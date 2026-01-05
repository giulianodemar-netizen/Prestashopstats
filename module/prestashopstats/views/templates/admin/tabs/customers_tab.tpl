{*
* Customers Statistics Tab - Enhanced Italian Version
* Modern, elegant, and clean design
*}

{if isset($stats.customers)}
<div class="customer-stats-container">
    
    {* Overview Cards Row *}
    <div class="row">
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-stat panel-primary">
                <div class="panel-body text-center">
                    <i class="icon-group stat-icon"></i>
                    <h3 class="stat-number">{$stats.customers.total_customers|escape:'html':'UTF-8'}</h3>
                    <p class="stat-label">Totale Clienti Attivi</p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-stat panel-success">
                <div class="panel-body text-center">
                    <i class="icon-user stat-icon"></i>
                    <h3 class="stat-number">{$stats.customers.new_customers|escape:'html':'UTF-8'}</h3>
                    <p class="stat-label">Nuovi Clienti</p>
                    {if $stats.customers.total_customers > 0}
                        <small class="stat-badge">
                            {($stats.customers.new_customers / $stats.customers.total_customers * 100)|string_format:"%.1f"}%
                        </small>
                    {/if}
                </div>
            </div>
        </div>
        
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-stat panel-info">
                <div class="panel-body text-center">
                    <i class="icon-shopping-cart stat-icon"></i>
                    <h3 class="stat-number">{$stats.customers.customers_with_orders|escape:'html':'UTF-8'}</h3>
                    <p class="stat-label">Clienti con Ordini</p>
                    {if $stats.customers.total_customers > 0}
                        <small class="stat-badge">
                            {($stats.customers.customers_with_orders / $stats.customers.total_customers * 100)|string_format:"%.1f"}%
                        </small>
                    {/if}
                </div>
            </div>
        </div>
        
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-stat panel-warning">
                <div class="panel-body text-center">
                    <i class="icon-map-marker stat-icon"></i>
                    <h3 class="stat-number">{$stats.customers.customers_with_address|escape:'html':'UTF-8'}</h3>
                    <p class="stat-label">Clienti con Indirizzo</p>
                    {if $stats.customers.total_customers > 0}
                        <small class="stat-badge">
                            {($stats.customers.customers_with_address / $stats.customers.total_customers * 100)|string_format:"%.1f"}%
                        </small>
                    {/if}
                </div>
            </div>
        </div>
    </div>

    {* Additional Metrics Row *}
    <div class="row">
        <div class="col-lg-4 col-md-6">
            <div class="panel panel-stat panel-default">
                <div class="panel-body text-center">
                    <i class="icon-user-times stat-icon-small"></i>
                    <h4 class="stat-number-small">{$stats.customers.customers_without_orders|escape:'html':'UTF-8'}</h4>
                    <p class="stat-label-small">Clienti Senza Ordini</p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4 col-md-6">
            <div class="panel panel-stat panel-default">
                <div class="panel-body text-center">
                    <i class="icon-envelope stat-icon-small"></i>
                    <h4 class="stat-number-small">{$stats.customers.customers_without_address|escape:'html':'UTF-8'}</h4>
                    <p class="stat-label-small">Clienti Senza Indirizzo</p>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4 col-md-6">
            <div class="panel panel-stat panel-default">
                <div class="panel-body text-center">
                    <i class="icon-shopping-cart stat-icon-small"></i>
                    <h4 class="stat-number-small">{$stats.customers.customers_with_cart|escape:'html':'UTF-8'}</h4>
                    <p class="stat-label-small">Clienti con Carrello</p>
                </div>
            </div>
        </div>
    </div>

    {* Charts and Tables Row *}
    <div class="row">
        {* Top Customers *}
        {if isset($stats.customers.top_customers) && count($stats.customers.top_customers) > 0}
        <div class="col-lg-6">
            <div class="panel panel-modern">
                <div class="panel-heading">
                    <i class="icon-trophy"></i> Top {$limit} Clienti per Numero di Ordini
                </div>
                <div class="panel-body">
                    <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Cliente</th>
                                    <th>Email</th>
                                    <th class="text-center">N° Ordini</th>
                                    <th class="text-right">Totale Speso</th>
                                    <th class="text-center">Azioni</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.customers.top_customers item=customer name=customerLoop}
                                <tr>
                                    <td><strong>{$smarty.foreach.customerLoop.iteration}</strong></td>
                                    <td>
                                        <a href="{$smarty.const._PS_BASE_URL}{$smarty.const.__PS_BASE_URI__}admin-dev/index.php?controller=AdminCustomers&id_customer={$customer.id_customer|escape:'html':'UTF-8'}&updatecustomer&token={Tools::getAdminTokenLite('AdminCustomers')}" 
                                           target="_blank" class="customer-link">
                                            {$customer.firstname|escape:'html':'UTF-8'} {$customer.lastname|escape:'html':'UTF-8'}
                                        </a>
                                    </td>
                                    <td><small>{$customer.email|escape:'html':'UTF-8'}</small></td>
                                    <td class="text-center">
                                        <span class="badge badge-info">{$customer.order_count|escape:'html':'UTF-8'}</span>
                                    </td>
                                    <td class="text-right">
                                        <strong>€{$customer.total_spent|string_format:"%.2f"}</strong>
                                    </td>
                                    <td class="text-center">
                                        <a href="{$smarty.const._PS_BASE_URL}{$smarty.const.__PS_BASE_URI__}admin-dev/index.php?controller=AdminCustomers&id_customer={$customer.id_customer|escape:'html':'UTF-8'}&viewcustomer&token={Tools::getAdminTokenLite('AdminCustomers')}" 
                                           target="_blank" class="btn btn-xs btn-default" title="Visualizza">
                                            <i class="icon-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        {/if}

        {* Customers Without Orders *}
        {if isset($stats.customers.customers_no_orders) && count($stats.customers.customers_no_orders) > 0}
        <div class="col-lg-6">
            <div class="panel panel-modern panel-warning-light">
                <div class="panel-heading">
                    <i class="icon-warning-sign"></i> Clienti Senza Ordini (Top {$limit})
                </div>
                <div class="panel-body">
                    <div class="table-responsive" style="max-height: 450px; overflow-y: auto;">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Cliente</th>
                                    <th>Email</th>
                                    <th>Data Registrazione</th>
                                    <th class="text-center">Azioni</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$stats.customers.customers_no_orders item=customer name=noOrderLoop}
                                <tr>
                                    <td>{$smarty.foreach.noOrderLoop.iteration}</td>
                                    <td>
                                        <a href="{$smarty.const._PS_BASE_URL}{$smarty.const.__PS_BASE_URI__}admin-dev/index.php?controller=AdminCustomers&id_customer={$customer.id_customer|escape:'html':'UTF-8'}&updatecustomer&token={Tools::getAdminTokenLite('AdminCustomers')}" 
                                           target="_blank" class="customer-link">
                                            {$customer.firstname|escape:'html':'UTF-8'} {$customer.lastname|escape:'html':'UTF-8'}
                                        </a>
                                    </td>
                                    <td><small>{$customer.email|escape:'html':'UTF-8'}</small></td>
                                    <td><small>{$customer.date_add|date_format:'%d/%m/%Y'}</small></td>
                                    <td class="text-center">
                                        <a href="{$smarty.const._PS_BASE_URL}{$smarty.const.__PS_BASE_URI__}admin-dev/index.php?controller=AdminCustomers&id_customer={$customer.id_customer|escape:'html':'UTF-8'}&viewcustomer&token={Tools::getAdminTokenLite('AdminCustomers')}" 
                                           target="_blank" class="btn btn-xs btn-warning" title="Visualizza">
                                            <i class="icon-eye"></i>
                                        </a>
                                    </td>
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

    {* Purchase Frequency and Country Distribution *}
    <div class="row">
        {* Purchase Frequency Distribution *}
        {if isset($stats.customers.purchase_frequency) && count($stats.customers.purchase_frequency) > 0}
        <div class="col-lg-6">
            <div class="panel panel-modern">
                <div class="panel-heading">
                    <i class="icon-repeat"></i> Distribuzione Frequenza Acquisti
                </div>
                <div class="panel-body">
                    <canvas id="purchaseFrequencyChart" height="200"></canvas>
                    <div style="margin-top: 20px;">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Frequenza</th>
                                    <th class="text-right">Numero Clienti</th>
                                    <th class="text-right">Percentuale</th>
                                </tr>
                            </thead>
                            <tbody>
                                {assign var="total_freq_customers" value=0}
                                {foreach from=$stats.customers.purchase_frequency item=freq}
                                    {assign var="total_freq_customers" value=$total_freq_customers+$freq.customer_count}
                                {/foreach}
                                {foreach from=$stats.customers.purchase_frequency item=freq}
                                <tr>
                                    <td><strong>{$freq.frequency_group|escape:'html':'UTF-8'}</strong></td>
                                    <td class="text-right">{$freq.customer_count|escape:'html':'UTF-8'}</td>
                                    <td class="text-right">
                                        {if $total_freq_customers > 0}
                                            {($freq.customer_count / $total_freq_customers * 100)|string_format:"%.1f"}%
                                        {else}
                                            0%
                                        {/if}
                                    </td>
                                </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        {/if}

        {* Top Countries *}
        {if isset($stats.customers.by_country) && count($stats.customers.by_country) > 0}
        <div class="col-lg-6">
            <div class="panel panel-modern">
                <div class="panel-heading">
                    <i class="icon-globe"></i> Top 10 Paesi per Numero di Clienti
                </div>
                <div class="panel-body">
                    <canvas id="customersByCountryChart" height="200"></canvas>
                    <div class="table-responsive" style="max-height: 300px; overflow-y: auto; margin-top: 20px;">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Paese</th>
                                    <th class="text-right">Numero Clienti</th>
                                    <th class="text-right">%</th>
                                </tr>
                            </thead>
                            <tbody>
                                {assign var="total_country_customers" value=0}
                                {foreach from=$stats.customers.by_country item=country}
                                    {assign var="total_country_customers" value=$total_country_customers+$country.customer_count}
                                {/foreach}
                                {foreach from=$stats.customers.by_country item=country name=countryLoop}
                                <tr>
                                    <td><strong>{$smarty.foreach.countryLoop.iteration}</strong></td>
                                    <td>{$country.country_name|escape:'html':'UTF-8'}</td>
                                    <td class="text-right">
                                        <span class="badge badge-primary">{$country.customer_count|escape:'html':'UTF-8'}</span>
                                    </td>
                                    <td class="text-right">
                                        {if $total_country_customers > 0}
                                            {($country.customer_count / $total_country_customers * 100)|string_format:"%.1f"}%
                                        {else}
                                            0%
                                        {/if}
                                    </td>
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

