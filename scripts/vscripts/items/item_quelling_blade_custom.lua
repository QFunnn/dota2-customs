--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_quelling_blade_custom", "items/item_quelling_blade_custom", LUA_MODIFIER_MOTION_NONE)

item_quelling_blade_custom = class({})

function item_quelling_blade_custom:CastFilterResultTarget(hTarget)
	if not IsServer() then return end
	if hTarget:IsOther() then
		if hTarget:GetName() == "npc_dota_ward_base" or hTarget:GetName() == "npc_dota_ward_base_truesight" then
			return UF_SUCCESS
		end
	end
	if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if (hTarget:IsCreep() or (hTarget:IsOther() and (string.find(hTarget:GetName(), "npc_dota_ward_base") or string.find(hTarget:GetName(), "npc_dota_techies_mines")))) then
			return UF_SUCCESS
		elseif hTarget:IsOther() and not (string.find(hTarget:GetName(), "npc_dota_ward_base") or string.find(hTarget:GetName(), "npc_dota_techies_mines")) then
			return UF_FAIL_CUSTOM
		end
	end
	local nResult = UnitFilter( hTarget, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
	return nResult
end

function item_quelling_blade_custom:GetCustomCastErrorTarget(hTarget)
	if not IsServer() then return end
	if hTarget:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then 
		if hTarget:IsOther() and not (string.find(hTarget:GetName(), "npc_dota_ward_base") or string.find(hTarget:GetName(), "npc_dota_techies_mines")) then
			return "Ability Can't Target This Ward-Type Unit"
		end
	end
end

function item_quelling_blade_custom:GetCastRange(location, target)
	return self.BaseClass.GetCastRange(self, location, target)
end

function item_quelling_blade_custom:GetCooldown(level)
	return self.BaseClass.GetCooldown(self, level)
end

function item_quelling_blade_custom:GetIntrinsicModifierName()
	return "modifier_item_quelling_blade_custom"
end

function item_quelling_blade_custom:OnSpellStart()
	if not IsServer() then return end
	if self:GetCursorTarget().CutDown then
		self:GetCursorTarget():CutDown(self:GetCaster():GetTeamNumber())
	end
	GridNav:DestroyTreesAroundPoint(self:GetCursorTarget():GetAbsOrigin(), 10, true)
end

modifier_item_quelling_blade_custom = class({})
function modifier_item_quelling_blade_custom:AllowIllusionDuplicate()	return false end
function modifier_item_quelling_blade_custom:IsPurgable()	return false end
function modifier_item_quelling_blade_custom:RemoveOnDeath() return false end
function modifier_item_quelling_blade_custom:IsHidden() return true end
function modifier_item_quelling_blade_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_quelling_blade_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.attack_range = self.ability:GetSpecialValueFor("attack_range")
    self.quelling_bonus = self.ability:GetSpecialValueFor("quelling_bonus")
    self.quelling_bonus_ranged = self.ability:GetSpecialValueFor("quelling_bonus_ranged")
end

function modifier_item_quelling_blade_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
	return funcs
end

function modifier_item_quelling_blade_custom:GetModifierAttackRangeBonus()
	if self.parent:IsRangedAttacker() then return 0 end
    return self.attack_range
end

function modifier_item_quelling_blade_custom:GetModifierProcAttack_BonusDamage_Physical( keys )
	if not IsServer() then return end
	if (self.parent:FindAllModifiersByName("modifier_item_quelling_blade_custom")[1] == self) and keys.target and not keys.target:IsHero() and not keys.target:IsOther() and not keys.target:IsBuilding() and not string.find(keys.target:GetUnitName(), "npc_dota_lone_druid_bear") and keys.target:GetTeamNumber() ~= self.parent:GetTeamNumber() then
		if not self.parent:IsRangedAttacker() then
			return self.quelling_bonus
		else
			return self.quelling_bonus_ranged
		end
	end
end