--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_ward_attack_range = class(mod_hidden)
function modifier_ward_attack_range:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_ward_attack_range:CheckState()
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_ward_attack_range:OnCreated(table)
self.parent = self:GetParent()
self.range = 200
end

function modifier_ward_attack_range:GetModifierAttackRangeBonus()
if self.parent:IsRangedAttacker() then return end
return self.range
end