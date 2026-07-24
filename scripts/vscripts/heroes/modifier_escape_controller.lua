--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_escape_controller = class({}) ---@class CDOTA_Modifier_Lua

function modifier_escape_controller:IsHidden()
    return true
end
function modifier_escape_controller:IsDebuff()
    return false
end
function modifier_escape_controller:IsPurgable()
    return false
end
function modifier_escape_controller:IsPurgeException()
    return false
end
function modifier_escape_controller:RemoveOnDeath()
    return false
end
function modifier_escape_controller:OnCreated(kv)
    if IsServer() then
        local hParent = self:GetParent()
        self:StartIntervalThink(0.5)
    end
end
function modifier_escape_controller:OnIntervalThink()
    local hParent = self:GetParent()

    if Util:IsEscaping(hParent, hParent:GetAbsOrigin()) then
        if (hParent:HasModifier("modifier_wind_waker") or hParent:HasModifier("modifier_eul_cyclone")) then --Проверка на еул, чтобы он не скидывался, на краю арены
            return
        end
        local suppose_pos = Util:GetRoomCenter(Util:GetSupposeRoom(hParent))
        local vPos = hParent:GetAbsOrigin()
        local dir = (suppose_pos - vPos):Normalized()
        local new_pos = dir + vPos
        
        for i = 1, 2000, 50 do
            new_pos = dir * i + vPos
            if not Util:IsEscaping(hParent, new_pos) then
                FindClearSpaceForUnit(hParent, new_pos, true)
                return
            end
        end

        local suppose_room = Util:GetSupposeRoom(hParent)
        local suppose_pos = Util:GetRoomCenter(suppose_room)
        FindClearSpaceForUnit(hParent, suppose_pos, true)
    end
end
function modifier_escape_controller:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end
function modifier_escape_controller:OnDeath(params)
    local hParent = self:GetParent()
    if params.unit == hParent then
        if not hParent:IsRealHero() then
            self:Destroy()
        end
    end
end