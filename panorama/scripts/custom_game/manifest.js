--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let DotaHud = GetDotaHud()

GameUI.CustomUIConfig().team_logo_xml = "file://{resources}/layout/custom_game/team_icon.xml";
GameUI.CustomUIConfig().team_logo_large_xml = "file://{resources}/layout/custom_game/team_icon_large.xml";

GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false );     
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_GAME_NAME, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_BAR_BACKGROUND, false );            
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_QUICK_STATS, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );
GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_KILLCAM, false );

GameUI.CustomUIConfig().team_colors = {}
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_GOODGUYS] = "#3dd296;"; // { 61, 210, 150 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_BADGUYS ] = "#F3C909;"; // { 243, 201, 9 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "#c54da8;"; // { 197, 77, 168 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "#FF6C00;"; // { 255, 108, 0 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "#3455FF;"; // { 52, 85, 255 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "#65d413;"; // { 101, 212, 19 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "#815336;"; // { 129, 83, 54 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "#1bc0d8;"; // { 27, 192, 216 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_7] = "#c7e40d;"; // { 199, 228, 13 }
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_8] = "#8c2af4;"; // { 140, 42, 244 }

GameUI.CustomUIConfig().team_icons = {}
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_GOODGUYS] = "s2r://panorama/images/custom_game/team_icons/team_icon_tiger_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_BADGUYS ] = "s2r://panorama/images/custom_game/team_icons/team_icon_monkey_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "file://{images}/custom_game/team_icons/team_icon_dragon_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "file://{images}/custom_game/team_icons/team_icon_dog_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "file://{images}/custom_game/team_icons/team_icon_rooster_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "file://{images}/custom_game/team_icons/team_icon_ram_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "file://{images}/custom_game/team_icons/team_icon_rat_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "file://{images}/custom_game/team_icons/team_icon_boar_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_7] = "file://{images}/custom_game/team_icons/team_icon_snake_01.png";
GameUI.CustomUIConfig().team_icons[DOTATeam_t.DOTA_TEAM_CUSTOM_8] = "file://{images}/custom_game/team_icons/team_icon_horse_01.png";

FindDotaHudElement('TimeOfDay').style['horizontal-align'] = 'left';
FindDotaHudElement('TimeOfDayBG').style['horizontal-align'] = 'left';
FindDotaHudElement('DayGlow').style['horizontal-align'] = 'left';
FindDotaHudElement('NightGlow').style['horizontal-align'] = 'left';
FindDotaHudElement('TimeUntil').style['horizontal-align'] = 'left';
FindDotaHudElement('TimeOfDay').style['margin-left'] = '405px';
FindDotaHudElement('TimeOfDayBG').style['margin-left'] = '390px';
FindDotaHudElement('DayGlow').style['margin-left'] = '390px';
FindDotaHudElement('NightGlow').style['margin-left'] = '390px';
FindDotaHudElement('TimeUntil').style['margin-left'] = '390px';
FindDotaHudElement('glyph').style.visibility = "collapse";
FindDotaHudElement('RadarButton').style.visibility = "collapse";

let PreGame = FindDotaHudElement('PreGame')
if (PreGame)
{
    let RightContainer = PreGame.FindChildTraverse('RightContainer')
    if (RightContainer)
    {
        RightContainer.style.visibility = "collapse";
    }
    let StrategyHeroBadge = PreGame.FindChildTraverse('StrategyHeroBadge')
    if (StrategyHeroBadge)
    {
        StrategyHeroBadge.style.visibility = "collapse";
    }
    let StrategyHeroRelicsThumbnailTooltips = PreGame.FindChildTraverse('StrategyHeroRelicsThumbnailTooltips')
    if (StrategyHeroRelicsThumbnailTooltips)
    {
        StrategyHeroRelicsThumbnailTooltips.style.visibility = "collapse";
    }
    let HeroRelicsContainer = PreGame.FindChildTraverse('HeroRelicsContainer')
    if (HeroRelicsContainer)
    {
        HeroRelicsContainer.style.visibility = "collapse";
    }
    let HeroModelLoadout = PreGame.FindChildTraverse('HeroModelLoadout')
    if (HeroModelLoadout)
    {
        HeroModelLoadout.style.horizontalAlign = "center";
    }
    let SelectedHeroDetails = PreGame.FindChildTraverse('SelectedHeroDetails')
    if (SelectedHeroDetails)
    {
        SelectedHeroDetails.style.horizontalAlign = "center";
        SelectedHeroDetails.style.marginLeft = "0px";
    }
    let StrategyScreen = PreGame.FindChildTraverse('StrategyScreen')
    if (StrategyScreen)
    {
        StrategyScreen.GetChild(2).style.horizontalAlign = "center";
        StrategyScreen.GetChild(2).style.marginLeft = "0px";
        StrategyScreen.GetChild(2).style.marginRight = "100px";
    }
}

function OnGameRulesStateChange(keys) 
{  
    if (Game.GameStateIsBefore(3) ) 
    {
        FindDotaHudElement("PreGame").style.opacity = "0";
    }
    else 
    {
        FindDotaHudElement("PreGame").style.opacity = "1";              
    }
}

GameEvents.Subscribe("game_rules_state_change", OnGameRulesStateChange);

GameEvents.Subscribe("PauseNotification", function(data) 
{
    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": data.reason || 80,
        "message": $.Localize(data.message) + " " + data.time
    })
})

GameEvents.Subscribe("CreateIngameErrorMessage", function(data) 
{
    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": data.reason || 80,
        "message": data.message
    })
})

var GridNeutralsCategory = DotaHud.FindChildTraverse("GridNeutralsCategory")
var GridNewShopCategory = DotaHud.FindChildTraverse("GridNewShopCategory")
var GridBasicItemsCategory = DotaHud.FindChildTraverse("GridBasicItemsCategory")
var GridUpgradesCategory = DotaHud.FindChildTraverse("GridUpgradesCategory")
var ChatHud = DotaHud.FindChildTraverse("HudChat")
if ((Game.GetMapInfo().map_display_name) == "tournament_1x8")
{
    ChatHud.DeleteAsync(0)     
}
GridNeutralsCategory.style.overflow = "squish scroll";
GridNewShopCategory.style.overflow = "squish scroll";
GridBasicItemsCategory.style.overflow = "squish scroll";
GridUpgradesCategory.style.overflow = "squish scroll";     

GameEvents.Subscribe( "SEND_ERROR_TO_PLAYER", function(event){
    EmitErrorToPlayer(event.errorText, event.errorSound)
} )