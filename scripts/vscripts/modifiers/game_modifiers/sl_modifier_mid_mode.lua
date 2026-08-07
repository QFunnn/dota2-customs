--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 中路模式 英雄固有buff
____exports.sl_modifier_mid_mode_hero = __TS__Class()
local sl_modifier_mid_mode_hero = ____exports.sl_modifier_mid_mode_hero
sl_modifier_mid_mode_hero.name = "sl_modifier_mid_mode_hero"
__TS__ClassExtends(sl_modifier_mid_mode_hero, SLModifierBase)
function sl_modifier_mid_mode_hero.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._bonus_max_hp = 0
	self._bonus_max_mp = 0
	self._last_check_minute = 0
end
function sl_modifier_mid_mode_hero.prototype.IsHidden(self)
	return false
end
function sl_modifier_mid_mode_hero.prototype.GetTexture(self)
	return "buff/modifier_mid_buff"
end
function sl_modifier_mid_mode_hero.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	if parent:IsHero() then
		local extra_tp_count = 4
		do
			local index = 0
			while index < extra_tp_count do
				SLAddItemToHeroAndDropWhenInventoryFull("item_tpscroll", parent)
				index = index + 1
			end
		end
	end
	local setting = HTTP.setting:GetServerSet("gameBasic")
	self._bonus_tick = setting.MID_HERO_ATTR_BONUS_TICK
	self._bonus_hp_tick_record = TableDeepCopy(setting.MID_HERO_ATTR_BONUS_HP)
	self._bonus_mp_tick_record = TableDeepCopy(setting.MID_HERO_ATTR_BONUS_MP)
	local minuete = math.floor(GameRules:GetDOTATime(false, false) / 60)
	self._bonus_hp_per_tick = self:_UpdateBonusPerTickFromTable(self._bonus_hp_tick_record, minuete)
	self._bonus_mp_per_tick = self:_UpdateBonusPerTickFromTable(self._bonus_mp_tick_record, minuete)
	self:StartIntervalThink(self._bonus_tick)
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_mid_mode_hero.prototype._UpdateBonusPerTickFromTable(self, tb, current_minute)
	local max_minute
	for key in pairs(tb) do
		do
			local minute = tonumber(key)
			if minute > current_minute then
				goto __continue10
			end
			if max_minute == nil or minute > max_minute then
				max_minute = minute
			end
		end
		::__continue10::
	end
	local ____temp_1
	if max_minute ~= nil then
		local ____tb_max_minute_0 = tb[max_minute]
		if ____tb_max_minute_0 == nil then
			____tb_max_minute_0 = 0
		end
		____temp_1 = ____tb_max_minute_0
	else
		____temp_1 = 0
	end
	local current_value = ____temp_1
	local to_remove = {}
	for key in pairs(tb) do
		local minute = tonumber(key)
		if minute <= current_minute and minute ~= max_minute then
			to_remove[#to_remove + 1] = minute
		end
	end
	for ____, minute in ipairs(to_remove) do
		tb[minute] = nil
	end
	return current_value
end
function sl_modifier_mid_mode_hero.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local time = GameRules:GetDOTATime(false, false)
	if time <= 0 then
		return
	end
	local minuete = math.floor(time / 60)
	if minuete ~= self._last_check_minute then
		self._last_check_minute = minuete
		self._bonus_hp_per_tick = self:_UpdateBonusPerTickFromTable(self._bonus_hp_tick_record, minuete)
		self._bonus_mp_per_tick = self:_UpdateBonusPerTickFromTable(self._bonus_mp_tick_record, minuete)
	end
	self._bonus_max_hp = self._bonus_max_hp + self._bonus_hp_per_tick
	self._bonus_max_mp = self._bonus_max_mp + self._bonus_mp_per_tick
	self:SendBuffRefreshToClients()
end
function sl_modifier_mid_mode_hero.prototype.DeclareFunctions(self)
	return {
		MODIFIER_EVENT_ON_RESPAWN,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_mid_mode_hero.prototype.OnRespawn(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local unit = event.unit
	if IsValid(parent) and IsValid(unit) and parent == unit then
		local tp_scroll = parent:FindItemInInventory("item_tpscroll")
		if IsValid(tp_scroll) then
			tp_scroll:EndCooldown()
		end
	end
end
function sl_modifier_mid_mode_hero.prototype.AddCustomTransmitterData(self)
	return {
		hp = self._bonus_max_hp,
		mp = self._bonus_max_mp,
		bonus_tick = self._bonus_tick,
		bonus_hp_per_tick = self._bonus_hp_per_tick,
		bonus_mp_per_tick = self._bonus_mp_per_tick,
	}
end
function sl_modifier_mid_mode_hero.prototype.HandleCustomTransmitterData(self, data)
	self._bonus_max_hp = data.hp
	self._bonus_max_mp = data.mp
	self._bonus_tick = data.bonus_tick
	self._bonus_hp_per_tick = data.bonus_hp_per_tick
	self._bonus_mp_per_tick = data.bonus_mp_per_tick
end
function sl_modifier_mid_mode_hero.prototype.GetModifierHealthBonus(self)
	return self._bonus_max_hp
end
function sl_modifier_mid_mode_hero.prototype.GetModifierManaBonus(self)
	return self._bonus_max_mp
end
function sl_modifier_mid_mode_hero.prototype.OnTooltip(self)
	return self._bonus_hp_per_tick
end
function sl_modifier_mid_mode_hero.prototype.OnTooltip2(self)
	return self._bonus_mp_per_tick
end
sl_modifier_mid_mode_hero = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_mid_mode") },
	sl_modifier_mid_mode_hero
)
____exports.sl_modifier_mid_mode_hero = sl_modifier_mid_mode_hero
return ____exports