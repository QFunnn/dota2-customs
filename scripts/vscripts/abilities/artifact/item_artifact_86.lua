--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_86"
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 8,
		["20"] = 9,
		["21"] = 8,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["26"] = 11,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["30"] = 19,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["34"] = 24,
		["35"] = 25,
		["36"] = 20,
		["37"] = 20,
		["38"] = 16,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["42"] = 32,
		["44"] = 34,
		["45"] = 29,
		["46"] = 36,
		["47"] = 37,
		["48"] = 36,
		["49"] = 6,
		["50"] = 5,
		["51"] = 6,
		["53"] = 6,
		["54"] = 41,
		["55"] = 50,
		["56"] = 41,
		["57"] = 50,
		["58"] = 53,
		["59"] = 55,
		["60"] = 53,
		["61"] = 57,
		["62"] = 58,
		["64"] = 57,
		["65"] = 62,
		["66"] = 63,
		["67"] = 62,
		["68"] = 67,
		["69"] = 68,
		["70"] = 69,
		["73"] = 70,
		["76"] = 72,
		["77"] = 73,
		["78"] = 74,
		["81"] = 75,
		["82"] = 76,
		["83"] = 77,
		["84"] = 78,
		["85"] = 83,
		["86"] = 86,
		["87"] = 87,
		["88"] = 88,
		["89"] = 93,
		["90"] = 93,
		["91"] = 93,
		["92"] = 93,
		["93"] = 93,
		["96"] = 67,
		["97"] = 50,
		["98"] = 41,
		["99"] = 41,
		["100"] = 41,
		["101"] = 41,
		["102"] = 41,
		["103"] = 41,
		["104"] = 41,
		["105"] = 41,
		["106"] = 41,
		["107"] = 50,
		["109"] = 50,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_86 = c()
local n = g.item_artifact_86
n.name = "item_artifact_86"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_86"
end
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	self:SpendCharge()
	local p = o:GetPlayerOwnerID()
	PlayerData:requestSectSelection(
		p,
		{ sects = AbilityShop.pickList, ability_name = "item_artifact_86" },
		function(q, p, r)
			self.specifiedSect = r
		end
	)
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
g.item_artifact_86 = n
g.modifier_item_artifact_86 = c()
local s = g.modifier_item_artifact_86
s.name = "modifier_item_artifact_86"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
	end
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function s.prototype.OnRoundStart(self)
	local p = self:GetParent():GetPlayerOwnerID()
	if not PlayerData:isAlivePlayer(p) then
		return
	end
	if not self:PRD(self.chance, "modifier_item_artifact_86") then
		return
	end
	local u = self:GetAbility()
	local v = u.specifiedSect
	if v == nil then
		return
	end
	local w = PlayerData:getplayerData(p)
	local x = w.hero
	if x then
		local y = AbilityShop:getRandomAbility(
			p,
			1,
			{ specifySect = { v }, isAbilityShop = false, specifyRarityIgnoreRule = true }
		)
		if #y > 0 then
			local z = y[1].aid
			x:learnAbility(z, true)
			Notification:combatToPlayer(
				p,
				{
					message = "notify_artifact_ability_" .. y[1].rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_86",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
				}
			)
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID()):addArtifactAbilities(u:entindex(), z, true)
		end
	end
end
s = e(
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
	s
)
g.modifier_item_artifact_86 = s
return g