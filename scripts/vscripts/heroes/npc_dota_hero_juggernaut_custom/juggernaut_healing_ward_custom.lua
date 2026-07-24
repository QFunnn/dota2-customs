--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_juggernaut_healing_ward_custom", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_healing_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_healing_ward_custom_aura", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_healing_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_healing_ward_custom_invul", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_healing_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_healing_ward_custom_speed", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_healing_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)

juggernaut_healing_ward_custom = class({})

function juggernaut_healing_ward_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_healing_ward.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
end

juggernaut_healing_ward_custom.modifier_juggernaut_5_cd = -30
juggernaut_healing_ward_custom.modifier_juggernaut_5 = {10,20,30}

function juggernaut_healing_ward_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_juggernaut_3") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function juggernaut_healing_ward_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_juggernaut_5") then
        bonus = self.modifier_juggernaut_5_cd
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function juggernaut_healing_ward_custom:GetAOERadius()
    return self:GetSpecialValueFor("healing_ward_aura_radius")
end

function juggernaut_healing_ward_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_juggernaut_7") then
        return 0
    end
    return self.BaseClass.GetCastPoint( self )
end

function juggernaut_healing_ward_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local wards = Entities:FindAllByModel("models/heroes/juggernaut/jugg_healing_ward.vmdl")
    for _,ward in pairs(wards) do 
        if ward:GetTeamNumber() == self:GetCaster():GetTeamNumber() then 
            ward:ForceKill(false)
        end
    end
    local ward = CreateUnitByName("juggernaut_healing_ward", self:GetCursorPosition(), true, nil, nil, self:GetCaster():GetTeamNumber())
    ward:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})
    ward:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)
    ward:SetOwner(self:GetCaster())
    Timers:CreateTimer(0.05, function() ward:MoveToNPC(self:GetCaster()) end)
    ward:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_healing_ward_custom", {})
    if self:GetCaster():HasModifier("modifier_juggernaut_7") then
        ward:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_healing_ward_custom_invul", {duration = 4})
    end
    if self:GetCaster():HasModifier("modifier_juggernaut_3") then
        ward:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_healing_ward_custom_speed", {})
    end
end

modifier_juggernaut_healing_ward_custom = class({})

function modifier_juggernaut_healing_ward_custom:OnCreated(table)
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Juggernaut.HealingWard.Cast")
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_healing_ward.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetAbility():GetSpecialValueFor("healing_ward_aura_radius"), 1, 1))
    ParticleManager:SetParticleControlEnt(self.particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "flame_attachment", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.particle, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_Juggernaut.HealingWard.Loop") 
    self.hits = 1
    if self:GetCaster():HasModifier("modifier_juggernaut_1") then
        self.hits = self.hits + self:GetCaster():GetTalentLevel("modifier_juggernaut_1")
    end
    self:GetParent():SetBaseMaxHealth(self.hits)
    self:GetParent():SetMaxHealth(self.hits)
    self:GetParent():SetHealth(self.hits)
    self:StartIntervalThink(FrameTime())
end

function modifier_juggernaut_healing_ward_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then
        self:Destroy()
    end
end

function modifier_juggernaut_healing_ward_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_juggernaut_5") then
        self:DeathEvent()
    end
    self:GetParent():EmitSound("Hero_Juggernaut.HealingWard.Stop")
    self:GetParent():AddNoDraw()
    self:GetParent():AddEffects(EF_NODRAW)
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, true)
        ParticleManager:ReleaseParticleIndex(self.particle)
    end
    self:GetParent():StopSound("Hero_Juggernaut.HealingWard.Loop")
end

function modifier_juggernaut_healing_ward_custom:DeathEvent()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:GetParent():EmitSound("Item.GuardianGreaves.Activate")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("healing_ward_aura_radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, enemy in pairs(units) do
        if self:GetCaster():HasModifier("modifier_juggernaut_5") then
            local heal = enemy:GetMaxHealth() / 100 * self:GetAbility().modifier_juggernaut_5[self:GetCaster():GetTalentLevel("modifier_juggernaut_5")]
            enemy:Heal(heal, self:GetAbility())
        end
    end
end

function modifier_juggernaut_healing_ward_custom:IsHidden() return true end
function modifier_juggernaut_healing_ward_custom:IsPurgable() return false end
function modifier_juggernaut_healing_ward_custom:IsAura() return true end
function modifier_juggernaut_healing_ward_custom:GetAuraDuration() return 2 end
function modifier_juggernaut_healing_ward_custom:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("healing_ward_aura_radius") end
function modifier_juggernaut_healing_ward_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_juggernaut_healing_ward_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_juggernaut_healing_ward_custom:GetModifierAura() return "modifier_juggernaut_healing_ward_custom_aura" end

function modifier_juggernaut_healing_ward_custom:CheckState() 
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true
    }
end

function modifier_juggernaut_healing_ward_custom:DeclareFunctions() 
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
         
        MODIFIER_PROPERTY_HEALTHBAR_PIPS
    } 
end

function modifier_juggernaut_healing_ward_custom:GetModifierHealthBarPips()
    self.hits = 1
    if self:GetCaster():HasModifier("modifier_juggernaut_1") then
        self.hits = self.hits + self:GetCaster():GetTalentLevel("modifier_juggernaut_1")
    end
    return self.hits
end


function modifier_juggernaut_healing_ward_custom:GetAbsoluteNoDamageMagical() return 1 end
function modifier_juggernaut_healing_ward_custom:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_juggernaut_healing_ward_custom:GetAbsoluteNoDamagePure() return 1 end

function modifier_juggernaut_healing_ward_custom:OnAttackLanded( param )
    if not IsServer() then return end
    if self:GetParent() ~= param.target then return end
    self.hits = self.hits - 1
    if self.hits <= 0 then
        self:GetParent():Kill(nil, param.attacker)
    else
        self:GetParent():SetHealth(self.hits)
    end
end

modifier_juggernaut_healing_ward_custom_aura = class({})

function modifier_juggernaut_healing_ward_custom_aura:IsPurgable() return false end

function modifier_juggernaut_healing_ward_custom_aura:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
    }
end 

function modifier_juggernaut_healing_ward_custom_aura:OnCreated()
    self.health_regen = self:GetAbility():GetSpecialValueFor("healing_ward_heal_amount")
end

function modifier_juggernaut_healing_ward_custom_aura:GetModifierHealthRegenPercentage() return self.health_regen end

modifier_juggernaut_healing_ward_custom_invul = class({})
function modifier_juggernaut_healing_ward_custom_invul:IsHidden() return true end
function modifier_juggernaut_healing_ward_custom_invul:IsPurgable() return false end
function modifier_juggernaut_healing_ward_custom_invul:IsPurgeException() return false end
function modifier_juggernaut_healing_ward_custom_invul:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end


modifier_juggernaut_healing_ward_custom_speed = class({})
function modifier_juggernaut_healing_ward_custom_speed:IsHidden() return true end
function modifier_juggernaut_healing_ward_custom_speed:IsPurgable() return false end
function modifier_juggernaut_healing_ward_custom_speed:IsPurgeException() return false end
function modifier_juggernaut_healing_ward_custom_speed:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    }
end

function modifier_juggernaut_healing_ward_custom_speed:GetModifierMoveSpeed_Absolute()
    return self:GetCaster():GetMoveSpeedModifier(self:GetCaster():GetBaseMoveSpeed(), true)
end