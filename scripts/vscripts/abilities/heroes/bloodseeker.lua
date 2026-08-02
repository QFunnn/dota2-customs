--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/bloodseeker"
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
		["60"] = 51,
		["61"] = 51,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["66"] = 53,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 54,
		["72"] = 54,
		["74"] = 56,
		["75"] = 57,
		["76"] = 57,
		["77"] = 57,
		["78"] = 57,
		["79"] = 57,
		["80"] = 57,
		["83"] = 47,
		["84"] = 61,
		["85"] = 62,
		["86"] = 63,
		["88"] = 61,
		["89"] = 66,
		["90"] = 67,
		["91"] = 68,
		["92"] = 69,
		["93"] = 70,
		["95"] = 66,
		["96"] = 74,
		["97"] = 75,
		["98"] = 76,
		["99"] = 77,
		["100"] = 78,
		["103"] = 81,
		["104"] = 81,
		["105"] = 81,
		["106"] = 81,
		["107"] = 81,
		["108"] = 81,
		["109"] = 84,
		["110"] = 85,
		["111"] = 85,
		["112"] = 85,
		["113"] = 85,
		["114"] = 85,
		["115"] = 85,
		["118"] = 74,
		["119"] = 90,
		["120"] = 91,
		["121"] = 90,
		["122"] = 93,
		["123"] = 94,
		["124"] = 95,
		["126"] = 93,
		["127"] = 98,
		["128"] = 99,
		["129"] = 100,
		["131"] = 98,
		["132"] = 23,
		["133"] = 15,
		["134"] = 15,
		["135"] = 15,
		["136"] = 15,
		["137"] = 15,
		["138"] = 15,
		["139"] = 15,
		["140"] = 15,
		["141"] = 23,
		["143"] = 23,
		["145"] = 107,
		["146"] = 108,
		["147"] = 107,
		["148"] = 108,
		["149"] = 109,
		["150"] = 110,
		["153"] = 113,
		["154"] = 114,
		["155"] = 116,
		["156"] = 119,
		["157"] = 120,
		["158"] = 121,
		["159"] = 121,
		["160"] = 121,
		["161"] = 121,
		["163"] = 123,
		["165"] = 109,
		["166"] = 108,
		["167"] = 107,
		["168"] = 108,
		["170"] = 108,
		["171"] = 130,
		["172"] = 138,
		["173"] = 130,
		["174"] = 138,
		["175"] = 144,
		["176"] = 145,
		["177"] = 146,
		["178"] = 147,
		["179"] = 148,
		["180"] = 144,
		["181"] = 151,
		["182"] = 152,
		["183"] = 153,
		["185"] = 151,
		["186"] = 157,
		["187"] = 158,
		["188"] = 159,
		["190"] = 157,
		["191"] = 163,
		["192"] = 164,
		["193"] = 165,
		["194"] = 167,
		["195"] = 168,
		["196"] = 168,
		["197"] = 168,
		["198"] = 168,
		["199"] = 168,
		["200"] = 168,
		["201"] = 168,
		["203"] = 163,
		["204"] = 172,
		["205"] = 173,
		["206"] = 174,
		["207"] = 174,
		["208"] = 173,
		["209"] = 172,
		["210"] = 178,
		["211"] = 179,
		["212"] = 181,
		["213"] = 182,
		["214"] = 182,
		["215"] = 182,
		["216"] = 182,
		["217"] = 182,
		["218"] = 182,
		["220"] = 178,
		["221"] = 186,
		["222"] = 187,
		["223"] = 186,
		["224"] = 192,
		["225"] = 193,
		["226"] = 192,
		["227"] = 138,
		["228"] = 130,
		["229"] = 130,
		["230"] = 130,
		["231"] = 130,
		["232"] = 130,
		["233"] = 130,
		["234"] = 130,
		["235"] = 130,
		["236"] = 138,
		["238"] = 138,
		["239"] = 198,
		["240"] = 205,
		["241"] = 198,
		["242"] = 205,
		["244"] = 205,
		["245"] = 209,
		["246"] = 198,
		["247"] = 210,
		["248"] = 211,
		["249"] = 212,
		["250"] = 213,
		["251"] = 210,
		["252"] = 215,
		["253"] = 215,
		["254"] = 217,
		["255"] = 218,
		["256"] = 219,
		["257"] = 219,
		["258"] = 218,
		["259"] = 217,
		["260"] = 222,
		["261"] = 223,
		["262"] = 224,
		["263"] = 225,
		["264"] = 226,
		["265"] = 227,
		["266"] = 228,
		["269"] = 222,
		["270"] = 232,
		["271"] = 233,
		["272"] = 232,
		["273"] = 238,
		["274"] = 239,
		["275"] = 238,
		["276"] = 241,
		["277"] = 242,
		["278"] = 241,
		["279"] = 205,
		["280"] = 198,
		["281"] = 198,
		["282"] = 198,
		["283"] = 198,
		["284"] = 198,
		["285"] = 198,
		["286"] = 198,
		["287"] = 205,
		["289"] = 205,
		["290"] = 247,
		["291"] = 254,
		["292"] = 247,
		["293"] = 254,
		["294"] = 257,
		["295"] = 258,
		["296"] = 259,
		["297"] = 260,
		["299"] = 257,
		["300"] = 264,
		["301"] = 265,
		["302"] = 266,
		["303"] = 266,
		["304"] = 266,
		["305"] = 265,
		["306"] = 267,
		["307"] = 267,
		["308"] = 267,
		["309"] = 265,
		["310"] = 265,
		["311"] = 264,
		["312"] = 271,
		["313"] = 272,
		["314"] = 273,
		["316"] = 271,
		["317"] = 277,
		["318"] = 278,
		["319"] = 279,
		["321"] = 277,
		["322"] = 283,
		["323"] = 284,
		["324"] = 285,
		["325"] = 286,
		["328"] = 287,
		["331"] = 289,
		["332"] = 290,
		["333"] = 290,
		["334"] = 290,
		["335"] = 290,
		["336"] = 290,
		["337"] = 290,
		["338"] = 283,
		["339"] = 254,
		["340"] = 247,
		["341"] = 247,
		["342"] = 247,
		["343"] = 247,
		["344"] = 247,
		["345"] = 247,
		["346"] = 247,
		["347"] = 254,
		["349"] = 254,
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
g.bloodseeker_talent = c()
local q = g.bloodseeker_talent
q.name = "bloodseeker_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_bloodseeker_talent"
end
q = e({ j(nil) }, q)
g.bloodseeker_talent = q
g.modifier_bloodseeker_talent = c()
local r = g.modifier_bloodseeker_talent
r.name = "modifier_bloodseeker_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("bloodseeker_talent_4", "interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("bloodseeker_talent_4", "talent_damage_bonus")
	self.silent_chance = self:GetAbilitySpecialValueFor("silent_chance")
	self.silent_duration = self:GetAbilitySpecialValueFor("silent_duration")
	self.reply_pct = self:GetAbilitySpecialValueFor("reply_pct")
	self.reply_max = self:GetAbilitySpecialValueFor("reply_max")
		+ self:GetAbilityTalentValue("bloodseeker_talent_2", "heal_limit_bonus")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStart(self, s)
	if IsServer() then
		self:StartIntervalThink(self.interval)
		if self:HasTalent("bloodseeker_talent_3") then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_bloodseeker_talent_3", {})
		end
		if self:HasTalent("bloodseeker_talent_5") then
			self.parent:AddNewModifier(
				self.parent,
				self.parent:FindAbilityByName("bloodseeker_ult"),
				"modifier_bloodseeker_ult",
				{}
			)
		end
		if self:HasTalent("bloodseeker_talent_6") then
			self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_bloodseeker_talent_6", {})
		end
	end
