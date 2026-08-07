--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["203"] = 141,
		["204"] = 142,
		["205"] = 144,
		["206"] = 145,
		["207"] = 146,
		["208"] = 146,
		["209"] = 146,
		["210"] = 146,
		["211"] = 148,
		["212"] = 149,
		["213"] = 150,
		["214"] = 150,
		["215"] = 150,
		["216"] = 150,
		["218"] = 152,
		["220"] = 137,
		["221"] = 136,
		["222"] = 135,
		["223"] = 136,
		["225"] = 136,
		["226"] = 159,
		["227"] = 168,
		["228"] = 159,
		["229"] = 168,
		["230"] = 174,
		["231"] = 175,
		["232"] = 176,
		["233"] = 177,
		["234"] = 178,
		["235"] = 174,
		["236"] = 181,
		["237"] = 182,
		["238"] = 183,
		["240"] = 181,
		["241"] = 187,
		["242"] = 188,
		["243"] = 189,
		["245"] = 187,
		["246"] = 193,
		["247"] = 194,
		["248"] = 195,
		["249"] = 197,
		["250"] = 198,
		["251"] = 198,
		["252"] = 198,
		["253"] = 198,
		["254"] = 198,
		["255"] = 198,
		["256"] = 198,
		["258"] = 193,
		["259"] = 202,
		["260"] = 203,
		["261"] = 204,
		["262"] = 204,
		["263"] = 203,
		["264"] = 202,
		["265"] = 208,
		["266"] = 209,
		["267"] = 211,
		["268"] = 212,
		["269"] = 212,
		["270"] = 212,
		["271"] = 212,
		["272"] = 212,
		["273"] = 212,
		["275"] = 208,
		["276"] = 216,
		["277"] = 217,
		["278"] = 216,
		["279"] = 222,
		["280"] = 223,
		["281"] = 222,
		["282"] = 168,
		["283"] = 159,
		["284"] = 159,
		["285"] = 159,
		["286"] = 159,
		["287"] = 159,
		["288"] = 159,
		["289"] = 159,
		["290"] = 159,
		["291"] = 159,
		["292"] = 168,
		["294"] = 168,
		["295"] = 228,
		["296"] = 235,
		["297"] = 228,
		["298"] = 235,
		["299"] = 239,
		["300"] = 240,
		["301"] = 241,
		["302"] = 242,
		["303"] = 239,
		["304"] = 244,
		["305"] = 245,
		["306"] = 246,
		["308"] = 244,
		["309"] = 249,
		["310"] = 250,
		["311"] = 251,
		["312"] = 252,
		["313"] = 253,
		["314"] = 254,
		["317"] = 257,
		["319"] = 249,
		["320"] = 260,
		["321"] = 261,
		["322"] = 262,
		["324"] = 260,
		["325"] = 265,
		["326"] = 266,
		["327"] = 265,
		["328"] = 271,
		["329"] = 272,
		["330"] = 271,
		["331"] = 274,
		["332"] = 275,
		["333"] = 274,
		["334"] = 235,
		["335"] = 228,
		["336"] = 228,
		["337"] = 228,
		["338"] = 228,
		["339"] = 228,
		["340"] = 228,
		["341"] = 228,
		["342"] = 235,
		["344"] = 235,
		["345"] = 280,
		["346"] = 288,
		["347"] = 280,
		["348"] = 288,
		["350"] = 288,
		["351"] = 291,
		["352"] = 280,
		["353"] = 293,
		["354"] = 294,
		["355"] = 295,
		["356"] = 296,
		["357"] = 297,
		["359"] = 293,
		["360"] = 301,
		["361"] = 302,
		["362"] = 303,
		["363"] = 303,
		["364"] = 303,
		["365"] = 302,
		["366"] = 304,
		["367"] = 304,
		["368"] = 304,
		["369"] = 302,
		["370"] = 302,
		["371"] = 301,
		["372"] = 308,
		["373"] = 309,
		["374"] = 310,
		["375"] = 311,
		["376"] = 312,
		["377"] = 313,
		["380"] = 308,
		["381"] = 318,
		["382"] = 319,
		["383"] = 320,
		["384"] = 321,
		["385"] = 322,
		["388"] = 318,
		["389"] = 327,
		["390"] = 328,
		["391"] = 329,
		["392"] = 330,
		["395"] = 331,
		["398"] = 333,
		["399"] = 334,
		["400"] = 334,
		["401"] = 334,
		["402"] = 334,
		["403"] = 334,
		["404"] = 334,
		["405"] = 327,
		["406"] = 288,
		["407"] = 280,
		["408"] = 280,
		["409"] = 280,
		["410"] = 280,
		["411"] = 280,
		["412"] = 280,
		["413"] = 280,
		["414"] = 280,
		["415"] = 288,
		["417"] = 288,
		["418"] = 339,
		["419"] = 340,
		["420"] = 339,
		["421"] = 340,
		["422"] = 341,
		["423"] = 342,
		["424"] = 341,
		["425"] = 340,
		["426"] = 339,
		["427"] = 340,
		["429"] = 340,
		["430"] = 346,
		["431"] = 353,
		["432"] = 346,
		["433"] = 353,
		["434"] = 356,
		["435"] = 357,
		["436"] = 356,
		["437"] = 360,
		["438"] = 361,
		["439"] = 362,
		["440"] = 362,
		["441"] = 361,
		["442"] = 360,
		["443"] = 366,
		["444"] = 367,
		["445"] = 368,
		["446"] = 369,
		["447"] = 369,
		["448"] = 369,
		["449"] = 369,
		["450"] = 369,
		["451"] = 369,
		["453"] = 366,
		["454"] = 353,
		["455"] = 346,
		["456"] = 346,
		["457"] = 346,
		["458"] = 346,
		["459"] = 346,
		["460"] = 346,
		["461"] = 346,
		["462"] = 353,
		["464"] = 353,
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
				{}
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
			AddSilence(x, v, self:GetAbility(), self.silent_duration)
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
	if self:HasTalent("bloodseeker_talent_5") then
		return
	end
	local D = self:GetCaster()
	local E = self:GetSpecialValueFor("ult_duration")
	D:EmitSound("Hero_Bloodseeker.Bloodrage")
	D:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	EmitSoundOn("hero_bloodseeker.bloodRage", self:GetCaster())
	local F = D:FindModifierByName("modifier_bloodseeker_ult")
	if F then
		F:SetDuration(F:GetRemainingTime() + E, true)
	else
		D:AddNewModifier(D, self, "modifier_bloodseeker_ult", { duration = E })
	end
