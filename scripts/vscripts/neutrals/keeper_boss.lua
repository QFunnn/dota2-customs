--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_keeper_mana", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_keeper_mana_aura", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

boss_keeper_mana = class({})

function boss_keeper_mana:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_mana_leak.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_mana_leak_cast.vpcf", context )
    PrecacheResource( "particle", "particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/keeper_of_the_light_illuminate_charge_spirit_form.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_keeper_spirit_form.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/kotl_illuminate.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_impact.vpcf", context )
end

function boss_keeper_mana:GetIntrinsicModifierName()
	return "modifier_boss_keeper_mana"
end

modifier_boss_keeper_mana = class({})

function modifier_boss_keeper_mana:IsHidden() return true end
function modifier_boss_keeper_mana:IsPurgable() return false end
function modifier_boss_keeper_mana:IsPurgeException() return false end
function modifier_boss_keeper_mana:IsAuraActiveOnDeath() return false end

function modifier_boss_keeper_mana:IsAura()
    return true
end

function modifier_boss_keeper_mana:GetModifierAura()
    return "modifier_boss_keeper_mana_aura"
end

function modifier_boss_keeper_mana:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_boss_keeper_mana:GetAuraDuration()
    return 0
end

function modifier_boss_keeper_mana:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_boss_keeper_mana:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_boss_keeper_mana:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_boss_keeper_mana_aura = class({})

function modifier_boss_keeper_mana_aura:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_mana_leak.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_boss_keeper_mana_aura:OnIntervalThink()
	if not IsServer() then return end
	local mana_reduce = (self:GetAbility():GetSpecialValueFor("mana") * self:GetAbility():GetSpecialValueFor("interval")) / 100 * self:GetParent():GetMaxMana()
	self:GetParent():Script_ReduceMana(mana_reduce, self:GetAbility())

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_mana_leak_cast.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( particle )
end

LinkLuaModifier("modifier_boss_keeper_light", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_keeper_light_debuff", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_keeper_light_knockback", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_BOTH)

boss_keeper_light = class({})

function boss_keeper_light:GetIntrinsicModifierName()
	return "modifier_boss_keeper_light"
end

modifier_boss_keeper_light = class({})

function modifier_boss_keeper_light:IsHidden() return true end
function modifier_boss_keeper_light:IsPurgable() return false end
function modifier_boss_keeper_light:IsPurgeException() return false end

function modifier_boss_keeper_light:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.delay = self:GetAbility():GetSpecialValueFor("delay")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self:StartIntervalThink(0)
end

function modifier_boss_keeper_light:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():AbilityIsCooldown("boss_keeper_horse") then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartBlinding()
		self:GetCaster():StartCooldownAbil( "boss_keeper_horse", 6 )
		self:GetAbility():StartCooldown(12)
	end
end

