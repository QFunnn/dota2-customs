--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/mirana"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 3,
		["16"] = 3,
		["17"] = 3,
		["19"] = 8,
		["20"] = 9,
		["21"] = 8,
		["22"] = 9,
		["23"] = 10,
		["24"] = 11,
		["25"] = 10,
		["26"] = 9,
		["27"] = 8,
		["28"] = 9,
		["30"] = 9,
		["31"] = 15,
		["32"] = 23,
		["33"] = 15,
		["34"] = 23,
		["35"] = 36,
		["36"] = 37,
		["37"] = 38,
		["38"] = 40,
		["39"] = 41,
		["40"] = 42,
		["41"] = 44,
		["42"] = 45,
		["43"] = 46,
		["44"] = 47,
		["45"] = 36,
		["46"] = 49,
		["47"] = 50,
		["48"] = 51,
		["49"] = 52,
		["50"] = 53,
		["51"] = 54,
		["52"] = 55,
		["55"] = 49,
		["56"] = 59,
		["57"] = 60,
		["58"] = 60,
		["59"] = 60,
		["60"] = 63,
		["61"] = 63,
		["62"] = 63,
		["63"] = 60,
		["64"] = 64,
		["65"] = 64,
		["66"] = 64,
		["67"] = 60,
		["68"] = 65,
		["69"] = 65,
		["70"] = 65,
		["71"] = 60,
		["72"] = 60,
		["73"] = 60,
		["74"] = 59,
		["75"] = 69,
		["76"] = 70,
		["77"] = 69,
		["78"] = 72,
		["79"] = 73,
		["80"] = 74,
		["81"] = 72,
		["82"] = 76,
		["83"] = 77,
		["84"] = 76,
		["85"] = 79,
		["86"] = 80,
		["87"] = 81,
		["88"] = 82,
		["89"] = 83,
		["90"] = 83,
		["91"] = 83,
		["92"] = 83,
		["93"] = 83,
		["94"] = 83,
		["96"] = 79,
		["97"] = 86,
		["98"] = 87,
		["99"] = 88,
		["101"] = 86,
		["102"] = 91,
		["103"] = 92,
		["104"] = 93,
		["105"] = 94,
		["106"] = 95,
		["107"] = 96,
		["108"] = 96,
		["109"] = 96,
		["110"] = 96,
		["111"] = 97,
		["112"] = 98,
		["114"] = 96,
		["115"] = 96,
		["118"] = 91,
		["119"] = 104,
		["120"] = 105,
		["121"] = 106,
		["122"] = 107,
		["123"] = 108,
		["124"] = 109,
		["125"] = 110,
		["127"] = 112,
		["128"] = 113,
		["129"] = 114,
		["132"] = 115,
		["133"] = 116,
		["134"] = 116,
		["135"] = 116,
		["136"] = 116,
		["137"] = 117,
		["138"] = 116,
		["139"] = 116,
		["141"] = 104,
		["142"] = 121,
		["143"] = 121,
		["144"] = 121,
		["146"] = 122,
		["147"] = 123,
		["148"] = 124,
		["149"] = 125,
		["150"] = 126,
		["151"] = 127,
		["152"] = 127,
		["153"] = 127,
		["154"] = 127,
		["155"] = 127,
		["156"] = 128,
		["157"] = 129,
		["158"] = 129,
		["159"] = 129,
		["160"] = 129,
		["161"] = 129,
		["162"] = 129,
		["164"] = 121,
		["165"] = 132,
		["166"] = 133,
		["167"] = 132,
		["168"] = 139,
		["169"] = 140,
		["170"] = 139,
		["171"] = 142,
		["172"] = 143,
		["173"] = 142,
		["174"] = 145,
		["175"] = 146,
		["176"] = 147,
		["178"] = 145,
		["179"] = 23,
		["180"] = 15,
		["181"] = 15,
		["182"] = 15,
		["183"] = 15,
		["184"] = 15,
		["185"] = 15,
		["186"] = 15,
		["187"] = 15,
		["188"] = 23,
		["190"] = 23,
		["192"] = 155,
		["193"] = 156,
		["194"] = 155,
		["195"] = 156,
		["196"] = 157,
		["197"] = 158,
		["198"] = 159,
		["199"] = 160,
		["200"] = 161,
		["201"] = 162,
		["202"] = 163,
		["203"] = 165,
		["204"] = 166,
		["205"] = 167,
		["206"] = 168,
		["207"] = 169,
		["208"] = 169,
		["209"] = 169,
		["210"] = 169,
		["211"] = 170,
		["212"] = 171,
		["214"] = 169,
		["215"] = 169,
		["218"] = 157,
		["219"] = 156,
		["220"] = 155,
		["221"] = 156,
		["223"] = 156,
		["224"] = 180,
		["225"] = 192,
		["226"] = 180,
		["227"] = 192,
		["229"] = 192,
		["230"] = 195,
		["231"] = 180,
		["232"] = 196,
		["233"] = 197,
		["234"] = 196,
		["235"] = 200,
		["236"] = 201,
		["237"] = 202,
		["238"] = 203,
		["239"] = 204,
		["241"] = 205,
		["242"] = 205,
		["243"] = 206,
		["244"] = 206,
		["245"] = 206,
		["246"] = 206,
		["247"] = 206,
		["248"] = 207,
		["249"] = 208,
		["250"] = 208,
		["251"] = 206,
		["252"] = 206,
		["253"] = 205,
		["257"] = 200,
		["258"] = 213,
		["259"] = 214,
		["260"] = 215,
		["261"] = 215,
		["262"] = 215,
		["263"] = 215,
		["264"] = 215,
		["265"] = 215,
		["266"] = 215,
		["268"] = 213,
		["269"] = 192,
		["270"] = 180,
		["271"] = 180,
		["272"] = 180,
		["273"] = 180,
		["274"] = 180,
		["275"] = 180,
		["276"] = 180,
		["277"] = 180,
		["278"] = 180,
		["279"] = 180,
		["280"] = 180,
		["281"] = 180,
		["282"] = 192,
		["284"] = 192,
		["285"] = 230,
		["286"] = 240,
		["287"] = 230,
		["288"] = 240,
		["289"] = 241,
		["290"] = 242,
		["291"] = 241,
		["292"] = 240,
		["293"] = 230,
		["294"] = 230,
		["295"] = 230,
		["296"] = 230,
		["297"] = 230,
		["298"] = 230,
		["299"] = 230,
		["300"] = 230,
		["301"] = 230,
		["302"] = 230,
		["303"] = 240,
		["305"] = 240,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
