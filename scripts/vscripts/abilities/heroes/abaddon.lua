--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/abaddon"
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
		["35"] = 27,
		["36"] = 12,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 34,
		["41"] = 37,
		["42"] = 39,
		["43"] = 40,
		["44"] = 43,
		["45"] = 31,
		["46"] = 45,
		["47"] = 46,
		["48"] = 46,
		["49"] = 49,
		["50"] = 49,
		["51"] = 49,
		["52"] = 46,
		["53"] = 50,
		["54"] = 50,
		["55"] = 50,
		["56"] = 46,
		["57"] = 46,
		["58"] = 45,
		["59"] = 53,
		["60"] = 54,
		["61"] = 55,
		["62"] = 53,
		["63"] = 62,
		["64"] = 62,
		["65"] = 73,
		["66"] = 75,
		["67"] = 73,
		["68"] = 77,
		["69"] = 78,
		["70"] = 79,
		["71"] = 80,
		["72"] = 81,
		["73"] = 82,
		["76"] = 85,
		["79"] = 77,
		["80"] = 89,
		["81"] = 90,
		["82"] = 91,
		["83"] = 92,
		["86"] = 95,
		["87"] = 96,
		["88"] = 97,
		["89"] = 97,
		["90"] = 97,
		["91"] = 97,
		["92"] = 97,
		["93"] = 97,
		["94"] = 97,
		["95"] = 97,
		["96"] = 97,
		["97"] = 98,
		["98"] = 99,
		["99"] = 100,
		["100"] = 101,
		["101"] = 101,
		["102"] = 101,
		["103"] = 101,
		["104"] = 101,
		["105"] = 101,
		["106"] = 101,
		["107"] = 102,
		["108"] = 107,
		["109"] = 109,
		["110"] = 110,
		["111"] = 110,
		["112"] = 110,
		["113"] = 110,
		["114"] = 110,
		["115"] = 110,
		["116"] = 116,
		["117"] = 117,
		["118"] = 118,
		["119"] = 119,
		["120"] = 119,
		["121"] = 119,
		["122"] = 119,
		["123"] = 119,
		["124"] = 119,
		["125"] = 119,
		["126"] = 119,
		["127"] = 119,
		["129"] = 110,
		["130"] = 110,
		["132"] = 89,
		["133"] = 133,
		["134"] = 134,
		["135"] = 135,
		["136"] = 135,
		["137"] = 135,
		["138"] = 135,
		["140"] = 133,
		["141"] = 20,
		["142"] = 12,
		["143"] = 12,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 20,
		["152"] = 20,
		["153"] = 140,
		["154"] = 149,
		["155"] = 140,
		["156"] = 149,
		["157"] = 156,
		["158"] = 158,
		["159"] = 159,
		["160"] = 160,
		["161"] = 162,
		["162"] = 156,
		["163"] = 164,
		["164"] = 165,
		["165"] = 166,
		["166"] = 167,
		["167"] = 168,
		["169"] = 170,
		["171"] = 164,
		["172"] = 173,
		["173"] = 174,
		["174"] = 175,
		["175"] = 176,
		["176"] = 177,
		["177"] = 178,
		["179"] = 180,
		["180"] = 181,
		["182"] = 183,
		["184"] = 173,
		["185"] = 149,
		["186"] = 140,
		["187"] = 140,
		["188"] = 140,
		["189"] = 140,
		["190"] = 140,
		["191"] = 140,
		["192"] = 140,
		["193"] = 140,
		["194"] = 140,
		["195"] = 149,
		["197"] = 149,
		["198"] = 188,
		["199"] = 189,
		["200"] = 188,
		["201"] = 189,
		["202"] = 190,
		["203"] = 191,
		["204"] = 192,
		["205"] = 193,
		["208"] = 194,
		["209"] = 195,
		["210"] = 196,
		["211"] = 199,
		["212"] = 199,
		["213"] = 199,
		["214"] = 199,
		["215"] = 199,
		["216"] = 199,
		["217"] = 200,
		["218"] = 201,
		["219"] = 202,
		["220"] = 203,
		["223"] = 190,
		["224"] = 207,
		["225"] = 208,
		["226"] = 207,
		["227"] = 189,
		["228"] = 188,
		["229"] = 189,
		["231"] = 189,
		["232"] = 212,
		["233"] = 220,
		["234"] = 212,
		["235"] = 220,
		["236"] = 223,
		["237"] = 225,
		["238"] = 223,
		["239"] = 228,
		["240"] = 229,
		["241"] = 229,
		["242"] = 231,
		["243"] = 231,
		["244"] = 231,
		["245"] = 229,
		["246"] = 232,
		["247"] = 232,
		["248"] = 232,
		["249"] = 229,
		["250"] = 229,
		["251"] = 228,
		["252"] = 235,
		["253"] = 236,
		["254"] = 235,
		["255"] = 238,
		["256"] = 239,
		["257"] = 238,
		["258"] = 241,
		["259"] = 242,
		["262"] = 243,
		["263"] = 244,
		["264"] = 245,
		["265"] = 246,
		["266"] = 247,
		["269"] = 241,
		["270"] = 220,
		["271"] = 212,
		["272"] = 212,
		["273"] = 212,
		["274"] = 212,
		["275"] = 212,
		["276"] = 212,
		["277"] = 212,
		["278"] = 212,
		["279"] = 220,
		["281"] = 220,
		["282"] = 253,
		["283"] = 261,
		["284"] = 253,
		["285"] = 261,
		["286"] = 266,
		["287"] = 267,
		["288"] = 268,
		["289"] = 266,
		["290"] = 270,
		["291"] = 271,
		["292"] = 272,
		["293"] = 273,
		["294"] = 274,
		["296"] = 277,
		["297"] = 277,
		["298"] = 277,
		["299"] = 277,
		["300"] = 277,
		["301"] = 278,
		["302"] = 278,
		["303"] = 278,
		["304"] = 278,
		["305"] = 278,
		["306"] = 279,
		["307"] = 279,
		["308"] = 279,
		["309"] = 279,
		["310"] = 279,
		["311"] = 279,
		["312"] = 279,
		["313"] = 279,
		["314"] = 280,
		["315"] = 280,
		["316"] = 280,
		["317"] = 280,
		["318"] = 280,
		["319"] = 280,
		["320"] = 280,
		["321"] = 280,
		["323"] = 270,
		["324"] = 283,
		["325"] = 284,
		["326"] = 285,
		["327"] = 286,
		["329"] = 288,
		["330"] = 288,
		["331"] = 288,
		["332"] = 288,
		["333"] = 288,
		["335"] = 283,
		["336"] = 291,
		["337"] = 292,
		["338"] = 293,
		["340"] = 291,
		["341"] = 296,
		["342"] = 297,
		["343"] = 298,
		["344"] = 299,
		["345"] = 300,
		["346"] = 301,
		["347"] = 301,
		["348"] = 301,
		["349"] = 301,
		["350"] = 301,
		["351"] = 301,
		["352"] = 301,
		["353"] = 301,
		["355"] = 303,
		["356"] = 304,
		["357"] = 305,
		["358"] = 305,
		["359"] = 305,
		["360"] = 305,
		["361"] = 305,
		["362"] = 305,
		["363"] = 305,
		["364"] = 305,
		["365"] = 305,
		["366"] = 314,
		["367"] = 315,
		["368"] = 316,
		["369"] = 316,
		["370"] = 316,
		["371"] = 316,
		["372"] = 316,
		["373"] = 317,
		["376"] = 320,
		["377"] = 321,
		["378"] = 296,
		["379"] = 323,
		["380"] = 324,
		["381"] = 325,
		["382"] = 325,
		["383"] = 325,
		["384"] = 324,
		["385"] = 326,
		["386"] = 326,
		["387"] = 326,
		["388"] = 324,
		["389"] = 324,
		["390"] = 323,
		["391"] = 329,
		["392"] = 330,
		["393"] = 331,
		["395"] = 329,
		["396"] = 334,
		["397"] = 335,
		["398"] = 336,
		["399"] = 337,
		["401"] = 334,
		["402"] = 261,
		["403"] = 253,
		["404"] = 253,
		["405"] = 253,
		["406"] = 253,
		["407"] = 253,
		["408"] = 253,
		["409"] = 253,
		["410"] = 253,
		["411"] = 261,
		["413"] = 261,
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
g.abaddon_talent = c()
local q = g.abaddon_talent
q.name = "abaddon_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_abaddon_talent"
end
q = e({ j(nil) }, q)
g.abaddon_talent = q
g.modifier_abaddon_talent = c()
local r = g.modifier_abaddon_talent
r.name = "modifier_abaddon_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.timerTick = 0.1
end
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.tl1_damage_pct = self:GetAbilityTalentValue("abaddon_talent_1", "damage_pct")
	self.tl8_chance = self:GetAbilityTalentValue("abaddon_talent_8", "chance")
	self.tl8_mana = self:GetAbilityTalentValue("abaddon_talent_8", "mana")
	self.record = 0
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.record = 0
	self:StartIntervalThink(self.timerTick)
