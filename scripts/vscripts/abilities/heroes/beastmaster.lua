--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/beastmaster"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__New
local h = b.__TS__ArrayFilter
local i = b.__TS__ArraySome
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 609,
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
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
		["34"] = 12,
		["35"] = 12,
		["36"] = 12,
		["37"] = 12,
		["38"] = 12,
		["39"] = 12,
		["40"] = 18,
		["41"] = 26,
		["42"] = 18,
		["43"] = 26,
		["45"] = 26,
		["46"] = 42,
		["47"] = 18,
		["48"] = 52,
		["49"] = 53,
		["50"] = 54,
		["51"] = 55,
		["52"] = 56,
		["53"] = 57,
		["54"] = 58,
		["55"] = 59,
		["56"] = 52,
		["57"] = 63,
		["58"] = 64,
		["59"] = 65,
		["60"] = 66,
		["61"] = 67,
		["62"] = 68,
		["63"] = 69,
		["64"] = 70,
		["65"] = 71,
		["66"] = 72,
		["67"] = 74,
		["68"] = 75,
		["69"] = 76,
		["70"] = 63,
		["71"] = 78,
		["72"] = 79,
		["73"] = 80,
		["74"] = 80,
		["75"] = 80,
		["76"] = 79,
		["77"] = 79,
		["78"] = 82,
		["79"] = 82,
		["80"] = 82,
		["81"] = 79,
		["82"] = 79,
		["83"] = 79,
		["84"] = 78,
		["85"] = 86,
		["86"] = 87,
		["87"] = 86,
		["88"] = 93,
		["89"] = 94,
		["90"] = 93,
		["91"] = 96,
		["92"] = 97,
		["95"] = 100,
		["96"] = 96,
		["97"] = 102,
		["98"] = 103,
		["101"] = 106,
		["102"] = 102,
		["103"] = 108,
		["104"] = 109,
		["105"] = 110,
		["106"] = 112,
		["107"] = 113,
		["108"] = 114,
		["109"] = 114,
		["110"] = 114,
		["111"] = 115,
		["112"] = 116,
		["114"] = 114,
		["115"] = 114,
		["116"] = 119,
		["118"] = 108,
		["119"] = 122,
		["120"] = 123,
		["121"] = 124,
		["122"] = 126,
		["123"] = 127,
		["124"] = 128,
		["125"] = 128,
		["126"] = 128,
		["127"] = 129,
		["128"] = 130,
		["130"] = 128,
		["131"] = 128,
		["132"] = 133,
		["134"] = 122,
		["135"] = 136,
		["136"] = 137,
		["137"] = 137,
		["138"] = 137,
		["139"] = 137,
		["140"] = 138,
		["141"] = 139,
		["142"] = 139,
		["143"] = 139,
		["144"] = 139,
		["145"] = 140,
		["146"] = 141,
		["147"] = 142,
		["149"] = 146,
		["150"] = 136,
		["151"] = 148,
		["152"] = 149,
		["153"] = 150,
		["154"] = 150,
		["155"] = 150,
		["156"] = 150,
		["157"] = 150,
		["158"] = 150,
		["160"] = 155,
		["161"] = 156,
		["162"] = 157,
		["164"] = 148,
		["165"] = 161,
		["166"] = 162,
		["167"] = 163,
		["168"] = 163,
		["169"] = 163,
		["170"] = 163,
		["171"] = 163,
		["172"] = 163,
		["174"] = 161,
		["175"] = 166,
		["176"] = 167,
		["177"] = 168,
		["179"] = 166,
		["180"] = 196,
		["181"] = 197,
		["182"] = 198,
		["183"] = 199,
		["186"] = 202,
		["189"] = 205,
		["190"] = 205,
		["191"] = 205,
		["192"] = 205,
		["193"] = 206,
		["194"] = 207,
		["195"] = 207,
		["196"] = 207,
		["197"] = 207,
		["198"] = 207,
		["199"] = 207,
		["200"] = 213,
		["201"] = 214,
		["202"] = 215,
		["203"] = 216,
		["204"] = 217,
		["206"] = 219,
		["209"] = 207,
		["210"] = 207,
		["211"] = 196,
		["212"] = 225,
		["213"] = 226,
		["214"] = 227,
		["215"] = 228,
		["218"] = 231,
		["221"] = 234,
		["222"] = 234,
		["223"] = 234,
		["224"] = 234,
		["225"] = 235,
		["226"] = 236,
		["227"] = 236,
		["228"] = 236,
		["229"] = 236,
		["230"] = 236,
		["231"] = 236,
		["233"] = 225,
		["234"] = 241,
		["235"] = 242,
		["236"] = 243,
		["238"] = 245,
		["239"] = 246,
		["240"] = 247,
		["241"] = 248,
		["243"] = 250,
		["244"] = 241,
		["245"] = 252,
		["246"] = 253,
		["247"] = 252,
		["248"] = 255,
		["249"] = 256,
		["250"] = 255,
		["251"] = 258,
		["252"] = 259,
		["253"] = 260,
		["254"] = 261,
		["256"] = 265,
		["258"] = 267,
		["261"] = 270,
		["262"] = 271,
		["263"] = 272,
		["265"] = 276,
		["267"] = 278,
		["270"] = 258,
		["271"] = 282,
		["272"] = 283,
		["273"] = 284,
		["274"] = 285,
		["275"] = 285,
		["276"] = 285,
		["277"] = 285,
		["278"] = 285,
		["279"] = 285,
		["280"] = 285,
		["281"] = 285,
		["282"] = 285,
		["283"] = 285,
		["284"] = 285,
		["285"] = 293,
		["286"] = 293,
		["287"] = 294,
		["288"] = 295,
		["290"] = 297,
		["291"] = 298,
		["292"] = 299,
		["295"] = 282,
		["296"] = 303,
		["297"] = 304,
		["298"] = 304,
		["299"] = 304,
		["300"] = 304,
		["301"] = 305,
		["302"] = 306,
		["303"] = 307,
		["304"] = 308,
		["307"] = 303,
		["308"] = 312,
		["309"] = 313,
		["310"] = 312,
		["311"] = 315,
		["312"] = 316,
		["313"] = 317,
		["314"] = 318,
		["315"] = 320,
		["316"] = 321,
		["317"] = 321,
		["318"] = 321,
		["319"] = 322,
		["320"] = 323,
		["321"] = 323,
		["322"] = 321,
		["323"] = 321,
		["325"] = 327,
		["326"] = 328,
		["329"] = 332,
		["330"] = 333,
		["331"] = 334,
		["332"] = 335,
		["333"] = 335,
		["334"] = 335,
		["335"] = 335,
		["336"] = 336,
		["337"] = 337,
		["342"] = 342,
		["343"] = 343,
		["344"] = 344,
		["345"] = 345,
		["348"] = 348,
		["349"] = 349,
		["350"] = 350,
		["353"] = 354,
		["356"] = 357,
		["357"] = 358,
		["358"] = 361,
		["359"] = 362,
		["360"] = 363,
		["361"] = 364,
		["362"] = 365,
		["363"] = 365,
		["364"] = 365,
		["365"] = 357,
		["366"] = 357,
		["367"] = 357,
		["368"] = 357,
		["369"] = 357,
		["370"] = 357,
		["371"] = 357,
		["372"] = 357,
		["373"] = 357,
		["374"] = 357,
		["375"] = 357,
		["376"] = 357,
		["377"] = 357,
		["378"] = 371,
		["379"] = 371,
		["380"] = 372,
		["381"] = 373,
		["383"] = 375,
		["384"] = 376,
		["385"] = 377,
		["388"] = 315,
		["389"] = 381,
		["390"] = 382,
		["391"] = 382,
		["392"] = 382,
		["393"] = 382,
		["394"] = 383,
		["395"] = 384,
		["396"] = 385,
		["397"] = 386,
		["400"] = 381,
		["401"] = 26,
		["402"] = 18,
		["403"] = 18,
		["404"] = 18,
		["405"] = 18,
		["406"] = 18,
		["407"] = 18,
		["408"] = 18,
		["409"] = 18,
		["410"] = 26,
		["412"] = 26,
		["413"] = 393,
		["414"] = 401,
		["415"] = 393,
		["416"] = 401,
		["417"] = 403,
		["418"] = 404,
		["419"] = 403,
		["420"] = 406,
		["421"] = 407,
		["422"] = 406,
		["423"] = 412,
		["424"] = 413,
		["425"] = 412,
		["426"] = 415,
		["427"] = 416,
		["428"] = 415,
		["429"] = 418,
		["430"] = 418,
		["431"] = 401,
		["432"] = 393,
		["433"] = 401,
		["435"] = 401,
		["436"] = 424,
		["437"] = 434,
		["438"] = 424,
		["439"] = 434,
		["441"] = 434,
		["442"] = 439,
		["443"] = 424,
		["444"] = 440,
		["445"] = 441,
		["446"] = 442,
		["447"] = 443,
		["448"] = 444,
		["449"] = 440,
		["450"] = 446,
		["451"] = 447,
		["452"] = 448,
		["453"] = 449,
		["454"] = 450,
		["455"] = 451,
		["456"] = 452,
		["457"] = 453,
		["460"] = 446,
		["461"] = 457,
		["462"] = 458,
		["463"] = 459,
		["464"] = 460,
		["465"] = 460,
		["466"] = 460,
		["467"] = 460,
		["468"] = 460,
		["469"] = 460,
		["470"] = 461,
		["471"] = 462,
		["472"] = 463,
		["473"] = 464,
		["474"] = 465,
		["475"] = 465,
		["476"] = 465,
		["477"] = 465,
		["478"] = 465,
		["479"] = 465,
		["480"] = 465,
		["481"] = 465,
		["482"] = 465,
		["483"] = 466,
		["484"] = 466,
		["485"] = 466,
		["486"] = 466,
		["487"] = 466,
		["490"] = 457,
		["491"] = 434,
		["492"] = 424,
		["493"] = 424,
		["494"] = 424,
		["495"] = 424,
		["496"] = 424,
		["497"] = 424,
		["498"] = 424,
		["499"] = 424,
		["500"] = 434,
		["502"] = 434,
		["503"] = 473,
		["504"] = 474,
		["505"] = 475,
		["506"] = 476,
		["507"] = 478,
		["508"] = 478,
		["509"] = 478,
		["511"] = 479,
		["512"] = 479,
		["513"] = 479,
		["514"] = 479,
		["515"] = 478,
		["516"] = 485,
		["517"] = 486,
		["518"] = 485,
		["519"] = 486,
		["520"] = 487,
		["521"] = 488,
		["522"] = 489,
		["523"] = 490,
		["524"] = 491,
		["525"] = 492,
		["528"] = 493,
		["529"] = 494,
		["530"] = 494,
		["531"] = 494,
		["532"] = 495,
		["533"] = 496,
		["534"] = 494,
		["535"] = 494,
		["536"] = 487,
		["537"] = 500,
		["538"] = 501,
		["539"] = 502,
		["540"] = 503,
		["541"] = 506,
		["542"] = 508,
		["543"] = 508,
		["544"] = 508,
		["546"] = 509,
		["547"] = 510,
		["548"] = 512,
		["549"] = 518,
		["550"] = 520,
		["551"] = 520,
		["552"] = 520,
		["553"] = 520,
		["554"] = 520,
		["555"] = 520,
		["556"] = 520,
		["557"] = 520,
		["558"] = 520,
		["559"] = 521,
		["560"] = 521,
		["561"] = 521,
		["562"] = 521,
		["563"] = 521,
		["564"] = 523,
		["565"] = 524,
		["566"] = 526,
		["567"] = 526,
		["568"] = 526,
		["569"] = 527,
		["570"] = 528,
		["571"] = 530,
		["572"] = 530,
		["573"] = 530,
		["574"] = 531,
		["575"] = 532,
		["576"] = 532,
		["577"] = 532,
		["578"] = 532,
		["579"] = 532,
		["580"] = 533,
		["581"] = 536,
		["582"] = 537,
		["583"] = 538,
		["584"] = 539,
		["585"] = 540,
		["586"] = 541,
		["587"] = 542,
		["591"] = 547,
		["592"] = 548,
		["594"] = 552,
		["595"] = 553,
		["596"] = 526,
		["597"] = 526,
		["598"] = 508,
		["599"] = 557,
		["600"] = 557,
		["601"] = 557,
		["602"] = 557,
		["603"] = 557,
		["604"] = 557,
		["605"] = 557,
		["606"] = 557,
		["607"] = 558,
		["608"] = 558,
		["609"] = 558,
		["610"] = 558,
		["611"] = 558,
		["612"] = 558,
		["613"] = 558,
		["614"] = 558,
		["615"] = 500,
		["616"] = 486,
		["617"] = 485,
		["618"] = 486,
		["620"] = 486,
		["622"] = 562,
		["623"] = 571,
		["624"] = 562,
		["625"] = 571,
		["626"] = 573,
		["627"] = 574,
		["628"] = 573,
		["629"] = 576,
		["630"] = 577,
		["631"] = 576,
		["632"] = 579,
		["633"] = 580,
		["634"] = 581,
		["636"] = 579,
		["637"] = 584,
		["638"] = 585,
		["639"] = 586,
		["641"] = 584,
		["642"] = 571,
		["643"] = 562,
		["644"] = 562,
		["645"] = 562,
		["646"] = 562,
		["647"] = 562,
		["648"] = 562,
		["649"] = 562,
		["650"] = 562,
		["651"] = 571,
		["653"] = 571,
		["654"] = 592,
		["657"] = 609,
		["658"] = 609,
		["659"] = 627,
		["660"] = 619,
		["661"] = 628,
		["662"] = 629,
		["663"] = 630,
		["664"] = 631,
		["665"] = 632,
		["666"] = 633,
		["667"] = 634,
		["668"] = 635,
		["669"] = 636,
		["670"] = 637,
		["671"] = 638,
		["672"] = 639,
		["673"] = 640,
		["674"] = 627,
		["675"] = 642,
		["676"] = 643,
		["679"] = 645,
		["680"] = 647,
		["681"] = 647,
		["682"] = 647,
		["683"] = 647,
		["684"] = 647,
		["685"] = 647,
		["686"] = 647,
		["687"] = 647,
		["688"] = 647,
		["689"] = 647,
		["690"] = 647,
		["691"] = 647,
		["692"] = 647,
		["693"] = 647,
		["694"] = 647,
		["695"] = 659,
		["696"] = 660,
		["697"] = 660,
		["698"] = 660,
		["699"] = 661,
		["700"] = 660,
		["701"] = 660,
		["702"] = 664,
		["705"] = 667,
		["707"] = 642,
		["708"] = 671,
		["709"] = 672,
		["712"] = 673,
		["713"] = 674,
		["716"] = 677,
		["717"] = 678,
		["718"] = 679,
		["719"] = 680,
		["720"] = 683,
		["721"] = 683,
		["722"] = 683,
		["723"] = 683,
		["724"] = 683,
		["725"] = 683,
		["726"] = 683,
		["727"] = 683,
		["728"] = 683,
		["729"] = 683,
		["730"] = 683,
		["731"] = 683,
		["732"] = 683,
		["733"] = 683,
		["734"] = 683,
		["735"] = 695,
		["736"] = 696,
		["737"] = 696,
		["738"] = 696,
		["739"] = 697,
		["742"] = 698,
		["743"] = 699,
		["744"] = 699,
		["745"] = 699,
		["746"] = 702,
		["747"] = 702,
		["748"] = 702,
		["749"] = 702,
		["750"] = 699,
		["751"] = 699,
		["752"] = 699,
		["753"] = 699,
		["754"] = 706,
		["755"] = 707,
		["756"] = 709,
		["757"] = 710,
		["758"] = 711,
		["759"] = 712,
		["760"] = 713,
		["761"] = 713,
		["762"] = 713,
		["763"] = 713,
		["764"] = 713,
		["765"] = 713,
		["766"] = 713,
		["768"] = 715,
		["771"] = 718,
		["772"] = 719,
		["773"] = 719,
		["774"] = 719,
		["775"] = 719,
		["776"] = 719,
		["777"] = 719,
		["778"] = 719,
		["780"] = 721,
		["785"] = 699,
		["786"] = 699,
		["787"] = 696,
		["788"] = 696,
		["790"] = 671,
		["791"] = 734,
		["792"] = 735,
		["795"] = 736,
		["796"] = 739,
		["797"] = 740,
		["798"] = 741,
		["799"] = 742,
		["800"] = 743,
		["801"] = 743,
		["802"] = 743,
		["803"] = 743,
		["804"] = 743,
		["805"] = 743,
		["806"] = 743,
		["807"] = 743,
		["808"] = 743,
		["809"] = 743,
		["810"] = 743,
		["811"] = 743,
		["812"] = 743,
		["813"] = 753,
		["814"] = 754,
		["815"] = 754,
		["816"] = 754,
		["817"] = 755,
		["818"] = 756,
		["820"] = 754,
		["821"] = 754,
		["823"] = 760,
		["825"] = 764,
		["826"] = 765,
		["827"] = 766,
		["829"] = 768,
		["830"] = 769,
		["831"] = 770,
		["833"] = 734,
		["836"] = 788,
		["837"] = 788,
		["838"] = 803,
		["839"] = 789,
		["840"] = 804,
		["841"] = 805,
		["842"] = 806,
		["843"] = 807,
		["844"] = 808,
		["845"] = 809,
		["846"] = 810,
		["847"] = 803,
		["848"] = 812,
		["849"] = 813,
		["852"] = 814,
		["853"] = 815,
		["854"] = 815,
		["855"] = 815,
		["856"] = 815,
		["857"] = 815,
		["858"] = 815,
		["859"] = 815,
		["860"] = 815,
		["861"] = 815,
		["862"] = 816,
		["863"] = 816,
		["864"] = 816,
		["865"] = 816,
		["866"] = 816,
		["867"] = 816,
		["868"] = 816,
		["869"] = 816,
		["870"] = 816,
		["871"] = 817,
		["872"] = 818,
		["873"] = 818,
		["874"] = 818,
		["875"] = 818,
		["876"] = 818,
		["877"] = 820,
		["878"] = 820,
		["879"] = 820,
		["880"] = 820,
		["881"] = 820,
		["882"] = 820,
		["883"] = 820,
		["884"] = 827,
		["885"] = 828,
		["888"] = 829,
		["889"] = 830,
		["890"] = 830,
		["891"] = 830,
		["892"] = 830,
		["893"] = 830,
		["894"] = 830,
		["895"] = 830,
		["896"] = 830,
		["897"] = 830,
		["898"] = 820,
		["899"] = 820,
		["900"] = 833,
		["901"] = 834,
		["902"] = 834,
		["903"] = 834,
		["904"] = 835,
		["905"] = 834,
		["906"] = 834,
		["907"] = 837,
		["910"] = 840,
		["912"] = 812,
		["913"] = 844,
		["914"] = 845,
		["915"] = 846,
		["918"] = 849,
		["921"] = 852,
		["922"] = 853,
		["923"] = 854,
		["924"] = 855,
		["925"] = 856,
		["926"] = 857,
		["927"] = 858,
		["928"] = 858,
		["929"] = 858,
		["930"] = 858,
		["931"] = 858,
		["932"] = 858,
		["933"] = 864,
		["934"] = 865,
		["935"] = 866,
		["936"] = 867,
		["937"] = 868,
		["939"] = 858,
		["940"] = 858,
		["941"] = 844,
		["942"] = 874,
		["943"] = 875,
		["946"] = 876,
		["947"] = 879,
		["948"] = 880,
		["949"] = 881,
		["950"] = 882,
		["952"] = 884,
		["953"] = 885,
		["954"] = 886,
		["956"] = 888,
		["957"] = 890,
		["958"] = 891,
		["959"] = 892,
		["960"] = 893,
		["962"] = 874,
		["963"] = 898,
		["964"] = 906,
		["965"] = 898,
		["966"] = 906,
		["967"] = 908,
		["968"] = 909,
		["969"] = 908,
		["970"] = 911,
		["971"] = 912,
		["972"] = 911,
		["973"] = 916,
		["974"] = 917,
		["975"] = 918,
		["977"] = 916,
		["978"] = 906,
		["979"] = 898,
		["980"] = 898,
		["981"] = 898,
		["982"] = 898,
		["983"] = 898,
		["984"] = 898,
		["985"] = 898,
		["986"] = 898,
		["987"] = 906,
		["989"] = 906,
	}
)
local k = {}
local l, m
local n = require("lib.dota_ts_adapter")
local o = n.BaseAbility
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
local t = require("abilities.ability_ai")
local u = t.BaseAbilityAI
local v = t.registerAbilityAI
k.beastmaster_talent = c()
local w = k.beastmaster_talent
w.name = "beastmaster_talent"
d(w, o)
function w.prototype.GetIntrinsicModifierName(self)
	return "modifier_beastmaster_talent"
