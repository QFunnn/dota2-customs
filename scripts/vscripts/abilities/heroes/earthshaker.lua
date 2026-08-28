--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/earthshaker"
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
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 10,
		["24"] = 9,
		["25"] = 8,
		["26"] = 7,
		["27"] = 8,
		["29"] = 8,
		["30"] = 14,
		["31"] = 22,
		["32"] = 14,
		["33"] = 22,
		["35"] = 22,
		["36"] = 28,
		["37"] = 30,
		["38"] = 14,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 37,
		["45"] = 38,
		["46"] = 31,
		["47"] = 40,
		["48"] = 41,
		["49"] = 40,
		["50"] = 45,
		["51"] = 46,
		["52"] = 45,
		["53"] = 48,
		["54"] = 49,
		["55"] = 49,
		["56"] = 51,
		["57"] = 51,
		["58"] = 51,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 49,
		["63"] = 49,
		["64"] = 48,
		["65"] = 57,
		["66"] = 57,
		["67"] = 59,
		["68"] = 59,
		["69"] = 61,
		["70"] = 62,
		["71"] = 62,
		["72"] = 62,
		["73"] = 62,
		["74"] = 61,
		["75"] = 64,
		["76"] = 65,
		["77"] = 66,
		["78"] = 66,
		["79"] = 66,
		["80"] = 66,
		["82"] = 64,
		["83"] = 69,
		["84"] = 70,
		["85"] = 71,
		["86"] = 72,
		["87"] = 73,
		["88"] = 74,
		["90"] = 76,
		["92"] = 69,
		["93"] = 79,
		["94"] = 80,
		["95"] = 81,
		["98"] = 82,
		["99"] = 83,
		["102"] = 86,
		["103"] = 87,
		["104"] = 88,
		["105"] = 88,
		["106"] = 88,
		["107"] = 88,
		["108"] = 88,
		["109"] = 88,
		["110"] = 88,
		["111"] = 88,
		["112"] = 88,
		["113"] = 97,
		["114"] = 98,
		["115"] = 98,
		["116"] = 98,
		["117"] = 98,
		["118"] = 98,
		["119"] = 99,
		["120"] = 99,
		["121"] = 99,
		["122"] = 99,
		["123"] = 99,
		["124"] = 100,
		["125"] = 101,
		["126"] = 102,
		["127"] = 79,
		["128"] = 22,
		["129"] = 14,
		["130"] = 14,
		["131"] = 14,
		["132"] = 14,
		["133"] = 14,
		["134"] = 14,
		["135"] = 14,
		["136"] = 14,
		["137"] = 22,
		["139"] = 22,
		["141"] = 108,
		["142"] = 109,
		["143"] = 108,
		["144"] = 109,
		["145"] = 119,
		["146"] = 120,
		["147"] = 121,
		["148"] = 122,
		["151"] = 125,
		["152"] = 126,
		["153"] = 127,
		["154"] = 128,
		["155"] = 131,
		["156"] = 132,
		["157"] = 133,
		["158"] = 134,
		["159"] = 135,
		["161"] = 138,
		["162"] = 139,
		["163"] = 140,
		["164"] = 140,
		["165"] = 140,
		["166"] = 140,
		["167"] = 141,
		["168"] = 142,
		["171"] = 145,
		["172"] = 146,
		["173"] = 147,
		["174"] = 148,
		["177"] = 151,
		["178"] = 152,
		["179"] = 152,
		["180"] = 152,
		["181"] = 152,
		["182"] = 152,
		["183"] = 153,
		["184"] = 153,
		["185"] = 153,
		["186"] = 153,
		["187"] = 153,
		["188"] = 154,
		["189"] = 155,
		["190"] = 156,
		["191"] = 157,
		["193"] = 159,
		["194"] = 160,
		["197"] = 140,
		["198"] = 140,
		["199"] = 119,
		["200"] = 165,
		["201"] = 166,
		["202"] = 165,
		["203"] = 109,
		["204"] = 108,
		["205"] = 109,
		["207"] = 109,
		["208"] = 170,
		["209"] = 178,
		["210"] = 170,
		["211"] = 178,
		["213"] = 178,
		["214"] = 186,
		["215"] = 192,
		["216"] = 170,
		["217"] = 196,
		["218"] = 197,
		["219"] = 199,
		["220"] = 200,
		["221"] = 201,
		["222"] = 202,
		["223"] = 204,
		["224"] = 206,
		["225"] = 207,
		["226"] = 208,
		["227"] = 209,
		["229"] = 211,
		["230"] = 212,
		["232"] = 215,
		["233"] = 217,
		["234"] = 219,
		["235"] = 221,
		["236"] = 196,
		["237"] = 223,
		["238"] = 224,
		["239"] = 225,
		["241"] = 223,
		["242"] = 228,
		["243"] = 229,
		["244"] = 230,
		["245"] = 231,
		["246"] = 232,
		["247"] = 233,
		["248"] = 233,
		["249"] = 234,
		["250"] = 235,
		["251"] = 236,
		["252"] = 237,
		["253"] = 238,
		["254"] = 239,
		["255"] = 240,
		["261"] = 228,
		["262"] = 247,
		["263"] = 248,
		["264"] = 248,
		["265"] = 250,
		["266"] = 250,
		["267"] = 250,
		["268"] = 248,
		["269"] = 248,
		["270"] = 248,
		["271"] = 248,
		["272"] = 247,
		["273"] = 255,
		["274"] = 256,
		["275"] = 255,
		["276"] = 258,
		["277"] = 259,
		["278"] = 258,
		["279"] = 261,
		["280"] = 262,
		["281"] = 264,
		["283"] = 266,
		["284"] = 268,
		["286"] = 270,
		["287"] = 271,
		["288"] = 272,
		["289"] = 273,
		["290"] = 275,
		["293"] = 261,
		["294"] = 279,
		["295"] = 280,
		["296"] = 281,
		["298"] = 279,
		["299"] = 284,
		["300"] = 285,
		["301"] = 286,
		["302"] = 286,
		["303"] = 284,
		["304"] = 291,
		["305"] = 292,
		["306"] = 293,
		["309"] = 296,
		["310"] = 297,
		["311"] = 297,
		["312"] = 291,
		["313"] = 302,
		["314"] = 303,
		["315"] = 305,
		["316"] = 306,
		["319"] = 309,
		["320"] = 310,
		["321"] = 311,
		["323"] = 314,
		["324"] = 315,
		["325"] = 316,
		["326"] = 316,
		["327"] = 316,
		["328"] = 316,
		["329"] = 316,
		["330"] = 316,
		["331"] = 316,
		["332"] = 316,
		["333"] = 316,
		["334"] = 325,
		["335"] = 326,
		["337"] = 328,
		["338"] = 302,
		["339"] = 331,
		["340"] = 332,
		["341"] = 333,
		["342"] = 334,
		["345"] = 337,
		["346"] = 338,
		["347"] = 339,
		["348"] = 340,
		["349"] = 341,
		["350"] = 342,
		["351"] = 343,
		["352"] = 344,
		["353"] = 345,
		["354"] = 345,
		["355"] = 345,
		["356"] = 345,
		["357"] = 345,
		["358"] = 346,
		["359"] = 347,
		["360"] = 348,
		["361"] = 349,
		["362"] = 331,
		["363"] = 351,
		["364"] = 352,
		["365"] = 353,
		["367"] = 355,
		["368"] = 356,
		["369"] = 357,
		["371"] = 351,
		["372"] = 360,
		["373"] = 361,
		["374"] = 360,
		["375"] = 363,
		["376"] = 364,
		["377"] = 363,
		["378"] = 371,
		["379"] = 372,
		["380"] = 373,
		["382"] = 371,
		["383"] = 376,
		["384"] = 377,
		["385"] = 378,
		["387"] = 376,
		["388"] = 178,
		["389"] = 170,
		["390"] = 170,
		["391"] = 170,
		["392"] = 170,
		["393"] = 170,
		["394"] = 170,
		["395"] = 170,
		["396"] = 170,
		["397"] = 178,
		["399"] = 178,
		["401"] = 394,
		["402"] = 402,
		["403"] = 394,
		["404"] = 402,
		["405"] = 406,
		["406"] = 408,
		["407"] = 410,
		["408"] = 406,
		["409"] = 412,
		["410"] = 413,
		["411"] = 414,
		["413"] = 416,
		["414"] = 417,
		["415"] = 418,
		["416"] = 418,
		["417"] = 418,
		["418"] = 418,
		["419"] = 418,
		["420"] = 418,
		["421"] = 418,
		["422"] = 418,
		["423"] = 418,
		["424"] = 419,
		["425"] = 419,
		["426"] = 419,
		["427"] = 419,
		["428"] = 419,
		["429"] = 419,
		["430"] = 419,
		["431"] = 419,
		["433"] = 412,
		["434"] = 422,
		["435"] = 423,
		["436"] = 424,
		["438"] = 422,
		["439"] = 427,
		["440"] = 428,
		["441"] = 427,
		["442"] = 432,
		["443"] = 433,
		["444"] = 432,
		["445"] = 435,
		["446"] = 436,
		["447"] = 435,
		["448"] = 441,
		["449"] = 442,
		["450"] = 443,
		["452"] = 441,
		["453"] = 446,
		["454"] = 447,
		["455"] = 448,
		["456"] = 449,
		["457"] = 450,
		["458"] = 451,
		["459"] = 452,
		["461"] = 454,
		["462"] = 455,
		["463"] = 456,
		["465"] = 458,
		["466"] = 459,
		["467"] = 460,
		["469"] = 462,
		["472"] = 446,
		["473"] = 466,
		["474"] = 467,
		["475"] = 466,
		["476"] = 471,
		["477"] = 472,
		["478"] = 471,
		["479"] = 402,
		["480"] = 394,
		["481"] = 394,
		["482"] = 394,
		["483"] = 394,
		["484"] = 394,
		["485"] = 394,
		["486"] = 394,
		["487"] = 394,
		["488"] = 402,
		["490"] = 402,
		["491"] = 477,
		["492"] = 485,
		["493"] = 477,
		["494"] = 485,
		["495"] = 486,
		["496"] = 487,
		["497"] = 486,
		["498"] = 489,
		["499"] = 490,
		["500"] = 491,
		["502"] = 489,
		["503"] = 494,
		["504"] = 495,
		["505"] = 496,
		["507"] = 494,
		["508"] = 485,
		["509"] = 477,
		["510"] = 477,
		["511"] = 477,
		["512"] = 477,
		["513"] = 477,
		["514"] = 477,
		["515"] = 477,
		["516"] = 477,
		["517"] = 485,
		["519"] = 485,
		["521"] = 503,
		["522"] = 504,
		["523"] = 503,
		["524"] = 504,
		["525"] = 505,
		["526"] = 506,
		["527"] = 505,
		["528"] = 504,
		["529"] = 503,
		["530"] = 504,
		["532"] = 504,
		["533"] = 510,
		["534"] = 518,
		["535"] = 510,
		["536"] = 518,
		["537"] = 520,
		["538"] = 521,
		["539"] = 520,
		["540"] = 523,
		["541"] = 524,
		["542"] = 525,
		["543"] = 525,
		["544"] = 525,
		["545"] = 526,
		["546"] = 527,
		["548"] = 525,
		["549"] = 525,
		["551"] = 523,
		["552"] = 532,
		["553"] = 533,
		["554"] = 532,
		["555"] = 537,
		["556"] = 538,
		["557"] = 537,
		["558"] = 518,
		["559"] = 510,
		["560"] = 510,
		["561"] = 510,
		["562"] = 510,
		["563"] = 510,
		["564"] = 510,
		["565"] = 510,
		["566"] = 510,
		["567"] = 518,
		["569"] = 518,
		["571"] = 545,
		["572"] = 546,
		["573"] = 545,
		["574"] = 546,
		["575"] = 547,
		["576"] = 548,
		["577"] = 547,
		["578"] = 546,
		["579"] = 545,
		["580"] = 546,
		["582"] = 546,
		["583"] = 552,
		["584"] = 560,
		["585"] = 552,
		["586"] = 560,
		["587"] = 563,
		["588"] = 564,
		["589"] = 565,
		["590"] = 563,
		["591"] = 567,
		["592"] = 568,
		["593"] = 567,
		["594"] = 572,
		["595"] = 573,
		["596"] = 572,
		["597"] = 560,
		["598"] = 552,
		["599"] = 552,
		["600"] = 552,
		["601"] = 552,
		["602"] = 552,
		["603"] = 552,
		["604"] = 552,
		["605"] = 552,
		["606"] = 560,
		["608"] = 560,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.earthshaker_talent = c()
