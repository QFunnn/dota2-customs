--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/lone_druid"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 6,
		["18"] = 14,
		["19"] = 6,
		["20"] = 14,
		["21"] = 17,
		["22"] = 19,
		["23"] = 21,
		["24"] = 22,
		["25"] = 17,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 28,
		["32"] = 30,
		["33"] = 31,
		["34"] = 31,
		["35"] = 31,
		["36"] = 31,
		["37"] = 31,
		["38"] = 31,
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["42"] = 32,
		["43"] = 32,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["48"] = 32,
		["49"] = 32,
		["51"] = 24,
		["52"] = 35,
		["53"] = 36,
		["55"] = 35,
		["56"] = 39,
		["57"] = 40,
		["58"] = 41,
		["59"] = 39,
		["60"] = 45,
		["61"] = 46,
		["62"] = 46,
		["63"] = 46,
		["64"] = 46,
		["65"] = 46,
		["66"] = 46,
		["67"] = 46,
		["68"] = 46,
		["69"] = 46,
		["70"] = 45,
		["71"] = 52,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 53,
		["79"] = 52,
		["80"] = 61,
		["81"] = 62,
		["82"] = 61,
		["83"] = 68,
		["84"] = 69,
		["85"] = 68,
		["86"] = 71,
		["87"] = 72,
		["88"] = 71,
		["89"] = 74,
		["90"] = 75,
		["91"] = 74,
		["92"] = 77,
		["93"] = 78,
		["94"] = 77,
		["95"] = 14,
		["96"] = 6,
		["97"] = 6,
		["98"] = 6,
		["99"] = 6,
		["100"] = 6,
		["101"] = 6,
		["102"] = 6,
		["103"] = 6,
		["104"] = 14,
		["106"] = 14,
		["107"] = 82,
		["108"] = 90,
		["109"] = 82,
		["110"] = 90,
		["111"] = 97,
		["112"] = 99,
		["113"] = 100,
		["114"] = 101,
		["115"] = 102,
		["116"] = 97,
		["117"] = 104,
		["118"] = 105,
		["119"] = 106,
		["120"] = 107,
		["121"] = 108,
		["124"] = 104,
		["125"] = 112,
		["126"] = 113,
		["127"] = 114,
		["128"] = 115,
		["129"] = 116,
		["130"] = 117,
		["131"] = 118,
		["132"] = 119,
		["133"] = 119,
		["134"] = 119,
		["135"] = 120,
		["136"] = 121,
		["137"] = 122,
		["140"] = 125,
		["141"] = 126,
		["142"] = 127,
		["145"] = 119,
		["146"] = 119,
		["149"] = 112,
		["150"] = 134,
		["151"] = 135,
		["152"] = 136,
		["153"] = 137,
		["156"] = 134,
		["157"] = 141,
		["158"] = 142,
		["159"] = 141,
		["160"] = 146,
		["161"] = 147,
		["162"] = 146,
		["163"] = 149,
		["164"] = 150,
		["165"] = 149,
		["166"] = 154,
		["167"] = 156,
		["168"] = 156,
		["169"] = 156,
		["170"] = 156,
		["171"] = 156,
		["172"] = 156,
		["173"] = 156,
		["174"] = 156,
		["175"] = 156,
		["176"] = 156,
		["177"] = 156,
		["178"] = 156,
		["179"] = 156,
		["180"] = 156,
		["181"] = 156,
		["182"] = 156,
		["183"] = 156,
		["184"] = 156,
		["185"] = 156,
		["186"] = 175,
		["187"] = 175,
		["188"] = 175,
		["189"] = 175,
		["190"] = 175,
		["191"] = 175,
		["192"] = 175,
		["193"] = 175,
		["194"] = 175,
		["195"] = 176,
		["196"] = 177,
		["197"] = 178,
		["198"] = 179,
		["199"] = 180,
		["200"] = 181,
		["201"] = 154,
		["202"] = 90,
		["203"] = 82,
		["204"] = 82,
		["205"] = 82,
		["206"] = 82,
		["207"] = 82,
		["208"] = 82,
		["209"] = 82,
		["210"] = 82,
		["211"] = 90,
		["213"] = 90,
		["214"] = 186,
		["215"] = 187,
		["216"] = 186,
		["217"] = 187,
		["218"] = 188,
		["219"] = 189,
		["220"] = 188,
		["221"] = 187,
		["222"] = 186,
		["223"] = 187,
		["225"] = 187,
		["226"] = 193,
		["227"] = 201,
		["228"] = 193,
		["229"] = 201,
		["231"] = 201,
		["232"] = 220,
		["233"] = 193,
		["234"] = 221,
		["235"] = 223,
		["236"] = 225,
		["237"] = 226,
		["238"] = 227,
		["239"] = 228,
		["240"] = 230,
		["241"] = 231,
		["242"] = 221,
		["243"] = 233,
		["244"] = 234,
		["245"] = 235,
		["246"] = 236,
		["248"] = 233,
		["249"] = 239,
		["250"] = 240,
		["251"] = 239,
		["252"] = 248,
		["253"] = 249,
		["254"] = 250,
		["255"] = 250,
		["256"] = 250,
		["257"] = 250,
		["258"] = 251,
		["259"] = 248,
		["260"] = 253,
		["261"] = 254,
		["262"] = 255,
		["263"] = 256,
		["265"] = 253,
		["266"] = 259,
		["267"] = 260,
		["268"] = 261,
		["269"] = 262,
		["270"] = 263,
		["274"] = 267,
		["275"] = 268,
		["276"] = 269,
		["277"] = 270,
		["278"] = 271,
		["281"] = 274,
		["282"] = 274,
		["283"] = 274,
		["284"] = 274,
		["285"] = 274,
		["286"] = 274,
		["287"] = 275,
		["288"] = 276,
		["289"] = 277,
		["290"] = 278,
		["292"] = 259,
		["293"] = 281,
		["294"] = 282,
		["295"] = 283,
		["296"] = 284,
		["297"] = 284,
		["298"] = 284,
		["299"] = 284,
		["300"] = 284,
		["301"] = 284,
		["302"] = 284,
		["303"] = 284,
		["304"] = 285,
		["305"] = 286,
		["306"] = 287,
		["307"] = 288,
		["308"] = 289,
		["309"] = 290,
		["313"] = 294,
		["314"] = 295,
		["315"] = 296,
		["317"] = 281,
		["318"] = 305,
		["319"] = 306,
		["320"] = 306,
		["321"] = 306,
		["322"] = 306,
		["323"] = 306,
		["324"] = 306,
		["325"] = 306,
		["326"] = 306,
		["327"] = 305,
		["328"] = 315,
		["329"] = 316,
		["330"] = 317,
		["332"] = 315,
		["333"] = 320,
		["334"] = 321,
		["335"] = 322,
		["337"] = 320,
		["338"] = 326,
		["339"] = 327,
		["341"] = 328,
		["342"] = 328,
		["344"] = 328,
		["347"] = 328,
		["348"] = 328,
		["353"] = 329,
		["356"] = 326,
		["357"] = 333,
		["358"] = 334,
		["359"] = 335,
		["361"] = 333,
		["362"] = 201,
		["363"] = 193,
		["364"] = 193,
		["365"] = 193,
		["366"] = 193,
		["367"] = 193,
		["368"] = 193,
		["369"] = 193,
		["370"] = 193,
		["371"] = 201,
		["373"] = 201,
		["374"] = 340,
		["375"] = 348,
		["376"] = 340,
		["377"] = 348,
		["378"] = 349,
		["379"] = 349,
		["380"] = 352,
		["381"] = 352,
		["382"] = 348,
		["383"] = 340,
		["384"] = 340,
		["385"] = 340,
		["386"] = 340,
		["387"] = 340,
		["388"] = 340,
		["389"] = 340,
		["390"] = 340,
		["391"] = 348,
		["393"] = 348,
		["394"] = 356,
		["395"] = 364,
		["396"] = 356,
		["397"] = 364,
		["398"] = 365,
		["399"] = 365,
		["400"] = 368,
		["401"] = 368,
		["402"] = 364,
		["403"] = 356,
		["404"] = 356,
		["405"] = 356,
		["406"] = 356,
		["407"] = 356,
		["408"] = 356,
		["409"] = 356,
		["410"] = 356,
		["411"] = 364,
		["413"] = 364,
		["414"] = 373,
		["415"] = 374,
		["416"] = 373,
		["417"] = 374,
		["418"] = 375,
		["419"] = 376,
		["420"] = 377,
		["421"] = 378,
		["422"] = 379,
		["423"] = 379,
		["424"] = 379,
		["425"] = 380,
		["426"] = 381,
		["427"] = 382,
		["428"] = 382,
		["429"] = 382,
		["430"] = 382,
		["431"] = 382,
		["432"] = 383,
		["433"] = 379,
		["434"] = 379,
		["435"] = 375,
		["436"] = 374,
		["437"] = 373,
		["438"] = 374,
		["440"] = 374,
		["441"] = 388,
		["442"] = 395,
		["443"] = 388,
		["444"] = 395,
		["445"] = 396,
		["446"] = 397,
		["447"] = 398,
		["448"] = 399,
		["449"] = 399,
		["450"] = 399,
		["451"] = 399,
		["452"] = 399,
		["453"] = 399,
		["454"] = 399,
		["455"] = 399,
		["456"] = 399,
		["457"] = 400,
		["458"] = 400,
		["459"] = 400,
		["460"] = 400,
		["461"] = 400,
		["462"] = 400,
		["463"] = 400,
		["464"] = 400,
		["465"] = 400,
		["466"] = 401,
		["467"] = 401,
		["468"] = 401,
		["469"] = 401,
		["470"] = 401,
		["471"] = 401,
		["472"] = 401,
		["473"] = 401,
		["475"] = 396,
		["476"] = 395,
		["477"] = 388,
		["478"] = 388,
		["479"] = 388,
		["480"] = 388,
		["481"] = 388,
		["482"] = 388,
		["483"] = 388,
		["484"] = 395,
		["486"] = 395,
		["487"] = 406,
		["488"] = 410,
		["489"] = 406,
		["490"] = 410,
		["491"] = 411,
		["492"] = 412,
		["493"] = 411,
		["494"] = 414,
		["495"] = 415,
		["496"] = 416,
		["498"] = 419,
		["499"] = 420,
		["500"] = 421,
		["501"] = 421,
		["502"] = 421,
		["503"] = 421,
		["504"] = 422,
		["505"] = 423,
		["506"] = 424,
		["507"] = 424,
		["508"] = 424,
		["509"] = 424,
		["511"] = 426,
		["512"] = 414,
		["513"] = 428,
		["514"] = 429,
		["515"] = 430,
		["517"] = 432,
		["518"] = 433,
		["519"] = 434,
		["520"] = 434,
		["521"] = 434,
		["523"] = 434,
		["524"] = 435,
		["525"] = 436,
		["526"] = 437,
		["527"] = 438,
		["530"] = 441,
		["531"] = 428,
		["532"] = 444,
		["533"] = 445,
		["534"] = 446,
		["535"] = 447,
		["536"] = 448,
		["537"] = 449,
		["538"] = 450,
		["539"] = 451,
		["540"] = 452,
		["544"] = 456,
		["545"] = 457,
		["546"] = 457,
		["547"] = 457,
		["549"] = 457,
		["550"] = 458,
		["551"] = 459,
		["553"] = 444,
		["554"] = 463,
		["555"] = 463,
		["556"] = 463,
		["558"] = 464,
		["559"] = 465,
		["560"] = 466,
		["563"] = 469,
		["564"] = 470,
		["565"] = 471,
		["566"] = 463,
		["567"] = 474,
		["568"] = 475,
		["569"] = 474,
		["570"] = 410,
		["571"] = 406,
		["572"] = 410,
		["574"] = 410,
		["575"] = 479,
		["576"] = 487,
		["577"] = 479,
		["578"] = 487,
		["579"] = 489,
		["580"] = 490,
		["581"] = 489,
		["582"] = 492,
		["583"] = 493,
		["584"] = 492,
		["585"] = 498,
		["586"] = 499,
		["589"] = 502,
		["590"] = 503,
		["591"] = 504,
		["592"] = 505,
		["593"] = 507,
		["595"] = 509,
		["596"] = 510,
		["597"] = 511,
		["598"] = 512,
		["599"] = 513,
		["603"] = 498,
		["604"] = 518,
		["605"] = 520,
		["606"] = 518,
		["607"] = 487,
		["608"] = 479,
		["609"] = 479,
		["610"] = 479,
		["611"] = 479,
		["612"] = 479,
		["613"] = 479,
		["614"] = 479,
		["615"] = 479,
		["616"] = 487,
		["618"] = 487,
		["619"] = 525,
		["620"] = 526,
		["621"] = 525,
		["622"] = 526,
		["623"] = 527,
		["624"] = 528,
		["625"] = 527,
		["626"] = 526,
		["627"] = 525,
		["628"] = 526,
		["630"] = 526,
		["631"] = 531,
		["632"] = 539,
		["633"] = 531,
		["634"] = 539,
		["635"] = 541,
		["636"] = 542,
		["637"] = 541,
		["638"] = 544,
		["639"] = 545,
		["640"] = 544,
		["641"] = 549,
		["642"] = 550,
		["643"] = 551,
		["644"] = 552,
		["645"] = 552,
		["646"] = 552,
		["647"] = 552,
		["648"] = 552,
		["649"] = 552,
		["652"] = 549,
		["653"] = 539,
		["654"] = 531,
		["655"] = 531,
		["656"] = 531,
		["657"] = 531,
		["658"] = 531,
		["659"] = 531,
		["660"] = 531,
		["661"] = 531,
		["662"] = 539,
		["664"] = 539,
		["665"] = 560,
		["666"] = 568,
		["667"] = 560,
		["668"] = 568,
		["669"] = 569,
		["670"] = 570,
		["671"] = 569,
		["672"] = 575,
		["673"] = 576,
		["674"] = 577,
		["675"] = 578,
		["676"] = 575,
		["677"] = 580,
		["678"] = 581,
		["679"] = 582,
		["681"] = 580,
		["682"] = 585,
		["683"] = 586,
		["684"] = 587,
		["685"] = 588,
		["686"] = 589,
		["687"] = 590,
		["688"] = 590,
		["689"] = 590,
		["690"] = 590,
		["691"] = 590,
		["692"] = 590,
		["693"] = 591,
		["694"] = 591,
		["695"] = 591,
		["696"] = 591,
		["697"] = 591,
		["698"] = 591,
		["701"] = 585,
		["702"] = 568,
		["703"] = 560,
		["704"] = 560,
		["705"] = 560,
		["706"] = 560,
		["707"] = 560,
		["708"] = 560,
		["709"] = 560,
		["710"] = 560,
		["711"] = 568,
		["713"] = 568,
		["714"] = 596,
		["715"] = 604,
		["716"] = 596,
		["717"] = 604,
		["718"] = 607,
		["719"] = 608,
		["720"] = 609,
		["721"] = 607,
		["722"] = 611,
		["723"] = 612,
		["724"] = 613,
		["725"] = 614,
		["727"] = 616,
		["728"] = 617,
		["729"] = 618,
		["730"] = 618,
		["731"] = 618,
		["732"] = 618,
		["733"] = 618,
		["734"] = 618,
		["735"] = 618,
		["736"] = 618,
		["737"] = 619,
		["738"] = 620,
		["739"] = 620,
		["740"] = 620,
		["741"] = 620,
		["742"] = 620,
		["743"] = 620,
		["744"] = 620,
		["745"] = 620,
		["746"] = 620,
		["747"] = 621,
		["748"] = 621,
		["749"] = 621,
		["750"] = 621,
		["751"] = 621,
		["752"] = 621,
		["753"] = 621,
		["754"] = 621,
		["756"] = 611,
		["757"] = 624,
		["758"] = 625,
		["759"] = 626,
		["761"] = 624,
		["762"] = 629,
		["763"] = 630,
		["764"] = 631,
		["765"] = 631,
		["766"] = 631,
		["767"] = 631,
		["768"] = 631,
		["769"] = 631,
		["770"] = 632,
		["771"] = 633,
		["774"] = 629,
		["775"] = 637,
		["776"] = 638,
		["777"] = 639,
		["779"] = 637,
		["780"] = 604,
		["781"] = 596,
		["782"] = 596,
		["783"] = 596,
		["784"] = 596,
		["785"] = 596,
		["786"] = 596,
		["787"] = 596,
		["788"] = 596,
		["789"] = 604,
		["791"] = 604,
		["792"] = 647,
		["793"] = 648,
		["794"] = 647,
		["795"] = 648,
		["796"] = 649,
		["797"] = 650,
		["798"] = 649,
		["799"] = 648,
		["800"] = 647,
		["801"] = 648,
		["803"] = 648,
		["804"] = 654,
		["805"] = 662,
		["806"] = 654,
		["807"] = 662,
		["809"] = 662,
		["810"] = 666,
		["811"] = 654,
		["812"] = 667,
		["813"] = 668,
		["814"] = 669,
		["815"] = 667,
		["816"] = 671,
		["817"] = 672,
		["818"] = 673,
		["820"] = 671,
		["821"] = 676,
		["822"] = 677,
		["825"] = 678,
		["826"] = 678,
		["827"] = 678,
		["828"] = 678,
		["829"] = 678,
		["830"] = 678,
		["832"] = 678,
		["833"] = 679,
		["834"] = 680,
		["835"] = 680,
		["836"] = 680,
		["837"] = 680,
		["838"] = 680,
		["839"] = 681,
		["840"] = 682,
		["842"] = 684,
		["844"] = 676,
		["845"] = 687,
		["846"] = 688,
		["847"] = 689,
		["848"] = 690,
		["849"] = 691,
		["850"] = 692,
		["851"] = 692,
		["852"] = 692,
		["853"] = 692,
		["854"] = 692,
		["855"] = 692,
		["856"] = 692,
		["857"] = 692,
		["858"] = 692,
		["859"] = 693,
		["860"] = 693,
		["861"] = 693,
		["862"] = 693,
		["863"] = 693,
		["864"] = 693,
		["865"] = 693,
		["866"] = 693,
		["867"] = 693,
		["868"] = 694,
		["869"] = 695,
		["870"] = 696,
		["871"] = 696,
		["872"] = 696,
		["873"] = 697,
		["874"] = 698,
		["875"] = 699,
		["877"] = 696,
		["878"] = 696,
		["880"] = 703,
		["883"] = 687,
		["884"] = 707,
		["885"] = 708,
		["886"] = 707,
		["887"] = 712,
		["888"] = 713,
		["889"] = 712,
		["890"] = 717,
		["891"] = 718,
		["892"] = 719,
		["894"] = 717,
		["895"] = 722,
		["896"] = 723,
		["897"] = 724,
		["898"] = 725,
		["899"] = 726,
		["901"] = 728,
		["902"] = 729,
		["903"] = 722,
		["904"] = 731,
		["905"] = 732,
		["906"] = 733,
		["907"] = 734,
		["909"] = 731,
		["910"] = 737,
		["911"] = 738,
		["912"] = 737,
		["913"] = 743,
		["914"] = 744,
		["915"] = 743,
		["916"] = 746,
		["917"] = 747,
		["918"] = 746,
		["919"] = 749,
		["920"] = 750,
		["921"] = 749,
		["922"] = 662,
		["923"] = 654,
		["924"] = 654,
		["925"] = 654,
		["926"] = 654,
		["927"] = 654,
		["928"] = 654,
		["929"] = 654,
		["930"] = 654,
		["931"] = 662,
		["933"] = 662,
		["934"] = 756,
		["935"] = 764,
		["936"] = 756,
		["937"] = 764,
		["938"] = 765,
		["939"] = 766,
		["940"] = 767,
		["941"] = 768,
		["943"] = 765,
		["944"] = 771,
		["945"] = 772,
		["946"] = 773,
		["947"] = 774,
		["949"] = 771,
		["950"] = 777,
		["951"] = 778,
		["952"] = 779,
		["954"] = 777,
		["955"] = 764,
		["956"] = 756,
		["957"] = 756,
		["958"] = 756,
		["959"] = 756,
		["960"] = 756,
		["961"] = 756,
		["962"] = 756,
		["963"] = 756,
		["964"] = 764,
		["966"] = 764,
		["967"] = 785,
		["968"] = 785,
		["969"] = 786,
		["970"] = 787,
		["971"] = 788,
		["972"] = 787,
		["973"] = 786,
		["974"] = 785,
		["975"] = 786,
		["977"] = 791,
		["978"] = 791,
		["979"] = 799,
		["980"] = 800,
		["981"] = 801,
		["982"] = 800,
		["983"] = 799,
		["984"] = 791,
		["985"] = 791,
		["986"] = 791,
		["987"] = 791,
		["988"] = 791,
		["989"] = 791,
		["990"] = 791,
		["991"] = 791,
		["992"] = 799,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.interact_ability")
