--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/sect/sect_evade"
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
		["20"] = 31,
		["21"] = 4,
		["22"] = 36,
		["23"] = 37,
		["24"] = 38,
		["25"] = 39,
		["26"] = 40,
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
		["50"] = 36,
		["51"] = 65,
		["52"] = 66,
		["53"] = 65,
		["54"] = 68,
		["55"] = 68,
		["56"] = 68,
		["58"] = 69,
		["59"] = 70,
		["63"] = 71,
		["64"] = 72,
		["66"] = 73,
		["67"] = 73,
		["68"] = 73,
		["69"] = 73,
		["70"] = 73,
		["71"] = 73,
		["72"] = 73,
		["75"] = 75,
		["77"] = 76,
		["78"] = 76,
		["79"] = 76,
		["80"] = 76,
		["81"] = 76,
		["82"] = 76,
		["83"] = 76,
		["86"] = 78,
		["88"] = 79,
		["91"] = 81,
		["93"] = 82,
		["96"] = 84,
		["98"] = 85,
		["101"] = 87,
		["103"] = 88,
		["106"] = 90,
		["108"] = 91,
		["109"] = 91,
		["110"] = 91,
		["111"] = 91,
		["112"] = 91,
		["113"] = 91,
		["114"] = 91,
		["117"] = 93,
		["119"] = 94,
		["123"] = 68,
		["124"] = 5,
		["125"] = 4,
		["126"] = 5,
		["128"] = 5,
		["129"] = 101,
		["130"] = 109,
		["131"] = 101,
		["132"] = 109,
		["134"] = 109,
		["135"] = 141,
		["136"] = 146,
		["137"] = 101,
		["138"] = 147,
		["139"] = 148,
		["140"] = 149,
		["141"] = 151,
		["142"] = 152,
		["143"] = 153,
		["144"] = 154,
		["145"] = 155,
		["146"] = 156,
		["147"] = 157,
		["148"] = 158,
		["149"] = 159,
		["150"] = 160,
		["151"] = 161,
		["152"] = 162,
		["153"] = 163,
		["154"] = 164,
		["155"] = 165,
		["156"] = 166,
		["157"] = 167,
		["158"] = 170,
		["159"] = 171,
		["160"] = 173,
		["161"] = 174,
		["162"] = 175,
		["163"] = 176,
		["164"] = 177,
		["165"] = 178,
		["166"] = 179,
		["167"] = 181,
		["168"] = 182,
		["169"] = 147,
		["170"] = 184,
		["171"] = 186,
		["172"] = 187,
		["173"] = 188,
		["175"] = 184,
		["176"] = 191,
		["177"] = 192,
		["178"] = 193,
		["179"] = 193,
		["180"] = 193,
		["181"] = 192,
		["182"] = 192,
		["183"] = 192,
		["184"] = 196,
		["185"] = 196,
		["186"] = 196,
		["187"] = 192,
		["188"] = 192,
		["189"] = 191,
		["190"] = 199,
		["191"] = 200,
		["192"] = 200,
		["193"] = 200,
		["194"] = 200,
		["195"] = 200,
		["196"] = 200,
		["197"] = 200,
		["198"] = 200,
		["199"] = 199,
		["200"] = 234,
		["201"] = 235,
		["202"] = 236,
		["204"] = 234,
		["205"] = 240,
		["206"] = 241,
		["207"] = 242,
		["208"] = 248,
		["209"] = 250,
		["211"] = 253,
		["212"] = 255,
		["214"] = 258,
		["215"] = 259,
		["217"] = 262,
		["218"] = 264,
		["220"] = 267,
		["221"] = 269,
		["223"] = 272,
		["224"] = 274,
		["226"] = 277,
		["227"] = 279,
		["229"] = 282,
		["230"] = 285,
		["232"] = 287,
		["233"] = 289,
		["234"] = 290,
		["235"] = 291,
		["236"] = 294,
		["237"] = 295,
		["238"] = 295,
		["239"] = 295,
		["240"] = 295,
		["241"] = 295,
		["242"] = 296,
		["243"] = 296,
		["244"] = 296,
		["245"] = 296,
		["246"] = 296,
		["247"] = 297,
		["248"] = 297,
		["249"] = 297,
		["250"] = 297,
		["251"] = 297,
		["252"] = 298,
		["253"] = 298,
		["254"] = 298,
		["255"] = 298,
		["256"] = 298,
		["257"] = 299,
		["258"] = 300,
		["259"] = 300,
		["260"] = 300,
		["261"] = 300,
		["262"] = 300,
		["263"] = 305,
		["264"] = 306,
		["265"] = 307,
		["266"] = 307,
		["267"] = 307,
		["268"] = 307,
		["269"] = 307,
		["270"] = 307,
		["271"] = 307,
		["272"] = 307,
		["273"] = 308,
		["274"] = 308,
		["275"] = 308,
		["276"] = 308,
		["277"] = 308,
		["278"] = 308,
		["279"] = 308,
		["281"] = 300,
		["282"] = 300,
		["284"] = 314,
		["285"] = 315,
		["286"] = 316,
		["287"] = 317,
		["288"] = 318,
		["289"] = 319,
		["290"] = 319,
		["291"] = 319,
		["292"] = 319,
		["293"] = 319,
		["294"] = 320,
		["295"] = 320,
		["296"] = 320,
		["297"] = 320,
		["298"] = 320,
		["299"] = 321,
		["300"] = 321,
		["301"] = 321,
		["302"] = 321,
		["303"] = 321,
		["304"] = 326,
		["305"] = 327,
		["306"] = 328,
		["307"] = 328,
		["308"] = 328,
		["309"] = 328,
		["310"] = 328,
		["311"] = 328,
		["312"] = 328,
		["313"] = 328,
		["314"] = 329,
		["315"] = 329,
		["316"] = 329,
		["317"] = 329,
		["318"] = 329,
		["319"] = 329,
		["320"] = 329,
		["321"] = 321,
		["322"] = 321,
		["326"] = 341,
		["327"] = 240,
		["328"] = 343,
		["329"] = 344,
		["330"] = 343,
		["331"] = 346,
		["332"] = 348,
		["333"] = 348,
		["334"] = 348,
		["335"] = 348,
		["336"] = 346,
		["337"] = 359,
		["338"] = 360,
		["339"] = 359,
		["340"] = 363,
		["341"] = 364,
		["342"] = 365,
		["344"] = 363,
		["345"] = 368,
		["346"] = 369,
		["347"] = 371,
		["348"] = 374,
		["349"] = 375,
		["350"] = 375,
		["351"] = 375,
		["352"] = 375,
		["353"] = 375,
		["354"] = 375,
		["356"] = 378,
		["357"] = 379,
		["358"] = 379,
		["359"] = 379,
		["360"] = 379,
		["361"] = 379,
		["362"] = 379,
		["363"] = 382,
		["364"] = 384,
		["365"] = 384,
		["366"] = 384,
		["367"] = 384,
		["368"] = 384,
		["369"] = 384,
		["372"] = 388,
		["373"] = 389,
		["374"] = 389,
		["375"] = 389,
		["376"] = 389,
		["377"] = 389,
		["378"] = 389,
		["380"] = 368,
		["381"] = 394,
		["382"] = 395,
		["385"] = 398,
		["388"] = 401,
		["389"] = 402,
		["391"] = 402,
		["394"] = 394,
		["395"] = 406,
		["396"] = 407,
		["397"] = 408,
		["398"] = 408,
		["399"] = 408,
		["400"] = 408,
		["401"] = 408,
		["402"] = 408,
		["403"] = 406,
		["404"] = 410,
		["405"] = 411,
		["408"] = 412,
		["411"] = 413,
		["414"] = 415,
		["415"] = 416,
		["418"] = 417,
		["419"] = 417,
		["420"] = 417,
		["421"] = 417,
		["422"] = 417,
		["423"] = 419,
		["424"] = 420,
		["425"] = 421,
		["426"] = 422,
		["427"] = 422,
		["428"] = 422,
		["429"] = 422,
		["430"] = 422,
		["431"] = 422,
		["432"] = 425,
		["434"] = 410,
		["435"] = 109,
		["436"] = 101,
		["437"] = 101,
		["438"] = 101,
		["439"] = 101,
		["440"] = 101,
		["441"] = 101,
		["442"] = 101,
		["443"] = 101,
		["444"] = 109,
		["446"] = 109,
		["447"] = 429,
		["448"] = 429,
		["449"] = 429,
		["450"] = 429,
		["451"] = 429,
		["452"] = 429,
		["453"] = 429,
		["454"] = 429,
		["455"] = 429,
		["457"] = 442,
		["458"] = 450,
		["459"] = 442,
		["460"] = 450,
		["462"] = 450,
		["463"] = 451,
		["464"] = 442,
		["465"] = 454,
		["466"] = 455,
		["467"] = 456,
		["468"] = 457,
		["470"] = 460,
		["471"] = 461,
		["472"] = 462,
		["473"] = 462,
		["474"] = 462,
		["475"] = 462,
		["476"] = 462,
		["477"] = 462,
		["478"] = 462,
		["479"] = 462,
		["480"] = 462,
		["481"] = 462,
		["482"] = 462,
		["484"] = 454,
		["485"] = 472,
		["486"] = 473,
		["487"] = 474,
		["488"] = 475,
		["489"] = 476,
		["490"] = 477,
		["492"] = 472,
		["493"] = 480,
		["494"] = 481,
		["495"] = 480,
		["496"] = 450,
		["497"] = 442,
		["498"] = 442,
		["499"] = 442,
		["500"] = 442,
		["501"] = 442,
		["502"] = 442,
		["503"] = 442,
		["504"] = 450,
		["506"] = 450,
		["508"] = 488,
		["509"] = 496,
		["510"] = 488,
		["511"] = 496,
		["512"] = 498,
		["513"] = 499,
		["514"] = 498,
		["515"] = 501,
		["516"] = 502,
		["517"] = 501,
		["518"] = 506,
		["519"] = 507,
		["520"] = 506,
		["521"] = 496,
		["522"] = 488,
		["523"] = 488,
		["524"] = 488,
		["525"] = 488,
		["526"] = 488,
		["527"] = 488,
		["528"] = 488,
		["529"] = 496,
		["531"] = 496,
		["533"] = 513,
		["534"] = 521,
		["535"] = 513,
		["536"] = 521,
		["537"] = 524,
		["538"] = 525,
		["539"] = 526,
		["540"] = 524,
		["541"] = 528,
		["542"] = 529,
		["543"] = 530,
		["545"] = 528,
		["546"] = 533,
		["547"] = 534,
		["548"] = 535,
		["550"] = 533,
		["551"] = 538,
		["552"] = 539,
		["553"] = 538,
		["554"] = 543,
		["555"] = 544,
		["556"] = 544,
		["557"] = 544,
		["558"] = 544,
		["559"] = 543,
		["560"] = 521,
		["561"] = 513,
		["562"] = 513,
		["563"] = 513,
		["564"] = 513,
		["565"] = 513,
		["566"] = 513,
		["567"] = 513,
		["568"] = 513,
		["569"] = 521,
		["571"] = 521,
		["573"] = 599,
		["574"] = 607,
		["575"] = 599,
		["576"] = 607,
		["577"] = 609,
		["578"] = 610,
		["579"] = 609,
		["580"] = 612,
		["581"] = 613,
		["582"] = 614,
		["583"] = 615,
		["585"] = 617,
		["586"] = 618,
		["587"] = 618,
		["588"] = 618,
		["589"] = 618,
		["590"] = 618,
		["591"] = 618,
		["592"] = 618,
		["593"] = 618,
		["594"] = 618,
		["595"] = 619,
		["596"] = 619,
		["597"] = 619,
		["598"] = 619,
		["599"] = 619,
		["600"] = 619,
		["601"] = 619,
		["602"] = 619,
		["604"] = 612,
		["605"] = 622,
		["606"] = 623,
		["607"] = 622,
		["608"] = 607,
		["609"] = 599,
		["610"] = 599,
		["611"] = 599,
		["612"] = 599,
		["613"] = 599,
		["614"] = 599,
		["615"] = 599,
		["616"] = 607,
		["618"] = 607,
		["620"] = 630,
		["621"] = 638,
		["622"] = 630,
		["623"] = 638,
		["624"] = 642,
		["625"] = 643,
		["626"] = 644,
		["627"] = 642,
		["628"] = 646,
		["629"] = 647,
		["630"] = 648,
		["631"] = 649,
		["632"] = 650,
		["633"] = 651,
		["634"] = 651,
		["636"] = 646,
		["637"] = 654,
		["638"] = 655,
		["639"] = 656,
		["640"] = 657,
		["641"] = 657,
		["643"] = 654,
		["644"] = 660,
		["645"] = 661,
		["646"] = 662,
		["647"] = 663,
		["648"] = 664,
		["649"] = 665,
		["652"] = 660,
		["653"] = 669,
		["654"] = 670,
		["655"] = 669,
		["656"] = 674,
		["657"] = 675,
		["658"] = 675,
		["659"] = 675,
		["660"] = 675,
		["661"] = 674,
		["662"] = 638,
		["663"] = 630,
		["664"] = 630,
		["665"] = 630,
		["666"] = 630,
		["667"] = 630,
		["668"] = 630,
		["669"] = 630,
		["670"] = 638,
		["672"] = 638,
		["674"] = 680,
		["675"] = 687,
		["676"] = 680,
		["677"] = 687,
		["678"] = 689,
		["679"] = 690,
		["680"] = 689,
		["681"] = 692,
		["682"] = 693,
		["683"] = 692,
		["684"] = 687,
		["685"] = 680,
		["686"] = 680,
		["687"] = 680,
		["688"] = 680,
		["689"] = 680,
		["690"] = 680,
		["691"] = 680,
		["692"] = 687,
		["694"] = 687,
		["696"] = 699,
		["697"] = 706,
		["698"] = 699,
		["699"] = 706,
		["700"] = 709,
		["701"] = 711,
		["702"] = 712,
		["703"] = 709,
		["704"] = 714,
		["705"] = 715,
		["706"] = 716,
		["707"] = 716,
		["708"] = 715,
		["709"] = 714,
		["710"] = 719,
		["711"] = 720,
		["712"] = 721,
		["713"] = 722,
		["715"] = 719,
		["716"] = 725,
		["717"] = 726,
		["718"] = 725,
		["719"] = 730,
		["720"] = 731,
		["721"] = 730,
		["722"] = 706,
		["723"] = 699,
		["724"] = 699,
		["725"] = 699,
		["726"] = 699,
		["727"] = 699,
		["728"] = 699,
		["729"] = 699,
		["730"] = 706,
		["732"] = 706,
		["734"] = 735,
		["735"] = 742,
		["736"] = 735,
		["737"] = 742,
		["738"] = 747,
		["739"] = 748,
		["740"] = 749,
		["741"] = 750,
		["742"] = 751,
		["743"] = 747,
		["744"] = 753,
		["745"] = 754,
		["746"] = 755,
		["747"] = 756,
		["748"] = 757,
		["749"] = 757,
		["750"] = 757,
		["751"] = 757,
		["752"] = 757,
		["753"] = 757,
		["754"] = 757,
		["755"] = 757,
		["756"] = 757,
		["757"] = 758,
		["758"] = 758,
		["759"] = 758,
		["760"] = 758,
		["761"] = 758,
		["762"] = 758,
		["763"] = 758,
		["764"] = 758,
		["766"] = 753,
		["767"] = 767,
		["768"] = 768,
		["769"] = 767,
		["770"] = 772,
		["771"] = 773,
		["772"] = 774,
		["773"] = 774,
		["774"] = 773,
		["775"] = 772,
		["776"] = 777,
		["777"] = 778,
		["780"] = 781,
		["783"] = 784,
		["786"] = 787,
		["787"] = 788,
		["788"] = 789,
		["790"] = 791,
		["791"] = 792,
		["792"] = 793,
		["793"] = 793,
		["794"] = 793,
		["795"] = 793,
		["796"] = 793,
		["797"] = 793,
		["798"] = 793,
		["799"] = 793,
		["801"] = 777,
		["802"] = 742,
		["803"] = 735,
		["804"] = 735,
		["805"] = 735,
		["806"] = 735,
		["807"] = 735,
		["808"] = 735,
		["809"] = 735,
		["810"] = 742,
		["812"] = 742,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.sect_evade = c()
