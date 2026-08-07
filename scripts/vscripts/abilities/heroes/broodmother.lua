--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/broodmother"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 515,
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 6,
		["30"] = 6,
		["31"] = 12,
		["32"] = 20,
		["33"] = 12,
		["34"] = 20,
		["36"] = 20,
		["37"] = 31,
		["38"] = 35,
		["39"] = 12,
		["40"] = 39,
		["41"] = 41,
		["42"] = 44,
		["43"] = 45,
		["44"] = 46,
		["45"] = 47,
		["46"] = 58,
		["47"] = 39,
		["48"] = 60,
		["49"] = 61,
		["50"] = 62,
		["51"] = 63,
		["52"] = 64,
		["54"] = 60,
		["55"] = 67,
		["56"] = 68,
		["57"] = 69,
		["58"] = 70,
		["59"] = 70,
		["60"] = 70,
		["61"] = 70,
		["62"] = 71,
		["65"] = 74,
		["66"] = 75,
		["67"] = 76,
		["70"] = 77,
		["71"] = 78,
		["72"] = 79,
		["73"] = 80,
		["76"] = 67,
		["77"] = 85,
		["78"] = 86,
		["79"] = 85,
		["80"] = 91,
		["81"] = 92,
		["82"] = 91,
		["83"] = 100,
		["84"] = 101,
		["85"] = 101,
		["86"] = 101,
		["87"] = 101,
		["88"] = 106,
		["89"] = 106,
		["90"] = 106,
		["91"] = 101,
		["92"] = 101,
		["93"] = 100,
		["94"] = 109,
		["95"] = 110,
		["96"] = 111,
		["97"] = 112,
		["98"] = 112,
		["99"] = 112,
		["100"] = 112,
		["101"] = 112,
		["102"] = 112,
		["104"] = 109,
		["105"] = 115,
		["106"] = 116,
		["107"] = 115,
		["108"] = 118,
		["109"] = 119,
		["110"] = 120,
		["111"] = 121,
		["113"] = 118,
		["114"] = 124,
		["115"] = 125,
		["116"] = 126,
		["118"] = 124,
		["119"] = 138,
		["120"] = 139,
		["121"] = 140,
		["122"] = 141,
		["125"] = 138,
		["126"] = 145,
		["127"] = 146,
		["128"] = 147,
		["129"] = 148,
		["132"] = 151,
		["133"] = 152,
		["134"] = 153,
		["136"] = 155,
		["137"] = 156,
		["138"] = 157,
		["139"] = 157,
		["140"] = 157,
		["141"] = 157,
		["142"] = 157,
		["143"] = 157,
		["144"] = 157,
		["145"] = 157,
		["146"] = 157,
		["147"] = 158,
		["148"] = 159,
		["149"] = 159,
		["150"] = 159,
		["151"] = 159,
		["152"] = 159,
		["153"] = 161,
		["154"] = 162,
		["155"] = 163,
		["156"] = 164,
		["157"] = 165,
		["158"] = 165,
		["159"] = 165,
		["160"] = 165,
		["161"] = 165,
		["162"] = 166,
		["163"] = 166,
		["164"] = 166,
		["165"] = 166,
		["166"] = 166,
		["167"] = 167,
		["168"] = 167,
		["169"] = 167,
		["170"] = 167,
		["171"] = 167,
		["172"] = 168,
		["173"] = 168,
		["174"] = 168,
		["175"] = 168,
		["176"] = 168,
		["177"] = 169,
		["178"] = 169,
		["179"] = 169,
		["180"] = 169,
		["181"] = 169,
		["182"] = 170,
		["183"] = 170,
		["184"] = 170,
		["185"] = 170,
		["186"] = 170,
		["187"] = 171,
		["188"] = 171,
		["189"] = 171,
		["190"] = 171,
		["191"] = 171,
		["192"] = 172,
		["193"] = 172,
		["194"] = 172,
		["195"] = 172,
		["196"] = 172,
		["197"] = 173,
		["198"] = 173,
		["199"] = 173,
		["200"] = 173,
		["201"] = 173,
		["202"] = 174,
		["203"] = 174,
		["204"] = 174,
		["205"] = 174,
		["206"] = 174,
		["207"] = 175,
		["208"] = 175,
		["209"] = 175,
		["210"] = 175,
		["211"] = 175,
		["212"] = 175,
		["213"] = 175,
		["214"] = 175,
		["215"] = 175,
		["217"] = 177,
		["218"] = 178,
		["219"] = 179,
		["220"] = 181,
		["221"] = 182,
		["222"] = 183,
		["223"] = 184,
		["224"] = 185,
		["225"] = 185,
		["226"] = 185,
		["227"] = 185,
		["228"] = 185,
		["229"] = 185,
		["232"] = 145,
		["233"] = 20,
		["234"] = 12,
		["235"] = 12,
		["236"] = 12,
		["237"] = 12,
		["238"] = 12,
		["239"] = 12,
		["240"] = 12,
		["241"] = 12,
		["242"] = 20,
		["244"] = 20,
		["245"] = 192,
		["246"] = 200,
		["247"] = 192,
		["248"] = 200,
		["249"] = 208,
		["250"] = 209,
		["251"] = 210,
		["252"] = 212,
		["253"] = 213,
		["254"] = 214,
		["255"] = 215,
		["256"] = 216,
		["257"] = 217,
		["259"] = 208,
		["260"] = 220,
		["261"] = 221,
		["262"] = 220,
		["263"] = 227,
		["264"] = 228,
		["265"] = 229,
		["267"] = 231,
		["268"] = 227,
		["269"] = 234,
		["270"] = 235,
		["271"] = 236,
		["273"] = 234,
		["274"] = 239,
		["275"] = 240,
		["276"] = 241,
		["278"] = 239,
		["279"] = 200,
		["280"] = 192,
		["281"] = 192,
		["282"] = 192,
		["283"] = 192,
		["284"] = 192,
		["285"] = 192,
		["286"] = 192,
		["287"] = 192,
		["288"] = 200,
		["290"] = 200,
		["291"] = 246,
		["292"] = 254,
		["293"] = 246,
		["294"] = 254,
		["295"] = 258,
		["296"] = 259,
		["297"] = 260,
		["298"] = 261,
		["299"] = 258,
		["300"] = 263,
		["301"] = 264,
		["302"] = 265,
		["303"] = 266,
		["304"] = 267,
		["307"] = 263,
		["308"] = 271,
		["309"] = 272,
		["310"] = 273,
		["311"] = 273,
		["312"] = 273,
		["313"] = 273,
		["314"] = 273,
		["315"] = 273,
		["317"] = 271,
		["318"] = 276,
		["319"] = 277,
		["320"] = 278,
		["322"] = 276,
		["323"] = 254,
		["324"] = 246,
		["325"] = 246,
		["326"] = 246,
		["327"] = 246,
		["328"] = 246,
		["329"] = 246,
		["330"] = 246,
		["331"] = 246,
		["332"] = 254,
		["334"] = 254,
		["335"] = 283,
		["336"] = 293,
		["337"] = 283,
		["338"] = 293,
		["339"] = 295,
		["340"] = 296,
		["341"] = 295,
		["342"] = 298,
		["343"] = 299,
		["344"] = 298,
		["345"] = 301,
		["346"] = 302,
		["347"] = 303,
		["349"] = 301,
		["350"] = 306,
		["351"] = 307,
		["352"] = 308,
		["354"] = 306,
		["355"] = 311,
		["356"] = 312,
		["357"] = 311,
		["358"] = 316,
		["359"] = 317,
		["360"] = 316,
		["361"] = 293,
		["362"] = 283,
		["363"] = 283,
		["364"] = 283,
		["365"] = 283,
		["366"] = 283,
		["367"] = 283,
		["368"] = 283,
		["369"] = 283,
		["370"] = 283,
		["371"] = 283,
		["372"] = 293,
		["374"] = 293,
		["375"] = 321,
		["376"] = 322,
		["377"] = 321,
		["378"] = 322,
		["379"] = 323,
		["380"] = 324,
		["381"] = 325,
		["382"] = 328,
		["383"] = 329,
		["384"] = 329,
		["385"] = 329,
		["386"] = 330,
		["387"] = 331,
		["390"] = 334,
		["391"] = 335,
		["392"] = 336,
		["393"] = 337,
		["394"] = 339,
		["395"] = 340,
		["396"] = 341,
		["398"] = 344,
		["399"] = 345,
		["400"] = 346,
		["401"] = 347,
		["403"] = 348,
		["404"] = 348,
		["405"] = 349,
		["406"] = 348,
		["411"] = 353,
		["412"] = 353,
		["413"] = 353,
		["414"] = 353,
		["415"] = 353,
		["416"] = 353,
		["417"] = 359,
		["418"] = 360,
		["419"] = 361,
		["420"] = 362,
		["421"] = 363,
		["422"] = 363,
		["423"] = 363,
		["424"] = 363,
		["425"] = 363,
		["426"] = 363,
		["427"] = 363,
		["428"] = 364,
		["430"] = 353,
		["431"] = 353,
		["432"] = 329,
		["433"] = 329,
		["434"] = 323,
		["435"] = 371,
		["436"] = 372,
		["437"] = 371,
		["438"] = 322,
		["439"] = 321,
		["440"] = 322,
		["442"] = 322,
		["443"] = 375,
		["444"] = 383,
		["445"] = 375,
		["446"] = 383,
		["447"] = 383,
		["448"] = 375,
		["449"] = 375,
		["450"] = 375,
		["451"] = 375,
		["452"] = 375,
		["453"] = 375,
		["454"] = 375,
		["455"] = 375,
		["456"] = 383,
		["458"] = 383,
		["459"] = 384,
		["460"] = 392,
		["461"] = 384,
		["462"] = 392,
		["463"] = 403,
		["464"] = 404,
		["465"] = 403,
		["466"] = 406,
		["467"] = 407,
		["468"] = 409,
		["469"] = 412,
		["470"] = 413,
		["471"] = 415,
		["472"] = 417,
		["473"] = 406,
		["474"] = 425,
		["475"] = 426,
		["476"] = 425,
		["477"] = 432,
		["478"] = 433,
		["479"] = 434,
		["480"] = 435,
		["481"] = 436,
		["482"] = 437,
		["483"] = 437,
		["484"] = 437,
		["485"] = 437,
		["486"] = 437,
		["487"] = 437,
		["488"] = 441,
		["489"] = 441,
		["490"] = 441,
		["491"] = 437,
		["492"] = 437,
		["493"] = 437,
		["494"] = 437,
		["495"] = 432,
		["496"] = 448,
		["497"] = 449,
		["498"] = 450,
		["499"] = 451,
		["500"] = 451,
		["501"] = 451,
		["502"] = 451,
		["503"] = 452,
		["504"] = 452,
		["505"] = 452,
		["506"] = 452,
		["507"] = 452,
		["508"] = 452,
		["510"] = 448,
		["511"] = 455,
		["512"] = 456,
		["513"] = 455,
		["514"] = 462,
		["515"] = 463,
		["516"] = 464,
		["519"] = 465,
		["522"] = 466,
		["523"] = 467,
		["524"] = 468,
		["525"] = 462,
		["526"] = 392,
		["527"] = 384,
		["528"] = 384,
		["529"] = 384,
		["530"] = 384,
		["531"] = 384,
		["532"] = 384,
		["533"] = 384,
		["534"] = 384,
		["535"] = 392,
		["537"] = 392,
		["538"] = 472,
		["539"] = 480,
		["540"] = 472,
		["541"] = 480,
		["542"] = 482,
		["543"] = 483,
		["544"] = 482,
		["545"] = 485,
		["546"] = 486,
		["547"] = 485,
		["548"] = 490,
		["549"] = 491,
		["550"] = 490,
		["551"] = 480,
		["552"] = 472,
		["553"] = 472,
		["554"] = 472,
		["555"] = 472,
		["556"] = 472,
		["557"] = 472,
		["558"] = 472,
		["559"] = 472,
		["560"] = 480,
		["562"] = 480,
		["563"] = 496,
		["564"] = 497,
		["565"] = 498,
		["566"] = 499,
		["569"] = 515,
		["570"] = 515,
		["571"] = 536,
		["572"] = 530,
		["573"] = 531,
		["574"] = 532,
		["575"] = 534,
		["576"] = 535,
		["577"] = 537,
		["578"] = 538,
		["579"] = 539,
		["580"] = 540,
		["581"] = 542,
		["582"] = 543,
		["583"] = 536,
		["584"] = 546,
		["585"] = 546,
		["586"] = 546,
		["588"] = 547,
		["591"] = 548,
		["592"] = 549,
		["593"] = 549,
		["594"] = 549,
		["595"] = 549,
		["596"] = 549,
		["597"] = 552,
		["598"] = 552,
		["599"] = 552,
		["600"] = 549,
		["601"] = 549,
		["602"] = 549,
		["603"] = 549,
		["604"] = 549,
		["605"] = 549,
		["606"] = 549,
		["607"] = 549,
		["608"] = 549,
		["609"] = 560,
		["610"] = 560,
		["611"] = 560,
		["612"] = 561,
		["613"] = 562,
		["614"] = 563,
		["616"] = 565,
		["617"] = 566,
		["618"] = 560,
		["619"] = 560,
		["621"] = 569,
		["622"] = 546,
		["623"] = 572,
		["624"] = 573,
		["627"] = 574,
		["628"] = 575,
		["631"] = 578,
		["632"] = 579,
		["633"] = 580,
		["634"] = 581,
		["635"] = 582,
		["636"] = 582,
		["637"] = 582,
		["638"] = 582,
		["639"] = 582,
		["640"] = 582,
		["641"] = 582,
		["642"] = 582,
		["643"] = 582,
		["644"] = 583,
		["645"] = 583,
		["646"] = 583,
		["647"] = 583,
		["648"] = 583,
		["649"] = 585,
		["650"] = 586,
		["652"] = 588,
		["653"] = 588,
		["654"] = 588,
		["655"] = 589,
		["656"] = 590,
		["657"] = 588,
		["658"] = 588,
		["659"] = 572,
		["660"] = 593,
		["661"] = 594,
		["664"] = 595,
		["665"] = 596,
		["666"] = 597,
		["667"] = 598,
		["668"] = 598,
		["669"] = 598,
		["670"] = 598,
		["671"] = 598,
		["672"] = 598,
		["673"] = 598,
		["674"] = 599,
		["675"] = 599,
		["676"] = 599,
		["677"] = 600,
		["678"] = 601,
		["679"] = 599,
		["680"] = 599,
		["681"] = 593,
		["682"] = 605,
		["683"] = 607,
		["684"] = 608,
		["685"] = 609,
		["686"] = 610,
		["687"] = 605,
		["688"] = 613,
		["689"] = 614,
		["690"] = 615,
		["691"] = 616,
		["693"] = 618,
		["694"] = 619,
		["696"] = 621,
		["697"] = 622,
		["699"] = 624,
		["700"] = 625,
		["702"] = 627,
		["703"] = 628,
		["705"] = 630,
		["706"] = 631,
		["707"] = 632,
		["708"] = 633,
		["709"] = 634,
		["710"] = 613,
		["711"] = 640,
		["712"] = 641,
		["713"] = 640,
		["714"] = 641,
		["715"] = 642,
		["716"] = 643,
		["717"] = 642,
		["718"] = 641,
		["719"] = 640,
		["720"] = 641,
		["722"] = 641,
		["723"] = 646,
		["724"] = 654,
		["725"] = 646,
		["726"] = 654,
		["727"] = 659,
		["728"] = 660,
		["729"] = 661,
		["730"] = 662,
		["731"] = 659,
		["732"] = 664,
		["733"] = 665,
		["734"] = 664,
		["735"] = 670,
		["736"] = 671,
		["737"] = 672,
		["738"] = 672,
		["739"] = 672,
		["740"] = 672,
		["741"] = 672,
		["742"] = 673,
		["743"] = 672,
		["744"] = 672,
		["745"] = 670,
		["746"] = 676,
		["747"] = 677,
		["748"] = 678,
		["749"] = 679,
		["750"] = 680,
		["753"] = 676,
		["754"] = 654,
		["755"] = 646,
		["756"] = 646,
		["757"] = 646,
		["758"] = 646,
		["759"] = 646,
		["760"] = 646,
		["761"] = 646,
		["762"] = 646,
		["763"] = 654,
		["765"] = 654,
		["766"] = 685,
		["767"] = 693,
		["768"] = 685,
		["769"] = 693,
		["770"] = 695,
		["771"] = 696,
		["772"] = 697,
		["773"] = 698,
		["774"] = 698,
		["775"] = 698,
		["776"] = 698,
		["777"] = 698,
		["778"] = 698,
		["779"] = 698,
		["781"] = 695,
		["782"] = 704,
		["783"] = 705,
		["784"] = 706,
		["786"] = 704,
		["787"] = 693,
		["788"] = 685,
		["789"] = 685,
		["790"] = 685,
		["791"] = 685,
		["792"] = 685,
		["793"] = 685,
		["794"] = 685,
		["795"] = 685,
		["796"] = 693,
		["798"] = 693,
	}
)
local h = {}
local i
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = require("abilities.ability_ai")
local q = p.BaseAbilityAI
local r = p.registerAbilityAI
h.broodmother_talent = c()
local s = h.broodmother_talent
s.name = "broodmother_talent"
d(s, k)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_broodmother_talent"
end
s = e({ l(nil) }, s)
h.broodmother_talent = s
h.modifier_broodmother_talent = c()
local t = h.modifier_broodmother_talent
t.name = "modifier_broodmother_talent"
d(t, n)
function t.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.tl5_counter = 0
	self.tick = 0.1
