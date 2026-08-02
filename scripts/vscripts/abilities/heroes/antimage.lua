--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/antimage"
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
		["34"] = 19,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 11,
		["40"] = 46,
		["41"] = 53,
		["42"] = 54,
		["43"] = 55,
		["44"] = 56,
		["45"] = 57,
		["46"] = 58,
		["47"] = 59,
		["48"] = 60,
		["49"] = 61,
		["50"] = 62,
		["51"] = 63,
		["52"] = 64,
		["53"] = 65,
		["54"] = 46,
		["55"] = 68,
		["56"] = 68,
		["57"] = 87,
		["58"] = 88,
		["59"] = 88,
		["60"] = 88,
		["61"] = 88,
		["62"] = 92,
		["63"] = 92,
		["64"] = 92,
		["65"] = 88,
		["66"] = 93,
		["67"] = 93,
		["68"] = 93,
		["69"] = 88,
		["70"] = 88,
		["71"] = 87,
		["72"] = 96,
		["73"] = 100,
		["74"] = 101,
		["75"] = 101,
		["76"] = 101,
		["77"] = 101,
		["78"] = 101,
		["79"] = 101,
		["81"] = 103,
		["82"] = 104,
		["83"] = 104,
		["84"] = 104,
		["85"] = 104,
		["86"] = 104,
		["87"] = 104,
		["88"] = 105,
		["89"] = 106,
		["92"] = 109,
		["93"] = 110,
		["94"] = 110,
		["95"] = 110,
		["96"] = 110,
		["97"] = 110,
		["98"] = 110,
		["100"] = 112,
		["101"] = 96,
		["102"] = 114,
		["103"] = 115,
		["104"] = 116,
		["105"] = 117,
		["106"] = 117,
		["107"] = 117,
		["108"] = 117,
		["109"] = 118,
		["110"] = 119,
		["111"] = 119,
		["112"] = 119,
		["113"] = 119,
		["114"] = 120,
		["115"] = 121,
		["116"] = 121,
		["117"] = 121,
		["118"] = 121,
		["119"] = 121,
		["120"] = 121,
		["122"] = 123,
		["123"] = 123,
		["124"] = 123,
		["125"] = 123,
		["126"] = 123,
		["128"] = 125,
		["129"] = 125,
		["130"] = 125,
		["131"] = 125,
		["132"] = 126,
		["133"] = 127,
		["134"] = 127,
		["135"] = 127,
		["136"] = 127,
		["137"] = 127,
		["138"] = 127,
		["140"] = 129,
		["141"] = 129,
		["142"] = 129,
		["143"] = 129,
		["144"] = 129,
		["148"] = 114,
		["149"] = 134,
		["150"] = 135,
		["151"] = 136,
		["152"] = 137,
		["153"] = 138,
		["154"] = 139,
		["155"] = 140,
		["156"] = 140,
		["157"] = 140,
		["158"] = 140,
		["159"] = 140,
		["160"] = 140,
		["163"] = 134,
		["164"] = 144,
		["165"] = 145,
		["166"] = 146,
		["167"] = 146,
		["168"] = 146,
		["169"] = 146,
		["170"] = 146,
		["171"] = 146,
		["173"] = 144,
		["174"] = 149,
		["175"] = 150,
		["176"] = 151,
		["177"] = 152,
		["179"] = 149,
		["180"] = 155,
		["181"] = 156,
		["182"] = 157,
		["183"] = 158,
		["184"] = 159,
		["185"] = 160,
		["186"] = 161,
		["187"] = 162,
		["188"] = 162,
		["189"] = 162,
		["190"] = 162,
		["191"] = 162,
		["192"] = 162,
		["194"] = 164,
		["195"] = 164,
		["196"] = 164,
		["197"] = 164,
		["198"] = 164,
		["201"] = 167,
		["202"] = 168,
		["203"] = 169,
		["204"] = 170,
		["205"] = 171,
		["208"] = 155,
		["209"] = 175,
		["210"] = 176,
		["211"] = 177,
		["212"] = 178,
		["214"] = 180,
		["215"] = 181,
		["216"] = 182,
		["217"] = 183,
		["219"] = 185,
		["220"] = 175,
		["221"] = 193,
		["222"] = 194,
		["223"] = 193,
		["224"] = 19,
		["225"] = 11,
		["226"] = 11,
		["227"] = 11,
		["228"] = 11,
		["229"] = 11,
		["230"] = 11,
		["231"] = 11,
		["232"] = 11,
		["233"] = 19,
		["235"] = 19,
		["236"] = 224,
		["237"] = 233,
		["238"] = 224,
		["239"] = 233,
		["240"] = 237,
		["241"] = 238,
		["242"] = 239,
		["243"] = 237,
		["244"] = 241,
		["245"] = 242,
		["246"] = 243,
		["247"] = 244,
		["248"] = 244,
		["249"] = 244,
		["250"] = 244,
		["251"] = 244,
		["252"] = 244,
		["253"] = 244,
		["254"] = 244,
		["255"] = 244,
		["256"] = 245,
		["257"] = 245,
		["258"] = 245,
		["259"] = 245,
		["260"] = 245,
		["261"] = 241,
		["262"] = 247,
		["263"] = 248,
		["264"] = 247,
		["265"] = 250,
		["266"] = 251,
		["267"] = 250,
		["268"] = 255,
		["269"] = 256,
		["270"] = 257,
		["271"] = 255,
		["272"] = 259,
		["273"] = 260,
		["274"] = 259,
		["275"] = 233,
		["276"] = 224,
		["277"] = 224,
		["278"] = 224,
		["279"] = 224,
		["280"] = 224,
		["281"] = 224,
		["282"] = 224,
		["283"] = 224,
		["284"] = 224,
		["285"] = 233,
		["287"] = 233,
		["288"] = 264,
		["289"] = 272,
		["290"] = 264,
		["291"] = 272,
		["292"] = 273,
		["293"] = 274,
		["294"] = 273,
		["295"] = 276,
		["296"] = 277,
		["297"] = 276,
		["298"] = 272,
		["299"] = 264,
		["300"] = 264,
		["301"] = 264,
		["302"] = 264,
		["303"] = 264,
		["304"] = 264,
		["305"] = 264,
		["306"] = 264,
		["307"] = 272,
		["309"] = 272,
		["310"] = 281,
		["311"] = 289,
		["312"] = 281,
		["313"] = 289,
		["314"] = 290,
		["315"] = 291,
		["316"] = 290,
		["317"] = 293,
		["318"] = 294,
		["319"] = 293,
		["320"] = 289,
		["321"] = 281,
		["322"] = 281,
		["323"] = 281,
		["324"] = 281,
		["325"] = 281,
		["326"] = 281,
		["327"] = 281,
		["328"] = 281,
		["329"] = 289,
		["331"] = 289,
		["332"] = 299,
		["333"] = 307,
		["334"] = 299,
		["335"] = 307,
		["336"] = 308,
		["337"] = 309,
		["338"] = 308,
		["339"] = 313,
		["340"] = 314,
		["341"] = 313,
		["342"] = 307,
		["343"] = 299,
		["344"] = 299,
		["345"] = 299,
		["346"] = 299,
		["347"] = 299,
		["348"] = 299,
		["349"] = 299,
		["350"] = 299,
		["351"] = 307,
		["353"] = 307,
		["354"] = 320,
		["355"] = 328,
		["356"] = 320,
		["357"] = 328,
		["358"] = 330,
		["359"] = 331,
		["360"] = 330,
		["361"] = 333,
		["362"] = 334,
		["363"] = 333,
		["364"] = 336,
		["365"] = 337,
		["366"] = 336,
		["367"] = 339,
		["368"] = 340,
		["369"] = 339,
		["370"] = 344,
		["371"] = 345,
		["372"] = 346,
		["373"] = 347,
		["374"] = 348,
		["376"] = 344,
		["377"] = 351,
		["378"] = 352,
		["379"] = 353,
		["381"] = 351,
		["382"] = 356,
		["383"] = 357,
		["384"] = 358,
		["385"] = 356,
		["386"] = 360,
		["387"] = 361,
		["388"] = 362,
		["389"] = 360,
		["390"] = 328,
		["391"] = 320,
		["392"] = 320,
		["393"] = 320,
		["394"] = 320,
		["395"] = 320,
		["396"] = 320,
		["397"] = 320,
		["398"] = 320,
		["399"] = 328,
		["401"] = 328,
		["403"] = 369,
		["404"] = 370,
		["405"] = 369,
		["406"] = 370,
		["408"] = 370,
		["409"] = 371,
		["410"] = 369,
		["411"] = 372,
		["412"] = 375,
		["413"] = 376,
		["414"] = 395,
		["415"] = 396,
		["416"] = 397,
		["417"] = 398,
		["418"] = 398,
		["419"] = 398,
		["420"] = 399,
		["421"] = 400,
		["422"] = 400,
		["423"] = 400,
		["424"] = 400,
		["425"] = 400,
		["426"] = 400,
		["427"] = 400,
		["428"] = 400,
		["429"] = 400,
		["430"] = 401,
		["431"] = 401,
		["432"] = 401,
		["433"] = 401,
		["434"] = 401,
		["435"] = 403,
		["436"] = 403,
		["437"] = 403,
		["438"] = 404,
		["439"] = 405,
		["440"] = 406,
		["441"] = 407,
		["442"] = 408,
		["443"] = 409,
		["444"] = 410,
		["447"] = 413,
		["448"] = 413,
		["449"] = 413,
		["450"] = 414,
		["451"] = 413,
		["452"] = 413,
		["453"] = 403,
		["454"] = 403,
		["455"] = 398,
		["456"] = 398,
		["457"] = 372,
		["458"] = 370,
		["459"] = 369,
		["460"] = 370,
		["462"] = 370,
		["463"] = 501,
		["464"] = 509,
		["465"] = 501,
		["466"] = 509,
		["467"] = 511,
		["468"] = 512,
		["469"] = 511,
		["470"] = 514,
		["471"] = 515,
		["472"] = 516,
		["474"] = 514,
		["475"] = 519,
		["476"] = 520,
		["477"] = 519,
		["478"] = 524,
		["479"] = 525,
		["480"] = 524,
		["481"] = 509,
		["482"] = 501,
		["483"] = 501,
		["484"] = 501,
		["485"] = 501,
		["486"] = 501,
		["487"] = 501,
		["488"] = 501,
		["489"] = 509,
		["491"] = 509,
		["493"] = 532,
		["494"] = 533,
		["495"] = 532,
		["496"] = 533,
		["497"] = 534,
		["498"] = 535,
		["499"] = 534,
		["500"] = 533,
		["501"] = 532,
		["502"] = 533,
		["504"] = 533,
		["505"] = 538,
		["506"] = 546,
		["507"] = 538,
		["508"] = 546,
		["509"] = 557,
		["510"] = 558,
		["511"] = 559,
		["512"] = 560,
		["513"] = 561,
		["514"] = 562,
		["515"] = 563,
		["516"] = 564,
		["517"] = 557,
		["518"] = 566,
		["519"] = 567,
		["520"] = 568,
		["521"] = 569,
		["523"] = 566,
		["524"] = 573,
		["525"] = 574,
		["526"] = 573,
		["527"] = 576,
		["528"] = 577,
		["529"] = 578,
		["530"] = 579,
		["532"] = 576,
		["533"] = 582,
		["534"] = 583,
		["535"] = 582,
		["536"] = 587,
		["537"] = 588,
		["538"] = 589,
		["539"] = 590,
		["542"] = 587,
		["543"] = 595,
		["544"] = 596,
		["545"] = 595,
		["546"] = 602,
		["547"] = 603,
		["548"] = 604,
		["551"] = 606,
		["552"] = 606,
		["555"] = 607,
		["557"] = 609,
		["558"] = 609,
		["559"] = 609,
		["560"] = 609,
		["561"] = 610,
		["564"] = 602,
		["565"] = 622,
		["566"] = 623,
		["567"] = 624,
		["568"] = 625,
		["571"] = 622,
		["572"] = 546,
		["573"] = 538,
		["574"] = 538,
		["575"] = 538,
		["576"] = 538,
		["577"] = 538,
		["578"] = 538,
		["579"] = 538,
		["580"] = 538,
		["581"] = 546,
		["583"] = 546,
		["585"] = 633,
		["586"] = 634,
		["587"] = 633,
		["588"] = 634,
		["589"] = 635,
		["590"] = 636,
		["591"] = 637,
		["592"] = 638,
		["593"] = 639,
		["594"] = 640,
		["595"] = 641,
		["597"] = 644,
		["598"] = 645,
		["599"] = 646,
		["600"] = 647,
		["602"] = 649,
		["603"] = 650,
		["604"] = 651,
		["606"] = 653,
		["607"] = 654,
		["608"] = 655,
		["609"] = 655,
		["610"] = 655,
		["611"] = 656,
		["612"] = 657,
		["613"] = 657,
		["614"] = 657,
		["615"] = 657,
		["616"] = 657,
		["617"] = 657,
		["618"] = 657,
		["619"] = 657,
		["620"] = 657,
		["621"] = 658,
		["622"] = 658,
		["623"] = 658,
		["624"] = 658,
		["625"] = 658,
		["626"] = 659,
		["627"] = 655,
		["628"] = 655,
		["629"] = 635,
		["630"] = 634,
		["631"] = 633,
		["632"] = 634,
		["634"] = 634,
		["636"] = 666,
		["637"] = 675,
		["638"] = 666,
		["639"] = 675,
		["640"] = 676,
		["641"] = 677,
		["642"] = 678,
		["643"] = 679,
		["644"] = 680,
		["645"] = 680,
		["646"] = 680,
		["647"] = 680,
		["648"] = 680,
		["649"] = 680,
		["651"] = 676,
		["652"] = 683,
		["653"] = 684,
		["654"] = 683,
		["655"] = 686,
		["656"] = 687,
		["657"] = 688,
		["658"] = 689,
		["659"] = 690,
		["660"] = 691,
		["661"] = 692,
		["664"] = 686,
		["665"] = 697,
		["666"] = 698,
		["667"] = 697,
		["668"] = 675,
		["669"] = 666,
		["670"] = 666,
		["671"] = 666,
		["672"] = 666,
		["673"] = 666,
		["674"] = 666,
		["675"] = 666,
		["676"] = 666,
		["677"] = 675,
		["679"] = 675,
		["680"] = 701,
		["681"] = 709,
		["682"] = 701,
		["683"] = 709,
		["685"] = 709,
		["686"] = 725,
		["687"] = 701,
		["688"] = 726,
		["689"] = 727,
		["690"] = 728,
		["691"] = 726,
		["692"] = 733,
		["693"] = 734,
		["694"] = 736,
		["695"] = 737,
		["696"] = 738,
		["697"] = 739,
		["698"] = 739,
		["699"] = 739,
		["700"] = 740,
		["701"] = 741,
		["702"] = 744,
		["704"] = 739,
		["705"] = 739,
		["707"] = 733,
		["708"] = 749,
		["709"] = 751,
		["710"] = 752,
		["711"] = 753,
		["714"] = 756,
		["715"] = 756,
		["716"] = 756,
		["717"] = 757,
		["718"] = 758,
		["720"] = 756,
		["721"] = 756,
		["722"] = 749,
		["723"] = 763,
		["724"] = 766,
		["725"] = 763,
		["726"] = 769,
		["727"] = 770,
		["728"] = 771,
		["729"] = 771,
		["730"] = 771,
		["731"] = 771,
		["732"] = 772,
		["733"] = 769,
		["734"] = 774,
		["735"] = 775,
		["736"] = 774,
		["737"] = 782,
		["738"] = 784,
		["739"] = 785,
		["740"] = 786,
		["741"] = 786,
		["742"] = 786,
		["744"] = 787,
		["745"] = 789,
		["746"] = 788,
		["748"] = 789,
		["749"] = 790,
		["750"] = 790,
		["751"] = 790,
		["752"] = 790,
		["753"] = 790,
		["754"] = 790,
		["755"] = 791,
		["756"] = 792,
		["757"] = 793,
		["758"] = 794,
		["759"] = 795,
		["760"] = 796,
		["761"] = 797,
		["763"] = 798,
		["765"] = 799,
		["766"] = 800,
		["767"] = 801,
		["768"] = 802,
		["769"] = 802,
		["770"] = 802,
		["771"] = 802,
		["772"] = 802,
		["773"] = 802,
		["774"] = 802,
		["775"] = 802,
		["776"] = 802,
		["777"] = 803,
		["781"] = 786,
		["782"] = 786,
		["783"] = 782,
		["784"] = 807,
		["785"] = 808,
		["786"] = 809,
		["787"] = 810,
		["789"] = 807,
		["790"] = 819,
		["791"] = 819,
		["792"] = 828,
		["793"] = 829,
		["794"] = 829,
		["795"] = 829,
		["796"] = 829,
		["797"] = 829,
		["798"] = 829,
		["799"] = 829,
		["800"] = 828,
		["801"] = 840,
		["802"] = 840,
		["803"] = 845,
		["804"] = 846,
		["805"] = 847,
		["806"] = 847,
		["807"] = 847,
		["808"] = 847,
		["809"] = 848,
		["810"] = 849,
		["812"] = 851,
		["814"] = 845,
		["815"] = 856,
		["816"] = 857,
		["817"] = 858,
		["819"] = 856,
		["820"] = 862,
		["821"] = 863,
		["822"] = 864,
		["824"] = 862,
		["825"] = 868,
		["826"] = 869,
		["827"] = 870,
		["829"] = 868,
		["830"] = 874,
		["831"] = 875,
		["832"] = 874,
		["833"] = 882,
		["834"] = 883,
		["835"] = 884,
		["836"] = 885,
		["837"] = 886,
		["838"] = 882,
		["839"] = 709,
		["840"] = 701,
		["841"] = 701,
		["842"] = 701,
		["843"] = 701,
		["844"] = 701,
		["845"] = 701,
		["846"] = 701,
		["847"] = 701,
		["848"] = 709,
		["850"] = 709,
		["851"] = 890,
		["852"] = 898,
		["853"] = 890,
		["854"] = 898,
		["855"] = 904,
		["856"] = 905,
		["857"] = 904,
		["858"] = 907,
		["859"] = 908,
		["860"] = 909,
		["861"] = 910,
		["862"] = 911,
		["864"] = 913,
		["865"] = 913,
		["866"] = 913,
		["867"] = 913,
		["869"] = 915,
		["871"] = 907,
		["872"] = 918,
		["873"] = 919,
		["874"] = 918,
		["875"] = 923,
		["876"] = 924,
		["879"] = 927,
		["880"] = 923,
		["881"] = 898,
		["882"] = 890,
		["883"] = 890,
		["884"] = 890,
		["885"] = 890,
		["886"] = 890,
		["887"] = 890,
		["888"] = 890,
		["889"] = 890,
		["890"] = 898,
		["892"] = 898,
		["893"] = 931,
		["894"] = 939,
		["895"] = 931,
		["896"] = 939,
		["897"] = 944,
		["898"] = 945,
		["899"] = 944,
		["900"] = 947,
		["901"] = 948,
		["902"] = 949,
		["903"] = 950,
		["904"] = 951,
		["906"] = 953,
		["907"] = 953,
		["908"] = 953,
		["909"] = 953,
		["910"] = 953,
		["912"] = 955,
		["914"] = 947,
		["915"] = 958,
		["916"] = 959,
		["917"] = 960,
		["918"] = 961,
		["920"] = 963,
		["921"] = 963,
		["922"] = 963,
		["923"] = 963,
		["924"] = 963,
		["926"] = 965,
		["928"] = 958,
		["929"] = 969,
		["930"] = 970,
		["931"] = 969,
		["932"] = 974,
		["933"] = 975,
		["934"] = 974,
		["935"] = 939,
		["936"] = 931,
		["937"] = 931,
		["938"] = 931,
		["939"] = 931,
		["940"] = 931,
		["941"] = 931,
		["942"] = 931,
		["943"] = 931,
		["944"] = 939,
		["946"] = 939,
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
g.antimage_talent = c()
local p = g.antimage_talent
p.name = "antimage_talent"
d(p, m)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_antimage_talent"
end
p = e({ o(nil) }, p)
g.antimage_talent = p
g.modifier_antimage_talent = c()
local q = g.modifier_antimage_talent
q.name = "modifier_antimage_talent"
d(q, i)
function q.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.max_health = 0
	self.damage_record = 0
	self.reduce_mana_record = 0
	self.custom_add = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.mana_reduce = self:GetAbilitySpecialValueFor("mana_reduce")
		+ self:GetAbilityTalentValue("antimage_talent_2", "add_mana")
	self.mana_reduce_pct = self:GetAbilitySpecialValueFor("mana_reduce_pct")
		+ self:GetAbilityTalentValue("antimage_talent_12", "mana_change_pct")
	self.mana_base_pct = self:GetAbilitySpecialValueFor("mana_base_pct")
	self.custom_mana_bonus = self:GetAbilitySpecialValueFor("custom_mana_bonus")
	self.custom_mana_bonus_limit = self:GetAbilitySpecialValueFor("custom_mana_bonus_limit")
	self.tl7_duration = self:GetAbilityTalentValue("antimage_talent_7", "duration")
	self.tl8_limit = self:GetAbilityTalentValue("antimage_talent_8", "limit")
	self.tl9_util_pct = self:GetAbilityTalentValue("antimage_talent_9", "util_pct")
	self.tl9_add_custom_mana = self:GetAbilityTalentValue("antimage_talent_9", "add_custom_mana")
	self.tl10_health_reduce = self:GetAbilityTalentValue("antimage_talent_10", "health_reduce")
	self.tl10_invincible_duration = self:GetAbilityTalentValue("antimage_talent_10", "invincible_duration")
	self.tl10_magic_reduce = self:GetAbilityTalentValue("antimage_talent_10", "magic_reduce")
	self.tl11_damage_base = self:GetAbilityTalentValue("antimage_talent_11", "damage_base")