end
function r.prototype.OnBattleStart(self, s) end
function r.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self.record = self.record + self.timerTick
		if self.record >= self.interval then
			self.record = 0
			if self:GetParent():PassivesDisabled() then
				return
			end
			self:DeathCoil()
		end
	end
end
function r.prototype.DeathCoil(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if not IsInjurable(u, t) then
		return
	end
	local v = self:GetAbility()
	local w = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion.vpcf",
		PATTACH_CUSTOMORIGIN,
		t
	)
	ParticleManager:SetParticleControlEnt(w, 1, t, PATTACH_POINT_FOLLOW, "attach_hitloc", t:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(w)
	t:EmitSound("Hero_Abaddon.DeathCoil.Target")
	local x = t:GetHealth() * self.damage_pct * 0.01
	t:DealDamage(
		t,
		v,
		x,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
		DamageFlags.DAMAGE_FLAG_HPLOSS + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
	)
	t:AddNewModifier(t, v, "modifier_abaddon_talent_buff", { duration = self.duration, damageValue = x })
	if self.tl1_damage_pct > 0 then
		t:EmitSound("Hero_Abaddon.DeathCoil.Cast")
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
			hCaster = t,
			vSpawnOrigin = t:GetAttachmentPosition("attach_hitloc"),
			hTarget = u,
			iMoveSpeed = 900,
			OnProjectileHit = function(y, z, A)
				if IsValid(self) and IsValid(v) and IsInjurable(t, u) then
					t:EmitSound("Hero_Abaddon.DeathCoil.Target")
					DamageSystem:dealDamage({
						attacker = t,
						target = u,
						ability = self:GetAbility(),
						damage = x * self.tl1_damage_pct * 0.01,
						damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
						damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
						damage_flags = DamageFlags.DAMAGE_FLAG_HPLOSS + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
					})
				end
			end,
		})
	end
