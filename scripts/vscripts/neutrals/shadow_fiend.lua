--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_shadow_fiend_passive_shadowraze", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_shadow_fiend_passive_shadowraze_thinker", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_shadow_fiend_passive_shadowraze_debuff", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)

boss_shadow_fiend_passive_shadowraze = class({})

function boss_shadow_fiend_passive_shadowraze:GetIntrinsicModifierName()
    return "modifier_boss_shadow_fiend_passive_shadowraze"
end

modifier_boss_shadow_fiend_passive_shadowraze = class({})
function modifier_boss_shadow_fiend_passive_shadowraze:IsHidden() return true end
function modifier_boss_shadow_fiend_passive_shadowraze:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_shadowraze:IsPurgeException() return false end
function modifier_boss_shadow_fiend_passive_shadowraze:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_trail_old.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end
function modifier_boss_shadow_fiend_passive_shadowraze:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetAbility():IsFullyCastable() then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetParent():GetHealthPercent() <= 0 then return end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, 0, false)
    for i = #units, 1, -1 do
        if units[i] and units[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(units, i)
        end
    end
    for _, unit in pairs(units) do
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_boss_shadow_fiend_passive_shadowraze_thinker", {duration = self:GetAbility():GetSpecialValueFor("delay")}, unit:GetAbsOrigin(), self:GetParent():GetTeamNumber(), false)
    end
    self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(-1))
end
function modifier_boss_shadow_fiend_passive_shadowraze:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

modifier_boss_shadow_fiend_passive_shadowraze_thinker = class({})
function modifier_boss_shadow_fiend_passive_shadowraze_thinker:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( particle, 1, Vector( self:GetAbility():GetSpecialValueFor("coil_radius"), 0, -self:GetAbility():GetSpecialValueFor("coil_radius") + 65 ) )
	ParticleManager:SetParticleControl( particle, 2, Vector( self:GetDuration(), 0, 0 ) )
    self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_boss_shadow_fiend_passive_shadowraze_thinker:OnDestroy()
    if not IsServer() then return end
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("coil_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for i = #units, 1, -1 do
        if units[i] and units[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(units, i)
        end
    end
    for _, unit in pairs(units) do
        local damage_percent = self:GetAbility():GetSpecialValueFor("damage_percent")
        local modifier_boss_shadow_fiend_passive_shadowraze_debuff = unit:FindModifierByName("modifier_boss_shadow_fiend_passive_shadowraze_debuff")
        if modifier_boss_shadow_fiend_passive_shadowraze_debuff then
            damage_percent = damage_percent * modifier_boss_shadow_fiend_passive_shadowraze_debuff:GetStackCount()
        end
        ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = unit:GetMaxHealth() / 100 * damage_percent, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()})
        unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_boss_shadow_fiend_passive_shadowraze_debuff", {duration = self:GetAbility():GetSpecialValueFor("debuff_duration")})
    end
    self:GetParent():EmitSound("Hero_Nevermore.Shadowraze")
    local particle_raze_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_raze_fx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_raze_fx, 1, Vector(self:GetAbility():GetSpecialValueFor("coil_radius"), 1, 1))
	ParticleManager:ReleaseParticleIndex(particle_raze_fx)
end

modifier_boss_shadow_fiend_passive_shadowraze_debuff = class({})
function modifier_boss_shadow_fiend_passive_shadowraze_debuff:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_shadowraze_debuff:OnCreated()
    if not IsServer() then return end
    self:IncrementStackCount()
end
function modifier_boss_shadow_fiend_passive_shadowraze_debuff:OnRefresh()
    if not IsServer() then return end
    self:IncrementStackCount()
end

