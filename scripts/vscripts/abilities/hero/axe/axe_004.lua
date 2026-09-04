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
local ____modifier_generic_motion = require("modifiers.modifier_generic_motion")
local modifier_generic_dash = ____modifier_generic_motion.modifier_generic_dash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
--- 斧王专用冲刺
____exports.axe_004 = __TS__Class()
local axe_004 = ____exports.axe_004
axe_004.name = "axe_004"
__TS__ClassExtends(axe_004, BaseHeroAbility)
function axe_004.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/hero/axe/axe_practos_ambient.vpcf", context)
	PrecacheResource("particle", "particles/hero/axe/axe_armor.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger.vpcf", context)
end
function axe_004.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_POINT }
end
function axe_004.prototype.GetCastRange(self, _location, _target)
	if IsClient() then
		return self:GetSpecialValue("axe_004", "dash_distance")
	end
	return 25000
end
function axe_004.prototype.GetMaxLevel(self)
	return 1
end
function axe_004.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, point, origin)
	local kvDistance = self:GetSpecialValue("axe_004", "dash_distance")
	local playerDistance = origin:__sub(point):Length2D()
	local minDistance = kvDistance * 0.618
	local maxDistance = kvDistance
	local distance = math.min(math.max(minDistance, playerDistance), maxDistance)
	local duration = self:GetSpecialValue("axe_004", "dash_duration")
	caster:AddNewModifier(caster, self, "modifier_cs_damage_reduction", { duration = 0.25, damage_reduction_pct = 100 })
	modifier_generic_dash:applys(caster, caster, self, {
		distance = distance,
		dir = dir,
		duration = duration,
		corridor_half_width = 500,
		cell_size = 80,
		break_destructibles = 1,
	})
end
axe_004 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_004)
____exports.axe_004 = axe_004
return ____exports