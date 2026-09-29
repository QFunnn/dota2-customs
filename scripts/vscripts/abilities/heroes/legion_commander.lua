--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
		["33"] = 29,
		["34"] = 31,
		["35"] = 32,
		["36"] = 33,
		["37"] = 34,
		["38"] = 36,
		["39"] = 37,
		["40"] = 29,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["45"] = 39,
		["46"] = 44,
		["47"] = 45,
		["48"] = 44,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["53"] = 47,
		["54"] = 52,
		["55"] = 53,
		["56"] = 53,
		["57"] = 53,
		["58"] = 56,
		["59"] = 56,
		["60"] = 56,
		["61"] = 53,
		["62"] = 53,
		["63"] = 52,
		["64"] = 59,
		["65"] = 60,
		["68"] = 61,
		["69"] = 62,
		["71"] = 59,
		["72"] = 65,
		["73"] = 66,
		["74"] = 67,
		["75"] = 67,
		["76"] = 67,
		["77"] = 67,
		["78"] = 68,
		["79"] = 69,
		["81"] = 67,
		["82"] = 67,
		["84"] = 73,
		["86"] = 65,
		["87"] = 76,
		["88"] = 77,
		["89"] = 78,
		["90"] = 79,
		["91"] = 80,
		["92"] = 81,
		["93"] = 81,
		["94"] = 81,
		["95"] = 81,
		["96"] = 81,
		["97"] = 82,
		["98"] = 82,
		["99"] = 82,
		["100"] = 82,
		["101"] = 82,
		["102"] = 83,
		["103"] = 84,
		["104"] = 84,
		["105"] = 84,
		["106"] = 84,
		["107"] = 84,
		["108"] = 84,
		["109"] = 85,
		["110"] = 86,
		["111"] = 86,
		["112"] = 86,
		["113"] = 86,
		["114"] = 86,
		["116"] = 76,
		["117"] = 21,
		["118"] = 13,
		["119"] = 13,
		["120"] = 13,
		["121"] = 13,
		["122"] = 13,
		["123"] = 13,
		["124"] = 13,
		["125"] = 13,
		["126"] = 21,
		["128"] = 21,
		["129"] = 91,
		["130"] = 92,
		["131"] = 91,
		["132"] = 92,
		["133"] = 93,
		["134"] = 94,
		["135"] = 95,
		["136"] = 96,
		["139"] = 99,
		["140"] = 102,
		["141"] = 103,
		["142"] = 104,
		["143"] = 106,
		["144"] = 107,
		["145"] = 108,
		["146"] = 109,
		["147"] = 109,
		["148"] = 109,
		["149"] = 109,
		["150"] = 109,
		["151"] = 109,
		["153"] = 111,
		["154"] = 112,
		["156"] = 114,
		["157"] = 116,
		["158"] = 117,
		["160"] = 93,
		["161"] = 92,
		["162"] = 91,
		["163"] = 92,
		["165"] = 92,
		["166"] = 123,
		["167"] = 130,
		["168"] = 123,
		["169"] = 130,
		["170"] = 131,
		["171"] = 132,
		["172"] = 133,
		["173"] = 135,
		["174"] = 136,
		["175"] = 136,
		["176"] = 136,
		["177"] = 136,
		["178"] = 136,
		["179"] = 137,
		["180"] = 137,
		["181"] = 137,
		["182"] = 137,
		["183"] = 137,
		["184"] = 137,
		["185"] = 137,
		["186"] = 137,
		["188"] = 131,
		["189"] = 130,
		["190"] = 123,
		["191"] = 123,
		["192"] = 123,
		["193"] = 123,
		["194"] = 123,
		["195"] = 123,
		["196"] = 123,
		["197"] = 130,
		["199"] = 130,
		["200"] = 149,
		["201"] = 157,
		["202"] = 149,
		["203"] = 157,
		["204"] = 160,
		["205"] = 161,
		["206"] = 162,
		["207"] = 160,
		["208"] = 164,
		["209"] = 165,
		["210"] = 166,
		["212"] = 168,
		["213"] = 168,
		["214"] = 168,
		["215"] = 168,
		["216"] = 168,
		["217"] = 169,
		["218"] = 169,
		["219"] = 169,
		["220"] = 169,
		["221"] = 169,
		["222"] = 169,
		["223"] = 169,
		["224"] = 169,
		["225"] = 169,
		["226"] = 170,
		["227"] = 170,
		["228"] = 170,
		["229"] = 170,
		["230"] = 170,
		["231"] = 170,
		["232"] = 170,
		["233"] = 170,
		["235"] = 164,
		["236"] = 173,
		["237"] = 174,
		["238"] = 175,
		["239"] = 175,
		["240"] = 175,
		["241"] = 175,
		["242"] = 175,
		["243"] = 175,
		["244"] = 175,
		["245"] = 175,
		["246"] = 175,
		["247"] = 173,
		["248"] = 157,
		["249"] = 149,
		["250"] = 149,
		["251"] = 149,
		["252"] = 149,
		["253"] = 149,
		["254"] = 149,
		["255"] = 149,
		["256"] = 149,
		["257"] = 157,
		["259"] = 157,
		["260"] = 180,
		["261"] = 188,
		["262"] = 180,
		["263"] = 188,
		["264"] = 190,
		["265"] = 192,
		["266"] = 190,
		["267"] = 194,
		["268"] = 195,
		["269"] = 194,
		["270"] = 188,
		["271"] = 180,
		["272"] = 180,
		["273"] = 180,
		["274"] = 180,
		["275"] = 180,
		["276"] = 180,
		["277"] = 180,
		["278"] = 180,
		["279"] = 188,
		["281"] = 188,
		["283"] = 206,
		["284"] = 207,
		["285"] = 206,
		["286"] = 207,
		["287"] = 208,
		["288"] = 209,
		["289"] = 208,
		["290"] = 207,
		["291"] = 206,
		["292"] = 207,
		["294"] = 207,
		["295"] = 212,
		["296"] = 219,
		["297"] = 212,
		["298"] = 219,
		["299"] = 221,
		["300"] = 222,
		["301"] = 221,
		["302"] = 224,
		["303"] = 225,
		["304"] = 224,
		["305"] = 219,
		["306"] = 212,
		["307"] = 212,
		["308"] = 212,
		["309"] = 212,
		["310"] = 212,
		["311"] = 212,
		["312"] = 212,
		["313"] = 219,
		["315"] = 219,
		["316"] = 232,
		["317"] = 233,
		["318"] = 232,
		["319"] = 233,
		["320"] = 234,
		["321"] = 235,
		["322"] = 234,
		["323"] = 233,
		["324"] = 232,
		["325"] = 233,
		["327"] = 233,
		["328"] = 238,
		["329"] = 245,
		["330"] = 238,
		["331"] = 245,
		["332"] = 247,
		["333"] = 248,
		["334"] = 247,
		["335"] = 250,
		["336"] = 251,
		["337"] = 250,
		["338"] = 253,
		["339"] = 254,
		["340"] = 254,
		["341"] = 256,
		["342"] = 256,
		["343"] = 256,
		["344"] = 254,
		["345"] = 254,
		["346"] = 253,
		["347"] = 259,
		["348"] = 260,
		["349"] = 261,
		["350"] = 261,
		["351"] = 261,
		["352"] = 261,
		["353"] = 261,
		["354"] = 259,
		["355"] = 263,
		["356"] = 264,
		["357"] = 264,
		["358"] = 264,
		["359"] = 264,
		["360"] = 264,
		["361"] = 264,
		["363"] = 264,
		["364"] = 263,
		["365"] = 266,
		["366"] = 267,
		["367"] = 266,
		["368"] = 269,
		["369"] = 270,
		["370"] = 271,
		["373"] = 272,
		["376"] = 275,
		["377"] = 276,
		["380"] = 279,
		["381"] = 280,
		["382"] = 281,
		["385"] = 269,
		["386"] = 285,
		["387"] = 286,
		["388"] = 285,
		["389"] = 294,
		["390"] = 295,
		["391"] = 294,
		["392"] = 245,
		["393"] = 238,
		["394"] = 238,
		["395"] = 238,
		["396"] = 238,
		["397"] = 238,
		["398"] = 238,
		["399"] = 238,
		["400"] = 245,
		["402"] = 245,
		["403"] = 301,
		["404"] = 302,
		["405"] = 301,
		["406"] = 302,
		["407"] = 303,
		["408"] = 304,
		["409"] = 303,
		["410"] = 302,
		["411"] = 301,
		["412"] = 302,
		["414"] = 302,
		["415"] = 307,
		["416"] = 314,
		["417"] = 307,
		["418"] = 314,
		["420"] = 314,
		["421"] = 318,
		["422"] = 307,
		["423"] = 319,
		["424"] = 320,
		["425"] = 321,
		["426"] = 322,
		["427"] = 323,
		["429"] = 319,
		["430"] = 326,
		["431"] = 327,
		["432"] = 328,
		["434"] = 326,
		["435"] = 331,
		["436"] = 332,
		["437"] = 333,
		["438"] = 334,
		["440"] = 331,
		["441"] = 337,
		["442"] = 338,
		["443"] = 337,
		["444"] = 340,
		["445"] = 341,
		["446"] = 342,
		["447"] = 342,
		["448"] = 342,
		["449"] = 341,
		["450"] = 341,
		["451"] = 344,
		["452"] = 344,
		["453"] = 344,
		["454"] = 341,
		["455"] = 341,
		["456"] = 340,
		["457"] = 348,
		["458"] = 349,
		["461"] = 350,
		["462"] = 351,
		["463"] = 352,
		["464"] = 353,
		["465"] = 355,
		["466"] = 356,
		["467"] = 356,
		["468"] = 356,
		["469"] = 356,
		["470"] = 356,
		["471"] = 361,
		["472"] = 362,
		["473"] = 363,
		["474"] = 363,
		["475"] = 363,
		["476"] = 363,
		["477"] = 363,
		["478"] = 363,
		["479"] = 363,
		["480"] = 363,
		["482"] = 356,
		["483"] = 356,
		["485"] = 371,
		["486"] = 371,
		["487"] = 371,
		["488"] = 371,
		["489"] = 371,
		["490"] = 371,
		["491"] = 371,
		["492"] = 371,
		["494"] = 376,
		["495"] = 377,
		["496"] = 377,
		["497"] = 377,
		["498"] = 377,
		["499"] = 377,
		["500"] = 377,
		["501"] = 377,
		["502"] = 377,
		["503"] = 377,
		["504"] = 378,
		["505"] = 378,
		["506"] = 378,
		["507"] = 378,
		["508"] = 378,
		["509"] = 379,
		["510"] = 348,
		["511"] = 381,
		["512"] = 382,
		["513"] = 383,
		["514"] = 381,
		["515"] = 385,
		["516"] = 386,
		["517"] = 387,
		["519"] = 385,
		["520"] = 390,
		["521"] = 391,
		["522"] = 392,
		["523"] = 393,
		["524"] = 394,
		["525"] = 395,
		["526"] = 396,
		["527"] = 397,
		["529"] = 399,
		["530"] = 400,
		["533"] = 390,
		["534"] = 314,
		["535"] = 307,
		["536"] = 307,
		["537"] = 307,
		["538"] = 307,
		["539"] = 307,
		["540"] = 307,
		["541"] = 307,
		["542"] = 314,
		["544"] = 314,
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
	self.tl4_chance = self:GetAbilityTalentValue("legion_commander_talent_4", "chance")
	self.tl4_count = self:GetAbilityTalentValue("legion_commander_talent_4", "count")
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
g.legion_commander_ult = c()
local x = g.legion_commander_ult
x.name = "legion_commander_ult"
d(x, o)
function x.prototype.OnSpellStart(self)
	local y = self:GetCaster()
	local z = y:GetEnemy()
	if not IsInjurable(z, y) then
		return
	end
	local A = self:GetSpecialValueFor("duration") + self:GetTalentValue("legion_commander_talent_3", "duration")
	local B = self:GetTalentValue("legion_commander_talent_5", "bonus_pct")
	y:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	y:EmitSound("Hero_LegionCommander.PressTheAttack")
	local C = self:GetTalentValue("legion_commander_talent_9", "reply")
	local D = self:GetTalentValue("legion_commander_talent_9", "buff_reduce")
	if C > 0 then
		Heal(y, C, self:GetAbilityName(), "Ability")
	end
	if D > 0 then
		ReduceDebuff(y, 0, D)
	end
	y:AddNewModifier(y, self, "modifier_legion_commander_ult", { duration = A })
	if B > 0 then
		y:AddNewModifier(y, self, "modifier_legion_commander_talent_3", { duration = A })
	end
