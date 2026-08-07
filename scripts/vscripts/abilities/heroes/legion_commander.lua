--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/legion_commander"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 9,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 7,
		["28"] = 7,
		["29"] = 13,
		["30"] = 21,
		["31"] = 13,
		["32"] = 21,
		["33"] = 32,
		["34"] = 34,
		["35"] = 35,
		["36"] = 36,
		["37"] = 37,
		["38"] = 39,
		["39"] = 40,
		["40"] = 42,
		["41"] = 43,
		["42"] = 44,
		["43"] = 45,
		["45"] = 32,
		["46"] = 48,
		["47"] = 49,
		["48"] = 48,
		["49"] = 51,
		["50"] = 52,
		["51"] = 53,
		["53"] = 51,
		["54"] = 56,
		["55"] = 57,
		["56"] = 56,
		["57"] = 59,
		["58"] = 60,
		["59"] = 61,
		["61"] = 59,
		["62"] = 64,
		["63"] = 65,
		["64"] = 65,
		["65"] = 65,
		["66"] = 65,
		["67"] = 69,
		["68"] = 69,
		["69"] = 69,
		["70"] = 65,
		["71"] = 65,
		["72"] = 64,
		["73"] = 72,
		["74"] = 73,
		["77"] = 74,
		["78"] = 75,
		["80"] = 72,
		["81"] = 78,
		["82"] = 79,
		["83"] = 80,
		["84"] = 80,
		["85"] = 80,
		["86"] = 80,
		["87"] = 81,
		["88"] = 82,
		["90"] = 80,
		["91"] = 80,
		["93"] = 86,
		["95"] = 78,
		["96"] = 89,
		["97"] = 90,
		["98"] = 91,
		["99"] = 92,
		["100"] = 93,
		["101"] = 94,
		["102"] = 94,
		["103"] = 94,
		["104"] = 94,
		["105"] = 94,
		["106"] = 95,
		["107"] = 95,
		["108"] = 95,
		["109"] = 95,
		["110"] = 95,
		["111"] = 96,
		["112"] = 97,
		["113"] = 97,
		["114"] = 97,
		["115"] = 97,
		["116"] = 97,
		["117"] = 97,
		["118"] = 98,
		["119"] = 99,
		["120"] = 99,
		["121"] = 99,
		["122"] = 99,
		["123"] = 99,
		["124"] = 100,
		["125"] = 101,
		["126"] = 102,
		["127"] = 103,
		["128"] = 104,
		["129"] = 104,
		["130"] = 104,
		["131"] = 104,
		["132"] = 104,
		["133"] = 104,
		["137"] = 89,
		["138"] = 21,
		["139"] = 13,
		["140"] = 13,
		["141"] = 13,
		["142"] = 13,
		["143"] = 13,
		["144"] = 13,
		["145"] = 13,
		["146"] = 13,
		["147"] = 21,
		["149"] = 21,
		["151"] = 113,
		["152"] = 122,
		["153"] = 113,
		["154"] = 122,
		["155"] = 124,
		["156"] = 126,
		["157"] = 124,
		["158"] = 128,
		["159"] = 129,
		["160"] = 130,
		["162"] = 128,
		["163"] = 133,
		["164"] = 134,
		["165"] = 135,
		["167"] = 133,
		["168"] = 138,
		["169"] = 139,
		["170"] = 138,
		["171"] = 143,
		["172"] = 144,
		["173"] = 143,
		["174"] = 122,
		["175"] = 113,
		["176"] = 113,
		["177"] = 113,
		["178"] = 113,
		["179"] = 113,
		["180"] = 113,
		["181"] = 113,
		["182"] = 113,
		["183"] = 113,
		["184"] = 122,
		["186"] = 122,
		["187"] = 148,
		["188"] = 149,
		["189"] = 148,
		["190"] = 149,
		["191"] = 150,
		["192"] = 151,
		["193"] = 152,
		["194"] = 153,
		["197"] = 156,
		["198"] = 159,
		["199"] = 160,
		["200"] = 161,
		["201"] = 162,
		["202"] = 164,
		["203"] = 165,
		["205"] = 150,
		["206"] = 149,
		["207"] = 148,
		["208"] = 149,
		["210"] = 149,
		["211"] = 171,
		["212"] = 178,
		["213"] = 171,
		["214"] = 178,
		["215"] = 179,
		["216"] = 180,
		["217"] = 181,
		["218"] = 183,
		["219"] = 184,
		["220"] = 184,
		["221"] = 184,
		["222"] = 184,
		["223"] = 184,
		["224"] = 185,
		["225"] = 185,
		["226"] = 185,
		["227"] = 185,
		["228"] = 185,
		["229"] = 185,
		["230"] = 185,
		["231"] = 185,
		["233"] = 179,
		["234"] = 178,
		["235"] = 171,
		["236"] = 171,
		["237"] = 171,
		["238"] = 171,
		["239"] = 171,
		["240"] = 171,
		["241"] = 171,
		["242"] = 178,
		["244"] = 178,
		["245"] = 197,
		["246"] = 205,
		["247"] = 197,
		["248"] = 205,
		["249"] = 208,
		["250"] = 209,
		["251"] = 210,
		["252"] = 208,
		["253"] = 212,
		["254"] = 213,
		["255"] = 214,
		["257"] = 216,
		["258"] = 216,
		["259"] = 216,
		["260"] = 216,
		["261"] = 216,
		["262"] = 217,
		["263"] = 217,
		["264"] = 217,
		["265"] = 217,
		["266"] = 217,
		["267"] = 217,
		["268"] = 217,
		["269"] = 217,
		["270"] = 217,
		["271"] = 218,
		["272"] = 218,
		["273"] = 218,
		["274"] = 218,
		["275"] = 218,
		["276"] = 218,
		["277"] = 218,
		["278"] = 218,
		["280"] = 212,
		["281"] = 221,
		["282"] = 222,
		["283"] = 223,
		["284"] = 223,
		["285"] = 223,
		["286"] = 223,
		["287"] = 223,
		["288"] = 223,
		["289"] = 223,
		["290"] = 223,
		["291"] = 223,
		["292"] = 221,
		["293"] = 205,
		["294"] = 197,
		["295"] = 197,
		["296"] = 197,
		["297"] = 197,
		["298"] = 197,
		["299"] = 197,
		["300"] = 197,
		["301"] = 197,
		["302"] = 205,
		["304"] = 205,
		["305"] = 228,
		["306"] = 236,
		["307"] = 228,
		["308"] = 236,
		["309"] = 238,
		["310"] = 240,
		["311"] = 238,
		["312"] = 242,
		["313"] = 243,
		["314"] = 242,
		["315"] = 236,
		["316"] = 228,
		["317"] = 228,
		["318"] = 228,
		["319"] = 228,
		["320"] = 228,
		["321"] = 228,
		["322"] = 228,
		["323"] = 228,
		["324"] = 236,
		["326"] = 236,
		["328"] = 254,
		["329"] = 255,
		["330"] = 254,
		["331"] = 255,
		["332"] = 256,
		["333"] = 257,
		["334"] = 256,
		["335"] = 255,
		["336"] = 254,
		["337"] = 255,
		["339"] = 255,
		["340"] = 260,
		["341"] = 267,
		["342"] = 260,
		["343"] = 267,
		["344"] = 269,
		["345"] = 270,
		["346"] = 269,
		["347"] = 272,
		["348"] = 273,
		["349"] = 272,
		["350"] = 267,
		["351"] = 260,
		["352"] = 260,
		["353"] = 260,
		["354"] = 260,
		["355"] = 260,
		["356"] = 260,
		["357"] = 260,
		["358"] = 267,
		["360"] = 267,
		["361"] = 280,
		["362"] = 281,
		["363"] = 280,
		["364"] = 281,
		["365"] = 282,
		["366"] = 283,
		["367"] = 282,
		["368"] = 281,
		["369"] = 280,
		["370"] = 281,
		["372"] = 281,
		["373"] = 286,
		["374"] = 293,
		["375"] = 286,
		["376"] = 293,
		["377"] = 295,
		["378"] = 296,
		["379"] = 295,
		["380"] = 298,
		["381"] = 299,
		["382"] = 298,
		["383"] = 301,
		["384"] = 302,
		["385"] = 302,
		["386"] = 304,
		["387"] = 304,
		["388"] = 304,
		["389"] = 302,
		["390"] = 302,
		["391"] = 301,
		["392"] = 307,
		["393"] = 308,
		["394"] = 308,
		["395"] = 308,
		["396"] = 308,
		["397"] = 308,
		["398"] = 307,
		["399"] = 310,
		["400"] = 311,
		["401"] = 311,
		["402"] = 311,
		["403"] = 311,
		["404"] = 311,
		["405"] = 311,
		["407"] = 311,
		["408"] = 310,
		["409"] = 314,
		["410"] = 315,
		["411"] = 316,
		["412"] = 316,
		["413"] = 316,
		["414"] = 316,
		["415"] = 317,
		["416"] = 317,
		["417"] = 317,
		["418"] = 317,
		["419"] = 317,
		["421"] = 314,
		["422"] = 320,
		["423"] = 321,
		["424"] = 322,
		["425"] = 320,
		["426"] = 324,
		["427"] = 325,
		["428"] = 326,
		["431"] = 327,
		["434"] = 330,
		["435"] = 331,
		["438"] = 334,
		["439"] = 335,
		["440"] = 336,
		["443"] = 324,
		["444"] = 340,
		["445"] = 341,
		["446"] = 340,
		["447"] = 349,
		["448"] = 350,
		["449"] = 349,
		["450"] = 293,
		["451"] = 286,
		["452"] = 286,
		["453"] = 286,
		["454"] = 286,
		["455"] = 286,
		["456"] = 286,
		["457"] = 286,
		["458"] = 293,
		["460"] = 293,
		["461"] = 356,
		["462"] = 357,
		["463"] = 356,
		["464"] = 357,
		["465"] = 358,
		["466"] = 359,
		["467"] = 358,
		["468"] = 357,
		["469"] = 356,
		["470"] = 357,
		["472"] = 357,
		["473"] = 362,
		["474"] = 369,
		["475"] = 362,
		["476"] = 369,
		["478"] = 369,
		["479"] = 373,
		["480"] = 362,
		["481"] = 374,
		["482"] = 375,
		["483"] = 376,
		["484"] = 377,
		["485"] = 378,
		["487"] = 374,
		["488"] = 381,
		["489"] = 382,
		["490"] = 383,
		["492"] = 381,
		["493"] = 386,
		["494"] = 387,
		["495"] = 388,
		["496"] = 389,
		["498"] = 386,
		["499"] = 392,
		["500"] = 393,
		["501"] = 392,
		["502"] = 395,
		["503"] = 396,
		["504"] = 397,
		["505"] = 397,
		["506"] = 397,
		["507"] = 396,
		["508"] = 396,
		["509"] = 399,
		["510"] = 399,
		["511"] = 399,
		["512"] = 396,
		["513"] = 396,
		["514"] = 395,
		["515"] = 403,
		["516"] = 404,
		["519"] = 405,
		["520"] = 406,
		["521"] = 407,
		["522"] = 408,
		["523"] = 410,
		["524"] = 411,
		["525"] = 411,
		["526"] = 411,
		["527"] = 411,
		["528"] = 411,
		["529"] = 416,
		["530"] = 417,
		["531"] = 418,
		["532"] = 418,
		["533"] = 418,
		["534"] = 418,
		["535"] = 418,
		["536"] = 418,
		["537"] = 418,
		["538"] = 418,
		["540"] = 411,
		["541"] = 411,
		["543"] = 426,
		["544"] = 426,
		["545"] = 426,
		["546"] = 426,
		["547"] = 426,
		["548"] = 426,
		["549"] = 426,
		["550"] = 426,
		["552"] = 431,
		["553"] = 432,
		["554"] = 432,
		["555"] = 432,
		["556"] = 432,
		["557"] = 432,
		["558"] = 432,
		["559"] = 432,
		["560"] = 432,
		["561"] = 432,
		["562"] = 433,
		["563"] = 433,
		["564"] = 433,
		["565"] = 433,
		["566"] = 433,
		["567"] = 434,
		["568"] = 403,
		["569"] = 436,
		["570"] = 437,
		["571"] = 438,
		["572"] = 436,
		["573"] = 440,
		["574"] = 441,
		["575"] = 442,
		["577"] = 440,
		["578"] = 445,
		["579"] = 446,
		["580"] = 447,
		["581"] = 448,
		["582"] = 449,
		["583"] = 450,
		["584"] = 451,
		["585"] = 452,
		["587"] = 454,
		["588"] = 455,
		["591"] = 445,
		["592"] = 369,
		["593"] = 362,
		["594"] = 362,
		["595"] = 362,
		["596"] = 362,
		["597"] = 362,
		["598"] = 362,
		["599"] = 362,
		["600"] = 369,
		["602"] = 369,
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
g.legion_commander_talent = c()
local q = g.legion_commander_talent
q.name = "legion_commander_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_talent"
end
q = e({ j(nil) }, q)
g.legion_commander_talent = q
g.modifier_legion_commander_talent = c()
local r = g.modifier_legion_commander_talent
r.name = "modifier_legion_commander_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
		+ self:GetAbilityTalentValue("legion_commander_talent_8", "bonus_chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.factor = self:GetAbilitySpecialValueFor("factor")
	self.talent_6_interval = self:GetAbilityTalentValue("legion_commander_talent_6", "interval")
	self.tl1_count = self:GetAbilityTalentValue("legion_commander_talent_1", "count")
	self.tl1_duration = self:GetAbilityTalentValue("legion_commander_talent_1", "duration")
	self.tl4_chance = self:GetAbilityTalentValue("legion_commander_talent_4", "chance")
	self.tl4_count = self:GetAbilityTalentValue("legion_commander_talent_4", "count")
	if IsServer() then
		self.tl1_counter = 0
	end
end
function r.prototype.OnBattleStartBefore(self, s)
	self.tl1_counter = 0
end
function r.prototype.OnBattleStart(self)
	if self.talent_6_interval > 0 then
		self:StartIntervalThink(self.talent_6_interval)
	end
end
function r.prototype.OnBattleEnd(self, s)
	self:StartIntervalThink(-1)
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		self:OverWhelming()
	end
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function r.prototype.OnShieldGained(self)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if self:PRD(self.chance) then
		self:OverWhelming()
	end
end
function r.prototype.OverWhelming(self)
	if self.tl4_chance > 0 then
		ForWithInterval(0.25, self.tl4_count, function()
			if IsValid(self) then
				self:_OverWhelming()
			end
		end)
	else
		self:_OverWhelming()
	end
end
function r.prototype._OverWhelming(self)
	local t = self:GetParent()
	local u = t:GetEnemy()
	if IsInjurable(t, u) then
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_commander_odds_hero_arrow_group.vpcf",
			PATTACH_CUSTOMORIGIN,
			t
		)
		ParticleManager:SetParticleControl(v, 0, u:GetAbsOrigin())
		ParticleManager:SetParticleControl(v, 1, t:GetAbsOrigin())
		local w = self.damage + GetShield(t) * self.factor
		t:DealDamage(u, self:GetAbility(), w, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
		t:EmitSound("Hero_LegionCommander.Overwhelming.Cast")
		EmitSoundOnLocationWithCaster(u:GetAbsOrigin(), "Hero_LegionCommander.Overwhelming.Location", t)
		if self.tl1_count > 0 then
			self.tl1_counter = self.tl1_counter + 1
			if self.tl1_counter >= self.tl1_count then
				self.tl1_counter = 0
				t:AddNewModifier(
					t,
					self:GetAbility(),
					"modifier_legion_commander_talent_1",
					{ duration = self.tl1_duration }
				)
			end
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
g.modifier_legion_commander_talent = r
g.modifier_legion_commander_talent_1 = c()
local x = g.modifier_legion_commander_talent_1
x.name = "modifier_legion_commander_talent_1"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.tl1_damage_pct = self:GetAbilityTalentValue("legion_commander_talent_1", "damage_pct")
end
function x.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function x.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function x.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function x.prototype.EOM_GetModifierOutgoingDamagePercentage(self, s)
	return self.tl1_damage_pct * self:GetStackCount()
end
x = e(
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
				IsIndependent = true,
			}
		),
	},
	x
)
g.modifier_legion_commander_talent_1 = x
g.legion_commander_ult = c()
local y = g.legion_commander_ult
y.name = "legion_commander_ult"
d(y, o)
function y.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	local A = z:GetEnemy()
	if not IsInjurable(A, z) then
		return
	end
	local B = self:GetSpecialValueFor("duration") + self:GetTalentValue("legion_commander_talent_3", "duration")
	local C = self:GetTalentValue("legion_commander_talent_5", "bonus_pct")
	z:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	z:EmitSound("Hero_LegionCommander.PressTheAttack")
	z:AddNewModifier(z, self, "modifier_legion_commander_ult", { duration = B })
	if C > 0 then
		z:AddNewModifier(z, self, "modifier_legion_commander_talent_3", { duration = B })
	end
