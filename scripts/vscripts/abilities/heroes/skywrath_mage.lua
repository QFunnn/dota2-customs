--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/skywrath_mage"
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
		["34"] = 38,
		["35"] = 39,
		["36"] = 40,
		["37"] = 42,
		["38"] = 45,
		["39"] = 46,
		["40"] = 47,
		["41"] = 48,
		["42"] = 50,
		["43"] = 51,
		["44"] = 52,
		["45"] = 54,
		["46"] = 38,
		["47"] = 60,
		["48"] = 61,
		["49"] = 60,
		["50"] = 65,
		["51"] = 66,
		["52"] = 67,
		["53"] = 67,
		["54"] = 66,
		["55"] = 65,
		["56"] = 70,
		["57"] = 71,
		["58"] = 72,
		["59"] = 73,
		["60"] = 74,
		["61"] = 75,
		["62"] = 76,
		["63"] = 76,
		["64"] = 76,
		["65"] = 76,
		["66"] = 76,
		["67"] = 76,
		["70"] = 79,
		["71"] = 80,
		["72"] = 81,
		["73"] = 82,
		["74"] = 82,
		["75"] = 82,
		["76"] = 82,
		["77"] = 82,
		["78"] = 82,
		["81"] = 70,
		["82"] = 87,
		["83"] = 88,
		["84"] = 89,
		["85"] = 90,
		["86"] = 91,
		["87"] = 92,
		["88"] = 93,
		["89"] = 94,
		["90"] = 106,
		["91"] = 107,
		["92"] = 108,
		["93"] = 110,
		["94"] = 111,
		["96"] = 113,
		["97"] = 113,
		["98"] = 113,
		["99"] = 113,
		["100"] = 113,
		["101"] = 113,
		["102"] = 119,
		["103"] = 120,
		["106"] = 122,
		["107"] = 123,
		["108"] = 124,
		["110"] = 127,
		["111"] = 128,
		["112"] = 128,
		["113"] = 128,
		["114"] = 128,
		["115"] = 128,
		["116"] = 128,
		["117"] = 129,
		["118"] = 129,
		["119"] = 129,
		["120"] = 129,
		["121"] = 129,
		["122"] = 129,
		["123"] = 132,
		["124"] = 132,
		["125"] = 132,
		["126"] = 132,
		["127"] = 132,
		["128"] = 132,
		["129"] = 134,
		["130"] = 134,
		["131"] = 134,
		["132"] = 134,
		["133"] = 134,
		["134"] = 134,
		["135"] = 136,
		["136"] = 136,
		["137"] = 136,
		["138"] = 136,
		["139"] = 136,
		["140"] = 136,
		["141"] = 113,
		["142"] = 113,
		["144"] = 87,
		["145"] = 21,
		["146"] = 13,
		["147"] = 13,
		["148"] = 13,
		["149"] = 13,
		["150"] = 13,
		["151"] = 13,
		["152"] = 13,
		["153"] = 13,
		["154"] = 21,
		["156"] = 21,
		["158"] = 144,
		["159"] = 145,
		["160"] = 144,
		["161"] = 145,
		["162"] = 146,
		["163"] = 147,
		["164"] = 148,
		["165"] = 149,
		["168"] = 150,
		["169"] = 151,
		["170"] = 152,
		["171"] = 153,
		["172"] = 156,
		["173"] = 157,
		["174"] = 158,
		["176"] = 146,
		["177"] = 145,
		["178"] = 144,
		["179"] = 145,
		["181"] = 145,
		["182"] = 163,
		["183"] = 172,
		["184"] = 163,
		["185"] = 172,
		["186"] = 176,
		["187"] = 177,
		["188"] = 178,
		["189"] = 176,
		["190"] = 181,
		["191"] = 182,
		["192"] = 183,
		["193"] = 184,
		["194"] = 185,
		["196"] = 187,
		["197"] = 187,
		["198"] = 187,
		["199"] = 187,
		["200"] = 187,
		["201"] = 192,
		["202"] = 192,
		["203"] = 192,
		["204"] = 192,
		["205"] = 192,
		["206"] = 193,
		["207"] = 193,
		["208"] = 193,
		["209"] = 193,
		["210"] = 193,
		["211"] = 193,
		["212"] = 193,
		["213"] = 193,
		["214"] = 193,
		["215"] = 194,
		["216"] = 194,
		["217"] = 194,
		["218"] = 194,
		["219"] = 194,
		["220"] = 194,
		["221"] = 194,
		["222"] = 194,
		["224"] = 181,
		["225"] = 197,
		["226"] = 198,
		["229"] = 199,
		["230"] = 197,
		["231"] = 201,
		["232"] = 202,
		["233"] = 203,
		["234"] = 204,
		["235"] = 205,
		["236"] = 206,
		["237"] = 206,
		["238"] = 206,
		["239"] = 206,
		["240"] = 206,
		["241"] = 206,
		["242"] = 208,
		["244"] = 201,
		["245"] = 172,
		["246"] = 163,
		["247"] = 163,
		["248"] = 163,
		["249"] = 163,
		["250"] = 163,
		["251"] = 163,
		["252"] = 163,
		["253"] = 163,
		["254"] = 163,
		["255"] = 172,
		["257"] = 172,
		["259"] = 218,
		["260"] = 226,
		["261"] = 218,
		["262"] = 226,
		["263"] = 228,
		["264"] = 229,
		["265"] = 228,
		["266"] = 231,
		["267"] = 232,
		["268"] = 233,
		["269"] = 234,
		["272"] = 231,
		["273"] = 238,
		["274"] = 239,
		["275"] = 238,
		["276"] = 226,
		["277"] = 218,
		["278"] = 218,
		["279"] = 218,
		["280"] = 218,
		["281"] = 218,
		["282"] = 218,
		["283"] = 218,
		["284"] = 218,
		["285"] = 226,
		["287"] = 226,
		["289"] = 244,
		["290"] = 245,
		["291"] = 244,
		["292"] = 245,
		["293"] = 246,
		["294"] = 247,
		["295"] = 246,
		["296"] = 245,
		["297"] = 244,
		["298"] = 245,
		["300"] = 245,
		["301"] = 250,
		["302"] = 258,
		["303"] = 250,
		["304"] = 258,
		["305"] = 260,
		["306"] = 261,
		["307"] = 260,
		["308"] = 263,
		["309"] = 264,
		["310"] = 265,
		["312"] = 263,
		["313"] = 268,
		["314"] = 269,
		["315"] = 268,
		["316"] = 271,
		["317"] = 272,
		["318"] = 271,
		["319"] = 258,
		["320"] = 250,
		["321"] = 250,
		["322"] = 250,
		["323"] = 250,
		["324"] = 250,
		["325"] = 250,
		["326"] = 250,
		["327"] = 250,
		["328"] = 258,
		["330"] = 258,
		["332"] = 277,
		["333"] = 285,
		["334"] = 277,
		["335"] = 285,
		["336"] = 287,
		["337"] = 288,
		["338"] = 287,
		["339"] = 290,
		["340"] = 291,
		["341"] = 290,
		["342"] = 293,
		["343"] = 294,
		["344"] = 293,
		["345"] = 285,
		["346"] = 277,
		["347"] = 277,
		["348"] = 277,
		["349"] = 277,
		["350"] = 277,
		["351"] = 277,
		["352"] = 277,
		["353"] = 277,
		["354"] = 285,
		["356"] = 285,
		["358"] = 299,
		["359"] = 307,
		["360"] = 299,
		["361"] = 307,
		["362"] = 311,
		["363"] = 312,
		["364"] = 313,
		["365"] = 314,
		["366"] = 311,
		["367"] = 316,
		["368"] = 317,
		["369"] = 318,
		["370"] = 319,
		["371"] = 319,
		["372"] = 319,
		["373"] = 319,
		["375"] = 316,
		["376"] = 322,
		["377"] = 323,
		["378"] = 322,
		["379"] = 325,
		["380"] = 326,
		["381"] = 325,
		["382"] = 328,
		["383"] = 329,
		["384"] = 329,
		["385"] = 329,
		["386"] = 329,
		["387"] = 328,
		["388"] = 307,
		["389"] = 299,
		["390"] = 299,
		["391"] = 299,
		["392"] = 299,
		["393"] = 299,
		["394"] = 299,
		["395"] = 299,
		["396"] = 299,
		["397"] = 307,
		["399"] = 307,
		["401"] = 334,
		["402"] = 335,
		["403"] = 334,
		["404"] = 335,
		["405"] = 336,
		["406"] = 337,
		["407"] = 336,
		["408"] = 335,
		["409"] = 334,
		["410"] = 335,
		["412"] = 335,
		["413"] = 340,
		["414"] = 348,
		["415"] = 340,
		["416"] = 348,
		["417"] = 350,
		["418"] = 351,
		["419"] = 350,
		["420"] = 353,
		["421"] = 354,
		["422"] = 355,
		["423"] = 355,
		["424"] = 354,
		["425"] = 353,
		["426"] = 358,
		["427"] = 359,
		["428"] = 360,
		["429"] = 361,
		["431"] = 358,
		["432"] = 348,
		["433"] = 340,
		["434"] = 340,
		["435"] = 340,
		["436"] = 340,
		["437"] = 340,
		["438"] = 340,
		["439"] = 340,
		["440"] = 340,
		["441"] = 348,
		["443"] = 348,
		["445"] = 367,
		["446"] = 376,
		["447"] = 367,
		["448"] = 376,
		["449"] = 380,
		["450"] = 381,
		["451"] = 380,
		["452"] = 383,
		["453"] = 385,
		["454"] = 386,
		["455"] = 383,
		["456"] = 388,
		["457"] = 389,
		["458"] = 390,
		["460"] = 388,
		["461"] = 393,
		["462"] = 394,
		["463"] = 395,
		["465"] = 393,
		["466"] = 398,
		["467"] = 399,
		["468"] = 398,
		["469"] = 401,
		["470"] = 402,
		["471"] = 401,
		["472"] = 376,
		["473"] = 367,
		["474"] = 367,
		["475"] = 367,
		["476"] = 367,
		["477"] = 367,
		["478"] = 367,
		["479"] = 367,
		["480"] = 367,
		["481"] = 367,
		["482"] = 376,
		["484"] = 376,
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
g.skywrath_mage_talent = c()
local q = g.skywrath_mage_talent
q.name = "skywrath_mage_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_skywrath_mage_talent"
end
q = e({ j(nil) }, q)
g.skywrath_mage_talent = q
g.modifier_skywrath_mage_talent = c()
local r = g.modifier_skywrath_mage_talent
r.name = "modifier_skywrath_mage_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("skywrath_mage_talent_5", "chance_bonus")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.regen_pct = self:GetAbilitySpecialValueFor("regen_pct")
		+ self:GetAbilityTalentValue("skywrath_mage_talent_2", "extra_regen_pct")
		+ self:GetAbilityTalentValue("skywrath_mage_shard", "regen_per")
	self.ice_immune_pct = self:GetAbilityTalentValue("skywrath_mage_talent_4", "ice_immune_pct")
	self.threshold = self:GetAbilityTalentValue("skywrath_mage_talent_1", "threshold")
	self.regen = self:GetAbilityTalentValue("skywrath_mage_talent_1", "regen")
	self.shard_duration = self:GetAbilityTalentValue("skywrath_mage_shard", "duration")
	local s = IsServer() and PlayerData:getTraitAbility(self:GetParent():GetPlayerOwnerID()) or nil
	self.g_chance = (s and s:GetAbilityName()) == "trait_196" and s:GetSpecialValueFor("chance") or 0
	self.g_slience = (s and s:GetAbilityName()) == "trait_196" and s:GetSpecialValueFor("slience") or 0
	self.damage_record = 0
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE] = self.ice_immune_pct }
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomTakeDamage(self, t)
	if t.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		if not self:GetCaster():PassivesDisabled() and self:PRD(self.chance, "chance") then
			self:ArcaneBolt()
			if self:PRD(self.g_chance, "g_chance") then
				self:ArcaneBolt()
				AddSilence(self.parent, self.parent:GetEnemy(), self:GetAbility(), self.g_slience)
			end
		end
		self.damage_record = self.damage_record + t.damage
		if self.regen > 0 and self.damage_record >= self.threshold then
			self.damage_record = 0
			Heal(self:GetParent(), self.regen, "skywrath_mage_talent_1", "Ability")
		end
	end
