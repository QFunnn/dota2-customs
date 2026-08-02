--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/index"
local b = require("lualib_bundle")
local c = b.Map
local d = b.__TS__New
local e = b.__TS__Iterator
local f = b.__TS__StringSplit
local g = b.__TS__Number
local h = b.__TS__NumberIsFinite
local i = b.__TS__StringReplace
local j = b.__TS__ArraySlice
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["16"] = 231,
		["17"] = 232,
		["18"] = 232,
		["19"] = 232,
		["20"] = 233,
		["21"] = 234,
		["25"] = 231,
		["27"] = 194,
		["32"] = 200,
		["33"] = 200,
		["34"] = 200,
		["36"] = 201,
		["37"] = 202,
		["38"] = 203,
		["40"] = 205,
		["41"] = 206,
		["42"] = 200,
		["47"] = 213,
		["48"] = 214,
		["49"] = 215,
		["50"] = 216,
		["52"] = 218,
		["54"] = 220,
		["55"] = 221,
		["56"] = 222,
		["58"] = 224,
		["59"] = 213,
		["64"] = 244,
		["65"] = 245,
		["66"] = 244,
		["70"] = 251,
		["71"] = 252,
		["72"] = 251,
		["78"] = 261,
		["79"] = 262,
		["80"] = 262,
		["81"] = 262,
		["83"] = 262,
		["84"] = 263,
		["85"] = 264,
		["86"] = 265,
		["87"] = 266,
		["88"] = 267,
		["89"] = 268,
		["90"] = 269,
		["91"] = 270,
		["92"] = 271,
		["94"] = 273,
		["95"] = 274,
		["96"] = 274,
		["97"] = 274,
		["98"] = 274,
		["99"] = 275,
		["100"] = 276,
		["105"] = 281,
		["106"] = 282,
		["107"] = 283,
		["108"] = 284,
		["109"] = 285,
		["110"] = 285,
		["111"] = 285,
		["112"] = 285,
		["113"] = 286,
		["114"] = 287,
		["120"] = 293,
		["121"] = 261,
		["128"] = 302,
		["129"] = 303,
		["130"] = 303,
		["131"] = 303,
		["133"] = 303,
		["134"] = 304,
		["135"] = 305,
		["136"] = 306,
		["137"] = 307,
		["138"] = 308,
		["139"] = 309,
		["140"] = 310,
		["141"] = 310,
		["142"] = 310,
		["143"] = 310,
		["144"] = 311,
		["145"] = 312,
		["146"] = 313,
		["147"] = 314,
		["148"] = 315,
		["150"] = 317,
		["156"] = 323,
		["157"] = 324,
		["158"] = 325,
		["159"] = 326,
		["160"] = 327,
		["161"] = 327,
		["162"] = 327,
		["163"] = 327,
		["164"] = 328,
		["165"] = 329,
		["166"] = 330,
		["167"] = 331,
		["168"] = 332,
		["170"] = 334,
		["177"] = 302,
		["185"] = 352,
		["186"] = 353,
		["187"] = 354,
		["188"] = 352,
		["189"] = 359,
		["190"] = 361,
		["191"] = 362,
		["193"] = 364,
		["194"] = 365,
		["195"] = 365,
		["197"] = 366,
		["198"] = 367,
		["199"] = 368,
		["200"] = 368,
		["201"] = 368,
		["203"] = 368,
		["205"] = 368,
		["206"] = 369,
		["207"] = 370,
		["209"] = 372,
		["210"] = 372,
		["211"] = 372,
		["213"] = 372,
		["214"] = 373,
		["215"] = 374,
		["216"] = 375,
		["217"] = 376,
		["218"] = 377,
		["219"] = 378,
		["220"] = 379,
		["223"] = 382,
		["224"] = 382,
		["225"] = 382,
		["226"] = 382,
		["227"] = 382,
		["228"] = 382,
		["229"] = 382,
		["230"] = 364,
		["231"] = 385,
		["232"] = 386,
		["234"] = 388,
		["235"] = 389,
		["236"] = 389,
		["238"] = 390,
		["239"] = 390,
		["240"] = 390,
		["241"] = 390,
		["242"] = 388,
		["243"] = 392,
		["244"] = 393,
		["245"] = 393,
		["247"] = 394,
		["248"] = 395,
		["249"] = 396,
		["250"] = 397,
		["252"] = 399,
		["253"] = 392,
		["254"] = 401,
		["255"] = 402,
		["256"] = 402,
		["258"] = 403,
		["259"] = 404,
		["260"] = 405,
		["261"] = 406,
		["263"] = 408,
		["264"] = 401,
		["265"] = 410,
		["266"] = 411,
		["269"] = 412,
		["270"] = 412,
		["271"] = 412,
		["272"] = 412,
		["273"] = 412,
		["274"] = 412,
		["275"] = 410,
		["276"] = 414,
		["277"] = 414,
		["278"] = 414,
		["280"] = 415,
		["283"] = 416,
		["284"] = 416,
		["285"] = 416,
		["286"] = 416,
		["287"] = 416,
		["288"] = 416,
		["289"] = 414,
		["290"] = 418,
		["291"] = 420,
		["293"] = 420,
		["295"] = 420,
		["296"] = 421,
		["297"] = 422,
		["299"] = 424,
		["300"] = 418,
		["301"] = 426,
		["302"] = 427,
		["303"] = 428,
		["305"] = 430,
		["306"] = 431,
		["307"] = 431,
		["308"] = 431,
		["309"] = 431,
		["310"] = 431,
		["311"] = 426,
		["312"] = 433,
		["313"] = 434,
		["314"] = 433,
		["315"] = 436,
		["316"] = 437,
		["317"] = 437,
		["319"] = 438,
		["320"] = 439,
		["321"] = 440,
		["322"] = 441,
		["323"] = 442,
		["324"] = 443,
		["325"] = 444,
		["326"] = 445,
		["327"] = 446,
		["329"] = 448,
		["331"] = 450,
		["332"] = 436,
		["333"] = 452,
		["334"] = 453,
		["335"] = 454,
		["336"] = 455,
		["337"] = 456,
		["338"] = 458,
		["339"] = 459,
		["340"] = 460,
		["341"] = 462,
		["342"] = 463,
		["344"] = 464,
		["345"] = 464,
		["347"] = 464,
		["348"] = 465,
		["349"] = 466,
		["351"] = 468,
		["355"] = 473,
		["358"] = 475,
		["361"] = 478,
		["362"] = 479,
		["363"] = 480,
		["364"] = 481,
		["365"] = 482,
		["366"] = 483,
		["368"] = 485,
		["369"] = 486,
		["370"] = 487,
		["371"] = 488,
		["375"] = 492,
		["376"] = 492,
		["377"] = 492,
		["378"] = 492,
		["379"] = 493,
		["380"] = 494,
		["382"] = 496,
		["383"] = 496,
		["384"] = 496,
		["385"] = 496,
		["386"] = 497,
		["387"] = 498,
		["388"] = 499,
		["392"] = 504,
		["393"] = 452,
		["394"] = 506,
		["395"] = 507,
		["396"] = 508,
		["398"] = 508,
		["400"] = 508,
		["401"] = 509,
		["402"] = 510,
		["404"] = 512,
		["405"] = 513,
		["406"] = 514,
		["407"] = 514,
		["408"] = 515,
		["409"] = 516,
		["410"] = 516,
		["411"] = 516,
		["412"] = 516,
		["413"] = 517,
		["414"] = 518,
		["415"] = 519,
		["416"] = 520,
		["419"] = 523,
		["420"] = 523,
		["421"] = 523,
		["422"] = 523,
		["423"] = 525,
		["424"] = 526,
		["425"] = 527,
		["426"] = 528,
		["428"] = 530,
		["429"] = 531,
		["431"] = 533,
		["432"] = 534,
		["433"] = 535,
		["437"] = 539,
		["438"] = 506,
		["439"] = 541,
		["440"] = 542,
		["441"] = 543,
		["442"] = 544,
		["443"] = 546,
		["444"] = 547,
		["446"] = 550,
		["447"] = 551,
		["448"] = 552,
		["450"] = 555,
		["451"] = 556,
		["453"] = 559,
		["454"] = 560,
		["456"] = 563,
		["457"] = 564,
		["459"] = 567,
		["460"] = 568,
		["462"] = 571,
		["463"] = 572,
		["465"] = 575,
		["466"] = 576,
		["468"] = 579,
		["469"] = 580,
		["471"] = 583,
		["472"] = 584,
		["474"] = 587,
		["475"] = 588,
		["477"] = 591,
		["478"] = 592,
		["480"] = 595,
		["481"] = 596,
		["483"] = 599,
		["484"] = 600,
		["486"] = 603,
		["487"] = 604,
		["489"] = 607,
		["490"] = 608,
		["492"] = 611,
		["493"] = 542,
		["495"] = 617,
		["496"] = 618,
		["497"] = 618,
		["499"] = 619,
		["500"] = 617,
		["501"] = 621,
		["502"] = 622,
		["503"] = 622,
		["505"] = 623,
		["506"] = 624,
		["507"] = 625,
		["508"] = 627,
		["510"] = 629,
		["511"] = 621,
		["512"] = 631,
		["513"] = 632,
		["514"] = 632,
		["516"] = 633,
		["517"] = 634,
		["518"] = 635,
		["519"] = 636,
		["521"] = 638,
		["522"] = 631,
		["523"] = 641,
		["524"] = 642,
		["525"] = 642,
		["527"] = 643,
		["528"] = 641,
		["529"] = 646,
		["530"] = 647,
		["531"] = 647,
		["533"] = 648,
		["534"] = 648,
		["535"] = 648,
		["536"] = 648,
		["537"] = 648,
		["538"] = 648,
		["539"] = 646,
		["540"] = 651,
		["541"] = 652,
		["542"] = 652,
		["544"] = 653,
		["545"] = 654,
		["546"] = 655,
		["547"] = 656,
		["548"] = 657,
		["549"] = 658,
		["550"] = 659,
		["551"] = 660,
		["552"] = 661,
		["554"] = 663,
		["556"] = 665,
		["557"] = 651,
		["558"] = 667,
		["559"] = 668,
		["560"] = 669,
		["561"] = 670,
		["562"] = 671,
		["563"] = 673,
		["564"] = 674,
		["565"] = 675,
		["566"] = 677,
		["567"] = 678,
		["569"] = 679,
		["570"] = 679,
		["572"] = 679,
		["573"] = 680,
		["574"] = 681,
		["576"] = 683,
		["580"] = 688,
		["583"] = 690,
		["586"] = 693,
		["587"] = 694,
		["588"] = 695,
		["589"] = 696,
		["590"] = 697,
		["591"] = 698,
		["593"] = 700,
		["594"] = 701,
		["595"] = 702,
		["596"] = 703,
		["600"] = 707,
		["601"] = 707,
		["602"] = 707,
		["603"] = 707,
		["604"] = 708,
		["605"] = 709,
		["607"] = 711,
		["608"] = 711,
		["609"] = 711,
		["610"] = 711,
		["611"] = 712,
		["612"] = 713,
		["613"] = 714,
		["617"] = 719,
		["618"] = 667,
		["619"] = 721,
		["620"] = 722,
		["621"] = 723,
		["623"] = 723,
		["625"] = 723,
		["626"] = 724,
		["627"] = 725,
		["629"] = 727,
		["630"] = 728,
		["631"] = 729,
		["632"] = 729,
		["633"] = 730,
		["634"] = 731,
		["635"] = 731,
		["636"] = 731,
		["637"] = 731,
		["638"] = 732,
		["639"] = 733,
		["640"] = 734,
		["641"] = 735,
		["644"] = 738,
		["645"] = 738,
		["646"] = 738,
		["647"] = 738,
		["648"] = 740,
		["649"] = 741,
		["650"] = 742,
		["651"] = 743,
		["653"] = 745,
		["654"] = 746,
		["656"] = 748,
		["657"] = 749,
		["658"] = 750,
		["662"] = 754,
		["663"] = 721,
		["664"] = 756,
		["665"] = 757,
		["666"] = 757,
		["668"] = 758,
		["669"] = 759,
		["670"] = 760,
		["671"] = 761,
		["672"] = 763,
		["673"] = 764,
		["674"] = 765,
		["675"] = 766,
		["676"] = 767,
		["677"] = 768,
		["678"] = 769,
		["682"] = 773,
		["683"] = 756,
		["684"] = 775,
		["685"] = 776,
		["686"] = 776,
		["688"] = 777,
		["689"] = 778,
		["690"] = 779,
		["691"] = 780,
		["692"] = 781,
		["693"] = 781,
		["694"] = 781,
		["695"] = 781,
		["696"] = 781,
		["697"] = 782,
		["698"] = 783,
		["699"] = 784,
		["700"] = 785,
		["701"] = 786,
		["702"] = 787,
		["703"] = 788,
		["708"] = 793,
		["709"] = 775,
		["710"] = 795,
		["711"] = 796,
		["712"] = 796,
		["714"] = 797,
		["715"] = 798,
		["716"] = 799,
		["717"] = 800,
		["718"] = 801,
		["720"] = 801,
		["724"] = 801,
		["726"] = 801,
		["727"] = 802,
		["728"] = 803,
		["729"] = 804,
		["730"] = 805,
		["731"] = 806,
		["732"] = 807,
		["737"] = 812,
		["738"] = 795,
		["739"] = 814,
		["740"] = 815,
		["741"] = 816,
		["743"] = 818,
		["745"] = 814,
		["746"] = 821,
		["747"] = 822,
		["748"] = 823,
		["750"] = 825,
		["752"] = 821,
		["753"] = 828,
		["754"] = 829,
		["755"] = 830,
		["757"] = 832,
		["758"] = 833,
		["760"] = 836,
		["761"] = 837,
		["762"] = 838,
		["764"] = 840,
		["765"] = 840,
		["766"] = 840,
		["767"] = 840,
		["768"] = 840,
		["769"] = 828,
		["770"] = 843,
		["771"] = 844,
		["773"] = 846,
		["774"] = 847,
		["775"] = 848,
		["776"] = 849,
		["778"] = 851,
		["779"] = 852,
		["782"] = 855,
		["783"] = 856,
		["785"] = 859,
		["786"] = 860,
		["788"] = 862,
		["790"] = 846,
		["791"] = 866,
		["792"] = 866,
		["793"] = 866,
		["795"] = 867,
		["796"] = 868,
		["797"] = 869,
		["798"] = 869,
		["799"] = 869,
		["800"] = 869,
		["801"] = 869,
		["803"] = 869,
		["804"] = 866,
		["805"] = 871,
		["806"] = 872,
		["807"] = 873,
		["808"] = 874,
		["809"] = 874,
		["810"] = 874,
		["812"] = 874,
		["813"] = 871,
		["814"] = 876,
		["815"] = 877,
		["816"] = 878,
		["817"] = 879,
		["818"] = 880,
		["820"] = 883,
		["821"] = 884,
		["822"] = 885,
		["823"] = 886,
		["827"] = 891,
		["828"] = 892,
		["830"] = 894,
		["831"] = 894,
		["832"] = 894,
		["833"] = 894,
		["834"] = 895,
		["835"] = 896,
		["837"] = 894,
		["838"] = 894,
		["839"] = 899,
		["841"] = 876,
		["842"] = 903,
		["843"] = 904,
		["845"] = 907,
		["846"] = 908,
		["847"] = 908,
		["848"] = 908,
		["849"] = 910,
		["850"] = 911,
		["851"] = 913,
		["853"] = 915,
		["854"] = 915,
		["855"] = 915,
		["856"] = 915,
		["857"] = 907,
		["858"] = 918,
		["859"] = 919,
		["861"] = 922,
		["862"] = 923,
		["863"] = 925,
		["864"] = 926,
		["866"] = 928,
		["867"] = 922,
		["868"] = 931,
		["869"] = 932,
		["871"] = 935,
		["872"] = 936,
		["873"] = 938,
		["874"] = 939,
		["876"] = 941,
		["877"] = 935,
		["878"] = 943,
		["879"] = 944,
		["881"] = 947,
		["882"] = 948,
		["883"] = 950,
		["884"] = 951,
		["886"] = 953,
		["887"] = 947,
		["888"] = 955,
		["889"] = 956,
		["890"] = 957,
		["891"] = 958,
		["893"] = 960,
		["894"] = 956,
		["895"] = 963,
		["896"] = 964,
		["898"] = 966,
		["899"] = 967,
		["900"] = 968,
		["901"] = 969,
		["903"] = 971,
		["905"] = 973,
		["906"] = 974,
		["907"] = 975,
		["909"] = 977,
		["910"] = 978,
		["911"] = 966,
		["912"] = 980,
		["913"] = 981,
		["915"] = 983,
		["916"] = 984,
		["917"] = 985,
		["918"] = 983,
		["919"] = 987,
		["920"] = 988,
		["923"] = 989,
		["924"] = 990,
		["925"] = 990,
		["926"] = 990,
		["927"] = 990,
		["928"] = 987,
		["929"] = 996,
		["930"] = 997,
		["932"] = 999,
	}
)
function GetRecordTableIndex(l)
	for m, n in e(tRecordTable) do
		local o = n[1]
		local p = n[2]
		if p == l then
			return o
		end
	end
	return
