--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GetDotaHud()
{
    let hPanel = $.GetContextPanel();
    while ( hPanel && hPanel.id !== 'Hud')
    {
        hPanel = hPanel.GetParent();
    }
    if (!hPanel)
    {
        throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
    }
    return hPanel;
}

function FindDotaHudElement(sId)
{
    return GetDotaHud().FindChildTraverse(sId);
}

var portraitHUD = FindDotaHudElement("portraitHUD")
var KillCamHeroRender = FindDotaHudElement("KillCamHeroImageOrMovie").GetChild(0)
var PortaitsScene_1 = $("#PortaitsScene_1")
var PortaitsScene_2 = $("#PortaitsScene_2")
var PortaitsScene_3 = $("#PortaitsScene_3")
var PortaitsScene_4 = $("#PortaitsScene_4")
var PortaitsScene_5 = $("#PortaitsScene_5")
var PortaitsScene_6 = $("#PortaitsScene_6")
var PortaitsScene_7 = $("#PortaitsScene_7")
var PortaitsScene_8 = $("#PortaitsScene_8")
var PortaitsSceneKiller = $("#PortaitsSceneKiller")
var save_portrait = null
var is_scene_reload = {}
var heroes_save_scene = {}
var save_panels_ids = {}
var disabled_hud_unit = {}
var locked_reload = {}

GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "dota_player_update_query_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "m_event_dota_inventory_changed_query_unit", UpdateSelectionUnit );

function UpdateSelectionUnit(data)
{
    let hero_current = Players.GetLocalPlayerPortraitUnit()
    UpdatePortraitCustom(hero_current)
}

function InitPortrait()
{
    if (portraitHUD)
    {
        PortaitsScene_1.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_1"] = PortaitsScene_1
        locked_reload["PortaitsScene_1"] = false
        PortaitsScene_2.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_2"] = PortaitsScene_2
        locked_reload["PortaitsScene_2"] = false
        PortaitsScene_3.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_3"] = PortaitsScene_3
        locked_reload["PortaitsScene_3"] = false
        PortaitsScene_4.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_4"] = PortaitsScene_4
        locked_reload["PortaitsScene_4"] = false
        PortaitsScene_5.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_5"] = PortaitsScene_5
        locked_reload["PortaitsScene_5"] = false
        PortaitsScene_6.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_6"] = PortaitsScene_6
        locked_reload["PortaitsScene_6"] = false
        PortaitsScene_7.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_7"] = PortaitsScene_7
        locked_reload["PortaitsScene_7"] = false
        PortaitsScene_8.SetParent(portraitHUD)
        save_panels_ids["PortaitsScene_8"] = PortaitsScene_8
        locked_reload["PortaitsScene_8"] = false
    }
    if (KillCamHeroRender)
    {
        PortaitsSceneKiller.SetParent(KillCamHeroRender)
    }
}

function OnSceneLoad(panel_name)
{
    if (!locked_reload[panel_name])
    {
        is_scene_reload = {}
        let hero_current = Players.GetLocalPlayerPortraitUnit()
        let hero_name = Entities.GetUnitName(hero_current)
        let scene = save_panels_ids[panel_name]
        if (scene.hero_save && scene.hero_save == hero_name)
        {
            GameEvents.SendEventClientSide( "update_portrait_lua", { portrait_unit : hero_current })
            scene.current_camera = "default"
            locked_reload[scene.scene_id] = true
            scene.ReloadScene()
            is_scene_reload[hero_name] = true
        }
        return
    }
    locked_reload[panel_name] = false
    save_panels_ids[panel_name].LerpToCameraEntity(save_panels_ids[panel_name].current_camera, 0);
}

function OnSceneLoadKiller()
{
    let panel = PortaitsSceneKiller;
    panel.LerpToCameraEntity(panel.current_camera, 0);
}

GameEvents.Subscribe_custom("force_update_player_hidden", force_update_player_hidden)
function force_update_player_hidden(data)
{
    disabled_hud_unit[data.entindex] = data.enable ? true : null
}

GameEvents.Subscribe_custom("force_update_player_portrait", UpdatePortraitCustomEvent)
function UpdatePortraitCustomEvent(data)
{
    let hero_current = Players.GetLocalPlayerPortraitUnit()
    let hero_name = Entities.GetUnitName(hero_current)
    if (data.mega_force)
    {
        UpdatePortraitCustom(hero_current, true)
        return
    }
    if (!data.model_change)
    {
        is_scene_reload[data.hero_name] = null
    }
    if (data.entindex && data.entindex != hero_current)
    {
        return
    }
    UpdatePortraitCustom(hero_current, true)
}

function GetSceneHero(hero_name)
{
    if (heroes_save_scene[hero_name])
    {
        return heroes_save_scene[hero_name]
    }
    else
    {
        for (let i = 1; i <= 8; i++)
        {
            let scene_panel = save_panels_ids["PortaitsScene_"+i]
            if (scene_panel && scene_panel.hero_save == null)
            {
                scene_panel.hero_save = hero_name
                scene_panel.scene_id = "PortaitsScene_"+i
                heroes_save_scene[hero_name] = scene_panel
                return scene_panel
            }
        }
    }
    return null
}

function UpdatePortraitCustom(hero_current, ignore_current)
{
    for (let panel_id in save_panels_ids)
    {
        let scene_to_close = save_panels_ids[panel_id]
        scene_to_close.style.opacity = "0"
    }
    if (!Entities.IsHero(hero_current))
    {
        return
    }
    if (Entities.IsCreepHero(hero_current))
    {
        return
    }
    let hero_name = Entities.GetUnitName(hero_current)
    let scene = GetSceneHero(hero_name)
    if (!ignore_current && save_portrait == hero_current)
    {
        scene.style.opacity = (Entities.IsHexed( hero_current ) || disabled_hud_unit[hero_current]) ? "0" : "1"
        return 
    }
    scene.style.opacity = (Entities.IsHexed( hero_current ) || disabled_hud_unit[hero_current]) ? "0" : "1"
    save_portrait = hero_current
    if (!is_scene_reload[hero_name])
    {
        GameEvents.SendEventClientSide( "update_portrait_lua", { portrait_unit : hero_current })
        scene.current_camera = "default"
        locked_reload[scene.scene_id] = true
        scene.ReloadScene()
        is_scene_reload[hero_name] = true
    }
}

GameEvents.Subscribe_custom("update_player_killer", update_player_killer)
function update_player_killer(data)
{
    let scene = PortaitsSceneKiller
    GameEvents.SendEventClientSide( "update_killer_lua", { portrait_unit : data.hero_current })
    scene.current_camera = "default"
    scene.ReloadScene()
}

InitPortrait()