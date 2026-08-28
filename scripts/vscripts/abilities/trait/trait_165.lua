--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_165"
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
		["14"] = 6,
		["15"] = 7,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["25"] = 7,
		["26"] = 13,
		["27"] = 20,
		["28"] = 13,
		["29"] = 20,
		["30"] = 21,
		["31"] = 22,
		["34"] = 23,
		["35"] = 24,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 27,
		["45"] = 27,
		["46"] = 32,
		["47"] = 32,
		["48"] = 32,
		["49"] = 32,
		["50"] = 32,
		["51"] = 21,
		["52"] = 35,
		["53"] = 36,
		["54"] = 37,
		["55"] = 37,
		["56"] = 36,
		["57"] = 35,
		["58"] = 40,
		["59"] = 41,
		["60"] = 42,
		["61"] = 42,
		["62"] = 42,
		["63"] = 42,
		["64"] = 42,
		["65"] = 42,
		["66"] = 40,
		["67"] = 20,
		["68"] = 13,
		["69"] = 13,
		["70"] = 13,
		["71"] = 13,
		["72"] = 13,
		["73"] = 13,
		["74"] = 13,
		["75"] = 20,
		["77"] = 20,
		["78"] = 46,
		["79"] = 53,
		["80"] = 46,
		["81"] = 53,
		["82"] = 54,
		["83"] = 55,
		["84"] = 54,
		["85"] = 58,
		["86"] = 59,
		["87"] = 60,
		["88"] = 58,
		["89"] = 53,
		["90"] = 46,
		["91"] = 46,
		["92"] = 46,
		["93"] = 46,
		["94"] = 46,
		["95"] = 46,
		["96"] = 46,
		["97"] = 53,
		["99"] = 53,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_165 = c()
local n = g.trait_165
n.name = "trait_165"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_165"
end
n = e({ j(nil) }, n)
g.trait_165 = n
g.modifier_trait_165 = c()
local o = g.modifier_trait_165
o.name = "modifier_trait_165"
d(o, l)
function o.prototype.OnCreated(self, p)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local r = "56"
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
	p.hero:RemoveModifierByName("modifier_trait_165_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_165_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_165 = o
g.modifier_trait_165_buff = c()
local t = g.modifier_trait_165_buff
t.name = "modifier_trait_165_buff"
d(t, l)
function t.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function t.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	local u = self:GetParent():FindModifierByName("modifier_sect_health")
	return IsValid(u) and u:GetIndomitableSoulDamageReduction() or 0
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_165_buff = t
return g