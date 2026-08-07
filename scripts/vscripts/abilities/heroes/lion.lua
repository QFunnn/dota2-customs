--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/lion"
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
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["34"] = 21,
		["35"] = 24,
		["36"] = 27,
		["37"] = 13,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 32,
		["42"] = 28,
		["43"] = 34,
		["44"] = 35,
		["45"] = 35,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 35,
		["50"] = 35,
		["51"] = 34,
		["52"] = 40,
		["53"] = 41,
		["54"] = 42,
		["55"] = 40,
		["56"] = 44,
		["57"] = 45,
		["58"] = 46,
		["59"] = 47,
		["60"] = 48,
		["61"] = 49,
		["64"] = 50,
		["67"] = 44,
		["68"] = 54,
		["69"] = 55,
		["70"] = 56,
		["71"] = 57,
		["74"] = 60,
		["75"] = 61,
		["76"] = 62,
		["77"] = 62,
		["78"] = 62,
		["79"] = 63,
		["80"] = 62,
		["81"] = 62,
		["83"] = 66,
		["84"] = 66,
		["85"] = 66,
		["86"] = 66,
		["87"] = 66,
		["88"] = 66,
		["89"] = 54,
		["90"] = 70,
		["91"] = 71,
		["92"] = 72,
		["94"] = 70,
		["95"] = 21,
		["96"] = 13,
		["97"] = 13,
		["98"] = 13,
		["99"] = 13,
		["100"] = 13,
		["101"] = 13,
		["102"] = 13,
		["103"] = 13,
		["104"] = 21,
		["106"] = 21,
		["107"] = 77,
		["108"] = 87,
		["109"] = 77,
		["110"] = 87,
		["111"] = 94,
		["112"] = 96,
		["113"] = 98,
		["114"] = 99,
		["115"] = 102,
		["116"] = 94,
		["117"] = 105,
		["118"] = 106,
		["119"] = 107,
		["120"] = 108,
		["121"] = 109,
		["122"] = 110,
		["123"] = 111,
		["125"] = 114,
		["126"] = 115,
		["127"] = 115,
		["128"] = 115,
		["129"] = 115,
		["130"] = 115,
		["131"] = 115,
		["132"] = 115,
		["133"] = 115,
		["134"] = 115,
		["135"] = 116,
		["136"] = 116,
		["137"] = 116,
		["138"] = 116,
		["139"] = 116,
		["140"] = 116,
		["141"] = 116,
		["142"] = 116,
		["143"] = 116,
		["144"] = 117,
		["145"] = 117,
		["146"] = 117,
		["147"] = 117,
		["148"] = 117,
		["149"] = 117,
		["150"] = 117,
		["151"] = 117,
		["153"] = 105,
		["154"] = 120,
		["155"] = 121,
		["156"] = 122,
		["157"] = 123,
		["158"] = 124,
		["159"] = 125,
		["161"] = 120,
		["162"] = 128,
		["163"] = 129,
		["164"] = 130,
		["166"] = 128,
		["167"] = 133,
		["168"] = 134,
		["169"] = 135,
		["170"] = 136,
		["171"] = 137,
		["174"] = 140,
		["175"] = 141,
		["176"] = 143,
		["177"] = 144,
		["178"] = 145,
		["179"] = 146,
		["180"] = 147,
		["181"] = 147,
		["182"] = 147,
		["183"] = 147,
		["184"] = 147,
		["185"] = 147,
		["186"] = 147,
		["187"] = 147,
		["188"] = 147,
		["190"] = 158,
		["191"] = 159,
		["192"] = 160,
		["195"] = 133,
		["196"] = 87,
		["197"] = 77,
		["198"] = 77,
		["199"] = 77,
		["200"] = 77,
		["201"] = 77,
		["202"] = 77,
		["203"] = 77,
		["204"] = 77,
		["205"] = 77,
		["206"] = 87,
		["208"] = 87,
		["209"] = 184,
		["210"] = 185,
		["211"] = 184,
		["212"] = 185,
		["213"] = 186,
		["214"] = 187,
		["215"] = 188,
		["216"] = 189,
		["219"] = 192,
		["220"] = 193,
		["221"] = 196,
		["222"] = 197,
		["223"] = 198,
		["224"] = 198,
		["225"] = 198,
		["226"] = 199,
		["227"] = 198,
		["228"] = 198,
		["229"] = 186,
		["230"] = 202,
		["231"] = 203,
		["232"] = 204,
		["234"] = 206,
		["235"] = 207,
		["236"] = 208,
		["237"] = 209,
		["238"] = 210,
		["239"] = 211,
		["240"] = 212,
		["241"] = 213,
		["242"] = 214,
		["243"] = 214,
		["244"] = 214,
		["245"] = 214,
		["246"] = 214,
		["247"] = 214,
		["248"] = 214,
		["249"] = 214,
		["250"] = 214,
		["251"] = 215,
		["252"] = 215,
		["253"] = 215,
		["254"] = 215,
		["255"] = 215,
		["256"] = 215,
		["257"] = 215,
		["258"] = 215,
		["259"] = 215,
		["260"] = 216,
		["261"] = 216,
		["262"] = 216,
		["263"] = 216,
		["264"] = 216,
		["265"] = 216,
		["266"] = 216,
		["267"] = 216,
		["268"] = 216,
		["269"] = 217,
		["270"] = 218,
		["271"] = 219,
		["272"] = 223,
		["273"] = 224,
		["274"] = 225,
		["275"] = 225,
		["276"] = 225,
		["277"] = 225,
		["278"] = 225,
		["279"] = 225,
		["280"] = 225,
		["281"] = 225,
		["282"] = 225,
		["283"] = 235,
		["284"] = 236,
		["285"] = 236,
		["286"] = 236,
		["287"] = 236,
		["288"] = 236,
		["289"] = 236,
		["292"] = 202,
		["293"] = 240,
		["294"] = 241,
		["295"] = 240,
		["296"] = 185,
		["297"] = 184,
		["298"] = 185,
		["300"] = 185,
		["301"] = 245,
		["302"] = 253,
		["303"] = 245,
		["304"] = 253,
		["305"] = 259,
		["306"] = 261,
		["307"] = 263,
		["308"] = 264,
		["309"] = 266,
		["310"] = 268,
		["311"] = 259,
		["312"] = 270,
		["313"] = 271,
		["314"] = 270,
		["315"] = 273,
		["316"] = 274,
		["317"] = 275,
		["318"] = 276,
		["319"] = 276,
		["320"] = 276,
		["322"] = 276,
		["323"] = 277,
		["325"] = 273,
		["326"] = 280,
		["327"] = 281,
		["328"] = 280,
		["329"] = 286,
		["330"] = 287,
		["331"] = 288,
		["333"] = 286,
		["334"] = 291,
		["335"] = 292,
		["336"] = 291,
		["337"] = 294,
		["338"] = 295,
		["339"] = 295,
		["340"] = 297,
		["341"] = 297,
		["342"] = 297,
		["343"] = 295,
		["344"] = 298,
		["345"] = 298,
		["346"] = 298,
		["347"] = 295,
		["348"] = 295,
		["349"] = 294,
		["350"] = 301,
		["351"] = 302,
		["352"] = 303,
		["353"] = 303,
		["354"] = 303,
		["356"] = 303,
		["357"] = 304,
		["358"] = 305,
		["359"] = 306,
		["360"] = 307,
		["362"] = 301,
		["363"] = 310,
		["364"] = 311,
		["365"] = 312,
		["366"] = 313,
		["367"] = 314,
		["368"] = 315,
		["369"] = 316,
		["370"] = 317,
		["371"] = 317,
		["372"] = 317,
		["373"] = 317,
		["374"] = 317,
		["377"] = 310,
		["378"] = 321,
		["379"] = 322,
		["380"] = 323,
		["381"] = 324,
		["382"] = 325,
		["385"] = 321,
		["386"] = 253,
		["387"] = 245,
		["388"] = 245,
		["389"] = 245,
		["390"] = 245,
		["391"] = 245,
		["392"] = 245,
		["393"] = 245,
		["394"] = 245,
		["395"] = 253,
		["397"] = 253,
		["398"] = 331,
		["399"] = 339,
		["400"] = 331,
		["401"] = 339,
		["402"] = 339,
		["403"] = 331,
		["404"] = 331,
		["405"] = 331,
		["406"] = 331,
		["407"] = 331,
		["408"] = 331,
		["409"] = 331,
		["410"] = 331,
		["411"] = 339,
		["413"] = 339,
		["414"] = 342,
		["415"] = 350,
		["416"] = 342,
		["417"] = 350,
		["418"] = 353,
		["419"] = 354,
		["420"] = 353,
		["421"] = 356,
		["422"] = 357,
		["423"] = 358,
		["424"] = 359,
		["426"] = 361,
		["429"] = 356,
		["430"] = 365,
		["431"] = 366,
		["432"] = 367,
		["435"] = 370,
		["436"] = 371,
		["437"] = 372,
		["438"] = 373,
		["439"] = 374,
		["440"] = 375,
		["441"] = 376,
		["442"] = 377,
		["443"] = 377,
		["444"] = 377,
		["445"] = 377,
		["446"] = 377,
		["451"] = 365,
		["452"] = 383,
		["453"] = 384,
		["454"] = 385,
		["455"] = 385,
		["456"] = 384,
		["457"] = 383,
		["458"] = 388,
		["459"] = 389,
		["460"] = 388,
		["461"] = 350,
		["462"] = 342,
		["463"] = 342,
		["464"] = 342,
		["465"] = 342,
		["466"] = 342,
		["467"] = 342,
		["468"] = 342,
		["469"] = 342,
		["470"] = 350,
		["472"] = 350,
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
g.lion_talent = c()
local q = g.lion_talent
q.name = "lion_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_lion_talent"
end
q = e({ j(nil) }, q)
g.lion_talent = q
g.modifier_lion_talent = c()
local r = g.modifier_lion_talent
r.name = "modifier_lion_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
	self.tick = 0.1
