--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_upheaval_custom", "heroes/npc_dota_hero_warlock_custom/warlock_upheaval_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_upheaval_custom_debuff", "heroes/npc_dota_hero_warlock_custom/warlock_upheaval_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_upheaval_custom_thinker_debuff", "heroes/npc_dota_hero_warlock_custom/warlock_upheaval_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_upheaval_custom_handler", "heroes/npc_dota_hero_warlock_custom/warlock_upheaval_custom", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_warlock_upheaval_custom_thinker_buffs", "heroes/npc_dota_hero_warlock_custom/warlock_upheaval_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_upheaval_custom_buff", "heroes/npc_dota_hero_warlock_custom/warlock_upheaval_custom", LUA_MODIFIER_MOTION_NONE)

warlock_upheaval_custom = class({})
warlock_upheaval_custom.modifier_warlock_16_duration = 5
warlock_upheaval_custom.modifier_warlock_16_cooldown = {-10,-20}
warlock_upheaval_custom.modifier_warlock_17 = {15,30}
warlock_upheaval_custom.modifier_warlock_18 = {100,150,200}
warlock_upheaval_custom.modifier_warlock_20 = {5,4,3}
warlock_upheaval_custom.modifier_warlock_20_duration = 5
warlock_upheaval_custom.modifier_warlock_15 = 2.5

function warlock_upheaval_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_upheaval.vpcf", context)
    PrecacheResource("particle", "particles/warlock_custom_fx/warlock_upheaval.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_upheaval_debuff.vpcf", context)
end

function warlock_upheaval_custom:GetAOERadius()
    return self:GetSpecialValueFor("aoe")
end

function warlock_upheaval_custom:GetIntrinsicModifierName()
    return "modifier_warlock_upheaval_custom_handler"
end