local n = g.sect_evade
n.name = "sect_evade"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.sr_151_enable = false
end
function n.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce_pct = self:GetSpecialValueFor("damage_reduce_pct")
	self.evasion = self:GetSpecialValueFor("evasion")
	self.n_17_evade = self:GetSectSpecialValueFor("17", "n_17_evade")
	self.n_18_poison = self:GetSectSpecialValueFor("18", "n_18_poison")
	self.n_19_ice = self:GetSectSpecialValueFor("19", "n_19_ice")
	self.n_20_mana = self:GetSectSpecialValueFor("20", "n_20_mana")
	self.n_21_regen = self:GetSectSpecialValueFor("21", "n_21_regen")
	self.n_22_shield = self:GetSectSpecialValueFor("22", "n_22_shield")
	self.n_23_injury = self:GetSectSpecialValueFor("23", "n_23_injury")
	self.n_25_evade_threshold = self:GetSectSpecialValueFor("25", "n_25_evade_threshold")
	self.n_25_crit_damage = self:GetSectSpecialValueFor("25", "n_25_crit_damage")
	self.n_26_duration = self:GetSectSpecialValueFor("26", "n_26_duration")
	self.n_26_evade = self:GetSectSpecialValueFor("26", "n_26_evade")
	self.n_26_max_evade = self:GetSectSpecialValueFor("26", "n_26_max_evade")
	self.r_28_chance = self:GetSectSpecialValueFor("28", "r_28_chance")
	self.r_29_duration = self:GetSectSpecialValueFor("29", "r_29_duration")
	self.r_30_damage = self:GetSectSpecialValueFor("30", "r_30_damage")
	self.sr_31_chance = self:GetSectSpecialValueFor("31", "sr_31_chance")
	self.n_123_fury = self:GetSectSpecialValueFor("123", "n_123_fury")
	self.sr_151_base_chance = self:GetSectSpecialValueFor("151", "sr_151_base_chance")
	self.sr_151_bonus_chance = self:GetSectSpecialValueFor("151", "sr_151_bonus_chance")
	self.sr_151_duration = self:GetSectSpecialValueFor("151", "sr_151_duration")
	self.sr_151_cooldown = self:GetSectSpecialValueFor("151", "sr_151_cooldown")
	self.sr_184_duration = self:GetSectSpecialValueFor("184", "sr_184_duration")
	self.sr_184_effect_1 = self:GetSectSpecialValueFor("184", "evade_bonus")
	self.sr_184_base = self:GetSectSpecialValueFor("184", "sr_184_base")
	self.sr_189_damage_pct = self:GetSectSpecialValueFor("189", "sr_189_damage_pct")
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_sect_evade"
end
function n.prototype.TriggerByName(self, o, p, q)
	if p == nil then
		p = self:GetCaster():GetEnemy()
	end
	local r = self:GetCaster()
	if not IsInjurable(p, r) then
		return
	end
	repeat
		local s = o
		local t = s == "18"
		if t then
			AddPoison(r, p, self.n_18_poison, "18", "AbilityUpgrade")
			break
		end
		t = t or s == "19"
		if t then
			AddIce(r, p, self.n_19_ice, "19", "AbilityUpgrade")
			break
		end
		t = t or s == "123"
		if t then
			AddFury(r, self.n_123_fury, "123", "AbilityUpgrade")
			break
		end
		t = t or s == "20"
		if t then
			Restore(r, self.n_20_mana)
			break
		end
		t = t or s == "21"
		if t then
			Heal(r, self.n_21_regen, "21", "AbilityUpgrade")
			break
		end
		t = t or s == "22"
		if t then
			AddShield(r, self.n_22_shield, "22", "AbilityUpgrade")
			break
		end
		t = t or s == "23"
		if t then
			AddInjury(r, p, self.n_23_injury, "23", "AbilityUpgrade")
			break
		end
		t = t or s == "29"
		if t then
			r:AddNewModifier(r, self, "modifier_sect_evade_29_buff", { duration = self.r_29_duration })
			break
		end
	until true
