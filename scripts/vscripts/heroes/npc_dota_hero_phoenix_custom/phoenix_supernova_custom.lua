--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_supernova_custom_buff", "heroes/npc_dota_hero_phoenix_custom/phoenix_supernova_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_supernova_custom_egg_thinker", "heroes/npc_dota_hero_phoenix_custom/phoenix_supernova_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_supernova_custom_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_supernova_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_supernova_custom_death", "heroes/npc_dota_hero_phoenix_custom/phoenix_supernova_custom", LUA_MODIFIER_MOTION_NONE)

phoenix_supernova_custom = class({})
phoenix_supernova_custom.modifier_phoenix_5 = {1,2,3}
phoenix_supernova_custom.modifier_phoenix_5_attack = 1
phoenix_supernova_custom.modifier_phoenix_5_attack_max_health = 2500
phoenix_supernova_custom.modifier_phoenix_7 = -60

function phoenix_supernova_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_phoenix_7") then
        bonus = self.modifier_phoenix_7
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function phoenix_supernova_custom:OnSpellStart()
	if not IsServer() then return end
    local egg_duration = self:GetSpecialValueFor("egg_duration")
    local modifier_phoenix_icarus_dive_custom_dash_dummy = self:GetCaster():FindModifierByName("modifier_phoenix_icarus_dive_custom_dash_dummy")
    if modifier_phoenix_icarus_dive_custom_dash_dummy then
        modifier_phoenix_icarus_dive_custom_dash_dummy:Destroy()
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phoenix_supernova_custom_buff", {duration = egg_duration})
    local point = self:GetCaster():GetAbsOrigin()
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, 64, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
        local knockback = 
        {
            should_stun = false,
            knockback_duration = 0.01,
            duration = 0.01,
            knockback_distance = 64,
            knockback_height = 0,
            center_x = point.x,
            center_y = point.y,
            center_z = point.z
        }
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_knockback", knockback)
    end
end

modifier_phoenix_supernova_custom_buff = class({})
function modifier_phoenix_supernova_custom_buff:IsPurgable() return false end
function modifier_phoenix_supernova_custom_buff:IsPurgeException() return false end

function modifier_phoenix_supernova_custom_buff:OnCreated()
    if not IsServer() then return end
    self:GetParent():AddNoDraw()
    local point = self:GetParent():GetAbsOrigin()
    local egg = CreateUnitByName("npc_dota_phoenix_sun", point, false, nil, nil, self:GetCaster():GetTeamNumber())
    egg:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    egg:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
    egg:SetAbsOrigin(point)
	egg:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phoenix_supernova_custom_egg_thinker", {duration = self:GetDuration()})
    if self:GetCaster():HasModifier("modifier_phoenix_7") then
        for i=0, 8 do
            local ability = self:GetCaster():GetAbilityByIndex(i)
            if ability and ability:GetName() ~= "phoenix_sun_ray_custom" and ability:GetName() ~= "phoenix_sun_ray_toggle_move_custom" and ability:GetName() ~= "phoenix_sun_ray_stop_custom" then
                ability:SetActivated(false)
            end
        end
    else
        local modifier_phoenix_sun_ray_custom_caster_dummy = self:GetCaster():FindModifierByName("modifier_phoenix_sun_ray_custom_caster_dummy")
        if modifier_phoenix_sun_ray_custom_caster_dummy then
            modifier_phoenix_sun_ray_custom_caster_dummy:Destroy()
        end
        for i=0, 8 do
            local ability = self:GetCaster():GetAbilityByIndex(i)
            if ability then
                ability:SetActivated(false)
            end
        end
    end
    for i=0, self:GetCaster():GetAbilityCount() - 1 do
        local ability = self:GetCaster():GetAbilityByIndex(i)
        if ability then
            if ability:GetAbilityType() ~= 1 then
                ability:EndCooldown()
            end
        end
    end
    self:GetCaster():Purge(false, true, false, true, true)
end

function modifier_phoenix_supernova_custom_buff:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_phoenix_supernova_custom_buff:CheckState()
	return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
    }
end

