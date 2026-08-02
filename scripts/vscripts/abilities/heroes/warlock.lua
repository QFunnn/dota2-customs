--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["16"] = 1068,
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
		["31"] = 10,
		["32"] = 11,
		["33"] = 12,
		["35"] = 14,
		["36"] = 10,
		["38"] = 18,
		["39"] = 24,
		["40"] = 30,
		["42"] = 31,
		["43"] = 31,
		["44"] = 32,
		["45"] = 33,
		["46"] = 33,
		["48"] = 31,
		["51"] = 30,
		["52"] = 37,
		["53"] = 38,
		["54"] = 38,
		["56"] = 39,
		["57"] = 39,
		["59"] = 40,
		["60"] = 40,
		["62"] = 41,
		["63"] = 37,
		["64"] = 44,
		["65"] = 45,
		["66"] = 46,
		["69"] = 47,
		["70"] = 48,
		["71"] = 49,
		["73"] = 50,
		["74"] = 50,
		["75"] = 51,
		["76"] = 52,
		["77"] = 52,
		["78"] = 53,
		["79"] = 54,
		["80"] = 55,
		["82"] = 50,
		["85"] = 58,
		["86"] = 44,
		["87"] = 61,
		["88"] = 62,
		["89"] = 63,
		["90"] = 63,
		["92"] = 64,
		["93"] = 65,
		["95"] = 66,
		["96"] = 66,
		["97"] = 67,
		["98"] = 67,
		["99"] = 68,
		["100"] = 69,
		["102"] = 66,
		["105"] = 72,
		["106"] = 61,
		["107"] = 75,
		["108"] = 76,
		["109"] = 77,
		["110"] = 77,
		["112"] = 78,
		["113"] = 79,
		["115"] = 80,
		["116"] = 80,
		["118"] = 81,
		["119"] = 82,
		["120"] = 83,
		["125"] = 86,
		["126"] = 75,
		["127"] = 89,
		["128"] = 90,
		["129"] = 91,
		["130"] = 92,
		["132"] = 94,
		["133"] = 89,
		["134"] = 97,
		["135"] = 98,
		["136"] = 99,
		["137"] = 100,
		["138"] = 97,
		["139"] = 105,
		["140"] = 106,
		["141"] = 105,
		["142"] = 106,
		["143"] = 107,
		["144"] = 108,
		["145"] = 107,
		["146"] = 106,
		["147"] = 105,
		["148"] = 106,
		["150"] = 106,
		["151"] = 112,
		["152"] = 120,
		["153"] = 112,
		["154"] = 120,
		["156"] = 120,
		["157"] = 143,
		["158"] = 158,
		["159"] = 160,
		["160"] = 161,
		["161"] = 162,
		["162"] = 112,
		["163"] = 168,
		["164"] = 169,
		["165"] = 170,
		["166"] = 171,
		["167"] = 172,
		["168"] = 173,
		["169"] = 174,
		["170"] = 175,
		["171"] = 176,
		["172"] = 177,
		["173"] = 178,
		["174"] = 182,
		["175"] = 183,
		["176"] = 184,
		["177"] = 185,
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
		["190"] = 202,
		["191"] = 203,
		["192"] = 204,
		["193"] = 207,
		["194"] = 208,
		["195"] = 209,
		["196"] = 168,
		["197"] = 212,
		["198"] = 213,
		["199"] = 214,
		["201"] = 212,
		["202"] = 218,
		["203"] = 219,
		["204"] = 219,
		["205"] = 219,
		["206"] = 219,
		["207"] = 219,
		["208"] = 219,
		["209"] = 219,
		["210"] = 219,
		["211"] = 219,
		["212"] = 219,
		["213"] = 218,
		["214"] = 231,
		["215"] = 232,
		["216"] = 233,
		["217"] = 234,
		["218"] = 235,
		["219"] = 235,
		["221"] = 237,
		["222"] = 238,
		["223"] = 238,
		["225"] = 240,
		["226"] = 241,
		["227"] = 242,
		["228"] = 243,
		["229"] = 244,
		["231"] = 246,
		["232"] = 246,
		["233"] = 246,
		["234"] = 246,
		["235"] = 246,
		["236"] = 247,
		["237"] = 248,
		["238"] = 231,
		["239"] = 251,
		["240"] = 252,
		["241"] = 253,
		["243"] = 251,
		["244"] = 257,
		["245"] = 258,
		["246"] = 259,
		["247"] = 260,
		["248"] = 261,
		["250"] = 257,
		["251"] = 265,
		["252"] = 266,
		["253"] = 267,
		["254"] = 269,
		["256"] = 271,
		["257"] = 272,
		["258"] = 272,
		["259"] = 272,
		["260"] = 272,
		["261"] = 272,
		["262"] = 272,
		["264"] = 274,
		["265"] = 275,
		["267"] = 265,
		["268"] = 278,
		["269"] = 279,
		["270"] = 280,
		["271"] = 281,
		["272"] = 282,
		["273"] = 283,
		["274"] = 284,
		["275"] = 284,
		["276"] = 284,
		["277"] = 284,
		["278"] = 284,
		["279"] = 284,
		["280"] = 286,
		["281"] = 291,
		["282"] = 291,
		["283"] = 291,
		["284"] = 291,
		["285"] = 291,
		["286"] = 291,
		["287"] = 291,
		["288"] = 291,
		["289"] = 291,
		["290"] = 292,
		["291"] = 292,
		["292"] = 292,
		["293"] = 292,
		["294"] = 292,
		["295"] = 292,
		["296"] = 292,
		["297"] = 292,
		["298"] = 292,
		["300"] = 294,
		["303"] = 297,
		["304"] = 298,
		["305"] = 299,
		["306"] = 300,
		["307"] = 301,
		["308"] = 301,
		["309"] = 301,
		["310"] = 301,
		["311"] = 301,
		["312"] = 301,
		["315"] = 278,
		["316"] = 305,
		["317"] = 306,
		["318"] = 306,
		["319"] = 306,
		["320"] = 307,
		["321"] = 308,
		["322"] = 309,
		["323"] = 309,
		["324"] = 309,
		["325"] = 309,
		["326"] = 309,
		["327"] = 309,
		["328"] = 310,
		["329"] = 311,
		["330"] = 312,
		["333"] = 315,
		["335"] = 306,
		["336"] = 306,
		["337"] = 318,
		["338"] = 305,
		["339"] = 320,
		["340"] = 321,
		["341"] = 322,
		["342"] = 322,
		["343"] = 322,
		["344"] = 322,
		["345"] = 322,
		["346"] = 322,
		["347"] = 323,
		["349"] = 320,
		["350"] = 327,
		["351"] = 328,
		["354"] = 329,
		["357"] = 330,
		["358"] = 331,
		["359"] = 332,
		["360"] = 333,
		["361"] = 334,
		["363"] = 336,
		["364"] = 337,
		["368"] = 327,
		["369"] = 343,
		["370"] = 344,
		["371"] = 343,
		["372"] = 350,
		["373"] = 351,
		["374"] = 350,
		["375"] = 355,
		["376"] = 356,
		["377"] = 357,
		["379"] = 355,
		["380"] = 361,
		["381"] = 362,
		["382"] = 361,
		["383"] = 365,
		["384"] = 366,
		["385"] = 367,
		["387"] = 365,
		["388"] = 371,
		["389"] = 372,
		["390"] = 371,
		["391"] = 375,
		["392"] = 376,
		["393"] = 375,
		["394"] = 379,
		["395"] = 380,
		["398"] = 381,
		["399"] = 382,
		["400"] = 379,
		["401"] = 385,
		["402"] = 386,
		["403"] = 387,
		["404"] = 387,
		["406"] = 388,
		["407"] = 388,
		["409"] = 389,
		["410"] = 385,
		["411"] = 392,
		["412"] = 393,
		["413"] = 394,
		["414"] = 395,
		["416"] = 397,
		["417"] = 392,
		["418"] = 400,
		["419"] = 401,
		["421"] = 402,
		["422"] = 402,
		["423"] = 403,
		["424"] = 402,
		["427"] = 405,
		["428"] = 400,
		["429"] = 408,
		["430"] = 409,
		["433"] = 412,
		["436"] = 415,
		["439"] = 418,
		["442"] = 421,
		["443"] = 408,
		["444"] = 424,
		["445"] = 425,
		["446"] = 426,
		["447"] = 427,
		["448"] = 428,
		["449"] = 429,
		["451"] = 424,
		["452"] = 432,
		["453"] = 433,
		["454"] = 434,
		["455"] = 435,
		["457"] = 432,
		["458"] = 440,
		["459"] = 441,
		["462"] = 444,
		["463"] = 444,
		["464"] = 444,
		["465"] = 444,
		["466"] = 444,
		["467"] = 444,
		["468"] = 445,
		["469"] = 440,
		["470"] = 448,
		["471"] = 448,
		["472"] = 448,
		["474"] = 449,
		["475"] = 450,
		["476"] = 451,
		["478"] = 448,
		["479"] = 455,
		["480"] = 456,
		["483"] = 459,
		["484"] = 460,
		["485"] = 460,
		["486"] = 460,
		["487"] = 460,
		["488"] = 460,
		["489"] = 460,
		["490"] = 460,
		["491"] = 460,
		["492"] = 460,
		["493"] = 460,
		["495"] = 467,
		["496"] = 467,
		["497"] = 467,
		["498"] = 467,
		["499"] = 467,
		["500"] = 467,
		["502"] = 469,
		["503"] = 455,
		["504"] = 472,
		["505"] = 473,
		["506"] = 474,
		["507"] = 475,
		["509"] = 472,
		["510"] = 479,
		["511"] = 480,
		["514"] = 483,
		["515"] = 483,
		["516"] = 483,
		["517"] = 483,
		["518"] = 484,
		["519"] = 485,
		["521"] = 487,
		["522"] = 488,
		["523"] = 488,
		["524"] = 488,
		["525"] = 488,
		["526"] = 488,
		["527"] = 488,
		["529"] = 479,
		["530"] = 492,
		["531"] = 493,
		["532"] = 494,
		["535"] = 497,
		["536"] = 498,
		["537"] = 499,
		["538"] = 500,
		["539"] = 501,
		["540"] = 501,
		["541"] = 501,
		["542"] = 502,
		["545"] = 505,
		["546"] = 501,
		["547"] = 501,
		["549"] = 492,
		["550"] = 510,
		["551"] = 511,
		["552"] = 512,
		["554"] = 510,
		["555"] = 520,
		["556"] = 521,
		["557"] = 522,
		["560"] = 525,
		["561"] = 526,
		["565"] = 529,
		["566"] = 529,
		["567"] = 530,
		["568"] = 529,
		["571"] = 520,
		["572"] = 534,
		["573"] = 535,
		["574"] = 534,
		["575"] = 538,
		["576"] = 539,
		["577"] = 538,
		["578"] = 542,
		["579"] = 543,
		["580"] = 545,
		["581"] = 546,
		["582"] = 547,
		["583"] = 547,
		["584"] = 547,
		["585"] = 547,
		["586"] = 547,
		["587"] = 547,
		["590"] = 551,
		["593"] = 554,
		["594"] = 556,
		["595"] = 557,
		["597"] = 561,
		["598"] = 562,
		["599"] = 563,
		["600"] = 564,
		["601"] = 565,
		["602"] = 566,
		["603"] = 567,
		["605"] = 568,
		["606"] = 568,
		["608"] = 569,
		["609"] = 569,
		["610"] = 570,
		["611"] = 569,
		["614"] = 568,
		["620"] = 542,
		["621"] = 577,
		["622"] = 578,
		["623"] = 579,
		["625"] = 581,
		["626"] = 582,
		["628"] = 577,
		["629"] = 588,
		["630"] = 589,
		["631"] = 590,
		["634"] = 591,
		["636"] = 592,
		["637"] = 592,
		["638"] = 593,
		["639"] = 594,
		["640"] = 595,
		["642"] = 592,
		["645"] = 588,
		["646"] = 600,
		["647"] = 601,
		["648"] = 602,
		["649"] = 603,
		["650"] = 603,
		["651"] = 603,
		["652"] = 604,
		["655"] = 605,
		["656"] = 606,
		["658"] = 608,
		["659"] = 609,
		["660"] = 609,
		["661"] = 609,
		["662"] = 609,
		["663"] = 609,
		["664"] = 609,
		["665"] = 610,
		["666"] = 611,
		["667"] = 612,
		["668"] = 613,
		["671"] = 616,
		["672"] = 616,
		["673"] = 616,
		["674"] = 616,
		["675"] = 618,
		["676"] = 619,
		["678"] = 621,
		["679"] = 603,
		["680"] = 603,
		["681"] = 600,
		["682"] = 625,
		["683"] = 626,
		["684"] = 627,
		["686"] = 629,
		["687"] = 629,
		["689"] = 630,
		["690"] = 630,
		["691"] = 630,
		["692"] = 630,
		["693"] = 631,
		["694"] = 625,
		["695"] = 634,
		["696"] = 635,
		["697"] = 635,
		["698"] = 635,
		["699"] = 635,
		["700"] = 635,
		["701"] = 635,
		["702"] = 635,
		["703"] = 635,
		["704"] = 635,
		["705"] = 635,
		["706"] = 635,
		["707"] = 635,
		["708"] = 635,
		["709"] = 635,
		["710"] = 635,
		["711"] = 635,
		["712"] = 635,
		["713"] = 635,
		["714"] = 635,
		["715"] = 635,
		["716"] = 635,
		["717"] = 635,
		["718"] = 634,
		["719"] = 656,
		["720"] = 657,
		["721"] = 657,
		["722"] = 657,
		["723"] = 657,
		["724"] = 656,
		["725"] = 660,
		["726"] = 661,
		["727"] = 662,
		["728"] = 663,
		["729"] = 664,
		["730"] = 665,
		["731"] = 666,
		["732"] = 666,
		["736"] = 669,
		["737"] = 660,
		["738"] = 672,
		["739"] = 673,
		["740"] = 674,
		["741"] = 675,
		["743"] = 677,
		["744"] = 672,
		["745"] = 120,
		["746"] = 112,
		["747"] = 112,
		["748"] = 112,
		["749"] = 112,
		["750"] = 112,
		["751"] = 112,
		["752"] = 112,
		["753"] = 112,
		["754"] = 120,
		["756"] = 120,
		["757"] = 683,
		["758"] = 684,
		["759"] = 683,
		["760"] = 684,
		["761"] = 685,
		["762"] = 686,
		["763"] = 685,
		["764"] = 688,
		["765"] = 689,
		["768"] = 691,
		["771"] = 692,
		["772"] = 693,
		["773"] = 694,
		["775"] = 688,
		["776"] = 697,
		["777"] = 698,
		["778"] = 697,
		["779"] = 684,
		["780"] = 683,
		["781"] = 684,
		["783"] = 684,
		["784"] = 702,
		["785"] = 710,
		["786"] = 702,
		["787"] = 710,
		["789"] = 710,
		["790"] = 713,
		["791"] = 714,
		["792"] = 716,
		["793"] = 717,
		["794"] = 702,
		["795"] = 719,
		["796"] = 720,
		["797"] = 721,
		["798"] = 722,
		["799"] = 723,
		["800"] = 724,
		["801"] = 725,
		["802"] = 726,
		["804"] = 719,
		["805"] = 730,
		["806"] = 731,
		["807"] = 732,
		["808"] = 733,
		["809"] = 734,
		["810"] = 735,
		["811"] = 736,
		["812"] = 737,
		["814"] = 730,
		["815"] = 740,
		["816"] = 741,
		["817"] = 742,
		["818"] = 743,
		["819"] = 744,
		["820"] = 745,
		["821"] = 746,
		["823"] = 740,
		["824"] = 751,
		["825"] = 752,
		["826"] = 752,
		["827"] = 752,
		["828"] = 752,
		["829"] = 751,
		["830"] = 754,
		["831"] = 755,
		["832"] = 755,
		["833"] = 755,
		["834"] = 755,
		["835"] = 755,
		["836"] = 754,
		["837"] = 757,
		["838"] = 758,
		["839"] = 758,
		["840"] = 758,
		["841"] = 758,
		["842"] = 757,
		["843"] = 760,
		["844"] = 760,
		["845"] = 760,
		["847"] = 761,
		["848"] = 761,
		["849"] = 761,
		["850"] = 761,
		["851"] = 761,
		["852"] = 760,
		["853"] = 763,
		["854"] = 764,
		["855"] = 764,
		["856"] = 764,
		["857"] = 764,
		["858"] = 763,
		["859"] = 766,
		["860"] = 766,
		["861"] = 766,
		["863"] = 767,
		["864"] = 767,
		["865"] = 767,
		["866"] = 767,
		["867"] = 767,
		["868"] = 766,
		["869"] = 769,
		["870"] = 770,
		["871"] = 770,
		["872"] = 770,
		["873"] = 770,
		["874"] = 769,
		["875"] = 772,
		["876"] = 773,
		["877"] = 773,
		["878"] = 773,
		["879"] = 773,
		["880"] = 773,
		["881"] = 772,
		["882"] = 775,
		["883"] = 776,
		["884"] = 776,
		["885"] = 776,
		["886"] = 776,
		["887"] = 775,
		["888"] = 778,
		["889"] = 779,
		["890"] = 779,
		["891"] = 779,
		["892"] = 779,
		["893"] = 779,
		["894"] = 778,
		["895"] = 781,
		["896"] = 782,
		["897"] = 782,
		["898"] = 782,
		["899"] = 782,
		["900"] = 783,
		["901"] = 783,
		["903"] = 784,
		["904"] = 785,
		["905"] = 786,
		["906"] = 787,
		["908"] = 789,
		["909"] = 781,
		["910"] = 791,
		["911"] = 792,
		["912"] = 792,
		["913"] = 792,
		["914"] = 792,
		["915"] = 792,
		["916"] = 791,
		["917"] = 795,
		["918"] = 796,
		["919"] = 797,
		["920"] = 798,
		["922"] = 795,
		["923"] = 803,
		["924"] = 804,
		["927"] = 805,
		["928"] = 806,
		["929"] = 807,
		["930"] = 808,
		["931"] = 809,
		["934"] = 803,
		["935"] = 814,
		["936"] = 815,
		["939"] = 816,
		["940"] = 817,
		["941"] = 818,
		["943"] = 814,
		["944"] = 822,
		["945"] = 823,
		["948"] = 824,
		["949"] = 825,
		["950"] = 826,
		["951"] = 827,
		["952"] = 828,
		["953"] = 829,
		["954"] = 822,
		["955"] = 832,
		["956"] = 833,
		["959"] = 834,
		["961"] = 835,
		["962"] = 835,
		["963"] = 835,
		["964"] = 835,
		["965"] = 835,
		["968"] = 836,
		["970"] = 838,
		["971"] = 839,
		["972"] = 840,
		["974"] = 832,
		["975"] = 844,
		["976"] = 845,
		["979"] = 846,
		["980"] = 847,
		["981"] = 847,
		["982"] = 847,
		["984"] = 848,
		["985"] = 844,
		["986"] = 851,
		["987"] = 852,
		["990"] = 853,
		["991"] = 854,
		["992"] = 855,
		["993"] = 856,
		["994"] = 856,
		["997"] = 858,
		["999"] = 851,
		["1000"] = 863,
		["1001"] = 864,
		["1002"] = 869,
		["1003"] = 869,
		["1004"] = 869,
		["1005"] = 869,
		["1006"] = 869,
		["1007"] = 870,
		["1008"] = 870,
		["1010"] = 871,
		["1011"] = 872,
		["1012"] = 872,
		["1014"] = 873,
		["1015"] = 874,
		["1016"] = 875,
		["1020"] = 879,
		["1021"] = 880,
		["1022"] = 881,
		["1023"] = 882,
		["1024"] = 883,
		["1025"] = 884,
		["1027"] = 886,
		["1029"] = 888,
		["1030"] = 889,
		["1031"] = 890,
		["1032"] = 869,
		["1033"] = 869,
		["1034"] = 869,
		["1035"] = 869,
		["1036"] = 869,
		["1037"] = 869,
		["1038"] = 863,
		["1039"] = 895,
		["1040"] = 896,
		["1043"] = 897,
		["1044"] = 898,
		["1045"] = 899,
		["1046"] = 900,
		["1049"] = 903,
		["1050"] = 904,
		["1053"] = 907,
		["1056"] = 908,
		["1057"] = 910,
		["1058"] = 911,
		["1059"] = 912,
		["1060"] = 913,
		["1061"] = 914,
		["1062"] = 915,
		["1066"] = 920,
		["1067"] = 921,
		["1068"] = 922,
		["1069"] = 922,
		["1070"] = 922,
		["1071"] = 922,
		["1072"] = 922,
		["1074"] = 922,
		["1075"] = 922,
		["1077"] = 924,
		["1078"] = 924,
		["1079"] = 924,
		["1080"] = 924,
		["1081"] = 924,
		["1082"] = 925,
		["1083"] = 925,
		["1085"] = 926,
		["1086"] = 927,
		["1087"] = 927,
		["1089"] = 928,
		["1090"] = 924,
		["1091"] = 924,
		["1094"] = 895,
		["1095"] = 934,
		["1096"] = 935,
		["1099"] = 936,
		["1100"] = 937,
		["1101"] = 938,
		["1102"] = 939,
		["1103"] = 940,
		["1104"] = 940,
		["1106"] = 941,
		["1107"] = 942,
		["1108"] = 943,
		["1109"] = 944,
		["1110"] = 944,
		["1114"] = 946,
		["1115"] = 947,
		["1116"] = 947,
		["1117"] = 947,
		["1118"] = 947,
		["1119"] = 947,
		["1120"] = 947,
		["1122"] = 934,
		["1123"] = 950,
		["1124"] = 951,
		["1127"] = 952,
		["1128"] = 953,
		["1129"] = 954,
		["1130"] = 955,
		["1132"] = 957,
		["1133"] = 958,
		["1134"] = 959,
		["1135"] = 960,
		["1136"] = 961,
		["1137"] = 962,
		["1138"] = 963,
		["1139"] = 964,
		["1140"] = 965,
		["1141"] = 966,
		["1142"] = 967,
		["1144"] = 968,
		["1145"] = 968,
		["1146"] = 969,
		["1147"] = 970,
		["1148"] = 971,
		["1149"] = 968,
		["1153"] = 974,
		["1154"] = 975,
		["1156"] = 976,
		["1157"] = 976,
		["1158"] = 977,
		["1159"] = 977,
		["1160"] = 977,
		["1161"] = 977,
		["1162"] = 977,
		["1163"] = 977,
		["1164"] = 977,
		["1165"] = 976,
		["1169"] = 980,
		["1170"] = 981,
		["1172"] = 983,
		["1174"] = 985,
		["1175"] = 950,
		["1176"] = 989,
		["1177"] = 990,
		["1178"] = 989,
		["1179"] = 998,
		["1180"] = 999,
		["1181"] = 1000,
		["1183"] = 998,
		["1184"] = 1004,
		["1185"] = 1005,
		["1186"] = 1004,
		["1187"] = 1008,
		["1188"] = 1008,
		["1189"] = 1008,
		["1190"] = 1008,
		["1191"] = 1010,
		["1192"] = 1011,
		["1195"] = 1012,
		["1196"] = 1012,
		["1199"] = 1013,
		["1200"] = 1014,
		["1201"] = 1015,
		["1202"] = 1016,
		["1204"] = 1010,
		["1205"] = 1020,
		["1206"] = 1021,
		["1207"] = 1022,
		["1208"] = 1022,
		["1210"] = 1023,
		["1211"] = 1024,
		["1212"] = 1020,
		["1213"] = 1027,
		["1214"] = 1028,
		["1215"] = 1029,
		["1218"] = 1030,
		["1219"] = 1031,
		["1223"] = 1032,
		["1224"] = 1032,
		["1226"] = 1033,
		["1227"] = 1034,
		["1228"] = 1034,
		["1230"] = 1035,
		["1231"] = 1035,
		["1233"] = 1036,
		["1234"] = 1036,
		["1235"] = 1037,
		["1238"] = 1032,
		["1241"] = 1027,
		["1242"] = 710,
		["1243"] = 702,
		["1244"] = 702,
		["1245"] = 702,
		["1246"] = 702,
		["1247"] = 702,
		["1248"] = 702,
		["1249"] = 702,
		["1250"] = 702,
		["1251"] = 710,
		["1253"] = 710,
		["1255"] = 1068,
		["1256"] = 1068,
		["1257"] = 1095,
		["1258"] = 1089,
		["1259"] = 1096,
		["1260"] = 1097,
		["1261"] = 1098,
		["1262"] = 1099,
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
		["1280"] = 1095,
		["1281"] = 1119,
		["1282"] = 1120,
		["1285"] = 1121,
		["1286"] = 1124,
		["1287"] = 1125,
		["1288"] = 1126,
		["1289"] = 1127,
		["1290"] = 1129,
		["1291"] = 1130,
		["1292"] = 1131,
		["1293"] = 1131,
		["1294"] = 1131,
		["1295"] = 1131,
		["1296"] = 1131,
		["1298"] = 1133,
		["1299"] = 1134,
		["1300"] = 1135,
		["1301"] = 1136,
		["1302"] = 1137,
		["1303"] = 1137,
		["1305"] = 1138,
		["1306"] = 1139,
		["1307"] = 1140,
		["1310"] = 1143,
		["1313"] = 1146,
		["1315"] = 1149,
		["1316"] = 1150,
		["1317"] = 1150,
		["1318"] = 1150,
		["1319"] = 1151,
		["1322"] = 1152,
		["1323"] = 1153,
		["1324"] = 1150,
		["1325"] = 1150,
		["1326"] = 1119,
		["1327"] = 1158,
		["1328"] = 1159,
		["1329"] = 1158,
		["1330"] = 1162,
		["1331"] = 1163,
		["1332"] = 1163,
		["1333"] = 1163,
		["1334"] = 1163,
		["1335"] = 1163,
		["1336"] = 1163,
		["1337"] = 1163,
		["1338"] = 1163,
		["1339"] = 1163,
		["1340"] = 1163,
		["1341"] = 1163,
		["1342"] = 1163,
		["1343"] = 1163,
		["1344"] = 1162,
		["1345"] = 1174,
		["1346"] = 1175,
		["1347"] = 1174,
		["1348"] = 1178,
		["1349"] = 1179,
		["1350"] = 1181,
		["1351"] = 1182,
		["1352"] = 1183,
		["1353"] = 1184,
		["1354"] = 1185,
		["1355"] = 1186,
		["1356"] = 1186,
		["1357"] = 1186,
		["1358"] = 1186,
		["1359"] = 1186,
		["1360"] = 1186,
		["1361"] = 1186,
		["1362"] = 1186,
		["1363"] = 1186,
		["1364"] = 1186,
		["1365"] = 1186,
		["1366"] = 1186,
		["1367"] = 1186,
		["1368"] = 1186,
		["1369"] = 1195,
		["1371"] = 1197,
		["1372"] = 1197,
		["1374"] = 1178,
		["1375"] = 1200,
		["1376"] = 1201,
		["1379"] = 1202,
		["1382"] = 1203,
		["1383"] = 1205,
		["1384"] = 1206,
		["1385"] = 1206,
		["1386"] = 1206,
		["1387"] = 1207,
		["1390"] = 1208,
		["1393"] = 1210,
		["1394"] = 1211,
		["1395"] = 1206,
		["1396"] = 1206,
		["1397"] = 1200,
		["1398"] = 1215,
		["1399"] = 1216,
		["1402"] = 1218,
		["1403"] = 1219,
		["1404"] = 1215,
		["1405"] = 1222,
		["1406"] = 1223,
		["1407"] = 1223,
		["1408"] = 1223,
		["1410"] = 1225,
		["1411"] = 1226,
		["1412"] = 1226,
		["1413"] = 1226,
		["1414"] = 1226,
		["1415"] = 1226,
		["1416"] = 1226,
		["1417"] = 1226,
		["1418"] = 1226,
		["1419"] = 1226,
		["1420"] = 1226,
		["1421"] = 1226,
		["1422"] = 1233,
		["1423"] = 1233,
		["1424"] = 1234,
		["1425"] = 1234,
		["1426"] = 1234,
		["1427"] = 1235,
		["1428"] = 1236,
		["1430"] = 1234,
		["1431"] = 1234,
		["1433"] = 1240,
		["1434"] = 1241,
		["1436"] = 1243,
		["1437"] = 1222,
		["1438"] = 1249,
		["1439"] = 1257,
		["1440"] = 1249,
		["1441"] = 1257,
		["1443"] = 1257,
		["1444"] = 1261,
		["1445"] = 1249,
		["1446"] = 1263,
		["1447"] = 1264,
		["1448"] = 1265,
		["1449"] = 1266,
		["1450"] = 1267,
		["1451"] = 1268,
		["1452"] = 1269,
		["1453"] = 1270,
		["1454"] = 1271,
		["1455"] = 1271,
		["1456"] = 1271,
		["1457"] = 1271,
		["1460"] = 1263,
		["1461"] = 1276,
		["1462"] = 1277,
		["1463"] = 1278,
		["1464"] = 1279,
		["1465"] = 1280,
		["1467"] = 1282,
		["1468"] = 1283,
		["1469"] = 1284,
		["1470"] = 1285,
		["1471"] = 1285,
		["1472"] = 1285,
		["1473"] = 1285,
		["1474"] = 1285,
		["1477"] = 1276,
		["1478"] = 1290,
		["1479"] = 1291,
		["1480"] = 1290,
		["1481"] = 1294,
		["1482"] = 1295,
		["1483"] = 1294,
		["1484"] = 1298,
		["1485"] = 1299,
		["1486"] = 1298,
		["1487"] = 1304,
		["1488"] = 1305,
		["1489"] = 1306,
		["1490"] = 1304,
		["1491"] = 1257,
		["1492"] = 1249,
		["1493"] = 1249,
		["1494"] = 1249,
		["1495"] = 1249,
		["1496"] = 1249,
		["1497"] = 1249,
		["1498"] = 1249,
		["1499"] = 1249,
		["1500"] = 1257,
		["1502"] = 1257,
		["1503"] = 1310,
		["1504"] = 1318,
		["1505"] = 1310,
		["1506"] = 1318,
		["1508"] = 1318,
		["1509"] = 1320,
		["1510"] = 1310,
		["1511"] = 1324,
		["1512"] = 1325,
		["1513"] = 1324,
		["1514"] = 1328,
		["1515"] = 1329,
		["1516"] = 1330,
		["1517"] = 1331,
		["1518"] = 1332,
		["1519"] = 1333,
		["1520"] = 1333,
		["1521"] = 1333,
		["1522"] = 1333,
		["1523"] = 1333,
		["1524"] = 1334,
		["1525"] = 1335,
		["1526"] = 1336,
		["1527"] = 1337,
		["1528"] = 1338,
		["1531"] = 1328,
		["1532"] = 1343,
		["1533"] = 1344,
		["1534"] = 1345,
		["1535"] = 1346,
		["1536"] = 1347,
		["1537"] = 1348,
		["1539"] = 1350,
		["1540"] = 1351,
		["1543"] = 1343,
		["1544"] = 1356,
		["1545"] = 1357,
		["1546"] = 1358,
		["1548"] = 1360,
		["1549"] = 1356,
		["1550"] = 1363,
		["1551"] = 1364,
		["1552"] = 1364,
		["1553"] = 1364,
		["1554"] = 1364,
		["1555"] = 1364,
		["1556"] = 1364,
		["1557"] = 1364,
		["1558"] = 1363,
		["1559"] = 1373,
		["1560"] = 1374,
		["1561"] = 1375,
		["1563"] = 1377,
		["1564"] = 1373,
		["1565"] = 1380,
		["1566"] = 1381,
		["1567"] = 1380,
		["1568"] = 1384,
		["1569"] = 1385,
		["1572"] = 1386,
		["1573"] = 1387,
		["1574"] = 1384,
		["1575"] = 1390,
		["1576"] = 1391,
		["1579"] = 1392,
		["1580"] = 1390,
		["1581"] = 1395,
		["1582"] = 1396,
		["1583"] = 1397,
		["1584"] = 1398,
		["1586"] = 1400,
		["1588"] = 1395,
		["1589"] = 1318,
		["1590"] = 1310,
		["1591"] = 1310,
		["1592"] = 1310,
		["1593"] = 1310,
		["1594"] = 1310,
		["1595"] = 1310,
		["1596"] = 1310,
		["1597"] = 1310,
		["1598"] = 1318,
		["1600"] = 1318,
		["1601"] = 1407,
		["1602"] = 1415,
		["1603"] = 1407,
		["1604"] = 1415,
		["1605"] = 1418,
		["1606"] = 1419,
		["1607"] = 1420,
		["1609"] = 1418,
		["1610"] = 1424,
		["1611"] = 1425,
		["1612"] = 1424,
		["1613"] = 1428,
		["1614"] = 1429,
		["1615"] = 1428,
		["1616"] = 1432,
		["1617"] = 1433,
		["1618"] = 1433,
		["1619"] = 1433,
		["1620"] = 1433,
		["1621"] = 1432,
		["1622"] = 1436,
		["1623"] = 1437,
		["1624"] = 1438,
		["1626"] = 1440,
		["1627"] = 1441,
		["1629"] = 1436,
		["1630"] = 1415,
		["1631"] = 1407,
		["1632"] = 1407,
		["1633"] = 1407,
		["1634"] = 1407,
		["1635"] = 1407,
		["1636"] = 1407,
		["1637"] = 1407,
		["1638"] = 1407,
		["1639"] = 1415,
		["1641"] = 1415,
		["1642"] = 1448,
		["1643"] = 1449,
		["1644"] = 1448,
		["1645"] = 1449,
		["1646"] = 1450,
		["1647"] = 1451,
		["1648"] = 1452,
		["1649"] = 1453,
		["1652"] = 1454,
		["1653"] = 1455,
		["1654"] = 1455,
		["1655"] = 1455,
		["1656"] = 1456,
		["1657"] = 1457,
		["1658"] = 1457,
		["1659"] = 1457,
		["1660"] = 1457,
		["1661"] = 1457,
		["1662"] = 1457,
		["1664"] = 1455,
		["1665"] = 1455,
		["1666"] = 1450,
		["1667"] = 1449,
		["1668"] = 1448,
		["1669"] = 1449,
		["1671"] = 1449,
		["1672"] = 1463,
		["1673"] = 1473,
		["1674"] = 1463,
		["1675"] = 1473,
		["1677"] = 1473,
		["1678"] = 1476,
		["1679"] = 1463,
		["1680"] = 1479,
		["1681"] = 1480,
		["1682"] = 1481,
		["1683"] = 1482,
		["1684"] = 1479,
		["1685"] = 1485,
		["1686"] = 1486,
		["1687"] = 1487,
		["1688"] = 1488,
		["1690"] = 1490,
		["1691"] = 1491,
		["1692"] = 1491,
		["1693"] = 1491,
		["1694"] = 1491,
		["1695"] = 1491,
		["1696"] = 1491,
		["1697"] = 1485,
		["1698"] = 1493,
		["1699"] = 1494,
		["1700"] = 1495,
		["1702"] = 1493,
		["1703"] = 1498,
		["1704"] = 1499,
		["1705"] = 1500,
		["1706"] = 1501,
		["1707"] = 1502,
		["1708"] = 1503,
		["1709"] = 1503,
		["1710"] = 1503,
		["1711"] = 1503,
		["1712"] = 1503,
		["1713"] = 1503,
		["1714"] = 1504,
		["1715"] = 1505,
		["1716"] = 1505,
		["1717"] = 1505,
		["1718"] = 1505,
		["1719"] = 1505,
		["1720"] = 1505,
		["1724"] = 1498,
		["1725"] = 1510,
		["1726"] = 1511,
		["1727"] = 1512,
		["1729"] = 1514,
		["1730"] = 1515,
		["1731"] = 1516,
		["1732"] = 1517,
		["1734"] = 1519,
		["1735"] = 1510,
		["1736"] = 1473,
		["1737"] = 1463,
		["1738"] = 1463,
		["1739"] = 1463,
		["1740"] = 1463,
		["1741"] = 1463,
		["1742"] = 1463,
		["1743"] = 1463,
		["1744"] = 1463,
		["1745"] = 1463,
		["1746"] = 1463,
		["1747"] = 1473,
		["1749"] = 1473,
		["1750"] = 1523,
		["1751"] = 1531,
		["1752"] = 1523,
		["1753"] = 1531,
		["1754"] = 1531,
		["1755"] = 1523,
		["1756"] = 1523,
		["1757"] = 1523,
		["1758"] = 1523,
		["1759"] = 1523,
		["1760"] = 1523,
		["1761"] = 1523,
		["1762"] = 1523,
		["1763"] = 1531,
		["1765"] = 1531,
		["1766"] = 1533,
		["1767"] = 1541,
		["1768"] = 1533,
		["1769"] = 1541,
		["1770"] = 1544,
		["1771"] = 1545,
		["1772"] = 1546,
		["1773"] = 1547,
		["1774"] = 1548,
		["1777"] = 1544,
		["1778"] = 1557,
		["1779"] = 1558,
		["1780"] = 1559,
		["1781"] = 1560,
		["1783"] = 1557,
		["1784"] = 1541,
		["1785"] = 1533,
		["1786"] = 1533,
		["1787"] = 1533,
		["1788"] = 1533,
		["1789"] = 1533,
		["1790"] = 1533,
		["1791"] = 1533,
		["1792"] = 1533,
		["1793"] = 1541,
		["1795"] = 1541,
		["1796"] = 1567,
		["1797"] = 1568,
		["1798"] = 1567,
		["1799"] = 1568,
		["1800"] = 1569,
		["1801"] = 1570,
		["1802"] = 1569,
		["1803"] = 1568,
		["1804"] = 1567,
		["1805"] = 1568,
		["1807"] = 1568,
		["1808"] = 1574,
		["1809"] = 1582,
		["1810"] = 1574,
		["1811"] = 1582,
		["1812"] = 1583,
		["1813"] = 1584,
		["1814"] = 1585,
		["1815"] = 1586,
		["1816"] = 1587,
		["1819"] = 1583,
		["1820"] = 1582,
		["1821"] = 1574,
		["1822"] = 1574,
		["1823"] = 1574,
		["1824"] = 1574,
		["1825"] = 1574,
		["1826"] = 1574,
		["1827"] = 1574,
		["1828"] = 1574,
		["1829"] = 1582,
		["1831"] = 1582,
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
local function E(self, F)
	if F:HasModifier("modifier_5100071") then
		return D
	end
	return C
