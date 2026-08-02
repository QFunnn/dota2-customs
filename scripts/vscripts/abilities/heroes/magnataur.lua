--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/magnataur"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = b.__TS__ArrayReduce
local h = b.__TS__ArrayForEach
local i = b.__TS__Number
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["20"] = 4,
		["21"] = 4,
		["22"] = 4,
		["24"] = 20,
		["25"] = 21,
		["26"] = 20,
		["27"] = 21,
		["28"] = 22,
		["29"] = 23,
		["30"] = 22,
		["31"] = 21,
		["32"] = 20,
		["33"] = 21,
		["35"] = 21,
		["36"] = 26,
		["37"] = 34,
		["38"] = 26,
		["39"] = 34,
		["41"] = 34,
		["42"] = 64,
		["43"] = 65,
		["44"] = 66,
		["45"] = 67,
		["46"] = 68,
		["47"] = 69,
		["48"] = 26,
		["49"] = 94,
		["50"] = 96,
		["51"] = 98,
		["52"] = 99,
		["53"] = 100,
		["54"] = 102,
		["55"] = 103,
		["56"] = 105,
		["57"] = 107,
		["58"] = 108,
		["59"] = 109,
		["60"] = 111,
		["61"] = 112,
		["62"] = 114,
		["63"] = 115,
		["64"] = 116,
		["65"] = 117,
		["66"] = 118,
		["67"] = 119,
		["68"] = 120,
		["69"] = 121,
		["70"] = 122,
		["71"] = 123,
		["72"] = 124,
		["73"] = 125,
		["74"] = 126,
		["75"] = 127,
		["76"] = 128,
		["77"] = 129,
		["78"] = 130,
		["79"] = 131,
		["80"] = 132,
		["81"] = 133,
		["82"] = 134,
		["83"] = 135,
		["84"] = 136,
		["85"] = 137,
		["86"] = 138,
		["87"] = 139,
		["88"] = 94,
		["89"] = 141,
		["90"] = 142,
		["91"] = 146,
		["92"] = 147,
		["93"] = 148,
		["94"] = 149,
		["95"] = 150,
		["96"] = 151,
		["97"] = 152,
		["98"] = 153,
		["99"] = 154,
		["100"] = 155,
		["101"] = 156,
		["102"] = 158,
		["103"] = 159,
		["104"] = 161,
		["105"] = 162,
		["106"] = 163,
		["107"] = 164,
		["108"] = 165,
		["109"] = 166,
		["110"] = 167,
		["111"] = 168,
		["113"] = 141,
		["114"] = 172,
		["115"] = 173,
		["116"] = 174,
		["117"] = 175,
		["118"] = 176,
		["119"] = 177,
		["120"] = 178,
		["121"] = 179,
		["122"] = 180,
		["123"] = 181,
		["124"] = 182,
		["125"] = 183,
		["126"] = 184,
		["127"] = 184,
		["128"] = 184,
		["129"] = 184,
		["130"] = 184,
		["131"] = 184,
		["132"] = 184,
		["133"] = 185,
		["134"] = 185,
		["135"] = 185,
		["136"] = 185,
		["137"] = 185,
		["138"] = 185,
		["139"] = 185,
		["140"] = 186,
		["141"] = 186,
		["142"] = 186,
		["143"] = 186,
		["144"] = 186,
		["145"] = 186,
		["146"] = 186,
		["147"] = 187,
		["148"] = 187,
		["149"] = 187,
		["150"] = 187,
		["151"] = 187,
		["152"] = 187,
		["153"] = 187,
		["154"] = 188,
		["155"] = 188,
		["156"] = 188,
		["157"] = 188,
		["158"] = 188,
		["159"] = 188,
		["160"] = 188,
		["161"] = 189,
		["162"] = 189,
		["163"] = 189,
		["164"] = 189,
		["165"] = 189,
		["166"] = 189,
		["167"] = 189,
		["168"] = 190,
		["169"] = 190,
		["170"] = 190,
		["171"] = 190,
		["172"] = 190,
		["173"] = 190,
		["174"] = 190,
		["175"] = 191,
		["176"] = 191,
		["177"] = 191,
		["178"] = 191,
		["179"] = 191,
		["180"] = 191,
		["181"] = 191,
		["182"] = 192,
		["183"] = 192,
		["184"] = 192,
		["185"] = 192,
		["186"] = 192,
		["187"] = 192,
		["188"] = 192,
		["189"] = 193,
		["190"] = 193,
		["191"] = 193,
		["192"] = 193,
		["193"] = 193,
		["194"] = 193,
		["195"] = 193,
		["196"] = 194,
		["197"] = 194,
		["198"] = 194,
		["199"] = 194,
		["200"] = 194,
		["201"] = 194,
		["202"] = 194,
		["204"] = 172,
		["205"] = 197,
		["206"] = 198,
		["207"] = 199,
		["209"] = 200,
		["210"] = 200,
		["211"] = 201,
		["212"] = 200,
		["217"] = 197,
		["218"] = 206,
		["219"] = 207,
		["220"] = 207,
		["221"] = 209,
		["222"] = 209,
		["223"] = 209,
		["224"] = 207,
		["225"] = 207,
		["226"] = 211,
		["227"] = 211,
		["228"] = 211,
		["229"] = 207,
		["230"] = 207,
		["231"] = 207,
		["232"] = 206,
		["233"] = 215,
		["234"] = 216,
		["235"] = 216,
		["236"] = 216,
		["237"] = 217,
		["240"] = 218,
		["241"] = 219,
		["242"] = 220,
		["243"] = 221,
		["244"] = 222,
		["245"] = 222,
		["246"] = 222,
		["247"] = 222,
		["248"] = 222,
		["249"] = 223,
		["250"] = 224,
		["252"] = 226,
		["253"] = 226,
		["254"] = 226,
		["255"] = 226,
		["256"] = 227,
		["257"] = 227,
		["259"] = 226,
		["260"] = 226,
		["262"] = 216,
		["263"] = 216,
		["264"] = 215,
		["265"] = 239,
		["266"] = 240,
		["267"] = 241,
		["268"] = 242,
		["269"] = 243,
		["271"] = 245,
		["272"] = 246,
		["274"] = 248,
		["275"] = 250,
		["276"] = 239,
		["277"] = 252,
		["278"] = 253,
		["279"] = 252,
		["280"] = 255,
		["281"] = 256,
		["282"] = 257,
		["283"] = 258,
		["284"] = 259,
		["285"] = 260,
		["286"] = 261,
		["289"] = 255,
		["290"] = 266,
		["291"] = 267,
		["292"] = 267,
		["293"] = 267,
		["294"] = 267,
		["295"] = 267,
		["296"] = 267,
		["297"] = 267,
		["298"] = 267,
		["299"] = 267,
		["300"] = 266,
		["301"] = 277,
		["302"] = 278,
		["303"] = 277,
		["304"] = 280,
		["305"] = 281,
		["306"] = 280,
		["307"] = 283,
		["308"] = 284,
		["309"] = 283,
		["310"] = 286,
		["311"] = 287,
		["312"] = 286,
		["313"] = 289,
		["314"] = 290,
		["315"] = 289,
		["316"] = 292,
		["317"] = 293,
		["318"] = 292,
		["319"] = 295,
		["320"] = 296,
		["321"] = 295,
		["322"] = 298,
		["323"] = 299,
		["324"] = 300,
		["325"] = 298,
		["326"] = 302,
		["327"] = 303,
		["328"] = 304,
		["329"] = 302,
		["330"] = 306,
		["331"] = 306,
		["332"] = 306,
		["334"] = 307,
		["335"] = 308,
		["336"] = 309,
		["337"] = 309,
		["338"] = 309,
		["339"] = 309,
		["340"] = 309,
		["341"] = 309,
		["342"] = 309,
		["343"] = 309,
		["344"] = 309,
		["345"] = 310,
		["346"] = 311,
		["347"] = 312,
		["348"] = 313,
		["349"] = 315,
		["351"] = 317,
		["353"] = 319,
		["354"] = 320,
		["355"] = 321,
		["356"] = 322,
		["357"] = 323,
		["360"] = 326,
		["361"] = 367,
		["362"] = 327,
		["364"] = 328,
		["365"] = 329,
		["368"] = 331,
		["370"] = 332,
		["371"] = 333,
		["374"] = 335,
		["376"] = 336,
		["377"] = 337,
		["380"] = 339,
		["382"] = 340,
		["383"] = 341,
		["386"] = 343,
		["388"] = 344,
		["389"] = 345,
		["392"] = 347,
		["394"] = 348,
		["395"] = 349,
		["398"] = 351,
		["400"] = 352,
		["403"] = 354,
		["405"] = 355,
		["408"] = 357,
		["410"] = 358,
		["413"] = 360,
		["415"] = 361,
		["418"] = 363,
		["420"] = 364,
		["421"] = 365,
		["422"] = 366,
		["423"] = 367,
		["424"] = 368,
		["425"] = 368,
		["426"] = 368,
		["427"] = 369,
		["428"] = 368,
		["429"] = 368,
		["433"] = 373,
		["434"] = 373,
		["435"] = 373,
		["436"] = 373,
		["437"] = 374,
		["438"] = 375,
		["439"] = 306,
		["440"] = 377,
		["441"] = 378,
		["443"] = 379,
		["444"] = 380,
		["446"] = 381,
		["449"] = 388,
		["451"] = 389,
		["454"] = 396,
		["456"] = 397,
		["459"] = 404,
		["461"] = 405,
		["464"] = 412,
		["466"] = 413,
		["469"] = 420,
		["471"] = 421,
		["474"] = 428,
		["476"] = 429,
		["479"] = 431,
		["481"] = 432,
		["484"] = 434,
		["486"] = 435,
		["489"] = 437,
		["491"] = 438,
		["494"] = 440,
		["499"] = 443,
		["500"] = 377,
		["501"] = 445,
		["502"] = 446,
		["503"] = 445,
		["504"] = 448,
		["505"] = 449,
		["506"] = 448,
		["507"] = 452,
		["508"] = 452,
		["509"] = 452,
		["511"] = 453,
		["512"] = 454,
		["513"] = 455,
		["514"] = 456,
		["515"] = 455,
		["517"] = 464,
		["519"] = 452,
		["520"] = 471,
		["521"] = 472,
		["522"] = 473,
		["523"] = 474,
		["524"] = 475,
		["525"] = 476,
		["526"] = 476,
		["527"] = 476,
		["528"] = 477,
		["529"] = 478,
		["530"] = 476,
		["531"] = 476,
		["532"] = 471,
		["533"] = 485,
		["535"] = 486,
		["536"] = 486,
		["537"] = 487,
		["538"] = 488,
		["539"] = 489,
		["541"] = 486,
		["544"] = 485,
		["545"] = 497,
		["546"] = 498,
		["547"] = 499,
		["548"] = 500,
		["549"] = 501,
		["550"] = 502,
		["551"] = 502,
		["553"] = 503,
		["554"] = 497,
		["555"] = 510,
		["556"] = 511,
		["557"] = 511,
		["558"] = 511,
		["559"] = 511,
		["560"] = 511,
		["561"] = 511,
		["562"] = 511,
		["563"] = 511,
		["564"] = 511,
		["565"] = 511,
		["566"] = 510,
		["567"] = 523,
		["568"] = 524,
		["569"] = 525,
		["570"] = 526,
		["571"] = 527,
		["572"] = 528,
		["573"] = 529,
		["574"] = 530,
		["575"] = 531,
		["576"] = 523,
		["577"] = 34,
		["578"] = 26,
		["579"] = 26,
		["580"] = 26,
		["581"] = 26,
		["582"] = 26,
		["583"] = 26,
		["584"] = 26,
		["585"] = 26,
		["586"] = 34,
		["588"] = 34,
		["589"] = 536,
		["590"] = 536,
		["591"] = 536,
		["592"] = 536,
		["593"] = 536,
		["594"] = 536,
		["596"] = 543,
		["597"] = 544,
		["598"] = 543,
		["599"] = 544,
		["601"] = 544,
		["602"] = 545,
		["603"] = 543,
		["604"] = 566,
		["605"] = 567,
		["606"] = 568,
		["607"] = 569,
		["608"] = 570,
		["609"] = 571,
		["610"] = 572,
		["611"] = 573,
		["613"] = 575,
		["614"] = 566,
		["615"] = 578,
		["616"] = 579,
		["617"] = 580,
		["618"] = 581,
		["619"] = 582,
		["620"] = 583,
		["621"] = 584,
		["622"] = 585,
		["624"] = 587,
		["625"] = 578,
		["626"] = 590,
		["627"] = 591,
		["628"] = 592,
		["629"] = 593,
		["630"] = 594,
		["631"] = 595,
		["632"] = 596,
		["633"] = 597,
		["634"] = 598,
		["635"] = 599,
		["636"] = 600,
		["637"] = 601,
		["638"] = 602,
		["639"] = 603,
		["640"] = 604,
		["641"] = 605,
		["642"] = 605,
		["643"] = 605,
		["644"] = 605,
		["645"] = 606,
		["646"] = 606,
		["647"] = 606,
		["648"] = 606,
		["649"] = 607,
		["650"] = 607,
		["651"] = 607,
		["652"] = 607,
		["653"] = 608,
		["654"] = 608,
		["655"] = 608,
		["656"] = 608,
		["657"] = 609,
		["658"] = 609,
		["659"] = 609,
		["660"] = 609,
		["661"] = 610,
		["662"] = 610,
		["663"] = 610,
		["664"] = 610,
		["666"] = 612,
		["667"] = 590,
		["668"] = 615,
		["669"] = 616,
		["670"] = 617,
		["673"] = 620,
		["674"] = 621,
		["675"] = 622,
		["676"] = 623,
		["677"] = 624,
		["678"] = 625,
		["679"] = 626,
		["680"] = 615,
		["681"] = 629,
		["682"] = 629,
		["683"] = 629,
		["685"] = 630,
		["686"] = 631,
		["687"] = 632,
		["688"] = 633,
		["689"] = 634,
		["690"] = 635,
		["691"] = 636,
		["692"] = 637,
		["693"] = 638,
		["694"] = 639,
		["696"] = 641,
		["698"] = 643,
		["699"] = 629,
		["700"] = 646,
		["701"] = 647,
		["702"] = 648,
		["703"] = 649,
		["704"] = 650,
		["705"] = 651,
		["706"] = 652,
		["707"] = 652,
		["708"] = 652,
		["709"] = 652,
		["710"] = 652,
		["711"] = 652,
		["712"] = 652,
		["714"] = 646,
		["715"] = 656,
		["716"] = 657,
		["717"] = 657,
		["718"] = 657,
		["719"] = 657,
		["720"] = 657,
		["721"] = 657,
		["723"] = 657,
		["724"] = 656,
		["725"] = 660,
		["726"] = 661,
		["727"] = 662,
		["728"] = 663,
		["729"] = 664,
		["730"] = 665,
		["731"] = 666,
		["733"] = 669,
		["734"] = 670,
		["736"] = 672,
		["737"] = 672,
		["738"] = 672,
		["739"] = 673,
		["742"] = 676,
		["744"] = 677,
		["745"] = 678,
		["747"] = 679,
		["750"] = 681,
		["752"] = 682,
		["755"] = 684,
		["757"] = 685,
		["761"] = 688,
		["765"] = 672,
		["766"] = 672,
		["767"] = 660,
		["768"] = 694,
		["769"] = 695,
		["770"] = 696,
		["771"] = 697,
		["772"] = 698,
		["773"] = 699,
		["775"] = 701,
		["776"] = 702,
		["778"] = 704,
		["779"] = 705,
		["780"] = 706,
		["781"] = 707,
		["782"] = 708,
		["783"] = 708,
		["784"] = 708,
		["785"] = 709,
		["786"] = 710,
		["787"] = 711,
		["788"] = 712,
		["790"] = 708,
		["791"] = 708,
		["792"] = 694,
		["793"] = 717,
		["794"] = 718,
		["795"] = 719,
		["796"] = 720,
		["797"] = 721,
		["798"] = 722,
		["799"] = 723,
		["800"] = 724,
		["801"] = 725,
		["802"] = 726,
		["803"] = 727,
		["805"] = 717,
		["806"] = 730,
		["807"] = 731,
		["808"] = 732,
		["809"] = 733,
		["810"] = 734,
		["811"] = 735,
		["812"] = 737,
		["813"] = 738,
		["814"] = 739,
		["815"] = 740,
		["816"] = 741,
		["817"] = 742,
		["819"] = 730,
		["820"] = 745,
		["821"] = 746,
		["822"] = 747,
		["825"] = 750,
		["826"] = 751,
		["827"] = 752,
		["828"] = 753,
		["829"] = 754,
		["830"] = 754,
		["831"] = 754,
		["832"] = 755,
		["833"] = 756,
		["835"] = 757,
		["836"] = 757,
		["837"] = 757,
		["838"] = 757,
		["839"] = 758,
		["842"] = 754,
		["843"] = 754,
		["844"] = 761,
		["845"] = 762,
		["847"] = 763,
		["848"] = 764,
		["850"] = 765,
		["851"] = 766,
		["852"] = 766,
		["855"] = 768,
		["857"] = 769,
		["858"] = 770,
		["859"] = 770,
		["862"] = 772,
		["864"] = 773,
		["865"] = 774,
		["866"] = 774,
		["869"] = 776,
		["871"] = 777,
		["872"] = 778,
		["873"] = 778,
		["876"] = 780,
		["878"] = 781,
		["879"] = 782,
		["880"] = 782,
		["883"] = 784,
		["885"] = 785,
		["886"] = 786,
		["887"] = 786,
		["890"] = 788,
		["892"] = 789,
		["893"] = 790,
		["894"] = 790,
		["897"] = 792,
		["899"] = 793,
		["900"] = 794,
		["901"] = 794,
		["904"] = 796,
		["906"] = 797,
		["907"] = 799,
		["908"] = 799,
		["911"] = 801,
		["913"] = 802,
		["914"] = 803,
		["915"] = 803,
		["918"] = 805,
		["920"] = 806,
		["921"] = 808,
		["922"] = 808,
		["925"] = 810,
		["927"] = 811,
		["928"] = 812,
		["929"] = 812,
		["932"] = 814,
		["934"] = 815,
		["935"] = 817,
		["936"] = 817,
		["940"] = 820,
		["941"] = 821,
		["942"] = 821,
		["943"] = 821,
		["944"] = 821,
		["945"] = 827,
		["946"] = 828,
		["947"] = 745,
		["948"] = 831,
		["949"] = 832,
		["950"] = 831,
		["951"] = 544,
		["952"] = 543,
		["953"] = 544,
		["955"] = 544,
		["956"] = 835,
		["957"] = 843,
		["958"] = 835,
		["959"] = 843,
		["960"] = 849,
		["961"] = 851,
		["962"] = 852,
		["963"] = 853,
		["964"] = 849,
		["965"] = 856,
		["966"] = 857,
		["967"] = 858,
		["968"] = 859,
		["969"] = 860,
		["971"] = 856,
		["972"] = 863,
		["973"] = 864,
		["974"] = 865,
		["975"] = 866,
		["977"] = 863,
		["978"] = 869,
		["979"] = 870,
		["980"] = 871,
		["981"] = 871,
		["982"] = 870,
		["983"] = 869,
		["984"] = 874,
		["985"] = 875,
		["986"] = 876,
		["987"] = 877,
		["988"] = 878,
		["989"] = 879,
		["991"] = 880,
		["992"] = 880,
		["993"] = 881,
		["994"] = 882,
		["995"] = 880,
		["1000"] = 874,
		["1001"] = 843,
		["1002"] = 835,
		["1003"] = 835,
		["1004"] = 835,
		["1005"] = 835,
		["1006"] = 835,
		["1007"] = 835,
		["1008"] = 835,
		["1009"] = 835,
		["1010"] = 843,
		["1012"] = 843,
		["1013"] = 888,
		["1014"] = 896,
		["1015"] = 888,
		["1016"] = 896,
		["1017"] = 897,
		["1018"] = 898,
		["1019"] = 897,
		["1020"] = 896,
		["1021"] = 888,
		["1022"] = 888,
		["1023"] = 888,
		["1024"] = 888,
		["1025"] = 888,
		["1026"] = 888,
		["1027"] = 888,
		["1028"] = 888,
		["1029"] = 896,
		["1031"] = 896,
		["1032"] = 905,
		["1033"] = 913,
		["1034"] = 905,
		["1035"] = 913,
		["1036"] = 923,
		["1037"] = 924,
		["1038"] = 925,
		["1039"] = 926,
		["1040"] = 927,
		["1042"] = 923,
		["1043"] = 931,
		["1044"] = 932,
		["1045"] = 932,
		["1046"] = 932,
		["1047"] = 932,
		["1048"] = 932,
		["1049"] = 932,
		["1050"] = 932,
		["1051"] = 932,
		["1052"] = 932,
		["1053"] = 932,
		["1054"] = 932,
		["1055"] = 932,
		["1056"] = 932,
		["1057"] = 932,
		["1058"] = 932,
		["1059"] = 931,
		["1060"] = 949,
		["1061"] = 950,
		["1062"] = 949,
		["1063"] = 952,
		["1064"] = 953,
		["1065"] = 952,
		["1066"] = 955,
		["1067"] = 956,
		["1068"] = 955,
		["1069"] = 958,
		["1070"] = 959,
		["1071"] = 958,
		["1072"] = 961,
		["1073"] = 962,
		["1074"] = 961,
		["1075"] = 964,
		["1076"] = 965,
		["1077"] = 964,
		["1078"] = 967,
		["1079"] = 968,
		["1080"] = 967,
		["1081"] = 970,
		["1082"] = 971,
		["1083"] = 970,
		["1084"] = 973,
		["1085"] = 974,
		["1086"] = 973,
		["1087"] = 976,
		["1088"] = 977,
		["1089"] = 976,
		["1090"] = 979,
		["1091"] = 980,
		["1092"] = 979,
		["1093"] = 983,
		["1094"] = 984,
		["1095"] = 983,
		["1096"] = 986,
		["1097"] = 987,
		["1098"] = 986,
		["1099"] = 989,
		["1100"] = 990,
		["1101"] = 990,
		["1103"] = 991,
		["1104"] = 992,
		["1106"] = 994,
		["1108"] = 989,
		["1109"] = 998,
		["1110"] = 999,
		["1111"] = 998,
		["1112"] = 1003,
		["1113"] = 1004,
		["1114"] = 1003,
		["1115"] = 913,
		["1116"] = 905,
		["1117"] = 905,
		["1118"] = 905,
		["1119"] = 905,
		["1120"] = 905,
		["1121"] = 905,
		["1122"] = 905,
		["1123"] = 905,
		["1124"] = 913,
		["1126"] = 913,
		["1128"] = 1009,
		["1129"] = 1010,
		["1130"] = 1009,
		["1131"] = 1010,
		["1132"] = 1011,
		["1133"] = 1011,
		["1134"] = 1011,
		["1136"] = 1012,
		["1137"] = 1013,
		["1138"] = 1014,
		["1139"] = 1015,
		["1140"] = 1016,
		["1141"] = 1017,
		["1142"] = 1018,
		["1143"] = 1018,
		["1144"] = 1018,
		["1145"] = 1019,
		["1146"] = 1020,
		["1147"] = 1021,
		["1148"] = 1022,
		["1150"] = 1018,
		["1151"] = 1018,
		["1152"] = 1011,
		["1153"] = 1026,
		["1154"] = 1026,
		["1155"] = 1026,
		["1157"] = 1026,
		["1158"] = 1026,
		["1160"] = 1027,
		["1161"] = 1028,
		["1162"] = 1029,
		["1163"] = 1030,
		["1164"] = 1031,
		["1165"] = 1032,
		["1166"] = 1033,
		["1167"] = 1033,
		["1168"] = 1033,
		["1169"] = 1033,
		["1170"] = 1033,
		["1171"] = 1033,
		["1172"] = 1033,
		["1173"] = 1033,
		["1174"] = 1033,
		["1175"] = 1033,
		["1176"] = 1043,
		["1177"] = 1044,
		["1178"] = 1045,
		["1179"] = 1046,
		["1181"] = 1033,
		["1182"] = 1033,
		["1184"] = 1026,
		["1185"] = 1010,
		["1186"] = 1009,
		["1187"] = 1010,
		["1189"] = 1010,
		["1191"] = 1056,
		["1192"] = 1057,
		["1193"] = 1056,
		["1194"] = 1057,
		["1195"] = 1058,
		["1196"] = 1059,
		["1197"] = 1058,
		["1198"] = 1057,
		["1199"] = 1056,
		["1200"] = 1057,
		["1202"] = 1057,
		["1203"] = 1062,
		["1204"] = 1070,
		["1205"] = 1062,
		["1206"] = 1070,
		["1207"] = 1072,
		["1208"] = 1073,
		["1209"] = 1072,
		["1210"] = 1075,
		["1211"] = 1076,
		["1212"] = 1075,
		["1213"] = 1070,
		["1214"] = 1062,
		["1215"] = 1062,
		["1216"] = 1062,
		["1217"] = 1062,
		["1218"] = 1062,
		["1219"] = 1062,
		["1220"] = 1062,
		["1221"] = 1062,
		["1222"] = 1070,
		["1224"] = 1070,
	}
)
local k = {}
local l = require("class.weight_pool")
local m = l.CWeightPool
local n = require("lib.dota_ts_adapter")
local o = n.BaseAbility
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
local t = require("abilities.ability_ai")
local u = t.BaseAbilityAI
local v = t.registerAbilityAI
k.magnataur_talent = c()
local w = k.magnataur_talent
w.name = "magnataur_talent"
d(w, o)
function w.prototype.GetIntrinsicModifierName(self)
	return "modifier_magnataur_talent"
