--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wisp_tether_custom", "heroes/npc_dota_hero_wisp_custom/wisp_tether_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_tether_custom_ally", "heroes/npc_dota_hero_wisp_custom/wisp_tether_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_tether_custom_latch", "heroes/npc_dota_hero_wisp_custom/wisp_tether_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_wisp_tether_custom_slow", "heroes/npc_dota_hero_wisp_custom/wisp_tether_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wisp_tether_custom_attack_custom", "heroes/npc_dota_hero_wisp_custom/wisp_tether_custom", LUA_MODIFIER_MOTION_NONE)

wisp_tether_custom = class({})
wisp_tether_custom.modifier_wisp_14 = 15
wisp_tether_custom.modifier_wisp_8_outgoing_damage = 30
wisp_tether_custom.modifier_wisp_8_incoming_damage = 200
wisp_tether_custom.modifier_wisp_8_duration = {6,12}
wisp_tether_custom.modifier_wisp_1 = 40
wisp_tether_custom.modifier_wisp_1_base_damage = 30
wisp_tether_custom.modifier_wisp_1_per_level = 2
wisp_tether_custom.modifier_wisp_7 = 2
wisp_tether_custom.modifier_wisp_7_max_targets = 3

function wisp_tether_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_tether.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/wisp/wisp_tether_ti7.vpcf", context)
end

function wisp_tether_custom:CastFilterResultTarget( target )
    if target == self:GetCaster() then
        return UF_FAIL_CUSTOM
    end

    local team_target = DOTA_UNIT_TARGET_TEAM_FRIENDLY
    if self:GetCaster():HasModifier("modifier_wisp_1") then
        team_target = DOTA_UNIT_TARGET_TEAM_ENEMY
    end
	local nResult = UnitFilter(
		target,
		team_target,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function wisp_tether_custom:GetCustomCastErrorTarget( target )
    if target == self:GetCaster() then
        return "#dota_hud_error_cannot_tether_self"
    end
    return ""
end


function wisp_tether_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_wisp_8") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function wisp_tether_custom:OnSpellStart()
    if not IsServer() then return end
	local latch_distance = self:GetSpecialValueFor("latch_distance")
    local target = self:GetCursorTarget()
    local point = self:GetCursorPosition()
    if target and target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if self:GetCaster():GetUnitName() ~= "npc_dota_hero_wisp" then return end
        if target:TriggerSpellAbsorb(self) then 
            return 
        end
    end
    if target == self:GetCaster() then return end
    if target == nil and self:GetCaster():HasModifier("modifier_wisp_8") then
        local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), { outgoing_damage = self.modifier_wisp_8_outgoing_damage - 100, incoming_damage = self.modifier_wisp_8_incoming_damage - 100, duration = self.modifier_wisp_8_duration[self:GetCaster():GetTalentLevel("modifier_wisp_8")] }, 1, 150, false, true )
        if not self:GetCaster():HasModifier("modifier_wisp_1") then
            target = illusions[1]
        end
        FindClearSpaceForUnit(illusions[1], point, true)
    end
    if target == nil then return end
    local distance = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
    if distance >= latch_distance then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_tether_custom_latch", {target = target:entindex()})
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_tether_custom", {target = target:entindex()})
	target:AddNewModifier(self:GetCaster(), self, "modifier_wisp_tether_custom_ally", {})
end

function wisp_tether_custom:WispAttack(target)
    if self:GetCaster():IsDisarmed() then return end
    local projectile_info = 
    {
        Ability = self,	
        EffectName = self:GetCaster():GetRangedProjectileName(),
        iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,	
        bDodgeable = true,
        bIsAttack = true,
        Source = self:GetCaster(),
        Target = target,
        ExtraData = {},
    }
    ProjectileManager:CreateTrackingProjectile( projectile_info )
end

function wisp_tether_custom:OnProjectileHit(target, vLocation)
    if not IsServer() then return end
    if target and not target:IsAttackImmune() then
        local modifier_wisp_tether_custom_attack_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_wisp_tether_custom_attack_custom", {})
        if modifier_wisp_tether_custom_attack_custom then
            self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
            modifier_wisp_tether_custom_attack_custom:Destroy()
        end
    end
end

