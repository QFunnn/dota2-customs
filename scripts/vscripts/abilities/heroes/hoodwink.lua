--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/hoodwink"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 266,
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["18"] = 270,
		["19"] = 271,
		["20"] = 272,
		["21"] = 273,
		["24"] = 6,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["28"] = 8,
		["29"] = 9,
		["30"] = 8,
		["31"] = 7,
		["32"] = 6,
		["33"] = 7,
		["35"] = 7,
		["36"] = 12,
		["37"] = 20,
		["38"] = 12,
		["39"] = 20,
		["41"] = 20,
		["42"] = 27,
		["43"] = 33,
		["44"] = 35,
		["45"] = 12,
		["46"] = 37,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 42,
		["51"] = 44,
		["52"] = 46,
		["53"] = 47,
		["54"] = 37,
		["55"] = 51,
		["56"] = 52,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["61"] = 51,
		["62"] = 58,
		["63"] = 59,
		["64"] = 59,
		["65"] = 59,
		["66"] = 62,
		["67"] = 62,
		["68"] = 62,
		["69"] = 59,
		["70"] = 59,
		["71"] = 58,
		["72"] = 65,
		["73"] = 66,
		["74"] = 67,
		["75"] = 69,
		["76"] = 70,
		["77"] = 71,
		["78"] = 72,
		["79"] = 73,
		["80"] = 74,
		["84"] = 80,
		["85"] = 81,
		["86"] = 82,
		["87"] = 83,
		["88"] = 84,
		["89"] = 85,
		["90"] = 86,
		["91"] = 87,
		["92"] = 88,
		["93"] = 89,
		["94"] = 90,
		["100"] = 65,
		["101"] = 97,
		["102"] = 98,
		["103"] = 99,
		["105"] = 97,
		["106"] = 102,
		["107"] = 103,
		["108"] = 104,
		["109"] = 105,
		["110"] = 106,
		["111"] = 107,
		["112"] = 108,
		["113"] = 108,
		["114"] = 108,
		["115"] = 108,
		["116"] = 109,
		["117"] = 110,
		["119"] = 108,
		["120"] = 108,
		["123"] = 102,
		["124"] = 116,
		["125"] = 117,
		["126"] = 118,
		["127"] = 119,
		["128"] = 120,
		["129"] = 121,
		["132"] = 122,
		["135"] = 116,
		["136"] = 127,
		["137"] = 128,
		["138"] = 129,
		["139"] = 130,
		["142"] = 131,
		["143"] = 131,
		["144"] = 131,
		["145"] = 132,
		["148"] = 133,
		["149"] = 134,
		["150"] = 135,
		["151"] = 135,
		["152"] = 135,
		["153"] = 135,
		["154"] = 135,
		["155"] = 135,
		["156"] = 151,
		["157"] = 152,
		["158"] = 152,
		["159"] = 152,
		["160"] = 152,
		["161"] = 152,
		["162"] = 152,
		["163"] = 152,
		["164"] = 153,
		["165"] = 154,
		["166"] = 154,
		["167"] = 154,
		["168"] = 154,
		["169"] = 154,
		["170"] = 154,
		["171"] = 154,
		["172"] = 155,
		["173"] = 156,
		["174"] = 156,
		["175"] = 156,
		["176"] = 156,
		["177"] = 156,
		["178"] = 156,
		["179"] = 156,
		["181"] = 160,
		["182"] = 160,
		["183"] = 160,
		["184"] = 160,
		["185"] = 160,
		["186"] = 160,
		["187"] = 163,
		["188"] = 164,
		["189"] = 165,
		["191"] = 167,
		["192"] = 168,
		["193"] = 168,
		["194"] = 168,
		["195"] = 168,
		["196"] = 168,
		["197"] = 168,
		["199"] = 172,
		["200"] = 172,
		["201"] = 172,
		["202"] = 172,
		["203"] = 172,
		["204"] = 172,
		["206"] = 131,
		["207"] = 131,
		["208"] = 177,
		["209"] = 178,
		["210"] = 178,
		["211"] = 178,
		["212"] = 178,
		["213"] = 178,
		["214"] = 178,
		["215"] = 178,
		["216"] = 182,
		["217"] = 183,
		["218"] = 184,
		["219"] = 185,
		["220"] = 186,
		["221"] = 187,
		["222"] = 187,
		["223"] = 187,
		["224"] = 187,
		["225"] = 187,
		["226"] = 187,
		["227"] = 187,
		["228"] = 187,
		["229"] = 187,
		["230"] = 188,
		["231"] = 188,
		["232"] = 188,
		["233"] = 188,
		["234"] = 188,
		["235"] = 188,
		["236"] = 188,
		["237"] = 188,
		["238"] = 188,
		["239"] = 189,
		["240"] = 189,
		["241"] = 189,
		["242"] = 189,
		["243"] = 189,
		["244"] = 191,
		["245"] = 191,
		["246"] = 191,
		["247"] = 192,
		["248"] = 193,
		["249"] = 193,
		["250"] = 193,
		["251"] = 194,
		["252"] = 194,
		["253"] = 194,
		["254"] = 194,
		["255"] = 194,
		["256"] = 195,
		["257"] = 196,
		["258"] = 197,
		["260"] = 199,
		["261"] = 200,
		["263"] = 202,
		["264"] = 203,
		["265"] = 204,
		["266"] = 191,
		["267"] = 191,
		["268"] = 127,
		["269"] = 207,
		["270"] = 208,
		["271"] = 209,
		["272"] = 210,
		["275"] = 211,
		["276"] = 212,
		["277"] = 213,
		["278"] = 214,
		["279"] = 215,
		["280"] = 216,
		["281"] = 216,
		["282"] = 216,
		["283"] = 216,
		["284"] = 216,
		["285"] = 217,
		["286"] = 217,
		["287"] = 217,
		["288"] = 217,
		["289"] = 217,
		["290"] = 219,
		["291"] = 219,
		["292"] = 219,
		["293"] = 219,
		["294"] = 219,
		["295"] = 219,
		["296"] = 219,
		["297"] = 227,
		["298"] = 228,
		["299"] = 229,
		["301"] = 231,
		["304"] = 232,
		["305"] = 233,
		["306"] = 234,
		["307"] = 234,
		["308"] = 234,
		["309"] = 234,
		["310"] = 234,
		["311"] = 235,
		["312"] = 236,
		["313"] = 237,
		["314"] = 219,
		["315"] = 219,
		["316"] = 207,
		["317"] = 20,
		["318"] = 12,
		["319"] = 12,
		["320"] = 12,
		["321"] = 12,
		["322"] = 12,
		["323"] = 12,
		["324"] = 12,
		["325"] = 12,
		["326"] = 20,
		["328"] = 20,
		["329"] = 266,
		["330"] = 267,
		["331"] = 276,
		["332"] = 286,
		["333"] = 276,
		["334"] = 286,
		["335"] = 286,
		["336"] = 276,
		["337"] = 276,
		["338"] = 276,
		["339"] = 276,
		["340"] = 276,
		["341"] = 276,
		["342"] = 276,
		["343"] = 276,
		["344"] = 276,
		["345"] = 276,
		["346"] = 286,
		["348"] = 286,
		["349"] = 288,
		["350"] = 296,
		["351"] = 288,
		["352"] = 296,
		["353"] = 298,
		["354"] = 299,
		["355"] = 298,
		["356"] = 303,
		["357"] = 304,
		["358"] = 303,
		["359"] = 296,
		["360"] = 288,
		["361"] = 288,
		["362"] = 288,
		["363"] = 288,
		["364"] = 288,
		["365"] = 288,
		["366"] = 288,
		["367"] = 288,
		["368"] = 296,
		["370"] = 296,
		["371"] = 309,
		["372"] = 318,
		["373"] = 309,
		["374"] = 318,
		["375"] = 320,
		["376"] = 321,
		["377"] = 322,
		["378"] = 320,
		["379"] = 324,
		["380"] = 325,
		["381"] = 326,
		["383"] = 324,
		["384"] = 329,
		["385"] = 330,
		["386"] = 331,
		["388"] = 329,
		["389"] = 334,
		["390"] = 337,
		["391"] = 334,
		["392"] = 339,
		["393"] = 340,
		["394"] = 339,
		["395"] = 342,
		["396"] = 343,
		["397"] = 344,
		["399"] = 345,
		["400"] = 345,
		["401"] = 346,
		["402"] = 345,
		["405"] = 348,
		["406"] = 342,
		["407"] = 318,
		["408"] = 309,
		["409"] = 309,
		["410"] = 309,
		["411"] = 309,
		["412"] = 309,
		["413"] = 309,
		["414"] = 309,
		["415"] = 309,
		["416"] = 309,
		["417"] = 318,
		["419"] = 318,
		["421"] = 353,
		["422"] = 354,
		["423"] = 353,
		["424"] = 354,
		["426"] = 354,
		["427"] = 356,
		["428"] = 353,
		["429"] = 357,
		["430"] = 358,
		["431"] = 359,
		["433"] = 357,
		["434"] = 362,
		["435"] = 363,
		["436"] = 364,
		["437"] = 366,
		["440"] = 368,
		["441"] = 369,
		["442"] = 371,
		["443"] = 373,
		["444"] = 376,
		["445"] = 377,
		["446"] = 378,
		["447"] = 379,
		["448"] = 379,
		["449"] = 379,
		["450"] = 380,
		["453"] = 381,
		["454"] = 382,
		["455"] = 383,
		["456"] = 384,
		["457"] = 385,
		["458"] = 386,
		["459"] = 387,
		["460"] = 387,
		["461"] = 387,
		["462"] = 387,
		["463"] = 388,
		["464"] = 389,
		["466"] = 387,
		["467"] = 387,
		["470"] = 394,
		["471"] = 395,
		["472"] = 396,
		["473"] = 397,
		["474"] = 398,
		["475"] = 398,
		["476"] = 398,
		["477"] = 398,
		["478"] = 398,
		["479"] = 398,
		["480"] = 398,
		["481"] = 398,
		["482"] = 406,
		["483"] = 407,
		["486"] = 408,
		["487"] = 409,
		["488"] = 410,
		["489"] = 410,
		["490"] = 410,
		["491"] = 410,
		["492"] = 410,
		["493"] = 410,
		["494"] = 411,
		["496"] = 413,
		["497"] = 414,
		["498"] = 415,
		["500"] = 417,
		["501"] = 418,
		["502"] = 422,
		["504"] = 398,
		["505"] = 398,
		["506"] = 379,
		["507"] = 379,
		["508"] = 427,
		["509"] = 362,
		["510"] = 431,
		["511"] = 432,
		["512"] = 431,
		["513"] = 435,
		["514"] = 435,
		["515"] = 435,
		["517"] = 436,
		["520"] = 437,
		["521"] = 438,
		["522"] = 439,
		["525"] = 440,
		["526"] = 441,
		["527"] = 442,
		["528"] = 443,
		["529"] = 444,
		["530"] = 445,
		["531"] = 446,
		["532"] = 446,
		["533"] = 446,
		["534"] = 446,
		["535"] = 446,
		["536"] = 447,
		["537"] = 447,
		["538"] = 447,
		["539"] = 447,
		["540"] = 447,
		["541"] = 447,
		["542"] = 447,
		["543"] = 447,
		["544"] = 455,
		["545"] = 456,
		["548"] = 457,
		["549"] = 458,
		["550"] = 447,
		["551"] = 447,
		["552"] = 435,
		["553"] = 354,
		["554"] = 353,
		["555"] = 354,
		["557"] = 354,
		["558"] = 463,
		["559"] = 471,
		["560"] = 463,
		["561"] = 471,
		["562"] = 474,
		["563"] = 475,
		["564"] = 476,
		["565"] = 474,
		["566"] = 478,
		["567"] = 479,
		["568"] = 478,
		["569"] = 481,
		["570"] = 482,
		["571"] = 481,
		["572"] = 486,
		["573"] = 487,
		["574"] = 486,
		["575"] = 489,
		["576"] = 490,
		["577"] = 489,
		["578"] = 492,
		["579"] = 494,
		["580"] = 495,
		["582"] = 498,
		["583"] = 499,
		["585"] = 501,
		["586"] = 502,
		["588"] = 504,
		["589"] = 505,
		["590"] = 492,
		["591"] = 507,
		["592"] = 508,
		["593"] = 509,
		["594"] = 510,
		["595"] = 511,
		["596"] = 512,
		["597"] = 513,
		["598"] = 514,
		["599"] = 515,
		["600"] = 516,
		["601"] = 517,
		["604"] = 520,
		["607"] = 507,
		["608"] = 471,
		["609"] = 463,
		["610"] = 463,
		["611"] = 463,
		["612"] = 463,
		["613"] = 463,
		["614"] = 463,
		["615"] = 463,
		["616"] = 463,
		["617"] = 471,
		["619"] = 471,
		["620"] = 526,
		["621"] = 535,
		["622"] = 526,
		["623"] = 535,
		["624"] = 536,
		["625"] = 537,
		["626"] = 538,
		["627"] = 539,
		["628"] = 540,
		["629"] = 541,
		["630"] = 541,
		["631"] = 541,
		["632"] = 541,
		["633"] = 541,
		["634"] = 542,
		["635"] = 542,
		["636"] = 542,
		["637"] = 542,
		["638"] = 542,
		["639"] = 542,
		["640"] = 542,
		["641"] = 542,
		["643"] = 536,
		["644"] = 545,
		["645"] = 546,
		["646"] = 547,
		["648"] = 545,
		["649"] = 535,
		["650"] = 526,
		["651"] = 526,
		["652"] = 526,
		["653"] = 526,
		["654"] = 526,
		["655"] = 526,
		["656"] = 526,
		["657"] = 526,
		["658"] = 526,
		["659"] = 535,
		["661"] = 535,
		["662"] = 552,
		["663"] = 560,
		["664"] = 552,
		["665"] = 560,
		["666"] = 561,
		["667"] = 562,
		["668"] = 561,
		["669"] = 560,
		["670"] = 552,
		["671"] = 552,
		["672"] = 552,
		["673"] = 552,
		["674"] = 552,
		["675"] = 552,
		["676"] = 552,
		["677"] = 552,
		["678"] = 560,
		["680"] = 560,
		["681"] = 628,
		["682"] = 636,
		["683"] = 628,
		["684"] = 636,
		["685"] = 641,
		["686"] = 642,
		["687"] = 643,
		["688"] = 641,
		["689"] = 645,
		["690"] = 646,
		["691"] = 647,
		["692"] = 648,
		["693"] = 649,
		["695"] = 645,
		["696"] = 652,
		["697"] = 653,
		["698"] = 654,
		["699"] = 655,
		["700"] = 656,
		["701"] = 657,
		["704"] = 652,
		["705"] = 661,
		["706"] = 662,
		["707"] = 661,
		["708"] = 664,
		["709"] = 665,
		["710"] = 664,
		["711"] = 667,
		["712"] = 668,
		["713"] = 667,
		["714"] = 670,
		["715"] = 670,
		["716"] = 636,
		["717"] = 628,
		["718"] = 628,
		["719"] = 628,
		["720"] = 628,
		["721"] = 628,
		["722"] = 628,
		["723"] = 628,
		["724"] = 628,
		["725"] = 636,
		["727"] = 636,
	}
)
local g = {}
local h, i, j
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
local q = require("abilities.ability_ai")
local r = q.BaseAbilityAI
local s = q.registerAbilityAI
function h(self, t)
	local u = i * math.cos(t * 2 * math.pi)
	local v = j * math.sin(t * 2 * math.pi)
	return { x = u, y = v }
