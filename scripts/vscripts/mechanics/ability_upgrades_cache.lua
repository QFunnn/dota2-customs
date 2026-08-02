--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/ability_upgrades_cache"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__Number
local g = b.__TS__StringReplace
local h = b.__TS__ArraySplice
local i = b.__TS__StringSplit
local j = b.__TS__ArrayForEach
local k = b.__TS__NumberIsFinite
local l = b.__TS__DecorateLegacy
local m = b.__TS__New
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 1,
		["17"] = 1,
		["18"] = 32,
		["19"] = 32,
		["20"] = 33,
		["22"] = 33,
		["23"] = 36,
		["24"] = 38,
		["25"] = 38,
		["26"] = 38,
		["27"] = 38,
		["28"] = 38,
		["29"] = 38,
		["30"] = 38,
		["31"] = 38,
		["32"] = 38,
		["33"] = 38,
		["34"] = 38,
		["35"] = 38,
		["36"] = 38,
		["37"] = 38,
		["38"] = 38,
		["39"] = 38,
		["40"] = 38,
		["41"] = 38,
		["42"] = 38,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 67,
		["47"] = 73,
		["48"] = 73,
		["49"] = 73,
		["50"] = 73,
		["51"] = 73,
		["52"] = 73,
		["53"] = 73,
		["54"] = 73,
		["55"] = 73,
		["56"] = 73,
		["57"] = 73,
		["58"] = 73,
		["59"] = 73,
		["60"] = 73,
		["61"] = 73,
		["62"] = 73,
		["63"] = 73,
		["64"] = 73,
		["65"] = 73,
		["66"] = 73,
		["67"] = 73,
		["68"] = 94,
		["69"] = 94,
		["70"] = 94,
		["71"] = 94,
		["72"] = 94,
		["73"] = 94,
		["74"] = 94,
		["75"] = 94,
		["76"] = 94,
		["77"] = 94,
		["78"] = 94,
		["79"] = 94,
		["80"] = 94,
		["81"] = 94,
		["82"] = 94,
		["83"] = 94,
		["84"] = 32,
		["85"] = 110,
		["86"] = 111,
		["87"] = 112,
		["88"] = 113,
		["89"] = 114,
		["91"] = 118,
		["92"] = 119,
		["93"] = 120,
		["94"] = 121,
		["95"] = 122,
		["96"] = 123,
		["97"] = 124,
		["98"] = 125,
		["100"] = 127,
		["101"] = 128,
		["103"] = 130,
		["104"] = 131,
		["105"] = 132,
		["106"] = 133,
		["107"] = 134,
		["108"] = 135,
		["109"] = 136,
		["110"] = 137,
		["111"] = 138,
		["112"] = 139,
		["113"] = 140,
		["115"] = 144,
		["120"] = 151,
		["121"] = 152,
		["122"] = 153,
		["123"] = 154,
		["124"] = 155,
		["125"] = 156,
		["127"] = 158,
		["131"] = 162,
		["132"] = 163,
		["137"] = 168,
		["138"] = 169,
		["139"] = 170,
		["140"] = 171,
		["142"] = 173,
		["145"] = 177,
		["146"] = 177,
		["147"] = 177,
		["148"] = 177,
		["149"] = 177,
		["151"] = 179,
		["152"] = 180,
		["155"] = 110,
		["156"] = 185,
		["157"] = 186,
		["158"] = 187,
		["159"] = 188,
		["160"] = 189,
		["161"] = 190,
		["162"] = 191,
		["164"] = 193,
		["165"] = 194,
		["168"] = 197,
		["169"] = 198,
		["172"] = 185,
		["173"] = 203,
		["174"] = 204,
		["175"] = 207,
		["176"] = 208,
		["177"] = 209,
		["178"] = 210,
		["180"] = 213,
		["181"] = 214,
		["183"] = 216,
		["184"] = 203,
		["185"] = 220,
		["186"] = 221,
		["187"] = 223,
		["188"] = 224,
		["189"] = 225,
		["190"] = 226,
		["191"] = 227,
		["192"] = 228,
		["195"] = 232,
		["196"] = 233,
		["197"] = 234,
		["198"] = 234,
		["199"] = 234,
		["200"] = 234,
		["201"] = 234,
		["202"] = 235,
		["203"] = 235,
		["204"] = 235,
		["205"] = 235,
		["206"] = 235,
		["208"] = 237,
		["209"] = 238,
		["210"] = 239,
		["211"] = 240,
		["212"] = 240,
		["213"] = 240,
		["214"] = 240,
		["215"] = 240,
		["216"] = 241,
		["217"] = 242,
		["218"] = 242,
		["219"] = 242,
		["220"] = 242,
		["221"] = 242,
		["224"] = 220,
		["225"] = 248,
		["226"] = 249,
		["227"] = 251,
		["228"] = 252,
		["229"] = 253,
		["230"] = 253,
		["231"] = 253,
		["232"] = 253,
		["233"] = 253,
		["234"] = 253,
		["235"] = 253,
		["237"] = 255,
		["238"] = 248,
		["239"] = 259,
		["240"] = 260,
		["241"] = 262,
		["242"] = 263,
		["243"] = 264,
		["244"] = 264,
		["245"] = 264,
		["246"] = 264,
		["247"] = 264,
		["248"] = 264,
		["249"] = 264,
		["251"] = 266,
		["252"] = 259,
		["253"] = 269,
		["254"] = 270,
		["257"] = 272,
		["258"] = 273,
		["259"] = 274,
		["260"] = 275,
		["262"] = 277,
		["263"] = 278,
		["265"] = 280,
		["266"] = 281,
		["267"] = 282,
		["268"] = 282,
		["269"] = 282,
		["270"] = 282,
		["271"] = 283,
		["274"] = 286,
		["275"] = 287,
		["277"] = 289,
		["280"] = 292,
		["281"] = 269,
		["282"] = 308,
		["283"] = 309,
		["284"] = 310,
		["285"] = 310,
		["287"] = 311,
		["288"] = 311,
		["290"] = 312,
		["291"] = 312,
		["293"] = 313,
		["294"] = 313,
		["296"] = 314,
		["297"] = 314,
		["299"] = 316,
		["300"] = 318,
		["301"] = 319,
		["302"] = 321,
		["303"] = 321,
		["304"] = 322,
		["305"] = 322,
		["306"] = 324,
		["307"] = 324,
		["308"] = 324,
		["309"] = 324,
		["310"] = 324,
		["311"] = 324,
		["312"] = 324,
		["313"] = 326,
		["314"] = 328,
		["315"] = 308,
		["316"] = 331,
		["317"] = 332,
		["318"] = 333,
		["319"] = 333,
		["321"] = 334,
		["322"] = 334,
		["324"] = 335,
		["325"] = 335,
		["327"] = 336,
		["328"] = 336,
		["330"] = 337,
		["331"] = 337,
		["333"] = 339,
		["334"] = 341,
		["335"] = 342,
		["336"] = 343,
		["337"] = 344,
		["338"] = 345,
		["339"] = 346,
		["340"] = 347,
		["341"] = 348,
		["345"] = 353,
		["346"] = 353,
		["347"] = 353,
		["348"] = 353,
		["349"] = 353,
		["350"] = 353,
		["351"] = 353,
		["352"] = 355,
		["353"] = 357,
		["354"] = 331,
		["355"] = 360,
		["356"] = 361,
		["357"] = 362,
		["358"] = 362,
		["360"] = 363,
		["361"] = 364,
		["362"] = 365,
		["363"] = 365,
		["365"] = 366,
		["366"] = 366,
		["368"] = 367,
		["369"] = 367,
		["371"] = 368,
		["372"] = 368,
		["374"] = 369,
		["375"] = 369,
		["377"] = 371,
		["378"] = 372,
		["379"] = 373,
		["380"] = 375,
		["381"] = 375,
		["382"] = 375,
		["383"] = 375,
		["384"] = 375,
		["385"] = 375,
		["386"] = 375,
		["387"] = 377,
		["388"] = 379,
		["389"] = 360,
		["390"] = 381,
		["391"] = 382,
		["392"] = 384,
		["393"] = 384,
		["395"] = 385,
		["396"] = 385,
		["398"] = 387,
		["399"] = 389,
		["400"] = 391,
		["401"] = 392,
		["402"] = 393,
		["403"] = 394,
		["404"] = 395,
		["405"] = 396,
		["406"] = 397,
		["407"] = 398,
		["411"] = 402,
		["412"] = 381,
		["413"] = 404,
		["414"] = 405,
		["415"] = 405,
		["417"] = 406,
		["418"] = 406,
		["419"] = 406,
		["420"] = 406,
		["421"] = 406,
		["422"] = 404,
		["423"] = 408,
		["424"] = 409,
		["425"] = 408,
		["426"] = 426,
		["427"] = 427,
		["428"] = 428,
		["429"] = 428,
		["431"] = 429,
		["432"] = 429,
		["434"] = 430,
		["435"] = 430,
		["437"] = 431,
		["438"] = 431,
		["440"] = 432,
		["441"] = 432,
		["443"] = 433,
		["444"] = 433,
		["446"] = 435,
		["447"] = 437,
		["448"] = 438,
		["449"] = 440,
		["450"] = 440,
		["451"] = 441,
		["452"] = 441,
		["453"] = 443,
		["454"] = 443,
		["455"] = 443,
		["456"] = 443,
		["457"] = 443,
		["458"] = 443,
		["459"] = 443,
		["460"] = 443,
		["461"] = 445,
		["462"] = 447,
		["463"] = 426,
		["464"] = 450,
		["465"] = 451,
		["466"] = 452,
		["467"] = 452,
		["469"] = 453,
		["470"] = 453,
		["472"] = 454,
		["473"] = 454,
		["475"] = 455,
		["476"] = 455,
		["478"] = 456,
		["479"] = 456,
		["481"] = 457,
		["482"] = 457,
		["484"] = 459,
		["485"] = 461,
		["486"] = 462,
		["487"] = 463,
		["488"] = 464,
		["489"] = 465,
		["490"] = 466,
		["491"] = 467,
		["492"] = 468,
		["496"] = 473,
		["497"] = 473,
		["498"] = 473,
		["499"] = 473,
		["500"] = 473,
		["501"] = 473,
		["502"] = 473,
		["503"] = 473,
		["504"] = 475,
		["505"] = 477,
		["506"] = 450,
		["507"] = 480,
		["508"] = 481,
		["509"] = 482,
		["510"] = 482,
		["512"] = 483,
		["513"] = 484,
		["514"] = 485,
		["515"] = 485,
		["517"] = 486,
		["518"] = 486,
		["520"] = 487,
		["521"] = 487,
		["523"] = 488,
		["524"] = 488,
		["526"] = 489,
		["527"] = 489,
		["529"] = 490,
		["530"] = 490,
		["532"] = 492,
		["533"] = 493,
		["534"] = 494,
		["535"] = 496,
		["536"] = 496,
		["537"] = 496,
		["538"] = 496,
		["539"] = 496,
		["540"] = 496,
		["541"] = 496,
		["542"] = 496,
		["543"] = 498,
		["544"] = 500,
		["545"] = 480,
		["546"] = 502,
		["547"] = 503,
		["548"] = 505,
		["549"] = 505,
		["551"] = 506,
		["552"] = 506,
		["554"] = 507,
		["555"] = 507,
		["557"] = 509,
		["558"] = 511,
		["559"] = 512,
		["560"] = 513,
		["561"] = 514,
		["562"] = 515,
		["563"] = 516,
		["564"] = 517,
		["565"] = 518,
		["566"] = 519,
		["570"] = 524,
		["571"] = 502,
		["572"] = 526,
		["573"] = 527,
		["574"] = 527,
		["576"] = 528,
		["577"] = 528,
		["578"] = 528,
		["579"] = 528,
		["580"] = 528,
		["581"] = 528,
		["582"] = 526,
		["583"] = 530,
		["584"] = 531,
		["585"] = 531,
		["586"] = 531,
		["587"] = 531,
		["588"] = 531,
		["589"] = 531,
		["590"] = 531,
		["591"] = 531,
		["592"] = 531,
		["593"] = 531,
		["594"] = 531,
		["595"] = 531,
		["596"] = 531,
		["597"] = 530,
		["598"] = 545,
		["599"] = 546,
		["600"] = 547,
		["601"] = 547,
		["603"] = 548,
		["604"] = 548,
		["606"] = 549,
		["607"] = 549,
		["609"] = 550,
		["610"] = 550,
		["612"] = 552,
		["613"] = 553,
		["614"] = 555,
		["615"] = 555,
		["616"] = 556,
		["617"] = 556,
		["618"] = 558,
		["619"] = 559,
		["620"] = 560,
		["621"] = 561,
		["622"] = 558,
		["623"] = 545,
		["624"] = 564,
		["625"] = 565,
		["626"] = 566,
		["627"] = 566,
		["629"] = 567,
		["630"] = 567,
		["632"] = 568,
		["633"] = 568,
		["635"] = 569,
		["636"] = 569,
		["638"] = 571,
		["639"] = 572,
		["640"] = 573,
		["641"] = 574,
		["642"] = 575,
		["643"] = 576,
		["644"] = 577,
		["645"] = 578,
		["649"] = 583,
		["650"] = 584,
		["651"] = 585,
		["652"] = 586,
		["653"] = 583,
		["654"] = 564,
		["655"] = 589,
		["656"] = 590,
		["657"] = 591,
		["658"] = 591,
		["660"] = 592,
		["661"] = 593,
		["662"] = 594,
		["663"] = 594,
		["665"] = 595,
		["666"] = 595,
		["668"] = 596,
		["669"] = 596,
		["671"] = 597,
		["672"] = 597,
		["674"] = 599,
		["675"] = 600,
		["676"] = 601,
		["677"] = 603,
		["678"] = 604,
		["679"] = 605,
		["680"] = 606,
		["681"] = 603,
		["682"] = 589,
		["683"] = 609,
		["684"] = 610,
		["685"] = 612,
		["686"] = 613,
		["687"] = 614,
		["688"] = 615,
		["690"] = 617,
		["691"] = 618,
		["692"] = 619,
		["693"] = 620,
		["694"] = 621,
		["695"] = 622,
		["697"] = 624,
		["701"] = 629,
		["702"] = 609,
		["703"] = 631,
		["704"] = 632,
		["705"] = 632,
		["707"] = 633,
		["708"] = 633,
		["709"] = 633,
		["710"] = 631,
		["711"] = 654,
		["712"] = 655,
		["713"] = 656,
		["714"] = 656,
		["716"] = 657,
		["717"] = 657,
		["719"] = 658,
		["720"] = 658,
		["722"] = 659,
		["723"] = 659,
		["725"] = 660,
		["726"] = 660,
		["728"] = 662,
		["729"] = 663,
		["730"] = 665,
		["731"] = 665,
		["732"] = 666,
		["733"] = 666,
		["734"] = 668,
		["735"] = 670,
		["736"] = 671,
		["737"] = 672,
		["738"] = 673,
		["740"] = 675,
		["741"] = 677,
		["742"] = 678,
		["743"] = 679,
		["744"] = 680,
		["745"] = 681,
		["746"] = 684,
		["747"] = 685,
		["748"] = 685,
		["749"] = 686,
		["750"] = 687,
		["751"] = 688,
		["752"] = 689,
		["753"] = 689,
		["754"] = 689,
		["755"] = 689,
		["757"] = 689,
		["758"] = 689,
		["759"] = 689,
		["760"] = 689,
		["762"] = 691,
		["763"] = 692,
		["764"] = 693,
		["765"] = 694,
		["766"] = 695,
		["767"] = 696,
		["768"] = 696,
		["769"] = 697,
		["770"] = 698,
		["771"] = 699,
		["772"] = 700,
		["773"] = 700,
		["774"] = 700,
		["775"] = 700,
		["777"] = 700,
		["778"] = 700,
		["779"] = 700,
		["780"] = 700,
		["784"] = 705,
		["788"] = 709,
		["791"] = 713,
		["792"] = 715,
		["793"] = 717,
		["794"] = 654,
		["795"] = 719,
		["796"] = 720,
		["797"] = 721,
		["798"] = 721,
		["800"] = 722,
		["801"] = 722,
		["803"] = 723,
		["804"] = 723,
		["806"] = 724,
		["807"] = 724,
		["809"] = 725,
		["810"] = 725,
		["812"] = 727,
		["813"] = 728,
		["814"] = 730,
		["815"] = 731,
		["816"] = 732,
		["817"] = 733,
		["818"] = 734,
		["819"] = 735,
		["823"] = 740,
		["824"] = 741,
		["825"] = 741,
		["826"] = 742,
		["828"] = 742,
		["830"] = 742,
		["832"] = 745,
		["833"] = 747,
		["834"] = 719,
		["835"] = 749,
		["836"] = 750,
		["837"] = 751,
		["838"] = 751,
		["840"] = 752,
		["841"] = 753,
		["842"] = 754,
		["843"] = 754,
		["845"] = 755,
		["846"] = 755,
		["848"] = 756,
		["849"] = 756,
		["851"] = 757,
		["852"] = 757,
		["854"] = 758,
		["855"] = 758,
		["857"] = 760,
		["858"] = 761,
		["859"] = 762,
		["860"] = 764,
		["861"] = 765,
		["862"] = 765,
		["863"] = 766,
		["865"] = 766,
		["867"] = 766,
		["869"] = 769,
		["870"] = 771,
		["871"] = 749,
		["872"] = 773,
		["873"] = 774,
		["874"] = 774,
		["876"] = 775,
		["877"] = 775,
		["878"] = 775,
		["879"] = 775,
		["880"] = 773,
		["881"] = 777,
		["882"] = 778,
		["885"] = 780,
		["886"] = 780,
		["887"] = 780,
		["888"] = 781,
		["889"] = 782,
		["890"] = 783,
		["891"] = 784,
		["892"] = 785,
		["893"] = 786,
		["898"] = 777,
		["899"] = 793,
		["900"] = 794,
		["903"] = 796,
		["904"] = 796,
		["905"] = 796,
		["906"] = 797,
		["907"] = 798,
		["908"] = 799,
		["909"] = 800,
		["910"] = 801,
		["911"] = 802,
		["912"] = 803,
		["913"] = 804,
		["914"] = 805,
		["915"] = 806,
		["916"] = 807,
		["917"] = 808,
		["918"] = 809,
		["919"] = 810,
		["921"] = 812,
		["928"] = 793,
		["929"] = 831,
		["930"] = 832,
		["931"] = 833,
		["932"] = 833,
		["934"] = 834,
		["935"] = 834,
		["937"] = 835,
		["938"] = 835,
		["940"] = 837,
		["941"] = 839,
		["942"] = 839,
		["944"] = 841,
		["945"] = 842,
		["946"] = 842,
		["948"] = 844,
		["949"] = 845,
		["950"] = 847,
		["951"] = 847,
		["952"] = 848,
		["953"] = 848,
		["954"] = 850,
		["955"] = 850,
		["956"] = 850,
		["957"] = 850,
		["958"] = 852,
		["959"] = 853,
		["960"] = 854,
		["961"] = 856,
		["962"] = 831,
		["963"] = 858,
		["964"] = 859,
		["965"] = 860,
		["966"] = 860,
		["968"] = 861,
		["969"] = 861,
		["971"] = 862,
		["972"] = 862,
		["974"] = 864,
		["975"] = 866,
		["976"] = 866,
		["978"] = 868,
		["979"] = 869,
		["980"] = 871,
		["981"] = 872,
		["982"] = 873,
		["983"] = 874,
		["984"] = 875,
		["985"] = 876,
		["989"] = 881,
		["990"] = 883,
		["991"] = 884,
		["992"] = 885,
		["993"] = 886,
		["994"] = 887,
		["997"] = 891,
		["998"] = 893,
		["999"] = 895,
		["1000"] = 858,
		["1001"] = 897,
		["1002"] = 898,
		["1003"] = 899,
		["1004"] = 899,
		["1006"] = 900,
		["1007"] = 901,
		["1008"] = 902,
		["1009"] = 902,
		["1011"] = 903,
		["1012"] = 903,
		["1014"] = 904,
		["1015"] = 904,
		["1017"] = 906,
		["1018"] = 908,
		["1019"] = 908,
		["1021"] = 910,
		["1022"] = 911,
		["1023"] = 912,
		["1024"] = 914,
		["1025"] = 916,
		["1026"] = 917,
		["1027"] = 918,
		["1028"] = 919,
		["1029"] = 920,
		["1032"] = 924,
		["1033"] = 926,
		["1034"] = 928,
		["1035"] = 897,
		["1036"] = 32,
		["1037"] = 936,
		["1038"] = 937,
	}
)
local o = {}
local p = require("lib.tstl-utils")
local q = p.reloadable
local r = c()
r.name = "CAbilityUpgrades_cache"
d(r, CModule)
function r.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.tClientAbilityUpgrades = {}
	self.ABILITY_UPGRADES_STATS_LIST = {
		"bonus_attack_damage",
		"base_attack_damage_pct",
		"bonus_attack_speed",
		"bonus_attack_range",
		"bonus_armor",
		"bonus_move_speed",
		"move_speed_pct",
		"bonus_mana",
		"bonus_mana_regen",
		"bonus_health",
		"bonus_health_regen",
		"max_health_regen_pct",
		"bonus_str",
		"bonus_agi",
		"bonus_int",
		"bonus_stats",
		"bonus_evasion",
		"bonus_cooldown_reduction",
		"bonus_status_resistance",
		"bonus_debuff_amplify",
	}
	self.ABILITY_UPGRADES_STATS_SETTLE = {
		bonus_evasion = SubtractionMultiplicationPercentage,
		bonus_cooldown_reduction = SubtractionMultiplicationPercentage,
		bonus_status_resistance = SubtractionMultiplicationPercentage,
		bonus_debuff_amplify = AdditionMultiplicationPercentage,
	}
	self.aPropertyNames = {
		"LinkedSpecialBonus",
		"LinkedSpecialBonusField",
		"LinkedSpecialBonusOperation",
		"CalculateSpellDamageTooltip",
		"RequiresScepter",
		"levelkey",
		"_str",
		"_int",
		"_agi",
		"_all",
		"_attack_damage",
		"_attack_speed",
		"_health",
		"_armor",
		"_magical_armor",
		"_mana",
		"_max",
		"_min",
		"_move_speed",
	}
	self.zip_list = {
		"type",
		"unit_name",
		"ability_name",
		"pre_ability_upgrade",
		"value",
		"special_value_name",
		"special_value_property",
		"operator",
		"values",
		"description",
		"level",
		"max_count",
		"key",
		"rarity",
	}
