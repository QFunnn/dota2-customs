--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_quill_spray_custom_thinker", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_quill_spray_custom", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_quill_spray_custom_count", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_quill_spray_custom_health_regen", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_quill_spray_custom_health_regen_count", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_quill_spray_custom_health_cost_increased", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_quill_spray_custom_handler", "heroes/npc_dota_hero_bristleback_custom/bristleback_quill_spray_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_quill_spray_custom = class({})

bristleback_quill_spray_custom.modifier_bristleback_3 = 4
bristleback_quill_spray_custom.modifier_bristleback_3_duration = {10,20}
bristleback_quill_spray_custom.modifier_bristleback_6_self = 1
bristleback_quill_spray_custom.modifier_bristleback_6_enemy = {2,3,4}
bristleback_quill_spray_custom.modifier_bristleback_18 = {70,140,210}
--bristleback_quill_spray_custom.modifier_bristleback_21 = 80
--bristleback_quill_spray_custom.modifier_bristleback_21_inc = 120
--bristleback_quill_spray_custom.modifier_bristleback_21_duration = 6

function bristleback_quill_spray_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
  	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf", context )
  	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_quill_spray_impact.vpcf", context )
  	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit.vpcf", context )
  	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit_creep.vpcf", context )
end

function bristleback_quill_spray_custom:GetIntrinsicModifierName()
    return "modifier_bristleback_quill_spray_custom_handler"
end

function bristleback_quill_spray_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_bristleback_15") then
		return "bristleback_15"
	end
	return "bristleback_quill_spray"
end

function bristleback_quill_spray_custom:GetCooldown(level)
    local bonus = 1
    return self.BaseClass.GetCooldown( self, level ) * bonus
end

function bristleback_quill_spray_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function bristleback_quill_spray_custom:GetHealthCost(level)
	local bonus = 0
	local stack = self:GetCaster():GetModifierStackCount("modifier_bristleback_quill_spray_custom_health_cost_increased", self:GetCaster())
	if self:GetCaster():HasModifier("modifier_bristleback_6") then
		bonus = self:GetCaster():GetMaxHealth() / 100 * self.modifier_bristleback_6_self
	end
	if self:GetCaster():HasModifier("modifier_bristleback_6") then
		if stack > 0 then
			local old_number = bonus +  ( ( bonus / 100 * self.modifier_bristleback_21_inc ) * (stack-1) )
			return old_number + ( ( old_number / 100 * self.modifier_bristleback_21_inc ) * stack)
		end
        return bonus
    end
    return 0
end

function bristleback_quill_spray_custom:OnSpellStart()
	if not IsServer() then return end
	self:MakeSpray(nil, nil, true)
	local warpath = self:GetCaster():FindModifierByName("modifier_bristleback_warpath_custom")
	if warpath then 
  		warpath:IncStacks()
	end
	if self:GetCaster():HasModifier("modifier_bristleback_3") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_quill_spray_custom_health_regen", {duration = self.modifier_bristleback_3_duration[self:GetCaster():GetTalentLevel("modifier_bristleback_3")]})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_quill_spray_custom_health_regen_count", {duration = self.modifier_bristleback_3_duration[self:GetCaster():GetTalentLevel("modifier_bristleback_3")]})
	end
	--if self:GetCaster():HasModifier("modifier_bristleback_21") then
	--	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_quill_spray_custom_health_cost_increased", {duration = self.modifier_bristleback_21_duration})
	--end
end 

modifier_bristleback_quill_spray_custom_health_cost_increased = class({})
function modifier_bristleback_quill_spray_custom_health_cost_increased:IsPurgable() return false end
function modifier_bristleback_quill_spray_custom_health_cost_increased:IsPurgeException() return false end
function modifier_bristleback_quill_spray_custom_health_cost_increased:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end
function modifier_bristleback_quill_spray_custom_health_cost_increased:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
end

function bristleback_quill_spray_custom:MakeSpray(location, is_cone, is_ability)
	self.caster = self:GetCaster()
    if self.caster:IsIllusion() then return end
	self.radius = self:GetSpecialValueFor("radius") 
	self.projectile_speed = self:GetSpecialValueFor("projectile_speed")
	self.duration = self.radius / self.projectile_speed
	if location == nil then 
  		self.location = self:GetCaster():GetAbsOrigin()
	else  
  		self.location = location
	end
	if not IsServer() then return end
	if location == nil then 
  		self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
  		self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	end
    local cone = 0
    if is_cone and is_cone == true then 
        cone = 1
    end 
	CreateModifierThinker(self.caster, self, "modifier_bristleback_quill_spray_custom_thinker", {duration = self.duration, cone = cone, is_ability = is_ability}, self.location, self.caster:GetTeamNumber(), false)
	self.caster:EmitSound("Hero_Bristleback.QuillSpray.Cast")
end

modifier_bristleback_quill_spray_custom_thinker = class({})