end
local G = {
	[0] = { "chaos_ritual_1", "chaos_ritual_2", "chaos_ritual_3", "chaos_ritual_4" },
	[1] = { "abyssal_fusion_1", "abyssal_fusion_2", "abyssal_fusion_3", "abyssal_fusion_4" },
	[2] = { "demonic_pact_1", "demonic_pact_2", "demonic_pact_3", "demonic_pact_4" },
}
local H = {
	{ "warlock_talent_1", "warlock_talent_2", "warlock_talent_3" },
	{ "warlock_talent_4", "warlock_talent_5", "warlock_talent_6" },
	{ "warlock_talent_7", "warlock_talent_8", "warlock_talent_9" },
}
local function I(self, J)
	do
		local K = 0
		while K < #H do
			local L = H[K + 1]
			if c(L, J) ~= -1 then
				return L
			end
			K = K + 1
		end
	end
end
local function M(self, J)
	if J == "warlock_talent_1" or J == "warlock_talent_4" or J == "warlock_talent_7" then
		return 0
	end
	if J == "warlock_talent_2" or J == "warlock_talent_5" or J == "warlock_talent_8" then
		return 1
	end
	if J == "warlock_talent_3" or J == "warlock_talent_6" or J == "warlock_talent_9" then
		return 2
	end
	return -1
