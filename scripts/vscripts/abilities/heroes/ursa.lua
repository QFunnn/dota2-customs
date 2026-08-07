--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/ursa"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SparseArrayNew
local g = b.__TS__SparseArrayPush
local h = b.__TS__SparseArraySpread
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["20"] = 5,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 7,
		["27"] = 6,
		["28"] = 5,
		["29"] = 6,
		["31"] = 6,
		["32"] = 12,
		["33"] = 20,
		["34"] = 12,
		["35"] = 20,
		["37"] = 20,
		["38"] = 30,
		["39"] = 12,
		["40"] = 37,
		["41"] = 38,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 42,
		["46"] = 44,
		["47"] = 46,
		["48"] = 47,
		["49"] = 48,
		["50"] = 37,
		["51"] = 50,
		["52"] = 51,
		["53"] = 52,
		["54"] = 52,
		["55"] = 52,
		["56"] = 51,
		["57"] = 53,
		["58"] = 53,
		["59"] = 53,
		["60"] = 51,
		["61"] = 51,
		["62"] = 50,
		["63"] = 56,
		["64"] = 57,
		["65"] = 57,
		["66"] = 57,
		["67"] = 57,
		["68"] = 57,
		["69"] = 57,
		["70"] = 57,
		["71"] = 56,
		["72"] = 72,
		["73"] = 73,
		["74"] = 74,
		["75"] = 75,
		["76"] = 76,
		["77"] = 77,
		["80"] = 72,
		["81"] = 81,
		["82"] = 82,
		["83"] = 83,
		["85"] = 81,
		["86"] = 91,
		["87"] = 92,
		["88"] = 91,
		["89"] = 94,
		["90"] = 95,
		["91"] = 94,
		["92"] = 97,
		["93"] = 98,
		["96"] = 99,
		["97"] = 101,
		["98"] = 102,
		["99"] = 103,
		["101"] = 107,
		["102"] = 107,
		["103"] = 107,
		["106"] = 107,
		["107"] = 107,
		["109"] = 107,
		["110"] = 108,
		["111"] = 109,
		["112"] = 109,
		["113"] = 109,
		["114"] = 109,
		["115"] = 109,
		["116"] = 109,
		["118"] = 97,
		["119"] = 20,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 12,
		["126"] = 12,
		["127"] = 12,
		["128"] = 20,
		["130"] = 20,
		["131"] = 118,
		["132"] = 119,
		["133"] = 118,
		["134"] = 119,
		["135"] = 121,
		["136"] = 122,
		["137"] = 121,
		["138"] = 124,
		["139"] = 125,
		["140"] = 126,
		["141"] = 127,
		["142"] = 128,
		["143"] = 131,
		["144"] = 132,
		["146"] = 136,
		["147"] = 137,
		["149"] = 139,
		["150"] = 140,
		["151"] = 140,
		["152"] = 140,
		["153"] = 140,
		["154"] = 141,
		["155"] = 141,
		["156"] = 141,
		["157"] = 141,
		["158"] = 142,
		["159"] = 142,
		["160"] = 142,
		["161"] = 142,
		["163"] = 144,
		["164"] = 124,
		["165"] = 119,
		["166"] = 118,
		["167"] = 119,
		["169"] = 119,
		["170"] = 148,
		["171"] = 156,
		["172"] = 148,
		["173"] = 156,
		["174"] = 164,
		["175"] = 165,
		["176"] = 167,
		["177"] = 168,
		["178"] = 169,
		["179"] = 164,
		["180"] = 171,
		["181"] = 172,
		["182"] = 173,
		["183"] = 174,
		["184"] = 175,
		["185"] = 176,
		["186"] = 177,
		["188"] = 179,
		["190"] = 181,
		["191"] = 182,
		["192"] = 182,
		["193"] = 182,
		["194"] = 182,
		["195"] = 182,
		["196"] = 182,
		["197"] = 182,
		["198"] = 182,
		["199"] = 182,
		["200"] = 183,
		["201"] = 183,
		["202"] = 183,
		["203"] = 183,
		["204"] = 183,
		["205"] = 183,
		["206"] = 183,
		["207"] = 183,
		["208"] = 183,
		["209"] = 184,
		["210"] = 184,
		["211"] = 184,
		["212"] = 184,
		["213"] = 184,
		["214"] = 184,
		["215"] = 184,
		["216"] = 184,
		["217"] = 184,
		["218"] = 185,
		["219"] = 185,
		["220"] = 185,
		["221"] = 185,
		["222"] = 185,
		["223"] = 185,
		["224"] = 185,
		["225"] = 185,
		["227"] = 171,
		["228"] = 188,
		["229"] = 189,
		["230"] = 190,
		["231"] = 191,
		["232"] = 192,
		["233"] = 193,
		["236"] = 188,
		["237"] = 197,
		["238"] = 198,
		["239"] = 197,
		["240"] = 202,
		["241"] = 203,
		["242"] = 202,
		["243"] = 208,
		["244"] = 209,
		["245"] = 208,
		["246"] = 214,
		["247"] = 215,
		["248"] = 216,
		["250"] = 223,
		["252"] = 214,
		["253"] = 226,
		["254"] = 227,
		["255"] = 228,
		["257"] = 226,
		["258"] = 231,
		["259"] = 233,
		["260"] = 231,
		["261"] = 241,
		["262"] = 242,
		["263"] = 243,
		["264"] = 243,
		["265"] = 242,
		["266"] = 241,
		["267"] = 246,
		["268"] = 247,
		["269"] = 248,
		["271"] = 250,
		["272"] = 251,
		["273"] = 252,
		["274"] = 252,
		["275"] = 252,
		["276"] = 252,
		["277"] = 252,
		["278"] = 252,
		["279"] = 252,
		["281"] = 254,
		["282"] = 255,
		["283"] = 256,
		["285"] = 246,
		["286"] = 156,
		["287"] = 148,
		["288"] = 148,
		["289"] = 148,
		["290"] = 148,
		["291"] = 148,
		["292"] = 148,
		["293"] = 148,
		["294"] = 148,
		["295"] = 156,
		["297"] = 156,
		["298"] = 266,
		["299"] = 273,
		["300"] = 266,
		["301"] = 273,
		["302"] = 276,
		["303"] = 277,
		["304"] = 278,
		["305"] = 276,
		["306"] = 280,
		["307"] = 281,
		["308"] = 280,
		["309"] = 273,
		["310"] = 266,
		["311"] = 266,
		["312"] = 266,
		["313"] = 266,
		["314"] = 266,
		["315"] = 266,
		["316"] = 266,
		["317"] = 273,
		["319"] = 273,
		["321"] = 317,
		["322"] = 324,
		["323"] = 317,
		["324"] = 324,
		["325"] = 325,
		["326"] = 326,
		["327"] = 327,
		["329"] = 325,
		["330"] = 330,
		["331"] = 331,
		["332"] = 332,
		["334"] = 330,
		["335"] = 336,
		["336"] = 337,
		["337"] = 336,
		["338"] = 341,
		["339"] = 342,
		["340"] = 341,
		["341"] = 324,
		["342"] = 317,
		["343"] = 317,
		["344"] = 317,
		["345"] = 317,
		["346"] = 317,
		["347"] = 317,
		["348"] = 317,
		["349"] = 324,
		["351"] = 324,
		["353"] = 377,
		["354"] = 378,
		["355"] = 377,
		["356"] = 378,
		["357"] = 379,
		["358"] = 380,
		["359"] = 379,
		["360"] = 378,
		["361"] = 377,
		["362"] = 378,
		["364"] = 378,
		["365"] = 383,
		["366"] = 390,
		["367"] = 383,
		["368"] = 390,
		["369"] = 393,
		["370"] = 394,
		["371"] = 395,
		["372"] = 393,
		["373"] = 397,
		["374"] = 398,
		["375"] = 398,
		["376"] = 400,
		["377"] = 400,
		["378"] = 400,
		["379"] = 398,
		["380"] = 398,
		["381"] = 397,
		["382"] = 403,
		["383"] = 404,
		["384"] = 403,
		["385"] = 406,
		["386"] = 407,
		["387"] = 408,
		["388"] = 406,
		["389"] = 410,
		["390"] = 411,
		["391"] = 412,
		["392"] = 413,
		["393"] = 414,
		["395"] = 410,
		["396"] = 418,
		["397"] = 419,
		["398"] = 418,
		["399"] = 423,
		["400"] = 424,
		["401"] = 423,
		["402"] = 390,
		["403"] = 383,
		["404"] = 383,
		["405"] = 383,
		["406"] = 383,
		["407"] = 383,
		["408"] = 383,
		["409"] = 383,
		["410"] = 390,
		["412"] = 390,
		["414"] = 430,
		["415"] = 431,
		["416"] = 430,
		["417"] = 431,
		["418"] = 432,
		["419"] = 433,
		["420"] = 432,
		["421"] = 431,
		["422"] = 430,
		["423"] = 431,
		["425"] = 431,
		["426"] = 436,
		["427"] = 443,
		["428"] = 436,
		["429"] = 443,
		["430"] = 445,
		["431"] = 446,
		["432"] = 446,
		["433"] = 448,
		["434"] = 448,
		["435"] = 448,
		["436"] = 446,
		["437"] = 446,
		["438"] = 445,
		["439"] = 451,
		["440"] = 452,
		["441"] = 453,
		["442"] = 454,
		["444"] = 451,
		["445"] = 457,
		["446"] = 458,
		["447"] = 459,
		["448"] = 460,
		["450"] = 457,
		["451"] = 443,
		["452"] = 436,
		["453"] = 436,
		["454"] = 436,
		["455"] = 436,
		["456"] = 436,
		["457"] = 436,
		["458"] = 436,
		["459"] = 443,
		["461"] = 443,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
