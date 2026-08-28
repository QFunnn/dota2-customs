--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/kunkka"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
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
		["19"] = 5,
		["20"] = 6,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 8,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 6,
		["30"] = 6,
		["31"] = 12,
		["32"] = 20,
		["33"] = 12,
		["34"] = 20,
		["35"] = 35,
		["36"] = 36,
		["37"] = 37,
		["38"] = 39,
		["39"] = 41,
		["40"] = 42,
		["41"] = 43,
		["42"] = 44,
		["43"] = 46,
		["44"] = 47,
		["45"] = 48,
		["47"] = 35,
		["48"] = 60,
		["49"] = 61,
		["50"] = 60,
		["51"] = 68,
		["52"] = 69,
		["53"] = 70,
		["55"] = 68,
		["56"] = 73,
		["57"] = 74,
		["58"] = 75,
		["60"] = 73,
		["61"] = 78,
		["62"] = 79,
		["63"] = 80,
		["64"] = 81,
		["65"] = 82,
		["68"] = 78,
		["69"] = 86,
		["70"] = 87,
		["71"] = 87,
		["72"] = 89,
		["73"] = 89,
		["74"] = 89,
		["75"] = 87,
		["76"] = 90,
		["77"] = 90,
		["78"] = 90,
		["79"] = 87,
		["80"] = 91,
		["81"] = 91,
		["82"] = 91,
		["83"] = 87,
		["84"] = 92,
		["85"] = 92,
		["86"] = 92,
		["87"] = 87,
		["88"] = 87,
		["89"] = 86,
		["90"] = 95,
		["91"] = 97,
		["94"] = 100,
		["95"] = 101,
		["97"] = 95,
		["98"] = 104,
		["99"] = 105,
		["100"] = 107,
		["101"] = 108,
		["103"] = 110,
		["104"] = 111,
		["107"] = 104,
		["108"] = 115,
		["109"] = 116,
		["110"] = 117,
		["111"] = 118,
		["112"] = 115,
		["113"] = 131,
		["114"] = 132,
		["117"] = 133,
		["118"] = 134,
		["119"] = 134,
		["120"] = 134,
		["121"] = 134,
		["123"] = 137,
		["124"] = 138,
		["125"] = 139,
		["128"] = 142,
		["129"] = 143,
		["130"] = 143,
		["131"] = 143,
		["132"] = 143,
		["133"] = 143,
		["134"] = 143,
		["136"] = 131,
		["137"] = 146,
		["138"] = 147,
		["139"] = 149,
		["140"] = 150,
		["141"] = 152,
		["142"] = 153,
		["144"] = 156,
		["145"] = 157,
		["147"] = 159,
		["148"] = 160,
		["149"] = 161,
		["150"] = 161,
		["151"] = 161,
		["152"] = 161,
		["153"] = 161,
		["154"] = 161,
		["159"] = 166,
		["160"] = 167,
		["163"] = 170,
		["164"] = 171,
		["165"] = 172,
		["166"] = 182,
		["167"] = 183,
		["168"] = 146,
		["169"] = 185,
		["170"] = 200,
		["171"] = 201,
		["172"] = 202,
		["173"] = 204,
		["174"] = 205,
		["175"] = 206,
		["177"] = 208,
		["178"] = 209,
		["181"] = 185,
		["182"] = 214,
		["183"] = 215,
		["184"] = 216,
		["185"] = 217,
		["186"] = 218,
		["188"] = 214,
		["189"] = 20,
		["190"] = 12,
		["191"] = 12,
		["192"] = 12,
		["193"] = 12,
		["194"] = 12,
		["195"] = 12,
		["196"] = 12,
		["197"] = 12,
		["198"] = 20,
		["200"] = 20,
		["201"] = 222,
		["202"] = 230,
		["203"] = 222,
		["204"] = 230,
		["205"] = 233,
		["206"] = 234,
		["207"] = 235,
		["208"] = 233,
		["209"] = 237,
		["210"] = 238,
		["211"] = 239,
		["212"] = 240,
		["213"] = 241,
		["214"] = 241,
		["215"] = 241,
		["216"] = 241,
		["217"] = 241,
		["218"] = 241,
		["219"] = 241,
		["220"] = 241,
		["221"] = 241,
		["222"] = 242,
		["223"] = 242,
		["224"] = 242,
		["225"] = 242,
		["226"] = 242,
		["227"] = 242,
		["228"] = 242,
		["229"] = 242,
		["230"] = 242,
		["231"] = 243,
		["232"] = 243,
		["233"] = 243,
		["234"] = 243,
		["235"] = 243,
		["236"] = 243,
		["237"] = 243,
		["238"] = 243,
		["239"] = 243,
		["240"] = 244,
		["241"] = 244,
		["242"] = 244,
		["243"] = 244,
		["244"] = 244,
		["245"] = 244,
		["246"] = 244,
		["247"] = 244,
		["249"] = 246,
		["251"] = 237,
		["252"] = 249,
		["253"] = 250,
		["254"] = 249,
		["255"] = 255,
		["256"] = 256,
		["257"] = 255,
		["258"] = 258,
		["259"] = 259,
		["260"] = 258,
		["261"] = 230,
		["262"] = 222,
		["263"] = 222,
		["264"] = 222,
		["265"] = 222,
		["266"] = 222,
		["267"] = 222,
		["268"] = 222,
		["269"] = 222,
		["270"] = 230,
		["272"] = 230,
		["273"] = 265,
		["274"] = 266,
		["275"] = 265,
		["276"] = 266,
		["277"] = 267,
		["278"] = 268,
		["279"] = 269,
		["280"] = 270,
		["283"] = 273,
		["284"] = 275,
		["285"] = 276,
		["286"] = 277,
		["287"] = 278,
		["288"] = 279,
		["289"] = 280,
		["290"] = 281,
		["291"] = 281,
		["292"] = 281,
		["293"] = 282,
		["294"] = 283,
		["295"] = 284,
		["296"] = 285,
		["297"] = 286,
		["298"] = 287,
		["299"] = 288,
		["301"] = 291,
		["302"] = 292,
		["304"] = 281,
		["305"] = 281,
		["306"] = 295,
		["307"] = 296,
		["308"] = 297,
		["309"] = 267,
		["310"] = 266,
		["311"] = 265,
		["312"] = 266,
		["314"] = 266,
		["315"] = 303,
		["316"] = 311,
		["317"] = 303,
		["318"] = 311,
		["319"] = 316,
		["320"] = 317,
		["321"] = 316,
		["322"] = 319,
		["323"] = 320,
		["324"] = 321,
		["325"] = 322,
		["326"] = 322,
		["327"] = 322,
		["328"] = 323,
		["329"] = 324,
		["331"] = 322,
		["332"] = 322,
		["334"] = 319,
		["335"] = 329,
		["336"] = 330,
		["339"] = 331,
		["342"] = 332,
		["343"] = 333,
		["344"] = 334,
		["345"] = 335,
		["347"] = 335,
		["349"] = 336,
		["351"] = 338,
		["352"] = 338,
		["353"] = 338,
		["354"] = 338,
		["355"] = 338,
		["356"] = 338,
		["358"] = 329,
		["359"] = 311,
		["360"] = 303,
		["361"] = 303,
		["362"] = 303,
		["363"] = 303,
		["364"] = 303,
		["365"] = 303,
		["366"] = 303,
		["367"] = 303,
		["368"] = 311,
		["370"] = 311,
		["371"] = 346,
		["372"] = 354,
		["373"] = 346,
		["374"] = 354,
		["375"] = 359,
		["376"] = 360,
		["377"] = 359,
		["378"] = 362,
		["379"] = 363,
		["380"] = 364,
		["381"] = 365,
		["382"] = 365,
		["383"] = 365,
		["384"] = 366,
		["385"] = 367,
		["387"] = 365,
		["388"] = 365,
		["390"] = 362,
		["391"] = 372,
		["392"] = 373,
		["395"] = 374,
		["396"] = 375,
		["397"] = 376,
		["398"] = 377,
		["399"] = 378,
		["401"] = 380,
		["402"] = 380,
		["403"] = 380,
		["404"] = 380,
		["405"] = 380,
		["406"] = 380,
		["408"] = 372,
		["409"] = 354,
		["410"] = 346,
		["411"] = 346,
		["412"] = 346,
		["413"] = 346,
		["414"] = 346,
		["415"] = 346,
		["416"] = 346,
		["417"] = 346,
		["418"] = 354,
		["420"] = 354,
		["421"] = 388,
		["422"] = 396,
		["423"] = 388,
		["424"] = 396,
		["425"] = 410,
		["426"] = 411,
		["427"] = 412,
		["428"] = 413,
		["429"] = 410,
		["430"] = 415,
		["431"] = 416,
		["432"] = 417,
		["433"] = 418,
		["434"] = 419,
		["435"] = 420,
		["436"] = 421,
		["437"] = 422,
		["439"] = 424,
		["441"] = 415,
		["442"] = 427,
		["443"] = 428,
		["444"] = 429,
		["445"] = 430,
		["447"] = 427,
		["448"] = 433,
		["449"] = 434,
		["450"] = 435,
		["451"] = 436,
		["452"] = 437,
		["453"] = 438,
		["454"] = 438,
		["455"] = 438,
		["456"] = 438,
		["457"] = 438,
		["458"] = 438,
		["459"] = 439,
		["460"] = 440,
		["461"] = 440,
		["462"] = 440,
		["463"] = 440,
		["464"] = 440,
		["465"] = 441,
		["466"] = 442,
		["467"] = 442,
		["468"] = 442,
		["469"] = 442,
		["470"] = 442,
		["473"] = 433,
		["474"] = 446,
		["475"] = 447,
		["476"] = 448,
		["477"] = 449,
		["480"] = 453,
		["481"] = 454,
		["482"] = 454,
		["484"] = 460,
		["485"] = 461,
		["488"] = 464,
		["491"] = 468,
		["492"] = 469,
		["493"] = 470,
		["494"] = 471,
		["495"] = 471,
		["496"] = 471,
		["497"] = 472,
		["498"] = 473,
		["499"] = 474,
		["500"] = 475,
		["501"] = 476,
		["502"] = 477,
		["504"] = 471,
		["505"] = 471,
		["506"] = 480,
		["507"] = 482,
		["508"] = 482,
		["509"] = 482,
		["510"] = 482,
		["511"] = 483,
		["512"] = 483,
		["513"] = 483,
		["514"] = 483,
		["515"] = 483,
		["516"] = 483,
		["517"] = 483,
		["518"] = 483,
		["519"] = 446,
		["520"] = 485,
		["521"] = 486,
		["522"] = 487,
		["523"] = 485,
		["524"] = 494,
		["525"] = 495,
		["526"] = 494,
		["527"] = 396,
		["528"] = 388,
		["529"] = 388,
		["530"] = 388,
		["531"] = 388,
		["532"] = 388,
		["533"] = 388,
		["534"] = 388,
		["535"] = 388,
		["536"] = 396,
		["538"] = 396,
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
i.kunkka_talent = c()
local s = i.kunkka_talent
s.name = "kunkka_talent"
d(s, k)
function s.prototype.GetIntrinsicModifierName(self)
	return "modifier_kunkka_talent"
