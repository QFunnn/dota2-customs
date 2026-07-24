--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_passive", "abilities/npc_golem_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_golem_passive_model", "abilities/npc_golem_passive.lua", LUA_MODIFIER_MOTION_NONE)

npc_golem_passive = class({})


function npc_golem_passive:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl", context )
PrecacheResource( "model", "models/creeps/neutral_creeps/n_creep_golem_b/n_creep_golem_b.vmdl", context )
end

function npc_golem_passive:GetIntrinsicModifierName() return "modifier_golem_passive" end
 
modifier_golem_passive = class ({})

function modifier_golem_passive:IsHidden() return true end
function modifier_golem_passive:DeclareFunctions() 
return 
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
} 
end

function modifier_golem_passive:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

self.hidden = self.parent:GetUnitName() ~= "npc_golem_large"
if self.hidden then
    self.owner_name = "npc_golem_large"
    if self.parent:GetUnitName() == "npc_golem_small" then
        self.owner_name = "npc_golem_medium"
    end
end

self.interval = 0.1
self:OnIntervalThink(true)
self:StartIntervalThink(self.interval)
end

function modifier_golem_passive:OnIntervalThink(first)
if not IsServer() then return end

if self.hidden then
    self.parent:AddNoDraw()
    if not self.golem_owner and self.parent.ally then
        for i = 1,#self.parent.ally do
            local unit = self.parent.ally[i]
            if IsValid(unit) and unit:IsAlive() and (not unit.golem_count or unit.golem_count < 2) and unit:GetUnitName() == self.owner_name then
                if not unit.golem_count then
                    unit.golem_count = 1
                else
                    unit.golem_count = unit.golem_count + 1
                end
                self.golem_owner = unit
                break
            end
        end
    end
    if not first then
        if (not IsValid(self.golem_owner) or not self.golem_owner:IsAlive()) then
            self.hidden = false
        elseif IsValid(self.golem_owner) then
            self.parent:SetAbsOrigin(self.golem_owner:GetAbsOrigin())
        end
    end
end

if not self.hidden then
    self.parent:RemoveNoDraw()
    if self.parent:GetUnitName() ~= "npc_golem_large" then
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_golem_passive_model", {})
    end
    self:StartIntervalThink(-1)
end

end

function modifier_golem_passive:GetModifierProcAttack_Feedback( param )
if not IsServer() then end 

if self:GetParent() == param.attacker then
local chance = self:GetAbility():GetSpecialValueFor("chance")
    local random = RollPseudoRandomPercentage(chance,1,self:GetParent())
    if random and not param.target:IsBuilding() then 
        local duration = self:GetAbility():GetSpecialValueFor("duration")
        param.target:AddNewModifier(param.attacker, self:GetAbility(), "modifier_stunned", { duration = duration*(1 - param.target:GetStatusResistance()) })
        param.target:EmitSound("Creep.Tiny_craggy")
        param.target:EmitSound("Creep.Tiny_craggy_stun")
    end
end

end

function modifier_golem_passive:CheckState()
if not self.hidden then return end
if self.parent:HasModifier("modifier_death") then return end
return
{
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_UNTARGETABLE] = true,
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_UNSELECTABLE] = true
}
end

modifier_golem_passive_model = class(mod_hidden)
function modifier_golem_passive_model:RemoveOnDeath() return false end
function modifier_golem_passive_model:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.model = "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl"
if self.parent:GetUnitName() == "npc_golem_small" then
    self.model = "models/creeps/neutral_creeps/n_creep_golem_b/n_creep_golem_b.vmdl"
end

end

function modifier_golem_passive_model:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MODEL_CHANGE
}
end

function modifier_golem_passive_model:GetModifierModelChange()
return self.model
end