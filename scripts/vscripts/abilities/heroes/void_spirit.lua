--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/void_spirit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__ArrayIndexOf
local h = b.__TS__ArraySplice
local i = b.__TS__ArrayIncludes
local j = b.__TS__ArrayFilter
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 2,
		["17"] = 2,
		["18"] = 2,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["23"] = 8,
		["24"] = 9,
		["25"] = 8,
		["26"] = 9,
		["27"] = 10,
		["28"] = 11,
		["29"] = 10,
		["30"] = 9,
		["31"] = 8,
		["32"] = 9,
		["34"] = 9,
		["35"] = 14,
		["36"] = 15,
		["37"] = 16,
		["38"] = 17,
		["39"] = 18,
		["40"] = 19,
		["41"] = 20,
		["42"] = 21,
		["43"] = 22,
		["44"] = 23,
		["45"] = 24,
		["49"] = 29,
		["50"] = 37,
		["51"] = 29,
		["52"] = 37,
		["54"] = 37,
		["55"] = 45,
		["56"] = 47,
		["57"] = 54,
		["58"] = 55,
		["59"] = 56,
		["60"] = 57,
		["61"] = 29,
		["62"] = 58,
		["63"] = 59,
		["64"] = 60,
		["65"] = 61,
		["66"] = 62,
		["67"] = 63,
		["68"] = 65,
		["69"] = 67,
		["70"] = 69,
		["71"] = 70,
		["72"] = 72,
		["73"] = 73,
		["74"] = 58,
		["75"] = 75,
		["76"] = 76,
		["78"] = 75,
		["79"] = 79,
		["80"] = 80,
		["81"] = 81,
		["82"] = 82,
		["83"] = 83,
		["84"] = 84,
		["87"] = 85,
		["90"] = 79,
		["91"] = 89,
		["92"] = 90,
		["93"] = 91,
		["94"] = 91,
		["95"] = 91,
		["96"] = 92,
		["97"] = 93,
		["98"] = 91,
		["99"] = 91,
		["100"] = 95,
		["102"] = 89,
		["103"] = 98,
		["104"] = 99,
		["105"] = 99,
		["106"] = 99,
		["107"] = 102,
		["108"] = 102,
		["109"] = 102,
		["110"] = 99,
		["111"] = 103,
		["112"] = 103,
		["113"] = 103,
		["114"] = 99,
		["115"] = 104,
		["116"] = 104,
		["117"] = 104,
		["118"] = 99,
		["119"] = 99,
		["120"] = 98,
		["121"] = 107,
		["122"] = 108,
		["123"] = 107,
		["124"] = 113,
		["125"] = 114,
		["126"] = 115,
		["127"] = 116,
		["128"] = 113,
		["129"] = 118,
		["130"] = 119,
		["131"] = 120,
		["132"] = 118,
		["133"] = 122,
		["134"] = 123,
		["135"] = 124,
		["136"] = 122,
		["137"] = 126,
		["138"] = 127,
		["141"] = 128,
		["142"] = 129,
		["143"] = 130,
		["144"] = 131,
		["145"] = 132,
		["146"] = 133,
		["147"] = 134,
		["148"] = 135,
		["149"] = 135,
		["150"] = 135,
		["151"] = 135,
		["152"] = 136,
		["155"] = 137,
		["156"] = 135,
		["157"] = 135,
		["161"] = 142,
		["162"] = 143,
		["163"] = 144,
		["164"] = 145,
		["165"] = 146,
		["166"] = 146,
		["167"] = 146,
		["168"] = 146,
		["169"] = 147,
		["170"] = 147,
		["171"] = 147,
		["172"] = 147,
		["173"] = 147,
		["174"] = 147,
		["178"] = 126,
		["179"] = 155,
		["180"] = 156,
		["183"] = 157,
		["184"] = 158,
		["185"] = 159,
		["186"] = 160,
		["187"] = 161,
		["188"] = 162,
		["189"] = 162,
		["190"] = 162,
		["191"] = 162,
		["192"] = 163,
		["195"] = 164,
		["196"] = 162,
		["197"] = 162,
		["200"] = 168,
		["201"] = 169,
		["202"] = 170,
		["203"] = 171,
		["204"] = 172,
		["205"] = 172,
		["206"] = 172,
		["207"] = 172,
		["208"] = 172,
		["209"] = 172,
		["213"] = 155,
		["214"] = 180,
		["215"] = 181,
		["216"] = 182,
		["217"] = 183,
		["219"] = 185,
		["220"] = 185,
		["221"] = 185,
		["222"] = 186,
		["225"] = 187,
		["226"] = 188,
		["229"] = 189,
		["230"] = 190,
		["231"] = 191,
		["232"] = 192,
		["233"] = 193,
		["234"] = 194,
		["235"] = 195,
		["236"] = 195,
		["237"] = 195,
		["238"] = 195,
		["239"] = 195,
		["240"] = 195,
		["241"] = 196,
		["242"] = 197,
		["243"] = 197,
		["244"] = 197,
		["245"] = 197,
		["246"] = 197,
		["247"] = 197,
		["248"] = 198,
		["249"] = 199,
		["250"] = 199,
		["251"] = 201,
		["252"] = 202,
		["253"] = 205,
		["254"] = 205,
		["255"] = 205,
		["256"] = 205,
		["257"] = 205,
		["258"] = 205,
		["259"] = 205,
		["260"] = 206,
		["261"] = 206,
		["262"] = 206,
		["263"] = 207,
		["266"] = 208,
		["267"] = 209,
		["268"] = 210,
		["269"] = 211,
		["271"] = 213,
		["274"] = 214,
		["275"] = 215,
		["276"] = 215,
		["277"] = 215,
		["278"] = 215,
		["279"] = 215,
		["280"] = 215,
		["281"] = 215,
		["282"] = 215,
		["283"] = 215,
		["284"] = 217,
		["285"] = 217,
		["286"] = 217,
		["287"] = 218,
		["288"] = 221,
		["289"] = 206,
		["290"] = 206,
		["291"] = 185,
		["292"] = 185,
		["293"] = 180,
		["294"] = 37,
		["295"] = 29,
		["296"] = 29,
		["297"] = 29,
		["298"] = 29,
		["299"] = 29,
		["300"] = 29,
		["301"] = 29,
		["302"] = 29,
		["303"] = 37,
		["305"] = 37,
		["307"] = 228,
		["308"] = 238,
		["309"] = 228,
		["310"] = 238,
		["311"] = 239,
		["312"] = 240,
		["313"] = 241,
		["314"] = 242,
		["315"] = 243,
		["318"] = 239,
		["319"] = 247,
		["320"] = 248,
		["321"] = 249,
		["322"] = 250,
		["323"] = 251,
		["326"] = 247,
		["327"] = 255,
		["328"] = 256,
		["329"] = 255,
		["330"] = 260,
		["331"] = 261,
		["332"] = 260,
		["333"] = 238,
		["334"] = 228,
		["335"] = 228,
		["336"] = 228,
		["337"] = 228,
		["338"] = 228,
		["339"] = 228,
		["340"] = 228,
		["341"] = 228,
		["342"] = 228,
		["343"] = 238,
		["345"] = 238,
		["347"] = 266,
		["348"] = 276,
		["349"] = 266,
		["350"] = 276,
		["351"] = 277,
		["352"] = 278,
		["353"] = 279,
		["354"] = 280,
		["355"] = 281,
		["358"] = 277,
		["359"] = 285,
		["360"] = 286,
		["361"] = 287,
		["362"] = 288,
		["363"] = 289,
		["366"] = 285,
		["367"] = 293,
		["368"] = 294,
		["369"] = 293,
		["370"] = 298,
		["371"] = 299,
		["372"] = 298,
		["373"] = 276,
		["374"] = 266,
		["375"] = 266,
		["376"] = 266,
		["377"] = 266,
		["378"] = 266,
		["379"] = 266,
		["380"] = 266,
		["381"] = 266,
		["382"] = 266,
		["383"] = 276,
		["385"] = 276,
		["387"] = 306,
		["388"] = 307,
		["389"] = 308,
		["390"] = 309,
		["391"] = 308,
		["392"] = 309,
		["393"] = 310,
		["394"] = 311,
		["395"] = 312,
		["396"] = 315,
		["397"] = 316,
		["398"] = 317,
		["399"] = 310,
		["400"] = 321,
		["401"] = 322,
		["402"] = 323,
		["403"] = 324,
		["406"] = 325,
		["407"] = 325,
		["408"] = 325,
		["409"] = 325,
		["410"] = 325,
		["411"] = 325,
		["412"] = 326,
		["413"] = 327,
		["414"] = 327,
		["415"] = 327,
		["416"] = 327,
		["417"] = 327,
		["418"] = 328,
		["419"] = 330,
		["420"] = 330,
		["421"] = 330,
		["422"] = 331,
		["425"] = 332,
		["426"] = 332,
		["427"] = 332,
		["428"] = 335,
		["429"] = 336,
		["430"] = 336,
		["431"] = 336,
		["432"] = 336,
		["433"] = 336,
		["434"] = 336,
		["435"] = 336,
		["436"] = 336,
		["437"] = 336,
		["438"] = 337,
		["439"] = 337,
		["440"] = 337,
		["441"] = 337,
		["442"] = 337,
		["443"] = 337,
		["444"] = 337,
		["445"] = 337,
		["446"] = 337,
		["447"] = 338,
		["448"] = 339,
		["449"] = 339,
		["450"] = 339,
		["451"] = 339,
		["452"] = 339,
		["453"] = 339,
		["454"] = 339,
		["455"] = 339,
		["456"] = 339,
		["457"] = 330,
		["458"] = 330,
		["459"] = 321,
		["460"] = 309,
		["461"] = 308,
		["462"] = 309,
		["464"] = 309,
		["465"] = 353,
		["466"] = 361,
		["467"] = 353,
		["468"] = 361,
		["469"] = 361,
		["470"] = 353,
		["471"] = 353,
		["472"] = 353,
		["473"] = 353,
		["474"] = 353,
		["475"] = 353,
		["476"] = 353,
		["477"] = 353,
		["478"] = 361,
		["480"] = 361,
		["482"] = 366,
		["483"] = 367,
		["484"] = 366,
		["485"] = 367,
		["486"] = 368,
		["487"] = 369,
		["488"] = 368,
		["489"] = 367,
		["490"] = 366,
		["491"] = 367,
		["493"] = 367,
		["494"] = 372,
		["495"] = 380,
		["496"] = 372,
		["497"] = 380,
		["498"] = 382,
		["499"] = 383,
		["500"] = 382,
		["501"] = 385,
		["502"] = 386,
		["503"] = 387,
		["505"] = 385,
		["506"] = 390,
		["507"] = 391,
		["508"] = 392,
		["510"] = 390,
		["511"] = 395,
		["512"] = 396,
		["513"] = 397,
		["514"] = 397,
		["515"] = 396,
		["516"] = 395,
		["517"] = 400,
		["518"] = 401,
		["519"] = 400,
		["520"] = 403,
		["521"] = 404,
		["522"] = 405,
		["523"] = 406,
		["524"] = 407,
		["525"] = 408,
		["526"] = 409,
		["527"] = 410,
		["528"] = 411,
		["529"] = 412,
		["530"] = 412,
		["531"] = 412,
		["532"] = 412,
		["533"] = 413,
		["534"] = 414,
		["540"] = 403,
		["541"] = 380,
		["542"] = 372,
		["543"] = 372,
		["544"] = 372,
		["545"] = 372,
		["546"] = 372,
		["547"] = 372,
		["548"] = 372,
		["549"] = 372,
		["550"] = 380,
		["552"] = 380,
		["554"] = 425,
		["555"] = 426,
		["556"] = 425,
		["557"] = 426,
		["558"] = 427,
		["559"] = 428,
		["560"] = 427,
		["561"] = 426,
		["562"] = 425,
		["563"] = 426,
		["565"] = 426,
		["566"] = 431,
		["567"] = 439,
		["568"] = 431,
		["569"] = 439,
		["570"] = 441,
		["571"] = 442,
		["572"] = 441,
		["573"] = 444,
		["574"] = 445,
		["575"] = 446,
		["577"] = 444,
		["578"] = 449,
		["579"] = 450,
		["580"] = 451,
		["582"] = 449,
		["583"] = 454,
		["584"] = 455,
		["585"] = 456,
		["586"] = 456,
		["587"] = 455,
		["588"] = 454,
		["589"] = 459,
		["590"] = 460,
		["591"] = 459,
		["592"] = 462,
		["593"] = 463,
		["594"] = 464,
		["595"] = 465,
		["596"] = 466,
		["597"] = 467,
		["598"] = 468,
		["599"] = 469,
		["600"] = 470,
		["601"] = 471,
		["602"] = 471,
		["603"] = 471,
		["604"] = 471,
		["605"] = 472,
		["606"] = 473,
		["612"] = 462,
		["613"] = 439,
		["614"] = 431,
		["615"] = 431,
		["616"] = 431,
		["617"] = 431,
		["618"] = 431,
		["619"] = 431,
		["620"] = 431,
		["621"] = 431,
		["622"] = 439,
		["624"] = 439,
		["625"] = 485,
		["626"] = 486,
		["627"] = 485,
		["628"] = 486,
		["629"] = 487,
		["630"] = 488,
		["631"] = 487,
		["632"] = 486,
		["633"] = 485,
		["634"] = 486,
		["636"] = 486,
		["637"] = 491,
		["638"] = 499,
		["639"] = 491,
		["640"] = 499,
		["641"] = 500,
		["642"] = 501,
		["643"] = 502,
		["644"] = 503,
		["645"] = 504,
		["646"] = 505,
		["647"] = 506,
		["648"] = 507,
		["649"] = 507,
		["650"] = 507,
		["651"] = 508,
		["652"] = 507,
		["653"] = 507,
		["654"] = 510,
		["655"] = 510,
		["656"] = 510,
		["657"] = 511,
		["658"] = 510,
		["659"] = 510,
		["660"] = 513,
		["661"] = 513,
		["662"] = 513,
		["663"] = 514,
		["664"] = 513,
		["665"] = 513,
		["666"] = 516,
		["667"] = 517,
		["672"] = 500,
		["673"] = 499,
		["674"] = 491,
		["675"] = 491,
		["676"] = 491,
		["677"] = 491,
		["678"] = 491,
		["679"] = 491,
		["680"] = 491,
		["681"] = 491,
		["682"] = 499,
		["684"] = 499,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseAbility
