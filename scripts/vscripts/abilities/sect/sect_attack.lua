--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["19"] = 5,
		["20"] = 7,
		["21"] = 16,
		["22"] = 43,
		["23"] = 4,
		["24"] = 50,
		["25"] = 51,
		["26"] = 52,
		["27"] = 53,
		["28"] = 54,
		["29"] = 55,
		["30"] = 56,
		["31"] = 57,
		["32"] = 58,
		["33"] = 59,
		["34"] = 60,
		["35"] = 61,
		["36"] = 62,
		["37"] = 63,
		["38"] = 64,
		["39"] = 67,
		["40"] = 68,
		["41"] = 69,
		["42"] = 72,
		["43"] = 73,
		["44"] = 75,
		["45"] = 76,
		["46"] = 77,
		["47"] = 78,
		["48"] = 50,
		["49"] = 80,
		["50"] = 81,
		["51"] = 80,
		["52"] = 83,
		["53"] = 83,
		["54"] = 83,
		["56"] = 84,
		["57"] = 85,
		["61"] = 88,
		["62"] = 109,
		["63"] = 89,
		["65"] = 90,
		["66"] = 90,
		["67"] = 90,
		["68"] = 90,
		["69"] = 90,
		["70"] = 90,
		["73"] = 92,
		["75"] = 93,
		["76"] = 93,
		["77"] = 93,
		["78"] = 93,
		["79"] = 93,
		["80"] = 93,
		["81"] = 93,
		["84"] = 95,
		["86"] = 96,
		["87"] = 96,
		["88"] = 96,
		["89"] = 96,
		["92"] = 98,
		["94"] = 99,
		["95"] = 99,
		["96"] = 99,
		["97"] = 99,
		["98"] = 99,
		["99"] = 99,
		["100"] = 99,
		["103"] = 101,
		["105"] = 102,
		["106"] = 102,
		["107"] = 102,
		["108"] = 102,
		["109"] = 102,
		["110"] = 102,
		["113"] = 104,
		["115"] = 105,
		["116"] = 105,
		["117"] = 105,
		["118"] = 105,
		["119"] = 105,
		["120"] = 105,
		["121"] = 105,
		["124"] = 107,
		["126"] = 108,
		["127"] = 109,
		["128"] = 110,
		["129"] = 111,
		["130"] = 111,
		["131"] = 111,
		["132"] = 111,
		["133"] = 111,
		["134"] = 116,
		["135"] = 117,
		["136"] = 118,
		["137"] = 118,
		["138"] = 118,
		["139"] = 118,
		["140"] = 118,
		["141"] = 118,
		["142"] = 118,
		["143"] = 118,
		["144"] = 118,
		["145"] = 118,
		["147"] = 111,
		["148"] = 111,
		["150"] = 128,
		["151"] = 128,
		["152"] = 128,
		["153"] = 128,
		["154"] = 128,
		["155"] = 128,
		["156"] = 128,
		["157"] = 128,
		["158"] = 128,
		["159"] = 128,
		["163"] = 136,
		["166"] = 138,
		["167"] = 139,
		["168"] = 140,
		["169"] = 141,
		["170"] = 142,
		["176"] = 147,
		["179"] = 149,
		["180"] = 150,
		["181"] = 151,
		["182"] = 152,
		["183"] = 153,
		["189"] = 158,
		["192"] = 160,
		["193"] = 161,
		["194"] = 162,
		["195"] = 163,
		["196"] = 163,
		["197"] = 163,
		["198"] = 163,
		["199"] = 163,
		["200"] = 168,
		["201"] = 169,
		["202"] = 170,
		["203"] = 170,
		["204"] = 170,
		["205"] = 170,
		["206"] = 170,
		["207"] = 170,
		["208"] = 170,
		["209"] = 170,
		["210"] = 170,
		["211"] = 170,
		["213"] = 163,
		["214"] = 163,
		["216"] = 180,
		["217"] = 180,
		["218"] = 180,
		["219"] = 180,
		["220"] = 180,
		["221"] = 180,
		["222"] = 180,
		["223"] = 180,
		["224"] = 180,
		["225"] = 180,
		["227"] = 187,
		["228"] = 188,
		["229"] = 188,
		["230"] = 188,
		["231"] = 188,
		["232"] = 188,
		["233"] = 188,
		["234"] = 188,
		["235"] = 188,
		["236"] = 188,
		["237"] = 189,
		["238"] = 189,
		["239"] = 189,
		["240"] = 189,
		["241"] = 189,
		["242"] = 190,
		["247"] = 194,
		["249"] = 195,
		["250"] = 195,
		["251"] = 195,
		["252"] = 195,
		["253"] = 195,
		["254"] = 195,
		["257"] = 197,
		["259"] = 198,
		["260"] = 198,
		["261"] = 198,
		["262"] = 198,
		["263"] = 198,
		["264"] = 198,
		["265"] = 198,
		["266"] = 198,
		["267"] = 198,
		["271"] = 83,
		["272"] = 204,
		["273"] = 205,
		["274"] = 204,
		["275"] = 5,
		["276"] = 4,
		["277"] = 5,
		["279"] = 5,
		["280"] = 209,
		["281"] = 216,
		["282"] = 209,
		["283"] = 216,
		["285"] = 216,
		["286"] = 218,
		["287"] = 227,
		["288"] = 260,
		["289"] = 262,
		["290"] = 209,
		["291"] = 269,
		["292"] = 270,
		["293"] = 271,
		["294"] = 273,
		["295"] = 274,
		["296"] = 275,
		["297"] = 276,
		["298"] = 277,
		["299"] = 278,
		["300"] = 279,
		["301"] = 280,
		["302"] = 281,
		["303"] = 282,
		["304"] = 283,
		["305"] = 284,
		["306"] = 285,
		["307"] = 286,
		["308"] = 287,
		["309"] = 288,
		["310"] = 289,
		["311"] = 290,
		["312"] = 291,
		["313"] = 292,
		["314"] = 293,
		["315"] = 294,
		["316"] = 295,
		["317"] = 296,
		["318"] = 301,
		["319"] = 302,
		["320"] = 303,
		["322"] = 305,
		["323"] = 306,
		["324"] = 307,
		["325"] = 308,
		["326"] = 309,
		["327"] = 310,
		["328"] = 269,
		["329"] = 312,
		["330"] = 313,
		["331"] = 314,
		["332"] = 315,
		["333"] = 316,
		["336"] = 319,
		["337"] = 320,
		["338"] = 321,
		["340"] = 312,
		["341"] = 325,
		["342"] = 326,
		["343"] = 326,
		["344"] = 329,
		["345"] = 329,
		["346"] = 329,
		["347"] = 326,
		["348"] = 326,
		["349"] = 331,
		["350"] = 331,
		["351"] = 331,
		["352"] = 326,
		["353"] = 326,
		["354"] = 325,
		["355"] = 334,
		["356"] = 335,
		["357"] = 336,
		["358"] = 337,
		["359"] = 338,
		["360"] = 339,
		["361"] = 340,
		["362"] = 342,
		["363"] = 343,
		["364"] = 344,
		["365"] = 345,
		["368"] = 348,
		["371"] = 351,
		["372"] = 334,
		["373"] = 353,
		["374"] = 354,
		["375"] = 355,
		["377"] = 353,
		["378"] = 358,
		["379"] = 359,
		["380"] = 360,
		["381"] = 361,
		["382"] = 362,
		["386"] = 366,
		["387"] = 367,
		["388"] = 369,
		["389"] = 370,
		["391"] = 373,
		["393"] = 358,
		["394"] = 376,
		["395"] = 377,
		["396"] = 378,
		["397"] = 379,
		["398"] = 380,
		["399"] = 381,
		["404"] = 386,
		["405"] = 387,
		["406"] = 388,
		["407"] = 388,
		["408"] = 388,
		["409"] = 388,
		["410"] = 389,
		["411"] = 390,
		["413"] = 376,
		["414"] = 423,
		["415"] = 424,
		["416"] = 423,
		["417"] = 428,
		["418"] = 429,
		["419"] = 428,
		["420"] = 432,
		["421"] = 434,
		["424"] = 438,
		["425"] = 439,
		["426"] = 440,
		["427"] = 440,
		["428"] = 440,
		["429"] = 440,
		["430"] = 440,
		["431"] = 440,
		["432"] = 443,
		["433"] = 444,
		["435"] = 432,
		["436"] = 449,
		["437"] = 450,
		["438"] = 451,
		["440"] = 449,
		["441"] = 455,
		["442"] = 456,
		["443"] = 457,
		["445"] = 459,
		["446"] = 460,
		["447"] = 461,
		["448"] = 463,
		["449"] = 464,
		["451"] = 467,
		["452"] = 468,
		["454"] = 471,
		["455"] = 472,
		["457"] = 475,
		["458"] = 476,
		["460"] = 479,
		["461"] = 480,
		["462"] = 455,
		["463"] = 482,
		["464"] = 483,
		["465"] = 484,
		["466"] = 485,
		["467"] = 486,
		["472"] = 491,
		["473"] = 492,
		["474"] = 493,
		["475"] = 494,
		["476"] = 495,
		["477"] = 496,
		["480"] = 482,
		["481"] = 500,
		["482"] = 501,
		["483"] = 502,
		["484"] = 503,
		["485"] = 505,
		["486"] = 506,
		["487"] = 507,
		["488"] = 508,
		["489"] = 509,
		["491"] = 511,
		["493"] = 513,
		["494"] = 514,
		["495"] = 516,
		["498"] = 520,
		["499"] = 521,
		["500"] = 522,
		["501"] = 523,
		["502"] = 524,
		["504"] = 526,
		["506"] = 528,
		["507"] = 529,
		["508"] = 531,
		["511"] = 535,
		["512"] = 536,
		["513"] = 537,
		["514"] = 538,
		["515"] = 539,
		["517"] = 541,
		["519"] = 543,
		["520"] = 544,
		["521"] = 545,
		["524"] = 549,
		["525"] = 550,
		["526"] = 551,
		["527"] = 552,
		["528"] = 553,
		["530"] = 555,
		["532"] = 557,
		["533"] = 558,
		["534"] = 560,
		["537"] = 564,
		["538"] = 565,
		["539"] = 566,
		["540"] = 567,
		["541"] = 568,
		["543"] = 570,
		["545"] = 572,
		["546"] = 573,
		["547"] = 574,
		["550"] = 577,
		["551"] = 579,
		["552"] = 580,
		["553"] = 581,
		["554"] = 582,
		["555"] = 583,
		["557"] = 585,
		["559"] = 587,
		["560"] = 588,
		["561"] = 590,
		["564"] = 594,
		["565"] = 595,
		["566"] = 596,
		["567"] = 597,
		["568"] = 598,
		["570"] = 600,
		["572"] = 602,
		["573"] = 603,
		["574"] = 605,
		["577"] = 609,
		["578"] = 610,
		["579"] = 611,
		["580"] = 612,
		["581"] = 613,
		["583"] = 615,
		["585"] = 617,
		["586"] = 618,
		["587"] = 620,
		["591"] = 500,
		["592"] = 626,
		["593"] = 627,
		["596"] = 630,
		["599"] = 634,
		["600"] = 635,
		["601"] = 636,
		["603"] = 636,
		["607"] = 626,
		["608"] = 640,
		["609"] = 641,
		["610"] = 642,
		["611"] = 642,
		["612"] = 642,
		["613"] = 642,
		["614"] = 642,
		["615"] = 642,
		["616"] = 640,
		["617"] = 216,
		["618"] = 209,
		["619"] = 209,
		["620"] = 209,
		["621"] = 209,
		["622"] = 209,
		["623"] = 209,
		["624"] = 209,
		["625"] = 216,
		["627"] = 216,
		["628"] = 646,
		["629"] = 658,
		["630"] = 646,
		["631"] = 658,
		["633"] = 658,
		["634"] = 661,
		["635"] = 646,
		["636"] = 662,
		["637"] = 663,
		["638"] = 662,
		["639"] = 665,
		["640"] = 666,
		["641"] = 667,
		["642"] = 668,
		["643"] = 669,
		["644"] = 670,
		["645"] = 671,
		["646"] = 672,
		["647"] = 672,
		["648"] = 672,
		["649"] = 672,
		["650"] = 672,
		["652"] = 674,
		["653"] = 675,
		["654"] = 676,
		["655"] = 677,
		["656"] = 677,
		["657"] = 677,
		["658"] = 677,
		["659"] = 677,
		["660"] = 677,
		["661"] = 677,
		["662"] = 677,
		["663"] = 677,
		["664"] = 678,
		["666"] = 665,
		["667"] = 681,
		["668"] = 682,
		["669"] = 683,
		["670"] = 684,
		["671"] = 685,
		["674"] = 688,
		["675"] = 689,
		["677"] = 681,
		["678"] = 692,
		["679"] = 693,
		["680"] = 694,
		["681"] = 694,
		["682"] = 693,
		["683"] = 692,
		["684"] = 697,
		["685"] = 698,
		["686"] = 697,
		["687"] = 700,
		["688"] = 701,
		["689"] = 700,
		["690"] = 705,
		["691"] = 706,
		["692"] = 705,
		["693"] = 658,
		["694"] = 646,
		["695"] = 646,
		["696"] = 646,
		["697"] = 646,
		["698"] = 646,
		["699"] = 646,
		["700"] = 646,
		["701"] = 646,
		["702"] = 646,
		["703"] = 646,
		["704"] = 646,
		["705"] = 658,
		["707"] = 658,
		["708"] = 713,
		["709"] = 725,
		["710"] = 713,
		["711"] = 725,
		["712"] = 733,
		["713"] = 734,
		["714"] = 735,
		["715"] = 736,
		["716"] = 737,
		["717"] = 738,
		["718"] = 733,
		["719"] = 740,
		["720"] = 741,
		["721"] = 742,
		["722"] = 742,
		["723"] = 741,
		["724"] = 740,
		["725"] = 745,
		["726"] = 746,
		["727"] = 745,
		["728"] = 751,
		["729"] = 752,
		["730"] = 751,
		["731"] = 754,
		["732"] = 755,
		["733"] = 756,
		["735"] = 758,
		["736"] = 754,
		["737"] = 760,
		["738"] = 761,
		["739"] = 762,
		["740"] = 763,
		["741"] = 763,
		["742"] = 763,
		["743"] = 763,
		["744"] = 763,
		["745"] = 763,
		["747"] = 760,
		["748"] = 725,
		["749"] = 713,
		["750"] = 713,
		["751"] = 713,
		["752"] = 713,
		["753"] = 713,
		["754"] = 713,
		["755"] = 713,
		["756"] = 725,
		["758"] = 725,
		["759"] = 769,
		["760"] = 780,
		["761"] = 769,
		["762"] = 780,
		["763"] = 782,
		["764"] = 783,
		["765"] = 782,
		["766"] = 785,
		["767"] = 786,
		["768"] = 787,
		["770"] = 785,
		["771"] = 790,
		["772"] = 791,
		["773"] = 790,
		["774"] = 780,
		["775"] = 769,
		["776"] = 769,
		["777"] = 769,
		["778"] = 769,
		["779"] = 769,
		["780"] = 769,
		["781"] = 769,
		["782"] = 769,
		["783"] = 769,
		["784"] = 769,
		["785"] = 769,
		["786"] = 780,
		["788"] = 780,
		["789"] = 798,
		["790"] = 806,
		["791"] = 798,
		["792"] = 806,
		["793"] = 809,
		["794"] = 810,
		["795"] = 811,
		["796"] = 809,
		["797"] = 813,
		["798"] = 814,
		["799"] = 815,
		["801"] = 813,
		["802"] = 818,
		["803"] = 819,
		["804"] = 818,
		["805"] = 823,
		["806"] = 824,
		["807"] = 824,
		["808"] = 824,
		["809"] = 824,
		["810"] = 823,
		["811"] = 806,
		["812"] = 798,
		["813"] = 798,
		["814"] = 798,
		["815"] = 798,
		["816"] = 798,
		["817"] = 798,
		["818"] = 798,
		["819"] = 806,
		["821"] = 806,
		["823"] = 830,
		["824"] = 838,
		["825"] = 830,
		["826"] = 838,
		["827"] = 840,
		["828"] = 841,
		["829"] = 840,
		["830"] = 843,
		["831"] = 844,
		["832"] = 845,
		["833"] = 845,
		["834"] = 844,
		["835"] = 843,
		["836"] = 848,
		["837"] = 849,
		["838"] = 850,
		["839"] = 850,
		["840"] = 850,
		["841"] = 850,
		["842"] = 850,
		["843"] = 850,
		["844"] = 850,
		["845"] = 850,
		["846"] = 850,
		["848"] = 848,
		["849"] = 853,
		["850"] = 854,
		["851"] = 853,
		["852"] = 858,
		["853"] = 859,
		["854"] = 860,
		["856"] = 858,
		["857"] = 838,
		["858"] = 830,
		["859"] = 830,
		["860"] = 830,
		["861"] = 830,
		["862"] = 830,
		["863"] = 830,
		["864"] = 830,
		["865"] = 838,
		["867"] = 838,
		["869"] = 869,
		["870"] = 877,
		["871"] = 869,
		["872"] = 877,
		["873"] = 879,
		["874"] = 880,
		["875"] = 879,
		["876"] = 882,
		["877"] = 883,
		["878"] = 884,
		["879"] = 884,
		["880"] = 883,
		["881"] = 882,
		["882"] = 887,
		["883"] = 888,
		["884"] = 887,
		["885"] = 890,
		["886"] = 891,
		["887"] = 890,
		["888"] = 895,
		["889"] = 896,
		["890"] = 895,
		["891"] = 877,
		["892"] = 869,
		["893"] = 869,
		["894"] = 869,
		["895"] = 869,
		["896"] = 869,
		["897"] = 869,
		["898"] = 869,
		["899"] = 877,
		["901"] = 877,
		["903"] = 924,
		["904"] = 932,
		["905"] = 924,
		["906"] = 932,
		["907"] = 936,
		["908"] = 937,
		["909"] = 938,
		["910"] = 939,
		["911"] = 936,
		["912"] = 941,
		["913"] = 942,
		["914"] = 941,
		["915"] = 944,
		["916"] = 945,
		["917"] = 946,
		["919"] = 944,
		["920"] = 949,
		["921"] = 950,
		["922"] = 949,
		["923"] = 954,
		["924"] = 955,
		["925"] = 956,
		["926"] = 954,
		["927"] = 932,
		["928"] = 924,
		["929"] = 924,
		["930"] = 924,
		["931"] = 924,
		["932"] = 924,
		["933"] = 924,
		["934"] = 924,
		["935"] = 932,
		["937"] = 932,
		["939"] = 960,
		["940"] = 968,
		["941"] = 960,
		["942"] = 968,
		["944"] = 968,
		["945"] = 972,
		["946"] = 960,
		["947"] = 973,
		["948"] = 974,
		["949"] = 975,
		["950"] = 976,
		["951"] = 973,
		["952"] = 978,
		["953"] = 979,
		["954"] = 980,
		["955"] = 981,
		["956"] = 982,
		["959"] = 978,
		["960"] = 986,
		["961"] = 987,
		["962"] = 986,
		["963"] = 991,
		["964"] = 992,
		["967"] = 995,
		["968"] = 991,
		["969"] = 997,
		["970"] = 998,
		["971"] = 999,
		["973"] = 997,
		["974"] = 1002,
		["975"] = 1003,
		["976"] = 1002,
		["977"] = 1011,
		["978"] = 1012,
		["979"] = 1012,
		["980"] = 1012,
		["981"] = 1012,
		["982"] = 1011,
		["983"] = 968,
		["984"] = 960,
		["985"] = 960,
		["986"] = 960,
		["987"] = 960,
		["988"] = 960,
		["989"] = 960,
		["990"] = 960,
		["991"] = 968,
		["993"] = 968,
		["995"] = 1017,
		["996"] = 1025,
		["997"] = 1017,
		["998"] = 1025,
		["1000"] = 1025,
		["1001"] = 1029,
		["1002"] = 1017,
		["1003"] = 1030,
		["1004"] = 1031,
		["1005"] = 1032,
		["1006"] = 1034,
		["1007"] = 1030,
		["1008"] = 1036,
		["1009"] = 1037,
		["1010"] = 1038,
		["1012"] = 1036,
		["1013"] = 1041,
		["1014"] = 1042,
		["1015"] = 1043,
		["1016"] = 1043,
		["1017"] = 1042,
		["1018"] = 1045,
		["1019"] = 1046,
		["1020"] = 1046,
		["1021"] = 1046,
		["1022"] = 1047,
		["1023"] = 1047,
		["1024"] = 1046,
		["1025"] = 1046,
		["1027"] = 1050,
		["1028"] = 1041,
		["1029"] = 1052,
		["1030"] = 1053,
		["1033"] = 1056,
		["1034"] = 1052,
		["1035"] = 1058,
		["1036"] = 1059,
		["1037"] = 1060,
		["1039"] = 1058,
		["1040"] = 1063,
		["1041"] = 1064,
		["1044"] = 1067,
		["1045"] = 1068,
		["1046"] = 1069,
		["1047"] = 1070,
		["1048"] = 1070,
		["1049"] = 1070,
		["1050"] = 1070,
		["1051"] = 1070,
		["1052"] = 1070,
		["1053"] = 1070,
		["1054"] = 1070,
		["1057"] = 1063,
		["1058"] = 1074,
		["1059"] = 1075,
		["1060"] = 1074,
		["1061"] = 1079,
		["1062"] = 1080,
		["1063"] = 1080,
		["1064"] = 1080,
		["1065"] = 1080,
		["1066"] = 1079,
		["1067"] = 1025,
		["1068"] = 1017,
		["1069"] = 1017,
		["1070"] = 1017,
		["1071"] = 1017,
		["1072"] = 1017,
		["1073"] = 1017,
		["1074"] = 1017,
		["1075"] = 1025,
		["1077"] = 1025,
		["1079"] = 1085,
		["1080"] = 1093,
		["1081"] = 1085,
		["1082"] = 1093,
		["1083"] = 1094,
		["1084"] = 1095,
		["1085"] = 1096,
		["1086"] = 1096,
		["1087"] = 1095,
		["1088"] = 1094,
		["1089"] = 1099,
		["1090"] = 1100,
		["1091"] = 1099,
		["1092"] = 1103,
		["1093"] = 1104,
		["1094"] = 1103,
		["1095"] = 1108,
		["1096"] = 1109,
		["1097"] = 1108,
		["1098"] = 1093,
		["1099"] = 1085,
		["1100"] = 1085,
		["1101"] = 1085,
		["1102"] = 1085,
		["1103"] = 1085,
		["1104"] = 1085,
		["1105"] = 1085,
		["1106"] = 1093,
		["1108"] = 1093,
		["1110"] = 1114,
		["1111"] = 1122,
		["1112"] = 1114,
		["1113"] = 1122,
		["1114"] = 1126,
		["1115"] = 1127,
		["1116"] = 1128,
		["1117"] = 1126,
		["1118"] = 1130,
		["1119"] = 1131,
		["1120"] = 1132,
		["1121"] = 1133,
		["1122"] = 1134,
		["1123"] = 1135,
		["1124"] = 1135,
		["1126"] = 1130,
		["1127"] = 1138,
		["1128"] = 1139,
		["1129"] = 1140,
		["1130"] = 1141,
		["1131"] = 1141,
		["1133"] = 1138,
		["1134"] = 1144,
		["1135"] = 1145,
		["1136"] = 1146,
		["1137"] = 1147,
		["1138"] = 1148,
		["1139"] = 1149,
		["1142"] = 1144,
		["1143"] = 1153,
		["1144"] = 1154,
		["1145"] = 1153,
		["1146"] = 1158,
		["1147"] = 1159,
		["1148"] = 1159,
		["1149"] = 1159,
		["1150"] = 1159,
		["1151"] = 1158,
		["1152"] = 1122,
		["1153"] = 1114,
		["1154"] = 1114,
		["1155"] = 1114,
		["1156"] = 1114,
		["1157"] = 1114,
		["1158"] = 1114,
		["1159"] = 1114,
		["1160"] = 1122,
		["1162"] = 1122,
		["1164"] = 1164,
		["1165"] = 1164,
		["1166"] = 1171,
		["1167"] = 1178,
		["1168"] = 1179,
		["1169"] = 1180,
		["1170"] = 1181,
		["1171"] = 1182,
		["1172"] = 1183,
		["1173"] = 1185,
		["1174"] = 1186,
		["1175"] = 1187,
		["1176"] = 1178,
		["1177"] = 1189,
		["1178"] = 1190,
		["1179"] = 1189,
		["1180"] = 1194,
		["1181"] = 1196,
		["1182"] = 1197,
		["1183"] = 1197,
		["1184"] = 1197,
		["1185"] = 1197,
		["1186"] = 1197,
		["1187"] = 1197,
		["1189"] = 1194,
		["1190"] = 1200,
		["1191"] = 1201,
		["1192"] = 1200,
		["1193"] = 1207,
		["1194"] = 1208,
		["1195"] = 1207,
		["1196"] = 1210,
		["1197"] = 1211,
		["1198"] = 1210,
		["1199"] = 1213,
		["1200"] = 1214,
		["1201"] = 1213,
		["1202"] = 1171,
		["1203"] = 1164,
		["1204"] = 1164,
		["1205"] = 1164,
		["1206"] = 1164,
		["1207"] = 1164,
		["1208"] = 1164,
		["1209"] = 1164,
		["1210"] = 1171,
		["1213"] = 1220,
		["1214"] = 1228,
		["1215"] = 1220,
		["1216"] = 1228,
		["1217"] = 1232,
		["1218"] = 1233,
		["1219"] = 1234,
		["1220"] = 1232,
		["1221"] = 1236,
		["1222"] = 1237,
		["1223"] = 1238,
		["1224"] = 1239,
		["1225"] = 1240,
		["1226"] = 1241,
		["1227"] = 1241,
		["1229"] = 1236,
		["1230"] = 1244,
		["1231"] = 1245,
		["1232"] = 1246,
		["1233"] = 1247,
		["1234"] = 1247,
		["1236"] = 1244,
		["1237"] = 1250,
		["1238"] = 1251,
		["1239"] = 1252,
		["1240"] = 1253,
		["1241"] = 1254,
		["1242"] = 1255,
		["1245"] = 1250,
		["1246"] = 1259,
		["1247"] = 1260,
		["1248"] = 1259,
		["1249"] = 1264,
		["1250"] = 1265,
		["1251"] = 1265,
		["1252"] = 1265,
		["1253"] = 1265,
		["1254"] = 1265,
		["1255"] = 1265,
		["1256"] = 1265,
		["1257"] = 1264,
		["1258"] = 1228,
		["1259"] = 1220,
		["1260"] = 1220,
		["1261"] = 1220,
		["1262"] = 1220,
		["1263"] = 1220,
		["1264"] = 1220,
		["1265"] = 1220,
		["1266"] = 1228,
		["1268"] = 1228,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_attack = c()
