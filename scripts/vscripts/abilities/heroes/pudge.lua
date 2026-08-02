--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["38"] = 32,
		["39"] = 33,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 38,
		["44"] = 40,
		["45"] = 41,
		["46"] = 32,
		["47"] = 43,
		["48"] = 44,
		["49"] = 45,
		["51"] = 43,
		["52"] = 48,
		["53"] = 49,
		["54"] = 49,
		["55"] = 51,
		["56"] = 51,
		["57"] = 51,
		["58"] = 49,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 48,
		["63"] = 56,
		["64"] = 57,
		["65"] = 58,
		["66"] = 59,
		["67"] = 60,
		["68"] = 61,
		["70"] = 56,
		["71"] = 67,
		["72"] = 68,
		["73"] = 69,
		["76"] = 70,
		["77"] = 71,
		["78"] = 72,
		["80"] = 74,
		["81"] = 75,
		["82"] = 76,
		["83"] = 77,
		["86"] = 67,
		["87"] = 82,
		["88"] = 83,
		["89"] = 84,
		["90"] = 85,
		["91"] = 86,
		["93"] = 88,
		["94"] = 89,
		["97"] = 82,
		["98"] = 93,
		["99"] = 94,
		["100"] = 93,
		["101"] = 100,
		["102"] = 101,
		["103"] = 102,
		["105"] = 104,
		["106"] = 100,
		["107"] = 106,
		["108"] = 107,
		["109"] = 106,
		["110"] = 109,
		["111"] = 110,
		["112"] = 110,
		["113"] = 110,
		["114"] = 110,
		["115"] = 109,
		["116"] = 112,
		["117"] = 113,
		["120"] = 115,
		["121"] = 116,
		["122"] = 117,
		["124"] = 112,
		["125"] = 121,
		["126"] = 122,
		["127"] = 123,
		["128"] = 123,
		["129"] = 123,
		["130"] = 123,
		["131"] = 123,
		["132"] = 121,
		["133"] = 125,
		["134"] = 126,
		["135"] = 126,
		["136"] = 126,
		["137"] = 126,
		["138"] = 126,
		["139"] = 126,
		["141"] = 126,
		["142"] = 127,
		["143"] = 125,
		["144"] = 20,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 20,
		["155"] = 20,
		["157"] = 133,
		["158"] = 134,
		["159"] = 133,
		["160"] = 134,
		["161"] = 135,
		["162"] = 136,
		["163"] = 137,
		["164"] = 138,
		["165"] = 139,
		["166"] = 141,
		["167"] = 142,
		["168"] = 143,
		["170"] = 135,
		["171"] = 134,
		["172"] = 133,
		["173"] = 134,
		["175"] = 134,
		["176"] = 147,
		["177"] = 155,
		["178"] = 147,
		["179"] = 155,
		["180"] = 165,
		["181"] = 166,
		["182"] = 167,
		["183"] = 168,
		["184"] = 169,
		["185"] = 170,
		["186"] = 172,
		["187"] = 173,
		["188"] = 165,
		["189"] = 175,
		["190"] = 176,
		["191"] = 177,
		["192"] = 178,
		["194"] = 180,
		["195"] = 180,
		["196"] = 180,
		["197"] = 180,
		["198"] = 180,
		["199"] = 181,
		["200"] = 181,
		["201"] = 181,
		["202"] = 181,
		["203"] = 181,
		["204"] = 182,
		["205"] = 182,
		["206"] = 182,
		["207"] = 182,
		["208"] = 182,
		["209"] = 182,
		["210"] = 182,
		["211"] = 182,
		["213"] = 175,
		["214"] = 185,
		["215"] = 186,
		["216"] = 187,
		["218"] = 185,
		["219"] = 190,
		["220"] = 191,
		["221"] = 192,
		["222"] = 193,
		["223"] = 195,
		["224"] = 196,
		["225"] = 196,
		["226"] = 196,
		["227"] = 196,
		["228"] = 196,
		["229"] = 196,
		["230"] = 196,
		["231"] = 196,
		["232"] = 196,
		["233"] = 198,
		["234"] = 199,
		["237"] = 190,
		["238"] = 203,
		["239"] = 204,
		["240"] = 203,
		["241"] = 208,
		["242"] = 210,
		["243"] = 211,
		["245"] = 208,
		["246"] = 214,
		["247"] = 215,
		["248"] = 216,
		["249"] = 216,
		["250"] = 215,
		["251"] = 214,
		["252"] = 219,
		["253"] = 221,
		["254"] = 222,
		["255"] = 223,
		["257"] = 219,
		["258"] = 155,
		["259"] = 147,
		["260"] = 147,
		["261"] = 147,
		["262"] = 147,
		["263"] = 147,
		["264"] = 147,
		["265"] = 147,
		["266"] = 147,
		["267"] = 155,
		["269"] = 155,
		["271"] = 233,
		["272"] = 234,
		["273"] = 233,
		["274"] = 234,
		["275"] = 235,
		["276"] = 236,
		["277"] = 235,
		["278"] = 234,
		["279"] = 233,
		["280"] = 234,
		["282"] = 234,
		["283"] = 239,
		["284"] = 246,
		["285"] = 239,
		["286"] = 246,
		["287"] = 248,
		["288"] = 249,
		["289"] = 248,
		["290"] = 251,
		["291"] = 252,
		["292"] = 251,
		["293"] = 256,
		["294"] = 257,
		["295"] = 258,
		["296"] = 259,
		["297"] = 260,
		["299"] = 262,
		["300"] = 256,
		["301"] = 246,
		["302"] = 239,
		["303"] = 239,
		["304"] = 239,
		["305"] = 239,
		["306"] = 239,
		["307"] = 239,
		["308"] = 239,
		["309"] = 246,
		["311"] = 246,
		["313"] = 267,
		["314"] = 268,
		["315"] = 267,
		["316"] = 268,
		["317"] = 269,
		["318"] = 270,
		["319"] = 269,
		["320"] = 268,
		["321"] = 267,
		["322"] = 268,
		["324"] = 268,
		["325"] = 273,
		["326"] = 281,
		["327"] = 273,
		["328"] = 281,
		["329"] = 283,
		["330"] = 284,
		["331"] = 283,
		["332"] = 286,
		["333"] = 287,
		["334"] = 288,
		["336"] = 286,
		["337"] = 291,
		["338"] = 292,
		["339"] = 291,
		["340"] = 296,
		["341"] = 297,
		["342"] = 296,
		["343"] = 281,
		["344"] = 273,
		["345"] = 273,
		["346"] = 273,
		["347"] = 273,
		["348"] = 273,
		["349"] = 273,
		["350"] = 273,
		["351"] = 273,
		["352"] = 281,
		["354"] = 281,
		["356"] = 302,
		["357"] = 310,
		["358"] = 302,
		["359"] = 310,
		["360"] = 312,
		["361"] = 313,
		["362"] = 312,
		["363"] = 315,
		["364"] = 316,
		["365"] = 315,
		["366"] = 320,
		["367"] = 321,
		["368"] = 320,
		["369"] = 310,
		["370"] = 302,
		["371"] = 302,
		["372"] = 302,
		["373"] = 302,
		["374"] = 302,
		["375"] = 302,
		["376"] = 302,
		["377"] = 302,
		["378"] = 310,
		["380"] = 310,
		["382"] = 326,
		["383"] = 327,
		["384"] = 326,
		["385"] = 327,
		["386"] = 328,
		["387"] = 329,
		["388"] = 328,
		["389"] = 327,
		["390"] = 326,
		["391"] = 327,
		["393"] = 327,
		["394"] = 332,
		["395"] = 340,
		["396"] = 332,
		["397"] = 340,
		["398"] = 342,
		["399"] = 343,
		["400"] = 342,
		["401"] = 345,
		["402"] = 346,
		["403"] = 347,
		["405"] = 345,
		["406"] = 350,
		["407"] = 351,
		["408"] = 350,
		["409"] = 355,
		["410"] = 356,
		["411"] = 355,
		["412"] = 340,
		["413"] = 332,
		["414"] = 332,
		["415"] = 332,
		["416"] = 332,
		["417"] = 332,
		["418"] = 332,
		["419"] = 332,
		["420"] = 332,
		["421"] = 340,
		["423"] = 340,
		["424"] = 359,
		["425"] = 367,
		["426"] = 359,
		["427"] = 367,
		["428"] = 370,
		["429"] = 371,
		["430"] = 372,
		["431"] = 370,
		["432"] = 374,
		["433"] = 375,
		["434"] = 374,
		["435"] = 377,
		["436"] = 378,
		["437"] = 378,
		["438"] = 378,
		["439"] = 378,
		["440"] = 378,
		["441"] = 378,
		["442"] = 378,
		["443"] = 377,
		["444"] = 367,
		["445"] = 359,
		["446"] = 359,
		["447"] = 359,
		["448"] = 359,
		["449"] = 359,
		["450"] = 359,
		["451"] = 359,
		["452"] = 359,
		["453"] = 367,
		["455"] = 367,
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
	self.g_max_health = self:GetAbilitySpecialValueFor("g_max_health")
	self.tl2_steal_health = self:GetAbilityTalentValue("pudge_talent_2", "skill_steal_health")
