--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_greater_crit_lua",
	"items/custom_items/item_greater_crit_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)

item_greater_crit_lua1 = item_greater_crit_lua1 or class({})
item_greater_crit_lua2 = item_greater_crit_lua1 or class({})
item_greater_crit_lua3 = item_greater_crit_lua1 or class({})

function item_greater_crit_lua1:GetIntrinsicModifierName()
	return "modifier_item_greater_crit_lua"
end

----------------------------------------------------------

modifier_item_greater_crit_lua = class({})

function modifier_item_greater_crit_lua:IsHidden()
	return true
end
function modifier_item_greater_crit_lua:IsPurgable()
	return false
end
function modifier_item_greater_crit_lua:RemoveOnDeath()
	return false
end
function modifier_item_greater_crit_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_greater_crit_lua:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.crit_multiplier = self:GetAbility():GetSpecialValueFor("crit_multiplier")
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
end

function modifier_item_greater_crit_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_item_greater_crit_lua:GetModifierPreAttack_CriticalStrike(keys)
	local target = keys.target
	if not target then
		return
	end
	if target:IsOther() or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
		return
	end
	if not RollPseudoRandom(self.crit_chance, self) then
		return
	end

	return self.crit_multiplier
end

function modifier_item_greater_crit_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function RollPseudoRandom(base_chance, entity)
	local ran = RandomInt(1, 100)
	if base_chance >= ran then
		return true
	else
		return false
	end
end