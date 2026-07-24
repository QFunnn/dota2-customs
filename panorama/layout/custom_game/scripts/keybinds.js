--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var UniqueTag = new Date().getTime()
var IsInit = false
var KeySetPlayer = {}
var KeyList = []
var EnableQuikCast = true
var ClickTimeCD = 0
var SAVE_HOTKEYS_LABELS = {}
var KeyBindsList = []

for (let i = 0; i < 6; i++)
{
    KeyBindsList.push([`CastAbility${i}`, `+CastAbility${i}`])
    KeyBindsList.push([`CastAbility${i}${i}`, `-CastAbility${i}`])
}

for (let i = 1; i <= 6; i++)
{
    KeyBindsList.push([`UseItem${i}`, `+UseItem${i}`])
    KeyBindsList.push([`UseItem${i}${i}`, `-UseItem${i}`])
}

KeyBindsList.push(["BackCity","+BackCity"])
KeyBindsList.push(["KeyUp","-BackCity"])
KeyBindsList.push(["TowerCall","+TowerCall"])
KeyBindsList.push(["KeyUp","-TowerCall"])
KeyBindsList.push(["TowerCancel","+TowerCancel"])
KeyBindsList.push(["KeyUp","-TowerCancel"])
KeyBindsList.push(["KeyUp","+KeyUp"])
KeyBindsList.push(["KeyUp","-KeyUp"])

Game.SubscribeCustomTableListener("keybinds_data", (table, key, val, old) =>
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        UpdateKeyBind()
    }
})

function ResponseGameSet()
{
    $.Schedule(1, function()
    {
        if (!IsInit)
        {
            InitShortKey()
            RegisterAbilityCommands()
            RegisterItemCommands()
            IsInit = true
        }
        UpdateKeyBind()
    })
}

function InitShortKey()
{
    let abilityKeys = []
    let itemKeys = []
    for (let i = 0; i < 6; i++)
    {
        abilityKeys.push(GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[i]))
        Game.CreateCustomKeyBind(abilityKeys[i], "+KeyUp" + UniqueTag)
    }
    for (let i = 0; i < 6; i++)
    {
        itemKeys.push(GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[i]))
        Game.CreateCustomKeyBind(itemKeys[i], "+KeyUp" + UniqueTag)
    }
    for (let data of KeyBindsList)
    {
        Game.AddCommand(data[1] + UniqueTag, WrapFunction(data[0]), "", 0)
    }
    GameEvents.SendCustomGameEventToServer("event_game_set_default_keybinds",
    {
        ability:
        {
            1: abilityKeys[0],
            2: abilityKeys[1],
            3: abilityKeys[2],
            4: abilityKeys[3],
            5: abilityKeys[4],
            6: abilityKeys[5],
            7: GetHokeyString(7),
            8: GetHokeyString(8),
            9: GetHokeyString(9)
        },
        item:
        {
            1: itemKeys[0],
            2: itemKeys[1],
            3: itemKeys[2],
            4: itemKeys[3],
            5: itemKeys[4],
            6: itemKeys[5]
        }
    })
}

function UpdateKeyBind()
{
    let resetRecord = {}
    for (let k of KeyList)
    {
        Game.CreateCustomKeyBind(k, "+KeyUp" + UniqueTag)
        resetRecord[k] = true
    }
    KeyList = []
    KeySetPlayer = {}

    let server_keybinds = Game.GetKeySet()
    let keySet =
    {
        item:
        {
            1: server_keybinds?.item?.[1] || GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[0]),
            2: server_keybinds?.item?.[2] || GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[1]),
            3: server_keybinds?.item?.[3] || GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[2]),
            4: server_keybinds?.item?.[4] || GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[3]),
            5: server_keybinds?.item?.[5] || GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[4]),
            6: server_keybinds?.item?.[6] || GetHokeyCustom(ITEMS_KEY_BINDS_SLOTS[5])
        },
        ability:
        {
            1: server_keybinds?.ability?.[1] || GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[0]),
            2: server_keybinds?.ability?.[2] || GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[1]),
            3: server_keybinds?.ability?.[3] || GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[2]),
            4: server_keybinds?.ability?.[4] || GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[3]),
            5: server_keybinds?.ability?.[5] || GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[4]),
            6: server_keybinds?.ability?.[6] || GetHokeyCustom(ABILITIES_KEY_BINDS_SLOTS[5]),
            7: server_keybinds?.ability?.[7] || GetHokeyString(7),
            8: server_keybinds?.ability?.[8] || GetHokeyString(8),
            9: server_keybinds?.ability?.[9] || GetHokeyString(9)
        }
    }

    ApplyKeyBindSet(keySet.item, "UseItem", 6, "item")
    ApplyKeyBindSet(keySet.ability, "CastAbility", 7, "ability")
    Game.CreateCustomKeyBind(keySet.ability["9"], "+BackCity" + UniqueTag)
    Game.CreateCustomKeyBind(keySet.ability["7"], "+TowerCall" + UniqueTag)
    Game.CreateCustomKeyBind(keySet.ability["8"], "+TowerCancel" + UniqueTag)
}