local o = n.InteractAbility
local p = n.registerInteractAbility
g.modifier_lone_druid_bear = c()
local q = g.modifier_lone_druid_bear
q.name = "modifier_lone_druid_bear"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	local r = self:GetAbilityTalentValue("lone_druid_talent_1", "bear_bonus")
	self.tl7_as_bonus = self:GetAbilityTalentValue("lone_druid_talent_7", "as_bonus")
	self.wisp_attack_bonus = self:GetAbilitySpecialValueFor("wisp_attack_bonus") * (1 + r * 0.01)
end
function q.prototype.OnCreated(self, s)
	if IsServer() then
		local t = self.caster:GetPlayerOwnerID()
		local u = PlayerData:getHeroLevel(t)
		self:SetStackCount(u)
	else
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lone_druid/lone_druid_loadout.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			v,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			false
		)
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function q.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function q.prototype.EDeclareEvents(self)
	local w = self:GetParent()
	return { [MODIFIER_EVENT_ON_ATTACK_LANDED] = { w, -1 } }
end
function q.prototype.OnAttackLanded(self, s)
	DamageSystem:performAttack(
		self.caster,
		self.caster:GetEnemy(),
		{
			damage = GetAttackDamage(self.parent),
			ability = self.ability,
			damage_flags = DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK + DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK,
		}
	)
