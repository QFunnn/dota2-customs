--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/axe"
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
		["36"] = 28,
		["37"] = 13,
		["38"] = 38,
		["39"] = 40,
		["40"] = 41,
		["41"] = 42,
		["42"] = 44,
		["43"] = 46,
		["44"] = 47,
		["45"] = 49,
		["46"] = 51,
		["47"] = 38,
		["48"] = 53,
		["49"] = 54,
		["50"] = 55,
		["51"] = 57,
		["52"] = 58,
		["53"] = 59,
		["54"] = 60,
		["55"] = 61,
		["56"] = 62,
		["59"] = 53,
		["60"] = 66,
		["61"] = 67,
		["62"] = 67,
		["63"] = 67,
		["64"] = 70,
		["65"] = 70,
		["66"] = 70,
		["67"] = 67,
		["68"] = 71,
		["69"] = 71,
		["70"] = 71,
		["71"] = 67,
		["72"] = 72,
		["73"] = 72,
		["74"] = 72,
		["75"] = 67,
		["76"] = 67,
		["77"] = 66,
		["78"] = 76,
		["79"] = 77,
		["80"] = 76,
		["81"] = 83,
		["82"] = 84,
		["83"] = 85,
		["84"] = 86,
		["85"] = 87,
		["87"] = 89,
		["88"] = 90,
		["89"] = 83,
		["90"] = 92,
		["91"] = 92,
		["92"] = 94,
		["93"] = 94,
		["94"] = 96,
		["95"] = 97,
		["96"] = 98,
		["97"] = 99,
		["98"] = 100,
		["100"] = 102,
		["101"] = 103,
		["102"] = 104,
		["105"] = 107,
		["107"] = 96,
		["108"] = 110,
		["109"] = 112,
		["112"] = 113,
		["113"] = 110,
		["114"] = 115,
		["115"] = 117,
		["118"] = 130,
		["119"] = 115,
		["120"] = 132,
		["121"] = 133,
		["122"] = 134,
		["123"] = 135,
		["124"] = 136,
		["126"] = 138,
		["129"] = 142,
		["130"] = 143,
		["131"] = 144,
		["133"] = 146,
		["134"] = 147,
		["135"] = 148,
		["136"] = 149,
		["139"] = 154,
		["140"] = 156,
		["143"] = 132,
		["144"] = 160,
		["145"] = 161,
		["148"] = 164,
		["149"] = 165,
		["150"] = 166,
		["151"] = 169,
		["152"] = 170,
		["153"] = 172,
		["154"] = 172,
		["155"] = 173,
		["156"] = 174,
		["157"] = 160,
		["158"] = 178,
		["159"] = 179,
		["160"] = 180,
		["161"] = 181,
		["164"] = 184,
		["165"] = 185,
		["167"] = 187,
		["168"] = 188,
		["169"] = 190,
		["170"] = 190,
		["171"] = 190,
		["172"] = 190,
		["173"] = 190,
		["174"] = 190,
		["175"] = 190,
		["176"] = 190,
		["177"] = 190,
		["178"] = 199,
		["179"] = 200,
		["180"] = 201,
		["181"] = 202,
		["182"] = 203,
		["185"] = 206,
		["188"] = 209,
		["189"] = 210,
		["191"] = 212,
		["192"] = 213,
		["193"] = 214,
		["194"] = 214,
		["195"] = 214,
		["196"] = 214,
		["197"] = 214,
		["198"] = 214,
		["199"] = 214,
		["200"] = 214,
		["201"] = 214,
		["202"] = 215,
		["203"] = 216,
		["204"] = 217,
		["206"] = 178,
		["207"] = 220,
		["208"] = 221,
		["209"] = 220,
		["210"] = 226,
		["211"] = 227,
		["212"] = 226,
		["213"] = 21,
		["214"] = 13,
		["215"] = 13,
		["216"] = 13,
		["217"] = 13,
		["218"] = 13,
		["219"] = 13,
		["220"] = 13,
		["221"] = 13,
		["222"] = 21,
		["224"] = 21,
		["225"] = 231,
		["226"] = 240,
		["227"] = 231,
		["228"] = 240,
		["229"] = 241,
		["230"] = 242,
		["231"] = 241,
		["232"] = 245,
		["233"] = 247,
		["234"] = 245,
		["235"] = 249,
		["236"] = 250,
		["237"] = 251,
		["239"] = 249,
		["240"] = 254,
		["241"] = 255,
		["242"] = 256,
		["244"] = 254,
		["245"] = 259,
		["246"] = 260,
		["247"] = 259,
		["248"] = 265,
		["249"] = 266,
		["250"] = 265,
		["251"] = 240,
		["252"] = 231,
		["253"] = 231,
		["254"] = 231,
		["255"] = 231,
		["256"] = 231,
		["257"] = 231,
		["258"] = 231,
		["259"] = 231,
		["260"] = 231,
		["261"] = 240,
		["263"] = 240,
		["265"] = 274,
		["266"] = 275,
		["267"] = 274,
		["268"] = 275,
		["269"] = 276,
		["270"] = 277,
		["271"] = 278,
		["272"] = 279,
		["275"] = 282,
		["276"] = 284,
		["277"] = 285,
		["278"] = 288,
		["279"] = 289,
		["280"] = 290,
		["281"] = 290,
		["282"] = 290,
		["283"] = 291,
		["286"] = 294,
		["287"] = 295,
		["288"] = 296,
		["289"] = 297,
		["290"] = 297,
		["291"] = 297,
		["292"] = 297,
		["293"] = 297,
		["294"] = 297,
		["295"] = 297,
		["296"] = 297,
		["297"] = 297,
		["298"] = 298,
		["299"] = 299,
		["300"] = 300,
		["301"] = 301,
		["302"] = 302,
		["303"] = 303,
		["304"] = 303,
		["305"] = 303,
		["306"] = 303,
		["307"] = 303,
		["308"] = 304,
		["309"] = 304,
		["310"] = 304,
		["311"] = 304,
		["312"] = 304,
		["313"] = 305,
		["314"] = 305,
		["315"] = 305,
		["316"] = 305,
		["317"] = 305,
		["318"] = 305,
		["319"] = 305,
		["320"] = 305,
		["321"] = 305,
		["322"] = 306,
		["323"] = 307,
		["324"] = 308,
		["325"] = 308,
		["326"] = 308,
		["327"] = 308,
		["328"] = 308,
		["329"] = 308,
		["330"] = 309,
		["331"] = 310,
		["332"] = 311,
		["333"] = 312,
		["337"] = 290,
		["338"] = 290,
		["339"] = 276,
		["340"] = 318,
		["341"] = 319,
		["342"] = 318,
		["343"] = 275,
		["344"] = 274,
		["345"] = 275,
		["347"] = 275,
		["348"] = 322,
		["349"] = 330,
		["350"] = 322,
		["351"] = 330,
		["352"] = 331,
		["353"] = 332,
		["354"] = 332,
		["355"] = 332,
		["356"] = 332,
		["357"] = 332,
		["358"] = 331,
		["359"] = 334,
		["360"] = 335,
		["361"] = 335,
		["362"] = 335,
		["363"] = 335,
		["364"] = 335,
		["365"] = 335,
		["367"] = 335,
		["368"] = 334,
		["369"] = 330,
		["370"] = 322,
		["371"] = 322,
		["372"] = 322,
		["373"] = 322,
		["374"] = 322,
		["375"] = 322,
		["376"] = 322,
		["377"] = 322,
		["378"] = 330,
		["380"] = 330,
		["381"] = 338,
		["382"] = 346,
		["383"] = 338,
		["384"] = 346,
		["385"] = 346,
		["386"] = 338,
		["387"] = 338,
		["388"] = 338,
		["389"] = 338,
		["390"] = 338,
		["391"] = 338,
		["392"] = 338,
		["393"] = 338,
		["394"] = 346,
		["396"] = 346,
		["398"] = 352,
		["399"] = 353,
		["400"] = 352,
		["401"] = 353,
		["402"] = 354,
		["403"] = 355,
		["404"] = 354,
		["405"] = 353,
		["406"] = 352,
		["407"] = 353,
		["409"] = 353,
		["410"] = 358,
		["411"] = 365,
		["412"] = 358,
		["413"] = 365,
		["414"] = 368,
		["415"] = 369,
		["416"] = 370,
		["417"] = 368,
		["418"] = 372,
		["419"] = 373,
		["420"] = 373,
		["421"] = 375,
		["422"] = 375,
		["423"] = 375,
		["424"] = 373,
		["425"] = 373,
		["426"] = 372,
		["427"] = 378,
		["428"] = 379,
		["429"] = 379,
		["430"] = 379,
		["431"] = 379,
		["432"] = 379,
		["433"] = 378,
		["434"] = 381,
		["435"] = 382,
		["436"] = 382,
		["437"] = 382,
		["438"] = 382,
		["439"] = 382,
		["440"] = 382,
		["442"] = 382,
		["443"] = 381,
		["444"] = 385,
		["445"] = 386,
		["446"] = 387,
		["447"] = 387,
		["448"] = 387,
		["449"] = 387,
		["450"] = 388,
		["451"] = 388,
		["452"] = 388,
		["453"] = 388,
		["454"] = 388,
		["456"] = 385,
		["457"] = 391,
		["458"] = 392,
		["459"] = 393,
		["460"] = 394,
		["461"] = 395,
		["462"] = 391,
		["463"] = 397,
		["464"] = 398,
		["465"] = 399,
		["468"] = 400,
		["471"] = 403,
		["472"] = 404,
		["475"] = 407,
		["476"] = 408,
		["477"] = 409,
		["478"] = 410,
		["480"] = 412,
		["481"] = 413,
		["482"] = 414,
		["485"] = 397,
		["486"] = 418,
		["487"] = 419,
		["488"] = 418,
		["489"] = 423,
		["490"] = 424,
		["491"] = 423,
		["492"] = 365,
		["493"] = 358,
		["494"] = 358,
		["495"] = 358,
		["496"] = 358,
		["497"] = 358,
		["498"] = 358,
		["499"] = 358,
		["500"] = 365,
		["502"] = 365,
		["503"] = 429,
		["504"] = 430,
		["505"] = 429,
		["506"] = 430,
		["507"] = 431,
		["508"] = 432,
		["509"] = 431,
		["510"] = 430,
		["511"] = 429,
		["512"] = 430,
		["514"] = 430,
		["515"] = 435,
		["516"] = 442,
		["517"] = 435,
		["518"] = 442,
		["519"] = 444,
		["520"] = 445,
		["521"] = 444,
		["522"] = 447,
		["523"] = 448,
		["524"] = 447,
		["525"] = 450,
		["526"] = 451,
		["527"] = 452,
		["528"] = 453,
		["529"] = 454,
		["532"] = 450,
		["533"] = 458,
		["534"] = 459,
		["535"] = 458,
		["536"] = 463,
		["537"] = 464,
		["538"] = 465,
		["539"] = 466,
		["541"] = 463,
		["542"] = 469,
		["543"] = 470,
		["544"] = 469,
		["545"] = 474,
		["546"] = 475,
		["547"] = 474,
		["548"] = 442,
		["549"] = 435,
		["550"] = 435,
		["551"] = 435,
		["552"] = 435,
		["553"] = 435,
		["554"] = 435,
		["555"] = 435,
		["556"] = 442,
		["558"] = 442,
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
g.axe_talent = c()
local q = g.axe_talent
q.name = "axe_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_axe_talent"
end
q = e({ j(nil) }, q)
g.axe_talent = q
g.modifier_axe_talent = c()
local r = g.modifier_axe_talent
r.name = "modifier_axe_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tick = 0.1
end
function r.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count") - self:GetAbilityTalentValue("axe_talent_1", "count_reduce")
	self.damage = self:GetAbilitySpecialValueFor("damage") + self:GetAbilityTalentValue("axe_talent_7", "bonus_damage")
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
	self.tl3_attackspeed = self:GetAbilityTalentValue("axe_talent_3", "attackspeed")
	self.tl5_attack_reduce = self:GetAbilityTalentValue("axe_talent_5", "attack_reduce")
	self.tl5_duration = self:GetAbilityTalentValue("axe_talent_5", "duration")
	self.tl8_shield = self:GetAbilityTalentValue("axe_talent_8", "shield")
	self.tl10_chance = self:GetAbilityTalentValue("axe_talent_10", "chance")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self.record = 0
		self.tl5_StealRecord = {}
		self.tl5_enable = false
		self.tl3_enable = false
		local t = self:GetParent():FindAbilityByName("axe_ult")
		if IsValid(t) then
			self.ulti_reduce = t:GetSpecialValueFor("count_reduce")
		end
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function r.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS_STEAL,
	}