end
s = e({ l(nil) }, s)
i.kunkka_talent = s
i.modifier_kunkka_talent = c()
local t = i.modifier_kunkka_talent
t.name = "modifier_kunkka_talent"
d(t, n)
function t.prototype.GetAbilitySpecialValue(self)
	self.cooldown = self:GetAbilitySpecialValueFor("cooldown")
		- self:GetAbilityTalentValue("kunkka_talent_5", "cooldown_reduce")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
		+ self:GetAbilityTalentValue("kunkka_talent_8", "bonus_damage")
		+ self:GetAbilityTalentValue("kunkka_talent_10", "damage_bonus")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
	self.talent_7_damage_pct = self:GetAbilityTalentValue("kunkka_talent_7", "damage_pct")
	self.talent_10_crit_bonus = self:GetAbilityTalentValue("kunkka_talent_10", "crit_bonus")
	self.talent_3_rum_up = self:GetAbilityTalentValue("kunkka_talent_3", "rum_up")
	self.talent_1_reduce_interval = self:GetAbilityTalentValue("kunkka_talent_1", "reduce_interval")
	self.s_interval = self:GetAbilityTalentValue("kunkka_shard", "interval")
	if IsServer() then
		self.cooldown_remain = 0
	end
end
function t.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROCATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_SOURCE_ABILITY,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MAGICAL_CRITICALSTRIKE_CHANCE,
	}