local o = m.registerAbility
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = require("abilities.ability_ai")
local t = s.BaseAbilityAI
local u = s.registerAbilityAI
l.void_spirit_talent = c()
local v = l.void_spirit_talent
v.name = "void_spirit_talent"
d(v, n)
function v.prototype.GetIntrinsicModifierName(self)
	return "modifier_void_spirit_talent"
end
v = e({ o(nil) }, v)
l.void_spirit_talent = v
local w = {}
local x = {}
local y = {}
for z, A in pairs(KeyValues.HeroTalentKv) do
	if A and A.Hero == "void_spirit" then
		if A.RequiredLevel == 5 then
			w[#w + 1] = z
		elseif A.RequiredLevel == 10 then
			x[#x + 1] = z
		elseif A.RequiredLevel == 15 then
			y[#y + 1] = z
		end
	end
end
l.modifier_void_spirit_talent = c()
local B = l.modifier_void_spirit_talent
B.name = "modifier_void_spirit_talent"
d(B, q)
function B.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.tl3_record = 0
	self.tl4_record = 0
	self.battle_end = true
	self.record = 0
	self.tick = 0.1
	self.particleList = {}
end
function B.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.injury_gain = self:GetAbilitySpecialValueFor("injury_gain")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
	self.tl3_injury_count = self:GetAbilityTalentValue("void_spirit_talent_3", "injury_count")
	self.tl4_shield_bonus = self:GetAbilityTalentValue("void_spirit_talent_4", "shield_bonus")
	self.tl5_count_pct = self:GetAbilityTalentValue("void_spirit_talent_5", "count_pct")
	self.tl5_duration = self:GetAbilityTalentValue("void_spirit_talent_5", "duration")
	self.tl6_count_pct = self:GetAbilityTalentValue("void_spirit_talent_6", "count_pct")
	self.tl6_duration = self:GetAbilityTalentValue("void_spirit_talent_6", "duration")
end
function B.prototype.OnCreated(self, C)
	if IsServer() then
	end
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.record = 0
			if self:GetParent():PassivesDisabled() then
				return
			end
			self:AstralStep()
		end
	end
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		f(self.particleList, function(D, E)
			ParticleManager:DestroyParticle(E, true)
			ParticleManager:ReleaseParticleIndex(E)
		end)
		self.particleList = {}
	end
end
function B.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 },
	}
end
function B.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS_PERCENTAGE_AFTER_EVENT] = -self.tl5_count_pct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE_AFTER_EVENT] = -self.tl6_count_pct,
	}
