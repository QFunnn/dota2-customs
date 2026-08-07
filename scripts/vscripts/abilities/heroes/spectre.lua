--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/spectre"
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
		["17"] = 8,
		["18"] = 9,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["22"] = 11,
		["23"] = 10,
		["24"] = 9,
		["25"] = 8,
		["26"] = 9,
		["28"] = 9,
		["29"] = 15,
		["30"] = 23,
		["31"] = 15,
		["32"] = 23,
		["34"] = 23,
		["35"] = 31,
		["36"] = 34,
		["37"] = 15,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 40,
		["42"] = 42,
		["43"] = 44,
		["44"] = 46,
		["45"] = 48,
		["46"] = 49,
		["47"] = 50,
		["48"] = 36,
		["49"] = 52,
		["50"] = 53,
		["51"] = 54,
		["52"] = 55,
		["53"] = 56,
		["55"] = 58,
		["56"] = 59,
		["59"] = 52,
		["60"] = 63,
		["61"] = 64,
		["62"] = 64,
		["63"] = 66,
		["64"] = 66,
		["65"] = 66,
		["66"] = 64,
		["67"] = 67,
		["68"] = 67,
		["69"] = 67,
		["70"] = 64,
		["71"] = 64,
		["72"] = 63,
		["73"] = 70,
		["74"] = 71,
		["75"] = 72,
		["77"] = 74,
		["78"] = 75,
		["80"] = 77,
		["81"] = 78,
		["82"] = 70,
		["83"] = 80,
		["84"] = 81,
		["85"] = 82,
		["86"] = 83,
		["87"] = 80,
		["88"] = 85,
		["89"] = 86,
		["90"] = 87,
		["93"] = 91,
		["94"] = 92,
		["95"] = 93,
		["96"] = 94,
		["97"] = 95,
		["98"] = 95,
		["99"] = 95,
		["100"] = 95,
		["101"] = 95,
		["102"] = 95,
		["103"] = 95,
		["104"] = 95,
		["105"] = 95,
		["106"] = 96,
		["107"] = 96,
		["108"] = 96,
		["109"] = 96,
		["110"] = 96,
		["111"] = 96,
		["112"] = 96,
		["113"] = 96,
		["114"] = 96,
		["115"] = 97,
		["116"] = 99,
		["117"] = 100,
		["118"] = 100,
		["119"] = 100,
		["120"] = 100,
		["121"] = 100,
		["122"] = 100,
		["123"] = 100,
		["124"] = 100,
		["125"] = 100,
		["128"] = 85,
		["129"] = 112,
		["130"] = 113,
		["131"] = 112,
		["132"] = 117,
		["133"] = 118,
		["134"] = 119,
		["135"] = 120,
		["136"] = 121,
		["137"] = 122,
		["140"] = 125,
		["141"] = 126,
		["142"] = 127,
		["143"] = 128,
		["144"] = 129,
		["145"] = 130,
		["147"] = 131,
		["148"] = 131,
		["149"] = 132,
		["150"] = 131,
		["154"] = 135,
		["155"] = 136,
		["157"] = 137,
		["158"] = 137,
		["159"] = 138,
		["160"] = 137,
		["167"] = 145,
		["168"] = 146,
		["169"] = 147,
		["170"] = 148,
		["171"] = 149,
		["172"] = 150,
		["173"] = 151,
		["174"] = 151,
		["175"] = 151,
		["176"] = 151,
		["177"] = 151,
		["178"] = 151,
		["179"] = 151,
		["180"] = 151,
		["181"] = 151,
		["182"] = 152,
		["183"] = 152,
		["184"] = 152,
		["185"] = 152,
		["186"] = 152,
		["187"] = 152,
		["188"] = 152,
		["189"] = 152,
		["190"] = 152,
		["191"] = 153,
		["192"] = 155,
		["193"] = 156,
		["194"] = 156,
		["195"] = 156,
		["196"] = 156,
		["197"] = 156,
		["198"] = 161,
		["199"] = 162,
		["201"] = 163,
		["202"] = 163,
		["203"] = 164,
		["204"] = 164,
		["205"] = 164,
		["206"] = 164,
		["207"] = 164,
		["208"] = 164,
		["209"] = 164,
		["210"] = 164,
		["211"] = 164,
		["212"] = 163,
		["216"] = 156,
		["217"] = 156,
		["220"] = 180,
		["221"] = 117,
		["222"] = 23,
		["223"] = 15,
		["224"] = 15,
		["225"] = 15,
		["226"] = 15,
		["227"] = 15,
		["228"] = 15,
		["229"] = 15,
		["230"] = 15,
		["231"] = 23,
		["233"] = 23,
		["234"] = 188,
		["235"] = 189,
		["236"] = 188,
		["237"] = 189,
		["238"] = 190,
		["239"] = 191,
		["240"] = 192,
		["241"] = 193,
		["242"] = 194,
		["243"] = 195,
		["244"] = 196,
		["245"] = 197,
		["246"] = 197,
		["247"] = 197,
		["248"] = 197,
		["249"] = 197,
		["250"] = 197,
		["251"] = 203,
		["252"] = 204,
		["253"] = 205,
		["254"] = 206,
		["256"] = 197,
		["257"] = 197,
		["258"] = 210,
		["259"] = 190,
		["260"] = 212,
		["261"] = 213,
		["262"] = 212,
		["263"] = 189,
		["264"] = 188,
		["265"] = 189,
		["267"] = 189,
		["268"] = 216,
		["269"] = 224,
		["270"] = 216,
		["271"] = 224,
		["272"] = 228,
		["273"] = 229,
		["274"] = 231,
		["275"] = 233,
		["276"] = 228,
		["277"] = 235,
		["278"] = 236,
		["279"] = 235,
		["280"] = 238,
		["281"] = 239,
		["282"] = 240,
		["283"] = 240,
		["284"] = 239,
		["285"] = 238,
		["286"] = 243,
		["287"] = 244,
		["288"] = 245,
		["290"] = 243,
		["291"] = 248,
		["292"] = 249,
		["293"] = 250,
		["294"] = 251,
		["297"] = 254,
		["298"] = 255,
		["299"] = 256,
		["300"] = 256,
		["301"] = 256,
		["302"] = 256,
		["303"] = 256,
		["304"] = 256,
		["305"] = 257,
		["306"] = 258,
		["307"] = 258,
		["308"] = 258,
		["309"] = 258,
		["310"] = 258,
		["311"] = 259,
		["312"] = 259,
		["313"] = 259,
		["314"] = 259,
		["315"] = 259,
		["316"] = 248,
		["317"] = 261,
		["318"] = 262,
		["319"] = 261,
		["320"] = 266,
		["321"] = 267,
		["322"] = 268,
		["324"] = 266,
		["325"] = 224,
		["326"] = 216,
		["327"] = 216,
		["328"] = 216,
		["329"] = 216,
		["330"] = 216,
		["331"] = 216,
		["332"] = 216,
		["333"] = 216,
		["334"] = 224,
		["336"] = 224,
		["337"] = 272,
		["338"] = 280,
		["339"] = 272,
		["340"] = 280,
		["341"] = 280,
		["342"] = 272,
		["343"] = 272,
		["344"] = 272,
		["345"] = 272,
		["346"] = 272,
		["347"] = 272,
		["348"] = 272,
		["349"] = 272,
		["350"] = 280,
		["352"] = 280,
		["353"] = 301,
		["354"] = 302,
		["355"] = 301,
		["356"] = 302,
		["357"] = 303,
		["358"] = 304,
		["359"] = 303,
		["360"] = 302,
		["361"] = 301,
		["362"] = 302,
		["364"] = 302,
		["365"] = 307,
		["366"] = 315,
		["367"] = 307,
		["368"] = 315,
		["369"] = 317,
		["370"] = 318,
		["371"] = 317,
		["372"] = 320,
		["373"] = 321,
		["374"] = 320,
		["375"] = 315,
		["376"] = 307,
		["377"] = 307,
		["378"] = 307,
		["379"] = 307,
		["380"] = 307,
		["381"] = 307,
		["382"] = 307,
		["383"] = 307,
		["384"] = 315,
		["386"] = 315,
		["387"] = 328,
		["388"] = 329,
		["389"] = 328,
		["390"] = 329,
		["391"] = 330,
		["392"] = 331,
		["393"] = 330,
		["394"] = 329,
		["395"] = 328,
		["396"] = 329,
		["398"] = 329,
		["399"] = 336,
		["400"] = 344,
		["401"] = 336,
		["402"] = 344,
		["403"] = 346,
		["404"] = 347,
		["405"] = 346,
		["406"] = 349,
		["407"] = 350,
		["408"] = 349,
		["409"] = 344,
		["410"] = 336,
		["411"] = 336,
		["412"] = 336,
		["413"] = 336,
		["414"] = 336,
		["415"] = 336,
		["416"] = 336,
		["417"] = 336,
		["418"] = 344,
		["420"] = 344,
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
g.spectre_talent = c()
local q = g.spectre_talent
q.name = "spectre_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_spectre_talent"
end
q = e({ j(nil) }, q)
g.spectre_talent = q
g.modifier_spectre_talent = c()
local r = g.modifier_spectre_talent
r.name = "modifier_spectre_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl6_record = -1
	self.tl7_record = -1
