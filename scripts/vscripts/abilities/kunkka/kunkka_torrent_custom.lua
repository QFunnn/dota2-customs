--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_kunkka_torrent_custom_tracker",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_delay",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_aoe",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_slow",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_kunkka_torrent_custom_stun",
	"abilities/kunkka/kunkka_torrent_custom",
	LUA_MODIFIER_MOTION_NONE
)

kunkka_torrent_custom = class({})
kunkka_torrent_custom.talents = {}

function kunkka_torrent_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf", context)
end

function kunkka_torrent_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {}
	end
end

function kunkka_torrent_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_kunkka_torrent_custom_tracker"
end

function kunkka_torrent_custom:GetAOERadius()
	return self.radius or 0
end

function kunkka_torrent_custom:OnSpellStart()
	local point = self:GetCursorPosition()

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_kunkka_torrent_custom_delay",
		{ duration = self.delay },
		point,
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_kunkka_torrent_custom_delay = class(mod_hidden)
function modifier_kunkka_torrent_custom_delay:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.radius = self.ability.radius
	self.center = self.parent:GetAbsOrigin()

	self.particle = ParticleManager:CreateParticleForTeam(
		"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf",
		PATTACH_WORLDORIGIN,
		nil,
		self.caster:GetTeamNumber()
	)
	ParticleManager:SetParticleControl(self.particle, 0, self.center)
	self:AddParticle(self.particle, false, false, -1, false, false)

	AddFOWViewer(self.caster:GetTeamNumber(), self.center, self.radius, 3, false)

	EmitSoundOnLocationForAllies(self.center, "Ability.pre.Torrent", self.caster)
end

function modifier_kunkka_torrent_custom_delay:OnDestroy()
	if not IsServer() then
		return
	end

	CreateModifierThinker(
		self.caster,
		self.ability,
		"modifier_kunkka_torrent_custom_aoe",
		{},
		self.center,
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_kunkka_torrent_custom_aoe = class(mod_hidden)
function modifier_kunkka_torrent_custom_aoe:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.center = self.parent:GetAbsOrigin()
	EmitSoundOnLocationWithCaster(self.center, "Ability.Torrent", self.caster)

	self.particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.particle, 0, self.center)
	ParticleManager:ReleaseParticleIndex(self.particle)

	self.count = 0
	self.max = self.ability.damage_ticks
	self.stun = self.ability.stun_duration
	self.radius = self.ability.radius
	self.slow_duration = self.ability.slow_duration

	self.damage = self.ability.torrent_damage / self.max
	self.interval = self.stun / self.max

	self.damageTable = { attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL }

	self:OnIntervalThink(true)
	self:StartIntervalThink(self.interval)
end

function modifier_kunkka_torrent_custom_aoe:OnIntervalThink(first)
	if not IsServer() then
		return
	end

	for _, target in pairs(self.caster:FindTargets(self.radius, self.center)) do
		self.damageTable.damage = self.damage
		self.damageTable.victim = target
		DoDamage(self.damageTable)

		if first then
			target:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_kunkka_torrent_custom_stun",
				{ duration = self.stun }
			)
		end

		target:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_kunkka_torrent_custom_slow",
			{ duration = self.slow_duration }
		)
	end

	self.count = self.count + 1
	if self.count >= self.max then
		self:Destroy()
		return
	end
end

modifier_kunkka_torrent_custom_slow = class(mod_visible)
function modifier_kunkka_torrent_custom_slow:IsPurgable()
	return true
end
function modifier_kunkka_torrent_custom_slow:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.slow = self.ability.movespeed_bonus
	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf", self)
end

function modifier_kunkka_torrent_custom_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_kunkka_torrent_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_kunkka_torrent_custom_tracker = class(mod_hidden)
function modifier_kunkka_torrent_custom_tracker:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.torrent_ability = self.ability

	self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.ability.torrent_damage = self.ability:GetSpecialValueFor("torrent_damage")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.movespeed_bonus = self.ability:GetSpecialValueFor("movespeed_bonus")
	self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
	self.ability.delay = self.ability:GetSpecialValueFor("delay")
	self.ability.damage_ticks = self.ability:GetSpecialValueFor("damage_ticks")

	self.ignore_angle = false
	self.parent:AddOrderEvent(self)
end

function modifier_kunkka_torrent_custom_tracker:OnRefresh(table)
	self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.ability.torrent_damage = self.ability:GetSpecialValueFor("torrent_damage")
end

function modifier_kunkka_torrent_custom_tracker:OrderEvent(params)
	if not IsServer() then
		return
	end
	if self.parent:GetCurrentActiveAbility() == self.ability then
		return
	end

	self.ignore_angle = false

	if params.order_type ~= DOTA_UNIT_ORDER_CAST_POSITION then
		return
	end
	if not params.ability or params.ability ~= self.ability then
		return
	end

	self.ignore_angle = true
end

function modifier_kunkka_torrent_custom_tracker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
end

function modifier_kunkka_torrent_custom_tracker:GetModifierDisableTurning()
	if not self.ignore_angle then
		return
	end
	return 1
end

function modifier_kunkka_torrent_custom_tracker:GetModifierIgnoreCastAngle()
	if not self.ignore_angle then
		return
	end
	return 1
end

modifier_kunkka_torrent_custom_stun = class(mod_hidden)
function modifier_kunkka_torrent_custom_stun:IsPurgeException()
	return true
end
function modifier_kunkka_torrent_custom_stun:IsStunDebuff()
	return true
end
function modifier_kunkka_torrent_custom_stun:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.parent:IsDebuffImmune() then
		self.parent:InterruptMotionControllers(false)
	end

	local height = 350
	local anim_time = self:GetRemainingTime() - 0.3

	self.mod = self.parent:AddNewModifier(self.caster, self.ability, "modifier_knockback", {
		center_x = self.parent:GetAbsOrigin().x,
		center_y = self.parent:GetAbsOrigin().y,
		center_z = self.parent:GetAbsOrigin().z,
		knockback_distance = 0,
		knockback_height = height,
		duration = anim_time,
		knockback_duration = anim_time,
		should_stun = true,
	})

	self.parent:StartGesture(ACT_DOTA_FLAIL)
	self:StartIntervalThink(anim_time)
end

function modifier_kunkka_torrent_custom_stun:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:RemoveGesture(ACT_DOTA_FLAIL)
	self.parent:StartGesture(ACT_DOTA_DISABLED)
	self:StartIntervalThink(-1)
end

function modifier_kunkka_torrent_custom_stun:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_kunkka_torrent_custom_stun:OnDestroy()
	if not IsServer() then
		return
	end

	if IsValid(self.mod) then
		self.mod:Destroy()
	end

	self.parent:FadeGesture(ACT_DOTA_DISABLED)
end