end
local function N(self, F)
	local O = PlayerData:getHero(F:GetPlayerOwnerID())
	if not O then
		return
	end
	local P = O:getAbilityData(true)
	local Q
	local R = -1
	do
		local K = 0
		while K < #AbilityShop.pickList do
			local S = AbilityShop.pickList[K + 1]
			local T = P[S]
			local U = T and T.exp or 0
			if U > R then
				Q = S
				R = U
			end
			K = K + 1
		end
	end
	return Q
end
local function V(self, F)
	local O = PlayerData:getHero(F:GetPlayerOwnerID())
	if not O then
		return 0
	end
	local P = O:getAbilityData(true)
	local R = 0
	do
		local K = 0
		while K < #AbilityShop.pickList do
			local W = P[AbilityShop.pickList[K + 1]]
			local U = W and W.exp or 0
			if U > R then
				R = U
			end
			K = K + 1
		end
	end
	return R
end
local function X(self, F, S)
	local O = PlayerData:getHero(F:GetPlayerOwnerID())
	if not O then
		return {}
	end
	local Q = {}
	for Y, Z in pairs(KeyValues.AbilityUpgradesKvs) do
		do
			if Z.rarity ~= "n" or Z.Triggerable == nil or Z.script_ability == nil then
				goto _
			end
			local a0 = Z.sect
			if a0 and d(a0, S) then
				Q[#Q + 1] = Y
			end
		end
		::_::
	end
	return Q
end
local function a1(self, F)
	local a2 = F:FindAbilityByName("sect_wisp")
	if not IsValid(a2) then
		a2 = F:AddAbility("sect_wisp")
	end
	return a2
end
local function a3(self, F, a4)
	local a5 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf",
		PATTACH_CUSTOMORIGIN,
		F
	)
	ParticleManager:SetParticleControl(a5, 0, a4)
	ParticleManager:ReleaseParticleIndex(a5)
