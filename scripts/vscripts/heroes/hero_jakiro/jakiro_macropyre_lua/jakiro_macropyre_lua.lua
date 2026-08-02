--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


jakiro_macropyre_lua = class({})
LinkLuaModifier(
	"modifier_jakiro_macropyre_lua",
	"heroes/hero_jakiro/jakiro_macropyre_lua/modifier_jakiro_macropyre_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_jakiro_macropyre_lua_thinker",
	"heroes/hero_jakiro/jakiro_macropyre_lua/modifier_jakiro_macropyre_lua_thinker",
	LUA_MODIFIER_MOTION_NONE
)

function jakiro_macropyre_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- calculate direction
	local dir = point - caster:GetOrigin()
	dir.z = 0
	dir = dir:Normalized()

	-- get duration
	local duration = self:GetSpecialValueFor("duration")
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_jakiro_int4")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		duration = self:GetSpecialValueFor("duration") + 10
	end
	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_jakiro_macropyre_lua_thinker", -- modifier name
		{
			duration = duration,
			x = dir.x,
			y = dir.y,
		}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)

	-- play effects
	local sound_cast = "Hero_Jakiro.Macropyre.Cast"
	EmitSoundOn(sound_cast, caster)
end