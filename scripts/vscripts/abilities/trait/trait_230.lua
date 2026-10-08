--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_230"
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
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 31,
		["57"] = 39,
		["58"] = 31,
		["59"] = 39,
		["60"] = 41,
		["61"] = 42,
		["62"] = 41,
		["63"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 46,
		["67"] = 46,
		["68"] = 45,
		["69"] = 45,
		["70"] = 45,
		["71"] = 44,
		["72"] = 50,
		["73"] = 51,
		["76"] = 52,
		["77"] = 53,
		["78"] = 54,
		["79"] = 54,
		["81"] = 50,
		["82"] = 56,
		["83"] = 57,
		["86"] = 58,
		["87"] = 59,
		["88"] = 60,
		["89"] = 61,
		["90"] = 62,
		["91"] = 62,
		["94"] = 64,
		["95"] = 64,
		["96"] = 64,
		["97"] = 64,
		["98"] = 64,
		["99"] = 64,
		["101"] = 56,
		["102"] = 39,
		["103"] = 31,
		["104"] = 31,
		["105"] = 31,
		["106"] = 31,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 39,
		["113"] = 39,
		["114"] = 69,
		["115"] = 76,
		["116"] = 69,
		["117"] = 76,
		["118"] = 78,
		["119"] = 79,
		["120"] = 78,
		["121"] = 81,
		["122"] = 82,
		["123"] = 82,
		["125"] = 81,
		["126"] = 84,
		["127"] = 85,
		["128"] = 84,
		["129"] = 76,
		["130"] = 69,
		["131"] = 69,
		["132"] = 69,
		["133"] = 69,
		["134"] = 69,
		["135"] = 69,
		["136"] = 69,
		["137"] = 76,
		["139"] = 76,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_230 = c()
local n = g.trait_230
n.name = "trait_230"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_230"
end
n = e({ j(nil) }, n)
g.trait_230 = n
g.modifier_trait_230 = c()
local o = g.modifier_trait_230
o.name = "modifier_trait_230"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_230_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_230_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_230 = o
g.modifier_trait_230_buff = c()
local q = g.modifier_trait_230_buff
q.name = "modifier_trait_230_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetEnemy()
	if IsInjurable(s) then
		s:RemoveModifierByName("modifier_trait_230_stack")
	end
end
function q.prototype.OnCustomAttackLanded(self, t)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local u = t.target
	local v = u:FindModifierByName("modifier_trait_230_stack")
	if IsValid(v) then
		if v:GetStackCount() < self.max_stack then
			v:IncrementStackCount()
		end
	else
		u:AddNewModifier(r, self:GetAbility(), "modifier_trait_230_stack", {})
	end
end
q = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	q
)
g.modifier_trait_230_buff = q
g.modifier_trait_230_stack = c()
local w = g.modifier_trait_230_stack
w.name = "modifier_trait_230_stack"
d(w, l)
function w.prototype.GetAbilitySpecialValue(self)
	self.per_stack = self:GetAbilitySpecialValueFor("per_stack")
end
function w.prototype.OnCreated(self, p)
	if self:GetStackCount() <= 0 then
		self:SetStackCount(1)
	end
end
function w.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE] = self:GetStackCount()
			* self.per_stack,
	}
end
w = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
g.modifier_trait_230_stack = w
return g