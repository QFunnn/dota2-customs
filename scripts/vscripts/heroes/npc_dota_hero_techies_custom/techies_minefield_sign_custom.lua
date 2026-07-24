--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_minefield_sign_custom", "heroes/npc_dota_hero_techies_custom/techies_minefield_sign_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_minefield_sign_custom_thinker", "heroes/npc_dota_hero_techies_custom/techies_minefield_sign_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_minefield_sign_custom_damage_thinker", "heroes/npc_dota_hero_techies_custom/techies_minefield_sign_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_minefield_sign_custom_damage_thinker_debuff", "heroes/npc_dota_hero_techies_custom/techies_minefield_sign_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_minefield_sign_custom_sign_activated", "heroes/npc_dota_hero_techies_custom/techies_minefield_sign_custom", LUA_MODIFIER_MOTION_NONE)

techies_minefield_sign_custom = class({})

function techies_minefield_sign_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_minefield_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_minefield.vpcf", context)
end

function techies_minefield_sign_custom:GetAOERadius()
    return self:GetSpecialValueFor("aura_radius")
end

function techies_minefield_sign_custom:OnAbilityPhaseStart()
    self.point = self:GetCursorPosition()
    self.modifier_techies_minefield_sign_custom_thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_techies_minefield_sign_custom_thinker", {duration = self:GetCastPoint()}, self.point, self:GetCaster():GetTeamNumber(), false)
    return true
end

function techies_minefield_sign_custom:OnAbilityPhaseInterrupted()
    if self.modifier_techies_minefield_sign_custom_thinker and not self.modifier_techies_minefield_sign_custom_thinker:IsNull() then
        self.modifier_techies_minefield_sign_custom_thinker:Destroy()
    end
end

function techies_minefield_sign_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self.point
    self:GetCaster():EmitSound("Hero_Techies.Sign")
    local sign = CreateUnitByName("npc_dota_techies_minefield_sign", point, false, nil, nil, self:GetCaster():GetTeamNumber())
    sign:SetOwner(self:GetCaster())
    sign:AddNewModifier(self:GetCaster(), self, "modifier_techies_minefield_sign_custom", {})
    sign:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = self:GetSpecialValueFor("lifetime")})
    sign:SetForwardVector(Vector(1,-2,0))
    self.assigned_sign = sign
end

modifier_techies_minefield_sign_custom = class({})
function modifier_techies_minefield_sign_custom:IsHidden() return true end
function modifier_techies_minefield_sign_custom:IsPurgable() return false end
function modifier_techies_minefield_sign_custom:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true
    }
end
function modifier_techies_minefield_sign_custom:OnCreated()
    if not IsServer() then return end
    self.activated_sign = false
    self:StartIntervalThink(0.1)
end
function modifier_techies_minefield_sign_custom:OnIntervalThink()
    if not IsServer() then return end
    self:FindMines()
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("scepter_move_amt"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    if #units > 0 and not self.activated_sign then
        self.activated_sign = true
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_minefield_sign_custom_sign_activated", {duration = self:GetAbility():GetSpecialValueFor("minefield_duration")})
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_techies_minefield_sign_custom_damage_thinker", {duration = self:GetAbility():GetSpecialValueFor("minefield_duration")}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    end
end

function modifier_techies_minefield_sign_custom:FindMines()
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("aura_radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit and unit:GetUnitName() == "npc_dota_techies_land_mine" and unit:GetOwner() == self:GetCaster() then
            unit:AddNewModifier(unit, self:GetAbility(), "modifier_invulnerable", {duration = 0.2})
        end
    end
end

modifier_techies_minefield_sign_custom_thinker = class({})
function modifier_techies_minefield_sign_custom_thinker:IsHidden() return true end
function modifier_techies_minefield_sign_custom_thinker:OnCreated()
    if not IsServer() then return end
    local trigger_radius = self:GetAbility():GetSpecialValueFor("trigger_radius")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_minefield_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(trigger_radius,0,0))
    self:AddParticle(particle, false, false, -1, false, true)
    self:GetParent():EmitSound("Hero_Techies.Sign.Start")
end
function modifier_techies_minefield_sign_custom_thinker:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Hero_Techies.Sign.Start")
end

modifier_techies_minefield_sign_custom_sign_activated = class({})
function modifier_techies_minefield_sign_custom_sign_activated:IsHidden() return true end
function modifier_techies_minefield_sign_custom_sign_activated:IsPurgable() return false end
function modifier_techies_minefield_sign_custom_sign_activated:OnDestroy()
    if not IsServer() then return end
    self:GetParent():ForceKill(false)
end

modifier_techies_minefield_sign_custom_damage_thinker = class({})
function modifier_techies_minefield_sign_custom_damage_thinker:IsHidden() return true end
function modifier_techies_minefield_sign_custom_damage_thinker:IsPurgable() return false end
function modifier_techies_minefield_sign_custom_damage_thinker:IsAura() return true end
function modifier_techies_minefield_sign_custom_damage_thinker:GetModifierAura() return "modifier_techies_minefield_sign_custom_damage_thinker_debuff" end
function modifier_techies_minefield_sign_custom_damage_thinker:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("aura_radius") end
function modifier_techies_minefield_sign_custom_damage_thinker:GetAuraDuration() return 0.1 end
function modifier_techies_minefield_sign_custom_damage_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_techies_minefield_sign_custom_damage_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_techies_minefield_sign_custom_damage_thinker:GetAuraSearchFlags() return 0 end
function modifier_techies_minefield_sign_custom_damage_thinker:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Techies.MinefieldSign.Trigger")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_minefield.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self:GetAbility():GetSpecialValueFor("aura_radius"),0,0))
    self:AddParticle(particle, false, false, -1, false, false)
end

modifier_techies_minefield_sign_custom_damage_thinker_debuff = class({})
function modifier_techies_minefield_sign_custom_damage_thinker_debuff:IsPurgable() return false end
function modifier_techies_minefield_sign_custom_damage_thinker_debuff:IsHidden() return false end
function modifier_techies_minefield_sign_custom_damage_thinker_debuff:OnCreated()
    if not IsServer() then return end
    self.max_distance = 200
    self.distance = 0
    self.origin = self:GetParent():GetAbsOrigin()
    self:StartIntervalThink(FrameTime())
end
function modifier_techies_minefield_sign_custom_damage_thinker_debuff:OnIntervalThink()
    if not IsServer() then return end
    local distance = (self:GetParent():GetAbsOrigin() - self.origin):Length2D()
    self.distance = self.distance + distance
    if self.distance >= self.max_distance then
        self.distance = 0
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_minefield_scepter_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 2, Vector(225,0,0))
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetParent():EmitSound("Hero_Techies.MinefieldSign.Detonate")
        ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self:GetAbility():GetSpecialValueFor("scepter_move_damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
    end
    self.origin = self:GetParent():GetAbsOrigin()
end
function modifier_techies_minefield_sign_custom_damage_thinker_debuff:GetEffectName()
    return "particles/units/heroes/hero_techies/techies_minefield_target.vpcf"
end