local q = g.earthshaker_talent
q.name = "earthshaker_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_talent"
end
q = e({ j(nil) }, q)
g.earthshaker_talent = q
g.modifier_earthshaker_talent = c()
local r = g.modifier_earthshaker_talent
r.name = "modifier_earthshaker_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.as_record = 0
	self.record_attack_count = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.crit_mana = self:GetAbilitySpecialValueFor("crit_mana")
	self.normal_mana = self:GetAbilitySpecialValueFor("normal_mana")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("earthshaker_talent_8", "bonus_damage")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.tl2_crit = self:GetAbilityTalentValue("earthshaker_talent_2", "crit")
	self.tl7_attack_count = self:GetAbilityTalentValue("earthshaker_talent_7", "attack_count")
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function r.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	return self.tl2_crit
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, s) end
function r.prototype.OnBattleEnd(self, s) end
function r.prototype.OnCritical(self, s)
	RestoreCustomMana(self:GetParent(), self.crit_mana)
end
function r.prototype.OnCustomTakeDamage(self, t)
	if t.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and not t.is_crit then
		RestoreCustomMana(self:GetParent(), self.normal_mana)
	end
end
function r.prototype.OnCustomAttackLanded(self, t)
	self.record_attack_count = self.record_attack_count + 1
	if self.tl7_attack_count > 0 and self.record_attack_count >= self.tl7_attack_count then
		local u = self.parent:FindModifierByName("modifier_earthshaker_ult")
		if IsValid(u) then
			u:EnchantTotem()
		end
		self.record_attack_count = self.record_attack_count - self.tl7_attack_count
	end
