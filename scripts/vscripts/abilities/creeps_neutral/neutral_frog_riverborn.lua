--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_frog_riverborn",
	"abilities/creeps_neutral/neutral_frog_riverborn",
	LUA_MODIFIER_MOTION_NONE
)

neutral_frog_riverborn = class({})

function neutral_frog_riverborn:GetIntrinsicModifierName()
	return "modifier_neutral_frog_riverborn"
end

modifier_neutral_frog_riverborn = class(mod_hidden)
function modifier_neutral_frog_riverborn:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.reduce = self.ability:GetSpecialValueFor("reduce")
end

function modifier_neutral_frog_riverborn:GetWater()
	local origin = self.parent:GetAbsOrigin()
	local input = { startpos = origin + Vector(0, 0, 32), endpos = origin, mask = 32768 }
	TraceLine(input)
	return input.hit
end

function modifier_neutral_frog_riverborn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_neutral_frog_riverborn:GetModifierTotalDamageOutgoing_Percentage(params)
	if not self:GetWater() then
		return
	end
	return self.ability.damage
end

function modifier_neutral_frog_riverborn:GetModifierDamageOutgoing_Percentage()
	if IsServer() then
		return
	end
	if not self:GetWater() then
		return
	end
	return self.ability.damage
end

function modifier_neutral_frog_riverborn:GetModifierIncomingDamage_Percentage()
	if not self:GetWater() then
		return
	end
	return self.ability.reduce
end