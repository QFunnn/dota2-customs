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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 怪物通用技能10 - 高空视野
____exports.common_016 = __TS__Class()
local common_016 = ____exports.common_016
common_016.name = "common_016"
__TS__ClassExtends(common_016, MonsterAbility_CS)
function common_016.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_016"
end
common_016 = __TS__DecorateLegacy({ registerAbility(nil) }, common_016)
____exports.common_016 = common_016
____exports.modifier_common_016 = __TS__Class()
local modifier_common_016 = ____exports.modifier_common_016
modifier_common_016.name = "modifier_common_016"
__TS__ClassExtends(modifier_common_016, BaseModifier_CS)
function modifier_common_016.prototype.IsHidden(self)
	return true
end
function modifier_common_016.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	parent:EmitSound("Hero_Beastmaster.Call.Boar")
	self:StartIntervalThink(3)
end
function modifier_common_016.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		1000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_CAN_BE_SEEN,
		FIND_ANY_ORDER,
		false
	)
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue11
			end
			unit:AddNewModifier(caster, nil, "modifier_cs_boss_fow_reveal", { duration = 5 })
		end
		::__continue11::
	end
end
modifier_common_016 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_common_016)
____exports.modifier_common_016 = modifier_common_016
return ____exports