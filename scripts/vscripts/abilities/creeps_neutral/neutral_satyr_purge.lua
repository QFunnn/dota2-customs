--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_purge", "abilities/creeps_neutral/neutral_satyr_purge", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_purge_slow", "abilities/creeps_neutral/neutral_satyr_purge", LUA_MODIFIER_MOTION_NONE)

neutral_satyr_purge = class({})

function neutral_satyr_purge:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_purge.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/diffusal_slow.vpcf", context)
end

function neutral_satyr_purge:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_satyr_purge"
end

modifier_satyr_purge = class(mod_hidden)
function modifier_satyr_purge:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.illusion = self.ability:GetSpecialValueFor("illusion")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_satyr_purge:StartCast(target)
	if not IsServer() then
		return
	end
	self.target = target

	if target and target:HasModifier("modifier_satyr_purge_slow") then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.1,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_satyr_purge:EndCast()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) or not self.target:IsAlive() then
		return
	end
	if self.target:TriggerSpellAbsorb(self.ability) then
		return
	end

	self.target:EmitSound("n_creep_SatyrTrickster.Cast")
	self.target:GenericParticle("particles/generic_gameplay/generic_purge.vpcf")

	if self.target:IsIllusion() then
		local damage = self.target:GetMaxHealth() * self.ability.illusion / 100

		self.target:SendNumber(4, damage)
		DoDamage({
			victim = self.target,
			attacker = self.parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
	end

	self.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_satyr_purge_slow",
		{ duration = self.ability.duration * (1 - self.target:GetStatusResistance()) }
	)
end

modifier_satyr_purge_slow = class(mod_visible)
function modifier_satyr_purge_slow:IsPurgable()
	return true
end
function modifier_satyr_purge_slow:GetEffectName()
	return "particles/items_fx/diffusal_slow.vpcf"
end
function modifier_satyr_purge_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
	self.damage = self.ability.damage
end

function modifier_satyr_purge_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_satyr_purge_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_satyr_purge_slow:GetModifierDamageOutgoing_Percentage()
	return self.damage
end

function modifier_satyr_purge_slow:GetModifierSpellAmplify_Percentage()
	return self.damage
end