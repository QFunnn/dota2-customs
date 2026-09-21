--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
		["12"] = 606,
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 5,
		["23"] = 6,
		["24"] = 9,
		["25"] = 10,
		["26"] = 9,
		["27"] = 10,
		["28"] = 11,
		["29"] = 12,
		["30"] = 11,
		["31"] = 10,
		["32"] = 9,
		["33"] = 10,
		["35"] = 10,
		["36"] = 15,
		["37"] = 15,
		["38"] = 15,
		["39"] = 15,
		["40"] = 15,
		["41"] = 15,
		["42"] = 21,
		["43"] = 29,
		["44"] = 21,
		["45"] = 29,
		["47"] = 29,
		["48"] = 45,
		["49"] = 21,
		["50"] = 55,
		["51"] = 56,
		["52"] = 57,
		["53"] = 58,
		["54"] = 59,
		["55"] = 60,
		["56"] = 61,
		["57"] = 62,
		["58"] = 55,
		["59"] = 66,
		["60"] = 67,
		["61"] = 68,
		["62"] = 69,
		["63"] = 70,
		["64"] = 71,
		["65"] = 72,
		["66"] = 73,
		["67"] = 74,
		["68"] = 75,
		["69"] = 77,
		["70"] = 78,
		["71"] = 79,
		["72"] = 66,
		["73"] = 81,
		["74"] = 82,
		["75"] = 83,
		["76"] = 83,
		["77"] = 83,
		["78"] = 82,
		["79"] = 82,
		["80"] = 85,
		["81"] = 85,
		["82"] = 85,
		["83"] = 82,
		["84"] = 82,
		["85"] = 82,
		["86"] = 81,
		["87"] = 89,
		["88"] = 90,
		["89"] = 89,
		["90"] = 96,
		["91"] = 97,
		["92"] = 96,
		["93"] = 99,
		["94"] = 100,
		["97"] = 103,
		["98"] = 99,
		["99"] = 105,
		["100"] = 106,
		["103"] = 109,
		["104"] = 105,
		["105"] = 111,
		["106"] = 112,
		["107"] = 113,
		["108"] = 115,
		["109"] = 116,
		["110"] = 117,
		["111"] = 117,
		["112"] = 117,
		["113"] = 118,
		["114"] = 119,
		["116"] = 117,
		["117"] = 117,
		["118"] = 122,
		["120"] = 111,
		["121"] = 125,
		["122"] = 126,
		["123"] = 127,
		["124"] = 129,
		["125"] = 130,
		["126"] = 131,
		["127"] = 131,
		["128"] = 131,
		["129"] = 132,
		["130"] = 133,
		["132"] = 131,
		["133"] = 131,
		["134"] = 136,
		["136"] = 125,
		["137"] = 139,
		["138"] = 140,
		["139"] = 140,
		["140"] = 140,
		["141"] = 140,
		["142"] = 141,
		["143"] = 142,
		["144"] = 142,
		["145"] = 142,
		["146"] = 142,
		["147"] = 143,
		["148"] = 144,
		["149"] = 147,
		["150"] = 139,
		["151"] = 149,
		["152"] = 150,
		["153"] = 151,
		["154"] = 151,
		["155"] = 151,
		["156"] = 151,
		["157"] = 151,
		["158"] = 151,
		["160"] = 156,
		["161"] = 157,
		["162"] = 158,
		["163"] = 159,
		["165"] = 161,
		["166"] = 162,
		["168"] = 149,
		["169"] = 166,
		["170"] = 167,
		["171"] = 168,
		["172"] = 168,
		["173"] = 168,
		["174"] = 168,
		["175"] = 168,
		["176"] = 168,
		["178"] = 166,
		["179"] = 171,
		["180"] = 172,
		["181"] = 173,
		["183"] = 171,
		["184"] = 201,
		["185"] = 202,
		["186"] = 203,
		["187"] = 204,
		["190"] = 207,
		["193"] = 210,
		["194"] = 210,
		["195"] = 210,
		["196"] = 210,
		["197"] = 211,
		["198"] = 212,
		["199"] = 212,
		["200"] = 212,
		["201"] = 212,
		["202"] = 212,
		["203"] = 212,
		["204"] = 218,
		["205"] = 219,
		["206"] = 220,
		["207"] = 221,
		["208"] = 222,
		["210"] = 224,
		["213"] = 212,
		["214"] = 212,
		["215"] = 201,
		["216"] = 230,
		["217"] = 231,
		["218"] = 232,
		["219"] = 233,
		["222"] = 236,
		["225"] = 239,
		["226"] = 239,
		["227"] = 239,
		["228"] = 239,
		["229"] = 240,
		["230"] = 241,
		["231"] = 241,
		["232"] = 241,
		["233"] = 241,
		["234"] = 241,
		["235"] = 241,
		["237"] = 230,
		["238"] = 246,
		["239"] = 247,
		["240"] = 248,
		["242"] = 250,
		["243"] = 251,
		["244"] = 252,
		["245"] = 253,
		["247"] = 255,
		["248"] = 246,
		["249"] = 257,
		["250"] = 258,
		["251"] = 257,
		["252"] = 260,
		["253"] = 261,
		["254"] = 260,
		["255"] = 263,
		["256"] = 264,
		["257"] = 265,
		["258"] = 266,
		["260"] = 270,
		["262"] = 272,
		["265"] = 275,
		["266"] = 276,
		["267"] = 277,
		["269"] = 281,
		["271"] = 283,
		["274"] = 263,
		["275"] = 287,
		["276"] = 288,
		["277"] = 289,
		["278"] = 290,
		["279"] = 290,
		["280"] = 290,
		["281"] = 290,
		["282"] = 290,
		["283"] = 290,
		["284"] = 290,
		["285"] = 290,
		["286"] = 290,
		["287"] = 290,
		["288"] = 290,
		["289"] = 298,
		["290"] = 298,
		["291"] = 299,
		["292"] = 300,
		["294"] = 302,
		["295"] = 303,
		["296"] = 304,
		["299"] = 287,
		["300"] = 308,
		["301"] = 309,
		["302"] = 309,
		["303"] = 309,
		["304"] = 309,
		["305"] = 310,
		["306"] = 311,
		["307"] = 312,
		["308"] = 313,
		["311"] = 308,
		["312"] = 317,
		["313"] = 318,
		["314"] = 317,
		["315"] = 320,
		["316"] = 321,
		["317"] = 322,
		["318"] = 323,
		["319"] = 325,
		["320"] = 326,
		["321"] = 326,
		["322"] = 326,
		["323"] = 327,
		["324"] = 328,
		["325"] = 328,
		["326"] = 326,
		["327"] = 326,
		["329"] = 332,
		["330"] = 333,
		["333"] = 337,
		["334"] = 338,
		["335"] = 339,
		["336"] = 340,
		["337"] = 340,
		["338"] = 340,
		["339"] = 340,
		["340"] = 341,
		["341"] = 342,
		["346"] = 347,
		["347"] = 348,
		["348"] = 349,
		["349"] = 350,
		["352"] = 353,
		["353"] = 354,
		["354"] = 355,
		["357"] = 359,
		["360"] = 362,
		["361"] = 363,
		["362"] = 366,
		["363"] = 367,
		["364"] = 368,
		["365"] = 369,
		["366"] = 370,
		["367"] = 370,
		["368"] = 370,
		["369"] = 362,
		["370"] = 362,
		["371"] = 362,
		["372"] = 362,
		["373"] = 362,
		["374"] = 362,
		["375"] = 362,
		["376"] = 362,
		["377"] = 362,
		["378"] = 362,
		["379"] = 362,
		["380"] = 362,
		["381"] = 362,
		["382"] = 376,
		["383"] = 376,
		["384"] = 377,
		["385"] = 378,
		["387"] = 380,
		["388"] = 381,
		["389"] = 382,
		["392"] = 320,
		["393"] = 386,
		["394"] = 387,
		["395"] = 387,
		["396"] = 387,
		["397"] = 387,
		["398"] = 388,
		["399"] = 389,
		["400"] = 390,
		["401"] = 391,
		["404"] = 386,
		["405"] = 29,
		["406"] = 21,
		["407"] = 21,
		["408"] = 21,
		["409"] = 21,
		["410"] = 21,
		["411"] = 21,
		["412"] = 21,
		["413"] = 21,
		["414"] = 29,
		["416"] = 29,
		["417"] = 398,
		["418"] = 406,
		["419"] = 398,
		["420"] = 406,
		["421"] = 408,
		["422"] = 409,
		["423"] = 408,
		["424"] = 411,
		["425"] = 412,
		["426"] = 411,
		["427"] = 417,
		["428"] = 418,
		["429"] = 417,
		["430"] = 420,
		["431"] = 421,
		["432"] = 420,
		["433"] = 423,
		["434"] = 423,
		["435"] = 406,
		["436"] = 398,
		["437"] = 406,
		["439"] = 406,
		["440"] = 429,
		["441"] = 439,
		["442"] = 429,
		["443"] = 439,
		["444"] = 442,
		["445"] = 443,
		["446"] = 444,
		["447"] = 442,
		["448"] = 446,
		["449"] = 447,
		["450"] = 448,
		["452"] = 446,
		["453"] = 451,
		["454"] = 452,
		["455"] = 453,
		["456"] = 454,
		["457"] = 455,
		["460"] = 456,
		["461"] = 456,
		["462"] = 457,
		["463"] = 458,
		["464"] = 458,
		["465"] = 458,
		["466"] = 458,
		["467"] = 458,
		["468"] = 458,
		["469"] = 459,
		["470"] = 460,
		["471"] = 461,
		["472"] = 461,
		["473"] = 461,
		["474"] = 461,
		["475"] = 461,
		["476"] = 461,
		["477"] = 461,
		["478"] = 461,
		["479"] = 461,
		["480"] = 462,
		["481"] = 462,
		["482"] = 462,
		["483"] = 462,
		["484"] = 462,
		["485"] = 463,
		["488"] = 451,
		["489"] = 439,
		["490"] = 429,
		["491"] = 429,
		["492"] = 429,
		["493"] = 429,
		["494"] = 429,
		["495"] = 429,
		["496"] = 429,
		["497"] = 429,
		["498"] = 439,
		["500"] = 439,
		["501"] = 470,
		["502"] = 471,
		["503"] = 472,
		["504"] = 473,
		["505"] = 475,
		["506"] = 475,
		["507"] = 475,
		["509"] = 476,
		["510"] = 476,
		["511"] = 476,
		["512"] = 476,
		["513"] = 475,
		["514"] = 482,
		["515"] = 483,
		["516"] = 482,
		["517"] = 483,
		["518"] = 484,
		["519"] = 485,
		["520"] = 486,
		["521"] = 487,
		["522"] = 488,
		["523"] = 489,
		["526"] = 490,
		["527"] = 491,
		["528"] = 491,
		["529"] = 491,
		["530"] = 492,
		["531"] = 493,
		["532"] = 491,
		["533"] = 491,
		["534"] = 484,
		["535"] = 497,
		["536"] = 498,
		["537"] = 499,
		["538"] = 500,
		["539"] = 503,
		["540"] = 505,
		["541"] = 505,
		["542"] = 505,
		["544"] = 506,
		["545"] = 507,
		["546"] = 509,
		["547"] = 515,
		["548"] = 517,
		["549"] = 517,
		["550"] = 517,
		["551"] = 517,
		["552"] = 517,
		["553"] = 517,
		["554"] = 517,
		["555"] = 517,
		["556"] = 517,
		["557"] = 518,
		["558"] = 518,
		["559"] = 518,
		["560"] = 518,
		["561"] = 518,
		["562"] = 520,
		["563"] = 521,
		["564"] = 523,
		["565"] = 523,
		["566"] = 523,
		["567"] = 524,
		["568"] = 525,
		["569"] = 527,
		["570"] = 527,
		["571"] = 527,
		["572"] = 528,
		["573"] = 529,
		["574"] = 529,
		["575"] = 529,
		["576"] = 529,
		["577"] = 529,
		["578"] = 530,
		["579"] = 533,
		["580"] = 534,
		["581"] = 535,
		["582"] = 536,
		["583"] = 537,
		["584"] = 538,
		["585"] = 539,
		["589"] = 544,
		["590"] = 545,
		["592"] = 549,
		["593"] = 550,
		["594"] = 523,
		["595"] = 523,
		["596"] = 505,
		["597"] = 554,
		["598"] = 554,
		["599"] = 554,
		["600"] = 554,
		["601"] = 554,
		["602"] = 554,
		["603"] = 554,
		["604"] = 554,
		["605"] = 555,
		["606"] = 555,
		["607"] = 555,
		["608"] = 555,
		["609"] = 555,
		["610"] = 555,
		["611"] = 555,
		["612"] = 555,
		["613"] = 497,
		["614"] = 483,
		["615"] = 482,
		["616"] = 483,
		["618"] = 483,
		["620"] = 559,
		["621"] = 568,
		["622"] = 559,
		["623"] = 568,
		["624"] = 570,
		["625"] = 571,
		["626"] = 570,
		["627"] = 573,
		["628"] = 574,
		["629"] = 573,
		["630"] = 576,
		["631"] = 577,
		["632"] = 578,
		["634"] = 576,
		["635"] = 581,
		["636"] = 582,
		["637"] = 583,
		["639"] = 581,
		["640"] = 568,
		["641"] = 559,
		["642"] = 559,
		["643"] = 559,
		["644"] = 559,
		["645"] = 559,
		["646"] = 559,
		["647"] = 559,
		["648"] = 559,
		["649"] = 568,
		["651"] = 568,
		["652"] = 589,
		["655"] = 606,
		["656"] = 606,
		["657"] = 624,
		["658"] = 616,
		["659"] = 625,
		["660"] = 626,
		["661"] = 627,
		["662"] = 628,
		["663"] = 629,
		["664"] = 630,
		["665"] = 631,
		["666"] = 632,
		["667"] = 633,
		["668"] = 634,
		["669"] = 635,
		["670"] = 636,
		["671"] = 637,
		["672"] = 624,
		["673"] = 639,
		["674"] = 640,
		["677"] = 642,
		["678"] = 644,
		["679"] = 644,
		["680"] = 644,
		["681"] = 644,
		["682"] = 644,
		["683"] = 644,
		["684"] = 644,
		["685"] = 644,
		["686"] = 644,
		["687"] = 644,
		["688"] = 644,
		["689"] = 644,
		["690"] = 644,
		["691"] = 644,
		["692"] = 644,
		["693"] = 656,
		["694"] = 657,
		["695"] = 657,
		["696"] = 657,
		["697"] = 658,
		["698"] = 657,
		["699"] = 657,
		["700"] = 661,
		["703"] = 664,
		["705"] = 639,
		["706"] = 668,
		["707"] = 669,
		["710"] = 670,
		["711"] = 671,
		["714"] = 674,
		["715"] = 675,
		["716"] = 676,
		["717"] = 677,
		["718"] = 680,
		["719"] = 680,
		["720"] = 680,
		["721"] = 680,
		["722"] = 680,
		["723"] = 680,
		["724"] = 680,
		["725"] = 680,
		["726"] = 680,
		["727"] = 680,
		["728"] = 680,
		["729"] = 680,
		["730"] = 680,
		["731"] = 680,
		["732"] = 680,
		["733"] = 692,
		["734"] = 693,
		["735"] = 693,
		["736"] = 693,
		["737"] = 694,
		["740"] = 695,
		["741"] = 696,
		["742"] = 696,
		["743"] = 696,
		["744"] = 699,
		["745"] = 699,
		["746"] = 699,
		["747"] = 699,
		["748"] = 696,
		["749"] = 696,
		["750"] = 696,
		["751"] = 696,
		["752"] = 703,
		["753"] = 704,
		["754"] = 706,
		["755"] = 707,
		["756"] = 708,
		["757"] = 709,
		["758"] = 710,
		["759"] = 710,
		["760"] = 710,
		["761"] = 710,
		["762"] = 710,
		["763"] = 710,
		["764"] = 710,
		["766"] = 712,
		["769"] = 715,
		["770"] = 716,
		["771"] = 716,
		["772"] = 716,
		["773"] = 716,
		["774"] = 716,
		["775"] = 716,
		["776"] = 716,
		["778"] = 718,
		["783"] = 696,
		["784"] = 696,
		["785"] = 693,
		["786"] = 693,
		["788"] = 668,
		["789"] = 731,
		["790"] = 732,
		["793"] = 733,
		["794"] = 736,
		["795"] = 737,
		["796"] = 738,
		["797"] = 739,
		["798"] = 740,
		["799"] = 740,
		["800"] = 740,
		["801"] = 740,
		["802"] = 740,
		["803"] = 740,
		["804"] = 740,
		["805"] = 740,
		["806"] = 740,
		["807"] = 740,
		["808"] = 740,
		["809"] = 740,
		["810"] = 740,
		["811"] = 750,
		["812"] = 751,
		["813"] = 751,
		["814"] = 751,
		["815"] = 752,
		["816"] = 753,
		["818"] = 751,
		["819"] = 751,
		["821"] = 757,
		["823"] = 761,
		["824"] = 762,
		["825"] = 763,
		["827"] = 765,
		["828"] = 766,
		["829"] = 767,
		["831"] = 731,
		["834"] = 785,
		["835"] = 785,
		["836"] = 800,
		["837"] = 786,
		["838"] = 801,
		["839"] = 802,
		["840"] = 803,
		["841"] = 804,
		["842"] = 805,
		["843"] = 806,
		["844"] = 807,
		["845"] = 800,
		["846"] = 809,
		["847"] = 810,
		["850"] = 811,
		["851"] = 812,
		["852"] = 813,
		["853"] = 813,
		["854"] = 813,
		["855"] = 813,
		["856"] = 813,
		["857"] = 813,
		["858"] = 813,
		["859"] = 813,
		["860"] = 813,
		["861"] = 814,
		["862"] = 814,
		["863"] = 814,
		["864"] = 814,
		["865"] = 814,
		["866"] = 814,
		["867"] = 814,
		["868"] = 814,
		["869"] = 814,
		["870"] = 815,
		["871"] = 816,
		["872"] = 816,
		["873"] = 816,
		["874"] = 816,
		["875"] = 816,
		["876"] = 818,
		["877"] = 818,
		["878"] = 818,
		["879"] = 818,
		["880"] = 818,
		["881"] = 818,
		["882"] = 818,
		["883"] = 825,
		["884"] = 826,
		["887"] = 827,
		["888"] = 828,
		["889"] = 828,
		["890"] = 828,
		["891"] = 828,
		["892"] = 828,
		["893"] = 828,
		["894"] = 828,
		["895"] = 828,
		["896"] = 828,
		["897"] = 818,
		["898"] = 818,
		["899"] = 831,
		["900"] = 832,
		["901"] = 832,
		["902"] = 832,
		["903"] = 833,
		["904"] = 832,
		["905"] = 832,
		["906"] = 835,
		["909"] = 838,
		["911"] = 809,
		["912"] = 842,
		["913"] = 843,
		["914"] = 844,
		["917"] = 847,
		["920"] = 850,
		["921"] = 851,
		["922"] = 852,
		["923"] = 853,
		["924"] = 854,
		["925"] = 855,
		["926"] = 856,
		["927"] = 856,
		["928"] = 856,
		["929"] = 856,
		["930"] = 856,
		["931"] = 856,
		["932"] = 862,
		["933"] = 863,
		["934"] = 864,
		["935"] = 865,
		["936"] = 866,
		["938"] = 856,
		["939"] = 856,
		["940"] = 842,
		["941"] = 872,
		["942"] = 873,
		["945"] = 874,
		["946"] = 877,
		["947"] = 878,
		["948"] = 879,
		["949"] = 880,
		["951"] = 882,
		["952"] = 883,
		["953"] = 884,
		["955"] = 886,
		["956"] = 888,
		["957"] = 889,
		["958"] = 890,
		["959"] = 891,
		["961"] = 872,
		["962"] = 896,
		["963"] = 904,
		["964"] = 896,
		["965"] = 904,
		["966"] = 906,
		["967"] = 907,
		["968"] = 906,
		["969"] = 909,
		["970"] = 910,
		["971"] = 909,
		["972"] = 914,
		["973"] = 915,
		["974"] = 916,
		["976"] = 914,
		["977"] = 904,
		["978"] = 896,
		["979"] = 896,
		["980"] = 896,
		["981"] = 896,
		["982"] = 896,
		["983"] = 896,
		["984"] = 896,
		["985"] = 896,
		["986"] = 904,
		["988"] = 904,
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
local w = "models/eom/hero/beastmaster_1/beastmaster_1_beast.vmdl"
local x = "particles/units/heroes/hero_beastmaster/5100077/bird_custom_idle.vpcf"
k.beastmaster_talent = c()
local y = k.beastmaster_talent
y.name = "beastmaster_talent"
d(y, o)
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_beastmaster_talent"
end
y = e({ p(nil) }, y)
k.beastmaster_talent = y
local z = { Vector(0, 150, 0), Vector(0, -150, 0), Vector(0, 250, 0), Vector(0, -250, 0) }
k.modifier_beastmaster_talent = c()
local A = k.modifier_beastmaster_talent
A.name = "modifier_beastmaster_talent"
d(A, r)
function A.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.position_list = {}
end
function A.prototype.OnCreated(self, B)
	self.evade_record = 0
	self.crit_record = 0
	self.beastCount = 0
	self.beastSpawnSerial = 0
	self.beastList = {}
	self.poultryList = {}
	self.tl3_record = {}
