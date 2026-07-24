--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_faceless_void_chronosphere_custom", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_chronosphere_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_faceless_void_chronosphere_custom_enemy", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_chronosphere_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_faceless_void_chronosphere_custom_friendly", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_chronosphere_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_faceless_void_chronosphere_custom_friendly_buff", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_chronosphere_custom", LUA_MODIFIER_MOTION_NONE)

faceless_void_chronosphere_custom = class({})
faceless_void_chronosphere_custom.modifier_faceless_void_12 = {8,16}

function faceless_void_chronosphere_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_faceless_void_14") then
        return "faceless_void_14"
    end
    return "faceless_void_chronosphere"
end

function faceless_void_chronosphere_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf", context)
end

function faceless_void_chronosphere_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function faceless_void_chronosphere_custom:GetBehavior()
    local behavior = DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT
    if self:GetCaster():HasModifier("modifier_faceless_void_14") then
        if not self:GetCaster():HasModifier("modifier_wodawisp") and not self:GetCaster():IsHexed() then
            behavior = behavior + 137438953472
        end
    end
    return behavior
end

function faceless_void_chronosphere_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
	local vision = self:GetSpecialValueFor("vision_radius")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), point, vision, duration, false)
    CreateModifierThinker(self:GetCaster(), self, "modifier_faceless_void_chronosphere_custom", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
    CreateModifierThinker(self:GetCaster(), self, "modifier_faceless_void_chronosphere_custom_friendly", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_faceless_void_chronosphere_custom = class({})
function modifier_faceless_void_chronosphere_custom:IsPurgable() return false end
function modifier_faceless_void_chronosphere_custom:IsHidden() return true end
function modifier_faceless_void_chronosphere_custom:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_FacelessVoid.Chronosphere")
end

function modifier_faceless_void_chronosphere_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Hero_FacelessVoid.Chronosphere")
end

function modifier_faceless_void_chronosphere_custom:IsAura()
    return true
end

function modifier_faceless_void_chronosphere_custom:GetModifierAura()
    return "modifier_faceless_void_chronosphere_custom_enemy"
end

function modifier_faceless_void_chronosphere_custom:GetAuraRadius()
    return self.radius
end

function modifier_faceless_void_chronosphere_custom:GetAuraDuration()
    return 0
end

function modifier_faceless_void_chronosphere_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_faceless_void_chronosphere_custom:GetAuraEntityReject(hEntity)
    if hEntity == self:GetCaster() and hEntity:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
        return true
    end
    if hEntity:GetUnitName() == "npc_dota_hero_faceless_void" then
        return true
    end
    return false
end

function modifier_faceless_void_chronosphere_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_ALL
end

function modifier_faceless_void_chronosphere_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
end

modifier_faceless_void_chronosphere_custom_friendly = class({})
function modifier_faceless_void_chronosphere_custom_friendly:IsPurgable() return false end
function modifier_faceless_void_chronosphere_custom_friendly:IsHidden() return true end
function modifier_faceless_void_chronosphere_custom_friendly:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_faceless_void_chronosphere_custom_friendly:IsAura()
    return true
end

function modifier_faceless_void_chronosphere_custom_friendly:GetModifierAura()
    return "modifier_faceless_void_chronosphere_custom_friendly_buff"
end

function modifier_faceless_void_chronosphere_custom_friendly:GetAuraRadius()
    return self.radius
end

function modifier_faceless_void_chronosphere_custom_friendly:GetAuraDuration()
    return 0
end

function modifier_faceless_void_chronosphere_custom_friendly:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_faceless_void_chronosphere_custom_friendly:GetAuraEntityReject(hEntity)
    if hEntity == self:GetCaster() and hEntity:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
        return false
    end
    return true
end

function modifier_faceless_void_chronosphere_custom_friendly:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_faceless_void_chronosphere_custom_friendly:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
end

modifier_faceless_void_chronosphere_custom_friendly_buff = class({})
function modifier_faceless_void_chronosphere_custom_friendly_buff:IsHidden() return true end
function modifier_faceless_void_chronosphere_custom_friendly_buff:IsPurgable() return false end
function modifier_faceless_void_chronosphere_custom_friendly_buff:IsPurgeException() return false end
function modifier_faceless_void_chronosphere_custom_friendly_buff:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_faceless_void_chronosphere_speed", {})
end
function modifier_faceless_void_chronosphere_custom_friendly_buff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_faceless_void_chronosphere_speed")
end
function modifier_faceless_void_chronosphere_custom_friendly_buff:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = self:GetParent():HasModifier("modifier_faceless_void_14") and true or nil
    }
end

modifier_faceless_void_chronosphere_custom_enemy = class({})
function modifier_faceless_void_chronosphere_custom_enemy:IsHidden() return true end
function modifier_faceless_void_chronosphere_custom_enemy:IsPurgable() return false end
function modifier_faceless_void_chronosphere_custom_enemy:IsPurgeException() return false end
function modifier_faceless_void_chronosphere_custom_enemy:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_faceless_void_chronosphere_freeze", {})
end
function modifier_faceless_void_chronosphere_custom_enemy:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasModifier("modifier_faceless_void_chronosphere_freeze") then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_faceless_void_chronosphere_freeze", {})
    end
end
function modifier_faceless_void_chronosphere_custom_enemy:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_faceless_void_chronosphere_freeze")
end
function modifier_faceless_void_chronosphere_custom_enemy:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_faceless_void_chronosphere_custom_enemy:GetModifierIncomingDamage_Percentage()
    if self:GetCaster():HasModifier("modifier_faceless_void_12") then
        return self:GetAbility().modifier_faceless_void_12[self:GetCaster():GetTalentLevel("modifier_faceless_void_12")]
    end
end

function modifier_faceless_void_chronosphere_custom_enemy:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_FROZEN] = true,
    }
end