end
w = e({ p(nil) }, w)
k.magnataur_talent = w
k.modifier_magnataur_talent = c()
local x = k.modifier_magnataur_talent
x.name = "modifier_magnataur_talent"
d(x, r)
function x.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.atk = 0
	self.atkSpeed = 0
	self.mana = 0
	self.evade = 0
	self.crit = 0
	self.hp = 0
end
function x.prototype.GetAbilitySpecialValue(self)
	self.tl1_add_pct = self:GetAbilityTalentValue("magnataur_talent_1", "add_pct")
	self.tl2_loss_hp_trigger = self:GetAbilityTalentValue("magnataur_talent_2", "loss_hp_trigger")
	self.tl2_ult_cnt = self:GetAbilityTalentValue("magnataur_talent_2", "ult_cnt")
	self.tl2_max_ult_cnt = self:GetAbilityTalentValue("magnataur_talent_2", "max_ult_cnt")
	self.tl3_upgrade_trigger = self:GetAbilityTalentValue("magnataur_talent_3", "upgrade_trigger")
	self.tl3_add_pct = self:GetAbilityTalentValue("magnataur_talent_3", "add_pct")
	self.tl4_add_mana = self:GetAbilityTalentValue("magnataur_talent_4", "add_mana")
	self.tl5_interval = self:GetAbilityTalentValue("magnataur_talent_5", "interval")
	self.tl5_trigger_pct = self:GetAbilityTalentValue("magnataur_talent_5", "trigger_pct")
	self.tl5_ult_cnt = self:GetAbilityTalentValue("magnataur_talent_5", "ult_cnt")
	self.tl6_loss_hp_trigger = self:GetAbilityTalentValue("magnataur_talent_6", "loss_hp_trigger")
	self.tl6_add_atk_speed = self:GetAbilityTalentValue("magnataur_talent_6", "add_atk_speed")
	self.atk_weight = self:GetAbilitySpecialValueFor("atk_weight")
	self.atk_value = self:GetAbilitySpecialValueFor("atk_value")
	self.atk_speed_weight = self:GetAbilitySpecialValueFor("atk_speed_weight")
	self.atk_speed_value = self:GetAbilitySpecialValueFor("atk_speed_value")
	self.hp_weight = self:GetAbilitySpecialValueFor("hp_weight")
	self.hp_value = self:GetAbilitySpecialValueFor("hp_value")
	self.crit_weight = self:GetAbilitySpecialValueFor("crit_weight")
	self.crit_value = self:GetAbilitySpecialValueFor("crit_value")
	self.evade_weight = self:GetAbilitySpecialValueFor("evade_weight")
	self.evade_value = self:GetAbilitySpecialValueFor("evade_value")
	self.mana_weight = self:GetAbilitySpecialValueFor("mana_weight")
	self.mana_value = self:GetAbilitySpecialValueFor("mana_value")
	self.sect_exp_weight = self:GetAbilitySpecialValueFor("sect_exp_weight")
	self.sect_exp_value = self:GetAbilitySpecialValueFor("sect_exp_value")
	self.gold_weight = self:GetAbilitySpecialValueFor("gold_weight")
	self.gold_value = self:GetAbilitySpecialValueFor("gold_value")
	self.ability_weight = self:GetAbilitySpecialValueFor("ability_weight")
	self.ability_value = self:GetAbilitySpecialValueFor("ability_value")
	self.card_weight = self:GetAbilitySpecialValueFor("card_weight")
	self.card_value = self:GetAbilitySpecialValueFor("card_value")
	self.guan_jun_value = self:GetAbilitySpecialValueFor("guan_jun_value")
	self.guan_jun_reward_gold = self:GetAbilitySpecialValueFor("guan_jun_reward_gold")
	self.guan_jun_trigger = self:GetAbilitySpecialValueFor("guan_jun_trigger")
	self.extra_trigger_pct = self:GetAbilitySpecialValueFor("extra_trigger_pct")
	self.sect_level = self:GetAbilitySpecialValueFor("sect_level")
	self.trigger_cnt = self:GetAbilitySpecialValueFor("trigger_cnt")
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		self.pool = f(m, {})
		self.pool:set("atk_weight", self.atk_weight)
		self.pool:set("atk_speed_weight", self.atk_speed_weight)
		self.pool:set("hp_weight", self.hp_weight)
		self.pool:set("crit_weight", self.crit_weight)
		self.pool:set("evade_weight", self.evade_weight)
		self.pool:set("mana_weight", self.mana_weight)
		self.pool:set("sect_exp_weight", self.sect_exp_weight)
		self.pool:set("gold_weight", self.gold_weight)
		self.pool:set("ability_weight", self.ability_weight)
		self.pool:set("card_weight", self.card_weight)
		self.tl2_ult_record = 0
		self.tl2_loss_hp_record = 0
		self.tl6_loss_hp_record = 0
		self.tl6_record = 0
		self.atk = 0
		self.atkSpeed = 0
		self.mana = 0
		self.evade = 0
		self.crit = 0
		self:SetHasCustomTransmitterData(true)
	end
