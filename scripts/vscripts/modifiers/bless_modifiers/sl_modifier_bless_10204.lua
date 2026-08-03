--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 流离：技能转向
-- TODO: 等实测确认 GetRedirectSpell 签名/返回值后再实现选目标与 CD。
-- 预期逻辑：
-- - 按 chance 判定
-- - 在 radius 内优先敌方英雄，否则随机英雄
-- - cd 冷却
____exports.sl_modifier_bless_10204 = __TS__Class()
local sl_modifier_bless_10204 = ____exports.sl_modifier_bless_10204
sl_modifier_bless_10204.name = "sl_modifier_bless_10204"
__TS__ClassExtends(sl_modifier_bless_10204, sl_modifier_transmitter_data)
function sl_modifier_bless_10204.prototype.____constructor(self, ...)
	sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	self._ready = true
end
function sl_modifier_bless_10204.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10204.prototype.GetTexture(self)
	return "buff/bless/10204"
end
function sl_modifier_bless_10204.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_REDIRECT_SPELL, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10204.prototype.GetRedirectSpell(self)
	return
end
function sl_modifier_bless_10204.prototype.OnTooltip(self)
	local ____table__params_chance_0 = self._params
	if ____table__params_chance_0 ~= nil then
		____table__params_chance_0 = ____table__params_chance_0.chance
	end
	local ____table__params_chance_0_2 = ____table__params_chance_0
	if ____table__params_chance_0_2 == nil then
		____table__params_chance_0_2 = 0
	end
	return ____table__params_chance_0_2
end
function sl_modifier_bless_10204.prototype._PickRedirectTarget(self)
	if not self._ready or not self._params then
		return nil
	end
	local ____self__params_chance_3 = self._params.chance
	if ____self__params_chance_3 == nil then
		____self__params_chance_3 = 0
	end
	local chance = ____self__params_chance_3
	if not RollPercentage(chance) then
		return nil
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return nil
	end
	local ____self__params_radius_4 = self._params.radius
	if ____self__params_radius_4 == nil then
		____self__params_radius_4 = 0
	end
	local radius = ____self__params_radius_4
	local units = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)
	local enemies = {}
	local allies = {}
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(unit) or not unit:IsRealHero() or unit == parent then
				goto __continue11
			end
			if unit:GetTeamNumber() ~= parent:GetTeamNumber() then
				enemies[#enemies + 1] = unit
			else
				allies[#allies + 1] = unit
			end
		end
		::__continue11::
	end
	local ____temp_5
	if #enemies > 0 then
		____temp_5 = enemies
	else
		____temp_5 = allies
	end
	local pool = ____temp_5
	if #pool == 0 then
		return nil
	end
	local pick = GetRandomArrayElement(pool)
	local ____self__params_cd_6 = self._params.cd
	if ____self__params_cd_6 == nil then
		____self__params_cd_6 = 0
	end
	local cd = ____self__params_cd_6
	self._ready = false
	Timers:CreateTimer(cd, function()
		if not IsValid(self) then
			return
		end
		self._ready = true
	end)
	return pick
end
sl_modifier_bless_10204 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10204") },
	sl_modifier_bless_10204
)
____exports.sl_modifier_bless_10204 = sl_modifier_bless_10204
return ____exports