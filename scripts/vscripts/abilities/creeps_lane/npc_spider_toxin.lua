--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spider_toxin", "abilities/creeps_lane/npc_spider_toxin", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_toxin_aura", "abilities/creeps_lane/npc_spider_toxin", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_toxin_thinker", "abilities/creeps_lane/npc_spider_toxin", LUA_MODIFIER_MOTION_NONE)

npc_spider_toxin = class({})

function npc_spider_toxin:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_break.vpcf", context)
end

function npc_spider_toxin:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.delay = self:GetLevelSpecialValueFor("delay", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.interval = self:GetLevelSpecialValueFor("interval", 1)
	self.slow = self:GetLevelSpecialValueFor("slow", 1)
end

function npc_spider_toxin:OnSpellStart()
	CreateModifierThinker(
		self.caster,
		self,
		"modifier_spider_toxin",
		{ duration = self.delay },
		self:GetCursorTarget():GetAbsOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_spider_toxin = class(mod_hidden)
function modifier_spider_toxin:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.radius, 0, -self.ability.radius))
	ParticleManager:SetParticleControl(particle, 2, Vector(self:GetRemainingTime(), 0, 0))
	self:AddParticle(particle, true, false, -1, false, false)
end

function modifier_spider_toxin:OnDestroy()
	if not IsServer() then
		return
	end
	self.caster:EmitSound("Hero_Viper.Nethertoxin.Cast")
	CreateModifierThinker(
		self.caster,
		self.ability,
		"modifier_toxin_thinker",
		{},
		self.parent:GetAbsOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
end

modifier_toxin_thinker = class(mod_hidden)
function modifier_toxin_thinker:IsAura()
	return true
end
function modifier_toxin_thinker:GetAuraDuration()
	return 0.1
end
function modifier_toxin_thinker:GetAuraRadius()
	return self.ability.radius
end
function modifier_toxin_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_toxin_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_toxin_thinker:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_Viper.NetherToxin")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_viper/viper_nethertoxin.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.radius, 1, 1))
	self:AddParticle(particle, false, false, -1, false, false)

	self:StartIntervalThink(0.3)
end

function modifier_toxin_thinker:OnIntervalThink()
	if not IsServer() then
		return
	end
	if IsValid(self.caster) and self.caster:IsAlive() then
		return
	end

	self.parent:StopSound("Hero_Viper.NetherToxin")
	self.parent:Destroy()
	self:Destroy()
end

function modifier_toxin_thinker:GetModifierAura()
	return "modifier_toxin_aura"
end

modifier_toxin_aura = class(mod_visible)
function modifier_toxin_aura:GetEffectName()
	return "particles/generic_gameplay/generic_break.vpcf"
end
function modifier_toxin_aura:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_toxin_aura:CheckState()
	return {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_toxin_aura:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow

	if not IsServer() then
		return
	end
	self.damage = self.ability.damage * self.ability.interval

	self:StartIntervalThink(self.ability.interval)
	self:OnIntervalThink()
end

function modifier_toxin_aura:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_Viper.NetherToxin.Damage")
	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end

function modifier_toxin_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_toxin_aura:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end