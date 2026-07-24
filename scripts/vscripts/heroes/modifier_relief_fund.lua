--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if modifier_relief_fund == nil then
    modifier_relief_fund = class({})
end
function modifier_relief_fund:IsHidden()
    if self:GetStackCount() > 0 then
        return false
    else
        return true
    end
end
function modifier_relief_fund:IsDebuff()
    return false
end
function modifier_relief_fund:IsPurgable()
    return false
end
function modifier_relief_fund:IsPurgeException()
    return false
end
function modifier_relief_fund:RemoveOnDeath()
    return false
end
function modifier_relief_fund:OnCreated(kv)
    if IsServer() then
        self:StartIntervalThink(0)
    end
end
function modifier_relief_fund:OnRefresh(kv)
    if IsServer() then
    end
end
function modifier_relief_fund:GetTexture()
    return "kobold_tunneler_prospecting"
end
function modifier_relief_fund:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2
    }
end
function modifier_relief_fund:OnTooltip()
    return self:GetStackCount() * 8
end
function modifier_relief_fund:OnTooltip2()
    return self:GetStackCount()
end
function modifier_relief_fund:OnIntervalThink()
    local hParent = self:GetParent()
    local playerID = hParent:GetPlayerOwnerID() or -1
    local bValid = true
    if not IsValid(hParent) then
        bValid = false
        self:Destroy()
    else
        local hHero = PlayerResource:GetSelectedHeroEntity(playerID)
        if hHero ~= hParent then
            bValid = false
            self:Destroy()
        end
    end

    if (PlayerResource:GetConnectionState(playerID) == DOTA_CONNECTION_STATE_ABANDONED) then
        bValid = false
        self:Destroy()
    end

    if bValid then
        self:SetStackCount(#(GameRulesCustom.sEarlyLeavePlayerSteamIds))
    else
        self:SetStackCount(0)
    end
end