end
w = e({ p(nil) }, w)
k.beastmaster_talent = w
local x = { Vector(0, 150, 0), Vector(0, -150, 0), Vector(0, 250, 0), Vector(0, -250, 0) }
k.modifier_beastmaster_talent = c()
local y = k.modifier_beastmaster_talent
y.name = "modifier_beastmaster_talent"
d(y, r)
function y.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.position_list = {}
end
function y.prototype.OnCreated(self, z)
	self.evade_record = 0
	self.crit_record = 0
	self.beastCount = 0
	self.beastSpawnSerial = 0
	self.beastList = {}
	self.poultryList = {}
	self.tl3_record = {}
end
function y.prototype.GetAbilitySpecialValue(self)
	self.crit_count = self:GetAbilitySpecialValueFor("crit_count")
	self.beast_interval = self:GetAbilitySpecialValueFor("beast_interval")
		* (1 - self:GetAbilityTalentValue("beastmaster_talent_5", "animal_interval_reduce") * 0.01)
	self.beast_damage = self:GetAbilitySpecialValueFor("beast_damage")
		+ self:GetAbilityTalentValue("beastmaster_talent_7", "damage_bonus")
	self.evade_count = self:GetAbilitySpecialValueFor("evade_count")
	self.poultry_interval = self:GetAbilitySpecialValueFor("poultry_interval")
		* (1 - self:GetAbilityTalentValue("beastmaster_talent_5", "animal_interval_reduce") * 0.01)
	self.poultry_damage = self:GetAbilitySpecialValueFor("poultry_damage")
		+ self:GetAbilityTalentValue("beastmaster_talent_7", "damage_bonus")
	self.animal_duration = self:GetAbilitySpecialValueFor("animal_duration")
		+ self:GetAbilityTalentValue("beastmaster_talent_7", "delay_duration")
	self.beast_max_count = self:GetAbilitySpecialValueFor("beast_max_count")
	self.ult_duration = self:GetAbilityTalentValue("beastmaster_ult", "duration")
	self.tl1_crit = self:GetAbilityTalentValue("beastmaster_talent_1", "steal_crit")
	self.tl2_evade = self:GetAbilityTalentValue("beastmaster_talent_2", "steal_evade")
	self.tl3_cd = self:GetAbilityTalentValue("beastmaster_talent_3", "cd")
