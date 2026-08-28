--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_80"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Delete
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 2,
		["10"] = 2,
		["11"] = 2,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["16"] = 6,
		["17"] = 7,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 9,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 7,
		["27"] = 7,
		["28"] = 13,
		["29"] = 22,
		["30"] = 13,
		["31"] = 22,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 30,
		["36"] = 27,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 36,
		["43"] = 36,
		["44"] = 36,
		["46"] = 32,
		["47"] = 39,
		["48"] = 40,
		["49"] = 41,
		["50"] = 41,
		["51"] = 40,
		["52"] = 39,
		["53"] = 44,
		["54"] = 45,
		["55"] = 46,
		["58"] = 49,
		["60"] = 49,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["66"] = 49,
		["67"] = 50,
		["68"] = 51,
		["69"] = 52,
		["70"] = 53,
		["71"] = 54,
		["72"] = 55,
		["73"] = 56,
		["74"] = 57,
		["75"] = 58,
		["76"] = 60,
		["77"] = 61,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["83"] = 68,
		["85"] = 69,
		["86"] = 69,
		["87"] = 70,
		["88"] = 71,
		["89"] = 72,
		["90"] = 73,
		["91"] = 78,
		["92"] = 78,
		["93"] = 78,
		["94"] = 78,
		["95"] = 78,
		["97"] = 69,
		["103"] = 44,
		["104"] = 22,
		["105"] = 13,
		["106"] = 13,
		["107"] = 13,
		["108"] = 13,
		["109"] = 13,
		["110"] = 13,
		["111"] = 13,
		["112"] = 13,
		["113"] = 13,
		["114"] = 22,
		["116"] = 22,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_80 = c()
local o = h.item_artifact_80
o.name = "item_artifact_80"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_80"
end
o = e({ k(nil) }, o)
h.item_artifact_80 = o
h.modifier_item_artifact_80 = c()
local p = h.modifier_item_artifact_80
p.name = "modifier_item_artifact_80"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
	self.n_count = self:GetAbilitySpecialValueFor("n_count")
	self.max = self:GetAbilitySpecialValueFor("max")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.record = 0
		local r = self:GetParent():GetPlayerOwnerID()
		PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.gold_bonus)
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function p.prototype.OnAbilityLearn(self, q)
	if not q.bGift then
		if self.record >= self.max then
			return
		end
		local s = q.abilityUpgradeInfo
		if s ~= nil then
			s = s.rarity
		end
		local t = s
		if t == nil then
			t = ""
		end
		local u = t
		if u == "r" or u == "sr" then
			local r = self:GetParent():GetPlayerOwnerID()
			local v = PlayerData:getplayerData(r)
			local w = v and v.bannedSect
			local x = v.hero
			if x then
				local y = AbilityShop:getAbilityPoolNew("n", nil, { w })
				for z, A in pairs(y.tList) do
					x:getAbilityUpgradeLevel(tostring(z))
					if
						x:getAbilityUpgradeLevel(tostring(z))
						>= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[z].rarity]
					then
						f(y.tList, z)
					end
				end
				y:update()
				local A = math.min(self.max - self.record, self.n_count)
				self.record = self.record + A
				self:GetAbility():SetCurrentCharges(self.record)
				do
					local B = 0
					while B < A do
						local C = y:random()
						if C then
							x:learnAbility(C, true)
							Notification:combatToPlayer(
								r,
								{
									message = "notify_artifact_ability_" .. "n",
									string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_80",
									string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
								}
							)
							PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
								:addArtifactAbilities(self:GetAbility():entindex(), C, B == self.n_count - 1)
						end
						B = B + 1
					end
				end
			end
		end
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
h.modifier_item_artifact_80 = p
return h