function modifier_boss_keeper_light:StartBlinding()
	if not IsServer() then return end
	self:GetParent():EmitSound("keeper_of_the_light_keep_illuminate_02")
	self.particle = ParticleManager:CreateParticle("particles/abilities_ranger_finder_check_ultimate_calldown.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl( self.particle, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.particle, 1, Vector( self.radius, 0, -500 ) )
	ParticleManager:SetParticleControl( self.particle, 2, Vector( self.delay, 0, 0 ) )
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
	local particle = self.particle

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 0.3)

	local parent = self:GetParent()

	Timers:CreateTimer(self.delay, function()
		if not parent:IsAlive() then
			ParticleManager:DestroyParticle(particle, true)
			return
		end
		
		if self.particle then
			ParticleManager:DestroyParticle(self.particle, true)
			ParticleManager:ReleaseParticleIndex(self.particle)
		end

		self:GetParent():EmitSound("Hero_KeeperOfTheLight.BlindingLight")

		self:GetCaster():StartCooldownAbil( "boss_keeper_horse", 6 )
		self:GetAbility():StartCooldown(12)

		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(particle, 2, Vector(self.radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle)

		local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)	
        for i = #enemies, 1, -1 do
            if enemies[i] and enemies[i]:GetUnitName() == "npc_woda_wisp_death" then
                table.remove(enemies, i)
            end
        end
		for _, enemy in pairs(enemies) do
			ApplyDamage({ victim = enemy, damage = self.damage / 100 * enemy:GetMaxHealth(), damage_type	= DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetParent(), ability = self:GetAbility()})
			local normalized = enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin()
			normalized.z = 0
			normalized = normalized:Normalized()
			enemy:FaceTowards(self:GetParent():GetAbsOrigin() * (-1))
			enemy:SetForwardVector(normalized)
			enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_keeper_light_debuff", {duration = self.duration * (1 - enemy:GetStatusResistance())})
			enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_keeper_light_knockback", {x = self:GetParent():GetAbsOrigin().x, y = self:GetParent():GetAbsOrigin().y, z = self:GetParent():GetAbsOrigin().z, duration = 0.6 * (1 - enemy:GetStatusResistance())})
		end

		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_boss_keeper_light_debuff = class({})

function modifier_boss_keeper_light_debuff:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_debuff.vpcf"
end

function modifier_boss_keeper_light_debuff:OnCreated()
	self.ability	= self:GetAbility()
	self.miss_rate	= self.ability:GetSpecialValueFor("miss_perc")
end

function modifier_boss_keeper_light_debuff:DeclareFunctions()
	local decFuncs = 
	{
		MODIFIER_PROPERTY_MISS_PERCENTAGE
    }
    return decFuncs
end

function modifier_boss_keeper_light_debuff:GetModifierMiss_Percentage()
    return self.miss_rate
end

modifier_boss_keeper_light_knockback = class({})

function modifier_boss_keeper_light_knockback:IsHidden() return true end

function modifier_boss_keeper_light_knockback:OnCreated(params)
	if not IsServer() then return end
	self.ability				= self:GetAbility()
	self.parent					= self:GetParent()
	self.knockback_duration		= 0.6
	self.knockback_distance		= 600
	self.knockback_speed		= self.knockback_distance / self.knockback_duration
	self.position	= Vector(params.x, params.y, params.z)
	self.parent:StartGesture(ACT_DOTA_FLAIL)
	if self:ApplyHorizontalMotionController() == false then 
		self:Destroy()
		return
	end
end

function modifier_boss_keeper_light_knockback:UpdateHorizontalMotion( me, dt )
	if not IsServer() then return end
	local distance = (me:GetOrigin() - self.position):Normalized()
	me:SetOrigin( me:GetOrigin() + distance * self.knockback_speed * dt )
end

function modifier_boss_keeper_light_knockback:OnDestroy()
	if not IsServer() then return end
	GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), 150, true )
	self.parent:FadeGesture(ACT_DOTA_FLAIL)
	self.parent:RemoveHorizontalMotionController( self )
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), false)
end

function modifier_boss_keeper_light_knockback:DeclareFunctions()
	local decFuncs = 
	{
		MODIFIER_PROPERTY_DISABLE_TURNING
    }
    return decFuncs
end

function modifier_boss_keeper_light_knockback:GetModifierDisableTurning()
	return 1
end

LinkLuaModifier("modifier_boss_keeper_horse", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_keeper_horse_thinker", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_keeper_horse_wave", "neutrals/keeper_boss", LUA_MODIFIER_MOTION_NONE)

boss_keeper_horse = class({})

function boss_keeper_horse:GetIntrinsicModifierName()
	return "modifier_boss_keeper_horse"
end

modifier_boss_keeper_horse = class({})

function modifier_boss_keeper_horse:IsHidden() return true end
function modifier_boss_keeper_horse:IsPurgable() return false end
function modifier_boss_keeper_horse:IsPurgeException() return false end

function modifier_boss_keeper_horse:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self.delay = self:GetAbility():GetSpecialValueFor("delay")
	self:StartIntervalThink(0)
end

