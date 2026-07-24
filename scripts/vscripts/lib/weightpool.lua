--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "lib\\WeightPool"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["10"] = 2,["11"] = 2,["12"] = 12,["13"] = 13,["14"] = 14,["15"] = 12,["16"] = 17,["17"] = 18,["18"] = 19,["19"] = 20,["20"] = 21,["21"] = 22,["22"] = 23,["23"] = 23,["24"] = 24,["25"] = 24,["27"] = 17,["28"] = 29,["29"] = 30,["30"] = 29,["31"] = 34,["32"] = 35,["33"] = 36,["35"] = 38,["36"] = 34,["37"] = 45,["38"] = 46,["39"] = 47,["41"] = 48,["42"] = 48,["43"] = 49,["44"] = 50,["46"] = 48,["49"] = 45,["50"] = 56,["51"] = 57,["52"] = 58,["53"] = 59,["54"] = 60,["55"] = 61,["56"] = 62,["58"] = 56,["59"] = 67,["60"] = 68,["61"] = 69,["62"] = 70,["64"] = 67,["65"] = 75,["66"] = 76,["67"] = 77,["68"] = 78,["69"] = 79,["70"] = 80,["73"] = 83,["74"] = 83,["76"] = 75,["77"] = 87,["78"] = 88,["79"] = 89,["81"] = 90,["82"] = 90,["83"] = 91,["84"] = 92,["86"] = 90,["89"] = 87,["90"] = 101,["91"] = 102,["92"] = 103,["94"] = 104,["95"] = 104,["96"] = 105,["97"] = 106,["98"] = 107,["100"] = 109,["101"] = 104,["105"] = 112,["106"] = 113,["107"] = 114,["108"] = 115,["110"] = 117,["111"] = 117,["112"] = 118,["113"] = 119,["115"] = 120,["116"] = 120,["117"] = 121,["118"] = 122,["119"] = 123,["120"] = 124,["122"] = 126,["123"] = 129,["124"] = 130,["125"] = 131,["126"] = 132,["129"] = 134,["130"] = 134,["131"] = 135,["132"] = 136,["133"] = 134,["136"] = 138,["137"] = 139,["138"] = 140,["141"] = 120,["144"] = 144,["145"] = 145,["147"] = 147,["148"] = 117,["152"] = 151,["153"] = 101,["154"] = 155,["155"] = 156,["156"] = 156,["158"] = 157,["159"] = 157,["161"] = 158,["162"] = 159,["163"] = 159,["164"] = 159,["165"] = 159,["166"] = 160,["167"] = 161,["169"] = 163,["170"] = 155,["171"] = 166,["172"] = 167,["173"] = 167,["175"] = 168,["176"] = 169,["177"] = 170,["178"] = 171,["180"] = 173,["181"] = 166,["182"] = 176,["183"] = 177,["184"] = 177,["186"] = 178,["187"] = 179,["188"] = 180,["189"] = 181,["190"] = 182,["191"] = 183,["192"] = 184,["193"] = 185,["194"] = 186,["198"] = 190,["199"] = 176});
WeightPool = __TS__Class()
WeightPool.name = "WeightPool"
function WeightPool.prototype.____constructor(self, tList)
    self.tList = __TS__ObjectAssign({}, tList)
    self:update()
