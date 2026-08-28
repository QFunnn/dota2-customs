--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["17"] = 90,
		["18"] = 91,
		["19"] = 90,
		["26"] = 102,
		["27"] = 103,
		["28"] = 102,
		["32"] = 109,
		["33"] = 110,
		["34"] = 109,
		["40"] = 129,
		["41"] = 130,
		["42"] = 131,
		["43"] = 131,
		["44"] = 131,
		["45"] = 132,
		["46"] = 133,
		["48"] = 135,
		["49"] = 131,
		["50"] = 131,
		["51"] = 137,
		["52"] = 138,
		["53"] = 129,
		["59"] = 157,
		["60"] = 158,
		["61"] = 159,
		["62"] = 159,
		["63"] = 159,
		["64"] = 160,
		["65"] = 161,
		["67"] = 163,
		["68"] = 159,
		["69"] = 159,
		["70"] = 165,
		["71"] = 166,
		["72"] = 157,
		["76"] = 173,
		["77"] = 174,
		["78"] = 175,
		["79"] = 176,
		["80"] = 176,
		["81"] = 176,
		["82"] = 177,
		["83"] = 176,
		["84"] = 176,
		["85"] = 179,
		["87"] = 173,
		["97"] = 196,
		["98"] = 197,
		["99"] = 198,
		["100"] = 198,
		["101"] = 198,
		["102"] = 198,
		["103"] = 198,
		["104"] = 198,
		["105"] = 198,
		["106"] = 205,
		["107"] = 206,
		["109"] = 208,
		["110"] = 209,
		["111"] = 210,
		["112"] = 211,
		["113"] = 212,
		["115"] = 214,
		["117"] = 216,
		["118"] = 217,
		["120"] = 219,
		["123"] = 222,
		["124"] = 223,
		["127"] = 226,
		["128"] = 227,
		["129"] = 228,
		["130"] = 229,
		["131"] = 230,
		["134"] = 234,
		["136"] = 236,
		["137"] = 196,
		["138"] = 239,
		["139"] = 240,
		["141"] = 242,
		["142"] = 248,
		["143"] = 248,
		["144"] = 248,
		["145"] = 248,
		["146"] = 248,
		["147"] = 248,
		["148"] = 248,
		["149"] = 248,
		["150"] = 242,
		["151"] = 251,
		["152"] = 252,
		["154"] = 254,
		["155"] = 255,
		["156"] = 256,
		["157"] = 255,
		["158"] = 254,
		["165"] = 267,
		["166"] = 268,
		["167"] = 269,
		["168"] = 270,
		["169"] = 271,
		["170"] = 272,
		["172"] = 274,
		["173"] = 275,
		["174"] = 276,
		["175"] = 277,
		["176"] = 278,
		["177"] = 279,
		["178"] = 280,
		["179"] = 281,
		["181"] = 283,
		["183"] = 285,
		["186"] = 289,
		["187"] = 290,
		["190"] = 267,
		["196"] = 301,
		["197"] = 302,
		["200"] = 303,
		["201"] = 304,
		["202"] = 305,
		["203"] = 306,
		["204"] = 307,
		["205"] = 308,
		["209"] = 301,
		["215"] = 320,
		["216"] = 321,
		["219"] = 322,
		["220"] = 323,
		["221"] = 324,
		["222"] = 325,
		["223"] = 326,
		["224"] = 327,
		["228"] = 320,
		["241"] = 346,
		["242"] = 346,
		["243"] = 346,
		["245"] = 347,
		["246"] = 347,
		["247"] = 347,
		["248"] = 347,
		["249"] = 347,
		["250"] = 347,
		["251"] = 347,
		["252"] = 347,
		["253"] = 347,
		["254"] = 347,
		["255"] = 347,
		["256"] = 348,
		["257"] = 349,
		["258"] = 350,
		["259"] = 351,
		["262"] = 354,
		["265"] = 358,
		["266"] = 360,
		["267"] = 361,
		["268"] = 362,
		["269"] = 363,
		["270"] = 364,
		["271"] = 365,
		["272"] = 365,
		["274"] = 366,
		["275"] = 368,
		["276"] = 369,
		["277"] = 369,
		["278"] = 369,
		["279"] = 369,
		["280"] = 370,
		["284"] = 374,
		["285"] = 375,
		["286"] = 376,
		["289"] = 380,
		["290"] = 346,
		["303"] = 396,
		["304"] = 396,
		["305"] = 396,
		["307"] = 397,
		["308"] = 397,
		["309"] = 397,
		["310"] = 397,
		["311"] = 397,
		["312"] = 397,
		["313"] = 397,
		["314"] = 397,
		["315"] = 397,
		["316"] = 397,
		["317"] = 397,
		["318"] = 398,
		["319"] = 399,
		["320"] = 400,
		["321"] = 401,
		["324"] = 404,
		["327"] = 408,
		["328"] = 410,
		["329"] = 411,
		["330"] = 412,
		["331"] = 413,
		["332"] = 413,
		["333"] = 413,
		["334"] = 413,
		["335"] = 414,
		["336"] = 415,
		["337"] = 416,
		["338"] = 417,
		["339"] = 417,
		["340"] = 417,
		["341"] = 417,
		["342"] = 417,
		["343"] = 417,
		["344"] = 417,
		["345"] = 417,
		["346"] = 418,
		["347"] = 416,
		["348"] = 421,
		["349"] = 422,
		["350"] = 423,
		["351"] = 423,
		["352"] = 423,
		["353"] = 423,
		["354"] = 423,
		["355"] = 423,
		["356"] = 423,
		["357"] = 423,
		["358"] = 424,
		["359"] = 426,
		["360"] = 427,
		["361"] = 428,
		["362"] = 429,
		["363"] = 430,
		["364"] = 431,
		["365"] = 432,
		["366"] = 433,
		["368"] = 435,
		["369"] = 435,
		["370"] = 435,
		["371"] = 435,
		["372"] = 436,
		["373"] = 436,
		["374"] = 436,
		["375"] = 436,
		["376"] = 436,
		["377"] = 437,
		["378"] = 441,
		["379"] = 441,
		["380"] = 441,
		["381"] = 442,
		["382"] = 443,
		["384"] = 441,
		["385"] = 441,
		["390"] = 451,
		["391"] = 452,
		["392"] = 453,
		["393"] = 454,
		["394"] = 455,
		["395"] = 457,
		["396"] = 458,
		["397"] = 458,
		["398"] = 458,
		["399"] = 458,
		["400"] = 459,
		["403"] = 462,
		["404"] = 463,
		["405"] = 464,
		["408"] = 468,
		["409"] = 469,
		["410"] = 470,
		["411"] = 471,
		["412"] = 471,
		["413"] = 471,
		["414"] = 471,
		["417"] = 476,
		["418"] = 477,
		["420"] = 480,
		["421"] = 396,
		["435"] = 497,
		["436"] = 497,
		["437"] = 497,
		["439"] = 498,
		["440"] = 498,
		["441"] = 498,
		["442"] = 498,
		["443"] = 498,
		["444"] = 498,
		["445"] = 498,
		["446"] = 498,
		["447"] = 498,
		["448"] = 498,
		["449"] = 498,
		["450"] = 499,
		["451"] = 500,
		["452"] = 501,
		["453"] = 502,
		["456"] = 505,
		["459"] = 509,
		["460"] = 511,
		["461"] = 512,
		["462"] = 513,
		["463"] = 514,
		["464"] = 515,
		["465"] = 516,
		["466"] = 517,
		["467"] = 527,
		["468"] = 517,
		["469"] = 529,
		["470"] = 530,
		["471"] = 531,
		["472"] = 533,
		["473"] = 534,
		["474"] = 535,
		["475"] = 536,
		["476"] = 537,
		["477"] = 538,
		["478"] = 539,
		["479"] = 540,
		["480"] = 540,
		["481"] = 540,
		["482"] = 540,
		["483"] = 540,
		["484"] = 541,
		["485"] = 542,
		["486"] = 542,
		["487"] = 542,
		["488"] = 542,
		["489"] = 542,
		["490"] = 542,
		["491"] = 542,
		["492"] = 549,
		["493"] = 549,
		["494"] = 549,
		["495"] = 549,
		["496"] = 549,
		["497"] = 549,
		["498"] = 549,
		["499"] = 549,
		["500"] = 549,
		["501"] = 549,
		["502"] = 549,
		["503"] = 549,
		["504"] = 549,
		["505"] = 550,
		["508"] = 553,
		["509"] = 554,
		["510"] = 555,
		["511"] = 555,
		["512"] = 555,
		["513"] = 555,
		["514"] = 555,
		["515"] = 556,
		["516"] = 557,
		["517"] = 557,
		["518"] = 557,
		["519"] = 557,
		["520"] = 557,
		["521"] = 557,
		["522"] = 557,
		["523"] = 564,
		["525"] = 567,
		["526"] = 568,
		["527"] = 569,
		["528"] = 570,
		["529"] = 571,
		["530"] = 573,
		["531"] = 574,
		["532"] = 574,
		["533"] = 574,
		["534"] = 574,
		["535"] = 574,
		["536"] = 574,
		["537"] = 574,
		["538"] = 575,
		["541"] = 578,
		["542"] = 579,
		["543"] = 580,
		["547"] = 585,
		["548"] = 586,
		["550"] = 589,
		["551"] = 497,
		["565"] = 606,
		["566"] = 606,
		["567"] = 606,
		["569"] = 607,
		["570"] = 607,
		["571"] = 607,
		["572"] = 607,
		["573"] = 607,
		["574"] = 607,
		["575"] = 607,
		["576"] = 607,
		["577"] = 607,
		["578"] = 607,
		["579"] = 607,
		["580"] = 609,
		["581"] = 610,
		["583"] = 613,
		["584"] = 615,
		["585"] = 616,
		["586"] = 617,
		["589"] = 621,
		["590"] = 622,
		["591"] = 624,
		["592"] = 625,
		["594"] = 627,
		["596"] = 606,
		["608"] = 643,
		["609"] = 643,
		["610"] = 643,
		["612"] = 643,
		["613"] = 643,
		["615"] = 643,
		["616"] = 643,
		["618"] = 644,
		["619"] = 644,
		["620"] = 644,
		["621"] = 644,
		["622"] = 644,
		["623"] = 644,
		["624"] = 644,
		["625"] = 644,
		["626"] = 644,
		["627"] = 644,
		["628"] = 645,
		["629"] = 646,
		["630"] = 647,
		["631"] = 648,
		["632"] = 650,
		["633"] = 651,
		["634"] = 651,
		["635"] = 651,
		["636"] = 651,
		["637"] = 651,
		["638"] = 652,
		["639"] = 658,
		["640"] = 658,
		["641"] = 658,
		["642"] = 658,
		["643"] = 658,
		["644"] = 658,
		["645"] = 658,
		["646"] = 658,
		["647"] = 658,
		["648"] = 659,
		["649"] = 659,
		["650"] = 659,
		["651"] = 659,
		["652"] = 659,
		["653"] = 659,
		["654"] = 659,
		["655"] = 659,
		["656"] = 659,
		["657"] = 660,
		["658"] = 660,
		["659"] = 660,
		["660"] = 660,
		["661"] = 660,
		["662"] = 660,
		["663"] = 660,
		["664"] = 660,
		["665"] = 660,
		["666"] = 661,
		["667"] = 661,
		["668"] = 661,
		["669"] = 661,
		["670"] = 661,
		["671"] = 661,
		["672"] = 661,
		["673"] = 661,
		["674"] = 661,
		["675"] = 662,
		["676"] = 663,
		["677"] = 663,
		["678"] = 663,
		["679"] = 663,
		["680"] = 663,
		["681"] = 663,
		["682"] = 663,
		["683"] = 663,
		["684"] = 663,
		["685"] = 663,
		["686"] = 663,
		["687"] = 664,
		["688"] = 665,
		["689"] = 666,
		["690"] = 667,
		["691"] = 667,
		["692"] = 667,
		["693"] = 667,
		["694"] = 668,
		["700"] = 643,
		["713"] = 687,
		["714"] = 688,
		["715"] = 689,
		["716"] = 689,
		["717"] = 689,
		["718"] = 689,
		["719"] = 689,
		["720"] = 689,
		["721"] = 689,
		["722"] = 689,
		["723"] = 689,
		["724"] = 689,
		["725"] = 689,
		["726"] = 690,
		["727"] = 691,
		["728"] = 692,
		["729"] = 693,
		["730"] = 694,
		["731"] = 695,
		["732"] = 696,
		["733"] = 697,
		["736"] = 700,
		["737"] = 687,
		["747"] = 713,
		["748"] = 713,
		["749"] = 713,
		["751"] = 714,
		["752"] = 715,
		["753"] = 716,
		["754"] = 716,
		["755"] = 716,
		["756"] = 716,
		["757"] = 716,
		["758"] = 716,
		["759"] = 722,
		["760"] = 722,
		["761"] = 722,
		["762"] = 722,
		["763"] = 722,
		["764"] = 722,
		["765"] = 722,
		["766"] = 722,
		["767"] = 722,
		["768"] = 722,
		["769"] = 722,
		["770"] = 723,
		["771"] = 724,
		["772"] = 725,
		["773"] = 725,
		["774"] = 725,
		["775"] = 725,
		["776"] = 726,
		["779"] = 729,
		["780"] = 713,
		["789"] = 741,
		["790"] = 741,
		["791"] = 741,
		["793"] = 742,
		["794"] = 742,
		["796"] = 743,
		["797"] = 743,
		["798"] = 743,
		["799"] = 743,
		["800"] = 743,
		["801"] = 743,
		["802"] = 743,
		["803"] = 743,
		["804"] = 743,
		["805"] = 743,
		["806"] = 741,
		["815"] = 755,
		["816"] = 755,
		["817"] = 755,
		["819"] = 755,
		["820"] = 755,
		["822"] = 756,
		["823"] = 756,
		["825"] = 757,
		["826"] = 757,
		["827"] = 757,
		["828"] = 757,
		["829"] = 757,
		["830"] = 757,
		["831"] = 757,
		["832"] = 757,
		["833"] = 757,
		["834"] = 757,
		["835"] = 757,
		["836"] = 755,
		["840"] = 764,
		["841"] = 765,
		["842"] = 765,
		["844"] = 766,
		["845"] = 766,
		["847"] = 767,
		["848"] = 764,
		["850"] = 771,
		["851"] = 771,
		["852"] = 771,
		["853"] = 771,
		["854"] = 771,
		["855"] = 771,
		["856"] = 771,
		["857"] = 771,
		["858"] = 771,
		["859"] = 790,
		["860"] = 791,
		["862"] = 793,
		["863"] = 794,
		["864"] = 794,
		["866"] = 795,
		["867"] = 797,
		["868"] = 797,
		["870"] = 798,
		["871"] = 800,
		["872"] = 793,
		["878"] = 808,
		["879"] = 808,
		["880"] = 809,
		["881"] = 810,
		["882"] = 810,
		["884"] = 811,
		["885"] = 812,
		["886"] = 813,
		["889"] = 816,
		["890"] = 808,
		["894"] = 822,
		["895"] = 823,
		["896"] = 823,
		["898"] = 824,
		["899"] = 824,
		["901"] = 826,
		["902"] = 827,
		["904"] = 822,
		["908"] = 834,
		["909"] = 835,
		["910"] = 835,
		["912"] = 836,
		["913"] = 836,
		["915"] = 838,
		["916"] = 839,
		["918"] = 834,
		["920"] = 844,
		["921"] = 844,
		["922"] = 844,
		["923"] = 844,
		["924"] = 844,
		["925"] = 844,
		["926"] = 844,
		["927"] = 844,
		["928"] = 844,
		["929"] = 844,
		["930"] = 844,
		["931"] = 844,
		["932"] = 844,
		["933"] = 844,
		["934"] = 844,
		["935"] = 844,
		["936"] = 844,
		["937"] = 844,
		["938"] = 844,
		["939"] = 844,
		["940"] = 844,
		["941"] = 888,
		["942"] = 888,
		["943"] = 888,
		["945"] = 889,
		["946"] = 890,
		["947"] = 891,
		["948"] = 892,
		["949"] = 893,
		["950"] = 894,
		["951"] = 895,
		["952"] = 896,
		["953"] = 898,
		["954"] = 898,
		["956"] = 899,
		["957"] = 935,
		["958"] = 935,
		["959"] = 935,
		["960"] = 935,
		["961"] = 935,
		["962"] = 935,
		["963"] = 935,
		["964"] = 935,
		["965"] = 935,
		["966"] = 935,
		["967"] = 937,
		["968"] = 888,
		["974"] = 946,
		["975"] = 946,
		["976"] = 947,
		["977"] = 948,
		["978"] = 948,
		["980"] = 949,
		["981"] = 950,
		["982"] = 951,
		["985"] = 954,
		["986"] = 946,
		["987"] = 960,
		["988"] = 961,
		["989"] = 960,
		["990"] = 963,
		["991"] = 964,
		["993"] = 966,
		["994"] = 967,
		["995"] = 967,
		["997"] = 969,
		["998"] = 971,
		["999"] = 972,
		["1001"] = 966,
		["1002"] = 975,
		["1003"] = 976,
		["1004"] = 976,
		["1006"] = 978,
		["1007"] = 978,
		["1008"] = 980,
		["1009"] = 975,
		["1010"] = 982,
		["1011"] = 983,
		["1012"] = 983,
		["1014"] = 985,
		["1015"] = 987,
		["1016"] = 982,
		["1017"] = 989,
		["1018"] = 991,
		["1019"] = 989,
		["1020"] = 994,
		["1021"] = 995,
		["1022"] = 996,
		["1023"] = 997,
		["1024"] = 998,
		["1025"] = 999,
		["1026"] = 1001,
		["1027"] = 994,
		["1028"] = 1003,
		["1029"] = 1004,
		["1030"] = 1005,
		["1031"] = 1007,
		["1033"] = 1003,
		["1034"] = 1010,
		["1035"] = 1011,
		["1037"] = 1013,
		["1038"] = 1014,
		["1039"] = 1015,
		["1040"] = 1016,
		["1041"] = 1017,
		["1042"] = 1018,
		["1043"] = 1019,
		["1044"] = 1020,
		["1046"] = 1022,
		["1047"] = 1023,
		["1048"] = 1024,
		["1049"] = 1025,
		["1051"] = 1027,
		["1052"] = 1028,
		["1053"] = 1029,
		["1055"] = 1031,
		["1056"] = 1032,
		["1057"] = 1033,
		["1058"] = 1034,
		["1059"] = 1035,
		["1060"] = 1036,
		["1063"] = 1039,
		["1065"] = 1041,
		["1066"] = 1042,
		["1068"] = 1044,
		["1069"] = 1045,
		["1071"] = 1047,
		["1072"] = 1013,
		["1073"] = 1050,
		["1074"] = 1051,
		["1076"] = 1053,
		["1077"] = 1054,
		["1078"] = 1055,
		["1079"] = 1056,
		["1080"] = 1057,
		["1081"] = 1058,
		["1083"] = 1060,
		["1085"] = 1062,
		["1086"] = 1053,
		["1087"] = 1064,
		["1088"] = 1065,
		["1090"] = 1067,
		["1091"] = 1067,
		["1092"] = 1067,
		["1094"] = 1068,
		["1095"] = 1069,
		["1096"] = 1070,
		["1097"] = 1071,
		["1098"] = 1072,
		["1099"] = 1073,
		["1100"] = 1073,
		["1101"] = 1073,
		["1102"] = 1073,
		["1103"] = 1073,
		["1104"] = 1073,
		["1105"] = 1073,
		["1109"] = 1067,
		["1110"] = 1079,
		["1111"] = 1080,
		["1112"] = 1079,
		["1113"] = 1083,
		["1114"] = 1084,
		["1115"] = 1083,
		["1116"] = 1086,
		["1117"] = 1087,
		["1118"] = 1087,
		["1119"] = 1087,
		["1120"] = 1088,
		["1123"] = 1089,
		["1124"] = 1090,
		["1125"] = 1087,
		["1126"] = 1087,
		["1127"] = 1086,
		["1128"] = 1094,
		["1129"] = 1095,
		["1130"] = 1094,
		["1131"] = 1098,
		["1132"] = 1099,
		["1133"] = 1100,
		["1134"] = 1101,
		["1135"] = 1102,
		["1136"] = 1103,
		["1139"] = 1098,
		["1140"] = 1111,
		["1141"] = 1112,
		["1142"] = 1111,
		["1143"] = 1115,
		["1144"] = 1116,
		["1146"] = 1118,
		["1147"] = 1119,
		["1148"] = 1118,
		["1149"] = 1125,
		["1150"] = 1126,
		["1151"] = 1127,
		["1152"] = 1127,
		["1153"] = 1127,
		["1154"] = 1127,
		["1155"] = 1130,
		["1157"] = 1125,
		["1163"] = 1140,
		["1164"] = 1140,
		["1165"] = 1140,
		["1167"] = 1141,
		["1168"] = 1142,
		["1170"] = 1144,
		["1171"] = 1145,
		["1172"] = 1146,
		["1175"] = 1140,
		["1180"] = 1156,
		["1181"] = 1157,
		["1182"] = 1158,
		["1183"] = 1160,
		["1184"] = 1162,
		["1186"] = 1165,
		["1187"] = 1166,
		["1188"] = 1168,
		["1189"] = 1169,
		["1190"] = 1170,
		["1192"] = 1173,
		["1193"] = 1174,
		["1194"] = 1175,
		["1195"] = 1176,
		["1197"] = 1178,
		["1202"] = 1183,
		["1203"] = 1184,
		["1205"] = 1186,
		["1206"] = 1187,
		["1207"] = 1188,
		["1208"] = 1189,
		["1211"] = 1156,
		["1212"] = 1194,
		["1213"] = 1195,
		["1214"] = 1196,
		["1215"] = 1197,
		["1216"] = 1199,
		["1217"] = 1200,
		["1218"] = 1202,
		["1219"] = 1203,
		["1220"] = 1205,
		["1221"] = 1206,
		["1222"] = 1207,
		["1223"] = 1209,
		["1224"] = 1210,
		["1225"] = 1211,
		["1227"] = 1213,
		["1228"] = 1214,
		["1229"] = 1215,
		["1231"] = 1218,
		["1232"] = 1219,
		["1233"] = 1194,
		["1234"] = 1221,
		["1235"] = 1222,
		["1237"] = 1224,
		["1238"] = 1225,
		["1239"] = 1226,
		["1240"] = 1227,
		["1242"] = 1229,
		["1243"] = 1229,
		["1244"] = 1229,
		["1245"] = 1229,
		["1246"] = 1229,
		["1247"] = 1224,
		["1248"] = 1235,
		["1249"] = 1236,
		["1251"] = 1238,
		["1252"] = 1239,
		["1253"] = 1240,
		["1254"] = 1241,
		["1255"] = 1242,
		["1257"] = 1244,
		["1260"] = 1247,
		["1262"] = 1249,
		["1263"] = 1249,
		["1264"] = 1249,
		["1265"] = 1249,
		["1266"] = 1249,
		["1267"] = 1249,
		["1268"] = 1249,
		["1269"] = 1238,
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
if CBaseEntity.SetAbsOrigin_Engine == nil then
	CBaseEntity.SetAbsOrigin_Engine = CBaseEntity.SetAbsOrigin
