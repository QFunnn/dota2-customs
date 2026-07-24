--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dazzle_poison_touch_custom", "heroes/npc_dota_hero_dazzle_custom/dazzle_poison_touch_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dazzle_poison_touch_custom_handler", "heroes/npc_dota_hero_dazzle_custom/dazzle_poison_touch_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dazzle_poison_touch_custom_handler_cooldown", "heroes/npc_dota_hero_dazzle_custom/dazzle_poison_touch_custom", LUA_MODIFIER_MOTION_NONE )

dazzle_poison_touch_custom = class({})
dazzle_poison_touch_custom.modifier_dazzle_10 = {0.9,1.8}
dazzle_poison_touch_custom.modifier_dazzle_9 = {20,30,40}
dazzle_poison_touch_custom.modifier_dazzle_8_duration = 3
dazzle_poison_touch_custom.modifier_dazzle_8_cooldown = 30

function dazzle_poison_touch_custom:GetIntrinsicModifierName()
    return "modifier_dazzle_poison_touch_custom_handler"
end

function dazzle_poison_touch_custom:OnSpellStartNew(target)
	if not IsServer() then return end
    local duration = self:GetSpecialValueFor( "duration" )
	target:AddNewModifier( self:GetCaster(), self, "modifier_dazzle_poison_touch_custom", { duration = duration * (1 - target:GetStatusResistance()) } )
    target:EmitSound("Hero_Dazzle.Poison_Touch")
end

function dazzle_poison_touch_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local origin = caster:GetOrigin()
	if target:TriggerSpellAbsorb( self ) then return end
	local max_targets = self:GetSpecialValueFor( "targets" )
	local distance = self:GetSpecialValueFor( "end_distance" )
	local start_radius = self:GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetSpecialValueFor( "end_radius" )
	local direction = target:GetOrigin()-origin
	direction.z = 0
	direction = direction:Normalized()
	local enemies = self:FindUnitsInCone( caster:GetTeamNumber(), target:GetOrigin(), caster:GetOrigin(), caster:GetOrigin() + direction*distance, start_radius, end_radius, nil, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
	local projectile_name = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )
	local info = 
    {
		Source = caster,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = false,
	}
	local counter = 0
	for _,enemy in pairs(enemies) do
		info.Target = enemy
		ProjectileManager:CreateTrackingProjectile(info)
		counter = counter+1
		if counter>=max_targets then break end
	end
	caster:EmitSound("Hero_Dazzle.Poison_Cast")
end

function dazzle_poison_touch_custom:OnProjectileHit( target, location )
	if not target then return end
	local duration = self:GetSpecialValueFor( "duration" )
	target:AddNewModifier( self:GetCaster(), self, "modifier_dazzle_poison_touch_custom", { duration = duration * (1 - target:GetStatusResistance()) } )
    target:EmitSound("Hero_Dazzle.Poison_Touch")
    local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
    if dazzle_innate_weave_custom and dazzle_innate_weave_custom:GetLevel() > 0 then
        dazzle_innate_weave_custom:TargetModifier(target)
    end
    if self:GetCaster():HasModifier("modifier_dazzle_12") then
        self:GetCaster():PerformAttack(target, true, true, true, false, true, false, false)
    end
    if self:GetCaster():HasModifier("modifier_dazzle_nothl_projection_soul_clone") or self:GetCaster():HasModifier("modifier_dazzle_10") then
        local dazzle_nothl_projection = self:GetCaster():FindAbilityByName("dazzle_nothl_projection")
        local duration_hex = dazzle_nothl_projection:GetSpecialValueFor("poison_touch_hex")
        if not self:GetCaster():HasModifier("modifier_dazzle_nothl_projection_soul_clone") and self:GetCaster():HasModifier("modifier_dazzle_10") then
            duration_hex = self.modifier_dazzle_10[self:GetCaster():GetTalentLevel("modifier_dazzle_10")]
        end
        target:AddNewModifier(self:GetCaster(), self, "modifier_hexxed", {duration = duration_hex * (1 - target:GetStatusResistance())})
        if target:IsIllusion() then
            target:Kill(self, self:GetCaster())
        end
    end
end

