--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_legion_commander_overwhelming_odds", "heroes/hero_legion_commander/overwhelming_odds.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_legion_commander_overwhelming_odds_lifesteal", "heroes/hero_legion_commander/overwhelming_odds.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_legion_commander_overwhelming_odds_buff", "heroes/hero_legion_commander/overwhelming_odds.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_legion_commander_overwhelming_odds_shield", "heroes/hero_legion_commander/overwhelming_odds.lua", LUA_MODIFIER_MOTION_NONE )

if ability_legion_commander_overwhelming_odds == nil then
	ability_legion_commander_overwhelming_odds = class({})
end

function ability_legion_commander_overwhelming_odds:GetIntrinsicModifierName()
	return "modifier_ability_legion_commander_overwhelming_odds"
end

function ability_legion_commander_overwhelming_odds:OnAbilityPhaseStart()
	EmitSoundOn("Hero_LegionCommander.Overwhelming.Cast", self:GetCaster())
	return true
end

function ability_legion_commander_overwhelming_odds:OnAbilityPhaseInterrupted()
	StopSoundOn("Hero_LegionCommander.Overwhelming.Cast", self:GetCaster())
end

function ability_legion_commander_overwhelming_odds:GetCastRange(location, target)
	if self:GetCaster() and self:GetCaster():HasShard() and self:GetCaster():HasModifier("modifier_duel_buff") then
		return self:GetSpecialValueFor("radius") + self:GetSpecialValueFor("duel_radius_bonus")
	end
	return self:GetSpecialValueFor("radius")
end

function ability_legion_commander_overwhelming_odds:GetBehavior()
	if self:GetCaster():HasModifier("modifier_duel_buff") then
		return self.BaseClass.GetBehavior(self)
	end
	return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function ability_legion_commander_overwhelming_odds:GetCastPoint()
	if self:GetCaster():HasModifier("modifier_duel_buff") then
		return 0
	end
	return self.BaseClass.GetCastPoint(self)
end

function ability_legion_commander_overwhelming_odds:OnSpellStart()
	local caster = self:GetCaster()
	local CasterPos = caster:GetAbsOrigin()

	local Radius = self:GetEffectiveCastRange(caster:GetAbsOrigin(), caster)
	local BaseDamage = self:GetSpecialValueFor("damage")
	local DamagePerUnit = self:GetSpecialValueFor("damage_per_unit")
	local DamagePerHero = self:GetSpecialValueFor("damage_per_hero")
	
	local BuffDuration = self:GetSpecialValueFor("duration")
	local ShieldDuration = self:GetSpecialValueFor("shield_duration")

	local Damage = 0

	local All = FindUnitsInRadius(
		caster:GetTeamNumber(), 
		CasterPos, 
		nil, 
		Radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, 
		false
	)

	if #All > 0 then
		Damage = BaseDamage
	end

	for _, unit in ipairs(All) do
		if unit:IsHero() then
			Damage = Damage + DamagePerHero

			EmitSoundOn('Hero_LegionCommander.Overwhelming.Hero', unit)
		else
			Damage = Damage + DamagePerUnit

			EmitSoundOn('Hero_LegionCommander.Overwhelming.Creep', unit)
		end
	end

	for _, unit in ipairs(All) do
		ApplyDamage({
			victim = unit, 
			attacker = caster, 
			damage = Damage, 
			damage_type = DAMAGE_TYPE_MAGICAL, 
			ability = self
		})
	end

	caster:AddNewModifier(caster, self, "modifier_ability_legion_commander_overwhelming_odds_buff", {duration=BuffDuration})

	if ShieldDuration > 0 and Damage > 0 then
		caster:AddNewModifier(caster, self, "modifier_ability_legion_commander_overwhelming_odds_shield", {duration=ShieldDuration, damage=Damage})
	end

	local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_odds.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(fx, 0, CasterPos)
	ParticleManager:SetParticleControl(fx, 1, CasterPos)
	ParticleManager:SetParticleControl(fx, 4, Vector(self:GetEffectiveCastRange(CasterPos, caster)+150, 0, 0))
	ParticleManager:ReleaseParticleIndex(fx)

	EmitSoundOn("Hero_LegionCommander.Overwhelming.Location", caster)

	if caster:HasModifier("modifier_duel_buff") then
		caster:StartGestureFadeWithSequenceSettings(ACT_DOTA_CAST_ABILITY_1)
	end
end

