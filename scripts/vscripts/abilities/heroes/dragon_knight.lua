--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/dragon_knight"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayReduce
local g = b.__TS__ArrayForEach
local h = b.__TS__ArrayIncludes
local i = b.__TS__ArraySome
local j = b.__TS__StringSplit
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 4,
		["23"] = 4,
		["24"] = 4,
		["25"] = 6,
		["26"] = 33,
		["27"] = 38,
		["28"] = 41,
		["29"] = 42,
		["30"] = 41,
		["31"] = 42,
		["32"] = 43,
		["33"] = 44,
		["34"] = 43,
		["35"] = 42,
		["36"] = 41,
		["37"] = 42,
		["39"] = 42,
		["40"] = 47,
		["41"] = 55,
		["42"] = 47,
		["43"] = 55,
		["44"] = 66,
		["45"] = 67,
		["46"] = 68,
		["47"] = 69,
		["48"] = 66,
		["49"] = 72,
		["50"] = 73,
		["51"] = 74,
		["52"] = 75,
		["53"] = 76,
		["55"] = 78,
		["57"] = 80,
		["58"] = 81,
		["59"] = 86,
		["61"] = 72,
		["62"] = 90,
		["63"] = 91,
		["64"] = 90,
		["65"] = 95,
		["66"] = 96,
		["67"] = 95,
		["68"] = 98,
		["69"] = 99,
		["70"] = 99,
		["71"] = 99,
		["72"] = 99,
		["73"] = 99,
		["74"] = 99,
		["75"] = 99,
		["76"] = 98,
		["77"] = 108,
		["78"] = 109,
		["79"] = 111,
		["80"] = 113,
		["81"] = 114,
		["82"] = 119,
		["83"] = 120,
		["84"] = 120,
		["85"] = 120,
		["86"] = 120,
		["87"] = 120,
		["89"] = 123,
		["90"] = 124,
		["91"] = 125,
		["92"] = 125,
		["93"] = 125,
		["94"] = 125,
		["95"] = 125,
		["96"] = 125,
		["97"] = 126,
		["98"] = 127,
		["99"] = 127,
		["101"] = 130,
		["102"] = 131,
		["103"] = 132,
		["104"] = 132,
		["105"] = 132,
		["106"] = 132,
		["107"] = 132,
		["108"] = 132,
		["109"] = 133,
		["110"] = 134,
		["111"] = 134,
		["113"] = 137,
		["114"] = 138,
		["115"] = 139,
		["116"] = 139,
		["117"] = 139,
		["118"] = 139,
		["119"] = 139,
		["120"] = 139,
		["121"] = 140,
		["122"] = 141,
		["123"] = 141,
		["125"] = 143,
		["126"] = 144,
		["128"] = 146,
		["131"] = 108,
		["132"] = 150,
		["133"] = 151,
		["134"] = 151,
		["135"] = 151,
		["136"] = 152,
		["137"] = 153,
		["139"] = 151,
		["140"] = 151,
		["141"] = 156,
		["142"] = 150,
		["143"] = 158,
		["144"] = 159,
		["145"] = 160,
		["146"] = 161,
		["149"] = 158,
		["150"] = 165,
		["151"] = 166,
		["152"] = 167,
		["153"] = 168,
		["156"] = 165,
		["157"] = 172,
		["158"] = 173,
		["159"] = 174,
		["160"] = 175,
		["163"] = 172,
		["164"] = 55,
		["165"] = 47,
		["166"] = 47,
		["167"] = 47,
		["168"] = 47,
		["169"] = 47,
		["170"] = 47,
		["171"] = 47,
		["172"] = 47,
		["173"] = 55,
		["175"] = 55,
		["176"] = 181,
		["177"] = 189,
		["178"] = 181,
		["179"] = 189,
		["180"] = 193,
		["181"] = 194,
		["182"] = 196,
		["183"] = 198,
		["184"] = 199,
		["185"] = 200,
		["186"] = 202,
		["188"] = 193,
		["189"] = 205,
		["190"] = 206,
		["191"] = 205,
		["192"] = 211,
		["193"] = 212,
		["196"] = 215,
		["197"] = 216,
		["198"] = 217,
		["200"] = 219,
		["201"] = 211,
		["202"] = 189,
		["203"] = 181,
		["204"] = 181,
		["205"] = 181,
		["206"] = 181,
		["207"] = 181,
		["208"] = 181,
		["209"] = 181,
		["210"] = 181,
		["211"] = 189,
		["213"] = 189,
		["214"] = 223,
		["215"] = 231,
		["216"] = 223,
		["217"] = 231,
		["218"] = 236,
		["219"] = 237,
		["220"] = 238,
		["221"] = 240,
		["222"] = 242,
		["223"] = 243,
		["224"] = 244,
		["225"] = 246,
		["227"] = 236,
		["228"] = 249,
		["229"] = 250,
		["230"] = 249,
		["231"] = 255,
		["232"] = 256,
		["235"] = 259,
		["236"] = 260,
		["237"] = 261,
		["239"] = 263,
		["240"] = 255,
		["241"] = 265,
		["242"] = 266,
		["245"] = 269,
		["246"] = 270,
		["247"] = 271,
		["249"] = 273,
		["250"] = 265,
		["251"] = 231,
		["252"] = 223,
		["253"] = 223,
		["254"] = 223,
		["255"] = 223,
		["256"] = 223,
		["257"] = 223,
		["258"] = 223,
		["259"] = 223,
		["260"] = 231,
		["262"] = 231,
		["263"] = 277,
		["264"] = 285,
		["265"] = 277,
		["266"] = 285,
		["268"] = 285,
		["269"] = 290,
		["270"] = 277,
		["271"] = 292,
		["272"] = 293,
		["273"] = 294,
		["274"] = 296,
		["275"] = 298,
		["276"] = 299,
		["277"] = 300,
		["278"] = 302,
		["280"] = 292,
		["281"] = 305,
		["282"] = 306,
		["283"] = 307,
		["284"] = 308,
		["286"] = 305,
		["287"] = 311,
		["288"] = 312,
		["289"] = 311,
		["290"] = 316,
		["291"] = 317,
		["292"] = 318,
		["294"] = 316,
		["295"] = 321,
		["296"] = 322,
		["297"] = 323,
		["300"] = 326,
		["301"] = 327,
		["302"] = 328,
		["303"] = 329,
		["304"] = 330,
		["305"] = 331,
		["306"] = 332,
		["307"] = 333,
		["309"] = 335,
		["310"] = 336,
		["313"] = 321,
		["314"] = 285,
		["315"] = 277,
		["316"] = 277,
		["317"] = 277,
		["318"] = 277,
		["319"] = 277,
		["320"] = 277,
		["321"] = 277,
		["322"] = 277,
		["323"] = 285,
		["325"] = 285,
		["326"] = 343,
		["327"] = 344,
		["328"] = 343,
		["329"] = 344,
		["330"] = 345,
		["331"] = 346,
		["332"] = 346,
		["333"] = 346,
		["334"] = 346,
		["335"] = 347,
		["336"] = 348,
		["337"] = 349,
		["338"] = 350,
		["339"] = 351,
		["340"] = 352,
		["342"] = 354,
		["343"] = 345,
		["344"] = 356,
		["345"] = 357,
		["346"] = 358,
		["347"] = 359,
		["348"] = 360,
		["351"] = 363,
		["352"] = 364,
		["354"] = 367,
		["355"] = 369,
		["356"] = 370,
		["357"] = 371,
		["358"] = 373,
		["359"] = 374,
		["360"] = 375,
		["361"] = 376,
		["362"] = 377,
		["363"] = 378,
		["364"] = 379,
		["365"] = 379,
		["366"] = 379,
		["367"] = 379,
		["368"] = 379,
		["369"] = 379,
		["370"] = 379,
		["371"] = 379,
		["372"] = 379,
		["374"] = 382,
		["375"] = 383,
		["376"] = 384,
		["377"] = 385,
		["380"] = 389,
		["381"] = 390,
		["382"] = 391,
		["383"] = 392,
		["386"] = 356,
		["387"] = 396,
		["388"] = 397,
		["389"] = 396,
		["390"] = 344,
		["391"] = 343,
		["392"] = 344,
		["394"] = 344,
		["395"] = 402,
		["396"] = 411,
		["397"] = 402,
		["398"] = 411,
		["399"] = 413,
		["400"] = 413,
		["401"] = 415,
		["402"] = 416,
		["403"] = 417,
		["405"] = 415,
		["406"] = 420,
		["407"] = 421,
		["408"] = 422,
		["409"] = 420,
		["410"] = 424,
		["411"] = 425,
		["412"] = 424,
		["413"] = 429,
		["414"] = 430,
		["415"] = 431,
		["416"] = 432,
		["418"] = 434,
		["419"] = 429,
		["420"] = 411,
		["421"] = 402,
		["422"] = 402,
		["423"] = 402,
		["424"] = 402,
		["425"] = 402,
		["426"] = 402,
		["427"] = 402,
		["428"] = 402,
		["429"] = 411,
		["431"] = 411,
		["432"] = 438,
		["433"] = 446,
		["434"] = 438,
		["435"] = 446,
		["436"] = 449,
		["437"] = 449,
		["438"] = 452,
		["439"] = 453,
		["440"] = 452,
		["441"] = 457,
		["442"] = 458,
		["443"] = 459,
		["444"] = 460,
		["445"] = 461,
		["446"] = 462,
		["447"] = 463,
		["448"] = 463,
		["449"] = 463,
		["450"] = 463,
		["451"] = 464,
		["452"] = 465,
		["453"] = 466,
		["454"] = 467,
		["456"] = 457,
		["457"] = 470,
		["458"] = 472,
		["459"] = 472,
		["460"] = 472,
		["461"] = 472,
		["463"] = 472,
		["464"] = 470,
		["465"] = 474,
		["466"] = 475,
		["467"] = 476,
		["468"] = 477,
		["469"] = 478,
		["471"] = 480,
		["472"] = 481,
		["474"] = 474,
		["475"] = 484,
		["476"] = 485,
		["477"] = 486,
		["478"] = 487,
		["479"] = 488,
		["480"] = 489,
		["481"] = 490,
		["482"] = 491,
		["483"] = 492,
		["484"] = 493,
		["485"] = 494,
		["486"] = 495,
		["488"] = 497,
		["490"] = 499,
		["491"] = 484,
		["492"] = 501,
		["493"] = 502,
		["494"] = 503,
		["495"] = 504,
		["496"] = 505,
		["497"] = 506,
		["499"] = 508,
		["500"] = 509,
		["501"] = 510,
		["502"] = 511,
		["503"] = 512,
		["504"] = 513,
		["505"] = 514,
		["507"] = 501,
		["508"] = 518,
		["509"] = 519,
		["510"] = 520,
		["511"] = 518,
		["512"] = 522,
		["513"] = 523,
		["514"] = 522,
		["515"] = 529,
		["516"] = 530,
		["517"] = 529,
		["518"] = 532,
		["519"] = 533,
		["520"] = 532,
		["521"] = 535,
		["522"] = 536,
		["523"] = 535,
		["524"] = 538,
		["525"] = 539,
		["526"] = 538,
		["527"] = 543,
		["528"] = 544,
		["529"] = 543,
		["530"] = 446,
		["531"] = 438,
		["532"] = 438,
		["533"] = 438,
		["534"] = 438,
		["535"] = 438,
		["536"] = 438,
		["537"] = 438,
		["538"] = 438,
		["539"] = 446,
		["541"] = 446,
		["542"] = 549,
		["543"] = 552,
		["544"] = 549,
		["545"] = 552,
		["546"] = 553,
		["547"] = 554,
		["548"] = 556,
		["549"] = 556,
		["550"] = 556,
		["551"] = 556,
		["552"] = 557,
		["553"] = 558,
		["554"] = 559,
		["555"] = 560,
		["557"] = 562,
		["559"] = 564,
		["560"] = 553,
		["561"] = 566,
		["562"] = 567,
		["563"] = 568,
		["565"] = 570,
		["566"] = 571,
		["568"] = 573,
		["569"] = 573,
		["570"] = 573,
		["571"] = 573,
		["572"] = 574,
		["575"] = 566,
		["576"] = 579,
		["577"] = 580,
		["580"] = 583,
		["581"] = 584,
		["582"] = 585,
		["583"] = 586,
		["584"] = 587,
		["586"] = 589,
		["589"] = 579,
		["590"] = 593,
		["591"] = 594,
		["592"] = 593,
		["593"] = 552,
		["594"] = 549,
		["595"] = 552,
		["597"] = 552,
		["598"] = 599,
		["599"] = 607,
		["600"] = 599,
		["601"] = 607,
		["603"] = 607,
		["604"] = 609,
		["605"] = 599,
		["606"] = 637,
		["607"] = 638,
		["608"] = 639,
		["609"] = 640,
		["610"] = 641,
		["611"] = 642,
		["612"] = 643,
		["613"] = 644,
		["614"] = 645,
		["615"] = 646,
		["616"] = 647,
		["617"] = 648,
		["618"] = 649,
		["619"] = 650,
		["620"] = 651,
		["621"] = 653,
		["622"] = 654,
		["623"] = 655,
		["624"] = 656,
		["625"] = 637,
		["626"] = 658,
		["627"] = 659,
		["628"] = 660,
		["629"] = 661,
		["630"] = 662,
		["631"] = 663,
		["632"] = 664,
		["633"] = 665,
		["635"] = 658,
		["636"] = 668,
		["637"] = 669,
		["638"] = 670,
		["640"] = 668,
		["641"] = 673,
		["642"] = 674,
		["643"] = 675,
		["644"] = 676,
		["645"] = 677,
		["646"] = 678,
		["649"] = 673,
		["650"] = 683,
		["651"] = 683,
		["652"] = 683,
		["654"] = 684,
		["657"] = 687,
		["658"] = 688,
		["659"] = 688,
		["660"] = 688,
		["662"] = 688,
		["663"] = 689,
		["664"] = 689,
		["665"] = 689,
		["667"] = 689,
		["668"] = 690,
		["669"] = 691,
		["670"] = 692,
		["672"] = 693,
		["673"] = 693,
		["674"] = 694,
		["675"] = 695,
		["676"] = 696,
		["677"] = 697,
		["681"] = 693,
		["685"] = 703,
		["686"] = 704,
		["687"] = 705,
		["688"] = 706,
		["691"] = 683,
		["692"] = 711,
		["693"] = 712,
		["696"] = 715,
		["697"] = 716,
		["698"] = 717,
		["700"] = 711,
		["701"] = 721,
		["702"] = 722,
		["705"] = 725,
		["706"] = 726,
		["707"] = 727,
		["709"] = 721,
		["710"] = 730,
		["711"] = 731,
		["714"] = 734,
		["715"] = 735,
		["717"] = 737,
		["718"] = 730,
		["719"] = 739,
		["720"] = 740,
		["723"] = 743,
		["724"] = 744,
		["725"] = 745,
		["726"] = 746,
		["728"] = 748,
		["729"] = 739,
		["730"] = 751,
		["731"] = 752,
		["734"] = 755,
		["735"] = 757,
		["736"] = 758,
		["737"] = 759,
		["738"] = 760,
		["741"] = 763,
		["743"] = 751,
		["744"] = 766,
		["745"] = 767,
		["748"] = 770,
		["749"] = 771,
		["750"] = 772,
		["751"] = 773,
		["752"] = 774,
		["754"] = 776,
		["757"] = 779,
		["758"] = 780,
		["759"] = 781,
		["761"] = 782,
		["762"] = 782,
		["763"] = 783,
		["764"] = 784,
		["767"] = 782,
		["771"] = 789,
		["773"] = 790,
		["774"] = 790,
		["775"] = 791,
		["776"] = 792,
		["779"] = 790,
		["783"] = 797,
		["784"] = 798,
		["785"] = 798,
		["786"] = 798,
		["787"] = 799,
		["788"] = 798,
		["789"] = 798,
		["791"] = 802,
		["792"] = 802,
		["793"] = 802,
		["794"] = 802,
		["795"] = 802,
		["796"] = 803,
		["797"] = 804,
		["798"] = 805,
		["800"] = 808,
		["801"] = 802,
		["802"] = 802,
		["805"] = 766,
		["806"] = 814,
		["807"] = 815,
		["810"] = 818,
		["811"] = 819,
		["812"] = 820,
		["813"] = 821,
		["814"] = 822,
		["815"] = 823,
		["816"] = 824,
		["817"] = 825,
		["818"] = 826,
		["820"] = 829,
		["821"] = 830,
		["822"] = 831,
		["823"] = 832,
		["824"] = 833,
		["826"] = 835,
		["827"] = 836,
		["828"] = 837,
		["833"] = 842,
		["834"] = 843,
		["835"] = 843,
		["836"] = 843,
		["837"] = 843,
		["838"] = 843,
		["841"] = 814,
		["842"] = 848,
		["843"] = 849,
		["844"] = 850,
		["845"] = 851,
		["846"] = 852,
		["847"] = 853,
		["848"] = 854,
		["849"] = 855,
		["851"] = 857,
		["852"] = 858,
		["854"] = 860,
		["855"] = 861,
		["857"] = 863,
		["858"] = 863,
		["859"] = 863,
		["860"] = 863,
		["861"] = 863,
		["862"] = 864,
		["864"] = 866,
		["865"] = 867,
		["866"] = 868,
		["868"] = 848,
		["869"] = 876,
		["870"] = 877,
		["871"] = 878,
		["872"] = 879,
		["873"] = 879,
		["874"] = 879,
		["875"] = 879,
		["876"] = 880,
		["878"] = 882,
		["879"] = 882,
		["880"] = 882,
		["881"] = 882,
		["882"] = 882,
		["883"] = 882,
		["885"] = 882,
		["887"] = 884,
		["888"] = 876,
		["889"] = 886,
		["890"] = 887,
		["891"] = 887,
		["892"] = 887,
		["893"] = 887,
		["894"] = 887,
		["895"] = 887,
		["897"] = 887,
		["898"] = 888,
		["899"] = 886,
		["900"] = 890,
		["901"] = 891,
		["902"] = 890,
		["903"] = 896,
		["904"] = 897,
		["905"] = 896,
		["906"] = 901,
		["907"] = 902,
		["908"] = 903,
		["910"] = 901,
		["911"] = 906,
		["912"] = 907,
		["913"] = 907,
		["914"] = 907,
		["915"] = 907,
		["916"] = 907,
		["917"] = 907,
		["918"] = 907,
		["919"] = 907,
		["920"] = 906,
		["921"] = 917,
		["922"] = 918,
		["923"] = 919,
		["924"] = 920,
		["927"] = 921,
		["928"] = 922,
		["929"] = 923,
		["930"] = 924,
		["931"] = 925,
		["933"] = 928,
		["934"] = 929,
		["935"] = 930,
		["937"] = 932,
		["938"] = 933,
		["939"] = 933,
		["940"] = 933,
		["941"] = 933,
		["942"] = 933,
		["943"] = 933,
		["945"] = 917,
		["946"] = 936,
		["947"] = 937,
		["949"] = 938,
		["950"] = 939,
		["952"] = 940,
		["954"] = 941,
		["956"] = 942,
		["958"] = 943,
		["960"] = 944,
		["962"] = 945,
		["964"] = 946,
		["967"] = 936,
		["968"] = 950,
		["969"] = 951,
		["970"] = 952,
		["971"] = 954,
		["972"] = 955,
		["973"] = 956,
		["974"] = 957,
		["975"] = 958,
		["976"] = 959,
		["977"] = 959,
		["978"] = 959,
		["979"] = 959,
		["980"] = 959,
		["981"] = 959,
		["982"] = 959,
		["983"] = 959,
		["984"] = 959,
		["985"] = 959,
		["986"] = 959,
		["987"] = 959,
		["988"] = 967,
		["989"] = 968,
		["993"] = 950,
		["994"] = 974,
		["995"] = 975,
		["996"] = 976,
		["997"] = 976,
		["998"] = 976,
		["999"] = 976,
		["1000"] = 976,
		["1001"] = 976,
		["1002"] = 976,
		["1004"] = 978,
		["1005"] = 979,
		["1006"] = 979,
		["1007"] = 979,
		["1008"] = 979,
		["1009"] = 979,
		["1010"] = 979,
		["1011"] = 979,
		["1013"] = 981,
		["1014"] = 982,
		["1016"] = 974,
		["1017"] = 985,
		["1018"] = 986,
		["1019"] = 985,
		["1020"] = 988,
		["1021"] = 989,
		["1022"] = 990,
		["1023"] = 991,
		["1025"] = 988,
		["1026"] = 994,
		["1027"] = 995,
		["1028"] = 994,
		["1029"] = 607,
		["1030"] = 599,
		["1031"] = 599,
		["1032"] = 599,
		["1033"] = 599,
		["1034"] = 599,
		["1035"] = 599,
		["1036"] = 599,
		["1037"] = 599,
		["1038"] = 607,
		["1040"] = 607,
		["1041"] = 1002,
		["1042"] = 1003,
		["1043"] = 1002,
		["1044"] = 1003,
		["1045"] = 1004,
		["1046"] = 1005,
		["1047"] = 1006,
		["1048"] = 1007,
		["1051"] = 1010,
		["1052"] = 1011,
		["1053"] = 1014,
		["1054"] = 1015,
		["1055"] = 1016,
		["1057"] = 1020,
		["1058"] = 1021,
		["1059"] = 1021,
		["1060"] = 1021,
		["1061"] = 1021,
		["1062"] = 1022,
		["1063"] = 1022,
		["1064"] = 1022,
		["1065"] = 1022,
		["1066"] = 1022,
		["1067"] = 1022,
		["1068"] = 1022,
		["1069"] = 1022,
		["1070"] = 1030,
		["1071"] = 1031,
		["1072"] = 1032,
		["1073"] = 1033,
		["1074"] = 1034,
		["1075"] = 1034,
		["1076"] = 1034,
		["1077"] = 1034,
		["1078"] = 1034,
		["1079"] = 1033,
		["1081"] = 1043,
		["1082"] = 1044,
		["1083"] = 1045,
		["1086"] = 1022,
		["1087"] = 1022,
		["1088"] = 1004,
		["1089"] = 1003,
		["1090"] = 1002,
		["1091"] = 1003,
		["1093"] = 1003,
		["1094"] = 1053,
		["1095"] = 1061,
		["1096"] = 1053,
		["1097"] = 1061,
		["1099"] = 1061,
		["1100"] = 1065,
		["1101"] = 1067,
		["1102"] = 1068,
		["1103"] = 1053,
		["1104"] = 1070,
		["1105"] = 1071,
		["1106"] = 1070,
		["1107"] = 1074,
		["1108"] = 1075,
		["1109"] = 1076,
		["1110"] = 1077,
		["1111"] = 1078,
		["1112"] = 1074,
		["1113"] = 1081,
		["1114"] = 1082,
		["1115"] = 1083,
		["1116"] = 1084,
		["1117"] = 1085,
		["1118"] = 1086,
		["1119"] = 1087,
		["1120"] = 1088,
		["1121"] = 1089,
		["1122"] = 1090,
		["1124"] = 1093,
		["1125"] = 1093,
		["1127"] = 1081,
		["1128"] = 1097,
		["1129"] = 1098,
		["1130"] = 1099,
		["1131"] = 1100,
		["1133"] = 1102,
		["1134"] = 1103,
		["1136"] = 1105,
		["1137"] = 1106,
		["1138"] = 1106,
		["1140"] = 1097,
		["1141"] = 1110,
		["1142"] = 1111,
		["1143"] = 1112,
		["1144"] = 1113,
		["1145"] = 1113,
		["1146"] = 1113,
		["1147"] = 1113,
		["1148"] = 1113,
		["1149"] = 1113,
		["1150"] = 1114,
		["1151"] = 1115,
		["1154"] = 1118,
		["1155"] = 1118,
		["1156"] = 1119,
		["1157"] = 1120,
		["1158"] = 1121,
		["1160"] = 1118,
		["1163"] = 1110,
		["1164"] = 1061,
		["1165"] = 1053,
		["1166"] = 1053,
		["1167"] = 1053,
		["1168"] = 1053,
		["1169"] = 1053,
		["1170"] = 1053,
		["1171"] = 1053,
		["1172"] = 1053,
		["1173"] = 1061,
		["1175"] = 1061,
		["1176"] = 1129,
		["1177"] = 1137,
		["1178"] = 1129,
		["1179"] = 1137,
		["1181"] = 1137,
		["1182"] = 1139,
		["1183"] = 1140,
		["1184"] = 1129,
		["1185"] = 1141,
		["1186"] = 1142,
		["1187"] = 1143,
		["1188"] = 1144,
		["1189"] = 1145,
		["1191"] = 1141,
		["1192"] = 1148,
		["1193"] = 1149,
		["1194"] = 1150,
		["1195"] = 1151,
		["1197"] = 1148,
		["1198"] = 1154,
		["1199"] = 1155,
		["1200"] = 1154,
		["1201"] = 1159,
		["1202"] = 1160,
		["1203"] = 1161,
		["1205"] = 1159,
		["1206"] = 1164,
		["1207"] = 1165,
		["1208"] = 1164,
		["1209"] = 1137,
		["1210"] = 1129,
		["1211"] = 1129,
		["1212"] = 1129,
		["1213"] = 1129,
		["1214"] = 1129,
		["1215"] = 1129,
		["1216"] = 1129,
		["1217"] = 1129,
		["1218"] = 1137,
		["1220"] = 1137,
		["1221"] = 1171,
		["1222"] = 1172,
		["1223"] = 1171,
		["1224"] = 1172,
		["1225"] = 1173,
		["1226"] = 1174,
		["1227"] = 1175,
		["1228"] = 1176,
		["1231"] = 1179,
		["1232"] = 1183,
		["1233"] = 1184,
		["1234"] = 1184,
		["1235"] = 1184,
		["1236"] = 1184,
		["1237"] = 1185,
		["1238"] = 1186,
		["1239"] = 1186,
		["1240"] = 1186,
		["1241"] = 1186,
		["1242"] = 1186,
		["1243"] = 1186,
		["1244"] = 1187,
		["1245"] = 1188,
		["1246"] = 1189,
		["1247"] = 1190,
		["1248"] = 1173,
		["1249"] = 1172,
		["1250"] = 1171,
		["1251"] = 1172,
		["1253"] = 1172,
		["1254"] = 1197,
		["1255"] = 1206,
		["1256"] = 1197,
		["1257"] = 1206,
		["1258"] = 1212,
		["1259"] = 1213,
		["1260"] = 1214,
		["1261"] = 1212,
		["1262"] = 1216,
		["1263"] = 1217,
		["1264"] = 1218,
		["1265"] = 1219,
		["1266"] = 1220,
		["1268"] = 1223,
		["1269"] = 1224,
		["1270"] = 1225,
		["1271"] = 1226,
		["1272"] = 1227,
		["1273"] = 1229,
		["1274"] = 1229,
		["1275"] = 1229,
		["1276"] = 1229,
		["1277"] = 1229,
		["1278"] = 1230,
		["1280"] = 1216,
		["1281"] = 1233,
		["1282"] = 1234,
		["1283"] = 1235,
		["1284"] = 1236,
		["1286"] = 1238,
		["1287"] = 1239,
		["1289"] = 1241,
		["1290"] = 1242,
		["1291"] = 1243,
		["1292"] = 1244,
		["1293"] = 1245,
		["1294"] = 1247,
		["1295"] = 1247,
		["1296"] = 1247,
		["1297"] = 1247,
		["1298"] = 1247,
		["1300"] = 1233,
		["1301"] = 1250,
		["1302"] = 1251,
		["1303"] = 1252,
		["1304"] = 1253,
		["1306"] = 1255,
		["1308"] = 1250,
		["1309"] = 1258,
		["1310"] = 1259,
		["1311"] = 1260,
		["1312"] = 1261,
		["1313"] = 1262,
		["1315"] = 1264,
		["1316"] = 1264,
		["1317"] = 1264,
		["1318"] = 1264,
		["1319"] = 1264,
		["1320"] = 1264,
		["1321"] = 1264,
		["1323"] = 1258,
		["1324"] = 1206,
		["1325"] = 1197,
		["1326"] = 1197,
		["1327"] = 1197,
		["1328"] = 1197,
		["1329"] = 1197,
		["1330"] = 1197,
		["1331"] = 1197,
		["1332"] = 1197,
		["1333"] = 1197,
		["1334"] = 1206,
		["1336"] = 1206,
		["1337"] = 1270,
		["1338"] = 1271,
		["1339"] = 1270,
		["1340"] = 1271,
		["1341"] = 1272,
		["1342"] = 1273,
		["1343"] = 1274,
		["1344"] = 1275,
		["1347"] = 1278,
		["1348"] = 1279,
		["1349"] = 1280,
		["1350"] = 1281,
		["1351"] = 1282,
		["1353"] = 1285,
		["1354"] = 1286,
		["1355"] = 1286,
		["1356"] = 1286,
		["1357"] = 1286,
		["1358"] = 1286,
		["1359"] = 1286,
		["1360"] = 1292,
		["1361"] = 1293,
		["1362"] = 1294,
		["1363"] = 1295,
		["1364"] = 1295,
		["1365"] = 1295,
		["1366"] = 1295,
		["1367"] = 1295,
		["1368"] = 1295,
		["1369"] = 1295,
		["1370"] = 1295,
		["1371"] = 1295,
		["1372"] = 1296,
		["1373"] = 1297,
		["1374"] = 1298,
		["1375"] = 1299,
		["1376"] = 1300,
		["1377"] = 1301,
		["1378"] = 1302,
		["1381"] = 1286,
		["1382"] = 1286,
		["1383"] = 1272,
		["1384"] = 1271,
		["1385"] = 1270,
		["1386"] = 1271,
		["1388"] = 1271,
		["1389"] = 1312,
		["1390"] = 1313,
		["1391"] = 1312,
		["1392"] = 1313,
		["1393"] = 1314,
		["1394"] = 1315,
		["1395"] = 1314,
		["1396"] = 1313,
		["1397"] = 1312,
		["1398"] = 1313,
		["1400"] = 1313,
		["1401"] = 1318,
		["1402"] = 1326,
		["1403"] = 1318,
		["1404"] = 1326,
		["1405"] = 1328,
		["1406"] = 1329,
		["1407"] = 1328,
		["1408"] = 1332,
		["1409"] = 1333,
		["1410"] = 1332,
		["1411"] = 1337,
		["1412"] = 1338,
		["1413"] = 1339,
		["1414"] = 1340,
		["1416"] = 1337,
		["1417"] = 1343,
		["1418"] = 1344,
		["1419"] = 1343,
		["1420"] = 1348,
		["1421"] = 1349,
		["1422"] = 1348,
		["1423"] = 1326,
		["1424"] = 1318,
		["1425"] = 1318,
		["1426"] = 1318,
		["1427"] = 1318,
		["1428"] = 1318,
		["1429"] = 1318,
		["1430"] = 1318,
		["1431"] = 1318,
		["1432"] = 1326,
		["1434"] = 1326,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = require("abilities.ability_ai")
