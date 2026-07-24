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

---@param name string
---@return number
function CDOTA_Buff:GetAbilitySpecialValueFor(name)
	if self:IsNull() or not IsValid(self:GetAbility()) then
		return self[name] or 0
	end
	return self:GetAbility():GetSpecialValueFor(name)
end

---@param name string
---@param level integer
---@return number
function CDOTA_Buff:GetAbilityLevelSpecialValueFor(name, level)
	if self:IsNull() or not IsValid(self:GetAbility()) then
		return self[name] or 0
	end
	return self:GetAbility():GetLevelSpecialValueFor(name, level)
end