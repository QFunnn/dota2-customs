--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_89"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayFilter
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["16"] = 5,
		["17"] = 6,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 7,
		["23"] = 6,
		["24"] = 5,
		["25"] = 6,
		["27"] = 6,
		["28"] = 12,
		["29"] = 21,
		["30"] = 12,
		["31"] = 21,
		["32"] = 26,
		["33"] = 27,
		["34"] = 28,
		["35"] = 29,
		["36"] = 26,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["41"] = 31,
		["42"] = 36,
		["43"] = 37,
		["44"] = 37,
		["45"] = 37,
		["46"] = 37,
		["47"] = 36,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["51"] = 44,
		["52"] = 44,
		["53"] = 44,
		["54"] = 44,
		["55"] = 42,
		["56"] = 46,
		["57"] = 47,
		["58"] = 48,
		["59"] = 49,
		["60"] = 50,
		["62"] = 46,
		["63"] = 53,
		["64"] = 54,
		["65"] = 55,
		["66"] = 56,
		["67"] = 57,
		["68"] = 58,
		["71"] = 61,
		["73"] = 53,
		["74"] = 64,
		["75"] = 65,
		["76"] = 66,
		["77"] = 67,
		["78"] = 68,
		["79"] = 69,
		["80"] = 69,
		["81"] = 69,
		["82"] = 69,
		["83"] = 69,
		["84"] = 70,
		["85"] = 71,
		["86"] = 72,
		["87"] = 72,
		["88"] = 72,
		["89"] = 72,
		["91"] = 74,
		["92"] = 75,
		["94"] = 75,
		["96"] = 76,
		["97"] = 82,
		["98"] = 82,
		["99"] = 82,
		["100"] = 82,
		["101"] = 82,
		["103"] = 64,
		["104"] = 21,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 12,
		["110"] = 12,
		["111"] = 12,
		["112"] = 12,
		["113"] = 12,
		["114"] = 21,
		["116"] = 21,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_89 = c()
local o = h.item_artifact_89
o.name = "item_artifact_89"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_89"
end
o = e({ k(nil) }, o)
h.item_artifact_89 = o
h.modifier_item_artifact_89 = c()
local p = h.modifier_item_artifact_89
p.name = "modifier_item_artifact_89"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.refresh_count = self:GetAbilitySpecialValueFor("refresh_count")
	self.exp = self:GetAbilitySpecialValueFor("exp")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.record = 0
	end
end
function p.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = {},
	}
end
function p.prototype.OnBattleEndStateEnd(self, q)
	self.record = 0
	PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID()):modifyArtifactExtraStringData(
		self:GetAbility():entindex(),
		"DOTA_Tooltip_ability_trait_103_effect",
		tostring(self.record)
	)
end
function p.prototype.OnShopRefresh(self, q)
	if self.record < self.max then
		self:IncrementStackCount()
	elseif self:GetStackCount() < self.refresh_count - 1 then
		self:IncrementStackCount()
	end
end
function p.prototype.OnStackCountChanged(self, r)
	if IsServer() then
		local s = self:GetStackCount()
		if s >= self.refresh_count then
			self:AddRandomSectExp()
			self:SetStackCount(0)
			return
		end
		self:GetAbility():SetCurrentCharges(s)
	end
end
function p.prototype.AddRandomSectExp(self)
	self.record = self.record + 1
	local t = self:GetParent():GetPlayerOwnerID()
	local u = PlayerData:getplayerData(t)
	if u then
		u:modifyArtifactExtraStringData(
			self:GetAbility():entindex(),
			"DOTA_Tooltip_ability_trait_103_effect",
			tostring(self.record)
		)
		local v = shallowcopy(AbilityShop.pickList)
		if u.bannedSect then
			v = f(v, function(w, x)
				return x ~= u.bannedSect
			end)
		end
		local y = GetRandomElement(v)
		local z = PlayerData:getHero(t)
		if z ~= nil then
			z:addSectExp(y, self.exp)
		end
		Notification:combatToPlayer(
			t,
			{
				message = "notify_artifact_48",
				string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_89",
				string_sect = "DOTA_Tooltip_ability_" .. y,
				int_exp = self.exp,
			}
		)
		u:modifyArtifactExtraData(self:GetAbility():entindex(), "exp_gain", self.exp)
	end
end
p = e(
	{
		n(
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
	p
)
h.modifier_item_artifact_89 = p
return h