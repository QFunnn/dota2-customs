--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_138"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySlice
local f = b.__TS__ObjectKeys
local g = b.__TS__DecorateLegacy
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
		["21"] = 5,
		["22"] = 6,
		["23"] = 4,
		["24"] = 7,
		["25"] = 7,
		["26"] = 7,
		["28"] = 7,
		["29"] = 8,
		["30"] = 8,
		["31"] = 8,
		["32"] = 9,
		["33"] = 10,
		["34"] = 11,
		["35"] = 12,
		["38"] = 13,
		["39"] = 14,
		["40"] = 14,
		["41"] = 15,
		["42"] = 15,
		["44"] = 16,
		["45"] = 17,
		["46"] = 18,
		["48"] = 20,
		["49"] = 21,
		["52"] = 22,
		["53"] = 23,
		["54"] = 23,
		["55"] = 23,
		["56"] = 23,
		["57"] = 23,
		["58"] = 23,
		["59"] = 23,
		["60"] = 23,
		["61"] = 28,
		["62"] = 28,
		["63"] = 28,
		["64"] = 28,
		["65"] = 28,
		["66"] = 29,
		["67"] = 30,
		["68"] = 9,
		["69"] = 32,
		["70"] = 33,
		["71"] = 33,
		["72"] = 33,
		["74"] = 34,
		["75"] = 32,
		["76"] = 36,
		["77"] = 36,
		["78"] = 36,
		["79"] = 5,
		["80"] = 4,
		["81"] = 5,
		["83"] = 5,
		["84"] = 39,
		["85"] = 40,
		["86"] = 39,
		["87"] = 40,
		["88"] = 42,
		["89"] = 42,
		["90"] = 42,
		["91"] = 43,
		["92"] = 44,
		["93"] = 43,
		["94"] = 46,
		["95"] = 47,
		["96"] = 48,
		["99"] = 49,
		["100"] = 50,
		["101"] = 50,
		["102"] = 50,
		["103"] = 50,
		["104"] = 50,
		["105"] = 50,
		["106"] = 50,
		["107"] = 51,
		["108"] = 51,
		["110"] = 52,
		["111"] = 46,
		["112"] = 40,
		["113"] = 39,
		["114"] = 39,
		["115"] = 39,
		["116"] = 39,
		["117"] = 39,
		["118"] = 39,
		["119"] = 39,
		["120"] = 39,
		["121"] = 40,
		["123"] = 40,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.item_artifact_138 = c()
local p = i.item_artifact_138
p.name = "item_artifact_138"
d(p, k)
function p.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.debtRounds = 0
end
function p.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_138"
end
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if not r then
		return
	end
	local s = e(AbilityShop.banList)
	local t = PlayerData:getplayerData(q)
	local u = t and t.bannedSect
	if u then
		s[#s + 1] = u
	end
	local v = AbilityShop:getAbilityPoolNew("sr", nil, s, false)
	for w, x in ipairs(f(r:getAbilityUpgradeData())) do
		v:remove(x)
	end
	local x = v:random()
	if not x then
		return
	end
	r:learnAbility(x, true)
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[x].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
		}
	)
	PlayerData:getplayerData(q):addArtifactAbilities(self:entindex(), x, true)
	self.debtRounds = self:GetSpecialValueFor("round")
	self:SpendCharge()
end
function p.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() <= 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function p.prototype.GetCustomCastError(self)
	return self.error
end
p = g({ l(nil) }, p)
i.item_artifact_138 = p
i.modifier_item_artifact_138 = c()
local y = i.modifier_item_artifact_138
y.name = "modifier_item_artifact_138"
d(y, n)
function y.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function y.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function y.prototype.OnRoundStart(self)
	local z = self:GetAbility()
	if not IsValid(z) or z.debtRounds <= 0 then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local A = math.min(self.gold, math.max(0, PlayerData:getGold(q)))
	if A > 0 then
		PlayerData:modifyGold(q, -A)
	end
	z.debtRounds = z.debtRounds - 1
end
y = g(
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
	y
)
i.modifier_item_artifact_138 = y
return i