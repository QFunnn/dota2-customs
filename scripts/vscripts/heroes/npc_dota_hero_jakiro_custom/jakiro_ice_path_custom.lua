--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_jakiro_ice_path_custom_thinker", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_path_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_ice_path_custom", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_path_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_ice_path_custom_magic_immune", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_path_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_ice_path_custom_handler", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_path_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_jakiro_ice_path_custom_thinker_target", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_path_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_ice_path_custom_heal_reduce", "heroes/npc_dota_hero_jakiro_custom/jakiro_ice_path_custom", LUA_MODIFIER_MOTION_NONE )

jakiro_ice_path_custom = class({})

jakiro_ice_path_custom.modifier_jakiro_15 = 150
jakiro_ice_path_custom.modifier_jakiro_19 = {1,2,3}
jakiro_ice_path_custom.modifier_jakiro_19_debuff = {-10,-20,-30}
jakiro_ice_path_custom.modifier_jakiro_13_attack_counter = {17,13}
jakiro_ice_path_custom.modifier_jakiro_13_radius = 150
jakiro_ice_path_custom.modifier_jakiro_13_duration = 1

function jakiro_ice_path_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_ice_path.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_ice_path_b.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_icepath_debuff.vpcf", context)
    PrecacheResource("particle", "particles/jakiro_custom/jakiro_ice_path_aoe.vpcf", context)
    PrecacheResource("particle", "particles/jakiro_custom/jakiro_ice_path_b_aoe.vpcf", context)
end

function jakiro_ice_path_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_jakiro_21") then
        cooldown = cooldown + 1
    end
    return cooldown
end

function jakiro_ice_path_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_jakiro_21") then
        return 0
    end
    return self.BaseClass.GetCastPoint(self)
end

function jakiro_ice_path_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_jakiro_21") then
        return "jakiro_21"
    end
    return "jakiro_ice_path"
end

function jakiro_ice_path_custom:GetIntrinsicModifierName()
    return "modifier_jakiro_ice_path_custom_handler"
end

function jakiro_ice_path_custom:OnSpellStart()
    if not IsServer() then return end
	local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
	local dir = point - self:GetCaster():GetOrigin()
	dir.z = 0
	dir = dir:Normalized()
	CreateModifierThinker( self:GetCaster(), self, "modifier_jakiro_ice_path_custom_thinker", { x = dir.x, y = dir.y }, self:GetCaster():GetOrigin(), self:GetCaster():GetTeamNumber(), false )
    if self:GetCaster():HasModifier("modifier_jakiro_21") then
        self:GetCaster():SetForwardVector(dir)
        local max_range = self:GetCastRange( self:GetCaster():GetAbsOrigin(), nil ) + self:GetCaster():GetCastRangeBonus()
        local current_range = (point - self:GetCaster():GetOrigin()):Length()
        if current_range > max_range then
            point = self:GetCaster():GetOrigin() + dir * max_range
        end
        current_range = (point - self:GetCaster():GetOrigin()):Length()
        local knockback = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = current_range / max_range, distance = current_range, IsStun = false, direction_x = dir.x, direction_y = dir.y} )
        if knockback then
            self:GetCaster():AddActivityModifier("loadout")
            self:GetCaster():AddActivityModifier("corkscrew_gesture")
            self:GetCaster():StartGesture(ACT_DOTA_TAUNT)
            local modifier_jakiro_ice_path_custom_magic_immune = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_jakiro_ice_path_custom_magic_immune", {})
            local callback = function()
                if modifier_jakiro_ice_path_custom_magic_immune then
                    modifier_jakiro_ice_path_custom_magic_immune:Destroy()
                end
                self:GetCaster():RemoveGesture(ACT_DOTA_TAUNT)
            end
            knockback:SetEndCallback( callback )
        end
    end
end

function jakiro_ice_path_custom:CreateTargetAoePath(target)
    CreateModifierThinker( self:GetCaster(), self, "modifier_jakiro_ice_path_custom_thinker_target", {}, target:GetOrigin(), self:GetCaster():GetTeamNumber(), false )
