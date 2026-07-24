--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



function init()
{
	GameEvents.Subscribe_custom('vo_npc_dota_hero_juggernaut', vo_npc_dota_hero_juggernaut)
	GameEvents.Subscribe_custom('vo_stop_sound', vo_stop_sound)
	GameEvents.Subscribe_custom('vo_make_sound', vo_make_sound)
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max) + 1;
}

const gcd = 1.5
const movecd = 6
const killcd = 30


var current_sound = null
var move_attack_cd = false 
var last_move = 0
var last_attack = 0
var lasthid_cd = false
var global_cd = false

function IsMove(n)
{
	return (n == 1 || n == 2)
}
function IsAttack(n)
{
	return (n == 3 || n == 4)
}

function UseCd()
{

	global_cd = true

	$.Schedule(gcd, function()
	{ 	
		global_cd = false 
	})

}


function vo_stop_sound()
{
	if (current_sound !== null)
	{
		Game.StopSound(current_sound)
	}
	
	UseCd()
}


function vo_make_sound(kv)
{
	if (kv.timer)
	{

		$.Schedule(kv.timer, function()
		{
		//	Game.EmitSound(kv.sound)
		})
		return	
	}


	current_sound = Game.EmitSound(kv.sound)
	UseCd()	
}

function vo_npc_dota_hero_juggernaut(kv)
{
	if (global_cd == true)
	{
		return
	}

	let ord = kv.type

	if ((IsMove(ord) || IsAttack(ord)) && move_attack_cd == false)
	{	
		let random = 0 
		let vo = ""

		if (IsMove(ord))
		{
			random = last_move

			while (random == last_move || random == 8)
			{
				random = getRandomInt(19)
			}

			last_move = random
			vo = "juggernaut_jug_move_"
		}

		if (IsAttack(ord))
		{
			random = last_attack

			while (random == last_attack)
			{
				random = getRandomInt(13)
			}

			last_attack = random
			vo = "juggernaut_jug_attack_"
		}

		let str = String(random)

		if (random < 10)
		{
			str = '0' + str 
		}

		if (vo !== "")
		{
			current_sound = Game.EmitSound(vo + str)
			UseCd()	
		}
		
		move_attack_cd = true 

		$.Schedule(movecd, function()
		{ 	
			move_attack_cd = false 
		})
	}

	if (ord == 500 && lasthid_cd == false)
	{
		lasthid_cd = true

		let random = getRandomInt(12)
		let str = String(random)

		if (random < 10)
		{
			str = '0' + str 
		}

		current_sound = Game.EmitSound("juggernaut_jug_lasthit_" + str)	
		UseCd()	

		$.Schedule(killcd, function()
		{ 	
			lasthid_cd = false 
		})	
	}
}


init()