end
function r.prototype.init(self, s)
	if IsServer() then
		if not s then
			self.tAbilityUpgrades = {}
			self.tAbilityUpgradesIndexs = {}
		end
		self.tAbilityUpgradesList = {}
		if type(KeyValues.AbilityUpgradesKvs) == "table" then
			for t in pairs(KeyValues.AbilityUpgradesKvs) do
				local u = KeyValues.AbilityUpgradesKvs[t]
				local v = deepcopy(u)
				v.type = ABILITY_UPGRADES_TYPE[v.type]
				if v.operator ~= nil then
					v.operator = ABILITY_UPGRADES_OP[v.operator]
				end
				if type(v.value) == "number" then
					v.value = Round(v.value, 5)
				end
				local w = v.AbilitySpecial
				if type(w) == "table" then
					v.values = {}
					for x, y in pairs(w) do
						local z
						local A = true
						for B, C in pairs(y) do
							if TableFindKey(self.aPropertyNames, B) == nil and B ~= "var_type" then
								z = B
								if type(C) == "number" then
									v.values[z] = { value = Round(C, 5) }
								else
									v.values[z] = { value = C }
								end
								break
							end
						end
						if z then
							for B, C in pairs(y) do
								if TableFindKey(self.aPropertyNames, B) ~= nil then
									A = false
									if type(C) == "number" then
										v.values[z][B] = Round(C, 5)
									else
										v.values[z][B] = C
									end
								end
							end
							if A then
								v.values[z] = v.values[z].value
							end
						end
					end
				end
				v.AbilitySpecial = nil
				v.id = t
				if v.description ~= nil then
					v.description = tostring(v.description)
				end
				self.tAbilityUpgradesList[t] = v
			end
		end
		GameEvent("custom_entity_removed", function(D, E)
			return self:OnEntityRemoved(E)
		end, self)
	else
		if not s then
			self.tClientAbilityUpgrades = {}
		end
	end
