--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_21=class({})

function modifier_arc_warden_21:IsHidden() return true end
function modifier_arc_warden_21:IsPurgable() return false end
function modifier_arc_warden_21:IsPurgeException() return false end
function modifier_arc_warden_21:RemoveOnDeath() return false end

function modifier_arc_warden_21:OnCreated()
    self.bonus={7}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(0.1)
    local item_hero_roshan_cheese = CreateItem("item_hero_roshan_cheese", self:GetCaster(), self:GetCaster())
    if item_hero_roshan_cheese then
        self:GetCaster():AddItem(item_hero_roshan_cheese)
        item_hero_roshan_cheese:SetPurchaseTime(0)
        item_hero_roshan_cheese:SetSellable(false)
        Timers:CreateTimer(FrameTime(), function()
            item_hero_roshan_cheese:SetPurchaseTime(0)
            if item_hero_roshan_cheese:GetPurchaseTime() <= 0 then
                item_hero_roshan_cheese:SetSellable(true)
                return
            end
            return FrameTime()
        end)
    end
end

function modifier_arc_warden_21:OnRefresh()
    self.bonus={7}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_21:OnIntervalThink()
    if not IsServer() then return end
    self.Intellect = 0
    self.Intellect = self:GetParent():GetIntellect(false) / 100 * self.bonus[self:GetStackCount()]
    self:GetParent():CalculateStatBonus(true)
end

function modifier_arc_warden_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
end

function modifier_arc_warden_21:GetModifierBonusStats_Intellect()
    return self.Intellect
end