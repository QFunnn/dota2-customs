--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_18=class({})

function modifier_ogre_magi_18:IsHidden() return true end
function modifier_ogre_magi_18:IsPurgable() return false end
function modifier_ogre_magi_18:IsPurgeException() return false end
function modifier_ogre_magi_18:RemoveOnDeath() return false end

function modifier_ogre_magi_18:OnCreated()
	self.cast_range = {50,100,150}
	self.move_speed = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_ogre_magi_18:OnRefresh()
	self.cast_range = {50,100,150}
	self.move_speed = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ogre_magi_18:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_ogre_magi_18:GetModifierCastRangeBonusStacking()
	return self.cast_range[self:GetStackCount()]
end

function modifier_ogre_magi_18:GetModifierMoveSpeedBonus_Constant()
	return self.move_speed[self:GetStackCount()]
end