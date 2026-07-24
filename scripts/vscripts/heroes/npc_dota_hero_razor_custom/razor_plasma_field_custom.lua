--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_plasma_field_custom", "heroes/npc_dota_hero_razor_custom/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_slow", "heroes/npc_dota_hero_razor_custom/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_handler", "heroes/npc_dota_hero_razor_custom/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_plasma_field_custom_silence", "heroes/npc_dota_hero_razor_custom/razor_plasma_field_custom", LUA_MODIFIER_MOTION_NONE)

razor_plasma_field_custom = class({})
razor_plasma_field_custom.modifier_razor_15 = {-1,-2}
razor_plasma_field_custom.modifier_razor_19 = {100,200}
razor_plasma_field_custom.modifier_razor_19_slow = {0.5,1}
razor_plasma_field_custom.modifier_razor_21_super_field = 4
razor_plasma_field_custom.modifier_razor_21_duration = 2

function razor_plasma_field_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_plasmafield.vpcf", context )
    PrecacheResource( "particle","particles/razor_custom/nullifier_mute.vpcf", context )
    PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_static_field.vpcf", context )
    PrecacheResource( "particle","particles/econ/items/razor/razor_ti6/razor_plasmafield_ti6.vpcf", context )
    PrecacheResource( "particle","particles/econ/items/razor/razor_arcana/razor_arcana_plasma_field.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_razor.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_razor.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_razor.vpcf", context)
end

function razor_plasma_field_custom:GetAbilityChargeRestoreTime(level)
    local cooldown_reduction = 0
    if self:GetCaster():HasModifier("modifier_razor_15") then
        cooldown_reduction = self.modifier_razor_15[self:GetCaster():GetTalentLevel("modifier_razor_15")]
    end
    return self.BaseClass.GetAbilityChargeRestoreTime( self, level ) + cooldown_reduction
end

function razor_plasma_field_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("radius")
end

function razor_plasma_field_custom:GetIntrinsicModifierName()
    return "modifier_razor_plasma_field_custom_handler"
end

function razor_plasma_field_custom:OnSpellStart(new_target)
    if not IsServer() then return end
    local target = self:GetCaster()
    if new_target then
        target = new_target
    end
    local is_super_field = nil
    local modifier_razor_plasma_field_custom_handler = self:GetCaster():FindModifierByName("modifier_razor_plasma_field_custom_handler")
    if modifier_razor_plasma_field_custom_handler and self:GetCaster():HasModifier("modifier_razor_21") then
        modifier_razor_plasma_field_custom_handler:IncrementStackCount()
        if modifier_razor_plasma_field_custom_handler:GetStackCount() >= self.modifier_razor_21_super_field then
            is_super_field = true
            modifier_razor_plasma_field_custom_handler:SetStackCount(0)
        end
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_razor_plasma_field_custom", {is_super_field = is_super_field})
end 

modifier_razor_plasma_field_custom = class({})
function modifier_razor_plasma_field_custom:IsHidden() return true end
function modifier_razor_plasma_field_custom:IsPurgable() return false end
function modifier_razor_plasma_field_custom:RemoveOnDeath() return false end
function modifier_razor_plasma_field_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_razor_plasma_field_custom:OnCreated( kv )
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.start_radius = 0
    self.current_radius = 0
    self.width = 80
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.speed = 636
    self.min_damage = self.ability:GetSpecialValueFor("damage_min")
    self.max_damage = self.ability:GetSpecialValueFor("damage_max")
    self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
    self.slow_max = self.ability:GetSpecialValueFor("slow_max")
    self.slow_min = self.ability:GetSpecialValueFor("slow_min")
    if self.caster:HasModifier("modifier_razor_19") then
        self.slow_max = self.slow_max + self.ability.modifier_razor_19_slow[self:GetCaster():GetTalentLevel("modifier_razor_19")]
        self.slow_min = self.slow_min + self.ability.modifier_razor_19_slow[self:GetCaster():GetTalentLevel("modifier_razor_19")]
        self.radius = self.radius + self.ability.modifier_razor_19[self:GetCaster():GetTalentLevel("modifier_razor_19")]
    end
    self.end_radius = self.radius + self.width
    self.max_radius = self.end_radius
    local particle_name = "particles/units/heroes/hero_razor/razor_plasmafield.vpcf"
    if self:GetCaster():HasModifier("modifier_razor_2") then
        particle_name = "particles/econ/items/razor/razor_arcana/razor_arcana_plasma_field.vpcf"
    end
    self.effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl(self.effect_cast , 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.speed, self.max_radius, 1 ) )
    self:AddParticle( self.effect_cast, false, false, -1, false, false )
    self.parent:EmitSound( "Ability.PlasmaField" )
    self.is_super_field = kv.is_super_field
    self.damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}
    self.outward = true
    self.targets = {}
    self.interval = 0.01
    self.circle_duration = 0
    self.damage_timer = 0
    self:StartIntervalThink( self.interval )
    self:OnIntervalThink()
end

