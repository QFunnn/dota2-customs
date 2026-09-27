--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_satyr_purge_active_slow",
	"abilities/creeps_neutral_active/neutral_satyr_purge_active",
	LUA_MODIFIER_MOTION_NONE
)

neutral_satyr_purge_active = class({})

function neutral_satyr_purge_active:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_purge.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/diffusal_slow.vpcf", context)
end

function neutral_satyr_purge_active:OnSpellStart()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then
		return
	end

	target:EmitSound("n_creep_SatyrTrickster.Cast")
	target:GenericParticle("particles/generic_gameplay/generic_purge.vpcf")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_satyr_purge_active_slow",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

modifier_satyr_purge_active_slow = class(mod_visible)
function modifier_satyr_purge_active_slow:IsPurgable()
	return true
end
function modifier_satyr_purge_active_slow:GetEffectName()
	return "particles/items_fx/diffusal_slow.vpcf"
end
function modifier_satyr_purge_active_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability:GetSpecialValueFor("slow")
	self.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_satyr_purge_active_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_satyr_purge_active_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_satyr_purge_active_slow:GetModifierDamageOutgoing_Percentage()
	return self.damage
end

function modifier_satyr_purge_active_slow:GetModifierSpellAmplify_Percentage()
	return self.damage
end