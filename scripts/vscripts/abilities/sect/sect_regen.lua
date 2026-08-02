--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_regen"
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
		["20"] = 7,
		["21"] = 9,
		["22"] = 11,
		["23"] = 12,
		["24"] = 36,
		["25"] = 4,
		["26"] = 45,
		["27"] = 46,
		["28"] = 47,
		["29"] = 48,
		["30"] = 49,
		["31"] = 50,
		["32"] = 51,
		["33"] = 52,
		["34"] = 53,
		["35"] = 54,
		["36"] = 55,
		["37"] = 56,
		["38"] = 57,
		["39"] = 58,
		["40"] = 59,
		["41"] = 60,
		["42"] = 61,
		["43"] = 62,
		["44"] = 63,
		["45"] = 64,
		["46"] = 65,
		["47"] = 66,
		["48"] = 67,
		["49"] = 68,
		["50"] = 69,
		["51"] = 70,
		["52"] = 71,
		["53"] = 72,
		["54"] = 73,
		["55"] = 74,
		["56"] = 45,
		["57"] = 76,
		["58"] = 76,
		["59"] = 76,
		["61"] = 77,
		["62"] = 78,
		["66"] = 81,
		["67"] = 82,
		["70"] = 83,
		["74"] = 86,
		["77"] = 87,
		["81"] = 90,
		["84"] = 91,
		["85"] = 91,
		["86"] = 91,
		["87"] = 91,
		["88"] = 91,
		["89"] = 91,
		["90"] = 91,
		["94"] = 94,
		["97"] = 95,
		["98"] = 95,
		["99"] = 95,
		["100"] = 95,
		["101"] = 95,
		["102"] = 95,
		["103"] = 95,
		["107"] = 98,
		["110"] = 99,
		["114"] = 102,
		["117"] = 103,
		["118"] = 103,
		["119"] = 103,
		["120"] = 103,
		["121"] = 103,
		["122"] = 103,
		["123"] = 103,
		["127"] = 106,
		["131"] = 108,
		["132"] = 109,
		["133"] = 109,
		["134"] = 109,
		["135"] = 109,
		["136"] = 109,
		["137"] = 109,
		["138"] = 109,
		["139"] = 109,
		["140"] = 109,
		["141"] = 110,
		["142"] = 110,
		["143"] = 110,
		["144"] = 110,
		["145"] = 110,
		["146"] = 110,
		["147"] = 110,
		["148"] = 110,
		["149"] = 110,
		["150"] = 111,
		["151"] = 112,
		["152"] = 112,
		["153"] = 112,
		["154"] = 113,
		["155"] = 114,
		["156"] = 114,
		["157"] = 114,
		["158"] = 114,
		["159"] = 114,
		["160"] = 114,
		["161"] = 114,
		["162"] = 114,
		["164"] = 112,
		["165"] = 112,
		["170"] = 120,
		["173"] = 121,
		["174"] = 122,
		["175"] = 122,
		["176"] = 122,
		["177"] = 122,
		["178"] = 122,
		["179"] = 123,
		["180"] = 123,
		["181"] = 123,
		["182"] = 123,
		["183"] = 123,
		["184"] = 124,
		["185"] = 124,
		["186"] = 124,
		["187"] = 125,
		["188"] = 126,
		["189"] = 126,
		["190"] = 126,
		["191"] = 126,
		["192"] = 126,
		["193"] = 126,
		["194"] = 126,
		["195"] = 126,
		["197"] = 124,
		["198"] = 124,
		["202"] = 131,
		["205"] = 132,
		["209"] = 135,
		["212"] = 136,
		["213"] = 137,
		["214"] = 138,
		["215"] = 139,
		["216"] = 140,
		["217"] = 141,
		["218"] = 141,
		["219"] = 141,
		["220"] = 141,
		["221"] = 141,
		["222"] = 141,
		["223"] = 141,
		["224"] = 141,
		["225"] = 141,
		["226"] = 141,
		["232"] = 155,
		["235"] = 156,
		["236"] = 156,
		["237"] = 156,
		["238"] = 156,
		["239"] = 156,
		["240"] = 156,
		["245"] = 76,
		["246"] = 161,
		["247"] = 162,
		["248"] = 161,
		["249"] = 5,
		["250"] = 4,
		["251"] = 5,
		["253"] = 5,
		["254"] = 166,
		["255"] = 174,
		["256"] = 166,
		["257"] = 174,
		["259"] = 174,
		["260"] = 178,
		["261"] = 180,
		["262"] = 182,
		["263"] = 183,
		["264"] = 209,
		["265"] = 166,
		["266"] = 218,
		["267"] = 219,
		["268"] = 220,
		["269"] = 221,
		["270"] = 222,
		["271"] = 223,
		["272"] = 224,
		["273"] = 225,
		["274"] = 226,
		["275"] = 227,
		["276"] = 228,
		["277"] = 229,
		["278"] = 230,
		["279"] = 231,
		["280"] = 232,
		["281"] = 235,
		["282"] = 236,
		["283"] = 237,
		["284"] = 238,
		["285"] = 239,
		["286"] = 240,
		["287"] = 241,
		["288"] = 242,
		["289"] = 243,
		["290"] = 244,
		["291"] = 245,
		["292"] = 246,
		["293"] = 247,
		["294"] = 218,
		["295"] = 249,
		["296"] = 250,
		["297"] = 251,
		["298"] = 251,
		["299"] = 251,
		["300"] = 250,
		["301"] = 250,
		["302"] = 250,
		["303"] = 254,
		["304"] = 254,
		["305"] = 254,
		["306"] = 250,
		["307"] = 250,
		["308"] = 249,
		["309"] = 257,
		["310"] = 258,
		["311"] = 257,
		["312"] = 263,
		["313"] = 264,
		["314"] = 263,
		["315"] = 269,
		["316"] = 270,
		["317"] = 269,
		["318"] = 272,
		["319"] = 273,
		["320"] = 274,
		["322"] = 276,
		["323"] = 272,
		["324"] = 278,
		["325"] = 280,
		["326"] = 280,
		["328"] = 281,
		["329"] = 282,
		["330"] = 283,
		["331"] = 283,
		["332"] = 283,
		["333"] = 283,
		["334"] = 283,
		["335"] = 283,
		["336"] = 284,
		["337"] = 285,
		["338"] = 286,
		["339"] = 287,
		["341"] = 289,
		["342"] = 278,
		["343"] = 291,
		["344"] = 292,
		["345"] = 295,
		["346"] = 298,
		["347"] = 301,
		["348"] = 304,
		["349"] = 307,
		["350"] = 310,
		["351"] = 313,
		["352"] = 314,
		["354"] = 317,
		["355"] = 318,
		["356"] = 319,
		["357"] = 320,
		["358"] = 321,
		["361"] = 326,
		["362"] = 327,
		["363"] = 327,
		["364"] = 327,
		["365"] = 328,
		["366"] = 329,
		["367"] = 329,
		["368"] = 329,
		["369"] = 329,
		["370"] = 329,
		["371"] = 329,
		["372"] = 329,
		["373"] = 329,
		["375"] = 327,
		["376"] = 327,
		["378"] = 334,
		["379"] = 291,
		["380"] = 337,
		["381"] = 338,
		["383"] = 339,
		["384"] = 339,
		["385"] = 340,
		["387"] = 341,
		["388"] = 342,
		["390"] = 342,
		["393"] = 344,
		["395"] = 344,
		["398"] = 346,
		["400"] = 346,
		["403"] = 348,
		["405"] = 348,
		["408"] = 350,
		["410"] = 350,
		["413"] = 352,
		["415"] = 352,
		["419"] = 339,
		["422"] = 337,
		["423"] = 358,
		["424"] = 359,
		["425"] = 360,
		["427"] = 358,
		["428"] = 364,
		["429"] = 365,
		["430"] = 366,
		["432"] = 364,
		["433"] = 370,
		["434"] = 371,
		["435"] = 372,
		["437"] = 370,
		["438"] = 376,
		["439"] = 377,
		["440"] = 378,
		["442"] = 376,
		["443"] = 382,
		["444"] = 383,
		["445"] = 384,
		["447"] = 382,
		["448"] = 388,
		["449"] = 389,
		["450"] = 390,
		["452"] = 388,
		["453"] = 394,
		["454"] = 395,
		["455"] = 396,
		["456"] = 397,
		["457"] = 398,
		["458"] = 399,
		["459"] = 400,
		["460"] = 402,
		["461"] = 403,
		["462"] = 404,
		["463"] = 404,
		["464"] = 404,
		["465"] = 404,
		["466"] = 404,
		["467"] = 404,
		["470"] = 406,
		["471"] = 407,
		["472"] = 407,
		["473"] = 407,
		["474"] = 407,
		["475"] = 407,
		["476"] = 407,
		["478"] = 394,
		["479"] = 410,
		["480"] = 411,
		["481"] = 412,
		["482"] = 413,
		["483"] = 416,
		["484"] = 417,
		["485"] = 418,
		["487"] = 420,
		["488"] = 421,
		["489"] = 421,
		["490"] = 421,
		["491"] = 421,
		["492"] = 421,
		["493"] = 422,
		["494"] = 422,
		["495"] = 422,
		["496"] = 422,
		["497"] = 422,
		["498"] = 423,
		["499"] = 423,
		["500"] = 423,
		["501"] = 423,
		["502"] = 423,
		["503"] = 423,
		["504"] = 423,
		["505"] = 423,
		["506"] = 423,
		["507"] = 424,
		["508"] = 424,
		["509"] = 424,
		["510"] = 424,
		["511"] = 424,
		["512"] = 424,
		["513"] = 424,
		["514"] = 424,
		["515"] = 425,
		["517"] = 428,
		["518"] = 429,
		["519"] = 429,
		["520"] = 429,
		["521"] = 429,
		["522"] = 429,
		["523"] = 429,
		["526"] = 410,
		["527"] = 444,
		["528"] = 445,
		["529"] = 446,
		["530"] = 447,
		["531"] = 448,
		["532"] = 449,
		["533"] = 450,
		["535"] = 452,
		["536"] = 453,
		["537"] = 454,
		["539"] = 456,
		["540"] = 457,
		["541"] = 458,
		["542"] = 459,
		["543"] = 459,
		["544"] = 459,
		["546"] = 459,
		["547"] = 460,
		["551"] = 444,
		["552"] = 465,
		["553"] = 466,
		["554"] = 467,
		["555"] = 468,
		["556"] = 469,
		["559"] = 473,
		["560"] = 474,
		["561"] = 475,
		["562"] = 476,
		["563"] = 477,
		["566"] = 481,
		["567"] = 482,
		["568"] = 483,
		["569"] = 484,
		["570"] = 485,
		["573"] = 465,
		["574"] = 490,
		["575"] = 491,
		["576"] = 492,
		["577"] = 493,
		["578"] = 494,
		["581"] = 490,
		["582"] = 500,
		["583"] = 501,
		["586"] = 504,
		["589"] = 508,
		["590"] = 510,
		["591"] = 511,
		["593"] = 511,
		["597"] = 500,
		["598"] = 515,
		["599"] = 516,
		["600"] = 517,
		["601"] = 517,
		["602"] = 517,
		["603"] = 517,
		["604"] = 517,
		["605"] = 517,
		["606"] = 517,
		["607"] = 517,
		["608"] = 517,
		["609"] = 517,
		["610"] = 515,
		["611"] = 174,
		["612"] = 166,
		["613"] = 166,
		["614"] = 166,
		["615"] = 166,
		["616"] = 166,
		["617"] = 166,
		["618"] = 166,
		["619"] = 166,
		["620"] = 174,
		["622"] = 174,
		["624"] = 522,
		["625"] = 530,
		["626"] = 522,
		["627"] = 530,
		["628"] = 531,
		["629"] = 532,
		["630"] = 533,
		["632"] = 531,
		["633"] = 537,
		["634"] = 538,
		["635"] = 537,
		["636"] = 544,
		["637"] = 545,
		["638"] = 544,
		["639"] = 530,
		["640"] = 522,
		["641"] = 522,
		["642"] = 522,
		["643"] = 522,
		["644"] = 522,
		["645"] = 522,
		["646"] = 522,
		["647"] = 530,
		["649"] = 530,
		["651"] = 553,
		["652"] = 561,
		["653"] = 553,
		["654"] = 561,
		["656"] = 561,
		["657"] = 563,
		["658"] = 564,
		["659"] = 565,
		["660"] = 553,
		["661"] = 566,
		["662"] = 567,
		["663"] = 566,
		["664"] = 569,
		["665"] = 570,
		["666"] = 571,
		["667"] = 572,
		["668"] = 572,
		["669"] = 572,
		["670"] = 572,
		["671"] = 572,
		["672"] = 572,
		["673"] = 572,
		["674"] = 572,
		["676"] = 569,
		["677"] = 575,
		["678"] = 576,
		["679"] = 577,
		["680"] = 578,
		["681"] = 579,
		["682"] = 580,
		["683"] = 581,
		["684"] = 582,
		["685"] = 583,
		["686"] = 584,
		["687"] = 585,
		["688"] = 585,
		["689"] = 585,
		["690"] = 585,
		["691"] = 585,
		["692"] = 585,
		["693"] = 585,
		["694"] = 585,
		["695"] = 586,
		["696"] = 587,
		["697"] = 588,
		["698"] = 589,
		["699"] = 589,
		["700"] = 589,
		["701"] = 589,
		["702"] = 589,
		["703"] = 589,
		["704"] = 589,
		["705"] = 589,
		["706"] = 590,
		["710"] = 575,
		["711"] = 595,
		["712"] = 596,
		["713"] = 595,
		["714"] = 601,
		["715"] = 602,
		["716"] = 601,
		["717"] = 604,
		["718"] = 605,
		["719"] = 606,
		["721"] = 604,
		["722"] = 609,
		["723"] = 610,
		["724"] = 611,
		["726"] = 609,
		["727"] = 614,
		["728"] = 615,
		["729"] = 616,
		["731"] = 614,
		["732"] = 619,
		["733"] = 620,
		["734"] = 621,
		["735"] = 621,
		["736"] = 621,
		["737"] = 620,
		["738"] = 622,
		["739"] = 622,
		["740"] = 622,
		["741"] = 620,
		["742"] = 620,
		["743"] = 619,
		["744"] = 625,
		["745"] = 626,
		["746"] = 627,
		["748"] = 625,
		["749"] = 630,
		["750"] = 631,
		["751"] = 632,
		["752"] = 633,
		["754"] = 630,
		["755"] = 561,
		["756"] = 553,
		["757"] = 553,
		["758"] = 553,
		["759"] = 553,
		["760"] = 553,
		["761"] = 553,
		["762"] = 553,
		["763"] = 561,
		["765"] = 561,
		["767"] = 639,
		["768"] = 649,
		["769"] = 639,
		["770"] = 649,
		["772"] = 649,
		["773"] = 650,
		["774"] = 651,
		["775"] = 652,
		["776"] = 639,
		["777"] = 654,
		["778"] = 655,
		["779"] = 654,
		["780"] = 657,
		["781"] = 658,
		["782"] = 659,
		["783"] = 660,
		["784"] = 661,
		["785"] = 661,
		["786"] = 661,
		["787"] = 661,
		["788"] = 661,
		["789"] = 661,
		["790"] = 661,
		["792"] = 661,
		["793"] = 662,
		["795"] = 657,
		["796"] = 665,
		["797"] = 666,
		["798"] = 667,
		["800"] = 665,
		["801"] = 670,
		["802"] = 671,
		["803"] = 672,
		["804"] = 673,
		["805"] = 674,
		["808"] = 677,
		["809"] = 678,
		["810"] = 679,
		["811"] = 680,
		["814"] = 683,
		["815"] = 684,
		["817"] = 670,
		["818"] = 687,
		["819"] = 688,
		["820"] = 687,
		["821"] = 692,
		["822"] = 693,
		["823"] = 692,
		["824"] = 695,
		["825"] = 696,
		["826"] = 695,
		["827"] = 700,
		["828"] = 701,
		["829"] = 702,
		["831"] = 700,
		["832"] = 649,
		["833"] = 639,
		["834"] = 639,
		["835"] = 639,
		["836"] = 639,
		["837"] = 639,
		["838"] = 639,
		["839"] = 639,
		["840"] = 639,
		["841"] = 639,
		["842"] = 649,
		["844"] = 649,
		["846"] = 708,
		["847"] = 715,
		["848"] = 708,
		["849"] = 715,
		["851"] = 715,
		["852"] = 716,
		["853"] = 717,
		["854"] = 708,
		["855"] = 725,
		["856"] = 726,
		["857"] = 727,
		["858"] = 725,
		["859"] = 729,
		["860"] = 730,
		["861"] = 731,
		["862"] = 732,
		["863"] = 733,
		["864"] = 734,
		["865"] = 735,
		["866"] = 736,
		["867"] = 737,
		["868"] = 737,
		["869"] = 737,
		["870"] = 737,
		["871"] = 737,
		["872"] = 738,
		["873"] = 738,
		["874"] = 738,
		["875"] = 738,
		["876"] = 738,
		["877"] = 739,
		["878"] = 739,
		["879"] = 739,
		["880"] = 739,
		["881"] = 739,
		["882"] = 739,
		["883"] = 739,
		["884"] = 739,
		["885"] = 740,
		["887"] = 729,
		["888"] = 743,
		["889"] = 744,
		["891"] = 743,
		["892"] = 747,
		["893"] = 748,
		["894"] = 749,
		["895"] = 750,
		["897"] = 747,
		["898"] = 753,
		["899"] = 754,
		["900"] = 753,
		["901"] = 758,
		["902"] = 759,
		["905"] = 760,
		["906"] = 761,
		["907"] = 762,
		["908"] = 763,
		["909"] = 764,
		["910"] = 765,
		["911"] = 766,
		["912"] = 767,
		["913"] = 767,
		["914"] = 767,
		["915"] = 767,
		["916"] = 767,
		["917"] = 767,
		["918"] = 767,
		["919"] = 767,
		["920"] = 767,
		["921"] = 768,
		["922"] = 769,
		["923"] = 770,
		["924"] = 771,
		["925"] = 771,
		["926"] = 771,
		["927"] = 771,
		["928"] = 771,
		["929"] = 771,
		["930"] = 771,
		["931"] = 771,
		["934"] = 774,
		["936"] = 776,
		["937"] = 758,
		["938"] = 778,
		["939"] = 779,
		["940"] = 779,
		["941"] = 779,
		["942"] = 779,
		["943"] = 778,
		["944"] = 784,
		["945"] = 785,
		["946"] = 786,
		["947"] = 784,
		["948"] = 788,
		["949"] = 789,
		["950"] = 790,
		["951"] = 791,
		["952"] = 791,
		["953"] = 791,
		["954"] = 791,
		["955"] = 791,
		["956"] = 791,
		["957"] = 791,
		["958"] = 791,
		["959"] = 792,
		["962"] = 788,
		["963"] = 715,
		["964"] = 708,
		["965"] = 708,
		["966"] = 708,
		["967"] = 708,
		["968"] = 708,
		["969"] = 708,
		["970"] = 708,
		["971"] = 715,
		["973"] = 715,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_regen = c()
