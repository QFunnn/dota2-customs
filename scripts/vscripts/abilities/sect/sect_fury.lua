--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_fury"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["20"] = 5,
		["21"] = 7,
		["22"] = 9,
		["23"] = 11,
		["24"] = 13,
		["25"] = 35,
		["26"] = 4,
		["27"] = 41,
		["28"] = 42,
		["29"] = 43,
		["30"] = 44,
		["31"] = 45,
		["32"] = 46,
		["33"] = 47,
		["34"] = 48,
		["35"] = 49,
		["36"] = 50,
		["37"] = 51,
		["38"] = 52,
		["39"] = 53,
		["40"] = 54,
		["41"] = 55,
		["42"] = 56,
		["43"] = 57,
		["44"] = 58,
		["45"] = 59,
		["46"] = 60,
		["47"] = 61,
		["48"] = 62,
		["49"] = 63,
		["50"] = 65,
		["51"] = 41,
		["52"] = 67,
		["53"] = 67,
		["54"] = 67,
		["56"] = 68,
		["57"] = 69,
		["61"] = 70,
		["62"] = 71,
		["65"] = 72,
		["66"] = 72,
		["67"] = 72,
		["68"] = 72,
		["69"] = 72,
		["70"] = 72,
		["71"] = 72,
		["75"] = 75,
		["78"] = 76,
		["82"] = 79,
		["85"] = 80,
		["86"] = 81,
		["87"] = 82,
		["88"] = 82,
		["89"] = 82,
		["90"] = 82,
		["91"] = 82,
		["92"] = 82,
		["93"] = 82,
		["94"] = 82,
		["95"] = 82,
		["96"] = 83,
		["97"] = 83,
		["98"] = 83,
		["99"] = 83,
		["100"] = 83,
		["101"] = 84,
		["102"] = 84,
		["103"] = 84,
		["104"] = 84,
		["105"] = 84,
		["109"] = 87,
		["112"] = 88,
		["113"] = 89,
		["114"] = 89,
		["115"] = 89,
		["116"] = 89,
		["117"] = 89,
		["118"] = 90,
		["119"] = 90,
		["120"] = 90,
		["121"] = 90,
		["122"] = 90,
		["123"] = 91,
		["124"] = 92,
		["125"] = 93,
		["126"] = 93,
		["127"] = 93,
		["128"] = 93,
		["129"] = 93,
		["130"] = 94,
		["131"] = 94,
		["132"] = 94,
		["133"] = 94,
		["134"] = 94,
		["135"] = 95,
		["136"] = 96,
		["137"] = 96,
		["138"] = 96,
		["139"] = 96,
		["140"] = 96,
		["141"] = 96,
		["142"] = 96,
		["143"] = 96,
		["147"] = 99,
		["150"] = 100,
		["151"] = 101,
		["152"] = 101,
		["153"] = 101,
		["154"] = 101,
		["155"] = 101,
		["156"] = 101,
		["157"] = 107,
		["158"] = 108,
		["159"] = 109,
		["160"] = 110,
		["161"] = 111,
		["163"] = 113,
		["164"] = 113,
		["165"] = 113,
		["166"] = 113,
		["167"] = 113,
		["168"] = 113,
		["169"] = 113,
		["170"] = 113,
		["172"] = 115,
		["173"] = 116,
		["174"] = 117,
		["175"] = 118,
		["176"] = 101,
		["177"] = 101,
		["178"] = 121,
		["182"] = 124,
		["185"] = 125,
		["186"] = 125,
		["187"] = 125,
		["188"] = 125,
		["189"] = 125,
		["190"] = 125,
		["195"] = 67,
		["196"] = 130,
		["197"] = 131,
		["198"] = 130,
		["199"] = 5,
		["200"] = 4,
		["201"] = 5,
		["203"] = 5,
		["204"] = 135,
		["205"] = 143,
		["206"] = 135,
		["207"] = 143,
		["209"] = 143,
		["210"] = 147,
		["211"] = 149,
		["212"] = 151,
		["213"] = 157,
		["214"] = 196,
		["215"] = 135,
		["216"] = 203,
		["217"] = 204,
		["218"] = 205,
		["219"] = 206,
		["220"] = 207,
		["221"] = 208,
		["222"] = 209,
		["223"] = 210,
		["224"] = 211,
		["225"] = 212,
		["226"] = 213,
		["227"] = 216,
		["228"] = 217,
		["229"] = 218,
		["230"] = 219,
		["231"] = 220,
		["232"] = 221,
		["233"] = 229,
		["234"] = 230,
		["235"] = 231,
		["236"] = 232,
		["237"] = 233,
		["238"] = 234,
		["239"] = 235,
		["240"] = 236,
		["241"] = 238,
		["242"] = 239,
		["243"] = 203,
		["244"] = 242,
		["245"] = 243,
		["246"] = 244,
		["247"] = 245,
		["249"] = 247,
		["250"] = 242,
		["251"] = 249,
		["252"] = 250,
		["253"] = 251,
		["254"] = 253,
		["255"] = 254,
		["256"] = 255,
		["257"] = 256,
		["258"] = 257,
		["261"] = 261,
		["262"] = 262,
		["263"] = 263,
		["264"] = 264,
		["265"] = 265,
		["268"] = 249,
		["269"] = 278,
		["270"] = 279,
		["271"] = 279,
		["272"] = 279,
		["273"] = 282,
		["274"] = 282,
		["275"] = 282,
		["276"] = 279,
		["277"] = 279,
		["278"] = 285,
		["279"] = 285,
		["280"] = 285,
		["281"] = 279,
		["282"] = 279,
		["283"] = 278,
		["284"] = 288,
		["285"] = 289,
		["286"] = 288,
		["287"] = 294,
		["288"] = 295,
		["289"] = 294,
		["290"] = 299,
		["291"] = 300,
		["292"] = 299,
		["293"] = 302,
		["294"] = 303,
		["295"] = 304,
		["297"] = 307,
		["298"] = 308,
		["300"] = 313,
		["301"] = 315,
		["302"] = 316,
		["303"] = 316,
		["304"] = 316,
		["305"] = 316,
		["306"] = 316,
		["307"] = 316,
		["308"] = 319,
		["309"] = 320,
		["311"] = 302,
		["312"] = 323,
		["313"] = 324,
		["314"] = 325,
		["315"] = 326,
		["316"] = 327,
		["317"] = 328,
		["318"] = 330,
		["319"] = 332,
		["320"] = 332,
		["321"] = 332,
		["322"] = 332,
		["323"] = 332,
		["324"] = 332,
		["325"] = 334,
		["326"] = 335,
		["327"] = 335,
		["328"] = 335,
		["329"] = 335,
		["330"] = 335,
		["331"] = 335,
		["333"] = 338,
		["334"] = 339,
		["335"] = 340,
		["336"] = 341,
		["337"] = 342,
		["338"] = 343,
		["339"] = 343,
		["340"] = 344,
		["341"] = 344,
		["342"] = 345,
		["343"] = 346,
		["346"] = 349,
		["347"] = 350,
		["349"] = 352,
		["352"] = 356,
		["353"] = 357,
		["354"] = 359,
		["355"] = 360,
		["356"] = 361,
		["358"] = 363,
		["359"] = 364,
		["360"] = 365,
		["361"] = 366,
		["362"] = 367,
		["363"] = 368,
		["365"] = 370,
		["366"] = 371,
		["369"] = 374,
		["370"] = 375,
		["371"] = 376,
		["372"] = 377,
		["374"] = 379,
		["375"] = 380,
		["379"] = 323,
		["380"] = 392,
		["381"] = 393,
		["382"] = 394,
		["383"] = 395,
		["384"] = 398,
		["385"] = 400,
		["386"] = 401,
		["387"] = 401,
		["388"] = 401,
		["389"] = 401,
		["390"] = 401,
		["391"] = 401,
		["393"] = 404,
		["394"] = 405,
		["395"] = 405,
		["396"] = 405,
		["397"] = 405,
		["398"] = 405,
		["399"] = 406,
		["400"] = 406,
		["401"] = 406,
		["402"] = 406,
		["403"] = 406,
		["404"] = 407,
		["405"] = 407,
		["406"] = 407,
		["407"] = 407,
		["408"] = 407,
		["409"] = 408,
		["412"] = 392,
		["413"] = 421,
		["414"] = 422,
		["415"] = 423,
		["416"] = 424,
		["417"] = 425,
		["418"] = 426,
		["421"] = 421,
		["422"] = 430,
		["423"] = 431,
		["424"] = 432,
		["425"] = 433,
		["427"] = 430,
		["428"] = 441,
		["429"] = 442,
		["430"] = 443,
		["431"] = 445,
		["432"] = 446,
		["436"] = 441,
		["437"] = 451,
		["438"] = 452,
		["439"] = 454,
		["440"] = 460,
		["441"] = 461,
		["442"] = 462,
		["443"] = 463,
		["445"] = 467,
		["446"] = 468,
		["448"] = 471,
		["449"] = 472,
		["452"] = 451,
		["453"] = 493,
		["454"] = 494,
		["455"] = 493,
		["456"] = 499,
		["457"] = 500,
		["460"] = 503,
		["463"] = 506,
		["464"] = 507,
		["466"] = 507,
		["469"] = 499,
		["470"] = 511,
		["471"] = 512,
		["472"] = 513,
		["473"] = 513,
		["474"] = 513,
		["475"] = 513,
		["476"] = 513,
		["477"] = 513,
		["478"] = 513,
		["479"] = 513,
		["480"] = 513,
		["481"] = 513,
		["482"] = 511,
		["483"] = 143,
		["484"] = 135,
		["485"] = 135,
		["486"] = 135,
		["487"] = 135,
		["488"] = 135,
		["489"] = 135,
		["490"] = 135,
		["491"] = 143,
		["493"] = 143,
		["494"] = 518,
		["495"] = 525,
		["496"] = 518,
		["497"] = 525,
		["498"] = 527,
		["499"] = 528,
		["500"] = 527,
		["501"] = 530,
		["502"] = 531,
		["503"] = 532,
		["504"] = 532,
		["505"] = 531,
		["506"] = 530,
		["507"] = 535,
		["508"] = 536,
		["509"] = 535,
		["510"] = 538,
		["511"] = 539,
		["512"] = 538,
		["513"] = 543,
		["514"] = 544,
		["515"] = 543,
		["516"] = 525,
		["517"] = 518,
		["518"] = 518,
		["519"] = 518,
		["520"] = 518,
		["521"] = 518,
		["522"] = 518,
		["523"] = 518,
		["524"] = 525,
		["526"] = 525,
		["527"] = 547,
		["528"] = 554,
		["529"] = 547,
		["530"] = 554,
		["531"] = 557,
		["532"] = 558,
		["533"] = 559,
		["534"] = 557,
		["535"] = 561,
		["536"] = 562,
		["537"] = 563,
		["538"] = 563,
		["539"] = 563,
		["540"] = 563,
		["541"] = 564,
		["542"] = 565,
		["544"] = 567,
		["545"] = 567,
		["546"] = 567,
		["547"] = 567,
		["548"] = 567,
		["549"] = 568,
		["550"] = 569,
		["551"] = 570,
		["552"] = 571,
		["553"] = 571,
		["554"] = 571,
		["555"] = 571,
		["556"] = 571,
		["557"] = 572,
		["558"] = 572,
		["559"] = 572,
		["560"] = 572,
		["561"] = 572,
		["562"] = 572,
		["563"] = 572,
		["564"] = 572,
		["566"] = 561,
		["567"] = 576,
		["568"] = 577,
		["569"] = 578,
		["570"] = 578,
		["571"] = 578,
		["572"] = 578,
		["573"] = 578,
		["574"] = 578,
		["576"] = 576,
		["577"] = 581,
		["578"] = 582,
		["579"] = 583,
		["580"] = 583,
		["581"] = 583,
		["582"] = 583,
		["584"] = 581,
		["585"] = 586,
		["586"] = 587,
		["587"] = 586,
		["588"] = 591,
		["589"] = 592,
		["590"] = 593,
		["591"] = 593,
		["592"] = 593,
		["593"] = 592,
		["594"] = 592,
		["595"] = 592,
		["596"] = 591,
		["597"] = 597,
		["598"] = 598,
		["599"] = 597,
		["600"] = 600,
		["601"] = 601,
		["602"] = 600,
		["603"] = 603,
		["604"] = 604,
		["605"] = 605,
		["606"] = 606,
		["607"] = 606,
		["608"] = 606,
		["609"] = 606,
		["610"] = 606,
		["611"] = 606,
		["613"] = 603,
		["614"] = 554,
		["615"] = 547,
		["616"] = 547,
		["617"] = 547,
		["618"] = 547,
		["619"] = 547,
		["620"] = 547,
		["621"] = 547,
		["622"] = 554,
		["624"] = 554,
		["625"] = 613,
		["626"] = 621,
		["627"] = 613,
		["628"] = 621,
		["629"] = 622,
		["630"] = 623,
		["631"] = 624,
		["632"] = 625,
		["633"] = 626,
		["636"] = 622,
		["637"] = 630,
		["638"] = 631,
		["639"] = 632,
		["640"] = 633,
		["641"] = 634,
		["644"] = 630,
		["645"] = 638,
		["646"] = 639,
		["647"] = 638,
		["648"] = 643,
		["649"] = 644,
		["650"] = 643,
		["651"] = 621,
		["652"] = 613,
		["653"] = 613,
		["654"] = 613,
		["655"] = 613,
		["656"] = 613,
		["657"] = 613,
		["658"] = 613,
		["659"] = 613,
		["660"] = 621,
		["662"] = 621,
		["664"] = 649,
		["665"] = 656,
		["666"] = 649,
		["667"] = 656,
		["669"] = 656,
		["670"] = 658,
		["671"] = 649,
		["672"] = 661,
		["673"] = 662,
		["674"] = 663,
		["675"] = 664,
		["676"] = 664,
		["677"] = 664,
		["678"] = 664,
		["679"] = 664,
		["680"] = 665,
		["681"] = 666,
		["682"] = 667,
		["683"] = 668,
		["684"] = 669,
		["685"] = 670,
		["686"] = 670,
		["687"] = 670,
		["688"] = 670,
		["689"] = 670,
		["690"] = 670,
		["692"] = 675,
		["693"] = 676,
		["694"] = 677,
		["695"] = 678,
		["696"] = 679,
		["697"] = 680,
		["698"] = 686,
		["699"] = 687,
		["700"] = 687,
		["701"] = 687,
		["702"] = 687,
		["703"] = 687,
		["704"] = 687,
		["705"] = 687,
		["706"] = 687,
		["707"] = 687,
		["708"] = 688,
		["709"] = 688,
		["710"] = 688,
		["711"] = 688,
		["712"] = 688,
		["713"] = 688,
		["714"] = 688,
		["715"] = 688,
		["717"] = 661,
		["718"] = 691,
		["719"] = 692,
		["720"] = 693,
		["721"] = 694,
		["722"] = 695,
		["723"] = 696,
		["724"] = 697,
		["725"] = 698,
		["726"] = 699,
		["727"] = 700,
		["728"] = 701,
		["729"] = 701,
		["730"] = 701,
		["731"] = 701,
		["732"] = 701,
		["733"] = 701,
		["734"] = 701,
		["735"] = 701,
		["736"] = 701,
		["737"] = 702,
		["738"] = 702,
		["739"] = 702,
		["740"] = 702,
		["741"] = 702,
		["742"] = 703,
		["744"] = 705,
		["745"] = 706,
		["746"] = 706,
		["747"] = 706,
		["748"] = 706,
		["749"] = 706,
		["750"] = 706,
		["751"] = 706,
		["752"] = 706,
		["753"] = 706,
		["754"] = 707,
		["756"] = 709,
		["758"] = 711,
		["759"] = 712,
		["760"] = 712,
		["761"] = 712,
		["762"] = 712,
		["763"] = 712,
		["764"] = 714,
		["765"] = 715,
		["767"] = 717,
		["768"] = 717,
		["769"] = 717,
		["770"] = 717,
		["771"] = 717,
		["774"] = 691,
		["775"] = 721,
		["776"] = 722,
		["779"] = 725,
		["782"] = 728,
		["783"] = 729,
		["784"] = 730,
		["785"] = 731,
		["786"] = 732,
		["789"] = 735,
		["790"] = 736,
		["791"] = 737,
		["792"] = 738,
		["793"] = 738,
		["794"] = 738,
		["795"] = 738,
		["796"] = 738,
		["797"] = 738,
		["798"] = 738,
		["799"] = 738,
		["800"] = 738,
		["801"] = 738,
		["803"] = 721,
		["804"] = 750,
		["805"] = 751,
		["806"] = 752,
		["807"] = 752,
		["808"] = 751,
		["809"] = 750,
		["810"] = 755,
		["811"] = 756,
		["812"] = 755,
		["813"] = 758,
		["814"] = 759,
		["815"] = 758,
		["816"] = 764,
		["817"] = 765,
		["818"] = 764,
		["819"] = 769,
		["820"] = 770,
		["821"] = 769,
		["822"] = 774,
		["823"] = 775,
		["824"] = 776,
		["826"] = 779,
		["827"] = 780,
		["829"] = 782,
		["830"] = 783,
		["831"] = 784,
		["833"] = 786,
		["834"] = 774,
		["835"] = 656,
		["836"] = 649,
		["837"] = 649,
		["838"] = 649,
		["839"] = 649,
		["840"] = 649,
		["841"] = 649,
		["842"] = 649,
		["843"] = 656,
		["845"] = 656,
		["847"] = 791,
		["848"] = 798,
		["849"] = 791,
		["850"] = 798,
		["851"] = 800,
		["852"] = 801,
		["853"] = 802,
		["855"] = 800,
		["856"] = 805,
		["857"] = 806,
		["858"] = 805,
		["859"] = 810,
		["860"] = 811,
		["861"] = 810,
		["862"] = 798,
		["863"] = 791,
		["864"] = 791,
		["865"] = 791,
		["866"] = 791,
		["867"] = 791,
		["868"] = 791,
		["869"] = 791,
		["870"] = 798,
		["872"] = 798,
		["874"] = 816,
		["875"] = 823,
		["876"] = 816,
		["877"] = 823,
		["878"] = 827,
		["879"] = 828,
		["880"] = 829,
		["881"] = 827,
		["882"] = 831,
		["883"] = 832,
		["884"] = 833,
		["886"] = 831,
		["887"] = 836,
		["888"] = 837,
		["889"] = 836,
		["890"] = 841,
		["891"] = 842,
		["892"] = 843,
		["893"] = 843,
		["894"] = 843,
		["895"] = 843,
		["896"] = 843,
		["897"] = 843,
		["898"] = 843,
		["900"] = 841,
		["901"] = 823,
		["902"] = 816,
		["903"] = 816,
		["904"] = 816,
		["905"] = 816,
		["906"] = 816,
		["907"] = 816,
		["908"] = 816,
		["909"] = 823,
		["911"] = 823,
		["913"] = 849,
		["914"] = 856,
		["915"] = 849,
		["916"] = 856,
		["917"] = 860,
		["918"] = 861,
		["919"] = 862,
		["920"] = 860,
		["921"] = 864,
		["922"] = 865,
		["923"] = 866,
		["925"] = 864,
		["926"] = 869,
		["927"] = 870,
		["928"] = 869,
		["929"] = 874,
		["930"] = 875,
		["931"] = 876,
		["933"] = 874,
		["934"] = 856,
		["935"] = 849,
		["936"] = 849,
		["937"] = 849,
		["938"] = 849,
		["939"] = 849,
		["940"] = 849,
		["941"] = 849,
		["942"] = 856,
		["944"] = 856,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.sect_fury = c()