end
function r.prototype.OnBattleStartBefore(self, s)
	self.record = 0
	local t = self:GetParent():FindAbilityByName("axe_ult")
	if IsValid(t) then
		self.ulti_reduce = t:GetSpecialValueFor("count_reduce")
	end
	self.tl5_enable = self:HasTalent("axe_talent_5")
	self.tl3_enable = self:HasTalent("axe_talent_3")
end
function r.prototype.OnBattleStart(self, s) end
function r.prototype.OnBattleEnd(self, s) end
function r.prototype.IncrementEffectCount(self)
	self.record = self.record + 1
	local u = self.count
	if self:GetParent():HasModifier("modifier_axe_ulti_buff") then
		u = u - self.ulti_reduce
	end
	if self.record >= u then
		self.record = 0
		if self:GetParent():PassivesDisabled() then
			return
		end
		self:CounterHelix()
	end
end
function r.prototype.OnCustomTakeDamage(self, v)
	if not (self:HasTalent("axe_talent_7") or v.damage_type == EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL) then
		return
	end
	self:IncrementEffectCount()
end
function r.prototype.OnCustomAttackLanded(self, v)
	if not self.tl3_enable then
		return
	end
	self:IncrementEffectCount()
end
function r.prototype.OnThink(self, w)
	if w == "talent_5" then
		for x = #self.tl5_StealRecord - 1, 0, -1 do
			if self.tl5_StealRecord[x + 1] <= 0 then
				table.remove(self.tl5_StealRecord, x + 1)
			else
				self.tl5_StealRecord[x + 1] = self.tl5_StealRecord[x + 1] - self.tick
			end
		end
		if #self.tl5_StealRecord == 0 then
			self:SetStackCount(0)
			self:StartThink(-1, "talent_5")
		else
			local y = self:GetParent():GetEnemy()
			if not IsInjurable(y) then
				self:SetStackCount(0)
				self:StartThink(-1, "talent_5")
				return
			end
			local z = self.tl5_attack_reduce * #self.tl5_StealRecord
			self:SetStackCount(z)
		end
	end
