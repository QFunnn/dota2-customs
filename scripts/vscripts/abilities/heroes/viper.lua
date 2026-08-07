--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/viper"
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
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["33"] = 33,
		["34"] = 34,
		["35"] = 35,
		["36"] = 36,
		["38"] = 38,
		["39"] = 39,
		["40"] = 44,
		["41"] = 45,
		["42"] = 46,
		["43"] = 47,
		["44"] = 48,
		["45"] = 50,
		["46"] = 33,
		["47"] = 52,
		["48"] = 53,
		["49"] = 54,
		["51"] = 52,
		["52"] = 57,
		["53"] = 58,
		["54"] = 59,
		["56"] = 61,
		["57"] = 62,
		["58"] = 63,
		["61"] = 57,
		["62"] = 67,
		["63"] = 68,
		["64"] = 68,
		["65"] = 70,
		["66"] = 70,
		["67"] = 70,
		["68"] = 68,
		["69"] = 71,
		["70"] = 71,
		["71"] = 71,
		["72"] = 68,
		["73"] = 68,
		["74"] = 67,
		["75"] = 74,
		["76"] = 75,
		["77"] = 74,
		["78"] = 79,
		["79"] = 79,
		["80"] = 82,
		["81"] = 83,
		["84"] = 84,
		["85"] = 82,
		["86"] = 86,
		["87"] = 87,
		["88"] = 88,
		["89"] = 89,
		["90"] = 90,
		["91"] = 91,
		["94"] = 95,
		["95"] = 96,
		["96"] = 97,
		["98"] = 86,
		["99"] = 100,
		["100"] = 101,
		["101"] = 102,
		["103"] = 100,
		["104"] = 104,
		["105"] = 105,
		["106"] = 106,
		["109"] = 108,
		["110"] = 109,
		["111"] = 110,
		["112"] = 111,
		["113"] = 112,
		["114"] = 113,
		["115"] = 114,
		["117"] = 123,
		["118"] = 123,
		["119"] = 123,
		["120"] = 123,
		["121"] = 123,
		["122"] = 123,
		["123"] = 123,
		["124"] = 123,
		["125"] = 123,
		["126"] = 123,
		["127"] = 123,
		["128"] = 124,
		["129"] = 124,
		["130"] = 124,
		["131"] = 124,
		["132"] = 124,
		["133"] = 124,
		["134"] = 124,
		["135"] = 125,
		["136"] = 125,
		["137"] = 125,
		["138"] = 125,
		["139"] = 125,
		["140"] = 125,
		["141"] = 104,
		["142"] = 20,
		["143"] = 12,
		["144"] = 12,
		["145"] = 12,
		["146"] = 12,
		["147"] = 12,
		["148"] = 12,
		["149"] = 12,
		["150"] = 12,
		["151"] = 20,
		["153"] = 20,
		["154"] = 139,
		["155"] = 148,
		["156"] = 139,
		["157"] = 148,
		["158"] = 152,
		["159"] = 153,
		["160"] = 154,
		["161"] = 155,
		["162"] = 152,
		["163"] = 157,
		["164"] = 158,
		["165"] = 159,
		["167"] = 157,
		["168"] = 163,
		["169"] = 164,
		["170"] = 165,
		["171"] = 166,
		["174"] = 163,
		["175"] = 172,
		["176"] = 173,
		["177"] = 172,
		["178"] = 179,
		["179"] = 180,
		["180"] = 179,
		["181"] = 182,
		["182"] = 183,
		["183"] = 182,
		["184"] = 148,
		["185"] = 139,
		["186"] = 139,
		["187"] = 139,
		["188"] = 139,
		["189"] = 139,
		["190"] = 139,
		["191"] = 139,
		["192"] = 139,
		["193"] = 139,
		["194"] = 148,
		["196"] = 148,
		["197"] = 188,
		["198"] = 197,
		["199"] = 188,
		["200"] = 197,
		["201"] = 203,
		["202"] = 204,
		["203"] = 205,
		["204"] = 206,
		["205"] = 207,
		["206"] = 208,
		["207"] = 209,
		["208"] = 209,
		["210"] = 211,
		["211"] = 211,
		["212"] = 211,
		["213"] = 211,
		["214"] = 211,
		["215"] = 212,
		["216"] = 212,
		["217"] = 212,
		["218"] = 212,
		["219"] = 212,
		["220"] = 212,
		["221"] = 212,
		["222"] = 212,
		["224"] = 203,
		["225"] = 215,
		["226"] = 216,
		["227"] = 217,
		["228"] = 218,
		["229"] = 218,
		["231"] = 215,
		["232"] = 221,
		["233"] = 222,
		["234"] = 223,
		["235"] = 224,
		["236"] = 225,
		["237"] = 226,
		["240"] = 221,
		["241"] = 230,
		["242"] = 231,
		["243"] = 230,
		["244"] = 235,
		["245"] = 236,
		["246"] = 235,
		["247"] = 197,
		["248"] = 188,
		["249"] = 188,
		["250"] = 188,
		["251"] = 188,
		["252"] = 188,
		["253"] = 188,
		["254"] = 188,
		["255"] = 188,
		["256"] = 197,
		["258"] = 197,
		["259"] = 242,
		["260"] = 243,
		["261"] = 242,
		["262"] = 243,
		["263"] = 245,
		["264"] = 246,
		["265"] = 247,
		["266"] = 249,
		["267"] = 250,
		["268"] = 251,
		["269"] = 252,
		["270"] = 253,
		["271"] = 253,
		["272"] = 253,
		["273"] = 253,
		["275"] = 253,
		["276"] = 255,
		["277"] = 256,
		["278"] = 257,
		["279"] = 257,
		["280"] = 257,
		["281"] = 257,
		["282"] = 257,
		["283"] = 257,
		["284"] = 257,
		["285"] = 257,
		["286"] = 257,
		["287"] = 258,
		["288"] = 258,
		["289"] = 258,
		["290"] = 258,
		["291"] = 258,
		["292"] = 259,
		["293"] = 259,
		["294"] = 259,
		["295"] = 259,
		["296"] = 259,
		["297"] = 260,
		["298"] = 260,
		["299"] = 260,
		["300"] = 260,
		["301"] = 260,
		["302"] = 261,
		["303"] = 261,
		["304"] = 261,
		["305"] = 261,
		["306"] = 261,
		["307"] = 262,
		["308"] = 262,
		["309"] = 262,
		["310"] = 262,
		["311"] = 262,
		["312"] = 263,
		["313"] = 263,
		["314"] = 263,
		["315"] = 263,
		["316"] = 263,
		["317"] = 263,
		["318"] = 270,
		["319"] = 271,
		["320"] = 271,
		["321"] = 271,
		["322"] = 271,
		["323"] = 271,
		["324"] = 271,
		["325"] = 271,
		["326"] = 272,
		["327"] = 273,
		["328"] = 273,
		["329"] = 273,
		["330"] = 273,
		["331"] = 273,
		["332"] = 273,
		["333"] = 273,
		["334"] = 274,
		["335"] = 275,
		["336"] = 276,
		["337"] = 276,
		["338"] = 276,
		["339"] = 276,
		["340"] = 276,
		["341"] = 276,
		["342"] = 276,
		["343"] = 276,
		["344"] = 276,
		["346"] = 263,
		["347"] = 279,
		["348"] = 280,
		["349"] = 263,
		["350"] = 263,
		["351"] = 284,
		["352"] = 285,
		["354"] = 288,
		["355"] = 289,
		["356"] = 290,
		["357"] = 290,
		["358"] = 290,
		["360"] = 290,
		["361"] = 245,
		["362"] = 292,
		["363"] = 293,
		["364"] = 294,
		["365"] = 295,
		["368"] = 296,
		["369"] = 297,
		["370"] = 298,
		["371"] = 301,
		["372"] = 301,
		["373"] = 301,
		["374"] = 301,
		["375"] = 301,
		["376"] = 301,
		["377"] = 301,
		["378"] = 292,
		["379"] = 243,
		["380"] = 242,
		["381"] = 243,
		["383"] = 243,
		["384"] = 306,
		["385"] = 318,
		["386"] = 306,
		["387"] = 318,
		["388"] = 323,
		["389"] = 324,
		["390"] = 325,
		["391"] = 326,
		["392"] = 328,
		["393"] = 323,
		["394"] = 330,
		["395"] = 331,
		["396"] = 330,
		["397"] = 336,
		["398"] = 337,
		["399"] = 336,
		["400"] = 339,
		["401"] = 340,
		["402"] = 339,
		["403"] = 318,
		["404"] = 306,
		["405"] = 306,
		["406"] = 306,
		["407"] = 306,
		["408"] = 306,
		["409"] = 306,
		["410"] = 306,
		["411"] = 306,
		["412"] = 306,
		["413"] = 306,
		["414"] = 306,
		["415"] = 306,
		["416"] = 318,
		["418"] = 318,
		["419"] = 344,
		["420"] = 353,
		["421"] = 344,
		["422"] = 353,
		["423"] = 363,
		["424"] = 364,
		["425"] = 365,
		["426"] = 366,
		["427"] = 367,
		["428"] = 368,
		["429"] = 369,
		["430"] = 370,
		["431"] = 363,
		["432"] = 372,
		["433"] = 373,
		["434"] = 374,
		["435"] = 375,
		["436"] = 376,
		["439"] = 379,
		["440"] = 380,
		["441"] = 380,
		["442"] = 380,
		["443"] = 380,
		["444"] = 380,
		["445"] = 380,
		["446"] = 380,
		["447"] = 380,
		["449"] = 372,
		["450"] = 383,
		["451"] = 384,
		["452"] = 385,
		["453"] = 385,
		["454"] = 385,
		["455"] = 385,
		["456"] = 385,
		["457"] = 385,
		["458"] = 385,
		["460"] = 383,
		["461"] = 388,
		["462"] = 389,
		["463"] = 388,
		["464"] = 395,
		["465"] = 396,
		["466"] = 395,
		["467"] = 398,
		["468"] = 399,
		["469"] = 398,
		["470"] = 353,
		["471"] = 344,
		["472"] = 344,
		["473"] = 344,
		["474"] = 344,
		["475"] = 344,
		["476"] = 344,
		["477"] = 344,
		["478"] = 344,
		["479"] = 344,
		["480"] = 353,
		["482"] = 353,
		["483"] = 411,
		["484"] = 412,
		["485"] = 411,
		["486"] = 412,
		["487"] = 413,
		["488"] = 414,
		["489"] = 413,
		["490"] = 412,
		["491"] = 411,
		["492"] = 412,
		["494"] = 412,
		["495"] = 417,
		["496"] = 425,
		["497"] = 417,
		["498"] = 425,
		["499"] = 427,
		["500"] = 428,
		["501"] = 427,
		["502"] = 430,
		["503"] = 431,
		["504"] = 430,
		["505"] = 425,
		["506"] = 417,
		["507"] = 417,
		["508"] = 417,
		["509"] = 417,
		["510"] = 417,
		["511"] = 417,
		["512"] = 417,
		["513"] = 417,
		["514"] = 425,
		["516"] = 425,
		["518"] = 438,
		["519"] = 447,
		["520"] = 438,
		["521"] = 447,
		["522"] = 452,
		["523"] = 453,
		["524"] = 454,
		["525"] = 452,
		["526"] = 457,
		["527"] = 458,
		["528"] = 459,
		["530"] = 461,
		["531"] = 461,
		["532"] = 461,
		["533"] = 461,
		["534"] = 461,
		["535"] = 462,
		["536"] = 462,
		["537"] = 462,
		["538"] = 462,
		["539"] = 462,
		["540"] = 462,
		["541"] = 462,
		["542"] = 462,
		["544"] = 457,
		["545"] = 465,
		["546"] = 466,
		["547"] = 465,
		["548"] = 471,
		["549"] = 471,
		["550"] = 474,
		["551"] = 475,
		["552"] = 474,
		["553"] = 447,
		["554"] = 438,
		["555"] = 438,
		["556"] = 438,
		["557"] = 438,
		["558"] = 438,
		["559"] = 438,
		["560"] = 438,
		["561"] = 438,
		["562"] = 438,
		["563"] = 447,
		["565"] = 447,
		["567"] = 479,
		["568"] = 488,
		["569"] = 479,
		["570"] = 488,
		["571"] = 490,
		["572"] = 491,
		["573"] = 490,
		["574"] = 493,
		["575"] = 494,
		["576"] = 493,
		["577"] = 498,
		["578"] = 499,
		["579"] = 498,
		["580"] = 488,
		["581"] = 479,
		["582"] = 479,
		["583"] = 479,
		["584"] = 479,
		["585"] = 479,
		["586"] = 479,
		["587"] = 479,
		["588"] = 479,
		["589"] = 479,
		["590"] = 488,
		["592"] = 488,
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
g.viper_talent = c()
local q = g.viper_talent
q.name = "viper_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_viper_talent"
end
q = e({ j(nil) }, q)
g.viper_talent = q
g.modifier_viper_talent = c()
local r = g.modifier_viper_talent
r.name = "modifier_viper_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	local s = 1
	if self:HasTalent("viper_talent_3") then
		s = s + 1
	end
	local t = self:GetAbilityTalentValue("viper_talent_10", "poison_pct") * 0.01
	s = s + t
	self.poison = self:GetAbilitySpecialValueFor("poison")
		+ self:GetAbilityTalentValue("viper_talent_2", "extra_poison")
	self.bonus_poison_damage = self:GetAbilitySpecialValueFor("bonus_poison_damage")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.pre_battle_poison_per_victory = self:GetAbilityTalentValue("viper_talent_8", "pre_battle_poison_per_victory")
	self.chance = self:GetAbilityTalentValue("viper_talent_11", "chance")
	self.tl5_chance = self:GetAbilityTalentValue("viper_talent_5", "chance")
