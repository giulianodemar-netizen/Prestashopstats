<?php
/**
 * Admin Controller for PrestaShop Statistics Module
 *
 * @author    Giuliano De Mar
 * @copyright Copyright (c) 2024
 * @license   MIT License
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class AdminPrestaShopStatsController extends ModuleAdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->bootstrap = true;
        $this->context = Context::getContext();
    }

    /**
     * Initialize content
     */
    public function initContent()
    {
        parent::initContent();

        // Get date range from request or set defaults
        $date_from = Tools::getValue('date_from', date('Y-m-d', strtotime('-30 days')));
        $date_to = Tools::getValue('date_to', date('Y-m-d'));
        
        // Get active tab (default: dashboard)
        $active_tab = Tools::getValue('tab', 'dashboard');
        
        // Get limit for top N lists (default: 10)
        $limit = (int)Tools::getValue('limit', 10);
        if (!in_array($limit, [10, 25, 50, 100])) {
            $limit = 10;
        }

        // Gather statistics based on active tab
        $stats = [];
        
        switch ($active_tab) {
            case 'customers':
                $stats['customers'] = $this->getCustomerInsights($date_from, $date_to, $limit);
                break;
            case 'orders':
                $stats['sales'] = $this->getSalesStatistics($date_from, $date_to, $limit);
                break;
            case 'visits':
                $stats['traffic'] = $this->getTrafficAnalytics($date_from, $date_to, $limit);
                $stats['products'] = $this->getProductMetrics($date_from, $date_to, $limit);
                break;
            case 'dashboard':
            default:
                $stats['sales'] = $this->getSalesStatistics($date_from, $date_to, 10);
                $stats['customers'] = $this->getCustomerInsights($date_from, $date_to, 10);
                $stats['products'] = $this->getProductMetrics($date_from, $date_to, 10);
                $stats['geolocation'] = $this->getGeolocationData($date_from, $date_to, 10);
                $stats['traffic'] = $this->getTrafficAnalytics($date_from, $date_to, 10);
                break;
        }

        $this->context->smarty->assign([
            'stats' => $stats,
            'date_from' => $date_from,
            'date_to' => $date_to,
            'active_tab' => $active_tab,
            'limit' => $limit,
            'module_dir' => $this->module->getPathUri(),
            'controller_url' => $this->context->link->getAdminLink('AdminPrestaShopStats'),
        ]);

        $this->setTemplate('dashboard.tpl');
    }

    /**
     * Get sales statistics
     */
    private function getSalesStatistics($date_from, $date_to, $limit = 10)
    {
        $sales = [];

        // Total sales
        $sql = 'SELECT COUNT(DISTINCT o.id_order) as total_orders,
                       SUM(o.total_paid) as total_revenue
                FROM '._DB_PREFIX_.'orders o
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1';
        $result = Db::getInstance()->getRow($sql);
        $sales['total_orders'] = (int)$result['total_orders'];
        $sales['total_revenue'] = (float)$result['total_revenue'];

        // Sales by product
        $sql = 'SELECT p.id_product, pl.name, 
                       SUM(od.product_quantity) as quantity,
                       SUM(od.total_price_tax_incl) as revenue
                FROM '._DB_PREFIX_.'order_detail od
                INNER JOIN '._DB_PREFIX_.'orders o ON od.id_order = o.id_order
                INNER JOIN '._DB_PREFIX_.'product p ON od.product_id = p.id_product
                INNER JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product AND pl.id_lang = '.(int)$this->context->language->id.')
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1
                GROUP BY p.id_product
                ORDER BY revenue DESC
                LIMIT '.(int)$limit;
        $sales['by_product'] = Db::getInstance()->executeS($sql);

        // Sales by customer
        $sql = 'SELECT c.id_customer, 
                       CONCAT(c.firstname, " ", c.lastname) as customer_name,
                       COUNT(DISTINCT o.id_order) as order_count,
                       SUM(o.total_paid) as total_spent
                FROM '._DB_PREFIX_.'orders o
                INNER JOIN '._DB_PREFIX_.'customer c ON o.id_customer = c.id_customer
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1
                GROUP BY c.id_customer
                ORDER BY total_spent DESC
                LIMIT '.(int)$limit;
        $sales['by_customer'] = Db::getInstance()->executeS($sql);

        // Sales by date
        $sql = 'SELECT DATE(o.date_add) as order_date,
                       COUNT(DISTINCT o.id_order) as orders,
                       SUM(o.total_paid) as revenue
                FROM '._DB_PREFIX_.'orders o
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1
                GROUP BY DATE(o.date_add)
                ORDER BY order_date ASC';
        $sales['by_date'] = Db::getInstance()->executeS($sql);

        return $sales;
    }

    /**
     * Get customer insights
     */
    private function getCustomerInsights($date_from, $date_to, $limit = 10)
    {
        $insights = [];

        // Total customers
        $sql = 'SELECT COUNT(*) as total FROM '._DB_PREFIX_.'customer WHERE active = 1';
        $insights['total_customers'] = (int)Db::getInstance()->getValue($sql);

        // New customers in period
        $sql = 'SELECT COUNT(*) as total FROM '._DB_PREFIX_.'customer 
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"';
        $insights['new_customers'] = (int)Db::getInstance()->getValue($sql);

        // Customers by country
        $sql = 'SELECT cl.name as country_name, COUNT(DISTINCT c.id_customer) as customer_count
                FROM '._DB_PREFIX_.'customer c
                INNER JOIN '._DB_PREFIX_.'address a ON c.id_customer = a.id_customer
                INNER JOIN '._DB_PREFIX_.'country_lang cl ON (a.id_country = cl.id_country AND cl.id_lang = '.(int)$this->context->language->id.')
                WHERE c.active = 1
                GROUP BY cl.name
                ORDER BY customer_count DESC
                LIMIT '.(int)$limit;
        $insights['by_country'] = Db::getInstance()->executeS($sql);

        // Customer purchase frequency
        $sql = 'SELECT 
                    CASE 
                        WHEN order_count = 1 THEN "1 order"
                        WHEN order_count BETWEEN 2 AND 5 THEN "2-5 orders"
                        WHEN order_count BETWEEN 6 AND 10 THEN "6-10 orders"
                        ELSE "10+ orders"
                    END as frequency_group,
                    COUNT(*) as customer_count
                FROM (
                    SELECT c.id_customer, COUNT(DISTINCT o.id_order) as order_count
                    FROM '._DB_PREFIX_.'customer c
                    LEFT JOIN '._DB_PREFIX_.'orders o ON c.id_customer = o.id_customer AND o.valid = 1
                    WHERE c.active = 1
                    GROUP BY c.id_customer
                ) as customer_orders
                GROUP BY frequency_group';
        $insights['purchase_frequency'] = Db::getInstance()->executeS($sql);

        return $insights;
    }

    /**
     * Get product metrics
     */
    private function getProductMetrics($date_from, $date_to, $limit = 10)
    {
        $metrics = [];

        // Most purchased products
        $sql = 'SELECT p.id_product, pl.name, 
                       SUM(od.product_quantity) as total_quantity,
                       COUNT(DISTINCT od.id_order) as order_count
                FROM '._DB_PREFIX_.'order_detail od
                INNER JOIN '._DB_PREFIX_.'orders o ON od.id_order = o.id_order
                INNER JOIN '._DB_PREFIX_.'product p ON od.product_id = p.id_product
                INNER JOIN '._DB_PREFIX_.'product_lang pl ON (p.id_product = pl.id_product AND pl.id_lang = '.(int)$this->context->language->id.')
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1
                GROUP BY p.id_product
                ORDER BY total_quantity DESC
                LIMIT '.(int)$limit;
        $metrics['most_purchased'] = Db::getInstance()->executeS($sql);

        // Product views from page_views table
        $sql = 'SELECT pv.id_product, pl.name, COUNT(*) as view_count
                FROM '._DB_PREFIX_.'prestashopstats_page_views pv
                INNER JOIN '._DB_PREFIX_.'product_lang pl ON (pv.id_product = pl.id_product AND pl.id_lang = '.(int)$this->context->language->id.')
                WHERE pv.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND pv.id_product IS NOT NULL
                GROUP BY pv.id_product
                ORDER BY view_count DESC
                LIMIT '.(int)$limit;
        $metrics['most_viewed'] = Db::getInstance()->executeS($sql);

        // If no custom views data, fall back to connections data
        if (empty($metrics['most_viewed'])) {
            $metrics['most_viewed'] = [];
        }

        // Product categories performance
        $sql = 'SELECT cl.name as category_name, 
                       COUNT(DISTINCT p.id_product) as product_count,
                       SUM(od.product_quantity) as total_sold
                FROM '._DB_PREFIX_.'order_detail od
                INNER JOIN '._DB_PREFIX_.'orders o ON od.id_order = o.id_order
                INNER JOIN '._DB_PREFIX_.'product p ON od.product_id = p.id_product
                INNER JOIN '._DB_PREFIX_.'category_product cp ON p.id_product = cp.id_product
                INNER JOIN '._DB_PREFIX_.'category_lang cl ON (cp.id_category = cl.id_category AND cl.id_lang = '.(int)$this->context->language->id.')
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1
                GROUP BY cl.name
                ORDER BY total_sold DESC
                LIMIT '.(int)$limit;
        $metrics['by_category'] = Db::getInstance()->executeS($sql);

        return $metrics;
    }

    /**
     * Get geolocation data
     */
    private function getGeolocationData($date_from, $date_to, $limit = 10)
    {
        $data = [];

        // Orders by country
        $sql = 'SELECT cl.name as country_name, 
                       COUNT(DISTINCT o.id_order) as order_count,
                       SUM(o.total_paid) as revenue
                FROM '._DB_PREFIX_.'orders o
                INNER JOIN '._DB_PREFIX_.'address a ON o.id_address_delivery = a.id_address
                INNER JOIN '._DB_PREFIX_.'country_lang cl ON (a.id_country = cl.id_country AND cl.id_lang = '.(int)$this->context->language->id.')
                WHERE o.date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND o.valid = 1
                GROUP BY cl.name
                ORDER BY order_count DESC
                LIMIT '.(int)$limit;
        $data['orders_by_country'] = Db::getInstance()->executeS($sql);

        // Traffic by country from custom table
        $sql = 'SELECT country_code, COUNT(*) as visit_count
                FROM '._DB_PREFIX_.'prestashopstats_traffic
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND country_code IS NOT NULL
                GROUP BY country_code
                ORDER BY visit_count DESC
                LIMIT '.(int)$limit;
        $data['traffic_by_country'] = Db::getInstance()->executeS($sql);

        return $data;
    }

    /**
     * Get traffic analytics
     */
    private function getTrafficAnalytics($date_from, $date_to, $limit = 10)
    {
        $analytics = [];

        // Traffic sources
        $sql = 'SELECT source, COUNT(*) as visit_count
                FROM '._DB_PREFIX_.'prestashopstats_traffic
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                AND source IS NOT NULL
                GROUP BY source
                ORDER BY visit_count DESC
                LIMIT '.(int)$limit;
        $analytics['sources'] = Db::getInstance()->executeS($sql);

        // Total visits
        $sql = 'SELECT COUNT(*) as total_visits
                FROM '._DB_PREFIX_.'prestashopstats_traffic
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"';
        $analytics['total_visits'] = (int)Db::getInstance()->getValue($sql);

        // Page views
        $sql = 'SELECT COUNT(*) as total_views
                FROM '._DB_PREFIX_.'prestashopstats_page_views
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"';
        $analytics['total_page_views'] = (int)Db::getInstance()->getValue($sql);

        // Conversion rate
        $sql = 'SELECT COUNT(DISTINCT id_order) as conversions
                FROM '._DB_PREFIX_.'prestashopstats_conversions
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"';
        $conversions = (int)Db::getInstance()->getValue($sql);
        
        $analytics['conversions'] = $conversions;
        $analytics['conversion_rate'] = $analytics['total_visits'] > 0 
            ? round(($conversions / $analytics['total_visits']) * 100, 2) 
            : 0;

        // Visits by date
        $sql = 'SELECT DATE(date_add) as visit_date, COUNT(*) as visit_count
                FROM '._DB_PREFIX_.'prestashopstats_traffic
                WHERE date_add BETWEEN "'.pSQL($date_from).' 00:00:00" 
                AND "'.pSQL($date_to).' 23:59:59"
                GROUP BY DATE(date_add)
                ORDER BY visit_date ASC';
        $analytics['by_date'] = Db::getInstance()->executeS($sql);

        return $analytics;
    }
}