end
y = e({ p(nil) }, y)
g.legion_commander_ult = y
g.modifier_legion_commander_vs = c()
local D = g.modifier_legion_commander_vs
D.name = "modifier_legion_commander_vs"
d(D, l)
function D.prototype.OnCreated(self, s)
	if IsClient() then
		local t = self:GetParent()
		local v = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_duel.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		ParticleManager:SetParticleControl(v, 2, Vector(500, 0, 0))
		self:AddParticle(v, false, false, -1, false, false)
	end
end
D = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	D
)
g.modifier_legion_commander_vs = D
g.modifier_legion_commander_ult = c()
local E = g.modifier_legion_commander_ult
E.name = "modifier_legion_commander_ult"
d(E, l)
function E.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("legion_commander_talent_5", "cooldown_reduce")
	self.shield = self:GetAbilitySpecialValueFor("shield")
end
function E.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(math.max(0, self.interval))
	else
		local F = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_commander_press_owner.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			F,
			2,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			self:GetParent():GetAbsOrigin(),
			false
		)
		self:AddParticle(F, false, false, -1, false, false)
	end
end
function E.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local G = AddShield
	local H = self.shield
	local I = self:GetAbility()
	G(t, H, I and I:GetAbilityName(), "Ability")
end
E = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	E
)
g.modifier_legion_commander_ult = E
g.modifier_legion_commander_talent_3 = c()
local J = g.modifier_legion_commander_talent_3
J.name = "modifier_legion_commander_talent_3"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.tl5_bonus_pct = self:GetAbilityTalentValue("legion_commander_talent_5", "bonus_pct")
end
function J.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE] = self.tl5_bonus_pct }
end
J = e(
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
	J
)
g.modifier_legion_commander_talent_3 = J
g.legion_commander_talent_2 = c()
local K = g.legion_commander_talent_2
K.name = "legion_commander_talent_2"
d(K, i)
function K.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_talent_2"
end
K = e({ j(nil) }, K)
g.legion_commander_talent_2 = K
g.modifier_legion_commander_talent_2 = c()
local L = g.modifier_legion_commander_talent_2
L.name = "modifier_legion_commander_talent_2"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
end
function L.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_chance }
end
L = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	L
)
g.modifier_legion_commander_talent_2 = L
g.legion_commander_talent_7 = c()
local M = g.legion_commander_talent_7
M.name = "legion_commander_talent_7"
d(M, i)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_talent_7"
end
M = e({ j(nil) }, M)
g.legion_commander_talent_7 = M
g.modifier_legion_commander_talent_7 = c()
local N = g.modifier_legion_commander_talent_7
N.name = "modifier_legion_commander_talent_7"
d(N, l)
function N.prototype.GetTexture(self)
	return "legion_commander_press_the_attack"
