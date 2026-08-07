--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/pudge"
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
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 7,
		["29"] = 7,
		["30"] = 12,
		["31"] = 20,
		["32"] = 12,
		["33"] = 20,
		["35"] = 20,
		["36"] = 29,
		["37"] = 12,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["43"] = 39,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 33,
		["51"] = 48,
		["52"] = 49,
		["53"] = 50,
		["55"] = 48,
		["56"] = 53,
		["57"] = 54,
		["58"] = 54,
		["59"] = 56,
		["60"] = 56,
		["61"] = 56,
		["62"] = 54,
		["63"] = 54,
		["64"] = 54,
		["65"] = 54,
		["66"] = 53,
		["67"] = 61,
		["68"] = 62,
		["69"] = 63,
		["70"] = 64,
		["71"] = 65,
		["72"] = 66,
		["74"] = 61,
		["75"] = 72,
		["76"] = 73,
		["77"] = 74,
		["80"] = 75,
		["81"] = 76,
		["82"] = 77,
		["84"] = 79,
		["85"] = 80,
		["86"] = 81,
		["87"] = 82,
		["90"] = 72,
		["91"] = 86,
		["92"] = 87,
		["93"] = 88,
		["94"] = 89,
		["95"] = 90,
		["98"] = 86,
		["99"] = 94,
		["100"] = 95,
		["101"] = 94,
		["102"] = 101,
		["103"] = 102,
		["104"] = 102,
		["106"] = 103,
		["107"] = 104,
		["108"] = 104,
		["109"] = 104,
		["110"] = 104,
		["111"] = 104,
		["112"] = 104,
		["113"] = 104,
		["114"] = 105,
		["115"] = 106,
		["116"] = 101,
		["117"] = 108,
		["118"] = 109,
		["119"] = 108,
		["120"] = 111,
		["121"] = 112,
		["122"] = 112,
		["123"] = 112,
		["124"] = 112,
		["125"] = 111,
		["126"] = 114,
		["127"] = 115,
		["130"] = 117,
		["131"] = 118,
		["132"] = 119,
		["134"] = 114,
		["135"] = 123,
		["136"] = 124,
		["137"] = 125,
		["138"] = 125,
		["139"] = 125,
		["140"] = 125,
		["141"] = 125,
		["142"] = 123,
		["143"] = 127,
		["144"] = 128,
		["145"] = 128,
		["146"] = 128,
		["147"] = 128,
		["148"] = 128,
		["149"] = 128,
		["151"] = 128,
		["152"] = 129,
		["153"] = 127,
		["154"] = 20,
		["155"] = 12,
		["156"] = 12,
		["157"] = 12,
		["158"] = 12,
		["159"] = 12,
		["160"] = 12,
		["161"] = 12,
		["162"] = 12,
		["163"] = 20,
		["165"] = 20,
		["167"] = 135,
		["168"] = 136,
		["169"] = 135,
		["170"] = 136,
		["171"] = 137,
		["172"] = 138,
		["173"] = 139,
		["174"] = 140,
		["175"] = 141,
		["176"] = 143,
		["177"] = 144,
		["178"] = 145,
		["180"] = 137,
		["181"] = 136,
		["182"] = 135,
		["183"] = 136,
		["185"] = 136,
		["186"] = 149,
		["187"] = 157,
		["188"] = 149,
		["189"] = 157,
		["190"] = 167,
		["191"] = 168,
		["192"] = 169,
		["193"] = 170,
		["194"] = 171,
		["195"] = 172,
		["196"] = 174,
		["197"] = 175,
		["198"] = 167,
		["199"] = 177,
		["200"] = 178,
		["201"] = 179,
		["202"] = 180,
		["204"] = 182,
		["205"] = 182,
		["206"] = 182,
		["207"] = 182,
		["208"] = 182,
		["209"] = 183,
		["210"] = 183,
		["211"] = 183,
		["212"] = 183,
		["213"] = 183,
		["214"] = 184,
		["215"] = 184,
		["216"] = 184,
		["217"] = 184,
		["218"] = 184,
		["219"] = 184,
		["220"] = 184,
		["221"] = 184,
		["223"] = 177,
		["224"] = 187,
		["225"] = 188,
		["226"] = 189,
		["228"] = 187,
		["229"] = 192,
		["230"] = 193,
		["231"] = 194,
		["232"] = 195,
		["233"] = 197,
		["234"] = 198,
		["235"] = 198,
		["236"] = 198,
		["237"] = 198,
		["238"] = 198,
		["239"] = 198,
		["240"] = 198,
		["241"] = 198,
		["242"] = 198,
		["243"] = 200,
		["244"] = 201,
		["247"] = 192,
		["248"] = 205,
		["249"] = 206,
		["250"] = 205,
		["251"] = 210,
		["252"] = 212,
		["253"] = 213,
		["255"] = 210,
		["256"] = 216,
		["257"] = 217,
		["258"] = 218,
		["259"] = 218,
		["260"] = 217,
		["261"] = 216,
		["262"] = 221,
		["263"] = 223,
		["264"] = 224,
		["265"] = 225,
		["267"] = 221,
		["268"] = 157,
		["269"] = 149,
		["270"] = 149,
		["271"] = 149,
		["272"] = 149,
		["273"] = 149,
		["274"] = 149,
		["275"] = 149,
		["276"] = 149,
		["277"] = 157,
		["279"] = 157,
		["281"] = 235,
		["282"] = 236,
		["283"] = 235,
		["284"] = 236,
		["285"] = 237,
		["286"] = 238,
		["287"] = 237,
		["288"] = 236,
		["289"] = 235,
		["290"] = 236,
		["292"] = 236,
		["293"] = 241,
		["294"] = 248,
		["295"] = 241,
		["296"] = 248,
		["297"] = 250,
		["298"] = 251,
		["299"] = 250,
		["300"] = 253,
		["301"] = 254,
		["302"] = 253,
		["303"] = 258,
		["304"] = 259,
		["305"] = 260,
		["306"] = 261,
		["307"] = 262,
		["309"] = 264,
		["310"] = 258,
		["311"] = 248,
		["312"] = 241,
		["313"] = 241,
		["314"] = 241,
		["315"] = 241,
		["316"] = 241,
		["317"] = 241,
		["318"] = 241,
		["319"] = 248,
		["321"] = 248,
		["323"] = 269,
		["324"] = 270,
		["325"] = 269,
		["326"] = 270,
		["327"] = 271,
		["328"] = 272,
		["329"] = 271,
		["330"] = 270,
		["331"] = 269,
		["332"] = 270,
		["334"] = 270,
		["335"] = 275,
		["336"] = 283,
		["337"] = 275,
		["338"] = 283,
		["339"] = 285,
		["340"] = 286,
		["341"] = 285,
		["342"] = 288,
		["343"] = 289,
		["344"] = 290,
		["346"] = 288,
		["347"] = 293,
		["348"] = 294,
		["349"] = 293,
		["350"] = 298,
		["351"] = 299,
		["352"] = 298,
		["353"] = 283,
		["354"] = 275,
		["355"] = 275,
		["356"] = 275,
		["357"] = 275,
		["358"] = 275,
		["359"] = 275,
		["360"] = 275,
		["361"] = 275,
		["362"] = 283,
		["364"] = 283,
		["366"] = 304,
		["367"] = 312,
		["368"] = 304,
		["369"] = 312,
		["370"] = 314,
		["371"] = 315,
		["372"] = 314,
		["373"] = 317,
		["374"] = 318,
		["375"] = 317,
		["376"] = 322,
		["377"] = 323,
		["378"] = 322,
		["379"] = 312,
		["380"] = 304,
		["381"] = 304,
		["382"] = 304,
		["383"] = 304,
		["384"] = 304,
		["385"] = 304,
		["386"] = 304,
		["387"] = 304,
		["388"] = 312,
		["390"] = 312,
		["392"] = 328,
		["393"] = 329,
		["394"] = 328,
		["395"] = 329,
		["396"] = 330,
		["397"] = 331,
		["398"] = 330,
		["399"] = 329,
		["400"] = 328,
		["401"] = 329,
		["403"] = 329,
		["404"] = 334,
		["405"] = 342,
		["406"] = 334,
		["407"] = 342,
		["408"] = 344,
		["409"] = 345,
		["410"] = 344,
		["411"] = 347,
		["412"] = 348,
		["413"] = 349,
		["415"] = 347,
		["416"] = 352,
		["417"] = 353,
		["418"] = 352,
		["419"] = 357,
		["420"] = 358,
		["421"] = 357,
		["422"] = 342,
		["423"] = 334,
		["424"] = 334,
		["425"] = 334,
		["426"] = 334,
		["427"] = 334,
		["428"] = 334,
		["429"] = 334,
		["430"] = 334,
		["431"] = 342,
		["433"] = 342,
		["434"] = 361,
		["435"] = 369,
		["436"] = 361,
		["437"] = 369,
		["438"] = 372,
		["439"] = 373,
		["440"] = 374,
		["441"] = 372,
		["442"] = 376,
		["443"] = 377,
		["444"] = 376,
		["445"] = 379,
		["446"] = 380,
		["447"] = 380,
		["448"] = 380,
		["449"] = 380,
		["450"] = 380,
		["451"] = 380,
		["452"] = 380,
		["453"] = 379,
		["454"] = 369,
		["455"] = 361,
		["456"] = 361,
		["457"] = 361,
		["458"] = 361,
		["459"] = 361,
		["460"] = 361,
		["461"] = 361,
		["462"] = 361,
		["463"] = 369,
		["465"] = 369,
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
g.pudge_talent = c()
local q = g.pudge_talent
q.name = "pudge_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent"
end
q = e({ j(nil) }, q)
g.pudge_talent = q
g.modifier_pudge_talent = c()
local r = g.modifier_pudge_talent
r.name = "modifier_pudge_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.g_health_bonus = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
	self.max_health = self:GetAbilitySpecialValueFor("max_health")
		+ self:GetAbilityTalentValue("pudge_talent_5", "threshold_bonus")
	self.passive_pct = self:GetAbilityTalentValue("pudge_talent_2", "passive_pct")
	self.pct = self:GetAbilityTalentValue("pudge_talent_7", "pct")
	self.s_stack = self:GetAbilityTalentValue("pudge_shard", "stack")
	self.passive_pct = self:GetAbilityTalentValue("pudge_talent_5", "passive_pct")
	local s = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_max_health = (s and s:GetAbilityName()) == "trait_190" and s:GetSpecialValueFor("health") or 0
	self.max_health = self.max_health + (
			(s and s:GetAbilityName()) == "trait_190" and s:GetSpecialValueFor("limit") or 0
		)
	self.tl2_steal_health_min = self:GetAbilityTalentValue("pudge_talent_2", "skill_steal_health_min")
	self.tl2_steal_health_max = self:GetAbilityTalentValue("pudge_talent_2", "skill_steal_health_max")