local n = g.sect_regen
n.name = "sect_regen"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_59_timer = 0
	self.r_69_timer = 0
	self.r_68_damage_record = 0
	self.sr_143_enable = false
end
function n.prototype.GetAbilitySpecialValue(self)
	self.regen = self:GetSpecialValueFor("regen")
	self.n_59_interval = self:GetSectSpecialValueFor("59", "n_59_interval")
	self.n_59_regen = self:GetSectSpecialValueFor("59", "n_59_regen")
	self.n_60_chance = self:GetSectSpecialValueFor("60", "n_60_chance")
	self.n_60_poison = self:GetSectSpecialValueFor("60", "n_60_poison")
	self.n_61_chance = self:GetSectSpecialValueFor("61", "n_61_chance")
	self.n_61_ice = self:GetSectSpecialValueFor("61", "n_61_ice")
	self.n_62_chance = self:GetSectSpecialValueFor("62", "n_62_chance")
	self.n_62_shield = self:GetSectSpecialValueFor("62", "n_62_shield")
	self.n_63_chance = self:GetSectSpecialValueFor("63", "n_63_chance")
	self.n_63_injury = self:GetSectSpecialValueFor("63", "n_63_injury")
	self.n_64_regen_reduce = self:GetSectSpecialValueFor("64", "n_64_regen_reduce")
	self.r_67_chance = self:GetSectSpecialValueFor("67", "r_67_chance")
	self.r_67_damage = self:GetSectSpecialValueFor("67", "r_67_damage")
	self.r_68_damage = self:GetSectSpecialValueFor("68", "r_68_damage")
	self.r_68_health = self:GetSectSpecialValueFor("68", "r_68_health")
	self.r_69_interval = self:GetSectSpecialValueFor("69", "r_69_interval")
	self.r_69_extra_regen = self:GetSectSpecialValueFor("69", "r_69_extra_regen")
	self.r_69_regen = self:GetSectSpecialValueFor("69", "r_69_regen")
	self.n_126_chance = self:GetSectSpecialValueFor("126", "n_126_chance")
	self.n_126_fury = self:GetSectSpecialValueFor("126", "n_126_fury")
	self.sr_143_health_pct = self:GetSectSpecialValueFor("143", "sr_143_health_pct")
	self.sr_143_duration = self:GetSectSpecialValueFor("143", "sr_143_duration")
	self.sr_162_damage_pct = self:GetSectSpecialValueFor("162", "sr_162_damage_pct")
	self.sr_162_chance = self:GetSectSpecialValueFor("162", "sr_162_chance")
	self.sr_162_win_regen = self:GetSectSpecialValueFor("162", "sr_162_win_regen")
	self.n_172_chance = self:GetSectSpecialValueFor("172", "n_172_chance")
	self.n_172_chaos_count = self:GetSectSpecialValueFor("172", "n_172_chaos_count")
	self.sr_192_interval = self:GetSectSpecialValueFor("192", "sr_192_interval")
