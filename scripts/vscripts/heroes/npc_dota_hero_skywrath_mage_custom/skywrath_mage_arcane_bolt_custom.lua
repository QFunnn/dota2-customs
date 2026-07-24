--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skywrath_mage_arcane_bolt_custom", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_arcane_bolt_custom_magic_immune", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_arcane_bolt_custom", LUA_MODIFIER_MOTION_NONE )

skywrath_mage_arcane_bolt_custom = class({})

skywrath_mage_arcane_bolt_custom.modifier_skywrath_mage_1_attacks = {6,5,4}
skywrath_mage_arcane_bolt_custom.modifier_skywrath_mage_2_count = {1,2}
skywrath_mage_arcane_bolt_custom.modifier_skywrath_mage_6_duration = 10
skywrath_mage_arcane_bolt_custom.modifier_skywrath_mage_6_magicimmune = {-1.5,-3}


skywrath_mage_arcane_bolt_custom.modifier_skywrath_mage_8_speed_mult = 2
skywrath_mage_arcane_bolt_custom.modifier_skywrath_mage_8_cooldown = -0.5

function skywrath_mage_arcane_bolt_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf", context )
end

function skywrath_mage_arcane_bolt_custom:GetIntrinsicModifierName()
	return "modifier_skywrath_mage_arcane_bolt_custom"
end

function skywrath_mage_arcane_bolt_custom:GetCooldown(level)
	local cooldown = self.BaseClass.GetCooldown( self, level )
	if self:GetCaster():HasModifier("modifier_skywrath_mage_8") then
        cooldown = cooldown + self.modifier_skywrath_mage_8_cooldown
	end
    return cooldown
end

function skywrath_mage_arcane_bolt_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_skywrath_mage_4") then
        return 0
    end
	local manacost = self.BaseClass.GetManaCost(self, level)
    return manacost
end

function skywrath_mage_arcane_bolt_custom:GetHealthCost(level)
    if self:GetCaster():HasModifier("modifier_skywrath_mage_4") then
        local manacost = self.BaseClass.GetManaCost(self, level)
        return manacost
    end
    return 0
end

function skywrath_mage_arcane_bolt_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() and (not self:GetCaster():HasModifier("modifier_skywrath_mage_7")) then
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

function skywrath_mage_arcane_bolt_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if new_target then
		target = new_target
	end
	local projectile_speed = self:GetSpecialValueFor( "bolt_speed" )
	local projectile_vision = self:GetSpecialValueFor( "bolt_vision" )
	local base_damage = self:GetSpecialValueFor( "bolt_damage" )
	local multiplier = self:GetSpecialValueFor( "int_multiplier" )
    if self:GetCaster():HasModifier("modifier_skywrath_mage_8") then
        projectile_speed = projectile_speed * self.modifier_skywrath_mage_8_speed_mult
	end
	local damage = base_damage

	if caster:HasModifier("modifier_skywrath_mage_4") then
		damage = damage + multiplier * caster:GetStrength()
	else
		damage = damage + multiplier * caster:GetIntellect(false)
	end

	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
		iVisionTeamNumber = caster:GetTeamNumber(),
		ExtraData = 
		{
			damage = damage,
		}
	}

	ProjectileManager:CreateTrackingProjectile(info)

	local flag = DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS

	if self:GetCaster():HasModifier("modifier_skywrath_mage_7") then
		flag = DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE
	end

	if caster:HasModifier("modifier_skywrath_mage_2") and new_target == nil then
        local scepter_radius = self:GetSpecialValueFor("scepter_radius")
        local talent_level = caster:GetTalentLevel("modifier_skywrath_mage_2")
        local extra_count = self.modifier_skywrath_mage_2_count[talent_level] or 1
        local enemies = FindUnitsInRadius(
            caster:GetTeamNumber(),
            target:GetOrigin(),
            nil,
            scepter_radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            flag,
            FIND_ANY_ORDER,
            false
        )
        local used_targets = 
        {
            [target:entindex()] = true
        }
        for i = 1, extra_count do
            local extra_target = nil
            -- Сначала ищем героя
            for _, enemy in pairs(enemies) do
                if enemy
                    and enemy:IsAlive()
                    and enemy:IsHero()
                    and not used_targets[enemy:entindex()]
                then
                    extra_target = enemy
                    break
                end
            end
            -- Если героя нет, берем любого другого юнита
            if not extra_target then
                for _, enemy in pairs(enemies) do
                    if enemy
                        and enemy:IsAlive()
                        and not used_targets[enemy:entindex()]
                    then
                        extra_target = enemy
                        break
                    end
                end
            end
            if extra_target then
                used_targets[extra_target:entindex()] = true
                local new_info = info
                new_info.Target = extra_target
                ProjectileManager:CreateTrackingProjectile(new_info)
            end
        end
    end

	caster:EmitSound("Hero_SkywrathMage.ArcaneBolt.Cast")
