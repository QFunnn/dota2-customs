--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["84"] = 87,
		["85"] = 86,
		["86"] = 94,
		["87"] = 95,
		["88"] = 97,
		["89"] = 98,
		["91"] = 100,
		["92"] = 101,
		["95"] = 94,
		["96"] = 105,
		["97"] = 106,
		["98"] = 107,
		["99"] = 108,
		["100"] = 105,
		["101"] = 121,
		["102"] = 122,
		["105"] = 123,
		["106"] = 124,
		["107"] = 124,
		["108"] = 124,
		["109"] = 124,
		["111"] = 127,
		["112"] = 128,
		["113"] = 129,
		["116"] = 132,
		["117"] = 133,
		["118"] = 133,
		["119"] = 133,
		["120"] = 133,
		["121"] = 133,
		["122"] = 133,
		["124"] = 121,
		["125"] = 136,
		["126"] = 137,
		["127"] = 139,
		["128"] = 140,
		["129"] = 142,
		["130"] = 143,
		["132"] = 146,
		["133"] = 147,
		["135"] = 149,
		["136"] = 150,
		["137"] = 151,
		["138"] = 151,
		["139"] = 151,
		["140"] = 151,
		["141"] = 151,
		["142"] = 151,
		["147"] = 156,
		["148"] = 157,
		["151"] = 160,
		["152"] = 161,
		["153"] = 162,
		["154"] = 172,
		["155"] = 173,
		["156"] = 136,
		["157"] = 175,
		["158"] = 190,
		["159"] = 191,
		["160"] = 192,
		["161"] = 194,
		["162"] = 195,
		["163"] = 196,
		["165"] = 198,
		["166"] = 199,
		["169"] = 175,
		["170"] = 204,
		["171"] = 205,
		["172"] = 206,
		["173"] = 207,
		["174"] = 208,
		["176"] = 204,
		["177"] = 20,
		["178"] = 12,
		["179"] = 12,
		["180"] = 12,
		["181"] = 12,
		["182"] = 12,
		["183"] = 12,
		["184"] = 12,
		["185"] = 12,
		["186"] = 20,
		["188"] = 20,
		["189"] = 212,
		["190"] = 220,
		["191"] = 212,
		["192"] = 220,
		["193"] = 223,
		["194"] = 224,
		["195"] = 225,
		["196"] = 223,
		["197"] = 227,
		["198"] = 228,
		["199"] = 229,
		["200"] = 230,
		["201"] = 231,
		["202"] = 231,
		["203"] = 231,
		["204"] = 231,
		["205"] = 231,
		["206"] = 231,
		["207"] = 231,
		["208"] = 231,
		["209"] = 231,
		["210"] = 232,
		["211"] = 232,
		["212"] = 232,
		["213"] = 232,
		["214"] = 232,
		["215"] = 232,
		["216"] = 232,
		["217"] = 232,
		["218"] = 232,
		["219"] = 233,
		["220"] = 233,
		["221"] = 233,
		["222"] = 233,
		["223"] = 233,
		["224"] = 233,
		["225"] = 233,
		["226"] = 233,
		["227"] = 233,
		["228"] = 234,
		["229"] = 234,
		["230"] = 234,
		["231"] = 234,
		["232"] = 234,
		["233"] = 234,
		["234"] = 234,
		["235"] = 234,
		["237"] = 236,
		["239"] = 227,
		["240"] = 239,
		["241"] = 240,
		["242"] = 239,
		["243"] = 245,
		["244"] = 246,
		["245"] = 245,
		["246"] = 248,
		["247"] = 249,
		["248"] = 248,
		["249"] = 220,
		["250"] = 212,
		["251"] = 212,
		["252"] = 212,
		["253"] = 212,
		["254"] = 212,
		["255"] = 212,
		["256"] = 212,
		["257"] = 212,
		["258"] = 220,
		["260"] = 220,
		["261"] = 255,
		["262"] = 256,
		["263"] = 255,
		["264"] = 256,
		["265"] = 257,
		["266"] = 258,
		["267"] = 259,
		["268"] = 260,
		["271"] = 263,
		["272"] = 265,
		["273"] = 266,
		["274"] = 267,
		["275"] = 268,
		["276"] = 269,
		["277"] = 270,
		["278"] = 271,
		["279"] = 271,
		["280"] = 271,
		["281"] = 272,
		["282"] = 273,
		["283"] = 274,
		["284"] = 275,
		["285"] = 276,
		["286"] = 277,
		["287"] = 278,
		["289"] = 281,
		["290"] = 282,
		["292"] = 271,
		["293"] = 271,
		["294"] = 285,
		["295"] = 286,
		["296"] = 287,
		["297"] = 257,
		["298"] = 256,
		["299"] = 255,
		["300"] = 256,
		["302"] = 256,
		["303"] = 293,
		["304"] = 301,
		["305"] = 293,
		["306"] = 301,
		["307"] = 306,
		["308"] = 307,
		["309"] = 306,
		["310"] = 309,
		["311"] = 310,
		["312"] = 311,
		["313"] = 312,
		["314"] = 312,
		["315"] = 312,
		["316"] = 313,
		["317"] = 314,
		["319"] = 312,
		["320"] = 312,
		["322"] = 309,
		["323"] = 319,
		["324"] = 320,
		["327"] = 321,
		["330"] = 322,
		["331"] = 323,
		["332"] = 324,
		["333"] = 325,
		["335"] = 325,
		["337"] = 326,
		["339"] = 328,
		["340"] = 328,
		["341"] = 328,
		["342"] = 328,
		["343"] = 328,
		["344"] = 328,
		["346"] = 319,
		["347"] = 301,
		["348"] = 293,
		["349"] = 293,
		["350"] = 293,
		["351"] = 293,
		["352"] = 293,
		["353"] = 293,
		["354"] = 293,
		["355"] = 293,
		["356"] = 301,
		["358"] = 301,
		["359"] = 336,
		["360"] = 344,
		["361"] = 336,
		["362"] = 344,
		["363"] = 349,
		["364"] = 350,
		["365"] = 349,
		["366"] = 352,
		["367"] = 353,
		["368"] = 354,
		["369"] = 355,
		["370"] = 355,
		["371"] = 355,
		["372"] = 356,
		["373"] = 357,
		["375"] = 355,
		["376"] = 355,
		["378"] = 352,
		["379"] = 362,
		["380"] = 363,
		["383"] = 364,
		["384"] = 365,
		["385"] = 366,
		["386"] = 367,
		["387"] = 368,
		["389"] = 370,
		["390"] = 370,
		["391"] = 370,
		["392"] = 370,
		["393"] = 370,
		["394"] = 370,
		["396"] = 362,
		["397"] = 344,
		["398"] = 336,
		["399"] = 336,
		["400"] = 336,
		["401"] = 336,
		["402"] = 336,
		["403"] = 336,
		["404"] = 336,
		["405"] = 336,
		["406"] = 344,
		["408"] = 344,
		["409"] = 378,
		["410"] = 386,
		["411"] = 378,
		["412"] = 386,
		["413"] = 400,
		["414"] = 401,
		["415"] = 402,
		["416"] = 403,
		["417"] = 400,
		["418"] = 405,
		["419"] = 406,
		["420"] = 407,
		["421"] = 408,
		["422"] = 409,
		["423"] = 410,
		["424"] = 411,
		["425"] = 412,
		["427"] = 414,
		["429"] = 405,
		["430"] = 417,
		["431"] = 418,
		["432"] = 419,
		["433"] = 420,
		["435"] = 417,
		["436"] = 423,
		["437"] = 424,
		["438"] = 425,
		["439"] = 426,
		["440"] = 427,
		["441"] = 428,
		["442"] = 428,
		["443"] = 428,
		["444"] = 428,
		["445"] = 428,
		["446"] = 428,
		["447"] = 429,
		["448"] = 430,
		["449"] = 430,
		["450"] = 430,
		["451"] = 430,
		["452"] = 430,
		["453"] = 431,
		["454"] = 432,
		["455"] = 432,
		["456"] = 432,
		["457"] = 432,
		["458"] = 432,
		["461"] = 423,
		["462"] = 436,
		["463"] = 437,
		["464"] = 438,
		["465"] = 439,
		["468"] = 443,
		["469"] = 444,
		["470"] = 444,
		["472"] = 450,
		["473"] = 451,
		["476"] = 454,
		["479"] = 458,
		["480"] = 459,
		["481"] = 460,
		["482"] = 461,
		["483"] = 461,
		["484"] = 461,
		["485"] = 462,
		["486"] = 463,
		["487"] = 464,
		["488"] = 465,
		["489"] = 466,
		["490"] = 467,
		["492"] = 461,
		["493"] = 461,
		["494"] = 470,
		["495"] = 472,
		["496"] = 472,
		["497"] = 472,
		["498"] = 472,
		["499"] = 473,
		["500"] = 473,
		["501"] = 473,
		["502"] = 473,
		["503"] = 473,
		["504"] = 473,
		["505"] = 473,
		["506"] = 473,
		["507"] = 436,
		["508"] = 475,
		["509"] = 476,
		["510"] = 477,
		["511"] = 475,
		["512"] = 484,
		["513"] = 485,
		["514"] = 484,
		["515"] = 386,
		["516"] = 378,
		["517"] = 378,
		["518"] = 378,
		["519"] = 378,
		["520"] = 378,
		["521"] = 378,
		["522"] = 378,
		["523"] = 378,
		["524"] = 386,
		["526"] = 386,
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
	}
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