end
g.hoodwink_talent = c()
local w = g.hoodwink_talent
w.name = "hoodwink_talent"
d(w, l)
function w.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_talent"
end
w = e({ m(nil) }, w)
g.hoodwink_talent = w
g.modifier_hoodwink_talent = c()
local x = g.modifier_hoodwink_talent
x.name = "modifier_hoodwink_talent"
d(x, o)
function x.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.tick = 0.1
	self.s_enable = false
	self.debuff = ""
end
function x.prototype.GetAbilitySpecialValue(self)
	self.tl5_bonus_damage = self:GetAbilityTalentValue("hoodwink_talent_5", "bonus_damage")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.damage_level = self:GetAbilitySpecialValueFor("damage_level") + self.tl5_bonus_damage
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("hoodwink_talent_1", "cd_reduce")
	self.tl3_threshold = self:GetAbilityTalentValue("hoodwink_talent_3", "threshold")
	self.stack = self:GetAbilityTalentValue("hoodwink_shard", "stack")
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		self.record = 0
		self.tl3_record = 0
		self.maxLv = 0
	end
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function x.prototype.OnBattleStartBefore(self, y)
	self.record = 0
	self.maxLv = 0
	local z = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if z then
		local A = z:getAbilityData()
		for B, C in pairs(A) do
			if self.maxLv < C.level then
				self.maxLv = C.level
			end
		end
	end
	if self.stack > 0 then
		local D = self:GetParent():GetPlayerOwnerID()
		local z = PlayerData:getHero(D)
		if z then
			local E = 0
			local F = z:getAbilityData()
			for G, C in pairs(F) do
				if tostring(G) == "sect_poison" or tostring(G) == "sect_ice" or tostring(G) == "sect_injury" then
					if C.exp > E then
						self.debuff = tostring(G)
						E = C.exp
					end
				end
			end
		end
	end
