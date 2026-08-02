--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "override/CEntityInstance"
CEntityInstance.Remove = function(self)
	if IsValid(self) then
		FireGameEvent("custom_entity_removed", { entindex = self:entindex() })
		self:RemoveSelf()
	end
end