--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/abyssal_underlord"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayForEach
local h = b.__TS__New
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 458,
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 6,
		["22"] = 7,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 9,
		["27"] = 8,
		["28"] = 7,
		["29"] = 6,
		["30"] = 7,
		["32"] = 7,
		["33"] = 13,
		["34"] = 21,
		["35"] = 13,
		["36"] = 21,
		["38"] = 21,
		["39"] = 24,
		["40"] = 25,
		["41"] = 39,
		["42"] = 58,
		["43"] = 59,
		["44"] = 13,
		["45"] = 63,
		["46"] = 64,
		["47"] = 65,
		["48"] = 66,
		["49"] = 67,
		["50"] = 69,
		["51"] = 70,
		["52"] = 72,
		["53"] = 73,
		["54"] = 74,
		["55"] = 75,
		["56"] = 77,
		["57"] = 78,
		["58"] = 79,
		["59"] = 80,
		["60"] = 82,
		["61"] = 83,
		["62"] = 84,
		["63"] = 85,
		["64"] = 86,
		["65"] = 88,
		["66"] = 89,
		["67"] = 63,
		["68"] = 91,
		["69"] = 92,
		["70"] = 92,
		["71"] = 94,
		["72"] = 94,
		["73"] = 94,
		["74"] = 92,
		["75"] = 95,
		["76"] = 95,
		["77"] = 95,
		["78"] = 92,
		["79"] = 96,
		["80"] = 96,
		["81"] = 96,
		["82"] = 92,
		["83"] = 92,
		["84"] = 91,
		["85"] = 99,
		["86"] = 100,
		["87"] = 101,
		["88"] = 102,
		["89"] = 103,
		["90"] = 103,
		["91"] = 103,
		["92"] = 103,
		["93"] = 103,
		["94"] = 103,
		["97"] = 99,
		["98"] = 107,
		["99"] = 108,
		["100"] = 109,
		["101"] = 110,
		["102"] = 111,
		["104"] = 113,
		["107"] = 107,
		["108"] = 117,
		["109"] = 118,
		["110"] = 118,
		["111"] = 118,
		["112"] = 118,
		["113"] = 118,
		["114"] = 118,
		["116"] = 118,
		["117"] = 119,
		["118"] = 120,
		["119"] = 121,
		["120"] = 121,
		["121"] = 121,
		["122"] = 121,
		["123"] = 121,
		["124"] = 121,
		["125"] = 123,
		["126"] = 124,
		["127"] = 125,
		["129"] = 127,
		["132"] = 130,
		["133"] = 131,
		["134"] = 132,
		["136"] = 135,
		["137"] = 136,
		["138"] = 137,
		["139"] = 138,
		["140"] = 139,
		["141"] = 140,
		["142"] = 140,
		["143"] = 140,
		["144"] = 140,
		["145"] = 141,
		["146"] = 141,
		["147"] = 141,
		["148"] = 141,
		["149"] = 141,
		["150"] = 141,
		["151"] = 141,
		["152"] = 141,
		["153"] = 142,
		["154"] = 143,
		["155"] = 144,
		["156"] = 144,
		["157"] = 144,
		["158"] = 144,
		["159"] = 144,
		["160"] = 144,
		["161"] = 144,
		["162"] = 144,
		["163"] = 144,
		["164"] = 145,
		["165"] = 145,
		["166"] = 145,
		["167"] = 145,
		["168"] = 145,
		["169"] = 146,
		["170"] = 147,
		["171"] = 148,
		["173"] = 150,
		["175"] = 152,
		["177"] = 117,
		["178"] = 155,
		["179"] = 156,
		["180"] = 157,
		["183"] = 160,
		["185"] = 162,
		["186"] = 163,
		["187"] = 165,
		["188"] = 165,
		["189"] = 165,
		["190"] = 165,
		["191"] = 166,
		["192"] = 167,
		["193"] = 167,
		["194"] = 167,
		["195"] = 167,
		["196"] = 168,
		["197"] = 170,
		["198"] = 171,
		["199"] = 172,
		["200"] = 173,
		["202"] = 175,
		["203"] = 176,
		["205"] = 178,
		["206"] = 155,
		["207"] = 181,
		["208"] = 182,
		["209"] = 183,
		["210"] = 184,
		["211"] = 185,
		["212"] = 186,
		["213"] = 186,
		["214"] = 186,
		["215"] = 186,
		["216"] = 186,
		["217"] = 186,
		["218"] = 187,
		["219"] = 188,
		["222"] = 181,
		["223"] = 194,
		["224"] = 194,
		["225"] = 206,
		["226"] = 207,
		["227"] = 208,
		["228"] = 209,
		["229"] = 209,
		["230"] = 209,
		["231"] = 209,
		["232"] = 209,
		["233"] = 209,
		["235"] = 209,
		["236"] = 210,
		["237"] = 210,
		["238"] = 210,
		["239"] = 210,
		["240"] = 210,
		["241"] = 213,
		["242"] = 213,
		["243"] = 213,
		["244"] = 213,
		["245"] = 213,
		["246"] = 213,
		["247"] = 213,
		["248"] = 206,
		["249"] = 216,
		["250"] = 217,
		["251"] = 216,
		["252"] = 222,
		["253"] = 223,
		["254"] = 222,
		["255"] = 225,
		["256"] = 226,
		["257"] = 227,
		["259"] = 225,
		["260"] = 231,
		["261"] = 232,
		["262"] = 233,
		["265"] = 236,
		["266"] = 237,
		["269"] = 242,
		["270"] = 243,
		["271"] = 244,
		["273"] = 246,
		["274"] = 247,
		["275"] = 248,
		["276"] = 249,
		["277"] = 251,
		["278"] = 252,
		["279"] = 258,
		["280"] = 258,
		["281"] = 258,
		["282"] = 263,
		["285"] = 266,
		["286"] = 267,
		["289"] = 278,
		["290"] = 279,
		["291"] = 280,
		["292"] = 281,
		["293"] = 281,
		["294"] = 281,
		["295"] = 281,
		["296"] = 281,
		["297"] = 281,
		["298"] = 281,
		["299"] = 281,
		["300"] = 281,
		["301"] = 281,
		["302"] = 281,
		["303"] = 281,
		["304"] = 281,
		["305"] = 281,
		["306"] = 281,
		["307"] = 281,
		["308"] = 281,
		["309"] = 295,
		["310"] = 295,
		["312"] = 297,
		["313"] = 297,
		["314"] = 297,
		["315"] = 297,
		["316"] = 297,
		["317"] = 297,
		["318"] = 297,
		["319"] = 297,
		["320"] = 297,
		["321"] = 297,
		["322"] = 297,
		["323"] = 297,
		["324"] = 297,
		["325"] = 297,
		["326"] = 297,
		["327"] = 297,
		["328"] = 297,
		["329"] = 297,
		["330"] = 312,
		["331"] = 312,
		["333"] = 258,
		["334"] = 258,
		["335"] = 231,
		["336"] = 317,
		["337"] = 318,
		["338"] = 317,
		["339"] = 321,
		["340"] = 322,
		["341"] = 321,
		["342"] = 325,
		["343"] = 326,
		["344"] = 327,
		["345"] = 328,
		["346"] = 329,
		["348"] = 331,
		["349"] = 332,
		["351"] = 325,
		["352"] = 21,
		["353"] = 13,
		["354"] = 13,
		["355"] = 13,
		["356"] = 13,
		["357"] = 13,
		["358"] = 13,
		["359"] = 13,
		["360"] = 13,
		["361"] = 21,
		["363"] = 21,
		["364"] = 337,
		["365"] = 346,
		["366"] = 337,
		["367"] = 346,
		["368"] = 348,
		["369"] = 349,
		["370"] = 348,
		["371"] = 351,
		["372"] = 352,
		["373"] = 353,
		["374"] = 354,
		["376"] = 351,
		["377"] = 357,
		["378"] = 358,
		["379"] = 357,
		["380"] = 362,
		["381"] = 363,
		["382"] = 362,
		["383"] = 346,
		["384"] = 337,
		["385"] = 337,
		["386"] = 337,
		["387"] = 337,
		["388"] = 337,
		["389"] = 337,
		["390"] = 337,
		["391"] = 337,
		["392"] = 337,
		["393"] = 346,
		["395"] = 346,
		["396"] = 367,
		["397"] = 368,
		["398"] = 367,
		["399"] = 368,
		["400"] = 369,
		["401"] = 370,
		["402"] = 371,
		["403"] = 372,
		["404"] = 373,
		["405"] = 374,
		["406"] = 374,
		["407"] = 374,
		["408"] = 375,
		["409"] = 376,
		["411"] = 374,
		["412"] = 374,
		["414"] = 380,
		["415"] = 381,
		["416"] = 382,
		["417"] = 382,
		["418"] = 382,
		["419"] = 382,
		["422"] = 369,
		["423"] = 368,
		["424"] = 367,
		["425"] = 368,
		["427"] = 368,
		["428"] = 388,
		["429"] = 396,
		["430"] = 388,
		["431"] = 396,
		["432"] = 400,
		["433"] = 401,
		["434"] = 402,
		["435"] = 403,
		["436"] = 400,
		["437"] = 406,
		["438"] = 407,
		["439"] = 406,
		["440"] = 409,
		["441"] = 410,
		["442"] = 411,
		["443"] = 411,
		["444"] = 411,
		["445"] = 411,
		["446"] = 412,
		["447"] = 412,
		["448"] = 412,
		["449"] = 412,
		["450"] = 412,
		["451"] = 413,
		["452"] = 413,
		["453"] = 413,
		["454"] = 413,
		["455"] = 413,
		["456"] = 414,
		["457"] = 414,
		["458"] = 414,
		["459"] = 414,
		["460"] = 414,
		["461"] = 415,
		["462"] = 416,
		["463"] = 417,
		["466"] = 418,
		["467"] = 419,
		["470"] = 420,
		["471"] = 420,
		["472"] = 420,
		["473"] = 420,
		["474"] = 420,
		["475"] = 420,
		["476"] = 421,
		["477"] = 422,
		["478"] = 422,
		["479"] = 422,
		["480"] = 422,
		["481"] = 422,
		["482"] = 422,
		["485"] = 409,
		["486"] = 426,
		["487"] = 427,
		["488"] = 428,
		["489"] = 428,
		["490"] = 427,
		["491"] = 426,
		["492"] = 431,
		["493"] = 432,
		["494"] = 431,
		["495"] = 434,
		["496"] = 435,
		["497"] = 434,
		["498"] = 396,
		["499"] = 388,
		["500"] = 388,
		["501"] = 388,
		["502"] = 388,
		["503"] = 388,
		["504"] = 388,
		["505"] = 388,
		["506"] = 388,
		["507"] = 396,
		["509"] = 396,
		["510"] = 440,
		["513"] = 458,
		["514"] = 458,
		["515"] = 476,
		["516"] = 470,
		["517"] = 477,
		["518"] = 478,
		["519"] = 479,
		["520"] = 480,
		["521"] = 481,
		["522"] = 482,
		["523"] = 483,
		["524"] = 484,
		["525"] = 485,
		["526"] = 486,
		["527"] = 487,
		["528"] = 488,
		["529"] = 489,
		["530"] = 476,
		["531"] = 492,
		["532"] = 493,
		["535"] = 494,
		["536"] = 495,
		["537"] = 497,
		["538"] = 497,
		["539"] = 497,
		["540"] = 497,
		["541"] = 497,
		["542"] = 499,
		["543"] = 500,
		["544"] = 501,
		["545"] = 502,
		["546"] = 503,
		["548"] = 497,
		["549"] = 497,
		["550"] = 506,
		["551"] = 507,
		["554"] = 510,
		["555"] = 514,
		["556"] = 515,
		["557"] = 515,
		["558"] = 515,
		["559"] = 516,
		["562"] = 517,
		["563"] = 518,
		["564"] = 519,
		["565"] = 524,
		["566"] = 525,
		["567"] = 526,
		["568"] = 526,
		["571"] = 528,
		["572"] = 528,
		["574"] = 530,
		["575"] = 531,
		["576"] = 532,
		["577"] = 532,
		["580"] = 515,
		["581"] = 515,
		["582"] = 536,
		["583"] = 536,
		["584"] = 536,
		["585"] = 537,
		["588"] = 540,
		["589"] = 541,
		["590"] = 536,
		["591"] = 536,
		["592"] = 543,
		["593"] = 543,
		["594"] = 543,
		["595"] = 544,
		["596"] = 543,
		["597"] = 543,
		["598"] = 492,
		["599"] = 548,
		["600"] = 549,
		["603"] = 552,
		["606"] = 555,
		["609"] = 558,
		["610"] = 559,
		["611"] = 560,
		["613"] = 562,
		["614"] = 563,
		["615"] = 563,
		["616"] = 563,
		["617"] = 564,
		["620"] = 567,
		["623"] = 570,
		["624"] = 571,
		["625"] = 563,
		["626"] = 563,
		["627"] = 548,
		["628"] = 576,
		["629"] = 577,
		["632"] = 580,
		["633"] = 582,
		["634"] = 583,
		["635"] = 584,
		["636"] = 585,
		["637"] = 586,
		["639"] = 589,
		["640"] = 590,
		["641"] = 591,
		["643"] = 593,
		["644"] = 594,
		["645"] = 595,
		["647"] = 599,
		["648"] = 600,
		["649"] = 600,
		["650"] = 600,
		["651"] = 600,
		["652"] = 600,
		["653"] = 600,
		["654"] = 600,
		["655"] = 600,
		["656"] = 600,
		["657"] = 600,
		["658"] = 600,
		["659"] = 600,
		["660"] = 609,
		["661"] = 610,
		["662"] = 610,
		["663"] = 610,
		["664"] = 611,
		["665"] = 612,
		["667"] = 610,
		["668"] = 610,
		["669"] = 616,
		["670"] = 617,
		["672"] = 619,
		["673"] = 621,
		["674"] = 622,
		["676"] = 576,
		["677"] = 627,
		["678"] = 635,
		["679"] = 627,
		["680"] = 635,
		["681"] = 638,
		["682"] = 639,
		["683"] = 638,
		["684"] = 643,
		["685"] = 644,
		["686"] = 643,
		["687"] = 650,
		["688"] = 651,
		["689"] = 650,
		["690"] = 653,
		["691"] = 654,
		["692"] = 653,
		["693"] = 656,
		["694"] = 657,
		["695"] = 656,
		["696"] = 659,
		["697"] = 659,
		["698"] = 662,
		["699"] = 663,
		["702"] = 665,
		["703"] = 666,
		["704"] = 666,
		["705"] = 666,
		["706"] = 666,
		["707"] = 666,
		["708"] = 666,
		["709"] = 666,
		["710"] = 666,
		["711"] = 666,
		["712"] = 666,
		["713"] = 666,
		["714"] = 666,
		["715"] = 662,
		["716"] = 676,
		["717"] = 677,
		["720"] = 678,
		["721"] = 679,
		["723"] = 681,
		["724"] = 681,
		["725"] = 681,
		["726"] = 681,
		["727"] = 681,
		["728"] = 681,
		["729"] = 681,
		["730"] = 681,
		["731"] = 681,
		["732"] = 681,
		["733"] = 681,
		["734"] = 681,
		["735"] = 681,
		["736"] = 681,
		["737"] = 676,
		["738"] = 693,
		["739"] = 694,
		["742"] = 695,
		["743"] = 697,
		["745"] = 693,
		["746"] = 700,
		["747"] = 701,
		["750"] = 702,
		["751"] = 703,
		["753"] = 700,
		["754"] = 706,
		["755"] = 707,
		["756"] = 708,
		["757"] = 709,
		["758"] = 710,
		["760"] = 713,
		["761"] = 714,
		["764"] = 706,
		["765"] = 635,
		["766"] = 627,
		["767"] = 627,
		["768"] = 627,
		["769"] = 627,
		["770"] = 627,
		["771"] = 627,
		["772"] = 627,
		["773"] = 627,
		["774"] = 635,
		["776"] = 635,
		["777"] = 720,
		["778"] = 728,
		["779"] = 720,
		["780"] = 728,
		["781"] = 729,
		["782"] = 730,
		["783"] = 729,
		["784"] = 736,
		["785"] = 737,
		["786"] = 736,
		["787"] = 739,
		["788"] = 740,
		["789"] = 739,
		["790"] = 742,
		["791"] = 743,
		["792"] = 742,
		["793"] = 728,
		["794"] = 720,
		["795"] = 720,
		["796"] = 720,
		["797"] = 720,
		["798"] = 720,
		["799"] = 720,
		["800"] = 720,
		["801"] = 720,
		["802"] = 728,
		["804"] = 728,
		["805"] = 748,
		["808"] = 767,
		["809"] = 767,
		["810"] = 788,
		["811"] = 780,
		["812"] = 789,
		["813"] = 790,
		["814"] = 791,
		["815"] = 792,
		["816"] = 793,
		["817"] = 794,
		["818"] = 795,
		["819"] = 796,
		["820"] = 797,
		["821"] = 798,
		["822"] = 799,
		["823"] = 800,
		["824"] = 801,
		["825"] = 802,
		["826"] = 788,
		["827"] = 805,
		["828"] = 806,
		["831"] = 807,
		["832"] = 808,
		["833"] = 809,
		["834"] = 811,
		["835"] = 811,
		["836"] = 811,
		["837"] = 811,
		["838"] = 811,
		["839"] = 811,
		["840"] = 811,
		["841"] = 811,
		["842"] = 816,
		["843"] = 817,
		["844"] = 818,
		["845"] = 822,
		["846"] = 824,
		["848"] = 828,
		["849"] = 829,
		["850"] = 829,
		["851"] = 829,
		["852"] = 830,
		["855"] = 831,
		["856"] = 832,
		["857"] = 833,
		["858"] = 838,
		["859"] = 839,
		["861"] = 841,
		["862"] = 841,
		["864"] = 843,
		["865"] = 844,
		["866"] = 845,
		["868"] = 847,
		["869"] = 847,
		["870"] = 847,
		["871"] = 847,
		["872"] = 847,
		["873"] = 847,
		["874"] = 847,
		["875"] = 847,
		["876"] = 847,
		["877"] = 847,
		["878"] = 847,
		["879"] = 847,
		["880"] = 847,
		["881"] = 858,
		["882"] = 860,
		["883"] = 860,
		["884"] = 860,
		["885"] = 861,
		["888"] = 862,
		["889"] = 863,
		["890"] = 860,
		["891"] = 860,
		["892"] = 829,
		["893"] = 829,
		["894"] = 866,
		["895"] = 866,
		["896"] = 866,
		["897"] = 867,
		["898"] = 866,
		["899"] = 866,
		["900"] = 805,
		["901"] = 870,
		["902"] = 871,
		["903"] = 872,
		["906"] = 875,
		["907"] = 876,
		["908"] = 877,
		["909"] = 877,
		["910"] = 877,
		["911"] = 877,
		["913"] = 879,
		["914"] = 880,
		["915"] = 881,
		["916"] = 881,
		["917"] = 881,
		["918"] = 881,
		["920"] = 883,
		["921"] = 884,
		["922"] = 885,
		["923"] = 885,
		["924"] = 885,
		["925"] = 885,
		["927"] = 870,
		["928"] = 889,
		["929"] = 890,
		["932"] = 891,
		["933"] = 892,
		["936"] = 895,
		["939"] = 897,
		["940"] = 898,
		["941"] = 899,
		["942"] = 900,
		["943"] = 900,
		["944"] = 900,
		["945"] = 900,
		["946"] = 900,
		["947"] = 900,
		["948"] = 900,
		["949"] = 900,
		["950"] = 900,
		["951"] = 900,
		["952"] = 900,
		["953"] = 900,
		["954"] = 900,
		["955"] = 900,
		["956"] = 900,
		["957"] = 912,
		["958"] = 914,
		["959"] = 914,
		["960"] = 914,
		["961"] = 915,
		["964"] = 916,
		["967"] = 917,
		["968"] = 917,
		["969"] = 917,
		["970"] = 917,
		["971"] = 917,
		["972"] = 917,
		["973"] = 917,
		["974"] = 924,
		["975"] = 925,
		["978"] = 926,
		["979"] = 927,
		["980"] = 928,
		["981"] = 930,
		["982"] = 931,
		["983"] = 932,
		["984"] = 933,
		["985"] = 934,
		["989"] = 917,
		["990"] = 917,
		["991"] = 914,
		["992"] = 914,
		["993"] = 889,
		["994"] = 947,
		["995"] = 948,
		["998"] = 949,
		["999"] = 952,
		["1000"] = 953,
		["1001"] = 954,
		["1003"] = 957,
		["1004"] = 958,
		["1005"] = 959,
		["1007"] = 961,
		["1008"] = 962,
		["1009"] = 963,
		["1011"] = 966,
		["1012"] = 967,
		["1013"] = 968,
		["1014"] = 969,
		["1015"] = 970,
		["1016"] = 970,
		["1017"] = 970,
		["1018"] = 970,
		["1019"] = 970,
		["1020"] = 970,
		["1021"] = 970,
		["1022"] = 970,
		["1023"] = 970,
		["1024"] = 970,
		["1025"] = 970,
		["1026"] = 970,
		["1027"] = 970,
		["1028"] = 980,
		["1029"] = 981,
		["1030"] = 981,
		["1031"] = 981,
		["1032"] = 982,
		["1033"] = 983,
		["1035"] = 981,
		["1036"] = 981,
		["1038"] = 987,
		["1040"] = 989,
		["1041"] = 991,
		["1042"] = 992,
		["1044"] = 947,
	}
)
local j = {}
local k, l, m
local n = require("lib.dota_ts_adapter")
local o = n.BaseAbility
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
local t = require("abilities.ability_ai")
local u = t.BaseAbilityAI
local v = t.registerAbilityAI
j.abyssal_underlord_talent = c()
local w = j.abyssal_underlord_talent
w.name = "abyssal_underlord_talent"
d(w, o)
function w.prototype.GetIntrinsicModifierName(self)
	return "modifier_abyssal_underlord_talent"
