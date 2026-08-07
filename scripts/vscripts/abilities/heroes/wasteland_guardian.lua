--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/wasteland_guardian"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIndexOf
local g = b.__TS__ArraySplice
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["20"] = 6,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 9,
		["26"] = 8,
		["27"] = 7,
		["28"] = 6,
		["29"] = 7,
		["31"] = 7,
		["32"] = 13,
		["33"] = 21,
		["34"] = 13,
		["35"] = 21,
		["37"] = 21,
		["38"] = 33,
		["39"] = 13,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["44"] = 42,
		["45"] = 44,
		["46"] = 45,
		["47"] = 46,
		["48"] = 48,
		["49"] = 49,
		["50"] = 38,
		["51"] = 51,
		["52"] = 52,
		["53"] = 53,
		["54"] = 54,
		["56"] = 51,
		["57"] = 57,
		["58"] = 58,
		["59"] = 59,
		["62"] = 60,
		["63"] = 61,
		["64"] = 62,
		["65"] = 63,
		["68"] = 57,
		["69"] = 67,
		["70"] = 68,
		["71"] = 69,
		["72"] = 70,
		["73"] = 71,
		["74"] = 71,
		["75"] = 71,
		["76"] = 71,
		["77"] = 71,
		["78"] = 71,
		["79"] = 71,
		["80"] = 71,
		["81"] = 71,
		["82"] = 72,
		["83"] = 78,
		["84"] = 79,
		["86"] = 81,
		["87"] = 81,
		["88"] = 81,
		["89"] = 81,
		["90"] = 81,
		["91"] = 81,
		["92"] = 82,
		["93"] = 67,
		["94"] = 84,
		["95"] = 85,
		["96"] = 86,
		["97"] = 87,
		["98"] = 87,
		["99"] = 87,
		["100"] = 87,
		["102"] = 89,
		["103"] = 84,
		["104"] = 91,
		["105"] = 92,
		["106"] = 93,
		["107"] = 94,
		["108"] = 95,
		["109"] = 96,
		["110"] = 97,
		["111"] = 98,
		["112"] = 98,
		["113"] = 98,
		["114"] = 98,
		["115"] = 99,
		["116"] = 100,
		["118"] = 98,
		["119"] = 98,
		["122"] = 91,
		["123"] = 106,
		["124"] = 107,
		["125"] = 107,
		["126"] = 107,
		["127"] = 110,
		["128"] = 110,
		["129"] = 110,
		["130"] = 107,
		["131"] = 111,
		["132"] = 111,
		["133"] = 111,
		["134"] = 107,
		["135"] = 112,
		["136"] = 112,
		["137"] = 112,
		["138"] = 107,
		["139"] = 107,
		["140"] = 106,
		["141"] = 115,
		["142"] = 117,
		["143"] = 118,
		["144"] = 119,
		["145"] = 119,
		["146"] = 119,
		["147"] = 119,
		["148"] = 119,
		["149"] = 119,
		["150"] = 120,
		["152"] = 115,
		["153"] = 123,
		["154"] = 124,
		["155"] = 125,
		["156"] = 126,
		["157"] = 123,
		["158"] = 128,
		["159"] = 129,
		["160"] = 130,
		["161"] = 131,
		["162"] = 128,
		["163"] = 134,
		["164"] = 135,
		["165"] = 136,
		["166"] = 137,
		["167"] = 138,
		["168"] = 141,
		["169"] = 141,
		["170"] = 141,
		["171"] = 141,
		["172"] = 141,
		["173"] = 141,
		["174"] = 142,
		["176"] = 134,
		["177"] = 145,
		["178"] = 146,
		["181"] = 148,
		["182"] = 149,
		["184"] = 145,
		["185"] = 21,
		["186"] = 13,
		["187"] = 13,
		["188"] = 13,
		["189"] = 13,
		["190"] = 13,
		["191"] = 13,
		["192"] = 13,
		["193"] = 13,
		["194"] = 21,
		["196"] = 21,
		["197"] = 153,
		["198"] = 162,
		["199"] = 153,
		["200"] = 162,
		["201"] = 164,
		["202"] = 165,
		["203"] = 164,
		["204"] = 167,
		["205"] = 168,
		["206"] = 169,
		["207"] = 169,
		["208"] = 168,
		["209"] = 167,
		["210"] = 172,
		["211"] = 173,
		["212"] = 173,
		["213"] = 173,
		["214"] = 173,
		["215"] = 173,
		["216"] = 173,
		["217"] = 174,
		["218"] = 175,
		["219"] = 175,
		["220"] = 175,
		["221"] = 175,
		["222"] = 175,
		["223"] = 176,
		["224"] = 177,
		["225"] = 172,
		["226"] = 162,
		["227"] = 153,
		["228"] = 153,
		["229"] = 153,
		["230"] = 153,
		["231"] = 153,
		["232"] = 153,
		["233"] = 153,
		["234"] = 153,
		["235"] = 153,
		["236"] = 162,
		["238"] = 162,
		["241"] = 184,
		["242"] = 193,
		["243"] = 184,
		["244"] = 193,
		["246"] = 193,
		["247"] = 202,
		["248"] = 203,
		["249"] = 184,
		["250"] = 204,
		["251"] = 205,
		["252"] = 206,
		["253"] = 207,
		["254"] = 208,
		["255"] = 209,
		["256"] = 204,
		["257"] = 211,
		["258"] = 212,
		["259"] = 213,
		["260"] = 214,
		["262"] = 216,
		["263"] = 217,
		["264"] = 217,
		["265"] = 217,
		["266"] = 217,
		["267"] = 218,
		["268"] = 218,
		["269"] = 219,
		["273"] = 211,
		["274"] = 226,
		["275"] = 227,
		["276"] = 228,
		["277"] = 229,
		["279"] = 231,
		["280"] = 231,
		["281"] = 231,
		["282"] = 231,
		["284"] = 233,
		["285"] = 233,
		["286"] = 233,
		["287"] = 233,
		["288"] = 234,
		["289"] = 234,
		["290"] = 235,
		["292"] = 226,
		["293"] = 238,
		["294"] = 239,
		["295"] = 240,
		["296"] = 241,
		["297"] = 241,
		["298"] = 241,
		["299"] = 241,
		["300"] = 241,
		["301"] = 241,
		["302"] = 241,
		["303"] = 241,
		["304"] = 242,
		["305"] = 243,
		["307"] = 238,
		["308"] = 246,
		["309"] = 247,
		["310"] = 246,
		["311"] = 252,
		["312"] = 253,
		["313"] = 254,
		["315"] = 252,
		["316"] = 258,
		["317"] = 259,
		["318"] = 258,
		["319"] = 193,
		["320"] = 184,
		["321"] = 184,
		["322"] = 184,
		["323"] = 184,
		["324"] = 184,
		["325"] = 184,
		["326"] = 184,
		["327"] = 184,
		["328"] = 193,
		["330"] = 193,
		["332"] = 265,
		["333"] = 266,
		["334"] = 265,
		["335"] = 266,
		["336"] = 267,
		["337"] = 268,
		["338"] = 269,
		["339"] = 270,
		["340"] = 271,
		["341"] = 271,
		["342"] = 271,
		["343"] = 271,
		["344"] = 271,
		["345"] = 272,
		["346"] = 273,
		["347"] = 276,
		["349"] = 278,
		["350"] = 278,
		["351"] = 278,
		["352"] = 279,
		["353"] = 280,
		["355"] = 278,
		["356"] = 278,
		["357"] = 283,
		["358"] = 283,
		["359"] = 283,
		["360"] = 284,
		["361"] = 285,
		["362"] = 287,
		["364"] = 289,
		["366"] = 283,
		["367"] = 283,
		["368"] = 267,
		["369"] = 296,
		["370"] = 296,
		["371"] = 296,
		["373"] = 297,
		["374"] = 298,
		["375"] = 299,
		["378"] = 302,
		["379"] = 303,
		["380"] = 304,
		["381"] = 305,
		["382"] = 306,
		["383"] = 307,
		["385"] = 310,
		["386"] = 311,
		["387"] = 312,
		["388"] = 312,
		["389"] = 312,
		["390"] = 312,
		["391"] = 312,
		["392"] = 313,
		["393"] = 315,
		["394"] = 316,
		["396"] = 318,
		["398"] = 320,
		["399"] = 322,
		["400"] = 322,
		["401"] = 322,
		["402"] = 322,
		["403"] = 322,
		["404"] = 322,
		["405"] = 323,
		["406"] = 296,
		["407"] = 266,
		["408"] = 265,
		["409"] = 266,
		["411"] = 266,
		["412"] = 327,
		["413"] = 335,
		["414"] = 327,
		["415"] = 335,
		["417"] = 335,
		["418"] = 344,
		["419"] = 349,
		["420"] = 327,
		["421"] = 351,
		["422"] = 352,
		["423"] = 353,
		["424"] = 354,
		["425"] = 355,
		["426"] = 356,
		["427"] = 358,
		["428"] = 351,
		["429"] = 360,
		["430"] = 361,
		["431"] = 362,
		["432"] = 363,
		["433"] = 364,
		["434"] = 365,
		["437"] = 368,
		["438"] = 369,
		["439"] = 370,
		["440"] = 371,
		["441"] = 372,
		["442"] = 374,
		["443"] = 375,
		["444"] = 375,
		["445"] = 375,
		["446"] = 375,
		["447"] = 375,
		["448"] = 375,
		["449"] = 376,
		["450"] = 377,
		["451"] = 377,
		["452"] = 377,
		["453"] = 377,
		["454"] = 377,
		["455"] = 378,
		["456"] = 379,
		["458"] = 360,
		["459"] = 382,
		["460"] = 383,
		["461"] = 384,
		["462"] = 385,
		["463"] = 386,
		["464"] = 387,
		["467"] = 390,
		["468"] = 391,
		["469"] = 392,
		["470"] = 393,
		["471"] = 394,
		["472"] = 395,
		["473"] = 397,
		["474"] = 398,
		["475"] = 398,
		["476"] = 398,
		["477"] = 398,
		["478"] = 398,
		["479"] = 398,
		["480"] = 399,
		["481"] = 400,
		["482"] = 400,
		["483"] = 400,
		["484"] = 400,
		["485"] = 400,
		["487"] = 402,
		["488"] = 403,
		["490"] = 382,
		["491"] = 406,
		["492"] = 407,
		["493"] = 408,
		["494"] = 409,
		["495"] = 410,
		["496"] = 411,
		["499"] = 406,
		["500"] = 415,
		["501"] = 416,
		["502"] = 417,
		["503"] = 418,
		["504"] = 419,
		["505"] = 420,
		["507"] = 422,
		["508"] = 422,
		["509"] = 427,
		["510"] = 415,
		["511"] = 429,
		["512"] = 430,
		["513"] = 429,
		["514"] = 432,
		["515"] = 433,
		["518"] = 436,
		["519"] = 437,
		["520"] = 438,
		["521"] = 439,
		["522"] = 440,
		["524"] = 442,
		["525"] = 443,
		["526"] = 444,
		["527"] = 445,
		["528"] = 446,
		["530"] = 432,
		["531"] = 449,
		["532"] = 450,
		["535"] = 451,
		["536"] = 452,
		["537"] = 453,
		["540"] = 456,
		["541"] = 457,
		["542"] = 458,
		["543"] = 459,
		["545"] = 461,
		["546"] = 462,
		["547"] = 463,
		["549"] = 449,
		["550"] = 466,
		["551"] = 467,
		["552"] = 468,
		["553"] = 469,
		["555"] = 466,
		["556"] = 472,
		["557"] = 473,
		["558"] = 472,
		["559"] = 478,
		["560"] = 479,
		["561"] = 480,
		["562"] = 480,
		["563"] = 479,
		["564"] = 478,
		["565"] = 483,
		["566"] = 484,
		["567"] = 485,
		["568"] = 486,
		["569"] = 487,
		["570"] = 483,
		["571"] = 489,
		["572"] = 490,
		["573"] = 489,
		["574"] = 495,
		["575"] = 496,
		["576"] = 495,
		["577"] = 498,
		["578"] = 499,
		["579"] = 498,
		["580"] = 335,
		["581"] = 327,
		["582"] = 327,
		["583"] = 327,
		["584"] = 327,
		["585"] = 327,
		["586"] = 327,
		["587"] = 327,
		["588"] = 327,
		["589"] = 335,
		["591"] = 335,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = require("abilities.ability_ai")