end
function r.prototype.ArcaneBolt(self)
	local u = self:GetParent()
	local v = u:GetEnemy()
	local w = self.base_damage
	local x = self.regen_pct
	local y = self:GetAbilityTalentValue("skywrath_mage_talent_4", "damage_stack")
	local z = self:GetAbilityTalentValue("skywrath_mage_talent_12", "chance")
	local A = self:GetAbilityTalentValue("skywrath_mage_talent_12", "shield")
	if IsInjurable(v) then
		u:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
		u:EmitSound("Hero_SkywrathMage.ArcaneBolt.Cast")
		if self:PRD(z, "ArcaneBolt") then
			AddShield(u, A, "skywrath_mage_talent_12", "Ability")
		end
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf",
			hCaster = u,
			vSpawnOrigin = u:GetAttachmentPosition("attach_attack1"),
			hTarget = v,
			iMoveSpeed = 1000,
			OnProjectileHit = function(B, C, D)
				if not IsValid(self) then
					return
				end
				local E = w
				if B:HasModifier("modifier_skywrath_mage_talent_4") then
					E = E + B:GetModifierStackCount("modifier_skywrath_mage_talent_4", u) * y
				end
				v:EmitSound("Hero_SkywrathMage.ArcaneBolt.Impact")
				u:DealDamage(v, self:GetAbility(), E, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				Heal(u, math.floor(E * x * 0.01), self:GetAbility():GetName(), "Ability")
				B:AddNewModifier(u, self:GetAbility(), "modifier_skywrath_mage_talent_4", {})
				B:AddNewModifier(u, self:GetAbility(), "modifier_skywrath_mage_talent_10", {})
				u:AddNewModifier(
					u,
					self:GetAbility(),
					"modifier_skywrath_mage_shard_buff",
					{ duration = self.shard_duration }
				)
			end,
		})
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
g.modifier_skywrath_mage_talent = r
g.skywrath_mage_ult = c()
local F = g.skywrath_mage_ult
F.name = "skywrath_mage_ult"
d(F, o)
function F.prototype.OnSpellStart(self)
	local G = self:GetCaster()
	local v = G:GetEnemy()
	if not IsInjurable(v, G) then
		return
	end
	G:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local H = self:GetSpecialValueFor("duration") + self:GetTalentValue("skywrath_mage_talent_3", "duration")
	v:AddNewModifier(G, self, "modifier_skywrath_mage_ult", { duration = H })
	G:EmitSound("Hero_SkywrathMage.MysticFlare.Cast")
	local I = self:GetTalentValue("skywrath_mage_talent_9", "duration")
	if I > 0 then
		G:AddNewModifier(G, self, "modifier_skywrath_mage_talent_9", { duration = I })
	end
