--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


C_DOTA_Ability_Lua.ABILITY_KV = LoadKeyValues("scripts/npc/npc_abilities.txt")
table.merge(C_DOTA_Ability_Lua.ABILITY_KV, LoadKeyValues("scripts/npc/npc_abilities_custom.txt"))

function C_DOTA_Ability_Lua:GetUpgradeValueFor(value_name)
	if self.upgrade_values and self.upgrade_values[value_name] then return self.upgrade_values[value_name] end

	if not self.upgrade_name then
		local name = self:GetAbilityName()
		self.upgrade_name = name:gsub("modifier_", ""):gsub("_upgrade", "")
	end

	if not GENERIC_UPGRADES_DATA[self.upgrade_name] then return end

	self.upgrade_values = self.upgrade_values or {}

	self.upgrade_values[value_name] = GENERIC_UPGRADES_DATA[self.upgrade_name]["specials"][value_name]
	return self.upgrade_values[value_name]
end

-- function C_DOTA_Ability_Lua:GetKeyValueNoOverride(value_name, level)
function GetKeyValueNoOverride(ability, value_name, level)
	if not level then level = ability:GetLevel() end
	level = level + 1 -- level starts at 0, need to increment to work properly

	if C_DOTA_Ability_Lua.ABILITY_KV[ability:GetAbilityName()] then
		if C_DOTA_Ability_Lua.ABILITY_KV[ability:GetAbilityName()][value_name] and level then
			local s = string.split(C_DOTA_Ability_Lua.ABILITY_KV[ability:GetAbilityName()][value_name])

			if s[level] then
				return tonumber(s[level]) or s[level] -- Try to cast to number
			else
				return tonumber(s[#s]) or s[#s]
			end
		else
			return C_DOTA_Ability_Lua.ABILITY_KV[ability:GetAbilityName()][value_name]
		end
	else
		print("No kv found for ability:", ability:GetAbilityName())
		return
	end
end

-- Talent helpers
function C_DOTA_BaseNPC:HasTalent(talent_name)
	if not self or self:IsNull() then return end

	local talent = self:FindAbilityByName(talent_name)
	if talent and talent:GetLevel() > 0 then return true end
end


function C_DOTA_BaseNPC:FindTalentValue(talent_name, key)
	if self:HasTalent(talent_name) then
		local value_name = key or "value"
		return self:FindAbilityByName(talent_name):GetSpecialValueFor(value_name)
	end
	return 0
end


function CDOTA_Modifier_Lua:CheckUniqueValue(value, tSuperiorModifierNames)
	local hParent = self:GetParent()
	if tSuperiorModifierNames then
		for _,sSuperiorMod in pairs(tSuperiorModifierNames) do
			if hParent:HasModifier(sSuperiorMod) then
				return 0
			end
		end
	end
	if bit.band(self:GetAttributes(), MODIFIER_ATTRIBUTE_MULTIPLE) == MODIFIER_ATTRIBUTE_MULTIPLE then
		if self:GetStackCount() == 1 then
			return 0
		end
	end
	return value
end

function CDOTA_Modifier_Lua:CheckUnique(bCreated)
	return nil
end