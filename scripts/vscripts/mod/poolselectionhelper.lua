--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "mod\\PoolSelectionHelper"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["8"] = 2,["9"] = 2,["10"] = 3,["11"] = 3,["12"] = 3,["13"] = 5,["14"] = 6,["15"] = 5,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 13,["20"] = 14,["21"] = 13,["22"] = 17,["23"] = 18,["24"] = 18,["25"] = 18,["26"] = 18,["27"] = 17,["28"] = 21,["29"] = 22,["30"] = 22,["31"] = 22,["32"] = 22,["33"] = 21,["34"] = 25,["35"] = 26,["36"] = 26,["37"] = 26,["38"] = 26,["39"] = 26,["40"] = 25,["41"] = 30,["42"] = 31,["43"] = 32,["44"] = 33,["46"] = 35,["47"] = 35,["48"] = 35,["49"] = 35,["50"] = 36,["51"] = 36,["53"] = 37,["54"] = 30,["55"] = 41,["56"] = 42,["57"] = 42,["58"] = 42,["59"] = 42,["60"] = 43,["61"] = 43,["63"] = 44,["64"] = 45,["65"] = 46,["66"] = 46,["67"] = 46,["68"] = 46,["69"] = 46,["70"] = 47,["71"] = 48,["72"] = 41,["73"] = 52,["74"] = 53,["75"] = 53,["76"] = 53,["77"] = 53,["78"] = 54,["79"] = 54,["81"] = 55,["82"] = 56,["83"] = 57,["84"] = 57,["85"] = 57,["86"] = 57,["87"] = 57,["88"] = 58,["89"] = 52,["90"] = 61,["91"] = 62,["92"] = 62,["93"] = 62,["94"] = 62,["95"] = 61,["96"] = 66,["97"] = 67,["98"] = 67,["99"] = 67,["100"] = 67,["101"] = 68,["102"] = 68,["104"] = 69,["105"] = 70,["106"] = 70,["107"] = 70,["108"] = 70,["109"] = 70,["110"] = 71,["111"] = 72,["112"] = 66});
PoolSelectionHelper = __TS__Class()
PoolSelectionHelper.name = "PoolSelectionHelper"
function PoolSelectionHelper.prototype.____constructor(self, sTable)
    self.sTable = sTable
end
function PoolSelectionHelper.prototype.selectKey(self, iPlayerID)
    return "select_" .. tostring(iPlayerID)
end
function PoolSelectionHelper.prototype.selectCountKey(self, iPlayerID)
    return "select_count_" .. tostring(iPlayerID)
end
function PoolSelectionHelper.prototype.freeRefreshKey(self, iPlayerID)
    return "free_refresh_count_" .. tostring(iPlayerID)
end
function PoolSelectionHelper.prototype.IsSelecting(self, iPlayerID)
    return NetEventData:GetTableValue(
        self.sTable,
        self:selectKey(iPlayerID)
    ) ~= nil
end
function PoolSelectionHelper.prototype.GetSelectList(self, iPlayerID)
    return NetEventData:GetTableValue(
        self.sTable,
        self:selectKey(iPlayerID)
    ) or ({})
end
function PoolSelectionHelper.prototype.ClearSelect(self, iPlayerID)
    NetEventData:SetTableValue(
        self.sTable,
        self:selectKey(iPlayerID),
        nil
    )
end
function PoolSelectionHelper.prototype.TryOpen(self, iPlayerID)
    if self:IsSelecting(iPlayerID) then
        ErrorMsg(_G, {msg = "error_not_Click"}, iPlayerID)
        return false
    end
    local iCount = NetEventData:GetTableValue(
        self.sTable,
        self:selectCountKey(iPlayerID)
    )
    if iCount == nil or iCount <= 0 then
        return false
    end
    return true
end
function PoolSelectionHelper.prototype.GiveUpSelect(self, iPlayerID, addRefreshCount)
    local iCount = NetEventData:GetTableValue(
        self.sTable,
        self:selectCountKey(iPlayerID)
    )
    if iCount == nil or iCount <= 0 then
        return false
    end
    iCount = iCount - 1
    addRefreshCount(_G, iPlayerID, 1)
    NetEventData:SetTableValue(
        self.sTable,
        self:selectCountKey(iPlayerID),
        iCount
    )
    self:ClearSelect(iPlayerID)
    return true
end
function PoolSelectionHelper.prototype.TryRefresh(self, iPlayerID, createSelection)
    local iCount = NetEventData:GetTableValue(
        self.sTable,
        self:freeRefreshKey(iPlayerID)
    ) or 0
    if iCount <= 0 then
        return false
    end
    iCount = iCount - 1
    createSelection(_G, iPlayerID)
    NetEventData:SetTableValue(
        self.sTable,
        self:freeRefreshKey(iPlayerID),
        iCount
    )
    return true
end
function PoolSelectionHelper.prototype.IsValidChoice(self, iPlayerID, sName)
    return __TS__ArrayIncludes(
        self:GetSelectList(iPlayerID),
        sName
    )
end
function PoolSelectionHelper.prototype.CompleteSelect(self, iPlayerID)
    local iCount = NetEventData:GetTableValue(
        self.sTable,
        self:selectCountKey(iPlayerID)
    )
    if iCount == nil or iCount <= 0 then
        return false
    end
    iCount = iCount - 1
    NetEventData:SetTableValue(
        self.sTable,
        self:selectCountKey(iPlayerID),
        iCount
    )
    self:ClearSelect(iPlayerID)
    return true
end