end
function y.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function y.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HPLOSS_CRIT_ENABLE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS,
	}
end
function y.prototype.EOM_GetModifierHplossCritEnable(self)
	return self:HasTalent("beastmaster_shard") and 1 or 0
end
function y.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	if #self.beastList == 0 and #self.poultryList == 0 then
		return
	end
	return 2
end
function y.prototype.EOM_GetModifierEvasion_Bonus(self, z)
	if #self.beastList == 0 and #self.poultryList == 0 then
		return
	end
	return 2
end
function y.prototype.OnCritical(self, z)
	self.crit_record = self.crit_record + 1
	if self.crit_record >= self.crit_count then
		EmitSoundOn("Hero_Beastmaster_Bird.Projection", self.parent)
		self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1)
		GameTimer(0.3, function()
			if IsValid(self) then
				self:CreateBeast()
			end
		end)
		self.crit_record = 0
	end
end
function y.prototype.OnEvasion(self, z)
	self.evade_record = self.evade_record + 1
	if self.evade_record >= self.evade_count then
		EmitSoundOn("Hero_Beastmaster_Bird.Projection", self.parent)
		self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 3)
		GameTimer(0.3, function()
			if IsValid(self) then
				self:CreatePoultry()
			end
		end)
		self.evade_record = 0
	end
