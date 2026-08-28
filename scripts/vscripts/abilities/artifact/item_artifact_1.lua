--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_1"
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
		["31"] = 20,
		["32"] = 23,
		["33"] = 11,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 24,
		["38"] = 28,
		["39"] = 29,
		["40"] = 28,
		["41"] = 34,
		["42"] = 35,
		["43"] = 34,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 44,
		["52"] = 45,
		["53"] = 46,
		["55"] = 48,
		["56"] = 49,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 51,
		["66"] = 51,
		["67"] = 51,
		["68"] = 51,
		["70"] = 53,
		["72"] = 37,
		["73"] = 20,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 11,
		["78"] = 11,
		["79"] = 11,
		["80"] = 11,
		["81"] = 11,
		["82"] = 11,
		["83"] = 20,
		["85"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_1 = c()
local n = g.item_artifact_1
n.name = "item_artifact_1"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_1"
end
n = e({ j(nil) }, n)
g.item_artifact_1 = n
g.modifier_item_artifact_1 = c()
local o = g.modifier_item_artifact_1
o.name = "modifier_item_artifact_1"
d(o, l)
function o.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.isFirstRegen = true
end
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
	self.first_regen = self:GetAbilitySpecialValueFor("first_regen")
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
	}
end
function o.prototype.OnPlayerKilled(self, p)
	self:IncrementStackCount()
end
function o.prototype.OnBattleEndStateEnd(self, q)
	local r = self:GetStackCount()
	if r > 0 then
		local s = self.parent:GetPlayerOwnerID()
		if PlayerData:isAlivePlayer(s) then
			local t = 0
			if self.isFirstRegen then
				self.isFirstRegen = false
				t = self.first_regen
				r = r - 1
			end
			local u = r * self.hp_regen + t
			PlayerData:modifyHealth(s, u)
			PlayerData:getplayerData(s):modifyArtifactExtraData(self.ability:entindex(), "bonus_health", u)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self.parent, u, self.parent:GetPlayerOwner())
		end
		self:SetStackCount(0)
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
g.modifier_item_artifact_1 = o
return g