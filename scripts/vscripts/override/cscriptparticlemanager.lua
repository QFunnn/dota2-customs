--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "override/CScriptParticleManager"
local b = require("lualib_bundle")
local c = b.__TS__StringStartsWith
ParticleEffectLevel = ParticleEffectLevel or {}
ParticleEffectLevel.Low = "low"
ParticleEffectLevel.Medium = "medium"
ParticleEffectLevel.High = "high"
if CScriptParticleManager.CreateParticle_Engine == nil then
	CScriptParticleManager.CreateParticle_Engine = CScriptParticleManager.CreateParticle
end
CScriptParticleManager.CreateParticle = function(self, d, e, f)
	return ParticleManager:CreateParticleWithCaster(d, e, f, f)
end
CScriptParticleManager.CreateParticleWithCaster = function(self, d, e, f, g, h)
	if h == nil then
		h = ParticleEffectLevel.Medium
	end
	if c(d, "particles/warning/") then
		return ParticleManager:CreateParticleForce(d, e, f)
	end
	local i = IsServer() and -1 or GetLocalPlayerID()
	if IsServer() and IsValid(g) and g.GetPlayerOwnerID ~= nil then
		local j = g:GetPlayerOwnerID()
		if PlayerResource:IsValidPlayerID(j) then
			i = j
		end
	end
	if ParticleClear:CanCreate(i, h) then
		ParticleClear:Record(i)
		if Cosmetic ~= nil then
			d = Cosmetic:GetParticleReplacement(f, d)
		end
		return ParticleManager:CreateParticle_Engine(d, e, f)
	end
	return -1
end
CScriptParticleManager.CreateParticleForce = function(self, d, e, f)
	if Cosmetic ~= nil then
		d = Cosmetic:GetParticleReplacement(f, d)
	end
	return ParticleManager:CreateParticle_Engine(d, e, f)
end