--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Symbol = ____lualib.__TS__Symbol
local Symbol = ____lualib.Symbol
HeroSymbols = HeroSymbols or {}
do
	local ____HeroSymbols_IsAssignedHero_0 = HeroSymbols.IsAssignedHero
	if ____HeroSymbols_IsAssignedHero_0 == nil then
		____HeroSymbols_IsAssignedHero_0 = __TS__Symbol("IsAssignedHero")
	end
	--- 是否是注册的英雄 boolean
	HeroSymbols.IsAssignedHero = ____HeroSymbols_IsAssignedHero_0
	local ____HeroSymbols_IsMonkeyArmy_1 = HeroSymbols.IsMonkeyArmy
	if ____HeroSymbols_IsMonkeyArmy_1 == nil then
		____HeroSymbols_IsMonkeyArmy_1 = __TS__Symbol("IsMonkeyArmy")
	end
	--- 是否是猴子猴孙标识 boolean
	HeroSymbols.IsMonkeyArmy = ____HeroSymbols_IsMonkeyArmy_1
	local ____HeroSymbols_AllowIllusionBuffs_2 = HeroSymbols.AllowIllusionBuffs
	if ____HeroSymbols_AllowIllusionBuffs_2 == nil then
		____HeroSymbols_AllowIllusionBuffs_2 = __TS__Symbol("HeroAllowIllusionBuffs")
	end
	--- 英雄身上能被幻象继承的buff LuaTable<CDOTA_Buff, boolean>
	HeroSymbols.AllowIllusionBuffs = ____HeroSymbols_AllowIllusionBuffs_2
	local ____HeroSymbols_ChildIllusions_3 = HeroSymbols.ChildIllusions
	if ____HeroSymbols_ChildIllusions_3 == nil then
		____HeroSymbols_ChildIllusions_3 = __TS__Symbol("HeroChildIllusions")
	end
	--- 英雄直属子幻想（作为caster）LuaTable<CDOTA_BaseNPC_Hero,boolean>
	HeroSymbols.ChildIllusions = ____HeroSymbols_ChildIllusions_3
	local ____HeroSymbols_ChildIllusionsAll_4 = HeroSymbols.ChildIllusionsAll
	if ____HeroSymbols_ChildIllusionsAll_4 == nil then
		____HeroSymbols_ChildIllusionsAll_4 = __TS__Symbol("HeroChildIllusionsAll")
	end
	--- 英雄所有的子幻想，包括子幻想的子幻象 LuaTable<CDOTA_BaseNPC_Hero,boolean>
	HeroSymbols.ChildIllusionsAll = ____HeroSymbols_ChildIllusionsAll_4
	local ____HeroSymbols_IllusionSourceHero_5 = HeroSymbols.IllusionSourceHero
	if ____HeroSymbols_IllusionSourceHero_5 == nil then
		____HeroSymbols_IllusionSourceHero_5 = __TS__Symbol("IllusionParentHero")
	end
	--- 幻象的直属来源英雄 CDOTA_BaseNPC_Hero
	HeroSymbols.IllusionSourceHero = ____HeroSymbols_IllusionSourceHero_5
	local ____HeroSymbols_IllusionSourceHeroTrace_6 = HeroSymbols.IllusionSourceHeroTrace
	if ____HeroSymbols_IllusionSourceHeroTrace_6 == nil then
		____HeroSymbols_IllusionSourceHeroTrace_6 = __TS__Symbol("IllusionParentHeroTrace")
	end
	--- 幻象的最终来源英雄，一定是真英雄 CDOTA_BaseNPC_Hero
	HeroSymbols.IllusionSourceHeroTrace = ____HeroSymbols_IllusionSourceHeroTrace_6
	local ____HeroSymbols_IllusionLifeTimer_7 = HeroSymbols.IllusionLifeTimer
	if ____HeroSymbols_IllusionLifeTimer_7 == nil then
		____HeroSymbols_IllusionLifeTimer_7 = __TS__Symbol("HeroIllusionLifeTimer")
	end
	--- 幻象的生命周期计时器
	HeroSymbols.IllusionLifeTimer = ____HeroSymbols_IllusionLifeTimer_7
	local ____HeroSymbols_IllusionDestroyTimer_8 = HeroSymbols.IllusionDestroyTimer
	if ____HeroSymbols_IllusionDestroyTimer_8 == nil then
		____HeroSymbols_IllusionDestroyTimer_8 = __TS__Symbol("HeroIllusionDestroyTimer")
	end
	--- 幻象的删除计时器
	HeroSymbols.IllusionDestroyTimer = ____HeroSymbols_IllusionDestroyTimer_8