end
function n.prototype.TriggerByName(self, o, p)
	if p == nil then
		p = self:GetCaster():GetEnemy()
	end
	local q = self:GetCaster()
	if not IsInjurable(p, q) then
		return
	end
	repeat
		local r = o
		local s = r == "59"
		if s then
			do
				Heal(q, self.n_59_regen, "59", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "69"
		if s then
			do
				Heal(q, self.r_69_regen, "69", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "60"
		if s then
			do
				AddPoison(q, p, self.n_60_poison, "60", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "61"
		if s then
			do
				AddIce(q, p, self.n_61_ice, "61", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "62"
		if s then
			do
				AddShield(q, self.n_62_shield, "62", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "63"
		if s then
			do
				AddInjury(q, p, self.n_63_injury, "63", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "67"
		if s then
			do
				do
					local t = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_dazzle/dazzle_shadow_wave.vpcf",
						PATTACH_CUSTOMORIGIN,
						q
					)
					ParticleManager:SetParticleControlEnt(
						t,
						0,
						q,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						q:GetAbsOrigin(),
						false
					)
					ParticleManager:SetParticleControlEnt(
						t,
						1,
						p,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						p:GetAbsOrigin(),
						false
					)
					q:EmitSound("Hero_Dazzle.Shadow_Wave")
					q:GameTimer(0.25, function()
						if IsValid(self) and IsInjurable(p) then
							q:DealDamage(p, self, self.r_67_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "67")
						end
					end)
				end
				break
			end
		end
		s = s or r == "68"
		if s then
			do
				local t = ParticleManager:CreateParticle("particles/sect/sect_regen_68.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(t, 0, p:GetAbsOrigin())
				ParticleManager:SetParticleControl(t, 3, p:GetAbsOrigin())
				q:GameTimer(0.25, function()
					if IsValid(self) and IsInjurable(p) then
						q:DealDamage(p, self, self.r_68_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, nil, "68")
					end
				end)
				break
			end
		end
		s = s or r == "126"
		if s then
			do
				AddFury(q, self.n_126_fury, "126", "AbilityUpgrade")
				break
			end
		end
		s = s or r == "162"
		if s then
			do
				local u = q:FindModifierByName("modifier_sect_regen_162")
				if IsValid(u) then
					local v = u.regenRecord
					local w = v * self.sr_162_damage_pct * 0.01
					if w > 0 then
						DamageSystem:dealDamage({
							attacker = q,
							target = p,
							ability = self,
							ability_upgrade = "162",
							damage = w,
							damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
							damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
							damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						})
					end
				end
				break
			end
		end
		s = s or r == "172"
		if s then
			do
				AddChaos(q, GetSectChaosModifiedValue(q, self.n_172_chaos_count), "172", "AbilityUpgrade")
				break
			end
		end
	until true
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_regen"
end
n = e({ j(nil) }, n)
g.sect_regen = n
g.modifier_sect_regen = c()
local x = g.modifier_sect_regen
x.name = "modifier_sect_regen"
d(x, l)
function x.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_59_timer = 0
	self.r_69_timer = 0
	self.r_68_damage_record = 0
	self.sr_143_enable = false
end
function x.prototype.GetAbilitySpecialValue(self)
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.n_59_interval = self:GetSectSpecialValueFor("59", "n_59_interval")
	self.n_60_chance = self:GetSectSpecialValueFor("60", "n_60_chance")
	self.n_61_chance = self:GetSectSpecialValueFor("61", "n_61_chance")
	self.n_62_chance = self:GetSectSpecialValueFor("62", "n_62_chance")
	self.n_63_chance = self:GetSectSpecialValueFor("63", "n_63_chance")
	self.n_64_regen_reduce = self:GetSectSpecialValueFor("64", "n_64_regen_reduce")
	self.r_67_chance = self:GetSectSpecialValueFor("67", "r_67_chance")
	self.r_67_damage = self:GetSectSpecialValueFor("67", "r_67_damage")
	self.r_68_damage = self:GetSectSpecialValueFor("68", "r_68_damage")
	self.r_68_health = self:GetSectSpecialValueFor("68", "r_68_health")
	self.r_69_interval = self:GetSectSpecialValueFor("69", "r_69_interval")
	self.r_69_extra_regen = self:GetSectSpecialValueFor("69", "r_69_extra_regen")
	self.r_69_regen = self:GetSectSpecialValueFor("69", "r_69_regen")
	self.n_126_chance = self:GetSectSpecialValueFor("126", "n_126_chance")
	self.n_126_fury = self:GetSectSpecialValueFor("126", "n_126_fury")
	self.sr_143_health_pct = self:GetSectSpecialValueFor("143", "sr_143_health_pct")
	self.sr_143_duration = self:GetSectSpecialValueFor("143", "sr_143_duration")
	self.sr_162_damage_pct = self:GetSectSpecialValueFor("162", "sr_162_damage_pct")
	self.sr_162_chance = self:GetSectSpecialValueFor("162", "sr_162_chance")
	self.sr_162_win_regen = self:GetSectSpecialValueFor("162", "sr_162_win_regen")
	self.n_172_chance = self:GetSectSpecialValueFor("172", "n_172_chance")
	self.n_172_chaos_count = self:GetSectSpecialValueFor("172", "n_172_chaos_count")
	self.sr_192_interval = self:GetSectSpecialValueFor("192", "sr_192_interval")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_regen_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_regen_effect", "value")
	self.ability:GetAbilitySpecialValue()
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function x.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS] = self.regen + self.r_69_extra_regen }
end
function x.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_AVOID_DAMAGE }
end
function x.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function x.prototype.EOM_GetModifierIgnoreAvoidDamage(self)
	if self.sr_143_health_pct > 0 and self.sr_143_enable then
		return 1
	end
	return 0
end
function x.prototype.EOM_GetModifierMinHealth(self, y)
	if not self.sr_143_enable or self.sr_143_health_pct == 0 then
		return 0
	end
	local z = self:GetParent()
	if z:GetHealth() - y.damage <= z:GetMaxHealth() * self.sr_143_health_pct * 0.01 then
		z:AddNewModifier(z, self:GetAbility(), "modifier_sect_regen_143", { duration = self.sr_143_duration })
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_oracle/oracle_false_promise_cast_enemy.vpcf",
			PATTACH_ABSORIGIN,
			z
		)
		z:EmitSound("Hero_Oracle.FalsePromise.Cast")
		CombatLog:recordSectAbilityCast(z, "143")
		self.sr_143_enable = false
	end
	return 1
end
function x.prototype.OnHeal(self, y)
	local q = self:GetParent()
	self:n_60()
	self:n_61()
	self:n_126()
	self:n_62()
	self:n_63()
	self:n_172()
	if self.r_67_chance > 0 and self:PRD(self.r_67_chance, "r_67_chance") then
		self.ability:TriggerByName("67")
	end
	if self.r_68_health > 0 then
		self.r_68_damage_record = self.r_68_damage_record + y.flHealAmount
		if self.r_68_damage_record >= self.r_68_health then
			self.r_68_damage_record = self.r_68_damage_record - self.r_68_health
			self.ability:TriggerByName("68")
		end
	end
	if self.sr_162_chance > 0 and bit.band(y.flag, HealFlags.HEAL_FLAG_RAIN) ~= HealFlags.HEAL_FLAG_RAIN then
		q:GameTimer(0.25, function()
			if IsInjurable(q) and self:PRD(self.sr_162_chance, "sr_162_chance") then
				Heal(
					q,
					y.flHealAmount,
					"162",
					"AbilityUpgrade",
					true,
					HealFlags.HEAL_FLAG_RAIN + HealFlags.HEAL_FLAG_IGNORE_ADJUST
				)
			end
		end)
	end
	self:customAbilityTrigger()
end
function x.prototype.GetHealAbility(self, A)
	local B = 0
	do
		local C = 0
		while C < A do
			B = math.floor(math.random() * 6)
			repeat
				local D = B
				local E = D == 0
				if E then
					self:n_60()
					break
				end
				E = E or D == 1
				if E then
					self:n_61()
					break
				end
				E = E or D == 2
				if E then
					self:n_62()
					break
				end
				E = E or D == 3
				if E then
					self:n_63()
					break
				end
				E = E or D == 4
				if E then
					self:n_126()
					break
				end
				E = E or D == 5
				if E then
					self:n_172()
					break
				end
			until true
			C = C + 1
		end
	end
end
function x.prototype.n_60(self)
	if self.n_60_chance > 0 and self:PRD(self.n_60_chance, "n_60_chance") then
		self.ability:TriggerByName("60")
	end
end
function x.prototype.n_61(self)
	if self.n_61_chance > 0 and self:PRD(self.n_61_chance, "n_61_chance") then
		self.ability:TriggerByName("61")
	end
end
function x.prototype.n_62(self)
	if self.n_62_chance > 0 and self:PRD(self.n_62_chance, "n_62_chance") then
		self.ability:TriggerByName("62")
	end
end
function x.prototype.n_126(self)
	if self.n_126_chance > 0 and self:PRD(self.n_126_chance, "n_126_chance") then
		self.ability:TriggerByName("126")
	end
end
function x.prototype.n_63(self)
	if self.n_63_chance > 0 and self:PRD(self.n_63_chance, "n_63_chance") then
		self.ability:TriggerByName("63")
	end
end
function x.prototype.n_172(self)
	if self.n_172_chance > 0 and self:PRD(self.n_172_chance, "n_172_chance") then
		self.ability:TriggerByName("172")
	end
end
function x.prototype.OnBattleStartBefore(self, y)
	local z = self:GetParent()
	local F = z:GetEnemy()
	self.n_59_timer = 0
	self.r_69_timer = 0
	self.r_68_damage_record = 0
	self.sr_143_enable = true
	if self.n_64_regen_reduce > 0 then
		if IsInjurable(F) then
			F:AddNewModifier(
				z,
				self:GetAbility(),
				"modifier_sect_regen_64_debuff",
				{ iStackCount = self.n_64_regen_reduce }
			)
		end
	end
	if self.sr_162_damage_pct > 0 then
		z:AddNewModifier(z, self:GetAbility(), "modifier_sect_regen_162", nil)
	end
end
function x.prototype.OnBattleStart(self, y)
	if IsServer() then
		self:StartIntervalThink(self.timerInterval)
		local z = self:GetParent()
		if self.r_69_regen > 0 then
			if self.r_69_particle then
				ParticleManager:DestroyParticle(self.r_69_particle, false)
			end
			local t = ParticleManager:CreateParticle(
				"particles/econ/items/witch_doctor/wd_ti10_immortal_weapon/wd_ti10_immortal_voodoo.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(t, 0, z:GetAbsOrigin())
			ParticleManager:SetParticleControl(t, 1, Vector(400, 0, 0))
			ParticleManager:SetParticleControlEnt(
				t,
				2,
				z,
				PATTACH_POINT_FOLLOW,
				"attach_attack1",
				z:GetAbsOrigin(),
				false
			)
			self:AddParticle(t, false, false, -1, false, false)
			self.r_69_particle = t
		end
		if self.sr_192_interval > 0 then
			z:AddNewModifier(z, self:GetAbility(), "modifier_regen_192_buff", nil)
		end
	end
end
function x.prototype.OnBattleEnd(self, y)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StartThink(-1, "sr_143_interval")
		if self.r_69_particle then
			ParticleManager:DestroyParticle(self.r_69_particle, false)
			self.r_69_particle = nil
		end
		if self.sr_70_particle then
			ParticleManager:DestroyParticle(self.sr_70_particle, false)
			self.sr_70_particle = nil
		end
		if self.sr_162_win_regen > 0 and not y.isNeutral then
			local G = self:GetParent():GetPlayerOwnerID()
			if y.winPlayerID == G then
				local H = PlayerData:loadData(G, "sr_162")
				if H == nil then
					H = 0
				end
				local I = H
				PlayerData:saveData(G, "sr_162", I + self.sr_162_win_regen)
			end
		end
	end
end
function x.prototype.OnIntervalThink(self)
	local z = self:GetParent()
	local J = z:GetEnemy()
	if not IsInjurable(J) then
		self:StartIntervalThink(-1)
		return
	end
	if self.n_59_interval > 0 then
		self.n_59_timer = self.n_59_timer + self.timerInterval
		if self.n_59_timer >= self.n_59_interval then
			self.n_59_timer = self.n_59_timer - self.n_59_interval
			self.ability:TriggerByName("59")
		end
	end
	if self.r_69_interval > 0 then
		self.r_69_timer = self.r_69_timer + self.timerInterval
		if self.r_69_timer >= self.r_69_interval then
			self.r_69_timer = self.r_69_timer - self.r_69_interval
			self.ability:TriggerByName("69")
		end
	end
end
function x.prototype.OnThink(self, K)
	local z = self:GetParent()
	local J = z:GetEnemy()
	if not IsInjurable(J) then
		self:StartThink(-1, K)
		return
	end
end
function x.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_regen" then
		return
	end
	if self.trigger_chance > 0 then
		if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
			local L = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if L ~= nil then
				L:customAbilityEffect()
			end
		end
	end
end
function x.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local M = Heal
	local N = self:GetParent()
	local O = self.effect_value
	local P = self:GetAbility()
	M(N, O, P and P:GetAbilityName() or "", "Sect")
end
x = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	x
)
g.modifier_sect_regen = x
g.modifier_sect_regen_64_debuff = c()
local Q = g.modifier_sect_regen_64_debuff
Q.name = "modifier_sect_regen_64_debuff"
d(Q, l)
function Q.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount(y.iStackCount)
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_HEAL_PERCENTAGE }
end
function Q.prototype.EOM_GetModifierIgnoreHealPercent(self, y)
	return self:GetStackCount()
end
Q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Q
)
g.modifier_sect_regen_64_debuff = Q
g.modifier_sect_regen_143 = c()
local R = g.modifier_sect_regen_143
R.name = "modifier_sect_regen_143"
d(R, l)
function R.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.damageRecord = 0
	self.beforeHealHP = 1
	self.invulnerable = true
