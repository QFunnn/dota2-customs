--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_satyr_root_passive", "abilities/npc_satyr_root.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_root_debuff", "abilities/npc_satyr_root.lua", LUA_MODIFIER_MOTION_NONE)

npc_satyr_root = class({})


function npc_satyr_root:GetIntrinsicModifierName() return "modifier_satyr_root_passive" end
 
modifier_satyr_root_passive = class ({})

function modifier_satyr_root_passive:IsHidden() return true end

function modifier_satyr_root_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.parent:AddAttackEvent_out(self, true)

self.duration = self.ability:GetSpecialValueFor("duration")
self.chance = self.ability:GetSpecialValueFor("chance")
end

function modifier_satyr_root_passive:AttackEvent_out(params)
if not IsServer() then end 
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local random = RollPseudoRandomPercentage(self.chance,1856, self.parent)
if not random then return end

params.target:EmitSound("n_creep_Spawnlord.Freeze")
params.target:AddNewModifier(self.parent, self.ability, "modifier_satyr_root_debuff", { duration = self.duration*(1 - params.target:GetStatusResistance()) })
end



modifier_satyr_root_debuff = class ({})

function modifier_satyr_root_debuff:IsHidden() return false end

function modifier_satyr_root_debuff:IsPurgable() return true end

function modifier_satyr_root_debuff:CheckState() return { [MODIFIER_STATE_ROOTED] = true } end

function modifier_satyr_root_debuff:OnCreated(table)
    local interval = 0.5
    self:StartIntervalThink(interval)
end

function modifier_satyr_root_debuff:OnIntervalThink()
    if not IsServer() then return end
    local tik = 0
    local total = self:GetAbility():GetSpecialValueFor("damage")
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    local interval = 0.5
    tik = total / (duration / interval) 
    DoDamage({ victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = tik, damage_type = DAMAGE_TYPE_MAGICAL})


end


function modifier_satyr_root_debuff:GetEffectName() return "particles/neutral_fx/prowler_shaman_shamanistic_ward.vpcf" end

function modifier_satyr_root_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end