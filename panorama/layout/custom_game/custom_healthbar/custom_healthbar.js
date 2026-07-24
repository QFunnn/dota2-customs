--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let TrackHeroes = {}
var TrackCreeps = {}
let PanelsForEntity = {}
let PanelsForHeroes = {}
let CreepsList = Game.GetCustomTable("health_data", "health_data")
var IGNORED_UNITS = ["npc_dota_thinker", "npc_levelup_service_pet"]
const POST_STAGE_DUMMY_LAYER_COLORS = [
    { from: "#8f3dff", to: "#f062ff" },
    { from: "#13c8ff", to: "#67f7ff" },
    { from: "#10d982", to: "#7cffb6" },
    { from: "#ffb72b", to: "#fff06a" },
    { from: "#ff4f92", to: "#ff9bc7" },
    { from: "#345dff", to: "#8fb0ff" },
    { from: "#d12cff", to: "#ff7bff" },
    { from: "#a8ff2f", to: "#eaff77" },
    { from: "#ff6a1f", to: "#ffc15d" },
    { from: "#f6edff", to: "#b887ff" },
]

function DeleteCreepHealthbar(entity)
{
    let key = String(entity)
    let panel = PanelsForEntity[key]
    if (panel && panel.IsValid())
    {
        panel.DeleteAsync(0)
    }
    delete PanelsForEntity[key]
}

Game.SubscribeCustomTableListener("health_data", (table, key, val, old) => 
{
    if (key == "health_data")
    {
        CreepsList = val
    }
});

function CreatePanelsForEntity(entity)
{
    if (Entities.IsRealHero(Number(entity)))
    {
        return
    }
    let unit_name = Entities.GetUnitName(entity)
    let Panel = $.CreatePanel("Panel", $.GetContextPanel(), "")
    Panel.SetHasClass("Hidden", true)
    Panel.BLoadLayoutSnippet("UnitHealthBar")
    PanelsForEntity[String(entity)] = Panel
    if (Entities.GetTeamNumber(entity) === Players.GetTeam(Players.GetLocalPlayer())) 
    {
        Panel.SetHasClass("Ally", true)
    }
    if (unit_name.includes("npc_levelup_abyss_"))
    {
        Panel.SetHasClass("IsOrangeHealth", true)
        Panel.SetHasClass("IsTimerEnable", true)
    }
    if (unit_name == "npc_levelup_hero_card_challenge_roshan")
    {
        Panel.SetHasClass("IsUnitNameEnable", true)
        Panel.SetHasClass("IsTimerEnable", true)
    }
    if (unit_name == "npc_levelup_neutral_camp_roshan")
    {
        Panel.SetHasClass("IsUnitNameEnable", true)
        Panel.SetHasClass("IsMeritHealth", true)
    }
    if (unit_name == "npc_levelup_lane_splitter" || unit_name == "npc_levelup_lane_berserk" || unit_name == "npc_levelup_lane_splitter_child" || unit_name == "npc_levelup_lane_demolitionist" || unit_name == "npc_levelup_lane_catapult" || unit_name == "npc_levelup_lane_banner_bearer")
    {
        Panel.SetHasClass("IsGoldHealth", true)
        Panel.SetHasClass("IsUnitNameEnable", true)
    }
    if (unit_name.includes("npc_levelup_lane_chest"))
    {
        Panel.SetHasClass("IsPurpleHealth", true)
        Panel.SetHasClass("IsUnitNameEnable", true)
    }
    if (unit_name == "npc_levelup_post_stage_dummy")
    {
        Panel.SetHasClass("IsPostStageDummy", true)
        Panel.SetHasClass("IsUnitNameEnable", true)
    }
    if (unit_name == "npc_levelup_afk_dummy")
    {
        Panel.SetHasClass("IsAfkDummy", true)
        Panel.SetHasClass("IsUnitNameEnable", true)
    }
    if (
        unit_name == "npc_levelup_poststage_activity_selector" ||
        unit_name == "npc_levelup_poststage_back_unit" ||
        unit_name == "npc_levelup_poststage_restart_unit"
    )
    {
        Panel.SetHasClass("IsUnitNameEnable", true)
        Panel.SetHasClass("IsInteractionLabelOnly", true)
    }
    let UnitName = Panel.FindChildTraverse("UnitName")
    if (UnitName && unit_name != "")
    {
        if ($.CanLocalize("#"+unit_name))
        {
            UnitName.text = $.Localize("#"+unit_name)
        }
    }
    let AdminID = Panel.FindChildTraverse("AdminID")
    if (AdminID && Game.IsInToolsMode())
    {
        //AdminID.visible = true
        //AdminID.text = String(entity) + " " + unit_name
    }
    let UnitTimerLabelTime = Panel.FindChildTraverse("UnitTimerLabelTime")
    if (UnitTimerLabelTime)
    {
        Panel.UnitTimerLabelTime = UnitTimerLabelTime
        Panel.IsTimerEnable = true
    }
    Panel.HealthLineBack = Panel.FindChildTraverse("HealthLineBack")
    Panel.HealthBarBG = Panel.FindChildTraverse("HealthBarBG")
    Panel.SetParent(GetDotaHud())
}

