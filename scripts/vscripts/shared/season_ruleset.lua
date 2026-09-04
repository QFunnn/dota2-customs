--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local ____exports = {}
--- 可由实体 `GetKeyValue` 覆盖的怪物字段。
-- 掉落池数组由掉落管理器直接读取完整行，避免把数组伪装成原生 KV 标量。
local RULESET_MONSTER_KEY_VALUE_FIELDS = {
	Custom_StatusHealth = true,
	Custom_StatusMana = true,
	Custom_AttackDamage = true,
	Custom_ArmorPhysical = true,
	Custom_MagicResistance = true,
	Custom_MovementSpeed = true,
	Custom_AttackRange = true,
	Custom_AttackRate = true,
	Custom_AttackSpeed = true,
	Custom_StatusManaRegen = true,
	Custom_StatusHealthRegen = true,
	Custom_OnAttackHealthPctDamage = true,
	Custom_DebuffResistance = true,
	Custom_StunResistance = true,
	Custom_AttackCritChance = true,
	AttackAcquisitionRange = true,
	VisionDaytimeRange = true,
	VisionNighttimeRange = true,
}
--- 已选定赛季的只读数据访问入口，服务端、客户端 Lua 与 Panorama 各自持有实例。
____exports.SeasonRuleset = __TS__Class()
local SeasonRuleset = ____exports.SeasonRuleset
SeasonRuleset.name = "SeasonRuleset"
function SeasonRuleset.prototype.____constructor(self, snapshot)
	self.activeRulesetId = snapshot.rulesetId
	self.activeTables = snapshot.tables
	self.activeLocalizationTokens = snapshot.localizationTokens or {}
	self.activeLocalizationTokensByLowerCase = {}
	for ____, ____value in ipairs(__TS__ObjectEntries(self.activeLocalizationTokens)) do
		local baseToken = ____value[1]
		local resolvedToken = ____value[2]
		self.activeLocalizationTokensByLowerCase[string.lower(baseToken)] = resolvedToken
	end
end
function SeasonRuleset.prototype.GetActiveRulesetId(self)
	return self.activeRulesetId
end
function SeasonRuleset.prototype.GetTable(self, tableName)
	return self.activeTables[tableName]
end
function SeasonRuleset.prototype.GetEquipmentConfig(self, itemName)
	local ____opt_0 = self:GetTable("ak_items_equip")
	return ____opt_0 and ____opt_0[itemName]
end
function SeasonRuleset.prototype.GetCommonItemConfig(self, itemName)
	local ____opt_2 = self:GetTable("ak_items")
	return ____opt_2 and ____opt_2[itemName]
end
function SeasonRuleset.prototype.GetPotionConfig(self, itemName)
	local ____opt_4 = self:GetTable("ak_items_potion")
	return ____opt_4 and ____opt_4[itemName]
end
function SeasonRuleset.prototype.GetFormulaConfig(self, itemName)
	local ____opt_6 = self:GetTable("ak_items_formula")
	return ____opt_6 and ____opt_6[itemName]
end
function SeasonRuleset.prototype.GetItemChangeConfig(self, itemName)
	local ____opt_8 = self:GetTable("ak_items_change")
	return ____opt_8 and ____opt_8[itemName]
end
function SeasonRuleset.prototype.GetProfessionTable(self)
	return self:GetTable("ak_profession")
end
function SeasonRuleset.prototype.GetProfessionConfig(self, rowId)
	local ____opt_10 = self:GetProfessionTable()
	return ____opt_10 and ____opt_10[rowId]
end
function SeasonRuleset.prototype.GetTagModifierRulesTable(self)
	return self:GetTable("ak_tag_modifier_rules")
end
function SeasonRuleset.prototype.GetTagModifierRuleConfig(self, ruleId)
	local ____opt_12 = self:GetTagModifierRulesTable()
	return ____opt_12 and ____opt_12[ruleId]
end
function SeasonRuleset.prototype.GetTalentTable(self)
	return self:GetTable("ak_talent")
end
function SeasonRuleset.prototype.GetTalentConfig(self, talentId)
	local ____opt_14 = self:GetTalentTable()
	return ____opt_14 and ____opt_14[talentId]