end
function x.prototype.OnBattleStart(self, y)
	if IsServer() then
		self:StartIntervalThink(self.tick)
	end
end
function x.prototype.OnCustomTakeDamage(self, H)
	if self.tl3_threshold > 0 then
		self.tl3_record = self.tl3_record + H.damage
		if self.tl3_record >= self.tl3_threshold then
			local I = math.floor(self.tl3_record / self.tl3_threshold)
			self.tl3_record = self.tl3_record % self.tl3_threshold
			ForWithInterval(0.1, I, function()
				if IsValid(self) then
					self:HuntersBoomerang()
				end
			end)
		end
	end
end
function x.prototype.OnIntervalThink(self)
	if IsServer() then
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.record = 0
			if self:GetParent():PassivesDisabled() then
				return
			end
			self:HuntersBoomerang()
		end
	end
end
function x.prototype.HuntersBoomerang(self)
	local J = self:GetParent()
	local K = J:GetEnemy()
	if not IsInjurable(K, J) then
		return
	end
	GameTimer(0.4, function()
		if not (IsValid(self) and IsInjurable(K, J)) then
			return
		end
		K:EmitSound("Hero_Hoodwink.Boomerang.Target")
		local L = self.damage + self.maxLv * self.damage_level
		J:DealDamage(K, self:GetAbility(), L, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		if self.debuff == "sect_poison" then
			AddPoison(J, K, self.stack, "hoodwink_talent", "Ability")
		elseif self.debuff == "sect_injury" then
			AddInjury(J, K, self.stack, "hoodwink_talent", "Ability")
		elseif self.debuff == "sect_ice" then
			AddIce(J, K, self.stack, "hoodwink_talent", "Ability")
		end
		K:AddNewModifier(J, self:GetAbility(), "modifier_hoodwink_talent_debuff_Particle", { duration = self.duration })
		if self.s_enable then
			self.s_enable = false
			self:BushWhack()
		end
		if self.tl5_bonus_damage > 0 then
			K:AddNewModifier(J, self:GetAbility(), "modifier_hoodwink_talent_debuff_ind", { duration = self.duration })
		else
			K:AddNewModifier(J, self:GetAbility(), "modifier_hoodwink_talent_debuff", { duration = self.duration })
		end
	end)
	J:EmitSound("Hero_Hoodwink.Boomerang.Cast")
	local M = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{ origin = J:GetAbsOrigin(), model = "models/development/invisiblebox.vmdl" }
	)
	M:EmitSound("Hero_Hoodwink.Boomerang.Projectile")
	local N = 0
	local O = J:GetForwardVector()
	local P = J:GetAbsOrigin() + O * i + Vector(0, 0, 96)
	local Q = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_hoodwink/hoodwink_boomerang.vpcf",
		PATTACH_CUSTOMORIGIN,
		J
	)
	ParticleManager:SetParticleControlEnt(Q, 0, J, PATTACH_POINT_FOLLOW, "attach_hitloc", J:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(Q, 1, M, PATTACH_ABSORIGIN_FOLLOW, nil, M:GetAbsOrigin(), false)
	ParticleManager:SetParticleControl(Q, 2, Vector(2100, 0, 0))
	GameTimer(FRAME_TIME, function()
		N = N + FRAME_TIME
		local R = h(nil, N / 0.8)
		local u = R.x
		local v = R.y
		local S = RotatePosition(P, VectorAngles(O * -1), P + Vector(u, v, 0))
		M:SetAbsOrigin(S)
		if N < 0.8 then
			return FRAME_TIME
		end
		if IsValid(J) then
			EmitSoundOnLocationWithCaster(S, "Hero_Hoodwink.Boomerang.Return", J)
		end
		M:StopSound("Hero_Hoodwink.Boomerang.Projectile")
		UTIL_Remove(M)
		ParticleManager:DestroyParticle(Q, false)
	end)
end
function x.prototype.BushWhack(self)
	local J = self:GetParent()
	local K = J:GetEnemy()
	if not IsInjurable(K, J) then
		return
	end
	local O = K:GetAbsOrigin() - J:GetAbsOrigin()
	O.z = 0
	O = O:Normalized()
	J:EmitSound("Hero_Hoodwink.Bushwhack.Cast")
	local T = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_projectile.vpcf",
		PATTACH_ABSORIGIN,
		J
	)
	ParticleManager:SetParticleControl(T, 1, K:GetAbsOrigin())
	ParticleManager:SetParticleControl(T, 2, Vector(PROJECTILE_SPEED_FAST, 0, 0))
	Projectile:CreateLinearProjectile({
		hCaster = J,
		vSpawnOrigin = J:GetAbsOrigin(),
		vDirection = O,
		flDistance = 600,
		flRadius = 0,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileDestroy = function(U)
			if T then
				ParticleManager:DestroyParticle(T, false)
			end
			if not (IsValid(self) and IsInjurable(J, K)) then
				return
			end
			local Q = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_hoodwink/hoodwink_bushwhack.vpcf",
				PATTACH_CUSTOMORIGIN,
				J
			)
			ParticleManager:SetParticleControl(Q, 0, U)
			ParticleManager:SetParticleControl(Q, 1, Vector(300, 0, 0))
			ParticleManager:ReleaseParticleIndex(Q)
			K:EmitSound("Hero_Hoodwink.Bushwhack.Impact")
			K:EmitSound("Hero_Hoodwink.Bushwhack.Target")
		end,
	})