local o = h.sect_fury
o.name = "sect_fury"
d(o, j)
function o.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_129_timer = 0
	self.n_133_timer = 0
	self.sr_138_timer = 0
	self.sr_160_enable = false
end
function o.prototype.GetAbilitySpecialValue(self)
	self.fury_count_extra = self:GetSpecialValueFor("fury_count_extra")
	self.ice_fury_pct = self:GetSpecialValueFor("ice_fury_pct")
	self.n_128_chance = self:GetSectSpecialValueFor("128", "n_128_chance")
	self.n_128_poison = self:GetSectSpecialValueFor("128", "n_128_poison")
	self.n_129_interval = self:GetSectSpecialValueFor("129", "n_129_interval")
	self.n_129_fury = self:GetSectSpecialValueFor("129", "n_129_fury")
	self.n_133_chance = self:GetSectSpecialValueFor("133", "n_133_chance")
	self.r_135_chance = self:GetSectSpecialValueFor("135", "r_135_chance")
	self.r_135_fury = self:GetSectSpecialValueFor("135", "r_135_fury")
	self.r_136_fury_stack = self:GetSectSpecialValueFor("136", "r_136_fury_stack")
	self.sr_138_interval = self:GetSectSpecialValueFor("138", "sr_138_interval")
	self.sr_138_fury = self:GetSectSpecialValueFor("138", "sr_138_fury")
	self.sr_138_base_damage = self:GetSectSpecialValueFor("138", "sr_138_base_damage")
	self.sr_138_damage = self:GetSectSpecialValueFor("138", "sr_138_damage")
	self.sr_150_chance = self:GetSectSpecialValueFor("150", "sr_150_chance")
	self.sr_150_damage = self:GetSectSpecialValueFor("150", "sr_150_damage")
	self.r_155_fury = self:GetSectSpecialValueFor("155", "r_155_fury")
	self.r_155_fury_permanent = self:GetSectSpecialValueFor("155", "r_155_fury_permanent")
	self.sr_160_factor = self:GetSectSpecialValueFor("160", "sr_160_factor")
	self.n_176_chance = self:GetSectSpecialValueFor("176", "n_176_chance")
	self.n_176_chaos_count = self:GetSectSpecialValueFor("176", "n_176_chaos_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
	self.effect_1 = self:GetSectSpecialValueFor("150", "effect_1")
end
function o.prototype.TriggerByName(self, p, q)
	if q == nil then
		q = self:GetCaster():GetEnemy()
	end
	local r = self:GetCaster()
	if not IsInjurable(q, r) then
		return
	end
	repeat
		local s = p
		local t = s == "128"
		if t then
			do
				AddPoison(r, q, self.n_128_poison, "128", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "129"
		if t then
			do
				AddFury(r, self.n_129_fury, "129", "AbilityUpgrade")
				break
			end
		end
		t = t or s == "135"
		if t then
			do
				AddFury(r, self.r_135_fury, "135", "AbilityUpgrade")
				local u = ParticleManager:CreateParticle("particles/sect/sect_fury_135.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(u, 1, r, PATTACH_ABSORIGIN, "", vec3_zero, false)
				ParticleManager:SetParticleControl(u, 0, r:GetAbsOrigin())
				ParticleManager:SetParticleControl(u, 1, q:GetAbsOrigin())
				break
			end
		end
		t = t or s == "138"
		if t then
			do
				local v = ParticleManager:CreateParticle(
					"particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf",
					PATTACH_CUSTOMORIGIN,
					r
				)
				ParticleManager:SetParticleControl(v, 0, q:GetAbsOrigin())
				ParticleManager:SetParticleControl(v, 1, Vector(450, 1, 1))
				r:EmitSound("Ability.LightStrikeArray")
				local w = ParticleManager:CreateParticle(
					"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_immortal1.vpcf",
					PATTACH_CUSTOMORIGIN,
					r
				)
				ParticleManager:SetParticleControl(w, 0, q:GetAbsOrigin())
				ParticleManager:SetParticleControl(w, 1, Vector(450, 450, 1))
				r:EmitSound("Hero_Invoker.SunStrike.Charge.Apex")
				r:DealDamage(
					q,
					self,
					GetFury(r) * self.sr_138_damage + self.sr_138_base_damage,
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
					nil,
					"138"
				)
				break
			end
		end
		t = t or s == "150"
		if t then
			do
				local x = self
				Projectile:CreateTrackingProjectile({
					EffectName = "particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf",
					hCaster = r,
					vSpawnOrigin = r:GetAttachmentPosition("attach_hitloc"),
					hTarget = q,
					iMoveSpeed = 1200,
					OnProjectileHit = function(y, z, A)
						if IsInjurable(q) then
							local B = self.sr_150_damage
							if self.effect_1 > 0 then
								B = B + GetFury(r) * self.effect_1 * 0.01
							end
							r:DealDamage(q, x, B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL, nil, "150")
						end
						local C = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_impact.vpcf",
							PATTACH_CUSTOMORIGIN,
							nil
						)
						ParticleManager:SetParticleControl(C, 0, z)
						ParticleManager:SetParticleControl(C, 3, z)
						ParticleManager:ReleaseParticleIndex(C)
					end,
				})
				r:EmitSound("Hero_Snapfire.MortimerBlob.Launch")
				break
			end
		end
		t = t or s == "176"
		if t then
			do
				AddChaos(r, GetSectChaosModifiedValue(r, self.n_176_chaos_count), "176", "AbilityUpgrade")
				break
			end
		end
	until true
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_fury"
end
o = e({ k(nil) }, o)
h.sect_fury = o
h.modifier_sect_fury = c()
local D = h.modifier_sect_fury
D.name = "modifier_sect_fury"
d(D, m)
function D.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.timerInterval = 0.1
	self.n_129_timer = 0
	self.n_133_timer = 0
	self.sr_138_timer = 0
	self.sr_160_enable = false
end
function D.prototype.GetAbilitySpecialValue(self)
	self.fury_count_extra = self:GetAbilitySpecialValueFor("fury_count_extra")
	self.ice_fury_pct = self:GetAbilitySpecialValueFor("ice_fury_pct")
	self.n_128_chance = self:GetSectSpecialValueFor("128", "n_128_chance")
	self.n_128_poison = self:GetSectSpecialValueFor("128", "n_128_poison")
	self.n_129_interval = self:GetSectSpecialValueFor("129", "n_129_interval")
	self.n_129_fury = self:GetSectSpecialValueFor("129", "n_129_fury")
	self.n_133_chance = self:GetSectSpecialValueFor("133", "n_133_chance")
	self.r_135_chance = self:GetSectSpecialValueFor("135", "r_135_chance")
	self.r_135_fury = self:GetSectSpecialValueFor("135", "r_135_fury")
	self.r_136_fury_stack = self:GetSectSpecialValueFor("136", "r_136_fury_stack")
	self.sr_138_interval = self:GetSectSpecialValueFor("138", "sr_138_interval")
	self.sr_138_fury = self:GetSectSpecialValueFor("138", "sr_138_fury")
	self.sr_138_base_damage = self:GetSectSpecialValueFor("138", "sr_138_base_damage")
	self.sr_138_damage = self:GetSectSpecialValueFor("138", "sr_138_damage")
	self.sr_150_chance = self:GetSectSpecialValueFor("150", "sr_150_chance")
	self.sr_150_damage = self:GetSectSpecialValueFor("150", "sr_150_damage")
	self.r_155_fury = self:GetSectSpecialValueFor("155", "r_155_fury")
	self.r_155_fury_permanent = self:GetSectSpecialValueFor("155", "r_155_fury_permanent")
	self.sr_160_factor = self:GetSectSpecialValueFor("160", "sr_160_factor")
	self.n_176_chance = self:GetSectSpecialValueFor("176", "n_176_chance")
	self.n_176_chaos_count = self:GetSectSpecialValueFor("176", "n_176_chaos_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_fury_trigger", "chance")
	self.effect_value = self:GetCustomAbilityValueFor("sect_fury_effect", "value")
	self.effect_1 = self:GetSectSpecialValueFor("150", "effect_1")
	self.ability:GetAbilitySpecialValue()
end
function D.prototype.GetIceFuryPct(self)
	if IsServer() then
		local E = f(AbilityShop.pickList, "sect_fury") and 100 + self.ice_fury_pct or 100
		self:SetStackCount(E)
	end
	return self:GetStackCount() * 0.01
end
function D.prototype.OnIntervalThink(self)
	local r = self:GetParent()
	local F = r:GetEnemy()
	if self.n_129_fury > 0 then
		self.n_129_timer = self.n_129_timer + self.timerInterval
		if self.n_129_timer >= self.n_129_interval then
			self.n_129_timer = self.n_129_timer - self.n_129_interval
			self.ability:TriggerByName("129")
		end
	end
	if self.sr_138_damage > 0 then
		self.sr_138_timer = self.sr_138_timer + self.timerInterval
		if self.sr_138_timer >= self.sr_138_interval then
			self.sr_138_timer = self.sr_138_timer - self.sr_138_interval
			self.ability:TriggerByName("138")
		end
	end
end
function D.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function D.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE] = self.fury_count_extra
			* self:GetIceFuryPct(),
	}
