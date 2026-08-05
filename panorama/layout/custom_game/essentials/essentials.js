--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


var curhpunit = false;
function hpbar() {
    var hp = Entities.GetHealthPercent(curhpunit)

	if (hp == null)
		return

    if(Math.ceil(hp)<=0){
        curhpunit= false
        $("#hpbarroot").visible = false 
        return;
    }
    $("#hpbar").style.width = hp+"%"
    $.Schedule(0.03,hpbar)
}
function showHpBar(t) {
	const unit = t.unit
	const unitName = unit ? Entities.GetUnitName(unit) : undefined

    if(!unit || !Entities.IsAlive(unit) || !unitName) {
        $("#hpbarroot").visible = false
        curhpunit = false
        return
    }
    curhpunit = unit
    $("#hpbarroot").visible = true
    $("#name").text = $.Localize("#"+unitName)
    hpbar()
}

function FindDotaHudElement(panel) {
	return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
}

var pan = FindDotaHudElement("TopBarDireTeam");
pan.visible = false


var open = false;
var state = false;

function ShowDamage()
{
	state = true
	if(open == true){
		close2()
		return
	}else{
		open1()
	}
}

function open1()
{
	Game.EmitSound('ui_team_select_shuffle')
	open = true;
	$("#dmgPanel").style['position'] = "0% 0px 0px";
	$("#dmgPanel").visible = true
}

function close2()
{
	Game.EmitSound('ui_team_select_shuffle')
	open = false;
	$("#dmgPanel").style['position'] = "120px 0px 0px";
	$.Schedule(0.2, function(){
		$("#dmgPanel").visible = false
	})	
}

// function dmgtable(t) {
    // $("#dmgPanel").RemoveAndDeleteChildren()
    // for(var k in t){
        // var pan=$.CreatePanel("Panel",$("#dmgPanel"),'hero_'+k)
        // pan.BLoadLayoutSnippet('heroinfosnippet')
        // if(t[k].heal)
            // pan.FindChildTraverse('heal').text =  t[k].heal.toFixed(0)
        // if(t[k].dmg)
            // pan.FindChildTraverse('dmg').text = t[k].dmg.toFixed(0)
		// if(t[k].mag)
            // pan.FindChildTraverse('mag').text = t[k].mag.toFixed(0)
		// if(t[k].pure)
            // pan.FindChildTraverse('pure').text = t[k].pure.toFixed(0)
        // if(t[k].tank)
            // pan.FindChildTraverse('tank').text = t[k].tank.toFixed(0)
        // pan.FindChildTraverse('heroname').text =  $.Localize("#"+Entities.GetUnitName(parseInt(k)))
    // }
    // Game.myDmgTable = t
// }

function showEndScreen() {
    $("#victoryText").text = Game.GetGameWinner()==Players.GetTeam(Game.GetLocalPlayerID())?"VICTORY":"DEFEAT"
    $("#victoryText").SetHasClass("red", Game.GetGameWinner()!=Players.GetTeam(Game.GetLocalPlayerID()))
    let t = Game.myDmgTable;
    for (var k in t) {
        var pan=$.CreatePanel("Panel",$("#players"),'hero_'+k)
        let ply = Entities.GetPlayerOwnerID(parseInt(k))
        pan.BLoadLayoutSnippet('playerrow')
        pan.FindChildTraverse("playerAvatar").steamid = Game.GetPlayerInfo(ply).player_steamid
        pan.FindChildTraverse("heronameboard").text = `${$.Localize("#"+Entities.GetUnitName(parseInt(k)))} ${Entities.GetLevel(parseInt(k))} lvl`
        pan.FindChildTraverse("death").text = Players.GetDeaths(ply)
        if(t[k].heal)
            pan.FindChildTraverse('healboard').text =  t[k].heal.toFixed(0)
        if(t[k].dmg)
            pan.FindChildTraverse('dmgboard').text = t[k].dmg.toFixed(0)
		if(t[k].mag)
            pan.FindChildTraverse('magboard').text = t[k].mag.toFixed(0)
		if(t[k].pure)
            pan.FindChildTraverse('pureboard').text = t[k].pure.toFixed(0)		
        if(t[k].tank)
            pan.FindChildTraverse('takenboard').text = t[k].tank.toFixed(0)
        for (var i = 0; 6>i; i++) {
            pan.FindChildTraverse(`slot${i}`).itemname = Abilities.GetAbilityName(Entities.GetItemInSlot(parseInt(k), i))
        }
    }
}

function showloc(t) {
    $("#newLocation").style.backgroundImage = `url("file://{resources}/${t.image}")`
    $("#newLocation").FindChildTraverse("locName").text = $.Localize("#"+t.name)
	$("#newLocation").FindChildTraverse("locName2").text = $.Localize("#"+t.name2)
    $("#newLocation").SetHasClass('hidden',false)
    $.Schedule(t.time?t.time:5,function() {
        $("#newLocation").SetHasClass('hidden',true)
    })
}


(function() {
    if($.GetContextPanel().BHasClass("endboard"))
        return;
    $("#hpbarroot").visible = false
    GameEvents.Subscribe("showHpBar",showHpBar)
    // GameEvents.Subscribe("dmgtable",dmgtable)
    GameEvents.Subscribe("showLoc",showloc)
    GameEvents.SendCustomGameEventToServer ("startreq",{})
})()