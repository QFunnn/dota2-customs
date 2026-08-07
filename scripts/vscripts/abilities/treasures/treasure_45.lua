--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_45"
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
		["16"] = 7,
		["17"] = 8,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["24"] = 14,
		["25"] = 15,
		["26"] = 16,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["33"] = 21,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 22,
		["38"] = 22,
		["39"] = 22,
		["40"] = 22,
		["41"] = 22,
		["42"] = 9,
		["43"] = 29,
		["44"] = 30,
		["45"] = 29,
		["46"] = 8,
		["47"] = 7,
		["48"] = 8,
		["50"] = 8,
		["51"] = 34,
		["52"] = 41,
		["53"] = 34,
		["54"] = 41,
		["55"] = 45,
		["56"] = 46,
		["57"] = 45,
		["58"] = 49,
		["59"] = 50,
		["62"] = 54,
		["63"] = 55,
		["64"] = 56,
		["65"] = 56,
		["66"] = 56,
		["67"] = 56,
		["68"] = 56,
		["69"] = 56,
		["70"] = 56,
		["71"] = 56,
		["72"] = 56,
		["73"] = 49,
		["74"] = 67,
		["75"] = 68,
		["78"] = 72,
		["79"] = 73,
		["80"] = 73,
		["81"] = 73,
		["82"] = 73,
		["83"] = 73,
		["84"] = 73,
		["85"] = 73,
		["86"] = 73,
		["87"] = 73,
		["88"] = 67,
		["89"] = 84,
		["90"] = 85,
		["91"] = 86,
		["92"] = 86,
		["93"] = 85,
		["94"] = 84,
		["95"] = 90,
		["96"] = 91,
		["97"] = 92,
		["98"] = 92,
		["99"] = 92,
		["100"] = 92,
		["101"] = 92,
		["102"] = 92,
		["103"] = 90,
		["104"] = 41,
		["105"] = 34,
		["106"] = 34,
		["107"] = 34,
		["108"] = 34,
		["109"] = 34,
		["110"] = 34,
		["111"] = 34,
		["112"] = 41,
		["114"] = 41,
		["115"] = 96,
		["116"] = 103,
		["117"] = 96,
		["118"] = 103,
		["119"] = 106,
		["120"] = 107,
		["121"] = 106,
		["122"] = 110,
		["123"] = 111,
		["124"] = 110,
		["125"] = 116,
		["126"] = 117,
		["129"] = 121,
		["130"] = 122,
		["131"] = 123,
		["133"] = 116,
		["134"] = 103,
		["135"] = 96,
		["136"] = 96,
		["137"] = 96,
		["138"] = 96,
		["139"] = 96,
		["140"] = 96,
		["141"] = 96,
		["142"] = 103,
		["144"] = 103,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "15"
local o = "r_15_max_stack"
g.treasure_45 = c()
local p = g.treasure_45
p.name = "treasure_45"
d(p, i)
function p.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local q = self:GetCaster():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if r:getAbilityUpgradeLevel(n) >= SECT_ABILITY_LEVEL.r then
		PlayerData:modifyGold(q, self:GetSpecialValueFor("gold"))
		return
	end
	r:learnAbility(n, true)
	Notification:combatToPlayer(
		q,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[n].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. n,
		}
	)
end
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_45"
end
p = e({ j(nil) }, p)
g.treasure_45 = p
g.modifier_treasure_45 = c()
local s = g.modifier_treasure_45
s.name = "modifier_treasure_45"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.maxBonus = self:GetAbilitySpecialValueFor("max_bonus")
end
function s.prototype.OnCreated(self, t)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	self.upgradeID = tostring(self:GetAbility():entindex())
	AbilityUpgrades:AddSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = o,
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.maxBonus,
		}
	)
end
function s.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	AbilityUpgrades:RemoveSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = o,
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.maxBonus,
		}
	)
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function s.prototype.OnTraitInit(self, t)
	t.hero:RemoveModifierByName("modifier_treasure_45_buff")
	t.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_45_buff", {})
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_treasure_45 = s
g.modifier_treasure_45_buff = c()
local u = g.modifier_treasure_45_buff
u.name = "modifier_treasure_45_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.preBattleStack = self:GetAbilitySpecialValueFor("pre_battle_stack")
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function u.prototype.OnBattleStartBefore(self)
	if not IsServer() then
		return
	end
	local v = self:GetParent():FindModifierByName("modifier_sect_attack_15_buff")
	if v ~= nil then
		v:SetStackCount(v:GetStackCount() + self.preBattleStack)
	end
end
u = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	u
)
g.modifier_treasure_45_buff = u
return g