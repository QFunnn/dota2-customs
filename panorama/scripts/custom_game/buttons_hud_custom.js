--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
var center_block = parentHUDElements.FindChildTraverse("center_with_stats")
var center_block_top = parentHUDElements.FindChildTraverse("center_block")

var buffs =  parentHUDElements.FindChildTraverse("buffs")
var debuffs = parentHUDElements.FindChildTraverse("debuffs")
CreateAllButtons()


var obs_bind = DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP5
var sentry_bind = DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP6
var dust_bind = DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP7


var default_button_for_dust
var default_button_for_observer
var default_button_for_sentry

function CreateAllButtons()
{

	buffs.style.marginBottom = "176px"
	debuffs.style.marginBottom = "176px"

	for (var i = 0; i < center_block.GetChildCount(); i++) 
	{
		if (center_block.GetChild(i).id == "RightPanel") 
			center_block.GetChild(i).DeleteAsync(0)
	}

	for (var i = 0; i < center_block_top.GetChildCount(); i++) 
	{
		if (center_block_top.GetChild(i).id == "TopPanel")
			center_block_top.GetChild(i).DeleteAsync(0)
	}

	var RightPanel = $.GetContextPanel().FindChildTraverse("RightPanel")
	var TopPanel = $.GetContextPanel().FindChildTraverse("TopPanel")

	RightPanel.SetParent(center_block)
	TopPanel.SetParent(center_block_top)

	var InfoButton = RightPanel.FindChildTraverse("InfoButton")
	SetShowText(InfoButton, "info_custom_buttons")

	var ObserverWardMain = RightPanel.FindChildTraverse("ObserverWard")

	var ObserverWardButtonHotkey = ObserverWardMain.FindChildTraverse("ObserverWardHotkey")
	var ObserverWardHotkeyLabel = ObserverWardMain.FindChildTraverse("ObserverWardHotkeyText")
	var ObserverCooldownLabel = ObserverWardMain.FindChildTraverse("ObserverCooldownLabel")
	var ObserverWard =  ObserverWardMain.FindChildTraverse("ObserverWardIcon")
	var ObserverWardCount =  ObserverWardMain.FindChildTraverse("ObserverWardCount")

	var SentryWardMain = RightPanel.FindChildTraverse("SentryWard")
	var SentryWardButtonHotkey = SentryWardMain.FindChildTraverse("SentryWardHotkey")
	var SentryWardHotkeyLabel = SentryWardMain.FindChildTraverse("SentryWardHotkeyText")
	var SentryCooldownLabel = SentryWardMain.FindChildTraverse("SentryCooldownLabel")
	var SentryWard =  SentryWardMain.FindChildTraverse("SentryWardIcon")
	var SentryWardCount =  SentryWardMain.FindChildTraverse("SentryWardCount")

	var SmokeMain = TopPanel.FindChildTraverse("SmokeMain")
	var SmokeButtonHotkey = SmokeMain.FindChildTraverse("SmokeButtonHotkey")
	var SmokeHotkeyLabel = SmokeMain.FindChildTraverse("SmokeHotkeyLabel")
	var SmokeCooldownLabel = SmokeMain.FindChildTraverse("SmokeCooldownLabel")
	var SmokePanel = SmokeMain.FindChildTraverse("SmokeIcon")
	var SmokeCount = SmokeMain.FindChildTraverse("SmokeCount")

	var DustMain = TopPanel.FindChildTraverse("DustMain")
	var DustButtonHotkey = DustMain.FindChildTraverse("DustButtonHotkey")
	var DustHotkeyLabel = DustMain.FindChildTraverse("DustHotkeyLabel")
	var DustCooldownLabel = DustMain.FindChildTraverse("DustCooldownLabel")
	var DustPanel = DustMain.FindChildTraverse("DustIcon")
	var DustCount = DustMain.FindChildTraverse("DustCount")

	SetButtonEvent(ObserverWardMain, "custom_ability_observer")
	SetButtonEvent(SentryWardMain, "custom_ability_sentry")
	SetButtonEvent(SmokeMain, "custom_ability_smoke")
	SetButtonEvent(DustMain, "custom_ability_dust")

	$.CreatePanel("DOTAItemImage", ObserverWard, "ward_image", { style: "width:100%;height:100%;", itemname: "item_ward_observer" });
	$.CreatePanel("DOTAItemImage", SentryWard, "ward_image", { style: "width:100%;height:100%;", itemname: "item_ward_sentry" });
	$.CreatePanel("DOTAItemImage", SmokePanel, "smoke_image", { style: "width:100%;height:100%;", itemname: "item_smoke_of_deceit" });
	$.CreatePanel("DOTAItemImage", DustPanel, "dust_image", { style: "width:100%;height:100%;", itemname: "item_dust" });

	ButtonsUpdate()
}

