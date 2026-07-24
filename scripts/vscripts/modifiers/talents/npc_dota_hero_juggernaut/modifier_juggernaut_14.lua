--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_juggernaut_14=class({})

function modifier_juggernaut_14:IsHidden() return true end
function modifier_juggernaut_14:IsPurgable() return false end
function modifier_juggernaut_14:IsPurgeException() return false end
function modifier_juggernaut_14:RemoveOnDeath() return false end

function modifier_juggernaut_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local juggernaut_swift_slash_custom = self:GetCaster():FindAbilityByName("juggernaut_swift_slash_custom")
	if juggernaut_swift_slash_custom then
		juggernaut_swift_slash_custom:SetLevel(1)
		juggernaut_swift_slash_custom:SetHidden(false)
	end
    local juggernaut_blade_fury_custom = self:GetCaster():FindAbilityByName("juggernaut_blade_fury_custom")
    if juggernaut_blade_fury_custom then
        juggernaut_blade_fury_custom:SetHidden(true)
        juggernaut_blade_fury_custom:SetActivated(false)
    end
end

function modifier_juggernaut_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end