end
F = e({ p(nil) }, F)
g.skywrath_mage_ult = F
g.modifier_skywrath_mage_ult = c()
local J = g.modifier_skywrath_mage_ult
J.name = "modifier_skywrath_mage_ult"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("skywrath_mage_talent_6", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("skywrath_mage_talent_7", "damage_bonus")
end
function J.prototype.OnCreated(self, K)
	local L = self:GetParent()
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:IncrementStackCount()
	else
		local M = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(M, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(M, 1, Vector(200, self:GetDuration(), self.interval))
		self:AddParticle(M, false, false, -1, false, false)
	end
end
function J.prototype.OnRefresh(self, K)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end
function J.prototype.OnIntervalThink(self)
	local N = self:GetParent()
	local G = self:GetCaster()
	if IsValid(N) then
		local O = self:GetStackCount()
		G:DealDamage(N, self:GetAbility(), self.damage * O, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		N:EmitSound("Hero_ElderTitan.AncestralSpirit.Damage")
	end
end
J = e(
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
				IsIndependent = true,
			}
		),
	},
	J
)
g.modifier_skywrath_mage_ult = J
g.modifier_skywrath_mage_talent_4 = c()
local P = g.modifier_skywrath_mage_talent_4
P.name = "modifier_skywrath_mage_talent_4"
d(P, l)
function P.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilityTalentValue("skywrath_mage_talent_4", "max_stack")
end
function P.prototype.OnCreated(self, K)
	if IsServer() then
		if self:GetStackCount() < self.max_stack then
			self:IncrementStackCount()
		end
	end
