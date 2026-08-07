--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


juggernaut_blade_fury_lua = class({})
LinkLuaModifier(
	"modifier_juggernaut_blade_fury_lua",
	"lua_abilities/juggernaut_blade_fury_lua/modifier_juggernaut_blade_fury_lua",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_blade_fury_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local bDuration = self:GetSpecialValueFor("duration")

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_juggernaut_blade_fury_lua", -- modifier name
		{ duration = bDuration } -- kv
	)
end