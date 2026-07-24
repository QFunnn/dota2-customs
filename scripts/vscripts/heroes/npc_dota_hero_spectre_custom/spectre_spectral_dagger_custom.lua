--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spectre_spectral_dagger_custom_dummy_proj", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_spectre_spectral_path", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_spectre_spectral_in_path", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_spectre_spectral_grace", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_spectre_spectral_path_by_heroes", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_spectre_spectral_grace_invis", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_spectral_dagger_custom_dummy_invis", "heroes/npc_dota_hero_spectre_custom/spectre_spectral_dagger_custom", LUA_MODIFIER_MOTION_NONE )

spectre_spectral_dagger_custom = class({})

spectre_spectral_dagger_custom.modifier_spectre_15 = {-1,-2}
spectre_spectral_dagger_custom.modifier_spectre_15_mana_cost = {-30,-60}
spectre_spectral_dagger_custom.modifier_spectre_9 = {3,6}
spectre_spectral_dagger_custom.modifier_spectre_10_outgoing_damage = 30
spectre_spectral_dagger_custom.modifier_spectre_10_incoming_damage = 200
spectre_spectral_dagger_custom.modifier_spectre_10_duration = {3,6,9}
spectre_spectral_dagger_custom.modifier_spectre_16_base_dmg = 10
spectre_spectral_dagger_custom.modifier_spectre_16_perc_dmg = {1,2}
spectre_spectral_dagger_custom.modifier_spectre_20 = {-15,-30}
spectre_spectral_dagger_custom.modifier_spectre_18 = 800
spectre_spectral_dagger_custom.modifier_spectre_17 = {50,100,150}

local function HasDamaged(damaged_list, target)
    for _, v in pairs(damaged_list) do
        if v == target then
            return true
        end
    end
    return false
end

function spectre_spectral_dagger_custom:GetManaCost(level)
    local mult = 1
	if self:GetCaster():HasModifier("modifier_spectre_15") then
		mult = mult + (self.modifier_spectre_15_mana_cost[self:GetCaster():GetTalentLevel("modifier_spectre_15")] / 100)
	end
    return self.BaseClass.GetManaCost(self, level) * mult
end

