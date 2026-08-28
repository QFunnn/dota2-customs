--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_crit_blade", "items/d_items/item_crit_blade", LUA_MODIFIER_MOTION_NONE)

item_crit_blade = item_crit_blade or class({})
item_crit_blade2 = item_crit_blade or class({})
item_crit_blade3 = item_crit_blade or class({})
item_crit_blade4 = item_crit_blade or class({})
item_crit_blade5 = item_crit_blade or class({})

function item_crit_blade:GetIntrinsicModifierName()
	return "modifier_item_crit_blade"
end

function item_crit_blade:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_crit_blade:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_crit_blade:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------

modifier_item_crit_blade = class({})

function modifier_item_crit_blade:IsHidden()
	return true
end

function modifier_item_crit_blade:IsPurgable()
	return false
end

function modifier_item_crit_blade:GetTexture()
	return "crit_blade"
end

function modifier_item_crit_blade:OnCreated(kv)
	self.agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
	self.crit = self:GetAbility():GetSpecialValueFor("crit")
	self.crit_damage = self:GetAbility():GetSpecialValueFor("crit_damage")
end

function modifier_item_crit_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_crit_blade:GetModifierBonusStats_Agility(params)
	return self.agility
end

function modifier_item_crit_blade:GetModifierAttackSpeedBonus_Constant(params)
	return self.attack_speed
end

function modifier_item_crit_blade:GetModifierPreAttack_CriticalStrike(params)
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end
		if RandomInt(0, 100) < self.crit then
			self.record = params.record
			return self.crit_damage
		end
	end
end

function modifier_item_crit_blade:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		if self.record and self.record == params.record then
			self.record = nil
			EmitSoundOn("Hero_Juggernaut.BladeDance", params.target)
		end
	end
end