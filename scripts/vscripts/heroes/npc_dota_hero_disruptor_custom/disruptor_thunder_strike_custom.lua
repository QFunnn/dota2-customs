--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_disruptor_thunder_strike_custom", "heroes/npc_dota_hero_disruptor_custom/disruptor_thunder_strike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_thunder_strike_custom_talent_handler", "heroes/npc_dota_hero_disruptor_custom/disruptor_thunder_strike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_thunder_strike_custom_slow", "heroes/npc_dota_hero_disruptor_custom/disruptor_thunder_strike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_thunder_strike_custom_attackspeed_stack", "heroes/npc_dota_hero_disruptor_custom/disruptor_thunder_strike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_thunder_strike_custom_attackspeed_buff", "heroes/npc_dota_hero_disruptor_custom/disruptor_thunder_strike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_disruptor_thunder_strike_custom_counter", "heroes/npc_dota_hero_disruptor_custom/disruptor_thunder_strike_custom", LUA_MODIFIER_MOTION_NONE )

disruptor_thunder_strike_custom = class({})

disruptor_thunder_strike_custom.modifier_disruptor_1 = {-0.75,-1.5}
disruptor_thunder_strike_custom.modifier_disruptor_2 = {1,2,3}
disruptor_thunder_strike_custom.modifier_disruptor_3 = {5,10}
disruptor_thunder_strike_custom.modifier_disruptor_3_duration = 4
disruptor_thunder_strike_custom.modifier_disruptor_4 = {40,60,80}

function disruptor_thunder_strike_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_thunder_strike_buff.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_disruptor/disruptor_pulse_knockback_area.vpcf', context )
end

function disruptor_thunder_strike_custom:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function disruptor_thunder_strike_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() and (not self:GetCaster():HasModifier("modifier_disruptor_7")) then
        return UF_FAIL_MAGIC_IMMUNE_ENEMY
    end

    if not IsServer() then return UF_SUCCESS end
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
end

function disruptor_thunder_strike_custom:GetIntrinsicModifierName()
	return "modifier_disruptor_thunder_strike_custom_talent_handler"
end

function disruptor_thunder_strike_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	target:RemoveModifierByName("modifier_disruptor_thunder_strike_custom")
	target:AddNewModifier( self:GetCaster(), self, "modifier_disruptor_thunder_strike_custom", {})
	self:GetCaster():EmitSound("Hero_Disruptor.ThunderStrike.Cast")
end

modifier_disruptor_thunder_strike_custom = class({})

function modifier_disruptor_thunder_strike_custom:RemoveOnDeath()
	return false
end

function modifier_disruptor_thunder_strike_custom:IsPurgable() return not self:GetCaster():HasModifier("modifier_disruptor_7") end

function modifier_disruptor_thunder_strike_custom:DestroyOnExpire()
	return false
end

function modifier_disruptor_thunder_strike_custom:OnCreated( kv )
	self.count = self:GetAbility():GetSpecialValueFor( "strikes" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.interval = self:GetAbility():GetSpecialValueFor( "strike_interval" )
	if self:GetCaster():HasModifier("modifier_disruptor_1") then
		self.interval = self.interval + self:GetAbility().modifier_disruptor_1[self:GetCaster():GetTalentLevel("modifier_disruptor_1")]
	end
	if self:GetCaster():HasModifier("modifier_disruptor_2") then
		self.count = self.count + self:GetAbility().modifier_disruptor_2[self:GetCaster():GetTalentLevel("modifier_disruptor_2")]
	end
	self.interval_time = self:GetAbility():GetSpecialValueFor( "strike_interval" )
	local damage = self:GetAbility():GetSpecialValueFor( "strike_damage" )
	if not IsServer() then return end
	self.damageTable = 
	{
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	local duration = (self.count-1) * self.interval
	self:SetDuration( duration, true )
	self:StartIntervalThink( FrameTime() )
	self:OnIntervalThink()
	self:GetParent():EmitSound("Hero_Disruptor.ThunderStrike.Thunderator")
end

function modifier_disruptor_thunder_strike_custom:OnDestroy()
	if not IsServer() then return end
	AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), 450, 3.34, false )
	self:GetParent():StopSound("Hero_Disruptor.ThunderStrike.Thunderator")
end

function modifier_disruptor_thunder_strike_custom:OnIntervalThink()
	if not IsServer() then return end

	self.interval_time = self.interval_time + FrameTime()

	AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), 50, FrameTime() * 2, false )

	if self.interval_time >= self.interval then
		if self:GetCaster():HasModifier("modifier_disruptor_3") then
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_attackspeed_stack", {duration = self:GetAbility().modifier_disruptor_3_duration})
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_attackspeed_buff", {duration = self:GetAbility().modifier_disruptor_3_duration})
		end

		local flag = 0
		if self:GetCaster():HasModifier("modifier_disruptor_7") then
			flag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
		end

		self.interval_time = 0
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flag, 0, false )

        if self:GetParent():HasModifier("modifier_disruptor_kinetic_field_custom") or self:GetParent():HasModifier("modifier_disruptor_kinetic_field_custom_big") then
            local enemies_circle = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flag, 0, false ) 
            for ___, enemy_circle in pairs(enemies_circle) do
                if enemy_circle:HasModifier("modifier_disruptor_kinetic_field_custom") or enemy_circle:HasModifier("modifier_disruptor_kinetic_field_custom_big") then
                    table.insert(enemies, enemy_circle)
                end
            end
        end
        
		for _,enemy in pairs(enemies) do
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_slow", {duration = self.slow_duration})
		end

		self:PlayEffects()

		self.count = self.count - 1

		if self.count < 1 then
			self:Destroy()
		end
	end