function spectre_spectral_dagger_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_spectre_15") then
		bonus = self.modifier_spectre_15[self:GetCaster():GetTalentLevel("modifier_spectre_15")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function spectre_spectral_dagger_custom:OnSpellStart(new_target)
	if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local position = self:GetCursorPosition()
    self.dagger_radius = self:GetSpecialValueFor("dagger_radius")
    local speed = self:GetSpecialValueFor("speed")
    local vision_radius = self:GetSpecialValueFor("vision_radius")
    local direction = nil
    caster:EmitSound("Hero_Spectre.DaggerCast")
    local proj = "particles/units/heroes/hero_spectre/spectre_spectral_dagger.vpcf"
    local proj_tracking = "particles/units/heroes/hero_spectre/spectre_spectral_dagger_tracking.vpcf"

    if new_target then
        target = new_target
    end

    if target and (target:IsHero() or new_target) then
        local info = 
		{
            Target = target,
            Source = caster,
            Ability = self,
            EffectName = proj_tracking,
            bDodgeable = false,
            bIsAttack = false,
            bProvidesVision = true,
            iMoveSpeed = speed,
            vSpawnOrigin = caster:GetAbsOrigin(),
            iVisionRadius = vision_radius,
            iVisionTeamNumber = caster:GetTeamNumber(),
			ExtraData = {tracking = 1},
        }
        ProjectileManager:CreateTrackingProjectile( info )
        local dummy = CreateUnitByName("npc_dummy_unit", caster:GetAbsOrigin(), true, nil, nil, caster:GetTeamNumber())
        dummy.TargetingHero = target
        dummy:SetDayTimeVisionRange(0)
        dummy:SetNightTimeVisionRange(0)
        dummy:AddNewModifier(caster, self, "modifier_spectre_spectral_dagger_custom_dummy_proj", {})
    else
        local direction = (position - self:GetCaster():GetAbsOrigin()):Normalized()
        local pathFX = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_spectral_dagger.vpcf", PATTACH_WORLDORIGIN, nil)
	    ParticleManager:SetParticleControl(pathFX, 0, self:GetCaster():GetAbsOrigin() )
        ParticleManager:SetParticleControlForward( pathFX, 0, self:GetCaster():GetForwardVector() )
        ParticleManager:SetParticleControl(pathFX, 1, direction * speed )
        direction = (position - caster:GetAbsOrigin()):Normalized()
        local info = 
		{
            Ability = self,
            EffectName = proj,
            vSpawnOrigin = caster:GetAbsOrigin(),
            fDistance = 2000,
            fStartRadius = self.dagger_radius,
            fEndRadius = self.dagger_radius,
            Source = caster,
            bHasFrontalCone = false,
            bReplaceExisting = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            bDeleteOnHit = false,
            vVelocity = direction * speed,
            bProvidesVision = true,
            iVisionRadius = vision_radius,
            iVisionTeamNumber = caster:GetTeamNumber(),
			ExtraData = {tracking = 0, pathFX = pathFX},
        }
        ProjectileManager:CreateLinearProjectile( info )
    end
end

function spectre_spectral_dagger_custom:OnProjectileHit_ExtraData(Target, Location, data)
	if not IsServer() then return end

    if Target ~= nil and not Target:IsInvulnerable() then
        local damage = self:GetSpecialValueFor("damage")
        if self:GetCaster():HasModifier("modifier_spectre_17") then
            damage = damage + self.modifier_spectre_17[self:GetCaster():GetTalentLevel("modifier_spectre_17")]
        end
        local hero_path_duration = self:GetSpecialValueFor("hero_path_duration")
        ApplyDamage({ victim = Target, attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbilityDamageType(), ability = self })
        EmitSoundOn("Hero_Spectre.DaggerImpact", Target)
        if Target:IsHero() then
            Target:AddNewModifier(self:GetCaster(), self, "modifier_ability_spectre_spectral_path_by_heroes", {duration=hero_path_duration})
        end
		if self:GetCaster():HasModifier("modifier_spectre_10") and data.tracking == 1 then
			local incoming_damage = self.modifier_spectre_10_incoming_damage - 100
			local outgoing_damage = self.modifier_spectre_10_outgoing_damage - 100
			local duration = self.modifier_spectre_10_duration[self:GetCaster():GetTalentLevel("modifier_spectre_10")]
			local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), { outgoing_damage = outgoing_damage, incoming_damage = incoming_damage, duration = duration }, 1, 150, false, true )
			if illusions and illusions[1] then
				FindClearSpaceForUnit(illusions[1], Location, true)
			end
		end
    end

	if Target == nil and data.tracking == 0 then
		if self:GetCaster():HasModifier("modifier_spectre_10") then
			local incoming_damage = self.modifier_spectre_10_incoming_damage - 100
			local outgoing_damage = self.modifier_spectre_10_outgoing_damage - 100
			local duration = self.modifier_spectre_10_duration[self:GetCaster():GetTalentLevel("modifier_spectre_10")]
			local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), { outgoing_damage = outgoing_damage, incoming_damage = incoming_damage, duration = duration }, 1, 150, false, true )
			if illusions and illusions[1] then
				FindClearSpaceForUnit(illusions[1], Location, true)
			end
		end
        if data and data.pathFX then
            ParticleManager:DestroyParticle(data.pathFX, false)
            ParticleManager:ReleaseParticleIndex(data.pathFX)
        end
	end

    return false
end

function spectre_spectral_dagger_custom:OnProjectileThink_ExtraData(vLocation, data)
	if not IsServer() then return end
    if data.last_path_pos and (vLocation - data.last_path_pos):Length2D() < self:GetSpecialValueFor("path_radius") then return end
    data.last_path_pos = vLocation
    local caster = self:GetCaster()
    CreateModifierThinker(caster, self, "modifier_ability_spectre_spectral_path", {duration = self:GetSpecialValueFor('dagger_path_duration')}, vLocation, caster:GetTeamNumber(), false)
