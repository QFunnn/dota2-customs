--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_oracle_false_promise_custom", "heroes/npc_dota_hero_oracle_custom/oracle_false_promise_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_oracle_false_promise_custom_handler", "heroes/npc_dota_hero_oracle_custom/oracle_false_promise_custom", LUA_MODIFIER_MOTION_NONE )

oracle_false_promise_custom = class({})

function oracle_false_promise_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_cast_enemy.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_indicator.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_dmg.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_attacked.vpcf", context )
end

oracle_false_promise_custom.modifier_oracle_5 = {15,30}
oracle_false_promise_custom.modifier_oracle_18 = {20,30,40}
oracle_false_promise_custom.modifier_oracle_18_radius = 500
oracle_false_promise_custom.modifier_oracle_18_limit = 2000
oracle_false_promise_custom.modifier_oracle_19 = {-6,-12}
oracle_false_promise_custom.modifier_oracle_21 = 10

function oracle_false_promise_custom:GetIntrinsicModifierName()
	return "modifier_oracle_false_promise_custom_handler"
end

function oracle_false_promise_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_oracle_19") then
	    bonus = self.modifier_oracle_19[self:GetCaster():GetTalentLevel("modifier_oracle_19")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function oracle_false_promise_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
    if self:GetCaster():HasModifier("modifier_oracle_21") then
        self:ApplyFalsePromise(target, 1)
    else
        self:ApplyFalsePromise(target, 0)
    end
end

function oracle_false_promise_custom:ApplyFalsePromise(target, talent)
	target:EmitSound("Hero_Oracle.FalsePromise.Target")
	EmitSoundOnClient("Hero_Oracle.FalsePromise.FP", target:GetPlayerOwner())

	self.false_promise_cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(self.false_promise_cast_particle, 2, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(self.false_promise_cast_particle)
	
	self.false_promise_target_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_cast_enemy.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(self.false_promise_target_particle)
	
	self:GetCaster():EmitSound("Hero_Oracle.FalsePromise.Cast")
	
	target:Purge(false, true, false, true, true)
	
	target:AddNewModifier(self:GetCaster(), self, "modifier_oracle_false_promise_custom", {duration = self:GetSpecialValueFor("duration"), talent_21 = talent})
end

modifier_oracle_false_promise_custom = class({})

function modifier_oracle_false_promise_custom:DestroyOnExpire()	return not self:GetParent():IsInvulnerable() end
function modifier_oracle_false_promise_custom:GetPriority()	return MODIFIER_PRIORITY_ULTRA end
function modifier_oracle_false_promise_custom:IsPurgable()	return false end

function modifier_oracle_false_promise_custom:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_false_promise.vpcf"
end

function modifier_oracle_false_promise_custom:OnCreated(params)
	if not IsServer() then return end
	
	self.talent_21 = params.talent_21

	self.overhead_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_indicator.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(self.overhead_particle, false, false, -1, true, true)

	self.heal_counter		= 0
	self.damage_instances	= {}
	self.instance_counter	= 1
	self.damage_counter		= 0

	--if self:GetCaster():HasShard() then
	--	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("shard_fade_time"))
	--end
end

function modifier_oracle_false_promise_custom:OnIntervalThink()
	self.invis_modifier = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_invisible", {})

	if self:GetParent():GetAggroTarget() then
		self:GetParent():MoveToTargetToAttack(self:GetParent():GetAggroTarget())
	end

	self:StartIntervalThink(-1)
end

function modifier_oracle_false_promise_custom:OnDestroy()
	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_oracle_18") then
		if self.damage_counter > 0 then
            local talent_radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_oracle_18_radius)
			local particle = ParticleManager:CreateParticle("particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_aoe.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
			ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
			ParticleManager:SetParticleControl(particle, 2, Vector(talent_radius, talent_radius, talent_radius))
			ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle)
			local damage = self.damage_counter / 100 * self:GetAbility().modifier_oracle_18[self:GetCaster():GetTalentLevel("modifier_oracle_18")]
			local limit = self:GetAbility().modifier_oracle_18_limit
			damage = math.min(damage, limit)
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),self:GetParent():GetAbsOrigin(),nil,talent_radius,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,0,0,false)
			for _, enemy in pairs(enemies) do
				ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
			end
		end
	end

	if self.talent_21 == 1 then
		self:GetParent():EmitSound("Hero_Oracle.FalsePromise.Healed")
		self.end_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(self.end_particle)

		if self.damage_counter < self.heal_counter then
			local heal = self.heal_counter - self.damage_counter

			if heal > self:GetParent():GetMaxHealth() then
				heal = self:GetParent():GetMaxHealth() - self:GetParent():GetHealth()
			end

			self:GetParent():Heal(math.max(heal, self:GetParent():GetMaxHealth() / 100 * self:GetAbility().modifier_oracle_21), self:GetAbility())
		else
			self:GetParent():Heal(self:GetParent():GetMaxHealth() / 100 * self:GetAbility().modifier_oracle_21, self:GetAbility())
		end
		return
	end

	if self.damage_counter < self.heal_counter then
		self:GetParent():EmitSound("Hero_Oracle.FalsePromise.Healed")

		self.end_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(self.end_particle)

		local heal = self.heal_counter - self.damage_counter

		if heal > self:GetParent():GetMaxHealth() then
			heal = self:GetParent():GetMaxHealth() - self:GetParent():GetHealth()
		end
		
		self:GetParent():Heal(heal, self:GetAbility())
		
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), heal, nil)
	else
		self:GetParent():EmitSound("Hero_Oracle.FalsePromise.Damaged")

		for _, instance in pairs(self.damage_instances) do
			if self.heal_counter > 0 then
				if self.heal_counter < instance.damage then
					instance.damage = instance.damage - self.heal_counter
					if instance.damage > self:GetParent():GetMaxHealth() then
						instance.damage = self:GetParent():GetMaxHealth() * 1.5
					end
					if self:GetCaster():HasModifier("modifier_oracle_5") then
						if instance.damage > 0 then
							instance.damage = instance.damage * ( 1 - (self:GetAbility().modifier_oracle_5[self:GetCaster():GetTalentLevel("modifier_oracle_5")] / 100))
						end
					end
					ApplyDamage(instance)
				end
				local subtraction_value = math.min(instance.damage, self.heal_counter)
				self.heal_counter = self.heal_counter - subtraction_value
				self.damage_counter = self.damage_counter - subtraction_value
			else
				if self:GetCaster():HasModifier("modifier_oracle_5") then
					if instance.damage > 0 then
						instance.damage = instance.damage * ( 1 - (self:GetAbility().modifier_oracle_5[self:GetCaster():GetTalentLevel("modifier_oracle_5")] / 100))
					end
				end
				if instance.damage > self:GetParent():GetMaxHealth() then
					instance.damage = self:GetParent():GetMaxHealth() * 1.5
				end
				ApplyDamage(instance)
			end
		end

		self.end_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(self.end_particle)

		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self.damage_counter, nil)
	end

	if self.invis_modifier and not self.invis_modifier:IsNull() then
		self.invis_modifier:Destroy()
	end