local q = p.BaseAbilityAI
local r = p.registerAbilityAI
i.wasteland_guardian_talent = c()
local s = i.wasteland_guardian_talent
s.name = "wasteland_guardian_talent"
d(s, k)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_wasteland_guardian_talent"
end
s = e({ l(nil) }, s)
i.wasteland_guardian_talent = s
i.modifier_wasteland_guardian_talent = c()
local t = i.modifier_wasteland_guardian_talent
t.name = "modifier_wasteland_guardian_talent"
d(t, n)
function t.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.tick = 0.1
end
function t.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.shield_bonus = self:GetAbilitySpecialValueFor("shield_bonus")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.talent_1_mana_regen = self:GetAbilityTalentValue("wasteland_guardian_talent_1", "mana_regen")
	self.talent_4_chance = self:GetAbilityTalentValue("wasteland_guardian_talent_4", "chance")
	self.talent_6_init_overload_count = self:GetAbilityTalentValue("wasteland_guardian_talent_6", "init_overload_count")
	self.s_count = self:GetAbilityTalentValue("wasteland_guardian_shard", "count")
	self.s_wave = self:GetAbilityTalentValue("wasteland_guardian_shard", "wave")
end
function t.prototype.OnCreated(self, u)
	if IsServer() then
		self.s_record = 0
		self.shieldStack = 0
	end
