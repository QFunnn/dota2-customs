--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_fury"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["20"] = 5,
		["21"] = 7,
		["22"] = 9,
		["23"] = 11,
		["24"] = 13,
		["25"] = 35,
		["26"] = 4,
		["27"] = 41,
		["28"] = 42,
		["29"] = 43,
		["30"] = 44,
		["31"] = 45,
		["32"] = 46,
		["33"] = 47,
		["34"] = 48,
		["35"] = 49,
		["36"] = 50,
		["37"] = 51,
		["38"] = 52,
		["39"] = 53,
		["40"] = 54,
		["41"] = 55,
		["42"] = 56,
		["43"] = 57,
		["44"] = 58,
		["45"] = 59,
		["46"] = 60,
		["47"] = 61,
		["48"] = 62,
		["49"] = 63,
		["50"] = 65,
		["51"] = 41,
		["52"] = 67,
		["53"] = 67,
		["54"] = 67,
		["56"] = 68,
		["57"] = 69,
		["61"] = 70,
		["62"] = 71,
		["65"] = 72,
		["66"] = 72,
		["67"] = 72,
		["68"] = 72,
		["69"] = 72,
		["70"] = 72,
		["71"] = 72,
		["75"] = 75,
		["78"] = 76,
		["82"] = 79,
		["85"] = 80,
		["86"] = 81,
		["87"] = 82,
		["88"] = 82,
		["89"] = 82,
		["90"] = 82,
		["91"] = 82,
		["92"] = 82,
		["93"] = 82,
		["94"] = 82,
		["95"] = 82,
		["96"] = 83,
		["97"] = 83,
		["98"] = 83,
		["99"] = 83,
		["100"] = 83,
		["101"] = 84,
		["102"] = 84,
		["103"] = 84,
		["104"] = 84,
		["105"] = 84,
		["109"] = 87,
		["112"] = 88,
		["113"] = 89,
		["114"] = 89,
		["115"] = 89,
		["116"] = 89,
		["117"] = 89,
		["118"] = 90,
		["119"] = 90,
		["120"] = 90,
		["121"] = 90,
		["122"] = 90,
		["123"] = 91,
		["124"] = 92,
		["125"] = 93,
		["126"] = 93,
		["127"] = 93,
		["128"] = 93,
		["129"] = 93,
		["130"] = 94,
		["131"] = 94,
		["132"] = 94,
		["133"] = 94,
		["134"] = 94,
		["135"] = 95,
		["136"] = 96,
		["137"] = 96,
		["138"] = 96,
		["139"] = 96,
		["140"] = 96,
		["141"] = 96,
		["142"] = 96,
		["143"] = 96,
		["147"] = 99,
		["150"] = 100,
		["151"] = 101,
		["152"] = 101,
		["153"] = 101,
		["154"] = 101,
		["155"] = 101,
		["156"] = 101,
		["157"] = 107,
		["158"] = 108,
		["159"] = 109,
		["160"] = 110,
		["161"] = 111,
		["163"] = 113,
		["164"] = 113,
		["165"] = 113,
		["166"] = 113,
		["167"] = 113,
		["168"] = 113,
		["169"] = 113,
		["170"] = 113,
		["172"] = 115,
		["173"] = 116,
		["174"] = 117,
		["175"] = 118,
		["176"] = 101,
		["177"] = 101,
		["178"] = 121,
		["182"] = 124,
		["185"] = 125,
		["186"] = 125,
		["187"] = 125,
		["188"] = 125,
		["189"] = 125,
		["190"] = 125,
		["195"] = 67,
		["196"] = 130,
		["197"] = 131,
		["198"] = 130,
		["199"] = 5,
		["200"] = 4,
		["201"] = 5,
		["203"] = 5,
		["204"] = 135,
		["205"] = 143,
		["206"] = 135,
		["207"] = 143,
		["209"] = 143,
		["210"] = 147,
		["211"] = 149,
		["212"] = 151,
		["213"] = 157,
		["214"] = 196,
		["215"] = 135,
		["216"] = 203,
		["217"] = 204,
		["218"] = 205,
		["219"] = 206,
		["220"] = 207,
		["221"] = 208,
		["222"] = 209,
		["223"] = 210,
		["224"] = 211,
		["225"] = 212,
		["226"] = 213,
		["227"] = 216,
		["228"] = 217,
		["229"] = 218,
		["230"] = 219,
		["231"] = 220,
		["232"] = 221,
		["233"] = 229,
		["234"] = 230,
		["235"] = 231,
		["236"] = 232,
		["237"] = 233,
		["238"] = 234,
		["239"] = 235,
		["240"] = 236,
		["241"] = 238,
		["242"] = 239,
		["243"] = 203,
		["244"] = 242,
		["245"] = 243,
		["246"] = 244,
		["247"] = 245,
		["249"] = 247,
		["250"] = 242,
		["251"] = 249,
		["252"] = 250,
		["253"] = 251,
		["254"] = 253,
		["255"] = 254,
		["256"] = 255,
		["257"] = 256,
		["258"] = 257,
		["261"] = 261,
		["262"] = 262,
		["263"] = 263,
		["264"] = 264,
		["265"] = 265,
		["268"] = 249,
		["269"] = 278,
		["270"] = 279,
		["271"] = 279,
		["272"] = 279,
		["273"] = 282,
		["274"] = 282,
		["275"] = 282,
		["276"] = 279,
		["277"] = 279,
		["278"] = 285,
		["279"] = 285,
		["280"] = 285,
		["281"] = 279,
		["282"] = 279,
		["283"] = 278,
		["284"] = 288,
		["285"] = 289,
		["286"] = 288,
		["287"] = 294,
		["288"] = 295,
		["289"] = 294,
		["290"] = 299,
		["291"] = 300,
		["292"] = 299,
		["293"] = 302,
		["294"] = 303,
		["295"] = 304,
		["297"] = 307,
		["298"] = 308,
		["300"] = 313,
		["301"] = 315,
		["302"] = 316,
		["303"] = 316,
		["304"] = 316,
		["305"] = 316,
		["306"] = 316,
		["307"] = 316,
		["308"] = 319,
		["309"] = 320,
		["311"] = 302,
		["312"] = 323,
		["313"] = 324,
		["314"] = 325,
		["315"] = 326,
		["316"] = 327,
		["317"] = 328,
		["318"] = 330,
		["319"] = 332,
		["320"] = 332,
		["321"] = 332,
		["322"] = 332,
		["323"] = 332,
		["324"] = 332,
		["325"] = 334,
		["326"] = 335,
		["327"] = 335,
		["328"] = 335,
		["329"] = 335,
		["330"] = 335,
		["331"] = 335,
		["333"] = 338,
		["334"] = 339,
		["335"] = 340,
		["336"] = 341,
		["337"] = 342,
		["338"] = 343,
		["339"] = 343,
		["340"] = 344,
		["341"] = 344,
		["342"] = 345,
		["343"] = 346,
		["346"] = 349,
		["347"] = 350,
		["349"] = 352,
		["352"] = 356,
		["353"] = 357,
		["354"] = 359,
		["355"] = 360,
		["356"] = 361,
		["358"] = 363,
		["359"] = 364,
		["360"] = 365,
		["361"] = 366,
		["362"] = 367,
		["363"] = 368,
		["365"] = 370,
		["366"] = 371,
		["369"] = 374,
		["370"] = 375,
		["371"] = 376,
		["372"] = 377,
		["374"] = 379,
		["375"] = 380,
		["379"] = 323,
		["380"] = 392,
		["381"] = 393,
		["382"] = 394,
		["383"] = 395,
		["384"] = 398,
		["385"] = 400,
		["386"] = 401,
		["387"] = 401,
		["388"] = 401,
		["389"] = 401,
		["390"] = 401,
		["391"] = 401,
		["393"] = 404,
		["394"] = 405,
		["395"] = 405,
		["396"] = 405,
		["397"] = 405,
		["398"] = 405,
		["399"] = 406,
		["400"] = 406,
		["401"] = 406,
		["402"] = 406,
		["403"] = 406,
		["404"] = 407,
		["405"] = 407,
		["406"] = 407,
		["407"] = 407,
		["408"] = 407,
		["409"] = 408,
		["412"] = 392,
		["413"] = 421,
		["414"] = 422,
		["415"] = 423,
		["416"] = 424,
		["417"] = 425,
		["418"] = 426,
		["421"] = 421,
		["422"] = 430,
		["423"] = 431,
		["424"] = 432,
		["425"] = 433,
		["427"] = 430,
		["428"] = 441,
		["429"] = 442,
		["430"] = 443,
		["431"] = 445,
		["432"] = 446,
		["436"] = 441,
		["437"] = 451,
		["438"] = 452,
		["439"] = 454,
		["440"] = 460,
		["441"] = 461,
		["442"] = 462,
		["443"] = 463,
		["445"] = 467,
		["446"] = 468,
		["448"] = 471,
		["449"] = 472,
		["452"] = 451,
		["453"] = 493,
		["454"] = 494,
		["455"] = 493,
		["456"] = 499,
		["457"] = 500,
		["460"] = 503,
		["463"] = 506,
		["464"] = 507,
		["466"] = 507,
		["469"] = 499,
		["470"] = 511,
		["471"] = 512,
		["472"] = 513,
		["473"] = 513,
		["474"] = 513,
		["475"] = 513,
		["476"] = 513,
		["477"] = 513,
		["478"] = 513,
		["479"] = 513,
		["480"] = 513,
		["481"] = 513,
		["482"] = 511,
		["483"] = 143,
		["484"] = 135,
		["485"] = 135,
		["486"] = 135,
		["487"] = 135,
		["488"] = 135,
		["489"] = 135,
		["490"] = 135,
		["491"] = 143,
		["493"] = 143,
		["494"] = 518,
		["495"] = 525,
		["496"] = 518,
		["497"] = 525,
		["498"] = 527,
		["499"] = 528,
		["500"] = 527,
		["501"] = 530,
		["502"] = 531,
		["503"] = 530,
		["504"] = 535,
		["505"] = 536,
		["506"] = 535,
		["507"] = 525,
		["508"] = 518,
		["509"] = 518,
		["510"] = 518,
		["511"] = 518,
		["512"] = 518,
		["513"] = 518,
		["514"] = 518,
		["515"] = 525,
		["517"] = 525,
		["518"] = 539,
		["519"] = 546,
		["520"] = 539,
		["521"] = 546,
		["522"] = 549,
		["523"] = 550,
		["524"] = 551,
		["525"] = 549,
		["526"] = 553,
		["527"] = 554,
		["528"] = 555,
		["529"] = 555,
		["530"] = 555,
		["531"] = 555,
		["532"] = 556,
		["533"] = 557,
		["535"] = 559,
		["536"] = 559,
		["537"] = 559,
		["538"] = 559,
		["539"] = 559,
		["540"] = 560,
		["541"] = 561,
		["542"] = 562,
		["543"] = 563,
		["544"] = 563,
		["545"] = 563,
		["546"] = 563,
		["547"] = 563,
		["548"] = 564,
		["549"] = 564,
		["550"] = 564,
		["551"] = 564,
		["552"] = 564,
		["553"] = 564,
		["554"] = 564,
		["555"] = 564,
		["557"] = 553,
		["558"] = 568,
		["559"] = 569,
		["560"] = 570,
		["561"] = 570,
		["562"] = 570,
		["563"] = 570,
		["564"] = 570,
		["565"] = 570,
		["567"] = 568,
		["568"] = 573,
		["569"] = 574,
		["570"] = 575,
		["571"] = 575,
		["572"] = 575,
		["573"] = 575,
		["575"] = 573,
		["576"] = 578,
		["577"] = 579,
		["578"] = 578,
		["579"] = 583,
		["580"] = 584,
		["581"] = 585,
		["582"] = 585,
		["583"] = 585,
		["584"] = 584,
		["585"] = 584,
		["586"] = 584,
		["587"] = 583,
		["588"] = 589,
		["589"] = 590,
		["590"] = 589,
		["591"] = 592,
		["592"] = 593,
		["593"] = 592,
		["594"] = 595,
		["595"] = 596,
		["596"] = 597,
		["597"] = 598,
		["598"] = 598,
		["599"] = 598,
		["600"] = 598,
		["601"] = 598,
		["602"] = 598,
		["604"] = 595,
		["605"] = 546,
		["606"] = 539,
		["607"] = 539,
		["608"] = 539,
		["609"] = 539,
		["610"] = 539,
		["611"] = 539,
		["612"] = 539,
		["613"] = 546,
		["615"] = 546,
		["616"] = 605,
		["617"] = 613,
		["618"] = 605,
		["619"] = 613,
		["620"] = 614,
		["621"] = 615,
		["622"] = 616,
		["623"] = 617,
		["624"] = 618,
		["627"] = 614,
		["628"] = 622,
		["629"] = 623,
		["630"] = 624,
		["631"] = 625,
		["632"] = 626,
		["635"] = 622,
		["636"] = 630,
		["637"] = 631,
		["638"] = 630,
		["639"] = 635,
		["640"] = 636,
		["641"] = 635,
		["642"] = 613,
		["643"] = 605,
		["644"] = 605,
		["645"] = 605,
		["646"] = 605,
		["647"] = 605,
		["648"] = 605,
		["649"] = 605,
		["650"] = 605,
		["651"] = 613,
		["653"] = 613,
		["655"] = 641,
		["656"] = 648,
		["657"] = 641,
		["658"] = 648,
		["660"] = 648,
		["661"] = 650,
		["662"] = 641,
		["663"] = 653,
		["664"] = 654,
		["665"] = 655,
		["666"] = 656,
		["667"] = 656,
		["668"] = 656,
		["669"] = 656,
		["670"] = 656,
		["671"] = 657,
		["672"] = 658,
		["673"] = 659,
		["674"] = 660,
		["675"] = 661,
		["676"] = 662,
		["677"] = 662,
		["678"] = 662,
		["679"] = 662,
		["680"] = 662,
		["681"] = 662,
		["683"] = 667,
		["684"] = 668,
		["685"] = 669,
		["686"] = 670,
		["687"] = 671,
		["688"] = 672,
		["689"] = 678,
		["690"] = 679,
		["691"] = 679,
		["692"] = 679,
		["693"] = 679,
		["694"] = 679,
		["695"] = 679,
		["696"] = 679,
		["697"] = 679,
		["698"] = 679,
		["699"] = 680,
		["700"] = 680,
		["701"] = 680,
		["702"] = 680,
		["703"] = 680,
		["704"] = 680,
		["705"] = 680,
		["706"] = 680,
		["708"] = 653,
		["709"] = 683,
		["710"] = 684,
		["711"] = 685,
		["712"] = 686,
		["713"] = 687,
		["714"] = 688,
		["715"] = 689,
		["716"] = 690,
		["717"] = 691,
		["718"] = 692,
		["719"] = 693,
		["720"] = 693,
		["721"] = 693,
		["722"] = 693,
		["723"] = 693,
		["724"] = 693,
		["725"] = 693,
		["726"] = 693,
		["727"] = 693,
		["728"] = 694,
		["729"] = 694,
		["730"] = 694,
		["731"] = 694,
		["732"] = 694,
		["733"] = 695,
		["735"] = 697,
		["736"] = 698,
		["737"] = 698,
		["738"] = 698,
		["739"] = 698,
		["740"] = 698,
		["741"] = 698,
		["742"] = 698,
		["743"] = 698,
		["744"] = 698,
		["745"] = 699,
		["747"] = 701,
		["749"] = 703,
		["750"] = 704,
		["751"] = 704,
		["752"] = 704,
		["753"] = 704,
		["754"] = 704,
		["755"] = 706,
		["756"] = 707,
		["758"] = 709,
		["759"] = 709,
		["760"] = 709,
		["761"] = 709,
		["762"] = 709,
		["765"] = 683,
		["766"] = 713,
		["767"] = 714,
		["770"] = 717,
		["773"] = 720,
		["774"] = 721,
		["775"] = 722,
		["776"] = 723,
		["777"] = 724,
		["780"] = 727,
		["781"] = 728,
		["782"] = 729,
		["783"] = 730,
		["784"] = 730,
		["785"] = 730,
		["786"] = 730,
		["787"] = 730,
		["788"] = 730,
		["789"] = 730,
		["790"] = 730,
		["791"] = 730,
		["792"] = 730,
		["794"] = 713,
		["795"] = 742,
		["796"] = 743,
		["797"] = 744,
		["798"] = 744,
		["799"] = 743,
		["800"] = 742,
		["801"] = 747,
		["802"] = 748,
		["803"] = 747,
		["804"] = 750,
		["805"] = 751,
		["806"] = 750,
		["807"] = 756,
		["808"] = 757,
		["809"] = 756,
		["810"] = 761,
		["811"] = 762,
		["812"] = 761,
		["813"] = 766,
		["814"] = 767,
		["815"] = 768,
		["817"] = 771,
		["818"] = 772,
		["820"] = 774,
		["821"] = 775,
		["822"] = 776,
		["824"] = 778,
		["825"] = 766,
		["826"] = 648,
		["827"] = 641,
		["828"] = 641,
		["829"] = 641,
		["830"] = 641,
		["831"] = 641,
		["832"] = 641,
		["833"] = 641,
		["834"] = 648,
		["836"] = 648,
		["838"] = 783,
		["839"] = 790,
		["840"] = 783,
		["841"] = 790,
		["842"] = 792,
		["843"] = 793,
		["844"] = 794,
		["846"] = 792,
		["847"] = 797,
		["848"] = 798,
		["849"] = 797,
		["850"] = 802,
		["851"] = 803,
		["852"] = 802,
		["853"] = 790,
		["854"] = 783,
		["855"] = 783,
		["856"] = 783,
		["857"] = 783,
		["858"] = 783,
		["859"] = 783,
		["860"] = 783,
		["861"] = 790,
		["863"] = 790,
		["865"] = 808,
		["866"] = 815,
		["867"] = 808,
		["868"] = 815,
		["869"] = 819,
		["870"] = 820,
		["871"] = 821,
		["872"] = 819,
		["873"] = 823,
		["874"] = 824,
		["875"] = 825,
		["877"] = 823,
		["878"] = 828,
		["879"] = 829,
		["880"] = 828,
		["881"] = 833,
		["882"] = 834,
		["883"] = 835,
		["884"] = 835,
		["885"] = 835,
		["886"] = 835,
		["887"] = 835,
		["888"] = 835,
		["889"] = 835,
		["891"] = 833,
		["892"] = 815,
		["893"] = 808,
		["894"] = 808,
		["895"] = 808,
		["896"] = 808,
		["897"] = 808,
		["898"] = 808,
		["899"] = 808,
		["900"] = 815,
		["902"] = 815,
		["904"] = 841,
		["905"] = 848,
		["906"] = 841,
		["907"] = 848,
		["908"] = 852,
		["909"] = 853,
		["910"] = 854,
		["911"] = 852,
		["912"] = 856,
		["913"] = 857,
		["914"] = 858,
		["916"] = 856,
		["917"] = 861,
		["918"] = 862,
		["919"] = 861,
		["920"] = 866,
		["921"] = 867,
		["922"] = 868,
		["924"] = 866,
		["925"] = 848,
		["926"] = 841,
		["927"] = 841,
		["928"] = 841,
		["929"] = 841,
		["930"] = 841,
		["931"] = 841,
		["932"] = 841,
		["933"] = 848,
		["935"] = 848,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.sect_fury = c()
