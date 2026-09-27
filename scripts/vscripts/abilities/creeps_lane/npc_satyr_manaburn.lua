--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_manaburn_npc", "abilities/creeps_lane/npc_satyr_manaburn", LUA_MODIFIER_MOTION_NONE)

npc_satyr_manaburn = class({})

function npc_satyr_manaburn:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/harpy_chain_lightning.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_manaburn.vpcf", context)
end

function npc_satyr_manaburn:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.damage_illusion = self:GetLevelSpecialValueFor("damage_illusion", 1)
	self.mana = self:GetLevelSpecialValueFor("mana", 1)
	self.interval = self:GetLevelSpecialValueFor("interval", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_satyr_manaburn:GetChannelTime()
	return self.duration
end

function npc_satyr_manaburn:OnSpellStart()
	self.caster:AddNewModifier(self.caster, self, "modifier_satyr_manaburn_npc", {})
end

function npc_satyr_manaburn:OnChannelFinish(bInterrupted)
	self.caster:RemoveModifierByName("modifier_satyr_manaburn_npc")
end

modifier_satyr_manaburn_npc = class(mod_hidden)
function modifier_satyr_manaburn_npc:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self:StartIntervalThink(self.ability.interval)
	self:OnIntervalThink()
end

function modifier_satyr_manaburn_npc:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)

	for _, target in pairs(self.parent:FindTargets(self.ability.radius)) do
		local particle = ParticleManager:CreateParticle(
			"particles/neutral_fx/harpy_chain_lightning.vpcf",
			PATTACH_POINT_FOLLOW,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			0,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			1,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)

		target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")
		target:EmitSound("n_creep_SatyrSoulstealer.ManaBurn")

		DoDamage({
			victim = target,
			attacker = self.parent,
			damage = (target:IsHero() and not target:IsRealHero()) and self.ability.damage_illusion
				or self.ability.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
		target:SpendMana(self.ability.mana, self.ability)
	end
end