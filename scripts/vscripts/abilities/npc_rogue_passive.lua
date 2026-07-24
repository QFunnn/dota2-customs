--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rogue_passive", "abilities/npc_rogue_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rogue_debuff", "abilities/npc_rogue_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rogue_proc", "abilities/npc_rogue_passive.lua", LUA_MODIFIER_MOTION_NONE)


npc_rogue_passive = class({})


function npc_rogue_passive:GetIntrinsicModifierName() return "modifier_rogue_passive" end
 
modifier_rogue_passive = class({})

function modifier_rogue_passive:IsHidden() return true end

function modifier_rogue_passive:DeclareFunctions() 
return 
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
}
end

function modifier_rogue_passive:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.chance = self.ability:GetSpecialValueFor("chance")
self.duration = self.ability:GetSpecialValueFor("duration")
self.parent:AddAttackRecordEvent_out(self)

self.anim = nil
self.proc = false
end

function modifier_rogue_passive:CheckState()
if not self.parent:HasModifier("modifier_rogue_proc") then return end
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end


function modifier_rogue_passive:AttackRecordEvent_out( params )
if self:GetParent() ~= params.attacker then return end 

self.parent:RemoveModifierByName("modifier_rogue_proc")
if not params.target:IsUnit() then return end

if RollPseudoRandomPercentage(self.chance ,1534,self.parent) then 
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_rogue_proc", {})
end

end

function modifier_rogue_passive:GetModifierProcAttack_Feedback( params )
if self.parent ~= params.attacker then return end
if not self.parent:HasModifier("modifier_rogue_proc") then return end

self.parent:RemoveModifierByName("modifier_rogue_proc") 

params.target:EmitSound("DOTA_Item.SilverEdge.Target")
params.target:AddNewModifier(self.parent, self.ability, "modifier_rogue_debuff", { duration = self.duration*(1 - params.target:GetStatusResistance()) })
end



modifier_rogue_debuff = class ({})
function modifier_rogue_debuff:IsHidden() return false end
function modifier_rogue_debuff:IsPurgable() return true end
function modifier_rogue_debuff:CheckState() return { [MODIFIER_STATE_PASSIVES_DISABLED] = true } end
function modifier_rogue_debuff:GetEffectName() return "particles/generic_gameplay/generic_break.vpcf" end
function modifier_rogue_debuff:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_rogue_debuff:GetTexture() return "pangolier_heartpiercer" end




modifier_rogue_proc = class(mod_hidden)