--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_3=class({})

function modifier_undying_3:IsHidden() return true end
function modifier_undying_3:IsPurgable() return false end
function modifier_undying_3:IsPurgeException() return false end
function modifier_undying_3:RemoveOnDeath() return false end

function modifier_undying_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local undying_hypnodancer_custom = self:GetCaster():FindAbilityByName("undying_hypnodancer_custom")
    if undying_hypnodancer_custom then
        undying_hypnodancer_custom:SetLevel(1)
        if self:GetCaster():HasModifier("modifier_undying_10") then
            self:GetCaster():SwapAbilities("undying_tombstone_body", "undying_hypnodancer_custom", true, true)
        else
            self:GetCaster():SwapAbilities("undying_tombstone_custom", "undying_hypnodancer_custom", false, true)
        end
    end
    local undying_tombstone_custom = self:GetCaster():FindAbilityByName("undying_tombstone_custom")
    if undying_tombstone_custom then
        undying_tombstone_custom:SetActivated(false)
    end
    for k, v in pairs(Entities:FindAllInSphere(self:GetCaster():GetAbsOrigin(), 99999)) do
        if v:GetName() == "npc_dota_unit_undying_tombstone" and v:FindModifierByName("modifier_undying_tombstone_custom") then
            v:ForceKill(false)
        end
    end
end

function modifier_undying_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end