end
function r.prototype.OnCreated(self, t)
	if IsServer() then
		self.battling = false
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, t)
	self.battling = true
	if self.s_stack > 0 then
		local u = self:LoadShardStack()
		self.max_health = self.max_health + u * self.s_stack
		self:SetStackCount(u * self.s_stack)
	end
end
function r.prototype.OnBattleEnd(self, t)
	self.battling = false
	if t.isNeutral or t.illusionPlayerID then
		return
	end
	local v = self:GetParent():GetPlayerOwnerID()
	if t.illusionPlayerID ~= v and t.winPlayerID == v then
		self:SaveShardStack()
	end
	if self.g_max_health > 0 and t.winPlayerID == v then
		local w = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if w then
			w:addProperty("item_health", self.g_max_health)
		end
	end
end
function r.prototype.OnBattleStart(self, t)
	if IsServer() then
		if self:HasTalent("pudge_shard") then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_shard_debuff", {})
			self.parent:GetEnemy():AddNewModifier(self.parent, self.ability, "modifier_shard_debuff", {})
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL,
	}
end
function r.prototype.EOM_GetModifierAbilityLifesteal(self, t)
	if not self:HasTalent("pudge_talent_2") then
		return 0
	end
	local x = self:GetParent():GetHealth() / self:GetParent():GetMaxHealth() * 100
	local y = math.min(9, math.max(0, math.floor((100 - x) / 10)))
	local z = (self.tl2_steal_health_max - self.tl2_steal_health_min) / 9
	return self.tl2_steal_health_min + y * z