function warlock_upheaval_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_warlock_16") then
        bonus = self.modifier_warlock_16_cooldown[self:GetCaster():GetTalentLevel("modifier_warlock_16")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function warlock_upheaval_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_warlock_16") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_AOE
end

function warlock_upheaval_custom:GetChannelTime()
    if self:GetCaster():HasModifier("modifier_warlock_16") then
        return
    end
    return self.BaseClass.GetChannelTime(self)
end

function warlock_upheaval_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local duration = self:GetChannelTime()
    if self:GetCaster():HasModifier("modifier_warlock_16") then
        duration = self.modifier_warlock_16_duration
    end
    self.modifier_thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_warlock_upheaval_custom", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
    if self:GetCaster():HasModifier("modifier_warlock_17") then
        self.modifier_thinker_friendly = CreateModifierThinker(self:GetCaster(), self, "modifier_warlock_upheaval_custom_thinker_buffs", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
    end
end

function warlock_upheaval_custom:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_warlock_16") then
        return
    end
    if self.modifier_thinker and not self.modifier_thinker:IsNull() then
        UTIL_Remove(self.modifier_thinker)
    end
    if self.modifier_thinker_friendly and not self.modifier_thinker_friendly:IsNull() then
        UTIL_Remove(self.modifier_thinker_friendly)
    end
end

modifier_warlock_upheaval_custom = class({})
function modifier_warlock_upheaval_custom:IsPurgable() return false end
function modifier_warlock_upheaval_custom:IsPurgeException() return false end
function modifier_warlock_upheaval_custom:IsHidden() return false end
function modifier_warlock_upheaval_custom:IsAura() return true end
function modifier_warlock_upheaval_custom:IsAuraActiveOnDeath() return false end
function modifier_warlock_upheaval_custom:GetAuraRadius() return self.radius end
function modifier_warlock_upheaval_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_warlock_upheaval_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_warlock_upheaval_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_warlock_upheaval_custom:GetModifierAura()	return "modifier_warlock_upheaval_custom_thinker_debuff" end
function modifier_warlock_upheaval_custom:GetAuraDuration() return 0 end
function modifier_warlock_upheaval_custom:OnCreated(params)
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("aoe")
    if self:GetParent() == self:GetCaster() or params.is_move then
        local particle = ParticleManager:CreateParticle("particles/warlock_custom_fx/warlock_upheaval.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
        self:AddParticle(particle, false, false, -1, false, false)
    else
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_upheaval.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
        self:AddParticle(particle, false, false, -1, false, false)
    end
    self.modifier_warlock_15_timer = 0
    self:StartIntervalThink(0.5)
    self:GetParent():EmitSound("Hero_Warlock.Upheaval")
end
function modifier_warlock_upheaval_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_warlock_15") then
        self.modifier_warlock_15_timer = self.modifier_warlock_15_timer + 0.5
        if self.modifier_warlock_15_timer >= self:GetAbility().modifier_warlock_15 then
            self.modifier_warlock_15_timer = 0
            local warlock_eldritch_summoning_custom = self:GetCaster():FindAbilityByName("warlock_eldritch_summoning_custom")
            if warlock_eldritch_summoning_custom then
                warlock_eldritch_summoning_custom:SpawnImp(self:GetParent():GetAbsOrigin())
            end
        end
    end
end

function modifier_warlock_upheaval_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Hero_Warlock.Upheaval")
    self:GetParent():EmitSound("Hero_Warlock.Upheaval.Stop")
end

modifier_warlock_upheaval_custom_thinker_debuff = class({})
function modifier_warlock_upheaval_custom_thinker_debuff:IsPurgable() return false end
function modifier_warlock_upheaval_custom_thinker_debuff:IsPurgeException() return false end
function modifier_warlock_upheaval_custom_thinker_debuff:IsHidden() return true end
function modifier_warlock_upheaval_custom_thinker_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_warlock_upheaval_custom_thinker_debuff:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_warlock_upheaval_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("duration")})
end

modifier_warlock_upheaval_custom_debuff = class({})
function modifier_warlock_upheaval_custom_debuff:OnCreated()
    if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage_per_second")
    self.max_damage = self:GetAbility():GetSpecialValueFor("max_damage")
    if self:GetCaster():HasModifier("modifier_warlock_18") then
        local regeneration_sum = self:GetCaster():GetManaRegen() + self:GetCaster():GetHealthRegen()
        self.max_damage = self.max_damage + (regeneration_sum / 100 * self:GetAbility().modifier_warlock_18[self:GetCaster():GetTalentLevel("modifier_warlock_18")])
    end
    self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
    local damage_tick_interval = self:GetAbility():GetSpecialValueFor("damage_tick_interval")
    self.slow = 0
    self.slow_per_second = self:GetAbility():GetSpecialValueFor("slow_per_second")
    self.max_slow = self:GetAbility():GetSpecialValueFor("max_slow")
    if self:GetCaster():HasModifier("modifier_warlock_20") then
        self.damage = self.max_damage
        self.slow = self.max_slow
    end
    self.damage_interval = 0
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(FrameTime())
end
function modifier_warlock_upheaval_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_warlock_upheaval_custom_thinker_debuff") then
        self.damage_interval = self.damage_interval + FrameTime()
        if self.damage_interval >= 1 then
            ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
            self.damage = math.min(self.damage + self.damage_per_second, self.max_damage)
            self.damage_interval = 0
        end
        self.slow = math.min((self.slow + (self.slow_per_second * FrameTime())), self.max_slow)
        self:SendBuffRefreshToClients()
    end
end
function modifier_warlock_upheaval_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_warlock_upheaval_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_warlock/warlock_upheaval_debuff.vpcf"
end
function modifier_warlock_upheaval_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_warlock_upheaval_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return -self.slow
end
function modifier_warlock_upheaval_custom_debuff:AddCustomTransmitterData() 
    return 
    {
        slow = self.slow,
    }
end
function modifier_warlock_upheaval_custom_debuff:HandleCustomTransmitterData(data)
    self.slow = data.slow
end

modifier_warlock_upheaval_custom_handler = class({})
function modifier_warlock_upheaval_custom_handler:IsPurgable() return false end
function modifier_warlock_upheaval_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_warlock_20") end
function modifier_warlock_upheaval_custom_handler:IsPurgeException() return false end
function modifier_warlock_upheaval_custom_handler:RemoveOnDeath() return false end
function modifier_warlock_upheaval_custom_handler:GetTexture() return "warlock_20" end
function modifier_warlock_upheaval_custom_handler:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(self:GetAbility().modifier_warlock_20[1])
end
function modifier_warlock_upheaval_custom_handler:DeclareFunctions()
    return
    {
         
    }
end
function modifier_warlock_upheaval_custom_handler:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.ability:IsItem() then return end
    if params.ability:IsToggle() then return end
    if not self:GetParent():HasModifier("modifier_warlock_20") then return end
    self:DecrementStackCount()
    print(params.ability:GetAbilityName())
    if self:GetStackCount() <= 0 then
        self:SetStackCount(self:GetAbility().modifier_warlock_20[self:GetCaster():GetTalentLevel("modifier_warlock_20")])
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_warlock_upheaval_custom", {duration = self:GetAbility().modifier_warlock_20_duration}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        if self:GetCaster():HasModifier("modifier_warlock_17") then
            CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_warlock_upheaval_custom_thinker_buffs", {duration = self:GetAbility().modifier_warlock_20_duration}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        end
    end
end

modifier_warlock_upheaval_custom_thinker_buffs = class({})
function modifier_warlock_upheaval_custom_thinker_buffs:IsPurgable() return false end
function modifier_warlock_upheaval_custom_thinker_buffs:IsPurgeException() return false end
function modifier_warlock_upheaval_custom_thinker_buffs:IsHidden() return false end
function modifier_warlock_upheaval_custom_thinker_buffs:IsAura() return true end
function modifier_warlock_upheaval_custom_thinker_buffs:IsAuraActiveOnDeath() return false end
function modifier_warlock_upheaval_custom_thinker_buffs:GetAuraRadius() return self.radius end
function modifier_warlock_upheaval_custom_thinker_buffs:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_warlock_upheaval_custom_thinker_buffs:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_warlock_upheaval_custom_thinker_buffs:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_warlock_upheaval_custom_thinker_buffs:GetModifierAura()	return "modifier_warlock_upheaval_custom_buff" end
function modifier_warlock_upheaval_custom_thinker_buffs:GetAuraDuration() return 0 end
function modifier_warlock_upheaval_custom_thinker_buffs:OnCreated(params)
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("aoe")
end

modifier_warlock_upheaval_custom_buff = class({})

function modifier_warlock_upheaval_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }
end

function modifier_warlock_upheaval_custom_buff:GetModifierConstantManaRegen()
    return self:GetAbility().modifier_warlock_17[self:GetCaster():GetTalentLevel("modifier_warlock_17")]
end

function modifier_warlock_upheaval_custom_buff:GetModifierConstantHealthRegen()
    return self:GetAbility().modifier_warlock_17[self:GetCaster():GetTalentLevel("modifier_warlock_17")]
end