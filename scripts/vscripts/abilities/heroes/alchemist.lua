--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/alchemist"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayConcat
local g = b.__TS__ArrayForEach
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 4,
		["20"] = 4,
		["21"] = 4,
		["22"] = 6,
		["23"] = 7,
		["24"] = 6,
		["25"] = 7,
		["26"] = 8,
		["27"] = 9,
		["28"] = 8,
		["29"] = 7,
		["30"] = 6,
		["31"] = 7,
		["33"] = 7,
		["34"] = 13,
		["35"] = 21,
		["36"] = 13,
		["37"] = 21,
		["38"] = 22,
		["39"] = 23,
		["40"] = 22,
		["41"] = 31,
		["42"] = 32,
		["43"] = 34,
		["44"] = 31,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["48"] = 39,
		["49"] = 40,
		["51"] = 36,
		["52"] = 43,
		["53"] = 44,
		["54"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 48,
		["58"] = 49,
		["61"] = 43,
		["62"] = 54,
		["63"] = 55,
		["64"] = 55,
		["65"] = 55,
		["66"] = 55,
		["67"] = 55,
		["68"] = 55,
		["70"] = 55,
		["71"] = 54,
		["72"] = 57,
		["73"] = 58,
		["74"] = 59,
		["75"] = 60,
		["76"] = 61,
		["77"] = 61,
		["78"] = 61,
		["79"] = 61,
		["80"] = 61,
		["81"] = 61,
		["82"] = 61,
		["84"] = 63,
		["85"] = 57,
		["86"] = 65,
		["87"] = 66,
		["88"] = 66,
		["89"] = 66,
		["90"] = 66,
		["91"] = 66,
		["92"] = 66,
		["94"] = 66,
		["95"] = 67,
		["96"] = 68,
		["97"] = 68,
		["98"] = 68,
		["99"] = 68,
		["100"] = 68,
		["101"] = 68,
		["103"] = 65,
		["104"] = 73,
		["105"] = 75,
		["106"] = 75,
		["107"] = 75,
		["108"] = 75,
		["109"] = 75,
		["110"] = 75,
		["112"] = 75,
		["113"] = 76,
		["114"] = 77,
		["115"] = 78,
		["116"] = 79,
		["117"] = 80,
		["119"] = 73,
		["120"] = 84,
		["121"] = 85,
		["122"] = 86,
		["123"] = 87,
		["124"] = 88,
		["125"] = 89,
		["126"] = 84,
		["127"] = 92,
		["128"] = 93,
		["129"] = 94,
		["130"] = 95,
		["132"] = 92,
		["133"] = 98,
		["134"] = 99,
		["135"] = 100,
		["136"] = 101,
		["137"] = 102,
		["138"] = 103,
		["139"] = 103,
		["140"] = 103,
		["142"] = 103,
		["143"] = 104,
		["144"] = 105,
		["145"] = 106,
		["146"] = 106,
		["147"] = 106,
		["148"] = 106,
		["149"] = 106,
		["153"] = 98,
		["154"] = 111,
		["155"] = 112,
		["156"] = 112,
		["157"] = 114,
		["158"] = 114,
		["159"] = 114,
		["160"] = 112,
		["161"] = 112,
		["162"] = 112,
		["163"] = 112,
		["164"] = 112,
		["165"] = 111,
		["166"] = 120,
		["167"] = 121,
		["168"] = 122,
		["169"] = 123,
		["171"] = 120,
		["172"] = 126,
		["173"] = 127,
		["174"] = 128,
		["175"] = 129,
		["176"] = 130,
		["177"] = 131,
		["178"] = 126,
		["179"] = 133,
		["180"] = 134,
		["183"] = 136,
		["184"] = 137,
		["187"] = 140,
		["190"] = 144,
		["191"] = 145,
		["192"] = 146,
		["193"] = 147,
		["194"] = 149,
		["197"] = 152,
		["199"] = 154,
		["200"] = 133,
		["201"] = 156,
		["202"] = 157,
		["203"] = 158,
		["206"] = 159,
		["209"] = 160,
		["210"] = 161,
		["211"] = 162,
		["214"] = 164,
		["215"] = 165,
		["216"] = 166,
		["217"] = 167,
		["219"] = 169,
		["220"] = 170,
		["222"] = 156,
		["223"] = 173,
		["224"] = 174,
		["225"] = 173,
		["226"] = 176,
		["227"] = 177,
		["228"] = 178,
		["229"] = 179,
		["230"] = 180,
		["231"] = 181,
		["232"] = 183,
		["233"] = 184,
		["234"] = 185,
		["235"] = 190,
		["236"] = 191,
		["237"] = 192,
		["241"] = 176,
		["242"] = 21,
		["243"] = 13,
		["244"] = 13,
		["245"] = 13,
		["246"] = 13,
		["247"] = 13,
		["248"] = 13,
		["249"] = 13,
		["250"] = 13,
		["251"] = 21,
		["253"] = 21,
		["254"] = 198,
		["255"] = 206,
		["256"] = 198,
		["257"] = 206,
		["258"] = 209,
		["259"] = 211,
		["260"] = 212,
		["261"] = 209,
		["262"] = 214,
		["263"] = 215,
		["264"] = 216,
		["266"] = 214,
		["267"] = 219,
		["268"] = 220,
		["269"] = 221,
		["271"] = 219,
		["272"] = 224,
		["273"] = 225,
		["274"] = 224,
		["275"] = 229,
		["276"] = 230,
		["277"] = 231,
		["279"] = 229,
		["280"] = 206,
		["281"] = 198,
		["282"] = 198,
		["283"] = 198,
		["284"] = 198,
		["285"] = 198,
		["286"] = 198,
		["287"] = 198,
		["288"] = 198,
		["289"] = 206,
		["291"] = 206,
		["292"] = 236,
		["293"] = 244,
		["294"] = 236,
		["295"] = 244,
		["296"] = 246,
		["297"] = 247,
		["298"] = 246,
		["299"] = 249,
		["300"] = 250,
		["301"] = 249,
		["302"] = 244,
		["303"] = 236,
		["304"] = 236,
		["305"] = 236,
		["306"] = 236,
		["307"] = 236,
		["308"] = 236,
		["309"] = 236,
		["310"] = 236,
		["311"] = 244,
		["313"] = 244,
		["314"] = 256,
		["315"] = 257,
		["316"] = 256,
		["317"] = 257,
		["318"] = 259,
		["319"] = 260,
		["320"] = 261,
		["321"] = 262,
		["324"] = 263,
		["325"] = 264,
		["326"] = 267,
		["327"] = 268,
		["328"] = 269,
		["329"] = 270,
		["330"] = 271,
		["331"] = 271,
		["332"] = 271,
		["333"] = 271,
		["334"] = 271,
		["335"] = 271,
		["337"] = 271,
		["339"] = 273,
		["340"] = 274,
		["341"] = 275,
		["342"] = 276,
		["343"] = 277,
		["345"] = 279,
		["346"] = 279,
		["347"] = 279,
		["348"] = 279,
		["349"] = 279,
		["351"] = 281,
		["352"] = 282,
		["353"] = 285,
		["354"] = 290,
		["355"] = 291,
		["356"] = 292,
		["357"] = 293,
		["358"] = 294,
		["361"] = 259,
		["362"] = 302,
		["363"] = 303,
		["364"] = 303,
		["365"] = 303,
		["366"] = 303,
		["367"] = 303,
		["368"] = 303,
		["370"] = 303,
		["371"] = 304,
		["372"] = 305,
		["373"] = 305,
		["374"] = 305,
		["375"] = 305,
		["376"] = 305,
		["377"] = 306,
		["378"] = 307,
		["379"] = 308,
		["381"] = 302,
		["382"] = 257,
		["383"] = 256,
		["384"] = 257,
		["386"] = 257,
		["387"] = 314,
		["388"] = 323,
		["389"] = 314,
		["390"] = 323,
		["391"] = 325,
		["392"] = 326,
		["393"] = 325,
		["394"] = 328,
		["395"] = 329,
		["396"] = 330,
		["398"] = 328,
		["399"] = 333,
		["400"] = 334,
		["401"] = 333,
		["402"] = 338,
		["403"] = 339,
		["404"] = 338,
		["405"] = 323,
		["406"] = 314,
		["407"] = 314,
		["408"] = 314,
		["409"] = 314,
		["410"] = 314,
		["411"] = 314,
		["412"] = 314,
		["413"] = 314,
		["414"] = 314,
		["415"] = 323,
		["417"] = 323,
		["418"] = 342,
		["419"] = 351,
		["420"] = 342,
		["421"] = 351,
		["422"] = 359,
		["423"] = 361,
		["424"] = 362,
		["425"] = 364,
		["426"] = 366,
		["427"] = 367,
		["428"] = 368,
		["429"] = 359,
		["430"] = 370,
		["431"] = 371,
		["432"] = 372,
		["433"] = 373,
		["434"] = 374,
		["435"] = 375,
		["436"] = 376,
		["437"] = 377,
		["439"] = 379,
		["440"] = 380,
		["441"] = 380,
		["442"] = 380,
		["443"] = 380,
		["444"] = 380,
		["445"] = 380,
		["446"] = 380,
		["447"] = 380,
		["448"] = 381,
		["449"] = 382,
		["450"] = 382,
		["451"] = 382,
		["452"] = 382,
		["453"] = 382,
		["454"] = 382,
		["455"] = 382,
		["456"] = 382,
		["458"] = 370,
		["459"] = 385,
		["460"] = 386,
		["461"] = 387,
		["463"] = 385,
		["464"] = 390,
		["465"] = 391,
		["466"] = 392,
		["467"] = 393,
		["468"] = 394,
		["469"] = 395,
		["470"] = 396,
		["472"] = 390,
		["473"] = 399,
		["474"] = 400,
		["475"] = 401,
		["476"] = 402,
		["477"] = 402,
		["478"] = 402,
		["479"] = 402,
		["480"] = 402,
		["481"] = 402,
		["483"] = 399,
		["484"] = 405,
		["485"] = 406,
		["486"] = 405,
		["487"] = 410,
		["488"] = 411,
		["489"] = 411,
		["490"] = 411,
		["491"] = 411,
		["492"] = 411,
		["493"] = 410,
		["494"] = 417,
		["495"] = 418,
		["496"] = 419,
		["498"] = 417,
		["499"] = 422,
		["500"] = 423,
		["501"] = 424,
		["503"] = 422,
		["504"] = 427,
		["505"] = 428,
		["506"] = 429,
		["507"] = 429,
		["508"] = 429,
		["509"] = 429,
		["510"] = 429,
		["511"] = 429,
		["512"] = 429,
		["513"] = 430,
		["514"] = 430,
		["515"] = 430,
		["516"] = 430,
		["517"] = 430,
		["518"] = 430,
		["520"] = 427,
		["521"] = 436,
		["522"] = 437,
		["523"] = 436,
		["524"] = 441,
		["525"] = 442,
		["526"] = 441,
		["527"] = 351,
		["528"] = 342,
		["529"] = 342,
		["530"] = 342,
		["531"] = 342,
		["532"] = 342,
		["533"] = 342,
		["534"] = 342,
		["535"] = 342,
		["536"] = 342,
		["537"] = 351,
		["539"] = 351,
		["540"] = 445,
		["541"] = 453,
		["542"] = 445,
		["543"] = 453,
		["544"] = 455,
		["545"] = 457,
		["546"] = 455,
		["547"] = 459,
		["548"] = 460,
		["549"] = 461,
		["551"] = 459,
		["552"] = 464,
		["553"] = 465,
		["554"] = 464,
		["555"] = 469,
		["556"] = 470,
		["557"] = 469,
		["558"] = 453,
		["559"] = 445,
		["560"] = 445,
		["561"] = 445,
		["562"] = 445,
		["563"] = 445,
		["564"] = 445,
		["565"] = 445,
		["566"] = 445,
		["567"] = 453,
		["569"] = 453,
		["570"] = 474,
		["571"] = 485,
		["572"] = 474,
		["573"] = 485,
		["574"] = 487,
		["575"] = 488,
		["576"] = 487,
		["577"] = 490,
		["578"] = 491,
		["579"] = 492,
		["581"] = 490,
		["582"] = 495,
		["583"] = 496,
		["584"] = 497,
		["586"] = 495,
		["587"] = 500,
		["588"] = 501,
		["589"] = 500,
		["590"] = 505,
		["591"] = 506,
		["592"] = 505,
		["593"] = 485,
		["594"] = 474,
		["595"] = 474,
		["596"] = 474,
		["597"] = 474,
		["598"] = 474,
		["599"] = 474,
		["600"] = 474,
		["601"] = 474,
		["602"] = 474,
		["603"] = 474,
		["604"] = 474,
		["605"] = 485,
		["607"] = 485,
		["608"] = 511,
		["609"] = 515,
		["610"] = 511,
		["611"] = 515,
		["612"] = 516,
		["613"] = 517,
		["614"] = 516,
		["615"] = 519,
		["616"] = 520,
		["617"] = 519,
		["618"] = 515,
		["619"] = 511,
		["620"] = 515,
		["622"] = 515,
		["623"] = 524,
		["624"] = 532,
		["625"] = 524,
		["626"] = 532,
		["627"] = 548,
		["628"] = 549,
		["629"] = 550,
		["630"] = 551,
		["631"] = 552,
		["632"] = 553,
		["633"] = 554,
		["634"] = 555,
		["635"] = 556,
		["636"] = 557,
		["637"] = 558,
		["638"] = 559,
		["639"] = 560,
		["640"] = 561,
		["641"] = 562,
		["642"] = 563,
		["643"] = 548,
		["644"] = 565,
		["645"] = 566,
		["646"] = 567,
		["648"] = 565,
		["649"] = 570,
		["650"] = 571,
		["651"] = 572,
		["652"] = 573,
		["653"] = 574,
		["656"] = 570,
		["657"] = 578,
		["658"] = 579,
		["659"] = 579,
		["660"] = 579,
		["661"] = 579,
		["662"] = 579,
		["663"] = 579,
		["665"] = 579,
		["666"] = 580,
		["667"] = 581,
		["668"] = 581,
		["669"] = 581,
		["670"] = 581,
		["671"] = 581,
		["672"] = 581,
		["674"] = 578,
		["675"] = 584,
		["676"] = 585,
		["677"] = 585,
		["678"] = 585,
		["679"] = 585,
		["680"] = 585,
		["681"] = 584,
		["682"] = 587,
		["683"] = 588,
		["684"] = 587,
		["685"] = 592,
		["686"] = 593,
		["687"] = 594,
		["688"] = 595,
		["690"] = 592,
		["691"] = 598,
		["692"] = 599,
		["695"] = 600,
		["696"] = 602,
		["697"] = 603,
		["698"] = 604,
		["699"] = 605,
		["700"] = 606,
		["701"] = 607,
		["702"] = 608,
		["703"] = 609,
		["704"] = 611,
		["705"] = 612,
		["707"] = 618,
		["708"] = 623,
		["709"] = 625,
		["711"] = 627,
		["712"] = 629,
		["714"] = 631,
		["715"] = 633,
		["717"] = 635,
		["718"] = 637,
		["720"] = 639,
		["721"] = 641,
		["722"] = 643,
		["723"] = 644,
		["725"] = 646,
		["726"] = 650,
		["727"] = 651,
		["728"] = 652,
		["729"] = 657,
		["732"] = 660,
		["733"] = 661,
		["734"] = 662,
		["735"] = 662,
		["736"] = 662,
		["737"] = 662,
		["738"] = 662,
		["739"] = 662,
		["740"] = 663,
		["741"] = 664,
		["742"] = 664,
		["743"] = 664,
		["744"] = 664,
		["745"] = 664,
		["746"] = 665,
		["747"] = 665,
		["748"] = 665,
		["749"] = 665,
		["750"] = 665,
		["751"] = 665,
		["752"] = 665,
		["753"] = 665,
		["754"] = 662,
		["755"] = 662,
		["756"] = 671,
		["759"] = 674,
		["762"] = 598,
		["763"] = 532,
		["764"] = 524,
		["765"] = 524,
		["766"] = 524,
		["767"] = 524,
		["768"] = 524,
		["769"] = 524,
		["770"] = 524,
		["771"] = 524,
		["772"] = 532,
		["774"] = 532,
		["775"] = 681,
		["776"] = 682,
		["777"] = 681,
		["778"] = 682,
		["779"] = 683,
		["780"] = 684,
		["781"] = 683,
		["782"] = 682,
		["783"] = 681,
		["784"] = 682,
		["786"] = 682,
		["787"] = 688,
		["788"] = 696,
		["789"] = 688,
		["790"] = 696,
		["791"] = 697,
		["792"] = 698,
		["793"] = 697,
		["794"] = 700,
		["795"] = 701,
		["796"] = 702,
		["798"] = 700,
		["799"] = 705,
		["800"] = 706,
		["801"] = 707,
		["802"] = 708,
		["803"] = 709,
		["804"] = 709,
		["805"] = 709,
		["806"] = 709,
		["808"] = 709,
		["809"] = 710,
		["812"] = 705,
		["813"] = 714,
		["814"] = 715,
		["815"] = 714,
		["816"] = 719,
		["817"] = 720,
		["818"] = 719,
		["819"] = 696,
		["820"] = 688,
		["821"] = 688,
		["822"] = 688,
		["823"] = 688,
		["824"] = 688,
		["825"] = 688,
		["826"] = 688,
		["827"] = 688,
		["828"] = 696,
		["830"] = 696,
		["832"] = 724,
		["833"] = 725,
		["834"] = 724,
		["835"] = 725,
		["836"] = 726,
		["837"] = 727,
		["838"] = 726,
		["839"] = 725,
		["840"] = 724,
		["841"] = 725,
		["843"] = 725,
		["844"] = 731,
		["845"] = 739,
		["846"] = 731,
		["847"] = 739,
		["848"] = 741,
		["849"] = 742,
		["850"] = 741,
		["851"] = 744,
		["852"] = 745,
		["853"] = 744,
		["854"] = 739,
		["855"] = 731,
		["856"] = 731,
		["857"] = 731,
		["858"] = 731,
		["859"] = 731,
		["860"] = 731,
		["861"] = 731,
		["862"] = 731,
		["863"] = 739,
		["865"] = 739,
		["867"] = 751,
		["868"] = 752,
		["869"] = 751,
		["870"] = 752,
		["871"] = 753,
		["872"] = 754,
		["873"] = 753,
		["874"] = 752,
		["875"] = 751,
		["876"] = 752,
		["878"] = 752,
		["879"] = 758,
		["880"] = 766,
		["881"] = 758,
		["882"] = 766,
		["884"] = 766,
		["885"] = 770,
		["886"] = 758,
		["887"] = 772,
		["888"] = 773,
		["889"] = 774,
		["890"] = 775,
		["891"] = 776,
		["892"] = 777,
		["894"] = 772,
		["895"] = 780,
		["896"] = 781,
		["897"] = 782,
		["899"] = 780,
		["900"] = 785,
		["901"] = 786,
		["902"] = 786,
		["903"] = 788,
		["904"] = 788,
		["905"] = 788,
		["906"] = 786,
		["907"] = 786,
		["908"] = 785,
		["909"] = 791,
		["910"] = 792,
		["911"] = 793,
		["912"] = 794,
		["913"] = 791,
		["914"] = 796,
		["915"] = 797,
		["916"] = 800,
		["917"] = 800,
		["918"] = 800,
		["919"] = 800,
		["920"] = 800,
		["921"] = 801,
		["922"] = 802,
		["923"] = 803,
		["924"] = 804,
		["926"] = 806,
		["927"] = 806,
		["928"] = 806,
		["929"] = 806,
		["930"] = 806,
		["931"] = 807,
		["932"] = 807,
		["933"] = 807,
		["934"] = 807,
		["935"] = 807,
		["936"] = 809,
		["937"] = 796,
		["938"] = 811,
		["939"] = 812,
		["940"] = 813,
		["941"] = 814,
		["942"] = 815,
		["945"] = 818,
		["946"] = 819,
		["947"] = 820,
		["948"] = 821,
		["950"] = 823,
		["951"] = 823,
		["952"] = 823,
		["953"] = 823,
		["954"] = 823,
		["955"] = 824,
		["956"] = 825,
		["957"] = 826,
		["958"] = 827,
		["960"] = 829,
		["961"] = 829,
		["962"] = 829,
		["963"] = 829,
		["964"] = 829,
		["965"] = 830,
		["966"] = 830,
		["967"] = 830,
		["968"] = 830,
		["969"] = 830,
		["972"] = 811,
		["973"] = 834,
		["974"] = 835,
		["975"] = 836,
		["976"] = 834,
		["977"] = 838,
		["978"] = 839,
		["979"] = 840,
		["980"] = 841,
		["981"] = 842,
		["984"] = 845,
		["985"] = 846,
		["986"] = 846,
		["987"] = 846,
		["988"] = 846,
		["989"] = 846,
		["990"] = 846,
		["991"] = 852,
		["992"] = 853,
		["993"] = 854,
		["994"] = 855,
		["995"] = 855,
		["996"] = 855,
		["997"] = 855,
		["998"] = 855,
		["999"] = 856,
		["1000"] = 856,
		["1001"] = 856,
		["1002"] = 856,
		["1003"] = 856,
		["1004"] = 856,
		["1005"] = 856,
		["1006"] = 856,
		["1007"] = 856,
		["1008"] = 857,
		["1009"] = 857,
		["1010"] = 857,
		["1011"] = 857,
		["1012"] = 857,
		["1013"] = 857,
		["1015"] = 846,
		["1016"] = 846,
		["1017"] = 838,
		["1018"] = 766,
		["1019"] = 758,
		["1020"] = 758,
		["1021"] = 758,
		["1022"] = 758,
		["1023"] = 758,
		["1024"] = 758,
		["1025"] = 758,
		["1026"] = 758,
		["1027"] = 766,
		["1029"] = 766,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = require("abilities.ability_ai")
local q = p.BaseAbilityAI
local r = p.registerAbilityAI
local s = require("abilities.interact_ability")
local t = s.InteractAbility
local u = s.registerInteractAbility
i.alchemist_talent = c()
local v = i.alchemist_talent
v.name = "alchemist_talent"
d(v, k)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_alchemist_talent"
end
v = e({ l(nil) }, v)
i.alchemist_talent = v
i.modifier_alchemist_talent = c()
local w = i.modifier_alchemist_talent
w.name = "modifier_alchemist_talent"
d(w, n)
function w.prototype.GetTexture(self)
	return "modifier_alchemist_talent"
end
function w.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.tl7_factor = self:GetAbilityTalentValue("alchemist_talent_7", "factor")
end
function w.prototype.OnCreated(self, x)
	if IsServer() then
		self.tl7_enable = true
		self:SetStackCount(self:LoadCoinStack())
		self:StartIntervalThink(0)
	end
end
function w.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetCaster():GetPlayerOwnerID() ~= -1 then
			self:SetStackCount(self:LoadCoinStack())
			self:checkTl1Effect()
			self:StartIntervalThink(-1)
			self:LoadCostCoinStack()
		end
	end
end
function w.prototype.LoadCoinStack(self)
	local y = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "alchemist_coin")
	if y == nil then
		y = 0
	end
	return y
