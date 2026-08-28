--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/bloodseeker"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
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
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["38"] = 35,
		["39"] = 36,
		["40"] = 37,
		["41"] = 31,
		["42"] = 40,
		["43"] = 41,
		["44"] = 41,
		["45"] = 43,
		["46"] = 43,
		["47"] = 43,
		["48"] = 41,
		["49"] = 44,
		["50"] = 44,
		["51"] = 44,
		["52"] = 41,
		["53"] = 41,
		["54"] = 40,
		["55"] = 47,
		["56"] = 48,
		["57"] = 49,
		["58"] = 50,
		["59"] = 51,
		["60"] = 52,
		["61"] = 52,
		["62"] = 52,
		["63"] = 52,
		["64"] = 52,
		["65"] = 52,
		["67"] = 54,
		["68"] = 55,
		["69"] = 55,
		["70"] = 55,
		["71"] = 55,
		["72"] = 55,
		["73"] = 55,
		["75"] = 57,
		["76"] = 58,
		["77"] = 58,
		["78"] = 58,
		["79"] = 58,
		["80"] = 59,
		["81"] = 59,
		["82"] = 59,
		["83"] = 59,
		["84"] = 59,
		["85"] = 59,
		["88"] = 47,
		["89"] = 63,
		["90"] = 64,
		["91"] = 65,
		["93"] = 63,
		["94"] = 68,
		["95"] = 69,
		["96"] = 70,
		["97"] = 71,
		["98"] = 72,
		["100"] = 68,
		["101"] = 75,
		["102"] = 76,
		["103"] = 75,
		["104"] = 78,
		["105"] = 79,
		["106"] = 80,
		["108"] = 78,
		["109"] = 83,
		["110"] = 84,
		["111"] = 85,
		["112"] = 85,
		["113"] = 85,
		["114"] = 86,
		["115"] = 87,
		["116"] = 87,
		["117"] = 87,
		["118"] = 87,
		["119"] = 87,
		["120"] = 88,
		["121"] = 88,
		["122"] = 88,
		["123"] = 88,
		["124"] = 88,
		["125"] = 89,
		["126"] = 89,
		["127"] = 89,
		["128"] = 89,
		["129"] = 89,
		["130"] = 85,
		["131"] = 85,
		["132"] = 83,
		["133"] = 93,
		["134"] = 94,
		["135"] = 95,
		["136"] = 96,
		["137"] = 97,
		["140"] = 98,
		["141"] = 99,
		["142"] = 100,
		["143"] = 100,
		["144"] = 100,
		["145"] = 101,
		["146"] = 100,
		["147"] = 100,
		["148"] = 104,
		["149"] = 105,
		["150"] = 106,
		["151"] = 107,
		["152"] = 108,
		["153"] = 109,
		["154"] = 110,
		["157"] = 113,
		["158"] = 113,
		["159"] = 113,
		["160"] = 113,
		["161"] = 113,
		["162"] = 113,
		["163"] = 116,
		["164"] = 117,
		["165"] = 117,
		["166"] = 117,
		["167"] = 117,
		["168"] = 117,
		["169"] = 117,
		["172"] = 93,
		["173"] = 122,
		["174"] = 123,
		["175"] = 124,
		["176"] = 125,
		["177"] = 126,
		["179"] = 128,
		["181"] = 122,
		["182"] = 22,
		["183"] = 14,
		["184"] = 14,
		["185"] = 14,
		["186"] = 14,
		["187"] = 14,
		["188"] = 14,
		["189"] = 14,
		["190"] = 14,
		["191"] = 22,
		["193"] = 22,
		["195"] = 135,
		["196"] = 136,
		["197"] = 135,
		["198"] = 136,
		["199"] = 137,
		["200"] = 138,
		["201"] = 139,
		["202"] = 141,
		["203"] = 142,
		["204"] = 143,
		["205"] = 143,
		["206"] = 143,
		["207"] = 143,
		["208"] = 144,
		["209"] = 137,
		["210"] = 136,
		["211"] = 135,
		["212"] = 136,
		["214"] = 136,
		["215"] = 151,
		["216"] = 161,
		["217"] = 151,
		["218"] = 161,
		["219"] = 167,
		["220"] = 168,
		["221"] = 169,
		["222"] = 170,
		["223"] = 171,
		["224"] = 167,
		["225"] = 174,
		["226"] = 175,
		["227"] = 176,
		["228"] = 177,
		["230"] = 174,
		["231"] = 180,
		["232"] = 181,
		["233"] = 182,
		["235"] = 180,
		["236"] = 185,
		["237"] = 186,
		["238"] = 187,
		["240"] = 185,
		["241"] = 191,
		["242"] = 192,
		["243"] = 193,
		["244"] = 195,
		["245"] = 196,
		["246"] = 196,
		["247"] = 196,
		["248"] = 196,
		["249"] = 196,
		["250"] = 196,
		["251"] = 196,
		["253"] = 191,
		["254"] = 200,
		["255"] = 201,
		["256"] = 202,
		["257"] = 202,
		["258"] = 201,
		["259"] = 200,
		["260"] = 206,
		["261"] = 207,
		["262"] = 209,
		["263"] = 210,
		["264"] = 210,
		["265"] = 210,
		["266"] = 210,
		["267"] = 210,
		["268"] = 210,
		["270"] = 206,
		["271"] = 214,
		["272"] = 215,
		["273"] = 214,
		["274"] = 220,
		["275"] = 221,
		["276"] = 220,
		["277"] = 161,
		["278"] = 151,
		["279"] = 151,
		["280"] = 151,
		["281"] = 151,
		["282"] = 151,
		["283"] = 151,
		["284"] = 151,
		["285"] = 151,
		["286"] = 151,
		["287"] = 151,
		["288"] = 161,
		["290"] = 161,
		["291"] = 226,
		["292"] = 233,
		["293"] = 226,
		["294"] = 233,
		["295"] = 237,
		["296"] = 238,
		["297"] = 239,
		["298"] = 240,
		["299"] = 237,
		["300"] = 242,
		["301"] = 243,
		["302"] = 244,
		["304"] = 242,
		["305"] = 247,
		["306"] = 248,
		["307"] = 249,
		["308"] = 250,
		["309"] = 251,
		["310"] = 252,
		["313"] = 255,
		["315"] = 247,
		["316"] = 258,
		["317"] = 259,
		["318"] = 260,
		["320"] = 258,
		["321"] = 263,
		["322"] = 264,
		["323"] = 263,
		["324"] = 269,
		["325"] = 270,
		["326"] = 269,
		["327"] = 272,
		["328"] = 273,
		["329"] = 272,
		["330"] = 233,
		["331"] = 226,
		["332"] = 226,
		["333"] = 226,
		["334"] = 226,
		["335"] = 226,
		["336"] = 226,
		["337"] = 226,
		["338"] = 233,
		["340"] = 233,
		["341"] = 278,
		["342"] = 286,
		["343"] = 278,
		["344"] = 286,
		["346"] = 286,
		["347"] = 289,
		["348"] = 278,
		["349"] = 291,
		["350"] = 292,
		["351"] = 293,
		["352"] = 294,
		["353"] = 295,
		["355"] = 291,
		["356"] = 299,
		["357"] = 300,
		["358"] = 301,
		["359"] = 301,
		["360"] = 301,
		["361"] = 300,
		["362"] = 302,
		["363"] = 302,
		["364"] = 302,
		["365"] = 300,
		["366"] = 300,
		["367"] = 299,
		["368"] = 306,
		["369"] = 307,
		["370"] = 308,
		["371"] = 309,
		["372"] = 310,
		["373"] = 311,
		["376"] = 306,
		["377"] = 316,
		["378"] = 317,
		["379"] = 318,
		["380"] = 319,
		["381"] = 320,
		["384"] = 316,
		["385"] = 325,
		["386"] = 326,
		["387"] = 327,
		["388"] = 328,
		["391"] = 329,
		["394"] = 331,
		["395"] = 332,
		["396"] = 332,
		["397"] = 332,
		["398"] = 332,
		["399"] = 332,
		["400"] = 332,
		["401"] = 325,
		["402"] = 286,
		["403"] = 278,
		["404"] = 278,
		["405"] = 278,
		["406"] = 278,
		["407"] = 278,
		["408"] = 278,
		["409"] = 278,
		["410"] = 278,
		["411"] = 286,
		["413"] = 286,
		["414"] = 337,
		["415"] = 338,
		["416"] = 337,
		["417"] = 338,
		["418"] = 339,
		["419"] = 340,
		["420"] = 339,
		["421"] = 338,
		["422"] = 337,
		["423"] = 338,
		["425"] = 338,
		["426"] = 344,
		["427"] = 351,
		["428"] = 344,
		["429"] = 351,
		["430"] = 354,
		["431"] = 355,
		["432"] = 354,
		["433"] = 358,
		["434"] = 359,
		["435"] = 358,
		["436"] = 364,
		["437"] = 365,
		["438"] = 366,
		["439"] = 367,
		["440"] = 367,
		["441"] = 367,
		["442"] = 367,
		["443"] = 367,
		["444"] = 367,
		["446"] = 364,
		["447"] = 351,
		["448"] = 344,
		["449"] = 344,
		["450"] = 344,
		["451"] = 344,
		["452"] = 344,
		["453"] = 344,
		["454"] = 344,
		["455"] = 351,
		["457"] = 351,
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
h.bloodseeker_talent = c()
local r = h.bloodseeker_talent
r.name = "bloodseeker_talent"
d(r, j)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_bloodseeker_talent"
end
r = e({ k(nil) }, r)
h.bloodseeker_talent = r
h.modifier_bloodseeker_talent = c()
local s = h.modifier_bloodseeker_talent
s.name = "modifier_bloodseeker_talent"
d(s, m)
function s.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("bloodseeker_talent_4", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.silent_chance = self:GetAbilitySpecialValueFor("silent_chance")
	self.silent_duration = self:GetAbilitySpecialValueFor("silent_duration")
	self.reply_pct = self:GetAbilitySpecialValueFor("reply_pct")
	self.reply_max = self:GetAbilitySpecialValueFor("reply_max")
		+ self:GetAbilityTalentValue("bloodseeker_talent_2", "heal_limit_bonus")
		+ self:GetAbilityTalentValue("bloodseeker_talent_5", "limit_bonus")
end
function s.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function s.prototype.OnBattleStart(self, t)
	if IsServer() then
		self:CreateTalentParticle()
		self:StartIntervalThink(self.interval)
		if self:HasTalent("bloodseeker_talent_3") then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_bloodseeker_talent_3", {})
		end
		if self:HasTalent("bloodseeker_talent_5") then
			self.parent:AddNewModifier(
				self.parent,
				self.parent:FindAbilityByName("bloodseeker_ult"),
				"modifier_bloodseeker_ult",
				{ duration = 50 }
			)
		end
		if self:HasTalent("bloodseeker_talent_6") then
			EmitSoundOn("hero_bloodseeker.rupture", self.parent:GetEnemy())
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_bloodseeker_talent_6", {})
		end
	end
end
function s.prototype.OnBattleEnd(self, t)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function s.prototype.OnCustomTakeDamage(self, u)
	local v = self:GetParent()
	if u.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE and u.target == v:GetEnemy() then
		local w = math.min(u.damage * self.reply_pct * 0.01, self.reply_max)
		Heal(v, w, "bloodseeker_talent", "Ability")
	end
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY }
end
function s.prototype.EOM_GetModifierHealAmplity(self)
	if self:HasTalent("bloodseeker_talent_2") and not f(AbilityShop.pickList, "sect_regen") then
		return -BUFF_VALUE.RegenDisablePct
	end
