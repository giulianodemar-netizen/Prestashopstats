<?php
/**
 * PrestaShop Statistics Module
 *
 * @author    Giuliano De Mar
 * @copyright Copyright (c) 2024
 * @license   MIT License
 * @version   1.0.0
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class PrestaShopStats extends Module
{
    public function __construct()
    {
        $this->name = 'prestashopstats';
        $this->tab = 'analytics_stats';
        $this->version = '1.0.0';
        $this->author = 'Giuliano De Mar';
        $this->need_instance = 0;
        $this->ps_versions_compliancy = [
            'min' => '1.7.8.0',
            'max' => '9.99.99'
        ];
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('PrestaShop Statistics');
        $this->description = $this->l('Comprehensive statistics module for sales, customers, products, geolocation, and traffic analytics.');
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall this module?');
    }

    /**
     * Module installation
     */
    public function install()
    {
        if (!parent::install() ||
            !$this->registerHook('displayBackOfficeHeader') ||
            !$this->registerHook('displayAdminStatsModules') ||
            !$this->registerHook('actionCustomerAccountAdd') ||
            !$this->registerHook('actionValidateOrder') ||
            !$this->registerHook('actionObjectProductUpdateAfter') ||
            !$this->installTab() ||
            !$this->createTables()) {
            return false;
        }

        return true;
    }

    /**
     * Module uninstallation
     */
    public function uninstall()
    {
        if (!parent::uninstall() ||
            !$this->uninstallTab() ||
            !$this->removeTables()) {
            return false;
        }

        return true;
    }

    /**
     * Install module tab in the admin menu
     */
    private function installTab()
    {
        $tab = new Tab();
        $tab->active = 1;
        $tab->class_name = 'AdminPrestaShopStats';
        $tab->name = [];
        foreach (Language::getLanguages(true) as $lang) {
            $tab->name[$lang['id_lang']] = 'Statistics Dashboard';
        }
        $tab->id_parent = (int)Tab::getIdFromClassName('AdminStats');
        $tab->module = $this->name;
        
        return $tab->add();
    }

    /**
     * Uninstall module tab
     */
    private function uninstallTab()
    {
        $id_tab = (int)Tab::getIdFromClassName('AdminPrestaShopStats');
        if ($id_tab) {
            $tab = new Tab($id_tab);
            return $tab->delete();
        }

        return true;
    }

    /**
     * Create necessary database tables
     */
    private function createTables()
    {
        $sql = [];

        // Table for tracking page views
        $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'prestashopstats_page_views` (
            `id_page_view` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `id_product` int(11) unsigned DEFAULT NULL,
            `id_customer` int(11) unsigned DEFAULT NULL,
            `ip_address` varchar(45) NOT NULL,
            `user_agent` text,
            `referer` text,
            `page_url` varchar(255) NOT NULL,
            `date_add` datetime NOT NULL,
            PRIMARY KEY (`id_page_view`),
            KEY `id_product` (`id_product`),
            KEY `id_customer` (`id_customer`),
            KEY `date_add` (`date_add`)
        ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';

        // Table for tracking traffic sources
        $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'prestashopstats_traffic` (
            `id_traffic` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `source` varchar(255) DEFAULT NULL,
            `medium` varchar(255) DEFAULT NULL,
            `campaign` varchar(255) DEFAULT NULL,
            `ip_address` varchar(45) NOT NULL,
            `country_code` varchar(2) DEFAULT NULL,
            `date_add` datetime NOT NULL,
            PRIMARY KEY (`id_traffic`),
            KEY `source` (`source`),
            KEY `date_add` (`date_add`),
            KEY `country_code` (`country_code`)
        ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';

        // Table for tracking conversion events
        $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'prestashopstats_conversions` (
            `id_conversion` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `id_order` int(11) unsigned NOT NULL,
            `id_traffic` int(11) unsigned DEFAULT NULL,
            `conversion_value` decimal(20,6) NOT NULL,
            `date_add` datetime NOT NULL,
            PRIMARY KEY (`id_conversion`),
            KEY `id_order` (`id_order`),
            KEY `id_traffic` (`id_traffic`),
            KEY `date_add` (`date_add`)
        ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';

        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }

        return true;
    }

    /**
     * Remove database tables
     */
    private function removeTables()
    {
        $sql = [
            'DROP TABLE IF EXISTS `'._DB_PREFIX_.'prestashopstats_page_views`',
            'DROP TABLE IF EXISTS `'._DB_PREFIX_.'prestashopstats_traffic`',
            'DROP TABLE IF EXISTS `'._DB_PREFIX_.'prestashopstats_conversions`',
        ];

        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }

        return true;
    }

    /**
     * Hook: Back office header
     */
    public function hookDisplayBackOfficeHeader()
    {
        if (Tools::getValue('controller') == 'AdminPrestaShopStats') {
            $this->context->controller->addCSS($this->_path.'views/css/admin.css');
            $this->context->controller->addJS($this->_path.'views/js/admin.js');
        }
    }

    /**
     * Hook: Admin stats modules
     */
    public function hookDisplayAdminStatsModules()
    {
        return $this->display(__FILE__, 'views/templates/admin/dashboard_widget.tpl');
    }

    /**
     * Hook: Customer account creation
     */
    public function hookActionCustomerAccountAdd($params)
    {
        // Track new customer registration
        $customer = $params['newCustomer'];
        // Additional tracking logic can be added here
    }

    /**
     * Hook: Order validation
     */
    public function hookActionValidateOrder($params)
    {
        // Track conversion
        $order = $params['order'];
        
        $sql = 'INSERT INTO `'._DB_PREFIX_.'prestashopstats_conversions` 
                (`id_order`, `conversion_value`, `date_add`) 
                VALUES ('.(int)$order->id.', '.(float)$order->total_paid.', NOW())';
        
        Db::getInstance()->execute($sql);
    }

    /**
     * Hook: Product update
     */
    public function hookActionObjectProductUpdateAfter($params)
    {
        // Track product updates if needed
    }

    /**
     * Module configuration page
     */
    public function getContent()
    {
        $output = '';

        if (Tools::isSubmit('submit'.$this->name)) {
            $output .= $this->displayConfirmation($this->l('Settings updated successfully.'));
        }

        return $output.$this->renderForm();
    }

    /**
     * Render configuration form
     */
    protected function renderForm()
    {
        $helper = new HelperForm();

        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);

        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submit'.$this->name;
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
            .'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $helper->tpl_vars = [
            'fields_value' => $this->getConfigFormValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
        ];

        return $helper->generateForm([$this->getConfigForm()]);
    }

    /**
     * Get configuration form structure
     */
    protected function getConfigForm()
    {
        return [
            'form' => [
                'legend' => [
                    'title' => $this->l('Settings'),
                    'icon' => 'icon-cogs',
                ],
                'input' => [
                    [
                        'type' => 'switch',
                        'label' => $this->l('Enable tracking'),
                        'name' => 'PRESTASHOPSTATS_TRACKING_ENABLED',
                        'is_bool' => true,
                        'desc' => $this->l('Enable visitor and traffic tracking'),
                        'values' => [
                            [
                                'id' => 'active_on',
                                'value' => true,
                                'label' => $this->l('Enabled')
                            ],
                            [
                                'id' => 'active_off',
                                'value' => false,
                                'label' => $this->l('Disabled')
                            ]
                        ],
                    ],
                ],
                'submit' => [
                    'title' => $this->l('Save'),
                ],
            ],
        ];
    }

    /**
     * Get configuration values
     */
    protected function getConfigFormValues()
    {
        return [
            'PRESTASHOPSTATS_TRACKING_ENABLED' => Configuration::get('PRESTASHOPSTATS_TRACKING_ENABLED', true),
        ];
    }
}