end
function q.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function q.prototype.EOM_GetModifierAttackDamageBase(self, s)
	return self:GetStackCount() * self.wisp_attack_bonus
end
function q.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.tl7_as_bonus
end
function q.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT }
end
function q.prototype.GetModifierBaseAttackTimeConstant(self)
	return GetAttackRate(self:GetParent())
end
q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	q
)
g.modifier_lone_druid_bear = q
g.modifier_lone_druid_bear_wisp = c()
local x = g.modifier_lone_druid_bear_wisp
x.name = "modifier_lone_druid_bear_wisp"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	local r = self:GetAbilityTalentValue("lone_druid_talent_1", "bear_bonus")
	self.wisp_attack_interval_reduce = self:GetAbilitySpecialValueFor("wisp_attack_interval_reduce") * (1 + r * 0.01)
	self.wisp_regen_interval = self:GetAbilitySpecialValueFor("wisp_regen_interval")
	self.wisp_regen = self:GetAbilitySpecialValueFor("wisp_regen")
end
function x.prototype.OnCreated(self, s)
	if IsServer() then
		self:GetParent():AddNoDraw()
		if self.wisp_regen > 0 then
			self:StartIntervalThink(self.wisp_regen_interval)
		end
	end
end
function x.prototype.OnRemoved(self)
	if IsServer() then
		local y = self.bear
		local w = self.parent
		if IsValid(y) then
			y:ForceKill(false)
			local z = false
			GameTimer(0.2, function()
				if z then
					if IsValid(y) then
						y:SafeRemoveUnit()
					end
				else
					z = true
					if IsValid(w) then
						return 5
					end
				end
			end)
		end
	end