end
function r.prototype.tl5StealAttack(self, y)
	if not IsInjurable(y) then
		return
	end
	local A = self:GetParent()
	local B = self:GetAbility()
	local C = #self.tl5_StealRecord or 0
	local z = self.tl5_attack_reduce * C
	self:SetStackCount(z)
	local D = self.tl5_StealRecord
	D[#D + 1] = self.tl5_duration
	self:StartThink(self.tick, "talent_5")
	y:AddNewModifier(A, B, "modifier_axe_talent_debuff", { duration = self.tl5_duration })
end
function r.prototype.CounterHelix(self)
	local A = self:GetParent()
	local y = A:GetEnemy()
	if not IsInjurable(A, y) then
		return
	end
	if not A:HasModifier("modifier_axe_ulti_cast") then
		A:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	end
	local B = self:GetAbility()
	local E = self.damage + GetShield(A) * self.damage_pct * 0.01
	DamageSystem:dealDamage({
		attacker = A,
		target = y,
		ability = B,
		damage = E,
		damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL,
		damage_flags = DamageFlags.DAMAGE_FLAG_NONE,
		damage_category = DOTA_DAMAGE_CATEGORY_SPELL,
	})
	if self.tl10_chance > 0 and self:PRD(self.tl10_chance, "tl10_chance") then
		if not (self.ultAbility and IsValid(self.ultAbility)) then
			self.ultAbility = A:FindAbilityByName("axe_ult")
			if IsValid(self.ultAbility) then
				self.ultAbility:OnSpellStart()
			end
		else
			self.ultAbility:OnSpellStart()
		end
	end
	if self.tl8_shield > 0 then
		AddShield(A, self.tl8_shield, "axe_talent_8", "Ability")
	end
	A:EmitSound("Hero_Axe.CounterHelix")
	local F = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf",
		PATTACH_CUSTOMORIGIN,
		A
	)
	ParticleManager:SetParticleControlEnt(F, 0, A, PATTACH_ABSORIGIN_FOLLOW, nil, A:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(F)
	if self.tl5_enable then
		self:tl5StealAttack(y)
	end
end
function r.prototype.EOM_GetModifierAttackDamageBonusSteal(self, s)
	return self:GetStackCount()
end
function r.prototype.EOM_GetModifierAttackSpeedBonus(self, s)
	return self.tl3_attackspeed
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
g.modifier_axe_talent = r
g.modifier_axe_talent_debuff = c()
local G = g.modifier_axe_talent_debuff
G.name = "modifier_axe_talent_debuff"
d(G, l)
function G.prototype.GetTexture(self)
	return "modifier_axe_talent_debuff"
end
function G.prototype.GetAbilitySpecialValue(self)
	self.tl5_attack_reduce = self:GetAbilityTalentValue("axe_talent_5", "attack_reduce")
end
function G.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function G.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function G.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function G.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount() * -self.tl5_attack_reduce
end
G = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	G
)
g.modifier_axe_talent_debuff = G
g.axe_ult = c()
local H = g.axe_ult
H.name = "axe_ult"
d(H, o)
function H.prototype.OnSpellStart(self)
	local I = self:GetCaster()
	local y = I:GetEnemy()
	if not IsInjurable(I, y) then
		return
	end
	local J = self:GetSpecialValueFor("shield_base")
	local u = self:GetSpecialValueFor("threshold") + self:GetTalentValue("axe_talent_9", "threshold_bonus")
	I:AddNewModifier(I, self, "modifier_axe_ulti_cast", { duration = 0.35 })
	I:EmitSound("Hero_Axe.BerserkersCall.Start")
	I:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
	self:GameTimer(0.35, function()
		if not IsInjurable(I, y) then
			return
		end
		I:EmitSound("Hero_Axe.Berserkers_Call")
		AddShield(I, J, "axe_ult", "Ability")
		local F = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			I
		)
		ParticleManager:SetParticleControlEnt(F, 1, I, PATTACH_POINT_FOLLOW, "attach_mouth", I:GetAbsOrigin(), true)
		if y:GetHealthPercent() <= u then
			local K = self:GetSpecialValueFor("base_damage")
			local L = self:GetSpecialValueFor("health_damage")
			I:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 2)
			local M = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				y
			)
			ParticleManager:SetParticleControl(M, 3, Vector(0, 0, 0))
			ParticleManager:SetParticleControlForward(M, 3, (y:GetAbsOrigin() - I:GetAbsOrigin()):Normalized())
			ParticleManager:SetParticleControlEnt(M, 4, y, PATTACH_ABSORIGIN_FOLLOW, nil, y:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(M)
			y:EmitSound("Hero_Axe.Culling_Blade_Success")
			I:DealDamage(y, self, K + y:GetHealthDeficit() * L * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
			if not IsInjurable(y) then
				local N = I:FindModifierByName("modifier_axe_ult")
				if IsValid(N) then
					N:saveStack(1)
				end
			end
		end
	end)
end
function H.prototype.GetIntrinsicModifierName(self)
	return "modifier_axe_ult"
end
H = e({ p(nil) }, H)
g.axe_ult = H
g.modifier_axe_ult = c()
local O = g.modifier_axe_ult
O.name = "modifier_axe_ult"
d(O, l)
function O.prototype.saveStack(self, P)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "axe_shard", self:loadStack() + P)
end
function O.prototype.loadStack(self)
	local Q = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "axe_shard")
	if Q == nil then
		Q = 0
	end
	return Q
