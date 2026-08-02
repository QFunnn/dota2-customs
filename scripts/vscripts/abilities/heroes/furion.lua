--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/furion"
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
		["35"] = 21,
		["36"] = 25,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["42"] = 13,
		["43"] = 33,
		["44"] = 34,
		["45"] = 35,
		["46"] = 33,
		["47"] = 37,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 41,
		["52"] = 41,
		["53"] = 41,
		["54"] = 38,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 38,
		["59"] = 38,
		["60"] = 37,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 49,
		["66"] = 50,
		["67"] = 51,
		["68"] = 52,
		["71"] = 45,
		["72"] = 56,
		["73"] = 57,
		["74"] = 58,
		["75"] = 59,
		["76"] = 60,
		["77"] = 61,
		["78"] = 62,
		["79"] = 63,
		["80"] = 64,
		["82"] = 56,
		["83"] = 67,
		["84"] = 68,
		["85"] = 67,
		["86"] = 70,
		["87"] = 71,
		["88"] = 72,
		["89"] = 73,
		["90"] = 74,
		["92"] = 70,
		["93"] = 77,
		["94"] = 78,
		["95"] = 77,
		["96"] = 80,
		["97"] = 81,
		["98"] = 82,
		["99"] = 83,
		["100"] = 84,
		["101"] = 85,
		["102"] = 86,
		["103"] = 87,
		["104"] = 88,
		["105"] = 89,
		["106"] = 89,
		["107"] = 89,
		["108"] = 89,
		["109"] = 89,
		["110"] = 89,
		["113"] = 80,
		["114"] = 95,
		["115"] = 96,
		["116"] = 97,
		["117"] = 98,
		["118"] = 99,
		["119"] = 100,
		["120"] = 101,
		["121"] = 102,
		["122"] = 103,
		["123"] = 103,
		["124"] = 103,
		["125"] = 103,
		["126"] = 104,
		["127"] = 105,
		["128"] = 106,
		["129"] = 106,
		["130"] = 106,
		["131"] = 106,
		["132"] = 106,
		["133"] = 107,
		["134"] = 108,
		["135"] = 108,
		["137"] = 111,
		["138"] = 112,
		["139"] = 113,
		["143"] = 95,
		["144"] = 21,
		["145"] = 13,
		["146"] = 13,
		["147"] = 13,
		["148"] = 13,
		["149"] = 13,
		["150"] = 13,
		["151"] = 13,
		["152"] = 13,
		["153"] = 21,
		["155"] = 21,
		["156"] = 120,
		["157"] = 128,
		["158"] = 120,
		["159"] = 128,
		["161"] = 128,
		["162"] = 138,
		["163"] = 139,
		["164"] = 120,
		["165"] = 142,
		["166"] = 143,
		["167"] = 144,
		["168"] = 145,
		["169"] = 146,
		["170"] = 147,
		["171"] = 149,
		["172"] = 151,
		["173"] = 153,
		["174"] = 142,
		["175"] = 156,
		["176"] = 157,
		["177"] = 158,
		["178"] = 159,
		["179"] = 161,
		["181"] = 156,
		["182"] = 164,
		["183"] = 165,
		["184"] = 170,
		["185"] = 171,
		["186"] = 172,
		["187"] = 173,
		["188"] = 174,
		["189"] = 175,
		["190"] = 176,
		["191"] = 177,
		["194"] = 180,
		["195"] = 181,
		["196"] = 182,
		["197"] = 183,
		["198"] = 183,
		["199"] = 183,
		["200"] = 183,
		["201"] = 183,
		["202"] = 183,
		["204"] = 185,
		["205"] = 186,
		["206"] = 186,
		["207"] = 186,
		["208"] = 186,
		["209"] = 186,
		["211"] = 189,
		["212"] = 190,
		["213"] = 191,
		["214"] = 192,
		["217"] = 195,
		["218"] = 196,
		["222"] = 164,
		["223"] = 201,
		["224"] = 202,
		["225"] = 201,
		["226"] = 207,
		["227"] = 208,
		["228"] = 209,
		["229"] = 210,
		["231"] = 207,
		["232"] = 213,
		["233"] = 214,
		["234"] = 213,
		["235"] = 128,
		["236"] = 120,
		["237"] = 120,
		["238"] = 120,
		["239"] = 120,
		["240"] = 120,
		["241"] = 120,
		["242"] = 120,
		["243"] = 120,
		["244"] = 128,
		["246"] = 128,
		["248"] = 219,
		["249"] = 220,
		["250"] = 219,
		["251"] = 220,
		["252"] = 221,
		["253"] = 222,
		["254"] = 223,
		["255"] = 224,
		["256"] = 225,
		["257"] = 226,
		["258"] = 221,
		["259"] = 228,
		["260"] = 229,
		["261"] = 230,
		["262"] = 231,
		["263"] = 232,
		["264"] = 233,
		["265"] = 234,
		["266"] = 235,
		["267"] = 236,
		["268"] = 237,
		["269"] = 238,
		["270"] = 239,
		["273"] = 242,
		["274"] = 243,
		["276"] = 228,
		["277"] = 220,
		["278"] = 219,
		["279"] = 220,
		["281"] = 220,
		["282"] = 250,
		["283"] = 261,
		["284"] = 250,
		["285"] = 261,
		["286"] = 261,
		["287"] = 250,
		["288"] = 250,
		["289"] = 250,
		["290"] = 250,
		["291"] = 250,
		["292"] = 250,
		["293"] = 250,
		["294"] = 250,
		["295"] = 250,
		["296"] = 250,
		["297"] = 250,
		["298"] = 261,
		["300"] = 261,
		["301"] = 264,
		["302"] = 275,
		["303"] = 264,
		["304"] = 275,
		["305"] = 282,
		["306"] = 283,
		["307"] = 284,
		["308"] = 285,
		["309"] = 288,
		["310"] = 282,
		["311"] = 290,
		["312"] = 291,
		["313"] = 292,
		["314"] = 293,
		["316"] = 290,
		["317"] = 296,
		["318"] = 297,
		["319"] = 298,
		["320"] = 299,
		["321"] = 300,
		["322"] = 301,
		["323"] = 302,
		["326"] = 306,
		["327"] = 307,
		["328"] = 308,
		["329"] = 309,
		["330"] = 310,
		["331"] = 311,
		["334"] = 315,
		["336"] = 317,
		["338"] = 296,
		["339"] = 275,
		["340"] = 264,
		["341"] = 264,
		["342"] = 264,
		["343"] = 264,
		["344"] = 264,
		["345"] = 264,
		["346"] = 264,
		["347"] = 264,
		["348"] = 264,
		["349"] = 264,
		["350"] = 264,
		["351"] = 275,
		["353"] = 275,
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
g.furion_talent = c()
local q = g.furion_talent
q.name = "furion_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_furion_talent"
end
q = e({ j(nil) }, q)
g.furion_talent = q
g.modifier_furion_talent = c()
local r = g.modifier_furion_talent
r.name = "modifier_furion_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
	self.distance = 175
	self.show_count = 5
	self.root_counter = 0
	self.particle_list = {}
	self.battleEnd = false
