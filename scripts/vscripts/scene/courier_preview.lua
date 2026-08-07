--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/courier_preview"
local b = require("lualib_bundle")
local c = b.__TS__StringIncludes
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["6"] = 1,
		["7"] = 1,
		["8"] = 18,
		["9"] = 19,
		["10"] = 19,
		["11"] = 19,
		["12"] = 19,
		["13"] = 20,
		["14"] = 21,
		["16"] = 22,
		["17"] = 22,
		["18"] = 23,
		["19"] = 24,
		["20"] = 22,
		["23"] = 27,
		["24"] = 28,
		["25"] = 29,
		["26"] = 30,
		["28"] = 32,
		["29"] = 33,
		["30"] = 34,
		["31"] = 35,
		["32"] = 35,
		["33"] = 35,
		["34"] = 35,
		["35"] = 35,
		["36"] = 35,
		["37"] = 34,
		["39"] = 45,
		["40"] = 46,
		["41"] = 46,
		["42"] = 46,
		["43"] = 46,
		["44"] = 46,
		["45"] = 46,
		["46"] = 45,
		["48"] = 56,
		["49"] = 57,
		["50"] = 58,
		["51"] = 59,
		["52"] = 59,
		["53"] = 59,
		["54"] = 59,
		["55"] = 59,
		["56"] = 59,
		["57"] = 59,
		["58"] = 59,
		["59"] = 59,
		["63"] = 19,
		["64"] = 19,
		["65"] = 65,
		["66"] = 65,
		["67"] = 65,
		["68"] = 65,
		["69"] = 66,
		["70"] = 67,
		["71"] = 68,
		["72"] = 69,
		["73"] = 70,
		["74"] = 65,
		["75"] = 65,
		["76"] = 72,
		["77"] = 72,
		["78"] = 72,
		["79"] = 72,
		["80"] = 73,
		["81"] = 74,
		["82"] = 72,
		["83"] = 72,
		["84"] = 76,
		["85"] = 76,
		["86"] = 76,
		["87"] = 76,
		["88"] = 77,
		["89"] = 79,
		["90"] = 80,
		["91"] = 81,
		["92"] = 82,
		["93"] = 83,
		["94"] = 84,
		["95"] = 86,
		["96"] = 87,
		["97"] = 87,
		["98"] = 87,
		["99"] = 87,
		["100"] = 87,
		["102"] = 89,
		["103"] = 89,
		["104"] = 89,
		["105"] = 89,
		["106"] = 89,
		["108"] = 92,
		["109"] = 92,
		["110"] = 92,
		["111"] = 92,
		["112"] = 92,
		["113"] = 92,
		["114"] = 92,
		["115"] = 92,
		["116"] = 92,
		["117"] = 93,
		["118"] = 93,
		["119"] = 93,
		["120"] = 93,
		["121"] = 93,
		["122"] = 94,
		["123"] = 94,
		["124"] = 94,
		["125"] = 95,
		["126"] = 96,
		["127"] = 94,
		["128"] = 94,
		["129"] = 94,
		["130"] = 98,
		["131"] = 99,
		["132"] = 100,
		["133"] = 100,
		["134"] = 100,
		["135"] = 101,
		["136"] = 103,
		["137"] = 104,
		["138"] = 104,
		["139"] = 104,
		["140"] = 104,
		["141"] = 104,
		["143"] = 106,
		["144"] = 106,
		["145"] = 106,
		["146"] = 106,
		["147"] = 106,
		["148"] = 106,
		["149"] = 106,
		["150"] = 106,
		["151"] = 106,
		["153"] = 108,
		["154"] = 108,
		["155"] = 108,
		["156"] = 108,
		["157"] = 108,
		["158"] = 108,
		["159"] = 108,
		["160"] = 108,
		["161"] = 108,
		["162"] = 109,
		["163"] = 109,
		["164"] = 109,
		["165"] = 109,
		["166"] = 109,
		["167"] = 110,
		["168"] = 110,
		["169"] = 110,
		["170"] = 111,
		["171"] = 112,
		["172"] = 110,
		["173"] = 110,
		["174"] = 110,
		["175"] = 114,
		["176"] = 100,
		["177"] = 100,
		["178"] = 100,
		["179"] = 76,
		["180"] = 76,
		["181"] = 117,
		["182"] = 117,
		["183"] = 117,
		["184"] = 117,
		["185"] = 118,
		["186"] = 119,
		["187"] = 120,
		["188"] = 120,
		["189"] = 120,
		["190"] = 120,
		["191"] = 120,
		["192"] = 120,
		["193"] = 120,
		["194"] = 120,
		["195"] = 120,
		["196"] = 117,
		["197"] = 117,
		["198"] = 122,
		["199"] = 122,
		["200"] = 122,
		["201"] = 122,
		["202"] = 123,
		["203"] = 124,
		["204"] = 122,
		["205"] = 122,
	}
)
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.registerEntityFunction
local h = false
g(nil, "Spawn", function(i, j)
	entities = {}
	local k = thisEntity
	do
		local l = 0
		while l < 19 do
			entities[k:GetName()] = k
			k = Entities:Next(k)
			l = l + 1
		end
	end
	ParticleManager:DestroyParticle(attackerParticle or -1, false)
	if attackerModel ~= "" then
		if IsValid(entities.attacker) then
			entities.attacker:RemoveSelf()
		end
		h = c(attackerModel, "/wards/")
		if h then
			entities.attacker = SpawnEntityFromTableSynchronous(
				"prop_dynamic_clientside",
				{
					origin = "0 -256 0",
					angles = "0 90 0",
					model = attackerModel,
					StartingAnim = "ACT_DOTA_CAPTURE",
					StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
					use_animgraph = "1",
				}
			)
		else
			entities.attacker = SpawnEntityFromTableSynchronous(
				"prop_dynamic_clientside",
				{
					origin = "0 -256 0",
					angles = "0 90 0",
					model = attackerModel,
					StartingAnim = "ACT_DOTA_ATTACK",
					StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
					use_animgraph = "1",
				}
			)
		end
		if IsValid(entities.attacker) then
			if attackerModel == "models/heroes/wisp/wisp.vmdl" then
				attackerParticle = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_wisp/wisp_ambient.vpcf",
					PATTACH_CUSTOMORIGIN_FOLLOW,
					entities.attacker
				)
				ParticleManager:SetParticleControlEnt(
					attackerParticle,
					0,
					entities.attacker,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					Vector(0, 0, 0),
					true
				)
			end
		end
	end
