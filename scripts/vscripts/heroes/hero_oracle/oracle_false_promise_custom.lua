--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_oracle_false_promise_custom", "heroes/hero_oracle/oracle_false_promise_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_oracle_false_promise_custom_handler", "heroes/hero_oracle/oracle_false_promise_custom", LUA_MODIFIER_MOTION_NONE )

oracle_false_promise_custom = class({})

function oracle_false_promise_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:ApplyFalsePromise(target)
end

function oracle_false_promise_custom:ApplyFalsePromise(target)
	target:EmitSound("Hero_Oracle.FalsePromise.Target")
	EmitSoundOnClient("Hero_Oracle.FalsePromise.FP", target:GetPlayerOwner())

	self.false_promise_cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(self.false_promise_cast_particle, 2, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(self.false_promise_cast_particle)
	
	self.false_promise_target_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_cast_enemy.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(self.false_promise_target_particle)
	
	self:GetCaster():EmitSound("Hero_Oracle.FalsePromise.Cast")
	
	target:Purge(false, true, false, true, true)
	
	target:AddNewModifier(self:GetCaster(), self, "modifier_oracle_false_promise_custom", {duration = self:GetSpecialValueFor("duration")})
    target:AddNewModifier(self:GetCaster(), self, "modifier_oracle_false_promise_custom_handler", {duration = self:GetSpecialValueFor("duration")})
end

modifier_oracle_false_promise_custom = class({})

function modifier_oracle_false_promise_custom:DestroyOnExpire()	return not self:GetParent():IsInvulnerable() end
function modifier_oracle_false_promise_custom:GetPriority()	return MODIFIER_PRIORITY_ULTRA end
function modifier_oracle_false_promise_custom:IsPurgable()	return false end

function modifier_oracle_false_promise_custom:GetTexture()
	return "oracle_false_promise"
end

function modifier_oracle_false_promise_custom:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_false_promise.vpcf"
end

function modifier_oracle_false_promise_custom:OnCreated()

	self.amplify = self:GetAbility():GetSpecialValueFor("shard_spell_amp_bonus")
	
	if not IsServer() then return end

	local brewmaster_primal_split = self:GetParent():FindAbilityByName("brewmaster_primal_split")
    if brewmaster_primal_split then
        brewmaster_primal_split:SetActivated(false)
    end
	
	self.overhead_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_indicator.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(self.overhead_particle, false, false, -1, true, true)

	self.heal_counter		= 0
	self.damage_instances	= {}
	self.instance_counter	= 1
	self.damage_counter		= 0
	self.flBaseAttackTime = GetUnitBaseAttackTime(self:GetParent()) - self:GetAbility():GetSpecialValueFor("shard_bat_bonus")

	if self:GetCaster():HasScepter() then
		self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("shard_fade_time"))
	end
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

    if self.invis_modifier and not self.invis_modifier:IsNull() then
		self.invis_modifier:Destroy()
	end

    local brewmaster_primal_split = self:GetParent():FindAbilityByName("brewmaster_primal_split")
    if brewmaster_primal_split then
        brewmaster_primal_split:SetActivated(true)
    end

    if self:GetParent():HasModifier("modifier_hero_refreshing") then return end
    if self:GetParent():HasModifier("modifier_duel_teleporting") then return end

	if self.damage_counter < self.heal_counter then
		self:GetParent():EmitSound("Hero_Oracle.FalsePromise.Healed")
		self.end_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(self.end_particle)
		local heal = self.heal_counter - self.damage_counter
		if heal > self:GetParent():GetMaxHealth() then
			heal = self:GetParent():GetMaxHealth()
		end
		self:GetParent():Heal(heal, self:GetAbility())
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), heal, nil)
	else
		self:GetParent():EmitSound("Hero_Oracle.FalsePromise.Damaged")

		for _, instance in pairs(self.damage_instances) do
			if not instance.attacker or instance.attacker:IsNull() then
				instance.attacker = self:GetCaster() and not self:GetCaster():IsNull() and self:GetCaster() or self:GetParent()
			end
			if self.heal_counter > 0 then
				if self.heal_counter < instance.damage then
					instance.damage = instance.damage - self.heal_counter
					if instance.damage > self:GetParent():GetMaxHealth() then
						instance.damage = self:GetParent():GetMaxHealth() * 1.5
					end
					ApplyDamage(instance)
				end
				local subtraction_value = math.min(instance.damage, self.heal_counter)
				self.heal_counter = self.heal_counter - subtraction_value
				self.damage_counter = self.damage_counter - subtraction_value
			else
				if instance.damage > self:GetParent():GetMaxHealth() then
					instance.damage = self:GetParent():GetMaxHealth() * 1.5
				end
				local hp_before = self:GetParent():GetHealth()
				ApplyDamage(instance)
				local actual_dealt = hp_before - self:GetParent():GetHealth()
				-- Borrowed Time гарантированно защищает: если его баф активен, урон уже поглощён
				-- и превращён в лечение -> НЕ добиваем принудительно (иначе FORCE-ветка пробивала бы BT).
				if actual_dealt < instance.damage and self:GetParent():IsAlive()
					and not self:GetParent():HasModifier("modifier_abaddon_borrowed_time_custom_buff") then
					local missing = instance.damage - actual_dealt
					local new_hp = self:GetParent():GetHealth() - missing
					if new_hp <= 0 then
						self:GetParent():Kill(self:GetAbility(), instance.attacker)
					else
						self:GetParent():SetHealth(new_hp)
					end
				end
				if not self:GetParent():IsAlive() then
					break
				end
			end
		end

		self.end_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(self.end_particle)

		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self.damage_counter, nil)
		
	end