local t = s.BaseAbilityAI
local u = s.registerAbilityAI
local v = require("abilities.interact_ability")
local w = v.InteractAbility
local x = v.registerInteractAbility
local y = {
	[0] = {
		skin = "default",
		attack = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf",
		transform = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf",
		sound = "Hero_DragonKnight.ElderDragonShoot1.Attack",
	},
	[1] = {
		skin = "1",
		attack = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf",
		transform = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red.vpcf",
		sound = "Hero_DragonKnight.ElderDragonShoot2.Attack",
	},
	[2] = {
		skin = "2",
		attack = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf",
		transform = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf",
		sound = "Hero_DragonKnight.ElderDragonShoot3.Attack",
	},
	[3] = {
		skin = "3",
		attack = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_attack_black.vpcf",
		transform = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_black.vpcf",
		sound = "Hero_DragonKnight.ElderDragonShoot3.Attack",
	},
}
local z = { [0] = { "poison_1", "poison_2", "poison_3" }, [1] = { "fire_1", "fire_2", "fire_3" }, [2] = {
	"ice_1",
	"ice_2",
	"ice_3",
} }
local A = { "black_1" }
l.dragon_knight_talent = c()
local B = l.dragon_knight_talent
B.name = "dragon_knight_talent"
d(B, n)
function B.prototype.GetIntrinsicModifierName(self)
	return "modifier_dragon_knight_talent"
