--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_primal_beast_pulverize_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_pulverize_lua:IsHidden()
	return false
end

function modifier_primal_beast_pulverize_lua:IsDebuff()
	return false
end

function modifier_primal_beast_pulverize_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_pulverize_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
end

function modifier_primal_beast_pulverize_lua:OnRefresh(kv) end

function modifier_primal_beast_pulverize_lua:OnRemoved() end

function modifier_primal_beast_pulverize_lua:OnDestroy() end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_pulverize_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}

	return funcs
end

function modifier_primal_beast_pulverize_lua:GetModifierDisableTurning()
	return 1
end