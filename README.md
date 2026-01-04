# PrestaShop Statistics Module

[![PrestaShop](https://img.shields.io/badge/PrestaShop-1.7.8+-blue.svg)](https://www.prestashop.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-orange.svg)](CHANGELOG.md)

A comprehensive statistics module for PrestaShop that provides detailed analytics about sales, customers, products, geolocation, and traffic. Compatible with PrestaShop versions 1.7.8.11, 8.x, and 9.x.

## 🚀 Features

### Sales Statistics
- **Real-time Sales Tracking**: Monitor total orders and revenue
- **Product Performance**: Top 10 products by revenue with detailed metrics
- **Customer Analytics**: Identify your most valuable customers
- **Trend Analysis**: Track sales patterns over customizable date ranges

### Customer Insights
- **Customer Base Overview**: Total active customers and new acquisitions
- **Geographic Distribution**: See where your customers are located
- **Purchase Behavior**: Segment customers by order frequency
- **Customer Lifetime Value**: Track total spending per customer

### Product Metrics
- **Best Sellers**: Most purchased products with quantity and order counts
- **Product Views**: Track which products attract the most attention
- **Category Performance**: Analyze sales by product category
- **Inventory Intelligence**: Make data-driven stocking decisions

### Geolocation Data
- **Order Geography**: Visualize orders by country with revenue data
- **Traffic Sources**: Understand where your visitors come from
- **Market Insights**: Identify growth opportunities in different regions

### Traffic Analytics
- **Visit Tracking**: Monitor total visits and page views
- **Conversion Metrics**: Calculate conversion rates and optimize performance
- **Source Attribution**: Identify which channels drive the most traffic
- **Daily Trends**: Analyze traffic patterns over time

### Dashboard Integration
- **Comprehensive Dashboard**: All statistics in one centralized location
- **Date Range Filtering**: Focus on specific time periods
- **Responsive Design**: Works perfectly on desktop, tablet, and mobile
- **Real-time Updates**: See your latest data instantly

## 📋 Requirements

- **PrestaShop**: Version 1.7.8.0 or higher (compatible with 8.x and 9.x)
- **PHP**: Version 7.1 or higher
- **MySQL**: Version 5.6 or higher
- **Browser**: Modern browser with JavaScript enabled

## 📦 Installation

### Quick Install (Recommended)

**⚠️ IMPORTANT:** Use the build script to create a proper ZIP file for PrestaShop!

```bash
# Clone or download the repository
git clone https://github.com/giulianodemar-netizen/Prestashopstats.git
cd Prestashopstats

# Run the build script to create installation ZIP
./build.sh

# Upload the generated file: release/prestashopstats-v1.0.0.zip
```

Then:
1. Go to **Modules** > **Module Manager** in PrestaShop admin
2. Click **Upload a module**
3. Select `release/prestashopstats-v1.0.0.zip`
4. Click **Install**

**Note:** Do NOT upload the repository ZIP directly! It contains documentation files that prevent installation. Always use the build script or follow the detailed instructions in [INSTALLATION.md](INSTALLATION.md)

### Alternative: Direct FTP Upload

Upload only the core module files to `/modules/prestashopstats/`:
- prestashopstats.php
- config.xml  
- index.php
- LICENSE
- controllers/
- views/
- translations/

For detailed installation instructions, see [INSTALLATION.md](INSTALLATION.md)

## 📖 Documentation

- **[Installation Guide](INSTALLATION.md)** - Step-by-step installation instructions
- **[Documentation](DOCUMENTATION.md)** - Complete feature documentation and usage guide
- **[Changelog](CHANGELOG.md)** - Version history and updates

## 🎯 Quick Start

After installation:

1. Navigate to **Stats** > **Statistics Dashboard** in your admin panel
2. Select a date range using the filter at the top
3. Explore the different sections:
   - Sales Statistics
   - Customer Insights
   - Product Metrics
   - Geolocation Data
   - Traffic Analytics

## 📊 Module Structure

```
prestashopstats/
├── prestashopstats.php              # Main module class
├── config.xml                        # Module configuration
├── controllers/
│   └── admin/
│       └── AdminPrestaShopStatsController.php
├── views/
│   ├── templates/admin/
│   │   ├── dashboard.tpl            # Main dashboard
│   │   └── dashboard_widget.tpl     # Dashboard widget
│   ├── css/
│   │   └── admin.css                # Styling
│   └── js/
│       └── admin.js                 # JavaScript
├── translations/
│   └── en.php                        # Translations
├── DOCUMENTATION.md                  # Full documentation
├── INSTALLATION.md                   # Installation guide
└── README.md                         # This file
```

## 🌍 Multi-Language Support

The module includes built-in localization support. Translation files are located in the `translations/` folder. Currently supported:

- English (en)

To add more languages, copy `translations/en.php` and translate the strings.

## 🔧 Configuration

Access module settings via **Modules** > **Module Manager** > **Configure**:

- **Enable Tracking**: Toggle visitor and traffic tracking
- Additional settings can be added as needed

## 🎨 Screenshots

### Statistics Dashboard
The main dashboard provides a comprehensive overview of all statistics with easy-to-read charts and tables.

### Sales Analytics
Track your revenue, top products, and best customers all in one place.

### Customer Insights
Understand your customer base with geographic and behavioral analytics.

### Traffic Analytics
Monitor visits, conversions, and traffic sources to optimize your marketing.

## 🛠️ Technical Details

### Database Tables

The module creates three custom tables:

- `ps_prestashopstats_page_views` - Tracks page and product views
- `ps_prestashopstats_traffic` - Stores traffic source information
- `ps_prestashopstats_conversions` - Records order conversions

### Hooks Used

- `displayBackOfficeHeader` - Load admin CSS/JS
- `displayAdminStatsModules` - Display dashboard widget
- `actionCustomerAccountAdd` - Track new customers
- `actionValidateOrder` - Track conversions
- `actionObjectProductUpdateAfter` - Track product updates

## 🤝 Contributing

Contributions are welcome! If you'd like to contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

This module is released under the MIT License. See [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Giuliano De Mar**

- GitHub: [@giulianodemar-netizen](https://github.com/giulianodemar-netizen)

## 🐛 Bug Reports & Feature Requests

If you encounter any issues or have suggestions for improvements:

1. Check existing issues first
2. Create a new issue with detailed information
3. Include PrestaShop version, PHP version, and error messages

## 📈 Roadmap

Future enhancements:
- Visual charts and graphs (Chart.js integration)
- Export functionality (CSV, PDF)
- Email reports
- Advanced filtering
- Google Analytics integration
- Predictive analytics

## ⭐ Support

If you find this module useful, please:
- Star this repository
- Share it with other PrestaShop users
- Provide feedback for improvements

## 🔗 Links

- [PrestaShop Official Website](https://www.prestashop.com/)
- [PrestaShop Documentation](https://doc.prestashop.com/)
- [PrestaShop Addons](https://addons.prestashop.com/)

## 💡 Credits

Special thanks to the PrestaShop community and all contributors.

---

Made with ❤️ for the PrestaShop community
