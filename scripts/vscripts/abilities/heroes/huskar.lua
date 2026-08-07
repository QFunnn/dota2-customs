--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/huskar"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Delete
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
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["40"] = 39,
		["41"] = 41,
		["42"] = 42,
		["43"] = 44,
		["44"] = 46,
		["45"] = 34,
		["46"] = 48,
		["47"] = 49,
		["48"] = 49,
		["49"] = 51,
		["50"] = 51,
		["51"] = 51,
		["52"] = 49,
		["53"] = 49,
		["54"] = 48,
		["55"] = 54,
		["56"] = 55,
		["57"] = 54,
		["58"] = 57,
		["59"] = 58,
		["60"] = 57,
		["61"] = 60,
		["62"] = 65,
		["63"] = 66,
		["64"] = 67,
		["65"] = 68,
		["66"] = 69,
		["67"] = 70,
		["68"] = 71,
		["69"] = 72,
		["70"] = 73,
		["71"] = 75,
		["75"] = 79,
		["76"] = 80,
		["77"] = 80,
		["78"] = 80,
		["79"] = 80,
		["80"] = 80,
		["81"] = 80,
		["82"] = 60,
		["83"] = 82,
		["84"] = 83,
		["85"] = 82,
		["86"] = 90,
		["87"] = 92,
		["88"] = 90,
		["89"] = 94,
		["90"] = 95,
		["91"] = 94,
		["92"] = 97,
		["93"] = 98,
		["94"] = 97,
		["95"] = 100,
		["96"] = 101,
		["97"] = 100,
		["98"] = 23,
		["99"] = 15,
		["100"] = 15,
		["101"] = 15,
		["102"] = 15,
		["103"] = 15,
		["104"] = 15,
		["105"] = 15,
		["106"] = 15,
		["107"] = 23,
		["109"] = 23,
		["111"] = 108,
		["112"] = 109,
		["113"] = 108,
		["114"] = 109,
		["115"] = 110,
		["116"] = 111,
		["117"] = 113,
		["118"] = 114,
		["119"] = 110,
		["120"] = 116,
		["121"] = 117,
		["122"] = 118,
		["123"] = 119,
		["124"] = 119,
		["125"] = 119,
		["126"] = 119,
		["127"] = 119,
		["128"] = 119,
		["129"] = 125,
		["130"] = 126,
		["131"] = 127,
		["133"] = 119,
		["134"] = 119,
		["135"] = 131,
		["136"] = 116,
		["137"] = 133,
		["138"] = 134,
		["139"] = 135,
		["140"] = 136,
		["141"] = 137,
		["142"] = 138,
		["143"] = 139,
		["145"] = 133,
		["146"] = 142,
		["147"] = 143,
		["148"] = 142,
		["149"] = 109,
		["150"] = 108,
		["151"] = 109,
		["153"] = 109,
		["154"] = 147,
		["155"] = 155,
		["156"] = 147,
		["157"] = 155,
		["158"] = 161,
		["159"] = 162,
		["160"] = 163,
		["161"] = 161,
		["162"] = 165,
		["163"] = 166,
		["164"] = 167,
		["165"] = 167,
		["166"] = 167,
		["167"] = 166,
		["168"] = 168,
		["169"] = 168,
		["170"] = 168,
		["171"] = 166,
		["172"] = 166,
		["173"] = 165,
		["174"] = 171,
		["175"] = 172,
		["176"] = 171,
		["177"] = 176,
		["178"] = 177,
		["179"] = 178,
		["180"] = 178,
		["181"] = 178,
		["182"] = 178,
		["183"] = 179,
		["184"] = 180,
		["185"] = 181,
		["186"] = 182,
		["187"] = 183,
		["188"] = 184,
		["191"] = 176,
		["192"] = 188,
		["193"] = 189,
		["196"] = 192,
		["197"] = 193,
		["198"] = 194,
		["199"] = 195,
		["200"] = 196,
		["203"] = 188,
		["204"] = 155,
		["205"] = 147,
		["206"] = 147,
		["207"] = 147,
		["208"] = 147,
		["209"] = 147,
		["210"] = 147,
		["211"] = 147,
		["212"] = 147,
		["213"] = 155,
		["215"] = 155,
		["216"] = 201,
		["217"] = 209,
		["218"] = 201,
		["219"] = 209,
		["220"] = 210,
		["221"] = 211,
		["222"] = 212,
		["223"] = 212,
		["224"] = 211,
		["225"] = 210,
		["226"] = 215,
		["227"] = 216,
		["228"] = 215,
		["229"] = 220,
		["230"] = 221,
		["231"] = 220,
		["232"] = 223,
		["233"] = 224,
		["234"] = 223,
		["235"] = 209,
		["236"] = 201,
		["237"] = 201,
		["238"] = 201,
		["239"] = 201,
		["240"] = 201,
		["241"] = 201,
		["242"] = 201,
		["243"] = 201,
		["244"] = 209,
		["246"] = 209,
		["247"] = 228,
		["248"] = 237,
		["249"] = 228,
		["250"] = 237,
		["252"] = 237,
		["253"] = 239,
		["254"] = 228,
		["255"] = 244,
		["256"] = 245,
		["257"] = 246,
		["258"] = 247,
		["259"] = 248,
		["260"] = 249,
		["261"] = 244,
		["262"] = 251,
		["263"] = 252,
		["264"] = 253,
		["265"] = 254,
		["266"] = 255,
		["267"] = 256,
		["268"] = 257,
		["269"] = 258,
		["270"] = 259,
		["271"] = 260,
		["274"] = 263,
		["275"] = 263,
		["276"] = 263,
		["277"] = 263,
		["278"] = 263,
		["279"] = 263,
		["281"] = 251,
		["282"] = 266,
		["283"] = 267,
		["284"] = 268,
		["285"] = 269,
		["286"] = 270,
		["287"] = 271,
		["288"] = 272,
		["289"] = 273,
		["290"] = 274,
		["293"] = 266,
		["294"] = 278,
		["295"] = 279,
		["296"] = 280,
		["297"] = 281,
		["298"] = 282,
		["299"] = 283,
		["300"] = 284,
		["302"] = 287,
		["303"] = 287,
		["304"] = 287,
		["305"] = 287,
		["306"] = 287,
		["307"] = 287,
		["308"] = 278,
		["309"] = 289,
		["310"] = 290,
		["311"] = 291,
		["312"] = 292,
		["313"] = 292,
		["314"] = 292,
		["315"] = 292,
		["317"] = 289,
		["318"] = 237,
		["319"] = 228,
		["320"] = 228,
		["321"] = 228,
		["322"] = 228,
		["323"] = 228,
		["324"] = 228,
		["325"] = 228,
		["326"] = 228,
		["327"] = 237,
		["329"] = 237,
		["330"] = 296,
		["331"] = 306,
		["332"] = 296,
		["333"] = 306,
		["334"] = 307,
		["335"] = 308,
		["336"] = 309,
		["337"] = 310,
		["338"] = 311,
		["341"] = 307,
		["342"] = 306,
		["343"] = 296,
		["344"] = 296,
		["345"] = 296,
		["346"] = 296,
		["347"] = 296,
		["348"] = 296,
		["349"] = 296,
		["350"] = 296,
		["351"] = 296,
		["352"] = 306,
		["354"] = 306,
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
h.huskar_talent = c()
local r = h.huskar_talent
r.name = "huskar_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_huskar_talent"
end
r = e({ k(nil) }, r)
h.huskar_talent = r
h.modifier_huskar_talent = c()
local s = h.modifier_huskar_talent
s.name = "modifier_huskar_talent"
d(s, m)
function s.prototype.GetAbilitySpecialValue(self)
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.fury = self:GetAbilitySpecialValueFor("fury")
	self.fury_trigger = self:GetAbilitySpecialValueFor("fury_trigger")
	self.fury_stack_trigger = self:GetAbilitySpecialValueFor("fury_stack_trigger")
	self.fury_stack = self:GetAbilitySpecialValueFor("fury_stack")
		+ self:GetAbilityTalentValue("huskar_talent_2", "fury_count")
	self.reduce = self:GetAbilityTalentValue("huskar_talent_3", "reduce")
	self.bonus_threshold = self:GetAbilityTalentValue("huskar_talent_4", "bonus_threshold")
	self.s_attackspeed = self:GetAbilityTalentValue("huskar_shard", "attackspeed")
	self.tl7_fury_count = self:GetAbilityTalentValue("huskar_talent_7", "fury_count")
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function s.prototype.OnBattleStart(self, t)
	self:StartIntervalThink(0.1)
