--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


pugna_oblivion_savant = pugna_oblivion_savant or class({})
LinkLuaModifier("modifier_pugna_oblivion_savant_custom", "abilities/heroes/pugna/pugna_oblivion_savant", LUA_MODIFIER_MOTION_NONE)


function pugna_oblivion_savant:GetIntrinsicModifierName()
	return "modifier_pugna_oblivion_savant_custom"
end



modifier_pugna_oblivion_savant_custom = modifier_pugna_oblivion_savant_custom or class({})

function modifier_pugna_oblivion_savant_custom:IsHidden() return true end
function modifier_pugna_oblivion_savant_custom:IsPurgable() return false end
function modifier_pugna_oblivion_savant_custom:RemoveOnDeath() return false end


function modifier_pugna_oblivion_savant_custom:CheckState()
	return {
		[MODIFIER_STATE_CASTS_IGNORE_CHANNELING] = true,
	}
end