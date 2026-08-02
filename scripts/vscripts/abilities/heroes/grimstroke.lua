--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/grimstroke"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayForEach
local h = b.__TS__New
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 292,
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["22"] = 6,
		["23"] = 7,
		["24"] = 6,
		["25"] = 7,
		["26"] = 8,
		["27"] = 9,
		["28"] = 8,
		["29"] = 7,
		["30"] = 6,
		["31"] = 7,
		["33"] = 7,
		["34"] = 13,
		["35"] = 21,
		["36"] = 13,
		["37"] = 21,
		["39"] = 21,
		["40"] = 27,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 13,
		["46"] = 45,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 49,
		["51"] = 51,
		["52"] = 52,
		["53"] = 55,
		["54"] = 57,
		["55"] = 58,
		["56"] = 45,
		["57"] = 60,
		["58"] = 61,
		["59"] = 62,
		["60"] = 63,
		["61"] = 64,
		["62"] = 65,
		["64"] = 60,
		["65"] = 68,
		["66"] = 69,
		["67"] = 70,
		["68"] = 71,
		["69"] = 72,
		["70"] = 73,
		["73"] = 74,
		["74"] = 75,
		["77"] = 68,
		["78"] = 79,
		["79"] = 80,
		["80"] = 79,
		["81"] = 87,
		["82"] = 88,
		["83"] = 89,
		["84"] = 90,
		["85"] = 91,
		["86"] = 100,
		["87"] = 101,
		["88"] = 102,
		["89"] = 103,
		["90"] = 104,
		["91"] = 105,
		["92"] = 106,
		["93"] = 107,
		["94"] = 107,
		["99"] = 87,
		["100"] = 116,
		["101"] = 117,
		["102"] = 116,
		["103"] = 119,
		["104"] = 120,
		["105"] = 121,
		["106"] = 121,
		["107"] = 121,
		["108"] = 121,
		["109"] = 119,
		["110"] = 125,
		["111"] = 126,
		["112"] = 127,
		["115"] = 128,
		["116"] = 129,
		["118"] = 130,
		["119"] = 130,
		["120"] = 131,
		["121"] = 131,
		["122"] = 131,
		["123"] = 131,
		["124"] = 131,
		["125"] = 132,
		["126"] = 132,
		["127"] = 132,
		["128"] = 132,
		["129"] = 132,
		["130"] = 132,
		["131"] = 132,
		["132"] = 132,
		["133"] = 132,
		["134"] = 132,
		["135"] = 132,
		["136"] = 133,
		["137"] = 134,
		["138"] = 135,
		["139"] = 136,
		["140"] = 137,
		["141"] = 138,
		["142"] = 139,
		["145"] = 130,
		["148"] = 125,
		["149"] = 144,
		["150"] = 145,
		["151"] = 144,
		["152"] = 147,
		["153"] = 148,
		["154"] = 147,
		["155"] = 21,
		["156"] = 13,
		["157"] = 13,
		["158"] = 13,
		["159"] = 13,
		["160"] = 13,
		["161"] = 13,
		["162"] = 13,
		["163"] = 13,
		["164"] = 21,
		["166"] = 21,
		["168"] = 155,
		["169"] = 156,
		["170"] = 155,
		["171"] = 156,
		["172"] = 157,
		["173"] = 158,
		["174"] = 159,
		["175"] = 160,
		["176"] = 160,
		["177"] = 160,
		["178"] = 161,
		["179"] = 162,
		["180"] = 163,
		["181"] = 164,
		["182"] = 165,
		["183"] = 166,
		["185"] = 160,
		["186"] = 160,
		["187"] = 157,
		["188"] = 156,
		["189"] = 155,
		["190"] = 156,
		["192"] = 156,
		["193"] = 172,
		["194"] = 181,
		["195"] = 172,
		["196"] = 181,
		["197"] = 186,
		["198"] = 188,
		["199"] = 189,
		["200"] = 190,
		["201"] = 192,
		["202"] = 186,
		["203"] = 194,
		["204"] = 195,
		["205"] = 194,
		["206"] = 199,
		["207"] = 200,
		["208"] = 201,
		["209"] = 202,
		["211"] = 204,
		["214"] = 207,
		["215"] = 208,
		["216"] = 208,
		["217"] = 208,
		["218"] = 208,
		["219"] = 208,
		["220"] = 209,
		["221"] = 209,
		["222"] = 209,
		["223"] = 209,
		["224"] = 209,
		["225"] = 209,
		["226"] = 209,
		["227"] = 209,
		["228"] = 209,
		["229"] = 210,
		["230"] = 210,
		["231"] = 210,
		["232"] = 210,
		["233"] = 210,
		["234"] = 210,
		["235"] = 210,
		["236"] = 210,
		["238"] = 199,
		["239"] = 213,
		["240"] = 214,
		["241"] = 215,
		["243"] = 213,
		["244"] = 218,
		["245"] = 219,
		["246"] = 220,
		["247"] = 221,
		["250"] = 224,
		["251"] = 225,
		["252"] = 226,
		["253"] = 227,
		["256"] = 218,
		["257"] = 231,
		["258"] = 232,
		["259"] = 233,
		["261"] = 231,
		["262"] = 181,
		["263"] = 172,
		["264"] = 172,
		["265"] = 172,
		["266"] = 172,
		["267"] = 172,
		["268"] = 172,
		["269"] = 172,
		["270"] = 172,
		["271"] = 172,
		["272"] = 181,
		["274"] = 181,
		["275"] = 238,
		["276"] = 247,
		["277"] = 238,
		["278"] = 247,
		["280"] = 247,
		["281"] = 252,
		["282"] = 238,
		["283"] = 253,
		["284"] = 254,
		["285"] = 256,
		["286"] = 258,
		["287"] = 253,
		["288"] = 260,
		["289"] = 261,
		["290"] = 262,
		["293"] = 265,
		["294"] = 266,
		["295"] = 268,
		["296"] = 269,
		["297"] = 270,
		["299"] = 272,
		["300"] = 273,
		["303"] = 277,
		["304"] = 278,
		["305"] = 278,
		["306"] = 278,
		["307"] = 278,
		["308"] = 278,
		["309"] = 279,
		["311"] = 260,
		["312"] = 283,
		["313"] = 284,
		["314"] = 285,
		["315"] = 285,
		["316"] = 284,
		["317"] = 283,
		["318"] = 288,
		["319"] = 289,
		["320"] = 288,
		["321"] = 247,
		["322"] = 238,
		["323"] = 238,
		["324"] = 238,
		["325"] = 238,
		["326"] = 238,
		["327"] = 238,
		["328"] = 238,
		["329"] = 238,
		["330"] = 238,
		["331"] = 247,
		["333"] = 247,
		["334"] = 292,
		["335"] = 292,
		["336"] = 292,
		["337"] = 292,
		["338"] = 292,
		["339"] = 292,
		["340"] = 292,
		["341"] = 292,
		["342"] = 295,
		["343"] = 295,
		["344"] = 312,
		["345"] = 313,
		["346"] = 314,
		["347"] = 315,
		["348"] = 316,
		["349"] = 317,
		["350"] = 318,
		["351"] = 319,
		["352"] = 320,
		["353"] = 320,
		["354"] = 320,
		["355"] = 320,
		["356"] = 321,
		["357"] = 321,
		["358"] = 321,
		["359"] = 321,
		["360"] = 321,
		["361"] = 322,
		["362"] = 312,
		["363"] = 324,
		["364"] = 325,
		["365"] = 326,
		["366"] = 326,
		["367"] = 326,
		["368"] = 326,
		["369"] = 326,
		["370"] = 326,
		["371"] = 327,
		["372"] = 331,
		["373"] = 332,
		["374"] = 332,
		["375"] = 332,
		["376"] = 333,
		["377"] = 334,
		["378"] = 332,
		["379"] = 332,
		["380"] = 324,
		["381"] = 337,
		["382"] = 338,
		["385"] = 341,
		["386"] = 342,
		["389"] = 345,
		["390"] = 346,
		["391"] = 347,
		["392"] = 348,
		["393"] = 349,
		["394"] = 349,
		["395"] = 349,
		["396"] = 349,
		["397"] = 349,
		["398"] = 349,
		["399"] = 350,
		["400"] = 351,
		["401"] = 351,
		["402"] = 351,
		["403"] = 351,
		["404"] = 351,
		["405"] = 351,
		["406"] = 351,
		["407"] = 351,
		["408"] = 359,
		["409"] = 360,
		["410"] = 361,
		["411"] = 362,
		["412"] = 363,
		["413"] = 364,
		["414"] = 365,
		["416"] = 351,
		["417"] = 351,
		["418"] = 369,
		["419"] = 337,
		["420"] = 371,
		["421"] = 372,
		["422"] = 373,
		["423"] = 373,
		["424"] = 373,
		["426"] = 374,
		["427"] = 375,
		["429"] = 376,
		["432"] = 378,
		["434"] = 379,
		["437"] = 381,
		["439"] = 382,
		["442"] = 384,
		["444"] = 385,
		["445"] = 385,
		["446"] = 385,
		["447"] = 385,
		["448"] = 385,
		["449"] = 385,
		["450"] = 385,
		["453"] = 387,
		["455"] = 388,
		["456"] = 388,
		["457"] = 388,
		["458"] = 388,
		["459"] = 388,
		["460"] = 388,
		["461"] = 388,
		["464"] = 390,
		["466"] = 391,
		["467"] = 391,
		["468"] = 391,
		["469"] = 391,
		["470"] = 391,
		["471"] = 391,
		["472"] = 391,
		["476"] = 373,
		["477"] = 373,
		["479"] = 371,
		["480"] = 397,
		["481"] = 398,
		["482"] = 399,
		["484"] = 401,
		["485"] = 402,
		["487"] = 404,
		["488"] = 405,
		["489"] = 406,
		["491"] = 408,
		["492"] = 409,
		["493"] = 397,
		["494"] = 415,
		["495"] = 416,
		["496"] = 415,
		["497"] = 416,
		["498"] = 417,
		["499"] = 418,
		["500"] = 417,
		["501"] = 416,
		["502"] = 415,
		["503"] = 416,
		["505"] = 416,
		["506"] = 422,
		["507"] = 430,
		["508"] = 422,
		["509"] = 430,
		["510"] = 431,
		["511"] = 432,
		["512"] = 431,
		["513"] = 435,
		["514"] = 436,
		["515"] = 435,
		["516"] = 438,
		["517"] = 439,
		["518"] = 438,
		["519"] = 443,
		["520"] = 444,
		["521"] = 443,
		["522"] = 446,
		["523"] = 446,
		["524"] = 446,
		["526"] = 447,
		["527"] = 448,
		["528"] = 449,
		["529"] = 450,
		["530"] = 451,
		["531"] = 452,
		["533"] = 454,
		["537"] = 446,
		["538"] = 460,
		["539"] = 461,
		["540"] = 462,
		["543"] = 465,
		["544"] = 466,
		["545"] = 467,
		["546"] = 468,
		["547"] = 468,
		["548"] = 468,
		["549"] = 468,
		["550"] = 468,
		["551"] = 468,
		["552"] = 468,
		["553"] = 468,
		["554"] = 468,
		["555"] = 469,
		["556"] = 472,
		["557"] = 460,
		["558"] = 430,
		["559"] = 422,
		["560"] = 422,
		["561"] = 422,
		["562"] = 422,
		["563"] = 422,
		["564"] = 422,
		["565"] = 422,
		["566"] = 422,
		["567"] = 430,
		["569"] = 430,
		["570"] = 479,
		["571"] = 487,
		["572"] = 479,
		["573"] = 487,
		["574"] = 488,
		["575"] = 489,
		["576"] = 488,
		["577"] = 491,
		["578"] = 492,
		["579"] = 493,
		["580"] = 494,
		["581"] = 495,
		["584"] = 498,
		["585"] = 499,
		["586"] = 500,
		["587"] = 500,
		["588"] = 500,
		["589"] = 500,
		["590"] = 500,
		["591"] = 500,
		["592"] = 500,
		["593"] = 500,
		["596"] = 491,
		["597"] = 504,
		["598"] = 505,
		["599"] = 506,
		["600"] = 507,
		["603"] = 504,
		["604"] = 511,
		["605"] = 512,
		["606"] = 513,
		["608"] = 518,
		["610"] = 511,
		["611"] = 487,
		["612"] = 479,
		["613"] = 479,
		["614"] = 479,
		["615"] = 479,
		["616"] = 479,
		["617"] = 479,
		["618"] = 479,
		["619"] = 487,
		["621"] = 487,
		["622"] = 526,
		["623"] = 527,
		["624"] = 526,
		["625"] = 527,
		["626"] = 528,
		["627"] = 529,
		["628"] = 528,
		["629"] = 527,
		["630"] = 526,
		["631"] = 527,
		["633"] = 527,
		["634"] = 533,
		["635"] = 541,
		["636"] = 533,
		["637"] = 541,
		["639"] = 541,
		["640"] = 546,
		["641"] = 533,
		["642"] = 542,
		["643"] = 543,
		["644"] = 542,
		["645"] = 547,
		["646"] = 548,
		["647"] = 547,
		["648"] = 550,
		["649"] = 551,
		["650"] = 550,
		["651"] = 555,
		["652"] = 556,
		["653"] = 555,
		["654"] = 558,
		["655"] = 558,
		["656"] = 558,
		["658"] = 559,
		["659"] = 560,
		["660"] = 561,
		["661"] = 562,
		["662"] = 563,
		["663"] = 564,
		["665"] = 566,
		["669"] = 558,
		["670"] = 573,
		["671"] = 574,
		["672"] = 575,
		["675"] = 578,
		["676"] = 579,
		["677"] = 580,
		["678"] = 581,
		["679"] = 582,
		["680"] = 583,
		["682"] = 585,
		["683"] = 585,
		["684"] = 585,
		["685"] = 585,
		["686"] = 585,
		["687"] = 585,
		["688"] = 585,
		["689"] = 585,
		["690"] = 585,
		["691"] = 585,
		["692"] = 585,
		["693"] = 585,
		["694"] = 594,
		["695"] = 595,
		["696"] = 596,
		["697"] = 596,
		["698"] = 596,
		["699"] = 596,
		["700"] = 596,
		["701"] = 601,
		["702"] = 602,
		["703"] = 604,
		["704"] = 596,
		["705"] = 606,
		["706"] = 607,
		["707"] = 608,
		["708"] = 609,
		["709"] = 610,
		["710"] = 611,
		["712"] = 596,
		["713"] = 614,
		["714"] = 615,
		["717"] = 618,
		["718"] = 619,
		["719"] = 622,
		["720"] = 596,
		["721"] = 624,
		["722"] = 625,
		["723"] = 626,
		["724"] = 627,
		["725"] = 628,
		["728"] = 596,
		["729"] = 596,
		["730"] = 573,
		["731"] = 541,
		["732"] = 533,
		["733"] = 533,
		["734"] = 533,
		["735"] = 533,
		["736"] = 533,
		["737"] = 533,
		["738"] = 533,
		["739"] = 533,
		["740"] = 541,
		["742"] = 541,
		["743"] = 638,
		["744"] = 646,
		["745"] = 638,
		["746"] = 646,
		["747"] = 648,
		["748"] = 649,
		["749"] = 650,
		["750"] = 651,
		["751"] = 652,
		["752"] = 653,
		["753"] = 655,
		["754"] = 656,
		["755"] = 657,
		["756"] = 658,
		["758"] = 660,
		["759"] = 660,
		["760"] = 660,
		["761"] = 660,
		["762"] = 660,
		["763"] = 660,
		["764"] = 660,
		["765"] = 660,
		["766"] = 660,
		["767"] = 660,
		["768"] = 660,
		["769"] = 660,
		["770"] = 670,
		["772"] = 672,
		["773"] = 673,
		["774"] = 673,
		["775"] = 673,
		["776"] = 673,
		["777"] = 673,
		["778"] = 673,
		["779"] = 673,
		["780"] = 673,
		["782"] = 648,
		["783"] = 676,
		["784"] = 677,
		["785"] = 678,
		["786"] = 679,
		["787"] = 680,
		["790"] = 676,
		["791"] = 684,
		["792"] = 685,
		["793"] = 686,
		["794"] = 687,
		["797"] = 690,
		["798"] = 690,
		["799"] = 690,
		["800"] = 690,
		["801"] = 690,
		["802"] = 690,
		["803"] = 690,
		["805"] = 684,
		["806"] = 646,
		["807"] = 638,
		["808"] = 638,
		["809"] = 638,
		["810"] = 638,
		["811"] = 638,
		["812"] = 638,
		["813"] = 638,
		["814"] = 638,
		["815"] = 646,
		["817"] = 646,
		["818"] = 695,
		["819"] = 696,
		["820"] = 695,
		["821"] = 696,
		["822"] = 697,
		["823"] = 698,
		["824"] = 697,
		["825"] = 696,
		["826"] = 695,
		["827"] = 696,
		["829"] = 696,
		["830"] = 702,
		["831"] = 710,
		["832"] = 702,
		["833"] = 710,
		["834"] = 711,
		["835"] = 712,
		["836"] = 711,
		["837"] = 716,
		["838"] = 717,
		["839"] = 718,
		["840"] = 716,
		["841"] = 710,
		["842"] = 702,
		["843"] = 702,
		["844"] = 702,
		["845"] = 702,
		["846"] = 702,
		["847"] = 702,
		["848"] = 702,
		["849"] = 702,
		["850"] = 710,
		["852"] = 710,
		["853"] = 723,
		["854"] = 731,
		["855"] = 723,
		["856"] = 731,
		["858"] = 731,
		["859"] = 732,
		["860"] = 723,
		["861"] = 734,
		["862"] = 735,
		["863"] = 734,
		["864"] = 737,
		["865"] = 738,
		["866"] = 739,
		["867"] = 740,
		["869"] = 737,
		["870"] = 743,
		["871"] = 744,
		["872"] = 743,
		["873"] = 748,
		["874"] = 749,
		["877"] = 750,
		["878"] = 751,
		["879"] = 752,
		["880"] = 753,
		["881"] = 754,
		["882"] = 754,
		["883"] = 754,
		["884"] = 754,
		["885"] = 754,
		["886"] = 754,
		["887"] = 754,
		["888"] = 754,
		["889"] = 754,
		["890"] = 755,
		["891"] = 755,
		["892"] = 755,
		["893"] = 755,
		["894"] = 755,
		["895"] = 755,
		["896"] = 755,
		["897"] = 755,
		["898"] = 755,
		["899"] = 756,
		["900"] = 758,
		["901"] = 759,
		["902"] = 760,
		["903"] = 761,
		["905"] = 763,
		["906"] = 764,
		["908"] = 766,
		["909"] = 767,
		["911"] = 748,
		["912"] = 731,
		["913"] = 723,
		["914"] = 723,
		["915"] = 723,
		["916"] = 723,
		["917"] = 723,
		["918"] = 723,
		["919"] = 723,
		["920"] = 723,
		["921"] = 731,
		["923"] = 731,
	}
)
local j = {}
local k, l
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = require("abilities.ability_ai")
local t = s.BaseAbilityAI
local u = s.registerAbilityAI
j.grimstroke_talent = c()
local v = j.grimstroke_talent
v.name = "grimstroke_talent"
d(v, n)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_grimstroke_talent"
end
v = e({ o(nil) }, v)
j.grimstroke_talent = v
j.modifier_grimstroke_talent = c()
local w = j.modifier_grimstroke_talent
w.name = "modifier_grimstroke_talent"
d(w, q)
function w.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.evade_damage_fixed = 0
	self.strokeList = {}
	self.evade_record = 0
	self.record = 0
	self.tick = 0.1