end
function x.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.wisp_regen > 0 then
			HealSingleWisp(self.caster, self.parent, self.ability, self.wisp_regen)
		end
	end
end
function x.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.caster, self.caster } }
end
function x.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function x.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_SINGLE_WISP_DISARMED] = true }
end
function x.prototype.SpawnBear(self)
	local A = {
		BaseClass = "npc_dota_creature",
		Model = "models/heroes/lone_druid/spirit_bear.vmdl",
		ModelScale = 1,
		MovementCapabilities = "DOTA_UNIT_CAP_MOVE_NONE",
		AttackAnimationPoint = 0.4,
		AttackRate = WISP_ATTACK_RATE - self.wisp_attack_interval_reduce,
		StatusHealth = 100,
		StatusHealthRegen = 0,
		StatusMana = 0,
		ManaRegen = 0,
		AttackDamage = WISP_BASE_DAMAGE,
		AttackRange = 900,
		AttackAcquisitionRange = 900,
		VisionDaytimeRange = 2000,
		VisionNighttimeRange = 2000,
		SoundSet = "LoneDruid_SpiritBear",
		AttackCapabilities = "DOTA_UNIT_CAP_MELEE_ATTACK",
	}
	self.bear = CreateUnitByNameWithNewData(
		"npc_custom_phantom",
		self.parent:GetAbsOrigin(),
		false,
		self.parent,
		self.parent,
		self.parent:GetTeamNumber(),
		A
	)
	local B = self.caster:GetEnemy():GetAbsOrigin() - self.caster:GetAbsOrigin()
	B.z = 0
	B = B:Normalized()
	self.bear:SetForwardVector(B)
	self.bear:AddNewModifier(self.caster, self.ability, "modifier_lone_druid_bear", {})
	return self.bear