end
C = e({ q(nil) }, C)
h.bloodseeker_ult = C
h.modifier_bloodseeker_ult = c()
local G = h.modifier_bloodseeker_ult
G.name = "modifier_bloodseeker_ult"
d(G, m)
function G.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.damage_pudg = self:GetAbilitySpecialValueFor("damage_pudg")
		+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
end
function G.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function G.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function G.prototype.OnIntervalThink(self)
	if IsServer() then
		local v = self:GetParent()
		local H = v:GetMaxHealth() * self.health_pct * 0.01
		v:DealDamage(v, self:GetAbility(), H, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE, DamageFlags.DAMAGE_FLAG_HPLOSS)
	end
end
function G.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function G.prototype.OnCustomAttackLanded(self, u)
	if IsServer() then
		local I = u.target:GetMaxHealth() * self.damage_pudg * 0.01
		u.attacker:DealDamage(u.target, self:GetAbility(), I, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function G.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return self.attack_speed
end
G = e(
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
				GetStatusEffectName = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf",
			}
		),
	},
	G
)
h.modifier_bloodseeker_ult = G
h.modifier_bloodseeker_talent_3 = c()
local J = h.modifier_bloodseeker_talent_3
J.name = "modifier_bloodseeker_talent_3"
d(J, m)
function J.prototype.GetAbilitySpecialValue(self)
	self.health_loss = self:GetAbilityTalentValue("bloodseeker_talent_3", "health_loss")
	self.attack_speed = self:GetAbilityTalentValue("bloodseeker_talent_3", "attack_speed")
	self.reply_extra = self:GetAbilityTalentValue("bloodseeker_talent_3", "reply_extra")
