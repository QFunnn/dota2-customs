--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ember_spirit_fire_remnant_custom", "abilities/ember_spirit_fire_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ember_spirit_fire_remnant_custom_thinker", "abilities/ember_spirit_fire_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ember_spirit_activate_fire_remnant_custom_blast_timer", "abilities/ember_spirit_fire_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ember_spirit_fire_remnant_custom_timer", "abilities/ember_spirit_fire_remnant_custom", LUA_MODIFIER_MOTION_NONE)

ember_spirit_fire_remnant_custom = class({})

function ember_spirit_fire_remnant_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_fire_remnant_trail.vpcf", context )
    PrecacheResource( "particle", "particles/ember_spirit/legendary_aoe.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf", context )
end

function ember_spirit_fire_remnant_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:GetCaster():StartGesture(ACT_DOTA_TELEPORT)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ember_spirit_fire_remnant_custom", {x = point.x, y = point.y, z = point.z})
end
    
function ember_spirit_fire_remnant_custom:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    self:GetCaster():RemoveModifierByName("modifier_ember_spirit_fire_remnant_custom")
    self:GetCaster():FadeGesture(ACT_DOTA_TELEPORT)
end

function ember_spirit_fire_remnant_custom:Explosion(point, is_legendary)
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    local tTargets = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    for n, hTarget in pairs(tTargets) do
        local damage = self:GetSpecialValueFor("damage")
        if not hTarget:IsHero() then
            damage = damage * 2
        end
        ApplyDamage({victim = hTarget, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    end
    caster:EmitSound("Hero_EmberSpirit.FireRemnant.Explode")
end 

function ember_spirit_fire_remnant_custom:Cast(name, target)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local speed_multiplier = self:GetSpecialValueFor("speed_multiplier")
    local StartPosition = caster:GetAbsOrigin()
    local TargetPosition = self:GetCursorPosition()
    if target ~= nil then 
        TargetPosition = target
    end
    local vDirection = TargetPosition - StartPosition
    vDirection.z = 0
    if vDirection:Length2D() == 0 then vDirection = caster:GetForwardVector() end
    local remnant_unit = CreateUnitByName("npc_dota_ember_spirit_remnant", StartPosition, false, caster, caster, caster:GetTeamNumber())
    remnant_unit:SetDayTimeVisionRange(700)
    remnant_unit:SetNightTimeVisionRange(700)
    remnant_unit:AddNewModifier(caster, self, "modifier_ember_spirit_fire_remnant_custom_thinker", {})
    remnant_unit.mod = true
    remnant_unit.mod = caster:AddNewModifier(caster, self, "modifier_ember_spirit_fire_remnant_custom_timer", { duration = duration, thinker_index = remnant_unit:entindex() })
    local remnant_speed = caster:GetMoveSpeedModifier(caster:GetBaseMoveSpeed(), false) * speed_multiplier * 0.01
    local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_fire_remnant_trail.vpcf", PATTACH_CUSTOMORIGIN, remnant_unit)
    ParticleManager:SetParticleControlEnt(iParticleID, 0, caster, PATTACH_CUSTOMORIGIN, nil, caster:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(iParticleID, 0, StartPosition)
    ParticleManager:SetParticleControl(iParticleID, 1, vDirection:Normalized() * remnant_speed)
    ParticleManager:SetParticleShouldCheckFoW(iParticleID, false)
    remnant_unit.iParticleID = iParticleID
    remnant_unit.vVelocity = vDirection:Normalized() * remnant_speed
    local tInfo = 
    {
        Ability = self,
        Source = caster,
        vSpawnOrigin = StartPosition,
        vVelocity = remnant_unit.vVelocity,
        fDistance = vDirection:Length2D(),
        ExtraData = 
        {
            thinker_index = remnant_unit:entindex(),
        },
    }
    ProjectileManager:CreateLinearProjectile(tInfo)
    caster:EmitSound("Hero_EmberSpirit.FireRemnant.Cast")
    local activate_remnant = caster:FindAbilityByName("ember_spirit_activate_fire_remnant_custom")
    if activate_remnant then
        local tRemnants = activate_remnant.tRemnants or {}
        table.insert(tRemnants, remnant_unit)
        activate_remnant.tRemnants = tRemnants
    end
    remnant_unit:SetAbsOrigin(TargetPosition)
    remnant_unit:AddNewModifier(caster, self, "modifier_ember_spirit_activate_fire_remnant_custom_blast_timer", {duration = (StartPosition - TargetPosition):Length2D()/remnant_speed})
end
    
modifier_ember_spirit_fire_remnant_custom = class({})
function modifier_ember_spirit_fire_remnant_custom:IsHidden() return true end
function modifier_ember_spirit_fire_remnant_custom:IsPurgable() return false end
function modifier_ember_spirit_fire_remnant_custom:OnCreated(table)
    if not IsServer() then return end
    self.count = 5
    self:SetStackCount(self.count)
    self.interval = 1.5 / self.count
    self.radius = 600
    self.center = Vector(table.x, table.y, table.z)
    self.vec = RandomVector(self.radius*0.7)
    self.line_position = self.center + self.vec
    self.qangle_rotation_rate = 360 / (self.count - 1)
    local cast_pfx = ParticleManager:CreateParticle("particles/ember_spirit/legendary_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(cast_pfx, 0, self.center)
    ParticleManager:SetParticleControl(cast_pfx, 1, Vector(self.radius/2, 1, 1))
    ParticleManager:ReleaseParticleIndex(cast_pfx)
    self:OnIntervalThink()
    self:StartIntervalThink(self.interval)
end

function modifier_ember_spirit_fire_remnant_custom:OnIntervalThink()
    if not IsServer() then return end
    local pos = self.line_position
    if self:GetStackCount() == self.count then 
        pos = self.center
    end
    self:GetAbility():Cast(pos)
    self:DecrementStackCount() 
    if self:GetStackCount() <= 0 then 
        self:Destroy()
        self:GetParent():Stop()
    end 
    self.line_position = RotatePosition(self.center, QAngle(0, self.qangle_rotation_rate, 0), self.line_position)
end



modifier_ember_spirit_fire_remnant_custom_thinker = class({})
function modifier_ember_spirit_fire_remnant_custom_thinker:IsDebuff() return false end
function modifier_ember_spirit_fire_remnant_custom_thinker:IsHidden() return false end
function modifier_ember_spirit_fire_remnant_custom_thinker:IsPurgable() return false end
function modifier_ember_spirit_fire_remnant_custom_thinker:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.ability = self:GetAbility()
	end
end
function modifier_ember_spirit_fire_remnant_custom_thinker:CheckState()
	if IsServer() then
		local state = 
        {
			[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
			[MODIFIER_STATE_MAGIC_IMMUNE] = true,
			[MODIFIER_STATE_ROOTED] = true,
			[MODIFIER_STATE_UNSELECTABLE] = true,
			[MODIFIER_STATE_FORCED_FLYING_VISION] = true
		}
		return state
	end
end
function modifier_ember_spirit_fire_remnant_custom_thinker:OnDestroy()
    if not IsServer() then return end
    local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(iParticleID, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleFoWProperties(iParticleID, 0, -1, self:GetAbility():GetSpecialValueFor("radius"))
    ParticleManager:ReleaseParticleIndex(iParticleID)
    self:GetParent():RemoveSelf()
end

modifier_ember_spirit_activate_fire_remnant_custom_blast_timer = class({})
function modifier_ember_spirit_activate_fire_remnant_custom_blast_timer:IsHidden() return true end
function modifier_ember_spirit_activate_fire_remnant_custom_blast_timer:IsPurgable() return false end
function modifier_ember_spirit_activate_fire_remnant_custom_blast_timer:OnDestroy()
    if not IsServer() then return end
    if self:GetParent().mod == nil then return end
    self:GetAbility():Explosion(self:GetParent():GetAbsOrigin(), true)
    self:GetParent().mod:Destroy()
    self:GetParent():Destroy()
end

modifier_ember_spirit_fire_remnant_custom_timer = class({})
function modifier_ember_spirit_fire_remnant_custom_timer:IsHidden()		return false end
function modifier_ember_spirit_fire_remnant_custom_timer:IsPurgable()		return false end
function modifier_ember_spirit_fire_remnant_custom_timer:RemoveOnDeath()	return false end
function modifier_ember_spirit_fire_remnant_custom_timer:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_ember_spirit_fire_remnant_custom_timer:OnCreated(params)
    if not IsServer() then return end
    self.RemoveForDuel = true
    self.hThinker = EntIndexToHScript(params.thinker_index)
    if self.hThinker and (self.hThinker:IsNull() or not self.hThinker:IsAlive()) then
        self:Destroy()
    end
end
function modifier_ember_spirit_fire_remnant_custom_timer:OnDestroy()
    if not IsServer() then return end
    local caster = self:GetParent()
    if self.hThinker and not self.hThinker:IsNull() and self.hThinker:IsAlive() then
        self.hThinker:RemoveModifierByName("modifier_ember_spirit_fire_remnant_custom_remnant")
    end
end