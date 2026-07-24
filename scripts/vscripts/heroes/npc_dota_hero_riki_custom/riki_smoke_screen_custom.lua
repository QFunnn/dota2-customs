--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_smoke_screen_custom", "heroes/npc_dota_hero_riki_custom/riki_smoke_screen_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_smoke_screen_custom_debuff", "heroes/npc_dota_hero_riki_custom/riki_smoke_screen_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_smoke_screen_custom_buff_aura", "heroes/npc_dota_hero_riki_custom/riki_smoke_screen_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_smoke_screen_custom_buff", "heroes/npc_dota_hero_riki_custom/riki_smoke_screen_custom", LUA_MODIFIER_MOTION_NONE)

riki_smoke_screen_custom = class({})
riki_smoke_screen_custom.modifier_riki_11 = {8,16}
riki_smoke_screen_custom.modifier_riki_10 = {-3,-6}
riki_smoke_screen_custom.modifier_riki_15_damage = 40
riki_smoke_screen_custom.modifier_riki_15_manacost = 20
riki_smoke_screen_custom.modifier_riki_17_damage = {40,60,80}
riki_smoke_screen_custom.modifier_riki_17_radius = {40,60,80}
riki_smoke_screen_custom.modifier_riki_19_resistance = {-5,-10,-15}
riki_smoke_screen_custom.modifier_riki_19_duration = {0.5,1,1.5}

function riki_smoke_screen_custom:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_riki/riki_smokebomb.vpcf", context)
    PrecacheResource("particle", "particles/generic_gameplay/generic_silenced.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_riki.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_riki.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_riki.vpcf", context)
end

function riki_smoke_screen_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_riki_15") then
        return "riki_15"
    end
    return "riki_smoke_screen"
end

function riki_smoke_screen_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function riki_smoke_screen_custom:GetCastRange(location, target)
    return self.BaseClass.GetCastRange(self, location, target)
end

function riki_smoke_screen_custom:GetManaCost(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_riki_15") then
        bonus = self.BaseClass.GetManaCost(self, level) / 100 * self.modifier_riki_15_manacost
    end
    return self.BaseClass.GetManaCost(self, level) - bonus
end

function riki_smoke_screen_custom:GetAOERadius()
    local radius = self:GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_riki_17") then
        radius = radius + self.modifier_riki_17_radius[self:GetCaster():GetTalentLevel("modifier_riki_17")]
    end
    return radius
end

function riki_smoke_screen_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    CreateModifierThinker(caster, self, "modifier_riki_smoke_screen_custom", {duration = duration}, point, caster:GetTeamNumber(), false)
    if self:GetCaster():HasModifier("modifier_riki_11") then
        CreateModifierThinker(caster, self, "modifier_riki_smoke_screen_custom_buff_aura", {duration = duration}, point, caster:GetTeamNumber(), false)
    end
end

modifier_riki_smoke_screen_custom = class({})
function modifier_riki_smoke_screen_custom:IsPurgable() return false end
function modifier_riki_smoke_screen_custom:IsHidden() return true end
function modifier_riki_smoke_screen_custom:IsAura() return true end

function modifier_riki_smoke_screen_custom:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_riki_17") then
        self.radius = self.radius + self:GetAbility().modifier_riki_17_radius[self:GetCaster():GetTalentLevel("modifier_riki_17")]
    end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_smokebomb.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self.radius, self.radius))
    self:AddParticle(self.particle, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_Riki.Smoke_Screen")
end

function modifier_riki_smoke_screen_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_riki_smoke_screen_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_riki_smoke_screen_custom:GetModifierAura()
    return "modifier_riki_smoke_screen_custom_debuff"
end

function modifier_riki_smoke_screen_custom:GetAuraRadius()
    return self.radius
end

function modifier_riki_smoke_screen_custom:GetAuraDuration()
    if self:GetCaster():HasModifier("modifier_riki_19") then
        return self:GetAbility().modifier_riki_19_duration[self:GetCaster():GetTalentLevel("modifier_riki_19")]
    end
    return 0 
end

modifier_riki_smoke_screen_custom_debuff = class({})
function modifier_riki_smoke_screen_custom_debuff:IsDebuff() return true end

function modifier_riki_smoke_screen_custom_debuff:OnCreated()
    self.miss_rate = self:GetAbility():GetSpecialValueFor("miss_rate")
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_riki_15") then
        self:StartIntervalThink(0.5)
    end
end

function modifier_riki_smoke_screen_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetAbility().modifier_riki_15_damage
    if self:GetCaster():HasModifier("modifier_riki_17") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_riki_17_damage[self:GetCaster():GetTalentLevel("modifier_riki_17")])
    end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_riki_smoke_screen_custom_debuff:GetEffectName()
    return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_riki_smoke_screen_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW 
end

function modifier_riki_smoke_screen_custom_debuff:CheckState()
    return
    { 
        [MODIFIER_STATE_SILENCED] = true
    }
end

function modifier_riki_smoke_screen_custom_debuff:DeclareFunctions()
    return
    { 
        MODIFIER_PROPERTY_MISS_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    }
end

function modifier_riki_smoke_screen_custom_debuff:GetModifierMiss_Percentage()
    return self.miss_rate
end

function modifier_riki_smoke_screen_custom_debuff:GetModifierPhysicalArmorBonus()
    if self:GetCaster():HasModifier("modifier_riki_10") then
        return self:GetAbility().modifier_riki_10[self:GetCaster():GetTalentLevel("modifier_riki_10")]
    end
end

function modifier_riki_smoke_screen_custom_debuff:GetModifierMagicalResistanceBonus()
    if self:GetCaster():HasModifier("modifier_riki_19") then
        return self:GetAbility().modifier_riki_19_resistance[self:GetCaster():GetTalentLevel("modifier_riki_19")]
    end
end

modifier_riki_smoke_screen_custom_buff_aura = class({})
function modifier_riki_smoke_screen_custom_buff_aura:IsPurgable() return false end
function modifier_riki_smoke_screen_custom_buff_aura:IsHidden() return true end
function modifier_riki_smoke_screen_custom_buff_aura:IsAura() return true end

function modifier_riki_smoke_screen_custom_buff_aura:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_riki_17") then
        self.radius = self.radius + self:GetAbility().modifier_riki_17_radius[self:GetCaster():GetTalentLevel("modifier_riki_17")]
    end
end

function modifier_riki_smoke_screen_custom_buff_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_riki_smoke_screen_custom_buff_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_riki_smoke_screen_custom_buff_aura:GetModifierAura()
    return "modifier_riki_smoke_screen_custom_buff"
end

function modifier_riki_smoke_screen_custom_buff_aura:GetAuraRadius()
    return self.radius
end

function modifier_riki_smoke_screen_custom_buff_aura:GetAuraDuration() 
    return 0 
end

modifier_riki_smoke_screen_custom_buff = class({})
function modifier_riki_smoke_screen_custom_buff:IsPurgable() return false end
function modifier_riki_smoke_screen_custom_buff:IsDebuff() return false end

function modifier_riki_smoke_screen_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_riki_smoke_screen_custom_buff:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target = self:GetParent()
        if kv.damage > 0 and RollPercentage(self:GetAbility().modifier_riki_11[self:GetCaster():GetTalentLevel("modifier_riki_11")]) then
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:ReleaseParticleIndex(particle)
            return kv.damage
        end
    end
end