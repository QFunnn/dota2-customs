--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


leshrac_lightning_storm_lua = class({})
LinkLuaModifier(
	"modifier_leshrac_lightning_storm_lua",
	"heroes/hero_leshrac/leshrac_lightning_storm_lua/modifier_leshrac_lightning_storm_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_leshrac_lightning_storm_lua_thinker",
	"heroes/hero_leshrac/leshrac_lightning_storm_lua/modifier_leshrac_lightning_storm_lua_thinker",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Ability Start
function leshrac_lightning_storm_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb(self) then
		return
	end

	-- create thinker
	local thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_leshrac_lightning_storm_lua_thinker", -- modifier name
		{}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
	local modifier = thinker:FindModifierByName("modifier_leshrac_lightning_storm_lua_thinker")
	modifier:Cast(target)
end