end
function D.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT }
end
function D.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function D.prototype.EOM_GetModifierAvoidDamage(self, G)
	if not self.sr_160_enable then
		return 0
	end
	if bit.band(G.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	local r = self:GetParent()
	if G.damage >= r:GetHealth() then
		r:AddNewModifier(r, self:GetAbility(), "modifier_sect_fury_160", { duration = BUFF_VALUE.SuperNovaDuration })
		self.sr_160_enable = false
		return 1
	end
end
function D.prototype.OnBattleStartBefore(self, G)
	local H = self:GetParent()
	local I = H:GetEnemy()
	self.n_129_timer = 0
	self.n_133_timer = 0
	self.sr_138_timer = 0
	self.sr_160_enable = self.sr_160_factor > 0
	H:AddNewModifier(H, self:GetAbility(), "modifier_fury_permanent", {})
	if self.n_133_chance > 0 and IsValid(I) then
		I:AddNewModifier(H, self:GetAbility(), "modifier_sect_fury_133_debuff", {})
	end
	if self.n_187_chance > 0 then
		local J = false
		local K = PlayerData:getHero(self.parent:GetPlayerOwnerID())
		if K then
			local L = K:getAbilityData()
			local M = L.sect_ice
			local N = M and M.exp or 0
			local O = L.sect_fury
			local P = O and O.exp or 0
			if P > N then
				J = true
			end
		end
		if J then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_sect_187_ice", nil)
		else
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_sect_187_fury", nil)
		end
	end
	local Q = self.r_155_fury + GetFuryPreBattle(H)
	if Q > 0 then
		local R = H:FindAbilityByName("sect_fury")
		if not IsValid(R) then
			R = H:AddAbility_Engine("sect_fury")
		end
		local S = H:FindModifierByName("modifier_ice_custom")
		if IsValid(S) then
			local T = S:GetStackCount()
			if T <= Q then
				Q = Q - T
				S:Destroy()
			else
				S:DecrementStackCount(Q)
				Q = 0
			end
		end
		if Q > 0 then
			if Q >= self.r_155_fury and self.r_155_fury > 0 then
				Q = Q - self.r_155_fury
				AddFury(H, self.r_155_fury, "155", "AbilityUpgrade")
			end
			if Q > 0 then
				AddFury(H, Q, "sect_fury", "Ability")
			end
		end
	end
end
function D.prototype.OnBattleStart(self, G)
	if IsServer() then
		local H = self:GetParent()
		local I = H:GetEnemy()
		self:StartIntervalThink(self.timerInterval)
		if self.r_136_fury_stack > 0 then
			H:AddNewModifier(H, self:GetAbility(), "modifier_sect_fury_136", nil)
		end
		if self.sr_138_damage > 0 then
			local v = ParticleManager:CreateParticle(
				"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_immortal1.vpcf",
				PATTACH_CUSTOMORIGIN,
				self:GetParent()
			)
			ParticleManager:SetParticleControl(v, 0, self:GetParent():GetEnemy():GetAbsOrigin())
			ParticleManager:SetParticleControl(v, 1, Vector(450, 450, 1))
			self:GetParent():EmitSound("Hero_Invoker.SunStrike.Charge.Apex")
		end
	end
end
function D.prototype.OnThink(self, U)
	local r = self:GetParent()
	local q = r:GetEnemy()
	local x = self:GetAbility()
	if not IsInjurable(q) then
		self:StartThink(-1, U)
		return
	end
end
function D.prototype.OnBattleEnd(self, G)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StartThink(-1, "sr_150_interval")
	end
end
function D.prototype.OnCustomTakeDamage(self, G)
	if IsServer() then
		if G and IsValid(G.attacker) then
			if self.r_135_chance > 0 and self:PRD(self.r_135_chance, "r_135_chance") then
				self.ability:TriggerByName("135", G.attacker)
			end
		end
	end
end
function D.prototype.OnFuryGained(self, G)
	if G then
		self:customAbilityTrigger()
		local r = self:GetParent()
		local F = r:GetEnemy()
		if self.sr_150_chance > 0 and self:PRD(self.sr_150_chance, "sr_150_chance") then
			self.ability:TriggerByName("150")
		end
		if self.n_128_chance > 0 and self:PRD(self.n_128_chance, "n_128_chance") then
			self.ability:TriggerByName("128")
		end
		if self.n_176_chance > 0 and self:PRD(self.n_176_chance, "n_176_chance") then
			self.ability:TriggerByName("176")
		end
	end
end
function D.prototype.EOM_GetModifierFuryPermanent(self)
	return self.r_155_fury_permanent
end
function D.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_fury" then
		return
	end
	if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
		local V = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
		if V ~= nil then
			V:customAbilityEffect()
		end
	end
end
function D.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	local W = AddFury
	local X = self:GetParent()
	local Y = self.effect_value
	local Z = self:GetAbility()
	W(X, Y, Z and Z:GetAbilityName() or "", "Sect")
end
D = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	D
)
h.modifier_sect_fury = D
h.modifier_sect_fury_133_debuff = c()
local _ = h.modifier_sect_fury_133_debuff
_.name = "modifier_sect_fury_133_debuff"
d(_, m)
function _.prototype.GetAbilitySpecialValue(self)
	self.n_133_chance = self:GetSectSpecialValueFor("133", "n_133_chance")