local o = require("abilities.ability_ai")
local p = o.BaseAbilityAI
local q = o.registerAbilityAI
h.mirana_talent = c()
local r = h.mirana_talent
r.name = "mirana_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_mirana_talent"
end
r = e({ k(nil) }, r)
h.mirana_talent = r
h.modifier_mirana_talent = c()
local s = h.modifier_mirana_talent
s.name = "modifier_mirana_talent"
d(s, m)
function s.prototype.GetAbilitySpecialValue(self)
	self.interval_reduce = self:GetAbilityTalentValue("mirana_talent_1", "interval_reduce")
	self.bonus_damage = self:GetAbilityTalentValue("mirana_talent_2", "bonus_damage")
	self.tl4_bonus_health = self:GetAbilityTalentValue("mirana_talent_4", "bonus_health")
	self.wisp_interval = self:GetAbilityTalentValue("mirana_talent_5", "wisp_interval")
	self:GetHeroLevel()
	self.s_chance = self:GetAbilityTalentValue("mirana_shard", "chance")
	self.s_count = self:GetAbilityTalentValue("mirana_shard", "count")
	self.s_damage_pct = self:GetAbilityTalentValue("mirana_shard", "damage_pct")
	self.s_wave = self:GetAbilityTalentValue("mirana_shard", "wave")
end
function s.prototype.GetHeroLevel(self)
	if IsServer() then
		self.heroLevel = 1
		local t = self:GetParent():GetPlayerOwnerID()
		local u = PlayerData:getplayerData(t)
		if u then
			self.heroLevel = u.heroLevel
		end
	end
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent() },
	}
end
function s.prototype.OnBattleStartBefore(self, v)
	self:GetHeroLevel()
end
function s.prototype.OnBattleStart(self, v)
	self.record = 0
	self:StartIntervalThink(0.1)
end
function s.prototype.OnBattleEnd(self, v)
	self:StartIntervalThink(-1)
end
function s.prototype.OnCustomAbilityFullyCast(self, w)
	if IsValid(self.firstWisp) and self:HasTalent("mirana_talent_6") then
		local x = self:GetParent():FindAbilityByName("mirana_ult")
		local y = x:GetSpecialValueFor("duration") + x:GetTalentValue("mirana_talent_3", "bonus_duration")
		self.firstWisp:AddNewModifier(self:GetParent(), x, "modifier_mirana_ult_mark", { duration = y })
	end
end
function s.prototype.OnWispSpawn(self, v)
	if self.firstWisp == nil and self:HasTalent("mirana_talent_6") then
		self.firstWisp = v.wisp
	end