end
w = e({ p(nil) }, w)
j.abyssal_underlord_talent = w
j.modifier_abyssal_underlord_talent = c()
local x = j.modifier_abyssal_underlord_talent
x.name = "modifier_abyssal_underlord_talent"
d(x, r)
function x.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.outgoing_chaos_damage = 0
	self.winCount = 0
	self.tl7_record = 0
	self.warriorList = {}
	self.archerList = {}
end
function x.prototype.GetAbilitySpecialValue(self)
	self.chaos_damage = self:GetAbilitySpecialValueFor("chaos_damage")
		+ self:GetAbilityTalentValue("abyssal_underlord_talent_2", "extra_chaos")
	self.damage_reduce_pct = self:GetAbilitySpecialValueFor("damage_reduce_pct")
	self.tl4_chaos_count = self:GetAbilityTalentValue("abyssal_underlord_talent_4", "chaos_count")
	self.tl4_interval = self:GetAbilityTalentValue("abyssal_underlord_talent_4", "interval")
	self.tl5_steal_chance = self:GetAbilityTalentValue("abyssal_underlord_talent_5", "steal_chance")
	self.tl5_steal_chaos = self:GetAbilityTalentValue("abyssal_underlord_talent_5", "steal_chaos")
	self.tl6_interval = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "interval")
	self.tl6_duration = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "duration")
	self.tl6_summon_chance = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "summon_chance")
	self.s_damage_reduce_pct = self:GetAbilityTalentValue("abyssal_underlord_shard", "damage_reduce_pct")
	self.warrior_health = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "warrior_health")
	self.warrior_attack_interval = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "warrior_attack_interval")
	self.warrior_mana_reduce = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "warrior_mana_reduce")
	self.warrior_death_chaos = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "warrior_death_chaos")
	self.archer_attack_interval = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "archer_attack_interval")
	self.archer_attack_chaos = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "archer_attack_chaos")
	self.archer_buff_reduce_pct = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "archer_buff_reduce_pct")
	self.archer_gold_chance = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "archer_gold_chance")
	self.archer_gold_amount = self:GetAbilityTalentValue("abyssal_underlord_talent_6", "archer_gold_amount")
	self.tl7_trigger_chaos = self:GetAbilityTalentValue("abyssal_underlord_talent_7", "trigger_chaos")
	self.tl7_stun_duration = self:GetAbilityTalentValue("abyssal_underlord_talent_7", "stun_duration")
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CHAOS_POINT_GAINED] = { self:GetParent(), -1 },
	}