end

function modifier_oracle_false_promise_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_DISABLE_HEALING,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
        MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
        MODIFIER_PROPERTY_PERSISTENT_INVISIBILITY,
        MODIFIER_EVENT_ON_TAKEDAMAGE
	}
end

function modifier_oracle_false_promise_custom:OnTakeDamage(params)
    if params.unit == self:GetParent() then
        self:HealHero(params)
    end
end

function modifier_oracle_false_promise_custom:OnAbilityHealRecive(keys)
	if keys.unit == self:GetParent() and self:GetRemainingTime() >= 0 then
		self.heal_counter = self.heal_counter + (keys.gain * 2)
		ParticleManager:SetParticleControl(self.overhead_particle, 1, Vector(self.damage_counter - self.heal_counter, 0, 0))
		ParticleManager:SetParticleControl(self.overhead_particle, 2, Vector(self.heal_counter - self.damage_counter, 0, 0))
	end
end

-- function modifier_oracle_false_promise_custom:GetAbsoluteNoDamagePhysical(params)
--     self:HealHero(params)
-- 	return 1
-- end

-- function modifier_oracle_false_promise_custom:GetAbsoluteNoDamageMagical(params)
--     self:HealHero(params)
-- 	return 1
-- end

-- function modifier_oracle_false_promise_custom:GetAbsoluteNoDamagePure(params)
--     self:HealHero(params)
-- 	return 1
-- end

function modifier_oracle_false_promise_custom:HealHero(params)
    if not IsServer() then return end
    if params.attacker and self:GetRemainingTime() >= 0 then
		self:GetParent():SetHealth(self:GetParent():GetHealth() + params.damage)

        local attacked_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_attacked.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(attacked_particle)
        local damage_flags = params.damage_flags or 0
        self.damage_instances[self.instance_counter] =
		{
			victim = self:GetParent(),
			damage = params.damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = damage_flags + DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
			attacker = params.attacker,
			ability = self:GetAbility()
		}
        self.instance_counter = self.instance_counter + 1
		self.damage_counter = self.damage_counter + params.damage
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

function modifier_oracle_false_promise_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_oracle_false_promise_custom:GetModifierSpellAmplify_Percentage()
	return self.amplify
end

function modifier_oracle_false_promise_custom:AttackModifier(keys)
	if self:GetCaster():HasScepter() and keys.attacker == self:GetParent() and not keys.no_attack_cooldown and self.invis_modifier and not self.invis_modifier:IsNull() then
		self.invis_modifier:Destroy()
		self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("shard_fade_time"))
	end
end

function modifier_oracle_false_promise_custom:OnAbilityfullCastCustom(keys)
	if self:GetCaster():HasScepter() and keys.unit == self:GetParent() and self.invis_modifier and not self.invis_modifier:IsNull() then
		self.invis_modifier:Destroy()
		self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("shard_fade_time"))
	end
end

function modifier_oracle_false_promise_custom:GetModifierInvisibilityAttackBehaviorException()
    return 1
end

function modifier_oracle_false_promise_custom:GetModifierPersistentInvisibility()
    return 1
end
function modifier_oracle_false_promise_custom:GetAlwaysAutoAttackWhileHoldPosition()
    return 1
end

modifier_oracle_false_promise_custom_handler = class({})
function modifier_oracle_false_promise_custom_handler:IsHidden() return true end
function modifier_oracle_false_promise_custom_handler:IsPurgable() return false end
function modifier_oracle_false_promise_custom_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_oracle_false_promise_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_phoenix_sun") or self:GetParent():HasModifier("modifier_ability_phoenix_supernova_hiding") then
        self:GetParent():RemoveModifierByName("modifier_oracle_false_promise_custom")
        self:Destroy()
    end
end