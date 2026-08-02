--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_126"
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
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 25,
		["36"] = 31,
		["37"] = 32,
		["38"] = 31,
		["39"] = 36,
		["40"] = 37,
		["41"] = 36,
		["42"] = 39,
		["43"] = 40,
		["44"] = 41,
		["45"] = 41,
		["46"] = 41,
		["47"] = 40,
		["48"] = 40,
		["49"] = 40,
		["50"] = 39,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 45,
		["61"] = 49,
		["62"] = 50,
		["65"] = 53,
		["66"] = 54,
		["67"] = 55,
		["68"] = 56,
		["69"] = 57,
		["70"] = 58,
		["71"] = 59,
		["76"] = 64,
		["77"] = 65,
		["78"] = 66,
		["79"] = 67,
		["80"] = 68,
		["81"] = 69,
		["82"] = 70,
		["83"] = 70,
		["84"] = 70,
		["85"] = 70,
		["86"] = 70,
		["87"] = 71,
		["88"] = 72,
		["89"] = 72,
		["90"] = 72,
		["91"] = 72,
		["92"] = 72,
		["93"] = 72,
		["94"] = 72,
		["96"] = 49,
		["97"] = 20,
		["98"] = 11,
		["99"] = 11,
		["100"] = 11,
		["101"] = 11,
		["102"] = 11,
		["103"] = 11,
		["104"] = 11,
		["105"] = 11,
		["106"] = 11,
		["107"] = 20,
		["109"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_126 = c()
local n = g.item_artifact_126
n.name = "item_artifact_126"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_126"
end
n = e({ j(nil) }, n)
g.item_artifact_126 = n
g.modifier_item_artifact_126 = c()
local o = g.modifier_item_artifact_126
o.name = "modifier_item_artifact_126"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.gold_max = self:GetAbilitySpecialValueFor("gold_max")
	self.chance_bonus = self:GetAbilitySpecialValueFor("chance_bonus")
	self.record = 0
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_RARE_CHANCE_BONUS }
end
function o.prototype.EOM_GetModifierRareChanceBonus(self)
	return self.chance_bonus
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_REFRESH] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
	}
end
function o.prototype.OnBattleEndStateEnd(self, p)
	self.record = 0
	PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "round_gain_gold", self.record, true, true)
end
function o.prototype.OnAbilityRefresh(self, p)
	if self.record >= self.gold_max then
		return
	end
	local q = 0
	for r in pairs(p) do
		if r then
			local s = KeyValues.AbilityUpgradesKvs[r]
			if s then
				if s.rarity == "r" then
					q = q + self.gold_bonus
				end
			end
		end
	end
	q = math.min(q, self.gold_max - self.record)
	self.record = math.min(self.record + q, self.gold_max)
	if q > 0 then
		local t = self:GetParent():GetPlayerOwnerID()
		local u = PlayerData:getplayerData(t)
		PlayerData:modifyGold(t, q)
		u:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", q)
		EmitAnnouncerSoundForPlayer("General.Coins", t)
		u:modifyArtifactExtraData(self:GetAbility():entindex(), "round_gain_gold", self.record, true, true)
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
g.modifier_item_artifact_126 = o
return g