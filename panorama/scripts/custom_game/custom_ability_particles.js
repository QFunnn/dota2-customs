--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var vectorTargetParticle_hoodwink = undefined;
var last_state = false;
var interval = 1/144


function Init()
{
	GameEvents.Subscribe_custom('ability_hoodwink_ulti', start_sharp)
	GameEvents.Subscribe_custom('ability_muerta_call', start_call)
	GameEvents.Subscribe_custom('ability_snapfire_scatter', start_scatter)
	GameEvents.Subscribe_custom('ability_sandking_stinger', start_stinger)
	GameEvents.Subscribe_custom('ability_slark_pounce_legendary', start_pounce)
	GameEvents.Subscribe_custom('ability_razor_current', start_current)
	GameEvents.Subscribe_custom('ability_morphling_adaptive', start_adaptive)
	GameEvents.Subscribe_custom('ability_lifestealer_unfettered', start_unfettered)
	GameEvents.Subscribe_custom('ability_stalker_dark', ability_stalker_dark)
	GameEvents.Subscribe_custom('ability_mars_spear', ability_mars_spear)
}

Init()

var init_scatter = false
var init_call = false
var init_sharp = false
var init_stinger = false
var init_pounce = false
var init_razor = false
var init_morphling = false
var init_unfettered = false
var hoodwink_pfx = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_range_finder.vpcf"

function start_scatter()
{
	if (init_scatter == true) return

	init_scatter = true
	ability_snapfire_scatter()
}
	
function start_call()
{
	if (init_call == true) return

	init_call = true
	ability_muerta_call()
}
	
function start_sharp(data)
{
    if (data.has_blue_style && data.has_blue_style == 1)
    {
        hoodwink_pfx = "particles/econ/items/hoodwink/hoodwink_2022_immortal/hoodwink_sharpshooter_range_finder_blossom.vpcf"
    }
    else
    {
        hoodwink_pfx = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_range_finder.vpcf"
    }
	if (init_sharp == true) return
	init_sharp = true
	ability_hoodwink_ulti()
}
	
function start_stinger()
{
	if (init_stinger == true) return

	init_stinger = true
	ability_sandking_stinger()
}
	
function start_pounce()
{
	if (init_pounce == true) return

	init_pounce = true
	ability_slark_pounce_legendary()
}

function start_unfettered()
{
	if (init_unfettered == true) return

	init_unfettered = true
	ability_lifestealer_unfettered()
}	

function start_current()
{
	if (init_razor == true) return

	init_razor = true
	ability_razor_current()
}

function start_adaptive()
{
	if (init_morphling == true) return

	init_morphling = true
	ability_morphling_adaptive()
}

function HasModifierCustom(unit, modifier) {
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return Entities.GetBuff(unit, i)
        }
    }
	return false
}


var vectorTargetParticle_mars;
var mars_range = 0
var mars_width = 0

function ability_mars_spear(kv)
{
	let state = 0
	if (kv)
	{
		state = kv.state
		mars_range = kv.range
		mars_width = kv.width
	}

	if (state == 2)
	{
		if (vectorTargetParticle_mars) 
		{
			Particles.DestroyParticleEffect(vectorTargetParticle_mars, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_mars)
			vectorTargetParticle_mars = undefined;
		}
		return
	}

	if (state == 1 && vectorTargetParticle_mars == undefined)
		vectorTargetParticle_mars = Particles.CreateParticle("particles/mars/spear_legendary_rope.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) ); 

	if (vectorTargetParticle_mars)
	{
		let max_distance = mars_range
		let origin = Entities.GetAbsOrigin( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) )
		let forward = Entities.GetForward( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))

		Particles.SetParticleControl(vectorTargetParticle_mars, 0, origin );
		Particles.SetParticleControl(vectorTargetParticle_mars, 1, Vector_add(origin, Vector_mult(forward, max_distance)));
		Particles.SetParticleControl(vectorTargetParticle_mars, 3, [mars_width, 0, 0]);
    	$.Schedule(interval, ability_mars_spear)
	}
}



