--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_120"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
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
		["27"] = 20,
		["28"] = 12,
		["29"] = 20,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 26,
		["35"] = 31,
		["36"] = 32,
		["37"] = 33,
		["39"] = 31,
		["40"] = 36,
		["41"] = 37,
		["43"] = 36,
		["44"] = 40,
		["45"] = 41,
		["46"] = 40,
		["47"] = 45,
		["48"] = 46,
		["51"] = 47,
		["54"] = 50,
		["57"] = 51,
		["58"] = 52,
		["59"] = 53,
		["60"] = 54,
		["61"] = 55,
		["62"] = 56,
		["63"] = 57,
		["64"] = 57,
		["65"] = 57,
		["66"] = 57,
		["67"] = 57,
		["68"] = 57,
		["69"] = 57,
		["70"] = 57,
		["71"] = 62,
		["72"] = 62,
		["73"] = 62,
		["74"] = 62,
		["75"] = 63,
		["78"] = 45,
		["79"] = 20,
		["80"] = 12,
		["81"] = 12,
		["82"] = 12,
		["83"] = 12,
		["84"] = 12,
		["85"] = 12,
		["86"] = 12,
		["87"] = 12,
		["88"] = 20,
		["90"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_120 = c()
local n = g.item_artifact_120
n.name = "item_artifact_120"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_120"
end
n = e({ j(nil) }, n)
g.item_artifact_120 = n
g.modifier_item_artifact_120 = c()
local o = g.modifier_item_artifact_120
o.name = "modifier_item_artifact_120"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.level = self:GetAbilitySpecialValueFor("level")
	self.card_count = self:GetAbilitySpecialValueFor("card_count")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.record = 0
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self.parent } }
end
function o.prototype.OnAbilityLearn(self, p)
	if p.bFirstLearn then
		return
	end
	if p.bGift then
		return
	end
	if self.record == self.max then
		return
	end
	local q = p.heroclass
	if q then
		local r = q:getAbilityUpgradeData()
		if r[p.abilityname] and r[p.abilityname].level == self.level then
			q:learnAbility(p.abilityname, true)
			local s = self.parent:GetPlayerOwnerID()
			Notification:combatToPlayer(
				s,
				{
					message = "notify_artifact_ability_"
						.. tostring(KeyValues.AbilityUpgradesKvs[p.abilityname].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.ability:GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. p.abilityname,
				}
			)
			PlayerData:getplayerData(s):addArtifactAbilities(self.ability:entindex(), p.abilityname)
			self.record = self.record + 1
		end
	end
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	o
)
g.modifier_item_artifact_120 = o
return g