end
function x.prototype.OnIntervalThink(self)
	local y = self:GetParent()
	if IsValid(y) then
		if self.winCount > 0 then
			AddChaos(y, self.tl4_chaos_count * self.winCount, self:GetAbility():GetName(), "Ability")
		end
	end
end
function x.prototype.OnThink(self, z)
	if z == "Summon" then
		if self:HasTalent("abyssal_underlord_talent_6") and self:PRD(self.tl6_summon_chance) then
			self:Summon(0)
			self:Summon(1)
		else
			self:Summon()
		end
	end
end
function x.prototype.OnBattleStart(self, A)
	local B = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "win_count")
	if B == nil then
		B = 0
	end
	self.winCount = B
	self.outgoing_chaos_damage = self.winCount * self.chaos_damage
	local C = self:GetParent():GetEnemy()
	C:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_abyssal_underlord_talent_debuff",
		{ damage_reduce = self.winCount * self.damage_reduce_pct }
	)
	if IsValid(C) then
		if C:IsHero() then
			C:CalculateStatBonus(true)
		else
			C:CalculateGenericBonuses()
		end
	end
	self:SetStackCount(self.outgoing_chaos_damage)
	if self:HasTalent("abyssal_underlord_talent_4") then
		self:StartIntervalThink(self.tl4_interval)
	end
	if self:HasTalent("abyssal_underlord_talent_6") then
		local y = self:GetParent()
		local D = C:GetAbsOrigin() - y:GetAbsOrigin()
		D.z = 0
		D = D:Normalized()
		local E = GetGroundPosition(y:GetAbsOrigin() + D * -400, nil)
		self.portalUnit = CreateUnitByName("npc_abyssal_underlord_door", E, true, y, y, y:GetTeamNumber())
		self.portalUnit:SetForwardVector(D)
		self.portalFx = ParticleManager:CreateParticle(
			"particles/units/heroes/heroes_underlord/abbysal_underlord_portal_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.portalUnit
		)
		ParticleManager:SetParticleControlEnt(
			self.portalFx,
			1,
			self.portalUnit,
			PATTACH_POINT_FOLLOW,
			"attach_portal",
			self.portalUnit:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControl(self.portalFx, 4, Vector(1, 0, 0))
		if self:HasTalent("abyssal_underlord_talent_6") and self:PRD(self.tl6_summon_chance) then
			self:Summon(0)
			self:Summon(1)
		else
			self:Summon()
		end
		self:StartThink(self.tl6_interval, "Summon")
	end
end
function x.prototype.OnBattleEnd(self, A)
	if A.winPlayerID == self:GetParent():GetPlayerOwnerID() then
		if A.isNeutral then
			return
		end
		self:saveOutgoingChaosDamage()
	end
	self:StartIntervalThink(-1)
	self:StartThink(-1, "Summon")
	g(f(self.warriorList), function(F, G)
		return G:Dispose(true)
	end)
	self.warriorList = {}
	g(f(self.archerList), function(F, G)
		return G:Dispose()
	end)
	self.archerList = {}
	if self.portalFx ~= nil then
		ParticleManager:DestroyParticle(self.portalFx, false)
		ParticleManager:ReleaseParticleIndex(self.portalFx)
		self.portalFx = nil
	end
	if self.portalUnit and IsValid(self.portalUnit) then
		self.portalUnit:SafeRemoveUnit()
	end
	self.portalUnit = nil
end
function x.prototype.OnChaosPointGained(self, A)
	if self:HasTalent("abyssal_underlord_talent_7") then
		self.tl7_record = self.tl7_record + A.iStackCount
		if self.tl7_record >= self.tl7_trigger_chaos then
			self.tl7_record = self.tl7_record - self.tl7_trigger_chaos
			AddStun(self:GetParent(), self:GetParent():GetEnemy(), self:GetAbility(), self.tl7_stun_duration)
			local H = self:GetParent():FindAbilityByName("abyssal_underlord_ult")
			H:OnSpellStart()
		end
	end
end
function x.prototype.OnCustomTakeDamage(self, I) end
function x.prototype.saveOutgoingChaosDamage(self)
	local J = self:GetParent():GetPlayerOwnerID()
	local K = PlayerData:getplayerData(J)
	local L = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "win_count")
	if L == nil then
		L = 0
	end
	local M = L
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "win_count", M + 1)
	K:modifyHeroAbilityExtraData("abyssal_underlord_talent", "outgoing_chaos", M + 1, true, true)
