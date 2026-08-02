--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["15"] = 499,
		["16"] = 500,
		["17"] = 501,
		["19"] = 503,
		["20"] = 499,
		["21"] = 47,
		["22"] = 48,
		["24"] = 51,
		["25"] = 51,
		["27"] = 54,
		["28"] = 53,
		["29"] = 52,
		["30"] = 52,
		["31"] = 56,
		["32"] = 57,
		["33"] = 57,
		["34"] = 57,
		["35"] = 57,
		["36"] = 56,
		["37"] = 59,
		["38"] = 60,
		["39"] = 60,
		["40"] = 60,
		["41"] = 60,
		["42"] = 59,
		["43"] = 62,
		["44"] = 63,
		["45"] = 62,
		["46"] = 65,
		["47"] = 66,
		["48"] = 65,
		["49"] = 69,
		["50"] = 70,
		["51"] = 71,
		["52"] = 72,
		["53"] = 73,
		["54"] = 74,
		["55"] = 75,
		["58"] = 78,
		["66"] = 98,
		["67"] = 99,
		["68"] = 100,
		["69"] = 101,
		["70"] = 98,
		["74"] = 107,
		["75"] = 108,
		["76"] = 109,
		["77"] = 110,
		["78"] = 112,
		["81"] = 115,
		["82"] = 107,
		["84"] = 119,
		["85"] = 120,
		["86"] = 119,
		["93"] = 141,
		["94"] = 142,
		["95"] = 142,
		["96"] = 142,
		["97"] = 148,
		["98"] = 149,
		["100"] = 151,
		["101"] = 142,
		["102"] = 142,
		["103"] = 153,
		["104"] = 154,
		["105"] = 141,
		["109"] = 160,
		["110"] = 161,
		["111"] = 162,
		["112"] = 163,
		["113"] = 164,
		["116"] = 167,
		["117"] = 160,
		["123"] = 180,
		["124"] = 181,
		["125"] = 182,
		["126"] = 183,
		["128"] = 185,
		["131"] = 180,
		["132"] = 195,
		["133"] = 196,
		["135"] = 198,
		["137"] = 200,
		["138"] = 202,
		["139"] = 205,
		["140"] = 205,
		["141"] = 206,
		["142"] = 207,
		["143"] = 208,
		["144"] = 209,
		["145"] = 210,
		["148"] = 213,
		["149"] = 205,
		["150"] = 217,
		["151"] = 217,
		["152"] = 218,
		["153"] = 219,
		["154"] = 220,
		["155"] = 221,
		["156"] = 222,
		["159"] = 225,
		["160"] = 217,
		["161"] = 229,
		["162"] = 229,
		["163"] = 230,
		["164"] = 231,
		["165"] = 232,
		["166"] = 233,
		["167"] = 234,
		["168"] = 235,
		["170"] = 237,
		["174"] = 241,
		["175"] = 229,
		["176"] = 245,
		["177"] = 245,
		["178"] = 246,
		["179"] = 247,
		["180"] = 248,
		["181"] = 249,
		["182"] = 250,
		["183"] = 251,
		["185"] = 253,
		["189"] = 257,
		["190"] = 245,
		["191"] = 261,
		["192"] = 261,
		["193"] = 262,
		["194"] = 263,
		["195"] = 264,
		["196"] = 265,
		["197"] = 266,
		["200"] = 269,
		["201"] = 261,
		["207"] = 278,
		["208"] = 278,
		["209"] = 278,
		["211"] = 279,
		["212"] = 278,
		["218"] = 288,
		["219"] = 288,
		["220"] = 288,
		["222"] = 289,
		["223"] = 289,
		["224"] = 289,
		["225"] = 289,
		["226"] = 288,
		["233"] = 299,
		["234"] = 300,
		["235"] = 301,
		["236"] = 302,
		["237"] = 306,
		["238"] = 307,
		["239"] = 308,
		["240"] = 309,
		["241"] = 310,
		["242"] = 311,
		["243"] = 312,
		["244"] = 313,
		["245"] = 314,
		["246"] = 315,
		["247"] = 315,
		["248"] = 315,
		["249"] = 315,
		["250"] = 314,
		["251"] = 314,
		["252"] = 314,
		["255"] = 320,
		["256"] = 320,
		["257"] = 320,
		["258"] = 320,
		["259"] = 324,
		["260"] = 325,
		["261"] = 326,
		["263"] = 328,
		["264"] = 300,
		["265"] = 331,
		["266"] = 332,
		["267"] = 333,
		["268"] = 334,
		["269"] = 335,
		["272"] = 338,
		["273"] = 338,
		["274"] = 338,
		["275"] = 338,
		["276"] = 339,
		["278"] = 341,
		["279"] = 342,
		["280"] = 342,
		["281"] = 342,
		["282"] = 343,
		["283"] = 344,
		["284"] = 345,
		["286"] = 347,
		["288"] = 349,
		["289"] = 350,
		["290"] = 351,
		["291"] = 352,
		["292"] = 353,
		["293"] = 354,
		["294"] = 355,
		["295"] = 356,
		["297"] = 342,
		["298"] = 342,
		["299"] = 359,
		["300"] = 299,
		["305"] = 367,
		["306"] = 368,
		["307"] = 367,
		["317"] = 381,
		["318"] = 381,
		["319"] = 381,
		["321"] = 381,
		["322"] = 381,
		["324"] = 381,
		["325"] = 381,
		["327"] = 381,
		["328"] = 381,
		["330"] = 381,
		["331"] = 381,
		["333"] = 381,
		["334"] = 381,
		["336"] = 382,
		["337"] = 385,
		["338"] = 386,
		["339"] = 387,
		["340"] = 388,
		["341"] = 389,
		["342"] = 390,
		["343"] = 391,
		["345"] = 393,
		["346"] = 395,
		["348"] = 398,
		["352"] = 403,
		["353"] = 404,
		["354"] = 405,
		["356"] = 407,
		["359"] = 411,
		["360"] = 413,
		["361"] = 381,
		["366"] = 421,
		["367"] = 422,
		["368"] = 423,
		["369"] = 424,
		["370"] = 425,
		["371"] = 426,
		["373"] = 428,
		["374"] = 421,
		["379"] = 436,
		["380"] = 437,
		["381"] = 438,
		["383"] = 440,
		["384"] = 436,
		["386"] = 444,
		["387"] = 445,
		["388"] = 445,
		["389"] = 446,
		["390"] = 447,
		["391"] = 448,
		["394"] = 452,
		["395"] = 453,
		["396"] = 454,
		["397"] = 455,
		["398"] = 456,
		["399"] = 457,
		["403"] = 462,
		["404"] = 444,
		["410"] = 472,
		["411"] = 473,
		["412"] = 474,
		["413"] = 475,
		["414"] = 476,
		["417"] = 472,
		["422"] = 486,
		["423"] = 487,
		["424"] = 488,
		["425"] = 489,
		["426"] = 490,
		["429"] = 486,
		["434"] = 511,
		["435"] = 512,
		["436"] = 513,
		["437"] = 514,
		["438"] = 515,
		["439"] = 516,
		["441"] = 518,
		["442"] = 518,
		["443"] = 518,
		["444"] = 518,
		["446"] = 520,
		["448"] = 522,
		["449"] = 511,
		["454"] = 530,
		["455"] = 531,
		["456"] = 532,
		["457"] = 533,
		["458"] = 534,
		["459"] = 535,
		["462"] = 539,
		["464"] = 541,
		["465"] = 530,
		["471"] = 550,
		["472"] = 550,
		["473"] = 550,
		["475"] = 551,
		["476"] = 552,
		["477"] = 553,
		["478"] = 554,
		["479"] = 554,
		["480"] = 554,
		["481"] = 554,
		["482"] = 555,
		["483"] = 555,
		["484"] = 555,
		["486"] = 557,
		["487"] = 550,
		["493"] = 566,
		["494"] = 566,
		["495"] = 566,
		["497"] = 567,
		["498"] = 568,
		["500"] = 570,
		["501"] = 571,
		["503"] = 572,
		["504"] = 572,
		["505"] = 573,
		["506"] = 572,
		["509"] = 575,
		["510"] = 576,
		["511"] = 577,
		["514"] = 580,
		["515"] = 566,
		["520"] = 588,
		["521"] = 589,
		["522"] = 590,
		["523"] = 591,
		["524"] = 592,
		["525"] = 593,
		["527"] = 595,
		["530"] = 598,
		["533"] = 601,
		["534"] = 588,
		["540"] = 610,
		["541"] = 611,
		["542"] = 612,
		["543"] = 613,
		["544"] = 614,
		["545"] = 615,
		["546"] = 616,
		["548"] = 618,
		["551"] = 621,
		["555"] = 625,
		["556"] = 610,
		["562"] = 634,
		["563"] = 634,
		["564"] = 634,
		["566"] = 635,
		["567"] = 636,
		["568"] = 637,
		["569"] = 638,
		["570"] = 634,
		["578"] = 649,
		["579"] = 650,
		["580"] = 649,
		["587"] = 660,
		["588"] = 661,
		["589"] = 662,
		["590"] = 663,
		["591"] = 664,
		["592"] = 665,
		["593"] = 660,
		["601"] = 676,
		["602"] = 677,
		["603"] = 678,
		["604"] = 679,
		["607"] = 682,
		["608"] = 676,
		["616"] = 693,
		["617"] = 694,
		["618"] = 695,
		["619"] = 696,
		["620"] = 697,
		["621"] = 698,
		["622"] = 700,
		["623"] = 701,
		["625"] = 703,
		["626"] = 705,
		["627"] = 706,
		["628"] = 707,
		["629"] = 708,
		["631"] = 710,
		["632"] = 712,
		["634"] = 715,
		["635"] = 693,
		["641"] = 724,
		["642"] = 724,
		["643"] = 725,
		["644"] = 726,
		["645"] = 727,
		["646"] = 728,
		["647"] = 729,
		["648"] = 730,
		["649"] = 731,
		["650"] = 732,
		["652"] = 734,
		["654"] = 736,
		["656"] = 738,
		["657"] = 724,
		["662"] = 746,
		["663"] = 747,
		["664"] = 748,
		["665"] = 748,
		["666"] = 748,
		["667"] = 748,
		["668"] = 748,
		["669"] = 746,
		["673"] = 755,
		["674"] = 756,
		["675"] = 755,
		["681"] = 774,
		["682"] = 775,
		["683"] = 776,
		["684"] = 777,
		["685"] = 778,
		["686"] = 779,
		["687"] = 780,
		["688"] = 781,
		["690"] = 783,
		["692"] = 785,
		["693"] = 774,
		["697"] = 792,
		["698"] = 793,
		["699"] = 792,
		["701"] = 797,
		["702"] = 798,
		["703"] = 799,
		["704"] = 800,
		["705"] = 801,
		["706"] = 802,
		["710"] = 806,
		["711"] = 797,
		["713"] = 810,
		["714"] = 811,
		["715"] = 812,
		["716"] = 813,
		["717"] = 814,
		["720"] = 810,
		["729"] = 828,
		["730"] = 829,
		["731"] = 829,
		["732"] = 829,
		["733"] = 829,
		["734"] = 829,
		["735"] = 829,
		["736"] = 829,
		["737"] = 829,
		["738"] = 829,
		["739"] = 828,
		["745"] = 838,
		["746"] = 839,
		["747"] = 840,
		["749"] = 842,
		["750"] = 843,
		["752"] = 846,
		["753"] = 847,
		["754"] = 848,
		["756"] = 850,
		["757"] = 851,
		["759"] = 853,
		["763"] = 857,
		["764"] = 838,
		["767"] = 863,
		["768"] = 864,
		["769"] = 864,
		["771"] = 865,
		["772"] = 866,
		["773"] = 867,
		["774"] = 868,
		["775"] = 869,
		["776"] = 870,
		["777"] = 871,
		["778"] = 872,
		["780"] = 874,
		["781"] = 863,
		["784"] = 879,
		["785"] = 880,
		["786"] = 881,
		["787"] = 882,
		["788"] = 883,
		["789"] = 884,
		["790"] = 885,
		["791"] = 886,
		["792"] = 887,
		["793"] = 888,
		["796"] = 889,
		["797"] = 890,
		["799"] = 892,
		["801"] = 894,
		["803"] = 896,
		["804"] = 879,
		["805"] = 898,
		["806"] = 899,
		["807"] = 900,
		["808"] = 901,
		["810"] = 903,
		["811"] = 904,
		["812"] = 904,
		["813"] = 904,
		["814"] = 904,
		["815"] = 904,
		["816"] = 905,
		["817"] = 903,
		["823"] = 913,
		["824"] = 914,
		["825"] = 914,
		["827"] = 915,
		["828"] = 915,
		["830"] = 916,
		["831"] = 916,
		["833"] = 917,
		["834"] = 917,
		["835"] = 917,
		["837"] = 917,
		["838"] = 918,
		["839"] = 919,
		["840"] = 920,
		["841"] = 921,
		["843"] = 923,
		["844"] = 924,
		["845"] = 913,
		["846"] = 926,
		["847"] = 927,
		["848"] = 927,
		["850"] = 926,
		["852"] = 931,
		["853"] = 932,
		["854"] = 933,
		["856"] = 931,
		["858"] = 937,
		["859"] = 938,
		["860"] = 939,
		["862"] = 937,
		["863"] = 943,
		["864"] = 944,
		["865"] = 945,
		["867"] = 947,
		["868"] = 948,
		["869"] = 949,
		["870"] = 950,
		["871"] = 951,
		["872"] = 952,
		["873"] = 953,
		["874"] = 954,
		["875"] = 955,
		["877"] = 957,
		["879"] = 943,
		["881"] = 961,
		["882"] = 962,
		["883"] = 963,
		["884"] = 964,
		["885"] = 966,
		["886"] = 967,
		["887"] = 968,
		["888"] = 969,
		["890"] = 971,
		["891"] = 961,
		["893"] = 974,
		["894"] = 975,
		["895"] = 976,
		["896"] = 977,
		["897"] = 978,
		["898"] = 979,
		["899"] = 981,
		["900"] = 982,
		["901"] = 983,
		["902"] = 984,
		["903"] = 985,
		["904"] = 986,
		["905"] = 987,
		["908"] = 990,
		["909"] = 991,
		["910"] = 993,
		["912"] = 995,
		["913"] = 974,
		["915"] = 1001,
		["916"] = 1002,
		["917"] = 1003,
		["918"] = 1004,
		["919"] = 1005,
		["920"] = 1006,
		["922"] = 1015,
		["923"] = 1016,
		["925"] = 1018,
		["926"] = 1018,
		["927"] = 1018,
		["928"] = 1019,
		["929"] = 1020,
		["930"] = 1021,
		["932"] = 1023,
		["933"] = 1018,
		["934"] = 1018,
		["935"] = 1018,
		["936"] = 1025,
		["938"] = 1002,
		["939"] = 1028,
		["940"] = 1029,
		["941"] = 1030,
		["942"] = 1031,
		["943"] = 1032,
		["945"] = 1047,
		["946"] = 1048,
		["948"] = 1050,
		["949"] = 1051,
		["950"] = 1051,
		["951"] = 1051,
		["952"] = 1051,
		["953"] = 1052,
		["954"] = 1053,
		["955"] = 1054,
		["957"] = 1057,
		["959"] = 1059,
		["960"] = 1051,
		["961"] = 1051,
		["963"] = 1028,
		["964"] = 1063,
		["965"] = 1065,
		["966"] = 1063,
		["968"] = 1069,
		["969"] = 1071,
		["970"] = 1073,
		["972"] = 1076,
		["973"] = 1078,
		["975"] = 1081,
		["976"] = 1069,
		["978"] = 1085,
		["979"] = 1087,
		["980"] = 1089,
		["982"] = 1092,
		["983"] = 1094,
		["985"] = 1097,
		["986"] = 1085,
		["988"] = 1101,
		["989"] = 1103,
		["990"] = 1103,
		["992"] = 1105,
		["993"] = 1105,
		["995"] = 1107,
		["996"] = 1108,
		["997"] = 1109,
		["998"] = 1101,
		["1000"] = 1115,
		["1001"] = 1116,
		["1002"] = 1117,
		["1003"] = 1116,
	}
)
function ArrayRemoveByIndex(k, l)
	if l == nil then
		l = #k
	end
	return table.remove(k, l + 1)
