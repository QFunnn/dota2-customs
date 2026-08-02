--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_stunned_lua = class({})

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:IsDebuff()
	return true
end

function modifier_generic_stunned_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_stunned_lua:GetOverrideAnimation(params)
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------

function modifier_generic_stunned_lua:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_generic_stunned_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------