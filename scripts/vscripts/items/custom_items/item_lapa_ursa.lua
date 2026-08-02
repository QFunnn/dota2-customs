--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_lapa_ursa", "items/custom_items/item_lapa_ursa.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_lapa_ursa_debuff", "items/custom_items/item_lapa_ursa.lua", LUA_MODIFIER_MOTION_NONE)

item_lapa_ursa = class({})

function item_lapa_ursa:GetIntrinsicModifierName()
	return "modifier_item_lapa_ursa"
end

--------------------------------------

modifier_item_lapa_ursa = class({})

function modifier_item_lapa_ursa:IsHidden()
	return true
end

function modifier_item_lapa_ursa:IsDebuff()
	return false
end

function modifier_item_lapa_ursa:IsPurgable()
	return false
end

function modifier_item_lapa_ursa:OnCreated(kv)
	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
		self.duration = self:GetAbility():GetSpecialValueFor("duration")
	end
end

function modifier_item_lapa_ursa:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_item_lapa_ursa:OnDeath(params)
	if self:GetParent() == params.unit then
		UTIL_Remove(self:GetAbility())
	end
end

function modifier_item_lapa_ursa:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() then
		local target = params.target
		if target == nil then
			target = params.unit
		end
		if target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return 0
		end

		local stack = 0
		local modifier =
			target:FindModifierByNameAndCaster("modifier_item_lapa_ursa_debuff", self:GetAbility():GetCaster())

		if modifier == nil then
			target:AddNewModifier(
				self:GetAbility():GetCaster(),
				self:GetAbility(),
				"modifier_item_lapa_ursa_debuff",
				{ duration = self.duration }
			)
			stack = 1
		else
			modifier:IncrementStackCount()
			modifier:ForceRefresh()
			stack = modifier:GetStackCount()
		end
		return stack * self.damage
	end
end

-------------------------------------------------------------------

modifier_item_lapa_ursa_debuff = class({})

function modifier_item_lapa_ursa_debuff:IsHidden()
	return false
end

function modifier_item_lapa_ursa_debuff:IsDebuff()
	return true
end

function modifier_item_lapa_ursa_debuff:IsPurgable()
	return false
end

function modifier_item_lapa_ursa_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_item_lapa_ursa_debuff:OnTooltip()
	return self:GetStackCount() * self.damagePerStack
end

function modifier_item_lapa_ursa_debuff:OnCreated(kv)
	self:SetStackCount(1)

	self.damagePerStack = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_item_lapa_ursa_debuff:OnRefresh(kv) end

function modifier_item_lapa_ursa_debuff:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf"
end

function modifier_item_lapa_ursa_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end