local n = g.sect_attack
n.name = "sect_attack"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.sectBuffActived = false
	self.r_16_ready = true
	self.sr_152_enable = false
end
function n.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetSpecialValueFor("attackspeed")
	self.attackdamage = self:GetSpecialValueFor("attackdamage")
	self.n_1_chance = self:GetSectSpecialValueFor("1", "n_1_chance")
	self.n_1_regen = self:GetSectSpecialValueFor("1", "n_1_regen")
	self.n_2_chance = self:GetSectSpecialValueFor("2", "n_2_chance")
	self.n_2_poison = self:GetSectSpecialValueFor("2", "n_2_poison")
	self.n_3_chance = self:GetSectSpecialValueFor("3", "n_3_chance")
	self.n_3_mana = self:GetSectSpecialValueFor("3", "n_3_mana")
	self.n_5_chance = self:GetSectSpecialValueFor("5", "n_5_chance")
	self.n_5_reduce_damage = self:GetSectSpecialValueFor("5", "n_5_reduce_damage")
	self.n_6_chance = self:GetSectSpecialValueFor("6", "n_6_chance")
	self.n_6_ice = self:GetSectSpecialValueFor("6", "n_6_ice")
	self.n_7_chance = self:GetSectSpecialValueFor("7", "n_7_chance")
	self.n_7_shield = self:GetSectSpecialValueFor("7", "n_7_shield")
	self.n_9_chance = self:GetSectSpecialValueFor("9", "n_9_chance")
	self.n_9_injury = self:GetSectSpecialValueFor("9", "n_9_injury")
	self.n_10_attack_pct = self:GetSectSpecialValueFor("10", "n_10_attack_pct")
	self.n_122_chance = self:GetSectSpecialValueFor("122", "n_122_chance")
	self.n_122_fury = self:GetSectSpecialValueFor("122", "n_122_fury")
	self.sr_152_duration = self:GetSectSpecialValueFor("152", "sr_152_duration")
	self.sr_159_lifesteal = self:GetSectSpecialValueFor("159", "sr_159_lifesteal")
	self.n_166_chance = self:GetSectSpecialValueFor("166", "n_166_chance")
	self.n_166_chaos_count = self:GetSectSpecialValueFor("166", "n_166_chaos_count")
