--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function C_DOTA_BaseNPC:GetTalentLevel(mod)
	if self:HasModifier(mod) then
		return self:GetModifierStackCount(mod, self)
	else
		return 0
	end
end

function C_DOTA_BaseNPC:GetAoeBonus(value)
	if self and self:HasModifier("modifier_item_gungir") then
		value = value + 75
	end
	if self and self:HasModifier("modifier_item_dezun_bloodrite") then
		value = value + (value / 100 * 16)
	end
	return value
end