--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/server"
local b = require("lualib_bundle")
local c = b.__TS__ArrayIsArray
local d = b.__TS__ArrayFilter
local e = b.__TS__ArrayForEach
local f = b.__TS__Delete
local g = b.__TS__ArrayIndexOf
local h = b.__TS__ArraySplice
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 733,
		["12"] = 734,
		["13"] = 735,
		["15"] = 737,
		["17"] = 733,
		["19"] = 741,
		["20"] = 742,
		["21"] = 743,
		["22"] = 744,
		["23"] = 745,
		["24"] = 746,
		["25"] = 747,
		["26"] = 747,
		["27"] = 747,
		["28"] = 747,
		["29"] = 747,
		["30"] = 747,
		["31"] = 748,
		["32"] = 749,
		["34"] = 751,
		["35"] = 751,
		["36"] = 751,
		["37"] = 751,
		["38"] = 751,
		["39"] = 751,
		["40"] = 752,
		["41"] = 753,
		["45"] = 757,
		["46"] = 741,
		["47"] = 828,
		["48"] = 829,
		["49"] = 830,
		["50"] = 831,
		["51"] = 832,
		["52"] = 833,
		["53"] = 834,
		["54"] = 834,
		["55"] = 834,
		["56"] = 834,
		["57"] = 834,
		["58"] = 834,
		["59"] = 835,
		["60"] = 836,
		["62"] = 838,
		["63"] = 838,
		["64"] = 838,
		["65"] = 838,
		["66"] = 838,
		["67"] = 838,
		["68"] = 839,
		["69"] = 840,
		["73"] = 844,
		["74"] = 828,
		["76"] = 848,
		["77"] = 849,
		["78"] = 850,
		["79"] = 851,
		["81"] = 853,
		["82"] = 854,
		["84"] = 856,
		["85"] = 848,
		["86"] = 100,
		["87"] = 100,
		["88"] = 101,
		["89"] = 102,
		["90"] = 103,
		["91"] = 104,
		["92"] = 105,
		["93"] = 106,
		["94"] = 106,
		["95"] = 106,
		["96"] = 106,
		["97"] = 106,
		["98"] = 106,
		["99"] = 106,
		["100"] = 107,
		["101"] = 108,
		["102"] = 109,
		["103"] = 110,
		["104"] = 111,
		["105"] = 112,
		["106"] = 113,
		["107"] = 114,
		["108"] = 115,
		["109"] = 116,
		["111"] = 118,
		["112"] = 119,
		["115"] = 122,
		["116"] = 122,
		["117"] = 122,
		["118"] = 122,
		["119"] = 122,
		["120"] = 122,
		["121"] = 122,
		["122"] = 100,
		["123"] = 131,
		["124"] = 132,
		["125"] = 133,
		["126"] = 134,
		["128"] = 136,
		["130"] = 138,
		["131"] = 139,
		["133"] = 141,
		["134"] = 142,
		["136"] = 144,
		["137"] = 145,
		["139"] = 147,
		["140"] = 148,
		["141"] = 149,
		["142"] = 149,
		["143"] = 149,
		["144"] = 149,
		["145"] = 149,
		["146"] = 149,
		["147"] = 149,
		["148"] = 149,
		["149"] = 149,
		["150"] = 149,
		["153"] = 131,
		["154"] = 172,
		["155"] = 173,
		["156"] = 172,
		["157"] = 175,
		["158"] = 176,
		["159"] = 177,
		["160"] = 178,
		["161"] = 179,
		["162"] = 180,
		["163"] = 181,
		["164"] = 182,
		["165"] = 183,
		["166"] = 184,
		["167"] = 185,
		["170"] = 189,
		["174"] = 175,
		["175"] = 194,
		["176"] = 195,
		["177"] = 196,
		["178"] = 197,
		["179"] = 198,
		["180"] = 200,
		["184"] = 194,
		["185"] = 205,
		["186"] = 206,
		["187"] = 207,
		["188"] = 208,
		["189"] = 209,
		["190"] = 211,
		["194"] = 205,
		["195"] = 216,
		["196"] = 217,
		["197"] = 218,
		["199"] = 220,
		["200"] = 221,
		["201"] = 221,
		["202"] = 221,
		["203"] = 221,
		["204"] = 221,
		["205"] = 221,
		["206"] = 221,
		["207"] = 221,
		["208"] = 221,
		["209"] = 221,
		["211"] = 216,
		["212"] = 235,
		["213"] = 236,
		["214"] = 238,
		["215"] = 240,
		["217"] = 235,
		["218"] = 244,
		["219"] = 245,
		["221"] = 247,
		["222"] = 248,
		["223"] = 249,
		["224"] = 249,
		["225"] = 249,
		["226"] = 249,
		["227"] = 250,
		["228"] = 250,
		["229"] = 250,
		["230"] = 251,
		["231"] = 250,
		["232"] = 250,
		["234"] = 254,
		["235"] = 247,
		["236"] = 256,
		["237"] = 257,
		["239"] = 259,
		["240"] = 260,
		["241"] = 261,
		["242"] = 261,
		["243"] = 261,
		["244"] = 261,
		["245"] = 262,
		["246"] = 262,
		["247"] = 262,
		["248"] = 263,
		["249"] = 262,
		["250"] = 262,
		["252"] = 266,
		["253"] = 259,
		["254"] = 268,
		["255"] = 269,
		["256"] = 270,
		["257"] = 272,
		["258"] = 273,
		["259"] = 275,
		["262"] = 278,
		["263"] = 278,
		["264"] = 278,
		["265"] = 278,
		["266"] = 279,
		["267"] = 280,
		["268"] = 280,
		["269"] = 280,
		["270"] = 281,
		["271"] = 280,
		["272"] = 280,
		["273"] = 283,
		["275"] = 285,
		["276"] = 285,
		["277"] = 285,
		["278"] = 286,
		["279"] = 285,
		["280"] = 285,
		["281"] = 288,
		["283"] = 268,
		["284"] = 291,
		["285"] = 292,
		["287"] = 294,
		["288"] = 295,
		["289"] = 296,
		["290"] = 294,
		["291"] = 298,
		["292"] = 299,
		["294"] = 301,
		["295"] = 302,
		["296"] = 303,
		["297"] = 304,
		["299"] = 306,
		["301"] = 301,
		["302"] = 310,
		["303"] = 310,
		["304"] = 310,
		["306"] = 311,
		["309"] = 314,
		["310"] = 314,
		["311"] = 314,
		["312"] = 314,
		["313"] = 314,
		["314"] = 314,
		["315"] = 314,
		["316"] = 314,
		["317"] = 322,
		["318"] = 323,
		["319"] = 310,
		["320"] = 326,
		["321"] = 327,
		["322"] = 328,
		["323"] = 329,
		["324"] = 330,
		["325"] = 331,
		["327"] = 333,
		["330"] = 336,
		["331"] = 326,
		["332"] = 339,
		["333"] = 340,
		["336"] = 343,
		["337"] = 344,
		["338"] = 345,
		["341"] = 348,
		["342"] = 349,
		["343"] = 350,
		["345"] = 351,
		["346"] = 351,
		["347"] = 352,
		["348"] = 353,
		["349"] = 351,
		["352"] = 355,
		["353"] = 355,
		["354"] = 355,
		["355"] = 355,
		["356"] = 355,
		["357"] = 355,
		["358"] = 355,
		["359"] = 355,
		["360"] = 355,
		["361"] = 356,
		["362"] = 357,
		["363"] = 358,
		["364"] = 358,
		["365"] = 358,
		["366"] = 358,
		["367"] = 358,
		["368"] = 358,
		["369"] = 362,
		["370"] = 362,
		["371"] = 362,
		["372"] = 362,
		["373"] = 362,
		["374"] = 362,
		["375"] = 365,
		["376"] = 339,
		["377"] = 368,
		["378"] = 369,
		["380"] = 371,
		["381"] = 371,
		["382"] = 371,
		["384"] = 372,
		["385"] = 371,
		["386"] = 375,
		["387"] = 376,
		["389"] = 378,
		["390"] = 379,
		["391"] = 380,
		["393"] = 382,
		["394"] = 383,
		["396"] = 385,
		["397"] = 386,
		["398"] = 386,
		["399"] = 386,
		["400"] = 387,
		["401"] = 388,
		["403"] = 386,
		["404"] = 386,
		["406"] = 378,
		["407"] = 393,
		["408"] = 394,
		["410"] = 396,
		["411"] = 397,
		["412"] = 398,
		["414"] = 400,
		["415"] = 401,
		["416"] = 401,
		["417"] = 401,
		["418"] = 402,
		["419"] = 403,
		["421"] = 401,
		["422"] = 401,
		["423"] = 396,
		["424"] = 407,
		["425"] = 408,
		["426"] = 407,
		["427"] = 411,
		["428"] = 412,
		["429"] = 411,
		["430"] = 415,
		["431"] = 417,
		["432"] = 419,
		["434"] = 421,
		["435"] = 423,
		["436"] = 423,
		["437"] = 424,
		["438"] = 415,
		["439"] = 427,
		["440"] = 429,
		["443"] = 433,
		["444"] = 434,
		["445"] = 435,
		["446"] = 437,
		["448"] = 427,
		["449"] = 440,
		["450"] = 441,
		["451"] = 442,
		["452"] = 442,
		["453"] = 442,
		["454"] = 442,
		["455"] = 442,
		["456"] = 442,
		["458"] = 442,
		["459"] = 440,
		["460"] = 444,
		["461"] = 445,
		["462"] = 445,
		["463"] = 445,
		["464"] = 445,
		["465"] = 445,
		["466"] = 444,
		["467"] = 447,
		["468"] = 448,
		["469"] = 448,
		["470"] = 448,
		["471"] = 448,
		["472"] = 448,
		["473"] = 448,
		["475"] = 448,
		["476"] = 447,
		["478"] = 452,
		["479"] = 452,
		["480"] = 452,
		["482"] = 452,
		["483"] = 452,
		["485"] = 453,
		["486"] = 454,
		["487"] = 455,
		["490"] = 458,
		["491"] = 459,
		["492"] = 459,
		["493"] = 459,
		["494"] = 460,
		["495"] = 461,
		["496"] = 462,
		["497"] = 463,
		["499"] = 459,
		["500"] = 459,
		["502"] = 467,
		["503"] = 467,
		["504"] = 467,
		["505"] = 468,
		["506"] = 469,
		["507"] = 470,
		["508"] = 471,
		["510"] = 467,
		["511"] = 467,
		["513"] = 452,
		["519"] = 483,
		["520"] = 484,
		["523"] = 486,
		["524"] = 487,
		["527"] = 490,
		["528"] = 492,
		["529"] = 493,
		["531"] = 495,
		["532"] = 496,
		["533"] = 497,
		["534"] = 498,
		["535"] = 499,
		["536"] = 500,
		["537"] = 501,
		["538"] = 502,
		["539"] = 503,
		["540"] = 505,
		["541"] = 506,
		["542"] = 507,
		["543"] = 508,
		["544"] = 510,
		["545"] = 511,
		["546"] = 512,
		["547"] = 513,
		["549"] = 515,
		["550"] = 516,
		["551"] = 517,
		["552"] = 518,
		["554"] = 520,
		["556"] = 522,
		["558"] = 524,
		["560"] = 526,
		["561"] = 527,
		["563"] = 530,
		["564"] = 530,
		["565"] = 530,
		["566"] = 530,
		["567"] = 530,
		["568"] = 530,
		["569"] = 530,
		["570"] = 530,
		["571"] = 531,
		["572"] = 483,
		["573"] = 533,
		["574"] = 534,
		["575"] = 535,
		["576"] = 536,
		["578"] = 538,
		["579"] = 539,
		["581"] = 541,
		["582"] = 533,
		["583"] = 543,
		["584"] = 544,
		["585"] = 545,
		["586"] = 546,
		["587"] = 547,
		["588"] = 548,
		["589"] = 549,
		["590"] = 549,
		["591"] = 549,
		["592"] = 549,
		["593"] = 549,
		["594"] = 549,
		["595"] = 550,
		["596"] = 551,
		["598"] = 553,
		["599"] = 553,
		["600"] = 553,
		["601"] = 553,
		["602"] = 553,
		["603"] = 553,
		["604"] = 554,
		["605"] = 555,
		["609"] = 559,
		["610"] = 543,
		["612"] = 564,
		["613"] = 565,
		["614"] = 566,
		["615"] = 567,
		["616"] = 568,
		["618"] = 570,
		["619"] = 571,
		["620"] = 571,
		["621"] = 571,
		["622"] = 571,
		["623"] = 572,
		["624"] = 572,
		["625"] = 572,
		["626"] = 572,
		["627"] = 573,
		["628"] = 573,
		["629"] = 573,
		["630"] = 573,
		["632"] = 564,
		["634"] = 579,
		["635"] = 580,
		["636"] = 580,
		["637"] = 580,
		["638"] = 580,
		["639"] = 581,
		["640"] = 581,
		["641"] = 581,
		["642"] = 581,
		["643"] = 582,
		["644"] = 582,
		["645"] = 582,
		["646"] = 582,
		["647"] = 583,
		["648"] = 579,
		["653"] = 596,
		["654"] = 597,
		["657"] = 599,
		["658"] = 600,
		["661"] = 603,
		["662"] = 604,
		["663"] = 605,
		["665"] = 607,
		["666"] = 608,
		["668"] = 610,
		["669"] = 611,
		["670"] = 612,
		["672"] = 614,
		["673"] = 618,
		["674"] = 619,
		["675"] = 620,
		["676"] = 623,
		["677"] = 624,
		["678"] = 625,
		["679"] = 626,
		["680"] = 627,
		["681"] = 628,
		["682"] = 629,
		["683"] = 630,
		["684"] = 632,
		["685"] = 633,
		["686"] = 634,
		["687"] = 635,
		["688"] = 637,
		["689"] = 638,
		["690"] = 639,
		["691"] = 640,
		["693"] = 642,
		["694"] = 643,
		["695"] = 644,
		["696"] = 645,
		["698"] = 647,
		["700"] = 649,
		["702"] = 651,
		["704"] = 653,
		["705"] = 654,
		["707"] = 657,
		["708"] = 657,
		["709"] = 657,
		["710"] = 657,
		["711"] = 657,
		["712"] = 657,
		["713"] = 657,
		["714"] = 657,
		["715"] = 658,
		["716"] = 596,
		["717"] = 660,
		["718"] = 661,
		["719"] = 662,
		["720"] = 663,
		["722"] = 665,
		["723"] = 666,
		["725"] = 668,
		["726"] = 660,
		["727"] = 670,
		["728"] = 671,
		["729"] = 672,
		["730"] = 673,
		["731"] = 674,
		["732"] = 675,
		["733"] = 676,
		["734"] = 676,
		["735"] = 676,
		["736"] = 676,
		["737"] = 676,
		["738"] = 676,
		["739"] = 677,
		["740"] = 678,
		["742"] = 680,
		["743"] = 680,
		["744"] = 680,
		["745"] = 680,
		["746"] = 680,
		["747"] = 680,
		["748"] = 681,
		["749"] = 682,
		["753"] = 686,
		["754"] = 670,
		["760"] = 695,
		["761"] = 697,
		["764"] = 699,
		["765"] = 700,
		["768"] = 703,
		["769"] = 704,
		["770"] = 705,
		["772"] = 707,
		["773"] = 708,
		["774"] = 713,
		["776"] = 719,
		["777"] = 720,
		["778"] = 724,
		["779"] = 724,
		["780"] = 724,
		["781"] = 724,
		["782"] = 724,
		["783"] = 724,
		["784"] = 724,
		["785"] = 724,
		["786"] = 725,
		["787"] = 695,
		["789"] = 760,
		["790"] = 760,
		["791"] = 760,
		["793"] = 761,
		["794"] = 762,
		["795"] = 763,
		["796"] = 765,
		["799"] = 760,
		["805"] = 777,
		["806"] = 778,
		["809"] = 780,
		["810"] = 781,
		["813"] = 784,
		["814"] = 785,
		["815"] = 786,
		["817"] = 788,
		["818"] = 788,
		["819"] = 788,
		["820"] = 788,
		["821"] = 789,
		["822"] = 790,
		["823"] = 791,
		["824"] = 792,
		["825"] = 793,
		["826"] = 794,
		["827"] = 795,
		["828"] = 796,
		["829"] = 797,
		["830"] = 798,
		["831"] = 800,
		["832"] = 801,
		["833"] = 802,
		["834"] = 803,
		["835"] = 805,
		["836"] = 806,
		["837"] = 807,
		["838"] = 808,
		["840"] = 810,
		["841"] = 811,
		["842"] = 812,
		["843"] = 813,
		["845"] = 815,
		["847"] = 817,
		["849"] = 819,
		["851"] = 821,
		["852"] = 822,
		["854"] = 825,
		["855"] = 825,
		["856"] = 825,
		["857"] = 825,
		["858"] = 825,
		["859"] = 825,
		["860"] = 825,
		["861"] = 825,
		["862"] = 826,
		["863"] = 777,
		["864"] = 858,
		["865"] = 859,
		["868"] = 860,
		["869"] = 861,
		["871"] = 863,
		["872"] = 864,
		["873"] = 865,
		["874"] = 865,
		["875"] = 865,
		["876"] = 865,
		["877"] = 865,
		["878"] = 865,
		["879"] = 865,
		["880"] = 865,
		["881"] = 858,
		["884"] = 868,
		["885"] = 869,
		["886"] = 870,
		["887"] = 871,
		["889"] = 873,
		["890"] = 868,
		["895"] = 881,
		["896"] = 882,
		["897"] = 883,
		["898"] = 884,
		["899"] = 885,
		["901"] = 887,
		["903"] = 881,
		["910"] = 900,
		["911"] = 900,
		["912"] = 900,
		["914"] = 901,
		["917"] = 905,
		["918"] = 906,
		["921"] = 909,
		["922"] = 910,
		["923"] = 911,
		["924"] = 912,
		["925"] = 913,
		["927"] = 915,
		["928"] = 916,
		["930"] = 918,
		["931"] = 919,
		["932"] = 920,
		["933"] = 921,
		["936"] = 924,
		["937"] = 925,
		["938"] = 930,
		["939"] = 931,
		["940"] = 932,
		["942"] = 938,
		["943"] = 939,
		["944"] = 940,
		["945"] = 941,
		["947"] = 947,
		["948"] = 948,
		["949"] = 949,
		["950"] = 950,
		["951"] = 951,
		["952"] = 953,
		["953"] = 954,
		["954"] = 956,
		["955"] = 957,
		["956"] = 959,
		["957"] = 960,
		["958"] = 961,
		["959"] = 962,
		["960"] = 963,
		["961"] = 964,
		["963"] = 967,
		["964"] = 968,
		["965"] = 969,
		["966"] = 970,
		["968"] = 972,
		["970"] = 974,
		["972"] = 976,
		["974"] = 978,
		["975"] = 979,
		["977"] = 982,
		["978"] = 982,
		["979"] = 982,
		["980"] = 982,
		["981"] = 982,
		["982"] = 982,
		["983"] = 982,
		["984"] = 982,
		["985"] = 983,
		["986"] = 900,
		["987"] = 990,
		["988"] = 991,
		["989"] = 992,
		["990"] = 993,
		["992"] = 995,
		["993"] = 996,
		["995"] = 998,
		["996"] = 990,
		["997"] = 1000,
		["998"] = 1001,
		["999"] = 1002,
		["1000"] = 1003,
		["1001"] = 1004,
		["1002"] = 1005,
		["1003"] = 1006,
		["1004"] = 1007,
		["1005"] = 1008,
		["1007"] = 1010,
		["1008"] = 1011,
		["1012"] = 1015,
		["1013"] = 1000,
		["1019"] = 1024,
		["1020"] = 1024,
		["1021"] = 1024,
		["1023"] = 1024,
		["1024"] = 1024,
		["1026"] = 1025,
		["1027"] = 1027,
		["1028"] = 1028,
		["1032"] = 1033,
		["1033"] = 1034,
		["1034"] = 1035,
		["1035"] = 1036,
		["1037"] = 1038,
		["1038"] = 1038,
		["1039"] = 1038,
		["1040"] = 1038,
		["1042"] = 1040,
		["1043"] = 1045,
		["1045"] = 1047,
		["1046"] = 1048,
		["1047"] = 1049,
		["1048"] = 1050,
		["1050"] = 1052,
		["1051"] = 1053,
		["1052"] = 1054,
		["1053"] = 1055,
		["1054"] = 1057,
		["1055"] = 1057,
		["1056"] = 1057,
		["1057"] = 1057,
		["1058"] = 1057,
		["1059"] = 1057,
		["1060"] = 1057,
		["1061"] = 1057,
		["1062"] = 1058,
		["1063"] = 1059,
		["1064"] = 1059,
		["1065"] = 1059,
		["1066"] = 1059,
		["1067"] = 1059,
		["1068"] = 1059,
		["1069"] = 1059,
		["1070"] = 1059,
		["1071"] = 1059,
		["1073"] = 1069,
		["1074"] = 1070,
		["1075"] = 1071,
		["1076"] = 1072,
		["1078"] = 1074,
		["1079"] = 1075,
		["1081"] = 1078,
		["1082"] = 1078,
		["1083"] = 1078,
		["1084"] = 1078,
		["1085"] = 1078,
		["1086"] = 1078,
		["1087"] = 1078,
		["1088"] = 1078,
		["1090"] = 1024,
		["1096"] = 1088,
		["1097"] = 1088,
		["1098"] = 1088,
		["1100"] = 1088,
		["1101"] = 1088,
		["1103"] = 1089,
		["1106"] = 1092,
		["1109"] = 1096,
		["1110"] = 1097,
		["1111"] = 1099,
		["1112"] = 1101,
		["1113"] = 1102,
		["1115"] = 1104,
		["1116"] = 1105,
		["1117"] = 1106,
		["1119"] = 1108,
		["1120"] = 1108,
		["1121"] = 1108,
		["1122"] = 1108,
		["1123"] = 1108,
		["1124"] = 1108,
		["1125"] = 1108,
		["1126"] = 1108,
		["1127"] = 1108,
		["1128"] = 1108,
		["1129"] = 1108,
		["1130"] = 1109,
		["1131"] = 1110,
		["1132"] = 1110,
		["1133"] = 1110,
		["1134"] = 1110,
		["1135"] = 1110,
		["1136"] = 1110,
		["1137"] = 1110,
		["1139"] = 1088,
		["1145"] = 1119,
		["1146"] = 1120,
		["1147"] = 1121,
		["1148"] = 1121,
		["1149"] = 1121,
		["1150"] = 1121,
		["1152"] = 1123,
		["1153"] = 1119,
		["1159"] = 1132,
		["1160"] = 1132,
		["1161"] = 1132,
		["1163"] = 1133,
		["1166"] = 1138,
		["1167"] = 1139,
		["1168"] = 1141,
		["1169"] = 1142,
		["1170"] = 1142,
		["1171"] = 1142,
		["1172"] = 1142,
		["1173"] = 1142,
		["1174"] = 1142,
		["1175"] = 1142,
		["1177"] = 1132,
		["1182"] = 1150,
		["1183"] = 1150,
		["1184"] = 1150,
		["1186"] = 1154,
		["1187"] = 1155,
		["1188"] = 1156,
		["1189"] = 1157,
		["1190"] = 1157,
		["1191"] = 1157,
		["1192"] = 1157,
		["1193"] = 1157,
		["1194"] = 1157,
		["1195"] = 1157,
		["1196"] = 1157,
		["1197"] = 1157,
		["1198"] = 1157,
		["1199"] = 1157,
		["1200"] = 1150,
		["1206"] = 1165,
		["1207"] = 1169,
		["1208"] = 1170,
		["1209"] = 1165,
		["1211"] = 1174,
		["1212"] = 1175,
		["1213"] = 1176,
		["1214"] = 1177,
		["1215"] = 1179,
		["1216"] = 1181,
		["1217"] = 1183,
		["1218"] = 1184,
		["1219"] = 1185,
		["1226"] = 1174,
		["1228"] = 1195,
		["1229"] = 1196,
		["1230"] = 1197,
		["1231"] = 1198,
		["1232"] = 1200,
		["1235"] = 1203,
		["1236"] = 1195,
		["1238"] = 1207,
		["1239"] = 1208,
		["1240"] = 1209,
		["1241"] = 1209,
		["1242"] = 1209,
		["1243"] = 1210,
		["1244"] = 1211,
		["1245"] = 1212,
		["1246"] = 1212,
		["1247"] = 1212,
		["1248"] = 1212,
		["1249"] = 1213,
		["1250"] = 1209,
		["1251"] = 1209,
		["1252"] = 1215,
		["1253"] = 1216,
		["1255"] = 1207,
		["1256"] = 1222,
		["1257"] = 1223,
		["1258"] = 1224,
		["1259"] = 1225,
		["1260"] = 1225,
		["1261"] = 1225,
		["1262"] = 1225,
		["1263"] = 1226,
		["1264"] = 1227,
		["1265"] = 1228,
		["1268"] = 1222,
		["1270"] = 1237,
		["1271"] = 1238,
		["1272"] = 1239,
		["1273"] = 1240,
		["1274"] = 1241,
		["1275"] = 1241,
		["1279"] = 1237,
		["1281"] = 1247,
		["1282"] = 1248,
		["1283"] = 1249,
		["1284"] = 1250,
		["1286"] = 1247,
		["1288"] = 1255,
		["1290"] = 1256,
		["1291"] = 1256,
		["1293"] = 1256,
		["1294"] = 1257,
		["1296"] = 1259,
		["1297"] = 1255,
		["1299"] = 1263,
		["1300"] = 1264,
		["1301"] = 1265,
		["1302"] = 1266,
		["1303"] = 1268,
		["1306"] = 1271,
		["1307"] = 1263,
		["1312"] = 1279,
		["1313"] = 1280,
		["1314"] = 1281,
		["1315"] = 1283,
		["1317"] = 1279,
		["1323"] = 1292,
		["1324"] = 1292,
		["1325"] = 1292,
		["1327"] = 1292,
		["1328"] = 1292,
		["1330"] = 1293,
		["1331"] = 1294,
		["1332"] = 1295,
		["1333"] = 1297,
		["1336"] = 1292,
		["1342"] = 1308,
		["1343"] = 1308,
		["1344"] = 1308,
		["1346"] = 1309,
		["1349"] = 1311,
		["1350"] = 1312,
		["1353"] = 1315,
		["1354"] = 1316,
		["1355"] = 1317,
		["1357"] = 1319,
		["1358"] = 1320,
		["1359"] = 1322,
		["1361"] = 1324,
		["1362"] = 1328,
		["1363"] = 1329,
		["1364"] = 1330,
		["1365"] = 1331,
		["1367"] = 1334,
		["1368"] = 1334,
		["1369"] = 1334,
		["1370"] = 1334,
		["1371"] = 1334,
		["1372"] = 1334,
		["1373"] = 1334,
		["1374"] = 1334,
		["1375"] = 1335,
		["1376"] = 1308,
		["1377"] = 1338,
		["1378"] = 1339,
		["1379"] = 1340,
		["1380"] = 1341,
		["1381"] = 1342,
		["1382"] = 1343,
		["1383"] = 1345,
		["1384"] = 1346,
		["1386"] = 1349,
		["1387"] = 1350,
		["1391"] = 1354,
		["1392"] = 1338,
		["1394"] = 1358,
		["1395"] = 1359,
		["1396"] = 1360,
		["1397"] = 1361,
		["1399"] = 1363,
		["1400"] = 1364,
		["1402"] = 1366,
		["1403"] = 1358,
		["1405"] = 1370,
		["1406"] = 1371,
		["1407"] = 1372,
		["1409"] = 1374,
		["1410"] = 1375,
		["1411"] = 1376,
		["1412"] = 1377,
		["1414"] = 1379,
		["1415"] = 1380,
		["1417"] = 1382,
		["1418"] = 1383,
		["1420"] = 1385,
		["1421"] = 1386,
		["1423"] = 1389,
		["1424"] = 1390,
		["1426"] = 1392,
		["1427"] = 1393,
		["1428"] = 1394,
		["1430"] = 1396,
		["1431"] = 1398,
		["1432"] = 1399,
		["1433"] = 1400,
		["1434"] = 1370,
		["1436"] = 1406,
		["1437"] = 1407,
		["1438"] = 1408,
		["1440"] = 1410,
		["1441"] = 1406,
		["1442"] = 1412,
		["1443"] = 1413,
		["1444"] = 1414,
		["1446"] = 1416,
		["1447"] = 1412,
		["1449"] = 1420,
		["1450"] = 1421,
		["1451"] = 1420,
		["1453"] = 1427,
		["1454"] = 1428,
		["1455"] = 1429,
		["1456"] = 1429,
		["1457"] = 1429,
		["1458"] = 1429,
		["1459"] = 1430,
		["1460"] = 1431,
		["1461"] = 1434,
		["1462"] = 1435,
		["1463"] = 1436,
		["1464"] = 1437,
		["1467"] = 1440,
		["1469"] = 1427,
		["1471"] = 1444,
		["1472"] = 1445,
		["1473"] = 1446,
		["1474"] = 1446,
		["1475"] = 1446,
		["1476"] = 1446,
		["1477"] = 1447,
		["1478"] = 1448,
		["1479"] = 1444,
		["1481"] = 1451,
		["1482"] = 1452,
		["1483"] = 1453,
		["1484"] = 1453,
		["1485"] = 1453,
		["1486"] = 1453,
		["1487"] = 1454,
		["1488"] = 1455,
		["1489"] = 1451,
		["1491"] = 1458,
		["1492"] = 1459,
		["1493"] = 1458,
		["1495"] = 1462,
		["1496"] = 1463,
		["1497"] = 1462,
		["1499"] = 1466,
		["1500"] = 1467,
		["1501"] = 1468,
		["1502"] = 1469,
		["1503"] = 1470,
		["1504"] = 1472,
		["1505"] = 1472,
		["1506"] = 1472,
		["1507"] = 1472,
		["1508"] = 1472,
		["1509"] = 1472,
		["1510"] = 1472,
		["1511"] = 1472,
		["1512"] = 1472,
		["1513"] = 1472,
		["1514"] = 1472,
		["1515"] = 1472,
		["1516"] = 1472,
		["1517"] = 1472,
		["1518"] = 1472,
		["1519"] = 1472,
		["1522"] = 1466,
		["1523"] = 1492,
		["1524"] = 1493,
		["1525"] = 1494,
		["1526"] = 1495,
		["1527"] = 1495,
		["1528"] = 1495,
		["1529"] = 1495,
		["1530"] = 1495,
		["1531"] = 1495,
		["1533"] = 1497,
		["1536"] = 1492,
		["1537"] = 1502,
		["1538"] = 1503,
		["1539"] = 1504,
		["1540"] = 1505,
		["1541"] = 1505,
		["1542"] = 1505,
		["1543"] = 1505,
		["1544"] = 1505,
		["1545"] = 1505,
		["1547"] = 1507,
		["1550"] = 1502,
		["1551"] = 1514,
		["1552"] = 1515,
		["1553"] = 1516,
		["1554"] = 1517,
		["1555"] = 1518,
		["1556"] = 1520,
		["1560"] = 1514,
		["1561"] = 1527,
		["1562"] = 1528,
		["1563"] = 1529,
		["1566"] = 1532,
		["1569"] = 1535,
		["1570"] = 1536,
		["1573"] = 1539,
		["1576"] = 1542,
		["1577"] = 1543,
		["1578"] = 1545,
		["1579"] = 1545,
		["1582"] = 1527,
	}
)
function GetPoison(j)
	if j:HasModifier("modifier_poison_custom") then
		return j:FindModifierByName("modifier_poison_custom"):GetStackCount()
	else
		return 0
	end