end

modifier_spectre_spectral_dagger_custom_dummy_proj = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
            MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
        }
    end,
    CheckState              = function(self)
        return {
            [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_STUNNED ] = true,
            [MODIFIER_STATE_ATTACK_IMMUNE] = true,
            [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        }
    end,
})

function modifier_spectre_spectral_dagger_custom_dummy_proj:OnCreated()
	if not IsServer() then return end
    self.target = self:GetParent().TargetingHero
    self.targets = {}
    self.speed = self:GetAbility():GetSpecialValueFor("speed") * 1/30
    self.dagger_path_duration = self:GetAbility():GetSpecialValueFor("dagger_path_duration")
    self.expire_time = GameRules:GetGameTime() + 5
    self:StartIntervalThink(0.03)
end

function modifier_spectre_spectral_dagger_custom_dummy_proj:OnIntervalThink()
	if not IsServer() then return end
    local parent = self:GetParent()
    if not self.target or self.target:IsNull() or GameRules:GetGameTime() >= self.expire_time then
        UTIL_Remove(parent)
        return
    end
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_spectre_17") then
        damage = damage + self:GetAbility().modifier_spectre_17[self:GetCaster():GetTalentLevel("modifier_spectre_17")]
    end
    local all = FindUnitsInRadius(self:GetCaster():GetTeamNumber(),  parent:GetAbsOrigin(),  nil,  self:GetAbility().dagger_radius, DOTA_UNIT_TARGET_TEAM_ENEMY,  DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER,  false)
    local hero_path_duration = self:GetAbility():GetSpecialValueFor("hero_path_duration")
    for _, unit in ipairs(all) do
        if not HasDamaged(self.targets, unit) and unit ~= self.target then
            table.insert(self.targets, unit)
            ApplyDamage({
                victim = unit,
                attacker = self:GetCaster(),
                damage = damage,
                damage_type = self:GetAbility():GetAbilityDamageType(),
                ability = self:GetAbility()
            })
            EmitSoundOn("Hero_Spectre.DaggerImpact", unit)
            if unit:IsHero() then
                unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ability_spectre_spectral_path_by_heroes", {duration=hero_path_duration})
            end
        end
    end
    if not parent:IsPositionInRange(self.target:GetAbsOrigin(), self:GetAbility().dagger_radius) then
        local direction = (self.target:GetAbsOrigin() - parent:GetAbsOrigin()):Normalized()
        parent:SetAbsOrigin(GetGroundPosition(parent:GetAbsOrigin(), parent) + direction * self.speed)
    else
        UTIL_Remove(parent)
    end
end

function modifier_spectre_spectral_dagger_custom_dummy_proj:GetAbsoluteNoDamageMagical() return 1 end
function modifier_spectre_spectral_dagger_custom_dummy_proj:GetAbsoluteNoDamagePure() return 1 end
function modifier_spectre_spectral_dagger_custom_dummy_proj:GetAbsoluteNoDamagePhysical() return 1 end

modifier_ability_spectre_spectral_path = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
})

function modifier_ability_spectre_spectral_path:IsAura()
    return true
end

function modifier_ability_spectre_spectral_path:GetModifierAura()
    return "modifier_ability_spectre_spectral_in_path"
end

function modifier_ability_spectre_spectral_path:GetAuraEntityReject(hEntity)
    if hEntity:IsIllusion() and hEntity:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() then
        return false
    end
    if hEntity:GetTeamNumber() == self:GetCaster():GetTeamNumber() and hEntity ~= self:GetCaster() then
        return true
    end
    return false
end

function modifier_ability_spectre_spectral_path:GetAuraRadius()
    return self.path_radius
end

function modifier_ability_spectre_spectral_path:GetAuraDuration()
    return 0.25
end

function modifier_ability_spectre_spectral_path:GetAuraSearchTeam()    
    return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_ability_spectre_spectral_path:GetAuraSearchType()    
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_ability_spectre_spectral_path:OnCreated()
    if not IsServer() then return end
    self.path_radius = self:GetAbility():GetSpecialValueFor("path_radius")
    self.buff_persistence = self:GetAbility():GetSpecialValueFor("buff_persistence")
    self.dagger_grace_period = self:GetAbility():GetSpecialValueFor("dagger_grace_period")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 200, self:GetDuration(), false)
    self:StartIntervalThink(0.1)