end
function P.prototype.OnRefresh(self, K)
	self:OnCreated(K)
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
g.modifier_skywrath_mage_talent_4 = P
g.skywrath_mage_talent_8 = c()
local Q = g.skywrath_mage_talent_8
Q.name = "skywrath_mage_talent_8"
d(Q, i)
function Q.prototype.GetIntrinsicModifierName(self)
	return "modifier_skywrath_mage_talent_8"
end
Q = e({ j(nil) }, Q)
g.skywrath_mage_talent_8 = Q
g.modifier_skywrath_mage_talent_8 = c()
local R = g.modifier_skywrath_mage_talent_8
R.name = "modifier_skywrath_mage_talent_8"
d(R, l)
function R.prototype.GetAbilitySpecialValue(self)
	self.magical_damage_per_victory = self:GetAbilitySpecialValueFor("magical_damage_per_victory")
end
function R.prototype.OnCreated(self, K)
	if IsServer() then
		self:SetStackCount(
			PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.magical_damage_per_victory
		)
	end
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE }
end
function R.prototype.EOM_GetModifierOutgoingMagicalDamagePercentage(self)
	return self:GetStackCount()
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
g.modifier_skywrath_mage_talent_8 = R
g.modifier_skywrath_mage_talent_9 = c()
local S = g.modifier_skywrath_mage_talent_9
S.name = "modifier_skywrath_mage_talent_9"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.ice_immunity_chance = self:GetAbilityTalentValue("skywrath_mage_talent_9", "ice_immunity_chance")
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE }
end
function S.prototype.EOM_GetModifierIgnoreIcePercent(self)
	return self.ice_immunity_chance
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
g.modifier_skywrath_mage_talent_9 = S
g.modifier_skywrath_mage_talent_10 = c()
local T = g.modifier_skywrath_mage_talent_10
T.name = "modifier_skywrath_mage_talent_10"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.magical_resist_reduce = self:GetAbilityTalentValue("skywrath_mage_talent_10", "magical_resist_reduce")
	self.max_stack = self:GetAbilityTalentValue("skywrath_mage_talent_10", "max_stack")
	self.duration = self:GetAbilityTalentValue("skywrath_mage_talent_10", "duration")