end
function r.prototype.EOM_GetModifierParryDamage(self)
	return self:EOM_GetModifierHealthBonus() * self.pct * 0.01
end
function r.prototype.EOM_GetModifierHealthBonus(self)
	return math.min(self:GetStackCount() + self.g_health_bonus, self.max_health)
end
function r.prototype.OnCustomTakeDamage(self, t)
	if not self.battling or self:GetCaster():PassivesDisabled() then
		return
	end
	if t.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		local A = self:GetStackCount() + math.floor(t.damage * (self.health_pct + self.passive_pct) * 0.01)
		self:SetStackCount(math.min(A, self.max_health))
	end
end
function r.prototype.SaveShardStack(self)
	local B = self:LoadShardStack() + 1
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "pudge_shard", B)
end
function r.prototype.LoadShardStack(self)
	local C = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "pudge_shard")
	if C == nil then
		C = 0
	end
	local u = C
	return u
end
r = e(
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
	r
)
g.modifier_pudge_talent = r
g.pudge_ult = c()
local D = g.pudge_ult
D.name = "pudge_ult"
d(D, o)
function D.prototype.OnSpellStart(self)
	local E = self:GetCaster()
	local F = self:GetSpecialValueFor("duration") + self:GetTalentValue("pudge_talent_1", "duration")
	E:StartGesture(ACT_DOTA_CAST_ABILITY_ROT)
	E:AddNewModifier(E, self, "modifier_pudge_ult", { duration = F })
	local G = self:GetTalentValue("pudge_talent_9", "duration")
	if G > 0 then
		E:AddNewModifier(E, self, "modifier_pudge_talent_9", { duration = G })
	end
