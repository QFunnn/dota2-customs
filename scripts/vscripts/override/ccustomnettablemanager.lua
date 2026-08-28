--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "override/CCustomNetTableManager"
if IsServer() then
	if CCustomNetTableManager.SetTableValue_Engine == nil then
		CCustomNetTableManager.SetTableValue_Engine = CCustomNetTableManager.SetTableValue
	end
	CCustomNetTableManager.SetTableValue = function(self, b, c, d)
		xpcall(function()
			if type(d) == "table" then
			end
		end, traceback)
		local e = self:SetTableValue_Engine(b, c, d)
		if e then
			if CCustomNetTableManager.TablesKeys == nil then
				CCustomNetTableManager.TablesKeys = {}
			end
			if CCustomNetTableManager.TablesKeys[b] == nil then
				CCustomNetTableManager.TablesKeys[b] = {}
			end
			if d ~= nil and TableFindKey(CCustomNetTableManager.TablesKeys[b], c) == nil then
				local f = CCustomNetTableManager.TablesKeys[b]
				f[#f + 1] = c
			elseif d == nil then
				ArrayRemove(CCustomNetTableManager.TablesKeys[b], c)
			end
		end
		return e
	end
	CCustomNetTableManager.GetAllTableKeys = function(self, b)
		if CCustomNetTableManager.TablesKeys ~= nil and CCustomNetTableManager.TablesKeys[b] ~= nil then
			return shallowcopy(CCustomNetTableManager.TablesKeys[b])
		end
		return {}
	end
	CCustomNetTableManager.SetNetData = function(self, b, g, d, h)
		local c = h ~= nil and g .. tostring(h) or g
		local i = d == nil and "" or json.encode(d)
		CustomNetTables:SetTableValue(b, c, { data = i })
	end
	CCustomNetTableManager.GetNetData = function(self, b, g, h)
		local c = h ~= nil and tostring(g) .. tostring(h) or g
		local j = CustomNetTables:GetTableValue(b, c)
		if j == nil or j.data == nil then
			return
		end
		local k = json.decode(j.data)
		return k
	end
end
if IsClient() then
	if CCustomNetTableManager.GetTableValue_Engine == nil then
		CCustomNetTableManager.GetTableValue_Engine = CCustomNetTableManager.GetTableValue
	end
	CCustomNetTableManager.GetTableValue = function(self, b, c)
		local l = (b .. ",") .. c
		local m = GetFrameCount()
		if CCustomNetTableManager.ClientNetTable == nil then
			CCustomNetTableManager.ClientNetTable = {}
		end
		local j
		local n = CCustomNetTableManager.ClientNetTable[l]
		if (n and n[m]) == nil then
			CCustomNetTableManager.ClientNetTable[l] = {}
			local o = self:GetTableValue_Engine(b, c)
			CCustomNetTableManager.ClientNetTable[l][m] = o
			j = o
		else
			j = CCustomNetTableManager.ClientNetTable[l][m]
		end
		return j
	end
	CCustomNetTableManager.GetNetData = function(self, b, g, h)
		local c
		if h ~= nil then
			c = g + h
		else
			c = g
		end
		local l = (b .. ",") .. tostring(c)
		local m = GetFrameCount()
		if CCustomNetTableManager.ClientNetData == nil then
			CCustomNetTableManager.ClientNetData = {}
		end
		local j
		local p = CCustomNetTableManager.ClientNetData[l]
		if (p and p[m]) == nil then
			CCustomNetTableManager.ClientNetData[l] = {}
			local k = CustomNetTables:GetTableValue(b, c)
			if k ~= nil and k.data ~= nil then
				local q = json.decode(k.data)
				CCustomNetTableManager.ClientNetData[l][m] = q
				j = q
			end
		else
			j = CCustomNetTableManager.ClientNetData[l][m]
		end
		return j
	end
	CCustomNetTableManager.GetPlayerServiceNetTable = function(self, g, h)
		if h == nil then
			h = GetLocalPlayerID()
		end
		local i = CustomNetTables:GetTableValue("service", g .. tostring(h))
		if i ~= nil and i.data ~= nil then
			local r = json.decode(i.data)
			return r
		end
	end
end