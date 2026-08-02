--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_glaz_sudby", "items/custom_items/item_glaz_sudby_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_glaz_sudby_effect", "items/custom_items/item_glaz_sudby_lua.lua", LUA_MODIFIER_MOTION_NONE)

item_glaz_sudby_1 = item_glaz_sudby_1 or class({})
item_glaz_sudby_2 = item_glaz_sudby_1 or class({})
item_glaz_sudby_3 = item_glaz_sudby_1 or class({})

function item_glaz_sudby_1:GetIntrinsicModifierName()
	return "modifier_glaz_sudby"
end

function item_glaz_sudby_1:OnSpellStart()
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeam(),
		caster:GetOrigin(),
		nil,
		700,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	caster:EmitSound("DOTA_Item.DustOfAppearance.Activate")
	local particle =
		ParticleManager:CreateParticle("particles/items_fx/dust_of_appearance.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 1, Vector(700, 700, 700))

	for _, enemy in ipairs(enemies) do
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_glaz_sudby_effect",
			{ duration = self:GetSpecialValueFor("duration") }
		)
	end
end

------------------------------------------------------------

modifier_glaz_sudby = class({})

function modifier_glaz_sudby:IsHidden()
	return true
end

function modifier_glaz_sudby:IsPurgable()
	return false
end

function modifier_glaz_sudby:RemoveOnDeath()
	return false
end

function modifier_glaz_sudby:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_glaz_sudby:OnCreated()
	self.bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.crit_chance = self:GetAbility():GetSpecialValueFor("crit_chance")
	self.crit_damage = self:GetAbility():GetSpecialValueFor("crit_damage")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_glaz_sudby:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_glaz_sudby:GetModifierBonusStats_Agility()
	return self.bonus_agility
end

function modifier_glaz_sudby:GetModifierBaseAttack_BonusDamage()
	return self.damage
end

function modifier_glaz_sudby:GetModifierPreAttack_CriticalStrike(keys)
	if
		self:GetAbility()
		and (keys.target and not keys.target:IsOther() and not keys.target:IsBuilding() and keys.target:GetTeamNumber() ~= self
			:GetParent()
			:GetTeamNumber())
		and RandomInt(1, 100) <= self.crit_chance
	then
		return self.crit_damage
	end
end

---------------------------------------------------------------------------

modifier_glaz_sudby_effect = class({})

function modifier_glaz_sudby_effect:IsHidden()
	return true
end

function modifier_glaz_sudby_effect:IsPurgable()
	return false
end

function modifier_glaz_sudby_effect:RemoveOnDeath()
	return false
end

function modifier_glaz_sudby_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}
end

function modifier_glaz_sudby_effect:GetEffectName()
	return "particles/items2_fx/true_sight_debuff.vpcf"
end

function modifier_glaz_sudby_effect:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_glaz_sudby_effect:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_glaz_sudby_effect:CheckState()
	return { [MODIFIER_STATE_INVISIBLE] = false }
end

function modifier_glaz_sudby_effect:GetModifierProvidesFOWVision()
	return 1
end

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Амулет Ярости
item_amulet_of_rage = class({})

function item_amulet_of_rage:GetIntrinsicModifierName()
	return "modifier_amulet_of_rage"
end

modifier_amulet_of_rage = class({})

function modifier_amulet_of_rage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_BONUS,
	}
end

function modifier_amulet_of_rage:GetModifierManaBonus()
	return 100
end

function item_amulet_of_rage:OnSpellStart()
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_amulet_of_rage_buff", { duration = 5 })
	self:StartCooldown(40)
end

modifier_amulet_of_rage_buff = class({})

function modifier_amulet_of_rage_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_amulet_of_rage_buff:GetModifierAttackSpeedBonus_Constant()
	return 50
end

-- Шлем Бури
item_helmet_of_storm = class({})

function item_helmet_of_storm:GetIntrinsicModifierName()
	return "modifier_helmet_of_storm"
end

modifier_helmet_of_storm = class({})

function modifier_helmet_of_storm:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_helmet_of_storm:GetModifierPhysicalArmorBonus()
	return 25
end

function item_helmet_of_storm:OnSpellStart()
	local caster = self:GetCaster()
	local radius = 500
	local duration = 5

	-- Вихрь вокруг героя
	local enemies = FindUnitsInRadius(
		caster:GetTeam(),
		caster:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in ipairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = 100, -- Урон вихря (можно настроить)
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end

	-- Увеличение брони
	caster:AddNewModifier(caster, self, "modifier_helmet_of_storm_buff", { duration = duration })
	self:StartCooldown(30)
end

modifier_helmet_of_storm_buff = class({})

function modifier_helmet_of_storm_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_helmet_of_storm_buff:GetModifierPhysicalArmorBonus()
	return 20
end

-- Перчатки Вечного Огня
item_gloves_of_eternal_fire = class({})

function item_gloves_of_eternal_fire:GetIntrinsicModifierName()
	return "modifier_gloves_of_eternal_fire"
end

modifier_gloves_of_eternal_fire = class({})

function modifier_gloves_of_eternal_fire:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
end

function modifier_gloves_of_eternal_fire:GetModifierBaseAttack_BonusDamage()
	return 30
end

function item_gloves_of_eternal_fire:OnSpellStart()
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_gloves_of_eternal_fire_buff", { duration = 5 })
	self:StartCooldown(30)
end

modifier_gloves_of_eternal_fire_buff = class({})

function modifier_gloves_of_eternal_fire_buff:OnCreated()
	if IsServer() then
		self.burn_damage = 0.5 * self:GetParent():GetBaseDamage()
	end
end

function modifier_gloves_of_eternal_fire_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}
end

function modifier_gloves_of_eternal_fire_buff:GetModifierBaseAttack_BonusDamage()
	return self.burn_damage
end

function modifier_gloves_of_eternal_fire_buff:GetEffectName()
	return "particles/items2_fx/mekansm_blink.vpcf"
end