LinkLuaModifier("modifier_boss_shadow_fiend_passive_dark_cyclone", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_shadow_fiend_passive_dark_cyclone_buff", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_BOTH)

boss_shadow_fiend_passive_dark_cyclone = class({})
function boss_shadow_fiend_passive_dark_cyclone:GetIntrinsicModifierName()
    return "modifier_boss_shadow_fiend_passive_dark_cyclone"
end

modifier_boss_shadow_fiend_passive_dark_cyclone = class({})
function modifier_boss_shadow_fiend_passive_dark_cyclone:IsHidden() return true end
function modifier_boss_shadow_fiend_passive_dark_cyclone:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_dark_cyclone:IsPurgeException() return false end
function modifier_boss_shadow_fiend_passive_dark_cyclone:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
	}
end
function modifier_boss_shadow_fiend_passive_dark_cyclone:OnCreated()
    if not IsServer() then return end
    self.activated = false
end

function modifier_boss_shadow_fiend_passive_dark_cyclone:Start()
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_boss_shadow_fiend_passive_dark_cyclone_buff") then return end
	local buff_duration	= self:GetAbility():GetSpecialValueFor("cyclone_duration")
	self:GetParent():Purge( false, true, false, true, true )
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_shadow_fiend_passive_dark_cyclone_buff", {duration = buff_duration})
end

modifier_boss_shadow_fiend_passive_dark_cyclone_buff = class({})
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:IsHidden() return false end
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:OnCreated(kv)
    if not IsServer() then return end
    self.angle = self:GetParent():GetAngles()
    self.cyc_pos = self:GetParent():GetAbsOrigin()
    self.pfx = ParticleManager:CreateParticle("particles/econ/events/ti6/cyclone_ti6.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
    self:GetParent():EmitSound("DOTA_Item.Cyclone.Activate")
    self:StartIntervalThink(FrameTime())
end
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
        [MODIFIER_STATE_STUNNED]            = true,
        [MODIFIER_STATE_ROOTED]             = true,
        [MODIFIER_STATE_DISARMED]           = true,
        [MODIFIER_STATE_FLYING]             = true,
        [MODIFIER_STATE_INVULNERABLE]             = true,
        [MODIFIER_STATE_NO_HEALTH_BAR]             = true,
    }
end
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:OnIntervalThink()
    self:HorizontalMotion(self:GetParent(), FrameTime())
end
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:HorizontalMotion(unit, time)
    if not IsServer() then return end
    local angle = self:GetParent():GetAngles()
    local new_angle = RotateOrientation(angle, QAngle(0,20,0))
    self:GetParent():SetAngles(angle.x, angle.y+20, angle.z)
    if self:GetElapsedTime() <= 0.3 then
        self.cyc_pos.z = self.cyc_pos.z + 25
        self:GetParent():SetAbsOrigin(self.cyc_pos)
    elseif self:GetDuration() - self:GetElapsedTime() < 0.3 then
        self.step = self.step or (self.cyc_pos.z - self:GetParent():GetAbsOrigin().z) / ((self:GetDuration() - self:GetElapsedTime()) / FrameTime())
        self.cyc_pos.z = self.cyc_pos.z - self.step
        self:GetParent():SetAbsOrigin(self.cyc_pos)
    end
end
function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:OnDestroy()
    StopSoundOn("DOTA_Item.Cyclone.Activate", self:GetParent())
    if not IsServer() then return end
    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, false)
        ParticleManager:ReleaseParticleIndex(self.pfx)
    end
    self:GetParent():FadeGesture(ACT_DOTA_FLAIL)
    self:GetParent():SetAbsOrigin(self:GetParent():GetAbsOrigin())
    ResolveNPCPositions(self:GetParent():GetAbsOrigin(), 128)
    self:GetParent():SetAngles(self.angle[1], self.angle[2], self.angle[3])
    if not self:GetAbility() then return end
    local modifier_boss_low_health = self:GetParent():FindModifierByName("modifier_boss_low_health")
    if modifier_boss_low_health then
        modifier_boss_low_health:AddStages(self:GetAbility():GetSpecialValueFor("stages"))
    end
end

function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end

function modifier_boss_shadow_fiend_passive_dark_cyclone_buff:GetOverrideAnimation( params )
    return ACT_DOTA_FLAIL