end
function s.prototype.OnCustomTakeDamage(self, w)
	if w.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL and self.s_chance > 0 then
		if self:PRD(self.s_chance, "s_chance") then
			local z = GetWispCount(self:GetParent())
			local A = self.s_count + z * self.s_wave
			ForWithInterval(0.2, A, function()
				if IsValid(self) then
					self:StarGuardians(self.s_damage_pct)
				end
			end)
		end
	end
end
function s.prototype.OnIntervalThink(self)
	self.record = self.record + 0.1
	local B = self:GetParent()
	local C = self:GetAbilitySpecialValueFor("interval") - self.interval_reduce
	if B:HasModifier("modifier_mirana_ult") then
		local x = B:FindAbilityByName("mirana_ult")
		C = C - x:GetSpecialValueFor("interval")
	end
	if self.record >= C then
		self.record = self.record - C
		if self:GetCaster():PassivesDisabled() then
			return
		end
		local B = self:GetParent()
		ForWithInterval(0.1, GetWispCount(B) + 1, function()
			self:StarGuardians()
		end)
	end
end
function s.prototype.StarGuardians(self, D)
	if D == nil then
		D = 100
	end
	local B = self:GetParent()
	local E = B:GetEnemy()
	local F = self:GetAbilitySpecialValueFor("damage") + self.bonus_damage
	if IsInjurable(B, E) then
		local G = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_mirana/mirana_starfall_attack.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(G, 0, E:GetAbsOrigin())
		B:EmitSound("Ability.StarfallImpact")
		B:DealDamage(E, self:GetAbility(), F * D * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	end
end
function s.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_TOTAL_DAMAGE_REDUCE_CONSTANT,
	}
end
function s.prototype.EOM_GetModifierWispInterval(self)
	return self.wisp_interval
end
function s.prototype.EOM_GetModifierWispHealthBonus(self)
	return self.heroLevel * self.tl4_bonus_health
end
function s.prototype.EOM_GetModifierWispTotalDamageReduceConstant(self, v)
	if
		v.wisp
		and self.firstWisp
		and self.firstWisp == v.wisp
		and self:GetParent():HasModifier("modifier_mirana_ult")
	then
		return 99999999999
	end
end
s = e(
	{
		n(
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
	s
)
h.modifier_mirana_talent = s
h.mirana_ult = c()
local H = h.mirana_ult
H.name = "mirana_ult"
d(H, p)
function H.prototype.OnSpellStart(self)
	local I = self:GetCaster()
	local y = self:GetSpecialValueFor("duration") + self:GetTalentValue("mirana_talent_3", "bonus_duration")
	I:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	ParticleManager:CreateParticle(
		"particles/units/heroes/hero_mirana/mirana_moonlight_recipient.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		I
	)
	I:AddNewModifier(I, self, "modifier_mirana_ult", { duration = y })
	I:EmitSound("Ability.MoonlightShadow")
	local J = self:GetTalentValue("mirana_talent_7", "count")
	if J > 0 then
		local K = I:FindModifierByName("modifier_mirana_talent")
		if IsValid(K) then
			ForWithInterval(0.1, J, function()
				if IsValid(K) then
					K:StarGuardians()
				end
			end)
		end
	end
end
H = e({ q(nil) }, H)
h.mirana_ult = H
h.modifier_mirana_ult = c()
local L = h.modifier_mirana_ult
L.name = "modifier_mirana_ult"
d(L, m)
function L.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.wisps = {}
end
function L.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function L.prototype.OnCreated(self, v)
	if IsServer() then
		local B = self:GetParent()
		local x = self:GetAbility()
		local y = self:GetDuration()
		do
			local M = 0
			while M < self.count do
				SummonWisp(B, WISP_HEALTH_BASE, nil, function(N)
					N:AddNewModifier(B, x, "modifier_mirana_ult_mark", { duration = y })
					local O = self.wisps
					O[#O + 1] = N
				end)
				M = M + 1
			end
		end
	end
end
function L.prototype.OnDestroy(self)
	if IsServer() then
		f(self.wisps, function(P, Q)
			return KillWisp(self:GetParent(), Q)
		end)
	end
end
L = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_luna/luna_lunar_marked.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
				GetStatusEffectName = "particles/econ/items/mirana/mirana_2021_immortal/mirana_2021_immortal_status_effect.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	L
)
h.modifier_mirana_ult = L
h.modifier_mirana_ult_mark = c()
local R = h.modifier_mirana_ult_mark
R.name = "modifier_mirana_ult_mark"
d(R, m)
function R.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
R = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_luna/luna_lunar_marked.vpcf",
				GetEffectAttachType = PATTACH_OVERHEAD_FOLLOW,
			}
		),
	},
	R
)
h.modifier_mirana_ult_mark = R
return h