end
function ReducePoison(k, l)
	l = math.floor(l)
	if k:HasModifier("modifier_poison_custom") then
		local m = k:FindModifierByName("modifier_poison_custom")
		if IsValid(m) then
			if m:GetStackCount() >= l then
				FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS, { iCount = l }, m:GetCaster(), k)
				m:DecrementStackCount(l)
				return l
			else
				FireModifierEvent(
					EOMModifierEvents.MODIFIER_EVENT_ON_POISON_LOSS,
					{ iCount = m:GetStackCount() },
					m:GetCaster(),
					k
				)
				m:Destroy()
				return m:GetStackCount()
			end
		end
	end
	return 0
end
function ReduceInjury(k, l)
	l = math.floor(l)
	if k:HasModifier("modifier_injury_custom") then
		local m = k:FindModifierByName("modifier_injury_custom")
		if IsValid(m) then
			if m:GetStackCount() >= l then
				FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS, { iCount = l }, m:GetCaster(), k)
				m:DecrementStackCount(l)
				return l
			else
				FireModifierEvent(
					EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS,
					{ iCount = m:GetStackCount() },
					m:GetCaster(),
					k
				)
				m:Destroy()
				return m:GetStackCount()
			end
		end
	end
	return 0
end
function GetInjury(j)
	local n = 0
	if j:HasModifier("modifier_injury_custom") then
		n = n + j:FindModifierByName("modifier_injury_custom"):GetStackCount()
	end
	if j:HasModifier("modifier_injury_permanent") then
		n = n + j:FindModifierByName("modifier_injury_permanent"):GetStackCount()
	end
	return n