end
function r.prototype.OnCreated(self, s)
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
function r.prototype.OnBattleStartBefore(self, s)
	self.battling = true
	if self.s_stack > 0 then
		local t = self:LoadShardStack()
		self.max_health = self.max_health + t * self.s_stack
		self:SetStackCount(t * self.s_stack)
	end
end
function r.prototype.OnBattleEnd(self, s)
	self.battling = false
	if s.isNeutral then
		return
	end
	local u = self:GetParent():GetPlayerOwnerID()
	if s.illusionPlayerID ~= u and s.winPlayerID == u then
		self:SaveShardStack()
	end
	if self.g_max_health > 0 and s.winPlayerID == u then
		local v = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if v then
			v:addProperty("item_health", self.g_max_health)
		end
	end
end
function r.prototype.OnBattleStart(self, s)
	if IsServer() then
		if self:HasTalent("pudge_shard") then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_shard_debuff", {})
			self.parent:GetEnemy():AddNewModifier(self.parent, self.ability, "modifier_shard_debuff", {})
		end
		if self:HasTalent("pudge_talent_2") then
			self.parent:AddNewModifier(self.parent, self.ability, "modifier_talent_2", {})
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
function r.prototype.EOM_GetModifierAbilityLifesteal(self, s)
	if self:HasTalent("pudge_talent_2") then
		return self.tl2_steal_health
	end
	return 0
