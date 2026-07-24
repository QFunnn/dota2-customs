--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[ utility_functions.lua ]]
---------------------------------------------------------------------------
-- Handle messages
---------------------------------------------------------------------------
function BroadcastMessage(sMessage, fDuration)
	local centerMessage = {
		message = sMessage,
		duration = fDuration
	}
	FireGameEvent("show_center_message", centerMessage)
end

function PickRandomShuffle(reference_list, bucket)
	if (#reference_list == 0) then
		return nil
	end

	if (#bucket == 0) then
		-- ran out of options, refill the bucket from the reference
		for k, v in pairs(reference_list) do
			bucket[k] = v
		end
	end

	-- pick a value from the bucket and remove it
	local pick_index = RandomInt(1, #bucket)
	local result = bucket[pick_index]
	table.remove(bucket, pick_index)
	return result
end

function shallowcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function ShuffledList(orig_list)
	local list = shallowcopy(orig_list)
	local result = {}
	local count = #list
	for i = 1, count do
		local pick = RandomInt(1, #list)
		result[#result + 1] = list[pick]
		table.remove(list, pick)
	end
	return result
end

function TableCount(t)
	local n = 0
	for _ in pairs(t) do
		n = n + 1
	end
	return n
end

-- function TableFindKey( table, val )
-- 	if table == nil then
-- 		print( "nil" )
-- 		return nil
-- 	end

-- 	for k, v in pairs( table ) do
-- 		if v == val then
-- 			return k
-- 		end
-- 	end
-- 	return nil
-- end

function CountdownTimer()
	nCOUNTDOWNTIMER = nCOUNTDOWNTIMER - 1
	local t = nCOUNTDOWNTIMER
	--print( t )
	local minutes = math.floor(t / 60)
	local seconds = t - (minutes * 60)
	local m10 = math.floor(minutes / 10)
	local m01 = minutes - (m10 * 10)
	local s10 = math.floor(seconds / 10)
	local s01 = seconds - (s10 * 10)
	local broadcast_gametimer =	{
		timer_minute_10 = m10,
		timer_minute_01 = m01,
		timer_second_10 = s10,
		timer_second_01 = s01,
	}
	CustomGameEventManager:Send_ServerToAllClients("countdown", broadcast_gametimer)
	if t <= 120 then
		CustomGameEventManager:Send_ServerToAllClients("time_remaining", broadcast_gametimer)
	end
end

function SetTimer(cmdName, time)
	print("Set the timer to: " .. time)
	nCOUNTDOWNTIMER = time
end

--将常数字符串转为Int
function ConvertConstStrToInt(sConstant)
	if sConstant == "DOTA_UNIT_CAP_NO_ATTACK" then
		return DOTA_UNIT_CAP_NO_ATTACK
	end
	if sConstant == "DOTA_UNIT_CAP_MELEE_ATTACK" then
		return DOTA_UNIT_CAP_MELEE_ATTACK
	end
	if sConstant == "DOTA_UNIT_CAP_RANGED_ATTACK" then
		return DOTA_UNIT_CAP_RANGED_ATTACK
	end
end

function PrintTable(t, indent, done)
	--print ( string.format ('PrintTable type %s', type(keys)) )
	if type(t) ~= "table" then return end

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
		if v ~= 'FDesc' then
			local value = t[v]

			if type(value) == "table" and not done[value] then
				done[value] = true
				print(string.rep("\t", indent) .. tostring(v) .. ":")
				PrintTable(value, indent + 2, done)
			elseif type(value) == "userdata" and not done[value] then
				done[value] = true
				print(string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value))
				PrintTable((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
			else
				if t.FDesc and t.FDesc[v] then
					print(string.rep("\t", indent) .. tostring(t.FDesc[v]))
				else
					print(string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value))
				end
			end
		end
	end
end


function PrintTableToString(t, indent, done)
	--print ( string.format ('PrintTable type %s', type(keys)) )

	local result = ""

	if type(t) ~= "table" then return end

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
		if v ~= 'FDesc' then
			local value = t[v]

			if type(value) == "table" and not done[value] then
				done[value] = true
				result = result .. string.rep("\t", indent) .. tostring(v) .. ":"
				result = result .. PrintTableToString(value, indent + 2, done) .. "\n"
			elseif type(value) == "userdata" and not done[value] then
				done[value] = true
				result = result .. string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value)
				result = result .. PrintTableToString((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done) .. "\n"
			else
				if t.FDesc and t.FDesc[v] then
					result = result .. string.rep("\t", indent) .. tostring(t.FDesc[v]) .. "\n"
				else
					result = result .. string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value) .. "\n"
				end
			end
		end
	end
	return result
end



function GetRandomValidPosition(vTopLeft, vDownRight)

	local minx = GetWorldMinX()
	local maxx = GetWorldMaxX()
	local miny = GetWorldMinY()
	local maxy = GetWorldMaxY()

	if vTopLeft and vDownRight then

		minx = vTopLeft.x
		maxx = vDownRight.x
		miny = vTopLeft.y
		maxy = vDownRight.y

	end

	local function getRandomPos()
		return Vector(RandomFloat(minx, maxx), RandomFloat(miny, maxy), 0)
	end
	local randomPos = getRandomPos()
	while not GridNav:CanFindPath(GameRules.vWorldCenterPos, randomPos) do
		randomPos = getRandomPos()
	end
	return randomPos
end


--以空格拆分字符串
function SpliteStr(str)
	local arr = {}
	for w in string.gmatch(str, "%S+") do
		table.insert(arr, w)
	end
	return arr
end

function string.trim(s)
	return s:match "^%s*(.-)%s*$"
end

--数组去重
function RemoveRepetition(TableData)
	local bExist = {}
	for v, k in pairs(TableData) do
		bExist[k] = true
	end
	local result = {}
	for v, k in pairs(bExist) do
		table.insert(result, v)
	end

	return result
end


function FloatKeepOneDecimal(flDecimal)
	flDecimal = flDecimal * 10

	if flDecimal % 1 >= 0.5 then
		flDecimal = math.ceil(flDecimal)
	else
		flDecimal = math.floor(flDecimal)
	end

	return flDecimal * 0.1
end


--注意此处自定义技能GetBehavior返回 userdata
--原生技能 GetBehavior返回 number
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


--移除无敌类的buff
function RemoveInvulnerableModifier(hUnit)
	if hUnit then
		if hUnit:HasModifier("modifier_ember_spirit_sleight_of_fist_caster_invulnerability") then
			hUnit:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster_invulnerability")
		end
	end
end


function ConvertToTime(value)
	local value = tonumber(value)

	if value <= 0 then
		return "00:00:00";
	else
		hours = string.format("%02.f", math.floor(value / 3600));
		mins = string.format("%02.f", math.floor(value / 60 - (hours * 60)));
		secs = string.format("%02.f", math.floor(value - hours * 3600 - mins * 60));
		if math.floor(value / 3600) == 0 then
			return mins .. ":" .. secs
		end
		return hours .. ":" .. mins .. ":" .. secs
	end
end


function IsValidAlive(entity)
	return entity and IsValidEntity(entity) and not entity:IsNull() and entity:IsAlive()
end

function ListModifiers(hUnit)

	if not hUnit then
		print('Failed to find unit to list modifiers.')
		return
	end

	print('Modifiers for ' .. hUnit:GetUnitName())

	local count = hUnit:GetModifierCount()
	for i = 0, count - 1 do
		print(hUnit:GetModifierNameByIndex(i))
		--print(hUnit:FindModifierByName(hUnit:GetModifierNameByIndex(i)):GetElapsedTime())
	end
end


function RemoveAllAbilities(hHero)
	if IsValidEntity(hHero) then
		for i = 1, hHero:GetAbilityCount() - 1 do
			local ability = hHero:GetAbilityByIndex(i - 1)
			if ability then
				hHero:RemoveAbility(ability:GetAbilityName())
			end
		end
	end
end

function ListAbilities(hHero)
	if IsValidEntity(hHero) then
		for i = 1, hHero:GetAbilityCount() - 1 do
			local hAbility = hHero:GetAbilityByIndex(i - 1)
			if hAbility and string.sub(hAbility:GetAbilityName(), 1, 14) ~= "special_bonus_" then
				local nPlaceholder = hAbility.nPlaceholder or " "
				local sHidden = hAbility:IsHidden() and "true" or "false"
				local sActivated = hAbility:IsActivated() and "true" or "false"
				print(hAbility:GetAbilityIndex() .. ":" .. hAbility:GetAbilityName() .. " nPlaceholder:" .. nPlaceholder .. " Hidden:" .. sHidden .. " Activated:" .. sActivated)
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

	for i = 0, 11 do --遍历物品
		local item = unit:GetItemInSlot(i)
		if item then
			UTIL_Remove(item)
		end
	end
end


function RemoveAllGenericHiddenAbilities(hHero)
	while (hHero:HasAbility("generic_hidden"))
	do
		hHero:RemoveAbility("generic_hidden")
	end
end

function CreateSecretKey()

	return RandomInt(1, 9999) .. "-" .. RandomInt(1, 9999) .. "-" .. RandomInt(1, 9999) .. "-" .. RandomInt(1, 9999)

end

--列举单位物品
function ListItems(hUnit)

	if not hUnit then
		print('Failed to find unit to list items.')
		return
	end

	print('Items for ' .. hUnit:GetUnitName())

	for i = 0, 20 do --遍历物品
		local hItem = hUnit:GetItemInSlot(i)
		if hItem then
			print("Item" .. i .. ": " .. hItem:GetName())
		end
	end

end


string.split = function(s, p)

	local rt = {}
	string.gsub(s, '[^' .. p .. ']+', function(w) table.insert(rt, w) end)
	return rt

end


function String2Vector(s)
	local array = string.split(s, " ")
	return Vector(array[1], array[2], array[3])
end


function EachPlayer(func)
	for i = 0, CHC_MAX_PLAYER_COUNT - 1 do
		if not PlayerResource:IsFakeClient(i) and PlayerResource:IsValidPlayerID(i) then
			if func(i) == true then
				return
			end
		end
	end
end

function RotatePosition(origin, angles, position)
	local pitch = angles.x * math.pi / 180
	local yaw   = angles.y * math.pi / 180
	local roll  = angles.z * math.pi / 180

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
-- 将c++里传出来的str形式的vector转换为vector
function StringToVector(str)
	if str == nil then return end
	local table = string.split(str, " ")
	return Vector(tonumber(table[1] or "0"), tonumber(table[2] or "0"), tonumber(table[3] or "0"))
end

function VectorToString(v)
	if v == nil then return end
	return tostring(v.x) .. " " .. tostring(v.y) .. " " .. tostring(v.z)
end
function TableOverride(mainTable, table)
	if mainTable == nil then
		return table
	end
	if table == nil or type(table) ~= "table" then
		return mainTable
	end

	for k, v in pairs(table) do
		if type(v) == "table" then
			mainTable[k] = TableOverride(mainTable[k], v)
		else
			mainTable[k] = v
		end
	end
	return mainTable
end