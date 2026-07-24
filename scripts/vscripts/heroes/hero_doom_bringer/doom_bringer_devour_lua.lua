--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_doom_bringer_devour_lua", "heroes/hero_doom_bringer/doom_bringer_devour_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if doom_bringer_devour_lua == nil then
	doom_bringer_devour_lua = class({})
end
function doom_bringer_devour_lua:CastFilterResultTarget(hTarget)
	local hCaster = self:GetCaster()
	if not IsValid(hTarget) then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end
	if hTarget.IsInvulnerable and type(hTarget.IsInvulnerable) == "function" and hTarget:IsInvulnerable() then
		self.error_msg = "dota_hud_error_target_invulnerable"
		return UF_FAIL_CUSTOM
	end
	if hTarget:IsRoshan() then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end
	if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hCaster:GetTeamNumber()) ~= UF_SUCCESS then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end
function doom_bringer_devour_lua:GetCustomCastErrorTarget(hTarget)
	return self.error_msg
end
function doom_bringer_devour_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()

	if IsValid(hCaster) and IsValid(hTarget) and hTarget:IsAlive() and UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS, hCaster:GetTeamNumber()) == UF_SUCCESS then
		hTarget:Kill(self, hCaster)

		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hCaster)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0, 0, 0), true)
		ParticleManager:ReleaseParticleIndex(iParticleID)

		EmitSoundOn("Hero_DoomBringer.Devour", hCaster)

		if hCaster:IsAlive() then
			local duration = self:GetEffectiveCooldown(-1)
			hCaster:AddNewModifier(hCaster, self, "modifier_doom_bringer_devour_lua", { duration = duration })
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_doom_bringer_devour_lua == nil then
	modifier_doom_bringer_devour_lua = class({})
end
function modifier_doom_bringer_devour_lua:IsHidden()
	return false
end
function modifier_doom_bringer_devour_lua:IsDebuff()
	return false
end
function modifier_doom_bringer_devour_lua:IsPurgable()
	return false
end
function modifier_doom_bringer_devour_lua:IsPurgeException()
	return false
end
function modifier_doom_bringer_devour_lua:RemoveOnDeath()
	return false
end
function modifier_doom_bringer_devour_lua:OnCreated(params)
	self.armor = self:GetAbilitySpecialValueFor("armor")
	self.magic_resist = self:GetAbilitySpecialValueFor("magic_resist")
	self.bonus_gold = self:GetAbilitySpecialValueFor("bonus_gold")
	self.health = self:GetAbilitySpecialValueFor("health")
	if IsServer() then
	end
end
function modifier_doom_bringer_devour_lua:OnRefresh(params)
	self.armor = self:GetAbilitySpecialValueFor("armor")
	self.magic_resist = self:GetAbilitySpecialValueFor("magic_resist")
	self.bonus_gold = self:GetAbilitySpecialValueFor("bonus_gold")
	self.health = self:GetAbilitySpecialValueFor("health")
	if IsServer() then
	end
end
function modifier_doom_bringer_devour_lua:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		if IsValid(hParent) then
			hParent:ModifyGoldFiltered(self.bonus_gold, false, DOTA_ModifyGold_AbilityGold)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, hParent, self.bonus_gold, nil)
		end
	end
end
function modifier_doom_bringer_devour_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
	}
end
function modifier_doom_bringer_devour_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end
function modifier_doom_bringer_devour_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end
function modifier_doom_bringer_devour_lua:GetModifierExtraHealthBonus()
	return self.health
end
function modifier_doom_bringer_devour_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end