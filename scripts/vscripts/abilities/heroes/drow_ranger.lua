--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/drow_ranger"
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
		["29"] = 11,
		["30"] = 19,
		["31"] = 11,
		["32"] = 19,
		["34"] = 19,
		["35"] = 31,
		["36"] = 11,
		["37"] = 33,
		["38"] = 34,
		["39"] = 35,
		["40"] = 37,
		["41"] = 38,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 42,
		["46"] = 33,
		["47"] = 44,
		["48"] = 45,
		["51"] = 46,
		["52"] = 47,
		["53"] = 47,
		["54"] = 47,
		["55"] = 48,
		["56"] = 49,
		["58"] = 50,
		["59"] = 51,
		["60"] = 47,
		["61"] = 47,
		["63"] = 44,
		["64"] = 55,
		["65"] = 56,
		["66"] = 56,
		["67"] = 58,
		["68"] = 58,
		["69"] = 58,
		["70"] = 56,
		["71"] = 56,
		["72"] = 55,
		["73"] = 61,
		["74"] = 62,
		["75"] = 63,
		["77"] = 61,
		["78"] = 66,
		["79"] = 67,
		["82"] = 68,
		["83"] = 66,
		["84"] = 70,
		["85"] = 71,
		["86"] = 72,
		["87"] = 73,
		["88"] = 74,
		["89"] = 74,
		["90"] = 74,
		["91"] = 75,
		["92"] = 75,
		["93"] = 75,
		["94"] = 74,
		["95"] = 74,
		["96"] = 74,
		["97"] = 74,
		["98"] = 74,
		["99"] = 74,
		["100"] = 74,
		["101"] = 81,
		["102"] = 81,
		["103"] = 81,
		["104"] = 81,
		["105"] = 81,
		["106"] = 82,
		["107"] = 82,
		["108"] = 82,
		["109"] = 82,
		["110"] = 82,
		["111"] = 82,
		["112"] = 82,
		["113"] = 82,
		["114"] = 82,
		["115"] = 83,
		["116"] = 83,
		["117"] = 83,
		["118"] = 83,
		["119"] = 83,
		["120"] = 84,
		["121"] = 84,
		["122"] = 84,
		["123"] = 84,
		["124"] = 84,
		["125"] = 84,
		["126"] = 84,
		["127"] = 84,
		["128"] = 84,
		["129"] = 86,
		["130"] = 70,
		["131"] = 88,
		["132"] = 89,
		["133"] = 90,
		["134"] = 91,
		["135"] = 93,
		["136"] = 94,
		["137"] = 95,
		["138"] = 96,
		["140"] = 98,
		["142"] = 88,
		["143"] = 101,
		["144"] = 102,
		["147"] = 103,
		["148"] = 101,
		["149"] = 105,
		["150"] = 106,
		["151"] = 105,
		["152"] = 111,
		["153"] = 112,
		["154"] = 111,
		["155"] = 116,
		["156"] = 118,
		["157"] = 124,
		["159"] = 116,
		["160"] = 127,
		["161"] = 128,
		["162"] = 127,
		["163"] = 130,
		["164"] = 131,
		["165"] = 131,
		["166"] = 131,
		["167"] = 131,
		["168"] = 130,
		["169"] = 133,
		["170"] = 133,
		["171"] = 133,
		["173"] = 134,
		["174"] = 135,
		["175"] = 136,
		["176"] = 137,
		["177"] = 138,
		["178"] = 139,
		["179"] = 140,
		["180"] = 141,
		["181"] = 142,
		["182"] = 142,
		["183"] = 142,
		["184"] = 142,
		["185"] = 142,
		["186"] = 142,
		["187"] = 142,
		["188"] = 143,
		["189"] = 144,
		["190"] = 145,
		["191"] = 146,
		["193"] = 148,
		["194"] = 148,
		["195"] = 148,
		["196"] = 148,
		["197"] = 148,
		["198"] = 148,
		["199"] = 148,
		["201"] = 133,
		["202"] = 19,
		["203"] = 11,
		["204"] = 11,
		["205"] = 11,
		["206"] = 11,
		["207"] = 11,
		["208"] = 11,
		["209"] = 11,
		["210"] = 11,
		["211"] = 19,
		["213"] = 19,
		["214"] = 154,
		["215"] = 155,
		["216"] = 154,
		["217"] = 155,
		["218"] = 156,
		["219"] = 157,
		["220"] = 158,
		["221"] = 159,
		["222"] = 161,
		["223"] = 162,
		["224"] = 163,
		["225"] = 164,
		["226"] = 165,
		["227"] = 166,
		["228"] = 167,
		["229"] = 168,
		["230"] = 169,
		["231"] = 169,
		["232"] = 169,
		["233"] = 169,
		["234"] = 169,
		["235"] = 169,
		["236"] = 169,
		["237"] = 169,
		["238"] = 177,
		["239"] = 178,
		["240"] = 179,
		["241"] = 180,
		["242"] = 181,
		["244"] = 169,
		["245"] = 169,
		["248"] = 156,
		["249"] = 155,
		["250"] = 154,
		["251"] = 155,
		["253"] = 155,
		["254"] = 192,
		["255"] = 201,
		["256"] = 192,
		["257"] = 201,
		["258"] = 210,
		["259"] = 211,
		["260"] = 212,
		["261"] = 213,
		["262"] = 215,
		["263"] = 216,
		["264"] = 217,
		["265"] = 218,
		["266"] = 210,
		["267"] = 220,
		["268"] = 221,
		["271"] = 222,
		["272"] = 223,
		["273"] = 224,
		["274"] = 220,
		["275"] = 226,
		["276"] = 227,
		["279"] = 228,
		["280"] = 226,
		["281"] = 230,
		["282"] = 231,
		["283"] = 232,
		["284"] = 233,
		["285"] = 234,
		["286"] = 235,
		["287"] = 236,
		["290"] = 239,
		["291"] = 240,
		["292"] = 241,
		["294"] = 243,
		["295"] = 243,
		["296"] = 244,
		["297"] = 244,
		["298"] = 244,
		["299"] = 244,
		["300"] = 244,
		["301"] = 244,
		["302"] = 244,
		["303"] = 246,
		["304"] = 246,
		["305"] = 246,
		["306"] = 246,
		["307"] = 250,
		["308"] = 250,
		["309"] = 250,
		["310"] = 250,
		["311"] = 246,
		["312"] = 246,
		["313"] = 246,
		["314"] = 246,
		["315"] = 254,
		["316"] = 255,
		["317"] = 256,
		["318"] = 257,
		["319"] = 258,
		["322"] = 246,
		["323"] = 246,
		["324"] = 243,
		["327"] = 264,
		["328"] = 265,
		["329"] = 266,
		["330"] = 267,
		["332"] = 230,
		["333"] = 270,
		["334"] = 271,
		["337"] = 272,
		["338"] = 270,
		["339"] = 274,
		["340"] = 275,
		["341"] = 276,
		["342"] = 276,
		["343"] = 276,
		["344"] = 275,
		["345"] = 277,
		["346"] = 277,
		["347"] = 277,
		["348"] = 275,
		["349"] = 275,
		["350"] = 274,
		["351"] = 280,
		["352"] = 281,
		["353"] = 282,
		["354"] = 280,
		["355"] = 284,
		["356"] = 285,
		["357"] = 284,
		["358"] = 289,
		["359"] = 290,
		["360"] = 289,
		["361"] = 292,
		["362"] = 293,
		["363"] = 294,
		["364"] = 295,
		["365"] = 296,
		["366"] = 297,
		["367"] = 298,
		["368"] = 299,
		["372"] = 292,
		["373"] = 201,
		["374"] = 192,
		["375"] = 192,
		["376"] = 192,
		["377"] = 192,
		["378"] = 192,
		["379"] = 192,
		["380"] = 192,
		["381"] = 192,
		["382"] = 192,
		["383"] = 201,
		["385"] = 201,
		["386"] = 306,
		["387"] = 314,
		["388"] = 306,
		["389"] = 314,
		["390"] = 316,
		["391"] = 317,
		["392"] = 316,
		["393"] = 319,
		["394"] = 320,
		["395"] = 319,
		["396"] = 314,
		["397"] = 306,
		["398"] = 306,
		["399"] = 306,
		["400"] = 306,
		["401"] = 306,
		["402"] = 306,
		["403"] = 306,
		["404"] = 306,
		["405"] = 314,
		["407"] = 314,
		["408"] = 326,
		["409"] = 327,
		["410"] = 326,
		["411"] = 327,
		["412"] = 328,
		["413"] = 329,
		["414"] = 328,
		["415"] = 327,
		["416"] = 326,
		["417"] = 327,
		["419"] = 327,
		["420"] = 333,
		["421"] = 341,
		["422"] = 333,
		["423"] = 341,
		["424"] = 344,
		["425"] = 345,
		["426"] = 346,
		["427"] = 344,
		["428"] = 348,
		["429"] = 349,
		["430"] = 350,
		["431"] = 350,
		["432"] = 350,
		["433"] = 349,
		["434"] = 351,
		["435"] = 351,
		["436"] = 351,
		["437"] = 349,
		["438"] = 349,
		["439"] = 348,
		["440"] = 354,
		["441"] = 355,
		["442"] = 356,
		["443"] = 354,
		["444"] = 358,
		["445"] = 359,
		["446"] = 360,
		["447"] = 361,
		["448"] = 362,
		["449"] = 363,
		["450"] = 364,
		["451"] = 365,
		["455"] = 358,
		["456"] = 341,
		["457"] = 333,
		["458"] = 333,
		["459"] = 333,
		["460"] = 333,
		["461"] = 333,
		["462"] = 333,
		["463"] = 333,
		["464"] = 333,
		["465"] = 341,
		["467"] = 341,
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
g.drow_ranger_talent = c()
local q = g.drow_ranger_talent
q.name = "drow_ranger_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_drow_ranger_talent"
end
q = e({ j(nil) }, q)
g.drow_ranger_talent = q
g.modifier_drow_ranger_talent = c()
local r = g.modifier_drow_ranger_talent
r.name = "modifier_drow_ranger_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.hillOffset = 100
end
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.ice = self:GetAbilitySpecialValueFor("ice")
	self.effect_pct = self:GetAbilityTalentValue("drow_ranger_talent_4", "effect_pct")
	self.damage_pct = self:GetAbilityTalentValue("drow_ranger_talent_5", "damage_pct")
	self.chance = self:GetAbilityTalentValue("drow_ranger_talent_6", "chance")
	self.bonus_damage = self:GetAbilityTalentValue("drow_ranger_talent_6", "bonus_damage")
	self.talent7IceLimit = self:GetAbilityTalentValue("drow_ranger_talent_7", "ice_limit")
	self.talent7HitChance = self:GetAbilityTalentValue("drow_ranger_talent_7", "chance")