end
function J.prototype.OnCreated(self, t)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function J.prototype.OnIntervalThink(self)
	local x = self:GetParent():GetEnemy()
	if IsValid(x) then
		local K = x:GetMaxHealth() * self.health_loss * 0.01
		if K > 0 then
			self:SetStackCount(math.floor(x:GetHealthDeficit() / K))
		end
	else
		self:SetStackCount(0)
	end
end
function J.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function J.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS,
	}
end
function J.prototype.EOM_GetModifierAttackSpeedBonus(self, t)
	return self.attack_speed * self:GetStackCount()
end
function J.prototype.EOM_GetModifierHeal_Bonus(self, t)
	return self.reply_extra * self:GetStackCount()
end
J = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	J
)
h.modifier_bloodseeker_talent_3 = J
h.modifier_bloodseeker_talent_6 = c()
local L = h.modifier_bloodseeker_talent_6
L.name = "modifier_bloodseeker_talent_6"
d(L, m)
function L.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.record = 0
end
function L.prototype.GetAbilitySpecialValue(self)
	local z = self:GetParent():FindAbilityByName("bloodseeker_ult")
	self.count = self:GetAbilityTalentValue("bloodseeker_talent_6", "count")
	if z then
		self.damage_pudg = z:GetSpecialValueFor("damage_pudg")
			+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
	end
end
function L.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self.parent:GetEnemy(), -1 },
	}
end
function L.prototype.OnCustomAttackLanded(self, u)
	if IsServer() then
		self.record = self.record + 1
		if self.record >= self.count then
			self:tryRupture(u.attacker)
			self.record = 0
		end
	end
end
function L.prototype.OnCustomAbilityFullyCast(self, u)
	if IsServer() then
		local x = self:GetParent():GetEnemy()
		if IsValid(x) and u.ability == x:GetAbilityByIndex(1) then
			self:tryRupture(x)
		end
	end
end
function L.prototype.tryRupture(self, M)
	local v = self:GetParent()
	local x = v:GetEnemy()
	if M ~= x then
		return
	end
	if not IsInjurable(v, x) then
		return
	end
	local I = x:GetMaxHealth() * self.damage_pudg * 0.01
	v:DealDamage(x, self.parent:FindAbilityByName("bloodseeker_rupture"), I, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
end
L = e(
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
	L
)
h.modifier_bloodseeker_talent_6 = L
h.bloodseeker_shard = c()
local N = h.bloodseeker_shard
N.name = "bloodseeker_shard"
d(N, j)
function N.prototype.GetIntrinsicModifierName(self)
	return "modifier_bloodseeker_shard"
end
N = e({ k(nil) }, N)
h.bloodseeker_shard = N
h.modifier_bloodseeker_shard = c()
local O = h.modifier_bloodseeker_shard
O.name = "modifier_bloodseeker_shard"
d(O, m)
function O.prototype.GetAbilitySpecialValue(self)
	self.regen_health_pct = self:GetAbilitySpecialValueFor("regen_health_pct")
end
function O.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, self:GetParent():GetEnemy() } }
end
function O.prototype.OnWispDie(self, t)
	if IsServer() and not t.remove and IsValid(t.wisp) then
		local w = t.wisp:GetMaxHealth() * self.regen_health_pct * 0.01
		Heal(self:GetParent(), w, "bloodseeker_shard", "Ability")
	end
end
O = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	O
)
h.modifier_bloodseeker_shard = O
return h