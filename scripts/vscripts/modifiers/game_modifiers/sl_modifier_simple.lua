--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_simple.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_simple.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "7:23",
		["17"] = "7:1",
		["18"] = "7:47",
		["19"] = "8:5",
		["20"] = "9:9",
		["21"] = "8:5",
		["23"] = "18:1",
		["24"] = "18:23",
		["25"] = "18:1",
		["26"] = "18:49",
		["27"] = "19:5",
		["28"] = "20:9",
		["29"] = "19:5",
		["31"] = "29:1",
		["32"] = "29:23",
		["33"] = "29:1",
		["34"] = "29:57",
		["35"] = "30:5",
		["36"] = "31:9",
		["37"] = "30:5",
		["38"] = "35:5",
		["39"] = "36:14",
		["42"] = "37:9",
		["43"] = "38:9",
		["44"] = "35:5",
		["45"] = "41:5",
		["46"] = "42:14",
		["49"] = "43:14",
		["52"] = "44:23",
		["54"] = "44:23",
		["56"] = "44:9",
		["57"] = "45:9",
		["58"] = "41:5",
		["59"] = "48:5",
		["60"] = "49:9",
		["61"] = "48:5",
		["62"] = "52:5",
		["63"] = "53:9",
		["64"] = "52:5",
		["65"] = "58:5",
		["66"] = "59:9",
		["67"] = "58:5",
		["68"] = "62:5",
		["69"] = "63:9",
		["70"] = "62:5",
		["72"] = "70:1",
		["73"] = "70:23",
		["74"] = "70:1",
		["75"] = "70:49",
		["76"] = "72:5",
		["77"] = "73:9",
		["78"] = "72:5",
		["79"] = "76:5",
		["80"] = "77:9",
		["81"] = "76:5",
		["82"] = "80:5",
		["83"] = "81:14",
		["86"] = "82:15",
		["87"] = "83:14",
		["90"] = "84:9",
		["91"] = "80:5",
		["92"] = "87:5",
		["93"] = "88:9",
		["94"] = "87:5",
		["95"] = "91:5",
		["96"] = "92:9",
		["97"] = "91:5",
		["99"] = "104:1",
		["100"] = "104:23",
		["101"] = "104:1",
		["102"] = "104:49",
		["103"] = "106:5",
		["104"] = "107:9",
		["105"] = "108:9",
		["106"] = "106:5",
		["107"] = "111:5",
		["108"] = "112:9",
		["109"] = "111:5",
		["110"] = "115:5",
		["111"] = "116:14",
		["114"] = "117:15",
		["115"] = "118:14",
		["118"] = "119:9",
		["119"] = "120:9",
		["120"] = "115:5",
		["121"] = "123:5",
		["122"] = "124:9",
		["123"] = "123:5",
		["124"] = "127:5",
		["125"] = "128:9",
		["126"] = "127:5",
		["127"] = "131:5",
		["128"] = "132:9",
		["129"] = "131:5",
		["130"] = "135:5",
		["131"] = "136:9",
		["132"] = "135:5",
		["135"] = "146:1",
		["136"] = "146:23",
		["137"] = "146:1",
		["138"] = "146:56",
		["139"] = "147:5",
		["140"] = "148:9",
		["141"] = "147:5",
		["142"] = "151:5",
		["143"] = "152:9",
		["144"] = "151:5",
		["145"] = "155:5",
		["146"] = "156:9",
		["147"] = "155:5",
		["148"] = "159:5",
		["149"] = "160:9",
		["150"] = "159:5",
		["152"] = "172:1",
		["153"] = "172:23",
		["154"] = "172:1",
		["155"] = "172:53",
		["156"] = "173:5",
		["157"] = "174:9",
		["158"] = "173:5",
		["159"] = "177:5",
		["160"] = "178:14",
		["163"] = "179:9",
		["164"] = "180:9",
		["165"] = "177:5",
		["166"] = "183:5",
		["167"] = "184:14",
		["170"] = "185:9",
		["171"] = "183:5",
		["172"] = "190:5",
		["173"] = "191:9",
		["174"] = "191:9",
		["176"] = "192:9",
		["177"] = "192:33",
		["179"] = "192:33",
		["181"] = "192:9",
		["182"] = "193:9",
		["183"] = "193:40",
		["185"] = "193:40",
		["187"] = "193:9",
		["188"] = "194:9",
		["189"] = "190:5",
		["190"] = "197:5",
		["191"] = "198:9",
		["192"] = "197:5",
		["193"] = "201:5",
		["194"] = "202:9",
		["195"] = "201:5",
		["196"] = "205:5",
		["197"] = "206:16",
		["198"] = "206:16",
		["199"] = "206:16",
		["201"] = "206:9",
		["202"] = "205:5",
		["203"] = "209:5",
		["204"] = "210:16",
		["205"] = "210:16",
		["206"] = "210:16",
		["208"] = "210:9",
		["209"] = "209:5",
		["211"] = "224:16",
		["212"] = "224:1",
		["213"] = "224:40",
		["214"] = "225:5",
		["215"] = "226:9",
		["216"] = "225:5",
		["217"] = "229:5",
		["218"] = "230:9",
		["219"] = "229:5",
		["220"] = "235:5",
		["221"] = "236:14",
		["224"] = "237:9",
		["225"] = "238:9",
		["226"] = "235:5",
		["227"] = "241:5",
		["228"] = "242:14",
		["231"] = "243:9",
		["232"] = "241:5",
		["233"] = "246:5",
		["234"] = "247:16",
		["235"] = "247:16",
		["236"] = "247:16",
		["238"] = "247:16",
		["240"] = "247:16",
		["242"] = "247:9",
		["243"] = "246:5",
		["244"] = "250:5",
		["245"] = "251:16",
		["246"] = "251:16",
		["247"] = "251:16",
		["249"] = "251:16",
		["251"] = "251:16",
		["253"] = "251:9",
		["254"] = "250:5",
		["255"] = "254:5",
		["256"] = "255:14",
		["259"] = "257:9",
		["260"] = "257:9",
		["262"] = "258:9",
		["263"] = "258:42",
		["265"] = "258:42",
		["267"] = "258:9",
		["268"] = "259:9",
		["269"] = "259:38",
		["270"] = "259:47",
		["272"] = "259:47",
		["274"] = "259:9",
		["275"] = "260:9",
		["276"] = "262:13",
		["277"] = "262:53",
		["279"] = "263:13",
		["280"] = "263:61",
		["282"] = "264:13",
		["283"] = "264:58",
		["285"] = "254:5",
		["286"] = "269:5",
		["287"] = "270:9",
		["288"] = "269:5",
		["289"] = "273:5",
		["290"] = "274:9",
		["291"] = "273:5",
		["292"] = "277:5",
		["293"] = "278:9",
		["294"] = "277:5",
		["295"] = "281:5",
		["296"] = "282:9",
		["297"] = "281:5",
		["298"] = "285:5",
		["299"] = "286:9",
		["300"] = "285:5",
		["301"] = "289:5",
		["302"] = "291:13",
		["303"] = "292:17",
		["304"] = "292:17",
		["305"] = "292:17",
		["307"] = "292:17",
		["308"] = "293:24",
		["309"] = "293:24",
		["310"] = "293:24",
		["312"] = "293:17",
		["314"] = "295:24",
		["315"] = "295:24",
		["316"] = "295:24",
		["318"] = "295:17",
		["321"] = "298:18",
		["324"] = "299:40",
		["325"] = "299:21",
		["326"] = "299:29",
		["327"] = "300:19",
		["328"] = "301:17",
		["331"] = "302:18",
		["332"] = "302:18",
		["333"] = "302:18",
		["335"] = "302:17",
		["337"] = "302:49",
		["338"] = "302:49",
		["339"] = "302:49",
		["341"] = "302:49",
		["346"] = "303:17",
		["347"] = "305:13",
		["348"] = "305:13",
		["349"] = "306:17",
		["350"] = "307:17",
		["351"] = "308:17",
		["353"] = "310:13",
		["354"] = "311:13",
		["356"] = "289:5",
		["358"] = "349:1",
		["359"] = "349:23",
		["360"] = "349:1",
		["361"] = "349:46",
		["362"] = "350:5",
		["363"] = "351:9",
		["364"] = "350:5",
		["366"] = "358:1",
		["367"] = "358:23",
		["368"] = "358:1",
		["369"] = "358:51",
		["370"] = "359:5",
		["371"] = "360:9",
		["372"] = "359:5",
		["374"] = "367:1",
		["375"] = "367:23",
		["376"] = "367:1",
		["377"] = "367:48",
		["378"] = "368:5",
		["379"] = "369:9",
		["380"] = "368:5",
		["382"] = "376:1",
		["383"] = "376:23",
		["384"] = "376:1",
		["385"] = "376:49",
		["386"] = "377:5",
		["387"] = "378:9",
		["388"] = "377:5",
		["389"] = "381:5",
		["390"] = "382:9",
		["391"] = "381:5",
		["392"] = "385:5",
		["393"] = "386:14",
		["396"] = "387:15",
		["397"] = "388:13",
		["398"] = "389:13",
		["400"] = "385:5",
		["402"] = "397:1",
		["403"] = "397:23",
		["404"] = "397:1",
		["405"] = "397:56",
		["406"] = "399:5",
		["407"] = "400:9",
		["408"] = "401:9",
		["409"] = "399:5",
		["410"] = "404:5",
		["411"] = "405:9",
		["412"] = "404:5",
		["413"] = "408:5",
		["414"] = "409:14",
		["417"] = "410:14",
		["420"] = "411:9",
		["421"] = "412:9",
		["422"] = "408:5",
		["423"] = "415:5",
		["424"] = "416:9",
		["425"] = "415:5",
		["426"] = "419:5",
		["427"] = "420:9",
		["428"] = "419:5",
		["429"] = "425:5",
		["430"] = "426:9",
		["431"] = "425:5",
		["432"] = "429:5",
		["433"] = "430:9",
		["434"] = "429:5",
		["435"] = "438:1",
		["436"] = "438:23",
		["437"] = "438:1",
		["438"] = "438:45",
		["439"] = "439:5",
		["440"] = "440:14",
		["443"] = "441:9",
		["444"] = "439:5",
		["445"] = "444:5",
		["446"] = "445:9",
		["447"] = "444:5",
		["448"] = "448:5",
		["449"] = "449:9",
		["450"] = "448:5",
		["451"] = "452:5",
		["452"] = "453:9",
		["453"] = "452:5",
		["454"] = "458:5",
		["455"] = "459:9",
		["456"] = "458:5",
		["457"] = "467:5",
		["458"] = "468:9",
		["459"] = "467:5",
		["460"] = "471:5",
		["461"] = "472:9",
		["462"] = "471:5",
		["463"] = "475:5",
		["464"] = "476:14",
		["467"] = "477:13",
		["468"] = "477:49",
		["470"] = "475:5",
		["471"] = "480:5",
		["472"] = "481:14",
		["475"] = "482:13",
		["476"] = "482:60",
		["478"] = "480:5",
		["483"] = "492:1",
		["484"] = "492:23",
		["485"] = "492:1",
		["486"] = "492:55",
		["487"] = "493:5",
		["488"] = "494:9",
		["489"] = "493:5",
		["490"] = "498:1",
		["491"] = "498:23",
		["492"] = "498:1",
		["493"] = "498:51",
		["494"] = "499:5",
		["495"] = "500:9",
		["496"] = "499:5",
		["497"] = "503:5",
		["498"] = "504:9",
		["499"] = "503:5",
		["500"] = "507:5",
		["501"] = "508:9",
		["502"] = "507:5",
		["503"] = "511:5",
		["504"] = "512:9",
		["505"] = "511:5",
		["506"] = "515:5",
		["507"] = "516:9",
		["508"] = "515:5",
		["509"] = "532:1",
		["510"] = "532:23",
		["511"] = "532:1",
		["512"] = "532:99",
		["514"] = "532:107",
		["515"] = "557:5",
		["516"] = "600:5",
		["517"] = "601:5",
		["518"] = "532:1",
		["519"] = "533:5",
		["520"] = "534:9",
		["521"] = "535:9",
		["522"] = "533:5",
		["523"] = "538:5",
		["524"] = "540:9",
		["525"] = "538:5",
		["526"] = "545:5",
		["527"] = "546:14",
		["530"] = "547:14",
		["533"] = "548:13",
		["536"] = "549:9",
		["537"] = "551:13",
		["538"] = "552:13",
		["540"] = "545:5",
		["541"] = "559:5",
		["542"] = "560:15",
		["543"] = "561:14",
		["544"] = "561:41",
		["546"] = "562:13",
		["547"] = "563:13",
		["549"] = "565:9",
		["550"] = "559:5",
		["551"] = "568:5",
		["552"] = "569:13",
		["555"] = "570:13",
		["556"] = "571:13",
		["558"] = "573:13",
		["559"] = "573:51",
		["560"] = "573:71",
		["561"] = "574:22",
		["564"] = "575:21",
		["565"] = "576:21",
		["566"] = "577:21",
		["568"] = "579:21",
		["570"] = "573:71",
		["571"] = "573:32",
		["573"] = "568:5",
		["574"] = "585:5",
		["575"] = "586:9",
		["576"] = "585:5",
		["577"] = "589:5",
		["578"] = "591:9",
		["579"] = "594:9",
		["580"] = "595:9",
		["581"] = "589:5",
		["582"] = "604:5",
		["583"] = "605:14",
		["586"] = "606:9",
		["587"] = "607:9",
		["588"] = "604:5",
		["589"] = "612:5",
		["590"] = "613:9",
		["591"] = "612:5",
		["593"] = "620:1",
		["594"] = "620:23",
		["595"] = "620:1",
		["596"] = "620:106",
		["597"] = "621:5",
		["598"] = "622:9",
		["599"] = "621:5",
		["600"] = "625:5",
		["601"] = "626:9",
		["602"] = "625:5",
		["603"] = "629:5",
		["604"] = "630:9",
		["605"] = "629:5",
		["606"] = "633:5",
		["607"] = "634:9",
		["608"] = "633:5",
		["609"] = "647:1",
		["610"] = "647:23",
		["611"] = "647:1",
		["612"] = "647:49",
		["613"] = "648:5",
		["614"] = "649:9",
		["615"] = "648:5",
		["616"] = "654:5",
		["617"] = "655:9",
		["618"] = "654:5",
		["619"] = "658:5",
		["620"] = "659:9",
		["621"] = "658:5",
		["622"] = "662:5",
		["623"] = "663:9",
		["624"] = "662:5",
		["625"] = "666:5",
		["626"] = "667:9",
		["627"] = "666:5",
		["628"] = "670:5",
		["629"] = "671:16",
		["630"] = "671:16",
		["631"] = "671:16",
		["633"] = "671:16",
		["635"] = "671:16",
		["637"] = "671:9",
		["638"] = "670:5",
		["639"] = "680:1",
		["640"] = "681:14",
		["641"] = "680:1",
		["642"] = "681:38",
		["643"] = "682:5",
		["644"] = "683:9",
		["645"] = "682:5",
		["646"] = "686:5",
		["647"] = "687:9",
		["648"] = "686:5",
		["649"] = "690:5",
		["650"] = "691:9",
		["651"] = "690:5",
		["652"] = "681:14",
		["653"] = "680:2",
		["654"] = "680:2",
		["655"] = "680:19",
		["656"] = "680:2",
		["658"] = "680:2",
		["659"] = "681:14",
		["661"] = "681:14",
		["662"] = "695:1",
		["663"] = "696:14",
		["664"] = "695:1",
		["665"] = "696:52",
		["666"] = "697:5",
		["667"] = "698:9",
		["668"] = "697:5",
		["669"] = "701:5",
		["670"] = "702:14",
		["673"] = "703:9",
		["674"] = "701:5",
		["675"] = "696:14",
		["676"] = "695:2",
		["677"] = "695:2",
		["678"] = "695:19",
		["679"] = "695:2",
		["681"] = "695:2",
		["682"] = "696:14",
		["684"] = "696:14",
		["685"] = "707:1",
		["686"] = "708:14",
		["687"] = "707:1",
		["688"] = "708:31",
		["689"] = "709:5",
		["690"] = "710:9",
		["691"] = "709:5",
		["692"] = "713:5",
		["693"] = "714:9",
		["694"] = "713:5",
		["695"] = "719:5",
		["696"] = "720:9",
		["697"] = "721:9",
		["698"] = "719:5",
		["699"] = "708:14",
		["700"] = "707:2",
		["701"] = "707:2",
		["702"] = "707:19",
		["703"] = "707:2",
		["705"] = "707:2",
		["706"] = "708:14",
		["708"] = "708:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 必中
