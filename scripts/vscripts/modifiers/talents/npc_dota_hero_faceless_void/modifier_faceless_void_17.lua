--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_faceless_void_17=class({})

function modifier_faceless_void_17:IsHidden() return true end
function modifier_faceless_void_17:IsPurgable() return false end
function modifier_faceless_void_17:IsPurgeException() return false end
function modifier_faceless_void_17:RemoveOnDeath() return false end

function modifier_faceless_void_17:OnCreated()
	if not IsServer() then return end
    self.bonus={150,300}
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
    local faceless_void_face_ward = self:GetCaster():FindAbilityByName("faceless_void_face_ward")
    if faceless_void_face_ward then
        faceless_void_face_ward:SetLevel(self:GetStackCount())
        faceless_void_face_ward:SetHidden(false)
    end
end

function modifier_faceless_void_17:OnRefresh()
	if not IsServer() then return end
    self.bonus={150,300}
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
    local faceless_void_face_ward = self:GetCaster():FindAbilityByName("faceless_void_face_ward")
    if faceless_void_face_ward then
        faceless_void_face_ward:SetLevel(self:GetStackCount())
        faceless_void_face_ward:SetHidden(false)
    end
end

function modifier_faceless_void_17:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_faceless_void_17:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end