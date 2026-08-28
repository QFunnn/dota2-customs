--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function CDOTA_Modifier_Lua:GetPrimaryAttributeOfParent()
	return self:GetParent():GetModifierStackCount("modifier_primary_attribute_reader", self:GetParent())
end

print("CLIENT EXTENTION LOADED IN")
print(IsClient(), CDOTA_Modifier_Lua)