end
o.warlock_talent = e()
local a6 = o.warlock_talent
a6.name = "warlock_talent"
f(a6, r)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_warlock_talent"
end
a6 = g({ s(nil) }, a6)
o.warlock_talent = a6
o.modifier_warlock_talent = e()
local a7 = o.modifier_warlock_talent
a7.name = "modifier_warlock_talent"
f(a7, u)
function a7.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.a1_record = 0
	self.immolationThinkActive = false
	self.isHeroInfernal = false
	self.createdWispModifier = false
	self.infernalLastStandTriggered = false
end
function a7.prototype.GetAbilitySpecialValue(self)
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
function a7.prototype.OnCreated(self, a8)
	if IsServer() then
		self.highestSectExp = V(nil, self.parent)
	end
end
function a7.prototype.EDeclareEvents(self)
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
function a7.prototype.ClearInfernalState(self)
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
function a7.prototype.OnClearTalent(self, a8)
	if IsServer() and a8.playerID == self.parent:GetPlayerOwnerID() then
		self:ClearInfernalState()
	end
end
function a7.prototype.OnBattleStartBefore(self, a8)
	if IsServer() then
		self.highestSectExp = V(nil, self.parent)
		self.isHeroInfernal = self:HasUpgrade("abyssal_fusion_3")
		self.infernalLastStandTriggered = false
	end