end
function q.prototype.OnCreated(self, r) end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent(), -1 },
	}
end
function q.prototype.OnBattleStart(self, r)
	if self:HasTalent("antimage_talent_8") then
		self.parent:AddNewModifier(self.caster, self:GetAbility(), "modifier_antimage_talent8_buff", {})
	end
	if self:HasTalent("antimage_talent_10") then
		local s = self.parent:AddNewModifier(self.caster, self:GetAbility(), "modifier_antimage_talent9_buff", {})
		if s then
			s:SetStackCount(self.tl10_magic_reduce)
		end
	end
	if self:HasTalent("antimage_shard") then
		self.parent:AddNewModifier(self.caster, self:GetAbility(), "modifier_antimage_new_shard_buff", {})
	end
	self.max_health = self.parent:GetMaxHealth()
end
function q.prototype.OnCustomAttackLanded(self, t)
	if t.attacker == self.parent then
		if t.target:IsAlive() then
			local u = math.min(t.target:GetMana(), self.mana_reduce)
			if IsCustomHeroMana(t.target) then
				ReduceCustomMana(self.parent:GetEnemy(), u)
				if self:HasTalent("antimage_talent_11") and u > 0 then
					self.parent:DealDamage(
						self.parent:GetEnemy(),
						self.parent:FindAbilityByName("antimage_talent_11"),
						self.tl11_damage_base * u,
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
					)
				end
				RestoreCustomMana(self.parent, u * (1 + self:GetCustomManaBonusPct() * 0.01), true)
			else
				ReduceMana(self.parent:GetEnemy(), u)
				if self:HasTalent("antimage_talent_11") and u > 0 then
					self.parent:DealDamage(
						self.parent:GetEnemy(),
						self.parent:FindAbilityByName("antimage_talent_11"),
						self.tl11_damage_base * u,
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
					)
				end
				RestoreCustomMana(self.parent, u * (1 + self:GetCustomManaBonusPct() * 0.01), true)
			end
		end
	end
