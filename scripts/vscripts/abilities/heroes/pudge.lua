--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["47"] = 45,
		["48"] = 46,
		["50"] = 48,
		["51"] = 49,
		["52"] = 33,
		["53"] = 51,
		["54"] = 52,
		["55"] = 53,
		["57"] = 51,
		["58"] = 56,
		["59"] = 57,
		["60"] = 57,
		["61"] = 59,
		["62"] = 59,
		["63"] = 59,
		["64"] = 57,
		["65"] = 57,
		["66"] = 57,
		["67"] = 57,
		["68"] = 56,
		["69"] = 64,
		["70"] = 65,
		["71"] = 66,
		["72"] = 67,
		["73"] = 68,
		["74"] = 69,
		["76"] = 64,
		["77"] = 75,
		["78"] = 76,
		["79"] = 77,
		["82"] = 78,
		["83"] = 79,
		["84"] = 80,
		["86"] = 82,
		["87"] = 83,
		["88"] = 84,
		["89"] = 85,
		["92"] = 75,
		["93"] = 89,
		["94"] = 90,
		["95"] = 91,
		["96"] = 92,
		["97"] = 93,
		["100"] = 89,
		["101"] = 97,
		["102"] = 98,
		["103"] = 97,
		["104"] = 104,
		["105"] = 105,
		["106"] = 105,
		["108"] = 106,
		["109"] = 107,
		["110"] = 107,
		["111"] = 107,
		["112"] = 107,
		["113"] = 107,
		["114"] = 107,
		["115"] = 107,
		["116"] = 108,
		["117"] = 109,
		["118"] = 104,
		["119"] = 111,
		["120"] = 112,
		["121"] = 111,
		["122"] = 114,
		["123"] = 115,
		["124"] = 115,
		["125"] = 115,
		["126"] = 115,
		["127"] = 114,
		["128"] = 117,
		["129"] = 118,
		["132"] = 120,
		["133"] = 121,
		["134"] = 122,
		["136"] = 117,
		["137"] = 126,
		["138"] = 127,
		["139"] = 128,
		["140"] = 128,
		["141"] = 128,
		["142"] = 128,
		["143"] = 128,
		["144"] = 126,
		["145"] = 130,
		["146"] = 131,
		["147"] = 131,
		["148"] = 131,
		["149"] = 131,
		["150"] = 131,
		["151"] = 131,
		["153"] = 131,
		["154"] = 132,
		["155"] = 130,
		["156"] = 20,
		["157"] = 12,
		["158"] = 12,
		["159"] = 12,
		["160"] = 12,
		["161"] = 12,
		["162"] = 12,
		["163"] = 12,
		["164"] = 12,
		["165"] = 20,
		["167"] = 20,
		["169"] = 138,
		["170"] = 139,
		["171"] = 138,
		["172"] = 139,
		["173"] = 140,
		["174"] = 141,
		["175"] = 142,
		["176"] = 143,
		["177"] = 144,
		["178"] = 146,
		["179"] = 147,
		["180"] = 148,
		["182"] = 140,
		["183"] = 139,
		["184"] = 138,
		["185"] = 139,
		["187"] = 139,
		["188"] = 152,
		["189"] = 160,
		["190"] = 152,
		["191"] = 160,
		["192"] = 170,
		["193"] = 171,
		["194"] = 172,
		["195"] = 173,
		["196"] = 174,
		["197"] = 175,
		["198"] = 177,
		["199"] = 178,
		["200"] = 170,
		["201"] = 180,
		["202"] = 181,
		["203"] = 182,
		["204"] = 183,
		["206"] = 185,
		["207"] = 185,
		["208"] = 185,
		["209"] = 185,
		["210"] = 185,
		["211"] = 186,
		["212"] = 186,
		["213"] = 186,
		["214"] = 186,
		["215"] = 186,
		["216"] = 187,
		["217"] = 187,
		["218"] = 187,
		["219"] = 187,
		["220"] = 187,
		["221"] = 187,
		["222"] = 187,
		["223"] = 187,
		["225"] = 180,
		["226"] = 190,
		["227"] = 191,
		["228"] = 192,
		["230"] = 190,
		["231"] = 195,
		["232"] = 196,
		["233"] = 197,
		["234"] = 198,
		["235"] = 200,
		["236"] = 201,
		["237"] = 201,
		["238"] = 201,
		["239"] = 201,
		["240"] = 201,
		["241"] = 201,
		["242"] = 201,
		["243"] = 201,
		["244"] = 201,
		["245"] = 203,
		["246"] = 204,
		["249"] = 195,
		["250"] = 208,
		["251"] = 209,
		["252"] = 208,
		["253"] = 213,
		["254"] = 215,
		["255"] = 216,
		["257"] = 213,
		["258"] = 219,
		["259"] = 220,
		["260"] = 221,
		["261"] = 221,
		["262"] = 220,
		["263"] = 219,
		["264"] = 224,
		["265"] = 226,
		["266"] = 227,
		["267"] = 228,
		["269"] = 224,
		["270"] = 160,
		["271"] = 152,
		["272"] = 152,
		["273"] = 152,
		["274"] = 152,
		["275"] = 152,
		["276"] = 152,
		["277"] = 152,
		["278"] = 152,
		["279"] = 160,
		["281"] = 160,
		["283"] = 238,
		["284"] = 239,
		["285"] = 238,
		["286"] = 239,
		["287"] = 240,
		["288"] = 241,
		["289"] = 240,
		["290"] = 239,
		["291"] = 238,
		["292"] = 239,
		["294"] = 239,
		["295"] = 244,
		["296"] = 251,
		["297"] = 244,
		["298"] = 251,
		["299"] = 253,
		["300"] = 254,
		["301"] = 253,
		["302"] = 256,
		["303"] = 257,
		["304"] = 256,
		["305"] = 261,
		["306"] = 262,
		["307"] = 263,
		["308"] = 264,
		["309"] = 265,
		["311"] = 267,
		["312"] = 261,
		["313"] = 251,
		["314"] = 244,
		["315"] = 244,
		["316"] = 244,
		["317"] = 244,
		["318"] = 244,
		["319"] = 244,
		["320"] = 244,
		["321"] = 251,
		["323"] = 251,
		["325"] = 272,
		["326"] = 273,
		["327"] = 272,
		["328"] = 273,
		["329"] = 274,
		["330"] = 275,
		["331"] = 274,
		["332"] = 273,
		["333"] = 272,
		["334"] = 273,
		["336"] = 273,
		["337"] = 278,
		["338"] = 286,
		["339"] = 278,
		["340"] = 286,
		["341"] = 288,
		["342"] = 289,
		["343"] = 288,
		["344"] = 291,
		["345"] = 292,
		["346"] = 293,
		["348"] = 291,
		["349"] = 296,
		["350"] = 297,
		["351"] = 296,
		["352"] = 301,
		["353"] = 302,
		["354"] = 301,
		["355"] = 286,
		["356"] = 278,
		["357"] = 278,
		["358"] = 278,
		["359"] = 278,
		["360"] = 278,
		["361"] = 278,
		["362"] = 278,
		["363"] = 278,
		["364"] = 286,
		["366"] = 286,
		["368"] = 307,
		["369"] = 315,
		["370"] = 307,
		["371"] = 315,
		["372"] = 317,
		["373"] = 318,
		["374"] = 317,
		["375"] = 320,
		["376"] = 321,
		["377"] = 320,
		["378"] = 325,
		["379"] = 326,
		["380"] = 325,
		["381"] = 315,
		["382"] = 307,
		["383"] = 307,
		["384"] = 307,
		["385"] = 307,
		["386"] = 307,
		["387"] = 307,
		["388"] = 307,
		["389"] = 307,
		["390"] = 315,
		["392"] = 315,
		["394"] = 331,
		["395"] = 332,
		["396"] = 331,
		["397"] = 332,
		["398"] = 333,
		["399"] = 334,
		["400"] = 333,
		["401"] = 332,
		["402"] = 331,
		["403"] = 332,
		["405"] = 332,
		["406"] = 337,
		["407"] = 345,
		["408"] = 337,
		["409"] = 345,
		["410"] = 347,
		["411"] = 348,
		["412"] = 347,
		["413"] = 350,
		["414"] = 351,
		["415"] = 352,
		["417"] = 350,
		["418"] = 355,
		["419"] = 356,
		["420"] = 355,
		["421"] = 360,
		["422"] = 361,
		["423"] = 360,
		["424"] = 345,
		["425"] = 337,
		["426"] = 337,
		["427"] = 337,
		["428"] = 337,
		["429"] = 337,
		["430"] = 337,
		["431"] = 337,
		["432"] = 337,
		["433"] = 345,
		["435"] = 345,
		["436"] = 364,
		["437"] = 372,
		["438"] = 364,
		["439"] = 372,
		["440"] = 375,
		["441"] = 376,
		["442"] = 377,
		["443"] = 375,
		["444"] = 379,
		["445"] = 380,
		["446"] = 379,
		["447"] = 382,
		["448"] = 383,
		["449"] = 383,
		["450"] = 383,
		["451"] = 383,
		["452"] = 383,
		["453"] = 383,
		["454"] = 383,
		["455"] = 382,
		["456"] = 372,
		["457"] = 364,
		["458"] = 364,
		["459"] = 364,
		["460"] = 364,
		["461"] = 364,
		["462"] = 364,
		["463"] = 364,
		["464"] = 364,
		["465"] = 372,
		["467"] = 372,
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
	if IsServer() and (s and s:GetAbilityName()) == "trait_190" then
		self.max_health = self.max_health
			+ s:GetSpecialValueFor("limit") * PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID())
	end
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