end
function executeOrder(j, o, ...)
	local p = { ... }
	local q
	local r
	local s
	local t = { DOTA_UNIT_ORDER_MOVE_TO_POSITION, DOTA_UNIT_ORDER_ATTACK_MOVE }
	local u = { DOTA_UNIT_ORDER_MOVE_TO_TARGET, DOTA_UNIT_ORDER_ATTACK_TARGET }
	local v = {
		DOTA_UNIT_ORDER_CAST_POSITION,
		DOTA_UNIT_ORDER_CAST_TARGET,
		DOTA_UNIT_ORDER_CAST_TARGET_TREE,
		DOTA_UNIT_ORDER_CAST_NO_TARGET,
		DOTA_UNIT_ORDER_CAST_TOGGLE,
	}
	if TableFindKey(t, o) ~= nil then
		s = p[1]
	elseif TableFindKey(u, o) ~= nil then
		r = p[1]
	elseif TableFindKey(v, o) ~= nil then
		if o == DOTA_UNIT_ORDER_CAST_POSITION then
			q = p[1]
			s = p[2]
		elseif o == DOTA_UNIT_ORDER_CAST_NO_TARGET or o == DOTA_UNIT_ORDER_CAST_TOGGLE then
			q = p[1]
		else
			q = p[1]
			r = p[2]
		end
	end
	ExecuteOrderFromTable({
		UnitIndex = j:entindex(),
		OrderType = o,
		TargetIndex = IsValid(r) and r:entindex() or nil,
		AbilityIndex = IsValid(q) and q:entindex() or nil,
		Position = s,
	})
