--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_tree_grab_custom", "heroes/npc_dota_hero_tiny_custom/tiny_tree_grab_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tiny_toss_tree_custom_damage", "heroes/npc_dota_hero_tiny_custom/tiny_tree_grab_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tiny_toss_custom", "heroes/npc_dota_hero_tiny_custom/tiny_toss_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

tiny_tree_grab_custom = class({})
tiny_tree_grab_custom.modifier_tiny_17 = {10,20,30}
tiny_tree_grab_custom.modifier_tiny_18 = {-1,-2,-3}

function tiny_tree_grab_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tiny_18") then
		bonus = self.modifier_tiny_18[self:GetCaster():GetTalentLevel("modifier_tiny_18")]
	end	
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function tiny_tree_grab_custom:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local mod = caster:AddNewModifier(caster, self, "modifier_tiny_tree_grab_custom", {})
    local attack_count= self:GetSpecialValueFor("attack_count")
	if not mod then return end
    if not self:GetCaster():HasModifier("modifier_tiny_2") then
        mod:SetStackCount(attack_count)
    end
	if target.CutDown then
		target:CutDown(caster:GetTeamNumber())
    else
        GridNav:DestroyTreesAroundPoint(target:GetAbsOrigin(), 10, true)
    end
	caster:EmitSound("Hero_Tiny.Tree.Grab")
end

function tiny_tree_grab_custom:OnUpgrade()
	local caster = self:GetCaster()
	local mod = caster:FindModifierByName("modifier_tiny_tree_grab_custom")
	if not mod then return end
	mod.attack_range_override = self:GetSpecialValueFor("attack_range")
	mod.speed_reduction = self:GetSpecialValueFor("speed_reduction") * -1
	mod.bonus_damage = self:GetSpecialValueFor("bonus_damage")
	mod.splash_pct = self:GetSpecialValueFor("splash_pct") / 100.0
	mod.splash_width = self:GetSpecialValueFor("splash_width")
	mod.splash_range = self:GetSpecialValueFor("splash_range")
end

modifier_tiny_tree_grab_custom = class({})
function modifier_tiny_tree_grab_custom:IsPurgable() return false end
function modifier_tiny_tree_grab_custom:IsPurgeException() return false end

function modifier_tiny_tree_grab_custom:OnCreated()
	self.attack_range_override = self:GetAbility():GetSpecialValueFor("attack_range")
	self.speed_reduction = -self:GetAbility():GetSpecialValueFor("speed_reduction")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.splash_pct 	= self:GetAbility():GetSpecialValueFor("splash_pct") / 100.0
	self.splash_width 	= self:GetAbility():GetSpecialValueFor("splash_width")
	self.splash_range 	= self:GetAbility():GetSpecialValueFor("splash_range")
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
    if not IsServer() then return end
    self:GetParent():SwapAbilities("tiny_tree_grab_custom", "tiny_toss_tree_custom", false, true)
    self:StartIntervalThink(0.1)
end

function modifier_tiny_tree_grab_custom:SpawnItems()
    if not IsServer() then return end
	self.tree = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/tiny/tiny_tree/tiny_tree.vmdl"})
	self.tree:FollowEntity(self:GetCaster(), true)
end

function modifier_tiny_tree_grab_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wodawisp") then
        if self.tree ~= nil then
            UTIL_Remove(self.tree)
            self.tree = nil
        end
    else
        if self.tree == nil then
            self:SpawnItems()
        end
    end
end

function modifier_tiny_tree_grab_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BASE_OVERRIDE,
	    MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_tiny_tree_grab_custom:GetModifierSpellAmplify_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_tiny_17") then
        bonus = self:GetAbility().modifier_tiny_17[self:GetCaster():GetTalentLevel("modifier_tiny_17")]
    end
    return bonus
end

function modifier_tiny_tree_grab_custom:GetActivityTranslationModifiers()
	return "tree"
end

function modifier_tiny_tree_grab_custom:GetAttackSound()
	return "Hero_Tiny_Tree.Attack"
end

function modifier_tiny_tree_grab_custom:GetModifierMoveSpeedBonus_Constant()
	return self.speed_reduction
end

