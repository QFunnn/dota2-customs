--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_smoke_of_deceit_lua = class({})
LinkLuaModifier( "modifier_item_smoke_of_deceit_lua", "item_ability/item_smoke_of_deceit_lua", LUA_MODIFIER_MOTION_NONE )
function item_smoke_of_deceit_lua:OnSpellStart()
    local hCaster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local application_radius = self:GetSpecialValueFor("application_radius")

    local particleID = ParticleManager:CreateParticle("particles/items2_fx/smoke_of_deceit.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
    ParticleManager:SetParticleControl(particleID, 0, hCaster:GetAbsOrigin())
    ParticleManager:SetParticleControl(particleID, 1, Vector(application_radius, 1, application_radius))
    ParticleManager:ReleaseParticleIndex(particleID)

    EmitSoundOn("DOTA_Item.SmokeOfDeceit.Activate", hCaster)

    local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, application_radius, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if IsValid(unit) and unit:IsAlive() then
            unit:AddNewModifier(hCaster, self, "modifier_item_smoke_of_deceit_lua", {duration = duration})
        end
    end
    self:SpendCharge()
end

modifier_item_smoke_of_deceit_lua = class({})
function modifier_item_smoke_of_deceit_lua:GetTexture()
    return "item_smoke_of_deceit"
end
function modifier_item_smoke_of_deceit_lua:IsHidden()
    return false
end
function modifier_item_smoke_of_deceit_lua:IsDebuff()
    return false
end
function modifier_item_smoke_of_deceit_lua:IsPurgable()
    return false
end
function modifier_item_smoke_of_deceit_lua:OnCreated()
    self.visibility_radius = self:GetAbility():GetSpecialValueFor("visibility_radius")
    self.bonus_movement_speed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
    if IsServer() then
        self:StartIntervalThink(0)
    end
end
function modifier_item_smoke_of_deceit_lua:OnIntervalThink()
    local hParent = self:GetParent()
    local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.visibility_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if IsValid(unit) and unit:IsAlive() then
            self:Destroy()
            break
        end
    end
end
function modifier_item_smoke_of_deceit_lua:CheckState()
    return {
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
        [MODIFIER_STATE_INVISIBLE] = true
    }
end
function modifier_item_smoke_of_deceit_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    }
end
function modifier_item_smoke_of_deceit_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus_movement_speed
end
function modifier_item_smoke_of_deceit_lua:GetModifierInvisibilityLevel()
    return 1
end
function modifier_item_smoke_of_deceit_lua:GetPriority()
    return 99999
end