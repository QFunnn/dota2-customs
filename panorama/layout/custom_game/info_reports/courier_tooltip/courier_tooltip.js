--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var player_courier_name = {}
var hide_other_names = false

CustomNetTables.SubscribeNetTableListener( "sub_data", UpdatePlayerShopTable );

function UpdatePlayerShopTable(table, key, data ) 
{
	if (table == "sub_data") 
	{
        UpdatePetsName(key, data)
	}
}

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

let TrackEntities = {}
let PanelsForEntity = {}

function CreatePanelsForEntity(entity)
{
    let Panel = $.CreatePanel("Panel", $.GetContextPanel(), "")
    Panel.BLoadLayoutSnippet("CourierNamePanel")
    PanelsForEntity[String(entity)] = Panel
    Panel.SetParent(GetDotaHud())
}

function UpdatePanelForEntity(entity) 
{
    let EntityPanel = PanelsForEntity[String(entity)]
    if (!EntityPanel) 
    {
        CreatePanelsForEntity(entity)
        return
    }
    if (!Entities.IsValidEntity( entity ) || !Entities.IsAlive(entity)) 
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    let PetOwner = Entities.GetPlayerOwnerID(entity)
    if (PetOwner == -1) 
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    if (hide_other_names && PetOwner != Players.GetLocalPlayer()) 
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    let PetOwnerHandler = Players.GetPlayerHeroEntityIndex(PetOwner)
    if (!Entities.IsAlive( PetOwnerHandler ))
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    if (IsPetInvisible(entity) && PetOwner != Players.GetLocalPlayer())
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    let PetName = player_courier_name[PetOwner]
    if (PetName == null || PetName == "" || PetName == " ")
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    if (!Entities.GetAllCreatureEntities().includes(entity))
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    EntityPanel.SetHasClass("Hidden", false)
    let pos = Entities.GetAbsOrigin(entity)
    if (!pos) 
    {
        return
    }
    let screen_x = Game.WorldToScreenX(pos[0], pos[1], pos[2] + 130)
    let screen_y = Game.WorldToScreenY(pos[0], pos[1], pos[2] + 130)
    let height = EntityPanel.actuallayoutheight
    let width = EntityPanel.actuallayoutwidth
    if (height == 0 || width == 0) 
    {
        return
    }
    let panel_x = screen_x - width / 2
    let panel_y = screen_y - height / 2
    let mx = EntityPanel.actualuiscale_x
    let my = EntityPanel.actualuiscale_y
    EntityPanel.SetPositionInPixels(panel_x / mx, panel_y / my, 0)
    //EntityPanel.style.x = panel_x / mx + "px"; 
	//EntityPanel.style.y = panel_y / my - 65 + "px";
    EntityPanel.FindChildTraverse("CourierName").text = PetName
}

function IsPetInvisible(entity)
{
    if (HasModifierPet(entity, "modifier_invisible") || Entities.IsInvisible(entity))
    {
        return true
    }
    return false
}

function HasModifierPet(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return true
        }
    }
    return false
}

function UpdatePetsName(player_id, data)
{
    if (data)
    {
        player_courier_name[Number(player_id)] = data.pet_overhead_name
        if (player_id == Players.GetLocalPlayer())
        {
            hide_other_names = data.hide_pet_names
        }
        return
    }   
    for (let i = 0; i <= 10; i++) 
    {
        var sub_data = CustomNetTables.GetTableValue("sub_data", String(i));
        if (sub_data)
        {
            player_courier_name[i] = sub_data.pet_overhead_name
            if (i == Players.GetLocalPlayer())
            {
                hide_other_names = sub_data.hide_pet_names
            }
        }
    } 
}

function Init() 
{
    UpdatePetsName()
    //let entities = Entities.GetAllCreatureEntities()
    //for (const entity of Object.values(entities))
    //{
    //    let unit_name = Entities.GetUnitName( entity )
    //    if (unit_name.includes("npc_dota_donate_pet"))
    //    {
    //        TrackEntities[String(entity)] = true
    //    }
    //}
    Loop()
}

function Loop()
{
    //let entities = Entities.GetAllCreatureEntities()
    //for (const entity of Object.values(entities))
    //{
    //    let unit_name = Entities.GetUnitName( entity )
    //    if (unit_name.includes("npc_dota_donate_pet"))
    //    {
    //        TrackEntities[String(entity)] = true
    //    }
    //} 
    let pets_list = Object.keys(TrackEntities)
    if (pets_list.length > 0)
    {
        for (const entity of Object.keys(TrackEntities))
        {
            UpdatePanelForEntity(Number(entity))
        }
    }
    $.Schedule(1/144, Loop)
}

function UpdatePetsIndex(data)
{
    TrackEntities[String(data.index)] = true
}

GameEvents.Subscribe_custom('event_update_pets_index', UpdatePetsIndex)

Init()