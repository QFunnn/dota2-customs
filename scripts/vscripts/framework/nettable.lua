--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/nettable"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["4"] = 45,
		["5"] = 46,
		["6"] = 47,
		["8"] = 49,
		["9"] = 50,
		["10"] = 50,
		["11"] = 51,
		["13"] = 50,
		["14"] = 50,
		["15"] = 50,
		["16"] = 55,
		["17"] = 56,
		["18"] = 57,
		["19"] = 58,
		["21"] = 60,
		["22"] = 61,
		["24"] = 63,
		["25"] = 64,
		["26"] = 64,
		["27"] = 66,
		["28"] = 67,
		["31"] = 70,
		["32"] = 49,
		["33"] = 72,
		["34"] = 73,
		["35"] = 74,
		["37"] = 76,
		["38"] = 72,
		["39"] = 78,
		["40"] = 79,
		["41"] = 80,
		["42"] = 82,
		["43"] = 78,
		["44"] = 84,
		["45"] = 85,
		["46"] = 87,
		["47"] = 89,
		["50"] = 93,
		["51"] = 94,
		["52"] = 84,
		["54"] = 101,
		["55"] = 102,
		["56"] = 103,
		["58"] = 105,
		["59"] = 107,
		["60"] = 108,
		["61"] = 109,
		["62"] = 110,
		["64"] = 112,
		["65"] = 113,
		["66"] = 113,
		["67"] = 114,
		["68"] = 115,
		["69"] = 115,
		["70"] = 115,
		["72"] = 117,
		["74"] = 119,
		["75"] = 105,
		["76"] = 121,
		["77"] = 122,
		["78"] = 123,
		["79"] = 124,
		["81"] = 126,
		["83"] = 129,
		["84"] = 130,
		["85"] = 131,
		["86"] = 132,
		["88"] = 134,
		["89"] = 135,
		["90"] = 135,
		["91"] = 136,
		["92"] = 138,
		["93"] = 140,
		["94"] = 142,
		["95"] = 142,
		["96"] = 142,
		["99"] = 145,
		["101"] = 147,
		["102"] = 121,
	}
)
if IsServer() then
	if CCustomNetTableManager.SetTableValue_Engine == nil then
		CCustomNetTableManager.SetTableValue_Engine = CCustomNetTableManager.SetTableValue
	end
	CCustomNetTableManager.SetTableValue = function(self, d, e, f)
		xpcall(function()
			if type(f) == "table" then
			end
		end, function(g)
			return traceback(nil, g)
		end)
		local h = self:SetTableValue_Engine(d, e, f)
		if h then
			if CCustomNetTableManager.TablesKeys == nil then
				CCustomNetTableManager.TablesKeys = {}
			end
			if CCustomNetTableManager.TablesKeys[d] == nil then
				CCustomNetTableManager.TablesKeys[d] = {}
			end
			if f ~= nil and TableFindKey(CCustomNetTableManager.TablesKeys[d], e) == nil then
				local i = CCustomNetTableManager.TablesKeys[d]
				i[#i + 1] = e
			elseif f == nil then
				ArrayRemove(CCustomNetTableManager.TablesKeys[d], e)
			end
		end
		return h
	end
	CCustomNetTableManager.GetAllTableKeys = function(self, d)
		if CCustomNetTableManager.TablesKeys ~= nil and CCustomNetTableManager.TablesKeys[d] ~= nil then
			return shallowcopy(CCustomNetTableManager.TablesKeys[d])
		end
		return {}
	end
	CCustomNetTableManager.SetSyncData = function(self, d, j, f, k)
		local e = k ~= nil and j .. tostring(k) or j
		local l = f == nil and "" or json.encode(f)
		CustomNetTables:SetTableValue(d, e, { data = l })
	end
	CCustomNetTableManager.GetSyncData = function(self, d, j, k)
		local e = k ~= nil and j .. tostring(k) or j
		local m = CustomNetTables:GetTableValue(d, e)
		if m == nil or m.data == nil then
			return
		end
		local n = json.decode(m.data)
		return n
	end
end
if IsClient() then
	if CCustomNetTableManager.GetTableValue_Engine == nil then
		CCustomNetTableManager.GetTableValue_Engine = CCustomNetTableManager.GetTableValue
	end
	CCustomNetTableManager.GetTableValue = function(self, d, e)
		local o = (d .. ",") .. tostring(e)
		local p = GetFrameCount()
		if CCustomNetTableManager.ClientNetTable == nil then
			CCustomNetTableManager.ClientNetTable = {}
		end
		local m
		local q = CCustomNetTableManager.ClientNetTable[o]
		if (q and q[p]) == nil then
			CCustomNetTableManager.ClientNetTable[o] = {}
			local r = self:GetTableValue_Engine(d, e)
			CCustomNetTableManager.ClientNetTable[o][p] = r
			m = r
		else
			m = CCustomNetTableManager.ClientNetTable[o][p]
		end
		return m
	end
	CCustomNetTableManager.GetSyncData = function(self, d, j, k)
		local e
		if k ~= nil then
			e = j .. tostring(k)
		else
			e = j
		end
		local o = (d .. ",") .. e
		local p = GetFrameCount()
		if CCustomNetTableManager.ClientNetData == nil then
			CCustomNetTableManager.ClientNetData = {}
		end
		local m
		local s = CCustomNetTableManager.ClientNetData[o]
		if (s and s[p]) == nil then
			CCustomNetTableManager.ClientNetData[o] = {}
			local n = CustomNetTables:GetTableValue(d, e)
			if n ~= nil and n.data ~= nil then
				local t = json.decode(n.data)
				CCustomNetTableManager.ClientNetData[o][p] = t
				m = t
			end
		else
			m = CCustomNetTableManager.ClientNetData[o][p]
		end
		return m
	end
end