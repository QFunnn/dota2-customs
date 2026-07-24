--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wolf_howl_buff", "abilities/npc_wolf_howl.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wolf_howl", "abilities/npc_wolf_howl.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wolf_cd", "abilities/npc_wolf_howl.lua", LUA_MODIFIER_MOTION_NONE)

npc_wolf_howl = class({})

function npc_wolf_howl:OnSpellStart()
    
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wolf_cd", {duration = self:GetCooldownTimeRemaining()})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wolf_howl", {})
end

function npc_wolf_howl:GetChannelTime() return self:GetSpecialValueFor("duration") end
 

function npc_wolf_howl:OnChannelFinish(bInterrupted)

self:GetCaster():RemoveModifierByName("modifier_wolf_howl")

end 

modifier_wolf_howl = class ({})

function modifier_wolf_howl:IsHidden() return true end

function modifier_wolf_howl:IsPurgable() return false end

function modifier_wolf_howl:IsAura() return true end

function modifier_wolf_howl:GetAuraDuration() return 0.1 end

function modifier_wolf_howl:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end

function modifier_wolf_howl:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end

function modifier_wolf_howl:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_wolf_howl:GetModifierAura() return "modifier_wolf_howl_buff" end

function modifier_wolf_howl:OnCreated(table)
    self:StartIntervalThink(2)
    self:OnIntervalThink()
end

function modifier_wolf_howl:OnIntervalThink()
if not IsServer() then return end
if not self:GetCaster() or self:GetCaster():IsNull() or not self:GetCaster():IsAlive() then return end

    self:GetCaster():StartGestureWithPlaybackRate( ACT_DOTA_CAST_ABILITY_2, 0.4)
    self:GetCaster():EmitSound("Hero_Lycan.Howl")
    local caster = self:GetCaster()

    Timers:CreateTimer(0.4, function()
         
        if not caster or caster:IsNull() or not caster:IsAlive() then return end 

        local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
        ParticleManager:SetParticleControlEnt( particle, 1, caster, PATTACH_POINT_FOLLOW, "attach_mouth", caster:GetOrigin(), true )
        ParticleManager:ReleaseParticleIndex( particle ) 
    end)
end

modifier_wolf_howl_buff = class ({})


function modifier_wolf_howl_buff:OnCreated(table)
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.speed = self:GetAbility():GetSpecialValueFor("speed")
end


function modifier_wolf_howl_buff:GetTexture() return "lycan_howl" end

function modifier_wolf_howl_buff:IsPurgable() return false end

function modifier_wolf_howl_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2
    }
end
function modifier_wolf_howl_buff:OnTooltip()
    return self.damage end

function modifier_wolf_howl_buff:OnTooltip2()
    return self.speed end



function modifier_wolf_howl_buff:GetModifierBaseDamageOutgoing_Percentage() return self.damage end
function modifier_wolf_howl_buff:GetModifierAttackSpeedBonus_Constant() return self.speed end

function modifier_wolf_howl_buff:GetEffectName() return "particles/units/heroes/hero_lone_druid/lone_druid_battle_cry_overhead.vpcf" end
 
function modifier_wolf_howl_buff:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end



modifier_wolf_cd = class({})

function modifier_wolf_cd:IsHidden() return false end
function modifier_wolf_cd:IsPurgable() return false end