____exports.sl_modifier_cannot_miss = __TS__Class()
local sl_modifier_cannot_miss = ____exports.sl_modifier_cannot_miss
sl_modifier_cannot_miss.name = "sl_modifier_cannot_miss"
__TS__ClassExtends(sl_modifier_cannot_miss, SLModifierBase)
function sl_modifier_cannot_miss.prototype.CheckState(self)
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
--- 无法闪避
____exports.sl_modifier_evade_disable = __TS__Class()
local sl_modifier_evade_disable = ____exports.sl_modifier_evade_disable
sl_modifier_evade_disable.name = "sl_modifier_evade_disable"
__TS__ClassExtends(sl_modifier_evade_disable, SLModifierBase)
function sl_modifier_evade_disable.prototype.CheckState(self)
	return { [MODIFIER_STATE_EVADE_DISABLED] = true }
end
--- 限制攻击距离
____exports.sl_modifier_override_attack_range = __TS__Class()
local sl_modifier_override_attack_range = ____exports.sl_modifier_override_attack_range
sl_modifier_override_attack_range.name = "sl_modifier_override_attack_range"
__TS__ClassExtends(sl_modifier_override_attack_range, SLModifierBase)
function sl_modifier_override_attack_range.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MAX_ATTACK_RANGE, MODIFIER_PROPERTY_ATTACK_RANGE_BONUS }
end
function sl_modifier_override_attack_range.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._range = params.range
	self:SetHasCustomTransmitterData(true)