end
function w.prototype.SaveCoinStack(self, z)
	local A = self:GetParent():GetPlayerOwnerID()
	local B = PlayerData:getplayerData(A)
	if B then
		B:modifyHeroAbilityExtraData("alchemist_talent", "goblin_coin", z, true, true)
	end
	PlayerData:saveData(A, "alchemist_coin", z)
end
function w.prototype.LoadCostCoinStack(self)
	local C = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "alchemist_coin_cost")
	if C == nil then
		C = 0
	end
	local D = C
	if D > 0 then
		self:GetParent()
			:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_alchemist_cost_coin", { iStackCount = D })
	end
end
function w.prototype.SaveCostCoinStack(self, z)
	local E = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "alchemist_coin_cost")
	if E == nil then
		E = 0
	end
	local F = E
	local A = self:GetParent():GetPlayerOwnerID()
	PlayerData:saveData(A, "alchemist_coin_cost", z + F)
	local B = PlayerData:getplayerData(A)
	if B then
		B:modifyHeroAbilityExtraData("alchemist_talent", "cost_goblin_coin", z, true)
	end
end
function w.prototype.CostCoinByTreasure(self, D)
	local G = self:GetStackCount()
	local H = math.max(0, G - D)
	self:SaveCostCoinStack(D)
	self:SetStackCount(H)
	self:SaveCoinStack(H)
