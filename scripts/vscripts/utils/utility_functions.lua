--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- Защитная обёртка над UnloadSpawnGroupByHandle: не выгружает один handle дважды
-- (иначе спам "AsyncUnloadSpawnGroup -- no such spawn group" у клиентов/зрителей)
-- и никогда не трогает активную spawn group карты.
_G.UnloadedSpawnGroups = _G.UnloadedSpawnGroups or {}

---@param handle integer|nil
---@return boolean unloaded
function SafeUnloadSpawnGroup(handle)
	if handle == nil or handle == 0 then
		return false
	end
	if _G.UnloadedSpawnGroups[handle] then
		return false
	end

	if GetActiveSpawnGroupHandle ~= nil then
		local ok, activeHandle = pcall(GetActiveSpawnGroupHandle)
		if ok and activeHandle == handle then
			return false
		end
	end

	_G.UnloadedSpawnGroups[handle] = true
	UnloadSpawnGroupByHandle(handle)
	return true
end

function shallowcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function PrintTable(t, indent, done)
	if type(t) ~= "table" then
		return
	end

	done = done or {}
	done[t] = true
	indent = indent or 0

	local l = {}
	for k, v in pairs(t) do
		table.insert(l, k)
	end

	table.sort(l)
	for k, v in ipairs(l) do
		-- Ignore FDesc
		if v ~= "FDesc" then
			local value = t[v]

			if type(value) == "table" and not done[value] then
				done[value] = true
				logger:Log(string.rep("\t", indent) .. tostring(v) .. ":")
				PrintTable(value, indent + 2, done)
			elseif type(value) == "userdata" and not done[value] then
				done[value] = true
				logger:Log(string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value))
				PrintTable(
					(getmetatable(value) and getmetatable(value).__index) or getmetatable(value),
					indent + 2,
					done
				)
			else
				if t.FDesc and t.FDesc[v] then
					logger:Log(string.rep("\t", indent) .. tostring(t.FDesc[v]))
				else
					logger:Log(string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value))
				end
			end
		end
	end
end

function ContainsValue(sum, nValue)
	if type(sum) == "userdata" then
		sum = tonumber(tostring(sum))
	end

	if bit:_and(sum, nValue) == nValue then
		return true
	else
		return false
	end
end

function ListModifiers(hUnit)
	if not hUnit then
		logger:Log("Failed to find unit to list modifiers.")
		return
	end

	logger:Log("Modifiers for " .. hUnit:GetUnitName())

	local count = hUnit:GetModifierCount()
	for i = 0, count - 1 do
		logger:Log(hUnit:GetModifierNameByIndex(i))
		--print(hUnit:FindModifierByName(hUnit:GetModifierNameByIndex(i)):GetElapsedTime())
	end
end

function ListAbilities(hHero)
	if IsValidEntity(hHero) then
		for i = 1, hHero:GetAbilityCount() - 1 do
			local hAbility = hHero:GetAbilityByIndex(i - 1)
			if hAbility and string.sub(hAbility:GetAbilityName(), 1, 14) ~= "special_bonus_" then
				local placeholderIndex = hAbility.placeholderIndex or " "
				local sHidden = hAbility:IsHidden() and "true" or "false"
				local sActivated = hAbility:IsActivated() and "true" or "false"
				logger:Log(
					hAbility:GetAbilityIndex()
						.. ":"
						.. hAbility:GetAbilityName()
						.. " placeholderIndex:"
						.. placeholderIndex
						.. " Hidden:"
						.. sHidden
						.. " Activated:"
						.. sActivated
				)
			end
		end
	end
end

function UnhideAbilities(hHero)
	if IsValidEntity(hHero) then
		for i = 1, hHero:GetAbilityCount() do
			local hAbility = hHero:GetAbilityByIndex(i - 1)
			if hAbility and string.sub(hAbility:GetAbilityName(), 1, 14) ~= "special_bonus_" then
				hAbility:SetHidden(false)
			end
		end
	end
end

