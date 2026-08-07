--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/warlock"
local b = require("lualib_bundle")
local c = b.__TS__ArrayIndexOf
local d = b.__TS__StringIncludes
local e = b.__TS__Class
local f = b.__TS__ClassExtends
local g = b.__TS__DecorateLegacy
local h = b.__TS__New
local i = b.__TS__StringSplit
local j = b.__TS__Number
local k = b.__TS__ArrayUnshift
local l = b.__TS__ArrayIncludes
local m = b.__TS__ArraySplice
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 1072,
		["17"] = 1,
		["18"] = 1,
		["19"] = 1,
		["20"] = 2,
		["21"] = 2,
		["22"] = 2,
		["23"] = 3,
		["24"] = 3,
		["25"] = 3,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 7,
		["30"] = 8,
		["31"] = 9,
		["32"] = 11,
		["33"] = 12,
		["34"] = 13,
		["36"] = 15,
		["37"] = 16,
		["39"] = 18,
		["40"] = 11,
		["42"] = 22,
		["43"] = 28,
		["44"] = 34,
		["46"] = 35,
		["47"] = 35,
		["48"] = 36,
		["49"] = 37,
		["50"] = 37,
		["52"] = 35,
		["55"] = 34,
		["56"] = 41,
		["57"] = 42,
		["58"] = 42,
		["60"] = 43,
		["61"] = 43,
		["63"] = 44,
		["64"] = 44,
		["66"] = 45,
		["67"] = 41,
		["68"] = 48,
		["69"] = 49,
		["70"] = 50,
		["73"] = 51,
		["74"] = 52,
		["75"] = 53,
		["77"] = 54,
		["78"] = 54,
		["79"] = 55,
		["80"] = 56,
		["81"] = 56,
		["82"] = 57,
		["83"] = 58,
		["84"] = 59,
		["86"] = 54,
		["89"] = 62,
		["90"] = 48,
		["91"] = 65,
		["92"] = 66,
		["93"] = 67,
		["94"] = 67,
		["96"] = 68,
		["97"] = 69,
		["99"] = 70,
		["100"] = 70,
		["101"] = 71,
		["102"] = 71,
		["103"] = 72,
		["104"] = 73,
		["106"] = 70,
		["109"] = 76,
		["110"] = 65,
		["111"] = 79,
		["112"] = 80,
		["113"] = 81,
		["114"] = 81,
		["116"] = 82,
		["117"] = 83,
		["119"] = 84,
		["120"] = 84,
		["122"] = 85,
		["123"] = 86,
		["124"] = 87,
		["129"] = 90,
		["130"] = 79,
		["131"] = 93,
		["132"] = 94,
		["133"] = 95,
		["134"] = 96,
		["136"] = 98,
		["137"] = 93,
		["138"] = 101,
		["139"] = 102,
		["140"] = 103,
		["141"] = 104,
		["142"] = 101,
		["143"] = 109,
		["144"] = 110,
		["145"] = 109,
		["146"] = 110,
		["147"] = 111,
		["148"] = 112,
		["149"] = 111,
		["150"] = 110,
		["151"] = 109,
		["152"] = 110,
		["154"] = 110,
		["155"] = 116,
		["156"] = 124,
		["157"] = 116,
		["158"] = 124,
		["160"] = 124,
		["161"] = 147,
		["162"] = 162,
		["163"] = 164,
		["164"] = 165,
		["165"] = 166,
		["166"] = 116,
		["167"] = 172,
		["168"] = 173,
		["169"] = 174,
		["170"] = 175,
		["171"] = 176,
		["172"] = 177,
		["173"] = 178,
		["174"] = 179,
		["175"] = 180,
		["176"] = 181,
		["177"] = 182,
		["178"] = 186,
		["179"] = 187,
		["180"] = 188,
		["181"] = 189,
		["182"] = 190,
		["183"] = 191,
		["184"] = 192,
		["185"] = 193,
		["186"] = 194,
		["187"] = 195,
		["188"] = 196,
		["189"] = 197,
		["190"] = 198,
		["191"] = 199,
		["192"] = 200,
		["193"] = 201,
		["194"] = 206,
		["195"] = 207,
		["196"] = 208,
		["197"] = 211,
		["198"] = 212,
		["199"] = 213,
		["200"] = 172,
		["201"] = 216,
		["202"] = 217,
		["203"] = 218,
		["205"] = 216,
		["206"] = 222,
		["207"] = 223,
		["208"] = 223,
		["209"] = 223,
		["210"] = 223,
		["211"] = 223,
		["212"] = 223,
		["213"] = 223,
		["214"] = 223,
		["215"] = 223,
		["216"] = 223,
		["217"] = 222,
		["218"] = 235,
		["219"] = 236,
		["220"] = 237,
		["221"] = 238,
		["222"] = 239,
		["223"] = 239,
		["225"] = 241,
		["226"] = 242,
		["227"] = 242,
		["229"] = 244,
		["230"] = 245,
		["231"] = 246,
		["232"] = 247,
		["233"] = 248,
		["235"] = 250,
		["236"] = 250,
		["237"] = 250,
		["238"] = 250,
		["239"] = 250,
		["240"] = 251,
		["241"] = 252,
		["242"] = 235,
		["243"] = 255,
		["244"] = 256,
		["245"] = 257,
		["247"] = 255,
		["248"] = 261,
		["249"] = 262,
		["250"] = 263,
		["251"] = 264,
		["252"] = 265,
		["254"] = 261,
		["255"] = 269,
		["256"] = 270,
		["257"] = 271,
		["258"] = 273,
		["260"] = 275,
		["261"] = 276,
		["262"] = 276,
		["263"] = 276,
		["264"] = 276,
		["265"] = 276,
		["266"] = 276,
		["268"] = 278,
		["269"] = 279,
		["271"] = 269,
		["272"] = 282,
		["273"] = 283,
		["274"] = 284,
		["275"] = 285,
		["276"] = 286,
		["277"] = 287,
		["278"] = 288,
		["279"] = 288,
		["280"] = 288,
		["281"] = 288,
		["282"] = 288,
		["283"] = 288,
		["284"] = 290,
		["285"] = 295,
		["286"] = 295,
		["287"] = 295,
		["288"] = 295,
		["289"] = 295,
		["290"] = 295,
		["291"] = 295,
		["292"] = 295,
		["293"] = 295,
		["294"] = 296,
		["295"] = 296,
		["296"] = 296,
		["297"] = 296,
		["298"] = 296,
		["299"] = 296,
		["300"] = 296,
		["301"] = 296,
		["302"] = 296,
		["304"] = 298,
		["307"] = 301,
		["308"] = 302,
		["309"] = 303,
		["310"] = 304,
		["311"] = 305,
		["312"] = 305,
		["313"] = 305,
		["314"] = 305,
		["315"] = 305,
		["316"] = 305,
		["319"] = 282,
		["320"] = 309,
		["321"] = 310,
		["322"] = 310,
		["323"] = 310,
		["324"] = 311,
		["325"] = 312,
		["326"] = 313,
		["327"] = 313,
		["328"] = 313,
		["329"] = 313,
		["330"] = 313,
		["331"] = 313,
		["332"] = 314,
		["333"] = 315,
		["334"] = 316,
		["337"] = 319,
		["339"] = 310,
		["340"] = 310,
		["341"] = 322,
		["342"] = 309,
		["343"] = 324,
		["344"] = 325,
		["345"] = 326,
		["346"] = 326,
		["347"] = 326,
		["348"] = 326,
		["349"] = 326,
		["350"] = 326,
		["351"] = 327,
		["353"] = 324,
		["354"] = 331,
		["355"] = 332,
		["358"] = 333,
		["361"] = 334,
		["362"] = 335,
		["363"] = 336,
		["364"] = 337,
		["365"] = 338,
		["367"] = 340,
		["368"] = 341,
		["372"] = 331,
		["373"] = 347,
		["374"] = 348,
		["375"] = 347,
		["376"] = 354,
		["377"] = 355,
		["378"] = 354,
		["379"] = 359,
		["380"] = 360,
		["381"] = 361,
		["383"] = 359,
		["384"] = 365,
		["385"] = 366,
		["386"] = 365,
		["387"] = 369,
		["388"] = 370,
		["389"] = 371,
		["391"] = 369,
		["392"] = 375,
		["393"] = 376,
		["394"] = 375,
		["395"] = 379,
		["396"] = 380,
		["397"] = 379,
		["398"] = 383,
		["399"] = 384,
		["402"] = 385,
		["403"] = 386,
		["404"] = 383,
		["405"] = 389,
		["406"] = 390,
		["407"] = 391,
		["408"] = 391,
		["410"] = 392,
		["411"] = 392,
		["413"] = 393,
		["414"] = 389,
		["415"] = 396,
		["416"] = 397,
		["417"] = 398,
		["418"] = 399,
		["420"] = 401,
		["421"] = 396,
		["422"] = 404,
		["423"] = 405,
		["425"] = 406,
		["426"] = 406,
		["427"] = 407,
		["428"] = 406,
		["431"] = 409,
		["432"] = 404,
		["433"] = 412,
		["434"] = 413,
		["437"] = 416,
		["440"] = 419,
		["443"] = 422,
		["446"] = 425,
		["447"] = 412,
		["448"] = 428,
		["449"] = 429,
		["450"] = 430,
		["451"] = 431,
		["452"] = 432,
		["453"] = 433,
		["455"] = 428,
		["456"] = 436,
		["457"] = 437,
		["458"] = 438,
		["459"] = 439,
		["461"] = 436,
		["462"] = 444,
		["463"] = 445,
		["466"] = 448,
		["467"] = 448,
		["468"] = 448,
		["469"] = 448,
		["470"] = 448,
		["471"] = 448,
		["472"] = 449,
		["473"] = 444,
		["474"] = 452,
		["475"] = 452,
		["476"] = 452,
		["478"] = 453,
		["479"] = 454,
		["480"] = 455,
		["482"] = 452,
		["483"] = 459,
		["484"] = 460,
		["487"] = 463,
		["488"] = 464,
		["489"] = 464,
		["490"] = 464,
		["491"] = 464,
		["492"] = 464,
		["493"] = 464,
		["494"] = 464,
		["495"] = 464,
		["496"] = 464,
		["497"] = 464,
		["499"] = 471,
		["500"] = 471,
		["501"] = 471,
		["502"] = 471,
		["503"] = 471,
		["504"] = 471,
		["506"] = 473,
		["507"] = 459,
		["508"] = 476,
		["509"] = 477,
		["510"] = 478,
		["511"] = 479,
		["513"] = 476,
		["514"] = 483,
		["515"] = 484,
		["518"] = 487,
		["519"] = 487,
		["520"] = 487,
		["521"] = 487,
		["522"] = 488,
		["523"] = 489,
		["525"] = 491,
		["526"] = 492,
		["527"] = 492,
		["528"] = 492,
		["529"] = 492,
		["530"] = 492,
		["531"] = 492,
		["533"] = 483,
		["534"] = 496,
		["535"] = 497,
		["536"] = 498,
		["539"] = 501,
		["540"] = 502,
		["541"] = 503,
		["542"] = 504,
		["543"] = 505,
		["544"] = 505,
		["545"] = 505,
		["546"] = 506,
		["549"] = 509,
		["550"] = 505,
		["551"] = 505,
		["553"] = 496,
		["554"] = 514,
		["555"] = 515,
		["556"] = 516,
		["558"] = 514,
		["559"] = 524,
		["560"] = 525,
		["561"] = 526,
		["564"] = 529,
		["565"] = 530,
		["569"] = 533,
		["570"] = 533,
		["571"] = 534,
		["572"] = 533,
		["575"] = 524,
		["576"] = 538,
		["577"] = 539,
		["578"] = 538,
		["579"] = 542,
		["580"] = 543,
		["581"] = 542,
		["582"] = 546,
		["583"] = 547,
		["584"] = 549,
		["585"] = 550,
		["586"] = 551,
		["587"] = 551,
		["588"] = 551,
		["589"] = 551,
		["590"] = 551,
		["591"] = 551,
		["594"] = 555,
		["597"] = 558,
		["598"] = 560,
		["599"] = 561,
		["601"] = 565,
		["602"] = 566,
		["603"] = 567,
		["604"] = 568,
		["605"] = 569,
		["606"] = 570,
		["607"] = 571,
		["609"] = 572,
		["610"] = 572,
		["612"] = 573,
		["613"] = 573,
		["614"] = 574,
		["615"] = 573,
		["618"] = 572,
		["624"] = 546,
		["625"] = 581,
		["626"] = 582,
		["627"] = 583,
		["629"] = 585,
		["630"] = 586,
		["632"] = 581,
		["633"] = 592,
		["634"] = 593,
		["635"] = 594,
		["638"] = 595,
		["640"] = 596,
		["641"] = 596,
		["642"] = 597,
		["643"] = 598,
		["644"] = 599,
		["646"] = 596,
		["649"] = 592,
		["650"] = 604,
		["651"] = 605,
		["652"] = 606,
		["653"] = 607,
		["654"] = 607,
		["655"] = 607,
		["656"] = 608,
		["659"] = 609,
		["660"] = 610,
		["662"] = 612,
		["663"] = 613,
		["664"] = 613,
		["665"] = 613,
		["666"] = 613,
		["667"] = 613,
		["668"] = 613,
		["669"] = 614,
		["670"] = 615,
		["671"] = 616,
		["672"] = 617,
		["675"] = 620,
		["676"] = 620,
		["677"] = 620,
		["678"] = 620,
		["679"] = 622,
		["680"] = 623,
		["682"] = 625,
		["683"] = 607,
		["684"] = 607,
		["685"] = 604,
		["686"] = 629,
		["687"] = 630,
		["688"] = 631,
		["690"] = 633,
		["691"] = 633,
		["693"] = 634,
		["694"] = 634,
		["695"] = 634,
		["696"] = 634,
		["697"] = 635,
		["698"] = 629,
		["699"] = 638,
		["700"] = 639,
		["701"] = 639,
		["702"] = 639,
		["703"] = 639,
		["704"] = 639,
		["705"] = 639,
		["706"] = 639,
		["707"] = 639,
		["708"] = 639,
		["709"] = 639,
		["710"] = 639,
		["711"] = 639,
		["712"] = 639,
		["713"] = 639,
		["714"] = 639,
		["715"] = 639,
		["716"] = 639,
		["717"] = 639,
		["718"] = 639,
		["719"] = 639,
		["720"] = 639,
		["721"] = 639,
		["722"] = 638,
		["723"] = 660,
		["724"] = 661,
		["725"] = 661,
		["726"] = 661,
		["727"] = 661,
		["728"] = 660,
		["729"] = 664,
		["730"] = 665,
		["731"] = 666,
		["732"] = 667,
		["733"] = 668,
		["734"] = 669,
		["735"] = 670,
		["736"] = 670,
		["740"] = 673,
		["741"] = 664,
		["742"] = 676,
		["743"] = 677,
		["744"] = 678,
		["745"] = 679,
		["747"] = 681,
		["748"] = 676,
		["749"] = 124,
		["750"] = 116,
		["751"] = 116,
		["752"] = 116,
		["753"] = 116,
		["754"] = 116,
		["755"] = 116,
		["756"] = 116,
		["757"] = 116,
		["758"] = 124,
		["760"] = 124,
		["761"] = 687,
		["762"] = 688,
		["763"] = 687,
		["764"] = 688,
		["765"] = 689,
		["766"] = 690,
		["767"] = 689,
		["768"] = 692,
		["769"] = 693,
		["772"] = 695,
		["775"] = 696,
		["776"] = 697,
		["777"] = 698,
		["779"] = 692,
		["780"] = 701,
		["781"] = 702,
		["782"] = 701,
		["783"] = 688,
		["784"] = 687,
		["785"] = 688,
		["787"] = 688,
		["788"] = 706,
		["789"] = 714,
		["790"] = 706,
		["791"] = 714,
		["793"] = 714,
		["794"] = 717,
		["795"] = 718,
		["796"] = 720,
		["797"] = 721,
		["798"] = 706,
		["799"] = 723,
		["800"] = 724,
		["801"] = 725,
		["802"] = 726,
		["803"] = 727,
		["804"] = 728,
		["805"] = 729,
		["806"] = 730,
		["808"] = 723,
		["809"] = 734,
		["810"] = 735,
		["811"] = 736,
		["812"] = 737,
		["813"] = 738,
		["814"] = 739,
		["815"] = 740,
		["816"] = 741,
		["818"] = 734,
		["819"] = 744,
		["820"] = 745,
		["821"] = 746,
		["822"] = 747,
		["823"] = 748,
		["824"] = 749,
		["825"] = 750,
		["827"] = 744,
		["828"] = 755,
		["829"] = 756,
		["830"] = 756,
		["831"] = 756,
		["832"] = 756,
		["833"] = 755,
		["834"] = 758,
		["835"] = 759,
		["836"] = 759,
		["837"] = 759,
		["838"] = 759,
		["839"] = 759,
		["840"] = 758,
		["841"] = 761,
		["842"] = 762,
		["843"] = 762,
		["844"] = 762,
		["845"] = 762,
		["846"] = 761,
		["847"] = 764,
		["848"] = 764,
		["849"] = 764,
		["851"] = 765,
		["852"] = 765,
		["853"] = 765,
		["854"] = 765,
		["855"] = 765,
		["856"] = 764,
		["857"] = 767,
		["858"] = 768,
		["859"] = 768,
		["860"] = 768,
		["861"] = 768,
		["862"] = 767,
		["863"] = 770,
		["864"] = 770,
		["865"] = 770,
		["867"] = 771,
		["868"] = 771,
		["869"] = 771,
		["870"] = 771,
		["871"] = 771,
		["872"] = 770,
		["873"] = 773,
		["874"] = 774,
		["875"] = 774,
		["876"] = 774,
		["877"] = 774,
		["878"] = 773,
		["879"] = 776,
		["880"] = 777,
		["881"] = 777,
		["882"] = 777,
		["883"] = 777,
		["884"] = 777,
		["885"] = 776,
		["886"] = 779,
		["887"] = 780,
		["888"] = 780,
		["889"] = 780,
		["890"] = 780,
		["891"] = 779,
		["892"] = 782,
		["893"] = 783,
		["894"] = 783,
		["895"] = 783,
		["896"] = 783,
		["897"] = 783,
		["898"] = 782,
		["899"] = 785,
		["900"] = 786,
		["901"] = 786,
		["902"] = 786,
		["903"] = 786,
		["904"] = 787,
		["905"] = 787,
		["907"] = 788,
		["908"] = 789,
		["909"] = 790,
		["910"] = 791,
		["912"] = 793,
		["913"] = 785,
		["914"] = 795,
		["915"] = 796,
		["916"] = 796,
		["917"] = 796,
		["918"] = 796,
		["919"] = 796,
		["920"] = 795,
		["921"] = 799,
		["922"] = 800,
		["923"] = 801,
		["924"] = 802,
		["926"] = 799,
		["927"] = 807,
		["928"] = 808,
		["931"] = 809,
		["932"] = 810,
		["933"] = 811,
		["934"] = 812,
		["935"] = 813,
		["938"] = 807,
		["939"] = 818,
		["940"] = 819,
		["943"] = 820,
		["944"] = 821,
		["945"] = 822,
		["947"] = 818,
		["948"] = 826,
		["949"] = 827,
		["952"] = 828,
		["953"] = 829,
		["954"] = 830,
		["955"] = 831,
		["956"] = 832,
		["957"] = 833,
		["958"] = 826,
		["959"] = 836,
		["960"] = 837,
		["963"] = 838,
		["965"] = 839,
		["966"] = 839,
		["967"] = 839,
		["968"] = 839,
		["969"] = 839,
		["972"] = 840,
		["974"] = 842,
		["975"] = 843,
		["976"] = 844,
		["978"] = 836,
		["979"] = 848,
		["980"] = 849,
		["983"] = 850,
		["984"] = 851,
		["985"] = 851,
		["986"] = 851,
		["988"] = 852,
		["989"] = 848,
		["990"] = 855,
		["991"] = 856,
		["994"] = 857,
		["995"] = 858,
		["996"] = 859,
		["997"] = 860,
		["998"] = 860,
		["1001"] = 862,
		["1003"] = 855,
		["1004"] = 867,
		["1005"] = 868,
		["1006"] = 873,
		["1007"] = 873,
		["1008"] = 873,
		["1009"] = 873,
		["1010"] = 873,
		["1011"] = 874,
		["1012"] = 874,
		["1014"] = 875,
		["1015"] = 876,
		["1016"] = 876,
		["1018"] = 877,
		["1019"] = 878,
		["1020"] = 879,
		["1024"] = 883,
		["1025"] = 884,
		["1026"] = 885,
		["1027"] = 886,
		["1028"] = 887,
		["1029"] = 888,
		["1031"] = 890,
		["1033"] = 892,
		["1034"] = 893,
		["1035"] = 894,
		["1036"] = 873,
		["1037"] = 873,
		["1038"] = 873,
		["1039"] = 873,
		["1040"] = 873,
		["1041"] = 873,
		["1042"] = 867,
		["1043"] = 899,
		["1044"] = 900,
		["1047"] = 901,
		["1048"] = 902,
		["1049"] = 903,
		["1050"] = 904,
		["1053"] = 907,
		["1054"] = 908,
		["1057"] = 911,
		["1060"] = 912,
		["1061"] = 914,
		["1062"] = 915,
		["1063"] = 916,
		["1064"] = 917,
		["1065"] = 918,
		["1066"] = 919,
		["1070"] = 924,
		["1071"] = 925,
		["1072"] = 926,
		["1073"] = 926,
		["1074"] = 926,
		["1075"] = 926,
		["1076"] = 926,
		["1078"] = 926,
		["1079"] = 926,
		["1081"] = 928,
		["1082"] = 928,
		["1083"] = 928,
		["1084"] = 928,
		["1085"] = 928,
		["1086"] = 929,
		["1087"] = 929,
		["1089"] = 930,
		["1090"] = 931,
		["1091"] = 931,
		["1093"] = 932,
		["1094"] = 928,
		["1095"] = 928,
		["1098"] = 899,
		["1099"] = 938,
		["1100"] = 939,
		["1103"] = 940,
		["1104"] = 941,
		["1105"] = 942,
		["1106"] = 943,
		["1107"] = 944,
		["1108"] = 944,
		["1110"] = 945,
		["1111"] = 946,
		["1112"] = 947,
		["1113"] = 948,
		["1114"] = 948,
		["1118"] = 950,
		["1119"] = 951,
		["1120"] = 951,
		["1121"] = 951,
		["1122"] = 951,
		["1123"] = 951,
		["1124"] = 951,
		["1126"] = 938,
		["1127"] = 954,
		["1128"] = 955,
		["1131"] = 956,
		["1132"] = 957,
		["1133"] = 958,
		["1134"] = 959,
		["1136"] = 961,
		["1137"] = 962,
		["1138"] = 963,
		["1139"] = 964,
		["1140"] = 965,
		["1141"] = 966,
		["1142"] = 967,
		["1143"] = 968,
		["1144"] = 969,
		["1145"] = 970,
		["1146"] = 971,
		["1148"] = 972,
		["1149"] = 972,
		["1150"] = 973,
		["1151"] = 974,
		["1152"] = 975,
		["1153"] = 972,
		["1157"] = 978,
		["1158"] = 979,
		["1160"] = 980,
		["1161"] = 980,
		["1162"] = 981,
		["1163"] = 981,
		["1164"] = 981,
		["1165"] = 981,
		["1166"] = 981,
		["1167"] = 981,
		["1168"] = 981,
		["1169"] = 980,
		["1173"] = 984,
		["1174"] = 985,
		["1176"] = 987,
		["1178"] = 989,
		["1179"] = 954,
		["1180"] = 993,
		["1181"] = 994,
		["1182"] = 993,
		["1183"] = 1002,
		["1184"] = 1003,
		["1185"] = 1004,
		["1187"] = 1002,
		["1188"] = 1008,
		["1189"] = 1009,
		["1190"] = 1008,
		["1191"] = 1012,
		["1192"] = 1012,
		["1193"] = 1012,
		["1194"] = 1012,
		["1195"] = 1014,
		["1196"] = 1015,
		["1199"] = 1016,
		["1200"] = 1016,
		["1203"] = 1017,
		["1204"] = 1018,
		["1205"] = 1019,
		["1206"] = 1020,
		["1208"] = 1014,
		["1209"] = 1024,
		["1210"] = 1025,
		["1211"] = 1026,
		["1212"] = 1026,
		["1214"] = 1027,
		["1215"] = 1028,
		["1216"] = 1024,
		["1217"] = 1031,
		["1218"] = 1032,
		["1219"] = 1033,
		["1222"] = 1034,
		["1223"] = 1035,
		["1227"] = 1036,
		["1228"] = 1036,
		["1230"] = 1037,
		["1231"] = 1038,
		["1232"] = 1038,
		["1234"] = 1039,
		["1235"] = 1039,
		["1237"] = 1040,
		["1238"] = 1040,
		["1239"] = 1041,
		["1242"] = 1036,
		["1245"] = 1031,
		["1246"] = 714,
		["1247"] = 706,
		["1248"] = 706,
		["1249"] = 706,
		["1250"] = 706,
		["1251"] = 706,
		["1252"] = 706,
		["1253"] = 706,
		["1254"] = 706,
		["1255"] = 714,
		["1257"] = 714,
		["1259"] = 1072,
		["1260"] = 1072,
		["1261"] = 1099,
		["1262"] = 1093,
		["1263"] = 1100,
		["1264"] = 1101,
		["1265"] = 1102,
		["1266"] = 1103,
		["1267"] = 1104,
		["1268"] = 1105,
		["1269"] = 1106,
		["1270"] = 1107,
		["1271"] = 1108,
		["1272"] = 1109,
		["1273"] = 1110,
		["1274"] = 1111,
		["1275"] = 1112,
		["1276"] = 1113,
		["1277"] = 1114,
		["1278"] = 1115,
		["1279"] = 1116,
		["1280"] = 1117,
		["1281"] = 1118,
		["1282"] = 1119,
		["1283"] = 1120,
		["1284"] = 1099,
		["1285"] = 1123,
		["1286"] = 1124,
		["1289"] = 1125,
		["1290"] = 1128,
		["1291"] = 1129,
		["1292"] = 1130,
		["1293"] = 1131,
		["1294"] = 1133,
		["1295"] = 1134,
		["1296"] = 1135,
		["1297"] = 1135,
		["1298"] = 1135,
		["1299"] = 1135,
		["1300"] = 1135,
		["1302"] = 1137,
		["1303"] = 1138,
		["1304"] = 1139,
		["1305"] = 1140,
		["1306"] = 1141,
		["1307"] = 1141,
		["1309"] = 1142,
		["1310"] = 1143,
		["1311"] = 1144,
		["1314"] = 1147,
		["1317"] = 1150,
		["1319"] = 1153,
		["1320"] = 1154,
		["1321"] = 1154,
		["1322"] = 1154,
		["1323"] = 1155,
		["1326"] = 1156,
		["1327"] = 1157,
		["1328"] = 1154,
		["1329"] = 1154,
		["1330"] = 1123,
		["1331"] = 1162,
		["1332"] = 1163,
		["1333"] = 1162,
		["1334"] = 1166,
		["1335"] = 1167,
		["1336"] = 1167,
		["1337"] = 1167,
		["1338"] = 1167,
		["1339"] = 1167,
		["1340"] = 1167,
		["1341"] = 1167,
		["1342"] = 1167,
		["1343"] = 1167,
		["1344"] = 1167,
		["1345"] = 1167,
		["1346"] = 1167,
		["1347"] = 1167,
		["1348"] = 1166,
		["1349"] = 1178,
		["1350"] = 1179,
		["1351"] = 1178,
		["1352"] = 1182,
		["1353"] = 1183,
		["1354"] = 1185,
		["1355"] = 1186,
		["1356"] = 1187,
		["1357"] = 1188,
		["1358"] = 1189,
		["1359"] = 1190,
		["1360"] = 1190,
		["1361"] = 1190,
		["1362"] = 1190,
		["1363"] = 1190,
		["1364"] = 1190,
		["1365"] = 1190,
		["1366"] = 1190,
		["1367"] = 1190,
		["1368"] = 1190,
		["1369"] = 1190,
		["1370"] = 1190,
		["1371"] = 1190,
		["1372"] = 1190,
		["1373"] = 1199,
		["1375"] = 1201,
		["1376"] = 1201,
		["1378"] = 1182,
		["1379"] = 1204,
		["1380"] = 1205,
		["1383"] = 1206,
		["1386"] = 1207,
		["1387"] = 1209,
		["1388"] = 1210,
		["1389"] = 1210,
		["1390"] = 1210,
		["1391"] = 1211,
		["1394"] = 1212,
		["1397"] = 1214,
		["1398"] = 1215,
		["1399"] = 1210,
		["1400"] = 1210,
		["1401"] = 1204,
		["1402"] = 1219,
		["1403"] = 1220,
		["1406"] = 1222,
		["1407"] = 1223,
		["1408"] = 1219,
		["1409"] = 1226,
		["1410"] = 1227,
		["1411"] = 1227,
		["1412"] = 1227,
		["1414"] = 1229,
		["1415"] = 1230,
		["1416"] = 1230,
		["1417"] = 1230,
		["1418"] = 1230,
		["1419"] = 1230,
		["1420"] = 1230,
		["1421"] = 1230,
		["1422"] = 1230,
		["1423"] = 1230,
		["1424"] = 1230,
		["1425"] = 1230,
		["1426"] = 1237,
		["1427"] = 1237,
		["1428"] = 1238,
		["1429"] = 1238,
		["1430"] = 1238,
		["1431"] = 1239,
		["1432"] = 1240,
		["1434"] = 1238,
		["1435"] = 1238,
		["1437"] = 1244,
		["1438"] = 1245,
		["1440"] = 1247,
		["1441"] = 1226,
		["1442"] = 1253,
		["1443"] = 1261,
		["1444"] = 1253,
		["1445"] = 1261,
		["1447"] = 1261,
		["1448"] = 1265,
		["1449"] = 1253,
		["1450"] = 1267,
		["1451"] = 1268,
		["1452"] = 1269,
		["1453"] = 1270,
		["1454"] = 1271,
		["1455"] = 1272,
		["1456"] = 1273,
		["1457"] = 1274,
		["1458"] = 1275,
		["1459"] = 1275,
		["1460"] = 1275,
		["1461"] = 1275,
		["1464"] = 1267,
		["1465"] = 1280,
		["1466"] = 1281,
		["1467"] = 1282,
		["1468"] = 1283,
		["1469"] = 1284,
		["1471"] = 1286,
		["1472"] = 1287,
		["1473"] = 1288,
		["1474"] = 1289,
		["1475"] = 1289,
		["1476"] = 1289,
		["1477"] = 1289,
		["1478"] = 1289,
		["1481"] = 1280,
		["1482"] = 1294,
		["1483"] = 1295,
		["1484"] = 1294,
		["1485"] = 1298,
		["1486"] = 1299,
		["1487"] = 1298,
		["1488"] = 1302,
		["1489"] = 1303,
		["1490"] = 1302,
		["1491"] = 1308,
		["1492"] = 1309,
		["1493"] = 1310,
		["1494"] = 1308,
		["1495"] = 1261,
		["1496"] = 1253,
		["1497"] = 1253,
		["1498"] = 1253,
		["1499"] = 1253,
		["1500"] = 1253,
		["1501"] = 1253,
		["1502"] = 1253,
		["1503"] = 1253,
		["1504"] = 1261,
		["1506"] = 1261,
		["1507"] = 1314,
		["1508"] = 1322,
		["1509"] = 1314,
		["1510"] = 1322,
		["1512"] = 1322,
		["1513"] = 1324,
		["1514"] = 1314,
		["1515"] = 1328,
		["1516"] = 1329,
		["1517"] = 1328,
		["1518"] = 1332,
		["1519"] = 1333,
		["1520"] = 1334,
		["1521"] = 1335,
		["1522"] = 1336,
		["1523"] = 1337,
		["1524"] = 1337,
		["1525"] = 1337,
		["1526"] = 1337,
		["1527"] = 1337,
		["1528"] = 1338,
		["1529"] = 1339,
		["1530"] = 1340,
		["1531"] = 1341,
		["1532"] = 1342,
		["1535"] = 1332,
		["1536"] = 1347,
		["1537"] = 1348,
		["1538"] = 1349,
		["1539"] = 1350,
		["1540"] = 1351,
		["1541"] = 1352,
		["1543"] = 1354,
		["1544"] = 1355,
		["1547"] = 1347,
		["1548"] = 1360,
		["1549"] = 1361,
		["1550"] = 1362,
		["1552"] = 1364,
		["1553"] = 1360,
		["1554"] = 1367,
		["1555"] = 1368,
		["1556"] = 1368,
		["1557"] = 1368,
		["1558"] = 1368,
		["1559"] = 1368,
		["1560"] = 1368,
		["1561"] = 1368,
		["1562"] = 1367,
		["1563"] = 1377,
		["1564"] = 1378,
		["1565"] = 1379,
		["1567"] = 1381,
		["1568"] = 1377,
		["1569"] = 1384,
		["1570"] = 1385,
		["1571"] = 1384,
		["1572"] = 1388,
		["1573"] = 1389,
		["1576"] = 1390,
		["1577"] = 1391,
		["1578"] = 1388,
		["1579"] = 1394,
		["1580"] = 1395,
		["1583"] = 1396,
		["1584"] = 1394,
		["1585"] = 1399,
		["1586"] = 1400,
		["1587"] = 1401,
		["1588"] = 1402,
		["1590"] = 1404,
		["1592"] = 1399,
		["1593"] = 1322,
		["1594"] = 1314,
		["1595"] = 1314,
		["1596"] = 1314,
		["1597"] = 1314,
		["1598"] = 1314,
		["1599"] = 1314,
		["1600"] = 1314,
		["1601"] = 1314,
		["1602"] = 1322,
		["1604"] = 1322,
		["1605"] = 1411,
		["1606"] = 1419,
		["1607"] = 1411,
		["1608"] = 1419,
		["1609"] = 1422,
		["1610"] = 1423,
		["1611"] = 1424,
		["1613"] = 1422,
		["1614"] = 1428,
		["1615"] = 1429,
		["1616"] = 1428,
		["1617"] = 1432,
		["1618"] = 1433,
		["1619"] = 1432,
		["1620"] = 1436,
		["1621"] = 1437,
		["1622"] = 1437,
		["1623"] = 1437,
		["1624"] = 1437,
		["1625"] = 1436,
		["1626"] = 1440,
		["1627"] = 1441,
		["1628"] = 1442,
		["1630"] = 1444,
		["1631"] = 1445,
		["1633"] = 1440,
		["1634"] = 1419,
		["1635"] = 1411,
		["1636"] = 1411,
		["1637"] = 1411,
		["1638"] = 1411,
		["1639"] = 1411,
		["1640"] = 1411,
		["1641"] = 1411,
		["1642"] = 1411,
		["1643"] = 1419,
		["1645"] = 1419,
		["1646"] = 1452,
		["1647"] = 1453,
		["1648"] = 1452,
		["1649"] = 1453,
		["1650"] = 1454,
		["1651"] = 1455,
		["1652"] = 1456,
		["1653"] = 1457,
		["1656"] = 1458,
		["1657"] = 1459,
		["1658"] = 1459,
		["1659"] = 1459,
		["1660"] = 1460,
		["1661"] = 1461,
		["1662"] = 1462,
		["1663"] = 1462,
		["1664"] = 1462,
		["1665"] = 1462,
		["1666"] = 1462,
		["1667"] = 1462,
		["1669"] = 1459,
		["1670"] = 1459,
		["1671"] = 1454,
		["1672"] = 1453,
		["1673"] = 1452,
		["1674"] = 1453,
		["1676"] = 1453,
		["1677"] = 1468,
		["1678"] = 1478,
		["1679"] = 1468,
		["1680"] = 1478,
		["1682"] = 1478,
		["1683"] = 1481,
		["1684"] = 1468,
		["1685"] = 1484,
		["1686"] = 1485,
		["1687"] = 1486,
		["1688"] = 1487,
		["1689"] = 1484,
		["1690"] = 1490,
		["1691"] = 1491,
		["1692"] = 1492,
		["1693"] = 1493,
		["1695"] = 1495,
		["1696"] = 1496,
		["1697"] = 1496,
		["1698"] = 1496,
		["1699"] = 1496,
		["1700"] = 1496,
		["1701"] = 1496,
		["1702"] = 1490,
		["1703"] = 1498,
		["1704"] = 1499,
		["1705"] = 1500,
		["1707"] = 1498,
		["1708"] = 1503,
		["1709"] = 1504,
		["1710"] = 1505,
		["1711"] = 1506,
		["1712"] = 1507,
		["1713"] = 1508,
		["1714"] = 1508,
		["1715"] = 1508,
		["1716"] = 1508,
		["1717"] = 1508,
		["1718"] = 1508,
		["1719"] = 1509,
		["1720"] = 1510,
		["1721"] = 1510,
		["1722"] = 1510,
		["1723"] = 1510,
		["1724"] = 1510,
		["1725"] = 1510,
		["1729"] = 1503,
		["1730"] = 1515,
		["1731"] = 1516,
		["1732"] = 1517,
		["1734"] = 1519,
		["1735"] = 1520,
		["1736"] = 1521,
		["1737"] = 1522,
		["1739"] = 1524,
		["1740"] = 1515,
		["1741"] = 1478,
		["1742"] = 1468,
		["1743"] = 1468,
		["1744"] = 1468,
		["1745"] = 1468,
		["1746"] = 1468,
		["1747"] = 1468,
		["1748"] = 1468,
		["1749"] = 1468,
		["1750"] = 1468,
		["1751"] = 1468,
		["1752"] = 1478,
		["1754"] = 1478,
		["1755"] = 1528,
		["1756"] = 1536,
		["1757"] = 1528,
		["1758"] = 1536,
		["1759"] = 1536,
		["1760"] = 1528,
		["1761"] = 1528,
		["1762"] = 1528,
		["1763"] = 1528,
		["1764"] = 1528,
		["1765"] = 1528,
		["1766"] = 1528,
		["1767"] = 1528,
		["1768"] = 1536,
		["1770"] = 1536,
		["1771"] = 1538,
		["1772"] = 1546,
		["1773"] = 1538,
		["1774"] = 1546,
		["1775"] = 1549,
		["1776"] = 1550,
		["1777"] = 1551,
		["1778"] = 1552,
		["1779"] = 1553,
		["1782"] = 1549,
		["1783"] = 1562,
		["1784"] = 1563,
		["1785"] = 1564,
		["1786"] = 1565,
		["1788"] = 1562,
		["1789"] = 1546,
		["1790"] = 1538,
		["1791"] = 1538,
		["1792"] = 1538,
		["1793"] = 1538,
		["1794"] = 1538,
		["1795"] = 1538,
		["1796"] = 1538,
		["1797"] = 1538,
		["1798"] = 1546,
		["1800"] = 1546,
		["1801"] = 1572,
		["1802"] = 1573,
		["1803"] = 1572,
		["1804"] = 1573,
		["1805"] = 1574,
		["1806"] = 1575,
		["1807"] = 1574,
		["1808"] = 1573,
		["1809"] = 1572,
		["1810"] = 1573,
		["1812"] = 1573,
		["1813"] = 1579,
		["1814"] = 1587,
		["1815"] = 1579,
		["1816"] = 1587,
		["1817"] = 1588,
		["1818"] = 1589,
		["1819"] = 1590,
		["1820"] = 1591,
		["1821"] = 1592,
		["1824"] = 1588,
		["1825"] = 1587,
		["1826"] = 1579,
		["1827"] = 1579,
		["1828"] = 1579,
		["1829"] = 1579,
		["1830"] = 1579,
		["1831"] = 1579,
		["1832"] = 1579,
		["1833"] = 1579,
		["1834"] = 1587,
		["1836"] = 1587,
	}
)
local o = {}
local p
local q = require("lib.dota_ts_adapter")
local r = q.BaseAbility
local s = q.registerAbility
local t = require("modifiers.eom_modifier")
local u = t.EOMModifier
local v = t.registerEOMModifier
local w = require("abilities.ability_ai")
local x = w.BaseAbilityAI
local y = w.registerAbilityAI
local z = require("abilities.interact_ability")
local A = z.InteractAbility
local B = z.registerInteractAbility
local C = "models/units/warlock_demon_custom/warlock_demon_custom.vmdl"
local D =
	"models/items/warlock/golem/warlock_tailor_of_burning_puppet_golem/warlock_tailor_of_burning_puppet_golem.vmdl"
