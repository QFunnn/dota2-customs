--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_3 = class({})

function modifier_ogre_magi_3:IsHidden()
	return true
end
function modifier_ogre_magi_3:IsPurgable()
	return false
end
function modifier_ogre_magi_3:IsPurgeException()
	return false
end
function modifier_ogre_magi_3:RemoveOnDeath()
	return false
end

function modifier_ogre_magi_3:OnCreated()
	self.cooldown_reduction = 13
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local ogre_magi_fireblast_custom = self:GetCaster():FindAbilityByName("ogre_magi_fireblast_custom")
	if ogre_magi_fireblast_custom then
		ogre_magi_fireblast_custom:SetHidden(true)
		ogre_magi_fireblast_custom:SetActivated(false)
	end
end

function modifier_ogre_magi_3:OnRefresh()
	self.cooldown_reduction = 13
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ogre_magi_3:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_ogre_magi_3:GetModifierPercentageCooldown()
	return self.cooldown_reduction
end