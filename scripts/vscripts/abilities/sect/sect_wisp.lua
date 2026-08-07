--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_wisp"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__StringIncludes
local h = b.__TS__ObjectKeys
local i = b.__TS__ArraySome
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 6,
		["22"] = 57,
		["23"] = 58,
		["24"] = 59,
		["25"] = 60,
		["26"] = 61,
		["27"] = 62,
		["28"] = 63,
		["29"] = 64,
		["30"] = 65,
		["31"] = 66,
		["32"] = 67,
		["33"] = 68,
		["34"] = 69,
		["35"] = 70,
		["36"] = 71,
		["37"] = 72,
		["38"] = 73,
		["39"] = 74,
		["40"] = 75,
		["41"] = 76,
		["42"] = 77,
		["43"] = 78,
		["44"] = 79,
		["45"] = 80,
		["46"] = 81,
		["47"] = 82,
		["48"] = 83,
		["49"] = 84,
		["50"] = 85,
		["51"] = 86,
		["52"] = 87,
		["53"] = 88,
		["54"] = 89,
		["55"] = 90,
		["56"] = 91,
		["57"] = 92,
		["58"] = 93,
		["59"] = 94,
		["60"] = 95,
		["61"] = 96,
		["62"] = 97,
		["63"] = 57,
		["64"] = 99,
		["65"] = 99,
		["66"] = 99,
		["68"] = 100,
		["69"] = 101,
		["72"] = 102,
		["73"] = 103,
		["74"] = 104,
		["75"] = 104,
		["76"] = 104,
		["77"] = 104,
		["78"] = 104,
		["82"] = 108,
		["83"] = 108,
		["84"] = 109,
		["85"] = 110,
		["86"] = 111,
		["89"] = 113,
		["90"] = 113,
		["91"] = 114,
		["92"] = 115,
		["94"] = 113,
		["98"] = 118,
		["99"] = 118,
		["100"] = 119,
		["102"] = 120,
		["103"] = 121,
		["106"] = 122,
		["107"] = 123,
		["108"] = 123,
		["109"] = 123,
		["110"] = 123,
		["115"] = 127,
		["118"] = 128,
		["119"] = 129,
		["120"] = 129,
		["121"] = 129,
		["122"] = 129,
		["123"] = 129,
		["124"] = 129,
		["125"] = 129,
		["130"] = 133,
		["133"] = 134,
		["134"] = 135,
		["135"] = 135,
		["136"] = 135,
		["137"] = 135,
		["138"] = 135,
		["139"] = 135,
		["140"] = 135,
		["145"] = 139,
		["148"] = 140,
		["149"] = 141,
		["150"] = 141,
		["151"] = 141,
		["152"] = 141,
		["153"] = 141,
		["154"] = 141,
		["159"] = 145,
		["162"] = 146,
		["163"] = 147,
		["164"] = 147,
		["165"] = 147,
		["166"] = 147,
		["167"] = 147,
		["168"] = 147,
		["173"] = 151,
		["176"] = 152,
		["177"] = 153,
		["178"] = 153,
		["179"] = 153,
		["180"] = 153,
		["181"] = 153,
		["182"] = 153,
		["183"] = 153,
		["188"] = 157,
		["191"] = 158,
		["192"] = 159,
		["193"] = 159,
		["194"] = 159,
		["195"] = 159,
		["196"] = 159,
		["197"] = 159,
		["198"] = 159,
		["199"] = 159,
		["200"] = 159,
		["205"] = 163,
		["208"] = 164,
		["209"] = 165,
		["210"] = 166,
		["211"] = 167,
		["212"] = 167,
		["213"] = 167,
		["214"] = 167,
		["215"] = 167,
		["216"] = 167,
		["217"] = 167,
		["218"] = 174,
		["219"] = 175,
		["220"] = 176,
		["221"] = 176,
		["222"] = 176,
		["223"] = 176,
		["224"] = 176,
		["225"] = 176,
		["226"] = 176,
		["227"] = 176,
		["228"] = 176,
		["229"] = 176,
		["230"] = 186,
		["231"] = 187,
		["233"] = 189,
		["235"] = 167,
		["236"] = 167,
		["243"] = 118,
		["246"] = 99,
		["247"] = 200,
		["248"] = 201,
		["249"] = 200,
		["250"] = 6,
		["251"] = 5,
		["252"] = 6,
		["254"] = 6,
		["255"] = 205,
		["256"] = 212,
		["257"] = 205,
		["258"] = 212,
		["260"] = 212,
		["261"] = 216,
		["262"] = 216,
		["263"] = 216,
		["264"] = 216,
		["265"] = 216,
		["266"] = 216,
		["267"] = 223,
		["268"] = 225,
		["269"] = 227,
		["270"] = 228,
		["271"] = 229,
		["272"] = 230,
		["273"] = 231,
		["274"] = 232,
		["275"] = 233,
		["276"] = 234,
		["277"] = 235,
		["278"] = 238,
		["279"] = 240,
		["280"] = 279,
		["281"] = 280,
		["282"] = 302,
		["283"] = 303,
		["284"] = 205,
		["285"] = 306,
		["286"] = 307,
		["287"] = 308,
		["288"] = 309,
		["289"] = 310,
		["290"] = 311,
		["291"] = 312,
		["292"] = 313,
		["293"] = 314,
		["294"] = 315,
		["295"] = 316,
		["296"] = 317,
		["297"] = 320,
		["298"] = 321,
		["299"] = 322,
		["300"] = 323,
		["301"] = 324,
		["302"] = 325,
		["303"] = 326,
		["304"] = 327,
		["305"] = 328,
		["306"] = 329,
		["307"] = 330,
		["308"] = 331,
		["309"] = 332,
		["310"] = 333,
		["311"] = 334,
		["312"] = 335,
		["313"] = 336,
		["314"] = 337,
		["315"] = 338,
		["316"] = 339,
		["317"] = 340,
		["318"] = 341,
		["319"] = 342,
		["320"] = 343,
		["321"] = 344,
		["322"] = 345,
		["323"] = 346,
		["324"] = 347,
		["325"] = 349,
		["326"] = 351,
		["327"] = 352,
		["328"] = 353,
		["329"] = 354,
		["330"] = 355,
		["331"] = 356,
		["332"] = 357,
		["333"] = 358,
		["334"] = 359,
		["335"] = 359,
		["336"] = 359,
		["337"] = 360,
		["338"] = 359,
		["339"] = 359,
		["340"] = 363,
		["341"] = 306,
		["342"] = 365,
		["343"] = 366,
		["344"] = 367,
		["346"] = 365,
		["347"] = 370,
		["348"] = 371,
		["349"] = 371,
		["350"] = 371,
		["351"] = 371,
		["352"] = 371,
		["353"] = 371,
		["354"] = 371,
		["355"] = 371,
		["356"] = 370,
		["357"] = 385,
		["358"] = 386,
		["359"] = 386,
		["360"] = 386,
		["361"] = 389,
		["362"] = 389,
		["363"] = 389,
		["364"] = 386,
		["365"] = 390,
		["366"] = 390,
		["367"] = 390,
		["368"] = 386,
		["369"] = 391,
		["370"] = 391,
		["371"] = 391,
		["372"] = 386,
		["373"] = 392,
		["374"] = 392,
		["375"] = 392,
		["376"] = 386,
		["377"] = 386,
		["378"] = 386,
		["379"] = 385,
		["380"] = 397,
		["381"] = 398,
		["382"] = 399,
		["383"] = 400,
		["384"] = 401,
		["385"] = 403,
		["386"] = 403,
		["387"] = 403,
		["388"] = 404,
		["389"] = 405,
		["390"] = 406,
		["391"] = 407,
		["392"] = 408,
		["393"] = 408,
		["394"] = 408,
		["395"] = 408,
		["396"] = 408,
		["397"] = 408,
		["398"] = 408,
		["399"] = 408,
		["400"] = 408,
		["401"] = 409,
		["402"] = 410,
		["403"] = 410,
		["404"] = 410,
		["405"] = 410,
		["406"] = 410,
		["407"] = 410,
		["408"] = 410,
		["409"] = 410,
		["410"] = 410,
		["411"] = 410,
		["412"] = 410,
		["414"] = 403,
		["415"] = 403,
		["418"] = 397,
		["419"] = 416,
		["420"] = 417,
		["421"] = 418,
		["422"] = 419,
		["423"] = 420,
		["424"] = 421,
		["425"] = 421,
		["426"] = 421,
		["427"] = 421,
		["428"] = 421,
		["429"] = 421,
		["432"] = 416,
		["433"] = 425,
		["434"] = 426,
		["435"] = 425,
		["436"] = 429,
		["437"] = 430,
		["438"] = 431,
		["439"] = 432,
		["440"] = 433,
		["441"] = 435,
		["442"] = 436,
		["443"] = 437,
		["444"] = 437,
		["445"] = 438,
		["447"] = 441,
		["448"] = 443,
		["449"] = 443,
		["450"] = 444,
		["451"] = 445,
		["453"] = 448,
		["454"] = 450,
		["455"] = 450,
		["456"] = 451,
		["457"] = 452,
		["459"] = 455,
		["460"] = 456,
		["461"] = 456,
		["462"] = 457,
		["463"] = 458,
		["465"] = 461,
		["466"] = 429,
		["467"] = 463,
		["468"] = 464,
		["469"] = 463,
		["470"] = 467,
		["471"] = 468,
		["472"] = 467,
		["473"] = 483,
		["475"] = 485,
		["476"] = 486,
		["477"] = 487,
		["478"] = 487,
		["479"] = 487,
		["480"] = 487,
		["481"] = 487,
		["482"] = 487,
		["483"] = 487,
		["485"] = 489,
		["487"] = 491,
		["488"] = 492,
		["490"] = 494,
		["491"] = 483,
		["492"] = 496,
		["493"] = 497,
		["494"] = 498,
		["496"] = 500,
		["497"] = 501,
		["498"] = 502,
		["499"] = 503,
		["501"] = 507,
		["503"] = 508,
		["504"] = 509,
		["505"] = 510,
		["506"] = 512,
		["507"] = 513,
		["509"] = 516,
		["510"] = 517,
		["511"] = 518,
		["512"] = 520,
		["513"] = 521,
		["514"] = 522,
		["515"] = 523,
		["516"] = 528,
		["517"] = 529,
		["518"] = 530,
		["519"] = 531,
		["520"] = 531,
		["521"] = 531,
		["522"] = 531,
		["524"] = 533,
		["526"] = 536,
		["527"] = 537,
		["528"] = 538,
		["530"] = 540,
		["531"] = 541,
		["533"] = 543,
		["534"] = 545,
		["535"] = 547,
		["536"] = 549,
		["537"] = 550,
		["538"] = 551,
		["539"] = 552,
		["540"] = 553,
		["542"] = 555,
		["549"] = 560,
		["550"] = 496,
		["551"] = 562,
		["552"] = 562,
		["553"] = 562,
		["555"] = 562,
		["556"] = 562,
		["558"] = 563,
		["559"] = 569,
		["560"] = 569,
		["561"] = 569,
		["562"] = 569,
		["563"] = 569,
		["564"] = 575,
		["565"] = 576,
		["566"] = 577,
		["567"] = 578,
		["568"] = 579,
		["569"] = 580,
		["573"] = 584,
		["574"] = 585,
		["575"] = 585,
		["576"] = 585,
		["577"] = 585,
		["578"] = 585,
		["579"] = 585,
		["581"] = 587,
		["582"] = 588,
		["583"] = 562,
		["584"] = 606,
		["585"] = 607,
		["586"] = 608,
		["587"] = 609,
		["588"] = 610,
		["589"] = 612,
		["590"] = 612,
		["591"] = 612,
		["592"] = 613,
		["595"] = 616,
		["596"] = 617,
		["597"] = 617,
		["598"] = 617,
		["599"] = 617,
		["600"] = 618,
		["602"] = 620,
		["603"] = 621,
		["604"] = 622,
		["606"] = 624,
		["607"] = 624,
		["608"] = 624,
		["609"] = 624,
		["610"] = 625,
		["611"] = 626,
		["612"] = 626,
		["613"] = 626,
		["614"] = 626,
		["615"] = 626,
		["616"] = 626,
		["617"] = 626,
		["618"] = 633,
		["619"] = 634,
		["620"] = 635,
		["621"] = 635,
		["622"] = 635,
		["623"] = 635,
		["624"] = 635,
		["625"] = 635,
		["626"] = 635,
		["627"] = 635,
		["628"] = 635,
		["629"] = 635,
		["631"] = 626,
		["632"] = 626,
		["633"] = 612,
		["634"] = 612,
		["635"] = 606,
		["636"] = 651,
		["637"] = 652,
		["638"] = 654,
		["639"] = 655,
		["640"] = 656,
		["641"] = 656,
		["642"] = 656,
		["643"] = 656,
		["645"] = 659,
		["646"] = 660,
		["647"] = 660,
		["648"] = 660,
		["649"] = 660,
		["650"] = 660,
		["651"] = 660,
		["652"] = 660,
		["653"] = 660,
		["654"] = 662,
		["655"] = 662,
		["656"] = 662,
		["657"] = 663,
		["658"] = 664,
		["659"] = 664,
		["660"] = 664,
		["661"] = 664,
		["662"] = 664,
		["663"] = 662,
		["664"] = 662,
		["665"] = 666,
		["666"] = 667,
		["670"] = 651,
		["671"] = 672,
		["672"] = 673,
		["673"] = 674,
		["674"] = 675,
		["675"] = 676,
		["676"] = 677,
		["677"] = 678,
		["678"] = 679,
		["679"] = 680,
		["680"] = 681,
		["681"] = 682,
		["682"] = 683,
		["683"] = 684,
		["684"] = 685,
		["685"] = 694,
		["686"] = 695,
		["687"] = 695,
		["688"] = 695,
		["689"] = 695,
		["690"] = 695,
		["691"] = 695,
		["693"] = 697,
		["694"] = 698,
		["695"] = 698,
		["696"] = 698,
		["697"] = 698,
		["698"] = 698,
		["699"] = 698,
		["701"] = 672,
		["702"] = 701,
		["703"] = 702,
		["704"] = 702,
		["705"] = 702,
		["706"] = 702,
		["707"] = 702,
		["708"] = 702,
		["709"] = 702,
		["710"] = 702,
		["711"] = 702,
		["712"] = 702,
		["713"] = 702,
		["714"] = 702,
		["715"] = 701,
		["716"] = 716,
		["718"] = 717,
		["719"] = 718,
		["721"] = 718,
		["723"] = 719,
		["725"] = 719,
		["727"] = 720,
		["729"] = 720,
		["731"] = 721,
		["733"] = 721,
		["735"] = 722,
		["737"] = 722,
		["739"] = 723,
		["741"] = 723,
		["743"] = 724,
		["745"] = 724,
		["747"] = 725,
		["749"] = 725,
		["751"] = 726,
		["753"] = 726,
		["755"] = 727,
		["757"] = 727,
		["760"] = 728,
		["763"] = 716,
		["764"] = 733,
		["765"] = 734,
		["766"] = 735,
		["767"] = 737,
		["768"] = 738,
		["770"] = 741,
		["771"] = 742,
		["773"] = 745,
		["774"] = 746,
		["776"] = 749,
		["777"] = 750,
		["779"] = 753,
		["780"] = 754,
		["782"] = 757,
		["783"] = 758,
		["785"] = 761,
		["786"] = 762,
		["788"] = 765,
		["789"] = 766,
		["791"] = 769,
		["792"] = 770,
		["794"] = 773,
		["795"] = 774,
		["797"] = 777,
		["798"] = 778,
		["800"] = 733,
		["801"] = 784,
		["802"] = 785,
		["803"] = 787,
		["804"] = 788,
		["805"] = 788,
		["806"] = 788,
		["807"] = 788,
		["808"] = 789,
		["810"] = 793,
		["811"] = 794,
		["812"] = 795,
		["813"] = 796,
		["814"] = 797,
		["815"] = 797,
		["816"] = 797,
		["817"] = 798,
		["818"] = 797,
		["819"] = 797,
		["820"] = 800,
		["825"] = 805,
		["826"] = 806,
		["827"] = 807,
		["828"] = 808,
		["829"] = 809,
		["830"] = 810,
		["831"] = 811,
		["832"] = 812,
		["833"] = 813,
		["834"] = 814,
		["838"] = 818,
		["839"] = 819,
		["842"] = 822,
		["843"] = 823,
		["845"] = 825,
		["846"] = 826,
		["850"] = 833,
		["851"] = 835,
		["852"] = 836,
		["853"] = 837,
		["854"] = 842,
		["856"] = 843,
		["857"] = 843,
		["858"] = 844,
		["859"] = 845,
		["860"] = 843,
		["864"] = 848,
		["865"] = 784,
		["866"] = 852,
		["867"] = 853,
		["870"] = 858,
		["871"] = 859,
		["872"] = 860,
		["874"] = 862,
		["875"] = 863,
		["876"] = 864,
		["877"] = 865,
		["878"] = 867,
		["879"] = 868,
		["880"] = 869,
		["881"] = 870,
		["882"] = 871,
		["885"] = 875,
		["886"] = 876,
		["887"] = 876,
		["888"] = 876,
		["889"] = 876,
		["890"] = 877,
		["891"] = 877,
		["892"] = 877,
		["893"] = 877,
		["894"] = 878,
		["897"] = 881,
		["899"] = 883,
		["900"] = 884,
		["901"] = 885,
		["902"] = 886,
		["906"] = 852,
		["907"] = 892,
		["908"] = 897,
		["910"] = 898,
		["911"] = 899,
		["912"] = 900,
		["913"] = 901,
		["918"] = 904,
		["919"] = 892,
		["920"] = 906,
		["921"] = 908,
		["922"] = 909,
		["924"] = 912,
		["925"] = 913,
		["927"] = 916,
		["928"] = 917,
		["930"] = 920,
		["931"] = 921,
		["933"] = 924,
		["934"] = 925,
		["936"] = 928,
		["937"] = 929,
		["939"] = 932,
		["940"] = 933,
		["942"] = 936,
		["943"] = 937,
		["945"] = 940,
		["946"] = 941,
		["948"] = 906,
		["949"] = 944,
		["950"] = 945,
		["951"] = 948,
		["953"] = 944,
		["954"] = 951,
		["955"] = 952,
		["956"] = 953,
		["957"] = 954,
		["958"] = 955,
		["961"] = 959,
		["962"] = 951,
		["963"] = 961,
		["964"] = 962,
		["965"] = 963,
		["966"] = 964,
		["967"] = 961,
		["968"] = 966,
		["969"] = 967,
		["970"] = 968,
		["971"] = 969,
		["974"] = 970,
		["975"] = 971,
		["976"] = 972,
		["977"] = 973,
		["978"] = 974,
		["979"] = 975,
		["980"] = 976,
		["981"] = 977,
		["982"] = 978,
		["983"] = 979,
		["985"] = 981,
		["986"] = 981,
		["987"] = 981,
		["988"] = 981,
		["989"] = 981,
		["990"] = 981,
		["991"] = 981,
		["992"] = 981,
		["993"] = 986,
		["994"] = 988,
		["995"] = 989,
		["996"] = 990,
		["998"] = 995,
		["1000"] = 997,
		["1001"] = 999,
		["1003"] = 1002,
		["1004"] = 1004,
		["1005"] = 1038,
		["1006"] = 1040,
		["1007"] = 1044,
		["1008"] = 966,
		["1009"] = 1047,
		["1010"] = 1048,
		["1011"] = 1049,
		["1012"] = 1050,
		["1015"] = 1054,
		["1016"] = 1056,
		["1017"] = 1058,
		["1018"] = 1060,
		["1019"] = 1062,
		["1020"] = 1064,
		["1021"] = 1066,
		["1022"] = 1068,
		["1023"] = 1047,
		["1024"] = 1071,
		["1025"] = 1072,
		["1026"] = 1073,
		["1028"] = 1071,
		["1029"] = 1077,
		["1030"] = 1078,
		["1031"] = 1079,
		["1033"] = 1077,
		["1034"] = 1082,
		["1035"] = 1083,
		["1036"] = 1082,
		["1037"] = 1087,
		["1038"] = 1088,
		["1041"] = 1091,
		["1042"] = 1091,
		["1043"] = 1091,
		["1044"] = 1091,
		["1045"] = 1092,
		["1046"] = 1093,
		["1047"] = 1094,
		["1048"] = 1095,
		["1049"] = 1096,
		["1050"] = 1096,
		["1051"] = 1096,
		["1052"] = 1097,
		["1053"] = 1098,
		["1054"] = 1099,
		["1055"] = 1100,
		["1056"] = 1101,
		["1059"] = 1096,
		["1060"] = 1096,
		["1061"] = 1105,
		["1062"] = 1106,
		["1063"] = 1107,
		["1064"] = 1110,
		["1065"] = 1111,
		["1069"] = 1087,
		["1070"] = 1117,
		["1071"] = 1118,
		["1072"] = 1119,
		["1073"] = 1117,
		["1074"] = 1123,
		["1075"] = 1124,
		["1078"] = 1127,
		["1081"] = 1130,
		["1083"] = 1130,
		["1085"] = 1123,
		["1086"] = 1133,
		["1087"] = 1134,
		["1088"] = 1136,
		["1089"] = 1137,
		["1090"] = 1138,
		["1091"] = 1139,
		["1093"] = 1133,
		["1094"] = 212,
		["1095"] = 205,
		["1096"] = 205,
		["1097"] = 205,
		["1098"] = 205,
		["1099"] = 205,
		["1100"] = 205,
		["1101"] = 205,
		["1102"] = 212,
		["1104"] = 212,
		["1106"] = 1145,
		["1107"] = 1152,
		["1108"] = 1145,
		["1109"] = 1152,
		["1110"] = 1156,
		["1111"] = 1157,
		["1112"] = 1158,
		["1113"] = 1159,
		["1114"] = 1160,
		["1115"] = 1161,
		["1116"] = 1162,
		["1117"] = 1163,
		["1118"] = 1163,
		["1119"] = 1163,
		["1120"] = 1163,
		["1121"] = 1163,
		["1122"] = 1167,
		["1123"] = 1167,
		["1124"] = 1167,
		["1125"] = 1167,
		["1126"] = 1167,
		["1127"] = 1171,
		["1128"] = 1172,
		["1130"] = 1174,
		["1131"] = 1175,
		["1133"] = 1177,
		["1134"] = 1178,
		["1135"] = 1179,
		["1136"] = 1180,
		["1137"] = 1181,
		["1138"] = 1182,
		["1140"] = 1184,
		["1141"] = 1185,
		["1145"] = 1189,
		["1146"] = 1190,
		["1147"] = 1191,
		["1148"] = 1191,
		["1149"] = 1191,
		["1150"] = 1191,
		["1151"] = 1191,
		["1152"] = 1191,
		["1153"] = 1191,
		["1154"] = 1191,
		["1155"] = 1191,
		["1156"] = 1192,
		["1157"] = 1192,
		["1158"] = 1192,
		["1159"] = 1192,
		["1160"] = 1192,
		["1161"] = 1192,
		["1162"] = 1192,
		["1163"] = 1192,
		["1164"] = 1192,
		["1165"] = 1193,
		["1166"] = 1193,
		["1167"] = 1193,
		["1168"] = 1193,
		["1169"] = 1193,
		["1170"] = 1193,
		["1171"] = 1193,
		["1172"] = 1193,
		["1174"] = 1195,
		["1175"] = 1196,
		["1177"] = 1198,
		["1178"] = 1199,
		["1179"] = 1199,
		["1180"] = 1199,
		["1181"] = 1199,
		["1182"] = 1199,
		["1183"] = 1199,
		["1184"] = 1199,
		["1185"] = 1199,
		["1186"] = 1200,
		["1187"] = 1201,
		["1188"] = 1202,
		["1189"] = 1202,
		["1190"] = 1202,
		["1191"] = 1202,
		["1192"] = 1202,
		["1193"] = 1202,
		["1194"] = 1202,
		["1195"] = 1202,
		["1196"] = 1202,
		["1197"] = 1203,
		["1198"] = 1203,
		["1199"] = 1203,
		["1200"] = 1203,
		["1201"] = 1203,
		["1202"] = 1203,
		["1203"] = 1203,
		["1204"] = 1203,
		["1205"] = 1203,
		["1206"] = 1204,
		["1207"] = 1204,
		["1208"] = 1204,
		["1209"] = 1204,
		["1210"] = 1204,
		["1211"] = 1204,
		["1212"] = 1204,
		["1213"] = 1204,
		["1216"] = 1156,
		["1217"] = 1208,
		["1218"] = 1209,
		["1219"] = 1210,
		["1220"] = 1211,
		["1221"] = 1212,
		["1222"] = 1212,
		["1223"] = 1212,
		["1224"] = 1212,
		["1225"] = 1212,
		["1227"] = 1208,
		["1228"] = 1215,
		["1229"] = 1216,
		["1230"] = 1215,
		["1231"] = 1221,
		["1232"] = 1222,
		["1233"] = 1221,
		["1234"] = 1227,
		["1235"] = 1228,
		["1236"] = 1227,
		["1237"] = 1235,
		["1238"] = 1236,
		["1239"] = 1237,
		["1240"] = 1235,
		["1241"] = 1239,
		["1242"] = 1244,
		["1243"] = 1244,
		["1244"] = 1244,
		["1246"] = 1244,
		["1247"] = 1239,
		["1248"] = 1246,
		["1249"] = 1247,
		["1250"] = 1246,
		["1251"] = 1249,
		["1252"] = 1250,
		["1253"] = 1249,
		["1254"] = 1152,
		["1255"] = 1145,
		["1256"] = 1145,
		["1257"] = 1145,
		["1258"] = 1145,
		["1259"] = 1145,
		["1260"] = 1145,
		["1261"] = 1145,
		["1262"] = 1152,
		["1264"] = 1152,
		["1265"] = 1254,
		["1266"] = 1261,
		["1267"] = 1254,
		["1268"] = 1261,
		["1269"] = 1263,
		["1270"] = 1264,
		["1271"] = 1263,
		["1272"] = 1267,
		["1273"] = 1268,
		["1274"] = 1267,
		["1275"] = 1261,
		["1276"] = 1254,
		["1277"] = 1254,
		["1278"] = 1254,
		["1279"] = 1254,
		["1280"] = 1254,
		["1281"] = 1254,
		["1282"] = 1254,
		["1283"] = 1261,
		["1285"] = 1261,
		["1286"] = 1272,
		["1287"] = 1279,
		["1288"] = 1272,
		["1289"] = 1279,
		["1290"] = 1282,
		["1291"] = 1283,
		["1292"] = 1282,
		["1293"] = 1285,
		["1294"] = 1286,
		["1295"] = 1285,
		["1296"] = 1279,
		["1297"] = 1272,
		["1298"] = 1272,
		["1299"] = 1272,
		["1300"] = 1272,
		["1301"] = 1272,
		["1302"] = 1272,
		["1303"] = 1272,
		["1304"] = 1279,
		["1306"] = 1279,
		["1308"] = 1292,
		["1309"] = 1299,
		["1310"] = 1292,
		["1311"] = 1299,
		["1312"] = 1302,
		["1313"] = 1303,
		["1314"] = 1302,
		["1315"] = 1305,
		["1316"] = 1306,
		["1317"] = 1307,
		["1319"] = 1305,
		["1320"] = 1310,
		["1321"] = 1311,
		["1322"] = 1310,
		["1323"] = 1315,
		["1324"] = 1316,
		["1325"] = 1315,
		["1326"] = 1299,
		["1327"] = 1292,
		["1328"] = 1292,
		["1329"] = 1292,
		["1330"] = 1292,
		["1331"] = 1292,
		["1332"] = 1292,
		["1333"] = 1292,
		["1334"] = 1299,
		["1336"] = 1299,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
