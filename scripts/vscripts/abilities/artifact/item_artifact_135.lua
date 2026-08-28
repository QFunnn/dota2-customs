--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_135"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ArrayFilter
local g = b.__TS__ArrayForEach
local h = b.__TS__ArraySome
local i = b.__TS__DecorateLegacy
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 7,
		["23"] = 6,
		["24"] = 10,
		["25"] = 11,
		["26"] = 12,
		["27"] = 13,
		["28"] = 14,
		["31"] = 15,
		["32"] = 15,
		["33"] = 15,
		["34"] = 15,
		["35"] = 16,
		["38"] = 18,
		["39"] = 19,
		["40"] = 20,
		["41"] = 20,
		["42"] = 20,
		["43"] = 21,
		["44"] = 22,
		["45"] = 23,
		["46"] = 23,
		["48"] = 24,
		["49"] = 25,
		["50"] = 25,
		["51"] = 25,
		["52"] = 25,
		["53"] = 25,
		["54"] = 25,
		["55"] = 25,
		["56"] = 25,
		["57"] = 30,
		["58"] = 30,
		["59"] = 30,
		["60"] = 30,
		["61"] = 30,
		["62"] = 31,
		["63"] = 32,
		["64"] = 32,
		["65"] = 32,
		["66"] = 32,
		["67"] = 32,
		["68"] = 32,
		["69"] = 32,
		["70"] = 32,
		["71"] = 32,
		["72"] = 32,
		["73"] = 32,
		["74"] = 32,
		["75"] = 20,
		["76"] = 20,
		["77"] = 40,
		["78"] = 10,
		["79"] = 43,
		["80"] = 44,
		["81"] = 45,
		["82"] = 46,
		["83"] = 47,
		["85"] = 49,
		["86"] = 49,
		["88"] = 50,
		["89"] = 51,
		["90"] = 52,
		["92"] = 54,
		["93"] = 55,
		["94"] = 55,
		["95"] = 55,
		["96"] = 55,
		["97"] = 56,
		["98"] = 57,
		["100"] = 59,
		["101"] = 43,
		["102"] = 62,
		["103"] = 63,
		["104"] = 62,
		["105"] = 5,
		["106"] = 4,
		["107"] = 5,
		["109"] = 5,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseItem
local n = l.registerAbility
k.item_artifact_135 = c()
local o = k.item_artifact_135
o.name = "item_artifact_135"
d(o, m)
function o.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster():GetPlayerOwnerID()
	local q = self:GetSpecialValueFor("gold_cost")
	local r = PlayerData:getHero(p)
	if not r or PlayerData:getGold(p) < q then
		return
	end
	local s = f(e(r.abilityShopData), function(t, u)
		return not r.abilityShopData[u].soldOut
	end)
	if #s == 0 then
		return
	end
	PlayerData:modifyGold(p, -q)
	self:SpendCharge()
	g(s, function(t, v, w)
		local x = r.abilityShopData[v]
		x.soldOut = true
		if x.fu then
			AbilityShop:receiveFucard(p, v)
		end
		r:learnAbility(v)
		Notification:combatToPlayer(
			p,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[v].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v,
			}
		)
		PlayerData:getplayerData(p):addArtifactAbilities(self:entindex(), v, w == #s - 1)
		Forge:Reward(p, "buy")
		FireModifierEvent(
			EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY,
			{ abilityname = v, playerhero = PlayerResource:GetSelectedHeroEntity(p), heroclass = r, cost = 0, index = x.index },
			PlayerResource:GetSelectedHeroEntity(p),
			nil
		)
	end)
	AbilityShop:refreshShop(p)
end
function o.prototype.CastFilterResult(self)
	local p = self:GetCaster():GetPlayerOwnerID()
	if self:GetCurrentCharges() <= 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	if not IsServer() then
		return UF_SUCCESS
	end
	if PlayerData:getGold(p) < self:GetSpecialValueFor("gold_cost") then
		self.error = "dota_hud_error_not_enough_gold"
		return UF_FAIL_CUSTOM
	end
	local r = PlayerData:getHero(p)
	if not r or not h(e(r.abilityShopData), function(t, u)
		return not r.abilityShopData[u].soldOut
	end) then
		self.error = "error_shop_empty"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastError(self)
	return self.error
end
o = i({ n(nil) }, o)
k.item_artifact_135 = o
return k