end
function r.prototype.OnEntityRemoved(self, E)
	local F = E.entindex
	local G = EntIndexToHScript(F)
	if IsServer() then
		if self.tAbilityUpgrades[F] ~= nil then
			self:UpdateAbilityUpgradesNetTables(G)
			e(self.tAbilityUpgrades, F)
		end
		if self.tAbilityUpgradesIndexs[F] ~= nil then
			e(self.tAbilityUpgradesIndexs, F)
		end
	else
		if self.tClientAbilityUpgrades[F] ~= nil then
			e(self.tClientAbilityUpgrades, F)
		end
	end
end
function r.prototype.zip(self, H)
	local I = { self.zip_list }
	for D, u in ipairs(H) do
		local v = {}
		for J = 0, #self.zip_list - 1, 1 do
			v[J + 1] = u[self.zip_list[J + 1]]
		end
		v.n = #self.zip_list
		I[#I + 1] = v
	end
	return I
end
function r.prototype.UpdateAbilityUpgradesNetTables(self, G, H)
	assert(IsServer())
	local K = CustomNetTables:GetAllTableKeys("ability_upgrades_list")
	for L = #K - 1, 0, -1 do
		local F = f(K[L + 1])
		if not IsValid(EntIndexToHScript(F)) then
			CustomNetTables:SetTableValue("ability_upgrades_list", K[L + 1], nil)
			CustomNetTables:SetTableValue("ability_upgrades_result", K[L + 1], nil)
		end
	end
	if IsValid(G) then
		if H == nil then
			CustomNetTables:SetTableValue("ability_upgrades_list", tostring(G:entindex()), nil)
			CustomNetTables:SetTableValue("ability_upgrades_result", tostring(G:entindex()), nil)
		else
			local M = H[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
			local N = json.encode(self:zip(M))
			N = g(N, "null", "*")
			CustomNetTables:SetTableValue("ability_upgrades_list", tostring(G:entindex()), { json = N })
			local O = H[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1]
			CustomNetTables:SetTableValue("ability_upgrades_result", tostring(G:entindex()), { json = json.encode(O) })
		end
	end
end
function r.prototype.GetAbilityUpgradeTable(self, G)
	assert(IsServer())
	local F = G:entindex()
	if self.tAbilityUpgrades[F] == nil then
		self.tAbilityUpgrades[F] = { {}, { {}, {}, {}, {}, {} } }
	end
	return self.tAbilityUpgrades[F]
end
function r.prototype.GetAbilityUpgradeIndexs(self, G)
	assert(IsServer())
	local F = G:entindex()
	if self.tAbilityUpgradesIndexs[F] == nil then
		self.tAbilityUpgradesIndexs[F] = { {}, {}, {}, {}, {} }
	end
	return self.tAbilityUpgradesIndexs[F]
end
function r.prototype.GetCachedResult(self, G)
	if not IsValid(G) then
		return
	end
	local F = G:entindex()
	local O
	if IsServer() then
		O = self:GetAbilityUpgradeTable(G)[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1]
	else
		if self.tClientAbilityUpgrades[F] == nil then
			self.tClientAbilityUpgrades[F] = {}
		end
		if self.tClientAbilityUpgrades[F][GetFrameCount()] == nil then
			self.tClientAbilityUpgrades[F] = {}
			local v = CustomNetTables:GetTableValue("ability_upgrades_result", tostring(F))
			if (v and v.json) == nil then
				return
			end
			O = json.decode(v.json)
			self.tClientAbilityUpgrades[F][GetFrameCount()] = O
		else
			O = self.tClientAbilityUpgrades[F][GetFrameCount()]
		end
	end
	return O
end
function r.prototype.AddSpecialValueUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if H.special_value_name == nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	H.operator = H.operator or ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	local Q = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	Q[#Q + 1] = H
	local R = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1]
	R[#R + 1] = #M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	self:_UpdateSpecialValueUpgrades(M, P, H.ability_name, H.special_value_name, H.operator)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveSpecialValueUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if H.special_value_name == nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	H.operator = H.operator or ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and H.id == T.id then
			h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], S, 1)
			h(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1], L, 1)
			break
		end
	end
	self:_UpdateSpecialValueUpgrades(M, P, H.ability_name, H.special_value_name, H.operator)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveSpecialValueUpgradeByIndex(self, G, U)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local H = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][U + 1]
	if H == nil then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if H.special_value_name == nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], U, 1)
	local P = self:GetAbilityUpgradeIndexs(G)
	ArrayRemove(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1], U)
	self:_UpdateSpecialValueUpgrades(M, P, H.ability_name, H.special_value_name, H.operator)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype._UpdateSpecialValueUpgrades(self, M, P, V, W, X)
	local Y =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1]
	if Y[V] == nil then
		Y[V] = {}
	end
	if Y[V][W] == nil then
		Y[V][W] = {}
	end
	local Z = Y[V][W]
	local _ = 0
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and T.ability_name == V and T.ability_name == W and T.operator == X then
			if X == ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD then
				_ = _ + T.value
			elseif X == ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL then
				_ = AdditionMultiplicationPercentage(_, T.value)
			end
		end
	end
	Z[X] = _