end
x = e({ p(nil) }, x)
g.legion_commander_ult = x
g.modifier_legion_commander_vs = c()
local E = g.modifier_legion_commander_vs
E.name = "modifier_legion_commander_vs"
d(E, l)
function E.prototype.OnCreated(self, s)
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
E = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = true, AllowIllusionDuplicate = false }
	) },
	E
)
g.modifier_legion_commander_vs = E
g.modifier_legion_commander_ult = c()
local F = g.modifier_legion_commander_ult
F.name = "modifier_legion_commander_ult"
d(F, l)
function F.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
		- self:GetAbilityTalentValue("legion_commander_talent_5", "cooldown_reduce")
	self.shield = self:GetAbilitySpecialValueFor("shield")
end
function F.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(math.max(0, self.interval))
	else
		local G = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_legion_commander/legion_commander_press_owner.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			G,
			2,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_attack1",
			self:GetParent():GetAbsOrigin(),
			false
		)
		self:AddParticle(G, false, false, -1, false, false)
	end
end
function F.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local H = AddShield
	local I = self.shield
	local J = self:GetAbility()
	H(t, I, J and J:GetAbilityName(), "Ability")
end
F = e(
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
	F
)
g.modifier_legion_commander_ult = F
g.modifier_legion_commander_talent_3 = c()
local K = g.modifier_legion_commander_talent_3
K.name = "modifier_legion_commander_talent_3"
d(K, l)
function K.prototype.GetAbilitySpecialValue(self)
	self.tl5_bonus_pct = self:GetAbilityTalentValue("legion_commander_talent_5", "bonus_pct")
