--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["532"] = 487,
		["533"] = 487,
		["534"] = 486,
		["535"] = 485,
		["536"] = 490,
		["537"] = 491,
		["538"] = 490,
		["539"] = 493,
		["540"] = 494,
		["541"] = 493,
		["542"] = 498,
		["543"] = 499,
		["544"] = 498,
		["545"] = 480,
		["546"] = 473,
		["547"] = 473,
		["548"] = 473,
		["549"] = 473,
		["550"] = 473,
		["551"] = 473,
		["552"] = 473,
		["553"] = 480,
		["555"] = 480,
		["556"] = 503,
		["557"] = 510,
		["558"] = 503,
		["559"] = 510,
		["560"] = 512,
		["561"] = 513,
		["562"] = 512,
		["563"] = 515,
		["564"] = 516,
		["565"] = 517,
		["566"] = 517,
		["567"] = 517,
		["568"] = 517,
		["569"] = 517,
		["570"] = 518,
		["571"] = 518,
		["572"] = 518,
		["573"] = 518,
		["574"] = 518,
		["575"] = 519,
		["576"] = 519,
		["577"] = 519,
		["578"] = 519,
		["579"] = 519,
		["580"] = 519,
		["581"] = 519,
		["582"] = 519,
		["584"] = 515,
		["585"] = 522,
		["586"] = 523,
		["587"] = 522,
		["588"] = 527,
		["589"] = 528,
		["590"] = 527,
		["591"] = 510,
		["592"] = 503,
		["593"] = 503,
		["594"] = 503,
		["595"] = 503,
		["596"] = 503,
		["597"] = 503,
		["598"] = 503,
		["599"] = 510,
		["601"] = 510,
		["602"] = 532,
		["603"] = 539,
		["604"] = 532,
		["605"] = 539,
		["606"] = 542,
		["607"] = 543,
		["608"] = 544,
		["609"] = 542,
		["610"] = 546,
		["611"] = 547,
		["612"] = 546,
		["613"] = 552,
		["614"] = 553,
		["615"] = 552,
		["616"] = 555,
		["617"] = 556,
		["618"] = 555,
		["619"] = 539,
		["620"] = 532,
		["621"] = 532,
		["622"] = 532,
		["623"] = 532,
		["624"] = 532,
		["625"] = 532,
		["626"] = 532,
		["627"] = 539,
		["629"] = 539,
		["630"] = 560,
		["631"] = 567,
		["632"] = 560,
		["633"] = 567,
		["634"] = 570,
		["635"] = 571,
		["636"] = 570,
		["637"] = 573,
		["638"] = 574,
		["639"] = 575,
		["640"] = 576,
		["641"] = 576,
		["642"] = 576,
		["643"] = 576,
		["644"] = 577,
		["645"] = 578,
		["646"] = 579,
		["647"] = 580,
		["648"] = 581,
		["649"] = 582,
		["651"] = 584,
		["652"] = 585,
		["655"] = 588,
		["656"] = 589,
		["657"] = 589,
		["658"] = 589,
		["659"] = 589,
		["660"] = 589,
		["661"] = 589,
		["663"] = 592,
		["664"] = 592,
		["665"] = 592,
		["666"] = 592,
		["667"] = 592,
		["668"] = 592,
		["669"] = 592,
		["670"] = 592,
		["671"] = 594,
		["672"] = 595,
		["673"] = 597,
		["674"] = 597,
		["675"] = 597,
		["676"] = 597,
		["677"] = 597,
		["678"] = 597,
		["679"] = 597,
		["680"] = 597,
		["682"] = 601,
		["683"] = 601,
		["684"] = 601,
		["685"] = 601,
		["686"] = 601,
		["687"] = 602,
		["688"] = 602,
		["689"] = 602,
		["690"] = 602,
		["691"] = 602,
		["692"] = 602,
		["693"] = 602,
		["694"] = 602,
		["695"] = 602,
		["696"] = 603,
		["697"] = 603,
		["698"] = 603,
		["699"] = 603,
		["700"] = 603,
		["701"] = 603,
		["702"] = 603,
		["703"] = 603,
		["705"] = 573,
		["706"] = 606,
		["707"] = 607,
		["708"] = 608,
		["710"] = 606,
		["711"] = 567,
		["712"] = 560,
		["713"] = 560,
		["714"] = 560,
		["715"] = 560,
		["716"] = 560,
		["717"] = 560,
		["718"] = 560,
		["719"] = 567,
		["721"] = 567,
		["722"] = 614,
		["723"] = 621,
		["724"] = 614,
		["725"] = 621,
		["727"] = 621,
		["728"] = 625,
		["729"] = 614,
		["730"] = 626,
		["731"] = 627,
		["732"] = 628,
		["733"] = 629,
		["734"] = 626,
		["735"] = 631,
		["736"] = 632,
		["737"] = 633,
		["738"] = 634,
		["740"] = 636,
		["741"] = 637,
		["742"] = 637,
		["743"] = 637,
		["744"] = 637,
		["745"] = 637,
		["746"] = 637,
		["747"] = 637,
		["748"] = 637,
		["749"] = 637,
		["750"] = 638,
		["751"] = 638,
		["752"] = 638,
		["753"] = 638,
		["754"] = 638,
		["755"] = 639,
		["756"] = 639,
		["757"] = 639,
		["758"] = 639,
		["759"] = 639,
		["760"] = 639,
		["761"] = 639,
		["762"] = 639,
		["764"] = 631,
		["765"] = 642,
		["766"] = 643,
		["767"] = 644,
		["768"] = 645,
		["769"] = 646,
		["770"] = 646,
		["771"] = 646,
		["772"] = 646,
		["773"] = 647,
		["774"] = 647,
		["775"] = 647,
		["776"] = 647,
		["777"] = 648,
		["778"] = 648,
		["779"] = 648,
		["780"] = 648,
		["781"] = 649,
		["782"] = 650,
		["783"] = 650,
		["784"] = 650,
		["785"] = 650,
		["786"] = 650,
		["787"] = 650,
		["788"] = 650,
		["789"] = 650,
		["790"] = 650,
		["791"] = 651,
		["792"] = 652,
		["793"] = 652,
		["794"] = 652,
		["795"] = 652,
		["796"] = 652,
		["797"] = 652,
		["798"] = 652,
		["799"] = 652,
		["801"] = 642,
		["802"] = 655,
		["803"] = 656,
		["804"] = 657,
		["805"] = 657,
		["806"] = 656,
		["807"] = 655,
		["808"] = 660,
		["809"] = 661,
		["810"] = 662,
		["811"] = 663,
		["812"] = 664,
		["814"] = 660,
		["815"] = 667,
		["816"] = 668,
		["817"] = 667,
		["818"] = 621,
		["819"] = 614,
		["820"] = 614,
		["821"] = 614,
		["822"] = 614,
		["823"] = 614,
		["824"] = 614,
		["825"] = 614,
		["826"] = 621,
		["828"] = 621,
		["829"] = 677,
		["830"] = 684,
		["831"] = 677,
		["832"] = 684,
		["833"] = 687,
		["834"] = 688,
		["835"] = 689,
		["836"] = 687,
		["837"] = 691,
		["838"] = 692,
		["839"] = 693,
		["840"] = 694,
		["842"] = 691,
		["843"] = 697,
		["844"] = 698,
		["845"] = 699,
		["846"] = 700,
		["847"] = 701,
		["849"] = 697,
		["850"] = 704,
		["851"] = 705,
		["852"] = 704,
		["853"] = 709,
		["854"] = 710,
		["855"] = 709,
		["856"] = 684,
		["857"] = 677,
		["858"] = 677,
		["859"] = 677,
		["860"] = 677,
		["861"] = 677,
		["862"] = 677,
		["863"] = 677,
		["864"] = 684,
		["866"] = 684,
		["867"] = 715,
		["868"] = 722,
		["869"] = 715,
		["870"] = 722,
		["872"] = 722,
		["873"] = 727,
		["874"] = 715,
		["875"] = 728,
		["876"] = 729,
		["877"] = 730,
		["878"] = 731,
		["879"] = 732,
		["880"] = 728,
		["881"] = 734,
		["882"] = 735,
		["883"] = 736,
		["885"] = 734,
		["886"] = 739,
		["887"] = 740,
		["888"] = 741,
		["889"] = 742,
		["892"] = 745,
		["893"] = 753,
		["894"] = 739,
		["895"] = 756,
		["896"] = 757,
		["897"] = 756,
		["898"] = 761,
		["899"] = 762,
		["900"] = 761,
		["901"] = 722,
		["902"] = 715,
		["903"] = 715,
		["904"] = 715,
		["905"] = 715,
		["906"] = 715,
		["907"] = 715,
		["908"] = 715,
		["909"] = 722,
		["911"] = 722,
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
function K.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function K.prototype.OnBattleEnd(self)
	self:Destroy()
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