end
function r.prototype.AfterShock(self)
	local v = self:GetParent()
	if v:PassivesDisabled() then
		return
	end
	local w = v:GetEnemy()
	if not IsInjurable(v, w) then
		return
	end
	local x = self:GetAbility()
	local y = self.damage + self.as_record * self.bonus_damage
	DamageSystem:dealDamage({
		attacker = v,
		target = w,
		ability = x,
		damage = y,
		damage_type = DAMAGE_TYPE_NONE,
		damage_flags = DamageFlags.DAMAGE_FLAG_REFLECTION
			+ DamageFlags.DAMAGE_FLAG_HPLOSS
			+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	})
	local z = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf",
		PATTACH_CUSTOMORIGIN,
		v
	)
	ParticleManager:SetParticleControl(z, 0, v:GetAbsOrigin())
	ParticleManager:SetParticleControl(z, 1, Vector(350, 350, 350))
	ParticleManager:ReleaseParticleIndex(z)
	v:EmitSound("Hero_EarthShaker.Totem")
	self.as_record = self.as_record + 1
end
r = e(
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
	r
)
g.modifier_earthshaker_talent = r
g.earthshaker_ult = c()
local A = g.earthshaker_ult
A.name = "earthshaker_ult"
d(A, o)
function A.prototype.OnSpellStart(self)
	local B = self:GetCaster()
	local w = B:GetEnemy()
	if not IsInjurable(w, B) then
		return
	end
	B:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local C = w:GetAbsOrigin() - B:GetAbsOrigin()
	C.z = 0
	C = C:Normalized()
	local D = self:GetTalentValue("earthshaker_talent_6", "count")
	local E = 1
	if D > 0 then
		E = E + B:GetModifierStackCount("modifier_earthshaker_talent_6", B)
		B:AddNewModifier(B, self, "modifier_earthshaker_talent_6", nil)
	end
	local F = self:HasTalent("earthshaker_talent_9")
	local G = B:FindModifierByName("modifier_earthshaker_talent")
	ForWithInterval(0.2, E, function()
		if IsValid(self) then
			if not IsInjurable(w, B) then
				return
			end
			if F then
				local u = B:FindModifierByName("modifier_earthshaker_ult")
				if IsValid(u) then
					u:EnchantTotem()
				end
			else
				local H = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf",
					PATTACH_CUSTOMORIGIN,
					B
				)
				ParticleManager:SetParticleControl(H, 0, B:GetAbsOrigin() + C * 80)
				ParticleManager:SetParticleControl(H, 1, Vector(1, 0, 0))
				ParticleManager:ReleaseParticleIndex(H)
				B:EmitSound("Hero_EarthShaker.EchoSlamSmall")
				local y = self:GetSpecialValueFor("damage")
				B:DealDamage(w, self, y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			end
			if IsValid(G) then
				G:AfterShock()
			end
		end
	end)
