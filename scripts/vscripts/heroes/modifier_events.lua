--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[
	Глобальный диспетчер MODIFIER_EVENT_ON_*.

	Движок шлёт эти события всем модификаторам, объявившим их. Здесь они объявлены
	один раз, дальше — лукап по участникам события и вызов только подписчиков,
	с разделением source/target.

	Подписка: AddModifierEvents(iEvent, hModifier, hSource, hTarget)
	(utils/utility_functions.lua) -> hSource.tSourceModifierEvents /
	hTarget.tTargetModifierEvents / _G.tModifierEvents.
	Имя метода = имя события: ON_ABILITY_FULLY_CAST -> OnAbilityFullyCast.

	ИНВАРИАНТ: должен висеть на сущности (MODIFIER_EVENTS_DUMMY,
	core/gamemode/gamemode_spawn_units.lua). Без носителя диспатча нет — молча,
	без ошибок и варнингов.

	Те же таблицы читает CDOTA_BaseNPC:Attack (utils/cdota_base_npc.lua),
	вызывая методы с суффиксом _AttackSystem.
]]

if modifier_events == nil then
	modifier_events = class({})
end

local public = modifier_events

function public:IsHidden()
	return true
end
function public:IsDebuff()
	return false
end
function public:IsPurgable()
	return false
end
function public:IsPurgeException()
	return false
end
function public:AllowIllusionDuplicate()
	return false
end
function public:RemoveOnDeath()
	return false
end
function public:DestroyOnExpire()
	return false
end
function public:IsPermanent()
	return true
end
function public:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function public:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_SPELL_TARGET_READY,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_EVENT_ON_ATTACK_ALLIED,
		-- MODIFIER_EVENT_ON_PROJECTILE_DODGE,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_EVENT_ON_UNIT_MOVED,
		MODIFIER_EVENT_ON_ABILITY_START,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		-- MODIFIER_EVENT_ON_BREAK_INVISIBILITY,
		MODIFIER_EVENT_ON_ABILITY_END_CHANNEL,
		-- MODIFIER_EVENT_ON_PROCESS_UPGRADE,
		-- MODIFIER_EVENT_ON_REFRESH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_STATE_CHANGED,
		-- MODIFIER_EVENT_ON_ORB_EFFECT,
		-- MODIFIER_EVENT_ON_PROCESS_CLEAVE,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_RESPAWN,
		MODIFIER_EVENT_ON_SPENT_MANA,
		MODIFIER_EVENT_ON_TELEPORTING,
		MODIFIER_EVENT_ON_TELEPORTED,
		-- MODIFIER_EVENT_ON_SET_LOCATION,
		MODIFIER_EVENT_ON_HEALTH_GAINED,
		MODIFIER_EVENT_ON_MANA_GAINED,
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,
		MODIFIER_EVENT_ON_HERO_KILLED,
		MODIFIER_EVENT_ON_HEAL_RECEIVED,
		-- MODIFIER_EVENT_ON_BUILDING_KILLED,
		-- MODIFIER_EVENT_ON_MODEL_CHANGED,
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
		-- MODIFIER_EVENT_ON_DOMINATED,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		-- MODIFIER_EVENT_ON_PROJECTILE_OBSTRUCTION_HIT,
		MODIFIER_EVENT_ON_ATTACK_CANCELLED,
	}
end

---Вызывает sMethod у всех подписчиков из списка, попутно вычищая невалидные.
---hHolder перепроверяется на каждой итерации: обработчик может уничтожить юнита,
---и остальные подписчики не должны вызываться на уже невалидной сущности.
---@param hHolder CDOTA_BaseNPC? владелец списка; nil для глобального бакета
---@param tModifiers table?
---@param sMethod string
local function DispatchTo(hHolder, tModifiers, sMethod, params)
	if not tModifiers then
		return
	end

	for i = #tModifiers, 1, -1 do
		local hModifier = tModifiers[i]
		local holderAlive = hHolder == nil or IsValid(hHolder)
		if holderAlive and IsValid(hModifier) and hModifier[sMethod] then
			hModifier[sMethod](hModifier, params)
		else
			table.remove(tModifiers, i)
		end
	end
end

---Раздаёт событие подписчикам источника, цели и глобальным.
---@param iEvent integer
---@param sMethod string
---@param sSource string? поле params с источником ("unit" | "attacker")
---@param sTarget string? поле params с целью ("target" | "unit")
local function Fanout(params, iEvent, sMethod, sSource, sTarget)
	local hSource = sSource and params[sSource]
	if IsValid(hSource) and hSource.tSourceModifierEvents then
		DispatchTo(hSource, hSource.tSourceModifierEvents[iEvent], sMethod, params)
	end

	local hTarget = sTarget and params[sTarget]
	if IsValid(hTarget) and hTarget.tTargetModifierEvents then
		DispatchTo(hTarget, hTarget.tTargetModifierEvents[iEvent], sMethod, params)
	end

	if tModifierEvents then
		DispatchTo(nil, tModifierEvents[iEvent], sMethod, params)
	end
end

function public:OnSpellTargetReady(params)
	Fanout(params, MODIFIER_EVENT_ON_SPELL_TARGET_READY, "OnSpellTargetReady", "unit", "target")
end

function public:OnAttackRecord(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_RECORD, "OnAttackRecord", "attacker", "target")
end

function public:OnAttackStart(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_START, "OnAttackStart", "attacker", "target")
end

