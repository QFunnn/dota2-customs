--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/riki"
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
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["28"] = 7,
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 24,
		["36"] = 27,
		["37"] = 28,
		["38"] = 28,
		["39"] = 28,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 28,
		["44"] = 28,
		["45"] = 27,
		["46"] = 35,
		["47"] = 36,
		["48"] = 37,
		["50"] = 35,
		["51"] = 40,
		["52"] = 41,
		["55"] = 43,
		["56"] = 44,
		["58"] = 40,
		["59"] = 21,
		["60"] = 13,
		["61"] = 13,
		["62"] = 13,
		["63"] = 13,
		["64"] = 13,
		["65"] = 13,
		["66"] = 13,
		["67"] = 13,
		["68"] = 21,
		["70"] = 21,
		["71"] = 52,
		["72"] = 53,
		["73"] = 52,
		["74"] = 53,
		["75"] = 54,
		["76"] = 55,
		["77"] = 56,
		["78"] = 54,
		["79"] = 58,
		["80"] = 59,
		["81"] = 60,
		["82"] = 61,
		["85"] = 62,
		["86"] = 63,
		["87"] = 65,
		["88"] = 66,
		["89"] = 67,
		["91"] = 69,
		["92"] = 58,
		["93"] = 53,
		["94"] = 52,
		["95"] = 53,
		["97"] = 53,
		["99"] = 74,
		["100"] = 83,
		["101"] = 74,
		["102"] = 83,
		["103"] = 92,
		["104"] = 93,
		["105"] = 94,
		["106"] = 96,
		["107"] = 97,
		["108"] = 99,
		["109"] = 100,
		["110"] = 92,
		["111"] = 102,
		["112"] = 105,
		["113"] = 106,
		["114"] = 107,
		["115"] = 108,
		["116"] = 109,
		["117"] = 110,
		["118"] = 110,
		["119"] = 110,
		["120"] = 110,
		["121"] = 110,
		["122"] = 111,
		["123"] = 111,
		["124"] = 111,
		["125"] = 111,
		["126"] = 111,
		["127"] = 112,
		["128"] = 112,
		["129"] = 112,
		["130"] = 112,
		["131"] = 112,
		["132"] = 113,
		["133"] = 113,
		["134"] = 113,
		["135"] = 113,
		["136"] = 113,
		["137"] = 114,
		["138"] = 114,
		["139"] = 114,
		["140"] = 114,
		["141"] = 114,
		["142"] = 114,
		["143"] = 114,
		["144"] = 114,
		["146"] = 102,
		["147"] = 117,
		["148"] = 118,
		["149"] = 119,
		["150"] = 120,
		["151"] = 121,
		["152"] = 122,
		["155"] = 117,
		["156"] = 127,
		["157"] = 128,
		["158"] = 129,
		["159"] = 130,
		["162"] = 131,
		["163"] = 132,
		["164"] = 133,
		["165"] = 135,
		["166"] = 136,
		["168"] = 139,
		["169"] = 140,
		["170"] = 140,
		["171"] = 140,
		["172"] = 140,
		["173"] = 140,
		["174"] = 140,
		["175"] = 140,
		["176"] = 140,
		["177"] = 140,
		["178"] = 141,
		["179"] = 143,
		["180"] = 144,
		["181"] = 145,
		["182"] = 145,
		["183"] = 145,
		["184"] = 145,
		["185"] = 145,
		["186"] = 146,
		["187"] = 147,
		["188"] = 148,
		["189"] = 149,
		["190"] = 149,
		["191"] = 149,
		["192"] = 149,
		["193"] = 149,
		["194"] = 149,
		["195"] = 149,
		["196"] = 150,
		["197"] = 151,
		["198"] = 151,
		["199"] = 151,
		["200"] = 151,
		["201"] = 151,
		["202"] = 151,
		["203"] = 151,
		["204"] = 151,
		["205"] = 151,
		["207"] = 127,
		["208"] = 83,
		["209"] = 74,
		["210"] = 74,
		["211"] = 74,
		["212"] = 74,
		["213"] = 74,
		["214"] = 74,
		["215"] = 74,
		["216"] = 74,
		["217"] = 74,
		["218"] = 83,
		["220"] = 83,
		["222"] = 161,
		["223"] = 170,
		["224"] = 161,
		["225"] = 170,
		["226"] = 171,
		["227"] = 172,
		["228"] = 173,
		["229"] = 174,
		["232"] = 171,
		["233"] = 178,
		["234"] = 179,
		["235"] = 180,
		["236"] = 181,
		["239"] = 178,
		["240"] = 185,
		["241"] = 186,
		["242"] = 185,
		["243"] = 170,
		["244"] = 161,
		["245"] = 161,
		["246"] = 161,
		["247"] = 161,
		["248"] = 161,
		["249"] = 161,
		["250"] = 161,
		["251"] = 161,
		["252"] = 161,
		["253"] = 170,
		["255"] = 170,
		["256"] = 194,
		["257"] = 195,
		["258"] = 194,
		["259"] = 195,
		["260"] = 196,
		["261"] = 197,
		["262"] = 196,
		["263"] = 195,
		["264"] = 194,
		["265"] = 195,
		["267"] = 195,
		["268"] = 201,
		["269"] = 209,
		["270"] = 201,
		["271"] = 209,
		["272"] = 211,
		["273"] = 212,
		["274"] = 211,
		["275"] = 214,
		["276"] = 215,
		["277"] = 214,
		["278"] = 219,
		["279"] = 220,
		["280"] = 221,
		["281"] = 221,
		["282"] = 220,
		["283"] = 219,
		["284"] = 224,
		["285"] = 225,
		["286"] = 226,
		["287"] = 226,
		["288"] = 226,
		["289"] = 226,
		["290"] = 226,
		["291"] = 227,
		["292"] = 227,
		["293"] = 227,
		["294"] = 227,
		["295"] = 227,
		["296"] = 227,
		["297"] = 227,
		["298"] = 227,
		["299"] = 227,
		["300"] = 228,
		["301"] = 229,
		["302"] = 224,
		["303"] = 209,
		["304"] = 201,
		["305"] = 201,
		["306"] = 201,
		["307"] = 201,
		["308"] = 201,
		["309"] = 201,
		["310"] = 201,
		["311"] = 201,
		["312"] = 209,
		["314"] = 209,
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
g.riki_talent = c()
local q = g.riki_talent
q.name = "riki_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_riki_talent"
end
q = e({ j(nil) }, q)
g.riki_talent = q
g.modifier_riki_talent = c()
local r = g.modifier_riki_talent
r.name = "modifier_riki_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	if IsServer() then
		self.ult_ability = self:GetParent():FindAbilityByName("riki_ult")
	end