k.sect_wisp = c()
local r = k.sect_wisp
r.name = "sect_wisp"
d(r, m)
function r.prototype.GetAbilitySpecialValue(self)
	self.health_bonus_pct = self:GetSpecialValueFor("health_bonus_pct")
	self.share_bonus = self:GetSpecialValueFor("share_bonus")
	self.cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	self.n_12_health = self:GetSectSpecialValueFor("12", "n_12_health")
	self.n_12_health_base = self:GetSectSpecialValueFor("12", "n_12_health_base")
	self.n_27_health = self:GetSectSpecialValueFor("27", "n_27_health")
	self.n_27_health_base = self:GetSectSpecialValueFor("27", "n_27_health_base")
	self.n_41_health = self:GetSectSpecialValueFor("41", "n_41_health")
	self.n_41_health_base = self:GetSectSpecialValueFor("41", "n_41_health_base")
	self.n_54_health = self:GetSectSpecialValueFor("54", "n_54_health")
	self.n_54_health_base = self:GetSectSpecialValueFor("54", "n_54_health_base")
	self.n_66_interval = self:GetSectSpecialValueFor("66", "n_66_interval")
	self.n_66_regen = self:GetSectSpecialValueFor("66", "n_66_regen")
	self.n_77_interval = self:GetSectSpecialValueFor("77", "n_77_interval")
	self.n_77_mana = self:GetSectSpecialValueFor("77", "n_77_mana")
	self.n_87_interval = self:GetSectSpecialValueFor("87", "n_87_interval")
	self.n_87_poison = self:GetSectSpecialValueFor("87", "n_87_poison")
	self.n_96_interval = self:GetSectSpecialValueFor("96", "n_96_interval")
	self.n_96_ice = self:GetSectSpecialValueFor("96", "n_96_ice")
	self.n_104_interval = self:GetSectSpecialValueFor("104", "n_104_interval")
	self.n_104_shield = self:GetSectSpecialValueFor("104", "n_104_shield")
	self.n_111_interval = self:GetSectSpecialValueFor("111", "n_111_interval")
	self.n_111_injury = self:GetSectSpecialValueFor("111", "n_111_injury")
	self.n_116_bonus = self:GetSectSpecialValueFor("116", "n_116_bonus")
	self.n_117_bonus = self:GetSectSpecialValueFor("117", "n_117_bonus")
	self.r_118_threshold = self:GetSectSpecialValueFor("118", "r_118_threshold")
	self.r_118_health = self:GetSectSpecialValueFor("118", "r_118_health")
	self.r_120_interval = self:GetSectSpecialValueFor("120", "r_120_interval")
	self.r_120_damage = self:GetSectSpecialValueFor("120", "r_120_damage")
	self.sr_121_count = self:GetSectSpecialValueFor("121", "sr_121_count")
	self.sr_121_factor = self:GetSectSpecialValueFor("121", "sr_121_factor")
	self.n_130_interval = self:GetSectSpecialValueFor("130", "n_130_interval")
	self.n_130_fury = self:GetSectSpecialValueFor("130", "n_130_fury")
	self.sr_149_damage = self:GetSectSpecialValueFor("149", "sr_149_damage")
	self.sr_149_reduce = self:GetSectSpecialValueFor("149", "sr_149_reduce")
	self.sr_149_chance = self:GetSectSpecialValueFor("149", "sr_149_chance")
	self.sr_149_heal = self:GetSectSpecialValueFor("149", "sr_149_heal")
	self.n_169_interval = self:GetSectSpecialValueFor("169", "n_169_interval")
	self.n_169_chaos_count = self:GetSectSpecialValueFor("169", "n_169_chaos_count")
	self.r_191_health = self:GetSectSpecialValueFor("191", "r_191_health")