end
n = e({ j(nil) }, n)
g.sect_evade = n
g.modifier_sect_evade = c()
local u = g.modifier_sect_evade
u.name = "modifier_sect_evade"
d(u, l)
function u.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.sr_151_enable = false
	self.hookList = {}
end
function u.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce_pct = self:GetAbilitySpecialValueFor("damage_reduce_pct")
	self.evasion = self:GetAbilitySpecialValueFor("evasion")
	self.n_17_evade = self:GetSectSpecialValueFor("17", "n_17_evade")
	self.n_18_poison = self:GetSectSpecialValueFor("18", "n_18_poison")
	self.n_19_ice = self:GetSectSpecialValueFor("19", "n_19_ice")
	self.n_20_mana = self:GetSectSpecialValueFor("20", "n_20_mana")
	self.n_21_regen = self:GetSectSpecialValueFor("21", "n_21_regen")
	self.n_22_shield = self:GetSectSpecialValueFor("22", "n_22_shield")
	self.n_23_injury = self:GetSectSpecialValueFor("23", "n_23_injury")
	self.n_25_evade_threshold = self:GetSectSpecialValueFor("25", "n_25_evade_threshold")
	self.n_25_crit_damage = self:GetSectSpecialValueFor("25", "n_25_crit_damage")
	self.n_26_duration = self:GetSectSpecialValueFor("26", "n_26_duration")
	self.n_26_evade = self:GetSectSpecialValueFor("26", "n_26_evade")
	self.n_26_max_evade = self:GetSectSpecialValueFor("26", "n_26_max_evade")
	self.r_28_chance = self:GetSectSpecialValueFor("28", "r_28_chance")
	self.r_29_duration = self:GetSectSpecialValueFor("29", "r_29_duration")
	self.r_30_damage = self:GetSectSpecialValueFor("30", "r_30_damage")
	self.sr_31_chance = self:GetSectSpecialValueFor("31", "sr_31_chance")
	self.n_123_fury = self:GetSectSpecialValueFor("123", "n_123_fury")
	self.trigger_chance = self:GetCustomAbilityValueFor("sect_evade_trigger", "chance")
	self.effect_duration = self:GetCustomAbilityValueFor("sect_evade_effect", "duration")
	self.sr_151_base_chance = self:GetSectSpecialValueFor("151", "sr_151_base_chance")
	self.sr_151_bonus_chance = self:GetSectSpecialValueFor("151", "sr_151_bonus_chance")
	self.sr_151_duration = self:GetSectSpecialValueFor("151", "sr_151_duration")
	self.sr_151_cooldown = self:GetSectSpecialValueFor("151", "sr_151_cooldown")
	self.sr_184_duration = self:GetSectSpecialValueFor("184", "sr_184_duration")
	self.sr_184_effect_1 = self:GetSectSpecialValueFor("184", "evade_bonus")
	self.sr_184_base = self:GetSectSpecialValueFor("184", "sr_184_base")
	self.sr_189_damage_pct = self:GetSectSpecialValueFor("189", "sr_189_damage_pct")
	self.ability:GetAbilitySpecialValue()
