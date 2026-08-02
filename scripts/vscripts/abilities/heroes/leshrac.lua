--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/leshrac"
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
		["31"] = 11,
		["32"] = 19,
		["33"] = 11,
		["34"] = 19,
		["36"] = 19,
		["37"] = 23,
		["38"] = 24,
		["39"] = 25,
		["40"] = 11,
		["41"] = 29,
		["42"] = 31,
		["43"] = 32,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["47"] = 37,
		["49"] = 29,
		["50"] = 40,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 44,
		["55"] = 44,
		["56"] = 44,
		["57"] = 41,
		["58"] = 41,
		["59"] = 40,
		["60"] = 47,
		["61"] = 48,
		["62"] = 49,
		["63"] = 50,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 54,
		["68"] = 55,
		["69"] = 56,
		["70"] = 57,
		["71"] = 59,
		["72"] = 59,
		["73"] = 59,
		["74"] = 59,
		["75"] = 59,
		["76"] = 59,
		["81"] = 47,
		["82"] = 65,
		["83"] = 66,
		["84"] = 65,
		["85"] = 68,
		["86"] = 69,
		["87"] = 68,
		["88"] = 71,
		["89"] = 72,
		["90"] = 73,
		["93"] = 74,
		["94"] = 75,
		["97"] = 78,
		["98"] = 79,
		["99"] = 80,
		["100"] = 81,
		["103"] = 82,
		["106"] = 71,
		["107"] = 87,
		["108"] = 88,
		["109"] = 89,
		["110"] = 90,
		["113"] = 93,
		["114"] = 94,
		["115"] = 94,
		["116"] = 94,
		["117"] = 94,
		["118"] = 94,
		["119"] = 95,
		["120"] = 96,
		["121"] = 97,
		["122"] = 98,
		["123"] = 98,
		["124"] = 98,
		["125"] = 98,
		["126"] = 98,
		["127"] = 98,
		["128"] = 87,
		["129"] = 100,
		["130"] = 101,
		["131"] = 100,
		["132"] = 19,
		["133"] = 11,
		["134"] = 11,
		["135"] = 11,
		["136"] = 11,
		["137"] = 11,
		["138"] = 11,
		["139"] = 11,
		["140"] = 11,
		["141"] = 19,
		["143"] = 19,
		["144"] = 104,
		["145"] = 112,
		["146"] = 104,
		["147"] = 112,
		["148"] = 114,
		["149"] = 116,
		["150"] = 114,
		["151"] = 118,
		["152"] = 119,
		["153"] = 118,
		["154"] = 112,
		["155"] = 104,
		["156"] = 104,
		["157"] = 104,
		["158"] = 104,
		["159"] = 104,
		["160"] = 104,
		["161"] = 104,
		["162"] = 104,
		["163"] = 112,
		["165"] = 112,
		["166"] = 124,
		["167"] = 126,
		["168"] = 127,
		["169"] = 126,
		["170"] = 127,
		["171"] = 129,
		["172"] = 130,
		["173"] = 131,
		["174"] = 132,
		["177"] = 135,
		["178"] = 136,
		["180"] = 138,
		["181"] = 139,
		["182"] = 139,
		["183"] = 139,
		["184"] = 139,
		["185"] = 139,
		["186"] = 139,
		["187"] = 129,
		["188"] = 141,
		["189"] = 142,
		["190"] = 144,
		["191"] = 145,
		["192"] = 146,
		["193"] = 147,
		["195"] = 149,
		["196"] = 141,
		["197"] = 154,
		["198"] = 155,
		["199"] = 156,
		["200"] = 157,
		["201"] = 158,
		["202"] = 159,
		["203"] = 160,
		["206"] = 154,
		["207"] = 164,
		["208"] = 165,
		["209"] = 167,
		["211"] = 169,
		["214"] = 172,
		["215"] = 173,
		["216"] = 174,
		["219"] = 177,
		["220"] = 178,
		["221"] = 178,
		["222"] = 178,
		["223"] = 178,
		["224"] = 178,
		["225"] = 178,
		["226"] = 178,
		["227"] = 178,
		["228"] = 178,
		["229"] = 179,
		["230"] = 179,
		["231"] = 179,
		["232"] = 179,
		["233"] = 179,
		["234"] = 180,
		["235"] = 181,
		["236"] = 182,
		["237"] = 182,
		["238"] = 182,
		["239"] = 182,
		["240"] = 182,
		["241"] = 182,
		["242"] = 182,
		["243"] = 164,
		["244"] = 184,
		["245"] = 185,
		["246"] = 184,
		["247"] = 127,
		["248"] = 126,
		["249"] = 127,
		["251"] = 127,
		["252"] = 188,
		["253"] = 197,
		["254"] = 188,
		["255"] = 197,
		["256"] = 199,
		["257"] = 200,
		["258"] = 199,
		["259"] = 202,
		["260"] = 203,
		["261"] = 202,
		["262"] = 207,
		["263"] = 208,
		["264"] = 209,
		["265"] = 210,
		["266"] = 211,
		["270"] = 207,
		["271"] = 197,
		["272"] = 188,
		["273"] = 188,
		["274"] = 188,
		["275"] = 188,
		["276"] = 188,
		["277"] = 188,
		["278"] = 188,
		["279"] = 188,
		["280"] = 188,
		["281"] = 197,
		["283"] = 197,
		["284"] = 217,
		["285"] = 226,
		["286"] = 217,
		["287"] = 226,
		["289"] = 226,
		["290"] = 229,
		["291"] = 217,
		["292"] = 230,
		["293"] = 232,
		["294"] = 230,
		["295"] = 234,
		["296"] = 235,
		["297"] = 236,
		["298"] = 237,
		["299"] = 238,
		["301"] = 234,
		["302"] = 241,
		["303"] = 242,
		["304"] = 243,
		["306"] = 241,
		["307"] = 246,
		["308"] = 247,
		["309"] = 248,
		["310"] = 249,
		["311"] = 250,
		["312"] = 251,
		["313"] = 252,
		["316"] = 255,
		["320"] = 246,
		["321"] = 226,
		["322"] = 217,
		["323"] = 217,
		["324"] = 217,
		["325"] = 217,
		["326"] = 217,
		["327"] = 217,
		["328"] = 217,
		["329"] = 217,
		["330"] = 217,
		["331"] = 226,
		["333"] = 226,
		["334"] = 263,
		["335"] = 264,
		["336"] = 263,
		["337"] = 264,
		["338"] = 265,
		["339"] = 266,
		["340"] = 265,
		["341"] = 264,
		["342"] = 263,
		["343"] = 264,
		["345"] = 264,
		["346"] = 269,
		["347"] = 277,
		["348"] = 269,
		["349"] = 277,
		["351"] = 277,
		["352"] = 281,
		["353"] = 282,
		["354"] = 283,
		["355"] = 290,
		["356"] = 269,
		["357"] = 291,
		["358"] = 292,
		["359"] = 293,
		["360"] = 295,
		["361"] = 296,
		["362"] = 297,
		["363"] = 299,
		["364"] = 300,
		["365"] = 301,
		["366"] = 302,
		["367"] = 303,
		["368"] = 304,
		["370"] = 306,
		["371"] = 307,
		["374"] = 291,
		["375"] = 311,
		["376"] = 312,
		["377"] = 313,
		["378"] = 314,
		["379"] = 315,
		["380"] = 316,
		["381"] = 317,
		["382"] = 318,
		["383"] = 320,
		["384"] = 321,
		["385"] = 322,
		["389"] = 326,
		["390"] = 311,
		["391"] = 328,
		["392"] = 329,
		["393"] = 329,
		["394"] = 329,
		["395"] = 332,
		["396"] = 332,
		["397"] = 332,
		["398"] = 329,
		["399"] = 329,
		["400"] = 328,
		["401"] = 335,
		["402"] = 336,
		["403"] = 337,
		["404"] = 338,
		["405"] = 339,
		["406"] = 340,
		["407"] = 341,
		["408"] = 341,
		["409"] = 341,
		["410"] = 341,
		["411"] = 341,
		["412"] = 341,
		["413"] = 342,
		["416"] = 345,
		["418"] = 335,
		["419"] = 348,
		["420"] = 349,
		["421"] = 348,
		["422"] = 351,
		["423"] = 352,
		["424"] = 351,
		["425"] = 354,
		["426"] = 355,
		["427"] = 356,
		["430"] = 357,
		["433"] = 358,
		["434"] = 359,
		["437"] = 362,
		["438"] = 363,
		["439"] = 364,
		["440"] = 365,
		["443"] = 354,
		["444"] = 369,
		["445"] = 370,
		["446"] = 371,
		["447"] = 372,
		["450"] = 375,
		["451"] = 376,
		["452"] = 377,
		["453"] = 378,
		["454"] = 379,
		["455"] = 380,
		["457"] = 382,
		["458"] = 382,
		["459"] = 382,
		["460"] = 382,
		["461"] = 382,
		["462"] = 382,
		["463"] = 383,
		["464"] = 384,
		["465"] = 385,
		["466"] = 386,
		["467"] = 387,
		["469"] = 387,
		["473"] = 369,
		["474"] = 391,
		["475"] = 392,
		["476"] = 391,
		["477"] = 277,
		["478"] = 269,
		["479"] = 269,
		["480"] = 269,
		["481"] = 269,
		["482"] = 269,
		["483"] = 269,
		["484"] = 269,
		["485"] = 269,
		["486"] = 277,
		["488"] = 277,
		["489"] = 395,
		["490"] = 403,
		["491"] = 395,
		["492"] = 403,
		["493"] = 405,
		["494"] = 407,
		["495"] = 405,
		["496"] = 409,
		["497"] = 410,
		["498"] = 409,
		["499"] = 403,
		["500"] = 395,
		["501"] = 395,
		["502"] = 395,
		["503"] = 395,
		["504"] = 395,
		["505"] = 395,
		["506"] = 395,
		["507"] = 395,
		["508"] = 403,
		["510"] = 403,
		["511"] = 416,
		["512"] = 417,
		["513"] = 416,
		["514"] = 417,
		["515"] = 418,
		["516"] = 419,
		["517"] = 420,
		["520"] = 421,
		["521"] = 422,
		["522"] = 422,
		["523"] = 422,
		["524"] = 423,
		["525"] = 422,
		["526"] = 422,
		["527"] = 418,
		["528"] = 426,
		["529"] = 427,
		["530"] = 428,
		["531"] = 429,
		["534"] = 430,
		["535"] = 431,
		["536"] = 432,
		["537"] = 433,
		["538"] = 434,
		["539"] = 435,
		["540"] = 436,
		["541"] = 436,
		["542"] = 436,
		["543"] = 436,
		["544"] = 436,
		["545"] = 437,
		["546"] = 438,
		["547"] = 439,
		["548"] = 440,
		["549"] = 441,
		["550"] = 426,
		["551"] = 443,
		["552"] = 444,
		["553"] = 443,
		["554"] = 417,
		["555"] = 416,
		["556"] = 417,
		["558"] = 417,
		["559"] = 447,
		["560"] = 455,
		["561"] = 447,
		["562"] = 455,
		["563"] = 456,
		["564"] = 456,
		["565"] = 458,
		["566"] = 459,
		["567"] = 460,
		["569"] = 458,
		["570"] = 463,
		["571"] = 464,
		["572"] = 464,
		["573"] = 464,
		["574"] = 467,
		["575"] = 467,
		["576"] = 467,
		["577"] = 464,
		["578"] = 464,
		["579"] = 463,
		["580"] = 470,
		["581"] = 471,
		["582"] = 470,
		["583"] = 473,
		["584"] = 474,
		["585"] = 475,
		["586"] = 476,
		["587"] = 477,
		["588"] = 478,
		["589"] = 479,
		["590"] = 480,
		["593"] = 483,
		["594"] = 473,
		["595"] = 455,
		["596"] = 447,
		["597"] = 447,
		["598"] = 447,
		["599"] = 447,
		["600"] = 447,
		["601"] = 447,
		["602"] = 447,
		["603"] = 447,
		["604"] = 455,
		["606"] = 455,
		["608"] = 488,
		["609"] = 496,
		["610"] = 488,
		["611"] = 496,
		["612"] = 497,
		["613"] = 498,
		["614"] = 497,
		["615"] = 496,
		["616"] = 488,
		["617"] = 488,
		["618"] = 488,
		["619"] = 488,
		["620"] = 488,
		["621"] = 488,
		["622"] = 488,
		["623"] = 488,
		["624"] = 496,
		["626"] = 496,
		["627"] = 501,
		["628"] = 509,
		["629"] = 501,
		["630"] = 509,
		["631"] = 514,
		["632"] = 515,
		["633"] = 516,
		["634"] = 517,
		["635"] = 518,
		["636"] = 514,
		["637"] = 520,
		["638"] = 520,
		["639"] = 522,
		["640"] = 523,
		["641"] = 522,
		["642"] = 529,
		["643"] = 530,
		["644"] = 531,
		["645"] = 532,
		["647"] = 534,
		["649"] = 529,
		["650"] = 542,
		["651"] = 543,
		["652"] = 544,
		["653"] = 545,
		["655"] = 547,
		["656"] = 542,
		["657"] = 509,
		["658"] = 501,
		["659"] = 501,
		["660"] = 501,
		["661"] = 501,
		["662"] = 501,
		["663"] = 501,
		["664"] = 501,
		["665"] = 501,
		["666"] = 509,
		["668"] = 509,
		["670"] = 562,
		["671"] = 563,
		["672"] = 562,
		["673"] = 563,
		["674"] = 564,
		["675"] = 565,
		["676"] = 564,
		["677"] = 563,
		["678"] = 562,
		["679"] = 563,
		["681"] = 563,
		["682"] = 568,
		["683"] = 576,
		["684"] = 568,
		["685"] = 576,
		["686"] = 579,
		["687"] = 580,
		["688"] = 579,
		["689"] = 582,
		["690"] = 583,
		["691"] = 582,
		["692"] = 588,
		["693"] = 589,
		["694"] = 588,
		["695"] = 576,
		["696"] = 568,
		["697"] = 568,
		["698"] = 568,
		["699"] = 568,
		["700"] = 568,
		["701"] = 568,
		["702"] = 568,
		["703"] = 568,
		["704"] = 576,
		["706"] = 576,
		["708"] = 612,
		["709"] = 613,
		["710"] = 612,
		["711"] = 613,
		["712"] = 614,
		["713"] = 615,
		["714"] = 614,
		["715"] = 613,
		["716"] = 612,
		["717"] = 613,
		["719"] = 613,
		["720"] = 618,
		["721"] = 626,
		["722"] = 618,
		["723"] = 626,
		["724"] = 630,
		["725"] = 631,
		["726"] = 632,
		["727"] = 633,
		["728"] = 630,
		["729"] = 635,
		["730"] = 636,
		["731"] = 635,
		["732"] = 640,
		["733"] = 641,
		["736"] = 642,
		["737"] = 643,
		["738"] = 644,
		["739"] = 645,
		["740"] = 645,
		["741"] = 645,
		["742"] = 645,
		["743"] = 645,
		["744"] = 645,
		["745"] = 648,
		["746"] = 649,
		["749"] = 640,
		["750"] = 626,
		["751"] = 618,
		["752"] = 618,
		["753"] = 618,
		["754"] = 618,
		["755"] = 618,
		["756"] = 618,
		["757"] = 618,
		["758"] = 618,
		["759"] = 626,
		["761"] = 626,
		["762"] = 655,
		["763"] = 667,
		["764"] = 655,
		["765"] = 667,
		["766"] = 669,
		["767"] = 670,
		["768"] = 669,
		["769"] = 672,
		["770"] = 673,
		["771"] = 674,
		["772"] = 675,
		["774"] = 672,
		["775"] = 678,
		["776"] = 679,
		["777"] = 678,
		["778"] = 667,
		["779"] = 655,
		["780"] = 655,
		["781"] = 655,
		["782"] = 655,
		["783"] = 655,
		["784"] = 655,
		["785"] = 655,
		["786"] = 655,
		["787"] = 655,
		["788"] = 655,
		["789"] = 655,
		["790"] = 655,
		["791"] = 667,
		["793"] = 667,
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
local p = n.InteractBaseAbility
local q = n.registerInteractAbility
local r = n.registerInteractBaseAbility
g.leshrac_talent = c()
local s = g.leshrac_talent
s.name = "leshrac_talent"
d(s, p)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_talent"
end
s = e({ r(nil) }, s)
g.leshrac_talent = s
g.modifier_leshrac_talent = c()
local t = g.modifier_leshrac_talent
t.name = "modifier_leshrac_talent"
d(t, l)
function t.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.exp_record = 0
	self.tick = 0.1
	self.record = 0