function ConvertTime(time)
{
	var min = Math.trunc((time)/60) 
	var sec_n =  (time) - 60*Math.trunc((time)/60) 
	var hour = String( Math.trunc((min)/60) )
	var min = String(min - 60*( Math.trunc(min/60) ))
	var sec = String(sec_n)
	if (sec_n < 10) 
	{
		sec = '0' + sec
	}

	return (min + ':' + sec)
}



function ButtonsUpdate() 
{
	var AllCustomButtons = center_block.FindChildTraverse("AllCustomButtons")
	var AllCustomButtonsTop = center_block_top.FindChildTraverse("AllCustomButtonsTop")

	let local_id = Game.GetLocalPlayerID()
	let entindex = Players.GetPlayerHeroEntityIndex(local_id)


	//if (Players.GetLocalPlayerPortraitUnit() != entindex ) 
	//{
	//	AllCustomButtons.visible = false
	//} else 
//	{
	//	AllCustomButtons.visible = true
//	}

//	if (Players.GetLocalPlayerPortraitUnit() != entindex ) 
//	{
	//	AllCustomButtonsTop.visible = false
//	} else 
//	{
	//	AllCustomButtonsTop.visible = true
	//}

	center_block_top.style.paddingLeft = "0px"
	center_block_top.style.paddingRight = "0px"


	var ObserverCooldownLabel = center_block.FindChildTraverse("ObserverCooldownLabel")
	var SentryCooldownLabel = center_block.FindChildTraverse("SentryCooldownLabel")
	var SmokeCooldownLabel = center_block_top.FindChildTraverse("SmokeCooldownLabel")

	var observer_button_label = center_block.FindChildTraverse("ObserverWardCount")
	var sentry_button_label = center_block.FindChildTraverse("SentryWardCount")
	var smoke_button_label = center_block_top.FindChildTraverse("SmokeCount")
	var dust_button_label = center_block_top.FindChildTraverse("DustCount")

	var ObserverWardHotkeyLabel = center_block.FindChildTraverse("ObserverWardHotkeyText")
	var SentryWardHotkeyLabel = center_block.FindChildTraverse("SentryWardHotkeyText")
	var SmokeHotkeyLabel = center_block.FindChildTraverse("SmokeHotkeyLabel")
	var DustHotkeyLabel = center_block.FindChildTraverse("DustHotkeyLabel")


    SentryWardHotkeyLabel.text = String(GetGameKeybind(sentry_bind)).toUpperCase()
    ObserverWardHotkeyLabel.text = String(GetGameKeybind(obs_bind)).toUpperCase()
    DustHotkeyLabel.text = String(GetGameKeybind(dust_bind)).toUpperCase()

	if (default_button_for_dust != GetGameKeybind(dust_bind) ) {
		RegisterKeybindDust()
	}

	if (default_button_for_observer != GetGameKeybind(obs_bind) ) {
		RegisterKeybindObserver()
	}

	if (default_button_for_sentry != GetGameKeybind(sentry_bind) ) {
		RegisterKeybindSentry()
	}

	let obs_ability = Entities.GetAbilityByName(entindex, "custom_ability_observer")
	let sentry_ability = Entities.GetAbilityByName(entindex, "custom_ability_sentry")
	let smoke_ability = Entities.GetAbilityByName(entindex, "custom_ability_smoke")
	let dust_ability = Entities.GetAbilityByName(entindex, "custom_ability_dust")

	if (obs_ability > -1)
	{
		var time = 0
		let max = Abilities.GetSpecialValueFor(obs_ability, "max")
		if (Game.GetGameMode() == 2)
			max = Abilities.GetSpecialValueFor(obs_ability, "max_duo")

		let stack = HowStacks("modifier_item_custom_observer_ward_charges")

        let modifier = FindModifier(entindex, "modifier_item_custom_observer_ward_charges")
        if (modifier != "No")
        {
            let check_time = Number(Buffs.GetRemainingTime(entindex, modifier))
            if (check_time > 0)
              time = Math.ceil(check_time)        
        }

        ObserverCooldownLabel.text = ConvertTime(time)
		observer_button_label.text = String(stack)
		ObserverCooldownLabel.visible = (stack < max) 
	}

	if (sentry_ability > -1)
	{
		var time = 0
		let max = Abilities.GetSpecialValueFor(sentry_ability, "max")
		if (Game.GetGameMode() == 2)
			max = Abilities.GetSpecialValueFor(obs_ability, "max_duo")

		let stack = HowStacks("modifier_item_custom_sentry_ward_charges")

        let modifier = FindModifier(entindex, "modifier_item_custom_sentry_ward_charges")
        if (modifier != "No")
        {
            let check_time = Number(Buffs.GetRemainingTime(entindex, modifier))
            if (check_time > 0)
            {
                time = Math.ceil(check_time)
            }
        }

        SentryCooldownLabel.text = ConvertTime(time)
		sentry_button_label.text = String(stack)
		SentryCooldownLabel.visible =  (stack < max) 
	}

	if (smoke_ability > -1)
	{
		var time = 0
		let max = Abilities.GetSpecialValueFor(smoke_ability, "max")
		if (Game.GetGameMode() == 2)
			max = Abilities.GetSpecialValueFor(obs_ability, "max_duo")
		
		let stack = HowStacks("modifier_item_custom_smoke_charges")

        let modifier = FindModifier(entindex, "modifier_item_custom_smoke_charges")
        if (modifier != "No")
        {
            let check_time = Number(Buffs.GetRemainingTime(entindex, modifier))
            if (check_time > 0)
            {
                time = Math.ceil(check_time)
            }
        }

        SmokeCooldownLabel.text = ConvertTime(time)
		smoke_button_label.text = String(stack)
		SmokeCooldownLabel.visible =  (stack < max) 
	}

	if (dust_ability > -1)
	{
		dust_button_label.text = String(HowStacks("modifier_item_custom_dust_charges"))
	}

	$.Schedule( 1, ButtonsUpdate );
}