local o = h.sect_fury
o.name = "sect_fury"
d(o, j)
function o.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_129_timer = 0
	self.n_133_timer = 0
	self.sr_138_timer = 0
	self.sr_160_enable = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.fury_count_extra = self:GetSpecialValueFor("fury_count_extra")
	self.ice_fury_pct = self:GetSpecialValueFor("ice_fury_pct")
	self.n_128_chance = self:GetSectSpecialValueFor("128", "n_128_chance")
	self.n_128_poison = self:GetSectSpecialValueFor("128", "n_128_poison")
	self.n_129_interval = self:GetSectSpecialValueFor("129", "n_129_interval")
	self.n_129_fury = self:GetSectSpecialValueFor("129", "n_129_fury")
	self.n_133_chance = self:GetSectSpecialValueFor("133", "n_133_chance")
	self.r_135_chance = self:GetSectSpecialValueFor("135", "r_135_chance")
	self.r_135_fury = self:GetSectSpecialValueFor("135", "r_135_fury")
	self.r_136_fury_stack = self:GetSectSpecialValueFor("136", "r_136_fury_stack")
	self.sr_138_interval = self:GetSectSpecialValueFor("138", "sr_138_interval")
	self.sr_138_fury = self:GetSectSpecialValueFor("138", "sr_138_fury")
	self.sr_138_base_damage = self:GetSectSpecialValueFor("138", "sr_138_base_damage")
	self.sr_138_damage = self:GetSectSpecialValueFor("138", "sr_138_damage")
	self.sr_150_chance = self:GetSectSpecialValueFor("150", "sr_150_chance")
	self.sr_150_damage = self:GetSectSpecialValueFor("150", "sr_150_damage")
	self.r_155_fury = self:GetSectSpecialValueFor("155", "r_155_fury")
	self.r_155_fury_permanent = self:GetSectSpecialValueFor("155", "r_155_fury_permanent")
	self.sr_160_factor = self:GetSectSpecialValueFor("160", "sr_160_factor")
	self.n_176_chance = self:GetSectSpecialValueFor("176", "n_176_chance")
	self.n_176_chaos_count = self:GetSectSpecialValueFor("176", "n_176_chaos_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
	self.effect_1 = self:GetSectSpecialValueFor("150", "effect_1")
end
function o.prototype.TriggerByName(self, p, q)
	if q == nil then
		q = self:GetCaster():GetEnemy()
	end
	local r = self:GetCaster()
	if not IsInjurable(q, r) then
		return
	end
	repeat
		local s = p
		local t = s == "128"
		if t then
			do
				AddPoison(r, q, self.n_128_poison, "128", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "129"
		if t then
			do
				AddFury(r, self.n_129_fury, "129", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "135"
		if t then
			do
				AddFury(r, self.r_135_fury, "135", "AbilityUpgrade")
				local u = ParticleManager:CreateParticle("particles/sect/sect_fury_135.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(u, 1, r, PATTACH_ABSORIGIN, "", vec3_zero, false)
				ParticleManager:SetParticleControl(u, 0, r:GetAbsOrigin())
				ParticleManager:SetParticleControl(u, 1, q:GetAbsOrigin())
				break
			end
		end
		t = t or s == "138"
		if t then
			do
				local v = ParticleManager:CreateParticle(
					"particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf",
					PATTACH_CUSTOMORIGIN,
					r
				)
				ParticleManager:SetParticleControl(v, 0, q:GetAbsOrigin())
				ParticleManager:SetParticleControl(v, 1, Vector(450, 1, 1))
				r:EmitSound("Ability.LightStrikeArray")
				local w = ParticleManager:CreateParticle(
					"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_immortal1.vpcf",
					PATTACH_CUSTOMORIGIN,
					r
				)
				ParticleManager:SetParticleControl(w, 0, q:GetAbsOrigin())
				ParticleManager:SetParticleControl(w, 1, Vector(450, 450, 1))
				r:EmitSound("Hero_Invoker.SunStrike.Charge.Apex")
				r:DealDamage(
					q,
					self,
					GetFury(r) * self.sr_138_damage + self.sr_138_base_damage,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					nil,
					"138"
				)
				break
			end
		end
		t = t or s == "150"
		if t then
			do
				local x = self
				Projectile:CreateTrackingProjectile({
					EffectName = "particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf",
					hCaster = r,
					vSpawnOrigin = r:GetAttachmentPosition("attach_hitloc"),
					hTarget = q,
					iMoveSpeed = 1200,
					OnProjectileHit = function(y, z, A)
						if IsInjurable(q) then
							local B = self.sr_150_damage
							if self.effect_1 > 0 then
								B = B + GetFury(r) * self.effect_1 * 0.01
							end
							r:DealDamage(q, x, B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "150")
						end
						local C = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_impact.vpcf",
							PATTACH_CUSTOMORIGIN,
							nil
						)
						ParticleManager:SetParticleControl(C, 0, z)
						ParticleManager:SetParticleControl(C, 3, z)
						ParticleManager:ReleaseParticleIndex(C)
					end,
				})
				r:EmitSound("Hero_Snapfire.MortimerBlob.Launch")
				break
			end
		end
		t = t or s == "176"
		if t then
			do
				AddChaos(r, GetSectChaosModifiedValue(r, self.n_176_chaos_count), "176", "AbilityUpgrade")
				break
			end
		end
	until true
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_fury"
end
o = e({ k(nil) }, o)
h.sect_fury = o
h.modifier_sect_fury = c()
local D = h.modifier_sect_fury
D.name = "modifier_sect_fury"
d(D, m)
function D.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_129_timer = 0
	self.n_133_timer = 0
	self.sr_138_timer = 0
	self.sr_160_enable = false
end
function D.prototype.GetAbilitySpecialValue(self)
	self.fury_count_extra = self:GetAbilitySpecialValueFor("fury_count_extra")
	self.ice_fury_pct = self:GetAbilitySpecialValueFor("ice_fury_pct")
	self.n_128_chance = self:GetSectSpecialValueFor("128", "n_128_chance")
	self.n_128_poison = self:GetSectSpecialValueFor("128", "n_128_poison")
	self.n_129_interval = self:GetSectSpecialValueFor("129", "n_129_interval")
	self.n_129_fury = self:GetSectSpecialValueFor("129", "n_129_fury")
	self.n_133_chance = self:GetSectSpecialValueFor("133", "n_133_chance")
	self.r_135_chance = self:GetSectSpecialValueFor("135", "r_135_chance")
	self.r_135_fury = self:GetSectSpecialValueFor("135", "r_135_fury")
	self.r_136_fury_stack = self:GetSectSpecialValueFor("136", "r_136_fury_stack")
	self.sr_138_interval = self:GetSectSpecialValueFor("138", "sr_138_interval")
	self.sr_138_fury = self:GetSectSpecialValueFor("138", "sr_138_fury")
	self.sr_138_base_damage = self:GetSectSpecialValueFor("138", "sr_138_base_damage")
	self.sr_138_damage = self:GetSectSpecialValueFor("138", "sr_138_damage")
	self.sr_150_chance = self:GetSectSpecialValueFor("150", "sr_150_chance")
	self.sr_150_damage = self:GetSectSpecialValueFor("150", "sr_150_damage")
	self.r_155_fury = self:GetSectSpecialValueFor("155", "r_155_fury")
	self.r_155_fury_permanent = self:GetSectSpecialValueFor("155", "r_155_fury_permanent")
	self.sr_160_factor = self:GetSectSpecialValueFor("160", "sr_160_factor")
	self.n_176_chance = self:GetSectSpecialValueFor("176", "n_176_chance")
	self.n_176_chaos_count = self:GetSectSpecialValueFor("176", "n_176_chaos_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_fury_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_fury_effect", "value")
	self.effect_1 = self:GetSectSpecialValueFor("150", "effect_1")
	self.ability:GetAbilitySpecialValue()
end
function D.prototype.GetIceFuryPct(self)
	if IsServer() then
		local E = f(AbilityShop.pickList, "sect_fury") and 100 + self.ice_fury_pct or 100
		self:SetStackCount(E)
	end
	return self:GetStackCount() * 0.01
end
function D.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	local F = r:GetEnemy()
	if self.n_129_fury > 0 then
		self.n_129_timer = self.n_129_timer + self.timerInterval
		if self.n_129_timer >= self.n_129_interval then
			self.n_129_timer = self.n_129_timer - self.n_129_interval
			self.ability:TriggerByName("129")
		end
	end
	if self.sr_138_damage > 0 then
		self.sr_138_timer = self.sr_138_timer + self.timerInterval
		if self.sr_138_timer >= self.sr_138_interval then
			self.sr_138_timer = self.sr_138_timer - self.sr_138_interval
			self.ability:TriggerByName("138")
		end
	end
end
function D.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function D.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE] = self.fury_count_extra
			* self:GetIceFuryPct(),
	}
end
function D.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT }
end
function D.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function D.prototype.EOM_GetModifierAvoidDamage(self, G)
	if not self.sr_160_enable then
		return 0
	end
	if bit.band(G.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	local r = self:GetParent()
	if G.damage >= r:GetHealth() then
		r:AddNewModifier(r, self:GetAbility(), "modifier_sect_fury_160", { duration = BUFF_VALUE.SuperNovaDuration })
		self.sr_160_enable = false
		return 1
	end
end
function D.prototype.OnBattleStartBefore(self, G)
	local H = self:GetParent()
	local I = H:GetEnemy()
	self.n_129_timer = 0
	self.n_133_timer = 0
	self.sr_138_timer = 0
	self.sr_160_enable = self.sr_160_factor > 0
	H:AddNewModifier(H, self:GetAbility(), "modifier_fury_permanent", {})
	if self.n_133_chance > 0 and IsValid(I) then
		I:AddNewModifier(H, self:GetAbility(), "modifier_sect_fury_133_debuff", {})
	end
	if self.n_187_chance > 0 then
		local J = false
		local K = PlayerData:getHero(self.parent:GetPlayerOwnerID())
		if K then
			local L = K:getAbilityData()
			local M = L.sect_ice
			local N = M and M.exp or 0
			local O = L.sect_fury
			local P = O and O.exp or 0
			if P > N then
				J = true
			end
		end
		if J then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_sect_187_ice", nil)
		else
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_sect_187_fury", nil)
		end
	end
	local Q = self.r_155_fury + GetFuryPreBattle(H)
	if Q > 0 then
		local R = H:FindAbilityByName("sect_fury")
		if not IsValid(R) then
			R = H:AddAbility_Engine("sect_fury")
		end
		local S = H:FindModifierByName("modifier_ice_custom")
		if IsValid(S) then
			local T = S:GetStackCount()
			if T <= Q then
				Q = Q - T
				S:Destroy()
			else
				S:DecrementStackCount(Q)
				Q = 0
			end
		end
		if Q > 0 then
			if Q >= self.r_155_fury and self.r_155_fury > 0 then
				Q = Q - self.r_155_fury
				AddFury(H, self.r_155_fury, "155", "AbilityUpgrade")
			end
			if Q > 0 then
				AddFury(H, Q, "sect_fury", "Ability")
			end
		end
	end
end
function D.prototype.OnBattleStart(self, G)
	if IsServer() then
		local H = self:GetParent()
		local I = H:GetEnemy()
		self:StartIntervalThink(self.timerInterval)
		if self.r_136_fury_stack > 0 then
			H:AddNewModifier(H, self:GetAbility(), "modifier_sect_fury_136", nil)
		end
		if self.sr_138_damage > 0 then
			local v = ParticleManager:CreateParticle(
				"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_immortal1.vpcf",
				PATTACH_CUSTOMORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(v, 0, self:GetParent():GetEnemy():GetAbsOrigin())
			ParticleManager:SetParticleControl(v, 1, Vector(450, 450, 1))
			self:GetParent():EmitSound("Hero_Invoker.SunStrike.Charge.Apex")
		end
	end
end
function D.prototype.OnThink(self, U)
	local r = self:GetParent()
	local q = r:GetEnemy()
	local x = self:GetAbility()
	if not IsInjurable(q) then
		self:StartThink(-1, U)
		return
	end
end
function D.prototype.OnBattleEnd(self, G)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StartThink(-1, "sr_150_interval")
	end
end
function D.prototype.OnCustomTakeDamage(self, G)
	if IsServer() then
		if G and IsValid(G.attacker) then
			if self.r_135_chance > 0 and self:PRD(self.r_135_chance, "r_135_chance") then
				self.ability:TriggerByName("135", G.attacker)
			end
		end
	end
end
function D.prototype.OnFuryGained(self, G)
	if G then
		self:customAbilityTrigger()
		local r = self:GetParent()
		local F = r:GetEnemy()
		if self.sr_150_chance > 0 and self:PRD(self.sr_150_chance, "sr_150_chance") then
			self.ability:TriggerByName("150")
		end
		if self.n_128_chance > 0 and self:PRD(self.n_128_chance, "n_128_chance") then
			self.ability:TriggerByName("128")
		end
		if self.n_176_chance > 0 and self:PRD(self.n_176_chance, "n_176_chance") then
			self.ability:TriggerByName("176")
		end
	end
end
function D.prototype.EOM_GetModifierFuryPermanent(self)
	return self.r_155_fury_permanent
end
function D.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_fury" then
		return
	end
	if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
		local V = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
		if V ~= nil then
			V:customAbilityEffect()
		end
	end
end
function D.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local W = AddFury
	local X = self:GetParent()
	local Y = self.effect_value
	local Z = self:GetAbility()
	W(X, Y, Z and Z:GetAbilityName() or "", "Sect")
end
D = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	D
)
h.modifier_sect_fury = D
h.modifier_sect_fury_133_debuff = c()
local _ = h.modifier_sect_fury_133_debuff
_.name = "modifier_sect_fury_133_debuff"
d(_, m)
function _.prototype.GetAbilitySpecialValue(self)
	self.n_133_chance = self:GetSectSpecialValueFor("133", "n_133_chance")
end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_FURY_PERCENTAGE }
end
function _.prototype.EOM_GetModifierIgnoreFuryPercent(self)
	return self.n_133_chance