end
function R.prototype.GetAbilitySpecialValue(self)
	self.sr_143_multi = self:GetSectSpecialValueFor("143", "sr_143_multi")
end
function R.prototype.OnCreated(self, y)
	if IsClient() then
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_oracle/oracle_false_promise.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		self:AddParticle(t, false, false, -1, false, false)
	end
end
function R.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent()
		local S = q:GetEnemy()
		local T = self:GetAbility()
		self.invulnerable = false
		local w = self.damageRecord
		if IsInjurable(q, S) then
			if w > 0 then
				q:EmitSound("Hero_Oracle.FalsePromise.Damaged")
				S:DealDamage(
					q,
					T,
					w,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					DamageFlags.DAMAGE_FLAG_HPLOSS
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING,
					"143"
				)
				ParticleManager:CreateParticle(
					"particles/units/heroes/hero_oracle/oracle_false_promise_dmg.vpcf",
					PATTACH_ABSORIGIN,
					q
				)
			elseif w < 0 then
				q:EmitSound("Hero_Oracle.FalsePromise.Healed")
				Heal(q, -w, "143", "AbilityUpgrade", true, HealFlags.HEAL_FLAG_IGNORE_ADJUST)
				ParticleManager:CreateParticle(
					"particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf",
					PATTACH_ABSORIGIN,
					q
				)
			end
		end
	end