end
O = e(
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
	O
)
g.modifier_axe_ult = O
g.modifier_axe_ulti_cast = c()
local R = g.modifier_axe_ulti_cast
R.name = "modifier_axe_ulti_cast"
d(R, l)
R = e(
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
	R
)
g.modifier_axe_ulti_cast = R
g.axe_talent_4 = c()
local S = g.axe_talent_4
S.name = "axe_talent_4"
d(S, i)
function S.prototype.GetIntrinsicModifierName(self)
	return "modifier_axe_talent_4"
end
S = e({ j(nil) }, S)
g.axe_talent_4 = S
g.modifier_axe_talent_4 = c()
local T = g.modifier_axe_talent_4
T.name = "modifier_axe_talent_4"
d(T, l)
function T.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.win_stack = self:GetAbilitySpecialValueFor("win_stack")
end
function T.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function T.prototype.SaveStack(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "axe_talent_4", self:GetStackCount())
end
function T.prototype.LoadStack(self)
	local U = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "axe_talent_4")
	if U == nil then
		U = 0
	end
	return U
end
function T.prototype.Init(self)
	local A = self:GetParent()
	if PlayerData:loadData(A:GetPlayerOwnerID(), "axe_talent_4") == nil then
		PlayerData:saveData(A:GetPlayerOwnerID(), "axe_talent_4", 0)
	end
