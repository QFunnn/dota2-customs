--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_shield"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["19"] = 5,
		["20"] = 9,
		["21"] = 40,
		["22"] = 4,
		["23"] = 43,
		["24"] = 44,
		["25"] = 45,
		["26"] = 46,
		["27"] = 47,
		["28"] = 48,
		["29"] = 49,
		["30"] = 50,
		["31"] = 51,
		["32"] = 52,
		["33"] = 53,
		["34"] = 54,
		["35"] = 56,
		["36"] = 57,
		["37"] = 58,
		["38"] = 59,
		["39"] = 60,
		["40"] = 61,
		["41"] = 62,
		["42"] = 63,
		["43"] = 64,
		["44"] = 65,
		["45"] = 66,
		["46"] = 67,
		["47"] = 68,
		["48"] = 69,
		["49"] = 70,
		["50"] = 71,
		["51"] = 72,
		["52"] = 43,
		["53"] = 75,
		["54"] = 75,
		["55"] = 75,
		["57"] = 76,
		["58"] = 77,
		["62"] = 80,
		["63"] = 81,
		["66"] = 82,
		["67"] = 82,
		["68"] = 82,
		["69"] = 82,
		["70"] = 82,
		["71"] = 82,
		["72"] = 82,
		["76"] = 85,
		["79"] = 86,
		["80"] = 86,
		["81"] = 86,
		["82"] = 86,
		["83"] = 86,
		["84"] = 86,
		["85"] = 86,
		["89"] = 89,
		["92"] = 90,
		["96"] = 93,
		["99"] = 94,
		["100"] = 94,
		["101"] = 94,
		["102"] = 94,
		["103"] = 94,
		["104"] = 94,
		["105"] = 94,
		["109"] = 97,
		["112"] = 98,
		["113"] = 99,
		["114"] = 99,
		["115"] = 99,
		["116"] = 99,
		["117"] = 99,
		["118"] = 99,
		["119"] = 100,
		["120"] = 100,
		["121"] = 100,
		["122"] = 100,
		["123"] = 100,
		["124"] = 101,
		["125"] = 102,
		["126"] = 102,
		["127"] = 102,
		["128"] = 103,
		["129"] = 104,
		["130"] = 104,
		["131"] = 104,
		["132"] = 104,
		["133"] = 104,
		["134"] = 104,
		["135"] = 104,
		["136"] = 104,
		["138"] = 102,
		["139"] = 102,
		["143"] = 109,
		["146"] = 110,
		["150"] = 113,
		["153"] = 114,
		["154"] = 115,
		["155"] = 115,
		["156"] = 115,
		["157"] = 115,
		["158"] = 115,
		["159"] = 115,
		["160"] = 115,
		["161"] = 115,
		["162"] = 115,
		["163"] = 116,
		["164"] = 116,
		["165"] = 116,
		["166"] = 116,
		["167"] = 116,
		["168"] = 116,
		["169"] = 116,
		["170"] = 116,
		["171"] = 116,
		["172"] = 117,
		["173"] = 118,
		["174"] = 119,
		["175"] = 119,
		["176"] = 119,
		["177"] = 119,
		["178"] = 119,
		["179"] = 119,
		["180"] = 119,
		["181"] = 119,
		["182"] = 119,
		["183"] = 120,
		["184"] = 120,
		["185"] = 120,
		["186"] = 120,
		["187"] = 120,
		["188"] = 121,
		["189"] = 121,
		["190"] = 121,
		["191"] = 122,
		["192"] = 123,
		["193"] = 121,
		["194"] = 121,
		["195"] = 125,
		["196"] = 125,
		["197"] = 125,
		["198"] = 125,
		["199"] = 125,
		["200"] = 125,
		["201"] = 125,
		["202"] = 125,
		["203"] = 126,
		["207"] = 129,
		["210"] = 130,
		["211"] = 130,
		["212"] = 130,
		["213"] = 130,
		["214"] = 130,
		["215"] = 130,
		["219"] = 133,
		["222"] = 134,
		["223"] = 135,
		["224"] = 136,
		["225"] = 136,
		["226"] = 136,
		["227"] = 136,
		["228"] = 136,
		["229"] = 136,
		["230"] = 136,
		["231"] = 136,
		["232"] = 136,
		["233"] = 137,
		["234"] = 138,
		["238"] = 141,
		["241"] = 142,
		["242"] = 143,
		["243"] = 144,
		["244"] = 145,
		["245"] = 146,
		["246"] = 147,
		["247"] = 148,
		["248"] = 149,
		["249"] = 149,
		["250"] = 149,
		["251"] = 149,
		["252"] = 149,
		["253"] = 150,
		["254"] = 151,
		["255"] = 152,
		["256"] = 152,
		["257"] = 152,
		["258"] = 152,
		["259"] = 152,
		["260"] = 152,
		["261"] = 152,
		["262"] = 152,
		["269"] = 75,
		["270"] = 159,
		["271"] = 160,
		["272"] = 159,
		["273"] = 5,
		["274"] = 4,
		["275"] = 5,
		["277"] = 5,
		["278"] = 164,
		["279"] = 171,
		["280"] = 164,
		["281"] = 171,
		["283"] = 171,
		["284"] = 177,
		["285"] = 210,
		["286"] = 164,
		["287"] = 213,
		["288"] = 214,
		["289"] = 215,
		["290"] = 216,
		["291"] = 217,
		["292"] = 218,
		["293"] = 219,
		["294"] = 220,
		["295"] = 221,
		["296"] = 222,
		["297"] = 223,
		["298"] = 224,
		["299"] = 225,
		["300"] = 227,
		["301"] = 228,
		["302"] = 229,
		["303"] = 230,
		["304"] = 231,
		["305"] = 232,
		["306"] = 233,
		["307"] = 234,
		["308"] = 235,
		["309"] = 236,
		["310"] = 237,
		["311"] = 238,
		["312"] = 239,
		["313"] = 240,
		["314"] = 241,
		["315"] = 242,
		["316"] = 243,
		["317"] = 244,
		["318"] = 245,
		["319"] = 246,
		["320"] = 247,
		["321"] = 248,
		["323"] = 213,
		["324"] = 251,
		["325"] = 252,
		["326"] = 254,
		["327"] = 255,
		["329"] = 251,
		["330"] = 258,
		["331"] = 259,
		["332"] = 259,
		["333"] = 259,
		["334"] = 262,
		["335"] = 262,
		["336"] = 262,
		["337"] = 259,
		["338"] = 259,
		["339"] = 264,
		["340"] = 264,
		["341"] = 264,
		["342"] = 259,
		["343"] = 259,
		["344"] = 258,
		["345"] = 278,
		["346"] = 279,
		["347"] = 278,
		["348"] = 281,
		["349"] = 282,
		["350"] = 283,
		["352"] = 286,
		["353"] = 287,
		["355"] = 292,
		["356"] = 294,
		["357"] = 295,
		["358"] = 296,
		["359"] = 297,
		["360"] = 297,
		["361"] = 297,
		["362"] = 297,
		["363"] = 297,
		["364"] = 297,
		["365"] = 298,
		["366"] = 299,
		["368"] = 281,
		["369"] = 302,
		["370"] = 303,
		["371"] = 302,
		["372"] = 309,
		["373"] = 310,
		["374"] = 311,
		["375"] = 312,
		["376"] = 313,
		["377"] = 315,
		["378"] = 315,
		["379"] = 315,
		["380"] = 315,
		["381"] = 315,
		["382"] = 315,
		["383"] = 348,
		["384"] = 349,
		["385"] = 349,
		["386"] = 349,
		["387"] = 349,
		["388"] = 349,
		["389"] = 349,
		["391"] = 353,
		["392"] = 354,
		["393"] = 354,
		["394"] = 354,
		["395"] = 354,
		["396"] = 354,
		["397"] = 354,
		["398"] = 355,
		["399"] = 357,
		["400"] = 357,
		["401"] = 357,
		["402"] = 357,
		["403"] = 357,
		["404"] = 357,
		["407"] = 364,
		["408"] = 365,
		["409"] = 365,
		["410"] = 365,
		["411"] = 365,
		["412"] = 365,
		["413"] = 365,
		["415"] = 368,
		["416"] = 369,
		["417"] = 369,
		["418"] = 369,
		["419"] = 369,
		["420"] = 369,
		["421"] = 369,
		["423"] = 309,
		["424"] = 373,
		["425"] = 374,
		["426"] = 375,
		["427"] = 376,
		["428"] = 378,
		["429"] = 379,
		["432"] = 373,
		["433"] = 383,
		["434"] = 384,
		["435"] = 385,
		["436"] = 386,
		["437"] = 387,
		["440"] = 383,
		["441"] = 391,
		["442"] = 392,
		["443"] = 393,
		["444"] = 394,
		["446"] = 391,
		["447"] = 397,
		["448"] = 398,
		["449"] = 399,
		["450"] = 401,
		["451"] = 402,
		["453"] = 406,
		["454"] = 407,
		["456"] = 411,
		["457"] = 413,
		["459"] = 418,
		["460"] = 419,
		["462"] = 424,
		["463"] = 425,
		["465"] = 430,
		["466"] = 431,
		["468"] = 434,
		["469"] = 435,
		["470"] = 436,
		["471"] = 437,
		["472"] = 438,
		["475"] = 443,
		["477"] = 397,
		["478"] = 446,
		["479"] = 447,
		["480"] = 448,
		["482"] = 446,
		["483"] = 452,
		["484"] = 453,
		["487"] = 456,
		["490"] = 460,
		["491"] = 462,
		["492"] = 463,
		["494"] = 463,
		["498"] = 452,
		["499"] = 467,
		["500"] = 468,
		["501"] = 469,
		["502"] = 469,
		["503"] = 469,
		["504"] = 469,
		["505"] = 469,
		["506"] = 469,
		["507"] = 469,
		["508"] = 469,
		["509"] = 469,
		["510"] = 469,
		["511"] = 467,
		["512"] = 171,
		["513"] = 164,
		["514"] = 164,
		["515"] = 164,
		["516"] = 164,
		["517"] = 164,
		["518"] = 164,
		["519"] = 164,
		["520"] = 171,
		["522"] = 171,
		["523"] = 473,
		["524"] = 480,
		["525"] = 473,
		["526"] = 480,
		["527"] = 482,
		["528"] = 483,
		["529"] = 482,
		["530"] = 485,
		["531"] = 486,
		["532"] = 485,
		["533"] = 490,
		["534"] = 491,
		["535"] = 490,
		["536"] = 480,
		["537"] = 473,
		["538"] = 473,
		["539"] = 473,
		["540"] = 473,
		["541"] = 473,
		["542"] = 473,
		["543"] = 473,
		["544"] = 480,
		["546"] = 480,
		["547"] = 495,
		["548"] = 502,
		["549"] = 495,
		["550"] = 502,
		["551"] = 504,
		["552"] = 505,
		["553"] = 504,
		["554"] = 507,
		["555"] = 508,
		["556"] = 509,
		["557"] = 509,
		["558"] = 509,
		["559"] = 509,
		["560"] = 509,
		["561"] = 510,
		["562"] = 510,
		["563"] = 510,
		["564"] = 510,
		["565"] = 510,
		["566"] = 511,
		["567"] = 511,
		["568"] = 511,
		["569"] = 511,
		["570"] = 511,
		["571"] = 511,
		["572"] = 511,
		["573"] = 511,
		["575"] = 507,
		["576"] = 514,
		["577"] = 515,
		["578"] = 514,
		["579"] = 519,
		["580"] = 520,
		["581"] = 519,
		["582"] = 502,
		["583"] = 495,
		["584"] = 495,
		["585"] = 495,
		["586"] = 495,
		["587"] = 495,
		["588"] = 495,
		["589"] = 495,
		["590"] = 502,
		["592"] = 502,
		["593"] = 524,
		["594"] = 531,
		["595"] = 524,
		["596"] = 531,
		["597"] = 534,
		["598"] = 535,
		["599"] = 536,
		["600"] = 534,
		["601"] = 538,
		["602"] = 539,
		["603"] = 538,
		["604"] = 544,
		["605"] = 545,
		["606"] = 544,
		["607"] = 547,
		["608"] = 548,
		["609"] = 547,
		["610"] = 531,
		["611"] = 524,
		["612"] = 524,
		["613"] = 524,
		["614"] = 524,
		["615"] = 524,
		["616"] = 524,
		["617"] = 524,
		["618"] = 531,
		["620"] = 531,
		["621"] = 552,
		["622"] = 559,
		["623"] = 552,
		["624"] = 559,
		["625"] = 562,
		["626"] = 563,
		["627"] = 562,
		["628"] = 565,
		["629"] = 566,
		["630"] = 567,
		["631"] = 568,
		["632"] = 568,
		["633"] = 568,
		["634"] = 568,
		["635"] = 569,
		["636"] = 570,
		["637"] = 571,
		["638"] = 572,
		["639"] = 573,
		["640"] = 574,
		["642"] = 576,
		["643"] = 577,
		["646"] = 580,
		["647"] = 581,
		["648"] = 581,
		["649"] = 581,
		["650"] = 581,
		["651"] = 581,
		["652"] = 581,
		["654"] = 584,
		["655"] = 584,
		["656"] = 584,
		["657"] = 584,
		["658"] = 584,
		["659"] = 584,
		["660"] = 584,
		["661"] = 584,
		["662"] = 586,
		["663"] = 587,
		["664"] = 589,
		["665"] = 589,
		["666"] = 589,
		["667"] = 589,
		["668"] = 589,
		["669"] = 589,
		["670"] = 589,
		["671"] = 589,
		["673"] = 593,
		["674"] = 593,
		["675"] = 593,
		["676"] = 593,
		["677"] = 593,
		["678"] = 594,
		["679"] = 594,
		["680"] = 594,
		["681"] = 594,
		["682"] = 594,
		["683"] = 594,
		["684"] = 594,
		["685"] = 594,
		["686"] = 594,
		["687"] = 595,
		["688"] = 595,
		["689"] = 595,
		["690"] = 595,
		["691"] = 595,
		["692"] = 595,
		["693"] = 595,
		["694"] = 595,
		["696"] = 565,
		["697"] = 598,
		["698"] = 599,
		["699"] = 600,
		["701"] = 598,
		["702"] = 559,
		["703"] = 552,
		["704"] = 552,
		["705"] = 552,
		["706"] = 552,
		["707"] = 552,
		["708"] = 552,
		["709"] = 552,
		["710"] = 559,
		["712"] = 559,
		["713"] = 606,
		["714"] = 613,
		["715"] = 606,
		["716"] = 613,
		["718"] = 613,
		["719"] = 617,
		["720"] = 606,
		["721"] = 618,
		["722"] = 619,
		["723"] = 620,
		["724"] = 621,
		["725"] = 618,
		["726"] = 623,
		["727"] = 624,
		["728"] = 625,
		["729"] = 626,
		["731"] = 628,
		["732"] = 629,
		["733"] = 629,
		["734"] = 629,
		["735"] = 629,
		["736"] = 629,
		["737"] = 629,
		["738"] = 629,
		["739"] = 629,
		["740"] = 629,
		["741"] = 630,
		["742"] = 630,
		["743"] = 630,
		["744"] = 630,
		["745"] = 630,
		["746"] = 631,
		["747"] = 631,
		["748"] = 631,
		["749"] = 631,
		["750"] = 631,
		["751"] = 631,
		["752"] = 631,
		["753"] = 631,
		["755"] = 623,
		["756"] = 634,
		["757"] = 635,
		["758"] = 636,
		["759"] = 637,
		["760"] = 638,
		["761"] = 638,
		["762"] = 638,
		["763"] = 638,
		["764"] = 639,
		["765"] = 639,
		["766"] = 639,
		["767"] = 639,
		["768"] = 640,
		["769"] = 640,
		["770"] = 640,
		["771"] = 640,
		["772"] = 641,
		["773"] = 642,
		["774"] = 642,
		["775"] = 642,
		["776"] = 642,
		["777"] = 642,
		["778"] = 642,
		["779"] = 642,
		["780"] = 642,
		["781"] = 642,
		["782"] = 643,
		["783"] = 644,
		["784"] = 644,
		["785"] = 644,
		["786"] = 644,
		["787"] = 644,
		["788"] = 644,
		["789"] = 644,
		["790"] = 644,
		["792"] = 634,
		["793"] = 647,
		["794"] = 648,
		["795"] = 649,
		["796"] = 649,
		["797"] = 648,
		["798"] = 647,
		["799"] = 652,
		["800"] = 653,
		["801"] = 654,
		["802"] = 655,
		["803"] = 656,
		["805"] = 652,
		["806"] = 659,
		["807"] = 660,
		["808"] = 659,
		["809"] = 613,
		["810"] = 606,
		["811"] = 606,
		["812"] = 606,
		["813"] = 606,
		["814"] = 606,
		["815"] = 606,
		["816"] = 606,
		["817"] = 613,
		["819"] = 613,
		["820"] = 669,
		["821"] = 676,
		["822"] = 669,
		["823"] = 676,
		["824"] = 679,
		["825"] = 680,
		["826"] = 681,
		["827"] = 679,
		["828"] = 683,
		["829"] = 684,
		["830"] = 685,
		["831"] = 686,
		["833"] = 683,
		["834"] = 689,
		["835"] = 690,
		["836"] = 691,
		["837"] = 692,
		["838"] = 693,
		["840"] = 689,
		["841"] = 696,
		["842"] = 697,
		["843"] = 696,
		["844"] = 701,
		["845"] = 702,
		["846"] = 701,
		["847"] = 676,
		["848"] = 669,
		["849"] = 669,
		["850"] = 669,
		["851"] = 669,
		["852"] = 669,
		["853"] = 669,
		["854"] = 669,
		["855"] = 676,
		["857"] = 676,
		["858"] = 707,
		["859"] = 714,
		["860"] = 707,
		["861"] = 714,
		["863"] = 714,
		["864"] = 719,
		["865"] = 707,
		["866"] = 720,
		["867"] = 721,
		["868"] = 722,
		["869"] = 723,
		["870"] = 724,
		["871"] = 720,
		["872"] = 726,
		["873"] = 727,
		["874"] = 728,
		["876"] = 726,
		["877"] = 731,
		["878"] = 732,
		["879"] = 733,
		["880"] = 734,
		["883"] = 737,
		["884"] = 745,
		["885"] = 731,
		["886"] = 748,
		["887"] = 749,
		["888"] = 748,
		["889"] = 753,
		["890"] = 754,
		["891"] = 753,
		["892"] = 714,
		["893"] = 707,
		["894"] = 707,
		["895"] = 707,
		["896"] = 707,
		["897"] = 707,
		["898"] = 707,
		["899"] = 707,
		["900"] = 714,
		["902"] = 714,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_shield = c()
