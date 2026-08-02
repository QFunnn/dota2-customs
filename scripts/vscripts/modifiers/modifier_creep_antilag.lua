--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_creep_antilag = class({})

function modifier_creep_antilag:IsHidden()
	return true
end

function modifier_creep_antilag:IsPurgable()
	return false
end

function modifier_creep_antilag:OnCreated()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()

	parent:AddNoDraw()
end

function modifier_creep_antilag:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()

	parent:RemoveNoDraw()
end

function modifier_creep_antilag:CheckState()
	local state = {
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		-- [MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
	return state
end