--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_health"
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
		["21"] = 9,
		["22"] = 11,
		["23"] = 13,
		["24"] = 15,
		["25"] = 17,
		["26"] = 19,
		["27"] = 21,
		["28"] = 23,
		["29"] = 4,
		["30"] = 60,
		["31"] = 61,
		["32"] = 62,
		["33"] = 63,
		["34"] = 64,
		["35"] = 65,
		["36"] = 66,
		["37"] = 67,
		["38"] = 68,
		["39"] = 69,
		["40"] = 70,
		["41"] = 71,
		["42"] = 72,
		["43"] = 73,
		["44"] = 74,
		["45"] = 75,
		["46"] = 76,
		["47"] = 77,
		["48"] = 78,
		["49"] = 79,
		["50"] = 80,
		["51"] = 81,
		["52"] = 82,
		["53"] = 83,
		["54"] = 84,
		["55"] = 85,
		["56"] = 86,
		["57"] = 87,
		["58"] = 88,
		["59"] = 89,
		["60"] = 90,
		["61"] = 91,
		["62"] = 92,
		["63"] = 93,
		["64"] = 93,
		["65"] = 93,
		["66"] = 93,
		["67"] = 93,
		["69"] = 60,
		["70"] = 96,
		["71"] = 96,
		["72"] = 96,
		["74"] = 97,
		["75"] = 98,
		["78"] = 101,
		["80"] = 102,
		["81"] = 103,
		["84"] = 104,
		["85"] = 105,
		["86"] = 106,
		["88"] = 108,
		["90"] = 110,
		["91"] = 110,
		["92"] = 110,
		["93"] = 110,
		["94"] = 111,
		["98"] = 114,
		["101"] = 115,
		["102"] = 116,
		["103"] = 117,
		["105"] = 119,
		["107"] = 121,
		["108"] = 122,
		["109"] = 123,
		["110"] = 124,
		["111"] = 124,
		["112"] = 124,
		["113"] = 124,
		["114"] = 124,
		["115"] = 124,
		["116"] = 124,
		["120"] = 127,
		["123"] = 128,
		["124"] = 129,
		["125"] = 130,
		["127"] = 132,
		["129"] = 134,
		["130"] = 135,
		["131"] = 136,
		["132"] = 137,
		["133"] = 137,
		["134"] = 137,
		["135"] = 137,
		["136"] = 137,
		["137"] = 137,
		["138"] = 137,
		["142"] = 140,
		["145"] = 141,
		["146"] = 142,
		["147"] = 143,
		["149"] = 145,
		["151"] = 147,
		["152"] = 148,
		["153"] = 149,
		["154"] = 150,
		["155"] = 150,
		["156"] = 150,
		["157"] = 150,
		["158"] = 150,
		["159"] = 150,
		["160"] = 150,
		["164"] = 153,
		["167"] = 154,
		["168"] = 155,
		["169"] = 156,
		["171"] = 158,
		["173"] = 161,
		["174"] = 162,
		["175"] = 163,
		["176"] = 164,
		["180"] = 167,
		["183"] = 168,
		["184"] = 169,
		["185"] = 170,
		["186"] = 171,
		["187"] = 171,
		["188"] = 171,
		["189"] = 171,
		["190"] = 171,
		["191"] = 172,
		["192"] = 172,
		["193"] = 172,
		["194"] = 172,
		["195"] = 172,
		["196"] = 173,
		["197"] = 174,
		["198"] = 174,
		["199"] = 174,
		["200"] = 175,
		["201"] = 176,
		["202"] = 176,
		["203"] = 176,
		["204"] = 176,
		["205"] = 176,
		["206"] = 176,
		["207"] = 176,
		["208"] = 176,
		["210"] = 174,
		["211"] = 174,
		["215"] = 181,
		["218"] = 182,
		["219"] = 183,
		["220"] = 184,
		["222"] = 186,
		["224"] = 188,
		["225"] = 189,
		["226"] = 190,
		["227"] = 191,
		["231"] = 194,
		["234"] = 195,
		["235"] = 196,
		["236"] = 197,
		["237"] = 198,
		["238"] = 199,
		["240"] = 201,
		["241"] = 202,
		["242"] = 202,
		["243"] = 202,
		["244"] = 202,
		["245"] = 202,
		["246"] = 202,
		["247"] = 202,
		["248"] = 202,
		["249"] = 202,
		["250"] = 203,
		["251"] = 203,
		["252"] = 203,
		["253"] = 203,
		["254"] = 203,
		["255"] = 204,
		["256"] = 205,
		["257"] = 207,
		["258"] = 208,
		["260"] = 210,
		["261"] = 211,
		["262"] = 211,
		["263"] = 211,
		["264"] = 211,
		["265"] = 211,
		["266"] = 212,
		["267"] = 212,
		["268"] = 212,
		["269"] = 212,
		["270"] = 212,
		["271"] = 212,
		["272"] = 212,
		["273"] = 212,
		["278"] = 216,
		["281"] = 217,
		["282"] = 218,
		["283"] = 219,
		["285"] = 221,
		["287"] = 223,
		["288"] = 224,
		["289"] = 225,
		["290"] = 226,
		["291"] = 227,
		["296"] = 96,
		["297"] = 232,
		["298"] = 233,
		["299"] = 232,
		["300"] = 5,
		["301"] = 4,
		["302"] = 5,
		["304"] = 5,
		["305"] = 237,
		["306"] = 245,
		["307"] = 237,
		["308"] = 245,
		["310"] = 245,
		["311"] = 251,
		["312"] = 254,
		["313"] = 256,
		["314"] = 258,
		["315"] = 260,
		["316"] = 262,
		["317"] = 264,
		["318"] = 266,
		["319"] = 270,
		["320"] = 272,
		["321"] = 274,
		["322"] = 276,
		["323"] = 278,
		["324"] = 237,
		["325"] = 332,
		["326"] = 333,
		["327"] = 335,
		["328"] = 336,
		["329"] = 337,
		["330"] = 338,
		["331"] = 339,
		["332"] = 340,
		["333"] = 341,
		["334"] = 342,
		["335"] = 343,
		["336"] = 344,
		["337"] = 345,
		["338"] = 346,
		["339"] = 347,
		["340"] = 348,
		["341"] = 349,
		["342"] = 352,
		["343"] = 354,
		["344"] = 355,
		["345"] = 356,
		["346"] = 357,
		["347"] = 358,
		["348"] = 359,
		["349"] = 360,
		["350"] = 361,
		["351"] = 362,
		["352"] = 363,
		["353"] = 364,
		["354"] = 365,
		["355"] = 366,
		["356"] = 367,
		["357"] = 368,
		["358"] = 369,
		["359"] = 370,
		["360"] = 371,
		["361"] = 372,
		["362"] = 373,
		["363"] = 374,
		["364"] = 376,
		["365"] = 377,
		["366"] = 378,
		["367"] = 379,
		["368"] = 380,
		["369"] = 380,
		["370"] = 380,
		["371"] = 380,
		["372"] = 380,
		["373"] = 381,
		["374"] = 382,
		["375"] = 383,
		["376"] = 384,
		["377"] = 385,
		["378"] = 386,
		["380"] = 388,
		["381"] = 332,
		["382"] = 391,
		["383"] = 392,
		["384"] = 393,
		["385"] = 394,
		["386"] = 395,
		["387"] = 396,
		["388"] = 397,
		["389"] = 398,
		["390"] = 399,
		["391"] = 400,
		["392"] = 401,
		["393"] = 402,
		["395"] = 391,
		["396"] = 406,
		["397"] = 407,
		["398"] = 407,
		["399"] = 407,
		["400"] = 410,
		["401"] = 410,
		["402"] = 410,
		["403"] = 407,
		["404"] = 411,
		["405"] = 411,
		["406"] = 411,
		["407"] = 407,
		["408"] = 407,
		["409"] = 406,
		["410"] = 415,
		["411"] = 416,
		["412"] = 415,
		["413"] = 427,
		["414"] = 428,
		["415"] = 427,
		["416"] = 433,
		["417"] = 434,
		["418"] = 433,
		["419"] = 436,
		["420"] = 438,
		["421"] = 439,
		["423"] = 442,
		["424"] = 443,
		["425"] = 444,
		["426"] = 445,
		["427"] = 445,
		["428"] = 445,
		["429"] = 445,
		["430"] = 445,
		["431"] = 445,
		["432"] = 445,
		["433"] = 445,
		["434"] = 445,
		["435"] = 446,
		["436"] = 447,
		["437"] = 447,
		["438"] = 447,
		["439"] = 447,
		["440"] = 447,
		["441"] = 448,
		["442"] = 449,
		["443"] = 453,
		["444"] = 454,
		["445"] = 455,
		["446"] = 456,
		["448"] = 458,
		["449"] = 436,
		["450"] = 460,
		["451"] = 462,
		["452"] = 462,
		["453"] = 462,
		["454"] = 462,
		["455"] = 460,
		["456"] = 464,
		["457"] = 464,
		["458"] = 472,
		["459"] = 472,
		["460"] = 483,
		["461"] = 484,
		["462"] = 485,
		["463"] = 486,
		["464"] = 487,
		["465"] = 488,
		["466"] = 489,
		["467"] = 490,
		["468"] = 491,
		["469"] = 492,
		["470"] = 493,
		["471"] = 494,
		["472"] = 495,
		["473"] = 496,
		["474"] = 498,
		["475"] = 498,
		["476"] = 498,
		["477"] = 498,
		["478"] = 498,
		["479"] = 498,
		["480"] = 499,
		["481"] = 501,
		["482"] = 502,
		["484"] = 505,
		["485"] = 506,
		["486"] = 506,
		["487"] = 506,
		["488"] = 506,
		["489"] = 506,
		["490"] = 506,
		["492"] = 483,
		["493"] = 510,
		["494"] = 511,
		["495"] = 512,
		["496"] = 513,
		["497"] = 514,
		["498"] = 516,
		["499"] = 517,
		["501"] = 519,
		["502"] = 520,
		["504"] = 523,
		["505"] = 524,
		["506"] = 525,
		["507"] = 526,
		["508"] = 526,
		["509"] = 526,
		["510"] = 526,
		["511"] = 526,
		["512"] = 526,
		["513"] = 526,
		["514"] = 533,
		["515"] = 535,
		["516"] = 535,
		["517"] = 535,
		["518"] = 535,
		["519"] = 535,
		["520"] = 535,
		["521"] = 535,
		["522"] = 535,
		["523"] = 536,
		["524"] = 536,
		["525"] = 536,
		["526"] = 536,
		["527"] = 536,
		["528"] = 536,
		["529"] = 536,
		["530"] = 536,
		["531"] = 537,
		["532"] = 538,
		["533"] = 539,
		["534"] = 540,
		["535"] = 526,
		["536"] = 526,
		["538"] = 510,
		["539"] = 546,
		["540"] = 547,
		["541"] = 548,
		["542"] = 549,
		["543"] = 550,
		["544"] = 552,
		["545"] = 553,
		["546"] = 554,
		["547"] = 546,
		["548"] = 557,
		["549"] = 558,
		["550"] = 560,
		["551"] = 560,
		["552"] = 560,
		["553"] = 560,
		["554"] = 561,
		["555"] = 561,
		["556"] = 561,
		["557"] = 561,
		["558"] = 564,
		["559"] = 565,
		["560"] = 566,
		["561"] = 567,
		["562"] = 568,
		["565"] = 572,
		["566"] = 573,
		["567"] = 574,
		["568"] = 575,
		["569"] = 576,
		["572"] = 580,
		["573"] = 581,
		["574"] = 582,
		["575"] = 583,
		["576"] = 584,
		["579"] = 588,
		["580"] = 589,
		["581"] = 590,
		["582"] = 591,
		["583"] = 592,
		["586"] = 596,
		["587"] = 597,
		["588"] = 598,
		["589"] = 599,
		["590"] = 600,
		["593"] = 604,
		["594"] = 605,
		["595"] = 606,
		["596"] = 607,
		["597"] = 608,
		["600"] = 612,
		["601"] = 613,
		["602"] = 614,
		["603"] = 615,
		["604"] = 616,
		["607"] = 620,
		["608"] = 621,
		["609"] = 622,
		["610"] = 623,
		["611"] = 624,
		["614"] = 557,
		["615"] = 629,
		["616"] = 630,
		["617"] = 629,
		["618"] = 633,
		["619"] = 634,
		["620"] = 634,
		["621"] = 634,
		["622"] = 634,
		["623"] = 633,
		["624"] = 637,
		["625"] = 638,
		["626"] = 640,
		["627"] = 640,
		["628"] = 640,
		["629"] = 640,
		["630"] = 647,
		["631"] = 652,
		["632"] = 637,
		["633"] = 656,
		["634"] = 657,
		["635"] = 658,
		["636"] = 659,
		["637"] = 660,
		["638"] = 661,
		["640"] = 663,
		["642"] = 665,
		["643"] = 665,
		["644"] = 665,
		["645"] = 665,
		["646"] = 667,
		["648"] = 669,
		["649"] = 656,
		["650"] = 685,
		["651"] = 686,
		["654"] = 689,
		["657"] = 692,
		["658"] = 693,
		["659"] = 694,
		["660"] = 695,
		["661"] = 696,
		["663"] = 696,
		["667"] = 685,
		["668"] = 701,
		["669"] = 702,
		["670"] = 703,
		["671"] = 703,
		["672"] = 703,
		["673"] = 703,
		["674"] = 703,
		["675"] = 703,
		["676"] = 701,
		["677"] = 245,
		["678"] = 237,
		["679"] = 237,
		["680"] = 237,
		["681"] = 237,
		["682"] = 237,
		["683"] = 237,
		["684"] = 237,
		["685"] = 237,
		["686"] = 245,
		["688"] = 245,
		["690"] = 708,
		["691"] = 716,
		["692"] = 708,
		["693"] = 716,
		["695"] = 716,
		["696"] = 726,
		["697"] = 727,
		["698"] = 708,
		["699"] = 728,
		["700"] = 729,
		["701"] = 730,
		["702"] = 731,
		["703"] = 732,
		["704"] = 733,
		["705"] = 734,
		["706"] = 735,
		["707"] = 736,
		["708"] = 728,
		["709"] = 739,
		["710"] = 740,
		["711"] = 741,
		["712"] = 742,
		["713"] = 743,
		["714"] = 744,
		["715"] = 746,
		["716"] = 748,
		["717"] = 748,
		["718"] = 749,
		["719"] = 749,
		["720"] = 749,
		["721"] = 749,
		["723"] = 753,
		["724"] = 755,
		["725"] = 755,
		["726"] = 756,
		["727"] = 757,
		["728"] = 758,
		["730"] = 762,
		["731"] = 764,
		["732"] = 764,
		["733"] = 765,
		["734"] = 766,
		["735"] = 767,
		["737"] = 770,
		["738"] = 771,
		["740"] = 773,
		["741"] = 774,
		["742"] = 775,
		["743"] = 776,
		["744"] = 777,
		["745"] = 778,
		["747"] = 739,
		["748"] = 781,
		["749"] = 782,
		["750"] = 783,
		["752"] = 781,
		["753"] = 786,
		["754"] = 787,
		["755"] = 788,
		["756"] = 788,
		["757"] = 788,
		["758"] = 788,
		["759"] = 789,
		["760"] = 790,
		["761"] = 791,
		["762"] = 792,
		["763"] = 793,
		["765"] = 796,
		["766"] = 796,
		["767"] = 796,
		["768"] = 796,
		["770"] = 786,
		["771"] = 799,
		["772"] = 800,
		["773"] = 799,
		["774"] = 805,
		["775"] = 806,
		["776"] = 805,
		["777"] = 808,
		["778"] = 810,
		["779"] = 808,
		["780"] = 716,
		["781"] = 708,
		["782"] = 708,
		["783"] = 708,
		["784"] = 708,
		["785"] = 708,
		["786"] = 708,
		["787"] = 708,
		["788"] = 716,
		["790"] = 716,
		["792"] = 816,
		["793"] = 824,
		["794"] = 816,
		["795"] = 824,
		["796"] = 826,
		["797"] = 827,
		["798"] = 826,
		["799"] = 829,
		["800"] = 830,
		["801"] = 831,
		["803"] = 829,
		["804"] = 834,
		["805"] = 835,
		["806"] = 836,
		["808"] = 834,
		["809"] = 839,
		["810"] = 840,
		["811"] = 839,
		["812"] = 844,
		["813"] = 845,
		["814"] = 844,
		["815"] = 824,
		["816"] = 816,
		["817"] = 816,
		["818"] = 816,
		["819"] = 816,
		["820"] = 816,
		["821"] = 816,
		["822"] = 816,
		["823"] = 816,
		["824"] = 824,
		["826"] = 824,
		["828"] = 850,
		["829"] = 858,
		["830"] = 850,
		["831"] = 858,
		["832"] = 860,
		["833"] = 861,
		["834"] = 860,
		["835"] = 863,
		["836"] = 864,
		["838"] = 863,
		["839"] = 867,
		["840"] = 868,
		["841"] = 867,
		["842"] = 874,
		["843"] = 875,
		["844"] = 874,
		["845"] = 858,
		["846"] = 850,
		["847"] = 850,
		["848"] = 850,
		["849"] = 850,
		["850"] = 850,
		["851"] = 850,
		["852"] = 850,
		["853"] = 858,
		["855"] = 858,
		["857"] = 880,
		["858"] = 888,
		["859"] = 880,
		["860"] = 888,
		["861"] = 892,
		["862"] = 893,
		["863"] = 894,
		["864"] = 895,
		["865"] = 895,
		["866"] = 895,
		["867"] = 895,
		["868"] = 895,
		["870"] = 892,
		["871"] = 898,
		["872"] = 899,
		["873"] = 900,
		["875"] = 898,
		["876"] = 903,
		["877"] = 904,
		["878"] = 905,
		["879"] = 906,
		["880"] = 906,
		["881"] = 906,
		["882"] = 906,
		["883"] = 906,
		["884"] = 906,
		["885"] = 906,
		["887"] = 903,
		["888"] = 909,
		["889"] = 910,
		["890"] = 909,
		["891"] = 914,
		["892"] = 915,
		["893"] = 914,
		["894"] = 888,
		["895"] = 880,
		["896"] = 880,
		["897"] = 880,
		["898"] = 880,
		["899"] = 880,
		["900"] = 880,
		["901"] = 880,
		["902"] = 888,
		["904"] = 888,
		["906"] = 921,
		["907"] = 932,
		["908"] = 921,
		["909"] = 932,
		["911"] = 932,
		["912"] = 940,
		["913"] = 921,
		["914"] = 945,
		["915"] = 946,
		["916"] = 947,
		["917"] = 948,
		["918"] = 949,
		["919"] = 951,
		["920"] = 952,
		["921"] = 945,
		["922"] = 954,
		["923"] = 955,
		["924"] = 955,
		["925"] = 955,
		["926"] = 955,
		["927"] = 954,
		["928"] = 957,
		["929"] = 958,
		["930"] = 959,
		["931"] = 957,
		["932"] = 961,
		["933"] = 962,
		["934"] = 963,
		["935"] = 964,
		["937"] = 961,
		["938"] = 967,
		["939"] = 968,
		["940"] = 967,
		["941"] = 970,
		["942"] = 971,
		["943"] = 972,
		["944"] = 973,
		["945"] = 974,
		["948"] = 977,
		["950"] = 970,
		["951"] = 981,
		["952"] = 982,
		["953"] = 981,
		["954"] = 991,
		["955"] = 992,
		["956"] = 991,
		["957"] = 996,
		["958"] = 997,
		["959"] = 996,
		["960"] = 932,
		["961"] = 921,
		["962"] = 921,
		["963"] = 921,
		["964"] = 921,
		["965"] = 921,
		["966"] = 921,
		["967"] = 921,
		["968"] = 921,
		["969"] = 921,
		["970"] = 921,
		["971"] = 932,
		["973"] = 932,
		["975"] = 1001,
		["976"] = 1008,
		["977"] = 1001,
		["978"] = 1008,
		["979"] = 1009,
		["980"] = 1009,
		["981"] = 1008,
		["982"] = 1001,
		["983"] = 1001,
		["984"] = 1001,
		["985"] = 1001,
		["986"] = 1001,
		["987"] = 1001,
		["988"] = 1001,
		["989"] = 1008,
		["991"] = 1008,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_health = c()
