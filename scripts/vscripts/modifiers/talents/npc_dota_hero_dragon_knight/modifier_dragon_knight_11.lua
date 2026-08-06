--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_dragon_knight_11 = class({})

function modifier_dragon_knight_11:IsHidden()
	return true
end
function modifier_dragon_knight_11:IsPurgable()
	return false
end
function modifier_dragon_knight_11:IsPurgeException()
	return false
end
function modifier_dragon_knight_11:RemoveOnDeath()
	return false
end

function modifier_dragon_knight_11:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("dragon_knight_dragon_toxic")
	if ability then
		ability:SetHidden(false)
		ability:SetLevel(1)
	end
end

function modifier_dragon_knight_11:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local ability = self:GetParent():FindAbilityByName("dragon_knight_dragon_toxic")
	if ability then
		ability:SetLevel(self:GetStackCount())
	end
end