--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_doom_bringer_devour_lua", "heroes/hero_doom_bringer/doom_bringer_devour_lua.lua",
	LUA_MODIFIER_MOTION_NONE)

if doom_bringer_devour_lua == nil then
	doom_bringer_devour_lua = class({}) ---@class doom_bringer_devour_lua : CDOTA_Ability_Lua
end

function doom_bringer_devour_lua:CastFilterResultTarget(target)
	local caster = self:GetCaster()
	if not IsValid(target) then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end
	if target.IsInvulnerable and type(target.IsInvulnerable) == "function" and target:IsInvulnerable() then
		self.error_msg = "dota_hud_error_target_invulnerable"
		return UF_FAIL_CUSTOM
	end
	if target:GetUnitName() == "npc_dota_roshan" then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end
	if UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, caster:GetTeamNumber()) ~= UF_SUCCESS then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function doom_bringer_devour_lua:GetCustomCastErrorTarget(hTarget)
	return self.error_msg
end

function doom_bringer_devour_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if IsValid(caster) and
		IsValid(target) and ---@cast target CDOTA_BaseNPC
		target:IsAlive() and
		UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS, caster:GetTeamNumber()) == UF_SUCCESS
	then
		target:Kill(self, caster)

		local iParticleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc",
			Vector(0, 0, 0), true)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, target, PATTACH_POINT_FOLLOW, "attach_attack1",
			Vector(0, 0, 0), true)
		ParticleManager:ReleaseParticleIndex(iParticleID)

		EmitSoundOn("Hero_DoomBringer.Devour", caster)

		if caster:IsAlive() then
			local duration = self:GetEffectiveCooldown(-1)
			if self:GetMaxAbilityCharges(-1) > 0 then
				duration = self:GetAbilityChargeRestoreTime(-1)
			end
			caster:AddNewModifier(caster, self, "modifier_doom_bringer_devour_lua", { duration = duration })
		end
	end
end

---------------------------------------------------------------------
if modifier_doom_bringer_devour_lua == nil then
	modifier_doom_bringer_devour_lua = class({}) ---@class modifier_doom_bringer_devour_lua : CDOTA_Modifier_Lua
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

function modifier_doom_bringer_devour_lua:OnCreated()
	local ability = self:GetAbility()
	if not ability then return end
	self.armor = ability:GetSpecialValueFor("armor")
	self.magic_resist = ability:GetSpecialValueFor("magic_resist")
	self.bonus_gold = ability:GetSpecialValueFor("bonus_gold")
	self.health = ability:GetSpecialValueFor("health")
end

function modifier_doom_bringer_devour_lua:OnRefresh()
	self:OnCreated()
end

function modifier_doom_bringer_devour_lua:OnDestroy()
	if not IsServer() then return end

	local hParent = self:GetParent()
	if IsValid(hParent) then
		hParent:ModifyGoldFiltered(self.bonus_gold, false, DOTA_ModifyGold_AbilityGold)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, hParent, self.bonus_gold, nil)
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