local n = g.sect_health
n.name = "sect_health"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.sr_respawn_enable = false
	self.S = 0
	self.S_ice = 0
	self.S_fury = 0
	self.S_shield = 0
	self.S_injury = 0
	self.S_poison = 0
	self.S_chaos = 0
	self.S_custom_effect = 0
end
function n.prototype.GetAbilitySpecialValue(self)
	self.n_46_interval = self:GetSectSpecialValueFor("46", "n_46_interval")
	self.n_46_regen_pct = self:GetSectSpecialValueFor("46", "n_46_regen_pct")
	self.n_46_regen_min = self:GetSectSpecialValueFor("46", "n_46_regen_min")
	self.n_47_health = self:GetSectSpecialValueFor("47", "n_47_health")
	self.n_48_value = self:GetSectSpecialValueFor("48", "n_48_value")
	self.n_48_min = self:GetSectSpecialValueFor("48", "n_48_min")
	self.n_49_value = self:GetSectSpecialValueFor("49", "n_49_value")
	self.n_49_min = self:GetSectSpecialValueFor("49", "n_49_min")
	self.n_50_value = self:GetSectSpecialValueFor("50", "n_50_value")
	self.n_50_min = self:GetSectSpecialValueFor("50", "n_50_min")
	self.n_51_gain_reduce_pct = self:GetSectSpecialValueFor("51", "n_51_gain_reduce_pct")
	self.n_52_restore = self:GetSectSpecialValueFor("52", "n_52_restore")
	self.n_53_value = self:GetSectSpecialValueFor("53", "n_53_value")
	self.n_53_min = self:GetSectSpecialValueFor("53", "n_53_min")
	self.r_55_interval = self:GetSectSpecialValueFor("55", "r_55_interval")
	self.r_55_health_pct = self:GetSectSpecialValueFor("55", "r_55_health_pct")
	self.r_56_health_pct_per = self:GetSectSpecialValueFor("56", "r_56_health_pct_per")
	self.r_56_damage = self:GetSectSpecialValueFor("56", "r_56_damage")
	self.r_56_max = self:GetSectSpecialValueFor("56", "r_56_max")
	self.r_57_health_pct = self:GetSectSpecialValueFor("57", "r_57_health_pct")
	self.sr_58_health_pct = self:GetSectSpecialValueFor("58", "sr_58_health_pct")
	self.n_125_value = self:GetSectSpecialValueFor("125", "n_125_value")
	self.n_125_min = self:GetSectSpecialValueFor("125", "n_125_min")
	self.sr_142_health = self:GetSectSpecialValueFor("142", "sr_142_health")
	self.sr_153_health_pct = self:GetSectSpecialValueFor("153", "sr_153_health_pct")
	self.sr_153_health_per = self:GetSectSpecialValueFor("153", "sr_153_health_per")
	self.sr_153_max = self:GetSectSpecialValueFor("153", "sr_153_max")
	self.n_171_value = self:GetSectSpecialValueFor("171", "n_171_value")
	self.n_171_min = self:GetSectSpecialValueFor("171", "n_171_min")
	self.sr_197_health = self:GetSectSpecialValueFor("197", "sr_197_health")
	self.sr_197_duration = self:GetSectSpecialValueFor("197", "sr_197_duration")
	if IsServer() then
		self.trait_135_enable =
			AbilityUpgrades:HasAbilityMechanicsUpgrade(self:GetCaster():GetPlayerOwnerID(), "sect_health", "trait_135")
	end
