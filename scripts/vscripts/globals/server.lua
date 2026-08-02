--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "globals/server"
local b = require("lualib_bundle")
local c = b.__TS__StringReplace
local d = b.__TS__StringSplit
local e = b.__TS__ArrayIndexOf
local f = b.__TS__ArrayIsArray
local g = b.__TS__ArrayForEach
local h = b.__TS__ArraySplice
local i = b.__TS__Delete
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["17"] = 89,
		["18"] = 90,
		["19"] = 89,
		["26"] = 101,
		["27"] = 102,
		["28"] = 101,
		["32"] = 108,
		["33"] = 109,
		["34"] = 108,
		["40"] = 128,
		["41"] = 129,
		["42"] = 130,
		["43"] = 130,
		["44"] = 130,
		["45"] = 131,
		["46"] = 132,
		["48"] = 134,
		["49"] = 130,
		["50"] = 130,
		["51"] = 136,
		["52"] = 137,
		["53"] = 128,
		["59"] = 156,
		["60"] = 157,
		["61"] = 158,
		["62"] = 158,
		["63"] = 158,
		["64"] = 159,
		["65"] = 160,
		["67"] = 162,
		["68"] = 158,
		["69"] = 158,
		["70"] = 164,
		["71"] = 165,
		["72"] = 156,
		["76"] = 172,
		["77"] = 173,
		["78"] = 174,
		["79"] = 175,
		["80"] = 175,
		["81"] = 175,
		["82"] = 176,
		["83"] = 175,
		["84"] = 175,
		["85"] = 178,
		["87"] = 172,
		["97"] = 195,
		["98"] = 196,
		["99"] = 197,
		["100"] = 197,
		["101"] = 197,
		["102"] = 197,
		["103"] = 197,
		["104"] = 197,
		["105"] = 197,
		["106"] = 204,
		["107"] = 205,
		["109"] = 207,
		["110"] = 208,
		["111"] = 209,
		["112"] = 210,
		["113"] = 211,
		["115"] = 213,
		["117"] = 215,
		["118"] = 216,
		["120"] = 218,
		["123"] = 221,
		["124"] = 222,
		["127"] = 225,
		["128"] = 226,
		["129"] = 227,
		["130"] = 228,
		["131"] = 229,
		["134"] = 233,
		["136"] = 235,
		["137"] = 195,
		["138"] = 238,
		["139"] = 239,
		["141"] = 241,
		["142"] = 247,
		["143"] = 247,
		["144"] = 247,
		["145"] = 247,
		["146"] = 247,
		["147"] = 247,
		["148"] = 247,
		["149"] = 247,
		["150"] = 241,
		["151"] = 250,
		["152"] = 251,
		["154"] = 253,
		["155"] = 254,
		["156"] = 255,
		["157"] = 254,
		["158"] = 253,
		["165"] = 266,
		["166"] = 267,
		["167"] = 268,
		["168"] = 269,
		["169"] = 270,
		["170"] = 271,
		["172"] = 273,
		["173"] = 274,
		["174"] = 275,
		["175"] = 276,
		["176"] = 277,
		["177"] = 278,
		["178"] = 279,
		["179"] = 280,
		["181"] = 282,
		["183"] = 284,
		["186"] = 288,
		["187"] = 289,
		["190"] = 266,
		["196"] = 300,
		["197"] = 301,
		["200"] = 302,
		["201"] = 303,
		["202"] = 304,
		["203"] = 305,
		["204"] = 306,
		["205"] = 307,
		["209"] = 300,
		["215"] = 319,
		["216"] = 320,
		["219"] = 321,
		["220"] = 322,
		["221"] = 323,
		["222"] = 324,
		["223"] = 325,
		["224"] = 326,
		["228"] = 319,
		["241"] = 345,
		["242"] = 345,
		["243"] = 345,
		["245"] = 346,
		["246"] = 346,
		["247"] = 346,
		["248"] = 346,
		["249"] = 346,
		["250"] = 346,
		["251"] = 346,
		["252"] = 346,
		["253"] = 346,
		["254"] = 346,
		["255"] = 346,
		["256"] = 347,
		["257"] = 348,
		["258"] = 349,
		["259"] = 350,
		["262"] = 353,
		["265"] = 357,
		["266"] = 359,
		["267"] = 360,
		["268"] = 361,
		["269"] = 362,
		["270"] = 363,
		["271"] = 364,
		["272"] = 364,
		["274"] = 365,
		["275"] = 367,
		["276"] = 368,
		["277"] = 368,
		["278"] = 368,
		["279"] = 368,
		["280"] = 369,
		["284"] = 373,
		["285"] = 374,
		["286"] = 375,
		["289"] = 379,
		["290"] = 345,
		["303"] = 395,
		["304"] = 395,
		["305"] = 395,
		["307"] = 396,
		["308"] = 396,
		["309"] = 396,
		["310"] = 396,
		["311"] = 396,
		["312"] = 396,
		["313"] = 396,
		["314"] = 396,
		["315"] = 396,
		["316"] = 396,
		["317"] = 396,
		["318"] = 397,
		["319"] = 398,
		["320"] = 399,
		["321"] = 400,
		["324"] = 403,
		["327"] = 407,
		["328"] = 409,
		["329"] = 410,
		["330"] = 411,
		["331"] = 412,
		["332"] = 412,
		["333"] = 412,
		["334"] = 412,
		["335"] = 413,
		["336"] = 414,
		["337"] = 415,
		["338"] = 416,
		["339"] = 416,
		["340"] = 416,
		["341"] = 416,
		["342"] = 416,
		["343"] = 416,
		["344"] = 416,
		["345"] = 416,
		["346"] = 417,
		["347"] = 415,
		["348"] = 420,
		["349"] = 421,
		["350"] = 422,
		["351"] = 422,
		["352"] = 422,
		["353"] = 422,
		["354"] = 422,
		["355"] = 422,
		["356"] = 422,
		["357"] = 422,
		["358"] = 423,
		["359"] = 425,
		["360"] = 426,
		["361"] = 427,
		["362"] = 428,
		["363"] = 429,
		["364"] = 430,
		["365"] = 431,
		["366"] = 432,
		["368"] = 434,
		["369"] = 434,
		["370"] = 434,
		["371"] = 434,
		["372"] = 435,
		["373"] = 435,
		["374"] = 435,
		["375"] = 435,
		["376"] = 435,
		["377"] = 436,
		["378"] = 440,
		["379"] = 440,
		["380"] = 440,
		["381"] = 441,
		["382"] = 442,
		["384"] = 440,
		["385"] = 440,
		["390"] = 450,
		["391"] = 451,
		["392"] = 452,
		["393"] = 453,
		["394"] = 454,
		["395"] = 456,
		["396"] = 457,
		["397"] = 457,
		["398"] = 457,
		["399"] = 457,
		["400"] = 458,
		["403"] = 461,
		["404"] = 462,
		["405"] = 463,
		["408"] = 467,
		["409"] = 468,
		["410"] = 469,
		["411"] = 470,
		["412"] = 470,
		["413"] = 470,
		["414"] = 470,
		["417"] = 475,
		["418"] = 476,
		["420"] = 479,
		["421"] = 395,
		["435"] = 496,
		["436"] = 496,
		["437"] = 496,
		["439"] = 497,
		["440"] = 497,
		["441"] = 497,
		["442"] = 497,
		["443"] = 497,
		["444"] = 497,
		["445"] = 497,
		["446"] = 497,
		["447"] = 497,
		["448"] = 497,
		["449"] = 497,
		["450"] = 498,
		["451"] = 499,
		["452"] = 500,
		["453"] = 501,
		["456"] = 504,
		["459"] = 508,
		["460"] = 510,
		["461"] = 511,
		["462"] = 512,
		["463"] = 513,
		["464"] = 514,
		["465"] = 515,
		["466"] = 516,
		["467"] = 526,
		["468"] = 516,
		["469"] = 528,
		["470"] = 529,
		["471"] = 530,
		["472"] = 532,
		["473"] = 533,
		["474"] = 534,
		["475"] = 535,
		["476"] = 536,
		["477"] = 537,
		["478"] = 538,
		["479"] = 539,
		["480"] = 539,
		["481"] = 539,
		["482"] = 539,
		["483"] = 539,
		["484"] = 540,
		["485"] = 541,
		["486"] = 541,
		["487"] = 541,
		["488"] = 541,
		["489"] = 541,
		["490"] = 541,
		["491"] = 541,
		["492"] = 548,
		["493"] = 548,
		["494"] = 548,
		["495"] = 548,
		["496"] = 548,
		["497"] = 548,
		["498"] = 548,
		["499"] = 548,
		["500"] = 548,
		["501"] = 548,
		["502"] = 548,
		["503"] = 548,
		["504"] = 548,
		["505"] = 549,
		["508"] = 552,
		["509"] = 553,
		["510"] = 554,
		["511"] = 554,
		["512"] = 554,
		["513"] = 554,
		["514"] = 554,
		["515"] = 555,
		["516"] = 556,
		["517"] = 556,
		["518"] = 556,
		["519"] = 556,
		["520"] = 556,
		["521"] = 556,
		["522"] = 556,
		["523"] = 563,
		["525"] = 566,
		["526"] = 567,
		["527"] = 568,
		["528"] = 569,
		["529"] = 570,
		["530"] = 572,
		["531"] = 573,
		["532"] = 573,
		["533"] = 573,
		["534"] = 573,
		["535"] = 573,
		["536"] = 573,
		["537"] = 573,
		["538"] = 574,
		["541"] = 577,
		["542"] = 578,
		["543"] = 579,
		["547"] = 584,
		["548"] = 585,
		["550"] = 588,
		["551"] = 496,
		["565"] = 605,
		["566"] = 605,
		["567"] = 605,
		["569"] = 606,
		["570"] = 606,
		["571"] = 606,
		["572"] = 606,
		["573"] = 606,
		["574"] = 606,
		["575"] = 606,
		["576"] = 606,
		["577"] = 606,
		["578"] = 606,
		["579"] = 606,
		["580"] = 608,
		["581"] = 609,
		["583"] = 612,
		["584"] = 614,
		["585"] = 615,
		["586"] = 616,
		["589"] = 620,
		["590"] = 621,
		["591"] = 623,
		["592"] = 624,
		["594"] = 626,
		["596"] = 605,
		["608"] = 642,
		["609"] = 642,
		["610"] = 642,
		["612"] = 642,
		["613"] = 642,
		["615"] = 642,
		["616"] = 642,
		["618"] = 643,
		["619"] = 643,
		["620"] = 643,
		["621"] = 643,
		["622"] = 643,
		["623"] = 643,
		["624"] = 643,
		["625"] = 643,
		["626"] = 643,
		["627"] = 643,
		["628"] = 644,
		["629"] = 645,
		["630"] = 646,
		["631"] = 647,
		["632"] = 649,
		["633"] = 650,
		["634"] = 650,
		["635"] = 650,
		["636"] = 650,
		["637"] = 650,
		["638"] = 651,
		["639"] = 657,
		["640"] = 657,
		["641"] = 657,
		["642"] = 657,
		["643"] = 657,
		["644"] = 657,
		["645"] = 657,
		["646"] = 657,
		["647"] = 657,
		["648"] = 658,
		["649"] = 658,
		["650"] = 658,
		["651"] = 658,
		["652"] = 658,
		["653"] = 658,
		["654"] = 658,
		["655"] = 658,
		["656"] = 658,
		["657"] = 659,
		["658"] = 659,
		["659"] = 659,
		["660"] = 659,
		["661"] = 659,
		["662"] = 659,
		["663"] = 659,
		["664"] = 659,
		["665"] = 659,
		["666"] = 660,
		["667"] = 660,
		["668"] = 660,
		["669"] = 660,
		["670"] = 660,
		["671"] = 660,
		["672"] = 660,
		["673"] = 660,
		["674"] = 660,
		["675"] = 661,
		["676"] = 662,
		["677"] = 662,
		["678"] = 662,
		["679"] = 662,
		["680"] = 662,
		["681"] = 662,
		["682"] = 662,
		["683"] = 662,
		["684"] = 662,
		["685"] = 662,
		["686"] = 662,
		["687"] = 663,
		["688"] = 664,
		["689"] = 665,
		["690"] = 666,
		["691"] = 666,
		["692"] = 666,
		["693"] = 666,
		["694"] = 667,
		["700"] = 642,
		["713"] = 686,
		["714"] = 687,
		["715"] = 688,
		["716"] = 688,
		["717"] = 688,
		["718"] = 688,
		["719"] = 688,
		["720"] = 688,
		["721"] = 688,
		["722"] = 688,
		["723"] = 688,
		["724"] = 688,
		["725"] = 688,
		["726"] = 689,
		["727"] = 690,
		["728"] = 691,
		["729"] = 692,
		["730"] = 693,
		["731"] = 694,
		["732"] = 695,
		["733"] = 696,
		["736"] = 699,
		["737"] = 686,
		["747"] = 712,
		["748"] = 712,
		["749"] = 712,
		["751"] = 713,
		["752"] = 714,
		["753"] = 715,
		["754"] = 715,
		["755"] = 715,
		["756"] = 715,
		["757"] = 715,
		["758"] = 715,
		["759"] = 721,
		["760"] = 721,
		["761"] = 721,
		["762"] = 721,
		["763"] = 721,
		["764"] = 721,
		["765"] = 721,
		["766"] = 721,
		["767"] = 721,
		["768"] = 721,
		["769"] = 721,
		["770"] = 722,
		["771"] = 723,
		["772"] = 724,
		["773"] = 724,
		["774"] = 724,
		["775"] = 724,
		["776"] = 725,
		["779"] = 728,
		["780"] = 712,
		["789"] = 740,
		["790"] = 740,
		["791"] = 740,
		["793"] = 741,
		["794"] = 741,
		["796"] = 742,
		["797"] = 742,
		["798"] = 742,
		["799"] = 742,
		["800"] = 742,
		["801"] = 742,
		["802"] = 742,
		["803"] = 742,
		["804"] = 742,
		["805"] = 742,
		["806"] = 740,
		["815"] = 754,
		["816"] = 754,
		["817"] = 754,
		["819"] = 754,
		["820"] = 754,
		["822"] = 755,
		["823"] = 755,
		["825"] = 756,
		["826"] = 756,
		["827"] = 756,
		["828"] = 756,
		["829"] = 756,
		["830"] = 756,
		["831"] = 756,
		["832"] = 756,
		["833"] = 756,
		["834"] = 756,
		["835"] = 756,
		["836"] = 754,
		["840"] = 763,
		["841"] = 764,
		["842"] = 764,
		["844"] = 765,
		["845"] = 765,
		["847"] = 766,
		["848"] = 763,
		["850"] = 770,
		["851"] = 770,
		["852"] = 770,
		["853"] = 770,
		["854"] = 770,
		["855"] = 770,
		["856"] = 770,
		["857"] = 770,
		["858"] = 770,
		["859"] = 789,
		["860"] = 790,
		["862"] = 792,
		["863"] = 793,
		["864"] = 793,
		["866"] = 794,
		["867"] = 796,
		["868"] = 796,
		["870"] = 797,
		["871"] = 799,
		["872"] = 792,
		["878"] = 807,
		["879"] = 807,
		["880"] = 808,
		["881"] = 809,
		["882"] = 809,
		["884"] = 810,
		["885"] = 811,
		["886"] = 812,
		["889"] = 815,
		["890"] = 807,
		["894"] = 821,
		["895"] = 822,
		["896"] = 822,
		["898"] = 823,
		["899"] = 823,
		["901"] = 825,
		["902"] = 826,
		["904"] = 821,
		["908"] = 833,
		["909"] = 834,
		["910"] = 834,
		["912"] = 835,
		["913"] = 835,
		["915"] = 837,
		["916"] = 838,
		["918"] = 833,
		["920"] = 843,
		["921"] = 843,
		["922"] = 843,
		["923"] = 843,
		["924"] = 843,
		["925"] = 843,
		["926"] = 843,
		["927"] = 843,
		["928"] = 843,
		["929"] = 843,
		["930"] = 843,
		["931"] = 843,
		["932"] = 843,
		["933"] = 843,
		["934"] = 843,
		["935"] = 843,
		["936"] = 843,
		["937"] = 843,
		["938"] = 843,
		["939"] = 843,
		["940"] = 843,
		["941"] = 887,
		["942"] = 887,
		["943"] = 887,
		["945"] = 888,
		["946"] = 889,
		["947"] = 890,
		["948"] = 891,
		["949"] = 892,
		["950"] = 893,
		["951"] = 894,
		["952"] = 895,
		["953"] = 897,
		["954"] = 897,
		["956"] = 898,
		["957"] = 934,
		["958"] = 934,
		["959"] = 934,
		["960"] = 934,
		["961"] = 934,
		["962"] = 934,
		["963"] = 934,
		["964"] = 934,
		["965"] = 934,
		["966"] = 934,
		["967"] = 936,
		["968"] = 887,
		["974"] = 945,
		["975"] = 945,
		["976"] = 946,
		["977"] = 947,
		["978"] = 947,
		["980"] = 948,
		["981"] = 949,
		["982"] = 950,
		["985"] = 953,
		["986"] = 945,
		["987"] = 959,
		["988"] = 960,
		["989"] = 959,
		["990"] = 962,
		["991"] = 963,
		["993"] = 965,
		["994"] = 966,
		["995"] = 966,
		["997"] = 968,
		["998"] = 970,
		["999"] = 971,
		["1001"] = 965,
		["1002"] = 974,
		["1003"] = 975,
		["1004"] = 975,
		["1006"] = 977,
		["1007"] = 977,
		["1008"] = 979,
		["1009"] = 974,
		["1010"] = 981,
		["1011"] = 982,
		["1012"] = 982,
		["1014"] = 984,
		["1015"] = 986,
		["1016"] = 981,
		["1017"] = 988,
		["1018"] = 990,
		["1019"] = 988,
		["1020"] = 993,
		["1021"] = 994,
		["1022"] = 995,
		["1023"] = 996,
		["1024"] = 997,
		["1025"] = 998,
		["1026"] = 1000,
		["1027"] = 993,
		["1028"] = 1002,
		["1029"] = 1003,
		["1030"] = 1004,
		["1031"] = 1006,
		["1033"] = 1002,
		["1034"] = 1009,
		["1035"] = 1010,
		["1037"] = 1012,
		["1038"] = 1013,
		["1039"] = 1014,
		["1040"] = 1015,
		["1041"] = 1016,
		["1042"] = 1017,
		["1043"] = 1018,
		["1044"] = 1019,
		["1046"] = 1021,
		["1047"] = 1022,
		["1048"] = 1023,
		["1049"] = 1024,
		["1051"] = 1026,
		["1052"] = 1027,
		["1053"] = 1028,
		["1055"] = 1030,
		["1056"] = 1031,
		["1057"] = 1032,
		["1058"] = 1033,
		["1059"] = 1034,
		["1060"] = 1035,
		["1063"] = 1038,
		["1065"] = 1040,
		["1066"] = 1041,
		["1068"] = 1043,
		["1069"] = 1044,
		["1071"] = 1046,
		["1072"] = 1012,
		["1073"] = 1049,
		["1074"] = 1050,
		["1076"] = 1052,
		["1077"] = 1053,
		["1078"] = 1054,
		["1079"] = 1055,
		["1080"] = 1056,
		["1081"] = 1057,
		["1083"] = 1059,
		["1085"] = 1061,
		["1086"] = 1052,
		["1087"] = 1063,
		["1088"] = 1064,
		["1090"] = 1066,
		["1091"] = 1066,
		["1092"] = 1066,
		["1094"] = 1067,
		["1095"] = 1068,
		["1096"] = 1069,
		["1097"] = 1070,
		["1098"] = 1071,
		["1099"] = 1072,
		["1100"] = 1072,
		["1101"] = 1072,
		["1102"] = 1072,
		["1103"] = 1072,
		["1104"] = 1072,
		["1105"] = 1072,
		["1109"] = 1066,
		["1110"] = 1078,
		["1111"] = 1079,
		["1112"] = 1078,
		["1113"] = 1082,
		["1114"] = 1083,
		["1115"] = 1082,
		["1116"] = 1085,
		["1117"] = 1086,
		["1118"] = 1086,
		["1119"] = 1086,
		["1120"] = 1087,
		["1123"] = 1088,
		["1124"] = 1089,
		["1125"] = 1086,
		["1126"] = 1086,
		["1127"] = 1085,
		["1128"] = 1093,
		["1129"] = 1094,
		["1130"] = 1093,
		["1131"] = 1097,
		["1132"] = 1098,
		["1133"] = 1099,
		["1134"] = 1100,
		["1135"] = 1101,
		["1136"] = 1102,
		["1139"] = 1097,
		["1140"] = 1110,
		["1141"] = 1111,
		["1142"] = 1110,
		["1143"] = 1117,
		["1144"] = 1118,
		["1145"] = 1119,
		["1146"] = 1119,
		["1147"] = 1119,
		["1148"] = 1119,
		["1149"] = 1122,
		["1151"] = 1117,
		["1157"] = 1132,
		["1158"] = 1132,
		["1159"] = 1132,
		["1161"] = 1133,
		["1162"] = 1134,
		["1164"] = 1136,
		["1165"] = 1137,
		["1166"] = 1138,
		["1169"] = 1132,
		["1174"] = 1148,
		["1175"] = 1149,
		["1176"] = 1150,
		["1177"] = 1152,
		["1178"] = 1154,
		["1180"] = 1157,
		["1181"] = 1158,
		["1182"] = 1160,
		["1183"] = 1161,
		["1184"] = 1162,
		["1186"] = 1165,
		["1187"] = 1166,
		["1188"] = 1167,
		["1189"] = 1168,
		["1191"] = 1170,
		["1196"] = 1175,
		["1197"] = 1176,
		["1199"] = 1178,
		["1200"] = 1179,
		["1201"] = 1180,
		["1202"] = 1181,
		["1205"] = 1148,
		["1206"] = 1186,
		["1207"] = 1187,
		["1208"] = 1188,
		["1209"] = 1189,
		["1210"] = 1191,
		["1211"] = 1192,
		["1212"] = 1194,
		["1213"] = 1195,
		["1214"] = 1197,
		["1215"] = 1198,
		["1216"] = 1199,
		["1217"] = 1201,
		["1218"] = 1202,
		["1219"] = 1203,
		["1221"] = 1205,
		["1222"] = 1206,
		["1223"] = 1207,
		["1225"] = 1210,
		["1226"] = 1211,
		["1227"] = 1186,
		["1228"] = 1213,
		["1229"] = 1214,
		["1231"] = 1216,
		["1232"] = 1217,
		["1233"] = 1218,
		["1234"] = 1219,
		["1236"] = 1221,
		["1237"] = 1221,
		["1238"] = 1221,
		["1239"] = 1221,
		["1240"] = 1221,
		["1241"] = 1216,
		["1242"] = 1227,
		["1243"] = 1228,
		["1245"] = 1230,
		["1246"] = 1231,
		["1247"] = 1232,
		["1248"] = 1233,
		["1249"] = 1234,
		["1251"] = 1236,
		["1254"] = 1239,
		["1256"] = 1241,
		["1257"] = 1241,
		["1258"] = 1241,
		["1259"] = 1241,
		["1260"] = 1241,
		["1261"] = 1241,
		["1262"] = 1241,
		["1263"] = 1230,
	}
)
function Timer(k, l, m)
	return GameRules:GetGameModeEntity():Timer(k, l, m)
