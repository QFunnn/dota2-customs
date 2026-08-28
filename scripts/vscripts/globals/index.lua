--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "globals/index"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayForEach
local e = b.__TS__ArraySplice
local f = b.__TS__Number
local g = b.__TS__NumberIsFinite
local h = b.__TS__ObjectKeys
local i = b.__TS__StringSplit
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["15"] = 509,
		["16"] = 510,
		["17"] = 511,
		["19"] = 513,
		["20"] = 509,
		["24"] = 802,
		["25"] = 803,
		["26"] = 802,
		["27"] = 47,
		["28"] = 48,
		["30"] = 51,
		["31"] = 51,
		["33"] = 54,
		["34"] = 53,
		["35"] = 52,
		["36"] = 52,
		["37"] = 56,
		["38"] = 57,
		["39"] = 57,
		["40"] = 57,
		["41"] = 57,
		["42"] = 56,
		["43"] = 59,
		["44"] = 60,
		["45"] = 60,
		["46"] = 60,
		["47"] = 60,
		["48"] = 59,
		["49"] = 62,
		["50"] = 63,
		["51"] = 62,
		["52"] = 65,
		["53"] = 66,
		["54"] = 65,
		["55"] = 69,
		["56"] = 70,
		["57"] = 71,
		["58"] = 72,
		["59"] = 73,
		["60"] = 74,
		["61"] = 75,
		["64"] = 78,
		["72"] = 98,
		["73"] = 99,
		["74"] = 100,
		["75"] = 101,
		["76"] = 98,
		["80"] = 107,
		["81"] = 108,
		["82"] = 109,
		["83"] = 110,
		["84"] = 112,
		["87"] = 115,
		["88"] = 107,
		["90"] = 119,
		["91"] = 120,
		["92"] = 119,
		["99"] = 141,
		["100"] = 142,
		["101"] = 142,
		["102"] = 142,
		["103"] = 142,
		["104"] = 143,
		["105"] = 144,
		["108"] = 148,
		["109"] = 149,
		["112"] = 152,
		["113"] = 153,
		["116"] = 156,
		["117"] = 158,
		["118"] = 159,
		["119"] = 159,
		["120"] = 159,
		["121"] = 159,
		["123"] = 161,
		["124"] = 142,
		["125"] = 142,
		["126"] = 163,
		["127"] = 164,
		["128"] = 141,
		["132"] = 170,
		["133"] = 171,
		["134"] = 172,
		["135"] = 173,
		["136"] = 174,
		["139"] = 177,
		["140"] = 170,
		["146"] = 190,
		["147"] = 191,
		["148"] = 192,
		["149"] = 193,
		["151"] = 195,
		["154"] = 190,
		["155"] = 205,
		["156"] = 206,
		["158"] = 208,
		["160"] = 210,
		["161"] = 212,
		["162"] = 215,
		["163"] = 215,
		["164"] = 216,
		["165"] = 217,
		["166"] = 218,
		["167"] = 219,
		["168"] = 220,
		["171"] = 223,
		["172"] = 215,
		["173"] = 227,
		["174"] = 227,
		["175"] = 228,
		["176"] = 229,
		["177"] = 230,
		["178"] = 231,
		["179"] = 232,
		["182"] = 235,
		["183"] = 227,
		["184"] = 239,
		["185"] = 239,
		["186"] = 240,
		["187"] = 241,
		["188"] = 242,
		["189"] = 243,
		["190"] = 244,
		["191"] = 245,
		["193"] = 247,
		["197"] = 251,
		["198"] = 239,
		["199"] = 255,
		["200"] = 255,
		["201"] = 256,
		["202"] = 257,
		["203"] = 258,
		["204"] = 259,
		["205"] = 260,
		["206"] = 261,
		["208"] = 263,
		["212"] = 267,
		["213"] = 255,
		["214"] = 271,
		["215"] = 271,
		["216"] = 272,
		["217"] = 273,
		["218"] = 274,
		["219"] = 275,
		["220"] = 276,
		["223"] = 279,
		["224"] = 271,
		["230"] = 288,
		["231"] = 288,
		["232"] = 288,
		["234"] = 289,
		["235"] = 288,
		["241"] = 298,
		["242"] = 298,
		["243"] = 298,
		["245"] = 299,
		["246"] = 299,
		["247"] = 299,
		["248"] = 299,
		["249"] = 298,
		["256"] = 309,
		["257"] = 310,
		["258"] = 311,
		["259"] = 312,
		["260"] = 316,
		["261"] = 317,
		["262"] = 318,
		["263"] = 319,
		["264"] = 320,
		["265"] = 321,
		["266"] = 322,
		["267"] = 323,
		["268"] = 324,
		["269"] = 325,
		["270"] = 325,
		["271"] = 325,
		["272"] = 325,
		["273"] = 324,
		["274"] = 324,
		["275"] = 324,
		["278"] = 330,
		["279"] = 330,
		["280"] = 330,
		["281"] = 330,
		["282"] = 334,
		["283"] = 335,
		["284"] = 336,
		["286"] = 338,
		["287"] = 310,
		["288"] = 341,
		["289"] = 342,
		["290"] = 343,
		["291"] = 344,
		["292"] = 345,
		["295"] = 348,
		["296"] = 348,
		["297"] = 348,
		["298"] = 348,
		["299"] = 349,
		["301"] = 351,
		["302"] = 352,
		["303"] = 352,
		["304"] = 352,
		["305"] = 353,
		["306"] = 354,
		["307"] = 355,
		["309"] = 357,
		["311"] = 359,
		["312"] = 360,
		["313"] = 361,
		["314"] = 362,
		["315"] = 363,
		["316"] = 364,
		["317"] = 365,
		["318"] = 366,
		["320"] = 352,
		["321"] = 352,
		["322"] = 369,
		["323"] = 309,
		["328"] = 377,
		["329"] = 378,
		["330"] = 377,
		["340"] = 391,
		["341"] = 391,
		["342"] = 391,
		["344"] = 391,
		["345"] = 391,
		["347"] = 391,
		["348"] = 391,
		["350"] = 391,
		["351"] = 391,
		["353"] = 391,
		["354"] = 391,
		["356"] = 391,
		["357"] = 391,
		["359"] = 392,
		["360"] = 395,
		["361"] = 396,
		["362"] = 397,
		["363"] = 398,
		["364"] = 399,
		["365"] = 400,
		["366"] = 401,
		["368"] = 403,
		["369"] = 405,
		["371"] = 408,
		["375"] = 413,
		["376"] = 414,
		["377"] = 415,
		["379"] = 417,
		["382"] = 421,
		["383"] = 423,
		["384"] = 391,
		["389"] = 431,
		["390"] = 432,
		["391"] = 433,
		["392"] = 434,
		["393"] = 435,
		["394"] = 436,
		["396"] = 438,
		["397"] = 431,
		["402"] = 446,
		["403"] = 447,
		["404"] = 448,
		["406"] = 450,
		["407"] = 446,
		["409"] = 454,
		["410"] = 455,
		["411"] = 455,
		["412"] = 456,
		["413"] = 457,
		["414"] = 458,
		["417"] = 462,
		["418"] = 463,
		["419"] = 464,
		["420"] = 465,
		["421"] = 466,
		["422"] = 467,
		["426"] = 472,
		["427"] = 454,
		["433"] = 482,
		["434"] = 483,
		["435"] = 484,
		["436"] = 485,
		["437"] = 486,
		["440"] = 482,
		["445"] = 496,
		["446"] = 497,
		["447"] = 498,
		["448"] = 499,
		["449"] = 500,
		["452"] = 496,
		["457"] = 521,
		["458"] = 522,
		["459"] = 523,
		["460"] = 524,
		["461"] = 525,
		["462"] = 526,
		["464"] = 528,
		["465"] = 528,
		["466"] = 528,
		["467"] = 528,
		["469"] = 530,
		["471"] = 532,
		["472"] = 521,
		["477"] = 540,
		["478"] = 541,
		["479"] = 542,
		["480"] = 543,
		["481"] = 544,
		["482"] = 545,
		["485"] = 549,
		["487"] = 551,
		["488"] = 540,
		["494"] = 560,
		["495"] = 560,
		["496"] = 560,
		["498"] = 561,
		["499"] = 562,
		["500"] = 563,
		["501"] = 564,
		["502"] = 564,
		["503"] = 564,
		["504"] = 564,
		["505"] = 565,
		["506"] = 565,
		["507"] = 565,
		["509"] = 567,
		["510"] = 560,
		["516"] = 576,
		["517"] = 576,
		["518"] = 576,
		["520"] = 577,
		["521"] = 578,
		["523"] = 580,
		["524"] = 581,
		["526"] = 582,
		["527"] = 582,
		["528"] = 583,
		["529"] = 582,
		["532"] = 585,
		["533"] = 586,
		["534"] = 587,
		["537"] = 590,
		["538"] = 576,
		["543"] = 598,
		["544"] = 599,
		["545"] = 600,
		["546"] = 601,
		["547"] = 602,
		["548"] = 603,
		["550"] = 605,
		["553"] = 608,
		["556"] = 611,
		["557"] = 598,
		["563"] = 620,
		["564"] = 621,
		["565"] = 622,
		["566"] = 623,
		["567"] = 624,
		["568"] = 625,
		["569"] = 626,
		["571"] = 628,
		["574"] = 631,
		["578"] = 635,
		["579"] = 620,
		["585"] = 644,
		["586"] = 644,
		["587"] = 644,
		["589"] = 645,
		["590"] = 646,
		["591"] = 647,
		["592"] = 648,
		["593"] = 644,
		["601"] = 659,
		["602"] = 660,
		["603"] = 659,
		["610"] = 670,
		["611"] = 671,
		["612"] = 672,
		["613"] = 673,
		["614"] = 674,
		["615"] = 675,
		["616"] = 670,
		["624"] = 686,
		["625"] = 687,
		["626"] = 688,
		["627"] = 689,
		["630"] = 692,
		["631"] = 686,
		["639"] = 703,
		["640"] = 704,
		["641"] = 705,
		["642"] = 706,
		["643"] = 707,
		["644"] = 708,
		["645"] = 710,
		["646"] = 711,
		["648"] = 713,
		["649"] = 715,
		["650"] = 716,
		["651"] = 717,
		["652"] = 718,
		["654"] = 720,
		["655"] = 722,
		["657"] = 725,
		["658"] = 703,
		["664"] = 734,
		["665"] = 734,
		["666"] = 735,
		["667"] = 736,
		["668"] = 737,
		["669"] = 738,
		["670"] = 739,
		["671"] = 740,
		["672"] = 741,
		["673"] = 742,
		["675"] = 744,
		["677"] = 746,
		["679"] = 748,
		["680"] = 734,
		["685"] = 756,
		["686"] = 757,
		["687"] = 758,
		["688"] = 758,
		["689"] = 758,
		["690"] = 758,
		["691"] = 758,
		["692"] = 756,
		["696"] = 765,
		["697"] = 766,
		["698"] = 765,
		["704"] = 784,
		["705"] = 785,
		["706"] = 786,
		["707"] = 787,
		["708"] = 788,
		["709"] = 789,
		["710"] = 790,
		["711"] = 791,
		["713"] = 793,
		["715"] = 795,
		["716"] = 784,
		["718"] = 807,
		["719"] = 808,
		["720"] = 809,
		["721"] = 810,
		["722"] = 811,
		["723"] = 812,
		["727"] = 816,
		["728"] = 807,
		["730"] = 820,
		["731"] = 821,
		["732"] = 822,
		["733"] = 823,
		["734"] = 824,
		["737"] = 820,
		["746"] = 838,
		["747"] = 839,
		["748"] = 839,
		["749"] = 839,
		["750"] = 839,
		["751"] = 839,
		["752"] = 839,
		["753"] = 839,
		["754"] = 839,
		["755"] = 839,
		["756"] = 838,
		["762"] = 848,
		["763"] = 849,
		["764"] = 850,
		["766"] = 852,
		["767"] = 853,
		["769"] = 856,
		["770"] = 857,
		["771"] = 858,
		["773"] = 860,
		["774"] = 861,
		["776"] = 863,
		["780"] = 867,
		["781"] = 848,
		["784"] = 873,
		["785"] = 874,
		["786"] = 874,
		["788"] = 875,
		["789"] = 876,
		["790"] = 877,
		["791"] = 878,
		["792"] = 879,
		["793"] = 880,
		["794"] = 881,
		["795"] = 882,
		["797"] = 884,
		["798"] = 873,
		["801"] = 889,
		["802"] = 890,
		["803"] = 891,
		["804"] = 892,
		["805"] = 893,
		["806"] = 894,
		["807"] = 895,
		["808"] = 896,
		["809"] = 897,
		["810"] = 898,
		["813"] = 899,
		["814"] = 900,
		["816"] = 902,
		["818"] = 904,
		["820"] = 906,
		["821"] = 889,
		["822"] = 908,
		["823"] = 909,
		["824"] = 910,
		["825"] = 911,
		["827"] = 913,
		["828"] = 914,
		["829"] = 914,
		["830"] = 914,
		["831"] = 914,
		["832"] = 914,
		["833"] = 915,
		["834"] = 913,
		["840"] = 923,
		["841"] = 924,
		["842"] = 924,
		["844"] = 925,
		["845"] = 925,
		["847"] = 926,
		["848"] = 926,
		["850"] = 927,
		["851"] = 927,
		["852"] = 927,
		["854"] = 927,
		["855"] = 928,
		["856"] = 929,
		["857"] = 930,
		["858"] = 931,
		["860"] = 933,
		["861"] = 934,
		["862"] = 923,
		["863"] = 936,
		["864"] = 937,
		["865"] = 937,
		["867"] = 936,
		["869"] = 941,
		["870"] = 942,
		["871"] = 943,
		["873"] = 941,
		["875"] = 947,
		["876"] = 948,
		["877"] = 949,
		["879"] = 947,
		["880"] = 953,
		["881"] = 954,
		["882"] = 955,
		["884"] = 957,
		["885"] = 958,
		["886"] = 959,
		["887"] = 960,
		["888"] = 961,
		["889"] = 962,
		["890"] = 963,
		["891"] = 964,
		["892"] = 965,
		["894"] = 967,
		["896"] = 953,
		["898"] = 971,
		["899"] = 972,
		["900"] = 973,
		["901"] = 974,
		["902"] = 976,
		["903"] = 977,
		["904"] = 978,
		["905"] = 979,
		["907"] = 981,
		["908"] = 971,
		["910"] = 984,
		["911"] = 985,
		["912"] = 986,
		["913"] = 987,
		["914"] = 988,
		["915"] = 989,
		["916"] = 991,
		["917"] = 992,
		["918"] = 993,
		["919"] = 994,
		["920"] = 995,
		["921"] = 996,
		["922"] = 997,
		["925"] = 1000,
		["926"] = 1001,
		["927"] = 1003,
		["929"] = 1005,
		["930"] = 984,
		["932"] = 1011,
		["933"] = 1012,
		["934"] = 1013,
		["935"] = 1014,
		["936"] = 1015,
		["937"] = 1016,
		["939"] = 1025,
		["940"] = 1026,
		["942"] = 1028,
		["943"] = 1028,
		["944"] = 1028,
		["945"] = 1029,
		["946"] = 1030,
		["947"] = 1031,
		["949"] = 1033,
		["950"] = 1028,
		["951"] = 1028,
		["952"] = 1028,
		["953"] = 1035,
		["955"] = 1012,
		["956"] = 1038,
		["957"] = 1039,
		["958"] = 1040,
		["959"] = 1041,
		["960"] = 1042,
		["962"] = 1057,
		["963"] = 1058,
		["965"] = 1060,
		["966"] = 1061,
		["967"] = 1061,
		["968"] = 1061,
		["969"] = 1061,
		["970"] = 1062,
		["971"] = 1063,
		["972"] = 1064,
		["974"] = 1067,
		["976"] = 1069,
		["977"] = 1061,
		["978"] = 1061,
		["980"] = 1038,
		["981"] = 1073,
		["982"] = 1075,
		["983"] = 1073,
		["985"] = 1079,
		["986"] = 1081,
		["987"] = 1083,
		["989"] = 1086,
		["990"] = 1088,
		["992"] = 1091,
		["993"] = 1079,
		["995"] = 1095,
		["996"] = 1097,
		["997"] = 1099,
		["999"] = 1102,
		["1000"] = 1104,
		["1002"] = 1107,
		["1003"] = 1095,
		["1005"] = 1111,
		["1006"] = 1113,
		["1007"] = 1113,
		["1009"] = 1115,
		["1010"] = 1115,
		["1012"] = 1117,
		["1013"] = 1118,
		["1014"] = 1119,
		["1015"] = 1111,
		["1017"] = 1125,
		["1018"] = 1126,
		["1019"] = 1127,
		["1020"] = 1126,
	}
)
function ArrayRemoveByIndex(k, l)
	if l == nil then
		l = #k
	end
	return table.remove(k, l + 1)
