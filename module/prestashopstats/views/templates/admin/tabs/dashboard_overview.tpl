{*
* Dashboard Overview Tab
*}

<div class="row">
    {* Sales Overview *}
    {if isset($stats.sales)}
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-shopping-cart"></i> {l s='Total Orders' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.sales.total_orders|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-success">
            <div class="panel-heading">
                <i class="icon-money"></i> {l s='Total Revenue' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{displayPrice price=$stats.sales.total_revenue}</h2>
            </div>
        </div>
    </div>
    {/if}
    
    {* Customer Overview *}
    {if isset($stats.customers)}
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="icon-group"></i> {l s='Total Customers' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.customers.total_customers|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <i class="icon-user"></i> {l s='New Customers' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.customers.new_customers|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    {/if}
</div>

{* Quick Stats Charts *}
<div class="row">
    {if isset($stats.sales.by_date) && count($stats.sales.by_date) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-bar-chart"></i> {l s='Sales Trend' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <canvas id="salesTrendChart" height="100"></canvas>
            </div>
        </div>
    </div>
    {/if}
    
    {if isset($stats.sales.by_product) && count($stats.sales.by_product) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-pie-chart"></i> {l s='Top Products' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <canvas id="topProductsChart" height="100"></canvas>
            </div>
        </div>
    </div>
    {/if}
</div>

{* Top 10 Lists *}
<div class="row">
    {if isset($stats.sales.by_product) && count($stats.sales.by_product) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-trophy"></i> {l s='Top Products by Revenue' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>{l s='Product' mod='prestashopstats'}</th>
                            <th class="text-right">{l s='Quantity' mod='prestashopstats'}</th>
                            <th class="text-right">{l s='Revenue' mod='prestashopstats'}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.sales.by_product item=product}
                        <tr>
                            <td>{$product.name|escape:'html':'UTF-8'}</td>
                            <td class="text-right">{$product.quantity|escape:'html':'UTF-8'}</td>
                            <td class="text-right">{displayPrice price=$product.revenue}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {/if}
    
    {if isset($stats.sales.by_customer) && count($stats.sales.by_customer) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-star"></i> {l s='Top Customers' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>{l s='Customer' mod='prestashopstats'}</th>
                            <th class="text-right">{l s='Orders' mod='prestashopstats'}</th>
                            <th class="text-right">{l s='Total Spent' mod='prestashopstats'}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.sales.by_customer item=customer}
                        <tr>
                            <td>{$customer.customer_name|escape:'html':'UTF-8'}</td>
                            <td class="text-right">{$customer.order_count|escape:'html':'UTF-8'}</td>
                            <td class="text-right">{displayPrice price=$customer.total_spent}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {/if}
</div>

<script>
{if isset($stats.sales.by_date) && count($stats.sales.by_date) > 0}
// Sales Trend Chart
var salesDates = [];
var salesRevenue = [];
{foreach from=$stats.sales.by_date item=day}
    salesDates.push('{$day.order_date|escape:'javascript':'UTF-8'}');
    salesRevenue.push({$day.revenue});
{/foreach}

var ctx1 = document.getElementById('salesTrendChart').getContext('2d');
new Chart(ctx1, {
    type: 'line',
    data: {
        labels: salesDates,
        datasets: [{
            label: 'Revenue',
            data: salesRevenue,
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgba(75, 192, 192, 0.1)',
            tension: 0.1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                display: true
            }
        }
    }
});
{/if}

{if isset($stats.sales.by_product) && count($stats.sales.by_product) > 0}
// Top Products Chart
var productNames = [];
var productRevenue = [];
{foreach from=$stats.sales.by_product item=product name=productLoop}
    {if $smarty.foreach.productLoop.index < 5}
    productNames.push('{$product.name|escape:'javascript':'UTF-8'}');
    productRevenue.push({$product.revenue});
    {/if}
{/foreach}

var ctx2 = document.getElementById('topProductsChart').getContext('2d');
new Chart(ctx2, {
    type: 'doughnut',
    data: {
        labels: productNames,
        datasets: [{
            data: productRevenue,
            backgroundColor: [
                'rgba(255, 99, 132, 0.8)',
                'rgba(54, 162, 235, 0.8)',
                'rgba(255, 206, 86, 0.8)',
                'rgba(75, 192, 192, 0.8)',
                'rgba(153, 102, 255, 0.8)'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'right'
            }
        }
    }
});
{/if}
</script>
