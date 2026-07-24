--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_unranked_penalty_1 = class(mod_visible)
function modifier_unranked_penalty_1:IsDebuff() return true end
function modifier_unranked_penalty_1:RemoveOnDeath() return false end
function modifier_unranked_penalty_1:GetTexture() return "buffs/generic/unranked_penalty" end
function modifier_unranked_penalty_1:OnCreated(table)
self.parent = self:GetParent()
self.damage = UNRANKED_DAMAGE_PENALTY
self.rating = UNRANKED_RATING_PENALTY
self.parent.damage_penalty = self.damage
end

function modifier_unranked_penalty_1:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP,
    MODIFIER_PROPERTY_TOOLTIP2
}
end

function modifier_unranked_penalty_1:OnTooltip()
return self.rating
end

function modifier_unranked_penalty_1:OnTooltip2()
return self.damage
end


modifier_unranked_penalty_2 = class(mod_visible)
function modifier_unranked_penalty_2:IsDebuff() return true end
function modifier_unranked_penalty_2:RemoveOnDeath() return false end
function modifier_unranked_penalty_2:GetTexture() return "buffs/generic/unranked_penalty" end
function modifier_unranked_penalty_2:OnCreated(table)
self.parent = self:GetParent()
self.damage = UNRANKED_DAMAGE_PENALTY
self.parent.damage_penalty = self.damage
end

function modifier_unranked_penalty_2:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP,
    MODIFIER_PROPERTY_TOOLTIP2
}
end

function modifier_unranked_penalty_2:OnTooltip()
return self.rating
end

function modifier_unranked_penalty_2:OnTooltip2()
return self.damage
end




modifier_unranked_penalty_3 = class(mod_visible)
function modifier_unranked_penalty_3:IsDebuff() return false end
function modifier_unranked_penalty_3:RemoveOnDeath() return false end
function modifier_unranked_penalty_3:GetTexture() return "buffs/generic/unranked_penalty" end
function modifier_unranked_penalty_3:OnCreated(table)
self.parent = self:GetParent()
self.damage = RANKED_DAMAGE_BONUS
self.start_interval = 10*60
self.interval = 10*60
self.diff = 5

if not IsServer() then return end
self:SetStackCount(self.damage)
self:StartIntervalThink(self.start_interval + self.interval)
end

function modifier_unranked_penalty_3:OnIntervalThink()
if not IsServer() then return end

self:SetStackCount(self:GetStackCount() - self.diff)
if self:GetStackCount() <= 0 then
    self:Destroy()
    return
end

self:StartIntervalThink(self.interval)
end

function modifier_unranked_penalty_3:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent.damage_penalty = self:GetStackCount()*-1
end

function modifier_unranked_penalty_3:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP,
}
end

function modifier_unranked_penalty_3:OnTooltip()
return self:GetStackCount()
end