end
function r.prototype.OnEvasion(self, s)
	if self:GetParent():PassivesDisabled() then
		return
	end
	if IsValid(self.ult_ability) then
		self.ult_ability:TriggerTricks(self.duration)
	end
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
g.modifier_riki_talent = r
g.riki_ult = c()
local t = g.riki_ult
t.name = "riki_ult"
d(t, o)
function t.prototype.OnSpellStart(self)
	local u = self:GetSpecialValueFor("duration")
	self:TriggerTricks(u)
end
function t.prototype.TriggerTricks(self, u)
	local v = self:GetCaster()
	local w = v:GetEnemy()
	if not IsInjurable(w, v) then
		return
	end
	local x = self:GetSpecialValueFor("interval") - self:GetTalentValue("riki_talent_11", "interval_reduce")
	local y = math.floor(u / x)
	local z = self:GetTalentValue("riki_talent_8", "debuff_reduce")
	if z > 0 then
		ReduceDebuff(v, 0, z)
	end
	w:AddNewModifier(v, self, "modifier_riki_ult_buff", { count = y })
end
t = e({ p(nil) }, t)
g.riki_ult = t
g.modifier_riki_ult_buff = c()
local A = g.modifier_riki_ult_buff
A.name = "modifier_riki_ult_buff"
d(A, l)
function A.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("riki_talent_7", "bonus_damage")
	self.talent_9_evasion_factor = self:GetAbilityTalentValue("riki_talent_9", "evasion_factor")
	self.injury_bonus = self:GetAbilitySpecialValueFor("injury_bonus")
		+ self:GetAbilityTalentValue("riki_talent_10", "count")
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("riki_talent_11", "interval_reduce")
	self.talent_12_value = self:GetAbilityTalentValue("riki_talent_12", "value")
	self.talent_12_duration = self:GetAbilityTalentValue("riki_talent_12", "duration")