function modifier_tiny_tree_grab_custom:GetModifierAttackRangeOverride()
	return self.attack_range_override
end

function modifier_tiny_tree_grab_custom:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	local parent = self.parent
	if not parent or parent:IsNull() then return end
	if not params.target or params.target:IsNull() then return end
	if parent:GetTeam() == params.target:GetTeam() then return end
	if params.no_attack_cooldown then return end
	local ability = self:GetAbility()
	local damage = params.original_damage
	local splash_damage = damage * self.splash_pct

    local nfx = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf", PATTACH_POINT, self:GetCaster())
    ParticleManager:SetParticleControl(nfx, 0, params.target:GetAbsOrigin())
    ParticleManager:SetParticleControl(nfx, 1, params.target:GetAbsOrigin())
    ParticleManager:SetParticleControlForward(nfx, 2, self:GetCaster():GetForwardVector())
    ParticleManager:SetParticleControlForward(nfx, 1, self:GetCaster():GetForwardVector())
    ParticleManager:ReleaseParticleIndex(nfx)

	local direction = (params.target:GetAbsOrigin() - parent:GetAbsOrigin()):Normalized()
	local enemies = FindUnitsInLine( parent:GetTeamNumber(), params.target:GetAbsOrigin(), params.target:GetAbsOrigin() + direction * self.splash_range, nil, self.splash_width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES )

	local damage_table = 
	{
		attacker = parent,
		ability = ability,
		victim = nil,
		damage = splash_damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
	}

	for i, unit in pairs(enemies) do
		if unit ~= params.target then
			damage_table.victim = unit
			ApplyDamage(damage_table)
		end
	end

    if not self:GetCaster():HasModifier("modifier_tiny_2") then
        self:DecrementStackCount()
        if self:GetStackCount() <= 0 then
            self:Destroy()
        end
    else
        self:SetStackCount(0)
    end
end

function modifier_tiny_tree_grab_custom:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_tiny_tree_grab_custom:OnDestroy()
	if not IsServer() then return end
    self:GetParent():SwapAbilities("tiny_toss_tree_custom", "tiny_tree_grab_custom", false, true)
	self:GetAbility():UseResources(false, false, false, true)
    if self.tree then
        UTIL_Remove(self.tree)
    end
end

tiny_toss_tree_custom = class({})

function tiny_toss_tree_custom:GetAOERadius()
	return self:GetSpecialValueFor("splash_radius")
end