end
function B.prototype.OnBattleStartBefore(self, C)
	self.tl3_record = 0
	self.tl4_record = 0
	self.battle_end = false
end
function B.prototype.OnBattleStart(self, C)
	self.record = 0
	self:StartIntervalThink(self.tick)
end
function B.prototype.OnBattleEnd(self, C)
	self.battle_end = true
	self:StartIntervalThink(-1)
end
function B.prototype.OnInjuryGained(self, C)
	if self.battle_end then
		return
	end
	if self.tl3_injury_count > 0 then
		self.tl3_record = self.tl3_record + C.iStackCount
		if self.tl3_record >= self.tl3_injury_count then
			local F = math.floor(self.tl3_record / self.tl3_injury_count)
			self.tl3_record = self.tl3_record % self.tl3_injury_count
			local G = self:GetParent():FindAbilityByName("void_spirit_ult")
			if IsValid(G) then
				ForWithInterval(self.tick, F, function(H)
					if not IsValid(G) then
						return
					end
					G:ResonancePulse()
				end)
			end
		end
	end
	if self.tl5_count_pct > 0 then
		local I = Round(C.iStackCount * self.tl5_count_pct * 0.01)
		if I > 0 then
			local J = self:GetParent():GetEnemy()
			if IsInjurable(self:GetParent(), J) then
				J:AddNewModifier(
					self:GetParent(),
					self:GetAbility(),
					"modifier_void_spirit_talent_5",
					{ duration = self.tl5_duration, add_value = I }
				)
			end
		end
	end
