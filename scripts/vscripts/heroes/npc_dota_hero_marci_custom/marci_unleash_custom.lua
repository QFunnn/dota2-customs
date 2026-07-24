--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_marci_unleash_custom", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_unleash_custom_attacks", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_unleash_custom_attacks_refresh", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_unleash_custom_attacks_animation", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_unleash_custom_debuff", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_unleash_custom_str_buff", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_unleash_custom_str_debuff", "heroes/npc_dota_hero_marci_custom/marci_unleash_custom", LUA_MODIFIER_MOTION_NONE )

marci_unleash_custom = class({})

marci_unleash_custom.modifier_marci_6 = {-1,-2}
marci_unleash_custom.modifier_marci_3 = {4,8}
marci_unleash_custom.modifier_marci_5_creep_damage = {50,100,150}
marci_unleash_custom.modifier_marci_5 = 5
marci_unleash_custom.modifier_marci_5_duration = {5,10,15}
marci_unleash_custom.modifier_marci_7 = 1

function marci_unleash_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_pulse_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_stack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", context )
end

function marci_unleash_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_marci_14") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function marci_unleash_custom:GetIntrinsicModifierName()
    if self:GetCaster():HasModifier("modifier_marci_15") then return end
    if self:GetCaster():HasModifier("modifier_marci_14") then
        return "modifier_marci_unleash_custom"
    end
end

function marci_unleash_custom:GetCooldown( level )
    if self:GetCaster():HasModifier("modifier_marci_14") then
        return 0
    end
	return self.BaseClass.GetCooldown( self, level )
end

function marci_unleash_custom:GetManaCost( level )
    if self:GetCaster():HasModifier("modifier_marci_14") then
        return 0
    end
	return self.BaseClass.GetManaCost( self, level )
end

function marci_unleash_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor( "duration" )
    if self:GetCaster():HasModifier("modifier_marci_3") then
        duration = duration + self.modifier_marci_3[self:GetCaster():GetTalentLevel("modifier_marci_3")]
    end
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_marci_unleash_custom", {duration = duration} )
end

function marci_unleash_custom:Pulse( center )
    local ability_usefull = self
    if self:GetCaster():HasModifier("modifier_marci_7") then
        ability_usefull = self:GetCaster():FindAbilityByName("marci_unleash_custom_magic_immune")
    end
    local pulse_radius = self:GetSpecialValueFor( "pulse_radius" )
    local pulse_debuff_duration = self:GetSpecialValueFor( "pulse_debuff_duration" )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), center, nil, pulse_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
        local pulse_damage = self:GetSpecialValueFor( "pulse_damage" )
        if not enemy:IsHero() and self:GetCaster():HasModifier("modifier_marci_5") then
            pulse_damage = pulse_damage + self.modifier_marci_5_creep_damage[self:GetCaster():GetTalentLevel("modifier_marci_5")]
        end
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = pulse_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = ability_usefull })
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_marci_unleash_custom_debuff", { duration = pulse_debuff_duration } )
        if self:GetCaster():HasModifier("modifier_marci_5") and enemy:IsRealHero() then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_marci_unleash_custom_str_buff", {duration = self.modifier_marci_5_duration[self:GetCaster():GetTalentLevel("modifier_marci_5")]})
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_marci_unleash_custom_str_debuff", {duration = self.modifier_marci_5_duration[self:GetCaster():GetTalentLevel("modifier_marci_5") * (1-enemy:GetStatusResistance())]})
        end
        if self:GetCaster():HasModifier("modifier_marci_7") then
            enemy:AddNewModifier(self:GetCaster(), ability_usefull, "modifier_marci_unleash_pulse_silence", {duration = self.modifier_marci_7})
        end
	end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, center )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(pulse_radius,pulse_radius,pulse_radius) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( center, "Hero_Marci.Unleash.Pulse", self:GetCaster() )
    if self:GetCaster():HasModifier("modifier_marci_6") then
        local cooldown = self:GetCooldownTimeRemaining()
        local time_reduction = self.modifier_marci_6[self:GetCaster():GetTalentLevel("modifier_marci_6")]
        if cooldown > 0 then
            if (cooldown + time_reduction) > 0 then
                self:EndCooldown()
                self:StartCooldown(cooldown + time_reduction)
            else
                self:EndCooldown()
            end
        end
    end
end

