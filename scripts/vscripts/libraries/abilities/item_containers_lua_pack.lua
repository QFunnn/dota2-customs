--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_containers_lua_pack = class({})
--------------------------------------------------------------------------------

function item_containers_lua_pack:OnSpellStart()

  local container = self.container
  if IsValidContainer(container) then
    local pid = self:GetOwner():GetPlayerOwnerID()
    if container:IsOpen(pid) then
      container:Close(pid)
      self.toggled = false
    else
      container:Open(pid)
      self.toggled = true
    end
  else
    print("INVALID CONTAINER", container)
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------