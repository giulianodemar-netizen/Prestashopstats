{*
* Orders Statistics Tab
*}

{if isset($stats.sales)}
<div class="row">
    <div class="col-lg-4 col-md-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-shopping-cart"></i> {l s='Total Orders' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.sales.total_orders|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6">
        <div class="panel panel-success">
            <div class="panel-heading">
                <i class="icon-money"></i> {l s='Total Revenue' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{displayPrice price=$stats.sales.total_revenue}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="icon-bar-chart"></i> {l s='Average Order Value' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>
                    {if $stats.sales.total_orders > 0}
                        {displayPrice price=($stats.sales.total_revenue/$stats.sales.total_orders)}
                    {else}
                        {displayPrice price=0}
                    {/if}
                </h2>
            </div>
        </div>
    </div>
</div>

{if isset($stats.sales.by_date) && count($stats.sales.by_date) > 0}
<div class="row">
    <div class="col-lg-12">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-line-chart"></i> {l s='Sales Trend' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <canvas id="ordersTrendChart" height="80"></canvas>
            </div>
        </div>
    </div>
</div>
{/if}

<div class="row">
    {if isset($stats.sales.by_product) && count($stats.sales.by_product) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-trophy"></i> {l s='Top' mod='prestashopstats'} {$limit} {l s='Products by Revenue' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <div style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>{l s='Product' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Quantity' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Revenue' mod='prestashopstats'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.sales.by_product item=product name=prodLoop}
                            <tr>
                                <td>{$smarty.foreach.prodLoop.iteration}</td>
                                <td>{$product.name|escape:'html':'UTF-8'}</td>
                                <td class="text-right"><strong>{$product.quantity|escape:'html':'UTF-8'}</strong></td>
                                <td class="text-right"><strong>{displayPrice price=$product.revenue}</strong></td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    {/if}
    
    {if isset($stats.sales.by_customer) && count($stats.sales.by_customer) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-star"></i> {l s='Top' mod='prestashopstats'} {$limit} {l s='Customers by Revenue' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <div style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>{l s='Customer' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Orders' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Total Spent' mod='prestashopstats'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.sales.by_customer item=customer name=custLoop}
                            <tr>
                                <td>{$smarty.foreach.custLoop.iteration}</td>
                                <td>{$customer.customer_name|escape:'html':'UTF-8'}</td>
                                <td class="text-right"><strong>{$customer.order_count|escape:'html':'UTF-8'}</strong></td>
                                <td class="text-right"><strong>{displayPrice price=$customer.total_spent}</strong></td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    {/if}
</div>

<script>
{if isset($stats.sales.by_date) && count($stats.sales.by_date) > 0}
// Orders Trend Chart
var ordersDates = [];
var ordersCount = [];
var ordersRevenue = [];
{foreach from=$stats.sales.by_date item=day}
    ordersDates.push('{$day.order_date|escape:'javascript':'UTF-8'}');
    ordersCount.push({$day.orders});
    ordersRevenue.push({$day.revenue});
{/foreach}

var ctx = document.getElementById('ordersTrendChart').getContext('2d');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ordersDates,
        datasets: [{
            label: 'Orders',
            data: ordersCount,
            backgroundColor: 'rgba(54, 162, 235, 0.6)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1,
            yAxisID: 'y'
        }, {
            label: 'Revenue',
            data: ordersRevenue,
            type: 'line',
            borderColor: 'rgba(75, 192, 192, 1)',
            backgroundColor: 'rgba(75, 192, 192, 0.1)',
            tension: 0.1,
            yAxisID: 'y1'
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        interaction: {
            mode: 'index',
            intersect: false
        },
        scales: {
            y: {
                type: 'linear',
                display: true,
                position: 'left',
                title: {
                    display: true,
                    text: 'Orders'
                }
            },
            y1: {
                type: 'linear',
                display: true,
                position: 'right',
                title: {
                    display: true,
                    text: 'Revenue'
                },
                grid: {
                    drawOnChartArea: false
                }
            }
        }
    }
});
{/if}
</script>
{/if}
