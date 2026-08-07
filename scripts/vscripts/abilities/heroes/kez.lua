--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/kez"
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
		["14"] = 2,
		["15"] = 2,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 11,
		["30"] = 19,
		["31"] = 11,
		["32"] = 19,
		["33"] = 27,
		["34"] = 29,
		["35"] = 30,
		["36"] = 33,
		["37"] = 27,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["42"] = 36,
		["43"] = 41,
		["44"] = 42,
		["45"] = 43,
		["46"] = 44,
		["48"] = 41,
		["49"] = 47,
		["50"] = 48,
		["51"] = 48,
		["52"] = 50,
		["53"] = 50,
		["54"] = 50,
		["55"] = 48,
		["56"] = 48,
		["57"] = 48,
		["58"] = 47,
		["59"] = 54,
		["60"] = 55,
		["61"] = 56,
		["62"] = 56,
		["63"] = 56,
		["64"] = 58,
		["67"] = 61,
		["70"] = 64,
		["73"] = 67,
		["74"] = 68,
		["75"] = 69,
		["76"] = 70,
		["77"] = 71,
		["78"] = 72,
		["79"] = 73,
		["80"] = 73,
		["81"] = 73,
		["82"] = 73,
		["83"] = 73,
		["84"] = 73,
		["88"] = 56,
		["89"] = 56,
		["90"] = 54,
		["91"] = 81,
		["92"] = 82,
		["93"] = 83,
		["94"] = 84,
		["96"] = 81,
		["97"] = 88,
		["98"] = 90,
		["99"] = 91,
		["100"] = 92,
		["101"] = 93,
		["102"] = 94,
		["105"] = 88,
		["106"] = 98,
		["107"] = 99,
		["108"] = 100,
		["109"] = 101,
		["110"] = 102,
		["111"] = 103,
		["112"] = 104,
		["113"] = 105,
		["115"] = 107,
		["116"] = 108,
		["119"] = 98,
		["120"] = 112,
		["121"] = 113,
		["122"] = 112,
		["123"] = 117,
		["124"] = 118,
		["125"] = 119,
		["127"] = 117,
		["128"] = 122,
		["129"] = 123,
		["130"] = 122,
		["131"] = 125,
		["132"] = 126,
		["133"] = 127,
		["134"] = 128,
		["136"] = 125,
		["137"] = 132,
		["138"] = 133,
		["139"] = 135,
		["140"] = 136,
		["141"] = 137,
		["144"] = 140,
		["145"] = 141,
		["146"] = 142,
		["147"] = 143,
		["148"] = 144,
		["149"] = 145,
		["150"] = 146,
		["151"] = 147,
		["152"] = 147,
		["153"] = 147,
		["154"] = 147,
		["155"] = 147,
		["156"] = 147,
		["157"] = 148,
		["158"] = 149,
		["159"] = 149,
		["160"] = 149,
		["161"] = 150,
		["162"] = 151,
		["163"] = 152,
		["164"] = 153,
		["165"] = 153,
		["166"] = 153,
		["167"] = 153,
		["168"] = 153,
		["170"] = 149,
		["171"] = 149,
		["173"] = 132,
		["174"] = 19,
		["175"] = 11,
		["176"] = 11,
		["177"] = 11,
		["178"] = 11,
		["179"] = 11,
		["180"] = 11,
		["181"] = 11,
		["182"] = 11,
		["183"] = 19,
		["185"] = 19,
		["187"] = 163,
		["188"] = 171,
		["189"] = 163,
		["190"] = 171,
		["191"] = 178,
		["192"] = 179,
		["193"] = 178,
		["194"] = 181,
		["195"] = 182,
		["196"] = 183,
		["197"] = 184,
		["198"] = 181,
		["199"] = 186,
		["200"] = 187,
		["201"] = 188,
		["202"] = 189,
		["203"] = 190,
		["204"] = 191,
		["205"] = 192,
		["206"] = 192,
		["207"] = 193,
		["208"] = 193,
		["209"] = 194,
		["211"] = 196,
		["213"] = 186,
		["214"] = 199,
		["215"] = 200,
		["216"] = 201,
		["217"] = 202,
		["218"] = 203,
		["219"] = 203,
		["220"] = 204,
		["221"] = 204,
		["222"] = 205,
		["225"] = 199,
		["226"] = 209,
		["227"] = 210,
		["228"] = 211,
		["229"] = 212,
		["230"] = 213,
		["231"] = 214,
		["234"] = 217,
		["235"] = 218,
		["238"] = 221,
		["240"] = 222,
		["241"] = 222,
		["242"] = 223,
		["243"] = 224,
		["244"] = 225,
		["245"] = 226,
		["246"] = 227,
		["248"] = 222,
		["251"] = 230,
		["252"] = 231,
		["253"] = 232,
		["254"] = 233,
		["255"] = 234,
		["256"] = 244,
		["258"] = 246,
		["261"] = 249,
		["262"] = 250,
		["266"] = 209,
		["267"] = 255,
		["268"] = 256,
		["269"] = 262,
		["270"] = 263,
		["271"] = 263,
		["272"] = 263,
		["273"] = 263,
		["274"] = 263,
		["275"] = 263,
		["276"] = 263,
		["277"] = 263,
		["278"] = 263,
		["279"] = 264,
		["280"] = 264,
		["281"] = 264,
		["282"] = 264,
		["283"] = 264,
		["284"] = 265,
		["285"] = 265,
		["286"] = 265,
		["287"] = 266,
		["288"] = 267,
		["289"] = 265,
		["290"] = 265,
		["291"] = 255,
		["292"] = 271,
		["293"] = 272,
		["294"] = 273,
		["295"] = 274,
		["296"] = 275,
		["297"] = 276,
		["299"] = 277,
		["300"] = 277,
		["301"] = 278,
		["302"] = 277,
		["305"] = 280,
		["306"] = 281,
		["307"] = 282,
		["308"] = 283,
		["309"] = 284,
		["310"] = 285,
		["311"] = 286,
		["312"] = 287,
		["313"] = 287,
		["314"] = 287,
		["315"] = 287,
		["316"] = 287,
		["317"] = 287,
		["318"] = 287,
		["319"] = 287,
		["320"] = 287,
		["321"] = 288,
		["322"] = 288,
		["323"] = 288,
		["324"] = 288,
		["325"] = 288,
		["326"] = 288,
		["327"] = 289,
		["328"] = 290,
		["329"] = 300,
		["332"] = 303,
		["333"] = 304,
		["334"] = 305,
		["336"] = 271,
		["337"] = 171,
		["338"] = 163,
		["339"] = 163,
		["340"] = 163,
		["341"] = 163,
		["342"] = 163,
		["343"] = 163,
		["344"] = 163,
		["345"] = 163,
		["346"] = 171,
		["348"] = 171,
		["350"] = 311,
		["351"] = 312,
		["352"] = 311,
		["353"] = 312,
		["354"] = 313,
		["355"] = 314,
		["356"] = 315,
		["357"] = 316,
		["360"] = 319,
		["361"] = 320,
		["362"] = 321,
		["363"] = 322,
		["364"] = 323,
		["365"] = 324,
		["366"] = 325,
		["367"] = 326,
		["368"] = 327,
		["369"] = 328,
		["370"] = 329,
		["371"] = 330,
		["372"] = 330,
		["373"] = 330,
		["374"] = 331,
		["377"] = 334,
		["378"] = 335,
		["379"] = 336,
		["380"] = 337,
		["381"] = 337,
		["382"] = 337,
		["383"] = 337,
		["384"] = 337,
		["385"] = 337,
		["386"] = 338,
		["387"] = 338,
		["388"] = 338,
		["389"] = 338,
		["390"] = 338,
		["391"] = 338,
		["392"] = 338,
		["393"] = 338,
		["394"] = 338,
		["395"] = 339,
		["396"] = 339,
		["397"] = 339,
		["398"] = 339,
		["399"] = 339,
		["400"] = 340,
		["401"] = 341,
		["402"] = 342,
		["403"] = 342,
		["404"] = 342,
		["405"] = 342,
		["406"] = 342,
		["407"] = 342,
		["408"] = 342,
		["409"] = 342,
		["410"] = 342,
		["411"] = 343,
		["412"] = 344,
		["413"] = 346,
		["414"] = 347,
		["415"] = 348,
		["416"] = 349,
		["417"] = 350,
		["419"] = 330,
		["420"] = 330,
		["422"] = 354,
		["423"] = 355,
		["424"] = 356,
		["425"] = 357,
		["426"] = 358,
		["427"] = 358,
		["428"] = 358,
		["429"] = 359,
		["432"] = 362,
		["433"] = 363,
		["435"] = 365,
		["437"] = 367,
		["438"] = 368,
		["439"] = 369,
		["441"] = 371,
		["443"] = 373,
		["444"] = 374,
		["445"] = 375,
		["446"] = 376,
		["447"] = 377,
		["448"] = 377,
		["449"] = 377,
		["450"] = 377,
		["451"] = 377,
		["452"] = 377,
		["453"] = 378,
		["454"] = 378,
		["455"] = 378,
		["456"] = 378,
		["457"] = 378,
		["458"] = 378,
		["459"] = 378,
		["460"] = 378,
		["461"] = 378,
		["462"] = 379,
		["463"] = 379,
		["464"] = 379,
		["465"] = 379,
		["466"] = 379,
		["467"] = 380,
		["468"] = 381,
		["469"] = 382,
		["470"] = 382,
		["471"] = 382,
		["472"] = 382,
		["473"] = 382,
		["474"] = 382,
		["475"] = 382,
		["476"] = 382,
		["477"] = 382,
		["478"] = 383,
		["479"] = 384,
		["480"] = 385,
		["481"] = 386,
		["482"] = 387,
		["483"] = 388,
		["484"] = 389,
		["486"] = 358,
		["487"] = 358,
		["489"] = 393,
		["490"] = 394,
		["491"] = 395,
		["493"] = 313,
		["494"] = 312,
		["495"] = 311,
		["496"] = 312,
		["498"] = 312,
		["500"] = 402,
		["501"] = 403,
		["502"] = 402,
		["503"] = 403,
		["504"] = 404,
		["505"] = 405,
		["506"] = 404,
		["507"] = 403,
		["508"] = 402,
		["509"] = 403,
		["511"] = 403,
		["512"] = 408,
		["513"] = 416,
		["514"] = 408,
		["515"] = 416,
		["516"] = 422,
		["517"] = 424,
		["518"] = 425,
		["519"] = 426,
		["520"] = 422,
		["521"] = 428,
		["522"] = 429,
		["523"] = 430,
		["524"] = 431,
		["526"] = 428,
		["527"] = 434,
		["528"] = 435,
		["529"] = 435,
		["530"] = 437,
		["531"] = 437,
		["532"] = 437,
		["533"] = 435,
		["534"] = 435,
		["535"] = 435,
		["536"] = 435,
		["537"] = 434,
		["538"] = 443,
		["539"] = 444,
		["540"] = 445,
		["541"] = 446,
		["542"] = 446,
		["543"] = 446,
		["544"] = 447,
		["545"] = 448,
		["546"] = 449,
		["547"] = 450,
		["548"] = 451,
		["549"] = 452,
		["550"] = 453,
		["551"] = 454,
		["552"] = 455,
		["553"] = 456,
		["554"] = 456,
		["555"] = 456,
		["556"] = 456,
		["557"] = 456,
		["558"] = 456,
		["559"] = 456,
		["560"] = 456,
		["561"] = 456,
		["562"] = 457,
		["563"] = 457,
		["564"] = 457,
		["565"] = 457,
		["566"] = 457,
		["567"] = 457,
		["568"] = 458,
		["571"] = 446,
		["572"] = 446,
		["574"] = 443,
		["575"] = 464,
		["576"] = 465,
		["577"] = 464,
		["578"] = 467,
		["579"] = 467,
		["580"] = 470,
		["581"] = 471,
		["584"] = 474,
		["587"] = 477,
		["590"] = 480,
		["591"] = 481,
		["592"] = 482,
		["593"] = 483,
		["595"] = 470,
		["596"] = 487,
		["597"] = 488,
		["600"] = 491,
		["603"] = 494,
		["606"] = 497,
		["607"] = 498,
		["609"] = 487,
		["610"] = 501,
		["611"] = 502,
		["612"] = 503,
		["613"] = 504,
		["614"] = 504,
		["615"] = 504,
		["616"] = 504,
		["617"] = 504,
		["618"] = 504,
		["620"] = 501,
		["621"] = 507,
		["622"] = 508,
		["623"] = 507,
		["624"] = 510,
		["625"] = 511,
		["626"] = 512,
		["627"] = 513,
		["629"] = 510,
		["630"] = 516,
		["631"] = 517,
		["632"] = 516,
		["633"] = 521,
		["634"] = 522,
		["635"] = 523,
		["637"] = 521,
		["638"] = 527,
		["639"] = 528,
		["640"] = 529,
		["641"] = 530,
		["644"] = 533,
		["645"] = 534,
		["646"] = 535,
		["647"] = 535,
		["648"] = 535,
		["649"] = 535,
		["650"] = 535,
		["651"] = 535,
		["652"] = 535,
		["653"] = 535,
		["654"] = 535,
		["655"] = 536,
		["656"] = 536,
		["657"] = 536,
		["658"] = 536,
		["659"] = 536,
		["660"] = 536,
		["661"] = 536,
		["662"] = 536,
		["663"] = 536,
		["664"] = 537,
		["665"] = 538,
		["666"] = 538,
		["667"] = 538,
		["668"] = 539,
		["669"] = 540,
		["670"] = 541,
		["671"] = 544,
		["672"] = 544,
		["673"] = 544,
		["674"] = 544,
		["675"] = 544,
		["676"] = 544,
		["678"] = 538,
		["679"] = 538,
		["680"] = 527,
		["681"] = 416,
		["682"] = 408,
		["683"] = 408,
		["684"] = 408,
		["685"] = 408,
		["686"] = 408,
		["687"] = 408,
		["688"] = 408,
		["689"] = 408,
		["690"] = 416,
		["692"] = 416,
		["694"] = 551,
		["695"] = 562,
		["696"] = 551,
		["697"] = 562,
		["698"] = 563,
		["699"] = 564,
		["700"] = 565,
		["701"] = 565,
		["702"] = 565,
		["703"] = 565,
		["704"] = 565,
		["705"] = 565,
		["706"] = 566,
		["707"] = 566,
		["708"] = 566,
		["709"] = 566,
		["710"] = 566,
		["711"] = 566,
		["712"] = 566,
		["713"] = 566,
		["715"] = 563,
		["716"] = 562,
		["717"] = 551,
		["718"] = 551,
		["719"] = 551,
		["720"] = 551,
		["721"] = 551,
		["722"] = 551,
		["723"] = 551,
		["724"] = 551,
		["725"] = 551,
		["726"] = 562,
		["728"] = 562,
		["730"] = 573,
		["731"] = 574,
		["732"] = 573,
		["733"] = 574,
		["734"] = 575,
		["735"] = 576,
		["736"] = 577,
		["737"] = 578,
		["738"] = 579,
		["739"] = 580,
		["742"] = 585,
		["743"] = 586,
		["744"] = 587,
		["745"] = 588,
		["746"] = 589,
		["747"] = 592,
		["748"] = 593,
		["749"] = 594,
		["751"] = 575,
		["752"] = 597,
		["753"] = 598,
		["754"] = 597,
		["755"] = 574,
		["756"] = 573,
		["757"] = 574,
		["759"] = 574,
		["760"] = 602,
		["761"] = 610,
		["762"] = 602,
		["763"] = 610,
		["764"] = 611,
		["765"] = 612,
		["766"] = 611,
		["767"] = 616,
		["768"] = 617,
		["769"] = 618,
		["772"] = 622,
		["773"] = 623,
		["774"] = 624,
		["775"] = 625,
		["776"] = 626,
		["777"] = 627,
		["778"] = 628,
		["779"] = 629,
		["780"] = 630,
		["781"] = 630,
		["782"] = 630,
		["783"] = 630,
		["784"] = 630,
		["785"] = 631,
		["786"] = 632,
		["787"] = 633,
		["788"] = 634,
		["789"] = 634,
		["790"] = 634,
		["791"] = 634,
		["792"] = 634,
		["793"] = 634,
		["794"] = 634,
		["795"] = 634,
		["796"] = 634,
		["797"] = 635,
		["798"] = 636,
		["799"] = 637,
		["800"] = 637,
		["801"] = 637,
		["802"] = 637,
		["803"] = 637,
		["804"] = 638,
		["805"] = 638,
		["806"] = 638,
		["807"] = 639,
		["808"] = 640,
		["809"] = 641,
		["812"] = 644,
		["813"] = 645,
		["814"] = 646,
		["815"] = 646,
		["816"] = 646,
		["817"] = 646,
		["818"] = 646,
		["819"] = 646,
		["820"] = 646,
		["821"] = 646,
		["822"] = 646,
		["823"] = 648,
		["824"] = 648,
		["825"] = 648,
		["826"] = 648,
		["827"] = 648,
		["828"] = 649,
		["829"] = 649,
		["830"] = 649,
		["831"] = 649,
		["832"] = 649,
		["833"] = 649,
		["834"] = 649,
		["835"] = 649,
		["836"] = 649,
		["837"] = 650,
		["838"] = 650,
		["839"] = 650,
		["840"] = 650,
		["841"] = 650,
		["842"] = 650,
		["843"] = 650,
		["844"] = 650,
		["845"] = 650,
		["846"] = 651,
		["847"] = 652,
		["848"] = 652,
		["849"] = 652,
		["850"] = 652,
		["851"] = 652,
		["852"] = 653,
		["853"] = 654,
		["854"] = 655,
		["856"] = 657,
		["857"] = 658,
		["858"] = 658,
		["859"] = 658,
		["860"] = 658,
		["861"] = 658,
		["862"] = 658,
		["863"] = 658,
		["864"] = 658,
		["866"] = 638,
		["867"] = 638,
		["870"] = 616,
		["871"] = 610,
		["872"] = 602,
		["873"] = 602,
		["874"] = 602,
		["875"] = 602,
		["876"] = 602,
		["877"] = 602,
		["878"] = 602,
		["879"] = 602,
		["880"] = 610,
		["882"] = 610,
		["883"] = 669,
		["884"] = 677,
		["885"] = 669,
		["886"] = 677,
		["887"] = 680,
		["888"] = 681,
		["889"] = 682,
		["890"] = 680,
		["891"] = 684,
		["892"] = 685,
		["893"] = 686,
		["894"] = 687,
		["895"] = 688,
		["896"] = 688,
		["897"] = 688,
		["898"] = 688,
		["899"] = 688,
		["900"] = 688,
		["901"] = 688,
		["902"] = 688,
		["903"] = 688,
		["904"] = 689,
		["905"] = 689,
		["906"] = 689,
		["907"] = 689,
		["908"] = 689,
		["909"] = 689,
		["910"] = 689,
		["911"] = 689,
		["912"] = 689,
		["913"] = 690,
		["914"] = 690,
		["915"] = 690,
		["916"] = 690,
		["917"] = 690,
		["918"] = 690,
		["919"] = 690,
		["920"] = 690,
		["921"] = 690,
		["922"] = 691,
		["923"] = 691,
		["924"] = 691,
		["925"] = 691,
		["926"] = 691,
		["927"] = 691,
		["928"] = 691,
		["929"] = 691,
		["930"] = 691,
		["931"] = 692,
		["932"] = 692,
		["933"] = 692,
		["934"] = 692,
		["935"] = 692,
		["936"] = 692,
		["937"] = 692,
		["938"] = 692,
		["940"] = 684,
		["941"] = 695,
		["942"] = 696,
		["943"] = 695,
		["944"] = 677,
		["945"] = 669,
		["946"] = 669,
		["947"] = 669,
		["948"] = 669,
		["949"] = 669,
		["950"] = 669,
		["951"] = 669,
		["952"] = 669,
		["953"] = 677,
		["955"] = 677,
		["957"] = 705,
		["958"] = 714,
		["959"] = 705,
		["960"] = 714,
		["961"] = 715,
		["962"] = 716,
		["963"] = 717,
		["965"] = 715,
		["966"] = 720,
		["967"] = 721,
		["968"] = 720,
		["969"] = 723,
		["970"] = 724,
		["971"] = 725,
		["972"] = 726,
		["973"] = 727,
		["974"] = 728,
		["975"] = 729,
		["976"] = 730,
		["978"] = 732,
		["979"] = 733,
		["980"] = 734,
		["982"] = 736,
		["983"] = 737,
		["984"] = 738,
		["987"] = 723,
		["988"] = 742,
		["989"] = 743,
		["990"] = 744,
		["991"] = 742,
		["992"] = 746,
		["993"] = 747,
		["994"] = 746,
		["995"] = 714,
		["996"] = 705,
		["997"] = 705,
		["998"] = 705,
		["999"] = 705,
		["1000"] = 705,
		["1001"] = 705,
		["1002"] = 705,
		["1003"] = 705,
		["1004"] = 714,
		["1006"] = 714,
		["1007"] = 750,
		["1008"] = 758,
		["1009"] = 750,
		["1010"] = 758,
		["1012"] = 758,
		["1013"] = 762,
		["1014"] = 763,
		["1015"] = 750,
		["1016"] = 766,
		["1017"] = 768,
		["1018"] = 769,
		["1019"] = 770,
		["1020"] = 772,
		["1021"] = 774,
		["1022"] = 766,
		["1023"] = 776,
		["1024"] = 777,
		["1027"] = 781,
		["1028"] = 782,
		["1029"] = 784,
		["1030"] = 785,
		["1031"] = 786,
		["1032"] = 787,
		["1033"] = 788,
		["1036"] = 791,
		["1037"] = 792,
		["1038"] = 793,
		["1039"] = 794,
		["1043"] = 798,
		["1044"] = 799,
		["1045"] = 800,
		["1046"] = 801,
		["1049"] = 804,
		["1050"] = 805,
		["1051"] = 806,
		["1052"] = 807,
		["1056"] = 776,
		["1057"] = 812,
		["1058"] = 813,
		["1059"] = 813,
		["1060"] = 815,
		["1061"] = 815,
		["1062"] = 815,
		["1063"] = 813,
		["1064"] = 813,
		["1065"] = 813,
		["1066"] = 813,
		["1067"] = 812,
		["1068"] = 820,
		["1069"] = 821,
		["1070"] = 822,
		["1071"] = 820,
		["1072"] = 824,
		["1073"] = 825,
		["1074"] = 824,
		["1075"] = 827,
		["1076"] = 828,
		["1079"] = 831,
		["1080"] = 832,
		["1081"] = 834,
		["1082"] = 835,
		["1083"] = 836,
		["1084"] = 837,
		["1085"] = 838,
		["1088"] = 841,
		["1089"] = 842,
		["1090"] = 843,
		["1094"] = 848,
		["1095"] = 849,
		["1096"] = 850,
		["1097"] = 851,
		["1099"] = 853,
		["1101"] = 827,
		["1102"] = 857,
		["1103"] = 858,
		["1104"] = 859,
		["1105"] = 859,
		["1106"] = 859,
		["1107"] = 859,
		["1108"] = 859,
		["1109"] = 859,
		["1110"] = 859,
		["1111"] = 859,
		["1113"] = 857,
		["1114"] = 758,
		["1115"] = 750,
		["1116"] = 750,
		["1117"] = 750,
		["1118"] = 750,
		["1119"] = 750,
		["1120"] = 750,
		["1121"] = 750,
		["1122"] = 750,
		["1123"] = 758,
		["1125"] = 758,
		["1126"] = 863,
		["1127"] = 871,
		["1128"] = 863,
		["1129"] = 871,
		["1130"] = 872,
		["1131"] = 873,
		["1132"] = 872,
		["1133"] = 877,
		["1134"] = 878,
		["1135"] = 877,
		["1136"] = 871,
		["1137"] = 863,
		["1138"] = 863,
		["1139"] = 863,
		["1140"] = 863,
		["1141"] = 863,
		["1142"] = 863,
		["1143"] = 863,
		["1144"] = 863,
		["1145"] = 871,
		["1147"] = 871,
		["1148"] = 881,
		["1149"] = 889,
		["1150"] = 881,
		["1151"] = 889,
		["1152"] = 890,
		["1153"] = 891,
		["1154"] = 890,
		["1155"] = 895,
		["1156"] = 896,
		["1157"] = 895,
		["1158"] = 889,
		["1159"] = 881,
		["1160"] = 881,
		["1161"] = 881,
		["1162"] = 881,
		["1163"] = 881,
		["1164"] = 881,
		["1165"] = 881,
		["1166"] = 881,
		["1167"] = 889,
		["1169"] = 889,
		["1170"] = 899,
		["1171"] = 907,
		["1172"] = 899,
		["1173"] = 907,
		["1174"] = 908,
		["1175"] = 909,
		["1176"] = 910,
		["1177"] = 910,
		["1178"] = 910,
		["1179"] = 910,
		["1180"] = 910,
		["1181"] = 911,
		["1182"] = 911,
		["1183"] = 911,
		["1184"] = 911,
		["1185"] = 911,
		["1186"] = 912,
		["1187"] = 912,
		["1188"] = 912,
		["1189"] = 912,
		["1190"] = 912,
		["1191"] = 914,
		["1192"] = 914,
		["1193"] = 914,
		["1194"] = 914,
		["1195"] = 914,
		["1196"] = 914,
		["1197"] = 914,
		["1198"] = 914,
		["1200"] = 908,
		["1201"] = 907,
		["1202"] = 899,
		["1203"] = 899,
		["1204"] = 899,
		["1205"] = 899,
		["1206"] = 899,
		["1207"] = 899,
		["1208"] = 899,
		["1209"] = 899,
		["1210"] = 907,
		["1212"] = 907,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.interact_ability")