function FormatPostStageDummyDamage(value)
{
    const amount = Math.max(0, Number(value || 0))

    if (IsChineseLanguage())
    {
        return FormatChineseNumber(amount, 1)
    }

    if (amount >= 1000000000)
    {
        return (amount / 1000000000).toFixed(1) + "B"
    }
    if (amount >= 1000000)
    {
        return (amount / 1000000).toFixed(1) + "M"
    }
    if (amount >= 10000)
    {
        return (amount / 1000).toFixed(1) + "K"
    }

    return String(Math.floor(amount + 0.5))
}

function GetPostStageDummyLayerColor(layerIndex)
{
    const safeIndex = Math.max(1, Number(layerIndex) || 1)
    return POST_STAGE_DUMMY_LAYER_COLORS[(safeIndex - 1) % POST_STAGE_DUMMY_LAYER_COLORS.length]
}

function BuildPostStageDummyLayerGradient(layerIndex)
{
    const color = GetPostStageDummyLayerColor(layerIndex)
    return "gradient( linear, 0% 0%, 100% 0%, from( " + color.from + " ), to( " + color.to + " ) )"
}

function UpdatePostStageDummyLayerHealthbar(panel, healthData)
{
    const layerIndex = Math.max(1, Number(healthData.dummy_layer_index) || 1)
    const progressPct = Math.max(0, Math.min(100, Number(healthData.dummy_layer_progress_pct) || 0))
    const remainingPct = Math.max(0, Math.min(100, 100 - progressPct))
    const threshold = Math.max(1, Number(healthData.dummy_layer_threshold) || 1)
    const remaining = Math.max(0, Number(healthData.dummy_layer_remaining) || threshold)

    if (panel.HealthBarFront)
    {
        panel.HealthBarFront.style.width = remainingPct + "%"
    }
    if (panel.HealthBarBG)
    {
        panel.HealthBarBG.style.backgroundColor = BuildPostStageDummyLayerGradient(layerIndex)
    }
    if (panel.HealthLineBack)
    {
        panel.HealthLineBack.style.backgroundColor = BuildPostStageDummyLayerGradient(layerIndex + 1)
    }
    if (panel.HealthPercent)
    {
        panel.HealthPercent.text = $.Localize("#levelup_dummy_layer") + " " + layerIndex + " · " + FormatPostStageDummyDamage(remaining) + "/" + FormatPostStageDummyDamage(threshold)
    }
}

function UpdateAfkDummyLayerHealthbar(panel, healthData)
{
    const progressPct = Math.max(0, Math.min(100, Number(healthData.afk_dummy_layer_progress_pct) || 0))
    const remainingPct = Math.max(0, Math.min(100, 100 - progressPct))

    if (panel.HealthBarFront)
    {
        panel.HealthBarFront.style.width = remainingPct + "%"
    }
    if (panel.HealthBarBG)
    {
        panel.HealthBarBG.style.backgroundColor = BuildPostStageDummyLayerGradient(1)
    }
    if (panel.HealthLineBack)
    {
        panel.HealthLineBack.style.backgroundColor = BuildPostStageDummyLayerGradient(2)
    }
    if (panel.HealthPercent)
    {
        panel.HealthPercent.text = Math.floor(remainingPct + 0.5) + "%"
    }
}

