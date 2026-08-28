--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		["135"] = 113,
		["136"] = 113,
		["138"] = 87,
		["139"] = 21,
		["140"] = 13,
		["141"] = 13,
		["142"] = 13,
		["143"] = 13,
		["144"] = 13,
		["145"] = 13,
		["146"] = 13,
		["147"] = 13,
		["148"] = 21,
		["150"] = 21,
		["152"] = 144,
		["153"] = 145,
		["154"] = 144,
		["155"] = 145,
		["156"] = 146,
		["157"] = 147,
		["158"] = 148,
		["159"] = 149,
		["162"] = 150,
		["163"] = 151,
		["164"] = 152,
		["165"] = 153,
		["166"] = 156,
		["167"] = 157,
		["168"] = 158,
		["170"] = 146,
		["171"] = 145,
		["172"] = 144,
		["173"] = 145,
		["175"] = 145,
		["176"] = 163,
		["177"] = 172,
		["178"] = 163,
		["179"] = 172,
		["180"] = 176,
		["181"] = 177,
		["182"] = 178,
		["183"] = 176,
		["184"] = 181,
		["185"] = 182,
		["186"] = 183,
		["187"] = 184,
		["188"] = 185,
		["190"] = 187,
		["191"] = 187,
		["192"] = 187,
		["193"] = 187,
		["194"] = 187,
		["195"] = 192,
		["196"] = 192,
		["197"] = 192,
		["198"] = 192,
		["199"] = 192,
		["200"] = 193,
		["201"] = 193,
		["202"] = 193,
		["203"] = 193,
		["204"] = 193,
		["205"] = 193,
		["206"] = 193,
		["207"] = 193,
		["208"] = 193,
		["209"] = 194,
		["210"] = 194,
		["211"] = 194,
		["212"] = 194,
		["213"] = 194,
		["214"] = 194,
		["215"] = 194,
		["216"] = 194,
		["218"] = 181,
		["219"] = 197,
		["220"] = 198,
		["223"] = 199,
		["224"] = 197,
		["225"] = 201,
		["226"] = 202,
		["227"] = 203,
		["228"] = 204,
		["229"] = 205,
		["230"] = 206,
		["231"] = 206,
		["232"] = 206,
		["233"] = 206,
		["234"] = 206,
		["235"] = 206,
		["236"] = 208,
		["238"] = 201,
		["239"] = 172,
		["240"] = 163,
		["241"] = 163,
		["242"] = 163,
		["243"] = 163,
		["244"] = 163,
		["245"] = 163,
		["246"] = 163,
		["247"] = 163,
		["248"] = 163,
		["249"] = 172,
		["251"] = 172,
		["253"] = 218,
		["254"] = 226,
		["255"] = 218,
		["256"] = 226,
		["257"] = 228,
		["258"] = 229,
		["259"] = 228,
		["260"] = 231,
		["261"] = 232,
		["262"] = 233,
		["263"] = 234,
		["266"] = 231,
		["267"] = 238,
		["268"] = 239,
		["269"] = 238,
		["270"] = 226,
		["271"] = 218,
		["272"] = 218,
		["273"] = 218,
		["274"] = 218,
		["275"] = 218,
		["276"] = 218,
		["277"] = 218,
		["278"] = 218,
		["279"] = 226,
		["281"] = 226,
		["283"] = 244,
		["284"] = 245,
		["285"] = 244,
		["286"] = 245,
		["287"] = 246,
		["288"] = 247,
		["289"] = 246,
		["290"] = 245,
		["291"] = 244,
		["292"] = 245,
		["294"] = 245,
		["295"] = 250,
		["296"] = 258,
		["297"] = 250,
		["298"] = 258,
		["299"] = 260,
		["300"] = 261,
		["301"] = 260,
		["302"] = 263,
		["303"] = 264,
		["304"] = 265,
		["306"] = 263,
		["307"] = 268,
		["308"] = 269,
		["309"] = 268,
		["310"] = 271,
		["311"] = 272,
		["312"] = 271,
		["313"] = 258,
		["314"] = 250,
		["315"] = 250,
		["316"] = 250,
		["317"] = 250,
		["318"] = 250,
		["319"] = 250,
		["320"] = 250,
		["321"] = 250,
		["322"] = 258,
		["324"] = 258,
		["326"] = 277,
		["327"] = 285,
		["328"] = 277,
		["329"] = 285,
		["330"] = 287,
		["331"] = 288,
		["332"] = 287,
		["333"] = 290,
		["334"] = 291,
		["335"] = 290,
		["336"] = 293,
		["337"] = 294,
		["338"] = 293,
		["339"] = 285,
		["340"] = 277,
		["341"] = 277,
		["342"] = 277,
		["343"] = 277,
		["344"] = 277,
		["345"] = 277,
		["346"] = 277,
		["347"] = 277,
		["348"] = 285,
		["350"] = 285,
		["352"] = 299,
		["353"] = 307,
		["354"] = 299,
		["355"] = 307,
		["356"] = 311,
		["357"] = 312,
		["358"] = 313,
		["359"] = 314,
		["360"] = 311,
		["361"] = 316,
		["362"] = 317,
		["363"] = 318,
		["364"] = 319,
		["365"] = 319,
		["366"] = 319,
		["367"] = 319,
		["369"] = 316,
		["370"] = 322,
		["371"] = 323,
		["372"] = 322,
		["373"] = 325,
		["374"] = 326,
		["375"] = 325,
		["376"] = 328,
		["377"] = 329,
		["378"] = 329,
		["379"] = 329,
		["380"] = 329,
		["381"] = 328,
		["382"] = 307,
		["383"] = 299,
		["384"] = 299,
		["385"] = 299,
		["386"] = 299,
		["387"] = 299,
		["388"] = 299,
		["389"] = 299,
		["390"] = 299,
		["391"] = 307,
		["393"] = 307,
		["395"] = 334,
		["396"] = 335,
		["397"] = 334,
		["398"] = 335,
		["399"] = 336,
		["400"] = 337,
		["401"] = 336,
		["402"] = 335,
		["403"] = 334,
		["404"] = 335,
		["406"] = 335,
		["407"] = 340,
		["408"] = 348,
		["409"] = 340,
		["410"] = 348,
		["411"] = 350,
		["412"] = 351,
		["413"] = 350,
		["414"] = 353,
		["415"] = 354,
		["416"] = 355,
		["417"] = 355,
		["418"] = 354,
		["419"] = 353,
		["420"] = 358,
		["421"] = 359,
		["422"] = 360,
		["423"] = 361,
		["425"] = 358,
		["426"] = 348,
		["427"] = 340,
		["428"] = 340,
		["429"] = 340,
		["430"] = 340,
		["431"] = 340,
		["432"] = 340,
		["433"] = 340,
		["434"] = 340,
		["435"] = 348,
		["437"] = 348,
		["439"] = 367,
		["440"] = 376,
		["441"] = 367,
		["442"] = 376,
		["443"] = 380,
		["444"] = 381,
		["445"] = 380,
		["446"] = 383,
		["447"] = 385,
		["448"] = 386,
		["449"] = 383,
		["450"] = 388,
		["451"] = 389,
		["452"] = 390,
		["454"] = 388,
		["455"] = 393,
		["456"] = 394,
		["457"] = 395,
		["459"] = 393,
		["460"] = 398,
		["461"] = 399,
		["462"] = 398,
		["463"] = 401,
		["464"] = 402,
		["465"] = 401,
		["466"] = 376,
		["467"] = 367,
		["468"] = 367,
		["469"] = 367,
		["470"] = 367,
		["471"] = 367,
		["472"] = 367,
		["473"] = 367,
		["474"] = 367,
		["475"] = 367,
		["476"] = 376,
		["478"] = 376,
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
	self.g_chance = self:GetAbilityTalentValue("skywrath_mage_shard", "chance")
	self.g_slience = self:GetAbilityTalentValue("skywrath_mage_shard", "slience")
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