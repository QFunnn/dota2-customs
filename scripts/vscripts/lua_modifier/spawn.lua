--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_spawn = class({})

function modifier_spawn:IsStunDebuff()
	return true
end

function modifier_spawn:IsHidden()
	return true
end

function modifier_spawn:IsPurgable()
	return false
end

function modifier_spawn:RemoveOnDeath()
	return false
end

function modifier_spawn:OnCreated(kv)
	return
end

function modifier_spawn:OnDestroy()
	return
end

-- function modifier_spawn:DeclareFunctions()
--     local funcs = {
--         MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
--     }
--     return funcs
-- end

-- function modifier_spawn:GetOverrideAnimation()
--     return ACT_DOTA_SPAWN
-- end