function tiny_toss_tree_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local position = self:GetCursorPosition()
	local speed = self:GetSpecialValueFor("speed")
    local modifier_tiny_tree_grab_custom = self:GetCaster():FindModifierByName("modifier_tiny_tree_grab_custom")
    if modifier_tiny_tree_grab_custom then
        modifier_tiny_tree_grab_custom:Destroy()
    end
    local index = DoUniqueString("tiny_index")
    self[index] = false
	if target then
		local projectile_info = 
		{
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_tiny/tiny_tree_proj.vpcf",
			bDodgeable = true,
			bProvidesVision = true,
			iMoveSpeed = speed,
		    iVisionRadius = 200,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
		ProjectileManager:CreateTrackingProjectile( projectile_info )
	else
		local range = self:GetSpecialValueFor("range")
		local splash_radius = self:GetSpecialValueFor("splash_radius")
		local direction = (position - caster:GetAbsOrigin())
        direction.z = 0
        direction = direction:Normalized()
		local projectile_info = 
        {
			EffectName = "particles/units/heroes/hero_tiny/tiny_tree_linear_proj.vpcf",
			Ability = self,
			vSpawnOrigin = caster:GetOrigin(),
			vVelocity = direction * speed,
			fDistance = range,
			fStartRadius = splash_radius,
			fEndRadius = splash_radius,
			Source = caster,
			bHasFrontalCone = false,
			bReplaceExisting = true,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			iVisionRadius = splash_radius,
			iVisionTeamNumber = caster:GetTeamNumber(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
            ExtraData = {index = index}
		}
		ProjectileManager:CreateLinearProjectile( projectile_info )
	end
	caster:EmitSound("Hero_Tiny.Tree.Throw")
end

function tiny_toss_tree_custom:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then return end
    if extra_data and extra_data.index and self[extra_data.index] then return end
    local slow_duration = self:GetSpecialValueFor("slow_duration")
    local splash_radius = self:GetSpecialValueFor("splash_radius")
    
    if target == nil then
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), location, nil, splash_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
        CreateModifierThinker(self:GetCaster(), self, "modifier_tiny_toss_tree_custom_damage", {duration = 1}, location, self:GetCaster():GetTeamNumber(), false)
        if self:GetCaster():HasModifier("modifier_tiny_19") then
            if #enemies > 0 then
                local tiny_toss_custom = self:GetCaster():FindAbilityByName("tiny_toss_custom")
                if tiny_toss_custom and tiny_toss_custom:GetLevel() > 0 and not enemies[1]:IsDebuffImmune() then
                    enemies[1]:RemoveModifierByName("modifier_spirit_breaker_charge_of_darkness_custom")
                    enemies[1]:AddNewModifier( self:GetCaster(), tiny_toss_custom, "modifier_tiny_toss_custom", { point_x = enemies[1]:GetAbsOrigin().x, point_y = enemies[1]:GetAbsOrigin().y, use = true } )
                end
            end
        end
    else
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, splash_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
        target:AddNewModifier(self:GetCaster(), self, "modifier_tiny_toss_tree_custom_damage", {})
        if self:GetCaster():HasModifier("modifier_tiny_19") then
            if #enemies > 0 then
                local tiny_toss_custom = self:GetCaster():FindAbilityByName("tiny_toss_custom")
                if tiny_toss_custom and tiny_toss_custom:GetLevel() > 0 and not target:IsDebuffImmune() then
                    target:RemoveModifierByName("modifier_spirit_breaker_charge_of_darkness_custom")
                    target:AddNewModifier( self:GetCaster(), tiny_toss_custom, "modifier_tiny_toss_custom", { point_x = target:GetAbsOrigin().x, point_y = target:GetAbsOrigin().y, use = true } )
                end
            end
        end
        local cleave_p = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(cleave_p, 0, location)
        ParticleManager:SetParticleControl(cleave_p, 1, location)
        ParticleManager:ReleaseParticleIndex(cleave_p)
        if extra_data and extra_data.index then
            self[extra_data.index] = true
        end
        if has_enemy or target then
            return true
        end
    end
end

modifier_tiny_toss_tree_custom_damage = class({})
function modifier_tiny_toss_tree_custom_damage:IsHidden() return true end
function modifier_tiny_toss_tree_custom_damage:IsPurgable() return false end
function modifier_tiny_toss_tree_custom_damage:IsPurgeException() return false end
function modifier_tiny_toss_tree_custom_damage:RemoveOnDeath() return false end
function modifier_tiny_toss_tree_custom_damage:OnCreated()
    if not IsServer() then return end
    self.splash_radius = self:GetAbility():GetSpecialValueFor("splash_radius")
    self.splash_pct = 0
    local tiny_tree_grab_custom = self:GetCaster():FindAbilityByName("tiny_tree_grab_custom")
    if tiny_tree_grab_custom then
        self.splash_pct = tiny_tree_grab_custom:GetSpecialValueFor("splash_pct") / 100
    end
    self:StartIntervalThink(FrameTime())
end
function modifier_tiny_toss_tree_custom_damage:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Tiny.Tree.Target")
    self:GetCaster():PerformAttack(self:GetParent(), true, true, true, true, false, false, true)
    self:Destroy()
end
function modifier_tiny_toss_tree_custom_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_AVOID_DAMAGE
    }
end

function modifier_tiny_toss_tree_custom_damage:GetModifierAvoidDamage(params)
    if self:GetParent():GetUnitName() == "npc_dota_thinker" then return 1 end
end

function modifier_tiny_toss_tree_custom_damage:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.attacker ~= self:GetCaster() then return end
    local damage = params.original_damage
    local splash_damage = damage * self.splash_pct
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.splash_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
    for _, enemy in pairs(enemies) do
        if enemy ~= self:GetParent() then
            ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = splash_damage, damage_type = DAMAGE_TYPE_PHYSICAL})
        end
    end
end