end
function r.prototype.OnBattleEnd(self, s)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function r.prototype.OnCustomTakeDamage(self, t)
	if t.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE then
		local u = self:GetParent()
		local v = math.min(t.damage * self.reply_pct * 0.01, self.reply_max)
		Heal(u, v, "bloodseeker_talent", "Ability")
	end
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		local u = self:GetParent()
		local w = u:GetEnemy()
		if not IsInjurable(u, w) then
			return
		end
		u:DealDamage(w, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
		if self:PRD(self.silent_chance) then
			AddSilence(w, u, self:GetAbility(), self.silent_duration)
		end
	end
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY }
end
function r.prototype.EOM_GetModifierHealAmplity(self, s)
	if self:HasTalent("bloodseeker_talent_2") then
		return 30
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
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
g.modifier_bloodseeker_talent = r
g.bloodseeker_ult = c()
local x = g.bloodseeker_ult
x.name = "bloodseeker_ult"
d(x, o)
function x.prototype.OnSpellStart(self)
	if self:HasTalent("bloodseeker_talent_5") then
		return
	end
	local y = self:GetCaster()
	local z = self:GetSpecialValueFor("ult_duration")
	y:EmitSound("Hero_Bloodseeker.Bloodrage")
	local A = y:FindModifierByName("modifier_bloodseeker_ult")
	if A then
		A:SetDuration(A:GetRemainingTime() + z, true)
	else
		y:AddNewModifier(y, self, "modifier_bloodseeker_ult", { duration = z })
	end