end

modifier_jakiro_ice_path_custom_thinker = class({})
function modifier_jakiro_ice_path_custom_thinker:IsPurgable() return false end

function modifier_jakiro_ice_path_custom_thinker:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_jakiro_15") then
        damage = damage + (self:GetCaster():GetIntellect(true) / 100 * self:GetAbility().modifier_jakiro_15)
    end
	self.range = self:GetAbility():GetCastRange( self.parent:GetAbsOrigin(), nil ) + self.caster:GetCastRangeBonus()
	self.delay = self:GetAbility():GetSpecialValueFor( "path_delay" )
	self.duration = self:GetAbility():GetSpecialValueFor( "path_duration" )
    if self:GetCaster():HasModifier("modifier_jakiro_19") then
        self.duration = self.duration + self:GetAbility().modifier_jakiro_19[self:GetCaster():GetTalentLevel("modifier_jakiro_19")]
    end
	self.radius = self:GetAbility():GetSpecialValueFor( "path_radius" )
    self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()
	self.delayed = true
	self.targets = {}
	local start_range = 12
	self.direction = Vector( kv.x, kv.y, 0 )
	self.startpoint = self.parent:GetOrigin() + self.direction + start_range
	self.endpoint = self.startpoint + self.direction * self.range
	self.damageTable = 
    {
		attacker = self.caster,
		damage = damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}
	self:StartIntervalThink( self.delay )
	self:PlayEffects1()
end

function modifier_jakiro_ice_path_custom_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_jakiro_ice_path_custom_thinker:OnIntervalThink()
	if self.delayed then
		self.delayed = false
		self:SetDuration( self.duration, false )
		self:StartIntervalThink( 0.03 )
		local step = 0
		while step < self.range do
			local loc = self.startpoint + self.direction * step
			AddFOWViewer( self.caster:GetTeamNumber(), loc, self.radius, self.duration, false)
			step = step + self.radius
		end
		return
	end
	local enemies = FindUnitsInLine( self.caster:GetTeamNumber(), self.startpoint, self.endpoint, nil, self.radius, self.abilityTargetTeam, self.abilityTargetType, self.abilityTargetFlags)
	for _,enemy in pairs(enemies) do
		if not self.targets[enemy] then
			self.targets[enemy] = true
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
			local duration = math.min(self.stun_duration, self:GetRemainingTime())
			enemy:AddNewModifier( self.caster, self:GetAbility(), "modifier_jakiro_ice_path_custom", { duration = duration * (1-enemy:GetStatusResistance()) } )
		end
        if self:GetCaster():HasModifier("modifier_jakiro_19") then
            enemy:AddNewModifier( self.caster, self:GetAbility(), "modifier_jakiro_ice_path_custom_heal_reduce", { duration = 0.5 } )
        end
	end
end

function modifier_jakiro_ice_path_custom_thinker:PlayEffects1()
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_jakiro/jakiro_ice_path.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( particle, 0, self.startpoint )
	ParticleManager:SetParticleControl( particle, 1, self.endpoint )
	ParticleManager:SetParticleControl( particle, 2, Vector( self.duration + self.delay, 0, 0 ) )
    ParticleManager:SetParticleControl( particle, 3, Vector( self.radius, 0, 0 ) )
    ParticleManager:SetParticleControl( particle, 6, Vector( 1, 1, 1 ) )
    self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("Hero_Jakiro.IcePath.Cast")
    self:GetParent():EmitSound("Hero_Jakiro.IcePath")
end

modifier_jakiro_ice_path_custom = class({})

function modifier_jakiro_ice_path_custom:CheckState()
	return
    {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_jakiro_ice_path_custom:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_icepath_debuff.vpcf"
end

function modifier_jakiro_ice_path_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_jakiro_ice_path_custom_magic_immune = class({})
function modifier_jakiro_ice_path_custom_magic_immune:IsPurgable() return false end
function modifier_jakiro_ice_path_custom_magic_immune:GetTexture() return "jakiro_21" end

function modifier_jakiro_ice_path_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_jakiro_ice_path_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_jakiro_ice_path_custom_magic_immune:CheckState()
    return 
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true
    }