end
function K.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS_PERCENTAGE] = self.tl5_bonus_pct }
end
K = e(
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
	K
)
g.modifier_legion_commander_talent_3 = K
g.legion_commander_talent_2 = c()
local L = g.legion_commander_talent_2
L.name = "legion_commander_talent_2"
d(L, i)
function L.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_talent_2"
end
L = e({ j(nil) }, L)
g.legion_commander_talent_2 = L
g.modifier_legion_commander_talent_2 = c()
local M = g.modifier_legion_commander_talent_2
M.name = "modifier_legion_commander_talent_2"
d(M, l)
function M.prototype.GetAbilitySpecialValue(self)
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
end
function M.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_chance }
end
M = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	M
)
g.modifier_legion_commander_talent_2 = M
g.legion_commander_talent_7 = c()
local N = g.legion_commander_talent_7
N.name = "legion_commander_talent_7"
d(N, i)
function N.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_talent_7"
end
N = e({ j(nil) }, N)
g.legion_commander_talent_7 = N
g.modifier_legion_commander_talent_7 = c()
local O = g.modifier_legion_commander_talent_7
O.name = "modifier_legion_commander_talent_7"
d(O, l)
function O.prototype.GetTexture(self)
	return "legion_commander_press_the_attack"
end
function O.prototype.GetAbilitySpecialValue(self)
	self.add_value = self:GetAbilitySpecialValueFor("add_value")
