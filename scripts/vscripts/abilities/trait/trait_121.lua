--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_121"
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
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["22"] = 8,
		["23"] = 13,
		["24"] = 14,
		["25"] = 13,
		["26"] = 16,
		["27"] = 17,
		["28"] = 18,
		["29"] = 19,
		["30"] = 19,
		["31"] = 19,
		["32"] = 19,
		["33"] = 19,
		["34"] = 19,
		["35"] = 19,
		["37"] = 16,
		["38"] = 22,
		["39"] = 23,
		["40"] = 22,
		["41"] = 6,
		["42"] = 5,
		["43"] = 6,
		["45"] = 6,
		["46"] = 27,
		["47"] = 34,
		["48"] = 27,
		["49"] = 34,
		["50"] = 35,
		["51"] = 36,
		["52"] = 37,
		["53"] = 37,
		["54"] = 37,
		["55"] = 36,
		["56"] = 36,
		["57"] = 36,
		["58"] = 35,
		["59"] = 41,
		["60"] = 42,
		["61"] = 43,
		["62"] = 43,
		["63"] = 43,
		["64"] = 43,
		["65"] = 43,
		["66"] = 43,
		["67"] = 41,
		["68"] = 45,
		["69"] = 46,
		["72"] = 47,
		["73"] = 48,
		["74"] = 49,
		["76"] = 45,
		["77"] = 34,
		["78"] = 27,
		["79"] = 27,
		["80"] = 27,
		["81"] = 27,
		["82"] = 27,
		["83"] = 27,
		["84"] = 27,
		["85"] = 34,
		["87"] = 34,
		["88"] = 55,
		["89"] = 62,
		["90"] = 55,
		["91"] = 62,
		["92"] = 64,
		["93"] = 65,
		["94"] = 64,
		["95"] = 67,
		["96"] = 68,
		["97"] = 69,
		["99"] = 67,
		["100"] = 72,
		["101"] = 73,
		["102"] = 72,
		["103"] = 77,
		["104"] = 78,
		["105"] = 79,
		["107"] = 81,
		["109"] = 77,
		["110"] = 84,
		["111"] = 85,
		["112"] = 84,
		["113"] = 89,
		["114"] = 90,
		["115"] = 89,
		["116"] = 62,
		["117"] = 55,
		["118"] = 55,
		["119"] = 55,
		["120"] = 55,
		["121"] = 55,
		["122"] = 55,
		["123"] = 55,
		["124"] = 62,
		["126"] = 62,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_121 = c()
local n = g.trait_121
n.name = "trait_121"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self.stack = 0
	end
end
function n.prototype.loadStack(self)
	return self.stack
end
function n.prototype.saveStack(self, o)
	if IsServer() then
		self.stack = self.stack + o
		PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID()):modifyArtifactExtraData(
			self:entindex(),
			"KeyWord_Health",
			self.stack * self:GetSpecialValueFor("health"),
			true,
			true
		)
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_121"
end
n = e({ j(nil) }, n)
g.trait_121 = n
g.modifier_trait_121 = c()
local p = g.modifier_trait_121
p.name = "modifier_trait_121"
d(p, l)
function p.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function p.prototype.OnTraitInit(self, q)
	q.hero:RemoveModifierByName("modifier_trait_121_buff")
	q.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_121_buff", {})
end
function p.prototype.OnBattleEnd(self, q)
	if q.isNeutral then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if q.illusionPlayerID ~= r and q.losePlayerID == r then
		self:GetAbility():saveStack(1)
	end
end
p = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
g.modifier_trait_121 = p
g.modifier_trait_121_buff = c()
local s = g.modifier_trait_121_buff
s.name = "modifier_trait_121_buff"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.health = self:GetAbilitySpecialValueFor("health")
end
function s.prototype.OnCreated(self, q)
	if IsServer() then
		self:SetStackCount(self:GetAbility():loadStack())
	end
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function s.prototype.OnBattleStartBefore(self, q)
	if IsValid(self:GetAbility()) then
		self:SetStackCount(self:GetAbility():loadStack())
	else
		self:Destroy()
	end
end
function s.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BASE }
end
function s.prototype.EOM_GetModifierHealthBase(self, q)
	return self:GetStackCount() * self.health
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_trait_121_buff = s
return g