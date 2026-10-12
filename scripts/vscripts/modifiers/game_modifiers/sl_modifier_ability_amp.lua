--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_ability_amp.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_ability_amp.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:7",
		["16"] = "9:1",
		["17"] = "10:14",
		["18"] = "9:1",
		["19"] = "10:38",
		["21"] = "10:46",
		["22"] = "26:5",
		["23"] = "61:5",
		["24"] = "62:5",
		["25"] = "63:5",
		["26"] = "64:9",
		["27"] = "65:9",
		["28"] = "66:9",
		["29"] = "67:9",
		["30"] = "68:9",
		["31"] = "63:61",
		["32"] = "273:5",
		["33"] = "291:5",
		["34"] = "371:5",
		["35"] = "373:9",
		["36"] = "374:17",
		["37"] = "374:38",
		["39"] = "375:13",
		["40"] = "373:34",
		["41"] = "377:9",
		["42"] = "378:17",
		["43"] = "378:38",
		["45"] = "379:13",
		["46"] = "377:38",
		["47"] = "381:9",
		["48"] = "371:128",
		["49"] = "433:5",
		["50"] = "458:5",
		["51"] = "9:1",
		["52"] = "17:5",
		["53"] = "18:15",
		["54"] = "19:9",
		["55"] = "17:5",
		["56"] = "28:5",
		["57"] = "29:9",
		["58"] = "28:5",
		["59"] = "33:5",
		["60"] = "34:14",
		["63"] = "35:15",
		["64"] = "36:15",
		["65"] = "37:15",
		["66"] = "39:9",
		["67"] = "41:9",
		["68"] = "42:9",
		["69"] = "43:9",
		["70"] = "33:5",
		["71"] = "48:5",
		["72"] = "49:9",
		["73"] = "50:20",
		["74"] = "51:19",
		["75"] = "52:13",
		["76"] = "53:24",
		["77"] = "54:17",
		["80"] = "57:9",
		["81"] = "48:5",
		["82"] = "71:5",
		["83"] = "72:14",
		["84"] = "72:32",
		["86"] = "73:13",
		["87"] = "73:69",
		["89"] = "74:13",
		["90"] = "74:73",
		["92"] = "75:9",
		["93"] = "71:5",
		["94"] = "78:5",
		["95"] = "79:9",
		["96"] = "78:5",
		["97"] = "86:5",
		["98"] = "87:14",
		["101"] = "89:15",
		["102"] = "90:14",
		["103"] = "90:14",
		["104"] = "90:14",
		["106"] = "90:14",
		["107"] = "90:14",
		["108"] = "90:14",
		["110"] = "90:14",
		["113"] = "91:13",
		["116"] = "93:9",
		["117"] = "94:9",
		["118"] = "86:5",
		["119"] = "100:5",
		["120"] = "104:9",
		["121"] = "104:9",
		["123"] = "106:14",
		["124"] = "106:32",
		["126"] = "107:52",
		["127"] = "107:17",
		["128"] = "107:35",
		["129"] = "109:13",
		["130"] = "111:13",
		["131"] = "112:19",
		["132"] = "113:22",
		["134"] = "113:22",
		["136"] = "113:13",
		["138"] = "116:13",
		["139"] = "117:17",
		["140"] = "118:17",
		["142"] = "120:17",
		["145"] = "124:9",
		["146"] = "100:5",
		["147"] = "127:5",
		["148"] = "129:14",
		["151"] = "130:9",
		["152"] = "131:9",
		["153"] = "127:5",
		["154"] = "134:5",
		["155"] = "136:14",
		["158"] = "137:9",
		["159"] = "138:9",
		["160"] = "134:5",
		["161"] = "141:5",
		["162"] = "142:15",
		["163"] = "143:13",
		["164"] = "144:17",
		["165"] = "145:32",
		["167"] = "145:32",
		["169"] = "145:23",
		["170"] = "146:17",
		["171"] = "147:17",
		["174"] = "150:13",
		["175"] = "151:17",
		["176"] = "157:17",
		["179"] = "160:9",
		["180"] = "141:5",
		["181"] = "163:5",
		["182"] = "180:15",
		["183"] = "182:15",
		["184"] = "183:14",
		["185"] = "183:19",
		["187"] = "185:15",
		["188"] = "187:13",
		["189"] = "201:13",
		["192"] = "204:17",
		["193"] = "206:19",
		["194"] = "209:17",
		["195"] = "211:23",
		["196"] = "213:21",
		["197"] = "214:21",
		["200"] = "217:19",
		["201"] = "218:19",
		["202"] = "219:19",
		["203"] = "225:19",
		["204"] = "227:17",
		["205"] = "228:17",
		["206"] = "229:17",
		["207"] = "230:17",
		["209"] = "232:17",
		["211"] = "239:13",
		["213"] = "163:5",
		["214"] = "248:5",
		["215"] = "249:15",
		["216"] = "250:14",
		["217"] = "250:14",
		["218"] = "250:14",
		["220"] = "250:14",
		["221"] = "250:76",
		["223"] = "252:15",
		["224"] = "253:13",
		["225"] = "253:33",
		["227"] = "255:15",
		["228"] = "256:13",
		["229"] = "256:35",
		["231"] = "258:16",
		["232"] = "264:15",
		["233"] = "265:9",
		["234"] = "248:5",
		["235"] = "275:5",
		["236"] = "276:9",
		["237"] = "276:9",
		["239"] = "281:13",
		["240"] = "282:13",
		["242"] = "284:13",
		["244"] = "275:5",
		["245"] = "293:5",
		["246"] = "294:15",
		["247"] = "295:15",
		["248"] = "296:9",
		["249"] = "293:5",
		["250"] = "300:5",
		["251"] = "301:14",
		["254"] = "303:15",
		["255"] = "304:14",
		["258"] = "305:13",
		["259"] = "306:20",
		["260"] = "307:19",
		["261"] = "308:19",
		["262"] = "309:19",
		["263"] = "310:17",
		["264"] = "311:17",
		["265"] = "312:17",
		["266"] = "312:17",
		["267"] = "313:17",
		["270"] = "316:13",
		["271"] = "318:13",
		["272"] = "319:13",
		["274"] = "300:5",
		["275"] = "323:5",
		["276"] = "324:9",
		["277"] = "325:9",
		["278"] = "323:5",
		["279"] = "328:5",
		["280"] = "329:15",
		["281"] = "330:9",
		["282"] = "331:13",
		["284"] = "333:9",
		["285"] = "334:9",
		["286"] = "328:5",
		["287"] = "337:5",
		["288"] = "338:14",
		["291"] = "339:9",
		["292"] = "339:9",
		["294"] = "344:20",
		["295"] = "345:19",
		["296"] = "346:19",
		["297"] = "347:13",
		["299"] = "350:9",
		["300"] = "337:5",
		["301"] = "357:5",
		["302"] = "358:15",
		["303"] = "359:15",
		["304"] = "360:13",
		["305"] = "361:17",
		["306"] = "364:17",
		["309"] = "367:9",
		["310"] = "357:5",
		["311"] = "384:5",
		["312"] = "385:15",
		["313"] = "386:15",
		["314"] = "388:14",
		["315"] = "388:68",
		["317"] = "390:30",
		["318"] = "390:30",
		["319"] = "390:30",
		["321"] = "390:15",
		["322"] = "391:13",
		["323"] = "392:13",
		["325"] = "395:17",
		["326"] = "396:19",
		["327"] = "397:24",
		["329"] = "398:23",
		["330"] = "399:21",
		["331"] = "399:50",
		["333"] = "400:32",
		["334"] = "400:17",
		["338"] = "403:13",
		["339"] = "403:13",
		["340"] = "403:13",
		["342"] = "404:13",
		["343"] = "407:13",
		["345"] = "384:5",
		["346"] = "413:5",
		["347"] = "414:9",
		["348"] = "413:5",
		["349"] = "417:5",
		["350"] = "418:13",
		["351"] = "419:19",
		["352"] = "420:18",
		["353"] = "421:17",
		["356"] = "424:9",
		["357"] = "425:9",
		["358"] = "427:9",
		["359"] = "428:9",
		["360"] = "429:9",
		["361"] = "417:5",
		["362"] = "436:5",
		["363"] = "438:13",
		["366"] = "440:13",
		["367"] = "441:13",
		["369"] = "444:13",
		["370"] = "444:51",
		["371"] = "444:71",
		["372"] = "445:22",
		["375"] = "446:21",
		["376"] = "447:21",
		["377"] = "448:21",
		["379"] = "450:21",
		["381"] = "444:71",
		["382"] = "444:32",
		["384"] = "436:5",
		["385"] = "459:5",
		["386"] = "461:9",
		["387"] = "464:9",
		["388"] = "465:9",
		["389"] = "459:5",
		["390"] = "468:5",
		["391"] = "469:15",
		["392"] = "470:14",
		["393"] = "470:41",
		["395"] = "471:13",
		["396"] = "472:13",
		["398"] = "474:9",
		["399"] = "468:5",
		["400"] = "477:5",
		["401"] = "478:9",
		["402"] = "479:9",
		["403"] = "477:5",
		["404"] = "482:5",
		["405"] = "483:15",
		["406"] = "484:13",
		["407"] = "485:13",
		["408"] = "486:13",
		["409"] = "483:36",
		["410"] = "488:9",
		["411"] = "482:5",
		["412"] = "491:5",
		["413"] = "493:52",
		["414"] = "493:17",
		["415"] = "493:26",
		["416"] = "494:9",
		["417"] = "495:13",
		["418"] = "496:13",
		["419"] = "497:20",
		["420"] = "498:13",
		["422"] = "500:9",
		["423"] = "491:5",
		["424"] = "505:5",
		["425"] = "507:75",
		["426"] = "507:17",
		["427"] = "507:26",
		["428"] = "507:49",
		["429"] = "508:9",
		["430"] = "509:15",
		["431"] = "510:30",
		["432"] = "510:30",
		["433"] = "510:30",
		["435"] = "510:30",
		["436"] = "510:30",
		["437"] = "510:30",
		["439"] = "510:15",
		["440"] = "511:13",
		["441"] = "515:13",
		["443"] = "517:19",
		["444"] = "519:20",
		["445"] = "526:19",
		["446"] = "527:19",
		["447"] = "529:13",
		["448"] = "529:13",
		["449"] = "529:13",
		["451"] = "530:13",
		["452"] = "530:13",
		["453"] = "530:13",
		["455"] = "531:13",
		["456"] = "533:13",
		["458"] = "505:5",
		["459"] = "10:14",
		["460"] = "9:2",
		["461"] = "9:2",
		["462"] = "9:19",
		["463"] = "9:2",
		["465"] = "9:2",
		["466"] = "10:14",
		["468"] = "10:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ABILITY_DAMAGE_SPECIAL_KEY = "AbilityDamage"
