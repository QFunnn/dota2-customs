--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function bitand(a, b)
	local result = 0
	local bitval = 1

	-- Hack to try to fix an error about comparing userdata to a number
	local a_int = tonumber(tostring(a))
	local b_int = tonumber(tostring(b))

	while a_int > 0 and b_int > 0 do
		if a_int % 2 == 1 and b_int % 2 == 1 then -- test the rightmost bits
			result = result + bitval -- set the current bit
		end
		bitval = bitval * 2 -- shift left
		a_int = math.floor(a_int / 2) -- shift right
		b_int = math.floor(b_int / 2)
	end

	return result
end

function table.count(t)
	local c = 0
	for _ in pairs(t) do
		c = c + 1
	end

	return c
end

function table.includes(tbl, value)
	for _, v in ipairs(tbl) do
		if v == value then
			return true
		end
	end
	return false
end

function table.contains(t, v)
	for _, _v in pairs(t) do
		if _v == v then
			return true
		end
	end
end

function table.has_element(t)
	return tablefirstkey(t) ~= nil
end

function table.has_value(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

function table.has_element_fit(t, func)
	for k, v in pairs(t) do
		if func(t, k, v) then
			return k, v
		end
	end
end

function table.findkey(t, v)
	for k, _v in pairs(t) do
		if _v == v then
			return k
		end
	end
end

function table.shallowcopy(orig)
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

function table.deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[table.deepcopy(orig_key)] = table.deepcopy(orig_value)
		end
		setmetatable(copy, table.deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function table.random(t)
	local keys = {}
	if type(t) ~= "table" then
		print("Value", t, "NotTable")
	end
	for k, _ in pairs(t) do
		table.insert(keys, k)
	end
	local key = keys[RandomInt(1, #keys)]
	return t[key], key
end

function table.shuffle(tbl)
	-- НЕ ДОЛЖНА СОДЕРЖАТЬ ТАБЛИЦЫ В ЗНАЧЕНИЯХ
	local t = table.shallowcopy(tbl)
	for i = #t, 2, -1 do
		local j = RandomInt(1, i)
		t[i], t[j] = t[j], t[i]
	end
	return t
end

function table.random_some(t, count)
	local key_table = table.make_key_table(t)
	key_table = table.shuffle(key_table)
	local r = {}
	for i = 1, count do
		local key = key_table[i]
		table.insert(r, t[key])
	end
	return r
end

-- СЛУЧАЙНЫЙ ВЫБОР ЭЛЕМЕНТА С УСЛОВИЕМ ПЕРЕДАВАЕМОЙ ФУНКЦИИ
function table.random_with_condition(t, func)
	local keys = {}
	for k, v in pairs(t) do
		if func(t, k, v) then
			table.insert(keys, k)
		end
	end

	local key = keys[RandomInt(1, #keys)]
	return t[key], key
end

-- 带权重的选择某个元素
-- 权重表达的几种方式，获取顺序也是这个顺序
-- 1. GetWeight函数
-- 2. Weight变量
-- 3. 第二个元素
-- 4. 如果没有定义，默认为0

--КАКАЯ-ТО ЕБАНУТАЯ ХУЙНЯ, НУ ЕЕ НАХУЙ
function table.random_with_weight(t)
	local weight_table = {}
	local total_weight = 0
	for k, v in pairs(t) do
		local w
		if v.GetWeight then
			w = v:GetWeight()
		else
			w = v.Weight or v[2] or 0
		end
		total_weight = total_weight + w
		table.insert(weight_table, { key = k, total_weight = total_weight })
	end

	local randomValue = RandomFloat(0, total_weight)
	for i = 1, #weight_table do
		if weight_table[i].total_weight >= randomValue then
			local key = weight_table[i].key
			return t[key]
		end
	end
end

--ФИЛЬТРАЦИЯ ТАБЛИЦЫ С УСЛОВИЕМ ПЕРЕДАВАЕМОЙ ФУНКЦИИ
function table.filter(t, condition)
	local r = {}
	for k, v in pairs(t) do
		if condition(t, k, v) then
			r[k] = v
		end
	end
	return r
end

-- ВОЗВРАТ ВСЕХ КЛЮЧЕЙ В ТАБЛИЦЕ
function table.make_key_table(t)
	local r = {}
	for k, _ in pairs(t) do
		table.insert(r, k)
	end
	return r
end

-- СРАВНЕНИЕ ТАБЛИЦ
function table.is_equal(t1, t2)
	for k, v in pairs(t1) do
		if t2[k] ~= v then
			return false
		end
	end
	return true
end

function table.random_key(t)
	return table.random(table.make_key_table(t))
end

function table.print(t)
	--print( "PrintTable( t, indent ): " )

	if type(t) ~= "table" then
		print("Value,", t, "Nottable")
		return
	end

	if indent == nil then
		indent = "   "
	end

	for k, v in pairs(t) do
		if type(v) == "table" then
			if v ~= t then
				print(indent .. tostring(k) .. ":\n" .. indent .. "{")
				table.print(v, indent .. "  ")
				print(indent .. "}")
			end
		else
			print(indent .. tostring(k) .. ":" .. tostring(v))
		end
	end
end

--ПЕРЕСОХРАНИТЬ ТАБЛИЦУ ТОЛЬКО С ЧИСЛОВЫМИ КЛЮЧАМИ
--ПРЕВРАТИТЬ ВСЕ ЗНАЧЕНИЯ В СТРОКИ
function table.safe_table(t)
	local r = {}
	for k, v in pairs(t) do
		if type(v) == "table" and k ~= "_M" then --ЦИКЛЫ ПРИВОДЯЩИЕ В ТУПИК
			r[k] = table.safe_table(v)
		elseif type(v) == "string" or type(v) == "number" then
			r[k] = tostring(v)
		end
	end

	return r
end

---СОХРАНИТЬ ТАБЛИЦУ В ВИДЕ КВ ФАЙЛА
---@param tbl table ЭКСПОРТИРУЕМАЯ ТАБЛИЦА
---@param filePath string ПУТЬ К ФАЙЛУ
---@param headerName string ЗАГОЛОВОК
function table.save_as_kv_file(tbl, filePath, headerName, utf16)
	local file = io.open(filePath, "w")
	if utf16 then
		file:write(utf8_to_utf16le('"' .. (headerName or "unknown_header") .. '"\n'))
		file:write(utf8_to_utf16le("{\n"))
		for _, line in pairs(table.to_kv_lines(tbl, 1)) do
			file:write(utf8_to_utf16le(line .. "\n"))
		end
		file:write(utf8_to_utf16le("}\n"))
	else
		file:write('"' .. (headerName or "unknown_header") .. '"\n')
		file:write("{\n")
		for _, line in pairs(table.to_kv_lines(tbl, 1)) do
			file:write(line .. "\n")
		end
		file:write("}\n")
	end

	file:flush()
	file:close()
end

function table.to_kv_lines(tbl, tabCount)
	tabCount = tabCount or 0
	local result = {}
	local preTabs = ""
	for i = 1, tabCount do
		preTabs = preTabs .. "\t"
	end
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			table.insert(result, preTabs .. '"' .. tostring(k) .. '"')
			table.insert(result, preTabs .. "{")
			local lines = table.to_kv_lines(v, tabCount + 1)
			for _, line in pairs(lines) do
				table.insert(result, preTabs .. line)
			end
			table.insert(result, preTabs .. "}")
		else
			table.insert(result, string.format('%s"%s"\t\t"%s"', preTabs, k, v))
		end
	end
	return result
end

--ДОПОЛНИТЬ ТАБЛИЦУ ЗНАЧЕНИЯМИ ИЗ ДРУГОЙ ТАБЛИЦЫ
--ЕСЛИ ПЕРЕДАННЫЕ ДАЙННЫЕ НЕ ТАБЛИЦА ВСТАВИТЬ ЗНАЧЕНИЕ
function table.join(...)
	local arg = { ... }
	local r = {}
	for _, t in pairs(arg) do
		if type(t) == "table" then
			for _, v in pairs(t) do
				table.insert(r, v)
			end
		else
			table.insert(r, t)
		end
	end

	return r
end

-- ПОМЕНЯТЬ МЕСТАМИ КЛЮЧИ И ЗНАЧЕНИЯ ТАБЛИЦЫ
function table.reverse(tbl)
	local t = {}
	for k, v in pairs(tbl) do
		t[v] = k
	end
	return t
end

-- УДАЛЯЕТ ИЗ ТАБЛИЦЫ ОПРЕДЕЛННОЕ ЗНАЧЕНИЕ
function table.remove_item(tbl, item)
	local i, max = 1, #tbl
	while i <= max do
		if tbl[i] == item then
			table.remove(tbl, i)
			i = i - 1
			max = max - 1
		end
		i = i + 1
	end
	return tbl
end

function table.remove_key(tbl, key)
	local t = {}
	for k, v in pairs(tbl) do
		if k ~= key then
			t[k] = v
		end
	end
	return t
end

function table.make_lookup_table(tbl)
	local new_tbl = {}
	for _, v in pairs(tbl) do
		new_tbl[v] = true
	end
	return new_tbl
end