end
function r.prototype.TriggerByName(self, s, t)
	if t == nil then
		t = self:GetCaster():GetEnemy()
	end
	local u = self:GetCaster()
	if not IsInjurable(u, t) then
		return
	end
	if s == "66" then
		if self.n_66_regen > 0 then
			HealWisp(u, self, GetSectWispModifiedValue(u, self.n_66_regen))
		end
		return
	end
	local v = u:FindModifierByName("modifier_sect_wisp")
	local w = v and v:GetWispList() or {}
	local x = {}
	if HasState(u, EOMModifierStates.MODIFIER_STATE_HERO_WISP) then
		x[#x + 1] = u
	end
	do
		local y = 0
		while y < #w do
			if IsValid(w[y + 1].wisp) then
				x[#x + 1] = w[y + 1].wisp
			end
			y = y + 1
		end
	end
	do
		local y = 0
		while y < #x do
			local z = x[y + 1]
			repeat
				local A = s
				local B = A == "77"
				if B then
					do
						if self.n_77_mana > 0 then
							Restore(u, GetSectWispModifiedValue(u, self.n_77_mana))
						end
						break
					end
				end
				B = B or A == "87"
				if B then
					do
						if self.n_87_poison > 0 then
							AddPoison(u, t, GetSectWispModifiedValue(u, self.n_87_poison), "87", "AbilityUpgrade")
						end
						break
					end
				end
				B = B or A == "96"
				if B then
					do
						if self.n_96_ice > 0 then
							AddIce(u, t, GetSectWispModifiedValue(u, self.n_96_ice), "96", "AbilityUpgrade")
						end
						break
					end
				end
				B = B or A == "130"
				if B then
					do
						if self.n_130_fury > 0 then
							AddFury(u, GetSectWispModifiedValue(u, self.n_130_fury), "130", "AbilityUpgrade")
						end
						break
					end
				end
				B = B or A == "104"
				if B then
					do
						if self.n_104_shield > 0 then
							AddShield(u, GetSectWispModifiedValue(u, self.n_104_shield), "104", "AbilityUpgrade")
						end
						break
					end
				end
				B = B or A == "111"
				if B then
					do
						if self.n_111_injury > 0 then
							AddInjury(u, t, GetSectWispModifiedValue(u, self.n_111_injury), "111", "AbilityUpgrade")
						end
						break
					end
				end
				B = B or A == "169"
				if B then
					do
						if self.n_169_chaos_count > 0 then
							AddChaos(
								u,
								GetSectChaosModifiedValue(u, GetSectWispModifiedValue(u, self.n_169_chaos_count)),
								"169",
								"AbilityUpgrade"
							)
						end
						break
					end
				end
				B = B or A == "120"
				if B then
					do
						if self.r_120_damage > 0 then
							local C = z
							if C and IsInjurable(t) then
								Projectile:CreateTrackingProjectile({
									EffectName = "particles/projectile/sect_wisp/sect_wisp_attack.vpcf",
									hCaster = u,
									hTarget = t,
									Ability = self,
									vSpawnOrigin = C:GetAttachmentPosition("attach_attack1"),
									iMoveSpeed = 1000,
									OnProjectileHit = function(D, E, F)
										if IsInjurable(D) then
											local G = {
												attacker = u,
												target = D,
												ability = self,
												damage = GetSectWispModifiedValue(u, self.r_120_damage),
												damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
												damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
												damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
												ability_upgrade = "120",
											}
											if u ~= C then
												G.wisp = C
											end
											DamageSystem:dealDamage(G)
										end
									end,
								})
							end
						end
						break
					end
				end
			until true
			y = y + 1
		end
	end
end
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_wisp"
end
r = e({ n(nil) }, r)
k.sect_wisp = r
k.modifier_sect_wisp = c()
local H = k.modifier_sect_wisp
H.name = "modifier_sect_wisp"
d(H, p)
function H.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.wispPositionList = { Vector(150, 120, 0), Vector(150, -120, 0), Vector(-150, 120, 0), Vector(-150, -120, 0) }
	self.wispPositionIndex = 0
	self.timerInterval = 0.1
	self.n_66_timer = 0
	self.n_77_timer = 0
	self.n_87_timer = 0
	self.n_96_timer = 0
	self.n_130_timer = 0
	self.n_104_timer = 0
	self.n_111_timer = 0
	self.r_120_timer = 0
	self.trigger_timer = 0
	self.projList = {}
	self.wisps = {}
	self.r_119_enable = false
	self.r_119_invulnerable = false
	self.isBattleEnd = true
	self.parentIsNeutral = false
end
function H.prototype.GetAbilitySpecialValue(self)
	self.health_bonus_pct = self:GetAbilitySpecialValueFor("health_bonus_pct")
	self.share_bonus = self:GetAbilitySpecialValueFor("share_bonus")
	self.cooldown_reduction = self:GetAbilitySpecialValueFor("cooldown_reduction")
	self.n_12_health = self:GetSectSpecialValueFor("12", "n_12_health")
	self.n_12_health_base = self:GetSectSpecialValueFor("12", "n_12_health_base")
	self.n_27_health = self:GetSectSpecialValueFor("27", "n_27_health")
	self.n_27_health_base = self:GetSectSpecialValueFor("27", "n_27_health_base")
	self.n_41_health = self:GetSectSpecialValueFor("41", "n_41_health")
	self.n_41_health_base = self:GetSectSpecialValueFor("41", "n_41_health_base")
	self.n_54_health = self:GetSectSpecialValueFor("54", "n_54_health")
	self.n_54_health_base = self:GetSectSpecialValueFor("54", "n_54_health_base")
	self.n_66_interval = self:GetSectSpecialValueFor("66", "n_66_interval")
	self.n_66_regen = self:GetSectSpecialValueFor("66", "n_66_regen")
	self.n_77_interval = self:GetSectSpecialValueFor("77", "n_77_interval")
	self.n_77_mana = self:GetSectSpecialValueFor("77", "n_77_mana")
	self.n_87_interval = self:GetSectSpecialValueFor("87", "n_87_interval")
	self.n_87_poison = self:GetSectSpecialValueFor("87", "n_87_poison")
	self.n_96_interval = self:GetSectSpecialValueFor("96", "n_96_interval")
	self.n_104_interval = self:GetSectSpecialValueFor("104", "n_104_interval")
	self.n_111_interval = self:GetSectSpecialValueFor("111", "n_111_interval")
	self.n_111_injury = self:GetSectSpecialValueFor("111", "n_111_injury")
	self.n_116_bonus = self:GetSectSpecialValueFor("116", "n_116_bonus")
	self.n_117_bonus = self:GetSectSpecialValueFor("117", "n_117_bonus")
	self.r_118_threshold = self:GetSectSpecialValueFor("118", "r_118_threshold")
	self.r_118_health = self:GetSectSpecialValueFor("118", "r_118_health")
	self.r_119_base = self:GetSectSpecialValueFor("119", "r_119_base")
	self.r_119_factor = self:GetSectSpecialValueFor("119", "r_119_factor")
	self.r_120_interval = self:GetSectSpecialValueFor("120", "r_120_interval")
	self.r_120_damage = self:GetSectSpecialValueFor("120", "r_120_damage")
	self.sr_121_count = self:GetSectSpecialValueFor("121", "sr_121_count")
	self.sr_121_factor = self:GetSectSpecialValueFor("121", "sr_121_factor")
	self.n_130_interval = self:GetSectSpecialValueFor("130", "n_130_interval")
	self.sr_149_damage = self:GetSectSpecialValueFor("149", "sr_149_damage")
	self.sr_149_reduce = self:GetSectSpecialValueFor("149", "sr_149_reduce")
	self.sr_149_chance = self:GetSectSpecialValueFor("149", "sr_149_chance")
	self.sr_149_heal = self:GetSectSpecialValueFor("149", "sr_149_heal")
	self.n_169_interval = self:GetSectSpecialValueFor("169", "n_169_interval")
	self.n_169_chaos_count = self:GetSectSpecialValueFor("169", "n_169_chaos_count")
	self.r_191_health = self:GetSectSpecialValueFor("191", "r_191_health")
	self.wisp_share = WISP_SHARE_BASE + self.share_bonus
	self.trigger_interval = self:GetCustomAbilityValueFor("sect_wisp_trigger", "interval")
	self.effect_value = self:GetCustomAbilityValueFor("sect_wisp_effect", "value")
	self.effect_count = 0
	self.custom_reduce_interval = self:GetCustomAbilityValueFor("sect_wisp_effect", "reduce_interval")
	self.custom_max_reduce = self:GetCustomAbilityValueFor("sect_wisp_effect", "max_reduce")
	self.custom_duration = self:GetCustomAbilityValueFor("sect_wisp_effect", "duration")
	self.custom_reduce = 0
	self.custom_reduce_changed = {}
	f(self:GetWispTimerList(), function(I, C)
		self.custom_reduce_changed[C] = false
	end)
	self.ability:GetAbilitySpecialValue()
end
function H.prototype.OnCreated(self, G)
	if IsServer() then
		self.parentIsNeutral = self:GetParent():HasModifier("modifier_neutral")
	end
end
function H.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_SHARE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_SCAPEGOAT,
	}
end
function H.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SCAPEGOAT] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL] = { self:GetParent() },
	}