modifier_wisp_tether_custom_latch = class({})
function modifier_wisp_tether_custom_latch:IsHidden()	return true end
function modifier_wisp_tether_custom_latch:IsPurgable()	return false end
function modifier_wisp_tether_custom_latch:OnCreated(params)
    if not IsServer() then return end
	self.target = EntIndexToHScript(params.target)
	self.destroy_tree_radius = self:GetAbility():GetSpecialValueFor("radius")
	self.final_latch_distance = 300
    self.latch_speed = self:GetAbility():GetSpecialValueFor("latch_speed")
    if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
    if not self:ApplyVerticalMotionController() then
        self:Destroy()
    end
end

function modifier_wisp_tether_custom_latch:UpdateHorizontalMotion( me, dt )
    if not IsServer() then return end
    if self.target == nil or self.target:IsNull() then
        self:Destroy()
        return
    end
    if me:IsStunned() or me:IsHexed() or me:IsOutOfGame() or (me.IsFeared and me:IsFeared()) or me:IsRooted() then
        self:Destroy()
        return
    end
    local casterDir = me:GetAbsOrigin() - self.target:GetAbsOrigin()
    local distToAlly = casterDir:Length2D()
    casterDir = casterDir:Normalized()
    if distToAlly > self.final_latch_distance then
        distToAlly = distToAlly - self.latch_speed * dt
        distToAlly = math.max( distToAlly, self.final_latch_distance )
        local pos = self.target:GetAbsOrigin() + casterDir * distToAlly
        me:SetOrigin(pos)
    end
    if distToAlly <= self.final_latch_distance then
        GridNav:DestroyTreesAroundPoint(me:GetAbsOrigin(), 300, false)
        ResolveNPCPositions(me:GetAbsOrigin(), 128)
        self:Destroy()
    end
end

function modifier_wisp_tether_custom_latch:UpdateVerticalMotion( me, dt )
    if not IsServer() then return end
    local height = me:GetOrigin().z
    local ground_height = GetGroundHeight(me:GetOrigin(), me)
    if height > ground_height and ground_height > 0 then
        me:SetOrigin(Vector(me:GetOrigin().x, me:GetOrigin().y, ground_height))
    else
        me:SetOrigin(Vector(me:GetOrigin().x, me:GetOrigin().y, math.max(height, ground_height)))
    end
end

function modifier_wisp_tether_custom_latch:OnDestroy()
	if not IsServer() then return end
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), false)
end

function modifier_wisp_tether_custom_latch:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_wisp_tether_custom_latch:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

modifier_wisp_tether_custom_slow = class({})

function modifier_wisp_tether_custom_slow:OnCreated()
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_wisp_tether_custom_slow:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}	
end

function modifier_wisp_tether_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_wisp_tether_custom_slow:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end

modifier_wisp_tether_custom = class({})
function modifier_wisp_tether_custom:IsHidden() return false end
function modifier_wisp_tether_custom:IsPurgable() return false end
function modifier_wisp_tether_custom:GetPriority() return MODIFIER_PRIORITY_SUPER_ULTRA end

function modifier_wisp_tether_custom:OnCreated(params)
	if not IsServer() then return end
	self.target = EntIndexToHScript(params.target)
    if self.target == nil or self.target:IsNull() then
        self:Destroy()
        return
    end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.tether_heal_amp = self:GetAbility():GetSpecialValueFor("tether_heal_amp") / 100
    self.tether_mana_amp = self:GetAbility():GetSpecialValueFor("tether_mana_amp") / 100
	self.total_gained_mana = 0
	self.total_gained_health = 0
	self.update_timer = 0
    self.cachedSpeed = 0
    self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self:GetCaster():EmitSound("Hero_Wisp.Tether")
    self:GetCaster():SwapAbilities("wisp_tether_custom", "wisp_tether_break_custom", false, true)
    local wisp_tether_break_custom = self:GetCaster():FindAbilityByName("wisp_tether_break_custom")
    if wisp_tether_break_custom then
        wisp_tether_break_custom:StartCooldown(1)
    end
    self.damage_timer = 0
    self.damage = 0
    self.attack_timer = 0
    self.pfx_timer = 0
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
	self:StartIntervalThink(FrameTime())
end

function modifier_wisp_tether_custom:AddCustomTransmitterData()
	local data = 
    {
		cachedSpeed = self.cachedSpeed,
	}
	return data
end

function modifier_wisp_tether_custom:HandleCustomTransmitterData( data )
	self.cachedSpeed = data.cachedSpeed
end