end
function x.prototype.RefreshValue(self)
	self.atk = self:GetCount("atk_weight")
	self.atkSpeed = self:GetCount("atk_speed_weight")
	self.mana = self:GetCount("mana_weight")
	self.evade = self:GetCount("evade_weight")
	self.crit = self:GetCount("crit_weight")
	self.hp = self:GetCount("hp_weight")
	self:SendBuffRefreshToClients()
	self:SetStackCount(self:GetStackCount() + 1)
	local z = self:GetParent():GetPlayerOwnerID()
	local A = PlayerData:getplayerData(z)
	if A then
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_atk", self.atk, true, true)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_atk_speed", self.atkSpeed, true, true)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_hp", self.hp, true, true)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_crit", self.crit, true, true)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_evade", self.evade, true, true)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_mana", self.mana, true, true)
		A:modifyHeroAbilityExtraData(
			"magnataur_talent",
			"magnataur_sect_exp",
			self:GetCount("sect_exp_weight"),
			true,
			true
		)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_gold", self:GetCount("gold_weight"), true, true)
		A:modifyHeroAbilityExtraData(
			"magnataur_talent",
			"magnataur_ability",
			self:GetCount("ability_weight"),
			true,
			true
		)
		A:modifyHeroAbilityExtraData("magnataur_talent", "magnataur_card", self:GetCount("card_weight"), true, true)
		A:modifyHeroAbilityExtraData(
			"magnataur_talent",
			"magnataur_guan_jun",
			self:GetCount("guan_jun_weight"),
			true,
			true
		)
	end
