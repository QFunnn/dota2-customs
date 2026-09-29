--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/chaos_knight"
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
		["30"] = 13,
		["31"] = 21,
		["32"] = 13,
		["33"] = 21,
		["34"] = 34,
		["35"] = 35,
		["36"] = 36,
		["37"] = 37,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 42,
		["42"] = 44,
		["43"] = 46,
		["44"] = 47,
		["45"] = 34,
		["46"] = 50,
		["47"] = 51,
		["48"] = 50,
		["49"] = 53,
		["50"] = 54,
		["51"] = 55,
		["53"] = 53,
		["54"] = 58,
		["55"] = 59,
		["56"] = 58,
		["57"] = 61,
		["58"] = 62,
		["59"] = 63,
		["60"] = 63,
		["61"] = 63,
		["62"] = 63,
		["64"] = 61,
		["65"] = 66,
		["66"] = 67,
		["67"] = 67,
		["68"] = 67,
		["69"] = 70,
		["70"] = 70,
		["71"] = 70,
		["72"] = 67,
		["73"] = 71,
		["74"] = 71,
		["75"] = 71,
		["76"] = 67,
		["77"] = 67,
		["78"] = 67,
		["79"] = 66,
		["80"] = 75,
		["81"] = 76,
		["82"] = 77,
		["83"] = 78,
		["86"] = 81,
		["87"] = 82,
		["88"] = 83,
		["89"] = 83,
		["90"] = 83,
		["91"] = 83,
		["92"] = 83,
		["93"] = 83,
		["94"] = 83,
		["95"] = 84,
		["96"] = 85,
		["99"] = 88,
		["100"] = 92,
		["101"] = 75,
		["102"] = 94,
		["103"] = 95,
		["104"] = 96,
		["105"] = 97,
		["106"] = 98,
		["107"] = 99,
		["108"] = 100,
		["109"] = 102,
		["110"] = 105,
		["112"] = 106,
		["113"] = 106,
		["114"] = 107,
		["115"] = 106,
		["120"] = 94,
		["121"] = 21,
		["122"] = 13,
		["123"] = 13,
		["124"] = 13,
		["125"] = 13,
		["126"] = 13,
		["127"] = 13,
		["128"] = 13,
		["129"] = 13,
		["130"] = 21,
		["132"] = 21,
		["133"] = 115,
		["134"] = 125,
		["135"] = 115,
		["136"] = 125,
		["137"] = 130,
		["138"] = 131,
		["139"] = 133,
		["140"] = 135,
		["141"] = 136,
		["142"] = 130,
		["143"] = 138,
		["144"] = 139,
		["145"] = 140,
		["147"] = 138,
		["148"] = 143,
		["149"] = 144,
		["150"] = 145,
		["152"] = 143,
		["153"] = 148,
		["154"] = 149,
		["155"] = 148,
		["156"] = 156,
		["157"] = 157,
		["158"] = 156,
		["159"] = 159,
		["160"] = 160,
		["161"] = 159,
		["162"] = 162,
		["163"] = 163,
		["164"] = 162,
		["165"] = 165,
		["166"] = 166,
		["167"] = 165,
		["168"] = 125,
		["169"] = 115,
		["170"] = 115,
		["171"] = 115,
		["172"] = 115,
		["173"] = 115,
		["174"] = 115,
		["175"] = 115,
		["176"] = 115,
		["177"] = 115,
		["178"] = 115,
		["179"] = 125,
		["181"] = 125,
		["182"] = 169,
		["183"] = 178,
		["184"] = 169,
		["185"] = 178,
		["186"] = 180,
		["187"] = 181,
		["188"] = 180,
		["189"] = 183,
		["190"] = 184,
		["191"] = 183,
		["192"] = 186,
		["193"] = 187,
		["194"] = 188,
		["196"] = 186,
		["197"] = 191,
		["198"] = 192,
		["199"] = 193,
		["201"] = 191,
		["202"] = 196,
		["203"] = 197,
		["204"] = 196,
		["205"] = 201,
		["206"] = 202,
		["207"] = 201,
		["208"] = 178,
		["209"] = 169,
		["210"] = 169,
		["211"] = 169,
		["212"] = 169,
		["213"] = 169,
		["214"] = 169,
		["215"] = 169,
		["216"] = 169,
		["217"] = 169,
		["218"] = 178,
		["220"] = 178,
		["222"] = 208,
		["223"] = 209,
		["224"] = 208,
		["225"] = 209,
		["226"] = 210,
		["227"] = 211,
		["228"] = 212,
		["229"] = 213,
		["232"] = 216,
		["233"] = 217,
		["234"] = 218,
		["235"] = 219,
		["236"] = 220,
		["237"] = 221,
		["240"] = 224,
		["241"] = 226,
		["242"] = 226,
		["243"] = 226,
		["244"] = 226,
		["245"] = 226,
		["246"] = 226,
		["247"] = 226,
		["248"] = 226,
		["249"] = 226,
		["250"] = 235,
		["251"] = 236,
		["252"] = 237,
		["253"] = 238,
		["254"] = 239,
		["255"] = 240,
		["256"] = 241,
		["257"] = 242,
		["258"] = 242,
		["259"] = 242,
		["260"] = 242,
		["261"] = 242,
		["262"] = 242,
		["263"] = 242,
		["264"] = 242,
		["265"] = 242,
		["266"] = 243,
		["267"] = 243,
		["268"] = 243,
		["269"] = 243,
		["270"] = 243,
		["271"] = 243,
		["272"] = 244,
		["273"] = 245,
		["274"] = 245,
		["275"] = 245,
		["276"] = 245,
		["277"] = 245,
		["278"] = 246,
		["279"] = 246,
		["280"] = 246,
		["281"] = 246,
		["282"] = 246,
		["283"] = 246,
		["284"] = 246,
		["285"] = 246,
		["286"] = 246,
		["287"] = 247,
		["288"] = 247,
		["289"] = 247,
		["290"] = 247,
		["291"] = 247,
		["292"] = 247,
		["293"] = 249,
		["294"] = 250,
		["295"] = 251,
		["297"] = 253,
		["298"] = 255,
		["299"] = 256,
		["300"] = 257,
		["302"] = 259,
		["303"] = 260,
		["304"] = 261,
		["305"] = 262,
		["306"] = 262,
		["307"] = 262,
		["308"] = 262,
		["309"] = 262,
		["310"] = 263,
		["311"] = 263,
		["312"] = 263,
		["313"] = 263,
		["314"] = 263,
		["315"] = 264,
		["316"] = 265,
		["318"] = 267,
		["319"] = 268,
		["321"] = 270,
		["322"] = 271,
		["323"] = 273,
		["324"] = 274,
		["326"] = 210,
		["327"] = 277,
		["328"] = 278,
		["329"] = 277,
		["330"] = 209,
		["331"] = 208,
		["332"] = 209,
		["334"] = 209,
		["335"] = 281,
		["336"] = 289,
		["337"] = 281,
		["338"] = 289,
		["339"] = 295,
		["340"] = 296,
		["341"] = 298,
		["342"] = 300,
		["343"] = 295,
		["344"] = 302,
		["345"] = 303,
		["346"] = 304,
		["348"] = 302,
		["349"] = 307,
		["350"] = 308,
		["351"] = 308,
		["352"] = 308,
		["353"] = 308,
		["354"] = 307,
		["355"] = 313,
		["356"] = 314,
		["357"] = 313,
		["358"] = 316,
		["359"] = 318,
		["362"] = 321,
		["363"] = 322,
		["365"] = 316,
		["366"] = 325,
		["367"] = 326,
		["368"] = 325,
		["369"] = 330,
		["370"] = 331,
		["371"] = 332,
		["373"] = 330,
		["374"] = 335,
		["375"] = 336,
		["376"] = 335,
		["377"] = 338,
		["378"] = 339,
		["379"] = 340,
		["380"] = 341,
		["382"] = 338,
		["383"] = 289,
		["384"] = 281,
		["385"] = 281,
		["386"] = 281,
		["387"] = 281,
		["388"] = 281,
		["389"] = 281,
		["390"] = 281,
		["391"] = 281,
		["392"] = 289,
		["394"] = 289,
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
g.chaos_knight_talent = c()
local q = g.chaos_knight_talent
q.name = "chaos_knight_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_talent"
end
q = e({ j(nil) }, q)
g.chaos_knight_talent = q
g.modifier_chaos_knight_talent = c()
local r = g.modifier_chaos_knight_talent
r.name = "modifier_chaos_knight_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.custom_mana = self:GetAbilitySpecialValueFor("custom_mana")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("chaos_knight_talent_9", "bonus_chance")
	self.heal_pct = self:GetAbilitySpecialValueFor("heal_pct")
	self.tl1_mana = self:GetAbilityTalentValue("chaos_knight_talent_1", "mana")
	self.tl4_duration = self:GetAbilityTalentValue("chaos_knight_talent_4", "duration")
	self.tl6_chance = self:GetAbilityTalentValue("chaos_knight_talent_6", "chance")
	self.tl6_heal_pct = self:GetAbilityTalentValue("chaos_knight_talent_6", "heal_pct")
