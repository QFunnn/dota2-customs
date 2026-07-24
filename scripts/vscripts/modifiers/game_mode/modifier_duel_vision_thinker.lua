--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_duel_vision_thinker_buff", "modifiers/game_mode/modifier_duel_vision_thinker", LUA_MODIFIER_MOTION_NONE)


modifier_duel_vision_thinker = class({})

function modifier_duel_vision_thinker:IsHidden() return false end


function modifier_duel_vision_thinker:CheckState()
return 
{
  [MODIFIER_STATE_UNSELECTABLE] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
}
end




function modifier_duel_vision_thinker:OnCreated(table)
if not IsServer() then return end 

self.radius = 500
self:StartIntervalThink(0.2)
end




function modifier_duel_vision_thinker:OnIntervalThink()
if not IsServer() then return end 

local targets = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false)

for _,hero in pairs(targets) do 
    hero:AddNewModifier(hero, nil, "modifier_duel_vision_thinker_buff", {duration = 0.2, thinker = self:GetParent():entindex()})
end 


end 





modifier_duel_vision_thinker_buff = class({})
function modifier_duel_vision_thinker_buff:IsHidden() return true end
function modifier_duel_vision_thinker_buff:IsPurgable() return false end


function modifier_duel_vision_thinker_buff:OnCreated(table)
if not IsServer() then return end

self.thinker = EntIndexToHScript(table.thinker)
self.abs = self.thinker:GetAbsOrigin()

self:OnIntervalThink()
self:StartIntervalThink(1)
end


function modifier_duel_vision_thinker_buff:OnRefresh(table)
if not IsServer() then return end

self.thinker = EntIndexToHScript(table.thinker)
self.abs = self.thinker:GetAbsOrigin()

end 

function modifier_duel_vision_thinker_buff:OnIntervalThink()
if not IsServer() then return end 

AddFOWViewer(self:GetParent():GetTeamNumber(), self.abs, 500, 1, false)
end 
