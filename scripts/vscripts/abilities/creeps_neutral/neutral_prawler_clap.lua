--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_prawler_clap", "abilities/creeps_neutral/neutral_prawler_clap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_prawler_root_custom",
	"abilities/creeps_neutral/neutral_prawler_clap",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_prawler_armor_custom",
	"abilities/creeps_neutral/neutral_prawler_clap",
	LUA_MODIFIER_MOTION_NONE
)

neutral_prawler_clap = class({})

function neutral_prawler_clap:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf", context)
	PrecacheResource("particle", "particles/enigma/summon_spell_damage.vpcf", context)
end

function neutral_prawler_clap:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_prawler_clap"
end

modifier_prawler_clap = class(mod_hidden)
function modifier_prawler_clap:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if IsServer() then
		self.ability:SetLevel(1)
	end

	self.ability.aoe = self.ability:GetSpecialValueFor("aoe")
	self.ability.root = self.ability:GetSpecialValueFor("root")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.armor = self.ability:GetSpecialValueFor("armor")
end

function modifier_prawler_clap:StartCast(target)
	if not IsServer() then
		return
	end
	if target and target:IsStunned() then
		return
	end

	self.parent:EmitSound("n_creep_Spawnlord.Stomp")
	local mod = self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 1,
			anim_speed = 0.56,
			anim = ACT_DOTA_CAST_ABILITY_1,
			effect = 1,
			parent_mod = self:GetName(),
		}
	)
	if not mod then
		return
	end

	local time = mod:GetRemainingTime()
	local particle =
		ParticleManager:CreateParticle("particles/generic/red_zone.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.aoe, 0, -self.ability.aoe / time))
	ParticleManager:SetParticleControl(particle, 2, Vector(time, 0, 0))
	mod:AddParticle(particle, false, false, -1, false, false)
end

function modifier_prawler_clap:EndCast()
	if not IsServer() then
		return
	end

	self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)

	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.aoe, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	self.parent:EmitSound("n_creep_Spawnlord.Freeze")

	for _, target in pairs(self.parent:FindTargets(self.ability.aoe)) do
		target:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_prawler_root_custom",
			{ duration = self.ability.root * (1 - target:GetStatusResistance()) }
		)
		target:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_prawler_armor_custom",
			{ duration = self.ability.duration }
		)
	end
end

modifier_prawler_root_custom = class(mod_hidden)
function modifier_prawler_root_custom:IsPurgable()
	return true
end
function modifier_prawler_root_custom:GetEffectName()
	return "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf"
end
function modifier_prawler_root_custom:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end

modifier_prawler_armor_custom = class(mod_visible)
function modifier_prawler_armor_custom:IsPurgable()
	return true
end
function modifier_prawler_armor_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.armor = self.ability.armor * self.parent:GetPhysicalArmorValue(false) / 100

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/enigma/summon_spell_damage.vpcf", self, true)
end

function modifier_prawler_armor_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_prawler_armor_custom:GetModifierPhysicalArmorBonus()
	return self.armor
end