var vectorTargetParticle_stalker;

function ability_stalker_dark(kv)
{
	let state = 0
	if (kv)
		state = kv.state

	if (state == 2)
	{
		if (vectorTargetParticle_stalker) 
		{
			Particles.DestroyParticleEffect(vectorTargetParticle_stalker, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_stalker)
			vectorTargetParticle_stalker = undefined;
		}
		return
	}

	if (state == 1 && vectorTargetParticle_stalker == undefined)
		vectorTargetParticle_stalker = Particles.CreateParticle("particles/night_stalker/dark_legedary_vector.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) ); 

	if (vectorTargetParticle_stalker)
	{
		let max_distance = Number(Game.GetTalentValue("modifier_stalker_dark_7", "range"))
		let origin = Entities.GetAbsOrigin( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) )
		let forward = Entities.GetForward( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))

		Particles.SetParticleControl(vectorTargetParticle_stalker, 0, origin );
		Particles.SetParticleControl(vectorTargetParticle_stalker, 1, Vector_add(origin, Vector_mult(forward, max_distance)));
    	$.Schedule(interval, ability_stalker_dark)
	}
}



var vectorTargetParticle_razor;

function ability_razor_current()
{

	let hero_id = Players.GetLocalPlayerPortraitUnit()
   	let modifier_main = HasModifierCustom(hero_id, "modifier_razor_unstable_current_custom_legendary")


	if (modifier_main)
	{
		if (vectorTargetParticle_razor == undefined) {
			vectorTargetParticle_razor = Particles.CreateParticle("particles/razor/surge_range.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) );
		}
	} else {
		if (vectorTargetParticle_razor) {
			Particles.DestroyParticleEffect(vectorTargetParticle_razor, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_razor)
			vectorTargetParticle_razor = undefined;
		}
	}

	if (vectorTargetParticle_razor)
	{
	    if (modifier_main)
	    {
	    	let max_time = Number(Game.GetTalentValue("modifier_razor_current_7", "duration"))
			let max_distance = Number(Game.GetTalentValue("modifier_razor_current_7", "max_distance"))
			let time = max_time - Buffs.GetRemainingTime(hero_id, modifier_main)

	    	let origin = Entities.GetAbsOrigin( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) )
	    	let forward = Entities.GetForward( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))

	    	let range = (time/max_time)*max_distance

	    	Particles.SetParticleControl(vectorTargetParticle_razor, 0, origin );
			Particles.SetParticleControl(vectorTargetParticle_razor, 1, Vector_add(origin, Vector_mult(forward, range)));
	    }
	}
    $.Schedule(interval, ability_razor_current)
}


function ability_hoodwink_ulti()
{
	if (HasModifier(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), "modifier_hoodwink_sharpshooter_custom") )
	{
		if (vectorTargetParticle_hoodwink == undefined) {
			vectorTargetParticle_hoodwink = Particles.CreateParticle(hoodwink_pfx, ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) );
		}
	} else {
		if (vectorTargetParticle_hoodwink) {
			Particles.DestroyParticleEffect(vectorTargetParticle_hoodwink, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_hoodwink)
			vectorTargetParticle_hoodwink = undefined;
		}
	}

	if (vectorTargetParticle_hoodwink)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = GameUI.GetScreenWorldPosition(cursor);

	    if (HasModifier(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), "modifier_hoodwink_sharpshooter_custom")  )
	    {
	    	let cast_range = Abilities.GetSpecialValueFor(Buffs.GetAbility( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), FindModifier(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), "modifier_hoodwink_sharpshooter_custom") ), "arrow_range");
	    	let origin = Entities.GetAbsOrigin( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ) )
	    	let forward = Entities.GetForward( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))
	    	Particles.SetParticleControl(vectorTargetParticle_hoodwink, 0, origin );
			Particles.SetParticleControl(vectorTargetParticle_hoodwink, 1, Vector_add(origin, Vector_mult(forward, cast_range)) );
	    }
	}

    $.Schedule(interval, ability_hoodwink_ulti)
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


