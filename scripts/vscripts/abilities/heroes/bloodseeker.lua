--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/bloodseeker"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayFilter
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 10,
		["25"] = 9,
		["26"] = 8,
		["27"] = 7,
		["28"] = 8,
		["30"] = 8,
		["31"] = 14,
		["32"] = 22,
		["33"] = 14,
		["34"] = 22,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["44"] = 33,
		["45"] = 44,
		["46"] = 45,
		["47"] = 45,
		["48"] = 47,
		["49"] = 47,
		["50"] = 47,
		["51"] = 45,
		["52"] = 48,
		["53"] = 48,
		["54"] = 48,
		["55"] = 45,
		["56"] = 45,
		["57"] = 44,
		["58"] = 51,
		["59"] = 52,
		["60"] = 53,
		["61"] = 54,
		["62"] = 55,
		["63"] = 56,
		["64"] = 56,
		["65"] = 56,
		["66"] = 56,
		["67"] = 57,
		["68"] = 58,
		["69"] = 58,
		["70"] = 58,
		["71"] = 58,
		["72"] = 58,
		["73"] = 58,
		["75"] = 60,
		["76"] = 61,
		["77"] = 61,
		["78"] = 61,
		["79"] = 61,
		["80"] = 61,
		["81"] = 61,
		["83"] = 63,
		["84"] = 64,
		["85"] = 64,
		["86"] = 64,
		["87"] = 64,
		["88"] = 65,
		["89"] = 65,
		["90"] = 65,
		["91"] = 65,
		["92"] = 65,
		["93"] = 65,
		["96"] = 51,
		["97"] = 69,
		["98"] = 70,
		["99"] = 71,
		["101"] = 69,
		["102"] = 74,
		["103"] = 75,
		["104"] = 76,
		["105"] = 77,
		["106"] = 78,
		["108"] = 74,
		["109"] = 81,
		["110"] = 82,
		["111"] = 81,
		["112"] = 84,
		["113"] = 85,
		["114"] = 86,
		["116"] = 84,
		["117"] = 89,
		["118"] = 90,
		["119"] = 91,
		["120"] = 91,
		["121"] = 91,
		["122"] = 92,
		["123"] = 93,
		["124"] = 93,
		["125"] = 93,
		["126"] = 93,
		["127"] = 93,
		["128"] = 94,
		["129"] = 94,
		["130"] = 94,
		["131"] = 94,
		["132"] = 94,
		["133"] = 95,
		["134"] = 95,
		["135"] = 95,
		["136"] = 95,
		["137"] = 95,
		["138"] = 91,
		["139"] = 91,
		["140"] = 89,
		["141"] = 99,
		["142"] = 100,
		["143"] = 101,
		["144"] = 102,
		["145"] = 103,
		["148"] = 104,
		["149"] = 105,
		["150"] = 106,
		["151"] = 106,
		["152"] = 106,
		["153"] = 107,
		["154"] = 106,
		["155"] = 106,
		["156"] = 110,
		["157"] = 111,
		["158"] = 112,
		["159"] = 113,
		["160"] = 114,
		["161"] = 115,
		["162"] = 116,
		["165"] = 119,
		["166"] = 119,
		["167"] = 119,
		["168"] = 119,
		["169"] = 119,
		["170"] = 119,
		["171"] = 122,
		["172"] = 123,
		["173"] = 123,
		["174"] = 123,
		["175"] = 123,
		["176"] = 123,
		["177"] = 123,
		["180"] = 99,
		["181"] = 128,
		["182"] = 129,
		["183"] = 130,
		["184"] = 131,
		["185"] = 132,
		["187"] = 134,
		["189"] = 128,
		["190"] = 22,
		["191"] = 14,
		["192"] = 14,
		["193"] = 14,
		["194"] = 14,
		["195"] = 14,
		["196"] = 14,
		["197"] = 14,
		["198"] = 14,
		["199"] = 22,
		["201"] = 22,
		["203"] = 141,
		["204"] = 142,
		["205"] = 141,
		["206"] = 142,
		["207"] = 143,
		["208"] = 144,
		["209"] = 145,
		["210"] = 147,
		["211"] = 148,
		["212"] = 149,
		["213"] = 149,
		["214"] = 149,
		["215"] = 149,
		["216"] = 150,
		["217"] = 143,
		["218"] = 142,
		["219"] = 141,
		["220"] = 142,
		["222"] = 142,
		["223"] = 157,
		["224"] = 167,
		["225"] = 157,
		["226"] = 167,
		["227"] = 173,
		["228"] = 174,
		["229"] = 175,
		["230"] = 176,
		["231"] = 177,
		["232"] = 173,
		["233"] = 180,
		["234"] = 181,
		["235"] = 182,
		["236"] = 183,
		["238"] = 180,
		["239"] = 186,
		["240"] = 187,
		["241"] = 188,
		["243"] = 186,
		["244"] = 191,
		["245"] = 192,
		["246"] = 193,
		["248"] = 191,
		["249"] = 197,
		["250"] = 198,
		["251"] = 199,
		["252"] = 201,
		["253"] = 202,
		["254"] = 202,
		["255"] = 202,
		["256"] = 202,
		["257"] = 202,
		["258"] = 202,
		["259"] = 202,
		["261"] = 197,
		["262"] = 206,
		["263"] = 207,
		["264"] = 208,
		["265"] = 208,
		["266"] = 207,
		["267"] = 206,
		["268"] = 212,
		["269"] = 213,
		["270"] = 215,
		["271"] = 216,
		["272"] = 216,
		["273"] = 216,
		["274"] = 216,
		["275"] = 216,
		["276"] = 216,
		["278"] = 212,
		["279"] = 220,
		["280"] = 221,
		["281"] = 220,
		["282"] = 226,
		["283"] = 227,
		["284"] = 226,
		["285"] = 167,
		["286"] = 157,
		["287"] = 157,
		["288"] = 157,
		["289"] = 157,
		["290"] = 157,
		["291"] = 157,
		["292"] = 157,
		["293"] = 157,
		["294"] = 157,
		["295"] = 157,
		["296"] = 167,
		["298"] = 167,
		["299"] = 232,
		["300"] = 239,
		["301"] = 232,
		["302"] = 239,
		["303"] = 243,
		["304"] = 244,
		["305"] = 245,
		["306"] = 246,
		["307"] = 243,
		["308"] = 248,
		["309"] = 249,
		["310"] = 250,
		["312"] = 248,
		["313"] = 253,
		["314"] = 254,
		["315"] = 255,
		["316"] = 256,
		["317"] = 257,
		["318"] = 258,
		["321"] = 261,
		["323"] = 253,
		["324"] = 264,
		["325"] = 265,
		["326"] = 266,
		["328"] = 264,
		["329"] = 269,
		["330"] = 270,
		["331"] = 269,
		["332"] = 275,
		["333"] = 276,
		["334"] = 275,
		["335"] = 278,
		["336"] = 279,
		["337"] = 278,
		["338"] = 239,
		["339"] = 232,
		["340"] = 232,
		["341"] = 232,
		["342"] = 232,
		["343"] = 232,
		["344"] = 232,
		["345"] = 232,
		["346"] = 239,
		["348"] = 239,
		["349"] = 284,
		["350"] = 292,
		["351"] = 284,
		["352"] = 292,
		["354"] = 292,
		["355"] = 295,
		["356"] = 284,
		["357"] = 297,
		["358"] = 298,
		["359"] = 299,
		["360"] = 300,
		["361"] = 301,
		["363"] = 297,
		["364"] = 305,
		["365"] = 306,
		["366"] = 307,
		["367"] = 307,
		["368"] = 307,
		["369"] = 306,
		["370"] = 308,
		["371"] = 308,
		["372"] = 308,
		["373"] = 306,
		["374"] = 306,
		["375"] = 305,
		["376"] = 312,
		["377"] = 313,
		["378"] = 314,
		["380"] = 312,
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
		["403"] = 335,
		["406"] = 336,
		["407"] = 336,
		["408"] = 338,
		["409"] = 339,
		["410"] = 339,
		["411"] = 339,
		["412"] = 339,
		["413"] = 339,
		["414"] = 339,
		["415"] = 327,
		["416"] = 292,
		["417"] = 284,
		["418"] = 284,
		["419"] = 284,
		["420"] = 284,
		["421"] = 284,
		["422"] = 284,
		["423"] = 284,
		["424"] = 284,
		["425"] = 292,
		["427"] = 292,
		["428"] = 344,
		["429"] = 345,
		["430"] = 344,
		["431"] = 345,
		["432"] = 346,
		["433"] = 347,
		["434"] = 346,
		["435"] = 345,
		["436"] = 344,
		["437"] = 345,
		["439"] = 345,
		["440"] = 351,
		["441"] = 358,
		["442"] = 351,
		["443"] = 358,
		["444"] = 361,
		["445"] = 362,
		["446"] = 361,
		["447"] = 365,
		["448"] = 366,
		["449"] = 365,
		["450"] = 371,
		["451"] = 372,
		["452"] = 373,
		["453"] = 374,
		["454"] = 374,
		["455"] = 374,
		["456"] = 374,
		["457"] = 374,
		["458"] = 374,
		["460"] = 371,
		["461"] = 358,
		["462"] = 351,
		["463"] = 351,
		["464"] = 351,
		["465"] = 351,
		["466"] = 351,
		["467"] = 351,
		["468"] = 351,
		["469"] = 358,
		["471"] = 358,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = require("abilities.ability_ai")
