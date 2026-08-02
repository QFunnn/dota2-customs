--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 47,
		["51"] = 48,
		["52"] = 37,
		["53"] = 50,
		["54"] = 51,
		["55"] = 52,
		["56"] = 52,
		["57"] = 52,
		["58"] = 51,
		["59"] = 53,
		["60"] = 53,
		["61"] = 53,
		["62"] = 51,
		["63"] = 51,
		["64"] = 50,
		["65"] = 56,
		["66"] = 57,
		["67"] = 57,
		["68"] = 57,
		["69"] = 57,
		["70"] = 57,
		["71"] = 57,
		["72"] = 57,
		["73"] = 56,
		["74"] = 72,
		["75"] = 73,
		["76"] = 74,
		["77"] = 75,
		["78"] = 76,
		["79"] = 77,
		["82"] = 72,
		["83"] = 81,
		["84"] = 82,
		["85"] = 83,
		["87"] = 81,
		["88"] = 86,
		["89"] = 87,
		["90"] = 88,
		["92"] = 86,
		["93"] = 91,
		["94"] = 92,
		["95"] = 91,
		["96"] = 94,
		["97"] = 95,
		["98"] = 94,
		["99"] = 97,
		["100"] = 98,
		["103"] = 99,
		["104"] = 101,
		["105"] = 102,
		["106"] = 103,
		["108"] = 107,
		["109"] = 107,
		["110"] = 107,
		["113"] = 107,
		["114"] = 107,
		["116"] = 107,
		["117"] = 108,
		["118"] = 109,
		["119"] = 109,
		["120"] = 109,
		["121"] = 109,
		["122"] = 109,
		["123"] = 109,
		["125"] = 97,
		["126"] = 20,
		["127"] = 12,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 12,
		["135"] = 20,
		["137"] = 20,
		["138"] = 118,
		["139"] = 119,
		["140"] = 118,
		["141"] = 119,
		["142"] = 121,
		["143"] = 122,
		["144"] = 121,
		["145"] = 124,
		["146"] = 125,
		["147"] = 126,
		["148"] = 127,
		["149"] = 128,
		["150"] = 131,
		["151"] = 132,
		["153"] = 136,
		["154"] = 137,
		["156"] = 139,
		["157"] = 140,
		["158"] = 140,
		["159"] = 140,
		["160"] = 140,
		["161"] = 141,
		["162"] = 141,
		["163"] = 141,
		["164"] = 141,
		["165"] = 142,
		["166"] = 142,
		["167"] = 142,
		["168"] = 142,
		["170"] = 144,
		["171"] = 124,
		["172"] = 119,
		["173"] = 118,
		["174"] = 119,
		["176"] = 119,
		["177"] = 148,
		["178"] = 156,
		["179"] = 148,
		["180"] = 156,
		["181"] = 163,
		["182"] = 164,
		["183"] = 165,
		["184"] = 166,
		["185"] = 167,
		["186"] = 163,
		["187"] = 169,
		["188"] = 170,
		["189"] = 171,
		["190"] = 172,
		["191"] = 173,
		["192"] = 174,
		["193"] = 175,
		["195"] = 177,
		["197"] = 179,
		["198"] = 180,
		["199"] = 180,
		["200"] = 180,
		["201"] = 180,
		["202"] = 180,
		["203"] = 180,
		["204"] = 180,
		["205"] = 180,
		["206"] = 180,
		["207"] = 181,
		["208"] = 181,
		["209"] = 181,
		["210"] = 181,
		["211"] = 181,
		["212"] = 181,
		["213"] = 181,
		["214"] = 181,
		["215"] = 181,
		["216"] = 182,
		["217"] = 182,
		["218"] = 182,
		["219"] = 182,
		["220"] = 182,
		["221"] = 182,
		["222"] = 182,
		["223"] = 182,
		["224"] = 182,
		["225"] = 183,
		["226"] = 183,
		["227"] = 183,
		["228"] = 183,
		["229"] = 183,
		["230"] = 183,
		["231"] = 183,
		["232"] = 183,
		["234"] = 169,
		["235"] = 186,
		["236"] = 187,
		["237"] = 188,
		["238"] = 189,
		["239"] = 190,
		["240"] = 191,
		["243"] = 186,
		["244"] = 195,
		["245"] = 196,
		["246"] = 195,
		["247"] = 200,
		["248"] = 201,
		["249"] = 200,
		["250"] = 206,
		["251"] = 207,
		["252"] = 206,
		["253"] = 212,
		["254"] = 213,
		["255"] = 214,
		["257"] = 221,
		["259"] = 212,
		["260"] = 224,
		["261"] = 225,
		["262"] = 226,
		["264"] = 224,
		["265"] = 229,
		["266"] = 231,
		["267"] = 229,
		["268"] = 239,
		["269"] = 240,
		["270"] = 241,
		["271"] = 241,
		["272"] = 240,
		["273"] = 239,
		["274"] = 244,
		["275"] = 245,
		["276"] = 246,
		["278"] = 248,
		["279"] = 249,
		["280"] = 250,
		["282"] = 244,
		["283"] = 156,
		["284"] = 148,
		["285"] = 148,
		["286"] = 148,
		["287"] = 148,
		["288"] = 148,
		["289"] = 148,
		["290"] = 148,
		["291"] = 148,
		["292"] = 156,
		["294"] = 156,
		["295"] = 260,
		["296"] = 267,
		["297"] = 260,
		["298"] = 267,
		["299"] = 270,
		["300"] = 271,
		["301"] = 272,
		["302"] = 270,
		["303"] = 274,
		["304"] = 275,
		["305"] = 274,
		["306"] = 267,
		["307"] = 260,
		["308"] = 260,
		["309"] = 260,
		["310"] = 260,
		["311"] = 260,
		["312"] = 260,
		["313"] = 260,
		["314"] = 267,
		["316"] = 267,
		["318"] = 311,
		["319"] = 318,
		["320"] = 311,
		["321"] = 318,
		["322"] = 319,
		["323"] = 320,
		["324"] = 321,
		["326"] = 319,
		["327"] = 324,
		["328"] = 325,
		["329"] = 326,
		["331"] = 324,
		["332"] = 330,
		["333"] = 331,
		["334"] = 330,
		["335"] = 335,
		["336"] = 336,
		["337"] = 335,
		["338"] = 318,
		["339"] = 311,
		["340"] = 311,
		["341"] = 311,
		["342"] = 311,
		["343"] = 311,
		["344"] = 311,
		["345"] = 311,
		["346"] = 318,
		["348"] = 318,
		["350"] = 371,
		["351"] = 372,
		["352"] = 371,
		["353"] = 372,
		["354"] = 373,
		["355"] = 374,
		["356"] = 373,
		["357"] = 372,
		["358"] = 371,
		["359"] = 372,
		["361"] = 372,
		["362"] = 377,
		["363"] = 384,
		["364"] = 377,
		["365"] = 384,
		["366"] = 387,
		["367"] = 388,
		["368"] = 389,
		["369"] = 387,
		["370"] = 391,
		["371"] = 392,
		["372"] = 392,
		["373"] = 394,
		["374"] = 394,
		["375"] = 394,
		["376"] = 392,
		["377"] = 392,
		["378"] = 391,
		["379"] = 397,
		["380"] = 398,
		["381"] = 397,
		["382"] = 400,
		["383"] = 401,
		["384"] = 402,
		["385"] = 400,
		["386"] = 404,
		["387"] = 405,
		["388"] = 406,
		["389"] = 407,
		["390"] = 408,
		["392"] = 404,
		["393"] = 412,
		["394"] = 413,
		["395"] = 412,
		["396"] = 417,
		["397"] = 418,
		["398"] = 417,
		["399"] = 384,
		["400"] = 377,
		["401"] = 377,
		["402"] = 377,
		["403"] = 377,
		["404"] = 377,
		["405"] = 377,
		["406"] = 377,
		["407"] = 384,
		["409"] = 384,
		["411"] = 424,
		["412"] = 425,
		["413"] = 424,
		["414"] = 425,
		["415"] = 426,
		["416"] = 427,
		["417"] = 426,
		["418"] = 425,
		["419"] = 424,
		["420"] = 425,
		["422"] = 425,
		["423"] = 430,
		["424"] = 437,
		["425"] = 430,
		["426"] = 437,
		["427"] = 439,
		["428"] = 440,
		["429"] = 440,
		["430"] = 442,
		["431"] = 442,
		["432"] = 442,
		["433"] = 440,
		["434"] = 440,
		["435"] = 439,
		["436"] = 445,
		["437"] = 446,
		["438"] = 447,
		["439"] = 448,
		["441"] = 445,
		["442"] = 451,
		["443"] = 452,
		["444"] = 453,
		["445"] = 454,
		["447"] = 451,
		["448"] = 437,
		["449"] = 430,
		["450"] = 430,
		["451"] = 430,
		["452"] = 430,
		["453"] = 430,
		["454"] = 430,
		["455"] = 430,
		["456"] = 437,
		["458"] = 437,
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
	self.pre_battle_injury_per_victory = self:GetAbilityTalentValue("ursa_talent_2", "pre_battle_injury_per_victory")
	self.per_injury_attackspeed = self:GetAbilityTalentValue("ursa_talent_11", "per_injury_attackspeed")
	self.talent_injury_stack = self:GetAbilityTalentValue("ursa_talent_11", "injury_stack")
	self.health_bonus_per_victory = self:GetAbilityTalentValue("ursa_talent_8", "health_bonus_per_victory")
	self.injury_bonus = self:GetAbilityTalentValue("ursa_talent_3", "injury_bonus")
	self.health_damage_pct = self:GetAbilityTalentValue("ursa_talent_9", "health_damage_pct")
	self.passive_bonus_ulti = self:GetAbilityTalentValue("ursa_talent_5", "passive_bonus_ulti")
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
function u.prototype.EOM_GetModifierInjuryStackBonus(self, x)
	if self.injury_bonus > 0 then
		return self.injury_bonus
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
	local z = self.injury_stack + self.passive_bonus_ulti * self.recordCastAbilityCount
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
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.attack_count = self:GetAbilitySpecialValueFor("attack_count")
		+ self:GetAbilityTalentValue("ursa_talent_4", "attack_count_bonus")
	self.extra_hit_chance = self:GetAbilityTalentValue("ursa_talent_10", "extra_hit_chance")
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
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack,
	}
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
local M = j.modifier_ursa_talent_6
M.name = "modifier_ursa_talent_6"
d(M, o)
function M.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce_pct = self:GetAbilityTalentValue("ursa_talent_6", "damage_reduce_pct")
	self.duration = self:GetAbilityTalentValue("ursa_talent_6", "duration")
