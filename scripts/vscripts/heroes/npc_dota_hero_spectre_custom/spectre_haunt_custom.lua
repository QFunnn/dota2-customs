--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spectre_haunt_custom", "heroes/npc_dota_hero_spectre_custom/spectre_haunt_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_spectre_reality_custom", "heroes/npc_dota_hero_spectre_custom/spectre_haunt_custom", LUA_MODIFIER_MOTION_BOTH)

spectre_haunt_custom = class({})

spectre_haunt_custom.modifier_spectre_11 = {-30,-60,-90}

function spectre_haunt_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_spectre_11") then
		bonus = self.modifier_spectre_11[self:GetCaster():GetTalentLevel("modifier_spectre_11")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function spectre_haunt_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_haunt.vpcf", context )
end

function spectre_haunt_custom:OnUpgrade( level )
	if not IsServer() then return end
	local sub = self:GetCaster():FindAbilityByName( "spectre_reality_custom" )
	if sub then
		sub:SetLevel( 1 )
	end
end

function spectre_haunt_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor( "duration" )
	local outgoing = self:GetSpecialValueFor( "illusion_damage_outgoing" ) - 100
	local incoming = self:GetSpecialValueFor( "illusion_damage_incoming" ) - 100
	local distance = 70
    local radius = self:GetSpecialValueFor( "radius" )
	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST , false )
	if caster:HasModifier("modifier_spectre_11") then
        local creeps = FindUnitsInRadius( caster:GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST , false )
        if creeps and creeps[1] then
            table.insert(heroes, creeps[1])
        end
    end

	for count = #heroes, 1, -1 do
        if heroes[count] and (heroes[count]:GetUnitName() == "npc_woda_wisp_death" or not heroes[count]:IsAlive() or heroes[count]:IsIllusion()) then
            table.remove(heroes, count)
        end
    end

	self:GetCaster():EmitSound("Hero_Spectre.HauntCast")
    local illusions = CreateIllusions( caster, caster, { outgoing_damage = outgoing, incoming_damage = incoming, duration = duration }, #heroes, distance, false, true )
	for _, target in pairs( heroes ) do
        local illusion = illusions[_]
        illusion:SetControllableByPlayer( -1, false )
        FindClearSpaceForUnit( illusion, target:GetOrigin(), false )
        EmitSoundOn( "Hero_Spectre.Haunt", illusion )
        self:SetContextThink( DoUniqueString( "spectre_haunt_custom" ),function()
                illusion:AddNewModifier( caster, self, "modifier_spectre_haunt_custom", { duration = duration, target = target:entindex() })
        end, FrameTime()*2)
    end
end

spectre_reality_custom = class({})

function spectre_reality_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local haunts = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	local origin = caster:GetOrigin()
	local target = nil
	local mdistance = 99999
	for _,haunt in pairs(haunts) do
		if (haunt:HasModifier( "modifier_spectre_haunt_custom" ) or haunt:HasModifier( "modifier_spectre_shadow_step_custom" )) and haunt:GetPlayerOwner() == caster:GetPlayerOwner() then
			local distance = (haunt:GetOrigin()-point):Length2D()
			if distance < mdistance then
				target = haunt
				mdistance = distance
			end
		end
	end
	if not target then return end
	local pos = target:GetOrigin()
    local direction = (pos - origin)
    direction.z = 0
    direction = direction:Normalized()
	caster:SetForwardVector( direction )
    caster:AddNewModifier(caster, self, "modifier_spectre_reality_custom", {point_x = pos.x, point_y = pos.y, point_z = pos.z})
	EmitSoundOn("Hero_Spectre.ShadowStep.Reality", caster )
    local spectre_haunt_custom = self:GetCaster():FindAbilityByName( "spectre_haunt_custom" )
    caster.reality_cast = true
    Timers:CreateTimer(4, function()
        caster.reality_cast = nil
    end)
    if self:GetCaster():HasModifier("modifier_spectre_19") then
        local modifier_spectre_haunt_custom = target:FindModifierByName("modifier_spectre_haunt_custom")
        if not modifier_spectre_haunt_custom then
            modifier_spectre_haunt_custom = target:FindModifierByName("modifier_spectre_shadow_step_custom")
        end
        if modifier_spectre_haunt_custom then
            local target_enemy = modifier_spectre_haunt_custom.target
            local spectre_spectral_dagger_custom = self:GetCaster():FindAbilityByName("spectre_spectral_dagger_custom")
            if spectre_spectral_dagger_custom and spectre_spectral_dagger_custom:GetLevel() > 0 then
                spectre_spectral_dagger_custom:OnSpellStart(target_enemy)
            end
        end
    end
    target:Kill(self, self:GetCaster())
end

modifier_spectre_reality_custom = class({})
function modifier_spectre_reality_custom:IsHidden() return true end
function modifier_spectre_reality_custom:IsPurgable() return false end
function modifier_spectre_reality_custom:IsPurgeException() return false end
function modifier_spectre_reality_custom:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.point = Vector( params.point_x, params.point_y, params.point_z )

    -- If another motion controller is already active, do not keep the invulnerable modifier stuck forever.
    if self:ApplyHorizontalMotionController() == false then
        self:Destroy()
        return
    end

    local direction = (self.point - self:GetParent():GetOrigin())
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    local min_speed = self:GetAbility():GetSpecialValueFor("min_speed")
    local travel_time = self:GetAbility():GetSpecialValueFor("travel_time")
    self.direction = direction
    self.speed = math.max(distance / travel_time, min_speed)
    self.distance = distance
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_shadowstep_tracking.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self.point + self.direction * 75)
    ParticleManager:SetParticleControlEnt(particle, 7, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_spectre_reality_custom:UpdateHorizontalMotion(me, dt)
    if not IsServer() then return end
    local point = self:GetParent():GetAbsOrigin()
    point = point + self.direction * self.speed * dt
    self.distance = self.distance - (self.speed * dt)
    self:GetParent():SetAbsOrigin(point)
    if (self.distance <= 0) then
        self:Destroy()
    end
end

function modifier_spectre_reality_custom:OnHorizontalMotionInterrupted()
    if not IsServer() then return end

    self:Destroy()
end

function modifier_spectre_reality_custom:OnDestroy()
    if not IsServer() then return end

    local parent = self:GetParent()
    if parent and not parent:IsNull() then
        parent:RemoveHorizontalMotionController(self)

        if self.point then
            FindClearSpaceForUnit(parent, self.point, true)
        else
            FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
        end
    end
end

function modifier_spectre_reality_custom:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
    }