function dazzle_poison_touch_custom:FindUnitsInCone( nTeamNumber, vCenterPos, vStartPos, vEndPos, fStartRadius, fEndRadius, hCacheUnit, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter, bCanGrowCache )
	local direction = vEndPos-vStartPos
	direction.z = 0
	local distance = direction:Length2D()
	direction = direction:Normalized()
	local big_radius = distance + math.max(fStartRadius, fEndRadius)
	local units = FindUnitsInRadius( nTeamNumber, vCenterPos, nil, big_radius, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter, bCanGrowCache )
	local targets = {}
	for _,unit in pairs(units) do
		local vUnitPos = unit:GetOrigin()-vStartPos
		local fProjection = vUnitPos.x*direction.x + vUnitPos.y*direction.y + vUnitPos.z*direction.z
		fProjection = math.max(math.min(fProjection,distance),0)
		local vProjection = direction*fProjection
		local fUnitRadius = (vUnitPos - vProjection):Length2D()
		local fInterpRadius = (fProjection/distance)*(fEndRadius-fStartRadius) + fStartRadius
		if fUnitRadius<=fInterpRadius then
			table.insert( targets, unit )
		end
	end
	return targets
end

modifier_dazzle_poison_touch_custom = class({})

function modifier_dazzle_poison_touch_custom:IsHidden()
	return false
end

function modifier_dazzle_poison_touch_custom:IsDebuff()
	return true
end

function modifier_dazzle_poison_touch_custom:IsStunDebuff()
	return false
end

function modifier_dazzle_poison_touch_custom:IsPurgable()
	return true
end

function modifier_dazzle_poison_touch_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_dazzle_poison_touch_custom:OnCreated( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_dazzle_9") then
        damage = damage + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_dazzle_9[self:GetCaster():GetTalentLevel("modifier_dazzle_9")])
    end
	self.slow = self:GetAbility():GetSpecialValueFor( "slow" )
    self.bonus_slow = self:GetAbility():GetSpecialValueFor("bonus_slow")
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	if not IsServer() then return end
	self.damageTable = 
    {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
        damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK
	}
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_dazzle_poison_touch_custom:DeclareFunctions()
	local funcs = 
    {
		 
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_dazzle_poison_touch_custom:OnAttackLanded( params )
	if params.target~=self:GetParent() then return end
    local is_valid = false
    if params.attacker == self:GetCaster() or params.attacker:HasModifier("modifier_dazzle_nothl_projection_soul_clone") then
        is_valid = true
    end
    if not is_valid then return end
    if IsServer() then
	    self:SetDuration( self.duration, true )
    end
    self.slow = self.slow + self.bonus_slow
end

function modifier_dazzle_poison_touch_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_dazzle_poison_touch_custom:OnIntervalThink()
	if not IsServer() then return end
	ApplyDamage( self.damageTable )
	self:GetParent():EmitSound("Hero_Dazzle.Poison_Tick")
end

function modifier_dazzle_poison_touch_custom:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_poison_debuff.vpcf"
end

function modifier_dazzle_poison_touch_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dazzle_poison_touch_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_dazzle_copy.vpcf"
end




modifier_dazzle_poison_touch_custom_handler = class({})
function modifier_dazzle_poison_touch_custom_handler:IsPurgable() return false end
function modifier_dazzle_poison_touch_custom_handler:IsHidden() return true end
function modifier_dazzle_poison_touch_custom_handler:IsPurgeException() return false end
function modifier_dazzle_poison_touch_custom_handler:RemoveOnDeath() return false end
function modifier_dazzle_poison_touch_custom_handler:DeclareFunctions()
    return
    {
         
    }
end

function dazzle_poison_touch_custom:GetIntrinsicModifierName()
	if self:GetCaster():IsIllusion() then return end
	return "modifier_dazzle_poison_touch_custom_handler"
end

function modifier_dazzle_poison_touch_custom_handler:OnTakeDamage(params)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_dazzle_8") then
    	if params.attacker == self:GetCaster() then return end
    	if params.unit ~= self:GetCaster() then return end
    	if params.attacker:HasModifier("modifier_dazzle_poison_touch_custom_handler_cooldown") then return end
    	if self:GetParent():HasModifier("modifier_dazzle_18") then return end
    	if self:GetParent():HasModifier("modifier_dazzle_1") then return end
        if self:GetParent():HasModifier("modifier_wodawisp") then return end
	    if self:GetParent():HasModifier("modifier_wodarelax") then return end
	    if not self:GetParent():IsAlive() then return end
    	params.attacker:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_dazzle_poison_touch_custom_handler_cooldown", {duration = self:GetAbility().modifier_dazzle_8_cooldown})
    	self:GetAbility():OnSpellStartNew(params.attacker, self:GetAbility().modifier_dazzle_8_duration)
    	return
    end
end

modifier_dazzle_poison_touch_custom_handler_cooldown = class({})
function modifier_dazzle_poison_touch_custom_handler_cooldown:IsPurgable() return false end
function modifier_dazzle_poison_touch_custom_handler_cooldown:IsHidden() return true end
function modifier_dazzle_poison_touch_custom_handler_cooldown:IsPurgeException() return false end
function modifier_dazzle_poison_touch_custom_handler_cooldown:RemoveOnDeath() return false end