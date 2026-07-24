--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_kunkka_tidebringer_custom_passive", "heroes/npc_dota_hero_kunkka_custom/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_kunkka_tidebringer_custom_particle", "heroes/npc_dota_hero_kunkka_custom/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_kunkka_tidebringer_custom_debuff_slow", "heroes/npc_dota_hero_kunkka_custom/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_kunkka_tidebringer_custom_buff_damage", "heroes/npc_dota_hero_kunkka_custom/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_kunkka_tidebringer_custom_buff_damage_stack", "heroes/npc_dota_hero_kunkka_custom/kunkka_tidebringer_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

kunkka_tidebringer_custom = class({})

function kunkka_tidebringer_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_tidebringer.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_weapon/kunkka_spell_tidebringer_fxset.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_kunkka.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_kunkka.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_kunkka.vpcf", context)
end

kunkka_tidebringer_custom.modifier_kunkka_4 = {120,180,240}
kunkka_tidebringer_custom.modifier_kunkka_8_slow = -100
kunkka_tidebringer_custom.modifier_kunkka_8_duration = 1 
kunkka_tidebringer_custom.modifier_kunkka_11_dmg = 3
kunkka_tidebringer_custom.modifier_kunkka_11_duration = {10,15}
kunkka_tidebringer_custom.modifier_kunkka_12 = {60,120,180}

function kunkka_tidebringer_custom:GetIntrinsicModifierName()
    return "modifier_kunkka_tidebringer_custom_passive"
end

function kunkka_tidebringer_custom:OnUpgrade()
    if not IsServer() then return end
    if self and self:GetLevel() == 1 then
        self:ToggleAutoCast()
    end
end