end

modifier_spectre_haunt_custom = class({})

function modifier_spectre_haunt_custom:IsHidden()
	return true
end

function modifier_spectre_haunt_custom:IsPurgable()
	return false
end

function modifier_spectre_haunt_custom:OnCreated( kv )
	if not IsServer() then return end
	self.target = EntIndexToHScript( kv.target )
	self.distance = 70
	self.disarm = true
	self:StartIntervalThink( FrameTime() )
end

function modifier_spectre_haunt_custom:OnDestroy()
	if not IsServer() then return end
	local haunts = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
	local found = false
	for _,haunt in pairs(haunts) do
		if haunt~=self:GetParent() and haunt:HasModifier( "modifier_spectre_haunt_custom" ) then
			found = true
			break
		end
	end
	if found then return end
end

function modifier_spectre_haunt_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
	return state
end

function modifier_spectre_haunt_custom:OnIntervalThink()
	self:FollowThink()
end

function modifier_spectre_haunt_custom:FollowThink()
	if not self.target:IsAlive() then
		self:GetParent():ForceKill( false )
		self:Destroy()
		return
	end
	local parent = self:GetParent()
	local origin = self.target:GetOrigin()
	local seen = self:GetCaster():CanEntityBeSeenByMyTeam( self.target )
	if not seen then
		if (parent:GetOrigin()-origin):Length2D()>self.distance/2 then
			parent:MoveToPosition( origin )
		end
	else
		if parent:GetAggroTarget()~=self.target then
			local order = {
				UnitIndex = parent:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = self.target:entindex(),
			}
			ExecuteOrderFromTable( order )
		end
	end
end