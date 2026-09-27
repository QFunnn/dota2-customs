--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cone_buff", "abilities/creeps_neutral/neutral_cone_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cone_armor", "abilities/creeps_neutral/neutral_cone_armor", LUA_MODIFIER_MOTION_NONE)

neutral_cone_armor = class({})

function neutral_cone_armor:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context)
end

function neutral_cone_armor:GetIntrinsicModifierName()
	return "modifier_neutral_cone_armor"
end

modifier_neutral_cone_armor = class(mod_hidden)
function modifier_neutral_cone_armor:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.damage = self.ability:GetSpecialValueFor("damage") / 100
	self.ability.cd = self.ability:GetSpecialValueFor("AbilityCooldown")
	self.ability.reduce = self.ability:GetSpecialValueFor("reduce")

	if not IsServer() then
		return
	end
	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_neutral_cone_armor:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if not params.attacker then
		return
	end
	if self.parent ~= params.unit then
		return
	end

	if
		self.parent:HasModifier("modifier_neutral_cone_buff")
		and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION
	then
		DoDamage({
			victim = params.attacker,
			attacker = self.parent,
			ability = self.ability,
			damage = params.original_damage * self.ability.damage,
			damage_type = params.damage_type,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION,
		})
		EmitSoundOnEntityForPlayer("DOTA_Item.BladeMail.Damage", params.attacker, params.attacker:GetPlayerOwnerID())
	end

	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end
	if self.parent:HasModifier("modifier_neutral_cast_cd") then
		return
	end

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_neutral_cast_cd", { duration = self.ability.cd })
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cone_buff",
		{ duration = self.ability.duration }
	)
end

modifier_neutral_cone_buff = class(mod_visible)
function modifier_neutral_cone_buff:IsPurgable()
	return true
end
function modifier_neutral_cone_buff:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.reduce = self.ability.reduce

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
end

function modifier_neutral_cone_buff:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_neutral_cone_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_neutral_cone_buff:GetModifierIncomingDamage_Percentage()
	return self.reduce
end