end
function R.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_AVOID_DAMAGE,
	}
end
function R.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function R.prototype.EOM_GetModifierIgnoreAvoidDamage(self)
	if self.invulnerable then
		return 1
	end
end
function R.prototype.EOM_GetModifierMinHealth(self, y)
	if self.invulnerable then
		return self:GetParent():GetHealth()
	end
end
function R.prototype.EOM_GetModifierHealAmplity(self, y)
	if self.invulnerable then
		self.beforeHealHP = self:GetParent():GetHealth()
	end
end
function R.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 },
	}
end
function R.prototype.OnCustomTakeDamage(self, U)
	if self.invulnerable then
		self.damageRecord = self.damageRecord + U.damage
	end
end
function R.prototype.OnHeal(self, y)
	if self.invulnerable then
		self.damageRecord = self.damageRecord - y.flHealAmount * self.sr_143_multi * 0.01
		self:GetParent():SetHealth(self.beforeHealHP)
	end
end
R = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	R
)
g.modifier_sect_regen_143 = R
g.modifier_sect_regen_162 = c()
local V = g.modifier_sect_regen_162
V.name = "modifier_sect_regen_162"
d(V, l)
function V.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 1
	self.inited = false
	self.regenRecord = 0
end
function V.prototype.GetAbilitySpecialValue(self)
	self.sr_162_damage_pct = self:GetSectSpecialValueFor("162", "sr_162_damage_pct")
