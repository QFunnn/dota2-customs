--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gang_letter", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_effect", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_fade", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_ghost_letter", "item_ability/item_gang_ghost_letter.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_gang_ghost_letter == nil then
	item_gang_ghost_letter = class({})
end
function item_gang_ghost_letter:OnSpellStart()
	local hCaster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local aura_radius = self:GetSpecialValueFor("aura_radius")
	if IsValid(hCaster) and hCaster:IsAlive() then
		EmitSoundOn("Item.Brooch.Cast", hCaster)
		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, aura_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() and unit:HasModifier("modifier_item_gang_letter_effect") then
				unit:AddNewModifier(hCaster, self, "modifier_item_gang_ghost_letter", { duration = duration })
			end
		end
	end
end
function item_gang_ghost_letter:GetIntrinsicModifierName()
	return "modifier_item_gang_letter"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_gang_ghost_letter == nil then
	modifier_item_gang_ghost_letter = class({})
end
function modifier_item_gang_ghost_letter:IsDebuff(params)
	return false
end
function modifier_item_gang_ghost_letter:IsHidden(params)
	return false
end
function modifier_item_gang_ghost_letter:IsPurgable(params)
	return false
end
function modifier_item_gang_ghost_letter:IsPurgeException(params)
	return false
end
function modifier_item_gang_ghost_letter:OnCreated()
	self.bonus_spell_amp_active = self:GetAbilitySpecialValueFor("bonus_spell_amp_active")
	if IsServer() then
	end
end
function modifier_item_gang_ghost_letter:OnRefresh()
	self.bonus_spell_amp_active = self:GetAbilitySpecialValueFor("bonus_spell_amp_active")
	if IsServer() then
	end
end
function modifier_item_gang_ghost_letter:GetEffectName()
	return "particles/items5_fx/revenant_brooch.vpcf"
end
function modifier_item_gang_ghost_letter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_gang_ghost_letter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function modifier_item_gang_ghost_letter:GetOverrideAttackMagical(params)
	return 1
end
function modifier_item_gang_ghost_letter:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end
function modifier_item_gang_ghost_letter:GetModifierSpellAmplify_Percentage(params)
	local hCaster = self:GetCaster()
	if IsServer() then
		if IsValid(hCaster) and hCaster:GetUnitLabel() ~= "spirit_bear" then
			return hCaster:GetSpellAmplification(false) * 100
		end
	end
end