function modifier_boss_keeper_horse:OnIntervalThink()
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() and (self:GetParent():GetAggroTarget() ~= nil or self:GetParent().hTarget ~= nil) then
		if not self:GetParent():IsAlive() then return end
		self:StartHorse()
		self:GetCaster():StartCooldownAbil( "boss_keeper_light", 6 )
		self:GetAbility():StartCooldown(12)
	end
end

function modifier_boss_keeper_horse:StartHorse()
	if not IsServer() then return end

	if RollPercentage(5) then
		self:GetParent():EmitSound("keeper_of_the_light_keep_illuminate_06")
	elseif RollPercentage(50) then
		if RollPercentage(50) then
			self:GetParent():EmitSound("keeper_of_the_light_keep_illuminate_05")
		else
			self:GetParent():EmitSound("keeper_of_the_light_keep_illuminate_07")
		end
	end

	local random_point = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(0, 300))
	local start_point = RotatePosition(random_point, QAngle(0,-135,0), random_point + self:GetCaster():GetForwardVector() * 700)
	local end_point = RotatePosition(random_point, QAngle(0,45,0), random_point + self:GetCaster():GetForwardVector() * 700)

	if RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,45,0), random_point + self:GetCaster():GetForwardVector() * 700)
		end_point = RotatePosition(random_point, QAngle(0,-135,0), random_point + self:GetCaster():GetForwardVector() * 700)
	elseif RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,-180,0), random_point + self:GetCaster():GetForwardVector() * 700)
		end_point = RotatePosition(random_point, QAngle(0,0,0), random_point + self:GetCaster():GetForwardVector() * 700)
	elseif RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,0,0), random_point + self:GetCaster():GetForwardVector() * 700)
		end_point = RotatePosition(random_point, QAngle(0,-180,0), random_point + self:GetCaster():GetForwardVector() * 700)
	elseif RollPercentage(25) then
		start_point = RotatePosition(random_point, QAngle(0,-90,0), random_point + self:GetCaster():GetForwardVector() * 700)
		end_point = RotatePosition(random_point, QAngle(0,90,0), random_point + self:GetCaster():GetForwardVector() * 700)
	end

	local forward_vector = (end_point - start_point)
	forward_vector.z = 0
	forward_vector = forward_vector:Normalized()

	local thinker = CreateUnitByName("boss_1_effect", start_point, false, nil, nil, DOTA_TEAM_NEUTRALS)
	if thinker then
		local mod = thinker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_keeper_horse_thinker", {duration = self.delay})
		thinker:SetForwardVector(forward_vector)
		thinker.dir = forward_vector
		thinker:StartGesture(ACT_DOTA_CAST_ABILITY_7)

		local particle = ParticleManager:CreateParticle("particles/keeper_of_the_light_illuminate_charge_spirit_form.vpcf", PATTACH_ABSORIGIN_FOLLOW, thinker)
		ParticleManager:SetParticleControl(particle, 0, start_point)
		ParticleManager:SetParticleControl(particle, 1, start_point)
		ParticleManager:SetParticleControl(particle, 2, start_point)
		ParticleManager:SetParticleControlEnt(particle, 3, thinker, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", thinker:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(particle, 5, start_point)

		mod:AddParticle(particle, false, false, -1, false, false)
	end
end

modifier_boss_keeper_horse_thinker = class({})

function modifier_boss_keeper_horse_thinker:IsPurgable() return false end

function modifier_boss_keeper_horse_thinker:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_spirit_form_ambient.vpcf"
end

function modifier_boss_keeper_horse_thinker:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_form.vpcf"
end

function modifier_boss_keeper_horse_thinker:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_ROOTED] = true,
	}
end

function modifier_boss_keeper_horse_thinker:OnCreated()
	if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
	self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Charge")
	self:StartIntervalThink(0.01)
end

function modifier_boss_keeper_horse_thinker:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent().dir then
		self:GetParent():SetForwardVector(self:GetParent().dir)
	end
end

