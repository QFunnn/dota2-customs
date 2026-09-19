--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Расчет перекрестного произведения
---@param p1 any
---@param p2 any
---@return unknown
local function GetCross(p1, p2)
	return p1.x * p2.y - p2.x * p1.y
end

---@param p1 any
---@param p2 any
---@return number
function GetDotProduct(p1, p2)
	return p1.x * p2.x + p1.y * p2.y
end

-- Чтобы определить, находится ли точка p внутри прямоугольника, передайте ее по порядку в верхний левый, нижний левый, верхний правый и нижний правый углы.
---@param p any
---@param lu any
---@param ld any
---@param ru any
---@param rd any
---@return boolean
function IsPointInsideRectangle(p, lu, ld, ru, rd)
	return (GetCross(ru - lu, p - lu) * GetCross(ld - rd, p - rd) >= 0)
		and (GetCross(lu - ld, p - ld) * GetCross(rd - ru, p - ru) >= 0)
end