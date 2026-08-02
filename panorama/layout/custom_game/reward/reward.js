--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var mainPanel = $("#ss_main_panel")
var show_reward_notification = $("#show_reward_notification")
var Skills = []

show_reward_notification.visible = false
	
	
var AbilityTooltipOver = (function(pan,skill){
    return function(){
        $.DispatchEvent( "DOTAShowAbilityTooltip", pan, skill);
    }
});
var AbilityTooltipOut = (function(){
    return function(){
        $.DispatchEvent( "DOTAHideAbilityTooltip");
    }
});
var SkillClick = (function(SkillClass){
    return function(){
        let callback = {
            skill_name : SkillClass.getSkillName()
        }
        if(SkillClass.getAction() == 'add'){
            GameEvents.SendCustomGameEventToServer("select_skill_lua", callback)
        }
        mainPanel.visible = false
    }
})

class SingleSkill {
    constructor(place){
        this.place = place
        this.skill_name = null
        this.action = null
        this.skill_panel = $(`#skill_numb_${this.place}`)
        this.label_panel = $(`#skill_name_numb_${this.place}`)
    }
    update(skill_name, action){
        this.skill_name = skill_name
        this.action = action
        if(this.skill_name == null){
            this.skill_panel.visible = false
            this.label_panel.visible = false
            return
        }
        if(this.skill_panel){
            this.skill_panel.style.backgroundImage = `url("file://{resources}/images/custom_game/reward/`+ skill_name + `.png")` ;
            this.skill_panel.style.backgroundSize = "100%";
            this.skill_panel.SetPanelEvent("onmouseactivate", SkillClick( this ))
            this.skill_panel.visible = true
        }
        if(this.label_panel){
            this.label_panel.text = $.Localize("#"+this.skill_name)
            this.label_panel.visible = true
        }
    }
    getSkillName(){
        return this.skill_name
    }
    getSkillPlace(){
        return this.place
    }
    getAction(){
        return this.action
    }
}

function show_skills_js(t){
	if (mainPanel.visible) return
    for(var i = 1; i <= 3; i++){
        let skill = t[i]
        Skills[i].update(skill, 'add')
    }
    mainPanel.visible = true
}

function show_reward_notifications(t){
	show_reward_notification.visible = true
	var rp = $("#rp_not")
	var exp = $("#exp_not")
	var guild = $("#guild_not")
	rp.visible = false
	exp.visible = false
	guild.visible = false
	if(t.rp > 0){
		rp.visible = true
		$("#rp_not_text").text = "+"+t.rp
	}
	if(t.expa > 0){
		exp.visible = true
		$("#exp_not_text").text = "+"+t.expa
	}
	if(t.guild_exp > 0){
		guild.visible = true
		$("#guild_not_text").text = "+"+t.guild_exp
	}
	Game.EmitSound("ui.trophy_levelup")
	$.Schedule(3, function(){
		show_reward_notification.visible = false
    });
}


(function() {
    mainPanel.visible = false
    for(var i = 1; i <= 3; i++){
        Skills[i] = new SingleSkill(i)
    }
    GameEvents.Subscribe("show_skills_js", show_skills_js);
    GameEvents.Subscribe("show_reward_notifications", show_reward_notifications);
})();

