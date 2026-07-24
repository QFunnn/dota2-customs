--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_riki_tricks_of_the_trade_custom", "abilities/riki_tricks_of_the_trade_custom", LUA_MODIFIER_MOTION_NONE )

riki_tricks_of_the_trade_custom = class({})

function riki_tricks_of_the_trade_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function riki_tricks_of_the_trade_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function riki_tricks_of_the_trade_custom:OnAbilityPhaseStart()
    if self:GetCursorTarget() and self:GetCursorTarget() == self:GetCaster() then
        self:GetCaster():SetCursorPosition(self:GetCaster():GetAbsOrigin())
        self:GetCaster():SetCursorCastTarget(nil)
        self:GetCaster():CastAbilityOnPosition(self:GetCaster():GetAbsOrigin(), self, self:GetCaster():GetPlayerID())
    end
    return true
end

function riki_tricks_of_the_trade_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local target = self:GetCursorTarget()
    local target_scepter = false
    if target == nil then
        target = self:GetCaster()
    end
    if target and target ~= self:GetCaster() then
        target_scepter = true
    end
    if self:GetCaster():HasTalent("special_bonus_unique_riki_5") then
        self:GetCaster():Purge(false, true, false, false, false)
    end
    self:GetCaster():SetAbsOrigin(point)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_riki_tricks_of_the_trade_custom", {target = target:entindex(), target_scepter = target_scepter})
end

function riki_tricks_of_the_trade_custom:OnChannelFinish()
    if not IsServer() then return end
    local modifier = self:GetCaster():FindModifierByName("modifier_riki_tricks_of_the_trade_custom")
    if modifier and not modifier:IsNull() then
        modifier:Destroy()
    end
end

modifier_riki_tricks_of_the_trade_custom = class({})

function modifier_riki_tricks_of_the_trade_custom:IsPurgable() return false end

function modifier_riki_tricks_of_the_trade_custom:OnCreated(params)
    if not IsServer() then return end
    self.target = EntIndexToHScript(params.target)
    self.target_scepter = params.target_scepter
    self.agility = self:GetCaster():GetAgility() / 100 * self:GetAbility():GetSpecialValueFor("agility_pct")
    self.attack_count = self:GetAbility():GetSpecialValueFor("attack_count")
    self.current_interval = 0
    self.attack_speed = 2 / self.attack_count
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self:GetParent():EmitSound("Hero_Riki.TricksOfTheTrade")
    local particle_start = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_tricks_cast.vpcf", PATTACH_WORLDORIGIN, nil)
    self.particle_radius = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_tricks.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.particle_radius, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle_radius, 1, Vector(self.radius, 0, self.radius))
    ParticleManager:SetParticleControl(self.particle_radius, 2, Vector(self.radius, 0, self.radius))
    self:AddParticle(self.particle_radius, false, false, -1, false, false)
    self:GetParent():AddNoDraw()
    self:OnIntervalThink()
    self:StartIntervalThink(0.1)
end

function modifier_riki_tricks_of_the_trade_custom:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    self:GetParent():RemoveNoDraw()
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_riki/riki_tricks_end.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_riki_tricks_of_the_trade_custom:OnRefresh(params)
    if not IsServer() then return end
    self:OnCreated(params)
end

function modifier_riki_tricks_of_the_trade_custom:OnIntervalThink()
    if not IsServer() then return end
    self.current_interval = self.current_interval + 0.1
    if self.target_scepter then
        self:GetCaster():SetAbsOrigin(self.target:GetAbsOrigin())
        ParticleManager:SetParticleControl(self.particle_radius, 0, self:GetParent():GetAbsOrigin())
    end
    if self.current_interval >= self.attack_speed then
        self.current_interval = 0
        local targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY , DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC , DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER , false)
        if #targets > 0 then
            for _, target in pairs(targets) do
                if target:IsAlive() and not target:IsAttackImmune() then
                    self:GetParent():PerformAttack(target, true, true, true, false, false, false, false)
                end
            end
        end
        self.attack_count = self.attack_count - 1
        if self.attack_count <= 0 then
            self:Destroy()
        end
    end
end

function modifier_riki_tricks_of_the_trade_custom:DeclareFunctions()
    local funcs = 
    { 
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE

     }
    return funcs
end

function modifier_riki_tricks_of_the_trade_custom:GetModifierDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("damage_pct") - 100
end

function modifier_riki_tricks_of_the_trade_custom:GetModifierBonusStats_Agility()
    return self.agility
end

function modifier_riki_tricks_of_the_trade_custom:GetModifierProcAttack_BonusDamage_Physical( keys )
    if not IsServer() then return end
    local damage = 0
    local target = keys.target
    local attacker = keys.attacker
    local ability = self:GetCaster():FindAbilityByName("riki_bariki_backstab_customckstab")
    local agility_damage_multiplier = 0
    if ability then
        agility_damage_multiplier = ability:GetSpecialValueFor("damage_multiplier")
    end
    EmitSoundOn("Hero_Riki.Backstab", target)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_riki/riki_backstab.vpcf", PATTACH_ABSORIGIN_FOLLOW, target) 
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true) 
    damage = attacker:GetAgility() * agility_damage_multiplier
    return damage
end

function modifier_riki_tricks_of_the_trade_custom:CheckState()
    local state = 
    {   
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
    return state
end