end
function u.prototype.OnThink(self, v)
	if v == "sr_151" then
		self:StartThink(-1, "sr_151")
		self.sr_151_enable = true
	end
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function u.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BASE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MAGICAL_EVASION_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT,
	}
end
function u.prototype.OnEvasion(self, w)
	if w.target == self.parent then
		self:TriggerEvadeEffect(w)
	end
end
function u.prototype.TriggerEvadeEffect(self, w)
	local x = self:GetParent()
	local y = w.attacker
	if self.n_18_poison > 0 then
		self.ability:TriggerByName("18", y)
	end
	if self.n_19_ice > 0 then
		self.ability:TriggerByName("19", y)
	end
	if self.n_123_fury > 0 then
		self.ability:TriggerByName("123")
	end
	if self.n_20_mana > 0 then
		self.ability:TriggerByName("20")
	end
	if self.n_21_regen > 0 then
		self.ability:TriggerByName("21")
	end
	if self.n_22_shield > 0 then
		self.ability:TriggerByName("22")
	end
	if self.n_23_injury > 0 then
		self.ability:TriggerByName("23", y)
	end
	if self.r_29_duration > 0 then
		self.ability:TriggerByName("29")
	end
	if w then
		if
			self.r_30_damage > 0
			and bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION
		then
			local z = w.evade_damage or 0
			z = z * self.r_30_damage * 0.01
			local A = ParticleManager:CreateParticle("particles/sect/sect_evade_30.vpcf", PATTACH_CUSTOMORIGIN, x)
			ParticleManager:SetParticleControl(A, 0, x:GetAbsOrigin())
			ParticleManager:SetParticleControl(A, 1, y:GetAbsOrigin())
			ParticleManager:SetParticleControl(A, 2, x:GetAbsOrigin())
			ParticleManager:SetParticleControl(A, 3, x:GetAbsOrigin())
			x:EmitSound("Hero_Riki.Blink_Strike")
			Projectile:CreateTrackingProjectile({
				hCaster = x,
				vSpawnOrigin = x:GetAbsOrigin(),
				hTarget = y,
				iMoveSpeed = PROJECTILE_SPEED_FAST,
				OnProjectileHit = function(y, B, C)
					if IsValid(self) and IsInjurable(y) then
						x:DealDamage(
							y,
							self:GetAbility(),
							z,
							EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
							DamageFlags.DAMAGE_FLAG_REFLECTION
								+ DamageFlags.DAMAGE_FLAG_HPLOSS
								+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
							"30"
						)
						SendOverheadEventMessage(
							nil,
							OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
							y,
							self.r_30_damage,
							x:GetPlayerOwner()
						)
					end
				end,
			})
		end
		if
			self.sr_31_chance > 0
			and bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION
		then
			local D = Round(w.damage + (w.evade_damage or 0))
			if D > 0 and self:PRD(self.sr_31_chance, "sr_31_chance") then
				ParticleManager:CreateParticle("particles/sect/evade_legend_blademail.vpcf", PATTACH_ABSORIGIN, x)
				local A = ParticleManager:CreateParticle(
					"particles/econ/items/spectre/spectre_arcana/spectre_arcana_desolate.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(A, 0, y:GetAbsOrigin())
				ParticleManager:SetParticleControlForward(A, 0, x:GetForwardVector())
				Projectile:CreateTrackingProjectile({
					hCaster = x,
					vSpawnOrigin = x:GetAbsOrigin(),
					hTarget = y,
					iMoveSpeed = PROJECTILE_SPEED_FAST,
					OnProjectileHit = function(y, B, C)
						x:EmitSound("DOTA_Item.BladeMail.Damage")
						x:DealDamage(
							y,
							self:GetAbility(),
							D,
							EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
							DamageFlags.DAMAGE_FLAG_REFLECTION + DamageFlags.DAMAGE_FLAG_NO_EVASION,
							"31"
						)
						SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, y, D, x:GetPlayerOwner())
					end,
				})
			end
		end
	end
	self:customAbilityTrigger()