end
function sl_modifier_override_attack_range.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	if not params then
		return
	end
	local ____params_range_0 = params.range
	if ____params_range_0 == nil then
		____params_range_0 = self._range
	end
	self._range = ____params_range_0
	self:SendBuffRefreshToClients()
end
function sl_modifier_override_attack_range.prototype.HandleCustomTransmitterData(self, data)
	self._range = data.range
end
function sl_modifier_override_attack_range.prototype.AddCustomTransmitterData(self)
	return { range = self._range }
end
function sl_modifier_override_attack_range.prototype.GetModifierMaxAttackRange(self)
	return self._range
end
function sl_modifier_override_attack_range.prototype.GetModifierAttackRangeBonus(self)
	return self._range
end
--- 承伤百分比 正值增伤，负值减伤
____exports.sl_modifier_damage_income = __TS__Class()
local sl_modifier_damage_income = ____exports.sl_modifier_damage_income
sl_modifier_damage_income.name = "sl_modifier_damage_income"
__TS__ClassExtends(sl_modifier_damage_income, SLModifierBase)
function sl_modifier_damage_income.prototype.OnCreated(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_damage_income.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_damage_income.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	local value = params.value
	if not value then
		return
	end
	self._pct = value
end
function sl_modifier_damage_income.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_damage_income.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self._pct
end
--- 输出百分比 正值增伤 负值减伤
____exports.sl_modifier_damage_output = __TS__Class()
local sl_modifier_damage_output = ____exports.sl_modifier_damage_output
sl_modifier_damage_output.name = "sl_modifier_damage_output"
__TS__ClassExtends(sl_modifier_damage_output, SLModifierBase)
function sl_modifier_damage_output.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_damage_output.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_damage_output.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	local value = params.value
	if not value then
		return
	end
	self._pct = value
	self:SendBuffRefreshToClients()
end
function sl_modifier_damage_output.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_damage_output.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	return self._pct
end
function sl_modifier_damage_output.prototype.HandleCustomTransmitterData(self, data)
	self._pct = data.value
end
function sl_modifier_damage_output.prototype.AddCustomTransmitterData(self)
	return { value = self._pct }
end
--- 输出百分比debuff  正值增伤 负值减伤
-- 默认隐藏，死亡移除，可驱散
____exports.sl_modifier_damage_output_debuff = __TS__Class()
local sl_modifier_damage_output_debuff = ____exports.sl_modifier_damage_output_debuff
sl_modifier_damage_output_debuff.name = "sl_modifier_damage_output_debuff"
__TS__ClassExtends(sl_modifier_damage_output_debuff, ____exports.sl_modifier_damage_output)
function sl_modifier_damage_output_debuff.prototype.IsDebuff(self)
	return true
end
function sl_modifier_damage_output_debuff.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_damage_output_debuff.prototype.IsPurgable(self)
	return true
end
function sl_modifier_damage_output_debuff.prototype.IsPermanent(self)
	return false
end
--- 绿字攻击力
____exports.sl_modifier_pre_attack_damage = __TS__Class()
local sl_modifier_pre_attack_damage = ____exports.sl_modifier_pre_attack_damage
sl_modifier_pre_attack_damage.name = "sl_modifier_pre_attack_damage"
__TS__ClassExtends(sl_modifier_pre_attack_damage, SLModifierBase)
function sl_modifier_pre_attack_damage.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_pre_attack_damage.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_pre_attack_damage.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_pre_attack_damage.prototype._ApplyParam(self, params)
	if self._params == nil then
		self._params = params
	end
	local ____self__params_2 = self._params
	local ____params_constant_1 = params.constant
	if ____params_constant_1 == nil then
		____params_constant_1 = self._params.constant
	end
	____self__params_2.constant = ____params_constant_1
	local ____self__params_4 = self._params
	local ____params_base_attack_pct_3 = params.base_attack_pct
	if ____params_base_attack_pct_3 == nil then
		____params_base_attack_pct_3 = self._params.base_attack_pct
	end
	____self__params_4.base_attack_pct = ____params_base_attack_pct_3
	self:SendBuffRefreshToClients()
end
function sl_modifier_pre_attack_damage.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_pre_attack_damage.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_pre_attack_damage.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_constant_5 = self._params
	if ____table__params_constant_5 ~= nil then
		____table__params_constant_5 = ____table__params_constant_5.constant
	end
	return ____table__params_constant_5
end
function sl_modifier_pre_attack_damage.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_base_attack_pct_7 = self._params
	if ____table__params_base_attack_pct_7 ~= nil then
		____table__params_base_attack_pct_7 = ____table__params_base_attack_pct_7.base_attack_pct
	end
	return ____table__params_base_attack_pct_7
end
--- 护盾
local sl_modifier_shield_base = __TS__Class()
sl_modifier_shield_base.name = "sl_modifier_shield_base"
__TS__ClassExtends(sl_modifier_shield_base, SLModifierBase)
function sl_modifier_shield_base.prototype.IsHidden(self)
	return true
end
function sl_modifier_shield_base.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_shield_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_shield_base.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_shield_base.prototype.GetCurrentShieldAmount(self)
	local ____table__params_shield_amount_9 = self._params
	if ____table__params_shield_amount_9 ~= nil then
		____table__params_shield_amount_9 = ____table__params_shield_amount_9.shield_amount
	end
	local ____table__params_shield_amount_9_11 = ____table__params_shield_amount_9
	if ____table__params_shield_amount_9_11 == nil then
		____table__params_shield_amount_9_11 = 0
	end
	return ____table__params_shield_amount_9_11
end
function sl_modifier_shield_base.prototype.GetMaxShieldAmount(self)
	local ____table__params_shield_amount_max_12 = self._params
	if ____table__params_shield_amount_max_12 ~= nil then
		____table__params_shield_amount_max_12 = ____table__params_shield_amount_max_12.shield_amount_max
	end
	local ____table__params_shield_amount_max_12_14 = ____table__params_shield_amount_max_12
	if ____table__params_shield_amount_max_12_14 == nil then
		____table__params_shield_amount_max_12_14 = 0
	end
	return ____table__params_shield_amount_max_12_14
end
function sl_modifier_shield_base.prototype._ApplyParam(self, params)
	if not params then
		return
	end
	if self._params == nil then
		self._params = params
	end
	local ____self__params_16 = self._params
	local ____params_shield_amount_max_15 = params.shield_amount_max
	if ____params_shield_amount_max_15 == nil then
		____params_shield_amount_max_15 = self._params.shield_amount_max
	end
	____self__params_16.shield_amount_max = ____params_shield_amount_max_15
	local ____self__params_19 = self._params
	local ____math_min_18 = math.min
	local ____params_shield_amount_17 = params.shield_amount
	if ____params_shield_amount_17 == nil then
		____params_shield_amount_17 = self._params.shield_amount_max
	end
	____self__params_19.shield_amount = ____math_min_18(____params_shield_amount_17, self._params.shield_amount_max)
	self:SendBuffRefreshToClients()
	if self.GetModifierIncomingDamageConstant then
		self:GetModifierIncomingDamageConstant(nil)
	end
	if self.GetModifierIncomingPhysicalDamageConstant then
		self:GetModifierIncomingPhysicalDamageConstant(nil)
	end
	if self.GetModifierIncomingSpellDamageConstant then
		self:GetModifierIncomingSpellDamageConstant(nil)
	end
end
function sl_modifier_shield_base.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_shield_base.prototype.HandleCustomTransmitterData(self, params)
	self._params = params
end
function sl_modifier_shield_base.prototype.GetModifierIncomingDamageConstant(self, event)
	return self:_OnShieldBlockDamage(event)
end
function sl_modifier_shield_base.prototype.GetModifierIncomingPhysicalDamageConstant(self, event)
	return self:_OnShieldBlockDamage(event)
end
function sl_modifier_shield_base.prototype.GetModifierIncomingSpellDamageConstant(self, event)
	return self:_OnShieldBlockDamage(event)
end
function sl_modifier_shield_base.prototype._OnShieldBlockDamage(self, event)
	if IsClient() then
		local ____event_report_max_20 = event
		if ____event_report_max_20 ~= nil then
			____event_report_max_20 = ____event_report_max_20.report_max
		end
		if ____event_report_max_20 then
			local ____table__params_shield_amount_max_22 = self._params
			if ____table__params_shield_amount_max_22 ~= nil then
				____table__params_shield_amount_max_22 = ____table__params_shield_amount_max_22.shield_amount_max
			end
			return ____table__params_shield_amount_max_22
		else
			local ____table__params_shield_amount_24 = self._params
			if ____table__params_shield_amount_24 ~= nil then
				____table__params_shield_amount_24 = ____table__params_shield_amount_24.shield_amount
			end
			return ____table__params_shield_amount_24
		end
	else
		if not event then
			return
		end
		local ____event_26 = event
		local damage = ____event_26.damage
		local target = ____event_26.target
		local parent = self:GetParent()
		if parent ~= target then
			return
		end
		local ____table__params_shield_amount_27 = self._params
		if ____table__params_shield_amount_27 ~= nil then
			____table__params_shield_amount_27 = ____table__params_shield_amount_27.shield_amount
		end
		local ____temp_31 = not ____table__params_shield_amount_27
		if not ____temp_31 then
			local ____table__params_shield_amount_29 = self._params
			if ____table__params_shield_amount_29 ~= nil then
				____table__params_shield_amount_29 = ____table__params_shield_amount_29.shield_amount
			end
			____temp_31 = ____table__params_shield_amount_29 <= 0
		end
		if ____temp_31 then
			return
		end
		local blocked_damage = damage
		local ____self__params_32, ____shield_amount_33 = self._params, "shield_amount"
		____self__params_32[____shield_amount_33] = ____self__params_32[____shield_amount_33] - damage
		if self._params.shield_amount <= 0 then
			blocked_damage = damage - math.abs(self._params.shield_amount)
			self:Destroy()
		end
		self:SendBuffRefreshToClients()
		return -blocked_damage
	end
end
--- 全护盾
____exports.sl_modifier_shield_all = __TS__Class()
local sl_modifier_shield_all = ____exports.sl_modifier_shield_all
sl_modifier_shield_all.name = "sl_modifier_shield_all"
__TS__ClassExtends(sl_modifier_shield_all, sl_modifier_shield_base)
function sl_modifier_shield_all.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT }
end
--- 物理护盾
____exports.sl_modifier_shield_physical = __TS__Class()
local sl_modifier_shield_physical = ____exports.sl_modifier_shield_physical
sl_modifier_shield_physical.name = "sl_modifier_shield_physical"
__TS__ClassExtends(sl_modifier_shield_physical, sl_modifier_shield_base)
function sl_modifier_shield_physical.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT }
end
--- 魔法护盾
____exports.sl_modifier_shield_spell = __TS__Class()
local sl_modifier_shield_spell = ____exports.sl_modifier_shield_spell
sl_modifier_shield_spell.name = "sl_modifier_shield_spell"
__TS__ClassExtends(sl_modifier_shield_spell, sl_modifier_shield_base)
function sl_modifier_shield_spell.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT }
end
--- 免疫伤害
____exports.sl_modifier_immune_damage = __TS__Class()
local sl_modifier_immune_damage = ____exports.sl_modifier_immune_damage
sl_modifier_immune_damage.name = "sl_modifier_immune_damage"
__TS__ClassExtends(sl_modifier_immune_damage, SLModifierBase)
function sl_modifier_immune_damage.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.damage_immune
end
function sl_modifier_immune_damage.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function sl_modifier_immune_damage.prototype.GetModifierAvoidDamage(self, event)
	if not IsServer() then
		return
	end
	local unit = event.target
	if unit == self:GetParent() then
		return 1
	end