async function UpdatePanelForEntity(entity) 
{
    let EntityPanel = PanelsForEntity[String(entity)]
    if (!EntityPanel && Entities.IsValidEntity( entity ) && Entities.IsAlive(entity)) 
    {
        CreatePanelsForEntity(entity)
        return
    }
    if (!EntityPanel || !EntityPanel.IsValid())
    {
        return
    }
    if (!Entities.IsValidEntity( entity ) || !Entities.IsAlive(entity)) 
    {
        EntityPanel.SetHasClass("Hidden", true)
        DeleteCreepHealthbar(entity)
        return
    }
    if (Entities.IsRealHero(Number(entity)))
    {
        EntityPanel.SetHasClass("Hidden", true)
        DeleteCreepHealthbar(entity)
        return
    }
    let health_data = Game.GetCustomTable("health_data", "health_data")
    if (health_data && health_data[String(entity)])
    {
        health_data = health_data[String(entity)]
    }
    if (health_data && health_data.hide_healthbar && health_data.hide_healthbar == 1)
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    if (health_data && health_data.health_percent <= 0 && Entities.GetUnitName(entity) != "npc_levelup_neutral_camp_roshan" && Entities.GetUnitName(entity) != "npc_levelup_afk_dummy")
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    if (!health_data)
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    let pos = Entities.GetAbsOrigin(entity)
    if (!pos) 
    {
        return
    }
    let health_offset = Entities.GetHealthBarOffset(entity)
    pos[2] += health_offset
    let bonus_offset = 0//65
    let screen_x = Game.WorldToScreenX(pos[0], pos[1], pos[2] + bonus_offset)
    let screen_y = Game.WorldToScreenY(pos[0], pos[1], pos[2] + bonus_offset)
    if (screen_x == -1 || screen_y == -1)
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    EntityPanel.SetHasClass("Hidden", false)
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
    EntityPanel.GetChild(0).RemoveClass("OpacityHealthBars")
    if (!EntityPanel.HealthBarFront)
    {
        EntityPanel.HealthBarFront = EntityPanel.FindChildTraverse("HealthBarFront")
    }
    if (!EntityPanel.HealthPercent)
    {
        EntityPanel.HealthPercent = EntityPanel.FindChildTraverse("HealthPercent")
    }
    if (EntityPanel.IsTimerEnable)
    {
        const now = Math.max(0, Game.GetGameTime())
        const unit_name = Entities.GetUnitName(entity)
        let remaining_time = 0

        if (unit_name && unit_name.includes("npc_levelup_abyss_"))
        {
            const abyss_data = Game.GetCustomTable("abyss_state", String(health_data.creep_owner))
            remaining_time = Math.max(0, Number(abyss_data && abyss_data.active_end_time || 0) - now)
        }
        else if (unit_name == "npc_levelup_hero_card_challenge_roshan")
        {
            const hero_card_data = Game.GetCustomTable("heroes_card_player", String(health_data.creep_owner))
            const challenge_units = hero_card_data && hero_card_data.challenge_unit_entindexes ? hero_card_data.challenge_unit_entindexes : null
            const tracked_data = challenge_units ? challenge_units[String(entity)] : null
            remaining_time = Math.max(0, Number(tracked_data && tracked_data.expires_at || 0) - now)
        }

        EntityPanel.UnitTimerLabelTime.text = Math.floor(remaining_time + 1)
    }
    let EntHealthPct = 0
    if (health_data)
    {
        EntHealthPct = health_data.health_percent
    }
    if (EntityPanel.HealthBarFront && EntityPanel.HealthPercent)
    {
        EntityPanel.HealthBarFront.style.width = EntHealthPct + "%"
        if (health_data && health_data.is_post_stage_dummy && health_data.is_post_stage_dummy == 1)
        {
            UpdatePostStageDummyLayerHealthbar(EntityPanel, health_data)
        }
        else if (health_data && health_data.is_afk_dummy && health_data.is_afk_dummy == 1)
        {
            UpdateAfkDummyLayerHealthbar(EntityPanel, health_data)
        }
        else if (Entities.GetUnitName(entity) == "npc_levelup_neutral_camp_roshan" && health_data)
        {
            EntityPanel.HealthPercent.text = Math.floor(health_data.merit_current || 0) + "/" + Math.floor(health_data.merit_max || 2000)
        }
        else
        {
            EntityPanel.HealthPercent.text = EntHealthPct + "%"
        }
    }
}

function CreatePanelsForHero(entity)
{
    let Panel = $.CreatePanel("Panel", $.GetContextPanel(), "")
    Panel.BLoadLayoutSnippet("HeroHealthBar")
    PanelsForHeroes[String(entity)] = Panel
    if (Entities.GetTeamNumber(entity) === Players.GetTeam(Players.GetLocalPlayer())) 
    {
        Panel.SetHasClass("Ally", true)
    }
    let AvatarHeroIMG = Panel.FindChildTraverse("AvatarHeroIMG")
    if (AvatarHeroIMG)
    {
        let player_id = Entities.GetPlayerOwnerID(entity)
        if (player_id != -1)
        {
            let playerInfo = Game.GetPlayerInfo(player_id);
            AvatarHeroIMG.steamid = playerInfo && playerInfo.player_steamid
        }
    }
    Panel.SetParent(GetDotaHud())
}