end
function x.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function x.prototype.EOM_GetModifierChaosDamageBonus(self)
	return self:GetStackCount()
end
function x.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	if self:HasTalent("abyssal_underlord_shard") then
		return -(self:GetStackCount() / self.chaos_damage * self.s_damage_reduce_pct)
	end
end
function x.prototype.Summon(self, N)
	local y = self:GetParent()
	if not IsValid(y) then
		return
	end
	local C = y:GetEnemy()
	if not IsInjurable(C, y) then
		return
	end
	local O = RandomInt(0, 1) == 0
	if N ~= nil then
		O = N == 0
	end
	local P = C:GetAbsOrigin() - y:GetAbsOrigin()
	P.z = 0
	P = P:Normalized()
	local Q = Vector(-P.y, P.x, 0)
	local R = 150
	local S = y:GetAbsOrigin() + Q * (O and -R or R)
	GameTimer(1, function()
		if not IsValid(self) or not IsValid(y) then
			return
		end
		local T = y:GetEnemy()
		if not IsInjurable(T, y) then
			return
		end
		EmitSoundOn("Hero_Chen.SummonConvert", y)
		local U = self.portalUnit and IsValid(self.portalUnit) and self.portalUnit:GetAbsOrigin() or S
		if O then
			local V = h(
				k,
				{
					parent = y,
					enemy = T,
					ability = self:GetAbility(),
					buff = self,
					position = S,
					direction = P,
					duration = self.tl6_duration + 1,
					warrior_health = self.warrior_health,
					warrior_attack_interval = self.warrior_attack_interval,
					warrior_mana_reduce = self.warrior_mana_reduce,
					warrior_death_chaos = self.warrior_death_chaos,
					portalPos = U,
				}
			)
			local W = self.warriorList
			W[#W + 1] = V
		else
			local X = h(
				m,
				{
					parent = y,
					enemy = T,
					ability = self:GetAbility(),
					buff = self,
					position = S,
					direction = P,
					duration = self.tl6_duration + 1,
					archer_attack_interval = self.archer_attack_interval,
					archer_attack_chaos = self.archer_attack_chaos,
					archer_buff_reduce_pct = self.archer_buff_reduce_pct,
					archer_gold_chance = self.archer_gold_chance,
					archer_gold_amount = self.archer_gold_amount,
					portalPos = U,
				}
			)
			local Y = self.archerList
			Y[#Y + 1] = X
		end
	end)
end
function x.prototype.OnDemonWarriorDispose(self, V)
	self.warriorList = {}
end
function x.prototype.OnDemonArcherDispose(self, X)
	self.archerList = {}
end
function x.prototype.OnDestroy(self)
	if self.portalFx ~= nil then
		ParticleManager:DestroyParticle(self.portalFx, false)
		ParticleManager:ReleaseParticleIndex(self.portalFx)
		self.portalFx = nil
	end
	if self.portalUnit and IsValid(self.portalUnit) then
		self.portalUnit:SafeRemoveUnit()
	end
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
j.modifier_abyssal_underlord_talent = x
j.modifier_abyssal_underlord_talent_debuff = c()
local Z = j.modifier_abyssal_underlord_talent_debuff
Z.name = "modifier_abyssal_underlord_talent_debuff"
d(Z, r)
function Z.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce_pct = self:GetAbilitySpecialValueFor("damage_reduce_pct")
end
function Z.prototype.OnCreated(self, A)
	if IsServer() then
		self:SetStackCount(A.damage_reduce)
		print(A.damage_reduce)
	end
end
function Z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function Z.prototype.EOM_GetModifierAttackDamageTotalPercentage(self)
	return -self:GetStackCount()
end
Z = e(
	{
		s(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	Z
)
j.modifier_abyssal_underlord_talent_debuff = Z
j.abyssal_underlord_ult = c()
local _ = j.abyssal_underlord_ult
_.name = "abyssal_underlord_ult"
d(_, u)
function _.prototype.OnSpellStart(self)
	local a0 = self:GetCaster()
	local a1 = self:GetSpecialValueFor("duration")
	if not a0:HasModifier("modifier_abyssal_underlord_ult") then
		a0:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
		GameTimer(0.6, function()
			if IsValid(a0) then
				a0:AddNewModifier(a0, self, "modifier_abyssal_underlord_ult", { duration = a1 })
			end
		end)
	else
		local a2 = a0:FindModifierByName("modifier_abyssal_underlord_ult")
		if a2 then
			a2:SetDuration(a2:GetRemainingTime() + a1, true)
		end
	end
end
_ = e({ v(nil) }, _)
j.abyssal_underlord_ult = _
j.modifier_abyssal_underlord_ult = c()
local a3 = j.modifier_abyssal_underlord_ult
a3.name = "modifier_abyssal_underlord_ult"
d(a3, r)
function a3.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("abyssal_underlord_talent_3", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.tl1_magic_damage_pct = self:GetAbilityTalentValue("abyssal_underlord_talent_1", "magic_damage_pct")
end
function a3.prototype.OnCreated(self, A)
	self:StartIntervalThink(self.interval)
end
function a3.prototype.OnIntervalThink(self)
	if IsServer() then
		EmitSoundOn("Hero_AbyssalUnderlord.Firestorm", self:GetParent())
		local a4 = ParticleManager:CreateParticle(
			"particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(a4, 0, self:GetParent():GetEnemy():GetAbsOrigin())
		ParticleManager:SetParticleControl(a4, 4, Vector(400, 400, 400))
		ParticleManager:ReleaseParticleIndex(a4)
		local y = self:GetParent()
		if not IsValid(y) then
			return
		end
		local C = y:GetEnemy()
		if not IsInjurable(C, y) then
			return
		end
		y:DealDamage(C, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS)
		if self:HasTalent("abyssal_underlord_talent_1") then
			y:DealDamage(
				C,
				y:FindAbilityByName("abyssal_underlord_talent_1"),
				y:GetMaxHealth() * self.tl1_magic_damage_pct * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
		end
	end
end
function a3.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a3.prototype.OnBattleEnd(self, A)
	self:StartIntervalThink(-1)
end
function a3.prototype.OnDestroy(self)
	self:StartIntervalThink(-1)
end
a3 = e(
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
	a3
)
j.modifier_abyssal_underlord_ult = a3
local a5 = "models/creeps/item_creeps/i_creep_necro_warrior/necro_warrior.vmdl"
k = c()
k.name = "DemonWarrior"
function k.prototype.____constructor(self, a6)
	self.disposed = false
	self.parent = a6.parent
	self.enemy = a6.enemy
	self.ability = a6.ability
	self.buff = a6.buff
	self.position = a6.position
	self.direction = a6.direction
	self.duration = a6.duration
	self.warrior_health = a6.warrior_health
	self.warrior_attack_interval = a6.warrior_attack_interval
	self.warrior_mana_reduce = a6.warrior_mana_reduce
	self.warrior_death_chaos = a6.warrior_death_chaos
	self.portalPos = a6.portalPos
	self:spawn()
end
function k.prototype.spawn(self)
	if self.disposed then
		return
	end
	local a7 = self.portalPos
	local a8 = self.position
	local a9 = SummonWisp(self.parent, self.warrior_health, a5, function(G)
		G:SetAbsOrigin(a7)
		G:SetForwardVector(self.direction)
		local aa = G:AddNewModifier(self.parent, self.ability, "modifier_abyssal_underlord_demon_warrior", nil)
		if aa then
			aa.owner = self
		end
	end)
	if not a9 then
		self.disposed = true
		return
	end
	self.wisp = a9
	local ab = 0
	GameTimer(0.033, function()
		if self.disposed then
			return
		end
		ab = ab + 1
		local ac = ab / 30
		local ad = Vector(a7.x + (a8.x - a7.x) * ac, a7.y + (a8.y - a7.y) * ac, a7.z + (a8.z - a7.z) * ac)
		if self.wisp and IsValid(self.wisp) then
			local aa = self.wisp:FindModifierByName("modifier_abyssal_underlord_demon_warrior")
			if aa then
				aa:SetPosition(ad)
			end
		end
		if ab < 30 then
			return 0.033
		end
		if self.wisp and IsValid(self.wisp) then
			local ae = self.wisp:FindModifierByName("modifier_abyssal_underlord_demon_warrior")
			if ae then
				ae:StopWalk()
			end
		end
	end)
	self.attackTimer = GameTimer(1 + self.warrior_attack_interval, function()
		if self.disposed then
			return
		end
		self:Attack()
		return self.warrior_attack_interval
	end)
	self.lifeTimer = GameTimer(self.duration, function()
		self:Dispose(true)
	end)
end
function k.prototype.Attack(self)
	if self.disposed then
		return
	end
	if not IsInjurable(self.enemy, self.parent) then
		return
	end
	if not self.wisp or not IsValid(self.wisp) then
		return
	end
	local aa = self.wisp:FindModifierByName("modifier_abyssal_underlord_demon_warrior")
	if aa then
		aa:PlayAttack()
	end
	EmitSoundOn("Hero_AbyssalUnderlord.Attack", self.wisp)
	GameTimer(0.3, function()
		if self.disposed then
			return
		end
		if not IsInjurable(self.enemy, self.parent) then
			return
		end
		local af = self.parent:FindAbilityByName("abyssal_underlord_warrior") or self.ability
		ReduceMana(self.enemy, self.warrior_mana_reduce, af)
	end)
end
function k.prototype.Dispose(self, ag)
	if self.disposed then
		return
	end
	self.disposed = true
	if not ag and IsInjurable(self.enemy, self.parent) then
		local af = self.parent:FindAbilityByName("abyssal_underlord_warrior") or self.ability
		self.parent:DealDamage(self.enemy, af, self.warrior_death_chaos, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS)
		local a4 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_abyssal_underlord/abyssal_underlord_pit_of_malice_warning.vpcf",
			PATTACH_ABSORIGIN,
			self.enemy
		)
		ParticleManager:ReleaseParticleIndex(a4)
	end
	if self.attackTimer ~= nil then
		StopTimer(self.attackTimer)
		self.attackTimer = nil
	end
	if self.lifeTimer ~= nil then
		StopTimer(self.lifeTimer)
		self.lifeTimer = nil
	end
	local ah = self.wisp and IsValid(self.wisp) and self.wisp:GetAbsOrigin() or self.position
	local ai = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = ah,
			angles = VectorToAngles(self.direction),
			scales = "0.5 0.5 0.5",
			model = a5,
			DefaultAnim = "ACT_DOTA_DIE",
			use_animgraph = "1",
			AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
		}
	)
	EmitSoundOn("Hero_AbyssalUnderlord.Death", ai)
	GameTimer(1, function()
		if ai and IsValid(ai) then
			UTIL_Remove(ai)
		end
	end)
	if self.wisp and IsValid(self.wisp) then
		KillWisp(self.parent, self.wisp, true, false)
	end
	self.wisp = nil
	if IsValid(self.buff) then
		self.buff:OnDemonWarriorDispose(self)
	end
end
j.modifier_abyssal_underlord_demon_warrior = c()
local aj = j.modifier_abyssal_underlord_demon_warrior
aj.name = "modifier_abyssal_underlord_demon_warrior"
d(aj, r)
function aj.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED] = true }
end
function aj.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_MODEL_SCALE }
end
function aj.prototype.GetModifierModelChange(self)
	return a5
end
function aj.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function aj.prototype.GetModifierModelScale(self)
	return -100
end
function aj.prototype.OnCreated(self, A) end
function aj.prototype.StopWalk(self)
	if not IsServer() then
		return
	end
	self.parent:AddNoDraw()
	self.dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			model = a5,
			origin = self.parent:GetAbsOrigin(),
			angles = VectorToAngles(self.parent:GetForwardVector()),
			scales = "0.5 0.5 0.5",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
		}
	)
