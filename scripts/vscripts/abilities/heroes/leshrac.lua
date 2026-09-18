--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
		["149"] = 115,
		["150"] = 114,
		["151"] = 117,
		["152"] = 118,
		["153"] = 117,
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
		["166"] = 123,
		["167"] = 125,
		["168"] = 126,
		["169"] = 125,
		["170"] = 126,
		["171"] = 128,
		["172"] = 129,
		["173"] = 130,
		["174"] = 131,
		["177"] = 134,
		["178"] = 135,
		["179"] = 135,
		["180"] = 135,
		["181"] = 135,
		["182"] = 135,
		["183"] = 135,
		["184"] = 128,
		["185"] = 137,
		["186"] = 138,
		["187"] = 139,
		["188"] = 139,
		["189"] = 140,
		["190"] = 142,
		["191"] = 143,
		["192"] = 144,
		["193"] = 145,
		["195"] = 147,
		["196"] = 137,
		["197"] = 151,
		["198"] = 152,
		["199"] = 153,
		["200"] = 154,
		["201"] = 155,
		["202"] = 156,
		["203"] = 157,
		["206"] = 151,
		["207"] = 161,
		["208"] = 162,
		["209"] = 163,
		["211"] = 165,
		["214"] = 168,
		["215"] = 169,
		["216"] = 170,
		["219"] = 173,
		["220"] = 174,
		["221"] = 174,
		["222"] = 174,
		["223"] = 174,
		["224"] = 174,
		["225"] = 174,
		["226"] = 174,
		["227"] = 174,
		["228"] = 174,
		["229"] = 175,
		["230"] = 175,
		["231"] = 175,
		["232"] = 175,
		["233"] = 175,
		["234"] = 176,
		["235"] = 177,
		["236"] = 178,
		["237"] = 178,
		["238"] = 178,
		["239"] = 178,
		["240"] = 178,
		["241"] = 178,
		["242"] = 178,
		["243"] = 161,
		["244"] = 180,
		["245"] = 181,
		["246"] = 180,
		["247"] = 183,
		["248"] = 184,
		["249"] = 183,
		["250"] = 126,
		["251"] = 125,
		["252"] = 126,
		["254"] = 126,
		["255"] = 187,
		["256"] = 196,
		["257"] = 187,
		["258"] = 196,
		["259"] = 198,
		["260"] = 199,
		["261"] = 198,
		["262"] = 201,
		["263"] = 202,
		["264"] = 201,
		["265"] = 206,
		["266"] = 207,
		["269"] = 208,
		["272"] = 209,
		["275"] = 210,
		["278"] = 211,
		["279"] = 212,
		["281"] = 206,
		["282"] = 196,
		["283"] = 187,
		["284"] = 187,
		["285"] = 187,
		["286"] = 187,
		["287"] = 187,
		["288"] = 187,
		["289"] = 187,
		["290"] = 187,
		["291"] = 187,
		["292"] = 196,
		["294"] = 196,
		["295"] = 216,
		["296"] = 225,
		["297"] = 216,
		["298"] = 225,
		["299"] = 228,
		["300"] = 229,
		["301"] = 228,
		["302"] = 231,
		["303"] = 232,
		["304"] = 234,
		["305"] = 235,
		["307"] = 231,
		["308"] = 238,
		["309"] = 239,
		["310"] = 240,
		["311"] = 241,
		["312"] = 242,
		["315"] = 245,
		["316"] = 246,
		["317"] = 247,
		["318"] = 248,
		["321"] = 238,
		["322"] = 225,
		["323"] = 216,
		["324"] = 216,
		["325"] = 216,
		["326"] = 216,
		["327"] = 216,
		["328"] = 216,
		["329"] = 216,
		["330"] = 216,
		["331"] = 216,
		["332"] = 225,
		["334"] = 225,
		["335"] = 255,
		["336"] = 256,
		["337"] = 255,
		["338"] = 256,
		["339"] = 257,
		["340"] = 258,
		["341"] = 257,
		["342"] = 256,
		["343"] = 255,
		["344"] = 256,
		["346"] = 256,
		["347"] = 261,
		["348"] = 269,
		["349"] = 261,
		["350"] = 269,
		["352"] = 269,
		["353"] = 273,
		["354"] = 274,
		["355"] = 275,
		["356"] = 282,
		["357"] = 261,
		["358"] = 283,
		["359"] = 284,
		["360"] = 285,
		["361"] = 287,
		["362"] = 288,
		["363"] = 289,
		["364"] = 291,
		["365"] = 292,
		["366"] = 293,
		["367"] = 294,
		["368"] = 295,
		["369"] = 296,
		["371"] = 298,
		["372"] = 299,
		["375"] = 283,
		["376"] = 303,
		["377"] = 304,
		["378"] = 305,
		["379"] = 306,
		["380"] = 307,
		["381"] = 308,
		["382"] = 309,
		["383"] = 310,
		["384"] = 312,
		["385"] = 313,
		["386"] = 314,
		["390"] = 318,
		["391"] = 303,
		["392"] = 320,
		["393"] = 321,
		["394"] = 321,
		["395"] = 321,
		["396"] = 324,
		["397"] = 324,
		["398"] = 324,
		["399"] = 321,
		["400"] = 321,
		["401"] = 320,
		["402"] = 327,
		["403"] = 328,
		["404"] = 329,
		["405"] = 330,
		["406"] = 331,
		["407"] = 332,
		["408"] = 333,
		["409"] = 333,
		["410"] = 333,
		["411"] = 333,
		["412"] = 333,
		["413"] = 333,
		["414"] = 334,
		["417"] = 337,
		["419"] = 327,
		["420"] = 340,
		["421"] = 341,
		["422"] = 340,
		["423"] = 343,
		["424"] = 344,
		["425"] = 343,
		["426"] = 346,
		["427"] = 347,
		["428"] = 348,
		["431"] = 349,
		["434"] = 350,
		["435"] = 351,
		["438"] = 354,
		["439"] = 355,
		["440"] = 356,
		["441"] = 357,
		["444"] = 346,
		["445"] = 361,
		["446"] = 362,
		["447"] = 363,
		["448"] = 364,
		["451"] = 367,
		["452"] = 368,
		["453"] = 369,
		["454"] = 370,
		["455"] = 371,
		["456"] = 372,
		["458"] = 374,
		["459"] = 374,
		["460"] = 374,
		["461"] = 374,
		["462"] = 374,
		["463"] = 374,
		["464"] = 375,
		["465"] = 376,
		["466"] = 377,
		["467"] = 378,
		["468"] = 379,
		["470"] = 379,
		["474"] = 361,
		["475"] = 383,
		["476"] = 384,
		["477"] = 383,
		["478"] = 269,
		["479"] = 261,
		["480"] = 261,
		["481"] = 261,
		["482"] = 261,
		["483"] = 261,
		["484"] = 261,
		["485"] = 261,
		["486"] = 261,
		["487"] = 269,
		["489"] = 269,
		["490"] = 387,
		["491"] = 395,
		["492"] = 387,
		["493"] = 395,
		["494"] = 397,
		["495"] = 399,
		["496"] = 397,
		["497"] = 401,
		["498"] = 402,
		["499"] = 401,
		["500"] = 395,
		["501"] = 387,
		["502"] = 387,
		["503"] = 387,
		["504"] = 387,
		["505"] = 387,
		["506"] = 387,
		["507"] = 387,
		["508"] = 387,
		["509"] = 395,
		["511"] = 395,
		["512"] = 408,
		["513"] = 409,
		["514"] = 408,
		["515"] = 409,
		["516"] = 410,
		["517"] = 411,
		["518"] = 412,
		["521"] = 413,
		["522"] = 414,
		["523"] = 414,
		["524"] = 414,
		["525"] = 415,
		["526"] = 414,
		["527"] = 414,
		["528"] = 410,
		["529"] = 418,
		["530"] = 419,
		["531"] = 420,
		["532"] = 421,
		["535"] = 422,
		["536"] = 423,
		["537"] = 424,
		["538"] = 425,
		["539"] = 425,
		["540"] = 426,
		["541"] = 427,
		["542"] = 428,
		["543"] = 429,
		["544"] = 429,
		["545"] = 429,
		["546"] = 429,
		["547"] = 429,
		["548"] = 430,
		["549"] = 431,
		["550"] = 432,
		["551"] = 433,
		["552"] = 434,
		["553"] = 418,
		["554"] = 436,
		["555"] = 437,
		["556"] = 436,
		["557"] = 409,
		["558"] = 408,
		["559"] = 409,
		["561"] = 409,
		["562"] = 440,
		["563"] = 448,
		["564"] = 440,
		["565"] = 448,
		["566"] = 449,
		["567"] = 449,
		["568"] = 451,
		["569"] = 452,
		["570"] = 453,
		["572"] = 451,
		["573"] = 456,
		["574"] = 457,
		["575"] = 457,
		["576"] = 457,
		["577"] = 460,
		["578"] = 460,
		["579"] = 460,
		["580"] = 457,
		["581"] = 457,
		["582"] = 456,
		["583"] = 463,
		["584"] = 464,
		["585"] = 463,
		["586"] = 466,
		["587"] = 467,
		["588"] = 468,
		["589"] = 469,
		["590"] = 470,
		["591"] = 471,
		["592"] = 472,
		["593"] = 473,
		["596"] = 476,
		["597"] = 466,
		["598"] = 448,
		["599"] = 440,
		["600"] = 440,
		["601"] = 440,
		["602"] = 440,
		["603"] = 440,
		["604"] = 440,
		["605"] = 440,
		["606"] = 440,
		["607"] = 448,
		["609"] = 448,
		["611"] = 481,
		["612"] = 489,
		["613"] = 481,
		["614"] = 489,
		["615"] = 490,
		["616"] = 491,
		["617"] = 490,
		["618"] = 489,
		["619"] = 481,
		["620"] = 481,
		["621"] = 481,
		["622"] = 481,
		["623"] = 481,
		["624"] = 481,
		["625"] = 481,
		["626"] = 481,
		["627"] = 489,
		["629"] = 489,
		["630"] = 494,
		["631"] = 502,
		["632"] = 494,
		["633"] = 502,
		["634"] = 507,
		["635"] = 508,
		["636"] = 509,
		["637"] = 510,
		["638"] = 511,
		["639"] = 507,
		["640"] = 513,
		["641"] = 513,
		["642"] = 515,
		["643"] = 516,
		["644"] = 515,
		["645"] = 522,
		["646"] = 523,
		["647"] = 524,
		["648"] = 525,
		["650"] = 527,
		["652"] = 522,
		["653"] = 535,
		["654"] = 536,
		["655"] = 537,
		["656"] = 538,
		["658"] = 540,
		["659"] = 535,
		["660"] = 502,
		["661"] = 494,
		["662"] = 494,
		["663"] = 494,
		["664"] = 494,
		["665"] = 494,
		["666"] = 494,
		["667"] = 494,
		["668"] = 494,
		["669"] = 502,
		["671"] = 502,
		["673"] = 555,
		["674"] = 556,
		["675"] = 555,
		["676"] = 556,
		["677"] = 557,
		["678"] = 558,
		["679"] = 557,
		["680"] = 556,
		["681"] = 555,
		["682"] = 556,
		["684"] = 556,
		["685"] = 561,
		["686"] = 569,
		["687"] = 561,
		["688"] = 569,
		["689"] = 572,
		["690"] = 573,
		["691"] = 572,
		["692"] = 575,
		["693"] = 576,
		["694"] = 575,
		["695"] = 581,
		["696"] = 582,
		["697"] = 581,
		["698"] = 569,
		["699"] = 561,
		["700"] = 561,
		["701"] = 561,
		["702"] = 561,
		["703"] = 561,
		["704"] = 561,
		["705"] = 561,
		["706"] = 561,
		["707"] = 569,
		["709"] = 569,
		["711"] = 605,
		["712"] = 606,
		["713"] = 605,
		["714"] = 606,
		["715"] = 607,
		["716"] = 608,
		["717"] = 607,
		["718"] = 606,
		["719"] = 605,
		["720"] = 606,
		["722"] = 606,
		["723"] = 611,
		["724"] = 619,
		["725"] = 611,
		["726"] = 619,
		["727"] = 623,
		["728"] = 624,
		["729"] = 625,
		["730"] = 626,
		["731"] = 623,
		["732"] = 628,
		["733"] = 629,
		["734"] = 628,
		["735"] = 633,
		["736"] = 634,
		["739"] = 635,
		["740"] = 636,
		["741"] = 637,
		["742"] = 638,
		["743"] = 638,
		["744"] = 638,
		["745"] = 638,
		["746"] = 638,
		["747"] = 638,
		["748"] = 641,
		["749"] = 642,
		["752"] = 633,
		["753"] = 619,
		["754"] = 611,
		["755"] = 611,
		["756"] = 611,
		["757"] = 611,
		["758"] = 611,
		["759"] = 611,
		["760"] = 611,
		["761"] = 611,
		["762"] = 619,
		["764"] = 619,
		["765"] = 648,
		["766"] = 660,
		["767"] = 648,
		["768"] = 660,
		["769"] = 662,
		["770"] = 663,
		["771"] = 662,
		["772"] = 665,
		["773"] = 666,
		["774"] = 667,
		["775"] = 668,
		["777"] = 665,
		["778"] = 671,
		["779"] = 672,
		["780"] = 671,
		["781"] = 660,
		["782"] = 648,
		["783"] = 648,
		["784"] = 648,
		["785"] = 648,
		["786"] = 648,
		["787"] = 648,
		["788"] = 648,
		["789"] = 648,
		["790"] = 648,
		["791"] = 648,
		["792"] = 648,
		["793"] = 648,
		["794"] = 660,
		["796"] = 660,
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
	self.tl3_magic_bonus_pct = self:GetAbilityTalentValue("leshrac_talent_3", "magic_bonus_pct")
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
			if self.tl3_magic_bonus_pct > 0 then
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
	self.tl3_magic_bonus_pct = self:GetAbilityTalentValue("leshrac_talent_3", "magic_bonus_pct")
