--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
		["48"] = 52,
		["49"] = 53,
		["50"] = 55,
		["51"] = 55,
		["52"] = 55,
		["53"] = 56,
		["54"] = 57,
		["55"] = 57,
		["56"] = 57,
		["57"] = 57,
		["59"] = 55,
		["60"] = 55,
		["62"] = 52,
		["63"] = 62,
		["64"] = 63,
		["65"] = 62,
		["66"] = 70,
		["67"] = 71,
		["68"] = 72,
		["70"] = 70,
		["71"] = 75,
		["72"] = 76,
		["73"] = 77,
		["75"] = 75,
		["76"] = 80,
		["77"] = 81,
		["78"] = 82,
		["79"] = 83,
		["80"] = 84,
		["83"] = 80,
		["84"] = 88,
		["85"] = 89,
		["86"] = 89,
		["87"] = 91,
		["88"] = 91,
		["89"] = 91,
		["90"] = 89,
		["91"] = 92,
		["92"] = 92,
		["93"] = 92,
		["94"] = 89,
		["95"] = 93,
		["96"] = 93,
		["97"] = 93,
		["98"] = 89,
		["99"] = 89,
		["100"] = 88,
		["101"] = 96,
		["102"] = 98,
		["105"] = 101,
		["106"] = 102,
		["108"] = 96,
		["109"] = 105,
		["110"] = 106,
		["111"] = 107,
		["112"] = 108,
		["113"] = 105,
		["114"] = 121,
		["115"] = 122,
		["118"] = 123,
		["119"] = 124,
		["120"] = 124,
		["121"] = 124,
		["122"] = 124,
		["124"] = 127,
		["125"] = 128,
		["126"] = 129,
		["129"] = 132,
		["130"] = 133,
		["131"] = 133,
		["132"] = 133,
		["133"] = 133,
		["134"] = 133,
		["135"] = 133,
		["137"] = 121,
		["138"] = 136,
		["139"] = 137,
		["140"] = 139,
		["141"] = 140,
		["142"] = 142,
		["143"] = 143,
		["145"] = 146,
		["146"] = 147,
		["148"] = 149,
		["149"] = 150,
		["150"] = 151,
		["151"] = 151,
		["152"] = 151,
		["153"] = 151,
		["154"] = 151,
		["155"] = 151,
		["160"] = 156,
		["161"] = 157,
		["164"] = 160,
		["165"] = 161,
		["166"] = 162,
		["167"] = 172,
		["168"] = 173,
		["169"] = 136,
		["170"] = 175,
		["171"] = 190,
		["172"] = 191,
		["173"] = 192,
		["174"] = 194,
		["175"] = 195,
		["176"] = 196,
		["178"] = 198,
		["179"] = 199,
		["182"] = 175,
		["183"] = 204,
		["184"] = 205,
		["185"] = 206,
		["186"] = 207,
		["187"] = 208,
		["189"] = 204,
		["190"] = 20,
		["191"] = 12,
		["192"] = 12,
		["193"] = 12,
		["194"] = 12,
		["195"] = 12,
		["196"] = 12,
		["197"] = 12,
		["198"] = 12,
		["199"] = 20,
		["201"] = 20,
		["202"] = 212,
		["203"] = 220,
		["204"] = 212,
		["205"] = 220,
		["206"] = 223,
		["207"] = 224,
		["208"] = 225,
		["209"] = 223,
		["210"] = 227,
		["211"] = 228,
		["212"] = 229,
		["213"] = 230,
		["214"] = 231,
		["215"] = 231,
		["216"] = 231,
		["217"] = 231,
		["218"] = 231,
		["219"] = 231,
		["220"] = 231,
		["221"] = 231,
		["222"] = 231,
		["223"] = 232,
		["224"] = 232,
		["225"] = 232,
		["226"] = 232,
		["227"] = 232,
		["228"] = 232,
		["229"] = 232,
		["230"] = 232,
		["231"] = 232,
		["232"] = 233,
		["233"] = 233,
		["234"] = 233,
		["235"] = 233,
		["236"] = 233,
		["237"] = 233,
		["238"] = 233,
		["239"] = 233,
		["240"] = 233,
		["241"] = 234,
		["242"] = 234,
		["243"] = 234,
		["244"] = 234,
		["245"] = 234,
		["246"] = 234,
		["247"] = 234,
		["248"] = 234,
		["250"] = 236,
		["252"] = 227,
		["253"] = 239,
		["254"] = 240,
		["255"] = 239,
		["256"] = 245,
		["257"] = 246,
		["258"] = 245,
		["259"] = 248,
		["260"] = 249,
		["261"] = 248,
		["262"] = 220,
		["263"] = 212,
		["264"] = 212,
		["265"] = 212,
		["266"] = 212,
		["267"] = 212,
		["268"] = 212,
		["269"] = 212,
		["270"] = 212,
		["271"] = 220,
		["273"] = 220,
		["274"] = 255,
		["275"] = 256,
		["276"] = 255,
		["277"] = 256,
		["278"] = 257,
		["279"] = 258,
		["280"] = 259,
		["281"] = 260,
		["284"] = 263,
		["285"] = 265,
		["286"] = 266,
		["287"] = 267,
		["288"] = 268,
		["289"] = 269,
		["290"] = 270,
		["291"] = 271,
		["292"] = 271,
		["293"] = 271,
		["294"] = 272,
		["295"] = 273,
		["296"] = 274,
		["297"] = 275,
		["298"] = 276,
		["299"] = 277,
		["300"] = 278,
		["302"] = 281,
		["303"] = 282,
		["305"] = 271,
		["306"] = 271,
		["307"] = 285,
		["308"] = 286,
		["309"] = 287,
		["310"] = 257,
		["311"] = 256,
		["312"] = 255,
		["313"] = 256,
		["315"] = 256,
		["316"] = 293,
		["317"] = 301,
		["318"] = 293,
		["319"] = 301,
		["320"] = 306,
		["321"] = 307,
		["322"] = 306,
		["323"] = 309,
		["324"] = 310,
		["325"] = 311,
		["326"] = 312,
		["327"] = 312,
		["328"] = 312,
		["329"] = 313,
		["330"] = 314,
		["332"] = 312,
		["333"] = 312,
		["335"] = 309,
		["336"] = 319,
		["337"] = 320,
		["340"] = 321,
		["343"] = 322,
		["344"] = 323,
		["345"] = 324,
		["346"] = 325,
		["348"] = 325,
		["350"] = 326,
		["352"] = 328,
		["353"] = 328,
		["354"] = 328,
		["355"] = 328,
		["356"] = 328,
		["357"] = 328,
		["359"] = 319,
		["360"] = 301,
		["361"] = 293,
		["362"] = 293,
		["363"] = 293,
		["364"] = 293,
		["365"] = 293,
		["366"] = 293,
		["367"] = 293,
		["368"] = 293,
		["369"] = 301,
		["371"] = 301,
		["372"] = 336,
		["373"] = 344,
		["374"] = 336,
		["375"] = 344,
		["376"] = 349,
		["377"] = 350,
		["378"] = 349,
		["379"] = 352,
		["380"] = 353,
		["381"] = 354,
		["382"] = 355,
		["383"] = 355,
		["384"] = 355,
		["385"] = 356,
		["386"] = 357,
		["388"] = 355,
		["389"] = 355,
		["391"] = 352,
		["392"] = 362,
		["393"] = 363,
		["396"] = 364,
		["397"] = 365,
		["398"] = 366,
		["399"] = 367,
		["400"] = 368,
		["402"] = 370,
		["403"] = 370,
		["404"] = 370,
		["405"] = 370,
		["406"] = 370,
		["407"] = 370,
		["409"] = 362,
		["410"] = 344,
		["411"] = 336,
		["412"] = 336,
		["413"] = 336,
		["414"] = 336,
		["415"] = 336,
		["416"] = 336,
		["417"] = 336,
		["418"] = 336,
		["419"] = 344,
		["421"] = 344,
		["422"] = 378,
		["423"] = 386,
		["424"] = 378,
		["425"] = 386,
		["426"] = 400,
		["427"] = 401,
		["428"] = 402,
		["429"] = 403,
		["430"] = 400,
		["431"] = 405,
		["432"] = 406,
		["433"] = 407,
		["434"] = 408,
		["435"] = 409,
		["436"] = 410,
		["437"] = 411,
		["438"] = 412,
		["440"] = 414,
		["442"] = 405,
		["443"] = 417,
		["444"] = 418,
		["445"] = 419,
		["446"] = 420,
		["448"] = 417,
		["449"] = 423,
		["450"] = 424,
		["451"] = 425,
		["452"] = 426,
		["453"] = 427,
		["454"] = 428,
		["455"] = 428,
		["456"] = 428,
		["457"] = 428,
		["458"] = 428,
		["459"] = 428,
		["460"] = 429,
		["461"] = 430,
		["462"] = 430,
		["463"] = 430,
		["464"] = 430,
		["465"] = 430,
		["466"] = 431,
		["467"] = 432,
		["468"] = 432,
		["469"] = 432,
		["470"] = 432,
		["471"] = 432,
		["474"] = 423,
		["475"] = 436,
		["476"] = 437,
		["477"] = 438,
		["478"] = 439,
		["481"] = 443,
		["482"] = 444,
		["483"] = 444,
		["485"] = 450,
		["486"] = 451,
		["489"] = 454,
		["492"] = 458,
		["493"] = 459,
		["494"] = 460,
		["495"] = 461,
		["496"] = 461,
		["497"] = 461,
		["498"] = 462,
		["499"] = 463,
		["500"] = 464,
		["501"] = 465,
		["502"] = 466,
		["503"] = 467,
		["505"] = 461,
		["506"] = 461,
		["507"] = 470,
		["508"] = 472,
		["509"] = 472,
		["510"] = 472,
		["511"] = 472,
		["512"] = 473,
		["513"] = 473,
		["514"] = 473,
		["515"] = 473,
		["516"] = 473,
		["517"] = 473,
		["518"] = 473,
		["519"] = 473,
		["520"] = 436,
		["521"] = 475,
		["522"] = 476,
		["523"] = 477,
		["524"] = 475,
		["525"] = 484,
		["526"] = 485,
		["527"] = 484,
		["528"] = 386,
		["529"] = 378,
		["530"] = 378,
		["531"] = 378,
		["532"] = 378,
		["533"] = 378,
		["534"] = 378,
		["535"] = 378,
		["536"] = 378,
		["537"] = 386,
		["539"] = 386,
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
function t.prototype.OnCreated(self)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED, function(u, v, w)
			if w == u:GetParent() and v.is_crit and v.ability == u:GetAbility() and u:HasTalent("kunkka_talent_10") then
				v.damage_flags = bit.bor(
					v.damage_flags,
					bit.bor(
						DamageFlags.DAMAGE_FLAG_NO_DAMAGE_INCOMING,
						DamageFlags.DAMAGE_FLAG_NO_EVASION_DAMAGE_INCOMING
					)
				)
			end
		end)
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
function t.prototype.EOM_GetModifierPhysicalCriticalStrikeChanceBonus(self, x)
	if (x and x.ability) == self:GetAbility() then
		return self.talent_10_crit_bonus
	end
