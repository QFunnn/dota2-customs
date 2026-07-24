--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lone_druid_4=class({})

function modifier_lone_druid_4:IsHidden() return true end
function modifier_lone_druid_4:IsPurgable() return false end
function modifier_lone_druid_4:IsPurgeException() return false end
function modifier_lone_druid_4:RemoveOnDeath() return false end

function modifier_lone_druid_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("lone_druid_spirit_link_custom", "lone_druid_unity_with_nature", false, true)
	local ability = self:GetParent():FindAbilityByName("lone_druid_unity_with_nature")
	if ability then
		ability:SetLevel(1)
		ability:SetHidden(false)
	end
    local lone_druid_spirit_link_custom = self:GetCaster():FindAbilityByName("lone_druid_spirit_link_custom")
    if lone_druid_spirit_link_custom then
        lone_druid_spirit_link_custom:SetHidden(false)
    end
end

function modifier_lone_druid_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local ability = self:GetParent():FindAbilityByName("lone_druid_unity_with_nature")
	if ability then
		ability:SetLevel(1)
		ability:SetHidden(false)
	end
end