function modifier_phoenix_supernova_custom_buff:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_phoenix_supernova_custom_buff:GetAbsoluteNoDamageMagical() return 1 end
function modifier_phoenix_supernova_custom_buff:GetAbsoluteNoDamagePure() return 1 end

function modifier_phoenix_supernova_custom_buff:OnDestroy()
	if not IsServer() then return end
    self:GetParent():RemoveNoDraw()
	self:GetCaster():StartGesture(ACT_DOTA_INTRO)
    for i=0, 8 do
        local ability = self:GetCaster():GetAbilityByIndex(i)
        if ability then
            ability:SetActivated(true)
        end
    end
end

modifier_phoenix_supernova_custom_egg_thinker = class({})
function modifier_phoenix_supernova_custom_egg_thinker:IsPurgable() return false end
function modifier_phoenix_supernova_custom_egg_thinker:IsPurgeException() return false end
function modifier_phoenix_supernova_custom_egg_thinker:IsAura() return true end
function modifier_phoenix_supernova_custom_egg_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_phoenix_supernova_custom_egg_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_phoenix_supernova_custom_egg_thinker:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("aura_radius") end
function modifier_phoenix_supernova_custom_egg_thinker:GetModifierAura() return "modifier_phoenix_supernova_custom_debuff" end
function modifier_phoenix_supernova_custom_egg_thinker:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
         
        MODIFIER_PROPERTY_HEALTHBAR_PIPS,
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_phoenix_supernova_custom_egg_thinker:GetOverrideAnimation() return ACT_DOTA_IDLE end
function modifier_phoenix_supernova_custom_egg_thinker:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_phoenix_supernova_custom_egg_thinker:GetAbsoluteNoDamageMagical() return 1 end
function modifier_phoenix_supernova_custom_egg_thinker:GetAbsoluteNoDamagePure() return 1 end
function modifier_phoenix_supernova_custom_egg_thinker:GetModifierHealthBarPips(data) return self.max_hero_attacks end 

function modifier_phoenix_supernova_custom_egg_thinker:CheckState()
    return
    {
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
end

function modifier_phoenix_supernova_custom_egg_thinker:OnCreated()
    self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
    self.damage_per_sec = self:GetAbility():GetSpecialValueFor("damage_per_sec")
    self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
    self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
    self.max_hero_attacks = self:GetAbility():GetSpecialValueFor("max_hero_attacks")
    if self:GetCaster():HasModifier("modifier_phoenix_5") then
        self.max_hero_attacks = self.max_hero_attacks + (self:GetAbility().modifier_phoenix_5[self:GetCaster():GetTalentLevel("modifier_phoenix_5")]) + (math.floor(self:GetCaster():GetMaxHealth() / self:GetAbility().modifier_phoenix_5_attack_max_health) * self:GetAbility().modifier_phoenix_5_attack)
    end
	if not IsServer() then return end
    self:GetParent():SetBaseMaxHealth(self.max_hero_attacks)
    self:GetParent():SetMaxHealth(self.max_hero_attacks)
    self:GetParent():SetHealth(self.max_hero_attacks)
    local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
	self:AddParticle( pfx, false, false, -1, false, false )
	StartSoundEvent( "Hero_Phoenix.SuperNova.Begin", self:GetParent())
	StartSoundEvent( "Hero_Phoenix.SuperNova.Cast", self:GetParent())
	GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 500, false)
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.aura_radius, 1, false)
	self:StartIntervalThink(self.tick_interval)
end

function modifier_phoenix_supernova_custom_egg_thinker:OnIntervalThink()
	if not IsServer() then return end
    if not self:GetParent():IsAlive() then
        self:StartIntervalThink(-1)
        return
    end
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.aura_radius, math.min(1, self:GetRemainingTime()), false)
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.aura_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )
	for _, enemy in pairs(enemies) do
		ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = self.damage_per_sec * self.tick_interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = ability})
	end
end

