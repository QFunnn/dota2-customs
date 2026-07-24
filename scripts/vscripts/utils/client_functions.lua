--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function C_DOTA_BaseNPC:HasShard()
    return self:HasModifier("modifier_item_aghanims_shard")
end

function IsValid(...)
    for i = 1, select("#", ...) do
        local entity = select(i, ...)
        if not entity or not entity.IsNull or entity:IsNull() then
            return false
        end
    end
    return true
end