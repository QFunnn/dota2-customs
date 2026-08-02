--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_lich_heart", "items/custom_items/item_lich_heart.lua", LUA_MODIFIER_MOTION_NONE)

item_lich_heart = class({})

function item_lich_heart:GetIntrinsicModifierName()
	return "modifier_item_lich_heart"
end

--------------------------------------

modifier_item_lich_heart = class({})

function modifier_item_lich_heart:IsHidden()
	return true
end

function modifier_item_lich_heart:IsDebuff()
	return false
end

function modifier_item_lich_heart:IsPurgable()
	return false
end

function modifier_item_lich_heart:OnCreated(kv)
	if IsServer() then
		self.hp_back = self:GetAbility():GetSpecialValueFor("hp_back")
		self.mp_back = self:GetAbility():GetSpecialValueFor("mp_back")
	end
end

function modifier_item_lich_heart:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
	return funcs
end

function modifier_item_lich_heart:OnDeath(params)
	if self:GetParent() == params.unit then
		UTIL_Remove(self:GetAbility())
	end
end

function modifier_item_lich_heart:OnAbilityFullyCast(params)
	if
		IsServer()
		and self:GetAbility()
		and params.unit == self:GetParent()
		and self:GetCaster():IsRealHero()
		and self:GetCaster():IsAlive()
	then
		if params.ability:IsItem() then
			return
		end
		self:GetParent():Heal(self.hp_back, self:GetParent())
		self:GetParent():GiveMana(self.mp_back)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), self.hp_back, nil)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, self:GetParent(), self.mp_back, nil)
	end
end