end
function B.prototype.OnShieldGained(self, C)
	if self.battle_end then
		return
	end
	if self.tl4_shield_bonus > 0 then
		self.tl4_record = self.tl4_record + C.iStackCount
		if self.tl4_record >= self.tl4_shield_bonus then
			local F = math.floor(self.tl4_record / self.tl4_shield_bonus)
			self.tl4_record = self.tl4_record % self.tl4_shield_bonus
			ForWithInterval(self.tick, F, function(H)
				if not IsValid(self) then
					return
				end
				self:AstralStep()
			end)
		end
	end
	if self.tl6_count_pct > 0 then
		local I = Round(C.iStackCount * self.tl6_count_pct * 0.01)
		if I > 0 then
			if IsInjurable(self:GetParent()) then
				self:GetParent():AddNewModifier(
					self:GetParent(),
					self:GetAbility(),
					"modifier_void_spirit_talent_6",
					{ duration = self.tl6_duration, add_value = I }
				)
			end
		end
	end
end
function B.prototype.AstralStep(self)
	local K = self:GetParent()
	if not K:HasModifier("modifier_void_spirit_ult_cast") then
		K:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	end
	GameTimer(0.1, function()
		if not IsValid(self) then
			return
		end
		local J = K:GetEnemy()
		if not IsInjurable(K, J) then
			return
		end
		local L = J:GetAbsOrigin()
		local M = L - K:GetAbsOrigin()
		M.z = 0
		M = M:Normalized()
		local N = L + M * 200
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_void_spirit/astral_step/astral_step.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			K
		)
		ParticleManager:SetParticleControlTransform(O, 1, N, VectorAngles(M))
		local P = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf",
			PATTACH_CUSTOMORIGIN,
			J,
			K
		)
		ParticleManager:SetParticleControlTransform(P, 0, J:GetAttachmentPosition("attach_hitloc"), VectorAngles(M))
		local Q = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			J,
			K
		)
		local R = self.particleList
		R[#R + 1] = Q
		local G = self:GetAbility()
		K:EmitSound("Hero_VoidSpirit.AstralStep.Start")
		AddInjury(K, J, self.injury_gain, G:GetName(), "Ability")
		GameTimer(self.delay, function()
			if not IsValid(self) then
				return
			end
			local S = g(self.particleList, Q)
			if S ~= -1 then
				h(self.particleList, S, 1)
				ParticleManager:DestroyParticle(Q, false)
			end
			if not IsInjurable(K, J) then
				return
			end
			local O = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf",
				PATTACH_CUSTOMORIGIN,
				J,
				K
			)
			ParticleManager:SetParticleControlEnt(O, 0, J, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
			local T = self.base_damage
			local U = PlayerData:getHero(K:GetPlayerOwnerID())
			local V = T + (U and U:getLevel() or 0) * self.damage_bonus
			J:EmitSound("Hero_VoidSpirit.AstralStep.End")
			K:DealChaosDamage(J, G, V)
		end)
	end)