end
function w.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.evade_damage = self:GetAbilitySpecialValueFor("evade_damage")
	self.count = self:GetAbilitySpecialValueFor("count")
		+ self:GetAbilityTalentValue("grimstroke_talent_3", "count_bonus")
	self.tl1_interval_reduce = self:GetAbilityTalentValue("grimstroke_talent_1", "interval_reduce")
	self.tl1_extra_damage = self:GetAbilityTalentValue("grimstroke_talent_1", "extra_damage")
	self.tl7_trigger_cnt = self:GetAbilityTalentValue("grimstroke_talent_7", "count")
	self.s_level = self:GetAbilityTalentValue("grimstroke_shard", "level")
	self.s_count = self:GetAbilityTalentValue("grimstroke_shard", "count")
end
function w.prototype.OnCreated(self, x)
	if IsServer() then
		self.s_sect_record = {}
		self.calc_interval = self.interval
		self.evade_damage_fixed = self.evade_damage
		self.last_stroke_record = 0
	end
end
function w.prototype.OnIntervalThink(self)
	if IsServer() then
		self.record = self.record + self.tick
		if self.record >= self.calc_interval then
			self.record = 0
			if self.parent:PassivesDisabled() then
				return
			end
			self:LastStroke(self.count)
			self.evade_record = 0
		end
	end
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self.parent },
	}
