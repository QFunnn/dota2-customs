--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_ghost_walk_lua = class({})
LinkLuaModifier( "modifier_invoker_ghost_walk_lua", "heroes/hero_invoker/modifier_invoker_ghost_walk_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_lua_debuff", "heroes/hero_invoker/modifier_invoker_ghost_walk_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_ghost_walk_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_ghost_walk_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	self:PlayEffects()
end

function invoker_ghost_walk_lua:GetCooldown(level)
    if not IsServer() then return end
    local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_invoker_10")
    if talent and talent:GetLevel() > 0 then
        return self.BaseClass.GetCooldown(self, level) - talent:GetSpecialValueFor("value")
    end
    return self.BaseClass.GetCooldown(self, level)
end



function invoker_ghost_walk_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf"
	local sound_cast = "Hero_Invoker.GhostWalk"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end