end
function y.prototype.OnBattleEnd(self, z)
	f(self.beastList, function(A, B)
		return B:Dispose()
	end)
	self.beastList = {}
	f(self.poultryList, function(A, B)
		return B:Dispose()
	end)
	self.poultryList = {}
	if self:HasTalent("beastmaster_talent_6") then
		self.parent:RemoveModifierByName("modifier_talent_6")
	end
	self:RemoveShard()
end
function y.prototype.OnBattleStart(self, z)
	if self:HasTalent("beastmaster_talent_6") then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_talent_6", {})
	end
	if self:HasTalent("beastmaster_talent_5") then
		self:CreateBeast(true)
		self:CreatePoultry(true)
	end
end
function y.prototype.AddShard(self)
	if IsServer() then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_shard_buff", {})
	end
end
function y.prototype.RemoveShard(self)
	if IsServer() then
		self.parent:RemoveModifierByName("modifier_shard_buff")
	end
end
function y.prototype.PoultryAttack(self, C)
	local D = self.caster:GetEnemy()
	local E = self.parent
	if not IsInjurable(D, E) then
		return
	end
	if C and not self:CheckTl3Enable("poultry") then
		return
	end
	f(self.poultryList, function(A, B)
		return B:Attack()
	end)
	local F = self:GetPoultryCount()
	Projectile:CreateTrackingProjectile({
		sEffectName = "particles/units/heroes/hero_beastmaster/bird_attack.vpcf",
		hCaster = E,
		vSpawnOrigin = E:GetAbsOrigin(),
		hTarget = D,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(G, H, I)
			if IsInjurable(E, D) then
				if E:HasModifier("modifier_beastmaster_ult_buff") then
					local J = E:FindModifierByName("modifier_beastmaster_ult_buff"):GetStackCount()
					E:DealDamage(D, self.ability, self.poultry_damage * F + J, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				else
					E:DealDamage(D, self.ability, self.poultry_damage * F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				end
			end
		end,
	})
end
function y.prototype.BeastAttack(self, C)
	local D = self.caster:GetEnemy()
	local E = self.parent
	if not IsInjurable(D, E) then
		return
	end
	if C and not self:CheckTl3Enable("beast") then
		return
	end
	f(self.beastList, function(A, B)
		return B:Attack()
	end)
	if self.ability:HasTalent("beastmaster_talent_4") then
		self.parent:AddNewModifier(
			self.parent,
			self.parent:FindAbilityByName("beastmaster_ult"),
			"modifier_beastmaster_ult_buff",
			{ duration = self.ult_duration }
		)
	end
end
function y.prototype.CheckTl3Enable(self, K)
	if self.tl3_record[K] == nil then
		self.tl3_record[K] = 0
	end
	local L = GameRules:GetGameTime()
	if L >= self.tl3_record[K] then
		self.tl3_record[K] = L + self.tl3_cd
		return true
	end
	return false
end
function y.prototype.StartBeastAttack(self)
	self:StartThink(self.beast_interval, "beast_attack")
end
function y.prototype.StartPoultryAttack(self)
	self:StartThink(self.poultry_interval, "poultry_attack")
end
function y.prototype.OnThink(self, M)
	if M == "beast_attack" then
		if #self.beastList == 0 then
			if self.parent:HasModifier("modifier_talent_2_buff") then
			end
			self:StartThink(-1, "beast_attack")
		else
			self:BeastAttack()
		end
	end
	if M == "poultry_attack" then
		if #self.poultryList == 0 then
			if self.parent:HasModifier("modifier_talent_1_buff") then
			end
			self:StartThink(-1, "poultry_attack")
		else
			self:PoultryAttack()
		end
	end
end
function y.prototype.CreatePoultry(self, N)
	local D = self.caster:GetEnemy()
	local O = "beastmaster_poultry_" .. tostring(self:GetAbility():entindex())
	local P = g(
		m,
		{ parent = self.caster, enemy = D, buff = self, ability = self:GetAbility(), groupName = O, duration = self.animal_duration }
	)
	local Q = self.poultryList
	Q[#Q + 1] = P
	if self:HasTalent("beastmaster_talent_8") and not self.parent:HasModifier("modifier_shard_buff") then
		self:AddShard()
	end
	if not N then
		if self:HasTalent("beastmaster_talent_3") then
			self:BeastAttack(true)
		end
	end
end
function y.prototype.GetPoultryDestroy(self, P)
	self.poultryList = h(self.poultryList, function(A, B)
		return B ~= P
	end)
	if #self.poultryList == 0 then
		self:StartThink(-1, "poultry_attack")
		if #self.beastList == 0 then
			self:RemoveShard()
		end
	end
end
function y.prototype.GetPoultryCount(self)
	return #self.poultryList
end
function y.prototype.CreateBeast(self, N)
	local D = self.caster:GetEnemy()
	local R = self.caster:GetAbsOrigin()
	local S = D:GetAbsOrigin() - R
	if #self.position_list == 0 then
		f(x, function(A, B)
			local T = R + B
			local U = self.position_list
			U[#U + 1] = T
		end)
	end
	local V = self.beast_max_count
	if V <= 0 then
		return
	end
	local W = -1
	if #self.beastList < V then
		for X = 0, V - 1 do
			local Y = i(self.beastList, function(A, B)
				return B.index == X
			end)
			if not Y then
				W = X
				break
			end
		end
	else
		local Z
		for A, _ in ipairs(self.beastList) do
			if not Z or _.spawnSerial < Z.spawnSerial then
				Z = _
			end
		end
		if Z then
			W = Z.index
			Z:Dispose()
		end
	end
	if W == -1 or W >= #self.position_list then
		return
	end
	local a0 = l
	local a1 = self.caster
	local a2 = self:GetAbility()
	local a3 = self.position_list[W + 1]
	local a4 = S
	local a5 = W
	local a6, a7 = self, "beastSpawnSerial"
	local a8 = a6[a7] + 1
	a6[a7] = a8
	local _ = g(
		a0,
		{
			parent = a1,
			enemy = D,
			buff = self,
			ability = a2,
			position = a3,
			direction = a4,
			index = a5,
			spawnSerial = a8,
			attack_interval = self.beast_interval,
			attack_damage = self.beast_damage,
			duration = self.animal_duration + 0.7,
		}
	)
	local a9 = self.beastList
	a9[#a9 + 1] = _
	if self:HasTalent("beastmaster_talent_8") and not self.parent:HasModifier("modifier_shard_buff") then
		self:AddShard()
	end
	if not N then
		if self:HasTalent("beastmaster_talent_3") then
			self:PoultryAttack(true)
		end
	end
end
function y.prototype.GetBeastDestroy(self, aa)
	self.beastList = h(self.beastList, function(A, B)
		return B.index ~= aa
	end)
	if #self.beastList == 0 then
		self:StartThink(-1, "beast_attack")
		if #self.poultryList == 0 then
			self:RemoveShard()
		end
	end
end
y = e(
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
	y
)
k.modifier_beastmaster_talent = y
k.modifier_shard_buff = c()
local ab = k.modifier_shard_buff
ab.name = "modifier_shard_buff"
d(ab, r)
function ab.prototype.GetAbilitySpecialValue(self)
	self.tl8_bonus = self:GetAbilityTalentValue("beastmaster_talent_8", "bonus")
end
function ab.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS,
	}
end
function ab.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, z)
	return self.tl8_bonus
end
function ab.prototype.EOM_GetModifierEvasion_Bonus(self, z)
	return self.tl8_bonus
end
function ab.prototype.OnDestroy(self) end
ab = e({ s(a, { IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true }) }, ab)
k.modifier_shard_buff = ab
k.modifier_talent_6 = c()
local ac = k.modifier_talent_6
ac.name = "modifier_talent_6"
d(ac, r)
function ac.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.hasBuff = false
end
function ac.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilityTalentValue("beastmaster_talent_6", "interval")
	self.magic_damage = self:GetAbilityTalentValue("beastmaster_talent_6", "magic_damage")
	self.reply_health = self:GetAbilityTalentValue("beastmaster_talent_6", "reply_health")
	self.interval_reduce = self:GetAbilityTalentValue("beastmaster_talent_6", "interval_reduce")
end
function ac.prototype.OnCreated(self, z)
	local ad = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	local ae = (ad and ad:getSectLevel("sect_evade") or 0) + (ad and ad:getSectLevel("sect_crit") or 0)
	self.interval = self.interval - self.interval_reduce * ae
	self:StartThink(self.interval, "attack")
	if IsServer() then
		if self.parent:FindModifierByName("modifier_sect_health_153_buff") then
			self.hasBuff = true
		end
	end
end
function ac.prototype.OnThink(self, M)
	if M == "attack" then
		if IsServer() then
			self.parent:DealDamage(
				self.parent:GetEnemy(),
				self:GetParent():FindAbilityByName("beastmaster_talent_6"),
				self.magic_damage,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			Heal(self.parent, self.reply_health, "beastmaster_talent_6", "Ability")
			self:StartThink(-1, "attack")
			self:StartThink(self.interval, "attack")
			local af = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_beastmaster/beastmaster_drums_of_slom_stop.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.parent
			)
			ParticleManager:SetParticleControlEnt(af, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
			ParticleManager:SetParticleControl(af, 2, Vector(600, 600, 600))
		end
	end
end
ac = e(
	{
		s(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	ac
)
k.modifier_talent_6 = ac
local ag = 350
local ah = 175
local ai = 0.8
local aj = 60
local function ak(self, al, am)
	if am == nil then
		am = false
	end
	return { x = ag * math.cos(al * 2 * math.pi), y = ah * math.sin(al * 2 * math.pi) * (am and -1 or 1) }
end
k.beastmaster_ult = c()
local an = k.beastmaster_ult
an.name = "beastmaster_ult"
d(an, u)
function an.prototype.OnSpellStart(self)
	local ao = self:GetSpecialValueFor("magic_damage")
	local ap = self:GetSpecialValueFor("duration")
	local aq = self:GetCaster()
	local D = aq:GetEnemy()
	if not IsInjurable(D, aq) then
		return
	end
	aq:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GameTimer(0.4, function()
		self:LaunchDoubleAxes(aq, D, ao, ap)
		self:EmitSound("Hero_Beastmaster.Wild_Axes")
	end)
end
function an.prototype.LaunchDoubleAxes(self, E, D, ao, ap)
	local S = D:GetAbsOrigin() - E:GetAbsOrigin()
	S.z = 0
	S = S:Normalized()
	local ar = Vector(-S.y, S.x, 0)
	local function as(A, at, au, av, aw, am)
		if am == nil then
			am = false
		end
		local ax = E:GetAbsOrigin() + ar * at
		local ay = ax + S * ag + Vector(0, 0, 96)
		local az = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{ origin = ax, model = "models/development/invisiblebox.vmdl" }
		)
		local aA = ParticleManager:CreateParticle(av, PATTACH_CUSTOMORIGIN, E)
		ParticleManager:SetParticleControlEnt(aA, 0, az, PATTACH_ABSORIGIN_FOLLOW, nil, az:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(aA, 2, Vector(2100, 0, 0))
		local aB = 0
		local aC = false
		GameTimer(FRAME_TIME, function()
			aB = aB + FRAME_TIME
			local al = aB / ai
			local aD = ak(nil, al, am)
			local aE = aD.x
			local aF = aD.y
			local aG = ay + Vector(aE, aF, 0)
			local aH = RotatePosition(ay, VectorAngles(S * -1), aG)
			az:SetAbsOrigin(aH)
			if not aC and al >= 0.5 then
				aC = true
				if IsValid(self) and IsInjurable(D, E) then
					if aw then
						E:DealDamage(D, self, ao, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
						E:AddNewModifier(E, self, "modifier_beastmaster_ult_buff", { duration = ap })
						self:EmitSound("Hero_Beastmaster.Wild_Axes_Damage")
					end
				end
			end
			if aB < ai then
				return FRAME_TIME
			end
			UTIL_Remove(az)
			ParticleManager:DestroyParticle(aA, false)
		end)
	end
	as(nil, -aj, "attach_hand2", "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf", false, true)
	as(nil, aj, "attach_hand1", "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf", true, false)
end
an = e({ v(nil) }, an)
k.beastmaster_ult = an
k.modifier_beastmaster_ult_buff = c()
local aI = k.modifier_beastmaster_ult_buff
aI.name = "modifier_beastmaster_ult_buff"
d(aI, r)
function aI.prototype.GetTexture(self)
	return "beastmaster_wild_axes"
end
function aI.prototype.GetAbilitySpecialValue(self)
	self.talent_damage_bonus = self:GetAbilitySpecialValueFor("talent_damage_bonus")
		+ self:GetAbilityTalentValue("beastmaster_talent_4", "ult_add")
end
function aI.prototype.OnCreated(self, z)
	if IsServer() then
		self:IncrementStackCount(self.talent_damage_bonus)
	end
end
function aI.prototype.OnRefresh(self, z)
	if IsServer() then
		self:IncrementStackCount(self.talent_damage_bonus)
	end
end
aI = e(
	{
		s(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
			}
		),
	},
	aI
)
k.modifier_beastmaster_ult_buff = aI
local aJ = "models/heroes/beastmaster/beastmaster_beast.vmdl"
l = c()
l.name = "Beast"
function l.prototype.____constructor(self, aK)
	self.disposed = false
	self.parent = aK.parent
	self.enemy = aK.enemy
	self.ability = aK.ability
	self.position = aK.position
	self.direction = aK.direction
	self.index = aK.index
	self.spawnSerial = aK.spawnSerial
	self.buff = aK.buff
	self.attack_interval = aK.attack_interval
	self.attack_damage = aK.attack_damage
	self.duration = aK.duration
	print(self.duration)
	self:spawn()
end
function l.prototype.spawn(self)
	if self.disposed then
		return
	end
	self.cachedModel = Wearable:getReplaceUnitModel(self.parent, aJ)
	self.beastDummy = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = self.position,
			angles = VectorToAngles(self.direction),
			scale = 0.6,
			model = self.cachedModel,
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			use_animgraph = "1",
			AnimateOnServer = "1",
		}
	)
	EmitSoundOn("Hero_Beastmaster.Call.Boar", self.beastDummy)
	self.lifeTimer = GameTimer(self.duration, function()
		self:Dispose()
	end)
	if #self.buff.beastList > 1 then
		return
	else
		self.buff:StartBeastAttack()
	end
end
function l.prototype.Attack(self)
	if self.disposed then
		return
	end
	if not IsInjurable(self.enemy, self.parent) then
		self:Dispose()
		return
	end
	if self.beastDummy and IsValid(self.beastDummy) then
		local aL = self.beastDummy
		local aM = self.position
		local aN = self.direction
		self.beastDummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = aM,
				angles = VectorToAngles(aN),
				scale = 0.6,
				model = self.cachedModel,
				StartingAnim = "ACT_DOTA_ATTACK",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				DefaultAnim = "ACT_DOTA_IDLE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				AnimateOnServer = "1",
			}
		)
		UTIL_Remove(aL)
		GameTimer(0.6, function()
			if self.disposed or not self.beastDummy or not IsValid(self.beastDummy) then
				return
			end
			EmitSoundOn("Beastmaster_Boar.Attack", self.beastDummy)
			Projectile:CreateTrackingProjectile({
				EffectName = "particles/units/heroes/hero_beastmaster/beastmaster_boar_attack.vpcf",
				hCaster = self.parent,
				vSpawnOrigin = self.position
					+ RotatePosition(vec3_zero, VectorToAngles(self.direction), Vector(100, 0, 60)),
				hTarget = self.enemy,
				flRadius = 0,
				iMoveSpeed = 1500,
				OnProjectileDestroy = function(H, I)
					if IsInjurable(self.parent, self.enemy) then
						if IsServer() then
							if self.parent:HasModifier("modifier_beastmaster_ult_buff") then
								local J =
									self.parent:FindModifierByName("modifier_beastmaster_ult_buff"):GetStackCount()
								if self.buff:HasTalent("beastmaster_shard") then
									self.parent:DealDamage(
										self.enemy,
										self.ability,
										self.attack_damage + J,
										EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
										DamageFlags.DAMAGE_FLAG_HPLOSS
									)
								else
									self.parent:DealDamage(
										self.enemy,
										self.ability,
										self.attack_damage + J,
										EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
									)
								end
							else
								if self.buff:HasTalent("beastmaster_shard") then
									self.parent:DealDamage(
										self.enemy,
										self.ability,
										self.attack_damage,
										EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
										DamageFlags.DAMAGE_FLAG_HPLOSS
									)
								else
									self.parent:DealDamage(
										self.enemy,
										self.ability,
										self.attack_damage,
										EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
									)
								end
							end
						end
					end
				end,
			})
		end)
	end
end
function l.prototype.Dispose(self)
	if self.disposed then
		return
	end
	self.disposed = true
	if self.beastDummy and IsValid(self.beastDummy) then
		local aO = self.beastDummy
		self.beastDummy = nil
		if self.cachedModel then
			local aP = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{
					origin = self.position,
					angles = VectorToAngles(self.direction),
					scale = 0.6,
					model = self.cachedModel,
					DefaultAnim = "ACT_DOTA_DIE",
					use_animgraph = "1",
					AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
					AnimateOnServer = "1",
				}
			)
			EmitSoundOn("Hero_Beastmaster_Boar.Death", aP)
			GameTimer(1, function()
				if aP and IsValid(aP) then
					UTIL_Remove(aP)
				end
			end)
		end
		UTIL_Remove(aO)
	end
	self.beastDummy = nil
	if IsValid(self.buff) then
		self.buff:GetBeastDestroy(self.index)
	end
	if self.lifeTimer ~= nil then
		StopTimer(self.lifeTimer)
		self.lifeTimer = nil
	end
end
m = c()
m.name = "Poultry"
function m.prototype.____constructor(self, aK)
	self.disposed = false
	self.parent = aK.parent
	self.enemy = aK.enemy
	self.ability = aK.ability
	self.buff = aK.buff
	self.groupName = aK.groupName
	self.duration = aK.duration
	self:spawn()
end
function m.prototype.spawn(self)
	if self.disposed then
		return
	end
	local aQ = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_beastmaster/bird_custom_idle.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		aQ,
		0,
		self.parent,
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(aQ, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
	self.idleParticle = aQ
	EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Hero_Beastmaster.Call.Hawk", self.parent)
	local aR = Projectile:CreateGroupSurroundProjectile({
		hCaster = self.parent,
		sGroupName = self.groupName,
		flCircleRadius = 150,
		flAngularVelocity = 100,
		flOffset = 350,
		iCount = 1,
		OnProjectileCreated = function(I)
			if self.disposed then
				return
			end
			local aS = I
			ParticleManager:SetParticleControlEnt(
				aQ,
				0,
				aS._hThinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				aS._hThinker:GetAbsOrigin(),
				true
			)
		end,
	})
	self.projIndex = aR[1]
	self.lifeTimer = GameTimer(self.duration + 0.03333, function()
		self:Dispose()
	end)
	if #self.buff.poultryList > 1 then
		return
	else
		self.buff:StartPoultryAttack()
	end
end
function m.prototype.Attack(self)
	if not IsInjurable(self.enemy, self.parent) then
		self:Dispose()
		return
	end
	if self.projIndex == nil then
		return
	end
	local E = self.parent
	local D = self.enemy
	local aT = Projectile:getProjectileInfo(self.projIndex)
	local A = aT._vPosition
	local aU = aT._vPosition
	EmitSoundOnLocationWithCaster(aU, "Hero_Beastmaster.Hawk.Reveal", E)
	Projectile:CreateTrackingProjectile({
		sEffectName = "particles/units/heroes/hero_beastmaster/bird_attack.vpcf",
		hCaster = E,
		vSpawnOrigin = aU,
		hTarget = D,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(G, H, I)
			if IsInjurable(E, D) then
				local aQ = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_beastmaster/beastmaster_shard_dive_impact.vpcf",
					PATTACH_ABSORIGIN,
					D,
					E
				)
				ParticleManager:ReleaseParticleIndex(aQ)
				EmitSoundOnLocationWithCaster(H, "Hero_Beastmaster.Hawk.Target", E)
			end
		end,
	})
end
function m.prototype.Dispose(self)
	if self.disposed then
		return
	end
	self.disposed = true
	local aV = self.projIndex
	self.projIndex = nil
	if aV ~= nil then
		Projectile:DestroyProjectile(aV)
	end
	if self.idleParticle ~= nil then
		ParticleManager:DestroyParticle(self.idleParticle, false)
		EmitSoundOn("Hero_Beastmaster_Bird.Death", self.parent)
	end
	self.idleParticle = nil
	self.buff:GetPoultryDestroy(self)
	if self.lifeTimer then
		StopTimer(self.lifeTimer)
		self.lifeTimer = nil
	end
end
k.modifier_beastmaster_shard_buff = c()
local aW = k.modifier_beastmaster_shard_buff
aW.name = "modifier_beastmaster_shard_buff"
d(aW, r)
function aW.prototype.GetAbilitySpecialValue(self)
	self.reply_health = self:GetAbilityTalentValue("beastmaster_shard", "reply_health")
end
function aW.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() } }
end
function aW.prototype.OnCustomTakeDamage(self, aX)
	if IsValid(aX.ability) and aX.ability_upgrade == "153" then
		Heal(self.parent, self.reply_health * 0.01 * aX.damage, "beastmaster_shard", "Ability")
	end
end
aW = e(
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
	aW
)
k.modifier_beastmaster_shard_buff = aW
return k