end
function r.prototype.OnCreated(self, u)
	if IsServer() then
		self:GetUltiAbility()
	end
end
function r.prototype.GetUltiAbility(self)
	if IsValid(self.ultiAbility) then
		return self.ultiAbility
	else
		self.ultiAbility = self:GetParent():FindAbilityByName("viper_ult")
		if IsValid(self.ultiAbility) then
			return self.ultiAbility
		end
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
	}
end
function r.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_PRE_BATTLE }
end
function r.prototype.OnBattleStartBefore(self, u) end
function r.prototype.OnCustomAttackLanded(self, v)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	self:PoisonAttack(v.target)
end
function r.prototype.OnCustomTakeDamage(self, v)
	if self.chance > 0 and self:PRD(self.chance) then
		local w = self:GetParent()
		local x = w:GetEnemy()
		if IsInjurable(w, x) then
			TriggerPoison(x)
		end
	end
	if self.tl5_chance > 0 and self:PRD(self.tl5_chance) then
		local x = self.caster:GetEnemy()
		self:PoisonAttack(x)
	end
end
function r.prototype.EOM_GetModifierPoisonPreBattle(self)
	if IsServer() then
		return self:GetTotalWin() * self.pre_battle_poison_per_victory
	end
end
function r.prototype.PoisonAttack(self, x)
	local y = self:GetCaster()
	if not IsInjurable(y, x) then
		return
	end
	local z = self.duration
	local A = self.poison
	local B = self.bonus_poison_damage
	if self:HasTalent("viper_talent_3") then
		A = A * 2
		B = B * 2
		z = z * 2
	end
	local C = AddPoison
	local D = x
	local E = A
	local F = self:GetAbility()
	C(y, D, E, F and F:GetAbilityName(), "Ability")
	AddPoisonDeepen(y, x, self:GetAbility(), B, z)
	y:AddNewModifier(y, self:GetAbility(), "modifier_viper_talent_stack", { duration = z })
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
g.modifier_viper_talent = r
g.modifier_viper_talent_stack = c()
local G = g.modifier_viper_talent_stack
G.name = "modifier_viper_talent_stack"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilityTalentValue("viper_shard", "max_stack")
	self.magical_armor_pct = self:GetAbilityTalentValue("viper_shard", "magical_armor_pct")
	self.ability_steal_pct = self:GetAbilityTalentValue("viper_shard", "ability_steal_pct")