end
CDOTA_BaseNPC.DealDamage = function(self, w, q, x, y, z, A)
	local B = {}
	if c(w) then
		B = w
	else
		B[#B + 1] = w
	end
	if IsValid(q) and y == nil then
		y = q:GetDamageType()
	end
	if y == nil then
		y = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
	end
	if z == nil then
		z = DamageFlags.DAMAGE_FLAG_NONE
	end
	for C, j in ipairs(B) do
		if IsValid(j) then
			DamageSystem:dealDamage({
				attacker = self,
				target = j,
				ability = q,
				damage = x,
				damage_type = y,
				damage_flags = z,
				damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
				ability_upgrade = A,
			})
		end
	end
end
CDOTA_BaseNPC.IsCustomIllusion = function(self)
	return self:HasModifier("modifier_illusion_visual")
end
CDOTA_BaseNPC.TriggerSectEvadeEffect = function(self, D)
	if IsInjurable(self) then
		if self:HasModifier("modifier_sect_evade") then
			local E = self:FindModifierByName("modifier_sect_evade")
			if IsValid(E) then
				local F = D
				if D then
					F = shallowcopy(D)
					if F.attacker == self then
						F.attacker = D.target
						F.target = D.attacker
					end
				end
				E:TriggerEvadeEffect(F)
			end
		end
	end
end
CDOTA_BaseNPC.TriggerSectAttackNormal = function(self, G, H)
	if IsInjurable(self, G) then
		if self:HasModifier("modifier_sect_attack") then
			local E = self:FindModifierByName("modifier_sect_attack")
			if IsValid(E) then
				E:TriggerNormalEffect(G, nil, H)
			end
		end
	end
end
CDOTA_BaseNPC.TriggerSectAttackRAndSR = function(self, G)
	if IsInjurable(self, G) then
		if self:HasModifier("modifier_sect_attack") then
			local E = self:FindModifierByName("modifier_sect_attack")
			if IsValid(E) then
				E:TriggerRAndSREffect(G, nil)
			end
		end
	end
end
CDOTA_BaseNPC.DealChaosDamage = function(self, G, I, x, z, A)
	if z == nil then
		z = DamageFlags.DAMAGE_FLAG_NONE
	end
	if IsValid(G) then
		DamageSystem:dealDamage({
			attacker = self,
			target = G,
			ability = I,
			damage = x,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS,
			damage_flags = z,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			ability_upgrade = A,
		})
	end
end
CDOTA_BaseNPC.StartAbilityAI = function(self)
	local I = self:GetAbilityByIndex(1)
	if IsValid(I) and I._StartThink then
		I:_StartThink()
	end
end
if CDOTA_BaseNPC.AddNoDraw_Engine == nil then
	CDOTA_BaseNPC.AddNoDraw_Engine = CDOTA_BaseNPC.AddNoDraw
end
CDOTA_BaseNPC.AddNoDraw = function(self)
	if not LoadData(self, "_WEARABLES_HIDDEN_") then
		local J = d(self:GetChildren(), function(C, K)
			return K:GetClassname() == "dota_item_wearable"
		end)
		e(J, function(C, K)
			K:AddEffects(EF_NODRAW)
		end)
	end
	self:AddNoDraw_Engine()
end
if CDOTA_BaseNPC.RemoveNoDraw_Engine == nil then
	CDOTA_BaseNPC.RemoveNoDraw_Engine = CDOTA_BaseNPC.RemoveNoDraw
end
CDOTA_BaseNPC.RemoveNoDraw = function(self)
	if not LoadData(self, "_WEARABLES_HIDDEN_") then
		local J = d(self:GetChildren(), function(C, K)
			return K:GetClassname() == "dota_item_wearable"
		end)
		e(J, function(C, K)
			K:RemoveEffects(EF_NODRAW)
		end)
	end
	self:RemoveNoDraw_Engine()
end
CDOTA_BaseNPC.SetWearablesVisible = function(self, L)
	local M = self:FindModifierByName("modifier_skin")
	if M then
		M:DestroyWearableAmbient()
		if L then
			M:CreateWearableAmbient()
		end
	end
	local J = d(self:GetChildren(), function(C, K)
		return K:GetClassname() == "dota_item_wearable"
	end)
	if L then
		e(J, function(C, K)
			K:RemoveEffects(EF_NODRAW)
		end)
		SaveData(self, "_WEARABLES_HIDDEN_", nil)
	else
		e(J, function(C, K)
			K:AddEffects(EF_NODRAW)
		end)
		SaveData(self, "_WEARABLES_HIDDEN_", 1)
	end
end
if CDOTA_BaseNPC.StopSound_Engine == nil then
	CDOTA_BaseNPC.StopSound_Engine = CDOTA_BaseNPC.StopSound
end
CDOTA_BaseNPC.StopSound = function(self, N)
	N = Wearable:getReplaceSound(self, N)
	self:StopSound_Engine(N)
end
if CDOTA_BaseNPC.EmitSound_Engine == nil then
	CDOTA_BaseNPC.EmitSound_Engine = CDOTA_BaseNPC.EmitSound
end
CDOTA_BaseNPC.EmitSound = function(self, N, O)
	N = Wearable:getReplaceSound(self, N)
	if O then
		EmitSoundOnLocationWithCaster(O, N, self)
	else
		self:EmitSound_Engine(N)
	end
end
CDOTA_BaseNPC.KnockBack = function(self, P, Q, R, S, T)
	if T == nil then
		T = false
	end
	if not IsValid(self) or not self:IsAlive() then
		return
	end
	local U =
		{ vDirection = P, duration = S, knockback_duration = S, knockback_distance = Q, knockback_height = R, ignore_block = T }
	self:RemoveModifierByName("modifier_knockback_custom")
	return self:AddNewModifier(self, nil, "modifier_knockback_custom", U)
end
CDOTA_BaseNPC.GetDefaultModelScale = function(self)
	local V = LoadData(self, "_MODEL_SCALE")
	if type(V) ~= "number" then
		local U = KeyValues.UnitsKv[self:GetUnitName()]
		if U and type(U.ModelScale) == "number" then
			return U.ModelScale
		else
			return 1
		end
	end
	return V
end
CDOTA_BaseNPC.CreatePhantom = function(self, O, W)
	if not IsValid(self) then
		return
	end
	local X = self:GetUnitName()
	local U = KeyValues.UnitsKv[X]
	if not U then
		return
	end
	local Y = self:GetPlayerOwnerID()
	local Z = deepcopy(U)
	Z.HasInventory = 0
	do
		local _ = 1
		while _ <= 20 do
			local a0 = "Ability" .. tostring(_)
			f(Z, a0)
			_ = _ + 1
		end
	end
	local a1 = CreateUnitByNameWithNewData(X, O, false, W, W, self:GetTeamNumber(), Z)
	a1:SetUnitCanRespawn(false)
	local a2 = Wearable:serviceGetEquipWearable(Y, X)
	a1:AddNewModifier(a1, a1:GetDummyAbility(), "modifier_skin_phantom", { unitName = X, id = a2 })
	a1:AddNewModifier(W, a1:GetDummyAbility(), "modifier_custom_phantom", { unitName = X })
	return a1
end
if CDOTA_Item_Lua.SpendCharge_Engine == nil then
	CDOTA_Item_Lua.SpendCharge_Engine = CDOTA_Item_Lua.SpendCharge
end
CDOTA_Item_Lua.SpendCharge = function(self, a3)
	if a3 == nil then
		a3 = 0
	end
	self:SpendCharge_Engine(a3)
end
if CDOTABaseAbility.UseResources_Engine == nil then
	CDOTABaseAbility.UseResources_Engine = CDOTABaseAbility.UseResources
end
CDOTABaseAbility.UseResources = function(self, a4, a5, a6)
	if a6 then
		self:StartCooldown_Engine(self:GetCooldown(self:GetLevel() - 1) + FRAME_TIME)
	end
	if a4 then
		self:GetCaster():SetMana(self:GetCaster():GetMana() - self:GetManaCost(self:GetLevel() - 1))
	end
	if a6 then
		self:GameTimer(self:GetCooldown(self:GetLevel() - 1), function()
			if IsValid(self) then
				self:EndCooldown()
			end
		end)
	end
end
if CDOTABaseAbility.StartCooldown_Engine == nil then
	CDOTABaseAbility.StartCooldown_Engine = CDOTABaseAbility.StartCooldown
end
CDOTABaseAbility.StartCooldown = function(self, a6)
	if a6 < 0 then
		a6 = self:GetCooldown(self:GetLevel() - 1)
	end
	self:StartCooldown_Engine(a6 + FRAME_TIME * 10)
	self:GameTimer(a6, function()
		if IsValid(self) then
			self:EndCooldown()
		end
	end)
end
CDOTABaseAbility.GetTarget = function(self)
	return self:GetCaster():GetEnemy()
end
CDOTA_Buff.GetTotalWin = function(self)
	return PlayerData:getTotalWin(self:GetCaster():GetPlayerOwnerID())
end
CDOTA_Buff.hook = function(self, a7, a8)
	if self._HookList == nil then
		self._HookList = {}
	end
	local a9 = DamageSystem:hook(a7, a8, self)
	local aa = self._HookList
	aa[#aa + 1] = a9
	return a9
end
CDOTA_Buff.unhook = function(self, a9)
	if self._HookList == nil then
		return
	end
	local _ = g(self._HookList, a9)
	if _ ~= -1 then
		DamageSystem:unHook(a9)
		h(self._HookList, _, 1)
	end
end
CDOTA_Buff.modifyData = function(self, ab, ac)
	local Y = self:GetParent():GetPlayerOwnerID()
	local ad = PlayerData
	local ae = PlayerData.saveData
	local af = ab
	local ag = PlayerData:loadData(Y, ab)
	if ag == nil then
		ag = 0
	end
	ae(ad, Y, af, ag + ac)
end
CDOTA_Buff.saveData = function(self, ab, ac)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), ab, ac)
end
CDOTA_Buff.loadData = function(self, ab)
	local ah = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), ab)
	if ah == nil then
		ah = 0
	end
	return ah