end
function w.prototype.addCoin(self, z)
	if z > 0 then
		self:IncrementStackCount(z)
		self:SaveCoinStack(self:GetStackCount())
	end
end
function w.prototype.checkTl1Effect(self)
	local I = self:GetAbilityTalentValue("alchemist_talent_1", "coin_bonus")
	if I > 0 then
		local A = self:GetParent():GetPlayerOwnerID()
		if A ~= -1 then
			local J = PlayerData:loadData(A, "alchemist_tl1")
			if J == nil then
				J = 0
			end
			local K = J
			if K == 0 then
				self:addCoin(I)
				PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "alchemist_tl1", 1)
			end
		end
	end
end
function w.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 },
	}
end
function w.prototype.OnTalentLearn(self, x)
	if x.talentName == "alchemist_talent_1" then
		self:SetStackCount(self:LoadCoinStack())
		self:checkTl1Effect()
	end
end
function w.prototype.OnBattleStartBefore(self, x)
	self:SetStackCount(self:LoadCoinStack())
	self:checkTl1Effect()
	self.tl7_enable = true
	self:LoadCostCoinStack()
	self.roundEnemyID = nil
end
function w.prototype.OnPlayerTakeDamage(self, L)
	if self:GetParent():IsCustomIllusion() then
		return
	end
	local A = self:GetParent():GetPlayerOwnerID()
	if L.attackerID == L.victimID or not (L.attackerID == A or L.victimID == A) then
		return
	end
	if self.roundEnemyID == nil or self:GetParent():IsNeutral() then
		return
	end
	local M = 0
	if L.victimID == A then
		M = L.damage
	elseif L.attackerID == A and self:HasTalent("alchemist_talent_3") then
		if self.roundEnemyID ~= L.victimID then
			return
		end
		M = L.damage
	end
	self:addCoin(M)