end
function r.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	if self.chance > 0 then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(t, s, u, v)
			if
				u == self.parent
				and s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
				and bit.band(s.damage_flags, DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING) ~= DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
				and self:PRD(self.chance)
			then
				s.damage_flags = s.damage_flags + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
			end
			s.damage_flags = s.damage_flags + DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING
			s.damage = s.damage + self.bonus_damage
		end)
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetCaster(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	if self:HasTalent("drow_ranger_talent_2") then
		self:CreateHilltop()
	end
end
function r.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyHilltop()
end
function r.prototype.CreateHilltop(self)
	local w = self:GetCaster()
	w:EmitSound("Hero_Drow.Glacier")
	w:SetAbsOrigin(w:GetAbsOrigin() + Vector(0, 0, self.hillOffset))
	self.hill = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = GetGroundPosition(w:GetAbsOrigin(), w) + Vector(0, 0, self.hillOffset),
			model = "models/heroes/drow/drow_glacier_hilltop_model.vmdl",
			StartingAnim = "drow_glacier_spawn",
			scale = "4",
			angles = VectorToAngles(w:GetRightVector()),
		}
	)
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_drow/drow_glacier_hilltop.vpcf",
		PATTACH_CUSTOMORIGIN,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		x,
		0,
		self.hill,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.hill:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(x, 1, self.hill:GetAbsOrigin() + self.hill:GetForwardVector() * 100)
	ParticleManager:SetParticleControlEnt(x, 2, w, PATTACH_POINT_FOLLOW, "bow_bot", w:GetAbsOrigin(), true)
	self.hill._AMBIENT_PARTICLEID = x