end
function n.prototype.TriggerByName(self, o, p)
	if p == nil then
		p = self:GetCaster():GetEnemy()
	end
	local q = self:GetCaster()
	if not IsInjurable(p, q) then
		return
	end
	local r = self.trait_135_enable or q:HasModifier("modifier_sect_health_197_buff")
	repeat
		local s = o
		local t = s == "46"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local v = math.max(
					math.ceil(u * GetSectHealthModifiedValue(q, self.n_46_regen_pct) / 100),
					self.n_46_regen_min
				)
				Heal(q, v, "46", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "48"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local w = math.floor(u * self.n_48_value * 0.01)
				w = GetSectHealthModifiedValue(q, w)
				w = math.max(self.n_48_min, w)
				AddPoison(q, q:GetEnemy(), w, "48", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "49"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local w = math.floor(u * self.n_49_value * 0.01)
				w = GetSectHealthModifiedValue(q, w)
				w = math.max(self.n_49_min, w)
				AddIce(q, p, w, "49", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "50"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local w = math.floor(u * self.n_50_value * 0.01)
				w = GetSectHealthModifiedValue(q, w)
				w = math.max(self.n_50_min, w)
				AddInjury(q, p, w, "50", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "53"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local w = math.floor(u * self.n_53_value * 0.01)
				w = GetSectHealthModifiedValue(q, w)
				w = math.max(self.n_53_min, w)
				AddShield(q, w, "53", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "55"
		if t then
			do
				local x = q:GetMaxHealth()
				local y = math.ceil(x * GetSectHealthModifiedValue(q, self.r_55_health_pct) / 100)
				local z =
					ParticleManager:CreateParticle("particles/sect/sect_health_55.vpcf", PATTACH_ABSORIGIN_FOLLOW, p)
				ParticleManager:SetParticleControl(z, 1, p:GetAbsOrigin())
				ParticleManager:SetParticleControl(z, 2, p:GetAbsOrigin())
				q:EmitSound("Hero_ShadowDemon.ShadowPoison.Release")
				q:GameTimer(0.25, function()
					if IsInjurable(p) then
						q:DealDamage(p, self, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, nil, "55")
					end
				end)
				break
			end
		end
		t = t or s == "125"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local w = math.floor(u * self.n_125_value * 0.01)
				w = GetSectHealthModifiedValue(q, w)
				w = math.max(self.n_125_min, w)
				AddFury(q, w, "125", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "153"
		if t then
			do
				local A = q:FindModifierByName("modifier_sect_health_153_buff")
				if IsValid(A) then
					if A:GetStackCount() <= self.sr_153_max then
						A:IncrementStackCount()
						A:ForceRefresh()
					end
					local z = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_beastmaster/beastmaster_drums_of_slom_stop.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						q
					)
					ParticleManager:SetParticleControlEnt(z, 1, q, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
					ParticleManager:SetParticleControl(z, 2, Vector(600, 600, 600))
					ParticleManager:ReleaseParticleIndex(z)
					local B = 1
					if q:IsNeutral() then
						B = 0.5
					end
					local y = q:GetMaxHealth() * GetSectHealthModifiedValue(q, self.sr_153_health_pct) * 0.01 * B
					EmitSoundOnLocationWithCaster(q:GetAbsOrigin(), "Hero_Beastmaster.DrumsOfSlom.Strike", q)
					q:DealDamage(p, self, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "153")
				end
				break
			end
		end
		t = t or s == "171"
		if t then
			do
				local u = 0
				if r then
					u = q:GetMaxHealth()
				else
					u = q:GetHealthDeficit()
				end
				local w = math.floor(u * self.n_171_value * 0.01)
				w = GetSectHealthModifiedValue(q, w)
				w = GetSectChaosModifiedValue(q, w)
				w = math.max(self.n_171_min, w)
				AddChaos(q, w, "171", "AbilityUpgrade")
				break
			end
		end
	until true
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_health"
end
n = e({ j(nil) }, n)
g.sect_health = n
g.modifier_sect_health = c()
local C = g.modifier_sect_health
C.name = "modifier_sect_health"
d(C, l)
function C.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.timerInterval = 0.05
	self.n_46_timer = 0
	self.n_51_timer = 0
	self.r_55_timer = 0
	self.sr_respawn_enable = false
	self.S = 0
	self.S_ice = 0
	self.S_fury = 0
	self.S_shield = 0
	self.S_injury = 0
	self.S_poison = 0
	self.S_chaos = 0
	self.S_custom_effect = 0
end
function C.prototype.GetAbilitySpecialValue(self)
	self.trait_135_tick = self:GetAbilitySpecialValueFor("bonus_tick")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
	self.interval_reduce = self:GetAbilitySpecialValueFor("interval_reduce")
	self.n_46_interval = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("46", "n_46_interval"))
	self.n_46_regen_pct = self:GetSectSpecialValueFor("46", "n_46_regen_pct")
	self.n_46_regen_min = self:GetSectSpecialValueFor("46", "n_46_regen_min")
	self.n_47_health = self:GetSectSpecialValueFor("47", "n_47_health")
	self.n_48_value = self:GetSectSpecialValueFor("48", "n_48_value")
	self.n_48_min = self:GetSectSpecialValueFor("48", "n_48_min")
	self.n_48_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("48", "n_48_tick"))
	self.n_49_value = self:GetSectSpecialValueFor("49", "n_49_value")
	self.n_49_min = self:GetSectSpecialValueFor("49", "n_49_min")
	self.n_49_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("49", "n_49_tick"))
	self.n_50_value = self:GetSectSpecialValueFor("50", "n_50_value")
	self.n_50_min = self:GetSectSpecialValueFor("50", "n_50_min")
	self.n_50_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("50", "n_50_tick"))
	self.n_51_gain_reduce_pct = self:GetSectSpecialValueFor("51", "n_51_gain_reduce_pct")
	self.n_52_restore = self:GetSectSpecialValueFor("52", "n_52_restore")
	self.n_53_value = self:GetSectSpecialValueFor("53", "n_53_value")
	self.n_53_min = self:GetSectSpecialValueFor("53", "n_53_min")
	self.n_53_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("53", "n_53_tick"))
	self.r_55_interval = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("55", "r_55_interval"))
	self.r_55_health_pct = self:GetSectSpecialValueFor("55", "r_55_health_pct")
	self.r_56_health_pct_per = self:GetSectSpecialValueFor("56", "r_56_health_pct_per")
	self.r_56_damage = self:GetSectSpecialValueFor("56", "r_56_damage")
	self.r_56_max = self:GetSectSpecialValueFor("56", "r_56_max")
	self.r_57_health_pct = self:GetSectSpecialValueFor("57", "r_57_health_pct")
	self.sr_58_health_pct = self:GetSectSpecialValueFor("58", "sr_58_health_pct")
	self.n_125_value = self:GetSectSpecialValueFor("125", "n_125_value")
	self.n_125_min = self:GetSectSpecialValueFor("125", "n_125_min")
	self.n_125_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("125", "n_125_tick"))
	self.sr_142_health = self:GetSectSpecialValueFor("142", "sr_142_health")
	self.sr_153_interval = self:GetSectSpecialValueFor("153", "sr_153_interval")
	self.n_171_value = self:GetSectSpecialValueFor("171", "n_171_value")
	self.n_171_min = self:GetSectSpecialValueFor("171", "n_171_min")
	self.n_171_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("171", "n_171_tick"))
	self.sr_197_health = self:GetSectSpecialValueFor("197", "sr_197_health")
	self.sr_197_duration = self:GetSectSpecialValueFor("197", "sr_197_duration")
	self.trigger_health_loss = self:GetCustomAbilityValueFor("sect_health_trigger", "health_loss")
	self.trigger_value = self:GetCustomAbilityValueFor("sect_health_effect", "value")
	self.trigger_duration = self:GetCustomAbilityValueFor("sect_health_effect", "duration")
	if IsServer() then
		self.trait_135_enable =
			AbilityUpgrades:HasAbilityMechanicsUpgrade(self:GetParent():GetPlayerOwnerID(), "sect_health", "trait_135")
		self.n_48_timer = 0
		self.n_49_timer = 0
		self.n_50_timer = 0
		self.n_53_timer = 0
		self.n_125_timer = 0
		self.n_171_timer = 0
	end
	self.ability:GetAbilitySpecialValue()