local l = k.InteractAbility
local m = k.InteractBaseAbility
local n = k.registerInteractAbility
local o = k.registerInteractBaseAbility
g.kez_talent = c()
local p = g.kez_talent
p.name = "kez_talent"
d(p, m)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_kez_talent"
end
p = e({ o(nil) }, p)
g.kez_talent = p
g.modifier_kez_talent = c()
local q = g.modifier_kez_talent
q.name = "modifier_kez_talent"
d(q, i)
function q.prototype.GetAbilitySpecialValue(self)
	self.attack_pct = self:GetAbilitySpecialValueFor("attack_pct")
		+ 1
		+ self:GetAbilityTalentValue("kez_talent_2", "ui_bonus_pct") * 0.01
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
		+ 1
		+ self:GetAbilityTalentValue("kez_talent_2", "ui_bonus_pct") * 0.01
	self.tl4_trigger = self:GetAbilityTalentValue("kez_talent_4", "trigger_cnt")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		self.attack_cnt = 0
	end
end
function q.prototype.OnThink(self, s)
	if s == "temp_act" then
		self:SetStackCount(0)
		self:StartThink(-1, "temp_act")
	end
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
	}
end
function q.prototype.OnBattleStartBefore(self, r)
	local t = self:GetParent()
	self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(u, r, v, w)
		if v ~= t then
			return
		end
		if not self:IsActivated() then
			return
		end
		if t:PassivesDisabled() then
			return
		end
		if
			r.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
			or IsValid(r.ability) and r.ability:GetAbilityName() == "kez_ult"
		then
			local x = Round(self.damage_pct * 0.01 * r.damage)
			if x > 0 then
				local w = r.target
				local y = r.attacker
				if IsInjurable(w, y) then
					w:AddNewModifier(y, self:GetAbility(), "modifier_kez_talent_debuff", { damageStack = x })
				end
			end
		end
	end)