end
function r.prototype.DestroyHilltop(self)
	if IsValidEntity(self.hill) then
		local w = self:GetCaster()
		w:SetAbsOrigin(w:GetAbsOrigin() + Vector(0, 0, -self.hillOffset))
		local y = self.hill._AMBIENT_PARTICLEID
		if y ~= nil then
			ParticleManager:DestroyParticle(y, true)
			ParticleManager:ReleaseParticleIndex(y)
		end
		self.hill:RemoveSelf()
	end
end
function r.prototype.OnCustomAttackLanded(self, z)
	if self.parent:PassivesDisabled() then
		return
	end
	self:ForstArrow()
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_EVASION }
end
function r.prototype.EOM_GetModifierIgnoreEvasion(self, s)
	if
		s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		and IsValid(s.ability)
		and IsValid(s.target)
		and (s.ability == self:GetAbility() or s.ability:GetAbilityName() == "drow_ranger_ult")
		and GetIce(s.target) > self.talent7IceLimit
	then
		return self.talent7HitChance
	end
end
function r.prototype.GetAttackSound(self)
	return "Hero_DrowRanger.FrostArrows"
end
function r.prototype.GetModifierProjectileName(self)
	return Wearable:getReplaceParticle(self:GetParent(), "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf")
end
function r.prototype.ForstArrow(self, A, B)
	if A == nil then
		A = 0
	end
	local C = self:GetParent()
	local v = C:GetEnemy()
	local D = self:GetAbility()
	if IsInjurable(C, v) then
		local E = GetIce(v)
		local F = 1 + self.effect_pct * 0.01
		local G = self.damage * (1 + A * 0.01)
		local H = E * self.damage_pct * 0.01 * (1 + A * 0.01)
		AddIce(C, v, self.ice * (1 + A * 0.01) * F, "drow_ranger_talent", "Ability")
		local I = DamageFlags.DAMAGE_FLAG_NONE
		if GetIce(v) > self.talent7IceLimit then
			I = I + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
			I = I + DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING
		end
		C:DealDamage(v, B or D, (G + H) * F, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, I)
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
g.modifier_drow_ranger_talent = r
g.drow_ranger_ult = c()
local J = g.drow_ranger_ult
J.name = "drow_ranger_ult"
d(J, o)
function J.prototype.OnSpellStart(self)
	local u = self:GetCaster()
	local K = self:GetSpecialValueFor("duration")
	u:AddNewModifier(u, self, "modifier_drow_ranger_ult", { duration = K })
	local L = self:GetTalentValue("drow_ranger_shard", "duration")
	if L > 0 then
		local M = u:GetEnemy()
		if IsInjurable(u, M) then
			local N = M:GetAbsOrigin() - u:GetAbsOrigin()
			N.z = 0
			N = N:Normalized()
			u:EmitSound("Hero_DrowRanger.Silence")
			Projectile:CreateLinearProjectile({
				EffectName = "particles/units/heroes/hero_drow/drow_silence_wave.vpcf",
				hCaster = u,
				vSpawnOrigin = u:GetAbsOrigin(),
				vDirection = N,
				flDistance = 800,
				flRadius = 450,
				iMoveSpeed = PROJECTILE_SPEED_FAST,
				OnProjectileHit = function(v, O, P)
					if IsValid(self) and IsInjurable(v) then
						AddSilence(u, v, self, L)
						print("add modifier_drow_ranger_shard", L, self)
						v:AddNewModifier(u, self, "modifier_drow_ranger_shard", { duration = L })
					end
				end,
			})
		end
	end
