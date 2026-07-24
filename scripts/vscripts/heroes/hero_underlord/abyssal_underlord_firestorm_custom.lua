--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


abyssal_underlord_firestorm_custom = class({})

LinkLuaModifier( "modifier_abyssal_underlord_firestorm_custom", "heroes/hero_underlord/abyssal_underlord_firestorm_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_abyssal_underlord_firestorm_custom_thinker", "heroes/hero_underlord/abyssal_underlord_firestorm_custom", LUA_MODIFIER_MOTION_NONE )

function abyssal_underlord_firestorm_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/heroes_underlord/underlord_firestorm_pre.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf", context)
end

function abyssal_underlord_firestorm_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function abyssal_underlord_firestorm_custom:OnAbilityPhaseStart()
	local point = self:GetCursorPosition()
	self:PlayEffects( point )
	return true
end

function abyssal_underlord_firestorm_custom:OnAbilityPhaseInterrupted()
	self:StopEffects()
end

function abyssal_underlord_firestorm_custom:GetBehavior()
	if self:GetCaster():HasShard() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end


function abyssal_underlord_firestorm_custom:GetCastPoint()
	if self:GetCaster():HasShard() then
		return 0.25
	end
    return 0.5
end

function abyssal_underlord_firestorm_custom:OnSpellStart()
	if not IsServer() then return end
	self:StopEffects()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	if self:GetCursorTarget() then
		CreateModifierThinker( caster, self, "modifier_abyssal_underlord_firestorm_custom_thinker", {target = self:GetCursorTarget():entindex()}, point, caster:GetTeamNumber(), false )
		return
	end

	CreateModifierThinker( caster, self, "modifier_abyssal_underlord_firestorm_custom_thinker", {}, point, caster:GetTeamNumber(), false )
end

function abyssal_underlord_firestorm_custom:PlayEffects( point )
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_firestorm_pre.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.Firestorm.Start"
	local radius = self:GetSpecialValueFor( "radius" )
	self.effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, point )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 2, 2, 2 ) )
	self:GetCaster():EmitSound(sound_cast)
end

function abyssal_underlord_firestorm_custom:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

modifier_abyssal_underlord_firestorm_custom_thinker = class({})

function modifier_abyssal_underlord_firestorm_custom_thinker:IsHidden()
	return true
end

function modifier_abyssal_underlord_firestorm_custom_thinker:IsPurgable()
	return false
end

function modifier_abyssal_underlord_firestorm_custom_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	local damage = self.ability:GetSpecialValueFor( "wave_damage" )
	local delay = self.ability:GetSpecialValueFor( "first_wave_delay" )
	self.radius = self.ability:GetSpecialValueFor( "radius" )
	self.count = self.ability:GetSpecialValueFor( "wave_count" )
	self.interval = self.ability:GetSpecialValueFor( "wave_interval" )
	self.burn_duration = self.ability:GetSpecialValueFor( "burn_duration" )
	self.burn_interval = self.ability:GetSpecialValueFor( "burn_interval" )
	self.burn_damage = self.ability:GetSpecialValueFor( "burn_damage" )

	if kv.target then
		local target = EntIndexToHScript(kv.target)
		self:GetParent():FollowEntity(target, false)
	end

	if self:GetCaster():HasShard() then
		self.count = self.count + 3
		self.interval = 0.75
		self.burn_interval = 0.75
	end

	if not IsServer() then return end

	self.wave = 0
	self.wave_base = damage   -- [#25] флат-урон волны (усиливаем спелл-ампом вручную)
	self.damageTable = {
		attacker = self.caster,
		damage = damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}

	self:StartIntervalThink( delay )
end

function modifier_abyssal_underlord_firestorm_custom_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_abyssal_underlord_firestorm_custom_thinker:OnIntervalThink()
	if not self.delayed then
		self.delayed = true
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
		return
	end

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	-- [#25] Спелл-амп усиливает только ФЛАТ-волну. Контроллер для firestorm возвращает 0
	-- (в percentage_abilities), поэтому ApplyDamage сам не усилит — усиливаем вручную
	-- значением контроллера (включает все источники через flSP). Герои amp*0.2, прочие — полный.
	local ctrl = self.caster.FindModifierByName and self.caster:FindModifierByName("modifier_spell_amplify_controller")
	local rawAmp = (ctrl and ctrl.spell_amplify) or 0
	for _,enemy in pairs(enemies) do
		local isHero = enemy.IsRealHero and enemy:IsRealHero()
		local amp = isHero and (rawAmp * 0.2) or rawAmp
		self.damageTable.victim = enemy
		self.damageTable.damage = self.wave_base * (1 + amp / 100)
		ApplyDamage( self.damageTable )
		enemy:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_abyssal_underlord_firestorm_custom",
			{
				duration = self.burn_duration,
				interval = self.burn_interval,
				damage = self.burn_damage,
			}
		)
	end

	self:PlayEffects()
	self.wave = self.wave + 1
	if self.wave>=self.count then
		self:Destroy()
	end
end

function modifier_abyssal_underlord_firestorm_custom_thinker:PlayEffects()
	local particle_cast = "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.Firestorm"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 4, Vector( self.radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOn( sound_cast, self.parent )
end

modifier_abyssal_underlord_firestorm_custom = class({})

function modifier_abyssal_underlord_firestorm_custom:IsHidden()
	return false
end

function modifier_abyssal_underlord_firestorm_custom:IsDebuff()
	return true
end

function modifier_abyssal_underlord_firestorm_custom:IsStunDebuff()
	return false
end

function modifier_abyssal_underlord_firestorm_custom:IsPurgable()
	return true
end

function modifier_abyssal_underlord_firestorm_custom:OnCreated( kv )
	if not IsServer() then return end
	local interval = kv.interval
	self.damage_pct = kv.damage/100
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}
	self:StartIntervalThink( interval )
end

function modifier_abyssal_underlord_firestorm_custom:OnRefresh( kv )
	if not IsServer() then return end
	self.damage_pct = kv.damage/100
end

function modifier_abyssal_underlord_firestorm_custom:OnIntervalThink()
	local damage = self:GetParent():GetMaxHealth() * self.damage_pct
	self.damageTable.damage = damage
	ApplyDamage( self.damageTable )
end

function modifier_abyssal_underlord_firestorm_custom:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf"
end

function modifier_abyssal_underlord_firestorm_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end