end
function w.prototype.OnBattleStartBefore(self, x)
	self.record = 0
	self.evade_record = 0
	self.evade_damage_fixed = self.evade_damage + self.tl1_extra_damage
	self.calc_interval = self.interval - self.tl1_interval_reduce
	self.s_sect_record = {}
	if self.s_level > 0 then
		local y = PlayerData:getHero(self.parent:GetPlayerOwnerID())
		if y then
			local z = y:getAbilityData()
			for A, B in pairs(z) do
				if B.level >= self.s_level and f(k, A) then
					local C = self.s_sect_record
					C[#C + 1] = { type = A, count = self.s_count }
				end
			end
		end
	end
end
function w.prototype.OnBattleStart(self, x)
	self:StartIntervalThink(self.tick)
end
function w.prototype.OnBattleEnd(self, x)
	self:StartIntervalThink(-1)
	g(self.strokeList, function(D, B)
		return B:dispose()
	end)
end
function w.prototype.LastStroke(self, E)
	local F = self.parent:GetEnemy()
	if not IsInjurable(self.parent, F) then
		return
	end
	local G = self.parent:GetForwardVector()
	local H = self.base_damage + self.evade_damage_fixed * self.evade_record
	do
		local I = 0
		while I < E do
			local J = self.parent:GetAbsOrigin() + Rotation2D(nil, G, math.rad(RandomInt(145, 215))) * 400
			local K = self.strokeList
			K[#K + 1] = h(l, self, self.parent, F, J, self:GetAbility(), H, self.s_sect_record)
			if self:HasTalent("grimstroke_talent_7") then
				self.last_stroke_record = self.last_stroke_record + 1
				if self.last_stroke_record >= self.tl7_trigger_cnt then
					self.last_stroke_record = self.last_stroke_record - self.tl7_trigger_cnt
					local L = self:GetCaster()
					local M = L:FindAbilityByName("grimstroke_ult")
					M:OnSpellStart()
				end
			end
			I = I + 1
		end
	end
end
function w.prototype.Stroked(self, N)
	ArrayRemove(self.strokeList, N)
end
function w.prototype.OnEvasion(self, x)
	self.evade_record = self.evade_record + 1
end
w = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	w
)
j.modifier_grimstroke_talent = w
j.grimstroke_ult = c()
local O = j.grimstroke_ult
O.name = "grimstroke_ult"
d(O, t)
function O.prototype.OnSpellStart(self)
	local L = self:GetCaster()
	L:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GameTimer(0.3, function()
		local F = L:GetEnemy()
		if IsInjurable(F, L) then
			local P = self:GetSpecialValueFor("duration")
			F:EmitSound("Hero_Grimstroke.InkSwell.Cast")
			F:AddNewModifier(L, self, "modifier_grimstroke_ult_dot", { duration = P })
			F:AddNewModifier(L, self, "modifier_grimstroke_ult_explode", { duration = P })
		end
	end)
end
O = e({ u(nil) }, O)
j.grimstroke_ult = O
j.modifier_grimstroke_ult_dot = c()
local Q = j.modifier_grimstroke_ult_dot
Q.name = "modifier_grimstroke_ult_dot"
d(Q, q)
function Q.prototype.GetAbilitySpecialValue(self)
	self.tl2_heal_pct = self:GetAbilityTalentValue("grimstroke_talent_2", "heal_pct")
	self.tick_damage = self:GetAbilitySpecialValueFor("tick_damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.tl4_evade_bonus = self:GetAbilityTalentValue("grimstroke_talent_4", "evade_bonus")
end
function Q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.tl4_evade_bonus }
end
function Q.prototype.OnCreated(self, x)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		do
			self.parent:EmitSound("Hero_Grimstroke.InkSwell.Cast")
		end
	else
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_buff.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self.parent,
			self.caster
		)
		ParticleManager:SetParticleControl(R, 2, Vector(350, 350, 350))
		ParticleManager:SetParticleControlEnt(
			R,
			3,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(R, false, false, -1, false, true)
	end
end
function Q.prototype.OnRefresh(self, x)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function Q.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsInjurable(self.caster, self.parent) then
			self:Destroy()
			return
		end
		local H = self.tick_damage * self:GetStackCount()
		self.caster:DealDamage(self.parent, self.ability, H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		if self.tl2_heal_pct > 0 then
			Heal(self.caster, H * self.tl2_heal_pct * 0.01, "grimstroke_talent_2", "Ability")
		end
	end
end
function Q.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:RemoveModifierByName("modifier_grimstroke_ult_explode")
	end
end
Q = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				IsIndependent = true,
			}
		),
	},
	Q
)
j.modifier_grimstroke_ult_dot = Q
j.modifier_grimstroke_ult_explode = c()
local S = j.modifier_grimstroke_ult_explode
S.name = "modifier_grimstroke_ult_explode"
d(S, q)
function S.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.record = 0
end
function S.prototype.GetAbilitySpecialValue(self)
	self.evade_damage = self:GetAbilitySpecialValueFor("evade_damage")
	self.tl2_heal_pct = self:GetAbilityTalentValue("grimstroke_talent_2", "heal_pct")
	self.tl4_purge_pct = self:GetAbilityTalentValue("grimstroke_talent_4", "purge_pct")