local E = "models/items/warlock/golem/greevil_master_greevil_golem/greevil_master_greevil_golem.vmdl"
local function F(self, G)
	if G:HasModifier("modifier_5100071") then
		return D
	end
	if G:HasModifier("modifier_5100572") then
		return E
	end
	return C
end
local H = {
	[0] = { "chaos_ritual_1", "chaos_ritual_2", "chaos_ritual_3", "chaos_ritual_4" },
	[1] = { "abyssal_fusion_1", "abyssal_fusion_2", "abyssal_fusion_3", "abyssal_fusion_4" },
	[2] = { "demonic_pact_1", "demonic_pact_2", "demonic_pact_3", "demonic_pact_4" },
}
local I = {
	{ "warlock_talent_1", "warlock_talent_2", "warlock_talent_3" },
	{ "warlock_talent_4", "warlock_talent_5", "warlock_talent_6" },
	{ "warlock_talent_7", "warlock_talent_8", "warlock_talent_9" },
}
local function J(self, K)
	do
		local L = 0
		while L < #I do
			local M = I[L + 1]
			if c(M, K) ~= -1 then
				return M
			end
			L = L + 1
		end
	end
end
local function N(self, K)
	if K == "warlock_talent_1" or K == "warlock_talent_4" or K == "warlock_talent_7" then
		return 0
	end
	if K == "warlock_talent_2" or K == "warlock_talent_5" or K == "warlock_talent_8" then
		return 1
	end
	if K == "warlock_talent_3" or K == "warlock_talent_6" or K == "warlock_talent_9" then
		return 2
	end
	return -1
