--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_107"
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
		["30"] = 21,
		["31"] = 22,
		["32"] = 21,
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 30,
		["37"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 36,
		["45"] = 37,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 38,
		["51"] = 39,
		["52"] = 39,
		["53"] = 39,
		["54"] = 39,
		["55"] = 39,
		["56"] = 39,
		["57"] = 39,
		["60"] = 30,
		["61"] = 19,
		["62"] = 11,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 19,
		["72"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_107 = c()
local n = g.item_artifact_107
n.name = "item_artifact_107"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_107"
end
n = e({ j(nil) }, n)
g.item_artifact_107 = n
g.modifier_item_artifact_107 = c()
local o = g.modifier_item_artifact_107
o.name = "modifier_item_artifact_107"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp = self:GetAbilitySpecialValueFor("hp")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.illusionPlayerID ~= q and p.winPlayerID == q then
		local r = PlayerData:getplayerData(q)
		if r and r.loseStack > 0 then
			local q = self:GetParent():GetPlayerOwnerID()
			PlayerData:modifyHealth(q, self.hp)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", self.hp)
			SendOverheadEventMessage(
				nil,
				OVERHEAD_ALERT_HEAL,
				self:GetParent(),
				self.hp,
				self:GetParent():GetPlayerOwner()
			)
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
g.modifier_item_artifact_107 = o
return g