--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_doom_sword", "items/d_items/item_doom_sword", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_doom_sword_effect", "items/d_items/item_doom_sword", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_doom_sword = item_doom_sword or class({})
item_doom_sword2 = item_doom_sword or class({})
item_doom_sword3 = item_doom_sword or class({})
item_doom_sword4 = item_doom_sword or class({})
item_doom_sword5 = item_doom_sword or class({})

function item_doom_sword:GetIntrinsicModifierName()
	return "modifier_item_doom_sword"
end

function item_doom_sword:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_doom_sword:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_doom_sword:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------

item_doom_sword2 = class({})

function item_doom_sword2:GetIntrinsicModifierName()
	return "modifier_item_doom_sword"
end

function item_doom_sword2:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_doom_sword2:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_doom_sword2:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------

item_doom_sword3 = class({})

function item_doom_sword3:GetIntrinsicModifierName()
	return "modifier_item_doom_sword"
end

function item_doom_sword3:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_doom_sword3:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_doom_sword3:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_doom_sword = class({})

function modifier_item_doom_sword:IsHidden()
	return true
end

function modifier_item_doom_sword:IsPurgable()
	return false
end

function modifier_item_doom_sword:IsAura()
	return true
end

function modifier_item_doom_sword:GetTexture()
	return "cursed_bloodthorn"
end

function modifier_item_doom_sword:GetModifierAura()
	return "modifier_item_doom_sword_effect"
end

function modifier_item_doom_sword:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_doom_sword:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_item_doom_sword:GetAuraRadius()
	return self.radius
end

function modifier_item_doom_sword:OnCreated(kv)
	self.bonus_damage_pct = self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
	self.radius = self:GetAbility():GetSpecialValueFor("AbilityCastRange")
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	self.lifesteal_pct = self:GetAbility():GetSpecialValueFor("lifesteal_pct")
end

function modifier_item_doom_sword:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_doom_sword:GetModifierBaseDamageOutgoing_Percentage(params)
	return self.bonus_damage_pct
end

function modifier_item_doom_sword:GetModifierBonusStats_Strength(params)
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_doom_sword:GetModifierBonusStats_Agility(params)
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_doom_sword:GetModifierBonusStats_Intellect(params)
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_doom_sword:OnAttackLanded(params)
	if IsServer() then
		local Target = params.target
		local Attacker = params.attacker
		if Attacker ~= nil and Attacker == self:GetParent() and Target ~= nil then
			local full_heal = params.damage * self.lifesteal_pct / 100

			local allies = FindUnitsInRadius(
				Attacker:GetTeamNumber(),
				self:GetCaster():GetOrigin(),
				self:GetCaster(),
				450,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
				0,
				false
			)

			for i = #allies, 1, -1 do
				if allies[i] == nil or not allies[i]:HasModifier("modifier_item_doom_sword_effect") then
					table.remove(allies, i)
				end
			end

			local total_missing_hp = 0

			for _, ally in ipairs(allies) do
				local missing_hp = ally:GetHealth() / (ally:GetMaxHealth() / 100)
				total_missing_hp = total_missing_hp + missing_hp
			end

			if total_missing_hp == 0 then
				return
			end

			for _, ally in ipairs(allies) do
				local missing_hp = ally:GetHealth() / (ally:GetMaxHealth() / 100)
				local heal_amount = (missing_hp / total_missing_hp) * full_heal
				ally:Heal(heal_amount, self:GetAbility())
				local nFXIndex = ParticleManager:CreateParticle(
					"particles/generic_gameplay/generic_lifesteal.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					ally
				)
				ParticleManager:ReleaseParticleIndex(nFXIndex)
			end
		end
	end
	return 0
end

------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

modifier_item_doom_sword_effect = class({})

function modifier_item_doom_sword_effect:GetTexture()
	return "cursed_bloodthorn"
end

function modifier_item_doom_sword_effect:OnCreated(kv)
	self.lifesteal_pct = self:GetAbility():GetSpecialValueFor("lifesteal_pct")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_item_doom_sword_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_doom_sword_effect:GetModifierConstantHealthRegen(params)
	return self.hp_regen
end