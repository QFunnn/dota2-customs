--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/blademaiden"
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
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 10,
		["24"] = 9,
		["25"] = 8,
		["26"] = 7,
		["27"] = 8,
		["29"] = 8,
		["30"] = 14,
		["31"] = 22,
		["32"] = 14,
		["33"] = 22,
		["34"] = 31,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 31,
		["43"] = 43,
		["44"] = 44,
		["45"] = 45,
		["46"] = 45,
		["47"] = 44,
		["48"] = 43,
		["49"] = 49,
		["50"] = 50,
		["53"] = 51,
		["54"] = 51,
		["55"] = 51,
		["56"] = 51,
		["59"] = 54,
		["60"] = 55,
		["61"] = 56,
		["62"] = 58,
		["63"] = 59,
		["64"] = 60,
		["65"] = 61,
		["66"] = 62,
		["67"] = 63,
		["68"] = 64,
		["69"] = 65,
		["70"] = 66,
		["71"] = 67,
		["72"] = 68,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 68,
		["77"] = 68,
		["82"] = 49,
		["83"] = 77,
		["84"] = 78,
		["85"] = 79,
		["86"] = 80,
		["87"] = 80,
		["88"] = 80,
		["89"] = 80,
		["90"] = 80,
		["91"] = 81,
		["92"] = 81,
		["93"] = 81,
		["94"] = 81,
		["95"] = 81,
		["96"] = 82,
		["97"] = 85,
		["98"] = 86,
		["99"] = 87,
		["101"] = 89,
		["102"] = 89,
		["103"] = 89,
		["104"] = 89,
		["105"] = 89,
		["106"] = 89,
		["109"] = 94,
		["110"] = 95,
		["111"] = 95,
		["112"] = 95,
		["113"] = 95,
		["114"] = 95,
		["115"] = 95,
		["117"] = 97,
		["118"] = 98,
		["119"] = 98,
		["120"] = 98,
		["121"] = 98,
		["122"] = 98,
		["123"] = 98,
		["124"] = 77,
		["125"] = 100,
		["126"] = 101,
		["127"] = 100,
		["128"] = 105,
		["129"] = 106,
		["130"] = 107,
		["132"] = 105,
		["133"] = 22,
		["134"] = 14,
		["135"] = 14,
		["136"] = 14,
		["137"] = 14,
		["138"] = 14,
		["139"] = 14,
		["140"] = 14,
		["141"] = 14,
		["142"] = 22,
		["144"] = 22,
		["145"] = 111,
		["146"] = 121,
		["147"] = 111,
		["148"] = 121,
		["149"] = 123,
		["150"] = 124,
		["151"] = 123,
		["152"] = 126,
		["153"] = 127,
		["154"] = 126,
		["155"] = 121,
		["156"] = 111,
		["157"] = 111,
		["158"] = 111,
		["159"] = 111,
		["160"] = 111,
		["161"] = 111,
		["162"] = 111,
		["163"] = 111,
		["164"] = 111,
		["165"] = 111,
		["166"] = 121,
		["168"] = 121,
		["169"] = 133,
		["170"] = 141,
		["171"] = 133,
		["172"] = 141,
		["173"] = 143,
		["174"] = 144,
		["175"] = 145,
		["177"] = 143,
		["178"] = 148,
		["179"] = 149,
		["180"] = 150,
		["182"] = 148,
		["183"] = 153,
		["184"] = 154,
		["185"] = 153,
		["186"] = 158,
		["187"] = 160,
		["188"] = 158,
		["189"] = 141,
		["190"] = 133,
		["191"] = 133,
		["192"] = 133,
		["193"] = 133,
		["194"] = 133,
		["195"] = 133,
		["196"] = 133,
		["197"] = 133,
		["198"] = 141,
		["200"] = 141,
		["202"] = 165,
		["203"] = 166,
		["204"] = 165,
		["205"] = 166,
		["206"] = 167,
		["207"] = 168,
		["208"] = 169,
		["209"] = 170,
		["210"] = 171,
		["211"] = 172,
		["213"] = 174,
		["214"] = 177,
		["215"] = 167,
		["216"] = 166,
		["217"] = 165,
		["218"] = 166,
		["220"] = 166,
		["221"] = 183,
		["222"] = 191,
		["223"] = 183,
		["224"] = 191,
		["226"] = 191,
		["227"] = 193,
		["228"] = 183,
		["229"] = 194,
		["230"] = 194,
		["231"] = 198,
		["232"] = 199,
		["233"] = 200,
		["234"] = 201,
		["235"] = 202,
		["236"] = 203,
		["238"] = 205,
		["239"] = 205,
		["240"] = 205,
		["241"] = 205,
		["242"] = 206,
		["243"] = 207,
		["245"] = 212,
		["246"] = 213,
		["247"] = 213,
		["248"] = 213,
		["249"] = 213,
		["250"] = 213,
		["251"] = 213,
		["252"] = 213,
		["253"] = 213,
		["254"] = 213,
		["255"] = 214,
		["256"] = 214,
		["257"] = 214,
		["258"] = 214,
		["259"] = 214,
		["260"] = 214,
		["261"] = 214,
		["262"] = 214,
		["264"] = 198,
		["265"] = 218,
		["266"] = 219,
		["267"] = 220,
		["268"] = 221,
		["269"] = 222,
		["270"] = 223,
		["272"] = 225,
		["273"] = 225,
		["274"] = 225,
		["275"] = 225,
		["276"] = 226,
		["277"] = 227,
		["279"] = 218,
		["280"] = 230,
		["281"] = 231,
		["282"] = 232,
		["283"] = 233,
		["284"] = 234,
		["285"] = 235,
		["288"] = 230,
		["289"] = 239,
		["290"] = 240,
		["291"] = 241,
		["292"] = 242,
		["293"] = 243,
		["294"] = 244,
		["296"] = 239,
		["297"] = 248,
		["298"] = 249,
		["299"] = 248,
		["300"] = 191,
		["301"] = 183,
		["302"] = 183,
		["303"] = 183,
		["304"] = 183,
		["305"] = 183,
		["306"] = 183,
		["307"] = 183,
		["308"] = 183,
		["309"] = 191,
		["311"] = 191,
		["312"] = 266,
		["313"] = 275,
		["314"] = 266,
		["315"] = 275,
		["316"] = 282,
		["317"] = 283,
		["318"] = 284,
		["319"] = 285,
		["320"] = 287,
		["321"] = 289,
		["322"] = 282,
		["323"] = 292,
		["324"] = 293,
		["325"] = 294,
		["326"] = 300,
		["327"] = 301,
		["328"] = 302,
		["329"] = 303,
		["331"] = 292,
		["332"] = 306,
		["333"] = 307,
		["334"] = 308,
		["335"] = 309,
		["336"] = 310,
		["337"] = 310,
		["338"] = 310,
		["339"] = 310,
		["340"] = 310,
		["341"] = 311,
		["342"] = 312,
		["343"] = 313,
		["344"] = 314,
		["345"] = 315,
		["346"] = 315,
		["347"] = 315,
		["348"] = 315,
		["349"] = 315,
		["350"] = 316,
		["351"] = 316,
		["352"] = 316,
		["353"] = 317,
		["354"] = 316,
		["355"] = 316,
		["356"] = 319,
		["357"] = 320,
		["359"] = 306,
		["360"] = 323,
		["361"] = 324,
		["362"] = 325,
		["363"] = 327,
		["364"] = 328,
		["365"] = 331,
		["367"] = 323,
		["368"] = 275,
		["369"] = 266,
		["370"] = 266,
		["371"] = 266,
		["372"] = 266,
		["373"] = 266,
		["374"] = 266,
		["375"] = 266,
		["376"] = 266,
		["377"] = 266,
		["378"] = 275,
		["380"] = 275,
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
g.blademaiden_talent = c()
local q = g.blademaiden_talent
q.name = "blademaiden_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_blademaiden_talent"
end
q = e({ j(nil) }, q)
g.blademaiden_talent = q
g.modifier_blademaiden_talent = c()
local r = g.modifier_blademaiden_talent
r.name = "modifier_blademaiden_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.fury_count = self:GetAbilitySpecialValueFor("fury_gain")
	self.base_heal = self:GetAbilityTalentValue("blademaiden_talent_2", "base_heal")
	self.attack_heal = self:GetAbilityTalentValue("blademaiden_talent_2", "attack_heal")
	self.reduce_count = self:GetAbilityTalentValue("blademaiden_talent_5", "reduce_count")
	self.s_duration = self:GetAbilityTalentValue("blademaiden_shard", "duration")
	self.s_count = self:GetAbilityTalentValue("blademaiden_shard", "count")
	self.s_record = 0
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAttackLanded(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if
		bit.band(defaultValue(s.damage_flags, DamageFlags.DAMAGE_FLAG_NONE), DamageFlags.DAMAGE_FLAG_NO_EXTRA)
		== DamageFlags.DAMAGE_FLAG_NO_EXTRA
	then
		return
	end
	local t = self:GetStackCount() + 1
	self:IncrementStackCount()
	if IsValid(s.target) then
		local u = self:GetAbilitySpecialValueFor("count") - self.reduce_count
		if t >= u then
			self:SetStackCount(0)
			self:FlameBlades(s.target)
			if self.s_count > 0 then
				self.s_record = self.s_record + 1
				if self.s_record == self.s_count then
					self.s_record = 0
					local v = self:GetParent()
					v:EmitSound("Hero_Puck.EtherealJaunt")
					v:AddNewModifier(v, self:GetAbility(), "modifire_blademaiden_shard", { duration = self.s_duration })
				end
			end
		end
	end
end
function r.prototype.FlameBlades(self, w)
	local v = self:GetParent()
	local x = ParticleManager:CreateParticle(
		"particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_slash_tgt.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		w,
		v
	)
	ParticleManager:SetParticleControl(x, 0, w:GetAbsOrigin() + RandomVector(200))
	ParticleManager:SetParticleControl(x, 1, w:GetAbsOrigin())
	v:EmitSound("Hero_Juggernaut.OmniSlash")
	if self.fury_count > 0 then
		if not self:HasTalent("blademaiden_talent_5") then
			AddFury(v, self.fury_count, "blademaiden_talent", "Ability")
		else
			v:AddNewModifier(v, self:GetAbility(), "modifire_blademaiden_talent_1", { count = self.fury_count })
		end
	end
	if self.attack_heal > 0 then
		Heal(v, self.base_heal + self.attack_heal * GetFury(v) * 0.01, "blademaiden_talent_3", "Ability")
	end
	local y = self:GetAbilitySpecialValueFor("fury_base_damage")
		+ self:GetAbilityTalentValue("blademaiden_talent_7", "damage")
		+ (
				self:GetAbilitySpecialValueFor("fury_extra_pct")
				+ self:GetAbilityTalentValue("blademaiden_talent_4", "fury_damage_pct")
			)
			* 0.01
			* GetFury(v)
	v:DealDamage(w, self:GetAbility(), y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
end
function r.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function r.prototype.GetActivityTranslationModifiers(self)
	if self:GetStackCount() == self:GetAbilitySpecialValueFor("count") - self.reduce_count - 1 then
		return "ember"
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
g.modifier_blademaiden_talent = r
g.modifire_blademaiden_shard = c()
local z = g.modifire_blademaiden_shard
z.name = "modifire_blademaiden_shard"
d(z, l)
function z.prototype.GetAbilitySpecialValue(self)
	self.ice_fury_against = self:GetAbilityTalentValue("blademaiden_shard", "ice_fury_against")
end
function z.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ICE_FURY_AGAINST_PERCENTAGE] = self.ice_fury_against,
	}
