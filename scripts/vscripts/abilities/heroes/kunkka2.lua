--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/kunkka2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__ArrayFilter
local h = b.__TS__ArrayReduce
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
		["20"] = 5,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["24"] = 7,
		["25"] = 8,
		["26"] = 7,
		["27"] = 6,
		["28"] = 5,
		["29"] = 6,
		["31"] = 6,
		["32"] = 12,
		["33"] = 20,
		["34"] = 12,
		["35"] = 20,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 31,
		["40"] = 35,
		["41"] = 36,
		["42"] = 35,
		["43"] = 41,
		["44"] = 42,
		["45"] = 43,
		["46"] = 44,
		["47"] = 45,
		["48"] = 45,
		["49"] = 45,
		["50"] = 46,
		["51"] = 47,
		["54"] = 48,
		["56"] = 45,
		["57"] = 45,
		["58"] = 41,
		["59"] = 52,
		["60"] = 53,
		["61"] = 54,
		["62"] = 55,
		["65"] = 58,
		["66"] = 58,
		["67"] = 63,
		["68"] = 64,
		["69"] = 65,
		["70"] = 65,
		["71"] = 65,
		["72"] = 66,
		["73"] = 67,
		["74"] = 68,
		["75"] = 69,
		["76"] = 65,
		["77"] = 65,
		["78"] = 72,
		["79"] = 72,
		["80"] = 72,
		["81"] = 72,
		["82"] = 73,
		["83"] = 73,
		["84"] = 73,
		["85"] = 73,
		["86"] = 73,
		["87"] = 73,
		["88"] = 73,
		["89"] = 52,
		["90"] = 75,
		["91"] = 76,
		["92"] = 77,
		["93"] = 78,
		["94"] = 79,
		["95"] = 80,
		["98"] = 83,
		["99"] = 84,
		["100"] = 85,
		["101"] = 75,
		["102"] = 87,
		["103"] = 88,
		["104"] = 88,
		["105"] = 88,
		["106"] = 88,
		["107"] = 88,
		["108"] = 87,
		["109"] = 20,
		["110"] = 12,
		["111"] = 12,
		["112"] = 12,
		["113"] = 12,
		["114"] = 12,
		["115"] = 12,
		["116"] = 12,
		["117"] = 12,
		["118"] = 20,
		["120"] = 20,
		["121"] = 94,
		["122"] = 95,
		["123"] = 94,
		["124"] = 95,
		["125"] = 96,
		["126"] = 97,
		["127"] = 98,
		["128"] = 99,
		["129"] = 100,
		["130"] = 101,
		["131"] = 102,
		["132"] = 103,
		["133"] = 104,
		["134"] = 105,
		["135"] = 106,
		["136"] = 106,
		["137"] = 106,
		["138"] = 107,
		["139"] = 108,
		["140"] = 109,
		["141"] = 110,
		["142"] = 111,
		["143"] = 112,
		["145"] = 114,
		["146"] = 115,
		["148"] = 106,
		["149"] = 106,
		["150"] = 118,
		["151"] = 119,
		["152"] = 120,
		["153"] = 96,
		["154"] = 95,
		["155"] = 94,
		["156"] = 95,
		["158"] = 95,
		["159"] = 124,
		["160"] = 132,
		["161"] = 124,
		["162"] = 132,
		["163"] = 132,
		["164"] = 124,
		["165"] = 124,
		["166"] = 124,
		["167"] = 124,
		["168"] = 124,
		["169"] = 124,
		["170"] = 124,
		["171"] = 124,
		["172"] = 132,
		["174"] = 132,
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
j.kunkka_talent = c()
local t = j.kunkka_talent
t.name = "kunkka_talent"
d(t, l)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_kunkka_talent"
end
t = e({ m(nil) }, t)
j.kunkka_talent = t
j.modifier_kunkka_talent = c()
local u = j.modifier_kunkka_talent
u.name = "modifier_kunkka_talent"
d(u, o)
function u.prototype.GetAbilitySpecialValue(self)
	self.reduce_pct = self:GetAbilitySpecialValueFor("reduce_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function u.prototype.OnBattleStart(self, v)
	self.record = 0
	self.recordList = {}
	self:StartIntervalThink(1)
	self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_PREDAMAGE, function(w, v, x, y)
		if y == self:GetParent() then
			if self:GetCaster():PassivesDisabled() then
				return
			end
			self:OnPreDamage(v)
		end
	end)
end
function u.prototype.OnIntervalThink(self)
	local z = self:GetParent()
	local y = z:GetEnemy()
	if not IsInjurable(z, y) then
		return
	end
	local A = self.recordList
	A[#A + 1] = { damage = self.record, remainDamage = self.record, time = 0 }
	self.record = 0
	local B = 0
	f(self.recordList, function(C, D, E)
		D.time = D.time + 1
		local F = D.time == self.duration and D.remainDamage or D.damage * 1 / self.duration
		D.remainDamage = D.remainDamage - F
		B = B + F
	end)
	self.recordList = g(self.recordList, function(C, D)
		return D.remainDamage > 0
	end)
	y:DealDamage(
		z,
		self:GetAbility(),
		B,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
		DamageFlags.DAMAGE_FLAG_HPLOSS + DamageFlags.DAMAGE_FLAG_REFLECTION
	)
end
function u.prototype.OnPreDamage(self, G)
	local H = self.reduce_pct
	if G.target:HasModifier("modifier_kunkka_ult") then
		local I = G.target:FindAbilityByName("kunkka_ult")
		if IsValid(I) then
			H = H + I:GetSpecialValueFor("bonus_pct")
		end
	end
	local J = math.floor(G.damage * H * 0.01)
	G.damage = G.damage - J
	self.record = self.record + J
end
function u.prototype.getTotalRecord(self)
	return h(self.recordList, function(C, K, L)
		return K + L.remainDamage
	end, 0)
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
j.modifier_kunkka_talent = u
j.kunkka_ult = c()
local M = j.kunkka_ult
M.name = "kunkka_ult"
d(M, r)
function M.prototype.OnSpellStart(self)
	local N = self:GetCaster()
	local y = N:GetEnemy()
	local O = self:GetSpecialValueFor("duration")
	local P = self:GetSpecialValueFor("damage_pct")
	local Q = (y:GetAbsOrigin() - N:GetAbsOrigin()):Normalized()
	local R = y:GetAbsOrigin() + Q * -400 * O
	local S = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kunkka/kunkka_ghost_ship.vpcf",
		PATTACH_CUSTOMORIGIN,
		N
	)
	ParticleManager:SetParticleControl(S, 0, R)
	ParticleManager:SetParticleControl(S, 1, Q * 400)
	GameTimer(O, function()
		ParticleManager:DestroyParticle(S, false)
		if IsInjurable(N, y) then
			local B = self:GetSpecialValueFor("damage")
			local T = N:FindModifierByName("modifier_kunkka_talent")
			if IsValid(T) then
				B = B + T:getTotalRecord() * P * 0.01
			end
			N:DealDamage(y, self, B, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
			N:EmitSound("Ability.Ghostship.crash")
		end
	end)
	N:EmitSound("Ability.Ghostship.bell")
	N:EmitSound("Ability.Ghostship")
	N:AddNewModifier(N, self, "modifier_kunkka_ult", { duration = O })
end
M = e({ s(nil) }, M)
j.kunkka_ult = M
j.modifier_kunkka_ult = c()
local U = j.modifier_kunkka_ult
U.name = "modifier_kunkka_ult"
d(U, o)
U = e(
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
	U
)
j.modifier_kunkka_ult = U
return j