end
function C.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE] = self.tl3_magic_bonus_pct }
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
	G:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 2)
	G:AddNewModifier(G, self, "modifier_leshrac_ult_buff", self:GetBuffParam())
end
function E.prototype.GetBuffParam(self)
	self:GetSectUltiLevel()
	local H = PlayerData:getHero(self:GetCaster():GetPlayerOwnerID())
	local I = H and H:getHeroSelectedTalentCnt() or 0
	local J = self:GetSpecialValueFor("count") + I * self:GetSpecialValueFor("level_count")
	local K = self:GetTalentValue("leshrac_talent_3", "count")
	local L = self:GetTalentValue("leshrac_talent_3", "sect_lv")
	if K > 0 and self.sect_lv >= L then
		J = J + K
	end
	return { iCastCount = J }
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
function E.prototype.LightningStorm(self, B, M)
	if B == nil then
		B = self:GetLightningDamage()
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
		M and DamageFlags.DAMAGE_FLAG_NO_EXTRA or DamageFlags.DAMAGE_FLAG_NONE
	)
end
function E.prototype.GetLightningDamage(self)
	return self:GetSpecialValueFor("damage") + self:GetTalentValue("leshrac_talent_1", "damage_bonus")
end
function E.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_ult"
end
E = e({ r(nil) }, E)
g.leshrac_ult = E
g.modifier_leshrac_ult = c()
local N = g.modifier_leshrac_ult
N.name = "modifier_leshrac_ult"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.tl5_chance = self:GetAbilityTalentValue("leshrac_talent_5", "chance")
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() } }
end
function N.prototype.OnCustomTakeDamage(self, O)
	if not IsServer() or self.tl5_chance <= 0 or O.damage <= 0 then
		return
	end
	if O.damage_type ~= EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		return
	end
	if bit.band(O.damage_flags or 0, DamageFlags.DAMAGE_FLAG_NO_EXTRA) ~= 0 then
		return
	end
	if IsValid(O.ability) and O.ability:GetAbilityType() == ABILITY_TYPE_ULTIMATE then
		return
	end
	if self:PRD(self.tl5_chance, "tl5_chance") then
		self:GetAbility():LightningStorm(nil, true)
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
g.modifier_leshrac_ult = N
g.modifier_leshrac_ult_buff = c()
local P = g.modifier_leshrac_ult_buff
P.name = "modifier_leshrac_ult_buff"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbility():GetLightningDamage()
end
function P.prototype.OnCreated(self, u)
	if IsServer() then
		self.count = u.iCastCount
		self:StartIntervalThink(D)
	end
