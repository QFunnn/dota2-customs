--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_103"
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
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 25,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["38"] = 29,
		["39"] = 34,
		["40"] = 35,
		["41"] = 35,
		["42"] = 35,
		["43"] = 35,
		["44"] = 34,
		["45"] = 40,
		["46"] = 41,
		["47"] = 40,
		["48"] = 43,
		["49"] = 44,
		["50"] = 45,
		["51"] = 46,
		["52"] = 47,
		["53"] = 48,
		["54"] = 49,
		["55"] = 50,
		["56"] = 50,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 51,
		["62"] = 53,
		["63"] = 43,
		["64"] = 19,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 19,
		["75"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_103 = c()
local n = g.item_artifact_103
n.name = "item_artifact_103"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_103"
end
n = e({ j(nil) }, n)
g.item_artifact_103 = n
g.modifier_item_artifact_103 = c()
local o = g.modifier_item_artifact_103
o.name = "modifier_item_artifact_103"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.refresh = self:GetAbilitySpecialValueFor("refresh")
	self.limit = self:GetAbilitySpecialValueFor("limit")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.record = 0
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent() },
	}
end
function o.prototype.OnBattleEndStateEnd(self, p)
	self.flag = nil
end
function o.prototype.OnShopRefresh(self, p)
	self.record = self.record + 1
	local q = self:GetAbility()
	if not self.flag and self.record >= self.refresh then
		self.flag = true
		local r = self:GetParent():GetPlayerOwnerID()
		AbilityShop:setPlayerAbilityShopFreeCount(r, 1)
		PlayerData:getplayerData(r):modifyArtifactExtraData(self:GetAbility():entindex(), "AbilityFreeCount", 1)
		self.record = 0
	end
	q:SetCurrentCharges(math.min(self.record, self.refresh - 1))
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
g.modifier_item_artifact_103 = o
return g