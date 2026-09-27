--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tusk_ghost_passive", "abilities/creeps_lane/npc_tusk_ghost_passive", LUA_MODIFIER_MOTION_NONE)

npc_tusk_ghost_passive = class({})

function npc_tusk_ghost_passive:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		context
	)
end

function npc_tusk_ghost_passive:GetIntrinsicModifierName()
	return "modifier_tusk_ghost_passive"
end

modifier_tusk_ghost_passive = class(mod_hidden)
function modifier_tusk_ghost_passive:CheckState()
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
function modifier_tusk_ghost_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.damage = self.ability:GetSpecialValueFor("damage") / 100
	self.ability.tower_damage = self.ability:GetSpecialValueFor("tower_damage") / 100
	self.ability.live = self.ability:GetSpecialValueFor("live")

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_phased", {})
	self:StartIntervalThink(self.ability.live)
end

function modifier_tusk_ghost_passive:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:RemoveModifierByName("modifier_invulnerable")
	self.parent:Kill(nil, nil)
end

function modifier_tusk_ghost_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_tusk_ghost_passive:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	local damage = params.target:GetMaxHealth()
		* (params.target:IsBuilding() and self.ability.tower_damage or self.ability.damage)

	params.target:EmitSound("UI.Ability_frost")
	params.target:GenericParticle("particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf")
	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_stunned",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
	DoDamage({
		victim = params.target,
		attacker = self.parent,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})

	self.parent:RemoveModifierByName("modifier_invulnerable")
	self.parent:Kill(nil, nil)
end