end
function t.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("leshrac_talent_5", "interval_reduce")
	self.damage_factor = self:GetAbilitySpecialValueFor("damage_factor")
	self.tl3_ulti_power = self:GetAbilityTalentValue("leshrac_talent_3", "ulti_power")
	self.tl3_sect_lv = self:GetAbilityTalentValue("leshrac_talent_3", "sect_lv")
	if IsServer() then
		self.battling = false
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function t.prototype.OnBattleStartBefore(self, u)
	self.battling = true
	local v = self:GetParent()
	local w = v:GetPlayerOwnerID()
	local x = PlayerData:getHero(w)
	if x then
		local y = x:getAbilityData(false, true)
		if y and y.sect_ulti then
			self.exp_record = y.sect_ulti.exp
			if self.tl3_ulti_power > 0 then
				if y.sect_ulti.level >= self.tl3_sect_lv then
					v:AddNewModifier(v, self:GetAbility(), "modifier_leshrac_talent_3", nil)
				end
			end
		end
	end
end
function t.prototype.OnBattleStart(self, u)
	self:StartIntervalThink(self.tick)
end
function t.prototype.OnBattleEnd(self, u)
	self.battling = false
end
function t.prototype.OnIntervalThink(self)
	if IsServer() then
		if not self:IsActivated() then
			return
		end
		if not self.battling then
			self:StartIntervalThink(-1)
			return
		end
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.record = 0
			if self:GetParent():PassivesDisabled() then
				return
			end
			self:DiabolicEdict()
		end
	end
