--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["137"] = 128,
		["138"] = 130,
		["139"] = 132,
		["140"] = 128,
		["141"] = 134,
		["142"] = 135,
		["143"] = 136,
		["145"] = 134,
		["146"] = 139,
		["147"] = 140,
		["148"] = 141,
		["150"] = 139,
		["151"] = 144,
		["152"] = 145,
		["153"] = 144,
		["154"] = 150,
		["155"] = 151,
		["156"] = 150,
		["157"] = 153,
		["158"] = 154,
		["159"] = 153,
		["160"] = 125,
		["161"] = 115,
		["162"] = 115,
		["163"] = 115,
		["164"] = 115,
		["165"] = 115,
		["166"] = 115,
		["167"] = 115,
		["168"] = 115,
		["169"] = 115,
		["170"] = 115,
		["171"] = 125,
		["173"] = 125,
		["174"] = 157,
		["175"] = 166,
		["176"] = 157,
		["177"] = 166,
		["178"] = 168,
		["179"] = 169,
		["180"] = 168,
		["181"] = 171,
		["182"] = 172,
		["183"] = 171,
		["184"] = 174,
		["185"] = 175,
		["186"] = 176,
		["188"] = 174,
		["189"] = 179,
		["190"] = 180,
		["191"] = 181,
		["193"] = 179,
		["194"] = 184,
		["195"] = 185,
		["196"] = 184,
		["197"] = 189,
		["198"] = 190,
		["199"] = 189,
		["200"] = 166,
		["201"] = 157,
		["202"] = 157,
		["203"] = 157,
		["204"] = 157,
		["205"] = 157,
		["206"] = 157,
		["207"] = 157,
		["208"] = 157,
		["209"] = 157,
		["210"] = 166,
		["212"] = 166,
		["214"] = 196,
		["215"] = 197,
		["216"] = 196,
		["217"] = 197,
		["218"] = 198,
		["219"] = 199,
		["220"] = 200,
		["221"] = 201,
		["224"] = 204,
		["225"] = 205,
		["226"] = 206,
		["227"] = 207,
		["228"] = 208,
		["229"] = 209,
		["232"] = 212,
		["233"] = 214,
		["234"] = 214,
		["235"] = 214,
		["236"] = 214,
		["237"] = 214,
		["238"] = 214,
		["239"] = 214,
		["240"] = 214,
		["241"] = 214,
		["242"] = 223,
		["243"] = 224,
		["244"] = 225,
		["245"] = 226,
		["246"] = 227,
		["247"] = 228,
		["248"] = 229,
		["249"] = 230,
		["250"] = 230,
		["251"] = 230,
		["252"] = 230,
		["253"] = 230,
		["254"] = 230,
		["255"] = 230,
		["256"] = 230,
		["257"] = 230,
		["258"] = 231,
		["259"] = 231,
		["260"] = 231,
		["261"] = 231,
		["262"] = 231,
		["263"] = 231,
		["264"] = 232,
		["265"] = 233,
		["266"] = 233,
		["267"] = 233,
		["268"] = 233,
		["269"] = 233,
		["270"] = 234,
		["271"] = 234,
		["272"] = 234,
		["273"] = 234,
		["274"] = 234,
		["275"] = 234,
		["276"] = 234,
		["277"] = 234,
		["278"] = 234,
		["279"] = 235,
		["280"] = 235,
		["281"] = 235,
		["282"] = 235,
		["283"] = 235,
		["284"] = 235,
		["285"] = 237,
		["286"] = 238,
		["287"] = 239,
		["289"] = 241,
		["290"] = 243,
		["291"] = 244,
		["292"] = 245,
		["294"] = 247,
		["295"] = 248,
		["296"] = 249,
		["297"] = 250,
		["298"] = 250,
		["299"] = 250,
		["300"] = 250,
		["301"] = 250,
		["302"] = 251,
		["303"] = 251,
		["304"] = 251,
		["305"] = 251,
		["306"] = 251,
		["307"] = 252,
		["308"] = 253,
		["310"] = 255,
		["311"] = 256,
		["313"] = 258,
		["314"] = 259,
		["315"] = 198,
		["316"] = 261,
		["317"] = 262,
		["318"] = 261,
		["319"] = 197,
		["320"] = 196,
		["321"] = 197,
		["323"] = 197,
		["324"] = 265,
		["325"] = 273,
		["326"] = 265,
		["327"] = 273,
		["328"] = 279,
		["329"] = 280,
		["330"] = 282,
		["331"] = 284,
		["332"] = 279,
		["333"] = 286,
		["334"] = 287,
		["335"] = 288,
		["337"] = 286,
		["338"] = 291,
		["339"] = 292,
		["340"] = 292,
		["341"] = 292,
		["342"] = 292,
		["343"] = 291,
		["344"] = 297,
		["345"] = 298,
		["346"] = 297,
		["347"] = 300,
		["348"] = 301,
		["349"] = 302,
		["351"] = 300,
		["352"] = 305,
		["353"] = 306,
		["354"] = 305,
		["355"] = 310,
		["356"] = 311,
		["357"] = 312,
		["359"] = 310,
		["360"] = 315,
		["361"] = 316,
		["362"] = 315,
		["363"] = 318,
		["364"] = 319,
		["365"] = 320,
		["366"] = 321,
		["368"] = 318,
		["369"] = 273,
		["370"] = 265,
		["371"] = 265,
		["372"] = 265,
		["373"] = 265,
		["374"] = 265,
		["375"] = 265,
		["376"] = 265,
		["377"] = 265,
		["378"] = 273,
		["380"] = 273,
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
	self.tl3_crit = self:GetAbilityTalentValue("chaos_knight_talent_3", "crit")
	self.tl7_attackspeed = self:GetAbilityTalentValue("chaos_knight_talent_7", "attackspeed")
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
	}
end
function A.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.tl7_attackspeed
end
function A.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	return self.tl3_crit
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