end
function A.prototype.GetAbilitySpecialValue(self)
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
function A.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function A.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HPLOSS_CRIT_ENABLE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS,
	}
end
function A.prototype.EOM_GetModifierHplossCritEnable(self)
	return self:HasTalent("beastmaster_shard") and 1 or 0
end
function A.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self)
	if #self.beastList == 0 and #self.poultryList == 0 then
		return
	end
	return 2
end
function A.prototype.EOM_GetModifierEvasion_Bonus(self, B)
	if #self.beastList == 0 and #self.poultryList == 0 then
		return
	end
	return 2
end
function A.prototype.OnCritical(self, B)
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
function A.prototype.OnEvasion(self, B)
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
function A.prototype.OnBattleEnd(self, B)
	f(self.beastList, function(C, D)
		return D:Dispose()
	end)
	self.beastList = {}
	f(self.poultryList, function(C, D)
		return D:Dispose()
	end)
	self.poultryList = {}
	self.parent:RemoveModifierByName("modifier_beastmaster_talent_9")
	self:RemoveShard()
end
function A.prototype.OnBattleStart(self, B)
	if self:HasTalent("beastmaster_talent_9") then
		self.parent:AddNewModifier(
			self.parent,
			self.parent:FindAbilityByName("beastmaster_talent_9"),
			"modifier_beastmaster_talent_9",
			{}
		)
	end
	local E = PlayerData:getHero(self.parent:GetPlayerOwnerID())
	local F = self:GetAbilitySpecialValueFor("level")
	if (E and E:getSectLevel("sect_crit") or 0) >= F then
		self:CreateBeast(true)
	end
	if (E and E:getSectLevel("sect_evade") or 0) >= F then
		self:CreatePoultry(true)
	end
