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

var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
dotaHud.FindChildTraverse("GlyphScanContainer").style.visibility = "collapse";
dotaHud.FindChildTraverse("level_stats_frame").style.visibility = "collapse";
dotaHud.FindChildTraverse("StatBranch").style.visibility = "collapse";
dotaHud.FindChildTraverse("StatBranchDrawer").style.visibility = "collapse";
dotaHud.FindChildTraverse("courier").style.visibility = "collapse";
dotaHud.FindChildTraverse("AghsStatusContainer").style.visibility = "collapse";
dotaHud.FindChildTraverse("AghsStatusContainer").style.opacity = "0";
dotaHud.FindChildTraverse("minimap").style.visibility = "visible";
var GridNeutralsCategory = dotaHud.FindChildTraverse("GridNeutralsCategory")
GridNeutralsCategory.style.overflow = "squish scroll";
dotaHud.FindChildTraverse("unitbadge").style.opacity = "0";
dotaHud.FindChildTraverse("inventory_neutral_craft_holder").style.opacity = "0";
dotaHud.FindChildTraverse("RoshanTimerContainer").style.opacity = "0";
dotaHud.FindChildTraverse("inventory_neutral_craft_holder").visible = false;
dotaHud.FindChildTraverse("RoshanTimerContainer").visible = false;

dotaHud.FindChildTraverse("TimersContainer").style.opacity = "0";
dotaHud.FindChildTraverse("TimersContainer").visible = false;

var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
var PreGame = dotaHud.FindChildTraverse("PreGame");
PreGame.style.opacity = "0";
dotaHud.FindChildTraverse("MorphProgress").style.marginLeft = "130px"
var GridNeutralsCategory = dotaHud.FindChildTraverse("GridNeutralsCategory")
var GridNewShopCategory = dotaHud.FindChildTraverse("GridNewShopCategory")
var GridBasicItemsCategory = dotaHud.FindChildTraverse("GridBasicItemsCategory")
var GridUpgradesCategory = dotaHud.FindChildTraverse("GridUpgradesCategory")
var CommonItems = dotaHud.FindChildTraverse("CommonItems")
GridNeutralsCategory.style.overflow = "squish scroll";
GridNewShopCategory.style.overflow = "squish scroll";
GridBasicItemsCategory.style.overflow = "squish scroll";
GridUpgradesCategory.style.overflow = "squish scroll";
if (CommonItems)
{
    var CommonItemsTitle = CommonItems.FindChildTraverse("CommonItemTitleContainer")
    if (CommonItemsTitle)
    {
        CommonItemsTitle.style.opacity = "0"
    }
    var ItemList = CommonItems.FindChildTraverse("ItemList")
    if (ItemList)
    {
        ItemList.style.opacity = "0"
    }
}


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
    $.Msg(data)
    GameUI.SelectUnit( data.unit, false )
}

GameEvents.Subscribe_custom('delete_bounty', delete_bounty)

function delete_bounty(kv)
{
	$.Schedule(0.01, function ()
	{
		var dotaHud = $.GetContextPanel().GetParent().GetParent().FindChild("HUDElements");
		var combat = dotaHud.FindChildTraverse("combat_events")
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