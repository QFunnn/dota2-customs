--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_11_debuff", "modifiers/talents/npc_dota_hero_phoenix/modifier_phoenix_11", LUA_MODIFIER_MOTION_NONE)

modifier_phoenix_11=class({})

function modifier_phoenix_11:IsHidden() return true end
function modifier_phoenix_11:IsPurgable() return false end
function modifier_phoenix_11:IsPurgeException() return false end
function modifier_phoenix_11:RemoveOnDeath() return false end

function modifier_phoenix_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_phoenix_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phoenix_11:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_MODIFIER_ADDED
    }
end

function modifier_phoenix_11:OnModifierAdded(params)
    local modifier = params.added_buff
    if modifier:GetCaster() ~= self:GetParent() then return end
    if modifier:GetAbility() == nil then return end
    if modifier:GetAbility():IsItem() then return end
    if params.unit:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not modifier:IsDebuff() then return end
    params.unit:AddNewModifier(self:GetCaster(), nil, "modifier_phoenix_11_debuff", {duration = 4})
end
 
modifier_phoenix_11_debuff = class({})

function modifier_phoenix_11_debuff:GetTexture()
    return "phoenix_11"
end

function modifier_phoenix_11_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
    self:IncrementStackCount()
end

function modifier_phoenix_11_debuff:OnIntervalThink()
    if not IsServer() then return end
    local new_stacks = 0
    for _, modifier in pairs(self:GetParent():FindAllModifiers()) do
        if modifier and modifier:GetCaster() == self:GetCaster() and modifier:GetAbility() and not modifier:GetAbility():IsItem() then
            new_stacks = new_stacks + 1
        end
    end
    if new_stacks == 0 then return end
    for i = 1, new_stacks do
        self:SetDuration(self:GetDuration(), true)
        self:IncrementStackCount()
    end
end

function modifier_phoenix_11_debuff:OnRefresh()
    if not IsServer() then return end
    self:IncrementStackCount()
end

function modifier_phoenix_11_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MISS_PERCENTAGE
    }
end

function modifier_phoenix_11_debuff:GetModifierMiss_Percentage()
    return self:GetStackCount()
end