function RemoveAllItems(unit)
	for i = 0, 11 do --перебираем предметы
		local item = unit:GetItemInSlot(i)
		if item then
			UTIL_Remove(item)
		end
	end
end

---@return string
function CreateSecretKey()
	return RandomInt(1, 9999) .. "-" .. RandomInt(1, 9999) .. "-" .. RandomInt(1, 9999) .. "-" .. RandomInt(1, 9999)
end

function ListItems(hUnit)
	if not hUnit then
		logger:Log("Failed to find unit to list items.")
		return
	end

	logger:Log("Items for " .. hUnit:GetUnitName())

	for i = 0, 20 do
		local hItem = hUnit:GetItemInSlot(i)
		if hItem then
			logger:Log("Item" .. i .. ": " .. hItem:GetName())
		end
	end
end

---
---@generic K, V
---@param inputTable table<K, V>
---@param value V
---@return V?
function TableFindKey(inputTable, value)
	if inputTable == nil then
		return nil
	end

	for _k, _v in pairs(inputTable) do
		if value == _v then
			return _k
		end
	end
	return nil
end

if IsServer() then
	if not CDOTA_Item.SpendCharge_Original then
		CDOTA_Item.SpendCharge_Original = CDOTA_Item.SpendCharge

		function CDOTA_Item:SpendCharge(delay)
			delay = delay or 0

			local ok, err = pcall(function()
				self:SpendCharge_Original(delay)
			end)

			if not ok then
				logger:Log("[SpendCharge ERROR]", self:GetName(), err)
			end
		end

		logger:Log("CDOTA_Item:SpendCharge() overridden successfully")
	end

	-- if not OnChargeCountChanged_Engine then
	-- 	local OnChargeCountChanged_Engine = CDOTA_Item_Lua.OnChargeCountChanged
	-- 	function CDOTA_Item_Lua:OnChargeCountChanged(what)
	-- 		OnChargeCountChanged_Engine(self)
	-- 	end
	-- end
end

local BaseEntity = CBaseEntity

Hashtables = Hashtables or {}
function CreateHashtable(table)
	local new_hastable = {}
	local index = 1
	while Hashtables[index] ~= nil do
		index = index + 1
	end
	if table ~= nil then
		Hashtables[index] = table
	else
		Hashtables[index] = new_hastable
	end

	return Hashtables[index], index
end

function RemoveHashtable(hastable_or_index)
	local index
	if type(hastable_or_index) == "number" then
		index = hastable_or_index
	else
		index = GetHashtableIndex(hastable_or_index) or 0
	end
	Hashtables[index] = nil
end

function GetHashtableIndex(hastable)
	if hastable == nil then
		return nil
	end
	for index, h in pairs(Hashtables) do
		if h == hastable then
			return index
		end
	end
	return nil
end

function GetHashtableByIndex(index)
	return Hashtables[index]
end

function HashtableCount()
	local n = 0
	for index, h in pairs(Hashtables) do
		n = n + 1
	end
	return n
end

function ArrayRemove(t, v)
	if t == nil then
		return
	end
	for i = #t, 1, -1 do
		if t[i] == v then
			table.remove(t, i)
		end
	end
end

function toboolean(value)
	if not value then
		return value
	end
	local val_type = type(value)
	if val_type == "boolean" then
		return value
	end
	if val_type == "number" then
		return value ~= 0
	end
	return true
end

function AddModifierEvents(iModifierEvent, hModifier, hSource, hTarget)
	if IsValid(hTarget) or IsValid(hSource) then
		if IsValid(hSource) then
			if hSource.tSourceModifierEvents == nil then
				hSource.tSourceModifierEvents = {}
			end
			if hSource.tSourceModifierEvents[iModifierEvent] == nil then
				hSource.tSourceModifierEvents[iModifierEvent] = {}
			end

			table.insert(hSource.tSourceModifierEvents[iModifierEvent], hModifier)
		end
		if IsValid(hTarget) then
			if hTarget.tTargetModifierEvents == nil then
				hTarget.tTargetModifierEvents = {}
			end
			if hTarget.tTargetModifierEvents[iModifierEvent] == nil then
				hTarget.tTargetModifierEvents[iModifierEvent] = {}
			end

			table.insert(hTarget.tTargetModifierEvents[iModifierEvent], hModifier)
		end
	else
		if _G.tModifierEvents == nil then
			_G.tModifierEvents = {}
		end
		if tModifierEvents[iModifierEvent] == nil then
			tModifierEvents[iModifierEvent] = {}
		end

		table.insert(tModifierEvents[iModifierEvent], hModifier)
	end
