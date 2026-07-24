--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Возвращает количество элементов таблицы
---@param inputTable table<any, any>
---@return integer
function table.count(inputTable)
	local c = 0
	for _ in pairs(inputTable) do
		c = c + 1
	end

	return c
end

function table.merge(input1, input2)
	for i,v in pairs(input2) do
		input1[i] = v
	end
	return input1
end


---Проверяет, содержится ли значение в таблице.
---Если найдено — возвращает true, иначе false
---@generic T
---@param inputTable table<any, T>?
---@param key T
---@return boolean
function table.contains(inputTable, key)
	for _, _v in pairs(inputTable or {}) do
		if _v == key then
			return true
		end
	end
	return false
end

---Возвращает первую пару (ключ, значение), удовлетворяющую условию.
---Если ни один элемент не подходит — возвращает nil.
---@generic K, V
---@param inputTable table<K, V> @Исходная таблица для поиска
---@param func fun(tbl: table<K, V>, key: K, value: V): boolean @Функция-предикат. Должна вернуть true, если элемент подходит
---@return K? key @Ключ найденного элемента или nil
---@return V? value @Значение найденного элемента или nil
function table.has_element_fit(inputTable, func)
	for key, value in pairs(inputTable) do
		if func(inputTable, key, value) then
			return key, value
		end
	end
end

---Находит первый ключ в таблице по заданному значению.
---Если значение не найдено — возвращает nil.
---@generic K, V
---@param inputTable table<K, V> @Таблица, в которой ведётся поиск
---@param key V @Значение, которое нужно найти
---@return K? @Ключ найденного значения или nil
function table.findkey(inputTable, key)
	for k, v in pairs(inputTable or {}) do
		if v == key then
			return k
		end
	end
end

---Создаёт поверхностную копию таблицы (shallow copy).
---Копирует только первый уровень без рекурсии.
---Если передано не table, возвращает значение как есть.
---@generic K, V
---@param originalTable table<K, V> @Исходная таблица
---@return table<K, V> @Новая таблица с теми же ключами и значениями
function table.shallowcopy(originalTable)
	local orig_type = type(originalTable)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(originalTable) do
			copy[orig_key] = orig_value
		end
	else
		copy = originalTable
	end
	return copy
end


---Создаёт глубокую копию таблицы (deep copy).
---Рекурсивно копирует все подтаблицы и метатаблицы.
---Если передан не table, возвращает значение как есть.
---@generic K, V
---@param originalTable table<K, V> @Исходная таблица (ключи типа K, значения типа V)
---@return table<K, V> @Новая таблица, являющаяся полной копией оригинала
function table.deepcopy(originalTable)
	local orig_type = type(originalTable)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, originalTable, nil do
			copy[table.deepcopy(orig_key)] = table.deepcopy(orig_value)
		end
		setmetatable(copy, table.deepcopy(getmetatable(originalTable)))
	else
		copy = originalTable
	end
	return copy
end


