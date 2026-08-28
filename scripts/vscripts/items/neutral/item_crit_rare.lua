--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_crit_rare = class({})
LinkLuaModifier("modifier_item_crit_rare", "items/neutral/item_crit_rare.lua", LUA_MODIFIER_MOTION_NONE)

function item_crit_rare:GetIntrinsicModifierName()
	return "modifier_item_crit_rare"
end

modifier_item_crit_rare = class({})

function modifier_item_crit_rare:IsHidden()
	return true
end
function modifier_item_crit_rare:IsPurgable()
	return false
end
function modifier_item_crit_rare:RemoveOnDeath()
	return false
end
function modifier_item_crit_rare:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_crit_rare:OnCreated(kv)
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance") -- special value
	self.crit_mult = self:GetAbility():GetSpecialValueFor("crit_mult") -- special value
end

function modifier_item_crit_rare:OnDestroy(kv) end

function modifier_item_crit_rare:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_item_crit_rare:GetModifierPreAttack_CriticalStrike(params)
	local Random = RandomInt(0, 100)
	if Random <= self.crit_chance then
		return self.crit_mult
	else
		return 0
	end
end