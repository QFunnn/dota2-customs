--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_boss_egg", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_boss_egg_active", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_boss_egg_debuff", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE)

phoenix_boss_egg = class({})

function phoenix_boss_egg:GetIntrinsicModifierName()
	return "modifier_phoenix_boss_egg"
end

modifier_phoenix_boss_egg = class({})

function modifier_phoenix_boss_egg:IsHidden() return true end
function modifier_phoenix_boss_egg:IsPurgable() return false end
function modifier_phoenix_boss_egg:IsPurgeException() return false end

function modifier_phoenix_boss_egg:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self:StartIntervalThink(0)
end

function modifier_phoenix_boss_egg:OnIntervalThink()
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartEgg()
		self:GetCaster():StartCooldownAbil( "phoenix_boss_beam", 13 )
		self:GetCaster():StartCooldownAbil( "phoenix_boss_wave", 6 )
		self:GetAbility():StartCooldown(21)
	end
end

function modifier_phoenix_boss_egg:StartEgg()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_boss_egg_active", {duration = self.duration+0.5})
end

modifier_phoenix_boss_egg_active = class({})
function modifier_phoenix_boss_egg_active:IsPurgable() return false end
function modifier_phoenix_boss_egg_active:IsPurgeException() return false end
function modifier_phoenix_boss_egg_active:IsHidden() return true end

function modifier_phoenix_boss_egg_active:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MODEL_CHANGE
	}
end

function modifier_phoenix_boss_egg_active:GetModifierModelChange()
	return "models/items/phoenix/ultimate/phoenix_crimson_dawn_supernova/phoenix_crimson_dawn_supernova.vmdl"
end
		
function modifier_phoenix_boss_egg_active:CheckState()
	return
	{
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_phoenix_boss_egg_active:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.init = false
	self:StartIntervalThink(0.5)
	self.particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl( self.particle, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 1, Vector( self:GetAbility():GetSpecialValueFor("radius"), 0, -500 ) )
	ParticleManager:SetParticleControl( self.particle, 2, Vector( 3.5, 0, 0 ) )
	self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_phoenix_boss_egg_active:OnIntervalThink()
	if not IsServer() then return end
	if not self.init then
		self.init = true
		local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt( pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
		self:AddParticle(pfx, false, false, -1, false, false)
		StartSoundEvent( "Hero_Phoenix.SuperNova.Begin", self:GetParent())
		StartSoundEvent( "Hero_Phoenix.SuperNova.Cast", self:GetParent())
	end
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_boss_egg_debuff", {duration = 0.6})
	end
end

function modifier_phoenix_boss_egg_active:OnDestroy()
	if not IsServer() then return end
	StopSoundEvent("Hero_Phoenix.SuperNova.Begin", self:GetParent())
	StopSoundEvent( "Hero_Phoenix.SuperNova.Cast", self:GetParent())
	if self:GetParent():IsAlive() then
		StartSoundEvent( "Hero_Phoenix.SuperNova.Explode", self:GetParent())
		local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( pfx, 0, self:GetParent():GetAbsOrigin() )
		ParticleManager:SetParticleControl( pfx, 1, Vector(1.5,1.5,1.5) )
		ParticleManager:SetParticleControl( pfx, 3, self:GetParent():GetAbsOrigin() )
		ParticleManager:ReleaseParticleIndex(pfx)
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
		for i = #enemies, 1, -1 do
            if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(enemies, i)
            end
        end
        for _, enemy in pairs(enemies) do
			enemy:RemoveModifierByName("modifier_phoenix_boss_egg_debuff")
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self:GetAbility():GetSpecialValueFor("stun_duration")})
		end
	end
end

modifier_phoenix_boss_egg_debuff = class({})

function modifier_phoenix_boss_egg_debuff:IsHidden() return true end
function modifier_phoenix_boss_egg_debuff:IsPurgable() return false end
function modifier_phoenix_boss_egg_debuff:IsPurgeException() return false end
function modifier_phoenix_boss_egg_debuff:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.speed = self:GetAbility():GetSpecialValueFor("speed_pull")
	self:StartIntervalThink(FrameTime())
end

