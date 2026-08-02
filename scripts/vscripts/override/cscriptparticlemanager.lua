--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "override/CScriptParticleManager"
if CScriptParticleManager.CreateParticle_Engine == nil then
	CScriptParticleManager.CreateParticle_Engine = CScriptParticleManager.CreateParticle
end
CScriptParticleManager.CreateParticle = function(self, b, c, d)
	local e = IsServer() and -1 or GetLocalPlayerID()
	if IsServer() and IsValid(d) and d.GetPlayerOwnerID ~= nil then
		local f = d:GetPlayerOwnerID()
		if PlayerResource:IsValidPlayerID(f) then
			e = f
		end
	end
	if ParticleClear:CanCreate(e) then
		ParticleClear:Record(e)
		if Cosmetic ~= nil then
			b = Cosmetic:GetParticleReplacement(d, b)
		end
		return ParticleManager:CreateParticle_Engine(b, c, d)
	end
	return -1
end
CScriptParticleManager.CreateParticleForce = function(self, b, c, d)
	if Cosmetic ~= nil then
		b = Cosmetic:GetParticleReplacement(d, b)
	end
	return ParticleManager:CreateParticle_Engine(b, c, d)
end