end
function S.prototype.OnDestroy(self)
	if IsServer() then
		if not IsInjurable(self.caster, self.parent) then
			return
		end
		local H = self.record * self.evade_damage
		self.parent:EmitSound("Hero_Grimstroke.InkSwell.Stun")
		self.caster:DealDamage(self.parent, self.ability, H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		if self.tl2_heal_pct > 0 then
			Heal(self.caster, H * self.tl2_heal_pct * 0.01, "grimstroke_talent_2", "Ability")
		end
		if self.tl4_purge_pct > 0 then
			ReduceDebuff(self.caster, nil, self.tl4_purge_pct)
		end
	else
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf",
			PATTACH_ABSORIGIN,
			self.parent,
			self.caster
		)
		ParticleManager:SetParticleControl(R, 2, Vector(350, 350, 350))
		ParticleManager:ReleaseParticleIndex(R)
	end
end
function S.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { -1, self:GetParent() } }
end
function S.prototype.OnEvasion(self, x)
	self.record = self.record + 1
end
S = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	S
)
j.modifier_grimstroke_ult_explode = S
k = { "sect_ice", "sect_injury", "sect_poison", "sect_shield", "sect_fury", "sect_chaos" }
l = c()
l.name = "GrimstrokeLastStroke"
function l.prototype.____constructor(self, T, L, F, J, M, H, U)
	self.caster = L
	self.enemy = F
	self.position = J
	self.ability = M
	self.buff = T
	self.damage = H
	self.buffList = U
	self.direction = CalcDirection2D(self.enemy:GetAbsOrigin(), self.position)
	self.projectilePos = self.position + Rotation2D(nil, self.direction, -math.rad(90)) * 80
	self:CastPoint()