end
function G.prototype.OnCreated(self, u)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function G.prototype.OnRefresh(self, u)
	if IsServer() then
		if self:GetStackCount() < self.max_stack then
			self:IncrementStackCount()
		end
	end
end
function G.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ABILITY_LIFESTEAL,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE,
	}
end
function G.prototype.EOM_GetModifierAbilityLifesteal(self, u)
	return self:GetStackCount() * self.ability_steal_pct
end
function G.prototype.EOM_GetModifierIncomingMagicalDamagePercentage(self, u)
	return -self:GetStackCount() * self.magical_armor_pct
end
G = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	G
)
g.modifier_viper_talent_stack = G
g.modifier_viper_talent_debuff = c()
local H = g.modifier_viper_talent_debuff
H.name = "modifier_viper_talent_debuff"
d(H, l)
function H.prototype.OnCreated(self, u)
	if IsServer() then
		local I = AddStun
		self:IncrementStackCount(u.iStackCount)
		self:StartIntervalThink(0)
		self.tData = {}
		local J = self.tData
		J[#J + 1] = self:GetDieTime()
	else
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_viper/viper_poison_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function H.prototype.OnRefresh(self, u)
	if IsServer() then
		self:IncrementStackCount(u.iStackCount)
		local L = self.tData
		L[#L + 1] = self:GetDieTime()
	end
end
function H.prototype.OnIntervalThink(self)
	local M = GameRules:GetGameTime()
	for N = #self.tData, 1, -1 do
		if self.tData[N] <= M then
			self:DecrementStackCount()
			table.remove(self.tData, N)
		end
	end
end
function H.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_TARGET }
end
function H.prototype.EOM_GetModifierPoisonDamageBonusTarget(self)
	return self:GetStackCount()
end
H = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	H
)
g.modifier_viper_talent_debuff = H
g.viper_ult = c()
local O = g.viper_ult
O.name = "viper_ult"
d(O, o)
function O.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local Q = P:GetEnemy()
	local R = self:GetTalentValue("viper_talent_4", "steal_mana")
	local S = self:GetTalentValue("viper_talent_9", "duration")
	local T = self:GetTalentValue("viper_talent_6", "ulti_bonus")
	local B = self:GetSpecialValueFor("bonus_poison_damage")
	local U = self:GetSpecialValueFor("poison") + self:GetTalentValue("viper_talent_1", "poison_bonus")
	local V = self.castRecord
	if V == nil then
		V = 0 * T
	end
	local A = U + V
	local z = self:GetSpecialValueFor("duration")
	local K = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_viper/viper_viper_strike_beam.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(K, 1, Q, PATTACH_POINT_FOLLOW, "attach_hitloc", vec3_zero, false)
	ParticleManager:SetParticleControl(K, 2, P:GetAttachmentPosition("attach_wing_barb_1"))
	ParticleManager:SetParticleControl(K, 3, P:GetAttachmentPosition("attach_wing_barb_2"))
	ParticleManager:SetParticleControl(K, 4, P:GetAttachmentPosition("attach_wing_barb_3"))
	ParticleManager:SetParticleControl(K, 5, P:GetAttachmentPosition("attach_wing_barb_4"))
	ParticleManager:SetParticleControl(K, 6, Vector(1000, 0, 0))
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/units/heroes/hero_viper/viper_viper_strike.vpcf",
		hCaster = P,
		hTarget = Q,
		iMoveSpeed = 1000,
		vSpawnOrigin = P:GetAttachmentPosition("attach_attack2"),
		OnProjectileHit = function(Q, W, X)
			AddPoison(P, Q, A, self:GetAbilityName(), "Ability")
			Q:AddNewModifier(P, self, "modifier_viper_ult", { duration = z })
			AddPoisonDeepen(P, Q, self, B, z)
			EmitSoundOnLocationWithCaster(W, "hero_viper.PoisonAttack.Target", P)
			if R > 0 then
				P:AddNewModifier(
					P,
					self,
					"modifier_viper_ult_talent_4",
					{ duration = z, mana_regen = GetManaRegen(Q) * R * 0.01 }
				)
			end
		end,
		OnProjectileDestroy = function(Y, Z)
			ParticleManager:DestroyParticle(K, false)
		end,
	})
	if S > 0 then
		P:AddNewModifier(P, self, "modifier_viper_ult_talent_9", { duration = S })
	end
	P:EmitSound("hero_viper.viperStrike")
	P:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local _ = self.castRecord
	if _ == nil then
		_ = 0
	end
	self.castRecord = _ + 1
