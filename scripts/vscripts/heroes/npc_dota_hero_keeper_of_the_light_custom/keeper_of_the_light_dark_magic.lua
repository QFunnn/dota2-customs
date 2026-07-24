--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


keeper_of_the_light_dark_magic = class({})
keeper_of_the_light_dark_magic.modifier_keeper_of_the_light_5 = 200
keeper_of_the_light_dark_magic.modifier_keeper_of_the_light_5_strength = {120,240}

function keeper_of_the_light_dark_magic:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_dark_magic.vpcf", context)
end

function keeper_of_the_light_dark_magic:OnSpellStart()
    local target = self:GetCursorTarget()
    local mana_reduce = self:GetSpecialValueFor("mana_reduce")
    local cooldown_increased = self:GetSpecialValueFor("cooldown_increased")
    if target:TriggerSpellAbsorb(self) then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_dark_magic.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    target:EmitSound("Hero_KeeperOfTheLight.ChakraMagic.Target")

    target:Script_ReduceMana(mana_reduce, self)
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_LOSS, target, mana_reduce, nil)

    for i=0, target:GetAbilityCount()-1 do
        local ability = target:GetAbilityByIndex(i)
        if ability and ability:GetAbilityType() ~= ABILITY_TYPE_ULTIMATE and ability ~= self then
            local cooldown = ability:GetCooldownTimeRemaining()
            ability:EndCooldown()
            ability:StartCooldown(cooldown + cooldown_increased)
        end
    end

    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_5") then
        local damage = self.modifier_keeper_of_the_light_5 + (self:GetCaster():GetStrength() / 100 * self.modifier_keeper_of_the_light_5_strength[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_5")])
        ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self })
    end
end