end
function r.prototype.GetSpecialValueUpgrade(self, G, V, W, X)
	if not IsValid(G) then
		return 0
	end
	local a0 = self:GetCachedResult(G)
	local a1 = a0 and a0[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE + 1]
	local a2 = a1 and a1[V]
	local a3 = a2 and a2[W]
	return a3 and a3[X] or 0
end
function r.prototype.CalcSpecialValueUpgrade(self, G, V, W, a4)
	return (a4 + self:GetSpecialValueUpgrade(G, V, W, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD))
		* (1 + self:GetSpecialValueUpgrade(G, V, W, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL) * 0.01)
end
function r.prototype.AddSpecialValuePropertyUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if H.special_value_name == nil then
		return false
	end
	if H.special_value_property == nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	H.operator = H.operator or ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	local a5 = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	a5[#a5 + 1] = H
	local a6 = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1]
	a6[#a6 + 1] = #M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	self:_UpdateSpecialValuePropertyUpgrade(
		M,
		P,
		H.ability_name,
		H.special_value_name,
		H.special_value_property,
		H.operator
	)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveSpecialValuePropertyUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if H.special_value_name == nil then
		return false
	end
	if H.special_value_property == nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	H.operator = H.operator or ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and H.id == T.id then
			h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], S, 1)
			h(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1], L, 1)
			break
		end
	end
	self:_UpdateSpecialValuePropertyUpgrade(
		M,
		P,
		H.ability_name,
		H.special_value_name,
		H.special_value_property,
		H.operator
	)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveSpecialValuePropertyUpgradeByIndex(self, G, U)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local H = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][U + 1]
	if H == nil then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if H.special_value_name == nil then
		return false
	end
	if H.special_value_property == nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], U, 1)
	local P = self:GetAbilityUpgradeIndexs(G)
	ArrayRemove(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1], U)
	self:_UpdateSpecialValuePropertyUpgrade(
		M,
		P,
		H.ability_name,
		H.special_value_name,
		H.special_value_property,
		H.operator
	)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype._UpdateSpecialValuePropertyUpgrade(self, M, P, V, W, a7, X)
	local a8 =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1]
	if a8[V] == nil then
		a8[V] = {}
	end
	if a8[V][W] == nil then
		a8[V][W] = {}
	end
	if a8[V][W][a7] == nil then
		a8[V][W][a7] = {}
	end
	local a9 = a8[V][W][a7]
	local _ = 0
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if
			T ~= nil
			and T.ability_name == V
			and T.ability_name == W
			and T.special_value_property == a7
			and T.operator == X
		then
			if X == ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD then
				_ = _ + T.value
			elseif X == ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL then
				_ = AdditionMultiplicationPercentage(_, T.value)
			end
		end
	end
	a9[X] = _