end
function r.prototype.GetAbilitySpecialValue(self)
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.delay_reduce = self:GetAbilitySpecialValueFor("delay_reduce")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		local t = self:GetParent()
		local u = t:GetPlayerOwnerID()
		local v = PlayerData:getplayerData(u)
		self.heroLevel = 1
		if v then
			self.heroLevel = v.heroLevel
		end
	end
end
function r.prototype.OnBattleStartBefore(self, s)
	self.delay_now = self.delay
	self.battleEnd = false
	local t = self:GetParent()
	local u = t:GetPlayerOwnerID()
	local v = PlayerData:getplayerData(u)
	self.heroLevel = 1
	if v then
		self.heroLevel = v.heroLevel
	end
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(self.tick)
end
function r.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
	self.battleEnd = true
	for w, x in ipairs(self.particle_list) do
		ParticleManager:DestroyParticle(x, false)
	end
end
function r.prototype.OnWispSpawn(self, s)
	self.delay_now = self.delay_now - self.delay_reduce
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self.delay_now = self.delay_now - self.tick
		if self.delay_now <= 0 then
			self.root_counter = 0
			local t = self:GetParent()
			t:EmitSound("Hero_Treant.NaturesGrasp.Cast")
			self:StartThink(0.1, "particle")
			self:StartIntervalThink(-1)
			t:AddNewModifier(t, self:GetAbility(), "modifier_furion_talent_buff", { heroLevel = self.heroLevel })
		end
	end