end

function RemoveModifierEvents(iModifierEvent, hModifier, hSource, hTarget)
	if IsValid(hTarget) or IsValid(hSource) then
		if IsValid(hSource) then
			if hSource.tSourceModifierEvents == nil then
				hSource.tSourceModifierEvents = {}
			end
			if hSource.tSourceModifierEvents[iModifierEvent] == nil then
				hSource.tSourceModifierEvents[iModifierEvent] = {}
			end

			ArrayRemove(hSource.tSourceModifierEvents[iModifierEvent], hModifier)
		end
		if IsValid(hTarget) then
			if hTarget.tTargetModifierEvents == nil then
				hTarget.tTargetModifierEvents = {}
			end
			if hTarget.tTargetModifierEvents[iModifierEvent] == nil then
				hTarget.tTargetModifierEvents[iModifierEvent] = {}
			end

			ArrayRemove(hTarget.tTargetModifierEvents[iModifierEvent], hModifier)
		end
	else
		if _G.tModifierEvents == nil then
			_G.tModifierEvents = {}
		end
		if tModifierEvents[iModifierEvent] == nil then
			tModifierEvents[iModifierEvent] = {}
		end

		ArrayRemove(tModifierEvents[iModifierEvent], hModifier)
	end
end

function IsVector(v)
	if v.x == nil then
		return false
	end
	if v.y == nil then
		return false
	end
	if v.z == nil then
		return false
	end
	if type(v.x) ~= "number" then
		return false
	end
	if type(v.y) ~= "number" then
		return false
	end
	if type(v.z) ~= "number" then
		return false
	end
	return true
end

function DamageFlagFilter(flag, value)
	return bit.band(value, flag) == flag
end

function ReductionToArmor(fReductionPct)
	fReductionPct = math.min(fReductionPct, 99.9)
	return fReductionPct / (6 - 0.06 * fReductionPct)
end

function Rotation2D(vVector, radian)
	local fLength2D = vVector:Length2D()
	local vUnitVector2D = vVector / fLength2D
	local fCos = math.cos(radian)
	local fSin = math.sin(radian)
	return Vector(
		vUnitVector2D.x * fCos - vUnitVector2D.y * fSin,
		vUnitVector2D.x * fSin + vUnitVector2D.y * fCos,
		vUnitVector2D.z
	) * fLength2D
end

function RotatePosition(origin, angles, position)
	local pitch = angles.x * math.pi / 180
	local yaw = angles.y * math.pi / 180
	local roll = angles.z * math.pi / 180

	local sp = math.sin(pitch)
	local cp = math.cos(pitch)
	local sy = math.sin(yaw)
	local cy = math.cos(yaw)
	local sr = math.sin(roll)
	local cr = math.cos(roll)

	local ox = position.x - origin.x
	local oy = position.y - origin.y
	local oz = position.z - origin.z

	local m00 = cp * cy
	local m01 = sr * sp * cy - cr * sy
	local m02 = cr * sp * cy + sr * sy

	local m10 = cp * sy
	local m11 = sr * sp * sy + cr * cy
	local m12 = cr * sp * sy - sr * cy

	local m20 = -sp
	local m21 = sr * cp
	local m22 = cr * cp

	local rx = m00 * ox + m01 * oy + m02 * oz
	local ry = m10 * ox + m11 * oy + m12 * oz
	local rz = m20 * ox + m21 * oy + m22 * oz

	return Vector(origin.x + rx, origin.y + ry, origin.z + rz)
end