--- 技能增强buff
____exports.sl_modifier_ability_amp = __TS__Class()
local sl_modifier_ability_amp = ____exports.sl_modifier_ability_amp
sl_modifier_ability_amp.name = "sl_modifier_ability_amp"
__TS__ClassExtends(sl_modifier_ability_amp, SLModifierBase)
function sl_modifier_ability_amp.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._need_send_amp_record = false
	self._special_record = {}
	self._native_ability_damage_override_warning_record = {}
	self._special_record_refuse_list = {
		item_tpscroll = true,
		ability_capture = true,
		abyssal_underlord_portal_warp = true,
		twin_gate_portal_warp = true,
		ability_lamp_use = true,
	}
	self._special_attr_cached_table = {}
	self._attr_cached_send_keys = {}
	self._special_attr_calc_cb = {
		jnfw = function(____, original_value, attr)
			if original_value == 0 then
				return 0
			end
			return attr
		end,
		jnfwI = function(____, original_value, attr)
			if original_value == 0 then
				return 0
			end
			return original_value * (attr / 100)
		end,
		cfdjshI = function(____, original_value, attr)
			return original_value * (attr / 100)
		end,
	}
	self._min_interval = StaticFrameTime
	self._transmitter_counts = 0
end
function sl_modifier_ability_amp.prototype._FixedNumber(self, num, decimalPlaces)
	local multiplier = 10 ^ decimalPlaces
	return (math.floor(num * multiplier + 0.5) or 0) / multiplier
