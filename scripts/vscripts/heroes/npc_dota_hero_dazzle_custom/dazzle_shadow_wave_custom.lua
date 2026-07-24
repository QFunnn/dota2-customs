--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dazzle_shadow_wave_custom_slow", "heroes/npc_dota_hero_dazzle_custom/dazzle_shadow_wave_custom", LUA_MODIFIER_MOTION_NONE )

dazzle_shadow_wave_custom = class({})

dazzle_shadow_wave_custom.modifier_dazzle_19_duration = 2
dazzle_shadow_wave_custom.modifier_dazzle_19 = {-20,-40}
dazzle_shadow_wave_custom.modifier_dazzle_19_turn = {-20,-40}
dazzle_shadow_wave_custom.modifier_dazzle_15 = {10,15,20}

function dazzle_shadow_wave_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shadow_wave.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_bounce.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_impact_damage.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_inverse.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_dazzle.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_dazzle.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_dazzle.vpcf", context)
end

function dazzle_shadow_wave_custom:GetCooldown(level)
    local mult = 1
    if self:GetCaster():HasModifier("modifier_dazzle_nothl_projection_soul_clone") then
        local dazzle_nothl_projection = self:GetCaster():FindAbilityByName("dazzle_nothl_projection")
        mult = mult - (dazzle_nothl_projection:GetSpecialValueFor("shadow_wave_cdr") / 100)
    end
    return self.BaseClass.GetCooldown( self, level ) * mult
end

function dazzle_shadow_wave_custom:CastFilterResultTarget( target )
    if not self:GetCaster():HasModifier("modifier_dazzle_15") then
        if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            return UF_FAIL_ENEMY
        end
    end
	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function dazzle_shadow_wave_custom:OnSpellStart()
    if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	self.radius = self:GetSpecialValueFor( "damage_radius" )
	self.bounce_radius = self:GetSpecialValueFor( "bounce_radius" )
	local jumps = self:GetSpecialValueFor( "max_targets" )
	self.damage = self:GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_dazzle_15") then
        self.damage = self.damage + (self:GetCaster():GetMaxMana() / 100 * self.modifier_dazzle_15[self:GetCaster():GetTalentLevel("modifier_dazzle_15")])
    end
	self.damageTable = 
    {
		attacker = caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self,
        damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK,
	}
	self.healedUnits = {}
	table.insert( self.healedUnits, caster )
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        self:Jump( jumps, caster, target )
    else
        if not target:TriggerSpellAbsorb(self) then
            self:JumpDamage( jumps, caster, target )
        end
    end
	self:GetCaster():EmitSound("Hero_Dazzle.Shadow_Wave")
end

function dazzle_shadow_wave_custom:Jump( jumps, source, target )
    if not IsServer() then return end
	source:Heal( self.damage, self )
    local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
    if dazzle_innate_weave_custom and dazzle_innate_weave_custom:GetLevel() > 0 then
        dazzle_innate_weave_custom:TargetModifier(source)
    end
	local enemies = FindUnitsInRadius( source:GetTeamNumber(), source:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
		self:PlayEffects2( enemy )
        local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
        if dazzle_innate_weave_custom and dazzle_innate_weave_custom:GetLevel() > 0 then
            dazzle_innate_weave_custom:TargetModifier(enemy)
        end
        if self:GetCaster():HasModifier("modifier_dazzle_19") then
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_dazzle_shadow_wave_custom_slow", {duration = self.modifier_dazzle_19_duration * (1 - enemy:GetStatusResistance())})
        end
	end
	local jump = jumps-1
	if jump <0 then
		return
	end
	local nextTarget = nil
	if target and target~=source then
		nextTarget = target
	else
		local allies = FindUnitsInRadius( source:GetTeamNumber(), source:GetOrigin(), nil, self.bounce_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
		for _,ally in pairs(allies) do
			local pass = false
			for _,unit in pairs(self.healedUnits) do
				if ally==unit then
					pass = true
				end
			end

			if not pass then
				nextTarget = ally
				break
			end
		end
	end
	if nextTarget then
		table.insert( self.healedUnits, nextTarget )
		self:Jump( jump, nextTarget )
	end
	self:PlayEffects1( source, nextTarget )
end

function dazzle_shadow_wave_custom:JumpDamage( jumps, source, target )
    if not IsServer() then return end
    if source ~= self:GetCaster() then
        self.damageTable.victim = source
        ApplyDamage( self.damageTable )
        if self:GetCaster():HasModifier("modifier_dazzle_19") then
            source:AddNewModifier(self:GetCaster(), self, "modifier_dazzle_shadow_wave_custom_slow", {duration = self.modifier_dazzle_19_duration * (1 - source:GetStatusResistance())})
        end
    end
    local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
    if dazzle_innate_weave_custom and dazzle_innate_weave_custom:GetLevel() > 0 then
        dazzle_innate_weave_custom:TargetModifier(source)
    end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), source:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(enemies) do
		enemy:Heal( self.damage, self )
        self:PlayEffects2( enemy )
	end
	local jump = jumps-1
	if jump <0 then
		return
	end
	local nextTarget = nil
	if target and target~=source then
		nextTarget = target
	else
		local allies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), source:GetOrigin(), nil, self.bounce_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
		for _,ally in pairs(allies) do
			local pass = false
			for _,unit in pairs(self.healedUnits) do
				if ally==unit then
					pass = true
				end
			end
			if not pass then
				nextTarget = ally
				break
			end
		end
	end
	if nextTarget then
		table.insert( self.healedUnits, nextTarget )
		self:JumpDamage( jump, nextTarget )
	end
	self:PlayEffects1( source, nextTarget )