end
function C.prototype.UpdateSectHealthInterval(self)
	self.n_46_interval = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("46", "n_46_interval"))
	self.n_48_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("48", "n_48_tick"))
	self.n_49_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("49", "n_49_tick"))
	self.n_50_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("50", "n_50_tick"))
	self.n_53_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("53", "n_53_tick"))
	self.r_55_interval = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("55", "r_55_interval"))
	self.n_125_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("125", "n_125_tick"))
	self.n_171_tick = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("171", "n_171_tick"))
	local D = self.parent:FindModifierByName("modifier_sect_health_153_buff")
	if D then
		D:UpdateSectHealthIntervalBonus()
	end
end
function C.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { nil, self:GetParent() },
	}
end
function C.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE,
	}
end
function C.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function C.prototype.EOM_GetModifierHealthBonusPercentage(self)
	return self.health_pct
end
function C.prototype.EOM_GetModifierAvoidDamage(self, E)
	if
		bit.band(E.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL
		or E.target:HasModifier("modifier_sect_regen_143")
	then
		return 0
	end
	if self.sr_respawn_enable and E.damage >= E.target:GetHealth() then
		local q = self:GetParent()
		local F = ParticleManager:CreateParticle("particles/sect/health_legend.vpcf", PATTACH_CUSTOMORIGIN, q)
		ParticleManager:SetParticleControlEnt(F, 0, q, PATTACH_ABSORIGIN_FOLLOW, nil, q:GetAbsOrigin(), false)
		ParticleManager:ReleaseParticleIndex(F)
		EmitSoundOnLocationWithCaster(q:GetAbsOrigin(), "Hero_Omniknight.GuardianAngel.Cast", q)
		q:SetHealth(q:GetMaxHealth() * self.sr_58_health_pct * 0.01)
		CombatLog:recordSectAbilityCast(q, "58")
		PurgeDebuff(q)
		ParticleManager:CreateParticle("particles/items_fx/aegis_respawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, q)
		self.sr_respawn_enable = false
		return 1
	end
	return 0
end
function C.prototype.EOM_GetModifierHealthBase(self)
	return GetSectHealthModifiedValue(self:GetParent(), self.n_47_health)
end
function C.prototype.EOM_GetModifierPoisonDamageBonus(self) end
function C.prototype.EOM_GetModifierInjuryStackBonus(self) end
function C.prototype.OnBattleStartBefore(self, E)
	local G = self:GetParent()
	local H = G:GetEnemy()
	local I = self:GetAbility()
	self.n_46_timer = 0
	self.n_51_timer = 0
	self.r_55_timer = 0
	self.n_48_timer = 0
	self.n_49_timer = 0
	self.n_50_timer = 0
	self.n_53_timer = 0
	self.n_125_timer = 0
	self.n_171_timer = 0
	self.sr_respawn_enable = self.sr_58_health_pct > 0
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_sect_health_buff", nil)
	self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
	if self.n_51_gain_reduce_pct > 0 and IsInjurable(H) then
		H:AddNewModifier(G, I, "modifier_sect_health_debuff", {})
	end
	if self.n_52_restore > 0 then
		G:AddNewModifier(G, self:GetAbility(), "modifier_sect_health_52_buff", nil)
	end
end
function C.prototype.OnBattleStart(self, E)
	self:StartIntervalThink(self.timerInterval)
	local G = self:GetParent()
	local H = G:GetEnemy()
	local I = self:GetAbility()
	if self.sr_153_interval > 0 then
		G:AddNewModifier(G, I, "modifier_sect_health_153_buff", nil)
	end
	if self.sr_197_health > 0 then
		G:AddNewModifier(G, I, "modifier_sect_health_197_buff", { duration = self.sr_197_duration })
	end
	if self.sr_142_health > 0 and IsInjurable(H) then
		local y = G:GetMaxHealth() * self.sr_142_health * 0.01
		CombatLog:recordSectAbilityCast(G, "142")
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/sect/sect_health_142.vpcf",
			hCaster = G,
			hTarget = H,
			Ability = I,
			vSpawnOrigin = G:GetAbsOrigin(),
			iMoveSpeed = 1200,
			OnProjectileHit = function(J, K, L)
				H:DealDamage(
					G,
					I,
					y,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK
						+ DamageFlags.DAMAGE_FLAG_HPLOSS
						+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
						+ DamageFlags.DAMAGE_FLAG_NO_CRIT,
					"142"
				)
				G:DealDamage(H, I, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE, DamageFlags.DAMAGE_FLAG_IGNORE_BLOCK, "142")
				ParticleManager:CreateParticle(
					"particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf",
					PATTACH_ABSORIGIN,
					G
				)
				G:EmitSound("Hero_Huskar.Life_Break")
				ParticleManager:CreateParticle(
					"particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf",
					PATTACH_ABSORIGIN,
					H
				)
				H:EmitSound("Hero_Huskar.Life_Break.Impact")
			end,
		})
	end
