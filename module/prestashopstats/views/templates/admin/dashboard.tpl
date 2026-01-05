{*
* PrestaShop Statistics Dashboard Template - Italiano
*
* @author    Giuliano De Mar
* @copyright Copyright (c) 2024
* @license   MIT License
*}

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<div class="panel prestashopstats-dashboard">
    <div class="panel-heading">
        <i class="icon-bar-chart"></i> Dashboard Statistiche
    </div>
    
    <div class="panel-body">
        {* Date Range Filter and Limit Selector *}
        <div class="row">
            <div class="col-lg-12">
                <form method="get" class="form-inline pull-right" id="stats-filter-form">
                    <input type="hidden" name="controller" value="AdminPrestaShopStats" />
                    <input type="hidden" name="token" value="{$smarty.get.token|escape:'html':'UTF-8'}" />
                    <input type="hidden" name="tab" value="{$active_tab|escape:'html':'UTF-8'}" id="active-tab-input" />
                    
                    <div class="form-group">
                        <label>Da:</label>
                        <input type="date" name="date_from" value="{$date_from|escape:'html':'UTF-8'}" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label>A:</label>
                        <input type="date" name="date_to" value="{$date_to|escape:'html':'UTF-8'}" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Mostra Top:</label>
                        <select name="limit" class="form-control">
                            <option value="10" {if $limit == 10}selected{/if}>10</option>
                            <option value="25" {if $limit == 25}selected{/if}>25</option>
                            <option value="50" {if $limit == 50}selected{/if}>50</option>
                            <option value="100" {if $limit == 100}selected{/if}>100</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-default">
                        <i class="icon-search"></i> Filtra
                    </button>
                </form>
            </div>
        </div>
        
        <div class="clearfix"></div>
        <hr/>

        {* Tab Navigation *}
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="{if $active_tab == 'dashboard'}active{/if}">
                <a href="#" data-tab="dashboard" class="tab-link">
                    <i class="icon-dashboard"></i> Dashboard
                </a>
            </li>
            <li role="presentation" class="{if $active_tab == 'orders'}active{/if}">
                <a href="#" data-tab="orders" class="tab-link">
                    <i class="icon-shopping-cart"></i> Ordini
                </a>
            </li>
            <li role="presentation" class="{if $active_tab == 'customers'}active{/if}">
                <a href="#" data-tab="customers" class="tab-link">
                    <i class="icon-group"></i> Clienti
                </a>
            </li>
            <li role="presentation" class="{if $active_tab == 'visits'}active{/if}">
                <a href="#" data-tab="visits" class="tab-link">
                    <i class="icon-signal"></i> Visite
                </a>
            </li>
        </ul>

        <div class="tab-content" style="margin-top: 20px;">
            
            {* Dashboard Tab *}
            {if $active_tab == 'dashboard'}
                {include file="./tabs/dashboard_overview.tpl"}
            {/if}
            
            {* Orders Tab *}
            {if $active_tab == 'orders' && isset($stats.sales)}
                {include file="./tabs/orders_tab.tpl"}
            {/if}
            
            {* Customers Tab *}
            {if $active_tab == 'customers' && isset($stats.customers)}
                {include file="./tabs/customers_tab.tpl"}
            {/if}
            
            {* Visits Tab *}
            {if $active_tab == 'visits' && (isset($stats.traffic) || isset($stats.products))}
                {include file="./tabs/visits_tab.tpl"}
            {/if}
            
        </div>
    </div>
</div>

<script>
// Tab switching functionality
$(document).ready(function() {
    $('.tab-link').click(function(e) {
        e.preventDefault();
        var tab = $(this).data('tab');
        $('#active-tab-input').val(tab);
        $('#stats-filter-form').submit();
    });
});
</script>
