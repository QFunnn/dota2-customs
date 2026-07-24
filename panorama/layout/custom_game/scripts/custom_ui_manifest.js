--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );

GameUI.CustomUIConfig().team_colors = {}
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_GOODGUYS] = "#3dd296;"; // { 61, 210, 150 }    --        Teal
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_BADGUYS ] = "#F3C909;"; // { 243, 201, 9 }     --        Yellow
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "#c54da8;"; // { 197, 77, 168 }    --        Pink
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "#FF6C00;"; // { 255, 108, 0 }     --        Orange
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "#3455FF;"; // { 52, 85, 255 }     --        Blue
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "#65d413;"; // { 101, 212, 19 }    --        Green
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "#815336;"; // { 129, 83, 54 }     --        Brown
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "#1bc0d8;"; // { 27, 192, 216 }    --        Cyan
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_7] = "#c7e40d;"; // { 199, 228, 13 }    --        Olive
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_8] = "#8c2af4;"; // { 140, 42, 244 }    --        Purple

var PANELS_DELETE_LIST =
[
    "GlyphScanContainer",
    "level_stats_frame",
    "StatBranch",
    "StatBranchDrawer",
    "AghsStatusContainer",
    "inventory_neutral_craft_holder",
    "RoshanTimerContainer",
    "BuybackProtection",
    "TimersContainer",
    "TormentorTimerContainer",
    "InvokerAghsStatusContainer",
    "CoachingControls",
]

var PANELS_OPACITY_LIST =
[
    "unitbadge",
    "courier",
]

for (let panel_name of PANELS_DELETE_LIST)
{
    let panel = FindDotaHudElement(panel_name)
    if (panel)
    {
        panel.style.visibility = "collapse";
    }
}

for (let panel_name of PANELS_OPACITY_LIST)
{
    let panel = FindDotaHudElement(panel_name)
    if (panel)
    {
        panel.style.opacity = "0";
    }
}

// other hud deletes
let ShopCourierControls = FindDotaHudElement("ShopCourierControls")
if (ShopCourierControls)
{
    
}
let ItemContextMenuInstructionsContainer = GetDotaHud().FindChildrenWithClassTraverse("ItemContextMenuInstructionsContainer")[0]
if (ItemContextMenuInstructionsContainer)
{
    ItemContextMenuInstructionsContainer.style.visibility = "collapse";
}
let quickbuy = FindDotaHudElement("quickbuy")
if (quickbuy)
{
    let BuybackProtection = quickbuy.FindChildTraverse("BuybackProtection")
    if (BuybackProtection)
    {
        BuybackProtection.style.visibility = "collapse";
    }
}
let minimap = FindDotaHudElement("minimap")
if (minimap)
{
    minimap.style.visibility = "visible";
}
let PreGame = FindDotaHudElement("PreGame")
if (PreGame)
{
    PreGame.style.opacity = "0";
}
let MorphProgress = FindDotaHudElement("MorphProgress")
if (MorphProgress)
{
    MorphProgress.style.marginLeft = "130px"
}
let GridNeutralsCategory = FindDotaHudElement("GridNeutralsCategory")
if (GridNeutralsCategory)
{
    GridNeutralsCategory.style.overflow = "squish scroll";
}
let GridNewShopCategory = FindDotaHudElement("GridNewShopCategory")
if (GridNewShopCategory)
{
    GridNewShopCategory.style.overflow = "squish scroll";
}
let GridBasicItemsCategory = FindDotaHudElement("GridBasicItemsCategory")
if (GridBasicItemsCategory)
{
    GridBasicItemsCategory.style.overflow = "squish scroll";
}
let GridUpgradesCategory = FindDotaHudElement("GridUpgradesCategory")
if (GridUpgradesCategory)
{
    GridUpgradesCategory.style.overflow = "squish scroll";
}
let CommonItems = FindDotaHudElement("CommonItems")
if (CommonItems)
{
    let CommonItemsTitle = CommonItems.FindChildTraverse("CommonItemTitleContainer")
    if (CommonItemsTitle)
    {
        CommonItemsTitle.style.opacity = "0"
    }
    let ItemList = CommonItems.FindChildTraverse("ItemList")
    if (ItemList)
    {
        ItemList.style.opacity = "0"
    }
}

// functions
GameEvents.Subscribe_custom("CreateIngameErrorMessage", function(data) 
{
    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": data.reason || 80,
        "message": data.message
    })
}) 

GameEvents.Subscribe_custom( 'set_camera_target', SetCamera );

function SetCamera( data )
{
    GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin( data.id ), 0.1);
    $.Schedule(0.01, function ()
	{
		GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin( data.id ), 0.1);
	})
}

GameEvents.Subscribe_custom( 'set_unit_target', SetTarget );

function SetTarget( data )
{
    GameUI.SelectUnit( data.unit, false )
}

GameEvents.Subscribe_custom('delete_bounty', delete_bounty)

function delete_bounty(kv)
{
	$.Schedule(0.01, function ()
	{
		var dotaHud = $.GetContextPanel().GetParent().GetParent().FindChild("HUDElements");
		var combat = FindDotaHudElement("combat_events")
		var manager = combat.FindChildTraverse("ToastManager")
		var bounty = manager.FindChildrenWithClassTraverse("event_dota_rune_pickup")
		for (var i = 0; i < manager.GetChildCount(); i++)
		{
			if (manager.GetChild(i).BHasClass("event_dota_rune_pickup"))
			{
				manager.GetChild(i).DeleteAsync(0)
			}
        }
    })
}

GameEvents.Subscribe_custom( 'woda_client_sound', ClientSound );
function ClientSound(data)
{
	Game.EmitSound(data.sound)
}