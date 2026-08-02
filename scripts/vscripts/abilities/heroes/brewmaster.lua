--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/brewmaster"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SparseArrayNew
local g = b.__TS__SparseArrayPush
local h = b.__TS__SparseArraySpread
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["21"] = 6,
		["22"] = 7,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 9,
		["27"] = 8,
		["28"] = 7,
		["29"] = 6,
		["30"] = 7,
		["32"] = 7,
		["33"] = 13,
		["34"] = 21,
		["35"] = 13,
		["36"] = 21,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 32,
		["42"] = 33,
		["43"] = 34,
		["44"] = 28,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 37,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 37,
		["55"] = 37,
		["56"] = 36,
		["57"] = 42,
		["58"] = 43,
		["59"] = 44,
		["60"] = 46,
		["61"] = 47,
		["63"] = 42,
		["64"] = 50,
		["65"] = 52,
		["66"] = 53,
		["68"] = 50,
		["69"] = 56,
		["70"] = 57,
		["71"] = 59,
		["72"] = 60,
		["75"] = 62,
		["76"] = 62,
		["77"] = 63,
		["79"] = 64,
		["80"] = 65,
		["82"] = 66,
		["83"] = 66,
		["84"] = 66,
		["85"] = 66,
		["86"] = 66,
		["87"] = 66,
		["88"] = 66,
		["89"] = 66,
		["90"] = 66,
		["91"] = 66,
		["94"] = 68,
		["96"] = 69,
		["97"] = 69,
		["98"] = 69,
		["99"] = 69,
		["100"] = 69,
		["101"] = 69,
		["102"] = 69,
		["103"] = 69,
		["104"] = 69,
		["105"] = 69,
		["108"] = 71,
		["110"] = 72,
		["112"] = 72,
		["113"] = 72,
		["114"] = 72,
		["116"] = 72,
		["119"] = 72,
		["120"] = 72,
		["122"] = 72,
		["125"] = 74,
		["127"] = 75,
		["129"] = 75,
		["130"] = 75,
		["131"] = 75,
		["133"] = 75,
		["136"] = 75,
		["137"] = 75,
		["139"] = 75,
		["146"] = 62,
		["149"] = 82,
		["150"] = 83,
		["151"] = 83,
		["152"] = 83,
		["153"] = 83,
		["154"] = 83,
		["155"] = 83,
		["157"] = 56,
		["158"] = 21,
		["159"] = 13,
		["160"] = 13,
		["161"] = 13,
		["162"] = 13,
		["163"] = 13,
		["164"] = 13,
		["165"] = 13,
		["166"] = 13,
		["167"] = 21,
		["169"] = 21,
		["171"] = 89,
		["172"] = 90,
		["173"] = 89,
		["174"] = 90,
		["175"] = 91,
		["176"] = 92,
		["177"] = 93,
		["178"] = 95,
		["179"] = 96,
		["180"] = 97,
		["181"] = 98,
		["182"] = 101,
		["183"] = 107,
		["184"] = 108,
		["186"] = 109,
		["187"] = 109,
		["188"] = 110,
		["189"] = 109,
		["193"] = 114,
		["194"] = 114,
		["195"] = 114,
		["196"] = 114,
		["197"] = 114,
		["199"] = 115,
		["200"] = 115,
		["201"] = 116,
		["202"] = 115,
		["206"] = 119,
		["207"] = 119,
		["208"] = 119,
		["209"] = 119,
		["210"] = 119,
		["211"] = 119,
		["212"] = 120,
		["213"] = 120,
		["214"] = 120,
		["215"] = 120,
		["216"] = 120,
		["217"] = 120,
		["218"] = 121,
		["219"] = 121,
		["220"] = 121,
		["221"] = 121,
		["222"] = 121,
		["223"] = 121,
		["224"] = 121,
		["225"] = 122,
		["226"] = 122,
		["227"] = 122,
		["228"] = 122,
		["229"] = 122,
		["230"] = 122,
		["231"] = 122,
		["232"] = 124,
		["233"] = 125,
		["235"] = 91,
		["236"] = 90,
		["237"] = 89,
		["238"] = 90,
		["240"] = 90,
		["242"] = 131,
		["243"] = 132,
		["244"] = 131,
		["245"] = 132,
		["246"] = 133,
		["247"] = 134,
		["248"] = 133,
		["249"] = 132,
		["250"] = 131,
		["251"] = 132,
		["253"] = 132,
		["254"] = 137,
		["255"] = 145,
		["256"] = 137,
		["257"] = 145,
		["258"] = 147,
		["259"] = 148,
		["260"] = 147,
		["261"] = 150,
		["262"] = 151,
		["263"] = 150,
		["264"] = 145,
		["265"] = 137,
		["266"] = 137,
		["267"] = 137,
		["268"] = 137,
		["269"] = 137,
		["270"] = 137,
		["271"] = 137,
		["272"] = 137,
		["273"] = 145,
		["275"] = 145,
		["277"] = 158,
		["278"] = 159,
		["279"] = 158,
		["280"] = 159,
		["281"] = 160,
		["282"] = 161,
		["283"] = 160,
		["284"] = 159,
		["285"] = 158,
		["286"] = 159,
		["288"] = 159,
		["289"] = 164,
		["290"] = 172,
		["291"] = 164,
		["292"] = 172,
		["293"] = 174,
		["294"] = 175,
		["295"] = 174,
		["296"] = 177,
		["297"] = 178,
		["298"] = 177,
		["299"] = 172,
		["300"] = 164,
		["301"] = 164,
		["302"] = 164,
		["303"] = 164,
		["304"] = 164,
		["305"] = 164,
		["306"] = 164,
		["307"] = 164,
		["308"] = 172,
		["310"] = 172,
		["312"] = 185,
		["313"] = 192,
		["314"] = 185,
		["315"] = 192,
		["316"] = 194,
		["317"] = 195,
		["318"] = 194,
		["319"] = 197,
		["320"] = 198,
		["321"] = 197,
		["322"] = 202,
		["323"] = 203,
		["324"] = 204,
		["326"] = 202,
		["327"] = 192,
		["328"] = 185,
		["329"] = 185,
		["330"] = 185,
		["331"] = 185,
		["332"] = 185,
		["333"] = 185,
		["334"] = 185,
		["335"] = 192,
		["337"] = 192,
		["339"] = 210,
		["340"] = 211,
		["341"] = 210,
		["342"] = 211,
		["343"] = 212,
		["344"] = 213,
		["345"] = 212,
		["346"] = 211,
		["347"] = 210,
		["348"] = 211,
		["350"] = 211,
		["351"] = 216,
		["352"] = 224,
		["353"] = 216,
		["354"] = 224,
		["355"] = 226,
		["356"] = 227,
		["357"] = 226,
		["358"] = 229,
		["359"] = 230,
		["360"] = 231,
		["362"] = 229,
		["363"] = 234,
		["364"] = 235,
		["365"] = 234,
		["366"] = 239,
		["367"] = 240,
		["368"] = 239,
		["369"] = 224,
		["370"] = 216,
		["371"] = 216,
		["372"] = 216,
		["373"] = 216,
		["374"] = 216,
		["375"] = 216,
		["376"] = 216,
		["377"] = 216,
		["378"] = 224,
		["380"] = 224,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