end
function ForWithInterval(ai, n, a8, aj, ak)
	if aj == nil then
		aj = false
	end
	if ak == nil then
		ak = true
	end
	local al = 0
	if n == 1 and not aj then
		a8(1)
		return
	end
	if ak then
		GameTimer(aj and ai or 0, function()
			if al < n then
				al = al + 1
				a8(al)
				return ai
			end
		end)
	else
		Timer(aj and ai or 0, function()
			if al < n then
				al = al + 1
				a8(al)
				return ai
			end
		end)
	end
end
function AddIce(k, r, l, am, an)
	if not IsValid(r) then
		return
	end
	local ao = GetIgnoreIcePercent(r)
	if ao > 0 and PRD(r, ao, "common_ignore_ice") then
		return
	end
	local q = k:FindAbilityByName("sect_ice")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_ice")
	end
	l = math.floor(
		l * (1 + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS_PERCENTAGE) * 0.01)
	)
	l = l + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS)
	l = math.max(0, l)
	local ap = l
	local m = r:FindModifierByName("modifier_fury_custom")
	if IsValid(m) then
		local aq = m:GetStackCount()
		local ar = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local as = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local at = Round(l * ar)
		local au = Round(aq * as)
		local av = at - au
		local aw = { iCount = 0 }
		if av >= 0 then
			aw.iCount = aq
			l = Round(av / ar)
			m:Destroy()
		else
			local ax = Round(-av / as)
			aw.iCount = aq - ax
			if ax > 0 then
				m:SetStackCount(ax)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS, aw, r, k)
	end
	if l > 0 then
		r:AddNewModifier(k, q, "modifier_ice_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, r, "ice", ap, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED,
		{ iStackCount = ap, origin = am, type = an },
		k,
		r
	)
