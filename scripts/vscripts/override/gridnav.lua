--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "override/GridNav"
if IsServer() then
	GridNav.IsValidPosition = function(self, b)
		if not self:IsTraversable(b) or self:IsBlocked(b) then
			return false
		end
		return true
	end
	GridNav.IsHole = function(self, b)
		local c = GetGroundPosition(b, nil) + Vector(0, 0, -5000)
		local d = { startpos = c, endpos = c + Vector(0, 0, 3000), mask = 33570827 }
		if TraceLine(d) then
			if d.hit then
				return true
			else
				return false
			end
		end
		return false
	end
end