end
function aj.prototype.PlayAttack(self)
	if not IsServer() then
		return
	end
	if self.dummy and IsValid(self.dummy) then
		UTIL_Remove(self.dummy)
	end
	self.dummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			model = a5,
			origin = self.parent:GetAbsOrigin(),
			angles = VectorToAngles(self.parent:GetForwardVector()),
			scales = "0.5 0.5 0.5",
			StartingAnim = "ACT_DOTA_ATTACK",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
		}
	)
end
function aj.prototype.SetPosition(self, S)
	if not IsServer() then
		return
	end
	if IsValid(self.parent) then
		self.parent:SetAbsOrigin(S)
	end
end
function aj.prototype.SyncDummyToParent(self)
	if not IsServer() then
		return
	end
	if self.dummy and IsValid(self.dummy) then
		self.dummy:SetAbsOrigin(self.parent:GetAbsOrigin())
	end
end
function aj.prototype.OnDestroy(self)
	if IsServer() then
		if self.dummy then
			UTIL_Remove(self.dummy)
			self.dummy = nil
		end
		if self.owner and not self.owner.disposed then
			self.owner:Dispose()
		end
	end
end
aj = e(
	{
		s(
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
	aj
)
j.modifier_abyssal_underlord_demon_warrior = aj
j.modifier_abyssal_underlord_archer_walk = c()
local ak = j.modifier_abyssal_underlord_archer_walk
ak.name = "modifier_abyssal_underlord_archer_walk"
d(ak, r)
function ak.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_MODEL_SCALE }
end
function ak.prototype.GetModifierModelChange(self)
	return l
end
function ak.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function ak.prototype.GetModifierModelScale(self)
	return -0.2
end
ak = e(
	{
		s(
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
	ak
)
j.modifier_abyssal_underlord_archer_walk = ak
l = "models/creeps/item_creeps/i_creep_necro_archer/necro_archer.vmdl"
m = c()
m.name = "DemonArcher"
function m.prototype.____constructor(self, a6)
	self.disposed = false
	self.parent = a6.parent
	self.enemy = a6.enemy
	self.ability = a6.ability
	self.buff = a6.buff
	self.position = a6.position
	self.direction = a6.direction
	self.duration = a6.duration
	self.archer_attack_interval = a6.archer_attack_interval
	self.archer_attack_chaos = a6.archer_attack_chaos
	self.archer_buff_reduce_pct = a6.archer_buff_reduce_pct
	self.archer_gold_chance = a6.archer_gold_chance
	self.archer_gold_amount = a6.archer_gold_amount
	self.portalPos = a6.portalPos
	self:spawn()
end
function m.prototype.spawn(self)
	if self.disposed then
		return
	end
	local a7 = self.portalPos
	local a8 = self.position
	self.cachedModel = l
	local al = CreateUnitFromTable(
		{ MapUnitName = "npc_wisp_small", teamnumber = self.parent:GetTeamNumber(), StatusHealth = 9999 },
		a7
	)
	al:SetForwardVector(self.direction)
	al:AddNewModifier(self.parent, self.ability, "modifier_abyssal_underlord_archer_walk", nil)
	self.archerWalkUnit = al
	if IsValid(self.enemy) then
		self:ReduceBuff()
	end
	local ab = 0
	GameTimer(0.033, function()
		if self.disposed then
			return
		end
		ab = ab + 1
		local ac = ab / 30
		local ad = Vector(a7.x + (a8.x - a7.x) * ac, a7.y + (a8.y - a7.y) * ac, a7.z + (a8.z - a7.z) * ac)
		if self.archerWalkUnit and IsValid(self.archerWalkUnit) then
			self.archerWalkUnit:SetAbsOrigin(ad)
		end
		if ab < 30 then
			return 0.033
		end
		if self.archerWalkUnit and IsValid(self.archerWalkUnit) then
			UTIL_Remove(self.archerWalkUnit)
			self.archerWalkUnit = nil
		end
		self.archerDummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = a8,
				angles = VectorToAngles(self.direction),
				scale = 0.5,
				model = self.cachedModel,
				DefaultAnim = "ACT_DOTA_IDLE",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
				AnimateOnServer = "1",
			}
		)
		self:Attack()
		self.attackTimer = GameTimer(self.archer_attack_interval, function()
			if self.disposed then
				return
			end
			self:Attack()
			return self.archer_attack_interval
		end)
	end)
	self.lifeTimer = GameTimer(self.duration, function()
		self:Dispose()
	end)
end
function m.prototype.ReduceBuff(self)
	local C = self.enemy
	if not IsValid(C) then
		return
	end
	local am = GetChaos(C)
	if am > 0 then
		ReduceChaos(C, math.floor(am * self.archer_buff_reduce_pct * 0.01))
	end
	local an = GetShield(C)
	if an > 0 then
		ReduceShield(C, math.floor(an * self.archer_buff_reduce_pct * 0.01))
	end
	local ao = GetFury(C)
	if ao > 0 then
		ReduceFury(C, math.floor(ao * self.archer_buff_reduce_pct * 0.01))
	end
end
function m.prototype.Attack(self)
	if self.disposed then
		return
	end
	if not IsInjurable(self.enemy, self.parent) then
		self:Dispose()
		return
	end
	if not self.archerDummy or not IsValid(self.archerDummy) then
		return
	end
	local ap = self.archerDummy
	local aq = self.position
	local ar = self.direction
	self.archerDummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = aq,
			angles = VectorToAngles(ar),
			scale = 0.5,
			model = self.cachedModel,
			StartingAnim = "ACT_DOTA_ATTACK",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
			AnimateOnServer = "1",
		}
	)
	UTIL_Remove(ap)
	GameTimer(0.4, function()
		if self.disposed or not self.archerDummy or not IsValid(self.archerDummy) then
			return
		end
		if not IsInjurable(self.enemy, self.parent) then
			return
		end
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/items2_fx/necronomicon_archer_projectile.vpcf",
			hCaster = self.parent,
			vSpawnOrigin = self.position + Vector(0, 0, 100),
			hTarget = self.enemy,
			flRadius = 0,
			iMoveSpeed = 1500,
			OnProjectileDestroy = function(as, at)
				if not IsInjurable(self.enemy, self.parent) then
					return
				end
				if IsServer() then
					local au = self.parent:FindAbilityByName("abyssal_underlord_archer") or self.ability
					self.parent:DealDamage(self.enemy, au, self.archer_attack_chaos, EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS)
					if RandomInt(1, 100) <= self.archer_gold_chance then
						local J = self.parent:GetPlayerOwnerID()
						if J ~= -1 then
							PlayerData:modifyGold(J, self.archer_gold_amount)
							Notification:combatToPlayer(
								J,
								{
									message = "notify_bonus_gold",
									string_itemname_artifact = "DOTA_Tooltip_ability_abyssal_underlord_archer",
									int_gold = self.archer_gold_amount,
								}
							)
						end
					end
				end
			end,
		})
	end)