end
function r.prototype.GetSpecialValuePropertyUpgrade(self, G, V, W, a7, X)
	if not IsValid(G) then
		return 0
	end
	local aa = self:GetCachedResult(G)
	local ab = aa and aa[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE_PROPERTY + 1]
	local ac = ab and ab[V]
	local ad = ac and ac[W]
	local ae = ad and ad[a7]
	return ae and ae[X] or 0
end
function r.prototype.CalcSpecialValuePropertyUpgrade(self, G, V, W, a7, a4)
	return (a4 + self:GetSpecialValuePropertyUpgrade(G, V, W, a7, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD))
		* (1 + self:GetSpecialValuePropertyUpgrade(G, V, W, a7, ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_MUL) * 0.01)
end
function r.prototype.AddStatsUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS then
		return false
	end
	if H.special_value_name == nil and TableFindKey(self.ABILITY_UPGRADES_STATS_LIST, H.special_value_name) ~= nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	local af = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	af[#af + 1] = H
	local ag = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1]
	ag[#ag + 1] = #M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	return G:BonusesChangedProc(function()
		self:_UpdateStatsUpgrade(M, P, H.special_value_name)
		self:UpdateAbilityUpgradesNetTables(G, M)
		return true
	end)
end
function r.prototype.RemoveStatsUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS then
		return false
	end
	if H.special_value_name == nil and TableFindKey(self.ABILITY_UPGRADES_STATS_LIST, H.special_value_name) ~= nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and H.id == T.id then
			h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], S, 1)
			h(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1], L, 1)
			break
		end
	end
	return G:BonusesChangedProc(function()
		self:_UpdateStatsUpgrade(M, P, H.special_value_name)
		self:UpdateAbilityUpgradesNetTables(G, M)
		return true
	end)
