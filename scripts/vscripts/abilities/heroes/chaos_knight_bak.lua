--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/chaos_knight_bak"
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
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 24,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 30,
		["43"] = 29,
		["44"] = 34,
		["45"] = 35,
		["48"] = 36,
		["49"] = 37,
		["50"] = 38,
		["51"] = 38,
		["52"] = 38,
		["53"] = 38,
		["54"] = 38,
		["55"] = 38,
		["56"] = 40,
		["57"] = 41,
		["58"] = 41,
		["59"] = 41,
		["60"] = 41,
		["61"] = 41,
		["62"] = 41,
		["63"] = 41,
		["64"] = 41,
		["65"] = 41,
		["66"] = 41,
		["69"] = 34,
		["70"] = 20,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 20,
		["81"] = 20,
		["82"] = 48,
		["83"] = 49,
		["84"] = 48,
		["85"] = 49,
		["86"] = 50,
		["87"] = 51,
		["88"] = 52,
		["89"] = 53,
		["90"] = 54,
		["91"] = 55,
		["92"] = 56,
		["94"] = 57,
		["95"] = 57,
		["96"] = 58,
		["97"] = 58,
		["98"] = 58,
		["99"] = 58,
		["100"] = 58,
		["101"] = 58,
		["102"] = 64,
		["103"] = 65,
		["104"] = 66,
		["106"] = 68,
		["107"] = 68,
		["108"] = 68,
		["109"] = 68,
		["110"] = 68,
		["111"] = 68,
		["112"] = 69,
		["113"] = 58,
		["114"] = 58,
		["115"] = 57,
		["118"] = 73,
		["119"] = 50,
		["120"] = 49,
		["121"] = 48,
		["122"] = 49,
		["124"] = 49,
		["126"] = 82,
		["127"] = 83,
		["128"] = 82,
		["129"] = 83,
		["130"] = 84,
		["131"] = 85,
		["132"] = 84,
		["133"] = 83,
		["134"] = 82,
		["135"] = 83,
		["137"] = 83,
		["138"] = 88,
		["139"] = 95,
		["140"] = 88,
		["141"] = 95,
		["142"] = 97,
		["143"] = 98,
		["144"] = 97,
		["145"] = 100,
		["146"] = 101,
		["147"] = 100,
		["148"] = 95,
		["149"] = 88,
		["150"] = 88,
		["151"] = 88,
		["152"] = 88,
		["153"] = 88,
		["154"] = 88,
		["155"] = 88,
		["156"] = 95,
		["158"] = 95,
		["159"] = 108,
		["160"] = 109,
		["161"] = 108,
		["162"] = 109,
		["163"] = 110,
		["164"] = 111,
		["165"] = 110,
		["166"] = 109,
		["167"] = 108,
		["168"] = 109,
		["170"] = 109,
		["171"] = 114,
		["172"] = 121,
		["173"] = 114,
		["174"] = 121,
		["175"] = 123,
		["176"] = 124,
		["177"] = 123,
		["178"] = 126,
		["179"] = 127,
		["180"] = 126,
		["181"] = 121,
		["182"] = 114,
		["183"] = 114,
		["184"] = 114,
		["185"] = 114,
		["186"] = 114,
		["187"] = 114,
		["188"] = 114,
		["189"] = 121,
		["191"] = 121,
		["192"] = 134,
		["193"] = 135,
		["194"] = 134,
		["195"] = 135,
		["196"] = 136,
		["197"] = 137,
		["198"] = 136,
		["199"] = 135,
		["200"] = 134,
		["201"] = 135,
		["203"] = 135,
		["204"] = 140,
		["205"] = 147,
		["206"] = 140,
		["207"] = 147,
		["208"] = 151,
		["209"] = 152,
		["210"] = 153,
		["211"] = 151,
		["212"] = 155,
		["213"] = 156,
		["214"] = 155,
		["215"] = 160,
		["216"] = 161,
		["217"] = 160,
		["218"] = 147,
		["219"] = 140,
		["220"] = 140,
		["221"] = 140,
		["222"] = 140,
		["223"] = 140,
		["224"] = 140,
		["225"] = 140,
		["226"] = 147,
		["228"] = 147,
		["229"] = 166,
		["230"] = 167,
		["231"] = 166,
		["232"] = 167,
		["233"] = 168,
		["234"] = 169,
		["235"] = 168,
		["236"] = 167,
		["237"] = 166,
		["238"] = 167,
		["240"] = 167,
		["241"] = 172,
		["242"] = 179,
		["243"] = 172,
		["244"] = 179,
		["245"] = 182,
		["246"] = 183,
		["247"] = 184,
		["248"] = 182,
		["249"] = 186,
		["250"] = 187,
		["251"] = 188,
		["252"] = 188,
		["253"] = 187,
		["254"] = 186,
		["255"] = 191,
		["256"] = 192,
		["257"] = 193,
		["258"] = 193,
		["259"] = 193,
		["260"] = 193,
		["261"] = 193,
		["262"] = 193,
		["264"] = 191,
		["265"] = 179,
		["266"] = 172,
		["267"] = 172,
		["268"] = 172,
		["269"] = 172,
		["270"] = 172,
		["271"] = 172,
		["272"] = 172,
		["273"] = 179,
		["275"] = 179,
		["276"] = 200,
		["277"] = 209,
		["278"] = 200,
		["279"] = 209,
		["280"] = 211,
		["281"] = 212,
		["282"] = 211,
		["283"] = 214,
		["284"] = 215,
		["285"] = 216,
		["287"] = 214,
		["288"] = 219,
		["289"] = 220,
		["290"] = 221,
		["292"] = 219,
		["293"] = 224,
		["294"] = 225,
		["295"] = 224,
		["296"] = 229,
		["297"] = 230,
		["298"] = 229,
		["299"] = 209,
		["300"] = 200,
		["301"] = 200,
		["302"] = 200,
		["303"] = 200,
		["304"] = 200,
		["305"] = 200,
		["306"] = 200,
		["307"] = 200,
		["308"] = 200,
		["309"] = 209,
		["311"] = 209,
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
g.chaos_knight_talent = c()
local q = g.chaos_knight_talent
q.name = "chaos_knight_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_talent"
end
q = e({ j(nil) }, q)
g.chaos_knight_talent = q
g.modifier_chaos_knight_talent = c()
local r = g.modifier_chaos_knight_talent
r.name = "modifier_chaos_knight_talent"
d(r, l)
function r.prototype.GetAbilitySpecialValue(self)
	self.health_damage = self:GetAbilitySpecialValueFor("health_damage")
	self.talent_5_health_regen_pct = self:GetAbilityTalentValue("chaos_knight_talent_5", "health_regen_pct")
	self.talent_5_chance = self:GetAbilityTalentValue("chaos_knight_talent_5", "chance")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function r.prototype.OnCritical(self, s)
	if self:GetCaster():PassivesDisabled() then
		return
	end
	if bit.band(s.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION then
		local t = s.attacker:GetMaxHealth() * self.health_damage * 0.01
		s.attacker:DealChaosDamage(s.target, self:GetAbility(), t, DamageFlags.DAMAGE_FLAG_REFLECTION)
		if self.talent_5_chance > 0 and self:PRD(self.talent_5_chance, "chaos_knight_talent_5") then
			local u = Heal
			local v = s.attacker
			local w = t * self.talent_5_health_regen_pct * 0.01
			local x = self:GetAbility()
			u(v, w, x and x:GetAbilityName(), "Ability")
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
g.modifier_chaos_knight_talent = r
g.chaos_knight_ult = c()
local y = g.chaos_knight_ult
y.name = "chaos_knight_ult"
d(y, o)
function y.prototype.OnSpellStart(self)
	local z = self:GetCaster()
	z:EmitSound("Hero_ChaosKnight.ChaosBolt.Cast")
	z:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	local A = z:GetEnemy()
	local B = self:GetSpecialValueFor("max_count") + self:GetTalentValue("chaos_knight_talent_2", "count_bonus")
	local C = self:GetTalentValue("chaos_knight_talent_1", "stun_duration")
	do
		local D = 0
		while D < B do
			Projectile:CreateTrackingProjectile({
				EffectName = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf",
				hCaster = z,
				vSpawnOrigin = D > 0 and z:GetAbsOrigin() + RandomVector(150) + Vector(0, 0, 75) or nil,
				hTarget = A,
				iMoveSpeed = 600,
				OnProjectileHit = function(A, E, F)
					if C > 0 then
						AddStun(z, A, self, C)
					end
					z:DealDamage(A, self, self:GetSpecialValueFor("damage"), EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
					EmitSoundOnLocationWithCaster(E, "Hero_ChaosKnight.ChaosBolt.Impact", z)
				end,
			})
			D = D + 1
		end
	end
	z:EmitSound("Hero_ChaosKnight.ChaosBolt")
end
y = e({ p(nil) }, y)
g.chaos_knight_ult = y
g.chaos_knight_talent_3 = c()
local G = g.chaos_knight_talent_3
G.name = "chaos_knight_talent_3"
d(G, i)
function G.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_talent_3"
end
G = e({ j(nil) }, G)
g.chaos_knight_talent_3 = G
g.modifier_chaos_knight_talent_3 = c()
local H = g.modifier_chaos_knight_talent_3
H.name = "modifier_chaos_knight_talent_3"
d(H, l)
function H.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilitySpecialValueFor("health_bonus")
end
function H.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS] = self.health_bonus or 0 }
end
H = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	H
)
g.modifier_chaos_knight_talent_3 = H
g.chaos_knight_talent_4 = c()
local I = g.chaos_knight_talent_4
I.name = "chaos_knight_talent_4"
d(I, i)
function I.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_talent_4"
end
I = e({ j(nil) }, I)
g.chaos_knight_talent_4 = I
g.modifier_chaos_knight_talent_4 = c()
local J = g.modifier_chaos_knight_talent_4
J.name = "modifier_chaos_knight_talent_4"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
end
function J.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_CHANCE_BONUS] = self.crit_chance or 0 }
end
J = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	J
)
g.modifier_chaos_knight_talent_4 = J
g.chaos_knight_talent_6 = c()
local K = g.chaos_knight_talent_6
K.name = "chaos_knight_talent_6"
d(K, i)
function K.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_talent_6"
end
K = e({ j(nil) }, K)
g.chaos_knight_talent_6 = K
g.modifier_chaos_knight_talent_6 = c()
local L = g.modifier_chaos_knight_talent_6
L.name = "modifier_chaos_knight_talent_6"
d(L, l)
function L.prototype.GetAbilitySpecialValue(self)
	self.min_crit_damage_pct = self:GetAbilitySpecialValueFor("min_crit_damage_pct")
	self.max_crit_damage_pct = self:GetAbilitySpecialValueFor("max_crit_damage_pct")