end
function M.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -self.damage_reduce_pct }
end
M = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	M
)
j.modifier_ursa_talent_6 = M
j.modifier_ursa_talent_1_debuff = c()
local N = j.modifier_ursa_talent_1_debuff
N.name = "modifier_ursa_talent_1_debuff"
d(N, o)
function N.prototype.OnCreated(self, x)
	if IsServer() then
		self:SetStackCount(x.iStack)
	end
end
function N.prototype.OnRefresh(self, x)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + x.iStack)
	end
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function N.prototype.EOM_GetModifierInjuryPermanent(self)
	return self:GetStackCount()
end
N = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
j.modifier_ursa_talent_1_debuff = N
j.ursa_talent_11 = c()
local O = j.ursa_talent_11
O.name = "ursa_talent_11"
d(O, l)
function O.prototype.GetIntrinsicModifierName(self)
	return "modifier_ursa_talent_11"
end
O = e({ m(nil) }, O)
j.ursa_talent_11 = O
j.modifier_ursa_talent_11 = c()
local P = j.modifier_ursa_talent_11
P.name = "modifier_ursa_talent_11"
d(P, o)
function P.prototype.GetAbilitySpecialValue(self)
	self.per_injury_attackspeed = self:GetAbilitySpecialValueFor("per_injury_attackspeed")
	self.injury_stack = self:GetAbilitySpecialValueFor("injury_stack")
