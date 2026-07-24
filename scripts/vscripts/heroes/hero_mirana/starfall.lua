--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_mirana_starfall", "heroes/hero_mirana/starfall.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_mirana_starfall_delay", "heroes/hero_mirana/starfall.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_mirana_starfall_blind", "heroes/hero_mirana/starfall.lua", LUA_MODIFIER_MOTION_NONE )

if ability_mirana_starfall == nil then
	ability_mirana_starfall = class({})
end

function ability_mirana_starfall:GetIntrinsicModifierName()
	return "modifier_ability_mirana_starfall"
end

function ability_mirana_starfall:GetCastRange(vLocation, hTarget)
	return self:GetSpecialValueFor("starfall_radius")
end

function ability_mirana_starfall:OnSpellStart()
	local Waves = self:GetSpecialValueFor("cast_waves")

	for i=0, Waves-1 do
		Timers:CreateTimer(i*1.4, function()
			self:CastWave()
		end)
	end
end

function ability_mirana_starfall:CastWave()
	local caster = self:GetCaster()

	local Radius = self:GetSpecialValueFor("starfall_radius")
	local SecondaryRadius = self:GetSpecialValueFor("starfall_secondary_radius")

	local HitDelay = 0.4

	local All = FindUnitsInRadius(
		caster:GetTeamNumber(), 
		caster:GetAbsOrigin(), 
		nil, 
		Radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
		DOTA_UNIT_TARGET_FLAG_NO_INVIS, 
		FIND_ANY_ORDER, 
		false
	)

	for _, unit in ipairs(All) do
		unit:AddNewModifier(caster, self, "modifier_ability_mirana_starfall_delay", {duration=HitDelay})
	end

	Timers:CreateTimer(0.8, function()
		if not caster or caster:IsNull() or not self or self:IsNull() then return end

		local SecondaryAll = FindUnitsInRadius(
			caster:GetTeamNumber(), 
			caster:GetAbsOrigin(), 
			nil, 
			SecondaryRadius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
			DOTA_UNIT_TARGET_FLAG_NO_INVIS, 
			FIND_CLOSEST, 
			false
		)
		
		if SecondaryAll[1] then
			SecondaryAll[1]:AddNewModifier(caster, self, "modifier_ability_mirana_starfall_delay", {duration=HitDelay, secondary=1})
		end
	end)

	local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_mirana/mirana_starfall_moonray.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(fx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(fx)

	EmitSoundOn("Ability.Starfall", caster)
end

modifier_ability_mirana_starfall = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	OnCreated				= function(self, table)
		if not IsServer() then return end

		self.nextTime = 0

		self:StartIntervalThink(0.3)
	end,

	OnIntervalThink			= function(self)
		local parent = self:GetParent()
		local ability = self:GetAbility()
		if ability and not ability:IsNull() and ability.CastWave and parent and self.nextTime <= GameRules:GetGameTime() then
			self.AutocastInterval = ability:GetSpecialValueFor("auto_cast_interval")
			self.StarfallRadius = ability:GetSpecialValueFor("starfall_radius")

			if self.AutocastInterval > 0 then
				local All = FindUnitsInRadius(
					parent:GetTeamNumber(), 
					parent:GetAbsOrigin(), 
					nil, 
					self.StarfallRadius, 
					DOTA_UNIT_TARGET_TEAM_ENEMY, 
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
					DOTA_UNIT_TARGET_FLAG_NO_INVIS, 
					FIND_ANY_ORDER, 
					false
				)

				if #All > 0 then
					self.nextTime = GameRules:GetGameTime() + self.AutocastInterval

					ability:CastWave()
				end
			end
		end
	end,
})

modifier_ability_mirana_starfall_delay = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	GetAttributes			= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,

	OnCreated				= function(self, table)
		local ability = self:GetAbility()
		if ability then
			self.Damage = ability:GetSpecialValueFor("damage")
			self.SecondaryDamagePct = ability:GetSpecialValueFor("secondary_starfall_damage_percent")
			self.BlindDuration = ability:GetSpecialValueFor("starstruck_duration")
		end

		if not IsServer() then return end

		self.bIsSecondary = table.secondary == 1

		local caster = self:GetCaster()
		local parent = self:GetParent()

		if not parent or parent:IsNull() or not parent:IsAlive() or not caster or caster:IsNull() then return end

		local fxAttack = ParticleManager:CreateParticle("particles/units/heroes/hero_mirana/mirana_starfall_attack.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(fxAttack, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0,0,0), true)
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		local parent = self:GetParent()
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		if not parent or parent:IsNull() or not parent:IsAlive() or not caster or not ability or caster:IsNull() or ability:IsNull() then return end

		local Damage = self.Damage
		if self.bIsSecondary then
			Damage = Damage * 0.01 * self.SecondaryDamagePct
		end

		EmitSoundOn("Ability.StarfallImpact", parent)

		ApplyDamage({
			victim = parent, 
			attacker = caster, 
			damage = Damage, 
			damage_type = DAMAGE_TYPE_MAGICAL, 
			ability = ability
		})

		if parent:IsAlive() and self.BlindDuration > 0 and self.bIsSecondary then
			parent:AddNewModifier(caster, ability, "modifier_ability_mirana_starfall_blind", {duration=self.BlindDuration})
		end
	end,
})

modifier_ability_mirana_starfall_blind = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_MISS_PERCENTAGE
		}
	end,

	GetModifierMiss_Percentage				= function(self) return self.BlindPct or 0 end,

	OnCreated				= function(self, table)
		self:OnRefresh()
	end,

	OnRefresh				= function(self, table)
		local ability = self:GetAbility()
		if ability then
			self.BlindPct = ability:GetSpecialValueFor("starstruck_blind_pct")
		end
	end,
})