end
x = e(
	{
		m(
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
g.modifier_lone_druid_bear_wisp = x
g.lone_druid_talent = c()
local C = g.lone_druid_talent
C.name = "lone_druid_talent"
d(C, i)
function C.prototype.GetIntrinsicModifierName(self)
	return "modifier_lone_druid_talent"
end
C = e({ j(nil) }, C)
g.lone_druid_talent = C
g.modifier_lone_druid_talent = c()
local D = g.modifier_lone_druid_talent
D.name = "modifier_lone_druid_talent"
d(D, l)
function D.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hero_level = 0
end
function D.prototype.GetAbilitySpecialValue(self)
	self.life_steal_share = self:GetAbilitySpecialValueFor("life_steal_share")
		+ self:GetAbilityTalentValue("lone_druid_talent_7", "lf_bonus")
	local r = self:GetAbilityTalentValue("lone_druid_talent_1", "bear_bonus")
	self.wisp_attack_bonus = self:GetAbilitySpecialValueFor("wisp_attack_bonus") * (1 + r * 0.01)
	self.wisp_health_bonus = self:GetAbilitySpecialValueFor("wisp_health_bonus") * (1 + r * 0.01)
	self.wisp_attack_interval_reduce = self:GetAbilitySpecialValueFor("wisp_attack_interval_reduce")
	self.tl4_hero_bonus = self:GetAbilityTalentValue("lone_druid_talent_4", "hero_bonus")
	self.tl5_wisp_count = self:GetAbilityTalentValue("lone_druid_talent_5", "wisp_count")
end
function D.prototype.OnCreated(self, s)
	if IsServer() then
		self.hero_level = PlayerData:getHeroLevel(self.parent:GetPlayerOwnerID())
		self:SetStackCount(self.hero_level)
	end
end
function D.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CLEAR_TALENT] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FIRST_WISP_SPAWN] = { self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent },
	}
end
function D.prototype.OnClearTalent(self, s)
	PlayerData:saveData(s.playerID, "lone_druid_form_stage", 0)
	local E = Wearable:serviceGetEquipWearable(self.parent:GetPlayerOwnerID(), self.caster:GetUnitName())
	Wearable:equipWearable(self.caster, E)