function kunkka_tidebringer_custom:OnOrbImpact( params, mark )
    self:GetCaster():ClearActivityModifiers()
	local range = self:GetSpecialValueFor("cleave_distance")
	local radius_start = self:GetSpecialValueFor("cleave_starting_width")
	local radius_end = self:GetSpecialValueFor("cleave_ending_width")

    local bonus = 0

    local damage_bonus = self:GetSpecialValueFor("damage_bonus")

    if self:GetCaster():HasModifier("modifier_kunkka_4") then
        bonus = bonus + (self:GetCaster():GetHealthRegen() / 100 * self.modifier_kunkka_4[self:GetCaster():GetTalentLevel("modifier_kunkka_4")])
    end

    if self:GetCaster():HasModifier("modifier_kunkka_12") then
        bonus = bonus + self.modifier_kunkka_12[self:GetCaster():GetTalentLevel("modifier_kunkka_12")]
    end

	local cleaveDamage = (params.damage + damage_bonus + bonus) * (self:GetSpecialValueFor("cleave_damage") / 100)

	self:GetCaster():EmitSound("Hero_Kunkka.Tidebringer.Attack")

    if mark then
        local kunkka_attacker = self:GetCaster():FindAbilityByName("kunkka_attacker")
        if kunkka_attacker then
            range = (params.target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
            radius_start = kunkka_attacker:GetSpecialValueFor("width")
            radius_end = kunkka_attacker:GetSpecialValueFor("width")
        end
    else
        self:UseResources(false, false, false, true)
    end

    local enemies_to_cleave = self:FindUnitsInCone(self:GetCaster():GetTeamNumber(),self:CalculateDirection(params.target, self:GetCaster()),self:GetCaster():GetAbsOrigin(), radius_start, radius_end, range, nil, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)

    local anchor = "particles/units/heroes/hero_kunkka/kunkka_spell_tidebringer.vpcf"
    if mark then
        for _, target_cleave in pairs(enemies_to_cleave) do
            ApplyDamage({victim = target_cleave, attacker = self:GetCaster(), damage = cleaveDamage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = nil, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL})
            local tidebringer_hit_fx = ParticleManager:CreateParticle(anchor, PATTACH_CUSTOMORIGIN, self:GetCaster())
            ParticleManager:SetParticleControlEnt(tidebringer_hit_fx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(tidebringer_hit_fx, 1, Vector(1,1,1))
            ParticleManager:SetParticleControlForward(tidebringer_hit_fx, 1, self:GetCaster():GetForwardVector())
            ParticleManager:SetParticleControlEnt(tidebringer_hit_fx, 2, target_cleave, PATTACH_POINT_FOLLOW, "attach_hitloc", target_cleave:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(tidebringer_hit_fx)
        end
    else
	   DoCleaveAttack( params.attacker, params.target, self, cleaveDamage, radius_start, radius_end, range, anchor )
    end

    for _, target_cleave in pairs(enemies_to_cleave) do
        if self:GetCaster():HasModifier("modifier_kunkka_8") then
            target_cleave:AddNewModifier(self:GetCaster(), self, "modifier_kunkka_tidebringer_custom_debuff_slow", {duration = self.modifier_kunkka_8_duration})
        end
    end

    if self:GetCaster():HasModifier("modifier_kunkka_11") then
        if #enemies_to_cleave > 0 then
            local mod = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kunkka_tidebringer_custom_buff_damage", {duration = self.modifier_kunkka_11_duration[self:GetCaster():GetTalentLevel("modifier_kunkka_11")]})
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kunkka_tidebringer_custom_buff_damage_stack", {duration = self.modifier_kunkka_11_duration[self:GetCaster():GetTalentLevel("modifier_kunkka_11")], count = #enemies_to_cleave})
            if mod then
                mod:SetStackCount(mod:GetStackCount() + #enemies_to_cleave)
            end
        end
    end
end

function kunkka_tidebringer_custom:FindUnitsInCone(teamNumber, vDirection, vPosition, startRadius, endRadius, flLength, hCacheUnit, targetTeam, targetUnit, targetFlags, findOrder, bCache)
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

function kunkka_tidebringer_custom:CalculateDirection(ent1, ent2)
    local pos1 = ent1
    local pos2 = ent2
    if ent1.GetAbsOrigin then pos1 = ent1:GetAbsOrigin() end
    if ent2.GetAbsOrigin then pos2 = ent2:GetAbsOrigin() end
    local direction = (pos1 - pos2):Normalized()
    return direction
end

modifier_kunkka_tidebringer_custom_passive = class({})

function modifier_kunkka_tidebringer_custom_passive:IsHidden()
    return true
end

function modifier_kunkka_tidebringer_custom_passive:IsDebuff()
    return false
end

function modifier_kunkka_tidebringer_custom_passive:IsPurgable()
    return false
end

function modifier_kunkka_tidebringer_custom_passive:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_kunkka_tidebringer_custom_passive:OnCreated( kv )
    self.ability = self:GetAbility()
    self.cast = false
    self.records = {}
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_kunkka_tidebringer_custom_passive:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility():IsFullyCastable() then
        if not self:GetCaster():HasModifier("modifier_kunkka_tidebringer_custom_particle") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kunkka_tidebringer_custom_particle", {})
        end
    else
        self:GetParent():RemoveModifierByName("modifier_kunkka_tidebringer_custom_particle")
    end
end

function modifier_kunkka_tidebringer_custom_passive:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
        MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
    }
    return funcs
end

function modifier_kunkka_tidebringer_custom_passive:OnAttack( params )
    if params.attacker~=self:GetParent() then return end
    self:GetCaster():ClearActivityModifiers()
    if self:GetParent().jinada_shuriken then
        self.records[params.record] = true
        if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
    end
    if self:ShouldLaunch( params.target ) then
        self.records[params.record] = true
        if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
    end

    self.cast = false
end

function modifier_kunkka_tidebringer_custom_passive:OnAttackStart(params)
    if params.attacker~=self:GetParent() then return end
    if self:ShouldLaunch( params.target ) then
        self:GetParent():AddActivityModifier("tidebringer")
    end
end

function modifier_kunkka_tidebringer_custom_passive:GetModifierProcAttack_Feedback( params )
    if self:GetParent().mark then
        if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params, true ) end
        return
    end
    if self.records[params.record] then
        if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
    end
end

function modifier_kunkka_tidebringer_custom_passive:OnAttackFail( params )
    if self.records[params.record] then
        if self.ability.OnOrbFail then self:GetCaster():ClearActivityModifiers() self.ability:OnOrbFail( params ) end
    end
end

function modifier_kunkka_tidebringer_custom_passive:OnAttackRecordDestroy( params )
    self:GetCaster():ClearActivityModifiers()
    self.records[params.record] = nil
end

function modifier_kunkka_tidebringer_custom_passive:OnOrder( params )
    if params.unit~=self:GetParent() then return end

    if params.ability then
        if params.ability==self:GetAbility() then
            self.cast = true
            return
        end
        local pass = false
        local behavior = params.ability:GetBehaviorInt()
        if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
            self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
            self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
        then
            local pass = true -- do nothing
        end

        if self.cast and (not pass) then
            self.cast = false
        end
    else
        if self.cast then
            if self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_POSITION ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_TARGET ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_MOVE ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_TARGET ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_STOP ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_HOLD_POSITION )
            then
                self.cast = false
            end
        end
    end
end

function modifier_kunkka_tidebringer_custom_passive:ShouldLaunch( target )
    if self.ability:GetAutoCastState() then
        if self.ability.CastFilterResultTarget~=CDOTA_Ability_Lua.CastFilterResultTarget then
            if self.ability:CastFilterResultTarget( target )==UF_SUCCESS then
                self.cast = true
            end
        else
            local nResult = UnitFilter(
                target,
                self.ability:GetAbilityTargetTeam(),
                self.ability:GetAbilityTargetType(),
                self.ability:GetAbilityTargetFlags(),
                self:GetCaster():GetTeamNumber()
            )
            if nResult == UF_SUCCESS then
                self.cast = true
            end
        end
    end

    if self.cast and self.ability:IsFullyCastable() and (not self:GetParent():IsSilenced()) then
        return true
    end

    return false
end

function modifier_kunkka_tidebringer_custom_passive:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function modifier_kunkka_tidebringer_custom_passive:GetModifierProcAttack_BonusDamage_Physical(params)
    if self.records[params.record] then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_kunkka_4") then
            bonus = bonus + (self:GetCaster():GetHealthRegen() / 100 * self:GetAbility().modifier_kunkka_4[self:GetCaster():GetTalentLevel("modifier_kunkka_4")])
        end
        if self:GetCaster():HasModifier("modifier_kunkka_12") then
            bonus = bonus + self:GetAbility().modifier_kunkka_12[self:GetCaster():GetTalentLevel("modifier_kunkka_12")]
        end
        return self:GetAbility():GetSpecialValueFor("damage_bonus") + bonus
    end
end

modifier_kunkka_tidebringer_custom_particle = class({})

function modifier_kunkka_tidebringer_custom_particle:IsPurgable() return false end
function modifier_kunkka_tidebringer_custom_particle:IsHidden() return true end
function modifier_kunkka_tidebringer_custom_particle:RemoveOnDeath() return false end

function modifier_kunkka_tidebringer_custom_particle:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Kunkaa.Tidebringer")
    local particle_glow_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_weapon_tidebringer.vpcf", PATTACH_ABSORIGIN, self:GetParent())
   	ParticleManager:SetParticleControlEnt(particle_glow_fx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_tidebringer", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle_glow_fx, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_sword", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle_glow_fx, false, false, -1, false, false)
end

modifier_kunkka_tidebringer_custom_debuff_slow = class({})

function modifier_kunkka_tidebringer_custom_debuff_slow:GetTexture()
    return "kunkka_8"
end

function modifier_kunkka_tidebringer_custom_debuff_slow:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_kunkka_tidebringer_custom_debuff_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_kunkka_8_slow
end

modifier_kunkka_tidebringer_custom_buff_damage = class({})

function modifier_kunkka_tidebringer_custom_buff_damage:GetTexture() return "kunkka_11" end

function modifier_kunkka_tidebringer_custom_buff_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_kunkka_tidebringer_custom_buff_damage:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility().modifier_kunkka_11_dmg * self:GetStackCount()
end

modifier_kunkka_tidebringer_custom_buff_damage_stack = class({})
function modifier_kunkka_tidebringer_custom_buff_damage_stack:IsHidden() return true end
function modifier_kunkka_tidebringer_custom_buff_damage_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_kunkka_tidebringer_custom_buff_damage_stack:OnCreated(params)
    if not IsServer() then return end
    self.count = params.count
end
function modifier_kunkka_tidebringer_custom_buff_damage_stack:OnDestroy()
    if not IsServer() then return end
    local modifier_kunkka_tidebringer_custom_buff_damage = self:GetCaster():FindModifierByName("modifier_kunkka_tidebringer_custom_buff_damage")
    if modifier_kunkka_tidebringer_custom_buff_damage then
        modifier_kunkka_tidebringer_custom_buff_damage:SetStackCount(modifier_kunkka_tidebringer_custom_buff_damage:GetStackCount() - self.count)
    end
end