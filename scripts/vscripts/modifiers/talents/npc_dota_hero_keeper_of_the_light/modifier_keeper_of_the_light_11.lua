--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_11=class({})

function modifier_keeper_of_the_light_11:IsHidden() return true end
function modifier_keeper_of_the_light_11:IsPurgable() return false end
function modifier_keeper_of_the_light_11:IsPurgeException() return false end
function modifier_keeper_of_the_light_11:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local keeper_of_the_light_will_o_wisp_custom = self:GetCaster():FindAbilityByName("keeper_of_the_light_will_o_wisp_custom")
    if keeper_of_the_light_will_o_wisp_custom then
        keeper_of_the_light_will_o_wisp_custom:SetLevel(1)
        keeper_of_the_light_will_o_wisp_custom:SetHidden(false)
    end
end

function modifier_keeper_of_the_light_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end