end
function w.prototype.OnBattleEnd(self, x)
	self.tl7_enable = false
	if self:GetParent():IsIllusion() then
		return
	end
	if x.isNeutral ~= nil then
		return
	end
	local N = self:GetParent()
	local A = N:GetPlayerOwnerID()
	if x.illusionPlayerID == A then
		return
	end
	if x.losePlayerID == A then
		self.roundEnemyID = x.winPlayerID
	elseif x.winPlayerID == A then
		self.roundEnemyID = x.losePlayerID
	end
	if x.winPlayerID == A then
		self:addCoin(self.count)
	end
end
function w.prototype.OnRoundStart(self, x)
	self:Talent7()
end
function w.prototype.Talent7(self)
	if self.tl7_factor > 0 and self.tl7_enable then
		local O = self:GetStackCount()
		if O > 0 then
			self.tl7_enable = false
			local A = self:GetParent():GetPlayerOwnerID()
			local P = O * self.tl7_factor
			PlayerData:modifyGold(A, P)
			Notification:combatToPlayer(
				A,
				{ message = "notify_bonus_gold", string_itemname_artifact = "RecordTab_Talent", int_gold = P }
			)
			local B = PlayerData:getplayerData(A)
			if B then
				B:modifyHeroAbilityExtraData("alchemist_talent", "DOTA_Tooltip_ability_alchemist_talent_7", P, true)
			end
		end
	end
