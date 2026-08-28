--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/zombie_guitarist"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__Delete
local h = b.__TS__ArraySort
local i = b.__TS__StringSplit
local j = b.__TS__Number
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 227,
		["14"] = 1,
		["15"] = 1,
		["16"] = 1,
		["17"] = 2,
		["18"] = 2,
		["19"] = 2,
		["20"] = 3,
		["21"] = 3,
		["22"] = 3,
		["23"] = 6,
		["24"] = 6,
		["25"] = 6,
		["26"] = 6,
		["27"] = 6,
		["28"] = 6,
		["29"] = 6,
		["30"] = 6,
		["31"] = 14,
		["32"] = 14,
		["33"] = 14,
		["34"] = 14,
		["35"] = 14,
		["36"] = 14,
		["37"] = 14,
		["38"] = 14,
		["39"] = 23,
		["40"] = 24,
		["41"] = 23,
		["42"] = 24,
		["43"] = 26,
		["44"] = 27,
		["45"] = 26,
		["46"] = 24,
		["47"] = 23,
		["48"] = 24,
		["50"] = 24,
		["51"] = 31,
		["52"] = 39,
		["53"] = 31,
		["54"] = 39,
		["55"] = 53,
		["56"] = 54,
		["57"] = 55,
		["58"] = 56,
		["59"] = 57,
		["60"] = 58,
		["61"] = 59,
		["62"] = 60,
		["63"] = 62,
		["64"] = 64,
		["65"] = 65,
		["66"] = 66,
		["67"] = 67,
		["69"] = 53,
		["70"] = 70,
		["71"] = 71,
		["72"] = 71,
		["73"] = 71,
		["74"] = 74,
		["75"] = 74,
		["76"] = 74,
		["77"] = 71,
		["78"] = 75,
		["79"] = 75,
		["80"] = 75,
		["81"] = 71,
		["82"] = 71,
		["83"] = 70,
		["84"] = 78,
		["85"] = 79,
		["86"] = 80,
		["87"] = 81,
		["88"] = 82,
		["89"] = 82,
		["91"] = 78,
		["92"] = 85,
		["93"] = 86,
		["94"] = 87,
		["96"] = 85,
		["97"] = 90,
		["98"] = 91,
		["99"] = 92,
		["101"] = 90,
		["102"] = 95,
		["103"] = 96,
		["104"] = 97,
		["106"] = 95,
		["107"] = 100,
		["108"] = 101,
		["111"] = 102,
		["112"] = 103,
		["114"] = 100,
		["115"] = 106,
		["116"] = 107,
		["117"] = 109,
		["118"] = 110,
		["120"] = 111,
		["121"] = 111,
		["122"] = 112,
		["123"] = 113,
		["125"] = 111,
		["128"] = 116,
		["129"] = 117,
		["132"] = 120,
		["133"] = 121,
		["134"] = 122,
		["135"] = 125,
		["136"] = 126,
		["137"] = 126,
		["138"] = 126,
		["139"] = 126,
		["140"] = 126,
		["141"] = 126,
		["142"] = 129,
		["143"] = 130,
		["144"] = 131,
		["145"] = 132,
		["146"] = 132,
		["147"] = 132,
		["148"] = 132,
		["149"] = 132,
		["150"] = 132,
		["151"] = 135,
		["152"] = 136,
		["153"] = 136,
		["154"] = 136,
		["155"] = 136,
		["156"] = 136,
		["157"] = 136,
		["158"] = 139,
		["159"] = 140,
		["160"] = 140,
		["161"] = 140,
		["162"] = 140,
		["163"] = 140,
		["164"] = 140,
		["165"] = 143,
		["166"] = 144,
		["167"] = 144,
		["168"] = 144,
		["169"] = 144,
		["170"] = 144,
		["171"] = 144,
		["173"] = 148,
		["174"] = 148,
		["175"] = 148,
		["176"] = 148,
		["177"] = 148,
		["178"] = 149,
		["179"] = 150,
		["180"] = 151,
		["181"] = 152,
		["182"] = 153,
		["183"] = 154,
		["184"] = 155,
		["185"] = 155,
		["186"] = 156,
		["187"] = 157,
		["188"] = 158,
		["189"] = 159,
		["190"] = 160,
		["191"] = 161,
		["192"] = 162,
		["193"] = 162,
		["194"] = 162,
		["195"] = 163,
		["196"] = 164,
		["198"] = 162,
		["199"] = 162,
		["205"] = 106,
		["206"] = 173,
		["207"] = 174,
		["208"] = 175,
		["209"] = 176,
		["210"] = 179,
		["212"] = 182,
		["213"] = 182,
		["214"] = 183,
		["215"] = 182,
		["218"] = 185,
		["219"] = 187,
		["221"] = 189,
		["222"] = 189,
		["223"] = 189,
		["224"] = 189,
		["225"] = 189,
		["226"] = 189,
		["227"] = 189,
		["228"] = 189,
		["229"] = 189,
		["230"] = 193,
		["231"] = 196,
		["232"] = 196,
		["233"] = 196,
		["234"] = 196,
		["235"] = 196,
		["236"] = 196,
		["237"] = 196,
		["238"] = 196,
		["239"] = 196,
		["240"] = 200,
		["241"] = 200,
		["242"] = 200,
		["243"] = 200,
		["244"] = 200,
		["245"] = 200,
		["246"] = 200,
		["247"] = 200,
		["248"] = 200,
		["249"] = 204,
		["250"] = 204,
		["251"] = 204,
		["252"] = 204,
		["253"] = 204,
		["254"] = 204,
		["255"] = 204,
		["256"] = 204,
		["257"] = 204,
		["258"] = 208,
		["259"] = 208,
		["260"] = 208,
		["261"] = 208,
		["262"] = 208,
		["263"] = 208,
		["264"] = 208,
		["265"] = 208,
		["266"] = 208,
		["267"] = 173,
		["268"] = 213,
		["269"] = 214,
		["270"] = 215,
		["271"] = 216,
		["272"] = 217,
		["273"] = 218,
		["275"] = 220,
		["276"] = 224,
		["277"] = 213,
		["278"] = 39,
		["279"] = 31,
		["280"] = 31,
		["281"] = 31,
		["282"] = 31,
		["283"] = 31,
		["284"] = 31,
		["285"] = 31,
		["286"] = 31,
		["287"] = 39,
		["289"] = 39,
		["290"] = 227,
		["291"] = 228,
		["292"] = 229,
		["293"] = 230,
		["294"] = 231,
		["295"] = 232,
		["296"] = 233,
		["297"] = 234,
		["298"] = 235,
		["299"] = 236,
		["300"] = 237,
		["301"] = 238,
		["302"] = 239,
		["303"] = 240,
		["304"] = 241,
		["305"] = 242,
		["306"] = 243,
		["307"] = 244,
		["308"] = 245,
		["309"] = 246,
		["310"] = 247,
		["311"] = 248,
		["312"] = 249,
		["313"] = 250,
		["314"] = 251,
		["315"] = 252,
		["316"] = 253,
		["317"] = 254,
		["318"] = 255,
		["319"] = 256,
		["320"] = 257,
		["321"] = 258,
		["322"] = 259,
		["323"] = 260,
		["324"] = 261,
		["325"] = 262,
		["326"] = 263,
		["327"] = 264,
		["328"] = 265,
		["329"] = 266,
		["333"] = 270,
		["334"] = 271,
		["335"] = 271,
		["336"] = 271,
		["337"] = 271,
		["338"] = 271,
		["339"] = 271,
		["340"] = 271,
		["341"] = 271,
		["342"] = 271,
		["343"] = 272,
		["344"] = 227,
		["346"] = 275,
		["347"] = 284,
		["348"] = 275,
		["349"] = 284,
		["351"] = 284,
		["352"] = 288,
		["353"] = 275,
		["354"] = 298,
		["355"] = 299,
		["356"] = 300,
		["357"] = 301,
		["358"] = 306,
		["359"] = 298,
		["360"] = 325,
		["361"] = 326,
		["362"] = 327,
		["363"] = 328,
		["364"] = 329,
		["367"] = 332,
		["368"] = 333,
		["369"] = 334,
		["370"] = 335,
		["371"] = 335,
		["374"] = 325,
		["375"] = 349,
		["376"] = 350,
		["377"] = 351,
		["379"] = 349,
		["380"] = 364,
		["381"] = 365,
		["382"] = 366,
		["383"] = 367,
		["384"] = 369,
		["385"] = 370,
		["388"] = 373,
		["389"] = 374,
		["390"] = 375,
		["391"] = 376,
		["393"] = 378,
		["394"] = 379,
		["395"] = 380,
		["396"] = 380,
		["397"] = 380,
		["398"] = 380,
		["399"] = 380,
		["400"] = 380,
		["401"] = 380,
		["405"] = 364,
		["406"] = 385,
		["407"] = 386,
		["408"] = 385,
		["409"] = 390,
		["410"] = 391,
		["411"] = 390,
		["412"] = 284,
		["413"] = 275,
		["414"] = 275,
		["415"] = 275,
		["416"] = 275,
		["417"] = 275,
		["418"] = 275,
		["419"] = 275,
		["420"] = 275,
		["421"] = 275,
		["422"] = 284,
		["424"] = 284,
		["426"] = 396,
		["427"] = 404,
		["428"] = 396,
		["429"] = 404,
		["430"] = 405,
		["431"] = 406,
		["432"] = 407,
		["434"] = 405,
		["435"] = 421,
		["436"] = 422,
		["437"] = 423,
		["439"] = 421,
		["440"] = 404,
		["441"] = 396,
		["442"] = 396,
		["443"] = 396,
		["444"] = 396,
		["445"] = 396,
		["446"] = 396,
		["447"] = 396,
		["448"] = 396,
		["449"] = 404,
		["451"] = 404,
		["453"] = 429,
		["454"] = 438,
		["455"] = 429,
		["456"] = 438,
		["458"] = 438,
		["459"] = 445,
		["460"] = 429,
		["461"] = 446,
		["462"] = 447,
		["463"] = 449,
		["464"] = 446,
		["465"] = 451,
		["466"] = 452,
		["467"] = 451,
		["468"] = 456,
		["469"] = 457,
		["470"] = 456,
		["471"] = 462,
		["472"] = 463,
		["473"] = 464,
		["474"] = 465,
		["475"] = 466,
		["476"] = 466,
		["477"] = 467,
		["480"] = 462,
		["481"] = 480,
		["482"] = 481,
		["483"] = 482,
		["485"] = 480,
		["486"] = 495,
		["487"] = 496,
		["488"] = 495,
		["489"] = 500,
		["490"] = 501,
		["491"] = 502,
		["492"] = 503,
		["494"] = 505,
		["495"] = 500,
		["496"] = 438,
		["497"] = 429,
		["498"] = 429,
		["499"] = 429,
		["500"] = 429,
		["501"] = 429,
		["502"] = 429,
		["503"] = 429,
		["504"] = 429,
		["505"] = 429,
		["506"] = 438,
		["508"] = 438,
		["510"] = 510,
		["511"] = 519,
		["512"] = 510,
		["513"] = 519,
		["514"] = 525,
		["515"] = 526,
		["516"] = 527,
		["517"] = 529,
		["518"] = 525,
		["519"] = 531,
		["520"] = 532,
		["521"] = 533,
		["522"] = 534,
		["523"] = 535,
		["524"] = 536,
		["525"] = 536,
		["528"] = 531,
		["529"] = 551,
		["530"] = 552,
		["531"] = 553,
		["533"] = 551,
		["534"] = 556,
		["535"] = 557,
		["536"] = 558,
		["537"] = 559,
		["538"] = 560,
		["540"] = 562,
		["541"] = 562,
		["542"] = 562,
		["543"] = 562,
		["544"] = 562,
		["545"] = 562,
		["547"] = 556,
		["548"] = 519,
		["549"] = 510,
		["550"] = 510,
		["551"] = 510,
		["552"] = 510,
		["553"] = 510,
		["554"] = 510,
		["555"] = 510,
		["556"] = 510,
		["557"] = 510,
		["558"] = 519,
		["560"] = 519,
		["562"] = 568,
		["563"] = 577,
		["564"] = 568,
		["565"] = 577,
		["567"] = 577,
		["568"] = 582,
		["569"] = 568,
		["570"] = 583,
		["571"] = 585,
		["572"] = 586,
		["573"] = 588,
		["574"] = 583,
		["575"] = 590,
		["576"] = 591,
		["577"] = 592,
		["578"] = 593,
		["579"] = 595,
		["580"] = 596,
		["581"] = 596,
		["584"] = 590,
		["585"] = 600,
		["586"] = 601,
		["587"] = 602,
		["588"] = 603,
		["590"] = 600,
		["591"] = 606,
		["592"] = 608,
		["593"] = 608,
		["594"] = 608,
		["595"] = 608,
		["596"] = 606,
		["597"] = 610,
		["598"] = 611,
		["599"] = 610,
		["600"] = 615,
		["601"] = 616,
		["602"] = 617,
		["603"] = 618,
		["605"] = 620,
		["606"] = 615,
		["607"] = 577,
		["608"] = 568,
		["609"] = 568,
		["610"] = 568,
		["611"] = 568,
		["612"] = 568,
		["613"] = 568,
		["614"] = 568,
		["615"] = 568,
		["616"] = 568,
		["617"] = 577,
		["619"] = 577,
		["621"] = 640,
		["622"] = 648,
		["623"] = 640,
		["624"] = 648,
		["625"] = 650,
		["626"] = 651,
		["627"] = 650,
		["628"] = 653,
		["629"] = 654,
		["630"] = 655,
		["632"] = 653,
		["633"] = 658,
		["634"] = 659,
		["635"] = 660,
		["637"] = 658,
		["638"] = 663,
		["639"] = 664,
		["640"] = 663,
		["641"] = 668,
		["642"] = 669,
		["643"] = 668,
		["644"] = 648,
		["645"] = 640,
		["646"] = 640,
		["647"] = 640,
		["648"] = 640,
		["649"] = 640,
		["650"] = 640,
		["651"] = 640,
		["652"] = 640,
		["653"] = 648,
		["655"] = 648,
		["657"] = 674,
		["658"] = 683,
		["659"] = 674,
		["660"] = 683,
		["662"] = 683,
		["663"] = 687,
		["664"] = 674,
		["665"] = 694,
		["666"] = 695,
		["667"] = 696,
		["668"] = 697,
		["669"] = 699,
		["670"] = 694,
		["671"] = 701,
		["672"] = 702,
		["673"] = 703,
		["674"] = 704,
		["675"] = 705,
		["678"] = 708,
		["679"] = 709,
		["680"] = 710,
		["681"] = 711,
		["682"] = 711,
		["685"] = 701,
		["686"] = 715,
		["687"] = 716,
		["688"] = 717,
		["690"] = 715,
		["691"] = 720,
		["692"] = 721,
		["693"] = 722,
		["694"] = 723,
		["695"] = 725,
		["696"] = 726,
		["699"] = 729,
		["700"] = 730,
		["701"] = 731,
		["702"] = 732,
		["704"] = 734,
		["705"] = 735,
		["706"] = 736,
		["710"] = 720,
		["711"] = 741,
		["712"] = 742,
		["713"] = 741,
		["714"] = 683,
		["715"] = 674,
		["716"] = 674,
		["717"] = 674,
		["718"] = 674,
		["719"] = 674,
		["720"] = 674,
		["721"] = 674,
		["722"] = 674,
		["723"] = 674,
		["724"] = 683,
		["726"] = 683,
		["728"] = 748,
		["729"] = 756,
		["730"] = 748,
		["731"] = 756,
		["732"] = 757,
		["733"] = 758,
		["734"] = 759,
		["736"] = 757,
		["737"] = 762,
		["738"] = 763,
		["739"] = 764,
		["741"] = 762,
		["742"] = 767,
		["743"] = 768,
		["744"] = 767,
		["745"] = 775,
		["746"] = 776,
		["747"] = 775,
		["748"] = 778,
		["749"] = 779,
		["750"] = 778,
		["751"] = 781,
		["752"] = 782,
		["753"] = 781,
		["754"] = 784,
		["755"] = 785,
		["756"] = 784,
		["757"] = 756,
		["758"] = 748,
		["759"] = 748,
		["760"] = 748,
		["761"] = 748,
		["762"] = 748,
		["763"] = 748,
		["764"] = 748,
		["765"] = 748,
		["766"] = 756,
		["768"] = 756,
		["772"] = 791,
		["774"] = 797,
		["775"] = 807,
		["776"] = 797,
		["777"] = 807,
		["779"] = 807,
		["780"] = 808,
		["781"] = 797,
		["782"] = 811,
		["783"] = 812,
		["784"] = 813,
		["785"] = 814,
		["786"] = 815,
		["788"] = 817,
		["789"] = 818,
		["790"] = 819,
		["791"] = 819,
		["792"] = 819,
		["793"] = 819,
		["794"] = 820,
		["795"] = 821,
		["796"] = 822,
		["797"] = 822,
		["798"] = 822,
		["799"] = 822,
		["800"] = 822,
		["801"] = 822,
		["802"] = 822,
		["803"] = 822,
		["804"] = 822,
		["805"] = 822,
		["806"] = 822,
		["807"] = 822,
		["808"] = 823,
		["809"] = 823,
		["810"] = 823,
		["811"] = 823,
		["812"] = 823,
		["813"] = 824,
		["814"] = 824,
		["815"] = 824,
		["816"] = 824,
		["817"] = 824,
		["818"] = 825,
		["819"] = 825,
		["820"] = 825,
		["821"] = 825,
		["822"] = 825,
		["823"] = 825,
		["824"] = 825,
		["825"] = 825,
		["827"] = 811,
		["828"] = 828,
		["829"] = 829,
		["830"] = 830,
		["831"] = 831,
		["833"] = 833,
		["834"] = 834,
		["835"] = 835,
		["837"] = 837,
		["838"] = 838,
		["839"] = 839,
		["840"] = 839,
		["841"] = 839,
		["842"] = 839,
		["843"] = 840,
		["844"] = 841,
		["845"] = 842,
		["846"] = 842,
		["847"] = 842,
		["848"] = 842,
		["849"] = 842,
		["850"] = 842,
		["851"] = 842,
		["852"] = 842,
		["853"] = 842,
		["854"] = 842,
		["855"] = 842,
		["856"] = 842,
		["858"] = 828,
		["859"] = 845,
		["860"] = 846,
		["861"] = 847,
		["862"] = 848,
		["863"] = 849,
		["864"] = 850,
		["865"] = 851,
		["866"] = 853,
		["868"] = 854,
		["869"] = 854,
		["870"] = 855,
		["871"] = 854,
		["877"] = 845,
		["878"] = 861,
		["879"] = 862,
		["880"] = 863,
		["881"] = 864,
		["882"] = 864,
		["883"] = 864,
		["884"] = 864,
		["886"] = 865,
		["887"] = 865,
		["888"] = 866,
		["889"] = 867,
		["890"] = 868,
		["891"] = 868,
		["892"] = 868,
		["893"] = 868,
		["894"] = 868,
		["895"] = 869,
		["897"] = 865,
		["902"] = 861,
		["903"] = 875,
		["904"] = 876,
		["905"] = 875,
		["906"] = 881,
		["907"] = 882,
		["908"] = 881,
		["909"] = 884,
		["910"] = 885,
		["911"] = 884,
		["912"] = 807,
		["913"] = 797,
		["914"] = 797,
		["915"] = 797,
		["916"] = 797,
		["917"] = 797,
		["918"] = 797,
		["919"] = 797,
		["920"] = 797,
		["921"] = 797,
		["922"] = 797,
		["923"] = 807,
		["925"] = 807,
		["927"] = 889,
		["928"] = 897,
		["929"] = 889,
		["930"] = 897,
		["931"] = 898,
		["932"] = 899,
		["933"] = 900,
		["934"] = 900,
		["935"] = 900,
		["936"] = 900,
		["937"] = 900,
		["938"] = 900,
		["939"] = 900,
		["940"] = 900,
		["941"] = 900,
		["942"] = 900,
		["943"] = 900,
		["944"] = 900,
		["946"] = 898,
		["947"] = 897,
		["948"] = 889,
		["949"] = 889,
		["950"] = 889,
		["951"] = 889,
		["952"] = 889,
		["953"] = 889,
		["954"] = 889,
		["955"] = 889,
		["956"] = 897,
		["958"] = 897,
		["960"] = 905,
		["961"] = 913,
		["962"] = 905,
		["963"] = 913,
		["964"] = 914,
		["965"] = 915,
		["966"] = 916,
		["967"] = 916,
		["968"] = 916,
		["969"] = 916,
		["970"] = 916,
		["971"] = 916,
		["972"] = 916,
		["973"] = 916,
		["974"] = 916,
		["975"] = 916,
		["976"] = 916,
		["977"] = 916,
		["979"] = 914,
		["980"] = 913,
		["981"] = 905,
		["982"] = 905,
		["983"] = 905,
		["984"] = 905,
		["985"] = 905,
		["986"] = 905,
		["987"] = 905,
		["988"] = 905,
		["989"] = 913,
		["991"] = 913,
		["993"] = 921,
		["994"] = 929,
		["995"] = 921,
		["996"] = 929,
		["997"] = 930,
		["998"] = 931,
		["999"] = 932,
		["1000"] = 932,
		["1001"] = 932,
		["1002"] = 932,
		["1003"] = 932,
		["1004"] = 932,
		["1005"] = 932,
		["1006"] = 932,
		["1007"] = 932,
		["1008"] = 932,
		["1009"] = 932,
		["1010"] = 932,
		["1012"] = 930,
		["1013"] = 929,
		["1014"] = 921,
		["1015"] = 921,
		["1016"] = 921,
		["1017"] = 921,
		["1018"] = 921,
		["1019"] = 921,
		["1020"] = 921,
		["1021"] = 921,
		["1022"] = 929,
		["1024"] = 929,
		["1026"] = 937,
		["1027"] = 945,
		["1028"] = 937,
		["1029"] = 945,
		["1030"] = 946,
		["1031"] = 947,
		["1032"] = 948,
		["1033"] = 948,
		["1034"] = 948,
		["1035"] = 948,
		["1036"] = 948,
		["1037"] = 948,
		["1038"] = 948,
		["1039"] = 948,
		["1040"] = 948,
		["1041"] = 948,
		["1042"] = 948,
		["1043"] = 948,
		["1045"] = 946,
		["1046"] = 945,
		["1047"] = 937,
		["1048"] = 937,
		["1049"] = 937,
		["1050"] = 937,
		["1051"] = 937,
		["1052"] = 937,
		["1053"] = 937,
		["1054"] = 937,
		["1055"] = 945,
		["1057"] = 945,
		["1059"] = 953,
		["1060"] = 961,
		["1061"] = 953,
		["1062"] = 961,
		["1063"] = 962,
		["1064"] = 963,
		["1065"] = 964,
		["1066"] = 964,
		["1067"] = 964,
		["1068"] = 964,
		["1069"] = 964,
		["1070"] = 964,
		["1071"] = 964,
		["1072"] = 964,
		["1073"] = 964,
		["1074"] = 964,
		["1075"] = 964,
		["1076"] = 964,
		["1078"] = 962,
		["1079"] = 961,
		["1080"] = 953,
		["1081"] = 953,
		["1082"] = 953,
		["1083"] = 953,
		["1084"] = 953,
		["1085"] = 953,
		["1086"] = 953,
		["1087"] = 953,
		["1088"] = 961,
		["1090"] = 961,
		["1092"] = 969,
		["1093"] = 977,
		["1094"] = 969,
		["1095"] = 977,
		["1096"] = 978,
		["1097"] = 979,
		["1098"] = 980,
		["1099"] = 980,
		["1100"] = 980,
		["1101"] = 980,
		["1102"] = 980,
		["1103"] = 980,
		["1104"] = 980,
		["1105"] = 980,
		["1106"] = 980,
		["1107"] = 980,
		["1108"] = 980,
		["1109"] = 980,
		["1111"] = 978,
		["1112"] = 977,
		["1113"] = 969,
		["1114"] = 969,
		["1115"] = 969,
		["1116"] = 969,
		["1117"] = 969,
		["1118"] = 969,
		["1119"] = 969,
		["1120"] = 969,
		["1121"] = 977,
		["1123"] = 977,
		["1124"] = 986,
		["1125"] = 987,
		["1126"] = 986,
		["1127"] = 987,
		["1128"] = 988,
		["1129"] = 989,
		["1130"] = 990,
		["1131"] = 991,
		["1134"] = 994,
		["1135"] = 995,
		["1136"] = 997,
		["1137"] = 998,
		["1138"] = 999,
		["1139"] = 999,
		["1140"] = 999,
		["1141"] = 999,
		["1142"] = 999,
		["1143"] = 999,
		["1144"] = 999,
		["1145"] = 1000,
		["1147"] = 1001,
		["1148"] = 1001,
		["1149"] = 1002,
		["1150"] = 1001,
		["1153"] = 1004,
		["1154"] = 1005,
		["1155"] = 1007,
		["1156"] = 1008,
		["1157"] = 1009,
		["1158"] = 1014,
		["1159"] = 1015,
		["1163"] = 988,
		["1164"] = 987,
		["1165"] = 986,
		["1166"] = 987,
		["1168"] = 987,
	}
)
local l = {}
local m
local n = require("lib.dota_ts_adapter")
local o = n.BaseAbility
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
local t = require("abilities.ability_ai")
local u = t.BaseAbilityAI
local v = t.registerAbilityAI
local w = { "red", "orange", "yellow", "green", "blue", "purple" }
local x = {
	"modifier_zombie_guitarist_red_record",
	"modifier_zombie_guitarist_orange_record",
	"modifier_zombie_guitarist_yellow_record",
	"modifier_zombie_guitarist_green_record",
	"modifier_zombie_guitarist_blue_record",
	"modifier_zombie_guitarist_purple_record",
}
l.zombie_guitarist_talent = c()
local y = l.zombie_guitarist_talent
y.name = "zombie_guitarist_talent"
d(y, o)
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_zombie_guitarist_talent"
end
y = e({ p(nil) }, y)
l.zombie_guitarist_talent = y
l.modifier_zombie_guitarist_talent = c()
local z = l.modifier_zombie_guitarist_talent
z.name = "modifier_zombie_guitarist_talent"
d(z, r)
function z.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("zombie_guitarist_talent_5", "chance")
		+ self:GetAbilityTalentValue("zombie_guitarist_talent_3", "chance")
	self.r_duration = self:GetAbilitySpecialValueFor("r_duration")
	self.y_duration = self:GetAbilitySpecialValueFor("y_duration")
	self.g_duration = self:GetAbilitySpecialValueFor("g_duration")
	self.b_duration = self:GetAbilitySpecialValueFor("b_duration")
	self.p_duration = self:GetAbilitySpecialValueFor("p_duration")
	self.o_bonus = self:GetAbilitySpecialValueFor("o_bonus")
	self.tl1_tick = self:GetAbilityTalentValue("zombie_guitarist_talent_1", "tick")
	self.tl8_bonus_pct = self:GetAbilityTalentValue("zombie_guitarist_talent_8", "bonus_pct")
	if IsServer() then
		self.playedRecord = {}
		self.isAllPlayed = false
	end