end
function r.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.tl6_chance = self:GetAbilityTalentValue("lion_talent_6", "chance")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStart(self, s)
	self.record = 0
	self:StartIntervalThink(self.tick)
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self.record = self.record + self.tick
		if self.record >= self.cooldown then
			self.record = 0
			if self:GetParent():PassivesDisabled() then
				return
			end
			self:ManaDrain()
		end
	end
end
function r.prototype.ManaDrain(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if not IsInjurable(t, u) then
		return
	end
	if not t:HasModifier("modifier_lion_ult_cast") then
		t:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 0, 0.1, 1.8)
		t:GameTimer(0.35, function()
			t:FadeGesture(ACT_DOTA_CAST_ABILITY_3)
		end)
	end
	u:AddNewModifier(t, self:GetAbility(), "modifier_lion_talent_target", { duration = self.duration })
end
function r.prototype.OnCustomTakeDamage(self, v)
	if
		self.tl6_chance > 0
		and v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS
		and self:PRD(self.tl6_chance, "tl6_chance")
	then
		self:ManaDrain()
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
g.modifier_lion_talent = r
g.modifier_lion_talent_target = c()
local w = g.modifier_lion_talent_target
w.name = "modifier_lion_talent_target"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.buff_damage = self:GetAbilitySpecialValueFor("buff_damage")
		+ self:GetAbilityTalentValue("lion_talent_7", "damage_factor")
	self.mana_steal = self:GetAbilitySpecialValueFor("mana_steal")
		+ self:GetAbilityTalentValue("lion_talent_2", "bonus_value")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.tl4_chaos_count = self:GetAbilityTalentValue("lion_talent_4", "chaos_count")
