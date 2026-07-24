--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_primary_attribute_reader = class({})

function modifier_primary_attribute_reader:IsHidden() return true end
function modifier_primary_attribute_reader:IsPurgable() return false end
function modifier_primary_attribute_reader:RemoveOnDeath() return false end
function modifier_primary_attribute_reader:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_primary_attribute_reader:OnCreated()
	if not IsServer() then return end
	local parent = self:GetParent()

	if not parent:IsHero() then
		self:SetStackCount(DOTA_ATTRIBUTE_INVALID)
	else
		self:SetStackCount(parent:GetPrimaryAttribute())
	end
end