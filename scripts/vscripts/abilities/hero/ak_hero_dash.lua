--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____modifier_generic_motion = require("modifiers.modifier_generic_motion")
local modifier_generic_dash = ____modifier_generic_motion.modifier_generic_dash
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
--- 冲刺：点地面，施法距离无限，冲刺距离固定 300，冲刺过程中减伤。
-- 等级上限 1，不可学习。
____exports.ak_hero_dash = __TS__Class()
local ak_hero_dash = ____exports.ak_hero_dash
ak_hero_dash.name = "ak_hero_dash"
__TS__ClassExtends(ak_hero_dash, BaseHeroAbility)
function ak_hero_dash.prototype.GetBehavior(self)
	return DOTA_ABILITY_BEHAVIOR_POINT
end
function ak_hero_dash.prototype.GetCastRange(self, _location, _target)
	if IsClient() then
		return 300
	end
	return 25000
end
function ak_hero_dash.prototype.GetMaxLevel(self)
	return 1
end
function ak_hero_dash.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, point, origin)
	local kv_distance = self:GetSpecialValue("ak_hero_dash", "dash_distance")
	local player_distance = origin:__sub(point):Length2D()
	local min_distance = kv_distance * 0.618
	local max_distance = kv_distance * 1
	local distance = math.min(math.max(min_distance, player_distance), max_distance)
	local duration = self:GetSpecialValue("ak_hero_dash", "dash_duration")
	caster:AddNewModifier(caster, self, "modifier_cs_damage_reduction", { duration = 0.2, damage_reduction_pct = 100 })
	modifier_generic_dash:applys(caster, caster, self, { distance = distance, dir = dir, duration = duration })
end
ak_hero_dash = __TS__DecorateLegacy({ registerAbility(nil) }, ak_hero_dash)
____exports.ak_hero_dash = ak_hero_dash
return ____exports