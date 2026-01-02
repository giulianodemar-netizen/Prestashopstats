# PrestaShop Statistics Module

A comprehensive statistics module for PrestaShop 1.7.8.11+ (compatible with versions 8 and 9) that provides detailed analytics about sales, customers, products, geolocation, and traffic.

## Features

### 1. Sales Statistics
- **Total Orders and Revenue**: Track your store's total orders and revenue within a customizable date range
- **Sales by Product**: View top 10 products by revenue with quantity and total revenue
- **Sales by Customer**: Identify your top 10 customers with order count and total spent
- **Sales by Date**: Analyze daily sales trends over time

### 2. Customer Insights
- **Total Active Customers**: Monitor your total customer base
- **New Customers**: Track customer acquisition within the selected period
- **Customers by Country**: Geographic distribution of your customer base
- **Purchase Frequency**: Customer segmentation by order frequency (1 order, 2-5 orders, 6-10 orders, 10+ orders)

### 3. Product Metrics
- **Most Purchased Products**: Top 10 products by quantity sold and number of orders
- **Most Viewed Products**: Track product page views (requires tracking implementation)
- **Sales by Category**: Analyze which product categories perform best

### 4. Geolocation Data
- **Orders by Country**: See which countries generate the most orders and revenue
- **Traffic by Country**: Geographic distribution of your website visitors (requires tracking implementation)

### 5. Traffic Analytics
- **Total Visits**: Count of unique visits to your store
- **Page Views**: Total number of pages viewed
- **Conversions**: Number of completed orders
- **Conversion Rate**: Percentage of visits that result in a purchase
- **Traffic Sources**: Identify where your visitors come from (requires tracking implementation)
- **Visits by Date**: Daily traffic trends

### 6. Dashboard Integration
- Quick access widget in the admin stats section
- Comprehensive statistics dashboard with filterable date ranges
- Responsive design compatible with PrestaShop's default theme

## Installation

### Method 1: Manual Installation

1. Download the module files
2. Create a folder named `prestashopstats` in your PrestaShop's `modules` directory
3. Upload all module files to `/modules/prestashopstats/`
4. Go to your PrestaShop admin panel
5. Navigate to **Modules** > **Module Manager**
6. Search for "PrestaShop Statistics"
7. Click **Install**
8. Configure the module settings if needed

### Method 2: ZIP Installation

1. Create a ZIP archive of the `prestashopstats` folder
2. Go to your PrestaShop admin panel
3. Navigate to **Modules** > **Module Manager**
4. Click **Upload a module**
5. Select the ZIP file and upload
6. Click **Install**

## File Structure

```
prestashopstats/
├── prestashopstats.php              # Main module class
├── config.xml                        # Module metadata
├── index.php                         # Security file
├── logo.txt                          # Logo placeholder info
├── controllers/
│   ├── admin/
│   │   ├── AdminPrestaShopStatsController.php  # Admin controller
│   │   └── index.php
│   └── index.php
├── views/
│   ├── templates/
│   │   ├── admin/
│   │   │   ├── dashboard.tpl        # Main dashboard template
│   │   │   ├── dashboard_widget.tpl # Widget template
│   │   │   └── index.php
│   │   └── index.php
│   ├── css/
│   │   ├── admin.css                # Admin styles
│   │   └── index.php
│   ├── js/
│   │   ├── admin.js                 # Admin JavaScript
│   │   └── index.php
│   └── index.php
└── translations/
    ├── en.php                        # English translations
    └── index.php
```

## Usage

### Accessing the Statistics Dashboard

1. Log in to your PrestaShop admin panel
2. Navigate to **Stats** > **Statistics Dashboard**
3. Use the date range filter to select your desired time period
4. Click **Filter** to update the statistics

### Understanding the Data

#### Sales Statistics
The sales section provides insights into your revenue and order performance:
- Monitor total orders and revenue
- Identify best-selling products
- Recognize valuable customers
- Track sales trends over time

#### Customer Insights
Understand your customer base better:
- Total active customers in your database
- New customer acquisition rate
- Geographic distribution
- Customer loyalty based on purchase frequency

#### Product Metrics
Optimize your product strategy:
- Identify top-performing products
- Monitor product view counts (with tracking enabled)
- Analyze category performance

#### Geolocation Data
Understand where your customers and visitors come from:
- Order distribution by country
- Visitor geographic data

#### Traffic Analytics
Monitor your store's traffic and conversion performance:
- Total visits and page views
- Conversion metrics
- Traffic source analysis
- Daily traffic patterns

