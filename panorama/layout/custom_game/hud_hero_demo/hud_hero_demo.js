--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const FacetPickerMain = $("#FacetPickerMain")
const LocalPID = Players.GetLocalPlayer()

// let parentHUDElements = GetDotaHud();
// $.GetContextPanel().SetParent(parentHUDElements);
// parentHUDElements.MoveChildBefore(FindDotaHudElement("VoiceChat"), $.GetContextPanel())

let SelectedHero = -1
let SelectedFacet = -1

function LoadPicker(){
	const List = FacetPickerMain.FindChildTraverse("FacetList")
	if(List){
		List.style.margin = "0px 0px 0px"
		List.style.flowChildren = "right-wrap"
	}

	$.RegisterEventHandler( 'DOTAUIHeroPickerHeroSelected', $( '#SelectHeroContainer' ), function(heroid, facetid){
		SelectedHero = heroid

		Game.EmitSound( "UI.Button.Pressed" );

		$.Msg( 'Hero = ' + SelectedHero );

		CloseHeroPicker();

		$( '#SelectHeroContainer' ).SetHasClass( 'PickMainHero', true );

		GameEvents.SendCustomGameEventToServer( "debugger_replace_main_hero", {heroid:SelectedHero, facetid:0} );
	} );
}

LoadPicker()

// function(){
// 	var HeroPickerImage = $( '#HeroPickerImage' );
// 	if ( HeroPickerImage != null )
// 	{
// 		HeroPickerImage.SetImage( "file://{images}/heroes/" + event_data.hero_name + ".png" );
// 	}

// 	var SpawnHeroButton = $( '#SpawnHeroButton' );
// 	if ( SpawnHeroButton != null )
// 	{
// 		$.Msg( 'HERO NAME = ' + event_data.hero_name );
// 		SpawnHeroButton.SetDialogVariable( "hero_name", $.Localize( '#'+event_data.hero_name ) );
// 	}
// }

function ToggleHeroPicker()
{
	let heroPickerOpen = $( '#SelectHeroContainer' ).BHasClass("HeroPickerVisible")
	HideAllAdditionalPanels();
	$( '#SelectHeroContainer' ).SetHasClass('HeroPickerVisible', !heroPickerOpen);
	if(!heroPickerOpen == true) {
		$( "#SelectHeroContainer" ).FindChildTraverse( "HeroSearchTextEntry" ).text = "";
		$( "#SelectHeroContainer" ).FindChildTraverse( "HeroSearchTextEntry" ).SetFocus();
	}
	Game.EmitSound( "UI.Button.Pressed" );
}

function ToggleBotPicker(){
	let heroPickerOpen = $( '#SelectBotContainer' ).BHasClass("HeroPickerVisible")
	HideAllAdditionalPanels();
	$( '#SelectBotContainer' ).SetHasClass('HeroPickerVisible', !heroPickerOpen);
	if(!heroPickerOpen == true) {
		$( "#SelectBotContainer" ).FindChildTraverse( "HeroSearchTextEntry" ).text = "";
		$( "#SelectBotContainer" ).FindChildTraverse( "HeroSearchTextEntry" ).SetFocus();
	}
	Game.EmitSound( "UI.Button.Pressed" );
}

// function EscapeHeroPickerSearch()
// {
// 	$( '#SelectHeroContainer' ).ToggleClass('HeroPickerVisible');
// }

// function EscapeBotPickerSearch()
// {
// 	$( '#SelectBotContainer' ).ToggleClass('HeroPickerVisible');
// }

function CloseHeroPicker()
{
	$( '#SelectHeroContainer' ).RemoveClass("HeroPickerVisible");
	$( '#SelectFacetHero' ).RemoveClass("HeroPickerVisible");
}

function CloseBotPicker()
{
	$( '#SelectBotContainer' ).RemoveClass("HeroPickerVisible");
}

function RespawnHero()
{
	GameEvents.SendCustomGameEventToServer( "RespawnHeroDemo", {} );
}

function SuicideHero()
{
	GameEvents.SendCustomGameEventToServer( "SuicideHeroDemo", {} );
}

function GiveLoserCurse()
{
	GameEvents.SendCustomGameEventToServer( "debugger_give_loser_curse", { unit: Players.GetLocalPlayerPortraitUnit() } );
	Game.EmitSound("UI.Button.Pressed");
}

function ClearLoserCurse()
{
	GameEvents.SendCustomGameEventToServer( "debugger_clear_loser_curse", { unit: Players.GetLocalPlayerPortraitUnit() } );
	Game.EmitSound("UI.Button.Pressed");
}

function GiveReportCurse()
{
	GameEvents.SendCustomGameEventToServer( "debugger_give_report_curse", { unit: Players.GetLocalPlayerPortraitUnit() } );
	Game.EmitSound("UI.Button.Pressed");
}

function GiveReportWarning()
{
	GameEvents.SendCustomGameEventToServer( "debugger_give_report_warning", { unit: Players.GetLocalPlayerPortraitUnit() } );
	Game.EmitSound("UI.Button.Pressed");
}

function ClearPunishments()
{
	GameEvents.SendCustomGameEventToServer( "debugger_clear_punishments", { unit: Players.GetLocalPlayerPortraitUnit() } );
	Game.EmitSound("UI.Button.Pressed");
}

function RefreshHero()
{
	GameEvents.SendCustomGameEventToServer( "RefreshHeroDemo", {} );
}

function ChooseSkill()
{
	GameEvents.SendCustomGameEventToServer( "ChooseSkillDemo", {} );
}

function AddQuickSkill(skillName)
{
	let countEntry = $("#QuickSkillCount");
	let count = 1;
	if (countEntry && countEntry.text && isNumeric(countEntry.text)) {
		count = parseInt(countEntry.text);
		if (count < 1) count = 1;
		if (count > 20) count = 20;
	}
	GameEvents.SendCustomGameEventToServer("debugger_add_quick_skill", {
		skill_name: skillName,
		count: count,
		unit: Players.GetLocalPlayerPortraitUnit()
	});
	Game.EmitSound("UI.Button.Pressed");
}

// Quick Skills popup
let SKILLS_INFO_TABLE = {};
SubscribeAndFireNetTableByKey("globals", "skills_info", function(v) {
	SKILLS_INFO_TABLE = v;
});

