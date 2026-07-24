--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tiny_tree_grab_lua = class({})
LinkLuaModifier("modifier_tiny_grab_lua", "heroes/hero_tiny/modifier_tiny_grab_lua", LUA_MODIFIER_MOTION_NONE)

--function tiny_tree_grab_lua:GetBehaviorInt( ... )
	
--end

function tiny_tree_grab_lua:OnSpellStart( ... )
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local mod = caster:AddNewModifier(caster, self, "modifier_tiny_grab_lua", {})
    local attack_count= self:GetSpecialValueFor("attack_count")+caster:GetTalentValue("special_bonus_unique_tiny_6")
	
	if not mod then return end

	if not caster:HasShard() then
    	mod:SetStackCount(attack_count)
    end

	caster:SwapAbilities("tiny_tree_grab_lua", "tiny_tree_throw_lua", false, true)

	if target.CutDown then
		target:CutDown(caster:GetTeamNumber())
	end

	caster:EmitSound("Hero_Tiny.Tree.Grab")
end


function tiny_tree_grab_lua:OnUpgrade()
	local caster = self:GetCaster()
	local mod = caster:FindModifierByName("modifier_tiny_grab_lua")
	if not mod then return end

	mod.attack_range_override = self:GetSpecialValueFor("attack_range")
	mod.speed_reduction 	  = self:GetSpecialValueFor("speed_reduction") * -1
	mod.bonus_damage 		  = self:GetSpecialValueFor("bonus_damage") / 100.0

	mod.splash_pct 		= self:GetSpecialValueFor("splash_pct") / 100.0
	mod.splash_width 	= self:GetSpecialValueFor("splash_width")
	mod.splash_range 	= self:GetSpecialValueFor("splash_range")
end


function tiny_tree_grab_lua:GetAssociatedSecondaryAbilities()
	return "tiny_tree_throw_lua"
end