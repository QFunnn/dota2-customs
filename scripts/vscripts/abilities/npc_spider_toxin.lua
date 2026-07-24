--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spider_toxin", "abilities/npc_spider_toxin.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spider_toxin_cd", "abilities/npc_spider_toxin.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_toxin_aura", "abilities/npc_spider_toxin.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_toxin_thinker", "abilities/npc_spider_toxin.lua", LUA_MODIFIER_MOTION_NONE)


npc_spider_toxin = class({})

function npc_spider_toxin:OnSpellStart()


local target = self:GetCursorTarget()

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_spider_toxin_cd", {duration = self:GetCooldownTimeRemaining()})
    
CreateModifierThinker(self:GetCaster(), self, "modifier_spider_toxin", {duration = self:GetSpecialValueFor("delay")}, target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
   

end




modifier_spider_toxin = class({})

function modifier_spider_toxin:IsHidden() return true end

function modifier_spider_toxin:IsPurgable() return false end

function modifier_spider_toxin:OnCreated(table)
if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
    ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )

end


function modifier_spider_toxin:OnDestroy(table)
if not IsServer() then return end
    
    ParticleManager:DestroyParticle( self.effect_cast, true )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )

    self:GetCaster():EmitSound("Hero_Viper.Nethertoxin.Cast")  
    CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_toxin_thinker", {}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)

end





modifier_toxin_thinker = class({})

function modifier_toxin_thinker:IsHidden() return false end

function modifier_toxin_thinker:IsPurgable() return false end

function modifier_toxin_thinker:IsAura() return true end

function modifier_toxin_thinker:GetAuraDuration() return 0.1 end

function modifier_toxin_thinker:GetAuraRadius() return self.radius
 end
function modifier_toxin_thinker:OnCreated(table)
if not IsServer() then return end


self.radius = self:GetAbility():GetSpecialValueFor("radius")

self.nFXIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_viper/viper_nethertoxin.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.nFXIndex, 0, self:GetParent():GetOrigin())
ParticleManager:SetParticleControl(self.nFXIndex, 1, Vector(self.radius, 1, 1))
EmitSoundOn("Hero_Viper.NetherToxin", self:GetParent())
self:StartIntervalThink(0.3)
end


function modifier_toxin_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end

function modifier_toxin_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_toxin_thinker:GetModifierAura() return "modifier_toxin_aura" end

function modifier_toxin_thinker:OnIntervalThink()
if not IsServer() then return end
if not self:GetCaster():IsAlive() then 
     StopSoundOn("Hero_Viper.NetherToxin", self:GetParent())
        ParticleManager:DestroyParticle(self.nFXIndex, false)
        ParticleManager:ReleaseParticleIndex(self.nFXIndex)
        self:GetParent():Destroy()
        self:Destroy()
end
end


modifier_toxin_aura = class({})

function modifier_toxin_aura:IsPurgable() return false end

function modifier_toxin_aura:IsHidden() return false end 
function modifier_toxin_aura:IsDebuff() return true end
function modifier_toxin_aura:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true,
[MODIFIER_STATE_SILENCED] = true} end


function modifier_toxin_aura:OnCreated(table)
self.slow = self:GetAbility():GetSpecialValueFor("slow")
if not IsServer() then return end

self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.interval = self:GetAbility():GetSpecialValueFor("interval")

self.damage = self.damage*self.interval

self:StartIntervalThink(self.interval)

self:OnIntervalThink()
end

function modifier_toxin_aura:OnIntervalThink()
if not IsServer() then return end
self:GetParent():EmitSound("Hero_Viper.NetherToxin.Damage")
DoDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
 
end

function modifier_toxin_aura:GetEffectName() return "particles/generic_gameplay/generic_break.vpcf" end
 
function modifier_toxin_aura:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end



function modifier_toxin_aura:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE

}
end

function modifier_toxin_aura:GetModifierMoveSpeedBonus_Percentage() return self.slow end





modifier_spider_toxin_cd = class({})

function modifier_spider_toxin_cd:IsHidden() return false end
function modifier_spider_toxin_cd:IsPurgable() return false end