end
function n.prototype.RecordInheitUnit(self, o)
	self.inherit_unit = o
end
function n.prototype.TriggerByName(self, p, q)
	if q == nil then
		q = self:GetCaster():GetEnemy()
	end
	local r = self:GetCaster()
	if not IsInjurable(r, q) then
		return
	end
	repeat
		local s = p
		local o
		local t = s == "1"
		if t then
			Heal(r, GetSectAttackModifiedValue(r, self.n_1_regen), "1", "AbilityUpgrade")
			break
		end
		t = t or s == "2"
		if t then
			AddPoison(r, q, GetSectAttackModifiedValue(r, self.n_2_poison), "2", "AbilityUpgrade")
			break
		end
		t = t or s == "3"
		if t then
			Restore(r, GetSectAttackModifiedValue(r, self.n_3_mana))
			break
		end
		t = t or s == "6"
		if t then
			AddIce(r, q, GetSectAttackModifiedValue(r, self.n_6_ice), "6", "AbilityUpgrade")
			break
		end
		t = t or s == "7"
		if t then
			AddShield(r, GetSectAttackModifiedValue(r, self.n_7_shield), "7", "AbilityUpgrade")
			break
		end
		t = t or s == "9"
		if t then
			AddInjury(r, q, GetSectAttackModifiedValue(r, self.n_9_injury), "9", "AbilityUpgrade")
			break
		end
		t = t or s == "14"
		if t then
			r:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 2)
			o = self.inherit_unit or r
			if o:IsRangedAttacker() then
				Projectile:CreateTrackingProjectile({
					EffectName = o:GetRangedProjectileName(),
					hCaster = o,
					hTarget = q,
					iMoveSpeed = o:GetProjectileSpeed(),
					OnProjectileHit = function(u, v, w)
						if IsInjurable(u) then
							DamageSystem:performAttack(
								r,
								u,
								{
									damage = GetAttackDamage(o),
									ability = self,
									ability_upgrade = "14",
									damage_flags = o ~= r and DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
										or DamageFlags.DAMAGE_FLAG_NONE,
								}
							)
						end
					end,
				})
			else
				DamageSystem:performAttack(
					r,
					q,
					{
						damage = GetAttackDamage(o),
						ability = self,
						ability_upgrade = "14",
						damage_flags = o ~= r and DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
							or DamageFlags.DAMAGE_FLAG_NONE,
					}
				)
			end
			break
		end
		t = t or s == "13"
		if t then
			do
				local o = self.inherit_unit or r
				if IsValid(o) then
					if o:HasModifier("modifier_sect_attack_13_buff") then
						local x = o:FindModifierByName("modifier_sect_attack_13_buff")
						x:AddStack()
					end
				end
			end
			break
		end
		t = t or s == "15"
		if t then
			do
				local o = self.inherit_unit or r
				if IsValid(o) then
					if o:HasModifier("modifier_sect_attack_15_buff") then
						local x = o:FindModifierByName("modifier_sect_attack_15_buff")
						x:AddStack()
					end
				end
			end
			break
		end
		t = t or s == "16"
		if t then
			do
				local o = self.inherit_unit or r
				if IsValid(o) then
					if o:IsRangedAttacker() then
						Projectile:CreateTrackingProjectile({
							EffectName = o:GetRangedProjectileName(),
							hCaster = o,
							hTarget = q,
							iMoveSpeed = o:GetProjectileSpeed(),
							OnProjectileHit = function(u, v, w)
								if IsValid(self) and IsInjurable(u) then
									DamageSystem:performAttack(
										o,
										u,
										{
											damage = GetAttackDamage(o),
											ability = self,
											ability_upgrade = "16",
											damage_flags = o ~= o and DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
												or DamageFlags.DAMAGE_FLAG_NONE,
										}
									)
								end
							end,
						})
					else
						DamageSystem:performAttack(
							o,
							q,
							{
								damage = GetAttackDamage(o),
								ability = self,
								ability_upgrade = "16",
								damage_flags = o ~= o and DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
									or DamageFlags.DAMAGE_FLAG_NONE,
							}
						)
					end
					local y = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						o
					)
					ParticleManager:SetParticleControlEnt(y, 1, o, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, false)
					ParticleManager:SetParticleControl(y, 2, Vector(0, 1, 0))
					o:EmitSound("Hero_LegionCommander.Courage")
				end
			end
			break
		end
		t = t or s == "122"
		if t then
			AddFury(r, GetSectAttackModifiedValue(r, self.n_122_fury), "122", "AbilityUpgrade")
			break
		end
		t = t or s == "166"
		if t then
			AddChaos(
				r,
				GetSectAttackModifiedValue(r, GetSectChaosModifiedValue(r, self.n_166_chaos_count)),
				"166",
				"AbilityUpgrade"
			)
			break
		end
	until true
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_attack"
end
n = e({ j(nil) }, n)
g.sect_attack = n
g.modifier_sect_attack = c()
local z = g.modifier_sect_attack
z.name = "modifier_sect_attack"
d(z, l)
function z.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.sectBuffActived = false
	self.r_16_ready = true
	self.sr_152_enable = false
	self.sr_152_initialized = false