local q = require("abilities.ability_ai")
local r = q.BaseAbilityAI
local s = q.registerAbilityAI
j.ursa_talent = c()
local t = j.ursa_talent
t.name = "ursa_talent"
d(t, l)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_ursa_talent"
end
t = e({ m(nil) }, t)
j.ursa_talent = t
j.modifier_ursa_talent = c()
local u = j.modifier_ursa_talent
u.name = "modifier_ursa_talent"
d(u, o)
function u.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.attack_count = 0
end
function u.prototype.GetAbilitySpecialValue(self)
	self.injury_stack = self:GetAbilitySpecialValueFor("injury_stack")
		+ self:GetAbilityTalentValue("ursa_talent_3", "injury_bonus")
	self.pre_battle_injury_per_victory = self:GetAbilityTalentValue("ursa_talent_2", "pre_battle_injury_per_victory")
	self.per_injury_attackspeed = self:GetAbilityTalentValue("ursa_talent_11", "per_injury_attackspeed")
	self.talent_injury_stack = self:GetAbilityTalentValue("ursa_talent_11", "injury_stack")
	self.health_bonus_per_victory = self:GetAbilityTalentValue("ursa_talent_8", "health_bonus_per_victory")
	self.health_damage_pct = self:GetAbilityTalentValue("ursa_talent_9", "health_damage_pct")
	self.talent_1 = self:HasTalent("ursa_talent_1")
	self.shard_count = self:GetAbilityTalentValue("ursa_shard", "shard_count")
	self.recordCastAbilityCount = 0
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
	}
