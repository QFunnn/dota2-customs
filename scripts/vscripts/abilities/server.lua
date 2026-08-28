--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["11"] = 735,
		["12"] = 736,
		["13"] = 737,
		["15"] = 739,
		["17"] = 735,
		["19"] = 743,
		["20"] = 744,
		["21"] = 745,
		["22"] = 746,
		["23"] = 747,
		["24"] = 748,
		["25"] = 749,
		["26"] = 749,
		["27"] = 749,
		["28"] = 749,
		["29"] = 749,
		["30"] = 749,
		["31"] = 750,
		["32"] = 751,
		["34"] = 753,
		["35"] = 753,
		["36"] = 753,
		["37"] = 753,
		["38"] = 753,
		["39"] = 753,
		["40"] = 754,
		["41"] = 755,
		["45"] = 759,
		["46"] = 743,
		["47"] = 834,
		["48"] = 835,
		["49"] = 836,
		["50"] = 837,
		["51"] = 838,
		["52"] = 839,
		["53"] = 840,
		["54"] = 840,
		["55"] = 840,
		["56"] = 840,
		["57"] = 840,
		["58"] = 840,
		["59"] = 841,
		["60"] = 842,
		["62"] = 844,
		["63"] = 844,
		["64"] = 844,
		["65"] = 844,
		["66"] = 844,
		["67"] = 844,
		["68"] = 845,
		["69"] = 846,
		["73"] = 850,
		["74"] = 834,
		["76"] = 854,
		["77"] = 855,
		["78"] = 856,
		["79"] = 857,
		["81"] = 859,
		["82"] = 860,
		["84"] = 862,
		["85"] = 854,
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
		["535"] = 499,
		["536"] = 500,
		["537"] = 501,
		["538"] = 502,
		["539"] = 503,
		["540"] = 504,
		["541"] = 505,
		["542"] = 507,
		["543"] = 508,
		["544"] = 509,
		["545"] = 510,
		["546"] = 512,
		["547"] = 513,
		["548"] = 514,
		["549"] = 515,
		["551"] = 517,
		["552"] = 518,
		["553"] = 519,
		["554"] = 520,
		["556"] = 522,
		["558"] = 524,
		["560"] = 526,
		["562"] = 528,
		["563"] = 529,
		["565"] = 532,
		["566"] = 532,
		["567"] = 532,
		["568"] = 532,
		["569"] = 532,
		["570"] = 532,
		["571"] = 532,
		["572"] = 532,
		["573"] = 533,
		["574"] = 483,
		["575"] = 535,
		["576"] = 536,
		["577"] = 537,
		["578"] = 538,
		["580"] = 540,
		["581"] = 541,
		["583"] = 543,
		["584"] = 535,
		["585"] = 545,
		["586"] = 546,
		["587"] = 547,
		["588"] = 548,
		["589"] = 549,
		["590"] = 550,
		["591"] = 551,
		["592"] = 551,
		["593"] = 551,
		["594"] = 551,
		["595"] = 551,
		["596"] = 551,
		["597"] = 552,
		["598"] = 553,
		["600"] = 555,
		["601"] = 555,
		["602"] = 555,
		["603"] = 555,
		["604"] = 555,
		["605"] = 555,
		["606"] = 556,
		["607"] = 557,
		["611"] = 561,
		["612"] = 545,
		["614"] = 566,
		["615"] = 567,
		["616"] = 568,
		["617"] = 569,
		["618"] = 570,
		["620"] = 572,
		["621"] = 573,
		["622"] = 573,
		["623"] = 573,
		["624"] = 573,
		["625"] = 574,
		["626"] = 574,
		["627"] = 574,
		["628"] = 574,
		["629"] = 575,
		["630"] = 575,
		["631"] = 575,
		["632"] = 575,
		["634"] = 566,
		["636"] = 581,
		["637"] = 582,
		["638"] = 582,
		["639"] = 582,
		["640"] = 582,
		["641"] = 583,
		["642"] = 583,
		["643"] = 583,
		["644"] = 583,
		["645"] = 584,
		["646"] = 584,
		["647"] = 584,
		["648"] = 584,
		["649"] = 585,
		["650"] = 581,
		["655"] = 598,
		["656"] = 599,
		["659"] = 601,
		["660"] = 602,
		["663"] = 605,
		["664"] = 606,
		["665"] = 607,
		["667"] = 609,
		["668"] = 610,
		["670"] = 612,
		["671"] = 613,
		["672"] = 614,
		["674"] = 616,
		["675"] = 620,
		["676"] = 621,
		["677"] = 622,
		["678"] = 625,
		["679"] = 626,
		["680"] = 627,
		["681"] = 628,
		["682"] = 629,
		["683"] = 630,
		["684"] = 631,
		["685"] = 632,
		["686"] = 634,
		["687"] = 635,
		["688"] = 636,
		["689"] = 637,
		["690"] = 639,
		["691"] = 640,
		["692"] = 641,
		["693"] = 642,
		["695"] = 644,
		["696"] = 645,
		["697"] = 646,
		["698"] = 647,
		["700"] = 649,
		["702"] = 651,
		["704"] = 653,
		["706"] = 655,
		["707"] = 656,
		["709"] = 659,
		["710"] = 659,
		["711"] = 659,
		["712"] = 659,
		["713"] = 659,
		["714"] = 659,
		["715"] = 659,
		["716"] = 659,
		["717"] = 660,
		["718"] = 598,
		["719"] = 662,
		["720"] = 663,
		["721"] = 664,
		["722"] = 665,
		["724"] = 667,
		["725"] = 668,
		["727"] = 670,
		["728"] = 662,
		["729"] = 672,
		["730"] = 673,
		["731"] = 674,
		["732"] = 675,
		["733"] = 676,
		["734"] = 677,
		["735"] = 678,
		["736"] = 678,
		["737"] = 678,
		["738"] = 678,
		["739"] = 678,
		["740"] = 678,
		["741"] = 679,
		["742"] = 680,
		["744"] = 682,
		["745"] = 682,
		["746"] = 682,
		["747"] = 682,
		["748"] = 682,
		["749"] = 682,
		["750"] = 683,
		["751"] = 684,
		["755"] = 688,
		["756"] = 672,
		["762"] = 697,
		["763"] = 699,
		["766"] = 701,
		["767"] = 702,
		["770"] = 705,
		["771"] = 706,
		["772"] = 707,
		["774"] = 709,
		["775"] = 710,
		["776"] = 715,
		["778"] = 721,
		["779"] = 722,
		["780"] = 726,
		["781"] = 726,
		["782"] = 726,
		["783"] = 726,
		["784"] = 726,
		["785"] = 726,
		["786"] = 726,
		["787"] = 726,
		["788"] = 727,
		["789"] = 697,
		["791"] = 762,
		["792"] = 762,
		["793"] = 762,
		["795"] = 763,
		["796"] = 764,
		["797"] = 765,
		["798"] = 767,
		["801"] = 762,
		["807"] = 779,
		["808"] = 780,
		["811"] = 782,
		["812"] = 783,
		["815"] = 786,
		["816"] = 787,
		["817"] = 788,
		["819"] = 790,
		["820"] = 791,
		["821"] = 791,
		["822"] = 791,
		["823"] = 791,
		["824"] = 792,
		["825"] = 793,
		["827"] = 795,
		["828"] = 796,
		["829"] = 797,
		["830"] = 798,
		["832"] = 800,
		["833"] = 801,
		["834"] = 802,
		["835"] = 803,
		["836"] = 804,
		["837"] = 806,
		["838"] = 807,
		["839"] = 808,
		["840"] = 809,
		["841"] = 811,
		["842"] = 812,
		["843"] = 813,
		["844"] = 814,
		["846"] = 816,
		["847"] = 817,
		["848"] = 818,
		["849"] = 819,
		["851"] = 821,
		["853"] = 823,
		["855"] = 825,
		["857"] = 827,
		["858"] = 828,
		["860"] = 831,
		["861"] = 831,
		["862"] = 831,
		["863"] = 831,
		["864"] = 831,
		["865"] = 831,
		["866"] = 831,
		["867"] = 831,
		["868"] = 832,
		["869"] = 779,
		["870"] = 864,
		["871"] = 865,
		["874"] = 866,
		["875"] = 867,
		["877"] = 869,
		["878"] = 870,
		["879"] = 871,
		["880"] = 871,
		["881"] = 871,
		["882"] = 871,
		["883"] = 871,
		["884"] = 871,
		["885"] = 871,
		["886"] = 871,
		["887"] = 864,
		["890"] = 874,
		["891"] = 875,
		["892"] = 876,
		["893"] = 877,
		["895"] = 879,
		["896"] = 874,
		["901"] = 887,
		["902"] = 888,
		["903"] = 889,
		["904"] = 890,
		["905"] = 891,
		["907"] = 893,
		["909"] = 887,
		["916"] = 906,
		["917"] = 906,
		["918"] = 906,
		["920"] = 907,
		["923"] = 911,
		["924"] = 912,
		["927"] = 915,
		["928"] = 916,
		["929"] = 917,
		["930"] = 918,
		["931"] = 919,
		["933"] = 921,
		["934"] = 922,
		["936"] = 924,
		["937"] = 925,
		["938"] = 926,
		["939"] = 927,
		["942"] = 930,
		["943"] = 931,
		["944"] = 936,
		["945"] = 937,
		["946"] = 938,
		["948"] = 944,
		["949"] = 945,
		["950"] = 946,
		["951"] = 947,
		["953"] = 953,
		["954"] = 954,
		["955"] = 955,
		["956"] = 956,
		["957"] = 957,
		["958"] = 959,
		["959"] = 960,
		["960"] = 962,
		["961"] = 963,
		["962"] = 965,
		["963"] = 966,
		["964"] = 967,
		["965"] = 968,
		["966"] = 969,
		["967"] = 970,
		["969"] = 973,
		["970"] = 974,
		["971"] = 975,
		["972"] = 976,
		["974"] = 978,
		["976"] = 980,
		["978"] = 982,
		["980"] = 984,
		["981"] = 985,
		["983"] = 988,
		["984"] = 988,
		["985"] = 988,
		["986"] = 988,
		["987"] = 988,
		["988"] = 988,
		["989"] = 988,
		["990"] = 988,
		["991"] = 989,
		["992"] = 906,
		["993"] = 996,
		["994"] = 997,
		["995"] = 998,
		["996"] = 999,
		["998"] = 1001,
		["999"] = 1002,
		["1001"] = 1004,
		["1002"] = 996,
		["1003"] = 1006,
		["1004"] = 1007,
		["1005"] = 1008,
		["1006"] = 1009,
		["1007"] = 1010,
		["1008"] = 1011,
		["1009"] = 1012,
		["1010"] = 1013,
		["1011"] = 1014,
		["1013"] = 1016,
		["1014"] = 1017,
		["1018"] = 1021,
		["1019"] = 1006,
		["1025"] = 1030,
		["1026"] = 1030,
		["1027"] = 1030,
		["1029"] = 1030,
		["1030"] = 1030,
		["1032"] = 1031,
		["1033"] = 1033,
		["1034"] = 1034,
		["1035"] = 1037,
		["1036"] = 1037,
		["1037"] = 1037,
		["1038"] = 1037,
		["1039"] = 1037,
		["1040"] = 1037,
		["1041"] = 1037,
		["1042"] = 1037,
		["1046"] = 1042,
		["1047"] = 1043,
		["1048"] = 1044,
		["1049"] = 1045,
		["1051"] = 1047,
		["1052"] = 1047,
		["1053"] = 1047,
		["1054"] = 1047,
		["1056"] = 1049,
		["1057"] = 1054,
		["1059"] = 1056,
		["1060"] = 1057,
		["1061"] = 1058,
		["1062"] = 1059,
		["1064"] = 1061,
		["1065"] = 1062,
		["1066"] = 1063,
		["1067"] = 1064,
		["1068"] = 1066,
		["1069"] = 1066,
		["1070"] = 1066,
		["1071"] = 1066,
		["1072"] = 1066,
		["1073"] = 1066,
		["1074"] = 1066,
		["1075"] = 1066,
		["1076"] = 1067,
		["1077"] = 1068,
		["1078"] = 1068,
		["1079"] = 1068,
		["1080"] = 1068,
		["1081"] = 1068,
		["1082"] = 1068,
		["1083"] = 1068,
		["1084"] = 1068,
		["1085"] = 1068,
		["1087"] = 1078,
		["1088"] = 1079,
		["1089"] = 1080,
		["1090"] = 1081,
		["1092"] = 1083,
		["1093"] = 1084,
		["1095"] = 1087,
		["1096"] = 1087,
		["1097"] = 1087,
		["1098"] = 1087,
		["1099"] = 1087,
		["1100"] = 1087,
		["1101"] = 1087,
		["1102"] = 1087,
		["1104"] = 1030,
		["1110"] = 1097,
		["1111"] = 1097,
		["1112"] = 1097,
		["1114"] = 1097,
		["1115"] = 1097,
		["1117"] = 1098,
		["1120"] = 1101,
		["1123"] = 1105,
		["1124"] = 1106,
		["1125"] = 1108,
		["1126"] = 1110,
		["1127"] = 1111,
		["1129"] = 1113,
		["1130"] = 1114,
		["1131"] = 1115,
		["1133"] = 1117,
		["1134"] = 1117,
		["1135"] = 1117,
		["1136"] = 1117,
		["1137"] = 1117,
		["1138"] = 1117,
		["1139"] = 1117,
		["1140"] = 1117,
		["1141"] = 1117,
		["1142"] = 1117,
		["1143"] = 1117,
		["1144"] = 1118,
		["1145"] = 1119,
		["1146"] = 1119,
		["1147"] = 1119,
		["1148"] = 1119,
		["1149"] = 1119,
		["1150"] = 1119,
		["1151"] = 1119,
		["1153"] = 1097,
		["1159"] = 1128,
		["1160"] = 1129,
		["1161"] = 1130,
		["1162"] = 1130,
		["1163"] = 1130,
		["1164"] = 1130,
		["1166"] = 1132,
		["1167"] = 1128,
		["1173"] = 1141,
		["1174"] = 1141,
		["1175"] = 1141,
		["1177"] = 1142,
		["1180"] = 1147,
		["1181"] = 1148,
		["1182"] = 1150,
		["1183"] = 1151,
		["1184"] = 1151,
		["1185"] = 1151,
		["1186"] = 1151,
		["1187"] = 1151,
		["1188"] = 1151,
		["1189"] = 1151,
		["1191"] = 1141,
		["1196"] = 1159,
		["1197"] = 1159,
		["1198"] = 1159,
		["1200"] = 1163,
		["1201"] = 1164,
		["1202"] = 1165,
		["1203"] = 1166,
		["1204"] = 1166,
		["1205"] = 1166,
		["1206"] = 1166,
		["1207"] = 1166,
		["1208"] = 1166,
		["1209"] = 1166,
		["1210"] = 1166,
		["1211"] = 1166,
		["1212"] = 1166,
		["1213"] = 1166,
		["1214"] = 1159,
		["1220"] = 1174,
		["1221"] = 1178,
		["1222"] = 1179,
		["1223"] = 1174,
		["1225"] = 1183,
		["1226"] = 1184,
		["1227"] = 1185,
		["1228"] = 1186,
		["1229"] = 1188,
		["1230"] = 1190,
		["1231"] = 1192,
		["1232"] = 1193,
		["1233"] = 1194,
		["1240"] = 1183,
		["1242"] = 1204,
		["1243"] = 1205,
		["1244"] = 1206,
		["1245"] = 1207,
		["1246"] = 1209,
		["1249"] = 1212,
		["1250"] = 1204,
		["1252"] = 1216,
		["1253"] = 1217,
		["1254"] = 1218,
		["1255"] = 1218,
		["1256"] = 1218,
		["1257"] = 1219,
		["1258"] = 1220,
		["1259"] = 1221,
		["1260"] = 1221,
		["1261"] = 1221,
		["1262"] = 1221,
		["1263"] = 1222,
		["1264"] = 1218,
		["1265"] = 1218,
		["1266"] = 1224,
		["1267"] = 1225,
		["1269"] = 1216,
		["1270"] = 1231,
		["1271"] = 1232,
		["1272"] = 1233,
		["1273"] = 1234,
		["1274"] = 1234,
		["1275"] = 1234,
		["1276"] = 1234,
		["1277"] = 1235,
		["1278"] = 1236,
		["1279"] = 1237,
		["1282"] = 1231,
		["1284"] = 1246,
		["1285"] = 1247,
		["1286"] = 1248,
		["1287"] = 1249,
		["1288"] = 1250,
		["1289"] = 1250,
		["1293"] = 1246,
		["1295"] = 1256,
		["1296"] = 1257,
		["1297"] = 1258,
		["1298"] = 1259,
		["1300"] = 1256,
		["1302"] = 1264,
		["1304"] = 1265,
		["1305"] = 1265,
		["1307"] = 1265,
		["1308"] = 1266,
		["1310"] = 1268,
		["1311"] = 1264,
		["1313"] = 1272,
		["1314"] = 1273,
		["1315"] = 1274,
		["1316"] = 1275,
		["1317"] = 1277,
		["1320"] = 1280,
		["1321"] = 1272,
		["1326"] = 1288,
		["1327"] = 1289,
		["1328"] = 1290,
		["1329"] = 1292,
		["1331"] = 1288,
		["1337"] = 1301,
		["1338"] = 1301,
		["1339"] = 1301,
		["1341"] = 1301,
		["1342"] = 1301,
		["1344"] = 1302,
		["1345"] = 1303,
		["1346"] = 1304,
		["1347"] = 1306,
		["1350"] = 1301,
		["1356"] = 1317,
		["1357"] = 1317,
		["1358"] = 1317,
		["1360"] = 1318,
		["1363"] = 1320,
		["1364"] = 1321,
		["1367"] = 1324,
		["1368"] = 1325,
		["1369"] = 1326,
		["1371"] = 1328,
		["1372"] = 1329,
		["1373"] = 1331,
		["1375"] = 1333,
		["1376"] = 1337,
		["1377"] = 1338,
		["1378"] = 1339,
		["1379"] = 1340,
		["1381"] = 1343,
		["1382"] = 1343,
		["1383"] = 1343,
		["1384"] = 1343,
		["1385"] = 1343,
		["1386"] = 1343,
		["1387"] = 1343,
		["1388"] = 1343,
		["1389"] = 1344,
		["1390"] = 1317,
		["1391"] = 1347,
		["1392"] = 1348,
		["1393"] = 1349,
		["1394"] = 1350,
		["1395"] = 1351,
		["1396"] = 1352,
		["1397"] = 1354,
		["1398"] = 1355,
		["1400"] = 1358,
		["1401"] = 1359,
		["1405"] = 1363,
		["1406"] = 1347,
		["1408"] = 1367,
		["1409"] = 1368,
		["1410"] = 1369,
		["1411"] = 1370,
		["1413"] = 1372,
		["1414"] = 1373,
		["1416"] = 1375,
		["1417"] = 1367,
		["1419"] = 1379,
		["1420"] = 1380,
		["1421"] = 1381,
		["1423"] = 1383,
		["1424"] = 1384,
		["1425"] = 1385,
		["1426"] = 1386,
		["1428"] = 1388,
		["1429"] = 1389,
		["1431"] = 1391,
		["1432"] = 1392,
		["1434"] = 1394,
		["1435"] = 1395,
		["1437"] = 1398,
		["1438"] = 1399,
		["1440"] = 1401,
		["1441"] = 1402,
		["1442"] = 1403,
		["1444"] = 1405,
		["1445"] = 1407,
		["1446"] = 1408,
		["1447"] = 1409,
		["1448"] = 1379,
		["1450"] = 1415,
		["1451"] = 1416,
		["1452"] = 1417,
		["1454"] = 1419,
		["1455"] = 1415,
		["1456"] = 1421,
		["1457"] = 1422,
		["1458"] = 1423,
		["1460"] = 1425,
		["1461"] = 1421,
		["1463"] = 1429,
		["1464"] = 1430,
		["1465"] = 1429,
		["1467"] = 1436,
		["1468"] = 1437,
		["1471"] = 1438,
		["1472"] = 1439,
		["1473"] = 1439,
		["1474"] = 1439,
		["1475"] = 1439,
		["1476"] = 1440,
		["1477"] = 1441,
		["1478"] = 1444,
		["1479"] = 1445,
		["1480"] = 1446,
		["1481"] = 1447,
		["1484"] = 1450,
		["1486"] = 1436,
		["1488"] = 1454,
		["1489"] = 1455,
		["1492"] = 1456,
		["1493"] = 1457,
		["1494"] = 1457,
		["1495"] = 1457,
		["1496"] = 1457,
		["1497"] = 1458,
		["1498"] = 1459,
		["1499"] = 1454,
		["1501"] = 1462,
		["1502"] = 1463,
		["1505"] = 1464,
		["1506"] = 1465,
		["1507"] = 1465,
		["1508"] = 1465,
		["1509"] = 1465,
		["1510"] = 1466,
		["1511"] = 1467,
		["1512"] = 1462,
		["1514"] = 1470,
		["1515"] = 1471,
		["1516"] = 1470,
		["1518"] = 1474,
		["1519"] = 1475,
		["1522"] = 1476,
		["1523"] = 1474,
		["1525"] = 1479,
		["1526"] = 1480,
		["1527"] = 1481,
		["1528"] = 1482,
		["1529"] = 1483,
		["1530"] = 1485,
		["1531"] = 1485,
		["1532"] = 1485,
		["1533"] = 1485,
		["1534"] = 1485,
		["1535"] = 1485,
		["1536"] = 1485,
		["1537"] = 1485,
		["1538"] = 1485,
		["1539"] = 1485,
		["1540"] = 1485,
		["1541"] = 1485,
		["1542"] = 1485,
		["1543"] = 1485,
		["1544"] = 1485,
		["1545"] = 1485,
		["1548"] = 1479,
		["1549"] = 1505,
		["1550"] = 1506,
		["1551"] = 1507,
		["1552"] = 1508,
		["1553"] = 1508,
		["1554"] = 1508,
		["1555"] = 1508,
		["1556"] = 1508,
		["1557"] = 1508,
		["1559"] = 1510,
		["1562"] = 1505,
		["1563"] = 1515,
		["1564"] = 1516,
		["1565"] = 1517,
		["1566"] = 1518,
		["1567"] = 1518,
		["1568"] = 1518,
		["1569"] = 1518,
		["1570"] = 1518,
		["1571"] = 1518,
		["1573"] = 1520,
		["1576"] = 1515,
		["1577"] = 1527,
		["1578"] = 1528,
		["1579"] = 1529,
		["1580"] = 1530,
		["1581"] = 1531,
		["1582"] = 1533,
		["1586"] = 1527,
		["1587"] = 1540,
		["1588"] = 1541,
		["1589"] = 1542,
		["1592"] = 1545,
		["1595"] = 1548,
		["1596"] = 1549,
		["1599"] = 1552,
		["1602"] = 1555,
		["1603"] = 1556,
		["1604"] = 1558,
		["1605"] = 1558,
		["1608"] = 1540,
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
function AddIce(k, r, l, am, an, ao)
	if not IsValid(r) then
		return
	end
	local ap = GetIgnoreIcePercent(r)
	if ap > 0 and PRD(r, ap, "common_ignore_ice") then
		return
	end
	local q = k:FindAbilityByName("sect_ice")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_ice")
	end
	if ao == nil or bit.band(ao, IceFlags.ICE_FLAG_NO_EXTRA) ~= IceFlags.ICE_FLAG_NO_EXTRA then
		l = math.floor(
			l * (
					1
					+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS_PERCENTAGE)
						* 0.01
				)
		)
		l = l + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS)
	end
	l = math.max(0, l)
	local aq = l
	local m = r:FindModifierByName("modifier_fury_custom")
	if IsValid(m) then
		local ar = m:GetStackCount()
		local as = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local at = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local au = Round(l * as)
		local av = Round(ar * at)
		local aw = au - av
		local ax = { iCount = 0 }
		if aw >= 0 then
			ax.iCount = ar
			l = Round(aw / as)
			m:Destroy()
		else
			local ay = Round(-aw / at)
			ax.iCount = ar - ay
			if ay > 0 then
				m:SetStackCount(ay)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS, ax, r, k)
	end
	if l > 0 then
		r:AddNewModifier(k, q, "modifier_ice_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, r, "ice", aq, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED,
		{ iStackCount = aq, origin = am, type = an, flag = ao },
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
function ReduceDebuff(k, az, aA)
	if az and az > 0 then
		ReduceIce(k, az)
		ReducePoison(k, az)
		ReduceInjury(k, az)
	end
	if aA and aA > 0 then
		ReduceIce(k, math.ceil(GetIce(k) * aA * 0.01))
		ReducePoison(k, math.ceil(GetPoison(k) * aA * 0.01))
		ReduceInjury(k, math.ceil(GetInjury(k) * aA * 0.01))
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
	local ap = GetIgnoreFuryPercent(k)
	if ap > 0 and PRD(k, ap, "common_ignore_fury") then
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
	local aB = GetModifierProperty(
		k,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
		{ type = "fury", count = l }
	)
	l = math.floor(l * (1 - aB * 0.01))
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
	local aq = l
	local m = k:FindModifierByName("modifier_ice_custom")
	if IsValid(m) then
		local ar = m:GetStackCount()
		local r = m:GetCaster()
		local at = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_FURY_AGAINST_PERCENTAGE) * 0.01
		local as = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_FURY_AGAINST_PERCENTAGE) * 0.01
		local av = Round(l * at)
		local au = Round(ar * as)
		local aw = av - au
		local ax = { iCount = 0 }
		if aw >= 0 then
			ax.iCount = ar
			l = Round(aw / at)
			m:Destroy()
		else
			local ay = Round(-aw / as)
			ax.iCount = ar - ay
			if ay > 0 then
				m:SetStackCount(ay)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ICE_LOSS, ax, r, k)
	end
	if l > 0 then
		k:AddNewModifier(k, q, "modifier_fury_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, k, "fury", aq, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED,
		{ iStackCount = aq, origin = am, type = an },
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
function AddPoison(k, r, l, am, an, ao)
	if not IsValid(r) or l <= 0 then
		return
	end
	local ap = GetIgnorePoisonPercent(r)
	if ap > 0 and PRD(r, ap, "common_ignore_poison") then
		return
	end
	local q = k:FindAbilityByName("sect_poison")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_poison")
	end
	if
		ao == nil
		or bit.band(ao, PoisonFlags.POISON_FLAG_IGNORE_ADJUST) ~= PoisonFlags.POISON_FLAG_IGNORE_ADJUST
			and bit.band(ao, PoisonFlags.POISON_FLAG_NO_EXTRA) ~= PoisonFlags.POISON_FLAG_NO_EXTRA
	then
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS_PERCENTAGE,
							{ count = l, ability = am, flag = ao }
						)
						* 0.01
				)
		)
		l = l
			+ GetModifierProperty(
				k,
				EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS,
				{ count = l, ability = am, flag = ao }
			)
	end
	l = math.max(0, l)
	r:AddNewModifier(k, q, "modifier_poison_custom", { iStackCount = l })
	CombatLog:recordBuff(k, r, "poison", l, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED,
		{ iStackCount = l, origin = am, type = an, flag = ao },
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
function AddInjury(k, r, l, am, an, ao)
	if not IsValid(r) then
		return
	end
	local ap = GetIgnoreInjuryPercent(r)
	if ap > 0 and PRD(r, ap, "common_ignore_injury") then
		return
	end
	local q = k:FindAbilityByName("sect_injury")
	if not IsValid(q) then
		q = k:AddAbility_Engine("sect_injury")
	end
	if ao == nil or bit.band(ao, InjuryFlags.INJURY_FLAG_NO_EXTRA) ~= InjuryFlags.INJURY_FLAG_NO_EXTRA then
		l = math.max(l, GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_LIMIT_MIN))
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE
						)
						* 0.01
				)
		)
		l = l + GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS)
	end
	l = math.max(0, l)
	local aq = l
	if ao == nil or bit.band(ao, InjuryFlags.INJURY_FLAG_NO_EXTRA) ~= InjuryFlags.INJURY_FLAG_NO_EXTRA then
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
	end
	local m = r:FindModifierByName("modifier_shield_custom")
	if IsValid(m) then
		local ar = m:GetStackCount()
		local aE = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aF = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aG = Round(l * aE)
		local aH = Round(ar * aF)
		local aw = aG - aH
		local ax = { iCount = 0 }
		if aw >= 0 then
			ax.iCount = ar
			l = Round(aw / aE)
			m:Destroy()
		else
			local ay = Round(-aw / aF)
			ax.iCount = ar - ay
			if ay > 0 then
				m:SetStackCount(ay)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_LOSS, ax, r, k)
	end
	if l > 0 then
		r:AddNewModifier(k, q, "modifier_injury_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, r, "injury", aq, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED,
		{ iStackCount = aq, origin = am, type = an, flag = ao },
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
function AddShield(k, l, am, an, ao)
	if ao == nil then
		ao = ShieldFlags.FLAG_NONE
	end
	if l <= 0 then
		return
	end
	local ap = GetIgnoreShieldPercentage(k)
	if ap > 0 and PRD(k, ap, "common_ignore_shield") then
		return
	end
	local aK = l
	local aL = bit.band(ao, ShieldFlags.FLAG_IGNORE_BONUS) == ShieldFlags.FLAG_IGNORE_BONUS
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
		local aB = GetModifierProperty(
			k,
			EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
			{ type = "shield", count = l, flag = ao }
		)
		l = math.floor(l * (1 - aB * 0.01))
		l = math.max(0, l)
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE_BEFORE_EVENT,
							{ flag = ao, count = l, original_count = aK }
						)
						* 0.01
				)
		)
	end
	l = math.max(0, l)
	local aq = l
	if not aL then
		l = math.floor(
			l
				* (
					1
					+ GetModifierProperty(
							k,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE_AFTER_EVENT,
							{ flag = ao, count = aq, original_count = aK }
						)
						* 0.01
				)
		)
	end
	l = math.max(0, l)
	local m = k:FindModifierByName("modifier_injury_custom")
	if IsValid(m) then
		local r = m:GetCaster()
		local ar = m:GetStackCount()
		local aF = 1
			+ GetModifierProperty(k, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aE = 1
			+ GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_SHIELD_AGAINST_PERCENTAGE)
				* 0.01
		local aH = Round(l * aF)
		local aG = Round(ar * aE)
		local aw = aH - aG
		local ax = { iCount = 0 }
		if aw >= 0 then
			ax.iCount = ar
			l = Round(aw / aF)
			m:Destroy()
		else
			local aM = Round(-aw / aE)
			ax.iCount = ar - aM
			if aM > 0 then
				m:SetStackCount(aM)
			else
				m:Destroy()
			end
			l = 0
		end
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_LOSS, ax, r, k)
	end
	if l > 0 then
		k:AddNewModifier(k, q, "modifier_shield_custom", { iStackCount = l })
	end
	CombatLog:recordBuff(k, k, "shield", aq, am, an)
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED,
		{ iStackCount = aq, origin = am, type = an, flag = ao },
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
function Heal(k, l, am, an, aN, ao)
	if aN == nil then
		aN = true
	end
	if ao == nil then
		ao = HealFlags.HEAL_FLAG_NONE
	end
	if bit.band(ao, HealFlags.HEAL_FLAG_IGNORE_DISTURB) ~= HealFlags.HEAL_FLAG_IGNORE_DISTURB then
		local ap = GetIgnoreHealPercentage(k)
		if ap > 0 and PRD(k, ap, "common_ignore_heal") then
			PlayerData:addDetailData(k, an, "regen_blocked", math.max(0, l), false, am)
			return
		end
	end
	local aO = l
	if bit.band(ao, HealFlags.HEAL_FLAG_IGNORE_ADJUST) ~= HealFlags.HEAL_FLAG_IGNORE_ADJUST then
		if HasState(k, EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM) then
			aO = 0
		else
			aO = math.floor(
				math.max(
					0,
					(aO + GetHealBonus(k))
						* (1 + GetHealAmplify(k, { origin = am, type = an, flag = ao }) * 0.01)
						* (1 - GetHPLossPercentage(k) * 0.01)
				)
			)
		end
		local aB = GetModifierProperty(
			k,
			EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
			{ type = "heal", count = aO, flag = ao }
		)
		aO = math.floor(aO * (1 - aB * 0.01))
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
			{ origin_health = aP, current_health = aR, flHealAmount = aO, target = k, origin = am, type = an, flag = ao },
			k,
			nil
		)
	end
	if aQ then
		if ao == HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL then
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
	local ap = GetIgnoreChaosPercent(k)
	if ap > 0 and PRD(k, ap, "common_ignore_chaos") then
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
	local aB = GetModifierProperty(
		k,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE,
		{ type = "chaos", count = l }
	)
	l = math.floor(l * (1 - aB * 0.01))
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
	if r:HasModifier("modifier_state_immunity_custom") then
		return
	end
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
	if r:HasModifier("modifier_state_immunity_custom") then
		return
	end
	CombatLog:recordState(r, k, "Silence", "add")
	local bh =
		math.max(0, 1 - GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_STATE_RESISTANCE) * 0.01)
	aJ = aJ * bh
	r:AddNewModifier(k, I, "modifier_silence_custom", { duration = aJ })
end
function AddDisarm(k, r, I, aJ)
	if r:HasModifier("modifier_state_immunity_custom") then
		return
	end
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
	if r:HasModifier("modifier_state_immunity_custom") then
		return
	end
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