--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var invopened = false;
var every_day = $('#Gold_everyday_reward_lock')
var every_day_button = $('#Gold_everyday_reward')
var main = $("#BP_container")
BuyBP = $('#BuyBP')
ShowReward = $('#ShowReward')
BuyControl = $('#BuyControl')
BuyControl.visible = false
ShowReward.visible = false
var c = 0
var timerId
const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
DotaHUD.windowControllers["bp"] = {
    is_open: false,
    open: function(){
        GameEvents.SendCustomGameEventToServer("get_bp", {})
    },
    close: function(){
        main.visible = false;
    }
}
DotaHUD.ListenToMouseEvent(
    DotaHUD.GetCloseWindowOnOutsideClick(main, "bp")
);

let sound_tick;

main.visible = false;


var steamID = Game.GetPlayerInfo(Game.GetLocalPlayerID()).player_steamid;

function open() {
	if(DotaHUD.IsWindowOpen("bp")){
		DotaHUD.WindowClose("bp");
	}else{
		DotaHUD.WindowOpen("bp");
	}
}


function close(){
	main.visible = false;
	invopened = false;
}

function bp_init(t) {
	quest = $("#BP_content_top_right");
    quest.RemoveAndDeleteChildren();

    $.Msg(t.user_reward)
	
	const sortedQuestsData = Object.entries(t.quests_data);

	sortedQuestsData.sort((a, b) => a[1].reward - b[1].reward);

	for (const [key, reward] of sortedQuestsData) {
		var PassPanel = $.CreatePanel("Panel", quest, "Pass_Panel_" + key);
		PassPanel.BLoadLayoutSnippet("quest_content");
		const reward = t.quests_data[key];
		if (key.includes('damage_quest')){
			PassPanel.FindChildInLayoutFile("Player_quest_image").style.backgroundImage = "url('file://{resources}/images/bp/quests/damage_quest.png')";
			PassPanel.FindChildInLayoutFile("Player_quest_image_desc").text = $.Localize("#deal_damage_quest")+" "+ reward.target
		}else if (key.includes('heal_quest')){
			PassPanel.FindChildInLayoutFile("Player_quest_image").style.backgroundImage = "url('file://{resources}/images/bp/quests/heal.png')";
			PassPanel.FindChildInLayoutFile("Player_quest_image_desc").text = $.Localize("#heal_quest")+" "+ reward.target	
		}else if (key.includes('bless_quest') || key.includes('soul_quest')){
			PassPanel.FindChildInLayoutFile("Player_quest_image").style.backgroundImage = "url('file://{resources}/images/bp/quests/"+key+".png')";
			PassPanel.FindChildInLayoutFile("Player_quest_image_desc").text = $.Localize("#use_quest")+" "+ reward.target + " " + $.Localize("#"+key)
		}else{
			PassPanel.FindChildInLayoutFile("Player_quest_image").style.backgroundImage = "url('file://{resources}/images/bp/quests/npc_custom.png')";
			PassPanel.FindChildInLayoutFile("Player_quest_image_desc").text = $.Localize("#kill_quest")+" "+ reward.target + " " + $.Localize("#"+key)
		}
		PassPanel.FindChildInLayoutFile("Player_quest_image_progress").text = reward.count + "/" + reward.target
		PassPanel.FindChildInLayoutFile("MMMRPointsLabel").text = reward.reward
		PassPanel.FindChildInLayoutFile("done").visible = false
		if(reward.target == reward.count){
			PassPanel.FindChildInLayoutFile("done").visible = true
		}
		
	}
	
    invopened = !invopened;
    $("#BP_icon").steamid = steamID;
    $("#BP_name").steamid = steamID;
	
    var tab = GetHeroLevel(t.exp);
    var pan = $('#BP_exp_icon');

    $('#BP_icon_pr_bar').style.width = (198 / 100 * tab.percent) + "px";
    $('#BP_icon_lvl_text').text = t.level - 1
	$('#Gold_everyday_reward_text').text = t.subscriber_reward
	
	every_day_button.ClearPanelEvent("onmouseactivate");
	if (t.subscriber === 0) {
		every_day.visible = true;
	}else{
		BuyBP.visible = false
		every_day.visible = false;
		if (t.subscriber_reward > 0) {
			every_day_button.SetPanelEvent("onmouseactivate", function () {
				AddEveryDayReward(t.subscriber_reward);
			});
		}
	}
	
    pan.SetPanelEvent("onmouseover", function() { $.DispatchEvent("DOTAShowTextTooltip", pan, $.Localize(tab.nexp + " из " + tab.need)); });
    pan.SetPanelEvent("onmouseout", TipsOut);

    var user_reward = t.user_reward;
	
    panel = $("#BP_content_bottom");
    panel.RemoveAndDeleteChildren();

    main.visible = true;

    for (const i of Object.keys(t.rewards)) {
        const reward = t.rewards[i];

        $.Msg(reward, i)

        var PassPanel = $.CreatePanel("Panel", panel, "Pass_Panel_" + i);
        PassPanel.BLoadLayoutSnippet("pass_container");
        PassPanel.FindChildInLayoutFile("pass_content_level_simple").text = i;
		PassPanel.FindChildInLayoutFile("pass_content_image_lock").visible = true
		if (t.subscriber === 1) {
            PassPanel.FindChildInLayoutFile("pass_content_image_lock").visible = false;
        }
		var item = PassPanel.FindChildInLayoutFile("pass_content_image_simple");
		var image = PassPanel.FindChildInLayoutFile("pass_content_image_simple_image");
		var reward_bp = PassPanel.FindChildInLayoutFile("free_bp");
		if (reward['reward'].includes('item')){
			image.visible = false
			item.visible = true
			item.itemname = reward['reward']
		}else{
			image.visible = true
			item.visible = false
			image.SetImage('file://{resources}/images/bp/rew/' + reward['reward'] + '.png');
			
			
		
			(function(reward_bp, t) {
				reward_bp.SetPanelEvent("onmouseover", function() {
					$.DispatchEvent("DOTAShowTextTooltip", reward_bp, $.Localize('#'+t));
				});
				reward_bp.SetPanelEvent("onmouseout", TipsOut);
			})(reward_bp, reward['reward']);
		}
    
        if (user_reward[i] && user_reward[i]['reward'] === 0) {
            reward_bp.AddClass('pass_content_back_simple');
            var send_reward = reward['reward'];
            const ButtonHandler = function(send_reward, reward_bp, i) {
                return function() {
                    TakeReward(reward['reward'], reward_bp, i);
                };
            };
            PassPanel.SetPanelEvent("onmouseactivate", ButtonHandler(reward['reward'], reward_bp, i));
        } else {
            reward_bp.ClearPanelEvent("onmouseactivate");
        }
    }
}