end
function D.prototype.OnBattleStartBefore(self, s)
	if IsServer() then
		self.hero_level = PlayerData:getHeroLevel(self.parent:GetPlayerOwnerID())
		self:SetStackCount(self.hero_level)
	end
end
function D.prototype.OnFirstWispSpawn(self, s)
	local F = self:HasTalent("lone_druid_talent_3")
	if not F then
		local G = self.parent:FindAbilityByName("lone_druid_interact")
		if not G:BearCheck() then
			return
		end
	end
	local H = s.wisp
	if F or not s.success then
		local I = self:EOM_GetModifierWispHealthBonus({ bear = true }) or 0
		if I > 0 then
			H = SummonWisp(self.parent, I)
		end
	end
	local J = H:AddNewModifier(self.parent, self:GetAbility(), "modifier_lone_druid_bear_wisp", {})
	self.bearLinkedWisp = H
	self.bear = J:SpawnBear()
	if self:HasTalent("lone_druid_shard") then
		InheritSectAttackAbility(self.parent, self.bear)
	end
end
function D.prototype.OnCustomAttackLanded(self, K)
	local L = K.damage * self.life_steal_share * 0.01
	if
		K.damage_flags ~= nil
		and bit.band(K.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK)
			== DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
	then
		Heal(self.parent, L, "lone_druid_talent", "Ability", false, HealFlags.HEAL_FLAG_LIFESETEAL)
		if IsValid(self.bear) then
			local M = GetModifierProperty(self.bear, EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL, K)
			if M > 0 then
				HealSingleWisp(self.parent, self.bearLinkedWisp, self.ability, K.damage * M * 0.01)
				local v = ParticleManager:CreateParticle(
					"particles/generic_gameplay/generic_lifesteal.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self.bear
				)
				ParticleManager:ReleaseParticleIndex(v)
			end
		end
	else
		HealSingleWisp(self.parent, self.bearLinkedWisp, self.ability, L)
		local v = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_lifesteal.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.bear
		)
		ParticleManager:ReleaseParticleIndex(v)
	end
end
function D.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_ATTACK,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS,
	}
end
function D.prototype.EOM_GetModifierHealthBonus(self, s)
	if self.tl4_hero_bonus > 0 then
		return self.wisp_health_bonus * self:GetStackCount() * self.tl4_hero_bonus * 0.01
	end
end
function D.prototype.EOM_GetModifierAttackRateBonus(self, s)
	if self.tl4_hero_bonus > 0 then
		return -self.wisp_attack_interval_reduce * self.tl4_hero_bonus * 0.01
	end
end
function D.prototype.EOM_GetModifierWispHealthBonus(self, s)
	if IsServer() then
		local N
		if s ~= nil then
			N = s.first
		end
		local O = N
		if not O then
			local P
			if s ~= nil then
				P = s.bear
			end
			O = P
		end
		if O then
			return self.wisp_health_bonus * self.hero_level
		end
	end
end
function D.prototype.EOM_GetModifierAttackDamageBonus(self, s)
	if self.tl4_hero_bonus > 0 then
		return self.wisp_attack_bonus * self:GetStackCount() * self.tl4_hero_bonus * 0.01
	end
