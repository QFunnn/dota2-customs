--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_faceless_void_11=class({})

function modifier_faceless_void_11:IsHidden() return true end
function modifier_faceless_void_11:IsPurgable() return false end
function modifier_faceless_void_11:IsPurgeException() return false end
function modifier_faceless_void_11:RemoveOnDeath() return false end

function modifier_faceless_void_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_faceless_void_11_buff", {})
end

function modifier_faceless_void_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_faceless_void_11_buff = class({})
function modifier_faceless_void_11_buff:IsHidden() return not self:GetParent():HasModifier("modifier_faceless_void_11") end
function modifier_faceless_void_11_buff:IsPurgable() return false end
function modifier_faceless_void_11_buff:IsPurgeException() return false end
function modifier_faceless_void_11_buff:RemoveOnDeath() return false end
function modifier_faceless_void_11_buff:GetTexture() return "faceless_void_11" end
function modifier_faceless_void_11_buff:OnCreated()
    self.bonus = {2,3,4}
    if not IsServer() then return end
end

function modifier_faceless_void_11_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_faceless_void_11_buff:OnDeath(params)
    if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if not params.unit:IsRealHero() then return end
    if not self:GetParent():IsSilenced() then return end
    self:IncrementStackCount()
end

function modifier_faceless_void_11_buff:GetModifierBaseAttack_BonusDamage()
    if not self:GetCaster():HasModifier("modifier_faceless_void_11") then return end
    return self:GetStackCount() * self.bonus[self:GetCaster():GetTalentLevel("modifier_faceless_void_11")]
end