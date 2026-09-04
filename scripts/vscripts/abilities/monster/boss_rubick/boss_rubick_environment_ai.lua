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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_rubick_origin_6 = require("abilities.monster.boss_rubick.boss_rubick_origin_6")
local SyncRubickBossStyleAbilities = ____boss_rubick_origin_6.SyncRubickBossStyleAbilities
--- 拉比克 Boss 专属环境 AI：用于承载 Boss 房间环境相关的被动逻辑。
____exports.boss_rubick_environment_ai = __TS__Class()
local boss_rubick_environment_ai = ____exports.boss_rubick_environment_ai
boss_rubick_environment_ai.name = "boss_rubick_environment_ai"
__TS__ClassExtends(boss_rubick_environment_ai, MonsterAbility_CS)
function boss_rubick_environment_ai.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function boss_rubick_environment_ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_rubick_environment_ai"
end
boss_rubick_environment_ai = __TS__DecorateLegacy({ registerAbility(nil) }, boss_rubick_environment_ai)
____exports.boss_rubick_environment_ai = boss_rubick_environment_ai
--- 拉比克 Boss 环境 AI 宿体。
____exports.modifier_boss_rubick_environment_ai = __TS__Class()
local modifier_boss_rubick_environment_ai = ____exports.modifier_boss_rubick_environment_ai
modifier_boss_rubick_environment_ai.name = "modifier_boss_rubick_environment_ai"
__TS__ClassExtends(modifier_boss_rubick_environment_ai, MonsterModifier_CS)
function modifier_boss_rubick_environment_ai.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
function modifier_boss_rubick_environment_ai.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	SysTimers:CreateTimer(0, function()
		self:SyncCurrentFloorStyleAbilities()
		return nil
	end)
end
function modifier_boss_rubick_environment_ai.prototype.SyncCurrentFloorStyleAbilities(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not MyGameDynamicFloor or not MyGameRubickBossEnvironment then
		return
	end
	local ____MyGameDynamicFloor_3 = MyGameDynamicFloor
	local ____MyGameDynamicFloor_GetTileAtPoint_4 = MyGameDynamicFloor.GetTileAtPoint
	local ____temp_2 = parent:GetAbsOrigin()
	local ____opt_0 = parent.GetRoomId
	local tile =
		____MyGameDynamicFloor_GetTileAtPoint_4(____MyGameDynamicFloor_3, ____temp_2, ____opt_0 and ____opt_0(parent))
	if not tile then
		return
	end
	local phaseId = MyGameRubickBossEnvironment:GetCurrentPhase(tile.floorId)
	SyncRubickBossStyleAbilities(nil, parent, phaseId)
end
modifier_boss_rubick_environment_ai =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_rubick_environment_ai)
____exports.modifier_boss_rubick_environment_ai = modifier_boss_rubick_environment_ai
return ____exports