end
function O.prototype.ViperStrikeDebuff(self)
	local P = self:GetCaster()
	local Q = P:GetEnemy()
	if not IsInjurable(P, Q) then
		return
	end
	local z = self:GetSpecialValueFor("duration")
	local B = self:GetSpecialValueFor("bonus_poison_damage")
	Q:AddNewModifier(P, self, "modifier_viper_ult_talent_5", { duration = z })
	AddPoisonDeepen(P, Q, self, B, z)
end
O = e({ p(nil) }, O)
g.viper_ult = O
g.modifier_viper_ult_talent_5 = c()
local a0 = g.modifier_viper_ult_talent_5
a0.name = "modifier_viper_ult_talent_5"
d(a0, l)
function a0.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.debuff_strength = self:GetAbilityTalentValue("viper_talent_7", "debuff_strength")
	self.tl5_effect_pct = self:GetAbilityTalentValue("viper_talent_5", "effect_pct")
end
function a0.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE_PERCENTAGE,
	}
end
function a0.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return -(self.attackspeed + self.debuff_strength) * self.tl5_effect_pct * 0.01
end
function a0.prototype.EOM_GetModifierManaRegenBasePercentage(self, u)
	return -(self.mana_regen + self.debuff_strength) * self.tl5_effect_pct * 0.01