end
function x.prototype.OnIntervalThink(self)
	if IsServer() then
		if PlayerData:PRD(self.parent, self.tl5_trigger_pct, "magnataur_talent_5") then
			do
				local B = 0
				while B < self.tl5_ult_cnt do
					self:DianShao()
					B = B + 1
				end
			end
		end
	end
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function x.prototype.OnPrepare(self, y)
	GameTimer(3, function()
		if not IsValid(self) then
			return
		end
		local z = self:GetParent():GetPlayerOwnerID()
		local C = PlayerData:getHero(z)
		if C then
			local D = 1
			local E = g(AbilityShop.pickList, function(F, G, H)
				return C:getSectLevel(H) >= self.sect_level and G + self.extra_trigger_pct or G
			end, 0)
			if RollPercentage(E) then
				D = D + self.trigger_cnt
			end
			ForWithInterval(1, D, function()
				if IsValid(self) then
					self:DianShao()
				end
			end)
		end
	end)
end
function x.prototype.OnBattleStart(self)
	if self:HasTalent("magnataur_talent_4") then
		local I = self.caster:FindAbilityByName("magnataur_ult")
		I:OnSpellStart()
		Restore(self.caster, self.tl4_add_mana, true)
	end
	if self.tl5_trigger_pct > 0 and not self.parent:IsCustomIllusion() then
		self:StartIntervalThink(self.tl5_interval)
	end
	self:RefreshValue()
	self:SendBuffRefreshToClients()