end

function modifier_ability_spectre_spectral_path:OnIntervalThink()
	if not IsServer() then return end
    local all = FindUnitsInRadius(self:GetParent():GetTeamNumber(),  self:GetParent():GetAbsOrigin(),  nil,  self.path_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY,  DOTA_UNIT_TARGET_HERO,  DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER,  false)
    for _, hero in ipairs(all) do
        if hero == self:GetCaster() or (hero:IsIllusion() and hero:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID()) then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ability_spectre_spectral_grace", {duration=self.dagger_grace_period})
            break
        end
    end
end

modifier_ability_spectre_spectral_in_path = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
			MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
        }
    end,
    CheckState              = function(self)
        return {
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        }
    end,
})

function modifier_ability_spectre_spectral_in_path:OnCreated()
    self.bonus_movespeed = self:GetAbility():GetSpecialValueFor("bonus_movespeed")
	if self:GetCaster():HasModifier("modifier_spectre_9") then
		self.bonus_movespeed = self.bonus_movespeed + self:GetAbility().modifier_spectre_9[self:GetCaster():GetTalentLevel("modifier_spectre_9")]
	end
    if not IsServer() then return end
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		self:StartIntervalThink(1)
	end
end

function modifier_ability_spectre_spectral_in_path:IsDebuff()
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        return false
    end
    return true
end

function modifier_ability_spectre_spectral_in_path:GetModifierMoveSpeedBonus_Percentage()
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        return self.bonus_movespeed
    end
    return self.bonus_movespeed * -1
end

function modifier_ability_spectre_spectral_in_path:OnIntervalThink()
	if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_spectre_16") then
        local damage = self:GetAbility().modifier_spectre_16_base_dmg + (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_spectre_16_perc_dmg[self:GetCaster():GetTalentLevel("modifier_spectre_16")])
        ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
    end
    if self:GetCaster():HasModifier("modifier_spectre_21") then
        local spectre_desolate_custom = self:GetCaster():FindAbilityByName("spectre_desolate_custom")
        if spectre_desolate_custom and spectre_desolate_custom:GetLevel() > 0 then
            local damage = spectre_desolate_custom:GetSpecialValueFor( "bonus_damage" )
            if self:GetParent():HasModifier("modifier_spectre_12") then
                damage = damage + spectre_desolate_custom.modifier_spectre_12[self:GetCaster():GetTalentLevel("modifier_spectre_12")]
            end
            if self:GetCaster():HasModifier("modifier_spectre_6") then
                damage = damage * 2
            end
            if self:GetCaster():HasModifier("modifier_spectre_13") and RollPercentage(self:GetCaster():GetEvasion() * 100) then
                damage = damage * 2
            end
            ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = spectre_desolate_custom })
        end
    end
end

function modifier_ability_spectre_spectral_in_path:GetModifierPropertyRestorationAmplification()
	if self:GetCaster():HasModifier("modifier_spectre_20") and self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
 		return self:GetAbility().modifier_spectre_20[self:GetCaster():GetTalentLevel("modifier_spectre_20")]
	end
end

modifier_ability_spectre_spectral_grace = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    CheckState              = function(self)
        return {
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        }
    end,
})

function modifier_ability_spectre_spectral_grace:OnCreated()
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_spectre_18") then
		local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_spectre_18, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false) 
    	if #enemies <= 0 then 
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ability_spectre_spectral_grace_invis", {duration = 0.1})
		end
	end
end

function modifier_ability_spectre_spectral_grace:OnRefresh(table)
	self:OnCreated()
end

modifier_ability_spectre_spectral_path_by_heroes = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsDebuff                = function(self) return true end,
    IsBuff                  = function(self) return false end,
    RemoveOnDeath           = function(self) return true end,
})