end
function A.prototype.OnCreated(self, s)
	local B = self:GetParent()
	if IsServer() then
		self.counter = s and s.count or 1
		self:StartIntervalThink(self.interval)
		B:EmitSound("Hero_Riki.TricksOfTheTrade")
		local C = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_riki/cutom_riki_tricks.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(C, 0, B:GetAbsOrigin())
		ParticleManager:SetParticleControl(C, 1, Vector(400, 400, 400))
		ParticleManager:SetParticleControl(C, 2, Vector(400, 0, 0))
		self:AddParticle(C, false, false, -1, false, false)
	end
end
function A.prototype.OnIntervalThink(self)
	if IsServer() then
		self:Tricks()
		self.counter = self.counter - 1
		if self.counter <= 0 then
			self:Destroy()
		end
	end
end
function A.prototype.Tricks(self)
	local D = self:GetCaster()
	local B = self:GetParent()
	if not IsInjurable(D, B) then
		return
	end
	local E = B:GetAbsOrigin()
	EmitSoundOnLocationWithCaster(E, "Hero_Riki.TricksOfTheTrade.Cast", D)
	local F = self.damage
	if self.talent_9_evasion_factor > 0 then
		F = F + GetEvasion(D) * self.talent_9_evasion_factor
	end
	local G =
		ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_backstab.vpcf", PATTACH_CUSTOMORIGIN, D)
	ParticleManager:SetParticleControlEnt(G, 0, B, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
	ParticleManager:ReleaseParticleIndex(G)
	local H = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_riki/riki_tricks_backstab_ring.vpcf",
		PATTACH_CUSTOMORIGIN,
		D
	)
	ParticleManager:SetParticleControl(H, 0, E)
	ParticleManager:SetParticleControl(H, 1, Vector(400, 400, 400))
	ParticleManager:ReleaseParticleIndex(H)
	local I = self:GetAbility()
	D:DealDamage(B, I, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	AddInjury(D, B, self.injury_bonus, "riki_ult", "Ability")
	if self.talent_12_value > 0 then
		B:AddNewModifier(
			D,
			I,
			"modifier_riki_talent_12_buff",
			{ duration = self.talent_12_duration, count = math.floor(self.injury_bonus * self.talent_12_value * 0.01) }
		)
	end
end
A = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	A
)
g.modifier_riki_ult_buff = A
g.modifier_riki_talent_12_buff = c()
local J = g.modifier_riki_talent_12_buff
J.name = "modifier_riki_talent_12_buff"
d(J, l)
function J.prototype.OnCreated(self, s)
	if IsServer() then
		if s and s.count then
			self:IncrementStackCount(s and s.count)
		end
	end
end
function J.prototype.OnRefresh(self, s)
	if IsServer() then
		if s and s.count then
			self:IncrementStackCount(s and s.count)
		end
	end
end
function J.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT] = self:GetStackCount() }
end
J = e(
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
				IsIndependent = true,
			}
		),
	},
	J
)
g.modifier_riki_talent_12_buff = J
g.riki_shard = c()
local K = g.riki_shard
K.name = "riki_shard"
d(K, i)
function K.prototype.GetIntrinsicModifierName(self)
	return "modifier_riki_shard"
end
K = e({ j(nil) }, K)
g.riki_shard = K
g.modifier_riki_shard = c()
local L = g.modifier_riki_shard
L.name = "modifier_riki_shard"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function L.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS] = self.damage }
end
function L.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function L.prototype.OnCustomAttackLanded(self, M)
	local N = M.target
	local G = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_riki/riki_backstab.vpcf",
		PATTACH_CUSTOMORIGIN,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(G, 0, N, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, true)
	ParticleManager:ReleaseParticleIndex(G)
	N:EmitSound("Hero_Riki.Backstab")
end
L = e(
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
	L
)
g.modifier_riki_shard = L
return g