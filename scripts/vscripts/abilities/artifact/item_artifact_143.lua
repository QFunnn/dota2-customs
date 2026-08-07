--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_143"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
local g = b.__TS__ArrayFilter
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 3,
		["14"] = 3,
		["15"] = 3,
		["16"] = 5,
		["17"] = 6,
		["18"] = 5,
		["19"] = 6,
		["20"] = 6,
		["21"] = 6,
		["22"] = 6,
		["23"] = 6,
		["24"] = 5,
		["25"] = 6,
		["27"] = 6,
		["28"] = 8,
		["29"] = 9,
		["30"] = 8,
		["31"] = 9,
		["32"] = 11,
		["33"] = 11,
		["34"] = 11,
		["35"] = 12,
		["36"] = 12,
		["37"] = 12,
		["38"] = 13,
		["39"] = 14,
		["40"] = 15,
		["41"] = 16,
		["44"] = 17,
		["45"] = 17,
		["46"] = 17,
		["47"] = 18,
		["48"] = 19,
		["49"] = 17,
		["50"] = 17,
		["51"] = 21,
		["52"] = 22,
		["55"] = 23,
		["56"] = 24,
		["57"] = 25,
		["58"] = 26,
		["59"] = 27,
		["60"] = 27,
		["62"] = 28,
		["63"] = 29,
		["64"] = 30,
		["65"] = 31,
		["66"] = 31,
		["67"] = 31,
		["68"] = 31,
		["69"] = 31,
		["70"] = 31,
		["71"] = 31,
		["72"] = 31,
		["73"] = 36,
		["74"] = 36,
		["75"] = 36,
		["76"] = 36,
		["77"] = 36,
		["79"] = 38,
		["80"] = 39,
		["81"] = 39,
		["82"] = 39,
		["83"] = 39,
		["84"] = 39,
		["85"] = 39,
		["86"] = 39,
		["87"] = 39,
		["88"] = 39,
		["89"] = 39,
		["90"] = 39,
		["91"] = 39,
		["92"] = 40,
		["93"] = 41,
		["94"] = 41,
		["96"] = 13,
		["97"] = 9,
		["98"] = 8,
		["99"] = 8,
		["100"] = 8,
		["101"] = 8,
		["102"] = 8,
		["103"] = 8,
		["104"] = 8,
		["105"] = 8,
		["106"] = 9,
		["108"] = 9,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.item_artifact_143 = c()
local p = i.item_artifact_143
p.name = "item_artifact_143"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_143"
end
p = e({ l(nil) }, p)
i.item_artifact_143 = p
i.modifier_item_artifact_143 = c()
local q = i.modifier_item_artifact_143
q.name = "modifier_item_artifact_143"
d(q, n)
function q.prototype.GetAbilitySpecialValue(self)
	self.discount = self:GetAbilitySpecialValueFor("discount")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function q.prototype.OnRoundStart(self)
	local r = self:GetParent():GetPlayerOwnerID()
	local s = PlayerData:getHero(r)
	if not s then
		return
	end
	local t = g(f(s.abilityShopData), function(u, v)
		local w = s.abilityShopData[v]
		return not w.soldOut
			and (w.health or 0) <= 0
			and PlayerData:getGold(r) >= math.floor(w.gold * self.discount * 0.01)
	end)
	local x = GetRandomElement(t)
	if not x then
		return
	end
	local y = s.abilityShopData[x]
	local z = math.floor(y.gold * self.discount * 0.01)
	PlayerData:modifyGold(r, -z)
	y.soldOut = true
	if y.fu then
		AbilityShop:receiveFucard(r, x)
	end
	s:learnAbility(x)
	local A = self:GetAbility()
	if A then
		Notification:combatToPlayer(
			r,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[x].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. A:GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
			}
		)
		PlayerData:getplayerData(r):addArtifactAbilities(A:entindex(), x, true)
	end
	Forge:Reward(r, "buy")
	FireModifierEvent(
		EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY,
		{ abilityname = x, playerhero = self:GetParent(), heroclass = s, cost = z, index = y.index },
		self:GetParent(),
		nil
	)
	AbilityShop:updateNetTable(r)
	if AbilityShop:isEmptyShop(r) then
		AbilityShop:refreshShop(r)
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
i.modifier_item_artifact_143 = q
return i