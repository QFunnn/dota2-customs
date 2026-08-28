--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function RequestData(url, callback)
	local req = CreateHTTPRequestScriptVM("GET", url)
	req:Send(function(res)
		if res.StatusCode ~= 200 then
			return
		end
		if callback then
			local obj, pos, err = json.decode(res.Body)
			callback(obj)
		end
	end)
end

function GetWodaServerKey()
	local key = GetDedicatedServerKeyV3("woda")
	if IsInToolsMode() then
		local key_data = LoadKeyValues("scripts/woda_key.txt")
		if key_data and key_data["CustomDedicatedKey"] then
			key = key_data["CustomDedicatedKey"]
		end
	end
	return key
end

function SendData(url, data, callback)
	local AUTH_KEY = GetWodaServerKey()
	local token = AUTH_KEY
	local req = CreateHTTPRequestScriptVM("POST", url)
	local encoded = json.encode(data)
	local encoded_token = json.encode(token)
	req:SetHTTPRequestGetOrPostParameter("data", encoded)
	req:SetHTTPRequestGetOrPostParameter("token", encoded_token)
	req:Send(function(res)
		if callback then
			local obj, pos, err = json.decode(res.Body)
			callback(obj)
		end
	end)
end