function ApplyKeyBindSet(set, prefix, count, type)
{
    for (let i = 1; i <= count; i++)
    {
        let key = set[i]

        let index = prefix === "CastAbility" ? (i-1) : i
        Game.CreateCustomKeyBind(key, `+${prefix}${index}${UniqueTag}`)

        KeyList.push(key)
        KeySetPlayer[key] = true

        let label = SAVE_HOTKEYS_LABELS[`${type}${i}`]

        if (label)
        {
            label.text = GetLevelUpKeyBind(type, i)
        }
    }
}

function RegisterAbilityCommands()
{
    for (let i = 0; i < 6; i++)
    {
        Game[`CastAbility${i}`] = function()
        {
            PushKeyDown(0, i)
            PushDownStyle(0, i)
        }
        Game[`CastAbility${i}${i}`] = function()
        {
            PushKeyUp(0, i)
        }
    }
}

function RegisterItemCommands()
{
    for (let i = 1; i <= 6; i++)
    {
        let index = i - 1

        Game[`UseItem${i}`] = function()
        {
            PushKeyDown(1, index)
            PushDownStyle(1, index)
        }

        Game[`UseItem${i}${i}`] = function()
        {
            PushKeyUp(1, index)
        }
    }
}

function CanCastAbility(ability, hero)
{
    if (ability == -1) return false
    if (Abilities.GetLevel(ability) < 1) return false
    if (Abilities.IsPassive(ability)) return false
    if (!Abilities.IsActivated(ability)) return false
    if (!Abilities.IsCooldownReady(ability)) return false
    if (Entities.IsSilenced(hero)) return false
    if (Entities.IsStunned(hero)) return false
    return true
}

function PushKeyDown(type, index)
{
    let hero = GetPlayerHero()
    if (type == 0)
    {
        ExecuteClientAbility(index)
        return
    }
    let ability = Entities.GetItemInSlot(hero, index)

    if (!CanCastAbility(ability, hero))
        return

    GameUI.SelectUnit(hero, false)
    Abilities.ExecuteAbility(ability, hero, true)
}

function PushKeyUp(type,index)
{
    let keySlot

    if (type == 0)
        keySlot = AbilitiesList.GetChild(index)
    else
        keySlot = ItemsContainer.FindChildTraverse("ItemPanel"+index)

    keySlot.SetHasClass("pushKey", false)
}

function PushDownStyle(type,index)
{
    let keySlot

    if (type == 0)
        keySlot = AbilitiesList.GetChild(index)
    else
        keySlot = ItemsContainer.FindChildTraverse("ItemPanel"+index)

    keySlot.SetHasClass("pushKey", true)
}

Game.BackCity = function()
{
    GameEvents.SendCustomGameEventToServer("event_player_cast_teleport_to_base", {})
}

Game.KeyUp = function(){}

Game.TowerCall = function()
{
    if (typeof IsPostStageTrialsDisabled === "function" && IsPostStageTrialsDisabled()) return
    if (ClickTimeCD > 0) return

    ClickTimeCD = 0.2
    $.Schedule(0.2,function()
    {
        ClickTimeCD = 0
    })
    GameEvents.SendCustomGameEventToServer("event_player_cast_tower_start", {})
}

Game.TowerCancel = function()
{
    if (ClickTimeCD > 0) return

    ClickTimeCD = 0.2
    $.Schedule(0.2,function()
    {
        ClickTimeCD = 0
    })
    GameEvents.SendCustomGameEventToServer("event_player_cast_tower_end", {})
}

Game.AbilityClickCast = function(i)
{
    if (ClickTimeCD > 0) return

    ClickTimeCD = 0.1
    $.Schedule(0.1,function()
    {
        ClickTimeCD = 0
    })
    PushKeyDown(0, i)
}

Game.ItemClickCast = function(i)
{
    if (ClickTimeCD > 0) return

    ClickTimeCD = 0.1
    $.Schedule(0.1,function()
    {
        ClickTimeCD = 0
    })
    PushKeyDown(1, i)
}

function ExecuteClientAbility(index)
{
    if (index == 0)
        GameEvents.SendCustomGameEventToServer("event_player_cast_ability_custom",{ability_name:"levelup_select_card"})

    else if (index == 1)
        GameEvents.SendCustomGameEventToServer("event_player_cast_ability_custom",{ability_name:"levelup_upgrade_stats"})

    else if (index == 2)
    {
        if (typeof IsPostStageTrialsDisabled === "function" && IsPostStageTrialsDisabled()) return
        GameEvents.SendCustomGameEventToServer("event_player_cast_ability_custom",{ability_name:"levelup_upgrade_artifacts"})
    }

    else if (index == 3)
        GameEvents.SendCustomGameEventToServer("event_player_cast_ability_custom",{ability_name:"levelup_blink",position:GetMousePoint()})

    else if (index == 4)
        SwitchInventoryCards()
}

Game.GetKeySet = function()
{
    return Game.GetCustomTable("keybinds_data", String(Game.GetLocalPlayerID()))
}

ResponseGameSet()