end
function L.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PHYSICAL_CRITICALSTRIKE_DAMAGE }
end
function L.prototype.EOM_GetModifierPhysicalCriticalStrikeDamage(self)
	return RandomInt(self.min_crit_damage_pct, self.max_crit_damage_pct)
end
L = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	L
)
g.modifier_chaos_knight_talent_6 = L
g.chaos_knight_talent_7 = c()
local M = g.chaos_knight_talent_7
M.name = "chaos_knight_talent_7"
d(M, i)
function M.prototype.GetIntrinsicModifierName(self)
	return "modifier_chaos_knight_talent_7"
end
M = e({ j(nil) }, M)
g.chaos_knight_talent_7 = M
g.modifier_chaos_knight_talent_7 = c()
local N = g.modifier_chaos_knight_talent_7
N.name = "modifier_chaos_knight_talent_7"
d(N, l)
function N.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function N.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL] = { self:GetParent(), -1 } }
end
function N.prototype.OnCritical(self, s)
	if
		bit.band(s.damage_flags, DamageFlags.DAMAGE_FLAG_REFLECTION) ~= DamageFlags.DAMAGE_FLAG_REFLECTION
		and self:PRD(self.chance)
	then
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_chaos_knight_talent_7_buff",
			{ duration = self.duration }
		)
	end
end
N = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	N
)
g.modifier_chaos_knight_talent_7 = N
g.modifier_chaos_knight_talent_7_buff = c()
local O = g.modifier_chaos_knight_talent_7_buff
O.name = "modifier_chaos_knight_talent_7_buff"
d(O, l)
function O.prototype.GetAbilitySpecialValue(self)
	self.health_bonus = self:GetAbilitySpecialValueFor("health_bonus")
end
function O.prototype.OnCreated(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function O.prototype.OnRefresh(self, s)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function O.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function O.prototype.EOM_GetModifierHealthBonus(self, s)
	return self:GetStackCount() * self.health_bonus
end
O = e(
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
				IsIndependent = true,
			}
		),
	},
	O
)
g.modifier_chaos_knight_talent_7_buff = O
return g