end
z = e(
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
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
				GetStatusEffectName = "particles/status_fx/status_effect_valkyrie_fire_wreath_magic_immunity.vpcf",
			}
		),
	},
	z
)
g.modifire_blademaiden_shard = z
g.modifire_blademaiden_talent_1 = c()
local A = g.modifire_blademaiden_talent_1
A.name = "modifire_blademaiden_talent_1"
d(A, l)
function A.prototype.OnCreated(self, B)
	if IsServer() then
		self.fury = B.count
	end
end
function A.prototype.OnRefresh(self, B)
	if IsServer() then
		self.fury = self.fury + B.count
	end
end
function A.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_PERMANENT }
end
function A.prototype.EOM_GetModifierFuryPermanent(self)
	return self.fury
end
A = e(
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
	A
)
g.modifire_blademaiden_talent_1 = A
g.blademaiden_ult = c()
local C = g.blademaiden_ult
C.name = "blademaiden_ult"
d(C, o)
function C.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	local E = self:GetSpecialValueFor("duration")
	local F = self:GetTalentValue("blademaiden_talent_3", "bonus_fury")
	if F > 0 then
		AddFury(D, F, "blademaiden_ult", "Ability")
	end
	D:AddNewModifier(D, self, "modifier_blademaiden_ult", { duration = E })
	D:AddNewModifier(D, self, "modifier_blademaiden_ult_cast", { duration = E })