end
function O.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = {},
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function O.prototype.SaveStack(self, P)
	local Q = self:LoadStack()
	PlayerData:saveData(self:GetParent():GetPlayerOwnerID(), "legion_commander_talent_7", Q + P)
end
function O.prototype.LoadStack(self)
	local R = PlayerData:loadData(self:GetParent():GetPlayerOwnerID(), "legion_commander_talent_7")
	if R == nil then
		R = 0
	end
	return R
end
function O.prototype.OnBattleStart(self)
	self:SetStackCount(self:LoadStack())
end
function O.prototype.OnBattleEnd(self, s)
	if IsServer() then
		if self.add_value == 0 then
			return
		end
		if s.isNeutral ~= nil then
			return
		end
		local S = self:GetParent():GetPlayerOwnerID()
		if s.illusionPlayerID == S then
			return
		end
		if s.winPlayerID == S then
			self:SaveStack(self.add_value)
			self:SetStackCount(self:LoadStack())
		end
	end
end
function O.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_SHIELD_STACK_BONUS }
end
function O.prototype.EOM_GetModifierShieldStackBonus(self, s)
	return self:GetStackCount()
end
O = e(
	{ m(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	O
)
g.modifier_legion_commander_talent_7 = O
g.legion_commander_shard = c()
local T = g.legion_commander_shard
T.name = "legion_commander_shard"
d(T, i)
function T.prototype.GetIntrinsicModifierName(self)
	return "modifier_legion_commander_shard"
end
T = e({ j(nil) }, T)
g.legion_commander_shard = T
g.modifier_legion_commander_shard = c()
local U = g.modifier_legion_commander_shard
U.name = "modifier_legion_commander_shard"
d(U, l)
function U.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.sect = "16"
end
function U.prototype.GetAbilitySpecialValue(self)
	self.base_duration = self:GetAbilitySpecialValueFor("base_duration")
	self.shield = self:GetAbilitySpecialValueFor("shield")
	if IsServer() then
		self.ready = true
	end
end
function U.prototype.OnCreated(self, s)
	if IsServer() then
		self:FixAbilityLevel()
	end
end
function U.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self.ready = true
	end
end
function U.prototype.OnStackCountChanged(self, V)
	self.base_duration = self:GetAbilitySpecialValueFor("base_duration")
end
function U.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { -1, self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = {
			PlayerResource:GetSelectedHeroEntity(self:GetParent():GetPlayerOwnerID()),
			-1,
		},
	}
end
function U.prototype.OnCustomAttackLanded(self, W)
	if not self.ready then
		return
	end
	self.ready = false
	self:StartIntervalThink(self.base_duration)
	local X = self:GetParent()
	local w = GetAttackDamage(X) + self.shield * GetShield(X) * 0.01
	if X:IsRangedAttacker() then
		Projectile:CreateTrackingProjectile({
			EffectName = X:GetRangedProjectileName(),
			hCaster = X,
			hTarget = W.attacker,
			iMoveSpeed = X:GetProjectileSpeed(),
			OnProjectileHit = function(u, Y, Z)
				if IsValid(self) and IsInjurable(u) then
					DamageSystem:performAttack(X, u, { ability = self:GetAbility(), damage = w })
				end
			end,
		})
	else
		DamageSystem:performAttack(X, W.attacker, { damage = w, ability = self:GetAbility() })
	end
	local v = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_legion_commander/legion_commander_courage_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		X
	)
	ParticleManager:SetParticleControlEnt(v, 1, X, PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, false)
	ParticleManager:SetParticleControl(v, 2, Vector(0, 1, 0))
	X:EmitSound("Hero_LegionCommander.Courage")
end
function U.prototype.OnBattleStartBefore(self, s)
	self:FixAbilityLevel()
	self.ready = true
end
function U.prototype.OnAbilityLearn(self, s)
	if s.abilityname == self.sect then
		self:FixAbilityLevel()
	end
end
function U.prototype.FixAbilityLevel(self)
	if IsServer() then
		local _ = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		if _ then
			local a0 = _:getAbilityUpgradeData()
			local a1 = 1
			if a0[self.sect] then
				a1 = a0[self.sect].level
			end
			self:GetAbility():SetLevel(Clamp(a1, 1, 3))
			self:IncrementStackCount()
		end
	end
end
U = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	U
)
g.modifier_legion_commander_shard = U
return g