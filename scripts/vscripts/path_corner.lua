--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if not PathGraph then
    PathGraph = class({})
end

local TableCount = function(t)
    local n = 0
    for _ in pairs( t ) do
        n = n + 1
    end
    return n
end

function PathGraph:Initialize()
    local corners = Entities:FindAllByClassname('path_corner')
    local points = {} 
    for _,corner in ipairs(corners) do
        points[corner:entindex()] = corner
    end

    local names = {}

    for _,corner in ipairs(corners) do
        local name = corner:GetName()
        if names[name] ~= nil then
        else
            local parents = Entities:FindAllByTarget(corner:GetName())
            corner.edges = corner.edges or {}
            
            for _,parent in ipairs(parents) do
                corner.edges[parent:entindex()] = parent
                parent.edges = parent.edges or {}
                parent.edges[corner:entindex()] = corner
                parent.next_corner = corner
            end
        end
    end
end

function PathGraph:DrawPaths(pathCorner, duration, color)
    duration = duration or 10
    color = color or Vector(255,255,255)
    if pathCorner ~= nil then
        if pathCorner:GetClassname() ~= "path_corner" or pathCorner.edges == nil then
        return
        end

        local seen = {}
        local toDo = {pathCorner}

        repeat 
        local corner = table.remove(toDo)
        local edges = corner.edges
        DebugDrawCircle(corner:GetAbsOrigin(), color, 50, 20, true, duration)
        seen[corner:entindex()] = corner

        for index,edge in pairs(edges) do
            if seen[index] == nil then
            DebugDrawLine_vCol(corner:GetAbsOrigin(), edge:GetAbsOrigin(), color, true, duration)
            table.insert(toDo, edge)
            end
        end
        until (#toDo == 0)
    else
        local corners = Entities:FindAllByClassname('path_corner')
        local points = {} 
        for _,corner in ipairs(corners) do
        points[corner:entindex()] = corner
        end

        repeat 
        local seen = {}
        local k,v = next(points)
        local toDo = {v}

        repeat 
            local corner = table.remove(toDo)
            points[corner:entindex()] = nil
            local edges = corner.edges
            DebugDrawCircle(corner:GetAbsOrigin(), color, 50, 20, true, duration)
            seen[corner:entindex()] = corner

            for index,edge in pairs(edges) do
            if seen[index] == nil then
                DebugDrawLine_vCol(corner:GetAbsOrigin(), edge:GetAbsOrigin(), color, true, duration)
                table.insert(toDo, edge)
            end
            end
        until (#toDo == 0)
        until (TableCount(points) == 0)
    end
end

function MoveToNextCornerThink(unit, corner_name)
    if unit:IsNull() or not unit:IsAlive() then return nil end
    if unit:IsDominated() then return nil end

    if unit.current_corner == nil then
        unit.current_corner = Entities:FindByName(nil, corner_name)
        if unit.current_corner == nil then
            return
        end
    end

    local current_corner = unit.current_corner
    local next_corner = current_corner.next_corner or nil
    local point_corner = unit.current_corner:GetAbsOrigin()
    local point_unit = unit:GetAbsOrigin()
    local vector_dist = (point_corner - point_unit):Length2D()

    if vector_dist < 250 then     
        if next_corner then
            unit.current_corner = next_corner
        else
            unit:RemoveModifierByName("modifier_patrol_start")
            return
        end
    else
        if unit:GetAggroTarget() == nil or (unit:GetAggroTarget() and not unit:GetAggroTarget():IsAlive()) then
            local order = 
            {
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                Position = point_corner,
                Queue = false
            }
            ExecuteOrderFromTable(order)
            --unit:MoveToPositionAggressive(point_corner)
        end
    end
    
    return 0.1
end

function CDOTA_BaseNPC:SetInitialWaypoint(corner_name)
    self:SetContextThink( "Think", function() return MoveToNextCornerThink(self, corner_name) end, 0.1 )
end