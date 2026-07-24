--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_silencer_lastword_debuff", "abilities/npc_silencer_lastword", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_silencer_lastword_silence", "abilities/npc_silencer_lastword", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_silencer_lastword_cd", "abilities/npc_silencer_lastword", LUA_MODIFIER_MOTION_NONE)

npc_silencer_lastword = class({})

function npc_silencer_lastword:OnSpellStart()
if not IsServer() then return end
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_silencer_lastword_cd", {duration = self:GetCooldownTimeRemaining()})
local caster = self:GetCaster()
local target = self:GetCursorTarget()



if target:TriggerSpellAbsorb(self) then return end

target:EmitSound("Hero_Silencer.LastWord.Target")
target:AddNewModifier(caster, self, "modifier_silencer_lastword_debuff", {duration = self:GetSpecialValueFor("duration")*(1 - target:GetStatusResistance())})

end







modifier_silencer_lastword_debuff = class({})
function modifier_silencer_lastword_debuff:IsPurgable() return false  end
function modifier_silencer_lastword_debuff:IsHidden() return false end
function modifier_silencer_lastword_debuff:GetEffectName()
    return "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
end



function modifier_silencer_lastword_debuff:OnCreated(table)
if not IsServer() then return end
self.cast = false 
self.silence = self:GetAbility():GetSpecialValueFor("silence")
self.stun = self:GetAbility():GetSpecialValueFor("stun")

self:GetParent():AddSpellEvent(self)
end




function modifier_silencer_lastword_debuff:OnDestroy()
if not IsServer() then return end
if self:GetParent():IsMagicImmune() then return end


self:GetParent():StopSound("Hero_Silencer.LastWord.Target")

if self.cast == true then 
 
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self.stun*(1 - self:GetParent():GetStatusResistance())})

	self:GetParent():EmitSound("Hero_Silencer.LastWord.Damage")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_silencer/silencer_last_word_dmg.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex(particle)
	DoDamage({ victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL})


end


end




function modifier_silencer_lastword_debuff:SpellEvent(params)
if self:GetParent() ~= params.unit then return end
if params.ability:IsItem() then return end

self.cast = true
self:Destroy()

end






modifier_silencer_lastword_silence = class({})
function modifier_silencer_lastword_silence:IsHidden() return false end
function modifier_silencer_lastword_silence:IsPurgable() return true end


function modifier_silencer_lastword_silence:CheckState() return {[MODIFIER_STATE_SILENCED] = true} end
function modifier_silencer_lastword_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
 
function modifier_silencer_lastword_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end





modifier_silencer_lastword_cd = class({})
function modifier_silencer_lastword_cd:IsHidden() return false end
function modifier_silencer_lastword_cd:IsPurgable() return false end