end
function r.prototype.EOM_GetModifierParryDamage(self)
	return self:EOM_GetModifierHealthBonus() * self.pct * 0.01
end
function r.prototype.EOM_GetModifierHealthBonus(self)
	return math.min(self:GetStackCount() + self.g_health_bonus, self.max_health)
end
function r.prototype.OnCustomTakeDamage(self, s)
	if not self.battling or self:GetCaster():PassivesDisabled() then
		return
	end
	if s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		local w = self:GetStackCount() + math.floor(s.damage * (self.health_pct + self.passive_pct) * 0.01)
		self:SetStackCount(math.min(w, self.max_health))
	end
end
function r.prototype.SaveShardStack(self)
	local x = self:LoadShardStack() + 1
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "pudge_shard", x)
end
function r.prototype.LoadShardStack(self)
	local y = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "pudge_shard")
	if y == nil then
		y = 0
	end
	local t = y
	return t
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
local z = g.pudge_ult
z.name = "pudge_ult"
d(z, o)
function z.prototype.OnSpellStart(self)
	local A = self:GetCaster()
	local B = self:GetSpecialValueFor("duration") + self:GetTalentValue("pudge_talent_1", "duration")
	A:StartGesture(ACT_DOTA_CAST_ABILITY_ROT)
	A:AddNewModifier(A, self, "modifier_pudge_ult", { duration = B })
	local C = self:GetTalentValue("pudge_talent_9", "duration")
	if C > 0 then
		A:AddNewModifier(A, self, "modifier_pudge_talent_9", { duration = C })
	end
end
z = e({ p(nil) }, z)
g.pudge_ult = z
g.modifier_pudge_ult = c()
local D = g.modifier_pudge_ult
D.name = "modifier_pudge_ult"
d(D, l)
function D.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
		+ self:GetAbilityTalentValue("pudge_talent_12", "health_pct")
	self.damage_reduce_pct = self:GetAbilityTalentValue("pudge_talent_4", "damage_reduce_pct")
	self.chance = self:GetAbilityTalentValue("pudge_talent_6", "chance")
	self.heal = self:GetAbilityTalentValue("pudge_talent_6", "heal")
	self.talent_11_chance = self:GetAbilityTalentValue("pudge_talent_11", "chance")
	self.shield = self:GetAbilityTalentValue("pudge_talent_11", "shield")
end
function D.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:GetParent():EmitSound("Greevil.Rot")
	else
		local E = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pudge/pudge_rot.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(E, 1, Vector(450, 0, 0))
		self:AddParticle(E, false, false, -1, false, false)
	end