end
function q.prototype.OnCustomTakeDamage(self, t)
	if t.target == self.parent and self:HasTalent("antimage_talent_10") then
		self.damage_record = self.damage_record + t.damage
		local v = self.tl10_health_reduce * self.max_health * 0.01
		if self.damage_record > v then
			self.damage_record = 0
			self.parent:AddNewModifier(
				self.parent,
				self:GetAbility(),
				"modifier_antimage_talent_10_invincible",
				{ duration = self.tl10_invincible_duration }
			)
		end
	end
end
function q.prototype.OnCustomAbilityFullyCast(self, t)
	if self:HasTalent("antimage_talent_7") then
		self.parent:AddNewModifier(
			self.parent,
			self:GetAbility(),
			"modifier_antimage_talent7_buff",
			{ duration = self.tl7_duration }
		)
	end
end
function q.prototype.OnRestore(self, r)
	if not r.ignore_event then
		local w = self.parent:GetEnemy()
		self:ReduceEnemyMana(r.count)
	end
end
function q.prototype.ReduceEnemyMana(self, x)
	local u = x * self.mana_reduce_pct * 0.01
	if IsServer() then
		local w = self.parent:GetEnemy()
		if w:IsAlive() and not IsCustomHeroMana(w) then
			ReduceMana(w, u)
			if self:HasTalent("antimage_talent_11") and u > 0 then
				self.parent:DealDamage(
					w,
					self.parent:FindAbilityByName("antimage_talent_11"),
					self.tl11_damage_base * u,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
				)
			end
			RestoreCustomMana(self.parent, u * (1 + self:GetCustomManaBonusPct() * 0.01), true)
		end
	end
	if self:HasTalent("antimage_talent_8") then
		self.reduce_mana_record = self.reduce_mana_record + u
		local s = self.parent:FindModifierByName("modifier_antimage_talent8_buff")
		if s then
			s:SetStackCount(math.min(self.reduce_mana_record, self.tl8_limit))
		end
	end
