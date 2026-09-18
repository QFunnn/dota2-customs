--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
		["42"] = 65,
		["43"] = 66,
		["44"] = 67,
		["45"] = 68,
		["46"] = 69,
		["47"] = 70,
		["48"] = 26,
		["49"] = 95,
		["50"] = 97,
		["51"] = 99,
		["52"] = 100,
		["53"] = 101,
		["54"] = 103,
		["55"] = 104,
		["56"] = 106,
		["57"] = 108,
		["58"] = 109,
		["59"] = 110,
		["60"] = 112,
		["61"] = 113,
		["62"] = 115,
		["63"] = 116,
		["64"] = 117,
		["65"] = 118,
		["66"] = 119,
		["67"] = 120,
		["68"] = 121,
		["69"] = 122,
		["70"] = 123,
		["71"] = 124,
		["72"] = 125,
		["73"] = 126,
		["74"] = 127,
		["75"] = 128,
		["76"] = 129,
		["77"] = 130,
		["78"] = 131,
		["79"] = 132,
		["80"] = 133,
		["81"] = 134,
		["82"] = 135,
		["83"] = 136,
		["84"] = 137,
		["85"] = 138,
		["86"] = 139,
		["87"] = 140,
		["88"] = 95,
		["89"] = 142,
		["90"] = 143,
		["91"] = 147,
		["92"] = 148,
		["93"] = 149,
		["94"] = 150,
		["95"] = 151,
		["96"] = 152,
		["97"] = 153,
		["98"] = 154,
		["99"] = 155,
		["100"] = 156,
		["101"] = 157,
		["102"] = 159,
		["103"] = 160,
		["104"] = 162,
		["105"] = 163,
		["106"] = 164,
		["107"] = 165,
		["108"] = 166,
		["109"] = 167,
		["110"] = 168,
		["111"] = 169,
		["113"] = 142,
		["114"] = 173,
		["115"] = 174,
		["116"] = 175,
		["117"] = 176,
		["118"] = 177,
		["119"] = 178,
		["120"] = 179,
		["121"] = 180,
		["122"] = 181,
		["123"] = 182,
		["124"] = 183,
		["125"] = 184,
		["126"] = 185,
		["127"] = 185,
		["128"] = 185,
		["129"] = 185,
		["130"] = 185,
		["131"] = 185,
		["132"] = 185,
		["133"] = 186,
		["134"] = 186,
		["135"] = 186,
		["136"] = 186,
		["137"] = 186,
		["138"] = 186,
		["139"] = 186,
		["140"] = 187,
		["141"] = 187,
		["142"] = 187,
		["143"] = 187,
		["144"] = 187,
		["145"] = 187,
		["146"] = 187,
		["147"] = 188,
		["148"] = 188,
		["149"] = 188,
		["150"] = 188,
		["151"] = 188,
		["152"] = 188,
		["153"] = 188,
		["154"] = 189,
		["155"] = 189,
		["156"] = 189,
		["157"] = 189,
		["158"] = 189,
		["159"] = 189,
		["160"] = 189,
		["161"] = 190,
		["162"] = 190,
		["163"] = 190,
		["164"] = 190,
		["165"] = 190,
		["166"] = 190,
		["167"] = 190,
		["168"] = 191,
		["169"] = 191,
		["170"] = 191,
		["171"] = 191,
		["172"] = 191,
		["173"] = 191,
		["174"] = 191,
		["175"] = 192,
		["176"] = 192,
		["177"] = 192,
		["178"] = 192,
		["179"] = 192,
		["180"] = 192,
		["181"] = 192,
		["182"] = 193,
		["183"] = 193,
		["184"] = 193,
		["185"] = 193,
		["186"] = 193,
		["187"] = 193,
		["188"] = 193,
		["189"] = 194,
		["190"] = 194,
		["191"] = 194,
		["192"] = 194,
		["193"] = 194,
		["194"] = 194,
		["195"] = 194,
		["196"] = 195,
		["197"] = 195,
		["198"] = 195,
		["199"] = 195,
		["200"] = 195,
		["201"] = 195,
		["202"] = 195,
		["204"] = 173,
		["205"] = 198,
		["206"] = 199,
		["207"] = 200,
		["209"] = 201,
		["210"] = 201,
		["211"] = 202,
		["212"] = 201,
		["217"] = 198,
		["218"] = 207,
		["219"] = 208,
		["220"] = 208,
		["221"] = 210,
		["222"] = 210,
		["223"] = 210,
		["224"] = 208,
		["225"] = 208,
		["226"] = 212,
		["227"] = 212,
		["228"] = 212,
		["229"] = 208,
		["230"] = 208,
		["231"] = 208,
		["232"] = 208,
		["233"] = 207,
		["234"] = 217,
		["235"] = 218,
		["236"] = 217,
		["237"] = 220,
		["238"] = 221,
		["241"] = 224,
		["242"] = 225,
		["243"] = 225,
		["244"] = 225,
		["245"] = 226,
		["248"] = 227,
		["249"] = 228,
		["250"] = 229,
		["251"] = 230,
		["252"] = 231,
		["253"] = 231,
		["254"] = 231,
		["255"] = 231,
		["256"] = 231,
		["257"] = 232,
		["258"] = 233,
		["260"] = 235,
		["261"] = 235,
		["262"] = 235,
		["263"] = 235,
		["264"] = 236,
		["265"] = 236,
		["267"] = 235,
		["268"] = 235,
		["270"] = 225,
		["271"] = 225,
		["272"] = 220,
		["273"] = 248,
		["274"] = 249,
		["275"] = 250,
		["276"] = 251,
		["277"] = 252,
		["279"] = 254,
		["280"] = 255,
		["282"] = 257,
		["283"] = 259,
		["284"] = 248,
		["285"] = 261,
		["286"] = 262,
		["287"] = 261,
		["288"] = 264,
		["289"] = 265,
		["290"] = 266,
		["291"] = 267,
		["292"] = 268,
		["293"] = 269,
		["294"] = 270,
		["297"] = 264,
		["298"] = 275,
		["299"] = 276,
		["300"] = 276,
		["301"] = 276,
		["302"] = 276,
		["303"] = 276,
		["304"] = 276,
		["305"] = 276,
		["306"] = 276,
		["307"] = 276,
		["308"] = 275,
		["309"] = 286,
		["310"] = 287,
		["311"] = 286,
		["312"] = 289,
		["313"] = 290,
		["314"] = 289,
		["315"] = 292,
		["316"] = 293,
		["317"] = 292,
		["318"] = 295,
		["319"] = 296,
		["320"] = 295,
		["321"] = 298,
		["322"] = 299,
		["323"] = 298,
		["324"] = 301,
		["325"] = 302,
		["326"] = 301,
		["327"] = 304,
		["328"] = 305,
		["329"] = 304,
		["330"] = 307,
		["331"] = 308,
		["332"] = 309,
		["333"] = 307,
		["334"] = 311,
		["335"] = 312,
		["336"] = 313,
		["337"] = 311,
		["338"] = 315,
		["339"] = 315,
		["340"] = 315,
		["342"] = 316,
		["343"] = 317,
		["344"] = 318,
		["345"] = 318,
		["346"] = 318,
		["347"] = 318,
		["348"] = 318,
		["349"] = 318,
		["350"] = 318,
		["351"] = 318,
		["352"] = 318,
		["353"] = 319,
		["354"] = 320,
		["355"] = 321,
		["356"] = 322,
		["357"] = 324,
		["359"] = 326,
		["361"] = 328,
		["362"] = 329,
		["363"] = 330,
		["364"] = 331,
		["365"] = 332,
		["368"] = 335,
		["369"] = 376,
		["370"] = 336,
		["372"] = 337,
		["373"] = 338,
		["376"] = 340,
		["378"] = 341,
		["379"] = 342,
		["382"] = 344,
		["384"] = 345,
		["385"] = 346,
		["388"] = 348,
		["390"] = 349,
		["391"] = 350,
		["394"] = 352,
		["396"] = 353,
		["397"] = 354,
		["400"] = 356,
		["402"] = 357,
		["403"] = 358,
		["406"] = 360,
		["408"] = 361,
		["411"] = 363,
		["413"] = 364,
		["416"] = 366,
		["418"] = 367,
		["421"] = 369,
		["423"] = 370,
		["426"] = 372,
		["428"] = 373,
		["429"] = 374,
		["430"] = 375,
		["431"] = 376,
		["432"] = 377,
		["433"] = 377,
		["434"] = 377,
		["435"] = 378,
		["436"] = 377,
		["437"] = 377,
		["441"] = 382,
		["442"] = 382,
		["443"] = 382,
		["444"] = 382,
		["445"] = 383,
		["446"] = 384,
		["447"] = 315,
		["448"] = 386,
		["449"] = 387,
		["451"] = 388,
		["452"] = 389,
		["454"] = 390,
		["457"] = 397,
		["459"] = 398,
		["462"] = 405,
		["464"] = 406,
		["467"] = 413,
		["469"] = 414,
		["472"] = 421,
		["474"] = 422,
		["477"] = 429,
		["479"] = 430,
		["482"] = 437,
		["484"] = 438,
		["487"] = 440,
		["489"] = 441,
		["492"] = 443,
		["494"] = 444,
		["497"] = 446,
		["499"] = 447,
		["502"] = 449,
		["507"] = 452,
		["508"] = 386,
		["509"] = 454,
		["510"] = 455,
		["511"] = 454,
		["512"] = 457,
		["513"] = 458,
		["514"] = 457,
		["515"] = 461,
		["516"] = 461,
		["517"] = 461,
		["519"] = 462,
		["520"] = 463,
		["521"] = 464,
		["522"] = 465,
		["523"] = 464,
		["525"] = 473,
		["527"] = 461,
		["528"] = 480,
		["529"] = 481,
		["530"] = 482,
		["531"] = 483,
		["532"] = 484,
		["533"] = 485,
		["534"] = 485,
		["535"] = 485,
		["536"] = 486,
		["537"] = 487,
		["538"] = 485,
		["539"] = 485,
		["540"] = 480,
		["541"] = 494,
		["543"] = 495,
		["544"] = 495,
		["545"] = 496,
		["546"] = 497,
		["547"] = 498,
		["549"] = 495,
		["552"] = 494,
		["553"] = 506,
		["554"] = 507,
		["555"] = 508,
		["556"] = 509,
		["557"] = 510,
		["558"] = 511,
		["559"] = 511,
		["561"] = 512,
		["562"] = 506,
		["563"] = 519,
		["564"] = 520,
		["565"] = 520,
		["566"] = 520,
		["567"] = 520,
		["568"] = 520,
		["569"] = 520,
		["570"] = 520,
		["571"] = 520,
		["572"] = 520,
		["573"] = 520,
		["574"] = 519,
		["575"] = 532,
		["576"] = 533,
		["577"] = 534,
		["578"] = 535,
		["579"] = 536,
		["580"] = 537,
		["581"] = 538,
		["582"] = 539,
		["583"] = 540,
		["584"] = 532,
		["585"] = 34,
		["586"] = 26,
		["587"] = 26,
		["588"] = 26,
		["589"] = 26,
		["590"] = 26,
		["591"] = 26,
		["592"] = 26,
		["593"] = 26,
		["594"] = 34,
		["596"] = 34,
		["597"] = 545,
		["598"] = 545,
		["599"] = 545,
		["600"] = 545,
		["601"] = 545,
		["602"] = 545,
		["604"] = 552,
		["605"] = 553,
		["606"] = 552,
		["607"] = 553,
		["609"] = 553,
		["610"] = 554,
		["611"] = 552,
		["612"] = 575,
		["613"] = 576,
		["614"] = 577,
		["615"] = 578,
		["616"] = 579,
		["617"] = 580,
		["618"] = 581,
		["619"] = 582,
		["621"] = 584,
		["622"] = 575,
		["623"] = 587,
		["624"] = 588,
		["625"] = 589,
		["626"] = 590,
		["627"] = 591,
		["628"] = 592,
		["629"] = 593,
		["630"] = 594,
		["632"] = 596,
		["633"] = 587,
		["634"] = 599,
		["635"] = 600,
		["636"] = 601,
		["637"] = 602,
		["638"] = 603,
		["639"] = 604,
		["640"] = 605,
		["641"] = 606,
		["642"] = 607,
		["643"] = 608,
		["644"] = 609,
		["645"] = 610,
		["646"] = 611,
		["647"] = 612,
		["648"] = 613,
		["649"] = 614,
		["650"] = 614,
		["651"] = 614,
		["652"] = 614,
		["653"] = 615,
		["654"] = 615,
		["655"] = 615,
		["656"] = 615,
		["657"] = 616,
		["658"] = 616,
		["659"] = 616,
		["660"] = 616,
		["661"] = 617,
		["662"] = 617,
		["663"] = 617,
		["664"] = 617,
		["665"] = 618,
		["666"] = 618,
		["667"] = 618,
		["668"] = 618,
		["669"] = 619,
		["670"] = 619,
		["671"] = 619,
		["672"] = 619,
		["674"] = 621,
		["675"] = 599,
		["676"] = 624,
		["677"] = 625,
		["678"] = 626,
		["681"] = 629,
		["682"] = 630,
		["683"] = 631,
		["684"] = 632,
		["685"] = 633,
		["686"] = 634,
		["687"] = 635,
		["688"] = 624,
		["689"] = 638,
		["690"] = 638,
		["691"] = 638,
		["693"] = 639,
		["694"] = 640,
		["695"] = 641,
		["696"] = 642,
		["697"] = 643,
		["698"] = 644,
		["699"] = 645,
		["700"] = 646,
		["701"] = 647,
		["702"] = 648,
		["704"] = 650,
		["706"] = 652,
		["707"] = 638,
		["708"] = 655,
		["709"] = 656,
		["710"] = 657,
		["711"] = 658,
		["712"] = 659,
		["713"] = 660,
		["714"] = 661,
		["715"] = 661,
		["716"] = 661,
		["717"] = 661,
		["718"] = 661,
		["719"] = 661,
		["720"] = 661,
		["722"] = 655,
		["723"] = 665,
		["724"] = 666,
		["725"] = 666,
		["726"] = 666,
		["727"] = 666,
		["728"] = 666,
		["729"] = 666,
		["731"] = 666,
		["732"] = 665,
		["733"] = 669,
		["734"] = 670,
		["735"] = 671,
		["736"] = 672,
		["737"] = 673,
		["738"] = 674,
		["739"] = 675,
		["741"] = 678,
		["742"] = 679,
		["744"] = 681,
		["745"] = 681,
		["746"] = 681,
		["747"] = 682,
		["750"] = 685,
		["752"] = 686,
		["753"] = 687,
		["755"] = 688,
		["758"] = 690,
		["760"] = 691,
		["763"] = 693,
		["765"] = 694,
		["769"] = 697,
		["773"] = 681,
		["774"] = 681,
		["775"] = 669,
		["776"] = 703,
		["777"] = 704,
		["778"] = 705,
		["779"] = 706,
		["780"] = 707,
		["781"] = 708,
		["783"] = 710,
		["784"] = 711,
		["786"] = 713,
		["787"] = 714,
		["788"] = 715,
		["789"] = 716,
		["790"] = 717,
		["791"] = 717,
		["792"] = 717,
		["793"] = 718,
		["794"] = 719,
		["795"] = 720,
		["796"] = 721,
		["798"] = 717,
		["799"] = 717,
		["800"] = 703,
		["801"] = 726,
		["802"] = 727,
		["803"] = 728,
		["804"] = 729,
		["805"] = 730,
		["806"] = 731,
		["807"] = 732,
		["808"] = 733,
		["809"] = 734,
		["810"] = 735,
		["811"] = 736,
		["813"] = 726,
		["814"] = 739,
		["815"] = 740,
		["816"] = 741,
		["817"] = 742,
		["818"] = 743,
		["819"] = 744,
		["820"] = 746,
		["821"] = 747,
		["822"] = 748,
		["823"] = 749,
		["824"] = 750,
		["825"] = 751,
		["827"] = 739,
		["828"] = 754,
		["829"] = 755,
		["830"] = 756,
		["833"] = 759,
		["834"] = 760,
		["835"] = 761,
		["836"] = 762,
		["837"] = 763,
		["838"] = 763,
		["839"] = 763,
		["840"] = 764,
		["841"] = 765,
		["843"] = 766,
		["844"] = 766,
		["845"] = 766,
		["846"] = 766,
		["847"] = 767,
		["850"] = 763,
		["851"] = 763,
		["852"] = 770,
		["853"] = 771,
		["855"] = 772,
		["856"] = 773,
		["858"] = 774,
		["859"] = 775,
		["860"] = 775,
		["863"] = 777,
		["865"] = 778,
		["866"] = 779,
		["867"] = 779,
		["870"] = 781,
		["872"] = 782,
		["873"] = 783,
		["874"] = 783,
		["877"] = 785,
		["879"] = 786,
		["880"] = 787,
		["881"] = 787,
		["884"] = 789,
		["886"] = 790,
		["887"] = 791,
		["888"] = 791,
		["891"] = 793,
		["893"] = 794,
		["894"] = 795,
		["895"] = 795,
		["898"] = 797,
		["900"] = 798,
		["901"] = 799,
		["902"] = 799,
		["905"] = 801,
		["907"] = 802,
		["908"] = 803,
		["909"] = 803,
		["912"] = 805,
		["914"] = 806,
		["915"] = 808,
		["916"] = 808,
		["919"] = 810,
		["921"] = 811,
		["922"] = 812,
		["923"] = 812,
		["926"] = 814,
		["928"] = 815,
		["929"] = 817,
		["930"] = 817,
		["933"] = 819,
		["935"] = 820,
		["936"] = 821,
		["937"] = 821,
		["940"] = 823,
		["942"] = 824,
		["943"] = 826,
		["944"] = 826,
		["948"] = 829,
		["949"] = 830,
		["950"] = 830,
		["951"] = 830,
		["952"] = 830,
		["953"] = 836,
		["954"] = 837,
		["955"] = 754,
		["956"] = 840,
		["957"] = 841,
		["958"] = 840,
		["959"] = 553,
		["960"] = 552,
		["961"] = 553,
		["963"] = 553,
		["964"] = 844,
		["965"] = 852,
		["966"] = 844,
		["967"] = 852,
		["968"] = 858,
		["969"] = 860,
		["970"] = 861,
		["971"] = 862,
		["972"] = 858,
		["973"] = 865,
		["974"] = 866,
		["975"] = 867,
		["976"] = 868,
		["977"] = 869,
		["979"] = 865,
		["980"] = 872,
		["981"] = 873,
		["982"] = 874,
		["983"] = 875,
		["985"] = 872,
		["986"] = 878,
		["987"] = 879,
		["988"] = 880,
		["989"] = 880,
		["990"] = 879,
		["991"] = 878,
		["992"] = 883,
		["993"] = 884,
		["994"] = 885,
		["995"] = 886,
		["996"] = 887,
		["997"] = 888,
		["999"] = 889,
		["1000"] = 889,
		["1001"] = 890,
		["1002"] = 891,
		["1003"] = 889,
		["1008"] = 883,
		["1009"] = 852,
		["1010"] = 844,
		["1011"] = 844,
		["1012"] = 844,
		["1013"] = 844,
		["1014"] = 844,
		["1015"] = 844,
		["1016"] = 844,
		["1017"] = 844,
		["1018"] = 852,
		["1020"] = 852,
		["1021"] = 897,
		["1022"] = 905,
		["1023"] = 897,
		["1024"] = 905,
		["1025"] = 906,
		["1026"] = 907,
		["1027"] = 906,
		["1028"] = 905,
		["1029"] = 897,
		["1030"] = 897,
		["1031"] = 897,
		["1032"] = 897,
		["1033"] = 897,
		["1034"] = 897,
		["1035"] = 897,
		["1036"] = 897,
		["1037"] = 905,
		["1039"] = 905,
		["1040"] = 914,
		["1041"] = 922,
		["1042"] = 914,
		["1043"] = 922,
		["1044"] = 932,
		["1045"] = 933,
		["1046"] = 934,
		["1047"] = 935,
		["1048"] = 936,
		["1050"] = 932,
		["1051"] = 940,
		["1052"] = 941,
		["1053"] = 941,
		["1054"] = 941,
		["1055"] = 941,
		["1056"] = 941,
		["1057"] = 941,
		["1058"] = 941,
		["1059"] = 941,
		["1060"] = 941,
		["1061"] = 941,
		["1062"] = 941,
		["1063"] = 941,
		["1064"] = 941,
		["1065"] = 941,
		["1066"] = 941,
		["1067"] = 940,
		["1068"] = 958,
		["1069"] = 959,
		["1070"] = 958,
		["1071"] = 961,
		["1072"] = 962,
		["1073"] = 961,
		["1074"] = 964,
		["1075"] = 965,
		["1076"] = 964,
		["1077"] = 967,
		["1078"] = 968,
		["1079"] = 967,
		["1080"] = 970,
		["1081"] = 971,
		["1082"] = 970,
		["1083"] = 973,
		["1084"] = 974,
		["1085"] = 973,
		["1086"] = 976,
		["1087"] = 977,
		["1088"] = 976,
		["1089"] = 979,
		["1090"] = 980,
		["1091"] = 979,
		["1092"] = 982,
		["1093"] = 983,
		["1094"] = 982,
		["1095"] = 985,
		["1096"] = 986,
		["1097"] = 985,
		["1098"] = 988,
		["1099"] = 989,
		["1100"] = 988,
		["1101"] = 992,
		["1102"] = 993,
		["1103"] = 992,
		["1104"] = 995,
		["1105"] = 996,
		["1106"] = 995,
		["1107"] = 998,
		["1108"] = 999,
		["1109"] = 999,
		["1111"] = 1000,
		["1112"] = 1001,
		["1114"] = 1003,
		["1116"] = 998,
		["1117"] = 1007,
		["1118"] = 1008,
		["1119"] = 1007,
		["1120"] = 1012,
		["1121"] = 1013,
		["1122"] = 1012,
		["1123"] = 922,
		["1124"] = 914,
		["1125"] = 914,
		["1126"] = 914,
		["1127"] = 914,
		["1128"] = 914,
		["1129"] = 914,
		["1130"] = 914,
		["1131"] = 914,
		["1132"] = 922,
		["1134"] = 922,
		["1136"] = 1018,
		["1137"] = 1019,
		["1138"] = 1018,
		["1139"] = 1019,
		["1140"] = 1020,
		["1141"] = 1020,
		["1142"] = 1020,
		["1144"] = 1021,
		["1145"] = 1022,
		["1146"] = 1023,
		["1147"] = 1024,
		["1148"] = 1025,
		["1149"] = 1026,
		["1150"] = 1027,
		["1151"] = 1027,
		["1152"] = 1027,
		["1153"] = 1028,
		["1154"] = 1029,
		["1155"] = 1030,
		["1156"] = 1031,
		["1158"] = 1027,
		["1159"] = 1027,
		["1160"] = 1020,
		["1161"] = 1035,
		["1162"] = 1035,
		["1163"] = 1035,
		["1165"] = 1035,
		["1166"] = 1035,
		["1168"] = 1036,
		["1169"] = 1037,
		["1170"] = 1038,
		["1171"] = 1039,
		["1172"] = 1040,
		["1173"] = 1041,
		["1174"] = 1042,
		["1175"] = 1042,
		["1176"] = 1042,
		["1177"] = 1042,
		["1178"] = 1042,
		["1179"] = 1042,
		["1180"] = 1042,
		["1181"] = 1042,
		["1182"] = 1042,
		["1183"] = 1042,
		["1184"] = 1052,
		["1185"] = 1053,
		["1186"] = 1054,
		["1187"] = 1055,
		["1189"] = 1042,
		["1190"] = 1042,
		["1192"] = 1035,
		["1193"] = 1019,
		["1194"] = 1018,
		["1195"] = 1019,
		["1197"] = 1019,
		["1199"] = 1065,
		["1200"] = 1066,
		["1201"] = 1065,
		["1202"] = 1066,
		["1203"] = 1067,
		["1204"] = 1068,
		["1205"] = 1067,
		["1206"] = 1066,
		["1207"] = 1065,
		["1208"] = 1066,
		["1210"] = 1066,
		["1211"] = 1071,
		["1212"] = 1079,
		["1213"] = 1071,
		["1214"] = 1079,
		["1215"] = 1081,
		["1216"] = 1082,
		["1217"] = 1081,
		["1218"] = 1084,
		["1219"] = 1085,
		["1220"] = 1084,
		["1221"] = 1079,
		["1222"] = 1071,
		["1223"] = 1071,
		["1224"] = 1071,
		["1225"] = 1071,
		["1226"] = 1071,
		["1227"] = 1071,
		["1228"] = 1071,
		["1229"] = 1071,
		["1230"] = 1079,
		["1232"] = 1079,
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
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function x.prototype.OnRoundChange(self)
	self.disable = false
end
function x.prototype.OnPrepare(self, y)
	if self.disable then
		return
	end
	self.disable = true
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