end
function C.prototype.OnBattleEnd(self, E)
	self:StartIntervalThink(-1)
	self.S = 0
	self.S_ice = 0
	self.S_fury = 0
	self.S_shield = 0
	self.S_custom_effect = 0
	self.S_injury = 0
end
function C.prototype.OnIntervalThink(self)
	local G = self:GetParent()
	self.r_56_damage = GetSectHealthModifiedValue(G, self:GetSectSpecialValueFor("56", "r_56_damage"))
	self.r_56_max = GetSectHealthModifiedValue(G, self:GetSectSpecialValueFor("56", "r_56_max"))
	if self.n_46_interval > 0 and self.n_46_regen_min > 0 then
		self.n_46_timer = self.n_46_timer + self.timerInterval
		if self:checkTimer(self.n_46_timer, self.n_46_interval) then
			self.n_46_timer = self.n_46_timer - self.n_46_interval
			self.ability:TriggerByName("46")
		end
	end
	if self.n_53_tick > 0 and self.n_53_value > 0 then
		self.n_53_timer = self.n_53_timer + self.timerInterval
		if self:checkTimer(self.n_53_timer, self.n_53_tick) then
			self.n_53_timer = 0
			self.ability:TriggerByName("53")
		end
	end
	if self.n_50_tick > 0 and self.n_50_value > 0 then
		self.n_50_timer = self.n_50_timer + self.timerInterval
		if self:checkTimer(self.n_50_timer, self.n_50_tick) then
			self.n_50_timer = 0
			self.ability:TriggerByName("50")
		end
	end
	if self.n_49_tick > 0 and self.n_49_value > 0 then
		self.n_49_timer = self.n_49_timer + self.timerInterval
		if self:checkTimer(self.n_49_timer, self.n_49_tick) then
			self.n_49_timer = 0
			self.ability:TriggerByName("49")
		end
	end
	if self.n_125_tick > 0 and self.n_125_value > 0 then
		self.n_125_timer = self.n_125_timer + self.timerInterval
		if self:checkTimer(self.n_125_timer, self.n_125_tick) then
			self.n_125_timer = 0
			self.ability:TriggerByName("125")
		end
	end
	if self.n_48_tick > 0 and self.n_48_value > 0 then
		self.n_48_timer = self.n_48_timer + self.timerInterval
		if self:checkTimer(self.n_48_timer, self.n_48_tick) then
			self.n_48_timer = 0
			self.ability:TriggerByName("48")
		end
	end
	if self.n_171_tick > 0 and self.n_171_value > 0 then
		self.n_171_timer = self.n_171_timer + self.timerInterval
		if self:checkTimer(self.n_171_timer, self.n_171_tick) then
			self.n_171_timer = 0
			self.ability:TriggerByName("171")
		end
	end
	if self.r_55_health_pct > 0 then
		self.r_55_timer = self.r_55_timer + self.timerInterval
		if self:checkTimer(self.r_55_timer, self.r_55_interval) then
			self.r_55_timer = self.r_55_timer - self.r_55_interval
			self.ability:TriggerByName("55")
		end
	end
