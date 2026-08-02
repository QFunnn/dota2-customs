--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_8"
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
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 47,
		["65"] = 43,
		["66"] = 49,
		["67"] = 50,
		["68"] = 51,
		["69"] = 51,
		["70"] = 51,
		["71"] = 52,
		["72"] = 53,
		["73"] = 54,
		["74"] = 55,
		["77"] = 51,
		["78"] = 51,
		["80"] = 49,
		["81"] = 61,
		["82"] = 62,
		["83"] = 61,
		["84"] = 69,
		["85"] = 70,
		["86"] = 69,
		["87"] = 74,
		["88"] = 75,
		["89"] = 76,
		["90"] = 77,
		["92"] = 74,
		["93"] = 80,
		["94"] = 81,
		["95"] = 80,
		["96"] = 83,
		["97"] = 84,
		["98"] = 83,
		["99"] = 86,
		["100"] = 87,
		["101"] = 86,
		["102"] = 38,
		["103"] = 31,
		["104"] = 31,
		["105"] = 31,
		["106"] = 31,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 38,
		["112"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_8 = c()
local n = g.trait_8
n.name = "trait_8"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_8"
end
n = e({ j(nil) }, n)
g.trait_8 = n
g.modifier_trait_8 = c()
local o = g.modifier_trait_8
o.name = "modifier_trait_8"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_8_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_8_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_8 = o
g.modifier_trait_8_buff = c()
local q = g.modifier_trait_8_buff
q.name = "modifier_trait_8_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.base_attack = self:GetAbilitySpecialValueFor("base_attack")
	self.damage_reduce = self:GetAbilitySpecialValueFor("damage_reduce")
end
function q.prototype.OnCreated(self, p)
	if IsServer() then
		self:hook(EOMModifierEvents.MODIFIER_EVENT_ON_CRITICAL_CALCULATED, function(r, p, s, t)
			if s == self:GetParent() then
				if p.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
					p.damage = p.damage * (100 - self.damage_reduce) * 0.01
					p.original_damage = p.original_damage * (100 - self.damage_reduce) * 0.01
				end
			end
		end)
	end
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_TOTAL_PERCENTAGE,
	}
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function q.prototype.OnBattleStart(self, p)
	local u = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	if u then
		self:SetStackCount(u:getLevel())
	end
end
function q.prototype.EOM_GetModifierAttackSpeedBonus(self)
	return self:GetStackCount() * self.attackspeed
end
function q.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.base_attack
end
function q.prototype.EOM_GetModifierAttackDamageTotalPercentage(self, p)
	return self:GetStackCount() * self.attack
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_8_buff = q
return g