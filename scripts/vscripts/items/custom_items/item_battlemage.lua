--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_battlemage_arsenal", "items/custom_items/item_battlemage", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_battlemage_arsenal_attack_buff",
	"items/custom_items/item_battlemage",
	LUA_MODIFIER_MOTION_NONE
)

item_battlemage = item_battlemage or class({})
item_battlemage_2 = item_battlemage or class({})
item_battlemage_3 = item_battlemage or class({})

function item_battlemage:GetIntrinsicModifierName()
	return "modifier_battlemage_arsenal"
end

function item_battlemage:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()

	caster
		:AddNewModifier(caster, self, "modifier_battlemage_arsenal_attack_buff", {
			duration = self:GetSpecialValueFor("duration"),
		})
		:SetStackCount(self:GetSpecialValueFor("hits"))

	EmitSoundOn("Item.Brooch.Cast", caster)
end

-------------------------------------------------------------------------------------------

modifier_battlemage_arsenal = class({})

function modifier_battlemage_arsenal:IsHidden()
	return true
end
function modifier_battlemage_arsenal:IsPurgable()
	return false
end

function modifier_battlemage_arsenal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
	}
	return funcs
end

function modifier_battlemage_arsenal:OnCreated()
	local ability = self:GetAbility()

	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_intellect = ability:GetSpecialValueFor("bonus_intellect")
	self.bonus_spell_amp = ability:GetSpecialValueFor("bonus_spell_amp")
	self.bonus_attack_speed = ability:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
	self.bonus_mana_regen = ability:GetSpecialValueFor("bonus_mana_regen")
	self.projectile_speed = ability:GetSpecialValueFor("projectile_speed")
end

function modifier_battlemage_arsenal:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_battlemage_arsenal:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_battlemage_arsenal:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_battlemage_arsenal:GetModifierSpellAmplify_Percentage()
	return self.bonus_spell_amp
end

function modifier_battlemage_arsenal:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_battlemage_arsenal:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_battlemage_arsenal:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

function modifier_battlemage_arsenal:GetModifierProjectileSpeedBonus()
	return self.projectile_speed
end

-------------------------------------------------------------------------------------------

modifier_battlemage_arsenal_attack_buff = class({})

function modifier_battlemage_arsenal_attack_buff:IsHidden()
	return false
end
function modifier_battlemage_arsenal_attack_buff:IsPurgable()
	return false
end

function modifier_battlemage_arsenal_attack_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_battlemage_arsenal_attack_buff:GetModifierTotalDamageOutgoing_Percentage(params)
	if params.inflictor then
		return
	end
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if params.damage_type ~= DAMAGE_TYPE_PHYSICAL then
		return
	end

	if params.attacker:HasModifier("modifier_muerta_pierce_the_veil_lua") then
		return
	end

	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
		if not params.target:IsMagicImmune() then
			ApplyDamage({
				victim = params.target,
				attacker = self:GetParent(),
				damage = params.original_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flag = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK
					+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
					+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			})
			EmitSoundOn("Hero_Muerta.PierceTheVeil.ProjectileImpact", params.target)
		else
			EmitSoundOn("Hero_Muerta.PierceTheVeil.ProjectileImpact.MagicImmune", params.target)
		end
		if self:GetStackCount() == 0 then
			self:Destroy()
		end
	end

	return -200
end

function modifier_battlemage_arsenal_attack_buff:GetOverrideAttackMagical()
	return 1
end

function modifier_battlemage_arsenal_attack_buff:GetModifierProjectileName()
	return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf"
end

function modifier_battlemage_arsenal_attack_buff:GetEffectName()
	return "particles/items5_fx/revenant_brooch.vpcf"
end