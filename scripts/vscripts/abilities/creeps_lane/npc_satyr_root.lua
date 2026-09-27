--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_root_passive", "abilities/creeps_lane/npc_satyr_root", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_root_debuff", "abilities/creeps_lane/npc_satyr_root", LUA_MODIFIER_MOTION_NONE)

npc_satyr_root = class({})

function npc_satyr_root:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf", context)
end

function npc_satyr_root:GetIntrinsicModifierName()
	return "modifier_satyr_root_passive"
end

modifier_satyr_root_passive = class(mod_hidden)
function modifier_satyr_root_passive:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.chance = self.ability:GetSpecialValueFor("chance")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")

	self.parent:AddAttackEvent_out(self, true)
end

function modifier_satyr_root_passive:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not params.target:IsUnit() then
		return
	end
	if not RollPseudoRandomPercentage(self.ability.chance, 1856, self.parent) then
		return
	end

	params.target:EmitSound("n_creep_Spawnlord.Freeze")
	params.target:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_satyr_root_debuff",
		{ duration = self.ability.duration * (1 - params.target:GetStatusResistance()) }
	)
end

modifier_satyr_root_debuff = class(mod_visible)
function modifier_satyr_root_debuff:IsPurgable()
	return true
end
function modifier_satyr_root_debuff:GetEffectName()
	return "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf"
end
function modifier_satyr_root_debuff:CheckState()
	return { [MODIFIER_STATE_ROOTED] = true }
end
function modifier_satyr_root_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage * 0.5 / self.ability.duration

	self:StartIntervalThink(0.5)
end

function modifier_satyr_root_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end
	DoDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end