end
function z.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function z.prototype.OnBattleStartBefore(self, A)
	local B = self:GetAbility()
	B.note_record = {}
	if self.tl8_bonus_pct > 0 then
		local C = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		self.heroLevel = C and C.heroLevel or 1
	end
end
function z.prototype.OnBattleStart(self, A)
	if self.tl1_tick > 0 then
		self:StartThink(self.tl1_tick, "tl1")
	end
end
function z.prototype.OnBattleEnd(self, A)
	if self.tl1_tick > 0 then
		self:StartThink(-1, "tl1")
	end
end
function z.prototype.OnThink(self, D)
	if D == "tl1" then
		self:playRandomNote()
	end
end
function z.prototype.OnCustomTakeDamage(self, E)
	if self.parent:PassivesDisabled() then
		return
	end
	if self:PRD(self.chance) then
		self:playRandomNote()
	end
end
function z.prototype.playRandomNote(self, F)
	local G = w[math.random(0, #w - 1) + 1]
	if self:HasTalent("zombie_guitarist_talent_2") and F then
		local H = shallowcopy(w)
		do
			local I = #H - 1
			while I >= 0 do
				if f(self.playedRecord, H[I + 1]) then
					table.remove(H, I + 1)
				end
				I = I - 1
			end
		end
		if #H > 0 then
			G = H[math.random(0, #H - 1) + 1]
		end
	end
	local J = self:GetParent()
	local B = self:GetAbility()
	J:AddNewModifier(J, nil, "modifier_zombie_guitarist_ranged", { duration = 1 })
	if G == "red" then
		J:AddNewModifier(
			J,
			B,
			"modifier_zombie_guitarist_red",
			{ duration = self:getNoteBuffDuration(self.r_duration) }
		)
	elseif G == "orange" then
		J:AddNewModifier(J, B, "modifier_zombie_guitarist_orange", nil)
	elseif G == "yellow" then
		J:AddNewModifier(
			J,
			B,
			"modifier_zombie_guitarist_yellow",
			{ duration = self:getNoteBuffDuration(self.y_duration) }
		)
	elseif G == "green" then
		J:AddNewModifier(
			J,
			B,
			"modifier_zombie_guitarist_green",
			{ duration = self:getNoteBuffDuration(self.g_duration) }
		)
	elseif G == "blue" then
		J:AddNewModifier(
			J,
			B,
			"modifier_zombie_guitarist_blue",
			{ duration = self:getNoteBuffDuration(self.b_duration) }
		)
	elseif G == "purple" then
		J:AddNewModifier(
			J,
			B,
			"modifier_zombie_guitarist_purple",
			{ duration = self:getNoteBuffDuration(self.p_duration) }
		)
	end
	local K = m(nil, G, self:GetParent())
	ParticleManager:ReleaseParticleIndex(K)
	if not J:HasModifier("modifier_zombie_guitarist_all_record") then
		J:EmitSound("Hero_DoomBringer.InfernalBlade.ShredLayer")
		J:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_2, 0.06, 0.2)
		J:AddNewModifier(J, B, ("modifier_zombie_guitarist_" .. G) .. "_record", nil)
		if not f(self.playedRecord, G) then
			local L = self.playedRecord
			L[#L + 1] = G
			if #self.playedRecord == #w then
				self.isAllPlayed = true
				self.playedRecord = {}
				if self:HasTalent("zombie_guitarist_talent_3") then
					local M = J:FindAbilityByName("zombie_guitarist_ult")
					if IsValid(M) then
						M:GameTimer(FRAME_TIME, function()
							if IsValid(M) then
								M:OnSpellStart()
							end
						end)
					end
				end
			end
		end
	end
end
function z.prototype.playerAllNote(self, N)
	local J = self:GetParent()
	local B = self:GetAbility()
	J:AddNewModifier(J, nil, "modifier_zombie_guitarist_ranged", { duration = N })
	J:AddNewModifier(J, B, "modifier_zombie_guitarist_all_record", { duration = N })
	do
		local I = 0
		while I < #x do
			J:RemoveModifierByName(x[I + 1])
			I = I + 1
		end
	end
	if not self:HasTalent("zombie_guitarist_talent_2") then
		self.isAllPlayed = false
	end
	J:AddNewModifier(
		J,
		B,
		"modifier_zombie_guitarist_red",
		{ duration = self:getNoteBuffDuration(self.r_duration), isAll = 1 }
	)
	J:AddNewModifier(J, B, "modifier_zombie_guitarist_orange", { isAll = 1 })
	J:AddNewModifier(
		J,
		B,
		"modifier_zombie_guitarist_green",
		{ duration = self:getNoteBuffDuration(self.g_duration), isAll = 1 }
	)
	J:AddNewModifier(
		J,
		B,
		"modifier_zombie_guitarist_blue",
		{ duration = self:getNoteBuffDuration(self.b_duration), isAll = 1 }
	)
	J:AddNewModifier(
		J,
		B,
		"modifier_zombie_guitarist_purple",
		{ duration = self:getNoteBuffDuration(self.p_duration), isAll = 1 }
	)
	J:AddNewModifier(
		J,
		B,
		"modifier_zombie_guitarist_yellow",
		{ duration = self:getNoteBuffDuration(self.y_duration), isAll = 1 }
	)
end
function z.prototype.getNoteBuffDuration(self, O)
	local P = self:GetParent():FindModifierByName("modifier_zombie_guitarist_orange")
	local Q = 0
	if IsValid(P) then
		Q = P:GetStackCount()
		P:Destroy()
	end
	local R = O + Q * self.o_bonus
	return R
end
z = e(
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
	z
)
l.modifier_zombie_guitarist_talent = z
m = function(S, T, J)
	local U
	if T == "red" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_01.vpcf"
	elseif T == "orange" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_02.vpcf"
	elseif T == "yellow" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_03.vpcf"
	elseif T == "green" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_04.vpcf"
	elseif T == "blue" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_05.vpcf"
	elseif T == "purple" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_06.vpcf"
	elseif T == "red_record" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_yf_01.vpcf"
	elseif T == "orange_record" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_yf_02.vpcf"
	elseif T == "yellow_record" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_yf_03.vpcf"
	elseif T == "green_record" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_yf_04.vpcf"
	elseif T == "blue_record" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_yf_05.vpcf"
	elseif T == "purple_record" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_yf_06.vpcf"
	elseif T == "red_ult" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_ultimate_01.vpcf"
	elseif T == "orange_ult" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_ultimate_02.vpcf"
	elseif T == "yellow_ult" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_ultimate_03.vpcf"
	elseif T == "green_ult" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_ultimate_04.vpcf"
	elseif T == "blue_ult" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_ultimate_05.vpcf"
	elseif T == "purple_ult" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_ultimate_06.vpcf"
	elseif T == "all" then
		U = "models/eom/hero/life_stealer_1/particles/life_stealer_1_skill_1_fx.vpcf"
	else
		return
	end
	local K = ParticleManager:CreateParticle(U, PATTACH_ABSORIGIN_FOLLOW, J)
	ParticleManager:SetParticleControlEnt(K, 3, J, PATTACH_ABSORIGIN_FOLLOW, nil, J:GetAbsOrigin(), true)
	return K
end
l.modifier_zombie_guitarist_red = c()
local V = l.modifier_zombie_guitarist_red
V.name = "modifier_zombie_guitarist_red"
d(V, r)
function V.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.DebuffList = { sect_poison = AddPoison, sect_injury = AddInjury, sect_ice = AddIce }
end
function V.prototype.GetAbilitySpecialValue(self)
	self.r_tick = self:GetAbilitySpecialValueFor("r_tick")
	self.r_buff = self:GetAbilitySpecialValueFor("r_buff")
		+ self:GetAbilityTalentValue("zombie_guitarist_shard", "count")
	self.r_damage_pct = self:GetAbilitySpecialValueFor("r_damage_pct")
	self.tl8_bonus_pct = self:GetAbilityTalentValue("zombie_guitarist_talent_8", "bonus_pct")
end
function V.prototype.OnCreated(self, A)
	if IsServer() then
		for W, R in pairs(self.DebuffList) do
			if f(AbilityShop.banList, W) then
				g(self.DebuffList, W)
			end
		end
		self:IncrementStackCount()
		self:StartIntervalThink(self.r_tick)
		if self.tl8_bonus_pct > 0 then
			local X = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			self.heroLevel = X and X.heroLevel or 1
		end
	end
end
function V.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function V.prototype.OnIntervalThink(self)
	if IsServer() then
		local J = self:GetParent()
		local Y = J:GetEnemy()
		if not IsInjurable(J, Y) then
			self:Destroy()
			return
		end
		local Z = self:GetStackCount()
		local R = Z * self.r_buff
		if self.tl8_bonus_pct > 0 then
			R = R * (1 + self.heroLevel * self.tl8_bonus_pct * 0.01)
		end
		for _, a0 in pairs(self.DebuffList) do
			if type(a0) == "function" then
				a0(J, Y, R, "zombie_guitarist_talent", "Ability")
			end
		end
	end
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function V.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.r_damage_pct
end
V = e(
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
				IsIndependent = true,
			}
		),
	},
	V
)
l.modifier_zombie_guitarist_red = V
l.modifier_zombie_guitarist_orange = c()
local a1 = l.modifier_zombie_guitarist_orange
a1.name = "modifier_zombie_guitarist_orange"
d(a1, r)
function a1.prototype.OnCreated(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a1.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
a1 = e(
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
	a1
)
l.modifier_zombie_guitarist_orange = a1
l.modifier_zombie_guitarist_yellow = c()
local a2 = l.modifier_zombie_guitarist_yellow
a2.name = "modifier_zombie_guitarist_yellow"
d(a2, r)
function a2.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.heroLevel = 1
end
function a2.prototype.GetAbilitySpecialValue(self)
	self.y_bonus = self:GetAbilitySpecialValueFor("y_bonus")
	self.tl8_bonus_pct = self:GetAbilityTalentValue("zombie_guitarist_talent_8", "bonus_pct")
end
function a2.prototype.AddCustomTransmitterData(self)
	return { heroLevel = self.heroLevel }
end
function a2.prototype.HandleCustomTransmitterData(self, a3)
	self.heroLevel = tonumber(a3.heroLevel)
end
function a2.prototype.OnCreated(self, A)
	if IsServer() then
		self:IncrementStackCount()
		if self.tl8_bonus_pct > 0 then
			local a4 = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			self.heroLevel = a4 and a4.heroLevel or 1
			self:SetHasCustomTransmitterData(true)
		end
	end
end
function a2.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a2.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function a2.prototype.EOM_GetModifierAttackSpeedBonus(self, A)
	local R = self.y_bonus * self:GetStackCount()
	if self.tl8_bonus_pct > 0 then
		R = R * (1 + self.tl8_bonus_pct * (self.heroLevel or 1) * 0.01)
	end
	return R
end
a2 = e(
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
				IsIndependent = true,
			}
		),
	},
	a2
)
l.modifier_zombie_guitarist_yellow = a2
l.modifier_zombie_guitarist_green = c()
local a5 = l.modifier_zombie_guitarist_green
a5.name = "modifier_zombie_guitarist_green"
d(a5, r)
function a5.prototype.GetAbilitySpecialValue(self)
	self.g_tick = self:GetAbilitySpecialValueFor("g_tick")
	self.g_regen = self:GetAbilitySpecialValueFor("g_regen")
	self.tl8_bonus_pct = self:GetAbilityTalentValue("zombie_guitarist_talent_8", "bonus_pct")
