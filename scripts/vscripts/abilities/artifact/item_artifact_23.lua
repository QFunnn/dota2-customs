--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_23"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["25"] = 9,
		["26"] = 5,
		["27"] = 4,
		["28"] = 5,
		["30"] = 5,
		["31"] = 16,
		["32"] = 25,
		["33"] = 16,
		["34"] = 25,
		["35"] = 28,
		["36"] = 29,
		["37"] = 28,
		["38"] = 32,
		["39"] = 33,
		["40"] = 34,
		["42"] = 32,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 39,
		["47"] = 38,
		["48"] = 37,
		["49"] = 42,
		["50"] = 44,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["60"] = 42,
		["61"] = 25,
		["62"] = 16,
		["63"] = 16,
		["64"] = 16,
		["65"] = 16,
		["66"] = 16,
		["67"] = 16,
		["68"] = 16,
		["69"] = 16,
		["70"] = 16,
		["71"] = 25,
		["73"] = 25,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_23 = c()
local n = g.item_artifact_23
n.name = "item_artifact_23"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_23"
end
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("damage_immunity_counts"))
	end
end
n = e({ j(nil) }, n)
g.item_artifact_23 = n
g.modifier_item_artifact_23 = c()
local o = g.modifier_item_artifact_23
o.name = "modifier_item_artifact_23"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.damage_immunity_counts = self:GetAbilitySpecialValueFor("damage_immunity_counts")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData.playerData[self:GetParent():GetPlayerOwnerID()].damageImmunityCounts = self.damage_immunity_counts
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, self:GetParent() } }
end
function o.prototype.OnPlayerTakeDamage(self, q)
	if q.attackerID ~= q.victimID then
		self:GetAbility()
			:SetCurrentCharges(PlayerData.playerData[self:GetParent():GetPlayerOwnerID()].damageImmunityCounts)
		if q.bImmunity and q.originDamage > 0 then
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
				:modifyArtifactExtraData(self:GetAbility():entindex(), "resist_damage", q.originDamage)
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_23 = o
return g