end
function r.prototype.RemoveStatsUpgradeByIndex(self, G, U)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local H = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][U + 1]
	if H == nil then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS then
		return false
	end
	if H.special_value_name == nil and TableFindKey(self.ABILITY_UPGRADES_STATS_LIST, H.special_value_name) ~= nil then
		return false
	end
	if H.value == nil or H.value == 0 then
		return false
	end
	h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], U, 1)
	local P = self:GetAbilityUpgradeIndexs(G)
	ArrayRemove(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1], U)
	return G:BonusesChangedProc(function()
		self:_UpdateStatsUpgrade(M, P, H.special_value_name)
		self:UpdateAbilityUpgradesNetTables(G, M)
		return true
	end)
end
function r.prototype._UpdateStatsUpgrade(self, M, P, W)
	local ah =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1]
	local ai = self.ABILITY_UPGRADES_STATS_SETTLE[W]
	local _ = 0
	if ai ~= nil then
		_ = ai(nil)
	end
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and T.special_value_name == W then
			if ai ~= nil then
				_ = ai(nil, _, T.value)
			else
				_ = _ + T.value
			end
		end
	end
	ah[W] = _
end
function r.prototype.GetStatsUpgrade(self, G, W)
	if not IsValid(G) then
		return 0
	end
	local aj = self:GetCachedResult(G)
	local ak = aj and aj[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_STATS + 1]
	return ak and ak[W] or 0