end
function t.prototype.EOM_GetModifierMagicalCriticalStrikeChance(self, x)
	if (x and x.ability) == self:GetAbility() then
		return self.talent_10_crit_bonus
	end
end
function t.prototype.EOM_GetModifierProcAttackDamageBonus(self, x)
	if IsServer() then
		if self.enable and IsValid(x and x.ability) and x.ability == self:GetAbility() then
			local y = self:GetParent():GetMaxHealth() * self.talent_7_damage_pct * 0.01
			return self.bonus_damage + self:GetParent():GetHealthDeficit() * self.bonus_damage_pct * 0.01 + y
		end
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BLOCK] = { -1, self:GetParent() },
	}
end
function t.prototype.OnBlock(self, v)
	if v.attacker ~= self:GetParent() or v.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if self.enable and self:GetParent():HasModifier("modifier_kunkka_talent_buff") then
		self.enable = false
	end
end
function t.prototype.OnBattleStart(self, x)
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
		local z = self:GetParent()
		z:AddNewModifier(z, self:GetAbility(), "modifier_kunkka_talent_buff", {})
	end
end
function t.prototype.OnCustomAttackLanded(self, v)
	local z = self:GetParent()
	if not (self.enable and z:HasModifier("modifier_kunkka_talent_buff")) then
		if self.cooldown_remain > 0 then
			if self.s_interval > 0 then
				self.cooldown_remain = self.cooldown_remain - self.s_interval
			end
			if self.talent_1_reduce_interval > 0 then
				self.cooldown_remain = self.cooldown_remain - -self.talent_1_reduce_interval
			end
			if self.cooldown_remain <= 0 then
				local z = self:GetParent()
				z:AddNewModifier(z, self:GetAbility(), "modifier_kunkka_talent_buff", {})
			end
		end
		return
	end
	local A = v.target
	if not IsInjurable(z, A) then
		return
	end
	z:RemoveModifierByName("modifier_kunkka_talent_buff")
	self.enable = false
	self.cooldown_remain = self.cooldown
	A:EmitSound("Hero_Kunkka.TidebringerDamage")
	z:EmitSound("Hero_Kunkka.Tidebringer.Attack")