end
function IsValid(m)
	return m ~= nil and not m:IsNull()
end
if _G.aModules == nil then
	_G.aModules = {}
end
CModule = c()
CModule.name = "CModule"
function CModule.prototype.____constructor(self)
	aModules[#aModules + 1] = self
end
function CModule.prototype.init(self, n) end
function CModule.initialize(self)
	d(aModules, function(o, p)
		return p:init(false)
	end)
end
function CModule.reload(self)
	d(aModules, function(o, p)
		return p:init(true)
	end)
end
function CModule.prototype.print(self, ...)
	print(("[" .. self.constructor.name) .. "]: ", ...)
end
function CModule.prototype.isModule(self)
	return true
end
if Activated == nil then
	_G.Activated = false
	_G.GameEventListenerIDs = {}
	_G.CustomUIEventListenerIDs = {}
	_G.tRequestEvents = {}
	if IsServer() then
		_G.TimerEventListenerIDs = {}
	end
else
	_G.Activated = true
end
function GameEvent(q, r, s)
	local t = ListenToGameEvent(q, r, s)
	GameEventListenerIDs[#GameEventListenerIDs + 1] = t
	return t
end
function StopGameEvent(t)
	for u = #GameEventListenerIDs - 1, 0, -1 do
		local v = GameEventListenerIDs[u + 1]
		if v == t then
			table.remove(GameEventListenerIDs, u + 1)
		end
	end
	StopListeningToGameEvent(t)
end
function RegisterClientEvent(w, x, s)
	tRequestEvents[w] = { callback = x, context = s }
end
function CustomUIEvent(q, r, s)
	local t = CustomGameEventManager:RegisterListener(q, function(y, ...)
		local z = { ... }
		local A = EntIndexToHScript(y)
		if not IsValid(A) then
			return
		end
		local B = A:GetPlayerID()
		if not PlayerResource:IsValidPlayerID(B) then
			return
		end
		local C = z[1]
		if C == nil then
			return
		end
		C.PlayerID = B
		if s ~= nil then
			return r(s, unpack(z))
		end
		return r(unpack(z))
	end)
	CustomUIEventListenerIDs[#CustomUIEventListenerIDs + 1] = t
	return t
end
function StopCustomUIEvent(t)
	for u = #CustomUIEventListenerIDs - 1, 0, -1 do
		local v = CustomUIEventListenerIDs[u + 1]
		if v == t then
			e(CustomUIEventListenerIDs, u, 1)
		end
	end
	CustomGameEventManager:UnregisterListener(t)
end
function RequestEvent(q, r, s)
	if Request ~= nil then
		if IsServer() then
			Request:RegisterServerEvent(q, r, s)
		else
			Request:RegisterClientEvent(q, r, s)
		end
	end
end
if IsServer() then
	require("globals.server")
else
	require("globals.client")
end
require("globals.unique")
_G.ZERO_VALUE = 1 / 10000000000
function AdditionMultiplicationPercentage(...)
	local z = { ... }
	local D = 0
	for u = 0, #z - 1, 1 do
		local E = z[u + 1]
		if type(E) == "number" then
			D = ((1 + D * 0.01) * (1 + E * 0.01) - 1) * 100
		end
	end
	return D
end
function SubtractionMultiplicationPercentage(...)
	local z = { ... }
	local D = 0
	for u = 0, #z - 1, 1 do
		local E = z[u + 1]
		if type(E) == "number" then
			D = (1 - (1 - D * 0.01) * (1 - E * 0.01)) * 100
		end
	end
	return D
end
function Maximum(...)
	local z = { ... }
	local D = ZERO_VALUE
	for u = 0, #z - 1, 1 do
		local E = z[u + 1]
		if type(E) == "number" then
			if D == ZERO_VALUE then
				D = E
			else
				D = math.max(D, E)
			end
		end
	end
	return D
end
function Minimum(...)
	local z = { ... }
	local D = ZERO_VALUE
	for u = 0, #z - 1, 1 do
		local E = z[u + 1]
		if type(E) == "number" then
			if D == ZERO_VALUE then
				D = E
			else
				D = math.min(D, E)
			end
		end
	end
	return D
end
function First(...)
	local z = { ... }
	local D = nil
	for u = 0, #z - 1, 1 do
		local E = z[u + 1]
		if type(E) ~= "nil" then
			D = E
		end
	end
	return D
end
function finiteNumber(u, F)
	if F == nil then
		F = 0
	end
	return g(f(u)) and u or F
end
function toFiniteNumber(u, F)
	if F == nil then
		F = 0
	end
	return finiteNumber(f(u), F)
end
function parse_conditional(G, x)
	local function H(I)
		local J = "[&|]"
		local K = {}
		local u = 0
		local L = 0
		local M = 0
		local l = 0
		local N
		while true do
			u, L = string.find(I, J, u + 1)
			if u == nil then
				K[M + 1] = { str = string.sub(I, l, string.len(I)), operator = N }
				break
			end
			K[M + 1] = { str = string.sub(I, l, u - 1), operator = N }
			l = u + L - (u - 1)
			M = M + 1
			N = string.sub(I, u, L)
		end
		return K
	end
	local O = nil
	G = string.gsub(G, "%s", "")
	while true do
		local u, L = string.find(G, "%b()")
		if u == nil then
			break
		end
		O = parse_conditional(string.sub(G, u + 1, L - 1), x)
		G = (string.sub(G, 1, u - 1) .. tostring(O)) .. string.sub(G, L + 1, -1)
	end
	local P = H(G)
	d(P, function(o, E, u)
		local K
		if E.str ~= "false" and E.str ~= "true" then
			K = x(E.str)
		else
			K = E.str == "true"
		end
		if O == nil then
			O = K
		elseif E.operator == nil then
			O = K
		elseif E.operator == "|" then
			O = O or K
		elseif E.operator == "&" then
			O = O and K
		end
	end)
	return O or false
end
function IsLeapYear(Q)
	return Q % 4 == 0 and Q % 100 ~= 0 or Q % 400 == 0
end
function toUnixTime(Q, R, S, T, U, V)
	if Q == nil then
		Q = 0
	end
	if R == nil then
		R = 0
	end
	if S == nil then
		S = 0
	end
	if T == nil then
		T = 0
	end
	if U == nil then
		U = 0
	end
	if V == nil then
		V = 0
	end
	local W = V + U * 60 + T * 60 * 60 + (S - 1) * 86400
	local X = 0
	local Y = R - 1
	for u = 1, Y, 1 do
		if u == 1 or u == 3 or u == 5 or u == 7 or u == 8 or u == 10 or u == 12 then
			X = X + 31
		elseif u == 4 or u == 6 or u == 9 or u == 11 then
			X = X + 30
		else
			if IsLeapYear(Q) then
				X = X + 29
			else
				X = X + 28
			end
		end
	end
	for u = 1970, Q - 1, 1 do
		if IsLeapYear(u) then
			X = X + 366
		else
			X = X + 365
		end
	end
	W = W + X * 86400
	return W
end
function RandomValue(Z)
	local _ = h(Z)
	if #_ > 0 then
		local u = RandomInt(0, #_ - 1)
		local a0 = _[u + 1]
		return Z[a0]
	end
	return nil
end
function GetRandomElement(P)
	if #P > 0 then
		return P[RandomInt(0, #P - 1) + 1]
	end
	return nil
end
function GetRandomElementByWeight(a1)
	local a2 = 0
	local a3 = 0
	for a4, D in pairs(a1) do
		if D > 0 then
			a2 = a2 + D
		end
	end
	local a5 = math.random(1, a2)
	for a6, D in pairs(a1) do
		if D > 0 then
			a3 = a3 + D
			if a5 <= a3 then
				return a6
			end
		end
	end
	return ""
end
function TableFindKey(Z, E)
	for a7, a8 in pairs(Z) do
		local a8 = Z[a7]
		if E == a8 then
			return a7
		end
	end
end
function ArrayRemove(Z, E)
	for u = #Z - 1, 0, -1 do
		if Z[u + 1] == E then
			ArrayRemoveByIndex(Z, u)
			return { E, u }
		end
	end
end
function deepcopy(a9)
	local aa
	if type(a9) == "table" then
		aa = {}
		for a7, ab in pairs(a9) do
			aa[deepcopy(a7)] = deepcopy(ab)
		end
		setmetatable(aa, deepcopy(getmetatable(a9)))
	else
		aa = a9
	end
	return aa
end
function shallowcopy(a9)
	local aa
	if type(a9) == "table" then
		aa = {}
		for a7, ab in pairs(a9) do
			aa[a7] = ab
		end
	else
		aa = a9
	end
	return aa
end
function ShuffledList(k, ac)
	if ac == nil then
		ac = false
	end
	local Z = ac and k or shallowcopy(k)
	local u = #Z
	while u > 0 do
		local ad = math.random()
		local ae = u
		u = ae - 1
		local L = math.floor(ad * ae)
		local af = { Z[u + 1], Z[L + 1] }
		Z[L + 1] = af[1]
		Z[u + 1] = af[2]
	end
	return Z
end
function PickList(ag, ah, ai)
	if ai == nil then
		ai = false
	end
	if ah > #ag then
		return ag
	end
	local aa = ShuffledList(ag, ai)
	local aj = {}
	do
		local u = 0
		while u < ah do
			aj[#aj + 1] = aa[u + 1]
			u = u + 1
		end
	end
	if ai then
		for o, v in ipairs(aj) do
			ArrayRemove(ag, v)
		end
	end
	return aj
end
function TableOverride(ak, al)
	for a0 in pairs(al) do
		local E = al[a0]
		if type(E) == "table" then
			if type(ak[a0]) == "table" then
				ak[a0] = TableOverride(ak[a0], E)
			else
				ak[a0] = TableOverride({}, E)
			end
		else
			ak[a0] = E
		end
	end
	return ak
end
function TableReplace(ak, al)
	for a0 in pairs(al) do
		if ak[a0] ~= nil then
			local E = al[a0]
			if type(E) == "table" then
				if type(ak[a0]) == "table" then
					ak[a0] = TableOverride(ak[a0], E)
				else
					ak[a0] = TableOverride({}, E)
				end
			else
				ak[a0] = E
			end
		end
	end
	return ak
end
function Round(am, an)
	if an == nil then
		an = 0
	end
	local ao = am > 0 and 1 or -1
	am = math.abs(am)
	local u = 10 ^ an
	return ao * math.floor(am * u + 0.5) / u
end
function IsLineCross(ap, aq, ar, as)
	return math.min(ap.x, aq.x) <= math.max(ar.x, as.x)
		and math.min(ar.x, as.x) <= math.max(ap.x, aq.x)
		and math.min(ap.y, aq.y) <= math.max(ar.y, as.y)
		and math.min(ar.y, as.y) <= math.max(ap.y, aq.y)
end
function IsCross(at, au, av)
	local aw = au.x - at.x
	local ax = au.y - at.y
	local ay = av.x - at.x
	local az = av.y - at.y
	return aw * az - ay * ax
end
function IsIntersect(at, au, av, aA)
	if IsLineCross(at, au, av, aA) then
		if IsCross(at, au, av) * IsCross(at, au, aA) <= 0 and IsCross(av, aA, at) * IsCross(av, aA, au) <= 0 then
			return true
		end
	end
	return false
end
function GetCrossPoint(at, au, aB, aC)
	if IsIntersect(at, au, aB, aC) then
		local aD = 0
		local aE = 0
		local aF = (aC.x - aB.x) * (at.y - au.y) - (au.x - at.x) * (aB.y - aC.y)
		local aG = (at.y - aB.y) * (au.x - at.x) * (aC.x - aB.x)
			+ aB.x * (aC.y - aB.y) * (au.x - at.x)
			- at.x * (au.y - at.y) * (aC.x - aB.x)
		if aF == 0 then
			return vec3_invalid
		end
		aD = aG / aF
		aF = (at.x - au.x) * (aC.y - aB.y) - (au.y - at.y) * (aB.x - aC.x)
		aG = au.y * (at.x - au.x) * (aC.y - aB.y)
			+ (aC.x - au.x) * (aC.y - aB.y) * (at.y - au.y)
			- aC.y * (aB.x - aC.x) * (au.y - at.y)
		if aF == 0 then
			return vec3_invalid
		end
		aE = aG / aF
		return Vector(aD, aE, 0)
	end
	return vec3_invalid
end
function Bessel(Z, ...)
	local aH = { ... }
	if #aH == 1 then
		return aH[2]
	elseif #aH > 1 then
		while #aH > 2 do
			local aI = {}
			for u = 0, #aH - 2, 1 do
				local aJ = LerpVectors(aH[u + 1], aH[u + 1 + 1], Z)
				aI[#aI + 1] = aJ
			end
			aH = aI
		end
		return LerpVectors(aH[2], aH[3], Z)
	end
	return vec3_invalid
end
function StringToVector(I)
	local P = i(I, " ")
	return Vector(toFiniteNumber(P[1]), toFiniteNumber(P[2]), toFiniteNumber(P[3]))
end
function VectorToString(E)
	return (((tostring(E.x) .. " ") .. tostring(E.y)) .. " ") .. tostring(E.z)
end
function IsPointInPolygon(aK, aL)
	local L = #aL
	local O = 0
	for u = 1, #aL, 1 do
		local aM = aL[L]
		local aN = aL[u]
		if (aN.y < aK.y and aM.y >= aK.y or aM.y < aK.y and aN.y >= aK.y) and (aN.x <= aK.x or aM.x <= aK.x) then
			O = bit.bxor(O, aN.x + (aK.y - aN.y) / (aM.y - aN.y) * (aM.x - aN.x) < aK.x and 1 or 0)
		end
		L = u
	end
	return O == 1
end
function IsInjurable(...)
	local aO = true
	for u = 1, select("#", ...) do
		local aP = select(u, ...)
		if not IsValid(aP) or not aP:IsAlive() then
			aO = false
			break
		end
	end
	return aO
end
function defaultValue(...)
	for u = 1, select("#", ...) do
		local E = select(u, ...)
		if E ~= nil then
			return E
		end
	end
end
function CreateCasterThinker(aQ, aR, aS, aT, aU)
	return CreateModifierThinker(aQ, aR, aS, aT, aU, aQ:GetTeamNumber(), false)
end
function ServiceTableOverride(ak, aV)
	if ak == nil then
		return aV
	end
	if aV == nil or type(aV) ~= "table" then
		return ak
	end
	for a0, E in pairs(aV) do
		if type(E) == "table" then
			ak[a0] = ServiceTableOverride(ak[a0], E)
		else
			if E == "DELETE" then
				ak[a0] = nil
			else
				ak[a0] = E
			end
		end
	end
	return ak
end
function PfromC(aW)
	if aW == 0 then
		return 1
	end
	local aX = 0
	local aY = 0
	local aZ = 0
	local a_ = math.ceil(1 / aW)
	for b0 = 1, a_, 1 do
		aX = math.min(1, b0 * aW) * (1 - aY)
		aY = aY + aX
		aZ = aZ + b0 * aX
	end
	return 1 / aZ
end
function CfromP(b1)
	local b2 = b1
	local b3 = 0
	local b4
	local at
	local au = 1
	while true do
		b4 = (b2 + b3) / 2
		at = PfromC(b4)
		if math.abs(at - au) <= 0 then
			break
		end
		if at > b1 then
			b2 = b4
		else
			b3 = b4
		end
		au = at
	end
	return b4
end
PSEUDO_RANDOM_C = {}
for u = 0, 100, 1 do
	local b5 = CfromP(u * 0.01)
	PSEUDO_RANDOM_C[u + 1] = b5
end
function PRD_C(b6)
	b6 = Clamp(math.floor(b6), 0, 100)
	return PSEUDO_RANDOM_C[b6 + 1]
end
function PRD(al, b6, b7)
	if type(al) ~= "table" then
		return false
	end
	if b6 >= 100 then
		return true
	end
	if al.PSEUDO_RANDOM_RECORDING_LIST == nil then
		al.PSEUDO_RANDOM_RECORDING_LIST = {}
	end
	local b8 = al.PSEUDO_RANDOM_RECORDING_LIST[b7]
	if b8 == nil then
		b8 = 1
	end
	local b0 = b8
	local b5 = PRD_C(b6)
	if RandomFloat(0, 1) <= b5 * b0 then
		al.PSEUDO_RANDOM_RECORDING_LIST[b7] = 1
		return true
	end
	al.PSEUDO_RANDOM_RECORDING_LIST[b7] = b0 + 1
	return false
end
function ClearPRDRecord(al)
	if type(al) == "table" and al.PSEUDO_RANDOM_RECORDING_LIST ~= nil then
		al.PSEUDO_RANDOM_RECORDING_LIST = nil
	end
end
function SaveData(al, a7, ab)
	if al then
		al[a7] = ab
	end
end
function LoadData(al, a7)
	if al then
		return al[a7]
	end
end
function getBytes(b9)
	if not b9 then
		return 0
	end
	local ba = string.byte(b9)
	if ba < 127 then
		return 1
	elseif ba <= 223 then
		return 2
	elseif ba <= 239 then
		return 3
	elseif ba <= 247 then
		return 4
	else
		return 0
	end
end
function Utf8StringLength(I)
	local bb = I
	local bc = 0
	local bd = 0
	while string.len(bb) > 0 do
		bd = bd + getBytes(bb)
		bb = string.sub(I, bd + 1)
		bc = bc + 1
	end
	return bc
end
function Utf8StringSub(I, be, bf)
	local bb = I
	local bg = 1
	local bh = -1
	local bc = 0
	local bd = 0
	be = math.max(be, 1)
	bf = bf or -1
	while string.len(bb) > 0 do
		if bc == be - 1 then
			bg = bd + 1
		elseif bc == bf then
			bh = bd
			break
		end
		bd = bd + getBytes(bb)
		bb = string.sub(I, bd + 1)
		bc = bc + 1
	end
	return string.sub(I, bg, bh)
end
BaseEntity = IsServer() and CBaseEntity or C_BaseEntity
BaseEntity.Timer = function(self, bi, bj, bk)
	if bk == nil then
		bk = bj
		bj = bi
		bi = DoUniqueString("Timer")
	end
	if IsServer() then
		return TimerManager:Timer(self, bj, bk)
	else
		self:SetContextThink(bi, function()
			local K = bk()
			if type(K) == "number" then
				K = math.max(FRAME_TIME, K)
			end
			return K
		end, bj)
		return bi
	end
end
BaseEntity.GameTimer = function(self, bi, bj, bk)
	if bk == nil then
		bk = bj
		bj = bi
		bi = DoUniqueString("GameTimer")
	end
	if IsServer() then
		return TimerManager:GameTimer(self, bj, bk)
	else
		local bl = GameRules:GetGameTime() + math.max(FRAME_TIME, bj)
		return self:Timer(bi, bj, function()
			if GameRules:GetGameTime() >= bl then
				local K = bk()
				if type(K) == "number" then
				end
				return K
			end
			return 0
		end)
	end
end
BaseEntity.StopTimer = function(self, bi)
	TimerManager:StopTimer(bi)
end
function CalcDistance(bm, bn)
	if bm.GetAbsOrigin then
		bm = bm:GetAbsOrigin()
	end
	if bn.GetAbsOrigin then
		bn = bn:GetAbsOrigin()
	end
	return (bm - bn):Length2D()
end
function CalcDirection(bm, bn)
	if bm.GetAbsOrigin then
		bm = bm:GetAbsOrigin()
	end
	if bn.GetAbsOrigin then
		bn = bn:GetAbsOrigin()
	end
	return (bm - bn):Normalized()
end
function CalcDirection2D(bo, bp)
	if bo.GetAbsOrigin ~= nil then
		bo = bo:GetAbsOrigin()
	end
	if bp.GetAbsOrigin ~= nil then
		bp = bp:GetAbsOrigin()
	end
	local bq = bo - bp
	bq.z = 0
	return bq:Normalized()
end
do
	local br = IsServer() and CDOTA_BaseNPC or C_DOTA_BaseNPC
	br.GetUltiPower = function(self)
		return GetUltiPower(self)
	end
end