--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArraySome = ____lualib.__TS__ArraySome
local ____exports = {}
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
____exports.RubickOriginAbility = __TS__Class()
local RubickOriginAbility = ____exports.RubickOriginAbility
RubickOriginAbility.name = "RubickOriginAbility"
__TS__ClassExtends(RubickOriginAbility, MonsterAbility_CS)
function RubickOriginAbility.prototype.GetUnitTile(self, unit)
	if not MyGameDynamicFloor or not IsValidAlive(nil, unit) then
		return nil
	end
	local ____MyGameDynamicFloor_3 = MyGameDynamicFloor
	local ____MyGameDynamicFloor_GetTileAtPoint_4 = MyGameDynamicFloor.GetTileAtPoint
	local ____temp_2 = unit:GetAbsOrigin()
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetRoomId
	return ____MyGameDynamicFloor_GetTileAtPoint_4(
		____MyGameDynamicFloor_3,
		____temp_2,
		____opt_0 and ____opt_0(____this_1)
	)
end
function RubickOriginAbility.prototype.GetPointTile(self, point, roomId)
	if not MyGameDynamicFloor then
		return nil
	end
	return MyGameDynamicFloor:GetTileAtPoint(point, roomId)
end
function RubickOriginAbility.prototype.GetTileByGrid(self, floorId, gridColumn, gridRow)
	if not MyGameDynamicFloor then
		return nil
	end
	return MyGameDynamicFloor:GetTileByGrid(floorId, gridColumn, gridRow)
end
function RubickOriginAbility.prototype.GetNearestAvailableTileOnFloor(self, floorId, origin)
	if not MyGameDynamicFloor then
		return nil
	end
	local result = MyGameDynamicFloor:GetNearestAvailableTileCenter(floorId, origin)
	if not result.success or result.gridColumn == nil or result.gridRow == nil then
		return nil
	end
	return self:GetTileByGrid(floorId, result.gridColumn, result.gridRow)
end
function RubickOriginAbility.prototype.GetTilesByOffsets(self, centerTile, offsets)
	local tiles = {}
	for ____, offset in ipairs(offsets) do
		local tile =
			self:GetTileByGrid(centerTile.floorId, centerTile.gridColumn + offset.dx, centerTile.gridRow + offset.dy)
		if tile then
			tiles[#tiles + 1] = tile
		end
	end
	return tiles
end
function RubickOriginAbility.prototype.GetNeighborTiles8(self, centerTile)
	return self:GetTilesByOffsets(centerTile, {
		{ dx = 0, dy = 1 },
		{ dx = 1, dy = 1 },
		{ dx = 1, dy = 0 },
		{ dx = 1, dy = -1 },
		{ dx = 0, dy = -1 },
		{ dx = -1, dy = -1 },
		{ dx = -1, dy = 0 },
		{ dx = -1, dy = 1 },
	})
end
function RubickOriginAbility.prototype.GetCardinalTiles(self, centerTile)
	return self:GetTilesByOffsets(
		centerTile,
		{ { dx = 0, dy = 1 }, { dx = 1, dy = 0 }, { dx = 0, dy = -1 }, { dx = -1, dy = 0 } }
	)
end
function RubickOriginAbility.prototype.GetCardinalDirectionFromVector(self, direction)
	if math.abs(direction.x) >= math.abs(direction.y) then
		return { dx = direction.x >= 0 and 1 or -1, dy = 0 }
	end
	return { dx = 0, dy = direction.y >= 0 and 1 or -1 }
end
function RubickOriginAbility.prototype.GetDirectionFromCasterToTarget(self, caster, target)
	return self:GetCardinalDirectionFromVector(GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin()))
end
function RubickOriginAbility.prototype.GetTileRows(self, centerTile, direction, width, length, startDistance)
	if startDistance == nil then
		startDistance = 1
	end
	local safeWidth = math.max(1, math.floor(width))
	local safeLength = math.max(1, math.floor(length))
	local halfWidth = math.floor(safeWidth / 2)
	local side = { dx = -direction.dy, dy = direction.dx }
	local rows = {}
	do
		local forwardIndex = 0
		while forwardIndex < safeLength do
			local forwardDistance = startDistance + forwardIndex
			local row = {}
			do
				local sideIndex = -halfWidth
				while sideIndex <= halfWidth do
					local tile = self:GetTileByGrid(
						centerTile.floorId,
						centerTile.gridColumn + direction.dx * forwardDistance + side.dx * sideIndex,
						centerTile.gridRow + direction.dy * forwardDistance + side.dy * sideIndex
					)
					if tile then
						row[#row + 1] = tile
					end
					sideIndex = sideIndex + 1
				end
			end
			if #row > 0 then
				rows[#rows + 1] = row
			end
			forwardIndex = forwardIndex + 1
		end
	end
	return rows
end
function RubickOriginAbility.prototype.FindEnemyUnitsOnTiles(self, tiles)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or #tiles <= 0 then
		return {}
	end
	local searchCenter = self:GetTileSearchCenter(tiles)
	local searchRadius = self:GetTileSearchRadius(tiles, searchCenter)
	local candidates = FindUnitsInRadius(
		caster:GetTeamNumber(),
		searchCenter,
		nil,
		searchRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local result = {}
	for ____, unit in ipairs(candidates) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue27
			end
			local unitTile = self:GetUnitTile(unit)
			if unitTile and self:HasTile(tiles, unitTile) then
				result[#result + 1] = unit
			end
		end
		::__continue27::
	end
	return result
end
function RubickOriginAbility.prototype.HasTile(self, tiles, targetTile)
	return __TS__ArraySome(tiles, function(____, tile)
		return self:IsSameTile(tile, targetTile)
	end)
end
function RubickOriginAbility.prototype.IsSameTile(self, left, right)
	return left.floorId == right.floorId and left.gridColumn == right.gridColumn and left.gridRow == right.gridRow
end
function RubickOriginAbility.prototype.GetTileSearchCenter(self, tiles)
	local x = 0
	local y = 0
	local z = 0
	for ____, tile in ipairs(tiles) do
		x = x + tile.origin.x
		y = y + tile.origin.y
		z = z + tile.origin.z
	end
	local count = math.max(1, #tiles)
	return Vector(x / count, y / count, z / count)
end
function RubickOriginAbility.prototype.GetTileSearchRadius(self, tiles, center)
	local radius = 0
	for ____, tile in ipairs(tiles) do
		radius = math.max(radius, GetDistance(nil, tile.origin, center) + tile.radius)
	end
	return radius + 128
end
return ____exports