const SKILL_DEFINITIONS = [
	{ name: "all_atributes", icon: "crown" },
	{ name: "armor", icon: "chainmail" },
	{ name: "attack_range", icon: "dragon_lance" },
	{ name: "attackspeed", icon: "gloves" },
	{ name: "cast_point", icon: "arcane_blink" },
	{ name: "cast_range", icon: "psychic_headband" },
	{ name: "critical_strike", icon: "lesser_crit" },
	{ name: "damage", icon: "blades_of_attack" },
	{ name: "debuff_amplify", icon: "timeless_relic" },
	{ name: "evasion", icon: "talisman_of_evasion" },
	{ name: "gold_per_minute", icon: "philosophers_stone" },
	{ name: "health", icon: "vitality_booster" },
	{ name: "health_regen_pct", icon: "heart" },
	{ name: "lifesteal", icon: "lifesteal" },
	{ name: "magical_critical_strike", icon: "magilys_custom" },
	{ name: "magical_resistance", icon: "cloak" },
	{ name: "mana_regen_pct", icon: "bloodstone" },
	{ name: "manacost_pct", icon: "mysterious_hat" },
	{ name: "movespeed", icon: "boots" },
	{ name: "projectile_speed", icon: "witch_blade" },
	{ name: "spell_amplify", icon: "kaya" },
	{ name: "spell_lifesteal", icon: "voodoo_mask" },
	{ name: "status_resistance", icon: "titan_sliver" },
	{ name: "total_block", icon: "craggy_coat" },
	{ name: "universal_evasion", icon: "void_spell" },
];

function BuildQuickSkillsList(filter) {
	let list = $("#QuickSkillsList");
	if (!list) return;
	list.RemoveAndDeleteChildren();

	let filterLower = (filter || "").trim().toLowerCase();

	let filtered = SKILL_DEFINITIONS.filter(function(skill) {
		if (!filterLower) return true;
		let localizedDesc = $.Localize("#SKILL_" + skill.name + "_desc").trim();
		let localizedName = $.Localize("#SKILL_" + skill.name);
		return skill.name.toLowerCase().includes(filterLower) ||
			localizedDesc.toLowerCase().includes(filterLower) ||
			localizedName.toLowerCase().includes(filterLower);
	});

	for (let i = 0; i < filtered.length; i += 2) {
		let row = $.CreatePanel("Panel", list, "");
		row.AddClass("Row");

		for (let j = i; j < Math.min(i + 2, filtered.length); j++) {
			let skill = filtered[j];
			let displayName = $.Localize("#SKILL_" + skill.name + "_desc").trim();
			// Capitalize first letter
			if (displayName.length > 0) {
				displayName = displayName.charAt(0).toUpperCase() + displayName.slice(1);
			}

			let btn = $.CreatePanel("Button", row, "skill_btn_" + skill.name);
			btn.AddClass("SkillButton");
			if (j === i) btn.AddClass("LeftButton");
			else btn.AddClass("RightButton");

			let icon = $.CreatePanel("Panel", btn, "");
			icon.AddClass("SkillIcon");
			icon.style.backgroundImage = 'url("file://{images}/items/' + skill.icon + '.png")';
			icon.style.backgroundSize = "100%";
			icon.hittest = false;

			let skillInfo = SKILLS_INFO_TABLE[skill.name];
			let valueStr = "";
			if (skillInfo) {
				let val = skillInfo.value;
				let sign = val >= 0 ? "+" : "";
				let pct = skillInfo.is_percent ? "%" : "";
				valueStr = " (" + sign + val + pct + ")";
			}

			let label = $.CreatePanel("Label", btn, "");
			label.text = displayName + valueStr;

			btn.SetPanelEvent("onactivate", (function(sn) {
				return function() { AddQuickSkill(sn); };
			})(skill.name));
		}
	}
}

function ToggleQuickSkills() {
	let open = $("#QuickSkillsContainer").BHasClass("QuickSkillsVisible");
	HideAllAdditionalPanels();
	if (!open) {
		let searchEntry = $("#QuickSkillSearch");
		BuildQuickSkillsList(searchEntry ? searchEntry.text : "");
	}
	$("#QuickSkillsContainer").SetHasClass("QuickSkillsVisible", !open);
	Game.EmitSound("UI.Button.Pressed");
}

function CloseQuickSkills() {
	$("#QuickSkillsContainer").SetHasClass("QuickSkillsVisible", false);
}

function ToggleOtherPanel() {
	let open = $("#OtherContainer").BHasClass("OtherVisible");
	HideAllAdditionalPanels();
	$("#OtherContainer").SetHasClass("OtherVisible", !open);
	Game.EmitSound("UI.Button.Pressed");
}

function CloseOtherPanel() {
	$("#OtherContainer").SetHasClass("OtherVisible", false);
}

// [NP-DBG] Тумблер Alt-пингов (фича патча 16.06). Дёргает общий флаг в zxc_notifications.js
// через CustomUIConfig. Для проверки, уходят ли микроподёргивания при отключённых Alt-кликах.
function UpdateAltPingsLabel(){
	let cfg = GameUI.CustomUIConfig();
	let on = (cfg && cfg.IsAltPingEnabled) ? cfg.IsAltPingEnabled() : true;
	let lbl = $("#ToggleAltPingsLabel");
	if(lbl){ lbl.text = $.Localize(on ? "#DEBUG_AltPingsOn" : "#DEBUG_AltPingsOff"); }
	let btn = $("#ToggleAltPingsBtn");
	if(btn){ btn.SetHasClass("Active", on); }
}
function ToggleAltPings(){
	let cfg = GameUI.CustomUIConfig();
	if(!cfg || !cfg.SetAltPingEnabled){ return; }
	let on = cfg.IsAltPingEnabled ? cfg.IsAltPingEnabled() : true;
	cfg.SetAltPingEnabled(!on);
	UpdateAltPingsLabel();
	Game.EmitSound("UI.Button.Pressed");
}
UpdateAltPingsLabel();

BuildQuickSkillsList();

const QuickSkillSearch = $("#QuickSkillSearch");
if (QuickSkillSearch) {
	QuickSkillSearch.SetPanelEvent("ontextentrychange", () => {
		BuildQuickSkillsList(QuickSkillSearch.text);
	});
}

function ToggleInvulnerability()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

    for ( var i = 0; i < numEntities; i++ )
    {
        var entindex = entities[ i ];
        if ( entindex == -1 )
            continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'ToggleInvulnerabilityHero', String( entindex ) );
	}
}