end
D = e({ p(nil) }, D)
g.pudge_ult = D
g.modifier_pudge_ult = c()
local H = g.modifier_pudge_ult
H.name = "modifier_pudge_ult"
d(H, l)
function H.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
		+ self:GetAbilityTalentValue("pudge_talent_12", "health_pct")
	self.damage_reduce_pct = self:GetAbilityTalentValue("pudge_talent_4", "damage_reduce_pct")
	self.chance = self:GetAbilityTalentValue("pudge_talent_6", "chance")
	self.heal = self:GetAbilityTalentValue("pudge_talent_6", "heal")
	self.talent_11_chance = self:GetAbilityTalentValue("pudge_talent_11", "chance")
	self.shield = self:GetAbilityTalentValue("pudge_talent_11", "shield")
end
function H.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:GetParent():EmitSound("Greevil.Rot")
	else
		local I = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pudge/pudge_rot.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(I, 1, Vector(450, 0, 0))
		self:AddParticle(I, false, false, -1, false, false)
	end
end
function H.prototype.OnRemoved(self)
	if IsServer() then
		self:GetParent():StopSound("Greevil.Rot")
	end
end
function H.prototype.OnIntervalThink(self)
	local J = self:GetParent()
	local K = J:GetEnemy()
	if IsInjurable(J, K) then
		local L = math.ceil(J:GetMaxHealth() * self.health_pct * 0.01)
		local M = AddPoison
		local N = self:GetAbility()
		M(J, K, L, N and N:GetAbilityName(), "Ability")
		if self:PRD(self.chance, "chance") then
			Heal(J, self.heal, "pudge_talent_6", "Ability")
		end
	end
