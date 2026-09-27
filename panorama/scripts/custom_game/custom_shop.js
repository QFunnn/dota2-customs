--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var CUSTOM_SHOP_SECTIONS = {};

GameEvents.Subscribe_custom('send_items', get_items)

GameEvents.OnLoaded(function () {
    GameEvents.SendCustomGameEventToServer_custom('request_items', {});
});

function get_items(data)
{
    CUSTOM_SHOP_SECTIONS = data.shop
    CustomShopWake();
}


var CUSTOM_SHOP_BASIC_ROWS = ['consumables', 'attributes', 'weapons_armor', 'misc', 'secretshop'];
var CUSTOM_SHOP_UPGRADE_ROWS = ['basics', 'support', 'magics', 'defense', 'weapons', 'artifacts'];

var CUSTOM_SHOP_GRIDS = [
    { id: 'GridBasicItems', rows: CUSTOM_SHOP_BASIC_ROWS },
    { id: 'GridUpgradeItems', rows: CUSTOM_SHOP_UPGRADE_ROWS },
    { id: 'GridBasicItemsV2', rows: CUSTOM_SHOP_BASIC_ROWS },
    { id: 'GridUpgradeItemsV2', rows: CUSTOM_SHOP_UPGRADE_ROWS }
];

var CUSTOM_SHOP_STATE = {};
var CUSTOM_SHOP_HUD = null;
var CUSTOM_SHOP_ROOT = null;
var CUSTOM_SHOP_IDLE = 0;
var CUSTOM_SHOP_GENERATION = 0;

function CustomShopGetHud() {
    if (CUSTOM_SHOP_HUD) {
        return CUSTOM_SHOP_HUD;
    }

    var panel = $.GetContextPanel();

    while (panel && panel.id !== 'Hud') {
        panel = panel.GetParent();
    }

    CUSTOM_SHOP_HUD = panel;

    return panel;
}

function CustomShopGetRoot() {
    if (CUSTOM_SHOP_ROOT) {
        return CUSTOM_SHOP_ROOT;
    }

    var hud = CustomShopGetHud();

    if (!hud) {
        return null;
    }

    CUSTOM_SHOP_ROOT = hud.FindChildTraverse('shop');

    return CUSTOM_SHOP_ROOT || hud;
}

function CustomShopIsOwnPanel(panel) {
    return typeof panel.id === 'string' && panel.id.slice(-4) === '_new';
}

function CustomShopGetItemMetrics(gridId, container) {
    var large = container.BAscendantHasClass('ShopLarge');

    if (gridId === 'GridUpgradeItems') {
        return {
            width: container.BAscendantHasClass('AspectRatio4x3') ? '37px' : '38px',
            scale: large ? '100%' : '92%'
        };
    }

    if (gridId === 'GridBasicItems') {
        return { width: '42px', scale: '100%' };
    }

    return { width: large ? '42px' : '40px', scale: '100%' };
}

function CustomShopFillRow(grid, container, key) {
    var items = CUSTOM_SHOP_SECTIONS[key];

    if (!items) {
        return false;
    }

    items = Object.values(items);

    var cacheKey = grid.id + ':' + key;
    var cached = CUSTOM_SHOP_STATE[cacheKey] || {};
    var metrics = CustomShopGetItemMetrics(grid.id, container);
    var restyle = cached.width !== metrics.width || cached.scale !== metrics.scale;
    var panels = [];
    var created = false;

    CUSTOM_SHOP_STATE[cacheKey] = { width: metrics.width, scale: metrics.scale };

    for (var i = 0; i < items.length; i++) {
        var itemName = items[i];
        var panelId = itemName + '_new';
        var panel = container.FindChild(panelId);

        if (!panel) {
            panel = $.CreatePanel('DOTAShopItem', container, panelId, {
                class: 'CustomShopItem',
                itemname: itemName,
                style: 'width: ' + metrics.width + '; height: width-percentage( 72.7% ); ui-scale: ' + metrics.scale + '; margin-top: 1px; margin-bottom: 1px; margin-right: 3px; margin-left: 2px;'
            });
            created = true;
        } else if (restyle) {
            panel.style.width = metrics.width;
            panel.style.uiScale = metrics.scale;
        }

        panels.push(panel);
    }

    if (created) {
        for (var j = 0; j < panels.length; j++) {
            if (j > 0) {
                container.MoveChildAfter(panels[j], panels[j - 1]);
                continue;
            }

            var first = container.GetChild(0);

            if (first && first.id !== panels[j].id) {
                container.MoveChildBefore(panels[j], first);
            }
        }
    }

    return created || restyle;
}

function CustomShopUpdateGrid(root, grid, pass) {
    if (!grid.panel) {
        grid.panel = root.FindChildTraverse(grid.id);
    }

    var container = grid.panel;

    if (!container) {
        return;
    }

    var rows = container.Children();
    var index = 0;

    for (var r = 0; r < rows.length; r++) {
        var itemsContainer = rows[r].FindChildTraverse('ShopItemsContainer');

        if (!itemsContainer) {
            continue;
        }

        var key = grid.rows[index];

        index++;

        if (!key) {
            continue;
        }

        var children = itemsContainer.Children();

        for (var i = 0; i < children.length; i++) {
            var child = children[i];

            if (!CustomShopIsOwnPanel(child) && child.visible) {
                child.visible = false;
                pass.changed = true;
            }
        }

        pass.rows++;

        if (CustomShopFillRow(grid, itemsContainer, key)) {
            pass.changed = true;
        }
    }
}

function CustomShopUpdate() {
    var pass = { rows: 0, changed: false };
    var root = CustomShopGetRoot();

    if (root) {
        for (var i = 0; i < CUSTOM_SHOP_GRIDS.length; i++) {
            CustomShopUpdateGrid(root, CUSTOM_SHOP_GRIDS[i], pass);
        }
    }

    return pass;
}

function CustomShopSchedule(delay) {
    CUSTOM_SHOP_GENERATION++;

    var generation = CUSTOM_SHOP_GENERATION;

    $.Schedule(delay, function () {
        if (generation === CUSTOM_SHOP_GENERATION) {
            CustomShopTick();
        }
    });
}

function CustomShopTick() {
    var pass = CustomShopUpdate();

    if (pass.changed) {
        CUSTOM_SHOP_IDLE = 0;
    } else {
        CUSTOM_SHOP_IDLE++;
    }

    if (CUSTOM_SHOP_IDLE < (pass.rows > 0 ? 20 : 30)) {
        CustomShopSchedule(0.5);
    }
}

function CustomShopWake() {
    CUSTOM_SHOP_IDLE = 0;

    CustomShopSchedule(0);
}

$.RegisterForUnhandledEvent('StyleClassesChanged', function (panel) {
    if (panel && (panel.id === 'shop' || panel.paneltype === 'DOTAHUDShop')) {
        CustomShopWake();
    }
});

CustomShopWake();