end
function a5.prototype.OnCreated(self, A)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.g_tick)
		if self.tl8_bonus_pct > 0 then
			local a6 = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			self.heroLevel = a6 and a6.heroLevel or 1
		end
	end
end
function a5.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a5.prototype.OnIntervalThink(self)
	if IsServer() then
		local a7 = self.g_regen * self:GetStackCount()
		if self.tl8_bonus_pct > 0 then
			a7 = a7 * (1 + self.heroLevel * self.tl8_bonus_pct * 0.01)
		end
		Heal(self:GetParent(), a7, "zombie_guitarist_talent", "Ability")
	end
end
a5 = e(
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
				IsIndependent = true,
			}
		),
	},
	a5
)
l.modifier_zombie_guitarist_green = a5
l.modifier_zombie_guitarist_blue = c()
local a8 = l.modifier_zombie_guitarist_blue
a8.name = "modifier_zombie_guitarist_blue"
d(a8, r)
function a8.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.heroLevel = 1
end
function a8.prototype.GetAbilitySpecialValue(self)
	self.b_mana = self:GetAbilitySpecialValueFor("b_mana")
	self.b_ult_pct = self:GetAbilitySpecialValueFor("b_ult_pct")
	self.tl8_bonus_pct = self:GetAbilityTalentValue("zombie_guitarist_talent_8", "bonus_pct")