end
function u.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PRE_BATTLE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
	}
end
function u.prototype.EOM_GetModifierProcAttackDamageBonus(self)
	if self.health_damage_pct > 0 then
		local v = self:GetParent()
		local w = v:GetEnemy()
		if IsInjurable(v) and IsInjurable(w) then
			return v:GetMaxHealth() * self.health_damage_pct * 0.01
		end
	end
end
function u.prototype.EOM_GetModifierHealthBonus(self, x)
	if IsServer() and self.health_bonus_per_victory > 0 then
		return self.health_bonus_per_victory * self:GetTotalWin()
	end
end
function u.prototype.EOM_GetModifierInjuryPreBattle(self)
	return self:GetTotalWin() * self.pre_battle_injury_per_victory
end
function u.prototype.OnCustomAbilityFullyCast(self, y)
	self.recordCastAbilityCount = self.recordCastAbilityCount + 1
end
function u.prototype.OnCustomAttackLanded(self, y)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	local z = self.injury_stack
	if self.attack_count < self.shard_count then
		z = z * 2
		self.attack_count = self.attack_count + 1
	end
	local A = AddInjury
	local B = f(y.attacker, y.target, z)
	local C = self:GetAbility()
	g(B, C and C:GetAbilityName(), "Ability")
	A(h(B))
	if self.talent_1 then
		y.target:AddNewModifier(y.attacker, self:GetAbility(), "modifier_ursa_talent_1_debuff", { iStack = z })
	end