end
function GetIce(j)
	local n = 0
	if j:HasModifier("modifier_ice_custom") then
		n = n + j:FindModifierByName("modifier_ice_custom"):GetStackCount()
	end
	if j:HasModifier("modifier_ice_permanent") then
		n = n + j:FindModifierByName("modifier_ice_permanent"):GetStackCount()
	end
	return n
end
function ReduceIce(k, l)
	l = math.floor(l)
	if k:HasModifier("modifier_ice_custom") then
		local m = k:FindModifierByName("modifier_ice_custom")
		if IsValid(m) then
			if m:GetStackCount() >= l then
				FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS, { iCount = l }, m:GetCaster(), k)
				m:DecrementStackCount(l)
				return l
			else
				FireModifierEvent(
					EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS,
					{ iCount = m:GetStackCount() },
					m:GetCaster(),
					k
				)
				m:Destroy()
				return m:GetStackCount()
			end
		end
	end
	return 0
end
function ReduceDebuff(k, ay, az)
	if ay and ay > 0 then
		ReduceIce(k, ay)
		ReducePoison(k, ay)
		ReduceInjury(k, ay)
	end
	if az and az > 0 then
		ReduceIce(k, math.ceil(GetIce(k) * az * 0.01))
		ReducePoison(k, math.ceil(GetPoison(k) * az * 0.01))
		ReduceInjury(k, math.ceil(GetInjury(k) * az * 0.01))
	end
end
function PurgeDebuff(k)
	ReduceIce(k, GetIce(k))
	ReducePoison(k, GetPoison(k))
	ReduceInjury(k, GetInjury(k))
	k:RemoveModifierByName("modifier_silence_custom")
end
function AddFury(k, l, am, an)
	if not IsValid(k) then
		return
	end
	local ao = GetIgnoreFuryPercent(k)
	if ao > 0 and PRD(k, ao, "common_ignore_fury") then
		return
	end
	local q = k:FindAbilityByName("sect_fury")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_fury")
	end
	if HasState(k, EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM) then
		l = 0
	else
		l = math.floor(
			l * (
					1
					+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE)
						* 0.01
				)
		)
		l = l + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS)
		l = math.max(0, l)
	end
	local aA = GetModifierProperty(
		k,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
		{ type = "fury", count = l }
	)
	l = math.floor(l * (1 - aA * 0.01))
	l = math.max(0, l)
	l = math.floor(
		l
			* (
				1
				+ GetModifierProperty(
						k,
						EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE_BEFORE_EVENT,
						{ count = l }
					)
					* 0.01
			)
	)
	l = math.max(0, l)
	local ap = l
	local m = k:FindModifierByName("modifier_ice_custom")
	if IsValid(m) then
		local aq = m:GetStackCount()
		local r = m:GetCaster()
		local as = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_FURY_AGAINST_PERCENTAGE) * 0.01
		local ar = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_FURY_AGAINST_PERCENTAGE) * 0.01
		local au = Round(l * as)
		local at = Round(aq * ar)
		local av = au - at
		local aw = { iCount = 0 }
		if av >= 0 then
			aw.iCount = aq
			l = Round(av / as)
			m:Destroy()
		else
			local ax = Round(-av / ar)
			aw.iCount = aq - ax
			if ax > 0 then
				m:SetStackCount(ax)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS, aw, r, k)
	end
	if l > 0 then
		k:AddNewModifier(k, q, "modifier_fury_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, k, "fury", ap, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED,
		{ iStackCount = ap, origin = am, type = an },
		k,
		nil
	)
end
function GetFury(j)
	local n = 0
	if j:HasModifier("modifier_fury_custom") then
		n = n + j:FindModifierByName("modifier_fury_custom"):GetStackCount()
	end
	if j:HasModifier("modifier_fury_permanent") then
		n = n + j:FindModifierByName("modifier_fury_permanent"):GetStackCount()
	end
	return n
end
function ReduceFury(k, l)
	l = math.floor(l)
	if k:HasModifier("modifier_fury_custom") then
		local m = k:FindModifierByName("modifier_fury_custom")
		if IsValid(m) then
			if m:GetStackCount() >= l then
				FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS, { iCount = l }, m:GetCaster(), k)
				m:DecrementStackCount(l)
				return l
			else
				FireModifierEvent(
					EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS,
					{ iCount = m:GetStackCount() },
					m:GetCaster(),
					k
				)
				m:Destroy()
				return m:GetStackCount()
			end
		end
	end
	return 0
end
function AddPoison(k, r, l, am, an, aB)
	if not IsValid(r) or l <= 0 then
		return
	end
	local ao = GetIgnorePoisonPercent(r)
	if ao > 0 and PRD(r, ao, "common_ignore_poison") then
		return
	end
	local q = k:FindAbilityByName("sect_poison")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_poison")
	end
	if aB == nil or bit.band(aB, PoisonFlags.POISON_FLAG_IGNORE_ADJUST) ~= PoisonFlags.POISON_FLAG_IGNORE_ADJUST then
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS_PERCENTAGE,
							{ count = l, ability = am, flag = aB }
						)
						* 0.01
				)
		)
		l = l
			+ GetModifierProperty(
				k,
				EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS,
				{ count = l, ability = am, flag = aB }
			)
	end
	l = math.max(0, l)
	r:AddNewModifier(k, q, "modifier_poison_custom", { iStackCount = l })
	CombatLog:recordBuff(k, r, "poison", l, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED,
		{ iStackCount = l, origin = am, type = an, flag = aB },
		k,
		r
	)
end
function TriggerPoison(r, aC, I, aD)
	if aD == nil then
		aD = false
	end
	if r:HasModifier("modifier_poison_custom") then
		local m = r:FindModifierByName("modifier_poison_custom")
		if IsValid(m) then
			m:OnIntervalThink(aC, I, aD)
		end
	end
end
function AddInjury(k, r, l, am, an)
	if not IsValid(r) then
		return
	end
	local ao = GetIgnoreInjuryPercent(r)
	if ao > 0 and PRD(r, ao, "common_ignore_injury") then
		return
	end
	local q = k:FindAbilityByName("sect_injury")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_injury")
	end
	l = math.max(l, GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_LIMIT_MIN))
	l = math.floor(
		l * (1 + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE) * 0.01)
	)
	l = l + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS)
	l = math.max(0, l)
	local ap = l
	l = math.floor(
		l
			* (
				1
				+ GetModifierProperty(
						k,
						EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE_AFTER_EVENT
					)
					* 0.01
			)
	)
	local m = r:FindModifierByName("modifier_shield_custom")
	if IsValid(m) then
		local aq = m:GetStackCount()
		local aE = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aF = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aG = Round(l * aE)
		local aH = Round(aq * aF)
		local av = aG - aH
		local aw = { iCount = 0 }
		if av >= 0 then
			aw.iCount = aq
			l = Round(av / aE)
			m:Destroy()
		else
			local ax = Round(-av / aF)
			aw.iCount = aq - ax
			if ax > 0 then
				m:SetStackCount(ax)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS, aw, r, k)
	end
	if l > 0 then
		r:AddNewModifier(k, q, "modifier_injury_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, r, "injury", ap, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED,
		{ iStackCount = ap, origin = am, type = an },
		k,
		r
	)