end
function x.prototype.OnBattleEnd(self, y)
	self:StartIntervalThink(-1)
end
function x.prototype.OnCustomTakeDamage(self, J)
	if self.tl6_loss_hp_trigger > 0 then
		self.tl6_loss_hp_record = self.tl6_loss_hp_record + J.damage
		if self.tl6_loss_hp_record >= self.tl6_loss_hp_trigger then
			self.tl6_loss_hp_record = self.tl6_loss_hp_record - self.tl6_loss_hp_trigger
			self.tl6_record = self.tl6_record + 1
			self:SendBuffRefreshToClients()
		end
	end
end
function x.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end
function x.prototype.EOM_GetModifierAttackSpeedTotalPercentage(self, y)
	return self.tl6_record * self.tl6_add_atk_speed
end
function x.prototype.EOM_GetModifierEvasion_Bonus(self, y)
	return self.evade
end
function x.prototype.EOM_GetModifierHealthBonus(self, y)
	return self.hp
end
function x.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	return self.crit
end
function x.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.atk
end
function x.prototype.EOM_GetModifierManaRegenBase(self, y)
	return self.mana
end
function x.prototype.EOM_GetModifierAttackSpeedBonus(self, y)
	return self.atkSpeed
end
function x.prototype.GetDianShaoAddAll(self)
	local C = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	return (self.tl1_add_pct + self.tl3_add_pct * C:GetSectLevel("sect_health") + 100) * 0.01
end
function x.prototype.GetDianShaoAddTl3(self)
	local C = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	return (self.tl3_add_pct * C:GetSectLevel("sect_health") + 100) * 0.01
end
function x.prototype.DianShao(self, K)
	if K == nil then
		K = self.parent:GetPlayerOwnerID()
	end
	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_5)
	local L = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_magnataur/magnataur_horn_toss.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		L,
		1,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_horn",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(L)
	self.caster:EmitSound("Hero_Magnataur.HornToss.Cast")
	local M
	if not self:checkGuanJun() and RandomInt(1, 10000) <= 11 then
		M = "guan_jun_weight"
	else
		M = self.pool:random()
	end
	local N = 0
	local C = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	local O = 0
	if self.tl3_add_pct > 0 then
		O = self.tl3_add_pct * C:getSectLevel("sect_health")
	end
	repeat
		local P = M
		local Q
		local R = P == "atk_weight"
		if R then
			N = self.atk_value
			O = O + self.tl1_add_pct
			break
		end
		R = R or P == "atk_speed_weight"
		if R then
			N = self.atk_speed_value
			O = O + self.tl1_add_pct
			break
		end
		R = R or P == "hp_weight"
		if R then
			N = self.hp_value
			O = O + self.tl1_add_pct
			break
		end
		R = R or P == "crit_weight"
		if R then
			N = self.crit_value
			O = O + self.tl1_add_pct
			break
		end
		R = R or P == "evade_weight"
		if R then
			N = self.evade_value
			O = O + self.tl1_add_pct
			break
		end
		R = R or P == "mana_weight"
		if R then
			N = self.mana_value
			O = O + self.tl1_add_pct
			break
		end
		R = R or P == "sect_exp_weight"
		if R then
			N = self.sect_exp_value
			break
		end
		R = R or P == "ability_weight"
		if R then
			N = self.ability_value
			break
		end
		R = R or P == "gold_weight"
		if R then
			N = self.gold_value
			break
		end
		R = R or P == "card_weight"
		if R then
			N = self.card_value
			break
		end
		R = R or P == "guan_jun_weight"
		if R then
			N = self.guan_jun_value
			self:AddCount(self.guan_jun_value, "guan_jun_weight")
			self:AddGold(K, self.guan_jun_reward_gold, true)
			Q = ParticleManager:CreateParticle(
				"models/ui/aegis_of_champions/particles/aegis_of_champions_fx.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				self.caster
			)
			GameTimer(3, function()
				ParticleManager:DestroyParticle(Q, true)
			end)
			break
		end
	until true
	self:DianshaoSaveData(math.floor(N * (1 + O * 0.01)), M)
	self:RefreshValue()
	self:SendBuffRefreshToClients()