end
function GameTimer(k, l, m)
	return GameRules:GetGameModeEntity():GameTimer(k, l, m)
end
function StopTimer(k)
	return GameRules:GetGameModeEntity():StopTimer(k)
end
function TimerEvent(l, n, o)
	local p = GameRules:GetGameModeEntity()
	local q = p:Timer(l, function()
		if o ~= nil then
			return n(o)
		end
		return n()
	end)
	TimerEventListenerIDs[#TimerEventListenerIDs + 1] = q
	return q
end
function GameTimerEvent(l, n, o)
	local p = GameRules:GetGameModeEntity()
	local q = p:GameTimer(l, function()
		if o ~= nil then
			return n(o)
		end
		return n()
	end)
	TimerEventListenerIDs[#TimerEventListenerIDs + 1] = q
	return q
end
function Sleep(r)
	local s = coroutine.running()
	if s then
		Timer(r, function()
			assert({ coroutine.resume(s) })
		end)
		coroutine.yield()
	end
end
function CreateUnitByNameWithNewData(t, u, v, w, x, y, z)
	local A = w or x
	local B = {
		MapUnitName = t,
		teamnumber = y,
		vscripts = "units/common.lua",
		origin = (((tostring(u.x) .. " ") .. tostring(u.y)) .. " ") .. tostring(u.z),
		NeverMoveToClearSpace = not v,
	}
	if IsValid(A) then
		B.iOwnerIndex = A:entindex()
	end
	if z ~= nil then
		local q
		for C, D in pairs(z) do
			if C == "StatusHealth" then
				B.StatusHealth = D
			else
				B[C] = D
			end
			if q == nil then
				q = C
			else
				q = (q .. ",") .. C
			end
		end
		if q then
			B.OverrideKeys = q
		end
	end
	local E = CreateUnitFromTable(B, u)
	if IsValid(E) then
		E:SetNeverMoveToClearSpace(false)
		if v then
			FindClearSpaceForUnit(E, u, true)
		end
	else
		print("<!> CreateUnitByNameWithNewData FAILED: " .. t)
	end
	return E
end
if CreateUnitByName_Engine == nil then
	CreateUnitByName_Engine = CreateUnitByName
end
_G.CreateUnitByName = function(t, u, v, w, x, y)
	return CreateUnitByNameWithNewData(t, u, v, w, x, y)
end
if EmitSoundOnLocationWithCaster_Engine == nil then
	EmitSoundOnLocationWithCaster_Engine = EmitSoundOnLocationWithCaster
end
_G.EmitSoundOnLocationWithCaster = function(F, G, H)
	Game:EachPlayer(function(I, J)
		EmitSoundOnLocationForPlayer(G, F, J)
	end)
end
function GetUnitLabelWithNewLabel(t, K, z)
	local L
	if z ~= nil and type(z.UnitLabel) == "string" then
		L = z.UnitLabel
	elseif KeyValues ~= nil and type(KeyValues.GetUnitData) == "function" then
		L = KeyValues:GetUnitData(t, "UnitLabel")
	end
	if L ~= nil then
		if K ~= nil and K ~= "" then
			K = string.lower(K)
			local q = string.lower(L)
			q = c(q, "%s", "")
			local M = d(q, ",")
			if e(M, K) == -1 then
				M[#M + 1] = K
			end
			return table.concat(M, ",")
		else
			return L
		end
	else
		if K ~= nil and K ~= "" then
			return string.lower(K)
		end
	end
end
function GetEmptyAbilitySlot(t, z)
	if KeyValues == nil or type(KeyValues.GetUnitData) ~= "function" or KeyValues.AbilitiesKv == nil then
		return
	end
	for N = 1, 32, 1 do
		local O = "Ability" .. tostring(N)
		local P = KeyValues:GetUnitData(t, O)
		if P == nil or type(KeyValues.AbilitiesKv[P]) ~= "table" then
			if z == nil or type(KeyValues.AbilitiesKv[z[O]]) ~= "table" then
				return O
			end
		end
	end
end
function GetEmptyDropItemSlot(t, z)
	if KeyValues == nil or type(KeyValues.GetUnitData) ~= "function" then
		return
	end
	for N = 1, 10, 1 do
		local O = "DropItem" .. tostring(N)
		local Q = KeyValues:GetUnitData(t, O)
		if Q == nil then
			if z == nil or z[O] == nil then
				return O
			end
		end
	end
end
function GetAOEMostTargetsSpellTarget(R, S, y, T, U, V, W, X, Y)
	if X == nil then
		X = FIND_ANY_ORDER
	end
	local Z = FindUnitsInRadius(y, R, nil, S + T, U, V, W, X, false)
	if Y ~= nil then
		if f(Y) then
			for N = 0, #Y - 1, 1 do
				ArrayRemove(Z, Y[N + 1])
			end
		else
			ArrayRemove(Z, Y)
		end
	end
	local _
	local a0 = 0
	for N = 0, #Z - 1, 1 do
		local a1 = Z[N + 1]
		local a2 = 0
		if a1:IsPositionInRange(R, S) then
			if _ == nil then
				_ = a1
			end
			for a3 = 0, #Z - 1, 1 do
				local a4 = Z[a3 + 1]
				if a4:IsPositionInRange(a1:GetAbsOrigin(), T + a4:GetHullRadius()) then
					a2 = a2 + 1
				end
			end
		end
		if a2 > a0 then
			_ = a1
			a0 = a2
		end
	end
	return _
end
function GetAOEMostTargetsPosition(R, S, y, T, U, V, W, X, Y)
	if X == nil then
		X = FIND_ANY_ORDER
	end
	local Z = FindUnitsInRadius(y, R, nil, S + T, U, V, W, X, false)
	if Y ~= nil then
		if f(Y) then
			for N = 0, #Y - 1, 1 do
				ArrayRemove(Z, Y[N + 1])
			end
		else
			ArrayRemove(Z, Y)
		end
	end
	local a5 = vec3_invalid
	if #Z == 1 then
		local a6 = Z[1]:GetAbsOrigin() - R
		a6.z = 0
		a5 = R + a6:Normalized() * math.min(S - 1, a6:Length2D())
	elseif #Z > 1 then
		local a7 = {}
		local function a8(a9)
			DebugDrawCircle(GetGroundPosition(a9, nil), Vector(0, 0, 255), 32, 32, true, 0.5)
			a7[#a7 + 1] = a9
		end
		for N = 0, #Z - 1, 1 do
			local a1 = Z[N + 1]
			DebugDrawCircle(a1:GetAbsOrigin(), Vector(0, 255, 0), 32, T, false, 0.5)
			for a3 = N + 1, #Z - 1, 1 do
				local a4 = Z[a3 + 1]
				local a6 = a4:GetAbsOrigin() - a1:GetAbsOrigin()
				a6.z = 0
				local aa = a6:Length2D()
				if aa <= T * 2 and aa > 0 then
					local ab = (a4:GetAbsOrigin() + a1:GetAbsOrigin()) / 2
					if (ab - R):Length2D() <= S then
						a8(ab)
					else
						local ac = math.sqrt(bit.bxor(bit.bxor(T, 2 - aa / 2), 2))
						local D = RotatePosition(vec3_zero, QAngle(0, 90, 0), a6:Normalized()) * ac
						local ad = { ab - D, ab + D }
						g(ad, function(I, a9)
							if (a9 - R):Length2D() <= S then
								a8(a9)
							end
						end)
					end
				end
			end
		end
		local a0 = 0
		for N = 0, #a7 - 1, 1 do
			local a9 = a7[N + 1]
			local a2 = 0
			for a3 = 0, #Z - 1, 1 do
				local _ = Z[a3 + 1]
				if _:IsPositionInRange(a9, T + _:GetHullRadius()) then
					a2 = a2 + 1
				end
			end
			if a2 > a0 then
				a5 = a9
				a0 = a2
			end
		end
		if a5 == vec3_invalid then
			local a6 = Z[2]:GetAbsOrigin() - R
			a6.z = 0
			a5 = R + a6:Normalized() * math.min(S - 1, a6:Length2D())
		end
	end
	if a5 ~= vec3_invalid then
		a5 = GetGroundPosition(a5, nil)
	end
	return a5
end
function GetLinearMostTargetsPosition(R, S, y, ae, af, U, V, W, X, Y)
	if X == nil then
		X = FIND_ANY_ORDER
	end
	local Z = FindUnitsInRadius(y, R, nil, S + af, U, V, W, X, false)
	if Y ~= nil then
		if f(Y) then
			for N = 0, #Y - 1, 1 do
				ArrayRemove(Z, Y[N + 1])
			end
		else
			ArrayRemove(Z, Y)
		end
	end
	local a5 = vec3_invalid
	if #Z == 1 then
		local a6 = Z[2]:GetAbsOrigin() - R
		a6.z = 0
		a5 = R + a6:Normalized() * (S - 1)
	elseif #Z > 1 then
		local ag = {}
		local function ah(ai)
			ag[#ag + 1] = ai
		end
		for N = 0, #Z - 1, 1 do
			local a1 = Z[N + 1]
			for a3 = N + 1, #Z - 1, 1 do
				local a4 = Z[a3 + 1]
				local aj = a1:GetAbsOrigin() - R
				aj.z = 0
				local ak = a4:GetAbsOrigin() - R
				ak.z = 0
				local a6 = (aj + ak) / 2
				a6.z = 0
				local D = RotatePosition(vec3_zero, QAngle(0, 90, 0), a6:Normalized())
				local al = R + a6:Normalized() * (S - 1)
				local ai = { R + D * ae, al + D * af, al, al - D * af, R - D * ae }
				if
					(IsPointInPolygon(a1:GetAbsOrigin(), ai) or a1:IsPositionInRange(al, af + a1:GetHullRadius()))
					and (IsPointInPolygon(a4:GetAbsOrigin(), ai) or a4:IsPositionInRange(al, af + a4:GetHullRadius()))
				then
					ah(ai)
				end
			end
			local a6 = a1:GetAbsOrigin() - R
			a6.z = 0
			local D = RotatePosition(vec3_zero, QAngle(0, 90, 0), a6:Normalized())
			local al = R + a6:Normalized() * (S - 1)
			local ai = { R + D * ae, al + D * af, al, al - D * af, R - D * ae }
			ah(ai)
		end
		local a0 = 0
		for N = 0, #ag - 1, 1 do
			local ai = ag[N + 1]
			local a2 = 0
			for a3 = 0, #Z - 1, 1 do
				local _ = Z[a3 + 1]
				if IsPointInPolygon(_:GetAbsOrigin(), ai) or _:IsPositionInRange(ai[4], af + _:GetHullRadius()) then
					a2 = a2 + 1
				end
			end
			if a2 > a0 then
				a5 = ai[4]
				a0 = a2
			end
		end
	end
	if a5 ~= vec3_invalid then
		a5 = GetGroundPosition(a5, nil)
	end
	return a5
end
function GetBounceTarget(am, y, a9, T, U, V, W, X, an, ao)
	if ao == nil then
		ao = false
	end
	local ap = FindUnitsInRadius(y, a9, nil, T, U, V, W, X, false)
	if am then
		ArrayRemove(ap, am)
	end
	local aq = shallowcopy(ap)
	if an ~= nil then
		for N = 0, #an - 1, 1 do
			ArrayRemove(ap, an[N + 1])
		end
	end
	local ar = ap[1]
	local as = aq[1]
	if ao then
		return ar or as
	else
		return ar
	end
end
function DoCleaveAction(at, _, ae, af, aa, n, U, V, W)
	if U == nil then
		U = DOTA_UNIT_TARGET_TEAM_ENEMY
	end
	if V == nil then
		V = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	end
	if W == nil then
		W = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
	end
	local T = math.max(ae / 2, math.max(af / 2, math.sqrt(bit.bxor(bit.bxor(aa, 2 + af / 2), 2))))
	local au = at:GetAbsOrigin()
	local a6 = _:GetAbsOrigin() - au
	a6.z = 0
	a6 = a6:Normalized()
	local av = au + a6 * aa
	local D = RotatePosition(vec3_zero, QAngle(0, 90, 0), a6)
	local ai = { au + D * ae, av + D * af, av - D * af, au - D * ae }
	DebugDrawLine(ai[2], ai[3], 255, 255, 255, true, at:GetSecondsPerAttack(false))
	DebugDrawLine(ai[3], ai[4], 255, 255, 255, true, at:GetSecondsPerAttack(false))
	DebugDrawLine(ai[4], ai[5], 255, 255, 255, true, at:GetSecondsPerAttack(false))
	DebugDrawLine(ai[5], ai[2], 255, 255, 255, true, at:GetSecondsPerAttack(false))
	local I = false
	local Z = FindUnitsInRadius(at:GetTeamNumber(), au, nil, T + 100, U, V, W, FIND_CLOSEST, false)
	for N = 0, #Z - 1, 1 do
		local E = Z[N + 1]
		if E ~= _ then
			if IsPointInPolygon(E:GetAbsOrigin(), ai) then
				if n(E) == true then
					break
				end
			end
		end
	end
end
function FindUnitsInSector(y, a9, T, aw, ax, U, V, W, X)
	aw = Vector(aw.x, aw.y, 0)
	local ay = FindUnitsInRadius(y, a9, nil, T, U, V, W, X, false)
	for N = #ay - 1, 0, -1 do
		local E = ay[N + 1]
		local a5 = E:GetAbsOrigin()
		local az = a5 - a9
		az.z = 0
		local aA = math.deg(math.acos(aw:Normalized():Dot(az:Normalized())))
		if aA > ax / 2 then
			h(ay, N, 1)
		end
	end
	return ay
end
function FindUnitsInRect(y, aB, U, V, W, X)
	if X == nil then
		X = FIND_ANY_ORDER
	end
	local aC = aB.min:Lerp(aB.max, 0.5)
	local T = (aB.min - aB.max):Length2D() / 2
	local ai = { aB.min, Vector(aB.min.x, aB.max.y, 0), aB.max, Vector(aB.max.x, aB.min.y, 0) }
	local Z = FindUnitsInRadius(y, aC, nil, T, U, V, W, X, false)
	for N = #Z - 1, 0, -1 do
		local E = Z[N + 1]
		if not IsPointInPolygon(E:GetAbsOrigin(), ai) then
			h(Z, N, 1)
		end
	end
	return Z
end
function FindUnitsInLineWithAbility(aD, au, av, aE, aF)
	if aF == nil then
		aF = aD:GetCaster()
	end
	if not IsValid(aF) or not IsValid(aD) then
		return {}
	end
	return FindUnitsInLine(
		aF:GetTeamNumber(),
		au,
		av,
		nil,
		aE,
		aD:GetAbilityTargetTeam(),
		aD:GetAbilityTargetType(),
		aD:GetAbilityTargetFlags()
	)
end
function FindUnitsInRadiusWithAbility(aD, a9, T, X, aF)
	if X == nil then
		X = FIND_ANY_ORDER
	end
	if aF == nil then
		aF = aD:GetCaster()
	end
	if not IsValid(aF) or not IsValid(aD) then
		return {}
	end
	return FindUnitsInRadius(
		aF:GetTeamNumber(),
		a9,
		nil,
		T,
		aD:GetAbilityTargetTeam(),
		aD:GetAbilityTargetType(),
		aD:GetAbilityTargetFlags(),
		X,
		false
	)
end
function GetNextRecord()
	if RECORD_SYSTEM_DUMMY.iLastRecord == nil then
		RECORD_SYSTEM_DUMMY.iLastRecord = 0
	end
	if RECORD_SYSTEM_DUMMY.iLastRecord and RECORD_SYSTEM_DUMMY.iLastRecord >= 255 then
		RECORD_SYSTEM_DUMMY.iLastRecord = RECORD_SYSTEM_DUMMY.iLastRecord - 256
	end
	return RECORD_SYSTEM_DUMMY.iLastRecord + 1
end
DAMAGE_STATE = DAMAGE_STATE or {}
DAMAGE_STATE.PHYSICAL_CRIT = 1
DAMAGE_STATE[DAMAGE_STATE.PHYSICAL_CRIT] = "PHYSICAL_CRIT"
DAMAGE_STATE.MAGICAL_CRIT = 2
DAMAGE_STATE[DAMAGE_STATE.MAGICAL_CRIT] = "MAGICAL_CRIT"
DAMAGE_STATE.NO_CRIT = 4
DAMAGE_STATE[DAMAGE_STATE.NO_CRIT] = "NO_CRIT"
DAMAGE_STATE.DOT = 8
DAMAGE_STATE[DAMAGE_STATE.DOT] = "DOT"
if ApplyDamage_Engine == nil then
	ApplyDamage_Engine = ApplyDamage
end
_G.ApplyDamage = function(aG, aH)
	if aH == nil then
		aH = 0
	end
	local aI = GetNextRecord()
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM == nil then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM = {}
	end
	RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aI] = aH
	return ApplyDamage_Engine(aG)
end
function DamageStateFilter(aJ, ...)
	local aK = { ... }
	local aL = false
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM == nil then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM = {}
	end
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] ~= nil and RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] ~= 0 then
		for I, aH in ipairs(aK) do
			aL = aL or bit.band(RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ], aH) == aH
		end
	end
	return aL
end
function _DamageStatePhysicalCrit(aJ)
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM == nil then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM = {}
	end
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] == nil then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] = 0
	end
	if bit.band(RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ], DAMAGE_STATE.PHYSICAL_CRIT) ~= DAMAGE_STATE.PHYSICAL_CRIT then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] = RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] + DAMAGE_STATE.PHYSICAL_CRIT
	end
