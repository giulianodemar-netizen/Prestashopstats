{*
* Orders Statistics Tab - Italiano
*}

{if isset($stats.sales)}
<div class="row">
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-shopping-cart"></i> Totale Ordini
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.sales.total_orders|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-success">
            <div class="panel-heading">
                <i class="icon-money"></i> Fatturato Totale
            </div>
            <div class="panel-body text-center">
                <h2>{displayPrice price=$stats.sales.total_revenue}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="icon-bar-chart"></i> Valore Medio Ordine
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
    {if isset($stats.returns)}
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-danger">
            <div class="panel-heading">
                <i class="icon-undo"></i> Resi/Rimborsi
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.returns.total_returns|escape:'html':'UTF-8'}</h2>
                <small>{displayPrice price=$stats.returns.total_refunded}</small>
            </div>
        </div>
    </div>
    {/if}
</div>

{if isset($stats.sales.by_date) && count($stats.sales.by_date) > 0}
<div class="row">
    <div class="col-lg-12">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-line-chart"></i> Trend Vendite
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
                <i class="icon-trophy"></i> Top {$limit} Prodotti per Fatturato
            </div>
            <div class="panel-body">
                <div style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Prodotto</th>
                                <th class="text-right">Quantità</th>
                                <th class="text-right">Fatturato</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.sales.by_product item=product name=prodLoop}
                            <tr>
                                <td>{$smarty.foreach.prodLoop.iteration}</td>
                                <td>
                                    <a href="index.php?controller=AdminProducts&id_product={$product.id_product|escape:'html':'UTF-8'}&updateproduct&token={Tools::getAdminTokenLite('AdminProducts')}" target="_blank">
                                        {$product.name|escape:'html':'UTF-8'}
                                    </a>
                                </td>
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
                <i class="icon-star"></i> Top {$limit} Clienti per Fatturato
            </div>
            <div class="panel-body">
                <div style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Cliente</th>
                                <th class="text-right">Ordini</th>
                                <th class="text-right">Totale Speso</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.sales.by_customer item=customer name=custLoop}
                            <tr>
                                <td>{$smarty.foreach.custLoop.iteration}</td>
                                <td>
                                    <a href="index.php?controller=AdminCustomers&id_customer={$customer.id_customer|escape:'html':'UTF-8'}&viewcustomer&token={Tools::getAdminTokenLite('AdminCustomers')}" target="_blank">
                                        {$customer.customer_name|escape:'html':'UTF-8'}
                                    </a>
                                </td>
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

{* Payment Methods and Returns *}
<div class="row">
    {if isset($stats.payments.by_payment) && count($stats.payments.by_payment) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-credit-card"></i> Metodi di Pagamento (Ordini Validi)
            </div>
            <div class="panel-body">
                <canvas id="paymentMethodsChart" height="120"></canvas>
                <div style="margin-top: 20px;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Metodo</th>
                                <th class="text-right">Ordini</th>
                                <th class="text-right">Fatturato</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.payments.by_payment item=payment}
                            <tr>
                                <td><strong>{$payment.payment|escape:'html':'UTF-8'}</strong></td>
                                <td class="text-right">{$payment.order_count|escape:'html':'UTF-8'}</td>
                                <td class="text-right">{displayPrice price=$payment.total_revenue}</td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    {/if}
    
    {if isset($stats.returns.by_product) && count($stats.returns.by_product) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-undo"></i> Prodotti con Più Resi
            </div>
            <div class="panel-body">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th class="text-right">Ordini con Reso</th>
                            <th class="text-right">Quantità</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.returns.by_product item=product}
                        <tr>
                            <td>
                                <a href="index.php?controller=AdminProducts&id_product={$product.id_product|escape:'html':'UTF-8'}&updateproduct&token={Tools::getAdminTokenLite('AdminProducts')}" target="_blank">
                                    {$product.name|escape:'html':'UTF-8'}
                                </a>
                            </td>
                            <td class="text-right">{$product.return_count|escape:'html':'UTF-8'}</td>
                            <td class="text-right">{$product.quantity_returned|escape:'html':'UTF-8'}</td>
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
            label: 'Ordini',
            data: ordersCount,
            backgroundColor: 'rgba(54, 162, 235, 0.6)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1,
            yAxisID: 'y'
        }, {
            label: 'Fatturato',
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
                    text: 'Ordini'
                }
            },
            y1: {
                type: 'linear',
                display: true,
                position: 'right',
                title: {
                    display: true,
                    text: 'Fatturato'
                },
                grid: {
                    drawOnChartArea: false
                }
            }
        }
    }
});
{/if}

{if isset($stats.payments.by_payment) && count($stats.payments.by_payment) > 0}
// Payment Methods Chart
var paymentMethods = [];
var paymentCounts = [];
{foreach from=$stats.payments.by_payment item=payment}
    paymentMethods.push('{$payment.payment|escape:'javascript':'UTF-8'}');
    paymentCounts.push({$payment.order_count});
{/foreach}

var ctx2 = document.getElementById('paymentMethodsChart').getContext('2d');
new Chart(ctx2, {
    type: 'pie',
    data: {
        labels: paymentMethods,
        datasets: [{
            data: paymentCounts,
            backgroundColor: [
                'rgba(255, 99, 132, 0.8)',
                'rgba(54, 162, 235, 0.8)',
                'rgba(255, 206, 86, 0.8)',
                'rgba(75, 192, 192, 0.8)',
                'rgba(153, 102, 255, 0.8)',
                'rgba(255, 159, 64, 0.8)'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'bottom'
            }
        }
    }
});
{/if}
</script>
{/if}
