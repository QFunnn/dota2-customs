--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_drake_arcane_power",
	"abilities/creeps_neutral/neutral_drake_arcane_power",
	LUA_MODIFIER_MOTION_NONE
)

neutral_drake_arcane_power = class({})

function neutral_drake_arcane_power:GetIntrinsicModifierName()
	return "modifier_neutral_drake_arcane_power"
end

modifier_neutral_drake_arcane_power = class(mod_hidden)
function modifier_neutral_drake_arcane_power:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage") / 100

	self.parent:AddAttackEvent_out(self, true)
end

function modifier_neutral_drake_arcane_power:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_neutral_drake_arcane_power:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not params.target:IsUnit() then
		return
	end

	DoDamage({
		victim = params.target,
		attacker = self.parent,
		damage = params.original_damage * self.ability.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end