end
function q.prototype.GetCustomManaBonusPct(self)
	self.custom_add = 0
	if self:HasTalent("antimage_talent_9") then
		self.custom_add = GetUltiPower(self.parent) / self.tl9_util_pct * self.tl9_add_custom_mana
	end
	local y = GetManaRegen(self.parent)
	if self.mana_base_pct > 0 then
		local z = self.custom_mana_bonus * y / self.mana_base_pct
		self.custom_add = self.custom_add + math.min(z, self.custom_mana_bonus_limit)
	end
	return self.custom_add
end
function q.prototype.EDeclareFunctions(self)
	return {}
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
g.modifier_antimage_talent = q
g.modifier_antimage_talent7_buff = c()
local A = g.modifier_antimage_talent7_buff
A.name = "modifier_antimage_talent7_buff"
d(A, i)
function A.prototype.GetAbilitySpecialValue(self)
	self.ulti_pct = self:GetAbilityTalentValue("antimage_talent_7", "ulti_pct")
	self.attack_bonus = self:GetAbilityTalentValue("antimage_talent_7", "attack_bonus")
end
function A.prototype.OnCreated(self, r)
	self:SetStackCount(1)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_antimage/antimage_counter.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		self.particleID,
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particleID, 1, Vector(130, 100, 100))
end
function A.prototype.OnRefresh(self, r)
	self:IncrementStackCount()
