--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		["44"] = 53,
		["45"] = 38,
		["46"] = 59,
		["47"] = 60,
		["48"] = 59,
		["49"] = 64,
		["50"] = 65,
		["51"] = 66,
		["52"] = 66,
		["53"] = 65,
		["54"] = 64,
		["55"] = 69,
		["56"] = 70,
		["57"] = 71,
		["58"] = 72,
		["59"] = 73,
		["60"] = 74,
		["61"] = 75,
		["62"] = 75,
		["63"] = 75,
		["64"] = 75,
		["65"] = 75,
		["66"] = 75,
		["69"] = 78,
		["70"] = 79,
		["71"] = 80,
		["72"] = 81,
		["73"] = 81,
		["74"] = 81,
		["75"] = 81,
		["76"] = 81,
		["77"] = 81,
		["80"] = 69,
		["81"] = 86,
		["82"] = 87,
		["83"] = 88,
		["84"] = 89,
		["85"] = 90,
		["86"] = 91,
		["87"] = 92,
		["88"] = 93,
		["89"] = 105,
		["90"] = 106,
		["91"] = 107,
		["92"] = 109,
		["93"] = 110,
		["95"] = 112,
		["96"] = 112,
		["97"] = 112,
		["98"] = 112,
		["99"] = 112,
		["100"] = 112,
		["101"] = 118,
		["102"] = 119,
		["105"] = 121,
		["106"] = 122,
		["107"] = 123,
		["109"] = 126,
		["110"] = 127,
		["111"] = 127,
		["112"] = 127,
		["113"] = 127,
		["114"] = 127,
		["115"] = 127,
		["116"] = 128,
		["117"] = 128,
		["118"] = 128,
		["119"] = 128,
		["120"] = 128,
		["121"] = 128,
		["122"] = 131,
		["123"] = 131,
		["124"] = 131,
		["125"] = 131,
		["126"] = 131,
		["127"] = 131,
		["128"] = 133,
		["129"] = 133,
		["130"] = 133,
		["131"] = 133,
		["132"] = 133,
		["133"] = 133,
		["134"] = 135,
		["135"] = 135,
		["136"] = 135,
		["137"] = 135,
		["138"] = 135,
		["139"] = 135,
		["140"] = 112,
		["141"] = 112,
		["143"] = 86,
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
		["157"] = 143,
		["158"] = 144,
		["159"] = 143,
		["160"] = 144,
		["161"] = 145,
		["162"] = 146,
		["163"] = 147,
		["164"] = 148,
		["167"] = 149,
		["168"] = 150,
		["169"] = 151,
		["170"] = 152,
		["171"] = 155,
		["172"] = 156,
		["173"] = 157,
		["175"] = 145,
		["176"] = 144,
		["177"] = 143,
		["178"] = 144,
		["180"] = 144,
		["181"] = 162,
		["182"] = 171,
		["183"] = 162,
		["184"] = 171,
		["185"] = 175,
		["186"] = 176,
		["187"] = 177,
		["188"] = 175,
		["189"] = 180,
		["190"] = 181,
		["191"] = 182,
		["192"] = 183,
		["193"] = 184,
		["195"] = 186,
		["196"] = 186,
		["197"] = 186,
		["198"] = 186,
		["199"] = 186,
		["200"] = 191,
		["201"] = 191,
		["202"] = 191,
		["203"] = 191,
		["204"] = 191,
		["205"] = 192,
		["206"] = 192,
		["207"] = 192,
		["208"] = 192,
		["209"] = 192,
		["210"] = 192,
		["211"] = 192,
		["212"] = 192,
		["213"] = 192,
		["214"] = 193,
		["215"] = 193,
		["216"] = 193,
		["217"] = 193,
		["218"] = 193,
		["219"] = 193,
		["220"] = 193,
		["221"] = 193,
		["223"] = 180,
		["224"] = 196,
		["225"] = 197,
		["228"] = 198,
		["229"] = 196,
		["230"] = 200,
		["231"] = 201,
		["232"] = 202,
		["233"] = 203,
		["234"] = 204,
		["235"] = 205,
		["236"] = 205,
		["237"] = 205,
		["238"] = 205,
		["239"] = 205,
		["240"] = 205,
		["241"] = 207,
		["243"] = 200,
		["244"] = 171,
		["245"] = 162,
		["246"] = 162,
		["247"] = 162,
		["248"] = 162,
		["249"] = 162,
		["250"] = 162,
		["251"] = 162,
		["252"] = 162,
		["253"] = 162,
		["254"] = 171,
		["256"] = 171,
		["258"] = 217,
		["259"] = 225,
		["260"] = 217,
		["261"] = 225,
		["262"] = 227,
		["263"] = 228,
		["264"] = 227,
		["265"] = 230,
		["266"] = 231,
		["267"] = 232,
		["268"] = 233,
		["271"] = 230,
		["272"] = 237,
		["273"] = 238,
		["274"] = 237,
		["275"] = 225,
		["276"] = 217,
		["277"] = 217,
		["278"] = 217,
		["279"] = 217,
		["280"] = 217,
		["281"] = 217,
		["282"] = 217,
		["283"] = 217,
		["284"] = 225,
		["286"] = 225,
		["288"] = 243,
		["289"] = 244,
		["290"] = 243,
		["291"] = 244,
		["292"] = 245,
		["293"] = 246,
		["294"] = 245,
		["295"] = 244,
		["296"] = 243,
		["297"] = 244,
		["299"] = 244,
		["300"] = 249,
		["301"] = 257,
		["302"] = 249,
		["303"] = 257,
		["304"] = 259,
		["305"] = 260,
		["306"] = 259,
		["307"] = 262,
		["308"] = 263,
		["309"] = 264,
		["311"] = 262,
		["312"] = 267,
		["313"] = 268,
		["314"] = 267,
		["315"] = 270,
		["316"] = 271,
		["317"] = 270,
		["318"] = 257,
		["319"] = 249,
		["320"] = 249,
		["321"] = 249,
		["322"] = 249,
		["323"] = 249,
		["324"] = 249,
		["325"] = 249,
		["326"] = 249,
		["327"] = 257,
		["329"] = 257,
		["331"] = 276,
		["332"] = 284,
		["333"] = 276,
		["334"] = 284,
		["335"] = 286,
		["336"] = 287,
		["337"] = 286,
		["338"] = 289,
		["339"] = 290,
		["340"] = 289,
		["341"] = 292,
		["342"] = 293,
		["343"] = 292,
		["344"] = 284,
		["345"] = 276,
		["346"] = 276,
		["347"] = 276,
		["348"] = 276,
		["349"] = 276,
		["350"] = 276,
		["351"] = 276,
		["352"] = 276,
		["353"] = 284,
		["355"] = 284,
		["357"] = 298,
		["358"] = 306,
		["359"] = 298,
		["360"] = 306,
		["361"] = 310,
		["362"] = 311,
		["363"] = 312,
		["364"] = 313,
		["365"] = 310,
		["366"] = 315,
		["367"] = 316,
		["368"] = 317,
		["369"] = 318,
		["370"] = 318,
		["371"] = 318,
		["372"] = 318,
		["374"] = 315,
		["375"] = 321,
		["376"] = 322,
		["377"] = 321,
		["378"] = 324,
		["379"] = 325,
		["380"] = 324,
		["381"] = 327,
		["382"] = 328,
		["383"] = 328,
		["384"] = 328,
		["385"] = 328,
		["386"] = 327,
		["387"] = 306,
		["388"] = 298,
		["389"] = 298,
		["390"] = 298,
		["391"] = 298,
		["392"] = 298,
		["393"] = 298,
		["394"] = 298,
		["395"] = 298,
		["396"] = 306,
		["398"] = 306,
		["400"] = 333,
		["401"] = 334,
		["402"] = 333,
		["403"] = 334,
		["404"] = 335,
		["405"] = 336,
		["406"] = 335,
		["407"] = 334,
		["408"] = 333,
		["409"] = 334,
		["411"] = 334,
		["412"] = 339,
		["413"] = 347,
		["414"] = 339,
		["415"] = 347,
		["416"] = 349,
		["417"] = 350,
		["418"] = 349,
		["419"] = 352,
		["420"] = 353,
		["421"] = 354,
		["422"] = 354,
		["423"] = 353,
		["424"] = 352,
		["425"] = 357,
		["426"] = 358,
		["427"] = 359,
		["428"] = 360,
		["430"] = 357,
		["431"] = 347,
		["432"] = 339,
		["433"] = 339,
		["434"] = 339,
		["435"] = 339,
		["436"] = 339,
		["437"] = 339,
		["438"] = 339,
		["439"] = 339,
		["440"] = 347,
		["442"] = 347,
		["444"] = 366,
		["445"] = 375,
		["446"] = 366,
		["447"] = 375,
		["448"] = 379,
		["449"] = 380,
		["450"] = 379,
		["451"] = 382,
		["452"] = 384,
		["453"] = 385,
		["454"] = 382,
		["455"] = 387,
		["456"] = 388,
		["457"] = 389,
		["459"] = 387,
		["460"] = 392,
		["461"] = 393,
		["462"] = 394,
		["464"] = 392,
		["465"] = 397,
		["466"] = 398,
		["467"] = 397,
		["468"] = 400,
		["469"] = 401,
		["470"] = 400,
		["471"] = 375,
		["472"] = 366,
		["473"] = 366,
		["474"] = 366,
		["475"] = 366,
		["476"] = 366,
		["477"] = 366,
		["478"] = 366,
		["479"] = 366,
		["480"] = 366,
		["481"] = 375,
		["483"] = 375,
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
	self.g_chance = self:GetAbilitySpecialValueFor("g_chance")
	self.g_slience = self:GetAbilitySpecialValueFor("g_slience")
	self.damage_record = 0
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE] = self.ice_immune_pct }
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomTakeDamage(self, s)
	if s.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		if not self:GetCaster():PassivesDisabled() and self:PRD(self.chance, "chance") then
			self:ArcaneBolt()
			if self:PRD(self.g_chance, "g_chance") then
				self:ArcaneBolt()
				AddSilence(self.parent, self.parent:GetEnemy(), self:GetAbility(), self.g_slience)
			end
		end
		self.damage_record = self.damage_record + s.damage
		if self.regen > 0 and self.damage_record >= self.threshold then
			self.damage_record = 0
			Heal(self:GetParent(), self.regen, "skywrath_mage_talent_1", "Ability")
		end
	end