function modifier_boss_keeper_horse_thinker:OnDestroy()
	if not IsServer() then return end
	local distance = self:GetAbility():GetSpecialValueFor("distance")
    local speed = self:GetAbility():GetSpecialValueFor("speed")
    local vDirection = self:GetParent().dir
    self:GetParent():StopSound("Hero_KeeperOfTheLight.Illuminate.Charge")
    self:GetParent():EmitSound("Hero_KeeperOfTheLight.Illuminate.Discharge")

    CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_boss_keeper_horse_wave", 
    {
        duration        = distance / speed,
        direction_x     = vDirection.x,
        direction_y     = vDirection.y,
    }, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    UTIL_Remove(self:GetParent())
end

modifier_boss_keeper_horse_wave = class({})

function modifier_boss_keeper_horse_wave:OnCreated( params )
    if not IsServer() then return end
    if self:GetAbility():GetLevel() <= 0 then
        self:GetAbility():SetLevel(1)
    end
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.radius = self.ability:GetSpecialValueFor("radius")
    self.speed = self.ability:GetSpecialValueFor("speed")
    self.total_damage = self.ability:GetSpecialValueFor("damage")
    self.duration           = params.duration
    self.direction          = Vector(params.direction_x, params.direction_y, 0)
    self.direction_angle    = math.deg(math.atan2(self.direction.x, self.direction.y))

    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/kotl_illuminate.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(self.particle, 1, self.direction * self.speed)
    ParticleManager:SetParticleControl(self.particle, 3, self.parent:GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
    self.hit_targets = {}
    self:OnIntervalThink()
    self:StartIntervalThink(FrameTime())
end

function modifier_boss_keeper_horse_wave:OnIntervalThink()
    if not IsServer() then return end
    local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for i = #targets, 1, -1 do
        if targets[i] and targets[i]:GetUnitName() == "npc_woda_wisp_death" then
            table.remove(targets, i)
        end
    end
    local damage = self.total_damage
    local valid_targets =   {}

    for _, target in pairs(targets) do
        local target_pos    = target:GetAbsOrigin()
        local target_angle  = math.deg(math.atan2((target_pos.x - self.parent:GetAbsOrigin().x), target_pos.y - self.parent:GetAbsOrigin().y))
        local difference = math.abs(self.direction_angle - target_angle)
        if difference <= 90 or difference >= 270 then
            table.insert(valid_targets, target)
        end
    end

    for _, target in pairs(valid_targets) do
        local hit_already = false
        for _, hit_target in pairs(self.hit_targets) do
            if hit_target == target then
                hit_already = true
                break
            end
        end
        if not hit_already then

            local damageTable = 
            {
                victim          = target,
                damage          = damage / 100 * target:GetMaxHealth(),
                damage_type     = DAMAGE_TYPE_PURE,
                damage_flags    = DOTA_DAMAGE_FLAG_NONE,
                attacker        = self.caster,
                ability         = self.ability
            }
            
            ApplyDamage(damageTable)

            target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target")
            target:EmitSound("Hero_KeeperOfTheLight.Illuminate.Target.Secondary")

            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_illuminate_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
            ParticleManager:SetParticleControl(particle, 1, target:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)

            table.insert(self.hit_targets, target)
        end
    end

    self.parent:SetAbsOrigin(self.parent:GetAbsOrigin() + (self.direction * self.speed * FrameTime()))
end

function modifier_boss_keeper_horse_wave:OnDestroy()
    if not IsServer() then return end
    self.parent:RemoveSelf()
end

function UpdateCooldown(caster, ability)
	local boss_keeper_light = caster:FindAbilityByName("boss_keeper_light")
	if boss_keeper_light and boss_keeper_light ~= ability then
		local cooldown_time = boss_keeper_light:GetCooldownTimeRemaining() + 3
		boss_keeper_light:StartCooldown(cooldown_time)
	end

	local boss_keeper_horse = caster:FindAbilityByName("boss_keeper_horse")
	if boss_keeper_horse and boss_keeper_horse ~= ability then
		local cooldown_time = boss_keeper_horse:GetCooldownTimeRemaining() + 3
		boss_keeper_horse:StartCooldown(cooldown_time)
	end
end



		