end
a0 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetStatusEffectName = "particles/status_fx/status_effect_poison_viper.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_NORMAL,
				GetEffectName = "particles/units/heroes/hero_venomancer/venomancer_gale_poison_debuff.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	a0
)
g.modifier_viper_ult_talent_5 = a0
g.modifier_viper_ult = c()
local a1 = g.modifier_viper_ult
a1.name = "modifier_viper_ult"
d(a1, l)
function a1.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.bonus_poison_damage = self:GetAbilitySpecialValueFor("bonus_poison_damage")
	self.debuff_strength = self:GetAbilityTalentValue("viper_talent_7", "debuff_strength")
	self.chance = self:GetAbilityTalentValue("viper_talent_12", "chance")
	self.ice = self:GetAbilityTalentValue("viper_talent_12", "ice")
	self.interval = self:GetAbilityTalentValue("viper_talent_12", "interval")
end
function a1.prototype.OnCreated(self, u)
	local a2 = self:GetParent()
	if IsServer() then
		if self.interval > 0 then
			self:StartIntervalThink(self.interval)
		end
	else
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_viper/viper_viper_strike_debuff.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			a2
		)
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function a1.prototype.OnIntervalThink(self)
	if self.chance > 0 and self:PRD(self.chance) then
		AddIce(self:GetParent(), self:GetParent():GetEnemy(), self.ice, "viper_ult", "Ability")
	end
