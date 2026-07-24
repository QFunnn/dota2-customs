--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";

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

let invokerpanel = null
let parentSet = false


class InvokerPanel {
    constructor() {
        this.skills = [
            [
                {
                    name: "invoker_cold_snap",
                    buttons: ["q", "q", "q"]
                },
                {
                    name: "invoker_ghost_walk_custom",
                    buttons: ["q", "q", "w"]
                },
                {
                    name: "invoker_ice_wall_custom",
                    buttons: ["q", "q", "e"]
                }
            ],
            [
                {
                    name: "invoker_emp_custom",
                    buttons: ["w", "w", "w"]
                },
                {
                    name: "invoker_tornado_custom",
                    buttons: ["w", "w", "q"]
                },
                {
                    name: "invoker_alacrity_custom",
                    buttons: ["w", "w", "e"]
                },
                {
                    name: "invoker_deafening_blast_custom",
                    buttons: ["q", "w", "e"]
                }
            ],
            [
                {
                    name: "invoker_sun_strike_custom",
                    buttons: ["e", "e", "e"]
                },
                {
                    name: "invoker_forge_spirit_custom",
                    buttons: ["e", "e", "q"]
                },
                {
                    name: "invoker_chaos_meteor_custom",
                    buttons: ["e", "e", "w"]
                }
            ]
        ]
        this.parentSet = false;
        
        this.init()
        checkPortraitUnit()
    }
    init() {
        let invokerPanel = $.GetContextPanel().FindChildTraverse("InvokerPanel")
        let customButton = $.GetContextPanel().FindChildTraverse("InvokerSpellCardButtonCustom")

        if(Game.IsHUDFlipped())
            invokerPanel.AddClass("HUDFlipped")

        invokerPanel.FindChildTraverse("CloseSpellCard").SetPanelEvent('onmouseactivate', () => {
            invokerPanel.AddClass("Hidden")
        })
        customButton.SetPanelEvent('onmouseactivate', () => {
            invokerPanel.ToggleClass("Hidden")
            Game.EmitSound("UI.Click")
        })

        invokerPanel.FindChildTraverse("HideNames").SetPanelEvent('onmouseactivate', () => {
            invokerPanel.ToggleClass("HideNames")
        })

        this.skills.forEach((skillColumn, columnIndex) => {
            let currentColumn = invokerPanel.FindChildTraverse(`SpellColumn${columnIndex}`)
            skillColumn.forEach((skill, i) => {
                let spellCardRow = $.CreatePanel("Panel", currentColumn, `Row${i}`);
                spellCardRow.AddClass("SpellCardRow")

                let abilityImage = $.CreatePanel("DOTAAbilityImage", spellCardRow, "AbilityIcon");
                abilityImage.abilityname = skill.name;
                abilityImage.AddClass("AbilityMaxLevel")
                this.mouseOver(abilityImage, skill.name)

                skill.buttons.forEach((button, buttonIndex) => {
                    let panelKey = $.CreatePanel("Panel", spellCardRow, `KeyContainer${buttonIndex}`);
                    panelKey.AddClass("KeyContainer");
                    panelKey.AddClass(button === 'q' ? "QuasColor" :
                                      button === 'w' ? "WexColor"  :
                                                       "ExortColor");

                    let labelKey = $.CreatePanel("Label", panelKey, `InvokeKey${buttonIndex}`);
                    labelKey.AddClass("InvokeKey");
                    labelKey.text = button.toUpperCase()
                })

                let abilityName = $.CreatePanel("Label", spellCardRow, `AbilityName`);
                abilityName.text = $.Localize(`#DOTA_Tooltip_ability_${skill.name}`).toUpperCase()
            })
        })
        panelSetParent()
    }
    // checkPortraitUnit(){
    //     let unit = Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit())
    //     $.Msg(unit)
    //     let panel =FindDotaHudElement("InvokerSpellCardButtonCustom") 
    //     if(unit === "npc_dota_hero_invoker") {
    //         if(!this.parentSet) this.panelSetParent();
    //         panel.style.visibility = "visible";
    //     }
    //     else panel.style.visibility = "collapse";

    //     $.Schedule(0.5, this.checkPortraitUnit)
    // }
    mouseOver(panel, skill) {
        panel.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowAbilityTooltip', panel, skill) 
        });

        panel.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideAbilityTooltip', panel);
        });
    }
    // panelSetParent(){
    //     if(FindDotaHudElement("Ability5")) {
    //         $.GetContextPanel().FindChildTraverse("InvokerPanel").SetParent(FindDotaHudElement("lower_hud"))
    //         $.GetContextPanel().FindChildTraverse("InvokerSpellCardButtonCustom").SetParent(FindDotaHudElement("Ability5"))
    //         this.parentSet = true;
    //     }
    // }
}

function checkPortraitUnit() {
    let unit = Entities.GetUnitName(Players.GetLocalPlayerPortraitUnit())
    // $.Msg(unit)
    let panel = FindDotaHudElement("InvokerSpellCardButtonCustom") 
    if(unit === "npc_dota_hero_invoker") {
        if(!parentSet) panelSetParent();
        panel.style.visibility = "visible";
    }
    else panel.style.visibility = "collapse";
    $.Schedule(0.2, checkPortraitUnit)
}

function panelSetParent() {
    if(FindDotaHudElement("Ability5")) {
        $.GetContextPanel().FindChildTraverse("InvokerPanel").SetParent(FindDotaHudElement("lower_hud"))
        $.GetContextPanel().FindChildTraverse("InvokerSpellCardButtonCustom").SetParent(FindDotaHudElement("Ability5"))
        parentSet = true;
    }
}

function func()
{
    GameEvents.Subscribe_custom("initInvokerPanel", new_constructor)
}


function new_constructor()
{

    if (!invokerpanel)
        invokerpanel = new InvokerPanel() 
}


func()