end
function s.prototype.CreateTalentParticle(self)
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_6)
	GameTimer(0.5, function()
		EmitSoundOn("Hero_Bloodseeker.BloodRite.Cast", self.parent)
		self.particleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_bloodseeker/bloodseeker_spell_bloodbath_bubbles.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent:GetEnemy()
		)
		ParticleManager:SetParticleControl(self.particleID, 0, self.parent:GetEnemy():GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particleID, 1, Vector(500, 500, 500))
	end)
end
function s.prototype.OnIntervalThink(self)
	if IsServer() then
		local v = self:GetParent()
		local x = v:GetEnemy()
		if not IsInjurable(v, x) then
			return
		end
		ParticleManager:DestroyParticle(self.particleID, false)
		ParticleManager:ReleaseParticleIndex(self.particleID)
		GameTimer(1, function()
			self:CreateTalentParticle()
		end)
		local y = 0
		if self:HasTalent("bloodseeker_talent_4") then
			local z = v:FindAbilityByName("bloodseeker_ult")
			local A = self:GetAbilityTalentValue("bloodseeker_talent_4", "count")
			if z and A > 0 then
				local B = z:GetSpecialValueFor("damage_pudg")
					+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
				y = x:GetMaxHealth() * B * 0.01 * A
			end
		end
		v:DealDamage(x, self:GetAbility(), self.damage + y, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
		if self:PRD(self.silent_chance) then
			AddSilence(v, x, self:GetAbility(), self.silent_duration)
		end
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() then
		if self.particleID then
			ParticleManager:DestroyParticle(self.particleID, false)
			ParticleManager:ReleaseParticleIndex(self.particleID)
		end
		self:StartIntervalThink(-1)
	end
end
s = e(
	{
		n(
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
	s
)
h.modifier_bloodseeker_talent = s
h.bloodseeker_ult = c()
local C = h.bloodseeker_ult
C.name = "bloodseeker_ult"
d(C, p)
function C.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	local E = self:GetSpecialValueFor("ult_duration")
	D:EmitSound("Hero_Bloodseeker.Bloodrage")
	D:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	EmitSoundOn("hero_bloodseeker.bloodRage", self:GetCaster())
	D:AddNewModifier(D, self, "modifier_bloodseeker_ult", { duration = E })
end
C = e({ q(nil) }, C)
h.bloodseeker_ult = C
h.modifier_bloodseeker_ult = c()
local F = h.modifier_bloodseeker_ult
F.name = "modifier_bloodseeker_ult"
d(F, m)
function F.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.damage_pudg = self:GetAbilitySpecialValueFor("damage_pudg")
		+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
end
function F.prototype.OnCreated(self, t)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
	end
end
function F.prototype.OnRefresh(self, t)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function F.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function F.prototype.OnIntervalThink(self)
	if IsServer() then
		local v = self:GetParent()
		local G = v:GetMaxHealth() * self.health_pct * 0.01
		v:DealDamage(v, self:GetAbility(), G, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE, DamageFlags.DAMAGE_FLAG_HPLOSS)
	end
end
function F.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function F.prototype.OnCustomAttackLanded(self, u)
	if IsServer() then
		local H = u.target:GetMaxHealth() * self.damage_pudg * 0.01
		u.attacker:DealDamage(u.target, self:GetAbility(), H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
end
function F.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function F.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return self.attack_speed * self:GetStackCount()
end
F = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
				GetStatusEffectName = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf",
			}
		),
	},
	F
)
h.modifier_bloodseeker_ult = F
h.modifier_bloodseeker_talent_3 = c()
local I = h.modifier_bloodseeker_talent_3
I.name = "modifier_bloodseeker_talent_3"
d(I, m)
function I.prototype.GetAbilitySpecialValue(self)
	self.health_loss = self:GetAbilityTalentValue("bloodseeker_talent_3", "health_loss")
	self.attack_speed = self:GetAbilityTalentValue("bloodseeker_talent_3", "attack_speed")
	self.reply_extra = self:GetAbilityTalentValue("bloodseeker_talent_3", "reply_extra")