var vectorTargetParticle_snapfire;
var lastAbility_snapfire = -1;




function ability_snapfire_scatter()
{

	if (Abilities.GetLocalPlayerActiveAbility() != lastAbility_snapfire) 
	{
		lastAbility_snapfire = Abilities.GetLocalPlayerActiveAbility()
		if (vectorTargetParticle_snapfire) {
			Particles.DestroyParticleEffect(vectorTargetParticle_snapfire, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_snapfire)
			vectorTargetParticle_snapfire = undefined;
		}
		if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "snapfire_scatterblast_custom") ) 
		{
			let name = "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_range_finder_aoe.vpcf"
			if (HasModifier(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), "modifier_snapfire_scatterblast_custom_reverse") )
			{
				name = "particles/snapfire/scatter_range.vpcf"
			}
			vectorTargetParticle_snapfire = Particles.CreateParticle(name, ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetLocalPlayerPortraitUnit() );
		}
	}

	if (vectorTargetParticle_snapfire)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = GameUI.GetScreenWorldPosition(cursor);
	    if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "snapfire_scatterblast_custom") ) 
	    {
	    	let point_blank = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "point_blank_range");
	    	let distance = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "distance");
	    	let blast_width_end = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "blast_width_end")
	    	let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )
	    	let width_start = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "blast_width_initial");

			if (HasModifier(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), "modifier_snapfire_scatterblast_custom_reverse") )
			{
				distance = Number(Game.GetTalentValue("modifier_snapfire_scatter_5", "range"))
				blast_width_end = Number(Game.GetTalentValue("modifier_snapfire_scatter_5", "width_end"))
				width_start = Number(Game.GetTalentValue("modifier_snapfire_scatter_5", "width_start"))
			}

	    	let k = (point_blank/distance)

	    	let direction = Vector_normalize(Vector_sub(origin, worldPosition));
	    	let cast_range = Abilities.GetCastRange( Abilities.GetLocalPlayerActiveAbility() )

	    	Particles.SetParticleControl(vectorTargetParticle_snapfire, 0, origin );

			if (HasModifier(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), "modifier_snapfire_scatterblast_custom_reverse") )
			{
				Particles.SetParticleControl(vectorTargetParticle_snapfire, 1, Vector_sub(origin, Vector_mult(direction, (cast_range + (blast_width_end*1.3) ))) );
				Particles.SetParticleControl(vectorTargetParticle_snapfire, 2, [width_start, blast_width_end, 0] );
				Particles.SetParticleControl(vectorTargetParticle_snapfire, 3, [width_start, (blast_width_end)/2, 0] );
			}
			else
			{
				Particles.SetParticleControl(vectorTargetParticle_snapfire, 1, Vector_sub(origin, Vector_mult(direction, (cast_range + (blast_width_end*0.7) ))) );
				Particles.SetParticleControl(vectorTargetParticle_snapfire, 2, [width_start/2, blast_width_end/2, 0] );
				Particles.SetParticleControl(vectorTargetParticle_snapfire, 3, [width_start/2, (blast_width_end*0.7)/2, 0] );
			}
			Particles.SetParticleControl(vectorTargetParticle_snapfire, 6, Vector_sub(origin, Vector_mult(direction, point_blank)) );
	    }
	}

    $.Schedule(interval, ability_snapfire_scatter)
}

var vectorTargetParticle_muerta;
var lastAbility_muerta = -1;

