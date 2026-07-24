--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_viscous_nasal_goo_custom", "heroes/npc_dota_hero_bristleback_custom/bristleback_viscous_nasal_goo_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_viscous_nasal_goo_custom_stack", "heroes/npc_dota_hero_bristleback_custom/bristleback_viscous_nasal_goo_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_viscous_nasal_goo_custom_count", "heroes/npc_dota_hero_bristleback_custom/bristleback_viscous_nasal_goo_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_viscous_nasal_goo_custom = class({})

bristleback_viscous_nasal_goo_custom.modifier_bristleback_17 = {-3,-6}
bristleback_viscous_nasal_goo_custom.modifier_bristleback_8 = {26,36,46}
bristleback_viscous_nasal_goo_custom.modifier_bristleback_bonus = {13,18,23}
bristleback_viscous_nasal_goo_custom.modifier_bristleback_8_duration = 5
bristleback_viscous_nasal_goo_custom.modifier_bristleback_9 = {350,700}
bristleback_viscous_nasal_goo_custom.modifier_bristleback_11 = {1,2,3}
bristleback_viscous_nasal_goo_custom.modifier_bristleback_13 = {25,50}
bristleback_viscous_nasal_goo_custom.modifier_bristleback_13_need_stack = 2

function bristleback_viscous_nasal_goo_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_proj.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_goo.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_stack.vpcf", context )
end

function bristleback_viscous_nasal_goo_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_bristleback_17") then
		return "bristleback_17"
	end
	return "bristleback_viscous_nasal_goo"
end

function bristleback_viscous_nasal_goo_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_bristleback_9") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function bristleback_viscous_nasal_goo_custom:OnSpellStart(enemy, caster, double)
  	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local pointer = self:GetCaster()
    local lotus = 0
    local double_t = 0
    if double then
        double_t = 1
    end
    if target ~= nil then
        lotus = 1
    end
	if enemy then
		target = enemy
	end
	if caster then
		pointer = caster
	end
    print(double)
  	self:GetCaster():EmitSound("Hero_Bristleback.ViscousGoo.Cast")
    local projectile =
    {
      	Target = target,
      	Source = pointer,
      	Ability = self,
      	EffectName = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf",
      	iMoveSpeed = self:GetSpecialValueFor("goo_speed"),
      	vSourceLoc = pointer:GetAbsOrigin(),
      	bDrawsOnMinimap = false,
      	bDodgeable = true,
      	bIsAttack = false,
      	bVisibleToEnemies = true,
      	bReplaceExisting = false,
      	flExpireTime = GameRules:GetGameTime() + 10,
      	bProvidesVision = false,
        ExtraData = {lotus = lotus, double = double_t}
    }
	
	local warpath = self:GetCaster():FindModifierByName("modifier_bristleback_warpath_custom")
	if warpath then 
  		warpath:IncStacks()
	end

	if enemy == nil and caster == nil then
		if self:GetCaster():HasModifier("modifier_bristleback_9") then
			self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1)
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_bristleback_9[self:GetCaster():GetTalentLevel("modifier_bristleback_9")]), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
  			for _, enemy in pairs(enemies) do
				projectile.Target = enemy
				ProjectileManager:CreateTrackingProjectile(projectile)
			end
			return
		end
	end

    ProjectileManager:CreateTrackingProjectile(projectile)
end

function bristleback_viscous_nasal_goo_custom:TalentRadius(target)
  	if not IsServer() then return end
  	self:GetCaster():EmitSound("Hero_Bristleback.ViscousGoo.Cast")
    local projectile =
    {
      	Target = target,
      	Source = self:GetCaster(),
      	Ability = self,
      	EffectName = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf",
      	iMoveSpeed = self:GetSpecialValueFor("goo_speed"),
      	vSourceLoc = self:GetCaster():GetAbsOrigin(),
      	bDrawsOnMinimap = false,
      	bDodgeable = true,
      	bIsAttack = false,
      	bVisibleToEnemies = true,
      	bReplaceExisting = false,
      	flExpireTime = GameRules:GetGameTime() + 10,
      	bProvidesVision = false,
        ExtraData = {lotus = 0, double = 0}
    }
    ProjectileManager:CreateTrackingProjectile(projectile)
