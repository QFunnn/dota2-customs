--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


dragon_knight_elder_dragon_form_lua = class({})
LinkLuaModifier(
	"modifier_dragon_knight_elder_dragon_form_lua",
	"heroes/hero_dragon/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_dragon_knight_elder_dragon_form_lua_corrosive",
	"heroes/hero_dragon/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua_corrosive",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_dragon_knight_elder_dragon_form_lua_frost",
	"heroes/hero_dragon/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua_frost",
	LUA_MODIFIER_MOTION_NONE
)

function dragon_knight_elder_dragon_form_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_3")
	if talent and talent:GetLevel() > 0 then
		duration = duration + 60
	end

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dragon_knight_elder_dragon_form_lua", -- modifier name
		{ duration = duration } -- kv
	)
end