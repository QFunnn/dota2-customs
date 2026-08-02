--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


jakiro_ice_path_lua = class({})
LinkLuaModifier(
	"modifier_jakiro_ice_path_lua",
	"heroes/hero_jakiro/jakiro_ice_path_lua/modifier_jakiro_ice_path_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_jakiro_ice_path_lua_thinker",
	"heroes/hero_jakiro/jakiro_ice_path_lua/modifier_jakiro_ice_path_lua_thinker",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Ability Start
function jakiro_ice_path_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- calculate direction
	local dir = point - caster:GetOrigin()
	dir.z = 0
	dir = dir:Normalized()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_jakiro_ice_path_lua_thinker", -- modifier name
		{
			x = dir.x,
			y = dir.y,
		}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
end