local n = g.sect_shield
n.name = "sect_shield"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.r_157_record = 0
	self.flag = true
end
function n.prototype.GetAbilitySpecialValue(self)
	self.shield_count_bonus = self:GetSpecialValueFor("shield_count_bonus")
	self.n_83_poison_count = self:GetSectSpecialValueFor("83", "n_83_poison_count")
	self.n_93_ice_count = self:GetSectSpecialValueFor("93", "n_93_ice_count")
	self.n_93_chance = self:GetSectSpecialValueFor("93", "n_93_chance")
	self.n_101_shield = self:GetSectSpecialValueFor("101", "n_101_shield")
	self.n_101_interval = self:GetSectSpecialValueFor("101", "n_101_interval")
	self.n_102_chance = self:GetSectSpecialValueFor("102", "n_102_chance")
	self.n_102_injury_count = self:GetSectSpecialValueFor("102", "n_102_injury_count")
	self.n_103_chance = self:GetSectSpecialValueFor("103", "n_103_chance")
	self.r_105_shield = self:GetSectSpecialValueFor("105", "r_105_shield")
	self.r_106_incoming_damage_reduce = self:GetSectSpecialValueFor("106", "r_106_incoming_damage_reduce")
	self.r_106_effect_1 = self:GetSectSpecialValueFor("106", "effect_1")
	self.r_107_chance = self:GetSectSpecialValueFor("107", "r_107_chance")
	self.r_107_damage = self:GetSectSpecialValueFor("107", "r_107_damage")
	self.sr_108_duration = self:GetSectSpecialValueFor("108", "sr_108_duration")
	self.sr_108_base_shield = self:GetSectSpecialValueFor("108", "sr_108_base_shield")
	self.n_131_chance = self:GetSectSpecialValueFor("131", "n_131_chance")
	self.n_131_fury = self:GetSectSpecialValueFor("131", "n_131_fury")
	self.r_157_shield = self:GetSectSpecialValueFor("157", "r_157_shield")
	self.r_157_damage = self:GetSectSpecialValueFor("157", "r_157_damage")
	self.n_173_chance = self:GetSectSpecialValueFor("173", "n_173_chance")
	self.n_173_chaos_count = self:GetSectSpecialValueFor("173", "n_173_chaos_count")
	self.r_185_threshold = self:GetSectSpecialValueFor("185", "r_185_threshold")
	self.r_185_shield = self:GetSectSpecialValueFor("185", "r_185_shield")
	self.n_186_convert = self:GetSectSpecialValueFor("186", "n_186_convert")
	self.sr_193_damage = self:GetSectSpecialValueFor("193", "sr_193_damage")
	self.sr_193_basedamage = self:GetSectSpecialValueFor("193", "sr_193_basedamage")
	self.sr_193_add_shiled_pct = self:GetSectSpecialValueFor("193", "sr_193_add_shiled_pct")