function modifier_ability_spectre_spectral_path_by_heroes:OnCreated()
	if not IsServer() then return end
    self.dagger_path_duration = self:GetAbility():GetSpecialValueFor("dagger_path_duration")
    self.path_radius = self:GetAbility():GetSpecialValueFor("path_radius")
    self:StartIntervalThink(0.15)
    self.pathFX = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_shadow_path.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControlEnt(self.pathFX, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(self.pathFX, 5, Vector(self.dagger_path_duration, 0, 0) )
end

function modifier_ability_spectre_spectral_path_by_heroes:OnDestroy()
	if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pathFX, false)
end

function modifier_ability_spectre_spectral_path_by_heroes:OnIntervalThink()
	if not IsServer() then return end
    local caster = self:GetCaster()
    local pos = self:GetParent():GetAbsOrigin()
    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() and self:GetParent():IsHero() then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), pos, self:GetParent():GetDayTimeVisionRange(), 0.15, true)
    end
    if self.last_path_pos and (pos - self.last_path_pos):Length2D() < self.path_radius then return end
    self.last_path_pos = pos
    CreateModifierThinker(caster, self:GetAbility(), "modifier_ability_spectre_spectral_path", {duration = self.dagger_path_duration}, pos, caster:GetTeamNumber(), false)
end

modifier_ability_spectre_spectral_grace_invis = class({})

function modifier_ability_spectre_spectral_grace_invis:IsPurgable() return false end

function modifier_ability_spectre_spectral_grace_invis:GetTexture() return "spectre_18" end

function modifier_ability_spectre_spectral_grace_invis:GetEffectName()
    return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_active_blur.vpcf"
end

function modifier_ability_spectre_spectral_grace_invis:GetEffectAttachType()
     return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_ability_spectre_spectral_grace_invis:OnCreated()
    if not self:GetAbility() then self:Destroy() return end
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end

function modifier_ability_spectre_spectral_grace_invis:OnRefresh()
    self:OnCreated()
end

function modifier_ability_spectre_spectral_grace_invis:OnIntervalThink()
	if not IsServer() then return end
    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_spectre_18, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_ANY_ORDER, false) 
    if #enemies > 0 then 
		self:Destroy()
    end
end

function modifier_ability_spectre_spectral_grace_invis:CheckState()
    return 
    {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true
    }
end

function modifier_ability_spectre_spectral_grace_invis:GetPriority()
    return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_ability_spectre_spectral_grace_invis:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    }
end

function modifier_ability_spectre_spectral_grace_invis:GetModifierInvisibilityLevel()
    return 1
end

function GetRandomPosition2D(vPosition, fRadius)
	local newPos = vPosition + Vector(1,0,0) * math.random(0-fRadius, fRadius)
	return RotatePosition(vPosition, QAngle(0,math.random(-360,360),0), newPos)
end

modifier_spectre_spectral_dagger_custom_dummy_invis = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
            MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        }
    end,
    CheckState              = function(self)
        return {
            [MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
            [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_STUNNED ] = true,
            [MODIFIER_STATE_ATTACK_IMMUNE] = true,
            [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        }
    end,
})
function modifier_spectre_spectral_dagger_custom_dummy_invis:GetAbsoluteNoDamageMagical() return 1 end
function modifier_spectre_spectral_dagger_custom_dummy_invis:GetAbsoluteNoDamagePure() return 1 end
function modifier_spectre_spectral_dagger_custom_dummy_invis:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_spectre_spectral_dagger_custom_dummy_invis:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.03)
end
function modifier_spectre_spectral_dagger_custom_dummy_invis:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then return end
    if self:GetAbility():GetLevel() <= 0
    or self:GetCaster():HasModifier("modifier_wodawispdeath_wisp")
    or self:GetCaster():HasModifier("modifier_wodarelax")
    or self:GetCaster():HasModifier("modifier_smoke_of_deceit")
    or self:GetCaster():HasModifier("modifier_wodawisp") then 
        return 
    end
    self:GetParent():SetAbsOrigin(self:GetCaster():GetAbsOrigin() + RandomVector(25))
end