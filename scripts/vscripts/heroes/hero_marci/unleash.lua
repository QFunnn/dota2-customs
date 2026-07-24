--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_marci_unleash", "heroes/hero_marci/unleash.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_marci_unleash_animation", "heroes/hero_marci/unleash.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_marci_unleash_fury", "heroes/hero_marci/unleash.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_marci_unleash_debuff", "heroes/hero_marci/unleash.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_marci_unleash_recovery", "heroes/hero_marci/unleash.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_marci_unleash_debuff_silence", "heroes/hero_marci/unleash.lua", LUA_MODIFIER_MOTION_NONE )

if ability_marci_unleash == nil then
	ability_marci_unleash = class({})
end

function ability_marci_unleash:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_cast.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_stack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_pulse_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context )
end

function ability_marci_unleash:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor( "duration" )

	caster:AddNewModifier(caster, self, "modifier_ability_marci_unleash",{duration = duration})
end

function ability_marci_unleash:Pulse(center)
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "pulse_radius" )
	local damage = self:GetSpecialValueFor( "pulse_damage" )
	local duration = self:GetSpecialValueFor( "pulse_debuff_duration" )

	local silence = self:GetSpecialValueFor("pulse_silence_duration")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_ability_marci_unleash_debuff", {duration = duration})

		if silence > 0 then
			enemy:AddNewModifier(caster, self, "modifier_ability_marci_unleash_debuff_silence", {duration = silence})
		end

		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(fx, 0, center)
	ParticleManager:SetParticleControl(fx, 1, Vector(radius,radius,radius))
	ParticleManager:ReleaseParticleIndex(fx)

	caster:EmitSound("Hero_Marci.Unleash.Pulse")
end

modifier_ability_marci_unleash = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	GetModifierMoveSpeedBonus_Percentage		= function(self) return self.bonus_ms or 0 end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		}
	end,

	OnCreated				= function(self)
		self.parent = self:GetParent()

		self:OnRefresh()

		if not IsServer() then return end

		self.parent:AddNewModifier(self.parent, self.ability, "modifier_ability_marci_unleash_fury", {})
	end,

	OnRefresh				= function(self)
		self.ability = self:GetAbility()
		if self.ability then
			self.bonus_ms = self.ability:GetSpecialValueFor( "bonus_movespeed" )
			self.dispel = self.ability:GetSpecialValueFor("dispel")
			self.extend_duration = self.ability:GetSpecialValueFor("extend_duration")
		end

		if not IsServer() then return end

		if self.dispel > 0 then
			self.parent:Purge( false, true, false, false, false )
		end

		self:PlayEffects()
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		local fury = self.parent:FindModifierByNameAndCaster( "modifier_ability_marci_unleash_fury", self.parent )
		if fury then
			fury:ForceDestroy()
		end

		local recovery = self.parent:FindModifierByNameAndCaster( "modifier_ability_marci_unleash_recovery", self.parent )
		if recovery then
			recovery:ForceDestroy()
		end
	end,

	OnAbilityfullCastCustom		= function(self, event)
		if event.unit ~= self.parent or self.dispel == 0 then return end

		if self.ability and event.ability ~= self.ability then
			local pos = event.target ~= nil and event.target:GetAbsOrigin() or self.parent:GetAbsOrigin()
			self.ability:Pulse(pos)
		end
	end,

	OnDeathEvent				= function(self, event)
		if event.attacker ~= self.parent or self.extend_duration == 0 then return end

		if event.unit and not event.unit:IsRealHero() and not event.unit:IsIllusion() then
			self:SetDuration(self:GetRemainingTime()+self.extend_duration, true)
		end
	end,

	PlayEffects				= function(self)
		local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:ReleaseParticleIndex( fx )

		EmitSoundOn( "Hero_Marci.Unleash.Cast", self:GetParent() )
	end,
})

modifier_ability_marci_unleash_animation = class({
	IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	GetActivityTranslationModifiers		= function(self) return "unleash" end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		}
	end,
})

modifier_ability_marci_unleash_debuff = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	GetEffectName			= function(self) return "particles/units/heroes/hero_marci/marci_unleash_pulse_debuff.vpcf" end,
	GetEffectAttachType			= function(self) return PATTACH_ABSORIGIN_FOLLOW end,
	GetStatusEffectName			= function(self) return "particles/status_fx/status_effect_snapfire_slow.vpcf" end,
	StatusEffectPriority			= function(self) return MODIFIER_PRIORITY_NORMAL end,

	GetModifierAttackSpeedBonus_Constant		= function(self) return self.as_slow or 0 end,
	GetModifierMoveSpeedBonus_Percentage		= function(self) return self.ms_slow or 0 end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		}
	end,

	OnCreated				= function(self)
		self:OnRefresh()
	end,

	OnRefresh				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.as_slow = -ability:GetSpecialValueFor( "pulse_attack_slow_pct" )	
			self.ms_slow = -ability:GetSpecialValueFor( "pulse_move_slow_pct" )	
		end
	end,
})

