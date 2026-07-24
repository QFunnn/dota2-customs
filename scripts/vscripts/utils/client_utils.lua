--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function IsValid(h)
	return h ~= nil and not h:IsNull()
end

-- Has Aghanim's Shard
function C_DOTA_BaseNPC:HasShard()
	return self:HasModifier("modifier_item_aghanims_shard")
end

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

function C_DOTA_BaseNPC:IsDueling()
	return self:HasModifier("modifier_hero_dueling")
end

---获取技能当前等级的键值
---@param szName 键名
---@return number
function CDOTA_Buff:GetAbilitySpecialValueFor(szName)
	if self:IsNull() or not IsValid(self:GetAbility()) then
		return self[szName] or 0
	end
	return self:GetAbility():GetSpecialValueFor(szName)
end

---获取技能特定等级的键值
---@param szName 键名
---@param iLevel 技能等级
---@return number
function CDOTA_Buff:GetAbilityLevelSpecialValueFor(szName, iLevel)
	if self:IsNull() or not IsValid(self:GetAbility()) then
		return self[szName] or 0
	end
	return self:GetAbility():GetLevelSpecialValueFor(szName, iLevel)
end

---判断单位是否是Roshan
function C_DOTA_BaseNPC:IsRoshan()
	if IsValid(self) and self.GetUnitName and type(self.GetUnitName) == "function" and self:GetUnitName() == "npc_dota_roshan" then
		return true
	else
		return false
	end
end