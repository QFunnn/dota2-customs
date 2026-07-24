--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param inputstr string
---@param separator string
---@return string[]
function string.split(inputstr, separator)
	if separator == nil then
		separator = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. separator .. "]+)") do
		table.insert(t, str)
	end
	return t
end

---@param s string
---@param prefix string
---@return boolean
function string.startsWith(s, prefix)
	return type(s) == "string" and s:sub(1, #prefix) == prefix
end

---@param source string
---@return string
function string.trim(source)
	return source:match "^%s*(.-)%s*$"
end

---@param source string
---@param word string
---@return string
function string.remove(source, word)
    if type(source) ~= "string" or type(word) ~= "string" then
        return source
    end

    if word == "" then
        return source
    end

    local result = source

    while true do
        local startPos, endPos = string.find(result, word, 1, true)
        if not startPos then
            break
        end

        result = string.sub(result, 1, startPos - 1) .. string.sub(result, endPos + 1)
    end

    return result
end