function modifier_phoenix_boss_egg_debuff:OnIntervalThink()
	if not IsServer() then return end
	local dir = self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()
	dir.z = 0
	self.direction = dir:Normalized()
	if not self:GetParent():IsCurrentlyVerticalMotionControlled() and not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():HasModifier("modifier_slark_pounce_arc") and not self:GetParent():HasModifier("modifier_slark_pounce_custom") then
        local point = self:GetParent():GetAbsOrigin() + self.direction * (self.speed * FrameTime())
		point = GetGroundPosition(point, self:GetParent())
		if GridNav:CanFindPath( self:GetParent():GetAbsOrigin(), point ) then
			self:GetParent():SetAbsOrigin(point)
		else
			FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
		end
	end
end

function modifier_phoenix_boss_egg_debuff:OnDestroy()
	if not IsServer() then return end
	if not self:GetParent():IsCurrentlyVerticalMotionControlled() and not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():HasModifier("modifier_slark_pounce_arc") and not self:GetParent():HasModifier("modifier_slark_pounce_custom") then
	    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    end
end

function modifier_phoenix_boss_egg_debuff:GetEffectName()
	return "particles/units/heroes/hero_phoenix/phoenix_icarus_dive_burn_debuff.vpcf"
end

function modifier_phoenix_boss_egg_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

LinkLuaModifier("modifier_phoenix_boss_wave", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_boss_wave_debuff", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_boss_wave_passive", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE)

phoenix_boss_wave = class({})

function phoenix_boss_wave:Precache(context)
    PrecacheResource( "particle", 'particles/doom_fueling_hell.vpcf', context )
end

function phoenix_boss_wave:GetIntrinsicModifierName()
	return "modifier_phoenix_boss_wave_passive"
end

modifier_phoenix_boss_wave_passive = class({})

function modifier_phoenix_boss_wave_passive:IsHidden() return true end
function modifier_phoenix_boss_wave_passive:IsPurgable() return false end
function modifier_phoenix_boss_wave_passive:IsPurgeException() return false end

function modifier_phoenix_boss_wave_passive:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self:StartIntervalThink(0)
end

function modifier_phoenix_boss_wave_passive:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("phoenix_boss_egg") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartWave()
		self:GetCaster():StartCooldownAbil( "phoenix_boss_beam", 4 )
		self:GetAbility():StartCooldown(21)
	end
end