end
function n.prototype.TriggerByName(self, o, p)
	if p == nil then
		p = self:GetCaster()
	end
	local q = self:GetCaster()
	if not IsInjurable(q, p) then
		return
	end
	repeat
		local r = o
		local s = r == "83"
		if s then
			do
				AddPoison(q, p, self.n_83_poison_count, "83", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "93"
		if s then
			do
				AddIce(q, p, self.n_93_ice_count, "93", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "101"
		if s then
			do
				AddShield(q, self.n_101_shield, "101", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "102"
		if s then
			do
				AddInjury(q, p, self.n_102_injury_count, "102", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "107"
		if s then
			do
				local t = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_mars/mars_shield_bash.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlTransformForward(
					t,
					0,
					q:GetAbsOrigin(),
					(p:GetAbsOrigin() - q:GetAbsOrigin()):Normalized()
				)
				ParticleManager:SetParticleControl(t, 1, Vector(500, 500, 500))
				q:EmitSound("Hero_Mars.Shield.Cast")
				q:GameTimer(0.25, function()
					if IsValid(self) and IsInjurable(p) then
						q:DealDamage(p, self, self.r_107_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, nil, "107")
					end
				end)
				break
			end
		end
		s = s or r == "131"
		if s then
			do
				AddFury(q, self.n_131_fury, "131", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "157"
		if s then
			do
				local u = ParticleManager:CreateParticle(
					"particles/econ/items/dark_seer/dark_seer_ti8_immortal_arms/dark_seer_ti8_immortal_ion_shell_dmg_golden.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					u,
					0,
					q,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					q:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControlEnt(
					u,
					0,
					p,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					p:GetAbsOrigin(),
					false
				)
				ParticleManager:ReleaseParticleIndex(u)
				local v = ParticleManager:CreateParticle(
					"particles/econ/items/dark_seer/dark_seer_ti8_immortal_arms/dark_seer_ti8_immortal_ion_shell_golden.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					v,
					0,
					q,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					q:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControl(v, 1, Vector(60, 1, 1))
				GameTimer(0.1, function()
					ParticleManager:DestroyParticle(v, false)
					ParticleManager:ReleaseParticleIndex(v)
				end)
				q:DealDamage(p, self, self.r_157_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "157")
				q:EmitSound("Hero_Dark_Seer.Ion_Shield_Start")
				break
			end
		end
		s = s or r == "173"
		if s then
			do
				AddChaos(q, GetSectChaosModifiedValue(q, self.n_173_chaos_count), "173", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "185"
		if s then
			do
				q:EmitSound("Hero_Tidehunter.KrakenShell")
				local w = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					q
				)
				ParticleManager:SetParticleControlEnt(w, 3, q, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
				ParticleManager:ReleaseParticleIndex(w)
				AddShield(q, self.r_185_shield, "185", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "193"
		if s then
			do
				local x = q:FindModifierByName("modifier_sect_shield_193")
				if IsValid(x) then
					local y = x.shiledRecord
					local z = self.sr_193_basedamage + y * self.sr_193_damage * 0.01
					if z > 0 then
						AddShield(q, y * self.sr_193_add_shiled_pct * 0.01, "mechanics_193", "Ability")
						local w = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_techies/techies_tazer_explode.vpcf",
							PATTACH_ABSORIGIN_FOLLOW,
							q
						)
						ParticleManager:SetParticleControl(w, 1, Vector(300, 0, 0))
						ParticleManager:ReleaseParticleIndex(w)
						q:EmitSound("Hero_Techies.ReactiveTazer.Detonate")
						q:DealDamage(p, self, z, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "193")
					end
				end
				break
			end
		end
	until true
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_shield"
end
n = e({ j(nil) }, n)
g.sect_shield = n
g.modifier_sect_shield = c()
local A = g.modifier_sect_shield
A.name = "modifier_sect_shield"
d(A, l)
function A.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.r_157_record = 0
	self.flag = true
end
function A.prototype.GetAbilitySpecialValue(self)
	self.shield_count_bonus = self:GetAbilitySpecialValueFor("shield_count_bonus")
	self.n_83_poison_count = self:GetSectSpecialValueFor("83", "n_83_poison_count")
	self.n_83_chance = self:GetSectSpecialValueFor("83", "n_83_chance")
	self.n_93_ice_count = self:GetSectSpecialValueFor("93", "n_93_ice_count")
	self.n_93_chance = self:GetSectSpecialValueFor("93", "n_93_chance")
	self.n_101_shield = self:GetSectSpecialValueFor("101", "n_101_shield")
	self.n_101_interval = self:GetSectSpecialValueFor("101", "n_101_interval")
	self.n_102_chance = self:GetSectSpecialValueFor("102", "n_102_chance")
	self.n_102_injury_count = self:GetSectSpecialValueFor("102", "n_102_injury_count")
	self.n_103_chance = self:GetSectSpecialValueFor("103", "n_103_chance")
	self.r_105_shield = self:GetSectSpecialValueFor("105", "r_105_shield")
	self.r_106_incoming_damage_reduce = self:GetSectSpecialValueFor("106", "r_106_incoming_damage_reduce")
	self.r_106_effect_1 = self:GetSectSpecialValueFor("106", "effect_1")
	self.r_107_chance = self:GetSectSpecialValueFor("107", "r_107_chance")
	self.r_107_damage = self:GetSectSpecialValueFor("107", "r_107_damage")
	self.sr_108_duration = self:GetSectSpecialValueFor("108", "sr_108_duration")
	self.sr_108_base_shield = self:GetSectSpecialValueFor("108", "sr_108_base_shield")
	self.n_131_chance = self:GetSectSpecialValueFor("131", "n_131_chance")
	self.n_131_fury = self:GetSectSpecialValueFor("131", "n_131_fury")
	self.sr_147_shield_loss = self:GetSectSpecialValueFor("147", "sr_147_shield_loss")
	self.sr_147_duration = self:GetSectSpecialValueFor("147", "sr_147_duration")
	self.r_157_shield = self:GetSectSpecialValueFor("157", "r_157_shield")
	self.r_157_damage = self:GetSectSpecialValueFor("157", "r_157_damage")
	self.n_173_chance = self:GetSectSpecialValueFor("173", "n_173_chance")
	self.n_173_chaos_count = self:GetSectSpecialValueFor("173", "n_173_chaos_count")
	self.r_185_threshold = self:GetSectSpecialValueFor("185", "r_185_threshold")
	self.r_185_shield = self:GetSectSpecialValueFor("185", "r_185_shield")
	self.n_186_convert = self:GetSectSpecialValueFor("186", "n_186_convert")
	self.sr_193_damage = self:GetSectSpecialValueFor("193", "sr_193_damage")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_shield_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_shield_effect", "value")
	self.ability:GetAbilitySpecialValue()
	if IsServer() then
		self.r_185_record = 0
	end
end
function A.prototype.OnIntervalThink(self)
	local B = self:GetParent()
	if self.n_101_shield > 0 then
		self.ability:TriggerByName("101")
	end
end
function A.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function A.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function A.prototype.EOM_GetModifierAvoidDamage(self, C)
	if not self.flag then
		return 0
	end
	if bit.band(C.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	local q = self:GetParent()
	if C.damage >= q:GetHealth() and self.sr_108_duration > 0 then
		q:SetHealth(1)
		CombatLog:recordSectAbilityCast(q, "108")
		q:AddNewModifier(q, self:GetAbility(), "modifier_sect_shield_108_buff", { duration = self.sr_108_duration })
		self.flag = false
		return 1
	end
end
function A.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS] = self.shield_count_bonus,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE] = self.n_186_convert,
	}
end
function A.prototype.OnBattleStartBefore(self, C)
	local q = self:GetParent()
	self.hEnemy = q:GetEnemy()
	self.r_157_record = 0
	self.flag = true
	q:AddNewModifier(q, self:GetAbility(), "modifier_shield_permanent", {})
	if self.n_103_chance > 0 and IsValid(self.hEnemy) then
		self.hEnemy:AddNewModifier(q, self:GetAbility(), "modifier_sect_shield_103_debuff", {})
	end
	if self.r_106_incoming_damage_reduce > 0 then
		q:AddNewModifier(q, self:GetAbility(), "modifier_sect_shield_106_buff", nil)
		if self.r_106_effect_1 > 0 then
			q:AddNewModifier(
				q,
				self:GetAbility(),
				"modifier_sect_shield_106_buff_plus",
				{ duration = self.r_106_effect_1 }
			)
		end
	end
	if self.sr_147_shield_loss > 0 then
		q:AddNewModifier(q, self:GetAbility(), "modifier_sect_shield_147", nil)
	end
	if self.sr_193_damage > 0 then
		q:AddNewModifier(q, self:GetAbility(), "modifier_sect_shield_193", nil)
	end
end
function A.prototype.OnBattleStart(self, C)
	if IsServer() then
		local q = self:GetParent()
		self.hEnemy = q:GetEnemy()
		if self.n_101_interval > 0 then
			self:StartIntervalThink(self.n_101_interval)
		end
	end
end
function A.prototype.OnThink(self, D)
	local q = self:GetParent()
	local p = q:GetEnemy()
	if not IsInjurable(q, p) then
		self:StartThink(-1, D)
		return
	end
end
function A.prototype.OnBattleEnd(self, C)
	if IsServer() then
		self.hEnemy = nil
		self:StartIntervalThink(-1)
	end
end
function A.prototype.OnShieldGained(self, C)
	if IsValid(self.hEnemy) then
		local q = self:GetParent()
		if self.n_83_chance > 0 and self:PRD(self.n_83_chance, "n_83_chance") then
			self.ability:TriggerByName("83", self.hEnemy)
		end
		if self.n_93_chance > 0 and self:PRD(self.n_93_chance, "n_93_chance") then
			self.ability:TriggerByName("93", self.hEnemy)
		end
		if self.n_102_chance > 0 and self:PRD(self.n_102_chance, "n_102_chance") then
			self.ability:TriggerByName("102", self.hEnemy)
		end
		if self.n_131_chance > 0 and self:PRD(self.n_131_chance, "n_131_chance") then
			self.ability:TriggerByName("131")
		end
		if self.n_173_chance > 0 and self:PRD(self.n_173_chance, "n_173_chance") then
			self.ability:TriggerByName("173")
		end
		if self.r_107_chance > 0 and IsValid(self.hEnemy) and self:PRD(self.r_107_chance, "r_107_chance") then
			self.ability:TriggerByName("107", self.hEnemy)
		end
		if self.r_157_shield > 0 then
			self.r_157_record = self.r_157_record + C.iStackCount
			if self.r_157_record >= self.r_157_shield then
				self.r_157_record = self.r_157_record - self.r_157_shield
				self.ability:TriggerByName("157", self.hEnemy)
			end
		end
		self:customAbilityTrigger()
	end
end
function A.prototype.OnCustomTakeDamage(self, E)
	if self.r_185_threshold > 0 and E.damage >= self.r_185_threshold then
		self.ability:TriggerByName("185")
	end
end
function A.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_shield" then
		return
	end
	if self.trigger_chance > 0 then
		if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chances") then
			local F = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if F ~= nil then
				F:customAbilityEffect()
			end
		end
	end
end
function A.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local G = AddShield
	local H = self:GetParent()
	local I = self.effect_value
	local J = self:GetAbility()
	G(H, I, J and J:GetAbilityName() or "", "Sect")
end
A = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	A
)
g.modifier_sect_shield = A
g.modifier_sect_shield_103_debuff = c()
local K = g.modifier_sect_shield_103_debuff
K.name = "modifier_sect_shield_103_debuff"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.n_103_chance = self:GetSectSpecialValueFor("103", "n_103_chance")
end
function K.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_SHIELD_PERCENTAGE }
end
function K.prototype.EOM_GetModifierIgnoreShieldPercent(self)
	return self.n_103_chance
end
K = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	K
)
g.modifier_sect_shield_103_debuff = K
g.modifier_sect_shield_106_buff = c()
local L = g.modifier_sect_shield_106_buff
L.name = "modifier_sect_shield_106_buff"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.r_106_incoming_damage_reduce = self:GetSectSpecialValueFor("106", "r_106_incoming_damage_reduce")
end
function L.prototype.OnCreated(self, C)
	if IsClient() then
		local v = ParticleManager:CreateParticle(
			"particles/items3_fx/star_emblem_friend.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(v, 1, self:GetParent():GetAbsOrigin())
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function L.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function L.prototype.EOM_GetModifierShieldPermanent(self, C)
	return self.r_106_incoming_damage_reduce
end
L = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	L
)
g.modifier_sect_shield_106_buff = L
g.modifier_sect_shield_106_buff_plus = c()
local M = g.modifier_sect_shield_106_buff_plus
M.name = "modifier_sect_shield_106_buff_plus"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.r_106_incoming_damage_reduce = self:GetSectSpecialValueFor("106", "r_106_incoming_damage_reduce")
	self.r_106_effect_2 = self:GetSectSpecialValueFor("106", "effect_2")
end
function M.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_ATTENUATION_PERCENTAGE,
	}
end
function M.prototype.EOM_GetModifierShieldPermanent(self, C)
	return self.r_106_incoming_damage_reduce * self.r_106_effect_2 * 0.01
end
function M.prototype.EOM_GetModifierShieldAttenuationPercent(self)
	return -999
end
M = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	M
)
g.modifier_sect_shield_106_buff_plus = M
g.modifier_sect_shield_108_buff = c()
local N = g.modifier_sect_shield_108_buff
N.name = "modifier_sect_shield_108_buff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.sr_108_base_shield = self:GetSectSpecialValueFor("108", "sr_108_base_shield")
end
function N.prototype.OnCreated(self, C)
	if IsServer() then
		local q = self:GetParent()
		AddStrongShield(q, self:GetDuration())
		local O = q:FindModifierByName("modifier_injury_custom")
		if IsValid(O) then
			local P = O:GetStackCount()
			if P <= self.sr_108_base_shield then
				self.sr_108_base_shield = self.sr_108_base_shield - P
				O:Destroy()
			else
				O:DecrementStackCount(self.sr_108_base_shield)
				self.sr_108_base_shield = 0
			end
		end
		if self.sr_108_base_shield > 0 then
			q:AddNewModifier(q, self:GetAbility(), "modifier_shield_custom", { iStackCount = self.sr_108_base_shield })
		end
		PlayerData:addDetailData(self:GetParent(), "AbilityUpgrade", "shield", self.sr_108_base_shield, false, "108")
		q:EmitSound("Hero_Omniknight.GuardianAngel.Cast")
		q:EmitSound("Hero_Omniknight.GuardianAngel")
		CombatLog:recordBuff(q, q, "shield", self.sr_108_base_shield, "108", "AbilityUpgrade")
	else
		local Q = ParticleManager:CreateParticle(
			"particles/econ/items/omniknight/omni_2021_immortal/omni_2021_immortal.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			Q,
			0,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			true
		)
		self:AddParticle(Q, true, false, -1, false, false)
	end
end
function N.prototype.OnDestroy(self)
	if IsServer() and IsInjurable(self:GetParent()) then
		self:GetParent():StopSound("Hero_Omniknight.GuardianAngel")
	end
end
N = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	N
)
g.modifier_sect_shield_108_buff = N
g.modifier_sect_shield_147 = c()
local R = g.modifier_sect_shield_147
R.name = "modifier_sect_shield_147"
d(R, l)
function R.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.shiledRecord = 0
end
function R.prototype.GetAbilitySpecialValue(self)
	self.sr_147_reduce = self:GetSectSpecialValueFor("147", "sr_147_reduce")
	self.sr_147_purge_pct = self:GetSectSpecialValueFor("147", "sr_147_purge_pct")
	self.sr_147_shield_loss = self:GetSectSpecialValueFor("147", "sr_147_shield_loss")