end
function _DamageStateMagicalCrit(aJ)
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM == nil then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM = {}
	end
	if RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] == nil then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] = 0
	end
	if bit.band(RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ], DAMAGE_STATE.MAGICAL_CRIT) ~= DAMAGE_STATE.MAGICAL_CRIT then
		RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] = RECORD_SYSTEM_DUMMY.DAMAGE_SYSTEM[aJ] + DAMAGE_STATE.MAGICAL_CRIT
	end
end
ATTACK_STATE = ATTACK_STATE or {}
ATTACK_STATE.NOT_USECASTATTACKORB = 2
ATTACK_STATE[ATTACK_STATE.NOT_USECASTATTACKORB] = "NOT_USECASTATTACKORB"
ATTACK_STATE.NOT_PROCESSPROCS = 4
ATTACK_STATE[ATTACK_STATE.NOT_PROCESSPROCS] = "NOT_PROCESSPROCS"
ATTACK_STATE.SKIPCOOLDOWN = 8
ATTACK_STATE[ATTACK_STATE.SKIPCOOLDOWN] = "SKIPCOOLDOWN"
ATTACK_STATE.IGNOREINVIS = 16
ATTACK_STATE[ATTACK_STATE.IGNOREINVIS] = "IGNOREINVIS"
ATTACK_STATE.NOT_USEPROJECTILE = 32
ATTACK_STATE[ATTACK_STATE.NOT_USEPROJECTILE] = "NOT_USEPROJECTILE"
ATTACK_STATE.FAKEATTACK = 64
ATTACK_STATE[ATTACK_STATE.FAKEATTACK] = "FAKEATTACK"
ATTACK_STATE.NEVERMISS = 128
ATTACK_STATE[ATTACK_STATE.NEVERMISS] = "NEVERMISS"
ATTACK_STATE.NO_CLEAVE = 256
ATTACK_STATE[ATTACK_STATE.NO_CLEAVE] = "NO_CLEAVE"
ATTACK_STATE.NO_EXTENDATTACK = 512
ATTACK_STATE[ATTACK_STATE.NO_EXTENDATTACK] = "NO_EXTENDATTACK"
ATTACK_STATE.SKIPCOUNTING = 1024
ATTACK_STATE[ATTACK_STATE.SKIPCOUNTING] = "SKIPCOUNTING"
CDOTA_BaseNPC.Attack = function(self, _, aM)
	if aM == nil then
		aM = 0
	end
	local aI = GetNextRecord()
	local aN = bit.band(aM, ATTACK_STATE.NOT_USECASTATTACKORB) ~= ATTACK_STATE.NOT_USECASTATTACKORB
	local aO = bit.band(aM, ATTACK_STATE.NOT_PROCESSPROCS) ~= ATTACK_STATE.NOT_PROCESSPROCS
	local aP = bit.band(aM, ATTACK_STATE.SKIPCOOLDOWN) == ATTACK_STATE.SKIPCOOLDOWN
	local aQ = bit.band(aM, ATTACK_STATE.IGNOREINVIS) == ATTACK_STATE.IGNOREINVIS
	local aR = bit.band(aM, ATTACK_STATE.NOT_USEPROJECTILE) ~= ATTACK_STATE.NOT_USEPROJECTILE
	local aS = bit.band(aM, ATTACK_STATE.FAKEATTACK) == ATTACK_STATE.FAKEATTACK
	local aT = bit.band(aM, ATTACK_STATE.NEVERMISS) == ATTACK_STATE.NEVERMISS
	if RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM == nil then
		RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM = {}
	end
	RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM[aI] = aM
	self:PerformAttack(_, aN, aO, aP, aQ, aR, aS, aT)
	return aI
