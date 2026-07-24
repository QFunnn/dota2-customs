--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


techies_remote_mines_self_detonate_custom = class({})

function techies_remote_mines_self_detonate_custom:Spawn()
    if not IsServer() then return end
    if self and not self:IsTrained() then
        self:SetLevel(1)
    end
end

function techies_remote_mines_self_detonate_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf", context)
end

function techies_remote_mines_self_detonate_custom:OnSpellStart(use_ability)
    if not IsServer() then return end
    local modifier_techies_remote_mines_custom = self:GetCaster():FindModifierByName("modifier_techies_remote_mines_custom")
    if modifier_techies_remote_mines_custom == nil then return end
    local techies_remote_mines_custom = modifier_techies_remote_mines_custom:GetAbility()
    local detonate_delay = techies_remote_mines_custom:GetSpecialValueFor("detonate_delay")
    self:GetCaster():EmitSound("Hero_Techies.RemoteMine.Activate")

    if not use_ability then
        local units = PlayerResource:GetSelectedEntities(self:GetCaster():GetPlayerOwnerID())
        for _, id in pairs(units) do
            local unit = EntIndexToHScript(id)
            if unit and unit ~= self:GetCaster() and unit:HasAbility("techies_remote_mines_self_detonate_custom") and unit:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
                local techies_remote_mines_self_detonate_custom = unit:FindAbilityByName("techies_remote_mines_self_detonate_custom")
                if techies_remote_mines_self_detonate_custom then
                    techies_remote_mines_self_detonate_custom:OnSpellStart(true)
                end
            end
        end
    end

    Timers:CreateTimer(detonate_delay, function()
        if self == nil or self:IsNull() then return end
        if self:GetCaster() == nil or self:GetCaster():IsNull() then return end
        if not self:GetCaster():IsAlive() then return end
        self:GetCaster():EmitSound("Hero_Techies.RemoteMine.Detonate")

        local damage = techies_remote_mines_custom:GetSpecialValueFor("damage") / 100 * techies_remote_mines_custom:GetCaster():GetDisplayAttackSpeed()
        local radius = techies_remote_mines_custom:GetSpecialValueFor("radius")
        local vision_radius = techies_remote_mines_custom:GetSpecialValueFor("vision_radius")
        local vision_duration = techies_remote_mines_custom:GetSpecialValueFor("vision_duration")

        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, Vector(radius+100, 1, 1))
        ParticleManager:SetParticleControl(particle, 3, self:GetCaster():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)

        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), vision_radius, vision_duration, false)

        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
        for _,enemy in pairs(enemies) do
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = techies_remote_mines_custom})
        end

        if techies_remote_mines_custom:GetCaster():HasModifier("modifier_techies_10") then
            local cooldown = techies_remote_mines_custom:GetCooldownTimeRemaining()
            local reduction_talent = techies_remote_mines_custom.modifier_techies_10[techies_remote_mines_custom:GetCaster():GetTalentLevel("modifier_techies_10")]
            if (cooldown + reduction_talent) <= 0 then
                techies_remote_mines_custom:EndCooldown()
            else
                techies_remote_mines_custom:EndCooldown()
                techies_remote_mines_custom:StartCooldown(cooldown + reduction_talent)
            end
        end
        
        self:GetCaster():AddNoDraw()
        self:GetCaster():ForceKill(true)
    end)
end