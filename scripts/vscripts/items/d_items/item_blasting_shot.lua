--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_blasting_shot_passive", "items/d_items/item_blasting_shot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_blasting_shot_cooldown", "items/d_items/item_blasting_shot", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_blasting_shot = item_blasting_shot or class({})
item_blasting_shot2 = item_blasting_shot or class({})
item_blasting_shot3 = item_blasting_shot or class({})
item_blasting_shot4 = item_blasting_shot or class({})
item_blasting_shot5 = item_blasting_shot or class({})

function item_blasting_shot:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_blasting_shot:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_blasting_shot:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	if not self:GetCaster():IsHero() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

function item_blasting_shot:GetIntrinsicModifierName()
	return "modifier_item_blasting_shot_passive"
end

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

modifier_item_blasting_shot_passive = modifier_item_blasting_shot_passive or class({})
function modifier_item_blasting_shot_passive:IsDebuff()
	return false
end
function modifier_item_blasting_shot_passive:IsHidden()
	return true
end
function modifier_item_blasting_shot_passive:IsPermanent()
	return true
end
function modifier_item_blasting_shot_passive:IsPurgable()
	return false
end
function modifier_item_blasting_shot_passive:IsPurgeException()
	return false
end
function modifier_item_blasting_shot_passive:IsStunDebuff()
	return false
end
function modifier_item_blasting_shot_passive:RemoveOnDeath()
	return false
end
function modifier_item_blasting_shot_passive:AllowIllusionDuplicate()
	return false
end

function modifier_item_blasting_shot_passive:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return decFuns
end

function modifier_item_blasting_shot_passive:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_blasting_shot_passive:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_blasting_shot_passive:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_blasting_shot_passive:OnAttackLanded(keys)
	if IsServer() then
		local parent = self:GetParent()
		local ability = self:GetAbility()

		if parent ~= keys.attacker then
			return
		end

		if parent:IsIllusion() then
			return
		end

		local target = keys.target
		if ((not target:IsHero()) and (not target:IsCreep())) or (target:GetTeam() == parent:GetTeam()) then
			return
		end

		if
			(not parent:HasModifier("modifier_item_blasting_shot_cooldown"))
			and parent:IsRealHero()
			and parent:IsRangedAttacker()
		then
			parent:AddNewModifier(
				parent,
				ability,
				"modifier_item_blasting_shot_cooldown",
				{ duration = ability:GetSpecialValueFor("internal_cooldown") }
			)

			local damage_table = {}
			local radius = 200
			local multiplier = ability:GetSpecialValueFor("bonus_magical_damage_multiplier")

			damage_table.attacker = parent
			damage_table.victim = target
			damage_table.damage_type = DAMAGE_TYPE_MAGICAL
			damage_table.ability = ability
			damage_table.damage = keys.damage * multiplier

			ApplyDamage(damage_table)

			if parent:IsRangedAttacker() then
				radius = ability:GetSpecialValueFor("radius_ranged")
				multiplier = ability:GetSpecialValueFor("ranged_dmg_multiplier")
			else
				radius = ability:GetSpecialValueFor("radius_melee")
				multiplier = ability:GetSpecialValueFor("melee_dmg_multiplier")
			end

			damage_table.damage = keys.damage * multiplier

			local unitsToDamage = {
				unpack(
					FindUnitsInRadius(
						parent:GetTeam(),
						target:GetAbsOrigin(),
						target,
						radius,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
						DOTA_UNIT_TARGET_FLAG_NONE,
						1,
						false
					),
					2
				),
			}

			for _, v in ipairs(unitsToDamage) do
				damage_table.victim = v
				ApplyDamage(damage_table)
			end

			local particle_name = "particles/econ/events/snowball/snowball_projectile_explosion_b.vpcf" --"particles/units/heroes/hero_brewmaster/brewmaster_storm_attack_explosion.vpcf"
			local particle_willful_fx = ParticleManager:CreateParticle(particle_name, PATTACH_POINT_FOLLOW, target)
			ParticleManager:SetParticleControl(particle_willful_fx, 0, Vector(radius, 2, radius * 2))
			ParticleManager:SetParticleControlEnt(
				particle_willful_fx,
				3,
				target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				target:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(particle_willful_fx)
		end
	end
end

modifier_item_blasting_shot_cooldown = class({})
function modifier_item_blasting_shot_cooldown:IsHidden()
	return false
end
function modifier_item_blasting_shot_cooldown:IsDebuff()
	return false
end
function modifier_item_blasting_shot_cooldown:IsPurgable()
	return false
end
function modifier_item_blasting_shot_cooldown:IsPermanent()
	return true
end

function modifier_item_blasting_shot_cooldown:GetTexture()
	return "item_blasting_shot"
end