modifier_ability_marci_unleash_debuff_silence = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	GetEffectName			= function(self) return "particles/generic_gameplay/generic_silence.vpcf" end,
	GetEffectAttachType			= function(self) return PATTACH_OVERHEAD_FOLLOW end,
	ShouldUseOverheadOffset				= function(self) return true end,

	CheckState				= function(self)
		return {
			[MODIFIER_STATE_SILENCED] = true
		}
	end,
})

modifier_ability_marci_unleash_fury = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,

	GetModifierAttackSpeed_Limit		= function(self) return 1 end,
	GetModifierAttackSpeedBonus_Constant		= function(self) return self.bonus_as end,
	GetActivityTranslationModifiers		= function(self)
		if self:GetStackCount()==1 then
			return "flurry_pulse_attack"
		end

		if self:GetStackCount()%2==0 then
			return "flurry_attack_b"
		end

		return "flurry_attack_a"
	end,

	ShouldUseOverheadOffset				= function(self) return true end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
			MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		}
	end,

	OnCreated				= function(self)
		self.parent = self:GetParent()
		self.ability = self:GetAbility()

		if self.ability then
			self.bonus_as = self.ability:GetSpecialValueFor( "flurry_bonus_attack_speed" )
			self.recovery = self.ability:GetSpecialValueFor( "time_between_flurries" )
			self.charges = self.ability:GetSpecialValueFor( "charges_per_flurry" )
			self.timer = self.ability:GetSpecialValueFor( "max_time_window_per_hit" )
		end

		if not IsServer() then return end

		self.counter = self.charges
		self:SetStackCount( self.counter )

		self.animation = self.parent:AddNewModifier(self.parent, self.ability, "modifier_ability_marci_unleash_animation", {})

		self:PlayEffects1()
		self:PlayEffects2( self.parent, self.counter )
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		if not self.animation:IsNull() then
			self.animation:Destroy()
		end

		local main = self.parent:FindModifierByNameAndCaster( "modifier_ability_marci_unleash", self.parent )
		if not main then return end

		if self.forced then return end

		self.parent:AddNewModifier(self.parent, self.ability, "modifier_ability_marci_unleash_recovery", {duration = self.recovery})
	end,

	GetModifierProcAttack_Feedback				= function(self, event)
		self:StartIntervalThink( self.timer )

		self.counter = self.counter - 1
		self:SetStackCount( self.counter )

		self:EditEffects2( self.counter )
		self:PlayEffects3( self.parent, event.target )

		if self.counter<=0 then
			if self.ability then
				self.ability:Pulse(event.target:GetOrigin())
			end
			self:Destroy()
		end
	end,

	OnIntervalThink								= function(self)
		self:Destroy()
	end,

	ForceDestroy			= function(self)
		self.forced = true
		self:Destroy()
	end,

	PlayEffects1				= function(self)
		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_marci/marci_unleash_buff.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_l", Vector(0,0,0), true)
		ParticleManager:SetParticleControlEnt(fx, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_r", Vector(0,0,0), true)
		ParticleManager:SetParticleControlEnt(fx, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
		ParticleManager:SetParticleControlEnt(fx, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true)
		ParticleManager:SetParticleControlEnt(fx, 5, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
		ParticleManager:SetParticleControlEnt(fx, 6, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true)

		self:AddParticle(fx, false, false, -1, false, false)

		EmitSoundOn( "Hero_Marci.Unleash.Charged", self:GetParent() )
		EmitSoundOnClient( "Hero_Marci.Unleash.Charged.2D", self:GetParent():GetPlayerOwner() )
	end,

	PlayEffects2				= function(self, caster, counter)
		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_marci/marci_unleash_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, caster)
		ParticleManager:SetParticleControl(fx, 1, Vector(0, counter, 0))

		self:AddParticle(fx, false, false, 1, false, true)
		self.fx_stack = fx
	end,

	EditEffects2				= function(self, counter)
		ParticleManager:SetParticleControl( self.fx_stack, 1, Vector( 0, counter, 0 ) )
	end,

	PlayEffects3				= function(self, caster, target)
		local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(fx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
		ParticleManager:ReleaseParticleIndex(fx)
	end,
})

modifier_ability_marci_unleash_recovery = class({
	IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	GetModifierFixedAttackRate		= function(self) return self.rate or 0 end,
	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
		}
	end,

	OnCreated				= function(self)
		self.parent = self:GetParent()
		self.rate = self:GetAbility():GetSpecialValueFor( "recovery_fixed_attack_rate" )

		if not IsServer() then return end
	end,

	OnRefresh				= function(self)
		self:OnCreated()
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		local main = self.parent:FindModifierByNameAndCaster( "modifier_ability_marci_unleash", self.parent )
		if not main then return end

		if self.forced then return end

		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_ability_marci_unleash_fury", {})
	end,

	ForceDestroy			= function(self)
		self.forced = true
		self:Destroy()
	end,
})