function ability_muerta_call()
{

	if (Game.HasTalent("npc_dota_hero_muerta", "modifier_muerta_calling_7"))
	{
		if (vectorTargetParticle_muerta) {
			Particles.DestroyParticleEffect(vectorTargetParticle_muerta, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_muerta)
			vectorTargetParticle_muerta = undefined;
		}
		return
	}

	if (Abilities.GetLocalPlayerActiveAbility() != lastAbility_muerta) 
	{
		lastAbility_muerta = Abilities.GetLocalPlayerActiveAbility()
		if (vectorTargetParticle_muerta) {
			Particles.DestroyParticleEffect(vectorTargetParticle_muerta, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_muerta)
			vectorTargetParticle_muerta = undefined;
		
		}
		if ( (Abilities.GetLocalPlayerActiveAbility() != 1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "muerta_the_calling_custom") ) {
			vectorTargetParticle_muerta = Particles.CreateParticle("particles/units/heroes/hero_muerta/muerta_calling_reticule_2.vpcf", ParticleAttachment_t.PATTACH_WORLDORIGIN, Players.GetLocalPlayerPortraitUnit() );
		}
	}

	if (vectorTargetParticle_muerta)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = GameUI.GetScreenWorldPosition(cursor);
	    if ( (Abilities.GetLocalPlayerActiveAbility() != 1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "muerta_the_calling_custom") ) 
		{
			let radius = 580
	    	let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )

	    	Particles.SetParticleControl(vectorTargetParticle_muerta, 1, [radius, radius, radius] );

		    let c = Math.sqrt( 2 ) * 0.5 * radius 
		    let x_offset = [ -radius+120, -c, 0.0, c, radius-120, c, 0.0, -c ]
		    let y_offset = [ 0.0, c, radius-120, c, 0.0, -c, -radius+120, -c ]

		    Particles.SetParticleControl(vectorTargetParticle_muerta, 0, worldPosition );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 2, Vector_add2(worldPosition,[x_offset[0], y_offset[0], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 3, Vector_add2(worldPosition,[x_offset[0], y_offset[0], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 4, Vector_add2(worldPosition,[x_offset[2], y_offset[2], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 5, Vector_add2(worldPosition,[x_offset[2], y_offset[2], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 6, Vector_add2(worldPosition,[x_offset[4], y_offset[4], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 7, Vector_add2(worldPosition,[x_offset[4], y_offset[4], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 8, Vector_add2(worldPosition,[x_offset[6], y_offset[6], 0]) );
		    Particles.SetParticleControl(vectorTargetParticle_muerta, 9, Vector_add2(worldPosition,[x_offset[6], y_offset[6], 0]) );
		}
	}

    $.Schedule(interval, ability_muerta_call)
}



function Vector_add2(vec1, vec2)
{
	if (vec1)
	{
		return [vec1[0] + vec2[0], vec1[1] + vec2[1], vec1[2] + vec2[2]];
	}
}






var vectorTargetParticle_sandking;
var lastAbility_sandking = -1;

function ability_sandking_stinger()
{
	if (Abilities.GetLocalPlayerActiveAbility() != lastAbility_sandking) 
	{
		lastAbility_sandking = Abilities.GetLocalPlayerActiveAbility()
		if (vectorTargetParticle_sandking) {
			Particles.DestroyParticleEffect(vectorTargetParticle_sandking, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_sandking)
			vectorTargetParticle_sandking = undefined;
		}
		if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "sandking_scorpion_strike_custom") ) {
			vectorTargetParticle_sandking = Particles.CreateParticle("particles/sand_king/stinger_target.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetLocalPlayerPortraitUnit() );
		}
	}

	if (vectorTargetParticle_sandking)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = GameUI.GetScreenWorldPosition(cursor);
	    if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "sandking_scorpion_strike_custom") ) {

	    	let radius = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "inner_radius");
	    	let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )

	    	Particles.SetParticleControl(vectorTargetParticle_sandking, 0, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_sandking, 1, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_sandking, 2, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_sandking, 3, [radius, radius, radius] );
	    }
	}
    $.Schedule(interval, ability_sandking_stinger)
}





var vectorTargetParticle_morphling;
var lastAbility_morphling = -1;

function ability_morphling_adaptive()
{
	if (Abilities.GetLocalPlayerActiveAbility() != lastAbility_morphling) 
	{
		lastAbility_morphling = Abilities.GetLocalPlayerActiveAbility()
		if (vectorTargetParticle_morphling) {
			Particles.DestroyParticleEffect(vectorTargetParticle_morphling, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_morphling)
			vectorTargetParticle_morphling = undefined;
		}
		if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "morphling_adaptive_strike_custom") ) {
			vectorTargetParticle_morphling = Particles.CreateParticle("particles/sand_king/stinger_target.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetLocalPlayerPortraitUnit() );
		}
	}

	if (vectorTargetParticle_morphling)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = GameUI.GetScreenWorldPosition(cursor);
	    if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "morphling_adaptive_strike_custom") ) {

	    	let radius = Number(Game.GetTalentValue("modifier_morphling_adaptive_7", "inner_radius"));
	    	let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )

	    	Particles.SetParticleControl(vectorTargetParticle_morphling, 0, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_morphling, 1, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_morphling, 2, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_morphling, 3, [radius, radius, radius] );
	    }
	}
    $.Schedule(interval, ability_morphling_adaptive)
}