end
function t.prototype.OnCustomTakeDamage(self, v)
	if self.talent_3_rum_up > 0 then
		local z = self:GetParent()
		if z:GetHealthPercent() <= self.talent_3_rum_up then
			local B = z:FindAbilityByName("kunkka_ult")
			if IsValid(B) then
				z:AddNewModifier(z, B, "modifier_kunkka_ult_damage_record", {})
			end
		elseif z:HasModifier("modifier_kunkka_ult_damage_record") then
			z:RemoveModifierByName("modifier_kunkka_ult_damage_record")
		end
	end
end
function t.prototype.EOM_GetModifierAttackSourceAbility(self, x)
	local z = self:GetParent()
	if not self.enable and z:HasModifier("modifier_kunkka_talent_buff") then
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
local C = i.modifier_kunkka_talent_buff
C.name = "modifier_kunkka_talent_buff"
d(C, n)
function C.prototype.GetAbilitySpecialValue(self)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
end
function C.prototype.OnCreated(self, x)
	local z = self:GetParent()
	if IsClient() then
		local D = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			z
		)
		ParticleManager:SetParticleControlEnt(
			D,
			0,
			z,
			PATTACH_POINT_FOLLOW,
			"attach_tidebringer",
			z:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			D,
			1,
			z,
			PATTACH_POINT_FOLLOW,
			"attach_tidebringer_2",
			z:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(D, 2, z, PATTACH_POINT_FOLLOW, "attach_sword", z:GetAbsOrigin(), true)
		self:AddParticle(D, false, false, -1, false, false)
	else
		z:EmitSound("Hero_Kunkaa.Tidebringer")
	end
end
function C.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function C.prototype.GetActivityTranslationModifiers(self)
	return "tidebringer"
end
function C.prototype.GetAttackSound(self)
	return "Hero_Kunkka.Tidebringer.Attack"
end
C = e(
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
	C
)
i.modifier_kunkka_talent_buff = C
i.kunkka_ult = c()
local E = i.kunkka_ult
E.name = "kunkka_ult"
d(E, q)
function E.prototype.OnSpellStart(self)
	local F = self:GetCaster()
	local A = F:GetEnemy()
	if not IsInjurable(A, F) then
		return
	end
	local G = self:GetSpecialValueFor("duration")
	local H = self:GetSpecialValueFor("damage_pct") + self:GetTalentValue("kunkka_talent_2", "rum_damage_pct")
	local I = (A:GetAbsOrigin() - F:GetAbsOrigin()):Normalized()
	local J = A:GetAbsOrigin() + I * -400 * G
	local D = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf",
		PATTACH_CUSTOMORIGIN,
		F
	)
	ParticleManager:SetParticleControl(D, 0, J)
	ParticleManager:SetParticleControl(D, 1, I * 400)
	GameTimer(G, function()
		ParticleManager:DestroyParticle(D, false)
		if IsInjurable(F, A) then
			local K = self:GetSpecialValueFor("damage")
			local L = F:FindModifierByName("modifier_kunkka_ult")
			if IsValid(L) then
				local M = L:getTotalRecord()
				K = K + M * H * 0.01
			end
			F:DealDamage(A, self, K, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			F:EmitSound("Ability.Ghostship.crash")
		end
	end)
	F:EmitSound("Ability.Ghostship.bell")
	F:EmitSound("Ability.Ghostship")
	F:AddNewModifier(F, self, "modifier_kunkka_ult_damage_record_ult", { duration = G })
end
E = e({ r(nil) }, E)
i.kunkka_ult = E
i.modifier_kunkka_ult_damage_record_ult = c()
local N = i.modifier_kunkka_ult_damage_record_ult
N.name = "modifier_kunkka_ult_damage_record_ult"
d(N, n)
function N.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("kunkka_talent_6", "rum_reduce_pct")
end
function N.prototype.OnCreated(self, x)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(u, x, O, A)
			if A == self:GetParent() then
				self:OnPreDamage(x)
			end
		end)
	end
