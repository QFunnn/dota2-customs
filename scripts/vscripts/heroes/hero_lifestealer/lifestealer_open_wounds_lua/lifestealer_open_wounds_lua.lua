--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


lifestealer_open_wounds_lua = class({})
LinkLuaModifier(
	"modifier_lifestealer_open_wounds_lua",
	"heroes/hero_lifestealer/lifestealer_open_wounds_lua/modifier_lifestealer_open_wounds_lua",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Ability Start
function lifestealer_open_wounds_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb(self) then
		return
	end

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int4") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int4"):GetLevel() > 0 then
			duration = self:GetSpecialValueFor("duration") + 2
		end
	end

	-- apply modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lifestealer_open_wounds_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_LifeStealer.OpenWounds.Cast"
	local sound_target = "Hero_LifeStealer.OpenWounds"
	EmitSoundOn(sound_cast, caster)
	EmitSoundOn(sound_target, target)
end