function modifier_bristleback_quill_spray_custom_thinker:OnCreated(params)
  	self.ability = self:GetAbility()
  	self.caster = self:GetCaster()
  	self.parent = self:GetParent()
  	self.radius = self.ability:GetSpecialValueFor("radius")
  	self.quill_base_damage = self.ability:GetSpecialValueFor("quill_base_damage")
  	self.quill_stack_damage = self.ability:GetSpecialValueFor("quill_stack_damage") 
  	self.quill_stack_duration = self.ability:GetSpecialValueFor("quill_stack_duration")
  	self.max_damage = self.ability:GetSpecialValueFor("max_damage")
  	if not IsServer() then return end
    self.is_ability = params.is_ability
    self.cone = params.cone
    if self.cone == 1 then 
        self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray_conical.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
  	    self:AddParticle(self.particle, false, false, -1, false, false)
    else
        self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray.vpcf", PATTACH_ABSORIGIN, self.parent)
  	    self:AddParticle(self.particle, false, false, -1, false, false)
    end
  	self.hit_enemies = {}
  	self:StartIntervalThink(FrameTime())
end

function modifier_bristleback_quill_spray_custom_thinker:OnIntervalThink()
  	if not IsServer() then return end
    local damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK
    if not self.is_ability then
        damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_REFLECTION
    end
  	local radius_pct = math.min((self:GetDuration() - self:GetRemainingTime()) / self:GetDuration(), 1)
  	local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius * radius_pct, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
  	for _, enemy in pairs(enemies) do
		local hit_already = false
		for _, hit_enemy in pairs(self.hit_enemies) do
			if hit_enemy == enemy then
				hit_already = true
				break
			end
		end
    	if not hit_already then
      		local quill_spray_stacks  = 0
      		local quill_spray_modifier  = enemy:FindModifierByName("modifier_bristleback_quill_spray_custom")
			if quill_spray_modifier then
				quill_spray_stacks = quill_spray_modifier:GetStackCount()
			end
			local bonus = 0
			if self:GetCaster():HasModifier("modifier_bristleback_6") and self.is_ability then
				bonus = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_bristleback_6_enemy[self:GetCaster():GetTalentLevel("modifier_bristleback_6")]
			end
			local type_damage = DAMAGE_TYPE_PHYSICAL
			if self:GetCaster():HasModifier("modifier_bristleback_15") then
				type_damage = DAMAGE_TYPE_MAGICAL
			end
			local bonus_max = 0
			if self:GetCaster():HasModifier("modifier_bristleback_18") then
				bonus_max = self:GetAbility().modifier_bristleback_18[self:GetCaster():GetTalentLevel("modifier_bristleback_18")]
			end
			local end_damage = math.min(self.quill_base_damage + (self.quill_stack_damage * quill_spray_stacks), (self.max_damage+bonus_max)) + bonus
            if self.cone == 1 then
                local angle = self:GetAbility():GetSpecialValueFor("activation_angle")
                local origin = self:GetCaster():GetOrigin()
                local cast_direction = self:GetCaster():GetForwardVector() * -1
                local cast_angle = VectorToAngles( cast_direction ).y
                local enemy_direction = (enemy:GetOrigin() - origin):Normalized()
                local enemy_angle = VectorToAngles( enemy_direction ).y
                local angle_diff = math.abs( AngleDiff( cast_angle, enemy_angle ) )
                if angle_diff <= 60 then
                    local damageTable = { victim = enemy, damage = end_damage, damage_type = type_damage, damage_flags = damage_flags, attacker = self.caster, ability = self.ability}
      		        ApplyDamage(damageTable)
			        if enemy:IsHero() then
      		        	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
     		        	ParticleManager:SetParticleControlEnt(particle, 1, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
      		        	ParticleManager:ReleaseParticleIndex(particle)
			        end
      		        enemy:EmitSound("Hero_Bristleback.QuillSpray.Target")
      		        local stack_duration = self.quill_stack_duration
      		        enemy:AddNewModifier(self.caster, self.ability, "modifier_bristleback_quill_spray_custom", {duration = stack_duration * (1 - enemy:GetStatusResistance())})
      		        enemy:AddNewModifier(self.caster, self.ability, "modifier_bristleback_quill_spray_custom_count", {duration = stack_duration * (1 - enemy:GetStatusResistance())})
                end
                local warpath = self:GetCaster():FindModifierByName("modifier_bristleback_warpath_custom")
                if warpath then 
                    warpath:IncStacks()
                end
            else
      		    local damageTable = { victim = enemy, damage = end_damage, damage_type = type_damage, damage_flags = damage_flags, attacker = self.caster, ability = self.ability}
      		    ApplyDamage(damageTable)
			    if enemy:IsHero() then
      		    	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_quill_spray_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
     		    	ParticleManager:SetParticleControlEnt(particle, 1, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
      		    	ParticleManager:ReleaseParticleIndex(particle)
			    end
      		    enemy:EmitSound("Hero_Bristleback.QuillSpray.Target")
      		    local stack_duration = self.quill_stack_duration
      		    enemy:AddNewModifier(self.caster, self.ability, "modifier_bristleback_quill_spray_custom", {duration = stack_duration * (1 - enemy:GetStatusResistance())})
      		    enemy:AddNewModifier(self.caster, self.ability, "modifier_bristleback_quill_spray_custom_count", {duration = stack_duration * (1 - enemy:GetStatusResistance())})
            end
      
      		table.insert(self.hit_enemies, enemy)
      
      		if not enemy:IsAlive() and enemy:IsRealHero() and (enemy.IsReincarnating and not enemy:IsReincarnating()) then
        		self.caster:EmitSound("bristleback_bristle_quill_spray_0"..math.random(1,6))
      		end
    	end
  	end
end

modifier_bristleback_quill_spray_custom = class({})
function modifier_bristleback_quill_spray_custom:IsPurgable() return false end
function modifier_bristleback_quill_spray_custom:OnCreated()
  	self.ability  = self:GetAbility()
  	self.caster   = self:GetCaster()
  	self.parent   = self:GetParent()
  	if not IsServer() then return end
  	self:IncrementStackCount()
  	local particle_name = "particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit.vpcf"
	if self.parent:IsCreep() then 
		particle_name ="particles/units/heroes/hero_bristleback/bristleback_quill_spray_hit_creep.vpcf"
	end
	if self:GetParent():IsHero() then
  		self.particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
  		ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
  		ParticleManager:SetParticleControlEnt(self.particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
  		self:AddParticle(self.particle, false, false, -1, false, false)
	end
end
function modifier_bristleback_quill_spray_custom:OnRefresh()
  	if not IsServer() then return end
  	self:IncrementStackCount()
end

modifier_bristleback_quill_spray_custom_count = class({})
function modifier_bristleback_quill_spray_custom_count:IsHidden() return true end
function modifier_bristleback_quill_spray_custom_count:IsPurgable() return false end
function modifier_bristleback_quill_spray_custom_count:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bristleback_quill_spray_custom_count:OnDestroy()
	if not IsServer() then return end
	local mod = self:GetParent():FindModifierByName("modifier_bristleback_quill_spray_custom")
	if mod then 
  		mod:DecrementStackCount()
	end
end

modifier_bristleback_quill_spray_custom_health_regen = class({})
function modifier_bristleback_quill_spray_custom_health_regen:IsPurgable() return false end
function modifier_bristleback_quill_spray_custom_health_regen:IsPurgeException() return false end
function modifier_bristleback_quill_spray_custom_health_regen:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bristleback_quill_spray_custom_health_regen:IsHidden() return true end
function modifier_bristleback_quill_spray_custom_health_regen:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end
function modifier_bristleback_quill_spray_custom_health_regen:GetModifierConstantHealthRegen()
	return self:GetAbility().modifier_bristleback_3
end

modifier_bristleback_quill_spray_custom_health_regen_count = class({})
function modifier_bristleback_quill_spray_custom_health_regen_count:IsPurgable() return false end
function modifier_bristleback_quill_spray_custom_health_regen_count:IsPurgeException() return false end
function modifier_bristleback_quill_spray_custom_health_regen_count:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end
function modifier_bristleback_quill_spray_custom_health_regen_count:OnIntervalThink()
	if not IsServer() then return end
	local modifier_bristleback_quill_spray_custom_health_regen = self:GetParent():FindAllModifiersByName("modifier_bristleback_quill_spray_custom_health_regen")
	self:SetStackCount(#modifier_bristleback_quill_spray_custom_health_regen)
end

modifier_bristleback_quill_spray_custom_handler = class({})
function modifier_bristleback_quill_spray_custom_handler:IsHidden() return true end
function modifier_bristleback_quill_spray_custom_handler:IsPurgable() return false end
function modifier_bristleback_quill_spray_custom_handler:RemoveOnDeath() return false end
function modifier_bristleback_quill_spray_custom_handler:IsPurgeException() return false end
function modifier_bristleback_quill_spray_custom_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_bristleback_quill_spray_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility():IsFullyCastable() and self:GetAbility():GetAutoCastState() then
        if self:GetParent():HasModifier("modifier_woda_stunned") then return end
		if self:GetParent():HasModifier("modifier_wodarelax") then return end
        if self:GetParent():HasModifier("modifier_wodawisp") then return end
		if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
        if not self:GetParent():IsAlive() then return end
        if self:GetParent():HasModifier("modifier_disconnect_player_no_damage") then
            return
        end
        if self:GetParent():HasModifier("modifier_bristleback_8") then return end
        if self:GetParent():IsSilenced() or self:GetParent():IsStunned() then return end
        self:GetParent():CastAbilityNoTarget(self:GetAbility(), self:GetParent():GetPlayerOwnerID())
    end
end