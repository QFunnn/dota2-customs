--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let invokerpanel = null
let parentSet = false
let skills = null
let is_init = false
var init_schedule = false

function initInvokerPanel() 
{
    if (is_init) 
    {
        return
    }
    is_init = true
    skills = 
    [
        [
            { name: "invoker_cold_snap_custom", buttons: ["q", "q", "q"] },
            { name: "invoker_ghost_walk_custom", buttons: ["q", "q", "w"] },
            { name: "invoker_ice_wall_custom", buttons: ["q", "q", "e"] }
        ],
        [
            { name: "invoker_emp_custom", buttons: ["w", "w", "w"] },
            { name: "invoker_tornado_custom", buttons: ["w", "w", "q"] },
            { name: "invoker_alacrity_custom", buttons: ["w", "w", "e"] },
            { name: "invoker_deafening_blast_custom", buttons: ["q", "w", "e"] }
        ],
        [
            { name: "invoker_sun_strike_custom", buttons: ["e", "e", "e"] },
            { name: "invoker_forge_spirit_custom", buttons: ["e", "e", "q"] },
            { name: "invoker_chaos_meteor_custom", buttons: ["e", "e", "w"] }
        ]
    ]
    createInvokerPanel()
}

function createInvokerPanel() 
{
    let invokerPanel = $.GetContextPanel().FindChildTraverse("InvokerPanel")
    if (!invokerPanel) 
    {
        return
    }
    let customButton = $.GetContextPanel().FindChildTraverse("InvokerSpellCardButtonCustom")
    if (Game.IsHUDFlipped()) 
    {
        invokerPanel.AddClass("HUDFlipped")
    }
    invokerPanel.FindChildTraverse("CloseSpellCard").SetPanelEvent('onmouseactivate', () => 
    {
        invokerPanel.AddClass("Hidden")
    })
    customButton.SetPanelEvent('onmouseactivate', () => 
    {
        invokerPanel.ToggleClass("Hidden")
        Game.EmitSound("UI.Click")
    })
    invokerPanel.FindChildTraverse("HideNames").SetPanelEvent('onmouseactivate', () => 
    {
        invokerPanel.ToggleClass("HideNames")
    })

    let ability_1 = Entities.GetAbility( Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()), 0 )
    let ability_2 = Entities.GetAbility( Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()), 1 )
    let ability_3 = Entities.GetAbility( Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()), 2 )

    let q_new = Abilities.GetKeybind( ability_1 )
    let w_new = Abilities.GetKeybind( ability_2 )
    let e_new = Abilities.GetKeybind( ability_3 )

    skills.forEach((skillColumn, columnIndex) => 
    {
        let currentColumn = invokerPanel.FindChildTraverse(`SpellColumn${columnIndex}`)
        skillColumn.forEach((skill, i) => 
        {
            let spellCardRow = $.CreatePanel("Panel", currentColumn, `Row${i}`)
            spellCardRow.AddClass("SpellCardRow")

            let abilityImage = $.CreatePanel("DOTAAbilityImage", spellCardRow, "AbilityIcon")
            abilityImage.abilityname = skill.name
            abilityImage.AddClass("AbilityMaxLevel")
            ShowAbilityDescription(abilityImage, skill.name)

            skill.buttons.forEach((button, buttonIndex) => 
            {
                let panelKey = $.CreatePanel("Panel", spellCardRow, `KeyContainer${buttonIndex}`)
                panelKey.AddClass("KeyContainer")
                panelKey.AddClass(button === 'q' ? "QuasColor" : button === 'w' ? "WexColor"  : "ExortColor")

                let labelKey = $.CreatePanel("Label", panelKey, `InvokeKey${buttonIndex}`)
                labelKey.AddClass("InvokeKey")

                let button_name = button === 'q' ? q_new : button === 'w' ? w_new : e_new
                labelKey.text = button_name.toUpperCase()
            })
            let abilityName = $.CreatePanel("Label", spellCardRow, `AbilityName`)
            abilityName.text = $.Localize(`#DOTA_Tooltip_ability_${skill.name}`).toUpperCase()
        })
    })

    panelSetParent()
}

function UpdateSelectionUnit()
{
    let unit = Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit())
    let panel = FindDotaHudElement("InvokerSpellCardButtonCustom")
    if (unit === "npc_dota_hero_invoker")
    {
        initInvokerPanel()
    }
    if (!init_schedule)
    {
        init_schedule = true
        panelSetParent()
        return
    }
    if (!parentSet)
    {
        return
    }
    panel.style.visibility = unit === "npc_dota_hero_invoker" ? "visible" : "collapse"
}

function panelSetParent() 
{
    if (parentSet) { return }
    let Ability5 = FindDotaHudElement("Ability5")
    let lower_hud = FindDotaHudElement("lower_hud")
    if (Ability5) 
    {
        let InvokerPanel = $.GetContextPanel().FindChildTraverse("InvokerPanel")
        let InvokerSpellCardButtonCustom = $.GetContextPanel().FindChildTraverse("InvokerSpellCardButtonCustom")
        InvokerPanel.SetParent(lower_hud)
        InvokerSpellCardButtonCustom.SetParent(Ability5)
        parentSet = true
        UpdateSelectionUnit()
    }
    else
    {
        $.Schedule(0.1, panelSetParent)
    }
}

GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "dota_player_update_query_unit", UpdateSelectionUnit );
GameEvents.Subscribe( "m_event_dota_inventory_changed_query_unit", UpdateSelectionUnit );
UpdateSelectionUnit()