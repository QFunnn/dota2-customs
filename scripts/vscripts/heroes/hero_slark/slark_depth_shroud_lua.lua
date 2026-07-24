--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slark_depth_shroud_lua_thinker", "heroes/hero_slark/slark_depth_shroud_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slark_depth_shroud_lua", "heroes/hero_slark/slark_depth_shroud_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
-- if slark_depth_shroud_lua == nil then
slark_depth_shroud_lua = class({})
-- end
function slark_depth_shroud_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function slark_depth_shroud_lua:OnSpellStart()
	local position = self:GetCursorPosition()
	local hCaster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	CreateModifierThinker(hCaster, self, "modifier_slark_depth_shroud_lua_thinker", { duration = duration }, position, hCaster:GetTeamNumber(), false)
end
---------------------------------------------------------------------
--Modifiers
if modifier_slark_depth_shroud_lua_thinker == nil then
	modifier_slark_depth_shroud_lua_thinker = class({})
end
function modifier_slark_depth_shroud_lua_thinker:IsAura()
	return true
end
function modifier_slark_depth_shroud_lua_thinker:IsHidden()
	return true
end
function modifier_slark_depth_shroud_lua_thinker:GetAuraDuration()
	return 0
end
function modifier_slark_depth_shroud_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_slark_depth_shroud_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end
function modifier_slark_depth_shroud_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_slark_depth_shroud_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end
function modifier_slark_depth_shroud_lua_thinker:GetModifierAura()
	return "modifier_slark_depth_shroud_lua"
end

function modifier_slark_depth_shroud_lua_thinker:OnCreated(params)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	if IsServer() then
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_slark/slark_shard_depth_shroud.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(iParticleID, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 1, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 2, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 3, self:GetParent():GetAbsOrigin())
		self:AddParticle(iParticleID, false, false, -1, false, false)
		EmitSoundOnLocationWithCaster(self:GetParent():GetAbsOrigin(), "Hero_Slark.ShadowDance", self:GetParent())
	end
end
function modifier_slark_depth_shroud_lua_thinker:OnDestroy()
	if IsServer() then
		self:GetParent():StopSound("Hero_Slark.ShadowDance")
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_slark_depth_shroud_lua == nil then
	modifier_slark_depth_shroud_lua = class({})
end
function modifier_slark_depth_shroud_lua:IsDebuff()
	return false
end
function modifier_slark_depth_shroud_lua:IsPurgable()
	return false
end

function modifier_slark_depth_shroud_lua:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true
	}
end
function modifier_slark_depth_shroud_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
	}
end
function modifier_slark_depth_shroud_lua:GetModifierInvisibilityLevel()
	return 1
end
function modifier_slark_depth_shroud_lua:GetModifierInvisibilityAttackBehaviorException()
	return 1
end