--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_reactive_tazer_custom", "heroes/npc_dota_hero_techies_custom/techies_reactive_tazer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_reactive_tazer_custom_debuff", "heroes/npc_dota_hero_techies_custom/techies_reactive_tazer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_reactive_tazer_custom_thinker", "heroes/npc_dota_hero_techies_custom/techies_reactive_tazer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_reactive_tazer_custom_debuff_thinker", "heroes/npc_dota_hero_techies_custom/techies_reactive_tazer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_reactive_tazer_custom_regen_buff", "heroes/npc_dota_hero_techies_custom/techies_reactive_tazer_custom", LUA_MODIFIER_MOTION_NONE)

techies_reactive_tazer_custom = class({})

techies_reactive_tazer_custom.modifier_techies_8_duration = 5
techies_reactive_tazer_custom.modifier_techies_8 = {30,50,70}
techies_reactive_tazer_custom.modifier_techies_12 = {0.1,0.2,0.3}
techies_reactive_tazer_custom.modifier_techies_12_speed = {5,10,15}
techies_reactive_tazer_custom.modifier_techies_13 = 10

function techies_reactive_tazer_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_tazer_explode.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_tazer_link.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_tazer_target.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_tazer.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_techies_tazer.vpcf", context)
    PrecacheResource("particle", "particles/techies_tazer_ground_explosion.vpcf", context)
end

function techies_reactive_tazer_custom:GetCooldown( level )
	return self.BaseClass.GetCooldown( self, level )
end

function techies_reactive_tazer_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local target = self:GetCursorTarget()
    self.target = target
    target:AddNewModifier(self:GetCaster(), self, "modifier_techies_reactive_tazer_custom", {duration = duration})
end

modifier_techies_reactive_tazer_custom = class({})

function modifier_techies_reactive_tazer_custom:OnCreated()
    self.bonus_ms = self:GetAbility():GetSpecialValueFor("bonus_ms")
    self.disarm_duration = self:GetAbility():GetSpecialValueFor("disarm_duration")
    if self:GetCaster():HasModifier("modifier_techies_12") then
        self.bonus_ms = self.bonus_ms + self:GetAbility().modifier_techies_12_speed[self:GetCaster():GetTalentLevel("modifier_techies_12")]
        self.disarm_duration = self.disarm_duration + self:GetAbility().modifier_techies_12[self:GetCaster():GetTalentLevel("modifier_techies_12")]
    end
    self.stun_radius = self:GetAbility():GetSpecialValueFor("stun_radius")
    if not IsServer() then return end
    self:GetParent():EmitSound("DOTA_Item.Mjollnir.Loop")
    local techies_reactive_tazer_stop_custom = self:GetCaster():FindAbilityByName("techies_reactive_tazer_stop_custom")
    if techies_reactive_tazer_stop_custom then
        techies_reactive_tazer_stop_custom:SetLevel(self:GetAbility():GetLevel())
        techies_reactive_tazer_stop_custom:UseResources(false, false, false, true)
        self:GetCaster():SwapAbilities("techies_reactive_tazer_custom", "techies_reactive_tazer_stop_custom", false, true)
    end
end