end
function a7.prototype.OnBattleStart(self, a8)
	if IsServer() then
		self.highestSectExp = V(nil, self.parent)
		self:StartIntervalThink(self:GetSummonDelay())
	end
	if self:HasUpgrade("abyssal_fusion_1") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_warlock_abyssal_fusion_1", {})
	end
	if self.a1_tick > 0 then
		self:StartThink(self.a1_tick, "a1_tick")
	end
end
function a7.prototype.OnThink(self, a9)
	if a9 == "a1_tick" then
		if self.a1_record > 0 then
			local aa = self.parent:GetEnemy()
			local ab = self.a1_record * self.a1_damage_pct * 0.01
			if ab > 0 and IsInjurable(aa, self.parent) then
				self.parent:DealDamage(
					aa,
					self.fatalBondsAbility or self:GetAbility(),
					ab,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
				)
				local ac = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_warlock/warlock_fatal_bonds_hit_parent.vpcf",
					PATTACH_CUSTOMORIGIN,
					self.parent
				)
				ParticleManager:SetParticleControlEnt(
					ac,
					0,
					aa,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					Vector(0, 0, 0),
					true
				)
				ParticleManager:SetParticleControlEnt(
					ac,
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
	if a9 == "immolation" then
		local ad = self.parent:GetEnemy()
		local ae = self:GetImmolationDamagePct()
		if ae > 0 and IsInjurable(ad, self.parent) then
			self:DealInfernalDamage(
				ad,
				self:GetImmolationDamage() * ae * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				self.immolationAbility
			)
		end
	end
end
function a7.prototype.OnIntervalThink(self)
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
function a7.prototype.EnsureWispModifier(self)
	if not self.parent:HasModifier("modifier_sect_wisp") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_sect_wisp", {})
		self.createdWispModifier = true
	end
end
function a7.prototype.OnFirstWispSpawn(self, a8)
	if not IsServer() then
		return
	end
	if not self:HasUpgrade("demonic_pact_1") then
		return
	end
	local af = self.isHeroInfernal or self:HasUpgrade("abyssal_fusion_3")
	if af then
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
function a7.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS,
	}
end
function a7.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function a7.prototype.EOM_GetModifierMinHealth(self, a8)
	if not self.infernalLastStandTriggered and self:HasUpgrade("chaos_ritual_4") and self.c4_live_duration > 0 then
		return 1
	end
end
function a7.prototype.EOM_GetModifierHealthBonus(self, a8)
	return self.abyssal_fusion_hp * self:GetUpgradeCount(1)
end
function a7.prototype.EOM_GetModifierWispHealthBonus(self, a8)
	if self:HasUpgrade("demonic_pact_1") then
		return self.d1_wisp_health_bonus
	end
end
function a7.prototype.GetInfernalDamage(self)
	return (self.damage_base + self.highestSectExp * self.damage_bonus)
		* (1 + self.demonic_pact_damage * self:GetUpgradeCount(2) * 0.01)
end
function a7.prototype.GetImmolationDamage(self)
	return self.c3_damage + self.c3_level_damage * self.highestSectExp
end
function a7.prototype.StartInfernalImmolationTimer(self)
	if self.immolationThinkActive or not self:HasUpgrade("chaos_ritual_3") or self.c3_interval <= 0 then
		return
	end
	self.immolationThinkActive = true
	self:StartThink(self.c3_interval, "immolation")
end
function a7.prototype.GetImmolationDamagePct(self)
	local ae = self.isHeroInfernal and 100 or 0
	if self.infernal and not self.infernal.disposed then
		ae = ae + self.infernal.damagePct
	end
	if self.secondaryInfernal and not self.secondaryInfernal.disposed then
		ae = ae + self.secondaryInfernal.damagePct
	end
	return ae
end
function a7.prototype.GetSummonDelay(self)
	local ag = self.summon - self:GetLearnedEvolutionPointCount()
	if self:HasUpgrade("demonic_pact_4") then
		ag = ag - self.d4_summon_reduce
	end
	return math.max(0, ag)
end
function a7.prototype.GetLearnedEvolutionPointCount(self)
	local ah = 0
	do
		local K = 0
		while K < 3 do
			ah = ah + self:GetUpgradeCount(K)
			K = K + 1
		end
	end
	return ah
end
function a7.prototype.OnCustomAttackLanded(self, ai)
	if not IsServer() then
		return
	end
	if not self.isHeroInfernal then
		return
	end
	if bit.band(ai.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK) == DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK then
		return
	end
	if not IsInjurable(ai.target, self.parent) then
		return
	end
	self:OnInfernalAttackLanded(ai.target, ai.damage)
end
function a7.prototype.OnBattleEnd(self, a8)
	if IsServer() then
		self:ClearInfernalState()
		self:StartIntervalThink(-1)
		self:StartThink(-1, "a1_tick")
		self:StartThink(-1, "immolation")
	end
end
function a7.prototype.OnRoundEnd(self, a8)
	if IsServer() then
		self:ClearInfernalState()
		self:StartIntervalThink(-1)
	end
end
function a7.prototype.DealInfernalDamage(self, aj, ak, al, am)
	if not IsInjurable(aj, self.parent) then
		return
	end
	self.parent:DealDamage(aj, am or self:GetAbility(), ak, al)
	self:TriggerInfernalHitEffects(aj, ak)
end
function a7.prototype.DealInfernalAttack(self, aj, ak, ae)
	if ae == nil then
		ae = 100
	end
	self:DealInfernalBasicAttack(aj, ak * ae * 0.01)
	if self:HasUpgrade("chaos_ritual_2") and self.c2_chance > 0 and self:PRD(self.c2_chance) then
		self:DealInfernalDamage(
			aj,
			(self.c2_base_damage + self.c2_exp_damage * self.highestSectExp) * ae * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.flameFistAbility
		)
	end
