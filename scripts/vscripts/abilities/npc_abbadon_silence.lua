--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abbadon_silence_self", "abilities/npc_abbadon_silence.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_silence", "abilities/npc_abbadon_silence.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_stack", "abilities/npc_abbadon_silence.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_speed", "abilities/npc_abbadon_silence.lua", LUA_MODIFIER_MOTION_NONE)


npc_abbadon_silence = class({})


function npc_abbadon_silence:GetIntrinsicModifierName() return "modifier_abbadon_silence_self" end


modifier_abbadon_silence_self = class(mod_hidden)
function modifier_abbadon_silence_self:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddAttackEvent_out(self, true)

self.hits = self:GetAbility():GetSpecialValueFor("hits")
end


function modifier_abbadon_silence_self:AttackEvent_out(params) 
if not IsServer() then return end

local target = params.target

if not target:HasModifier("modifier_abbadon_silence") then
    target:AddNewModifier(self.parent, self.ability, "modifier_abbadon_stack", {duration = 5})
end

end



modifier_abbadon_stack = class({})


function modifier_abbadon_stack:IsHidden() return false end

function modifier_abbadon_stack:IsPurgable() return true end

function modifier_abbadon_stack:OnCreated(table)
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_abbadon_stack:OnRefresh(table)
if not IsServer() then return end
self:SetStackCount(self:GetStackCount()+1)
if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("hits") then return end

self:GetParent():EmitSound("Hero_Abaddon.Curse.Proc")
self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_abbadon_silence", {duration = self:GetAbility():GetSpecialValueFor("duration")*(1 - self:GetParent():GetStatusResistance())})
self:Destroy()
end


function modifier_abbadon_stack:OnDestroy()
if not IsServer() then return end
ParticleManager:DestroyParticle(self.pfx, false)
ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_abbadon_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if not self.pfx then
self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
end

ParticleManager:SetParticleControl(self.pfx, 1, Vector(0, self:GetStackCount(), 0))
end






modifier_abbadon_silence = class({})
function modifier_abbadon_silence:IsHidden() return false end
function modifier_abbadon_silence:IsPurgable() return true end
function modifier_abbadon_silence:CheckState() return {[MODIFIER_STATE_SILENCED] = true} end 
function modifier_abbadon_silence:GetEffectName() return "particles/units/heroes/hero_abaddon/abaddon_curse_frostmourne_debuff.vpcf" end
function modifier_abbadon_silence:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.speed = self:GetAbility():GetSpecialValueFor("speed")

if not IsServer() then return end
self.parent:AddAttackEvent_inc(self, true)
self.parent:GenericParticle("particles/generic_gameplay/generic_silence.vpcf", self ,true)
end


function modifier_abbadon_silence:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_abbadon_silence:OnTooltip()
return self.speed
end


function modifier_abbadon_silence:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end

local attacker = params.attacker
attacker:AddNewModifier(self.caster, self.ability, "modifier_abbadon_speed", {duration = 2})
end

 


modifier_abbadon_speed = class({})


function modifier_abbadon_speed:IsHidden() return false end

function modifier_abbadon_speed:IsPurgable() return false end

function modifier_abbadon_speed:OnCreated(table)
if not self:GetAbility() then return end
   self.speed = self:GetAbility():GetSpecialValueFor("speed")
   self.move = self:GetAbility():GetSpecialValueFor("move")
end
function modifier_abbadon_speed:OnTooltip2()
return self.move
end
function modifier_abbadon_speed:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_abbadon_speed:GetModifierAttackSpeedBonus_Constant() return self.speed end
function modifier_abbadon_speed:GetModifierMoveSpeedBonus_Percentage() return self.move end

 

function modifier_abbadon_speed:OnTooltip()
return self.speed
end


function modifier_abbadon_speed:GetEffectName() return "particles/units/heroes/hero_abaddon/abaddon_frost_buff.vpcf" end
 
function modifier_abbadon_speed:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end