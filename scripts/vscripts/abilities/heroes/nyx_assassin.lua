--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/nyx_assassin"
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
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["34"] = 20,
		["35"] = 25,
		["36"] = 12,
		["37"] = 26,
		["38"] = 27,
		["39"] = 28,
		["40"] = 30,
		["41"] = 32,
		["42"] = 26,
		["43"] = 34,
		["44"] = 35,
		["45"] = 35,
		["46"] = 37,
		["47"] = 37,
		["48"] = 37,
		["49"] = 35,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 35,
		["54"] = 35,
		["55"] = 34,
		["56"] = 41,
		["57"] = 43,
		["58"] = 44,
		["59"] = 41,
		["60"] = 46,
		["61"] = 47,
		["62"] = 46,
		["63"] = 49,
		["64"] = 50,
		["65"] = 51,
		["66"] = 49,
		["67"] = 53,
		["68"] = 54,
		["69"] = 55,
		["70"] = 56,
		["73"] = 57,
		["74"] = 58,
		["75"] = 58,
		["76"] = 58,
		["77"] = 58,
		["78"] = 58,
		["79"] = 58,
		["80"] = 59,
		["82"] = 53,
		["83"] = 62,
		["84"] = 63,
		["85"] = 64,
		["87"] = 62,
		["88"] = 20,
		["89"] = 12,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 20,
		["99"] = 20,
		["100"] = 68,
		["101"] = 78,
		["102"] = 68,
		["103"] = 78,
		["105"] = 78,
		["106"] = 88,
		["107"] = 68,
		["108"] = 90,
		["109"] = 91,
		["110"] = 92,
		["111"] = 93,
		["112"] = 94,
		["113"] = 97,
		["114"] = 98,
		["115"] = 99,
		["116"] = 101,
		["117"] = 102,
		["118"] = 104,
		["119"] = 90,
		["120"] = 106,
		["121"] = 107,
		["122"] = 106,
		["123"] = 111,
		["124"] = 112,
		["125"] = 113,
		["126"] = 114,
		["127"] = 114,
		["128"] = 114,
		["129"] = 114,
		["130"] = 114,
		["131"] = 114,
		["132"] = 114,
		["133"] = 115,
		["134"] = 115,
		["135"] = 115,
		["136"] = 115,
		["137"] = 115,
		["138"] = 115,
		["139"] = 116,
		["140"] = 118,
		["141"] = 119,
		["142"] = 120,
		["143"] = 121,
		["144"] = 121,
		["145"] = 121,
		["146"] = 121,
		["147"] = 121,
		["148"] = 121,
		["151"] = 127,
		["152"] = 127,
		["153"] = 127,
		["154"] = 127,
		["155"] = 127,
		["156"] = 127,
		["157"] = 127,
		["158"] = 128,
		["159"] = 129,
		["161"] = 131,
		["163"] = 133,
		["164"] = 111,
		["165"] = 78,
		["166"] = 68,
		["167"] = 68,
		["168"] = 68,
		["169"] = 68,
		["170"] = 68,
		["171"] = 68,
		["172"] = 68,
		["173"] = 68,
		["174"] = 68,
		["175"] = 68,
		["176"] = 78,
		["178"] = 78,
		["179"] = 148,
		["180"] = 157,
		["181"] = 148,
		["182"] = 157,
		["183"] = 162,
		["184"] = 163,
		["185"] = 164,
		["186"] = 165,
		["187"] = 166,
		["188"] = 166,
		["189"] = 166,
		["190"] = 166,
		["191"] = 166,
		["192"] = 166,
		["194"] = 162,
		["195"] = 157,
		["196"] = 148,
		["197"] = 148,
		["198"] = 148,
		["199"] = 148,
		["200"] = 148,
		["201"] = 148,
		["202"] = 148,
		["203"] = 148,
		["204"] = 148,
		["205"] = 157,
		["207"] = 157,
		["208"] = 178,
		["209"] = 187,
		["210"] = 178,
		["211"] = 187,
		["212"] = 188,
		["213"] = 189,
		["214"] = 190,
		["215"] = 191,
		["217"] = 188,
		["218"] = 194,
		["219"] = 195,
		["220"] = 196,
		["221"] = 197,
		["223"] = 194,
		["224"] = 200,
		["225"] = 201,
		["226"] = 200,
		["227"] = 205,
		["228"] = 206,
		["229"] = 205,
		["230"] = 187,
		["231"] = 178,
		["232"] = 178,
		["233"] = 178,
		["234"] = 178,
		["235"] = 178,
		["236"] = 178,
		["237"] = 178,
		["238"] = 178,
		["239"] = 178,
		["240"] = 187,
		["242"] = 187,
		["243"] = 210,
		["244"] = 211,
		["245"] = 210,
		["246"] = 211,
		["247"] = 212,
		["248"] = 213,
		["249"] = 214,
		["250"] = 215,
		["251"] = 216,
		["252"] = 217,
		["253"] = 219,
		["254"] = 220,
		["255"] = 221,
		["257"] = 223,
		["258"] = 224,
		["259"] = 224,
		["260"] = 224,
		["261"] = 224,
		["262"] = 224,
		["263"] = 224,
		["264"] = 224,
		["265"] = 224,
		["266"] = 224,
		["267"] = 225,
		["268"] = 228,
		["269"] = 230,
		["270"] = 232,
		["271"] = 234,
		["272"] = 235,
		["273"] = 236,
		["274"] = 237,
		["275"] = 238,
		["276"] = 238,
		["277"] = 238,
		["278"] = 239,
		["281"] = 240,
		["282"] = 240,
		["283"] = 240,
		["284"] = 240,
		["285"] = 240,
		["286"] = 240,
		["287"] = 240,
		["288"] = 241,
		["289"] = 242,
		["290"] = 243,
		["291"] = 243,
		["292"] = 243,
		["293"] = 243,
		["294"] = 243,
		["295"] = 243,
		["296"] = 243,
		["297"] = 243,
		["298"] = 243,
		["299"] = 244,
		["300"] = 244,
		["301"] = 244,
		["302"] = 244,
		["303"] = 244,
		["304"] = 244,
		["305"] = 244,
		["306"] = 244,
		["307"] = 244,
		["308"] = 238,
		["309"] = 238,
		["311"] = 247,
		["312"] = 248,
		["313"] = 249,
		["314"] = 250,
		["317"] = 212,
		["318"] = 211,
		["319"] = 210,
		["320"] = 211,
		["322"] = 211,
		["323"] = 256,
		["324"] = 264,
		["325"] = 256,
		["326"] = 264,
		["327"] = 265,
		["328"] = 266,
		["329"] = 265,
		["330"] = 264,
		["331"] = 256,
		["332"] = 256,
		["333"] = 256,
		["334"] = 256,
		["335"] = 256,
		["336"] = 256,
		["337"] = 256,
		["338"] = 256,
		["339"] = 264,
		["341"] = 264,
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
g.nyx_assassin_talent = c()
local q = g.nyx_assassin_talent
q.name = "nyx_assassin_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_nyx_assassin_talent"
end
q = e({ j(nil) }, q)
g.nyx_assassin_talent = q
g.modifier_nyx_assassin_talent = c()
local r = g.modifier_nyx_assassin_talent
r.name = "modifier_nyx_assassin_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.interval_reduce = self:GetAbilityTalentValue("nyx_assassin_talent_1", "interval_reduce")
	self.interval_reduce_damage = self:GetAbilityTalentValue("nyx_assassin_talent_5", "interval_reduce_damage")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(0.1)
	self.record = 0