end
function t.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("broodmother_talent_1", "interval")
	self.tl5_duration = self:GetAbilityTalentValue("broodmother_talent_5", "duration")
	self.tl5_tirgger_web = self:GetAbilityTalentValue("broodmother_talent_5", "tirgger_web")
	self.steal_as = self:GetAbilitySpecialValueFor("steal_as")
	self.mana = self:GetAbilitySpecialValueFor("mana")
	self.tl3_steal_hp_pct = self:GetAbilityTalentValue("broodmother_talent_3", "heal_hp_pct")
end
function t.prototype.OnCreated(self, u)
	if IsServer() then
		self.poison_record = 0
		self.web_counter = 0
		self.record = 0
	end
end
function t.prototype.OnIntervalThink(self)
	if IsServer() then
		local v = self.parent:GetEnemy()
		if not IsInjurable(self.parent:GetEnemy(), self.parent) then
			self:StartIntervalThink(-1)
			return
		end
		local w = self.steal_as * self.web_counter
		self:SetStackCount(w)
		if self.parent:PassivesDisabled() then
			return
		end
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.record = 0
			self:SpinWeb()
		end
	end
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function t.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return self:GetStackCount()
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
		[EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function t.prototype.OnBattleStartBefore(self, u)
	self:SpinWeb()
	if self.tl5_duration > 0 then
		self.caster:AddNewModifier(
			self.caster,
			self:GetAbility(),
			"modifier_broodmother_talent_5",
			{ duration = self.tl5_duration }
		)
	end
end
function t.prototype.OnBattleStart(self, u)
	self:StartIntervalThink(self.tick)
end
function t.prototype.OnBattleEnd(self, u)
	self:StartIntervalThink(-1)
	if self.web_id then
		ParticleManager:DestroyParticle(self.web_id, false)
	end
end
function t.prototype.OnPoisonTakeDamage(self, u)
	if IsServer() and self:HasTalent("broodmother_talent_3") then
		Heal(self.parent, u.damage * self.tl3_steal_hp_pct * 0.01, "broodmother_talent_3", "Ability")
	end
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		if self.web_id then
			ParticleManager:DestroyParticle(self.web_id, false)
		end
	end
end
function t.prototype.SpinWeb(self)
	local v = self.parent:GetEnemy()
	if not IsInjurable(self.parent, v) then
		self:StartIntervalThink(-1)
		return
	end
	self.parent:EmitSound("Hero_Broodmother.SpinWebCast")
	if not self.parent:HasModifier("modifier_broodmother_ult_cast") then
		self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.5)
	end
	local x = self.parent:GetAbsOrigin()
	local y = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_broodmother/broodmother_spin_web_cast.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(y, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", x, true)
	ParticleManager:SetParticleControl(y, 1, x)
	ParticleManager:SetParticleControl(y, 2, Vector(600, 600, 600))
	ParticleManager:ReleaseParticleIndex(y)
	if self.web_id == nil then
		self.web_id = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_broodmother/broodmother_web.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControl(self.web_id, 0, x)
		ParticleManager:SetParticleControl(self.web_id, 1, Vector(600, 600, 600))
		ParticleManager:SetParticleControl(self.web_id, 2, Vector(600, 600, 600))
		ParticleManager:SetParticleControl(y, 10, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 11, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 12, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 13, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 14, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 15, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 16, Vector(0, 0, 0))
		ParticleManager:SetParticleControl(y, 17, Vector(0, 0, 0))
		ParticleManager:SetParticleControlEnt(self.web_id, 3, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, x, true)
	end
	Restore(self.parent, self.mana)
	v:AddNewModifier(self.caster, self.ability, "modifier_broodmother_talent_debuff", nil)
	self.web_counter = self.web_counter + 1
	if self.tl5_tirgger_web > 0 then
		self.tl5_counter = self.tl5_counter + 1
		if self.tl5_counter >= self.tl5_tirgger_web then
			self.tl5_counter = 0
			self.caster:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_broodmother_talent_5",
				{ duration = self.tl5_duration }
			)
		end
	end
