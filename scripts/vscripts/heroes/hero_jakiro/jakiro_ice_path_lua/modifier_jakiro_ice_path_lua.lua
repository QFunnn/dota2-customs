--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_jakiro_ice_path_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_ice_path_lua:IsHidden()
	return false
end

function modifier_jakiro_ice_path_lua:IsDebuff()
	return true
end

function modifier_jakiro_ice_path_lua:IsStunDebuff()
	return true
end

function modifier_jakiro_ice_path_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_ice_path_lua:OnCreated(kv) end

function modifier_jakiro_ice_path_lua:OnRefresh(kv) end

function modifier_jakiro_ice_path_lua:OnRemoved() end

function modifier_jakiro_ice_path_lua:OnDestroy() end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_jakiro_ice_path_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_ice_path_lua:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_icepath_debuff.vpcf"
end

function modifier_jakiro_ice_path_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end