end

LinkLuaModifier("modifier_boss_shadow_fiend_passive_ultimate", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_shadow_fiend_passive_ultimate_cast", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_shadow_fiend_passive_ultimate_explosion", "neutrals/shadow_fiend", LUA_MODIFIER_MOTION_NONE)

boss_shadow_fiend_passive_ultimate = class({})

function boss_shadow_fiend_passive_ultimate:GetIntrinsicModifierName()
    return "modifier_boss_shadow_fiend_passive_ultimate"
end

function boss_shadow_fiend_passive_ultimate:OnProjectileHit_ExtraData(target, location, extra_data)
	if not target then return nil end
	local damage = self:GetSpecialValueFor("damage") / 100 * target:GetMaxHealth()
	local slow_duration = 1
	local max_duration = 1
	target:EmitSound("Hero_Nevermore.RequiemOfSouls.Damage")
	ApplyDamage({victim = target, damage = damage, damage_type = DAMAGE_TYPE_PURE, attacker = self:GetCaster(), ability = self})
    if not target:HasModifier("modifier_nevermore_requiem_fear") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_nevermore_requiem_fear", {duration  = slow_duration * (1 - target:GetStatusResistance())})
    else
        target:FindModifierByName("modifier_nevermore_requiem_fear"):SetDuration(math.min(target:FindModifierByName("modifier_nevermore_requiem_fear"):GetRemainingTime() + slow_duration, max_duration) * (1 - target:GetStatusResistance()), true)
    end
end

modifier_boss_shadow_fiend_passive_ultimate = class({})
function modifier_boss_shadow_fiend_passive_ultimate:IsHidden() return true end
function modifier_boss_shadow_fiend_passive_ultimate:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_ultimate:IsPurgeException() return false end
function modifier_boss_shadow_fiend_passive_ultimate:OnCreated()
    if not IsServer() then return end
    self.cast = false
    self.target = nil
    self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(-1))
    self:StartIntervalThink(0.1)
end
function modifier_boss_shadow_fiend_passive_ultimate:OnIntervalThink()
    if not IsServer() then return end
    if self.cast then
        local particle_start = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_start_nevermore.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle_start, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle_start)
        if self.target and not self.target:IsNull() then
            FindClearSpaceForUnit(self:GetParent(), self.target:GetAbsOrigin(), true)
        end
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_shadow_fiend_passive_ultimate_explosion", {duration = 1.7})
        self:GetCaster():EmitSound("DOTA_Item.Arcane_Blink.Activate")
        self:GetCaster():EmitSound("Blink_Layer.Arcane")
        local particle_end = ParticleManager:CreateParticle("particles/items3_fx/blink_arcane_end_nevermore.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
        ParticleManager:ReleaseParticleIndex(particle_end)
        self.cast = false
        self.target = nil
        self:StartIntervalThink(0.1)
    else
        if self:GetAbility():IsFullyCastable() then
            local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
            for i = #units, 1, -1 do
                if units[i] and units[i]:GetUnitName() == "npc_woda_wisp_death" then
                    table.remove(units, i)
                end
            end
            for _, unit in pairs(units) do
                if unit and unit:IsAlive() then
                    self.target = unit
                    break
                end
            end
            if self.target ~= nil then
                self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(-1))
                self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_shadow_fiend_passive_ultimate_cast", {duration = 3.1})
                self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.5)
                self.cast = true
                self:StartIntervalThink(1)
            end
        end
    end
end

modifier_boss_shadow_fiend_passive_ultimate_cast = class({})
function modifier_boss_shadow_fiend_passive_ultimate_cast:IsHidden() return true end
function modifier_boss_shadow_fiend_passive_ultimate_cast:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_ultimate_cast:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

