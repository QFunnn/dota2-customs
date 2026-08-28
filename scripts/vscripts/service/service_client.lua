--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "service/service_client"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringIncludes
local f = b.__TS__StringReplace
local g = b.__TS__Number
local h = b.__TS__ArrayForEach
local i = b.__TS__DecorateLegacy
local j = b.__TS__New
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["16"] = 4,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 7,
		["22"] = 7,
		["23"] = 8,
		["24"] = 9,
		["25"] = 10,
		["28"] = 14,
		["29"] = 15,
		["30"] = 16,
		["31"] = 17,
		["32"] = 18,
		["33"] = 19,
		["36"] = 22,
		["37"] = 23,
		["38"] = 24,
		["40"] = 26,
		["41"] = 27,
		["42"] = 28,
		["43"] = 29,
		["44"] = 30,
		["46"] = 28,
		["47"] = 7,
		["48"] = 7,
		["49"] = 7,
		["50"] = 34,
		["51"] = 34,
		["52"] = 34,
		["53"] = 35,
		["54"] = 36,
		["55"] = 37,
		["58"] = 41,
		["59"] = 42,
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 51,
		["67"] = 55,
		["68"] = 56,
		["69"] = 57,
		["71"] = 59,
		["72"] = 62,
		["73"] = 63,
		["74"] = 64,
		["78"] = 46,
		["80"] = 34,
		["81"] = 34,
		["82"] = 34,
		["83"] = 75,
		["84"] = 75,
		["85"] = 75,
		["86"] = 75,
		["87"] = 75,
		["88"] = 75,
		["89"] = 75,
		["90"] = 6,
		["91"] = 77,
		["92"] = 78,
		["95"] = 79,
		["96"] = 80,
		["97"] = 81,
		["98"] = 81,
		["99"] = 81,
		["100"] = 82,
		["101"] = 82,
		["102"] = 82,
		["103"] = 82,
		["104"] = 82,
		["105"] = 83,
		["106"] = 81,
		["107"] = 81,
		["108"] = 77,
		["109"] = 87,
		["110"] = 88,
		["111"] = 89,
		["114"] = 92,
		["115"] = 93,
		["118"] = 94,
		["119"] = 94,
		["120"] = 94,
		["121"] = 94,
		["122"] = 95,
		["123"] = 96,
		["124"] = 97,
		["125"] = 98,
		["127"] = 100,
		["130"] = 87,
		["131"] = 4,
		["132"] = 112,
		["133"] = 113,
	}
)
local l = {}
local m = require("lib.tstl-utils")
local n = m.reloadable
local o = c()
o.name = "CServiceClient"
d(o, CModule)
function o.prototype.init(self, p)
	RegisterClientEvent("web_request", function(q, r)
		local s = r.url
		local t = r.type
		if s == nil or t == nil then
			return
		end
		local u = CreateHTTPRequestScriptVM(t, s)
		if r.data then
			local v = json.decode(r.data)
			for w in pairs(v) do
				local x = v[w]
				u:SetHTTPRequestGetOrPostParameter(w, x)
			end
		end
		local y = r.timeout
		if type(y) ~= "number" then
			y = 3
		end
		print(s)
		u:SetHTTPRequestAbsoluteTimeoutMS(y * 1000)
		u:Send(function(z)
			if type(z) == "table" and z.Body ~= nil then
				print(z.Body)
			end
		end)
	end, nil)
	GameEvent("client_side_event", function(self, A)
		if A.event_name == "web_request" then
			if IsInToolsMode() then
				Client:SendLocalConsoleMessage("player_region", { region = "CN" })
				return
			end
			local B = json.decode(A.event_data)
			local s = B.url
			local C = CreateHTTPRequestScriptVM(B.type, B.url)
			C:SetHTTPRequestHeaderValue("Content-Type", "application/json")
			C:SetHTTPRequestRawPostBody("application/json", B.data)
			C:Send(function(z)
				if z.StatusCode ~= 200 then
					return
				end
				local D
				if z and z.Body then
					D = json.decode(z.Body)
				end
				if D.code == 200 or D.code == 0 then
					if e(s, "/statistic/project") then
						if D.data and D.data.iso_code then
							Client:SendLocalConsoleMessage("player_region", { region = D.data.iso_code })
						end
					end
				end
			end)
		end
	end, self)
	GameEvent("cosmetic_preview_live_worldlayer", function(self, ...)
		return self:OnCosmeticPreviewLiveWorldlayer(...)
	end, self)
end
function o.prototype.InitCosmeticPreviewLiveController(self)
	if _G.cosmeticPreviewLiveControllerList then
		return
	end
	_G.cosmeticPreviewLiveControllerList = {}
	local E = Entities:FindAllByClassname("info_world_layer")
	h(E, function(q, F)
		local G = g(f(F:GetName(), "cosmetic_preview_controller_", ""))
		_G.cosmeticPreviewLiveControllerList[G] = F
	end)
end
function o.prototype.OnCosmeticPreviewLiveWorldlayer(self, A)
	if A.state == nil then
		self:InitCosmeticPreviewLiveController()
		return
	end
	local H = A.state == 1
	if _G.cosmeticPreviewLiveState == H then
		return
	end
	local B = CustomNetTables:GetTableValue("player_data", tostring(GetLocalPlayerID()))
	if B and _G.cosmeticPreviewLiveControllerList[B.index] then
		_G.cosmeticPreviewLiveState = H
		if H then
			_G.cosmeticPreviewLiveControllerList[B.index]:ShowWorldLayer()
		else
			_G.cosmeticPreviewLiveControllerList[B.index]:HideWorldLayer()
		end
	end
end
o = i({ n }, o)
if _G.ServiceClient == nil then
	_G.ServiceClient = j(o)
end
return l