end
--- 固定攻击间隔
____exports.sl_modifier_override_attack_rate = __TS__Class()
local sl_modifier_override_attack_rate = ____exports.sl_modifier_override_attack_rate
sl_modifier_override_attack_rate.name = "sl_modifier_override_attack_rate"
__TS__ClassExtends(sl_modifier_override_attack_rate, SLModifierBase)
function sl_modifier_override_attack_rate.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_override_attack_rate.prototype.OnRefresh(self, params)
	self:_ApplyParam(params)
end
function sl_modifier_override_attack_rate.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	if not params.rate then
		return
	end
	self._rate = params.rate
	self:SendBuffRefreshToClients()
end
function sl_modifier_override_attack_rate.prototype.HandleCustomTransmitterData(self, data)
	self._rate = data.rate
end
function sl_modifier_override_attack_rate.prototype.AddCustomTransmitterData(self)
	return { rate = self._rate }
end
function sl_modifier_override_attack_rate.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_FIXED_ATTACK_RATE }
end
function sl_modifier_override_attack_rate.prototype.GetModifierFixedAttackRate(self)
	return self._rate
end
____exports.sl_modifier_invisible = __TS__Class()
local sl_modifier_invisible = ____exports.sl_modifier_invisible
sl_modifier_invisible.name = "sl_modifier_invisible"
__TS__ClassExtends(sl_modifier_invisible, SLModifierBase)
function sl_modifier_invisible.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("invisible_active")
end
function sl_modifier_invisible.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.invisible_start
end
function sl_modifier_invisible.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function sl_modifier_invisible.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVISIBLE] = true }
end
function sl_modifier_invisible.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
end
function sl_modifier_invisible.prototype.GetModifierInvisibilityLevel(self)
	return 1