end
function P.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function P.prototype.OnBattleStart(self)
	self:StartIntervalThink(0.1)
end
function P.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
	self:SetStackCount(0)
end
function P.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local Q = v:GetEnemy()
	if IsInjurable(Q) and self.injury_stack > 0 then
		self:SetStackCount(math.floor(GetInjury(Q) / self.injury_stack) * self.per_injury_attackspeed)
	end
end
function P.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function P.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetStackCount()
end
P = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	P
)
j.modifier_ursa_talent_11 = P
j.ursa_shard = c()
local R = j.ursa_shard
R.name = "ursa_shard"
d(R, l)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_ursa_shard"
end
R = e({ m(nil) }, R)
j.ursa_shard = R
j.modifier_ursa_shard = c()
local S = j.modifier_ursa_shard
S.name = "modifier_ursa_shard"
d(S, o)
function S.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function S.prototype.OnBattleStartBefore(self, x)
	local T = self:GetParent():FindAbilityByName("ursa_ult")
	if IsValid(T) then
		T:setShardEnable(1)
	end
end
function S.prototype.OnBattleEnd(self, x)
	local T = self:GetParent():FindAbilityByName("ursa_ult")
	if IsValid(T) then
		T:setShardEnable(0)
	end
end
S = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	S
)
j.modifier_ursa_shard = S
return j