end
function AttackStateFilter(aJ, ...)
	local aK = { ... }
	local aL = false
	if RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM == nil then
		RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM = {}
	end
	if RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM[aJ] ~= nil and RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM[aJ] ~= 0 then
		for I, aH in ipairs(aK) do
			aL = aL or bit.band(RECORD_SYSTEM_DUMMY.ATTACK_SYSTEM[aJ], aH) == aH
		end
	end
	return aL
end
CDOTA_BaseNPC.GetDummyAbility = function(self)
	return self:FindAbilityByName("unit_state")
end
if CDOTA_BaseNPC.AddActivityModifier_Engine == nil then
	CDOTA_BaseNPC.AddActivityModifier_Engine = CDOTA_BaseNPC.AddActivityModifier
end
CDOTA_BaseNPC._updateActivityModifier = function(self)
	if self._aActivityModifiers == nil then
		self._aActivityModifiers = {}
	end
	self:ClearActivityModifiers()
	for N = 0, #self._aActivityModifiers - 1, 1 do
		self:AddActivityModifier_Engine(self._aActivityModifiers[N + 1])
	end
end
CDOTA_BaseNPC.AddActivityModifier = function(self, Q)
	if self._aActivityModifiers == nil then
		self._aActivityModifiers = {}
	end
	local aU = self._aActivityModifiers
	aU[#aU + 1] = Q
	self:_updateActivityModifier()
end
CDOTA_BaseNPC.RemoveActivityModifier = function(self, Q)
	if self._aActivityModifiers == nil then
		self._aActivityModifiers = {}
	end
	ArrayRemove(self._aActivityModifiers, Q)
	self:_updateActivityModifier()
end
CDOTA_BaseNPC.GetAttachmentPosition = function(self, aV)
	return self:GetAttachmentOrigin(self:ScriptLookupAttachment(aV))
end
CDOTA_BaseNPC.BonusesChangedProc = function(self, n)
	self:CalculateGenericBonuses()
	local aW = self:GetMana() / self:GetMaxMana()
	local aX = n()
	self:CalculateGenericBonuses()
	self:SetMana(aW * self:GetMaxMana())
	return aX
end
CDOTA_BaseNPC.CalculateHealth = function(self)
	local aY = self:FindModifierByName("modifier_common")
	if IsValid(aY) then
		aY:CalculateHealth()
	end
end
if CDOTA_BaseNPC.AddAbility_Engine == nil then
	CDOTA_BaseNPC.AddAbility_Engine = CDOTA_BaseNPC.AddAbility
end
CDOTA_BaseNPC.AddAbility = function(self, P, aZ)
	local a_ = aZ or 0
	local b0 = self.__pendingAbilityLevels
	local b1
	if a_ > 0 then
		if b0 == nil then
			b0 = {}
			self.__pendingAbilityLevels = b0
		end
		b1 = b0[P]
		if b1 == nil then
			b1 = {}
			b0[P] = b1
		end
		b1[#b1 + 1] = a_
	elseif b0 then
		b1 = b0[P]
	end
	local b2 = self:AddAbility_Engine(P)
	if not IsValid(b2) then
		if b1 and #b1 > 0 then
			table.remove(b1)
			if #b1 == 0 and b0 then
				i(b0, P)
			end
		end
		return b2
	end
	if a_ > 0 and b2:GetLevel() ~= a_ then
		b2:SetLevel(a_)
	end
	if b1 and #b1 == 0 and b0 then
		i(b0, P)
	end
	return b2
end
if CDOTA_BaseNPC.RespawnUnit_Engine == nil then
	CDOTA_BaseNPC.RespawnUnit_Engine = CDOTA_BaseNPC.RespawnUnit
end
CDOTA_BaseNPC.RespawnUnit = function(self)
	local b3 = self:FirstMoveChild()
	while b3 ~= nil do
		local b4 = b3:NextMovePeer()
		if b3 ~= nil and b3:GetClassname() ~= "" and b3:GetClassname() == "dota_item_wearable" then
			UTIL_Remove(b3)
		end
		b3 = b4
	end
	self:RespawnUnit_Engine()
end
if CDOTA_BaseNPC.Heal_Engine == nil then
	CDOTA_BaseNPC.Heal_Engine = CDOTA_BaseNPC.Heal
end
CDOTA_BaseNPC.Heal = function(self, b5, b6, b7)
	if b7 == nil then
		b7 = false
	end
	if IsInjurable(self) then
		self:Heal_Engine(b5, b6)
		if b7 and IsValid(b6) and type(b6.GetCaster) == "function" then
			local aF = b6:GetCaster()
			if IsValid(aF) then
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self, b5, aF:GetPlayerOwner())
			end
		end
	end
end
CDOTA_BaseNPC.GetEnemy = function(self)
	return LoadData(self, "_enemyHero")
end
CDOTA_BaseNPC.IsNeutral = function(self)
	return self:HasModifier("modifier_neutral")
end
CDOTA_BaseNPC.SafeRemoveUnit = function(self)
	GameTimer(0, function()
		if self:IsNull() then
			return
		end
		self:RemoveAllModifiers(0, false, true, false)
		self:Remove()
	end)
end
CDOTABaseAbility.IsAbility = function(self)
	return true
end
CDOTABaseAbility.ReduceRemainingCooldown = function(self, b8)
	local b9 = self:GetCooldownTimeRemaining()
	if b9 > 0 then
		self:EndCooldown()
		if b9 > b8 then
			self:StartCooldown(b9 - b8)
		end
	end
end
CBaseEntity.IsAbility = function(self)
	return false
end
CEntityInstance.Remove = function(self)
	if IsValid(self) then
		FireGameEventLocal("custom_entity_removed", { entindex = self:entindex() })
		self:RemoveSelf()
	end
end
function ErrorMessage(ba, bb, bc)
	if bc == nil then
		bc = "General.Cancel"
	end
	if ba == -1 then
		CustomGameEventManager:Send_ServerToAllClients("error_message", { message = bb, sound = bc })
	else
		local bd = PlayerResource:GetPlayer(ba)
		if bd then
			CustomGameEventManager:Send_ServerToPlayer(bd, "error_message", { message = bb, sound = bc })
		end
	end
end
function SelectUnit(ba, be)
	local bf = ""
	if type(be) == "table" then
		if type(be.entindex) == "function" then
			bf = tostring(be.entindex)
		else
			for N, D in ipairs(be) do
				if type(D) == "table" then
					if type(D.entindex) == "function" then
						if bf ~= "" then
							bf = bf .. ","
						end
						bf = bf .. tostring(D:entindex())
					elseif tonumber(D) ~= nil then
						if bf ~= "" then
							bf = bf .. ","
						end
						bf = bf .. tostring(tonumber(D))
					end
				end
			end
		end
	elseif tonumber(be) ~= nil then
		bf = tostring(tonumber(be))
	end
	if ba ~= nil then
		local bd = PlayerResource:GetPlayer(ba)
		if bd then
			CustomGameEventManager:Send_ServerToPlayer(bd, "select_units", { units = bf })
		end
	end
end
CDOTA_PlayerResource.ChangePlayerTeam = function(self, bg, bh)
	local bi = self:GetTeam(bg)
	local bj = self:GetReliableGold(bg)
	local bk = self:GetUnreliableGold(bg)
	local bl = self:GetPlayerCountForTeam(bi)
	local bm = self:GetPlayerCountForTeam(bh)
	self:SetGold(bg, 0, false)
	self:SetGold(bg, 0, true)
	GameRules:SetCustomGameTeamMaxPlayers(bh, bm + 1)
	self:UpdateTeamSlot(bg, bh, bm)
	GameRules:SetCustomGameTeamMaxPlayers(bi, bl - 1)
	local bn = self:GetSelectedHeroEntity(bg)
	if IsValid(bn) then
		bn:SetTeam(bh)
	end
	local bo = self:GetPlayer(bg)
	if IsValid(bo) then
		bo:SetTeam(bh)
	end
	self:SetGold(bg, bk, false)
	self:SetGold(bg, bj, true)
end
if CDOTA_PlayerResource.SetCameraTarget_Engine == nil then
	CDOTA_PlayerResource.SetCameraTarget_Engine = CDOTA_PlayerResource.SetCameraTarget
end
CDOTA_PlayerResource.SetCameraTarget = function(self, ba, bp)
	local bq = -1
	if bp and IsValid(bp) then
		bq = bp:entindex()
	end
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(ba), "set_camera_target", { target = bq })
end
if _G.SendOverheadEventMessage_Engine == nil then
	_G.SendOverheadEventMessage_Engine = _G.SendOverheadEventMessage
end
_G.SendOverheadEventMessage = function(br, bs, bt, bu, bv)
	if bv then
		local bw = bv:GetPlayerID()
		if OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bw] == nil then
			OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bw] = {}
		end
		if OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bw][bs] == OVERHEAD_EVENT_MESSAGE_LIMIT_COUNT then
			return
		end
		OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bw][bs] = (OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bw][bs] or 0) + 1
	end
	_G.SendOverheadEventMessage_Engine(br, bs, bt, bu, bv)
end