end
local function O(self, G)
	local P = PlayerData:getHero(G:GetPlayerOwnerID())
	if not P then
		return
	end
	local Q = P:getAbilityData(true)
	local R
	local S = -1
	do
		local L = 0
		while L < #AbilityShop.pickList do
			local T = AbilityShop.pickList[L + 1]
			local U = Q[T]
			local V = U and U.exp or 0
			if V > S then
				R = T
				S = V
			end
			L = L + 1
		end
	end
	return R
end
local function W(self, G)
	local P = PlayerData:getHero(G:GetPlayerOwnerID())
	if not P then
		return 0
	end
	local Q = P:getAbilityData(true)
	local S = 0
	do
		local L = 0
		while L < #AbilityShop.pickList do
			local X = Q[AbilityShop.pickList[L + 1]]
			local V = X and X.exp or 0
			if V > S then
				S = V
			end
			L = L + 1
		end
	end
	return S
end
local function Y(self, G, T)
	local P = PlayerData:getHero(G:GetPlayerOwnerID())
	if not P then
		return {}
	end
	local R = {}
	for Z, _ in pairs(KeyValues.AbilityUpgradesKvs) do
		do
			if _.rarity ~= "n" or _.Triggerable == nil or _.script_ability == nil then
				goto a0
			end
			local a1 = _.sect
			if a1 and d(a1, T) then
				R[#R + 1] = Z
			end
		end
		::a0::
	end
	return R
end
local function a2(self, G)
	local a3 = G:FindAbilityByName("sect_wisp")
	if not IsValid(a3) then
		a3 = G:AddAbility("sect_wisp")
	end
	return a3
end
local function a4(self, G, a5)
	local a6 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf",
		PATTACH_CUSTOMORIGIN,
		G
	)
	ParticleManager:SetParticleControl(a6, 0, a5)
	ParticleManager:ReleaseParticleIndex(a6)