end
function r.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function r.prototype.OnIntervalThink(self)
	self.record = self.record + 0.1
	self:CheckCooldown()
end
function r.prototype.CheckCooldown(self)
	if self.record >= self.interval - self.interval_reduce then
		self.record = 0
		if self:GetCaster():PassivesDisabled() then
			return
		end
		local t = self:GetParent()
		t:AddNewModifier(t, self:GetAbility(), "modifier_nyx_assassin_talent_buff", { duration = 2 })
		t:EmitSound("Hero_NyxAssassin.SpikedCarapace")
	end
end
function r.prototype.OnCustomTakeDamage(self, u)
	if self.interval_reduce_damage > 0 then
		self.record = self.record + self.interval_reduce_damage
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
g.modifier_nyx_assassin_talent = r
g.modifier_nyx_assassin_talent_buff = c()
local v = g.modifier_nyx_assassin_talent_buff
v.name = "modifier_nyx_assassin_talent_buff"
d(v, l)
function v.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = true
end
function v.prototype.GetAbilitySpecialValue(self)
	self.injury_pct = self:GetAbilitySpecialValueFor("injury_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.max_injury = self:GetAbilitySpecialValueFor("max_injury")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.mana_regen = self:GetAbilityTalentValue("nyx_assassin_talent_2", "mana_regen")
	self.bonus_duration = self:GetAbilityTalentValue("nyx_assassin_talent_3", "bonus_duration")
	self.bonus_injury = self:GetAbilityTalentValue("nyx_assassin_talent_7", "bonus_injury")
	self.tl8_buff_pct = self:GetAbilityTalentValue("nyx_assassin_talent_8", "buff_pct")
	self.tl8_duration = self:GetAbilityTalentValue("nyx_assassin_talent_8", "duration")
	self.s_add_pct = self:GetAbilityTalentValue("nyx_assassin_shard", "add_pct")
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE }
end
function v.prototype.EOM_GetModifierAllBlockChance(self, s)
	if s and self.enable then
		self.enable = false
		s.target:DealDamage(
			s.attacker,
			self:GetAbility(),
			s.damage * (self.damage_pct + self.s_add_pct) * 0.01,
			s.damage_type,
			s.damage_flags
		)
		s.attacker:AddNewModifier(
			s.target,
			self:GetAbility(),
			"modifier_nyx_assassin_talent_debuff",
			{ duration = self.duration + self.bonus_duration }
		)
		local w = math.min((self.injury_pct + self.s_add_pct) * s.damage * 0.01, self.max_injury) + self.bonus_injury
		if self.tl8_buff_pct > 0 then
			local x = math.floor(w * self.tl8_buff_pct * 0.01)
			if x > 0 then
				s.attacker:AddNewModifier(
					s.target,
					self:GetAbility(),
					"modifier_nyx_assassin_talent_8_debuff",
					{ duration = self.tl8_duration, iStackCount = x }
				)
			end
		end
		AddInjury(s.target, s.attacker, w, "nyx_assassin_talent", "Ability")
		if self.mana_regen > 0 then
			Restore(s.target, self.mana_regen)
		end
		return 1
	end
	return 0
