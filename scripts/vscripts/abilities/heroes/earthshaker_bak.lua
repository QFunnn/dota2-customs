--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/earthshaker_bak"
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
		["35"] = 21,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 13,
		["40"] = 34,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 38,
		["45"] = 38,
		["46"] = 38,
		["47"] = 48,
		["48"] = 34,
		["49"] = 50,
		["50"] = 51,
		["51"] = 51,
		["52"] = 53,
		["53"] = 53,
		["54"] = 53,
		["55"] = 51,
		["56"] = 54,
		["57"] = 54,
		["58"] = 54,
		["59"] = 51,
		["60"] = 51,
		["61"] = 50,
		["62"] = 57,
		["63"] = 58,
		["64"] = 59,
		["65"] = 60,
		["66"] = 57,
		["67"] = 62,
		["68"] = 63,
		["69"] = 64,
		["70"] = 62,
		["71"] = 66,
		["72"] = 67,
		["73"] = 68,
		["74"] = 69,
		["75"] = 70,
		["76"] = 71,
		["77"] = 72,
		["78"] = 73,
		["79"] = 74,
		["83"] = 66,
		["84"] = 79,
		["85"] = 80,
		["86"] = 81,
		["87"] = 82,
		["88"] = 83,
		["89"] = 84,
		["91"] = 86,
		["92"] = 87,
		["95"] = 79,
		["96"] = 92,
		["97"] = 92,
		["98"] = 92,
		["100"] = 93,
		["103"] = 96,
		["104"] = 97,
		["105"] = 98,
		["108"] = 99,
		["111"] = 100,
		["112"] = 101,
		["113"] = 102,
		["114"] = 103,
		["116"] = 105,
		["117"] = 106,
		["118"] = 107,
		["120"] = 109,
		["121"] = 109,
		["122"] = 109,
		["123"] = 109,
		["124"] = 109,
		["125"] = 109,
		["126"] = 109,
		["127"] = 109,
		["128"] = 109,
		["129"] = 118,
		["130"] = 119,
		["131"] = 119,
		["132"] = 119,
		["133"] = 119,
		["134"] = 119,
		["135"] = 120,
		["136"] = 120,
		["137"] = 120,
		["138"] = 120,
		["139"] = 120,
		["140"] = 121,
		["141"] = 122,
		["142"] = 92,
		["143"] = 21,
		["144"] = 13,
		["145"] = 13,
		["146"] = 13,
		["147"] = 13,
		["148"] = 13,
		["149"] = 13,
		["150"] = 13,
		["151"] = 13,
		["152"] = 21,
		["154"] = 21,
		["156"] = 128,
		["157"] = 129,
		["158"] = 128,
		["159"] = 129,
		["160"] = 130,
		["161"] = 131,
		["162"] = 132,
		["163"] = 133,
		["166"] = 136,
		["167"] = 137,
		["168"] = 137,
		["169"] = 137,
		["170"] = 138,
		["171"] = 139,
		["172"] = 140,
		["173"] = 141,
		["175"] = 143,
		["177"] = 137,
		["178"] = 137,
		["179"] = 130,
		["180"] = 147,
		["181"] = 148,
		["182"] = 147,
		["183"] = 129,
		["184"] = 128,
		["185"] = 129,
		["187"] = 129,
		["188"] = 152,
		["189"] = 160,
		["190"] = 152,
		["191"] = 160,
		["192"] = 164,
		["193"] = 166,
		["194"] = 168,
		["195"] = 164,
		["196"] = 170,
		["197"] = 171,
		["199"] = 170,
		["200"] = 174,
		["201"] = 175,
		["202"] = 174,
		["203"] = 177,
		["204"] = 178,
		["205"] = 177,
		["206"] = 184,
		["207"] = 185,
		["208"] = 186,
		["210"] = 184,
		["211"] = 189,
		["212"] = 190,
		["213"] = 191,
		["215"] = 189,
		["216"] = 194,
		["217"] = 195,
		["218"] = 196,
		["220"] = 194,
		["221"] = 160,
		["222"] = 152,
		["223"] = 152,
		["224"] = 152,
		["225"] = 152,
		["226"] = 152,
		["227"] = 152,
		["228"] = 152,
		["229"] = 152,
		["230"] = 160,
		["232"] = 160,
		["234"] = 202,
		["235"] = 210,
		["236"] = 202,
		["237"] = 210,
		["238"] = 213,
		["239"] = 214,
		["240"] = 213,
		["241"] = 216,
		["242"] = 217,
		["243"] = 218,
		["244"] = 219,
		["245"] = 220,
		["246"] = 220,
		["247"] = 220,
		["248"] = 220,
		["249"] = 220,
		["250"] = 220,
		["251"] = 220,
		["252"] = 220,
		["253"] = 220,
		["254"] = 221,
		["255"] = 221,
		["256"] = 221,
		["257"] = 221,
		["258"] = 221,
		["259"] = 221,
		["260"] = 221,
		["261"] = 221,
		["263"] = 216,
		["264"] = 224,
		["265"] = 225,
		["266"] = 224,
		["267"] = 229,
		["268"] = 230,
		["269"] = 229,
		["270"] = 232,
		["271"] = 233,
		["272"] = 232,
		["273"] = 238,
		["274"] = 239,
		["275"] = 240,
		["277"] = 238,
		["278"] = 243,
		["279"] = 244,
		["280"] = 245,
		["281"] = 246,
		["282"] = 247,
		["283"] = 248,
		["284"] = 249,
		["285"] = 250,
		["287"] = 252,
		["290"] = 243,
		["291"] = 256,
		["292"] = 257,
		["293"] = 256,
		["294"] = 261,
		["295"] = 262,
		["296"] = 261,
		["297"] = 210,
		["298"] = 202,
		["299"] = 202,
		["300"] = 202,
		["301"] = 202,
		["302"] = 202,
		["303"] = 202,
		["304"] = 202,
		["305"] = 202,
		["306"] = 210,
		["308"] = 210,
		["310"] = 267,
		["311"] = 268,
		["312"] = 267,
		["313"] = 268,
		["314"] = 269,
		["315"] = 270,
		["316"] = 269,
		["317"] = 268,
		["318"] = 267,
		["319"] = 268,
		["321"] = 268,
		["323"] = 275,
		["324"] = 283,
		["325"] = 275,
		["326"] = 283,
		["327"] = 285,
		["328"] = 286,
		["329"] = 285,
		["330"] = 288,
		["331"] = 289,
		["332"] = 288,
		["333"] = 293,
		["334"] = 295,
		["335"] = 295,
		["336"] = 295,
		["337"] = 295,
		["338"] = 293,
		["339"] = 283,
		["340"] = 275,
		["341"] = 275,
		["342"] = 275,
		["343"] = 275,
		["344"] = 275,
		["345"] = 275,
		["346"] = 275,
		["347"] = 275,
		["348"] = 283,
		["350"] = 283,
		["352"] = 300,
		["353"] = 301,
		["354"] = 300,
		["355"] = 301,
		["356"] = 302,
		["357"] = 303,
		["358"] = 302,
		["359"] = 301,
		["360"] = 300,
		["361"] = 301,
		["363"] = 301,
		["364"] = 306,
		["365"] = 314,
		["366"] = 306,
		["367"] = 314,
		["368"] = 316,
		["369"] = 317,
		["370"] = 316,
		["371"] = 319,
		["372"] = 320,
		["373"] = 319,
		["374"] = 314,
		["375"] = 306,
		["376"] = 306,
		["377"] = 306,
		["378"] = 306,
		["379"] = 306,
		["380"] = 306,
		["381"] = 306,
		["382"] = 306,
		["383"] = 314,
		["385"] = 314,
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
g.earthshaker_talent = c()
local q = g.earthshaker_talent
q.name = "earthshaker_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_talent"
end
q = e({ j(nil) }, q)
g.earthshaker_talent = q
g.modifier_earthshaker_talent = c()
local r = g.modifier_earthshaker_talent
r.name = "modifier_earthshaker_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = false
	self.record = 0
	self.tick = 0.1
