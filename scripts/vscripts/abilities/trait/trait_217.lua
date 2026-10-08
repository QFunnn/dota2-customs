--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_217"
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
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 44,
		["66"] = 50,
		["67"] = 51,
		["68"] = 52,
		["69"] = 52,
		["70"] = 52,
		["71"] = 51,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["75"] = 51,
		["76"] = 51,
		["77"] = 50,
		["78"] = 56,
		["79"] = 57,
		["82"] = 58,
		["83"] = 59,
		["84"] = 60,
		["87"] = 61,
		["88"] = 62,
		["89"] = 63,
		["90"] = 63,
		["93"] = 65,
		["94"] = 65,
		["95"] = 65,
		["96"] = 65,
		["97"] = 65,
		["98"] = 65,
		["100"] = 56,
		["101"] = 68,
		["102"] = 69,
		["103"] = 68,
		["104"] = 71,
		["105"] = 72,
		["108"] = 73,
		["109"] = 74,
		["110"] = 75,
		["111"] = 76,
		["112"] = 77,
		["113"] = 77,
		["114"] = 77,
		["115"] = 77,
		["116"] = 77,
		["117"] = 77,
		["118"] = 78,
		["119"] = 79,
		["121"] = 81,
		["123"] = 71,
		["124"] = 39,
		["125"] = 31,
		["126"] = 31,
		["127"] = 31,
		["128"] = 31,
		["129"] = 31,
		["130"] = 31,
		["131"] = 31,
		["132"] = 31,
		["133"] = 39,
		["135"] = 39,
		["136"] = 86,
		["137"] = 93,
		["138"] = 86,
		["139"] = 93,
		["140"] = 95,
		["141"] = 96,
		["142"] = 95,
		["143"] = 98,
		["144"] = 99,
		["145"] = 99,
		["147"] = 98,
		["148"] = 101,
		["149"] = 102,
		["150"] = 101,
		["151"] = 93,
		["152"] = 86,
		["153"] = 86,
		["154"] = 86,
		["155"] = 86,
		["156"] = 86,
		["157"] = 86,
		["158"] = 86,
		["159"] = 93,
		["161"] = 93,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_217 = c()
local n = g.trait_217
n.name = "trait_217"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_217"
end
n = e({ j(nil) }, n)
g.trait_217 = n
g.modifier_trait_217 = c()
local o = g.modifier_trait_217
o.name = "modifier_trait_217"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_217_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_217_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_217 = o
g.modifier_trait_217_buff = c()
local q = g.modifier_trait_217_buff
q.name = "modifier_trait_217_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
	self.per_stack = self:GetAbilitySpecialValueFor("per_stack")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.heal = self:GetAbilitySpecialValueFor("heal")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function q.prototype.AddStack(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetEnemy()
	if not IsInjurable(s) then
		return
	end
	local t = s:FindModifierByName("modifier_trait_217_stack")
	if IsValid(t) then
		if t:GetStackCount() < self.max_stack then
			t:IncrementStackCount()
		end
	else
		s:AddNewModifier(r, self:GetAbility(), "modifier_trait_217_stack", {})
	end
end
function q.prototype.OnCustomAbilityFullyCast(self, u)
	self:AddStack()
end
function q.prototype.OnCustomAttackLanded(self, u)
	if not IsServer() then
		return
	end
	local v = u.target
	local t = v:FindModifierByName("modifier_trait_217_stack")
	if IsValid(t) and t:GetStackCount() >= self.max_stack then
		local r = self:GetParent()
		r:DealDamage(v, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		Heal(r, self.heal, "trait_217", "Ability")
		t:Destroy()
	else
		self:AddStack()
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
g.modifier_trait_217_buff = q
g.modifier_trait_217_stack = c()
local w = g.modifier_trait_217_stack
w.name = "modifier_trait_217_stack"
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
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_MAGICAL_DAMAGE_PERCENTAGE] = self:GetStackCount()
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
g.modifier_trait_217_stack = w
return g