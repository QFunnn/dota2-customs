--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_24"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 26,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["40"] = 26,
		["41"] = 33,
		["42"] = 34,
		["43"] = 35,
		["44"] = 35,
		["45"] = 35,
		["46"] = 34,
		["47"] = 34,
		["48"] = 37,
		["49"] = 37,
		["50"] = 37,
		["51"] = 34,
		["52"] = 34,
		["53"] = 33,
		["54"] = 40,
		["55"] = 41,
		["56"] = 40,
		["57"] = 45,
		["58"] = 46,
		["59"] = 45,
		["60"] = 50,
		["61"] = 51,
		["62"] = 50,
		["63"] = 53,
		["64"] = 54,
		["65"] = 55,
		["66"] = 55,
		["67"] = 55,
		["68"] = 55,
		["69"] = 55,
		["70"] = 55,
		["71"] = 53,
		["72"] = 57,
		["73"] = 58,
		["74"] = 59,
		["75"] = 60,
		["78"] = 61,
		["79"] = 62,
		["80"] = 57,
		["81"] = 64,
		["82"] = 65,
		["83"] = 66,
		["84"] = 67,
		["85"] = 68,
		["86"] = 69,
		["87"] = 70,
		["88"] = 70,
		["89"] = 70,
		["90"] = 70,
		["91"] = 70,
		["92"] = 70,
		["93"] = 70,
		["94"] = 70,
		["95"] = 75,
		["96"] = 75,
		["97"] = 75,
		["98"] = 75,
		["99"] = 75,
		["101"] = 64,
		["102"] = 19,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 12,
		["109"] = 12,
		["110"] = 19,
		["112"] = 19,
		["113"] = 80,
		["114"] = 87,
		["115"] = 80,
		["116"] = 87,
		["117"] = 90,
		["118"] = 91,
		["119"] = 92,
		["120"] = 90,
		["121"] = 94,
		["122"] = 95,
		["123"] = 96,
		["125"] = 94,
		["126"] = 99,
		["127"] = 100,
		["128"] = 99,
		["129"] = 104,
		["130"] = 105,
		["131"] = 106,
		["132"] = 104,
		["133"] = 108,
		["134"] = 109,
		["135"] = 108,
		["136"] = 114,
		["137"] = 115,
		["138"] = 114,
		["139"] = 87,
		["140"] = 80,
		["141"] = 80,
		["142"] = 80,
		["143"] = 80,
		["144"] = 80,
		["145"] = 80,
		["146"] = 80,
		["147"] = 87,
		["149"] = 87,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_24 = c()
local n = g.trait_24
n.name = "trait_24"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_24"
end
n = e({ j(nil) }, n)
g.trait_24 = n
g.modifier_trait_24 = c()
local o = g.modifier_trait_24
o.name = "modifier_trait_24"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHeroLevel(q)
		self:SetStackCount(r)
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent(), -1 },
	}
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INTEREST_RATE_CONSTANT] = 100000 }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function o.prototype.EOM_GetModifierExtraWages(self)
	return self:GetStackCount() * self.gold
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_24_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_24_buff", {})
end
function o.prototype.OnHeroLevelUp(self, p)
	local s = self:GetParent()
	local q = self:GetParent():GetPlayerOwnerID()
	if p.player_id ~= s:GetPlayerOwnerID() then
		return
	end
	local r = PlayerData:getHeroLevel(q)
	self:SetStackCount(r)
end
function o.prototype.OnAbilityBuy(self, p)
	local s = self:GetParent()
	if IsValid(s) then
		local q = s:GetPlayerOwnerID()
		local t = p.cost * self.reduce * 0.01
		PlayerData:modifyGold(q, t)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
				int_gold = t,
			}
		)
		PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", t)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_24 = o
g.modifier_trait_24_buff = c()
local u = g.modifier_trait_24_buff
u.name = "modifier_trait_24_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.damage_bonus = self:GetAbilitySpecialValueFor("damage_bonus")
end
function u.prototype.OnCreated(self, p)
	if IsServer() then
		self:OnBattleStartBefore({})
	end
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function u.prototype.OnBattleStartBefore(self, p)
	local r = PlayerData:getHeroLevel(self:GetParent():GetPlayerOwnerID())
	self:SetStackCount(r)
end
function u.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function u.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return -self.damage + self:GetStackCount() * self.damage_bonus
end
u = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
g.modifier_trait_24_buff = u
return g