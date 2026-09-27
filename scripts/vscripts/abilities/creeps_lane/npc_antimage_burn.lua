--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_attack", "abilities/creeps_lane/npc_antimage_burn", LUA_MODIFIER_MOTION_NONE)

npc_antimage_burn = class({})

function npc_antimage_burn:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_manaburn.vpcf", context)
end

function npc_antimage_burn:GetIntrinsicModifierName()
	return "modifier_antimage_attack"
end

modifier_antimage_attack = class(mod_hidden)
function modifier_antimage_attack:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.mana = self.ability:GetSpecialValueFor("mana") / 100
end

function modifier_antimage_attack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_antimage_attack:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end
	if params.target:GetMaxMana() == 0 then
		return
	end

	local mana = math.min(params.target:GetMaxMana() * self.ability.mana, params.target:GetMana())

	DoDamage({
		victim = params.target,
		attacker = self.parent,
		damage = mana,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self.ability,
	})

	params.target:EmitSound("Hero_Antimage.ManaBreak")
	params.target:SpendMana(mana, self.ability)
	params.target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")
end