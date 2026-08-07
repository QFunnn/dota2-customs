--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/dazzle"
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
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 10,
		["25"] = 9,
		["26"] = 8,
		["27"] = 9,
		["29"] = 9,
		["30"] = 15,
		["31"] = 23,
		["32"] = 15,
		["33"] = 23,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 35,
		["38"] = 36,
		["39"] = 31,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 40,
		["44"] = 40,
		["45"] = 39,
		["46"] = 41,
		["47"] = 41,
		["48"] = 41,
		["49"] = 39,
		["50"] = 39,
		["51"] = 38,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["57"] = 48,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 48,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 49,
		["67"] = 49,
		["68"] = 49,
		["69"] = 49,
		["70"] = 50,
		["71"] = 51,
		["72"] = 51,
		["73"] = 51,
		["74"] = 51,
		["75"] = 51,
		["76"] = 51,
		["79"] = 44,
		["80"] = 55,
		["81"] = 56,
		["84"] = 59,
		["85"] = 60,
		["86"] = 61,
		["87"] = 62,
		["88"] = 63,
		["91"] = 55,
		["92"] = 67,
		["93"] = 68,
		["96"] = 71,
		["97"] = 72,
		["98"] = 73,
		["99"] = 74,
		["101"] = 76,
		["102"] = 77,
		["103"] = 78,
		["105"] = 80,
		["106"] = 81,
		["107"] = 82,
		["110"] = 67,
		["111"] = 23,
		["112"] = 15,
		["113"] = 15,
		["114"] = 15,
		["115"] = 15,
		["116"] = 15,
		["117"] = 15,
		["118"] = 15,
		["119"] = 15,
		["120"] = 23,
		["122"] = 23,
		["123"] = 87,
		["124"] = 96,
		["125"] = 87,
		["126"] = 96,
		["127"] = 99,
		["128"] = 100,
		["129"] = 101,
		["130"] = 99,
		["131"] = 103,
		["132"] = 104,
		["133"] = 105,
		["135"] = 103,
		["136"] = 108,
		["137"] = 109,
		["138"] = 110,
		["139"] = 110,
		["140"] = 110,
		["141"] = 110,
		["143"] = 108,
		["144"] = 113,
		["145"] = 114,
		["146"] = 113,
		["147"] = 119,
		["148"] = 120,
		["149"] = 119,
		["150"] = 122,
		["151"] = 123,
		["152"] = 122,
		["153"] = 96,
		["154"] = 87,
		["155"] = 87,
		["156"] = 87,
		["157"] = 87,
		["158"] = 87,
		["159"] = 87,
		["160"] = 87,
		["161"] = 87,
		["162"] = 87,
		["163"] = 96,
		["165"] = 96,
		["167"] = 130,
		["168"] = 131,
		["169"] = 130,
		["170"] = 131,
		["171"] = 132,
		["172"] = 133,
		["173"] = 134,
		["174"] = 135,
		["175"] = 136,
		["176"] = 137,
		["177"] = 138,
		["178"] = 139,
		["179"] = 139,
		["180"] = 139,
		["181"] = 139,
		["182"] = 139,
		["183"] = 139,
		["184"] = 145,
		["185"] = 146,
		["186"] = 147,
		["187"] = 148,
		["188"] = 148,
		["189"] = 148,
		["190"] = 148,
		["191"] = 148,
		["192"] = 148,
		["193"] = 148,
		["194"] = 149,
		["195"] = 149,
		["196"] = 149,
		["197"] = 149,
		["198"] = 149,
		["199"] = 149,
		["200"] = 149,
		["201"] = 150,
		["203"] = 139,
		["204"] = 139,
		["205"] = 154,
		["206"] = 132,
		["207"] = 131,
		["208"] = 130,
		["209"] = 131,
		["211"] = 131,
		["212"] = 158,
		["213"] = 167,
		["214"] = 158,
		["215"] = 167,
		["216"] = 170,
		["217"] = 171,
		["218"] = 172,
		["219"] = 170,
		["220"] = 174,
		["221"] = 175,
		["222"] = 176,
		["224"] = 174,
		["225"] = 179,
		["226"] = 180,
		["227"] = 181,
		["228"] = 182,
		["229"] = 182,
		["230"] = 182,
		["231"] = 182,
		["232"] = 182,
		["233"] = 182,
		["234"] = 179,
		["235"] = 167,
		["236"] = 158,
		["237"] = 158,
		["238"] = 158,
		["239"] = 158,
		["240"] = 158,
		["241"] = 158,
		["242"] = 158,
		["243"] = 158,
		["244"] = 158,
		["245"] = 167,
		["247"] = 167,
		["248"] = 188,
		["249"] = 189,
		["250"] = 188,
		["251"] = 189,
		["252"] = 190,
		["253"] = 191,
		["254"] = 190,
		["255"] = 189,
		["256"] = 188,
		["257"] = 189,
		["259"] = 189,
		["260"] = 195,
		["261"] = 203,
		["262"] = 195,
		["263"] = 203,
		["265"] = 203,
		["266"] = 205,
		["267"] = 195,
		["268"] = 206,
		["269"] = 207,
		["270"] = 206,
		["271"] = 209,
		["272"] = 210,
		["273"] = 209,
		["274"] = 214,
		["275"] = 215,
		["278"] = 217,
		["279"] = 218,
		["281"] = 220,
		["282"] = 221,
		["283"] = 222,
		["284"] = 223,
		["285"] = 224,
		["286"] = 224,
		["287"] = 224,
		["288"] = 224,
		["289"] = 224,
		["290"] = 224,
		["291"] = 227,
		["293"] = 229,
		["294"] = 214,
		["295"] = 203,
		["296"] = 195,
		["297"] = 195,
		["298"] = 195,
		["299"] = 195,
		["300"] = 195,
		["301"] = 195,
		["302"] = 195,
		["303"] = 195,
		["304"] = 203,
		["306"] = 203,
		["307"] = 232,
		["308"] = 240,
		["309"] = 232,
		["310"] = 240,
		["311"] = 241,
		["312"] = 242,
		["313"] = 243,
		["315"] = 246,
		["316"] = 246,
		["317"] = 246,
		["318"] = 246,
		["319"] = 246,
		["320"] = 247,
		["321"] = 247,
		["322"] = 247,
		["323"] = 247,
		["324"] = 247,
		["325"] = 248,
		["326"] = 248,
		["327"] = 248,
		["328"] = 248,
		["329"] = 248,
		["330"] = 249,
		["331"] = 249,
		["332"] = 249,
		["333"] = 249,
		["334"] = 249,
		["335"] = 249,
		["336"] = 249,
		["337"] = 249,
		["339"] = 241,
		["340"] = 252,
		["341"] = 253,
		["342"] = 254,
		["344"] = 252,
		["345"] = 257,
		["346"] = 258,
		["347"] = 257,
		["348"] = 262,
		["349"] = 263,
		["350"] = 264,
		["352"] = 262,
		["353"] = 240,
		["354"] = 232,
		["355"] = 232,
		["356"] = 232,
		["357"] = 232,
		["358"] = 232,
		["359"] = 232,
		["360"] = 232,
		["361"] = 232,
		["362"] = 240,
		["364"] = 240,
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
g.dazzle_talent = c()
local q = g.dazzle_talent
q.name = "dazzle_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_dazzle_talent"
end
q = e({ j(nil) }, q)
g.dazzle_talent = q
g.modifier_dazzle_talent = c()
local r = g.modifier_dazzle_talent
r.name = "modifier_dazzle_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.count = self:GetAbilitySpecialValueFor("count")
		+ self:GetAbilityTalentValue("dazzle_talent_1", "bonus_count")
		+ self:GetAbilityTalentValue("dazzle_talent_6", "bonus_count")
	self.injury_threshold = self:GetAbilityTalentValue("dazzle_talent_2", "injury_threshold")
	self.heal_pct = self:GetAbilityTalentValue("dazzle_talent_5", "heal_pct")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent(), -1 },
	}