end
function a1.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BASE_PERCENTAGE,
	}
end
function a1.prototype.EOM_GetModifierAttackSpeedBonus(self, u)
	return -(self.attackspeed + self.debuff_strength)
end
function a1.prototype.EOM_GetModifierManaRegenBasePercentage(self, u)
	return -(self.mana_regen + self.debuff_strength)
end
a1 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a1
)
g.modifier_viper_ult = a1
g.viper_talent_10 = c()
local a3 = g.viper_talent_10
a3.name = "viper_talent_10"
d(a3, i)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_viper_talent_10"
end
a3 = e({ j(nil) }, a3)
g.viper_talent_10 = a3
g.modifier_viper_talent_10 = c()
local a4 = g.modifier_viper_talent_10
a4.name = "modifier_viper_talent_10"
d(a4, l)
function a4.prototype.GetAbilitySpecialValue(self)
	self.poison_pct = self:GetAbilityTalentValue("viper_talent_10", "poison_pct")
end
function a4.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_STACK_BONUS_PERCENTAGE] = self.poison_pct }
end
a4 = e(
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
	a4
)
g.modifier_viper_talent_10 = a4
g.modifier_viper_ult_talent_4 = c()
local a5 = g.modifier_viper_ult_talent_4
a5.name = "modifier_viper_ult_talent_4"
d(a5, l)
function a5.prototype.GetAbilitySpecialValue(self)
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	self.debuff_strength = self:GetAbilityTalentValue("viper_talent_7", "debuff_strength")
end
function a5.prototype.OnCreated(self, u)
	if IsServer() then
		self:SetStackCount(math.floor(u.mana_regen * 100))
	else
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_viper/viper_buff_mana.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function a5.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function a5.prototype.EOM_GetModifierManaLossPercentage(self, u) end
function a5.prototype.EOM_GetModifierManaRegenBonus(self)
	return self:GetStackCount() / 100
end
a5 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a5
)
g.modifier_viper_ult_talent_4 = a5
g.modifier_viper_ult_talent_9 = c()
local a6 = g.modifier_viper_ult_talent_9
a6.name = "modifier_viper_ult_talent_9"
d(a6, l)
function a6.prototype.GetAbilitySpecialValue(self)
	self.shield_disrupt_chance = self:GetAbilityTalentValue("viper_talent_9", "shield_disrupt_chance")
end
function a6.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_IGNORE_SHIELD_PERCENTAGE }
end
function a6.prototype.EOM_GetModifierIgnoreShieldPercent(self, u)
	return self.shield_disrupt_chance
end
a6 = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	a6
)
g.modifier_viper_ult_talent_9 = a6
return g