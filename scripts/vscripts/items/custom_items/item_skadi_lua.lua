--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_skadi_lua1 = item_skadi_lua1 or class({})
item_skadi_lua2 = item_skadi_lua1 or class({})
item_skadi_lua3 = item_skadi_lua1 or class({})

LinkLuaModifier("modifier_item_skadi_lua", "items/custom_items/item_skadi_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_skadi_slow_lua", "items/custom_items/item_skadi_lua.lua", LUA_MODIFIER_MOTION_NONE)

modifier_item_skadi_lua = class({})
modifier_item_skadi_slow_lua = class({})

function item_skadi_lua1:GetIntrinsicModifierName()
	return "modifier_item_skadi_lua"
end

function modifier_item_skadi_lua:IsHidden()
	return true
end

function modifier_item_skadi_lua:IsPurgable()
	return false
end

function modifier_item_skadi_lua:DestroyOnExpire()
	return false
end

function modifier_item_skadi_lua:RemoveOnDeath()
	return false
end

function modifier_item_skadi_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_skadi_lua:OnCreated()
	if not IsServer() then
		return
	end
	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mana")
	self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_item_skadi_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_item_skadi_lua:OnDeath(params)
	local parent = self:GetParent()
	if
		(params.attacker == parent or params.attacker:GetOwner() == parent)
		and params.unit:HasModifier("modifier_item_skadi_slow_lua")
	then
		local nearby_enemy_units = FindUnitsInRadius(
			parent:GetTeam(),
			params.unit:GetAbsOrigin(),
			params.unit,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		parent:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Target")

		for _, enemy in pairs(nearby_enemy_units) do
			if enemy ~= params.unit and enemy:IsAlive() then
				local projectile = {
					Target = enemy,
					Source = params.unit,
					Ability = self:GetAbility(),
					EffectName = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf",
					iMoveSpeed = 600,
					vSourceLoc = params.unit:GetAbsOrigin(),
					bDrawsOnMinimap = false,
					bDodgeable = true,
					bIsAttack = false,
					bVisibleToEnemies = true,
					bReplaceExisting = false,
					flExpireTime = GameRules:GetGameTime() + 10,
					-- bProvidesVision 	= true,
					-- iVisionRadius 		= 400,
					-- iVisionTeamNumber 	= parent:GetTeamNumber(),
				}

				ProjectileManager:CreateTrackingProjectile(projectile)
			end
		end
	end
end

function item_skadi_lua1:OnProjectileHit(target)
	if target and target:IsAlive() then
		local caster = self:GetCaster()
		target:AddNewModifier(caster, self, "modifier_stunned", { duration = 1 * (1 - target:GetStatusResistance()) })
		caster:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Splinter")
		AddFOWViewer(DOTA_TEAM_GOODGUYS, target:GetOrigin(), 400, 1.5, false)
		local damage_table = {}
		damage_table.attacker = caster
		damage_table.ability = self
		damage_table.damage_type = DAMAGE_TYPE_MAGICAL
		damage_table.damage = self:GetSpecialValueFor("damage")
		damage_table.damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN
		damage_table.victim = target
		ApplyDamage(damage_table)
	end
end

function modifier_item_skadi_lua:GetModifierBonusStats_Strength()
	return self.bonus_all_stats
end

function modifier_item_skadi_lua:GetModifierBonusStats_Agility()
	return self.bonus_all_stats
end

function modifier_item_skadi_lua:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats
end

function modifier_item_skadi_lua:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_skadi_lua:GetModifierManaBonus()
	return self.bonus_mana
end

function modifier_item_skadi_lua:OnAttackLanded(params)
	local attacker = params.attacker
	if attacker ~= self:GetParent() then
		return
	end
	if attacker:IsIllusion() then
		return
	end
	if attacker:PassivesDisabled() then
		return
	end

	local target = params.target

	if target:GetTeamNumber() == attacker:GetTeamNumber() then
		return
	end

	if target:HasModifier("modifier_item_skadi_slow_lua") then
		return
	end

	target:AddNewModifier(attacker, self:GetAbility(), "modifier_item_skadi_slow_lua", { duration = 3 })
end

--------------------------------------------------------------------

function modifier_item_skadi_slow_lua:IsHidden()
	return false
end

function modifier_item_skadi_slow_lua:IsPurgable()
	return false
end

function modifier_item_skadi_slow_lua:OnCreated(kv)
	self.cold_slow_melee = self:GetAbility():GetSpecialValueFor("cold_slow_melee")
	self.cold_slow_melee = self:GetAbility():GetSpecialValueFor("cold_slow_melee")
	self.heal_reduction = self:GetAbility():GetSpecialValueFor("heal_reduction")
	self.cold_duration = self:GetAbility():GetSpecialValueFor("cold_duration")
end

function modifier_item_skadi_slow_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_skadi_slow_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_skadi_slow_lua:GetModifierAttackSpeedBonus_Constant()
	return self.cold_slow_melee
end

function modifier_item_skadi_slow_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.cold_slow_melee
end

function modifier_item_skadi_slow_lua:GetModifierHPRegenAmplify_Percentage()
	return -self.heal_reduction
end

function modifier_item_skadi_slow_lua:GetModifierLifestealAmplify()
	return -self.heal_reduction
end