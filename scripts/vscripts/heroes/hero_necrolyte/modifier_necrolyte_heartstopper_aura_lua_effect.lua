--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_necrolyte_heartstopper_aura_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_necrolyte_heartstopper_aura_lua_effect:IsHidden()
    return false
end

function modifier_necrolyte_heartstopper_aura_lua_effect:DeclareFunctions()
    local funcs =
    {
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    }
    return funcs
end


function modifier_necrolyte_heartstopper_aura_lua_effect:IsDebuff()
    return true
end

function modifier_necrolyte_heartstopper_aura_lua_effect:IsPurgable()
    return false
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnCreated(kv)
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnRefresh(kv)
    if not IsServer() then return end
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnDestroy()
    self:StartIntervalThink(-1)
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetAbility() or self:GetAbility():IsNull() then  return  end
    local aura_damage = self:GetAbility():GetSpecialValueFor("aura_damage")
    local end_damage =  self:GetParent():GetMaxHealth() / 100 * aura_damage 
    if self:GetCaster():HasScepter() then
        if GetMapName() == "1x8_old" or GetMapName() == "1x8_old_pvp" then
            end_damage = end_damage + (self:GetCaster():GetHealthRegen() * 0.2)
        else
            end_damage = end_damage + (self:GetCaster():GetHealthRegen() * 0.3)
        end
    end
    local damage_table = {}
    damage_table.attacker = self:GetCaster()
    damage_table.victim = self:GetParent()
    damage_table.damage_type = DAMAGE_TYPE_MAGICAL
    damage_table.ability = self:GetAbility()
    damage_table.damage = end_damage * 0.2
    damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS
    ApplyDamage(damage_table)
end

function modifier_necrolyte_heartstopper_aura_lua_effect:GetModifierHPRegenAmplify_Percentage(params)
    if IsServer() then
       --竭心光环减少恢复 貌似无效？
       local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_necrophos_4")
       if talent and talent:GetLevel() > 0 then
          return -1*talent:GetSpecialValueFor("value")
       end
    end
    return 0
end