--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_block_shield", "items/d_items/item_block_shield", LUA_MODIFIER_MOTION_NONE)

item_block_shield = item_block_shield or class({})
item_block_shield2 = item_block_shield or class({})
item_block_shield3 = item_block_shield or class({})
item_block_shield4 = item_block_shield or class({})
item_block_shield5 = item_block_shield or class({})

function item_block_shield:GetIntrinsicModifierName()
	return "modifier_item_block_shield"
end

function item_block_shield:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_block_shield:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_block_shield:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_block_shield = class({})

function modifier_item_block_shield:IsHidden()
	return true
end

function modifier_item_block_shield:IsPurgable()
	return false
end

function modifier_item_block_shield:OnCreated(kv)
	self.block = self:GetAbility():GetSpecialValueFor("block")
	self.helth_recovery = self:GetAbility():GetSpecialValueFor("helth_recovery")
end

function modifier_item_block_shield:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_block_shield:GetModifierPhysical_ConstantBlockUnavoidablePreArmor(params)
	return self.damage_block
end

function modifier_item_block_shield:OnTakeDamage(keys)
	if IsServer() and self:GetAbility() then
		local parent = self:GetParent()
		local attacker = keys.attacker
		local target = keys.unit
		if not target:IsRealHero() then
			return nil
		end
		if
			attacker
			and attacker:GetTeamNumber() ~= parent:GetTeamNumber()
			and parent == target
			and not attacker:IsOther()
			and attacker:GetName() ~= "npc_dota_unit_undying_zombie"
			and not attacker:IsBuilding()
		then
			parent:Heal(self.helth_recovery, self:GetAbility())
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, self.helth_recovery, nil)
		end
	end
end