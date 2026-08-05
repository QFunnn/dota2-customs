--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_god_tribute", "items/d_items/item_god_tribute", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_god_tribute = item_god_tribute or class({})
item_god_tribute2 = item_god_tribute or class({})
item_god_tribute3 = item_god_tribute or class({})
item_god_tribute4 = item_god_tribute or class({})
item_god_tribute5 = item_god_tribute or class({})

function item_god_tribute:GetIntrinsicModifierName()
	return "modifier_item_god_tribute"
end

function item_god_tribute:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_god_tribute:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_god_tribute:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_god_tribute = class({})

function modifier_item_god_tribute:IsHidden()
	return true
end

function modifier_item_god_tribute:IsPurgable()
	return false
end

function modifier_item_god_tribute:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.bonus_intellect = self:GetAbility():GetSpecialValueFor("bonus_intellect")
	self.mana_regen_sec = self:GetAbility():GetSpecialValueFor("mana_regen_sec")
	self.rupture_chance = self:GetAbility():GetSpecialValueFor("rupture_chance")
	self.refresh_pct = self:GetAbility():GetSpecialValueFor("refresh_pct")
end

function modifier_item_god_tribute:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_god_tribute:OnAbilityFullyCast(params)
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return 0
		end
		local Ability = params.ability
		if Ability == nil then
			return 0
		end

		if
			Ability:IsRefreshable()
			and Ability:GetName() ~= "hero_pangolier_blade_of_the_exile"
			and Ability:IsItem() == false
			and RollPercentage(self.refresh_pct)
		then
			Ability:EndCooldown()
			local nFXIndex = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(nFXIndex, 1, Vector(1, 2, 1))
			ParticleManager:ReleaseParticleIndex(nFXIndex)
			EmitSoundOn("Bogduggs.LuckyFemur", self:GetParent())
		end
	end
	return 0
end

function modifier_item_god_tribute:GetModifierBonusStats_Intellect(params)
	return self.bonus_intellect
end

function modifier_item_god_tribute:GetModifierConstantManaRegen(params)
	return self.mana_regen_sec
end

function modifier_item_god_tribute:OnAttackLanded(params)
	if IsServer() then
		if params.attacker == self:GetParent() and RollPercentage(self.rupture_chance) then
			if params.target ~= nil then
				ApplyDamage({
					victim = params.target,
					attacker = params.attacker,
					damage = self.damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				})
				local Attacker = params.attacker
				local Target = params.target
				EmitSoundOn("Dungeon.FireTrap", self:GetCaster())
				local nFXIndex = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_leshrac/leshrac_pulse_nova.vpcf",
					PATTACH_WORLDORIGIN,
					Attacker
				)
				ParticleManager:SetParticleControl(nFXIndex, 0, Target:GetOrigin())
				ParticleManager:SetParticleControl(
					nFXIndex,
					1,
					Vector(self.damage_radius, self.damage_radius, self.damage_radius)
				)
				ParticleManager:ReleaseParticleIndex(nFXIndex)
			end
		end
	end
	return 0
end