end

function bristleback_viscous_nasal_goo_custom:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	if hTarget == nil or not hTarget:IsAlive() or hTarget:IsMagicImmune() then return end
    if ExtraData and ExtraData.lotus == 1 then
        if hTarget:TriggerSpellAbsorb(self) then return end
    end
    local duration = self:GetSpecialValueFor("goo_duration")
    if hTarget:IsCreep() then 
      	duration = self:GetSpecialValueFor("goo_duration_creep")
    end
    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_bristleback_viscous_nasal_goo_custom", {duration = duration * (1 - hTarget:GetStatusResistance())})
    print(ExtraData.double)
    if ExtraData.double == 1 then
        hTarget:AddNewModifier(self:GetCaster(), self, "modifier_bristleback_viscous_nasal_goo_custom", {duration = duration * (1 - hTarget:GetStatusResistance())})
    end
    hTarget:EmitSound("Hero_Bristleback.ViscousGoo.Target")
	if self:GetCaster():HasModifier("modifier_bristleback_8") then
		local modifier_bristleback_11 = 0
		if self:GetCaster():HasModifier("modifier_bristleback_11") then
			modifier_bristleback_11 = self.modifier_bristleback_11[self:GetCaster():GetTalentLevel("modifier_bristleback_11")]
		end
		local stack_max = self:GetSpecialValueFor("stack_limit") + modifier_bristleback_11
		local stack = hTarget:GetModifierStackCount("modifier_bristleback_viscous_nasal_goo_custom_count", self:GetCaster())
		local damage = self.modifier_bristleback_8[self:GetCaster():GetTalentLevel("modifier_bristleback_8")] + (stack * self.modifier_bristleback_bonus[self:GetCaster():GetTalentLevel("modifier_bristleback_8")])
      	ApplyDamage({ victim = hTarget, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, attacker = self:GetCaster(), ability = self})
		if stack < stack_max then
			hTarget:AddNewModifier(self:GetCaster(), self, "modifier_bristleback_viscous_nasal_goo_custom_stack", {duration = self.modifier_bristleback_8_duration * (1 - hTarget:GetStatusResistance())})
      		hTarget:AddNewModifier(self:GetCaster(), self, "modifier_bristleback_viscous_nasal_goo_custom_count", {duration = self.modifier_bristleback_8_duration * (1 - hTarget:GetStatusResistance())})
		end
	end
end

modifier_bristleback_viscous_nasal_goo_custom = class({})

function modifier_bristleback_viscous_nasal_goo_custom:GetEffectName()
  	return "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf"
end

function modifier_bristleback_viscous_nasal_goo_custom:GetStatusEffectName()
  	return "particles/status_fx/status_effect_goo.vpcf"
end

function modifier_bristleback_viscous_nasal_goo_custom:StatusEffectPriority()
    return 10
end

function modifier_bristleback_viscous_nasal_goo_custom:OnCreated()
  	self.ability  = self:GetAbility()
  	self.caster   = self:GetCaster()
  	self.parent   = self:GetParent()
  	self.base_armor       = self.ability:GetSpecialValueFor("base_armor")
  	self.armor_per_stack    = self.ability:GetSpecialValueFor("armor_per_stack")
  	self.base_move_slow     = self.ability:GetSpecialValueFor("base_move_slow")
  	self.move_slow_per_stack  = self.ability:GetSpecialValueFor("move_slow_per_stack")
  	self.stack_limit      = self.ability:GetSpecialValueFor("stack_limit")
  	if not IsServer() then return end
  	self:SetStackCount(1)
	if self:GetParent():IsHero() then
  		self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
  		ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
  		self:AddParticle(self.particle, false, false, -1, false, false)
	end
	self:StartIntervalThink(1)
end