end
function _.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function _.prototype.OnBattleEnd(self)
	self:Destroy()
end
function _.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_FURY_PERCENTAGE }
end
function _.prototype.EOM_GetModifierIgnoreFuryPercent(self)
	return self.n_133_chance
end
_ = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	_
)
h.modifier_sect_fury_133_debuff = _
h.modifier_sect_fury_136 = c()
local a0 = h.modifier_sect_fury_136
a0.name = "modifier_sect_fury_136"
d(a0, m)
function a0.prototype.GetAbilitySpecialValue(self)
	self.r_136_fury_stack = self:GetSectSpecialValueFor("136", "r_136_fury_stack")
	self.r_136_tick = self:GetSectSpecialValueFor("136", "r_136_tick")
end
function a0.prototype.OnCreated(self, G)
	if IsServer() then
		EmitSoundOn("Hero_EmberSpirit.FlameGuard.Cast", self:GetCaster())
		self:StartIntervalThink(self.r_136_tick)
		self:StartThink(0.1)
	else
		local v = ParticleManager:CreateParticle(
			"particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard.vpcf",
			PATTACH_WORLDORIGIN,
			self:GetCaster()
		)
		local a1 = self:GetCaster():GetAbsOrigin()
		ParticleManager:SetParticleControl(v, 0, a1)
		ParticleManager:SetParticleControl(v, 1, a1)
		ParticleManager:SetParticleControl(v, 2, Vector(350, 1, 1))
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function a0.prototype.OnIntervalThink(self)
	if IsServer() then
		AddFury(self:GetParent(), self.r_136_fury_stack, "136", "AbilityUpgrade")
	end
