{*
* PrestaShop Statistics Dashboard Widget
*
* @author    Giuliano De Mar
* @copyright Copyright (c) 2024
* @license   MIT License
*}

<div class="panel prestashopstats-widget">
    <div class="panel-heading">
        <i class="icon-bar-chart"></i> {l s='Quick Statistics' mod='prestashopstats'}
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-12 text-center">
                <a href="{$link->getAdminLink('AdminPrestaShopStats')}" class="btn btn-primary">
                    <i class="icon-bar-chart"></i> {l s='View Full Statistics Dashboard' mod='prestashopstats'}
                </a>
            </div>
        </div>
    </div>
</div>
