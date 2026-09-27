--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_cone_armor_active_reduce",
	"abilities/creeps_neutral_active/neutral_cone_armor_active",
	LUA_MODIFIER_MOTION_NONE
)

neutral_cone_armor_active = class({})

function neutral_cone_armor_active:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context)
end

function neutral_cone_armor_active:OnSpellStart()
	self.caster:AddNewModifier(
		self.caster,
		self,
		"modifier_neutral_cone_armor_active_reduce",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

modifier_neutral_cone_armor_active_reduce = class(mod_visible)
function modifier_neutral_cone_armor_active_reduce:IsPurgable()
	return true
end
function modifier_neutral_cone_armor_active_reduce:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.reduce = self.ability:GetSpecialValueFor("reduce")
	self.damage = self.ability:GetSpecialValueFor("damage") / 100

	if not IsServer() then
		return
	end
	self.parent:EmitSound("UI.Generic_shield")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		Vector(0, 0, 0),
		false
	)
	ParticleManager:SetParticleControl(particle, 3, Vector(255, 255, 255))
	self:AddParticle(particle, false, false, -1, true, false)

	local egg = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(egg, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0, 0, 0), false)
	self:AddParticle(egg, false, false, -1, true, false)

	local streaks = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		streaks,
		1,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		Vector(0, 0, 0),
		false
	)
	self:AddParticle(streaks, false, false, -1, true, false)

	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_neutral_cone_armor_active_reduce:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if not params.attacker then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end

	DoDamage({
		victim = params.attacker,
		attacker = self.parent,
		ability = self.ability,
		damage = params.original_damage * self.damage,
		damage_type = params.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION,
	})
	EmitSoundOnEntityForPlayer("DOTA_Item.BladeMail.Damage", params.attacker, params.attacker:GetPlayerOwnerID())
end

function modifier_neutral_cone_armor_active_reduce:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_neutral_cone_armor_active_reduce:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_neutral_cone_armor_active_reduce:GetModifierIncomingDamage_Percentage()
	return self.reduce
end