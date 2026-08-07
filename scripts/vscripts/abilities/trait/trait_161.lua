--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_161"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 21,
		["34"] = 20,
		["35"] = 19,
		["36"] = 24,
		["37"] = 25,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 26,
		["44"] = 24,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 41,
		["64"] = 45,
		["65"] = 46,
		["66"] = 45,
		["67"] = 52,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 53,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["76"] = 53,
		["77"] = 54,
		["78"] = 54,
		["79"] = 54,
		["80"] = 54,
		["81"] = 54,
		["82"] = 54,
		["83"] = 52,
		["84"] = 56,
		["85"] = 57,
		["88"] = 60,
		["89"] = 61,
		["90"] = 61,
		["91"] = 61,
		["92"] = 61,
		["93"] = 61,
		["94"] = 61,
		["96"] = 61,
		["97"] = 62,
		["98"] = 62,
		["99"] = 62,
		["100"] = 62,
		["101"] = 62,
		["103"] = 56,
		["104"] = 69,
		["105"] = 70,
		["106"] = 69,
		["107"] = 74,
		["108"] = 75,
		["109"] = 74,
		["110"] = 38,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 31,
		["116"] = 31,
		["117"] = 31,
		["118"] = 38,
		["120"] = 38,
		["121"] = 78,
		["122"] = 85,
		["123"] = 78,
		["124"] = 85,
		["125"] = 87,
		["126"] = 88,
		["127"] = 87,
		["128"] = 90,
		["129"] = 91,
		["130"] = 90,
		["131"] = 95,
		["132"] = 96,
		["133"] = 95,
		["134"] = 85,
		["135"] = 78,
		["136"] = 78,
		["137"] = 78,
		["138"] = 78,
		["139"] = 78,
		["140"] = 78,
		["141"] = 78,
		["142"] = 85,
		["144"] = 85,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_161 = c()
local n = g.trait_161
n.name = "trait_161"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_161"
end
n = e({ j(nil) }, n)
g.trait_161 = n
g.modifier_trait_161 = c()
local o = g.modifier_trait_161
o.name = "modifier_trait_161"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_161_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_161_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_161 = o
g.modifier_trait_161_buff = c()
local q = g.modifier_trait_161_buff
q.name = "modifier_trait_161_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.round_attack = self:GetAbilitySpecialValueFor("round_attack")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self.parent, self.parent },
	}
end
function q.prototype.OnBattleStart(self, p)
	local r = self.SetStackCount
	local s = PlayerData:loadData(self:GetCaster():GetPlayerOwnerID(), "trait_161")
	if s == nil then
		s = 0
	end
	r(self, s)
	self.parent:GetEnemy():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_161_debuff", {})
end
function q.prototype.OnBattleEnd(self, p)
	if p.isNeutral then
		return
	end
	if p.winPlayerID == self.parent:GetPlayerOwnerID() then
		local t = PlayerData:loadData(self:GetCaster():GetPlayerOwnerID(), "trait_161")
		if t == nil then
			t = 0
		end
		local u = t
		PlayerData:saveData(self:GetCaster():GetPlayerOwnerID(), "trait_161", u + 1)
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS }
end
function q.prototype.EOM_GetModifierAttackDamageBonus(self, p)
	return self.attack + self:GetStackCount() * self.round_attack
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_161_buff = q
g.modifier_trait_161_debuff = c()
local v = g.modifier_trait_161_debuff
v.name = "modifier_trait_161_debuff"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.physical_reduce = self:GetAbilitySpecialValueFor("physical_reduce")
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE }
end
function v.prototype.EOM_GetModifierIncomingPhysicalDamagePercentage(self, p)
	return self.physical_reduce
end
v = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
g.modifier_trait_161_debuff = v
return g