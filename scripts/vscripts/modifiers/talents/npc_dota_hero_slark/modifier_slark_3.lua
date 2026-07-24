--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slark_3_fx", "modifiers/talents/npc_dota_hero_slark/modifier_slark_3", LUA_MODIFIER_MOTION_NONE)

modifier_slark_3=class({})

function modifier_slark_3:IsHidden() return true end
function modifier_slark_3:IsPurgable() return false end
function modifier_slark_3:IsPurgeException() return false end
function modifier_slark_3:RemoveOnDeath() return false end

function modifier_slark_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_slark_3_fx", {})
end

function modifier_slark_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_slark_3_fx = class({})
function modifier_slark_3_fx:GetTexture() return "slark_3" end
function modifier_slark_3_fx:IsPurgable() return false end
function modifier_slark_3_fx:IsPurgeException() return false end
function modifier_slark_3_fx:RemoveOnDeath() return false end
function modifier_slark_3_fx:OnCreated()
    if not IsServer() then return end
    local modifier_slark_essence_shift_custom = self:GetParent():FindModifierByName("modifier_slark_essence_shift_custom")
    if modifier_slark_essence_shift_custom then
        self:SetStackCount(modifier_slark_essence_shift_custom:GetStackCount())
    end
end
function modifier_slark_3_fx:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOOLTIP
    }
end
function modifier_slark_3_fx:OnTooltip()
    return self:GetStackCount()
end