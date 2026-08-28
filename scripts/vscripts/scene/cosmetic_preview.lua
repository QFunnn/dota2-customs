--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "scene/cosmetic_preview"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["5"] = 1,
		["6"] = 1,
		["7"] = 7,
		["8"] = 7,
		["9"] = 7,
		["10"] = 7,
		["11"] = 7,
		["12"] = 7,
		["13"] = 14,
		["14"] = 15,
		["15"] = 16,
		["16"] = 17,
		["17"] = 18,
		["18"] = 19,
		["19"] = 19,
		["20"] = 19,
		["21"] = 19,
		["22"] = 19,
		["23"] = 19,
		["24"] = 19,
		["25"] = 19,
		["26"] = 19,
		["27"] = 20,
		["28"] = 20,
		["29"] = 20,
		["30"] = 20,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 21,
		["37"] = 21,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 22,
		["42"] = 22,
		["43"] = 22,
		["44"] = 23,
		["45"] = 24,
		["46"] = 22,
		["47"] = 22,
		["48"] = 22,
		["49"] = 14,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
f(nil, "Spawn", function(g, h) end)
thisEntity.Launch = function(g, i)
	local j = Entities:Next(thisEntity)
	local k = 255
	local l = (thisEntity:GetAbsOrigin() - j:GetAbsOrigin()):Length()
	local m = ParticleManager:CreateParticle(i, PATTACH_CUSTOMORIGIN_FOLLOW, thisEntity)
	ParticleManager:SetParticleControlEnt(
		m,
		0,
		thisEntity,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		thisEntity:GetAbsOrigin(),
		false
	)
	ParticleManager:SetParticleControlEnt(m, 1, j, PATTACH_POINT_FOLLOW, "attach_hitloc", j:GetAbsOrigin(), false)
	ParticleManager:SetParticleControl(m, 2, Vector(k, 0, 0))
	thisEntity:SetContextThink("proj_" .. tostring(m), function()
		ParticleManager:DestroyParticle(m, false)
		return 0
	end, l / k)
end
return d