end
function r.prototype.OnShieldGained(self, s)
	if self.tl8_chance > 0 and self:PRD(self.tl8_chance, "tl8_chance") then
		Restore(self:GetParent(), self.tl8_mana)
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
g.modifier_abaddon_talent = r
g.modifier_abaddon_talent_buff = c()
local B = g.modifier_abaddon_talent_buff
B.name = "modifier_abaddon_talent_buff"
d(B, l)
function B.prototype.GetAbilitySpecialValue(self)
	self.tick = self:GetAbilitySpecialValueFor("tick") - self:GetAbilityTalentValue("abaddon_talent_5", "cd_reduce")
	self.shield_count = self:GetAbilitySpecialValueFor("shield_count")
	self.regen_pct = self:GetAbilitySpecialValueFor("regen_pct")
	self.tl3_regen_pct = self:GetAbilityTalentValue("abaddon_talent_3", "regen_pct")
end
function B.prototype.OnCreated(self, s)
	if IsServer() then
		self.regen = s and s.damageValue or 0
		if self.regen > 0 then
			self.regen = self.regen * self.regen_pct * 0.01
		end
		self:StartIntervalThink(self.tick)
	end
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		local t = self:GetParent()
		local C = self.regen
		if self.tl3_regen_pct > 0 then
			C = C + t:GetMaxHealth() * self.tl3_regen_pct * 0.01
		end
		if C > 0 then
			Heal(t, C, "abaddon_talent", "Ability")
		end
		AddShield(t, self.shield_count, "abaddon_talent", "Ability")
	end