end
function l.prototype.CastPoint(self)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/last_stroke_cast_e.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControlTransform(self.particleID, 0, self.position, VectorAngles(self.direction))
	self.dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{ origin = self.position, model = "models/development/invisiblebox.vmdl" }
	)
	self.dummy:EmitSound("Hero_Grimstroke.DarkArtistry.PreCastPoint")
	self.timer = GameTimer(0.37, function()
		self:Stroke()
		self.timer = nil
	end)
end
function l.prototype.Stroke(self)
	if self.timer == nil then
		return
	end
	if not (IsValid(self.buff) and IsValid(self.ability) and IsInjurable(self.caster, self.enemy)) then
		self:dispose()
		return
	end
	self.dummy:StopSound("Hero_Grimstroke.DarkArtistry.PreCastPoint")
	self.dummy:EmitSound("Hero_Grimstroke.DarkArtistry.Cast")
	UTIL_Remove(self.dummy)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/last_stroke_cast_light.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControlTransform(self.particleID, 0, self.position, VectorAngles(self.direction))
	local V = CalcDistance(self.projectilePos, self.enemy) + 300
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf",
		hCaster = self.caster,
		vSpawnOrigin = self.projectilePos,
		vDirection = CalcDirection2D(self.enemy, self.projectilePos),
		flDistance = V,
		flRadius = 250,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(W, X, Y)
			if IsValid(self.ability) and IsInjurable(self.caster, self.enemy) then
				self.enemy:EmitSound("Hero_Grimstroke.DarkArtistry.Damage")
				local Z = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_dmg_stroke_tgt.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self.enemy,
					self.caster
				)
				ParticleManager:ReleaseParticleIndex(Z)
				self.caster:DealDamage(self.enemy, self.ability, self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				self:ShardEffect()
			end
		end,
	})
	self.buff:Stroked(self)
