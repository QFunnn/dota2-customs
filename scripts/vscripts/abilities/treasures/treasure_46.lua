--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_46"
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
		["28"] = 18,
		["29"] = 19,
		["30"] = 19,
		["31"] = 19,
		["32"] = 19,
		["33"] = 19,
		["34"] = 19,
		["35"] = 19,
		["36"] = 19,
		["39"] = 27,
		["40"] = 9,
		["41"] = 30,
		["42"] = 31,
		["43"] = 30,
		["44"] = 8,
		["45"] = 7,
		["46"] = 8,
		["48"] = 8,
		["49"] = 35,
		["50"] = 42,
		["51"] = 35,
		["52"] = 42,
		["53"] = 47,
		["54"] = 48,
		["55"] = 49,
		["56"] = 47,
		["57"] = 52,
		["58"] = 53,
		["61"] = 57,
		["62"] = 58,
		["63"] = 59,
		["64"] = 59,
		["65"] = 59,
		["66"] = 59,
		["67"] = 59,
		["68"] = 59,
		["69"] = 59,
		["70"] = 59,
		["71"] = 59,
		["72"] = 68,
		["73"] = 68,
		["74"] = 68,
		["75"] = 68,
		["76"] = 68,
		["77"] = 68,
		["78"] = 68,
		["79"] = 68,
		["80"] = 68,
		["81"] = 52,
		["82"] = 79,
		["83"] = 80,
		["86"] = 84,
		["87"] = 85,
		["88"] = 85,
		["89"] = 85,
		["90"] = 85,
		["91"] = 85,
		["92"] = 85,
		["93"] = 85,
		["94"] = 85,
		["95"] = 85,
		["96"] = 94,
		["97"] = 94,
		["98"] = 94,
		["99"] = 94,
		["100"] = 94,
		["101"] = 94,
		["102"] = 94,
		["103"] = 94,
		["104"] = 94,
		["105"] = 79,
		["106"] = 105,
		["107"] = 106,
		["108"] = 107,
		["109"] = 107,
		["110"] = 106,
		["111"] = 105,
		["112"] = 111,
		["113"] = 112,
		["114"] = 113,
		["115"] = 113,
		["116"] = 113,
		["117"] = 113,
		["118"] = 113,
		["119"] = 113,
		["120"] = 111,
		["121"] = 42,
		["122"] = 35,
		["123"] = 35,
		["124"] = 35,
		["125"] = 35,
		["126"] = 35,
		["127"] = 35,
		["128"] = 35,
		["129"] = 42,
		["131"] = 42,
		["132"] = 117,
		["133"] = 124,
		["134"] = 117,
		["135"] = 124,
		["136"] = 127,
		["137"] = 128,
		["138"] = 127,
		["139"] = 131,
		["140"] = 132,
		["141"] = 131,
		["142"] = 137,
		["143"] = 138,
		["146"] = 142,
		["147"] = 143,
		["148"] = 144,
		["150"] = 137,
		["151"] = 124,
		["152"] = 117,
		["153"] = 117,
		["154"] = 117,
		["155"] = 117,
		["156"] = 117,
		["157"] = 117,
		["158"] = 117,
		["159"] = 124,
		["161"] = 124,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = "13"
local o = "r_13_max_stack"
g.treasure_46 = c()
local p = g.treasure_46
p.name = "treasure_46"
d(p, i)
function p.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	local q = self:GetCaster():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if r:getAbilityUpgradeLevel(n) >= SECT_ABILITY_LEVEL.r then
		local s = self:GetSpecialValueFor("gold")
		PlayerData:modifyGold(q, s)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
				int_gold = s,
			}
		)
		return
	end
	r:learnAbility(n, true)
end
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_46"
end
p = e({ j(nil) }, p)
g.treasure_46 = p
g.modifier_treasure_46 = c()
local t = g.modifier_treasure_46
t.name = "modifier_treasure_46"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.maxBonus = self:GetAbilitySpecialValueFor("max_bonus")
	self.preBattleStack = self:GetAbilitySpecialValueFor("pre_battle_stack")
end
function t.prototype.OnCreated(self, u)
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
	AbilityUpgrades:AddSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = "r_13_pre_stack_count",
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.preBattleStack,
		}
	)
end
function t.prototype.OnDestroy(self)
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
	AbilityUpgrades:RemoveSpecialValueUpgrade(
		q,
		{
			id = self.upgradeID,
			type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_SPECIAL_VALUE,
			description = self.upgradeID,
			ability_name = n,
			special_value_name = "r_13_pre_stack_count",
			operator = ABILITY_UPGRADES_OP.ABILITY_UPGRADES_OP_ADD,
			value = self.preBattleStack,
		}
	)
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function t.prototype.OnTraitInit(self, u)
	u.hero:RemoveModifierByName("modifier_treasure_46_buff")
	u.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_46_buff", {})
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_treasure_46 = t
g.modifier_treasure_46_buff = c()
local v = g.modifier_treasure_46_buff
v.name = "modifier_treasure_46_buff"
d(v, l)
function v.prototype.GetAbilitySpecialValue(self)
	self.preBattleStack = self:GetAbilitySpecialValueFor("pre_battle_stack")
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 } }
end
function v.prototype.OnBattleStartBefore(self)
	if not IsServer() then
		return
	end
	local w = self:GetParent():FindModifierByName("modifier_sect_attack_13_buff")
	if w ~= nil then
		w:SetStackCount(w:GetStackCount() + self.preBattleStack)
	end
end
v = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	v
)
g.modifier_treasure_46_buff = v
return g