end
function sl_modifier_ability_amp.prototype._InitAbilityAmpRecord(self)
	self._amp_record = {}
end
function sl_modifier_ability_amp.prototype.RefreshPlayerAbilityAmp(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local player_id = parent:GetPlayerOwnerID()
	local record = SLModules.AbilityAmp:GetAbilityValueTableByPlayerID(player_id)
	self._amp_record = record
	self:_RefreshAmpCache()
	self._need_send_amp_record = true
	self:_QueueSendBuffRefreshToClients()
end
function sl_modifier_ability_amp.prototype._RefreshAmpCache(self)
	self._amp_cache = {}
	for key in pairs(self._amp_record) do
		local ability_name = key
		self._amp_cache[ability_name] = {}
		for special_key in pairs(self._amp_record[ability_name]) do
			self._amp_cache[ability_name][special_key] = {}
		end
	end
	self._total_cached_table = {}
end
function sl_modifier_ability_amp.prototype._FilterSpecialRecord(self, ability)
	if not IsValid(ability) then
		return false
	end
	if ability.IsAttributeBonus and ability:IsAttributeBonus() then
		return false
	end
	if self._special_record_refuse_list[ability:GetAbilityName()] then
		return false
	end
	return true
end
function sl_modifier_ability_amp.prototype.GetSpecialRecord(self)
	return self._special_record
end
function sl_modifier_ability_amp.prototype._WarnIfNativeAbilityDamageOverrideDetected(self, ability, special_key)
	if not IsServer() or special_key ~= ABILITY_DAMAGE_SPECIAL_KEY then
		return
	end
	local ability_name = ability:GetAbilityName()
	local ____table__amp_record_ability_name_2 = self._amp_record
	if ____table__amp_record_ability_name_2 ~= nil then
		____table__amp_record_ability_name_2 = ____table__amp_record_ability_name_2[ability_name]
	end
	local ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 = ____table__amp_record_ability_name_2
	if ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 ~= nil then
		____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 =
			____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0[ABILITY_DAMAGE_SPECIAL_KEY]
	end
	if not ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_0 then
		return
	end
	if self._native_ability_damage_override_warning_record[ability_name] then
		return
	end
	self._native_ability_damage_override_warning_record[ability_name] = true
	SLError(
		"[AbilityDamageAmp][VALVE_NATIVE_OVERRIDE_DETECTED] 引擎已通过 modifier special value override 请求 "
			.. ((ability_name .. ".") .. ABILITY_DAMAGE_SPECIAL_KEY)
			.. "。当前 DamageFilter 补偿可能重复增伤，请立即复测并评估移除补偿。",
		nil,
		"modifiers/game_modifiers/sl_modifier_ability_amp.ts:94:9"
	)
end
function sl_modifier_ability_amp.prototype._CalculateAmpValueByType(
	self,
	amp_config,
	____type,
	target_level,
	default_value
)
	if default_value == nil then
		default_value = 0
	end
	if not amp_config[____type] then
		return default_value
	end
	local ____amp_config_____type_4 = amp_config[____type]
	local all_level_values = ____amp_config_____type_4.all_level_values
	local level_values = ____amp_config_____type_4.level_values
	local result = ____type == "c" and 0 or default_value
	if level_values and #level_values > 0 then
		local max_level = math.min(#level_values, target_level) - 1
		local ____level_values_index_5 = level_values[max_level + 1]
		if ____level_values_index_5 == nil then
			____level_values_index_5 = result
		end
		result = ____level_values_index_5
	end
	if all_level_values then
		if ____type == "c" then
			result = math.max(result, all_level_values)
		else
			result = result + all_level_values
		end
	end
	return result
end
function sl_modifier_ability_amp.prototype._AddCustomTransmitterDataForAbilityAmp(self)
	if not self._need_send_amp_record then
		return
	end
	self._need_send_amp_record = false
	return self._amp_record
end
function sl_modifier_ability_amp.prototype._HandleCustomTransmitterDataForAbilityAmp(self, data)
	if not data then
		return
	end
	self._amp_record = data
	self:_RefreshAmpCache()
end
function sl_modifier_ability_amp.prototype._FilterSpecialValueForAbilityAmp(self, ability, special_key)
	local ability_name = ability:GetAbilityName()
	if IsInToolsMode() then
		if self:_FilterSpecialRecord(ability) then
			local ____self__special_record_ability_name_6 = self._special_record[ability_name]
			if ____self__special_record_ability_name_6 == nil then
				____self__special_record_ability_name_6 = {}
			end
			local record = ____self__special_record_ability_name_6
			record[special_key] = true
			self._special_record[ability_name] = record
		end
	end
	if self._amp_record[ability_name] then
		if self._amp_record[ability_name][special_key] then
			return true
		end
	end
	return false
end
function sl_modifier_ability_amp.prototype._GetTotalBonusValueForAbilityAmp(
	self,
	ability,
	special_level,
	special_key,
	original_value
)
	local ability_name = ability:GetAbilityName()
	local cfg = self._amp_record[ability_name] and self._amp_record[ability_name][special_key]
	if not cfg then
		return original_value, 0
	end
	local cached_table = self._amp_cache[ability_name][special_key][special_level]
	if cached_table ~= nil and cached_table.original == original_value then
		return cached_table.override_origin, cached_table.cached
	else
		--- 目标等级（1=1级）
		local target_level = special_level + 1
		local ability_current_level = ability:GetLevel()
		if ability_current_level > target_level then
			local original_value_for_current =
				ability:GetLevelSpecialValueNoOverride(special_key, ability_current_level)
			if original_value_for_current == original_value then
				target_level = ability_current_level
			end
		end
		local actual_base = self:_CalculateAmpValueByType(cfg, "c", target_level, original_value)
		local actual_constant_bonus = self:_CalculateAmpValueByType(cfg, "b", target_level, 0)
		local actual_percent_bonus = self:_CalculateAmpValueByType(cfg, "a", target_level, 0)
		local total_bonus = self:_FixedNumber(actual_constant_bonus + actual_base * (actual_percent_bonus / 100), 2)
		if cached_table ~= nil then
			cached_table.cached = total_bonus
			cached_table.original = original_value
			cached_table.override_origin = actual_base
		else
			self._amp_cache[ability_name][special_key][special_level] =
				{ cached = total_bonus, original = original_value, override_origin = actual_base }
		end
		return actual_base, total_bonus
	end
end
function sl_modifier_ability_amp.prototype.GetAbilityDamageAmpFactor(self, ability)
	local ability_name = ability:GetAbilityName()
	local ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 = self._amp_record[ability_name]
	if ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 ~= nil then
		____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 =
			____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7[ABILITY_DAMAGE_SPECIAL_KEY]
	end
	if not ____table__amp_record_ability_name_ABILITY_DAMAGE_SPECIAL_KEY_7 then
		return nil
	end
	local ability_level = ability:GetLevel()
	if ability_level <= 0 then
		return nil
	end
	local original_damage = ability:GetAbilityDamage()
	if original_damage <= 0 then
		return nil
	end
	local override_origin, amp_bonus =
		self:_GetTotalBonusValueForAbilityAmp(ability, ability_level - 1, ABILITY_DAMAGE_SPECIAL_KEY, original_damage)
	local modified_damage = math.max(override_origin + amp_bonus, 0)
	return modified_damage / original_damage
end
function sl_modifier_ability_amp.prototype._InitSpecialAttrOnCreated(self)
	if self._attr_value == nil then
		self._attr_value = { jnfw = 0, jnfwI = 0, cfdjshI = 0 }
	end
	if IsServer() then
		self._special_attr_relation_map = KvData.special_attr_kv_relation_map
	else
		self._special_attr_relation_map = CustomNetTables:GetTableValue("kv_data", "special_attr_kv_relation_map")
	end
end
function sl_modifier_ability_amp.prototype._GetPlayerAttrManager(self)
	local parent = self:GetParent()
	local player_id = parent:GetPlayerOwnerID()
	return GlobalAttrManager:Get(player_id)
end
function sl_modifier_ability_amp.prototype.RefreshSpecialAttr(self)
	if not IsServer() then
		return
	end
	local attr_manager = self:_GetPlayerAttrManager()
	if not attr_manager then
		return
	end
	local need_send = false
	for key in pairs(self._attr_value) do
		local attr_name = key
		local attr_value = self._attr_value[attr_name]
		local current_value = attr_manager:GetAttr(attr_name)
		if attr_value ~= current_value then
			self._attr_value[attr_name] = current_value
			local ____self__attr_cached_send_keys_9 = self._attr_cached_send_keys
			____self__attr_cached_send_keys_9[#____self__attr_cached_send_keys_9 + 1] = attr_name
			need_send = true
		end
	end
	if need_send then
		self:_RefreshSpecialAttrCache()
		self:_QueueSendBuffRefreshToClients()
	end
end
function sl_modifier_ability_amp.prototype._RefreshSpecialAttrCache(self)
	self._special_attr_cached_table = {}
	self._total_cached_table = {}
end
function sl_modifier_ability_amp.prototype._AddCustomTransmitterDataForSpecialAttr(self)
	local data = {}
	for ____, key in ipairs(self._attr_cached_send_keys) do
		data[key] = self._attr_value[key]
	end
	self._attr_cached_send_keys = {}
	return data
end
function sl_modifier_ability_amp.prototype._HandleCustomTransmitterDataForSpecialAttr(self, data)
	if not data then
		return
	end
	if self._attr_value == nil then
		self._attr_value = { jnfw = 0, jnfwI = 0, cfdjshI = 0 }
	end
	for key in pairs(data) do
		local attr_name = key
		local attr_value = data[attr_name]
		self._attr_value[attr_name] = attr_value
	end
	self:_RefreshSpecialAttrCache()
end
function sl_modifier_ability_amp.prototype._FilterSpecialValueForSpecialAttr(self, ability, special_key)
	local ability_name = ability:GetAbilityName()
	local map = self._special_attr_relation_map[ability_name]
	if map then
		if map[special_key] ~= nil then
			return true
		end
	end
	return false
end
function sl_modifier_ability_amp.prototype._GetTotalBonusValueForSpecialAttr(self, ability, special_key, original_value)
	local map = self._special_attr_relation_map
	local ability_name = ability:GetAbilityName()
	if not map[ability_name] or not map[ability_name][special_key] then
		return 0
	end
	local ____table__special_attr_cached_table_ability_name_special_key_10 =
		self._special_attr_cached_table[ability_name]
	if ____table__special_attr_cached_table_ability_name_special_key_10 ~= nil then
		____table__special_attr_cached_table_ability_name_special_key_10 =
			____table__special_attr_cached_table_ability_name_special_key_10[special_key]
	end
	local cached_value = ____table__special_attr_cached_table_ability_name_special_key_10
	if cached_value then
		return cached_value
	else
		local total_bonus = 0
		local relation_attrs = map[ability_name][special_key]
		for key in pairs(relation_attrs) do
			do
				local attr = key
				if self._attr_value[attr] == 0 then
					goto __continue78
				end
				local ____self_12 = self._special_attr_calc_cb
				total_bonus = total_bonus + ____self_12[attr](____self_12, original_value, self._attr_value[attr])
			end
			::__continue78::
		end
		local ____self__special_attr_cached_table_13, ____ability_name_14 =
			self._special_attr_cached_table, ability_name
		if ____self__special_attr_cached_table_13[____ability_name_14] == nil then
			____self__special_attr_cached_table_13[____ability_name_14] = {}
		end
		self._special_attr_cached_table[ability_name][special_key] = total_bonus
		return total_bonus
	end
end
function sl_modifier_ability_amp.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE }
end
function sl_modifier_ability_amp.prototype.OnCreated(self, params)
	if IsServer() then
		local parent = self:GetParent()
		if not parent:IsRealHero() then
			SLError(
				"sl_modifier_ability_amp: 只有真英雄才能添加技能增强修饰器",
				nil,
				"modifiers/game_modifiers/sl_modifier_ability_amp.ts:421:17"
			)
		end
	end
	self:_InitAbilityAmpRecord()
	self:_InitSpecialAttrOnCreated()
	self:SetHasCustomTransmitterData(true)
	self:RefreshPlayerAbilityAmp()
	self:RefreshSpecialAttr()
end
function sl_modifier_ability_amp.prototype._QueueSendBuffRefreshToClients(self)
	if Timers:IsValid(self._send_timer) then
		return
	end
	if self:_CanSendBuff() then
		self:_SendBuffRefreshToClientsAndRecord()
	else
		self._send_timer = Timers:CreateTimer(self._min_interval, function()
			if not IsValid(self) then
				return
			end
			if self:_CanSendBuff() then
				self:_SendBuffRefreshToClientsAndRecord()
				return nil
			else
				return self._min_interval
			end
		end)
	end
end
function sl_modifier_ability_amp.prototype._SendBuffRefreshToClientsAndRecord(self)
	self._last_send_data_time = GameRules:GetGameTime()
	self._transmitter_counts = self._transmitter_counts + 1
	self:SendBuffRefreshToClients()
end
function sl_modifier_ability_amp.prototype._CanSendBuff(self)
	local now = GameRules:GetGameTime()
	if not self._last_send_data_time then
		return true
	end
	if now - self._last_send_data_time >= self._min_interval then
		return true
	end
	return false
end
function sl_modifier_ability_amp.prototype.HandleCustomTransmitterData(self, data)
	self:_HandleCustomTransmitterDataForAbilityAmp(data.amp_record)
	self:_HandleCustomTransmitterDataForSpecialAttr(data.attr_table)
end
function sl_modifier_ability_amp.prototype.AddCustomTransmitterData(self)
	local data = {
		transmitter_counts = self._transmitter_counts,
		amp_record = self:_AddCustomTransmitterDataForAbilityAmp(),
		attr_table = self:_AddCustomTransmitterDataForSpecialAttr(),
	}
	return data
end
function sl_modifier_ability_amp.prototype.GetModifierOverrideAbilitySpecial(self, event)
	local ____event_15 = event
	local ability = ____event_15.ability
	local ability_special_value = ____event_15.ability_special_value
	self:_WarnIfNativeAbilityDamageOverrideDetected(ability, ability_special_value)
	if self:_FilterSpecialValueForAbilityAmp(ability, ability_special_value) then
		return 1
	elseif self:_FilterSpecialValueForSpecialAttr(ability, ability_special_value) then
		return 1
	end
	return 0
end
function sl_modifier_ability_amp.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ____event_16 = event
	local ability = ____event_16.ability
	local ability_special_level = ____event_16.ability_special_level
	local ability_special_value = ____event_16.ability_special_value
	self:_WarnIfNativeAbilityDamageOverrideDetected(ability, ability_special_value)
	local ability_name = ability:GetAbilityName()
	local ____table__total_cached_table_ability_name_ability_special_value_19 = self._total_cached_table[ability_name]
	if ____table__total_cached_table_ability_name_ability_special_value_19 ~= nil then
		____table__total_cached_table_ability_name_ability_special_value_19 =
			____table__total_cached_table_ability_name_ability_special_value_19[ability_special_value]
	end
	local ____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17 =
		____table__total_cached_table_ability_name_ability_special_value_19
	if ____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17 ~= nil then
		____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17 =
			____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17[ability_special_level]
	end
	local cached_value = ____table__total_cached_table_ability_name_ability_special_value_ability_special_level_17
	if cached_value then
		return cached_value
	else
		local original_value = ability:GetLevelSpecialValueNoOverride(ability_special_value, ability_special_level)
		local override_origin, amp_bonus =
			self:_GetTotalBonusValueForAbilityAmp(ability, ability_special_level, ability_special_value, original_value)
		local special_attr_bonus =
			self:_GetTotalBonusValueForSpecialAttr(ability, ability_special_value, override_origin)
		local result = override_origin + amp_bonus + special_attr_bonus
		local ____self__total_cached_table_21, ____ability_name_22 = self._total_cached_table, ability_name
		if ____self__total_cached_table_21[____ability_name_22] == nil then
			____self__total_cached_table_21[____ability_name_22] = {}
		end
		local ____self__total_cached_table_ability_name_23, ____ability_special_value_24 =
			self._total_cached_table[ability_name], ability_special_value
		if ____self__total_cached_table_ability_name_23[____ability_special_value_24] == nil then
			____self__total_cached_table_ability_name_23[____ability_special_value_24] = {}
		end
		self._total_cached_table[ability_name][ability_special_value][ability_special_level] = result
		return result
	end
end
sl_modifier_ability_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_ability_amp", nil, getfenv()) },
	sl_modifier_ability_amp
)
____exports.sl_modifier_ability_amp = sl_modifier_ability_amp
return ____exports