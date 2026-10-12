--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_custom_attr.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_custom_attr.lua",
	{
		["13"] = "1:1",
		["14"] = "1:10",
		["15"] = "2:1",
		["16"] = "2:10",
		["18"] = "7:1",
		["19"] = "8:14",
		["20"] = "7:1",
		["21"] = "8:38",
		["23"] = "8:46",
		["24"] = "110:5",
		["25"] = "111:9",
		["26"] = "114:9",
		["27"] = "117:9",
		["28"] = "120:9",
		["29"] = "123:9",
		["30"] = "126:9",
		["31"] = "129:9",
		["32"] = "132:9",
		["33"] = "135:9",
		["34"] = "142:9",
		["35"] = "145:9",
		["36"] = "148:9",
		["37"] = "151:9",
		["38"] = "154:9",
		["39"] = "157:9",
		["40"] = "160:9",
		["41"] = "163:9",
		["42"] = "166:9",
		["43"] = "167:9",
		["44"] = "170:9",
		["45"] = "173:9",
		["46"] = "176:9",
		["47"] = "179:9",
		["48"] = "182:9",
		["49"] = "185:9",
		["50"] = "188:9",
		["51"] = "191:9",
		["52"] = "199:9",
		["53"] = "207:9",
		["54"] = "215:9",
		["55"] = "223:9",
		["56"] = "231:9",
		["57"] = "232:9",
		["58"] = "235:9",
		["59"] = "238:9",
		["60"] = "241:9",
		["61"] = "244:9",
		["62"] = "247:9",
		["63"] = "250:9",
		["64"] = "253:9",
		["65"] = "254:9",
		["66"] = "255:9",
		["67"] = "259:9",
		["68"] = "260:9",
		["69"] = "261:9",
		["70"] = "262:9",
		["71"] = "263:9",
		["72"] = "264:9",
		["73"] = "265:9",
		["74"] = "266:9",
		["75"] = "267:9",
		["76"] = "268:9",
		["77"] = "269:9",
		["78"] = "110:66",
		["79"] = "273:5",
		["80"] = "326:5",
		["81"] = "327:5",
		["82"] = "328:5",
		["83"] = "363:5",
		["84"] = "373:5",
		["85"] = "7:1",
		["86"] = "9:5",
		["87"] = "10:9",
		["88"] = "10:16",
		["89"] = "10:16",
		["90"] = "10:16",
		["91"] = "10:16",
		["92"] = "10:16",
		["93"] = "10:16",
		["94"] = "10:16",
		["95"] = "10:16",
		["96"] = "10:16",
		["97"] = "10:16",
		["98"] = "10:16",
		["99"] = "10:16",
		["100"] = "10:16",
		["101"] = "10:16",
		["102"] = "10:16",
		["103"] = "10:16",
		["104"] = "10:16",
		["105"] = "10:16",
		["106"] = "10:16",
		["107"] = "10:16",
		["108"] = "10:16",
		["109"] = "10:16",
		["110"] = "10:16",
		["111"] = "10:16",
		["112"] = "10:16",
		["113"] = "10:16",
		["114"] = "10:16",
		["115"] = "10:16",
		["116"] = "10:16",
		["117"] = "10:16",
		["118"] = "10:16",
		["119"] = "10:16",
		["120"] = "10:16",
		["121"] = "10:16",
		["122"] = "10:16",
		["123"] = "10:16",
		["124"] = "10:16",
		["126"] = "10:16",
		["127"] = "9:5",
		["128"] = "274:5",
		["129"] = "275:14",
		["132"] = "276:15",
		["133"] = "277:14",
		["136"] = "278:9",
		["137"] = "279:9",
		["138"] = "274:5",
		["139"] = "288:5",
		["140"] = "289:9",
		["141"] = "288:5",
		["142"] = "296:5",
		["143"] = "297:14",
		["144"] = "298:13",
		["147"] = "301:15",
		["148"] = "302:14",
		["149"] = "303:13",
		["152"] = "306:20",
		["154"] = "307:19",
		["155"] = "308:19",
		["156"] = "309:18",
		["157"] = "309:26",
		["159"] = "310:19",
		["160"] = "311:13",
		["161"] = "312:17",
		["162"] = "314:17",
		["164"] = "316:17",
		["165"] = "317:17",
		["167"] = "319:17",
		["168"] = "320:17",
		["173"] = "296:5",
		["174"] = "334:5",
		["175"] = "335:13",
		["176"] = "336:13",
		["177"] = "337:20",
		["178"] = "338:13",
		["179"] = "339:20",
		["180"] = "340:13",
		["182"] = "342:13",
		["184"] = "344:13",
		["187"] = "345:13",
		["188"] = "346:13",
		["190"] = "349:13",
		["191"] = "350:22",
		["194"] = "351:21",
		["195"] = "352:21",
		["196"] = "353:21",
		["198"] = "355:21",
		["200"] = "349:56",
		["202"] = "334:5",
		["203"] = "364:5",
		["204"] = "367:9",
		["205"] = "369:9",
		["206"] = "370:9",
		["207"] = "364:5",
		["208"] = "375:5",
		["209"] = "376:15",
		["210"] = "377:14",
		["211"] = "377:41",
		["213"] = "378:13",
		["214"] = "379:13",
		["216"] = "381:9",
		["217"] = "375:5",
		["218"] = "385:5",
		["219"] = "386:36",
		["221"] = "386:36",
		["223"] = "386:9",
		["224"] = "389:20",
		["225"] = "390:13",
		["227"] = "385:5",
		["228"] = "394:5",
		["229"] = "395:13",
		["230"] = "396:19",
		["231"] = "397:17",
		["232"] = "397:34",
		["234"] = "398:13",
		["236"] = "400:9",
		["237"] = "401:13",
		["239"] = "403:9",
		["240"] = "405:15",
		["241"] = "408:20",
		["242"] = "410:19",
		["243"] = "411:19",
		["244"] = "412:13",
		["246"] = "415:9",
		["247"] = "416:9",
		["248"] = "394:5",
		["249"] = "421:5",
		["250"] = "422:13",
		["251"] = "423:20",
		["252"] = "423:20",
		["253"] = "423:20",
		["255"] = "423:13",
		["257"] = "425:13",
		["259"] = "421:5",
		["260"] = "429:5",
		["261"] = "430:9",
		["262"] = "429:5",
		["263"] = "433:5",
		["264"] = "434:9",
		["265"] = "433:5",
		["266"] = "437:5",
		["267"] = "438:9",
		["268"] = "437:5",
		["269"] = "441:5",
		["270"] = "442:9",
		["271"] = "441:5",
		["272"] = "445:5",
		["273"] = "446:9",
		["274"] = "445:5",
		["275"] = "449:5",
		["276"] = "450:9",
		["277"] = "449:5",
		["278"] = "453:5",
		["279"] = "454:9",
		["280"] = "453:5",
		["281"] = "457:5",
		["282"] = "458:9",
		["283"] = "457:5",
		["284"] = "461:5",
		["285"] = "464:15",
		["286"] = "465:13",
		["287"] = "466:19",
		["288"] = "467:17",
		["290"] = "467:33",
		["291"] = "467:33",
		["292"] = "467:33",
		["294"] = "467:33",
		["295"] = "467:33",
		["296"] = "467:33",
		["298"] = "467:17",
		["300"] = "467:17",
		["301"] = "469:17",
		["302"] = "470:67",
		["303"] = "470:67",
		["304"] = "470:67",
		["306"] = "470:67",
		["308"] = "470:67",
		["310"] = "471:25",
		["311"] = "471:25",
		["312"] = "471:25",
		["314"] = "471:25",
		["316"] = "471:25",
		["318"] = "472:25",
		["319"] = "472:25",
		["320"] = "472:25",
		["321"] = "472:25",
		["323"] = "472:25",
		["324"] = "472:53",
		["326"] = "472:53",
		["328"] = "472:53",
		["330"] = "472:102",
		["332"] = "469:17",
		["335"] = "476:9",
		["336"] = "461:5",
		["337"] = "479:5",
		["338"] = "480:9",
		["339"] = "479:5",
		["340"] = "483:5",
		["341"] = "484:9",
		["342"] = "483:5",
		["343"] = "487:5",
		["344"] = "488:14",
		["347"] = "489:15",
		["348"] = "490:15",
		["349"] = "491:15",
		["350"] = "492:15",
		["351"] = "493:14",
		["354"] = "494:13",
		["355"] = "495:19",
		["356"] = "496:19",
		["357"] = "497:19",
		["358"] = "498:19",
		["359"] = "499:19",
		["360"] = "500:19",
		["362"] = "487:5",
		["363"] = "588:5",
		["364"] = "589:9",
		["365"] = "588:5",
		["366"] = "592:5",
		["367"] = "593:9",
		["368"] = "592:5",
		["369"] = "596:5",
		["370"] = "597:9",
		["371"] = "596:5",
		["372"] = "600:5",
		["373"] = "601:9",
		["374"] = "600:5",
		["375"] = "604:5",
		["376"] = "605:9",
		["377"] = "604:5",
		["378"] = "608:5",
		["379"] = "609:9",
		["380"] = "608:5",
		["381"] = "612:5",
		["382"] = "613:9",
		["383"] = "612:5",
		["384"] = "616:5",
		["385"] = "617:9",
		["386"] = "616:5",
		["387"] = "632:5",
		["388"] = "633:14",
		["389"] = "633:26",
		["391"] = "634:13",
		["392"] = "635:13",
		["393"] = "636:22",
		["395"] = "636:22",
		["397"] = "636:13",
		["398"] = "637:20",
		["399"] = "638:23",
		["401"] = "638:23",
		["403"] = "638:13",
		["405"] = "640:19",
		["407"] = "640:19",
		["409"] = "640:68",
		["411"] = "640:68",
		["413"] = "640:9",
		["414"] = "641:9",
		["415"] = "632:5",
		["416"] = "656:5",
		["417"] = "657:14",
		["418"] = "657:26",
		["420"] = "658:13",
		["421"] = "659:13",
		["422"] = "660:22",
		["424"] = "660:22",
		["426"] = "660:13",
		["427"] = "661:20",
		["428"] = "662:23",
		["430"] = "662:23",
		["432"] = "662:13",
		["434"] = "664:19",
		["436"] = "664:19",
		["438"] = "664:67",
		["440"] = "664:67",
		["442"] = "664:9",
		["443"] = "665:9",
		["444"] = "656:5",
		["445"] = "680:5",
		["446"] = "681:14",
		["447"] = "681:26",
		["449"] = "682:13",
		["450"] = "683:13",
		["451"] = "684:22",
		["453"] = "684:22",
		["455"] = "684:13",
		["456"] = "685:20",
		["457"] = "686:23",
		["459"] = "686:23",
		["461"] = "686:13",
		["463"] = "688:19",
		["465"] = "688:19",
		["467"] = "688:69",
		["469"] = "688:69",
		["471"] = "688:9",
		["472"] = "689:9",
		["473"] = "680:5",
		["474"] = "730:5",
		["475"] = "731:9",
		["476"] = "730:5",
		["477"] = "739:5",
		["478"] = "740:9",
		["479"] = "739:5",
		["480"] = "743:5",
		["481"] = "744:9",
		["482"] = "743:5",
		["483"] = "747:5",
		["484"] = "748:9",
		["485"] = "747:5",
		["486"] = "751:5",
		["487"] = "752:9",
		["488"] = "751:5",
		["489"] = "755:5",
		["490"] = "756:9",
		["491"] = "755:5",
		["492"] = "759:5",
		["493"] = "760:9",
		["494"] = "759:5",
		["495"] = "763:5",
		["496"] = "764:9",
		["497"] = "763:5",
		["498"] = "784:5",
		["499"] = "785:9",
		["500"] = "784:5",
		["501"] = "788:5",
		["502"] = "789:22",
		["504"] = "789:22",
		["506"] = "789:72",
		["508"] = "789:72",
		["510"] = "789:13",
		["511"] = "790:13",
		["512"] = "791:23",
		["514"] = "791:23",
		["516"] = "791:78",
		["518"] = "791:78",
		["520"] = "791:13",
		["522"] = "793:9",
		["523"] = "788:5",
		["524"] = "796:5",
		["525"] = "797:22",
		["527"] = "797:22",
		["529"] = "797:78",
		["531"] = "797:78",
		["533"] = "797:13",
		["534"] = "798:13",
		["535"] = "799:23",
		["537"] = "799:23",
		["539"] = "799:84",
		["541"] = "799:84",
		["543"] = "799:13",
		["545"] = "801:9",
		["546"] = "796:5",
		["547"] = "804:5",
		["548"] = "805:9",
		["549"] = "804:5",
		["550"] = "8:14",
		["551"] = "7:2",
		["552"] = "7:2",
		["553"] = "7:19",
		["554"] = "7:2",
		["556"] = "7:2",
		["557"] = "8:14",
		["559"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 自定义属性模块
____exports.sl_modifier_custom_attr = __TS__Class()
local sl_modifier_custom_attr = ____exports.sl_modifier_custom_attr
sl_modifier_custom_attr.name = "sl_modifier_custom_attr"
__TS__ClassExtends(sl_modifier_custom_attr, SLModifierBase)
function sl_modifier_custom_attr.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._attr_record = {
		sm = { need_calculate = true },
		smI = { need_calculate = true },
		mf = { need_calculate = true },
		mfI = { need_calculate = true },
		gjb = { send_to_client = true },
		gjl = { send_to_client = true },
		gjbI = { send_to_client = true },
		gjI = { send_to_client = true },
		jnzq = { send_to_client = true },
		hj = { send_to_client = true },
		mk = { send_to_client = true },
		xx = { send_to_client = true },
		jnxx = { send_to_client = true },
		qnxx = { send_to_client = true },
		yxxx = { send_to_client = true },
		yxjnxx = { send_to_client = true },
		yxqnxx = { send_to_client = true },
		shI = {},
		gsI = { send_to_client = true },
		gs = { send_to_client = true },
		lq = { send_to_client = true },
		ys = { send_to_client = true },
		ysI = { send_to_client = true },
		gjjl = { send_to_client = true },
		sb = { send_to_client = true },
		sfjl = { send_to_client = true },
		ll = { send_to_client = true, need_calculate = true },
		mj = { send_to_client = true, need_calculate = true },
		zl = { send_to_client = true, need_calculate = true },
		zsx = { send_to_client = true, need_calculate = true },
		qss = { send_to_client = true, need_calculate = true },
		fm = {},
		ztkx = { send_to_client = true },
		gjjg = { send_to_client = true },
		smhf = { send_to_client = true },
		smhfI = { send_to_client = true },
		smhfzqI = { send_to_client = true },
		mfhf = { send_to_client = true },
		mfhfzqI = { send_to_client = true },
		csshI = {},
		mxI = {},
		smhftzI = { send_to_client = true },
		cffyshI = nil,
		cfdjshI = nil,
		jnfw = nil,
		jnfwI = nil,
		fhsj = nil,
		fhsjI = nil,
		hxgjbl = nil,
		hxgjgl = nil,
		phcs = nil,
		phzs = nil,
		gangpct = nil,
	}
	self._primary_attribute = DOTA_ATTRIBUTE_INVALID
	self._cached_need_send_attrs = {}
	self._cached_custom_sync_funcs = __TS__New(Set)
	self._cached_need_calculate = false
	self._transmitter_counts = 0
	self._min_interval = StaticFrameTime
end
function sl_modifier_custom_attr.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end
function sl_modifier_custom_attr.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent:IsHero() then
		return
	end
	self._primary_attribute = parent:GetPrimaryAttribute()
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_custom_attr.prototype.SetAttrValue(self, attr, value)
	self:SetAttrValueByTable({ [attr] = value })
end
function sl_modifier_custom_attr.prototype.SetAttrValueByTable(self, attr_table)
	if not IsServer() then
		SLError(
			"sl_modifier_custom_attr: SetAttrValueByTable can only be called on server",
			nil,
			"modifiers/game_modifiers/sl_modifier_custom_attr.ts:298:13"
		)
		return
	end
	local parent = self:GetParent()
	if not parent:IsHero() then
		SLError(
			"sl_modifier_custom_attr: parent is not a hero",
			nil,
			"modifiers/game_modifiers/sl_modifier_custom_attr.ts:303:13"
		)
		return
	end
	for key in pairs(attr_table) do
		do
			local attr_key = key
			local config = self._attr_record[attr_key]
			if not config then
				goto __continue10
			end
			local attr_value = attr_table[attr_key]
			config.value = attr_value
			if config.send_to_client then
				self:_PushRefresh(attr_key)
			end
			if config.need_calculate then
				self:_PushRefresh(true)
			end
			if config.custom_sync_func then
				self:_PushRefresh(config.custom_sync_func)
			end
		end
		::__continue10::
	end
end
function sl_modifier_custom_attr.prototype._PushRefresh(self, k1)
	if type(k1) == "boolean" then
		self._cached_need_calculate = k1
	elseif type(k1) == "string" then
		self._cached_need_send_attrs[k1] = true
	elseif type(k1) == "function" then
		self._cached_custom_sync_funcs:add(k1)
	else
		SLError(
			"sl_modifier_custom_attr: invalid argument type",
			nil,
			"modifiers/game_modifiers/sl_modifier_custom_attr.ts:342:13"
		)
	end
	if Timers:IsValid(self._send_buff_timer) then
		return
	end
	if self:_CanSendBuff() then
		self:_SendBuffRefreshToClientsAndRecord()
	else
		self._send_buff_timer = Timers:CreateTimer(function()
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
function sl_modifier_custom_attr.prototype._SendBuffRefreshToClientsAndRecord(self)
	self._transmitter_counts = self._transmitter_counts + 1
	self._last_send_data_time = GameRules:GetGameTime()
	self:SendBuffRefreshToClients()
end
function sl_modifier_custom_attr.prototype._CanSendBuff(self)
	local now = GameRules:GetGameTime()
	if not self._last_send_data_time then
		return true
	end
	if now - self._last_send_data_time >= self._min_interval then
		return true
	end
	return false
end
function sl_modifier_custom_attr.prototype.HandleCustomTransmitterData(self, data)
	local ____self__client_attr_record_0 = self._client_attr_record
	if ____self__client_attr_record_0 == nil then
		____self__client_attr_record_0 = { transmitter_counts = data.transmitter_counts }
	end
	self._client_attr_record = ____self__client_attr_record_0
	for key in pairs(data) do
		self._client_attr_record[key] = data[key]
	end
end
function sl_modifier_custom_attr.prototype.AddCustomTransmitterData(self)
	if self._cached_need_calculate then
		local parent = self:GetParent()
		if parent:IsHero() then
			parent:CalculateStatBonus(true)
		end
		self._cached_need_calculate = nil
	end
	for ____, func in __TS__Iterator(self._cached_custom_sync_funcs) do
		func(nil)
	end
	self._cached_custom_sync_funcs:clear()
	local data = { transmitter_counts = self._transmitter_counts }
	for key in pairs(self._cached_need_send_attrs) do
		local attr = key
		local value = self._attr_record[attr].value
		data[attr] = value
	end
	self._cached_need_send_attrs = {}
	return data
end
function sl_modifier_custom_attr.prototype._GetAttrValue(self, attr)
	if IsClient() then
		local ____table__client_attr_record_attr_1 = self._client_attr_record
		if ____table__client_attr_record_attr_1 ~= nil then
			____table__client_attr_record_attr_1 = ____table__client_attr_record_attr_1[attr]
		end
		return ____table__client_attr_record_attr_1
	else
		return self._attr_record[attr].value
	end
end
function sl_modifier_custom_attr.prototype.GetModifierHealthBonus(self)
	return self:_GetAttrValue("sm")
end
function sl_modifier_custom_attr.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetAttrValue("smI")
end
function sl_modifier_custom_attr.prototype.GetModifierManaBonus(self)
	return self:_GetAttrValue("mf")
end
function sl_modifier_custom_attr.prototype.GetModifierExtraManaPercentage(self)
	return self:_GetAttrValue("mfI")
end
function sl_modifier_custom_attr.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_GetAttrValue("gjb")
end
function sl_modifier_custom_attr.prototype.GetModifierPreAttack_BonusDamage(self)
	return self:_GetAttrValue("gjl")
end
function sl_modifier_custom_attr.prototype.GetModifierBaseDamageOutgoing_Percentage(self)
	return self:_GetAttrValue("gjbI")
end
function sl_modifier_custom_attr.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	return self:_GetAttrValue("gjI")
end
function sl_modifier_custom_attr.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ability = event.inflictor
	if IsServer() and IsValid(ability) then
		local ability_name = ability.GetAbilityName and ability:GetAbilityName()
		local ____ability_name_7 = ability_name
		if ____ability_name_7 then
			local ____HTTP_setting_GetServerSet_result_ability_name_5 =
				HTTP.setting:GetServerSet("abilitySpellAmplifyFix")
			if ____HTTP_setting_GetServerSet_result_ability_name_5 ~= nil then
				____HTTP_setting_GetServerSet_result_ability_name_5 =
					____HTTP_setting_GetServerSet_result_ability_name_5[ability_name]
			end
			local ____HTTP_setting_GetServerSet_result_ability_name_enable_3 =
				____HTTP_setting_GetServerSet_result_ability_name_5
			if ____HTTP_setting_GetServerSet_result_ability_name_enable_3 ~= nil then
				____HTTP_setting_GetServerSet_result_ability_name_enable_3 =
					____HTTP_setting_GetServerSet_result_ability_name_enable_3.enable
			end
			____ability_name_7 = ____HTTP_setting_GetServerSet_result_ability_name_enable_3 == 1
		end
		if ____ability_name_7 then
			local ____SLError_18 = SLError
			local ____ability_GetCaster_result_GetUnitName_result_8 = ability:GetCaster()
			if ____ability_GetCaster_result_GetUnitName_result_8 ~= nil then
				____ability_GetCaster_result_GetUnitName_result_8 =
					____ability_GetCaster_result_GetUnitName_result_8:GetUnitName()
			end
			local ____ability_GetCaster_result_GetUnitName_result_8_10 =
				____ability_GetCaster_result_GetUnitName_result_8
			if ____ability_GetCaster_result_GetUnitName_result_8_10 == nil then
				____ability_GetCaster_result_GetUnitName_result_8_10 = "unknown caster"
			end
			local ____event_attacker_GetUnitName_result_11 = event.attacker
			if ____event_attacker_GetUnitName_result_11 ~= nil then
				____event_attacker_GetUnitName_result_11 = ____event_attacker_GetUnitName_result_11:GetUnitName()
			end
			local ____event_attacker_GetUnitName_result_11_13 = ____event_attacker_GetUnitName_result_11
			if ____event_attacker_GetUnitName_result_11_13 == nil then
				____event_attacker_GetUnitName_result_11_13 = "unknown attacker"
			end
			local ____event_target_GetUnitName_17
			local ____event_target_GetUnitName_14 = event.target
			if ____event_target_GetUnitName_14 ~= nil then
				____event_target_GetUnitName_14 = ____event_target_GetUnitName_14.GetUnitName
			end
			if ____event_target_GetUnitName_14 then
				local ____temp_16 = event.target:GetUnitName()
				if ____temp_16 == nil then
					____temp_16 = "unknown target"
				end
				____event_target_GetUnitName_17 = ____temp_16
			else
				____event_target_GetUnitName_17 = "unknown target"
			end
			____SLError_18(
				(
					(
						(
							(
								(ability_name .. " now can use spell amplify. ")
								.. ____ability_GetCaster_result_GetUnitName_result_8_10
							) .. " "
						) .. ____event_attacker_GetUnitName_result_11_13
					) .. " "
				) .. ____event_target_GetUnitName_17,
				nil,
				"modifiers/game_modifiers/sl_modifier_custom_attr.ts:469:17"
			)
		end
	end
	return self:_GetAttrValue("jnzq")
end
function sl_modifier_custom_attr.prototype.GetModifierPhysicalArmorBonus(self, event)
	return self:_GetAttrValue("hj")
end
function sl_modifier_custom_attr.prototype.GetModifierMagicalResistanceBonus(self, event)
	return self:_GetAttrValue("mk")
end
function sl_modifier_custom_attr.prototype.OnTakeDamage(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local attacker = event.attacker
	local ability = event.inflictor
	local victim = event.unit
	if not IsValid(parent) or not IsValid(attacker) or not IsValid(victim) then
		return
	end
	if parent == attacker then
		local attackerTeam = attacker:GetTeamNumber()
		local victimTeam = victim:GetTeamNumber()
		local damage = event.damage
		local damageType = event.damage_type
		local damageCategory = event.damage_category
		local damageFlags = event.damage_flags
	end
end
function sl_modifier_custom_attr.prototype.GetModifierAttackSpeedPercentage(self)
	return self:_GetAttrValue("gsI")
end
function sl_modifier_custom_attr.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self:_GetAttrValue("gs")
end
function sl_modifier_custom_attr.prototype.GetModifierPercentageCooldown(self)
	return self:_GetAttrValue("lq")
end
function sl_modifier_custom_attr.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return self:_GetAttrValue("ys")
end
function sl_modifier_custom_attr.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return self:_GetAttrValue("ysI")
end
function sl_modifier_custom_attr.prototype.GetModifierAttackRangeBonus(self)
	return self:_GetAttrValue("gjjl")
end
function sl_modifier_custom_attr.prototype.GetModifierEvasion_Constant(self, event)
	return self:_GetAttrValue("sb")
end
function sl_modifier_custom_attr.prototype.GetModifierCastRangeBonusStacking(self)
	return self:_GetAttrValue("sfjl")
end
function sl_modifier_custom_attr.prototype.GetModifierBonusStats_Strength(self)
	if not IsServer() then
		return 0
	end
	local value = 0
	if self._primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
		local ____temp_19 = self:_GetAttrValue("zsx")
		if ____temp_19 == nil then
			____temp_19 = 0
		end
		value = value + ____temp_19
	elseif self._primary_attribute == DOTA_ATTRIBUTE_ALL then
		local ____temp_20 = self:_GetAttrValue("zsx")
		if ____temp_20 == nil then
			____temp_20 = 0
		end
		value = value + ____temp_20 * HTTP.setting:GetServerSet("gameBasic").UNIVERSAL_MAIN_STATS_PCT * 0.01
	end
	local ____temp_21 = self:_GetAttrValue("ll")
	if ____temp_21 == nil then
		____temp_21 = 0
	end
	local ____temp_22 = self:_GetAttrValue("qss")
	if ____temp_22 == nil then
		____temp_22 = 0
	end
	value = value + (____temp_21 + ____temp_22)
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierBonusStats_Agility(self)
	if not IsServer() then
		return 0
	end
	local value = 0
	if self._primary_attribute == DOTA_ATTRIBUTE_AGILITY then
		local ____temp_23 = self:_GetAttrValue("zsx")
		if ____temp_23 == nil then
			____temp_23 = 0
		end
		value = value + ____temp_23
	elseif self._primary_attribute == DOTA_ATTRIBUTE_ALL then
		local ____temp_24 = self:_GetAttrValue("zsx")
		if ____temp_24 == nil then
			____temp_24 = 0
		end
		value = value + ____temp_24 * HTTP.setting:GetServerSet("gameBasic").UNIVERSAL_MAIN_STATS_PCT * 0.01
	end
	local ____temp_25 = self:_GetAttrValue("mj")
	if ____temp_25 == nil then
		____temp_25 = 0
	end
	local ____temp_26 = self:_GetAttrValue("qss")
	if ____temp_26 == nil then
		____temp_26 = 0
	end
	value = value + (____temp_25 + ____temp_26)
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierBonusStats_Intellect(self)
	if not IsServer() then
		return 0
	end
	local value = 0
	if self._primary_attribute == DOTA_ATTRIBUTE_INTELLECT then
		local ____temp_27 = self:_GetAttrValue("zsx")
		if ____temp_27 == nil then
			____temp_27 = 0
		end
		value = value + ____temp_27
	elseif self._primary_attribute == DOTA_ATTRIBUTE_ALL then
		local ____temp_28 = self:_GetAttrValue("zsx")
		if ____temp_28 == nil then
			____temp_28 = 0
		end
		value = value + ____temp_28 * HTTP.setting:GetServerSet("gameBasic").UNIVERSAL_MAIN_STATS_PCT * 0.01
	end
	local ____temp_29 = self:_GetAttrValue("zl")
	if ____temp_29 == nil then
		____temp_29 = 0
	end
	local ____temp_30 = self:_GetAttrValue("qss")
	if ____temp_30 == nil then
		____temp_30 = 0
	end
	value = value + (____temp_29 + ____temp_30)
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierStatusResistanceStacking(self)
	return self:_GetAttrValue("ztkx")
end
function sl_modifier_custom_attr.prototype.GetModifierConstantHealthRegen(self)
	return self:_GetAttrValue("smhf")
end
function sl_modifier_custom_attr.prototype.GetModifierHealthRegenPercentage(self)
	return self:_GetAttrValue("smhfI")
end
function sl_modifier_custom_attr.prototype.GetModifierHPRegenAmplify_Percentage(self)
	return self:_GetAttrValue("smhfzqI")
end
function sl_modifier_custom_attr.prototype.GetModifierConstantManaRegen(self)
	return self:_GetAttrValue("mfhf")
end
function sl_modifier_custom_attr.prototype.GetModifierMPRegenAmplify_Percentage(self)
	return self:_GetAttrValue("mfhfzqI")
end
function sl_modifier_custom_attr.prototype.GetModifierIncomingDamage_Percentage(self)
	return self:_GetAttrValue("csshI")
end
function sl_modifier_custom_attr.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	return self:_GetAttrValue("shI")
end
function sl_modifier_custom_attr.prototype.GetModifierModelScale(self)
	return self:_GetAttrValue("mxI")
end
function sl_modifier_custom_attr.prototype.GetModifierProperty_PhysicalLifesteal(self, event)
	local ____temp_31 = self:_GetAttrValue("xx")
	if ____temp_31 == nil then
		____temp_31 = 0
	end
	local ____temp_32 = self:_GetAttrValue("qnxx")
	if ____temp_32 == nil then
		____temp_32 = 0
	end
	local value = ____temp_31 + ____temp_32
	if event.target:IsRealHero() then
		local ____temp_33 = self:_GetAttrValue("yxxx")
		if ____temp_33 == nil then
			____temp_33 = 0
		end
		local ____temp_34 = self:_GetAttrValue("yxqnxx")
		if ____temp_34 == nil then
			____temp_34 = 0
		end
		value = value + (____temp_33 + ____temp_34)
	end
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierProperty_MagicalLifesteal(self, event)
	local ____temp_35 = self:_GetAttrValue("jnxx")
	if ____temp_35 == nil then
		____temp_35 = 0
	end
	local ____temp_36 = self:_GetAttrValue("qnxx")
	if ____temp_36 == nil then
		____temp_36 = 0
	end
	local value = ____temp_35 + ____temp_36
	if event.target:IsRealHero() then
		local ____temp_37 = self:_GetAttrValue("yxjnxx")
		if ____temp_37 == nil then
			____temp_37 = 0
		end
		local ____temp_38 = self:_GetAttrValue("yxqnxx")
		if ____temp_38 == nil then
			____temp_38 = 0
		end
		value = value + (____temp_37 + ____temp_38)
	end
	return value
end
function sl_modifier_custom_attr.prototype.GetModifierPropertyRestorationAmplification(self)
	return self:_GetAttrValue("smhftzI")
end
sl_modifier_custom_attr = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_custom_attr", nil, getfenv()) },
	sl_modifier_custom_attr
)
____exports.sl_modifier_custom_attr = sl_modifier_custom_attr
return ____exports