end
function A.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function A.prototype.EOM_GetModifierAttackDamageBonus(self, r)
	local B = GetUltiPower(self.parent)
	return self.attack_bonus * math.floor(B / self.ulti_pct) * self:GetStackCount()
end
function A.prototype.OnDestroy(self)
	ParticleManager:DestroyParticle(self.particleID, true)
end
A = e(
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
				IsIndependent = true,
			}
		),
	},
	A
)
g.modifier_antimage_talent7_buff = A
g.modifier_antimage_talent8_buff = c()
local C = g.modifier_antimage_talent8_buff
C.name = "modifier_antimage_talent8_buff"
d(C, i)
function C.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function C.prototype.EOM_GetModifierAttackSpeedBonus(self, r)
	return self:GetStackCount()
end
C = e(
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
	C
)
g.modifier_antimage_talent8_buff = C
g.modifier_antimage_talent9_buff = c()
local D = g.modifier_antimage_talent9_buff
D.name = "modifier_antimage_talent9_buff"
d(D, i)
function D.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function D.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, r)
	return -self:GetStackCount()
end
D = e(
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
	D
)
g.modifier_antimage_talent9_buff = D
g.modifier_antimage_talent_10_invincible = c()
local E = g.modifier_antimage_talent_10_invincible
E.name = "modifier_antimage_talent_10_invincible"
d(E, i)
function E.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100 }
end
function E.prototype.CheckState(self)
	return { [MODIFIER_STATE_FROZEN] = true }
