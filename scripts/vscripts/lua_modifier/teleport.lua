--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_teleport = class({})

function modifier_teleport:IsStunDebuff()
	return true
end

function modifier_teleport:IsHidden()
	return true
end

function modifier_teleport:IsPurgable()
	return false
end

function modifier_teleport:RemoveOnDeath()
	return false
end

function modifier_teleport:OnCreated(kv)
	return
end

function modifier_teleport:OnDestroy()
	return
end

-- function modifier_teleport:DeclareFunctions()
--     local funcs = {
--         MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
--     }
--     return funcs
-- end

-- function modifier_teleport:GetOverrideAnimation()
--     return ACT_DOTA_TELEPORT
-- end