end
x = e({ p(nil) }, x)
g.bloodseeker_ult = x
g.modifier_bloodseeker_ult = c()
local B = g.modifier_bloodseeker_ult
B.name = "modifier_bloodseeker_ult"
d(B, l)
function B.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
		- self:GetAbilityTalentValue("bloodseeker_talent_1", "health_reduce")
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.damage_pudg = self:GetAbilitySpecialValueFor("damage_pudg")
end
function B.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function B.prototype.OnIntervalThink(self)
	if IsServer() then
		local u = self:GetParent()
		local C = u:GetMaxHealth() * self.health_pct * 0.01
		u:DealDamage(u, self:GetAbility(), C, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE, DamageFlags.DAMAGE_FLAG_HPLOSS)
	end
end
function B.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function B.prototype.OnCustomAttackLanded(self, t)
	if IsServer() then
		local D = t.target:GetMaxHealth() * self.damage_pudg * 0.01
		t.attacker:DealDamage(t.target, self:GetAbility(), D, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
end
function B.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function B.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.attack_speed
end
B = e(
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
	B
)
g.modifier_bloodseeker_ult = B
g.modifier_bloodseeker_talent_3 = c()
local E = g.modifier_bloodseeker_talent_3
E.name = "modifier_bloodseeker_talent_3"
d(E, l)
function E.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.health_loss_record = 0
end
function E.prototype.GetAbilitySpecialValue(self)
	self.health_loss = self:GetAbilityTalentValue("bloodseeker_talent_3", "health_loss")
	self.attack_speed = self:GetAbilityTalentValue("bloodseeker_talent_3", "attack_speed")
	self.reply_extra = self:GetAbilityTalentValue("bloodseeker_talent_3", "reply_extra")
end
function E.prototype.OnCreated(self, s) end
function E.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 } }
end
function E.prototype.OnCustomTakeDamage(self, t)
	self.health_loss_record = self.health_loss_record + t.damage
	local w = self:GetParent():GetEnemy()
	if w then
		local F = w:GetMaxHealth() * self.health_loss * 0.01
		if F > 0 then
			self:SetStackCount(math.floor(self.health_loss_record / F))
		end
	end
end
function E.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS,
	}
end
function E.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.attack_speed * self:GetStackCount()
end
function E.prototype.EOM_GetModifierHeal_Bonus(self, s)
	return self.reply_extra * self:GetStackCount()
end
E = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	E
)
g.modifier_bloodseeker_talent_3 = E
g.modifier_bloodseeker_talent_6 = c()
local G = g.modifier_bloodseeker_talent_6
G.name = "modifier_bloodseeker_talent_6"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	local H = self:GetParent():FindAbilityByName("bloodseeker_ult")
	if H then
		self.damage_pudg = H:GetSpecialValueFor("damage_pudg")
	end
end
function G.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self.parent:GetEnemy(), -1 },
	}
end
function G.prototype.OnCustomAttackLanded(self, t)
	if IsServer() then
		self:tryRupture(t.attacker)
	end
end
function G.prototype.OnCustomAbilityFullyCast(self, t)
	if IsServer() then
		self:tryRupture(t.ability:GetCaster())
	end
end
function G.prototype.tryRupture(self, I)
	local u = self:GetParent()
	local w = u:GetEnemy()
	if I ~= w then
		return
	end
	if not IsInjurable(u, w) then
		return
	end
	local D = w:GetMaxHealth() * self.damage_pudg * 0.01
	u:DealDamage(w, self.parent:FindAbilityByName("bloodseeker_rupture"), D, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
end
G = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	G
)
g.modifier_bloodseeker_talent_6 = G
return g