local q = p.BaseAbilityAI
local r = p.registerAbilityAI
i.bloodseeker_talent = c()
local s = i.bloodseeker_talent
s.name = "bloodseeker_talent"
d(s, k)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_bloodseeker_talent"
end
s = e({ l(nil) }, s)
i.bloodseeker_talent = s
i.modifier_bloodseeker_talent = c()
local t = i.modifier_bloodseeker_talent
t.name = "modifier_bloodseeker_talent"
d(t, n)
function t.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.level = self:GetAbilitySpecialValueFor("level")
	self.interval_reduce = self:GetAbilitySpecialValueFor("interval_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage")
		+ self:GetAbilityTalentValue("bloodseeker_talent_4", "damge_bonus")
	self.silent_chance = self:GetAbilityTalentValue("bloodseeker_talent_4", "chance")
	self.silent_duration = self:GetAbilityTalentValue("bloodseeker_talent_4", "duration")
	self.reply_pct = self:GetAbilitySpecialValueFor("reply_pct")
	self.reply_max = self:GetAbilitySpecialValueFor("reply_max")
		+ self:GetAbilityTalentValue("bloodseeker_talent_2", "heal_limit_bonus")
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function t.prototype.OnBattleStart(self, u)
	if IsServer() then
		self:CreateTalentParticle()
		local v = PlayerData:getHero(self.parent:GetPlayerOwnerID()):GetSectLevel("sect_health")
		local w = self.interval - math.floor(v / math.max(1, self.level)) * self.interval_reduce
		self:StartIntervalThink(math.max(FrameTime(), w))
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
function t.prototype.OnBattleEnd(self, u)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function t.prototype.OnCustomTakeDamage(self, x)
	local y = self:GetParent()
	if x.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE and x.target == y:GetEnemy() then
		local z = math.min(x.damage * self.reply_pct * 0.01, self.reply_max)
		Heal(y, z, "bloodseeker_talent", "Ability")
	end
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY }
end
function t.prototype.EOM_GetModifierHealAmplity(self)
	if self:HasTalent("bloodseeker_talent_2") and not f(AbilityShop.pickList, "sect_regen") then
		return -BUFF_VALUE.RegenDisablePct
	end
