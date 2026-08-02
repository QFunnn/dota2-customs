--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/pangolier"
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
		["33"] = 37,
		["34"] = 39,
		["35"] = 41,
		["36"] = 42,
		["37"] = 43,
		["38"] = 44,
		["39"] = 46,
		["40"] = 47,
		["41"] = 48,
		["42"] = 49,
		["43"] = 50,
		["44"] = 52,
		["45"] = 53,
		["46"] = 54,
		["47"] = 37,
		["48"] = 56,
		["49"] = 57,
		["50"] = 58,
		["51"] = 58,
		["52"] = 58,
		["53"] = 59,
		["54"] = 60,
		["56"] = 58,
		["57"] = 58,
		["59"] = 56,
		["60"] = 65,
		["61"] = 66,
		["62"] = 68,
		["63"] = 68,
		["64"] = 66,
		["65"] = 65,
		["66"] = 71,
		["67"] = 72,
		["68"] = 73,
		["69"] = 75,
		["70"] = 76,
		["71"] = 78,
		["72"] = 79,
		["74"] = 81,
		["75"] = 82,
		["76"] = 82,
		["77"] = 82,
		["78"] = 82,
		["79"] = 83,
		["80"] = 84,
		["81"] = 84,
		["82"] = 84,
		["83"] = 84,
		["84"] = 84,
		["85"] = 84,
		["86"] = 84,
		["87"] = 84,
		["88"] = 84,
		["89"] = 86,
		["90"] = 87,
		["91"] = 88,
		["92"] = 92,
		["93"] = 93,
		["94"] = 94,
		["96"] = 97,
		["97"] = 98,
		["99"] = 102,
		["100"] = 103,
		["102"] = 105,
		["104"] = 108,
		["105"] = 109,
		["107"] = 71,
		["108"] = 113,
		["109"] = 114,
		["112"] = 115,
		["113"] = 116,
		["114"] = 117,
		["115"] = 118,
		["116"] = 120,
		["117"] = 121,
		["119"] = 113,
		["120"] = 20,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 12,
		["126"] = 12,
		["127"] = 12,
		["128"] = 12,
		["129"] = 20,
		["131"] = 20,
		["132"] = 134,
		["133"] = 143,
		["134"] = 134,
		["135"] = 143,
		["136"] = 148,
		["137"] = 150,
		["138"] = 148,
		["139"] = 152,
		["140"] = 153,
		["141"] = 154,
		["142"] = 155,
		["143"] = 156,
		["144"] = 158,
		["145"] = 159,
		["146"] = 160,
		["147"] = 152,
		["148"] = 162,
		["149"] = 165,
		["150"] = 166,
		["151"] = 167,
		["152"] = 168,
		["153"] = 169,
		["154"] = 170,
		["155"] = 170,
		["156"] = 170,
		["157"] = 170,
		["158"] = 170,
		["159"] = 170,
		["160"] = 170,
		["163"] = 162,
		["164"] = 174,
		["165"] = 177,
		["166"] = 178,
		["167"] = 179,
		["168"] = 180,
		["169"] = 181,
		["170"] = 182,
		["171"] = 182,
		["172"] = 182,
		["173"] = 182,
		["174"] = 182,
		["175"] = 182,
		["176"] = 182,
		["179"] = 174,
		["180"] = 186,
		["181"] = 187,
		["182"] = 186,
		["183"] = 191,
		["184"] = 192,
		["185"] = 191,
		["186"] = 196,
		["187"] = 197,
		["188"] = 196,
		["189"] = 143,
		["190"] = 134,
		["191"] = 134,
		["192"] = 134,
		["193"] = 134,
		["194"] = 134,
		["195"] = 134,
		["196"] = 134,
		["197"] = 134,
		["198"] = 134,
		["199"] = 143,
		["201"] = 143,
		["202"] = 202,
		["203"] = 210,
		["204"] = 202,
		["205"] = 210,
		["206"] = 212,
		["207"] = 213,
		["208"] = 212,
		["209"] = 216,
		["210"] = 217,
		["211"] = 216,
		["212"] = 210,
		["213"] = 202,
		["214"] = 202,
		["215"] = 202,
		["216"] = 202,
		["217"] = 202,
		["218"] = 202,
		["219"] = 202,
		["220"] = 202,
		["221"] = 210,
		["223"] = 210,
		["224"] = 223,
		["225"] = 231,
		["226"] = 223,
		["227"] = 231,
		["228"] = 235,
		["229"] = 236,
		["230"] = 237,
		["231"] = 235,
		["232"] = 239,
		["233"] = 240,
		["234"] = 241,
		["235"] = 242,
		["236"] = 243,
		["237"] = 244,
		["238"] = 244,
		["240"] = 239,
		["241"] = 247,
		["242"] = 248,
		["243"] = 249,
		["244"] = 250,
		["245"] = 251,
		["246"] = 251,
		["248"] = 254,
		["249"] = 255,
		["250"] = 255,
		["251"] = 256,
		["254"] = 247,
		["255"] = 260,
		["256"] = 261,
		["257"] = 262,
		["258"] = 263,
		["259"] = 264,
		["260"] = 265,
		["263"] = 260,
		["264"] = 269,
		["265"] = 270,
		["266"] = 269,
		["267"] = 274,
		["268"] = 275,
		["269"] = 274,
		["270"] = 231,
		["271"] = 223,
		["272"] = 223,
		["273"] = 223,
		["274"] = 223,
		["275"] = 223,
		["276"] = 223,
		["277"] = 223,
		["278"] = 223,
		["279"] = 231,
		["281"] = 231,
		["282"] = 280,
		["283"] = 281,
		["284"] = 280,
		["285"] = 281,
		["286"] = 285,
		["287"] = 286,
		["288"] = 287,
		["289"] = 290,
		["290"] = 291,
		["291"] = 292,
		["292"] = 293,
		["293"] = 294,
		["294"] = 294,
		["295"] = 294,
		["296"] = 295,
		["297"] = 296,
		["298"] = 297,
		["299"] = 298,
		["300"] = 303,
		["302"] = 294,
		["303"] = 294,
		["304"] = 285,
		["305"] = 307,
		["306"] = 307,
		["307"] = 307,
		["309"] = 308,
		["310"] = 309,
		["311"] = 310,
		["312"] = 312,
		["313"] = 314,
		["314"] = 315,
		["315"] = 316,
		["316"] = 316,
		["317"] = 316,
		["318"] = 316,
		["319"] = 316,
		["320"] = 317,
		["321"] = 317,
		["322"] = 317,
		["323"] = 317,
		["324"] = 317,
		["325"] = 318,
		["326"] = 319,
		["328"] = 325,
		["329"] = 325,
		["330"] = 325,
		["331"] = 325,
		["332"] = 325,
		["333"] = 325,
		["334"] = 325,
		["336"] = 328,
		["338"] = 307,
		["339"] = 332,
		["340"] = 333,
		["341"] = 332,
		["342"] = 281,
		["343"] = 280,
		["344"] = 281,
		["346"] = 281,
		["347"] = 336,
		["348"] = 344,
		["349"] = 336,
		["350"] = 344,
		["351"] = 348,
		["352"] = 349,
		["353"] = 350,
		["354"] = 348,
		["355"] = 352,
		["356"] = 353,
		["357"] = 352,
		["358"] = 357,
		["359"] = 358,
		["360"] = 359,
		["363"] = 360,
		["364"] = 361,
		["365"] = 362,
		["366"] = 363,
		["367"] = 363,
		["368"] = 363,
		["369"] = 363,
		["370"] = 363,
		["371"] = 363,
		["372"] = 366,
		["373"] = 366,
		["374"] = 366,
		["375"] = 366,
		["376"] = 366,
		["377"] = 366,
		["378"] = 367,
		["380"] = 369,
		["382"] = 357,
		["383"] = 344,
		["384"] = 336,
		["385"] = 336,
		["386"] = 336,
		["387"] = 336,
		["388"] = 336,
		["389"] = 336,
		["390"] = 336,
		["391"] = 336,
		["392"] = 344,
		["394"] = 344,
		["396"] = 375,
		["397"] = 385,
		["398"] = 375,
		["399"] = 385,
		["400"] = 391,
		["401"] = 392,
		["402"] = 393,
		["403"] = 394,
		["404"] = 395,
		["405"] = 391,
		["406"] = 397,
		["407"] = 398,
		["408"] = 399,
		["409"] = 400,
		["410"] = 401,
		["411"] = 402,
		["412"] = 403,
		["413"] = 404,
		["414"] = 405,
		["415"] = 405,
		["416"] = 405,
		["417"] = 405,
		["418"] = 405,
		["419"] = 405,
		["420"] = 405,
		["421"] = 405,
		["422"] = 405,
		["423"] = 405,
		["424"] = 405,
		["425"] = 405,
		["426"] = 415,
		["427"] = 416,
		["428"] = 417,
		["429"] = 418,
		["430"] = 419,
		["431"] = 420,
		["432"] = 421,
		["434"] = 423,
		["435"] = 424,
		["438"] = 427,
		["439"] = 428,
		["440"] = 428,
		["441"] = 428,
		["442"] = 428,
		["443"] = 428,
		["444"] = 428,
		["446"] = 431,
		["447"] = 432,
		["448"] = 432,
		["449"] = 432,
		["450"] = 432,
		["451"] = 433,
		["452"] = 433,
		["453"] = 433,
		["454"] = 433,
		["455"] = 433,
		["456"] = 433,
		["457"] = 433,
		["458"] = 433,
		["459"] = 434,
		["460"] = 434,
		["461"] = 434,
		["462"] = 434,
		["463"] = 434,
		["464"] = 434,
		["465"] = 434,
		["466"] = 434,
		["468"] = 397,
		["469"] = 437,
		["470"] = 438,
		["471"] = 439,
		["472"] = 440,
		["473"] = 441,
		["474"] = 442,
		["476"] = 444,
		["477"] = 445,
		["479"] = 437,
		["480"] = 448,
		["481"] = 449,
		["482"] = 448,
		["483"] = 453,
		["484"] = 454,
		["485"] = 455,
		["486"] = 455,
		["487"] = 454,
		["488"] = 453,
		["489"] = 458,
		["490"] = 459,
		["491"] = 460,
		["492"] = 461,
		["493"] = 462,
		["494"] = 463,
		["495"] = 463,
		["496"] = 463,
		["497"] = 463,
		["498"] = 464,
		["499"] = 465,
		["501"] = 463,
		["502"] = 463,
		["504"] = 458,
		["505"] = 385,
		["506"] = 375,
		["507"] = 375,
		["508"] = 375,
		["509"] = 375,
		["510"] = 375,
		["511"] = 375,
		["512"] = 375,
		["513"] = 375,
		["514"] = 375,
		["515"] = 375,
		["516"] = 385,
		["518"] = 385,
		["520"] = 473,
		["521"] = 474,
		["522"] = 473,
		["523"] = 474,
		["524"] = 475,
		["525"] = 476,
		["526"] = 475,
		["527"] = 474,
		["528"] = 473,
		["529"] = 474,
		["531"] = 474,
		["532"] = 479,
		["533"] = 487,
		["534"] = 479,
		["535"] = 487,
		["536"] = 489,
		["537"] = 490,
		["538"] = 489,
		["539"] = 492,
		["540"] = 493,
		["541"] = 494,
		["543"] = 492,
		["544"] = 497,
		["545"] = 498,
		["546"] = 497,
		["547"] = 502,
		["548"] = 503,
		["549"] = 502,
		["550"] = 487,
		["551"] = 479,
		["552"] = 479,
		["553"] = 479,
		["554"] = 479,
		["555"] = 479,
		["556"] = 479,
		["557"] = 479,
		["558"] = 479,
		["559"] = 487,
		["561"] = 487,
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
g.pangolier_talent = c()
local q = g.pangolier_talent
q.name = "pangolier_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_pangolier_talent"
end
q = e({ j(nil) }, q)
g.pangolier_talent = q
g.modifier_pangolier_talent = c()
local r = g.modifier_pangolier_talent
r.name = "modifier_pangolier_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance") + self:GetAbilityTalentValue("pangolier_talent_5", "chance")
	self.tl12_effect_pct = self:GetAbilityTalentValue("pangolier_talent_12", "effect_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.duration = self.duration * (1 + self.tl12_effect_pct * 0.01)
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.mana_regen = self:GetAbilityTalentValue("pangolier_talent_3", "mana_regen")
	self.bonus_duration = self:GetAbilityTalentValue("pangolier_talent_9", "bonus_duration")
	self.evade_bonus_duration = self:GetAbilityTalentValue("pangolier_talent_9", "duration")
	self.talent_injury_count = 0
	self.attack_speed = self:GetAbilityTalentValue("pangolier_talent_6", "attack_speed")
	self.tl10_count_pct = self:GetAbilityTalentValue("pangolier_talent_10", "count_pct")
	self.talent_threshold = self:GetAbilityTalentValue("pangolier_talent_11", "threshold")
	self.count = self:GetAbilityTalentValue("pangolier_talent_11", "count")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(t, s, u, v)
			if
				u == self:GetParent()
				and s.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
				and bit.band(s.damage_flags, DamageFlags.DAMAGE_FLAG_HPLOSS) ~= DamageFlags.DAMAGE_FLAG_HPLOSS
			then
				self:OnCustomAttackLanded(s)
			end
		end)
	end
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_INJURY_GAINED] = { self:GetParent(), -1 } }
end
function r.prototype.OnCustomAttackLanded(self, w)
	local x = self:GetParent()
	local v = x:GetEnemy()
	if not x:PassivesDisabled() and IsInjurable(x, v) and self:PRD(self.chance, "chance") then
		local y = false
		if self.tl10_count_pct > 0 and IsValid(w.ability) and w.ability:GetAbilityName() == "pangolier_ult" then
			y = true
		end
		local z = self:GetAbility()
		x:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, x:GetAttackSpeed(false))
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf",
			PATTACH_ABSORIGIN,
			x
		)
		ParticleManager:SetParticleControlEnt(A, 1, v, PATTACH_POINT, "attach_hitloc", v:GetAbsOrigin(), false)
		local B =
			ParticleManager:CreateParticle("particles/gameplay/hero_buff_empty.vpcf", PATTACH_ABSORIGIN_FOLLOW, v, x)
		ParticleManager:ReleaseParticleIndex(B)
		v:AddNewModifier(
			x,
			z,
			"modifier_pangolier_talent_debuff",
			{ duration = self.duration + self.bonus_duration, stackCount = y and self.tl10_count_pct * 0.01 or 0 }
		)
		local C = v:FindModifierByName("modifier_injury_permanent")
		if IsValid(C) then
			C:OnIntervalThink()
		end
		if self.attack_speed > 0 then
			x:AddNewModifier(
				x,
				z,
				"modifier_pangolier_talent_6_buff",
				{ duration = self.duration + self.bonus_duration }
			)
		end
		if self.evade_bonus_duration > 0 then
			x:AddNewModifier(x, z, "modifier_pangolier_talent_9_buff", { duration = self.evade_bonus_duration })
		end
		x:EmitSound("Hero_Pangolier.HeartPiercer.Creep")
	end
	if self.mana_regen > 0 then
		Restore(x, self.mana_regen)
	end