end
function t.prototype.OnIntervalThink(self)
	if IsServer() then
		if self:GetCaster():PassivesDisabled() then
			return
		end
		self.recordTime = self.recordTime - self.tick
		if self.recordTime <= 0 then
			self.recordTime = self:getPassiveInterval()
			self:SteamArmor()
		end
	end
end
function t.prototype.SteamArmor(self)
	local v = self:GetParent()
	local w = self:GetAbility()
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_wasterland_guardian/overload_buff_c.vpcf",
		PATTACH_CUSTOMORIGIN,
		v
	)
	ParticleManager:SetParticleControlEnt(x, 0, v, PATTACH_POINT, "attach_hitloc", v:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(x)
	if self.talent_1_mana_regen > 0 then
		Restore(v, self.talent_1_mana_regen)
	end
	AddShield(v, self.shield_bonus, w:GetAbilityName(), "Ability")
	v:AddNewModifier(v, w, "modifier_wasteland_guardian_attack", {})
end
function t.prototype.getPassiveInterval(self)
	local v = self:GetParent()
	if v:HasModifier("modifier_wasteland_guardian_overload") then
		return math.max(
			0,
			self.interval
				- v:FindModifierByName("modifier_wasteland_guardian_overload"):GetStackCount()
					* BUFF_VALUE.OverloadIntervalReduce
		)
	end
	return self.interval
end
function t.prototype.ShardStack(self, y)
	if self.s_count > 0 then
		self.s_record = self.s_record + y
		if self.s_record >= self.s_count then
			local z = math.floor(self.s_record / self.s_count) * self.s_wave
			self.s_record = self.s_record % self.s_count
			local A = self:GetParent():FindAbilityByName("wasteland_guardian_ult")
			ForWithInterval(0.1, z, function()
				if IsValid(A) then
					A:ShockWave()
				end
			end)
		end
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function t.prototype.OnBattleStartBefore(self, u)
	if self.talent_6_init_overload_count > 0 then
		local v = self:GetParent()
		v:AddNewModifier(v, self:GetAbility(), "modifier_wasteland_guardian_overload", {})
		self:ShardStack(self.talent_6_init_overload_count)
	end
end
function t.prototype.OnBattleStart(self, u)
	self.shieldStack = 0
	self.recordTime = self:getPassiveInterval()
	self:StartIntervalThink(self.tick)
end
function t.prototype.OnBattleEnd(self, u)
	self.shieldStack = 0
	self.recordTime = 0
	self:StartIntervalThink(-1)
end
function t.prototype.OnShieldGained(self, u)
	self.shieldStack = self.shieldStack + u.iStackCount
	if self.shieldStack >= self.threshold then
		self.shieldStack = self.shieldStack - self.threshold
		local v = self:GetParent()
		v:AddNewModifier(v, self:GetAbility(), "modifier_wasteland_guardian_overload", {})
		self:ShardStack(1)
	end
end
function t.prototype.OnCustomTakeDamage(self, B)
	if self.talent_4_chance == 0 then
		return
	end
	if self:PRD(self.talent_4_chance, "wasteland_guardian_talent_4") then
		self:SteamArmor()
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
i.modifier_wasteland_guardian_talent = t
i.modifier_wasteland_guardian_attack = c()
local C = i.modifier_wasteland_guardian_attack
C.name = "modifier_wasteland_guardian_attack"
d(C, n)
function C.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function C.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function C.prototype.OnCustomAttackLanded(self, B)
	B.attacker:DealDamage(B.target, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/wasteland_guardian/overload.vpcf",
		PATTACH_CUSTOMORIGIN,
		B.attacker
	)
	ParticleManager:SetParticleControl(x, 0, B.target:GetAbsOrigin())
	B.attacker:EmitSound("Hero_StormSpirit.Overload")
	self:Destroy()
end
C = e(
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
				IsIndependent = true,
			}
		),
	},
	C
)
i.modifier_wasteland_guardian_attack = C
i.modifier_wasteland_guardian_overload = c()
local D = i.modifier_wasteland_guardian_overload
D.name = "modifier_wasteland_guardian_overload"
d(D, n)
function D.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.timerNames = {}
	self.timerIndex = 0
