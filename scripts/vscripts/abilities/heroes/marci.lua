--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/marci"
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
		["36"] = 36,
		["37"] = 37,
		["38"] = 38,
		["39"] = 39,
		["40"] = 41,
		["41"] = 13,
		["42"] = 42,
		["43"] = 43,
		["44"] = 44,
		["45"] = 45,
		["46"] = 47,
		["47"] = 48,
		["48"] = 49,
		["49"] = 50,
		["50"] = 51,
		["51"] = 52,
		["52"] = 53,
		["53"] = 55,
		["54"] = 42,
		["55"] = 57,
		["56"] = 58,
		["57"] = 57,
		["58"] = 62,
		["59"] = 63,
		["60"] = 63,
		["61"] = 63,
		["62"] = 66,
		["63"] = 66,
		["64"] = 66,
		["65"] = 63,
		["66"] = 67,
		["67"] = 67,
		["68"] = 67,
		["69"] = 63,
		["70"] = 68,
		["71"] = 68,
		["72"] = 68,
		["73"] = 63,
		["74"] = 63,
		["75"] = 62,
		["76"] = 71,
		["77"] = 72,
		["78"] = 73,
		["79"] = 74,
		["80"] = 75,
		["81"] = 71,
		["82"] = 77,
		["83"] = 79,
		["84"] = 80,
		["85"] = 77,
		["86"] = 82,
		["87"] = 83,
		["88"] = 84,
		["89"] = 85,
		["90"] = 82,
		["91"] = 87,
		["92"] = 89,
		["93"] = 90,
		["95"] = 93,
		["96"] = 94,
		["98"] = 87,
		["99"] = 97,
		["100"] = 99,
		["101"] = 100,
		["102"] = 101,
		["103"] = 103,
		["104"] = 104,
		["105"] = 105,
		["106"] = 106,
		["109"] = 107,
		["110"] = 109,
		["111"] = 110,
		["112"] = 110,
		["113"] = 110,
		["114"] = 111,
		["115"] = 112,
		["116"] = 113,
		["117"] = 113,
		["118"] = 113,
		["119"] = 113,
		["120"] = 113,
		["121"] = 113,
		["122"] = 110,
		["123"] = 110,
		["125"] = 116,
		["126"] = 117,
		["127"] = 118,
		["130"] = 97,
		["131"] = 122,
		["132"] = 123,
		["133"] = 122,
		["134"] = 126,
		["135"] = 127,
		["138"] = 132,
		["139"] = 132,
		["140"] = 132,
		["141"] = 133,
		["142"] = 134,
		["143"] = 135,
		["145"] = 132,
		["146"] = 132,
		["147"] = 126,
		["148"] = 140,
		["149"] = 141,
		["150"] = 140,
		["151"] = 145,
		["152"] = 145,
		["153"] = 145,
		["155"] = 146,
		["156"] = 147,
		["157"] = 148,
		["160"] = 150,
		["161"] = 151,
		["162"] = 152,
		["163"] = 153,
		["165"] = 155,
		["166"] = 156,
		["167"] = 156,
		["168"] = 156,
		["169"] = 156,
		["170"] = 156,
		["171"] = 157,
		["172"] = 158,
		["173"] = 158,
		["174"] = 158,
		["175"] = 158,
		["176"] = 158,
		["177"] = 159,
		["178"] = 160,
		["179"] = 161,
		["180"] = 161,
		["181"] = 161,
		["182"] = 161,
		["183"] = 161,
		["184"] = 161,
		["186"] = 145,
		["187"] = 165,
		["188"] = 166,
		["189"] = 167,
		["190"] = 168,
		["191"] = 168,
		["192"] = 168,
		["193"] = 168,
		["194"] = 168,
		["195"] = 168,
		["196"] = 168,
		["197"] = 168,
		["199"] = 170,
		["200"] = 171,
		["201"] = 171,
		["202"] = 171,
		["203"] = 171,
		["204"] = 171,
		["205"] = 171,
		["206"] = 171,
		["207"] = 171,
		["210"] = 165,
		["211"] = 21,
		["212"] = 13,
		["213"] = 13,
		["214"] = 13,
		["215"] = 13,
		["216"] = 13,
		["217"] = 13,
		["218"] = 13,
		["219"] = 13,
		["220"] = 21,
		["222"] = 21,
		["224"] = 177,
		["225"] = 186,
		["226"] = 177,
		["227"] = 186,
		["229"] = 186,
		["230"] = 200,
		["231"] = 177,
		["232"] = 201,
		["233"] = 202,
		["234"] = 203,
		["235"] = 205,
		["236"] = 207,
		["237"] = 208,
		["238"] = 210,
		["239"] = 211,
		["240"] = 201,
		["241"] = 213,
		["242"] = 214,
		["245"] = 217,
		["246"] = 218,
		["247"] = 220,
		["248"] = 221,
		["249"] = 222,
		["250"] = 223,
		["251"] = 224,
		["252"] = 224,
		["253"] = 224,
		["254"] = 224,
		["255"] = 224,
		["256"] = 224,
		["257"] = 224,
		["258"] = 224,
		["259"] = 224,
		["260"] = 225,
		["261"] = 225,
		["262"] = 225,
		["263"] = 225,
		["264"] = 225,
		["265"] = 225,
		["266"] = 225,
		["267"] = 225,
		["268"] = 227,
		["269"] = 228,
		["270"] = 228,
		["271"] = 228,
		["272"] = 229,
		["275"] = 230,
		["276"] = 230,
		["277"] = 231,
		["279"] = 228,
		["280"] = 228,
		["282"] = 213,
		["283"] = 236,
		["284"] = 237,
		["285"] = 238,
		["288"] = 241,
		["289"] = 242,
		["290"] = 243,
		["292"] = 236,
		["293"] = 246,
		["294"] = 247,
		["295"] = 248,
		["296"] = 249,
		["297"] = 253,
		["298"] = 255,
		["299"] = 256,
		["300"] = 257,
		["301"] = 258,
		["302"] = 259,
		["303"] = 259,
		["304"] = 259,
		["305"] = 259,
		["306"] = 259,
		["307"] = 259,
		["310"] = 263,
		["311"] = 246,
		["312"] = 265,
		["313"] = 266,
		["314"] = 265,
		["315"] = 270,
		["316"] = 271,
		["317"] = 270,
		["318"] = 273,
		["319"] = 274,
		["320"] = 273,
		["321"] = 278,
		["322"] = 279,
		["323"] = 280,
		["324"] = 281,
		["325"] = 282,
		["327"] = 284,
		["328"] = 285,
		["329"] = 287,
		["331"] = 289,
		["333"] = 278,
		["334"] = 292,
		["335"] = 293,
		["336"] = 292,
		["337"] = 297,
		["338"] = 298,
		["339"] = 300,
		["340"] = 300,
		["341"] = 298,
		["342"] = 297,
		["343"] = 303,
		["344"] = 304,
		["345"] = 304,
		["346"] = 305,
		["348"] = 303,
		["349"] = 321,
		["350"] = 323,
		["351"] = 324,
		["352"] = 325,
		["353"] = 326,
		["354"] = 327,
		["355"] = 327,
		["356"] = 327,
		["357"] = 327,
		["358"] = 327,
		["359"] = 327,
		["360"] = 327,
		["361"] = 327,
		["362"] = 327,
		["363"] = 328,
		["364"] = 329,
		["365"] = 329,
		["366"] = 329,
		["367"] = 329,
		["368"] = 329,
		["369"] = 330,
		["370"] = 331,
		["371"] = 332,
		["374"] = 321,
		["375"] = 186,
		["376"] = 177,
		["377"] = 177,
		["378"] = 177,
		["379"] = 177,
		["380"] = 177,
		["381"] = 177,
		["382"] = 177,
		["383"] = 177,
		["384"] = 177,
		["385"] = 186,
		["387"] = 186,
		["389"] = 338,
		["390"] = 346,
		["391"] = 338,
		["392"] = 346,
		["393"] = 347,
		["394"] = 348,
		["395"] = 349,
		["396"] = 350,
		["397"] = 351,
		["398"] = 352,
		["400"] = 354,
		["402"] = 347,
		["403"] = 357,
		["404"] = 358,
		["405"] = 357,
		["406"] = 362,
		["407"] = 363,
		["408"] = 362,
		["409"] = 346,
		["410"] = 338,
		["411"] = 338,
		["412"] = 338,
		["413"] = 338,
		["414"] = 338,
		["415"] = 338,
		["416"] = 338,
		["417"] = 338,
		["418"] = 346,
		["420"] = 346,
		["422"] = 368,
		["423"] = 369,
		["424"] = 368,
		["425"] = 369,
		["426"] = 370,
		["427"] = 371,
		["428"] = 372,
		["429"] = 373,
		["430"] = 374,
		["431"] = 375,
		["432"] = 370,
		["433"] = 369,
		["434"] = 368,
		["435"] = 369,
		["437"] = 369,
		["439"] = 379,
		["440"] = 389,
		["441"] = 379,
		["442"] = 389,
		["443"] = 394,
		["444"] = 395,
		["445"] = 396,
		["446"] = 397,
		["447"] = 398,
		["448"] = 394,
		["449"] = 400,
		["450"] = 401,
		["451"] = 402,
		["452"] = 403,
		["453"] = 404,
		["454"] = 405,
		["456"] = 408,
		["457"] = 409,
		["459"] = 411,
		["460"] = 412,
		["461"] = 412,
		["462"] = 412,
		["463"] = 412,
		["464"] = 412,
		["465"] = 412,
		["466"] = 412,
		["467"] = 412,
		["468"] = 412,
		["469"] = 413,
		["470"] = 413,
		["471"] = 413,
		["472"] = 413,
		["473"] = 413,
		["474"] = 414,
		["475"] = 414,
		["476"] = 414,
		["477"] = 414,
		["478"] = 414,
		["479"] = 414,
		["480"] = 414,
		["481"] = 414,
		["483"] = 400,
		["484"] = 417,
		["485"] = 418,
		["486"] = 419,
		["487"] = 420,
		["488"] = 421,
		["489"] = 422,
		["491"] = 425,
		["492"] = 426,
		["494"] = 417,
		["495"] = 429,
		["496"] = 430,
		["497"] = 429,
		["498"] = 434,
		["499"] = 435,
		["500"] = 436,
		["501"] = 436,
		["502"] = 435,
		["503"] = 434,
		["504"] = 439,
		["505"] = 440,
		["506"] = 441,
		["507"] = 442,
		["508"] = 443,
		["509"] = 444,
		["512"] = 439,
		["513"] = 389,
		["514"] = 379,
		["515"] = 379,
		["516"] = 379,
		["517"] = 379,
		["518"] = 379,
		["519"] = 379,
		["520"] = 379,
		["521"] = 379,
		["522"] = 379,
		["523"] = 389,
		["525"] = 389,
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
g.marci_talent = c()
local q = g.marci_talent
q.name = "marci_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_marci_talent"
end
q = e({ j(nil) }, q)
g.marci_talent = q
g.modifier_marci_talent = c()
local r = g.modifier_marci_talent
r.name = "modifier_marci_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
	self.record = 0
	self.ulti_refresh = false
	self.battle_end = true
	self.first = true