end
function A.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_ult"
end
A = e({ p(nil) }, A)
g.earthshaker_ult = A
g.modifier_earthshaker_ult = c()
local I = g.modifier_earthshaker_ult
I.name = "modifier_earthshaker_ult"
d(I, l)
function I.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl1_record = 0
	self.tick = FRAME_TIME
end
function I.prototype.GetAbilitySpecialValue(self)
	self.threshold1 = self:GetAbilitySpecialValueFor("threshold1")
	self.bonus_attack = self:GetAbilitySpecialValueFor("bonus_attack")
		+ self:GetAbilityTalentValue("earthshaker_talent_9", "bonus_damage")
	self.threshold2 = self:GetAbilitySpecialValueFor("threshold2")
	self.fissure_damage = self:GetAbilitySpecialValueFor("fissure_damage")
	self.stun = self:GetAbilitySpecialValueFor("stun")
	self.tl9_attack_pct = self:GetAbilityTalentValue("earthshaker_talent_9", "attack_pct")
	local J = self:GetAbilityTalentValue("earthshaker_shard", "threshold1")
	local K = self:GetAbilityTalentValue("earthshaker_shard", "threshold2")
	if J > 0 then
		self.threshold1 = J
	end
	if K > 0 then
		self.threshold2 = K
	end
	self.tl1_mana = self:GetAbilityTalentValue("earthshaker_talent_1", "mana")
	self.tl3_hit_chance = self:GetAbilityTalentValue("earthshaker_talent_3", "hit_chance")
	self.tl4_chance = self:GetAbilityTalentValue("earthshaker_talent_4", "chance")
	self.tl9_enable = self:HasTalent("earthshaker_talent_9")