end
function H.prototype.OnWispDie(self, G)
	if not G.remove then
		if self.r_119_base > 0 then
			local u = self:GetParent()
			local t = u:GetEnemy()
			GameTimer(FRAME_TIME, function()
				if IsValid(self) and IsInjurable(u, t) then
					local C = G.wisp
					CombatLog:recordSectAbilityCast(u, "119")
					local J = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_wisp/wisp_guardian_explosion.vpcf",
						PATTACH_CUSTOMORIGIN,
						u
					)
					ParticleManager:SetParticleControlEnt(J, 0, C, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
					ParticleManager:ReleaseParticleIndex(J)
					u:DealDamage(
						t,
						self:GetAbility(),
						GetSectWispModifiedValue(u, self.r_119_base + C:GetMaxHealth() * self.r_119_factor / 100),
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
						nil,
						"119"
					)
				end
			end)
		end
	end
end
function H.prototype.OnWispHeal(self, G)
	if self.sr_149_damage > 0 and G.healAmount > 0 then
		local u = self:GetParent()
		local t = u:GetEnemy()
		if IsInjurable(u, t) then
			u:DealDamage(
				t,
				self:GetAbility(),
				G.healAmount * self.sr_149_damage * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
			)
		end
	end
end
function H.prototype.EOM_GetModifierIncomingDamageSharePercentage(self)
	return self.wisp_share
