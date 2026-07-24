--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


keeper_of_the_light_chakra_magic = class({})

function keeper_of_the_light_chakra_magic:OnSpellStart()
    if not IsServer() then return end
    
    local caster = self:GetCaster()
    
    -- Применяем эффект на самого кастера
    self:ApplyChakraMagic(caster)
end

function keeper_of_the_light_chakra_magic:ApplyChakraMagic(target)
    local mana_restore = self:GetSpecialValueFor("mana_restore")
    local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
    
    -- Восстанавливаем ману
    target:GiveMana(mana_restore)
    
    -- Уменьшаем кулдауны всех способностей (кроме ультимативных)
    for i = 0, target:GetAbilityCount() - 1 do
        local ability = target:GetAbilityByIndex(i)
        if ability and not ability:IsNull() and ability ~= self then
            -- Проверяем, что это не ультимативная способность
            local ability_type = ability:GetAbilityType()
            local is_ultimate = (ability_type == ABILITY_TYPE_ULTIMATE)
            
            if not is_ultimate then
                local remaining_cooldown = ability:GetCooldownTimeRemaining()
                if remaining_cooldown > 0 then
                    local new_cooldown = math.max(0, remaining_cooldown - cooldown_reduction)
                    ability:EndCooldown()
                    if new_cooldown > 0 then
                        ability:StartCooldown(new_cooldown)
                    end
                end
            end
        end
    end
    
    -- Эффекты
    target:EmitSound("Hero_KeeperOfTheLight.ChakraMagic.Target")
    
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_chakra_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:ReleaseParticleIndex(particle)
end