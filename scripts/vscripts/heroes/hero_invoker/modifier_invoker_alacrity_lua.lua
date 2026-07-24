--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_alacrity_lua = class({})

function modifier_invoker_alacrity_lua:IsHidden()
    return false
end

function modifier_invoker_alacrity_lua:IsDebuff()
    return false
end

function modifier_invoker_alacrity_lua:IsPurgable()
    return true
end

function modifier_invoker_alacrity_lua:OnCreated(kv)
    self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    if IsServer() then
        self:PlayEffects()
    end
end

function modifier_invoker_alacrity_lua:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
    return funcs
end

function modifier_invoker_alacrity_lua:GetModifierPreAttack_BonusDamage(params)
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, self.damage, "invoker_alacrity", DAMAGE_TYPE_PHYSICAL)
    end
    return self.damage
end

function modifier_invoker_alacrity_lua:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed
end

function modifier_invoker_alacrity_lua:GetEffectName()
    return "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf"
end

function modifier_invoker_alacrity_lua:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_invoker_alacrity_lua:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle( effect_cast, false, false, -1, false, false )
    local sound_cast = "Hero_Invoker.Alacrity"
    self:GetParent():EmitSound(sound_cast)
end