end
function a7.prototype.DealInfernalBasicAttack(self, aj, ak)
	if not IsInjurable(aj, self.parent) then
		return
	end
	if self:HasUpgrade("chaos_ritual_1") then
		DamageSystem:performAttack(
			self.parent,
			aj,
			{
				damage = ak,
				ability = self:GetAbility(),
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
				damage_flags = DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK + DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK,
			}
		)
	else
		self.parent:DealDamage(aj, self:GetAbility(), ak, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
	self:TriggerInfernalHitEffects(aj, ak)
end
function a7.prototype.OnInfernalAttackLanded(self, aj, ak)
	self:TriggerInfernalHitEffects(aj, ak)
	if self:HasUpgrade("chaos_ritual_2") and self.c2_chance > 0 and self:PRD(self.c2_chance) then
		self:DealInfernalDamage(
			aj,
			self.c2_base_damage + self.c2_exp_damage * self.highestSectExp,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.flameFistAbility
		)
	end
end
function a7.prototype.TriggerInfernalSkillSet(self, aj, an)
	if not IsInjurable(aj, self.parent) then
		return
	end
	self:DealInfernalBasicAttack(aj, self:GetInfernalDamage())
	if self:HasUpgrade("chaos_ritual_2") and self.c2_base_damage > 0 then
		self:DealInfernalDamage(
			aj,
			self.c2_base_damage + self.c2_exp_damage * self.highestSectExp,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.flameFistAbility
		)
	end
	if self:HasUpgrade("chaos_ritual_3") and self:GetImmolationDamage() > 0 then
		self:DealInfernalDamage(
			aj,
			self:GetImmolationDamage(),
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			self.immolationAbility
		)
	end
end
function a7.prototype.TriggerInfernalSkillSetByHealthLoss(self, an)
	local ad = self.parent:GetEnemy()
	if not IsInjurable(ad, self.parent) then
		return
	end
	if self.isHeroInfernal then
		self:TriggerInfernalSkillSet(ad, an)
	elseif self.infernal and not self.infernal.disposed then
		self.infernal:UpdatePosition()
		GameTimer(0.3, function()
			if not IsValid(self) or not self.infernal or self.infernal.disposed then
				return
			end
			self:TriggerInfernalSkillSet(ad, an)
		end)
	end
end
function a7.prototype.TriggerInfernalHitEffects(self, aj, ak)
	if self:HasUpgrade("abyssal_fusion_2") and self.a2_damage_reply > 0 then
		Heal(self.parent, ak * self.a2_damage_reply * 0.01, "warlock_talent", "Ability")
	end
end
function a7.prototype.TriggerCataclysm(self, aj)
	local S = N(nil, self.parent)
	if not S then
		return
	end
	local ao = X(nil, self.parent, S)
	if #ao == 0 then
		return
	end
	do
		local K = 0
		while K < #ao do
			TriggerSectAbilityByName(self.parent, ao[K + 1])
			K = K + 1
		end
	end
end
function a7.prototype.HasActiveInfernal(self)
	return self.isHeroInfernal
		or self.infernal ~= nil and not self.infernal.disposed
		or self.secondaryInfernal ~= nil and not self.secondaryInfernal.disposed
end
function a7.prototype.HasActiveInfernalUnit(self)
	return self.infernal ~= nil and not self.infernal.disposed
		or self.secondaryInfernal ~= nil and not self.secondaryInfernal.disposed
end
function a7.prototype.OnCustomTakeDamage(self, ai)
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
		local ad = self.parent:GetEnemy()
		if
			self:HasActiveInfernal()
			and self:HasUpgrade("abyssal_fusion_1")
			and self.a1_damage_pct > 0
			and ai.damage > 0
			and bit.band(ai.damage_flags or 0, DamageFlags.DAMAGE_FLAG_REFLECTION)
				~= DamageFlags.DAMAGE_FLAG_REFLECTION
		then
			self.a1_record = self.a1_record + ai.damage
		end
		if self:HasActiveInfernal() and self:HasUpgrade("abyssal_fusion_4") and self.a4_health_reduce > 0 then
			local ap = self.a4_health_reduce
			self:AddCount(ai.damage, "abyssal_fusion_4_hp_lost")
			local aq = self:GetCount("abyssal_fusion_4_hp_lost")
			if aq >= ap and self.parent:GetHealth() > 0 then
				local ar = math.floor(aq / ap)
				self:AddCount(-ar * ap, "abyssal_fusion_4_hp_lost")
				do
					local K = 0
					while K < ar do
						do
							local as = 0
							while as < self.a4_count do
								self:TriggerInfernalSkillSetByHealthLoss(ap)
								as = as + 1
							end
						end
						K = K + 1
					end
				end
			end
		end
	end
end
function a7.prototype.OnDestroy(self)
	if self.infernal ~= nil then
		self.infernal:Dispose()
	end
	if self.secondaryInfernal ~= nil then
		self.secondaryInfernal:Dispose()
	end
end
function a7.prototype.GetFirstWisp(self)
	local at = self.parent:FindModifierByName("modifier_sect_wisp")
	if not IsValid(at) then
		return
	end
	local au = at:GetWispList()
	do
		local K = 0
		while K < #au do
			local av = au[K + 1]
			if av.first and IsValid(av.wisp) then
				return av.wisp
			end
			K = K + 1
		end
	end
end
function a7.prototype.SpawnInfernal(self)
	self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	EmitSoundOn("Warlock_Imp.Explode", self.parent)
	GameTimer(0.4, function()
		if self.isHeroInfernal then
			return
		end
		if self.infernal and not self.infernal.disposed then
			self.infernal:Dispose(true)
		end
		local aw
		AddStun(self.parent, self.parent:GetEnemy(), self:GetAbility(), self.stun_duration)
		if self:HasUpgrade("demonic_pact_1") then
			aw = self:GetFirstWisp()
			if not IsValid(aw) then
				self:EnsureWispModifier()
			end
		end
		self.infernal = h(p, self:GetInfernalProps(false, aw))
		if self:HasUpgrade("demonic_pact_2") then
			self:SpawnSecondaryInfernal()
		end
		self:StartInfernalImmolationTimer()
	end)
end
function a7.prototype.SpawnSecondaryInfernal(self)
	if self:HasUpgrade("demonic_pact_1") then
		self:EnsureWispModifier()
	end
	if self.secondaryInfernal and not self.secondaryInfernal.disposed then
		self.secondaryInfernal:Dispose(true)
	end
	self.secondaryInfernal = h(p, self:GetInfernalProps(true))
	self:StartInfernalImmolationTimer()
end
function a7.prototype.GetInfernalProps(self, ax, aw)
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
		wispBonusHP = ax and self.d2_health or self.d1_wisp_health_bonus,
		damagePct = ax and self.d2_damage_pct or 100,
		isSecondary = ax,
		existingWisp = aw,
		c2_chance = self.c2_chance,
		c2_base_damage = self.c2_base_damage,
		c2_exp_damage = self.c2_exp_damage,
	}
end
function a7.prototype.HasUpgrade(self, ay)
	return AbilityUpgrades:HasAbilityMechanicsUpgradeByID(self.parent:GetPlayerOwnerID(), ay)
end
function a7.prototype.GetUpgradeCount(self, az)
	local aA = self.parent:GetPlayerOwnerID()
	local ah = 0
	local aB = G[az]
	if aB then
		for aC, aD in ipairs(aB) do
			if AbilityUpgrades:HasAbilityMechanicsUpgradeByID(aA, aD) then
				ah = ah + 1
			end
		end
	end
	return ah
end
function a7.prototype.GetBonusAS(self)
	local aE = self.chaos_ritual_as * self:GetUpgradeCount(0)
	if self:HasUpgrade("chaos_ritual_1") then
		aE = aE + self.c1_attackspeed
	end
	return aE
end
a7 = g(
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
	a7
)
o.modifier_warlock_talent = a7
o.warlock_interact = e()
local aF = o.warlock_interact
aF.name = "warlock_interact"
f(aF, A)
function aF.prototype.GetAbilityTextureName(self)
	return "warlock/warlock_ti10_immortal_ability_icons/warlock_fatal_bonds_ti10"
end
function aF.prototype.OnSpellStart(self)
	if self:GetCaster():IsCustomIllusion() then
		return
	end
	if self:GetCurrentAbilityCharges() <= 0 then
		return
	end
	local aG = self:GetCaster():FindModifierByName("modifier_warlock_interact")
	if aG then
		aG:Effect()
	end
end
function aF.prototype.GetIntrinsicModifierName(self)
	return "modifier_warlock_interact"
end
aF = g({ B(nil, { DisableToggle = true }) }, aF)
o.warlock_interact = aF
o.modifier_warlock_interact = e()
local aH = o.modifier_warlock_interact
aH.name = "modifier_warlock_interact"
f(aH, u)
function aH.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.pending_dirs = {}
	self.display_talent_learning = {}
	self.shard_pending = false
	self.shard_point = 0
end
function aH.prototype.OnCreated(self, a8)
	if IsServer() then
		self.pending_dirs = self:LoadDirs()
		self:LoadShardState()
		self:StartIntervalThink(0)
		self:CheckStartBonus()
		self:CheckShard()
		self:UpdateEvolutionPoint()
	end
end
function aH.prototype.OnIntervalThink(self)
	if self.parent:GetPlayerOwnerID() ~= -1 then
		self:StartIntervalThink(-1)
		self.pending_dirs = self:LoadDirs()
		self:LoadShardState()
		self:UpdateEvolutionPoint()
		self:CheckStartBonus()
		self:CheckShard()
	end
end
function aH.prototype.OnRefresh(self, a8)
	if IsServer() then
		self.pending_dirs = self:LoadDirs()
		self:LoadShardState()
		self:CheckStartBonus()
		self:CheckShard()
		self:UpdateEvolutionPoint()
	end