end
function s.prototype.OnBattleEnd(self, t)
	self:StartIntervalThink(-1)
end
function s.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	local v = 100 - u:GetHealthPercent()
	local w = math.floor(v / (self.threshold - self.bonus_threshold))
	if self.tl7_fury_count > 0 then
		local x = w - self:GetStackCount()
		if x > 0 then
			local y = self.parent:GetEnemy()
			if IsInjurable(y, u) then
				local z = x * self.tl7_fury_count
				AddFury(u, z, "huskar_talent_7", "Ability")
			end
		end
	end
	self:SetStackCount(w)
	u:AddNewModifier(u, self:GetAbility(), "modifier_fury_custom", { iStackCount = 0 })
end
function s.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
	}
end
function s.prototype.EOM_GetModifierFuryPermanent(self)
	return math.floor(self:GetStackCount() / self.fury_trigger) * self.fury
end
function s.prototype.EOM_GetModifierFuryStackBonus(self)
	return math.floor(self:GetStackCount() / self.fury_stack_trigger) * self.fury_stack
end
function s.prototype.EOM_GetModifierIncomingDamagePercentage(self)
	return -self:GetStackCount() * self.reduce
end
function s.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return self:GetStackCount() * self.s_attackspeed
end
s = e(
	{
		n(
			a,
			{
				IsHidden = false,
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
h.modifier_huskar_talent = s
h.huskar_ult = c()
local A = h.huskar_ult
A.name = "huskar_ult"
d(A, p)
function A.prototype.OnSpellStart(self)
	local B = self:GetCaster()
	local C = self:GetSpecialValueFor("buff_duration")
	B:AddNewModifier(B, self, "modifier_huskar_ult_buff", { duration = C })
end
function A.prototype.fire(self)
	local B = self:GetCaster()
	local D = B:GetEnemy()
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf",
		hCaster = B,
		vSpawnOrigin = B:GetAttachmentPosition("attach_attack1"),
		hTarget = D,
		iMoveSpeed = 1400,
		OnProjectileHit = function(E, F, G)
			if IsInjurable(D) then
				self:BurningSpear()
			end
		end,
	})
	B:EmitSound("Hero_Huskar.Burning_Spear.Cast")
end
function A.prototype.BurningSpear(self)
	local B = self:GetCaster()
	local D = B:GetEnemy()
	local H = self:GetSpecialValueFor("duration")
	if IsInjurable(B, D) then
		D:AddNewModifier(B, self, "modifier_huskar_ult_debuff_counter", { duration = H })
		B:EmitSound("Hero_BrewMaster.CinderBrew.Ignite")
	end
end
function A.prototype.GetIntrinsicModifierName(self)
	return "modifier_huskar_ult"
end
A = e({ q(nil) }, A)
h.huskar_ult = A
h.modifier_huskar_ult = c()
local I = h.modifier_huskar_ult
I.name = "modifier_huskar_ult"
d(I, m)
function I.prototype.GetAbilitySpecialValue(self)
	self.talent_5_fury = self:GetAbilityTalentValue("huskar_talent_5", "fury")
	self.health = self:GetAbilityTalentValue("huskar_talent_6", "health")
end
function I.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME }
end
function I.prototype.OnCustomTakeDamage(self, J)
	local u = self:GetParent()
	local K = math.max(0, J.original_health - u:GetHealth())
	if self.health > 0 then
		self.damageRecord = (self.damageRecord or 0) + K
		local L = self.health * u:GetMaxHealth() * 0.01
		if self.damageRecord >= L then
			self.damageRecord = self.damageRecord - L
			self:GetAbility():fire()
		end
	end
end
function I.prototype.OnFuryGained(self, t)
	if not IsServer() then
		return
	end
	if self.talent_5_fury > 0 then
		self.record = (self.record or 0) + (t.iStackCount or 0)
		if self.record >= self.talent_5_fury then
			self.record = self.record - self.talent_5_fury
			self:GetAbility():fire()
		end
	end
end
I = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	I
)
h.modifier_huskar_ult = I
h.modifier_huskar_ult_buff = c()
local M = h.modifier_huskar_ult_buff
M.name = "modifier_huskar_ult_buff"
d(M, m)
function M.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function M.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME }
end
function M.prototype.EOM_GetModifierProjectileName(self)
	return "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf"
