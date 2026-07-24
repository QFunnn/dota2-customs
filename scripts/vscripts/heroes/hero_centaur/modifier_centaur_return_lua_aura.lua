--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_centaur_return_lua_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_centaur_return_lua_aura:IsHidden()
	return true
end

function modifier_centaur_return_lua_aura:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
function modifier_centaur_return_lua_aura:IsAura()
	return true
end

function modifier_centaur_return_lua_aura:GetModifierAura()
	return "modifier_centaur_return_lua"
end

function modifier_centaur_return_lua_aura:GetAuraRadius()

	local talent = self:GetParent():FindAbilityByName("special_bonus_unique_centaur_1")
    if talent and talent:GetLevel() > 0 then
        return self:GetAbility():GetSpecialValueFor( "aura_radius" )
    else
        return 1
    end
end

function modifier_centaur_return_lua_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_centaur_return_lua_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_centaur_return_lua_aura:GetAuraDuration()
	return 0.5
end