function CastAbility(name)
{
	let entindex = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())
	let ability = Entities.GetAbilityByName(entindex, name)
	if (ability > -1)
	{
    	Abilities.ExecuteAbility(ability, entindex, false);
		if (name == "custom_ability_observer" || name == "custom_ability_sentry")
		{
    		init_particle()
		}
	}
}

function ClearBind()
{

}


function RegisterKeybindDust() 
{
    const name_bind = "use_dust" + Math.floor(Math.random() * 99999);
    Game.AddCommand(name_bind, function(){CastAbility("custom_ability_dust")} , "", 0);
    Game.CreateCustomKeyBind(GetGameKeybind(dust_bind), name_bind);
    default_button_for_dust = GetGameKeybind(dust_bind)
}

function RegisterKeybindObserver() 
{
    const name_bind = "use_observer" + Math.floor(Math.random() * 99999);
    Game.AddCommand(name_bind, function(){CastAbility("custom_ability_observer")}, "", 0);


    Game.CreateCustomKeyBind(GetGameKeybind(obs_bind), name_bind);
    default_button_for_observer = GetGameKeybind(obs_bind)
}

function RegisterKeybindSentry() 
{
    const name_bind = "use_sentry" + Math.floor(Math.random() * 99999);
    Game.AddCommand(name_bind, function(){CastAbility("custom_ability_sentry")}, "", 0);
    Game.CreateCustomKeyBind(GetGameKeybind(sentry_bind), name_bind);
    default_button_for_sentry = GetGameKeybind(sentry_bind)
}

