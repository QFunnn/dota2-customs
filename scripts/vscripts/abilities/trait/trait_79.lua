--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_79"
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
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["44"] = 30,
		["45"] = 40,
		["47"] = 41,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 43,
		["52"] = 43,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["56"] = 43,
		["57"] = 43,
		["58"] = 41,
		["62"] = 26,
		["63"] = 51,
		["64"] = 52,
		["65"] = 53,
		["66"] = 54,
		["67"] = 54,
		["68"] = 54,
		["69"] = 54,
		["70"] = 54,
		["71"] = 54,
		["72"] = 54,
		["74"] = 51,
		["75"] = 65,
		["76"] = 66,
		["77"] = 67,
		["78"] = 67,
		["79"] = 66,
		["80"] = 65,
		["81"] = 70,
		["82"] = 71,
		["83"] = 72,
		["84"] = 72,
		["85"] = 72,
		["86"] = 72,
		["87"] = 72,
		["88"] = 72,
		["89"] = 70,
		["90"] = 19,
		["91"] = 12,
		["92"] = 12,
		["93"] = 12,
		["94"] = 12,
		["95"] = 12,
		["96"] = 12,
		["97"] = 12,
		["98"] = 19,
		["100"] = 19,
		["101"] = 76,
		["102"] = 83,
		["103"] = 76,
		["104"] = 83,
		["105"] = 85,
		["106"] = 86,
		["107"] = 85,
		["108"] = 88,
		["109"] = 89,
		["110"] = 88,
		["111"] = 93,
		["112"] = 94,
		["113"] = 94,
		["114"] = 94,
		["115"] = 94,
		["116"] = 93,
		["117"] = 83,
		["118"] = 76,
		["119"] = 76,
		["120"] = 76,
		["121"] = 76,
		["122"] = 76,
		["123"] = 76,
		["124"] = 76,
		["125"] = 83,
		["127"] = 83,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_79 = c()
local n = g.trait_79
n.name = "trait_79"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_79"
end
n = e({ j(nil) }, n)
g.trait_79 = n
g.modifier_trait_79 = c()
local o = g.modifier_trait_79
o.name = "modifier_trait_79"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.guard_hp = self:GetAbilitySpecialValueFor("guard_hp")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "sect_wisp",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "trait_79",
				values = { trait_79 = self.guard_hp },
				description = "trait_79",
			}
		)
		local s = "118"
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
function o.prototype.OnRemoved(self, u)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		AbilityUpgrades:RemoveAbilityMechanicsUpgrade(
			q,
			{
				ability_name = "sect_wisp",
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = "trait_79",
				values = { trait_79 = self.guard_hp },
				description = "trait_79",
			}
		)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_79_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_79_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_79 = o
g.modifier_trait_79_buff = c()
local v = g.modifier_trait_79_buff
v.name = "modifier_trait_79_buff"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.guard_hp = self:GetAbilitySpecialValueFor("guard_hp")
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_WISP_HEALTH_BONUS }
end
function v.prototype.EOM_GetModifierWispHealthBonus(self, p)
	return GetSectWispModifiedValue(self:GetParent(), self.guard_hp)
end
v = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
g.modifier_trait_79_buff = v
return g