end
E = e(
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
	E
)
g.modifier_antimage_talent_10_invincible = E
g.modifier_antimage_new_shard_buff = c()
local F = g.modifier_antimage_new_shard_buff
F.name = "modifier_antimage_new_shard_buff"
d(F, i)
function F.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilityTalentValue("antimage_shard", "interval")
end
function F.prototype.OnCreated(self, r)
	self:StartIntervalThink(self.interval)
end
function F.prototype.OnIntervalThink(self)
	self:SpellUlti()
end
function F.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { -1, self.parent } }
end
function F.prototype.OnCustomAbilityFullyCast(self, t)
	if t.unit == self.parent:GetEnemy() then
		self:StartIntervalThink(-1)
		self:StartThink(-1, "ulti")
		self:StartThink(self.interval, "ulti")
	end
end
function F.prototype.OnThink(self, G)
	if G == "ulti" then
		self:SpellUlti()
	end
end
function F.prototype.SpellUlti(self)
	local H = self.parent:GetAbilityByIndex(1)
	H:OnSpellStart()
end
function F.prototype.OnDestroy(self)
	self:StartIntervalThink(-1)
	self:StartThink(-1, "ulti")
end
F = e(
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
	F
)
g.modifier_antimage_new_shard_buff = F
g.antimage_ult = c()
local I = g.antimage_ult
I.name = "antimage_ult"
d(I, m)
function I.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.count = 1
end
function I.prototype.OnSpellStart(self, J)
	local K = self:GetCaster()
	local w = K:GetEnemy()
	local L = self:GetSpecialValueFor("stun_duration")
	local M = self:GetSpecialValueFor("magic_damage")
	K:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	GameTimer(0.4, function()
		local N = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_antimage/antimage_manavoid.vpcf",
			PATTACH_POINT,
			K
		)
		ParticleManager:SetParticleControlEnt(N, 0, w, PATTACH_POINT_FOLLOW, "attach_hitloc", w:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(N, 1, Vector(300, 0, 0))
		GameTimer(0.1, function()
			if IsInjurable(K, w) then
				K:DealDamage(w, self, M, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				AddStun(K, w, self, L)
				if self:HasTalent("antimage_talent_3") then
					local O = self:GetTalentValue("antimage_talent_3", "duration")
					K:AddNewModifier(K, self, "modifier_antimage_talent3", { duration = O })
					w:AddNewModifier(K, self, "modifier_antimage_talent3", { duration = O })
				end
			end
			GameTimer(0.1, function()
				ParticleManager:DestroyParticle(N, true)
			end)
		end)
	end)
end
I = e({ o(nil) }, I)
g.antimage_ult = I
g.modifier_antimage_shard_buff = c()
local P = g.modifier_antimage_shard_buff
P.name = "modifier_antimage_shard_buff"
d(P, i)
function P.prototype.GetAbilitySpecialValue(self)
	self.shard_magic_armor = self:GetAbilityTalentValue("antimage_shard", "magical_armor_pct")
end
function P.prototype.OnCreated(self, r)
	if IsServer() then
		PurgeDebuff(self.parent)
	end
end
function P.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function P.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, r)
	return -self.shard_magic_armor
end
P = e(
	{ j(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	P
)
g.modifier_antimage_shard_buff = P
g.antimage_talent_s = c()
local Q = g.antimage_talent_s
Q.name = "antimage_talent_s"
d(Q, m)
function Q.prototype.GetIntrinsicModifierName(self)
	return "modifier_antimage_talent_s"
end
Q = e({ o(nil) }, Q)
g.antimage_talent_s = Q
g.modifier_antimage_talent_s = c()
local R = g.modifier_antimage_talent_s
R.name = "modifier_antimage_talent_s"
d(R, i)
function R.prototype.GetAbilitySpecialValue(self)
	self.atk = self:GetAbilitySpecialValueFor("atk")
	self.exchange_amp_ulti_pct = self:GetAbilitySpecialValueFor("exchange_amp_ulti_pct")
	self.max_change = self:GetAbilitySpecialValueFor("max_change")
	self.mana_get = self:GetAbilitySpecialValueFor("mana_get")
		+ self:GetAbilityTalentValue("antimage_talent_2", "add_mana")
	self.add_mana_regen = self:GetAbilityTalentValue("antimage_talent_1", "add_mana_regen")
	self.tl6_exchange_mul = self:GetAbilityTalentValue("antimage_talent_6", "exchange_mul")
	self.has_talent5 = self:GetAbilityTalentValue("antimage_talent_5", "has_talent5")
end
function R.prototype.OnThink(self, G)
	if G == "temp_act" then
		self:SetStackCount(0)
		self:StartThink(-1, "temp_act")
	end
end
function R.prototype.IsActivated(self)
	return self.has_talent5 > 0
		or self:GetStackCount() > 0
		or IsValid(self:GetAbility()) and self:GetAbility():GetToggleState()
end
function R.prototype.setTempActivated(self, S)
	if IsServer() then
		self:SetStackCount(1)
		self:StartThink(S, "temp_act")
	end
end
function R.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self.parent, -1 } }
end
function R.prototype.OnCustomAttackLanded(self, t)
	if self:IsActivated() then
		if t.attacker == self.parent then
			Restore(self.parent, self.mana_get)
		end
	end
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function R.prototype.EOM_GetModifierUltiPower(self, r)
	if self:IsActivated() then
		if IsServer() then
		end
		local T
		if r ~= nil then
			T = r._antimage
		end
		if T then
			return 0
		else
			local U = math.min(math.floor(GetAttackDamage(self.caster, { _antimage = 1 }) / self.atk), self.max_change)
			return (self.exchange_amp_ulti_pct + self.add_mana_regen) * U * (self.tl6_exchange_mul * 0.01 + 1)
		end
	end