end
function z.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attackdamage = self:GetAbilitySpecialValueFor("attackdamage")
	self.n_1_chance = self:GetSectSpecialValueFor("1", "n_1_chance")
	self.n_1_regen = self:GetSectSpecialValueFor("1", "n_1_regen")
	self.n_2_chance = self:GetSectSpecialValueFor("2", "n_2_chance")
	self.n_2_poison = self:GetSectSpecialValueFor("2", "n_2_poison")
	self.n_3_chance = self:GetSectSpecialValueFor("3", "n_3_chance")
	self.n_3_mana = self:GetSectSpecialValueFor("3", "n_3_mana")
	self.n_5_chance = self:GetSectSpecialValueFor("5", "n_5_chance")
	self.n_5_reduce_damage = self:GetSectSpecialValueFor("5", "n_5_reduce_damage")
	self.n_6_chance = self:GetSectSpecialValueFor("6", "n_6_chance")
	self.n_6_ice = self:GetSectSpecialValueFor("6", "n_6_ice")
	self.n_7_chance = self:GetSectSpecialValueFor("7", "n_7_chance")
	self.n_7_shield = self:GetSectSpecialValueFor("7", "n_7_shield")
	self.n_9_chance = self:GetSectSpecialValueFor("9", "n_9_chance")
	self.n_9_injury = self:GetSectSpecialValueFor("9", "n_9_injury")
	self.n_10_attack_pct = self:GetSectSpecialValueFor("10", "n_10_attack_pct")
	self.r_13_attack = self:GetSectSpecialValueFor("13", "r_13_attack")
	self.r_14_chance = self:GetSectSpecialValueFor("14", "r_14_chance")
	self.r_14_cooldown = self:GetSectSpecialValueFor("14", "cooldown")
	self.r_15_attackspeed = self:GetSectSpecialValueFor("15", "r_15_attackspeed")
	self.sr_16_chance = self:GetSectSpecialValueFor("16", "sr_16_chance")
	self.sr_16_cooldown = self:GetSectSpecialValueFor("16", "sr_16_cooldown")
	self.n_122_chance = self:GetSectSpecialValueFor("122", "n_122_chance")
	self.n_122_fury = self:GetSectSpecialValueFor("122", "n_122_fury")
	self.sr_152_duration = self:GetSectSpecialValueFor("152", "sr_152_duration")
	if not self.sr_152_initialized and self.sr_152_duration > 0 then
		self.sr_152_enable = true
		self.sr_152_initialized = true
	end
	self.sr_159_lifesteal = self:GetSectSpecialValueFor("159", "sr_159_lifesteal")
	self.n_166_chance = self:GetSectSpecialValueFor("166", "n_166_chance")
	self.n_166_chaos_count = self:GetSectSpecialValueFor("166", "n_166_chaos_count")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_attack_trigger", "chance")
	self.effect_duration = self:GetCustomAbilityValueFor("sect_attack_effect", "duration")
	self.ability:GetAbilitySpecialValue()