end
t = e(
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
	t
)
h.modifier_broodmother_talent = t
h.modifier_broodmother_talent_5 = c()
local z = h.modifier_broodmother_talent_5
z.name = "modifier_broodmother_talent_5"
d(z, n)
function z.prototype.GetAbilitySpecialValue(self)
	self.hp_steal_pct = self:GetAbilityTalentValue("broodmother_talent_5", "hp_steal_pct")
	self.atk = self:GetAbilityTalentValue("broodmother_talent_5", "atk")
	local A = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_reduce_attack_interval = (A and A:GetAbilityName()) == "trait_195"
			and A:GetSpecialValueFor("reduce_attack_interval")
		or 0
	self.g_bonus = (A and A:GetAbilityName()) == "trait_195" and A:GetSpecialValueFor("bonus") or 1
	if self.g_bonus > 1 then
		self.hp_steal_pct = self.hp_steal_pct * self.g_bonus
		self.atk = self.atk * self.g_bonus
	end
end
function z.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_LIFESTEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS,
	}
end
function z.prototype.EOM_GetModifierAttackDamageBonus(self, u)
	if IsServer() then
		self:SetStackCount(self.atk)
	end
	return self:GetStackCount()
end
function z.prototype.EOM_GetModifierLifesteal(self, u)
	if IsServer() then
		return self.hp_steal_pct
	end
