# Frequently Asked Questions (FAQ)

## General Questions

### What is PrestaShop Statistics Module?
PrestaShop Statistics is a comprehensive analytics module that provides detailed insights into your store's sales, customers, products, geolocation, and traffic. It's designed to help store owners make data-driven decisions.

### Is this module free?
Yes, this module is released under the MIT License and is completely free to use.

### Which PrestaShop versions are supported?
The module is compatible with:
- PrestaShop 1.7.8.0 and higher
- PrestaShop 8.x series
- PrestaShop 9.x series

### Does it work with multi-store setups?
Yes, the module works with multi-store configurations and will show data for the currently selected store context.

## Installation Questions

### How do I install the module?
See the [INSTALLATION.md](INSTALLATION.md) guide for detailed step-by-step instructions.

### The module won't install. What should I do?
Common solutions:
1. Check file permissions (755 for folders, 644 for files)
2. Ensure your database user has CREATE TABLE privileges
3. Check PHP error logs for specific errors
4. Try enabling PrestaShop debug mode for detailed error messages

### Do I need to configure anything after installation?
No, the module works out of the box with your existing PrestaShop data. However, you can optionally configure tracking settings in the module configuration page.

## Usage Questions

### Why am I not seeing any data?
Possible reasons:
1. The selected date range doesn't include any orders
2. You don't have valid orders in your database yet
3. The module was just installed and hasn't collected data yet

The module uses your existing PrestaShop order, customer, and product data, so if you have orders in your database, they will appear in the statistics.

### How do I change the date range?
At the top of the dashboard, use the "From" and "To" date selectors, then click the "Filter" button.

### Can I export the statistics?
Export functionality is planned for a future version. Currently, you can use your browser's print function to create PDFs.

### Why are traffic sources showing no data?
Traffic source tracking requires the custom tracking tables to be populated. This data is collected through:
1. The module's tracking hooks (enabled by default)
2. Custom tracking implementation (for advanced features)

If you just installed the module, traffic data will start accumulating as visitors browse your store.

### What's the difference between "visits" and "page views"?
- **Visits**: Unique visitor sessions to your store
- **Page Views**: Total number of pages viewed (one visit can have multiple page views)

## Technical Questions

### Does the module affect site performance?
The module is designed to be lightweight and efficient. It queries data only when you access the statistics dashboard, so it has no impact on your front-end store performance.

### What database tables does it create?
The module creates three tables:
- `ps_prestashopstats_page_views` - Tracks page and product views
- `ps_prestashopstats_traffic` - Stores traffic source information
- `ps_prestashopstats_conversions` - Records order conversions

### Can I customize the statistics displayed?
Yes, the module is designed to be extensible. Developers can:
- Add new statistics by extending the controller
- Customize templates in the views folder
- Add custom queries for specific analytics needs

### Is the data stored securely?
Yes, the module follows PrestaShop security best practices:
- SQL injection prevention with prepared statements
- XSS protection with proper output escaping
- No sensitive data exposure
- Index.php protection files in all directories

### Does it comply with GDPR?
The module collects IP addresses for traffic tracking. Ensure you:
1. Include this in your privacy policy
2. Obtain proper consent for tracking
3. Provide options to anonymize or delete data
4. Comply with your local data protection regulations

## Feature Questions

### Can I track custom events?
Currently, the module tracks standard events. Custom event tracking is planned for a future version, or you can extend the module to add your own tracking.

### Does it integrate with Google Analytics?
Direct Google Analytics integration is not currently available but is on the roadmap for future versions.

### Can I create custom reports?
The current version provides predefined reports. Custom report builder functionality is planned for future releases.

### Can I schedule email reports?
Email report scheduling is not available in v1.0 but is planned for a future version.

### Does it have real-time analytics?
The dashboard shows near real-time data (data is current as of page load). Auto-refresh functionality is planned for future versions.

## Troubleshooting

### I see a white screen after installation
This usually indicates a PHP error. Enable debug mode:
1. Edit `/config/defines.inc.php`
2. Set `define('_PS_MODE_DEV_', true);`
3. Refresh the page to see the error

### Statistics show incorrect numbers
Possible causes:
1. Date range filter not correctly applied
2. Database table corruption
3. Module needs to be reinstalled

Try:
1. Clear PrestaShop cache
2. Check the date range filter
3. Verify data directly in database

### Module menu not appearing
Solutions:
1. Clear PrestaShop cache (`var/cache/`)
2. Go to Advanced Parameters > Performance > Clear cache
3. Reinstall the module

### Database tables were not created
Manually create tables by:
1. Open `prestashopstats.php`
2. Find the `createTables()` method
3. Execute the SQL statements manually in your database

## Support Questions

### Where can I get help?
1. Check this FAQ
2. Read the [DOCUMENTATION.md](DOCUMENTATION.md)
3. Review the [INSTALLATION.md](INSTALLATION.md)
4. Open an issue on GitHub with details

### How do I report a bug?
1. Check if the bug is already reported in GitHub issues
2. Create a new issue with:
   - PrestaShop version
   - PHP version
   - Steps to reproduce
   - Expected vs actual behavior
   - Error messages or logs

### Can I request features?
Yes! Feature requests are welcome. Please open a GitHub issue with:
- Clear description of the feature
- Use case explanation
- Why it would be beneficial

### How can I contribute?
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Code contributions
- Documentation improvements
- Translation additions
- Bug reports

## Upgrade Questions

### How do I upgrade to a new version?
1. Backup your module files and database
2. Download the new version
3. Replace files in `/modules/prestashopstats/`
4. Go to Module Manager and click upgrade (if available)
5. Clear cache

### Will upgrading delete my data?
No, upgrading preserves your custom tracking data in the database tables.

### Can I downgrade to an older version?
While technically possible, it's not recommended. Always backup before making changes.

## Best Practices

### How often should I check statistics?
Recommended frequency:
- Daily: Quick overview
- Weekly: Trend analysis
- Monthly: Performance review
- Quarterly: Strategic planning

### What metrics should I focus on?
Key metrics to monitor:
1. Conversion rate
2. Average order value
3. Top-selling products
4. Customer acquisition rate
5. Traffic sources ROI

### How can I improve my store based on statistics?
1. Stock more of your top-selling products
2. Target marketing in high-converting countries
3. Optimize products with high views but low conversions
4. Focus on traffic sources with best conversion rates
5. Retain top customers with loyalty programs

---

**Still have questions?** Feel free to open an issue on GitHub!