end
function D.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.talent_3_crit_chance = self:GetAbilityTalentValue("wasteland_guardian_talent_3", "crit_chance")
	self.talent_5_overload_limit_bonus =
		self:GetAbilityTalentValue("wasteland_guardian_talent_5", "overload_limit_bonus")
	self.talent_6_init_overload_count = self:GetAbilityTalentValue("wasteland_guardian_talent_6", "init_overload_count")
end
function D.prototype.OnCreated(self, u)
	if IsServer() then
		if self.talent_6_init_overload_count > 0 then
			self:IncrementStackCount(self.talent_6_init_overload_count)
		else
			self:IncrementStackCount()
			self:StartThink(self.duration, tostring(self.timerIndex))
			local E = self.timerNames
			E[#E + 1] = self.timerIndex
			self.timerIndex = self.timerIndex + 1
		end
	else
	end
end
function D.prototype.OnRefresh(self, u)
	if IsServer() then
		if self:GetStackCount() < self.max_stack + self.talent_6_init_overload_count then
			self:IncrementStackCount()
		else
			self:StartThink(-1, tostring(self.timerNames[1]))
		end
		self:StartThink(self.duration, tostring(self.timerIndex))
		local F = self.timerNames
		F[#F + 1] = self.timerIndex
		self.timerIndex = self.timerIndex + 1
	end
end
function D.prototype.OnThink(self, G)
	self:DecrementStackCount()
	self:StartThink(-1, G)
	g(self.timerNames, f(self.timerNames, tonumber(G)), 1)
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function D.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROC_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
	}
end
function D.prototype.EOM_GetModifierProcDamageBonus(self, u)
	if u.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL then
		return self:GetStackCount() * (BUFF_VALUE.OverloadPhyDmg + self.talent_5_overload_limit_bonus)
	end
end
function D.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, u)
	return self:GetStackCount() * self.talent_3_crit_chance
