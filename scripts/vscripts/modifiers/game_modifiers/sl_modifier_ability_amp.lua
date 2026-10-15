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
		["22"] = "24:5",
		["23"] = "26:5",
		["24"] = "47:5",
		["25"] = "61:5",
		["26"] = "62:5",
		["27"] = "63:5",
		["28"] = "64:9",
		["29"] = "65:9",
		["30"] = "66:9",
		["31"] = "67:9",
		["32"] = "68:9",
		["33"] = "63:61",
		["34"] = "256:5",
		["35"] = "274:5",
		["36"] = "352:5",
		["37"] = "354:9",
		["38"] = "355:17",
		["39"] = "355:38",
		["41"] = "356:13",
		["42"] = "354:34",
		["43"] = "358:9",
		["44"] = "359:17",
		["45"] = "359:38",
		["47"] = "360:13",
		["48"] = "358:38",
		["49"] = "362:9",
		["50"] = "352:128",
		["51"] = "430:5",
		["52"] = "455:5",
		["53"] = "9:1",
		["54"] = "17:5",
		["55"] = "18:15",
		["56"] = "19:9",
		["57"] = "17:5",
		["58"] = "28:5",
		["59"] = "29:9",
		["60"] = "28:5",
		["61"] = "33:5",
		["62"] = "34:14",
		["65"] = "35:15",
		["66"] = "36:15",
		["67"] = "37:15",
		["68"] = "39:9",
		["69"] = "41:9",
		["70"] = "42:9",
		["71"] = "43:9",
		["72"] = "33:5",
		["73"] = "48:5",
		["74"] = "49:9",
		["75"] = "50:20",
		["76"] = "51:19",
		["77"] = "52:13",
		["78"] = "53:24",
		["79"] = "54:17",
		["82"] = "57:9",
		["83"] = "48:5",
		["84"] = "71:5",
		["85"] = "72:14",
		["86"] = "72:32",
		["88"] = "73:13",
		["89"] = "73:69",
		["91"] = "74:13",
		["92"] = "74:73",
		["94"] = "75:9",
		["95"] = "71:5",
		["96"] = "78:5",
		["97"] = "79:9",
		["98"] = "78:5",
		["99"] = "86:5",
		["100"] = "87:14",
		["103"] = "89:15",
		["104"] = "90:14",
		["105"] = "90:14",
		["106"] = "90:14",
		["108"] = "90:14",
		["109"] = "90:14",
		["110"] = "90:14",
		["112"] = "90:14",
		["115"] = "91:13",
		["118"] = "93:9",
		["119"] = "94:9",
		["120"] = "86:5",
		["121"] = "100:5",
		["122"] = "104:9",
		["123"] = "104:9",
		["125"] = "106:14",
		["126"] = "106:32",
		["128"] = "107:52",
		["129"] = "107:17",
		["130"] = "107:35",
		["131"] = "109:13",
		["132"] = "111:13",
		["133"] = "112:19",
		["134"] = "113:22",
		["136"] = "113:22",
		["138"] = "113:13",
		["140"] = "116:13",
		["141"] = "117:17",
		["142"] = "118:17",
		["144"] = "120:17",
		["147"] = "124:9",
		["148"] = "100:5",
		["149"] = "127:5",
		["150"] = "129:14",
		["153"] = "130:9",
		["154"] = "131:9",
		["155"] = "127:5",
		["156"] = "134:5",
		["157"] = "136:14",
		["160"] = "137:9",
		["161"] = "138:9",
		["162"] = "134:5",
		["163"] = "141:5",
		["164"] = "142:13",
		["165"] = "143:17",
		["166"] = "144:32",
		["168"] = "144:32",
		["170"] = "144:23",
		["171"] = "145:17",
		["172"] = "146:17",
		["175"] = "149:13",
		["176"] = "150:17",
		["177"] = "156:17",
		["180"] = "159:9",
		["181"] = "141:5",
		["182"] = "162:5",
		["183"] = "176:15",
		["184"] = "177:14",
		["185"] = "177:19",
		["187"] = "180:13",
		["188"] = "181:15",
		["189"] = "182:13",
		["190"] = "183:19",
		["191"] = "184:17",
		["192"] = "184:63",
		["195"] = "186:15",
		["196"] = "188:13",
		["197"] = "193:13",
		["199"] = "195:19",
		["200"] = "196:19",
		["201"] = "197:19",
		["202"] = "203:19",
		["203"] = "205:17",
		["204"] = "206:17",
		["205"] = "207:17",
		["206"] = "208:17",
		["207"] = "209:17",
		["208"] = "210:17",
		["210"] = "212:17",
		["211"] = "213:21",
		["212"] = "214:21",
		["213"] = "215:21",
		["214"] = "216:21",
		["215"] = "217:21",
		["216"] = "212:77",
		["218"] = "221:13",
		["220"] = "162:5",
		["221"] = "230:5",
		["222"] = "231:15",
		["223"] = "232:14",
		["224"] = "232:14",
		["225"] = "232:14",
		["227"] = "232:14",
		["228"] = "232:76",
		["230"] = "234:15",
		["231"] = "235:13",
		["232"] = "235:33",
		["234"] = "237:15",
		["235"] = "238:13",
		["236"] = "238:35",
		["238"] = "240:16",
		["239"] = "241:13",
		["240"] = "242:13",
		["241"] = "243:13",
		["242"] = "244:13",
		["243"] = "245:13",
		["244"] = "240:46",
		["245"] = "247:15",
		["246"] = "248:9",
		["247"] = "230:5",
		["248"] = "258:5",
		["249"] = "259:9",
		["250"] = "259:9",
		["252"] = "264:13",
		["253"] = "265:13",
		["255"] = "267:13",
		["257"] = "258:5",
		["258"] = "276:5",
		["259"] = "277:15",
		["260"] = "278:15",
		["261"] = "279:9",
		["262"] = "276:5",
		["263"] = "283:5",
		["264"] = "284:14",
		["267"] = "286:15",
		["268"] = "287:14",
		["271"] = "288:13",
		["272"] = "289:20",
		["273"] = "290:19",
		["274"] = "291:19",
		["275"] = "292:19",
		["276"] = "293:17",
		["277"] = "294:17",
		["278"] = "295:17",
		["279"] = "295:17",
		["280"] = "296:17",
		["283"] = "299:13",
		["284"] = "301:13",
		["285"] = "302:13",
		["287"] = "283:5",
		["288"] = "306:5",
		["289"] = "307:9",
		["290"] = "306:5",
		["291"] = "310:5",
		["292"] = "311:15",
		["293"] = "312:9",
		["294"] = "313:13",
		["296"] = "315:9",
		["297"] = "316:9",
		["298"] = "310:5",
		["299"] = "319:5",
		["300"] = "320:14",
		["303"] = "321:9",
		["304"] = "321:9",
		["306"] = "326:20",
		["307"] = "327:19",
		["308"] = "328:19",
		["309"] = "329:13",
		["311"] = "332:9",
		["312"] = "319:5",
		["313"] = "339:5",
		["314"] = "340:15",
		["315"] = "341:13",
		["316"] = "342:17",
		["317"] = "345:17",
		["320"] = "348:9",
		["321"] = "339:5",
		["322"] = "365:5",
		["323"] = "372:15",
		["324"] = "374:14",
		["325"] = "374:68",
		["327"] = "376:30",
		["328"] = "376:30",
		["329"] = "376:30",
		["331"] = "376:30",
		["332"] = "376:30",
		["333"] = "376:30",
		["335"] = "376:15",
		["336"] = "377:13",
		["337"] = "378:13",
		["339"] = "381:17",
		["340"] = "382:19",
		["341"] = "383:24",
		["343"] = "384:23",
		["344"] = "385:21",
		["345"] = "385:50",
		["347"] = "386:32",
		["348"] = "386:17",
		["352"] = "389:13",
		["353"] = "389:13",
		["354"] = "389:13",
		["356"] = "390:13",
		["357"] = "390:13",
		["358"] = "390:13",
		["360"] = "391:17",
		["361"] = "392:17",
		["362"] = "393:17",
		["363"] = "394:17",
		["365"] = "396:17",
		["367"] = "404:13",
		["369"] = "365:5",
		["370"] = "410:5",
		["371"] = "411:9",
		["372"] = "410:5",
		["373"] = "414:5",
		["374"] = "415:13",
		["375"] = "416:19",
		["376"] = "417:18",
		["377"] = "418:17",
		["380"] = "421:9",
		["381"] = "422:9",
		["382"] = "424:9",
		["383"] = "425:9",
		["384"] = "426:9",
		["385"] = "414:5",
		["386"] = "433:5",
		["387"] = "435:13",
		["390"] = "437:13",
		["391"] = "438:13",
		["393"] = "441:13",
		["394"] = "441:51",
		["395"] = "441:71",
		["396"] = "442:22",
		["399"] = "443:21",
		["400"] = "444:21",
		["401"] = "445:21",
		["403"] = "447:21",
		["405"] = "441:71",
		["406"] = "441:32",
		["408"] = "433:5",
		["409"] = "456:5",
		["410"] = "458:9",
		["411"] = "461:9",
		["412"] = "462:9",
		["413"] = "456:5",
		["414"] = "465:5",
		["415"] = "466:15",
		["416"] = "467:14",
		["417"] = "467:41",
		["419"] = "468:13",
		["420"] = "469:13",
		["422"] = "471:9",
		["423"] = "465:5",
		["424"] = "474:5",
		["425"] = "475:9",
		["426"] = "476:9",
		["427"] = "474:5",
		["428"] = "479:5",
		["429"] = "480:15",
		["430"] = "481:13",
		["431"] = "482:13",
		["432"] = "483:13",
		["433"] = "480:36",
		["434"] = "485:9",
		["435"] = "479:5",
		["436"] = "488:5",
		["437"] = "490:52",
		["438"] = "490:17",
		["439"] = "490:26",
		["440"] = "491:14",
		["441"] = "491:32",
		["443"] = "492:9",
		["444"] = "493:15",
		["445"] = "494:13",
		["446"] = "495:13",
		["447"] = "496:20",
		["448"] = "497:13",
		["450"] = "499:9",
		["451"] = "488:5",
		["452"] = "502:5",
		["453"] = "504:75",
		["454"] = "504:17",
		["455"] = "504:26",
		["456"] = "504:49",
		["457"] = "505:14",
		["458"] = "505:32",
		["460"] = "506:9",
		["461"] = "507:15",
		["462"] = "509:15",
		["463"] = "510:16",
		["464"] = "511:13",
		["465"] = "512:13",
		["466"] = "513:13",
		["467"] = "514:13",
		["468"] = "515:13",
		["469"] = "510:46",
		["470"] = "517:15",
		["471"] = "518:13",
		["472"] = "519:13",
		["473"] = "520:13",
		["474"] = "521:13",
		["475"] = "522:13",
		["476"] = "517:36",
		["477"] = "524:9",
		["478"] = "502:5",
		["479"] = "10:14",
		["480"] = "9:2",
		["481"] = "9:2",
		["482"] = "9:19",
		["483"] = "9:2",
		["485"] = "9:2",
		["486"] = "10:14",
		["488"] = "10:14",
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
	self._amp_record = {}
	self._need_send_amp_record = false
	self._amp_cache = {}
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
	self:_RefreshSpecialAttrCache()
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
function sl_modifier_ability_amp.prototype._FilterSpecialValueForAbilityAmp(self, ability, ability_name, special_key)
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
	original_value,
	ability_name
)
	local cfg = self._amp_record[ability_name] and self._amp_record[ability_name][special_key]
	if not cfg then
		return original_value, 0
	end
	local target_level = special_level + 1
	local ability_current_level = ability:GetLevel()
	if ability_current_level > target_level then
		local original_value_for_current =
			ability:GetLevelSpecialValueNoOverride(special_key, ability_current_level - 1)
		if original_value_for_current == original_value then
			target_level = ability_current_level
		end
	end
	local cached_table = self._amp_cache[ability_name][special_key][special_level]
	if
		cached_table ~= nil
		and cached_table.ability == ability
		and cached_table.original == original_value
		and cached_table.target_level == target_level
	then
		return cached_table.override_origin, cached_table.cached
	else
		local actual_base = self:_CalculateAmpValueByType(cfg, "c", target_level, original_value)
		local actual_constant_bonus = self:_CalculateAmpValueByType(cfg, "b", target_level, 0)
		local actual_percent_bonus = self:_CalculateAmpValueByType(cfg, "a", target_level, 0)
		local total_bonus = self:_FixedNumber(actual_constant_bonus + actual_base * (actual_percent_bonus / 100), 2)
		if cached_table ~= nil then
			cached_table.cached = total_bonus
			cached_table.original = original_value
			cached_table.override_origin = actual_base
			cached_table.ability = ability
			cached_table.target_level = target_level
		else
			self._amp_cache[ability_name][special_key][special_level] = {
				cached = total_bonus,
				original = original_value,
				override_origin = actual_base,
				ability = ability,
				target_level = target_level,
			}
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
	local override_origin, amp_bonus = self:_GetTotalBonusValueForAbilityAmp(
		ability,
		ability_level - 1,
		ABILITY_DAMAGE_SPECIAL_KEY,
		original_damage,
		ability_name
	)
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
function sl_modifier_ability_amp.prototype._FilterSpecialValueForSpecialAttr(self, ability_name, special_key)
	local map = self._special_attr_relation_map[ability_name]
	if map then
		if map[special_key] ~= nil then
			return true
		end
	end
	return false
