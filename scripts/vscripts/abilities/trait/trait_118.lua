--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_118"
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
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 26,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 26,
		["44"] = 31,
		["45"] = 31,
		["46"] = 31,
		["47"] = 31,
		["48"] = 31,
		["50"] = 20,
		["51"] = 34,
		["52"] = 35,
		["53"] = 36,
		["54"] = 36,
		["55"] = 35,
		["56"] = 34,
		["57"] = 39,
		["58"] = 40,
		["59"] = 41,
		["60"] = 41,
		["61"] = 41,
		["62"] = 41,
		["63"] = 41,
		["64"] = 41,
		["65"] = 39,
		["66"] = 19,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 19,
		["76"] = 19,
		["77"] = 46,
		["78"] = 53,
		["79"] = 46,
		["80"] = 53,
		["81"] = 56,
		["82"] = 57,
		["83"] = 58,
		["84"] = 56,
		["85"] = 60,
		["86"] = 61,
		["87"] = 62,
		["88"] = 62,
		["89"] = 63,
		["91"] = 60,
		["92"] = 66,
		["93"] = 67,
		["94"] = 68,
		["95"] = 68,
		["96"] = 68,
		["97"] = 67,
		["98"] = 67,
		["99"] = 67,
		["100"] = 66,
		["101"] = 72,
		["102"] = 73,
		["103"] = 74,
		["104"] = 74,
		["105"] = 75,
		["107"] = 72,
		["108"] = 78,
		["109"] = 79,
		["110"] = 78,
		["111"] = 83,
		["112"] = 84,
		["113"] = 83,
		["114"] = 53,
		["115"] = 46,
		["116"] = 46,
		["117"] = 46,
		["118"] = 46,
		["119"] = 46,
		["120"] = 46,
		["121"] = 46,
		["122"] = 53,
		["124"] = 53,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_118 = c()
local n = g.trait_118
n.name = "trait_118"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_118"
end
n = e({ j(nil) }, n)
g.trait_118 = n
g.modifier_trait_118 = c()
local o = g.modifier_trait_118
o.name = "modifier_trait_118"
d(o, l)
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = "164"
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
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_118_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_118_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_118 = o
g.modifier_trait_118_buff = c()
local t = g.modifier_trait_118_buff
t.name = "modifier_trait_118_buff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.level = self:GetAbilitySpecialValueFor("level")
	self.value = self:GetAbilitySpecialValueFor("value")
end
function t.prototype.OnCreated(self, p)
	if IsServer() then
		local u = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		local v = u and u:getLevel() or 1
		self:SetStackCount(math.floor((v - 1) / self.level))
	end
end
function t.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function t.prototype.OnHeroLevelUp(self, p)
	if IsServer() then
		local w = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		local v = w and w:getLevel() or 1
		self:SetStackCount(math.floor((v - 1) / self.level))
	end
end
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_STACK_BONUS }
end
function t.prototype.EOM_GetModifierChaosStackBonusPercent(self, p)
	return self:GetStackCount() * self.value
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_118_buff = t
return g