end
_ = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	_
)
h.modifier_sect_fury_133_debuff = _
h.modifier_sect_fury_136 = c()
local a0 = h.modifier_sect_fury_136
a0.name = "modifier_sect_fury_136"
d(a0, m)
function a0.prototype.GetAbilitySpecialValue(self)
	self.r_136_fury_stack = self:GetSectSpecialValueFor("136", "r_136_fury_stack")
	self.r_136_tick = self:GetSectSpecialValueFor("136", "r_136_tick")
end
function a0.prototype.OnCreated(self, G)
	if IsServer() then
		EmitSoundOn("Hero_EmberSpirit.FlameGuard.Cast", self:GetCaster())
		self:StartIntervalThink(self.r_136_tick)
		self:StartThink(0.1)
	else
		local v = ParticleManager:CreateParticle(
			"particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetCaster()
		)
		local a1 = self:GetCaster():GetAbsOrigin()
		ParticleManager:SetParticleControl(v, 0, a1)
		ParticleManager:SetParticleControl(v, 1, a1)
		ParticleManager:SetParticleControl(v, 2, Vector(350, 1, 1))
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function a0.prototype.OnIntervalThink(self)
	if IsServer() then
		AddFury(self:GetParent(), self.r_136_fury_stack, "136", "AbilityUpgrade")
	end