end
function M.prototype.OnCustomAttackLanded(self, J)
	self:GetAbility():BurningSpear()
end
M = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
			}
		),
	},
	M
)
h.modifier_huskar_ult_buff = M
h.modifier_huskar_ult_debuff_counter = c()
local N = h.modifier_huskar_ult_debuff_counter
N.name = "modifier_huskar_ult_debuff_counter"
d(N, m)
function N.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = {}
end
function N.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.base_damage = self:GetAbilitySpecialValueFor("base_damage")
	self.fury_pct = self:GetAbilitySpecialValueFor("fury_pct")
	self.health = self:GetAbilityTalentValue("huskar_talent_1", "health")
end
function N.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		local u = self:GetParent()
		local B = self:GetCaster()
		local O = self:GetAbility()
		local P = u:AddNewModifier(B, O, "modifier_huskar_ult_debuff", { duration = self.duration })
		if IsValid(P) then
			self.record[tostring(P)] = GetFury(B)
			self:IncrementStackCount()
		end
	else
		ParticleManager:CreateParticle(
			"particles/econ/items/huskar/huskar_2021_immortal/huskar_2021_immortal_burning_spear_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent(),
			self:GetCaster()
		)
	end
end
function N.prototype.OnRefresh(self, t)
	if IsServer() then
		local u = self:GetParent()
		local B = self:GetCaster()
		local O = self:GetAbility()
		local P = u:AddNewModifier(B, O, "modifier_huskar_ult_debuff", { duration = self.duration })
		if IsValid(P) then
			self.record[tostring(P)] = GetFury(B)
			self:IncrementStackCount()
		end
	end
end
function N.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	local B = self:GetCaster()
	local K = 0
	local Q = self.health * B:GetMaxHealth() * 0.01
	for R, z in pairs(self.record) do
		K = K + self.base_damage + z * self.fury_pct * 0.01 + Q
	end
	B:DealDamage(u, self:GetAbility(), K, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function N.prototype.OnSingleDebuffRemove(self, S)
	if IsValid(S) then
		self:DecrementStackCount()
		f(self.record, tostring(S))
	end
end
N = e(
	{
		n(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	N
)
h.modifier_huskar_ult_debuff_counter = N
h.modifier_huskar_ult_debuff = c()
local T = h.modifier_huskar_ult_debuff
T.name = "modifier_huskar_ult_debuff"
d(T, m)
function T.prototype.OnRemoved(self, U)
	if IsServer() then
		local V = self:GetParent():FindModifierByName("modifier_huskar_ult_debuff_counter")
		if IsValid(V) then
			V:OnSingleDebuffRemove(self)
		end
	end
end
T = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	T
)
h.modifier_huskar_ult_debuff = T
return h