end
B = e(
	{
		r(
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
l.modifier_void_spirit_talent = B
l.modifier_void_spirit_talent_5 = c()
local W = l.modifier_void_spirit_talent_5
W.name = "modifier_void_spirit_talent_5"
d(W, q)
function W.prototype.OnCreated(self, C)
	if IsServer() then
		local F = C.add_value or 0
		if F > 0 then
			self:IncrementStackCount(F)
		end
	end
end
function W.prototype.OnRefresh(self, C)
	if IsServer() then
		local F = C.add_value or 0
		if F > 0 then
			self:IncrementStackCount(F)
		end
	end
end
function W.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function W.prototype.EOM_GetModifierInjuryPermanent(self, C)
	return self:GetStackCount()
end
W = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				IsIndependent = true,
			}
		),
	},
	W
)
l.modifier_void_spirit_talent_5 = W
l.modifier_void_spirit_talent_6 = c()
local X = l.modifier_void_spirit_talent_6
X.name = "modifier_void_spirit_talent_6"
d(X, q)
function X.prototype.OnCreated(self, C)
	if IsServer() then
		local F = C.add_value or 0
		if F > 0 then
			self:IncrementStackCount(F)
		end
	end
end
function X.prototype.OnRefresh(self, C)
	if IsServer() then
		local F = C.add_value or 0
		if F > 0 then
			self:IncrementStackCount(F)
		end
	end
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function X.prototype.EOM_GetModifierShieldPermanent(self, C)
	return self:GetStackCount()