end
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function H.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	if self.damage_reduce_pct > 0 then
		return -self.damage_reduce_pct
	end
end
function H.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function H.prototype.OnPoisonTakeDamage(self, t)
	if self:PRD(self.talent_11_chance, "talent_11_chance") then
		local O = self:GetParent()
		AddShield(O, self.shield, "pudge_talent_11", "Ability")
	end
end
H = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	H
)
g.modifier_pudge_ult = H
g.pudge_talent_3 = c()
local P = g.pudge_talent_3
P.name = "pudge_talent_3"
d(P, o)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent_3"
end
P = e({ j(nil) }, P)
g.pudge_talent_3 = P
g.modifier_pudge_talent_3 = c()
local Q = g.modifier_pudge_talent_3
Q.name = "modifier_pudge_talent_3"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.damage_block = self:GetAbilitySpecialValueFor("damage_block")
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE }
end
function Q.prototype.EOM_GetModifierParryDamage(self)
	local J = self:GetParent()
	local R = J:GetEnemy()
	if IsValid(R) then
		return math.floor(GetPoison(R) * self.damage_block * 0.01)
	end
	return 0
end
Q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	Q
)
g.modifier_pudge_talent_3 = Q
g.pudge_talent_8 = c()
local S = g.pudge_talent_8
S.name = "pudge_talent_8"
d(S, i)
function S.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent_8"
end
S = e({ j(nil) }, S)
g.pudge_talent_8 = S
g.modifier_pudge_talent_8 = c()
local T = g.modifier_pudge_talent_8
T.name = "modifier_pudge_talent_8"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.poison_damage_per_victory = self:GetAbilitySpecialValueFor("poison_damage_per_victory")
end
function T.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.poison_damage_per_victory)
	end
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_PERCENTAGE }
end
function T.prototype.EOM_GetModifierPoisonDamageBonusPercent(self)
	return self:GetStackCount()
end
T = e(
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
	T
)
g.modifier_pudge_talent_8 = T
g.modifier_pudge_talent_9 = c()
local U = g.modifier_pudge_talent_9
U.name = "modifier_pudge_talent_9"
d(U, l)
function U.prototype.GetAbilitySpecialValue(self)
	self.poison_immunity_chance = self:GetAbilityTalentValue("pudge_talent_9", "poison_immunity_chance")
end
function U.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_POISON_PERCENTAGE }
end
function U.prototype.EOM_GetModifierIgnorePoisonPercent(self)
	return self.poison_immunity_chance
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
g.modifier_pudge_talent_9 = U
g.pudge_talent_10 = c()
local V = g.pudge_talent_10
V.name = "pudge_talent_10"
d(V, i)
function V.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent_10"
end
V = e({ j(nil) }, V)
g.pudge_talent_10 = V
g.modifier_pudge_talent_10 = c()
local W = g.modifier_pudge_talent_10
W.name = "modifier_pudge_talent_10"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.health_per_victory = self:GetAbilitySpecialValueFor("health_per_victory")
end
function W.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.health_per_victory)
	end
end
function W.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function W.prototype.EOM_GetModifierPoisonDamageBonusPercent(self)
	return self:GetStackCount()
end
W = e(
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
	W
)
g.modifier_pudge_talent_10 = W
g.modifier_shard_debuff = c()
local X = g.modifier_shard_debuff
X.name = "modifier_shard_debuff"
d(X, l)
function X.prototype.GetAbilitySpecialValue(self)
	self.poison_stack = self:GetAbilityTalentValue("pudge_shard", "poison_stack")
	self.interval = self:GetAbilityTalentValue("pudge_shard", "interval")
end
function X.prototype.OnCreated(self, t)
	self:StartIntervalThink(self.interval)
end
function X.prototype.OnIntervalThink(self)
	AddPoison(self:GetCaster(), self:GetParent(), self.poison_stack, "pudge_shard", "Ability")
end
X = e(
	{
		m(
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
	X
)
g.modifier_shard_debuff = X
return g