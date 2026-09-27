--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


item_guardian_greaves_custom = class({})

LinkLuaModifier(
	"modifier_item_guardian_greaves_custom",
	"abilities/items/item_guardian_greaves_custom",
	LUA_MODIFIER_MOTION_NONE
)

function item_guardian_greaves_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items3_fx/warmage.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/warmage_recipient.vpcf", context)
end

function item_guardian_greaves_custom:GetIntrinsicModifierName()
	return "modifier_item_guardian_greaves_custom"
end

function item_guardian_greaves_custom:Spawn()
	self.bonus_movement = self:GetSpecialValueFor("bonus_movement")
	self.bonus_armor = self:GetSpecialValueFor("bonus_armor")
	self.bonus_mana_regen = self:GetSpecialValueFor("bonus_mana_regen")
	self.bonus_mana = self:GetSpecialValueFor("bonus_mana")
	self.aura_health_regen = self:GetSpecialValueFor("aura_health_regen")
	self.aura_reduction = self:GetSpecialValueFor("aura_reduction")
	self.aura_bonus_threshold = self:GetSpecialValueFor("aura_bonus_threshold")
	self.replenish_health = self:GetSpecialValueFor("replenish_health")
	self.replenish_mana = self:GetSpecialValueFor("replenish_mana")
	self.radius = self:GetSpecialValueFor("radius")
end

function item_guardian_greaves_custom:OnSpellStart()
	local caster = self:GetCaster()
	local heal = self.replenish_health / 100
	local mana = self.replenish_mana / 100
	local radius = self.radius

	local player_id = caster:GetPlayerOwnerID()
	local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_mekansm")
	local default_effect = "particles/items3_fx/warmage.vpcf"
	local default_effect_recipient = "particles/items3_fx/warmage_recipient.vpcf"
	if custom_effect_data then
		default_effect = custom_effect_data[1]
		default_effect_recipient = custom_effect_data[2]
	end

	caster:EmitSound("Item.GuardianGreaves.Activate")
	caster:GenericParticle(default_effect)
	caster:Purge(false, true, false, false, false)

	local friends = caster:FindFriends(radius, nil, nil, DOTA_UNIT_TARGET_FLAG_INVULNERABLE)

	for _, friend in pairs(friends) do
		local heal_amount = heal * friend:GetMaxHealth()
		local mana_amount = mana * friend:GetMaxMana()

		friend:GiveMana(mana_amount)
		friend:SendNumber(OVERHEAD_ALERT_MANA_ADD, mana_amount)
		friend:GenericHeal(heal_amount, self)

		friend:EmitSound("Item.GuardianGreaves.Target")
		local particle_2 = ParticleManager:CreateParticle(default_effect_recipient, PATTACH_ABSORIGIN_FOLLOW, friend)
		ParticleManager:SetParticleControl(particle_2, 0, friend:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(
			particle_2,
			1,
			friend,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			friend:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle_2)
	end
end

modifier_item_guardian_greaves_custom = class(mod_hidden)
function modifier_item_guardian_greaves_custom:IsHidden()
	return self.parent:GetHealthPercent() > self.ability.aura_bonus_threshold
end
function modifier_item_guardian_greaves_custom:RemoveOnDeath()
	return false
end
function modifier_item_guardian_greaves_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if self.parent:IsRealHero() then
		self.parent:AddDamageEvent_inc(self, true)
	end
end

function modifier_item_guardian_greaves_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_guardian_greaves_custom:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not self.parent:IsRealHero() then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.aura_bonus_threshold then
		return
	end
	if self.ability:GetCooldownTimeRemaining() > 0 then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end

	self.ability:StartCd()
	self.ability:OnSpellStart()
end

function modifier_item_guardian_greaves_custom:GetModifierManaBonus()
	return self.ability.bonus_mana
end

function modifier_item_guardian_greaves_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self.ability.bonus_movement
end

function modifier_item_guardian_greaves_custom:GetModifierConstantManaRegen()
	return self.ability.bonus_mana_regen
end

function modifier_item_guardian_greaves_custom:GetModifierPhysicalArmorBonus()
	return self.ability.bonus_armor
end

function modifier_item_guardian_greaves_custom:GetModifierConstantHealthRegen()
	return self.ability.aura_health_regen
end

function modifier_item_guardian_greaves_custom:GetModifierIncomingDamage_Percentage()
	if self.parent:GetHealthPercent() < self.ability.aura_bonus_threshold then
		return self.ability.aura_reduction
	end
end