local q = require("abilities.ability_ai")
local r = q.BaseAbilityAI
local s = q.registerAbilityAI
j.brewmaster_talent = c()
local t = j.brewmaster_talent
t.name = "brewmaster_talent"
d(t, l)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_brewmaster_talent"
end
t = e({ m(nil) }, t)
j.brewmaster_talent = t
j.modifier_brewmaster_talent = c()
local u = j.modifier_brewmaster_talent
u.name = "modifier_brewmaster_talent"
d(u, o)
function u.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.status_count = self:GetAbilitySpecialValueFor("status_count")
		+ self:GetAbilityTalentValue("brewmaster_talent_2", "drunken_brawler_data")
	self.drunken_brawler_damage = self:GetAbilityTalentValue("brewmaster_talent_9", "drunken_brawler_damage")
	self.mana_per_wisp_die = self:GetAbilityTalentValue("brewmaster_talent_10", "mana_per_wisp_die")
	self.chance_2x = self:GetAbilityTalentValue("brewmaster_talent_5", "chance")
	self.chance_attack = self:GetAbilityTalentValue("brewmaster_talent_11", "chance")
end
function u.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_DIE] = { -1, self:GetParent() },
	}
end
function u.prototype.OnWispDie(self, v)
	local w = self:GetParent()
	self:DrunkenBrawler(self.count)
	if self:HasTalent("brewmaster_talent_10") and self.mana_per_wisp_die > 0 then
		w:GiveMana(self.mana_per_wisp_die)
	end