end
function a8.prototype.OnCreated(self, A)
	if IsServer() then
		self:TriggerEffect()
		self:IncrementStackCount()
		if self.tl8_bonus_pct > 0 then
			local a9 = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			self.heroLevel = a9 and a9.heroLevel or 1
		end
	end
end
function a8.prototype.OnRefresh(self, A)
	if IsServer() then
		self:TriggerEffect()
		self:IncrementStackCount()
	end
end
function a8.prototype.TriggerEffect(self)
	Restore(self:GetParent(), self.b_mana)
end
function a8.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function a8.prototype.EOM_GetModifierUltiPower(self)
	local R = self.b_ult_pct * self:GetStackCount()
	if self.tl8_bonus_pct > 0 then
		R = R * (1 + self.heroLevel * self.tl8_bonus_pct * 0.01)
	end
	return R
end
a8 = e(
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
				IsIndependent = true,
			}
		),
	},
	a8
)
l.modifier_zombie_guitarist_blue = a8
l.modifier_zombie_guitarist_blue_buff = c()
local aa = l.modifier_zombie_guitarist_blue_buff
aa.name = "modifier_zombie_guitarist_blue_buff"
d(aa, r)
function aa.prototype.GetAbilitySpecialValue(self)
	self.b_ult_pct = self:GetAbilitySpecialValueFor("b_ult_pct")