end
function N.prototype.OnPreDamage(self, v)
	if v.ability == self.rum_ability then
		return
	end
	if self:GetParent():HasModifier("modifier_kunkka_ult_damage_record") then
		return
	end
	local P = math.floor(v.damage * self.reduce_pct * 0.01)
	v.damage = v.damage - P
	if IsValid(self.rum_modifier) and self.rum_modifier.RecordDamage ~= nil then
		local Q = self.rum_modifier
		if Q ~= nil then
			Q:RecordDamage(P)
		end
		self.rum_modifier:SetDuration(BUFF_VALUE.DrunkDuration, true)
	else
		self.rum_modifier = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_kunkka_ult",
			{ duration = BUFF_VALUE.DrunkDuration, record_damage = P }
		)
	end
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
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	N
)
i.modifier_kunkka_ult_damage_record_ult = N
i.modifier_kunkka_ult_damage_record = c()
local R = i.modifier_kunkka_ult_damage_record
R.name = "modifier_kunkka_ult_damage_record"
d(R, n)
function R.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = BUFF_VALUE.DrunkReduce + self:GetAbilityTalentValue("kunkka_talent_6", "rum_reduce_pct")
end
function R.prototype.OnCreated(self, x)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.hookID = self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(u, x, O, A)
			if A == self:GetParent() then
				self:OnPreDamage(x)
			end
		end)
	end