end
o.warlock_talent = e()
local a7 = o.warlock_talent
a7.name = "warlock_talent"
f(a7, r)
function a7.prototype.GetIntrinsicModifierName(self)
	return "modifier_warlock_talent"
end
a7 = g({ s(nil) }, a7)
o.warlock_talent = a7
o.modifier_warlock_talent = e()
local a8 = o.modifier_warlock_talent
a8.name = "modifier_warlock_talent"
f(a8, u)
function a8.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.a1_record = 0
	self.immolationThinkActive = false
	self.isHeroInfernal = false
	self.createdWispModifier = false
	self.infernalLastStandTriggered = false
end
function a8.prototype.GetAbilitySpecialValue(self)
	self.attack_interval = self:GetAbilitySpecialValueFor("attack_interval")
	self.damage_base = self:GetAbilitySpecialValueFor("damage_base")
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
	self.stun_duration = self:GetAbilitySpecialValueFor("stun_duration")
	self.summon = self:GetAbilitySpecialValueFor("summon")
	self.reduce_summon = self:GetAbilitySpecialValueFor("reduce_summon")
	self.chaos_ritual_as = self:GetAbilitySpecialValueFor("chaos_ritual_as")
	self.c1_attackspeed = self:GetAbilitySpecialValueFor("c1_attackspeed")
	self.abyssal_fusion_hp = self:GetAbilitySpecialValueFor("abyssal_fusion_hp")
	self.demonic_pact_damage = self:GetAbilitySpecialValueFor("demonic_pact_damage")
	self.c2_chance = self:GetAbilitySpecialValueFor("c2_chance")
	self.c2_base_damage = self:GetAbilitySpecialValueFor("c2_base_damage")
	self.c2_exp_damage = self:GetAbilitySpecialValueFor("c2_exp_damage")
	self.c3_interval = self:GetAbilitySpecialValueFor("c3_interval")
	self.c3_damage = self:GetAbilitySpecialValueFor("c3_damage")
	self.c3_level_damage = self:GetAbilitySpecialValueFor("c3_level_damage")
	self.c4_live_duration = self:GetAbilitySpecialValueFor("c4_live_duration")
	self.a2_damage_reply = self:GetAbilitySpecialValueFor("a2_damage_reply")
	self.a3_damage_reduce = self:GetAbilitySpecialValueFor("a3_damage_reduce")
	self.a4_health_reduce = self:GetAbilitySpecialValueFor("a4_health_reduce")
	self.a4_count = self:GetAbilitySpecialValueFor("a4_count")
	self.d2_health = self:GetAbilitySpecialValueFor("d2_health")
	self.d2_damage_pct = self:GetAbilitySpecialValueFor("d2_damage_pct")
	self.d3_health_reply = self:GetAbilitySpecialValueFor("d3_health_reply")
	self.d3_ult_interval_reduce = self:GetAbilitySpecialValueFor("d3_ult_interval_reduce")
	self.d4_summon_reduce = self:GetAbilitySpecialValueFor("d4_summon_reduce")
	self.a1_damage_pct = self:GetAbilitySpecialValueFor("a1_damage_pct")
	self.a1_tick = self:GetAbilitySpecialValueFor("a1_tick")
	self.d1_wisp_health_bonus = self:GetAbilitySpecialValueFor("d1_wisp_health_bonus")
	self.flameFistAbility = self.parent:FindAbilityByName("warlock_golem_flaming_fists")
	self.immolationAbility = self.parent:FindAbilityByName("warlock_golem_permanent_immolation")
	self.fatalBondsAbility = self.parent:FindAbilityByName("warlock_fatal_bonds")