end
function z.prototype.OnThink(self, A)
	local B = self:GetParent()
	local C = B:GetEnemy()
	if not IsInjurable(C) then
		self:StartThink(-1, A)
		return
	end
	if A == "sr_16_cooldown" then
		self:StartThink(-1, A)
		self.r_16_ready = true
	end
end
function z.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function z.prototype.OnBattleStartBefore(self, D)
	local B = self:GetParent()
	local q = B:GetEnemy()
	local E = self:GetAbility()
	self.r_16_ready = true
	self.sr_152_enable = self.sr_152_duration > 0
	self.sr_152_initialized = true
	if self.n_5_chance > 0 then
		B:AddNewModifier(B, E, "modifier_sect_attack_5_buff", nil)
		if IsValid(q) then
			q:AddNewModifier(B, E, "modifier_sect_attack_5_debuff", nil)
		end
	end
	if IsSectAttackDisabled(B) then
		return
	end
	self:ActivateSectBuff(B)
end
function z.prototype.OnBattleEnd(self, D)
	if IsServer() then
		self:StartThink(-1, "sr_139_interval")
	end
end
function z.prototype.OnCustomAttackLanded(self, F)
	local G = F.attacker
	local u = F.target
	if self.inherit_unit ~= nil then
		if
			not IsInjurable(self.inherit_unit)
			or bit.band(F.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK)
				~= DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
		then
			return
		end
	end
	if G == self:GetParent() then
		self:TriggerNormalEffect(u, F)
		if self.r_14_chance > 0 and self:PRD(self.r_14_chance, "r_14_chance") then
			self.ability:TriggerByName("14", u)
		end
		self:customAbilityTrigger()
	end
