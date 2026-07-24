--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_chaos_meteor_lua_burn = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_chaos_meteor_lua_burn:IsHidden()
    return false
end

function modifier_invoker_chaos_meteor_lua_burn:IsDebuff()
    return true
end

function modifier_invoker_chaos_meteor_lua_burn:IsStunDebuff()
    return false
end

function modifier_invoker_chaos_meteor_lua_burn:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_invoker_chaos_meteor_lua_burn:IsPurgable()
    return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_chaos_meteor_lua_burn:OnCreated(kv)
    if IsServer() then
        if self:GetAbility() and (not self:GetAbility():IsNull()) then
            local damage = self:GetAbility():GetSpecialValueFor("burn_dps")
            local delay = 1
            self.damageTable = {
                victim = self:GetParent(),
                attacker = self:GetCaster(),
                damage = damage,
                damage_type = self:GetAbility():GetAbilityDamageType(),
                ability = self:GetAbility(), --Optional.
            }
            self:StartIntervalThink(delay)
        end
    end
end

function modifier_invoker_chaos_meteor_lua_burn:OnRefresh(kv)

end

function modifier_invoker_chaos_meteor_lua_burn:OnDestroy()

end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_invoker_chaos_meteor_lua_burn:OnIntervalThink()
    if IsServer() then
        if self:GetParent() and self:GetAbility() and (not self:GetAbility():IsNull()) then
            ApplyDamage(self.damageTable)
            -- play effects
            local sound_tick = "Hero_Invoker.ChaosMeteor.Damage"
            self:GetParent():EmitSound(sound_tick)
        end
    end
end