end
function r.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("earthshaker_talent_6", "bonus_damage")
	self.stun_duration = self:GetAbilitySpecialValueFor("stun_duration")
		+ self:GetAbilityTalentValue("earthshaker_talent_6", "stun_duration")
	self.interval = math.max(
		0,
		self:GetAbilitySpecialValueFor("interval") - self:GetAbilityTalentValue("earthshaker_talent_6", "cd_reduce")
	)
	self.tl3_count = self:GetAbilityTalentValue("earthshaker_talent_3", "count")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.enable = true
	self.tl3_record = 0
	self.record = 0
end
function r.prototype.OnBattleEnd(self, s)
	self.enable = false
	self:StartIntervalThink(-1)
end
function r.prototype.OnCritical(self, s)
	self:AfterShock()
	if self.tl3_count > 0 then
		self.tl3_record = self.tl3_record + 1
		if self.tl3_record >= self.tl3_count then
			self.tl3_record = 0
			local t = self:GetParent():FindAbilityByName("earthshaker_ult")
			if IsValid(t) then
				t:OnSpellStart()
			end
		end
	end
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self.record = self.record + self.tick
		if self.record >= self.interval then
			self.enable = true
			self.record = 0
		end
		if self.enable then
			self:StartIntervalThink(-1)
		end
	end