end

function modifier_oracle_false_promise_custom:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_HEAL_RECEIVED,
		MODIFIER_PROPERTY_DISABLE_HEALING,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_oracle_false_promise_custom:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end
    self:ApplyDamageFunc(params, params.attacker)
    return params.damage
end

function modifier_oracle_false_promise_custom:ApplyDamageFunc(keys, attacker)
	if attacker and self:GetRemainingTime() >= 0 then  
		self.attacked_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_attacked.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(self.attacked_particle)
		local damage_flags = keys.damage_flags
		local end_damage = keys.damage
        local flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_HPLOSS
        if attacker == self:GetCaster() then
            flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NON_LETHAL
        end
		self.damage_instances[self.instance_counter] = 
		{
			victim			= self:GetParent(),
			damage			= end_damage,
			damage_type		= keys.damage_type,
			damage_flags	= flags,
			attacker		= attacker,
			ability			= self:GetAbility()
		}
		self.instance_counter = self.instance_counter + 1
		self.damage_counter = self.damage_counter + end_damage
		ParticleManager:SetParticleControl(self.overhead_particle, 1, Vector(self.damage_counter - self.heal_counter, 0, 0))
		ParticleManager:SetParticleControl(self.overhead_particle, 2, Vector(self.heal_counter - self.damage_counter, 0, 0))
	end
end

function modifier_oracle_false_promise_custom:OnHealReceived(keys)
	if keys.unit == self:GetParent() and self:GetRemainingTime() >= 0 then
		self.heal_counter = self.heal_counter + (keys.gain * 2)
		
		ParticleManager:SetParticleControl(self.overhead_particle, 1, Vector(self.damage_counter - self.heal_counter, 0, 0))
		ParticleManager:SetParticleControl(self.overhead_particle, 2, Vector(self.heal_counter - self.damage_counter, 0, 0))
	end
end

function modifier_oracle_false_promise_custom:GetDisableHealing(keys)
	return 1
end

function modifier_oracle_false_promise_custom:GetMinHealth()
	return 1
end

function modifier_oracle_false_promise_custom:OnAttack(keys)
	--if self:GetCaster():HasShard() and keys.attacker == self:GetParent() and not keys.no_attack_cooldown and self.invis_modifier and not self.invis_modifier:IsNull() then
	--	self.invis_modifier:Destroy()
	--	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("shard_fade_time"))
	--end
end

function modifier_oracle_false_promise_custom:OnAbilityFullyCast(keys)
	--if self:GetCaster():HasShard() and keys.unit == self:GetParent() and self.invis_modifier and not self.invis_modifier:IsNull() then
	--	self.invis_modifier:Destroy()
	--	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("shard_fade_time"))
	--end
end

modifier_oracle_false_promise_custom_handler = class({})
function modifier_oracle_false_promise_custom_handler:IsPurgeException() return false end
function modifier_oracle_false_promise_custom_handler:IsPurgable() return false end
function modifier_oracle_false_promise_custom_handler:RemoveOnDeath() return false end
function modifier_oracle_false_promise_custom_handler:IsHidden() return true end

function modifier_oracle_false_promise_custom_handler:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_oracle_false_promise_custom_handler:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if not self:GetAbility():IsCooldownReady() then return end
	if not self:GetParent():HasModifier("modifier_oracle_21") then return end
	return 1
end

function modifier_oracle_false_promise_custom_handler:OnTakeDamage(params)
	if not IsServer() then return end
	if self:GetParent():IsIllusion() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if not self:GetAbility():IsCooldownReady() then return end
	if not self:GetParent():HasModifier("modifier_oracle_21") then return end
	self:GetAbility():ApplyFalsePromise(self:GetCaster(), 1)
	self:GetAbility():UseResources(false, false, false, true)
end