end
x = e(
	{
		p(
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
	x
)
g.modifier_hoodwink_talent = x
i = 350
j = 175
g.modifier_hoodwink_talent_debuff_Particle = c()
local V = g.modifier_hoodwink_talent_debuff_Particle
V.name = "modifier_hoodwink_talent_debuff_Particle"
d(V, o)
V = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_hoodwink/hoodwink_hunters_mark.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
			}
		),
	},
	V
)
g.modifier_hoodwink_talent_debuff_Particle = V
g.modifier_hoodwink_talent_debuff = c()
local W = g.modifier_hoodwink_talent_debuff
W.name = "modifier_hoodwink_talent_debuff"
d(W, o)
function W.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function W.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = self.damage_pct }
end
W = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	W
)
g.modifier_hoodwink_talent_debuff = W
g.modifier_hoodwink_talent_debuff_ind = c()
local X = g.modifier_hoodwink_talent_debuff_ind
X.name = "modifier_hoodwink_talent_debuff_ind"
d(X, o)
function X.prototype.IndependentMaxCount(self)
	local Y = self:GetAbilityTalentValue("hoodwink_talent_5", "max")
	return Y
end
function X.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function X.prototype.OnRefresh(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function X.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function X.prototype.EOM_GetModifierIncomingDamagePercentage(self, y)
	local I = self:GetStackCount()
	local Z = 0
	do
		local _ = 0
		while _ < I do
			Z = SubtractionMultiplicationPercentage(Z, self.damage_pct)
			_ = _ + 1
		end
	end
	return Z
end
X = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	X
)
g.modifier_hoodwink_talent_debuff_ind = X
g.hoodwink_ult = c()
local a0 = g.hoodwink_ult
a0.name = "hoodwink_ult"
d(a0, r)
function a0.prototype.____constructor(self, ...)
	r.prototype.____constructor(self, ...)
	self.scarRecord = 0