end
function x.prototype.DianshaoSaveData(self, N, M)
	local z = self.parent:GetPlayerOwnerID()
	repeat
		local S = M
		local T = S == "atk_weight"
		if T then
			Notification:combatToPlayer(
				z,
				{
					message = "notify_attribute_gain",
					string_ability_name = "DOTA_Tooltip_ability_magnataur_talent",
					string_attribute = "Tooltip_Attribute_Attack",
					int_value = N,
				}
			)
			break
		end
		T = T or S == "atk_speed_weight"
		if T then
			Notification:combatToPlayer(
				z,
				{
					message = "notify_attribute_gain",
					string_ability_name = "DOTA_Tooltip_ability_magnataur_talent",
					string_attribute = "Attribute_Attackspeed",
					int_value = N,
				}
			)
			break
		end
		T = T or S == "hp_weight"
		if T then
			Notification:combatToPlayer(
				z,
				{
					message = "notify_attribute_gain",
					string_ability_name = "DOTA_Tooltip_ability_magnataur_talent",
					string_attribute = "magnataur_hp",
					int_value = N,
				}
			)
			break
		end
		T = T or S == "crit_weight"
		if T then
			Notification:combatToPlayer(
				z,
				{
					message = "notify_attribute_gain",
					string_ability_name = "DOTA_Tooltip_ability_magnataur_talent",
					string_attribute = "Attribute_CritChance",
					int_value = N,
				}
			)
			break
		end
		T = T or S == "evade_weight"
		if T then
			Notification:combatToPlayer(
				z,
				{
					message = "notify_attribute_gain",
					string_ability_name = "DOTA_Tooltip_ability_magnataur_talent",
					string_attribute = "Attribute_Evasion",
					int_value = N,
				}
			)
			break
		end
		T = T or S == "mana_weight"
		if T then
			Notification:combatToPlayer(
				z,
				{
					message = "notify_attribute_gain",
					string_ability_name = "DOTA_Tooltip_ability_magnataur_talent",
					string_attribute = "Attribute_ManaRegen",
					int_value = N,
				}
			)
			break
		end
		T = T or S == "sect_exp_weight"
		if T then
			self:AddSectExp(N)
			break
		end
		T = T or S == "ability_weight"
		if T then
			self:AddAbility(N)
			break
		end
		T = T or S == "gold_weight"
		if T then
			self:AddGold(z, N)
			break
		end
		T = T or S == "card_weight"
		if T then
			self:AddCard(z, N)
			break
		end
		T = T or S == "guan_jun_weight"
		if T then
			return
		end
	until true
	self:AddCount(N, M)
end
function x.prototype.GetDianShaoAdd(self)
	return (self.tl1_add_pct + self.tl3_add_pct + 100) * 0.01
end
function x.prototype.checkGuanJun(self)
	return self:GetCount("guan_jun_weight") >= self.guan_jun_trigger
end
function x.prototype.AddGold(self, K, N, U)
	if U == nil then
		U = false
	end
	PlayerData:modifyGold(K, N)
	if U then
		PlayerData:eachPlayer(function(F, V, W)
			Notification:combatToPlayer(
				W,
				{
					message = "notify_magnataur_guan_jun_gold",
					player_id = K,
					string_itemname_artifact = "DOTA_Tooltip_ability_magnataur_talent",
					int_gold = N,
				}
			)
		end)
	else
		Notification:combatToPlayer(
			K,
			{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_magnataur_talent", int_gold = N }
		)
	end
end
function x.prototype.AddAbility(self, D)
	local z = self.parent:GetPlayerOwnerID()
	local A = PlayerData:getplayerData(z)
	local X = AbilityShop:getRandomAbility(z, D)
	local C = A.hero
	h(X, function(F, Y, Z)
		C:learnAbility(Y.aid, true)
		Notification:combatToPlayer(
			z,
			{
				message = "notify_artifact_ability_" .. Y.rarity,
				string_itemname_artifact = "DOTA_Tooltip_ability_magnataur_talent",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. Y.aid,
			}
		)
	end)
end
function x.prototype.AddCard(self, K, D)
	do
		local B = 0
		while B < D do
			local _ = CardEffect:randomCardEffect(K)
			if _ then
				Notification:combatToPlayer(
					K,
					{
						message = "notify_card_effect",
						string_card1 = "DOTA_Tooltip_ability_magnataur_talent",
						string_card2 = "DOTA_Tooltip_ability_" .. _,
					}
				)
			end
			B = B + 1
		end
	end
end
function x.prototype.AddSectExp(self, N)
	local z = self.parent:GetPlayerOwnerID()
	local C = PlayerData:getHero(z)
	local a0 = GetRandomElement(AbilityShop.pickList)
	local a1 = N
	if C ~= nil then
		C:addSectExp(a0, a1)
	end
	Notification:combatToPlayer(
		z,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_magnataur_talent",
			string_sect = "DOTA_Tooltip_ability_" .. a0,
			int_exp = a1,
		}
	)
end
function x.prototype.AddCustomTransmitterData(self)
	return {
		atk_value = self.atk,
		atk_speed_value = self.atkSpeed,
		evade_value = self.evade,
		crit_value = self.crit,
		mana_value = self.mana,
		hp_value = self.hp,
		tl6_record = self.tl6_record,
		tl6_atk_speed = self.tl6_add_atk_speed,
	}
end
function x.prototype.HandleCustomTransmitterData(self, a2)
	self.atk = a2.atk_value
	self.atkSpeed = a2.atk_speed_value
	self.crit = a2.crit_value
	self.mana = a2.mana_value
	self.evade = a2.evade_value
	self.hp = a2.hp_value
	self.tl6_record = a2.tl6_record
	self.tl6_add_atk_speed = a2.tl6_add_atk_speed