end
function r.prototype.ArcaneBolt(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	local v = self.base_damage
	local w = self.regen_pct
	local x = self:GetAbilityTalentValue("skywrath_mage_talent_4", "damage_stack")
	local y = self:GetAbilityTalentValue("skywrath_mage_talent_12", "chance")
	local z = self:GetAbilityTalentValue("skywrath_mage_talent_12", "shield")
	if IsInjurable(u) then
		t:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2)
		t:EmitSound("Hero_SkywrathMage.ArcaneBolt.Cast")
		if self:PRD(y, "ArcaneBolt") then
			AddShield(t, z, "skywrath_mage_talent_12", "Ability")
		end
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf",
			hCaster = t,
			vSpawnOrigin = t:GetAttachmentPosition("attach_attack1"),
			hTarget = u,
			iMoveSpeed = 1000,
			OnProjectileHit = function(A, B, C)
				if not IsValid(self) then
					return
				end
				local D = v
				if A:HasModifier("modifier_skywrath_mage_talent_4") then
					D = D + A:GetModifierStackCount("modifier_skywrath_mage_talent_4", t) * x
				end
				u:EmitSound("Hero_SkywrathMage.ArcaneBolt.Impact")
				t:DealDamage(u, self:GetAbility(), D, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
				Heal(t, math.floor(D * w * 0.01), self:GetAbility():GetName(), "Ability")
				A:AddNewModifier(t, self:GetAbility(), "modifier_skywrath_mage_talent_4", {})
				A:AddNewModifier(t, self:GetAbility(), "modifier_skywrath_mage_talent_10", {})
				t:AddNewModifier(
					t,
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
local E = g.skywrath_mage_ult
E.name = "skywrath_mage_ult"
d(E, o)
function E.prototype.OnSpellStart(self)
	local F = self:GetCaster()
	local u = F:GetEnemy()
	if not IsInjurable(u, F) then
		return
	end
	F:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local G = self:GetSpecialValueFor("duration") + self:GetTalentValue("skywrath_mage_talent_3", "duration")
	u:AddNewModifier(F, self, "modifier_skywrath_mage_ult", { duration = G })
	F:EmitSound("Hero_SkywrathMage.MysticFlare.Cast")
	local H = self:GetTalentValue("skywrath_mage_talent_9", "duration")
	if H > 0 then
		F:AddNewModifier(F, self, "modifier_skywrath_mage_talent_9", { duration = H })
	end
end
E = e({ p(nil) }, E)
g.skywrath_mage_ult = E
g.modifier_skywrath_mage_ult = c()
local I = g.modifier_skywrath_mage_ult
I.name = "modifier_skywrath_mage_ult"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("skywrath_mage_talent_6", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("skywrath_mage_talent_7", "damage_bonus")
end
function I.prototype.OnCreated(self, J)
	local K = self:GetParent()
	if IsServer() then
		self:StartIntervalThink(self.interval)
		self:IncrementStackCount()
	else
		local L = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(L, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(L, 1, Vector(200, self:GetDuration(), self.interval))
		self:AddParticle(L, false, false, -1, false, false)
	end
end
function I.prototype.OnRefresh(self, J)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end
function I.prototype.OnIntervalThink(self)
	local M = self:GetParent()
	local F = self:GetCaster()
	if IsValid(M) then
		local N = self:GetStackCount()
		F:DealDamage(M, self:GetAbility(), self.damage * N, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		M:EmitSound("Hero_ElderTitan.AncestralSpirit.Damage")
	end
end
I = e(
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
	I
)
g.modifier_skywrath_mage_ult = I
g.modifier_skywrath_mage_talent_4 = c()
local O = g.modifier_skywrath_mage_talent_4
O.name = "modifier_skywrath_mage_talent_4"
d(O, l)
function O.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilityTalentValue("skywrath_mage_talent_4", "max_stack")
end
function O.prototype.OnCreated(self, J)
	if IsServer() then
		if self:GetStackCount() < self.max_stack then
			self:IncrementStackCount()
		end
	end
end
function O.prototype.OnRefresh(self, J)
	self:OnCreated(J)
end
O = e(
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
	O
)
g.modifier_skywrath_mage_talent_4 = O
g.skywrath_mage_talent_8 = c()
local P = g.skywrath_mage_talent_8
P.name = "skywrath_mage_talent_8"
d(P, i)
function P.prototype.GetIntrinsicModifierName(self)
	return "modifier_skywrath_mage_talent_8"
end
P = e({ j(nil) }, P)
g.skywrath_mage_talent_8 = P
g.modifier_skywrath_mage_talent_8 = c()
local Q = g.modifier_skywrath_mage_talent_8
Q.name = "modifier_skywrath_mage_talent_8"
d(Q, l)
function Q.prototype.GetAbilitySpecialValue(self)
	self.magical_damage_per_victory = self:GetAbilitySpecialValueFor("magical_damage_per_victory")
end
function Q.prototype.OnCreated(self, J)
	if IsServer() then
		self:SetStackCount(
			PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.magical_damage_per_victory
		)
	end
end
function Q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_MAGICAL_DAMAGE_PERCENTAGE }
end
function Q.prototype.EOM_GetModifierOutgoingMagicalDamagePercentage(self)
	return self:GetStackCount()
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
g.modifier_skywrath_mage_talent_8 = Q
g.modifier_skywrath_mage_talent_9 = c()
local R = g.modifier_skywrath_mage_talent_9
R.name = "modifier_skywrath_mage_talent_9"
d(R, l)
function R.prototype.GetAbilitySpecialValue(self)
	self.ice_immunity_chance = self:GetAbilityTalentValue("skywrath_mage_talent_9", "ice_immunity_chance")
end
function R.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_ICE_PERCENTAGE }
end
function R.prototype.EOM_GetModifierIgnoreIcePercent(self)
	return self.ice_immunity_chance
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
g.modifier_skywrath_mage_talent_9 = R
g.modifier_skywrath_mage_talent_10 = c()
local S = g.modifier_skywrath_mage_talent_10
S.name = "modifier_skywrath_mage_talent_10"
d(S, l)
function S.prototype.GetAbilitySpecialValue(self)
	self.magical_resist_reduce = self:GetAbilityTalentValue("skywrath_mage_talent_10", "magical_resist_reduce")
	self.max_stack = self:GetAbilityTalentValue("skywrath_mage_talent_10", "max_stack")
	self.duration = self:GetAbilityTalentValue("skywrath_mage_talent_10", "duration")
end
function S.prototype.OnCreated(self, J)
	if IsServer() then
		self:IncrementStackCount()
		self:StartThink(self.duration, DoUniqueString("skywrath_mage_talent_10"))
	end
end
function S.prototype.OnThink(self, T)
	self:DecrementStackCount()
end
function S.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function S.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return self.magical_resist_reduce * math.min(self.max_stack, self:GetStackCount())
end
S = e(
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
	S
)
g.modifier_skywrath_mage_talent_10 = S
g.skywrath_mage_talent_11 = c()
local U = g.skywrath_mage_talent_11
U.name = "skywrath_mage_talent_11"
d(U, i)
function U.prototype.GetIntrinsicModifierName(self)
	return "modifier_skywrath_mage_talent_11"
end
U = e({ j(nil) }, U)
g.skywrath_mage_talent_11 = U
g.modifier_skywrath_mage_talent_11 = c()
local V = g.modifier_skywrath_mage_talent_11
V.name = "modifier_skywrath_mage_talent_11"
d(V, l)
function V.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function V.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function V.prototype.OnCustomAttackLanded(self, s)
	if self.chance > 0 and self:PRD(self.chance, "OnCustomAttackLanded") then
		local W = self:GetParent():FindModifierByName("modifier_skywrath_mage_talent")
		W:ArcaneBolt()
	end
end
V = e(
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
	V
)
g.modifier_skywrath_mage_talent_11 = V
g.modifier_skywrath_mage_shard_buff = c()
local X = g.modifier_skywrath_mage_shard_buff
X.name = "modifier_skywrath_mage_shard_buff"
d(X, l)
function X.prototype.IndependentMaxCount(self)
	return self:GetAbilityTalentValue("skywrath_mage_shard", "max_stack")
end
function X.prototype.GetAbilitySpecialValue(self)
	self.magical_armor_pct = self:GetAbilityTalentValue("skywrath_mage_shard", "magical_armor_pct")
	self.duration = self:GetAbilityTalentValue("skywrath_mage_shard", "duration")
end
function X.prototype.OnCreated(self, J)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function X.prototype.OnRefresh(self, J)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE }
end
function X.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self)
	return -self.magical_armor_pct * self:GetStackCount()
end
X = e(
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
	X
)
g.modifier_skywrath_mage_shard_buff = X
return g