end
function C.prototype.checkTimer(self, M, N)
	return Round(M * 100) >= Round(N * 100)
end
function C.prototype.GetSectHealthIntervalBonus(self, N)
	return math.max(
		0.05,
		N + self.trait_135_tick - self.interval_reduce - GetPropertySectHealthIntervalBonus(self.parent)
	)
end
function C.prototype.OnCustomTakeDamage(self, O)
	local G = self:GetParent()
	local y = math.max(0, O.original_health - G:GetHealth())
	self.S_custom_effect = self.S_custom_effect + y
	self:customAbilityTrigger()
end
function C.prototype.EOM_GetModifierIncomingDamagePercentage(self, E)
	if IsServer() and self.r_56_health_pct_per > 0 and self.r_56_damage > 0 then
		local G = self:GetParent()
		local u = 0
		if G:HasModifier("modifier_sect_health_197_buff") then
			u = G:GetMaxHealth()
		else
			u = G:GetHealthDeficit()
		end
		local P = math.min(self.r_56_max, math.floor(u / self.r_56_health_pct_per) * self.r_56_damage)
		return -P
	end
	return 0
end
function C.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_health" then
		return
	end
	if self.trigger_health_loss > 0 then
		local w = math.floor(self.S_custom_effect / self.trigger_health_loss)
		if w >= 1 then
			self.S_custom_effect = self.S_custom_effect % self.trigger_health_loss
			local Q = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
			if Q ~= nil then
				Q:customAbilityEffect()
			end
		end
	end
