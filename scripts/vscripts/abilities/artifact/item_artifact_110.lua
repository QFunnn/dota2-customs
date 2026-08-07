--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_110"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
local f = b.__TS__DecorateLegacy
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
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 9,
		["23"] = 7,
		["24"] = 12,
		["25"] = 13,
		["26"] = 14,
		["27"] = 15,
		["28"] = 16,
		["29"] = 16,
		["30"] = 16,
		["31"] = 19,
		["32"] = 20,
		["33"] = 21,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 22,
		["38"] = 23,
		["39"] = 24,
		["42"] = 16,
		["43"] = 16,
		["44"] = 12,
		["45"] = 29,
		["46"] = 30,
		["47"] = 31,
		["48"] = 32,
		["50"] = 34,
		["51"] = 29,
		["52"] = 36,
		["53"] = 37,
		["54"] = 36,
		["55"] = 39,
		["56"] = 40,
		["57"] = 39,
		["58"] = 6,
		["59"] = 5,
		["60"] = 6,
		["62"] = 6,
		["63"] = 44,
		["64"] = 53,
		["65"] = 44,
		["66"] = 53,
		["67"] = 56,
		["68"] = 57,
		["69"] = 56,
		["70"] = 59,
		["71"] = 60,
		["72"] = 61,
		["73"] = 62,
		["74"] = 63,
		["75"] = 64,
		["76"] = 65,
		["77"] = 65,
		["78"] = 65,
		["79"] = 65,
		["82"] = 59,
		["83"] = 69,
		["84"] = 70,
		["85"] = 71,
		["86"] = 72,
		["87"] = 73,
		["88"] = 74,
		["89"] = 75,
		["90"] = 75,
		["91"] = 75,
		["92"] = 75,
		["96"] = 69,
		["97"] = 80,
		["98"] = 81,
		["99"] = 80,
		["100"] = 85,
		["101"] = 86,
		["104"] = 87,
		["105"] = 88,
		["106"] = 89,
		["107"] = 90,
		["108"] = 91,
		["109"] = 92,
		["110"] = 93,
		["111"] = 93,
		["112"] = 93,
		["113"] = 93,
		["114"] = 93,
		["115"] = 93,
		["116"] = 93,
		["117"] = 93,
		["118"] = 98,
		["119"] = 98,
		["120"] = 98,
		["121"] = 98,
		["122"] = 98,
		["125"] = 85,
		["126"] = 53,
		["127"] = 44,
		["128"] = 44,
		["129"] = 44,
		["130"] = 44,
		["131"] = 44,
		["132"] = 44,
		["133"] = 44,
		["134"] = 44,
		["135"] = 44,
		["136"] = 53,
		["138"] = 53,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_110 = c()
local o = h.item_artifact_110
o.name = "item_artifact_110"
d(o, j)
function o.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local q = p:GetPlayerOwnerID()
	self:SpendCharge()
	PlayerData:requestSectSelection(
		q,
		{ sects = AbilityShop.pickList, ability_name = "item_artifact_110" },
		function(r, q, s)
			if IsValid(self) and IsValid(self:GetCaster()) then
				local t = self:GetCaster():FindAllModifiersByName("modifier_item_artifact_110")
				local u = e(t, function(r, v)
					return IsValid(v) and v:GetAbility() == self
				end)
				if u then
					u:SetSpecifySect(s)
				end
			end
		end
	)
end
function o.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastError(self)
	return self.error
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_110"
end
o = f({ k(nil) }, o)
h.item_artifact_110 = o
h.modifier_item_artifact_110 = c()
local w = h.modifier_item_artifact_110
w.name = "modifier_item_artifact_110"
d(w, m)
function w.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function w.prototype.SetSpecifySect(self, s)
	if not self.specify_sect then
		self.specify_sect = s
		local q = self:GetParent():GetPlayerOwnerID()
		local x = PlayerData:getHero(q)
		if x then
			x:addSectModifier(s, self:GetAbility():GetName())
		end
	end
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		if self.specify_sect then
			local x = PlayerData:getHero(q)
			if x then
				x:addSectModifier(self.specify_sect, self:GetAbility():GetName())
			end
		end
	end
end
function w.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { -1, -1 } }
end
function w.prototype.OnAbilityBuy(self, y)
	if not self.specify_sect then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if y.heroclass.playerID ~= q then
		local z = y.abilityname
		local s = KeyValues.AbilityUpgradesKvs[z].sect
		if (string.find(s, self.specify_sect, nil, true) or 0) - 1 ~= -1 then
			PlayerData:modifyGold(q, self.gold)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					int_gold = self.gold,
				}
			)
			PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
		end
	end
end
w = f(
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
	w
)
h.modifier_item_artifact_110 = w
return h