end
function R.prototype.SwapSkill(self, V)
	local W = self:GetParent()
	local w = W:GetEnemy()
	if not IsInjurable(W, w) then
		return
	end
end
R = e(
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
	R
)
g.modifier_antimage_talent_s = R
g.antimage_ult_s = c()
local X = g.antimage_ult_s
X.name = "antimage_ult_s"
d(X, m)
function X.prototype.OnSpellStart(self, J)
	local K = self:GetCaster()
	local w = K:GetEnemy()
	if self:HasTalent("antimage_talent_3") and not J then
		local O = self:GetTalentValue("antimage_talent_3", "duration")
		K:AddNewModifier(K, self, "modifier_antimage_talent3", { duration = O })
		w:AddNewModifier(K, self, "modifier_antimage_talent3", { duration = O })
	end
	if self:HasTalent("antimage_talent_4") and not J then
		local Y = self:GetTalentValue("antimage_talent_4", "duration")
		K:AddNewModifier(K, self, "modifier_antimage_talent4", { duration = Y })
		w:AddNewModifier(K, self, "modifier_antimage_talent4", { duration = Y })
	end
	if self:HasTalent("antimage_talent_5") and not J then
		local H = K:FindAbilityByName("antimage_ult")
		H:OnSpellStart(1)
	end
	K:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local Z = self:GetSpecialValueFor("damage")
	GameTimer(0.5, function()
		local N = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_antimage/antimage_manavoid.vpcf",
			PATTACH_POINT,
			K
		)
		ParticleManager:SetParticleControlEnt(N, 0, w, PATTACH_POINT_FOLLOW, "attach_hitloc", w:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(N, 1, Vector(300, 0, 0))
		K:DealDamage(w, self, Z, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end)
end
X = e({ o(nil) }, X)
g.antimage_ult_s = X
g.antimage_interact = c()
local _ = g.antimage_interact
_.name = "antimage_interact"
d(_, l)
function _.prototype.Spawn(self)
	if IsServer() then
		self:GetCaster():RemoveActivityModifier("kunai")
		self:GetCaster():RemoveModifierByName("modifier_antimage_sai")
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_antimage_katana", nil)
	end
end
function _.prototype.OnSpellStart(self)
	self:ToggleAbility()
end
function _.prototype.OnToggle(self)
	if IsServer() then
		local K = self:GetCaster()
		local a0 = self:GetToggleState()
		local s = K:FindModifierByName("modifier_antimage_interact")
		if IsValid(s) then
			s:SwichSkill(a0)
		end
	end
end
function _.prototype.GetIntrinsicModifierName(self)
	return "modifier_antimage_interact"
end
_ = e(
	{
		n(
			nil,
			{
				ActiveTextureName = "antimage/the_basher_blades/antimage_mana_void",
				InactiveTextureName = "antimage/golden_basher_blades/antimage_mana_void",
				talent_ability1 = "antimage_talent",
				talent_ability2 = "antimage_talent_s",
				ult_ability1 = "antimage_ult",
				ult_ability2 = "antimage_ult_s",
			}
		),
	},
	_
)
g.antimage_interact = _
g.modifier_antimage_interact = c()
local a1 = g.modifier_antimage_interact
a1.name = "modifier_antimage_interact"
d(a1, i)
function a1.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.isSpawn = true
end
function a1.prototype.GetAbilitySpecialValue(self)
	self.incoming_magical_dmg = self:GetAbilitySpecialValueFor("incoming_magical_dmg")
	self.add_amp_ult = self:GetAbilitySpecialValueFor("add_amp_ult")
end
function a1.prototype.OnCreated(self, r)
	if IsServer() then
		self.modifier1 = self.parent:FindModifierByName("modifier_antimage_talent")
		self.modifier2 = self.parent:FindModifierByName("modifier_antimage_talent_s")
		self:SetHasCustomTransmitterData(true)
		GameTimer(0.3, function()
			if IsValid(self) then
				self:UpdateActivated()
				self:SendBuffRefreshToClients()
			end
		end)
	end
end
function a1.prototype.SwichSkill(self, a2)
	local W = self:GetParent()
	if self.isSpawn then
		self.isSpawn = false
		return
	end
	GameTimer(0.5, function()
		if IsValid(self) then
			self:UpdateActivated()
		end
	end)
end
function a1.prototype.UpdateActivated(self)
	self:SendBuffRefreshToClients()
end
function a1.prototype.SetModel(self)
	local W = self.parent
	local a3 = Wearable:serviceGetEquipWearable(self.parent:GetPlayerOwnerID(), self.caster:GetUnitName())
	Wearable:equipWearable(self.caster, a3)
end
function a1.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CHANGE_INTERACT_ABILITY] = { self.caster },
	}