end
function V.prototype.OnCreated(self, y)
	if IsServer() then
		local q = self:GetParent()
		q:EmitSound("Hero_Necrolyte.SpiritForm.Cast")
		local W = self.SetStackCount
		local X = PlayerData:loadData(q:GetPlayerOwnerID(), "sr_162")
		if X == nil then
			X = 0
		end
		W(self, X)
		self:StartIntervalThink(0)
	end
end
function V.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Necrolyte.SpiritForm.Cast")
	end
end
function V.prototype.OnIntervalThink(self)
	if IsServer() then
		if not self.inited then
			self.inited = true
			self:StartIntervalThink(self.tick)
			return
		end
		local q = self:GetParent()
		local p = q:GetEnemy()
		if not IsInjurable(q, p) then
			self:Destroy()
			return
		end
		self.ability:TriggerByName("162")
		self.regenRecord = 0
	end
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS }
end
function V.prototype.EOM_GetModifierHeal_Bonus(self, y)
	return self:GetStackCount()
end
function V.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent() } }
end
function V.prototype.OnHeal(self, y)
	if self.inited then
		self.regenRecord = self.regenRecord + y.flHealAmount
	end
end
V = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/econ/items/necrolyte/necro_ti9_immortal/necro_ti9_immortal_shroud.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	V
)
g.modifier_sect_regen_162 = V
g.modifier_regen_192_buff = c()
local Y = g.modifier_regen_192_buff
Y.name = "modifier_regen_192_buff"
d(Y, l)
function Y.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 1
	self.inited = false