### Date Range Filtering

The dashboard includes a date range filter allowing you to:
- View statistics for any custom date range
- Compare performance across different time periods
- Focus on specific campaigns or seasons

## Configuration

Access module configuration:
1. Go to **Modules** > **Module Manager**
2. Search for "PrestaShop Statistics"
3. Click **Configure**

Available settings:
- **Enable Tracking**: Toggle visitor and traffic tracking on/off

## Database Tables

The module creates three custom tables:

### prestashopstats_page_views
Tracks page views for products and pages:
- `id_page_view`: Unique identifier
- `id_product`: Product ID (if applicable)
- `id_customer`: Customer ID (if logged in)
- `ip_address`: Visitor IP address
- `user_agent`: Browser user agent
- `referer`: HTTP referer
- `page_url`: Visited page URL
- `date_add`: Timestamp

### prestashopstats_traffic
Tracks traffic sources and origins:
- `id_traffic`: Unique identifier
- `source`: Traffic source (e.g., Google, Facebook)
- `medium`: Traffic medium (e.g., organic, cpc)
- `campaign`: Campaign name
- `ip_address`: Visitor IP address
- `country_code`: ISO country code
- `date_add`: Timestamp

### prestashopstats_conversions
Tracks order conversions:
- `id_conversion`: Unique identifier
- `id_order`: Order ID
- `id_traffic`: Related traffic ID
- `conversion_value`: Order value
- `date_add`: Timestamp

## Compatibility

- **PrestaShop 1.7.8.0+**: Full support
- **PrestaShop 8.x**: Compatible
- **PrestaShop 9.x**: Compatible

### PHP Requirements
- PHP 7.1 or higher
- MySQL 5.6 or higher

### Browser Compatibility
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Opera (latest)

## Localization

The module includes built-in support for multiple languages. Translation files are located in the `translations` folder.

### Adding New Languages

1. Copy `translations/en.php`
2. Rename it to your language code (e.g., `fr.php` for French)
3. Translate the strings in the new file
4. The module will automatically detect and use the translations

## Advanced Features

### Custom Tracking Implementation

To enable advanced tracking features (product views, traffic sources), you can implement custom tracking code. Here's an example:

```php
// In your theme's header or footer template
{if Module::isInstalled('prestashopstats') && Module::isEnabled('prestashopstats')}
<script>
// Track page views
(function() {
    // Your tracking implementation here
})();
</script>
{/if}
```

### Extending the Module

The module is designed to be extensible. You can:

1. **Add Custom Statistics**: Extend the controller to add new statistics
2. **Create Custom Reports**: Add new template sections for specific reports
3. **Integrate External Analytics**: Connect to Google Analytics or other services
4. **Add Visualizations**: Integrate chart libraries like Chart.js or D3.js

## Troubleshooting

### Module Won't Install
- Ensure you have the correct file permissions (755 for folders, 644 for files)
- Check PHP error logs for specific error messages
- Verify database credentials and permissions

### No Data Showing
- Check if the date range includes data
- Verify that orders exist in the database
- Ensure the tables were created successfully during installation

### Performance Issues
- For large datasets, consider implementing pagination
- Add database indexes for frequently queried fields
- Cache statistics data for better performance

## Support

For issues, questions, or contributions, please contact:
- **Author**: Giuliano De Mar
- **Email**: support@example.com (replace with actual email)
- **Repository**: https://github.com/giulianodemar-netizen/Prestashopstats

## License

MIT License

Copyright (c) 2024 Giuliano De Mar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Changelog

### Version 1.0.0 (2024)
- Initial release
- Sales statistics by product, customer, and date
- Customer insights and analytics
- Product metrics and performance tracking
- Geolocation data for orders and traffic
- Traffic analytics with conversion tracking
- Responsive dashboard with date range filtering
- Multi-language support
- Compatible with PrestaShop 1.7.8.11, 8.x, and 9.x

## Roadmap

Future enhancements planned:
- [ ] Chart visualizations for all statistics
- [ ] Export functionality (CSV, PDF)
- [ ] Email reports scheduling
- [ ] Advanced filtering and segmentation
- [ ] Real-time analytics dashboard
- [ ] Integration with Google Analytics
- [ ] Custom KPI widgets
- [ ] A/B testing support
- [ ] Predictive analytics using machine learning
- [ ] Mobile app for statistics viewing

## Credits

Developed by Giuliano De Mar for the PrestaShop community.

Special thanks to the PrestaShop team for creating an excellent e-commerce platform.