end
function a0.prototype.OnThink(self, U)
	if IsServer() then
		self:SetStackCount(
			math.min(BUFF_VALUE.BurningBodyMax, math.floor(GetFury(self:GetParent()) / BUFF_VALUE.BurningBodyThreshold))
		)
	end
end
function a0.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function a0.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_LOSS] = { self:GetParent() },
	}
end
function a0.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, G)
	return -BUFF_VALUE.BurningBodyMagicReduce * self:GetStackCount()
end
function a0.prototype.OnBattleEnd(self, G)
	self:Destroy()
end
function a0.prototype.OnFuryLoss(self, G)
	local a2 = G.iCount * BUFF_VALUE.BurningBodyConvert * 0.01
	if a2 > 0 then
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_sect_fury_136_fury",
			{ duration = BUFF_VALUE.BurningBodyDuration, iStackCount = a2 }
		)
	end
end
a0 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a0
)
h.modifier_sect_fury_136 = a0
h.modifier_sect_fury_136_fury = c()
local a3 = h.modifier_sect_fury_136_fury
a3.name = "modifier_sect_fury_136_fury"
d(a3, m)
function a3.prototype.OnCreated(self, G)
	if IsServer() then
		local a4 = G and G.iStackCount or 0
		if a4 > 0 then
			self:IncrementStackCount(a4)
		end
	end
