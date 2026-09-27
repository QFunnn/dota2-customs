--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_custom_phantom_assassin_fan_of_knives_thinker",
	"abilities/phantom_assassin/custom_phantom_assassin_fan_of_knives",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_phantom_assassin_fan_of_knives",
	"abilities/phantom_assassin/custom_phantom_assassin_fan_of_knives",
	LUA_MODIFIER_MOTION_NONE
)

custom_phantom_assassin_fan_of_knives = class({})
function custom_phantom_assassin_fan_of_knives:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin_persona/pa_persona_shard_fan_of_knives.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives_dot.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin_persona/pa_persona_shard_fan_of_knives_debuff.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_life_stealer/life_stealer_open_wounds.vpcf", context)
end

function custom_phantom_assassin_fan_of_knives:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.speed = self:GetLevelSpecialValueFor("projectile_speed", 1)
	self.stun = self:GetLevelSpecialValueFor("stun", 1)
end

function custom_phantom_assassin_fan_of_knives:GetAOERadius()
	return self.radius or 0
end

function custom_phantom_assassin_fan_of_knives:OnSpellStart()
	if IsValid(self.caster.crit_ability) then
		self.caster:AddNewModifier(
			self.caster,
			self.caster.crit_ability,
			"modifier_phantom_assassin_phantom_coup_de_grace_focus",
			{ duration = self.caster.crit_ability.focus_duration }
		)
	end

	self.caster:EmitSound("Hero_PhantomAssassin.FanOfKnives.Cast")

	CreateModifierThinker(
		self.caster,
		self,
		"modifier_custom_phantom_assassin_fan_of_knives_thinker",
		{ duration = self.radius / self.speed },
		self.caster:GetAbsOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_custom_phantom_assassin_fan_of_knives_thinker = class(mod_hidden)
function modifier_custom_phantom_assassin_fan_of_knives_thinker:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end

	self.hit = {}

	local effect = wearables_system:GetParticleReplacementAbility(
		self.caster,
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf",
		self
	)

	self.particle = ParticleManager:CreateParticle(effect, PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle, 3, self.parent:GetAbsOrigin())
	self:AddParticle(self.particle, false, false, -1, false, false)

	self:StartIntervalThink(FrameTime())
end

function modifier_custom_phantom_assassin_fan_of_knives_thinker:OnIntervalThink()
	if not IsServer() then
		return
	end

	local radius = self.ability.radius
		* math.min((self:GetDuration() - self:GetRemainingTime()) / self:GetDuration(), 1)

	for _, enemy in pairs(self.parent:FindTargets(radius, self.parent:GetAbsOrigin())) do
		if not self.hit[enemy] then
			self.hit[enemy] = true

			local status = 1 - enemy:GetStatusResistance()

			enemy:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_custom_phantom_assassin_fan_of_knives",
				{ duration = self.ability.duration * status }
			)
			enemy:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_stunned",
				{ duration = self.ability.stun * status }
			)
			enemy:EmitSound("Hero_PhantomAssassin.Attack")
			enemy:EmitSound("PA.Scepter_target")
		end
	end
end

modifier_custom_phantom_assassin_fan_of_knives = class(mod_visible)
function modifier_custom_phantom_assassin_fan_of_knives:GetEffectName()
	return "particles/items3_fx/silver_edge.vpcf"
end
function modifier_custom_phantom_assassin_fan_of_knives:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end

	self.parent:GenericParticle(
		wearables_system:GetParticleReplacementAbility(
			self.caster,
			"particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives_dot.vpcf",
			self
		),
		self
	)
	self.parent:GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)
	self.parent:GenericParticle("particles/units/heroes/hero_life_stealer/life_stealer_open_wounds.vpcf", self)
end

function modifier_custom_phantom_assassin_fan_of_knives:CheckState()
	return {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
end

function modifier_custom_phantom_assassin_fan_of_knives:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_custom_phantom_assassin_fan_of_knives:GetDisableHealing()
	return 1
end