end
function T.prototype.OnBattleStart(self)
	self:Init()
	local C = self:LoadStack()
	print("stack", C)
	self:SetStackCount(self:LoadStack())
end
function T.prototype.OnBattleEnd(self, s)
	if IsServer() then
		if self.stack == 0 then
			return
		end
		if s.isNeutral ~= nil then
			return
		end
		local V = self:GetParent():GetPlayerOwnerID()
		if s.illusionPlayerID == V then
			return
		end
		if s.winPlayerID == V then
			print("winstack", self.stack + self.win_stack)
			self:IncrementStackCount(self.stack + self.win_stack)
			self:SaveStack()
		else
			print("lossstack", self.stack)
			self:IncrementStackCount(self.stack)
			self:SaveStack()
		end
	end
end
function T.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_PERMANENT }
end
function T.prototype.EOM_GetModifierShieldPermanent(self, s)
	return self:GetStackCount()
end
T = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	T
)
g.modifier_axe_talent_4 = T
g.axe_shard = c()
local W = g.axe_shard
W.name = "axe_shard"
d(W, i)
function W.prototype.GetIntrinsicModifierName(self)
	return "modifier_axe_shard"
end
W = e({ j(nil) }, W)
g.axe_shard = W
g.modifier_axe_shard = c()
local X = g.modifier_axe_shard
X.name = "modifier_axe_shard"
d(X, l)
function X.prototype.GetTexture(self)
	return "modifier_axe_shard"
end
function X.prototype.GetAbilitySpecialValue(self)
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
end
function X.prototype.OnCreated(self, s)
	if IsServer() then
		local N = self:GetParent():FindModifierByName("modifier_axe_ult")
		if IsValid(N) then
			self:SetStackCount(N:loadStack())
		end
	end
end
function X.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function X.prototype.OnBattleStartBefore(self, s)
	local N = self:GetParent():FindModifierByName("modifier_axe_ult")
	if IsValid(N) then
		self:SetStackCount(N:loadStack())
	end
end
function X.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function X.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, s)
	return -self.damage_reduce * self:GetStackCount()
end
X = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	X
)
g.modifier_axe_shard = X
return g