end
function R.prototype.OnCreated(self, C)
	local q = self:GetParent()
	if IsServer() then
		q:EmitSound("Hero_Abaddon.AphoticShield.Cast")
	else
		local v = ParticleManager:CreateParticle(
			"particles/econ/items/abaddon/abaddon_feathers_mace/abaddon_aphotic_shield_mace.vpcf",
			PATTACH_CUSTOMORIGIN,
			q
		)
		ParticleManager:SetParticleControlEnt(v, 0, q, PATTACH_POINT_FOLLOW, "attach_hitloc", q:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(v, 1, Vector(120, 0, 0))
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function R.prototype.Borken(self)
	local q = self:GetParent()
	local p = q:GetEnemy()
	q:EmitSound("Hero_Abaddon.AphoticShield.Destroy")
	ReduceIce(q, GetIce(q) * self.sr_147_purge_pct * 0.01)
	ReducePoison(q, GetPoison(q) * self.sr_147_purge_pct * 0.01)
	ReduceInjury(q, GetInjury(q) * self.sr_147_purge_pct * 0.01)
	local v = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf",
		PATTACH_CUSTOMORIGIN,
		q
	)
	ParticleManager:SetParticleControlEnt(v, 0, q, PATTACH_POINT_FOLLOW, "attach_hitloc", q:GetAbsOrigin(), false)
	if IsInjurable(q, p) then
		q:DealDamage(
			p,
			self:GetAbility(),
			self.sr_147_shield_loss,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			DamageFlags.DAMAGE_FLAG_HPLOSS,
			"147"
		)
	end