end
PlayerSymbols = PlayerSymbols or {}
do
	local ____PlayerSymbols_DebugIsReplacingHero_9 = PlayerSymbols.DebugIsReplacingHero
	if ____PlayerSymbols_DebugIsReplacingHero_9 == nil then
		____PlayerSymbols_DebugIsReplacingHero_9 = __TS__Symbol("PlayerReplacingHero")
	end
	--- 玩家正在替换英雄的标记 boolean
	PlayerSymbols.DebugIsReplacingHero = ____PlayerSymbols_DebugIsReplacingHero_9
end
UnitSymbols = UnitSymbols or {}
do
	local ____UnitSymbols_ZombieRemoveFlag_10 = UnitSymbols.ZombieRemoveFlag
	if ____UnitSymbols_ZombieRemoveFlag_10 == nil then
		____UnitSymbols_ZombieRemoveFlag_10 = __TS__Symbol("ZombieRemoveFlag")
	end
	--- boolean 小僵尸移除标记 boolean
	UnitSymbols.ZombieRemoveFlag = ____UnitSymbols_ZombieRemoveFlag_10
	local ____UnitSymbols_IsInAttackStartToLaunchFlow_11 = UnitSymbols.IsInAttackStartToLaunchFlow
	if ____UnitSymbols_IsInAttackStartToLaunchFlow_11 == nil then
		____UnitSymbols_IsInAttackStartToLaunchFlow_11 = __TS__Symbol("IsInAttackStartToLaunchFlow")
	end
	--- 单位是否在进入了攻击前摇的攻击流程中 boolean
	UnitSymbols.IsInAttackStartToLaunchFlow = ____UnitSymbols_IsInAttackStartToLaunchFlow_11
	local ____UnitSymbols_AttackStartToLaunchFlowRecord_12 = UnitSymbols.AttackStartToLaunchFlowRecord
	if ____UnitSymbols_AttackStartToLaunchFlowRecord_12 == nil then
		____UnitSymbols_AttackStartToLaunchFlowRecord_12 = __TS__Symbol("AttackStartToLaunchFlowRecord")
	end
	--- 单位进入了攻击前摇的攻击流程中的攻击记录 number
	UnitSymbols.AttackStartToLaunchFlowRecord = ____UnitSymbols_AttackStartToLaunchFlowRecord_12
	local ____UnitSymbols_OriginalBaseAttackRange_13 = UnitSymbols.OriginalBaseAttackRange
	if ____UnitSymbols_OriginalBaseAttackRange_13 == nil then
		____UnitSymbols_OriginalBaseAttackRange_13 = __TS__Symbol("UnitOriginalBaseAttackRange")
	end
	--- 单位原始攻击距离 number
	UnitSymbols.OriginalBaseAttackRange = ____UnitSymbols_OriginalBaseAttackRange_13
	local ____UnitSymbols_OriginalProjectileName_14 = UnitSymbols.OriginalProjectileName
	if ____UnitSymbols_OriginalProjectileName_14 == nil then
		____UnitSymbols_OriginalProjectileName_14 = __TS__Symbol("HeroOriginalProjectileName")
	end
	--- 单位原始攻击弹道名 string
	UnitSymbols.OriginalProjectileName = ____UnitSymbols_OriginalProjectileName_14
	local ____UnitSymbols_OriginalModelName_15 = UnitSymbols.OriginalModelName
	if ____UnitSymbols_OriginalModelName_15 == nil then
		____UnitSymbols_OriginalModelName_15 = __TS__Symbol("OriginalModelName")
	end
	--- 单位原始模型
	UnitSymbols.OriginalModelName = ____UnitSymbols_OriginalModelName_15
	local ____UnitSymbols_OriginalBaseAttackTime_16 = UnitSymbols.OriginalBaseAttackTime
	if ____UnitSymbols_OriginalBaseAttackTime_16 == nil then
		____UnitSymbols_OriginalBaseAttackTime_16 = __TS__Symbol("UnitOriginalBaseAttackTime")
	end
	--- 单位原始攻击间隔 number
	UnitSymbols.OriginalBaseAttackTime = ____UnitSymbols_OriginalBaseAttackTime_16
	local ____UnitSymbols_IsAsyncCreatedUnit_17 = UnitSymbols.IsAsyncCreatedUnit
	if ____UnitSymbols_IsAsyncCreatedUnit_17 == nil then
		____UnitSymbols_IsAsyncCreatedUnit_17 = __TS__Symbol("IsAsyncCreatedUnit")
	end
	--- 是否是异步创建的单位（会创建新的spawnhandlegroup）
	UnitSymbols.IsAsyncCreatedUnit = ____UnitSymbols_IsAsyncCreatedUnit_17
	local ____UnitSymbols_AsyncUnitRemoveListenTimer_18 = UnitSymbols.AsyncUnitRemoveListenTimer
	if ____UnitSymbols_AsyncUnitRemoveListenTimer_18 == nil then
		____UnitSymbols_AsyncUnitRemoveListenTimer_18 = __TS__Symbol("AsyncUnitRemoveListenTimer")
	end
	--- 异步创建的单位移除监听计时器
	UnitSymbols.AsyncUnitRemoveListenTimer = ____UnitSymbols_AsyncUnitRemoveListenTimer_18
	local ____UnitSymbols_IsPreventForceKill_19 = UnitSymbols.IsPreventForceKill
	if ____UnitSymbols_IsPreventForceKill_19 == nil then
		____UnitSymbols_IsPreventForceKill_19 = __TS__Symbol("IsPreventForceKill")
	end
	--- 是否阻止强制击杀 boolean
	UnitSymbols.IsPreventForceKill = ____UnitSymbols_IsPreventForceKill_19
	local ____UnitSymbols_StrikeCritAttack_AttackRecordOnLanded_20 = UnitSymbols.StrikeCritAttack_AttackRecordOnLanded
	if ____UnitSymbols_StrikeCritAttack_AttackRecordOnLanded_20 == nil then
		____UnitSymbols_StrikeCritAttack_AttackRecordOnLanded_20 = __TS__Symbol("StrikeCritAttack_AttackRecordOnLanded")
	end
	UnitSymbols.StrikeCritAttack_AttackRecordOnLanded = ____UnitSymbols_StrikeCritAttack_AttackRecordOnLanded_20
	local ____UnitSymbols_StrikeCritAttackDamageRecord_21 = UnitSymbols.StrikeCritAttackDamageRecord
	if ____UnitSymbols_StrikeCritAttackDamageRecord_21 == nil then
		____UnitSymbols_StrikeCritAttackDamageRecord_21 = __TS__Symbol("StrikeCritAttackRecord")
	end
	--- 攻击会心一击记录
	UnitSymbols.StrikeCritAttackDamageRecord = ____UnitSymbols_StrikeCritAttackDamageRecord_21
	local ____UnitSymbols_IsForbidCustomImmuneDeathDamage_22 = UnitSymbols.IsForbidCustomImmuneDeathDamage
	if ____UnitSymbols_IsForbidCustomImmuneDeathDamage_22 == nil then
		____UnitSymbols_IsForbidCustomImmuneDeathDamage_22 = __TS__Symbol("IsForbidCustomImmuneDeathDamage")
	end
	--- 是否处于禁用自定义免疫致死伤害的状态 boolean
	UnitSymbols.IsForbidCustomImmuneDeathDamage = ____UnitSymbols_IsForbidCustomImmuneDeathDamage_22
	local ____UnitSymbols_CustomImmuneDeathTriggeredCount_23 = UnitSymbols.CustomImmuneDeathTriggeredCount
	if ____UnitSymbols_CustomImmuneDeathTriggeredCount_23 == nil then
		____UnitSymbols_CustomImmuneDeathTriggeredCount_23 = __TS__Symbol("CustomImmuneDeathTriggeredCount")
	end
	--- 自定义免疫致死伤害的累计触发次数（单调递增，用于同步判断某次击杀是否被免疫致死拦截） number
	UnitSymbols.CustomImmuneDeathTriggeredCount = ____UnitSymbols_CustomImmuneDeathTriggeredCount_23
end
AbilitySymbols = AbilitySymbols or {}
do
	local ____AbilitySymbols_CustomCursorPoint_24 = AbilitySymbols.CustomCursorPoint
	if ____AbilitySymbols_CustomCursorPoint_24 == nil then
		____AbilitySymbols_CustomCursorPoint_24 = __TS__Symbol("AbilityCustomCursorPoint")
	end
	--- 技能自定义坐标记录 Vector
	AbilitySymbols.CustomCursorPoint = ____AbilitySymbols_CustomCursorPoint_24
	local ____AbilitySymbols_CustomRecord_25 = AbilitySymbols.CustomRecord
	if ____AbilitySymbols_CustomRecord_25 == nil then
		____AbilitySymbols_CustomRecord_25 = __TS__Symbol("AbilityCustomRecord")
	end
	--- 技能自定义记录
	AbilitySymbols.CustomRecord = ____AbilitySymbols_CustomRecord_25
end