end
function a3.prototype.OnRefresh(self, G)
	if IsServer() then
		local a4 = G and G.iStackCount or 0
		if a4 > 0 then
			self:IncrementStackCount(a4)
		end
	end
end
function a3.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT }
end
function a3.prototype.EOM_GetModifierFuryPermanent(self, G)
	return self:GetStackCount()
end
a3 = e(
	{
		n(
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
	a3
)
h.modifier_sect_fury_136_fury = a3
h.modifier_sect_fury_160 = c()
local a5 = h.modifier_sect_fury_160
a5.name = "modifier_sect_fury_160"
d(a5, m)
function a5.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.flag = true
end
function a5.prototype.OnCreated(self, G)
	if IsServer() then
		local r = self:GetParent()
		EmitSoundOnLocationWithCaster(r:GetAbsOrigin(), "Hero_Phoenix.SuperNova.Begin", r)
		r:EmitSound("Hero_Phoenix.SuperNova.Cast")
		self.modelScale = r:GetModelScale()
		r:SetModelScale(0.01)
		local a6 = BUFF_VALUE.SuperNovaHealth - r:GetMaxHealth()
		if a6 > 0 then
			r:AddNewModifier(r, self:GetAbility(), "modifier_sect_fury_160_temphealh", { bonus_value = a6 })
		end
		r:SetHealth(BUFF_VALUE.SuperNovaHealth)
		CombatLog:recordSectAbilityCast(r, "160")
		self.damage_count = math.floor(BUFF_VALUE.SuperNovaDuration)
		self:StartIntervalThink(1)
		local a1 = r:GetAbsOrigin()
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{ origin = a1, model = "models/heroes/phoenix/phoenix_egg.vmdl", DefaultAnim = "ACT_DOTA_IDLE", use_animgraph = "1" }
		)
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.dummy
		)
		ParticleManager:SetParticleControlEnt(
			v,
			1,
			self.dummy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.dummy:GetAbsOrigin(),
			true
		)
		self:AddParticle(v, false, false, -1, false, false)
	end