end
function a0.prototype.OnThink(self, U)
	if IsServer() then
		self:SetStackCount(
			math.min(BUFF_VALUE.BurningBodyMax, math.floor(GetFury(self:GetParent()) / BUFF_VALUE.BurningBodyThreshold))
		)
	end
end
function a0.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function a0.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS] = { self:GetParent() },
	}
end
function a0.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, G)
	return -BUFF_VALUE.BurningBodyMagicReduce * self:GetStackCount()
end
function a0.prototype.OnBattleEnd(self, G)
	self:Destroy()
end
function a0.prototype.OnFuryLoss(self, G)
	local a2 = G.iCount * BUFF_VALUE.BurningBodyConvert * 0.01
	if a2 > 0 then
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_sect_fury_136_fury",
			{ duration = BUFF_VALUE.BurningBodyDuration, iStackCount = a2 }
		)
	end
end
a0 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a0
)
h.modifier_sect_fury_136 = a0
h.modifier_sect_fury_136_fury = c()
local a3 = h.modifier_sect_fury_136_fury
a3.name = "modifier_sect_fury_136_fury"
d(a3, m)
function a3.prototype.OnCreated(self, G)
	if IsServer() then
		local a4 = G and G.iStackCount or 0
		if a4 > 0 then
			self:IncrementStackCount(a4)
		end
	end