function modifier_bristleback_viscous_nasal_goo_custom:OnRefresh()
  	if not IsServer() then return end
	local modifier_bristleback_11 = 0
	if self:GetCaster():HasModifier("modifier_bristleback_11") then
		modifier_bristleback_11 = self:GetAbility().modifier_bristleback_11[self:GetCaster():GetTalentLevel("modifier_bristleback_11")]
	end
  	if self:GetStackCount() < (self.stack_limit + modifier_bristleback_11) then
    	self:IncrementStackCount()
        if self.particle then
    	    ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
        end
  	end
end

function modifier_bristleback_viscous_nasal_goo_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_bristleback_13") and self:GetStackCount() >= self:GetAbility().modifier_bristleback_13_need_stack then
		local damage = self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_bristleback_13[self:GetCaster():GetTalentLevel("modifier_bristleback_13")]
		ApplyDamage({ victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, attacker = self:GetCaster(), ability = self:GetAbility()})
	end
end

function modifier_bristleback_viscous_nasal_goo_custom:DeclareFunctions()
    return 
	{
    	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS 
    }
end

function modifier_bristleback_viscous_nasal_goo_custom:GetModifierMoveSpeedBonus_Percentage()
    return ((self.base_move_slow + (self.move_slow_per_stack * self:GetStackCount())) * (-1))
end

function modifier_bristleback_viscous_nasal_goo_custom:GetModifierPhysicalArmorBonus()
    return ((self.base_armor + (self.armor_per_stack * self:GetStackCount())) * (-1))
end

function modifier_bristleback_viscous_nasal_goo_custom:GetModifierMagicalResistanceBonus()
	if self:GetCaster():HasModifier("modifier_bristleback_17") then
    	return self:GetStackCount() * self:GetAbility().modifier_bristleback_17[self:GetCaster():GetTalentLevel("modifier_bristleback_17")]
	end
	return 0
end

modifier_bristleback_viscous_nasal_goo_custom_count = class({})
function modifier_bristleback_viscous_nasal_goo_custom_count:IsHidden() return true end
function modifier_bristleback_viscous_nasal_goo_custom_count:IsPurgable() return false end
function modifier_bristleback_viscous_nasal_goo_custom_count:OnCreated()
  	if not IsServer() then return end
  	self:IncrementStackCount()
end
function modifier_bristleback_viscous_nasal_goo_custom_count:OnRefresh()
  	if not IsServer() then return end
  	self:IncrementStackCount()
end

modifier_bristleback_viscous_nasal_goo_custom_stack = class({})
function modifier_bristleback_viscous_nasal_goo_custom_stack:IsHidden() return true end
function modifier_bristleback_viscous_nasal_goo_custom_stack:IsPurgable() return false end
function modifier_bristleback_viscous_nasal_goo_custom_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bristleback_viscous_nasal_goo_custom_stack:OnDestroy()
	if not IsServer() then return end
	local mod = self:GetParent():FindModifierByName("modifier_bristleback_quill_spray_custom")
	if mod then 
  		mod:DecrementStackCount()
	end
end

LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

bristleback_sneezing = class({})

function bristleback_sneezing:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Bristleback.Hairball.Cast")
	local bristleback_viscous_nasal_goo_custom = self:GetCaster():FindAbilityByName("bristleback_viscous_nasal_goo_custom")
	if bristleback_viscous_nasal_goo_custom and bristleback_viscous_nasal_goo_custom:GetLevel() > 0 then
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
		for _, enemy in pairs(enemies) do
			bristleback_viscous_nasal_goo_custom:TalentRadius(enemy)
		end
	end
    local warpath = self:GetCaster():FindModifierByName("modifier_bristleback_warpath_custom")
	if warpath then 
  		warpath:IncStacks()
	end
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1)
	local direction = self:GetCaster():GetForwardVector()
    local distance = self:GetSpecialValueFor("knockback")
    if self:GetCaster():IsRooted() then
        distance = 0
    end
    local knockback = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = self:GetSpecialValueFor("knockback_duration"), distance = distance, height = 100, direction_x = direction.x, direction_y = direction.y})
end