end
u = e(
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
	u
)
j.modifier_ursa_talent = u
j.ursa_ult = c()
local D = j.ursa_ult
D.name = "ursa_ult"
d(D, r)
function D.prototype.setShardEnable(self, E)
	self.shardEnable = E
end
function D.prototype.OnSpellStart(self)
	local F = self:GetCaster()
	local G = self:GetTalentValue("ursa_talent_6", "duration")
	local H = self:GetTalentValue("ursa_talent_12", "debuff_reduce_pct")
	F:AddNewModifier(F, self, "modifier_ursa_ult", { ShardEnable = self.shardEnable })
	if G > 0 then
		F:AddNewModifier(F, self, "modifier_ursa_talent_6", { duration = G })
	end
	if self.shardEnable ~= nil and self.shardEnable > 0 then
		self.shardEnable = self.shardEnable - 1
	end
	if H > 0 then
		ReduceIce(F, GetIce(F) * H * 0.01)
		ReducePoison(F, GetPoison(F) * H * 0.01)
		ReduceInjury(F, GetInjury(F) * H * 0.01)
	end
	F:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
end
D = e({ s(nil) }, D)
j.ursa_ult = D
j.modifier_ursa_ult = c()
local I = j.modifier_ursa_ult
I.name = "modifier_ursa_ult"
d(I, o)
function I.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attack_count = self:GetAbilitySpecialValueFor("attack_count")
		+ self:GetAbilityTalentValue("ursa_talent_4", "attack_count_bonus")
	self.extra_hit_chance = self:GetAbilityTalentValue("ursa_talent_10", "extra_hit_chance")
	self.extra_injury = self:GetAbilityTalentValue("ursa_talent_5", "extra_injury")
end
function I.prototype.OnCreated(self, x)
	local J = self:GetParent()
	if IsServer() then
		self:SetStackCount(self.attack_count)
		local K = x.ShardEnable or 0
		if K > 0 then
			self.shardCount = self.attack_count
		end
		J:EmitSound("Hero_Ursa.Overpower")
	else
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf",
			PATTACH_CUSTOMORIGIN,
			J
		)
		ParticleManager:SetParticleControlEnt(L, 1, J, PATTACH_POINT_FOLLOW, "attach_eye_l", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(L, 2, J, PATTACH_POINT_FOLLOW, "attach_eye_l", vec3_zero, true)
		ParticleManager:SetParticleControlEnt(L, 3, J, PATTACH_POINT_FOLLOW, "attach_back", vec3_zero, true)
		self:AddParticle(L, false, false, -1, false, false)
	end
end
function I.prototype.OnRefresh(self, x)
	if IsServer() then
		self:IncrementStackCount(self.attack_count)
		local K = x.ShardEnable or 0
		if K > 0 then
			self.shardCount = self.shardCount + self.attack_count
		end
	end
end
function I.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function I.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed }
end
function I.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_ATTENUATION_PERCENTAGE,
	}
