--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_mid_mode.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_mid_mode.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:40",
		["20"] = "8:48",
		["21"] = "53:5",
		["22"] = "54:5",
		["23"] = "55:5",
		["24"] = "7:1",
		["25"] = "9:5",
		["26"] = "10:9",
		["27"] = "9:5",
		["28"] = "13:5",
		["29"] = "14:9",
		["30"] = "13:5",
		["31"] = "23:5",
		["32"] = "24:14",
		["35"] = "25:15",
		["36"] = "27:14",
		["39"] = "35:13",
		["40"] = "37:19",
		["42"] = "38:22",
		["43"] = "38:33",
		["44"] = "39:17",
		["45"] = "38:57",
		["49"] = "42:15",
		["50"] = "43:9",
		["51"] = "44:9",
		["52"] = "45:9",
		["53"] = "46:15",
		["54"] = "47:9",
		["55"] = "48:9",
		["56"] = "49:9",
		["57"] = "50:9",
		["58"] = "23:5",
		["59"] = "57:5",
		["60"] = "58:13",
		["61"] = "59:20",
		["63"] = "60:19",
		["64"] = "61:17",
		["65"] = "61:42",
		["67"] = "62:17",
		["68"] = "63:17",
		["73"] = "66:31",
		["74"] = "66:31",
		["75"] = "66:58",
		["77"] = "66:58",
		["79"] = "66:58",
		["81"] = "66:80",
		["83"] = "66:15",
		["84"] = "67:15",
		["85"] = "68:20",
		["86"] = "69:19",
		["87"] = "70:17",
		["88"] = "71:17",
		["91"] = "74:9",
		["92"] = "75:13",
		["94"] = "77:9",
		["95"] = "57:5",
		["96"] = "80:5",
		["97"] = "81:14",
		["100"] = "83:15",
		["101"] = "85:13",
		["104"] = "86:15",
		["105"] = "89:13",
		["106"] = "90:13",
		["107"] = "91:13",
		["108"] = "92:13",
		["110"] = "94:9",
		["111"] = "95:9",
		["112"] = "97:9",
		["113"] = "80:5",
		["114"] = "100:5",
		["115"] = "101:9",
		["116"] = "101:16",
		["117"] = "101:16",
		["118"] = "101:16",
		["119"] = "101:16",
		["121"] = "101:16",
		["122"] = "100:5",
		["123"] = "112:5",
		["124"] = "113:14",
		["127"] = "114:15",
		["128"] = "115:15",
		["129"] = "116:13",
		["130"] = "118:19",
		["131"] = "119:17",
		["132"] = "120:17",
		["135"] = "112:5",
		["136"] = "125:5",
		["137"] = "126:9",
		["138"] = "127:13",
		["139"] = "128:13",
		["140"] = "129:13",
		["141"] = "130:13",
		["142"] = "131:13",
		["143"] = "126:16",
		["144"] = "125:5",
		["145"] = "135:5",
		["146"] = "136:9",
		["147"] = "137:9",
		["148"] = "138:9",
		["149"] = "139:9",
		["150"] = "140:9",
		["151"] = "135:5",
		["152"] = "143:5",
		["153"] = "144:9",
		["154"] = "143:5",
		["155"] = "147:5",
		["156"] = "148:9",
		["157"] = "147:5",
		["158"] = "151:5",
		["159"] = "152:9",
		["160"] = "151:5",
		["161"] = "155:5",
		["162"] = "156:9",
		["163"] = "155:5",
		["164"] = "8:14",
		["165"] = "7:2",
		["166"] = "7:2",
		["167"] = "7:19",
		["168"] = "7:2",
		["170"] = "7:2",
		["171"] = "8:14",
		["173"] = "8:14",
	}
)
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
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_mid_mode", nil, getfenv()) },
	sl_modifier_mid_mode_hero
)
____exports.sl_modifier_mid_mode_hero = sl_modifier_mid_mode_hero
return ____exports