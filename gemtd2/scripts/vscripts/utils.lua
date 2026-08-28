--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


http = {}

function string.split(s, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	local i = 1
	for str in string.gmatch(s, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function string.replace(s, pattern, repl)
	local i, j = string.find(s, pattern, 1, true)
	if i and j then
		local ret = {}
		local start = 1
		while i and j do
			table.insert(ret, string.sub(s, start, i - 1))
			table.insert(ret, repl)
			start = j + 1
			i, j = string.find(s, pattern, start, true)
		end
		table.insert(ret, string.sub(s, start))
		return table.concat(ret)
	end
	return s
end

function table.join(t)
	local str = ""
	for _, v in pairs(t) do
		str = str .. v .. ","
	end
	return string.sub(str, 1, -2)
end

function table.copy(origin_table)
	local new_table = {}
	if origin_table ~= nil then
		for k, v in pairs(origin_table) do
			table.insert(new_table, v)
		end
		return new_table
	else
		return {}
	end
end

function table.remove_key(tbl, key)
	local max = table.maxn(tbl)
	for i = max, 1, -1 do
		if key == tbl[i] then
			table.remove(tbl, i)
			return true
		end
	end
	return false
end

function http.get(url, params, cb)
	if url == nil then
		print("HTTP FAILED! url = nil")
		return
	end

	if params == nil then
		params = {}
	end
	params["key"] = GetDedicatedServerKey("drodo")
	params["key2"] = GetDedicatedServerKeyV2("zzwdjs")
	params["key3"] = GetDedicatedServerKeyV2("xgnb")
	params["key4"] = GetDedicatedServerKeyV2("fgnb")
	params["key5"] = GetDedicatedServerKeyV2("bsl,bgbxh")

	url = url .. "?"
	for k, v in pairs(params) do
		url = url .. tostring(k) .. "=" .. tostring(v) .. "&"
	end

	print(url)

	local req = CreateHTTPRequestScriptVM("GET", url)
	req:SetHTTPRequestAbsoluteTimeoutMS(20000)

	req:Send(function(res)
		if res.StatusCode ~= 200 or not res.Body then
			print("HTTP FAILED!")
			if res.StatusCode then
				prt("StatusCode = " .. res.StatusCode)
			end
			return
		end
		local result = json.decode(res.Body)

		if cb then
			cb(result)
		end
	end)
end