end
function z.prototype.EOM_GetModifierAttackRateBonus(self, u)
	if self.g_reduce_attack_interval and self.g_reduce_attack_interval > 0 then
		return -self.g_reduce_attack_interval
	end
end
z = e(
	{
		o(
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
	z
)
h.modifier_broodmother_talent_5 = z
h.modifier_broodmother_talent_5_overflow = c()
local B = h.modifier_broodmother_talent_5_overflow
B.name = "modifier_broodmother_talent_5_overflow"
d(B, n)
function B.prototype.GetAbilitySpecialValue(self)
	local A = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.reply_pct = (A and A:GetAbilityName()) == "trait_195" and A:GetSpecialValueFor("reply_pct") or 0
	self.g_interval = (A and A:GetAbilityName()) == "trait_195" and A:GetSpecialValueFor("interval") or 0
end
function B.prototype.OnCreated(self, u)
	if IsServer() then
		self.overflow_total = u.overflow or 0
		if self.overflow_total > 0 then
			self:StartIntervalThink(self.g_interval)
		end
	end
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		Heal(self:GetParent(), self.overflow_total * self.reply_pct * 0.01, "greevil_effect_7", "Ability")
	end
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
B = e(
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
	B
)
h.modifier_broodmother_talent_5_overflow = B
h.modifier_broodmother_talent_debuff = c()
local C = h.modifier_broodmother_talent_debuff
C.name = "modifier_broodmother_talent_debuff"
d(C, n)
function C.prototype.GetTexture(self)
	return "broodmother_spin_web"
end
function C.prototype.GetAbilitySpecialValue(self)
	self.steal_as = self:GetAbilitySpecialValueFor("steal_as")
end
function C.prototype.OnCreated(self, u)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function C.prototype.OnRefresh(self, u)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function C.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function C.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return -self:GetStackCount() * self.steal_as
end
C = e(
	{
		o(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff_c.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	C
)
h.modifier_broodmother_talent_debuff = C
h.broodmother_ult = c()
local D = h.broodmother_ult
D.name = "broodmother_ult"
d(D, q)
function D.prototype.OnSpellStart(self)
	local E = self:GetCaster()
	E:AddNewModifier(E, self, "modifier_broodmother_ult_cast", { duration = 0.3 })
	E:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:GameTimer(0.3, function()
		local v = E:GetEnemy()
		if not IsInjurable(E, v) then
			return
		end
		E:EmitSound("Hero_Broodmother.SpawnSpiderlingsCast")
		local F = self:GetSpecialValueFor("damage")
		local G = self:GetSpecialValueFor("poison_count") + self:GetTalentValue("broodmother_talent_4", "poison")
		local H = self:GetSpecialValueFor("born_count")
		local I = self:GetTalentValue("broodmother_talent_6", "count_pct")
		if I > 0 then
			H = H * (1 + I * 0.01)
		end
		local J = self:GetTalentValue("broodmother_talent_4", "count")
		if J > 0 then
			local K = E:FindModifierByName("modifier_broodmother_talent")
			if IsValid(K) then
				do
					local L = 0
					while L < J do
						K:SpinWeb()
						L = L + 1
					end
				end
			end
		end
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_broodmother/broodmother_web_cast.vpcf",
			hCaster = E,
			vSpawnOrigin = E:GetAttachmentPosition("attach_thorax"),
			hTarget = v,
			iMoveSpeed = PROJECTILE_SPEED_FAST,
			OnProjectileHit = function(M, N, O)
				if IsValid(self) and IsInjurable(E, v) then
					v:EmitSound("Hero_Broodmother.SpawnSpiderlingsImpact")
					E:DealDamage(v, self, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
					AddPoison(E, v, G, self:GetAbilityName(), "Ability")
					E:FindModifierByName("modifier_broodmother_ult"):BornSpiderling(v, H)
				end
			end,
		})
	end)
end
function D.prototype.GetIntrinsicModifierName(self)
	return "modifier_broodmother_ult"
end
D = e({ r(nil) }, D)
h.broodmother_ult = D
h.modifier_broodmother_ult_cast = c()
local P = h.modifier_broodmother_ult_cast
P.name = "modifier_broodmother_ult_cast"
d(P, n)
P = e(
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
	P
)
h.modifier_broodmother_ult_cast = P
h.modifier_broodmother_ult = c()
local Q = h.modifier_broodmother_ult
Q.name = "modifier_broodmother_ult"
d(Q, n)
function Q.prototype.GetTexture(self)
	return "broodmother_spawn_spiderite"
end
function Q.prototype.GetAbilitySpecialValue(self)
	self.child_attack_pct = self:GetAbilitySpecialValueFor("child_attack_pct")
	self.child_posion = self:GetAbilitySpecialValueFor("child_posion")
		+ self:GetAbilityTalentValue("broodmother_talent_7", "poison_count")
	self.child_count = self:GetAbilitySpecialValueFor("child_count")
		+ self:GetAbilityTalentValue("broodmother_talent_6", "count_bonus")
	self.born_count = self:GetAbilitySpecialValueFor("born_count")
	self.tl2_count = self:GetAbilityTalentValue("broodmother_talent_2", "count")
	self.tl7_count = self:GetAbilityTalentValue("broodmother_talent_7", "count")
end
function Q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function Q.prototype.OnBattleStartBefore(self, u)
	self.UIAbility = self.parent:FindAbilityByName("broodmother_spiderling")
	local v = self.parent:GetEnemy()
	local R = self.parent:GetAbsOrigin()
	local S = v:GetAbsOrigin()
	self.spiderling_class = f(
		i,
		{
			parent = self.parent,
			enemy = v,
			ability = self.UIAbility,
			position = GetGroundPosition(S + CalcDirection2D(R, S) * 100, self.parent),
			values = { child_attack_pct = self.child_attack_pct, child_posion = self.child_posion },
		}
	)
end
function Q.prototype.OnBattleStart(self, u)
	if self.tl2_count > 0 then
		local v = self.caster:GetEnemy()
		self:BornSpiderling(self.parent:GetEnemy(), self.tl2_count)
		v:AddNewModifier(self.caster, self:GetAbility(), "modifier_broodmother_talent2_debuff", {})
	end
end
function Q.prototype.OnBattleEnd(self, u)
	self.spiderling_class:dispose()
end
function Q.prototype.BornSpiderling(self, T, U)
	local v = self.parent:GetEnemy()
	if not IsInjurable(v, self.parent) then
		return
	end
	if self.spiderling_class.spiderling_count == self.child_count then
		return
	end
	U = U + self.tl7_count
	self.spiderling_class:spawn(math.min(U, self.child_count - self.spiderling_class.spiderling_count))
	self:SetStackCount(self.spiderling_class.spiderling_count)
end
Q = e(
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
	Q
)
h.modifier_broodmother_ult = Q
h.modifier_broodmother_talent2_debuff = c()
local V = h.modifier_broodmother_talent2_debuff
V.name = "modifier_broodmother_talent2_debuff"
d(V, n)
function V.prototype.GetAbilitySpecialValue(self)
	self.tl2_add_poison = self:GetAbilityTalentValue("broodmother_talent_2", "add_poison")
end
function V.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DEEPEN }
end
function V.prototype.EOM_GetModifierPoisonDeepen(self, u)
	return self.tl2_add_poison
end
V = e(
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
	V
)
h.modifier_broodmother_talent2_debuff = V
local W = "models/heroes/broodmother/spiderling.vmdl"
local X = "particles/units/heroes/hero_broodmother/spiderling_attack.vpcf"
local Y = 0.5
local Z = 0.8
i = c()
i.name = "BroodmotherSpiderling"
function i.prototype.____constructor(self, _)
	self.attack_point = 0
	self.attack_backswing = 0
	self.animation_rate = 1
	self.spiderling_count = 0
	self.disposed = false
	self.parent = _.parent
	self.position = _.position
	self.ability = _.ability
	self.enemy = _.enemy
	self.child_attack_pct = _.values.child_attack_pct
	self.child_posion = _.values.child_posion
end
function i.prototype.spawn(self, U)
	if U == nil then
		U = 1
	end
	if self.disposed then
		return
	end
	if self.spiderling_count == 0 and not IsValid(self.spawningDummy) then
		self.spawningDummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = self.position,
				scales = ".3 .3 .3",
				angles = VectorToAngles(CalcDirection2D(self.enemy:GetAbsOrigin(), self.position)),
				model = Wearable:getReplaceUnitModel(self.parent, W),
				StartingAnim = "ACT_DOTA_SPAWN",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				DefaultAnim = "ACT_DOTA_SPAWN",
				AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
			}
		)
		self.timer0 = GameTimer(0.666667, function()
			self.timer0 = nil
			if self.spawningDummy then
				UTIL_Remove(self.spawningDummy)
			end
			self.spawningDummy = nil
			self:OnAttackStart()
		end)
	end
	self.spiderling_count = self.spiderling_count + U