end
B = e(
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
	B
)
g.modifier_abaddon_talent_buff = B
g.abaddon_ult = c()
local D = g.abaddon_ult
D.name = "abaddon_ult"
d(D, o)
function D.prototype.OnSpellStart(self)
	local E = self:GetCaster()
	local u = E:GetEnemy()
	if not IsInjurable(E, u) then
		return
	end
	local F = self:GetSpecialValueFor("duration")
	local G = self:GetSpecialValueFor("shield_count")
	E:AddNewModifier(E, self, "modifier_abaddon_ult_buff", { duration = F })
	AddShield(E, G, self:GetAbilityName(), "Ability")
	if self:HasTalent("abaddon_talent_2") then
		local H = E:FindModifierByName("modifier_abaddon_talent")
		if IsValid(H) then
			H:DeathCoil()
		end
	end
end
function D.prototype.GetIntrinsicModifierName(self)
	return "modifier_abaddon_ult"
end
D = e({ p(nil) }, D)
g.abaddon_ult = D
g.modifier_abaddon_ult = c()
local I = g.modifier_abaddon_ult
I.name = "modifier_abaddon_ult"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilityTalentValue("abaddon_shard", "threshold")
end
function I.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function I.prototype.OnBattleStartBefore(self, s)
	self.ult_trigger = true
end
function I.prototype.OnBattleEnd(self, s)
	self.ult_trigger = false
end
function I.prototype.OnCustomTakeDamage(self, J)
	if not self.ult_trigger or self:GetParent():PassivesDisabled() then
		return
	end
	if J.target:GetHealthPercent() <= self.threshold then
		self.ult_trigger = false
		local v = self:GetAbility()
		if IsValid(v) then
			v:OnSpellStart()
		end
	end
end
I = e(
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
	I
)
g.modifier_abaddon_ult = I
g.modifier_abaddon_ult_buff = c()
local K = g.modifier_abaddon_ult_buff
K.name = "modifier_abaddon_ult_buff"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.regen_pct = self:GetAbilitySpecialValueFor("regen_pct")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function K.prototype.OnCreated(self, s)
	if IsServer() then
		self.regen_record = 0
		self.damage_record = 0
		self:GetParent():EmitSound("Hero_Abaddon.BorrowedTime")
	else
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		local M = ParticleManager:CreateParticle(
			"particles/status_fx/status_effect_abaddon_borrowed_time.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(L, false, false, -1, false, false)
		self:AddParticle(M, false, true, 1, false, false)
	end
end
function K.prototype.OnRefresh(self, s)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Abaddon.BorrowedTime")
		self:OnBuffEnd()
	else
		ParticleManager:CreateParticle(
			"particles/units/heroes/hero_abaddon/abaddon_borrowed_time_e.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
	end
end
function K.prototype.OnDestroy(self)
	if IsServer() then
		self:OnBuffEnd()
	end
end
function K.prototype.OnBuffEnd(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if IsInjurable(t, u) then
		if self.regen_record > 0 then
			Heal(
				self:GetParent(),
				self.regen_record * self.regen_pct * 0.01,
				self:GetAbility():GetAbilityName(),
				"Ability",
				true,
				HealFlags.HEAL_FLAG_NONE
			)
		end
		if self.damage_record > 0 then
			local x = self.damage_pct * self.damage_record * 0.01
			DamageSystem:dealDamage({
				attacker = t,
				target = u,
				ability = self:GetAbility(),
				damage = x,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
				damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
				damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
			})
			local N = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf",
				PATTACH_CUSTOMORIGIN,
				t
			)
			local O = t:GetAbsOrigin()
			ParticleManager:SetParticleControl(N, 0, O + Vector(0, 0, 96))
			EmitSoundOnLocationWithCaster(O, "Hero_Abaddon.AphoticShield.Destroy", t)
		end
	end
	self.regen_record = 0
	self.damage_record = 0
end
function K.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ADJUST] = { -1, self:GetParent() },
	}
end
function K.prototype.OnAdjust(self, s)
	if s.adjust_damage > 0 then
		self.damage_record = self.damage_record + s.adjust_damage
	end
end
function K.prototype.OnShieldGained(self, s)
	local P = s.iStackCount
	if P > 0 then
		self.regen_record = self.regen_record + P
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
g.modifier_abaddon_ult_buff = K
return g