function modifier_techies_reactive_tazer_custom:DeclareFunctions()
    return
    {
         
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_techies_reactive_tazer_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus_ms
end

function modifier_techies_reactive_tazer_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target == nil then return end
    if params.target ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
    params.attacker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_techies_reactive_tazer_custom_debuff", {duration = self.disarm_duration * (1-params.attacker:GetStatusResistance())})
end

function modifier_techies_reactive_tazer_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Techies.ReactiveTazer.Detonate")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_tazer_explode.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.stun_radius,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.stun_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false)
    for _, unit in pairs(units) do
        unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_reactive_tazer_custom_debuff", {duration = self.disarm_duration * (1-unit:GetStatusResistance())})
    end
    local techies_reactive_tazer_stop_custom = self:GetCaster():FindAbilityByName("techies_reactive_tazer_stop_custom")
    if techies_reactive_tazer_stop_custom then
        self:GetCaster():SwapAbilities("techies_reactive_tazer_stop_custom", "techies_reactive_tazer_custom", false, true)
    end
    self:GetParent():StopSound("DOTA_Item.Mjollnir.Loop")
    if self:GetCaster():HasModifier("modifier_techies_8") then
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_techies_reactive_tazer_custom_thinker", {duration = self:GetAbility().modifier_techies_8_duration}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    end
end

function modifier_techies_reactive_tazer_custom:GetEffectName()
    return "particles/units/heroes/hero_techies/techies_tazer.vpcf"
end

function modifier_techies_reactive_tazer_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_techies_tazer.vpcf"
end

modifier_techies_reactive_tazer_custom_debuff = class({})
function modifier_techies_reactive_tazer_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_techies_reactive_tazer_custom_debuff:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_tazer_link.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:SetParticleControlEnt( particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:ReleaseParticleIndex(particle)
    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_techies/techies_tazer_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
    ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
    self:AddParticle( self.effect_cast, false, false, -1, false, false )
    if self:GetParent():IsDebuffImmune() then return end
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_techies_13") then
        damage = damage + (self:GetCaster():GetMaxMana() / 100 * self:GetAbility().modifier_techies_13)
    end
    ApplyDamage({ attacker = self:GetCaster(), victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
    self:GetParent():Purge(true, false, false, false, false)
end
function modifier_techies_reactive_tazer_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

techies_reactive_tazer_stop_custom = class({})
function techies_reactive_tazer_stop_custom:OnSpellStart()
    if not IsServer() then return end
    local techies_reactive_tazer_custom = self:GetCaster():FindAbilityByName("techies_reactive_tazer_custom")
    local modifier_techies_reactive_tazer_custom = techies_reactive_tazer_custom.target:FindModifierByName("modifier_techies_reactive_tazer_custom")
    if modifier_techies_reactive_tazer_custom then
        modifier_techies_reactive_tazer_custom:Destroy()
    end
end

modifier_techies_reactive_tazer_custom_thinker = class({})
function modifier_techies_reactive_tazer_custom_thinker:IsHidden() return true end
function modifier_techies_reactive_tazer_custom_thinker:IsPurgable() return false end
function modifier_techies_reactive_tazer_custom_thinker:IsAura() return true end
function modifier_techies_reactive_tazer_custom_thinker:GetModifierAura() return "modifier_techies_reactive_tazer_custom_debuff_thinker" end
function modifier_techies_reactive_tazer_custom_thinker:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("stun_radius") end
function modifier_techies_reactive_tazer_custom_thinker:GetAuraDuration() return 0.1 end
function modifier_techies_reactive_tazer_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_techies_reactive_tazer_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_techies_reactive_tazer_custom_thinker:GetAuraSearchFlags() return 0 end
function modifier_techies_reactive_tazer_custom_thinker:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/techies_tazer_ground_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 7, Vector(self:GetAbility():GetSpecialValueFor("stun_radius"), 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    self:StartIntervalThink(0.3)
end
function modifier_techies_reactive_tazer_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/techies_tazer_ground_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 7, Vector(self:GetAbility():GetSpecialValueFor("stun_radius"), 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_techies_reactive_tazer_custom_debuff_thinker = class({})
function modifier_techies_reactive_tazer_custom_debuff_thinker:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end
function modifier_techies_reactive_tazer_custom_debuff_thinker:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self:GetAbility().modifier_techies_8[self:GetCaster():GetTalentLevel("modifier_techies_8")], damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
end


modifier_techies_reactive_tazer_custom_regen_buff = class({})
function modifier_techies_reactive_tazer_custom_regen_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE, 
    }
end

function modifier_techies_reactive_tazer_custom_regen_buff:GetEffectName()
    return "particles/econ/events/fall_2021/fountain_regen_fall_2021.vpcf"
end