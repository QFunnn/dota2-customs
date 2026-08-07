--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/muerta"
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
		["35"] = 28,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 12,
		["40"] = 33,
		["41"] = 34,
		["42"] = 35,
		["43"] = 36,
		["44"] = 38,
		["45"] = 33,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["49"] = 48,
		["50"] = 48,
		["51"] = 47,
		["52"] = 49,
		["53"] = 49,
		["54"] = 49,
		["55"] = 47,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 47,
		["60"] = 51,
		["61"] = 51,
		["62"] = 51,
		["63"] = 47,
		["64"] = 47,
		["65"] = 46,
		["66"] = 55,
		["67"] = 56,
		["68"] = 57,
		["69"] = 58,
		["70"] = 59,
		["73"] = 55,
		["74"] = 64,
		["75"] = 65,
		["76"] = 66,
		["77"] = 67,
		["78"] = 68,
		["79"] = 69,
		["80"] = 69,
		["81"] = 69,
		["82"] = 69,
		["83"] = 69,
		["84"] = 69,
		["85"] = 75,
		["86"] = 76,
		["87"] = 77,
		["89"] = 69,
		["90"] = 69,
		["91"] = 81,
		["93"] = 64,
		["94"] = 84,
		["95"] = 85,
		["96"] = 86,
		["97"] = 87,
		["98"] = 88,
		["99"] = 89,
		["100"] = 90,
		["102"] = 95,
		["104"] = 84,
		["105"] = 98,
		["106"] = 99,
		["107"] = 100,
		["108"] = 101,
		["109"] = 102,
		["111"] = 104,
		["112"] = 105,
		["113"] = 105,
		["114"] = 105,
		["115"] = 105,
		["116"] = 106,
		["117"] = 107,
		["119"] = 98,
		["120"] = 110,
		["121"] = 111,
		["122"] = 112,
		["123"] = 113,
		["124"] = 114,
		["125"] = 115,
		["126"] = 116,
		["127"] = 117,
		["128"] = 117,
		["129"] = 117,
		["130"] = 117,
		["131"] = 117,
		["132"] = 117,
		["133"] = 123,
		["134"] = 124,
		["135"] = 125,
		["136"] = 126,
		["137"] = 127,
		["139"] = 117,
		["140"] = 117,
		["144"] = 110,
		["145"] = 20,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 12,
		["154"] = 20,
		["156"] = 20,
		["157"] = 139,
		["158"] = 140,
		["159"] = 139,
		["160"] = 140,
		["161"] = 142,
		["162"] = 143,
		["163"] = 144,
		["164"] = 145,
		["165"] = 146,
		["166"] = 147,
		["167"] = 148,
		["168"] = 149,
		["170"] = 151,
		["171"] = 154,
		["172"] = 142,
		["173"] = 156,
		["174"] = 157,
		["175"] = 156,
		["176"] = 159,
		["177"] = 160,
		["178"] = 159,
		["179"] = 140,
		["180"] = 139,
		["181"] = 140,
		["183"] = 140,
		["184"] = 163,
		["185"] = 171,
		["186"] = 163,
		["187"] = 171,
		["188"] = 172,
		["189"] = 173,
		["190"] = 172,
		["191"] = 177,
		["192"] = 178,
		["193"] = 179,
		["195"] = 177,
		["196"] = 171,
		["197"] = 163,
		["198"] = 163,
		["199"] = 163,
		["200"] = 163,
		["201"] = 163,
		["202"] = 163,
		["203"] = 163,
		["204"] = 163,
		["205"] = 171,
		["207"] = 171,
		["208"] = 184,
		["209"] = 195,
		["210"] = 184,
		["211"] = 195,
		["212"] = 200,
		["213"] = 201,
		["214"] = 204,
		["215"] = 205,
		["216"] = 200,
		["217"] = 207,
		["218"] = 208,
		["219"] = 209,
		["221"] = 211,
		["222"] = 211,
		["223"] = 211,
		["224"] = 211,
		["225"] = 211,
		["226"] = 212,
		["227"] = 212,
		["228"] = 212,
		["229"] = 212,
		["230"] = 212,
		["231"] = 212,
		["232"] = 212,
		["233"] = 212,
		["235"] = 207,
		["236"] = 215,
		["237"] = 216,
		["238"] = 217,
		["240"] = 215,
		["241"] = 220,
		["242"] = 221,
		["245"] = 222,
		["246"] = 223,
		["247"] = 220,
		["248"] = 225,
		["249"] = 226,
		["250"] = 226,
		["251"] = 231,
		["252"] = 231,
		["253"] = 231,
		["254"] = 226,
		["255"] = 226,
		["256"] = 226,
		["257"] = 225,
		["258"] = 235,
		["259"] = 236,
		["260"] = 235,
		["261"] = 242,
		["262"] = 243,
		["263"] = 242,
		["264"] = 245,
		["265"] = 246,
		["266"] = 245,
		["267"] = 248,
		["268"] = 249,
		["269"] = 250,
		["270"] = 250,
		["271"] = 250,
		["272"] = 249,
		["273"] = 251,
		["274"] = 251,
		["275"] = 251,
		["276"] = 249,
		["277"] = 249,
		["278"] = 248,
		["279"] = 254,
		["280"] = 255,
		["281"] = 254,
		["282"] = 257,
		["283"] = 258,
		["284"] = 257,
		["285"] = 260,
		["286"] = 261,
		["287"] = 260,
		["288"] = 266,
		["289"] = 267,
		["290"] = 266,
		["291"] = 269,
		["292"] = 270,
		["293"] = 270,
		["294"] = 270,
		["295"] = 270,
		["296"] = 269,
		["297"] = 195,
		["298"] = 184,
		["299"] = 184,
		["300"] = 184,
		["301"] = 184,
		["302"] = 184,
		["303"] = 184,
		["304"] = 184,
		["305"] = 184,
		["306"] = 184,
		["307"] = 184,
		["308"] = 195,
		["310"] = 195,
		["312"] = 285,
		["313"] = 286,
		["314"] = 285,
		["315"] = 286,
		["316"] = 287,
		["317"] = 288,
		["318"] = 287,
		["319"] = 286,
		["320"] = 285,
		["321"] = 286,
		["323"] = 286,
		["324"] = 291,
		["325"] = 299,
		["326"] = 291,
		["327"] = 299,
		["328"] = 302,
		["329"] = 303,
		["330"] = 302,
		["331"] = 305,
		["332"] = 306,
		["333"] = 305,
		["334"] = 311,
		["335"] = 312,
		["336"] = 311,
		["337"] = 299,
		["338"] = 291,
		["339"] = 291,
		["340"] = 291,
		["341"] = 291,
		["342"] = 291,
		["343"] = 291,
		["344"] = 291,
		["345"] = 291,
		["346"] = 299,
		["348"] = 299,
		["349"] = 336,
		["350"] = 337,
		["351"] = 336,
		["352"] = 337,
		["353"] = 338,
		["354"] = 339,
		["355"] = 338,
		["356"] = 337,
		["357"] = 336,
		["358"] = 337,
		["360"] = 337,
		["361"] = 343,
		["362"] = 351,
		["363"] = 343,
		["364"] = 351,
		["365"] = 354,
		["366"] = 355,
		["367"] = 354,
		["368"] = 357,
		["369"] = 358,
		["370"] = 359,
		["372"] = 357,
		["373"] = 363,
		["374"] = 364,
		["375"] = 363,
		["376"] = 369,
		["377"] = 370,
		["378"] = 369,
		["379"] = 372,
		["380"] = 373,
		["381"] = 373,
		["383"] = 374,
		["384"] = 372,
		["385"] = 351,
		["386"] = 343,
		["387"] = 343,
		["388"] = 343,
		["389"] = 343,
		["390"] = 343,
		["391"] = 343,
		["392"] = 343,
		["393"] = 343,
		["394"] = 351,
		["396"] = 351,
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
g.muerta_talent = c()
local q = g.muerta_talent
q.name = "muerta_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_muerta_talent"
end
q = e({ j(nil) }, q)
g.muerta_talent = q
g.modifier_muerta_talent = c()
local r = g.modifier_muerta_talent
r.name = "modifier_muerta_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tl6_record = 0
	self.fade = false
	self.trigger = false
	self.lastTime = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("muerta_talent_5", "bonus_chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
		+ self:GetAbilityTalentValue("muerta_talent_4", "bonus_damage")
	self.tl6_threshold = self:GetAbilityTalentValue("muerta_talent_6", "threshold")
end
function r.prototype.EDeclareEvents(self)
	return {
		[MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent(), -1 },
		[MODIFIER_EVENT_ON_ATTACK] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnBattleEnd(self, s)
	if IsServer() then
		local t = self:GetParent():GetPlayerOwnerID()
		if t == s.winPlayerID then
			self:AddCount(1, "muerta_shard_win")
		end
	end
end
function r.prototype.OnAttack(self, u)
	if self.trigger then
		self.trigger = false
		local v = self:GetParent()
		local w = u.target
		Projectile:CreateTrackingProjectile({
			EffectName = v:HasModifier("modifier_muerta_ult_buff")
					and "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf"
				or "particles/units/heroes/hero_muerta/muerta_base_attack_alt.vpcf",
			hCaster = v,
			vSpawnOrigin = v:GetAttachmentPosition("attach_attack2"),
			hTarget = w,
			iMoveSpeed = v:GetProjectileSpeed(),
			OnProjectileHit = function(x, y, z)
				if IsInjurable(v, w) then
					self:AttackAlt(v, w)
				end
			end,
		})
		v:EmitSound("Hero_Muerta.PierceTheVeil.Attack")
	end
end
function r.prototype.AttackAlt(self, v, w)
	local A = self:GetAbility()
	local B = GetAttackDamage(v)
	local C = B * self.damage * 0.01 + self.base_damage
	if self:HasTalent("muerta_talent_3") then
		C = C + B
		DamageSystem:performAttack(v, w, { ability = A, damage = C })
	else
		v:DealDamage(w, A, C, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
end
function r.prototype.OnAttackStart(self, u)
	local v = self:GetParent()
	if self.fade then
		self.fade = false
		v:FadeGesture(ACT_DOTA_CAST_ABILITY_3)
	end
	if not self:GetParent():PassivesDisabled() and self:PRD(self.chance) then
		v:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, v:GetAttackSpeed(false))
		self.trigger = true
		self.fade = true
	end
end
function r.prototype.OnCustomTakeDamage(self, u)
	if self.tl6_threshold > 0 then
		if u.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
			self.tl6_record = self.tl6_record + u.damage
			if self.tl6_record >= self.tl6_threshold then
				self.tl6_record = self.tl6_record - self.tl6_threshold
				u.attacker:EmitSound("Hero_Muerta.DeadShot.Cast")
				Projectile:CreateTrackingProjectile({
					EffectName = "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf",
					hCaster = u.attacker,
					vSpawnOrigin = u.attacker:GetAttachmentPosition("attach_attack1"),
					hTarget = u.target,
					iMoveSpeed = u.attacker:GetProjectileSpeed(),
					OnProjectileHit = function(x, y, z)
						if IsValid(self) then
							self:AttackAlt(u.attacker, x)
							u.attacker:EmitSound("Hero_Muerta.DeadShot.Damage", y)
							u.attacker:EmitSound("Hero_Muerta.DeadShot.Ricochet.Impact", y)
						end
					end,
				})
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
g.modifier_muerta_talent = r
g.muerta_ult = c()
local D = g.muerta_ult
D.name = "muerta_ult"
d(D, o)
function D.prototype.OnSpellStart(self)
	local E = self:GetCaster()
	E:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local F = self:GetSpecialValueFor("duration") + self:GetTalentValue("muerta_talent_2", "bonus_duration")
	local G = F
	local H = E:FindModifierByName("modifier_muerta_ult_buff")
	if IsValid(H) then
		G = G + H:GetRemainingTime()
	end
	E:AddNewModifier(E, self, "modifier_muerta_ult_buff", { duration = G })
	E:EmitSound("Hero_Muerta.PierceTheVeil.Cast")
end
function D.prototype.setUltAttackRecord(self, I)
	self.attackRecord = I
end
function D.prototype.GetIntrinsicModifierName(self)
	return "modifier_muerta_ult"
end
D = e({ p(nil) }, D)
g.muerta_ult = D
g.modifier_muerta_ult = c()
local J = g.modifier_muerta_ult
J.name = "modifier_muerta_ult"
d(J, l)
function J.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY }
end
function J.prototype.EOM_GetModifierAttackSourceAbility(self, s)
	if s and self:GetAbility().attackRecord == s then
		return self:GetAbility()
	end
end
J = e(
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
	J
)
g.modifier_muerta_ult = J
g.modifier_muerta_ult_buff = c()
local K = g.modifier_muerta_ult_buff
K.name = "modifier_muerta_ult_buff"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.tl1_attack = self:GetAbilityTalentValue("muerta_talent_1", "attack")
	self.tl7_attackspeed_bonus = self:GetAbilityTalentValue("muerta_talent_7", "attackspeed_bonus")
end
function K.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	else
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(L, false, false, -1, false, false)
	end
end
function K.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function K.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Muerta.PierceTheVeil.End")
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
end
function K.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TYPE] = EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME] = Wearable:getReplaceParticle(
			self:GetParent(),
			"particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf"
		),
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.tl7_attackspeed_bonus,
	}
