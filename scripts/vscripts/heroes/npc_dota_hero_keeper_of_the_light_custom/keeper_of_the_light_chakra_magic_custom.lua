--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


keeper_of_the_light_chakra_magic_custom = class({})

function keeper_of_the_light_chakra_magic_custom:OnSpellStart()
    local target = self:GetCursorTarget()
    local mana_restore = self:GetSpecialValueFor("mana_restore")
    local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
    local self_bonus = self:GetSpecialValueFor("self_bonus")
    if target == self:GetCaster() then
        mana_restore = mana_restore * (1 + (self_bonus/100))
        cooldown_reduction = cooldown_reduction * (1 + (self_bonus/100))
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_chakra_magic.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    target:EmitSound("Hero_KeeperOfTheLight.ChakraMagic.Target")
    target:GiveMana(mana_restore)
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, target, mana_restore, nil)
    for i=0, target:GetAbilityCount()-1 do
        local ability = target:GetAbilityByIndex(i)
        if ability and ability:GetAbilityType() ~= ABILITY_TYPE_ULTIMATE and ability ~= self then
            local cooldown = ability:GetCooldownTimeRemaining()
            if cooldown > 0 then
                ability:EndCooldown()
                ability:StartCooldown(cooldown - cooldown_reduction)
            end
        end
    end
end