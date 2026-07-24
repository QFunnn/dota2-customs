--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spirit_breaker_12_buff_visual", "modifiers/talents/npc_dota_hero_spirit_breaker/modifier_spirit_breaker_12", LUA_MODIFIER_MOTION_NONE)

modifier_spirit_breaker_12 = class({})

function modifier_spirit_breaker_12:IsHidden() return true end
function modifier_spirit_breaker_12:IsPurgable() return false end
function modifier_spirit_breaker_12:IsPurgeException() return false end
function modifier_spirit_breaker_12:RemoveOnDeath() return false end

function modifier_spirit_breaker_12:OnCreated()
    self.bonus_max = {10,20}
	if not IsServer() then return end
    self.speed = 0
    self.origin = self:GetParent():GetOrigin()
	self:SetStackCount(1)
    self:StartIntervalThink(0.3)
    self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_spirit_breaker_12_buff_visual", {})
    self:SetHasCustomTransmitterData(true)
end

function modifier_spirit_breaker_12:OnRefresh()
    self.bonus_max = {10,20}
	if not IsServer() then return end
    self:SendBuffRefreshToClients()
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_spirit_breaker_12:OnIntervalThink()
    if not IsServer() then return end
    local distance = (self.origin - self:GetParent():GetAbsOrigin()):Length2D()
    if distance <= 25 then
        self.speed = math.min(self.speed + 1, self.bonus_max[self:GetStackCount()])
    else
        self.speed = math.max(self.speed - 1, 0)
    end
    local modifier_spirit_breaker_12_buff_visual = self:GetCaster():FindModifierByName("modifier_spirit_breaker_12_buff_visual")
    if modifier_spirit_breaker_12_buff_visual then
        modifier_spirit_breaker_12_buff_visual:SetStackCount(self.speed)
    else
        modifier_spirit_breaker_12_buff_visual = self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_spirit_breaker_12_buff_visual", {})
        modifier_spirit_breaker_12_buff_visual:SetStackCount(self.speed)
    end
    self.origin = self:GetParent():GetAbsOrigin()
    self:SendBuffRefreshToClients()
end

function modifier_spirit_breaker_12:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_spirit_breaker_12:GetModifierMoveSpeedBonus_Constant()
    return self.speed * 15
end

function modifier_spirit_breaker_12:AddCustomTransmitterData()
    return 
    {
        speed = self.speed,
    }
end

function modifier_spirit_breaker_12:HandleCustomTransmitterData( data )
    self.speed = data.speed
end


modifier_spirit_breaker_12_buff_visual = class({})
function modifier_spirit_breaker_12_buff_visual:IsPurgable() return false end
function modifier_spirit_breaker_12_buff_visual:IsPurgeException() return false end
function modifier_spirit_breaker_12_buff_visual:RemoveOnDeath() return false end
function modifier_spirit_breaker_12_buff_visual:GetTexture() return "spirit_breaker_12" end