end
D = e(
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
	D
)
i.modifier_wasteland_guardian_overload = D
i.wasteland_guardian_ult = c()
local H = i.wasteland_guardian_ult
H.name = "wasteland_guardian_ult"
d(H, q)
function H.prototype.OnSpellStart(self)
	local I = self:GetCaster()
	local J = I:GetEnemy()
	I:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	EmitSoundOnLocationWithCaster(I:GetAbsOrigin(), "Hero_Dawnbreaker.Celestial_Hammer.Cast", I)
	local K = self:GetSpecialValueFor("duration")
	if I:HasModifier("modifier_wasteland_guardian_ult") then
		I:FindModifierByName("modifier_wasteland_guardian_ult"):HideParticle()
	end
	self:GameTimer(0.2, function()
		if IsInjurable(I, J) and IsValid(self) then
			I:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Impact")
		end
	end)
	self:GameTimer(0.4, function()
		if IsInjurable(I, J) and IsValid(self) then
			if I:HasModifier("modifier_wasteland_guardian_ult") then
				K = K + I:FindModifierByName("modifier_wasteland_guardian_ult"):GetRemainingTime()
			end
			I:AddNewModifier(I, self, "modifier_wasteland_guardian_ult", { duration = K })
		end
	end)
end
function H.prototype.ShockWave(self, L, M)
	if L == nil then
		L = self:GetSpecialValueFor("damage")
	end
	local I = self:GetCaster()
	local J = I:GetEnemy()
	if not IsInjurable(I, J) then
		return
	end
	if M == nil then
		local N = I:GetAbsOrigin()
		local O = J:GetAbsOrigin() - N
		O.z = 0
		O = O:Normalized()
		M = GetGroundPosition(N + O * 150, I)
	end
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_epicenter.vpcf",
		PATTACH_CUSTOMORIGIN,
		I
	)
	ParticleManager:SetParticleControl(x, 0, M)
	ParticleManager:SetParticleControl(x, 1, Vector(800, 800, 800))
	ParticleManager:ReleaseParticleIndex(x)
	if RollPercentage(50) then
		EmitSoundOnLocationWithCaster(M, "Hero_Dawnbreaker.Solar_Guardian.Impact", I)
	else
		EmitSoundOnLocationWithCaster(M, "Hero_Dawnbreaker.Solar_Guardian.Impact.Layer", I)
	end
	local P = self:GetSpecialValueFor("shield_gain_pct")
	AddShield(I, P, self:GetAbilityName(), "Ability")
	I:DealDamage(J, self, L, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
end
H = e({ r(nil) }, H)
i.wasteland_guardian_ult = H
i.modifier_wasteland_guardian_ult = c()
local Q = i.modifier_wasteland_guardian_ult
Q.name = "modifier_wasteland_guardian_ult"
d(Q, n)
function Q.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.damageList = {}
	self.working = false
end
function Q.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.base_count = self:GetAbilitySpecialValueFor("base_count")
	self.bonus_count = self:GetAbilitySpecialValueFor("bonus_count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.attack_reduce_pct = self:GetAbilitySpecialValueFor("attack_reduce_pct")
	self.talent_2_shield_bonus = self:GetAbilityTalentValue("wasteland_guardian_talent_2", "shield_bonus")
end
function Q.prototype.OnCreated(self, u)
	if IsServer() then
		local v = self:GetParent()
		local J = v:GetEnemy()
		if not IsInjurable(v, J) then
			self:Destroy()
			return
		end
		local N = v:GetAbsOrigin()
		local O = J:GetAbsOrigin() - N
		O.z = 0
		O = O:Normalized()
		self.damageOriginPos = GetGroundPosition(N + O * 150, v)
		self.particleID = ParticleManager:CreateParticle(
			"particles/units/heroes/wasteland_guardian/wasteland_guardian_ult.vpcf",
			PATTACH_CUSTOMORIGIN,
			v
		)
		ParticleManager:SetParticleControlTransform(self.particleID, 0, self.damageOriginPos, DirectionToQAngle(nil, O))
		ParticleManager:SetParticleControl(self.particleID, 1, self.damageOriginPos)
		ParticleManager:SetParticleControl(self.particleID, 2, Vector(200, 200, 200))
		self:StackDamage()
		self:calculateInterval()
	end
end
function Q.prototype.OnRefresh(self, u)
	if IsServer() then
		local v = self:GetParent()
		local J = v:GetEnemy()
		if not IsInjurable(v, J) then
			self:Destroy()
			return
		end
		if self.particleID == nil then
			local N = v:GetAbsOrigin()
			local O = J:GetAbsOrigin() - N
			O.z = 0
			O = O:Normalized()
			self.damageOriginPos = GetGroundPosition(N + O * 150, v)
			self.particleID = ParticleManager:CreateParticle(
				"particles/units/heroes/wasteland_guardian/wasteland_guardian_ult.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlTransform(
				self.particleID,
				0,
				self.damageOriginPos,
				DirectionToQAngle(nil, O)
			)
			ParticleManager:SetParticleControl(self.particleID, 1, self.damageOriginPos)
			ParticleManager:SetParticleControl(self.particleID, 2, Vector(200, 200, 200))
		end
		self:StackDamage()
		self:calculateInterval()
	end
end
function Q.prototype.HideParticle(self)
	if IsServer() then
		if self.particleID ~= nil then
			ParticleManager:DestroyParticle(self.particleID, false)
			ParticleManager:ReleaseParticleIndex(self.particleID)
			self.particleID = nil
		end
	end
end
function Q.prototype.StackDamage(self)
	local y = self.base_count
	local v = self:GetParent()
	if v:HasModifier("modifier_wasteland_guardian_overload") then
		local R = v:FindModifierByName("modifier_wasteland_guardian_overload"):GetStackCount()
		y = y + R * self.bonus_count
	end
	local S = self.damageList
	S[#S + 1] = { damage = self.damage, count = y }
	return y
end
function Q.prototype.OnIntervalThink(self)
	self:ShockWave()
end
function Q.prototype.ShockWave(self)
	if #self.damageList == 0 then
		return
	end
	local T = self.damageList[1]
	local L = T.damage
	local w = self:GetAbility()
	if IsValid(w) then
		w:ShockWave(L, self.damageOriginPos)
	end
	T.count = T.count - 1
	if T.count <= 0 then
		self.working = false
		g(self.damageList, 0, 1)
		self:calculateInterval()
	end
end
function Q.prototype.calculateInterval(self)
	if self.working then
		return
	end
	if #self.damageList == 0 then
		self.working = false
		self:StartIntervalThink(-1)
		return
	end
	local y = self.damageList[1].count
	if y > 0 then
		self.working = true
		self:StartIntervalThink(self.duration / y)
	else
		self.working = false
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end
function Q.prototype.OnDestroy(self)
	if IsServer() then
		self:ShockWave()
		self:HideParticle()
	end
end
function Q.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE] = -self.attack_reduce_pct,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE] = self.talent_2_shield_bonus,
	}
end
function Q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function Q.prototype.OnBattleEnd(self, u)
	self.damageList = {}
	self.working = false
	self:StartIntervalThink(-1)
	self:Destroy()
end
function Q.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function Q.prototype.GetActivityTranslationModifiers(self)
	return "activity_no_weapon"
end
function Q.prototype.GetAttackSound(self)
	return "Hero_Axe.Attack.Jungle"
end
Q = e(
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
	Q
)
i.modifier_wasteland_guardian_ult = Q
return i