end
function m.prototype.Dispose(self)
	if self.disposed then
		return
	end
	self.disposed = true
	if self.archerWalkUnit and IsValid(self.archerWalkUnit) then
		UTIL_Remove(self.archerWalkUnit)
		self.archerWalkUnit = nil
	end
	if self.attackTimer ~= nil then
		StopTimer(self.attackTimer)
		self.attackTimer = nil
	end
	if self.lifeTimer ~= nil then
		StopTimer(self.lifeTimer)
		self.lifeTimer = nil
	end
	if self.archerDummy and IsValid(self.archerDummy) then
		local av = self.archerDummy
		self.archerDummy = nil
		if self.cachedModel then
			local aw = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{
					origin = self.position,
					angles = VectorToAngles(self.direction),
					scale = 0.5,
					model = self.cachedModel,
					DefaultAnim = "ACT_DOTA_DIE",
					use_animgraph = "1",
					AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
					AnimateOnServer = "1",
				}
			)
			EmitSoundOn("Hero_AbyssalUnderlord.Death", aw)
			GameTimer(1, function()
				if aw and IsValid(aw) then
					UTIL_Remove(aw)
				end
			end)
		end
		UTIL_Remove(av)
	end
	self.archerDummy = nil
	if IsValid(self.buff) then
		self.buff:OnDemonArcherDispose(self)
	end
end
return j