end
function H.prototype.EOM_GetModifierWispHealthBonus(self)
	local u = self:GetParent()
	local K = u:GetPlayerOwnerID()
	local L = PlayerData:getHero(K)
	local M = L and L:getAbilityData(true)
	local N = self.n_116_bonus
	if self.n_12_health > 0 then
		local O = M and M.sect_attack
		local P = O and O.exp or 0
		N = N + GetSectAttackModifiedValue(u, self.n_12_health * P + self.n_12_health_base)
	end
	if self.n_27_health > 0 then
		local Q = M and M.sect_evade
		local P = Q and Q.exp or 0
		N = N + P * self.n_27_health
		N = N + self.n_27_health_base
	end
	if self.n_41_health > 0 then
		local R = M and M.sect_crit
		local P = R and R.exp or 0
		N = N + P * self.n_41_health
		N = N + self.n_41_health_base
	end
	if self.n_54_health > 0 then
		local S = M and M.sect_health
		local P = S and S.exp or 0
		local T = GetSectHealthModifiedValue(u, self.n_54_health * P + self.n_54_health_base)
		N = N + T
	end
	return GetSectWispModifiedValue(u, N)
end
function H.prototype.EOM_GetModifierWispHealthPercentage(self)
	return self.health_bonus_pct
end
function H.prototype.EOM_GetModifierWispInterval(self)
	return self.cooldown_reduction + self.sr_149_reduce
