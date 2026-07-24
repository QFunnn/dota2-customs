--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_cold_snap_lua = class({})

function modifier_invoker_cold_snap_lua:IsHidden()
	return false
end

function modifier_invoker_cold_snap_lua:IsDebuff()
	return true
end

function modifier_invoker_cold_snap_lua:IsStunDebuff()
	return false
end

function modifier_invoker_cold_snap_lua:IsPurgable()
	return true
end

function modifier_invoker_cold_snap_lua:OnCreated( kv )
	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor( "freeze_damage" )
		self.duration = self:GetAbility():GetSpecialValueFor( "freeze_duration")
		self.cooldown = self:GetAbility():GetSpecialValueFor( "freeze_cooldown")
		self.threshold = self:GetAbility():GetSpecialValueFor( "damage_trigger")
        self.heal = self:GetAbility():GetSpecialValueFor("freeze_heal")
		self.onCooldown = false
		self:Freeze()
	end
end

function modifier_invoker_cold_snap_lua:OnRefresh( kv )
	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor( "freeze_damage")
		self.duration = self:GetAbility():GetSpecialValueFor( "freeze_duration")
		self.cooldown = self:GetAbility():GetSpecialValueFor( "freeze_cooldown")
		self.threshold = self:GetAbility():GetSpecialValueFor( "damage_trigger")
        self.heal = self:GetAbility():GetSpecialValueFor("freeze_heal")
	end
end

function modifier_invoker_cold_snap_lua:TakeDamageScriptModifier( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		if params.damage<self.threshold then return end
		if self.onCooldown then return end
		self:Freeze()
		self:PlayEffects( params.attacker )
	end
end

function modifier_invoker_cold_snap_lua:OnIntervalThink()
	self.onCooldown = false
	self:StartIntervalThink(-1)
end

function modifier_invoker_cold_snap_lua:Freeze()
	self.onCooldown = true
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_stunned", -- modifier name
		{ duration = self.duration } -- kv
	)
    self:GetCaster():Heal(self.heal, self:GetAbility())
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
	self:StartIntervalThink( self.cooldown )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_cold_snap_lua:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_cold_snap_status.vpcf"
end

function modifier_invoker_cold_snap_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_invoker_cold_snap_lua:PlayEffects( attacker )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf"
	local sound_cast = "Hero_Invoker.ColdSnap.Freeze"

	-- Get Data
	local direction = self:GetParent():GetOrigin()-attacker:GetOrigin()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1,  self:GetParent():GetOrigin()+direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end