end
function aa.prototype.OnCreated(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function aa.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function aa.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function aa.prototype.EOM_GetModifierUltiPower(self)
	return self.b_ult_pct * self:GetStackCount()
end
aa = e(
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
	aa
)
l.modifier_zombie_guitarist_blue_buff = aa
l.modifier_zombie_guitarist_purple = c()
local ab = l.modifier_zombie_guitarist_purple
ab.name = "modifier_zombie_guitarist_purple"
d(ab, r)
function ab.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.BuffList = { sect_shield = AddShield, sect_fury = AddFury, sect_chaos = AddChaos }
end
function ab.prototype.GetAbilitySpecialValue(self)
	self.p_pct = self:GetAbilitySpecialValueFor("p_pct")
	self.p_tick = self:GetAbilitySpecialValueFor("p_tick")
	self.p_buff = self:GetAbilitySpecialValueFor("p_buff")
		+ self:GetAbilityTalentValue("zombie_guitarist_shard", "count")
	self.tl8_bonus_pct = self:GetAbilityTalentValue("zombie_guitarist_talent_8", "bonus_pct")
end
function ab.prototype.OnCreated(self, A)
	if IsServer() then
		for W, R in pairs(self.BuffList) do
			if f(AbilityShop.banList, W) then
				g(self.BuffList, W)
			end
		end
		self:IncrementStackCount()
		self:StartIntervalThink(self.p_tick)
		if self.tl8_bonus_pct > 0 then
			local ac = PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			self.heroLevel = ac and ac.heroLevel or 1
		end
	end
end
function ab.prototype.OnRefresh(self, A)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function ab.prototype.OnIntervalThink(self)
	if IsServer() then
		local J = self:GetParent()
		local Y = J:GetEnemy()
		if not IsInjurable(J, Y) then
			self:Destroy()
			return
		end
		local Z = self:GetStackCount()
		local R = Z * self.p_buff
		if self.tl8_bonus_pct > 0 then
			R = R * (1 + self.heroLevel * self.tl8_bonus_pct * 0.01)
		end
		for _, a0 in pairs(self.BuffList) do
			if type(a0) == "function" then
				a0(J, R, "zombie_guitarist_talent", "Ability")
			end
		end
	end
end
function ab.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -self.p_pct }
end
ab = e(
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
				IsIndependent = true,
			}
		),
	},
	ab
)
l.modifier_zombie_guitarist_purple = ab
l.modifier_zombie_guitarist_ranged = c()
local ad = l.modifier_zombie_guitarist_ranged
ad.name = "modifier_zombie_guitarist_ranged"
d(ad, r)
function ad.prototype.OnCreated(self, A)
	if IsServer() then
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	end
end
function ad.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	end
end
function ad.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROJECTILE_SPEED,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}
end
function ad.prototype.GetModifierProjectileName(self)
	return "models/eom/hero/life_stealer_1/particles/life_stealer_1_base_attack_fx.vpcf"