end
function a1.prototype.OnChangeInteractAbility(self)
	self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	local a4 = 0
	GameTimer(0.2, function()
		repeat
			local a5 = a4
			local a6, a7
			local a8 = a5 == 0
			if a8 then
				a6 = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_antimage/antimage_blink_start_b.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil,
					self.caster
				)
				ParticleManager:SetParticleControlTransform(a6, 0, self.caster:GetAbsOrigin(), VectorToAngles(vec3_top))
				ParticleManager:ReleaseParticleIndex(a6)
				self.caster:EmitSound("Hero_Antimage.Blink_out")
				self.caster:AddNoDraw()
				self:SetModel()
				self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
				a4 = 1
				return 0.2
			end
			a8 = a8 or a5 == 1
			if a8 then
				self.caster:EmitSound("Hero_Antimage.Blink_in")
				self.caster:RemoveNoDraw()
				a7 = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_antimage/antimage_blink_end.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil,
					self.caster
				)
				ParticleManager:SetParticleControlEnt(a7, 0, self.caster, PATTACH_ABSORIGIN, nil, vec3_zero, true)
				ParticleManager:ReleaseParticleIndex(a7)
				break
			end
		until true
	end)
end
function a1.prototype.OnBattleStartBefore(self, r)
	if IsServer() then
		self.enemy = self.caster:GetEnemy()
		self:StartIntervalThink(0.1)
	end
end
function a1.prototype.OnIntervalThink(self) end
function a1.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_WEARABLE_ID_LIST,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHANGE_MODEL,
	}
end
function a1.prototype.EOM_GetModifierOutgoingDamagePercentage(self) end
function a1.prototype.EOM_GetModifierChangeWearableIdList(self, r)
	if PlayerData:getplayerData(self.parent:GetPlayerOwnerID()):GetInteractiveAbilityState() then
		local a9 = Wearable:getUnitModelWearableID(
			"models/heroes/antimage_female/antimage_female.vmdl",
			self.parent:GetPlayerOwnerID()
		)
		if a9 == nil then
			return "708,714,715,716"
		end
		return a9
	end
end
function a1.prototype.EOM_GetModifierChangeModel(self, r)
	if PlayerData:getplayerData(self.parent:GetPlayerOwnerID()):GetInteractiveAbilityState() then
		return "models/heroes/antimage_female/antimage_female.vmdl"
	end
end
function a1.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, r)
	if self.isModifier1 == 1 then
		return -self.incoming_magical_dmg
	end
end
function a1.prototype.EOM_GetModifierUltiPower(self, r)
	if self.isModifier2 == 1 then
		return self.add_amp_ult
	end
end
function a1.prototype.AddCustomTransmitterData(self)
	return {
		isModifier1 = self.isModifier1,
		isModifier2 = self.isModifier2,
		incoming_magical_dmg = self.incoming_magical_dmg,
		add_amp_ult = self.add_amp_ult,
	}
end
function a1.prototype.HandleCustomTransmitterData(self, aa)
	self.isModifier1 = aa.isModifier1
	self.isModifier2 = aa.isModifier2
	self.incoming_magical_dmg = aa.incoming_magical_dmg
	self.add_amp_ult = aa.add_amp_ult
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
g.modifier_antimage_interact = a1
g.modifier_antimage_talent3 = c()
local ab = g.modifier_antimage_talent3
ab.name = "modifier_antimage_talent3"
d(ab, i)
function ab.prototype.GetAbilitySpecialValue(self)
	self.tl3_amp_ult_steal = self:GetAbilityTalentValue("antimage_talent_3", "amp_ult_steal")
end
function ab.prototype.OnCreated(self, r)
	self.is_caster = self.caster == self.parent
	if IsServer() then
		if not self.is_caster then
			self.enemy_amp_ult = GetUltiPower(self.parent, { _ignore_steal = true })
		else
			self.enemy_amp_ult = GetUltiPower(self.caster:GetEnemy(), { _ignore_steal = true })
		end
		self:SetStackCount(self.enemy_amp_ult)
	end
end
function ab.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function ab.prototype.EOM_GetModifierUltiPower(self, r)
	if r and r._ignore_steal then
		return
	end
	return (self.is_caster and self.tl3_amp_ult_steal or -self.tl3_amp_ult_steal) * 0.01 * self:GetStackCount()
end
ab = e(
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
	ab
)
g.modifier_antimage_talent3 = ab
g.modifier_antimage_talent4 = c()
local ac = g.modifier_antimage_talent4
ac.name = "modifier_antimage_talent4"
d(ac, i)
function ac.prototype.GetAbilitySpecialValue(self)
	self.tl4_atk_steal = self:GetAbilityTalentValue("antimage_talent_4", "atk_steal")
end
function ac.prototype.OnCreated(self, r)
	self.is_caster = self.caster == self.parent
	if IsServer() then
		if not self.is_caster then
			self.enemy_atk = GetAttackDamage(self.parent, nil, true)
		else
			self.enemy_atk = GetAttackDamage(self.caster:GetEnemy(), nil, true)
		end
		self:SetStackCount(self.enemy_atk)
	end
end
function ac.prototype.OnRefresh(self, r)
	if IsServer() then
		if not self.is_caster then
			self.enemy_atk = GetAttackDamage(self.parent, nil, true)
		else
			self.enemy_atk = GetAttackDamage(self.caster:GetEnemy(), nil, true)
		end
		self:SetStackCount(self.enemy_atk)
	end
end
function ac.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS_STEAL }
end
function ac.prototype.EOM_GetModifierAttackDamageBonusSteal(self, r)
	return (self.is_caster and self.tl4_atk_steal or -self.tl4_atk_steal) * 0.01 * self:GetStackCount()
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
g.modifier_antimage_talent4 = ac
return g