end
function K.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
	}
end
function K.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.attackspeed * self:GetStackCount()
end
function K.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.tl1_attack
end
function K.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function K.prototype.OnCustomAttackStart(self, u)
	self:GetAbility():setUltAttackRecord(u)
end
function K.prototype.EOM_GetModifierAttackDamageTotalPercentage(self)
	return GetUltiPower(self:GetParent())
end
function K.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function K.prototype.GetActivityTranslationModifiers(self)
	return "activity_trans"
end
function K.prototype.GetModifierModelChange(self)
	return Wearable:getReplaceUnitModel(self:GetParent(), "models/heroes/muerta/muerta_ult.vmdl")
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
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
				IsIndependent = true,
			}
		),
	},
	K
)
g.modifier_muerta_ult_buff = K
g.muerta_talent_7 = c()
local M = g.muerta_talent_7
M.name = "muerta_talent_7"
d(M, i)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_muerta_talent_7"
end
M = e({ j(nil) }, M)
g.muerta_talent_7 = M
g.modifier_muerta_talent_7 = c()
local N = g.modifier_muerta_talent_7
N.name = "modifier_muerta_talent_7"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.steal_pct = self:GetAbilitySpecialValueFor("steal_pct")
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL }
end
function N.prototype.EOM_GetModifierAbilityLifesteal(self, s)
	return self.steal_pct
end
N = e(
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
	N
)
g.modifier_muerta_talent_7 = N
g.muerta_shard = c()
local O = g.muerta_shard
O.name = "muerta_shard"
d(O, i)
function O.prototype.GetIntrinsicModifierName(self)
	return "modifier_muerta_shard"
end
O = e({ j(nil) }, O)
g.muerta_shard = O
g.modifier_muerta_shard = c()
local P = g.modifier_muerta_shard
P.name = "modifier_muerta_shard"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.amp_ulti_pct = self:GetAbilitySpecialValueFor("amp_ulti_pct")
end
function P.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(self:GetCount("muerta_shard_win"))
	end
end
function P.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER }
end
function P.prototype.EOM_GetModifierUltiPower(self)
	return self:GetShardAddUltiPower()
end
function P.prototype.GetShardAddUltiPower(self)
	if self.amp_ulti_pct <= 0 then
		return 0
	end
	return self.amp_ulti_pct * self:GetStackCount()
end
P = e(
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
	P
)
g.modifier_muerta_shard = P
return g