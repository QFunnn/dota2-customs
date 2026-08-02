--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_25"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 23,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["41"] = 34,
		["43"] = 36,
		["46"] = 28,
		["47"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 42,
		["51"] = 42,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 40,
		["56"] = 47,
		["57"] = 48,
		["58"] = 47,
		["59"] = 52,
		["60"] = 53,
		["61"] = 52,
		["62"] = 55,
		["63"] = 56,
		["64"] = 57,
		["65"] = 58,
		["68"] = 59,
		["69"] = 60,
		["70"] = 55,
		["71"] = 62,
		["72"] = 63,
		["73"] = 64,
		["74"] = 64,
		["75"] = 64,
		["76"] = 64,
		["77"] = 64,
		["78"] = 64,
		["79"] = 62,
		["80"] = 66,
		["81"] = 67,
		["82"] = 68,
		["83"] = 69,
		["84"] = 69,
		["85"] = 69,
		["86"] = 69,
		["88"] = 66,
		["89"] = 19,
		["90"] = 12,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 19,
		["99"] = 19,
		["100"] = 74,
		["101"] = 81,
		["102"] = 74,
		["103"] = 81,
		["104"] = 83,
		["105"] = 84,
		["106"] = 83,
		["107"] = 86,
		["108"] = 87,
		["109"] = 86,
		["110"] = 91,
		["111"] = 92,
		["112"] = 93,
		["113"] = 94,
		["114"] = 91,
		["115"] = 96,
		["116"] = 97,
		["117"] = 96,
		["118"] = 101,
		["119"] = 102,
		["120"] = 101,
		["121"] = 81,
		["122"] = 74,
		["123"] = 74,
		["124"] = 74,
		["125"] = 74,
		["126"] = 74,
		["127"] = 74,
		["128"] = 74,
		["129"] = 81,
		["131"] = 81,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_25 = c()
local n = g.trait_25
n.name = "trait_25"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_25"
end
n = e({ j(nil) }, n)
g.trait_25 = n
g.modifier_trait_25 = c()
local o = g.modifier_trait_25
o.name = "modifier_trait_25"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.add = self:GetAbilitySpecialValueFor("add")
	self.interest = self:GetAbilitySpecialValueFor("interest")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent()
		local r = q:GetPlayerOwnerID()
		local s = PlayerData:getHero(r)
		if s then
			self:SetStackCount(s:getLevel())
		else
			self:SetStackCount(1)
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 },
	}
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function o.prototype.EOM_GetModifierExtraInterest_Limit(self)
	return self.interest * self:GetStackCount()
end
function o.prototype.OnHeroLevelUp(self, p)
	local q = self:GetParent()
	local r = q:GetPlayerOwnerID()
	if p.player_id ~= r then
		return
	end
	local s = PlayerData:getHero(r)
	self:SetStackCount(s:getLevel())
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_25_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_25_buff", {})
end
function o.prototype.OnAbilityBuy(self, p)
	local q = self:GetParent()
	if IsValid(q) then
		PlayerData:modifyGold(q:GetPlayerOwnerID(), -p.cost * self.add * 0.01)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_25 = o
g.modifier_trait_25_buff = c()
local t = g.modifier_trait_25_buff
t.name = "modifier_trait_25_buff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function t.prototype.OnBattleStartBefore(self, p)
	local q = self:GetParent()
	local r = q:GetPlayerOwnerID()
	self:SetStackCount(math.floor(PlayerData:getGold(r) / self.gold))
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROC_DAMAGE_BONUS }
end
function t.prototype.EOM_GetModifierProcDamageBonus(self)
	return self:GetStackCount()
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_25_buff = t
return g