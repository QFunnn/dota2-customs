--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/* 
	TI9竞猜
*/ 

var MY_BET_TEAM = null;
var MY_TEAM = null;
var BUTTON_ON = true;
function ShowEventTI9(){
    $('#panel_event_ti9_outer').SetHasClass('hide',false);
    Game.EmitSound("dac.event.ti9");
    update_bet();
}
function update_bet(team){
	if (team){
		MY_TEAM = parseInt(team);
	}
    if (MY_TEAM && !isNaN(MY_TEAM)){
    	BUTTON_ON = false;
    	var my_team_name = TI9_TEAM_LIST[MY_TEAM].name;
    	var my_team_pic = TI9_TEAM_LIST[MY_TEAM].pic;
    	var my_team_bouns = Math.floor(TI9_TEAM_LIST[MY_TEAM].bet_rate * 50);
    	$('#text_ti9_my_team').text = my_team_name;
    	$('#img_ti9_my_team').SetImage(my_team_pic);
    	$('#text_ti9_my_bonus').text = '× '+my_team_bouns;
    	$('#text_ti9_my_team_title').text = $.Localize('#'+'ti9_my_bet');
    	$('#button_ti9_bet').SetHasClass('invisible',true);
    	$('#text_ti9_my_bonus').SetHasClass('invisible',false);
    	$('#img_ti9_my_bonus_candy').SetHasClass('invisible',false);
    	$('#text_ti9_my_bonus_title').SetHasClass('invisible',false);
    }
    else{
    	BUTTON_ON = true;
    	$('#text_ti9_my_bonus').SetHasClass('invisible',true);
    	$('#img_ti9_my_bonus_candy').SetHasClass('invisible',true);
    	$('#text_ti9_my_bonus_title').SetHasClass('invisible',true);
    	$('#text_ti9_my_team_title').text = $.Localize('#'+'ti9_my_bet_alt');
    }
}
function close_panel_event_ti9(){
	$('#panel_event_ti9_outer').SetHasClass('hide',true);
	Game.EmitSound("Shop.PanelUp");
}

function PickTI9Team(id){
	if (MY_TEAM != null){
		return;
	}
	var team_name = TI9_TEAM_LIST[id].name;
	var team_pic = TI9_TEAM_LIST[id].pic;
	$('#text_ti9_my_team').text = team_name;
	$('#img_ti9_my_team').SetImage(team_pic);
	$('#text_ti9_my_team_title').text = $.Localize('#'+'ti9_my_bet');
	MY_BET_TEAM = id;
	$('#button_ti9_bet').SetHasClass('unavailable',false);
	Game.EmitSound('ui.npe_objective_given');
}
function ConfirmBet(){
	if (MY_BET_TEAM && BUTTON_ON){
		BUTTON_ON = false;
		$('#button_ti9_bet').SetHasClass('unavailable',true);

		var local_id = Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid;
		var url = 'http://gemtd.ppbizon.com/ti9/bet/@'+ local_id + '@'+MY_BET_TEAM+'?hehe='+ Math.random();
	    $.AsyncWebRequest(url, 
	    { 
	        type: 'GET',
	        success: function(a) { 
	        	var data = JSON.parse(a);
	        	if (data.err == 0){
	        		show_msg($.Localize('#'+"bet_success"));
	        		update_bet(data.team);
	        		$("#store_shell_count").text = "× "+data.shell || "0";
	        	}
	        	else if (data.err == 1005){
	        		show_msg($.Localize('#'+"no_enough_shell"));
	        		BUTTON_ON = true;
	        		$('#button_ti9_bet').SetHasClass('unavailable',false);
	        	}
	        	else{
	        		show_msg($.Localize('#'+"bet_fail"));
	        		BUTTON_ON = true;
	        		$('#button_ti9_bet').SetHasClass('unavailable',false);
	        	}
	        },
	        error: function() {
	        	show_msg($.Localize('#'+"bet_fail"));
	        	BUTTON_ON = true;
	        	$('#button_ti9_bet').SetHasClass('unavailable',false);
	        }
	    });
	}
}
var TI9_TEAM_LIST = {
	1:{
		name:'Team Secret',
		pic:'file://{images}/teams/1838315.png',
		bet_rate: 3.75,
	},
	2:{
		name:'ViCi Gaming',
		pic:'file://{images}/teams/726228.png',
		bet_rate: 4.2,
	},
	3:{
		name:'Team Liquid',
		pic:'file://{images}/teams/2163.png',
		bet_rate: 5.5,
	},
	4:{
		name:'Virtus Pro',
		pic:'file://{images}/teams/1883502.png',
		bet_rate: 7.5,
	},
	5:{
		name:'PSG LGD',
		pic:'file://{images}/teams/15.png',
		bet_rate: 8,
	},
	6:{
		name:'Evil Geniuses',
		pic:'file://{images}/teams/39.png',
		bet_rate: 13,
	},
	7:{
		name:'Team OG',
		pic:'file://{images}/teams/2586976.png',
		bet_rate: 21,
	},
	8:{
		name:'TNC Predator',
		pic:'file://{images}/teams/2108395.png',
		bet_rate: 26,
	},
	9:{
		name:'Fnatic',
		pic:'file://{images}/teams/350190.png',
		bet_rate: 51,
	},
	10:{
		name:'Team NIP',
		pic:'file://{images}/teams/6214973.png',
		bet_rate: 51,
	},
	11:{
		name:'Keen Gaming',
		pic:'file://{images}/teams/2626685.png',
		bet_rate: 67,
	},
	12:{
		name:'Team RNG',
		pic:'file://{images}/teams/6209804.png',
		bet_rate: 81,
	},
	13:{
		name:'Alliance',
		pic:'file://{images}/teams/111474.png',
		bet_rate: 151,
	},
	14:{
		name:'Chaos Esports',
		pic:'file://{images}/teams/7203342.png',
		bet_rate: 151,
	},
	15:{
		name:'Newbee',
		pic:'file://{images}/teams/6214538.png',
		bet_rate: 151,
	},
	16:{
		name:'Natus Vincere',
		pic:'file://{images}/teams/36.png',
		bet_rate: 201,
	},
	17:{
		name:'Mineski',
		pic:'file://{images}/teams/543897.png',
		bet_rate: 251,
	},
	18:{
		name:'Infamous',
		pic:'file://{images}/teams/2672298.png',
		bet_rate: 1001,
	},
}