end
function sl_modifier_invisible.prototype.GetDisableAutoAttack(self)
	return 1
end
function sl_modifier_invisible.prototype.OnAttack(self, event)
	if not IsServer() then
		return
	end
	if event.attacker == self:GetParent() then
		self:Destroy()
	end
end
function sl_modifier_invisible.prototype.OnAbilityFullyCast(self, event)
	if not IsServer() then
		return
	end
	if event.ability:GetCaster() == self:GetParent() then
		self:Destroy()
	end
end
--- 通用隐身（不破隐）
-- - 保留 sl_modifier_invisible 的隐身音效和特效
-- - 不禁用自动攻击
-- - 攻击和施法都不会解除隐身
____exports.sl_modifier_invisible_non_break = __TS__Class()
local sl_modifier_invisible_non_break = ____exports.sl_modifier_invisible_non_break
sl_modifier_invisible_non_break.name = "sl_modifier_invisible_non_break"
__TS__ClassExtends(sl_modifier_invisible_non_break, ____exports.sl_modifier_invisible)
function sl_modifier_invisible_non_break.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
____exports.sl_modifier_disable_healing = __TS__Class()
local sl_modifier_disable_healing = ____exports.sl_modifier_disable_healing
sl_modifier_disable_healing.name = "sl_modifier_disable_healing"
__TS__ClassExtends(sl_modifier_disable_healing, SLModifierBase)
function sl_modifier_disable_healing.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_HEALING }
end
function sl_modifier_disable_healing.prototype.GetDisableHealing(self)
	return 1