end
function r.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.slow_duration = self:GetAbilitySpecialValueFor("slow_duration")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.lifesteal = self:GetAbilityTalentValue("marci_talent_2", "lifesteal")
	self.tl2_attack = self:GetAbilityTalentValue("marci_talent_2", "attack")
	self.pulse_damage_bonus = self:GetAbilityTalentValue("marci_talent_4", "pulse_damage_bonus")
	self.unleash_cd_reduce = self:GetAbilityTalentValue("marci_talent_7", "unleash_cd_reduce")
	self.tl8_pulse_chance = self:GetAbilityTalentValue("marci_talent_8", "pulse_chance")
	self.tl8_count = self:GetAbilityTalentValue("marci_talent_8", "count")
	self.init_cooldown = self:GetAbilityTalentValue("marci_talent_5", "init_cooldown")
	self.s_lifesteal = self:GetAbilityTalentValue("marci_shard", "lifesteal")
end
function r.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.tl2_attack }
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.ulti_refresh = false
	self.battle_end = false
	self.first = true
	self.record = 0
end
function r.prototype.OnBattleStart(self, s)
	self:StartIntervalThink(self.tick)
	self:OnIntervalThink()
end
function r.prototype.OnBattleEnd(self, s)
	self.battle_end = true
	self:StartIntervalThink(-1)
	self:SetStackCount(0)