function modifier_razor_plasma_field_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self.parent or self.parent:IsNull() then
        return
    end
    AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, self.interval, false)
    if self.effect_cast then 
        ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetAbsOrigin() )
    end 
    local damage_min = self.min_damage
    local damage_max = self.max_damage
    if self.outward then
        self.current_radius =  math.min(math.max(0, self.current_radius + self.speed * self.interval), self.max_radius)
    else
        self.current_radius =  math.max(0, self.current_radius + self.speed * self.interval)
    end
    local dealt_damage = false
    self.damage_timer = self.damage_timer + self.interval
    local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.current_radius + self.width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
    for _,target in pairs(targets) do
	    local distance = (target:GetOrigin()-self.parent:GetOrigin()):Length2D()
	    local real_radius = self.current_radius
	    if not self.targets[target] and distance > (real_radius -self.width*2) then
	        dealt_damage = true
		    self.targets[target] = true
		    local k = distance/self.radius
            if self:GetCaster():HasModifier("modifier_razor_2") then
                k = (1 - k)
            end
            if self.is_super_field then
                k = 1
            end
		    self.damageTable.victim = target
		    self.damageTable.damage = math.max(damage_min, math.min(damage_max, damage_min + (damage_max - damage_min)*k))
		    local slow = math.max(self.slow_min, math.min(self.slow_max, self.slow_min + (self.slow_max - self.slow_min)*k))
		    target:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_slow", {slow = slow, duration = self.slow_duration*(1 - target:GetStatusResistance())})
		    ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, target ) )
		    ApplyDamage(self.damageTable)
		    target:EmitSound( "Ability.PlasmaFieldImpact" )
            print("damage calc")
	    end
        if self.is_super_field and self.damage_timer >= 1 and self.outward then
            local k = 1
            local slow = math.max(self.slow_min, math.min(self.slow_max, self.slow_min + (self.slow_max - self.slow_min)*k))
		    target:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_slow", {slow = slow, duration = 1.1})
            target:AddNewModifier(self.caster, self.ability, "modifier_razor_plasma_field_custom_silence", {duration = 1.1})
            self.damageTable.victim = target
		    self.damageTable.damage = math.max(damage_min, math.min(damage_max, damage_min + (damage_max - damage_min)*k))
            ApplyDamage(self.damageTable)
            ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, target ) )
            target:EmitSound( "Ability.PlasmaFieldImpact" )
            print("damag epug")
        end
    end
    if self:GetCaster():HasModifier("modifier_razor_21") then
        if self.damage_timer >= 1 then
            self.damage_timer = 0
        else
            self.damage_timer = self.damage_timer + self.interval
        end
    end
    if self.outward and self.current_radius>=self.end_radius then
        if self:GetCaster():HasModifier("modifier_razor_21") then
            self.circle_duration = self.circle_duration + self.interval
        end
        if (self.circle_duration >= self:GetAbility().modifier_razor_21_duration) or not self.is_super_field then
            self:ChangeDir()
        end
    end
    if not self.outward and self.current_radius<=self.end_radius then
        self:Destroy()
        return
    end 
end 

function modifier_razor_plasma_field_custom:ChangeDir()
    if self.effect_cast then 	
        ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.speed, self.max_radius, -1 ) )
    end 
    self.outward = not self.outward
    self.speed = self.speed*-1
    if self.outward == true then 
        self.end_radius = self.radius + self.width
        self.start_radius = 0
    else 
        self.end_radius = 0
        self.start_radius = self.radius + self.width
    end 
    self.current_radius = self.current_radius - self.speed*self.interval
    self.targets = {}
end

function modifier_razor_plasma_field_custom:OnDestroy()
    if not IsServer() then return end
    AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), self.radius, 2, false)
end

modifier_razor_plasma_field_custom_slow = class({})
function modifier_razor_plasma_field_custom_slow:IsPurgable() return true end
function modifier_razor_plasma_field_custom_slow:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_razor_plasma_field_custom_slow:OnCreated(table)
    if not IsServer() then return end 
    self.slow = table.slow
    self:SetHasCustomTransmitterData( true )
end 

function modifier_razor_plasma_field_custom_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_razor_plasma_field_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self.slow * -1
end

function modifier_razor_plasma_field_custom_slow:AddCustomTransmitterData()
	local data = 
    {
		slow = self.slow,
	}
	return data
end

function modifier_razor_plasma_field_custom_slow:HandleCustomTransmitterData( data )
	self.slow = data.slow
end

modifier_razor_plasma_field_custom_handler = class({})
function modifier_razor_plasma_field_custom_handler:GetTexture() return "razor_21" end
function modifier_razor_plasma_field_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_razor_21") end
function modifier_razor_plasma_field_custom_handler:IsPurgable() return false end
function modifier_razor_plasma_field_custom_handler:IsPurgeException() return false end
function modifier_razor_plasma_field_custom_handler:RemoveOnDeath() return false end

modifier_razor_plasma_field_custom_silence = class({})
function modifier_razor_plasma_field_custom_silence:GetTexture() return "razor_21" end
function modifier_razor_plasma_field_custom_silence:IsPurgable() return false end
function modifier_razor_plasma_field_custom_silence:IsPurgeException() return false end

function modifier_razor_plasma_field_custom_silence:CheckState()
    return
    {
        [MODIFIER_STATE_MUTED] = true
    }
end

function modifier_razor_plasma_field_custom_silence:GetEffectName()
    return "particles/razor_custom/nullifier_mute.vpcf"
end

function modifier_razor_plasma_field_custom_silence:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end