end
function r.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
	self.ulti_reduce = self:GetAbilitySpecialValueFor("ulti_reduce")
	self.tl2_bonus_reduce = self:GetAbilityTalentValue("spectre_talent_2", "bonus_reduce")
	self.tl4_bonus_pct = self:GetAbilityTalentValue("spectre_talent_4", "bonus_pct")
	self.tl5_reflection_pct = self:GetAbilityTalentValue("spectre_talent_5", "reflection_pct")
	self.tl6_count = self:GetAbilityTalentValue("spectre_talent_6", "count")
	self.tl7_count = self:GetAbilityTalentValue("spectre_talent_7", "count")
	self.tl7_damage_factor = self:GetAbilityTalentValue("spectre_talent_7", "damage_factor")
	self.final_reduce = self.damage_reduce
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self.final_reduce = self.damage_reduce + GetEvasion(self:GetParent()) * self.tl2_bonus_reduce
		if self:GetParent():HasModifier("modifier_spectre_ult") then
			self.final_reduce = self.final_reduce + self.ulti_reduce
		end
		if self.tl4_bonus_pct > 0 and self:GetParent():HasModifier("modifier_spectre_ult") then
			local s = self.final_reduce + self.tl4_bonus_pct
		end
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_EVASION] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, t)
	if self.tl6_count > 0 then
		self.tl6_record = 0
	end
	if self.tl7_count > 0 then
		self.tl7_record = 0
	end
	self:StartIntervalThink(0.1)
	self.ult_ability = self:GetParent():FindAbilityByName("spectre_ult")