end
function q.prototype.OnBattleEnd(self, r)
	if self.hookID ~= nil then
		self:unhook(self.hookID)
		self.hookID = nil
	end
end
function q.prototype.OnCustomAttackLanded(self, z)
	if IsServer() and self.tl4_trigger > 0 then
		self.attack_cnt = self.attack_cnt + 1
		if self.attack_cnt >= self.tl4_trigger then
			self.attack_cnt = 0
			self:Talent4Effect()
		end
	end
end
function q.prototype.Talent4Effect(self)
	local v = self:GetParent()
	local A = self:GetAbilityTalentValue("kez_talent_4", "duration")
	if A > 0 then
		local B = v:FindModifierByName("modifier_kez_talent")
		local C = v:FindModifierByName("modifier_kez_talent_s")
		if IsValid(B) then
			B:setTempActivated(A)
		end
		if IsValid(C) then
			C:setTempActivated(A)
		end
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE }
end
function q.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, r)
	if self:IsActivated() then
		return self.attack_pct
	end
end
function q.prototype.IsActivated(self)
	return self:GetStackCount() > 0 or IsValid(self:GetAbility()) and self:GetAbility():GetToggleState()
end
function q.prototype.setTempActivated(self, D)
	if IsServer() then
		self:SetStackCount(1)
		self:StartThink(D, "temp_act")
	end
