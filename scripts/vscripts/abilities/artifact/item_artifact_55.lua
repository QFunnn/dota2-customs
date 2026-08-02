--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_55"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySome
local g = b.__TS__ArrayFind
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 5,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 4,
		["25"] = 5,
		["27"] = 5,
		["28"] = 11,
		["29"] = 19,
		["30"] = 11,
		["31"] = 19,
		["32"] = 29,
		["33"] = 30,
		["34"] = 31,
		["35"] = 32,
		["37"] = 29,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 36,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["46"] = 44,
		["47"] = 43,
		["48"] = 42,
		["49"] = 47,
		["50"] = 48,
		["51"] = 47,
		["52"] = 52,
		["53"] = 54,
		["54"] = 54,
		["55"] = 54,
		["56"] = 54,
		["59"] = 55,
		["60"] = 56,
		["61"] = 57,
		["62"] = 58,
		["63"] = 59,
		["64"] = 60,
		["65"] = 61,
		["66"] = 62,
		["68"] = 63,
		["69"] = 63,
		["70"] = 64,
		["71"] = 65,
		["72"] = 66,
		["73"] = 68,
		["74"] = 69,
		["75"] = 70,
		["77"] = 72,
		["78"] = 73,
		["80"] = 68,
		["81"] = 76,
		["82"] = 77,
		["83"] = 78,
		["84"] = 83,
		["85"] = 84,
		["86"] = 85,
		["89"] = 88,
		["92"] = 63,
		["95"] = 92,
		["96"] = 52,
		["97"] = 95,
		["98"] = 96,
		["101"] = 99,
		["102"] = 100,
		["103"] = 102,
		["104"] = 103,
		["105"] = 103,
		["106"] = 103,
		["107"] = 103,
		["108"] = 103,
		["109"] = 103,
		["112"] = 106,
		["113"] = 108,
		["114"] = 109,
		["115"] = 109,
		["116"] = 113,
		["117"] = 113,
		["118"] = 113,
		["119"] = 113,
		["121"] = 95,
		["122"] = 19,
		["123"] = 11,
		["124"] = 11,
		["125"] = 11,
		["126"] = 11,
		["127"] = 11,
		["128"] = 11,
		["129"] = 11,
		["130"] = 11,
		["131"] = 19,
		["133"] = 19,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.item_artifact_55 = c()
local p = i.item_artifact_55
p.name = "item_artifact_55"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_55"
end
p = e({ l(nil) }, p)
i.item_artifact_55 = p
i.modifier_item_artifact_55 = c()
local q = i.modifier_item_artifact_55
q.name = "modifier_item_artifact_55"
d(q, n)
function q.prototype.OnCreated(self, r)
	if IsServer() then
		self.sectList = {}
		self.record = 0
	end
end
function q.prototype.GetAbilitySpecialValue(self)
	self.sect_threshold = self:GetAbilitySpecialValueFor("sect_threshold")
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = { self:GetParent(), -1 } }
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function q.prototype.EOM_GetModifierCustomShopRefreshList(self, r)
	if not f(self.sectList, function(s, t)
		return not t.used
	end) then
		return
	end
	local u = self:GetParent()
	local v = u:GetPlayerOwnerID()
	local w = PlayerData:getplayerData(v)
	local x = w.hero
	local y = self.sectList
	local z = 0
	local A = {}
	local B = r and r.excludelist
	do
		local C = 0
		while C < #y do
			local D = y[C + 1]
			if not D.used then
				local E = AbilityShop:getAbilityPoolNew("r", D.sectName, nil, true)
				E:each(function(s, F)
					if x:getAbilityUpgradeLevel(F) >= SECT_ABILITY_LEVEL.r then
						E:set(F, 0)
					end
					if B and TableFindKey(B, F) then
						E:set(F, 0)
					end
				end)
				if E:count() > 0 then
					local G = E:random()
					A[#A + 1] = { aid = G, gold = 0, type = "artifact" }
					x:removeSectModifiers(self:GetAbility():GetName())
					D.used = true
					z = z + 1
				end
			end
			if z >= w:getAbilityShopProductSlotCount() then
				break
			end
			C = C + 1
		end
	end
	return A
end
function q.prototype.OnSectLevelUp(self, r)
	if self.record >= self.max then
		return
	end
	local u = self:GetParent()
	local x = PlayerData:getHero(u:GetPlayerOwnerID())
	if r.newLevel == self.sect_threshold then
		if g(self.sectList, function(s, H)
			return H.sectName == r.sect
		end) ~= nil then
			return
		end
		self.record = self.record + 1
		self:GetAbility():SetCurrentCharges(self.record)
		local I = self.sectList
		I[#I + 1] = { sectName = r.sect, used = false }
		x:addSectModifier(r.sect, self:GetAbility():GetName())
	end
end
q = e(
	{
		o(
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
	q
)
i.modifier_item_artifact_55 = q
return i