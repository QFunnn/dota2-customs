--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_monkey_king_jingu_magic_custom_hit", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_jingu_magic_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_jingu_magic_custom_buff", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_jingu_magic_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_jingu_magic_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_jingu_magic_custom", LUA_MODIFIER_MOTION_NONE)

monkey_king_jingu_magic_custom = class({})
monkey_king_jingu_magic_custom.modifier_monkey_king_2_lifesteal = {5,10}
monkey_king_jingu_magic_custom.modifier_monkey_king_2_damage = {5,10}

function monkey_king_jingu_magic_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack_magical.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_overhead_magical.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_start_magical.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_tap_buff_magical.vpcf", context )
end

function monkey_king_jingu_magic_custom:GetIntrinsicModifierName()
    return "modifier_monkey_king_jingu_magic_custom"
end

modifier_monkey_king_jingu_magic_custom = class({})
function modifier_monkey_king_jingu_magic_custom:IsHidden() return true end
function modifier_monkey_king_jingu_magic_custom:IsPurgable() return false end
function modifier_monkey_king_jingu_magic_custom:IsPurgeException() return false end
function modifier_monkey_king_jingu_magic_custom:RemoveOnDeath() return false end

function modifier_monkey_king_jingu_magic_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.duration_debuff = self.ability:GetSpecialValueFor("duration")
    if not IsServer() then return end
    self.exceptions = 
    {
        ["item_clarity"] = true,
        ["item_enchanted_mango"] = true,
        ["item_bottle"] = true,
        ["item_smoke_of_deceit"] = true,
        ["item_flask"] = true,
        ["item_tango"] = true,
        ["item_faerie_fire"] = true,
        ["item_dust_custom"] = true,
        ["item_book_str"] = true,
        ["item_book_agi"] = true,
        ["item_book_int"] = true,
        ["item_power_treads"] = true,
        ["item_aghanims_treads"] = true,
        ["item_aghanims_shard_custom"] = true,
        ["item_health_radiance"] = true,
        ["item_mana_radiance"] = true,
        ["item_radiance_custom"] = true,
        ["item_spear_of_mordiggian"] = true,
        ["item_vambrace"] = true,
        ["item_ward_dispenser_custom"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_kaya"] = true,
        ["item_moon_yasha"] = true,
        ["item_moon_sange"] = true,
        ["item_moon_aghanim"] = true,
        ["item_moon_shard"] = true,      
        ["item_royale_with_cheese"] = true,  
        ["item_talant_book"] = true,
        ["monkey_king_untransform"] = true, 
    }
end

function modifier_monkey_king_jingu_magic_custom:OnRefresh()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.duration_debuff = self.ability:GetSpecialValueFor("duration")
    if not IsServer() then return end
end

function modifier_monkey_king_jingu_magic_custom:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self.parent then return end
    if self:GetParent():PassivesDisabled() then return end
    if self.exceptions[params.ability:GetAbilityName()] then return end
    local modifier_monkey_king_jingu_magic_custom_buff = self.parent:FindModifierByName("modifier_monkey_king_jingu_magic_custom_buff")
    if not modifier_monkey_king_jingu_magic_custom_buff then
        self:GetParent():AddNewModifier(self:GetParent(), self.ability, "modifier_monkey_king_jingu_magic_custom_hit", {})
    end
end

function modifier_monkey_king_jingu_magic_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
    }
end

function modifier_monkey_king_jingu_magic_custom:GetModifierProperty_MagicalLifesteal(params)
    local modifier_monkey_king_jingu_magic_custom_buff = self.parent:FindModifierByName("modifier_monkey_king_jingu_magic_custom_buff")
    if modifier_monkey_king_jingu_magic_custom_buff and modifier_monkey_king_jingu_magic_custom_buff:GetElapsedTime() > 0.1 then
        return modifier_monkey_king_jingu_magic_custom_buff.spell_lifesteal
    end
end

modifier_monkey_king_jingu_magic_custom_hit = class({})
function modifier_monkey_king_jingu_magic_custom_hit:IsPurgable() return false end
function modifier_monkey_king_jingu_magic_custom_hit:OnCreated(table)
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.max_stack = self.ability:GetSpecialValueFor("required_hits")
    self.duration_buff = self.ability:GetSpecialValueFor("duration")
    if not IsServer() then return end
    self:SetStackCount(1)
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack_magical.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 1, Vector(1, self:GetStackCount(), 1))
    self:AddParticle(self.particle, true, false, -1, false, false)
end

function modifier_monkey_king_jingu_magic_custom_hit:OnRefresh(table)
    if not IsServer() then return end
    self:IncrementStackCount()
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(1, self:GetStackCount(), 1))
    end
    if self:GetStackCount() >= self.max_stack then 
        self.caster:AddNewModifier(self.caster, self.ability, "modifier_monkey_king_jingu_magic_custom_buff", {duration = self.duration_buff})
        self:Destroy()
    end
end

modifier_monkey_king_jingu_magic_custom_buff = class({})
function modifier_monkey_king_jingu_magic_custom_buff:IsHidden() return false end

function modifier_monkey_king_jingu_magic_custom_buff:OnCreated(params)
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.spell_amplify = self.ability:GetSpecialValueFor("spell_amplify")
    self.spell_lifesteal = self.ability:GetSpecialValueFor("spell_lifesteal")
    if self:GetCaster():HasModifier("modifier_monkey_king_2") then
        self.spell_amplify = self.spell_amplify + self:GetAbility().modifier_monkey_king_2_damage[self:GetCaster():GetTalentLevel("modifier_monkey_king_2")]
        self.spell_lifesteal = self.spell_lifesteal + self:GetAbility().modifier_monkey_king_2_lifesteal[self:GetCaster():GetTalentLevel("modifier_monkey_king_2")]
    end
    if not IsServer() then return end
    local startPfx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_start_magical.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(startPfx, 0, self.parent:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(startPfx)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_tap_buff_magical.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_top", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_top", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_weapon_bot", self.parent:GetAbsOrigin(), true)
    self:AddParticle(particle,true,false,0,false,false)
    self.parent:EmitSound("Hero_MonkeyKing.IronCudgel")
    self:StartIntervalThink(0.2)
end

function modifier_monkey_king_jingu_magic_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    if not self.ability or not self.ability:GetIntrinsicModifierName() or not self.caster:HasModifier(self.ability:GetIntrinsicModifierName()) then
        self:Destroy()
    end
end

function modifier_monkey_king_jingu_magic_custom_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_monkey_king_jingu_magic_custom_buff:GetModifierSpellAmplify_Percentage()
    if self:GetElapsedTime() <= 0.1 then return end
    return self.spell_amplify
end

function modifier_monkey_king_jingu_magic_custom_buff:GetEffectName()
    return "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_overhead_magical.vpcf"
end

function modifier_monkey_king_jingu_magic_custom_buff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end