end
function r.prototype.badJuJu(self)
	local s = self:GetParent()
	local t = s:GetEnemy()
	if IsInjurable(s, t) then
		AddInjury(s, t, self.count, "dazzle_talent", "Ability")
		AddPoison(s, t, self.count, "dazzle_talent", "Ability")
		if self:HasTalent("dazzle_talent_4") then
			t:AddNewModifier(s, self:GetAbility(), "modifier_dazzle_talent_debuff", nil)
		end
	end
end
function r.prototype.OnInjuryGained(self, u)
	if not IsServer() then
		return
	end
	if self.injury_threshold > 0 then
		self.injury_add_count = (self.injury_add_count or 0) + (u.iStackCount or 0)
		if self.injury_add_count >= self.injury_threshold then
			self.injury_add_count = self.injury_add_count - self.injury_threshold
			self:badJuJu()
		end
	end
end
function r.prototype.OnCustomTakeDamage(self, v)
	if not IsServer() then
		return
	end
	local s = self:GetParent()
	if v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL then
		if not self:GetCaster():PassivesDisabled() and self:PRD(self.chance) then
			self:badJuJu()
		end
	elseif v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_POISON then
		if self:HasTalent("dazzle_talent_3") then
			self:badJuJu()
		end
		if self.heal_pct > 0 then
			local w = (v.damage or 0) * self.heal_pct * 0.01
			Heal(s, w, "dazzle_talent", "Ability")
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
g.modifier_dazzle_talent = r
g.modifier_dazzle_talent_debuff = c()
local x = g.modifier_dazzle_talent_debuff
x.name = "modifier_dazzle_talent_debuff"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.bonus_stack = self:GetAbilityTalentValue("dazzle_talent_4", "bonus_stack")
	self.max_stack = self:GetAbilityTalentValue("dazzle_talent_4", "max_stack")
