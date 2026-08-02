--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["9"] = 539,
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
		["250"] = 200,
		["251"] = 208,
		["252"] = 192,
		["253"] = 211,
		["254"] = 212,
		["255"] = 213,
		["256"] = 215,
		["257"] = 216,
		["258"] = 217,
		["259"] = 218,
		["260"] = 211,
		["261"] = 220,
		["262"] = 221,
		["263"] = 222,
		["264"] = 223,
		["265"] = 223,
		["266"] = 222,
		["268"] = 226,
		["269"] = 220,
		["270"] = 228,
		["271"] = 229,
		["272"] = 228,
		["273"] = 235,
		["274"] = 236,
		["275"] = 237,
		["277"] = 239,
		["278"] = 235,
		["279"] = 242,
		["280"] = 243,
		["281"] = 244,
		["283"] = 242,
		["284"] = 247,
		["285"] = 248,
		["286"] = 249,
		["288"] = 247,
		["289"] = 252,
		["290"] = 253,
		["293"] = 254,
		["296"] = 255,
		["297"] = 256,
		["298"] = 257,
		["300"] = 252,
		["301"] = 260,
		["302"] = 261,
		["305"] = 262,
		["308"] = 263,
		["309"] = 264,
		["310"] = 264,
		["311"] = 264,
		["312"] = 264,
		["313"] = 264,
		["314"] = 264,
		["315"] = 260,
		["316"] = 200,
		["317"] = 192,
		["318"] = 192,
		["319"] = 192,
		["320"] = 192,
		["321"] = 192,
		["322"] = 192,
		["323"] = 192,
		["324"] = 192,
		["325"] = 200,
		["327"] = 200,
		["328"] = 271,
		["329"] = 279,
		["330"] = 271,
		["331"] = 279,
		["332"] = 283,
		["333"] = 284,
		["334"] = 285,
		["335"] = 283,
		["336"] = 287,
		["337"] = 288,
		["338"] = 289,
		["339"] = 290,
		["340"] = 291,
		["343"] = 287,
		["344"] = 295,
		["345"] = 296,
		["346"] = 297,
		["347"] = 297,
		["348"] = 297,
		["349"] = 297,
		["350"] = 297,
		["351"] = 297,
		["353"] = 295,
		["354"] = 300,
		["355"] = 301,
		["356"] = 302,
		["358"] = 300,
		["359"] = 279,
		["360"] = 271,
		["361"] = 271,
		["362"] = 271,
		["363"] = 271,
		["364"] = 271,
		["365"] = 271,
		["366"] = 271,
		["367"] = 271,
		["368"] = 279,
		["370"] = 279,
		["371"] = 307,
		["372"] = 317,
		["373"] = 307,
		["374"] = 317,
		["375"] = 319,
		["376"] = 320,
		["377"] = 319,
		["378"] = 322,
		["379"] = 323,
		["380"] = 322,
		["381"] = 325,
		["382"] = 326,
		["383"] = 327,
		["385"] = 325,
		["386"] = 330,
		["387"] = 331,
		["388"] = 332,
		["390"] = 330,
		["391"] = 335,
		["392"] = 336,
		["393"] = 335,
		["394"] = 340,
		["395"] = 341,
		["396"] = 340,
		["397"] = 317,
		["398"] = 307,
		["399"] = 307,
		["400"] = 307,
		["401"] = 307,
		["402"] = 307,
		["403"] = 307,
		["404"] = 307,
		["405"] = 307,
		["406"] = 307,
		["407"] = 307,
		["408"] = 317,
		["410"] = 317,
		["411"] = 345,
		["412"] = 346,
		["413"] = 345,
		["414"] = 346,
		["415"] = 347,
		["416"] = 348,
		["417"] = 349,
		["418"] = 352,
		["419"] = 353,
		["420"] = 353,
		["421"] = 353,
		["422"] = 354,
		["423"] = 355,
		["426"] = 358,
		["427"] = 359,
		["428"] = 360,
		["429"] = 361,
		["430"] = 363,
		["431"] = 364,
		["432"] = 365,
		["434"] = 368,
		["435"] = 369,
		["436"] = 370,
		["437"] = 371,
		["439"] = 372,
		["440"] = 372,
		["441"] = 373,
		["442"] = 372,
		["447"] = 377,
		["448"] = 377,
		["449"] = 377,
		["450"] = 377,
		["451"] = 377,
		["452"] = 377,
		["453"] = 383,
		["454"] = 384,
		["455"] = 385,
		["456"] = 386,
		["457"] = 387,
		["458"] = 387,
		["459"] = 387,
		["460"] = 387,
		["461"] = 387,
		["462"] = 387,
		["463"] = 387,
		["464"] = 388,
		["466"] = 377,
		["467"] = 377,
		["468"] = 353,
		["469"] = 353,
		["470"] = 347,
		["471"] = 395,
		["472"] = 396,
		["473"] = 395,
		["474"] = 346,
		["475"] = 345,
		["476"] = 346,
		["478"] = 346,
		["479"] = 399,
		["480"] = 407,
		["481"] = 399,
		["482"] = 407,
		["483"] = 407,
		["484"] = 399,
		["485"] = 399,
		["486"] = 399,
		["487"] = 399,
		["488"] = 399,
		["489"] = 399,
		["490"] = 399,
		["491"] = 399,
		["492"] = 407,
		["494"] = 407,
		["495"] = 408,
		["496"] = 416,
		["497"] = 408,
		["498"] = 416,
		["499"] = 427,
		["500"] = 428,
		["501"] = 427,
		["502"] = 430,
		["503"] = 431,
		["504"] = 433,
		["505"] = 436,
		["506"] = 437,
		["507"] = 439,
		["508"] = 441,
		["509"] = 430,
		["510"] = 449,
		["511"] = 450,
		["512"] = 449,
		["513"] = 456,
		["514"] = 457,
		["515"] = 458,
		["516"] = 459,
		["517"] = 460,
		["518"] = 461,
		["519"] = 461,
		["520"] = 461,
		["521"] = 461,
		["522"] = 461,
		["523"] = 461,
		["524"] = 465,
		["525"] = 465,
		["526"] = 465,
		["527"] = 461,
		["528"] = 461,
		["529"] = 461,
		["530"] = 461,
		["531"] = 456,
		["532"] = 472,
		["533"] = 473,
		["534"] = 474,
		["535"] = 475,
		["536"] = 475,
		["537"] = 475,
		["538"] = 475,
		["539"] = 476,
		["540"] = 476,
		["541"] = 476,
		["542"] = 476,
		["543"] = 476,
		["544"] = 476,
		["546"] = 472,
		["547"] = 479,
		["548"] = 480,
		["549"] = 479,
		["550"] = 486,
		["551"] = 487,
		["552"] = 488,
		["555"] = 489,
		["558"] = 490,
		["559"] = 491,
		["560"] = 492,
		["561"] = 486,
		["562"] = 416,
		["563"] = 408,
		["564"] = 408,
		["565"] = 408,
		["566"] = 408,
		["567"] = 408,
		["568"] = 408,
		["569"] = 408,
		["570"] = 408,
		["571"] = 416,
		["573"] = 416,
		["574"] = 496,
		["575"] = 504,
		["576"] = 496,
		["577"] = 504,
		["578"] = 506,
		["579"] = 507,
		["580"] = 506,
		["581"] = 509,
		["582"] = 510,
		["583"] = 509,
		["584"] = 514,
		["585"] = 515,
		["586"] = 514,
		["587"] = 504,
		["588"] = 496,
		["589"] = 496,
		["590"] = 496,
		["591"] = 496,
		["592"] = 496,
		["593"] = 496,
		["594"] = 496,
		["595"] = 496,
		["596"] = 504,
		["598"] = 504,
		["599"] = 520,
		["600"] = 521,
		["601"] = 522,
		["602"] = 523,
		["605"] = 539,
		["606"] = 539,
		["607"] = 560,
		["608"] = 554,
		["609"] = 555,
		["610"] = 556,
		["611"] = 558,
		["612"] = 559,
		["613"] = 561,
		["614"] = 562,
		["615"] = 563,
		["616"] = 564,
		["617"] = 566,
		["618"] = 567,
		["619"] = 560,
		["620"] = 570,
		["621"] = 570,
		["622"] = 570,
		["624"] = 571,
		["627"] = 572,
		["628"] = 573,
		["629"] = 573,
		["630"] = 573,
		["631"] = 573,
		["632"] = 573,
		["633"] = 576,
		["634"] = 576,
		["635"] = 576,
		["636"] = 573,
		["637"] = 573,
		["638"] = 573,
		["639"] = 573,
		["640"] = 573,
		["641"] = 573,
		["642"] = 573,
		["643"] = 573,
		["644"] = 573,
		["645"] = 584,
		["646"] = 584,
		["647"] = 584,
		["648"] = 585,
		["649"] = 586,
		["650"] = 587,
		["652"] = 589,
		["653"] = 590,
		["654"] = 584,
		["655"] = 584,
		["657"] = 593,
		["658"] = 570,
		["659"] = 596,
		["660"] = 597,
		["663"] = 598,
		["664"] = 599,
		["667"] = 602,
		["668"] = 603,
		["669"] = 604,
		["670"] = 605,
		["671"] = 606,
		["672"] = 606,
		["673"] = 606,
		["674"] = 606,
		["675"] = 606,
		["676"] = 606,
		["677"] = 606,
		["678"] = 606,
		["679"] = 606,
		["680"] = 607,
		["681"] = 607,
		["682"] = 607,
		["683"] = 607,
		["684"] = 607,
		["685"] = 609,
		["686"] = 610,
		["688"] = 612,
		["689"] = 612,
		["690"] = 612,
		["691"] = 613,
		["692"] = 614,
		["693"] = 612,
		["694"] = 612,
		["695"] = 596,
		["696"] = 617,
		["697"] = 618,
		["700"] = 619,
		["701"] = 620,
		["702"] = 621,
		["703"] = 622,
		["704"] = 622,
		["705"] = 622,
		["706"] = 622,
		["707"] = 622,
		["708"] = 622,
		["709"] = 622,
		["710"] = 623,
		["711"] = 623,
		["712"] = 623,
		["713"] = 624,
		["714"] = 625,
		["715"] = 623,
		["716"] = 623,
		["717"] = 617,
		["718"] = 629,
		["719"] = 631,
		["720"] = 632,
		["721"] = 633,
		["722"] = 634,
		["723"] = 629,
		["724"] = 637,
		["725"] = 638,
		["726"] = 639,
		["727"] = 640,
		["729"] = 642,
		["730"] = 643,
		["732"] = 645,
		["733"] = 646,
		["735"] = 648,
		["736"] = 649,
		["738"] = 651,
		["739"] = 652,
		["741"] = 654,
		["742"] = 655,
		["743"] = 656,
		["744"] = 657,
		["745"] = 658,
		["746"] = 637,
		["747"] = 664,
		["748"] = 665,
		["749"] = 664,
		["750"] = 665,
		["751"] = 666,
		["752"] = 667,
		["753"] = 666,
		["754"] = 665,
		["755"] = 664,
		["756"] = 665,
		["758"] = 665,
		["759"] = 670,
		["760"] = 678,
		["761"] = 670,
		["762"] = 678,
		["763"] = 683,
		["764"] = 684,
		["765"] = 685,
		["766"] = 686,
		["767"] = 683,
		["768"] = 688,
		["769"] = 689,
		["770"] = 688,
		["771"] = 694,
		["772"] = 695,
		["773"] = 696,
		["774"] = 696,
		["775"] = 696,
		["776"] = 696,
		["777"] = 696,
		["778"] = 697,
		["779"] = 696,
		["780"] = 696,
		["781"] = 694,
		["782"] = 700,
		["783"] = 701,
		["784"] = 702,
		["785"] = 703,
		["786"] = 704,
		["789"] = 700,
		["790"] = 678,
		["791"] = 670,
		["792"] = 670,
		["793"] = 670,
		["794"] = 670,
		["795"] = 670,
		["796"] = 670,
		["797"] = 670,
		["798"] = 670,
		["799"] = 678,
		["801"] = 678,
		["802"] = 709,
		["803"] = 717,
		["804"] = 709,
		["805"] = 717,
		["806"] = 719,
		["807"] = 720,
		["808"] = 721,
		["809"] = 722,
		["810"] = 722,
		["811"] = 722,
		["812"] = 722,
		["813"] = 722,
		["814"] = 722,
		["815"] = 722,
		["817"] = 719,
		["818"] = 728,
		["819"] = 729,
		["820"] = 730,
		["822"] = 728,
		["823"] = 717,
		["824"] = 709,
		["825"] = 709,
		["826"] = 709,
		["827"] = 709,
		["828"] = 709,
		["829"] = 709,
		["830"] = 709,
		["831"] = 709,
		["832"] = 717,
		["834"] = 717,
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
function z.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.overflow = 0
end
function z.prototype.GetAbilitySpecialValue(self)
	self.hp_steal_pct = self:GetAbilityTalentValue("broodmother_talent_5", "hp_steal_pct")
	self.atk = self:GetAbilityTalentValue("broodmother_talent_5", "atk")
	self.g_reduce_attack_interval = self:GetGreevilEffectValueFor("greevil_effect_7", "reduce_attack_interval")
	self.g_duration = self:GetGreevilEffectValueFor("greevil_effect_7", "duration")
	self.g_interval = self:GetGreevilEffectValueFor("greevil_effect_7", "interval")
	self.g_reply_pct = self:GetGreevilEffectValueFor("greevil_effect_7", "reply_pct")
end
function z.prototype.EDeclareEvents(self)
	if self.g_reduce_attack_interval > 0 then
		return { [EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent(), -1 } }
	end
	return {}
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
function z.prototype.OnHeal(self, u)
	if not IsServer() then
		return
	end
	if not (u.flag == HealFlags.HEAL_FLAG_LIFESETEAL or u.flag == HealFlags.HEAL_FLAG_ABILITY_LIFESETEAL) then
		return
	end
	local A = u.origin_health + u.flHealAmount - self:GetParent():GetMaxHealth()
	if A > 0 then
		self.overflow = self.overflow + A
	end
end
function z.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.g_reply_pct <= 0 or self.overflow <= 0 then
		return
	end
	print("结束天赋15")
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_broodmother_talent_5_overflow",
		{ duration = self.g_duration, overflow = self.overflow }
	)
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
	self.reply_pct = self:GetGreevilEffectValueFor("greevil_effect_7", "reply_pct")
	self.g_interval = self:GetGreevilEffectValueFor("greevil_effect_7", "interval")
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