end

function skywrath_mage_arcane_bolt_custom:OnProjectileHit_ExtraData( target, location, extraData )
	if not target then return end	
	if target:TriggerSpellAbsorb( self ) then return end
	if target:IsMagicImmune() then return end

	if self:GetCaster():HasModifier("modifier_skywrath_mage_6") then
		target:AddNewModifier(self:GetCaster(), self, "modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack", {duration = self.modifier_skywrath_mage_6_duration})
		target:AddNewModifier(self:GetCaster(), self, "modifier_skywrath_mage_arcane_bolt_custom_magic_immune", {duration = self.modifier_skywrath_mage_6_duration})
	end

	local damageTable = 
	{
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self
	}

	ApplyDamage(damageTable)

	target:AddNewModifier(self:GetCaster(), self, "modifier_skywrath_mage_arcane_bolt_lifesteal", {duration = self:GetSpecialValueFor("lifesteal_duration")})

	local vision = self:GetSpecialValueFor( "bolt_vision" )
	local duration = self:GetSpecialValueFor( "vision_duration" )

	AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, duration, false )

	target:EmitSound("Hero_SkywrathMage.ArcaneBolt.Impact")
	self:GetCaster():StopSound("Hero_SkywrathMage.ArcaneBolt.Cast")
end

modifier_skywrath_mage_arcane_bolt_custom = class({})

function modifier_skywrath_mage_arcane_bolt_custom:IsHidden() return not self:GetCaster():HasModifier("modifier_skywrath_mage_1") end
function modifier_skywrath_mage_arcane_bolt_custom:IsPurgable() return false end
function modifier_skywrath_mage_arcane_bolt_custom:IsPurgeException() return false end

function modifier_skywrath_mage_arcane_bolt_custom:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(0)
end

function modifier_skywrath_mage_arcane_bolt_custom:DeclareFunctions()
	return {
		 
	}
end

function modifier_skywrath_mage_arcane_bolt_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.target ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
    if params.no_attack_cooldown then return end
	if not self:GetParent():HasModifier("modifier_skywrath_mage_1") then return end
	self:IncrementStackCount()
	if self:GetStackCount() >= self:GetAbility().modifier_skywrath_mage_1_attacks[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_1")] then
		if not self:GetCaster():HasModifier("modifier_skywrath_mage_7") then
			if not params.attacker:IsMagicImmune() then
				self:GetAbility():OnSpellStart(params.attacker)
			end
		else
			self:GetAbility():OnSpellStart(params.attacker)
		end
		self:SetStackCount(0)
	end
end

modifier_skywrath_mage_arcane_bolt_custom_magic_immune = class({})

function modifier_skywrath_mage_arcane_bolt_custom_magic_immune:GetTexture() return "skywrath_mage_6" end

function modifier_skywrath_mage_arcane_bolt_custom_magic_immune:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self:SetStackCount(1)
end

function modifier_skywrath_mage_arcane_bolt_custom_magic_immune:OnIntervalThink()
	if not IsServer() then return end
	local modifiers = self:GetParent():FindAllModifiersByName("modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack")
	self:SetStackCount(#modifiers)
end

modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack = class({})

function modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack:GetTexture() return "skywrath_mage_6" end
function modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack:IsHidden() return true end
function modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_skywrath_mage_arcane_bolt_custom_magic_immune_stack:GetModifierMagicalResistanceBonus()
	return self:GetAbility().modifier_skywrath_mage_6_magicimmune[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_6")]
end