end
w = e(
	{
		o(
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
	w
)
i.modifier_alchemist_talent = w
i.modifier_alchemist_cost_coin = c()
local Q = i.modifier_alchemist_cost_coin
Q.name = "modifier_alchemist_cost_coin"
d(Q, n)
function Q.prototype.GetAbilitySpecialValue(self)
	self.tl5_coin = self:GetAbilityTalentValue("alchemist_talent_5", "coin")
	self.tl5_damage_pct = self:GetAbilityTalentValue("alchemist_talent_5", "damage_pct")
end
function Q.prototype.OnCreated(self, x)
	if IsServer() then
		self:SetStackCount(x.iStackCount or 0)
	end
end
function Q.prototype.OnRefresh(self, x)
	if IsServer() then
		self:SetStackCount(x.iStackCount or 0)
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function Q.prototype.EOM_GetModifierOutgoingDamagePercentage(self, x)
	if self.tl5_coin > 0 then
		return math.floor(self:GetStackCount() / self.tl5_coin) * self.tl5_damage_pct
	end
end
Q = e(
	{
		o(
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
	Q
)
i.modifier_alchemist_cost_coin = Q
i.modifier_alchemist_talent_legend = c()
local R = i.modifier_alchemist_talent_legend
R.name = "modifier_alchemist_talent_legend"
d(R, n)
function R.prototype.GetAbilitySpecialValue(self)
	self.effect6_ssr = self:GetAbilitySpecialValueFor("effect6_ssr")
end
function R.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_LEGEND_CHANCE_BONUS] = self.effect6_ssr }
end
R = e(
	{
		o(
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
	R
)
i.modifier_alchemist_talent_legend = R
i.alchemist_ult = c()
local S = i.alchemist_ult
S.name = "alchemist_ult"
d(S, q)
function S.prototype.OnSpellStart(self)
	local T = self:GetCaster()
	local U = T:GetEnemy()
	if not IsInjurable(T, U) then
		return
	end
	T:StartGesture(ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_START)
	local V = self:GetSpecialValueFor("duration")
	local O = T:GetModifierStackCount("modifier_alchemist_talent", T)
	local W = self:GetTalentValue("alchemist_talent_2", "count")
	if W > 0 then
		if self.tl2_counter == nil then
			local X = PlayerData:loadData(self:GetCaster():GetPlayerOwnerID(), "alchemist_ult_cnt")
			if X == nil then
				X = 0
			end
			self.tl2_counter = X
		end
		self.tl2_counter = self.tl2_counter + 1
		if self.tl2_counter >= W then
			self.tl2_counter = 0
			local Y = self:GetTalentValue("alchemist_talent_2", "health")
			self:SaveTl2Value(Y)
		end
		PlayerData:saveData(self:GetCaster():GetPlayerOwnerID(), "alchemist_ult_cnt", self.tl2_counter)
	end
	T:EmitSound("Hero_Alchemist.ChemicalRage.Cast")
	T:AddNewModifier(T, self, "modifier_alchemist_ult", { duration = V })
	T:AddNewModifier(T, self, "modifier_alchemist_ult_health", { duration = V, coinCount = O })
	local Z = self:GetTalentValue("alchemist_talent_6", "factor")
	if Z > 0 then
		local D = T:GetModifierStackCount("modifier_alchemist_cost_coin", T)
		if D > 0 then
			T:AddNewModifier(T, self, "modifier_alchemist_talent_6", { duration = V, iStackCount = D })
		end
	end
end
function S.prototype.SaveTl2Value(self, _)
	local a0 = PlayerData:loadData(self:GetCaster():GetPlayerOwnerID(), "alchemist_tl2")
	if a0 == nil then
		a0 = 0
	end
	local a1 = a0
	local a2 = a1 + _
	PlayerData:saveData(self:GetCaster():GetPlayerOwnerID(), "alchemist_tl2", a2)
	local a3 = self:GetCaster():FindModifierByName("modifier_alchemist_talent_2")
	if IsValid(a3) then
		a3:SetStackCount(a2)
	end
end
S = e({ r(nil) }, S)
i.alchemist_ult = S
i.modifier_alchemist_ult_health = c()
local a4 = i.modifier_alchemist_ult_health
a4.name = "modifier_alchemist_ult_health"
d(a4, n)
function a4.prototype.GetAbilitySpecialValue(self)
	self.coin_factor = self:GetAbilitySpecialValueFor("coin_factor")
end
function a4.prototype.OnCreated(self, x)
	if IsServer() then
		self:SetStackCount(x.coinCount or 0)
	end
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function a4.prototype.EOM_GetModifierHealthBonus(self, x)
	return self:GetStackCount() * self.coin_factor
end
a4 = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a4
)
i.modifier_alchemist_ult_health = a4
i.modifier_alchemist_ult = c()
local a5 = i.modifier_alchemist_ult
a5.name = "modifier_alchemist_ult"
d(a5, n)
function a5.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.regen = self:GetAbilitySpecialValueFor("regen")
	self.tl4_ap_reduce = self:GetAbilityTalentValue("alchemist_talent_4", "ap_reduce")
	self.s_poison = self:GetAbilityTalentValue("alchemist_shard", "poison")
	self.s_attack_reduce = self:GetAbilityTalentValue("alchemist_shard", "attack_reduce")
	self.s_duration = self:GetAbilityTalentValue("alchemist_shard", "duration")
end
function a5.prototype.OnCreated(self, x)
	if IsServer() then
		local N = self:GetParent()
		N:EmitSound("Hero_Alchemist.ChemicalRage")
		N:AddActivityModifier("chemical_rage")
		N:SetMaterialGroup("1")
		self:IncrementStackCount()
		self:StartIntervalThink(1)
	else
		local a6 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(a6, false, false, -1, false, false)
		local a7 = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_chemical_rage.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(a7, false, true, MODIFIER_PRIORITY_NORMAL, false, false)
	end
end
function a5.prototype.OnRefresh(self, x)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a5.prototype.OnDestroy(self)
	if IsServer() then
		local N = self:GetParent()
		N:SetMaterialGroup("default")
		N:StopSound("Hero_Alchemist.ChemicalRage")
		N:RemoveActivityModifier("chemical_rage")
		N:StartGesture(ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_END)
	end
end
function a5.prototype.OnIntervalThink(self)
	if IsServer() then
		local N = self:GetParent()
		Heal(N, self.regen * self:GetStackCount(), "alchemist_ult", "Ability")
	end
end
function a5.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed }
end
function a5.prototype.EDeclareEvents(self)
	return {
		[MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent() },
		[MODIFIER_EVENT_ON_ATTACK] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
	}
end
function a5.prototype.OnAttackStart(self, a8)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Alchemist.ChemicalRage.PreAttack")
	end
end
function a5.prototype.OnAttack(self, a8)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Alchemist.ChemicalRage.Attack")
	end
end
function a5.prototype.OnCustomAttackLanded(self, a8)
	if self.s_poison > 0 then
		AddPoison(a8.attacker, a8.target, self.s_poison, "alchemist_ult", "Ability")
		a8.target:AddNewModifier(
			a8.attacker,
			self:GetAbility(),
			"modifier_alchemist_shard",
			{ duration = self.s_duration }
		)
	end
end
function a5.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS }
end
function a5.prototype.EOM_GetModifierAttackRateBonus(self, x)
	return -self.tl4_ap_reduce
end
a5 = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				IsIndependent = true,
			}
		),
	},
	a5
)
i.modifier_alchemist_ult = a5
i.modifier_alchemist_talent_6 = c()
local a9 = i.modifier_alchemist_talent_6
a9.name = "modifier_alchemist_talent_6"
d(a9, n)
function a9.prototype.GetAbilitySpecialValue(self)
	self.tl6_factor = self:GetAbilityTalentValue("alchemist_talent_6", "factor")