end
function a3.prototype.OnRefresh(self, G)
	if IsServer() then
		local a4 = G and G.iStackCount or 0
		if a4 > 0 then
			self:IncrementStackCount(a4)
		end
	end
end
function a3.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT }
end
function a3.prototype.EOM_GetModifierFuryPermanent(self, G)
	return self:GetStackCount()
end
a3 = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	a3
)
h.modifier_sect_fury_136_fury = a3
h.modifier_sect_fury_160 = c()
local a5 = h.modifier_sect_fury_160
a5.name = "modifier_sect_fury_160"
d(a5, m)
function a5.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.flag = true
end
function a5.prototype.OnCreated(self, G)
	if IsServer() then
		local r = self:GetParent()
		EmitSoundOnLocationWithCaster(r:GetAbsOrigin(), "Hero_Phoenix.SuperNova.Begin", r)
		r:EmitSound("Hero_Phoenix.SuperNova.Cast")
		self.modelScale = r:GetModelScale()
		r:SetModelScale(0.01)
		local a6 = BUFF_VALUE.SuperNovaHealth - r:GetMaxHealth()
		if a6 > 0 then
			r:AddNewModifier(r, self:GetAbility(), "modifier_sect_fury_160_temphealh", { bonus_value = a6 })
		end
		r:SetHealth(BUFF_VALUE.SuperNovaHealth)
		CombatLog:recordSectAbilityCast(r, "160")
		self.damage_count = math.floor(BUFF_VALUE.SuperNovaDuration)
		self:StartIntervalThink(1)
		local a1 = r:GetAbsOrigin()
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{ origin = a1, model = "models/heroes/phoenix/phoenix_egg.vmdl", DefaultAnim = "ACT_DOTA_IDLE", use_animgraph = "1" }
		)
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.dummy
		)
		ParticleManager:SetParticleControlEnt(
			v,
			1,
			self.dummy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.dummy:GetAbsOrigin(),
			true
		)
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function a5.prototype.OnDestroy(self)
	if IsServer() then
		self:OnIntervalThink()
		local r = self:GetParent()
		r:RemoveModifierByName("modifier_sect_fury_160_temphealh")
		r:StopSound("Hero_Phoenix.SuperNova.Cast")
		r:SetModelScale(r:GetDefaultModelScale())
		if IsValid(self.dummy) then
			if self.flag then
				local v = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf",
					PATTACH_CUSTOMORIGIN,
					self.dummy
				)
				ParticleManager:SetParticleControlEnt(
					v,
					0,
					self.dummy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self.dummy:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(v, 1, Vector(500, 500, 500))
				ParticleManager:ReleaseParticleIndex(v)
			else
				local v = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self.dummy
				)
				ParticleManager:SetParticleControlEnt(
					v,
					1,
					self.dummy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self.dummy:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(v)
			end
			self.dummy:RemoveSelf()
		end
		if self.flag then
			EmitSoundOnLocationWithCaster(r:GetAbsOrigin(), "Hero_Phoenix.SuperNova.Explode", r)
			AddFury(r, BUFF_VALUE.SuperNovaFuryCount, "160", "AbilityUpgrade")
			r:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 3)
		else
			EmitSoundOnLocationWithCaster(r:GetAbsOrigin(), "Hero_Phoenix.SuperNova.Death", r)
		end
	end
