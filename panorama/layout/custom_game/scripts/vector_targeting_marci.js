--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// ----------------------------------------------------------
// Vector Targeting Library
// ========================
// Version: 1.0
// Github: https://github.com/Nibuja05/dota_vector_targeting
// STRANGER MARCI UPDATE UNIQUE
// ----------------------------------------------------------

const MARCI_CONTINUE_PROCESSING_EVENT = false;

//main variables
var marci_vectorTargetParticle;
var GogogoParticle;
var marci_vectorTargetUnit;
var marci_vectorStartPosition;
var marci_vectorRange = 800;
var marci_currentlyActiveVectorTargetAbility;
var marci_current_target_index;


var raduis = 0;
var ability_min_cast_range = 450
var ability_max_cast_range = 850
var cast_range

var modifier_for_bonus_cast_range = ""
var bonus_cast_range_for_stack = 0

function MarciGetBonusCastRange(number, mod) {

	var hero = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )

	for (var i = 0; i < Entities.GetNumBuffs(hero); i++) {
		var buffID = Entities.GetBuff(hero, i)
		if (Buffs.GetName(hero, buffID ) == mod ){
			var stack = Buffs.GetStackCount(hero, buffID ) 
			if (stack == 0) {
				stack = 1
			}
			return number * stack
		}
	}
	return 0
}
   

const MarcidefaultAbilities = ["marci_companion_run_custom"];

var marci_check_mouse_f = function marci_check_mouse(eventName, arg, arg2, arg3)
{
	if(GameUI.GetClickBehaviors() == 3 && marci_currentlyActiveVectorTargetAbility != undefined){
		const abilityName_2 = Abilities.GetAbilityName(marci_currentlyActiveVectorTargetAbility);

		if (MarcidefaultAbilities.includes(abilityName_2)) {
			var ent=GameUI.FindScreenEntities(GameUI.GetCursorPosition())
			if (ent[0] != null && ent[0].entityIndex != Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )) {


				marci_current_target_index = ent[0].entityIndex
				const netTable = CustomNetTables.GetTableValue( "vector_targeting", marci_currentlyActiveVectorTargetAbility )
				MarciOnVectorTargetingStart(netTable.startWidth, netTable.endWidth, netTable.castLength, netTable.dual, netTable.ignoreArrow);
			}
		}
	}
}


































 


//Listen for class changes
$.RegisterForUnhandledEvent("StyleClassesChanged", MarciCheckAbilityVectorTargeting );
function MarciCheckAbilityVectorTargeting(panel){
	if(panel == null){return;}
	//Check if the panel is an ability or item panel
	const abilityIndex = GetAbilityFromPanel(panel)
	if (abilityIndex >= 0) {

		//Check if the ability/item is vector targeted
		const netTable = CustomNetTables.GetTableValue("vector_targeting", abilityIndex);
		if (netTable == undefined) {
			let behavior = Abilities.GetBehavior(abilityIndex);
			if ((behavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING) !== 0) {
				GameEvents.SendCustomGameEventToServer_custom("check_ability", {"abilityIndex" : abilityIndex} );
			}
			return;
		}
		//Check if the ability/item gets activated or is finished
		if (panel.BHasClass("is_active")) {
			marci_currentlyActiveVectorTargetAbility = abilityIndex;
			if(GameUI.GetClickBehaviors() == 9 ){
				MarciOnVectorTargetingStart(netTable.startWidth, netTable.endWidth, netTable.castLength, netTable.dual, netTable.ignoreArrow);
			}
		} else {
			MarciOnVectorTargetingEnd();
		}
	}
}

//Find the ability/item entindex from the panorama panel
function GetAbilityFromPanel(panel) {
	if (panel.paneltype == "DOTAAbilityPanel") {

		// Be sure that it is a default ability Button
		const parent = panel.GetParent();
		if (parent != undefined && (parent.id == "abilities" || parent.id == "inventory_list")) {
			const abilityImage = panel.FindChildTraverse("AbilityImage")
			let abilityIndex = abilityImage.contextEntityIndex;
			let abilityName = abilityImage.abilityname

			//Will be undefined for items
			if (abilityName) {
				return abilityIndex;
			}

			//Return item entindex instead
			const itemImage = panel.FindChildTraverse("ItemImage")
			abilityIndex = itemImage.contextEntityIndex;
			return abilityIndex;
		}
	}
	return -1;
}

