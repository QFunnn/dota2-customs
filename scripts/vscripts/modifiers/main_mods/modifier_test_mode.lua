--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_test_hero_custom = class({})
function modifier_test_hero_custom:IsHidden() return false end
function modifier_test_hero_custom:IsPurgable() return false end
function modifier_test_hero_custom:GetTexture() return "buffs/coil_resist" end
function modifier_test_hero_custom:RemoveOnDeath() return false end
function modifier_test_hero_custom:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
self.parent:AddRespawnEvent(self)

self.full_test = table.full_test

self.pos = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self.res_pos = self.pos
FindClearSpaceForUnit(self:GetParent(), self.pos, false)

if self.full_test then
	self:StartIntervalThink(0.3)
end

end


function modifier_test_hero_custom:OnIntervalThink()
if not IsServer() then return end


local enemies = self.parent:FindTargets(300)

if #enemies <= 0 then return end

self.parent:MoveToTargetToAttack(enemies[1])
self.parent:SetForceAttackTarget(enemies[1])
end


function modifier_test_hero_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MIN_HEALTH,
	MODIFIER_PROPERTY_DISABLE_AUTOATTACK
}
end

function modifier_test_hero_custom:GetMinHealth()
if not self.full_test then return end
return 1
end

function modifier_test_hero_custom:GetDisableAutoAttack()
return 1
end

function modifier_test_hero_custom:RespawnEvent(params)
if not IsServer() then return end 
if self:GetParent() ~= params.unit then return end 

FindClearSpaceForUnit(self:GetParent(), self.res_pos, true)

Timers:CreateTimer(FrameTime(), function()
    self:GetParent():RemoveModifierByName("modifier_fountain_invulnerability")
end)

end 


function modifier_test_hero_custom:DeathEvent(params)
if not IsServer() then return end 
if self:GetParent() ~= params.unit then return end 

self.res_pos = self:GetParent():GetAbsOrigin()

if towers[self.parent:GetTeamNumber()] and self.parent.died_on_duel then
	self.res_pos = towers[self.parent:GetTeamNumber()]:GetAbsOrigin() + RandomVector(300)
end

end