--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_orb_effect_lua", "modifiers/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_huskar_burning_spear_custom_debuff", "heroes/npc_dota_hero_huskar_custom/huskar_burning_spear_custom", LUA_MODIFIER_MOTION_NONE)

huskar_burning_spear_custom = class({})

huskar_burning_spear_custom.modifier_huskar_4 = {4,3,2}
huskar_burning_spear_custom.modifier_huskar_19 = {-1,-1.5,-2}
huskar_burning_spear_custom.modifier_huskar_20 = 300
huskar_burning_spear_custom.modifier_huskar_16_max = 7
huskar_burning_spear_custom.modifier_huskar_16 = 300
huskar_burning_spear_custom.modifier_huskar_16_damage = {5,10,15}

function huskar_burning_spear_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_huskar.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_huskar.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_huskar.vpcf", context)
end

function huskar_burning_spear_custom:GetCastRange(vLocation, hTarget)
    return self:GetCaster():Script_GetAttackRange() + 50
end

function huskar_burning_spear_custom:GetHealthCost(level)
    if IsServer() then return end
    if self:GetCaster():HasModifier("modifier_huskar_15") then return end
    return (self:GetSpecialValueFor("health_cost")*self:GetCaster():GetMaxHealth()/100) * (1 - self:GetCaster():Script_GetMagicalArmorValue(self))
end 

function huskar_burning_spear_custom:GetManaCost(level)
    if IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_huskar_15") then return end
    return (self:GetSpecialValueFor("health_cost")*self:GetCaster():GetMaxMana()/100)
end

function huskar_burning_spear_custom:GetIntrinsicModifierName()
    return "modifier_generic_orb_effect_lua"
end

function huskar_burning_spear_custom:GetProjectileName()
    return "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf"
end

function huskar_burning_spear_custom:OnOrbFire()
    if self:GetCaster():HasModifier("modifier_huskar_10") then return end
    if self:GetCaster():HasModifier("modifier_huskar_14") then return end
    if self:GetCaster():IsSilenced() then return end
    local health_cost = self:GetSpecialValueFor("health_cost") / 100
    self:GetCaster():EmitSound("Hero_Huskar.Burning_Spear.Cast")
    if self:GetCaster():HasModifier("modifier_huskar_15") then
        self:GetCaster():SpendMana(health_cost*self:GetCaster():GetMaxMana(), self)
    else
        local damage = (self:GetCaster():GetMaxHealth() * health_cost)
        damage = damage * (1 - self:GetCaster():Script_GetMagicalArmorValue(self))
        self:GetCaster():SetHealth(math.max(self:GetCaster():GetHealth() - damage, 1))
    end
end

function huskar_burning_spear_custom:OnOrbImpact( params )
    if self:GetCaster():HasModifier("modifier_huskar_10") then return end
    if self:GetCaster():HasModifier("modifier_huskar_14") then return end
    self:AttackTarget(params.target)
    if self:GetCaster():HasModifier("modifier_huskar_16") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.target:GetAbsOrigin(), nil, self.modifier_huskar_16, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _, unit in pairs(units) do
            if unit and unit ~= params.target then
                self:AttackTarget(unit)
                break
            end
        end
    end
end

function huskar_burning_spear_custom:AttackTarget(target)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_huskar_10") then return end
    if self:GetCaster():HasModifier("modifier_huskar_14") then return end
    local duration = self:GetSpecialValueFor("duration")
    target:EmitSound("Hero_Huskar.Burning_Spear")
    target:AddNewModifier(self:GetCaster(), self, "modifier_huskar_burning_spear_custom_debuff", { duration = duration * (1-target:GetStatusResistance()) })
end

modifier_huskar_burning_spear_custom_debuff = class({})

function modifier_huskar_burning_spear_custom_debuff:IsPurgable() return not self:GetCaster():HasModifier("modifier_huskar_20") end

function modifier_huskar_burning_spear_custom_debuff:OnCreated()
    if not IsServer() then return end
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    self.burn_damage_max_pct = self:GetAbility():GetSpecialValueFor("burn_damage_max_pct")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:AddStack(1)
    self.burn_tick = 0
    self:StartIntervalThink(FrameTime())
end

function modifier_huskar_burning_spear_custom_debuff:OnRefresh()
    if not IsServer() then return end
    self:AddStack(1)
end

function modifier_huskar_burning_spear_custom_debuff:AddStack(count)
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_huskar_16") then
        self:SetStackCount(self:GetStackCount() + count)
        Timers:CreateTimer(self.duration, function()
            if self and not self:IsNull() then
                if self:GetCaster():HasModifier("modifier_huskar_16") then return end
                self:SetStackCount(self:GetStackCount() - count)
                if self:GetStackCount() <= 0 then
                    self:Destroy()
                end
            end
        end)
    else
        self:SetStackCount(math.min(self:GetStackCount() + count, self:GetAbility().modifier_huskar_16_max))
    end
end

function modifier_huskar_burning_spear_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_huskar_20") then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility().modifier_huskar_20, FrameTime(), true)
    end
    self.burn_tick = self.burn_tick + FrameTime()
    if self.burn_tick >= 1 then
        local burn_damage = self:GetAbility():GetSpecialValueFor("burn_damage") + (self:GetParent():GetMaxHealth() / 100 * self.burn_damage_max_pct)
        if self:GetCaster():HasModifier("modifier_huskar_16") then
            burn_damage = burn_damage + self:GetAbility().modifier_huskar_16_damage[self:GetCaster():GetTalentLevel("modifier_huskar_16")]
        end
        ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL, damage = burn_damage * self:GetStackCount()})
        self.burn_tick = 0
    end
end

function modifier_huskar_burning_spear_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_huskar_burning_spear_custom_debuff:GetModifierMagicalResistanceBonus()
    if self:GetCaster():HasModifier("modifier_huskar_19") then
        return self:GetAbility().modifier_huskar_19[self:GetCaster():GetTalentLevel("modifier_huskar_19")] * self:GetStackCount()
    end
end

function modifier_huskar_burning_spear_custom_debuff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Hero_Huskar.Burning_Spear")
end