--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



----------------------------------------------------------------------
spider_explode_lua = class({})

LinkLuaModifier( "modifier_spider_nethertoxin_lua", "creature_ability/modifier/modifier_spider_nethertoxin_lua", LUA_MODIFIER_MOTION_NONE )


function spider_explode_lua:OnOwnerDied()
	
	if IsServer() then
        
        local flDuration = self:GetSpecialValueFor( "duration" )
        local flRadius = self:GetSpecialValueFor( "radius" )
        
        local nParticle = ParticleManager:CreateParticle( "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", PATTACH_ABSORIGIN_FOLLOW, nil )
		ParticleManager:SetParticleControl(nParticle, 0, self:GetCaster():GetAbsOrigin())
		ParticleManager:SetParticleControl(nParticle, 1, Vector(flRadius, 1, 1))
		ParticleManager:SetParticleControl(nParticle, 15, Vector(255,153,102))
		ParticleManager:SetParticleControl(nParticle, 16, Vector(1,0,0))
        
        EmitSoundOn("Hero_Broodmother.SpawnSpiderlings", self:GetCaster())

		CreateModifierThinker(
			self:GetCaster(),
			self,
			"modifier_spider_nethertoxin_lua",
			{ duration = flDuration },
			self:GetCaster():GetAbsOrigin(),
			self:GetCaster():GetTeamNumber(),
			false
		)
	end
end
---------------------------------------------------------