end
C = e({ p(nil) }, C)
g.blademaiden_ult = C
g.modifier_blademaiden_ult = c()
local G = g.modifier_blademaiden_ult
G.name = "modifier_blademaiden_ult"
d(G, l)
function G.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.record = 0
end
function G.prototype.GetAbilitySpecialValue(self) end
function G.prototype.OnCreated(self, B)
	local v = self:GetParent()
	if IsServer() then
		local H = v:FindModifierByName("modifier_fury_custom")
		if IsValid(H) then
			H:StartIntervalThink(-1)
		end
		self:StartThink(self:GetDuration(), tostring(self.record))
		self.record = self.record + 1
		v:EmitSound("Hero_OgreMagi.FireShield.Target")
	else
		local x = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_swordmaiden/jianji_ult_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			v
		)
		ParticleManager:SetParticleControlEnt(x, 1, v, PATTACH_POINT_FOLLOW, "attach_hitloc", v:GetAbsOrigin(), true)
		self:AddParticle(x, false, false, -1, false, false)
	end
end
function G.prototype.OnRefresh(self, B)
	local v = self:GetParent()
	if IsServer() then
		local H = v:FindModifierByName("modifier_fury_custom")
		if IsValid(H) then
			H:StartIntervalThink(-1)
		end
		self:StartThink(self:GetDuration(), tostring(self.record))
		self.record = self.record + 1
		v:EmitSound("Hero_OgreMagi.FireShield.Target")
	end
