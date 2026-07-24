--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_invun = class({})


function modifier_invun:IsHidden() return true end
function modifier_invun:IsPurgable() return false end



function modifier_invun:CheckState()
if not self.parent or self.parent:IsNull() then return end

local tower = towers[self.parent:GetTeamNumber()]

if not tower then return end

if tower and duel_data[tower.duel_data]
    and (duel_data[tower.duel_data].rounds > 0)
    and duel_data[tower.duel_data].finished == 0 then 
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_STUNNED] = true,
    }
else 
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
    end

end 


function modifier_invun:RemoveOnDeath() return false end



function modifier_invun:OnCreated(table)
self.parent = self:GetParent()
end