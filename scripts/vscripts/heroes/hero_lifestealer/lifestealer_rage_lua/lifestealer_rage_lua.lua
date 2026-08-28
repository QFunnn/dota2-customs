--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


lifestealer_rage_lua = class({})
LinkLuaModifier(
	"modifier_lifestealer_rage_lua",
	"heroes/hero_lifestealer/lifestealer_rage_lua/modifier_lifestealer_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
function lifestealer_rage_lua:OnSpellStart()
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int2") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int2"):GetLevel() > 0 then
			duration = self:GetSpecialValueFor("duration") + 2
		end
	end

	-- dispel
	caster:Purge(false, true, false, false, false)

	-- apply modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lifestealer_rage_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_LifeStealer.Rage"
	EmitSoundOn(sound_cast, caster)
end