end
function H.prototype.ShareDamage(self, G)
	local U = 0
	if self:GetStackCount() > 0 then
		local V = math.max(0, math.min(100, GetIncomingDamageSharePercent(G.target, G))) * 0.01
		local W = G.damage * V
		local X = W / #self.wisps
		U = self:DealDamageToEachWisp(X, G)
	end
	return U
end
function H.prototype.DealDamageToEachWisp(self, X, G, Y)
	local Z = 0
	if self:GetStackCount() > 0 then
		local _ = 0
		local a0 = DamageSystem:hasShareDamage(G)
		if a0 and G.attacker then
			_ = _
				+ GetModifierProperty(G.attacker, EOMModifierFunction.EOM_MODIFIER_PROPERTY_DAMAGE_OUTGOING_TO_WISP, G)
		end
		for y = #self.wisps, 1, -1 do
			do
				local a1 = y - 1
				local a2 = self.wisps[a1 + 1]
				if not a2 or not IsValid(a2.wisp) then
					table.remove(self.wisps, y)
					goto a3
				end
				local C = a2.wisp
				local a4 = C:GetHealth()
				G.wisp = C
				Z = Z + math.min(a4, X)
				if not G.wisp:IsInvulnerable() then
					local a5 = 0
					local a6 = { wisp = C, damage = X, first = a2.first }
					if a0 then
						a6.damage = a6.damage * (1 + _ * 0.01)
						a5 = GetModifierProperty(
							G.target,
							EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_TOTAL_DAMAGE_REDUCE_CONSTANT,
							a6
						)
						a6.damage = math.max(0, math.floor(a6.damage - a5))
					else
						a6.damage = math.floor(X)
					end
					local a7 =
						GetModifierProperty(G.target, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_MIN_HEALTH, a6)
					if a7 > 0 then
						a6.damage = math.min(a4 - 1, a6.damage)
					end
					if Y then
						Y(nil, C)
					end
					if a6.damage > a4 then
						a6.attacker = G.attacker
						a6.target = G.target
						a6.remove = false
						FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE, a6, G.attacker, G.target)
						C:ForceKill(false)
						table.remove(self.wisps, y)
						self:DecrementStackCount()
					else
						C:ModifyHealth(a4 - a6.damage, G.ability, false, 0)
					end
				end
			end
			::a3::
		end
	end
	return Z
end
function H.prototype.KillWisp(self, C, a8, a9)
	if a8 == nil then
		a8 = true
	end
	if a9 == nil then
		a9 = true
	end
	local G = { attacker = self:GetParent(), target = self:GetParent(), wisp = C, remove = a8 }
	for y = #self.wisps, 1, -1 do
		local a1 = y - 1
		local aa = self.wisps[a1 + 1]
		if aa.wisp == C then
			G.first = aa.first
			table.remove(self.wisps, y)
			break
		end
	end
	if a9 then
		FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE, G, self:GetParent(), self:GetParent())
	end
	C:ForceKill(false)
	self:DecrementStackCount()
end
function H.prototype.OnWispAttackStart(self)
	local u = self:GetParent()
	local t = u:GetEnemy()
	local ab = self:GetAbility()
	local ac = Courier:getWispAttackEffect(self.parentIsNeutral and -1 or u:GetPlayerOwnerID())
	EachWisp(u, function(C)
		if HasState(C, EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED) then
			return
		end
		local ad = C:GetAttachmentPosition("attach_attack1")
		if g(C:GetModelName(), "/wards/") then
			ad = C:GetAbsOrigin() + Vector(0, 0, 128)
		end
		local ae = GetModifierProperty(u, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_PROJECTILE_NAME, { wisp = C })
		if type(ae) == "string" then
			ac = ae
		end
		C:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, u:GetAttackSpeed(false))
		local af = WISP_BASE_DAMAGE
			+ GetModifierProperty(u, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK, { wisp = C })
		Projectile:CreateTrackingProjectile({
			EffectName = ac,
			hCaster = u,
			hTarget = t,
			Ability = ab,
			vSpawnOrigin = ad,
			iMoveSpeed = WISP_PROJECTILE_SPEED,
			OnProjectileHit = function(D, E, F)
				if IsInjurable(t, u) then
					DamageSystem:dealDamage({
						attacker = u,
						target = t,
						ability = ab,
						damage = GetSectWispModifiedValue(u, af),
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
						damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						wisp = C,
					})
				end
			end,
		})
	end)
