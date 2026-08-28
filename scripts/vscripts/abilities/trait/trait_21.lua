--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_21"
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
		["32"] = 23,
		["33"] = 23,
		["34"] = 21,
		["35"] = 20,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["42"] = 32,
		["43"] = 32,
		["44"] = 32,
		["45"] = 32,
		["46"] = 32,
		["47"] = 32,
		["48"] = 32,
		["49"] = 32,
		["50"] = 37,
		["51"] = 37,
		["52"] = 37,
		["53"] = 37,
		["54"] = 37,
		["56"] = 26,
		["57"] = 40,
		["58"] = 41,
		["59"] = 42,
		["60"] = 42,
		["61"] = 42,
		["62"] = 42,
		["63"] = 42,
		["64"] = 42,
		["65"] = 40,
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
		["77"] = 52,
		["78"] = 59,
		["79"] = 52,
		["80"] = 59,
		["81"] = 62,
		["82"] = 63,
		["83"] = 62,
		["84"] = 66,
		["85"] = 67,
		["86"] = 66,
		["87"] = 72,
		["88"] = 73,
		["89"] = 72,
		["90"] = 59,
		["91"] = 52,
		["92"] = 52,
		["93"] = 52,
		["94"] = 52,
		["95"] = 52,
		["96"] = 52,
		["97"] = 52,
		["98"] = 59,
		["100"] = 59,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_21 = c()
local n = g.trait_21
n.name = "trait_21"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_21"
end
n = e({ j(nil) }, n)
g.trait_21 = n
g.modifier_trait_21 = c()
local o = g.modifier_trait_21
o.name = "modifier_trait_21"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = "156"
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
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_21_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_21_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_21 = o
g.modifier_trait_21_buff = c()
local t = g.modifier_trait_21_buff
t.name = "modifier_trait_21_buff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.fury = self:GetAbilitySpecialValueFor("fury")
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_FURY_STACK_BONUS_PERCENTAGE] = -self.fury }
end
function t.prototype.ECheckState(self)
	return { [EOMModifierStates.MODIFIER_STATE_IGNORE_ICE_EFFECT] = true }
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_21_buff = t
return g