end
function t.prototype.DiabolicEdict(self)
	local v = self:GetParent()
	local z = v:GetEnemy()
	if not IsInjurable(v, z) then
		return
	end
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_diabolic_edict.vpcf",
		PATTACH_ABSORIGIN,
		z,
		v
	)
	ParticleManager:SetParticleControl(A, 1, z:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(A)
	z:EmitSound("Hero_Leshrac.Diabolic_Edict")
	local B = self:GetAbilitySpecialValueFor("damage") + self.exp_record * self.damage_factor
	v:DealDamage(z, self:GetAbility(), B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function t.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
end
t = e(
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
	t
)
g.modifier_leshrac_talent = t
g.modifier_leshrac_talent_3 = c()
local C = g.modifier_leshrac_talent_3
C.name = "modifier_leshrac_talent_3"
d(C, l)
function C.prototype.GetAbilitySpecialValue(self)
	self.tl3_ulti_power = self:GetAbilityTalentValue("leshrac_talent_3", "ulti_power")
end
function C.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER] = self.tl3_ulti_power }
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
g.modifier_leshrac_talent_3 = C
local D = 0.2
g.leshrac_ult = c()
local E = g.leshrac_ult
E.name = "leshrac_ult"
d(E, p)
function E.prototype.OnSpellStart(self, F)
	local G = self:GetCaster()
	local z = G:GetEnemy()
	if not IsInjurable(G, z) then
		return
	end
	if self.sect_lv == nil then
		self:GetSectUltiLevel()
	end
	G:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 2)
	G:AddNewModifier(G, self, "modifier_leshrac_ult_buff", self:GetBuffParam())