end
function I.prototype.OnCreated(self, s)
	if IsServer() then
		self.actionList = {}
	end
end
function I.prototype.OnIntervalThink(self)
	if IsServer() then
		local L = #self.actionList - 1
		for M = #self.actionList, 1, -1 do
			L = M - 1
			local N, O = self.actionList[L + 1], "time"
			N[O] = N[O] - self.tick
			if self.actionList[L + 1].time <= 0 then
				local P = table.remove(self.actionList, M).type
				if self[P] then
					self[P](self)
					local u = self:GetTalentModifier()
					if IsValid(u) then
						u:AfterShock()
					end
				end
			end
		end
	end
end
function I.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent() },
	}
end
function I.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(self.tick)
end
function I.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function I.prototype.OnRestore(self, s)
	if s.original_mana < self.threshold1 and s.current_mana >= self.threshold1 then
		self:EnchantTotem()
	end
	if s.original_mana < self.threshold2 and s.current_mana >= self.threshold2 then
		self:Fissure()
	end
	if self.tl1_mana > 0 then
		self.tl1_record = self.tl1_record + s.count
		if self.tl1_record >= self.tl1_mana then
			self.tl1_record = self.tl1_record - self.tl1_mana
			self:EnchantTotem()
		end
	end
end
function I.prototype.OnCritical(self, s)
	if self.tl4_chance > 0 and self:PRD(self.tl4_chance, "tl4_chance") then
		self:GetAbility():OnSpellStart()
	end