end
function r.prototype.OnInjuryGained(self, s)
	if self.talent_threshold <= 0 then
		return
	end
	self.talent_injury_count = self.talent_injury_count + s.iStackCount
	if self.talent_injury_count >= self.talent_threshold then
		local x = self:GetParent()
		local z = x:FindAbilityByName("pangolier_ult")
		self.talent_injury_count = self.talent_injury_count - self.talent_threshold
		z:OnSpellStart()
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
g.modifier_pangolier_talent = r
g.modifier_pangolier_talent_debuff = c()
local D = g.modifier_pangolier_talent_debuff
D.name = "modifier_pangolier_talent_debuff"
d(D, l)
function D.prototype.IndependentMaxCount(self)
	return self.max + self.bonus_max
end
function D.prototype.GetAbilitySpecialValue(self)
	self.max = self:GetAbilitySpecialValueFor("max")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
		+ self:GetAbilityTalentValue("pangolier_talent_2", "damage_bonus")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.bonus_max = self:GetAbilityTalentValue("pangolier_talent_4", "bonus_max")
	local E = self:GetAbilityTalentValue("pangolier_talent_12", "effect_pct")
	self.bonus_damage = self.bonus_damage * (1 + E * 0.01)
	self.attackspeed = self.attackspeed * (1 + E * 0.01)