end
function E.prototype.GetBuffParam(self)
	local H = self:GetSpecialValueFor("count") + self.sect_lv * self:GetSpecialValueFor("level_count")
	local I = self:GetTalentValue("leshrac_talent_3", "count")
	local J = self:GetTalentValue("leshrac_talent_3", "sect_lv")
	if I > 0 and self.sect_lv >= J then
		H = H + I
	end
	return { duration = D * H + FRAME_TIME, iCastCount = H }
end
function E.prototype.GetSectUltiLevel(self)
	local x = PlayerData:getHero(self:GetCaster():GetPlayerOwnerID())
	self.sect_lv = 0
	if x then
		local y = x:getAbilityData(false, true)
		if y and y.sect_ulti then
			self.sect_lv = y.sect_ulti.level
		end
	end
end
function E.prototype.LightningStorm(self, B, K)
	if B == nil then
		B = self:GetSpecialValueFor("damage") + self:GetTalentValue("leshrac_talent_5", "bonus_damage")
	end
	if B <= 0 then
		return
	end
	local G = self:GetCaster()
	local z = G:GetEnemy()
	if not IsInjurable(G, z) then
		return
	end
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf",
		PATTACH_CUSTOMORIGIN,
		G
	)
	ParticleManager:SetParticleControl(
		A,
		0,
		z:GetAbsOrigin() + Vector(RandomInt(-100, 100), RandomInt(-100, 100), 1000)
	)
	ParticleManager:SetParticleControl(A, 1, z:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(A)
	z:EmitSound("Hero_Leshrac.Lightning_Storm")
	G:DealDamage(
		z,
		self,
		B,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		K and DamageFlags.DAMAGE_FLAG_NO_EXTRA or DamageFlags.DAMAGE_FLAG_NONE
	)
end
function E.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_ult"
end
E = e({ r(nil) }, E)
g.leshrac_ult = E
g.modifier_leshrac_ult = c()
local L = g.modifier_leshrac_ult
L.name = "modifier_leshrac_ult"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.tl1_chance = self:GetAbilityTalentValue("leshrac_talent_1", "chance")
end
function L.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() } }
end
function L.prototype.OnCustomTakeDamage(self, M)
	if self.tl1_chance > 0 then
		if
			M.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			and bit.band(M.damage_flags, DamageFlags.DAMAGE_FLAG_NO_EXTRA) ~= DamageFlags.DAMAGE_FLAG_NO_EXTRA
		then
			if self:PRD(self.tl1_chance, "tl1_chance") then
				self:GetAbility():LightningStorm(nil, true)
			end
		end
	end