end
function r.prototype.OnThink(self, y)
	if y == "particle" then
		local t = self:GetParent()
		local z = t:GetEnemy()
		if IsInjurable(t, z) and not self.battleEnd then
			local A = z:GetAbsOrigin() - t:GetAbsOrigin()
			A.z = 0
			A = A:Normalized()
			local B = GetGroundPosition(t:GetAbsOrigin() + A * (175 * self.root_counter + 125), nil)
			local x = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_treant/treant_bramble_root.vpcf",
				PATTACH_CUSTOMORIGIN,
				t
			)
			ParticleManager:SetParticleControl(x, 0, B)
			ParticleManager:SetParticleControl(x, 1, Vector(1, 1, 1))
			EmitSoundOnLocationWithCaster(B, "Hero_Treant.NaturesGrasp.Spawn", t)
			local C = self.particle_list
			C[#C + 1] = x
		end
		self.root_counter = self.root_counter + 1
		if self.root_counter >= self.show_count then
			self:StartThink(-1, y)
		end
		return
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
g.modifier_furion_talent = r
g.modifier_furion_talent_buff = c()
local D = g.modifier_furion_talent_buff
D.name = "modifier_furion_talent_buff"
d(D, l)
function D.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
	self.record = 0
end
function D.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.base_reduce = self:GetAbilitySpecialValueFor("base_reduce")
	self.bonus_reduce = self:GetAbilitySpecialValueFor("bonus_reduce")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.reduce_pct = self:GetAbilityTalentValue("furion_ult", "reduce_pct")
	self.tl1_heal_pct = self:GetAbilityTalentValue("furion_talent_1", "heal_pct")
	self.tl4_duration = self:GetAbilityTalentValue("furion_talent_4", "duration")
	self.s_level = self:GetAbilityTalentValue("furion_shard", "level")
end
function D.prototype.OnCreated(self, s)
	if IsServer() then
		self.record = 0
		self:SetStackCount(s.heroLevel)
		self:StartIntervalThink(self.tick)
	end
end
function D.prototype.OnIntervalThink(self)
	if IsServer() then
		local E = self:GetStackCount()
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.record = 0
			local t = self:GetParent()
			local z = t:GetEnemy()
			if not IsInjurable(t, z) then
				self:StartIntervalThink(-1)
				return
			end
			z:EmitSound("Hero_Treant.NaturesGrasp.Damage")
			local F = (self.base_reduce + E * self.bonus_reduce) * self.damage_pct * 0.01
			if F > 0 then
				t:DealDamage(z, self:GetAbility(), F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			end
			if self.tl1_heal_pct > 0 then
				HealWisp(t, self:GetAbility(), F * self.tl1_heal_pct * 0.01)
			end
			if self.tl4_duration > 0 then
				local G = t:FindAbilityByName("furion_ult")
				if IsValid(G) then
					G:Overgrowth(self.tl4_duration)
				end
			end
			if self:HasTalent("furion_talent_5") then
				TriggerAllWisp(t)
			end
		end
	end
end
function D.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_TOTAL_DAMAGE_REDUCE_CONSTANT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PARRY_DAMAGE,
	}
end
function D.prototype.EOM_GetModifierParryDamage(self)
	local z = self:GetParent():GetEnemy()
	if IsValid(z) and z:HasModifier("modifier_furion_ulti_debuff") then
		return self:EOM_GetModifierWispTotalDamageReduceConstant() * self.reduce_pct * 0.01
	end
end
function D.prototype.EOM_GetModifierWispTotalDamageReduceConstant(self)
	return self.base_reduce + self:GetStackCount() * (self.bonus_reduce + self.s_level)
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
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	D
)
g.modifier_furion_talent_buff = D
g.furion_ult = c()
local H = g.furion_ult
H.name = "furion_ult"
d(H, o)
function H.prototype.OnSpellStart(self)
	local I = self:GetCaster()
	I:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	ParticleManager:CreateParticle(
		"particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf",
		PATTACH_ABSORIGIN,
		I
	)
	I:EmitSound("Hero_Treant.Overgrowth.Cast")
	self:Overgrowth()
end
function H.prototype.Overgrowth(self, J)
	local I = self:GetCaster()
	local K = I:GetEnemy()
	local L = J
	local M = true
	if L == nil then
		M = false
		L = self:GetSpecialValueFor("duration")
		local N = self:GetSpecialValueFor("bonus_duration")
		local O = I:FindModifierByName("modifier_sect_wisp")
		if IsValid(O) then
			L = L + O:GetStackCount() * N
		end
	end
	if L > 0 and IsInjurable(K) then
		K:AddNewModifier(I, self, "modifier_furion_ulti_debuff", { duration = L, isTalent = M })
	end
end
H = e({ p(nil) }, H)
g.furion_ult = H
g.modifier_furion_ulti_wisp_buff = c()
local P = g.modifier_furion_ulti_wisp_buff
P.name = "modifier_furion_ulti_wisp_buff"
d(P, l)
P = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				IsIndependent = true,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
				GetEffectName = "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf",
			}
		),
	},
	P
)
g.modifier_furion_ulti_wisp_buff = P
g.modifier_furion_ulti_debuff = c()
local Q = g.modifier_furion_ulti_debuff
Q.name = "modifier_furion_ulti_debuff"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("furion_talent_2", "damage_bonus")
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("furion_talent_12", "interval_reduce")
	self.damage_bonus_pct = self:GetAbilityTalentValue("furion_talent_3", "damage_bonus_pct")
	self.tl1_heal_pct = self:GetAbilityTalentValue("furion_talent_1", "heal_pct")
end
function Q.prototype.OnCreated(self, s)
	if IsServer() then
		self.isTalent = (s and s.isTalent) == 1
		self:StartIntervalThink(self.interval)
	end
end
function Q.prototype.OnIntervalThink(self)
	if IsServer() then
		local R = self:GetCaster()
		local S = self:GetParent()
		local T = self:GetAbility()
		if not IsInjurable(R, S) then
			self:Destroy()
			return
		end
		local F = self.damage + self.damage * self:GetStackCount() * self.damage_bonus_pct * 0.01
		if self.isTalent then
			T = R:FindAbilityByName("furion_talent")
			R:DealDamage(S, T, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			if self.tl1_heal_pct > 0 then
				HealWisp(R, T, F * self.tl1_heal_pct * 0.01)
			end
		else
			R:DealDamage(S, T, F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		end
		self:IncrementStackCount()
	end
end
Q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
				GetEffectName = "particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	Q
)
g.modifier_furion_ulti_debuff = Q
return g