end
function l.prototype.ShardEffect(self)
	if self.buffList and IsInjurable(self.caster, self.enemy) then
		g(self.buffList, function(D, _)
			repeat
				local a0 = _.type
				local a1 = a0 == "sect_chaos"
				if a1 then
					AddChaos(self.caster, _.count, "grimstroke_shard", "Ability")
					break
				end
				a1 = a1 or a0 == "sect_fury"
				if a1 then
					AddFury(self.caster, _.count, "grimstroke_shard", "Ability")
					break
				end
				a1 = a1 or a0 == "sect_shield"
				if a1 then
					AddShield(self.caster, _.count, "grimstroke_shard", "Ability")
					break
				end
				a1 = a1 or a0 == "sect_ice"
				if a1 then
					AddIce(self.caster, self.enemy, _.count, "grimstroke_shard", "Ability")
					break
				end
				a1 = a1 or a0 == "sect_injury"
				if a1 then
					AddInjury(self.caster, self.enemy, _.count, "grimstroke_shard", "Ability")
					break
				end
				a1 = a1 or a0 == "sect_poison"
				if a1 then
					AddPoison(self.caster, self.enemy, _.count, "grimstroke_shard", "Ability")
					break
				end
			until true
		end)
	end
end
function l.prototype.dispose(self)
	if self.particleID then
		ParticleManager:DestroyParticle(self.particleID, false)
	end
	if self.timer ~= nil then
		StopTimer(self.timer)
	end
	if IsValid(self.dummy) then
		self.dummy:StopSound("Hero_Grimstroke.DarkArtistry.PreCastPoint")
		UTIL_Remove(self.dummy)
	end
	self.timer = nil
	self.buffList = nil
end
j.grimstroke_talent_5 = c()
local a2 = j.grimstroke_talent_5
a2.name = "grimstroke_talent_5"
d(a2, n)
function a2.prototype.GetIntrinsicModifierName(self)
	return "modifier_grimstroke_talent_5"
end
a2 = e({ o(nil) }, a2)
j.grimstroke_talent_5 = a2
j.modifier_grimstroke_talent_5 = c()
local a3 = j.modifier_grimstroke_talent_5
a3.name = "modifier_grimstroke_talent_5"
d(a3, q)
function a3.prototype.GetTexture(self)
	return "grimstroke_soul_chain"