function modifier_phoenix_supernova_custom_egg_thinker:OnDestroy()
    if not IsServer() then return end
    if self:GetCaster():IsAlive() and self:GetRemainingTime() <= 0 then
		StartSoundEvent( "Hero_Phoenix.SuperNova.Explode", self:GetParent())
		local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin() )
		ParticleManager:SetParticleControl(pfx, 1, Vector(1.5,1.5,1.5) )
		ParticleManager:SetParticleControl(pfx, 3, self:GetParent():GetAbsOrigin() )
		ParticleManager:ReleaseParticleIndex(pfx)
		self:GetCaster():SetHealth( self:GetCaster():GetMaxHealth() )
        self:GetCaster():SetMana( self:GetCaster():GetMaxMana() )
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.aura_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false )
		for _, enemy in pairs(enemies) do
            enemy:AddNewModifier(caster, ability, "modifier_stunned", {duration = self.stun_duration * (1 - enemy:GetStatusResistance())} )
		end
    end
    UTIL_Remove(self:GetParent())
end

function modifier_phoenix_supernova_custom_egg_thinker:OnDeath( params )
	if not IsServer() then return end
	local killer = params.attacker
	if self:GetParent() ~= params.unit then return end
	self:GetParent():AddNoDraw()
	StopSoundEvent("Hero_Phoenix.SuperNova.Begin", self:GetParent())
	StopSoundEvent( "Hero_Phoenix.SuperNova.Cast", self:GetParent())
	StartSoundEventFromPosition( "Hero_Phoenix.SuperNova.Death", self:GetParent():GetAbsOrigin())
    if self:GetCaster():IsAlive() then
        self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_phoenix_supernova_custom_death", {duration = 1})
        self:GetCaster():Kill(self, killer)
        self:GetCaster():SetAbsOrigin(self:GetParent():GetAbsOrigin() + Vector(0,0,-1000))
    end
    local pfxName = "particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf"
    local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf", PATTACH_WORLDORIGIN, nil )
    local attach_point = self:GetCaster():ScriptLookupAttachment( "attach_hitloc" )
    ParticleManager:SetParticleControl( pfx, 0, self:GetCaster():GetAttachmentOrigin(attach_point) )
    ParticleManager:SetParticleControl( pfx, 1, self:GetCaster():GetAttachmentOrigin(attach_point) )
    ParticleManager:SetParticleControl( pfx, 3, self:GetCaster():GetAttachmentOrigin(attach_point) )
    ParticleManager:ReleaseParticleIndex(pfx)
    local mod = self
    Timers:CreateTimer(FrameTime(), function()
        mod:Destroy()
    end)
end

function modifier_phoenix_supernova_custom_egg_thinker:OnAttackLanded( params )
	if not IsServer() then return end
	if self:GetParent() ~= params.target then return end
    if not params.attacker:IsHero() then return end
    if params.attacker:IsIllusion() then return end
	local attach_point = self:GetParent():ScriptLookupAttachment( "attach_hitloc" )
    local origin = self:GetParent():GetAttachmentOrigin(attach_point)
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_hit.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true )
	ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true )
	ParticleManager:ReleaseParticleIndex(particle)
    local new_health = self:GetParent():GetHealth() - 1
    if new_health > 0 then
        self:GetParent():SetHealth(new_health)
    else
        self:GetParent():Kill(nil, params.attacker)
    end
end

modifier_phoenix_supernova_custom_debuff = class({})
function modifier_phoenix_supernova_custom_debuff:IsHidden() return false end
function modifier_phoenix_supernova_custom_debuff:IsPurgable() return false end
function modifier_phoenix_supernova_custom_debuff:GetHeroEffectName() return "particles/units/heroes/hero_phoenix/phoenix_supernova_radiance.vpcf" end
function modifier_phoenix_supernova_custom_debuff:OnCreated()
    if not IsServer() then return end
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_supernova_radiance_streak_light.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( self.particle, 8, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
    self:AddParticle(self.particle, false, false, -1, false, false)
end


modifier_phoenix_supernova_custom_death = class({})
function modifier_phoenix_supernova_custom_death:IsHidden() return true end
function modifier_phoenix_supernova_custom_death:IsPurgable() return false end
function modifier_phoenix_supernova_custom_death:IsPurgeException() return false end
function modifier_phoenix_supernova_custom_death:RemoveOnDeath() return false end