async function UpdatePanelForHero(entity) 
{
    let EntityPanel = PanelsForHeroes[String(entity)]
    if (!EntityPanel) 
    {
        CreatePanelsForHero(entity)
        return
    }
    if (!EntityPanel || !EntityPanel.IsValid())
    {
        return
    }
    if (!Entities.IsValidEntity( entity ) || !Entities.IsAlive(entity)) 
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    let pos = Entities.GetAbsOrigin(entity)
    if (!pos) 
    {
        return
    }
    let health_offset = Entities.GetHealthBarOffset(entity)
    pos[2] += health_offset
    let screen_x = Game.WorldToScreenX (pos[0], pos[1], pos[2] + 65)
    let screen_y = Game.WorldToScreenY (pos[0], pos[1], pos[2] + 65)
    if (screen_x == -1 || screen_y == -1)
    {
        EntityPanel.SetHasClass("Hidden", true)
        return
    }
    EntityPanel.SetHasClass("Hidden", false)
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
    if (!EntityPanel.HealthBarFront)
    {
        EntityPanel.HealthBarFront = EntityPanel.FindChildTraverse("HealthBarFront")
    }
    if (!EntityPanel.ManaBarFront)
    {
        EntityPanel.ManaBarFront = EntityPanel.FindChildTraverse("ManaBarFront")
    }
    let EntHealthPct = 0
    let health_data = Game.GetCustomTable("health_data", "health_data")
    if (health_data && health_data[String(entity)])
    {
        health_data = health_data[String(entity)]
    }
    if (health_data)
    {
        EntHealthPct = health_data.health_percent
    }
    if (EntityPanel.HealthBarFront)
    {
        EntityPanel.HealthBarFront.style.width = EntHealthPct + "%"
    }
    if (EntityPanel.ManaBarFront)
    {
        const mana = Math.floor(Entities.GetMana(entity))
        const max_mana = Math.floor(Entities.GetMaxMana(entity))
        const mana_percent = (mana / max_mana) * 100
        EntityPanel.ManaBarFront.style.width = mana_percent + "%"
    }
}

function Init() 
{
    Loop()
}

function Loop()
{
    let entities = Entities.GetAllHeroEntities()
    for (const entity of Object.values(entities))
    {
        if (Entities.IsValidEntity( entity ) && Entities.IsAlive(entity)) 
        {
            TrackHeroes[String(entity)] = true
        }
    }

    let ent_list = 
    [
        ...Entities.GetAllEntitiesByName("npc_dota_creature"),
        ...Entities.GetAllEntitiesByName("npc_dota_building")
    ]

    for (let ent_idx of ent_list)
    {
        ent_idx = Number(ent_idx)

        if (!Entities.IsRealHero(ent_idx))
        {
            let unit_name = Entities.GetUnitName(ent_idx)

            if (!IGNORED_UNITS.includes(unit_name))
            {
                TrackCreeps[String(ent_idx)] = true
            }
        }
    }

    let heroes_list = Object.keys(TrackHeroes)
    if (heroes_list.length > 0)
    {
        for (const entity of Object.keys(TrackHeroes))
        {
            UpdatePanelForHero(Number(entity))
        }
    }

    let creeps_list = Object.keys(TrackCreeps)
    if (creeps_list.length > 0)
    {
        for (const entity of Object.keys(TrackCreeps))
        {
            UpdatePanelForEntity(Number(entity))
        }
    }

    const cursorPosition = GameUI.GetCursorPosition()
    const screenEntities = GameUI.FindScreenEntities ? GameUI.FindScreenEntities(cursorPosition) : []
    for (const screenEntity of screenEntities || [])
    {
        const entityIndex = Number(screenEntity.entityIndex || screenEntity.entindex || -1)
        let health_data = Game.GetCustomTable("health_data", "health_data")
        if (health_data && health_data[String(entityIndex)])
        {
            health_data = health_data[String(entityIndex)]
        }
    }

    $.Schedule(1/144, Loop)
}

if (Game.IsInToolsMode())
{
    let DOTAHUD = GetDotaHud()
    let health_Bars = DOTAHUD.FindChildrenWithClassTraverse("UnitHealthBarContainer")
    for (let child of health_Bars) 
    {
        child.DeleteAsync(0) 
    }
}

Init()