end
L = e(
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
				IsIndependent = true,
			}
		),
	},
	L
)
g.modifier_leshrac_ult = L
g.modifier_leshrac_ult_buff = c()
local N = g.modifier_leshrac_ult_buff
N.name = "modifier_leshrac_ult_buff"
d(N, l)
function N.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.2
end
function N.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("leshrac_talent_5", "bonus_damage")
end
function N.prototype.OnCreated(self, u)
	if IsServer() then
		self.count = u.iCastCount
		self:StartIntervalThink(D)
		self:IncrementStackCount()
	end
end
function N.prototype.OnRefresh(self, u)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function N.prototype.OnIntervalThink(self)
	if IsServer() then
		if self.count > 0 then
			self.count = self.count - 1
			local O = self:GetAbility()
			if IsValid(O) then
				O:LightningStorm(self.damage * self:GetStackCount())
			end
		else
			self:Destroy()
			return
		end
	end
end
N = e(
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
				IsIndependent = true,
			}
		),
	},
	N
)
g.modifier_leshrac_ult_buff = N
g.leshrac_talent_s = c()
local P = g.leshrac_talent_s
P.name = "leshrac_talent_s"
d(P, p)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_talent_s"
end
P = e({ r(nil) }, P)
g.leshrac_talent_s = P
g.modifier_leshrac_talent_s = c()
local Q = g.modifier_leshrac_talent_s
Q.name = "modifier_leshrac_talent_s"
d(Q, l)
function Q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
	self.record = 0
	self.sectExp = 0
	self.tl6_counter = 0