end
function r.prototype.AfterShock(self, u)
	if u == nil then
		u = true
	end
	if u and not self.enable then
		return
	end
	local v = self:GetParent()
	local w = v:GetEnemy()
	if v:PassivesDisabled() then
		return
	end
	if not IsInjurable(v, w) then
		return
	end
	if u and self.interval > 0 then
		self.enable = false
		self.record = 0
		self:StartIntervalThink(self.tick)
	end
	local t = self:GetAbility()
	if self.stun_duration > 0 then
		AddStun(v, w, t, self.stun_duration)
	end
	DamageSystem:dealDamage({
		attacker = v,
		target = w,
		ability = t,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_NONE,
		damage_flags = DamageFlags.DAMAGE_FLAG_REFLECTION
			+ DamageFlags.DAMAGE_FLAG_HPLOSS
			+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	})
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf",
		PATTACH_CUSTOMORIGIN,
		v
	)
	ParticleManager:SetParticleControl(x, 0, v:GetAbsOrigin())
	ParticleManager:SetParticleControl(x, 1, Vector(350, 350, 350))
	ParticleManager:ReleaseParticleIndex(x)
	v:EmitSound("Hero_EarthShaker.Totem")
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
g.modifier_earthshaker_talent = r
g.earthshaker_ult = c()
local y = g.earthshaker_ult
y.name = "earthshaker_ult"
d(y, o)
function y.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	local w = z:GetEnemy()
	if not IsInjurable(w, z) then
		return
	end
	z:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 2)
	self:GameTimer(0.25, function()
		if IsInjurable(z) then
			local A = z:FindModifierByName("modifier_earthshaker_talent")
			if IsValid(A) then
				A:AfterShock(false)
			end
			z:AddNewModifier(z, self, "modifier_earthshaker_ult_buff", {})
		end
	end)
end
function y.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_ult"
end
y = e({ p(nil) }, y)
g.earthshaker_ult = y
g.modifier_earthshaker_ult = c()
local B = g.modifier_earthshaker_ult
B.name = "modifier_earthshaker_ult"
d(B, l)
function B.prototype.GetAbilitySpecialValue(self)
	self.tl5_crit_damage = self:GetAbilityTalentValue("earthshaker_talent_5", "crit_damage")
	self.s_hitrate = self:GetAbilityTalentValue("earthshaker_shard", "hitrate")