end
function D.prototype.OnCreated(self, s)
	if IsServer() then
		local x = self:GetParent()
		local F = s and s.stackCount or 0
		self:IncrementStackCount(1)
		if F > 0 then
			AddInjury(self:GetCaster(), x, self.bonus_damage * F, "pangolier_talent_10", "Ability")
		end
	end
end
function D.prototype.OnRefresh(self, s)
	if IsServer() then
		local x = self:GetParent()
		local F = s and s.stackCount or 0
		self:IncrementStackCount(1)
		if F > 0 then
			AddInjury(self:GetCaster(), x, self.bonus_damage * F, "pangolier_talent_10", "Ability")
		end
	end
end
function D.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INJURY_PERMANENT }
end
function D.prototype.EOM_GetModifierInjuryPermanent(self)
	return self.bonus_damage * self:GetStackCount()
end
function D.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = -self.attackspeed }
end
D = e(
	{
		m(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = true,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				IsIndependent = true,
			}
		),
	},
	D
)
g.modifier_pangolier_talent_debuff = D
g.modifier_pangolier_talent_6_buff = c()
local G = g.modifier_pangolier_talent_6_buff
G.name = "modifier_pangolier_talent_6_buff"
d(G, l)
function G.prototype.GetAbilitySpecialValue(self)
	self.attack_speed = self:GetAbilityTalentValue("pangolier_talent_6", "attack_speed")
