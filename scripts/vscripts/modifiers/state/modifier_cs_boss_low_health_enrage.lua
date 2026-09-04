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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- BOSS 低血量强化检查间隔
local BOSS_LOW_HEALTH_ENRAGE_INTERVAL = 0.1
--- 低于该生命百分比时触发强化
local BOSS_LOW_HEALTH_ENRAGE_THRESHOLD_PCT = 10
--- 触发后获得的减伤与攻击百分比
local BOSS_LOW_HEALTH_ENRAGE_BONUS_PCT = 10
--- BOSS 低血量强化：血量低于 10% 时获得 10% 减伤与 10% 全域攻击力加成。
____exports.modifier_cs_boss_low_health_enrage = __TS__Class()
local modifier_cs_boss_low_health_enrage = ____exports.modifier_cs_boss_low_health_enrage
modifier_cs_boss_low_health_enrage.name = "modifier_cs_boss_low_health_enrage"
__TS__ClassExtends(modifier_cs_boss_low_health_enrage, BaseModifier_CS)
function modifier_cs_boss_low_health_enrage.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._isEnraged = false
end
function modifier_cs_boss_low_health_enrage.prototype.IsHidden(self)
	return true
end
function modifier_cs_boss_low_health_enrage.prototype.IsDebuff(self)
	return false
end
function modifier_cs_boss_low_health_enrage.prototype.IsPurgable(self)
	return false
end
function modifier_cs_boss_low_health_enrage.prototype.IsPurgeException(self)
	return false
end
function modifier_cs_boss_low_health_enrage.prototype.IsPermanent(self)
	return true
end
function modifier_cs_boss_low_health_enrage.prototype.RemoveOnDeath(self)
	return true
end
function modifier_cs_boss_low_health_enrage.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshEnrageState(false)
	self:StartIntervalThink(BOSS_LOW_HEALTH_ENRAGE_INTERVAL)
end
function modifier_cs_boss_low_health_enrage.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RefreshEnrageState(true)
end
function modifier_cs_boss_low_health_enrage.prototype.GetAttributeBonus(self)
	if not self._isEnraged then
		return {}
	end
	return {
		damage_reduction_pct = BOSS_LOW_HEALTH_ENRAGE_BONUS_PCT,
		all_attack_damage_percent = BOSS_LOW_HEALTH_ENRAGE_BONUS_PCT,
	}
end
function modifier_cs_boss_low_health_enrage.prototype.RefreshEnrageState(self, shouldRefreshAttributes)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local maxHealth = math.max(1, parent:GetMaxHealth())
	local healthPct = parent:GetHealth() / maxHealth * 100
	local nextIsEnraged = healthPct < BOSS_LOW_HEALTH_ENRAGE_THRESHOLD_PCT
	if nextIsEnraged == self._isEnraged then
		return
	end
	self._isEnraged = nextIsEnraged
	if shouldRefreshAttributes then
		self:RefreshAttributes()
	end
end
modifier_cs_boss_low_health_enrage = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_cs_boss_low_health_enrage") },
	modifier_cs_boss_low_health_enrage
)
____exports.modifier_cs_boss_low_health_enrage = modifier_cs_boss_low_health_enrage
return ____exports