end
B = e({ o(nil) }, B)
l.dragon_knight_talent = B
l.modifier_dragon_knight_talent = c()
local C = l.modifier_dragon_knight_talent
C.name = "modifier_dragon_knight_talent"
d(C, q)
function C.prototype.GetAbilitySpecialValue(self)
	self.poison_reduce_pct = self:GetAbilitySpecialValueFor("poison_reduce_pct")
	self.tl1_warpath = self:GetAbilityTalentValue("dragon_knight_talent_1", "warpath")
	self.tl2_counter_critical = self:GetAbilityTalentValue("dragon_knight_talent_2", "warpath")
end
function C.prototype.OnCreated(self, D)
	if IsServer() then
		self.buffList = {}
		if self:HasTalent("dragon_knight_talent_1") then
			SetCustomManaState(self.caster, true)
		else
			SetCustomManaState(self.caster, false)
		end
		self.dragon_type = 0
		self.upgrade_record = { [0] = 0, [1] = 0, [2] = 0 }
		self:GetCount("upgrade_point_record")
	end
end
function C.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_COUNTER_CRITICAL_CHANCE }
end
function C.prototype.EOM_GetModifierCounterCriticalChance(self, D)
	return self.tl2_counter_critical
end
function C.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self.caster },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_GAINED] = { self.caster },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self.caster },
	}