modifier_marci_unleash_custom = class({})
function modifier_marci_unleash_custom:IsHidden() return self:GetCaster():HasModifier("modifier_marci_14") end
function modifier_marci_unleash_custom:IsPurgable() return false end
function modifier_marci_unleash_custom:IsPurgeException() return false end
function modifier_marci_unleash_custom:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_marci_14") end
function modifier_marci_unleash_custom:OnCreated( kv )
    self.bonus_movespeed = self:GetAbility():GetSpecialValueFor( "bonus_movespeed" )
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( particle )
    self:GetParent():EmitSound("Hero_Marci.Unleash.Cast")
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_marci_unleash_custom_attacks", {})
    self:StartIntervalThink(0.25)
end

function modifier_marci_unleash_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_marci_14") and not self:GetParent():HasModifier("modifier_marci_unleash_custom_attacks") then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_marci_unleash_custom_attacks", {})
    end
end

function modifier_marci_unleash_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_marci_unleash_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed
end

function modifier_marci_unleash_custom:OnDestroy()
	if not IsServer() then return end
	local fury = self:GetParent():FindModifierByNameAndCaster( "modifier_marci_unleash_custom_attacks", self:GetParent() )
	if fury then
		fury:ForceDestroy()
	end
	local recovery = self:GetParent():FindModifierByNameAndCaster( "modifier_marci_unleash_custom_attacks_refresh", self:GetParent() )
	if recovery then
		recovery:ForceDestroy()
	end
end

modifier_marci_unleash_custom_attacks = class({})
function modifier_marci_unleash_custom_attacks:IsPurgable() return false end
function modifier_marci_unleash_custom_attacks:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_marci_14") end

function modifier_marci_unleash_custom_attacks:OnCreated( kv )
	self.flurry_bonus_attack_speed = self:GetAbility():GetSpecialValueFor( "flurry_bonus_attack_speed" )
	self.time_between_flurries = self:GetAbility():GetSpecialValueFor( "time_between_flurries" )
	self.charges_per_flurry = self:GetAbility():GetSpecialValueFor( "charges_per_flurry" )
	self.max_time_window_per_hit = self:GetAbility():GetSpecialValueFor( "max_time_window_per_hit" )
    self.pulse_radius = self:GetAbility():GetSpecialValueFor( "pulse_radius" )
    self.pulse_debuff_duration = self:GetAbility():GetSpecialValueFor( "pulse_debuff_duration" )
    self.pulse_damage = self:GetAbility():GetSpecialValueFor( "pulse_damage" )
	if not IsServer() then return end
	self.counter = self.charges_per_flurry
	self:SetStackCount( self.counter )
	self.success = 0
	self.modifier_marci_unleash_custom_attacks_animation = self:GetParent():AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_marci_unleash_custom_attacks_animation", {})

    ----------------------------------------------------- Main ---------------------------------------------------
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_l", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_r", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 5, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 6, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true)
	self:AddParticle( effect_cast, false, false, -1, false, false)
	self:GetParent():EmitSound("Hero_Marci.Unleash.Charged")
	EmitSoundOnClient( "Hero_Marci.Unleash.Charged.2D", self:GetParent():GetPlayerOwner() )

    ------------------------------------------------------ Overhead ---------------------------------------------------
    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self.counter, 0 ) )
	self:AddParticle( self.effect_cast, false, false, 1, false, true )
end

function modifier_marci_unleash_custom_attacks:OnDestroy()
	if not IsServer() then return end
	if not self.modifier_marci_unleash_custom_attacks_animation:IsNull() then
		self.modifier_marci_unleash_custom_attacks_animation:Destroy()
	end
	local modifier_marci_unleash_custom = self:GetParent():FindModifierByNameAndCaster( "modifier_marci_unleash_custom", self:GetParent() )
	if not modifier_marci_unleash_custom then return end
	if self.forced then return end
    if self:GetParent():HasModifier("modifier_marci_14") then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_marci_unleash_custom_attacks_refresh", {duration = FrameTime(), success = self.success})
    else
	    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_marci_unleash_custom_attacks_refresh", {duration = self.time_between_flurries, success = self.success})
    end
	if self.success~=1 then return end
end

function modifier_marci_unleash_custom_attacks:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_marci_unleash_custom_attacks:GetModifierAttackSpeed_Limit()
	return 1
end

function modifier_marci_unleash_custom_attacks:OnAttack(params)
    if not IsServer() then return end
    if params.attacker~=self:GetParent() then return end
    self:StartIntervalThink( self.max_time_window_per_hit )
	self.counter = self.counter - 1
	self:SetStackCount( self.counter )
    if self.effect_cast then
        ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self.counter, 0 ) )
    end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	if self.counter <= 0 then
		self.success = 1
		self:Pulse( params.target:GetOrigin() )
		self:Destroy()
	end
end