end
function u.prototype.OnCustomAttackLanded(self, x)
	if self:HasTalent("brewmaster_talent_11") and self:PRD(self.chance_attack) then
		self:DrunkenBrawler(self.count)
	end
end
function u.prototype.DrunkenBrawler(self, y)
	local w = self:GetParent()
	if self:HasTalent("brewmaster_talent_5") and self:PRD(self.chance_2x) then
		y = y + 1
	end
	do
		local z = 0
		while z < y do
			local A = RandomInt(1, 4)
			repeat
				local B = A
				local C = B == 1
				if C then
					local D = AddShield
					local E = self:GetParent()
					local F = self.status_count
					local G = self:GetAbility()
					D(E, F, G and G:GetAbilityName(), "Ability")
					break
				end
				C = C or B == 2
				if C then
					local H = AddFury
					local I = self:GetParent()
					local J = self.status_count
					local K = self:GetAbility()
					H(I, J, K and K:GetAbilityName(), "Ability")
					break
				end
				C = C or B == 3
				if C then
					local L = AddInjury
					local M = f(self:GetParent(), self:GetParent():GetEnemy(), self.status_count)
					local N = self:GetAbility()
					g(M, N and N:GetAbilityName(), "Ability")
					L(h(M))
					break
				end
				C = C or B == 4
				if C then
					local O = AddIce
					local P = f(self:GetParent(), self:GetParent():GetEnemy(), self.status_count)
					local Q = self:GetAbility()
					g(P, Q and Q:GetAbilityName(), "Ability")
					O(h(P))
					break
				end
				do
					break
				end
			until true
			z = z + 1
		end
	end
	if self:HasTalent("brewmaster_talent_9") and self.drunken_brawler_damage > 0 then
		w:DealDamage(
			w:GetEnemy(),
			self:GetAbility(),
			self.drunken_brawler_damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		)
	end
