--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_deafening_blast_lua_knockback = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_deafening_blast_lua_knockback:IsHidden()
    return false
end

function modifier_invoker_deafening_blast_lua_knockback:IsDebuff()
    return true
end

function modifier_invoker_deafening_blast_lua_knockback:IsStunDebuff()
    return false
end

function modifier_invoker_deafening_blast_lua_knockback:IsPurgable()
    return true
end

function modifier_invoker_deafening_blast_lua_knockback:IsStunDebuff()
    return false
end

function modifier_invoker_deafening_blast_lua_knockback:CheckState()
    local state =    {
        [MODIFIER_STATE_STUNNED] = true,
    }
    return state
end

function modifier_invoker_deafening_blast_lua_knockback:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf"
end

function modifier_invoker_deafening_blast_lua_knockback:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end