end
function D.prototype.OnRemoved(self)
	if IsServer() then
		self:GetParent():StopSound("Greevil.Rot")
	end
end
function D.prototype.OnIntervalThink(self)
	local F = self:GetParent()
	local G = F:GetEnemy()
	if IsInjurable(F, G) then
		local H = math.ceil(F:GetMaxHealth() * self.health_pct * 0.01)
		local I = AddPoison
		local J = self:GetAbility()
		I(F, G, H, J and J:GetAbilityName(), "Ability")
		if self:PRD(self.chance, "chance") then
			Heal(F, self.heal, "pudge_talent_6", "Ability")
		end
	end
end
function D.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function D.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	if self.damage_reduce_pct > 0 then
		return -self.damage_reduce_pct
	end
end
function D.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_POISON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function D.prototype.OnPoisonTakeDamage(self, s)
	if self:PRD(self.talent_11_chance, "talent_11_chance") then
		local K = self:GetParent()
		AddShield(K, self.shield, "pudge_talent_11", "Ability")
	end
end
D = e(
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
	D
)
g.modifier_pudge_ult = D
g.pudge_talent_3 = c()
local L = g.pudge_talent_3
L.name = "pudge_talent_3"
d(L, o)
function L.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent_3"
end
L = e({ j(nil) }, L)
g.pudge_talent_3 = L
g.modifier_pudge_talent_3 = c()
local M = g.modifier_pudge_talent_3
M.name = "modifier_pudge_talent_3"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.damage_block = self:GetAbilitySpecialValueFor("damage_block")
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE }
end
function M.prototype.EOM_GetModifierParryDamage(self)
	local F = self:GetParent()
	local N = F:GetEnemy()
	if IsValid(N) then
		return math.floor(GetPoison(N) * self.damage_block * 0.01)
	end
	return 0
end
M = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	M
)
g.modifier_pudge_talent_3 = M
g.pudge_talent_8 = c()
local O = g.pudge_talent_8
O.name = "pudge_talent_8"
d(O, i)
function O.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent_8"
end
O = e({ j(nil) }, O)
g.pudge_talent_8 = O
g.modifier_pudge_talent_8 = c()
local P = g.modifier_pudge_talent_8
P.name = "modifier_pudge_talent_8"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.poison_damage_per_victory = self:GetAbilitySpecialValueFor("poison_damage_per_victory")
end
function P.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.poison_damage_per_victory)
	end
end
function P.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_PERCENTAGE }
end
function P.prototype.EOM_GetModifierPoisonDamageBonusPercent(self)
	return self:GetStackCount()
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
			}
		),
	},
	P
)
g.modifier_pudge_talent_8 = P
g.modifier_pudge_talent_9 = c()
local Q = g.modifier_pudge_talent_9
Q.name = "modifier_pudge_talent_9"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.poison_immunity_chance = self:GetAbilityTalentValue("pudge_talent_9", "poison_immunity_chance")
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_POISON_PERCENTAGE }
end
function Q.prototype.EOM_GetModifierIgnorePoisonPercent(self)
	return self.poison_immunity_chance
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
g.modifier_pudge_talent_9 = Q
g.pudge_talent_10 = c()
local R = g.pudge_talent_10
R.name = "pudge_talent_10"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_pudge_talent_10"
end
R = e({ j(nil) }, R)
g.pudge_talent_10 = R
g.modifier_pudge_talent_10 = c()
local S = g.modifier_pudge_talent_10
S.name = "modifier_pudge_talent_10"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.health_per_victory = self:GetAbilitySpecialValueFor("health_per_victory")
end
function S.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.health_per_victory)
	end
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function S.prototype.EOM_GetModifierPoisonDamageBonusPercent(self)
	return self:GetStackCount()
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
g.modifier_pudge_talent_10 = S
g.modifier_shard_debuff = c()
local T = g.modifier_shard_debuff
T.name = "modifier_shard_debuff"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.poison_stack = self:GetAbilityTalentValue("pudge_shard", "poison_stack")
	self.interval = self:GetAbilityTalentValue("pudge_shard", "interval")
end
function T.prototype.OnCreated(self, s)
	self:StartIntervalThink(self.interval)
end
function T.prototype.OnIntervalThink(self)
	AddPoison(self:GetCaster(), self:GetParent(), self.poison_stack, "pudge_shard", "Ability")
end
T = e(
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
	T
)
g.modifier_shard_debuff = T
return g