function GetGameKeybind(command) 
{
    if (command != undefined)
    {
        return Game.GetKeybindForCommand(command);
    }
}


function SetShowText(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#" + text)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}



function HasModifier(unit, modifier) {
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return true
        }
    }
    return false
}

function FindModifier(unit, modifier) {
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return Entities.GetBuff(unit, i);
        }
    }
    return "No"
}

function HowStacks(mod) {

	var hero = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )

	for (var i = 0; i < Entities.GetNumBuffs(hero); i++) {
		var buffID = Entities.GetBuff(hero, i)
		if (Buffs.GetName(hero, buffID ) == mod ){
			var stack = Buffs.GetStackCount(hero, buffID ) 
			return stack
		}
	}
	return 0
}



function SetButtonEvent(panel, ability)
{
    panel.SetPanelEvent('onmouseactivate', function() 
    {
    	CastAbility(ability)
  	});    
    panel.SetPanelEvent('oncontextmenu', function() 
    {
    	CastAbility(ability)  
  	});    
}












var currently_active = 0
var ParticleWard = undefined;
var lastAbilityWard = -1;

function init_particle()
{
	if (currently_active == 1) return

	currently_active = 1
    $.Schedule(0.05, WardParticlesUpdate)
}


function WardParticlesUpdate()
{
	let active_ability = Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility())
	let interval = 0.01

	if (active_ability != lastAbilityWard) 
	{
		lastAbilityWard = active_ability
		if (ParticleWard) 
		{
			Particles.DestroyParticleEffect(ParticleWard, true)
			ParticleWard = undefined;
		}
	}

	if (active_ability == "custom_ability_observer" || active_ability == "custom_ability_sentry")
	{
		let entindex = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())


		if (ParticleWard == undefined) 
		{
			ParticleWard = Particles.CreateParticle("particles/ui_mouseactions/range_finder_ward_aoe.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, entindex );
		}

		if (ParticleWard)
		{
			const cursor = GameUI.GetCursorPosition();
			const worldPosition = GameUI.GetScreenWorldPosition(cursor);
			Particles.SetParticleControl(ParticleWard, 0, Entities.GetAbsOrigin( entindex ));
			Particles.SetParticleControl(ParticleWard, 1, [ 255, 255, 255 ]);
			Particles.SetParticleControl(ParticleWard, 6, [ 255, 255, 255 ]);
		    Particles.SetParticleControl(ParticleWard, 2, worldPosition);
		    
			if (active_ability == "custom_ability_observer") 
			{
				Particles.SetParticleControl(ParticleWard, 11, [ 0, 0, 0 ]);
				Particles.SetParticleControl(ParticleWard, 3, [ 1600, 1600, 1600 ]);
				
			} else if (active_ability == "custom_ability_sentry")  
			{
				Particles.SetParticleControl(ParticleWard, 11, [ 1, 0, 0 ]); 
				Particles.SetParticleControl(ParticleWard, 3, [ 700, 700, 700 ]);
			}
		}
	}else
	{	
		currently_active = 0
		return
	}
    $.Schedule(0.01, WardParticlesUpdate)
}