end
function SeasonRuleset.prototype.GetRoomDifficultyModeTable(self)
	return self:GetTable("ak_room_difficulty_modes")
end
function SeasonRuleset.prototype.GetRoomDifficultyModeConfig(self, modeId)
	local ____opt_16 = self:GetRoomDifficultyModeTable()
	return ____opt_16 and ____opt_16[modeId]
end
function SeasonRuleset.prototype.GetMonsterTable(self)
	return self:GetTable("ak_monster")
end
function SeasonRuleset.prototype.GetMonsterConfig(self, unitName)
	local ____opt_18 = self:GetMonsterTable()
	return ____opt_18 and ____opt_18[unitName]
end
function SeasonRuleset.prototype.ResolveMonsterKeyValue(self, unitName, key)
	if not RULESET_MONSTER_KEY_VALUE_FIELDS[key] then
		return nil
	end
	local ____opt_20 = self:GetMonsterConfig(unitName)
	local value = ____opt_20 and ____opt_20[key]
	local ____temp_22
	if type(value) == "string" or type(value) == "number" then
		____temp_22 = value
	else
		____temp_22 = nil
	end
	return ____temp_22
end
function SeasonRuleset.prototype.GetCraftItemConfig(self, itemName)
	return self:GetGemConfig(itemName)
		or self:GetEquipmentConfig(itemName)
		or self:GetPotionConfig(itemName)
		or self:GetCommonItemConfig(itemName)
end
function SeasonRuleset.prototype.GetItemConfig(self, itemName)
	return self:GetGemConfig(itemName)
		or self:GetItemChangeConfig(itemName)
		or self:GetFormulaConfig(itemName)
		or self:GetEquipmentConfig(itemName)
		or self:GetPotionConfig(itemName)
		or self:GetCommonItemConfig(itemName)
end
function SeasonRuleset.prototype.GetAbilityConfig(self, abilityName)
	local ____opt_23 = self:GetTable("ak_abilities")
	local ____temp_27 = ____opt_23 and ____opt_23[abilityName]
	if ____temp_27 == nil then
		local ____opt_25 = self:GetTable("ak_monster_abilities")
		____temp_27 = ____opt_25 and ____opt_25[abilityName]
	end
	return ____temp_27
end
function SeasonRuleset.prototype.GetGemConfig(self, itemName)
	local ____opt_28 = self:GetTable("ak_gems")
	return ____opt_28 and ____opt_28[itemName]
end
function SeasonRuleset.prototype.ResolveAbilityTopLevelValue(self, abilityName, key)
	local ____opt_30 = self:GetAbilityConfig(abilityName)
	local value = ____opt_30 and ____opt_30[key]
	local ____temp_32
	if type(value) == "string" or type(value) == "number" then
		____temp_32 = value
	else
		____temp_32 = nil
	end
	return ____temp_32
end
function SeasonRuleset.prototype.ResolveItemAbilityValues(self, itemName)
	local itemConfig = self:GetItemConfig(itemName)
	if not itemConfig then
		return { managed = false, values = {} }
	end
	return { managed = true, values = itemConfig.AbilityValues or {} }
end
function SeasonRuleset.prototype.ResolveAbilityValues(self, abilityName)
	local abilityConfig = self:GetAbilityConfig(abilityName)
	if not abilityConfig then
		return { managed = false, values = {} }
	end
	return { managed = true, values = abilityConfig.AbilityValues or {} }
end
function SeasonRuleset.prototype.ResolveLocalizationToken(self, baseToken)
	local ____baseToken_startsWith_result_33
	if __TS__StringStartsWith(baseToken, "#") then
		____baseToken_startsWith_result_33 = string.sub(baseToken, 2)
	else
		____baseToken_startsWith_result_33 = baseToken
	end
	local normalizedBaseToken = ____baseToken_startsWith_result_33
	local resolvedToken = self.activeLocalizationTokens[normalizedBaseToken]
		or self.activeLocalizationTokensByLowerCase[string.lower(normalizedBaseToken)]
	local ____temp_34
	if type(resolvedToken) == "string" and #resolvedToken > 0 then
		____temp_34 = resolvedToken
	else
		____temp_34 = normalizedBaseToken
	end
	return ____temp_34
end
return ____exports