end
function u.prototype.EOM_GetModifierEvasion_Base(self)
	return (self.evasion or 0) + self.n_17_evade + self.sr_184_base
end
function u.prototype.EOM_GetModifierMagicalEvasion_Constant(self, w)
	return GetEvasion(self:GetParent(), w) * self.r_28_chance * 0.01
end
function u.prototype.EOM_GetModifierEvadeDamageReduceBonusPercent(self, w)
	return self.damage_reduce_pct
end
function u.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	if self.n_25_evade_threshold > 0 then
		return math.floor(GetEvasion(self:GetParent()) / self.n_25_evade_threshold * self.n_25_crit_damage)
	end
end
function u.prototype.OnBattleStartBefore(self, w)
	local x = self:GetParent()
	self.sr_151_enable = true
	if IsInjurable(x) then
		x:AddNewModifier(x, self:GetAbility(), "modifier_sect_evade_26_buff", nil)
	end
	if self.sr_184_duration > 0 then
		x:AddNewModifier(x, self:GetAbility(), "modifier_sect_evade_184_buff", { duration = self.sr_184_duration })
		if self.sr_184_effect_1 > 0 then
			x:AddNewModifier(x, self:GetAbility(), "modifier_sect_evade_184_trait", nil)
		end
	end
	if self.sr_189_damage_pct > 0 then
		x:AddNewModifier(x, self:GetAbility(), "modifier_sect_evade_189_buff", nil)
	end