end
function ad.prototype.GetActivityTranslationModifiers(self)
	return "switchRanged"
end
function ad.prototype.GetModifierProjectileSpeed(self)
	return 1200
end
function ad.prototype.GetAttackSound(self)
	return "Hero_Leshrac.Attack"
end
ad = e(
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
	ad
)
l.modifier_zombie_guitarist_ranged = ad
local ae = { { "0,3", "1,4", "2,5" }, { "0,2", "1,4", "3,5" }, { "0,4", "1,3", "2,5" } }
l.modifier_zombie_guitarist_all_record = c()
local af = l.modifier_zombie_guitarist_all_record
af.name = "modifier_zombie_guitarist_all_record"
d(af, r)
function af.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.count = 3
end
function af.prototype.OnCreated(self, A)
	if IsServer() then
		self.soundName = "Hero_ZombieGuitarist.Ulti"
		if RollPercentage(50) then
			self.soundName = "Hero_ZombieGuitarist.Ulti2"
		end
		self:GetParent():EmitSound(self.soundName)
		self.orderList = shallowcopy(ae[math.random(0, #ae - 1) + 1])
		self.orderList = h(self.orderList, function(S, ag, ah)
			return RollPercentage(50) and 1 or -1
		end)
		local ai = self:GetDuration() / self.count
		self:StartIntervalThink(ai)
		self:AddParticle(m(nil, "all", self:GetParent()), false, false, -1, false, false)
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(K, 60, Vector(74, 32, 0))
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function af.prototype.OnRefresh(self, A)
	if IsServer() then
		if self.soundName then
			self:GetParent():StopSound(self.soundName)
		end
		self.soundName = "Hero_ZombieGuitarist.Ulti"
		if RollPercentage(50) then
			self.soundName = "Hero_ZombieGuitarist.Ulti2"
		end
		self:GetParent():EmitSound(self.soundName)
		self.orderList = shallowcopy(ae[math.random(0, #ae - 1) + 1])
		self.orderList = h(self.orderList, function(S, ag, ah)
			return RollPercentage(50) and 1 or -1
		end)
		local ai = self:GetDuration() / self.count
		self:StartIntervalThink(ai)
		self:AddParticle(m(nil, "all", self:GetParent()), false, false, -1, false, false)
	end
end
function af.prototype.OnDestroy(self)
	if IsServer() then
		local J = self:GetParent()
		local B = self:GetAbility()
		local Y = J:GetEnemy()
		self:GetParent():StopSound(self.soundName)
		if self:HasTalent("zombie_guitarist_talent_2") then
			if IsInjurable(J, Y) and IsValid(B) then
				do
					local I = 0
					while I < #x do
						J:AddNewModifier(J, B, x[I + 1], nil)
						I = I + 1
					end
				end
			end
		end
	end
end
function af.prototype.OnIntervalThink(self)
	if IsServer() then
		if #self.orderList > 0 then
			local aj = i(table.remove(self.orderList, #self.orderList), ",")
			do
				local I = 0
				while I < #aj do
					local ak = j(aj[I + 1])
					if type(ak) == "number" and w[ak + 1] then
						local K = m(nil, w[ak + 1] .. "_ult", self:GetParent())
						ParticleManager:ReleaseParticleIndex(K)
					end
					I = I + 1
				end
			end
		end
	end
end
function af.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function af.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_1
end
function af.prototype.GetOverrideAnimationRate(self)
	return 2
end
af = e(
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
				GetStatusEffectName = "particles/status_fx/status_effect_snapfire_magma.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	af
)
l.modifier_zombie_guitarist_all_record = af
l.modifier_zombie_guitarist_red_record = c()
local al = l.modifier_zombie_guitarist_red_record
al.name = "modifier_zombie_guitarist_red_record"
d(al, r)
function al.prototype.OnCreated(self, A)
	if IsServer() then
		self:AddParticle(m(nil, "red_record", self:GetParent()), false, false, -1, false, false)
	end
end
al = e(
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
	al
)
l.modifier_zombie_guitarist_red_record = al
l.modifier_zombie_guitarist_orange_record = c()
local am = l.modifier_zombie_guitarist_orange_record
am.name = "modifier_zombie_guitarist_orange_record"
d(am, r)
function am.prototype.OnCreated(self, A)
	if IsServer() then
		self:AddParticle(m(nil, "orange_record", self:GetParent()), false, false, -1, false, false)
	end
end
am = e(
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
	am
)
l.modifier_zombie_guitarist_orange_record = am
l.modifier_zombie_guitarist_yellow_record = c()
local an = l.modifier_zombie_guitarist_yellow_record
an.name = "modifier_zombie_guitarist_yellow_record"
d(an, r)
function an.prototype.OnCreated(self, A)
	if IsServer() then
		self:AddParticle(m(nil, "yellow_record", self:GetParent()), false, false, -1, false, false)
	end
end
an = e(
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
	an
)
l.modifier_zombie_guitarist_yellow_record = an
l.modifier_zombie_guitarist_green_record = c()
local ao = l.modifier_zombie_guitarist_green_record
ao.name = "modifier_zombie_guitarist_green_record"
d(ao, r)
function ao.prototype.OnCreated(self, A)
	if IsServer() then
		self:AddParticle(m(nil, "green_record", self:GetParent()), false, false, -1, false, false)
	end
end
ao = e(
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
	ao
)
l.modifier_zombie_guitarist_green_record = ao
l.modifier_zombie_guitarist_blue_record = c()
local ap = l.modifier_zombie_guitarist_blue_record
ap.name = "modifier_zombie_guitarist_blue_record"
d(ap, r)
function ap.prototype.OnCreated(self, A)
	if IsServer() then
		self:AddParticle(m(nil, "blue_record", self:GetParent()), false, false, -1, false, false)
	end
end
ap = e(
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
	ap
)
l.modifier_zombie_guitarist_blue_record = ap
l.modifier_zombie_guitarist_purple_record = c()
local aq = l.modifier_zombie_guitarist_purple_record
aq.name = "modifier_zombie_guitarist_purple_record"
d(aq, r)
function aq.prototype.OnCreated(self, A)
	if IsServer() then
		self:AddParticle(m(nil, "purple_record", self:GetParent()), false, false, -1, false, false)
	end
end
aq = e(
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
	aq
)
l.modifier_zombie_guitarist_purple_record = aq
l.zombie_guitarist_ult = c()
local ar = l.zombie_guitarist_ult
ar.name = "zombie_guitarist_ult"
d(ar, u)
function ar.prototype.OnSpellStart(self)
	local as = self:GetCaster()
	local Y = as:GetEnemy()
	if not IsInjurable(as, Y) then
		return
	end
	local N = self:GetSpecialValueFor("duration")
	local at = self:GetSpecialValueFor("damage")
	local Z = self:GetSpecialValueFor("count") + self:GetTalentValue("zombie_guitarist_talent_9", "count")
	local au = as:FindModifierByName("modifier_zombie_guitarist_talent")
	as:DealDamage(Y, self, at, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, DamageFlags.DAMAGE_FLAG_NONE)
	if IsValid(au) then
		do
			local I = 0
			while I < Z do
				au:playRandomNote(true)
				I = I + 1
			end
		end
		if au.isAllPlayed then
			au:playerAllNote(N)
			local av = self:GetTalentValue("zombie_guitarist_talent_6", "duration")
			if av > 0 then
				local aw = { AddStun, AddSilence, AddDisarm }
				local a0 = aw[math.random(0, #aw - 1) + 1]
				a0(as, Y, self, av)
			end
		end
	end
end
ar = e({ v(nil) }, ar)
l.zombie_guitarist_ult = ar
return l