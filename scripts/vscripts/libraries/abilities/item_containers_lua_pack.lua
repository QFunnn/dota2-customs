--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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