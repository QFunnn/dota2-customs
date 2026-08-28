--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_96"
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
		["27"] = 19,
		["28"] = 11,
		["29"] = 19,
		["30"] = 26,
		["31"] = 27,
		["32"] = 28,
		["33"] = 29,
		["34"] = 30,
		["35"] = 26,
		["36"] = 32,
		["37"] = 33,
		["38"] = 34,
		["40"] = 32,
		["41"] = 37,
		["42"] = 38,
		["43"] = 37,
		["44"] = 44,
		["45"] = 45,
		["46"] = 46,
		["47"] = 47,
		["48"] = 48,
		["49"] = 49,
		["50"] = 49,
		["51"] = 49,
		["52"] = 49,
		["53"] = 49,
		["54"] = 50,
		["55"] = 50,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 44,
		["63"] = 56,
		["64"] = 57,
		["65"] = 58,
		["67"] = 56,
		["68"] = 61,
		["69"] = 62,
		["70"] = 63,
		["71"] = 64,
		["72"] = 65,
		["73"] = 66,
		["74"] = 67,
		["78"] = 61,
		["79"] = 72,
		["80"] = 73,
		["81"] = 74,
		["82"] = 75,
		["83"] = 76,
		["85"] = 78,
		["87"] = 80,
		["88"] = 72,
		["89"] = 82,
		["90"] = 83,
		["91"] = 85,
		["93"] = 82,
		["94"] = 19,
		["95"] = 11,
		["96"] = 11,
		["97"] = 11,
		["98"] = 11,
		["99"] = 11,
		["100"] = 11,
		["101"] = 11,
		["102"] = 11,
		["103"] = 19,
		["105"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_96 = c()
local n = g.item_artifact_96
n.name = "item_artifact_96"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_96"
end
n = e({ j(nil) }, n)
g.item_artifact_96 = n
g.modifier_item_artifact_96 = c()
local o = g.modifier_item_artifact_96
o.name = "modifier_item_artifact_96"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.threshold = self:GetAbilitySpecialValueFor("threshold")
	self.round_gold = self:GetAbilitySpecialValueFor("round_gold")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.saved_gold = 0
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function o.prototype.OnPrepare(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = self.saved_gold + self.round_gold
	self.saved_gold = 0
	PlayerData:modifyGold(q, r)
	PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", r)
	Notification:combatToPlayer(
		q,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_gold = r,
		}
	)
end
function o.prototype.OnBattleStart(self, p)
	if IsServer() then
		self:StartIntervalThink(0.5)
	end
end
function o.prototype.OnIntervalThink(self)
	if IsServer() then
		if not self.state then
			local q = self:GetParent():GetPlayerOwnerID()
			if PlayerData:getGold(q) <= self.threshold then
				self.state = true
				self:StartIntervalThink(-1)
			end
		end
	end
end
function o.prototype.OnBattleEndStateEnd(self, p)
	self:StartIntervalThink(-1)
	if self.state and RollPercentage(self.chance) then
		self.saved_gold = self.gold
		self:SetStackCount(0)
	else
		self:IncrementStackCount()
	end
	self.state = nil
end
function o.prototype.OnStackCountChanged(self, s)
	if IsServer() then
		self:GetAbility():SetCurrentCharges(self:GetStackCount())
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
g.modifier_item_artifact_96 = o
return g