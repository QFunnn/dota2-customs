--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local keyName = type(ServiceSecurityKeyName) == "string" and ServiceSecurityKeyName or "chcreborn"

local function buildKey(generator)
	if type(generator) ~= "function" then
		return nil
	end

	local ok, value = pcall(generator, keyName)
	if ok and value then
		return tostring(value)
	end
end

local function applySecurityHeaders(request)
	if not request or type(request.SetHTTPRequestHeaderValue) ~= "function" then
		return
	end

	local keyV2 = buildKey(GetDedicatedServerKeyV2)
	if keyV2 then
		request:SetHTTPRequestHeaderValue("keyV2", keyV2)
	end

	local keyV3 = buildKey(GetDedicatedServerKeyV3)
	if keyV3 then
		request:SetHTTPRequestHeaderValue("keyV3", keyV3)
	end
end

return applySecurityHeaders