end
function N.prototype.GetAbilitySpecialValue(self)
	self.add_value = self:GetAbilitySpecialValueFor("add_value")
end
function N.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function N.prototype.SaveStack(self)
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "legion_commander_talent_7", self:GetStackCount())
end
function N.prototype.LoadStack(self)
	local O = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "legion_commander_talent_7")
	if O == nil then
		O = 0
	end
	return O
end
function N.prototype.Init(self)
	local P = self:GetParent()
	if PlayerData:loadData(P:GetPlayerOwnerID(), "legion_commander_talent_7") == nil then
		PlayerData:saveData(P:GetPlayerOwnerID(), "legion_commander_talent_7", 0)
	end
end
function N.prototype.OnBattleStart(self)
	self:Init()
	self:SetStackCount(self:LoadStack())
end
function N.prototype.OnBattleEnd(self, s)
	if IsServer() then
		if self.add_value == 0 then
			return
		end
		if s.isNeutral ~= nil then
			return
		end
		local Q = self:GetParent():GetPlayerOwnerID()
		if s.illusionPlayerID == Q then
			return
		end
		if s.winPlayerID == Q then
			self:IncrementStackCount(self.add_value)
			self:SaveStack()
		end
	end
end
function N.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS }
end
function N.prototype.EOM_GetModifierShieldStackBonus(self, s)
	return self:GetStackCount()