end
function z.prototype.OnCustomTakeDamage(self, D)
	local H = self:GetParent()
	local o = H
	if self.inherit_unit ~= nil then
		if IsInjurable(self.inherit_unit) then
			o = self.inherit_unit
		else
			return
		end
	end
	if
		self.sr_16_chance > 0
		and self.r_16_ready
		and self:GetAbility():IsCooldownReady()
		and self:PRD(self.sr_16_chance)
	then
		self.r_16_ready = false
		local I = math.max(-95, GetSectAttackGainPercentage(H))
		self:StartThink(self.sr_16_cooldown / (1 + I * 0.01), "sr_16_cooldown")
		self.ability:TriggerByName("16", D.attacker)
	end
end
function z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BASE }
end
function z.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function z.prototype.EOM_GetModifierAvoidDamage(self, D)
	if bit.band(D.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return
	end
	if self.sr_152_enable and D.damage >= D.target:GetHealth() then
		local H = self:GetParent()
		H:AddNewModifier(H, self:GetAbility(), "modifier_sect_attack_152_buff", { duration = self.sr_152_duration })
		self.sr_152_enable = false
		return 1
	end
end
function z.prototype.SetInheritUnit(self, J)
	if self:ActivateSectBuff(J) then
		self.inherit_unit = J
	end
end
function z.prototype.ActivateSectBuff(self, o)
	if self.sectBuffActived then
		return false
	end
	self.sectBuffActived = true
	local r = self.caster
	local E = self.ability
	if self.r_13_attack > 0 then
		o:AddNewModifier(r, E, "modifier_sect_attack_13_buff", nil)
	end
	if self.r_15_attackspeed > 0 then
		o:AddNewModifier(r, E, "modifier_sect_attack_15_buff", nil)
	end
	if self.n_10_attack_pct > 0 then
		o:AddNewModifier(r, E, "modifier_sect_attack_10_buff", nil)
	end
	if self.sr_159_lifesteal > 0 then
		o:AddNewModifier(r, E, "modifier_sect_attack_159_buff", nil)
	end
	o:AddNewModifier(r, E, "modifier_sect_attack_attribute", nil)
	return true
end
function z.prototype.TriggerRAndSREffect(self, q, F)
	local o = self.parent
	if self.inherit_unit ~= nil then
		if IsInjurable(self.inherit_unit) then
			o = self.inherit_unit
		else
			return
		end
	end
	local E = self.ability
	E:TriggerByName("13", q)
	E:TriggerByName("15", q)
	if self.r_14_chance > 0 then
		if self:PRD(self.r_14_chance, "r_14_chance") then
			E:TriggerByName("14", q)
		end
	end
end
function z.prototype.TriggerNormalEffect(self, q, F, K)
	local r = self:GetParent()
	local L = GetModifierProperty(r, EOMModifierFunction.EOM_MODIFIER_PROPERTY_SECT_ATTACK_PROC_BONUS_CHANCE, F)
	local M = 0
	if self.n_1_chance > 0 then
		local N = "n_1_chance"
		if K then
			M = K
			N = "n_1_chanceOR"
		else
			M = self.n_1_chance
		end
		M = M + L
		if self:PRD(M, N) then
			self.ability:TriggerByName("1")
		end
	end
	if self.n_3_chance > 0 then
		local N = "n_3_chance"
		if K then
			M = K
			N = "n_3_chanceOR"
		else
			M = self.n_3_chance
		end
		M = M + L
		if self:PRD(M, N) then
			self.ability:TriggerByName("3")
		end
	end
	if self.n_122_chance > 0 then
		local N = "n_122_chance"
		if K then
			M = K
			N = "n_122_chanceOR"
		else
			M = self.n_122_chance
		end
		M = M + L
		if self:PRD(M, N) then
			self.ability:TriggerByName("122")
		end
	end
	if self.n_7_chance > 0 then
		local N = "n_7_chance"
		if K then
			M = K
			N = "n_7_chanceOR"
		else
			M = self.n_7_chance
		end
		M = M + L
		if self:PRD(M, N) then
			self.ability:TriggerByName("7")
		end
	end
	if self.n_166_chance > 0 then
		local N = "n_166_chance"
		if K then
			M = K
			N = "n_166_chanceOR"
		else
			M = self.n_166_chance
		end
		M = M + L
		if self:PRD(M, N) then
			self.ability:TriggerByName("166")
		end
	end
	if IsValid(q) then
		if self.n_2_chance > 0 then
			local N = "n_2_chance"
			if K then
				M = K
				N = "n_2_chanceOR"
			else
				M = self.n_2_chance
			end
			M = M + L
			if self:PRD(M, N) then
				self.ability:TriggerByName("2", q)
			end
		end
		if self.n_6_chance > 0 then
			local N = "n_6_chance"
			if K then
				M = K
				N = "n_6_chanceOR"
			else
				M = self.n_6_chance
			end
			M = M + L
			if self:PRD(M, N) then
				self.ability:TriggerByName("6", q)
			end
		end
		if self.n_9_chance > 0 then
			local N = "n_9_chance"
			if K then
				M = K
				N = "n_9_chanceOR"
			else
				M = self.n_9_chance
			end
			M = M + L
			if self:PRD(M, N) then
				self.ability:TriggerByName("9", q)
			end
		end
	end
end
function z.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_attack" then
		return
	end
	if self.trigger_chance > 0 then
		if self.trigger_chance > 0 and self:PRD(self.trigger_chance) then
			local O = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if O ~= nil then
				O:customAbilityEffect()
			end
		end
	end
end
function z.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_sect_attack_effect_buff",
		{ duration = self.effect_duration }
	)