end
function x.prototype.OnCreated(self, u)
	if IsServer() then
		self:IncrementStackCount(self.bonus_stack)
	end
end
function x.prototype.OnRefresh(self, u)
	if IsServer() then
		self:SetStackCount(math.min(self.max_stack, self:GetStackCount() + self.bonus_stack))
	end
end
function x.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_TARGET,
	}
end
function x.prototype.EOM_GetModifierInjuryPermanent(self)
	return self.bonus_stack * self:GetStackCount()
end
function x.prototype.EOM_GetModifierPoisonDamageBonusTarget(self)
	return self.bonus_stack * self:GetStackCount()
end
x = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf",
			}
		),
	},
	x
)
g.modifier_dazzle_talent_debuff = x
g.dazzle_ult = c()
local y = g.dazzle_ult
y.name = "dazzle_ult"
d(y, o)
function y.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	local t = z:GetEnemy()
	local A = self:GetSpecialValueFor("injury")
	local B = self:GetSpecialValueFor("poison")
	local C = self:GetSpecialValueFor("duration")
	z:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf",
		hCaster = z,
		vSpawnOrigin = z:GetAttachmentPosition("attach_attack1"),
		hTarget = t,
		iMoveSpeed = 1000,
		OnProjectileHit = function(D, E, F)
			if IsInjurable(z, t) then
				t:AddNewModifier(z, self, "modifier_dazzle_ult_debuff", { duration = C })
				AddInjury(z, t, A, "dazzle_ult", "Ability")
				AddPoison(z, t, B, "dazzle_ult", "Ability")
				z:EmitSound("Hero_Dazzle.Poison_Touch")
			end
		end,
	})
	z:EmitSound("Hero_Dazzle.Poison_Cast")
end
y = e({ p(nil) }, y)
g.dazzle_ult = y
g.modifier_dazzle_ult_debuff = c()
local G = g.modifier_dazzle_ult_debuff
G.name = "modifier_dazzle_ult_debuff"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function G.prototype.OnCreated(self, u)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function G.prototype.OnIntervalThink(self)
	local z = self:GetCaster()
	local s = self:GetParent()
	z:DealDamage(s, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
G = e(
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
				GetEffectName = "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf",
			}
		),
	},
	G
)
g.modifier_dazzle_ult_debuff = G
g.dazzle_shard = c()
local H = g.dazzle_shard
H.name = "dazzle_shard"
d(H, i)
function H.prototype.GetIntrinsicModifierName(self)
	return "modifier_dazzle_shard"
end
H = e({ j(nil) }, H)
g.dazzle_shard = H
g.modifier_dazzle_shard = c()
local I = g.modifier_dazzle_shard
I.name = "modifier_dazzle_shard"
d(I, l)
function I.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = true
end
function I.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function I.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function I.prototype.EOM_GetModifierAvoidDamage(self, u)
	if not self.enable then
		return
	end
	if bit.band(u.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL then
		return 0
	end
	if u.damage >= u.target:GetHealth() then
		self.enable = false
		local s = self:GetParent()
		s:EmitSound("Hero_Dazzle.Projection")
		s:AddNewModifier(s, self:GetAbility(), "modifier_dazzle_shard_buff", { duration = self.duration })
		return 1
	end
	return 0
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
g.modifier_dazzle_shard = I
g.modifier_dazzle_shard_buff = c()
local J = g.modifier_dazzle_shard_buff
J.name = "modifier_dazzle_shard_buff"
d(J, l)
function J.prototype.OnCreated(self, u)
	if IsServer() then
		self:GetParent():EmitSound("Hero_Dazzle.Shallow_Grave")
	else
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControl(K, 7, Vector(1, 1, 1))
		ParticleManager:SetParticleControl(K, 8, Vector(1, 1, 1))
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function J.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("Hero_Dazzle.Shallow_Grave")
	end
end
function J.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE }
end
function J.prototype.EOM_GetModifierAllBlockChance(self, u)
	if u.damage_type ~= EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE then
		return 100
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
g.modifier_dazzle_shard_buff = J
return g