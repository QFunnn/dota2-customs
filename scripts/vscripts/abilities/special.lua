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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
____exports.collision_effect = __TS__Class()
local collision_effect = ____exports.collision_effect
collision_effect.name = "collision_effect"
__TS__ClassExtends(collision_effect, BaseAbility)
function collision_effect.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function collision_effect.prototype.GetIntrinsicModifierName(self)
	return "modifier_collision_effect"
end
collision_effect = __TS__DecorateLegacy({ registerAbility(nil) }, collision_effect)
____exports.collision_effect = collision_effect
____exports.modifier_collision_effect = __TS__Class()
local modifier_collision_effect = ____exports.modifier_collision_effect
modifier_collision_effect.name = "modifier_collision_effect"
__TS__ClassExtends(modifier_collision_effect, BaseModifier)
function modifier_collision_effect.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.03)
end
function modifier_collision_effect.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetCaster()) then
		return
	end
	self:PushUnit()
end
function modifier_collision_effect.prototype.PushUnit(self)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		100,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		if enemy == caster then
			return
		end
		if not IsValidAlive(nil, enemy) or enemy:IsNull() then
			return
		end
		if enemy:GetBaseMoveSpeed() < 40 then
			return
		end
		local direction = enemy:GetAbsOrigin():__sub(origin):Normalized()
		enemy:SetAbsOrigin(enemy:GetAbsOrigin():__add(direction:__mul(5)))
		FindClearSpaceForUnit(enemy, enemy:GetAbsOrigin(), false)
	end)
end
modifier_collision_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_collision_effect)
____exports.modifier_collision_effect = modifier_collision_effect
____exports.red_elite = __TS__Class()
local red_elite = ____exports.red_elite
red_elite.name = "red_elite"
__TS__ClassExtends(red_elite, BaseAbility)
function red_elite.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function red_elite.prototype.GetIntrinsicModifierName(self)
	return "modifier_red_elite"
end
red_elite = __TS__DecorateLegacy({ registerAbility(nil) }, red_elite)
____exports.red_elite = red_elite
____exports.purple_elite = __TS__Class()
local purple_elite = ____exports.purple_elite
purple_elite.name = "purple_elite"
__TS__ClassExtends(purple_elite, BaseAbility)
function purple_elite.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function purple_elite.prototype.GetIntrinsicModifierName(self)
	return "modifier_purple_elite"
end
purple_elite = __TS__DecorateLegacy({ registerAbility(nil) }, purple_elite)
____exports.purple_elite = purple_elite
____exports.cyan_elite = __TS__Class()
local cyan_elite = ____exports.cyan_elite
cyan_elite.name = "cyan_elite"
__TS__ClassExtends(cyan_elite, BaseAbility)
function cyan_elite.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function cyan_elite.prototype.GetIntrinsicModifierName(self)
	return "modifier_cyan_elite"
end
cyan_elite = __TS__DecorateLegacy({ registerAbility(nil) }, cyan_elite)
____exports.cyan_elite = cyan_elite
____exports.cyan_mini = __TS__Class()
local cyan_mini = ____exports.cyan_mini
cyan_mini.name = "cyan_mini"
__TS__ClassExtends(cyan_mini, BaseAbility)
function cyan_mini.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function cyan_mini.prototype.GetIntrinsicModifierName(self)
	return "modifier_cyan_mini"
end
cyan_mini = __TS__DecorateLegacy({ registerAbility(nil) }, cyan_mini)
____exports.cyan_mini = cyan_mini
____exports.modifier_red_elite = __TS__Class()
local modifier_red_elite = ____exports.modifier_red_elite
modifier_red_elite.name = "modifier_red_elite"
__TS__ClassExtends(modifier_red_elite, BaseModifier)
function modifier_red_elite.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
end
function modifier_red_elite.prototype.GetEffectName(self)
	return "particles/phoenix_ambient_red.vpcf"
end
modifier_red_elite = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_red_elite)
____exports.modifier_red_elite = modifier_red_elite
____exports.modifier_purple_elite = __TS__Class()
local modifier_purple_elite = ____exports.modifier_purple_elite
modifier_purple_elite.name = "modifier_purple_elite"
__TS__ClassExtends(modifier_purple_elite, BaseModifier)
function modifier_purple_elite.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
end
function modifier_purple_elite.prototype.GetEffectName(self)
	return "particles/phoenix_ambient_purple.vpcf"
end
modifier_purple_elite = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_purple_elite)
____exports.modifier_purple_elite = modifier_purple_elite
____exports.modifier_cyan_elite = __TS__Class()
local modifier_cyan_elite = ____exports.modifier_cyan_elite
modifier_cyan_elite.name = "modifier_cyan_elite"
__TS__ClassExtends(modifier_cyan_elite, BaseModifier)
function modifier_cyan_elite.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
end
function modifier_cyan_elite.prototype.GetEffectName(self)
	return "particles/phoenix_ambient_cyan.vpcf"
end
modifier_cyan_elite = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cyan_elite)
____exports.modifier_cyan_elite = modifier_cyan_elite
____exports.modifier_cyan_mini = __TS__Class()
local modifier_cyan_mini = ____exports.modifier_cyan_mini
modifier_cyan_mini.name = "modifier_cyan_mini"
__TS__ClassExtends(modifier_cyan_mini, BaseModifier)
function modifier_cyan_mini.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
end
function modifier_cyan_mini.prototype.GetEffectName(self)
	return "particles/phoenix_ambient_mini_cyan.vpcf"
end
modifier_cyan_mini = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cyan_mini)
____exports.modifier_cyan_mini = modifier_cyan_mini
return ____exports