end
N = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
g.modifier_legion_commander_talent_7 = N
g.legion_commander_shard = c()
local R = g.legion_commander_shard
R.name = "legion_commander_shard"
d(R, i)
function R.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_shard"
end
R = e({ j(nil) }, R)
g.legion_commander_shard = R
g.modifier_legion_commander_shard = c()
local S = g.modifier_legion_commander_shard
S.name = "modifier_legion_commander_shard"
d(S, l)
function S.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.sect = "16"
end
function S.prototype.GetAbilitySpecialValue(self)
	self.base_duration = self:GetAbilitySpecialValueFor("base_duration")
	self.shield = self:GetAbilitySpecialValueFor("shield")
	if IsServer() then
		self.ready = true
	end
end
function S.prototype.OnCreated(self, s)
	if IsServer() then
		self:FixAbilityLevel()
	end
end
function S.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self.ready = true
	end
end
function S.prototype.OnStackCountChanged(self, T)
	self.base_duration = self:GetAbilitySpecialValueFor("base_duration")
end
function S.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = {
			PlayerResource:GetSelectedHeroEntity(self:GetParent():GetPlayerOwnerID()),
			-1,
		},
	}
end
function S.prototype.OnCustomAttackLanded(self, U)
	if not self.ready then
		return
	end
	self.ready = false
	self:StartIntervalThink(self.base_duration)
	local P = self:GetParent()
	local w = GetAttackDamage(P) + self.shield * GetShield(P) * 0.01
	if P:IsRangedAttacker() then
		Projectile:CreateTrackingProjectile({
			EffectName = P:GetRangedProjectileName(),
			hCaster = P,
			hTarget = U.attacker,
			iMoveSpeed = P:GetProjectileSpeed(),
			OnProjectileHit = function(u, V, W)
				if IsValid(self) and IsInjurable(u) then
					DamageSystem:performAttack(P, u, { ability = self:GetAbility(), damage = w })
				end
			end,
		})
	else
		DamageSystem:performAttack(P, U.attacker, { damage = w, ability = self:GetAbility() })
	end
	local v = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		P
	)
	ParticleManager:SetParticleControlEnt(v, 1, P, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, false)
	ParticleManager:SetParticleControl(v, 2, Vector(0, 1, 0))
	P:EmitSound("Hero_LegionCommander.Courage")
end
function S.prototype.OnBattleStartBefore(self, s)
	self:FixAbilityLevel()
	self.ready = true
end
function S.prototype.OnAbilityLearn(self, s)
	if s.abilityname == self.sect then
		self:FixAbilityLevel()
	end
end
function S.prototype.FixAbilityLevel(self)
	if IsServer() then
		local X = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if X then
			local Y = X:getAbilityUpgradeData()
			local Z = 1
			if Y[self.sect] then
				Z = Y[self.sect].level
			end
			self:GetAbility():SetLevel(Clamp(Z, 1, 3))
			self:IncrementStackCount()
		end
	end
end
S = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	S
)
g.modifier_legion_commander_shard = S
return g