function InvulnerableOn()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

	for ( var i = 0; i < numEntities; i++ )
	{
		var entindex = entities[i];
		if ( entindex == -1 )
			continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'InvulnOnHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function InvulnerableOff()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

	for ( var i = 0; i < numEntities; i++ )
	{
		var entindex = entities[i];
		if ( entindex == -1 )
			continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'InvulnOffHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function LevelUpSelectedHeroes()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

    for ( var i = 0; i < numEntities; i++ )
    {
        var entindex = entities[ i ];
        if ( entindex == -1 )
            continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'LevelUpHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function MaxLevelUpSelectedHeroes()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

    for ( var i = 0; i < numEntities; i++ )
    {
        var entindex = entities[ i ];
        if ( entindex == -1 )
            continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'MaxLevelUpHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function ResetSelectedHeroes()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

	for ( var i = 0; i < numEntities; i++ )
	{
		var entindex = entities[i];
		if ( entindex == -1 )
			continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'ResetHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function ShardSelectedHeroes()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

    for ( var i = 0; i < numEntities; i++ )
    {
        var entindex = entities[ i ];
        if ( entindex == -1 )
            continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'ShardHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function ScepterSelectedHeroes()
{
	var entities = Players.GetSelectedEntities( LocalPID );

	var numEntities = Object.keys( entities ).length;

    for ( var i = 0; i < numEntities; i++ )
    {
        var entindex = entities[ i ];
        if ( entindex == -1 )
            continue;

		$.DispatchEvent( 'FireCustomGameEvent_Str', 'ScepterHero', String( entindex ) );
	}

	if ( numEntities > 0 )
	{
		Game.EmitSound( "UI.Button.Pressed" );
	}
}

function MouseOverRune( strRuneID, strRuneTooltip )
{
	var runePanel = $( '#' + strRuneID );
	runePanel.StartAnimating();
	$.DispatchEvent( 'UIShowTextTooltip', runePanel, strRuneTooltip );
}

function MouseOutRune( strRuneID )
{
	var runePanel = $( '#' + strRuneID );
	runePanel.StopAnimating();
	$.DispatchEvent( 'UIHideTextTooltip', runePanel );
}

function SlideThumbActivate()
{
	var slideThumb = $.GetContextPanel();
	var bMinimized = slideThumb.BHasClass( 'Minimized' );

	if ( bMinimized )
	{
		Game.EmitSound( "ui_settings_slide_out" );
	}
	else
	{
		Game.EmitSound( "ui_settings_slide_in" );
	}

	slideThumb.ToggleClass( 'Minimized' );

	HideAllAdditionalPanels()
}

const RoundTextEntry = $("#RoundTextEntry");
RoundTextEntry.SetPanelEvent("ontextentrychange", ()=>{
	if(!isNumeric(RoundTextEntry.text) && RoundTextEntry.text != ""){
		RoundTextEntry.text = RoundTextEntry.text.replace(/\D/g,'');
	}
})

const NeutralTextEntry = $("#NeutralTextEntry");
NeutralTextEntry.SetPanelEvent("ontextentrychange", ()=>{
	if(!isNumeric(NeutralTextEntry.text) && NeutralTextEntry.text != ""){
		NeutralTextEntry.text = NeutralTextEntry.text.replace(/\D/g,'');
	}else if(parseInt(NeutralTextEntry.text) > 5){
		NeutralTextEntry.text = "5"
	}
})

const TimescaleTextEntry = $("#TimescaleTextEntry");
TimescaleTextEntry.SetPanelEvent("ontextentrychange", ()=>{
	if(!isNumeric(TimescaleTextEntry.text) && TimescaleTextEntry.text != ""){
		TimescaleTextEntry.text = TimescaleTextEntry.text.replace(/\D/g,'');
	}else if(parseFloat(TimescaleTextEntry.text) > 10){
		TimescaleTextEntry.text = "10"
	}else if(parseFloat(TimescaleTextEntry.text) < 0){
		TimescaleTextEntry.text = "0"
	}
})

const MaxHealthTextEntry = $("#MaxHealthTextEntry");
MaxHealthTextEntry.SetPanelEvent("ontextentrychange", ()=>{
	if(!isNumeric(MaxHealthTextEntry.text) && MaxHealthTextEntry.text != ""){
		MaxHealthTextEntry.text = MaxHealthTextEntry.text.replace(/\D/g,'');
	}else if(parseInt(MaxHealthTextEntry.text) > 1000000000){
		MaxHealthTextEntry.text = "1000000000"
	}else if(parseInt(MaxHealthTextEntry.text) <= 0){
		MaxHealthTextEntry.text = "1"
	}
})
 
function StartRound(){
	if(isNumeric(RoundTextEntry.text)){
		GameEvents.SendCustomGameEventToServer( "debugger_start_round", {round_num: parseInt(RoundTextEntry.text)} );
	}
}

function CraftNeutral(){
	if(isNumeric(NeutralTextEntry.text)){
		GameEvents.SendCustomGameEventToServer( "debugger_craft_neutral", {tier: parseInt(NeutralTextEntry.text)} );
	}
}

function ChangeTimescale(){
	if(isNumeric(TimescaleTextEntry.text) && parseFloat(TimescaleTextEntry.text) != 0){
		GameEvents.SendCustomGameEventToServer( "debugger_set_timescale", {scale: parseFloat(TimescaleTextEntry.text)} );
	}
}

function ChangeMaxHealth(){
	if(isNumeric(MaxHealthTextEntry.text)){
		GameEvents.SendCustomGameEventToServer( "debugger_set_max_health", {max_health: parseInt(MaxHealthTextEntry.text)} );
	}
}

function CreateDummy(){
	GameEvents.SendCustomGameEventToServer( "debugger_create_dummy", {} );
}

function DeleteDummy(){
	GameEvents.SendCustomGameEventToServer( "debugger_delete_dummy", {} );
}

function HideAllAdditionalPanels() {
	CloseHeroPicker();
	CloseBotPicker();
	CloseItemSpawnerContainer();
	CloseAbilitiesSpawnerContainer();
	CloseQuickSkills();
	CloseOtherPanel();
	CloseCreepsPanel();
	$.DispatchEvent("DropInputFocus");
}

function SwitchItemSpawnerDisplay() {
	let displayOpen = $( '#ItemSpawnerContainer' ).BHasClass("ItemSpawnerVisible")
	HideAllAdditionalPanels();
	$( '#ItemSpawnerContainer' ).SetHasClass( 'ItemSpawnerVisible', !displayOpen);
	if (!displayOpen) {
		$('#ItemSpawnerContainer').FindChildTraverse("ItemSpawnerName").text = "";
		$('#ItemSpawnerContainer').FindChildTraverse("ItemSpawnerName").SetFocus();
	}
	else {
		$.DispatchEvent("DropInputFocus");
	}
	Game.EmitSound( "UI.Button.Pressed" );
}

function CloseItemSpawnerContainer() {
	$( '#ItemSpawnerContainer' ).SetHasClass( 'ItemSpawnerVisible', false);
	Game.EmitSound( "UI.Button.Pressed" );
}

function SwitchAbilitiesSpawnerDisplay() {
	let displayOpen = $('#AbilitiesSpawnerContainer').BHasClass("AbilitiesSpawnerVisible")
	HideAllAdditionalPanels();
	$('#AbilitiesSpawnerContainer').SetHasClass( 'AbilitiesSpawnerVisible', !displayOpen);
	if (!displayOpen) {
		$('#AbilitiesSpawnerContainer').FindChildTraverse("AbilitySpawnerName").text = "";
		$('#AbilitiesSpawnerContainer').FindChildTraverse("AbilitySpawnerName").SetFocus();
	}
	else {
		$.DispatchEvent("DropInputFocus");
	}
	Game.EmitSound( "UI.Button.Pressed" );
}

function CloseAbilitiesSpawnerContainer() {
	$( '#AbilitiesSpawnerContainer' ).SetHasClass( 'AbilitiesSpawnerVisible', false);
	Game.EmitSound( "UI.Button.Pressed" );
}

let MODIFIED_ABILITIES = {}
let ABILITIES_INFO = {}
let HEROES_INFO = {}

function EnsureColorFxParticle(panel, isModified){
	let existing = panel.FindChild("AbilityColorFx")
	if(isModified){
		if(!existing){
			$.CreatePanel("DOTAParticleScenePanel", panel, "AbilityColorFx", {
				class: "AbilityColorFx",
				particleName: "particles/ability_select/ability_color_white.vpcf",
				particleonly: "true",
				startActive: "true",
				cameraOrigin: "0 0 190",
				lookAt: "0 0 0",
				fov: "30",
				squarePixels: "true",
				hittest: "false",
			})
		}
	}else{
		if(existing){
			existing.DeleteAsync(0)
		}
	}
}

function SetupAbilityPanel(parent, abilityName){
	let abilityInList = GetOrCreateAbilityPanel(parent, abilityName)
	abilityInList._AbilityName = abilityName;

	EnsureColorFxParticle(abilityInList, MODIFIED_ABILITIES[abilityName] == true);

	abilityInList.SetPanelEvent('onmouseover', function () {
		$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", abilityInList, abilityName, Players.GetLocalPlayer());
	});
	abilityInList.SetPanelEvent('onmouseout', function () {
		$.DispatchEvent("DOTAHideAbilityTooltip", abilityInList);
	});

	abilityInList.SetPanelEvent('onactivate', function() {
		GameEvents.SendCustomGameEventToServer("debugger_add_ability", {abilityName : abilityName, unit: Players.GetLocalPlayerPortraitUnit()});
	});

	return abilityInList
}

function RebuildAbilitiesSpawnerList(){
	let parent = $("#AbilitiesSpawnerList");
	if(!parent){return}
	parent.RemoveAndDeleteChildren();

	let added = {}

	function addAbility(abilityName){
		if(!abilityName){return}
		if(added[abilityName]){return}
		if(abilityName.includes("special_bonus_")){return}
		if(!ABILITIES_INFO[abilityName]){return}
		added[abilityName] = true

		SetupAbilityPanel(parent, abilityName)
	}

	// Heroes alphabetically by their key (npc_dota_hero_X). Within hero — abilities in
	// order from globals:heroes_info (which mirrors npc_abilities_list.txt order).
	let heroNames = Object.keys(HEROES_INFO).sort()
	for (let heroName of heroNames) {
		let heroInfo = HEROES_INFO[heroName]
		if(!heroInfo || !heroInfo.abilities){continue}

		for (let _ in heroInfo.abilities) {
			let abilityName = heroInfo.abilities[_]
			addAbility(abilityName)

			// Linked sub-abilities go right after the main one
			let info = ABILITIES_INFO[abilityName]
			if(info && info.LinkedAbilities){
				for (let linkedName in info.LinkedAbilities) {
					addAbility(linkedName)
				}
			}
		}
	}

	// Catch-all: scepter/shard/innate/facet abilities not in any hero's main list
	for (let abilityName in ABILITIES_INFO) {
		addAbility(abilityName)
	}
}

SubscribeAndFirePlayerTableByKey("globals", "abilities_info", function(v){
	ABILITIES_INFO = v || {}
	RebuildAbilitiesSpawnerList()
});

SubscribeAndFirePlayerTableByKey("globals", "heroes_info", function(v){
	HEROES_INFO = v || {}
	RebuildAbilitiesSpawnerList()
});

SubscribeAndFirePlayerTableByKey("globals", "modified_abilities", function(v){
	MODIFIED_ABILITIES = v || {}

	let parent = $("#AbilitiesSpawnerList");
	if(!parent){return}
	for(let i = 0; i < parent.GetChildCount(); i++){
		let p = parent.GetChild(i);
		if(p && p._AbilityName){
			EnsureColorFxParticle(p, MODIFIED_ABILITIES[p._AbilityName] == true);
		}
	}
});

SubscribeAndFirePlayerTableByKey("globals", "items_info", function(v){
    let parent = $("#ItemSpawnerList");
	parent.RemoveAndDeleteChildren();
	for (const [itemName, itemID] of Object.entries(v)) {
		let abilityInList = GetOrCreateItemPanel(parent, itemName)
		abilityInList._ItemName = itemName;

		abilityInList.SetPanelEvent('onmouseover', function () {
			$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", abilityInList, itemName, Players.GetLocalPlayer());
		});
		abilityInList.SetPanelEvent('onmouseout', function () {
			$.DispatchEvent("DOTAHideAbilityTooltip", abilityInList);
		});

		abilityInList.SetPanelEvent('onactivate', function() {
			GameEvents.SendCustomGameEventToServer("debugger_add_item", {itemName : itemName, unit: Players.GetLocalPlayerPortraitUnit()});
		});
	}
});

const AbilitySpawnerName = $("#AbilitySpawnerName")
AbilitySpawnerName.SetPanelEvent("ontextentrychange", ()=>{
	OnAbilitiesSpawnerUnitNameFilterChanged()
})

function OnAbilitiesSpawnerUnitNameFilterChanged() {
	let filter = $("#AbilitySpawnerName");
	if(filter._oldInput == filter.text) {
		return;
	}
	filter._oldInput = filter.text;
	let list = $("#AbilitiesSpawnerList");
	if(!list){return}
	for(let i = 0; i < list.GetChildCount(); i++) {
		let spawnButton = list.GetChild(i);
		let filterText = filter.text;
		let abilityName = spawnButton._AbilityName.toLowerCase()
		let localizedAbilityName = $.Localize("#DOTA_Tooltip_Ability_" + abilityName)

		let searchWords = filterText.trim().toLowerCase().split(/\s+/);
		let visible = searchWords.every(word =>
			localizedAbilityName.toLowerCase().includes(word) ||
			abilityName.toLowerCase().includes(word)
		);
		spawnButton.style.visibility = (visible > 0) ? "visible" : "collapse"
	}
}

const ItemSpawnerName = $("#ItemSpawnerName")
ItemSpawnerName.SetPanelEvent("ontextentrychange", ()=>{
	OnItemSpawnerUnitNameFilterChanged()
})

function OnItemSpawnerUnitNameFilterChanged() {
	let filter = $("#ItemSpawnerName");
	if(filter._oldInput == filter.text) {
		return;
	}
	filter._oldInput = filter.text;
	let list = $("#ItemSpawnerList");
	if(!list){return}
	for(var i = 0; i < list.GetChildCount(); i++) {
		let Item = list.GetChild(i);
		let itemName = Item._ItemName.toLowerCase()
		let filterText = filter.text;
		let localizedItemName = $.Localize("#DOTA_Tooltip_Ability_" + itemName)

		let searchWords = filterText.trim().toLowerCase().split(/\s+/);
		let visible = searchWords.every(word =>
			localizedItemName.toLowerCase().includes(word) ||
			itemName.toLowerCase().includes(word)
		);

		Item.style.visibility = visible ? "visible" : "collapse"
	}
}

function GetOrCreateAbilityPanel(Container, AbilityName){
	let f = Container.FindChildTraverse(`Ability_${AbilityName}`)
	if(f){
		return f
	}else{
		let p = $.CreatePanel("Panel", Container, `Ability_${AbilityName}`, {})
		p.BLoadLayoutSnippet("AbilityRow")

		let AbilityImageForAbility = p.FindChildTraverse("AbilityImageForAbility")
		if(AbilityImageForAbility){
			AbilityImageForAbility.abilityname = AbilityName
		}

		return p
	}
}

function GetOrCreateItemPanel(Container, ItemName){
	let f = Container.FindChildTraverse(`Item_${ItemName}`)
	if(f){
		return f
	}else{
		let p = $.CreatePanel("Panel", Container, `Item_${ItemName}`, {})
		p.BLoadLayoutSnippet("ItemRow")

		let ItemImageForItem = p.FindChildTraverse("ItemImageForItem")
		if(ItemImageForItem){
			ItemImageForItem.itemname = ItemName
		}

		return p
	}
}

// ========== Debug Creep Spawner ==========

const CREEP_LIST_UNSORTED = [
	{ item: "item_extra_creature_roshling_big", unit: "npc_dota_roshling_big" },
	{ item: "item_extra_creature_big_thunder_lizard", unit: "npc_dota_big_thunder_lizard" },
	{ item: "item_extra_creature_centaur_khan", unit: "npc_dota_centaur_khan" },
	{ item: "item_extra_creature_dark_troll_warlord", unit: "npc_dota_dark_troll_summoner" },
	{ item: "item_extra_creature_elf_wolf", unit: "npc_dota_elf_wolf" },
	{ item: "item_extra_creature_explode_spider", unit: "npc_dota_explode_spider" },
	{ item: "item_extra_creature_ghost", unit: "npc_dota_ghost" },
	{ item: "item_extra_creature_gnoll_assassin", unit: "npc_dota_gnoll_assassin" },
	{ item: "item_extra_creature_granite_golem", unit: "npc_dota_granite_golem" },
	{ item: "item_extra_creature_kobold", unit: "npc_dota_kobold" },
	{ item: "item_extra_creature_ogreseal", unit: "npc_dota_ogreseal_big" },
	{ item: "item_extra_creature_prowler_shaman", unit: "npc_dota_prowler_shaman" },
	{ item: "item_extra_creature_rock_golem", unit: "npc_dota_rock_golem" },
	{ item: "item_extra_creature_satyr_trickster", unit: "npc_dota_satyr_trickster" },
	{ item: "item_extra_creature_siltbreaker", unit: "npc_dota_siltbreaker_red" },
	{ item: "item_extra_creature_spider_range", unit: "npc_dota_spider_range" },
	{ item: "item_extra_creature_timber_spider", unit: "npc_dota_timber_spider" },
	{ item: "item_extra_creature_warpine", unit: "npc_dota_warpine_cone_custom" },
];

// Sort alphabetically by localized name
const CREEP_LIST = CREEP_LIST_UNSORTED.sort(function(a, b) {
	let nameA = $.Localize("#DOTA_Tooltip_ability_" + a.item).toLowerCase();
	let nameB = $.Localize("#DOTA_Tooltip_ability_" + b.item).toLowerCase();
	if (nameA < nameB) return -1;
	if (nameA > nameB) return 1;
	return 0;
});

const BOSS_LIST = [
	{ item: "debug_creature_roshan", unit: "npc_dota_roshan", label: "#DEBUG_CreepBoss_Roshan" },
	{ item: "debug_creature_nian", unit: "npc_dota_nian", label: "#DEBUG_CreepBoss_Nian" },
];

let _spawnedCreeps = [];

const CREEP_STATS = [
	{ key: "health", icon: "s2r://panorama/images/primary_attribute_icons/primary_attribute_icon_strength_psd.vtex", tooltip: "#DEBUG_CreepStat_Health" },
	{ key: "damage_min", icon: "s2r://panorama/images/hud/reborn/icon_damage_psd.vtex", tooltip: "#DEBUG_CreepStat_DamageMin" },
	{ key: "damage_max", icon: "s2r://panorama/images/hud/reborn/icon_damage_psd.vtex", tooltip: "#DEBUG_CreepStat_DamageMax" },
	{ key: "armor", icon: "s2r://panorama/images/hud/reborn/icon_armor_psd.vtex", tooltip: "#DEBUG_CreepStat_Armor" },
	{ key: "magic_resist", icon: "s2r://panorama/images/hud/reborn/icon_magic_resist_psd.vtex", tooltip: "#DEBUG_CreepStat_MagicResist" },
	{ key: "attack_speed", icon: "s2r://panorama/images/hud/reborn/icon_attack_speed_psd.vtex", tooltip: "#DEBUG_CreepStat_AttackSpeed" },
	{ key: "move_speed", icon: "s2r://panorama/images/hud/reborn/icon_speed_psd.vtex", tooltip: "#DEBUG_CreepStat_MoveSpeed" },
];

function ToggleCreepsPanel() {
	let open = $("#CreepsContainer").BHasClass("CreepsVisible");
	HideAllAdditionalPanels();
	if (!open) {
		BuildCreepSelectionGrid();
		BuildSpawnedCreepsList();
	}
	$("#CreepsContainer").SetHasClass("CreepsVisible", !open);
	Game.EmitSound("UI.Button.Pressed");
}

function CloseCreepsPanel() {
	$("#CreepsContainer").SetHasClass("CreepsVisible", false);
}

function BuildCreepButtonRow(parent, creepList, startIdx, cols) {
	for (let i = 0; i < creepList.length; i += cols) {
		let row = $.CreatePanel("Panel", parent, "");
		row.AddClass("Row");

		for (let j = i; j < Math.min(i + cols, creepList.length); j++) {
			let creep = creepList[j];
			let isBoss = !!creep.label;
			let displayName = isBoss ? $.Localize(creep.label) : $.Localize("#DOTA_Tooltip_ability_" + creep.item);

			let btn = $.CreatePanel("Button", row, "creep_btn_" + startIdx + "_" + j);
			btn.AddClass("CreepSelectButton");
			if (j === i) btn.AddClass("LeftButton");
			else if (j === i + cols - 1 || j === creepList.length - 1) btn.AddClass("RightButton");
			else btn.AddClass("CenterButton");

			if (!isBoss) {
				let icon = $.CreatePanel("DOTAItemImage", btn, "");
				icon.itemname = creep.item;
				icon.AddClass("CreepSelectIcon");
				icon.hittest = false;
			}

			let label = $.CreatePanel("Label", btn, "");
			label.text = displayName;
			label.AddClass("CreepSelectLabel");

			btn.SetPanelEvent("onactivate", (function(itemName) {
				return function() {
					GameEvents.SendCustomGameEventToServer("debugger_spawn_creep", { creep_name: itemName });
					Game.EmitSound("UI.Button.Pressed");
				};
			})(creep.item));

			if (!isBoss) {
				btn.SetPanelEvent("onmouseover", (function(panel, itemName) {
					return function() {
						$.DispatchEvent("DOTAShowAbilityTooltipForEntityIndex", panel, itemName, Players.GetLocalPlayer());
					};
				})(btn, creep.item));
				btn.SetPanelEvent("onmouseout", (function(panel) {
					return function() { $.DispatchEvent("DOTAHideAbilityTooltip", panel); };
				})(btn));
			} else {
				btn.SetPanelEvent("onmouseover", (function(panel, name) {
					return function() { $.DispatchEvent("UIShowTextTooltip", panel, name); };
				})(btn, displayName));
				btn.SetPanelEvent("onmouseout", (function(panel) {
					return function() { $.DispatchEvent("UIHideTextTooltip", panel); };
				})(btn));
			}
		}
	}
}

function BuildCreepSelectionGrid() {
	let grid = $("#CreepSelectionGrid");
	if (!grid) return;
	grid.RemoveAndDeleteChildren();

	// Creeps section
	let headerRow = $.CreatePanel("Panel", grid, "");
	headerRow.AddClass("CreepGridHeader");
	let headerLabel = $.CreatePanel("Label", headerRow, "");
	headerLabel.text = $.Localize("#DEBUG_CreepSelect");
	headerLabel.AddClass("CreepSectionLabel");

	BuildCreepButtonRow(grid, CREEP_LIST, 0, 3);

	// Bosses section
	let bossHeaderRow = $.CreatePanel("Panel", grid, "");
	bossHeaderRow.AddClass("CreepGridHeader");
	bossHeaderRow.style.marginTop = "6px";
	let bossHeaderLabel = $.CreatePanel("Label", bossHeaderRow, "");
	bossHeaderLabel.text = $.Localize("#DEBUG_CreepBosses");
	bossHeaderLabel.AddClass("CreepSectionLabel");

	BuildCreepButtonRow(grid, BOSS_LIST, 1, 2);
}

function BuildSpawnedCreepsList() {
	let list = $("#SpawnedCreepsList");
	if (!list) return;
	list.RemoveAndDeleteChildren();

	if (_spawnedCreeps.length === 0) return;

	let headerRow = $.CreatePanel("Panel", list, "");
	headerRow.AddClass("CreepGridHeader");
	let headerLabel = $.CreatePanel("Label", headerRow, "");
	headerLabel.text = $.Localize("#DEBUG_SpawnedCreeps");
	headerLabel.AddClass("CreepSectionLabel");

	// Delete all button
	let deleteAllRow = $.CreatePanel("Panel", list, "");
	deleteAllRow.AddClass("Row");
	let deleteAllBtn = $.CreatePanel("Button", deleteAllRow, "");
	deleteAllBtn.AddClass("DemoButton");
	deleteAllBtn.AddClass("CreepDeleteAllBtn");
	let deleteAllLabel = $.CreatePanel("Label", deleteAllBtn, "");
	deleteAllLabel.text = $.Localize("#DEBUG_DeleteAllCreeps");
	deleteAllBtn.SetPanelEvent("onactivate", function() {
		GameEvents.SendCustomGameEventToServer("debugger_delete_all_creeps", {});
		_spawnedCreeps = [];
		BuildSpawnedCreepsList();
		Game.EmitSound("UI.Button.Pressed");
	});

	for (let ci = 0; ci < _spawnedCreeps.length; ci++) {
		let creepInfo = _spawnedCreeps[ci];
		let isBoss = creepInfo.item_name.indexOf("debug_creature_") === 0;
		let bossEntry = isBoss && BOSS_LIST.filter(function(b) { return b.item === creepInfo.item_name; })[0];
		let displayName = bossEntry ? $.Localize(bossEntry.label) : $.Localize("#DOTA_Tooltip_ability_" + creepInfo.item_name);

		let creepPanel = $.CreatePanel("Panel", list, "spawned_creep_" + creepInfo.entindex);
		creepPanel.AddClass("SpawnedCreepEntry");

		// Header row with name + delete + expand toggle
		let nameRow = $.CreatePanel("Panel", creepPanel, "");
		nameRow.AddClass("CreepEntryHeader");

		let icon = $.CreatePanel("DOTAItemImage", nameRow, "");
		icon.itemname = creepInfo.item_name;
		icon.AddClass("CreepEntryIcon");
		icon.hittest = false;

		let nameLabel = $.CreatePanel("Label", nameRow, "");
		nameLabel.text = displayName;
		nameLabel.AddClass("CreepEntryName");

		let expandBtn = $.CreatePanel("Button", nameRow, "");
		expandBtn.AddClass("CreepExpandBtn");
		let expandLabel = $.CreatePanel("Label", expandBtn, "");
		expandLabel.text = "...";

		let deleteBtn = $.CreatePanel("Button", nameRow, "");
		deleteBtn.AddClass("CreepDeleteBtn");
		let deleteBtnLabel = $.CreatePanel("Label", deleteBtn, "");
		deleteBtnLabel.text = "X";
		deleteBtn.SetPanelEvent("onactivate", (function(idx, entindex) {
			return function() {
				GameEvents.SendCustomGameEventToServer("debugger_delete_creep", { entindex: entindex });
				_spawnedCreeps.splice(idx, 1);
				BuildSpawnedCreepsList();
				Game.EmitSound("UI.Button.Pressed");
			};
		})(ci, creepInfo.entindex));

		// Damage stats row
		let damageRow = $.CreatePanel("Panel", creepPanel, "creep_damage_" + creepInfo.entindex);
		damageRow.AddClass("CreepDamageRow");
		if (!creepInfo.dmg_visible) damageRow.AddClass("CreepDamageHidden");

		let dmgTotalLabel = $.CreatePanel("Label", damageRow, "creep_dmg_total_" + creepInfo.entindex);
		dmgTotalLabel.AddClass("CreepDmgLabel");
		dmgTotalLabel.text = creepInfo.dmg_total ? ($.Localize("#DEBUG_CreepDmg_Total") + ": " + creepInfo.dmg_total) : "";

		let dmgDpsLabel = $.CreatePanel("Label", damageRow, "creep_dmg_dps_" + creepInfo.entindex);
		dmgDpsLabel.AddClass("CreepDmgLabel");
		dmgDpsLabel.AddClass("CreepDmgDps");
		dmgDpsLabel.text = creepInfo.dmg_dps ? ("DPS: " + creepInfo.dmg_dps) : "";

		let dmgLastLabel = $.CreatePanel("Label", damageRow, "creep_dmg_last_" + creepInfo.entindex);
		dmgLastLabel.AddClass("CreepDmgLabel");
		dmgLastLabel.AddClass("CreepDmgLast");
		dmgLastLabel.text = creepInfo.dmg_last ? ($.Localize("#DEBUG_CreepDmg_LastHit") + ": " + creepInfo.dmg_last) : "";

		// Clear damage button
		let clearDmgBtn = $.CreatePanel("Button", damageRow, "");
		clearDmgBtn.AddClass("CreepClearDmgBtn");
		let clearDmgLabel = $.CreatePanel("Label", clearDmgBtn, "");
		clearDmgLabel.text = "R";
		clearDmgBtn.SetPanelEvent("onactivate", (function(entindex) {
			return function() {
				GameEvents.SendCustomGameEventToServer("debugger_reset_creep_damage", { entindex: entindex });
				// Clear local data
				for (let k = 0; k < _spawnedCreeps.length; k++) {
					if (_spawnedCreeps[k].entindex === entindex) {
						_spawnedCreeps[k].dmg_total = 0;
						_spawnedCreeps[k].dmg_dps = 0;
						_spawnedCreeps[k].dmg_last = 0;
						_spawnedCreeps[k].dmg_visible = false;
						break;
					}
				}
				BuildSpawnedCreepsList();
				Game.EmitSound("UI.Button.Pressed");
			};
		})(creepInfo.entindex));

		// Dead indicator
		if (creepInfo.dead) {
			let deadRow = $.CreatePanel("Panel", creepPanel, "");
			deadRow.AddClass("CreepDeadRow");
			let deadLabel = $.CreatePanel("Label", deadRow, "");
			deadLabel.text = $.Localize("#DEBUG_CreepDead");
			deadLabel.AddClass("CreepDeadLabel");
		}

		// Collapsible stats container (collapsed by default)
		let statsContainer = $.CreatePanel("Panel", creepPanel, "creep_stats_" + creepInfo.entindex);
		statsContainer.AddClass("CreepStatsContainer");
		statsContainer.AddClass("CreepStatsCollapsed");

		expandBtn.SetPanelEvent("onactivate", (function(container, label) {
			return function() {
				let collapsed = container.BHasClass("CreepStatsCollapsed");
				container.SetHasClass("CreepStatsCollapsed", !collapsed);
				label.text = collapsed ? "^" : "...";
				Game.EmitSound("UI.Button.Pressed");
			};
		})(statsContainer, expandLabel));

		// Stats editors inside collapsible container — compact with icons
		let statsGrid = $.CreatePanel("Panel", statsContainer, "");
		statsGrid.AddClass("CreepStatsGrid");

		for (let si = 0; si < CREEP_STATS.length; si++) {
			let stat = CREEP_STATS[si];

			let statCell = $.CreatePanel("Panel", statsGrid, "");
			statCell.AddClass("CreepStatCell");

			let statIcon = $.CreatePanel("Panel", statCell, "");
			statIcon.AddClass("CreepStatIcon");
			statIcon.style.backgroundImage = 'url("' + stat.icon + '")';
			statIcon.style.backgroundSize = "100%";
			statIcon.SetPanelEvent("onmouseover", (function(panel, tip) {
				return function() { $.DispatchEvent("UIShowTextTooltip", panel, $.Localize(tip)); };
			})(statIcon, stat.tooltip));
			statIcon.SetPanelEvent("onmouseout", (function(panel) {
				return function() { $.DispatchEvent("UIHideTextTooltip", panel); };
			})(statIcon));

			let statInput = $.CreatePanel("TextEntry", statCell, "stat_" + creepInfo.entindex + "_" + stat.key);
			statInput.AddClass("CreepStatInputCompact");

			// Pre-fill with wave-scaled values
			if (creepInfo.stats && creepInfo.stats[stat.key] !== undefined) {
				statInput.text = String(creepInfo.stats[stat.key]);
				statInput._oldInput = statInput.text;
			}

			statInput.SetPanelEvent("ontextentrychange", (function(input) {
				return function() {
					if (input._oldInput === input.text) return;
					let cleaned = input.text.replace(/[^0-9.\-]/g, '');
					if (cleaned !== input.text) {
						input.text = cleaned;
					}
					input._oldInput = input.text;
				};
			})(statInput));

			let applyBtn = $.CreatePanel("Button", statCell, "");
			applyBtn.AddClass("CreepStatApplyBtnCompact");
			let checkmark = $.CreatePanel("Label", applyBtn, "");
			checkmark.text = "OK";
			checkmark.AddClass("CreepStatCheckmark");
			applyBtn.SetPanelEvent("onactivate", (function(input, statKey, entindex) {
				return function() {
					let val = parseFloat(input.text);
					if (!isNaN(val)) {
						GameEvents.SendCustomGameEventToServer("debugger_modify_creep_stats", {
							entindex: entindex,
							stat: statKey,
							value: val
						});
						Game.EmitSound("UI.Button.Pressed");
					}
				};
			})(statInput, stat.key, creepInfo.entindex));
		}
	}
}

// Creep spawned event
GameEvents.Subscribe("debugger_creep_spawned", function(event) {
	_spawnedCreeps.push({
		entindex: event.entindex,
		unit_name: event.unit_name,
		item_name: event.item_name,
		stats: event.stats || {}
	});
	if ($("#CreepsContainer").BHasClass("CreepsVisible")) {
		BuildSpawnedCreepsList();
	}
});

// Damage update event — update data and refresh panel
GameEvents.Subscribe("debugger_creep_damage_update", function(event) {
	for (let i = 0; i < _spawnedCreeps.length; i++) {
		if (_spawnedCreeps[i].entindex === event.entindex) {
			_spawnedCreeps[i].dmg_total = event.total_damage;
			_spawnedCreeps[i].dmg_dps = event.dps;
			_spawnedCreeps[i].dmg_last = event.last_hit;
			_spawnedCreeps[i].dmg_visible = true;

			// Update labels directly if panel exists
			let totalLabel = $("#creep_dmg_total_" + event.entindex);
			let dpsLabel = $("#creep_dmg_dps_" + event.entindex);
			let lastLabel = $("#creep_dmg_last_" + event.entindex);
			let dmgRow = $("#creep_damage_" + event.entindex);

			if (dmgRow) dmgRow.RemoveClass("CreepDamageHidden");
			if (totalLabel) totalLabel.text = $.Localize("#DEBUG_CreepDmg_Total") + ": " + event.total_damage;
			if (dpsLabel) dpsLabel.text = "DPS: " + event.dps;
			if (lastLabel) lastLabel.text = $.Localize("#DEBUG_CreepDmg_LastHit") + ": " + event.last_hit;
			break;
		}
	}
});

// Damage hide event — hide after timeout
GameEvents.Subscribe("debugger_creep_damage_hide", function(event) {
	for (let i = 0; i < _spawnedCreeps.length; i++) {
		if (_spawnedCreeps[i].entindex === event.entindex) {
			_spawnedCreeps[i].dmg_visible = false;
			let dmgRow = $("#creep_damage_" + event.entindex);
			if (dmgRow) dmgRow.AddClass("CreepDamageHidden");
			break;
		}
	}
});

// Creep died — mark as dead, don't remove
GameEvents.Subscribe("debugger_creep_died", function(event) {
	for (let i = 0; i < _spawnedCreeps.length; i++) {
		if (_spawnedCreeps[i].entindex === event.entindex) {
			_spawnedCreeps[i].dead = true;
			break;
		}
	}
	if ($("#CreepsContainer").BHasClass("CreepsVisible")) {
		BuildSpawnedCreepsList();
	}
});

function AnalyzePlayerTables(){
	var totalSize = 0;
    // Укажите имена ваших таблиц
    var tablesToCheck = [`player_${LocalPID}`, "globals", "notifications", `team_${Players.GetTeam( LocalPID )}`, "round_info", `player_${LocalPID}_global`];

    $.Msg("--- PlayerTable Size Analysis (Client Side) ---");
    for (var i = 0; i < tablesToCheck.length; i++) {
        var tableName = tablesToCheck[i];
        var tableData = GetAllPlayerTableValues(tableName); // Получаем всю таблицу целиком [citation:1]

        if (tableData) {
            try {
                // Преобразуем в JSON-строку и считаем длину
                var jsonString = JSON.stringify(tableData);
                var sizeInBytes = jsonString.length; // В JavaScript .length даёт кол-во символов UTF-16, но для оценки сойдёт
                totalSize += sizeInBytes;
                $.Msg("Table '" + tableName + "': ~" + (sizeInBytes / 1024).toFixed(2) + " KB");
            } catch (e) {
                $.Msg("Error analyzing table '" + tableName + "': " + e);
            }
        } else {
            $.Msg("Table '" + tableName + "' is empty or does not exist.");
        }
    }
    $.Msg("Total estimated size (all tables): ~" + (totalSize / 1024).toFixed(2) + " KB");
    $.Msg("------------------------------------------");
}

function AnalyzeNetTables() {
    var totalSize = 0;
    // Укажите имена ваших таблиц
    var tablesToCheck = ["players", "globals", "players_server_info", "hero_info", "round_info", "player_info", "team_rank", "mmr_player", "pause_owner", "coins_table", "creep_launch"];

    $.Msg("--- NetTable Size Analysis (Client Side) ---");
    for (var i = 0; i < tablesToCheck.length; i++) {
        var tableName = tablesToCheck[i];
        var tableData = CustomNetTables.GetAllTableValues(tableName); // Получаем всю таблицу целиком [citation:1]

        if (tableData) {
            try {
                // Преобразуем в JSON-строку и считаем длину
                var jsonString = JSON.stringify(tableData);
                var sizeInBytes = jsonString.length; // В JavaScript .length даёт кол-во символов UTF-16, но для оценки сойдёт
                totalSize += sizeInBytes;
                $.Msg("Table '" + tableName + "': ~" + (sizeInBytes / 1024).toFixed(2) + " KB");
            } catch (e) {
                $.Msg("Error analyzing table '" + tableName + "': " + e);
            }
        } else {
            $.Msg("Table '" + tableName + "' is empty or does not exist.");
        }
    }
    $.Msg("Total estimated size (all tables): ~" + (totalSize / 1024).toFixed(2) + " KB");
    $.Msg("------------------------------------------");
}