end
function q.prototype.SwapSkill(self, E)
	if IsServer() then
		local t = self:GetParent()
		local F = t:GetEnemy()
		if not IsInjurable(t, F) then
			return
		end
		t:EmitSound("Hero_Kez.Katana.Impale.Start")
		local G = t:GetAbsOrigin() - F:GetAbsOrigin()
		G.z = 0
		G = G:Normalized()
		local H = F:GetAttachmentPosition("attach_hitloc") + G * 100
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kez/kez_katana_impale.vpcf",
			PATTACH_CUSTOMORIGIN,
			t
		)
		ParticleManager:SetParticleControl(I, 0, H)
		ParticleManager:SetParticleControlTransform(I, 1, H, VectorAngles(G))
		ParticleManager:ReleaseParticleIndex(I)
		t:GameTimer(0.6, function()
			local B = F:FindModifierByName("modifier_kez_talent_debuff")
			if IsValid(B) then
				B:BurstDamage()
				DamageSystem:performAttack(t, F, { ability = self:GetAbility() })
			end
		end)
	end
end
q = e(
	{
		j(
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
	q
)
g.modifier_kez_talent = q
g.modifier_kez_talent_debuff = c()
local J = g.modifier_kez_talent_debuff
J.name = "modifier_kez_talent_debuff"
d(J, i)
function J.prototype.GetTexture(self)
	return "modifier_kez_talent_debuff"
end
function J.prototype.GetAbilitySpecialValue(self)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.tickAmounts = Round(self.duration / self.tick)
end
function J.prototype.OnCreated(self, r)
	if IsServer() then
		self.tickStack = {}
		self.damageStack = {}
		local G = r and r.damageStack or 0
		if G > 0 then
			local K = self.damageStack
			K[#K + 1] = G
			local L = self.tickStack
			L[#L + 1] = self.tickAmounts
			self:SetStackCount(self.tickAmounts * G)
		end
		self:StartIntervalThink(self.tick)
	end
end
function J.prototype.OnRefresh(self, r)
	if IsServer() then
		local G = r and r.damageStack or 0
		if G > 0 then
			local M = self.damageStack
			M[#M + 1] = G
			local N = self.tickStack
			N[#N + 1] = self.tickAmounts
			self:IncrementStackCount(self.tickAmounts * G)
		end
	end
end
function J.prototype.OnIntervalThink(self)
	if IsServer() then
		local v = self:GetCaster()
		local t = self:GetParent()
		if not IsInjurable(t, v) then
			self:Destroy()
			return
		end
		if #self.damageStack == 0 then
			self:Destroy()
			return
		end
		local x = 0
		do
			local O = #self.damageStack - 1
			while O >= 0 do
				x = x + self.damageStack[O + 1]
				self.tickStack[O + 1] = self.tickStack[O + 1] - 1
				if self.tickStack[O + 1] <= 0 then
					table.remove(self.damageStack, O + 1)
					table.remove(self.tickStack, O + 1)
				end
				O = O - 1
			end
		end
		if x > 0 then
			self:DecrementStackCount(x)
			local P = self:GetAbility()
			self:CreateDamageParticle(x)
			v:DealDamage(t, P, x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
			t:EmitSound("Hero_Kez.Katana.Bleed")
		else
			self:Destroy()
			return
		end
		if #self.damageStack == 0 then
			self:Destroy()
			return
		end
	end
end
function J.prototype.CreateDamageParticle(self, x)
	local t = self:GetParent()
	local Q = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kez/kez_katana_bleed_damage_tick.vpcf",
		PATTACH_CUSTOMORIGIN,
		t
	)
	ParticleManager:SetParticleControlEnt(Q, 0, t, PATTACH_POINT, "attach_hitloc", t:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(Q, 1, Vector(5, 0, 0))
	GameTimer(0.03, function()
		ParticleManager:DestroyParticle(Q, false)
		ParticleManager:ReleaseParticleIndex(Q)
	end)
end
function J.prototype.BurstDamage(self)
	if IsServer() then
		local v = self:GetCaster()
		local t = self:GetParent()
		if IsInjurable(t, v) and #self.damageStack > 0 then
			local x = 0
			do
				local O = #self.damageStack - 1
				while O >= 0 do
					x = x + self.damageStack[O + 1] * self.tickStack[O + 1]
					O = O - 1
				end
			end
			if x > 0 then
				local P = self:GetAbility()
				self:CreateDamageParticle(x)
				local G = v:GetAbsOrigin() - t:GetAbsOrigin()
				G.z = 0
				G = G:Normalized()
				local I = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_kez/kez_katana_impale_end.vpcf",
					PATTACH_CUSTOMORIGIN,
					v
				)
				ParticleManager:SetParticleControlEnt(
					I,
					0,
					t,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					t:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlTransform(I, 1, Vector(0, 0, 0), VectorAngles(G))
				ParticleManager:ReleaseParticleIndex(I)
				v:DealDamage(t, P, x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
				t:EmitSound("Hero_Kez.Katana.Impale.Target")
			end
		end
		self.tickStack = {}
		self.damageStack = {}
		self:Destroy()
	end
end
J = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	J
)
g.modifier_kez_talent_debuff = J
g.kez_ult = c()
local R = g.kez_ult
R.name = "kez_ult"
d(R, m)
function R.prototype.OnSpellStart(self, S)
	local v = self:GetCaster()
	local F = v:GetEnemy()
	if not IsInjurable(v, F) then
		return
	end
	local x = self:GetSpecialValueFor("damage")
	local T = self:GetSpecialValueFor("count")
	local U = v:GetRightVector()
	U.z = 0
	U = U:Normalized()
	local V = v:GetLeftVector()
	V.z = 0
	V = V:Normalized()
	if type(S) == "number" then
		T = math.floor(T * S * 0.01)
		local W = true
		self:GameTimer(0, function()
			if not IsInjurable(v, F) then
				return
			end
			v:EmitSound("Hero_Kez.RaptorDance.Katana.Slash")
			F:EmitSound("Hero_Kez.RaptorDance.Katana.Target")
			local I = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlTransform(I, 0, v:GetAbsOrigin(), VectorAngles(W and V or U))
			ParticleManager:SetParticleControlEnt(I, 1, v, PATTACH_ABSORIGIN, nil, v:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(I, 2, Vector(575, W and 1 or 0, 1))
			ParticleManager:ReleaseParticleIndex(I)
			local X = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/bird_samurai_blood_katana_slash_tgt.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlEnt(
				I,
				1,
				F,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				F:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(X)
			W = not W
			v:DealDamage(F, self, x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
			Heal(v, x, "kez_ult", "Ability")
			T = T - 1
			if T > 0 then
				return 0.25
			end
		end)
	else
		v:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CHANNEL_ABILITY_4, 0.03, 0.06, 1.5)
		local W = true
		local Y = false
		local Z = ACT_DOTA_KEZ_KATANA_ULT_START
		self:GameTimer(0.5, function()
			if not IsInjurable(v, F) then
				return
			end
			if W then
				Z = ACT_DOTA_KEZ_KATANA_ULT_START
			else
				Z = ACT_DOTA_KEZ_KATANA_ULT_CHAIN_B
			end
			if not Y then
				Y = true
				v:FadeGesture(ACT_DOTA_CHANNEL_ABILITY_4)
			else
				v:RemoveGesture(Z)
			end
			v:StartGesture(Z)
			v:EmitSound("Hero_Kez.RaptorDance.Katana.Slash")
			F:EmitSound("Hero_Kez.RaptorDance.Katana.Target")
			local I = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlTransform(I, 0, v:GetAbsOrigin(), VectorAngles(W and V or U))
			ParticleManager:SetParticleControlEnt(I, 1, v, PATTACH_ABSORIGIN, nil, v:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(I, 2, Vector(575, W and 1 or 0, 1))
			ParticleManager:ReleaseParticleIndex(I)
			local X = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/bird_samurai_blood_katana_slash_tgt.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlEnt(
				I,
				1,
				F,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				F:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(X)
			W = not W
			v:DealDamage(F, self, x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
			Heal(v, x, "kez_ult", "Ability")
			T = T - 1
			if T > 0 then
				return 0.25
			end
		end)
	end
	local _ = v:FindAbilityByName("kez_interact")
	if IsValid(_) then
		_:AddPlusEffect()
	end
end
R = e({ o(nil) }, R)
g.kez_ult = R
g.kez_talent_s = c()
local a0 = g.kez_talent_s
a0.name = "kez_talent_s"
d(a0, m)
function a0.prototype.GetIntrinsicModifierName(self)
	return "modifier_kez_talent_s"
end
a0 = e({ o(nil) }, a0)
g.kez_talent_s = a0
g.modifier_kez_talent_s = c()
local a1 = g.modifier_kez_talent_s
a1.name = "modifier_kez_talent_s"
d(a1, i)
function a1.prototype.GetAbilitySpecialValue(self)
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
		* (1 + self:GetAbilityTalentValue("kez_talent_2", "ui_bonus_pct") * 0.01)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		* (1 + self:GetAbilityTalentValue("kez_talent_2", "ui_bonus_pct") * 0.01)
	self.s_chance = self:GetAbilityTalentValue("kez_shard", "chance")
		* (1 + self:GetAbilityTalentValue("kez_talent_2", "ui_bonus_pct") * 0.01)
end
function a1.prototype.OnThink(self, s)
	if s == "temp_act" then
		self:SetStackCount(0)
		self:StartThink(-1, "temp_act")
	end
end
function a1.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent() },
	}
end
function a1.prototype.OnCreated(self, r)
	if IsServer() then
		self.s_enable = false
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(u, r, v, w)
			if v == self:GetParent() then
				if
					r.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and w:HasModifier("modifier_kez_talent_s_marker")
				then
					w:RemoveModifierByName("modifier_kez_talent_s_marker")
					r.is_crit = true
					v:EmitSound("Hero_Kez.Sai.Crit")
					local G = v:GetAbsOrigin() - w:GetAbsOrigin()
					G.z = 0
					G = G:Normalized()
					local a2 = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_kez/kez_sai_ultimate_crit.vpcf",
						PATTACH_CUSTOMORIGIN,
						w,
						v
					)
					ParticleManager:SetParticleControlEnt(
						a2,
						0,
						w,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						w:GetAbsOrigin(),
						true
					)
					ParticleManager:SetParticleControlTransformForward(
						a2,
						1,
						w:GetAttachmentPosition("attach_hitloc"),
						G
					)
					ParticleManager:ReleaseParticleIndex(a2)
				end
			end
		end)
	end
end
function a1.prototype.OnBattleStartBefore(self, r)
	self.s_enable = self.s_chance > 0
end
function a1.prototype.OnBattleEnd(self, r) end
function a1.prototype.OnCustomTakeDamage(self, z)
	if self.s_enable then
		return
	end
	if not self:IsActivated() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if z.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and self:PRD(self.chance, "talent") then
		local w = z.target
		local y = z.attacker
		self:AddMark(w)
	end
end
function a1.prototype.OnEvasion(self, r)
	if not self.s_enable then
		return
	end
	if not self:IsActivated() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if self:PRD(self.s_chance, "talent_shard") then
		self:AddMark(r.attacker)
	end
end
function a1.prototype.AddMark(self, w)
	local t = self:GetParent()
	if IsInjurable(t, w) then
		w:AddNewModifier(t, self:GetAbility(), "modifier_kez_talent_s_marker", nil)
	end
end
function a1.prototype.IsActivated(self)
	return self:GetStackCount() > 0 or IsValid(self:GetAbility()) and self:GetAbility():GetToggleState()
end
function a1.prototype.setTempActivated(self, D)
	if IsServer() then
		self:SetStackCount(1)
		self:StartThink(D, "temp_act")
	end
end
function a1.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function a1.prototype.EOM_GetModifierAttackSpeedBonus(self, r)
	if self:IsActivated() then
		return self.attack_speed
	end
end
function a1.prototype.SwapSkill(self, E)
	local t = self:GetParent()
	local F = t:GetEnemy()
	if not IsInjurable(t, F) then
		return
	end
	t:EmitSound("Hero_Kez.GrapplingClaw.Katana.Cast")
	local a2 =
		ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_kunai.vpcf", PATTACH_ABSORIGIN_FOLLOW, t)
	ParticleManager:SetParticleControlEnt(a2, 1, F, PATTACH_POINT_FOLLOW, "attach_hitloc", F:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(a2, 3, t, PATTACH_POINT_FOLLOW, "attach_hitloc", t:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(a2)
	t:GameTimer(0.1, function()
		if IsInjurable(t, F) and IsValid(self) and IsValid(E) then
			F:EmitSound("Hero_Kez.GrapplingClaw.Katana.Target")
			DamageSystem:performAttack(t, F, { ability = E })
			F:AddNewModifier(t, self:GetAbility(), "modifier_kez_talent_s_marker", nil)
		end
	end)
end
a1 = e(
	{
		j(
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
g.modifier_kez_talent_s = a1
g.modifier_kez_talent_s_marker = c()
local a3 = g.modifier_kez_talent_s_marker
a3.name = "modifier_kez_talent_s_marker"
d(a3, i)
function a3.prototype.OnCreated(self, r)
	if not IsServer() then
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
		self:AddParticle(I, false, false, -1, false, true)
	end
end
a3 = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	a3
)
g.modifier_kez_talent_s_marker = a3
g.kez_ult_s = c()
local a4 = g.kez_ult_s
a4.name = "kez_ult_s"
d(a4, m)
function a4.prototype.OnSpellStart(self, S)
	local v = self:GetCaster()
	local F = v:GetEnemy()
	local D = self:GetSpecialValueFor("duration")
	if type(S) == "number" then
		D = D * S * 0.01
	else
	end
	F:AddNewModifier(v, self, "modifier_kez_talent_s_marker", nil)
	v:EmitSound("Hero_Kez.FalconRush.Sai.Cast")
	local I = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kez/kez_sai_ultimate_buff_start.vpcf",
		PATTACH_ABSORIGIN,
		v
	)
	ParticleManager:ReleaseParticleIndex(I)
	v:AddNewModifier(v, self, "kez_ult_s_buff", { duration = D })
	local _ = v:FindAbilityByName("kez_interact")
	if IsValid(_) then
		_:AddPlusEffect()
	end
end
function a4.prototype.GetIntrinsicModifierName(self)
	return "modifier_kez_ult_s"
end
a4 = e({ o(nil) }, a4)
g.kez_ult_s = a4
g.modifier_kez_ult_s = c()
local a5 = g.modifier_kez_ult_s
a5.name = "modifier_kez_ult_s"
d(a5, i)
function a5.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() } }
end
function a5.prototype.OnCustomAttackLanded(self, z)
	if self:HasTalent("kez_talent_5") and z.attacker:HasModifier("kez_ult_s_buff") then
		if IsValid(z.ability) and z.ability:GetAbilityName() == "kez_ult_s" then
			return
		end
		local t = z.attacker
		local w = z.target
		if IsInjurable(t, w) then
			local P = self:GetAbility()
			local a6 = false
			local G = t:GetAbsOrigin() - w:GetAbsOrigin()
			G.z = 0
			G = G:Normalized()
			G = Rotation2D(nil, G, math.rad(math.random(0, 90) - 45))
			local a7 = w:GetAbsOrigin() + G * 150
			local W = P:GetToggleState() and 1 or 0
			local a8 = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/kez_sai_afterimage_cast.vpcf",
				PATTACH_ABSORIGIN,
				t
			)
			ParticleManager:SetParticleControlEnt(a8, 1, w, PATTACH_ABSORIGIN_FOLLOW, nil, w:GetAbsOrigin(), true)
			ParticleManager:SetParticleControl(a8, 2, a7)
			ParticleManager:SetParticleControl(a8, 4, a7)
			ParticleManager:SetParticleControl(a8, 5, Vector(W, 0, 0))
			GameTimer(1, function()
				ParticleManager:DestroyParticle(a8, false)
				ParticleManager:ReleaseParticleIndex(a8)
				if not (IsValid(self) and IsValid(P) and IsInjurable(t, w)) then
					return
				end
				if not a6 then
					local I = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_kez/kez_sai_afterimage_tracking.vpcf",
						PATTACH_CUSTOMORIGIN,
						t
					)
					ParticleManager:SetParticleControlEnt(I, 0, t, PATTACH_ABSORIGIN, nil, t:GetAbsOrigin(), true)
					ParticleManager:SetParticleControl(I, 1, w:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(I, 2, t, PATTACH_ABSORIGIN, nil, t:GetAbsOrigin(), false)
					ParticleManager:SetParticleControlEnt(I, 3, t, PATTACH_ABSORIGIN, nil, t:GetAbsOrigin(), false)
					ParticleManager:SetParticleControl(I, 4, a7)
					ParticleManager:SetParticleControl(I, 5, Vector(W, 0, 0))
					w:EmitSound("Hero_Kez.FalconRush.Sai.Target.Layer")
					a6 = true
					return 0.2
				else
					w:EmitSound("Hero_Kez.FalconRush.Sai.Target")
					DamageSystem:performAttack(
						t,
						w,
						{
							ability = self:GetAbility(),
							damage_flags = W == 0 and DamageFlags.DAMAGE_FLAG_KEZ or DamageFlags.DAMAGE_FLAG_NONE,
						}
					)
				end
			end)
		end
	end
end
a5 = e(
	{
		j(
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
	a5
)
g.modifier_kez_ult_s = a5
g.kez_ult_s_buff = c()
local a9 = g.kez_ult_s_buff
a9.name = "kez_ult_s_buff"
d(a9, i)
function a9.prototype.GetAbilitySpecialValue(self)
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.s_evade = self:GetAbilityTalentValue("kez_shard", "evade")
end
function a9.prototype.OnCreated(self, r)
	if not IsServer() then
		local t = self:GetParent()
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kez/kez_sai_afterimage_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		ParticleManager:SetParticleControlEnt(I, 1, t, PATTACH_POINT_FOLLOW, "eye_l", t:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(I, 2, t, PATTACH_POINT_FOLLOW, "eye_r", t:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(I, 3, t, PATTACH_POINT_FOLLOW, "attach_attack1", t:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(I, 4, t, PATTACH_POINT_FOLLOW, "attach_attack2", t:GetAbsOrigin(), true)
		self:AddParticle(I, false, false, -1, false, false)
	end
end
function a9.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attack_speed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.s_evade,
	}
end
a9 = e(
	{
		j(
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
g.kez_ult_s_buff = a9
g.kez_interact = c()
local aa = g.kez_interact
aa.name = "kez_interact"
d(aa, l)
function aa.prototype.Spawn(self)
	if IsServer() then
		self:GetCaster():RemoveActivityModifier("kunai")
	end
end
function aa.prototype.OnSpellStart(self)
	self:ToggleAbility()
end
function aa.prototype.OnToggle(self)
	if IsServer() then
		local v = self:GetCaster()
		local ab = self:GetToggleState()
		if ab then
			v:AddActivityModifier("kunai")
			v:RemoveModifierByName("modifier_kez_katana")
			v:AddNewModifier(v, self, "modifier_kez_sai", nil)
		else
			v:RemoveActivityModifier("kunai")
			v:RemoveModifierByName("modifier_kez_sai")
			v:AddNewModifier(v, self, "modifier_kez_katana", nil)
		end
		local B = v:FindModifierByName("modifier_kez_interact")
		if IsValid(B) then
			B:SwichSkill(ab)
		end
	end
end
function aa.prototype.AddPlusEffect(self)
	local v = self:GetCaster()
	v:AddNewModifier(v, self, "modifier_kez_interact_plus", nil)
end
function aa.prototype.GetIntrinsicModifierName(self)
	return "modifier_kez_interact"
end
aa = e(
	{
		n(
			nil,
			{
				ActiveTextureName = "kez_switch_weapons_sai",
				InactiveTextureName = "kez_switch_weapons_katana",
				talent_ability1 = "kez_talent",
				talent_ability2 = "kez_talent_s",
				ult_ability1 = "kez_ult",
				ult_ability2 = "kez_ult_s",
			}
		),
	},
	aa
)
g.kez_interact = aa
g.modifier_kez_interact = c()
local ac = g.modifier_kez_interact
ac.name = "modifier_kez_interact"
d(ac, i)
function ac.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.counter = 0
	self.battling = false
end
function ac.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count") - self:GetAbilityTalentValue("kez_talent_1", "count")
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.tl6_chance = self:GetAbilityTalentValue("kez_talent_6", "chance")
	self.tl3_percent = self:GetAbilityTalentValue("kez_talent_3", "percent")
end
function ac.prototype.SwichSkill(self, ad)
	if not self.battling then
		return
	end
	local t = self:GetParent()
	local ae = t:HasModifier("modifier_kez_interact_plus")
	if ad then
		if self.tl3_percent > 0 then
			local P = t:FindAbilityByName("kez_ult")
			if IsValid(P) then
				P:OnSpellStart(self.tl3_percent)
			end
		end
		if ae then
			local af = t:FindModifierByName("modifier_kez_talent")
			if IsValid(af) then
				af:SwapSkill(self:GetAbility())
			end
		end
	else
		if self.tl3_percent > 0 then
			local P = t:FindAbilityByName("kez_ult_s")
			if IsValid(P) then
				P:OnSpellStart(self.tl3_percent)
			end
		end
		if ae then
			local af = t:FindModifierByName("modifier_kez_talent_s")
			if IsValid(af) then
				af:SwapSkill(self:GetAbility())
			end
		end
	end
end
function ac.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() },
	}
end
function ac.prototype.OnBattleStartBefore(self, r)
	self.counter = 0
	self.battling = true
end
function ac.prototype.OnBattleEnd(self, r)
	self.battling = false
end
function ac.prototype.OnDamageStart(self, z)
	if not self.battling then
		return
	end
	if z.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		local P = self:GetAbility()
		if self.tl6_chance > 0 and self:PRD(self.tl6_chance, "tl6_chance") then
			if P:GetToggleState() then
				local af = self:GetParent():FindModifierByName("modifier_kez_talent_s")
				if IsValid(af) then
					af:SwapSkill(P)
				end
			else
				local af = self:GetParent():FindModifierByName("modifier_kez_talent")
				if IsValid(af) then
					af:SwapSkill(P)
				end
			end
		end
		self.counter = self.counter + 1
		if self.counter >= self.count then
			self.counter = 0
			self:GetAbility():CastAbility()
		end
		P:SetCurrentAbilityCharges(self.counter)
	end
end
function ac.prototype.OnCustomTakeDamage(self, z)
	if
		z.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
		and IsValid(z.ability)
		and z.ability:GetAbilityName() == "kez_interact"
	then
		Heal(
			z.attacker,
			z.damage * self.heal_pct * 0.01,
			"kez_interact",
			"Ability",
			false,
			HealFlags.HEAL_FLAG_LIFESETEAL
		)
	end
end
ac = e(
	{
		j(
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
g.modifier_kez_interact = ac
g.modifier_kez_sai = c()
local ag = g.modifier_kez_sai
ag.name = "modifier_kez_sai"
d(ag, i)
function ag.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function ag.prototype.GetActivityTranslationModifiers(self)
	return "kunai"
end
ag = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	ag
)
g.modifier_kez_sai = ag
g.modifier_kez_katana = c()
local ah = g.modifier_kez_katana
ah.name = "modifier_kez_katana"
d(ah, i)
function ah.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function ah.prototype.GetActivityTranslationModifiers(self)
	return ""
end
ah = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_ULTRA,
			}
		),
	},
	ah
)
g.modifier_kez_katana = ah
g.modifier_kez_interact_plus = c()
local ai = g.modifier_kez_interact_plus
ai.name = "modifier_kez_interact_plus"
d(ai, i)
function ai.prototype.OnCreated(self, r)
	if not IsServer() then
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_troll_warlord/troll_warlord_battletrance_buff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(I, 60, Vector(255, 0, 0))
		ParticleManager:SetParticleControl(I, 61, Vector(1, 0, 0))
		self:AddParticle(I, false, false, -1, false, false)
	end
end
ai = e(
	{
		j(
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
	ai
)
g.modifier_kez_interact_plus = ai
return g