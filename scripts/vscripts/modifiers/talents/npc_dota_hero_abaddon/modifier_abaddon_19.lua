--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_abaddon_19 = class({})

function modifier_abaddon_19:IsHidden()
	return true
end
function modifier_abaddon_19:IsPurgable()
	return false
end
function modifier_abaddon_19:IsPurgeException()
	return false
end
function modifier_abaddon_19:RemoveOnDeath()
	return false
end

function modifier_abaddon_19:OnCreated()
	self.bonus = { 10, 20 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_abaddon_19:OnRefresh()
	self.bonus = { 10, 20 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_abaddon_19:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_abaddon_19:GetModifierConstantManaRegen()
	return self.bonus[self:GetStackCount()]
end