function public:OnAttack(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK, "OnAttack", "attacker", "target")
end

function public:OnAttackLanded(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_LANDED, "OnAttackLanded", "attacker", "target")
end

function public:OnAttackFail(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_FAIL, "OnAttackFail", "attacker", "target")
end

function public:OnAttackAllied(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_ALLIED, "OnAttackAllied", "attacker", "target")
end

function public:OnProjectileDodge(params)
	Fanout(params, MODIFIER_EVENT_ON_PROJECTILE_DODGE, "OnProjectileDodge")
end

function public:OnOrder(params)
	Fanout(params, MODIFIER_EVENT_ON_ORDER, "OnOrder", "unit", "target")
end

function public:OnUnitMoved(params)
	Fanout(params, MODIFIER_EVENT_ON_UNIT_MOVED, "OnUnitMoved", "unit")
end

function public:OnAbilityStart(params)
	Fanout(params, MODIFIER_EVENT_ON_ABILITY_START, "OnAbilityStart", "unit", "target")
end

function public:OnAbilityExecuted(params)
	Fanout(params, MODIFIER_EVENT_ON_ABILITY_EXECUTED, "OnAbilityExecuted", "unit", "target")
end

function public:OnAbilityFullyCast(params)
	Fanout(params, MODIFIER_EVENT_ON_ABILITY_FULLY_CAST, "OnAbilityFullyCast", "unit", "target")
end

function public:OnBreakInvisibility(params)
	Fanout(params, MODIFIER_EVENT_ON_BREAK_INVISIBILITY, "OnBreakInvisibility")
end

function public:OnAbilityEndChannel(params)
	Fanout(params, MODIFIER_EVENT_ON_ABILITY_END_CHANNEL, "OnAbilityEndChannel", "unit", "target")
end

function public:OnTakeDamage(params)
	Fanout(params, MODIFIER_EVENT_ON_TAKEDAMAGE, "OnTakeDamage", "attacker", "unit")
end

function public:OnStateChanged(params)
	Fanout(params, MODIFIER_EVENT_ON_STATE_CHANGED, "OnStateChanged", "unit")
end

function public:OnProcessCleave(params)
	Fanout(params, MODIFIER_EVENT_ON_PROCESS_CLEAVE, "OnProcessCleave")
end

function public:OnDamageCalculated(params)
	Fanout(params, MODIFIER_EVENT_ON_DAMAGE_CALCULATED, "OnDamageCalculated", "attacker", "target")
end

function public:OnAttacked(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACKED, "OnAttacked", "attacker", "target")
end

function public:OnDeath(params)
	Fanout(params, MODIFIER_EVENT_ON_DEATH, "OnDeath", "attacker", "unit")
end

function public:OnRespawn(params)
	Fanout(params, MODIFIER_EVENT_ON_RESPAWN, "OnRespawn", "unit")
end

function public:OnSpentMana(params)
	Fanout(params, MODIFIER_EVENT_ON_SPENT_MANA, "OnSpentMana", "unit")
end

function public:OnTeleporting(params)
	Fanout(params, MODIFIER_EVENT_ON_TELEPORTING, "OnTeleporting", "unit")
end

function public:OnTeleported(params)
	Fanout(params, MODIFIER_EVENT_ON_TELEPORTED, "OnTeleported", "unit")
end

function public:OnSetLocation(params)
	Fanout(params, MODIFIER_EVENT_ON_SET_LOCATION, "OnSetLocation")
end

function public:OnHealthGained(params)
	Fanout(params, MODIFIER_EVENT_ON_HEALTH_GAINED, "OnHealthGained", "unit")
end

function public:OnManaGained(params)
	Fanout(params, MODIFIER_EVENT_ON_MANA_GAINED, "OnManaGained", "unit")
end

function public:OnTakeDamageKillCredit(params)
	Fanout(params, MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT, "OnTakeDamageKillCredit", "attacker", "target")
end

function public:OnHeroKilled(params)
	Fanout(params, MODIFIER_EVENT_ON_HERO_KILLED, "OnHeroKilled", "unit", "target")
end

function public:OnHealReceived(params)
	Fanout(params, MODIFIER_EVENT_ON_HEAL_RECEIVED, "OnHealReceived", "unit")
end

function public:OnBuildingKilled(params)
	Fanout(params, MODIFIER_EVENT_ON_BUILDING_KILLED, "OnBuildingKilled")
end

function public:OnModelChanged(params)
	Fanout(params, MODIFIER_EVENT_ON_MODEL_CHANGED, "OnModelChanged")
end

function public:OnModifierAdded(params)
	Fanout(params, MODIFIER_EVENT_ON_MODIFIER_ADDED, "OnModifierAdded", "unit")
end

function public:OnDominated(params)
	Fanout(params, MODIFIER_EVENT_ON_DOMINATED, "OnDominated")
end

function public:OnAttackFinished(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_FINISHED, "OnAttackFinished", "attacker", "target")
end

function public:OnAttackRecordDestroy(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY, "OnAttackRecordDestroy", "attacker", "target")
end

function public:OnProjectileObstructionHit(params)
	Fanout(params, MODIFIER_EVENT_ON_PROJECTILE_OBSTRUCTION_HIT, "OnProjectileObstructionHit")
end

function public:OnAttackCancelled(params)
	Fanout(params, MODIFIER_EVENT_ON_ATTACK_CANCELLED, "OnAttackCancelled", "attacker", "target")
end
