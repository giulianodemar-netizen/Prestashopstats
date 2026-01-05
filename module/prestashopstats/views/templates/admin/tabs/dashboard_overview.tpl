{*
* Dashboard Overview Tab - Italiano
*}

<div class="row">
    {* Sales Overview *}
    {if isset($stats.sales)}
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
    {/if}
    
    {* Customer Overview *}
    {if isset($stats.customers)}
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="icon-group"></i> Totale Clienti
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.customers.total_customers|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <i class="icon-user"></i> Nuovi Clienti
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.customers.new_customers|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    {/if}
</div>

{* Returns/Refunds Overview *}
{if isset($stats.returns)}
<div class="row">
    <div class="col-lg-6 col-md-6">
        <div class="panel panel-danger">
            <div class="panel-heading">
                <i class="icon-undo"></i> Resi/Rimborsi
            </div>
            <div class="panel-body text-center">
                <h3>{$stats.returns.total_returns|escape:'html':'UTF-8'} ordini</h3>
                <p>Valore: {displayPrice price=$stats.returns.total_refunded}</p>
            </div>
        </div>
    </div>
    {if isset($stats.payments.by_payment) && count($stats.payments.by_payment) > 0}
    <div class="col-lg-6 col-md-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-credit-card"></i> Metodi di Pagamento
            </div>
            <div class="panel-body">
                <table class="table table-condensed">
                    <tbody>
                        {foreach from=$stats.payments.by_payment item=payment name=payLoop}
                        {if $smarty.foreach.payLoop.index < 5}
                        <tr>
                            <td><strong>{$payment.payment|escape:'html':'UTF-8'}</strong></td>
                            <td class="text-right">{$payment.order_count|escape:'html':'UTF-8'} ordini</td>
                        </tr>
                        {/if}
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {/if}
</div>
{/if}

{* Quick Stats Charts *}
<div class="row">
    {if isset($stats.sales.by_date) && count($stats.sales.by_date) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-bar-chart"></i> Trend Vendite
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
                <i class="icon-pie-chart"></i> Top Prodotti
            </div>
            <div class="panel-body">
                <canvas id="topProductsChart" height="100"></canvas>
            </div>
        </div>
    </div>
    {/if}
</div>

{* Top Lists *}
<div class="row">
    {if isset($stats.sales.by_product) && count($stats.sales.by_product) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-trophy"></i> Top Prodotti per Fatturato
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th class="text-right">Quantità</th>
                            <th class="text-right">Fatturato</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.sales.by_product item=product}
                        <tr>
                            <td>
                                <a href="index.php?controller=AdminProducts&id_product={$product.id_product|escape:'html':'UTF-8'}&updateproduct&token={Tools::getAdminTokenLite('AdminProducts')}" target="_blank">
                                    {$product.name|escape:'html':'UTF-8'}
                                </a>
                            </td>
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
                <i class="icon-star"></i> Top Clienti
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Cliente</th>
                            <th class="text-right">Ordini</th>
                            <th class="text-right">Totale Speso</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.sales.by_customer item=customer}
                        <tr>
                            <td>
                                <a href="index.php?controller=AdminCustomers&id_customer={$customer.id_customer|escape:'html':'UTF-8'}&viewcustomer&token={Tools::getAdminTokenLite('AdminCustomers')}" target="_blank">
                                    {$customer.customer_name|escape:'html':'UTF-8'}
                                </a>
                            </td>
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

{* Top Categories and Most Viewed Products *}
<div class="row">
    {if isset($stats.products.by_category) && count($stats.products.by_category) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-tags"></i> Top Categorie
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Categoria</th>
                            <th class="text-right">Prodotti</th>
                            <th class="text-right">Unità Vendute</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.products.by_category item=category}
                        <tr>
                            <td><strong>{$category.category_name|escape:'html':'UTF-8'}</strong></td>
                            <td class="text-right">{$category.product_count|escape:'html':'UTF-8'}</td>
                            <td class="text-right">{$category.total_sold|escape:'html':'UTF-8'}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    {/if}
    
    {if isset($stats.products.most_viewed) && count($stats.products.most_viewed) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-eye"></i> Prodotti Più Visti
            </div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th class="text-right">Visualizzazioni</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$stats.products.most_viewed item=product}
                        <tr>
                            <td>
                                <a href="index.php?controller=AdminProducts&id_product={$product.id_product|escape:'html':'UTF-8'}&updateproduct&token={Tools::getAdminTokenLite('AdminProducts')}" target="_blank">
                                    {$product.name|escape:'html':'UTF-8'}
                                </a>
                            </td>
                            <td class="text-right">{$product.view_count|escape:'html':'UTF-8'}</td>
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
            label: 'Fatturato',
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
