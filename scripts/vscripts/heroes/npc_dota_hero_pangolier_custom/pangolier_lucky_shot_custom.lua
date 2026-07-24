--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_lucky_shot_custom", "heroes/npc_dota_hero_pangolier_custom/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_debuff", "heroes/npc_dota_hero_pangolier_custom/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_custom_buff", "heroes/npc_dota_hero_pangolier_custom/pangolier_lucky_shot_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_lucky_shot_custom = class({})

pangolier_lucky_shot_custom.modifier_pangolier_7 = 60
pangolier_lucky_shot_custom.modifier_pangolier_6_armor = {-1,-2,-3}
pangolier_lucky_shot_custom.modifier_pangolier_6_slow = {-20,-40,-60}
pangolier_lucky_shot_custom.modifier_pangolier_2_cleave = {50,100}
pangolier_lucky_shot_custom.modifier_pangolier_2_cooldown = 7
pangolier_lucky_shot_custom.modifier_pangolier_2_radius = 350

function pangolier_lucky_shot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_heartpiercer_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/pango_cleave.vpcf", context )
end

function pangolier_lucky_shot_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_pangolier_2") then
        return self.modifier_pangolier_2_cooldown
    end
end

function pangolier_lucky_shot_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_pangolier_2") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function pangolier_lucky_shot_custom:GetIntrinsicModifierName()
    return "modifier_pangolier_lucky_shot_custom"
end

function pangolier_lucky_shot_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_lucky_shot_custom_buff", {})
end

function pangolier_lucky_shot_custom:ProcPassive(target, proc)
    local caster = self:GetCaster()
    if caster:PassivesDisabled() then return end
    local chance = self:GetSpecialValueFor("chance_pct")
    local duration = self:GetSpecialValueFor("duration")

    if not proc then 
        if not RollPseudoRandomPercentage(chance, 842, caster) then 
            return 
        end
    end

    target:AddNewModifier(caster, self, "modifier_pangolier_lucky_shot_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})  
    target:EmitSound("Hero_Pangolier.LuckyShot.Proc")

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_pangolier_lucky_shot_custom = class({})
function modifier_pangolier_lucky_shot_custom:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom:IsHidden() return true end
function modifier_pangolier_lucky_shot_custom:IsPurgeException() return false end
function modifier_pangolier_lucky_shot_custom:RemoveOnDeath() return false end

function modifier_pangolier_lucky_shot_custom:DeclareFunctions()
    return 
    {
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_pangolier_lucky_shot_custom:OnCreated(table)
    self.ability = self:GetAbility()
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.proc = false
end

function modifier_pangolier_lucky_shot_custom:OnAttackStart(params)
    if not IsServer() then return end
    if self.parent ~= params.attacker then return end
    if self.parent:IsIllusion() then return end
    self.proc = false
    local chance = self:GetAbility():GetSpecialValueFor("chance_pct")
    if not RollPseudoRandomPercentage(chance, 450, self.caster) then return end
    self.proc = true
    if params.no_attack_cooldown then return end
    self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, self.parent:GetAttackSpeed(true))
end

function modifier_pangolier_lucky_shot_custom:OnAttack(params)
    if not IsServer() then return end
    if self.parent ~= params.attacker then return end
    if not self.proc then return end
    self.proc = false
    self.ability:ProcPassive(params.target, true)
end

modifier_pangolier_lucky_shot_custom_debuff = class({})
function modifier_pangolier_lucky_shot_custom_debuff:IsHidden() return false end
function modifier_pangolier_lucky_shot_custom_debuff:IsPurgable() return true end
function modifier_pangolier_lucky_shot_custom_debuff:OnCreated()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.armor = self.ability:GetSpecialValueFor("armor")
    self.attack_slow = self.ability:GetSpecialValueFor("attack_slow")
    if self:GetCaster():HasModifier("modifier_pangolier_6") then
        self.armor = self.armor + self:GetAbility().modifier_pangolier_6_armor[self:GetCaster():GetTalentLevel("modifier_pangolier_6")]
        self.attack_slow = self.attack_slow + self:GetAbility().modifier_pangolier_6_slow[self:GetCaster():GetTalentLevel("modifier_pangolier_6")]
    end
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_debuff.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    self:AddParticle(self.particle, false, false, -1, false, false)
    if self:GetCaster():HasModifier("modifier_pangolier_7") then
        self:StartIntervalThink(1)
    end
end

function modifier_pangolier_lucky_shot_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_pangolier_7") then
        local damage = self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_pangolier_7
        ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PURE})
    end