end
function I.prototype.EnchantTotem(self)
	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.5)
	local Q = self.actionList
	Q[#Q + 1] = { type = "_EnchantTotem", time = 0.3 }
end
function I.prototype.Fissure(self)
	if self.tl9_enable then
		self:EnchantTotem()
		return
	end
	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.5)
	local R = self.actionList
	R[#R + 1] = { type = "_Fissure", time = 0.5 }
end
function I.prototype._EnchantTotem(self)
	local v = self:GetParent()
	local w = v:GetEnemy()
	if not IsInjurable(v, w) then
		return
	end
	local y = self.bonus_attack
	if self.tl9_attack_pct > 0 then
		y = y + GetAttackDamage(self:GetParent()) * self.tl9_attack_pct * 0.01
	end
	v:EmitSound("Hero_EarthShaker.Totem.Attack")
	local x = v:FindAbilityByName("earthshaker_ult_ui1")
	local S = {
		attacker = v,
		target = w,
		ability = x,
		damage = y,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	}
	if self.tl3_hit_chance then
		S.is_crit = true
	end
	DamageSystem:dealDamage(S)
end
function I.prototype._Fissure(self)
	local v = self:GetParent()
	local w = v:GetEnemy()
	if not IsInjurable(v, w) then
		return
	end
	local T = w:GetAbsOrigin()
	local U = v:GetAbsOrigin()
	local C = T - U
	C.z = 0
	C = C:Normalized()
	local H = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf",
		PATTACH_CUSTOMORIGIN,
		v
	)
	ParticleManager:SetParticleControl(H, 0, U + C * 75)
	ParticleManager:SetParticleControl(H, 1, T + C * 200)
	ParticleManager:SetParticleControl(H, 2, Vector(1, 0, 0))
	v:EmitSound("Hero_EarthShaker.Fissure")
	local x = v:FindAbilityByName("earthshaker_ult_ui2")
	v:DealDamage(w, x, self.fissure_damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	AddStun(v, w, x, self.stun)
end
function I.prototype.GetTalentModifier(self)
	if IsValid(self.talent_modifier) then
		return self.talent_modifier
	end
	self.talent_modifier = self:GetParent():FindModifierByName("modifier_earthshaker_talent")
	if IsValid(self.talent_modifier) then
		return self.talent_modifier
	end
end
function I.prototype.RecordEnchantTotemAttackInfo(self, V)
	self.enchant_totem_recode = V
end
function I.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE,
	}
end
function I.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	if s ~= nil and self.tl3_hit_chance > 0 and self.enchant_totem_recode == s then
		return 1000
	end
end
function I.prototype.EOM_GetModifierSurehitChance(self, s)
	if s ~= nil and self.tl3_hit_chance > 0 and self.enchant_totem_recode == s then
		return self.tl3_hit_chance
	end
end
I = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	I
)
g.modifier_earthshaker_ult = I
g.modifier_earthshaker_enchant_totem_custom = c()
local W = g.modifier_earthshaker_enchant_totem_custom
W.name = "modifier_earthshaker_enchant_totem_custom"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.bonus_attack = self:GetAbilitySpecialValueFor("bonus_attack")
		+ self:GetAbilityTalentValue("earthshaker_talent_9", "bonus_damage")
	self.tl9_attack_pct = self:GetAbilityTalentValue("earthshaker_talent_9", "attack_pct")
