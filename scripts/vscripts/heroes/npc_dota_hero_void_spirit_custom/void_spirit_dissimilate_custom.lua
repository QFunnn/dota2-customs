--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_void_dissimilate", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_dissimilate_custom", LUA_MODIFIER_MOTION_NONE)

void_spirit_dissimilate_custom = class({})

void_spirit_dissimilate_custom.modifier_void_spirit_17 = 100
void_spirit_dissimilate_custom.modifier_void_spirit_18 = {4,6,8}
void_spirit_dissimilate_custom.modifier_void_spirit_20 = {0,0.5,1}
void_spirit_dissimilate_custom.modifier_void_spirit_6 = {1,3}
void_spirit_dissimilate_custom.modifier_void_spirit_6_duration = 4

function void_spirit_dissimilate_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_2.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf", context )
    PrecacheResource( "particle", "particles/void_custom/oracle_fortune_purge_root_pnt.vpcf", context )
end

function void_spirit_dissimilate_custom:OnSpellStart()
    local caster = self:GetCaster()
    ProjectileManager:ProjectileDodge(caster)
    caster:Stop()
    local duration = self:GetSpecialValueFor( "phase_duration" )
    caster:AddNewModifier( caster, self, "modifier_custom_void_dissimilate", { duration = duration } )
    self:GetCaster():EmitSound("Hero_VoidSpirit.Dissimilate.Cast")
end

modifier_custom_void_dissimilate = class({})
function modifier_custom_void_dissimilate:IsHidden() return false end
function modifier_custom_void_dissimilate:IsDebuff() return false end
function modifier_custom_void_dissimilate:IsPurgable() return false end

function modifier_custom_void_dissimilate:OnCreated( kv )
    self.portals = self:GetAbility():GetSpecialValueFor( "portals_per_ring" )
    self.angle = self:GetAbility():GetSpecialValueFor( "angle_per_ring_portal" )
    self.radius = self:GetAbility():GetSpecialValueFor( "damage_radius" )
    self.distance = self:GetAbility():GetSpecialValueFor( "first_ring_distance_offset" )
    self.target_radius = self:GetAbility():GetSpecialValueFor( "destination_fx_radius" )
    self.RemoveForDuel = true
    if not IsServer() then return end
    local origin = self:GetParent():GetOrigin()
    local direction = self:GetParent():GetForwardVector()
    local zero = Vector(0,0,0)
    self.selected = 1
    self.points = {}
    self.effects = {}
    table.insert( self.points, origin )
    table.insert( self.effects, self:PlayEffects1( origin, true ) )
    for i=1,self.portals do
        local new_direction = RotatePosition( zero, QAngle( 0, self.angle*i, 0 ), direction )
        local point = GetGroundPosition( origin + new_direction * self.distance, nil )
        table.insert( self.points, point )
        table.insert( self.effects, self:PlayEffects1( point, false ) )
    end
    if self:GetCaster():HasModifier("modifier_void_spirit_20") then
        for i=1,self.portals do
            local new_direction = RotatePosition( zero, QAngle( 0, self.angle*i, 0 ), direction )
            local point = GetGroundPosition( origin + new_direction * self.distance * 2, nil )
            table.insert( self.points, point )
            table.insert( self.effects, self:PlayEffects1( point, false ) )
        end
    end
    self.NoDraw = true
    self:GetParent():AddNoDraw()
    if self:GetParent():HasModifier("modifier_void_spirit_17") then
        self:GetParent():Purge(false, true, false, false, false)
        self:GetParent():HealWithParams(self:GetAbility().modifier_void_spirit_17, self:GetAbility(), false, true, self:GetCaster(), false)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), self:GetAbility().modifier_void_spirit_17, nil)
    end
end