end

function modifier_pangolier_lucky_shot_custom_debuff:DeclareFunctions()
    return  
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_pangolier_lucky_shot_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    return self.attack_slow
end

function modifier_pangolier_lucky_shot_custom_debuff:GetModifierPhysicalArmorBonus()
    return self.armor
end

modifier_pangolier_lucky_shot_custom_buff = class({})
function modifier_pangolier_lucky_shot_custom_buff:IsPurgable() return false end
function modifier_pangolier_lucky_shot_custom_buff:GetTexture() return "pangolier_2" end
function modifier_pangolier_lucky_shot_custom_buff:GetEffectName()
    return "particles/units/heroes/hero_pangolier/pangolier_heartpiercer_debuff.vpcf"
end
function modifier_pangolier_lucky_shot_custom_buff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end
function modifier_pangolier_lucky_shot_custom_buff:DeclareFunctions()
    return  
    {
         
    }
end
function modifier_pangolier_lucky_shot_custom_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.no_attack_cooldown then return end
    local particle = ParticleManager:CreateParticle("particles/pango_cleave.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControlTransformForward( particle, 0, self:GetParent():GetAbsOrigin(), self:GetParent():GetForwardVector() )
    ParticleManager:SetParticleControl(particle, 2, Vector(self:GetAbility().modifier_pangolier_2_radius+100, 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    local enemies_to_cleave = self:FindUnitsInCone(self:GetCaster():GetTeamNumber(),self:CalculateDirection(params.target, self:GetCaster()),self:GetCaster():GetAbsOrigin(), self:GetAbility().modifier_pangolier_2_radius, self:GetAbility().modifier_pangolier_2_radius, self:GetAbility().modifier_pangolier_2_radius, nil, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _,enemy in pairs(enemies_to_cleave) do
        local damage = params.original_damage / 100 * self:GetAbility().modifier_pangolier_2_cleave[self:GetCaster():GetTalentLevel("modifier_pangolier_2")]
        ApplyDamage({attacker = self:GetCaster(), victim = enemy, ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL})
        self:GetAbility():ProcPassive(enemy, true)
    end
    self:Destroy()
end
function modifier_pangolier_lucky_shot_custom_buff:FindUnitsInCone(teamNumber, vDirection, vPosition, startRadius, endRadius, flLength, hCacheUnit, targetTeam, targetUnit, targetFlags, findOrder, bCache)
    local vDirectionCone = Vector( vDirection.y, -vDirection.x, 0.0 )
    local enemies = FindUnitsInRadius(teamNumber, vPosition, hCacheUnit, endRadius + flLength, targetTeam, targetUnit, targetFlags, findOrder, bCache )
    local unitTable = {}
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            if enemy ~= nil then
                local vToPotentialTarget = enemy:GetOrigin() - vPosition
                local flSideAmount = math.abs( vToPotentialTarget.x * vDirectionCone.x + vToPotentialTarget.y * vDirectionCone.y + vToPotentialTarget.z * vDirectionCone.z )
                local enemy_distance_from_caster = ( vToPotentialTarget.x * vDirection.x + vToPotentialTarget.y * vDirection.y + vToPotentialTarget.z * vDirection.z )
                local max_increased_radius_from_distance = endRadius - startRadius
                local pct_distance = enemy_distance_from_caster / flLength
                local radius_increase_from_distance = max_increased_radius_from_distance * pct_distance
                if ( flSideAmount < startRadius + radius_increase_from_distance ) and ( enemy_distance_from_caster > 0.0 ) and ( enemy_distance_from_caster < flLength ) then
                    table.insert(unitTable, enemy)
                end
            end
        end
    end
    return unitTable
end
function modifier_pangolier_lucky_shot_custom_buff:CalculateDirection(ent1, ent2)
    local pos1 = ent1
    local pos2 = ent2
    if ent1.GetAbsOrigin then pos1 = ent1:GetAbsOrigin() end
    if ent2.GetAbsOrigin then pos2 = ent2:GetAbsOrigin() end
    local direction = (pos1 - pos2):Normalized()
    return direction
end