end
function t.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, u)
	if (u and u.ability) == self:GetAbility() then
		return self.talent_10_crit_bonus
	end
end
function t.prototype.EOM_GetModifierMagicalCriticalStrikeChance(self, u)
	if (u and u.ability) == self:GetAbility() then
		return self.talent_10_crit_bonus
	end
end
function t.prototype.EOM_GetModifierProcAttackDamageBonus(self, u)
	if IsServer() then
		if self.enable and IsValid(u and u.ability) and u.ability == self:GetAbility() then
			local v = self:GetParent():GetMaxHealth() * self.talent_7_damage_pct * 0.01
			return self.bonus_damage + self:GetParent():GetHealthDeficit() * self.bonus_damage_pct * 0.01 + v
		end
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BLOCK] = { -1, self:GetParent() },
	}
end
function t.prototype.OnBlock(self, w)
	if w.attacker ~= self:GetParent() or w.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if self.enable and self:GetParent():HasModifier("modifier_kunkka_talent_buff") then
		self.enable = false
	end
end
function t.prototype.OnCriticalCalculated(self, w)
	if w.is_crit and w.ability == self:GetAbility() and self:HasTalent("kunkka_talent_10") then
		if
			bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING)
			~= DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
		then
			w.damage_flags = w.damage_flags + DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING
		end
		if
			bit.band(w.damage_flags, DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING)
			~= DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING
		then
			w.damage_flags = w.damage_flags + DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING
		end
	end
