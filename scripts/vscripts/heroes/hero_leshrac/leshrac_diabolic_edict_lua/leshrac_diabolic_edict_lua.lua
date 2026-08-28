--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


leshrac_diabolic_edict_lua = class({})
LinkLuaModifier(
	"modifier_leshrac_diabolic_edict_lua",
	"heroes/hero_leshrac/leshrac_diabolic_edict_lua/modifier_leshrac_diabolic_edict_lua",
	LUA_MODIFIER_MOTION_NONE
)

function leshrac_diabolic_edict_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetDuration()

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_leshrac_diabolic_edict_lua", -- modifier name
		{ duration = duration } -- kv
	)
end