end
function C.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_sect_health_buff_custom",
		{ iStackCount = self.trigger_value, duration = self.trigger_duration }
	)
end
C = e(
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
	C
)
g.modifier_sect_health = C
g.modifier_sect_health_buff = c()
local R = g.modifier_sect_health_buff
R.name = "modifier_sect_health_buff"
d(R, l)
function R.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
	self.last_value = 0
end
function R.prototype.GetAbilitySpecialValue(self)
	self.n_8_health = self:GetSectSpecialValueFor("8", "n_8_health")
	self.n_8_health_base = self:GetSectSpecialValueFor("8", "n_8_health_base")
	self.n_24_health = self:GetSectSpecialValueFor("24", "n_24_health")
	self.n_24_health_base = self:GetSectSpecialValueFor("24", "n_24_health_base")
	self.n_39_health = self:GetSectSpecialValueFor("39", "n_39_health")
	self.n_39_health_base = self:GetSectSpecialValueFor("39", "n_39_health_base")
	self.r_57_health_pct = self:GetSectSpecialValueFor("57", "r_57_health_pct")
	self.sr_197_health = self:GetSectSpecialValueFor("197", "sr_197_health")
end
function R.prototype.OnCreated(self, E)
	if IsServer() then
		local S = self:GetParent():GetPlayerOwnerID()
		local T = PlayerData:getHero(S)
		local U = T and T:getAbilityData(true)
		local V = 0
		if self.n_8_health > 0 then
			local W = U and U.sect_attack
			local X = W and W.exp or 0
			V = V + GetSectAttackModifiedValue(self:GetParent(), X * self.n_8_health + self.n_8_health_base)
		end
		if self.n_24_health > 0 then
			local Y = U and U.sect_evade
			local X = Y and Y.exp or 0
			local w = X * self.n_24_health
			V = V + w
			V = V + self.n_24_health_base
		end
		if self.n_39_health > 0 then
			local Z = U and U.sect_crit
			local X = Z and Z.exp or 0
			local w = X * self.n_39_health
			V = V + self.n_39_health_base
			V = V + w
		end
		if self.sr_197_health > 0 then
			V = V + self.sr_197_health
		end
		self.record = V
		V = math.floor(V)
		self.last_value = V
		self:IncrementStackCount(V)
		self:StartIntervalThink(0.25)
		self.r_57_health_pct_modified = self.r_57_health_pct
	end