end
function a5.prototype.OnDestroy(self)
	if IsServer() then
		self:OnIntervalThink()
		local r = self:GetParent()
		r:RemoveModifierByName("modifier_sect_fury_160_temphealh")
		r:StopSound("Hero_Phoenix.SuperNova.Cast")
		r:SetModelScale(r:GetDefaultModelScale())
		if IsValid(self.dummy) then
			if self.flag then
				local v = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf",
					PATTACH_CUSTOMORIGIN,
					self.dummy
				)
				ParticleManager:SetParticleControlEnt(
					v,
					0,
					self.dummy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self.dummy:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(v, 1, Vector(500, 500, 500))
				ParticleManager:ReleaseParticleIndex(v)
			else
				local v = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self.dummy
				)
				ParticleManager:SetParticleControlEnt(
					v,
					1,
					self.dummy,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self.dummy:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(v)
			end
			self.dummy:RemoveSelf()
		end
		if self.flag then
			EmitSoundOnLocationWithCaster(r:GetAbsOrigin(), "Hero_Phoenix.SuperNova.Explode", r)
			AddFury(r, BUFF_VALUE.SuperNovaFuryCount, "160", "AbilityUpgrade")
			r:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 3)
		else
			EmitSoundOnLocationWithCaster(r:GetAbsOrigin(), "Hero_Phoenix.SuperNova.Death", r)
		end
	end