end
function u.prototype.customAbilityTrigger(self)
	if self:GetParent():IsNeutral() then
		return
	end
	if self:GetParent():GetHeroBase():getCustomAbilityTrigger() ~= "sect_evade" then
		return
	end
	if self.trigger_chance > 0 and self:PRD(self.trigger_chance, "trigger_chance") then
		local E = self:GetParent():GetHeroBase():getCustomAbilityEffectModifier()
		if E ~= nil then
			E:customAbilityEffect()
		end
	end
end
function u.prototype.customAbilityEffect(self)
	self:GetParent():GetHeroBase():addCustomAbilityTriggerCount()
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_sect_evade_effect_buff",
		{ duration = self.effect_duration }
	)
end
function u.prototype.EOM_GetModifierAllBlockChance(self, w)
	if self.sr_151_base_chance == 0 then
		return
	end
	if not self.sr_151_enable then
		return
	end
	if bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_NO_EVASION) == DamageFlags.DAMAGE_FLAG_NO_EVASION then
		return
	end
	local F = self:GetParent()
	if F:HasModifier("modifier_sect_evade_151_buff") then
		return
	end
	local G = Clamp(self.sr_151_base_chance + GetEvasion(F) * self.sr_151_bonus_chance * 0.01, 0, 100)
	if RollPercentage(G) then
		self.sr_151_enable = false
		self:StartThink(self.sr_151_cooldown, "sr_151")
		F:AddNewModifier(F, self:GetAbility(), "modifier_sect_evade_151_buff", { duration = self.sr_151_duration })
		return 100
	end