end
function H.prototype.OnCustomTakeDamage(self, G)
	if G then
		if
			self.wisp_caller
			and G.target == self:GetParent()
			and self:GetParent():GetHealthPercent() <= self.r_118_threshold
		then
			self.wisp_caller = false
			self:SummonWisp(GetSectWispModifiedValue(self:GetParent(), self.r_118_health))
		end
		if G.attacker == self:GetParent() and self.sr_149_chance > 0 and self:PRD(self.sr_149_chance) then
			HealWisp(self:GetParent(), self:GetAbility(), GetSectWispModifiedValue(self:GetParent(), self.sr_149_heal))
			EachWisp(self:GetParent(), function(ag)
				local J = ParticleManager:CreateParticle(
					"particles/econ/items/wisp/calavera/io_calavera_relocate_teleport_out_arcs.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(J, 3, ag:GetAbsOrigin() + Vector(0, 0, 100))
			end)
			if #self.wisps > 0 then
				self:GetParent():EmitSound("Hero_KeeperOfTheLight.Wisp.Destroy")
			end
		end
	end
end
function H.prototype.OnBattleStartBefore(self, G)
	self.isBattleEnd = false
	self.n_66_timer = 0
	self.n_77_timer = 0
	self.n_87_timer = 0
	self.n_96_timer = 0
	self.n_130_timer = 0
	self.n_104_timer = 0
	self.n_111_timer = 0
	self.r_120_timer = 0
	self.trigger_timer = 0
	self.r_119_enable = self.r_119_factor > 0
	local u = self:GetParent()
	local ah = u:GetEnemy()
	if self.n_117_bonus > 0 and IsInjurable(ah) then
		ah:AddNewModifier(u, self:GetAbility(), "modifier_sect_wisp_n_117_debuff", {})
	end
	if self.r_191_health > 0 then
		u:AddNewModifier(u, self:GetAbility(), "modifier_sect_wisp_191_buff", nil)
	end
end
function H.prototype.GetWispTimerList(self)
	return {
		"heal_wisp",
		"ulti_wisp",
		"poison_wisp",
		"ice_wisp",
		"fury_wisp",
		"shield_wisp",
		"injury_wisp",
		"chaos_wisp",
		"archer_wisp",
		"trigger_interval",
	}
end
function H.prototype.GetWispInterval(self, ai)
	repeat
		local aj = ai
		local ak = aj == "heal_wisp"
		if ak then
			return self.n_66_interval
		end
		ak = ak or aj == "ulti_wisp"
		if ak then
			return self.n_77_interval
		end
		ak = ak or aj == "poison_wisp"
		if ak then
			return self.n_87_interval
		end
		ak = ak or aj == "ice_wisp"
		if ak then
			return self.n_96_interval
		end
		ak = ak or aj == "fury_wisp"
		if ak then
			return self.n_130_interval
		end
		ak = ak or aj == "shield_wisp"
		if ak then
			return self.n_104_interval
		end
		ak = ak or aj == "injury_wisp"
		if ak then
			return self.n_111_interval
		end
		ak = ak or aj == "chaos_wisp"
		if ak then
			return self.n_169_interval
		end
		ak = ak or aj == "archer_wisp"
		if ak then
			return self.r_120_interval
		end
		ak = ak or aj == "trigger_interval"
		if ak then
			return self.trigger_interval
		end
		do
			return 0
		end
	until true
end
function H.prototype.ReStartThink(self, al)
	local u = self:GetParent()
	local am = GetModifierProperty(u, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL) + self.custom_reduce
	if self.n_66_interval > 0 then
		self:StartThink(self.n_66_interval - am, "heal_wisp")
	end
	if self.n_77_interval > 0 then
		self:StartThink(self.n_77_interval - am, "ulti_wisp")
	end
	if self.n_87_interval > 0 then
		self:StartThink(self.n_87_interval - am, "poison_wisp")
	end
	if self.n_96_interval > 0 then
		self:StartThink(self.n_96_interval - am, "ice_wisp")
	end
	if self.n_130_interval > 0 then
		self:StartThink(self.n_130_interval - am, "fury_wisp")
	end
	if self.n_104_interval > 0 then
		self:StartThink(self.n_104_interval - am, "shield_wisp")
	end
	if self.n_111_interval > 0 then
		self:StartThink(self.n_111_interval - am, "injury_wisp")
	end
	if self.n_169_interval > 0 then
		self:StartThink(self.n_169_interval - am, "chaos_wisp")
	end
	if self.r_120_interval > 0 then
		self:StartThink(self.r_120_interval - am, "archer_wisp")
	end
	if self.r_118_threshold > 0 and al then
		self.wisp_caller = true
	end
	if self.trigger_interval > 0 then
		self:StartThink(self.trigger_interval, "trigger_interval")
	end
end
function H.prototype.OnBattleStart(self, G)
	local u = self:GetParent()
	if not HasState(u, EOMModifierStates.MODIFIER_STATE_WISP_DISARMED) then
		self:StartThink(GetWispAttackInterval(u), "wisp_attack")
		self:OnWispAttackStart()
	end
	if self.parentIsNeutral then
		local an = GameState:getState()
		if
			GameState:getStateName() == "GameState_ConfirmNeutral"
			or GameState:getStateName() == "GameState_Neutral"
		then
			local ao = an and an.neutralSectData
			local ap = i(h(ao), function(I, aq)
				return g(KeyValues.AbilityUpgradesKvs[aq].sect, "sect_wisp")
			end)
			if not ap then
				return
			end
		end
	else
		local L = PlayerData:getHero(u:GetPlayerOwnerID())
		local ar = false
		if L then
			local as = L:getAbilityData(true)
			local at = L:getTempAbilityUpgrade()
			local au = AbilityShop:getAbilityPoolNew(nil, "sect_wisp", nil, false)
			local av = false
			for aw, ax in pairs(at) do
				if au.tList[aw] then
					av = true
					break
				end
			end
			if as.sect_wisp == nil or as.sect_wisp.count == 0 and not av then
				ar = true
			end
		else
			ar = true
			debug.traceback(
				(("OnBattleStart: Hero Is Nil.\t PlayerID: " .. tostring(u:GetPlayerOwnerID())) .. "\t,Parent Name: ")
					.. u:GetUnitName()
			)
		end
		if ar then
			FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN, { success = false }, self.parent)
			return
		end
	end
	self:ReStartThink(true)
	local a4 = GetWispHealth(u, { first = true })
	local ay = self:SummonWisp(a4, nil, true)
	FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN, { success = true, wisp = ay }, self.parent)
	if self.sr_121_count > 0 then
		do
			local y = 0
			while y < self.sr_121_count do
				local az = a4 * GetSectWispModifiedValue(u, self.sr_121_factor / 100)
				self:SummonWisp(az)
				y = y + 1
			end
		end
	end
	self.effect_count = 0
end
function H.prototype.OnThink(self, aA)
	if self.isBattleEnd then
		return
	end
	if aA == "r_119_invulnerable" then
		self.r_119_invulnerable = false
		self:StartThink(-1, "r_119_invulnerable")
	else
		local aB = self:GetParent()
		local ah = aB:GetEnemy()
		local aC = self:GetAbility()
		local am = GetModifierProperty(aB, EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL) + self.custom_reduce
		if self.custom_reduce_changed[aA] then
			local aD = self:GetWispInterval(aA)
			if aD > 0 then
				self:StartThink(aD - am, aA)
				self.custom_reduce_changed[aA] = false
			end
		end
		if aA == "wisp_attack" then
			self:StartThink(GetWispAttackInterval(aB), "wisp_attack")
			if not HasState(self:GetParent(), EOMModifierStates.MODIFIER_STATE_CUSTOM_DOOM) then
				self:OnWispAttackStart()
			end
		else
			self:WispTimerEffect(aA)
		end
		if aA == "trigger_interval" then
			local w = self:GetWispList()
			for y = #w, 1, -1 do
				self:customAbilityTrigger()
			end
		end
	end
end
function H.prototype.GetWispList(self)
	for y = #self.wisps, 1, -1 do
		do
			local a2 = self.wisps[y]
			if a2 == nil then
				table.remove(self.wisps, y)
				goto aE
			end
		end
		::aE::
	end
	return self.wisps
end
function H.prototype.WispTimerEffect(self, aA)
	if aA == "heal_wisp" then
		self.ability:TriggerByName("66")
	end
	if aA == "ulti_wisp" then
		self.ability:TriggerByName("77")
	end
	if aA == "poison_wisp" then
		self.ability:TriggerByName("87")
	end
	if aA == "ice_wisp" then
		self.ability:TriggerByName("96")
	end
	if aA == "fury_wisp" then
		self.ability:TriggerByName("130")
	end
	if aA == "shield_wisp" then
		self.ability:TriggerByName("104")
	end
	if aA == "injury_wisp" then
		self.ability:TriggerByName("111")
	end
	if aA == "chaos_wisp" then
		self.ability:TriggerByName("169")
	end
	if aA == "archer_wisp" then
		self.ability:TriggerByName("120")
	end
end
function H.prototype.OnDestroy(self)
	if IsServer() then
		self:KillAllWisp()
	end
end
function H.prototype.KillAllWisp(self)
	for y = #self.wisps, 1, -1 do
		local a2 = self.wisps[y]
		if IsValid(a2.wisp) then
			a2.wisp:ForceKill(false)
		end
	end
	self.wisps = {}
end
function H.prototype.OnBattleEnd(self)
	self.isBattleEnd = true
	self:StartIntervalThink(-1)
	self:KillAllWisp()