end
function W.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	else
		local v = self:GetParent()
		local H = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf",
			PATTACH_CUSTOMORIGIN,
			v
		)
		ParticleManager:SetParticleControlEnt(H, 0, v, PATTACH_POINT_FOLLOW, "attach_totem", vec3_zero, true)
		self:AddParticle(H, false, false, -1, false, false)
	end
end
function W.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function W.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent() } }
end
function W.prototype.OnCustomAttackStart(self, t)
	self.damageInfo = t
end
function W.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
	}
end
function W.prototype.EOM_GetModifierAttackSourceAbility(self, s)
	if s ~= nil and self.damageInfo == s then
		return self:GetParent():FindAbilityByName("earthshaker_ult_ui1")
	end
end
function W.prototype.EOM_GetModifierProcAttackDamageBonus(self, s)
	if IsServer() then
		if s ~= nil and s == self.damageInfo then
			self:GetParent():EmitSound("Hero_EarthShaker.Totem.Attack")
			self:DecrementStackCount()
			if self:GetStackCount() == 0 then
				self:Destroy()
			end
			local u = self:GetParent():FindModifierByName("modifier_earthshaker_ult")
			if IsValid(u) then
				u:RecordEnchantTotemAttackInfo(s)
			end
			local y = self.bonus_attack
			if self.tl9_attack_pct > 0 then
				y = y + GetAttackDamage(self:GetParent()) * self.tl9_attack_pct * 0.01
			end
			return y
		end
	end
end
function W.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function W.prototype.GetActivityTranslationModifiers(self)
	return "enchant_totem"
end
W = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	W
)
g.modifier_earthshaker_enchant_totem_custom = W
g.modifier_earthshaker_talent_6 = c()
local X = g.modifier_earthshaker_talent_6
X.name = "modifier_earthshaker_talent_6"
d(X, l)
function X.prototype.GetTexture(self)
	return "modifier_earthshaker_talent_6"
end
function X.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function X.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
X = e(
	{
		m(
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
	X
)
g.modifier_earthshaker_talent_6 = X
g.earthshaker_talent_5 = c()
local Y = g.earthshaker_talent_5
Y.name = "earthshaker_talent_5"
d(Y, i)
function Y.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_talent_5"
end
Y = e({ j(nil) }, Y)
g.earthshaker_talent_5 = Y
g.modifier_earthshaker_talent_5 = c()
local Z = g.modifier_earthshaker_talent_5
Z.name = "modifier_earthshaker_talent_5"
d(Z, l)
function Z.prototype.GetAbilitySpecialValue(self)
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
end
function Z.prototype.OnCreated(self, s)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED, function(_, a0, B, a1)
			if _:GetParent() == B and not a0.is_crit then
				a0.damage = 0
			end
		end)
	end
end
function Z.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function Z.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, s)
	return self.crit_damage
end
Z = e(
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
	Z
)
g.modifier_earthshaker_talent_5 = Z
g.earthshaker_shard = c()
local a2 = g.earthshaker_shard
a2.name = "earthshaker_shard"
d(a2, i)
function a2.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_shard_custom"
end
a2 = e({ j(nil) }, a2)
g.earthshaker_shard = a2
g.modifier_earthshaker_shard_custom = c()
local a3 = g.modifier_earthshaker_shard_custom
a3.name = "modifier_earthshaker_shard_custom"
d(a3, l)
function a3.prototype.GetAbilitySpecialValue(self)
	self.max_mana = self:GetAbilitySpecialValueFor("max_mana")
	self.mana_reduce = self:GetAbilitySpecialValueFor("mana_reduce")
end
function a3.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANA_BONUS }
end
function a3.prototype.GetModifierManaBonus(self)
	return -self.mana_reduce
end
a3 = e(
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
	a3
)
g.modifier_earthshaker_shard_custom = a3
return g