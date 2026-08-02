--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var main = $("#RatingPanel")
var Diff_description = $("#Diff_description")
var Diff_choise = $("#Diff_choise")
var Diff_description = $("#Diff_description")
var show_mode

function openButton()
{
	main.ToggleClass("hidden")
	GameEvents.SendCustomGameEventToServer("get_game_rating", {})
}

function closeButton()
{
	main.ToggleClass("hidden")
}

function opn(num){
	for(var i = 1; i <= 13; i++){
		var panel = $('#Mode_container_'+show_mode).FindChildTraverse('Diff_Panel_'+i) //$('#Diff_Panel_' + i)
		var panel_bnt = $('#TabPanel_' + i)
		if (panel){
			panel.visible = false
			panel_bnt.RemoveClass('selected_bd')
		}
	}
	var show = $('#Mode_container_'+show_mode).FindChildTraverse('Diff_Panel_'+num)//$('#Diff_Panel_' + num)
	var panel_bnt = $('#TabPanel_' + num)
	if (show){
		panel_bnt.AddClass('selected_bd')
		show.visible = true
	}
}

function diff_show(mode){
	show_mode = mode
	if (mode=='simple'){
		$('#Mode_container_simple').visible = true
		$('#Mode_container_ability').visible = false
	}else{
		$('#Mode_container_simple').visible = false
		$('#Mode_container_ability').visible = true
	}
}

function rating_init(t){
	var Keys = Object.keys(t)
	
	Diff_choise.RemoveAndDeleteChildren();
	Diff_description.RemoveAndDeleteChildren()
	
	for (var m = 0; m < Keys.length; m++) {
		var key = Keys[m];
		(function (currentKey) {
			var Mode = $.CreatePanel("Panel", Diff_description, "Mode_container_" + currentKey);
			for (var i = 1; i <= 13; i++) {
				if ($("#Diff_choise")) {
					(function (index) {
						if ($("#TabPanel_" + index) == null) {
							var TabPanel = $.CreatePanel("Panel", Diff_choise, "TabPanel_" + index);
							TabPanel.AddClass("rating_choise");
							TabPanel.SetPanelEvent("onmouseactivate", function () {
								opn(index);
							});
							var TabPanelLabel = $.CreatePanel("Label", TabPanel, "TabLabel_" + index);
							TabPanelLabel.AddClass('diff');
							TabPanelLabel.text = index;
						}
						if (t[currentKey][index]){
							var Diff_Panel = $.CreatePanel("Panel", Mode, "Diff_Panel_" + t[currentKey][i].game_difficulty)
							Diff_Panel.AddClass("RightPanel")
							for(var j = 1; j <= Object.keys(t[currentKey][1].game_time).length; j++){
								var game_time_obj = t[currentKey][i].game_time[j]
								if (game_time_obj){
									
									var container = $.CreatePanel("Panel", Diff_Panel, "game_container_" + j)
									container.BLoadLayoutSnippet("rating_card")
									container.AddClass("RatingCartContainer")
									
									let totalSeconds = game_time_obj.game_time
									let minutes = Math.floor(totalSeconds / 60)
									let seconds = totalSeconds % 60
									
									container.FindChildTraverse('rang').text = $.Localize("#rank_r") + j
									container.FindChildTraverse('time').text = $.Localize("#time_pass") + minutes + $.Localize("#minutes") + seconds + $.Localize("#sec")						
									
									for(var k = 1; k <= Object.keys(game_time_obj.players).length; k++){
										
										var player_obj = game_time_obj.players[k]

										var ContainerHero = $.CreatePanel("Panel", container, "ContainerHero" + k)
										ContainerHero.AddClass("RatingCartHero")
										
										ContainerHero.BLoadLayoutSnippet("rating_snippet")
					
										ContainerHero.FindChildTraverse('hero_icon').steamid = player_obj.player_id
										ContainerHero.FindChildTraverse('hero_name').steamid = player_obj.player_id
										ContainerHero.FindChildTraverse('hero_rating').text = $.Localize("#rait") + player_obj.player_rating
										ContainerHero.FindChildTraverse('hero_level').text = $.Localize("#level") + player_obj.player_level
										ContainerHero.FindChildTraverse('dota_hero').heroname = player_obj.hero
										
										ContainerHero.FindChildTraverse('dota_hero_img').visible = false
										if (player_obj.hero == "npc_dota_hero_anakim" || player_obj.hero == "npc_dota_hero_destroyer" || player_obj.hero == "npc_dota_hero_dado" || player_obj.hero == "npc_dota_hero_triss"){
											ContainerHero.FindChildTraverse('dota_hero_img').SetImage('file://{resources}/images/custom_game/heroes/' + player_obj.hero + ".png");
											ContainerHero.FindChildTraverse('dota_hero_img').visible = true
											ContainerHero.FindChildTraverse('dota_hero').visible = false
										}
										
										if (currentKey == "ability"){
											for(var l = 1; l <= Object.keys(player_obj.ability).length; l++){
												var item_id = player_obj.ability[l]
												const abilityPanel = $.CreatePanel("DOTAAbilityImage", ContainerHero.FindChildTraverse('ability_container'), ``);
												abilityPanel.AddClass("LinkedAbility");
												abilityPanel.abilityname = item_id;	
											}
										}
										
										
										if (player_obj.items){
											for(var l = 1; l <= Object.keys(player_obj.items).length; l++){
												var item_id = player_obj.items[l]
												const abilityPanel = $.CreatePanel("DOTAItemImage", ContainerHero.FindChildTraverse('item_container'), ``);
												abilityPanel.AddClass("dota_item");
												$.Msg(item_id)
												abilityPanel.itemname = item_id;	
												// $.Msg(item_id)
											}
										}
									}
									
								}
							}
						}
					})(i)
				}
			}
			
		})(key);
	}
	diff_show('simple')
	opn(1)
	
	$("#TabLoading").visible = false
}

function TipsOver(message, pos)
{
	$.DispatchEvent( "DOTAShowTextTooltip", $("#"+pos), $.Localize('#'+message))
}

function TipsOut()
{
    $.DispatchEvent( "DOTAHideTitleTextTooltip")
    $.DispatchEvent( "DOTAHideTextTooltip")
}


(function(){
	$("#RatingPanel").ToggleClass("hidden")
	GameEvents.Subscribe( "rating_init", rating_init)
})()