end
function G.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attack_speed }
end
G = e(
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
	G
)
g.modifier_pangolier_talent_6_buff = G
g.modifier_pangolier_talent_9_buff = c()
local H = g.modifier_pangolier_talent_9_buff
H.name = "modifier_pangolier_talent_9_buff"
d(H, l)
function H.prototype.GetAbilitySpecialValue(self)
	self.evade_bonus = self:GetAbilityTalentValue("pangolier_talent_9", "evade_bonus")
	self.max_stack = self:GetAbilityTalentValue("pangolier_talent_9", "max_stack")
end
function H.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink(0)
		self.tData = {}
		local I = self.tData
		I[#I + 1] = self:GetDieTime()
	end
end
function H.prototype.OnRefresh(self, J)
	if IsServer() then
		if self:GetStackCount() < self.max_stack then
			self:IncrementStackCount()
			local K = self.tData
			K[#K + 1] = self:GetDieTime()
		else
			table.remove(self.tData, 0)
			local L = self.tData
			L[#L + 1] = self:GetDieTime()
			self:SetStackCount(self.max_stack)
		end
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
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVASION_BONUS }
end
function H.prototype.EOM_GetModifierEvasion_Bonus(self, s)
	return self.evade_bonus * self:GetStackCount()
end
H = e(
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
	H
)
g.modifier_pangolier_talent_9_buff = H
g.pangolier_ult = c()
local O = g.pangolier_ult
O.name = "pangolier_ult"
d(O, o)
function O.prototype.OnSpellStart(self)
	local P = self:GetCaster()
	local F = self:GetSpecialValueFor("count") + self:GetTalentValue("pangolier_talent_7", "attack_count")
	local Q = 0.4
	local R = 0.4 / F
	local S = 0
	P:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
	self:GameTimer(0.2, function()
		P:EmitSound("Hero_Pangolier.Swashbuckle.Cast")
		if S < F then
			S = S + 1
			self:Swashbuckle()
			return R
		end
	end)
end
function O.prototype.Swashbuckle(self, T)
	if T == nil then
		T = true
	end
	local P = self:GetCaster()
	local v = P:GetEnemy()
	if IsInjurable(P, v) then
		local U = self:GetSpecialValueFor("damage") + self:GetTalentValue("pangolier_talent_1", "damage_bonus")
		local V = self:HasTalent("pangolier_talent_4") and DamageFlags.DAMAGE_FLAG_NO_EVASION
			or DamageFlags.DAMAGE_FLAG_NONE
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_pangolier/pangolier_swashbuckler_images.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			P
		)
		ParticleManager:SetParticleControl(A, 3, P:GetAbsOrigin())
		ParticleManager:SetParticleControlForward(A, 3, (v:GetAbsOrigin() - P:GetAbsOrigin()):Normalized())
		if T then
			DamageSystem:performAttack(P, v, { damage = U, damage_flags = V, ability = self })
		else
			P:DealDamage(v, self, U, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL, V)
		end
		P:EmitSound("Hero_Pangolier.Attack")
	end
end
function O.prototype.GetIntrinsicModifierName(self)
	return "modifier_pangolier_ult"
end
O = e({ p(nil) }, O)
g.pangolier_ult = O
g.modifier_pangolier_ult = c()
local W = g.modifier_pangolier_ult
W.name = "modifier_pangolier_ult"
d(W, l)
function W.prototype.GetAbilitySpecialValue(self)
	self.s_threshold = self:GetAbilityTalentValue("pangolier_shard", "threshold")
	self.s_duration = self:GetAbilityTalentValue("pangolier_shard", "duration")
end
function W.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MIN_HEALTH }
end
function W.prototype.EOM_GetModifierMinHealth(self, s)
	if self.s_threshold > 0 then
		if self.flag then
			return
		end
		local x = self:GetParent()
		local X = x:GetMaxHealth() * self.s_threshold * 0.01
		if x:GetHealth() - s.damage <= X then
			x:AddNewModifier(x, self:GetAbility(), "modifier_pangolier_shard_buff", { duration = self.s_duration })
			AddDisarm(x, x, self:GetAbility(), self.s_duration)
			self.flag = true
		end
		return 1
	end
