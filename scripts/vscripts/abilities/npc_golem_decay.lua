--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_decay", "abilities/npc_golem_decay", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_decay_debuff", "abilities/npc_golem_decay", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_decay_cd", "abilities/npc_golem_decay", LUA_MODIFIER_MOTION_NONE)


npc_golem_decay = class({})


function npc_golem_decay:OnAbilityPhaseStart()
    self.point = self:GetCursorPosition()
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.7)
       return true
end 



function npc_golem_decay:OnSpellStart()
if not IsServer() then return end

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_decay_cd", {duration = self:GetCooldownTimeRemaining()})
    self:GetCaster():EmitSound("Hero_Undying.Decay.Cast")
    CreateModifierThinker(self:GetCaster(), self, "modifier_decay", {duration = FrameTime()}, self.point, self:GetCaster():GetTeamNumber(), false)

end


modifier_decay = class({})

function modifier_decay:IsHidden() return false end

function modifier_decay:GetTexture() return "elder_titan_echo_stomp" end

function modifier_decay:IsPurgable() return false end

function modifier_decay:IsAura() return true end

function modifier_decay:GetAuraDuration() return 0.1 end

function modifier_decay:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

function modifier_decay:OnDestroy(table)
if not IsServer() then return end

self.number = self:GetAbility():GetSpecialValueFor("number")
self.live = self:GetAbility():GetSpecialValueFor("live")


  for i = 1,self.number do 
    local new_skelet = CreateUnitByName("npc_golem_zombie", self:GetAbility().point+RandomVector(RandomInt(-150, 150)), true, nil, nil, DOTA_TEAM_CUSTOM_5)
              
    new_skelet.mkb = self:GetCaster().mkb
    new_skelet.host_team = self:GetCaster().host_team
    new_skelet:AddNewModifier(new_skelet, nil, "modifier_waveupgrade", {})
    new_skelet:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kill", {duration = self.live})
  end

self:GetCaster():EmitSound("Hero_Undying.Decay.Target")
            
local decay_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_decay.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(decay_particle, 0, self:GetAbility().point)
    ParticleManager:SetParticleControl(decay_particle, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), 0, 0))
    ParticleManager:SetParticleControl(decay_particle, 2, self:GetCaster():GetAbsOrigin())    
    ParticleManager:ReleaseParticleIndex(decay_particle)


end    

function modifier_decay:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end

function modifier_decay:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_decay:GetModifierAura() return "modifier_decay_debuff" end

modifier_decay_debuff = class ({})

function modifier_decay_debuff:IsPurgable() return false end

function modifier_decay_debuff:GetTexture() return "undying_decay" end

function modifier_decay_debuff:IsHidden() return true end

function modifier_decay_debuff:OnCreated(table)
        if not IsServer() then return end
        self.damage = self:GetParent():GetMaxHealth()*self:GetAbility():GetSpecialValueFor("damage")/100

        DoDamage({ victim = self:GetParent(), attacker = self:GetAbility():GetCaster(), ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
       
        self:GetAbility():GetCaster():Heal(self.damage, self:GetAbility():GetCaster())

        local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetAbility():GetCaster() )
        ParticleManager:ReleaseParticleIndex( particle )

        SendOverheadEventMessage(self:GetAbility():GetCaster(), 10, self:GetAbility():GetCaster(), self.damage, nil)

        
end

modifier_decay_cd = class({})

function modifier_decay_cd:IsHidden() return false end
function modifier_decay_cd:IsPurgable() return false end