--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_9=class({})

function modifier_axe_9:IsHidden() return true end
function modifier_axe_9:IsPurgable() return false end
function modifier_axe_9:IsPurgeException() return false end
function modifier_axe_9:RemoveOnDeath() return false end

function modifier_axe_9:OnCreated()
	if not IsServer() then return end
    self.bonus_distance = {650,600,550}
    self.distance_to_skill = 0
	self.currentpos = self:GetParent():GetAbsOrigin()
	self:SetStackCount(1)
    local axe_counter_helix_custom = self:GetCaster():FindAbilityByName("axe_counter_helix_custom")
    if axe_counter_helix_custom and not self:GetCaster():HasModifier("modifier_axe_3") then
        axe_counter_helix_custom:EndCooldown()
    end
    if axe_counter_helix_custom and axe_counter_helix_custom:GetLevel() < 4 then
        axe_counter_helix_custom:SetLevel(axe_counter_helix_custom:GetLevel() + 1)
    end
    self:StartIntervalThink(FrameTime())
end

function modifier_axe_9:OnRefresh()
	if not IsServer() then return end
    self.bonus_distance = {650,600,550}
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_axe_9:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_axe_9:OnIntervalThink()
	if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
	local pos = self:GetParent():GetOrigin()
	local dist = (pos - self.currentpos):Length2D()
	self.currentpos = pos
	if dist > 1000 then return end
    self.distance_to_skill = self.distance_to_skill + dist
    if self.distance_to_skill > self.bonus_distance[self:GetStackCount()] then
        self.distance_to_skill = 0
        local modifier_axe_counter_helix_custom = self:GetParent():FindModifierByName("modifier_axe_counter_helix_custom")
        if modifier_axe_counter_helix_custom then
            modifier_axe_counter_helix_custom:StartHelix()
        end
    end
end