end
function t.prototype.OnBattleStart(self, u)
	self.enable = false
	self:StartIntervalThink(0)
	self.cooldown_remain = self.cooldown
end
function t.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if self.cooldown_remain > 0 then
		self.cooldown_remain = math.max(0, self.cooldown_remain - FrameTime())
	end
	if
		self.cooldown_remain <= 0 and not (self.enable and self:GetParent():HasModifier("modifier_kunkka_talent_buff"))
	then
		if self:GetCaster():PassivesDisabled() then
			self.cooldown_remain = self.cooldown
			return
		end
		local x = self:GetParent()
		x:AddNewModifier(x, self:GetAbility(), "modifier_kunkka_talent_buff", {})
	end
end
function t.prototype.OnCustomAttackLanded(self, w)
	local x = self:GetParent()
	if not (self.enable and x:HasModifier("modifier_kunkka_talent_buff")) then
		if self.cooldown_remain > 0 then
			if self.s_interval > 0 then
				self.cooldown_remain = self.cooldown_remain - self.s_interval
			end
			if self.talent_1_reduce_interval > 0 then
				self.cooldown_remain = self.cooldown_remain - -self.talent_1_reduce_interval
			end
			if self.cooldown_remain <= 0 then
				local x = self:GetParent()
				x:AddNewModifier(x, self:GetAbility(), "modifier_kunkka_talent_buff", {})
			end
		end
		return
	end
	local y = w.target
	if not IsInjurable(x, y) then
		return
	end
	x:RemoveModifierByName("modifier_kunkka_talent_buff")
	self.enable = false
	self.cooldown_remain = self.cooldown
	y:EmitSound("Hero_Kunkka.TidebringerDamage")
	x:EmitSound("Hero_Kunkka.Tidebringer.Attack")
end
function t.prototype.OnCustomTakeDamage(self, w)
	if self.talent_3_rum_up > 0 then
		local x = self:GetParent()
		if x:GetHealthPercent() <= self.talent_3_rum_up then
			local z = x:FindAbilityByName("kunkka_ult")
			if IsValid(z) then
				x:AddNewModifier(x, z, "modifier_kunkka_ult_damage_record", {})
			end
		elseif x:HasModifier("modifier_kunkka_ult_damage_record") then
			x:RemoveModifierByName("modifier_kunkka_ult_damage_record")
		end
	end
