--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_orb_icon = class({})


function modifier_orb_icon:IsHidden() return false end
function modifier_orb_icon:IsPurgable() return false end



function modifier_orb_icon:CheckState()
    return {
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
    }
end

function modifier_orb_icon:RemoveOnDeath() return false end


function modifier_orb_icon:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.team = self.caster:GetTeamNumber()
self.abs = self.parent:GetAbsOrigin()

self.item = EntIndexToHScript(table.item)
self.id = self.caster:GetId()

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end 


function modifier_orb_icon:OnIntervalThink()
if not IsServer() then return end 

AddFOWViewer(self.team, self.abs, 10, 0.2, false)

if not self.item or self.item:IsNull() or not players[self.id] then 
    self:Destroy()
    return
end 

end 


function modifier_orb_icon:OnDestroy()
if not IsServer() then return end 

if self.item and not self.item:IsNull() then
    UTIL_Remove(self.item:GetContainedItem()) 
    UTIL_Remove(self.item) 
end

UTIL_Remove(self.parent)
end 