end

function modifier_disruptor_thunder_strike_custom:GetEffectName()
	return "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_buff.vpcf"
end

function modifier_disruptor_thunder_strike_custom:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_disruptor_thunder_strike_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 2, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl(effect_cast, 7, Vector(self.radius,self.radius,self.radius))
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Disruptor.ThunderStrike.Target", self:GetCaster() )
end

modifier_disruptor_thunder_strike_custom_slow = class({})

function modifier_disruptor_thunder_strike_custom_slow:IsHidden() return true end

function modifier_disruptor_thunder_strike_custom_slow:OnCreated(kv)
    local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    self:AddParticle(fx, false, false, -1, false, false)
end

function modifier_disruptor_thunder_strike_custom_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_disruptor_thunder_strike_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow_amount")
end

function modifier_disruptor_thunder_strike_custom_slow:GetModifierAttackSpeedBonus_Constant()
	return -self:GetAbility():GetSpecialValueFor("slow_amount")
end

modifier_disruptor_thunder_strike_custom_attackspeed_stack = class({})
function modifier_disruptor_thunder_strike_custom_attackspeed_stack:IsHidden() return true end
function modifier_disruptor_thunder_strike_custom_attackspeed_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_disruptor_thunder_strike_custom_attackspeed_buff = class({})

function modifier_disruptor_thunder_strike_custom_attackspeed_buff:GetTexture() return "disruptor_3" end

function modifier_disruptor_thunder_strike_custom_attackspeed_buff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_disruptor_thunder_strike_custom_attackspeed_buff:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_disruptor_thunder_strike_custom_attackspeed_stack")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_disruptor_thunder_strike_custom_attackspeed_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_disruptor_thunder_strike_custom_attackspeed_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetStackCount() * self:GetAbility().modifier_disruptor_3[self:GetCaster():GetTalentLevel("modifier_disruptor_3")]
end

modifier_disruptor_thunder_strike_custom_counter = class({})

function modifier_disruptor_thunder_strike_custom_counter:RemoveOnDeath()
	return false
end

function modifier_disruptor_thunder_strike_custom_counter:DestroyOnExpire()
	return false
end

function modifier_disruptor_thunder_strike_custom_counter:IsHidden() return true end

function modifier_disruptor_thunder_strike_custom_counter:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_disruptor_thunder_strike_custom_counter:OnCreated( kv )
	self.count = kv.count
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	local damage = self:GetAbility():GetSpecialValueFor( "strike_damage" )
	if not IsServer() then return end
	self.damageTable = 
	{
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	self:GetParent():EmitSound("Hero_Disruptor.ThunderStrike.Thunderator")
	self:OnIntervalThink()
end

function modifier_disruptor_thunder_strike_custom_counter:OnDestroy()
	if not IsServer() then return end
	AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), 450, 1, false )
	self:GetParent():StopSound("Hero_Disruptor.ThunderStrike.Thunderator")
end

function modifier_disruptor_thunder_strike_custom_counter:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_disruptor_3") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_attackspeed_stack", {duration = self:GetAbility().modifier_disruptor_3_duration})
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_attackspeed_buff", {duration = self:GetAbility().modifier_disruptor_3_duration})
	end
	local flag = 0
	if self:GetCaster():HasModifier("modifier_disruptor_7") then
		flag = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flag, 0, false )
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_counter_slow", {duration = self.slow_duration})
	end
	self:PlayEffects()
	Timers:CreateTimer(0.1, function()
		self:Destroy()
	end)
end

function modifier_disruptor_thunder_strike_custom_counter:GetEffectName()
	return "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_buff.vpcf"
end

function modifier_disruptor_thunder_strike_custom_counter:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_disruptor_thunder_strike_custom_counter:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 2, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl(effect_cast, 7, Vector(self.radius,self.radius,self.radius))
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Disruptor.ThunderStrike.Target", self:GetCaster() )
end

modifier_disruptor_thunder_strike_custom_talent_handler = class({})

function modifier_disruptor_thunder_strike_custom_talent_handler:IsHidden() return true end
function modifier_disruptor_thunder_strike_custom_talent_handler:IsPurgable() return false end
function modifier_disruptor_thunder_strike_custom_talent_handler:IsPurgeException() return false end
function modifier_disruptor_thunder_strike_custom_talent_handler:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_disruptor_thunder_strike_custom_talent_handler:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if not self:GetParent():HasModifier("modifier_disruptor_4") then return end
	if RollPercentage(self:GetAbility().modifier_disruptor_4[self:GetCaster():GetTalentLevel("modifier_disruptor_4")]) then
		params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disruptor_thunder_strike_custom_counter", {count = 1})
	end
end