end
function a9.prototype.OnCreated(self, x)
	if IsServer() then
		self:SetStackCount(x.iStackCount or 0)
	end
end
function a9.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function a9.prototype.EOM_GetModifierIncomingDamagePercentage(self, x)
	return self:GetStackCount() * -self.tl6_factor
end
a9 = e(
	{
		o(
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
	a9
)
i.modifier_alchemist_talent_6 = a9
i.modifier_alchemist_shard = c()
local aa = i.modifier_alchemist_shard
aa.name = "modifier_alchemist_shard"
d(aa, n)
function aa.prototype.GetAbilitySpecialValue(self)
	self.s_attack_reduce = self:GetAbilityTalentValue("alchemist_shard", "attack_reduce")
end
function aa.prototype.OnCreated(self, x)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function aa.prototype.OnRefresh(self, x)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function aa.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function aa.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, x)
	return self.s_attack_reduce * self:GetStackCount()
end
aa = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_alchemist/alchemist_corrosive_weaponry.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				IsIndependent = true,
			}
		),
	},
	aa
)
i.modifier_alchemist_shard = aa
i.alchemist_interact = c()
local ab = i.alchemist_interact
ab.name = "alchemist_interact"
d(ab, t)
function ab.prototype.CustomToggleEnable(self)
	return true
