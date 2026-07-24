--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_greevil_golden_jinada_lua", "creature_ability/greevil/greevil_golden_jinada_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if greevil_golden_jinada_lua == nil then
    greevil_golden_jinada_lua = class({})
end
function greevil_golden_jinada_lua:GetIntrinsicModifierName()
    return "modifier_greevil_golden_jinada_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_greevil_golden_jinada_lua == nil then
    modifier_greevil_golden_jinada_lua = class({})
end
function modifier_greevil_golden_jinada_lua:IsHidden()
    return true
end
function modifier_greevil_golden_jinada_lua:IsDebuff()
    return true
end
function modifier_greevil_golden_jinada_lua:IsPurgable()
    return false
end
function modifier_greevil_golden_jinada_lua:IsPurgeException()
    return false
end
function modifier_greevil_golden_jinada_lua:OnCreated(params)
    self.radius = self:GetAbilitySpecialValueFor("radius")
    self.gold_steal = self:GetAbilitySpecialValueFor("gold_steal")
    if IsServer() then
        local hAbility = self:GetAbility()
        local interval = 0
        if IsValid(hAbility) then
            interval = hAbility:GetCooldown(-1)
        end
        self:StartIntervalThink(interval)
    end
end
function modifier_greevil_golden_jinada_lua:OnRefresh(params)
    if IsServer() then
    end
end
function modifier_greevil_golden_jinada_lua:OnDestroy()
    if IsServer() then
    end
end
function modifier_greevil_golden_jinada_lua:DeclareFunctions()
    return
    {
    }
end
function modifier_greevil_golden_jinada_lua:OnIntervalThink(params)
    local hParent = self:GetParent()
    local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if IsValid(unit) and unit:IsRealHero() and not unit:IsTempestDouble() then
            local particleID = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_hand_of_midas.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hParent)
            ParticleManager:SetParticleControlEnt(particleID, 0, unit, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), true)
            ParticleManager:SetParticleControlEnt(particleID, 1, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
            ParticleManager:ReleaseParticleIndex(particleID)
            EmitSoundOn("DOTA_Item.Hand_Of_Midas", unit)
            unit:ModifyGoldFiltered(-self.gold_steal, false, DOTA_ModifyGold_AbilityCost)
            break
        end
    end
end