end
function I.prototype.EOM_GetModifierInjuryAttenuationPercent(self, x)
	if x.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		if self.shardCount and self.shardCount > 0 then
		end
		return -1000
	end
end
function I.prototype.EOM_GetModifierIgnoreEvasion(self, x)
	if x.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		return self.extra_hit_chance
	end
end
function I.prototype.GetActivityTranslationModifiers(self)
	return "overpower" .. tostring(RandomInt(1, 6))
end
function I.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function I.prototype.OnCustomAttackLanded(self, y)
	if self.shardDamageInfo == y then
		self.shardCount = self.shardCount - 1
	end
	if self:HasTalent("ursa_talent_5") then
		local M = self.parent:GetMaxHealth()
		AddInjury(
			self.parent,
			self.parent:GetEnemy(),
			self.extra_injury * M * 0.01,
			self:GetAbility():GetName(),
			"Ability"
		)
	end
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
I = e(
	{
		p(
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
j.modifier_ursa_ult = I
j.modifier_ursa_talent_6 = c()
local N = j.modifier_ursa_talent_6
N.name = "modifier_ursa_talent_6"
d(N, o)
function N.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce_pct = self:GetAbilityTalentValue("ursa_talent_6", "damage_reduce_pct")
	self.duration = self:GetAbilityTalentValue("ursa_talent_6", "duration")
end
function N.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -self.damage_reduce_pct }
end
N = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
j.modifier_ursa_talent_6 = N
j.modifier_ursa_talent_1_debuff = c()
local O = j.modifier_ursa_talent_1_debuff
O.name = "modifier_ursa_talent_1_debuff"
d(O, o)
function O.prototype.OnCreated(self, x)
	if IsServer() then
		self:SetStackCount(x.iStack)
	end
end
function O.prototype.OnRefresh(self, x)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + x.iStack)
	end
end
function O.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function O.prototype.EOM_GetModifierInjuryPermanent(self)
	return self:GetStackCount()
end
O = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	O
)
j.modifier_ursa_talent_1_debuff = O
j.ursa_talent_11 = c()
local P = j.ursa_talent_11
P.name = "ursa_talent_11"
d(P, l)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_ursa_talent_11"
end
P = e({ m(nil) }, P)
j.ursa_talent_11 = P
j.modifier_ursa_talent_11 = c()
local Q = j.modifier_ursa_talent_11
Q.name = "modifier_ursa_talent_11"
d(Q, o)
function Q.prototype.GetAbilitySpecialValue(self)
	self.per_injury_attackspeed = self:GetAbilitySpecialValueFor("per_injury_attackspeed")
	self.injury_stack = self:GetAbilitySpecialValueFor("injury_stack")
end
function Q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function Q.prototype.OnBattleStart(self)
	self:StartIntervalThink(0.1)
end
function Q.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
	self:SetStackCount(0)
end
function Q.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local R = v:GetEnemy()
	if IsInjurable(R) and self.injury_stack > 0 then
		self:SetStackCount(math.floor(GetInjury(R) / self.injury_stack) * self.per_injury_attackspeed)
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function Q.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetStackCount()
end
Q = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	Q
)
j.modifier_ursa_talent_11 = Q
j.ursa_shard = c()
local S = j.ursa_shard
S.name = "ursa_shard"
d(S, l)
function S.prototype.GetIntrinsicModifierName(self)
	return "modifier_ursa_shard"
end
S = e({ m(nil) }, S)
j.ursa_shard = S
j.modifier_ursa_shard = c()
local T = j.modifier_ursa_shard
T.name = "modifier_ursa_shard"
d(T, o)
function T.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function T.prototype.OnBattleStartBefore(self, x)
	local U = self:GetParent():FindAbilityByName("ursa_ult")
	if IsValid(U) then
		U:setShardEnable(1)
	end
end
function T.prototype.OnBattleEnd(self, x)
	local U = self:GetParent():FindAbilityByName("ursa_ult")
	if IsValid(U) then
		U:setShardEnable(0)
	end
end
T = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	T
)
j.modifier_ursa_shard = T
return j