end
function r.prototype.Init(self)
	self.record = 0
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:Init()
	end
end
function r.prototype.OnBattleStartBefore(self, s)
	self:Init()
end
function r.prototype.OnBattleStart(self, s)
	if self.tl1_mana > 0 then
		RestoreCustomMana(self:GetParent(), self.tl1_mana)
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_RESTORE] = { self:GetParent() },
	}
end
function r.prototype.OnCritical(self, s)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if not IsInjurable(t, u) then
		return
	end
	if not t:PassivesDisabled() then
		local v = GetPhysicalCriticalChance(t) * self.damage
		t:DealDamage(
			u,
			self:GetAbility(),
			v,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			DamageFlags.DAMAGE_FLAG_HPLOSS + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
		)
		if t:HasModifier("modifier_chaos_knight_talent_buff") and self:PRD(self.chance, "chance") then
			Heal(t, v * self.heal_pct * 0.01, "chaos_knight_talent", "Ability")
		end
	end
	local w = self.custom_mana
	RestoreCustomMana(t, w)
end
function r.prototype.OnRestore(self, s)
	self.record = self.record + s.count
	if self.record >= self.threshold then
		local x = math.floor(self.record / self.threshold)
		self.record = self.record % self.threshold
		local t = self:GetParent()
		local y = self:GetAbility()
		t:AddNewModifier(t, y, "modifier_chaos_knight_talent_buff", { duration = self.duration })
		if self.tl4_duration > 0 then
			do
				local z = 0
				while z < x do
					t:AddNewModifier(t, y, "modifier_chaos_knight_talent_4", { duration = self.duration })
					z = z + 1
				end
			end
		end
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
g.modifier_chaos_knight_talent = r
g.modifier_chaos_knight_talent_buff = c()
local A = g.modifier_chaos_knight_talent_buff
A.name = "modifier_chaos_knight_talent_buff"
d(A, l)
function A.prototype.GetAbilitySpecialValue(self)
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.tl3_crit = self:GetAbilityTalentValue("chaos_knight_talent_3", "crit")
	self.tl11_hit_rate = self:GetAbilityTalentValue("chaos_knight_talent_11", "hit_rate")
	self.tl11_crit_damage = self:GetAbilityTalentValue("chaos_knight_talent_11", "crit_damage")
