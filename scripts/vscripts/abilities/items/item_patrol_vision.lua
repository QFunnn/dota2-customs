--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_vision", "abilities/items/item_patrol_vision", LUA_MODIFIER_MOTION_NONE)

item_patrol_vision = class({})


function item_patrol_vision:OnSpellStart()

local caster = self:GetCaster()

if not dota1x6:FinalDuel() then
	caster:AddNewModifier(caster, self, "modifier_patrol_vision", {duration = self:GetSpecialValueFor("duration")})
	EmitSoundOnEntityForPlayer("Item.SeerStone", caster, caster:GetPlayerOwnerID())
end

self:SpendCharge(0)
end



modifier_patrol_vision = class({})
function modifier_patrol_vision:IsHidden() return false end
function modifier_patrol_vision:IsPurgable() return false end
function modifier_patrol_vision:RemoveOnDeath() return false end
function modifier_patrol_vision:GetTexture() return "item_third_eye" end
function modifier_patrol_vision:OnCreated(table)

self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.ability = self:GetAbility()
self.radius = self.ability:GetSpecialValueFor("radius")

if not IsServer() then return end

self.interval = 0.3

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_patrol_vision:OnIntervalThink()
if not IsServer() then return end

for _,player in pairs(players) do
	if player ~= self.parent and (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius and player:IsAlive() then
    	AddFOWViewer(self.parent:GetTeamNumber(), player:GetAbsOrigin(), 10, self.interval + 0.1, false)
	end
end

end



function modifier_patrol_vision:DeathEvent(params)
if not IsServer() then return end
local attacker = params.attacker
local unit = params.unit

if not attacker then return end
if attacker:IsBuilding() then return end
if attacker:GetTeamNumber() ~= self.parent:GetTeamNumber() then return end
if params.unit:IsReincarnating() then return end
if not params.unit:IsRealHero() then return end
if params.unit:IsTempestDouble() then return end
if not self.parent:IsAlive() then return end

self.parent:GenericParticle("particles/general/patrol_refresh.vpcf")
self.parent:EmitSound("Patrol.Gem_heal")

self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf")
self.parent:SetMana(math.max(1, self.parent:GetMaxMana()))
self.parent:SetHealth(math.max(1, self.parent:GetMaxHealth()))
end