end
function r.prototype.OnBattleEnd(self, t)
	self.tl6_record = -1
	self.tl7_record = -1
	self:StartIntervalThink(-1)
end
function r.prototype.OnEvasion(self, t)
	if self.tl5_reflection_pct > 0 and t.evade_damage > 0 then
		if
			t.damage_flags
			and bit.band(t.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) == DamageFlags.DAMAGE_FLAG_REFLECTION
		then
			return
		end
		local u = t.attacker
		local v = t.target
		if IsInjurable(u, v) then
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_spectre/spectre_dispersion.vpcf",
				PATTACH_CUSTOMORIGIN,
				v
			)
			ParticleManager:SetParticleControlEnt(
				w,
				0,
				u,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				u:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				w,
				1,
				v,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				v:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(w)
			local x = t.evade_damage * self.tl5_reflection_pct * 0.01 + self.final_reduce
			DamageSystem:dealDamage({
				attacker = v,
				target = u,
				ability = self:GetAbility(),
				damage = x,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				damage_flags = DamageFlags.DAMAGE_FLAG_REFLECTION
					+ DamageFlags.DAMAGE_FLAG_HPLOSS
					+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
				damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
			})
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS }
end
function r.prototype.EOM_GetModifierEvadeDamageReduceBonus(self, t)
	local y = self.final_reduce
	local z = self:GetParent()
	local A = z:GetEnemy()
	local B = self:GetAbility()
	if not IsInjurable(z, A) then
		return
	end
	if self.tl6_record >= 0 then
		self.tl6_record = self.tl6_record + y
		if self.tl6_record >= self.tl6_count then
			local C = math.floor(self.tl6_record / self.tl6_count)
			self.tl6_record = self.tl6_record % self.tl6_count
			if IsValid(self.ult_ability) then
				do
					local D = 0
					while D < C do
						self.ult_ability:OnSpellStart()
						D = D + 1
					end
				end
			else
				self.ult_ability = self:GetParent():FindAbilityByName("spectre_ult")
				if IsValid(self.ult_ability) then
					do
						local D = 0
						while D < C do
							self.ult_ability:OnSpellStart()
							D = D + 1
						end
					end
				end
			end
		end
	end
	if self.tl7_record >= 0 then
		self.tl7_record = self.tl7_record + y
		if self.tl7_record >= self.tl7_count then
			local C = math.floor(self.tl7_record / self.tl7_count)
			self.tl7_record = self.tl7_record % self.tl7_count
			local w = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_spectre/spectre_dispersion.vpcf",
				PATTACH_CUSTOMORIGIN,
				z
			)
			ParticleManager:SetParticleControlEnt(
				w,
				0,
				A,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				A:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				w,
				1,
				z,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				z:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(w)
			local x = GetEvasion(z) * self.tl7_damage_factor
			Projectile:CreateTrackingProjectile({
				hCaster = z,
				vSpawnOrigin = z:GetAbsOrigin(),
				hTarget = A,
				iMoveSpeed = PROJECTILE_SPEED_FAST,
				OnProjectileHit = function(E, F, G)
					if IsValid(self) and IsInjurable(E) then
						do
							local D = 0
							while D < C do
								DamageSystem:dealDamage({
									attacker = z,
									target = A,
									ability = B,
									damage = x,
									damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
									damage_flags = DamageFlags.DAMAGE_FLAG_REFLECTION,
									damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
								})
								D = D + 1
							end
						end
					end
				end,
			})
		end
	end
	return self.parent:PassivesDisabled() and 0 or y
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
g.modifier_spectre_talent = r
g.spectre_ult = c()
local H = g.spectre_ult
H.name = "spectre_ult"
d(H, o)
function H.prototype.OnSpellStart(self)
	local I = self:GetCaster()
	local E = I:GetEnemy()
	local x = self:GetSpecialValueFor("damage") + self:GetTalentValue("spectre_talent_1", "damage_bonus")
	local J = self:GetSpecialValueFor("duration")
	I:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	I:EmitSound("Hero_Spectre.DaggerCast")
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_spectre/spectre_ulti.vpcf",
		hCaster = I,
		hTarget = E,
		vSpawnOrigin = I:GetAbsOrigin(),
		iMoveSpeed = 600,
		OnProjectileHit = function(E, F, G)
			if IsInjurable(E) then
				I:DealDamage(E, self, x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				EmitSoundOnLocationWithCaster(F, "Hero_Spectre.DaggerImpact", I)
			end
		end,
	})
	I:AddNewModifier(I, self, "modifier_spectre_ult", { duration = J })
