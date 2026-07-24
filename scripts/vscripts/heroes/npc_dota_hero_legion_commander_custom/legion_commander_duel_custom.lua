--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_commander_duel_custom", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_duel_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_duel_custom_damage", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_duel_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_duel_custom_creep", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_duel_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_duel_custom_thinker_magic", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_duel_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_duel_custom_thinker_magic_debuff", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_duel_custom", LUA_MODIFIER_MOTION_NONE)

legion_commander_duel_custom = class({})

function legion_commander_duel_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", context )
    PrecacheResource( "particle", "particles/woda_legion_duel_ring.vpcf", context )
    PrecacheResource( "particle", "particles/woda_legion_duel_ring_magical_version.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_legion_commander.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_legion_commander.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_legion_commander.vpcf", context)
end

legion_commander_duel_custom.modifier_legion_commander_6 = {0.75,1.5}
legion_commander_duel_custom.modifier_legion_commander_21_bonus = 1
legion_commander_duel_custom.modifier_legion_commander_21_per = 10
legion_commander_duel_custom.modifier_legion_commander_interval = 2
legion_commander_duel_custom.modifier_legion_commander_radius = 900
legion_commander_duel_custom.modifier_legion_commander_2 = {9,8,7}
legion_commander_duel_custom.modifier_legion_commander_4 = {3,6,9}
legion_commander_duel_custom.modifier_legion_commander_21_damage = 100
legion_commander_duel_custom.modifier_legion_commander_21_radius = 500

function legion_commander_duel_custom:Spawn()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_legion_commander_duel_custom_creep") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_duel_custom_creep", {})
    end
end

function legion_commander_duel_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_legion_commander_21") then
        return "legion_commander_21"
    end
    return "legion_commander_duel"
end

function legion_commander_duel_custom:CastFilterResultTarget( hTarget )
    if not IsServer() then return UF_SUCCESS end

    if string.find(GetMapName(), "rating") or GetMapName() == "overthrow" then
        local nResult = UnitFilter(
            hTarget,
            self:GetAbilityTargetTeam(),
            self:GetAbilityTargetType(),
            self:GetAbilityTargetFlags(),
            self:GetCaster():GetTeamNumber()
        )

        if nResult ~= UF_SUCCESS then
            return nResult
        end

        return UF_SUCCESS
    else
        local nResult = UnitFilter(
            hTarget,
            self:GetAbilityTargetTeam(),
            self:GetAbilityTargetType() + DOTA_UNIT_TARGET_BASIC,
            self:GetAbilityTargetFlags(),
            self:GetCaster():GetTeamNumber()
        )

        if nResult ~= UF_SUCCESS then
            return nResult
        end

        return UF_SUCCESS
    end
end

function legion_commander_duel_custom:StartDuel(target)
    if not IsServer() then return end
    self.caster = self:GetCaster()

    local duration = self:GetSpecialValueFor("duration")

    if self:GetCaster():HasModifier("modifier_legion_commander_6") then
        duration = duration + self.modifier_legion_commander_6[self:GetCaster():GetTalentLevel("modifier_legion_commander_6")]
    end

    duration = duration * (1-target:GetStatusResistance())

    if target:TriggerSpellAbsorb(self) then return end
    self.caster:EmitSound("Hero_LegionCommander.Duel.Cast")
    self.caster:AddNewModifier(self.caster, self, "modifier_legion_commander_duel_custom", {duration = duration, target = target:entindex()})
    target:AddNewModifier(self.caster, self, "modifier_legion_commander_duel_custom", {duration = duration, target = self.caster:entindex()})
end

function legion_commander_duel_custom:OnSpellStart(target)
    if not IsServer() then return end

    self.target = self:GetCursorTarget()

    if target ~= nil then 
        self.target = target
    end

    self:StartDuel(self.target)
end

function legion_commander_duel_custom:WinArena()
    if not IsServer() then return end
    local mod = self:GetCaster():FindModifierByName("modifier_legion_commander_duel_custom_damage")
    if not mod then 
        mod = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_legion_commander_duel_custom_damage", {})
    end 
    local damage = self:GetSpecialValueFor("reward_damage")
    mod.damage = mod.damage + (damage / 1)
    mod.duel_wins = mod.duel_wins + 1
