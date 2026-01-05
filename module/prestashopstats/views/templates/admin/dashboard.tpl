{*
* PrestaShop Statistics Dashboard Template
*
* @author    Giuliano De Mar
* @copyright Copyright (c) 2024
* @license   MIT License
*}

<div class="panel prestashopstats-dashboard">
    <div class="panel-heading">
        <i class="icon-bar-chart"></i> {l s='Statistics Dashboard' mod='prestashopstats'}
    </div>
    
    <div class="panel-body">
        {* Date Range Filter *}
        <div class="row">
            <div class="col-lg-12">
                <form method="get" class="form-inline pull-right">
                    <input type="hidden" name="controller" value="AdminPrestaShopStats" />
                    <input type="hidden" name="token" value="{$smarty.get.token}" />
                    <div class="form-group">
                        <label>{l s='From' mod='prestashopstats'}:</label>
                        <input type="date" name="date_from" value="{$date_from|escape:'html':'UTF-8'}" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label>{l s='To' mod='prestashopstats'}:</label>
                        <input type="date" name="date_to" value="{$date_to|escape:'html':'UTF-8'}" class="form-control" />
                    </div>
                    <button type="submit" class="btn btn-default">
                        <i class="icon-search"></i> {l s='Filter' mod='prestashopstats'}
                    </button>
                </form>
            </div>
        </div>
        
        <div class="clearfix"></div>
        <hr/>

        {* Sales Statistics *}
        <div class="row">
            <div class="col-lg-12">
                <h3><i class="icon-money"></i> {l s='Sales Statistics' mod='prestashopstats'}</h3>
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-info">
                    <h4>{l s='Total Orders' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.sales.total_orders|escape:'html':'UTF-8'}</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-success">
                    <h4>{l s='Total Revenue' mod='prestashopstats'}</h4>
                    <p class="stats-value">{displayPrice price=$stats.sales.total_revenue}</p>
                </div>
            </div>
        </div>

        {* Top Products by Sales *}
        <div class="row">
            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-shopping-cart"></i> {l s='Top 10 Products by Revenue' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Product' mod='prestashopstats'}</th>
                                    <th>{l s='Quantity' mod='prestashopstats'}</th>
                                    <th>{l s='Revenue' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.sales.by_product item=product}
                                    <tr>
                                        <td>{$product.name|escape:'html':'UTF-8'}</td>
                                        <td>{$product.quantity|escape:'html':'UTF-8'}</td>
                                        <td>{displayPrice price=$product.revenue}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="3" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            {* Top Customers *}
            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-user"></i> {l s='Top 10 Customers' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Customer' mod='prestashopstats'}</th>
                                    <th>{l s='Orders' mod='prestashopstats'}</th>
                                    <th>{l s='Total Spent' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.sales.by_customer item=customer}
                                    <tr>
                                        <td>{$customer.customer_name|escape:'html':'UTF-8'}</td>
                                        <td>{$customer.order_count|escape:'html':'UTF-8'}</td>
                                        <td>{displayPrice price=$customer.total_spent}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="3" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        {* Customer Insights *}
        <div class="row">
            <div class="col-lg-12">
                <h3><i class="icon-group"></i> {l s='Customer Insights' mod='prestashopstats'}</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-info">
                    <h4>{l s='Total Customers' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.customers.total_customers|escape:'html':'UTF-8'}</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-success">
                    <h4>{l s='New Customers' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.customers.new_customers|escape:'html':'UTF-8'}</p>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-globe"></i> {l s='Customers by Country' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Country' mod='prestashopstats'}</th>
                                    <th>{l s='Customers' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.customers.by_country item=country}
                                    <tr>
                                        <td>{$country.country_name|escape:'html':'UTF-8'}</td>
                                        <td>{$country.customer_count|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="2" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-bar-chart"></i> {l s='Purchase Frequency' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Frequency' mod='prestashopstats'}</th>
                                    <th>{l s='Customers' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.customers.purchase_frequency item=freq}
                                    <tr>
                                        <td>{$freq.frequency_group|escape:'html':'UTF-8'}</td>
                                        <td>{$freq.customer_count|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="2" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        {* Product Metrics *}
        <div class="row">
            <div class="col-lg-12">
                <h3><i class="icon-tags"></i> {l s='Product Metrics' mod='prestashopstats'}</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-shopping-cart"></i> {l s='Most Purchased Products' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Product' mod='prestashopstats'}</th>
                                    <th>{l s='Quantity' mod='prestashopstats'}</th>
                                    <th>{l s='Orders' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.products.most_purchased item=product}
                                    <tr>
                                        <td>{$product.name|escape:'html':'UTF-8'}</td>
                                        <td>{$product.total_quantity|escape:'html':'UTF-8'}</td>
                                        <td>{$product.order_count|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="3" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-eye"></i> {l s='Most Viewed Products' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Product' mod='prestashopstats'}</th>
                                    <th>{l s='Views' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.products.most_viewed item=product}
                                    <tr>
                                        <td>{$product.name|escape:'html':'UTF-8'}</td>
                                        <td>{$product.view_count|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="2" class="text-center">{l s='No data available for custom tracking. Install tracking code to see product views.' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-folder-open"></i> {l s='Sales by Category' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Category' mod='prestashopstats'}</th>
                                    <th>{l s='Products' mod='prestashopstats'}</th>
                                    <th>{l s='Total Sold' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.products.by_category item=category}
                                    <tr>
                                        <td>{$category.category_name|escape:'html':'UTF-8'}</td>
                                        <td>{$category.product_count|escape:'html':'UTF-8'}</td>
                                        <td>{$category.total_sold|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="3" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        {* Geolocation Data *}
        <div class="row">
            <div class="col-lg-12">
                <h3><i class="icon-map-marker"></i> {l s='Geolocation Data' mod='prestashopstats'}</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-globe"></i> {l s='Orders by Country' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Country' mod='prestashopstats'}</th>
                                    <th>{l s='Orders' mod='prestashopstats'}</th>
                                    <th>{l s='Revenue' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.geolocation.orders_by_country item=country}
                                    <tr>
                                        <td>{$country.country_name|escape:'html':'UTF-8'}</td>
                                        <td>{$country.order_count|escape:'html':'UTF-8'}</td>
                                        <td>{displayPrice price=$country.revenue}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="3" class="text-center">{l s='No data available' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-globe"></i> {l s='Traffic by Country' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Country Code' mod='prestashopstats'}</th>
                                    <th>{l s='Visits' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.geolocation.traffic_by_country item=country}
                                    <tr>
                                        <td>{$country.country_code|escape:'html':'UTF-8'}</td>
                                        <td>{$country.visit_count|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="2" class="text-center">{l s='No traffic data available. Install tracking code to see visitor countries.' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        {* Traffic Analytics *}
        <div class="row">
            <div class="col-lg-12">
                <h3><i class="icon-signal"></i> {l s='Traffic Analytics' mod='prestashopstats'}</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-info">
                    <h4>{l s='Total Visits' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.traffic.total_visits|escape:'html':'UTF-8'}</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-warning">
                    <h4>{l s='Page Views' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.traffic.total_page_views|escape:'html':'UTF-8'}</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-success">
                    <h4>{l s='Conversions' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.traffic.conversions|escape:'html':'UTF-8'}</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="alert alert-danger">
                    <h4>{l s='Conversion Rate' mod='prestashopstats'}</h4>
                    <p class="stats-value">{$stats.traffic.conversion_rate|escape:'html':'UTF-8'}%</p>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel">
                    <div class="panel-heading">
                        <i class="icon-link"></i> {l s='Traffic Sources' mod='prestashopstats'}
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Source' mod='prestashopstats'}</th>
                                    <th>{l s='Visits' mod='prestashopstats'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.traffic.sources item=source}
                                    <tr>
                                        <td>{$source.source|escape:'html':'UTF-8'}</td>
                                        <td>{$source.visit_count|escape:'html':'UTF-8'}</td>
                                    </tr>
                                {foreachelse}
                                    <tr>
                                        <td colspan="2" class="text-center">{l s='No traffic source data available. Install tracking code to see traffic sources.' mod='prestashopstats'}</td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