end
function WeightPool.prototype.update(self)
    self.tKey = {}
    self.tSection = {}
    self.iTotal = 0
    for k, iWeight in pairs(self.tList) do
        self.iTotal = self.iTotal + iWeight
        local ____self_tSection_0 = self.tSection
        ____self_tSection_0[#____self_tSection_0 + 1] = self.iTotal
        local ____self_tKey_1 = self.tKey
        ____self_tKey_1[#____self_tKey_1 + 1] = k
    end
end
function WeightPool.prototype.Has(self, key)
    return self.tList[key] ~= nil
end
function WeightPool.prototype.GetWeight(self, key)
    if self.tList[key] ~= nil then
        return self.tList[key]
    end
    return 0
end
function WeightPool.prototype.Get(self, iTarget, iRange)
    iTarget = iTarget / iRange * self.iTotal
    local iLen = #self.tSection
    do
        local i = 0
        while i < iLen do
            if iTarget <= self.tSection[i + 1] then
                return self.tKey[i + 1]
            end
            i = i + 1
        end
    end
end
function WeightPool.prototype.Set(self, key, iWeight)
    if iWeight > 0 then
        self.tList[key] = iWeight
        self:update()
    elseif self.tList[key] ~= nil then
        self.tList[key] = nil
        self:update()
    end
end
function WeightPool.prototype.Remove(self, key)
    if self.tList[key] ~= nil then
        self.tList[key] = nil
        self:update()
    end
end
function WeightPool.prototype.RemoveByTable(self, tKeys)
    local b = false
    for ____, key in ipairs(tKeys) do
        if self.tList[key] ~= nil then
            self.tList[key] = nil
            b = true
        end
    end
    if b then
        self:update()
    end
end
function WeightPool.prototype.Random(self)
    local iRandom = RandomInt(1, self.iTotal)
    local iLen = #self.tSection
    do
        local i = 0
        while i < iLen do
            if iRandom <= self.tSection[i + 1] then
                return self.tKey[i + 1]
            end
            i = i + 1
        end
    end
end
function WeightPool.prototype.RandomMulti(self, iCount, bRepeat)
    local tResult = {}
    if bRepeat then
        do
            local i = 0
            while i < iCount do
                local key = self:Random()
                if key == nil then
                    return tResult
                end
                tResult[#tResult + 1] = key
                i = i + 1
            end
        end
    else
        local iTotal = self.iTotal
        local tKeys = {unpack(self.tKey)}
        local tSection = {unpack(self.tSection)}
        local iLen = #tSection
        do
            local i = 0
            while i < iCount do
                local key
                local iRandom = RandomInt(1, iTotal)
                do
                    local j = 0
                    while j < iLen do
                        if iRandom <= tSection[j + 1] then
                            if iLen == 1 then
                                tResult[#tResult + 1] = tKeys[j + 1]
                                return tResult
                            end
                            key = tKeys[j + 1]
                            iLen = iLen - 1
                            local iOffset = tSection[j + 1]
                            if j > 0 then
                                iOffset = iOffset - tSection[j]
                            end
                            do
                                local k = j
                                while k < iLen do
                                    tSection[k + 1] = tSection[k + 1 + 1] - iOffset
                                    tKeys[k + 1] = tKeys[k + 1 + 1]
                                    k = k + 1
                                end
                            end
                            tSection[iLen + 1] = nil
                            tKeys[iLen + 1] = nil
                            iTotal = tSection[iLen]
                            break
                        end
                        j = j + 1
                    end
                end
                if key == nil then
                    return tResult
                end
                tResult[#tResult + 1] = key
                i = i + 1
            end
        end
    end
    return tResult
end
function WeightPool.CreateFrom_2String(self, sKeys, sWeights, separator, process)
    if sWeights == nil or sWeights == "" then
        sWeights = "1"
    end
    if process == nil then
        process = function(____, k) return k end
    end
    local t = {}
    local tWeight = __TS__StringSplit(
        tostring(sWeights),
        separator
    )
    for i, k in ipairs(__TS__StringSplit(sKeys, separator)) do
        t[process(_G, k)] = tonumber(tWeight[i] or 1)
    end
    return __TS__New(WeightPool, t)
end
function WeightPool.CreateFrom_1String(self, s, process)
    if process == nil then
        process = function(____, k) return k end
    end
    local t = {}
    for ____, s2 in ipairs(__TS__StringSplit(s, "|")) do
        local t2 = __TS__StringSplit(s2, "=")
        t[process(_G, t2[1])] = tonumber(t2[2] or 1)
    end
    return __TS__New(WeightPool, t)
end
function WeightPool.CreateFrom_Kv(self, tKv, process)
    if process == nil then
        process = function(____, k) return k end
    end
    local t = {}
    for k, v in pairs(tKv) do
        if type(v) == "number" then
            t[process(_G, k)] = v
        elseif type(v) == "table" then
            if type(v.Weight) == "number" then
                t[process(_G, k)] = v.Weight
            elseif type(v.weight) == "number" then
                t[process(_G, k)] = v.weight
            end
        end
    end
    return __TS__New(WeightPool, t)
end