end
function AddScar(k, r, I, l, aI)
	if not IsValid(r) then
		return
	end
	if aI == nil then
		aI = I:GetAbilityName()
	end
	r:AddNewModifier(k, I, "modifier_scar_custom", { stack = l, abilityName = aI })
	FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_TAKE_SCAR, { stack = l, target = r, caster = k }, r, k)
	CombatLog:recordBuff(k, r, "scar", l, aI, "Sect")
end
function GetScar(j)
	local n = 0
	if j:HasModifier("modifier_scar_custom") then
		n = n + j:FindModifierByName("modifier_scar_custom"):GetStackCount()
	end
	return n
end
function AddStrongShield(k, aJ)
	if aJ > 0 then
		local q = k:FindAbilityByName("sect_shield")
		if not IsValid(q) then
			q = k:AddAbility_Engine("sect_shield")
		end
		k:AddNewModifier(k, q, "modifier_shield_strong", { duration = aJ })
	end
end
function AddShield(k, l, am, an, aB)
	if aB == nil then
		aB = ShieldFlags.FLAG_NONE
	end
	if l <= 0 then
		return
	end
	local ao = GetIgnoreShieldPercentage(k)
	if ao > 0 and PRD(k, ao, "common_ignore_shield") then
		return
	end
	local aK = l
	local aL = bit.band(aB, ShieldFlags.FLAG_IGNORE_BONUS) == ShieldFlags.FLAG_IGNORE_BONUS
	local q = k:FindAbilityByName("sect_shield")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_shield")
	end
	if HasState(k, EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM) then
		l = 0
	else
		if not aL then
			l = math.floor(l * (1 + GetShieldBonusPct(k) * 0.01))
			l = l + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS)
			l = math.max(0, l)
		end
	end
	if not aL then
		local aA = GetModifierProperty(
			k,
			EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
			{ type = "shield", count = l, flag = aB }
		)
		l = math.floor(l * (1 - aA * 0.01))
		l = math.max(0, l)
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE_BEFORE_EVENT,
							{ flag = aB, count = l, original_count = aK }
						)
						* 0.01
				)
		)
	end
	l = math.max(0, l)
	local ap = l
	if not aL then
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE_AFTER_EVENT,
							{ flag = aB, count = ap, original_count = aK }
						)
						* 0.01
				)
		)
	end
	l = math.max(0, l)
	local m = k:FindModifierByName("modifier_injury_custom")
	if IsValid(m) then
		local r = m:GetCaster()
		local aq = m:GetStackCount()
		local aF = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aE = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aH = Round(l * aF)
		local aG = Round(aq * aE)
		local av = aH - aG
		local aw = { iCount = 0 }
		if av >= 0 then
			aw.iCount = aq
			l = Round(av / aF)
			m:Destroy()
		else
			local aM = Round(-av / aE)
			aw.iCount = aq - aM
			if aM > 0 then
				m:SetStackCount(aM)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS, aw, r, k)
	end
	if l > 0 then
		k:AddNewModifier(k, q, "modifier_shield_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, k, "shield", ap, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED,
		{ iStackCount = ap, origin = am, type = an, flag = aB },
		k,
		nil
	)
end
function GetShield(j)
	local n = 0
	if j:HasModifier("modifier_shield_custom") then
		n = n + j:FindModifierByName("modifier_shield_custom"):GetStackCount()
	end
	if j:HasModifier("modifier_shield_permanent") then
		n = n + j:FindModifierByName("modifier_shield_permanent"):GetStackCount()
	end
	return n
end
function ReduceShield(k, l)
	l = math.floor(l)
	if k:HasModifier("modifier_shield_custom") then
		local m = k:FindModifierByName("modifier_shield_custom")
		if IsValid(m) then
			l = math.ceil(
				l
					* (
						1
						+ GetModifierProperty(
								k,
								EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_ATTENUATION_PERCENTAGE
							)
							* 0.01
					)
			)
			if m:GetStackCount() >= l then
				m:DecrementStackCount(l)
				return l
			else
				m:Destroy()
				return m:GetStackCount()
			end
		end
	end
	return 0
end
function Heal(k, l, am, an, aN, aB)
	if aN == nil then
		aN = true
	end
	if aB == nil then
		aB = HealFlags.HEAL_FLAG_NONE
	end
	if bit.band(aB, HealFlags.HEAL_FLAG_IGNORE_DISTURB) ~= HealFlags.HEAL_FLAG_IGNORE_DISTURB then
		local ao = GetIgnoreHealPercentage(k)
		if ao > 0 and PRD(k, ao, "common_ignore_heal") then
			return
		end
	end
	local aO = l
	if bit.band(aB, HealFlags.HEAL_FLAG_IGNORE_ADJUST) ~= HealFlags.HEAL_FLAG_IGNORE_ADJUST then
		if HasState(k, EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM) then
			aO = 0
		else
			aO = math.floor(
				math.max(
					0,
					(aO + GetHealBonus(k)) * (1 + GetHealAmplify(k) * 0.01) * (1 - GetHPLossPercentage(k) * 0.01)
				)
			)
		end
		local aA = GetModifierProperty(
			k,
			EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
			{ type = "heal", count = aO, flag = aB }
		)
		aO = math.floor(aO * (1 - aA * 0.01))
	end
	aO = math.max(0, aO)
	local q = k:FindAbilityByName("sect_regen")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_regen")
	end
	local aP = k:GetHealth()
	local aQ = not CosmeticPreviewLive:IsPreviewLiveUnit(k)
	k:Heal(aO, q, aQ)
	local aR = k:GetHealth()
	PlayerData:addDetailData(k, an, "regen", aO, false, am)
	if aN then
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_HEAL,
			{ origin_health = aP, current_health = aR, flHealAmount = aO, target = k, origin = am, type = an, flag = aB },
			k,
			nil
		)
	end
	if aQ then
		if aB == HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL then
			local aS = ParticleManager:CreateParticle(
				"particles/items3_fx/octarine_core_lifesteal.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				k
			)
			ParticleManager:ReleaseParticleIndex(aS)
		else
			local aS = ParticleManager:CreateParticle(
				"particles/generic_gameplay/generic_lifesteal.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				k
			)
			ParticleManager:ReleaseParticleIndex(aS)
		end
		CombatLog:recordHeal(k, aO, aP, aR, am, an)
	end
end
function Restore(k, l, aT, aU)
	if aT == nil then
		aT = true
	end
	if aU == nil then
		aU = false
	end
	if IsCustomHeroMana(k) and k:GetUnitName() ~= "antimage" then
		return
	end
	if k:GetUnitName() == "antimage" and not aT then
		return
	end
	local aV = GetManaLossPercentage(k)
	l = math.max(l * (1 - aV * 0.01), 0)
	local aW = GetManaGainBonusPercentage(k)
	if aT then
		l = math.max(l * (1 + aW * 0.01), 0)
	end
	local aX = k:GetMana()
	if k:GetUnitName() ~= "antimage" then
		k:GiveMana(l)
	end
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE,
		{ count = l, original_mana = aX, current_mana = k:GetMana(), ignore_event = aU },
		k,
		nil
	)
	if aT then
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, k, l, k:GetPlayerOwner())
	end
end
function StealMana(aY, G, ac)
	if not IsCustomHeroMana(G) then
		G:SetMana(math.max(0, G:GetMana() - ac))
	end
	Restore(aY, ac)
end
function ReduceMana(k, l, q, aT)
	if aT == nil then
		aT = true
	end
	if IsCustomHeroMana(k) then
		return
	end
	l = math.max(l, 0)
	k:Script_ReduceMana(l, q)
	if aT then
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_LOSS, k, l, k:GetPlayerOwner())
	end
end
function RestoreCustomMana(k, l, aU)
	if aU == nil then
		aU = false
	end
	l = math.max(0, l)
	local aX = k:GetMana()
	k:GiveMana(l)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE,
		{ count = l, original_mana = aX, current_mana = k:GetMana(), ignore_event = aU },
		k,
		nil
	)
end
function ReduceCustomMana(k, l, q)
	l = math.max(0, l)
	k:Script_ReduceMana(l, q)
end
function EachWisp(k, a8)
	if k:HasModifier("modifier_sect_wisp") then
		local m = k:FindModifierByName("modifier_sect_wisp")
		if IsValid(m) then
			local aZ = m:GetWispList()
			for a_, b0 in ipairs(aZ) do
				local b1 = b0.wisp
				if IsInjurable(b1) then
					if a8(b1) then
						break
					end
				end
			end
		end
	end