end
function B.prototype.OnCreated(self, s)
	if IsServer() then
	end
end
function B.prototype.RecordUltAttackInfo(self, C)
	self.ultRecord = C
end
function B.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_SUREHIT_CHANCE,
	}
end
function B.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, s)
	if s ~= nil and self.ultRecord == s then
		return 1000
	end
end
function B.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self, s)
	if s ~= nil and self.ultRecord == s then
		return self.tl5_crit_damage
	end
end
function B.prototype.EOM_GetModifierSurehitChance(self, s)
	if s ~= nil and self.ultRecord == s then
		return self.s_hitrate
	end
end
B = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	B
)
g.modifier_earthshaker_ult = B
g.modifier_earthshaker_ult_buff = c()
local D = g.modifier_earthshaker_ult_buff
D.name = "modifier_earthshaker_ult_buff"
d(D, l)
function D.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("earthshaker_talent_1", "bonus_damage")
end
function D.prototype.OnCreated(self, s)
	if IsClient() then
		local v = self:GetParent()
		local E = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf",
			PATTACH_CUSTOMORIGIN,
			v
		)
		ParticleManager:SetParticleControlEnt(E, 0, v, PATTACH_POINT_FOLLOW, "attach_totem", vec3_zero, true)
		self:AddParticle(E, false, false, -1, false, false)
	end
end
function D.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_START] = { self:GetParent() } }
end
function D.prototype.OnCustomAttackStart(self, F)
	self.utlInfo = F
end
function D.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
	}
end
function D.prototype.EOM_GetModifierAttackSourceAbility(self, s)
	if s ~= nil and self.utlInfo == s then
		return self:GetAbility()
	end
end
function D.prototype.EOM_GetModifierProcAttackDamageBonus(self, s)
	if IsServer() then
		if s ~= nil and s == self.utlInfo then
			self:GetParent():EmitSound("Hero_EarthShaker.Totem.Attack")
			self:Destroy()
			local G = self:GetParent():FindModifierByName("modifier_earthshaker_ult")
			if IsValid(G) then
				G:RecordUltAttackInfo(s)
			end
			return self.damage
		end
	end
end
function D.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function D.prototype.GetActivityTranslationModifiers(self)
	return "enchant_totem"
end
D = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	D
)
g.modifier_earthshaker_ult_buff = D
g.earthshaker_talent_4 = c()
local H = g.earthshaker_talent_4
H.name = "earthshaker_talent_4"
d(H, i)
function H.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_talent_4"
end
H = e({ j(nil) }, H)
g.earthshaker_talent_4 = H
g.modifier_earthshaker_talent_4 = c()
local I = g.modifier_earthshaker_talent_4
I.name = "modifier_earthshaker_talent_4"
d(I, l)
function I.prototype.GetAbilitySpecialValue(self)
	self.crit_pct = self:GetAbilitySpecialValueFor("crit_pct")
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MAGICAL_CRITICALSTRIKE_CHANCE }
end
function I.prototype.EOM_GetModifierMagicalCriticalStrikeChance(self, s)
	return GetPhysicalCriticalChance(self:GetParent(), s) * self.crit_pct * 0.01
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
g.modifier_earthshaker_talent_4 = I
g.earthshaker_talent_7 = c()
local J = g.earthshaker_talent_7
J.name = "earthshaker_talent_7"
d(J, i)
function J.prototype.GetIntrinsicModifierName(self)
	return "modifier_earthshaker_talent_7"
end
J = e({ j(nil) }, J)
g.earthshaker_talent_7 = J
g.modifier_earthshaker_talent_7 = c()
local K = g.modifier_earthshaker_talent_7
K.name = "modifier_earthshaker_talent_7"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.crit = self:GetAbilitySpecialValueFor("crit")
end
function K.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit }
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
g.modifier_earthshaker_talent_7 = K
return g