end
function H.prototype.GetIntrinsicModifierName(self)
	return "modifier_spectre_ult_buff"
end
H = e({ p(nil) }, H)
g.spectre_ult = H
g.modifier_spectre_ult_buff = c()
local K = g.modifier_spectre_ult_buff
K.name = "modifier_spectre_ult_buff"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.damage_factor = self:GetAbilitySpecialValueFor("damage_factor")
	self.s_enable = self:HasTalent("spectre_shard")
	self.tl9_evade_bonus = self:GetAbilityTalentValue("spectre_talent_9", "evade_bonus")
end
function K.prototype.getUltimateBuffState(self)
	return self.s_enable or self:GetParent():HasModifier("modifier_spectre_ult")
end
function K.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function K.prototype.OnCustomAttackLanded(self, L)
	if self:getUltimateBuffState() then
		self:Desolate()
	end
end
function K.prototype.Desolate(self)
	local u = self:GetCaster()
	local M = u:GetEnemy()
	if not IsInjurable(u, M) then
		return
	end
	local x = GetEvasion(u) * self.damage_factor
	u:EmitSound("Hero_Spectre.Desolate")
	u:DealDamage(M, self:GetAbility(), x, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	local N = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_spectre/spectre_desolate.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(N, 0, M:GetAttachmentPosition("attach_hitloc"))
	ParticleManager:SetParticleControlForward(N, 0, (M:GetAbsOrigin() - u:GetAbsOrigin()):Normalized())
end
function K.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function K.prototype.EOM_GetModifierEvasion_Bonus(self, t)
	if self:getUltimateBuffState() then
		return self.tl9_evade_bonus
	end
end
K = e(
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
	K
)
g.modifier_spectre_ult_buff = K
g.modifier_spectre_ult = c()
local O = g.modifier_spectre_ult
O.name = "modifier_spectre_ult"
d(O, l)
O = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/units/heroes/hero_spectre/spectre_talent.vpcf",
			}
		),
	},
	O
)
g.modifier_spectre_ult = O
g.spectre_talent_3 = c()
local P = g.spectre_talent_3
P.name = "spectre_talent_3"
d(P, i)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_spectre_talent_3"
end
P = e({ j(nil) }, P)
g.spectre_talent_3 = P
g.modifier_spectre_talent_3 = c()
local Q = g.modifier_spectre_talent_3
Q.name = "modifier_spectre_talent_3"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilitySpecialValueFor("health_bonus")
end
function Q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.health_bonus }
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
g.modifier_spectre_talent_3 = Q
g.spectre_talent_8 = c()
local R = g.spectre_talent_8
R.name = "spectre_talent_8"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_spectre_talent_8"
end
R = e({ j(nil) }, R)
g.spectre_talent_8 = R
g.modifier_spectre_talent_8 = c()
local S = g.modifier_spectre_talent_8
S.name = "modifier_spectre_talent_8"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.evade = self:GetAbilitySpecialValueFor("evade")
end
function S.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = self.evade }
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
g.modifier_spectre_talent_8 = S
return g