end
function P.prototype.OnIntervalThink(self)
	if IsServer() then
		local Q = self:GetAbility()
		if self.count <= 0 or not IsValid(Q) then
			self:Destroy()
			return
		end
		self.count = self.count - 1
		Q:LightningStorm(self.damage)
		if self.count <= 0 then
			self:Destroy()
		end
	end
end
P = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	P
)
g.modifier_leshrac_ult_buff = P
g.leshrac_talent_s = c()
local R = g.leshrac_talent_s
R.name = "leshrac_talent_s"
d(R, p)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_talent_s"
end
R = e({ r(nil) }, R)
g.leshrac_talent_s = R
g.modifier_leshrac_talent_s = c()
local S = g.modifier_leshrac_talent_s
S.name = "modifier_leshrac_talent_s"
d(S, l)
function S.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
	self.record = 0
	self.sectExp = 0
	self.tl6_counter = 0
end
function S.prototype.GetAbilitySpecialValue(self)
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
function S.prototype.IsHealthSectLvEnable(self)
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
function S.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function S.prototype.OnBattleStartBefore(self, u)
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
function S.prototype.OnBattleStart(self, u)
	self:StartIntervalThink(self.tick)
end
function S.prototype.OnBattleEnd(self, u)
	self.battling = false
end
function S.prototype.OnIntervalThink(self)
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
function S.prototype.PulseNova(self)
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
			local T = self:GetParent():FindAbilityByName("leshrac_ult_s")
			if T ~= nil then
				T:SplitEarth()
			end
		end
	end
