--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_teleport_cast = class(mod_hidden)
function modifier_teleport_cast:OnCreated(table)

self.parent = self:GetParent()

if not IsServer() then return end 

self.ords = 
{
    [DOTA_UNIT_ORDER_MOVE_ITEM] = true,
    [DOTA_UNIT_ORDER_SELL_ITEM] = true,
    [DOTA_UNIT_ORDER_PURCHASE_ITEM] = true,
}

self.range = 300
self.cast = false
self.teleport = EntIndexToHScript(table.teleport)

self.parent:Stop()
self.parent:Interrupt()

if not self.parent:HasAbility("mid_teleport") then
    local teleport_mid = self.parent:AddAbility("mid_teleport")
    teleport_mid:SetLevel(1)
end

self.parent:MoveToPosition(self.teleport:GetAbsOrigin())
self.parent:MoveToPositionAggressive(self.parent:GetAbsOrigin())
self.parent:MoveToNPC(self.teleport)

self.parent:AddOrderEvent(self)

self:StartIntervalThink(FrameTime())
end

function modifier_teleport_cast:OnIntervalThink()
if not IsServer() then return end 
if not self.teleport or self.teleport:IsNull() then 
    self:Destroy()
    return
end

if (self.parent:GetAbsOrigin() - self.teleport:GetAbsOrigin()):Length2D() <= self.range then 
    self.cast = true
    self:Destroy()
    return
end 

end 


function modifier_teleport_cast:OrderEvent( params )
if self.ords[params.order_type] then return end 

self:Destroy()
end

function modifier_teleport_cast:OnDestroy()
if not IsServer() then return end 
self.parent:Stop()

if not self.cast then return end 

self:CastTeleport()
end 


function modifier_teleport_cast:CastTeleport()
if not IsServer() then return end

self.ability = self.parent:FindAbilityByName("mid_teleport")

if not self.ability then return end

self.ability.teleport = self.teleport
self.parent:CastAbilityNoTarget(self.ability, self.parent:GetPlayerOwnerID())
    --CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#midteleport_cd"})
end