function modifier_marci_unleash_custom_attacks:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent():HasModifier("modifier_marci_14") then return end
	return self.flurry_bonus_attack_speed
end

function modifier_marci_unleash_custom_attacks:GetActivityTranslationModifiers()
	if self:GetStackCount()==1 then
		return "flurry_pulse_attack"
	end
	if self:GetStackCount()%2==0 then
		return "flurry_attack_b"
	end
	return "flurry_attack_a"
end

function modifier_marci_unleash_custom_attacks:OnIntervalThink()
    if self:GetParent():IsAlive() then
	    self:Destroy()
    end
end

function modifier_marci_unleash_custom_attacks:Pulse( center )
    self:GetAbility():Pulse(center)
end

function modifier_marci_unleash_custom_attacks:ForceDestroy()
	self.forced = true
	self:Destroy()
end

function modifier_marci_unleash_custom_attacks:ShouldUseOverheadOffset()
	return true
end

modifier_marci_unleash_custom_attacks_animation = class({})
function modifier_marci_unleash_custom_attacks_animation:IsHidden() return true end
function modifier_marci_unleash_custom_attacks_animation:IsDebuff() return false end
function modifier_marci_unleash_custom_attacks_animation:IsPurgable() return false end
function modifier_marci_unleash_custom_attacks_animation:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end
function modifier_marci_unleash_custom_attacks_animation:GetActivityTranslationModifiers()
	return "unleash"
end

modifier_marci_unleash_custom_attacks_refresh = class({})
function modifier_marci_unleash_custom_attacks_refresh:IsDebuff() return true end
function modifier_marci_unleash_custom_attacks_refresh:IsPurgable() return false end
function modifier_marci_unleash_custom_attacks_refresh:OnCreated( kv )
	self.recovery_fixed_attack_rate = self:GetAbility():GetSpecialValueFor( "recovery_fixed_attack_rate" )
	if not IsServer() then return end
	self.success = kv.success==1
end

function modifier_marci_unleash_custom_attacks_refresh:OnDestroy()
	if not IsServer() then return end
	local modifier_marci_unleash_custom = self:GetParent():FindModifierByNameAndCaster( "modifier_marci_unleash_custom", self:GetParent() )
	if not modifier_marci_unleash_custom then return end
	if self.forced then return end
	self:GetParent():AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_marci_unleash_custom_attacks", {} )
end

function modifier_marci_unleash_custom_attacks_refresh:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
	}
end

function modifier_marci_unleash_custom_attacks_refresh:GetModifierFixedAttackRate( params )
	return self.recovery_fixed_attack_rate
end

function modifier_marci_unleash_custom_attacks_refresh:ForceDestroy()
	self.forced = true
	self:Destroy()
end

modifier_marci_unleash_custom_debuff = class({})

function modifier_marci_unleash_custom_debuff:OnCreated( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "pulse_attack_slow_pct" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "pulse_move_slow_pct" )
end

function modifier_marci_unleash_custom_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_marci_unleash_custom_debuff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_marci_unleash_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_marci_unleash_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_marci_unleash_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_unleash_pulse_debuff.vpcf"
end

function modifier_marci_unleash_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_marci_unleash_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_marci_unleash_custom_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

modifier_marci_unleash_custom_str_buff = class({})
function modifier_marci_unleash_custom_str_buff:GetTexture() return "marci_5" end
function modifier_marci_unleash_custom_str_buff:OnCreated()
    if not IsServer() then return end
    self:IncrementStackCount()
    self:GetParent():CalculateStatBonus(true)
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end
function modifier_marci_unleash_custom_str_buff:OnRefresh()
    self:OnCreated()
end
function modifier_marci_unleash_custom_str_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
end
function modifier_marci_unleash_custom_str_buff:GetModifierBonusStats_Strength()
    return self:GetAbility().modifier_marci_5 * self:GetStackCount()
end

modifier_marci_unleash_custom_str_debuff = class({})
function modifier_marci_unleash_custom_str_debuff:GetTexture() return "marci_5" end
function modifier_marci_unleash_custom_str_debuff:OnCreated()
    if not IsServer() then return end
    self:IncrementStackCount()
    self:GetParent():CalculateStatBonus(true)
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end
function modifier_marci_unleash_custom_str_debuff:OnRefresh()
    self:OnCreated()
end
function modifier_marci_unleash_custom_str_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
end
function modifier_marci_unleash_custom_str_debuff:GetModifierBonusStats_Strength()
    return -(self:GetAbility().modifier_marci_5 * self:GetStackCount())
end

marci_unleash_custom_magic_immune = marci_unleash_custom