end

function legion_commander_duel_custom:WinDuel(caster, winner, loser)
    if not IsServer() then return end
    if loser:IsIllusion() then return end

    local mod = winner:FindModifierByName("modifier_legion_commander_duel_custom_damage")

    if not mod then 
        mod = winner:AddNewModifier(caster, self, "modifier_legion_commander_duel_custom_damage", {})
    end 

    local damage = self:GetSpecialValueFor("reward_damage")

    if GetMapName() ~= "arena" then
        mod.damage = mod.damage + damage
        mod.duel_wins = mod.duel_wins + 1
    end

    if winner == caster then
        local legion_commander_press_the_attack_custom = winner:FindAbilityByName("legion_commander_press_the_attack_custom")
        if legion_commander_press_the_attack_custom then
            legion_commander_press_the_attack_custom:OnSpellStartCustom()
        end
    end

    local duel_victory_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, winner)
    winner:EmitSound("Hero_LegionCommander.Duel.Victory")
end

function legion_commander_duel_custom:TalentOds(check)
    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.modifier_legion_commander_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_ANY_ORDER, false)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.modifier_legion_commander_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)

    local new_target = nil

    if #heroes > 0 then
        new_target = heroes[1]
    end

    if new_target == nil then
        if #units > 0 then
            new_target = units[1]
        end
    end

    if new_target ~= nil then
        local legion_commander_overwhelming_odds_custom = self:GetCaster():FindAbilityByName("legion_commander_overwhelming_odds_custom")
        if legion_commander_overwhelming_odds_custom and legion_commander_overwhelming_odds_custom:GetLevel() > 0 then
            legion_commander_overwhelming_odds_custom:OnSpellStart(new_target:GetAbsOrigin(), true)
        end
    end

    if check == nil then
        local modifier_legion_commander_12 = self:GetCaster():FindModifierByName("modifier_legion_commander_12")
        if modifier_legion_commander_12 and modifier_legion_commander_12:GetStackCount() > 1 then
            Timers:CreateTimer(self.modifier_legion_commander_interval, function()
                self:TalentOds(true)
            end)
        end
    end
end

modifier_legion_commander_duel_custom = class({})

function modifier_legion_commander_duel_custom:IsHidden() return false end
function modifier_legion_commander_duel_custom:IsPurgable() return false end
function modifier_legion_commander_duel_custom:IsPurgeException() return false end
function modifier_legion_commander_duel_custom:IsDebuff() return true end
function modifier_legion_commander_duel_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_legion_commander_duel_custom:OnCreated(table)
    if not IsServer() then return end	
    self.target = EntIndexToHScript(table.target)

    if not self:GetParent():IsCreep() then 
        --self:GetParent():SetForceAttackTarget(self.target)
        self:GetParent():MoveToTargetToAttack(self.target)
    end

    local legion_commander_press_the_attack_custom = self:GetParent():FindAbilityByName("legion_commander_press_the_attack_custom")
    if legion_commander_press_the_attack_custom then
        legion_commander_press_the_attack_custom:SetActivated(false)
    end
    local legion_commander_moment_of_courage_custom = self:GetParent():FindAbilityByName("legion_commander_moment_of_courage_custom")
    if legion_commander_moment_of_courage_custom then
        legion_commander_moment_of_courage_custom:SetActivated(false)
    end
    local legion_commander_duel_custom = self:GetParent():FindAbilityByName("legion_commander_duel_custom")
    if legion_commander_duel_custom then
        legion_commander_duel_custom:SetActivated(false)
    end

    self.duel_end = false

    if self:GetCaster() == self:GetParent() then 
        local center_point = self:GetCaster():GetAbsOrigin() + ((self.target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()) / 2)
        local particle_name = "particles/woda_legion_duel_ring.vpcf"
        if self:GetCaster():HasModifier("modifier_legion_commander_21") then
            particle_name = "particles/woda_legion_duel_ring_magical_version.vpcf"
            self.magic_zone = CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_legion_commander_duel_custom_thinker_magic", {}, center_point, self:GetCaster():GetTeamNumber(), false)
        end
  	    self:GetCaster().particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN, self:GetCaster())
        ParticleManager:SetParticleControl(self:GetCaster().particle, 0, center_point)
        ParticleManager:SetParticleControl(self:GetCaster().particle, 7, center_point)
        if self:GetCaster():HasModifier("modifier_legion_commander_21") then
            ParticleManager:SetParticleControl(self:GetCaster().particle, 60, Vector(147, 8, 229))
            ParticleManager:SetParticleControl(self:GetCaster().particle, 61, Vector(1,1,1))
        end
        self:GetCaster():EmitSound("Hero_LegionCommander.Duel")
    end

    if self:GetCaster():HasModifier("modifier_legion_commander_12") and self:GetParent() == self:GetCaster() then
        self:GetAbility():TalentOds()
    end

    self:StartIntervalThink(0.1)
