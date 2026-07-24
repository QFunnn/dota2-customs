--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_juggernaut_fire_ward_custom", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_fire_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_fire_ward_custom_aura", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_fire_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_healing_ward_custom_invul", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_healing_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_healing_ward_custom_speed", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_healing_ward_custom.lua", LUA_MODIFIER_MOTION_NONE)

juggernaut_fire_ward_custom = class({})

function juggernaut_fire_ward_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context )
    PrecacheResource( "particle", "particles/juggernaut_healing_ward_fire.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_techies/techies_blast_off.vpcf", context )
end

function juggernaut_fire_ward_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_juggernaut_3") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function juggernaut_fire_ward_custom:GetAOERadius()
    return self:GetSpecialValueFor("healing_ward_aura_radius")
end

function juggernaut_fire_ward_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_juggernaut_7") then
        return 0
    end
    return self.BaseClass.GetCastPoint( self )
end

function juggernaut_fire_ward_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local wards = Entities:FindAllByModel("models/items/juggernaut/ward/fall20_juggernaut_katz_ward/fall20_juggernaut_katz_ward.vmdl")
    for _,ward in pairs(wards) do 
        if ward:GetTeamNumber() == self:GetCaster():GetTeamNumber() then 
            ward:ForceKill(false)
        end
    end
    local ward = CreateUnitByName("juggernaut_healing_ward_fire", self:GetCursorPosition(), true, nil, nil, self:GetCaster():GetTeamNumber())
    ward:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})
    ward:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)
    ward:SetOwner(self:GetCaster())
    Timers:CreateTimer(0.05, function() ward:MoveToNPC(self:GetCaster()) end)
    ward:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_fire_ward_custom", {})
    ward:SetRenderColor(255, 0, 0)
    if self:GetCaster():HasModifier("modifier_juggernaut_7") then
        ward:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_healing_ward_custom_invul", {duration = 4})
    end
    if self:GetCaster():HasModifier("modifier_juggernaut_3") then
        ward:AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_healing_ward_custom_speed", {})
    end
end

modifier_juggernaut_fire_ward_custom = class({})

function modifier_juggernaut_fire_ward_custom:OnCreated(table)
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Juggernaut.HealingWard.Cast")
    self.particle = ParticleManager:CreateParticle("particles/juggernaut_healing_ward_fire.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self:GetAbility():GetSpecialValueFor("healing_ward_aura_radius"), 1, 1))
    ParticleManager:SetParticleControlEnt(self.particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "flame_attachment", self:GetParent():GetAbsOrigin(), true)
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

function modifier_juggernaut_fire_ward_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then
        self:Destroy()
    end
end

function modifier_juggernaut_fire_ward_custom:OnDestroy()
    if not IsServer() then return end
    self:DeathEvent()
    self:GetParent():EmitSound("Hero_Juggernaut.HealingWard.Stop")
    self:GetParent():AddNoDraw()
    self:GetParent():AddEffects(EF_NODRAW)
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, true)
        ParticleManager:ReleaseParticleIndex(self.particle)
    end
    self:GetParent():StopSound("Hero_Juggernaut.HealingWard.Loop")
end

function modifier_juggernaut_fire_ward_custom:IsHidden() return true end
function modifier_juggernaut_fire_ward_custom:IsPurgable() return false end
function modifier_juggernaut_fire_ward_custom:IsAura() return true end
function modifier_juggernaut_fire_ward_custom:GetAuraDuration() return 0 end
function modifier_juggernaut_fire_ward_custom:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("healing_ward_aura_radius") end
function modifier_juggernaut_fire_ward_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_juggernaut_fire_ward_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_juggernaut_fire_ward_custom:GetModifierAura() return "modifier_juggernaut_fire_ward_custom_aura" end

function modifier_juggernaut_fire_ward_custom:CheckState() 
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true
    }
end

function modifier_juggernaut_fire_ward_custom:DeclareFunctions() 
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
         
        MODIFIER_PROPERTY_HEALTHBAR_PIPS
    } 
end

function modifier_juggernaut_fire_ward_custom:GetModifierHealthBarPips()
    self.hits = 1
    if self:GetCaster():HasModifier("modifier_juggernaut_1") then
        self.hits = self.hits + self:GetCaster():GetTalentLevel("modifier_juggernaut_1")
    end
    return self.hits
end


function modifier_juggernaut_fire_ward_custom:GetAbsoluteNoDamageMagical() return 1 end
function modifier_juggernaut_fire_ward_custom:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_juggernaut_fire_ward_custom:GetAbsoluteNoDamagePure() return 1 end

function modifier_juggernaut_fire_ward_custom:OnAttackLanded( param )
    if not IsServer() then return end
    if self:GetParent() ~= param.target then return end
    self.hits = self.hits - 1
    if self.hits <= 0 then
        self:GetParent():Kill(nil, param.attacker)
    else
        self:GetParent():SetHealth(self.hits)
    end
end

function modifier_juggernaut_fire_ward_custom:DeathEvent()
    if not IsServer() then return end
    local damage_base = self:GetAbility():GetSpecialValueFor("death_damage")
    local damage_perc = self:GetAbility():GetSpecialValueFor("death_damage_perc")
    local damage = damage_base + (self:GetCaster():GetStrength() / 100 * damage_perc)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("healing_ward_aura_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, enemy in pairs(units) do
        ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self:GetAbility() })
    end
    self:GetCaster():EmitSound("Hero_Techies.Suicide")
    local particle_explosion_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_blast_off.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle_explosion_fx, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_explosion_fx)
end

modifier_juggernaut_fire_ward_custom_aura = class({})

function modifier_juggernaut_fire_ward_custom_aura:IsPurgable() return false end

function modifier_juggernaut_fire_ward_custom_aura:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
end

function modifier_juggernaut_fire_ward_custom_aura:OnIntervalThink()
    if not IsServer() then return end
    local damage_base = self:GetAbility():GetSpecialValueFor("damage_base")
    local damage_perc = self:GetAbility():GetSpecialValueFor("damage_perc")
    local damage = damage_base + (self:GetCaster():GetStrength() / 100 * damage_perc)
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end