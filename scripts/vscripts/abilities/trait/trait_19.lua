--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_19"
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
		["34"] = 23,
		["35"] = 24,
		["36"] = 25,
		["37"] = 27,
		["38"] = 28,
		["39"] = 28,
		["40"] = 28,
		["41"] = 28,
		["42"] = 28,
		["43"] = 28,
		["44"] = 28,
		["45"] = 28,
		["46"] = 33,
		["47"] = 33,
		["48"] = 33,
		["49"] = 33,
		["50"] = 33,
		["51"] = 20,
		["52"] = 36,
		["53"] = 37,
		["54"] = 38,
		["55"] = 38,
		["56"] = 37,
		["57"] = 36,
		["58"] = 41,
		["59"] = 42,
		["60"] = 43,
		["61"] = 43,
		["62"] = 43,
		["63"] = 43,
		["64"] = 43,
		["65"] = 43,
		["66"] = 41,
		["67"] = 19,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 19,
		["77"] = 19,
		["78"] = 47,
		["79"] = 54,
		["80"] = 47,
		["81"] = 54,
		["82"] = 57,
		["83"] = 58,
		["84"] = 59,
		["85"] = 57,
		["86"] = 66,
		["87"] = 67,
		["88"] = 67,
		["89"] = 67,
		["90"] = 67,
		["91"] = 67,
		["92"] = 66,
		["93"] = 73,
		["94"] = 74,
		["95"] = 75,
		["96"] = 73,
		["97"] = 77,
		["98"] = 78,
		["99"] = 77,
		["100"] = 84,
		["101"] = 85,
		["102"] = 84,
		["103"] = 89,
		["104"] = 90,
		["105"] = 89,
		["106"] = 92,
		["107"] = 93,
		["108"] = 93,
		["109"] = 93,
		["110"] = 93,
		["111"] = 93,
		["112"] = 93,
		["113"] = 92,
		["114"] = 95,
		["115"] = 96,
		["116"] = 97,
		["117"] = 98,
		["118"] = 99,
		["119"] = 99,
		["120"] = 99,
		["121"] = 99,
		["122"] = 99,
		["123"] = 99,
		["124"] = 99,
		["126"] = 95,
		["127"] = 54,
		["128"] = 47,
		["129"] = 47,
		["130"] = 47,
		["131"] = 47,
		["132"] = 47,
		["133"] = 47,
		["134"] = 47,
		["135"] = 54,
		["137"] = 54,
		["138"] = 103,
		["139"] = 110,
		["140"] = 103,
		["141"] = 110,
		["142"] = 111,
		["143"] = 112,
		["144"] = 111,
		["145"] = 110,
		["146"] = 103,
		["147"] = 103,
		["148"] = 103,
		["149"] = 103,
		["150"] = 103,
		["151"] = 103,
		["152"] = 103,
		["153"] = 110,
		["155"] = 110,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_19 = c()
local n = g.trait_19
n.name = "trait_19"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_19"
end
n = e({ j(nil) }, n)
g.trait_19 = n
g.modifier_trait_19 = c()
local o = g.modifier_trait_19
o.name = "modifier_trait_19"
d(o, l)
function o.prototype.OnCreated(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local r = "116"
	PlayerData:getHero(q):learnAbility(r, true)
	local s = KeyValues.AbilityUpgradesKvs[r]
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_ability_" .. tostring(s.rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
		}
	)
	PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), r, true)
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_19_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_19_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_19 = o
g.modifier_trait_19_buff = c()
local t = g.modifier_trait_19_buff
t.name = "modifier_trait_19_buff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
	self.health = self:GetAbilitySpecialValueFor("health")
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_SPAWN] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_WISP_HEAL] = { self:GetParent() },
	}
end
function t.prototype.OnBattleStartBefore(self, p)
	self:SetStackCount(GetWispHealth(self:GetParent()))
	self:GetParent():CalculateGenericBonuses()
end
function t.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_SHARE_PERCENTAGE] = -1000,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_INTERVAL] = self.reduce,
	}
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function t.prototype.EOM_GetModifierHealthBonus(self)
	return self:GetStackCount()
end
function t.prototype.OnWispSpawn(self, p)
	p.wisp:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_19_wisp", nil)
end
function t.prototype.OnWispHeal(self, p)
	local u = self:GetParent()
	local v = u:GetEnemy()
	if IsInjurable(u, v) and p.healAmount > 0 then
		DealDamageToWisp(u, v, self:GetAbility(), p.healAmount, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE)
	end
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_19_buff = t
g.modifier_trait_19_wisp = c()
local w = g.modifier_trait_19_wisp
w.name = "modifier_trait_19_wisp"
d(w, l)
function w.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
w = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
g.modifier_trait_19_wisp = w
return g