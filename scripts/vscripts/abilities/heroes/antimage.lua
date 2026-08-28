--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["387"] = 359,
		["388"] = 356,
		["389"] = 361,
		["390"] = 362,
		["391"] = 363,
		["392"] = 361,
		["393"] = 328,
		["394"] = 320,
		["395"] = 320,
		["396"] = 320,
		["397"] = 320,
		["398"] = 320,
		["399"] = 320,
		["400"] = 320,
		["401"] = 320,
		["402"] = 328,
		["404"] = 328,
		["406"] = 370,
		["407"] = 371,
		["408"] = 370,
		["409"] = 371,
		["411"] = 371,
		["412"] = 372,
		["413"] = 370,
		["414"] = 373,
		["415"] = 376,
		["416"] = 377,
		["417"] = 396,
		["418"] = 397,
		["419"] = 398,
		["420"] = 399,
		["421"] = 399,
		["422"] = 399,
		["423"] = 400,
		["424"] = 401,
		["425"] = 401,
		["426"] = 401,
		["427"] = 401,
		["428"] = 401,
		["429"] = 401,
		["430"] = 401,
		["431"] = 401,
		["432"] = 401,
		["433"] = 402,
		["434"] = 402,
		["435"] = 402,
		["436"] = 402,
		["437"] = 402,
		["438"] = 404,
		["439"] = 404,
		["440"] = 404,
		["441"] = 405,
		["442"] = 406,
		["443"] = 407,
		["444"] = 408,
		["445"] = 409,
		["446"] = 410,
		["447"] = 411,
		["450"] = 414,
		["451"] = 414,
		["452"] = 414,
		["453"] = 415,
		["454"] = 414,
		["455"] = 414,
		["456"] = 404,
		["457"] = 404,
		["458"] = 399,
		["459"] = 399,
		["460"] = 373,
		["461"] = 371,
		["462"] = 370,
		["463"] = 371,
		["465"] = 371,
		["466"] = 502,
		["467"] = 510,
		["468"] = 502,
		["469"] = 510,
		["470"] = 512,
		["471"] = 513,
		["472"] = 512,
		["473"] = 515,
		["474"] = 516,
		["475"] = 517,
		["477"] = 515,
		["478"] = 520,
		["479"] = 521,
		["480"] = 520,
		["481"] = 525,
		["482"] = 526,
		["483"] = 525,
		["484"] = 510,
		["485"] = 502,
		["486"] = 502,
		["487"] = 502,
		["488"] = 502,
		["489"] = 502,
		["490"] = 502,
		["491"] = 502,
		["492"] = 510,
		["494"] = 510,
		["496"] = 533,
		["497"] = 534,
		["498"] = 533,
		["499"] = 534,
		["500"] = 535,
		["501"] = 536,
		["502"] = 535,
		["503"] = 534,
		["504"] = 533,
		["505"] = 534,
		["507"] = 534,
		["508"] = 539,
		["509"] = 547,
		["510"] = 539,
		["511"] = 547,
		["512"] = 558,
		["513"] = 559,
		["514"] = 560,
		["515"] = 561,
		["516"] = 562,
		["517"] = 563,
		["518"] = 564,
		["519"] = 565,
		["520"] = 558,
		["521"] = 567,
		["522"] = 568,
		["523"] = 569,
		["524"] = 570,
		["526"] = 567,
		["527"] = 574,
		["528"] = 575,
		["529"] = 574,
		["530"] = 577,
		["531"] = 578,
		["532"] = 579,
		["533"] = 580,
		["535"] = 577,
		["536"] = 583,
		["537"] = 584,
		["538"] = 583,
		["539"] = 588,
		["540"] = 589,
		["541"] = 590,
		["542"] = 591,
		["545"] = 588,
		["546"] = 596,
		["547"] = 597,
		["548"] = 596,
		["549"] = 603,
		["550"] = 604,
		["551"] = 605,
		["554"] = 607,
		["555"] = 607,
		["558"] = 608,
		["560"] = 610,
		["561"] = 610,
		["562"] = 610,
		["563"] = 610,
		["564"] = 611,
		["567"] = 603,
		["568"] = 623,
		["569"] = 624,
		["570"] = 625,
		["571"] = 626,
		["574"] = 623,
		["575"] = 547,
		["576"] = 539,
		["577"] = 539,
		["578"] = 539,
		["579"] = 539,
		["580"] = 539,
		["581"] = 539,
		["582"] = 539,
		["583"] = 539,
		["584"] = 547,
		["586"] = 547,
		["588"] = 634,
		["589"] = 635,
		["590"] = 634,
		["591"] = 635,
		["592"] = 636,
		["593"] = 637,
		["594"] = 638,
		["595"] = 639,
		["596"] = 640,
		["597"] = 641,
		["598"] = 642,
		["600"] = 645,
		["601"] = 646,
		["602"] = 647,
		["603"] = 648,
		["605"] = 650,
		["606"] = 651,
		["607"] = 652,
		["609"] = 654,
		["610"] = 655,
		["611"] = 656,
		["612"] = 656,
		["613"] = 656,
		["614"] = 657,
		["615"] = 658,
		["616"] = 658,
		["617"] = 658,
		["618"] = 658,
		["619"] = 658,
		["620"] = 658,
		["621"] = 658,
		["622"] = 658,
		["623"] = 658,
		["624"] = 659,
		["625"] = 659,
		["626"] = 659,
		["627"] = 659,
		["628"] = 659,
		["629"] = 660,
		["630"] = 656,
		["631"] = 656,
		["632"] = 636,
		["633"] = 635,
		["634"] = 634,
		["635"] = 635,
		["637"] = 635,
		["639"] = 667,
		["640"] = 676,
		["641"] = 667,
		["642"] = 676,
		["643"] = 677,
		["644"] = 678,
		["645"] = 679,
		["646"] = 680,
		["647"] = 681,
		["648"] = 681,
		["649"] = 681,
		["650"] = 681,
		["651"] = 681,
		["652"] = 681,
		["654"] = 677,
		["655"] = 684,
		["656"] = 685,
		["657"] = 684,
		["658"] = 687,
		["659"] = 688,
		["660"] = 689,
		["661"] = 690,
		["662"] = 691,
		["663"] = 692,
		["664"] = 693,
		["667"] = 687,
		["668"] = 698,
		["669"] = 699,
		["670"] = 698,
		["671"] = 676,
		["672"] = 667,
		["673"] = 667,
		["674"] = 667,
		["675"] = 667,
		["676"] = 667,
		["677"] = 667,
		["678"] = 667,
		["679"] = 667,
		["680"] = 676,
		["682"] = 676,
		["683"] = 702,
		["684"] = 710,
		["685"] = 702,
		["686"] = 710,
		["688"] = 710,
		["689"] = 726,
		["690"] = 702,
		["691"] = 727,
		["692"] = 728,
		["693"] = 729,
		["694"] = 727,
		["695"] = 734,
		["696"] = 735,
		["697"] = 737,
		["698"] = 738,
		["699"] = 739,
		["700"] = 740,
		["701"] = 740,
		["702"] = 740,
		["703"] = 741,
		["704"] = 742,
		["705"] = 745,
		["707"] = 740,
		["708"] = 740,
		["710"] = 734,
		["711"] = 750,
		["712"] = 752,
		["713"] = 753,
		["714"] = 754,
		["717"] = 757,
		["718"] = 757,
		["719"] = 757,
		["720"] = 758,
		["721"] = 759,
		["723"] = 757,
		["724"] = 757,
		["725"] = 750,
		["726"] = 764,
		["727"] = 767,
		["728"] = 764,
		["729"] = 770,
		["730"] = 771,
		["731"] = 772,
		["732"] = 772,
		["733"] = 772,
		["734"] = 772,
		["735"] = 773,
		["736"] = 770,
		["737"] = 775,
		["738"] = 776,
		["739"] = 775,
		["740"] = 783,
		["741"] = 785,
		["742"] = 786,
		["743"] = 787,
		["744"] = 787,
		["745"] = 787,
		["747"] = 788,
		["748"] = 790,
		["749"] = 789,
		["751"] = 790,
		["752"] = 791,
		["753"] = 791,
		["754"] = 791,
		["755"] = 791,
		["756"] = 791,
		["757"] = 791,
		["758"] = 792,
		["759"] = 793,
		["760"] = 794,
		["761"] = 795,
		["762"] = 796,
		["763"] = 797,
		["764"] = 798,
		["766"] = 799,
		["768"] = 800,
		["769"] = 801,
		["770"] = 802,
		["771"] = 803,
		["772"] = 803,
		["773"] = 803,
		["774"] = 803,
		["775"] = 803,
		["776"] = 803,
		["777"] = 803,
		["778"] = 803,
		["779"] = 803,
		["780"] = 804,
		["784"] = 787,
		["785"] = 787,
		["786"] = 783,
		["787"] = 808,
		["788"] = 809,
		["789"] = 810,
		["790"] = 811,
		["792"] = 808,
		["793"] = 820,
		["794"] = 820,
		["795"] = 829,
		["796"] = 830,
		["797"] = 830,
		["798"] = 830,
		["799"] = 830,
		["800"] = 830,
		["801"] = 830,
		["802"] = 830,
		["803"] = 829,
		["804"] = 841,
		["805"] = 841,
		["806"] = 846,
		["807"] = 847,
		["808"] = 848,
		["809"] = 848,
		["810"] = 848,
		["811"] = 848,
		["812"] = 849,
		["813"] = 850,
		["815"] = 852,
		["817"] = 846,
		["818"] = 857,
		["819"] = 858,
		["820"] = 859,
		["822"] = 857,
		["823"] = 863,
		["824"] = 864,
		["825"] = 865,
		["827"] = 863,
		["828"] = 869,
		["829"] = 870,
		["830"] = 871,
		["832"] = 869,
		["833"] = 875,
		["834"] = 876,
		["835"] = 875,
		["836"] = 883,
		["837"] = 884,
		["838"] = 885,
		["839"] = 886,
		["840"] = 887,
		["841"] = 883,
		["842"] = 710,
		["843"] = 702,
		["844"] = 702,
		["845"] = 702,
		["846"] = 702,
		["847"] = 702,
		["848"] = 702,
		["849"] = 702,
		["850"] = 702,
		["851"] = 710,
		["853"] = 710,
		["854"] = 891,
		["855"] = 899,
		["856"] = 891,
		["857"] = 899,
		["858"] = 905,
		["859"] = 906,
		["860"] = 905,
		["861"] = 908,
		["862"] = 909,
		["863"] = 910,
		["864"] = 911,
		["865"] = 912,
		["867"] = 914,
		["868"] = 914,
		["869"] = 914,
		["870"] = 914,
		["872"] = 916,
		["874"] = 908,
		["875"] = 919,
		["876"] = 920,
		["877"] = 919,
		["878"] = 924,
		["879"] = 925,
		["882"] = 928,
		["883"] = 924,
		["884"] = 899,
		["885"] = 891,
		["886"] = 891,
		["887"] = 891,
		["888"] = 891,
		["889"] = 891,
		["890"] = 891,
		["891"] = 891,
		["892"] = 891,
		["893"] = 899,
		["895"] = 899,
		["896"] = 932,
		["897"] = 940,
		["898"] = 932,
		["899"] = 940,
		["900"] = 945,
		["901"] = 946,
		["902"] = 945,
		["903"] = 948,
		["904"] = 949,
		["905"] = 950,
		["906"] = 951,
		["907"] = 952,
		["909"] = 954,
		["910"] = 954,
		["911"] = 954,
		["912"] = 954,
		["913"] = 954,
		["915"] = 956,
		["917"] = 948,
		["918"] = 959,
		["919"] = 960,
		["920"] = 961,
		["921"] = 962,
		["923"] = 964,
		["924"] = 964,
		["925"] = 964,
		["926"] = 964,
		["927"] = 964,
		["929"] = 966,
		["931"] = 959,
		["932"] = 970,
		["933"] = 971,
		["934"] = 970,
		["935"] = 975,
		["936"] = 976,
		["937"] = 975,
		["938"] = 940,
		["939"] = 932,
		["940"] = 932,
		["941"] = 932,
		["942"] = 932,
		["943"] = 932,
		["944"] = 932,
		["945"] = 932,
		["946"] = 932,
		["947"] = 940,
		["949"] = 940,
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
	local H = self.parent:FindAbilityByName("antimage_ult")
	if not IsValid(H) then
		return
	end
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