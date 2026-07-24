--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_meepo_14_debuff", "modifiers/talents/npc_dota_hero_meepo/modifier_meepo_14", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_14_debuff_stack", "modifiers/talents/npc_dota_hero_meepo/modifier_meepo_14", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_14_buff", "modifiers/talents/npc_dota_hero_meepo/modifier_meepo_14", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_14_buff_stack", "modifiers/talents/npc_dota_hero_meepo/modifier_meepo_14", LUA_MODIFIER_MOTION_NONE)

modifier_meepo_14=class({})

function modifier_meepo_14:IsHidden() return true end
function modifier_meepo_14:IsPurgable() return false end
function modifier_meepo_14:IsPurgeException() return false end
function modifier_meepo_14:RemoveOnDeath() return false end

function modifier_meepo_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_meepo_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_meepo_14:DeclareFunctions() 
    return 
    {
         
    } 
end

function modifier_meepo_14:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    params.target:AddNewModifier(self:GetCaster(), nil, "modifier_meepo_14_debuff_stack", {duration = 3}) 
    params.target:AddNewModifier(self:GetCaster(), nil, "modifier_meepo_14_debuff", {duration = 3}) 
    self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_meepo_14_buff_stack", {duration = 3}) 
    self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_meepo_14_buff", {duration = 3}) 
end

modifier_meepo_14_debuff = class({})
function modifier_meepo_14_debuff:GetTexture() return "meepo_14" end
function modifier_meepo_14_debuff:IsPurgable() return false end
function modifier_meepo_14_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_meepo_14_debuff:OnIntervalThink()
    if not IsServer() then return end
    local mod = self:GetParent():FindAllModifiersByName("modifier_meepo_14_debuff_stack")
    self:SetStackCount(#mod)
end
function modifier_meepo_14_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end
function modifier_meepo_14_debuff:GetModifierAttackSpeedBonus_Constant()
    return self:GetStackCount() * -5
end
function modifier_meepo_14_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetStackCount() * -2.5
end

modifier_meepo_14_debuff_stack = class({})
function modifier_meepo_14_debuff_stack:IsPurgable() return false end
function modifier_meepo_14_debuff_stack:IsHidden() return true end
function modifier_meepo_14_debuff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_meepo_14_debuff_stack:IsPurgeException() return false end

modifier_meepo_14_buff = class({})
function modifier_meepo_14_buff:GetTexture() return "meepo_14" end
function modifier_meepo_14_buff:IsPurgable() return false end
function modifier_meepo_14_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_meepo_14_buff:OnIntervalThink()
    if not IsServer() then return end
    local mod = self:GetParent():FindAllModifiersByName("modifier_meepo_14_buff_stack")
    self:SetStackCount(#mod)
end
function modifier_meepo_14_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end
function modifier_meepo_14_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetStackCount() * 5
end
function modifier_meepo_14_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetStackCount() * 2.5
end

modifier_meepo_14_buff_stack = class({})
function modifier_meepo_14_buff_stack:IsPurgable() return false end
function modifier_meepo_14_buff_stack:IsHidden() return true end
function modifier_meepo_14_buff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_meepo_14_buff_stack:IsPurgeException() return false end