modifier_ability_legion_commander_overwhelming_odds = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	OnCreated				= function(self)
		self:OnRefresh()

		self.nextCooldown = 0
	end,

	OnRefresh 				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.Cooldown = ability:GetSpecialValueFor("moment_of_courage_cooldown")
			self.Chance = ability:GetSpecialValueFor("trigger_chance")
			self.Duration = ability:GetSpecialValueFor("buff_duration")
		end
	end,

	AttackStartModifier		= function(self, event)
		local target = event.target
		local parent = self:GetParent()
		local ability = self:GetAbility()

		if parent and target == parent and self.nextCooldown <= GameRules:GetGameTime() and ability and not parent:PassivesDisabled() then
			if RollPseudoRandomPercentage(self.Chance, DOTA_PSEUDO_RANDOM_LEGION_MOMENT, parent) then
				self.nextCooldown = GameRules:GetGameTime() + self.Cooldown

				parent:AttackNoEarlierThan(0, 0)
				parent:AddNewModifier(parent, ability, "modifier_ability_legion_commander_overwhelming_odds_lifesteal", {duration=self.Duration})
				if parent:GetAttackTarget() ~= nil and parent:IsAttackingEntity(parent:GetAttackTarget()) then
					parent:PerformAttack(parent:GetAttackTarget(), true, true, true, false, true, false, false)
					parent:FadeGesture(ACT_DOTA_ATTACK)
					parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 4)
				end
			end
		end
	end,
})

modifier_ability_legion_commander_overwhelming_odds_lifesteal = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT
		}
	end,

	GetModifierAttackSpeedBonus_Constant		= function(self) return 2000 end,
	GetModifierBaseAttackTimeConstant		= function(self) return 0.01 end,

	OnCreated				= function(self)
		self:OnRefresh()
	end,

	OnRefresh 				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.LifestealPct = ability:GetSpecialValueFor("hp_leech_percent")
		end
	end,

	TakeDamageScriptModifier		= function(self, event)
		local attacker = event.attacker
		local parent = self:GetParent()
		local ability = self:GetAbility()

		if parent and attacker == parent and event.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and event.inflictor == nil then
			local Lifesteal = event.damage * 0.01 * self.LifestealPct
			parent:HealWithParams(Lifesteal, ability, true, true, parent, false)

			EmitSoundOn("Hero_LegionCommander.Courage", parent)

			local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
			ParticleManager:SetParticleControlTransformForward(fx, 0, parent:GetAbsOrigin(), parent:GetForwardVector())

			if parent.GetPlayerOwner then
				local player = parent:GetPlayerOwner()
				if player then
					SendOverheadEventMessage(player, OVERHEAD_ALERT_HEAL, parent, Lifesteal, player)
				end
			end

			self:Destroy()
		end
	end,
})

modifier_ability_legion_commander_overwhelming_odds_buff = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		}
	end,

	GetModifierAttackSpeedBonus_Constant		= function(self) return self.AttackSpeed or 0 end,

	OnCreated				= function(self)
		self:OnRefresh()
	end,

	OnRefresh 				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.AttackSpeed = ability:GetSpecialValueFor("bonus_attack_speed")
		end
	end,
})

modifier_ability_legion_commander_overwhelming_odds_shield = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
		}
	end,

	OnCreated				= function(self, table)
		self:OnRefresh(table)

		if not IsServer() then return end

		self:SetHasCustomTransmitterData(true)
	end,

	OnRefresh 				= function(self, table)
		local ability = self:GetAbility()
		if ability then
			self.ShieldPct = ability:GetSpecialValueFor("shield_per_damage_pct")
		end

		if not IsServer() then return end

		local Damage = table.damage
		
		self.BarrierMaxHealth = math.floor(Damage * 0.01 * self.ShieldPct)
		self.BarrierCurrentHealth = self.BarrierMaxHealth

		self:SendBuffRefreshToClients()
	end,

	AddCustomTransmitterData		= function(self)
		self.TransmitterTable = self.TransmitterTable or {}

		self.TransmitterTable.BarrierMaxHealth = self.BarrierMaxHealth
		self.TransmitterTable.BarrierCurrentHealth = self.BarrierCurrentHealth

		return self.TransmitterTable
	end,

	HandleCustomTransmitterData		= function(self, data)
		self.BarrierMaxHealth = data.BarrierMaxHealth
		self.BarrierCurrentHealth = data.BarrierCurrentHealth
	end,

	GetModifierIncomingDamageConstant			= function(self, event)
		if IsClient() then
			if event.report_max then
				return self.BarrierMaxHealth
			else
				return self.BarrierCurrentHealth
			end
		end

		if event.original_damage >= self.BarrierCurrentHealth then
			self:Destroy()
			return self.BarrierCurrentHealth * (-1)
		else
			self.BarrierCurrentHealth = self.BarrierCurrentHealth - event.original_damage
			self:SendBuffRefreshToClients()
			return event.original_damage * (-1)
		end
	end,
})