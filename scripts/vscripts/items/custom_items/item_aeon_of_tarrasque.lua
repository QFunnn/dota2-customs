--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aeon_of_tarrasque", "items/custom_items/item_aeon_of_tarrasque", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_aeon_of_tarrasque_immunity",
	"items/custom_items/item_aeon_of_tarrasque",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_aeon_of_tarrasque_cooldown",
	"items/custom_items/item_aeon_of_tarrasque",
	LUA_MODIFIER_MOTION_NONE
)

item_aeon_of_tarrasque = item_aeon_of_tarrasque or class({})
item_aeon_of_tarrasque2 = item_aeon_of_tarrasque or class({})
item_aeon_of_tarrasque3 = item_aeon_of_tarrasque or class({})

function item_aeon_of_tarrasque:GetIntrinsicModifierName()
	return "modifier_aeon_of_tarrasque"
end

--------------------------------------------------------------------------------

modifier_aeon_of_tarrasque = class({})

function modifier_aeon_of_tarrasque:IsHidden()
	return true
end

function modifier_aeon_of_tarrasque:IsPurgable()
	return false
end

function modifier_aeon_of_tarrasque:RemoveOnDeath()
	return false
end

function modifier_aeon_of_tarrasque:OnCreated()
	self.strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.health = self:GetAbility():GetSpecialValueFor("bonus_health")
	self.regen = self:GetAbility():GetSpecialValueFor("health_regen_pct")
	self.mana = self:GetAbility():GetSpecialValueFor("bonus_mana")
	self.damage_from_hp = self:GetAbility():GetSpecialValueFor("damage_from_hp")
	self.health_threshold_pct = self:GetAbility():GetSpecialValueFor("health_threshold_pct") / 100.0
end

function modifier_aeon_of_tarrasque:OnRemoved()
	if not IsServer() then
		return
	end
	self:GetParent():RemoveModifierByName("modifier_aeon_of_tarrasque_immunity")
end

function modifier_aeon_of_tarrasque:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, --GetModifierBonusStats_Strength
		MODIFIER_PROPERTY_HEALTH_BONUS, --GetModifierHealthBonus
		-- MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE, --GetModifierHealthRegenPercentage
		MODIFIER_PROPERTY_MANA_BONUS, --GetModifierManaBonus,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, --GetModifierPreAttack_BonusDamage
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_aeon_of_tarrasque:GetModifierIncomingDamage_Percentage(kv)
	if not IsServer() then
		return
	end
	local attacker = kv.attacker
	local victim = kv.unit
	if victim ~= self:GetParent() and self:GetParent():IsIllusion() then
		return
	end
	if self:GetAbility():IsCooldownReady() then
		local buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
		local health_threshold = self:GetParent():GetHealth() / self:GetParent():GetMaxHealth()
		if
			(
				health_threshold < self.health_threshold_pct
				or ((self:GetParent():GetHealth() - kv.damage) / self:GetParent():GetMaxHealth())
					<= self.health_threshold_pct
			) and bit.band(kv.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS
		then
			-- self:GetParent():Purge( false, true, false, true, true )
			self:GetParent():AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_aeon_of_tarrasque_immunity",
				{ duration = 3.5 }
			)
			self:GetParent():SetHealth(
				math.min(self:GetParent():GetHealth(), self:GetParent():GetMaxHealth() * self.health_threshold_pct)
			)
			self:GetAbility():UseResources(false, false, false, true)
			return -100
		end
	end
end

function modifier_aeon_of_tarrasque:GetModifierBonusStats_Strength()
	return self.strength
end

function modifier_aeon_of_tarrasque:GetModifierHealthBonus()
	return self.health
end

-- function modifier_aeon_of_tarrasque:GetModifierHealthRegenPercentage()
-- return self.regen
-- end

function modifier_aeon_of_tarrasque:GetModifierManaBonus()
	return self.mana
end

function modifier_aeon_of_tarrasque:GetModifierPreAttack_BonusDamage()
	return self:GetCaster():GetHealth() / 100 * self.damage_from_hp
end

--------------------------------------------------------------------------------

modifier_aeon_of_tarrasque_immunity = class({})

function modifier_aeon_of_tarrasque_immunity:IsPurgable()
	return false
end

function modifier_aeon_of_tarrasque_immunity:GetTexture()
	return "item_aeon_disk"
end

function modifier_aeon_of_tarrasque_immunity:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_aeon_of_tarrasque_immunity:OnCreated(kv)
	if IsServer() then
		if not self:GetAbility() then
			self:Destroy()
		end
	end
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	self.buff_health_regen_pct = self:GetAbility():GetSpecialValueFor("buff_health_regen_pct")

	if IsServer() then
		local parent = self:GetParent()
		self.ability = self:GetAbility()
		local combo_breaker_particle = ParticleManager:CreateParticle(
			"particles/items4_fx/combo_breaker_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			combo_breaker_particle,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)
		self:AddParticle(combo_breaker_particle, false, false, -1, true, false)
	end
end

function modifier_aeon_of_tarrasque_immunity:GetModifierIncomingDamage_Percentage()
	return -100
end

function modifier_aeon_of_tarrasque_immunity:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end

function modifier_aeon_of_tarrasque_immunity:GetModifierStatusResistanceStacking()
	return self.status_resistance
end

function modifier_aeon_of_tarrasque_immunity:GetModifierHealthRegenPercentage()
	return self.buff_health_regen_pct
end