end
function sl_modifier_disable_healing.prototype.IsDebuff(self)
	return true
end
function sl_modifier_disable_healing.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.unheal_defbuff
end
function sl_modifier_disable_healing.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
____exports.sl_modifier_transmitter_data = __TS__Class()
local sl_modifier_transmitter_data = ____exports.sl_modifier_transmitter_data
sl_modifier_transmitter_data.name = "sl_modifier_transmitter_data"
__TS__ClassExtends(sl_modifier_transmitter_data, SLModifierBase)
function sl_modifier_transmitter_data.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._min_interval = StaticFrameTime
	self._transmitter_counts = 0
	self._transmitter_counts_key = DoUniqueString("__transmitter_counts__")
end
function sl_modifier_transmitter_data.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_transmitter_data.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_transmitter_data.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	if not params then
		return
	end
	if params.update_data == nil then
		return
	end
	self._params = params
	if params.update_data == 1 then
		self:_QueueSendBuffRefreshToClients()
	end
end
function sl_modifier_transmitter_data.prototype._CanSendBuff(self)
	local now = GameRules:GetGameTime()
	if not self._last_send_data_time then
		return true
	end
	if now - self._last_send_data_time >= self._min_interval then
		return true
	end
	return false
end
function sl_modifier_transmitter_data.prototype._QueueSendBuffRefreshToClients(self)
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
function sl_modifier_transmitter_data.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_transmitter_data.prototype._SendBuffRefreshToClientsAndRecord(self)
	self._last_send_data_time = GameRules:GetGameTime()
	self._transmitter_counts = self._transmitter_counts + 1
	self:SendBuffRefreshToClients()
