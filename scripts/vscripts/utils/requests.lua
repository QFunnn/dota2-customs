--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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

function SendData(url, data, callback)
		local AUTH_KEY = GetDedicatedServerKeyV3('woda')
		local token = AUTH_KEY
		local req = CreateHTTPRequestScriptVM("POST", url)
		local encoded = json.encode(data)
		local encoded_token = json.encode(token)
		req:SetHTTPRequestGetOrPostParameter('data', encoded)
		req:SetHTTPRequestGetOrPostParameter('token', encoded_token)
		req:Send(function(res)
		if callback then
			local obj, pos, err = json.decode(res.Body)
			callback(obj)
		end
	end)
end