end)
g(nil, "Clear", function()
	ParticleManager:DestroyParticle(ambientParticle or -1, false)
	ParticleManager:DestroyParticle(holyLightParticle or -1, false)
	ParticleManager:DestroyParticle(projectileParticle or -1, false)
	ParticleManager:DestroyParticle(trailParticle or -1, false)
	thisEntity:StopThink("projectile")
end)
g(nil, "SwitchToAmbient", function(i, m)
	Clear(nil)
	ambientParticle = ParticleManager:CreateParticle(m, PATTACH_ABSORIGIN_FOLLOW, entities.courier)
end)
g(nil, "SwitchToProjectile", function(i, m)
	Clear(nil)
	local n = (entities.attacker:GetAbsOrigin() - entities.dummy:GetAbsOrigin()):Length()
	local o = 1000
	local p = n / o
	local q = 3
	local r = h
	local s = ParticleManager:CreateParticle(m, PATTACH_CUSTOMORIGIN, entities.attacker)
	if r then
		ParticleManager:SetParticleControl(s, 0, entities.attacker:GetAbsOrigin() + Vector(0, 0, 128))
	else
		ParticleManager:SetParticleControl(s, 0, entities.attacker:GetAbsOrigin() + Vector(0, 0, 64))
	end
	ParticleManager:SetParticleControlEnt(
		s,
		1,
		entities.dummy,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		entities.attacker:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControl(s, 2, Vector(o, 0, 0))
	thisEntity:SetContextThink("projectile_" .. tostring(s), function()
		ParticleManager:DestroyParticle(s, false)
		return nil
	end, p)
	projectileName = m
	projectileParticle = s
	thisEntity:SetContextThink("projectile", function()
		local s = ParticleManager:CreateParticle(m, PATTACH_CUSTOMORIGIN, entities.attacker)
		if r then
			ParticleManager:SetParticleControl(s, 0, entities.attacker:GetAbsOrigin() + Vector(0, 0, 128))
		else
			ParticleManager:SetParticleControlEnt(
				s,
				0,
				entities.attacker,
				PATTACH_POINT_FOLLOW,
				"attach_attack1",
				entities.attacker:GetAbsOrigin(),
				false
			)
		end
		ParticleManager:SetParticleControlEnt(
			s,
			1,
			entities.dummy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			entities.attacker:GetAbsOrigin(),
			false
		)
		ParticleManager:SetParticleControl(s, 2, Vector(o, 0, 0))
		thisEntity:SetContextThink("projectile_" .. tostring(s), function()
			ParticleManager:DestroyParticle(s, false)
			return nil
		end, p)
		return q
	end, q)
end)
g(nil, "SwitchToTrail", function(i, m)
	Clear(nil)
	trailParticle = ParticleManager:CreateParticle(m, PATTACH_ABSORIGIN_FOLLOW, entities.runner)
	ParticleManager:SetParticleControlEnt(
		trailParticle,
		1,
		entities.runner,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		entities.runner:GetAbsOrigin(),
		true
	)
end)
g(nil, "SwitchToHolyLight", function(i, m)
	Clear(nil)
	holyLightParticle = ParticleManager:CreateParticle(m, PATTACH_ABSORIGIN_FOLLOW, entities.holy_light_dummy_0)
end)
return e