end
function R.prototype.OnRefresh(self, E)
	if IsServer() then
		self:IncrementStackCount(E.iStackCount)
	end
end
function R.prototype.OnIntervalThink(self)
	if IsServer() then
		local V = math.floor(GetSectHealthModifiedValue(self:GetParent(), self.record))
		if V ~= self.last_value then
			local _ = V - self.last_value
			self:IncrementStackCount(_)
			self.last_value = V
			self:GetParent():CalculateHealth()
		end
		self.r_57_health_pct_modified = GetSectHealthModifiedValue(self:GetParent(), self.r_57_health_pct)
	end
end
function R.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE,
	}
end
function R.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount()
end
function R.prototype.EOM_GetModifierHealthBonusPercentage(self)
	return self.r_57_health_pct_modified
end
R = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	R
)
g.modifier_sect_health_buff = R
g.modifier_sect_health_buff_custom = c()
local a0 = g.modifier_sect_health_buff_custom
a0.name = "modifier_sect_health_buff_custom"
d(a0, l)
function a0.prototype.GetAbilitySpecialValue(self)
	self.trigger_value = self:GetCustomAbilityValueFor("sect_health_effect", "value")
end
function a0.prototype.OnCreated(self, E)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a0.prototype.OnRefresh(self, E)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function a0.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function a0.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount() * self.trigger_value
end
a0 = e(
	{
		m(
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
	a0
)
g.modifier_sect_health_buff_custom = a0
g.modifier_sect_health_debuff = c()
local a1 = g.modifier_sect_health_debuff
a1.name = "modifier_sect_health_debuff"
d(a1, l)
function a1.prototype.GetAbilitySpecialValue(self)
	self.n_51_gain_reduce_pct = self:GetSectSpecialValueFor("51", "n_51_gain_reduce_pct")
end
function a1.prototype.OnCreated(self, E)
	if IsServer() then
	end
end
function a1.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_SECT_GAIN_PERCENTAGE }
end
function a1.prototype.EOM_GetModifierHealthSectGainPercentage(self)
	return -self.n_51_gain_reduce_pct
end
a1 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a1
)
g.modifier_sect_health_debuff = a1
g.modifier_sect_health_52_buff = c()
local a2 = g.modifier_sect_health_52_buff
a2.name = "modifier_sect_health_52_buff"
d(a2, l)
function a2.prototype.GetAbilitySpecialValue(self)
	self.n_52_restore = self:GetSectSpecialValueFor("52", "n_52_restore")
	if IsServer() then
		self.trait_135_enable =
			AbilityUpgrades:HasAbilityMechanicsUpgrade(self:GetParent():GetPlayerOwnerID(), "sect_health", "trait_135")
	end
end
function a2.prototype.OnCreated(self, E)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function a2.prototype.OnIntervalThink(self)
	if IsServer() then
		local u = (self.trait_135_enable or self:GetParent():HasModifier("modifier_sect_health_197_buff"))
				and self:GetParent():GetMaxHealth()
			or self:GetParent():GetHealthDeficit()
		self:SetStackCount(
			math.max(0, math.floor(u * GetSectHealthModifiedValue(self:GetParent(), self.n_52_restore) * 0.01))
		)
	end
end
function a2.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function a2.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount()
end
a2 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a2
)
g.modifier_sect_health_52_buff = a2
g.modifier_sect_health_153_buff = c()
local a3 = g.modifier_sect_health_153_buff
a3.name = "modifier_sect_health_153_buff"
d(a3, l)
function a3.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function a3.prototype.GetAbilitySpecialValue(self)
	self.trait_135_tick = self:GetAbilitySpecialValueFor("bonus_tick")
	self.interval_reduce = self:GetAbilitySpecialValueFor("interval_reduce")
	self.sr_153_health_pct = self:GetSectSpecialValueFor("153", "sr_153_health_pct")
	self.sr_153_health_per = self:GetSectSpecialValueFor("153", "sr_153_health_per")
	self.sr_153_interval = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("153", "sr_153_interval"))
	self.sr_153_max = self:GetSectSpecialValueFor("153", "sr_153_max")
end
function a3.prototype.GetSectHealthIntervalBonus(self, N)
	return math.max(
		0.05,
		N + self.trait_135_tick - self.interval_reduce - GetPropertySectHealthIntervalBonus(self.parent)
	)
end
function a3.prototype.UpdateSectHealthIntervalBonus(self)
	self.sr_153_interval = self:GetSectHealthIntervalBonus(self:GetSectSpecialValueFor("153", "sr_153_interval"))
	self:StartIntervalThink(self:get153Interval())
end
function a3.prototype.OnCreated(self, E)
	if IsServer() then
		self.target = self:GetParent():GetEnemy()
		self:StartIntervalThink(self:get153Interval())
	end
end
function a3.prototype.get153Interval(self)
	return self.sr_153_interval
end
function a3.prototype.OnIntervalThink(self)
	if IsServer() then
		local q = self:GetParent()
		if not IsInjurable(self.target, q) then
			self:Destroy()
			return
		end
		self.ability:TriggerByName("153")
	end
end
function a3.prototype.EDeclareEvents(self)
	return {}
end
function a3.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function a3.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount() * self.sr_153_health_per
end
a3 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/units/heroes/hero_beastmaster/beastmaster_drums_of_slom_overhead.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
				ShouldUseOverheadOffset = true,
			}
		),
	},
	a3
)
g.modifier_sect_health_153_buff = a3
g.modifier_sect_health_197_buff = c()
local a4 = g.modifier_sect_health_197_buff
a4.name = "modifier_sect_health_197_buff"
d(a4, l)
function a4.prototype.OnCreated(self, E) end
a4 = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a4
)
g.modifier_sect_health_197_buff = a4
return g