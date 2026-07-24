--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_luna_14=class({})
function modifier_luna_14:IsHidden() return true end
function modifier_luna_14:IsPurgable() return false end
function modifier_luna_14:IsPurgeException() return false end
function modifier_luna_14:RemoveOnDeath() return false end

function modifier_luna_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self.current_agi = math.floor(self:GetParent():GetStrength() / 100)
    local modifier_luna_lunar_orbit_custom = self:GetParent():FindModifierByName("modifier_luna_lunar_orbit_custom")
    if modifier_luna_lunar_orbit_custom then
        modifier_luna_lunar_orbit_custom:Destroy()
    end
    local luna_lunar_orbit_custom = self:GetParent():FindAbilityByName("luna_lunar_orbit_custom")
    if luna_lunar_orbit_custom then
        luna_lunar_orbit_custom:SetLevel(4)
        self:GetParent():AddNewModifier(self:GetParent(), luna_lunar_orbit_custom, "modifier_luna_lunar_orbit_custom", {})
    end
    self:StartIntervalThink(1)
end

function modifier_luna_14:OnIntervalThink()
    if not IsServer() then return end
    local current_agi = math.floor(self:GetParent():GetStrength() / 100)
    if current_agi ~= self.current_agi then
        local modifier_luna_lunar_orbit_custom = self:GetParent():FindModifierByName("modifier_luna_lunar_orbit_custom")
        if modifier_luna_lunar_orbit_custom then
            modifier_luna_lunar_orbit_custom:OnRefresh()
        end
        self.current_agi = current_agi
    end
end

function modifier_luna_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end