end
tRecordTable = d(c)
function CreateRecordTable(l)
	if l == nil then
		l = {}
	end
	local o = 0
	while tRecordTable:has(o) do
		o = o + 1
	end
	tRecordTable:set(o, l)
	return tRecordTable:get(o), o
end
function RemoveRecordTable(q)
	local o
	if type(q) == "number" then
		o = q
	else
		o = GetRecordTableIndex(q)
	end
	if o then
		tRecordTable:delete(o)
		return true
	end
	return false
end
function GetRecordTableByIndex(o)
	return tRecordTable:get(o)
end
function RecordTableCount()
	return tRecordTable.size
end
function GetAbilityNameLevelSpecialValueFor(r, s, t)
	local u = KeyValues.AbilitiesKv[r]
	if u == nil then
		u = KeyValues.ItemsKv[r]
	end
	local v = u
	if type(v) == "table" then
		if type(v.AbilityValues) == "table" then
			local w = v.AbilityValues[s]
			if w then
				local x
				if type(w) == "table" then
					x = w.value
				elseif type(w) ~= "nil" then
					x = w
				end
				if x ~= nil then
					local y = f(tostring(x), " ")
					if #y > 0 then
						return toFiniteNumber(y[math.min(t, #y - 1) + 1])
					end
				end
			end
		end
		if type(v.AbilitySpecial) == "table" then
			for z in pairs(v.AbilitySpecial) do
				local A = v.AbilitySpecial[z]
				if A[s] ~= nil then
					local y = f(tostring(A[s]), " ")
					if #y > 0 then
						return toFiniteNumber(y[math.min(t, #y - 1) + 1])
					end
				end
			end
		end
	end
	return 0
end
function GetAbilityNameLevelSpecialAddedValueFor(r, s, t, B)
	local C = KeyValues.AbilitiesKv[r]
	if C == nil then
		C = KeyValues.ItemsKv[r]
	end
	local v = C
	if type(v) == "table" then
		if type(v.AbilityValues) == "table" then
			local w = v.AbilityValues[s]
			if type(w) == "table" then
				local x = w[B]
				if x ~= nil then
					local y = f(tostring(x), " ")
					if #y > 0 then
						local D = y[math.min(t, #y - 1) + 1]
						local E = g(D)
						if h(g(E)) then
							return E
						else
							return D
						end
					end
				end
			end
		end
		if type(v.AbilitySpecial) == "table" then
			for z in pairs(v.AbilitySpecial) do
				local A = v.AbilitySpecial[z]
				if A[s] ~= nil and A[B] ~= nil then
					local y = f(tostring(A[s]), " ")
					if #y > 0 then
						local D = y[math.min(t, #y - 1) + 1]
						local E = g(D)
						if h(g(E)) then
							return E
						else
							return D
						end
					end
				end
			end
		end
	end
end
function KnockBackFunction(F, G, H, I)
	F = Clamp(F, 0, 1)
	return (2 * I + 2 * G - 4 * H) * F * F + (4 * H - I - 3 * G) * F + G
end
CBaseAbility = IsServer() and CDOTABaseAbility or C_DOTABaseAbility
if CBaseAbility.GetLevelSpecialValueFor_Engine == nil then
	CBaseAbility.GetLevelSpecialValueFor_Engine = CBaseAbility.GetLevelSpecialValueFor
end
CBaseAbility.GetLevelSpecialValueFor = function(self, J, K)
	if not IsValid(self) then
		return 0
	end
	local L = self:GetCaster()
	local M = self:GetAbilityName()
	local N
	if self:IsItem() then
		N = KeyValues.ItemsKv[M]
	else
		N = KeyValues.AbilitiesKv[M]
	end
	local O = N
	if O == nil then
		return 0
	end
	local P = O.AbilityValues
	if P == nil then
		P = {}
	end
	local Q = P
	local R = Q[J]
	local S
	if L then
		local T = L:GetPlayerOwnerID()
		S = AbilityUpgrades:GetAbilityMechanicsUpgradeLevelSpecialValue(T, M, J, K)
		if type(S) == "number" then
			S = AbilityUpgrades:CalcSpecialValueUpgrade(T, M, J, S)
		end
	end
	return GetAbilityValues(nil, R, K, L, S)
end
if CBaseAbility.GetSpecialValueFor_Engine == nil then
	CBaseAbility.GetSpecialValueFor_Engine = CBaseAbility.GetSpecialValueFor
end
CBaseAbility.GetSpecialValueFor = function(self, J)
	if not IsValid(self) then
		return 0
	end
	return self:GetLevelSpecialValueFor(J, self:GetLevel())
end
CBaseAbility.HasTalent = function(self, U)
	if not IsValid(self) then
		return false
	end
	local V = self:GetCaster()
	local W = V and V:FindAbilityByName(U)
	if not IsValid(W) or W:GetLevel() == 0 then
		return false
	end
	return true
end
CBaseAbility.GetTalentValue = function(self, U, s)
	if not IsValid(self) then
		return 0
	end
	local V = self:GetCaster()
	local W = V and V:FindAbilityByName(U)
	if not IsValid(W) or W:GetLevel() == 0 then
		return 0
	end
	return W:GetSpecialValueFor(s)
end
CBaseAbility.GetSpecialAddedValueFor = function(self, s, B)
	if not IsValid(self) then
		return
	end
	return GetAbilityNameLevelSpecialAddedValueFor(self:GetName(), s, self:GetLevel() - 1, B)
end
CBaseAbility.GetLevelSpecialAddedValueFor = function(self, s, B, t)
	if t == nil then
		t = 1
	end
	if not IsValid(self) then
		return
	end
	return GetAbilityNameLevelSpecialAddedValueFor(self:GetName(), s, t - 1, B)
end
CBaseAbility.GetCustomAbilityType = function(self)
	local X = KeyValues.AbilitiesKv[self:GetAbilityName()]
	if X ~= nil then
		X = X.CustomAbilityType
	end
	local Y = X
	if Y == nil or Y == "" then
		Y = "ABILITY_TYPE_NONE"
	end
	return CUSTOM_ABILITY_TYPE[Y]
end
CBaseAbility.PRD = function(self, Z, _)
	if Z <= 0 then
		return false
	end
	local L = self:GetCaster()
	return PRD(L, Z, _ or self:GetAbilityName())
end
CBaseAbility.GetDamageType = function(self)
	return KeyValues.AbilitiesKv[self:GetAbilityName()].DamageType
end
CBaseAbility.GetSectSpecialValueFor = function(self, a0, s)
	if not IsValid(self) then
		return 0
	end
	local w = 0
	local V = self:GetCaster()
	if self:GetCaster() then
		local a1 = self:GetSectAbilityLevel(a0)
		local T = V:GetPlayerOwnerID()
		w = self:GetSectSpecialValueForUnit(a0, s, a1)
		local S = AbilityUpgrades:GetAbilityMechanicsUpgradeLevelSpecialValue(T, a0, s, a1)
		if type(S) == "number" then
			w = S
		end
		w = AbilityUpgrades:CalcSpecialValueUpgrade(T, a0, s, w)
	end
	return w
end
CBaseAbility.GetSectAbilityLevel = function(self, a0)
	local a1 = 0
	local V = self:GetCaster()
	local T = V:GetPlayerOwnerID()
	if V:HasModifier("modifier_neutral") then
		if IsServer() then
			local a2 = V:entindex()
			if a2 then
				local a3 = GameState:getState()
				if
					GameState:getStateName() == "GameState_ConfirmNeutral"
					or GameState:getStateName() == "GameState_ConfirmRoshan"
					or GameState:getStateName() == "GameState_Neutral"
				then
					local a4
					if a3 ~= nil then
						a4 = a3.neutralSectData
					end
					local a5 = a4
					if a5 and a5[a0] then
						a1 = a5[a0].level
					else
						a1 = 0
					end
				end
			else
				print("<!><E> CDOTA_Buff.GetSectSpecialValueFor hCaster.entindex is NULL.")
			end
		else
			a1 = 0
		end
	else
		if IsServer() then
			local a6 = PlayerData:getHero(T)
			if a6 then
				local a7 = a6:getAbilityUpgradeData(true, true)
				if a7 and a7[a0] then
					a1 = a7[a0].level
				end
				local a8 = a6:getTempAbilityUpgrade()
				if a8 and a8[a0] and KeyValues.AbilityUpgradesKvs[a0] then
					local a9 = KeyValues.AbilityUpgradesKvs[a0].MaxLevel
					a1 = math.min(a1 + a8[a0].level, a9)
				end
			end
		else
			local a5 = CustomNetTables:GetTableValue("sect_data", "ability_upgrade_" .. tostring(T))
			if a5 and a5[a0] then
				a1 = a5[a0].level
			end
			local a8 = CustomNetTables:GetTableValue("sect_data", "temp_ability_upgrade_" .. tostring(T))
			if a8 and a8[a0] and KeyValues.AbilityUpgradesKvs[a0] then
				local a9 = KeyValues.AbilityUpgradesKvs[a0].MaxLevel
				a1 = math.min(a1 + a8[a0].level, a9)
			end
		end
	end
	return a1
end
CBaseAbility.GetSectSpecialValueForUnit = function(self, a0, s, t)
	if t and t > 0 then
		local aa = KeyValues.AbilityUpgradesKvs[a0]
		if aa ~= nil then
			aa = aa.AbilityValues[s]
		end
		local ab = aa
		if ab == nil then
			return 0
		end
		local ac = CustomNetTables:GetTableValue("sect_data", "sect_adjust") or {}
		local ad = self:GetAbilityName()
		local ae = ac and ac[ad]
		local af = ae and ae.adjust or 0
		if type(ab) ~= "table" then
			local ag = f(tostring(ab), " ")
			if ag[t] then
				return (100 + af) / 100 * tonumber(ag[t])
			elseif ag[1] then
				return (100 + af) / 100 * tonumber(ag[1])
			end
		else
			local ag = f(tostring(ab.value), " ")
			if ag[t] then
				local w = tonumber(ag[t])
				if ab.modifier and ab.modifier == "constant" then
					return w
				end
				if ab.modifier and ab.modifier == "increase" then
					return w * (100 - af) / 100
				end
				return w * (100 + af) / 100
			elseif ag[1] then
				return (100 + af) / 100 * tonumber(ag[1])
			end
		end
	end
	return 0
end
if IsServer() then
	CDOTABaseAbility.IsAbilityReady = function(self)
		local V = self:GetCaster()
		local ah = self:GetBehaviorInt()
		if not IsValid(V) then
			return false
		end
		local ai = V:GetCurrentActiveAbility()
		if IsValid(ai) and ai:IsInAbilityPhase() then
			return false
		end
		if V:HasModifier("modifier_passive_cast") then
			return false
		end
		if self:GetLevel() <= 0 then
			return false
		end
		if self:IsHidden() then
			return false
		end
		if not self:IsActivated() then
			return false
		end
		if not self:IsCooldownReady() then
			return false
		end
		if not self:IsOwnersManaEnough() then
			return false
		end
		if not self:IsOwnersGoldEnough(V:GetPlayerOwnerID()) then
			return false
		end
		if V:IsHexed() or V:IsCommandRestricted() then
			return false
		end
		if
			bit.band(ah, DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE) ~= DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
			and V:IsStunned()
		then
			return false
		end
		if not self:IsItem() and not self:IsPassive() and V:IsSilenced() then
			return false
		end
		if not self:IsItem() and self:IsPassive() and V:PassivesDisabled() then
			return false
		end
		if self:IsItem() and not self:IsPassive() and V:IsMuted() then
			return false
		end
		if
			bit.band(ah, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL) ~= DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
			and V:IsChanneling()
		then
			return false
		end
		if not self:IsFullyCastable() then
			return false
		end
		return true
	end
end
CDOTA_Buff.GetAbilitySpecialValueFor = function(self, s)
	if not IsValid(self) or not IsValid(self:GetAbility()) then
		return 0
	end
	return self:GetAbility():GetSpecialValueFor(s)
end
CDOTA_Buff.GetAbilityTalentValue = function(self, U, s)
	if not IsValid(self) then
		return 0
	end
	local V = self:GetCaster()
	local W = V and V:FindAbilityByName(U)
	if not IsValid(W) or W:GetLevel() == 0 then
		return 0
	end
	return W:GetSpecialValueFor(s)
end
CDOTA_Buff.HasTalent = function(self, U)
	if not IsValid(self) then
		return false
	end
	local V = self:GetCaster()
	local W = V and V:FindAbilityByName(U)
	if not IsValid(W) or W:GetLevel() == 0 then
		return false
	end
	return true
end
CDOTA_Buff.GetAbilityLevelSpecialValueFor = function(self, s, t)
	if not IsValid(self) or not IsValid(self:GetAbility()) then
		return 0
	end
	return self:GetAbility():GetLevelSpecialValueFor(s, t)
end
CDOTA_Buff.GetAbilitySpecialAddedValueFor = function(self, s, B)
	if not IsValid(self) or not IsValid(self:GetAbility()) then
		return 0
	end
	return GetAbilityNameLevelSpecialAddedValueFor(self:GetAbility():GetName(), s, self:GetAbility():GetLevel() - 1, B)
end
CDOTA_Buff.GetSectSpecialValueFor = function(self, a0, s)
	if not IsValid(self) or not IsValid(self:GetAbility()) then
		return 0
	end
	local w = 0
	local V = self:GetCaster()
	if self:GetCaster() then
		local a1 = self:GetSectAbilityLevel(a0)
		local T = V:GetPlayerOwnerID()
		w = self:GetSectSpecialValueForUnit(a0, s, a1)
		local S = AbilityUpgrades:GetAbilityMechanicsUpgradeLevelSpecialValue(T, a0, s, a1)
		if type(S) == "number" then
			w = S
		end
		w = AbilityUpgrades:CalcSpecialValueUpgrade(T, a0, s, w)
	end
	return w
end
CDOTA_Buff.GetSectAbilityLevel = function(self, a0)
	local a1 = 0
	local V = self:GetCaster()
	local T = V:GetPlayerOwnerID()
	if V:HasModifier("modifier_neutral") then
		if IsServer() then
			local a2 = V:entindex()
			if a2 then
				local a3 = GameState:getState()
				if
					GameState:getStateName() == "GameState_ConfirmNeutral"
					or GameState:getStateName() == "GameState_ConfirmRoshan"
					or GameState:getStateName() == "GameState_Neutral"
				then
					local aj
					if a3 ~= nil then
						aj = a3.neutralSectData
					end
					local a5 = aj
					if a5 and a5[a0] then
						a1 = a5[a0].level
					else
						a1 = 0
					end
				end
			else
				print("<!><E> CDOTA_Buff.GetSectSpecialValueFor hCaster.entindex is NULL.")
			end
		else
			a1 = 0
		end
	else
		if IsServer() then
			local a6 = PlayerData:getHero(T)
			if a6 then
				local a7 = a6:getAbilityUpgradeData(true, true)
				if a7 and a7[a0] then
					a1 = a7[a0].level
				end
				local a8 = a6:getTempAbilityUpgrade()
				if a8 and a8[a0] and KeyValues.AbilityUpgradesKvs[a0] then
					local a9 = KeyValues.AbilityUpgradesKvs[a0].MaxLevel
					a1 = math.min(a1 + a8[a0].level, a9)
				end
			end
		else
			local a5 = CustomNetTables:GetTableValue("sect_data", "ability_upgrade_" .. tostring(T))
			if a5 and a5[a0] then
				a1 = a5[a0].level
			end
			local a8 = CustomNetTables:GetTableValue("sect_data", "temp_ability_upgrade_" .. tostring(T))
			if a8 and a8[a0] and KeyValues.AbilityUpgradesKvs[a0] then
				local a9 = KeyValues.AbilityUpgradesKvs[a0].MaxLevel
				a1 = math.min(a1 + a8[a0].level, a9)
			end
		end
	end
	return a1
end
CDOTA_Buff.GetSectSpecialValueForUnit = function(self, a0, s, t)
	if t and t > 0 then
		local ak = KeyValues.AbilityUpgradesKvs[a0]
		if ak ~= nil then
			ak = ak.AbilityValues[s]
		end
		local ab = ak
		if ab == nil then
			return 0
		end
		local ac = CustomNetTables:GetTableValue("sect_data", "sect_adjust") or {}
		local ad = self:GetAbility():GetAbilityName()
		local al = ac and ac[ad]
		local af = al and al.adjust or 0
		if type(ab) ~= "table" then
			local ag = f(tostring(ab), " ")
			if ag[t] then
				return (100 + af) / 100 * tonumber(ag[t])
			elseif ag[1] then
				return (100 + af) / 100 * tonumber(ag[1])
			end
		else
			local ag = f(tostring(ab.value), " ")
			if ag[t] then
				local w = tonumber(ag[t])
				if ab.modifier and ab.modifier == "constant" then
					return w
				end
				if ab.modifier and ab.modifier == "increase" then
					return w * (100 - af) / 100
				end
				return w * (100 + af) / 100
			elseif ag[1] then
				return (100 + af) / 100 * tonumber(ag[1])
			end
		end
	end
	return 0
end
CDOTA_Buff.GetCustomAbilityValueFor = function(self, a0, s)
	if not IsValid(self) or not IsValid(self:GetAbility()) then
		return 0
	end
	local am = self:GetAbility()
	local V = self:GetCaster()
	if IsValid(V) and IsValid(am) then
		local t = 1
		if t > 0 then
			local ab = KeyValues.CustomAbilitiesKv[a0].AbilityValues[s]
			local ag = f(ab, " ")
			if ag[t] then
				return tonumber(ag[t])
			elseif ag[1] then
				return tonumber(ag[1])
			end
		end
	end
	return 0
end
CDOTA_Buff.GetEffectCardValueFor = function(self, s)
	if not IsValid(self) then
		return 0
	end
	local V = self:GetCaster()
	if IsValid(V) then
		local t = 1
		if t > 0 then
			local _ = i(self:GetName(), "modifier_", "")
			local ab = KeyValues.CardEffectKV[_].AbilityValues[s]
			if ab then
				local ag = f(ab, " ")
				if ag[t] then
					return tonumber(ag[t])
				elseif ag[1] then
					return tonumber(ag[1])
				end
			end
		end
	end
	return 0
end
CDOTA_Buff.GetGreevilEffectValueFor = function(self, _, s)
	if not IsValid(self) then
		return 0
	end
	local V = self:GetCaster()
	if IsValid(V) then
		local t = 1
		if t > 0 then
			local an = KeyValues.GreevilEffectKV[_]
			if an ~= nil then
				an = an.AbilityValues
			end
			local ao
			if an ~= nil then
				ao = an[s]
			end
			local ab = ao
			if ab then
				local ag = f(ab, " ")
				if ag[t] then
					return tonumber(ag[t])
				elseif ag[1] then
					return tonumber(ag[1])
				end
			end
		end
	end
	return 0
end
CDOTA_Buff.IncrementStackCount = function(self, ap)
	if ap == nil then
		self:SetStackCount(self:GetStackCount() + 1)
	else
		self:SetStackCount(self:GetStackCount() + ap)
	end
end
CDOTA_Buff.DecrementStackCount = function(self, ap)
	if ap == nil then
		self:SetStackCount(self:GetStackCount() - 1)
	else
		self:SetStackCount(self:GetStackCount() - ap)
	end
end
CDOTA_Buff.PRD = function(self, Z, _)
	if not Z then
		return false
	end
	if Z <= 0 then
		return false
	end
	local L = self:GetCaster()
	if not L then
		L = self:GetParent()
	end
	return PRD(L, Z, _ or self:GetName())
end
if CDOTA_Buff.StartIntervalThink_Engine == nil then
	CDOTA_Buff.StartIntervalThink_Engine = CDOTA_Buff.StartIntervalThink
end
CDOTA_Buff.StartIntervalThink = function(self, aq)
	if IsServer() then
		if self:GetName() == "modifier_common" then
			debug.traceback(
				(
					(
						(("<!><M> Player[" .. tostring(self:GetCaster():GetPlayerOwnerID())) .. "][")
						.. PlayerData:steamIDOf(self:GetCaster():GetPlayerOwnerID())
					) .. "]: CDOTA_Buff.StartIntervalThink: "
				) .. self:GetName()
			)
		end
		if aq == -1 then
			TimerManager:StopTimer(self._TimerThinkIndex)
			return
		end
		if self._TimerThinkIndex ~= nil then
			TimerManager:StopTimer(self._TimerThinkIndex)
		end
		local o = TimerManager:StartIntervalThink(self, aq, self.OnIntervalThink)
		self._TimerThinkIndex = o
	else
		self:StartIntervalThink_Engine(aq)
	end
end
CDOTA_Buff.AddCount = function(self, ar, J)
	if ar == nil then
		ar = 1
	end
	local T = self:GetParent():GetPlayerOwnerID()
	local _ = J or self:GetName()
	local as = PlayerData
	local at = PlayerData.saveData
	local au = PlayerData:loadData(T, _)
	if au == nil then
		au = 0
	end
	at(as, T, _, au + ar)
end
CDOTA_Buff.GetCount = function(self, J)
	local T = self:GetParent():GetPlayerOwnerID()
	local _ = J or self:GetName()
	local av = PlayerData:loadData(T, _)
	if av == nil then
		av = 0
	end
	return av
end
CDOTA_Buff.StartThink = function(self, aq, _)
	if IsServer() then
		local aw = _ or self:GetName()
		if self._ThinkList == nil then
			self._ThinkList = {}
		end
		if aq == -1 then
			if self._ThinkList[aw] then
				TimerManager:StopTimer(self._ThinkList[aw])
				self._ThinkList[aw] = nil
			end
			return
		end
		if self._ThinkList[aw] ~= nil then
			TimerManager:StopTimer(self._ThinkList[aw])
		end
		local o = TimerManager:StartIntervalThink(self, aq, function()
			if self.OnThink then
				self:OnThink(aw)
			end
		end)
		self._ThinkList[aw] = o
	end
end
if CDOTA_Buff.SetDuration_Engine == nil then
	CDOTA_Buff.SetDuration_Engine = CDOTA_Buff.SetDuration
end
CDOTA_Buff.SetDuration = function(self, ...)
	local ax = { ... }
	local ay = ax[1]
	local az = j(ax, 1)
	if type(self.EOM_SetDuration) == "function" then
		ay = ay + 1
		self:EOM_SetDuration(...)
	end
	self:SetDuration_Engine(ay, unpack(az))
end
if CDOTA_Buff.GetDuration_Engine == nil then
	CDOTA_Buff.GetDuration_Engine = CDOTA_Buff.GetDuration
end
CDOTA_Buff.GetDuration = function(self)
	local ay = self:GetDuration_Engine()
	if type(self.EOM_SetDuration) == "function" then
		ay = math.max(ay - 1, 0)
	end
	return ay
end
if CDOTA_Buff.GetDieTime_Engine == nil then
	CDOTA_Buff.GetDieTime_Engine = CDOTA_Buff.GetDieTime
end
CDOTA_Buff.GetDieTime = function(self)
	local aA = self:GetDieTime_Engine()
	if type(self.EOM_SetDuration) == "function" then
		aA = aA - 1
	end
	return aA
end
if CDOTA_Buff.GetRemainingTime_Engine == nil then
	CDOTA_Buff.GetRemainingTime_Engine = CDOTA_Buff.GetRemainingTime
end
CDOTA_Buff.GetRemainingTime = function(self)
	local aB = self:GetRemainingTime_Engine()
	if type(self.EOM_SetDuration) == "function" then
		aB = math.max(aB - 1, 0)
	end
	return aB
end
BaseNPC = IsServer() and CDOTA_BaseNPC or C_DOTA_BaseNPC
BaseNPC.IsFriendly = function(self, aC)
	if IsValid(self) and IsValid(aC) then
		return self:GetTeamNumber() == aC:GetTeamNumber()
	end
	return false
end
if CScriptParticleManager.CreateParticle_Engine == nil then
	CScriptParticleManager.CreateParticle_Engine = CScriptParticleManager.CreateParticle
end
CScriptParticleManager.CreateParticle = function(self, aD, aE, aF, aG, aH)
	if not aH and IsServer() and CREATEPARTICLE_FRAME_ALL_LIMIT_ENABLE then
		if CREATEPARTICLE_FRAME_ALL_LIMIT_COUNTER == CREATEPARTICLE_FRAME_ALL_LIMIT_MAX then
			return -1
		end
		CREATEPARTICLE_FRAME_ALL_LIMIT_COUNTER = CREATEPARTICLE_FRAME_ALL_LIMIT_COUNTER + 1
	end
	aG = aG or aF
	if IsValid(aG) then
		aD = Wearable:getReplaceParticle(aG, aD)
	end
	self:DynamicPrecacheParticle(aD)
	return self:CreateParticle_Engine(aD, aE, aF)
end
if CScriptParticleManager.CreateParticleForPlayer_Engine == nil then
	CScriptParticleManager.CreateParticleForPlayer_Engine = CScriptParticleManager.CreateParticleForPlayer
end
CScriptParticleManager.CreateParticleForPlayer = function(self, aD, aE, aF, aI)
	self:DynamicPrecacheParticle(aD)
	return self:CreateParticleForPlayer_Engine(aD, aE, aF, aI)
end
CScriptParticleManager.DynamicPrecacheParticle = function(self, aD)
	if not aD or DYNAMIC_PRECACHE_RECORD[aD] then
		return
	end
	DYNAMIC_PRECACHE_RECORD[aD] = true
	ParticleManager:DestroyParticle(
		ParticleManager:CreateParticleForTeam(aD, PATTACH_ABSORIGIN, nil, DOTA_TEAM_GOODGUYS),
		true
	)
end
if IsServer() then
	require("abilities.server")
else
	require("abilities.client")
end