end
function C.prototype.OnBattleStartBefore(self, D)
	if IsServer() then
		self.dragon_type = self.parent:GetModifierStackCount("modifier_dragon_knight_interact", self.parent)
		local E = self.parent:GetPlayerOwnerID()
		self.upgrade_record = { [0] = 0, [1] = 0, [2] = 0 }
		for F, G in pairs(z) do
			self.upgrade_record[F] = f(G, function(H, I, J)
				return AbilityUpgrades:HasAbilityMechanicsUpgradeByID(E, J) and I + 1 or I
			end, 0)
		end
		local K = self.upgrade_record[0]
		if K > 0 then
			local L = self.caster
				:GetEnemy()
				:AddNewModifier(self.caster, self:GetAbility(), "modifier_dragon_knight_talent_poison", nil)
			L:SetStackCount(K)
			local M = self.buffList
			M[#M + 1] = L
		end
		local N = self.upgrade_record[1]
		if N > 0 then
			local L =
				self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_dragon_knight_talent_fury", nil)
			L:SetStackCount(N)
			local O = self.buffList
			O[#O + 1] = L
		end
		local P = self.upgrade_record[2]
		if P > 0 then
			local L =
				self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_dragon_knight_talent_ice", nil)
			L:SetStackCount(P)
			local Q = self.buffList
			Q[#Q + 1] = L
		end
		if self:HasTalent("dragon_knight_talent_1") then
			SetCustomManaState(self.caster, true)
		else
			SetCustomManaState(self.caster, false)
		end
	end
end
function C.prototype.OnBattleEnd(self, D)
	g(self.buffList, function(H, R)
		if IsValid(R) then
			R:Destroy()
		end
	end)
	self.buffList = {}
end
function C.prototype.OnFuryGained(self, D)
	if IsServer() then
		if self.dragon_type == 1 and self:HasTalent("dragon_knight_talent_1") then
			RestoreCustomMana(self.caster, BUFF_VALUE.CustomManaModelFire)
		end
	end
end
function C.prototype.OnPoisonGained(self, D)
	if IsServer() then
		if self.dragon_type == 0 and self:HasTalent("dragon_knight_talent_1") then
			RestoreCustomMana(self.caster, BUFF_VALUE.CustomManaModelPoison)
		end
	end
end
function C.prototype.OnIceGained(self, D)
	if IsServer() then
		if self.dragon_type == 2 and self:HasTalent("dragon_knight_talent_1") then
			RestoreCustomMana(self.caster, BUFF_VALUE.CustomManaModelIce)
		end
	end
end
C = e(
	{
		r(
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
	C
)
l.modifier_dragon_knight_talent = C
l.modifier_dragon_knight_talent_poison = c()
local S = l.modifier_dragon_knight_talent_poison
S.name = "modifier_dragon_knight_talent_poison"
d(S, q)
function S.prototype.GetAbilitySpecialValue(self)
	self.poison_reduce_pct = self:GetAbilitySpecialValueFor("poison_reduce_pct")
	self.b1_bonus_pct = self:GetAbilitySpecialValueFor("b1_bonus_pct")
	self.ult_affect_pct = 0
	local T = self.caster:FindAbilityByName("dragon_knight_ult")
	if T then
		self.ult_affect_pct = T:GetSpecialValueFor("affect_pct")
			+ self:GetAbilityTalentValue("dragon_knight_talent_3", "affect_pct")
	end
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function S.prototype.EOM_GetModifierIncomingDamagePercentage(self, D)
	if self.caster:PassivesDisabled() then
		return
	end
	local U = 1 + self.b1_bonus_pct * 0.01
	if self.caster:HasModifier("modifier_dragon_knight_model") then
		U = U + self.ult_affect_pct * 0.01
	end
	return self:GetStackCount() * self.poison_reduce_pct * U
end
S = e(
	{
		r(
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
	S
)
l.modifier_dragon_knight_talent_poison = S
l.modifier_dragon_knight_talent_fury = c()
local V = l.modifier_dragon_knight_talent_fury
V.name = "modifier_dragon_knight_talent_fury"
d(V, q)
function V.prototype.GetAbilitySpecialValue(self)
	self.fury_bonus_atk = self:GetAbilitySpecialValueFor("fury_bonus_atk")
	self.fury_bonus_atkSpeed = self:GetAbilitySpecialValueFor("fury_bonus_atkSpeed")
	self.b1_bonus_pct = self:GetAbilitySpecialValueFor("b1_bonus_pct")
	self.ult_affect_pct = 0
	local T = self.parent:FindAbilityByName("dragon_knight_ult")
	if T then
		self.ult_affect_pct = T:GetSpecialValueFor("affect_pct")
			+ self:GetAbilityTalentValue("dragon_knight_talent_3", "affect_pct")
	end
end
function V.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function V.prototype.EOM_GetModifierAttackDamageBonus(self, D)
	if self.caster:PassivesDisabled() then
		return
	end
	local U = 1 + self.b1_bonus_pct * 0.01
	if self.caster:HasModifier("modifier_dragon_knight_model") then
		U = U + self.ult_affect_pct * 0.01
	end
	return self:GetStackCount() * self.fury_bonus_atk * U
end
function V.prototype.EOM_GetModifierAttackSpeedBonus(self, D)
	if self.caster:PassivesDisabled() then
		return
	end
	local U = 1 + self.b1_bonus_pct * 0.01
	if self.caster:HasModifier("modifier_dragon_knight_model") then
		U = U + self.ult_affect_pct * 0.01
	end
	return self:GetStackCount() * self.fury_bonus_atkSpeed * U
end
V = e(
	{
		r(
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
	V
)
l.modifier_dragon_knight_talent_fury = V
l.modifier_dragon_knight_talent_ice = c()
local W = l.modifier_dragon_knight_talent_ice
W.name = "modifier_dragon_knight_talent_ice"
d(W, q)
function W.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.tick = 0.1
end
function W.prototype.GetAbilitySpecialValue(self)
	self.ice_regen = self:GetAbilitySpecialValueFor("ice_regen")
	self.ice_mana_regen = self:GetAbilitySpecialValueFor("ice_mana_regen")
	self.b1_bonus_pct = self:GetAbilitySpecialValueFor("b1_bonus_pct")
	self.ult_affect_pct = 0
	local T = self.parent:FindAbilityByName("dragon_knight_ult")
	if T then
		self.ult_affect_pct = T:GetSpecialValueFor("affect_pct")
			+ self:GetAbilityTalentValue("dragon_knight_talent_3", "affect_pct")
	end
end
function W.prototype.OnCreated(self, D)
	if IsServer() then
		self:StartIntervalThink(self.tick)
		self.record = 0
	end
end
function W.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent } }
end
function W.prototype.OnBattleEnd(self, D)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function W.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.caster:PassivesDisabled() then
			return
		end
		self.record = self.record + self.tick
		if self.record >= 1 then
			self.record = 0
			local X = self.ice_regen * self:GetStackCount()
			local Y = self.ice_mana_regen * self:GetStackCount()
			local U = 1 + self.b1_bonus_pct * 0.01
			if self.caster:HasModifier("modifier_dragon_knight_model") then
				U = U + self.ult_affect_pct * 0.01
			end
			Heal(self.caster, X * U, "dragon_knight_talent", "Ability")
			Restore(self.caster, Y * U)
		end
	end
end
W = e(
	{
		r(
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
	W
)
l.modifier_dragon_knight_talent_ice = W
l.dragon_knight_ult = c()
local Z = l.dragon_knight_ult
Z.name = "dragon_knight_ult"
d(Z, t)
function Z.prototype.GetAbilityTextureName(self)
	local _ = self:GetCaster():GetModifierStackCount("modifier_dragon_knight_ult_intrinsic", self:GetCaster())
	if _ == 1 then
		return "dragon_knight_splash"
	elseif _ == 2 then
		return "dragon_knight_frost"
	elseif _ == 3 then
		return "dragon_knight_black_dragon"
	end
	return "dragon_knight_corrosive"
end
function Z.prototype.OnSpellStart(self, a0)
	local a1 = self:GetSpecialValueFor("duration")
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a2, a3) then
		return
	end
	if not a2:HasModifier("modifier_dragon_knight_talent_6") then
		a2:AddNewModifier(a2, self, "modifier_dragon_knight_model", { duration = a1 })
	end
	local a4 = self:GetTalentValue("dragon_knight_talent_4", "affect_pct")
	local a5 = self:GetSpecialValueFor("i3_heal_pct")
	local a6 = self:GetSpecialValueFor("f3_fury_base_dmg")
	local E = a2:GetPlayerOwnerID()
	local a7 = self:GetSpecialValueFor("f2_duration")
	local a8 = self:GetSpecialValueFor("f2_interval")
	local a9 = self:GetSpecialValueFor("f2_base_dmg")
	local aa = self:GetSpecialValueFor("f2_fury_dmg_pct")
	local ab = a2:FindAbilityByName("dragon_knight_fire")
	if ab then
		ab:OnSpellStart(a4, a5, a7, a8, a9, aa, a6)
	end
	if AbilityUpgrades:HasAbilityMechanicsUpgradeByID(E, "poison_2") then
		local ab = a2:FindAbilityByName("dragon_knight_poison")
		if ab then
			ab:OnSpellStart(a4, a5)
		end
	end
	if AbilityUpgrades:HasAbilityMechanicsUpgradeByID(E, "ice_2") then
		local ab = a2:FindAbilityByName("dragon_knight_ice")
		if ab then
			ab:OnSpellStart(a4, a5)
		end
	end
end
function Z.prototype.GetIntrinsicModifierName(self)
	return "modifier_dragon_knight_ult_intrinsic"
end
Z = e({ u(nil) }, Z)
l.dragon_knight_ult = Z
l.modifier_dragon_knight_ult_intrinsic = c()
local ac = l.modifier_dragon_knight_ult_intrinsic
ac.name = "modifier_dragon_knight_ult_intrinsic"
d(ac, q)
function ac.prototype.GetAbilitySpecialValue(self) end
function ac.prototype.UpdateDragonConfig(self, ad)
	if ad and y[ad] then
		self:SetStackCount(ad)
	end
end
function ac.prototype.OnStackCountChanged(self, ae)
	local _ = self:GetStackCount()
	self.transfrom_config = y[_]
end
function ac.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function ac.prototype.GetAttackSound(self)
	local af = "Hero_DragonKnight.Attack"
	if self.parent:HasModifier("modifier_dragon_knight_model") then
		af = self.transfrom_config.sound
	end
	return Wearable:getReplaceSound(self.parent, af)
end
ac = e(
	{
		r(
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
	ac
)
l.modifier_dragon_knight_ult_intrinsic = ac
l.modifier_dragon_knight_model = c()
local ag = l.modifier_dragon_knight_model
ag.name = "modifier_dragon_knight_model"
d(ag, q)
function ag.prototype.GetAbilitySpecialValue(self) end
function ag.prototype.AddCustomTransmitterData(self)
	return { origin_model = self.origin_model }
end
function ag.prototype.HandleCustomTransmitterData(self, ah)
	self.origin_model = ah.origin_model
	local _ = self:GetStackCount()
	self.transfrom_config = y[_]
	local E = self:GetParent():GetPlayerOwnerID()
	local ai = self.origin_model
	local aj = Wearable:getReplaceParticle(self:GetParent(), "models/heroes/dragon_knight/dragon_knight_dragon.vmdl")
	if self:GetDuration() < 0 then
		Wearable:registerUnitWearablesModifier(E, ai, {})
		Wearable:registerUnitPortraitModifier(E, ai, aj)
		Wearable:registerUnitPortraitSkinModifier(E, aj, self.transfrom_config.skin, true)
	end
end
function ag.prototype.GetOriginModel(self)
	local ak = self.parent:FindModifierByName("modifier_skin")
	local al = ak and ak.originModel
	if al == nil then
		al = "models/heroes/dragon_knight/dragon_knight.vmdl"
	end
	return al
end
function ag.prototype.GetDragonConfig(self)
	local _ = 0
	local am = self.parent:FindModifierByName("modifier_dragon_knight_interact")
	if am then
		_ = am:GetDragonType()
	end
	if _ and y[_] then
		self:SetStackCount(_)
	end
end
function ag.prototype.OnCreated(self, D)
	self.transfrom_config = y[0]
	if IsServer() then
		self.origin_model = self:GetOriginModel()
		self:GetDragonConfig()
		self.parent:SetWearablesVisible(false)
		self.parent:SetOriginalModel(
			Wearable:getReplaceParticle(self.parent, "models/heroes/dragon_knight/dragon_knight_dragon.vmdl")
		)
		self.parent:ManageModelChanges()
		self.parent:SetSkin(self:GetStackCount())
		ParticleManager:CreateParticle(self.transfrom_config.transform, PATTACH_ABSORIGIN, self.parent)
		self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	else
		EmitSoundOn("Hero_DragonKnight.ElderDragonForm", self.parent)
	end
	self:SetHasCustomTransmitterData(true)
end
function ag.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:SetWearablesVisible(true)
		self.parent:SetOriginalModel(self.origin_model)
		self.parent:ManageModelChanges()
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	else
		EmitSoundOn("Hero_DragonKnight.ElderDragonForm.Revert", self.parent)
		local E = self.parent:GetPlayerOwnerID()
		local ai = self.origin_model
		local aj = Wearable:getReplaceParticle(self.parent, "models/heroes/dragon_knight/dragon_knight_dragon.vmdl")
		Wearable:unregisterUnitPortraitModifier(E, ai)
		Wearable:unregisterUnitWearablesModifier(E, ai)
		Wearable:unregisterUnitPortraitSkinModifier(E, aj, true)
	end
end
function ag.prototype.OnStackCountChanged(self, ae)
	local _ = self:GetStackCount()
	self.transfrom_config = y[_]
end
function ag.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_PROJECTILE_SPEED, MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function ag.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CONSTANT_LAYER
end
function ag.prototype.GetModifierProjectileName(self)
	return Wearable:getReplaceParticle(self.parent, self.transfrom_config.attack)
end
function ag.prototype.GetModifierProjectileSpeed(self)
	return 1200
end
function ag.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent } }
end
function ag.prototype.OnCustomAttackLanded(self, an)
	an.target:EmitSound("Hero_DragonKnight.ProjectileImpact")
end
ag = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	ag
)
l.modifier_dragon_knight_model = ag
l.dragon_knight_interact = c()
local ao = l.dragon_knight_interact
ao.name = "dragon_knight_interact"
d(ao, w)
function ao.prototype.GetAbilityTextureName(self)
	if self:GetCurrentAbilityCharges() == 0 then
		local _ = self:GetCaster():GetModifierStackCount("modifier_dragon_knight_interact", self:GetCaster())
		if _ == 1 then
			return "dragon_knight_splash"
		elseif _ == 2 then
			return "dragon_knight_frost"
		end
		return "dragon_knight_corrosive"
	end
	return "dragon_knight/dk_persona/dragon_knight_elder_dragon_form_persona1"
end
function ao.prototype.CustomToggleEnable(self)
	if self:GetCurrentAbilityCharges() > 0 then
		return true
	else
		if GameState:isCeaseFireState() then
			return true
		else
			ErrorMessage(self:GetCaster():GetPlayerOwnerID(), "error_disabled_battling")
			return false
		end
	end
end
function ao.prototype.OnSpellStart(self)
	if self:GetCaster():IsCustomIllusion() then
		return
	end
	local am = self:GetCaster():FindModifierByName("modifier_dragon_knight_interact")
	if am then
		local ap = self:GetCurrentAbilityCharges()
		if ap > 0 then
			am:Effect()
		else
			am:SwtichDragonType()
		end
	end
end
function ao.prototype.GetIntrinsicModifierName(self)
	return "modifier_dragon_knight_interact"
end
ao = e({ x(nil, { DisableToggle = true }) }, ao)
l.dragon_knight_interact = ao
l.modifier_dragon_knight_interact = c()
local aq = l.modifier_dragon_knight_interact
aq.name = "modifier_dragon_knight_interact"
d(aq, q)
function aq.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.effect_proc = false
end
function aq.prototype.GetAbilitySpecialValue(self)
	self.t4_affect_pct = self:GetAbilityTalentValue("dragon_knight_talent_4", "affect_pct")
	self.level = self:GetAbilitySpecialValueFor("level")
	self.upgrade_point = self:GetAbilitySpecialValueFor("upgrade_point")
	self.max_cnt = self:GetAbilitySpecialValueFor("max_cnt")
	self.tl5_upgrade_point = self:GetAbilityTalentValue("dragon_knight_talent_5", "upgrade_point")
	self.s_upgrade_point = self:GetAbilityTalentValue("dragon_knight_shard", "upgrade_point")
	self.f1_add_fury = self:GetAbilitySpecialValueFor("f1_add_fury")
	self.f3_fire_chance = self:GetAbilitySpecialValueFor("f3_fire_chance")
	self.f3_duration = self:GetAbilitySpecialValueFor("f3_duration")
	self.p1_poison_count = self:GetAbilitySpecialValueFor("p1_poison_count")
	self.p3_chance = self:GetAbilitySpecialValueFor("p3_chance")
	self.i1_ice_count = self:GetAbilitySpecialValueFor("i1_ice_count")
	self.i3_heal_pct = self:GetAbilitySpecialValueFor("i3_heal_pct")
	self.f3_fury_base_dmg = self:GetAbilitySpecialValueFor("f3_fury_base_dmg")
	self.f2_duration = self:GetAbilitySpecialValueFor("f2_duration")
	self.f2_interval = self:GetAbilitySpecialValueFor("f2_interval")
	self.f2_base_dmg = self:GetAbilitySpecialValueFor("f2_base_dmg")
	self.f2_fury_dmg_pct = self:GetAbilitySpecialValueFor("f2_fury_dmg_pct")
end
function aq.prototype.OnCreated(self, D)
	if IsServer() then
		self:checkLevel()
		self:SwtichDragonType(true)
		self:UpdateEvolutionPoint()
		self:checkTalent5()
		self:checkShard()
		self:SetDragonType()
	end
end
function aq.prototype.OnRefresh(self, D)
	if IsServer() then
		self:checkShard()
	end
end
function aq.prototype.OnDestroy(self)
	if IsServer() then
		if self.selection_key then
			local E = self.parent:GetPlayerOwnerID()
			Selection:RemoveSpecialSelection(E, self.selection_key)
			self.selection_key = nil
		end
	end
end
function aq.prototype.checkLevel(self, ar)
	if ar == nil then
		ar = PlayerData:getHeroLevel(self.parent:GetPlayerOwnerID())
	end
	if self.parent:IsCustomIllusion() then
		return
	end
	local E = self.parent:GetPlayerOwnerID()
	local as = PlayerData:loadData(E, "dragon_knight_saved_lv")
	if as == nil then
		as = 0
	end
	local at = as
	local au = PlayerData:loadData(E, "dragon_knight_saved_record")
	if au == nil then
		au = 0
	end
	local av = au
	if av < self.max_cnt then
		local ap = 0
		if ar > at then
			do
				local aw = at + 1
				while aw <= ar do
					if aw % self.level == 0 then
						ap = ap + 1
						av = av + 1
						if av == self.max_cnt then
							break
						end
					end
					aw = aw + 1
				end
			end
		end
		PlayerData:saveData(E, "dragon_knight_saved_lv", ar)
		if ap then
			PlayerData:saveData(E, "dragon_knight_saved_record", av)
			self:AddEvolutionPoint(ap)
		end
	end
end
function aq.prototype.checkTalent5(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	if self.tl5_upgrade_point > 0 and self:GetCount("dragon_knight_extra_upgrade_point") == 0 then
		self:AddEvolutionPoint(self.tl5_upgrade_point)
		self:AddCount(1, "dragon_knight_extra_upgrade_point")
	end
end
function aq.prototype.checkShard(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	if self.s_upgrade_point > 0 and self:GetCount("dragon_knight_shard") == 0 then
		self:AddEvolutionPoint(self.s_upgrade_point)
		self:AddCount(1, "dragon_knight_shard")
	end
end
function aq.prototype.AddEvolutionPoint(self, ap)
	if self.parent:IsCustomIllusion() then
		return
	end
	if ap > 0 then
		self:AddCount(ap, "dragon_knight_evolution")
	end
	self:UpdateEvolutionPoint()
end
function aq.prototype.ReduceEvolutionPoint(self, X)
	if self.parent:IsCustomIllusion() then
		return
	end
	local ap = self:GetCount("dragon_knight_evolution")
	if ap > 0 then
		X = math.min(X, ap)
		self:AddCount(-X, "dragon_knight_evolution")
	end
	self:UpdateEvolutionPoint()
end
function aq.prototype.UpdateEvolutionPoint(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local ap = self:GetCount("dragon_knight_evolution")
	local E = self.parent:GetPlayerOwnerID()
	if PlayerData:isRobot(E) then
		if ap > 0 then
			self:Effect()
		end
	else
		self.ability:SetCurrentAbilityCharges(ap)
	end
end
function aq.prototype.Effect(self)
	if self.parent:IsCustomIllusion() then
		return
	end
	local E = self.parent:GetPlayerOwnerID()
	if self.selection_key then
		Selection:RemoveSpecialSelection(E, self.selection_key)
		self.selection_key = nil
		self.effect_proc = false
	else
		if self.effect_proc then
			return
		end
		self.effect_proc = true
		local ax = {}
		if PlayerData:isShardUnlock(E) then
			do
				local aw = 0
				while aw < #A do
					if not AbilityUpgrades:HasAbilityMechanicsUpgradeByID(E, A[aw + 1]) then
						ax[#ax + 1] = A[aw + 1]
						break
					end
					aw = aw + 1
				end
			end
		end
		for F, G in pairs(z) do
			do
				local aw = 0
				while aw < #G do
					if not AbilityUpgrades:HasAbilityMechanicsUpgradeByID(E, G[aw + 1]) then
						ax[#ax + 1] = G[aw + 1]
						break
					end
					aw = aw + 1
				end
			end
		end
		if PlayerData:isRobot(E) then
			GameTimer(1, function()
				self:AddEvolutionEffect(ax[RandomInt(0, #ax - 1) + 1])
			end)
		else
			self.selection_key = Selection:AddSpecialSelection(E, "ability_upgrades_mechenics", ax, function(H, ay)
				if IsValid(self) then
					self.selection_key = nil
					self:AddEvolutionEffect(ay)
				end
				return true
			end)
		end
	end
end
function aq.prototype.AddEvolutionEffect(self, ay)
	if self.parent:IsCustomIllusion() then
		return
	end
	self.effect_proc = false
	local E = self.parent:GetPlayerOwnerID()
	self.last_upgrade_id = ay
	AbilityUpgrades:AddAbilityMechanicsUpgradeByID(E, ay, "dragon_knight_interact")
	AbilityUpgrades:AddAbilityMechanicsUpgradeByID(E, ay)
	self:ReduceEvolutionPoint(1)
	self:SetDragonType()
	if ay == "black_1" then
		self:SwtichDragonType(true)
	end
	local az = PlayerData:getplayerData(E)
	if az then
		local aA = -1
		if h(A, ay) then
			aA = 3
		else
			for F, G in pairs(z) do
				if h(G, ay) then
					aA = F
					break
				end
			end
		end
		if aA ~= -1 then
			az:modifyHeroAbilityExtraData(
				"dragon_knight_talent",
				("dragon_knight_interact_type_" .. tostring(aA)) .. "_count",
				1
			)
		end
	end
end
function aq.prototype.SwtichDragonType(self, aB)
	local az = PlayerData:getplayerData(self.parent:GetPlayerOwnerID())
	local aC = 1
	if az then
		local _ = az:loadData("dragon_knight_interact_type")
		if _ == nil then
			_ = aC
			self:AddEvolutionPoint(1)
		end
		if not aB then
			_ = (_ + 1) % 3
		end
		if not self.parent:IsCustomIllusion() then
			az:saveData("dragon_knight_interact_type", _)
		end
		az:modifyHeroAbilityExtraStringData(
			"dragon_knight_interact",
			"DOTA_Tooltip_ability_dragon_knight_ult",
			"#dragon_knight_interact_type_" .. tostring(_)
		)
		self:SetDragonType()
	end
	local aD = self.parent:FindModifierByName("modifier_dragon_knight_ult_intrinsic")
	if aD then
		aD:UpdateDragonConfig(self:GetDragonType())
	end
end
function aq.prototype.GetDragonType(self)
	local E = self.parent:GetPlayerOwnerID()
	local _ = 0
	if i(A, function(H, R)
		return AbilityUpgrades:HasAbilityMechanicsUpgradeByID(E, R)
	end) then
		_ = 3
	else
		local aE = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "dragon_knight_interact_type")
		if aE == nil then
			aE = 0
		end
		_ = aE
	end
	return _
end
function aq.prototype.SetDragonType(self)
	local aF = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "dragon_knight_interact_type")
	if aF == nil then
		aF = 0
	end
	local _ = aF
	self:SetStackCount(_)
end
function aq.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_POISON_CRIT] = self.p3_chance > 0 }
end
function aq.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_CRITICALSTRIKE_CHANCE_BONUS }
end
function aq.prototype.EOM_GetModifierPoisonCriticalStrikeChanceBonus(self, D)
	if self.p3_chance > 0 then
		return GetPhysicalCriticalChance(self.parent, D) * self.p3_chance * 0.01
	end
end
function aq.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self.parent },
	}
end
function aq.prototype.OnClearTalent(self, D)
	local aG = self.caster:GetPlayerOwnerID()
	if D.playerID == aG and IsServer() then
		if self:GetCount("dragon_knight_extra_upgrade_point") == 0 then
			return
		end
		local aH = AbilityUpgrades:GetAbilityUpgradeTable(aG)
		local aI = #aH[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1]
		local az = PlayerData:getplayerData(aG)
		if aI <= 0 then
			self:ReduceEvolutionPoint(1)
		else
			self.last_upgrade_id = aH[ABILITY_UPGRADES_KEY.UPGRADES_KEY_DATA + 1][aI].id
			AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(aG, self.last_upgrade_id)
			AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(aG, self.last_upgrade_id, "dragon_knight_interact")
		end
		self:AddCount(-1, "dragon_knight_extra_upgrade_point")
		az:modifyHeroAbilityExtraData(
			"dragon_knight_talent",
			("dragon_knight_interact_type_" .. self:GetLastUpgradeType(self.last_upgrade_id)) .. "_count",
			-1,
			true
		)
	end
end
function aq.prototype.GetLastUpgradeType(self, aJ)
	local G = j(aJ, "_")
	repeat
		local aK = G[1]
		local aL = aK == "black"
		if aL then
			return "3"
		end
		aL = aL or aK == "ice"
		if aL then
			return "2"
		end
		aL = aL or aK == "fire"
		if aL then
			return "1"
		end
		aL = aL or aK == "poison"
		if aL then
			return "0"
		end
	until true
end
function aq.prototype.OnFuryGained(self, D)
	if self.f3_fire_chance > 0 and self:PRD(self.f3_fire_chance, "f3_fire_chance") then
		local a3 = self.caster:GetEnemy()
		if IsInjurable(a3, self.parent) then
			local ab = self.caster:FindAbilityByName("dragon_knight_fire")
			local L = self.parent:AddNewModifier(
				self.parent,
				ab,
				"modifier_dragon_knight_fire3_stack",
				{ f3_fury_base_dmg = self.f3_fury_base_dmg }
			)
			local aM = self.f2_fury_dmg_pct * GetFury(self.parent) * 0.01
			local aN = (self.f2_base_dmg + aM) * (1 + self.t4_affect_pct * 0.01) + L:GetBaseDamage()
			a3:AddNewModifier(
				self.parent,
				self:GetAbility(),
				"modifier_dragon_knight_fire_buf",
				{
					durationT = self.f3_duration,
					heal_pct = 0,
					f2_interval = self.f2_interval,
					f2_base_dmg = self.f2_base_dmg,
					f2_fury_dmg_pct = self.f2_fury_dmg_pct,
				}
			)
			if self.i3_heal_pct > 0 then
				Heal(self.caster, aN * self.i3_heal_pct * 0.01, "dragon_knight_fire", "Ability")
			end
		end
	end
end
function aq.prototype.OnCustomAttackLanded(self, an)
	if self.p1_poison_count > 0 then
		AddPoison(an.attacker, an.target, self.p1_poison_count, "dragon_knight_interact", "Ability")
	end
	if self.i1_ice_count > 0 then
		AddIce(an.attacker, an.target, self.i1_ice_count, "dragon_knight_interact", "Ability")
	end
	if self.f1_add_fury > 0 then
		AddFury(self.caster, self.f1_add_fury, "dragon_knight_interact", "Ability")
	end
end
function aq.prototype.OnBattleStartBefore(self, D)
	self:SwtichDragonType(true)
end
function aq.prototype.OnTalentLearn(self, D)
	if D.talentName == "dragon_knight_talent_5" then
		self.tl5_upgrade_point = self:GetAbilityTalentValue("dragon_knight_talent_5", "upgrade_point")
		self:checkTalent5()
	end
end
function aq.prototype.OnHeroLevelUp(self, D)
	self:checkLevel(D.lvl)
end
aq = e(
	{
		r(
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
	aq
)
l.modifier_dragon_knight_interact = aq
l.dragon_knight_fire = c()
local aO = l.dragon_knight_fire
aO.name = "dragon_knight_fire"
d(aO, n)
function aO.prototype.OnSpellStart(self, aP, aQ, a7, a8, a9, aa, a6)
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a2, a3) then
		return
	end
	a2:EmitSound("Hero_DragonKnight.BreathFire")
	local aR = self:GetSpecialValueFor("damage")
	local aS = GetAttackDamage(a2)
	if aP then
		aR = aR * (1 + aP * 0.01)
	end
	local aT = a2:GetAbsOrigin()
	local aU = CalcDirection2D(a3:GetAbsOrigin(), aT)
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
		hCaster = a2,
		vSpawnOrigin = a2:GetAttachmentPosition("attach_head"),
		vDirection = aU,
		flDistance = 800,
		flRadius = 200,
		iMoveSpeed = 900,
		OnProjectileHit = function(aV, aW, aX)
			if IsValid(self) and IsInjurable(a2, aV) then
				if a7 > 0 then
					a3:AddNewModifier(
						a2,
						self,
						"modifier_dragon_knight_fire_buf",
						{ durationT = a7, heal_pct = aQ or 0, f2_interval = a8, f2_base_dmg = a9, f2_fury_dmg_pct = aa }
					)
				end
				a2:DealDamage(aV, self, aR, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				if aQ > 0 then
					Heal(a2, aR * aQ * 0.01, "dragon_knight_fire", "Ability")
				end
			end
		end,
	})
end
aO = e({ o(nil) }, aO)
l.dragon_knight_fire = aO
l.modifier_dragon_knight_fire_buf = c()
local aY = l.modifier_dragon_knight_fire_buf
aY.name = "modifier_dragon_knight_fire_buf"
d(aY, q)
function aY.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.f3_fury_base_dmg = 0
	self.i3_heal_pct = 0
	self.time_list = {}
end
function aY.prototype.GetAbilitySpecialValue(self)
	self.affect_pct = self:GetAbilityTalentValue("dragon_knight_talent_4", "affect_pct")
end
function aY.prototype.GetDamage(self)
	local L = self.caster:FindModifierByName("modifier_dragon_knight_fire3_stack")
	local aZ = L and L:GetBaseDamage() or 0
	local a_ = GetFury(self.caster) * self.fury_dmg_pct * 0.01
	return (self.base_dmg + a_) * (1 + self.affect_pct * 0.01) + aZ
end
function aY.prototype.OnCreated(self, D)
	if IsServer() then
		self.interval = D.f2_interval
		self.base_dmg = D.f2_base_dmg
		self.fury_dmg_pct = D.f2_fury_dmg_pct
		self:SetDuration(D.durationT, true)
		self:StartIntervalThink(self.interval)
		self:IncrementStackCount()
		if self.i3_heal_pct == 0 then
			self.i3_heal_pct = D.heal_pct
		end
		local b0 = self.time_list
		b0[#b0 + 1] = GameRules:GetGameTime() + D.durationT
	end
end
function aY.prototype.OnRefresh(self, D)
	if IsServer() then
		if D.durationT > self:GetDuration() then
			self:SetDuration(D.durationT, true)
		end
		if self.i3_heal_pct == 0 then
			self.i3_heal_pct = D.heal_pct
		end
		self:IncrementStackCount()
		local b1 = self.time_list
		b1[#b1 + 1] = GameRules:GetGameTime() + D.durationT
	end
end
function aY.prototype.OnIntervalThink(self)
	local a3 = self.caster:GetEnemy()
	local aR = self:GetDamage()
	self.caster:DealDamage(a3, self:GetAbility(), aR * self:GetStackCount(), EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	if self.i3_heal_pct > 0 then
		Heal(self.caster, aR * self.i3_heal_pct * 0.01, "dragon_knight_fire", "Ability")
	end
	do
		local aw = #self.time_list - 1
		while aw >= 0 do
			if GameRules:GetGameTime() > self.time_list[aw + 1] then
				self:DecrementStackCount()
				ArrayRemoveByIndex(self.time_list, aw)
			end
			aw = aw - 1
		end
	end
end
aY = e(
	{
		r(
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
	aY
)
l.modifier_dragon_knight_fire_buf = aY
l.modifier_dragon_knight_fire3_stack = c()
local b2 = l.modifier_dragon_knight_fire3_stack
b2.name = "modifier_dragon_knight_fire3_stack"
d(b2, q)
function b2.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.f3_fury_base_dmg = 0
	self.m_stack = 0
end
function b2.prototype.OnCreated(self, D)
	if IsServer() then
		self.f3_fury_base_dmg = D.f3_fury_base_dmg
		self.m_stack = self.m_stack + 1
		self:SetStackCount(self.m_stack * self.f3_fury_base_dmg)
	end
end
function b2.prototype.OnRefresh(self, D)
	if IsServer() then
		self.m_stack = self.m_stack + 1
		self:SetStackCount(self.m_stack * self.f3_fury_base_dmg)
	end
end
function b2.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent } }
end
function b2.prototype.OnBattleEnd(self, D)
	if IsServer() then
		self.parent:RemoveModifierByName("modifier_dragon_knight_fire3_stack")
	end
end
function b2.prototype.GetBaseDamage(self)
	return self:GetStackCount()
end
b2 = e(
	{
		r(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	b2
)
l.modifier_dragon_knight_fire3_stack = b2
l.dragon_knight_poison = c()
local b3 = l.dragon_knight_poison
b3.name = "dragon_knight_poison"
d(b3, n)
function b3.prototype.OnSpellStart(self, aP, aQ)
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a3, a2) then
		return
	end
	local a1 = self:GetSpecialValueFor("duration")
	local aT = a2:GetAbsOrigin()
	local aU = CalcDirection2D(a3:GetAbsOrigin(), aT)
	local b4 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dragon_knight/dragon_knight_shard_fireball_cast.vpcf",
		PATTACH_ABSORIGIN,
		a2
	)
	ParticleManager:SetParticleControlTransform(b4, 1, aT, VectorAngles(aU))
	ParticleManager:ReleaseParticleIndex(b4)
	a2:EmitSound("Hero_DragonKnight.Fireball.Cast")
	TriggerPoison(a3, aQ, self)
	a3:AddNewModifier(a2, self, "modifier_dragon_knight_poison_debuff", { duration = a1, fBonusPct = aP })
end
b3 = e({ o(nil) }, b3)
l.dragon_knight_poison = b3
l.modifier_dragon_knight_poison_debuff = c()
local b5 = l.modifier_dragon_knight_poison_debuff
b5.name = "modifier_dragon_knight_poison_debuff"
d(b5, q)
function b5.prototype.GetAbilitySpecialValue(self)
	self.poison = self:GetAbilitySpecialValueFor("poison")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function b5.prototype.OnCreated(self, D)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
		self.fBonusPct = D and D.fBonusPct or 0
	else
		local b6 = self.parent:GetAbsOrigin()
		local a1 = self:GetRemainingTime()
		self.particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dragon_knight/dragon_knight_shard_fireball.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(self.particle, 0, b6)
		ParticleManager:SetParticleControl(self.particle, 1, b6)
		ParticleManager:SetParticleControl(self.particle, 2, Vector(a1, a1, a1))
		EmitSoundOn("Hero_DragonKnight.Fireball.Target", self.parent)
	end
end
function b5.prototype.OnRefresh(self, D)
	if IsServer() then
		self:IncrementStackCount()
		self.fBonusPct = D and D.fBonusPct or 0
	else
		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
		end
		local b6 = self.parent:GetAbsOrigin()
		local a1 = self:GetRemainingTime()
		self.particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dragon_knight/dragon_knight_shard_fireball.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(self.particle, 0, b6)
		ParticleManager:SetParticleControl(self.particle, 1, b6)
		ParticleManager:SetParticleControl(self.particle, 2, Vector(a1, a1, a1))
	end
end
function b5.prototype.OnDestroy(self)
	if IsClient() then
		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
		end
		StopSoundOn("Hero_DragonKnight.Fireball.Target", self.parent)
	end
end
function b5.prototype.OnIntervalThink(self)
	if IsServer() then
		local X = self.poison * self:GetStackCount()
		if self.fBonusPct > 0 then
			X = X * (1 + self.fBonusPct * 0.01)
		end
		AddPoison(self.caster, self.parent, X, "dragon_knight_poison", "Ability")
	end
end
b5 = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	b5
)
l.modifier_dragon_knight_poison_debuff = b5
l.dragon_knight_ice = c()
local b7 = l.dragon_knight_ice
b7.name = "dragon_knight_ice"
d(b7, n)
function b7.prototype.OnSpellStart(self, aP, aQ)
	local a2 = self:GetCaster()
	local a3 = a2:GetEnemy()
	if not IsInjurable(a3, a2) then
		return
	end
	local b8 = self:GetSpecialValueFor("base_damage")
	local b9 = self:GetSpecialValueFor("damage_pct")
	local a1 = self:GetSpecialValueFor("duration")
	if aP then
		b9 = b9 * (1 + b9 * 0.01)
	end
	a2:EmitSound("Hero_DragonKnight.DragonTail.DragonFormCast")
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail_dragonform_proj.vpcf",
		hCaster = a2,
		vSpawnOrigin = a2:GetAttachmentPosition("attach_hitloc"),
		hTarget = a3,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(ba, aW, aX)
			if IsValid(self) and IsInjurable(a2, a3) then
				local b4 = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_dragon_knight/dragon_knight_dragon_tail_dragonform.vpcf",
					PATTACH_CUSTOMORIGIN,
					a2
				)
				ParticleManager:SetParticleControlEnt(
					b4,
					2,
					a3,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					vec3_zero,
					false
				)
				ParticleManager:ReleaseParticleIndex(b4)
				a3:EmitSound("Hero_DragonKnight.DragonTail.Target")
				local aR = b8 + GetIce(a3) * b9 * 0.01
				a2:DealDamage(a3, self, aR, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				AddStun(a2, a3, self, a1)
				if aQ > 0 then
					Heal(a2, aR * aQ * 0.01, "dragon_knight_ice", "Ability")
				end
			end
		end,
	})
end
b7 = e({ o(nil) }, b7)
l.dragon_knight_ice = b7
l.dragon_knight_talent_6 = c()
local bb = l.dragon_knight_talent_6
bb.name = "dragon_knight_talent_6"
d(bb, n)
function bb.prototype.GetIntrinsicModifierName(self)
	return "modifier_dragon_knight_talent_6"
end
bb = e({ o(nil) }, bb)
l.dragon_knight_talent_6 = bb
l.modifier_dragon_knight_talent_6 = c()
local bc = l.modifier_dragon_knight_talent_6
bc.name = "modifier_dragon_knight_talent_6"
d(bc, q)
function bc.prototype.GetAbilitySpecialValue(self)
	self.max_reduce = self:GetAbilitySpecialValueFor("max_reduce")
end
function bc.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 } }
end
function bc.prototype.OnConfirmBattle(self, D)
	local T = self.parent:FindAbilityByName("dragon_knight_ult")
	if T then
		self.parent:AddNewModifier(self.parent, T, "modifier_dragon_knight_model", nil)
	end
end
function bc.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANA_BONUS }
end
function bc.prototype.GetModifierManaBonus(self)
	return -self.max_reduce
end
bc = e(
	{
		r(
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
l.modifier_dragon_knight_talent_6 = bc
return l