end
function t.prototype.CreateTalentParticle(self)
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
function t.prototype.OnIntervalThink(self)
	if IsServer() then
		local y = self:GetParent()
		local A = y:GetEnemy()
		if not IsInjurable(y, A) then
			return
		end
		ParticleManager:DestroyParticle(self.particleID, false)
		ParticleManager:ReleaseParticleIndex(self.particleID)
		GameTimer(1, function()
			self:CreateTalentParticle()
		end)
		local B = 0
		if self:HasTalent("bloodseeker_talent_4") then
			local C = y:FindAbilityByName("bloodseeker_ult")
			local D = self:GetAbilityTalentValue("bloodseeker_talent_4", "count")
			if C and D > 0 then
				local E = C:GetSpecialValueFor("damage_pudg")
					+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
				B = A:GetMaxHealth() * E * 0.01 * D
			end
		end
		y:DealDamage(A, self:GetAbility(), self.damage + B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
		if self:HasTalent("bloodseeker_talent_4") and self:PRD(self.silent_chance) then
			AddSilence(y, A, self:GetAbility(), self.silent_duration)
		end
	end
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		if self.particleID then
			ParticleManager:DestroyParticle(self.particleID, false)
			ParticleManager:ReleaseParticleIndex(self.particleID)
		end
		self:StartIntervalThink(-1)
	end
end
t = e(
	{
		o(
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
	t
)
i.modifier_bloodseeker_talent = t
i.bloodseeker_ult = c()
local F = i.bloodseeker_ult
F.name = "bloodseeker_ult"
d(F, q)
function F.prototype.OnSpellStart(self)
	local G = self:GetCaster()
	local H = self:GetSpecialValueFor("ult_duration")
	G:EmitSound("Hero_Bloodseeker.Bloodrage")
	G:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	EmitSoundOn("hero_bloodseeker.bloodRage", self:GetCaster())
	G:AddNewModifier(G, self, "modifier_bloodseeker_ult", { duration = H })
end
F = e({ r(nil) }, F)
i.bloodseeker_ult = F
i.modifier_bloodseeker_ult = c()
local I = i.modifier_bloodseeker_ult
I.name = "modifier_bloodseeker_ult"
d(I, n)
function I.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
		- self:GetAbilityTalentValue("bloodseeker_talent_5", "health_reduce")
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.damage_pudg = self:GetAbilitySpecialValueFor("damage_pudg")
		+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
end
function I.prototype.OnCreated(self, u)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(self.interval)
	end
end
function I.prototype.OnRefresh(self, u)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function I.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function I.prototype.OnIntervalThink(self)
	if IsServer() then
		local y = self:GetParent()
		local J = y:GetMaxHealth() * self.health_pct * 0.01
		y:DealDamage(y, self:GetAbility(), J, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE, DamageFlags.DAMAGE_FLAG_HPLOSS)
	end
end
function I.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function I.prototype.OnCustomAttackLanded(self, x)
	if IsServer() then
		local K = x.target:GetMaxHealth() * self.damage_pudg * 0.01
		x.attacker:DealDamage(x.target, self:GetAbility(), K, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
end
function I.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function I.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return self.attack_speed * self:GetStackCount()
end
I = e(
	{
		o(
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
	I
)
i.modifier_bloodseeker_ult = I
i.modifier_bloodseeker_talent_3 = c()
local L = i.modifier_bloodseeker_talent_3
L.name = "modifier_bloodseeker_talent_3"
d(L, n)
function L.prototype.GetAbilitySpecialValue(self)
	self.health_loss = self:GetAbilityTalentValue("bloodseeker_talent_3", "health_loss")
	self.attack_speed = self:GetAbilityTalentValue("bloodseeker_talent_3", "attack_speed")
	self.reply_extra = self:GetAbilityTalentValue("bloodseeker_talent_3", "reply_extra")
end
function L.prototype.OnCreated(self, u)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function L.prototype.OnIntervalThink(self)
	local A = self:GetParent():GetEnemy()
	if IsValid(A) then
		local M = A:GetMaxHealth() * self.health_loss * 0.01
		if M > 0 then
			self:SetStackCount(math.floor(A:GetHealthDeficit() / M))
		end
	else
		self:SetStackCount(0)
	end
end
function L.prototype.OnDestroy(self)
	if IsServer() then
		self:StartIntervalThink(-1)
	end
end
function L.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS,
	}
end
function L.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return self.attack_speed * self:GetStackCount()
end
function L.prototype.EOM_GetModifierHeal_Bonus(self, u)
	return self.reply_extra * self:GetStackCount()
end
L = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	L
)
i.modifier_bloodseeker_talent_3 = L
i.modifier_bloodseeker_talent_6 = c()
local N = i.modifier_bloodseeker_talent_6
N.name = "modifier_bloodseeker_talent_6"
d(N, n)
function N.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.triggerTimes = {}
end
function N.prototype.GetAbilitySpecialValue(self)
	local C = self:GetParent():FindAbilityByName("bloodseeker_ult")
	self.limit = self:GetAbilityTalentValue("bloodseeker_talent_6", "limit")
	if C then
		self.damage_pudg = C:GetSpecialValueFor("damage_pudg")
			+ self:GetAbilityTalentValue("bloodseeker_talent_1", "ult_bonus_pct")
	end
end
function N.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self.parent:GetEnemy(), -1 },
	}
end
function N.prototype.OnCustomAttackLanded(self, x)
	if IsServer() then
		self:tryRupture(x.attacker)
	end
end
function N.prototype.OnCustomAbilityFullyCast(self, x)
	if IsServer() then
		local A = self:GetParent():GetEnemy()
		if IsValid(A) and x.ability == A:GetAbilityByIndex(1) then
			self:tryRupture(A)
		end
	end
end
function N.prototype.tryRupture(self, O)
	local y = self:GetParent()
	local A = y:GetEnemy()
	if O ~= A then
		return
	end
	if not IsInjurable(y, A) then
		return
	end
	local P = GameRules:GetGameTime()
	self.triggerTimes = g(self.triggerTimes, function(Q, R)
		return P - R < 1
	end)
	if #self.triggerTimes >= self.limit then
		return
	end
	local S = self.triggerTimes
	S[#S + 1] = P
	local K = A:GetMaxHealth() * self.damage_pudg * 0.01
	y:DealDamage(A, self.parent:FindAbilityByName("bloodseeker_rupture"), K, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
end
N = e(
	{
		o(
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
	N
)
i.modifier_bloodseeker_talent_6 = N
i.bloodseeker_shard = c()
local T = i.bloodseeker_shard
T.name = "bloodseeker_shard"
d(T, k)
function T.prototype.GetIntrinsicModifierName(self)
	return "modifier_bloodseeker_shard"
end
T = e({ l(nil) }, T)
i.bloodseeker_shard = T
i.modifier_bloodseeker_shard = c()
local U = i.modifier_bloodseeker_shard
U.name = "modifier_bloodseeker_shard"
d(U, n)
function U.prototype.GetAbilitySpecialValue(self)
	self.regen_health_pct = self:GetAbilitySpecialValueFor("regen_health_pct")
end
function U.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { self.parent, -1 } }
end
function U.prototype.OnWispDie(self, u)
	if IsServer() and not u.remove and IsValid(u.wisp) then
		local z = u.wisp:GetMaxHealth() * self.regen_health_pct * 0.01
		Heal(self:GetParent(), z, "bloodseeker_shard", "Ability")
	end
end
U = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	U
)
i.modifier_bloodseeker_shard = U
return i