end
CBaseEntity.SetAbsOrigin = function(self, ba)
	self:SetLocalOrigin(ba)
end
CEntityInstance.Remove = function(self)
	if IsValid(self) then
		FireGameEventLocal("custom_entity_removed", { entindex = self:entindex() })
		self:RemoveSelf()
	end
end
function ErrorMessage(bb, bc, bd)
	if bd == nil then
		bd = "General.Cancel"
	end
	if bb == -1 then
		CustomGameEventManager:Send_ServerToAllClients("error_message", { message = bc, sound = bd })
	else
		local be = PlayerResource:GetPlayer(bb)
		if be then
			CustomGameEventManager:Send_ServerToPlayer(be, "error_message", { message = bc, sound = bd })
		end
	end
end
function SelectUnit(bb, bf)
	local bg = ""
	if type(bf) == "table" then
		if type(bf.entindex) == "function" then
			bg = tostring(bf.entindex)
		else
			for N, D in ipairs(bf) do
				if type(D) == "table" then
					if type(D.entindex) == "function" then
						if bg ~= "" then
							bg = bg .. ","
						end
						bg = bg .. tostring(D:entindex())
					elseif tonumber(D) ~= nil then
						if bg ~= "" then
							bg = bg .. ","
						end
						bg = bg .. tostring(tonumber(D))
					end
				end
			end
		end
	elseif tonumber(bf) ~= nil then
		bg = tostring(tonumber(bf))
	end
	if bb ~= nil then
		local be = PlayerResource:GetPlayer(bb)
		if be then
			CustomGameEventManager:Send_ServerToPlayer(be, "select_units", { units = bg })
		end
	end