function modifier_wisp_tether_custom:OnIntervalThink()
	self.difference	= 0
	self.original_speed	= self:GetParent():GetMoveSpeedModifier(self:GetParent():GetBaseMoveSpeed(), false)
	self.target_speed = self.target:GetMoveSpeedModifier(self.target:GetBaseMoveSpeed(), true)
	self.difference	= self.target_speed - self.original_speed

    local baseSpeedOwner = self:GetParent():GetBaseMoveSpeed()
    local baseSpeedTarget = self.target:GetBaseMoveSpeed()
    local targetSpeed = self.target:GetMoveSpeedModifier(baseSpeedTarget, true)
    local finalMoveSpeed = 100
    local reduction = 1
    local baseSpeed = math.max(baseSpeedOwner, targetSpeed)
    local bonusSpeedMultiplier = 1
    local calculateSpeed = bonusSpeedMultiplier * (reduction * baseSpeed)
    if calculateSpeed >= finalMoveSpeed then
        finalMoveSpeed = math.min(calculateSpeed, 550)
    end
    if self.target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        self.cachedSpeed = finalMoveSpeed
        self:SendBuffRefreshToClients()
    end
	if not IsServer() then return end
	self.update_timer = self.update_timer + FrameTime()
	if self.update_timer > 1 then 
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self.target, self.total_gained_health * self.tether_heal_amp, nil)	
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_ADD, self.target, self.total_gained_mana * self.tether_mana_amp, nil)
		self.total_gained_mana = 0
		self.total_gained_health = 0
		self.update_timer = 0
	end

    self.damage_timer = self.damage_timer + FrameTime()
    if self.damage_timer >= 0.5 then
        self.damage_timer = 0
        ApplyDamage({ victim = self.target, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL })
        if self:GetCaster():HasModifier("modifier_wisp_2") then
            local enemies = FindUnitsInLine( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.target:GetAbsOrigin(), nil, 55, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 )
            for _, enemy in pairs(enemies) do
                if enemy ~= self.target then
                    ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL })
                end
            end
        end
        self.damage = 0
    end

    if self:GetCaster():HasModifier("modifier_wisp_7") then
        self.attack_timer = self.attack_timer + FrameTime()
        if self.attack_timer >= self:GetAbility().modifier_wisp_7 then
            self.attack_timer = 0
            local max_targets = self:GetAbility().modifier_wisp_7_max_targets
            local targets = {}
            if self.target and self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
                table.insert(targets, self.target)
                max_targets = max_targets - 1
            end
            local enemies = FindUnitsInLine( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.target:GetAbsOrigin(), nil, 55, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 )
            for _, enemy in pairs(enemies) do
                if enemy ~= self.target then
                    max_targets = max_targets - 1
                    table.insert(targets, enemy)
                    if max_targets <= 0 then break end
                end
            end
            for _, target in pairs(targets) do
                self:GetCaster():PerformAttack(target, true, true, true, true, true, false, true)
            end
        end
    end

	if self:GetParent():HasModifier("modifier_wisp_tether_custom_latch") then return end
    
    local enemies = FindUnitsInLine( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.target:GetAbsOrigin(), nil, 55, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 )
    for _, enemy in pairs(enemies) do
        if enemy ~= self.target then
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_wisp_tether_custom_slow", {duration = self.slow_duration * (1-enemy:GetStatusResistance())})
        end
    end
    if self.pfx_timer <= 0 then
        for _, enemy in pairs(enemies) do
            if enemy ~= self.target then
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_tether_hit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, enemy)
                ParticleManager:SetParticleControlEnt(particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(particle)
            end
        end
        self.pfx_timer = 0.25
    else
        self.pfx_timer = self.pfx_timer - FrameTime()
    end

    local modifier_wisp_relocate_custom = self:GetParent():FindModifierByName("modifier_wisp_relocate_custom")
    if modifier_wisp_relocate_custom and modifier_wisp_relocate_custom:GetElapsedTime() <= 0.2 then return end
	if (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D() <= self.radius then return end
	self:Destroy()
end

function modifier_wisp_tether_custom:selfReduction(owner)
    if owner:IsUnslowable() then return 1 end
    local reduction = owner:GetModifierPercentageMoveSpeedReduction()
    local bonus = owner:GetModifierPercentageMoveSpeedBonus()
    return math.max(1 - reduction + bonus, 0)
end

function modifier_wisp_tether_custom:DeclareFunctions()
	return
    {
		MODIFIER_EVENT_ON_HEAL_RECEIVED,
		MODIFIER_EVENT_ON_MANA_GAINED,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_wisp_tether_custom:GetModifierMoveSpeed_Absolute()
    if self.cachedSpeed and self.cachedSpeed > 0 then
        return self.cachedSpeed
    end
end

function modifier_wisp_tether_custom:OnHealReceived(params)
	if params.unit ~= self:GetParent() then return end
    if self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if params.inflictor and string.find(params.inflictor:GetName(), "dagon") then return end
        self.damage = self.damage + ((self:GetAbility().modifier_wisp_1_base_damage + (self:GetAbility().modifier_wisp_1_per_level * self:GetCaster():GetLevel() )) * 0.115) + (params.gain / 100 * self:GetAbility().modifier_wisp_1)
    else
	    self.target:Heal(params.gain * self.tether_heal_amp, self:GetAbility())
    end
end

function modifier_wisp_tether_custom:OnManaGained(params)
    if params.unit ~= self:GetParent() then return end
	if not self.target.GiveMana then return end
    if self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
	self.target:GiveMana(params.gain * self.tether_mana_amp)
end

function modifier_wisp_tether_custom:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Wisp.Tether.Stop")
	self:GetCaster():StopSound("Hero_Wisp.Tether")
	self:GetCaster():SwapAbilities("wisp_tether_break_custom", "wisp_tether_custom", false, true)
    local modifier_wisp_tether_custom_latch = self:GetParent():FindModifierByName("modifier_wisp_tether_custom_latch")
    if modifier_wisp_tether_custom_latch then
        modifier_wisp_tether_custom_latch:Destroy()
    end
    if self.target and not self.target:IsNull() then
        local modifier_wisp_tether_custom_ally = self.target:FindModifierByName("modifier_wisp_tether_custom_ally")
        if modifier_wisp_tether_custom_ally then
            modifier_wisp_tether_custom_ally:Destroy()
        end
    end
end

modifier_wisp_tether_custom_ally = class({})
function modifier_wisp_tether_custom_ally:IsHidden() return false end
function modifier_wisp_tether_custom_ally:IsPurgable() return false end
function modifier_wisp_tether_custom_ally:OnCreated()
    self.movespeed = self:GetAbility():GetSpecialValueFor("movespeed")
	if not IsServer() then return end
    local fx_name = "particles/units/heroes/hero_wisp/wisp_tether.vpcf"
    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        fx_name = "particles/econ/items/wisp/wisp_tether_ti7.vpcf"
    end
	self.pfx = ParticleManager:CreateParticle(fx_name, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(self.pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.pfx, false, false, -1, false, false)
	EmitSoundOn("Hero_Wisp.Tether.Target", self:GetParent())
end

function modifier_wisp_tether_custom_ally:OnDestroy() 
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Wisp.Tether.Target")
	local modifier_wisp_tether_custom = self:GetCaster():FindModifierByName("modifier_wisp_tether_custom")
    if modifier_wisp_tether_custom then
        modifier_wisp_tether_custom:Destroy()
    end
    local modifier_wisp_overcharge_custom = self:GetParent():FindModifierByName("modifier_wisp_overcharge_custom")
    if modifier_wisp_overcharge_custom then
        modifier_wisp_overcharge_custom:Destroy()
    end
    local modifier_wisp_overcharge_custom_debuff = self:GetParent():FindModifierByName("modifier_wisp_overcharge_custom_debuff")
    if modifier_wisp_overcharge_custom_debuff then
        modifier_wisp_overcharge_custom_debuff:Destroy()
    end
end

function modifier_wisp_tether_custom_ally:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
         
	}
end

function modifier_wisp_tether_custom_ally:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
    if params.target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
    if not self:GetCaster():HasModifier("modifier_wisp_14") then return end
    self:GetAbility():WispAttack(params.target)
end

function modifier_wisp_tether_custom_ally:GetModifierMoveSpeedBonus_Percentage()
    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        return self.movespeed * (-1)
    end
	return self.movespeed
end

wisp_tether_break_custom = class({})

function wisp_tether_break_custom:OnSpellStart()
    if not IsServer() then return end
    local modifier_wisp_tether_custom = self:GetCaster():FindModifierByName("modifier_wisp_tether_custom")
    if modifier_wisp_tether_custom then
        modifier_wisp_tether_custom:Destroy()
    end
end

modifier_wisp_tether_custom_attack_custom = class({})
function modifier_wisp_tether_custom_attack_custom:IsPurgable() return false end
function modifier_wisp_tether_custom_attack_custom:IsPurgeException() return false end
function modifier_wisp_tether_custom_attack_custom:IsHidden() return true end
function modifier_wisp_tether_custom_attack_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_wisp_tether_custom_attack_custom:GetModifierDamageOutgoing_Percentage()
    return self:GetAbility().modifier_wisp_14 - 100
end