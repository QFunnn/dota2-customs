--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_bloodlust_custom_buff", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_bloodlust_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_bloodlust_custom_aura", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_bloodlust_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_bloodlust_custom_handler", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_bloodlust_custom", LUA_MODIFIER_MOTION_NONE )

ogre_magi_bloodlust_custom = class({})

ogre_magi_bloodlust_custom.modifier_ogre_magi_9 = {5,10,15}
ogre_magi_bloodlust_custom.modifier_ogre_magi_13_movespeed = 4

function ogre_magi_bloodlust_custom:Spawn()
    if not IsServer() then return end
    if self:GetCaster() and self:GetCaster():IsRealHero() and not self:GetCaster():HasModifier("modifier_ogre_magi_bloodlust_custom_handler") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ogre_magi_bloodlust_custom_handler", {})
    end
end

function ogre_magi_bloodlust_custom:OnSpellStart(new_target)
    local caster = self:GetCaster()
    local target = caster
    if self:GetCursorTarget() then
        target = self:GetCursorTarget()
    end
    if new_target then
        target = new_target
    end
    local duration = self:GetSpecialValueFor( "duration" )
    target:AddNewModifier( caster, self, "modifier_ogre_magi_bloodlust_custom_buff", { duration = duration } )
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt( particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
    ParticleManager:ReleaseParticleIndex( particle )
    caster:EmitSound("Hero_OgreMagi.Bloodlust.Cast")
end

function ogre_magi_bloodlust_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ogre_magi_13") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return self.BaseClass.GetBehavior(self)
end

function ogre_magi_bloodlust_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_ogre_magi_13") then
        return 0
    end
    return self.BaseClass.GetCooldown(self, iLevel)
end

function ogre_magi_bloodlust_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_ogre_magi_13") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function ogre_magi_bloodlust_custom:GestIntrinsicModifierName()
    if not self:GetCaster():HasModifier("modifier_ogre_magi_13") then return end
    if self:GetCaster():HasModifier("modifier_ogre_magi_17") then return end
    return "modifier_ogre_magi_bloodlust_custom_aura"
end

modifier_ogre_magi_bloodlust_custom_buff = class({})

function modifier_ogre_magi_bloodlust_custom_buff:OnCreated( kv )
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    if not self.ability then return end
    self.modelscale = self.ability:GetSpecialValueFor( "modelscale" )
    self.bonus_movement_speed = self.ability:GetSpecialValueFor( "bonus_movement_speed" )
    self.bonus_attack_speed = self.ability:GetSpecialValueFor( "bonus_attack_speed" )
    self.self_bonus = self.ability:GetSpecialValueFor( "self_bonus" )
    if self.parent == self.caster then
        self.bonus_attack_speed = self.self_bonus
    end
    if not IsServer() then return end
    local particle_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
    local particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    self:AddParticle(particle, false, false, -1, true, false)
    self.parent:EmitSound("Hero_OgreMagi.Bloodlust.Target")
    EmitSoundOnClient("Hero_OgreMagi.Bloodlust.Target.FP", self.parent:GetPlayerOwner() )
end

function modifier_ogre_magi_bloodlust_custom_buff:OnRefresh()
    self.modelscale = self.ability:GetSpecialValueFor( "modelscale" )
    self.bonus_movement_speed = self.ability:GetSpecialValueFor( "bonus_movement_speed" )
    self.bonus_attack_speed = self.ability:GetSpecialValueFor( "bonus_attack_speed" )
    self.self_bonus = self.ability:GetSpecialValueFor( "self_bonus" )
    if self.parent == self.caster then
        self.bonus_attack_speed = self.self_bonus
    end
end

function modifier_ogre_magi_bloodlust_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MODEL_SCALE,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    }
end

function modifier_ogre_magi_bloodlust_custom_buff:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end

function modifier_ogre_magi_bloodlust_custom_buff:GetModifierMoveSpeedBonus_Percentage()
    local bonus = self.bonus_movement_speed or 0
    if self.caster and self.ability and self.caster:HasModifier("modifier_ogre_magi_13") then
        bonus = bonus + self.ability.modifier_ogre_magi_13_movespeed
    end
    return bonus
end

function modifier_ogre_magi_bloodlust_custom_buff:GetModifierBonusStats_Agility()
    if self.caster and self.ability and self.caster:HasModifier("modifier_ogre_magi_9") then
        return self.ability.modifier_ogre_magi_9[self.caster:GetTalentLevel("modifier_ogre_magi_9")]
    end
    return 0
end

function modifier_ogre_magi_bloodlust_custom_buff:GetModifierModelScale()
    return self.modelscale
end

modifier_ogre_magi_bloodlust_custom_aura = class({})
function modifier_ogre_magi_bloodlust_custom_aura:IsHidden() return true end
function modifier_ogre_magi_bloodlust_custom_aura:IsPurgable() return false end
function modifier_ogre_magi_bloodlust_custom_aura:IsPurgeException() return false end
function modifier_ogre_magi_bloodlust_custom_aura:RemoveOnDeath() return false end
function modifier_ogre_magi_bloodlust_custom_aura:IsAura() return true end
function modifier_ogre_magi_bloodlust_custom_aura:IsAuraActiveOnDeath() return false end
function modifier_ogre_magi_bloodlust_custom_aura:GetModifierAura() return "modifier_ogre_magi_bloodlust_custom_buff" end
function modifier_ogre_magi_bloodlust_custom_aura:GetAuraRadius() return 900 end
function modifier_ogre_magi_bloodlust_custom_aura:GetAuraDuration() return 0 end
function modifier_ogre_magi_bloodlust_custom_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_ogre_magi_bloodlust_custom_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_ogre_magi_bloodlust_custom_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end


modifier_ogre_magi_bloodlust_custom_handler = class({})
function modifier_ogre_magi_bloodlust_custom_handler:IsHidden() return true end
function modifier_ogre_magi_bloodlust_custom_handler:IsPurgable() return false end
function modifier_ogre_magi_bloodlust_custom_handler:IsPurgeException() return false end
function modifier_ogre_magi_bloodlust_custom_handler:RemoveOnDeath() return false end
function modifier_ogre_magi_bloodlust_custom_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_ogre_magi_bloodlust_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_ogre_magi_13") then return end
    if self:GetParent():HasModifier("modifier_ogre_magi_17") then return end

	if self:GetParent():HasModifier("modifier_wodarelax") then return end
    if self:GetParent():HasModifier("modifier_wodawisp") then return end

    if self:GetAbility():GetAutoCastState() and self:GetAbility():IsFullyCastable() and not self:GetCaster():GetCurrentActiveAbility() and not self:GetCaster():HasModifier("modifier_ogre_magi_bloodlust_custom_buff") then
        self:GetCaster():CastAbilityOnTarget(self:GetCaster(), self:GetAbility(), -1)
    end
end