end
function T.prototype.OnCreated(self, K)
	if IsServer() then
		self:IncrementStackCount()
		self:StartThink(self.duration, DoUniqueString("skywrath_mage_talent_10"))
	end
end
function T.prototype.OnThink(self, U)
	self:DecrementStackCount()
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function T.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return self.magical_resist_reduce * math.min(self.max_stack, self:GetStackCount())
end
T = e(
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
	T
)
g.modifier_skywrath_mage_talent_10 = T
g.skywrath_mage_talent_11 = c()
local V = g.skywrath_mage_talent_11
V.name = "skywrath_mage_talent_11"
d(V, i)
function V.prototype.GetIntrinsicModifierName(self)
	return "modifier_skywrath_mage_talent_11"
end
V = e({ j(nil) }, V)
g.skywrath_mage_talent_11 = V
g.modifier_skywrath_mage_talent_11 = c()
local W = g.modifier_skywrath_mage_talent_11
W.name = "modifier_skywrath_mage_talent_11"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function W.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function W.prototype.OnCustomAttackLanded(self, t)
	if self.chance > 0 and self:PRD(self.chance, "OnCustomAttackLanded") then
		local X = self:GetParent():FindModifierByName("modifier_skywrath_mage_talent")
		X:ArcaneBolt()
	end
end
W = e(
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
	W
)
g.modifier_skywrath_mage_talent_11 = W
g.modifier_skywrath_mage_shard_buff = c()
local Y = g.modifier_skywrath_mage_shard_buff
Y.name = "modifier_skywrath_mage_shard_buff"
d(Y, l)
function Y.prototype.IndependentMaxCount(self)
	return self:GetAbilityTalentValue("skywrath_mage_shard", "max_stack")
end
function Y.prototype.GetAbilitySpecialValue(self)
	self.magical_armor_pct = self:GetAbilityTalentValue("skywrath_mage_shard", "magical_armor_pct")
	self.duration = self:GetAbilityTalentValue("skywrath_mage_shard", "duration")
end
function Y.prototype.OnCreated(self, K)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function Y.prototype.OnRefresh(self, K)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function Y.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function Y.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return -self.magical_armor_pct * self:GetStackCount()
end
Y = e(
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
	Y
)
g.modifier_skywrath_mage_shard_buff = Y
return g