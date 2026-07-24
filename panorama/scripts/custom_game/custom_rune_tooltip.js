--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const DotaHUD = GetDotaHud();
const MAIN_PANEL = $.GetContextPanel()

let UISCALE_X = 1;
let UISCALE_Y = 1;

function SetupTooltip(){
    let ItemName = MAIN_PANEL.GetAttributeString("name", "")
    let Absx = Number(MAIN_PANEL.GetAttributeInt("x", 0))
    let Absy = Number(MAIN_PANEL.GetAttributeInt("y", 0))

    UISCALE_X = DotaHUD.actualuiscale_x;
    UISCALE_Y = DotaHUD.actualuiscale_y;
    
    let Tooltip = FindDotaHudElement("CustomRuneTooltip")
    if(Tooltip){
        Tooltip.style.transform = `translate3d(0px, 0px, 0px)`
        Tooltip.style.x = `-9000px`
        Tooltip.style.y = `-9000px`

        Tooltip.style.overflow = "noclip"
        Tooltip.style["pre-transform-scale2d"] = "1"
    }

    $.Schedule(0.01, function(){
    	let Tooltip = FindDotaHudElement("CustomRuneTooltip")
    	if(Tooltip){
    		let width = Tooltip.actuallayoutwidth / UISCALE_X;
    		let height = Tooltip.actuallayoutheight / UISCALE_Y;
            Tooltip.style.x = `0px`
            Tooltip.style.y = `0px`
            Tooltip.style["pre-transform-scale2d"] = "1"

            let x = Math.floor((Absx - (width/2 * UISCALE_Y)) / UISCALE_X);
            let y = Math.floor((Absy - (height + 60 * UISCALE_Y)) / UISCALE_Y);

    		Tooltip.style.transform = `translate3d(${x}px, ${y}px, 0px)`
    	}
    })

    MAIN_PANEL.SetDialogVariable("name", $.Localize(`#CUSTOM_RUNE_${ItemName}`))
    MAIN_PANEL.SetDialogVariable("desc", $.Localize(`#CUSTOM_RUNE_${ItemName}_desc`))

    MAIN_PANEL.SetHasClass("Haste", ItemName == "item_custom_rune_haste")
    MAIN_PANEL.SetHasClass("DoubleDamage", ItemName == "item_custom_rune_double_damage")
    MAIN_PANEL.SetHasClass("Illusion", ItemName == "item_custom_rune_illusion")
    MAIN_PANEL.SetHasClass("Invisibility", ItemName == "item_custom_rune_invisibility")
    MAIN_PANEL.SetHasClass("Regeneration", ItemName == "item_custom_rune_regeneration")
    MAIN_PANEL.SetHasClass("Arcane", ItemName == "item_custom_rune_arcane")
    MAIN_PANEL.SetHasClass("Shield", ItemName == "item_custom_rune_shield")
}