end
function I.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function I.prototype.OnIntervalThink(self)
	local x = self:GetParent():GetEnemy()
	if IsValid(x) then
		local J = x:GetMaxHealth() * self.health_loss * 0.01
		if J > 0 then
			self:SetStackCount(math.floor(x:GetHealthDeficit() / J))
		end
	else
		self:SetStackCount(0)
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function I.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS,
	}
end
function I.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return self.attack_speed * self:GetStackCount()
end
function I.prototype.EOM_GetModifierHeal_Bonus(self, t)
	return self.reply_extra * self:GetStackCount()
end
I = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	I
)
h.modifier_bloodseeker_talent_3 = I
h.modifier_bloodseeker_talent_6 = c()
local K = h.modifier_bloodseeker_talent_6
K.name = "modifier_bloodseeker_talent_6"
d(K, m)
function K.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = 0
end
function K.prototype.GetAbilitySpecialValue(self)
	local z = self:GetParent():FindAbilityByName("bloodseeker_ult")
	self.count = self:GetAbilityTalentValue("bloodseeker_talent_6", "count")
	if z then
		self.damage_pudg = z:GetSpecialValueFor("damage_pudg")
			+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
	end
end
function K.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self.parent:GetEnemy(), -1 },
	}
end
function K.prototype.OnCustomAttackLanded(self, u)
	if IsServer() then
		self.record = self.record + 1
		if self.record >= self.count then
			self:tryRupture(u.attacker)
			self.record = 0
		end
	end