end
X = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
				IsIndependent = true,
			}
		),
	},
	X
)
l.modifier_void_spirit_talent_6 = X
local Y = 500
local Z = 1200
l.void_spirit_ult = c()
local _ = l.void_spirit_ult
_.name = "void_spirit_ult"
d(_, t)
function _.prototype.OnSpellStart(self)
	local a0 = self:GetCaster()
	a0:AddNewModifier(a0, self, "modifier_void_spirit_ult_cast", { duration = 0.57 })
	a0:RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
	a0:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self:ResonancePulse()
end
function _.prototype.ResonancePulse(self)
	local a0 = self:GetCaster()
	local J = a0:GetEnemy()
	if not IsInjurable(J, a0) then
		return
	end
	AddShield(a0, self:GetSpecialValueFor("shield_gain"), self:GetAbilityName(), "Ability")
	local O = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		a0
	)
	ParticleManager:SetParticleControl(O, 1, Vector(Z, Z, Z))
	a0:EmitSound("Hero_VoidSpirit.Pulse.Cast")
	self:GameTimer(350 / Z, function()
		if not IsInjurable(J, a0) then
			return
		end
		local a1 = self:GetSpecialValueFor("damage")
		local a2 = PlayerData:getHero(a0:GetPlayerOwnerID())
		local V = a1 + (a2 and a2:getLevel() or 0) * self:GetSpecialValueFor("damage_bonus")
		O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf",
			PATTACH_CUSTOMORIGIN,
			J,
			a0
		)
		ParticleManager:SetParticleControlEnt(O, 0, J, PATTACH_POINT_FOLLOW, "attach_hitloc", J:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(O, 1, a0, PATTACH_ABSORIGIN_FOLLOW, nil, a0:GetAbsOrigin(), true)
		J:EmitSound("Hero_VoidSpirit.Pulse.Target")
		DamageSystem:dealDamage({
			attacker = a0,
			target = J,
			ability = self,
			damage = V,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
	end)
end
_ = e({ u(nil) }, _)
l.void_spirit_ult = _
l.modifier_void_spirit_ult_cast = c()
local a3 = l.modifier_void_spirit_ult_cast
a3.name = "modifier_void_spirit_ult_cast"
d(a3, q)
a3 = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	a3
)
l.modifier_void_spirit_ult_cast = a3
l.void_spirit_talent_1 = c()
local a4 = l.void_spirit_talent_1
a4.name = "void_spirit_talent_1"
d(a4, t)
function a4.prototype.GetIntrinsicModifierName(self)
	return "modifier_void_spirit_talent_1"
end
a4 = e({ u(nil) }, a4)
l.void_spirit_talent_1 = a4
l.modifier_void_spirit_talent_1 = c()
local a5 = l.modifier_void_spirit_talent_1
a5.name = "modifier_void_spirit_talent_1"
d(a5, q)
function a5.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor")
end
function a5.prototype.OnCreated(self, C)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function a5.prototype.OnIntervalThink(self)
	if IsServer() then
		self:CheckedEffect()
	end
end
function a5.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self:GetParent(), -1 } }
end
function a5.prototype.OnTalentLearn(self, C)
	self:CheckedEffect()
