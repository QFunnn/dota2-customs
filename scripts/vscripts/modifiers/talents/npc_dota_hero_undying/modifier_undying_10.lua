--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_10=class({})

function modifier_undying_10:IsHidden() return true end
function modifier_undying_10:IsPurgable() return false end
function modifier_undying_10:IsPurgeException() return false end
function modifier_undying_10:RemoveOnDeath() return false end

function modifier_undying_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)

    if self:GetCaster():HasModifier("modifier_undying_3") then
        local undying_tombstone_body = self:GetParent():FindAbilityByName("undying_tombstone_body")
        if undying_tombstone_body then
            undying_tombstone_body:SetHidden(false)
        end
    else
        self:Swap("undying_tombstone_custom", "undying_tombstone_body")
    end

	for k, v in pairs(Entities:FindAllInSphere(self:GetCaster():GetAbsOrigin(), 99999)) do
        if v:GetName() == "npc_dota_unit_undying_tombstone" and v:FindModifierByName("modifier_undying_tombstone_custom") then
            v:ForceKill(false)
        end
    end
    
    local undying_tombstone_body = self:GetParent():FindAbilityByName("undying_tombstone_body")
    if undying_tombstone_body then
    	undying_tombstone_body:SetLevel(self:GetStackCount())
    end
end

function modifier_undying_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local undying_tombstone_body = self:GetParent():FindAbilityByName("undying_tombstone_body")
    if undying_tombstone_body then
    	undying_tombstone_body:SetLevel(self:GetStackCount())
    end
end

function modifier_undying_10:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end