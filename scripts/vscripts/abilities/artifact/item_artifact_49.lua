--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_49"
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
		["18"] = 9,
		["19"] = 10,
		["20"] = 12,
		["21"] = 13,
		["23"] = 9,
		["24"] = 16,
		["25"] = 17,
		["26"] = 16,
		["27"] = 24,
		["28"] = 25,
		["29"] = 31,
		["30"] = 32,
		["31"] = 33,
		["32"] = 34,
		["34"] = 24,
		["35"] = 37,
		["36"] = 38,
		["37"] = 39,
		["38"] = 40,
		["40"] = 42,
		["41"] = 37,
		["42"] = 44,
		["43"] = 45,
		["44"] = 44,
		["45"] = 6,
		["46"] = 5,
		["47"] = 6,
		["49"] = 6,
		["50"] = 48,
		["51"] = 57,
		["52"] = 48,
		["53"] = 57,
		["54"] = 59,
		["55"] = 60,
		["56"] = 59,
		["57"] = 62,
		["58"] = 63,
		["59"] = 64,
		["60"] = 64,
		["61"] = 63,
		["62"] = 62,
		["63"] = 68,
		["64"] = 69,
		["67"] = 70,
		["70"] = 73,
		["71"] = 74,
		["72"] = 75,
		["73"] = 75,
		["74"] = 75,
		["75"] = 75,
		["76"] = 75,
		["77"] = 75,
		["78"] = 75,
		["79"] = 75,
		["80"] = 68,
		["81"] = 57,
		["82"] = 48,
		["83"] = 48,
		["84"] = 48,
		["85"] = 48,
		["86"] = 48,
		["87"] = 48,
		["88"] = 48,
		["89"] = 48,
		["90"] = 48,
		["91"] = 57,
		["93"] = 57,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_49 = c()
local n = g.item_artifact_49
n.name = "item_artifact_49"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self.round_cd = self:GetSpecialValueFor("round_cd")
		self:SetCurrentCharges(self:GetSpecialValueFor("count"))
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_49"
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = o:FindModifierByName(self:GetIntrinsicModifierName())
	if p and p:GetStackCount() < 1 then
		p:IncrementStackCount()
		self:SpendCharge()
	end
end
function n.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function n.prototype.GetCustomCastError(self)
	return self.error
end
n = e({ j(nil) }, n)
g.item_artifact_49 = n
g.modifier_item_artifact_49 = c()
local q = g.modifier_item_artifact_49
q.name = "modifier_item_artifact_49"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.exp = self:GetAbilitySpecialValueFor("exp")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent(), -1 } }
end
function q.prototype.OnAbilityBuy(self, r)
	if self:GetStackCount() <= 0 then
		return
	end
	if KeyValues.AbilityUpgradesKvs[r.abilityname].rarity == "sr" then
		return
	end
	self:DecrementStackCount()
	r.heroclass:learnAbility(r.abilityname, true)
	Notification:combatToPlayer(
		self:GetParent():GetPlayerOwnerID(),
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[r.abilityname].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_49",
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r.abilityname,
		}
	)
end
q = e(
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
	q
)
g.modifier_item_artifact_49 = q
return g