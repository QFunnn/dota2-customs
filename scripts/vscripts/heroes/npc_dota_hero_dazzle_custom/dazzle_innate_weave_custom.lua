--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_innate_weave_custom_armor_buff", "heroes/npc_dota_hero_dazzle_custom/dazzle_innate_weave_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_innate_weave_custom_armor_debuff", "heroes/npc_dota_hero_dazzle_custom/dazzle_innate_weave_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_innate_weave_custom_armor_buff_counter", "heroes/npc_dota_hero_dazzle_custom/dazzle_innate_weave_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_innate_weave_custom_armor_debuff_counter", "heroes/npc_dota_hero_dazzle_custom/dazzle_innate_weave_custom", LUA_MODIFIER_MOTION_NONE)

dazzle_innate_weave_custom = class({})

function dazzle_innate_weave_custom:TargetModifier(target)
    if not IsServer() then return end
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        local modifier_dazzle_innate_weave_custom_armor_buff = target:AddNewModifier(self:GetCaster(), self, "modifier_dazzle_innate_weave_custom_armor_buff", {duration = self:GetSpecialValueFor("duration")})
    else
        local modifier_dazzle_innate_weave_custom_armor_debuff = target:AddNewModifier(self:GetCaster(), self, "modifier_dazzle_innate_weave_custom_armor_debuff", {duration = self:GetSpecialValueFor("duration") * (1-target:GetStatusResistance())})
    end
end

modifier_dazzle_innate_weave_custom_armor_buff = class({})

function modifier_dazzle_innate_weave_custom_armor_buff:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_dazzle_innate_weave_custom_armor_buff_counter", {duration = self:GetAbility():GetSpecialValueFor("duration")})
    self:StartIntervalThink(FrameTime())
end

function modifier_dazzle_innate_weave_custom_armor_buff:OnRefresh()
    if not IsServer() then return end
    self:OnCreated()
end

function modifier_dazzle_innate_weave_custom_armor_buff:OnIntervalThink()
    if not IsServer() then return end
    self:SetStackCount(#self:GetParent():FindAllModifiersByName("modifier_dazzle_innate_weave_custom_armor_buff_counter"))
end

function modifier_dazzle_innate_weave_custom_armor_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_dazzle_innate_weave_custom_armor_buff:GetModifierPhysicalArmorBonus()
    return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("armor_change")
end

modifier_dazzle_innate_weave_custom_armor_debuff = class({})

function modifier_dazzle_innate_weave_custom_armor_debuff:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_dazzle_innate_weave_custom_armor_debuff_counter", {duration = self:GetDuration()})
    self:StartIntervalThink(FrameTime())
end

function modifier_dazzle_innate_weave_custom_armor_debuff:OnRefresh()
    if not IsServer() then return end
    self:OnCreated()
end

function modifier_dazzle_innate_weave_custom_armor_debuff:OnIntervalThink()
    if not IsServer() then return end
    self:SetStackCount(#self:GetParent():FindAllModifiersByName("modifier_dazzle_innate_weave_custom_armor_debuff_counter"))
end

function modifier_dazzle_innate_weave_custom_armor_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_dazzle_innate_weave_custom_armor_debuff:GetModifierPhysicalArmorBonus()
    return self:GetStackCount() * (self:GetAbility():GetSpecialValueFor("armor_change") * -1)
end

modifier_dazzle_innate_weave_custom_armor_buff_counter = class({})
function modifier_dazzle_innate_weave_custom_armor_buff_counter:IsHidden() return true end
function modifier_dazzle_innate_weave_custom_armor_buff_counter:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_dazzle_innate_weave_custom_armor_debuff_counter = class({})
function modifier_dazzle_innate_weave_custom_armor_debuff_counter:IsHidden() return true end
function modifier_dazzle_innate_weave_custom_armor_debuff_counter:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end