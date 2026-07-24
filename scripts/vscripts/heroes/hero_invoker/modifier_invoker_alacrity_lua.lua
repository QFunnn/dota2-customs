--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_alacrity_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_alacrity_lua:IsHidden()
    return false
end

function modifier_invoker_alacrity_lua:IsDebuff()
    return false
end

function modifier_invoker_alacrity_lua:IsPurgable()
    return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_alacrity_lua:OnCreated(kv)
    self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    if IsServer() then
        self:PlayEffects()
        local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_invoker_5")
        if talent and talent:GetLevel() > 0 then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_invoker_alacrity_talent", {})
        end
    end
end


function modifier_invoker_alacrity_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_alacrity_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }

    return funcs
end

function modifier_invoker_alacrity_lua:GetModifierPreAttack_BonusDamage()
    if self:GetCaster():HasModifier("modifier_invoker_alacrity_talent") then
        return self.damage + 50
    end
    return self.damage
end

function modifier_invoker_alacrity_lua:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():HasModifier("modifier_invoker_alacrity_talent") then
        return self.attack_speed + 50
    end
    return self.attack_speed
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_alacrity_lua:GetEffectName()
    return "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf"
end

function modifier_invoker_alacrity_lua:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
function modifier_invoker_alacrity_lua:PlayEffects()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

    -- buff particle
    self:AddParticle(
    effect_cast,
    false,
    false,
    -1,
    false,
    false
    )

    -- Emit Sounds
    local sound_cast = "Hero_Invoker.Alacrity"
    EmitSoundOn(sound_cast, self:GetParent())
end