end
function a8.prototype.OnCreated(self, a9)
	if IsServer() then
		self.highestSectExp = W(nil, self.parent)
	end
end
function a8.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_END] = { self.parent },
	}
end
function a8.prototype.ClearInfernalState(self)
	self:StartThink(-1, "immolation")
	self.immolationThinkActive = false
	if self.infernal then
		self.infernal:Dispose(true)
		self.infernal = nil
	end
	if self.secondaryInfernal then
		self.secondaryInfernal:Dispose(true)
		self.secondaryInfernal = nil
	end
	self.parent:RemoveModifierByName("modifier_warlock_infernal_form")
	self.parent:RemoveModifierByName("modifier_warlock_infernal_last_stand")
	if self.createdWispModifier then
		self.parent:RemoveModifierByName("modifier_sect_wisp")
		self.createdWispModifier = false
	end
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "abyssal_fusion_4_hp_lost", 0)
	self.isHeroInfernal = false
	self.infernalLastStandTriggered = false
end
function a8.prototype.OnClearTalent(self, a9)
	if IsServer() and a9.playerID == self.parent:GetPlayerOwnerID() then
		self:ClearInfernalState()
	end
end
function a8.prototype.OnBattleStartBefore(self, a9)
	if IsServer() then
		self.highestSectExp = W(nil, self.parent)
		self.isHeroInfernal = self:HasUpgrade("abyssal_fusion_3")
		self.infernalLastStandTriggered = false
	end
end
function a8.prototype.OnBattleStart(self, a9)
	if IsServer() then
		self.highestSectExp = W(nil, self.parent)
		self:StartIntervalThink(self:GetSummonDelay())
	end
	if self:HasUpgrade("abyssal_fusion_1") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_warlock_abyssal_fusion_1", {})
	end
	if self.a1_tick > 0 then
		self:StartThink(self.a1_tick, "a1_tick")
	end
end
function a8.prototype.OnThink(self, aa)
	if aa == "a1_tick" then
		if self.a1_record > 0 then
			local ab = self.parent:GetEnemy()
			local ac = self.a1_record * self.a1_damage_pct * 0.01
			if ac > 0 and IsInjurable(ab, self.parent) then
				self.parent:DealDamage(
					ab,
					self.fatalBondsAbility or self:GetAbility(),
					ac,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
				)
				local ad = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit_parent.vpcf",
					PATTACH_CUSTOMORIGIN,
					self.parent
				)
				ParticleManager:SetParticleControlEnt(
					ad,
					0,
					ab,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					Vector(0, 0, 0),
					true
				)
				ParticleManager:SetParticleControlEnt(
					ad,
					1,
					self.parent,
					PATTACH_POINT_FOLLOW,
					"attach_attack1",
					Vector(0, 0, 0),
					true
				)
			end
			self.a1_record = 0
		end
	end
	if aa == "immolation" then
		local ae = self.parent:GetEnemy()
		local af = self:GetImmolationDamagePct()
		if af > 0 and IsInjurable(ae, self.parent) then
			self:DealInfernalDamage(
				ae,
				self:GetImmolationDamage() * af * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				self.immolationAbility
			)
		end
	end
end
function a8.prototype.OnIntervalThink(self)
	GameTimer(0.3, function()
		self.isHeroInfernal = self:HasUpgrade("abyssal_fusion_3")
		if self.isHeroInfernal then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_warlock_infernal_form", {})
			self:StartInfernalImmolationTimer()
			if self:HasUpgrade("demonic_pact_2") and not self:HasUpgrade("demonic_pact_1") then
				self:SpawnSecondaryInfernal()
			end
		else
			self:SpawnInfernal()
		end
	end)
	self:StartIntervalThink(-1)
end
function a8.prototype.EnsureWispModifier(self)
	if not self.parent:HasModifier("modifier_sect_wisp") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_sect_wisp", {})
		self.createdWispModifier = true
	end
end
function a8.prototype.OnFirstWispSpawn(self, a9)
	if not IsServer() then
		return
	end
	if not self:HasUpgrade("demonic_pact_1") then
		return
	end
	local ag = self.isHeroInfernal or self:HasUpgrade("abyssal_fusion_3")
	if ag then
		if self.infernal and not self.infernal.disposed then
			self.infernal:Dispose(true)
			self.infernal = nil
		end
		if self:HasUpgrade("demonic_pact_2") then
			self:SpawnSecondaryInfernal()
		end
		return
	end
end
function a8.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS,
	}
end
function a8.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function a8.prototype.EOM_GetModifierMinHealth(self, a9)
	if not self.infernalLastStandTriggered and self:HasUpgrade("chaos_ritual_4") and self.c4_live_duration > 0 then
		return 1
	end
end
function a8.prototype.EOM_GetModifierHealthBonus(self, a9)
	return self.abyssal_fusion_hp * self:GetUpgradeCount(1)
end
function a8.prototype.EOM_GetModifierWispHealthBonus(self, a9)
	if self:HasUpgrade("demonic_pact_1") then
		return self.d1_wisp_health_bonus
	end
end
function a8.prototype.GetInfernalDamage(self)
	return (self.damage_base + self.highestSectExp * self.damage_bonus)
		* (1 + self.demonic_pact_damage * self:GetUpgradeCount(2) * 0.01)
end
function a8.prototype.GetImmolationDamage(self)
	return self.c3_damage + self.c3_level_damage * self.highestSectExp
end
function a8.prototype.StartInfernalImmolationTimer(self)
	if self.immolationThinkActive or not self:HasUpgrade("chaos_ritual_3") or self.c3_interval <= 0 then
		return
	end
	self.immolationThinkActive = true
	self:StartThink(self.c3_interval, "immolation")
end
function a8.prototype.GetImmolationDamagePct(self)
	local af = self.isHeroInfernal and 100 or 0
	if self.infernal and not self.infernal.disposed then
		af = af + self.infernal.damagePct
	end
	if self.secondaryInfernal and not self.secondaryInfernal.disposed then
		af = af + self.secondaryInfernal.damagePct
	end
	return af
end
function a8.prototype.GetSummonDelay(self)
	local ah = self.summon - self:GetLearnedEvolutionPointCount()
	if self:HasUpgrade("demonic_pact_4") then
		ah = ah - self.d4_summon_reduce
	end
	return math.max(0, ah)
end
function a8.prototype.GetLearnedEvolutionPointCount(self)
	local ai = 0
	do
		local L = 0
		while L < 3 do
			ai = ai + self:GetUpgradeCount(L)
			L = L + 1
		end
	end
	return ai
end
function a8.prototype.OnCustomAttackLanded(self, aj)
	if not IsServer() then
		return
	end
	if not self.isHeroInfernal then
		return
	end
	if bit.band(aj.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK) == DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK then
		return
	end
	if not IsInjurable(aj.target, self.parent) then
		return
	end
	self:OnInfernalAttackLanded(aj.target, aj.damage)
end
function a8.prototype.OnBattleEnd(self, a9)
	if IsServer() then
		self:ClearInfernalState()
		self:StartIntervalThink(-1)
		self:StartThink(-1, "a1_tick")
		self:StartThink(-1, "immolation")
	end
end
function a8.prototype.OnRoundEnd(self, a9)
	if IsServer() then
		self:ClearInfernalState()
		self:StartIntervalThink(-1)
	end
end
function a8.prototype.DealInfernalDamage(self, ak, al, am, an)
	if not IsInjurable(ak, self.parent) then
		return
	end
	self.parent:DealDamage(ak, an or self:GetAbility(), al, am)
	self:TriggerInfernalHitEffects(ak, al)
end
function a8.prototype.DealInfernalAttack(self, ak, al, af)
	if af == nil then
		af = 100
	end
	self:DealInfernalBasicAttack(ak, al * af * 0.01)
	if self:HasUpgrade("chaos_ritual_2") and self.c2_chance > 0 and self:PRD(self.c2_chance) then
		self:DealInfernalDamage(
			ak,
			(self.c2_base_damage + self.c2_exp_damage * self.highestSectExp) * af * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.flameFistAbility
		)
	end
