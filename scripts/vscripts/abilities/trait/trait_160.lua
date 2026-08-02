--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_160"
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
		["30"] = 20,
		["31"] = 21,
		["32"] = 20,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 26,
		["37"] = 25,
		["38"] = 24,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["45"] = 31,
		["46"] = 31,
		["47"] = 29,
		["48"] = 34,
		["49"] = 35,
		["50"] = 34,
		["51"] = 40,
		["52"] = 41,
		["53"] = 40,
		["54"] = 18,
		["55"] = 11,
		["56"] = 11,
		["57"] = 11,
		["58"] = 11,
		["59"] = 11,
		["60"] = 11,
		["61"] = 11,
		["62"] = 18,
		["64"] = 18,
		["65"] = 44,
		["66"] = 51,
		["67"] = 44,
		["68"] = 51,
		["69"] = 55,
		["70"] = 56,
		["71"] = 57,
		["72"] = 58,
		["73"] = 55,
		["74"] = 60,
		["75"] = 61,
		["76"] = 62,
		["77"] = 63,
		["78"] = 63,
		["79"] = 63,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["85"] = 63,
		["86"] = 63,
		["88"] = 60,
		["89"] = 72,
		["90"] = 73,
		["91"] = 72,
		["92"] = 77,
		["93"] = 78,
		["94"] = 77,
		["95"] = 81,
		["96"] = 82,
		["97"] = 83,
		["98"] = 83,
		["99"] = 82,
		["100"] = 81,
		["101"] = 86,
		["102"] = 87,
		["103"] = 88,
		["104"] = 88,
		["105"] = 88,
		["106"] = 88,
		["107"] = 88,
		["108"] = 88,
		["109"] = 88,
		["111"] = 86,
		["112"] = 51,
		["113"] = 44,
		["114"] = 44,
		["115"] = 44,
		["116"] = 44,
		["117"] = 44,
		["118"] = 44,
		["119"] = 44,
		["120"] = 51,
		["122"] = 51,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_160 = c()
local n = g.trait_160
n.name = "trait_160"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_160"
end
n = e({ j(nil) }, n)
g.trait_160 = n
g.modifier_trait_160 = c()
local o = g.modifier_trait_160
o.name = "modifier_trait_160"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.extra_gold = self:GetAbilitySpecialValueFor("extra_gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_160_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_160_buff", {})
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function o.prototype.EOM_GetModifierExtraWages(self, p)
	return self.extra_gold
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_160 = o
g.modifier_trait_160_buff = c()
local q = g.modifier_trait_160_buff
q.name = "modifier_trait_160_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attack_speed = self:GetAbilitySpecialValueFor("attack_speed")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function q.prototype.OnCreated(self, p)
	if IsServer() then
		local r = self:GetParent()
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_DAMAGE_START, function(s, t, u, v)
			if u == r and t.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				if self:PRD(self.chance, "trait_160") then
					t.trait_160 = 1
				end
			end
		end)
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS }
end
function q.prototype.EOM_GetModifierAttackSpeedBonus(self, p)
	return self.attack_speed
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 } }
end
function q.prototype.OnCustomAttackLanded(self, t)
	if (t and t.trait_160) == 1 then
		t.attacker:DealDamage(
			t.target,
			self:GetAbility(),
			self.damage,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL,
			DamageFlags.DAMAGE_FLAG_NO_EVASION
		)
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_160_buff = q
return g