// Start the vector targeting
function MarciOnVectorTargetingStart(fStartWidth, fEndWidth, fCastLength, bDual, bIgnoreArrow)
{

	if (marci_vectorTargetParticle && GogogoParticle) {
		Particles.DestroyParticleEffect(marci_vectorTargetParticle, true)
		Particles.DestroyParticleEffect(GogogoParticle, true)
		marci_vectorTargetParticle = undefined;
		marci_vectorTargetUnit = undefined;
	}

	const iPlayerID = Players.GetLocalPlayer();
	const selectedEntities = Players.GetSelectedEntities( iPlayerID );
	const mainSelected = Players.GetLocalPlayerPortraitUnit();
	const mainSelectedName = Entities.GetUnitName(mainSelected);
	marci_vectorTargetUnit = mainSelected;
	const cursor = GameUI.GetCursorPosition();
	const worldPosition = GameUI.GetScreenWorldPosition(cursor);

	// particle variables
	let startWidth = fStartWidth || 125;
	let endWidth = fEndWidth || startWidth;
	marci_vectorRange = fCastLength || 800;
	let ignoreArrowWidth = bIgnoreArrow;

	const abilityName = Abilities.GetAbilityName(marci_currentlyActiveVectorTargetAbility);

	if (abilityName != "marci_companion_run_custom")
	{
		return 
	}

	if (MarcidefaultAbilities.includes(abilityName)) {
		marci_vectorRange = Abilities.GetSpecialValueFor(marci_currentlyActiveVectorTargetAbility, "min_jump_distance");
		radius = Abilities.GetSpecialValueFor(marci_currentlyActiveVectorTargetAbility, "landing_radius");

		ability_min_cast_range = Abilities.GetSpecialValueFor(marci_currentlyActiveVectorTargetAbility, "min_jump_distance");
		ability_max_cast_range = Abilities.GetSpecialValueFor(marci_currentlyActiveVectorTargetAbility, "max_jump_distance") + MarciGetBonusCastRange(bonus_cast_range_for_stack, modifier_for_bonus_cast_range) - 50;
		cast_range = Abilities.GetCastRange( marci_currentlyActiveVectorTargetAbility ) -50
	}

	let particleName = "particles/ui_mouseactions/range_finder_generic_aoe_nocenter.vpcf";
	let gogogoParticleName = "particles/ui_mouseactions/range_finder_line_moving_dash.vpcf"

	var ent=GameUI.FindScreenEntities(GameUI.GetCursorPosition())
	if (ent[0] != null && ent[0].entityIndex != Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() )) {

		marci_current_target_index = ent[0].entityIndex
	}

	//Initialize the particle
	marci_vectorTargetParticle = Particles.CreateParticle(particleName, ParticleAttachment_t.PATTACH_CUSTOMORIGIN, mainSelected);

	GogogoParticle = Particles.CreateParticle(gogogoParticleName, ParticleAttachment_t.PATTACH_CUSTOMORIGIN, mainSelected);

	Particles.SetParticleControl(GogogoParticle, 0, Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())));



	const direction_2 = Vector_normalize(Vector_sub(Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())), Entities.GetAbsOrigin( marci_current_target_index )));



	const newPosition_2 = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_2, 800));
	Particles.SetParticleControl(GogogoParticle, 1, newPosition_2);
	Particles.SetParticleControl(GogogoParticle, 2, Entities.GetAbsOrigin( marci_current_target_index ));

	marci_vectorTargetUnit = mainSelected

	//Calculate initial particle CPs
	marci_vectorStartPosition = worldPosition;

	Particles.SetParticleControl(marci_vectorTargetParticle, 0, Entities.GetAbsOrigin( marci_current_target_index ));
	Particles.SetParticleControl(marci_vectorTargetParticle, 1, Entities.GetAbsOrigin( marci_current_target_index ));



	const direction_3 = Vector_normalize(Vector_sub(Entities.GetAbsOrigin( marci_current_target_index ), Vector_raiseZ(worldPosition, 100)));
	const newPosition_3 = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_3, radius/2));



	Particles.SetParticleControl(marci_vectorTargetParticle, 2, newPosition_3);









	Particles.SetParticleControl(marci_vectorTargetParticle, 3, [radius, radius, radius]);
	Particles.SetParticleControl(marci_vectorTargetParticle, 12, Vector_raiseZ(worldPosition, 100));


	const unitPosition = Entities.GetAbsOrigin(mainSelected);
	const direction = Vector_normalize(Vector_sub(marci_vectorStartPosition, unitPosition));
	const newPosition = Vector_add(marci_vectorStartPosition, Vector_mult(direction, marci_vectorRange));
	

	//Start position updates
	MarciShowVectorTargetingParticle();
	return MARCI_CONTINUE_PROCESSING_EVENT;
}

function MarciOnVectorTargetingEnd()
{
	marci_currentlyActiveVectorTargetAbility = undefined;

	if (marci_vectorTargetParticle && GogogoParticle) {
		Particles.DestroyParticleEffect(marci_vectorTargetParticle, true)
		Particles.DestroyParticleEffect(GogogoParticle, true)
		marci_vectorTargetParticle = undefined;
		marci_vectorTargetUnit = undefined;
	}
}