end
function Q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.tl4_health_pct = self:GetAbilityTalentValue("leshrac_talent_4", "health_pct")
	self.tl4_sect_lv = self:GetAbilityTalentValue("leshrac_talent_4", "sect_lv")
	self.tl4_bonus_factor = self:GetAbilityTalentValue("leshrac_talent_4", "bonus_factor")
	self.tl6_count = self:GetAbilityTalentValue("leshrac_talent_6", "count")
	self.tl6_interval_reduce = self:GetAbilityTalentValue("leshrac_talent_6", "interval_reduce")
	if IsServer() then
		self.battling = false
		if not self:IsHealthSectLvEnable() then
			self.tl4_bonus_factor = 0
		end
		if self.tl6_interval_reduce > 0 then
			self.interval = self.interval - self.tl6_interval_reduce
		end
	end
end
function Q.prototype.IsHealthSectLvEnable(self)
	local v = self:GetParent()
	local w = v:GetPlayerOwnerID()
	local x = PlayerData:getHero(w)
	self.sectExp = 0
	if x then
		local y = x:getAbilityData(false, true)
		if y and y.sect_health then
			self.sectExp = y.sect_health.exp
			if y.sect_health.level >= self.tl4_sect_lv then
				return true
			end
		end
	end
	return false
end
function Q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function Q.prototype.OnBattleStartBefore(self, u)
	self.battling = true
	if self:IsHealthSectLvEnable() then
		self.tl4_bonus_factor = self:GetAbilityTalentValue("leshrac_talent_4", "bonus_factor")
		if self.tl4_health_pct > 0 then
			local v = self:GetParent()
			v:AddNewModifier(v, self:GetAbility(), "modifier_leshrac_talent_4", nil)
			v:SetHealth(v:GetMaxHealth())
		end
	else
		self.tl4_bonus_factor = 0
	end