end
function i.prototype.OnAttackStart(self)
	if self.disposed then
		return
	end
	if not (IsInjurable(self.enemy, self.parent) and IsValid(self.ability)) then
		self:dispose()
		return
	end
	self:CaculateAttackTime()
	local a0 = self.spiderling
	self.spiderling = ParticleManager:CreateParticle(X, PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControl(self.spiderling, 0, self.position)
	ParticleManager:SetParticleControlEnt(
		self.spiderling,
		1,
		self.enemy,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.enemy:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.spiderling, 2, Vector(self.animation_rate, 0, 0))
	if a0 then
		ParticleManager:DestroyParticle(a0, false)
	end
	self.timer1 = GameTimer(self.attack_point, function()
		self.timer1 = nil
		self:OnAttackLanded()
	end)
end
function i.prototype.OnAttackLanded(self)
	if self.disposed then
		return
	end
	local F = GetAttackDamage(self.parent) * self.child_attack_pct * 0.01 * self.spiderling_count
	self.parent:DealDamage(self.enemy, self.ability, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	local a1 = self.child_posion * self.spiderling_count
	AddPoison(self.parent, self.enemy, a1, self.ability:GetAbilityName(), "Ability")
	self.timer2 = GameTimer(self.attack_backswing, function()
		self.timer2 = nil
		self:OnAttackStart()
	end)
end
function i.prototype.CaculateAttackTime(self)
	local a2 = self.parent:GetBaseAttackTime(false) / self.parent:GetAttackSpeed(false)
	self.animation_rate = Z / a2
	self.attack_point = a2 * Y / Z
	self.attack_backswing = a2 - self.attack_point
end
function i.prototype.dispose(self)
	self.disposed = true
	if self.timer0 ~= nil then
		StopTimer(self.timer1)
	end
	if self.timer1 ~= nil then
		StopTimer(self.timer1)
	end
	if self.timer2 ~= nil then
		StopTimer(self.timer2)
	end
	if self.spiderling then
		ParticleManager:DestroyParticle(self.spiderling, true)
	end
	if self.spawningDummy then
		UTIL_Remove(self.spawningDummy)
	end
	self.spawningDummy = nil
	self.spiderling = nil
	self.timer0 = nil
	self.timer1 = nil
	self.timer2 = nil
end
h.broodmother_shard = c()
local a3 = h.broodmother_shard
a3.name = "broodmother_shard"
d(a3, k)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_broodmother_shard_custom"
end
a3 = e({ l(nil) }, a3)
h.broodmother_shard = a3
h.modifier_broodmother_shard_custom = c()
local a4 = h.modifier_broodmother_shard_custom
a4.name = "modifier_broodmother_shard_custom"
d(a4, n)
function a4.prototype.GetAbilitySpecialValue(self)
	self.base_health = self:GetAbilitySpecialValueFor("base_health")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function a4.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { nil, self.parent },
	}
end
function a4.prototype.OnBattleStart(self, u)
	local a5 = self.base_health + self.bonus_health * PlayerData:getHeroLevel(self.parent:GetPlayerOwnerID())
	self.wisp = SummonWisp(self.parent, a5, "models/heroes/broodmother/spidersack.vmdl", function(a6)
		a6:AddNewModifier(self.parent, self.ability, "modifier_broodmother_shard_wisp", nil)
	end)
end
function a4.prototype.OnWispDie(self, u)
	if IsValid(u.wisp) and u.wisp == self.wisp then
		local a7 = self.parent:FindModifierByName("modifier_broodmother_ult")
		if IsValid(a7) then
			a7:BornSpiderling(self.wisp, self.count)
		end
	end
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
			}
		),
	},
	a4
)
h.modifier_broodmother_shard_custom = a4
h.modifier_broodmother_shard_wisp = c()
local a8 = h.modifier_broodmother_shard_wisp
a8.name = "modifier_broodmother_shard_wisp"
d(a8, n)
function a8.prototype.OnCreated(self, u)
	if IsServer() then
		self.parent:AddNoDraw()
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				model = Wearable:getReplaceUnitModel(self.caster, "models/heroes/broodmother/spidersack.vmdl"),
				origin = self.parent:GetAbsOrigin(),
			}
		)
	end
end
function a8.prototype.OnDestroy(self)
	if IsServer() then
		UTIL_Remove(self.dummy)
	end
end
a8 = e(
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
	a8
)
h.modifier_broodmother_shard_wisp = a8
return h