end
function sl_modifier_transmitter_data.prototype.AddCustomTransmitterData(self)
	if not self._params then
		return
	end
	self._params[self._transmitter_counts_key] = self._transmitter_counts
	return self._params
end
function sl_modifier_transmitter_data.prototype.GetCustomParam(self, key)
	return self._params[key]
end
--- 默认隐藏，死亡移除，可驱散
____exports.sl_modifier_transmitter_data_debuff = __TS__Class()
local sl_modifier_transmitter_data_debuff = ____exports.sl_modifier_transmitter_data_debuff
sl_modifier_transmitter_data_debuff.name = "sl_modifier_transmitter_data_debuff"
__TS__ClassExtends(sl_modifier_transmitter_data_debuff, ____exports.sl_modifier_transmitter_data)
function sl_modifier_transmitter_data_debuff.prototype.IsDebuff(self)
	return true
end
function sl_modifier_transmitter_data_debuff.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_transmitter_data_debuff.prototype.IsPurgable(self)
	return true
end
function sl_modifier_transmitter_data_debuff.prototype.IsPermanent(self)
	return false
end
____exports.sl_modifier_debuff_immune = __TS__Class()
local sl_modifier_debuff_immune = ____exports.sl_modifier_debuff_immune
sl_modifier_debuff_immune.name = "sl_modifier_debuff_immune"
__TS__ClassExtends(sl_modifier_debuff_immune, ____exports.sl_modifier_transmitter_data)
function sl_modifier_debuff_immune.prototype.CheckState(self)
	return { [MODIFIER_STATE_DEBUFF_IMMUNE] = true }