function updateValue(count) {
    count -= 1;
    if (count < 0) {
        $.Schedule(0.01, function () {
            // $.Msg("Значение достигло 0");
			Game.StopSound(sound_tick);
			Game.EmitSound("Plus.shards_tally");
        });
    } else {
        $('#Gold_everyday_reward_text').text = count;
        $.Schedule(0.01, function () {
            updateValue(count);
        });
    }
}

function AddEveryDayReward(count) {
    every_day_button.ClearPanelEvent("onmouseactivate");
	sound_tick = Game.EmitSound("Shards.Count");	
	GameEvents.SendCustomGameEventToServer("add_green_day_rewards", {count})
    updateValue(count);
}


function TakeReward(reward, button, level) {
	 button.ClearPanelEvent("onmouseactivate")
	 button.RemoveClass('pass_content_back_simple')
	 GameEvents.SendCustomGameEventToServer("TakeReward", {reward, level})
}


function GetHeroLevel(experience){
	var experienceNeeded = 500
	var pervLevel = 0
	var nextLevel = 500
	var now_exp = experience
	var level = 1
	while (experience >= experienceNeeded){
		experience = experience - experienceNeeded
		level = level + 1
		pervLevel = pervLevel + experienceNeeded
		experienceNeeded = experienceNeeded + 250
		nextLevel = nextLevel + experienceNeeded
	}	
	var need = nextLevel-pervLevel
	var nexp = now_exp-pervLevel
	var percent = Math.floor(now_exp-pervLevel)/(nextLevel-pervLevel)*100
	return {level:level, percent:percent, need:need, nexp:nexp}
}


function buy_control(){
	open()
	BuyControl.visible = true
}

function buy_control_close(){
	open()
	BuyControl.visible = false
}

function buy(cur){
	BuyControl.visible = false
	// $.Msg('buy bp')
	GameEvents.SendCustomGameEventToServer("buy_bp", {cur:cur})
}


(function(){
	GameEvents.Subscribe( "bp_init",bp_init)
})();


function TipsOver(message, pos)
{
    if ($("#"+pos) != undefined)
    {
       $.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize("#"+message));
    }
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip");
    $.DispatchEvent( "DOTAHideTextTooltip");
}


function Show_reward(tab) {
    var items = tab.items;
    ShowReward.visible = true;

    var image = ShowReward.FindChildInLayoutFile("reward_image");
    var item_image = ShowReward.FindChildInLayoutFile("reward_item_image");
    var label = ShowReward.FindChildInLayoutFile("reward_item_label");

    ShowReward.RemoveClass("animate-show");
    ShowReward.style.transform = 'scale3d(0, 0, 0)';
    ShowReward.AddClass("animate-show");

    function updateReward(imagePath, labelText, hideItemImage = true) {
        image.visible = true;
        image.SetImage(imagePath);
        item_image.visible = !hideItemImage;
        label.text = labelText;
    }

    if (tab.guild_exp > 0) {
        updateReward('file://{resources}/images/bp/rew/guild_exp_50.png', "+" + tab.guild_exp);
    }

    if (tab.rp_back > 0) {
        updateReward('file://{resources}/images/bp/rew/rp_25.png', "+" + tab.rp_back);
    }

    if (tab.acc_exp > 0) {
        updateReward('file://{resources}/images/bp/rew/account_exp_150.png', "+" + tab.acc_exp);
    }

    if (tab.bless > 0) {
        updateReward('file://{resources}/images/bp/rew/bless.png', "+" + tab.bless);
    }

    if (tab.soul > 0) {
        updateReward('file://{resources}/images/bp/rew/soul.png', "+" + tab.soul);
    }

    for (var key in items) {
        if (items.hasOwnProperty(key)) {
            var value = items[key];
            item_image.visible = true;
            item_image.itemname = key;
            label.text = $.Localize("#DOTA_Tooltip_ability_") + key;

            if (value > 0) {
                updateReward('file://{resources}/images/bp/rew/rp_25.png', "+" + value, false);
            }
        }
    }

    if (!timerId) {
        timerId = $.Schedule(1, timer);
    }
}

function timer() {
    $.Schedule(1, function() {
        if (c > 2) {
            ShowReward.visible = false;
			timerId = null
        } else {
			c++;
            timer()
        }
    });
}


(function () {
	GameEvents.Subscribe("Show_reward", Show_reward);
    GameUI.LoopTime.Schedule(0.0, ()=>{
		DotaHUD.CreateTopBarButton("file://{images}/bp/bpopen.png", "bp", open, "bp");
	});
})();


