end
if _G.aModules == nil then
	_G.aModules = {}
end
CModule = c()
CModule.name = "CModule"
function CModule.prototype.____constructor(self)
	aModules[#aModules + 1] = self
end
function CModule.prototype.init(self, m) end
function CModule.initialize(self)
	d(aModules, function(n, o)
		return o:init(false)
	end)
end
function CModule.reload(self)
	d(aModules, function(n, o)
		return o:init(true)
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
function GameEvent(p, q, r)
	local s = ListenToGameEvent(p, q, r)
	GameEventListenerIDs[#GameEventListenerIDs + 1] = s
	return s
end
function StopGameEvent(s)
	for t = #GameEventListenerIDs - 1, 0, -1 do
		local u = GameEventListenerIDs[t + 1]
		if u == s then
			table.remove(GameEventListenerIDs, t + 1)
		end
	end
	StopListeningToGameEvent(s)
end
function RegisterClientEvent(v, w, r)
	tRequestEvents[v] = { callback = w, context = r }
end
function CustomUIEvent(p, q, r)
	local s = CustomGameEventManager:RegisterListener(p, function(x, ...)
		if r ~= nil then
			return q(r, ...)
		end
		return q(...)
	end)
	CustomUIEventListenerIDs[#CustomUIEventListenerIDs + 1] = s
	return s
end
function StopCustomUIEvent(s)
	for t = #CustomUIEventListenerIDs - 1, 0, -1 do
		local u = CustomUIEventListenerIDs[t + 1]
		if u == s then
			e(CustomUIEventListenerIDs, t, 1)
		end
	end
	CustomGameEventManager:UnregisterListener(s)
end
function RequestEvent(p, q, r)
	if Request ~= nil then
		if IsServer() then
			Request:RegisterServerEvent(p, q, r)
		else
			Request:RegisterClientEvent(p, q, r)
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
	local y = { ... }
	local z = 0
	for t = 0, #y - 1, 1 do
		local A = y[t + 1]
		if type(A) == "number" then
			z = ((1 + z * 0.01) * (1 + A * 0.01) - 1) * 100
		end
	end
	return z
end
function SubtractionMultiplicationPercentage(...)
	local y = { ... }
	local z = 0
	for t = 0, #y - 1, 1 do
		local A = y[t + 1]
		if type(A) == "number" then
			z = (1 - (1 - z * 0.01) * (1 - A * 0.01)) * 100
		end
	end
	return z
end
function Maximum(...)
	local y = { ... }
	local z = ZERO_VALUE
	for t = 0, #y - 1, 1 do
		local A = y[t + 1]
		if type(A) == "number" then
			if z == ZERO_VALUE then
				z = A
			else
				z = math.max(z, A)
			end
		end
	end
	return z
end
function Minimum(...)
	local y = { ... }
	local z = ZERO_VALUE
	for t = 0, #y - 1, 1 do
		local A = y[t + 1]
		if type(A) == "number" then
			if z == ZERO_VALUE then
				z = A
			else
				z = math.min(z, A)
			end
		end
	end
	return z
end
function First(...)
	local y = { ... }
	local z = nil
	for t = 0, #y - 1, 1 do
		local A = y[t + 1]
		if type(A) ~= "nil" then
			z = A
		end
	end
	return z
end
function finiteNumber(t, B)
	if B == nil then
		B = 0
	end
	return g(f(t)) and t or B
end
function toFiniteNumber(t, B)
	if B == nil then
		B = 0
	end
	return finiteNumber(f(t), B)
end
function parse_conditional(C, w)
	local function D(E)
		local F = "[&|]"
		local G = {}
		local t = 0
		local H = 0
		local I = 0
		local l = 0
		local J
		while true do
			t, H = string.find(E, F, t + 1)
			if t == nil then
				G[I + 1] = { str = string.sub(E, l, string.len(E)), operator = J }
				break
			end
			G[I + 1] = { str = string.sub(E, l, t - 1), operator = J }
			l = t + H - (t - 1)
			I = I + 1
			J = string.sub(E, t, H)
		end
		return G
	end
	local K = nil
	C = string.gsub(C, "%s", "")
	while true do
		local t, H = string.find(C, "%b()")
		if t == nil then
			break
		end
		K = parse_conditional(string.sub(C, t + 1, H - 1), w)
		C = (string.sub(C, 1, t - 1) .. tostring(K)) .. string.sub(C, H + 1, -1)
	end
	local L = D(C)
	d(L, function(n, A, t)
		local G
		if A.str ~= "false" and A.str ~= "true" then
			G = w(A.str)
		else
			G = A.str == "true"
		end
		if K == nil then
			K = G
		elseif A.operator == nil then
			K = G
		elseif A.operator == "|" then
			K = K or G
		elseif A.operator == "&" then
			K = K and G
		end
	end)
	return K or false
end
function IsLeapYear(M)
	return M % 4 == 0 and M % 100 ~= 0 or M % 400 == 0
end
function toUnixTime(M, N, O, P, Q, R)
	if M == nil then
		M = 0
	end
	if N == nil then
		N = 0
	end
	if O == nil then
		O = 0
	end
	if P == nil then
		P = 0
	end
	if Q == nil then
		Q = 0
	end
	if R == nil then
		R = 0
	end
	local S = R + Q * 60 + P * 60 * 60 + (O - 1) * 86400
	local T = 0
	local U = N - 1
	for t = 1, U, 1 do
		if t == 1 or t == 3 or t == 5 or t == 7 or t == 8 or t == 10 or t == 12 then
			T = T + 31
		elseif t == 4 or t == 6 or t == 9 or t == 11 then
			T = T + 30
		else
			if IsLeapYear(M) then
				T = T + 29
			else
				T = T + 28
			end
		end
	end
	for t = 1970, M - 1, 1 do
		if IsLeapYear(t) then
			T = T + 366
		else
			T = T + 365
		end
	end
	S = S + T * 86400
	return S
end
function RandomValue(V)
	local W = h(V)
	if #W > 0 then
		local t = RandomInt(0, #W - 1)
		local X = W[t + 1]
		return V[X]
	end
	return nil
end
function GetRandomElement(L)
	if #L > 0 then
		return L[RandomInt(0, #L - 1) + 1]
	end
	return nil
end
function GetRandomElementByWeight(Y)
	local Z = 0
	local _ = 0
	for x, z in pairs(Y) do
		if z > 0 then
			Z = Z + z
		end
	end
	local a0 = math.random(1, Z)
	for a1, z in pairs(Y) do
		if z > 0 then
			_ = _ + z
			if a0 <= _ then
				return a1
			end
		end
	end
	return ""
end
function TableFindKey(V, A)
	for a2, a3 in pairs(V) do
		local a3 = V[a2]
		if A == a3 then
			return a2
		end
	end
end
function ArrayRemove(V, A)
	for t = #V - 1, 0, -1 do
		if V[t + 1] == A then
			ArrayRemoveByIndex(V, t)
			return { A, t }
		end
	end
end
function deepcopy(a4)
	local a5
	if type(a4) == "table" then
		a5 = {}
		for a2, a6 in pairs(a4) do
			a5[deepcopy(a2)] = deepcopy(a6)
		end
		setmetatable(a5, deepcopy(getmetatable(a4)))
	else
		a5 = a4
	end
	return a5
end
function shallowcopy(a4)
	local a5
	if type(a4) == "table" then
		a5 = {}
		for a2, a6 in pairs(a4) do
			a5[a2] = a6
		end
	else
		a5 = a4
	end
	return a5
end
function ShuffledList(k, a7)
	if a7 == nil then
		a7 = false
	end
	local V = a7 and k or shallowcopy(k)
	local t = #V
	while t > 0 do
		local a8 = math.random()
		local a9 = t
		t = a9 - 1
		local H = math.floor(a8 * a9)
		local aa = { V[t + 1], V[H + 1] }
		V[H + 1] = aa[1]
		V[t + 1] = aa[2]
	end
	return V
end
function PickList(ab, ac, ad)
	if ad == nil then
		ad = false
	end
	if ac > #ab then
		return ab
	end
	local a5 = ShuffledList(ab, ad)
	local ae = {}
	do
		local t = 0
		while t < ac do
			ae[#ae + 1] = a5[t + 1]
			t = t + 1
		end
	end
	if ad then
		for n, u in ipairs(ae) do
			ArrayRemove(ab, u)
		end
	end
	return ae
end
function TableOverride(af, ag)
	for X in pairs(ag) do
		local A = ag[X]
		if type(A) == "table" then
			if type(af[X]) == "table" then
				af[X] = TableOverride(af[X], A)
			else
				af[X] = TableOverride({}, A)
			end
		else
			af[X] = A
		end
	end
	return af
end
function TableReplace(af, ag)
	for X in pairs(ag) do
		if af[X] ~= nil then
			local A = ag[X]
			if type(A) == "table" then
				if type(af[X]) == "table" then
					af[X] = TableOverride(af[X], A)
				else
					af[X] = TableOverride({}, A)
				end
			else
				af[X] = A
			end
		end
	end
	return af
end
function Round(ah, ai)
	if ai == nil then
		ai = 0
	end
	local aj = ah > 0 and 1 or -1
	ah = math.abs(ah)
	local t = 10 ^ ai
	return aj * math.floor(ah * t + 0.5) / t
end
function IsLineCross(ak, al, am, an)
	return math.min(ak.x, al.x) <= math.max(am.x, an.x)
		and math.min(am.x, an.x) <= math.max(ak.x, al.x)
		and math.min(ak.y, al.y) <= math.max(am.y, an.y)
		and math.min(am.y, an.y) <= math.max(ak.y, al.y)
end
function IsCross(ao, ap, aq)
	local ar = ap.x - ao.x
	local as = ap.y - ao.y
	local at = aq.x - ao.x
	local au = aq.y - ao.y
	return ar * au - at * as
end
function IsIntersect(ao, ap, aq, av)
	if IsLineCross(ao, ap, aq, av) then
		if IsCross(ao, ap, aq) * IsCross(ao, ap, av) <= 0 and IsCross(aq, av, ao) * IsCross(aq, av, ap) <= 0 then
			return true
		end
	end
	return false
end
function GetCrossPoint(ao, ap, aw, ax)
	if IsIntersect(ao, ap, aw, ax) then
		local ay = 0
		local az = 0
		local aA = (ax.x - aw.x) * (ao.y - ap.y) - (ap.x - ao.x) * (aw.y - ax.y)
		local aB = (ao.y - aw.y) * (ap.x - ao.x) * (ax.x - aw.x)
			+ aw.x * (ax.y - aw.y) * (ap.x - ao.x)
			- ao.x * (ap.y - ao.y) * (ax.x - aw.x)
		if aA == 0 then
			return vec3_invalid
		end
		ay = aB / aA
		aA = (ao.x - ap.x) * (ax.y - aw.y) - (ap.y - ao.y) * (aw.x - ax.x)
		aB = ap.y * (ao.x - ap.x) * (ax.y - aw.y)
			+ (ax.x - ap.x) * (ax.y - aw.y) * (ao.y - ap.y)
			- ax.y * (aw.x - ax.x) * (ap.y - ao.y)
		if aA == 0 then
			return vec3_invalid
		end
		az = aB / aA
		return Vector(ay, az, 0)
	end
	return vec3_invalid
end
function Bessel(V, ...)
	local aC = { ... }
	if #aC == 1 then
		return aC[2]
	elseif #aC > 1 then
		while #aC > 2 do
			local aD = {}
			for t = 0, #aC - 2, 1 do
				local aE = LerpVectors(aC[t + 1], aC[t + 1 + 1], V)
				aD[#aD + 1] = aE
			end
			aC = aD
		end
		return LerpVectors(aC[2], aC[3], V)
	end
	return vec3_invalid
end
function StringToVector(E)
	local L = i(E, " ")
	return Vector(toFiniteNumber(L[1]), toFiniteNumber(L[2]), toFiniteNumber(L[3]))
end
function VectorToString(A)
	return (((tostring(A.x) .. " ") .. tostring(A.y)) .. " ") .. tostring(A.z)
end
function IsPointInPolygon(aF, aG)
	local H = #aG
	local K = 0
	for t = 1, #aG, 1 do
		local aH = aG[H]
		local aI = aG[t]
		if (aI.y < aF.y and aH.y >= aF.y or aH.y < aF.y and aI.y >= aF.y) and (aI.x <= aF.x or aH.x <= aF.x) then
			K = bit.bxor(K, aI.x + (aF.y - aI.y) / (aH.y - aI.y) * (aH.x - aI.x) < aF.x and 1 or 0)
		end
		H = t
	end
	return K == 1
end
function IsValid(aJ)
	return aJ ~= nil and not aJ:IsNull()
end
function IsInjurable(...)
	local aK = true
	for t = 1, select("#", ...) do
		local aL = select(t, ...)
		if not IsValid(aL) or not aL:IsAlive() then
			aK = false
			break
		end
	end
	return aK
end
function defaultValue(...)
	for t = 1, select("#", ...) do
		local A = select(t, ...)
		if A ~= nil then
			return A
		end
	end
end
function CreateCasterThinker(aM, aN, aO, aP, aQ)
	return CreateModifierThinker(aM, aN, aO, aP, aQ, aM:GetTeamNumber(), false)
end
function ServiceTableOverride(af, aR)
	if af == nil then
		return aR
	end
	if aR == nil or type(aR) ~= "table" then
		return af
	end
	for X, A in pairs(aR) do
		if type(A) == "table" then
			af[X] = ServiceTableOverride(af[X], A)
		else
			if A == "DELETE" then
				af[X] = nil
			else
				af[X] = A
			end
		end
	end
	return af
end
function PfromC(aS)
	if aS == 0 then
		return 1
	end
	local aT = 0
	local aU = 0
	local aV = 0
	local aW = math.ceil(1 / aS)
	for aX = 1, aW, 1 do
		aT = math.min(1, aX * aS) * (1 - aU)
		aU = aU + aT
		aV = aV + aX * aT
	end
	return 1 / aV
end
function CfromP(aY)
	local aZ = aY
	local a_ = 0
	local b0
	local ao
	local ap = 1
	while true do
		b0 = (aZ + a_) / 2
		ao = PfromC(b0)
		if math.abs(ao - ap) <= 0 then
			break
		end
		if ao > aY then
			aZ = b0
		else
			a_ = b0
		end
		ap = ao
	end
	return b0
end
PSEUDO_RANDOM_C = {}
for t = 0, 100, 1 do
	local b1 = CfromP(t * 0.01)
	PSEUDO_RANDOM_C[t + 1] = b1
end
function PRD_C(b2)
	b2 = Clamp(math.floor(b2), 0, 100)
	return PSEUDO_RANDOM_C[b2 + 1]
end
function PRD(ag, b2, b3)
	if type(ag) ~= "table" then
		return false
	end
	if b2 >= 100 then
		return true
	end
	if ag.PSEUDO_RANDOM_RECORDING_LIST == nil then
		ag.PSEUDO_RANDOM_RECORDING_LIST = {}
	end
	local b4 = ag.PSEUDO_RANDOM_RECORDING_LIST[b3]
	if b4 == nil then
		b4 = 1
	end
	local aX = b4
	local b1 = PRD_C(b2)
	if RandomFloat(0, 1) <= b1 * aX then
		ag.PSEUDO_RANDOM_RECORDING_LIST[b3] = 1
		return true
	end
	ag.PSEUDO_RANDOM_RECORDING_LIST[b3] = aX + 1
	return false
end
function ClearPRDRecord(ag)
	if type(ag) == "table" and ag.PSEUDO_RANDOM_RECORDING_LIST ~= nil then
		ag.PSEUDO_RANDOM_RECORDING_LIST = nil
	end
end
function SaveData(ag, a2, a6)
	if ag then
		ag[a2] = a6
	end
end
function LoadData(ag, a2)
	if ag then
		return ag[a2]
	end
end
function getBytes(b5)
	if not b5 then
		return 0
	end
	local b6 = string.byte(b5)
	if b6 < 127 then
		return 1
	elseif b6 <= 223 then
		return 2
	elseif b6 <= 239 then
		return 3
	elseif b6 <= 247 then
		return 4
	else
		return 0
	end
end
function Utf8StringLength(E)
	local b7 = E
	local b8 = 0
	local b9 = 0
	while string.len(b7) > 0 do
		b9 = b9 + getBytes(b7)
		b7 = string.sub(E, b9 + 1)
		b8 = b8 + 1
	end
	return b8
end
function Utf8StringSub(E, ba, bb)
	local b7 = E
	local bc = 1
	local bd = -1
	local b8 = 0
	local b9 = 0
	ba = math.max(ba, 1)
	bb = bb or -1
	while string.len(b7) > 0 do
		if b8 == ba - 1 then
			bc = b9 + 1
		elseif b8 == bb then
			bd = b9
			break
		end
		b9 = b9 + getBytes(b7)
		b7 = string.sub(E, b9 + 1)
		b8 = b8 + 1
	end
	return string.sub(E, bc, bd)
end
BaseEntity = IsServer() and CBaseEntity or C_BaseEntity
BaseEntity.Timer = function(self, be, bf, bg)
	if bg == nil then
		bg = bf
		bf = be
		be = DoUniqueString("Timer")
	end
	if IsServer() then
		return TimerManager:Timer(self, bf, bg)
	else
		self:SetContextThink(be, function()
			local G = bg()
			if type(G) == "number" then
				G = math.max(FRAME_TIME, G)
			end
			return G
		end, bf)
		return be
	end
end
BaseEntity.GameTimer = function(self, be, bf, bg)
	if bg == nil then
		bg = bf
		bf = be
		be = DoUniqueString("GameTimer")
	end
	if IsServer() then
		return TimerManager:GameTimer(self, bf, bg)
	else
		local bh = GameRules:GetGameTime() + math.max(FRAME_TIME, bf)
		return self:Timer(be, bf, function()
			if GameRules:GetGameTime() >= bh then
				local G = bg()
				if type(G) == "number" then
				end
				return G
			end
			return 0
		end)
	end
end
BaseEntity.StopTimer = function(self, be)
	TimerManager:StopTimer(be)
end
function CalcDistance(bi, bj)
	if bi.GetAbsOrigin then
		bi = bi:GetAbsOrigin()
	end
	if bj.GetAbsOrigin then
		bj = bj:GetAbsOrigin()
	end
	return (bi - bj):Length2D()
end
function CalcDirection(bi, bj)
	if bi.GetAbsOrigin then
		bi = bi:GetAbsOrigin()
	end
	if bj.GetAbsOrigin then
		bj = bj:GetAbsOrigin()
	end
	return (bi - bj):Normalized()
end
function CalcDirection2D(bk, bl)
	if bk.GetAbsOrigin ~= nil then
		bk = bk:GetAbsOrigin()
	end
	if bl.GetAbsOrigin ~= nil then
		bl = bl:GetAbsOrigin()
	end
	local bm = bk - bl
	bm.z = 0
	return bm:Normalized()
end
do
	local bn = IsServer() and CDOTA_BaseNPC or C_DOTA_BaseNPC
	bn.GetUltiPower = function(self)
		return GetUltiPower(self)
	end
end