end
D = e(
	{
		m(
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
	D
)
g.modifier_lone_druid_talent = D
g.modifier_sect_wisp_hero = c()
local Q = g.modifier_sect_wisp_hero
Q.name = "modifier_sect_wisp_hero"
d(Q, l)
function Q.prototype.OnCreated(self, s) end
function Q.prototype.OnDestroy(self) end
Q = e(
	{
		m(
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
g.modifier_sect_wisp_hero = Q
g.modifier_sect_attack_wisp = c()
local R = g.modifier_sect_attack_wisp
R.name = "modifier_sect_attack_wisp"
d(R, l)
function R.prototype.OnCreated(self, s) end
function R.prototype.OnDestroy(self) end
R = e(
	{
		m(
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
g.modifier_sect_attack_wisp = R
g.lone_druid_ult = c()
local S = g.lone_druid_ult
S.name = "lone_druid_ult"
d(S, i)
function S.prototype.OnSpellStart(self)
	local T = self:GetTalentValue("lone_druid_ult", "duration")
	local U = self:GetCaster()
	U:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
	self:GameTimer(0.4, function()
		U:EmitSound("Hero_LoneDruid.Entangle.Cast")
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lone_druid/lone_druid_entangle_aoe.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			U
		)
		ParticleManager:SetParticleControl(v, 1, Vector(350, 0, 0))
		U:AddNewModifier(U, self, "modifier_lone_druid_ult", { duration = T })
	end)
end
S = e({ j(nil) }, S)
g.lone_druid_ult = S
g.modifier_lone_druid_ult = c()
local V = g.modifier_lone_druid_ult
V.name = "modifier_lone_druid_ult"
d(V, l)
function V.prototype.OnCreated(self, s)
	if IsClient() then
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lone_druid/lone_druid_entagle_buff.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			v,
			0,
			self.parent,
			PATTACH_OVERHEAD_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			false
		)
		ParticleManager:SetParticleControlEnt(
			v,
			1,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			self.parent:GetAbsOrigin(),
			false
		)
		self:AddParticle(v, false, false, -1, false, true)
	end
end
V = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, ShouldUseOverheadOffset = true }
	) },
	V
)
g.modifier_lone_druid_ult = V
g.lone_druid_interact = c()
local W = g.lone_druid_interact
W.name = "lone_druid_interact"
d(W, o)
function W.prototype.Spawn(self)
	self:UpdateCooldown()
end
function W.prototype.CustomToggleEnable(self)
	if self:HasTalent("lone_druid_talent_3") then
		return false
	end
	local X = GameState:isCeaseFireState()
	if not X then
		ErrorMessage(self:GetCaster():GetPlayerOwnerID(), "error_disabled_battling")
	elseif not self:GetToggleState() and self:GetCurrentAbilityCharges() > 0 then
		X = false
		ErrorMessage(self:GetCaster():GetPlayerOwnerID(), "error_cd")
	end
	return X
end
function W.prototype.BearCheck(self)
	if not self:GetToggleState() then
		return false
	end
	if not self:GetCaster():IsCustomIllusion() then
		local t = self:GetCaster():GetPlayerOwnerID()
		local Y = PlayerData:loadData(t, "lone_druid_interact_loss_state")
		if Y == nil then
			Y = 1
		end
		local Z = Y == 1
		if Z and self:GetCurrentAbilityCharges() == 0 then
			PlayerData:saveData(t, "lone_druid_interact_loss_state", 0)
			PlayerData:saveData(t, "lone_druid_interact", 0)
			self:UpdateCooldown()
		end
	end
	return true
end
function W.prototype.UpdateCooldown(self)
	if IsServer() then
		local t = self:GetCaster():GetPlayerOwnerID()
		local _ = self:GetSpecialValueFor("level")
		if
			self:HasTalent("lone_druid_talent_3")
			or PlayerData:getHeroLevel(self:GetCaster():GetPlayerOwnerID()) >= _
		then
			self:SetCurrentAbilityCharges(0)
			local a0 = PlayerData:getplayerData(t)
			if a0 then
				a0:SetInteractiveAbilityState(true, false, true)
			end
			return
		end
		local a1 = self:GetSpecialValueFor("round_trigger")
		local a2 = PlayerData:loadData(t, "lone_druid_interact")
		if a2 == nil then
			a2 = a1
		end
		local a3 = a2
		local a4 = math.max(0, a1 - a3)
		self:SetCurrentAbilityCharges(a4)
	end
end
function W.prototype.ReduceBearCooldown(self, a5)
	if a5 == nil then
		a5 = 1
	end
	local t = self:GetCaster():GetPlayerOwnerID()
	local a3 = PlayerData:loadData(t, "lone_druid_interact")
	if a3 == nil then
		return
	end
	a3 = a3 + a5
	PlayerData:saveData(t, "lone_druid_interact", a3)
	self:UpdateCooldown()
end
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_lone_druid_interact"
end
W = e(
	{ p(nil, { ActiveTextureName = "lone_druid_spirit_bear", InactiveTextureName = "lone_druid_interact_disable" }) },
	W
)
g.lone_druid_interact = W
g.modifier_lone_druid_interact = c()
local a6 = g.modifier_lone_druid_interact
a6.name = "modifier_lone_druid_interact"
d(a6, l)
function a6.prototype.GetAbilitySpecialValue(self)
	self.win_reduce = self:GetAbilitySpecialValueFor("win_reduce")
end
function a6.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function a6.prototype.OnBattleEnd(self, s)
	if self.parent:IsCustomIllusion() then
		return
	end
	local t = self.parent:GetPlayerOwnerID()
	if t ~= s.illusionPlayerID then
		if t == s.winPlayerID then
			if self.win_reduce > 0 then
				self.ability:ReduceBearCooldown(self.win_reduce)
			end
		elseif t == s.losePlayerID then
			local a0 = PlayerData:getplayerData(t)
			if a0 then
				PlayerData:saveData(t, "lone_druid_interact_loss_state", 1)
				a0:SetInteractiveAbilityState(false, false, true)
			end
		end
	end
end
function a6.prototype.OnPrepare(self, s)
	self.ability:ReduceBearCooldown()
end
a6 = e(
	{
		m(
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
	a6
)
g.modifier_lone_druid_interact = a6
g.lone_druid_root = c()
local a7 = g.lone_druid_root
a7.name = "lone_druid_root"
d(a7, i)
function a7.prototype.GetIntrinsicModifierName(self)
	return "modifier_lone_druid_root"
end
a7 = e({ j(nil) }, a7)
g.lone_druid_root = a7
g.modifier_lone_druid_root = c()
local a8 = g.modifier_lone_druid_root
a8.name = "modifier_lone_druid_root"
d(a8, l)
function a8.prototype.GetAbilitySpecialValue(self)
	self.tl5_enable = self:HasTalent("lone_druid_talent_5")
end
function a8.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent } }
end
function a8.prototype.OnCustomAttackLanded(self, K)
	if
		self.parent:HasModifier("modifier_lone_druid_ult")
		or bit.band(K.damage_flags, DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK) == DamageFlags.DAMAGE_FLAG_SPECIAL_ATTACK
	then
		if self.tl5_enable or not K.target:HasModifier("modifier_bear_entangle_root") then
			self.parent:GetEnemy():AddNewModifier(self.parent, self:GetAbility(), "modifier_lone_druid_debuff", {})
		end
	end
end
a8 = e(
	{
		m(
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
	a8
)
g.modifier_lone_druid_root = a8
g.modifier_lone_druid_debuff = c()
local a9 = g.modifier_lone_druid_debuff
a9.name = "modifier_lone_druid_debuff"
d(a9, l)
function a9.prototype.GetTexture(self)
	return "lone_druid_entangle"
end
function a9.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.stun = self:GetAbilitySpecialValueFor("stun")
end
function a9.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a9.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
		if self:GetStackCount() >= self.count then
			self:SetStackCount(self:GetStackCount() - self.count)
			self.parent:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_bear_entangle_root",
				{ duration = self.duration }
			)
			AddStun(self.caster, self.parent, self:GetAbility(), self.stun)
		end
	end
end
a9 = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	a9
)
g.modifier_lone_druid_debuff = a9
g.modifier_bear_entangle_root = c()
local aa = g.modifier_bear_entangle_root
aa.name = "modifier_bear_entangle_root"
d(aa, l)
function aa.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("tick")
		- self:GetAbilityTalentValue("lone_druid_talent_2", "reduce_interval")
end
function aa.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
	else
		EmitSoundOn("Hero_LoneDruid.Entangle.Cast", self.parent)
		local ab = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lone_druid/lone_druid_bear_entangle.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(ab, false, false, -1, false, false)
		local ac = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lone_druid/lone_druid_bear_entangle_body.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			ac,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			false
		)
		self:AddParticle(ac, false, false, -1, false, false)
	end
end
function aa.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function aa.prototype.OnIntervalThink(self)
	if IsServer() then
		self.caster:DealDamage(
			self.parent,
			self.ability,
			self.damage * self:GetStackCount(),
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		)
		if self:HasTalent("lone_druid_talent_5") then
			TriggerAllWisp(self.caster)
		end
	end
end
function aa.prototype.OnDestroy(self)
	if IsClient() then
		StopSoundOn("Hero_LoneDruid.Entangle.Cast", self.parent)
	end
end
aa = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	aa
)
g.modifier_bear_entangle_root = aa
g.lone_druid_talent_6 = c()
local ad = g.lone_druid_talent_6
ad.name = "lone_druid_talent_6"
d(ad, i)
function ad.prototype.GetIntrinsicModifierName(self)
	return "modifier_lone_druid_talent_6"