end
J = e({ p(nil) }, J)
g.drow_ranger_ult = J
g.modifier_drow_ranger_ult = c()
local Q = g.modifier_drow_ranger_ult
Q.name = "modifier_drow_ranger_ult"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.wave = self:GetAbilitySpecialValueFor("wave")
		+ self:GetAbilityTalentValue("drow_ranger_talent_2", "bonus_count")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.arrow_count_per_wave = 4
	self.bonus_pct = self:GetAbilityTalentValue("drow_ranger_talent_1", "bonus_pct")
	self.interval_ice = self:GetAbilityTalentValue("drow_ranger_talent_3", "interval_ice")
	self.ice_record = 0
end
function Q.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.duration / self.wave)
	self:GetCaster():EmitSound("Hero_DrowRanger.Multishot.Channel")
	self:IncrementStackCount()
end
function Q.prototype.OnRefresh(self, s)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end
function Q.prototype.OnIntervalThink(self)
	local C = self:GetParent()
	local R = false
	local S = 50
	local N = C:GetForwardVector()
	local T = C:FindModifierByName("modifier_drow_ranger_talent")
	if not IsValid(T) then
		return
	end
	local U = self:HasTalent("drow_ranger_talent_1") and 200 or 100
	local V = self:GetStackCount()
	local D = self:GetAbility()
	do
		local W = 0
		while W < self.arrow_count_per_wave do
			local X = Script_RemapValClamped(W, 0, 3, 2, -1)
			Projectile:CreateLinearProjectile({
				EffectName = "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf",
				hCaster = C,
				vSpawnOrigin = C:GetAttachmentPosition("attach_attack1"),
				vDirection = Rotation2D(nil, N, -math.rad(S / 5 * X)),
				flDistance = 800,
				flRadius = 250,
				iMoveSpeed = 1200,
				OnProjectileHit = function(v, O, P)
					if not R and IsInjurable(v) then
						R = true
						if IsValid(T) and IsValid(D) then
							T:ForstArrow((self.bonus_pct + self.damage) * V, D)
						end
					end
				end,
			})
			W = W + 1
		end
	end
	self.wave = self.wave - 1
	if self.wave <= 0 then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end