//Updates the particle effect and detects when the ability is actually casted
function MarciShowVectorTargetingParticle()
{
	if (marci_vectorTargetParticle !== undefined && GogogoParticle !== undefined)
	{
		const mainSelected = Players.GetLocalPlayerPortraitUnit();
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = GameUI.GetScreenWorldPosition(cursor);

		if (worldPosition == null)
		{
			$.Schedule(1 / 144, MarciShowVectorTargetingParticle);
			return;
		}

		const testVec = Vector_sub(worldPosition, marci_vectorStartPosition);

		let direction = Vector_normalize(Vector_sub(marci_vectorStartPosition, worldPosition));
		direction = Vector_flatten(Vector_negate(direction));
		const newPosition = Vector_add(marci_vectorStartPosition, Vector_mult(direction, marci_vectorRange));

		Particles.SetParticleControl(marci_vectorTargetParticle, 0, Entities.GetAbsOrigin( marci_current_target_index ));
		Particles.SetParticleControl(marci_vectorTargetParticle, 1, Entities.GetAbsOrigin( marci_current_target_index ));


		let direction_3 = Vector_normalize(Vector_sub(worldPosition, Entities.GetAbsOrigin( marci_current_target_index )));

		let direction_4 = Vector_normalize(Vector_sub(Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())), Entities.GetAbsOrigin( marci_current_target_index )));

		let newPosition_3

		if (Vector_distance(worldPosition, Entities.GetAbsOrigin( marci_current_target_index )) >= ability_max_cast_range) {
			newPosition_3 = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_3, ability_max_cast_range));
			Particles.SetParticleControl(marci_vectorTargetParticle, 2, newPosition_3);	

			var line_length = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_3, ability_max_cast_range - radius));

			line_length[2] = line_length[2] + 50

			Particles.SetParticleControl(marci_vectorTargetParticle, 12, line_length);


		} else if (Vector_distance(worldPosition, Entities.GetAbsOrigin( marci_current_target_index )) <= ability_min_cast_range) {

			let distance_check = (Vector_distance(Entities.GetAbsOrigin( marci_current_target_index ), worldPosition))

			newPosition_3 = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_3, ability_min_cast_range));
			var line_length = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_3, ability_min_cast_range - radius));

			var ent=GameUI.FindScreenEntities(GameUI.GetCursorPosition())

			if (ent[0] != null && ent[0].entityIndex == marci_current_target_index) {
				newPosition_3 = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_4, -ability_min_cast_range));

				let direction_5 = Vector_normalize(Vector_sub(Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())), newPosition_3));

				line_length = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_5, -ability_min_cast_range + radius));
			}

			line_length[2] = line_length[2] + 50

			Particles.SetParticleControl(marci_vectorTargetParticle, 2, newPosition_3);
			Particles.SetParticleControl(marci_vectorTargetParticle, 12, line_length);
		} else {


			var line_length = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_3, Vector_distance(worldPosition, Entities.GetAbsOrigin( marci_current_target_index )) - radius));

			line_length[2] = line_length[2] + 50

			Particles.SetParticleControl(marci_vectorTargetParticle, 2, worldPosition);
			Particles.SetParticleControl(marci_vectorTargetParticle, 12, line_length);
		}



		

		

		Particles.SetParticleControl(GogogoParticle, 0, Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())));



		const direction_2 = Vector_normalize(Vector_sub(Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())), Entities.GetAbsOrigin( marci_current_target_index )));
		const newPosition_2 = Vector_add(Entities.GetAbsOrigin( marci_current_target_index ), Vector_mult(direction_2, cast_range));

		

		if (Vector_distance(Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())), Entities.GetAbsOrigin( marci_current_target_index )) >= cast_range) {
			Particles.SetParticleControl(GogogoParticle, 1, newPosition_2);
		} else {
			Particles.SetParticleControl(GogogoParticle, 1, Entities.GetAbsOrigin(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())));
		}

		Particles.SetParticleControl(GogogoParticle, 2, Entities.GetAbsOrigin( marci_current_target_index ));

		if( mainSelected != marci_vectorTargetUnit ){
			GameUI.SelectUnit(marci_vectorTargetUnit, false )
		}
		$.Schedule(1 / 144, MarciShowVectorTargetingParticle);
	}
}

function Vector_normalize(vec)
{
	const val = 1 / Math.sqrt(Math.pow(vec[0], 2) + Math.pow(vec[1], 2) + Math.pow(vec[2], 2));
	return [vec[0] * val, vec[1] * val, vec[2] * val];
}

function Vector_mult(vec, mult)
{
	return [vec[0] * mult, vec[1] * mult, vec[2] * mult];
}

function Vector_add(vec1, vec2)
{
	return [vec1[0] + vec2[0], vec1[1] + vec2[1], vec1[2] + vec2[2]];
}

function Vector_sub(vec1, vec2)
{
	return [vec1[0] - vec2[0], vec1[1] - vec2[1], vec1[2] - vec2[2]];
}

function Vector_negate(vec)
{
	return [-vec[0], -vec[1], -vec[2]];
}

function Vector_flatten(vec)
{
	return [vec[0], vec[1], 0];
}

function Vector_raiseZ(vec, inc)
{
	return [vec[0], vec[1], vec[2] + inc];
}

function Vector_distance (vec1, vec2) {
	return Math.sqrt(((vec2[0] - vec1[0]) ** 2) + ((vec2[1] - vec1[1]) ** 2));
}