end
function a5.prototype.OnIntervalThink(self)
	if not self.flag then
		return
	end
	if self.damage_count <= 0 then
		return
	end
	local r = self:GetParent()
	local q = r:GetEnemy()
	if not IsInjurable(r, q) then
		self.flag = false
		self:Destroy()
		return
	end
	self.damage_count = self.damage_count - 1
	local B = GetFury(r) * BUFF_VALUE.SuperNovaDPS * 0.01
	if B > 0 then
		DamageSystem:dealDamage({
			attacker = r,
			target = q,
			ability = self:GetAbility(),
			ability_upgrade = "160",
			damage = B,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
	end
end
function a5.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function a5.prototype.OnBattleEnd(self, G)
	self.flag = false
end
function a5.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function a5.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -BUFF_VALUE.SuperNovaDamageReduce }
end
function a5.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function a5.prototype.EOM_GetModifierAvoidDamage(self, G)
	if not self.flag then
		return 0
	end
	if bit.band(G.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	if G.damage >= self:GetParent():GetHealth() then
		self.flag = false
		self:Destroy()
	end
	return 0
end
a5 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a5
)
h.modifier_sect_fury_160 = a5
h.modifier_sect_fury_160_temphealh = c()
local a7 = h.modifier_sect_fury_160_temphealh
a7.name = "modifier_sect_fury_160_temphealh"
d(a7, m)
function a7.prototype.OnCreated(self, G)
	if IsServer() then
		self.value = G and G.bonus_value or 0
	end
end
function a7.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function a7.prototype.EOM_GetModifierHealthBonus(self, G)
	return self.value
end
a7 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a7
)
h.modifier_sect_fury_160_temphealh = a7
h.modifier_sect_187_fury = c()
local a8 = h.modifier_sect_187_fury
a8.name = "modifier_sect_187_fury"
d(a8, m)
function a8.prototype.GetAbilitySpecialValue(self)
	self.n_187_count = self:GetSectSpecialValueFor("187", "n_187_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
end
function a8.prototype.OnCreated(self, G)
	if IsServer() then
		self.enemy = self.parent:GetEnemy()
	end
end
function a8.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self.parent } }
end
function a8.prototype.OnFuryGained(self, G)
	if self:PRD(self.n_187_chance) then
		AddIce(self.parent, self.enemy, self.n_187_count, "187", "AbilityUpgrade")
	end
end
a8 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a8
)
h.modifier_sect_187_fury = a8
h.modifier_sect_187_ice = c()
local a9 = h.modifier_sect_187_ice
a9.name = "modifier_sect_187_ice"
d(a9, m)
function a9.prototype.GetAbilitySpecialValue(self)
	self.n_187_count = self:GetSectSpecialValueFor("187", "n_187_count")
	self.n_187_chance = self:GetSectSpecialValueFor("187", "n_187_chance")
end
function a9.prototype.OnCreated(self, G)
	if IsServer() then
		self.enemy = self.parent:GetEnemy()
	end
end
function a9.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self.parent } }
end
function a9.prototype.OnIceGained(self, G)
	if self:PRD(self.n_187_chance) then
		AddFury(self.parent, self.n_187_count, "187", "AbilityUpgrade")
	end
end
a9 = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	a9
)
h.modifier_sect_187_ice = a9
return h