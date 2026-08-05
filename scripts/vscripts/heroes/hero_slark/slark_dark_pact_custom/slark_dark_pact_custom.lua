--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_slark_dark_pact_custom",
	"heroes/hero_slark/slark_dark_pact_custom/slark_dark_pact_custom",
	LUA_MODIFIER_MOTION_NONE
)

slark_dark_pact_custom = class({})

function slark_dark_pact_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_dark_pact_start.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_dark_pact_pulses.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_buff.vpcf", context)
end

function slark_dark_pact_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_slark_dark_pact_custom", {})
end

modifier_slark_dark_pact_custom = class({})

function modifier_slark_dark_pact_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_slark_dark_pact_custom:IsHidden()
	return true
end

function modifier_slark_dark_pact_custom:IsDebuff()
	return false
end

function modifier_slark_dark_pact_custom:IsPurgable()
	return false
end

function modifier_slark_dark_pact_custom:DestroyOnExpire()
	return false
end

function modifier_slark_dark_pact_custom:OnCreated(kv)
	self.delay_time = self:GetAbility():GetSpecialValueFor("delay")
	self.pulse_duration = self:GetAbility():GetSpecialValueFor("pulse_duration")
	self.total_pulses = self:GetAbility():GetSpecialValueFor("total_pulses")
	self.total_damage = self:GetAbility():GetSpecialValueFor("total_damage")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.pulse_interval = self:GetAbility():GetSpecialValueFor("pulse_interval")
	self.self_damage_pct = self:GetAbility():GetSpecialValueFor("self_damage_pct")
	self.delay = true
	self.count = 0
	self.damage = self.total_damage / self.total_pulses
	if not IsServer() then
		return
	end
	self.attack_target = {}
	self.damageTable = {
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}
	self:StartIntervalThink(self.delay_time)
	self:PlayEffects1()
end

function modifier_slark_dark_pact_custom:OnRefresh(kv)
	self.delay_time = self:GetAbility():GetSpecialValueFor("delay")
	self.pulse_duration = self:GetAbility():GetSpecialValueFor("pulse_duration")
	self.total_pulses = self:GetAbility():GetSpecialValueFor("total_pulses")
	self.total_damage = self:GetAbility():GetSpecialValueFor("total_damage")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.delay = true
	self.count = 0
	self.damage = self.total_damage / self.total_pulses
	if not IsServer() then
		return
	end
	self.attack_target = {}
	self.damageTable = {
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}
	self:StartIntervalThink(self.delay_time)
	self:PlayEffects1()
end

function modifier_slark_dark_pact_custom:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.delay then
		if self:GetParent() == self:GetCaster() then
			self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		end
		self.delay = false
		self:StartIntervalThink(self.pulse_interval)
		self:PlayEffects2()
	else
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetOrigin(),
			nil,
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		self.damageTable.damage = self.damage
		self.damageTable.damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN
		for _, enemy in pairs(enemies) do
			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)
		end
		if self:GetParent() == self:GetCaster() then
			self:GetParent():Purge(false, true, false, true, true)
		end
		self.damageTable.damage = self.damage / 100 * self.self_damage_pct
		self.damageTable.damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL
			+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN
		self.damageTable.victim = self:GetParent()
		ApplyDamage(self.damageTable)
		self.count = self.count + 1
		if self.count >= self.total_pulses then
			self:StartIntervalThink(-1)
			self:Destroy()
		end
	end
end

function modifier_slark_dark_pact_custom:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticleForTeam(
		"particles/units/heroes/hero_slark/slark_dark_pact_start.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent(),
		self:GetParent():GetTeamNumber()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitoc",
		self:GetParent():GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Slark.DarkPact.PreCast"
	-- EmitSoundOnLocationForAllies( self:GetParent():GetOrigin(), sound_cast, self:GetParent() )
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_slark_dark_pact_custom:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slark/slark_dark_pact_pulses.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(),
		true
	)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	self:GetParent():EmitSound("Hero_Slark.DarkPact.Cast")
end