end
function S.prototype.IsActivated(self)
	return self:GetAbility():GetToggleState()
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
g.modifier_leshrac_talent_s = S
g.modifier_leshrac_talent_4 = c()
local U = g.modifier_leshrac_talent_4
U.name = "modifier_leshrac_talent_4"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self)
	self.tl4_health_pct = self:GetAbilityTalentValue("leshrac_talent_4", "health_pct")
end
function U.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE] = self.tl4_health_pct }
end
U = e(
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
	U
)
g.modifier_leshrac_talent_4 = U
g.leshrac_ult_s = c()
local V = g.leshrac_ult_s
V.name = "leshrac_ult_s"
d(V, p)
function V.prototype.OnSpellStart(self, F)
	local G = self:GetCaster()
	if not IsInjurable(G) then
		return
	end
	G:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
	self:GameTimer(0.4, function()
		self:SplitEarth()
	end)
end
function V.prototype.SplitEarth(self)
	local G = self:GetCaster()
	local z = G:GetEnemy()
	if not IsInjurable(G, z) then
		return
	end
	local B = self:GetSpecialValueFor("damage")
	local W = self:GetSpecialValueFor("stun_duration")
	local X = self:GetSpecialValueFor("level_duration")
	local Y = PlayerData:getHero(G:GetPlayerOwnerID())
	local I = Y and Y:getHeroSelectedTalentCnt() or 0
	local Z = G:GetModifierStackCount("modifier_leshrac_ult_s", G)
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf",
		PATTACH_ABSORIGIN,
		z,
		G
	)
	local _ = 175 + Z * 25
	ParticleManager:SetParticleControl(A, 1, Vector(_, _, _))
	ParticleManager:DestroyParticle(A, false)
	ParticleManager:ReleaseParticleIndex(A)
	z:EmitSound("Hero_Leshrac.Split_Earth")
	G:DealDamage(z, self, B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	AddStun(G, z, self, W + X * I)
end
function V.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_ult_s"
end
V = e({ r(nil) }, V)
g.leshrac_ult_s = V
g.modifier_leshrac_ult_s = c()
local a0 = g.modifier_leshrac_ult_s
a0.name = "modifier_leshrac_ult_s"
d(a0, l)
function a0.prototype.GetAbilitySpecialValue(self) end
function a0.prototype.OnCreated(self, u)
	if IsServer() then
		self:UpdateSectLevel()
	end
end
function a0.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function a0.prototype.OnBattleStartBefore(self, u)
	self:UpdateSectLevel()
end
function a0.prototype.UpdateSectLevel(self)
	local a1 = 0
	local w = self:GetParent():GetPlayerOwnerID()
	local x = PlayerData:getHero(w)
	if x then
		local a2 = x:getAbilityData(false, true)
		if a2 and a2.sect_health then
			a1 = a2.sect_health.level
		end
	end
	self:SetStackCount(a1)
end
a0 = e(
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
	a0
)
g.modifier_leshrac_ult_s = a0
g.leshrac_interact = c()
local a3 = g.leshrac_interact
a3.name = "leshrac_interact"
d(a3, o)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_interact"
end
a3 = e(
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
	a3
)
g.leshrac_interact = a3
g.modifier_leshrac_interact = c()
local a4 = g.modifier_leshrac_interact
a4.name = "modifier_leshrac_interact"
d(a4, l)
function a4.prototype.GetAbilitySpecialValue(self)
	self.void_buff = self:GetAbilitySpecialValueFor("void_buff")
	self.void_debuff = self:GetAbilitySpecialValueFor("void_debuff")
	self.ruination_buff = self:GetAbilitySpecialValueFor("ruination_buff")
	self.ruination_debuff = self:GetAbilitySpecialValueFor("ruination_debuff")
end
function a4.prototype.OnCreated(self, u) end
function a4.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE,
	}