end
u = e(
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
	u
)
g.modifier_sect_evade = u
local H = {
	"models/props_gameplay/donkey.vmdl",
	"models/props_gameplay/donkey_dire.vmdl",
	"models/props_gameplay/donkey_wings.vmdl",
	"models/props_gameplay/donkey_dire_wings.vmdl",
	"models/props_tree/tree_oak_00.vmdl",
	"models/props_tree/dire_tree003.vmdl",
	"models/props_tree/dire_tree001.vmdl",
}
g.modifier_sect_evade_151_buff = c()
local I = g.modifier_sect_evade_151_buff
I.name = "modifier_sect_evade_151_buff"
d(I, l)
function I.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.model = H[RandomInt(0, #H - 1) + 1]
end
function I.prototype.OnCreated(self, w)
	local F = self:GetParent()
	if IsClient() then
		ParticleManager:CreateParticle(
			"particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf",
			PATTACH_ABSORIGIN,
			F
		)
	else
		F:SetModelScale(0.01)
		EmitSoundOn("Hero_MonkeyKing.Transform.On", F)
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = F:GetAbsOrigin(),
				model = self.model,
				DefaultAnim = "ACT_DOTA_IDLE",
				use_animgraph = "1",
				AnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				angles = F:GetForwardVector(),
			}
		)
	end
end
function I.prototype.OnDestroy(self)
	local F = self:GetParent()
	if IsServer() then
		F:SetModelScale(F:GetDefaultModelScale())
		self.dummy:Remove()
		EmitSoundOn("Hero_MonkeyKing.Transform.Off", F)
	end
end
function I.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100 }
end
I = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	I
)
g.modifier_sect_evade_151_buff = I
g.modifier_sect_evade_26_buff = c()
local J = g.modifier_sect_evade_26_buff
J.name = "modifier_sect_evade_26_buff"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.n_26_max_evade = self:GetSectSpecialValueFor("26", "n_26_max_evade")
end
function J.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE }
end
function J.prototype.EOM_GetModifierSurehitChance(self, w)
	return self.n_26_max_evade
end
J = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	J
)
g.modifier_sect_evade_26_buff = J
g.modifier_sect_evade_29_buff = c()
local K = g.modifier_sect_evade_29_buff
K.name = "modifier_sect_evade_29_buff"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.r_29_evade = self:GetSectSpecialValueFor("29", "r_29_evade")
	self.r_29_max_evade = self:GetSectSpecialValueFor("29", "r_29_max_evade")
end
function K.prototype.OnCreated(self, w)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function K.prototype.OnRefresh(self, w)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function K.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function K.prototype.EOM_GetModifierEvasion_Bonus(self)
	return math.min(self.r_29_max_evade, self:GetStackCount() * self.r_29_evade)
end
K = e(
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
	K
)
g.modifier_sect_evade_29_buff = K
g.modifier_sect_evade_140_interval = c()
local L = g.modifier_sect_evade_140_interval
L.name = "modifier_sect_evade_140_interval"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.sr_140_evade = self:GetSectSpecialValueFor("140", "sr_140_evade")
end
function L.prototype.OnCreated(self, w)
	local F = self:GetParent()
	if IsServer() then
		F:EmitSound("Hero_TemplarAssassin.Refraction")
	else
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			F
		)
		ParticleManager:SetParticleControlEnt(A, 1, F, PATTACH_ABSORIGIN_FOLLOW, nil, F:GetAbsOrigin(), true)
		self:AddParticle(A, false, false, -1, false, false)
	end