end
u = e(
	{
		p(
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
	u
)
j.modifier_brewmaster_talent = u
j.brewmaster_ult = c()
local R = j.brewmaster_ult
R.name = "brewmaster_ult"
d(R, r)
function R.prototype.OnSpellStart(self)
	local S = self:GetCaster()
	S:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	local T = self:GetSpecialValueFor("wisp_count") + self:GetTalentValue("brewmaster_talent_12", "num")
	local U = (
		self:GetSpecialValueFor("wisp_health") + self:GetTalentValue("brewmaster_talent_4", "primal_split_health")
	) * (1 + self:GetTalentValue("brewmaster_talent_12", "wisp_health_pct") * 0.01)
	local V = self:GetSpecialValueFor("status") + self:GetTalentValue("brewmaster_talent_7", "primal_split_data")
	local W = self:GetTalentValue("brewmaster_talent_6", "duration")
	local X = {
		"models/heroes/brewmaster/brewmaster_firespirit.vmdl",
		"models/heroes/brewmaster/brewmaster_earthspirit.vmdl",
		"models/heroes/brewmaster/brewmaster_windspirit.vmdl",
		"models/heroes/brewmaster/brewmaster_voidspirit.vmdl",
	}
	local A = GetWispCount(S)
	if A + T <= 4 then
		do
			local z = 0
			while z < T do
				SummonWisp(S, U, X[z + 1])
				z = z + 1
			end
		end
	else
		HealWisp(S, self, U * math.min(T + A - 4, T) / A)
		do
			local z = 0
			while z < 4 - A do
				SummonWisp(S, U)
				z = z + 1
			end
		end
	end
	AddShield(S, V, self:GetAbilityName(), "Ability")
	AddFury(S, V, self:GetAbilityName(), "Ability")
	AddInjury(S, S:GetEnemy(), V, self:GetAbilityName(), "Ability")
	AddIce(S, S:GetEnemy(), V, self:GetAbilityName(), "Ability")
	if self:HasTalent("brewmaster_talent_6") and W > 0 then
		S:AddNewModifier(S, self, "modifier_brewmaster_talent_6", { duration = W })
	end
end
R = e({ s(nil) }, R)
j.brewmaster_ult = R
j.brewmaster_talent_1 = c()
local Y = j.brewmaster_talent_1
Y.name = "brewmaster_talent_1"
d(Y, l)
function Y.prototype.GetIntrinsicModifierName(self)
	return "modifier_brewmaster_talent_1"
end
Y = e({ m(nil) }, Y)
j.brewmaster_talent_1 = Y
j.modifier_brewmaster_talent_1 = c()
local Z = j.modifier_brewmaster_talent_1
Z.name = "modifier_brewmaster_talent_1"
d(Z, o)
function Z.prototype.GetAbilitySpecialValue(self)
	self.wisp_regen = self:GetAbilityTalentValue("brewmaster_talent_1", "wisp_regen")
end
function Z.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_REGEN] = self.wisp_regen }
end
Z = e(
	{
		p(
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
	Z
)
j.modifier_brewmaster_talent_1 = Z
j.brewmaster_talent_3 = c()
local _ = j.brewmaster_talent_3
_.name = "brewmaster_talent_3"
d(_, l)
function _.prototype.GetIntrinsicModifierName(self)
	return "modifier_brewmaster_talent_3"
end
_ = e({ m(nil) }, _)
j.brewmaster_talent_3 = _
j.modifier_brewmaster_talent_3 = c()
local a0 = j.modifier_brewmaster_talent_3
a0.name = "modifier_brewmaster_talent_3"
d(a0, o)
function a0.prototype.GetAbilitySpecialValue(self)
	self.wisp_damage_share_reduce = self:GetAbilitySpecialValueFor("wisp_damage_share_reduce")
end
function a0.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_SHARE_PERCENTAGE] = -self.wisp_damage_share_reduce,
	}
end
a0 = e(
	{
		p(
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
	a0
)
j.modifier_brewmaster_talent_3 = a0
j.modifier_brewmaster_talent_6 = c()
local a1 = j.modifier_brewmaster_talent_6
a1.name = "modifier_brewmaster_talent_6"
d(a1, o)
function a1.prototype.GetAbilitySpecialValue(self)
	self.wisp_damage_bonus = self:GetAbilitySpecialValueFor("wisp_damage_bonus")
end
function a1.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function a1.prototype.EOM_GetModifierOutgoingDamagePercentage(self, v)
	if v and v.inflictor and v.inflictor:GetAbilityName() == "sect_wisp" then
		return self.wisp_damage_bonus
	end
end
a1 = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	a1
)
j.modifier_brewmaster_talent_6 = a1
j.brewmaster_talent_8 = c()
local a2 = j.brewmaster_talent_8
a2.name = "brewmaster_talent_8"
d(a2, l)
function a2.prototype.GetIntrinsicModifierName(self)
	return "modifier_brewmaster_talent_8"
end
a2 = e({ m(nil) }, a2)
j.brewmaster_talent_8 = a2
j.modifier_brewmaster_talent_8 = c()
local a3 = j.modifier_brewmaster_talent_8
a3.name = "modifier_brewmaster_talent_8"
d(a3, o)
function a3.prototype.GetAbilitySpecialValue(self)
	self.wisp_health_per_victory = self:GetAbilitySpecialValueFor("wisp_health_per_victory")
end
function a3.prototype.OnCreated(self, v)
	if IsServer() then
		self:SetStackCount(PlayerData:getTotalWin(self:GetParent():GetPlayerOwnerID()) * self.wisp_health_per_victory)
	end
end
function a3.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_PERCENTAGE }
end
function a3.prototype.EOM_GetModifierWispHealthPercentage(self)
	return self:GetStackCount()
end
a3 = e(
	{
		p(
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
	a3
)
j.modifier_brewmaster_talent_8 = a3
return j