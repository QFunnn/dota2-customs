--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = require("data/dungeon_gridnav/index")
local b = { catalog = a }
local c = {}
function b:GetMap(d)
	local e = a.maps[d]
	if not e then
		return nil, "missing_or_stale_template"
	end
	if not c[d] then
		local f = require(e.module)
		assert(f.schema_version == 1 and f.grid_size == 64, "Unsupported GridNav template")
		assert(f.prefab == d and f.fingerprint == e.fingerprint, "GridNav template/catalog mismatch")
		c[d] = f
	end
	return c[d]
end
function b:GetLocalCode(d, g, h)
	local f, i = self:GetMap(d)
	if not f then
		return nil, i
	end
	if g < -f.capture_radius or g >= f.capture_radius or h < -f.capture_radius or h >= f.capture_radius then
		return nil, "outside_capture_window"
	end
	local j = math.floor((g - f.x_min + 32) / f.grid_size) + 1
	local k = math.floor((h - f.y_min + 32) / f.grid_size) + 1
	if j < 1 or k < 1 or j > f.width or k > f.height then
		return 0
	end
	return string.byte(f.rows[k], j) - 48
end
function b:GetCode(d, l, m)
	if m.x % 64 ~= 0 or m.y % 64 ~= 0 then
		return nil, "room_origin_not_grid_aligned"
	end
	return self:GetLocalCode(d, l.x - m.x, l.y - m.y)
end
b.gridNavReader = b
return b