end
function Q.prototype.OnBattleStart(self, u)
	self:StartIntervalThink(self.tick)
end
function Q.prototype.OnBattleEnd(self, u)
	self.battling = false
end
function Q.prototype.OnIntervalThink(self)
	if IsServer() then
		if not self:IsActivated() then
			return
		end
		if self:GetParent():PassivesDisabled() then
			return
		end
		if not self.battling then
			self:StartIntervalThink(-1)
			return
		end
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.record = 0
			self:PulseNova()
		end
	end
end
function Q.prototype.PulseNova(self)
	local v = self:GetParent()
	local z = v:GetEnemy()
	if not IsInjurable(v, z) then
		return
	end
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_pulse_nova_h.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		z,
		v
	)
	ParticleManager:ReleaseParticleIndex(A)
	z:EmitSound("Hero_Leshrac.Pulse_Nova_Strike")
	local B = self:GetAbilitySpecialValueFor("damage") + self.sectExp * self.damage_pct
	if self.tl4_bonus_factor > 0 then
		B = B + v:GetMaxHealth() * self.tl4_bonus_factor * 0.01
	end
	v:DealDamage(z, self:GetAbility(), B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	if self.tl6_count > 0 then
		self.tl6_counter = self.tl6_counter + 1
		if self.tl6_counter == self.tl6_count then
			self.tl6_counter = 0
			local R = self:GetParent():FindAbilityByName("leshrac_ult_s")
			if R ~= nil then
				R:SplitEarth()
			end
		end
	end
end
function Q.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
end
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
g.modifier_leshrac_talent_s = Q
g.modifier_leshrac_talent_4 = c()
local S = g.modifier_leshrac_talent_4
S.name = "modifier_leshrac_talent_4"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.tl4_health_pct = self:GetAbilityTalentValue("leshrac_talent_4", "health_pct")
end
function S.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE] = self.tl4_health_pct }
end
S = e(
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
	S
)
g.modifier_leshrac_talent_4 = S
g.leshrac_ult_s = c()
local T = g.leshrac_ult_s
T.name = "leshrac_ult_s"
d(T, p)
function T.prototype.OnSpellStart(self, F)
	local G = self:GetCaster()
	if not IsInjurable(G) then
		return
	end
	G:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
	self:GameTimer(0.4, function()
		self:SplitEarth()
	end)
end
function T.prototype.SplitEarth(self)
	local G = self:GetCaster()
	local z = G:GetEnemy()
	if not IsInjurable(G, z) then
		return
	end
	local B = self:GetSpecialValueFor("damage")
	local U = self:GetSpecialValueFor("stun_duration")
	local V = self:GetSpecialValueFor("level_duration")
	local W = G:GetModifierStackCount("modifier_leshrac_ult_s", G)
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf",
		PATTACH_ABSORIGIN,
		z,
		G
	)
	local X = 175 + W * 25
	ParticleManager:SetParticleControl(A, 1, Vector(X, X, X))
	ParticleManager:DestroyParticle(A, false)
	ParticleManager:ReleaseParticleIndex(A)
	z:EmitSound("Hero_Leshrac.Split_Earth")
	G:DealDamage(z, self, B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	AddStun(G, z, self, U + V * W)
end
function T.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_ult_s"
end
T = e({ r(nil) }, T)
g.leshrac_ult_s = T
g.modifier_leshrac_ult_s = c()
local Y = g.modifier_leshrac_ult_s
Y.name = "modifier_leshrac_ult_s"
d(Y, l)
function Y.prototype.GetAbilitySpecialValue(self) end
function Y.prototype.OnCreated(self, u)
	if IsServer() then
		self:UpdateSectLevel()
	end
end
function Y.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function Y.prototype.OnBattleStartBefore(self, u)
	self:UpdateSectLevel()
end
function Y.prototype.UpdateSectLevel(self)
	local Z = 0
	local w = self:GetParent():GetPlayerOwnerID()
	local x = PlayerData:getHero(w)
	if x then
		local _ = x:getAbilityData(false, true)
		if _ and _.sect_health then
			Z = _.sect_health.level
		end
	end
	self:SetStackCount(Z)
end
Y = e(
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
	Y
)
g.modifier_leshrac_ult_s = Y
g.leshrac_interact = c()
local a0 = g.leshrac_interact
a0.name = "leshrac_interact"
d(a0, o)
function a0.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_interact"
end
a0 = e(
	{
		q(
			nil,
			{
				ActiveTextureName = "leshrac_interact_active",
				InactiveTextureName = "leshrac_greater_lightning_storm",
				talent_ability1 = "leshrac_talent",
				talent_ability2 = "leshrac_talent_s",
				ult_ability1 = "leshrac_ult",
				ult_ability2 = "leshrac_ult_s",
			}
		),
	},
	a0
)
g.leshrac_interact = a0
g.modifier_leshrac_interact = c()
local a1 = g.modifier_leshrac_interact
a1.name = "modifier_leshrac_interact"
d(a1, l)
function a1.prototype.GetAbilitySpecialValue(self)
	self.void_buff = self:GetAbilitySpecialValueFor("void_buff")
	self.void_debuff = self:GetAbilitySpecialValueFor("void_debuff")
	self.ruination_buff = self:GetAbilitySpecialValueFor("ruination_buff")
	self.ruination_debuff = self:GetAbilitySpecialValueFor("ruination_debuff")
end
function a1.prototype.OnCreated(self, u) end
function a1.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE,
	}