end
function A.prototype.OnCreated(self, s)
	if IsServer() then
		self:GetParent():EmitSound("DOTA_Item.Armlet.Activate")
	end
end
function A.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("DOTA_Item.Armlet.Activate")
	end
end
function A.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
	}
end
function A.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.attack_speed
end
function A.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	return self.tl3_crit
end
function A.prototype.EOM_GetModifierIgnoreEvasion(self)
	return self.tl11_hit_rate
end
function A.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	return self.tl11_crit_damage
end
A = e(
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
				GetEffectName = "particles/items_fx/armlet.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	A
)
g.modifier_chaos_knight_talent_buff = A
g.modifier_chaos_knight_talent_4 = c()
local B = g.modifier_chaos_knight_talent_4
B.name = "modifier_chaos_knight_talent_4"
d(B, l)
function B.prototype.IndependentMaxCount(self)
	return self:GetAbilityTalentValue("chaos_knight_talent_4", "max")
end
function B.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilityTalentValue("chaos_knight_talent_4", "health_bonus")
end
function B.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function B.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function B.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function B.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount() * self.health_bonus
end
B = e(
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
				IsIndependent = true,
			}
		),
	},
	B
)
g.modifier_chaos_knight_talent_4 = B
g.chaos_knight_ult = c()
local C = g.chaos_knight_ult
C.name = "chaos_knight_ult"
d(C, o)
function C.prototype.OnSpellStart(self, D)
	local E = self:GetCaster()
	local u = E:GetEnemy()
	if not IsInjurable(E, u) then
		return
	end
	local F = D
	if not F then
		local G = E:FindModifierByName("modifier_chaos_knight_ult")
		if IsValid(G) then
			F = G:isPlus()
			G:AddCount()
		end
	end
	local v = self:GetSpecialValueFor("damage") + self:GetTalentValue("chaos_knight_talent_2", "bonus_damage")
	local H = {
		attacker = E,
		target = u,
		ability = self,
		damage = v,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	}
	E:EmitSound("Hero_ChaosKnight.RealityRift.Cast")
	E:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_2, 1.5)
	local I = u:GetAbsOrigin() - E:GetAbsOrigin()
	I.z = 0
	I = I:Normalized()
	local J = E:GetAbsOrigin() + I * 300
	local K = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		E
	)
	ParticleManager:SetParticleControlEnt(K, 1, E, PATTACH_ABSORIGIN_FOLLOW, nil, E:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlTransform(K, 2, J, VectorAngles(I))
	local L = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf",
		PATTACH_CUSTOMORIGIN,
		E
	)
	ParticleManager:SetParticleControl(L, 0, E:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(L, 1, u, PATTACH_ABSORIGIN_FOLLOW, nil, u:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlTransform(L, 2, J, VectorAngles(I))
	local M = self:GetTalentValue("chaos_knight_talent_8", "attack_pct")
	if M > 0 then
		v = v + GetAttackDamage(E) * M * 0.01
	end
	local N = 0
	local O = self:GetTalentValue("chaos_knight_talent_10", "heal_pct")
	if O > 0 then
		N = N + v * O * 0.01
	end
	if F then
		H.is_crit = true
		local P = ParticleManager:CreateParticle(
			"particles/econ/items/chaos_knight/chaos_knight_ti9_weapon/chaos_knight_ti9_weapon_crit_tgt.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			u,
			E
		)
		ParticleManager:SetParticleControl(P, 1, u:GetAbsOrigin())
		ParticleManager:SetParticleControl(P, 2, E:GetAbsOrigin())
		local Q = self:GetSpecialValueFor("heal_pct")
		N = N + v * Q * 0.01
	end
	if N > 0 then
		Heal(E, N, "chaos_knight_ult", "Ability")
	end
	H.damage = v
	DamageSystem:dealDamage(H)
	if self:HasTalent("chaos_knight_talent_12") and IsInjurable(E, u) then
		DamageSystem:performAttack(E, u, { ability = self })
	end
end
function C.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_ult"
end
C = e({ p(nil) }, C)
g.chaos_knight_ult = C
g.modifier_chaos_knight_ult = c()
local R = g.modifier_chaos_knight_ult
R.name = "modifier_chaos_knight_ult"
d(R, l)
function R.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.tl5_chance = self:GetAbilityTalentValue("chaos_knight_talent_5", "chance")
	self.s_crit_bonus = self:GetAbilityTalentValue("chaos_knight_shard", "crit_bonus")
end
function R.prototype.OnCreated(self, s)
	if IsServer() then
		self.record = 0
	end
end
function R.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent() },
	}
end
function R.prototype.OnBattleStartBefore(self, s)
	self.record = 0
end
function R.prototype.OnCustomAttackLanded(self, S)
	if S.ability == self:GetAbility() then
		return
	end
	if self.tl5_chance > 0 and self:PRD(self.tl5_chance, "tl5_chance") then
		self:GetAbility():OnSpellStart()
	end
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS }
end
function R.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	if s and IsValid(s.ability) and s.ability == self:GetAbility() then
		return self.s_crit_bonus
	end
end
function R.prototype.isPlus(self)
	return self.record == self.count - 1
end
function R.prototype.AddCount(self)
	self.record = self.record + 1
	if self.record == self.count then
		self.record = 0
	end
end
R = e(
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
	R
)
g.modifier_chaos_knight_ult = R
return g