end
function sl_modifier_ability_amp.prototype._GetTotalBonusValueForSpecialAttr(
	self,
	ability,
	ability_name,
	special_key,
	special_level,
	original_value
)
	local map = self._special_attr_relation_map
	if not map[ability_name] or not map[ability_name][special_key] then
		return 0
	end
	local ____table__special_attr_cached_table_ability_name_special_key_12 =
		self._special_attr_cached_table[ability_name]
	if ____table__special_attr_cached_table_ability_name_special_key_12 ~= nil then
		____table__special_attr_cached_table_ability_name_special_key_12 =
			____table__special_attr_cached_table_ability_name_special_key_12[special_key]
	end
	local ____table__special_attr_cached_table_ability_name_special_key_special_level_10 =
		____table__special_attr_cached_table_ability_name_special_key_12
	if ____table__special_attr_cached_table_ability_name_special_key_special_level_10 ~= nil then
		____table__special_attr_cached_table_ability_name_special_key_special_level_10 =
			____table__special_attr_cached_table_ability_name_special_key_special_level_10[special_level]
	end
	local cached_value = ____table__special_attr_cached_table_ability_name_special_key_special_level_10
	if cached_value ~= nil and cached_value.ability == ability and cached_value.original == original_value then
		return cached_value.cached
	else
		local total_bonus = 0
		local relation_attrs = map[ability_name][special_key]
		for key in pairs(relation_attrs) do
			do
				local attr = key
				if self._attr_value[attr] == 0 then
					goto __continue78
				end
				local ____self_14 = self._special_attr_calc_cb
				total_bonus = total_bonus + ____self_14[attr](____self_14, original_value, self._attr_value[attr])
			end
			::__continue78::
		end
		local ____self__special_attr_cached_table_15, ____ability_name_16 =
			self._special_attr_cached_table, ability_name
		if ____self__special_attr_cached_table_15[____ability_name_16] == nil then
			____self__special_attr_cached_table_15[____ability_name_16] = {}
		end
		local ____self__special_attr_cached_table_ability_name_17, ____special_key_18 =
			self._special_attr_cached_table[ability_name], special_key
		if ____self__special_attr_cached_table_ability_name_17[____special_key_18] == nil then
			____self__special_attr_cached_table_ability_name_17[____special_key_18] = {}
		end
		if cached_value ~= nil then
			cached_value.ability = ability
			cached_value.original = original_value
			cached_value.cached = total_bonus
		else
			self._special_attr_cached_table[ability_name][special_key][special_level] =
				{ ability = ability, original = original_value, cached = total_bonus }
		end
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
				"modifiers/game_modifiers/sl_modifier_ability_amp.ts:418:17"
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
	local ____event_19 = event
	local ability = ____event_19.ability
	local ability_special_value = ____event_19.ability_special_value
	if not IsValid(ability) then
		return 0
	end
	self:_WarnIfNativeAbilityDamageOverrideDetected(ability, ability_special_value)
	local ability_name = ability:GetAbilityName()
	if self:_FilterSpecialValueForAbilityAmp(ability, ability_name, ability_special_value) then
		return 1
	elseif self:_FilterSpecialValueForSpecialAttr(ability_name, ability_special_value) then
		return 1
	end
	return 0
end
function sl_modifier_ability_amp.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ____event_20 = event
	local ability = ____event_20.ability
	local ability_special_level = ____event_20.ability_special_level
	local ability_special_value = ____event_20.ability_special_value
	if not IsValid(ability) then
		return 0
	end
	self:_WarnIfNativeAbilityDamageOverrideDetected(ability, ability_special_value)
	local ability_name = ability:GetAbilityName()
	local original_value = ability:GetLevelSpecialValueNoOverride(ability_special_value, ability_special_level)
	local override_origin, amp_bonus = self:_GetTotalBonusValueForAbilityAmp(
		ability,
		ability_special_level,
		ability_special_value,
		original_value,
		ability_name
	)
	local special_attr_bonus = self:_GetTotalBonusValueForSpecialAttr(
		ability,
		ability_name,
		ability_special_value,
		ability_special_level,
		override_origin
	)
	return override_origin + amp_bonus + special_attr_bonus
end
sl_modifier_ability_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_ability_amp", nil, getfenv()) },
	sl_modifier_ability_amp
)
____exports.sl_modifier_ability_amp = sl_modifier_ability_amp
return ____exports