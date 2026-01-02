-- Sample Data for Testing PrestaShop Statistics Module
-- This file provides sample data insertion queries for testing the module
-- Replace ps_ with your actual database prefix if different

-- WARNING: Only use this on test/development environments!
-- DO NOT run this on production databases!

-- Sample Traffic Data (last 30 days)
INSERT INTO `ps_prestashopstats_traffic` 
(`source`, `medium`, `campaign`, `ip_address`, `country_code`, `date_add`) 
VALUES
('google', 'organic', NULL, '192.168.1.1', 'US', DATE_SUB(NOW(), INTERVAL 1 DAY)),
('google', 'organic', NULL, '192.168.1.2', 'GB', DATE_SUB(NOW(), INTERVAL 1 DAY)),
('facebook', 'social', 'summer_sale', '192.168.1.3', 'FR', DATE_SUB(NOW(), INTERVAL 2 DAYS)),
('direct', 'none', NULL, '192.168.1.4', 'DE', DATE_SUB(NOW(), INTERVAL 2 DAYS)),
('google', 'cpc', 'paid_campaign', '192.168.1.5', 'IT', DATE_SUB(NOW(), INTERVAL 3 DAYS));

-- Sample Page Views (example product views)
INSERT INTO `ps_prestashopstats_page_views` 
(`id_product`, `id_customer`, `ip_address`, `user_agent`, `referer`, `page_url`, `date_add`) 
VALUES
(1, NULL, '192.168.1.1', 'Mozilla/5.0', 'https://google.com', '/product/1', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, 1, '192.168.1.3', 'Mozilla/5.0', 'https://facebook.com', '/product/2', DATE_SUB(NOW(), INTERVAL 2 DAYS)),
(3, NULL, '192.168.1.4', 'Mozilla/5.0', NULL, '/product/3', DATE_SUB(NOW(), INTERVAL 2 DAYS));