end
z = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	z
)
g.modifier_sect_attack = z
g.modifier_sect_attack_152_buff = c()
local P = g.modifier_sect_attack_152_buff
P.name = "modifier_sect_attack_152_buff"
d(P, l)
function P.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.battleEnd = false
end
function P.prototype.GetAbilitySpecialValue(self)
	self.sr_152_health_pct = self:GetSectSpecialValueFor("152", "sr_152_health_pct")
end
function P.prototype.OnCreated(self, D)
	local H = self:GetParent()
	if IsServer() then
		self.enemy = H:GetEnemy()
		CombatLog:recordSectAbilityCast(H, "152")
		H:SetHealth(H:GetMaxHealth() * self.sr_152_health_pct * 0.01)
		H:EmitSound("Hero_SkeletonKing.Reincarnate.Ghost")
		EmitSoundOnLocationWithCaster(H:GetAbsOrigin(), "Hero_NyxAssassin.Vendetta", H)
	else
		local Q = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf",
			PATTACH_ABSORIGIN,
			H
		)
		ParticleManager:ReleaseParticleIndex(Q)
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_start.vpcf",
			PATTACH_CUSTOMORIGIN,
			H
		)
		ParticleManager:SetParticleControlEnt(R, 0, H, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
		ParticleManager:ReleaseParticleIndex(R)
	end
end
function P.prototype.OnDestroy(self)
	local H = self:GetParent()
	if IsServer() then
		if not self.battleEnd and IsInjurable(H, self.enemy) then
			DamageSystem:kill(self.enemy, H)
		end
	else
		local R = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_skeletonking/wraith_king_death.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			H
		)
		ParticleManager:ReleaseParticleIndex(R)
	end
end
function P.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function P.prototype.OnBattleEnd(self, D)
	self.battleEnd = true
end
function P.prototype.EFunctionValues(self)
	return {}
end
function P.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
P = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				GetEffectName = "particles/units/heroes/hero_skeletonking/wraith_king_ghosts_ambient.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
				GetStatusEffectName = "particles/status_fx/status_effect_wraithking_ghosts.vpcf",
			}
		),
	},
	P
)
g.modifier_sect_attack_152_buff = P
g.modifier_sect_attack_159_buff = c()
local S = g.modifier_sect_attack_159_buff
S.name = "modifier_sect_attack_159_buff"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.sr_159_threshold = self:GetSectSpecialValueFor("159", "sr_159_threshold")
	self.sr_159_lifesteal = self:GetSectSpecialValueFor("159", "sr_159_lifesteal")
	self.sr_159_lifesteal_bonus = self:GetSectSpecialValueFor("159", "sr_159_lifesteal_bonus")
	self.sr_159_rate = self:GetSectSpecialValueFor("159", "sr_159_rate")
	self.sr_159_duration = self:GetSectSpecialValueFor("159", "sr_159_duration")
end
function S.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetCaster() } }
end
function S.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL,
	}
end
function S.prototype.EOM_GetModifierAttackRateBonus(self, D)
	return -self.sr_159_rate
end
function S.prototype.EOM_GetModifierLifesteal(self, D)
	if self.parent:HasModifier("modifier_sect_attack_159_effect") then
		return self.sr_159_lifesteal + self.sr_159_lifesteal_bonus
	end
	return self.sr_159_lifesteal
end
function S.prototype.OnCustomTakeDamage(self, F)
	if not self.flag and self:GetCaster():GetHealthPercent() <= self.sr_159_threshold then
		self.flag = true
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_sect_attack_159_effect",
			{ duration = self.sr_159_duration }
		)
	end
end
S = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	S
)
g.modifier_sect_attack_159_buff = S
g.modifier_sect_attack_159_effect = c()
local T = g.modifier_sect_attack_159_effect
T.name = "modifier_sect_attack_159_effect"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.sr_159_as = self:GetSectSpecialValueFor("159", "sr_159_as")
end
function T.prototype.OnCreated(self, D)
	if IsServer() then
		self:GetParent():EmitSound("Hero_TrollWarlord.BattleTrance.Cast")
	end
end
function T.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.sr_159_as }
end
T = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				GetEffectName = "particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
				GetStatusEffectName = "particles/status_fx/status_effect_troll_warlord_battletrance.vpcf",
			}
		),
	},
	T
)
g.modifier_sect_attack_159_effect = T
g.modifier_sect_attack_10_buff = c()
local U = g.modifier_sect_attack_10_buff
U.name = "modifier_sect_attack_10_buff"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self)
	self.n_10_attack_pct = self:GetSectSpecialValueFor("10", "n_10_attack_pct")
	self.n_10_count = self:GetSectSpecialValueFor("10", "n_10_count")
end
function U.prototype.OnCreated(self, D)
	if IsServer() then
		self:SetStackCount(math.floor(GetBaseEvasion(self.caster) / self.n_10_count))
	end
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function U.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, D)
	return GetSectAttackModifiedValue(self.caster, self:GetStackCount() * self.n_10_attack_pct)
end
U = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	U
)
g.modifier_sect_attack_10_buff = U
g.modifier_sect_attack_5_buff = c()
local V = g.modifier_sect_attack_5_buff
V.name = "modifier_sect_attack_5_buff"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.n_5_chance = self:GetSectSpecialValueFor("5", "n_5_chance")
end
function V.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BLOCK] = { self:GetParent(), -1 } }
end
function V.prototype.OnBlock(self, D)
	if D.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		PlayerData:addDetailData(
			D.attacker,
			"Attack",
			"attack_blocked",
			math.floor(D.damage),
			false,
			"Attack",
			D.damage_type
		)
	end
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE }
end
function V.prototype.EOM_GetModifierAllBlockChance(self, D)
	if D.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.n_5_chance
	end
end
V = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	V
)
g.modifier_sect_attack_5_buff = V
g.modifier_sect_attack_5_debuff = c()
local W = g.modifier_sect_attack_5_debuff
W.name = "modifier_sect_attack_5_debuff"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.n_5_reduce_damage = self:GetSectSpecialValueFor("5", "n_5_reduce_damage")
end
function W.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function W.prototype.OnBattleEnd(self)
	self:Destroy()
end
function W.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function W.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, D)
	return -self.n_5_reduce_damage
end
W = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	W
)
g.modifier_sect_attack_5_debuff = W
g.modifier_sect_attack_8_buff = c()
local X = g.modifier_sect_attack_8_buff
X.name = "modifier_sect_attack_8_buff"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.n_8_deficit = self:GetSectSpecialValueFor("8", "n_8_deficit")
	self.n_8_attackdamage = self:GetSectSpecialValueFor("8", "n_8_attackdamage")
	self.tick = 0.1
end
function X.prototype.OnCreated(self, D)
	self:StartIntervalThink(self.tick)
end
function X.prototype.OnIntervalThink(self)
	if IsServer() then
		self:SetStackCount(math.floor(self:GetParent():GetHealthDeficit() / self.n_8_deficit))
	end
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BASE }
end
function X.prototype.EOM_GetModifierAttackDamageBase(self)
	local Y = self:GetStackCount() * self.n_8_attackdamage
	return Y
end
X = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	X
)
g.modifier_sect_attack_8_buff = X
g.modifier_sect_attack_13_buff = c()
local Z = g.modifier_sect_attack_13_buff
Z.name = "modifier_sect_attack_13_buff"
d(Z, l)
function Z.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.isInherit = false
end
function Z.prototype.GetAbilitySpecialValue(self)
	self.r_13_attack = self:GetSectSpecialValueFor("13", "r_13_attack")
	self.r_13_max_stack = self:GetSectSpecialValueFor("13", "r_13_max_stack")
	self.r_13_pre_stack_count = self:GetSectSpecialValueFor("13", "r_13_pre_stack_count")