end
function a3.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function a3.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self.parent } }
end
function a3.prototype.OnEvasion(self, x)
	self:TryAddCounter(x.attacker)
end
function a3.prototype.TryAddCounter(self, F)
	if F == nil then
		F = self.parent:GetEnemy()
	end
	if IsInjurable(F, self.parent) then
		if self.count > 0 and not F:HasModifier("modifier_grimstroke_soulchain") then
			local a4 = self:GetStackCount()
			if a4 + 1 >= self.count then
				self:SoulChain()
				self:SetStackCount(0)
			else
				self:IncrementStackCount()
			end
		end
	end
end
function a3.prototype.SoulChain(self)
	local F = self.parent:GetEnemy()
	if not IsInjurable(F, self.parent) then
		return
	end
	self.parent:EmitSound("Hero_Grimstroke.SoulChain.Cast")
	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_GS_SOUL_CHAIN, 1.5)
	local Z = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/grimstroke_cast_soulchain.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(Z, 1, F, PATTACH_POINT_FOLLOW, "attach_hitloc", F:GetAbsOrigin(), true)
	F:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_grimstroke_soulchain",
		{ duration = BUFF_VALUE.SoulChainDuration }
	)
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_grimstroke_soulchain",
		{ duration = BUFF_VALUE.SoulChainDuration }
	)
end
a3 = e(
	{
		r(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	a3
)
j.modifier_grimstroke_talent_5 = a3
j.modifier_grimstroke_soulchain = c()
local a5 = j.modifier_grimstroke_soulchain
a5.name = "modifier_grimstroke_soulchain"
d(a5, q)
function a5.prototype.IsDebuff(self)
	return self:GetParent() ~= self:GetCaster()
end
function a5.prototype.OnCreated(self, x)
	if IsServer() then
		if self.caster ~= self.parent then
			self.parent:EmitSound("Hero_Grimstroke.SoulChain.Leash")
			self.parent:EmitSound("Hero_Grimstroke.SoulChain.Partner")
		end
	else
		if self.caster ~= self.parent then
			local Z = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_grimstroke/grimstroke_soulchain_debuff.vpcf",
				PATTACH_CUSTOMORIGIN,
				self.parent,
				self.caster
			)
			self:AddParticle(Z, false, false, -1, false, false)
		end
	end
end
function a5.prototype.OnDestroy(self)
	if IsServer() then
		if self.caster ~= self.parent then
			self.parent:StopSound("Hero_Grimstroke.SoulChain.Leash")
		end
	end
end
function a5.prototype.EFunctionValues(self)
	if self.parent ~= self.caster then
		return {
			[EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE] = -BUFF_VALUE.SoulChainDamageReducePct,
			[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = -BUFF_VALUE.SoulChainEvade,
		}
	else
		return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = BUFF_VALUE.SoulChainEvade }
	end
end
a5 = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	a5
)
j.modifier_grimstroke_soulchain = a5
j.grimstroke_talent_6 = c()
local a6 = j.grimstroke_talent_6
a6.name = "grimstroke_talent_6"
d(a6, n)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_grimstroke_talent_6"
end
a6 = e({ o(nil) }, a6)
j.grimstroke_talent_6 = a6
j.modifier_grimstroke_talent_6 = c()
local a7 = j.modifier_grimstroke_talent_6
a7.name = "modifier_grimstroke_talent_6"
d(a7, q)
function a7.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.proc = false
end
function a7.prototype.GetTexture(self)
	return "grimstroke_ink_creature"
end
function a7.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function a7.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self.parent } }
end
function a7.prototype.OnEvasion(self, x)
	self:TryAddCounter(x.attacker)
end
function a7.prototype.TryAddCounter(self, F)
	if F == nil then
		F = self.parent:GetEnemy()
	end
	if IsInjurable(F, self.parent) then
		if not self.proc and not F:HasModifier("modifier_grimstroke_hostileshadow") then
			local a4 = self:GetStackCount()
			if a4 + 1 >= self.count then
				self:HostileShadow()
				self:SetStackCount(0)
			else
				self:IncrementStackCount()
			end
		end
	end
end
function a7.prototype.HostileShadow(self)
	local F = self.parent:GetEnemy()
	if not IsInjurable(F, self.parent) then
		return
	end
	self.parent:StartGestureWithPlaybackRate(ACT_DOTA_GS_INK_CREATURE, 1.5)
	self.proc = true
	local a8 = Wearable:getReplaceUnitModel(self.parent, "models/heroes/grimstroke/ink_phantom.vmdl")
	local a9 = "1"
	if a8 == "models/eom/hero/grimstroke_1/ink_phantom_1.vmdl" then
		a9 = "0.8"
	end
	local aa = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			model = a8,
			scale = a9,
			origin = self.parent:GetAbsOrigin(),
			DefaultAnim = "ACT_DOTA_RUN",
			use_animgraph = "1",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			skin = "dark",
		}
	)
	self.parent:EmitSound("Hero_Grimstroke.InkCreature.Cast")
	aa:EmitSound("Hero_Grimstroke.InkCreature.Spawn")
	Projectile:CreateTrackingProjectile({
		hCaster = self.parent,
		vSpawnOrigin = self.parent:GetAttachmentPosition("attach_hitloc"),
		hTarget = F,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileCreated = function(ab)
			local R = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_grimstroke/custom_grimstroke_phantom_ambient.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				aa,
				self.parent
			)
			ab._iParticleID = R
		end,
		OnProjectileThink = function(ac, ab)
			if IsValid(aa) then
				local G = F:GetAbsOrigin() - ac
				G.z = 0
				aa:SetAbsOrigin(GetGroundPosition(ac, nil) + Vector(0, 0, 96))
				aa:SetForwardVector(G:Normalized())
			end
		end,
		OnProjectileHit = function(W, ac, ab)
			if not (IsValid(self) and IsInjurable(self.parent, F)) then
				return
			end
			AddSilence(self.parent, F, self.ability, BUFF_VALUE.HostileShadowDuration)
			F:AddNewModifier(
				self.parent,
				self.ability,
				"modifier_grimstroke_hostileshadow",
				{ duration = BUFF_VALUE.HostileShadowDuration }
			)
			self.proc = false
		end,
		OnProjectileDestroy = function()
			if IsValid(self) then
				self.proc = false
				if IsValid(aa) then
					UTIL_Remove(aa)
				end
			end
		end,
	})