</div>

{* Enhanced Chart.js Scripts *}
<script>
document.addEventListener('DOMContentLoaded', function() {
    {* Purchase Frequency Chart *}
    {if isset($stats.customers.purchase_frequency) && count($stats.customers.purchase_frequency) > 0}
    var freqCtx = document.getElementById('purchaseFrequencyChart');
    if (freqCtx) {
        var freqLabels = [];
        var freqData = [];
        var freqColors = ['#d9534f', '#5bc0de', '#5cb85c', '#f0ad4e', '#337ab7'];
        
        {foreach from=$stats.customers.purchase_frequency item=freq name=freqLoop}
            freqLabels.push('{$freq.frequency_group|escape:'javascript':'UTF-8'}');
            freqData.push({$freq.customer_count});
        {/foreach}
        
        new Chart(freqCtx, {
            type: 'doughnut',
            data: {
                labels: freqLabels,
                datasets: [{
                    data: freqData,
                    backgroundColor: freqColors,
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            boxWidth: 15,
                            padding: 15,
                            font: {
                                size: 12
                            }
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                var label = context.label || '';
                                var value = context.parsed || 0;
                                var total = context.dataset.data.reduce((a, b) => a + b, 0);
                                var percentage = ((value / total) * 100).toFixed(1);
                                return label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
    }
    {/if}

    {* Customers by Country Chart - Limited to top 10 *}
    {if isset($stats.customers.by_country) && count($stats.customers.by_country) > 0}
    var countryCtx = document.getElementById('customersByCountryChart');
    if (countryCtx) {
        var countryLabels = [];
        var countryData = [];
        var countryColors = [];
        
        {* Limit to top 10 for chart *}
        {assign var="chart_limit" value=0}
        {foreach from=$stats.customers.by_country item=country name=countryLoop}
            {if $chart_limit < 10}
                countryLabels.push('{$country.country_name|escape:'javascript':'UTF-8'}');
                countryData.push({$country.customer_count});
                countryColors.push('rgba(54, 162, 235, 0.8)');
                {assign var="chart_limit" value=$chart_limit+1}
            {/if}
        {/foreach}
        
        new Chart(countryCtx, {
            type: 'bar',
            data: {
                labels: countryLabels,
                datasets: [{
                    label: 'Numero Clienti',
                    data: countryData,
                    backgroundColor: countryColors,
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                indexAxis: 'y',
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return 'Clienti: ' + context.parsed.x;
                            }
                        }
                    }
                }
            }
        });
    }
    {/if}
});
</script>

{* Custom CSS for elegant, modern design *}
<style>
.customer-stats-container {
    padding: 10px 0;
}

.panel-stat {
    border: none;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    border-radius: 8px;
    margin-bottom: 20px;
    transition: transform 0.2s, box-shadow 0.2s;
}

.panel-stat:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
}

.panel-stat.panel-primary {
    border-left: 4px solid #337ab7;
}

.panel-stat.panel-success {
    border-left: 4px solid #5cb85c;
}

.panel-stat.panel-info {
    border-left: 4px solid #5bc0de;
}

.panel-stat.panel-warning {
    border-left: 4px solid #f0ad4e;
}

.panel-stat.panel-default {
    border-left: 4px solid #999;
}

.stat-icon {
    font-size: 36px;
    color: #337ab7;
    margin-bottom: 10px;
    opacity: 0.8;
}

.panel-stat.panel-success .stat-icon {
    color: #5cb85c;
}

.panel-stat.panel-info .stat-icon {
    color: #5bc0de;
}

.panel-stat.panel-warning .stat-icon {
    color: #f0ad4e;
}

.stat-icon-small {
    font-size: 24px;
    color: #777;
    margin-bottom: 5px;
}

.stat-number {
    font-size: 32px;
    font-weight: bold;
    margin: 10px 0;
    color: #333;
}

.stat-number-small {
    font-size: 24px;
    font-weight: bold;
    margin: 5px 0;
    color: #555;
}

.stat-label {
    font-size: 14px;
    color: #777;
    margin: 0;
    font-weight: 500;
}

.stat-label-small {
    font-size: 12px;
    color: #999;
    margin: 0;
}

.stat-badge {
    display: inline-block;
    padding: 3px 8px;
    background: rgba(0,0,0,0.05);
    border-radius: 12px;
    font-weight: 600;
    color: #555;
    margin-top: 5px;
}

.panel-modern {
    border: none;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    border-radius: 8px;
    margin-bottom: 20px;
}

.panel-modern .panel-heading {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 8px 8px 0 0;
    padding: 15px 20px;
    font-weight: 600;
    font-size: 15px;
    border: none;
}

.panel-modern.panel-warning-light .panel-heading {
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.panel-modern .panel-body {
    padding: 20px;
}

.customer-link {
    color: #337ab7;
    font-weight: 500;
    text-decoration: none;
}

.customer-link:hover {
    color: #23527c;
    text-decoration: underline;
}

.table-hover tbody tr:hover {
    background-color: #f5f8fa;
}

.badge-info {
    background-color: #5bc0de;
    padding: 5px 10px;
    font-size: 12px;
}

.badge-primary {
    background-color: #337ab7;
    color: white;
    padding: 4px 8px;
    border-radius: 10px;
    font-size: 11px;
}

.btn-xs {
    padding: 3px 8px;
    font-size: 12px;
}

/* Scrollbar styling */
.table-responsive::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

.table-responsive::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 4px;
}

.table-responsive::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 4px;
}

.table-responsive::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>
{/if}
