--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if web == nil then
	web = class({})
end

function web:init()
	web:start_game()
end

function web:start_game()
	print("hello")
	Shop:get_db_info()
	print("hello")
end

--[[
	Хелпер-функция для упрощения отправки HTTP-запросов
	@param path string - Путь к endpoint (например: "/api_get_casino_data/")
	@param method string - Тип запроса: "GET" или "POST"
	@param data table|nil - Данные для отправки (таблица, будет закодирована в JSON)
	@param callback function - Функция обратного вызова, принимает response объект
	@return HTTPRequest объект
]]
function web:SendRequest(path, method, data, callback)
	if not _G.host or not _G.key then
		print("[Web] Ошибка: _G.host или _G.key не установлены")
		if callback then
			callback({
				StatusCode = 500,
				Body = nil,
			})
		end
		return nil
	end

	method = method or "GET"
	method = string.upper(method)

	-- Формируем базовый URL с key
	local url = _G.host .. path

	-- Для GET запросов добавляем параметры в URL
	if method == "GET" and data then
		local params = {}
		for k, v in pairs(data) do
			table.insert(params, tostring(k) .. "=" .. tostring(v))
		end
		if #params > 0 then
			local queryString = table.concat(params, "&")
			if string.find(path, "?") then
				url = url .. "&" .. queryString
			else
				url = url .. "?" .. queryString
			end
		end
	end

	-- Добавляем key в URL
	if string.find(url, "?") then
		url = url .. "&key=" .. _G.key
	else
		url = url .. "?key=" .. _G.key
	end

	-- Создаем запрос
	local req = CreateHTTPRequestScriptVM(method, url)

	-- Устанавливаем максимальный таймаут
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)

	-- Для POST запросов кодируем данные в JSON и отправляем как параметр 'arr'
	if method == "POST" and data then
		local arr = json.encode(data)
		req:SetHTTPRequestGetOrPostParameter("arr", arr)
	end

	-- Отправляем запрос
	if callback then
		req:Send(callback)
	else
		req:Send(function(res)
			print("[Web] Ответ сервера (" .. method .. " " .. path .. "): " .. tostring(res.StatusCode))
			if res.Body then
				print("[Web] Тело ответа: " .. res.Body)
			end
		end)
	end

	return req
end