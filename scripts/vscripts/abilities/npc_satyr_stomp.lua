--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_stomp", "abilities/npc_satyr_stomp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_stomp_cd", "abilities/npc_satyr_stomp.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stomp_break", "abilities/npc_satyr_stomp.lua", LUA_MODIFIER_MOTION_NONE)


npc_satyr_stomp = class({})

function npc_satyr_stomp:OnAbilityPhaseStart()
if not IsServer() then return end
    self:GetCaster():EmitSound("n_creep_Spawnlord.Stomp")
return true
end


function npc_satyr_stomp:OnSpellStart()
    self.damage = self:GetSpecialValueFor("damage")
    self.radius = self:GetSpecialValueFor("radius")
    self.duration = self:GetSpecialValueFor("duration")

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_satyr_stomp_cd", {duration = self:GetCooldownTimeRemaining()})
  

    if not IsServer() then return end

    local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.radius , 0 , 0 ) )
    ParticleManager:ReleaseParticleIndex(trail_pfx)  
    local enemy = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 , FIND_CLOSEST, false)
    if #enemy > 0 then 
        for _,i in pairs(enemy) do
            if not i:IsMagicImmune() then 
                DoDamage({ victim = i, attacker = self:GetCaster(), ability = self, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}) 
                i:AddNewModifier(self:GetCaster(), self, "modifier_stomp_break", {duration = self.duration*(1 - i:GetStatusResistance())})
            end
        end
    end

    

end


modifier_stomp_break = class({})

function modifier_stomp_break:IsHidden() return false end
function modifier_stomp_break:IsPurgable() return false end
function modifier_stomp_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end

function modifier_stomp_break:GetEffectName() return "particles/generic_gameplay/generic_break.vpcf" end
function modifier_stomp_break:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

modifier_satyr_stomp_cd = class({})

function modifier_satyr_stomp_cd:IsHidden() return false end
function modifier_satyr_stomp_cd:IsPurgable() return false end