end
function aH.prototype.GetEvoCount(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_evo_cnt") or 0
end
function aH.prototype.SetEvoCount(self, aI)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_evo_cnt", aI)
end
function aH.prototype.GetShardFlag(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_shard_flg") or 0
end
function aH.prototype.SetShardFlag(self, aJ)
	if aJ == nil then
		aJ = 1
	end
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_shard_flg", aJ)
end
function aH.prototype.GetStartBonusFlag(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_start_bonus_flg") or 0
end
function aH.prototype.SetStartBonusFlag(self, aJ)
	if aJ == nil then
		aJ = 1
	end
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_start_bonus_flg", aJ)
end
function aH.prototype.GetShardPending(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_shard_pending") == 1
end
function aH.prototype.SetShardPending(self, aK)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_shard_pending", aK and 1 or 0)
end
function aH.prototype.GetShardPoint(self)
	return PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_shard_point") or 0
end
function aH.prototype.SetShardPoint(self, aL)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_shard_point", aL)
end
function aH.prototype.LoadDirs(self)
	local aM = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "warlock_evo_dirs")
	if not aM or #aM == 0 then
		return {}
	end
	local aN = i(aM, ",")
	local Q = {}
	for aC, aO in ipairs(aN) do
		Q[#Q + 1] = j(aO)
	end
	return Q
end
function aH.prototype.SaveDirs(self)
	PlayerData:saveData(self.parent:GetPlayerOwnerID(), "warlock_evo_dirs", table.concat(self.pending_dirs, ","))
end
function aH.prototype.LoadShardState(self)
	if self:GetShardPending() then
		self.shard_pending = true
		self.shard_point = self:GetShardPoint()
	end
end
function aH.prototype.CheckShard(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	if self:HasTalent("warlock_shard") and self:GetShardFlag() == 0 then
		local aP = self:GetAbilityTalentValue("warlock_shard", "upgrade_point")
		if aP > 0 then
			self:AddDirectionPendingPoint(aP)
			self:SetShardFlag()
		end
	end
end
function aH.prototype.CheckStartBonus(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	if self:GetStartBonusFlag() == 0 then
		self:AddDirectionPendingPoint(1)
		self:SetStartBonusFlag()
	end
end
function aH.prototype.AddDirectionPendingPoint(self, ah)
	if ah <= 0 then
		return
	end
	self.shard_point = self.shard_point + ah
	self.shard_pending = true
	self:SetShardPending(true)
	self:SetShardPoint(self.shard_point)
	self:SetEvoCount(self:GetEvoCount() + ah)
	self:UpdateEvolutionPoint()
end
function aH.prototype.AddEvolutionPoint(self, ah, aQ)
	if self.parent:IsCustomIllusion() then
		return
	end
	if aQ ~= nil then
		do
			local K = 0
			while K < ah do
				local aR = self.pending_dirs
				aR[#aR + 1] = aQ
				K = K + 1
			end
		end
		self:SaveDirs()
	end
	if ah > 0 then
		self:SetEvoCount(self:GetEvoCount() + ah)
		self:UpdateEvolutionPoint()
	end
end
function aH.prototype.ReduceEvolutionPoint(self, aS)
	if self.parent:IsCustomIllusion() then
		return
	end
	local ah = self:GetEvoCount()
	if ah > 0 then
		aS = math.min(aS, ah)
		self:SetEvoCount(ah - aS)
	end
	self:UpdateEvolutionPoint()
end
function aH.prototype.UpdateEvolutionPoint(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aA = self.parent:GetPlayerOwnerID()
	local ah = self:GetEvoCount()
	if PlayerData:isRobot(aA) then
		if ah > 0 then
			self:Effect()
		end
	else
		self.ability:SetCurrentAbilityCharges(ah)
	end
end
function aH.prototype.ShowShardDirectionSelection(self, aA)
	local aT = { G[0][1], G[1][1], G[2][1] }
	self.selection_key = Selection:AddSpecialSelection(aA, "ability_upgrades_mechenics", aT, function(aC, Q)
		if not IsValid(self) then
			return true
		end
		self.selection_key = nil
		if not Q or Q == "" then
			return true
		end
		for aU, aB in pairs(G) do
			if aB[1] == Q then
				k(self.pending_dirs, aU)
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
function aH.prototype.Effect(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aA = self.parent:GetPlayerOwnerID()
	if self.selection_key then
		Selection:RemoveSpecialSelection(aA, self.selection_key)
		self.selection_key = nil
		return
	end
	if self.shard_pending then
		self:ShowShardDirectionSelection(aA)
		return
	end
	if #self.pending_dirs == 0 then
		return
	end
	local aQ = self.pending_dirs[1]
	local aV = {}
	local aB = G[aQ]
	if aB then
		for aC, aD in ipairs(aB) do
			if not AbilityUpgrades:HasAbilityMechanicsUpgradeByID(aA, aD) then
				aV[#aV + 1] = aD
			end
		end
	end
	if #aV > 0 then
		if PlayerData:isRobot(aA) then
			GameTimer(1, function()
				if IsValid(self) then
					self:AddEvolutionEffect(aV[RandomInt(0, #aV - 1) + 1])
				end
			end)
		else
			self.selection_key = Selection:AddSpecialSelection(aA, "ability_upgrades_mechenics", aV, function(aC, Q)
				if not IsValid(self) then
					return true
				end
				self.selection_key = nil
				if Q and Q ~= "" then
					self:AddEvolutionEffect(Q)
				end
				return true
			end)
		end
	end
end
function aH.prototype.AddEvolutionEffect(self, Q)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aA = self.parent:GetPlayerOwnerID()
	AbilityUpgrades:AddAbilityMechanicsUpgradeByID(aA, Q, "warlock_interact")
	AbilityUpgrades:AddAbilityMechanicsUpgradeByID(aA, Q)
	self:ReduceEvolutionPoint(1)
	if #self.pending_dirs > 0 then
		table.remove(self.pending_dirs, 1)
	end
	self:SaveDirs()
	local aQ = -1
	for aU, aB in pairs(G) do
		if l(aB, Q) then
			aQ = aU
			break
		end
	end
	local aW = PlayerData:getplayerData(aA)
	if aW and aQ >= 0 then
		aW:modifyHeroAbilityExtraData("warlock_talent", ("warlock_interact_type_" .. tostring(aQ)) .. "_count", 1)
	end
end
function aH.prototype.ResetEvolution(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local aA = self.parent:GetPlayerOwnerID()
	if self.selection_key then
		Selection:RemoveSpecialSelection(aA, self.selection_key)
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
	for aX, aB in pairs(G) do
		do
			local K = 0
			while K < #aB do
				local ay = aB[K + 1]
				AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(aA, ay)
				AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(aA, ay, "warlock_interact")
				K = K + 1
			end
		end
	end
	local aW = PlayerData:getplayerData(aA)
	if aW then
		do
			local K = 0
			while K < 3 do
				aW:modifyHeroAbilityExtraData(
					"warlock_talent",
					("warlock_interact_type_" .. tostring(K)) .. "_count",
					0,
					true,
					true
				)
				K = K + 1
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
function aH.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = { self.parent },
	}
end
function aH.prototype.OnClearTalent(self, a8)
	if IsServer() and a8.playerID == self.parent:GetPlayerOwnerID() then
		self:ResetEvolution()
	end
end
function aH.prototype.OnBattleEnd(self, a8)
	self:SaveDirs()
end
function aH.prototype.OnBattleStartBefore(self, a8)
	self:CheckStartBonus()
	self:CheckShard()
end
function aH.prototype.OnTalentLearn(self, a8)
	if self:ConsumeDisplayTalentLearn(a8.talentName) then
		return
	end
	if a8.talentName == "warlock_shard" then
		self:CheckShard()
		return
	end
	local aQ = M(nil, a8.talentName)
	if aQ >= 0 then
		self:AddEvolutionPoint(1, aQ)
		self:LearnTalentRowForDisplay(a8.talentName)
	end
end
function aH.prototype.ConsumeDisplayTalentLearn(self, J)
	local aY = c(self.display_talent_learning, J)
	if aY == -1 then
		return false
	end
	m(self.display_talent_learning, aY, 1)
	return true
end
function aH.prototype.LearnTalentRowForDisplay(self, J)
	local L = I(nil, J)
	if not L then
		return
	end
	local O = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	if not O then
		return
	end
	do
		local K = 0
		while K < #L do
			do
				local aZ = L[K + 1]
				if aZ == J then
					goto a_
				end
				if l(O.heroTalentBranch, aZ) then
					goto a_
				end
				local b0 = self.display_talent_learning
				b0[#b0 + 1] = aZ
				O:learnTalent(aZ)
			end
			::a_::
			K = K + 1
		end
	end
end
aH = g(
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
	aH
)
o.modifier_warlock_interact = aH
p = e()
p.name = "Infernal"
function p.prototype.____constructor(self, b1)
	self.disposed = false
	self.parent = b1.parent
	self.enemy = b1.enemy
	self.ability = b1.ability
	self.buff = b1.buff
	self.attack_interval = b1.attack_interval
	self.damage_base = b1.damage_base
	self.damage_bonus = b1.damage_bonus
	self.highestSectExp = b1.highestSectExp
	self.bonusAS = b1.bonusAS
	self.bonusDamagePct = b1.bonusDamagePct
	self.hasSectAttack = b1.hasSectAttack
	self.hasFlameFist = b1.hasFlameFist
	self.isWisp = b1.isWisp
	self.wispBonusHP = b1.wispBonusHP
	self.damagePct = b1.damagePct
	self.isSecondary = b1.isSecondary
	self.wisp = b1.existingWisp
	self.c2_chance = b1.c2_chance
	self.c2_base_damage = b1.c2_base_damage
	self.c2_exp_damage = b1.c2_exp_damage
	self:Spawn()
end
function p.prototype.Spawn(self)
	if self.disposed then
		return
	end
	local b2 = self.parent:GetForwardVector()
	local b3 = Vector(-b2.y, b2.x, 0)
	local b4 = 150
	self.position = self.parent:GetAbsOrigin() + b3 * (self.isSecondary and -b4 or b4)
	self:PlaySummonParticle()
	if self.isWisp then
		if not IsValid(self.wisp) then
			self.wisp = SummonWisp(self.parent, self.wispBonusHP, E(nil, self.parent))
		end
		if self.wisp then
			self.wisp:SetAbsOrigin(self.position)
			self.wisp:SetForwardVector(b2)
			local at = self.wisp:AddNewModifier(self.parent, self.ability, "modifier_warlock_infernal_wisp", {})
			if at then
				at.owner = self
			end
			self:SpawnDummy(b2)
			if self.hasSectAttack then
				InheritSectAttackAbility(self.parent, self.wisp)
			end
		else
			self:SpawnDummy(b2)
		end
	else
		self:SpawnDummy(b2)
	end
	local b5 = self.attack_interval / (1 + self.bonusAS * 0.01)
	self.attackTimer = GameTimer(b5, function()
		if self.disposed then
			return
		end
		self:Attack()
		return b5
	end)
end
function p.prototype.PlaySummonParticle(self)
	a3(nil, self.parent, self.position)
end
function p.prototype.SpawnDummy(self, b2)
	self.dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = self.position,
			angles = VectorToAngles(b2),
			model = E(nil, self.parent),
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
	local b2 = self.parent:GetForwardVector()
	local b3 = Vector(-b2.y, b2.x, 0)
	local b4 = 150
	self.position = self.parent:GetAbsOrigin() + b3 * (self.isSecondary and -b4 or b4)
	if self.dummy and IsValid(self.dummy) then
		local b6 = self.dummy
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				angles = VectorToAngles(b2),
				model = E(nil, self.parent),
				StartingAnim = "ACT_DOTA_ATTACK",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				DefaultAnim = "ACT_DOTA_IDLE",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
				AnimateOnServer = "1",
			}
		)
		UTIL_Remove(b6)
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
	local ak = self:GetDamage()
	GameTimer(0.3, function()
		if self.disposed then
			return
		end
		if not IsInjurable(self.enemy, self.parent) then
			return
		end
		self.parent:EmitSound("Hero_WarlockGolem.Attack")
		self.buff:DealInfernalAttack(self.enemy, ak, self.damagePct)
	end)
end
function p.prototype.Dispose(self, b7)
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
		local b8 = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				angles = self.dummy:GetAngles(),
				model = E(nil, self.parent),
				DefaultAnim = "ACT_DOTA_DIE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			}
		)
		UTIL_Remove(self.dummy)
		self.dummy = nil
		GameTimer(1, function()
			if b8 and IsValid(b8) then
				UTIL_Remove(b8)
			end
		end)
	end
	if self.wisp and IsValid(self.wisp) then
		KillWisp(self.parent, self.wisp, true, false)
	end
	self.wisp = nil
end
o.modifier_warlock_infernal_last_stand = e()
local b9 = o.modifier_warlock_infernal_last_stand
b9.name = "modifier_warlock_infernal_last_stand"
f(b9, u)
function b9.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.battleEnd = false
end
function b9.prototype.OnCreated(self, a8)
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
function b9.prototype.OnDestroy(self)
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
function b9.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function b9.prototype.EOM_GetModifierMinHealth(self, a8)
	return 1
end
function b9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function b9.prototype.OnBattleEnd(self, a8)
	self.battleEnd = true
	self:Destroy()
end
b9 = g(
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
	b9
)
o.modifier_warlock_infernal_last_stand = b9
o.modifier_warlock_infernal_form = e()
local ba = o.modifier_warlock_infernal_form
ba.name = "modifier_warlock_infernal_form"
f(ba, u)
function ba.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.isHeroTransform = false
end
function ba.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("a3_damage_reduce")
end
function ba.prototype.OnCreated(self, a8)
	if IsServer() then
		self.buff = self.parent:FindModifierByName("modifier_warlock_talent")
		if IsValid(self.buff) and self.buff.isHeroInfernal then
			self.isHeroTransform = true
			a3(nil, self.parent, self.parent:GetAbsOrigin())
			self.originalModel = self.parent:GetModelName()
			self.parent:SetOriginalModel(E(nil, self.parent))
			self.parent:ManageModelChanges()
			self.parent:SetWearablesVisible(false)
			self.parent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
		end
	end
end
function ba.prototype.OnDestroy(self)
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
function ba.prototype.ECheckState(self)
	if self.isHeroTransform and self.buff and self.buff:HasUpgrade("demonic_pact_1") then
		return { [EOMModifierStates.MODIFIER_STATE_HERO_WISP] = true }
	end
	return {}
end
function ba.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_INTERVAL_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL,
	}
end
function ba.prototype.EFunctionValues(self)
	if self.isHeroTransform then
		return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = E(nil, self.parent) }
	end
	return {}
end
function ba.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -self.damage_reduce
end
function ba.prototype.EOM_GetModifierAttackIntervalConstant(self, a8)
	if not self.isHeroTransform or not self.buff then
		return
	end
	local bb = self.buff:GetBonusAS()
	return self.buff.attack_interval / (1 + bb * 0.01)
end
function ba.prototype.EOM_GetModifierAttackDamageBase(self, a8)
	if not self.isHeroTransform or not self.buff then
		return
	end
	return self.buff:GetInfernalDamage() - self.parent:GetBaseDamageMax()
end
function ba.prototype.EOM_GetModifierAttackSourceAbility(self, a8)
	if self.isHeroTransform and self.buff then
		if self.buff:HasUpgrade("demonic_pact_1") then
			return a1(nil, self.parent)
		end
		return self.buff:GetAbility()
	end
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
o.modifier_warlock_infernal_form = ba
o.modifier_warlock_infernal_wisp = e()
local bc = o.modifier_warlock_infernal_wisp
bc.name = "modifier_warlock_infernal_wisp"
f(bc, u)
function bc.prototype.OnCreated(self, a8)
	if IsServer() then
		self.parent:AddNoDraw()
	end
end
function bc.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED] = true }
end
function bc.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL }
end
function bc.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = E(nil, self:GetCaster()) }
end
function bc.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:RemoveNoDraw()
	end
	if IsServer() and self.owner and not self.owner.disposed then
		self.owner:Dispose(false)
	end
end
bc = g(
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
	bc
)
o.modifier_warlock_infernal_wisp = bc
o.warlock_ult = e()
local bd = o.warlock_ult
bd.name = "warlock_ult"
f(bd, x)
function bd.prototype.OnSpellStart(self)
	local be = self:GetCaster()
	local ad = be:GetEnemy()
	if not IsInjurable(ad) then
		return
	end
	be:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	GameTimer(0.3, function()
		if IsInjurable(ad, be) then
			ad:AddNewModifier(be, self, "modifier_warlock_ult", { duration = self:GetSpecialValueFor("duration") })
		end
	end)
end
bd = g({ y(nil) }, bd)
o.warlock_ult = bd
o.modifier_warlock_ult = e()
local bf = o.modifier_warlock_ult
bf.name = "modifier_warlock_ult"
f(bf, u)
function bf.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.heal_amount = 0
end
function bf.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilitySpecialValueFor("d3_ult_interval_reduce")
	self.damage_magic = self:GetAbilitySpecialValueFor("damage_magic")
	self.heal_amount = self:GetAbilitySpecialValueFor("d3_health_reply")
end
function bf.prototype.OnCreated(self, a8)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:IncrementStackCount()
	end
	EmitSoundOn("Hero_Warlock.ShadowWord", self.parent)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_warlock/warlock_shadow_word_buff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		self:GetCaster()
	)
end
function bf.prototype.OnRefresh(self, a8)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function bf.prototype.OnIntervalThink(self)
	if IsServer() then
		local be = self:GetCaster()
		local aj = self:GetParent()
		if IsInjurable(aj, be) then
			be:DealDamage(
				aj,
				self:GetAbility(),
				self.damage_magic * self:GetStackCount(),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			if self.heal_amount > 0 then
				Heal(be, self.heal_amount * self:GetStackCount(), "warlock_ult", "Ability")
			end
		end
	end
end
function bf.prototype.OnDestroy(self)
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
bf = g(
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
	bf
)
o.modifier_warlock_ult = bf
o.modifier_warlock_ult_caster = e()
local bg = o.modifier_warlock_ult_caster
bg.name = "modifier_warlock_ult_caster"
f(bg, u)
bg = g(
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
	bg
)
o.modifier_warlock_ult_caster = bg
o.modifier_warlock_abyssal_fusion_1 = e()
local bh = o.modifier_warlock_abyssal_fusion_1
bh.name = "modifier_warlock_abyssal_fusion_1"
f(bh, u)
function bh.prototype.OnCreated(self, a8)
	if IsServer() then
		local ad = self.parent:GetEnemy()
		if IsValid(ad) then
			self.fatalBondsIconParticleId = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				ad
			)
		end
	end
end
function bh.prototype.OnDestroy(self)
	if self.fatalBondsIconParticleId then
		ParticleManager:DestroyParticle(self.fatalBondsIconParticleId, false)
		self.fatalBondsIconParticleId = nil
	end
end
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
o.modifier_warlock_abyssal_fusion_1 = bh
o.warlock_shard = e()
local bi = o.warlock_shard
bi.name = "warlock_shard"
f(bi, r)
function bi.prototype.GetIntrinsicModifierName(self)
	return "modifier_warlock_shard"
end
bi = g({ s(nil) }, bi)
o.warlock_shard = bi
o.modifier_warlock_shard = e()
local bj = o.modifier_warlock_shard
bj.name = "modifier_warlock_shard"
f(bj, u)
function bj.prototype.OnCreated(self, a8)
	if IsServer() then
		local bk = self.parent:FindModifierByName("modifier_warlock_interact")
		if IsValid(bk) then
			bk:CheckShard()
		end
	end
end
bj = g(
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
	bj
)
o.modifier_warlock_shard = bj
return o