end
function a8.prototype.DealInfernalBasicAttack(self, ak, al)
	if not IsInjurable(ak, self.parent) then
		return
	end
	if self:HasUpgrade("chaos_ritual_1") then
		DamageSystem:performAttack(
			self.parent,
			ak,
			{
				damage = al,
				ability = self:GetAbility(),
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
				damage_flags = DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK + DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK,
			}
		)
	else
		self.parent:DealDamage(ak, self:GetAbility(), al, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
	self:TriggerInfernalHitEffects(ak, al)
end
function a8.prototype.OnInfernalAttackLanded(self, ak, al)
	self:TriggerInfernalHitEffects(ak, al)
	if self:HasUpgrade("chaos_ritual_2") and self.c2_chance > 0 and self:PRD(self.c2_chance) then
		self:DealInfernalDamage(
			ak,
			self.c2_base_damage + self.c2_exp_damage * self.highestSectExp,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.flameFistAbility
		)
	end
end
function a8.prototype.TriggerInfernalSkillSet(self, ak, ao)
	if not IsInjurable(ak, self.parent) then
		return
	end
	self:DealInfernalBasicAttack(ak, self:GetInfernalDamage())
	if self:HasUpgrade("chaos_ritual_2") and self.c2_base_damage > 0 then
		self:DealInfernalDamage(
			ak,
			self.c2_base_damage + self.c2_exp_damage * self.highestSectExp,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.flameFistAbility
		)
	end
	if self:HasUpgrade("chaos_ritual_3") and self:GetImmolationDamage() > 0 then
		self:DealInfernalDamage(
			ak,
			self:GetImmolationDamage(),
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.immolationAbility
		)
	end
end
function a8.prototype.TriggerInfernalSkillSetByHealthLoss(self, ao)
	local ae = self.parent:GetEnemy()
	if not IsInjurable(ae, self.parent) then
		return
	end
	if self.isHeroInfernal then
		self:TriggerInfernalSkillSet(ae, ao)
	elseif self.infernal and not self.infernal.disposed then
		self.infernal:UpdatePosition()
		GameTimer(0.3, function()
			if not IsValid(self) or not self.infernal or self.infernal.disposed then
				return
			end
			self:TriggerInfernalSkillSet(ae, ao)
		end)
	end
end
function a8.prototype.TriggerInfernalHitEffects(self, ak, al)
	if self:HasUpgrade("abyssal_fusion_2") and self.a2_damage_reply > 0 then
		Heal(self.parent, al * self.a2_damage_reply * 0.01, "warlock_talent", "Ability")
	end
end
function a8.prototype.TriggerCataclysm(self, ak)
	local T = O(nil, self.parent)
	if not T then
		return
	end
	local ap = Y(nil, self.parent, T)
	if #ap == 0 then
		return
	end
	do
		local L = 0
		while L < #ap do
			TriggerSectAbilityByName(self.parent, ap[L + 1])
			L = L + 1
		end
	end
end
function a8.prototype.HasActiveInfernal(self)
	return self.isHeroInfernal
		or self.infernal ~= nil and not self.infernal.disposed
		or self.secondaryInfernal ~= nil and not self.secondaryInfernal.disposed
end
function a8.prototype.HasActiveInfernalUnit(self)
	return self.infernal ~= nil and not self.infernal.disposed
		or self.secondaryInfernal ~= nil and not self.secondaryInfernal.disposed
end
function a8.prototype.OnCustomTakeDamage(self, aj)
	if IsServer() then
		if
			not self.infernalLastStandTriggered
			and self:HasUpgrade("chaos_ritual_4")
			and self.c4_live_duration > 0
			and self.parent:GetHealth() <= 1
		then
			self.infernalLastStandTriggered = true
			self.parent:AddNewModifier(
				self.parent,
				self:GetAbility(),
				"modifier_warlock_infernal_last_stand",
				{ duration = self.c4_live_duration }
			)
			return
		end
		if self.infernalLastStandTriggered then
			return
		end
		local ae = self.parent:GetEnemy()
		if
			self:HasActiveInfernal()
			and self:HasUpgrade("abyssal_fusion_1")
			and self.a1_damage_pct > 0
			and aj.damage > 0
			and bit.band(aj.damage_flags or 0, DamageFlags.DAMAGE_FLAG_REFLECTION)
				~= DamageFlags.DAMAGE_FLAG_REFLECTION
		then
			self.a1_record = self.a1_record + aj.damage
		end
		if self:HasActiveInfernal() and self:HasUpgrade("abyssal_fusion_4") and self.a4_health_reduce > 0 then
			local aq = self.a4_health_reduce
			self:AddCount(aj.damage, "abyssal_fusion_4_hp_lost")
			local ar = self:GetCount("abyssal_fusion_4_hp_lost")
			if ar >= aq and self.parent:GetHealth() > 0 then
				local as = math.floor(ar / aq)
				self:AddCount(-as * aq, "abyssal_fusion_4_hp_lost")
				do
					local L = 0
					while L < as do
						do
							local at = 0
							while at < self.a4_count do
								self:TriggerInfernalSkillSetByHealthLoss(aq)
								at = at + 1
							end
						end
						L = L + 1
					end
				end
			end
		end
	end
end
function a8.prototype.OnDestroy(self)
	if self.infernal ~= nil then
		self.infernal:Dispose()
	end
	if self.secondaryInfernal ~= nil then
		self.secondaryInfernal:Dispose()
	end
end
function a8.prototype.GetFirstWisp(self)
	local au = self.parent:FindModifierByName("modifier_sect_wisp")
	if not IsValid(au) then
		return
	end
	local av = au:GetWispList()
	do
		local L = 0
		while L < #av do
			local aw = av[L + 1]
			if aw.first and IsValid(aw.wisp) then
				return aw.wisp
			end
			L = L + 1
		end
	end
end
function a8.prototype.SpawnInfernal(self)
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	EmitSoundOn("Warlock_Imp.Explode", self.parent)
	GameTimer(0.4, function()
		if self.isHeroInfernal then
			return
		end
		if self.infernal and not self.infernal.disposed then
			self.infernal:Dispose(true)
		end
		local ax
		AddStun(self.parent, self.parent:GetEnemy(), self:GetAbility(), self.stun_duration)
		if self:HasUpgrade("demonic_pact_1") then
			ax = self:GetFirstWisp()
			if not IsValid(ax) then
				self:EnsureWispModifier()
			end
		end
		self.infernal = h(p, self:GetInfernalProps(false, ax))
		if self:HasUpgrade("demonic_pact_2") then
			self:SpawnSecondaryInfernal()
		end
		self:StartInfernalImmolationTimer()
	end)
end
function a8.prototype.SpawnSecondaryInfernal(self)
	if self:HasUpgrade("demonic_pact_1") then
		self:EnsureWispModifier()
	end
	if self.secondaryInfernal and not self.secondaryInfernal.disposed then
		self.secondaryInfernal:Dispose(true)
	end
	self.secondaryInfernal = h(p, self:GetInfernalProps(true))
	self:StartInfernalImmolationTimer()
end
function a8.prototype.GetInfernalProps(self, ay, ax)
	return {
		parent = self.parent,
		enemy = self.parent:GetEnemy(),
		ability = self:GetAbility(),
		buff = self,
		attack_interval = self.attack_interval,
		damage_base = self.damage_base,
		damage_bonus = self.damage_bonus,
		highestSectExp = self.highestSectExp,
		bonusAS = self:GetBonusAS(),
		bonusDamagePct = self.demonic_pact_damage * self:GetUpgradeCount(2),
		hasSectAttack = self:HasUpgrade("chaos_ritual_1"),
		hasFlameFist = self:HasUpgrade("chaos_ritual_2"),
		isWisp = self:HasUpgrade("demonic_pact_1"),
		wispBonusHP = ay and self.d2_health or self.d1_wisp_health_bonus,
		damagePct = ay and self.d2_damage_pct or 100,
		isSecondary = ay,
		existingWisp = ax,
		c2_chance = self.c2_chance,
		c2_base_damage = self.c2_base_damage,
		c2_exp_damage = self.c2_exp_damage,
	}
end
function a8.prototype.HasUpgrade(self, az)
	return AbilityUpgrades:HasAbilityMechanicsUpgradeByID(self.parent:GetPlayerOwnerID(), az)
end
function a8.prototype.GetUpgradeCount(self, aA)
	local aB = self.parent:GetPlayerOwnerID()
	local ai = 0
	local aC = H[aA]
	if aC then
		for aD, aE in ipairs(aC) do
			if AbilityUpgrades:HasAbilityMechanicsUpgradeByID(aB, aE) then
				ai = ai + 1
			end
		end
	end
	return ai
end
function a8.prototype.GetBonusAS(self)
	local aF = self.chaos_ritual_as * self:GetUpgradeCount(0)
	if self:HasUpgrade("chaos_ritual_1") then
		aF = aF + self.c1_attackspeed
	end
	return aF
end
a8 = g(
	{
		v(
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
	a8
)
o.modifier_warlock_talent = a8
o.warlock_interact = e()
local aG = o.warlock_interact
aG.name = "warlock_interact"
f(aG, A)
function aG.prototype.GetAbilityTextureName(self)
	return "warlock/warlock_ti10_immortal_ability_icons/warlock_fatal_bonds_ti10"
end
function aG.prototype.OnSpellStart(self)
	if self:GetCaster():IsCustomIllusion() then
		return
	end
	if self:GetCurrentAbilityCharges() <= 0 then
		return
	end
	local aH = self:GetCaster():FindModifierByName("modifier_warlock_interact")
	if aH then
		aH:Effect()
	end
end
function aG.prototype.GetIntrinsicModifierName(self)
	return "modifier_warlock_interact"
end
aG = g({ B(nil, { DisableToggle = true }) }, aG)
o.warlock_interact = aG
o.modifier_warlock_interact = e()
local aI = o.modifier_warlock_interact
aI.name = "modifier_warlock_interact"
f(aI, u)
function aI.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.pending_dirs = {}
	self.display_talent_learning = {}
	self.shard_pending = false
	self.shard_point = 0
end
function aI.prototype.OnCreated(self, a9)
	if IsServer() then
		self.pending_dirs = self:LoadDirs()
		self:LoadShardState()
		self:StartIntervalThink(0)
		self:CheckStartBonus()
		self:CheckShard()
		self:UpdateEvolutionPoint()
	end
end
function aI.prototype.OnIntervalThink(self)
	if self.parent:GetPlayerOwnerID() ~= -1 then
		self:StartIntervalThink(-1)
		self.pending_dirs = self:LoadDirs()
		self:LoadShardState()
		self:UpdateEvolutionPoint()
		self:CheckStartBonus()
		self:CheckShard()
	end
end
function aI.prototype.OnRefresh(self, a9)
	if IsServer() then
		self.pending_dirs = self:LoadDirs()
		self:LoadShardState()
		self:CheckStartBonus()
		self:CheckShard()
		self:UpdateEvolutionPoint()
	end
end
function aI.prototype.GetEvoCount(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_evo_cnt") or 0
end
function aI.prototype.SetEvoCount(self, aJ)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_evo_cnt", aJ)
end
function aI.prototype.GetShardFlag(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_shard_flg") or 0
end
function aI.prototype.SetShardFlag(self, aK)
	if aK == nil then
		aK = 1
	end
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_shard_flg", aK)
end
function aI.prototype.GetStartBonusFlag(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_start_bonus_flg") or 0
end
function aI.prototype.SetStartBonusFlag(self, aK)
	if aK == nil then
		aK = 1
	end
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_start_bonus_flg", aK)
end
function aI.prototype.GetShardPending(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_shard_pending") == 1
end
function aI.prototype.SetShardPending(self, aL)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_shard_pending", aL and 1 or 0)
end
function aI.prototype.GetShardPoint(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_shard_point") or 0
end
function aI.prototype.SetShardPoint(self, aM)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_shard_point", aM)
end
function aI.prototype.LoadDirs(self)
	local aN = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_evo_dirs")
	if not aN or #aN == 0 then
		return {}
	end
	local aO = i(aN, ",")
	local R = {}
	for aD, aP in ipairs(aO) do
		R[#R + 1] = j(aP)
	end
	return R
end
function aI.prototype.SaveDirs(self)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_evo_dirs", table.concat(self.pending_dirs, ","))
end
function aI.prototype.LoadShardState(self)
	if self:GetShardPending() then
		self.shard_pending = true
		self.shard_point = self:GetShardPoint()
	end
end
function aI.prototype.CheckShard(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	if self:HasTalent("warlock_shard") and self:GetShardFlag() == 0 then
		local aQ = self:GetAbilityTalentValue("warlock_shard", "upgrade_point")
		if aQ > 0 then
			self:AddDirectionPendingPoint(aQ)
			self:SetShardFlag()
		end
	end
end
function aI.prototype.CheckStartBonus(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	if self:GetStartBonusFlag() == 0 then
		self:AddDirectionPendingPoint(1)
		self:SetStartBonusFlag()
	end
end
function aI.prototype.AddDirectionPendingPoint(self, ai)
	if ai <= 0 then
		return
	end
	self.shard_point = self.shard_point + ai
	self.shard_pending = true
	self:SetShardPending(true)
	self:SetShardPoint(self.shard_point)
	self:SetEvoCount(self:GetEvoCount() + ai)
	self:UpdateEvolutionPoint()
end
function aI.prototype.AddEvolutionPoint(self, ai, aR)
	if self.parent:IsCustomIllusion() then
		return
	end
	if aR ~= nil then
		do
			local L = 0
			while L < ai do
				local aS = self.pending_dirs
				aS[#aS + 1] = aR
				L = L + 1
			end
		end
		self:SaveDirs()
	end
	if ai > 0 then
		self:SetEvoCount(self:GetEvoCount() + ai)
		self:UpdateEvolutionPoint()
	end
end
function aI.prototype.ReduceEvolutionPoint(self, aT)
	if self.parent:IsCustomIllusion() then
		return
	end
	local ai = self:GetEvoCount()
	if ai > 0 then
		aT = math.min(aT, ai)
		self:SetEvoCount(ai - aT)
	end
	self:UpdateEvolutionPoint()
end
function aI.prototype.UpdateEvolutionPoint(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aB = self.parent:GetPlayerOwnerID()
	local ai = self:GetEvoCount()
	if PlayerData:isRobot(aB) then
		if ai > 0 then
			self:Effect()
		end
	else
		self.ability:SetCurrentAbilityCharges(ai)
	end
end
function aI.prototype.ShowShardDirectionSelection(self, aB)
	local aU = { H[0][1], H[1][1], H[2][1] }
	self.selection_key = Selection:AddSpecialSelection(aB, "ability_upgrades_mechenics", aU, function(aD, R)
		if not IsValid(self) then
			return true
		end
		self.selection_key = nil
		if not R or R == "" then
			return true
		end
		for aV, aC in pairs(H) do
			if aC[1] == R then
				k(self.pending_dirs, aV)
				break
			end
		end
		self.shard_point = self.shard_point - 1
		if self.shard_point <= 0 then
			self.shard_pending = false
			self.shard_point = 0
			self:SetShardPending(false)
			self:SetShardPoint(0)
		else
			self:SetShardPoint(self.shard_point)
		end
		self:SaveDirs()
		self:Effect()
		return true
	end, nil, nil, nil, true)
end
function aI.prototype.Effect(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aB = self.parent:GetPlayerOwnerID()
	if self.selection_key then
		Selection:RemoveSpecialSelection(aB, self.selection_key)
		self.selection_key = nil
		return
	end
	if self.shard_pending then
		self:ShowShardDirectionSelection(aB)
		return
	end
	if #self.pending_dirs == 0 then
		return
	end
	local aR = self.pending_dirs[1]
	local aW = {}
	local aC = H[aR]
	if aC then
		for aD, aE in ipairs(aC) do
			if not AbilityUpgrades:HasAbilityMechanicsUpgradeByID(aB, aE) then
				aW[#aW + 1] = aE
			end
		end
	end
	if #aW > 0 then
		if PlayerData:isRobot(aB) then
			GameTimer(1, function()
				if IsValid(self) then
					self:AddEvolutionEffect(aW[RandomInt(0, #aW - 1) + 1])
				end
			end)
		else
			self.selection_key = Selection:AddSpecialSelection(aB, "ability_upgrades_mechenics", aW, function(aD, R)
				if not IsValid(self) then
					return true
				end
				self.selection_key = nil
				if R and R ~= "" then
					self:AddEvolutionEffect(R)
				end
				return true
			end)
		end
	end
end
function aI.prototype.AddEvolutionEffect(self, R)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aB = self.parent:GetPlayerOwnerID()
	AbilityUpgrades:AddAbilityMechanicsUpgradeByID(aB, R, "warlock_interact")
	AbilityUpgrades:AddAbilityMechanicsUpgradeByID(aB, R)
	self:ReduceEvolutionPoint(1)
	if #self.pending_dirs > 0 then
		table.remove(self.pending_dirs, 1)
	end
	self:SaveDirs()
	local aR = -1
	for aV, aC in pairs(H) do
		if l(aC, R) then
			aR = aV
			break
		end
	end
	local aX = PlayerData:getplayerData(aB)
	if aX and aR >= 0 then
		aX:modifyHeroAbilityExtraData("warlock_talent", ("warlock_interact_type_" .. tostring(aR)) .. "_count", 1)
	end
end
function aI.prototype.ResetEvolution(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aB = self.parent:GetPlayerOwnerID()
	if self.selection_key then
		Selection:RemoveSpecialSelection(aB, self.selection_key)
		self.selection_key = nil
	end
	self.pending_dirs = {}
	self.display_talent_learning = {}
	self.shard_pending = false
	self.shard_point = 0
	self:SetEvoCount(0)
	self:SaveDirs()
	self:SetShardFlag(0)
	self:SetStartBonusFlag(0)
	self:SetShardPending(false)
	self:SetShardPoint(0)
	for aY, aC in pairs(H) do
		do
			local L = 0
			while L < #aC do
				local az = aC[L + 1]
				AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(aB, az)
				AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(aB, az, "warlock_interact")
				L = L + 1
			end
		end
	end
	local aX = PlayerData:getplayerData(aB)
	if aX then
		do
			local L = 0
			while L < 3 do
				aX:modifyHeroAbilityExtraData(
					"warlock_talent",
					("warlock_interact_type_" .. tostring(L)) .. "_count",
					0,
					true,
					true
				)
				L = L + 1
			end
		end
	end
	if self.parent:IsHero() then
		self.parent:CalculateStatBonus(true)
	else
		self.parent:CalculateGenericBonuses()
	end
	self:UpdateEvolutionPoint()
end
function aI.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = { self.parent },
	}
end
function aI.prototype.OnClearTalent(self, a9)
	if IsServer() and a9.playerID == self.parent:GetPlayerOwnerID() then
		self:ResetEvolution()
	end
end
function aI.prototype.OnBattleEnd(self, a9)
	self:SaveDirs()
end
function aI.prototype.OnBattleStartBefore(self, a9)
	self:CheckStartBonus()
	self:CheckShard()
end
function aI.prototype.OnTalentLearn(self, a9)
	if self:ConsumeDisplayTalentLearn(a9.talentName) then
		return
	end
	if a9.talentName == "warlock_shard" then
		self:CheckShard()
		return
	end
	local aR = N(nil, a9.talentName)
	if aR >= 0 then
		self:AddEvolutionPoint(1, aR)
		self:LearnTalentRowForDisplay(a9.talentName)
	end
end
function aI.prototype.ConsumeDisplayTalentLearn(self, K)
	local aZ = c(self.display_talent_learning, K)
	if aZ == -1 then
		return false
	end
	m(self.display_talent_learning, aZ, 1)
	return true
end
function aI.prototype.LearnTalentRowForDisplay(self, K)
	local M = J(nil, K)
	if not M then
		return
	end
	local P = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	if not P then
		return
	end
	do
		local L = 0
		while L < #M do
			do
				local a_ = M[L + 1]
				if a_ == K then
					goto b0
				end
				if l(P.heroTalentBranch, a_) then
					goto b0
				end
				local b1 = self.display_talent_learning
				b1[#b1 + 1] = a_
				P:learnTalent(a_)
			end
			::b0::
			L = L + 1
		end
	end
end
aI = g(
	{
		v(
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
	aI
)
o.modifier_warlock_interact = aI
p = e()
p.name = "Infernal"
function p.prototype.____constructor(self, b2)
	self.disposed = false
	self.parent = b2.parent
	self.enemy = b2.enemy
	self.ability = b2.ability
	self.buff = b2.buff
	self.attack_interval = b2.attack_interval
	self.damage_base = b2.damage_base
	self.damage_bonus = b2.damage_bonus
	self.highestSectExp = b2.highestSectExp
	self.bonusAS = b2.bonusAS
	self.bonusDamagePct = b2.bonusDamagePct
	self.hasSectAttack = b2.hasSectAttack
	self.hasFlameFist = b2.hasFlameFist
	self.isWisp = b2.isWisp
	self.wispBonusHP = b2.wispBonusHP
	self.damagePct = b2.damagePct
	self.isSecondary = b2.isSecondary
	self.wisp = b2.existingWisp
	self.c2_chance = b2.c2_chance
	self.c2_base_damage = b2.c2_base_damage
	self.c2_exp_damage = b2.c2_exp_damage
	self:Spawn()
end
function p.prototype.Spawn(self)
	if self.disposed then
		return
	end
	local b3 = self.parent:GetForwardVector()
	local b4 = Vector(-b3.y, b3.x, 0)
	local b5 = 150
	self.position = self.parent:GetAbsOrigin() + b4 * (self.isSecondary and -b5 or b5)
	self:PlaySummonParticle()
	if self.isWisp then
		if not IsValid(self.wisp) then
			self.wisp = SummonWisp(self.parent, self.wispBonusHP, F(nil, self.parent))
		end
		if self.wisp then
			self.wisp:SetAbsOrigin(self.position)
			self.wisp:SetForwardVector(b3)
			local au = self.wisp:AddNewModifier(self.parent, self.ability, "modifier_warlock_infernal_wisp", {})
			if au then
				au.owner = self
			end
			self:SpawnDummy(b3)
			if self.hasSectAttack then
				InheritSectAttackAbility(self.parent, self.wisp)
			end
		else
			self:SpawnDummy(b3)
		end
	else
		self:SpawnDummy(b3)
	end
	local b6 = self.attack_interval / (1 + self.bonusAS * 0.01)
	self.attackTimer = GameTimer(b6, function()
		if self.disposed then
			return
		end
		self:Attack()
		return b6
	end)
end
function p.prototype.PlaySummonParticle(self)
	a4(nil, self.parent, self.position)
end
function p.prototype.SpawnDummy(self, b3)
	self.dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = self.position,
			angles = VectorToAngles(b3),
			model = F(nil, self.parent),
			StartingAnim = "ACT_DOTA_SPAWN",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
			AnimateOnServer = "1",
		}
	)
end
function p.prototype.GetDamage(self)
	return (self.damage_base + self.highestSectExp * self.damage_bonus) * (1 + self.bonusDamagePct * 0.01)
end
function p.prototype.UpdatePosition(self)
	local b3 = self.parent:GetForwardVector()
	local b4 = Vector(-b3.y, b3.x, 0)
	local b5 = 150
	self.position = self.parent:GetAbsOrigin() + b4 * (self.isSecondary and -b5 or b5)
	if self.dummy and IsValid(self.dummy) then
		local b7 = self.dummy
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				angles = VectorToAngles(b3),
				model = F(nil, self.parent),
				StartingAnim = "ACT_DOTA_ATTACK",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				DefaultAnim = "ACT_DOTA_IDLE",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
				AnimateOnServer = "1",
			}
		)
		UTIL_Remove(b7)
	end
	if self.wisp and IsValid(self.wisp) then
		self.wisp:SetAbsOrigin(self.position)
	end
end
function p.prototype.Attack(self)
	if self.disposed then
		return
	end
	if not IsInjurable(self.enemy, self.parent) then
		return
	end
	self:UpdatePosition()
	local al = self:GetDamage()
	GameTimer(0.3, function()
		if self.disposed then
			return
		end
		if not IsInjurable(self.enemy, self.parent) then
			return
		end
		self.parent:EmitSound("Hero_WarlockGolem.Attack")
		self.buff:DealInfernalAttack(self.enemy, al, self.damagePct)
	end)
end
function p.prototype.Dispose(self, b8)
	if self.disposed then
		return
	end
	self.disposed = true
	self:Cleanup()
end
function p.prototype.Cleanup(self)
	if self.attackTimer ~= nil then
		StopTimer(self.attackTimer)
		self.attackTimer = nil
	end
	if self.dummy and IsValid(self.dummy) then
		local b9 = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				angles = self.dummy:GetAngles(),
				model = F(nil, self.parent),
				DefaultAnim = "ACT_DOTA_DIE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			}
		)
		UTIL_Remove(self.dummy)
		self.dummy = nil
		GameTimer(1, function()
			if b9 and IsValid(b9) then
				UTIL_Remove(b9)
			end
		end)
	end
	if self.wisp and IsValid(self.wisp) then
		KillWisp(self.parent, self.wisp, true, false)
	end
	self.wisp = nil
end
o.modifier_warlock_infernal_last_stand = e()
local ba = o.modifier_warlock_infernal_last_stand
ba.name = "modifier_warlock_infernal_last_stand"
f(ba, u)
function ba.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.battleEnd = false
end
function ba.prototype.OnCreated(self, a9)
	if IsServer() then
		self.buff = self.parent:FindModifierByName("modifier_warlock_talent")
		self.enemy = self.parent:GetEnemy()
		self.parent:SetHealth(1)
		self.parent:AddNoDraw()
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
		if IsValid(self.buff) and not self.buff:HasActiveInfernalUnit() then
			self.infernal = h(p, self.buff:GetInfernalProps(false))
		end
	end
end
function ba.prototype.OnDestroy(self)
	if IsServer() then
		if self.infernal then
			self.infernal:Dispose(true)
			self.infernal = nil
		end
		self.parent:RemoveNoDraw()
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
		if
			not self.battleEnd
			and IsInjurable(self.parent)
			and IsValid(self.enemy)
			and IsInjurable(self.parent, self.enemy)
		then
			DamageSystem:kill(self.enemy, self.parent, self:GetAbility())
		end
	end
end
function ba.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function ba.prototype.EOM_GetModifierMinHealth(self, a9)
	return 1
end
function ba.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function ba.prototype.OnBattleEnd(self, a9)
	self.battleEnd = true
	self:Destroy()
end
ba = g(
	{
		v(
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
	ba
)
o.modifier_warlock_infernal_last_stand = ba
o.modifier_warlock_infernal_form = e()
local bb = o.modifier_warlock_infernal_form
bb.name = "modifier_warlock_infernal_form"
f(bb, u)
function bb.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.isHeroTransform = false
end
function bb.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("a3_damage_reduce")
end
function bb.prototype.OnCreated(self, a9)
	if IsServer() then
		self.buff = self.parent:FindModifierByName("modifier_warlock_talent")
		if IsValid(self.buff) and self.buff.isHeroInfernal then
			self.isHeroTransform = true
			a4(nil, self.parent, self.parent:GetAbsOrigin())
			self.originalModel = self.parent:GetModelName()
			self.parent:SetOriginalModel(F(nil, self.parent))
			self.parent:ManageModelChanges()
			self.parent:SetWearablesVisible(false)
			self.parent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
		end
	end
end
function bb.prototype.OnDestroy(self)
	if IsServer() then
		if self.isHeroTransform then
			if self.originalModel then
				self.parent:SetOriginalModel(self.originalModel)
				self.parent:ManageModelChanges()
			end
			self.parent:SetWearablesVisible(true)
			self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
		end
	end
end
function bb.prototype.ECheckState(self)
	if self.isHeroTransform and self.buff and self.buff:HasUpgrade("demonic_pact_1") then
		return { [EOMModifierStates.MODIFIER_STATE_HERO_WISP] = true }
	end
	return {}
end
function bb.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_INTERVAL_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL,
	}
end
function bb.prototype.EFunctionValues(self)
	if self.isHeroTransform then
		return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = F(nil, self.parent) }
	end
	return {}
end
function bb.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -self.damage_reduce
end
function bb.prototype.EOM_GetModifierAttackIntervalConstant(self, a9)
	if not self.isHeroTransform or not self.buff then
		return
	end
	local bc = self.buff:GetBonusAS()
	return self.buff.attack_interval / (1 + bc * 0.01)
end
function bb.prototype.EOM_GetModifierAttackDamageBase(self, a9)
	if not self.isHeroTransform or not self.buff then
		return
	end
	return self.buff:GetInfernalDamage() - self.parent:GetBaseDamageMax()
end
function bb.prototype.EOM_GetModifierAttackSourceAbility(self, a9)
	if self.isHeroTransform and self.buff then
		if self.buff:HasUpgrade("demonic_pact_1") then
			return a2(nil, self.parent)
		end
		return self.buff:GetAbility()
	end
end
bb = g(
	{
		v(
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
	bb
)
o.modifier_warlock_infernal_form = bb
o.modifier_warlock_infernal_wisp = e()
local bd = o.modifier_warlock_infernal_wisp
bd.name = "modifier_warlock_infernal_wisp"
f(bd, u)
function bd.prototype.OnCreated(self, a9)
	if IsServer() then
		self.parent:AddNoDraw()
	end
end
function bd.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED] = true }
end
function bd.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL }
end
function bd.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = F(nil, self:GetCaster()) }
end
function bd.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:RemoveNoDraw()
	end
	if IsServer() and self.owner and not self.owner.disposed then
		self.owner:Dispose(false)
	end
end
bd = g(
	{
		v(
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
	bd
)
o.modifier_warlock_infernal_wisp = bd
o.warlock_ult = e()
local be = o.warlock_ult
be.name = "warlock_ult"
f(be, x)
function be.prototype.OnSpellStart(self)
	local bf = self:GetCaster()
	local ae = bf:GetEnemy()
	if not IsInjurable(ae) then
		return
	end
	bf:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	GameTimer(0.3, function()
		if IsInjurable(ae, bf) then
			ae:EmitSound("Hero_Warlock.ShadowWordCastBad")
			ae:AddNewModifier(bf, self, "modifier_warlock_ult", { duration = self:GetSpecialValueFor("duration") })
		end
	end)
end
be = g({ y(nil) }, be)
o.warlock_ult = be
o.modifier_warlock_ult = e()
local bg = o.modifier_warlock_ult
bg.name = "modifier_warlock_ult"
f(bg, u)
function bg.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.heal_amount = 0
end
function bg.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilitySpecialValueFor("d3_ult_interval_reduce")
	self.damage_magic = self:GetAbilitySpecialValueFor("damage_magic")
	self.heal_amount = self:GetAbilitySpecialValueFor("d3_health_reply")
end
function bg.prototype.OnCreated(self, a9)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:IncrementStackCount()
	end
	EmitSoundOn("Hero_Warlock.ShadowWord", self.parent)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_warlock/warlock_shadow_word_debuff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		self:GetCaster()
	)
end
function bg.prototype.OnRefresh(self, a9)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function bg.prototype.OnIntervalThink(self)
	if IsServer() then
		local bf = self:GetCaster()
		local ak = self:GetParent()
		if IsInjurable(ak, bf) then
			bf:DealDamage(
				ak,
				self:GetAbility(),
				self.damage_magic * self:GetStackCount(),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			if self.heal_amount > 0 then
				Heal(bf, self.heal_amount * self:GetStackCount(), "warlock_ult", "Ability")
			end
		end
	end
end
function bg.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
	if self.particleID ~= nil then
		ParticleManager:DestroyParticle(self.particleID, true)
		ParticleManager:ReleaseParticleIndex(self.particleID)
		self.particleID = nil
	end
	StopSoundOn("Hero_Warlock.ShadowWord", self.parent)
end
bg = g(
	{
		v(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
				IsIndependent = true,
			}
		),
	},
	bg
)
o.modifier_warlock_ult = bg
o.modifier_warlock_ult_caster = e()
local bh = o.modifier_warlock_ult_caster
bh.name = "modifier_warlock_ult_caster"
f(bh, u)
bh = g(
	{
		v(
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
	bh
)
o.modifier_warlock_ult_caster = bh
o.modifier_warlock_abyssal_fusion_1 = e()
local bi = o.modifier_warlock_abyssal_fusion_1
bi.name = "modifier_warlock_abyssal_fusion_1"
f(bi, u)
function bi.prototype.OnCreated(self, a9)
	if IsServer() then
		local ae = self.parent:GetEnemy()
		if IsValid(ae) then
			self.fatalBondsIconParticleId = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				ae
			)
		end
	end
end
function bi.prototype.OnDestroy(self)
	if self.fatalBondsIconParticleId then
		ParticleManager:DestroyParticle(self.fatalBondsIconParticleId, false)
		self.fatalBondsIconParticleId = nil
	end
end
bi = g(
	{
		v(
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
	bi
)
o.modifier_warlock_abyssal_fusion_1 = bi
o.warlock_shard = e()
local bj = o.warlock_shard
bj.name = "warlock_shard"
f(bj, r)
function bj.prototype.GetIntrinsicModifierName(self)
	return "modifier_warlock_shard"
end
bj = g({ s(nil) }, bj)
o.warlock_shard = bj
o.modifier_warlock_shard = e()
local bk = o.modifier_warlock_shard
bk.name = "modifier_warlock_shard"
f(bk, u)
function bk.prototype.OnCreated(self, a9)
	if IsServer() then
		local bl = self.parent:FindModifierByName("modifier_warlock_interact")
		if IsValid(bl) then
			bl:CheckShard()
		end
	end
end
bk = g(
	{
		v(
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
	bk
)
o.modifier_warlock_shard = bk
return o