end
function t.prototype.EOM_GetModifierAttackSourceAbility(self, u)
	local x = self:GetParent()
	if not self.enable and x:HasModifier("modifier_kunkka_talent_buff") then
		self.enable = true
		return self:GetAbility()
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
i.modifier_kunkka_talent = t
i.modifier_kunkka_talent_buff = c()
local A = i.modifier_kunkka_talent_buff
A.name = "modifier_kunkka_talent_buff"
d(A, n)
function A.prototype.GetAbilitySpecialValue(self)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
end
function A.prototype.OnCreated(self, u)
	local x = self:GetParent()
	if IsClient() then
		local B = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		ParticleManager:SetParticleControlEnt(
			B,
			0,
			x,
			PATTACH_POINT_FOLLOW,
			"attach_tidebringer",
			x:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			B,
			1,
			x,
			PATTACH_POINT_FOLLOW,
			"attach_tidebringer_2",
			x:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(B, 2, x, PATTACH_POINT_FOLLOW, "attach_sword", x:GetAbsOrigin(), true)
		self:AddParticle(B, false, false, -1, false, false)
	else
		x:EmitSound("Hero_Kunkaa.Tidebringer")
	end
end
function A.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function A.prototype.GetActivityTranslationModifiers(self)
	return "tidebringer"
end
function A.prototype.GetAttackSound(self)
	return "Hero_Kunkka.Tidebringer.Attack"
end
A = e(
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
	A
)
i.modifier_kunkka_talent_buff = A
i.kunkka_ult = c()
local C = i.kunkka_ult
C.name = "kunkka_ult"
d(C, q)
function C.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	local y = D:GetEnemy()
	if not IsInjurable(y, D) then
		return
	end
	local E = self:GetSpecialValueFor("duration")
	local F = self:GetSpecialValueFor("damage_pct") + self:GetTalentValue("kunkka_talent_2", "rum_damage_pct")
	local G = (y:GetAbsOrigin() - D:GetAbsOrigin()):Normalized()
	local H = y:GetAbsOrigin() + G * -400 * E
	local B = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf",
		PATTACH_CUSTOMORIGIN,
		D
	)
	ParticleManager:SetParticleControl(B, 0, H)
	ParticleManager:SetParticleControl(B, 1, G * 400)
	GameTimer(E, function()
		ParticleManager:DestroyParticle(B, false)
		if IsInjurable(D, y) then
			local I = self:GetSpecialValueFor("damage")
			local J = D:FindModifierByName("modifier_kunkka_ult")
			if IsValid(J) then
				local K = J:getTotalRecord()
				I = I + K * F * 0.01
			end
			D:DealDamage(y, self, I, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			D:EmitSound("Ability.Ghostship.crash")
		end
	end)
	D:EmitSound("Ability.Ghostship.bell")
	D:EmitSound("Ability.Ghostship")
	D:AddNewModifier(D, self, "modifier_kunkka_ult_damage_record_ult", { duration = E })
end
C = e({ r(nil) }, C)
i.kunkka_ult = C
i.modifier_kunkka_ult_damage_record_ult = c()
local L = i.modifier_kunkka_ult_damage_record_ult
L.name = "modifier_kunkka_ult_damage_record_ult"
d(L, n)
function L.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("kunkka_talent_6", "rum_reduce_pct")
end
function L.prototype.OnCreated(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(M, u, N, y)
			if y == self:GetParent() then
				self:OnPreDamage(u)
			end
		end)
	end
end
function L.prototype.OnPreDamage(self, w)
	if w.ability == self.rum_ability then
		return
	end
	if self:GetParent():HasModifier("modifier_kunkka_ult_damage_record") then
		return
	end
	local O = math.floor(w.damage * self.reduce_pct * 0.01)
	w.damage = w.damage - O
	if IsValid(self.rum_modifier) and self.rum_modifier.RecordDamage ~= nil then
		local P = self.rum_modifier
		if P ~= nil then
			P:RecordDamage(O)
		end
		self.rum_modifier:SetDuration(BUFF_VALUE.DrunkDuration, true)
	else
		self.rum_modifier = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_kunkka_ult",
			{ duration = BUFF_VALUE.DrunkDuration, record_damage = O }
		)
	end