function modifier_phoenix_boss_wave_passive:StartWave()
	if not IsServer() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/doom_fueling_hell.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1000, 1000, 1000 ) )
	ParticleManager:SetParticleControl( effect_cast, 15, Vector( 255, 90, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 16, Vector( 1, 1, 1 ) )

	local pulse = self:GetCaster():AddNewModifier(
		self:GetCaster(), 
		self:GetAbility(), 
		"modifier_phoenix_boss_wave", 
		{
			end_radius = self:GetAbility():GetSpecialValueFor("radius_start"),
			speed = 1000,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		} 
	)

	self:GetCaster():EmitSound("Hero_Phoenix.IcarusDive.Cast")

	pulse:SetCallback()
	
	Timers:CreateTimer(self:GetAbility():GetSpecialValueFor("radius_start")/1000,function()
		ParticleManager:DestroyParticle(effect_cast, false)
		ParticleManager:ReleaseParticleIndex(effect_cast)
    end)
end

modifier_phoenix_boss_wave = class({})

function modifier_phoenix_boss_wave:IsHidden()
	return true
end

function modifier_phoenix_boss_wave:IsDebuff()
	return false
end

function modifier_phoenix_boss_wave:IsStunDebuff()
	return false
end

function modifier_phoenix_boss_wave:IsPurgable()
	return false
end

function modifier_phoenix_boss_wave:RemoveOnDeath()
	return false
end

function modifier_phoenix_boss_wave:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_phoenix_boss_wave:OnCreated( kv )
	if not IsServer() then return end
	self.origin = self:GetParent():GetAbsOrigin()
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0
	self.outward = self.end_radius>=self.start_radius
	if not self.outward then
		self.speed = -self.speed
	end

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.IsCircle = kv.IsCircle or 1

	self.targets = {}
end

function modifier_phoenix_boss_wave:OnDestroy()
	if self.EndCallback then
		self.EndCallback()
	end
	if not IsServer() then return end
	if self:GetParent():GetClassname()=="npc_dota_thinker" then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_phoenix_boss_wave:SetCallback( callback )
	self.Callback = callback
	self:StartIntervalThink( 0.03 )
	self:OnIntervalThink()
end

function modifier_phoenix_boss_wave:SetEndCallback( callback )
	self.EndCallback = callback
end

function modifier_phoenix_boss_wave:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if not self.outward and radius<self.end_radius then
		self:Destroy()
		return
	elseif self.outward and radius>self.end_radius then
		self:Destroy()
		return
	end

	local targets = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self.origin, nil, radius, self.target_team, self.target_type, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
    for i = #targets, 1, -1 do
        if targets[i] and targets[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(targets, i)
        end
    end
	local fear_duration = 0
	for _,target in pairs(targets) do
		if not self.targets[target] then
			if ((not self.IsCircle) or (target:GetOrigin()-self.origin):Length2D()>(radius-self.width))  then
				self.targets[target] = true
				target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_boss_wave_debuff", {})
			end
		end
	end
end

modifier_phoenix_boss_wave_debuff = class({})

function modifier_phoenix_boss_wave_debuff:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage_perc = self:GetAbility():GetSpecialValueFor("damage_perc")
	self:SetStackCount(self:GetAbility():GetSpecialValueFor("duration"))
	self.effect_cast_2 = ParticleManager:CreateParticle( "particles/phoenix_counter_buff_strength_counter_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast_2, 2, Vector( math.floor(self:GetStackCount()), 0, 0 ) )
	ParticleManager:SetParticleControlEnt(self.effect_cast_2, 3, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, nil , self:GetParent():GetAbsOrigin(), true )
	self:AddParticle(self.effect_cast_2,false, false, -1, false, false)
	self:StartIntervalThink(1)
end

function modifier_phoenix_boss_wave_debuff:OnIntervalThink()
	if not IsServer() then return end
	self:DecrementStackCount()
	if self.effect_cast_2 then
		ParticleManager:SetParticleControl( self.effect_cast_2, 2, Vector( math.floor(self:GetStackCount()), 0, 0 ) )
	end
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end

function modifier_phoenix_boss_wave_debuff:OnDestroy()
	if not IsServer() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Ability.LightStrikeArray", self:GetCaster() )
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
	for _, enemy in pairs(enemies) do
		local damage = enemy:GetMaxHealth() / 100 * self.damage_perc
		ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_PURE})
	end
end

LinkLuaModifier("modifier_phoenix_boss_beam", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_phoenix_boss_beam_passive", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_phoenix_boss_beam_passive_thinker", "neutrals/phoenix_boss", LUA_MODIFIER_MOTION_NONE )

phoenix_boss_beam = class({})

function phoenix_boss_beam:GetIntrinsicModifierName()
    return "modifier_phoenix_boss_beam_passive"
end

modifier_phoenix_boss_beam_passive = class({})

function modifier_phoenix_boss_beam_passive:IsHidden() return true end
function modifier_phoenix_boss_beam_passive:IsPurgable() return false end
function modifier_phoenix_boss_beam_passive:IsPurgeException() return false end

function modifier_phoenix_boss_beam_passive:OnCreated()
    if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
    self.duration = self:GetAbility():GetSpecialValueFor("duration")
    self:StartIntervalThink(0)
end

function modifier_phoenix_boss_beam_passive:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():AbilityIsCooldown("phoenix_boss_wave") then return end
    if not self:GetCaster():AbilityIsCooldown("phoenix_boss_egg") then return end
    if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
        if not self:GetParent():IsAlive() then return end
        self:StartBeam()
        self:GetAbility():StartCooldown(21)
    end
end

function modifier_phoenix_boss_beam_passive:StartBeam()
    if not IsServer() then return end
    local origin = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 400
    local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_FARTHEST, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
    for count = #enemies, 1, -1 do
        if enemies[count] and not enemies[count]:IsAlive() and not enemies[count]:IsRealHero() then
            table.remove(units, count)
        end
    end
    if #enemies > 0 then
        origin = enemies[1]:GetAbsOrigin()
    end
    local target = nil
    if enemies[1] then
        target = enemies[1]:entindex()
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_boss_beam", {duration = self:GetAbility():GetSpecialValueFor("duration"), x = origin.x, y = origin.y, z = origin.z, target = target })
end

modifier_phoenix_boss_beam = class({})

function modifier_phoenix_boss_beam:IsPurgable() return false end
function modifier_phoenix_boss_beam:GetTexture() return "phoenix_boss_beam" end

function modifier_phoenix_boss_beam:OnCreated(params)
    if not IsServer() then return end
    self.point = Vector(params.x, params.y, params.z)
    self.dummy = CreateUnitByName( "npc_dota_companion", self.point, false, nil, nil, self:GetCaster():GetTeamNumber() )
    self.dummy:SetAbsOrigin(self.point)
    self.dummy:AddNewModifier(self.dummy, self:GetAbility(), "modifier_phoenix_boss_beam_passive_thinker", {duration = self:GetAbility():GetSpecialValueFor("duration")})
    local target = params.target
    if target ~= nil then
        self.target = EntIndexToHScript(target)
    end
    self.speed = self:GetCaster():GetBaseMoveSpeed()
    self.damage_perc = self:GetAbility():GetSpecialValueFor("damage_perc")
    EmitSoundOn( "Hero_Phoenix.SunRay.Cast", self:GetCaster() )
	EmitSoundOn( "Hero_Phoenix.SunRay.Loop", self:GetCaster() )

    self.nBeamFXIndex = ParticleManager:CreateParticle( "particles/econ/items/phoenix/phoenix_solar_forge/phoenix_sunray_solar_forge.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 1, self.dummy, PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self.dummy:GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.nBeamFXIndex, 9, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )

    self:StartIntervalThink(FrameTime())
end

modifier_phoenix_boss_beam_passive_thinker = class({})

function modifier_phoenix_boss_beam_passive_thinker:IsHidden() return true end
function modifier_phoenix_boss_beam_passive_thinker:IsPurgable() return false end
function modifier_phoenix_boss_beam_passive_thinker:RemoveOnDeath() return false end

function modifier_phoenix_boss_beam_passive_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_phoenix_boss_beam_passive_thinker:OnDestroy()
    if not IsServer() then return end
    UTIL_Remove(self:GetParent())
end

function modifier_phoenix_boss_beam:OnIntervalThink()
    if not IsServer() then return end
    if self.dummy and self.dummy:IsNull() then return end
    if self.target ~= nil then
        self.point = self.target:GetAbsOrigin()
    end
    local direction = self.point - self.dummy:GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()
    local new_point = self.dummy:GetAbsOrigin() + direction * (self.speed * FrameTime())
    local dir_min_c = new_point - self:GetCaster():GetAbsOrigin()
    local distance = dir_min_c:Length2D()
    dir_min_c.z = 0
    local direction_min = dir_min_c:Normalized()
    new_point = GetGroundPosition(new_point, nil)
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self.dummy:GetAbsOrigin(), 100, FrameTime(), false)
    self.dummy:SetAbsOrigin(new_point)


    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), new_point, nil, 100, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for i = #enemies, 1, -1 do
        if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(enemies, i)
        end
    end
    for _,enemy in pairs( enemies ) do
        local damage = enemy:GetMaxHealth() / 100 * self.damage_perc
        local damageInfo = 
        {
            victim = enemy,
            attacker = self:GetCaster(),
            damage = damage * FrameTime(),
            damage_type = DAMAGE_TYPE_PURE,
            ability = self:GetAbility(),
        }
        ApplyDamage( damageInfo )
    end

    local direction2 = self.dummy:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()
    direction2.z = 0
    direction2 = direction2:Normalized()
    self:GetCaster():SetForwardVector(direction2)
end

function modifier_phoenix_boss_beam:OnDestroy()
    if not IsServer() then return end
    if self.dummy and not self.dummy:IsNull() then
        self.dummy:RemoveModifierByName("modifier_phoenix_boss_beam_passive_thinker")
    end
    if self.nBeamFXIndex then
        ParticleManager:DestroyParticle(self.nBeamFXIndex, true)
    end
    StopSoundOn( "Hero_Phoenix.SunRay.Cast", self:GetCaster() )
	StopSoundOn( "Hero_Phoenix.SunRay.Loop", self:GetCaster() )
	EmitSoundOn( "Hero_Phoenix.SunRay.Stop", self:GetCaster() )
end

function modifier_phoenix_boss_beam:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING,
    }
end

function modifier_phoenix_boss_beam:CheckState()
    local state = 
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
    return state
end

function modifier_phoenix_boss_beam:GetOverrideAnimation()
    return ACT_DOTA_OVERRIDE_ABILITY_3
end

function modifier_phoenix_boss_beam:GetModifierDisableTurning()
    return 1
end