end
function Z.prototype.OnCreated(self, D)
	if IsServer() then
		self.isInherit = self:GetParent() ~= self.caster
		if self.r_13_pre_stack_count > 0 then
			self:SetStackCount(math.min(self.r_13_pre_stack_count, self.r_13_max_stack))
		end
	end
end
function Z.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.caster, -1 } }
end
function Z.prototype.OnCustomAttackLanded(self, F)
	if
		self.isInherit
		and bit.band(F.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK)
			~= DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
	then
		return
	end
	self:AddStack()
end
function Z.prototype.AddStack(self)
	if self:GetStackCount() < self.r_13_max_stack then
		self:IncrementStackCount()
	end
end
function Z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function Z.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, D)
	return GetSectAttackModifiedValue(self:GetCaster(), self:GetStackCount() * self.r_13_attack)
end
Z = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Z
)
g.modifier_sect_attack_13_buff = Z
g.modifier_sect_attack_15_buff = c()
local _ = g.modifier_sect_attack_15_buff
_.name = "modifier_sect_attack_15_buff"
d(_, l)
function _.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.isInherit = false
end
function _.prototype.GetAbilitySpecialValue(self)
	self.r_15_attackspeed = self:GetSectSpecialValueFor("15", "r_15_attackspeed")
	self.r_15_max_stack = self:GetSectSpecialValueFor("15", "r_15_max_stack")
	self.r_15_effect_1 = self:GetSectSpecialValueFor("15", "effect_1")
end
function _.prototype.OnCreated(self, D)
	if IsServer() then
		self.isInherit = self:GetParent() ~= self.caster
	end
end
function _.prototype.EDeclareEvents(self)
	local a0 = { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetCaster(), -1 } }
	if self:GetSectSpecialValueFor("15", "effect_1") > 0 then
		return vlua.tableadd(a0, { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetCaster(), -1 } })
	end
	return a0
end
function _.prototype.OnCustomAttackLanded(self, F)
	if
		self.isInherit
		and bit.band(F.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK)
			~= DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
	then
		return
	end
	self:AddStack()
end
function _.prototype.AddStack(self)
	if self:GetStackCount() < self.r_15_max_stack then
		self:IncrementStackCount()
	end
end
function _.prototype.OnCustomTakeDamage(self, F)
	if
		self.isInherit
		and bit.band(F.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK)
			~= DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
	then
		return
	end
	if F.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		local a1 = self:GetStackCount() * self.r_15_effect_1
		if a1 > 0 then
			Heal(F.attacker, F.damage * a1 * 0.01, "15", "AbilityUpgrade", false, HealFlags.HEAL_FLAG_LIFESETEAL)
		end
	end
end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function _.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return GetSectAttackModifiedValue(self:GetParent(), self:GetStackCount() * self.r_15_attackspeed)
end
_ = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	_
)
g.modifier_sect_attack_15_buff = _
g.modifier_sect_attack_14_buff = c()
local a2 = g.modifier_sect_attack_14_buff
a2.name = "modifier_sect_attack_14_buff"
d(a2, l)
function a2.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function a2.prototype.OnCustomAttackLanded(self, F)
	self:Destroy()
end
function a2.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function a2.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return 200
end
a2 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a2
)
g.modifier_sect_attack_14_buff = a2
g.modifier_sect_attack_effect_buff = c()
local a3 = g.modifier_sect_attack_effect_buff
a3.name = "modifier_sect_attack_effect_buff"
d(a3, l)
function a3.prototype.GetAbilitySpecialValue(self)
	self.effect_value = self:GetCustomAbilityValueFor("sect_attack_effect", "value")
	self.effect_max_value = self:GetCustomAbilityValueFor("sect_attack_effect", "max_value")
end
function a3.prototype.OnCreated(self, D)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(0)
		self.tData = {}
		local a4 = self.tData
		a4[#a4 + 1] = self:GetDieTime()
	end
end
function a3.prototype.OnRefresh(self, a5)
	if IsServer() then
		self:IncrementStackCount()
		local a6 = self.tData
		a6[#a6 + 1] = self:GetDieTime()
	end
end
function a3.prototype.OnIntervalThink(self)
	local a7 = GameRules:GetGameTime()
	for a8 = #self.tData, 1, -1 do
		if self.tData[a8] <= a7 then
			self:DecrementStackCount()
			table.remove(self.tData, a8)
		end
	end
end
function a3.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function a3.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return math.min(self.effect_max_value, self.effect_value * self:GetStackCount())
end
a3 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a3
)
g.modifier_sect_attack_effect_buff = a3
local a9 = c()
a9.name = "modifier_sect_attack_attribute"
d(a9, l)
function a9.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attackdamage = self:GetAbilitySpecialValueFor("attackdamage")
	local aa = GetSectAttackOriginalGainPercentage(self:GetParent())
	self.attackspeed = self.attackspeed * (1 + aa * 0.01)
	self.attackdamage = self.attackdamage * (1 + aa * 0.01)
	self.n_4_attack = self:GetSectSpecialValueFor("4", "n_4_attack")
	self.n_11_duration = self:GetSectSpecialValueFor("11", "n_11_duration")
	self.sr_152_attack_pct = self:GetSectSpecialValueFor("152", "sr_152_attack_pct")
end
function a9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self.caster } }
end
function a9.prototype.OnCritical(self, D)
	if self.n_11_duration > 0 then
		self.parent:AddNewModifier(
			self.parent,
			self:GetAbility(),
			"modifier_sect_crit_11_buff",
			{ duration = self.n_11_duration }
		)
	end
end
function a9.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function a9.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self.attackspeed
end
function a9.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, D)
	return self.attackdamage + self.sr_152_attack_pct
end
function a9.prototype.EOM_GetModifierAttackDamageBase(self)
	return GetSectAttackModifiedValue(self.caster, self.n_4_attack)
end
a9 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a9
)
g.modifier_sect_crit_11_buff = c()
local ab = g.modifier_sect_crit_11_buff
ab.name = "modifier_sect_crit_11_buff"
d(ab, l)
function ab.prototype.GetAbilitySpecialValue(self)
	self.n_11_attack = self:GetSectSpecialValueFor("11", "n_11_attack")
	self.n_11_max_attack = self:GetSectSpecialValueFor("11", "n_11_max_attack")
end
function ab.prototype.OnCreated(self, D)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(0)
		self.tData = {}
		local ac = self.tData
		ac[#ac + 1] = self:GetDieTime()
	end
end
function ab.prototype.OnRefresh(self, a5)
	if IsServer() then
		self:IncrementStackCount()
		local ad = self.tData
		ad[#ad + 1] = self:GetDieTime()
	end
end
function ab.prototype.OnIntervalThink(self)
	local a7 = GameRules:GetGameTime()
	for a8 = #self.tData, 1, -1 do
		if self.tData[a8] <= a7 then
			self:DecrementStackCount()
			table.remove(self.tData, a8)
		end
	end
end
function ab.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function ab.prototype.EOM_GetModifierAttackDamageBonus(self)
	return GetSectAttackModifiedValue(
		self:GetCaster(),
		math.min(self.n_11_max_attack, self.n_11_attack * self:GetStackCount())
	)
end
ab = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	ab
)
g.modifier_sect_crit_11_buff = ab
return g