end
function r.prototype.OnCustomAttackLanded(self, t)
	if self.unleash_cd_reduce > 0 then
		self.record = self.record + self.unleash_cd_reduce
	end
	if self.tl8_pulse_chance > 0 and self:PRD(self.tl8_pulse_chance, "tl8_pulse_chance") then
		self:Pulse()
	end
end
function r.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	self.record = self.record + self.tick
	local v = self.first and self.cooldown - self.init_cooldown or self.cooldown
	if self.record >= v and self.timer == nil and not u:HasModifier("modifier_marci_talent_buff") then
		self.record = 0
		self.first = false
		if self:GetCaster():PassivesDisabled() then
			return
		end
		self:StartIntervalThink(-1)
		u:StartGesture(ACT_DOTA_CAST_ABILITY_4)
		self.timer = u:GameTimer(0.3, function()
			self.timer = nil
			u:EmitSound("Hero_Marci.Unleash.Cast")
			u:AddNewModifier(u, self:GetAbility(), "modifier_marci_talent_buff", {})
		end)
	else
		if self.ulti_refresh then
			self.ulti_refresh = false
			self:reset()
		end
	end
end
function r.prototype.RefreshCooldown(self)
	self.ulti_refresh = true
end
function r.prototype.ResumeCooldown(self)
	if self.battle_end then
		return
	end
	GameTimer(FRAME_TIME, function()
		if IsValid(self) then
			self.record = 0
			self:StartIntervalThink(self.tick)
		end
	end)