end
ad = e({ j(nil) }, ad)
g.lone_druid_talent_6 = ad
g.modifier_lone_druid_talent_6 = c()
local ae = g.modifier_lone_druid_talent_6
ae.name = "modifier_lone_druid_talent_6"
d(ae, l)
function ae.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.triggered = false
end
function ae.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilitySpecialValueFor("health_bonus")
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
end
function ae.prototype.OnCreated(self, s)
	if IsServer() then
		self:TriggerTransform()
	end
end
function ae.prototype.TriggerTransform(self)
	if self.triggered then
		return
	end
	local af = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "lone_druid_form_stage")
	if af == nil then
		af = 0
	end
	local ag = af
	if ag == 0 then
		PlayerData:saveData(self.parent:GetPlayerOwnerID(), "lone_druid_form_stage", 1)
		self.triggered = true
		self:StartIntervalThink(0.5)
	else
		self:FinishModelChange(true)
	end
end
function ae.prototype.OnIntervalThink(self)
	if IsServer() then
		if not self.parent:IsMoving() then
			self:StartIntervalThink(-1)
			local v = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_lone_druid/lone_druid_true_form.vpcf",
				PATTACH_CUSTOMORIGIN,
				self.parent
			)
			ParticleManager:SetParticleControlEnt(
				v,
				0,
				self.parent,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				self.parent:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				v,
				3,
				self.parent,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				self.parent:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(v)
			self.parent:AddNewModifier(self.caster, self.ability, "modifier_lone_druid_talent_6_tranforming", {})
			self.parent:GameTimer(2, function()
				self.parent:RemoveModifierByName("modifier_lone_druid_talent_6_tranforming")
				if IsValid(self) then
					self:FinishModelChange()
				end
			end)
		else
			self:StartIntervalThink(0)
		end
	end
end
function ae.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self.parent } }
end
function ae.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL] = Wearable:getReplaceParticle(
			self.parent,
			"models/heroes/lone_druid/true_form.vmdl"
		),
	}
end
function ae.prototype.OnTalentLearn(self, s)
	if s.talentName == "lone_druid_talent_6" then
		self:StartIntervalThink(0.5)
	end
end
function ae.prototype.FinishModelChange(self, ah)
	self.triggered = true
	if not ah then
		self.parent:SetOriginalModel(
			Wearable:getReplaceParticle(self.parent, "models/heroes/lone_druid/true_form.vmdl")
		)
		self.parent:ManageModelChanges()
	end
	self.parent:SetWearablesVisible(false)
	self.parent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
end
function ae.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
		self.parent:SetWearablesVisible(true)
	end
end
function ae.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function ae.prototype.EOM_GetModifierHealthBonus(self, s)
	return self.health_bonus
end
function ae.prototype.EOM_GetModifierIncomingDamagePercentage(self, s)
	return -self.damage_reduce
end
function ae.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_HERO_WISP] = true }
end
ae = e(
	{
		m(
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
	ae
)
g.modifier_lone_druid_talent_6 = ae
g.modifier_lone_druid_talent_6_tranforming = c()
local ai = g.modifier_lone_druid_talent_6_tranforming
ai.name = "modifier_lone_druid_talent_6_tranforming"
d(ai, l)
function ai.prototype.OnCreated(self, s)
	if IsServer() then
		self.parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
		self:StartIntervalThink(1.5)
	end
end
function ai.prototype.OnIntervalThink(self)
	if IsServer() then
		self.parent:SetModelScale(0.1)
		self:StartIntervalThink(-1)
	end
end
function ai.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:SetModelScale(self.parent:GetDefaultModelScale())
	end
end
ai = e(
	{
		m(
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
g.modifier_lone_druid_talent_6_tranforming = ai
local aj = c()
aj.name = "lone_druid_shard"
d(aj, i)
function aj.prototype.GetIntrinsicModifierName(self)
	return "modifier_lone_druid_shard_c"
end
aj = e({ j(nil) }, aj)
local ak = c()
ak.name = "modifier_lone_druid_shard_c"
d(ak, l)
function ak.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_SECT_ATTACK_DISABLE] = true }
end
ak = e(
	{
		m(
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
	ak
)
return g