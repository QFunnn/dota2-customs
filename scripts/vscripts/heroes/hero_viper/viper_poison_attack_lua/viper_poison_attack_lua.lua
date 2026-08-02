--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


viper_poison_attack_lua = class({})
LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_viper_poison_attack_lua",
	"heroes/hero_viper/viper_poison_attack_lua/modifier_viper_poison_attack_lua",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Passive Modifier
function viper_poison_attack_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function viper_poison_attack_lua:GetManaCost(iLevel)
	if self:GetCaster():FindAbilityByName("special_bonus_viper_int1") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_viper_int1"):GetLevel() > 0 then
			return 0
		end
	end
	return self.BaseClass.GetManaCost(self, iLevel)
end

function viper_poison_attack_lua:GetProjectileName()
	return "particles/units/heroes/hero_viper/viper_poison_attack.vpcf"
end

function viper_poison_attack_lua:OnOrbFire(params)
	-- play effects
	local sound_cast = "hero_viper.poisonAttack.Cast"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function viper_poison_attack_lua:OnOrbImpact(params)
	-- references
	local duration = self:GetSpecialValueFor("duration")

	-- add debuff
	params.target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_viper_poison_attack_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "hero_viper.poisonAttack.Target"
	EmitSoundOn(sound_cast, self:GetCaster())
end