end
function R.prototype.OnPreDamage(self, v)
	if v.ability == self.rum_ability then
		return
	end
	local P = math.floor(v.damage * self.reduce_pct * 0.01)
	v.damage = v.damage - P
	if IsValid(self.rum_modifier) then
		self.rum_modifier:RecordDamage(P)
		self.rum_modifier:SetDuration(BUFF_VALUE.DrunkDuration, true)
	else
		self.rum_modifier = self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_kunkka_ult",
			{ duration = BUFF_VALUE.DrunkDuration, record_damage = P }
		)
	end
end
R = e(
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
	R
)
i.modifier_kunkka_ult_damage_record = R
i.modifier_kunkka_ult = c()
local S = i.modifier_kunkka_ult
S.name = "modifier_kunkka_ult"
d(S, n)
function S.prototype.GetAbilitySpecialValue(self)
	self.rum_duration = BUFF_VALUE.DrunkDuration
	self.talent_2_interval = self:GetAbilityTalentValue("kunkka_talent_2", "interval")
	self.talent_2_damage_pct = self:GetAbilityTalentValue("kunkka_talent_2", "damage_pct")
end
function S.prototype.OnCreated(self, x)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self.record = 0
		self.recordList = {}
		self:RecordDamage(x and x.record_damage or 0)
		if self.talent_2_interval > 0 then
			self:StartThink(self.talent_2_interval, "kunkka_talent_2")
		end
		self:StartIntervalThink(1)
	end
end
function S.prototype.OnRefresh(self, x)
	if IsServer() then
		self.rum_ability = self:GetParent():FindAbilityByName("rum_displayer")
		self:RecordDamage(x and x.record_damage or 0)
	end
end
function S.prototype.OnThink(self, T)
	if T == "kunkka_talent_2" then
		local z = self:GetParent()
		local A = self:GetParent():GetEnemy()
		if IsInjurable(z, A) and self:getTotalRecord() > 0 then
			z:DealDamage(
				A,
				self:GetParent():FindAbilityByName("kunkka_talent_2"),
				self:getTotalRecord() * self.talent_2_damage_pct * 0.01,
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
			)
			local D = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				A,
				z
			)
			ParticleManager:SetParticleControl(D, 0, A:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(D)
			EmitSoundOnLocationWithCaster(A:GetAbsOrigin(), "Ability.Torrent", z)
		end
	end
end
function S.prototype.OnIntervalThink(self)
	local z = self:GetParent()
	local A = z:GetEnemy()
	if not IsInjurable(z, A) then
		return
	end
	if self.record > 0 then
		local U = self.recordList
		U[#U + 1] = { damage = self.record, remainDamage = self.record, time = 0 }
	else
		if self:GetStackCount() <= 0 then
			self:Destroy()
			return
		else
			self:SetDuration(BUFF_VALUE.DrunkDuration, true)
		end
	end
	self.record = 0
	local K = 0
	local V = 0
	f(self.recordList, function(W, X, Y)
		if X.remainDamage > 0 then
			X.time = X.time + 1
			local Z = X.time == self.rum_duration and X.remainDamage or X.damage * 1 / self.rum_duration
			X.remainDamage = X.remainDamage - Z
			V = V + X.remainDamage
			K = K + Z
		end
	end)
	self:SetStackCount(V)
	self.recordList = g(self.recordList, function(W, X)
		return X.remainDamage > 0
	end)
	A:DealDamage(
		z,
		self.rum_ability,
		K,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
		DamageFlags.DAMAGE_FLAG_NO_LETHAL
			+ DamageFlags.DAMAGE_FLAG_REFLECTION
			+ DamageFlags.DAMAGE_FLAG_NO_DAMAGE_OUTGOING
			+ DamageFlags.DAMAGE_FLAG_PURE_INCOMING,
		"Rum"
	)
end
function S.prototype.RecordDamage(self, K)
	self.record = self.record + K
	self:SetStackCount(self:GetStackCount() + K)
end
function S.prototype.getTotalRecord(self)
	return self:GetStackCount()
end
S = e(
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
	S
)
i.modifier_kunkka_ult = S
return i