end
function L.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.sr_140_evade }
end
L = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	L
)
g.modifier_sect_evade_140_interval = L
g.modifier_sect_evade_effect_buff = c()
local M = g.modifier_sect_evade_effect_buff
M.name = "modifier_sect_evade_effect_buff"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.effect_value = self:GetCustomAbilityValueFor("sect_evade_effect", "value")
	self.effect_max_value = self:GetCustomAbilityValueFor("sect_evade_effect", "max_value")
end
function M.prototype.OnCreated(self, w)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(0)
		self.tData = {}
		local N = self.tData
		N[#N + 1] = self:GetDieTime()
	end
end
function M.prototype.OnRefresh(self, O)
	if IsServer() then
		self:IncrementStackCount()
		local P = self.tData
		P[#P + 1] = self:GetDieTime()
	end
end
function M.prototype.OnIntervalThink(self)
	local Q = GameRules:GetGameTime()
	for R = #self.tData, 1, -1 do
		if self.tData[R] <= Q then
			self:DecrementStackCount()
			table.remove(self.tData, R)
		end
	end
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function M.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -math.min(self.effect_max_value, self.effect_value * self:GetStackCount())
end
M = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	M
)
g.modifier_sect_evade_effect_buff = M
g.modifier_sect_evade_184_buff = c()
local S = g.modifier_sect_evade_184_buff
S.name = "modifier_sect_evade_184_buff"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.sr_184_count = self:GetSectSpecialValueFor("184", "sr_184_count")
end
function S.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.sr_184_count }
end
S = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	S
)
g.modifier_sect_evade_184_buff = S
g.modifier_sect_evade_184_trait = c()
local T = g.modifier_sect_evade_184_trait
T.name = "modifier_sect_evade_184_trait"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.evade_bonus = self:GetSectSpecialValueFor("184", "evade_bonus")
	self.max_stack = self:GetSectSpecialValueFor("184", "max_stack")
end
function T.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 } }
end
function T.prototype.OnEvasion(self, w)
	local U = self:GetStackCount()
	if U < self.max_stack then
		self:SetStackCount(math.min(self.max_stack, U + 1))
	end
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function T.prototype.EOM_GetModifierEvasion_Bonus(self, w)
	return self.evade_bonus * self:GetStackCount()
end
T = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	T
)
g.modifier_sect_evade_184_trait = T
g.modifier_sect_evade_189_buff = c()
local V = g.modifier_sect_evade_189_buff
V.name = "modifier_sect_evade_189_buff"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.sr_189_chance = self:GetSectSpecialValueFor("189", "sr_189_chance")
	self.sr_189_damage = self:GetSectSpecialValueFor("189", "sr_189_damage")
	self.sr_189_damage_pct = self:GetSectSpecialValueFor("189", "sr_189_damage_pct")
	self.sr_189_evade_reduce = self:GetSectSpecialValueFor("189", "sr_189_evade_reduce")
end
function V.prototype.OnCreated(self, w)
	if IsClient() then
		local F = self:GetParent()
		local W = ParticleManager:CreateParticle(
			"particles/econ/items/spectre/spectre_arcana/spectre_arcana_radiance_owner_body.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			F
		)
		ParticleManager:SetParticleControlEnt(W, 1, F, PATTACH_POINT_FOLLOW, "attach_hitloc", F:GetAbsOrigin(), true)
		self:AddParticle(W, false, false, -1, false, false)
	end
end
function V.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT] = self.sr_189_evade_reduce }
end
function V.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function V.prototype.OnCustomTakeDamage(self, X)
	if X.is_evasion then
		return
	end
	if not DamageSystem:hasEvasion(X) then
		return
	end
	if
		X.damage_flags
		and bit.band(X.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) == DamageFlags.DAMAGE_FLAG_REFLECTION
	then
		return
	end
	local Y = X.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
	if
		not Y
		and (X.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL or X.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS)
		and GetMagicalEvasion(self:GetParent()) > 0
	then
		Y = true
	end
	if Y and self:PRD(self.sr_189_chance) then
		local D = self.sr_189_damage + X.damage * self.sr_189_damage_pct * 0.01 * GetEvasion(X.target) * 0.01
		X.target:DealDamage(
			X.attacker,
			self:GetAbility(),
			D,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			DamageFlags.DAMAGE_FLAG_REFLECTION
				+ DamageFlags.DAMAGE_FLAG_HPLOSS
				+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
			"189"
		)
	end
end
V = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	V
)
g.modifier_sect_evade_189_buff = V
return g