end
function sl_modifier_debuff_immune.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.debuff_immune
end
function sl_modifier_debuff_immune.prototype.GetStatusEffectName(self)
	return GENERIC_PARTICLES.debuff_immune_status_effect
end
function sl_modifier_debuff_immune.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
function sl_modifier_debuff_immune.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end
function sl_modifier_debuff_immune.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____table__params_magic_resist_34 = self._params
	if ____table__params_magic_resist_34 ~= nil then
		____table__params_magic_resist_34 = ____table__params_magic_resist_34.magic_resist
	end
	local ____table__params_magic_resist_34_36 = ____table__params_magic_resist_34
	if ____table__params_magic_resist_34_36 == nil then
		____table__params_magic_resist_34_36 = 0
	end
	return ____table__params_magic_resist_34_36
end
____exports.sl_modifier_debt_debuff = __TS__Class()
local sl_modifier_debt_debuff = ____exports.sl_modifier_debt_debuff
sl_modifier_debt_debuff.name = "sl_modifier_debt_debuff"
__TS__ClassExtends(sl_modifier_debt_debuff, SLModifierBase)
function sl_modifier_debt_debuff.prototype.IsDebuff(self)
	return true
end
function sl_modifier_debt_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_debt_debuff.prototype.GetTexture(self)
	return "buff/debt"
end
sl_modifier_debt_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_simple", nil, getfenv()) },
	sl_modifier_debt_debuff
)
____exports.sl_modifier_debt_debuff = sl_modifier_debt_debuff
____exports.sl_modifier_ignore_attack_speed_limit = __TS__Class()
local sl_modifier_ignore_attack_speed_limit = ____exports.sl_modifier_ignore_attack_speed_limit
sl_modifier_ignore_attack_speed_limit.name = "sl_modifier_ignore_attack_speed_limit"
__TS__ClassExtends(sl_modifier_ignore_attack_speed_limit, SLModifierBase)
function sl_modifier_ignore_attack_speed_limit.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT }
end
function sl_modifier_ignore_attack_speed_limit.prototype.GetModifierAttackSpeed_Limit(self)
	if not IsServer() then
		return
	end
	return 1
end
sl_modifier_ignore_attack_speed_limit = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_simple", nil, getfenv()) },
	sl_modifier_ignore_attack_speed_limit
)
____exports.sl_modifier_ignore_attack_speed_limit = sl_modifier_ignore_attack_speed_limit
____exports.sl_modifier_test = __TS__Class()
local sl_modifier_test = ____exports.sl_modifier_test
sl_modifier_test.name = "sl_modifier_test"
__TS__ClassExtends(sl_modifier_test, SLModifierBase)
function sl_modifier_test.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_FOW_TEAM }
end
function sl_modifier_test.prototype.CheckState(self)
	return { [MODIFIER_STATE_BLIND] = true }
end
function sl_modifier_test.prototype.GetModifierFoWTeam(self)
	print("1")
	return 1
end
sl_modifier_test = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_simple", nil, getfenv()) },
	sl_modifier_test
)
____exports.sl_modifier_test = sl_modifier_test
return ____exports