end

function modifier_legion_commander_duel_custom:OnDeath(params)
    if params.unit == self.target then
        if not self.duel_end then
            self.duel_end = true
            self:GetAbility():WinDuel(self:GetCaster(), self:GetParent(), self.target)
            self:Destroy()
        end
    end
end

function modifier_legion_commander_duel_custom:OnIntervalThink()
    if not IsServer() then return end	

    if not self:GetParent():IsCreep() then 
        --self:GetParent():SetForceAttackTarget(self.target)
        self:GetParent():MoveToTargetToAttack(self.target)
    end

    if not self.duel_end then
        if not self.target:IsAlive() then 
            self.duel_end = true
      	    self:GetAbility():WinDuel(self:GetCaster(), self:GetParent(), self.target, self.double)
      	    self:Destroy()
        end
    end

    if (self:GetParent():GetAbsOrigin() - self.target:GetAbsOrigin()):Length2D() > self:GetAbility():GetSpecialValueFor("victory_range") or not self.target:HasModifier(self:GetName()) then 
  	    self:Destroy()
    end
end

function modifier_legion_commander_duel_custom:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():StopSound("Hero_LegionCommander.Duel")

    if self:GetCaster().particle then 
        ParticleManager:DestroyParticle(self:GetCaster().particle, false)
    end

    local legion_commander_press_the_attack_custom = self:GetParent():FindAbilityByName("legion_commander_press_the_attack_custom")
    if legion_commander_press_the_attack_custom then
        legion_commander_press_the_attack_custom:SetActivated(true)
    end
    local legion_commander_moment_of_courage_custom = self:GetParent():FindAbilityByName("legion_commander_moment_of_courage_custom")
    if legion_commander_moment_of_courage_custom then
        legion_commander_moment_of_courage_custom:SetActivated(true)
    end
    local legion_commander_duel_custom = self:GetParent():FindAbilityByName("legion_commander_duel_custom")
    if legion_commander_duel_custom then
        legion_commander_duel_custom:SetActivated(true)
    end

    if self.magic_zone then
        self.magic_zone:Destroy()
    end

    if not self:GetParent():IsCreep() then 
        self:GetParent():SetForceAttackTarget(nil)
    end
end

function modifier_legion_commander_duel_custom:CheckState() 
    if self:GetParent() == self:GetCaster() then
        return 
        {
            [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
            [MODIFIER_STATE_TAUNTED] = true, 
            [MODIFIER_STATE_MUTED] = true,
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        }
    end
    return 
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_TAUNTED] = true, 
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

function modifier_legion_commander_duel_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_EVENT_ON_DEATH,
    }
end

modifier_legion_commander_duel_custom_damage = class({})

function modifier_legion_commander_duel_custom_damage:IsHidden() return false end
function modifier_legion_commander_duel_custom_damage:IsPurgable() return false end
function modifier_legion_commander_duel_custom_damage:IsPurgeException() return false end
function modifier_legion_commander_duel_custom_damage:RemoveOnDeath() return false end
function modifier_legion_commander_duel_custom_damage:IsDebuff() return false end
function modifier_legion_commander_duel_custom_damage:GetTexture() return "legion_commander_duel" end
function modifier_legion_commander_duel_custom_damage:OnCreated(params)
    if not IsServer() then return end
    self.damage = params.damage or 0
    self.duel_wins = params.duel_wins or 0
    self:StartIntervalThink(FrameTime())