end
function A.prototype.AddShard(self)
	if IsServer() then
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_shard_buff", {})
	end
end
function A.prototype.RemoveShard(self)
	if IsServer() then
		self.parent:RemoveModifierByName("modifier_shard_buff")
	end
end
function A.prototype.PoultryAttack(self, G)
	local H = self.caster:GetEnemy()
	local I = self.parent
	if not IsInjurable(H, I) then
		return
	end
	if G and not self:CheckTl3Enable("poultry") then
		return
	end
	f(self.poultryList, function(C, D)
		return D:Attack()
	end)
	local J = self:GetPoultryCount()
	Projectile:CreateTrackingProjectile({
		sEffectName = "particles/units/heroes/hero_beastmaster/bird_attack.vpcf",
		hCaster = I,
		vSpawnOrigin = I:GetAbsOrigin(),
		hTarget = H,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(K, L, M)
			if IsInjurable(I, H) then
				if I:HasModifier("modifier_beastmaster_ult_buff") then
					local N = I:FindModifierByName("modifier_beastmaster_ult_buff"):GetStackCount()
					I:DealDamage(H, self.ability, self.poultry_damage * J + N, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				else
					I:DealDamage(H, self.ability, self.poultry_damage * J, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				end
			end
		end,
	})
end
function A.prototype.BeastAttack(self, G)
	local H = self.caster:GetEnemy()
	local I = self.parent
	if not IsInjurable(H, I) then
		return
	end
	if G and not self:CheckTl3Enable("beast") then
		return
	end
	f(self.beastList, function(C, D)
		return D:Attack()
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
function A.prototype.CheckTl3Enable(self, O)
	if self.tl3_record[O] == nil then
		self.tl3_record[O] = 0
	end
	local P = GameRules:GetGameTime()
	if P >= self.tl3_record[O] then
		self.tl3_record[O] = P + self.tl3_cd
		return true
	end
	return false
end
function A.prototype.StartBeastAttack(self)
	self:StartThink(self.beast_interval, "beast_attack")
end
function A.prototype.StartPoultryAttack(self)
	self:StartThink(self.poultry_interval, "poultry_attack")
end
function A.prototype.OnThink(self, Q)
	if Q == "beast_attack" then
		if #self.beastList == 0 then
			if self.parent:HasModifier("modifier_talent_2_buff") then
			end
			self:StartThink(-1, "beast_attack")
		else
			self:BeastAttack()
		end
	end
	if Q == "poultry_attack" then
		if #self.poultryList == 0 then
			if self.parent:HasModifier("modifier_talent_1_buff") then
			end
			self:StartThink(-1, "poultry_attack")
		else
			self:PoultryAttack()
		end
	end
end
function A.prototype.CreatePoultry(self, R)
	local H = self.caster:GetEnemy()
	local S = "beastmaster_poultry_" .. tostring(self:GetAbility():entindex())
	local T = g(
		m,
		{ parent = self.caster, enemy = H, buff = self, ability = self:GetAbility(), groupName = S, duration = self.animal_duration }
	)
	local U = self.poultryList
	U[#U + 1] = T
	if self:HasTalent("beastmaster_talent_8") and not self.parent:HasModifier("modifier_shard_buff") then
		self:AddShard()
	end
	if not R then
		if self:HasTalent("beastmaster_talent_3") then
			self:BeastAttack(true)
		end
	end
end
function A.prototype.GetPoultryDestroy(self, T)
	self.poultryList = h(self.poultryList, function(C, D)
		return D ~= T
	end)
	if #self.poultryList == 0 then
		self:StartThink(-1, "poultry_attack")
		if #self.beastList == 0 then
			self:RemoveShard()
		end
	end
end
function A.prototype.GetPoultryCount(self)
	return #self.poultryList
end
function A.prototype.CreateBeast(self, R)
	local H = self.caster:GetEnemy()
	local V = self.caster:GetAbsOrigin()
	local W = H:GetAbsOrigin() - V
	if #self.position_list == 0 then
		f(z, function(C, D)
			local X = V + D
			local Y = self.position_list
			Y[#Y + 1] = X
		end)
	end
	local Z = self.beast_max_count
	if Z <= 0 then
		return
	end
	local _ = -1
	if #self.beastList < Z then
		for a0 = 0, Z - 1 do
			local a1 = i(self.beastList, function(C, D)
				return D.index == a0
			end)
			if not a1 then
				_ = a0
				break
			end
		end
	else
		local a2
		for C, a3 in ipairs(self.beastList) do
			if not a2 or a3.spawnSerial < a2.spawnSerial then
				a2 = a3
			end
		end
		if a2 then
			_ = a2.index
			a2:Dispose()
		end
	end
	if _ == -1 or _ >= #self.position_list then
		return
	end
	local a4 = l
	local a5 = self.caster
	local a6 = self:GetAbility()
	local a7 = self.position_list[_ + 1]
	local a8 = W
	local a9 = _
	local aa, ab = self, "beastSpawnSerial"
	local ac = aa[ab] + 1
	aa[ab] = ac
	local a3 = g(
		a4,
		{
			parent = a5,
			enemy = H,
			buff = self,
			ability = a6,
			position = a7,
			direction = a8,
			index = a9,
			spawnSerial = ac,
			attack_interval = self.beast_interval,
			attack_damage = self.beast_damage,
			duration = self.animal_duration + 0.7,
		}
	)
	local ad = self.beastList
	ad[#ad + 1] = a3
	if self:HasTalent("beastmaster_talent_8") and not self.parent:HasModifier("modifier_shard_buff") then
		self:AddShard()
	end
	if not R then
		if self:HasTalent("beastmaster_talent_3") then
			self:PoultryAttack(true)
		end
	end
end
function A.prototype.GetBeastDestroy(self, ae)
	self.beastList = h(self.beastList, function(C, D)
		return D.index ~= ae
	end)
	if #self.beastList == 0 then
		self:StartThink(-1, "beast_attack")
		if #self.poultryList == 0 then
			self:RemoveShard()
		end
	end
end
A = e(
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
	A
)
k.modifier_beastmaster_talent = A
k.modifier_shard_buff = c()
local af = k.modifier_shard_buff
af.name = "modifier_shard_buff"
d(af, r)
function af.prototype.GetAbilitySpecialValue(self)
	self.tl8_bonus = self:GetAbilityTalentValue("beastmaster_talent_8", "bonus")
end
function af.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS,
	}
end
function af.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, B)
	return self.tl8_bonus
end
function af.prototype.EOM_GetModifierEvasion_Bonus(self, B)
	return self.tl8_bonus
end
function af.prototype.OnDestroy(self) end
af = e({ s(a, { IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true }) }, af)
k.modifier_shard_buff = af
k.modifier_beastmaster_talent_9 = c()
local ag = k.modifier_beastmaster_talent_9
ag.name = "modifier_beastmaster_talent_9"
d(ag, r)
function ag.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.magic_damage = self:GetAbilitySpecialValueFor("damage")
end
function ag.prototype.OnCreated(self, B)
	if IsServer() then
		self:StartThink(self.interval, "attack")
	end
end
function ag.prototype.OnThink(self, Q)
	if Q == "attack" then
		if IsServer() then
			local H = self.parent:GetEnemy()
			if not IsInjurable(self.parent, H) then
				return
			end
			local ah = self.parent:FindModifierByName("modifier_beastmaster_ult_buff")
			local N = ah and ah:GetStackCount() or 0
			local ai = self.magic_damage + N
			self.parent:DealDamage(H, self:GetAbility(), ai, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			Heal(self.parent, ai, "beastmaster_talent_9", "Ability")
			local aj = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_beastmaster/beastmaster_drums_of_slom_stop.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.parent
			)
			ParticleManager:SetParticleControlEnt(aj, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
			ParticleManager:SetParticleControl(aj, 2, Vector(600, 600, 600))
			ParticleManager:ReleaseParticleIndex(aj)
		end
	end
end
ag = e(
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
	ag
)
k.modifier_beastmaster_talent_9 = ag
local ak = 350
local al = 175
local am = 0.8
local an = 60
local function ao(self, ap, aq)
	if aq == nil then
		aq = false
	end
	return { x = ak * math.cos(ap * 2 * math.pi), y = al * math.sin(ap * 2 * math.pi) * (aq and -1 or 1) }
end
k.beastmaster_ult = c()
local ar = k.beastmaster_ult
ar.name = "beastmaster_ult"
d(ar, u)
function ar.prototype.OnSpellStart(self)
	local ai = self:GetSpecialValueFor("magic_damage")
	local as = self:GetSpecialValueFor("duration")
	local at = self:GetCaster()
	local H = at:GetEnemy()
	if not IsInjurable(H, at) then
		return
	end
	at:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GameTimer(0.4, function()
		self:LaunchDoubleAxes(at, H, ai, as)
		self:EmitSound("Hero_Beastmaster.Wild_Axes")
	end)
end
function ar.prototype.LaunchDoubleAxes(self, I, H, ai, as)
	local W = H:GetAbsOrigin() - I:GetAbsOrigin()
	W.z = 0
	W = W:Normalized()
	local au = Vector(-W.y, W.x, 0)
	local function av(C, aw, ax, ay, az, aq)
		if aq == nil then
			aq = false
		end
		local aA = I:GetAbsOrigin() + au * aw
		local aB = aA + W * ak + Vector(0, 0, 96)
		local aC = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{ origin = aA, model = "models/development/invisiblebox.vmdl" }
		)
		local aD = ParticleManager:CreateParticle(ay, PATTACH_CUSTOMORIGIN, I)
		ParticleManager:SetParticleControlEnt(aD, 0, aC, PATTACH_ABSORIGIN_FOLLOW, nil, aC:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(aD, 2, Vector(2100, 0, 0))
		local aE = 0
		local aF = false
		GameTimer(FRAME_TIME, function()
			aE = aE + FRAME_TIME
			local ap = aE / am
			local aG = ao(nil, ap, aq)
			local aH = aG.x
			local aI = aG.y
			local aJ = aB + Vector(aH, aI, 0)
			local aK = RotatePosition(aB, VectorAngles(W * -1), aJ)
			aC:SetAbsOrigin(aK)
			if not aF and ap >= 0.5 then
				aF = true
				if IsValid(self) and IsInjurable(H, I) then
					if az then
						I:DealDamage(H, self, ai, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
						I:AddNewModifier(I, self, "modifier_beastmaster_ult_buff", { duration = as })
						self:EmitSound("Hero_Beastmaster.Wild_Axes_Damage")
					end
				end
			end
			if aE < am then
				return FRAME_TIME
			end
			UTIL_Remove(aC)
			ParticleManager:DestroyParticle(aD, false)
		end)
	end
	av(nil, -an, "attach_hand2", "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf", false, true)
	av(nil, an, "attach_hand1", "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf", true, false)
end
ar = e({ v(nil) }, ar)
k.beastmaster_ult = ar
k.modifier_beastmaster_ult_buff = c()
local aL = k.modifier_beastmaster_ult_buff
aL.name = "modifier_beastmaster_ult_buff"
d(aL, r)
function aL.prototype.GetTexture(self)
	return "beastmaster_wild_axes"
end
function aL.prototype.GetAbilitySpecialValue(self)
	self.talent_damage_bonus = self:GetAbilitySpecialValueFor("talent_damage_bonus")
		+ self:GetAbilityTalentValue("beastmaster_talent_4", "ult_add")
end
function aL.prototype.OnCreated(self, B)
	if IsServer() then
		self:IncrementStackCount(self.talent_damage_bonus)
	end
end
function aL.prototype.OnRefresh(self, B)
	if IsServer() then
		self:IncrementStackCount(self.talent_damage_bonus)
	end
end
aL = e(
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
	aL
)
k.modifier_beastmaster_ult_buff = aL
local aM = "models/heroes/beastmaster/beastmaster_beast.vmdl"
l = c()
l.name = "Beast"
function l.prototype.____constructor(self, aN)
	self.disposed = false
	self.parent = aN.parent
	self.enemy = aN.enemy
	self.ability = aN.ability
	self.position = aN.position
	self.direction = aN.direction
	self.index = aN.index
	self.spawnSerial = aN.spawnSerial
	self.buff = aN.buff
	self.attack_interval = aN.attack_interval
	self.attack_damage = aN.attack_damage
	self.duration = aN.duration
	print(self.duration)
	self:spawn()
end
function l.prototype.spawn(self)
	if self.disposed then
		return
	end
	self.cachedModel = self.parent:HasModifier("modifier_5100077") and w or aM
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
		local aO = self.beastDummy
		local aP = self.position
		local aQ = self.direction
		self.beastDummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = aP,
				angles = VectorToAngles(aQ),
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
		UTIL_Remove(aO)
		GameTimer(0.6, function()
			if self.disposed or not self.beastDummy or not IsValid(self.beastDummy) then
				return
			end
			EmitSoundOn("Beastmaster_Boar.Attack", self.beastDummy)
			Projectile:CreateTrackingProjectile({
				sEffectName = "particles/units/heroes/hero_beastmaster/beastmaster_boar_attack.vpcf",
				hCaster = self.parent,
				vSpawnOrigin = self.position
					+ RotatePosition(vec3_zero, VectorToAngles(self.direction), Vector(100, 0, 60)),
				hTarget = self.enemy,
				flRadius = 0,
				iMoveSpeed = 1500,
				OnProjectileDestroy = function(L, M)
					if IsInjurable(self.parent, self.enemy) then
						if IsServer() then
							if self.parent:HasModifier("modifier_beastmaster_ult_buff") then
								local N =
									self.parent:FindModifierByName("modifier_beastmaster_ult_buff"):GetStackCount()
								if self.buff:HasTalent("beastmaster_shard") then
									self.parent:DealDamage(
										self.enemy,
										self.ability,
										self.attack_damage + N,
										EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
										DamageFlags.DAMAGE_FLAG_HPLOSS
									)
								else
									self.parent:DealDamage(
										self.enemy,
										self.ability,
										self.attack_damage + N,
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
		local aR = self.beastDummy
		self.beastDummy = nil
		if self.cachedModel then
			local aS = SpawnEntityFromTableSynchronous(
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
			EmitSoundOn("Hero_Beastmaster_Boar.Death", aS)
			GameTimer(1, function()
				if aS and IsValid(aS) then
					UTIL_Remove(aS)
				end
			end)
		end
		UTIL_Remove(aR)
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
function m.prototype.____constructor(self, aN)
	self.disposed = false
	self.parent = aN.parent
	self.enemy = aN.enemy
	self.ability = aN.ability
	self.buff = aN.buff
	self.groupName = aN.groupName
	self.duration = aN.duration
	self:spawn()
end
function m.prototype.spawn(self)
	if self.disposed then
		return
	end
	local aT = self.parent:HasModifier("modifier_5100077") and x
		or "particles/units/heroes/hero_beastmaster/bird_custom_idle.vpcf"
	local aU = ParticleManager:CreateParticle(aT, PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent)
	ParticleManager:SetParticleControlEnt(
		aU,
		0,
		self.parent,
		PATTACH_OVERHEAD_FOLLOW,
		nil,
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(aU, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
	self.idleParticle = aU
	EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Hero_Beastmaster.Call.Hawk", self.parent)
	local aV = Projectile:CreateGroupSurroundProjectile({
		hCaster = self.parent,
		sGroupName = self.groupName,
		flCircleRadius = 150,
		flAngularVelocity = 100,
		flOffset = 350,
		iCount = 1,
		OnProjectileCreated = function(M)
			if self.disposed then
				return
			end
			local aW = M
			ParticleManager:SetParticleControlEnt(
				aU,
				0,
				aW._hThinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				aW._hThinker:GetAbsOrigin(),
				true
			)
		end,
	})
	self.projIndex = aV[1]
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
	local I = self.parent
	local H = self.enemy
	local aX = Projectile:getProjectileInfo(self.projIndex)
	local C = aX._vPosition
	local aY = aX._vPosition
	EmitSoundOnLocationWithCaster(aY, "Hero_Beastmaster.Hawk.Reveal", I)
	Projectile:CreateTrackingProjectile({
		sEffectName = "particles/units/heroes/hero_beastmaster/bird_attack.vpcf",
		hCaster = I,
		vSpawnOrigin = aY,
		hTarget = H,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileHit = function(K, L, M)
			if IsInjurable(I, H) then
				local aU = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_beastmaster/beastmaster_shard_dive_impact.vpcf",
					PATTACH_ABSORIGIN,
					H,
					I
				)
				ParticleManager:ReleaseParticleIndex(aU)
				EmitSoundOnLocationWithCaster(L, "Hero_Beastmaster.Hawk.Target", I)
			end
		end,
	})
end
function m.prototype.Dispose(self)
	if self.disposed then
		return
	end
	self.disposed = true
	local aZ = self.projIndex
	self.projIndex = nil
	if aZ ~= nil then
		Projectile:DestroyProjectile(aZ)
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
local a_ = k.modifier_beastmaster_shard_buff
a_.name = "modifier_beastmaster_shard_buff"
d(a_, r)
function a_.prototype.GetAbilitySpecialValue(self)
	self.reply_health = self:GetAbilityTalentValue("beastmaster_shard", "reply_health")
end
function a_.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() } }
end
function a_.prototype.OnCustomTakeDamage(self, b0)
	if IsValid(b0.ability) and b0.ability_upgrade == "153" then
		Heal(self.parent, self.reply_health * 0.01 * b0.damage, "beastmaster_shard", "Ability")
	end
end
a_ = e(
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
	a_
)
k.modifier_beastmaster_shard_buff = a_
return k