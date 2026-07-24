--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



luna_eclipse_lua = class({})
LinkLuaModifier( "modifier_luna_eclipse_lua", "heroes/hero_luna/modifier_luna_eclipse_lua", LUA_MODIFIER_MOTION_NONE )
--------------------------------------------------------------------------------


function luna_eclipse_lua:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "radius" )
	end
	return 0
end

function luna_eclipse_lua:GetBehavior()
	if self:GetCaster():HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end

	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function luna_eclipse_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_tooltip_scepter" )
	end
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function luna_eclipse_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("damage")

	-- check scepter
	local unit = caster
	if caster:HasScepter() then
		if target then
			unit = target
		else
			unit = nil
		end
	end

	-- add eclipse modifier
	if unit then
		unit:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_luna_eclipse_lua", -- modifier name
			{
				damage = damage,
			} -- kv
		)
	else
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_luna_eclipse_lua", -- modifier name
			{
				damage = damage,
				point = 1,
				pointx = point.x,
				pointy = point.y,
				pointz = point.z,
			} -- kv
		)
	end

	-- begin night
	GameRules:BeginTemporaryNight( 10 )
end