end
function r.prototype.AddAbilityMechanicsUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS then
		return false
	end
	if H.description == nil then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if self:HasAbilityMechanicsUpgrade(G, H.ability_name, H.description) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	local al = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	al[#al + 1] = H
	local am = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	am[#am + 1] = #M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	local an =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local V = H.ability_name
	local ao = H.description
	if an[V] == nil then
		an[V] = {}
	end
	local ap = an[V]
	local aq = {}
	if type(H.values) == "table" then
		for t in pairs(H.values) do
			local u = H.values[t]
			local v = { value = {} }
			if type(u) == "number" then
				local ar = v.value
				ar[#ar + 1] = u
			elseif type(u) == "string" then
				local as = i(u, " ")
				if #as > 0 then
					j(as, function(D, C)
						local at = v.value
						local au = #at + 1
						at[au] = toFiniteNumber(C)
						return au
					end)
				end
			elseif type(u) == "table" then
				for B in pairs(u) do
					local C = u[B]
					if B == "value" then
						if type(C) == "number" then
							local av = v.value
							av[#av + 1] = C
						elseif type(C) == "string" then
							local as = i(C, " ")
							if #as > 0 then
								j(as, function(D, aw)
									local ax = v.value
									local ay = #ax + 1
									ax[ay] = toFiniteNumber(aw)
									return ay
								end)
							end
						end
					else
						v[B] = C
					end
				end
			end
			aq[t] = v
		end
	end
	ap[ao] = aq
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveAbilityMechanicsUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS then
		return false
	end
	if H.description == nil then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if not self:HasAbilityMechanicsUpgrade(G, H.ability_name, H.description) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and H.id == T.id then
			h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], S, 1)
			h(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1], L, 1)
			break
		end
	end
	local an =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local az = an[H.ability_name]
	if (az and az[H.description]) ~= nil then
		local aA = an[H.ability_name]
		if aA ~= nil then
			e(aA, H.description)
		end
		local D = true
	end
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveAbilityMechanicsUpgradeByIndex(self, G, U)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local H = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][U + 1]
	if H == nil then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS then
		return false
	end
	if H.description == nil then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	if not self:HasAbilityMechanicsUpgrade(G, H.ability_name, H.description) then
		return false
	end
	h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], U, 1)
	local P = self:GetAbilityUpgradeIndexs(G)
	ArrayRemove(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1], U)
	local an =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local aB = an[H.ability_name]
	if (aB and aB[H.description]) ~= nil then
		local aC = an[H.ability_name]
		if aC ~= nil then
			e(aC, H.description)
		end
		local D = true
	end
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.HasAbilityMechanicsUpgrade(self, G, V, ao)
	if not IsValid(G) then
		return false
	end
	local aD = self:GetCachedResult(G)
	local aE = aD and aD[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local aF = aE and aE[V]
	return (aF and aF[ao]) ~= nil
end
function r.prototype.GetAbilityMechanicsUpgradeLevelSpecialValue(self, G, V, aG, aH)
	if not IsValid(G) then
		return
	end
	local aI = self:GetCachedResult(G)
	local aJ = aI and aI[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local ap = aJ and aJ[V]
	if ap ~= nil then
		for ao in pairs(ap) do
			local aq = ap[ao]
			local aK = aq[aG]
			if (aK and aK.value) ~= nil then
				return aK.value[Clamp(aH, 0, #aK.value - 1) + 1]
			end
		end
	end
	return
end
function r.prototype.GetAbilityMechanicsUpgradeLevelSpecialAddedValue(self, G, V, aG, aH, aL)
	if not IsValid(G) then
		return
	end
	local aM = self:GetCachedResult(G)
	local aN = aM and aM[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1]
	local ap = aN and aN[V]
	if ap ~= nil then
		for ao in pairs(ap) do
			local aq = ap[ao]
			local aK = aq[aG]
			local u = aK and aK[aL]
			if type(u) == "number" then
				return u
			elseif type(u) == "string" then
				local as = i(u, " ")
				if #as > 0 then
					local C = as[Clamp(aH, 0, #as - 1) + 1]
					local aO = f(C)
					if k(f(aO)) then
						return aO
					else
						return C
					end
				end
			end
		end
	end
	return
end
function r.prototype.AddNewAbilityUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	local V = H.ability_name
	if G:HasAbility(V) then
		return false
	end
	local aP = G:AddAbility(V)
	if not IsValid(aP) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	local aQ = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
	aQ[#aQ + 1] = H
	local aR = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1]
	aR[#aR + 1] = #M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1] - 1
	aP:SetLevel(math.min(toFiniteNumber(H.level), 1))
	local aS =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1]
	aS[V] = aP:entindex()
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveNewAbilityUpgrade(self, G, H)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	local V = H.ability_name
	if not G:HasAbility(V) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local P = self:GetAbilityUpgradeIndexs(G)
	for L = 0, #P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1] - 1, 1 do
		local S = P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1][L + 1]
		local T = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][S + 1]
		if T ~= nil and H.id == T.id then
			h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], S, 1)
			h(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1], L, 1)
			break
		end
	end
	local aS =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1]
	local aT = aS[V]
	if aT ~= nil then
		local aP = EntIndexToHScript(aT)
		if IsValid(aP) then
			G:RemoveAbilityByHandle(aP)
		end
	end
	e(aS, V)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
function r.prototype.RemoveNewAbilityUpgradeByIndex(self, G, U)
	assert(IsServer())
	if not IsValid(G) then
		return false
	end
	local M = self:GetAbilityUpgradeTable(G)
	local H = M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][U + 1]
	if H == nil then
		return false
	end
	if H.type ~= ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY then
		return false
	end
	if H.ability_name == nil then
		return false
	end
	local V = H.ability_name
	if not G:HasAbility(V) then
		return false
	end
	h(M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1], U, 1)
	local P = self:GetAbilityUpgradeIndexs(G)
	ArrayRemove(P[ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS + 1], U)
	local aS =
		M[ABILITY_UPGRADES_KEY.UPGRADES_KEY_CACHED_RESULT + 1][ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ADD_ABILITY + 1]
	local aT = aS[V]
	if aT ~= nil then
		local aP = EntIndexToHScript(aT)
		if IsValid(aP) then
			G:RemoveAbilityByHandle(aP)
		end
	end
	e(aS, V)
	self:UpdateAbilityUpgradesNetTables(G, M)
	return true
end
r = l({ q }, r)
if _G.AbilityUpgrades_cache == nil then
	_G.AbilityUpgrades_cache = m(r)
end
return o