function modifier_custom_void_dissimilate:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveNoDraw()
    for _,effect in pairs(self.effects) do 
        ParticleManager:DestroyParticle(effect, true)
        ParticleManager:ReleaseParticleIndex(effect)
    end
    local point = self.points[self.selected]
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, self.radius,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,0,0,false)
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_void_spirit_18") then
        damage = damage + self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_void_spirit_18[self:GetCaster():GetTalentLevel("modifier_void_spirit_18")]
    end
    local old_pos = self:GetCaster():GetAbsOrigin()
    FindClearSpaceForUnit( self:GetCaster(), point, true )
    for _,enemy in pairs(enemies) do
        local deal_damage = damage
        ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = deal_damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility()})
        if self:GetCaster():HasModifier("modifier_void_spirit_20") then
            local modifier_rooted = enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_rooted", {duration = self:GetAbility().modifier_void_spirit_20[self:GetCaster():GetTalentLevel("modifier_void_spirit_20")] * (1-enemy:GetStatusResistance())})
            if modifier_rooted then
                local pfx = ParticleManager:CreateParticle("particles/void_custom/oracle_fortune_purge_root_pnt.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                modifier_rooted:AddParticle(pfx, false, false, -1, false, false)
            end
        end
    end
    self:PlayEffects2( point, #enemies )
    local void_spirit_aether_remnant_custom = self:GetCaster():FindAbilityByName("void_spirit_aether_remnant_custom")
    if void_spirit_aether_remnant_custom and self:GetCaster():HasModifier("modifier_void_spirit_6") and void_spirit_aether_remnant_custom:GetLevel() > 0 and self.selected ~= 1 then
        local points_checked = {}
        for id, point_checked in pairs(self.points) do
            if id ~= 1 and id ~= self.selected then
                table.insert(points_checked, point_checked)
            end
        end
        table.sort(points_checked, function(a, b)
            local distance_a = (self:GetCaster():GetAbsOrigin() - a):Length2D()
            local distance_b = (self:GetCaster():GetAbsOrigin() - b):Length2D()
            return distance_a > distance_b
        end)
        local random_points = {}
        for i=1, self:GetAbility().modifier_void_spirit_6[self:GetCaster():GetTalentLevel("modifier_void_spirit_6")] do
            table.insert(random_points, table.remove(points_checked, 1))
        end
        table.sort(random_points, function(a, b)
            local distance_a = (self:GetCaster():GetAbsOrigin() - a):Length2D()
            local distance_b = (self:GetCaster():GetAbsOrigin() - b):Length2D()
            return distance_a > distance_b
        end)
        local max_spirits = 3
        for _, new_point in pairs(random_points) do
            if max_spirits <= 0 then break end
            max_spirits = max_spirits - 1
            local center = self.points[1]
            local direction = center - new_point
            direction.z = 0
            direction = direction:Normalized()
            CreateModifierThinker( self:GetCaster(), void_spirit_aether_remnant_custom, "modifier_custom_void_remnant_thinker", {
                dir_x = direction.x, 
                dir_y = direction.y, 
                dir_z = direction.z,
                new_point_x = new_point.x,
                new_point_y = new_point.y,
                new_point_z = new_point.z,
                new_duration = self:GetAbility().modifier_void_spirit_6_duration
        }, new_point, self:GetCaster():GetTeamNumber(), false)
        end
    end
end

function modifier_custom_void_dissimilate:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}
end

function modifier_custom_void_dissimilate:OnOrder( params )
	if params.unit~=self:GetParent() then return end
	if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		self:SetValidTarget( params.new_pos )
	elseif 
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		self:SetValidTarget( params.target:GetOrigin() )
	end
end

function modifier_custom_void_dissimilate:GetModifierMoveSpeed_Limit()
	return 0.1
end

function modifier_custom_void_dissimilate:CheckState()
	return
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	}
end

function modifier_custom_void_dissimilate:SetValidTarget( location )
	local max_dist = (location-self.points[1]):Length2D()
	local max_point = 1
	for i,point in ipairs(self.points) do
		local dist = (location-point):Length2D()
		if dist<max_dist then
			max_dist = dist
			max_point = i
		end
	end
	local old_select = self.selected
	self.selected = max_point
	self:ChangeEffects( old_select, self.selected )
end

function modifier_custom_void_dissimilate:PlayEffects1( point, main )
	local radius = self.radius + 25
    point = GetGroundPosition(point, nil)
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 1 ) )
	if main then
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 0, 0 ) )
	end
	self:AddParticle( effect_cast, false, false, -1, false, false )
	EmitSoundOnLocationWithCaster( point, "Hero_VoidSpirit.Dissimilate.Portals", self:GetCaster() )
	return effect_cast
end

function modifier_custom_void_dissimilate:ChangeEffects( old, new )
	ParticleManager:SetParticleControl( self.effects[old], 2, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl( self.effects[new], 2, Vector( 1, 0, 0 ) )
end

function modifier_custom_void_dissimilate:PlayEffects2( point, hit )
    point = GetGroundPosition(point, nil)
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.target_radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	local particle_exit = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( particle_exit )
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	self:GetParent():EmitSound("Hero_VoidSpirit.Dissimilate.TeleportIn")
	if hit > 0 then
		self:GetParent():EmitSound("Hero_VoidSpirit.Dissimilate.Stun")
	end
end