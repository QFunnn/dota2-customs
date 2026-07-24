--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function math.clamp(number, min, max)
	return math.max(min, math.min(number, max))
end


function math.sign(number)
	return (number > 0 and 1) or (number == 0 and 0) or -1
end


function math.wrap(value, x_min, x_max)
	-- print("wrapping value", value, "between", x_min, x_max)
    local range = x_max - x_min  -- Calculate the range of values

    -- Wrap the value within the specified range
    local wrapped = (value - x_min) % (range + 1) + x_min

    -- If the result is still less than the minimum value, adjust it to the maximum value
    if wrapped < x_min then
        wrapped = wrapped + range + 1
    end

    return wrapped
end