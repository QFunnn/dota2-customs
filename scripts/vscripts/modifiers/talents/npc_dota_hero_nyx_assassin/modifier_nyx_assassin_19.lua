--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nyx_assassin_19=class({})

function modifier_nyx_assassin_19:IsHidden() return true end
function modifier_nyx_assassin_19:IsPurgable() return false end
function modifier_nyx_assassin_19:IsPurgeException() return false end
function modifier_nyx_assassin_19:RemoveOnDeath() return false end

function modifier_nyx_assassin_19:OnCreated()
    self.mana = {8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_nyx_assassin_19:OnRefresh()
    self.mana = {8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_nyx_assassin_19:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_nyx_assassin_19:OnTakeDamage(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent() == params.unit then return end
    if params.unit:IsBuilding() then return end
    if params.damage <= 0 then return end
    if params.inflictor == nil then return end
    local nyx_assassin_jolt_custom = self:GetParent():FindAbilityByName("nyx_assassin_jolt_custom")
    params.unit:Script_ReduceMana(params.damage / 100 * self.mana[self:GetStackCount()], nyx_assassin_jolt_custom)
end