end
function a4.prototype.EOM_GetModifierUltiPower(self)
	local a5 = self:GetAbility():GetToggleState()
	if not a5 then
		return self.void_buff
	else
		return -self.ruination_debuff
	end
end
function a4.prototype.EOM_GetModifierHealthBonusPercentage(self, u)
	local a5 = self:GetAbility():GetToggleState()
	if a5 then
		return self.ruination_buff
	end
	return -self.void_debuff
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
g.modifier_leshrac_interact = a4
g.leshrac_talent_2 = c()
local a6 = g.leshrac_talent_2
a6.name = "leshrac_talent_2"
d(a6, i)
function a6.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_talent_2"
end
a6 = e({ j(nil) }, a6)
g.leshrac_talent_2 = a6
g.modifier_leshrac_talent_2 = c()
local a7 = g.modifier_leshrac_talent_2
a7.name = "modifier_leshrac_talent_2"
d(a7, l)
function a7.prototype.GetAbilitySpecialValue(self)
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
end
function a7.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL }
end
function a7.prototype.EOM_GetModifierAbilityLifesteal(self, u)
	return self.heal_pct
end
a7 = e(
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
	a7
)
g.modifier_leshrac_talent_2 = a7
g.leshrac_shard = c()
local a8 = g.leshrac_shard
a8.name = "leshrac_shard"
d(a8, i)
function a8.prototype.GetIntrinsicModifierName(self)
	return "modifier_leshrac_shard"