end
function a5.prototype.OnIntervalThink(self)
	if not self.flag then
		return
	end
	if self.damage_count <= 0 then
		return
	end
	local r = self:GetParent()
	local q = r:GetEnemy()
	if not IsInjurable(r, q) then
		self.flag = false
		self:Destroy()
		return
	end
	self.damage_count = self.damage_count - 1
	local B = GetFury(r) * BUFF_VALUE.SuperNovaDPS * 0.01
	if B > 0 then
		DamageSystem:dealDamage({
			attacker = r,
			target = q,
			ability = self:GetAbility(),
			ability_upgrade = "160",
			damage = B,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
	end
end
function a5.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a5.prototype.OnBattleEnd(self, G)
	self.flag = false
end
function a5.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function a5.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -BUFF_VALUE.SuperNovaDamageReduce }
end
function a5.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function a5.prototype.EOM_GetModifierAvoidDamage(self, G)
	if not self.flag then
		return 0
	end
	if bit.band(G.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	if G.damage >= self:GetParent():GetHealth() then
		self.flag = false
		self:Destroy()
	end
	return 0
end
a5 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a5
)
h.modifier_sect_fury_160 = a5
h.modifier_sect_fury_160_temphealh = c()
local a7 = h.modifier_sect_fury_160_temphealh
a7.name = "modifier_sect_fury_160_temphealh"
d(a7, m)
function a7.prototype.OnCreated(self, G)
	if IsServer() then
		self.value = G and G.bonus_value or 0
	end
end
function a7.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function a7.prototype.EOM_GetModifierHealthBonus(self, G)
	return self.value
end
a7 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a7
)
h.modifier_sect_fury_160_temphealh = a7
h.modifier_sect_187_fury = c()
local a8 = h.modifier_sect_187_fury
a8.name = "modifier_sect_187_fury"
d(a8, m)
function a8.prototype.GetAbilitySpecialValue(self)
	self.n_187_count = self:GetSectSpecialValueFor("187", "n_187_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
end
function a8.prototype.OnCreated(self, G)
	if IsServer() then
		self.enemy = self.parent:GetEnemy()
	end
end
function a8.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self.parent } }
end
function a8.prototype.OnFuryGained(self, G)
	if self:PRD(self.n_187_chance) then
		AddIce(self.parent, self.enemy, self.n_187_count, "187", "AbilityUpgrade")
	end
end
a8 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a8
)
h.modifier_sect_187_fury = a8
h.modifier_sect_187_ice = c()
local a9 = h.modifier_sect_187_ice
a9.name = "modifier_sect_187_ice"
d(a9, m)
function a9.prototype.GetAbilitySpecialValue(self)
	self.n_187_count = self:GetSectSpecialValueFor("187", "n_187_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
end
function a9.prototype.OnCreated(self, G)
	if IsServer() then
		self.enemy = self.parent:GetEnemy()
	end
end
function a9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self.parent } }
end
function a9.prototype.OnIceGained(self, G)
	if self:PRD(self.n_187_chance) then
		AddFury(self.parent, self.n_187_count, "187", "AbilityUpgrade")
	end
end
a9 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a9
)
h.modifier_sect_187_ice = a9
return h