modifier_boss_shadow_fiend_passive_ultimate_explosion = class({})
function modifier_boss_shadow_fiend_passive_ultimate_explosion:IsHidden() return true end
function modifier_boss_shadow_fiend_passive_ultimate_explosion:IsPurgable() return false end
function modifier_boss_shadow_fiend_passive_ultimate_explosion:OnCreated()
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_Nevermore.RequiemOfSoulsCast")
    self.wings_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_wings.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	self:GetCaster():StartGestureFadeWithSequenceSettings(ACT_DOTA_CAST_ABILITY_6)
end
function modifier_boss_shadow_fiend_passive_ultimate_explosion:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():StopSound("Hero_Nevermore.RequiemOfSoulsCast")
	if self.wings_particle then
		ParticleManager:DestroyParticle(self.wings_particle, true)
		ParticleManager:ReleaseParticleIndex(self.wings_particle)
	end
    self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_6)
    self:GetCaster():RemoveModifierByName("modifier_boss_shadow_fiend_passive_ultimate_cast")
    if not self:GetParent():IsAlive() then return end
    self:UseRequeiem()
end
function modifier_boss_shadow_fiend_passive_ultimate_explosion:UseRequeiem()
    local souls_per_line = 1
	local travel_distance = 1800
    self:GetCaster():EmitSound("Hero_Nevermore.RequiemOfSouls")
	local particle_caster_souls_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_a.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_caster_souls_fx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_caster_souls_fx, 1, Vector(lines, 0, 0))
	ParticleManager:SetParticleControl(particle_caster_souls_fx, 2, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_caster_souls_fx)
	local particle_caster_ground_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_caster_ground_fx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_caster_ground_fx, 1, Vector(lines, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle_caster_ground_fx)

	local stacks = 30
	local max_souls = 30
	local line_position = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * travel_distance
	if stacks >= 1 then
		self:CreateRequiemSoulLine(self:GetCaster(), self:GetAbility(), line_position)
	end
	local qangle_rotation_rate = 360 / stacks
	for i = 1, stacks - 1 do
		local qangle = QAngle(0, qangle_rotation_rate, 0)
		line_position = RotatePosition(self:GetCaster():GetAbsOrigin() , qangle, line_position)
		self:CreateRequiemSoulLine(self:GetCaster(), self:GetAbility(), line_position)
	end
end

function modifier_boss_shadow_fiend_passive_ultimate_explosion:CreateRequiemSoulLine(caster, ability, line_end_position, death_cast)
	local travel_distance = 1500
	local lines_starting_width = 125
	local lines_end_width = 350
	local lines_travel_speed = 700
	local max_distance_time = travel_distance / lines_travel_speed
	local velocity = (line_end_position - caster:GetAbsOrigin()):Normalized()  * lines_travel_speed 

	local projectile_info = 
	{
		Ability = ability,	
	   	vSpawnOrigin = caster:GetAbsOrigin() + (line_end_position - caster:GetAbsOrigin()):Normalized()*(105),
	   	fDistance = travel_distance,
	   	fStartRadius = lines_starting_width,
	   	fEndRadius = lines_end_width,
	   	Source = caster,
	   	bHasFrontalCone = false,
	   	bReplaceExisting = false,
        fExpireTime = GameRules:GetGameTime() + (max_distance_time+1),
	   	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	   	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	   	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	   	bDeleteOnHit = false,
	   	vVelocity = velocity,
	   	bProvidesVision = false,
	   	ExtraData = {scepter_line = false, death_cast = death_cast}
	}

	ProjectileManager:CreateLinearProjectile(projectile_info)

	local particle_lines_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_lines_fx, 0, caster:GetAbsOrigin() + (line_end_position - caster:GetAbsOrigin()):Normalized()*(105))
    ParticleManager:SetParticleControl(particle_lines_fx, 1, velocity)
	ParticleManager:SetParticleControl(particle_lines_fx, 2, Vector(0, max_distance_time, 0))
	ParticleManager:ReleaseParticleIndex(particle_lines_fx)

	local origin = caster:GetAbsOrigin()
end