function Q.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetCaster():StopSound("Hero_DrowRanger.Multishot.Channel")
end
function Q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function Q.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
	self:Destroy()
end
function Q.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function Q.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CHANNEL_ABILITY_3
end
function Q.prototype.OnIceGained(self, s)
	if self.interval_ice > 0 then
		self.ice_record = self.ice_record + 1
		if self.ice_record >= self.interval_ice then
			self.ice_record = 0
			local Y = self:GetAbility()
			if IsValid(Y) then
				Y:OnSpellStart()
			end
		end
	end
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
				IsIndependent = true,
			}
		),
	},
	Q
)
g.modifier_drow_ranger_ult = Q
g.modifier_drow_ranger_shard = c()
local Z = g.modifier_drow_ranger_shard
Z.name = "modifier_drow_ranger_shard"
d(Z, l)
function Z.prototype.GetAbilitySpecialValue(self)
	self.evasion_reduce = self:GetAbilityTalentValue("drow_ranger_shard", "evasion_reduce")
end
function Z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS] = -self.evasion_reduce }
end
Z = e(
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
	Z
)
g.modifier_drow_ranger_shard = Z
g.drow_ranger_talent_3 = c()
local _ = g.drow_ranger_talent_3
_.name = "drow_ranger_talent_3"
d(_, i)
function _.prototype.GetIntrinsicModifierName(self)
	return "modifier_drow_ranger_talent_3"
end
_ = e({ j(nil) }, _)
g.drow_ranger_talent_3 = _
g.modifier_drow_ranger_talent_3 = c()
local a0 = g.modifier_drow_ranger_talent_3
a0.name = "modifier_drow_ranger_talent_3"
d(a0, l)
function a0.prototype.GetAbilitySpecialValue(self)
	self.interval_ice = self:GetAbilityTalentValue("drow_ranger_talent_3", "interval_ice")
	self.ice_record = 0
end
function a0.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function a0.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
	self:Destroy()
end
function a0.prototype.OnIceGained(self, s)
	if self.interval_ice > 0 then
		self.ice_record = self.ice_record + 1
		if self.ice_record >= self.interval_ice then
			self.ice_record = 0
			local Y = self:GetParent():FindAbilityByName("drow_ranger_ult")
			if IsValid(Y) then
				Y:OnSpellStart()
			end
		end
	end
end
a0 = e(
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
	a0
)
g.modifier_drow_ranger_talent_3 = a0
return g