end
function a1.prototype.EOM_GetModifierUltiPower(self)
	local a2 = self:GetAbility():GetToggleState()
	if not a2 then
		return self.void_buff
	else
		return -self.ruination_debuff
	end
end
function a1.prototype.EOM_GetModifierHealthBonusPercentage(self, u)
	local a2 = self:GetAbility():GetToggleState()
	if a2 then
		return self.ruination_buff
	end
	return -self.void_debuff
end
a1 = e(
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
	a1
)
g.modifier_leshrac_interact = a1
g.leshrac_talent_2 = c()
local a3 = g.leshrac_talent_2
a3.name = "leshrac_talent_2"
d(a3, i)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_talent_2"
end
a3 = e({ j(nil) }, a3)
g.leshrac_talent_2 = a3
g.modifier_leshrac_talent_2 = c()
local a4 = g.modifier_leshrac_talent_2
a4.name = "modifier_leshrac_talent_2"
d(a4, l)
function a4.prototype.GetAbilitySpecialValue(self)
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL }
end
function a4.prototype.EOM_GetModifierAbilityLifesteal(self, u)
	return self.heal_pct
end
a4 = e(
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
	a4
)
g.modifier_leshrac_talent_2 = a4
g.leshrac_shard = c()
local a5 = g.leshrac_shard
a5.name = "leshrac_shard"
d(a5, i)
function a5.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_shard"
end
a5 = e({ j(nil) }, a5)
g.leshrac_shard = a5
g.modifier_leshrac_shard = c()
local a6 = g.modifier_leshrac_shard
a6.name = "modifier_leshrac_shard"
d(a6, l)
function a6.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.thresold = self:GetAbilitySpecialValueFor("thresold")
	self.enable = true
end
function a6.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function a6.prototype.EOM_GetModifierMinHealth(self, u)
	if not self.enable then
		return
	end
	local a7 = u.target:GetMaxHealth() * self.thresold * 0.01
	if u.target:GetHealth() - u.damage <= a7 then
		self.enable = false
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_leshrac_shard_buff",
			{ duration = self.duration }
		)
		if u.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
			return a7
		end
	end
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
g.modifier_leshrac_shard = a6
g.modifier_leshrac_shard_buff = c()
local a8 = g.modifier_leshrac_shard_buff
a8.name = "modifier_leshrac_shard_buff"
d(a8, l)
function a8.prototype.GetAbilitySpecialValue(self)
	self.magic_pct = self:GetAbilitySpecialValueFor("magic_pct")
end
function a8.prototype.OnCreated(self, u)
	if IsServer() then
		local v = self:GetParent()
		v:EmitSound("Hero_Leshrac.Nihilism.Cast")
	end
end
function a8.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE] = self.magic_pct }
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
				GetEffectName = "particles/units/heroes/hero_leshrac/leshrac_scepter_nihilism_caster.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
				GetStatusEffectName = "particles/status_fx/status_effect_ghost.vpcfit",
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	a8
)
g.modifier_leshrac_shard_buff = a8
return g