--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = require("lualib_bundle")
local b = a.__TS__StringReplace
local c = a.__TS__ArrayIncludes
local d = a.__TS__StringStartsWith
local e = a.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 2,
		["10"] = 3,
		["11"] = 4,
		["12"] = 4,
		["13"] = 10,
		["14"] = 10,
		["15"] = 10,
		["16"] = 11,
		["17"] = 11,
		["18"] = 11,
		["19"] = 11,
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["23"] = 11,
		["24"] = 11,
		["25"] = 11,
		["26"] = 11,
		["27"] = 11,
		["28"] = 11,
		["29"] = 11,
		["30"] = 11,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["35"] = 21,
		["36"] = 22,
		["37"] = 27,
		["38"] = 28,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 34,
		["44"] = 34,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 34,
		["50"] = 34,
		["51"] = 34,
		["52"] = 34,
		["53"] = 34,
		["54"] = 41,
		["56"] = 43,
		["57"] = 27,
		["58"] = 47,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["63"] = 48,
		["65"] = 48,
		["66"] = 52,
		["68"] = 53,
		["69"] = 54,
		["70"] = 55,
		["71"] = 56,
		["73"] = 58,
		["74"] = 59,
		["75"] = 59,
		["76"] = 59,
		["77"] = 59,
		["78"] = 59,
		["79"] = 60,
		["80"] = 61,
		["81"] = 62,
		["82"] = 63,
		["87"] = 27,
		["88"] = 27,
		["89"] = 20,
		["90"] = 70,
	}
)
local f = {}
local g = require("tstl_plugins.path")
local h = require("tstl_plugins.typescript")
local i = require("tstl_plugins.typescript-to-lua")
local j = require("tstl_plugins.typescript-to-lua.dist.transformation.visitors.call")
local k = j.transformCallAndArguments
local function l(m, n)
	return b(n, nil, "/")
end
local function o(m, n)
	return b(b(b(b(n, nil, "\\\\"), nil, '\\"'), nil, "\\r"), nil, "\\n")
end
local function p(m, q)
	if q == nil then
		q = {}
	end
	local r = q.variableName or "__TSTL_FILE_PATH__"
	local s = { "registerEOMModifier", "registerModifier" }
	return {
		visitors = {
			[h.SyntaxKind.CallExpression] = function(m, t, u)
				if h:isIdentifier(t.expression) and c(s, t.expression.text) then
					local v = u.checker:getResolvedSignature(t)
					local w = h.factory:createIdentifier(r)
					local x, y = unpack(k(nil, u, t.expression, t.arguments, v, w), 1, 2)
					return i:createCallExpression(x, y, t)
				end
				return u:superTransformNode(t)
			end,
		},
		afterPrint = function(m, z, A, B, C)
			local D
			if A and A.configFilePath then
				D = g:dirname(A.configFilePath)
			else
				D = nil
			end
			local E = D or (B and B.getCurrentDirectory and B:getCurrentDirectory() or nil) or process:cwd()
			for m, F in ipairs(C) do
				do
					local G = F.sourceFiles and F.sourceFiles[1]
					local H = G and G.fileName or F.fileName
					if H == nil then
						goto I
					end
					H = g:relative(E, H)
					local J = b(l(nil, H), nil, "")
					local K = o(nil, J)
					local L = ((("local " .. r) .. ' = "') .. K) .. '"\n'
					if not d(F.code, L) then
						F.code = L .. F.code
					end
				end
				::I::
			end
		end,
	}
end
f.default = p
return f