end
function w.prototype.OnCreated(self, s)
	if IsServer() then
		local t = self:GetParent()
		local x = self:GetCaster()
		t:EmitSound("Hero_Lion.ManaDrain")
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
	else
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lion/lion_spell_mana_drain.vpcf",
			PATTACH_CUSTOMORIGIN,
			self.caster
		)
		ParticleManager:SetParticleControlEnt(
			y,
			0,
			self.parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self.parent:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			y,
			1,
			self.caster,
			PATTACH_POINT_FOLLOW,
			"attach_mouth",
			self.caster:GetAbsOrigin(),
			true
		)
		self:AddParticle(y, false, false, -1, false, false)
	end
end
function w.prototype.OnRefresh(self, s)
	if IsServer() then
		local t = self:GetParent()
		t:StopSound("Hero_Lion.ManaDrain")
		t:EmitSound("Hero_Lion.ManaDrain")
		self:IncrementStackCount()
	end
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Lion.ManaDrain")
	end
end
function w.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local x = self:GetCaster()
	if not IsInjurable(t, x) then
		self:Destroy()
		return
	end
	local z = self:GetStackCount()
	local A = self.mana_steal * z
	Restore(x, A)
	local B = x:GetModifierStackCount("modifier_lion_ult", x)
	if B > 0 then
		local C = self.buff_damage * B * z
		DamageSystem:dealDamage({
			attacker = x,
			target = t,
			ability = self:GetAbility(),
			damage = C,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
	end
	if self.tl4_chaos_count > 0 then
		if B > 0 then
			AddChaos(x, self.tl4_chaos_count * B * z, "lion_talent", "Ability")
		end
	end
end
w = e(
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
	w
)
g.modifier_lion_talent_target = w
g.lion_ult = c()
local D = g.lion_ult
D.name = "lion_ult"
d(D, o)
function D.prototype.OnSpellStart(self)
	local x = self:GetCaster()
	local E = x:GetEnemy()
	if not IsInjurable(x, E) then
		return
	end
	local F = 0.3
	x:AddNewModifier(x, self, "modifier_lion_ult_cast", { duration = F })
	x:RemoveGesture(ACT_DOTA_CAST_ABILITY_3)
	x:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.4)
	self:GameTimer(F, function()
		self:FingerOfDeath()
	end)
end
function D.prototype.FingerOfDeath(self, G)
	if G == nil then
		G = 100
	end
	local x = self:GetCaster()
	local E = x:GetEnemy()
	if IsInjurable(x, E) then
		local H = self:GetSpecialValueFor("duration")
		local C = self:GetSpecialValueFor("damage")
		local I = self:GetSpecialValueFor("stack_damage") + self:GetTalentValue("lion_talent_8", "damage_bonus")
		local J = self:GetTalentValue("lion_talent_3", "chaos_count")
		local y = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf",
			PATTACH_CUSTOMORIGIN,
			x
		)
		ParticleManager:SetParticleControlEnt(y, 0, x, PATTACH_POINT_FOLLOW, "attach_attack2", x:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(y, 1, E, PATTACH_POINT_FOLLOW, "attach_hitloc", E:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(y, 2, E, PATTACH_POINT_FOLLOW, "attach_hitloc", E:GetAbsOrigin(), true)
		x:EmitSound("Hero_Lion.FingerOfDeath")
		E:EmitSound("Hero_Lion.FingerOfDeathImpact")
		E:AddNewModifier(x, self, "modifier_lion_ult_debuff", { duration = H })
		local z = x:GetModifierStackCount("modifier_lion_ult", x) or 0
		local K = (C + I * z) * G * 0.01
		DamageSystem:dealDamage({
			attacker = x,
			target = E,
			ability = self,
			damage = K,
			damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_CHAOS,
			damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		})
		if J > 0 then
			AddChaos(x, J, self:GetAbilityName(), "Ability")
		end
	end
end
function D.prototype.GetIntrinsicModifierName(self)
	return "modifier_lion_ult"
end
D = e({ p(nil) }, D)
g.lion_ult = D
g.modifier_lion_ult = c()
local L = g.modifier_lion_ult
L.name = "modifier_lion_ult"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.tl1_bonus_count = self:GetAbilityTalentValue("lion_talent_1", "bonus_count")
	self.tl5_chance = self:GetAbilityTalentValue("lion_talent_5", "chance")
	self.tl5_damage_pct = self:GetAbilityTalentValue("lion_talent_5", "damage_pct")
	self.tl9_health = self:GetAbilityTalentValue("lion_talent_9", "health")
	self.shard_attack_damage = self:GetAbilityTalentValue("lion_shard", "attack_damage")
end
function L.prototype.GetTexture(self)
	return "dead_heart"
end
function L.prototype.OnCreated(self, s)
	if IsServer() then
		local M = self:GetCaster():GetPlayerOwnerID()
		local N = PlayerData:loadData(M, "lion_ult")
		if N == nil then
			N = 0
		end
		local z = N
		self:SetStackCount(z)
	end
end
function L.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
	}
end
function L.prototype.EOM_GetModifierHealthBonus(self, s)
	if self.tl9_health > 0 then
		return self.tl9_health * self:GetStackCount()
	end
end
function L.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.shard_attack_damage * self:GetStackCount()
end
function L.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function L.prototype.OnBattleStartBefore(self, s)
	local M = self:GetCaster():GetPlayerOwnerID()
	local O = PlayerData:loadData(M, "lion_ult")
	if O == nil then
		O = 0
	end
	local z = O
	self:SetStackCount(z)
	if self.tl9_health > 0 then
		self:GetCaster():CalculateHealth()
		self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
	end
end
function L.prototype.OnBattleEnd(self, s)
	if self.tl1_bonus_count > 0 and not self:GetParent():IsCustomIllusion() then
		local P = self:GetParent():GetPlayerOwnerID()
		if P == s.winPlayerID then
			local z = self:GetStackCount()
			local Q = z + self.tl1_bonus_count
			self:SetStackCount(Q)
			PlayerData:saveData(P, "lion_ult", self:GetStackCount())
		end
	end
end
function L.prototype.OnCustomTakeDamage(self, v)
	if
		self.tl5_chance > 0
		and v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
		and self:PRD(self.tl5_chance, "tl5_chance")
	then
		local R = self:GetAbility()
		if IsValid(R) then
			R:FingerOfDeath(self.tl5_damage_pct)
		end
	end
end
L = e(
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
	L
)
g.modifier_lion_ult = L
g.modifier_lion_ult_cast = c()
local S = g.modifier_lion_ult_cast
S.name = "modifier_lion_ult_cast"
d(S, l)
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
g.modifier_lion_ult_cast = S
g.modifier_lion_ult_debuff = c()
local T = g.modifier_lion_ult_debuff
T.name = "modifier_lion_ult_debuff"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.stack_add = self:GetAbilitySpecialValueFor("stack_add")
end
function T.prototype.OnCreated(self, s)
	if IsServer() then
		if self:GetCaster():IsCustomIllusion() then
			self.casterPlayerID = -1
		else
			self.casterPlayerID = self:GetCaster():GetPlayerOwnerID()
		end
	end
end
function T.prototype.OnDestroy(self)
	if IsServer() then
		if self.casterPlayerID == -1 then
			return
		end
		if not IsInjurable(self:GetParent()) then
			if IsValid(self:GetCaster()) then
				local U = self:GetCaster():FindModifierByName("modifier_lion_ult")
				if IsValid(U) then
					local z = U:GetStackCount()
					local Q = z + self.stack_add
					U:SetStackCount(Q)
					PlayerData:saveData(self.casterPlayerID, "lion_ult", U:GetStackCount())
				end
			end
		end
	end
end
function T.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function T.prototype.OnBattleEnd(self, s)
	self:Destroy()
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
g.modifier_lion_ult_debuff = T
return g