end
function K.prototype.OnCustomAbilityFullyCast(self, u)
	if IsServer() then
		local x = self:GetParent():GetEnemy()
		if IsValid(x) and u.ability == x:GetAbilityByIndex(1) then
			self:tryRupture(x)
		end
	end
end
function K.prototype.tryRupture(self, L)
	local v = self:GetParent()
	local x = v:GetEnemy()
	if L ~= x then
		return
	end
	if not IsInjurable(v, x) then
		return
	end
	local H = x:GetMaxHealth() * self.damage_pudg * 0.01
	v:DealDamage(x, self.parent:FindAbilityByName("bloodseeker_rupture"), H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
end
K = e(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/units/heroes/hero_bloodseeker/bloodseeker_rupture.vpcf",
			}
		),
	},
	K
)
h.modifier_bloodseeker_talent_6 = K
h.bloodseeker_shard = c()
local M = h.bloodseeker_shard
M.name = "bloodseeker_shard"
d(M, j)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_bloodseeker_shard"
end
M = e({ k(nil) }, M)
h.bloodseeker_shard = M
h.modifier_bloodseeker_shard = c()
local N = h.modifier_bloodseeker_shard
N.name = "modifier_bloodseeker_shard"
d(N, m)
function N.prototype.GetAbilitySpecialValue(self)
	self.regen_health_pct = self:GetAbilitySpecialValueFor("regen_health_pct")
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { self.parent, -1 } }
end
function N.prototype.OnWispDie(self, t)
	if IsServer() and not t.remove and IsValid(t.wisp) then
		local w = t.wisp:GetMaxHealth() * self.regen_health_pct * 0.01
		Heal(self:GetParent(), w, "bloodseeker_shard", "Ability")
	end
end
N = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
h.modifier_bloodseeker_shard = N
return h