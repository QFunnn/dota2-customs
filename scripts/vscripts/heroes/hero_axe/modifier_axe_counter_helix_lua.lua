--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_counter_helix_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_counter_helix_lua:IsHidden()
    return true
end

function modifier_axe_counter_helix_lua:IsPurgable()
    return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_counter_helix_lua:OnCreated(kv)
    if not IsServer() then return end
    -- references
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.chance = self:GetAbility():GetSpecialValueFor("shard_trigger_chance")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")

    -- precache damage
    self.damageTable = {
        -- victim = target,
        attacker = self:GetParent(),
        damage = self.damage,
        damage_type = DAMAGE_TYPE_PURE,
        ability = self:GetAbility(), --Optional.
        damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
    }
    -- ApplyDamage(damageTable)
end

function modifier_axe_counter_helix_lua:OnRefresh(kv)
    self:OnCreated(kv)
end

function modifier_axe_counter_helix_lua:OnDestroy()

end

function modifier_axe_counter_helix_lua:AttackLandedModifier(params)
    if IsServer() then
        if params.attacker:GetTeamNumber() == params.target:GetTeamNumber() then return end


        if params.attacker:IsOther() or params.attacker:IsBuilding() then return end
        if params.target ~= self:GetParent() then return end

        if self:GetParent():PassivesDisabled() then return end

        local flChance = self.chance

        if RandomInt(1, 100) > flChance then return end
         
        --冷却中不触发
        if not self:GetAbility():IsCooldownReady() then
           return
        end

        -- find enemies
        local enemies = FindUnitsInRadius(
            self:GetParent():GetTeamNumber(), -- int, your team number
            self:GetParent():GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
            0, -- int, order filter
            false	-- bool, can grow cache
        )

        -- damage
        for _, enemy in pairs(enemies) do
            self.damageTable.victim = enemy
            ApplyDamage(self.damageTable)

            --如果有碎片，增加debuff
            if self:GetParent():HasModifier("modifier_item_aghanims_shard") then
               if not enemy:HasModifier("modifier_axe_counter_helix_lua_debuff") then
                 local hDebuff=enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_axe_counter_helix_lua_debuff", {duration=6.0})
                 if hDebuff then
                    hDebuff:SetStackCount(1)
                 end
               else
                 if enemy:FindModifierByName("modifier_axe_counter_helix_lua_debuff"):GetStackCount()<6 then
                    enemy:FindModifierByName("modifier_axe_counter_helix_lua_debuff"):IncrementStackCount()
                 end
                 enemy:FindModifierByName("modifier_axe_counter_helix_lua_debuff"):SetDuration(6.0, true )
               end
            end
        end

        -- cooldown
        self:GetAbility():UseResources(false, false, false, true)

        -- effects
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_counter_helix_lua:PlayEffects()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf"
    local sound_cast = "Hero_Axe.CounterHelix"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    self:GetParent():EmitSound(sound_cast)
end