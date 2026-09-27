--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_manaburn", "abilities/creeps_neutral/neutral_satyr_manaburn", LUA_MODIFIER_MOTION_NONE)

neutral_satyr_manaburn = class({})

function neutral_satyr_manaburn:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_manaburn.vpcf", context)
end

function neutral_satyr_manaburn:GetIntrinsicModifierName()
	return "modifier_satyr_manaburn"
end

modifier_satyr_manaburn = class(mod_hidden)
function modifier_satyr_manaburn:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.mana = self.ability:GetSpecialValueFor("mana")
	self.ability.mana_max = self.ability:GetSpecialValueFor("mana_max")
end

function modifier_satyr_manaburn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
	}
end

function modifier_satyr_manaburn:GetModifierProcAttack_BonusDamage_Magical(params)
	if not IsServer() then
		return
	end
	local mana =
		math.min(params.target:GetMana(), self.ability.mana + params.target:GetMaxMana() * self.ability.mana_max / 100)
	if mana <= 0 then
		return
	end

	params.target:EmitSound("n_creep_SatyrSoulstealer.ManaBurn")
	params.target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")
	params.target:Script_ReduceMana(mana, self.ability)
	return mana
end