end
x = e(
	{
		s(
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
k.modifier_magnataur_talent = x
local a3 =
	{ [1] = Vector(0, 127, 255), [2] = Vector(0, 255, 119), [3] = Vector(231, 51, 255), [4] = Vector(255, 174, 0) }
k.magnataur_ult = c()
local a4 = k.magnataur_ult
a4.name = "magnataur_ult"
d(a4, u)
function a4.prototype.____constructor(self, ...)
	u.prototype.____constructor(self, ...)
	self.firstUlt = true
end
function a4.prototype.GetAbilityTextureName(self)
	local a5 = self:GetAbilityQualityStage()
	if a5 == 4 then
		return "magnataur_stewing"
	elseif a5 == 3 then
		return "magnataur_pan_frying"
	elseif a5 == 2 then
		return "magnataur_deep_frying"
	end
	return "magnataur_blanching"
end
function a4.prototype.GetAbilityQualityStage(self)
	local a6 = self:GetCurrentAbilityCharges()
	if a6 == 4 then
		return 4
	elseif a6 == 3 then
		return 3
	elseif a6 == 2 then
		return 2
	end
	return 1
end
function a4.prototype.GetQualityPool(self)
	if self.pool == nil then
		self.pool = f(m, {})
		local a7 = self:GetSpecialValueFor("quality1_value")
		local a8 = self:GetSpecialValueFor("quality2_value")
		local a9 = self:GetSpecialValueFor("quality3_value")
		local aa = self:GetSpecialValueFor("quality4_value")
		local ab = self:GetSpecialValueFor("quality5_value")
		local ac = self:GetSpecialValueFor("quality6_value")
		local ad = self:GetSpecialValueFor("quality1_weight")
		local ae = self:GetSpecialValueFor("quality2_weight")
		local af = self:GetSpecialValueFor("quality3_weight")
		local ag = self:GetSpecialValueFor("quality4_weight")
		local ah = self:GetSpecialValueFor("quality5_weight")
		local ai = self:GetSpecialValueFor("quality6_weight")
		self.pool:set(tostring(a7), ad)
		self.pool:set(tostring(a8), ae)
		self.pool:set(tostring(a9), af)
		self.pool:set(tostring(aa), ag)
		self.pool:set(tostring(ab), ah)
		self.pool:set(tostring(ac), ai)
	end
	return self.pool
end
function a4.prototype.AddQuality(self)
	local N = finiteNumber(i(self:GetQualityPool():random()))
	if N == 0 then
		return
	end
	local aj = self:GetCaster()
	aj:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 3)
	aj:EmitSound("Hero_Magnataur.Empower.Cast")
	local L = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_magnataur/magnataur_horn_toss_land.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		aj
	)
	ParticleManager:ReleaseParticleIndex(L)
	self:saveData(N)
	self:AdjustUlti()
end
function a4.prototype.AdjustUlti(self, ak)
	if ak == nil then
		ak = self:loadStack()
	end
	local al = self:GetSpecialValueFor("stage2_trigger")
	local am = self:GetSpecialValueFor("stage3_trigger")
	local an = self:GetSpecialValueFor("stage4_trigger")
	local ao = 0
	if ak >= an then
		ao = 4
	elseif ak >= am then
		ao = 3
	elseif ak >= al then
		ao = 2
	else
		ao = 1
	end
	self:SetCurrentAbilityCharges(ao)
end
function a4.prototype.saveData(self, D)
	local z = self:GetCaster():GetPlayerOwnerID()
	local ao = self:loadStack() + D
	PlayerData:saveData(z, "ult_quality", ao)
	local A = PlayerData:getplayerData(z)
	if A then
		A:modifyHeroAbilityExtraData("magnataur_ult", "magnataur_ult_quality", ao, true, true)
	end
end
function a4.prototype.loadStack(self)
	local ap = PlayerData:loadData(self:GetCaster():GetPlayerOwnerID(), "ult_quality")
	if ap == nil then
		ap = 0
	end
	return ap
end
function a4.prototype.OnSpellStart(self)
	local aj = self:GetCaster()
	local aq = aj:GetEnemy()
	aj:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	if self.firstUlt then
		self.firstUlt = nil
		self:AddQuality()
	end
	if self:HasTalent("magnataur_talent_1") then
		aj:AddNewModifier(aj, self, "modifier_magnataur_talent_1", nil)
	end
	self:GameTimer(0.33, function()
		if not IsInjurable(aj, aq) then
			return
		end
		local a5 = self:GetAbilityQualityStage()
		repeat
			local ar = a5
			local as = ar == 2
			if as then
				self:CastNormalAbility(2)
				break
			end
			as = as or ar == 3
			if as then
				self:Stage3()
				break
			end
			as = as or ar == 4
			if as then
				self:Stage4()
				break
			end
			do
				self:CastNormalAbility(1)
				break
			end
		until true
	end)
end
function a4.prototype.CastNormalAbility(self, a5)
	local at = 0
	local D = 1
	if a5 == 1 then
		at = self:GetSpecialValueFor("stage1_damage")
		D = 1
	else
		at = self:GetSpecialValueFor("stage2_damage")
		D = self:GetSpecialValueFor("stage2_damage_cnt")
	end
	local aj = self:GetCaster()
	local au = aj:GetEnemy()
	local I = aj:FindAbilityByName("magnataur_ult_s")
	local B = 0
	GameTimer(0, function()
		I:Launch(au, at, a3[a5])
		B = B + 1
		if B < D then
			return 0.25
		end
	end)
end
function a4.prototype.Stage3(self)
	local aj = self:GetCaster()
	local au = aj:GetEnemy()
	local av = self:GetSpecialValueFor("stage3_stun_duration")
	local aw = self:GetSpecialValueFor("stage3_dian_shao_pct")
	local I = aj:FindAbilityByName("magnataur_ult_s")
	I:OnSpellStart(3)
	AddStun(aj, au, I, av)
	if RollPercentage(aw) then
		local ax = aj:FindModifierByName("modifier_magnataur_talent")
		ax:DianShao()
	end
end
function a4.prototype.Stage4(self)
	self:Stage4StealSect()
	local aj = self:GetCaster()
	local aq = aj:GetEnemy()
	local ay = self:GetSpecialValueFor("stage4_stun_duration")
	local az = self:GetSpecialValueFor("stage4_dian_shao_pct")
	local I = aj:FindAbilityByName("magnataur_ult_s")
	I:OnSpellStart(4)
	AddStun(aj, aq, I, ay)
	if RollPercentage(az) then
		local ax = aj:FindModifierByName("modifier_magnataur_talent")
		ax:DianShao()
	end
end
function a4.prototype.Stage4StealSect(self)
	local aj = self:GetCaster()
	if aj:HasModifier("modifier_magnataur_ult_steal") then
		return
	end
	local aq = aj:GetEnemy()
	local aA = self:GetSpecialValueFor("stage4_steal_pct")
	local a0 = ""
	local C = PlayerData:getHero(aq:GetPlayerOwnerID())
	h(AbilityShop.pickList, function(F, Y)
		if a0 == "" then
			a0 = Y
		else
			local aB = C and C:getAbilityData(true)[a0]
			local aC = aB and aB.exp or 0
			local aD = C and C:getAbilityData(true)[Y]
			if aC < (aD and aD.exp or 0) then
				a0 = Y
			end
		end
	end)
	local M = 0
	local N = 0
	repeat
		local aE = a0
		local aF = aE == "sect_attack"
		if aF then
			M = 1
			local aG = aq:FindModifierByName("modifier_sect_attack")
			N = aG and aG.attackspeed or 0
			break
		end
		aF = aF or aE == "sect_health"
		if aF then
			M = 2
			local aH = aq:FindModifierByName("modifier_sect_health")
			N = aH and aH.health_pct or 0
			break
		end
		aF = aF or aE == "sect_evade"
		if aF then
			M = 3
			local aI = aq:FindModifierByName("modifier_sect_evade")
			N = aI and aI.evasion or 0
			break
		end
		aF = aF or aE == "sect_crit"
		if aF then
			M = 4
			local aJ = aq:FindModifierByName("modifier_sect_crit")
			N = aJ and aJ.crit_chance or 0
			break
		end
		aF = aF or aE == "sect_regen"
		if aF then
			M = 5
			local aK = aq:FindModifierByName("modifier_sect_regen")
			N = aK and aK.regen or 0
			break
		end
		aF = aF or aE == "sect_ulti"
		if aF then
			M = 6
			local aL = aq:FindModifierByName("modifier_sect_ulti")
			N = aL and aL.mana_regen or 0
			break
		end
		aF = aF or aE == "sect_wisp"
		if aF then
			M = 7
			local aM = aq:FindModifierByName("modifier_sect_wisp")
			N = aM and aM.health_bonus_pct or 0
			break
		end
		aF = aF or aE == "sect_poison"
		if aF then
			M = 8
			local aN = aq:FindModifierByName("modifier_sect_poison")
			N = aN and aN.poison_count_extra or 0
			break
		end
		aF = aF or aE == "sect_fury"
		if aF then
			M = 9
			local aO = aq:FindModifierByName("modifier_sect_fury")
			N = aO and aO.fury_count_extra or 0
			break
		end
		aF = aF or aE == "sect_ice"
		if aF then
			M = 10
			local aP = aq:FindModifierByName("modifier_sect_ice")
			N = aP and aP.ice_count_extra or 0
			break
		end
		aF = aF or aE == "sect_shield"
		if aF then
			M = 11
			local aQ = aq:FindModifierByName("modifier_sect_shield")
			N = aQ and aQ.shield_count_bonus or 0
			break
		end
		aF = aF or aE == "sect_injury"
		if aF then
			M = 12
			local aR = aq:FindModifierByName("modifier_sect_injury")
			N = aR and aR.injury_count_bonus or 0
			break
		end
		aF = aF or aE == "sect_chaos"
		if aF then
			M = 13
			local aS = aq:FindModifierByName("modifier_sect_chaos")
			N = aS and aS.chaos_prebattle or 0
			break
		end
	until true
	N = N * aA * 0.01
	Notification:combatToPlayer(
		aj:GetPlayerOwnerID(),
		{
			message = "notify_magnataur",
			string_itemname_artifact = "DOTA_Tooltip_ability_magnataur_ult",
			string_itemname_artifact2 = "DOTA_Tooltip_ability_" .. a0,
			int_gold = N,
		}
	)
	aj:AddNewModifier(aj, self, "modifier_magnataur_ult_steal", { type = M, value = N })
	aq:AddNewModifier(aj, self, "modifier_magnataur_ult_steal", { type = M, value = N })
end
function a4.prototype.GetIntrinsicModifierName(self)
	return "modifier_magnataur_ult_intr"
end
a4 = e({ v(nil) }, a4)
k.magnataur_ult = a4
k.modifier_magnataur_ult_intr = c()
local aT = k.modifier_magnataur_ult_intr
aT.name = "modifier_magnataur_ult_intr"
d(aT, r)
function aT.prototype.GetAbilitySpecialValue(self)
	self.tl2_loss_hp_trigger = self:GetAbilityTalentValue("magnataur_talent_2", "loss_hp_trigger")
	self.tl2_ult_cnt = self:GetAbilityTalentValue("magnataur_talent_2", "ult_cnt")
	self.tl2_max_ult_cnt = self:GetAbilityTalentValue("magnataur_talent_2", "max_ult_cnt")
end
function aT.prototype.OnCreated(self, y)
	if IsServer() then
		self.tl2_loss_hp_record = 0
		self.tl2_ult_record = 0
		self:StartIntervalThink(1)
	end
end
function aT.prototype.OnIntervalThink(self)
	if IsServer() then
		self.ability:AdjustUlti()
		self:StartIntervalThink(-1)
	end
end
function aT.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function aT.prototype.OnCustomTakeDamage(self, J)
	if self.tl2_loss_hp_trigger > 0 and self.tl2_ult_record < self.tl2_max_ult_cnt then
		self.tl2_loss_hp_record = self.tl2_loss_hp_record + J.damage
		local I = self.caster:FindAbilityByName("magnataur_ult")
		if self.tl2_loss_hp_record >= self.tl2_loss_hp_trigger then
			self.tl2_loss_hp_record = self.tl2_loss_hp_record - self.tl2_loss_hp_trigger
			do
				local B = 0
				while B < self.tl2_ult_cnt do
					self.tl2_ult_record = self.tl2_ult_record + 1
					I:AddQuality()
					B = B + 1
				end
			end
		end
	end
end
aT = e(
	{
		s(
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
	aT
)
k.modifier_magnataur_ult_intr = aT
k.modifier_magnataur_talent_1 = c()
local aU = k.modifier_magnataur_talent_1
aU.name = "modifier_magnataur_talent_1"
d(aU, r)
function aU.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_LOSS_PERCENTAGE] = 999 }
end
aU = e(
	{
		s(
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
	aU
)
k.modifier_magnataur_talent_1 = aU
k.modifier_magnataur_ult_steal = c()
local aV = k.modifier_magnataur_ult_steal
aV.name = "modifier_magnataur_ult_steal"
d(aV, r)
function aV.prototype.OnCreated(self, y)
	if IsServer() then
		self.type = y.type
		self:SetHasCustomTransmitterData(true)
		self:SetStackCount(y.value)
	end
end
function aV.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_STACK_BONUS,
	}
end
function aV.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetStealValue(1)
end
function aV.prototype.EOM_GetModifierHealthBonusPercentage(self)
	return self:GetStealValue(2)
end
function aV.prototype.EOM_GetModifierEvasion_Bonus(self)
	return self:GetStealValue(3)
end
function aV.prototype.EOM_GetModifierPhysicalCriticalStrikeChance(self)
	return self:GetStealValue(4)
end
function aV.prototype.EOM_GetModifierHeal_Bonus(self, y)
	return self:GetStealValue(5)
end
function aV.prototype.EOM_GetModifierManaRegenBase(self)
	return self:GetStealValue(6)
end
function aV.prototype.EOM_GetModifierWispHealthPercentage(self, y)
	return self:GetStealValue(7)
end
function aV.prototype.EOM_GetModifierPoisonDamageBonus(self)
	return self:GetStealValue(8)
end
function aV.prototype.EOM_GetModifierFuryStackBonus(self, y)
	return self:GetStealValue(9)
end
function aV.prototype.EOM_GetModifierIceStackBonus(self, y)
	return self:GetStealValue(10)
end
function aV.prototype.EOM_GetModifierShieldStackBonus(self, y)
	return self:GetStealValue(11)
end
function aV.prototype.EOM_GetModifierInjuryStackBonus(self, y)
	return self:GetStealValue(12)
end
function aV.prototype.EOM_GetModifierChaosStackBonus(self, y)
	return self:GetStealValue(13)
end
function aV.prototype.GetStealValue(self, aW)
	if self.type ~= aW then
		return 0
	end
	if self:GetParent() == self:GetCaster() then
		return self:GetStackCount()
	else
		return -self:GetStackCount()
	end
end
function aV.prototype.AddCustomTransmitterData(self)
	return { type = self.type }
end
function aV.prototype.HandleCustomTransmitterData(self, a2)
	self.type = a2.type
end
aV = e(
	{
		s(
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
	aV
)
k.modifier_magnataur_ult_steal = aV
k.magnataur_ult_s = c()
local aX = k.magnataur_ult_s
aX.name = "magnataur_ult_s"
d(aX, u)
function aX.prototype.OnSpellStart(self, a5)
	if a5 == nil then
		a5 = 3
	end
	local aY = self:GetCaster()
	local au = aY:GetEnemy()
	local aZ = self:GetSpecialValueFor("base_count")
	local a_ = self:GetSpecialValueFor("attack_damage_per_extra_count")
	local b0 = aZ + math.floor(GetAttackDamage(aY) / a_)
	local B = 0
	self:GameTimer(0, function()
		self:Launch(au, nil, a3[a5])
		B = B + 1
		if B < b0 then
			return 0.25
		end
	end)
end
function aX.prototype.Launch(self, au, b1, b2)
	if b1 == nil then
		b1 = 0
	end
	if b2 == nil then
		b2 = Vector(225, 120, 0)
	end
	local aY = self:GetCaster()
	local at = b1 == 0 and self:GetSpecialValueFor("damage") or b1
	if IsInjurable(au) then
		local b3 = (au:GetAbsOrigin() - aY:GetAbsOrigin()):Normalized()
		local b4 = (au:GetAbsOrigin() - aY:GetAbsOrigin()):Length2D() + 100
		aY:EmitSound("Hero_Magnataur.ShockWave.Particle")
		Projectile:CreateLinearProjectile({
			EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
			hCaster = aY,
			vSpawnOrigin = aY:GetAbsOrigin(),
			vDirection = b3,
			flDistance = b4,
			flRadius = 150,
			iMoveSpeed = PROJECTILE_SPEED_NORMAL,
			HSVColor = b2,
			HSVColorEnable = Vector(1, 0, 0),
			OnProjectileHit = function(au, b5, b6)
				if IsInjurable(au) then
					aY:DealDamage(au, self, at, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
					EmitSoundOnLocationWithCaster(b5, "Hero_Magnataur.ShockWave.Target", aY)
				end
			end,
		})
	end
end
aX = e({ v(nil) }, aX)
k.magnataur_ult_s = aX
k.magnataur_shard = c()
local b7 = k.magnataur_shard
b7.name = "magnataur_shard"
d(b7, o)
function b7.prototype.GetIntrinsicModifierName(self)
	return "modifier_magnataur_shard"
end
b7 = e({ p(nil) }, b7)
k.magnataur_shard = b7
k.modifier_magnataur_shard = c()
local b8 = k.modifier_magnataur_shard
b8.name = "modifier_magnataur_shard"
d(b8, r)
function b8.prototype.GetAbilitySpecialValue(self)
	self.health_per = self:GetAbilitySpecialValueFor("health_per")
end
function b8.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_SECT_GAIN_PERCENTAGE] = self.health_per }
end
b8 = e(
	{
		s(
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
	b8
)
k.modifier_magnataur_shard = b8
return k