end
function R.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS] = { self:GetParent(), -1 } }
end
function R.prototype.OnShieldLoss(self, C)
	self.shiledRecord = self.shiledRecord + C.iCount
	if self.shiledRecord >= self.sr_147_shield_loss then
		self:Borken()
		self.shiledRecord = self.shiledRecord - self.sr_147_shield_loss
	end
end
function R.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS_PERCENTAGE] = -self.sr_147_reduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS_PERCENTAGE] = -self.sr_147_reduce,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE] = -self.sr_147_reduce,
	}
end
R = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	R
)
g.modifier_sect_shield_147 = R
g.modifier_sect_shield_105_buff = c()
local S = g.modifier_sect_shield_105_buff
S.name = "modifier_sect_shield_105_buff"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.r_105_shield = self:GetSectSpecialValueFor("105", "r_105_shield")
	self.r_105_reduce = self:GetSectSpecialValueFor("105", "r_105_reduce")
end
function S.prototype.OnCreated(self, C)
	if IsServer() then
		self:SetStackCount(self.r_105_shield)
		self:StartIntervalThink(1)
	end
end
function S.prototype.OnIntervalThink(self)
	local T = math.ceil(self:GetStackCount() * self.r_105_reduce) + SHIELD_ATTENUATION.Const
	self:DecrementStackCount(T)
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function S.prototype.EOM_GetModifierShieldPermanent(self)
	return self:GetStackCount()