end
function GetWispCount(k)
	if k:HasModifier("modifier_sect_wisp") then
		local m = k:FindModifierByName("modifier_sect_wisp")
		if IsValid(m) then
			return m:GetStackCount()
		end
	end
	return 0
end
function HealWisp(k, I, aO)
	local a_ = 0
	EachWisp(k, function(b2)
		a_ = a_ + 1
		local b3 = b2:GetMaxHealth()
		local b4 = math.min(b2:GetHealth() + aO, b3)
		b2:ModifyHealth(b4, I, false, 0)
	end)
	if a_ > 0 then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL, { healAmount = aO, ability = I }, k)
	end
end
function HealSingleWisp(k, b5, I, aO, b6)
	if IsValid(b5) then
		local b3 = b5:GetMaxHealth()
		local b4 = math.min(b5:GetHealth() + aO, b3)
		b5:ModifyHealth(b4, I, false, 0)
		if not b6 then
			FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL, { healAmount = aO, ability = I }, k)
		end
	end
end
function WispAttack(k)
	if k:HasModifier("modifier_sect_wisp") then
		local m = k:FindModifierByName("modifier_sect_wisp")
		if IsValid(m) then
			if m ~= nil then
				m:OnWispAttackStart()
			end
		end
	end
end
function TriggerAllWisp(k)
	local m = k:FindModifierByName("modifier_sect_wisp")
	if IsValid(m) then
		m:doIntervalAction()
	end
end
function GetWispHealth(k, D)
	local b7
	if D ~= nil then
		b7 = D.bear
	end
	if not b7 and PlayerData:getHero(k:GetPlayerOwnerID()):getSectAbilityExp("sect_wisp") == 0 then
		return 0
	end
	return (WISP_HEALTH_BASE + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS, D))
		* (100 + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE, D))
		/ 100
end
function calculateDamageShare(D)
	if D.target:HasModifier("modifier_sect_wisp") then
		local b8 = D.target:FindModifierByName("modifier_sect_wisp")
		if IsValid(b8) then
			return b8:ShareDamage(D)
		end
	end
	return 0
end
function SummonWisp(k, b9, ba, a8)
	local m = k:FindModifierByName("modifier_sect_wisp")
	if IsValid(m) then
		return m:SummonWisp(b9, ba, false, a8)
	end
end
function KillWisp(aY, b1, bb, bc)
	if bb == nil then
		bb = true
	end
	if bc == nil then
		bc = true
	end
	if IsValid(aY) and IsInjurable(b1) then
		local m = aY:FindModifierByName("modifier_sect_wisp")
		if IsValid(m) then
			m:KillWisp(b1, bb, bc)
		end
	end
end
function AddChaos(k, l, am, an, bd)
	if bd == nil then
		bd = false
	end
	if not IsValid(k) then
		return
	end
	local ao = GetIgnoreChaosPercent(k)
	if ao > 0 and PRD(k, ao, "common_ignore_chaos") then
		return
	end
	local q = k:FindAbilityByName("sect_chaos")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_chaos")
	end
	if not bd then
		l = math.floor(
			l * (
					1
					+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_STACK_BONUS_PERCENTAGE)
						* 0.01
				)
		)
		l = l + GetChaosBonus(k)
	end
	local aA = GetModifierProperty(
		k,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
		{ type = "chaos", count = l }
	)
	l = math.floor(l * (1 - aA * 0.01))
	l = math.max(0, l)
	if l > 0 then
		k:AddNewModifier(k, q, "modifier_chaos_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, k, "chaos", l, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED,
		{ iStackCount = l, origin = am, type = an },
		k,
		nil
	)
end
function ReduceChaos(k, l)
	l = math.floor(l)
	if k:HasModifier("modifier_chaos_custom") then
		local m = k:FindModifierByName("modifier_chaos_custom")
		if IsValid(m) then
			if m:GetStackCount() >= l then
				m:DecrementStackCount(l)
				return l
			else
				m:Destroy()
				return m:GetStackCount()
			end
		end
	end
	return 0
end
function GetChaos(j, be)
	local n = 0
	if j:HasModifier("modifier_chaos_custom") then
		n = n + j:FindModifierByName("modifier_chaos_custom"):GetStackCount()
	end
	if not be and j:HasModifier("modifier_chaos_permanent") then
		n = n + j:FindModifierByName("modifier_chaos_permanent"):GetStackCount()
	end
	return n
end
function tryCastAbility(aY)
	if aY:GetMana() < aY:GetMaxMana() then
		return false
	end
	local I = aY:GetAbilityByIndex(1)
	local bf = aY:GetEnemy()
	if not IsValid(I) then
		return false
	end
	if not IsInjurable(aY, bf) then
		return false
	end
	if aY:IsSilenced() then
		return false
	end
	if aY:IsStunned() then
		return false
	end
	if IsCustomHeroUlt(aY) then
		return false
	end
	local aI = "default"
	if I:GetName() then
		aI = I:GetName()
	end
	I:UseResources(true, false, false, false)
	I:OnSpellStart()
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		{ ability = I, unit = aY, target = bf },
		aY,
		bf
	)
	return true
end
function IsLock(a1)
	if IsValid(a1) then
		a1:HasModifier("modifier_lock_custom")
	end
	return false
end
function IsBlind(a1)
	if IsValid(a1) then
		return a1:HasModifier("modifier_blind_custom")
	end
	return false
end
function AddStateImmunity(k, r, I, aJ, bg)
	r:AddNewModifier(k, I, "modifier_state_immunity_custom", { duration = aJ, HideParticle = bg })
end
function AddStun(k, r, I, aJ)
	local b8 = r:FindModifierByName("modifier_stun_custom")
	local bh =
		math.max(0, 1 - GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE) * 0.01)
	aJ = aJ * bh
	FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_STUN, { duration = aJ }, k, r)
	if IsValid(b8) then
		local bi = b8:GetRemainingTime()
		if aJ > bi then
			r:AddNewModifier(k, I, "modifier_stun_custom", { duration = aJ })
		end
	else
		r:AddNewModifier(k, I, "modifier_stun_custom", { duration = aJ })
	end
end
function AddSilence(k, r, I, aJ)
	CombatLog:recordState(r, k, "Silence", "add")
	local bh =
		math.max(0, 1 - GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE) * 0.01)
	aJ = aJ * bh
	r:AddNewModifier(k, I, "modifier_silence_custom", { duration = aJ })
end
function AddDisarm(k, r, I, aJ)
	CombatLog:recordState(r, k, "Disarm", "add")
	local bh =
		math.max(0, 1 - GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE) * 0.01)
	aJ = aJ * bh
	r:AddNewModifier(k, I, "modifier_disarm_custom", { duration = aJ })
end
function AddPoisonDeepen(k, r, I, n, aJ)
	r:AddNewModifier(k, I, "modifier_poison_deepen_server", { iStackCount = n, duration = aJ })
end
function AddBroken(k, r, I, aJ)
	r:AddNewModifier(k, I, "modifier_broken_custom", { duration = aJ })
end
function DealDamageToWisp(k, r, q, x, bj, a8)
	if k:HasModifier("modifier_sect_wisp") then
		local m = r:FindModifierByName("modifier_sect_wisp")
		if IsValid(m) then
			local aP = r:GetHealth()
			m:DealDamageToEachWisp(
				x,
				{
					attacker = k,
					target = r,
					ability = q,
					damage = x,
					damage_type = bj or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
					damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
					original_damage = 0,
					original_health = aP,
					crit_damage = 0,
					outgoing_damage = 0,
					incoming_damage = 0,
					adjust_damage = 0,
					share_damage = 0,
				},
				a8
			)
		end
	end
end
function SetCustomManaState(a1, bk)
	if IsValid(a1) then
		if bk then
			a1:AddNewModifier(a1, a1:GetDummyAbility(), "modifier_custom_mana", nil)
		else
			a1:RemoveModifierByName("modifier_custom_mana")
		end
	end
end
function SetCustomUltState(a1, bk)
	if IsValid(a1) then
		if bk then
			a1:AddNewModifier(a1, a1:GetDummyAbility(), "modifier_custom_ult", nil)
		else
			a1:RemoveModifierByName("modifier_custom_ult")
		end
	end
end
function InheritSectAttackAbility(aY, G)
	if IsInjurable(aY, G) then
		if aY:HasModifier("modifier_sect_attack") then
			local E = aY:FindModifierByName("modifier_sect_attack")
			if IsValid(E) then
				E:SetInheritUnit(G)
			end
		end
	end
end
function TriggerSectAbilityByName(aY, bl)
	local U = KeyValues.AbilityUpgradesKvs[bl]
	if U == nil then
		return
	end
	if U.Triggerable == nil then
		return
	end
	local bm = U.script_ability
	if bm == nil then
		return
	end
	if not IsValid(aY) then
		return
	end
	local I = aY:FindAbilityByName(bm)
	if IsValid(I) then
		if I ~= nil then
			I:TriggerByName(bl)
		end
	end
end