end
function a0.prototype.Spawn(self)
	if IsServer() then
		self.lvMax = 0
	end
end
function a0.prototype.OnSpellStart(self)
	local a1 = self:GetCaster()
	local K = a1:GetEnemy()
	if not IsInjurable(a1, K) then
		return
	end
	local a2 = self:GetSpecialValueFor("delay") - self:GetTalentValue("hoodwink_talent_8", "daley_reduce")
	local a3 = self:GetSpecialValueFor("lv_factor") + self:GetTalentValue("hoodwink_talent_6", "bonus_factor")
	local a4 = self:GetSpecialValueFor("base_damage") + self:GetTalentValue("hoodwink_talent_8", "bonus_damage")
	local a5 = self:GetTalentValue("hoodwink_talent_4", "count")
	local a6 = self:GetTalentValue("hoodwink_talent_9", "broken_duration")
	local a7 = self:GetTalentValue("hoodwink_talent_9", "bonus_factor")
	local L = a4 + self.lvMax * a3
	self:GameTimer(a2, function()
		if not (IsValid(self) and IsInjurable(a1, K)) then
			return
		end
		local O = K:GetAbsOrigin() - a1:GetAbsOrigin()
		O.z = 0
		O = O:Normalized()
		if a5 > 0 then
			local a8 = a1:FindModifierByName("modifier_hoodwink_talent")
			if IsValid(a8) then
				ForWithInterval(0.1, a5, function()
					if IsValid(a8) then
						a8:HuntersBoomerang()
					end
				end)
			end
		end
		local S = a1:GetAbsOrigin()
		EmitSoundOnLocationWithCaster(S, "Hero_Hoodwink.Sharpshooter.Cast", a1)
		EmitSoundOnLocationWithCaster(S, "Hero_Hoodwink.Sharpshooter.Projectile", a1)
		a1:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
		Projectile:CreateLinearProjectile({
			EffectName = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf",
			hCaster = a1,
			vSpawnOrigin = a1:GetAttachmentPosition("attach_attack1"),
			vDirection = O,
			flDistance = 500,
			flRadius = 250,
			iMoveSpeed = PROJECTILE_SPEED_FAST,
			OnProjectileDestroy = function()
				if not (IsValid(self) and IsInjurable(a1, K)) then
					return
				end
				K:EmitSound("Hero_Hoodwink.Sharpshooter.Target")
				if self:HasTalent("hoodwink_talent_7") and self.scarRecord < BUFF_VALUE.ScarMaxCount then
					AddScar(a1, K, self, K:GetMaxHealth() * BUFF_VALUE.ScarHealthPct * 0.01)
					self.scarRecord = self.scarRecord + 1
				end
				local a9 = GetScar(K)
				if a9 > 0 then
					L = L + 0.01 * a7 * a9
				end
				a1:DealDamage(K, self, L, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				if a6 > 0 then
					AddBroken(a1, K, self, a6)
				end
			end,
		})
	end)
	a1:AddNewModifier(a1, self, "modifier_hoodwink_ult_cast", { duration = a2 })
end
function a0.prototype.GetIntrinsicModifierName(self)
	return "modifier_hoodwink_ult"
end
function a0.prototype.GreevilShot(self, aa)
	if aa == nil then
		aa = 100
	end
	if not IsServer() then
		return
	end
	local a1 = self:GetCaster()
	local K = a1:GetEnemy()
	if not (IsValid(self) and IsInjurable(a1, K)) then
		return
	end
	local a3 = self:GetSpecialValueFor("lv_factor") + self:GetTalentValue("hoodwink_talent_6", "bonus_factor")
	local a4 = self:GetSpecialValueFor("base_damage") + self:GetTalentValue("hoodwink_talent_8", "bonus_damage")
	local L = (a4 + self.lvMax * a3) * aa * 0.01
	local O = K:GetAbsOrigin() - a1:GetAbsOrigin()
	O.z = 0
	O = O:Normalized()
	EmitSoundOnLocationWithCaster(a1:GetAbsOrigin(), "Hero_Hoodwink.Sharpshooter.Projectile", a1)
	Projectile:CreateLinearProjectile({
		EffectName = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf",
		hCaster = a1,
		vSpawnOrigin = a1:GetAttachmentPosition("attach_attack1"),
		vDirection = O,
		flDistance = 500,
		flRadius = 250,
		iMoveSpeed = PROJECTILE_SPEED_FAST,
		OnProjectileDestroy = function()
			if not (IsValid(self) and IsInjurable(a1, K)) then
				return
			end
			K:EmitSound("Hero_Hoodwink.Sharpshooter.Target")
			a1:DealDamage(K, self, L, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		end,
	})
end
a0 = e({ s(nil) }, a0)
g.hoodwink_ult = a0
g.modifier_hoodwink_ult = c()
local ab = g.modifier_hoodwink_ult
ab.name = "modifier_hoodwink_ult"
d(ab, o)
function ab.prototype.GetAbilitySpecialValue(self)
	self.g_chance = self:GetAbilityTalentValue("hoodwink_shard", "chance")
	self.g_damage_pct = self:GetAbilityTalentValue("hoodwink_shard", "damage_pct")
end
function ab.prototype.OnCreated(self, y)
	self:GetMaxSectLv()
end
function ab.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function ab.prototype.OnBattleStartBefore(self, y)
	self:GetMaxSectLv()
end
function ab.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function ab.prototype.EOM_GetModifierAvoidDamage(self, y)
	if self.g_chance <= 0 or y.damage <= 0 then
		return 0
	end
	if y.damage_type ~= EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		return 0
	end
	if not self:PRD(self.g_chance, "hoodwink_shard") then
		return 0
	end
	self:GetAbility():GreevilShot(self.g_damage_pct)
	return 1
end
function ab.prototype.GetMaxSectLv(self)
	if IsServer() then
		local D = self:GetParent():GetPlayerOwnerID()
		local z = PlayerData:getHero(D)
		local ac = self:GetAbility()
		if z then
			local F = z:getAbilityData()
			local E = 0
			for G, C in pairs(F) do
				if E < C.level then
					E = C.level
				end
			end
			ac.lvMax = E
		end
	end
end
ab = e(
	{
		p(
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
g.modifier_hoodwink_ult = ab
g.modifier_hoodwink_ult_cast = c()
local ad = g.modifier_hoodwink_ult_cast
ad.name = "modifier_hoodwink_ult_cast"
d(ad, o)
function ad.prototype.OnCreated(self, y)
	if IsServer() then
		local J = self:GetParent()
		J:EmitSound("Hero_Hoodwink.Sharpshooter.Channel")
		local Q = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			J
		)
		ParticleManager:SetParticleControl(Q, 1, J:GetAbsOrigin())
		self:AddParticle(Q, false, false, -1, false, false)
	end
end
function ad.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Hoodwink.Sharpshooter.Channel")
	end
end
ad = e(
	{
		p(
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
	ad
)
g.modifier_hoodwink_ult_cast = ad
g.modifier_hoodwink_ult_broken = c()
local ae = g.modifier_hoodwink_ult_broken
ae.name = "modifier_hoodwink_ult_broken"
d(ae, o)
function ae.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end
ae = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	ae
)
g.modifier_hoodwink_ult_broken = ae
g.modifier_scar = c()
local af = g.modifier_scar
af.name = "modifier_scar"
d(af, o)
function af.prototype.GetAbilitySpecialValue(self)
	self.maxhealth_lose = BUFF_VALUE.ScarHealthPct
	self.max_stack = BUFF_VALUE.ScarMaxCount
end
function af.prototype.OnCreated(self, y)
	if IsServer() then
		self.max_health = self.parent:GetMaxHealth()
		self:IncrementStackCount()
		self.total_reduce = self.max_health * 0.01 * self.maxhealth_lose
	end
end
function af.prototype.OnRefresh(self, y)
	if IsServer() then
		if self:GetStackCount() < 10 then
			self:IncrementStackCount()
			self.max_health = self.parent:GetMaxHealth()
			self.total_reduce = self.total_reduce + self.max_health * 0.01 * self.maxhealth_lose
		end
	end
end
function af.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function af.prototype.EOM_GetModifierHealthBonus(self, y)
	return -self.total_reduce
end
function af.prototype.GetTotalReduce(self)
	return self.total_reduce
end
function af.prototype.OnDestroy(self) end
af = e(
	{
		p(
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
	af
)
g.modifier_scar = af
return g