end
W = e(
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
	W
)
g.modifier_pangolier_ult = W
g.modifier_pangolier_shard_buff = c()
local Y = g.modifier_pangolier_shard_buff
Y.name = "modifier_pangolier_shard_buff"
d(Y, l)
function Y.prototype.GetAbilitySpecialValue(self)
	self.shield_pct = self:GetAbilityTalentValue("pangolier_shard", "shield_pct")
	self.count = self:GetAbilityTalentValue("pangolier_shard", "count")
	self.strike = self:GetAbilityTalentValue("pangolier_shard", "strike")
	self.record = 0
end
function Y.prototype.OnCreated(self, s)
	if IsServer() then
		local x = self:GetParent()
		x:EmitSound("Hero_Pangolier.Gyroshell.Cast")
		x:SetModelScale(0.01)
		local Z = x:GetForwardVector()
		Z.z = 0
		Z = Z:Normalized()
		self.dummy = SpawnEntityFromTableSynchronous(
			"prop_dynamic",
			{
				origin = x:GetAbsOrigin(),
				model = Wearable:getReplaceUnitModel(x, "models/heroes/pangolier/pangolier_gyroshell2.vmdl"),
				StartingAnim = "ACT_DOTA_SPAWN",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
				IdleAnim = "ACT_DOTA_IDLE",
				scale = "1.2",
				angles = VectorToAngles(Z),
			}
		)
		local _ = x:GetMaxHealth() * self.shield_pct * 0.01
		local a0 = x:FindModifierByName("modifier_injury_custom")
		if IsValid(a0) then
			local a1 = a0:GetStackCount()
			if a1 <= _ then
				_ = _ - a1
				a0:Destroy()
			else
				a0:DecrementStackCount(_)
				_ = 0
			end
		end
		if _ > 0 then
			x:AddNewModifier(x, self:GetAbility(), "modifier_shield_custom", { iStackCount = _ })
		end
		local a2 = "pangolier_shard"
		CombatLog:recordAbilityCast(x, x:FindAbilityByName("pangolier_shard"))
		PlayerData:addDetailData(self:GetParent(), "Ability", "shield", _, false, a2)
		CombatLog:recordBuff(x, x, "shield", _, a2, "Ability")
	end
