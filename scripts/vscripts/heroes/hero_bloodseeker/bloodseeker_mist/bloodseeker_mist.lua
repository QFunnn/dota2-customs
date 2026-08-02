--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_bloodseeker_mist",
	"heroes/hero_bloodseeker/bloodseeker_mist/bloodseeker_mist",
	LUA_MODIFIER_MOTION_NONE
)

bloodseeker_mist = class({})

function bloodseeker_mist:GetIntrinsicModifierName()
	return "modifier_bloodseeker_mist"
end

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

modifier_bloodseeker_mist = class({})

function modifier_bloodseeker_mist:IsHidden()
	return true
end

function modifier_bloodseeker_mist:IsPurgable()
	return false
end

function modifier_bloodseeker_mist:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_bloodseeker_mist:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_bloodseeker_mist:GetModifierPreAttack_BonusDamage()
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	local abil = self:GetCaster():FindAbilityByName("special_bonus_bloodseeker_4")
	if abil ~= nil and abil:GetLevel() > 0 then
		self.damage = self.damage + 3
	end
	return (100 - self:GetCaster():GetHealthPercent()) * self.damage
end