end
S = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	S
)
g.modifier_sect_shield_105_buff = S
g.modifier_sect_shield_193 = c()
local U = g.modifier_sect_shield_193
U.name = "modifier_sect_shield_193"
d(U, l)
function U.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.shiledRecord = 0
end
function U.prototype.GetAbilitySpecialValue(self)
	self.sr_193_damage = self:GetSectSpecialValueFor("193", "sr_193_damage")
	self.sr_193_tick = self:GetSectSpecialValueFor("193", "sr_193_tick")
	self.sr_193_basedamage = self:GetSectSpecialValueFor("193", "sr_193_basedamage")
	self.sr_193_add_shiled_pct = self:GetSectSpecialValueFor("193", "sr_193_add_shiled_pct")
end
function U.prototype.OnCreated(self, C)
	if IsServer() then
		self:StartIntervalThink(self.sr_193_tick)
	end
end
function U.prototype.OnIntervalThink(self)
	local p = self.parent:GetEnemy()
	if not IsInjurable(p, self.parent) then
		self:Destroy()
		return
	end
	self.ability:TriggerByName("193", p)
	self.shiledRecord = 0
end
function U.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS] = { self.parent } }
end
function U.prototype.OnShieldLoss(self, C)
	self.shiledRecord = self.shiledRecord + C.iCount
end
U = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	U
)
g.modifier_sect_shield_193 = U
return g