end

function dazzle_shadow_wave_custom:PlayEffects1( source, target )
	if not target then
		target = source
	end
    local particle = "particles/units/heroes/hero_dazzle/dazzle_shadow_wave.vpcf"
    if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        particle = "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_inverse.vpcf"
    end
	local effect_cast = ParticleManager:CreateParticle( particle, PATTACH_ABSORIGIN_FOLLOW, source )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, source, PATTACH_POINT_FOLLOW, "attach_hitloc", source:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function dazzle_shadow_wave_custom:PlayEffects2( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dazzle/dazzle_shadow_wave_impact_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dazzle_shadow_wave_custom_slow = class({})
function modifier_dazzle_shadow_wave_custom_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
    }
end
function modifier_dazzle_shadow_wave_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_dazzle_19[self:GetCaster():GetTalentLevel("modifier_dazzle_19")]
end
function modifier_dazzle_shadow_wave_custom_slow:GetModifierTurnRate_Percentage()
    return self:GetAbility().modifier_dazzle_19_turn[self:GetCaster():GetTalentLevel("modifier_dazzle_19")]
end


LinkLuaModifier( "modifier_dazzle_healing_step", "heroes/npc_dota_hero_dazzle_custom/dazzle_shadow_wave_custom", LUA_MODIFIER_MOTION_NONE )

dazzle_healing_step = class({})

dazzle_healing_step.modifier_dazzle_17_range = {50,100,150}
dazzle_healing_step.modifier_dazzle_17 = {-2,-4,-6}
dazzle_healing_step.modifier_dazzle_18 = 3
dazzle_healing_step.modifier_dazzle_19_duration = 2
dazzle_healing_step.modifier_dazzle_19 = {-20,-40}
dazzle_healing_step.modifier_dazzle_19_turn = {-20,-40}

function dazzle_healing_step:GetIntrinsicModifierName()
    return "modifier_dazzle_healing_step"
end

function dazzle_healing_step:GetCastRange( vLocation, hTarget )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_dazzle_17") then
        bonus = self.modifier_dazzle_17_range[self:GetCaster():GetTalentLevel("modifier_dazzle_17")]
    end
    return self.BaseClass.GetCastRange( self, vLocation, hTarget ) + bonus
end

function dazzle_healing_step:GetCooldown(level)
	local bonus = 0
    local mult = 1
	if self:GetCaster():HasModifier("modifier_dazzle_17") then
		bonus = self.modifier_dazzle_17[self:GetCaster():GetTalentLevel("modifier_dazzle_17")]
	end
    return (self.BaseClass.GetCooldown( self, level ) + bonus) * mult
end

function dazzle_healing_step:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local units = FindUnitsInLine(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), point, self:GetCaster(), 150, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0)

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_dazzle/dazzle_shadow_wave.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetAbsOrigin() + Vector(0,0,150))
	ParticleManager:SetParticleControl(effect_cast, 1, point + Vector(0,0,150))
	ParticleManager:ReleaseParticleIndex( effect_cast )

    FindClearSpaceForUnit(self:GetCaster(), point, true)

    self:GetCaster():EmitSound("Hero_Dazzle.Shadow_Wave")

    if self:GetCaster():HasModifier("modifier_dazzle_18") then
        local modifier_dazzle_healing_step = self:GetCaster():FindModifierByName("modifier_dazzle_healing_step")
        if modifier_dazzle_healing_step then
            modifier_dazzle_healing_step:IncrementStackCount()
            if modifier_dazzle_healing_step:GetStackCount() >= self.modifier_dazzle_18 then
                Timers:CreateTimer(FrameTime(), function()
                    self:EndCooldown()
                end)
                modifier_dazzle_healing_step:SetStackCount(0)
            end
        end
    end

    local dazzle_shadow_wave_custom = self:GetCaster():FindAbilityByName("dazzle_shadow_wave_custom")
    if dazzle_shadow_wave_custom then
        local damage = dazzle_shadow_wave_custom:GetSpecialValueFor( "damage" )
        if self:GetCaster():HasModifier("modifier_dazzle_15") then
            damage = damage + (self:GetCaster():GetMaxMana() / 100 * dazzle_shadow_wave_custom.modifier_dazzle_15[self:GetCaster():GetTalentLevel("modifier_dazzle_15")])
        end
        for _, unit in pairs(units) do
            if unit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
                unit:Heal( damage, self )
            else
                ApplyDamage( { victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK })
                if self:GetCaster():HasModifier("modifier_dazzle_19") then
                    unit:AddNewModifier(self:GetCaster(), self, "modifier_dazzle_shadow_wave_custom_slow", {duration = dazzle_shadow_wave_custom.modifier_dazzle_19_duration * (1 - unit:GetStatusResistance())})
                end
            end
        end
    end
end

modifier_dazzle_healing_step = class({})
function modifier_dazzle_healing_step:IsPurgable() return false end
function modifier_dazzle_healing_step:IsHidden() return self:GetStackCount() == 0 end
function modifier_dazzle_healing_step:IsPurgeException() return false end
function modifier_dazzle_healing_step:RemoveOnDeath() return false end