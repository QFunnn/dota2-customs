--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_npc_necro_melle_passive",
	"abilities/creeps_lane/npc_necro_melle_passive",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_npc_necro_melle_passive_heal",
	"abilities/creeps_lane/npc_necro_melle_passive",
	LUA_MODIFIER_MOTION_NONE
)

npc_necro_melle_passive = class({})

function npc_necro_melle_passive:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf", context)
	PrecacheResource("particle", "particles/items4_fx/spirit_vessel_damage.vpcf", context)
end

function npc_necro_melle_passive:GetIntrinsicModifierName()
	return "modifier_npc_necro_melle_passive"
end

modifier_npc_necro_melle_passive = class(mod_hidden)
function modifier_npc_necro_melle_passive:RemoveOnDeath()
	return false
end
function modifier_npc_necro_melle_passive:CheckState()
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
function modifier_npc_necro_melle_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage") / 100
	self.ability.stun = self.ability:GetSpecialValueFor("stun")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.reduce = self.ability:GetSpecialValueFor("reduce")

	if not IsServer() then
		return
	end
	self.parent:AddDeathEvent(self, true)
end

function modifier_npc_necro_melle_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_npc_necro_melle_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_npc_necro_melle_passive_heal",
		{ duration = self.ability.duration }
	)
end

function modifier_npc_necro_melle_passive:DeathEvent(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if params.attacker:IsBuilding() then
		return
	end
	if not params.attacker:IsAlive() then
		return
	end

	params.attacker:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_stunned",
		{ duration = self.ability.stun * (1 - params.attacker:GetStatusResistance()) }
	)
	DoDamage({
		victim = params.attacker,
		attacker = self.parent,
		damage = params.attacker:GetMaxHealth() * self.ability.damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self.ability,
	})

	params.attacker:GenericParticle("particles/units/heroes/hero_doom_bringer/doom_infernal_blade_impact.vpcf")
	params.attacker:EmitSound("Hero_DoomBringer.InfernalBlade.PreAttack")
end

modifier_npc_necro_melle_passive_heal = class(mod_visible)
function modifier_npc_necro_melle_passive_heal:IsPurgable()
	return true
end
function modifier_npc_necro_melle_passive_heal:GetTexture()
	return "centaur_double_edge"
end
function modifier_npc_necro_melle_passive_heal:GetEffectName()
	return "particles/items4_fx/spirit_vessel_damage.vpcf"
end
function modifier_npc_necro_melle_passive_heal:OnCreated()
	self.ability = self:GetAbility()

	self.reduce = -self.ability.reduce
end

function modifier_npc_necro_melle_passive_heal:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_npc_necro_melle_passive_heal:GetModifierHPRegenAmplify_Percentage()
	return self.reduce
end

function modifier_npc_necro_melle_passive_heal:GetModifierHealChange()
	return self.reduce
end