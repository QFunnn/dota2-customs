--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_counter_helix_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_counter_helix_lua_debuff:IsHidden()
    return false
end

function modifier_axe_counter_helix_lua_debuff:IsPurgable()
    return true
end

function modifier_axe_counter_helix_lua_debuff:IsDebuff()
    return true
end

function modifier_axe_counter_helix_lua_debuff:OnCreated()
    self.shard_damage_reduction = self:GetAbility():GetSpecialValueFor("shard_damage_reduction")
end

function modifier_axe_counter_helix_lua_debuff:OnRefresh()
    self.shard_damage_reduction = self:GetAbility():GetSpecialValueFor("shard_damage_reduction")
end

function modifier_axe_counter_helix_lua_debuff:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_TOOLTIP,
    }
    return funcs
end
function modifier_axe_counter_helix_lua_debuff:OnTooltip()
    return self:GetStackCount() * self.shard_damage_reduction
end