--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["22"] = 44,
		["23"] = 4,
		["24"] = 51,
		["25"] = 52,
		["26"] = 53,
		["27"] = 54,
		["28"] = 55,
		["29"] = 56,
		["30"] = 57,
		["31"] = 58,
		["32"] = 59,
		["33"] = 60,
		["34"] = 61,
		["35"] = 62,
		["36"] = 63,
		["37"] = 64,
		["38"] = 65,
		["39"] = 68,
		["40"] = 69,
		["41"] = 70,
		["42"] = 73,
		["43"] = 74,
		["44"] = 75,
		["45"] = 77,
		["46"] = 78,
		["47"] = 79,
		["48"] = 80,
		["49"] = 51,
		["50"] = 82,
		["51"] = 83,
		["52"] = 82,
		["53"] = 85,
		["54"] = 85,
		["55"] = 85,
		["57"] = 86,
		["58"] = 87,
		["62"] = 90,
		["63"] = 111,
		["64"] = 91,
		["66"] = 92,
		["67"] = 92,
		["68"] = 92,
		["69"] = 92,
		["70"] = 92,
		["71"] = 92,
		["74"] = 94,
		["76"] = 95,
		["77"] = 95,
		["78"] = 95,
		["79"] = 95,
		["80"] = 95,
		["81"] = 95,
		["82"] = 95,
		["85"] = 97,
		["87"] = 98,
		["88"] = 98,
		["89"] = 98,
		["90"] = 98,
		["93"] = 100,
		["95"] = 101,
		["96"] = 101,
		["97"] = 101,
		["98"] = 101,
		["99"] = 101,
		["100"] = 101,
		["101"] = 101,
		["104"] = 103,
		["106"] = 104,
		["107"] = 104,
		["108"] = 104,
		["109"] = 104,
		["110"] = 104,
		["111"] = 104,
		["114"] = 106,
		["116"] = 107,
		["117"] = 107,
		["118"] = 107,
		["119"] = 107,
		["120"] = 107,
		["121"] = 107,
		["122"] = 107,
		["125"] = 109,
		["127"] = 110,
		["128"] = 111,
		["129"] = 112,
		["130"] = 113,
		["131"] = 113,
		["132"] = 113,
		["133"] = 113,
		["134"] = 113,
		["135"] = 118,
		["136"] = 119,
		["137"] = 120,
		["138"] = 120,
		["139"] = 120,
		["140"] = 120,
		["141"] = 120,
		["142"] = 120,
		["143"] = 120,
		["144"] = 120,
		["145"] = 120,
		["146"] = 120,
		["148"] = 113,
		["149"] = 113,
		["151"] = 130,
		["152"] = 130,
		["153"] = 130,
		["154"] = 130,
		["155"] = 130,
		["156"] = 130,
		["157"] = 130,
		["158"] = 130,
		["159"] = 130,
		["160"] = 130,
		["164"] = 138,
		["167"] = 140,
		["168"] = 141,
		["169"] = 142,
		["170"] = 143,
		["171"] = 144,
		["177"] = 149,
		["180"] = 151,
		["181"] = 152,
		["182"] = 153,
		["183"] = 154,
		["184"] = 155,
		["190"] = 160,
		["193"] = 162,
		["194"] = 163,
		["195"] = 164,
		["196"] = 165,
		["197"] = 165,
		["198"] = 165,
		["199"] = 165,
		["200"] = 165,
		["201"] = 170,
		["202"] = 171,
		["203"] = 172,
		["204"] = 172,
		["205"] = 172,
		["206"] = 172,
		["207"] = 172,
		["208"] = 172,
		["209"] = 172,
		["210"] = 172,
		["211"] = 172,
		["212"] = 172,
		["214"] = 165,
		["215"] = 165,
		["217"] = 182,
		["218"] = 182,
		["219"] = 182,
		["220"] = 182,
		["221"] = 182,
		["222"] = 182,
		["223"] = 182,
		["224"] = 182,
		["225"] = 182,
		["226"] = 182,
		["228"] = 189,
		["229"] = 190,
		["230"] = 190,
		["231"] = 190,
		["232"] = 190,
		["233"] = 190,
		["234"] = 190,
		["235"] = 190,
		["236"] = 190,
		["237"] = 190,
		["238"] = 191,
		["239"] = 191,
		["240"] = 191,
		["241"] = 191,
		["242"] = 191,
		["243"] = 192,
		["248"] = 196,
		["250"] = 197,
		["251"] = 197,
		["252"] = 197,
		["253"] = 197,
		["254"] = 197,
		["255"] = 197,
		["258"] = 199,
		["260"] = 200,
		["261"] = 200,
		["262"] = 200,
		["263"] = 200,
		["264"] = 200,
		["265"] = 200,
		["266"] = 200,
		["267"] = 200,
		["268"] = 200,
		["272"] = 85,
		["273"] = 206,
		["274"] = 207,
		["275"] = 206,
		["276"] = 5,
		["277"] = 4,
		["278"] = 5,
		["280"] = 5,
		["281"] = 211,
		["282"] = 218,
		["283"] = 211,
		["284"] = 218,
		["286"] = 218,
		["287"] = 220,
		["288"] = 229,
		["289"] = 262,
		["290"] = 211,
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
		["318"] = 297,
		["319"] = 298,
		["320"] = 299,
		["321"] = 300,
		["322"] = 301,
		["323"] = 302,
		["324"] = 269,
		["325"] = 304,
		["326"] = 305,
		["327"] = 306,
		["328"] = 307,
		["329"] = 308,
		["332"] = 311,
		["333"] = 312,
		["334"] = 313,
		["336"] = 304,
		["337"] = 317,
		["338"] = 318,
		["339"] = 318,
		["340"] = 321,
		["341"] = 321,
		["342"] = 321,
		["343"] = 318,
		["344"] = 318,
		["345"] = 323,
		["346"] = 323,
		["347"] = 323,
		["348"] = 318,
		["349"] = 318,
		["350"] = 317,
		["351"] = 326,
		["352"] = 327,
		["353"] = 328,
		["354"] = 329,
		["355"] = 330,
		["356"] = 331,
		["357"] = 333,
		["358"] = 334,
		["359"] = 335,
		["360"] = 336,
		["363"] = 339,
		["366"] = 342,
		["367"] = 326,
		["368"] = 344,
		["369"] = 345,
		["370"] = 346,
		["372"] = 344,
		["373"] = 349,
		["374"] = 350,
		["375"] = 351,
		["376"] = 352,
		["377"] = 353,
		["381"] = 357,
		["382"] = 358,
		["383"] = 360,
		["384"] = 361,
		["386"] = 364,
		["388"] = 349,
		["389"] = 367,
		["390"] = 368,
		["391"] = 369,
		["392"] = 370,
		["393"] = 371,
		["394"] = 372,
		["399"] = 377,
		["400"] = 378,
		["401"] = 379,
		["402"] = 379,
		["403"] = 379,
		["404"] = 379,
		["405"] = 380,
		["406"] = 381,
		["408"] = 367,
		["409"] = 414,
		["410"] = 415,
		["411"] = 414,
		["412"] = 419,
		["413"] = 420,
		["414"] = 419,
		["415"] = 423,
		["416"] = 425,
		["419"] = 429,
		["420"] = 430,
		["421"] = 431,
		["422"] = 431,
		["423"] = 431,
		["424"] = 431,
		["425"] = 431,
		["426"] = 431,
		["427"] = 434,
		["428"] = 435,
		["430"] = 423,
		["431"] = 440,
		["432"] = 441,
		["433"] = 442,
		["435"] = 440,
		["436"] = 446,
		["437"] = 447,
		["438"] = 448,
		["440"] = 450,
		["441"] = 451,
		["442"] = 452,
		["443"] = 454,
		["444"] = 455,
		["446"] = 458,
		["447"] = 459,
		["449"] = 462,
		["450"] = 463,
		["452"] = 466,
		["453"] = 467,
		["455"] = 470,
		["456"] = 471,
		["457"] = 446,
		["458"] = 473,
		["459"] = 474,
		["460"] = 475,
		["461"] = 476,
		["462"] = 477,
		["467"] = 482,
		["468"] = 483,
		["469"] = 484,
		["470"] = 485,
		["471"] = 486,
		["472"] = 487,
		["475"] = 473,
		["476"] = 491,
		["477"] = 492,
		["478"] = 493,
		["479"] = 494,
		["480"] = 496,
		["481"] = 497,
		["482"] = 498,
		["483"] = 499,
		["484"] = 500,
		["486"] = 502,
		["488"] = 504,
		["489"] = 505,
		["490"] = 507,
		["493"] = 511,
		["494"] = 512,
		["495"] = 513,
		["496"] = 514,
		["497"] = 515,
		["499"] = 517,
		["501"] = 519,
		["502"] = 520,
		["503"] = 522,
		["506"] = 526,
		["507"] = 527,
		["508"] = 528,
		["509"] = 529,
		["510"] = 530,
		["512"] = 532,
		["514"] = 534,
		["515"] = 535,
		["516"] = 536,
		["519"] = 540,
		["520"] = 541,
		["521"] = 542,
		["522"] = 543,
		["523"] = 544,
		["525"] = 546,
		["527"] = 548,
		["528"] = 549,
		["529"] = 551,
		["532"] = 555,
		["533"] = 556,
		["534"] = 557,
		["535"] = 558,
		["536"] = 559,
		["538"] = 561,
		["540"] = 563,
		["541"] = 564,
		["542"] = 565,
		["545"] = 568,
		["546"] = 570,
		["547"] = 571,
		["548"] = 572,
		["549"] = 573,
		["550"] = 574,
		["552"] = 576,
		["554"] = 578,
		["555"] = 579,
		["556"] = 581,
		["559"] = 585,
		["560"] = 586,
		["561"] = 587,
		["562"] = 588,
		["563"] = 589,
		["565"] = 591,
		["567"] = 593,
		["568"] = 594,
		["569"] = 596,
		["572"] = 600,
		["573"] = 601,
		["574"] = 602,
		["575"] = 603,
		["576"] = 604,
		["578"] = 606,
		["580"] = 608,
		["581"] = 609,
		["582"] = 611,
		["586"] = 491,
		["587"] = 617,
		["588"] = 618,
		["591"] = 621,
		["594"] = 625,
		["595"] = 626,
		["596"] = 627,
		["598"] = 627,
		["602"] = 617,
		["603"] = 631,
		["604"] = 632,
		["605"] = 633,
		["606"] = 633,
		["607"] = 633,
		["608"] = 633,
		["609"] = 633,
		["610"] = 633,
		["611"] = 631,
		["612"] = 218,
		["613"] = 211,
		["614"] = 211,
		["615"] = 211,
		["616"] = 211,
		["617"] = 211,
		["618"] = 211,
		["619"] = 211,
		["620"] = 218,
		["622"] = 218,
		["623"] = 637,
		["624"] = 649,
		["625"] = 637,
		["626"] = 649,
		["628"] = 649,
		["629"] = 652,
		["630"] = 637,
		["631"] = 653,
		["632"] = 654,
		["633"] = 653,
		["634"] = 656,
		["635"] = 657,
		["636"] = 658,
		["637"] = 659,
		["638"] = 660,
		["639"] = 661,
		["640"] = 662,
		["641"] = 663,
		["642"] = 663,
		["643"] = 663,
		["644"] = 663,
		["645"] = 663,
		["647"] = 665,
		["648"] = 666,
		["649"] = 667,
		["650"] = 668,
		["651"] = 668,
		["652"] = 668,
		["653"] = 668,
		["654"] = 668,
		["655"] = 668,
		["656"] = 668,
		["657"] = 668,
		["658"] = 668,
		["659"] = 669,
		["661"] = 656,
		["662"] = 672,
		["663"] = 673,
		["664"] = 674,
		["665"] = 675,
		["666"] = 676,
		["669"] = 679,
		["670"] = 680,
		["672"] = 672,
		["673"] = 683,
		["674"] = 684,
		["675"] = 685,
		["676"] = 685,
		["677"] = 684,
		["678"] = 683,
		["679"] = 688,
		["680"] = 689,
		["681"] = 688,
		["682"] = 691,
		["683"] = 692,
		["684"] = 691,
		["685"] = 696,
		["686"] = 697,
		["687"] = 696,
		["688"] = 649,
		["689"] = 637,
		["690"] = 637,
		["691"] = 637,
		["692"] = 637,
		["693"] = 637,
		["694"] = 637,
		["695"] = 637,
		["696"] = 637,
		["697"] = 637,
		["698"] = 637,
		["699"] = 637,
		["700"] = 649,
		["702"] = 649,
		["703"] = 704,
		["704"] = 716,
		["705"] = 704,
		["706"] = 716,
		["707"] = 723,
		["708"] = 724,
		["709"] = 725,
		["710"] = 726,
		["711"] = 727,
		["712"] = 728,
		["713"] = 723,
		["714"] = 730,
		["715"] = 731,
		["716"] = 732,
		["717"] = 732,
		["718"] = 731,
		["719"] = 730,
		["720"] = 735,
		["721"] = 736,
		["722"] = 735,
		["723"] = 741,
		["724"] = 742,
		["725"] = 741,
		["726"] = 744,
		["727"] = 745,
		["728"] = 746,
		["730"] = 748,
		["731"] = 744,
		["732"] = 750,
		["733"] = 751,
		["734"] = 752,
		["735"] = 753,
		["736"] = 753,
		["737"] = 753,
		["738"] = 753,
		["739"] = 753,
		["740"] = 753,
		["742"] = 750,
		["743"] = 716,
		["744"] = 704,
		["745"] = 704,
		["746"] = 704,
		["747"] = 704,
		["748"] = 704,
		["749"] = 704,
		["750"] = 704,
		["751"] = 716,
		["753"] = 716,
		["754"] = 759,
		["755"] = 770,
		["756"] = 759,
		["757"] = 770,
		["758"] = 772,
		["759"] = 773,
		["760"] = 772,
		["761"] = 775,
		["762"] = 776,
		["763"] = 777,
		["765"] = 775,
		["766"] = 780,
		["767"] = 781,
		["768"] = 780,
		["769"] = 770,
		["770"] = 759,
		["771"] = 759,
		["772"] = 759,
		["773"] = 759,
		["774"] = 759,
		["775"] = 759,
		["776"] = 759,
		["777"] = 759,
		["778"] = 759,
		["779"] = 759,
		["780"] = 759,
		["781"] = 770,
		["783"] = 770,
		["784"] = 788,
		["785"] = 796,
		["786"] = 788,
		["787"] = 796,
		["788"] = 799,
		["789"] = 800,
		["790"] = 801,
		["791"] = 799,
		["792"] = 803,
		["793"] = 804,
		["794"] = 805,
		["796"] = 803,
		["797"] = 808,
		["798"] = 809,
		["799"] = 808,
		["800"] = 813,
		["801"] = 814,
		["802"] = 814,
		["803"] = 814,
		["804"] = 814,
		["805"] = 813,
		["806"] = 796,
		["807"] = 788,
		["808"] = 788,
		["809"] = 788,
		["810"] = 788,
		["811"] = 788,
		["812"] = 788,
		["813"] = 788,
		["814"] = 796,
		["816"] = 796,
		["818"] = 820,
		["819"] = 828,
		["820"] = 820,
		["821"] = 828,
		["822"] = 830,
		["823"] = 831,
		["824"] = 830,
		["825"] = 833,
		["826"] = 834,
		["827"] = 833,
		["828"] = 838,
		["829"] = 839,
		["830"] = 840,
		["832"] = 838,
		["833"] = 828,
		["834"] = 820,
		["835"] = 820,
		["836"] = 820,
		["837"] = 820,
		["838"] = 820,
		["839"] = 820,
		["840"] = 820,
		["841"] = 828,
		["843"] = 828,
		["845"] = 849,
		["846"] = 857,
		["847"] = 849,
		["848"] = 857,
		["849"] = 859,
		["850"] = 860,
		["851"] = 859,
		["852"] = 862,
		["853"] = 863,
		["854"] = 862,
		["855"] = 867,
		["856"] = 868,
		["857"] = 867,
		["858"] = 857,
		["859"] = 849,
		["860"] = 849,
		["861"] = 849,
		["862"] = 849,
		["863"] = 849,
		["864"] = 849,
		["865"] = 849,
		["866"] = 857,
		["868"] = 857,
		["870"] = 896,
		["871"] = 904,
		["872"] = 896,
		["873"] = 904,
		["874"] = 908,
		["875"] = 909,
		["876"] = 910,
		["877"] = 911,
		["878"] = 908,
		["879"] = 913,
		["880"] = 914,
		["881"] = 913,
		["882"] = 916,
		["883"] = 917,
		["884"] = 918,
		["886"] = 916,
		["887"] = 921,
		["888"] = 922,
		["889"] = 921,
		["890"] = 926,
		["891"] = 927,
		["892"] = 928,
		["893"] = 926,
		["894"] = 904,
		["895"] = 896,
		["896"] = 896,
		["897"] = 896,
		["898"] = 896,
		["899"] = 896,
		["900"] = 896,
		["901"] = 896,
		["902"] = 904,
		["904"] = 904,
		["906"] = 932,
		["907"] = 940,
		["908"] = 932,
		["909"] = 940,
		["911"] = 940,
		["912"] = 943,
		["913"] = 932,
		["914"] = 944,
		["915"] = 945,
		["916"] = 946,
		["917"] = 944,
		["918"] = 948,
		["919"] = 949,
		["920"] = 950,
		["922"] = 948,
		["923"] = 953,
		["924"] = 954,
		["925"] = 953,
		["926"] = 958,
		["927"] = 959,
		["930"] = 962,
		["931"] = 958,
		["932"] = 964,
		["933"] = 965,
		["934"] = 966,
		["936"] = 964,
		["937"] = 969,
		["938"] = 970,
		["939"] = 969,
		["940"] = 978,
		["941"] = 979,
		["942"] = 979,
		["943"] = 979,
		["944"] = 979,
		["945"] = 978,
		["946"] = 940,
		["947"] = 932,
		["948"] = 932,
		["949"] = 932,
		["950"] = 932,
		["951"] = 932,
		["952"] = 932,
		["953"] = 932,
		["954"] = 940,
		["956"] = 940,
		["958"] = 984,
		["959"] = 992,
		["960"] = 984,
		["961"] = 992,
		["963"] = 992,
		["964"] = 998,
		["965"] = 984,
		["966"] = 999,
		["967"] = 1000,
		["968"] = 1001,
		["969"] = 1002,
		["970"] = 1003,
		["971"] = 1005,
		["972"] = 999,
		["973"] = 1007,
		["974"] = 1008,
		["975"] = 1009,
		["977"] = 1007,
		["978"] = 1012,
		["979"] = 1013,
		["980"] = 1014,
		["981"] = 1014,
		["982"] = 1013,
		["983"] = 1016,
		["984"] = 1017,
		["985"] = 1017,
		["986"] = 1017,
		["987"] = 1018,
		["988"] = 1018,
		["989"] = 1017,
		["990"] = 1017,
		["992"] = 1021,
		["993"] = 1012,
		["994"] = 1023,
		["995"] = 1024,
		["998"] = 1027,
		["999"] = 1023,
		["1000"] = 1029,
		["1001"] = 1030,
		["1002"] = 1031,
		["1004"] = 1029,
		["1005"] = 1034,
		["1006"] = 1035,
		["1009"] = 1038,
		["1010"] = 1039,
		["1011"] = 1040,
		["1012"] = 1041,
		["1013"] = 1041,
		["1014"] = 1041,
		["1015"] = 1041,
		["1016"] = 1041,
		["1017"] = 1041,
		["1018"] = 1041,
		["1019"] = 1041,
		["1022"] = 1034,
		["1023"] = 1058,
		["1024"] = 1059,
		["1025"] = 1058,
		["1026"] = 1063,
		["1027"] = 1064,
		["1028"] = 1064,
		["1029"] = 1064,
		["1030"] = 1064,
		["1031"] = 1063,
		["1032"] = 992,
		["1033"] = 984,
		["1034"] = 984,
		["1035"] = 984,
		["1036"] = 984,
		["1037"] = 984,
		["1038"] = 984,
		["1039"] = 984,
		["1040"] = 992,
		["1042"] = 992,
		["1044"] = 1069,
		["1045"] = 1077,
		["1046"] = 1069,
		["1047"] = 1077,
		["1048"] = 1078,
		["1049"] = 1079,
		["1050"] = 1080,
		["1051"] = 1080,
		["1052"] = 1079,
		["1053"] = 1078,
		["1054"] = 1083,
		["1055"] = 1084,
		["1056"] = 1083,
		["1057"] = 1087,
		["1058"] = 1088,
		["1059"] = 1087,
		["1060"] = 1092,
		["1061"] = 1093,
		["1062"] = 1092,
		["1063"] = 1077,
		["1064"] = 1069,
		["1065"] = 1069,
		["1066"] = 1069,
		["1067"] = 1069,
		["1068"] = 1069,
		["1069"] = 1069,
		["1070"] = 1069,
		["1071"] = 1077,
		["1073"] = 1077,
		["1075"] = 1098,
		["1076"] = 1106,
		["1077"] = 1098,
		["1078"] = 1106,
		["1079"] = 1110,
		["1080"] = 1111,
		["1081"] = 1112,
		["1082"] = 1110,
		["1083"] = 1114,
		["1084"] = 1115,
		["1085"] = 1116,
		["1086"] = 1117,
		["1087"] = 1118,
		["1088"] = 1119,
		["1089"] = 1119,
		["1091"] = 1114,
		["1092"] = 1122,
		["1093"] = 1123,
		["1094"] = 1124,
		["1095"] = 1125,
		["1096"] = 1125,
		["1098"] = 1122,
		["1099"] = 1128,
		["1100"] = 1129,
		["1101"] = 1130,
		["1102"] = 1131,
		["1103"] = 1132,
		["1104"] = 1133,
		["1107"] = 1128,
		["1108"] = 1137,
		["1109"] = 1138,
		["1110"] = 1137,
		["1111"] = 1142,
		["1112"] = 1143,
		["1113"] = 1143,
		["1114"] = 1143,
		["1115"] = 1143,
		["1116"] = 1142,
		["1117"] = 1106,
		["1118"] = 1098,
		["1119"] = 1098,
		["1120"] = 1098,
		["1121"] = 1098,
		["1122"] = 1098,
		["1123"] = 1098,
		["1124"] = 1098,
		["1125"] = 1106,
		["1127"] = 1106,
		["1129"] = 1148,
		["1130"] = 1148,
		["1131"] = 1155,
		["1132"] = 1162,
		["1133"] = 1163,
		["1134"] = 1164,
		["1135"] = 1165,
		["1136"] = 1166,
		["1137"] = 1167,
		["1138"] = 1169,
		["1139"] = 1170,
		["1140"] = 1171,
		["1141"] = 1162,
		["1142"] = 1173,
		["1143"] = 1174,
		["1144"] = 1173,
		["1145"] = 1178,
		["1146"] = 1180,
		["1147"] = 1181,
		["1148"] = 1181,
		["1149"] = 1181,
		["1150"] = 1181,
		["1151"] = 1181,
		["1152"] = 1181,
		["1154"] = 1178,
		["1155"] = 1184,
		["1156"] = 1185,
		["1157"] = 1184,
		["1158"] = 1191,
		["1159"] = 1192,
		["1160"] = 1191,
		["1161"] = 1194,
		["1162"] = 1195,
		["1163"] = 1194,
		["1164"] = 1197,
		["1165"] = 1198,
		["1166"] = 1197,
		["1167"] = 1155,
		["1168"] = 1148,
		["1169"] = 1148,
		["1170"] = 1148,
		["1171"] = 1148,
		["1172"] = 1148,
		["1173"] = 1148,
		["1174"] = 1148,
		["1175"] = 1155,
		["1178"] = 1204,
		["1179"] = 1212,
		["1180"] = 1204,
		["1181"] = 1212,
		["1182"] = 1216,
		["1183"] = 1217,
		["1184"] = 1218,
		["1185"] = 1216,
		["1186"] = 1220,
		["1187"] = 1221,
		["1188"] = 1222,
		["1189"] = 1223,
		["1190"] = 1224,
		["1191"] = 1225,
		["1192"] = 1225,
		["1194"] = 1220,
		["1195"] = 1228,
		["1196"] = 1229,
		["1197"] = 1230,
		["1198"] = 1231,
		["1199"] = 1231,
		["1201"] = 1228,
		["1202"] = 1234,
		["1203"] = 1235,
		["1204"] = 1236,
		["1205"] = 1237,
		["1206"] = 1238,
		["1207"] = 1239,
		["1210"] = 1234,
		["1211"] = 1243,
		["1212"] = 1244,
		["1213"] = 1243,
		["1214"] = 1248,
		["1215"] = 1249,
		["1216"] = 1249,
		["1217"] = 1249,
		["1218"] = 1249,
		["1219"] = 1249,
		["1220"] = 1249,
		["1221"] = 1249,
		["1222"] = 1248,
		["1223"] = 1212,
		["1224"] = 1204,
		["1225"] = 1204,
		["1226"] = 1204,
		["1227"] = 1204,
		["1228"] = 1204,
		["1229"] = 1204,
		["1230"] = 1204,
		["1231"] = 1212,
		["1233"] = 1212,
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
	self.r_15_interval = self:GetSectSpecialValueFor("15", "r_15_interval")
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
	self.r_15_interval = self:GetSectSpecialValueFor("15", "r_15_interval")
	self.sr_16_chance = self:GetSectSpecialValueFor("16", "sr_16_chance")
	self.sr_16_cooldown = self:GetSectSpecialValueFor("16", "sr_16_cooldown")
	self.n_122_chance = self:GetSectSpecialValueFor("122", "n_122_chance")
	self.n_122_fury = self:GetSectSpecialValueFor("122", "n_122_fury")
	self.sr_152_duration = self:GetSectSpecialValueFor("152", "sr_152_duration")
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
	if self.r_15_interval > 0 then
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
function W.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function W.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, D)
	return -self.n_5_reduce_damage
end
W = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
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
	self.r_13_max = self:GetSectSpecialValueFor("13", "r_13_max")
end
function Z.prototype.OnCreated(self, D)
	if IsServer() then
		self.isInherit = self:GetParent() ~= self.caster
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
	if self:GetStackCount() < self.r_13_max then
		self:IncrementStackCount(self.r_13_attack)
	end
end
function Z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function Z.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, D)
	return GetSectAttackModifiedValue(self:GetCaster(), self:GetStackCount())
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
	self.r_15_interval = self:GetSectSpecialValueFor("15", "r_15_interval")
	self.r_15_attackspeed = self:GetSectSpecialValueFor("15", "r_15_attackspeed")
	self.r_15_max = self:GetSectSpecialValueFor("15", "r_15_max")
	self.max_stack = Round(self.r_15_max / self.r_15_attackspeed)
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
	if self:GetStackCount() < self.max_stack then
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