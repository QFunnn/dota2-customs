--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_Modifier_Lua:GetPrimaryAttributeOfParent()
	return self:GetParent():GetModifierStackCount("modifier_primary_attribute_reader", self:GetParent())
end

print("CLIENT EXTENTION LOADED IN")
print(IsClient(), CDOTA_Modifier_Lua)