end
function Y.prototype.GetAbilitySpecialValue(self)
	self.sr_192_interval = self:GetSectSpecialValueFor("192", "sr_192_interval")
	self.sr_192_damage = self:GetSectSpecialValueFor("192", "sr_192_damage")
end
function Y.prototype.OnCreated(self, y)
	if IsServer() then
		self.damageBonus = 0
		self.totalRegen = 0
		self.regenRecord = 0
		self.enable = true
		local q = self:GetParent()
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_oracle/oracle_scepter_rain_of_destiny.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(t, 0, q:GetAbsOrigin())
		ParticleManager:SetParticleControl(t, 1, Vector(350, 350, 0))
		self:AddParticle(t, false, false, -1, false, false)
		self:StartIntervalThink(self.sr_192_interval)
	end
end
function Y.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function Y.prototype.OnIntervalThink(self)
	if IsServer() then
		self.damageBonus = self.regenRecord * self.sr_192_damage * 0.01
		self.regenRecord = 0
	end
end
function Y.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function Y.prototype.EOM_GetModifierMinHealth(self, y)
	if not self.enable then
		return
	end
	local q = self:GetParent()
	if q:GetHealth() - y.damage <= q:GetMaxHealth() * BUFF_VALUE.RainOfDestinyThreshold * 0.01 then
		self.enable = false
		local p = q:GetEnemy()
		CombatLog:recordSectAbilityCast(q, "192")
		if IsInjurable(q, p) then
			local t = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_oracle/oracle_fortune_cast_tgt.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				q
			)
			ParticleManager:SetParticleControlEnt(
				t,
				1,
				q,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				q:GetAbsOrigin(),
				true
			)
			p:EmitSound("Hero_Oracle.FortunesEnd.Target")
			if self.totalRegen > 0 then
				Heal(q, self.totalRegen * BUFF_VALUE.RainOfDestinyRegen * 0.01, "192", "AbilityUpgrade")
				q:DealDamage(
					p,
					self:GetAbility(),
					self.totalRegen * BUFF_VALUE.RainOfDestinyDamage * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					DamageFlags.DAMAGE_FLAG_REFLECTION
						+ DamageFlags.DAMAGE_FLAG_HPLOSS
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
					"192"
				)
			end
		end
		self:Destroy()
	end
	return 1
end
function Y.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
	}
end
function Y.prototype.OnHeal(self, y)
	self.regenRecord = self.regenRecord + y.flHealAmount
	self.totalRegen = self.totalRegen + y.flHealAmount
end
function Y.prototype.OnCustomAttackLanded(self, U)
	if self.damageBonus > 0 then
		if IsInjurable(U.attacker, U.target) then
			U.attacker:DealDamage(
				U.target,
				self:GetAbility(),
				self.damageBonus,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				DamageFlags.DAMAGE_FLAG_REFLECTION
					+ DamageFlags.DAMAGE_FLAG_HPLOSS
					+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
				"192"
			)
			self.damageBonus = 0
		end
	end
end
Y = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Y
)
g.modifier_regen_192_buff = Y
return g