end
function H.prototype.SummonWisp(self, a4, aF, aG, Y)
	local u = self:GetParent()
	local t = u:GetEnemy()
	if not IsInjurable(u, t) then
		return
	end
	local ab = self:GetAbility()
	local aH = t:GetAbsOrigin() - u:GetAbsOrigin()
	aH.z = 0
	aH = aH:Normalized()
	local aI = self.wispPositionList[self.wispPositionIndex + 1]
	aI.x = aI.x * aH.x
	local aJ = u:GetAbsOrigin() + aI
	self.wispPositionIndex = self.wispPositionIndex + 1
	if self.wispPositionIndex > #self.wispPositionList - 1 then
		self.wispPositionIndex = 0
	end
	local ag = CreateUnitFromTable({ MapUnitName = "npc_wisp", StatusHealth = a4, teamnumber = u:GetTeam() }, aJ)
	ag:SetForwardVector(aH)
	if not self.parentIsNeutral then
		local aK = Courier.wispSkin[u:GetPlayerOwnerID()]
		ag:AddNewModifier(u, ab, "modifier_sect_wisp_status", { wispSkinID = aK, IsFirst = aG })
	else
		ag:AddNewModifier(u, ab, "modifier_sect_wisp_status", {})
	end
	if ag and Y then
		Y(ag)
	end
	EmitSoundOn("Portal.Hero_Appear", ag)
	table.insert(self.wisps, { wisp = ag, health = a4, first = aG })
	self:IncrementStackCount()
	FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN, { wisp = ag, first = aG }, u, u)
	return ag
end
function H.prototype.doIntervalAction(self)
	local aB = self:GetParent()
	local ah = aB:GetEnemy()
	if not IsInjurable(aB, ah) then
		return
	end
	self.ability:TriggerByName("66")
	self.ability:TriggerByName("77")
	self.ability:TriggerByName("87")
	self.ability:TriggerByName("96")
	self.ability:TriggerByName("130")
	self.ability:TriggerByName("104")
	self.ability:TriggerByName("111")
	self.ability:TriggerByName("120")
end
function H.prototype.EOM_GetModifierAllBlockChance(self, G)
	if self.r_119_invulnerable then
		return 100
	end
end
function H.prototype.EOM_GetModifierWispScapegoat(self)
	if self.r_119_enable then
		return 1
	end
end
function H.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function H.prototype.EOM_GetModifierAvoidDamage(self, G)
	if not IsServer() then
		return
	end
	if GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_SCAPEGOAT) > 0 then
		local u = self:GetParent()
		if G.damage >= u:GetHealth() then
			local aL = 0
			local aM
			EachWisp(u, function(C)
				if IsValid(C) and not HasState(C, EOMModifierStates.MODIFIER_STATE_WISP_UNDEAD) then
					local aN = C:GetHealth()
					if aN > 0 and aN > aL then
						aL = aN
						aM = C
					end
				end
			end)
			if IsValid(aM) then
				KillWisp(u, aM, false)
				FireModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SCAPEGOAT, { wisp = aM }, u)
				self.r_119_enable = false
				return 1
			end
		end
	end
end
function H.prototype.OnWispScapegoat(self, G)
	self.r_119_invulnerable = true
	self:StartThink(FRAME_TIME, "r_119_invulnerable")
end
function H.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_wisp" then
		return
	end
	local aO = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
	if aO ~= nil then
		aO:customAbilityEffect()
	end
end
function H.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	self.effect_count = self.effect_count + 1
	if self.effect_count >= self.effect_value then
		self.effect_count = self.effect_count - self.effect_value
		TriggerAllWisp(self:GetParent())
	end
end
H = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	H
)
k.modifier_sect_wisp = H
k.modifier_sect_wisp_status = c()
local aP = k.modifier_sect_wisp_status
aP.name = "modifier_sect_wisp_status"
d(aP, p)
function aP.prototype.OnCreated(self, G)
	local u = self:GetParent()
	if IsServer() then
		self:SetHasCustomTransmitterData(true)
		self.modelScale = u:GetModelScale()
		self.modelName = "models/heroes/wisp/wisp.vmdl"
		local aQ = "particles/units/heroes/hero_wisp/wisp_ambient.vpcf"
		local aR = GetModifierProperty(
			self:GetCaster(),
			EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_OVERRIDE_MODEL_NAME,
			{ wisp = u, first = G.IsFirst == 1 }
		)
		local aS = GetModifierProperty(
			self:GetCaster(),
			EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_OVERRIDE_SPAWN_PARTICLE,
			{ wisp = u, first = G.IsFirst == 1 }
		)
		if aR then
			self.modelName = aR
		end
		if aS then
			aQ = aS
		end
		if G.wispSkinID ~= nil then
			local aT = KeyValues.CosmeticsKV[G.wispSkinID]
			if aT then
				if not aR then
					self.modelName = aT.resource
					self.modelScale = aT.model_scale
				end
				if not aS then
					aQ = aT.wisp_ambient
				end
			end
		end
		if type(aQ) == "string" then
			local J = ParticleManager:CreateParticle(aQ, PATTACH_CUSTOMORIGIN_FOLLOW, u)
			ParticleManager:SetParticleControlEnt(J, 0, u, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_invalid, true)
			ParticleManager:SetParticleControlEnt(J, 1, u, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_invalid, true)
			self:AddParticle(J, false, false, -1, false, false)
		end
		self:SendBuffRefreshToClients()
		self:StartIntervalThink(1)
	else
		local J = ParticleManager:CreateParticle(
			"particles/econ/items/meepo/meepo_colossal_crystal_chorus/meepo_divining_rod_poof_end.vpcf",
			PATTACH_ABSORIGIN,
			u
		)
		self:AddParticle(J, false, false, -1, false, false)
		if self:GetSectSpecialValueFor("149", "sr_149_damage") > 0 then
			local aU = ParticleManager:CreateParticle(
				"particles/econ/items/wisp/calavera/io_calavera_tether.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(
				aU,
				0,
				u,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControlEnt(
				aU,
				1,
				self:GetCaster(),
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u:GetAbsOrigin(),
				false
			)
			self:AddParticle(aU, false, false, -1, false, false)
		end
	end
end
function aP.prototype.OnIntervalThink(self)
	local aV = self:GetCaster()
	local aW = GetWispRegen(aV)
	if aW > 0 then
		HealWisp(aV, self:GetAbility(), aW)
	end
end
function aP.prototype.CheckState(self)
	return { [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true, [MODIFIER_STATE_OUT_OF_GAME] = true }
end
function aP.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_MODEL_SCALE }
end
function aP.prototype.AddCustomTransmitterData(self)
	return { modelName = self.modelName, modelScale = self.modelScale }
end
function aP.prototype.HandleCustomTransmitterData(self, ao)
	self.modelName = ao.modelName
	self.modelScale = ao.modelScale
end
function aP.prototype.GetModifierModelChange(self)
	local aX = self.modelName
	if aX == nil then
		aX = "models/heroes/wisp/wisp.vmdl"
	end
	return aX
end
function aP.prototype.GetModifierModelScale(self)
	return self.modelScale or 1
end
function aP.prototype.GetModifierProjectileName(self)
	return "models/eom/courier/hunshamaoniang_1/particles/attack/hunshamaoniang_base_attack_1.vpcf"
end
aP = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	aP
)
k.modifier_sect_wisp_status = aP
k.modifier_sect_wisp_n_117_bonus = c()
local aY = k.modifier_sect_wisp_n_117_bonus
aY.name = "modifier_sect_wisp_n_117_bonus"
d(aY, p)
function aY.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_DAMAGE_OUTGOING_TO_WISP }
end
function aY.prototype.EOM_GetModifierDamageOutgoingToWisp(self, G)
	return self:GetStackCount()
end
aY = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = true, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	aY
)
k.modifier_sect_wisp_n_117_bonus = aY
k.modifier_sect_wisp_n_117_debuff = c()
local aZ = k.modifier_sect_wisp_n_117_debuff
aZ.name = "modifier_sect_wisp_n_117_debuff"
d(aZ, p)
function aZ.prototype.GetAbilitySpecialValue(self)
	self.n_117_bonus = self:GetSectSpecialValueFor("117", "n_117_bonus")
end
function aZ.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_SECT_GAIN_PERCENTAGE] = -self.n_117_bonus }
end
aZ = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = true, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	aZ
)
k.modifier_sect_wisp_n_117_debuff = aZ
k.modifier_sect_wisp_191_buff = c()
local a_ = k.modifier_sect_wisp_191_buff
a_.name = "modifier_sect_wisp_191_buff"
d(a_, p)
function a_.prototype.GetAbilitySpecialValue(self)
	self.r_191_health = self:GetSectSpecialValueFor("191", "r_191_health")
end
function a_.prototype.OnCreated(self, G)
	if IsServer() then
		self:SetStackCount(Round(GetWispHealth(self:GetParent()) * self.r_191_health * 0.01))
	end
end
function a_.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function a_.prototype.EOM_GetModifierHealthBonus(self, G)
	return self:GetStackCount()
end
a_ = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = true, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a_
)
k.modifier_sect_wisp_191_buff = a_
return k