---Возвращает случайный элемент таблицы и его ключ.
---Если таблица пуста, возвращает nil.
---@generic K, V
---@param inputTable table<K, V> @Таблица, из которой выбирается случайный элемент
---@return V? value @Случайное значение из таблицы или nil
---@return K? key @Ключ выбранного элемента или nil
function table.random(inputTable)
	local keys = {}
	for k, _ in pairs(inputTable) do
		table.insert(keys, k)
	end
	if #keys == 0 then return nil, nil end
	local key = keys[RandomInt(1, #keys)]
	return inputTable[key], key
end


---Перемешивает (shuffle) содержимое таблицы, возвращая новую.
---Использует алгоритм Фишера–Йейтса. Не изменяет оригинал.
---@generic K, V
---@param tbl table<K, V>
---@return table<K, V>
function table.shuffle(tbl)
	local result = table.shallowcopy(tbl)
	for i = #result, 2, -1 do
		local j	= RandomInt(1, i)
		result[i], result[j] = result[j], result[i]
	end
	return result
end

---Возвращает случайный элемент коллекции.
---@generic K, V
---@param inputTable table<K, V>
---@param count integer
---@return table<integer, V>
function table.random_some(inputTable, count)
	local key_table = table.make_key_table(inputTable)
	key_table = table.shuffle(key_table)
	local result = {}
	for i = 1, count do
		local key = key_table[i]
		table.insert(result, inputTable[key])
	end
	return result
end

---comment
---@param inputTable table
---@param func function
---@return any
---@return any
function table.random_with_condition(inputTable, func)
	local keys = {}
	for key, value in pairs(inputTable) do
		if func(inputTable, key, value) then
			table.insert(keys, key)
		end
	end

	local key = keys[RandomInt(1, #keys)]
	return inputTable[key], key
end

---comment
---@param inputTable table
---@return any
function table.random_with_weight(inputTable)
	local weight_table = {}
	local total_weight = 0
	for k, v in pairs(inputTable) do
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
			return inputTable[key]
		end
	end
end

---Фильтрует таблицу подохдящих под условие фильтра
---@generic K, V
---@param inputTable table<K, V>
---@param condition function
---@return table<K, V>
function table.filter(inputTable, condition)
	local result = {}
	for key, value in pairs(inputTable) do
		if condition(inputTable, key, value) then
			result[key] = value
		end
	end
	return result
end

---Возвращает массив, где все ключи становятся значениями
---@generic K
---@param inputTable table<K, any>
---@return K[]
function table.make_key_table(inputTable)
	local result = {}
	for key, _ in pairs(inputTable) do
		table.insert(result, key)
	end
	return result
end

---comment
---@param t1 table
---@param t2 table
---@return boolean
function table.is_equal(t1, t2)
	for k, v in pairs(t1) do
		if t2[k] ~= v then
			return false
		end
	end
	return true
end

---Возвращает случайный ключ таблицы
---@generic K, V
---@param inputTable table<K, V>
---@return K
function table.random_key(inputTable)
	return table.random(table.make_key_table(inputTable))
end

function table.print(t)
	for k, v in pairs(t) do
		logger:Log(k, v)
	end
end

---comment
---@param inputTable table
---@return table
function table.safe_table(inputTable)
	local r = {}
	for k, v in pairs(inputTable) do
		if type(v) == "table" and k ~= "_M" then
			r[k] = table.safe_table(v)
		elseif type(v) == "string" or type(v) == "number" then
			r[k] = tostring(v)
		end
	end

	return r
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
			table.insert(result, preTabs .. "\"" .. tostring(k) .. "\"")
			table.insert(result, preTabs .. "{")
			local lines = table.to_kv_lines(v, tabCount + 1)
			for _, line in pairs(lines) do
				table.insert(result, preTabs .. line)
			end
			table.insert(result, preTabs .. "}")
		else
			table.insert(result, string.format("%s\"%s\"\t\t\"%s\"", preTabs, k, v))
		end
	end
	return result
end

function table.join(...)
	local arg = { ... }
	local r = {}
	for _, t in pairs(arg) do
		if type(t) == "table" then
			for _, v in pairs(t) do
				table.insert(r, v)
			end
		else
			-- 如果是数值，直接插入到表
			table.insert(r, t)
		end
	end

	return r
end

---
---@generic K, V
---@param originalTable table<K, V>
---@return table<K, V>
function table.reverse(originalTable)
	local result = {}
	for key, value in pairs(originalTable) do
		result[value] = key
	end
	return result
end


---Удаляет элемент из таблицы (все вхождения).
---Работает только с массивами (таблицами с индексами 1..N).
---Возвращает ту же таблицу, изменённую на месте.
---@generic T
---@param inputTable table<integer, T>
---@param item T
---@return table<integer, T>
function table.remove_item(inputTable, item)
	local i, max = 1, #inputTable
	while i <= max do
		if inputTable[i] == item then
			table.remove(inputTable, i)
			i = i - 1
			max = max - 1
		end
		i = i + 1
	end
	return inputTable
end

-- remove one item
function table.pop_back_item(tbl, item)
	for i = #tbl, 1, -1 do
		if tbl[i] == item then
			table.remove(tbl, i)
			break
		end
	end
	return tbl
end


---Возвращает таблицу, которая НЕ содержит targetKey
---@generic K, V
---@param inputTable table<K, V>
---@param targetKey K
---@return table<K, V>
function table.remove_item_bykey(inputTable, targetKey)
	local result = {}
	for key, value in pairs(inputTable) do
		if type(targetKey) == "string" and key ~= targetKey then
			result[key] = value
		end
	end
	return result
end