end
function r.prototype.reset(self)
	self.record = self.record + self.cooldown
end
function r.prototype.Pulse(self, w)
	if w == nil then
		w = 0
	end
	local u = self:GetParent()
	local x = u:GetEnemy()
	if not IsInjurable(u, x) then
		return
	end
	local y = self:GetAbility()
	local z = self:GetAbilitySpecialValueFor("damage")
	if self.pulse_damage_bonus > 0 then
		z = z + self.pulse_damage_bonus * self:GetStackCount()
	end
	local A = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf",
		PATTACH_ABSORIGIN,
		u,
		u
	)
	ParticleManager:SetParticleControl(A, 1, Vector(600, 600, 600))
	ParticleManager:ReleaseParticleIndex(A)
	EmitSoundOnLocationWithCaster(x:GetAbsOrigin(), "Hero_Marci.Unleash.Pulse", u)
	u:DealDamage(x, y, z, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	if w > 0 then
		u:DealDamage(x, u:FindAbilityByName("marci_talent_3"), w, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	end
end
function r.prototype.OnCustomTakeDamage(self, t)
	if t.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		if self.lifesteal > 0 then
			Heal(
				t.attacker,
				t.damage * self.lifesteal * 0.01,
				"marci_talent_2",
				"Ability",
				false,
				HealFlags.HEAL_FLAG_LIFESETEAL
			)
		end
		if self.s_lifesteal > 0 then
			Heal(
				t.attacker,
				t.damage * self.s_lifesteal * 0.01,
				"marci_shard",
				"Ability",
				false,
				HealFlags.HEAL_FLAG_LIFESETEAL
			)
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
g.modifier_marci_talent = r
g.modifier_marci_talent_buff = c()
local B = g.modifier_marci_talent_buff
B.name = "modifier_marci_talent_buff"
d(B, l)
function B.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.attack_counter = 0
end
function B.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attack_count = self:GetAbilitySpecialValueFor("attack_count")
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
	self.bonus_attack = self:GetAbilityTalentValue("marci_talent_1", "bonus_attack")
	self.talent_3_damage_last = self:GetAbilityTalentValue("marci_talent_3", "damage_last")
	self.silence = self:GetAbilityTalentValue("marci_talent_6", "silence")
	self.damage_record = 0
end
function B.prototype.OnCreated(self, s)
	if not IsServer() then
		return
	end
	local u = self:GetParent()
	ParticleManager:CreateParticle("particles/units/heroes/hero_marci/marci_unleash_cast.vpcf", PATTACH_ABSORIGIN, u)
	u:AttackNoEarlierThan(0, 0)
	u:AddActivityModifier("unleash")
	self:SetStackCount(self.attack_count + self.bonus_attack)
	self.particleID = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_marci/marci_unleash_stack.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		u
	)
	ParticleManager:SetParticleControl(self.particleID, 1, Vector(0, self:GetStackCount(), 0))
	self:AddParticle(self.particleID, false, false, -1, false, false)
	if self.talent_3_damage_last > 0 then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE, function(C, s, D, E)
			if D ~= u then
				return
			end
			local F = s and s.ability
			if (F and F:GetAbilityName()) == "marci_talent" or s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				self.damage_record = self.damage_record + s.damage
			end
		end)
	end
end
function B.prototype.OnDestroy(self)
	local u = self:GetParent()
	if not IsServer() then
		return
	end
	local G = u:FindModifierByName("modifier_marci_talent")
	if IsValid(G) then
		G:ResumeCooldown()
	end
end
function B.prototype.LastPunch(self)
	local u = self:GetParent()
	local H = self:GetParent():FindModifierByName("modifier_marci_talent")
	if IsValid(H) then
		H:Pulse(self.damage_record * self.talent_3_damage_last * 0.01)
		H:IncrementStackCount()
		if self.silence > 0 then
			local u = self:GetParent()
			local E = u:GetEnemy()
			AddSilence(u, E, self:GetAbility(), self.silence)
		end
	end
	u:RemoveActivityModifier("unleash")