var vectorTargetParticle_slark;
var lastAbility_slark = -1;

function ability_slark_pounce_legendary()
{

	if (Abilities.GetLocalPlayerActiveAbility() != lastAbility_slark) 
	{
		lastAbility_slark = Abilities.GetLocalPlayerActiveAbility()
		if (vectorTargetParticle_slark) {
			Particles.DestroyParticleEffect(vectorTargetParticle_slark, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_slark)
			vectorTargetParticle_slark = undefined;
		}
		if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "slark_pounce_custom_legendary") ) {
			vectorTargetParticle_slark = Particles.CreateParticle("particles/slark/pounce_legendary_ui.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetLocalPlayerPortraitUnit() );
		}
	}

	if (vectorTargetParticle_slark)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )
	    if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "slark_pounce_custom_legendary") ) {

	    	let radius = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "min_dist");
	    	let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )

	    	Particles.SetParticleControl(vectorTargetParticle_slark, 0, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_slark, 1, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_slark, 2, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_slark, 3, [radius, radius, radius] );
	    }
	}
    $.Schedule(interval, ability_slark_pounce_legendary)
}





var vectorTargetParticle_lifestealer;
var lastAbility_lifestealer = -1;

function ability_lifestealer_unfettered()
{

	if (Abilities.GetLocalPlayerActiveAbility() != lastAbility_lifestealer) 
	{
		lastAbility_lifestealer = Abilities.GetLocalPlayerActiveAbility()
		if (vectorTargetParticle_lifestealer) {
			Particles.DestroyParticleEffect(vectorTargetParticle_lifestealer, true)
			Particles.ReleaseParticleIndex(vectorTargetParticle_lifestealer)
			vectorTargetParticle_lifestealer = undefined;
		}
		if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "life_stealer_unfettered_custom") ) {
			vectorTargetParticle_lifestealer = Particles.CreateParticle("particles/slark/pounce_legendary_ui.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, Players.GetLocalPlayerPortraitUnit() );
		}
	}

	if (vectorTargetParticle_lifestealer)
	{
		const cursor = GameUI.GetCursorPosition();
		const worldPosition = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )
	    if ( (Abilities.GetLocalPlayerActiveAbility() != -1) && (Abilities.GetAbilityName(Abilities.GetLocalPlayerActiveAbility()) == "life_stealer_unfettered_custom") ) {

	    	let radius = Abilities.GetSpecialValueFor(Abilities.GetLocalPlayerActiveAbility(), "min_dist");
	    	let origin = Entities.GetAbsOrigin( Players.GetLocalPlayerPortraitUnit() )

	    	Particles.SetParticleControl(vectorTargetParticle_lifestealer, 0, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_lifestealer, 1, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_lifestealer, 2, worldPosition );
	    	Particles.SetParticleControl(vectorTargetParticle_lifestealer, 3, [radius, radius, radius] );
	    }
	}
    $.Schedule(interval, ability_lifestealer_unfettered)
}