end
a8 = e({ j(nil) }, a8)
g.leshrac_shard = a8
g.modifier_leshrac_shard = c()
local a9 = g.modifier_leshrac_shard
a9.name = "modifier_leshrac_shard"
d(a9, l)
function a9.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.thresold = self:GetAbilitySpecialValueFor("thresold")
	self.enable = true
end
function a9.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function a9.prototype.EOM_GetModifierMinHealth(self, u)
	if not self.enable then
		return
	end
	local aa = u.target:GetMaxHealth() * self.thresold * 0.01
	if u.target:GetHealth() - u.damage <= aa then
		self.enable = false
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_leshrac_shard_buff",
			{ duration = self.duration }
		)
		if u.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
			return aa
		end
	end
end
a9 = e(
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
	a9
)
g.modifier_leshrac_shard = a9
g.modifier_leshrac_shard_buff = c()
local ab = g.modifier_leshrac_shard_buff
ab.name = "modifier_leshrac_shard_buff"
d(ab, l)
function ab.prototype.GetAbilitySpecialValue(self)
	self.magic_pct = self:GetAbilitySpecialValueFor("magic_pct")
end
function ab.prototype.OnCreated(self, u)
	if IsServer() then
		local v = self:GetParent()
		v:EmitSound("Hero_Leshrac.Nihilism.Cast")
	end
end
function ab.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE] = self.magic_pct }
end
ab = e(
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
	ab
)
g.modifier_leshrac_shard_buff = ab
return g