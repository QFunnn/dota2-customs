--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_crit_common = class({})
LinkLuaModifier("modifier_item_crit_common", "items/neutral/item_crit_common.lua", LUA_MODIFIER_MOTION_NONE)

function item_crit_common:GetIntrinsicModifierName()
	return "modifier_item_crit_common"
end

modifier_item_crit_common = class({})

function modifier_item_crit_common:IsHidden()
	return true
end
function modifier_item_crit_common:IsPurgable()
	return false
end
function modifier_item_crit_common:RemoveOnDeath()
	return false
end
function modifier_item_crit_common:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_crit_common:OnCreated(kv)
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance") -- special value
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult") -- special value
end

function modifier_item_crit_common:OnDestroy(kv) end

function modifier_item_crit_common:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_item_crit_common:GetModifierPreAttack_CriticalStrike(params)
	local Random = RandomInt(0, 100)
	if Random <= self.crit_chance then
		return self.crit_mult
	else
		return 0
	end
end