end
function ab.prototype.GetIntrinsicModifierName(self)
	return "modifier_alchemist_interact"
end
ab = e(
	{
		u(
			nil,
			{
				ActiveTextureName = "alchemist/midas_knuckles/alchemist_goblins_greed",
				InactiveTextureName = "alchemist_interact_disabled",
			}
		),
	},
	ab
)
i.alchemist_interact = ab
i.modifier_alchemist_interact = c()
local ac = i.modifier_alchemist_interact
ac.name = "modifier_alchemist_interact"
d(ac, n)
function ac.prototype.GetAbilitySpecialValue(self)
	self.threshold1 = self:GetAbilitySpecialValueFor("threshold1")
	self.effect1 = self:GetAbilitySpecialValueFor("effect1")
	self.threshold2 = self:GetAbilitySpecialValueFor("threshold2")
	self.effect2 = self:GetAbilitySpecialValueFor("effect2")
	self.threshold3 = self:GetAbilitySpecialValueFor("threshold3")
	self.effect3 = self:GetAbilitySpecialValueFor("effect3")
	self.threshold4 = self:GetAbilitySpecialValueFor("threshold4")
	self.effect4 = self:GetAbilitySpecialValueFor("effect4")
	self.threshold5 = self:GetAbilitySpecialValueFor("threshold5")
	self.effect5 = self:GetAbilitySpecialValueFor("effect5")
	self.threshold6 = self:GetAbilitySpecialValueFor("threshold6")
	self.effect6 = self:GetAbilitySpecialValueFor("effect6")
	self.effect6_ssr = self:GetAbilitySpecialValueFor("effect6_ssr")
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function ac.prototype.OnCreated(self, x)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function ac.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetCaster():GetPlayerOwnerID() ~= -1 then
			self:LoadLegendStack()
			self:StartIntervalThink(-1)
		end
	end
end
function ac.prototype.LoadLegendStack(self)
	local ad = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "alchemist_legend_bonus")
	if ad == nil then
		ad = 0
	end
	local ae = ad
	if ae > 0 then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_alchemist_talent_legend", {})
	end
end
function ac.prototype.SaveLegendStack(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "alchemist_legend_bonus", 1)
end
function ac.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function ac.prototype.OnBattleEndStateEnd(self, x)
	local af = Rounds:getCurrentRound()
	if af % self.round == 0 then
		self:Effect()
	end
end
function ac.prototype.Effect(self)
	if self:GetParent():IsCustomIllusion() then
		return
	end
	local ag = self:GetAbility():GetToggleState()
	local ah = self:GetParent():FindModifierByName("modifier_alchemist_talent")
	if IsValid(ah) then
		if ag then
			local O = ah:GetStackCount()
			local A = self:GetParent():GetPlayerOwnerID()
			if O > 0 then
				if O > self.threshold1 then
					local P = O * self.effect1
					PlayerData:modifyGold(A, P)
					Notification:combatToPlayer(
						A,
						{
							message = "notify_bonus_gold",
							string_itemname_artifact = "DOTA_Tooltip_ability_alchemist_talent",
							int_gold = P,
						}
					)
				end
				local ai = { n = 0, r = 0, sr = 0 }
				if O > self.threshold2 then
					ai.n = ai.n + self.effect2
				end
				if O > self.threshold3 then
					ai.r = ai.r + self.effect3
				end
				if O > self.threshold4 then
					ai.r = ai.r + self.effect4
				end
				if O > self.threshold5 then
					ai.sr = ai.sr + self.effect5
				end
				if O > self.threshold6 then
					ai.sr = ai.sr + self.effect6
					self:SaveLegendStack()
					self:LoadLegendStack()
				end
				local aj = {}
				for ak, z in pairs(ai) do
					if z > 0 then
						local al = AbilityShop:getRandomAbility(
							A,
							z,
							{ specifyRarity = ak, specifyRarityIgnoreRule = true, isAbilityShop = false }
						)
						aj = f(aj, al)
					end
				end
				local am = PlayerData:getplayerData(A)
				local an = am.hero
				g(aj, function(ao, ap, aq)
					local ar
					ar = ap.aid
					local ak = ap.rarity
					an:learnAbility(ar, true, true, true)
					am:addHeroAbilityAbilities(self:GetAbility():GetAbilityName(), ar, aq == #aj - 1)
					Notification:combatToPlayer(
						A,
						{
							message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[ar].rarity),
							string_itemname_artifact = "DOTA_Tooltip_ability_alchemist_talent",
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. ar,
						}
					)
				end)
				ah:CostCoinByTreasure(O)
			end
		else
			ah:addCoin(self.count)
		end
	end