end
function B.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_RATE_BONUS }
end
function B.prototype.EOM_GetModifierAttackRateBonus(self, s)
	return -1000
end
function B.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function B.prototype.GetActivityTranslationModifiers(self)
	if IsServer() then
		local I = self:GetStackCount()
		if I == 1 then
			return "flurry_pulse_attack"
		end
		self.attack_counter = self.attack_counter + 1
		if self.attack_counter % 2 == 1 then
			return "flurry_attack_b"
		end
		return "flurry_attack_a"
	end
end
function B.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_OVERRIDE] = 1325 }
end
function B.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START] = { self:GetParent(), -1 } }
end
function B.prototype.OnCustomTakeDamage(self, t)
	local J = t and t.ability
	if (J and J:GetAbilityName()) == "marci_talent" or t.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
		self.damage_record = self.damage_record + t.damage
	end
end
function B.prototype.OnDamageStart(self, t)
	if t.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and not IsValid(t and t.ability) then
		local u = self:GetParent()
		local E = t.target
		self:DecrementStackCount()
		ParticleManager:SetParticleControl(self.particleID, 1, Vector(0, self:GetStackCount(), 0))
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_marci/marci_unleash_attack.vpcf",
			PATTACH_ABSORIGIN,
			u
		)
		ParticleManager:SetParticleControl(A, 1, E:GetAbsOrigin())
		if self:GetStackCount() == 0 then
			self:LastPunch()
			self:Destroy()
		end
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
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetEffectName = "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf",
			}
		),
	},
	B
)
g.modifier_marci_talent_buff = B
g.modifier_marci_talent_debuff = c()
local K = g.modifier_marci_talent_debuff
K.name = "modifier_marci_talent_debuff"
d(K, l)
function K.prototype.OnDestroy(self)
	if IsServer() then
		local u = self:GetParent()
		local H = u:FindModifierByName("modifier_marci_talent")
		if IsValid(H) then
			H:IncrementStackCount()
		end
		u:RemoveModifierByName("modifier_marci_talent_buff")
	end
end
function K.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function K.prototype.GetActivityTranslationModifiers(self)
	return "unleash_recharge"
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
g.modifier_marci_talent_debuff = K
g.marci_ult = c()
local L = g.marci_ult
L.name = "marci_ult"
d(L, o)
function L.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	local M = self:GetSpecialValueFor("duration")
	D:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	D:EmitSound("Hero_Marci.Guardian.Applied")
	D:AddNewModifier(D, self, "modifier_marci_ult_buff", { duration = M })
end
L = e({ p(nil) }, L)
g.marci_ult = L
g.modifier_marci_ult_buff = c()
local N = g.modifier_marci_ult_buff
N.name = "modifier_marci_ult_buff"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.shield = self:GetAbilitySpecialValueFor("shield")
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.attack_add = self:GetAbilitySpecialValueFor("attack_add")
end
function N.prototype.OnCreated(self, s)
	local u = self:GetParent()
	if IsServer() then
		local H = u:FindModifierByName("modifier_marci_talent")
		if IsValid(H) then
			H:RefreshCooldown()
		end
		local O = self.attack_add > 0 and math.floor(GetAttackDamage(u) / self.attack_add) or 0
		self:IncrementStackCount(self.count + O)
	else
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			u
		)
		ParticleManager:SetParticleControlEnt(A, 1, u, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
		ParticleManager:SetParticleControl(A, 2, Vector(1, 0, 0))
		self:AddParticle(A, false, false, -1, false, true)
	end
end
function N.prototype.OnRefresh(self, s)
	if IsServer() then
		local u = self:GetParent()
		local H = u:FindModifierByName("modifier_marci_talent")
		if IsValid(H) then
			H:RefreshCooldown()
		end
		local O = self.attack_add > 0 and math.floor(GetAttackDamage(u) / self.attack_add) or 0
		self:IncrementStackCount(self.count + O)
	end
end
function N.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS] = self.attack }
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() } }
end
function N.prototype.OnCustomAttackLanded(self, t)
	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
		local H = self:GetParent():FindModifierByName("modifier_marci_talent")
		if IsValid(H) then
			H:Pulse()
		end
	end
end
N = e(
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
				ShouldUseOverheadOffset = true,
			}
		),
	},
	N
)
g.modifier_marci_ult_buff = N
return g