end
function a5.prototype.CheckedEffect(self)
	if IsServer() then
		local a6 = self:GetParent():GetPlayerOwnerID()
		local a7 = PlayerData:getHero(a6)
		if a7 then
			self:StartIntervalThink(-1)
			local a8 = a7.heroTalentBranch
			if a8 then
				if self.factor > 0 then
					local a9 = j(x, function(D, aa)
						return not i(a8, aa)
					end)
					if #a9 == 1 then
						a7:learnTalent(a9[1])
					end
				end
			end
		end
	end
end
a5 = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	a5
)
l.modifier_void_spirit_talent_1 = a5
l.void_spirit_talent_2 = c()
local ab = l.void_spirit_talent_2
ab.name = "void_spirit_talent_2"
d(ab, t)
function ab.prototype.GetIntrinsicModifierName(self)
	return "modifier_void_spirit_talent_2"
end
ab = e({ u(nil) }, ab)
l.void_spirit_talent_2 = ab
l.modifier_void_spirit_talent_2 = c()
local ac = l.modifier_void_spirit_talent_2
ac.name = "modifier_void_spirit_talent_2"
d(ac, q)
function ac.prototype.GetAbilitySpecialValue(self)
	self.factor = self:GetAbilitySpecialValueFor("factor")
end
function ac.prototype.OnCreated(self, C)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function ac.prototype.OnIntervalThink(self)
	if IsServer() then
		self:CheckedEffect()
	end
end
function ac.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TALENT_LEARN] = { self:GetParent(), -1 } }
end
function ac.prototype.OnTalentLearn(self, C)
	self:CheckedEffect()
end
function ac.prototype.CheckedEffect(self)
	if IsServer() then
		local a6 = self:GetParent():GetPlayerOwnerID()
		local a7 = PlayerData:getHero(a6)
		if a7 then
			self:StartIntervalThink(-1)
			local a8 = a7.heroTalentBranch
			if a8 then
				if self.factor > 0 then
					local a9 = j(y, function(D, aa)
						return not i(a8, aa)
					end)
					if #a9 == 1 then
						a7:learnTalent(a9[1])
					end
				end
			end
		end
	end
end
ac = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	ac
)
l.modifier_void_spirit_talent_2 = ac
l.void_spirit_shard = c()
local ad = l.void_spirit_shard
ad.name = "void_spirit_shard"
d(ad, t)
function ad.prototype.GetIntrinsicModifierName(self)
	return "modifier_void_spirit_shard"
end
ad = e({ u(nil) }, ad)
l.void_spirit_shard = ad
l.modifier_void_spirit_shard = c()
local ae = l.modifier_void_spirit_shard
ae.name = "modifier_void_spirit_shard"
d(ae, q)
function ae.prototype.OnCreated(self, C)
	if IsServer() then
		local a6 = self:GetParent():GetPlayerOwnerID()
		local af = PlayerData:getplayerData(a6)
		if af then
			local a7 = af.hero
			if a7 then
				f(w, function(D, ag)
					a7:learnTalent(ag)
				end)
				f(x, function(D, ag)
					a7:learnTalent(ag)
				end)
				f(y, function(D, ag)
					a7:learnTalent(ag)
				end)
				if af.talentPoint > 0 then
					PlayerData:clearTalentSelection(a6)
				end
			end
		end
	end
end
ae = e(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_NORMAL,
			}
		),
	},
	ae
)
l.modifier_void_spirit_shard = ae
return l