end
ac = e(
	{
		o(
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
	ac
)
i.modifier_alchemist_interact = ac
i.alchemist_talent_2 = c()
local as = i.alchemist_talent_2
as.name = "alchemist_talent_2"
d(as, q)
function as.prototype.GetIntrinsicModifierName(self)
	return "modifier_alchemist_talent_2"
end
as = e({ r(nil) }, as)
i.alchemist_talent_2 = as
i.modifier_alchemist_talent_2 = c()
local at = i.modifier_alchemist_talent_2
at.name = "modifier_alchemist_talent_2"
d(at, n)
function at.prototype.GetTexture(self)
	return "modifier_alchemist_talent_2"
end
function at.prototype.OnCreated(self, x)
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function at.prototype.OnIntervalThink(self)
	if IsServer() then
		local A = self:GetCaster():GetPlayerOwnerID()
		if A ~= -1 then
			local au = self.SetStackCount
			local av = PlayerData:loadData(A, "alchemist_tl2")
			if av == nil then
				av = 0
			end
			au(self, av)
			self:StartIntervalThink(-1)
		end
	end
end
function at.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function at.prototype.EOM_GetModifierHealthBonus(self, x)
	return self:GetStackCount()
end
at = e(
	{
		o(
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
	at
)
i.modifier_alchemist_talent_2 = at
i.alchemist_talent_4 = c()
local aw = i.alchemist_talent_4
aw.name = "alchemist_talent_4"
d(aw, q)
function aw.prototype.GetIntrinsicModifierName(self)
	return "modifier_alchemist_talent_4"
end
aw = e({ r(nil) }, aw)
i.alchemist_talent_4 = aw
i.modifier_alchemist_talent_4 = c()
local ax = i.modifier_alchemist_talent_4
ax.name = "modifier_alchemist_talent_4"
d(ax, n)
function ax.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
end
function ax.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed }
end
ax = e(
	{
		o(
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
	ax
)
i.modifier_alchemist_talent_4 = ax
i.alchemist_talent_8 = c()
local ay = i.alchemist_talent_8
ay.name = "alchemist_talent_8"
d(ay, q)
function ay.prototype.GetIntrinsicModifierName(self)
	return "modifier_alchemist_talent_8"
end
ay = e({ r(nil) }, ay)
i.alchemist_talent_8 = ay
i.modifier_alchemist_talent_8 = c()
local az = i.modifier_alchemist_talent_8
az.name = "modifier_alchemist_talent_8"
d(az, n)
function az.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.tick = 0.5
end
function az.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	if IsServer() then
		self.record = 0
		self.enable = true
	end
end
function az.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Alchemist.UnstableConcoction.Fuse")
	end
end
function az.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function az.prototype.OnBattleEnd(self, x)
	self:StartIntervalThink(-1)
	self.enable = false
	self:GetParent():StopSound("Hero_Alchemist.UnstableConcoction.Fuse")
end
function az.prototype.OnBattleStart(self, x)
	self:StartCountdown()
	local a6 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	local aA = 1
	local aB = math.floor(self.interval - self.record)
	if self.record % 1 == self.tick then
		aA = 8
	end
	ParticleManager:SetParticleControl(a6, 1, Vector(0, aB, aA))
	ParticleManager:SetParticleControl(a6, 2, Vector(2, 0, 0))
	self:StartIntervalThink(self.tick)
end
function az.prototype.OnIntervalThink(self)
	if IsServer() then
		if not self.enable then
			self:StartIntervalThink(-1)
			self:GetParent():StopSound("Hero_Alchemist.UnstableConcoction.Fuse")
			return
		end
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self:StartCountdown()
			self:Effect()
		else
			local a6 = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				self:GetParent()
			)
			local aA = 1
			local aB = math.floor(self.interval - self.record)
			if self.record % 1 == self.tick then
				aA = 8
			end
			ParticleManager:SetParticleControl(a6, 1, Vector(0, aB, aA))
			ParticleManager:SetParticleControl(a6, 2, Vector(2, 0, 0))
		end
	end
end
function az.prototype.StartCountdown(self)
	self.record = 0
	self:GetParent():EmitSound("Hero_Alchemist.UnstableConcoction.Fuse")
end
function az.prototype.Effect(self)
	local N = self:GetParent()
	local U = N:GetEnemy()
	N:StopSound("Hero_Alchemist.UnstableConcoction.Fuse")
	if not IsInjurable(N, U) then
		return
	end
	N:EmitSound("Hero_Alchemist.UnstableConcoction.Throw")
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf",
		hCaster = N,
		vSpawnOrigin = N:GetAbsOrigin() + Vector(0, 0, 168) + N:GetForwardVector() * 48,
		hTarget = U,
		iMoveSpeed = PROJECTILE_SPEED_NORMAL,
		OnProjectileHit = function(aC, aD, aE)
			if IsValid(self) and IsInjurable(N, U) then
				U:EmitSound("Hero_Alchemist.UnstableConcoction.Stun")
				local a6 = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf",
					PATTACH_CUSTOMORIGIN,
					self:GetParent()
				)
				ParticleManager:SetParticleControlEnt(a6, 0, U, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
				N:DealDamage(
					U,
					self:GetAbility(),
					N:GetMaxHealth() * self.damage_pct * 0.01,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
				)
			end
		end,
	})
end
az = e(
	{
		o(
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
	az
)
i.modifier_alchemist_talent_8 = az
return i