end
CDOTA_PlayerResource.ChangePlayerTeam = function(self, bh, bi)
	local bj = self:GetTeam(bh)
	local bk = self:GetReliableGold(bh)
	local bl = self:GetUnreliableGold(bh)
	local bm = self:GetPlayerCountForTeam(bj)
	local bn = self:GetPlayerCountForTeam(bi)
	self:SetGold(bh, 0, false)
	self:SetGold(bh, 0, true)
	GameRules:SetCustomGameTeamMaxPlayers(bi, bn + 1)
	self:UpdateTeamSlot(bh, bi, bn)
	GameRules:SetCustomGameTeamMaxPlayers(bj, bm - 1)
	local bo = self:GetSelectedHeroEntity(bh)
	if IsValid(bo) then
		bo:SetTeam(bi)
	end
	local bp = self:GetPlayer(bh)
	if IsValid(bp) then
		bp:SetTeam(bi)
	end
	self:SetGold(bh, bl, false)
	self:SetGold(bh, bk, true)
end
if CDOTA_PlayerResource.SetCameraTarget_Engine == nil then
	CDOTA_PlayerResource.SetCameraTarget_Engine = CDOTA_PlayerResource.SetCameraTarget
end
CDOTA_PlayerResource.SetCameraTarget = function(self, bb, bq)
	local br = -1
	if bq and IsValid(bq) then
		br = bq:entindex()
	end
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(bb), "set_camera_target", { target = br })
end
if _G.SendOverheadEventMessage_Engine == nil then
	_G.SendOverheadEventMessage_Engine = _G.SendOverheadEventMessage
end
_G.SendOverheadEventMessage = function(bs, bt, bu, bv, bw)
	if bw then
		local bx = bw:GetPlayerID()
		if OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bx] == nil then
			OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bx] = {}
		end
		if OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bx][bt] == OVERHEAD_EVENT_MESSAGE_LIMIT_COUNT then
			return
		end
		OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bx][bt] = (OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD[bx][bt] or 0) + 1
	end
	_G.SendOverheadEventMessage_Engine(bs, bt, bu, bv, bw)
end