--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


-- libraries/bignum.lua
-- Pure Lua BigNumber implementation for handling arbitrary precision arithmetic
-- Uses base-10^9 block representation to avoid float precision issues

local BigNum = {}

BigNum.BASE = 1000000000

-- Helper function to remove leading zero blocks
local function trim(a)
	local d = a.d
	while #d > 1 and d[#d] == 0 do
		table.remove(d)
	end
	return a
end

-- Create a zero BigNumber
function BigNum.zero()
	return { d = { 0 } }
end

-- Convert a regular number to BigNumber (safe for n <= 1e12)
function BigNum.fromNumber(n)
	if n <= 0 then
		return BigNum.zero()
	end
	local d = {}
	local base = BigNum.BASE
	while n > 0 do
		local r = n % base
		table.insert(d, r)
		n = math.floor(n / base)
	end
	return trim({ d = d })
end

-- Convert a string to BigNumber (handles arbitrary precision)
function BigNum.fromString(s)
	s = tostring(s):gsub("^%s+", ""):gsub("%s+$", "")
	if s == "" or s == "0" then
		return BigNum.zero()
	end

	local base = BigNum.BASE
	local a = BigNum.zero()
	local chunk = 9 -- 9 digits per block (BASE = 10^9)

	for i = #s, 1, -chunk do
		local start = math.max(1, i - chunk + 1)
		local part = tonumber(s:sub(start, i)) or 0

		-- Multiply existing number by base and add new part
		table.insert(a.d, 1, 0)
		a.d[1] = part
		a = trim(a)
	end

	return a
end

-- Compare two BigNumbers (returns -1, 0, or 1)
local function cmpRaw(a, b)
	local da, db = a.d, b.d
	if #da ~= #db then
		return (#da > #db) and 1 or -1
	end

	for i = #da, 1, -1 do
		if da[i] ~= db[i] then
			return (da[i] > db[i]) and 1 or -1
		end
	end
	return 0
end

function BigNum.cmp(a, b)
	return cmpRaw(a, b)
end

-- Add two BigNumbers
function BigNum.add(a, b)
	local base = BigNum.BASE
	local d, carry = {}, 0
	local na, nb = #a.d, #b.d
	local n = math.max(na, nb)

	for i = 1, n do
		local s = (a.d[i] or 0) + (b.d[i] or 0) + carry
		if s >= base then
			s = s - base
			carry = 1
		else
			carry = 0
		end
		d[i] = s
	end

	if carry == 1 then
		d[n + 1] = 1
	end

	return trim({ d = d })
end

-- Subtract two BigNumbers (assumes a >= b)
function BigNum.sub(a, b)
	local base = BigNum.BASE
	local d, borrow = {}, 0

	for i = 1, #a.d do
		local ai = a.d[i] - (b.d[i] or 0) - borrow
		if ai < 0 then
			ai = ai + base
			borrow = 1
		else
			borrow = 0
		end
		d[i] = ai
	end

	return trim({ d = d })
end

-- Convert BigNumber to string
function BigNum.toString(a)
	local d = a.d
	local s = tostring(d[#d])

	for i = #d - 1, 1, -1 do
		s = s .. string.format("%09d", d[i])
	end

	return s
end

return BigNum