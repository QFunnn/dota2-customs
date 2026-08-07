--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_72"
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
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["45"] = 28,
		["46"] = 33,
		["47"] = 34,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["53"] = 35,
		["54"] = 35,
		["55"] = 36,
		["56"] = 33,
		["57"] = 38,
		["58"] = 39,
		["59"] = 39,
		["60"] = 41,
		["61"] = 41,
		["62"] = 41,
		["63"] = 39,
		["64"] = 39,
		["65"] = 38,
		["66"] = 44,
		["67"] = 45,
		["68"] = 46,
		["69"] = 46,
		["70"] = 46,
		["71"] = 46,
		["72"] = 46,
		["73"] = 46,
		["74"] = 44,
		["75"] = 48,
		["76"] = 49,
		["79"] = 52,
		["80"] = 53,
		["83"] = 56,
		["86"] = 59,
		["87"] = 60,
		["89"] = 62,
		["91"] = 64,
		["92"] = 48,
		["93"] = 19,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 12,
		["98"] = 12,
		["99"] = 12,
		["100"] = 12,
		["101"] = 19,
		["103"] = 19,
		["104"] = 68,
		["105"] = 75,
		["106"] = 68,
		["107"] = 75,
		["108"] = 77,
		["109"] = 78,
		["110"] = 77,
		["111"] = 80,
		["112"] = 81,
		["113"] = 82,
		["115"] = 80,
		["116"] = 85,
		["117"] = 86,
		["118"] = 87,
		["119"] = 87,
		["120"] = 87,
		["122"] = 87,
		["123"] = 85,
		["124"] = 89,
		["125"] = 90,
		["126"] = 89,
		["127"] = 94,
		["128"] = 95,
		["129"] = 94,
		["130"] = 97,
		["131"] = 98,
		["132"] = 97,
		["133"] = 102,
		["134"] = 103,
		["135"] = 102,
		["136"] = 75,
		["137"] = 68,
		["138"] = 68,
		["139"] = 68,
		["140"] = 68,
		["141"] = 68,
		["142"] = 68,
		["143"] = 68,
		["144"] = 75,
		["146"] = 75,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_72 = c()
local n = g.trait_72
n.name = "trait_72"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_72"
end
n = e({ j(nil) }, n)
g.trait_72 = n
g.modifier_trait_72 = c()
local o = g.modifier_trait_72
o.name = "modifier_trait_72"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.regen1 = self:GetAbilitySpecialValueFor("regen1")
	self.regen2 = self:GetAbilitySpecialValueFor("regen2")
	self.regen = self:GetAbilitySpecialValueFor("regen")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "Attribute_4", self.regen, true, true)
	end
end
function o.prototype.SaveStack(self, q)
	local r = self:GetParent():GetPlayerOwnerID()
	PlayerData:getplayerData(r)
		:modifyArtifactExtraData(self:GetAbility():entindex(), "Attribute_4", self.regen + q, true, true)
	PlayerData:saveData(r, "trait_72", q)
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
	}
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_72_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_72_buff", {})
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral ~= nil then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if p.winPlayerID ~= r and p.losePlayerID ~= r then
		return
	end
	if p.illusionPlayerID == r then
		return
	end
	if p.winPlayerID == r then
		self:IncrementStackCount(self.regen1)
	else
		self:IncrementStackCount(self.regen2)
	end
	self:SaveStack(self:GetStackCount())
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_72 = o
g.modifier_trait_72_buff = c()
local s = g.modifier_trait_72_buff
s.name = "modifier_trait_72_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.regen = self:GetAbilitySpecialValueFor("regen")
end
function s.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self:LoadStack())
	end
end
function s.prototype.LoadStack(self)
	local r = self:GetParent():GetPlayerOwnerID()
	local t = PlayerData:loadData(r, "trait_72")
	if t == nil then
		t = 0
	end
	return t
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function s.prototype.OnBattleStartBefore(self, p)
	self:SetStackCount(self:LoadStack())
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_BONUS }
end
function s.prototype.EOM_GetModifierHeal_Bonus(self, p)
	return self.regen + self:GetStackCount()
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_trait_72_buff = s
return g