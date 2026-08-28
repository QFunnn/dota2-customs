--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_100"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 27,
		["37"] = 28,
		["39"] = 29,
		["40"] = 29,
		["41"] = 30,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["45"] = 31,
		["46"] = 31,
		["47"] = 31,
		["48"] = 31,
		["49"] = 31,
		["50"] = 29,
		["54"] = 24,
		["55"] = 39,
		["56"] = 40,
		["57"] = 41,
		["58"] = 41,
		["59"] = 40,
		["60"] = 39,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 46,
		["65"] = 46,
		["66"] = 46,
		["67"] = 46,
		["68"] = 46,
		["69"] = 44,
		["70"] = 19,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 19,
		["80"] = 19,
		["81"] = 50,
		["82"] = 57,
		["83"] = 50,
		["84"] = 57,
		["85"] = 59,
		["86"] = 60,
		["87"] = 59,
		["88"] = 62,
		["89"] = 63,
		["90"] = 62,
		["91"] = 57,
		["92"] = 50,
		["93"] = 50,
		["94"] = 50,
		["95"] = 50,
		["96"] = 50,
		["97"] = 50,
		["98"] = 50,
		["99"] = 57,
		["101"] = 57,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_100 = c()
local n = g.trait_100
n.name = "trait_100"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_100"
end
n = e({ j(nil) }, n)
g.trait_100 = n
g.modifier_trait_100 = c()
local o = g.modifier_trait_100
o.name = "modifier_trait_100"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		local s = "179"
		do
			local t = 0
			while t < self.count do
				r:learnAbility(s, true)
				Notification:combatToPlayer(
					q,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[s].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. s,
					}
				)
				t = t + 1
			end
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_100_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_100_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_100 = o
g.modifier_trait_100_buff = c()
local u = g.modifier_trait_100_buff
u.name = "modifier_trait_100_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.chaos_damage = self:GetAbilitySpecialValueFor("chaos_damage")
end
function u.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_DAMAGE_BONUS] = self.chaos_damage }
end
u = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
g.modifier_trait_100_buff = u
return g