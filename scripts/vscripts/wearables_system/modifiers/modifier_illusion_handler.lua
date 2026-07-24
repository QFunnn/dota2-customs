--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_illusion_handler = class({})
function modifier_illusion_handler:IsPurgable() return false end
function modifier_illusion_handler:IsPurgeException() return false end
function modifier_illusion_handler:IsHidden() return true end

function modifier_illusion_handler:OnCreated()
    self.parent = self:GetParent()
    if not IsServer() then return end
    self.parent:AddDeathEvent(self)
end

function modifier_illusion_handler:OnRemoved()
    if not IsServer() then return end
    if self.parent.items_list then
        for slot, handle in pairs(self.parent.items_list) do
            if handle and IsValid(handle) then
                handle:AddNoDraw()
                UTIL_Remove(handle)
            end
        end
        self.parent.items_list = nil
    end
    self.parent.first_spawn_model = nil
end

function modifier_illusion_handler:DeathEvent(params)
    if not IsServer() then return end
    if params.unit == self:GetParent() then
        self:Destroy()
    end
end