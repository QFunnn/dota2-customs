--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



if modifier_drow_ranger_trueshot_lua_aura_effect == nil then modifier_drow_ranger_trueshot_lua_aura_effect = class({}) end
function modifier_drow_ranger_trueshot_lua_aura_effect:IsHidden() return false end
function modifier_drow_ranger_trueshot_lua_aura_effect:IsDebuff() return false end
function modifier_drow_ranger_trueshot_lua_aura_effect:IsPurgable() return false end

function modifier_drow_ranger_trueshot_lua_aura_effect:GetStatusEffectName()  
	return "particles/units/heroes/hero_drow/drow_aura_buff.vpcf"
end
function modifier_drow_ranger_trueshot_lua_aura_effect:OnCreated(keys)
	
end
function modifier_drow_ranger_trueshot_lua_aura_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end
function modifier_drow_ranger_trueshot_lua_aura_effect:GetModifierPreAttack_BonusDamage( params )
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if caster and ability and caster.GetAgility then
	   return self:GetAbility():GetSpecialValueFor("trueshot_ranged_damage") / 100 * self:GetAbility():GetCaster():GetAgility()
    end
end

----------------------------------------