end
L = e(
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
	L
)
i.modifier_kunkka_ult_damage_record_ult = L
i.modifier_kunkka_ult_damage_record = c()
local Q = i.modifier_kunkka_ult_damage_record
Q.name = "modifier_kunkka_ult_damage_record"
d(Q, n)
function Q.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("kunkka_talent_6", "rum_reduce_pct")
end
function Q.prototype.OnCreated(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(M, u, N, y)
			if y == self:GetParent() then
				self:OnPreDamage(u)
			end
		end)
	end
end
function Q.prototype.OnPreDamage(self, w)
	if w.ability == self.rum_ability then
		return
	end
	local O = math.floor(w.damage * self.reduce_pct * 0.01)
	w.damage = w.damage - O
	if IsValid(self.rum_modifier) then
		self.rum_modifier:RecordDamage(O)
		self.rum_modifier:SetDuration(BUFF_VALUE.DrunkDuration, true)
	else
		self.rum_modifier = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_kunkka_ult",
			{ duration = BUFF_VALUE.DrunkDuration, record_damage = O }
		)
	end
end
Q = e(
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
	Q
)
i.modifier_kunkka_ult_damage_record = Q
i.modifier_kunkka_ult = c()
local R = i.modifier_kunkka_ult
R.name = "modifier_kunkka_ult"
d(R, n)
function R.prototype.GetAbilitySpecialValue(self)
	self.rum_duration = BUFF_VALUE.DrunkDuration
	self.talent_2_interval = self:GetAbilityTalentValue("kunkka_talent_2", "interval")
	self.talent_2_damage_pct = self:GetAbilityTalentValue("kunkka_talent_2", "damage_pct")
end
function R.prototype.OnCreated(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.record = 0
		self.recordList = {}
		self:RecordDamage(u and u.record_damage or 0)
		if self.talent_2_interval > 0 then
			self:StartThink(self.talent_2_interval, "kunkka_talent_2")
		end
		self:StartIntervalThink(1)
	end
end
function R.prototype.OnRefresh(self, u)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self:RecordDamage(u and u.record_damage or 0)
	end
end
function R.prototype.OnThink(self, S)
	if S == "kunkka_talent_2" then
		local x = self:GetParent()
		local y = self:GetParent():GetEnemy()
		if IsInjurable(x, y) and self:getTotalRecord() > 0 then
			x:DealDamage(
				y,
				self:GetParent():FindAbilityByName("kunkka_talent_2"),
				self:getTotalRecord() * self.talent_2_damage_pct * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			local B = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				y,
				x
			)
			ParticleManager:SetParticleControl(B, 0, y:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(B)
			EmitSoundOnLocationWithCaster(y:GetAbsOrigin(), "Ability.Torrent", x)
		end
	end
end
function R.prototype.OnIntervalThink(self)
	local x = self:GetParent()
	local y = x:GetEnemy()
	if not IsInjurable(x, y) then
		return
	end
	if self.record > 0 then
		local T = self.recordList
		T[#T + 1] = { damage = self.record, remainDamage = self.record, time = 0 }
	else
		if self:GetStackCount() <= 0 then
			self:Destroy()
			return
		else
			self:SetDuration(BUFF_VALUE.DrunkDuration, true)
		end
	end
	self.record = 0
	local I = 0
	local U = 0
	f(self.recordList, function(V, W, X)
		if W.remainDamage > 0 then
			W.time = W.time + 1
			local Y = W.time == self.rum_duration and W.remainDamage or W.damage * 1 / self.rum_duration
			W.remainDamage = W.remainDamage - Y
			U = U + W.remainDamage
			I = I + Y
		end
	end)
	self:SetStackCount(U)
	self.recordList = g(self.recordList, function(V, W)
		return W.remainDamage > 0
	end)
	y:DealDamage(
		x,
		self.rum_ability,
		I,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
		DamageFlags.DAMAGE_FLAG_NO_LETHAL
			+ DamageFlags.DAMAGE_FLAG_REFLECTION
			+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
			+ DamageFlags.DAMAGE_FLAG_PURE_INCOMING,
		"Rum"
	)
end
function R.prototype.RecordDamage(self, I)
	self.record = self.record + I
	self:SetStackCount(self:GetStackCount() + I)
end
function R.prototype.getTotalRecord(self)
	return self:GetStackCount()
end
R = e(
	{
		o(
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
	R
)
i.modifier_kunkka_ult = R
return i