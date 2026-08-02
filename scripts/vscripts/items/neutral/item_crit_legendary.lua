--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_crit_legendary = class({})
LinkLuaModifier("modifier_item_crit_legendary", "items/neutral/item_crit_legendary.lua", LUA_MODIFIER_MOTION_NONE)

function item_crit_legendary:GetIntrinsicModifierName()
	return "modifier_item_crit_legendary"
end

modifier_item_crit_legendary = class({})

function modifier_item_crit_legendary:IsHidden()
	return true
end
function modifier_item_crit_legendary:IsPurgable()
	return false
end
function modifier_item_crit_legendary:RemoveOnDeath()
	return false
end
function modifier_item_crit_legendary:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_crit_legendary:OnCreated(kv)
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance") -- special value
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult") -- special value
end

function modifier_item_crit_legendary:OnDestroy(kv) end

function modifier_item_crit_legendary:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_item_crit_legendary:GetModifierPreAttack_CriticalStrike(params)
	local Random = RandomInt(0, 100)
	if Random <= self.crit_chance then
		return self.crit_mult
	else
		return 0
	end
end