end
a7 = e(
	{
		r(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	a7
)
j.modifier_grimstroke_talent_6 = a7
j.modifier_grimstroke_hostileshadow = c()
local ad = j.modifier_grimstroke_hostileshadow
ad.name = "modifier_grimstroke_hostileshadow"
d(ad, q)
function ad.prototype.OnCreated(self, x)
	if IsServer() then
		self.parent:EmitSound("Hero_Grimstroke.InkCreature.Damage")
		local ae = self.parent:GetAbsOrigin()
		local G = CalcDirection2D(self.caster, ae)
		local af = VectorAngles(G * -1)
		local a8 = Wearable:getReplaceUnitModel(self.caster, "models/heroes/grimstroke/ink_phantom.vmdl")
		local a9 = "1"
		if a8 == "models/eom/hero/grimstroke_1/ink_phantom_1.vmdl" then
			a9 = "0.8"
		end
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				model = a8,
				scale = a9,
				origin = ae + Vector(G.x * 75, G.y * 75, 96),
				angles = (((tostring(af.x) .. " ") .. tostring(af.y)) .. " ") .. tostring(af.z),
				DefaultAnim = "ACT_DOTA_ATTACK",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		self:StartIntervalThink(BUFF_VALUE.HostileShadowInterval)
	else
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_grimstroke/grimstroke_phantom_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.dummy,
			self.caster
		)
		self:AddParticle(R, false, false, -1, false, false)
	end
end
function ad.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Grimstroke.InkCreature.Death")
		if IsValid(self.dummy) then
			UTIL_Remove(self.dummy)
		end
	end
end
function ad.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsInjurable(self.caster, self.parent) then
			self:Destroy()
			return
		end
		self.caster:DealDamage(
			self.parent,
			self.ability,
			BUFF_VALUE.HostileShadowDamage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			DamageFlags.DAMAGE_FLAG_HPLOSS + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
		)
	end
end
ad = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	ad
)
j.modifier_grimstroke_hostileshadow = ad
j.grimstroke_talent_8 = c()
local ag = j.grimstroke_talent_8
ag.name = "grimstroke_talent_8"
d(ag, n)
function ag.prototype.GetIntrinsicModifierName(self)
	return "modifier_grimstroke_talent_8"
end
ag = e({ o(nil) }, ag)
j.grimstroke_talent_8 = ag
j.modifier_grimstroke_talent_8 = c()
local ah = j.modifier_grimstroke_talent_8
ah.name = "modifier_grimstroke_talent_8"
d(ah, q)
function ah.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = {} }
end
function ah.prototype.OnBattleStartBefore(self, x)
	local F = self.parent:GetEnemy()
	F:AddNewModifier(self.parent, self.ability, "modifier_grimstroke_talent_8_debuff", nil)
end
ah = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	ah
)
j.modifier_grimstroke_talent_8 = ah
j.modifier_grimstroke_talent_8_debuff = c()
local ai = j.modifier_grimstroke_talent_8_debuff
ai.name = "modifier_grimstroke_talent_8_debuff"
d(ai, q)
function ai.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.enable = true
end
function ai.prototype.GetAbilitySpecialValue(self)
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
end
function ai.prototype.OnIntervalThink(self)
	if IsServer() then
		self.enable = true
		self:StartIntervalThink(-1)
	end
end
function ai.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self.parent } }
end
function ai.prototype.OnEvasion(self, x)
	if not self.enable then
		return
	end
	self.enable = false
	self:StartIntervalThink(self.cooldown)
	self.parent:EmitSound("Hero_Grimstroke.InkCreature.Attach")
	local Z = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_grimstroke/grimstroke_soulchain_proc_rope.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		Z,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		Z,
		1,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(Z)
	self.caster:TriggerSectEvadeEffect(x)
	local T = self.caster:FindModifierByName("modifier_grimstroke_talent")
	if IsValid(T) then
		T.evade_record = T.evade_record + 1
	end
	if self.caster:HasModifier("modifier_grimstroke_talent_5") then
		self.caster:FindModifierByName("modifier_grimstroke_talent_5"):TryAddCounter()
	end
	if self.caster:HasModifier("modifier_grimstroke_talent_6") then
		self.caster:FindModifierByName("modifier_grimstroke_talent_6"):TryAddCounter()
	end
end
ai = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	ai
)
j.modifier_grimstroke_talent_8_debuff = ai
return j