end
function G.prototype.OnDestroy(self)
	if IsServer() then
		local v = self:GetParent()
		local H = v:FindModifierByName("modifier_fury_custom")
		if IsValid(H) then
			H:StartIntervalThink(FURY_ATTENUATION.Interval)
		end
	end
end
function G.prototype.OnThink(self, I)
	self:StartThink(-1, I)
	local v = self:GetParent()
	local H = v:FindModifierByName("modifier_fury_custom")
	if IsValid(H) then
		H:OnIntervalThink()
	end
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE }
end
G = e(
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
	G
)
g.modifier_blademaiden_ult = G
g.modifier_blademaiden_ult_cast = c()
local J = g.modifier_blademaiden_ult_cast
J.name = "modifier_blademaiden_ult_cast"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.strike_count = self:GetAbilitySpecialValueFor("strike_count")
	self.fury_reduce_pct = self:GetAbilitySpecialValueFor("fury_reduce_pct")
	self.consume_fury_reduction = self:GetAbilityTalentValue("blademaiden_talent_4", "consume_fury_reduction")
	self.bonus_strike = self:GetAbilityTalentValue("blademaiden_talent_6", "bonus_strike")
	self.animCount = 0
end
function J.prototype.OnCreated(self, B)
	if IsServer() then
		local v = self:GetParent()
		local K = self.strike_count + self.bonus_strike
		self:StartIntervalThink(1 / K)
		v:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
		self:StartThink(0.15, "anim")
	end
end
function J.prototype.OnThink(self, I)
	self.animCount = self.animCount + 1
	local v = self:GetParent()
	local L = v:GetAbsOrigin() + Vector(0, 0, 128)
	local M = v:GetAbsOrigin() + v:GetForwardVector() * 1000 + Vector(0, RandomInt(-500, 500), RandomInt(-200, 200))
	local x =
		ParticleManager:CreateParticle("particles/units/heroes/hero_swordmaiden/sword_qi.vpcf", PATTACH_CUSTOMORIGIN, v)
	ParticleManager:SetParticleControl(x, 0, L)
	ParticleManager:SetParticleControlTransformForward(x, 0, L, M - L)
	ParticleManager:SetParticleControl(x, 1, M)
	ParticleManager:SetParticleControl(x, 2, Vector(2000, 0, 0))
	GameTimer(0.1, function()
		ParticleManager:DestroyParticle(x, false)
	end)
	if self.animCount >= 4 then
		self:StartThink(-1, "anim")
	end
end
function J.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local w = v:GetEnemy()
	local N = v:FindModifierByName("modifier_blademaiden_talent")
	if IsValid(N) and type(N.FlameBlades) == "function" and IsInjurable(v, w) then
		N:FlameBlades(w)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	J
)
g.modifier_blademaiden_ult_cast = J
return g