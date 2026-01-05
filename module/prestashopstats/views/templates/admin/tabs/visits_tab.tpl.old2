{*
* Visits and Traffic Statistics Tab
*}

{if isset($stats.traffic)}
<div class="row">
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <i class="icon-signal"></i> {l s='Total Visits' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.traffic.total_visits|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                <i class="icon-eye"></i> {l s='Total Page Views' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.traffic.total_page_views|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-success">
            <div class="panel-heading">
                <i class="icon-shopping-cart"></i> {l s='Conversions' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.traffic.conversions|escape:'html':'UTF-8'}</h2>
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-6">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <i class="icon-percent"></i> {l s='Conversion Rate' mod='prestashopstats'}
            </div>
            <div class="panel-body text-center">
                <h2>{$stats.traffic.conversion_rate|escape:'html':'UTF-8'}%</h2>
            </div>
        </div>
    </div>
</div>

<div class="row">
    {if isset($stats.traffic.sources) && count($stats.traffic.sources) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-arrow-circle-right"></i> {l s='Top' mod='prestashopstats'} {$limit} {l s='Traffic Sources' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <canvas id="trafficSourcesChart" height="120"></canvas>
                <div style="max-height: 400px; overflow-y: auto; margin-top: 20px;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>{l s='Source' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Visits' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Percentage' mod='prestashopstats'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {assign var="total_visits_sources" value=0}
                            {foreach from=$stats.traffic.sources item=source}
                                {assign var="total_visits_sources" value=$total_visits_sources+$source.visit_count}
                            {/foreach}
                            {foreach from=$stats.traffic.sources item=source name=sourceLoop}
                            <tr>
                                <td>{$smarty.foreach.sourceLoop.iteration}</td>
                                <td><strong>{$source.source|escape:'html':'UTF-8'}</strong></td>
                                <td class="text-right">{$source.visit_count|escape:'html':'UTF-8'}</td>
                                <td class="text-right">
                                    {if $total_visits_sources > 0}
                                        {($source.visit_count / $total_visits_sources * 100)|string_format:"%.1f"}%
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
    
    {if isset($stats.products.most_viewed) && count($stats.products.most_viewed) > 0}
    <div class="col-lg-6">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-eye"></i> {l s='Top' mod='prestashopstats'} {$limit} {l s='Most Viewed Products' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <div style="max-height: 600px; overflow-y: auto;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>{l s='Product' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Views' mod='prestashopstats'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.products.most_viewed item=product name=viewLoop}
                            <tr>
                                <td>{$smarty.foreach.viewLoop.iteration}</td>
                                <td>{$product.name|escape:'html':'UTF-8'}</td>
                                <td class="text-right"><strong>{$product.view_count|escape:'html':'UTF-8'}</strong></td>
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

{if isset($stats.products.by_category) && count($stats.products.by_category) > 0}
<div class="row">
    <div class="col-lg-12">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-tags"></i> {l s='Top' mod='prestashopstats'} {$limit} {l s='Product Categories Performance' mod='prestashopstats'}
            </div>
            <div class="panel-body">
                <div style="max-height: 400px; overflow-y: auto;">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>{l s='Category' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Products' mod='prestashopstats'}</th>
                                <th class="text-right">{l s='Units Sold' mod='prestashopstats'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$stats.products.by_category item=category name=catLoop}
                            <tr>
                                <td>{$smarty.foreach.catLoop.iteration}</td>
                                <td><strong>{$category.category_name|escape:'html':'UTF-8'}</strong></td>
                                <td class="text-right">{$category.product_count|escape:'html':'UTF-8'}</td>
                                <td class="text-right"><strong>{$category.total_sold|escape:'html':'UTF-8'}</strong></td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
{/if}

<script>
{if isset($stats.traffic.sources) && count($stats.traffic.sources) > 0}
// Traffic Sources Chart
var sourceNames = [];
var sourceVisits = [];
{foreach from=$stats.traffic.sources item=source name=sourceChartLoop}
    {if $smarty.foreach.sourceChartLoop.index < 10}
    sourceNames.push('{$source.source|escape:'javascript':'UTF-8'}');
    sourceVisits.push({$source.visit_count});
    {/if}
{/foreach}

var ctx = document.getElementById('trafficSourcesChart').getContext('2d');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: sourceNames,
        datasets: [{
            label: 'Visits',
            data: sourceVisits,
            backgroundColor: 'rgba(75, 192, 192, 0.6)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        indexAxis: 'y',
        plugins: {
            legend: {
                display: false
            }
        },
        scales: {
            x: {
                beginAtZero: true
            }
        }
    }
});
{/if}
</script>
{/if}
