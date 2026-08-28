--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_70"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 27,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["41"] = 32,
		["43"] = 32,
		["45"] = 33,
		["46"] = 39,
		["47"] = 39,
		["48"] = 39,
		["49"] = 39,
		["50"] = 39,
		["52"] = 27,
		["53"] = 42,
		["54"] = 43,
		["55"] = 42,
		["56"] = 57,
		["57"] = 58,
		["58"] = 59,
		["59"] = 60,
		["62"] = 61,
		["64"] = 61,
		["66"] = 62,
		["67"] = 68,
		["68"] = 68,
		["69"] = 68,
		["70"] = 68,
		["71"] = 68,
		["72"] = 57,
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
g.item_artifact_70 = c()
local n = g.item_artifact_70
n.name = "item_artifact_70"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_70"
end
n = e({ j(nil) }, n)
g.item_artifact_70 = n
g.modifier_item_artifact_70 = c()
local o = g.modifier_item_artifact_70
o.name = "modifier_item_artifact_70"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.exp = self:GetAbilitySpecialValueFor("exp")
	self.start_exp = self:GetAbilitySpecialValueFor("start_exp")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = GetRandomElement(AbilityShop.pickList)
		if not PlayerData:isAlivePlayer(q) then
			return
		end
		local s = PlayerData:getHero(q)
		if s ~= nil then
			s:addSectExp(r, self.start_exp)
		end
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_48",
				string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_70",
				string_sect = "DOTA_Tooltip_ability_" .. r,
				int_exp = self.start_exp,
			}
		)
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", self.start_exp)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	local q = self:GetParent():GetPlayerOwnerID()
	local r = GetRandomElement(AbilityShop.pickList)
	if not PlayerData:isAlivePlayer(q) then
		return
	end
	local t = PlayerData:getHero(q)
	if t ~= nil then
		t:addSectExp(r, self.exp)
	end
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_70",
			string_sect = "DOTA_Tooltip_ability_" .. r,
			int_exp = self.exp,
		}
	)
	PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", self.exp)
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
g.modifier_item_artifact_70 = o
return g