end

function modifier_jakiro_ice_path_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_jakiro_ice_path_custom_magic_immune:StatusEffectPriority()
    return 99999
end

function modifier_jakiro_ice_path_custom_magic_immune:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end

function modifier_jakiro_ice_path_custom_magic_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_jakiro_ice_path_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end

modifier_jakiro_ice_path_custom_handler = class({})
function modifier_jakiro_ice_path_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_jakiro_13") end
function modifier_jakiro_ice_path_custom_handler:GetTexture() return "jakiro_13" end
function modifier_jakiro_ice_path_custom_handler:IsPurgable() return false end
function modifier_jakiro_ice_path_custom_handler:IsPurgeException() return false end
function modifier_jakiro_ice_path_custom_handler:RemoveOnDeath() return false end
function modifier_jakiro_ice_path_custom_handler:DeclareFunctions()
    return
    {
         
    }
end
function modifier_jakiro_ice_path_custom_handler:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not self:GetCaster():HasModifier("modifier_jakiro_13") then return end
    if self:GetCaster():HasModifier("modifier_jakiro_2") then return end
    self:IncrementStackCount()
    if self:GetStackCount() >= self:GetAbility().modifier_jakiro_13_attack_counter[self:GetCaster():GetTalentLevel("modifier_jakiro_13")] then
        self:GetAbility():CreateTargetAoePath(params.target)
        self:SetStackCount(0)
    end
end

modifier_jakiro_ice_path_custom_thinker_target = class({})
function modifier_jakiro_ice_path_custom_thinker_target:IsPurgable() return false end

function modifier_jakiro_ice_path_custom_thinker_target:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_jakiro_15") then
        damage = damage + (self:GetCaster():GetIntellect(true) / 100 * self:GetAbility().modifier_jakiro_15)
    end
	self.duration = self:GetAbility().modifier_jakiro_13_duration
	self.radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_jakiro_13_radius)
    self.stun_duration = self:GetAbility().modifier_jakiro_13_duration
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.targets = {}
	self.damageTable = 
    {
		attacker = self.caster,
		damage = damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(),
	}
	self:StartIntervalThink( 0.03 )
	self:PlayEffects1()
    self:SetDuration( self.duration, false )
end

function modifier_jakiro_ice_path_custom_thinker_target:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_jakiro_ice_path_custom_thinker_target:OnIntervalThink()
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, 0, 0, false )
	for _,enemy in pairs(enemies) do
		if not self.targets[enemy] then
			self.targets[enemy] = true
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
			local duration = self.stun_duration
			enemy:AddNewModifier( self.caster, self:GetAbility(), "modifier_jakiro_ice_path_custom", { duration = duration * (1-enemy:GetStatusResistance()) } )
		end
	end
end

function modifier_jakiro_ice_path_custom_thinker_target:PlayEffects1()
	local particle = ParticleManager:CreateParticle( "particles/jakiro_custom/jakiro_ice_path_aoe.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( particle, 2, Vector( self.radius, 0, self.duration ) )
    ParticleManager:SetParticleControl( particle, 3, Vector( self.radius, 0, 0) )
    self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("Hero_Jakiro.IcePath.Cast")
    self:GetParent():EmitSound("Hero_Jakiro.IcePath")
end

modifier_jakiro_ice_path_custom_heal_reduce = class({})
function modifier_jakiro_ice_path_custom_heal_reduce:GetTexture() return "jakiro_19" end
function modifier_jakiro_ice_path_custom_heal_reduce:DeclareFunctions()
    return
    {
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    }
end

function modifier_jakiro_ice_path_custom_heal_reduce:GetModifierPropertyRestorationAmplification()
    if self:GetCaster():HasModifier("modifier_jakiro_19") then
	    return self:GetAbility().modifier_jakiro_19_debuff[self:GetCaster():GetTalentLevel("modifier_jakiro_19")]
    end
end