end
function modifier_legion_commander_duel_custom_damage:OnIntervalThink()
    if not IsServer() then return end
    local bonus = 0
    if self:GetParent():HasModifier("modifier_legion_commander_4") then
        bonus = self.duel_wins * self:GetAbility().modifier_legion_commander_4[self:GetCaster():GetTalentLevel("modifier_legion_commander_4")]
    end
    self:SetStackCount(self.damage + bonus)
end

function modifier_legion_commander_duel_custom_damage:DeclareFunctions()
    return
    {
    	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE 
    }
end

function modifier_legion_commander_duel_custom_damage:GetModifierPreAttack_BonusDamage() return self:GetStackCount() end

function modifier_legion_commander_duel_custom_damage:GetModifierSpellAmplify_Percentage() 
    if self:GetParent():HasModifier("modifier_legion_commander_21") then
        return (self:GetStackCount() / self:GetAbility().modifier_legion_commander_21_per) * self:GetAbility().modifier_legion_commander_21_bonus
    end
end

modifier_legion_commander_duel_custom_creep = class({})
function modifier_legion_commander_duel_custom_creep:IsPurgable() return false end
function modifier_legion_commander_duel_custom_creep:RemoveOnDeath() return false end
function modifier_legion_commander_duel_custom_creep:IsPurgeException() return false end
function modifier_legion_commander_duel_custom_creep:IsHidden() return true end

function modifier_legion_commander_duel_custom_creep:DeclareFunctions()
    return 
    {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_legion_commander_duel_custom_creep:OnDeath(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit == nil then return end
    if params.unit:IsHero() then return end
    if not self:GetParent():HasModifier("modifier_legion_commander_2") then return end
    self:SetStackCount(self:GetStackCount() + 1)

    if self:GetStackCount() >= self:GetAbility().modifier_legion_commander_2[self:GetCaster():GetTalentLevel("modifier_legion_commander_2")] then
        local modifier_legion_commander_duel_custom_damage = self:GetParent():FindModifierByName("modifier_legion_commander_duel_custom_damage")
        if modifier_legion_commander_duel_custom_damage then
            modifier_legion_commander_duel_custom_damage.damage = modifier_legion_commander_duel_custom_damage.damage + 1
        else
            modifier_legion_commander_duel_custom_damage = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_legion_commander_duel_custom_damage", {})
            modifier_legion_commander_duel_custom_damage.damage = modifier_legion_commander_duel_custom_damage.damage + 1
        end
        self:SetStackCount( math.max(0, self:GetStackCount() - self:GetAbility().modifier_legion_commander_2[self:GetCaster():GetTalentLevel("modifier_legion_commander_2")]) )
    end
end

modifier_legion_commander_duel_custom_thinker_magic = class({})
function modifier_legion_commander_duel_custom_thinker_magic:IsAura() return true end
function modifier_legion_commander_duel_custom_thinker_magic:GetAuraRadius() return self:GetCaster():GetAoeBonus(self:GetAbility().modifier_legion_commander_21_radius) end
function modifier_legion_commander_duel_custom_thinker_magic:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_legion_commander_duel_custom_thinker_magic:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_legion_commander_duel_custom_thinker_magic:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_legion_commander_duel_custom_thinker_magic:GetModifierAura() return "modifier_legion_commander_duel_custom_thinker_magic_debuff" end
function modifier_legion_commander_duel_custom_thinker_magic:OnCreated()
    if not IsServer() then return end

end

modifier_legion_commander_duel_custom_thinker_magic_debuff = class({})
function modifier_legion_commander_duel_custom_thinker_magic_debuff:IsPurgable() return false end
function modifier_legion_commander_duel_custom_thinker_magic_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
    self:OnIntervalThink()
end

function modifier_legion_commander_duel_custom_thinker_magic_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_legion_commander_21_damage
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end