end
function Y.prototype.OnDestroy(self)
	if IsServer() then
		local x = self:GetParent()
		x:EmitSound("Hero_Pangolier.Rollup.Stop")
		if IsValid(self.dummy) then
			UTIL_Remove(self.dummy)
		end
		x:SetModelScale(x:GetDefaultModelScale())
		x:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
	end
end
function Y.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function Y.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function Y.prototype.OnCustomTakeDamage(self, w)
	self.record = self.record + 1
	if self.record == self.count then
		self.record = 0
		local z = self:GetAbility()
		ForWithInterval(0.2, self.strike, function()
			if IsValid(z) then
				z:Swashbuckle()
			end
		end)
	end
end
Y = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_SUPER_ULTRA,
				GetStatusEffectName = "particles/status_fx/status_effect_pangolier_gyroshell.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	Y
)
g.modifier_pangolier_shard_buff = Y
g.pangolier_talent_8 = c()
local a3 = g.pangolier_talent_8
a3.name = "pangolier_talent_8"
d(a3, i)
function a3.prototype.GetIntrinsicModifierName(self)
	return "modifier_pangolier_talent_8"
end
a3 = e({ j(nil) }, a3)
g.pangolier_talent_8 = a3
g.modifier_pangolier_talent_8 = c()
local a4 = g.modifier_pangolier_talent_8
a4.name = "modifier_pangolier_talent_8"
d(a4, l)
function a4.prototype.GetAbilitySpecialValue(self)
	self.atk_speed_per_victory = self:GetAbilityTalentValue("pangolier_talent_8", "atk_speed_per_victory")
end
function a4.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.atk_speed_per_victory)
	end
end
function a4.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function a4.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self:GetStackCount()
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
g.modifier_pangolier_talent_8 = a4
return g