end
v = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
				GetEffectName = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace.vpcf",
			}
		),
	},
	v
)
g.modifier_nyx_assassin_talent_buff = v
g.modifier_nyx_assassin_talent_debuff = c()
local y = g.modifier_nyx_assassin_talent_debuff
y.name = "modifier_nyx_assassin_talent_debuff"
d(y, l)
function y.prototype.OnCreated(self, s)
	if IsServer() then
		local t = self:GetParent()
		local z = self:GetCaster()
		AddStun(z, t, self:GetAbility(), self:GetDuration())
	end
end
y = e(
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
				GetEffectName = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_spiked_carapace.vpcf",
			}
		),
	},
	y
)
g.modifier_nyx_assassin_talent_debuff = y
g.modifier_nyx_assassin_talent_8_debuff = c()
local A = g.modifier_nyx_assassin_talent_8_debuff
A.name = "modifier_nyx_assassin_talent_8_debuff"
d(A, l)
function A.prototype.OnCreated(self, s)
	if IsServer() then
		local B = s and s.iStackCount or 0
		self:IncrementStackCount(B)
	end
end
function A.prototype.OnRefresh(self, s)
	if IsServer() then
		local B = s and s.iStackCount or 0
		self:IncrementStackCount(B)
	end
end
function A.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function A.prototype.EOM_GetModifierInjuryPermanent(self, s)
	return self:GetStackCount()
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
				IsIndependent = true,
			}
		),
	},
	A
)
g.modifier_nyx_assassin_talent_8_debuff = A
g.nyx_assassin_ult = c()
local C = g.nyx_assassin_ult
C.name = "nyx_assassin_ult"
d(C, o)
function C.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	local D = z:GetEnemy()
	local E = self:GetSpecialValueFor("damage")
	local F = self:GetSpecialValueFor("duration")
	z:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
	local G = self:GetTalentValue("nyx_assassin_talent_9", "mana_reduce")
	if G > 0 then
		StealMana(z, D, G)
	end
	local H = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta.vpcf",
		PATTACH_CUSTOMORIGIN,
		z
	)
	ParticleManager:SetParticleControlEnt(H, 0, z, PATTACH_POINT, "attach_mouth", z:GetAbsOrigin(), false)
	DamageSystem:performAttack(z, D, { ability = self })
	z:DealDamage(D, self, E, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	AddBroken(z, D, self, F)
	local I = self:GetTalentValue("nyx_assassin_talent_6", "injury_damage_pct")
	local J = self:GetTalentValue("nyx_assassin_talent_10", "interval_reduce")
	if I > 0 then
		local K = GetInjury(D)
		z:StartGesture(ACT_DOTA_CAST_ABILITY_2)
		self:GameTimer(0.4, function()
			if not IsInjurable(z, D) then
				return
			end
			z:DealDamage(
				D,
				self,
				K * I * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				DamageFlags.DAMAGE_FLAG_KEEP_INJURY_COUNT
			)
			z:EmitSound("Hero_NyxAssassin.Jolt.Target")
			local H = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_nyx_assassin/nyx_assassin_jolt.vpcf",
				PATTACH_CUSTOMORIGIN,
				z
			)
			ParticleManager:SetParticleControlEnt(
				H,
				0,
				z,
				PATTACH_POINT_FOLLOW,
				"attach_mouth",
				z:GetAbsOrigin(),
				false
			)
			ParticleManager:SetParticleControlEnt(
				H,
				1,
				D,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				D:GetAbsOrigin(),
				false
			)
		end)
	end
	if J > 0 then
		local L = z:FindModifierByName("modifier_nyx_assassin_talent")
		if L then
			L.record = L.record + J
		end
	end
end
C = e({ p(nil) }, C)
g.nyx_assassin_ult = C
g.modifier_nyx_assassin_ult = c()
local M = g.modifier_nyx_assassin_ult
M.name = "modifier_nyx_assassin_ult"
d(M, l)
function M.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end
M = e(
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
	M
)
g.modifier_nyx_assassin_ult = M
return g