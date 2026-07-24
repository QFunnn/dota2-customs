--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_void_spirit_13=class({})

function modifier_void_spirit_13:IsHidden() return true end
function modifier_void_spirit_13:IsPurgable() return false end
function modifier_void_spirit_13:IsPurgeException() return false end
function modifier_void_spirit_13:RemoveOnDeath() return false end

function modifier_void_spirit_13:OnCreated()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
    local void_spirit_dissimilate_custom = self:GetCaster():FindAbilityByName("void_spirit_dissimilate_custom")
    if void_spirit_dissimilate_custom then
        void_spirit_dissimilate_custom:SetHidden(true)
        void_spirit_dissimilate_custom:SetActivated(false)
    end
end

function modifier_void_spirit_13:OnRefresh()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_void_spirit_13:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_void_spirit_13:GetModifierConstantManaRegen()
	return self.bonus[self:GetStackCount()]
end