--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");

var center_block = parentHUDElements.FindChildTraverse("center_block");
$.GetContextPanel().SetParent(center_block);

function Init()
{
	GameEvents.Subscribe_custom('ability_ogre_bloodlust', start_ogre)
}

Init()


var init_ogre = false

function start_ogre()
{
	if (init_ogre == true) return

	init_ogre = true
    $("#BuffPanel").RemoveClass("panel_hidden")
	UpdateHeroHudBuffs()
}
	

function UpdateHeroHudBuffs()
{
	let hero_id = Players.GetLocalPlayerPortraitUnit()
	let hero = Entities.GetUnitName(hero_id)
	
   	// Какой модификатор на каком месте
   	// Иконки прописываются в css
   	let modifier_1_id = HasModifier(hero_id, "modifier_ogre_magi_bloodlust_custom_legendary_1")
   	let modifier_2_id = HasModifier(hero_id, "modifier_ogre_magi_bloodlust_custom_legendary_2")
   	let modifier_3_id = HasModifier(hero_id, "modifier_ogre_magi_bloodlust_custom_legendary_3")
   	let modifier_4_id = HasModifier(hero_id, "modifier_ogre_magi_bloodlust_custom_legendary_4")
   	let modifier_main = HasModifier(hero_id, "modifier_ogre_magi_bloodlust_custom_buff")

   	SetShowText($("#Buff_1"), $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_1_Description"))
   	SetShowText($("#Buff_2"), $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_2_Description"))
   	SetShowText($("#Buff_3"), $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_3_Description"))
   	SetShowText($("#Buff_4"), $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_4_Description"))


   	let cooldown_time = 0


   	if (modifier_main)
   	{
    	cooldown_time = Math.ceil(Buffs.GetRemainingTime(hero_id, modifier_main))
    }
 
   	if ( modifier_1_id != false ) {
   		$("#Buff_1_icon").RemoveClass("DisableModifier")
   		$("#Buff_1_cooldown").text = String(cooldown_time)
   		$("#Buff_1_cooldown_border").AddClass("CooldownBorderActive")
   	} else {
		$("#Buff_1_icon").AddClass("DisableModifier")
		$("#Buff_1_cooldown").text = "" 
		$("#Buff_1_cooldown_border").RemoveClass("CooldownBorderActive")
   	}

   	if ( modifier_2_id != false ) {
   		$("#Buff_2_icon").RemoveClass("DisableModifier")
   		$("#Buff_2_cooldown").text = String(cooldown_time)
   		$("#Buff_2_cooldown_border").AddClass("CooldownBorderActive")
   	} else {
		$("#Buff_2_icon").AddClass("DisableModifier") 
		$("#Buff_2_cooldown").text = ""   	
		$("#Buff_2_cooldown_border").RemoveClass("CooldownBorderActive")	
   	}

   	if ( modifier_3_id != false ) {
   		$("#Buff_3_icon").RemoveClass("DisableModifier")
   		$("#Buff_3_cooldown").text = String(cooldown_time)
   		$("#Buff_3_cooldown_border").AddClass("CooldownBorderActive")
   	} else {
		$("#Buff_3_icon").AddClass("DisableModifier")   
		$("#Buff_3_cooldown").text = "" 	
		$("#Buff_3_cooldown_border").RemoveClass("CooldownBorderActive")	
   	}

   	if ( modifier_4_id != false ) {
   		$("#Buff_4_icon").RemoveClass("DisableModifier")
   		$("#Buff_4_cooldown").text = String(cooldown_time)
   		$("#Buff_4_cooldown_border").AddClass("CooldownBorderActive")
   	} else {
		$("#Buff_4_icon").AddClass("DisableModifier")   	
		$("#Buff_4_cooldown").text = "" 	
		$("#Buff_4_cooldown_border").RemoveClass("CooldownBorderActive")
   	}

	$.Schedule(0.2, UpdateHeroHudBuffs)
}

function SetShowText(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, Game.ShowTalentValues(text, "modifier_ogremagi_bloodlust_7", 1, false, false)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function HasModifier(unit, modifier) {
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return Entities.GetBuff(unit, i)
        }
    }
	return false
}