--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_auto_swarm_hidden", "heroes/npc_dota_hero_weaver_custom/weaver_auto_swarm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_auto_swarm", "heroes/npc_dota_hero_weaver_custom/weaver_auto_swarm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_auto_swarm_agility", "heroes/npc_dota_hero_weaver_custom/weaver_auto_swarm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_auto_swarm_attack", "heroes/npc_dota_hero_weaver_custom/weaver_auto_swarm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_auto_swarm_effect", "heroes/npc_dota_hero_weaver_custom/weaver_auto_swarm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_auto_swarm_armor_debuff", "heroes/npc_dota_hero_weaver_custom/weaver_auto_swarm", LUA_MODIFIER_MOTION_NONE)

weaver_auto_swarm = class({})

function weaver_auto_swarm:GetIntrinsicModifierName()
	return "modifier_weaver_auto_swarm_hidden"
end

function weaver_auto_swarm:GetCastRange()
    return self:GetCaster():Script_GetAttackRange()
end

function weaver_auto_swarm:OnProjectileHitHandle(target, vLocation, iProjectileHandle)
	if target then
		target:EmitSound("Hero_Weaver.ProjectileImpact")
        local weaver_the_swarm_custom = self:GetCaster():FindAbilityByName("weaver_the_swarm_custom")
        if weaver_the_swarm_custom and weaver_the_swarm_custom:GetLevel() > 0 then
            local duration = weaver_the_swarm_custom:GetSpecialValueFor("duration")
            local damage = weaver_the_swarm_custom:GetSpecialValueFor("damage")
            local armor_reduction = weaver_the_swarm_custom:GetSpecialValueFor("armor_reduction")
            if self:GetCaster():HasModifier("modifier_weaver_8") then
                damage = damage + weaver_the_swarm_custom.modifier_weaver_8[self:GetCaster():GetTalentLevel("modifier_weaver_8")]
            end
            if self:GetCaster():HasModifier("modifier_weaver_13") then
                armor_reduction = armor_reduction + weaver_the_swarm_custom.modifier_weaver_13[self:GetCaster():GetTalentLevel("modifier_weaver_13")]
            end
            ApplyDamage({ victim = target, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self })
            target:AddNewModifier(self:GetCaster(), self, "modifier_weaver_auto_swarm_armor_debuff", {duration = 6, arm = armor_reduction})
            if self:GetCaster():HasModifier("modifier_weaver_11") then
               target:Script_ReduceMana(damage / 100 * weaver_the_swarm_custom.modifier_weaver_11[self:GetCaster():GetTalentLevel("modifier_weaver_11")], weaver_the_swarm_custom)
            end
        end
	end
end

modifier_weaver_auto_swarm_hidden = class({})
function modifier_weaver_auto_swarm_hidden:IsHidden() return true end
function modifier_weaver_auto_swarm_hidden:IsPurgable() return false end
function modifier_weaver_auto_swarm_hidden:IsPurgeException() return false end
function modifier_weaver_auto_swarm_hidden:RemoveOnDeath() return false end
function modifier_weaver_auto_swarm_hidden:OnCreated()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm", {})
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_agility", {})
end

modifier_weaver_auto_swarm = class({})
function modifier_weaver_auto_swarm:IsHidden() return true end
function modifier_weaver_auto_swarm:IsPurgable() return false end
function modifier_weaver_auto_swarm:RemoveOnDeath() return false end
function modifier_weaver_auto_swarm:OnCreated( kv )
	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)
	self.revolution = 1.5
	self.rotate_radius = 100
	if not IsServer() then return end
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.position = self.parent:GetOrigin() + self.relative_pos
	self.rotation = 0
	self.facing = self.base_facing
	self.wisp = CreateUnitByName( "npc_dota_weaver_swarm", self.position, true, self.parent, self.parent:GetOwner(), self.parent:GetTeamNumber())
	self.wisp:SetForwardVector( self.facing )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_effect", {} )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_attack", {} )
	self.wisp:SetDayTimeVisionRange(0)
	self.wisp:SetNightTimeVisionRange(0)
	self:StartIntervalThink( self.interval )
end
function modifier_weaver_auto_swarm:OnRefresh( kv )
	self.revolution = 1.5
	self.rotate_radius = 100
	if not IsServer() then return end
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_attack", {} )
end
function modifier_weaver_auto_swarm:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.wisp )
end
function modifier_weaver_auto_swarm:OnIntervalThink()
	self.rotation = self.rotation + self.rotate_delta
	local origin = self.parent:GetOrigin()
	self.position = RotatePosition( origin, QAngle( 0, -self.rotation, 0 ), origin + self.relative_pos )
	self.facing = RotatePosition( self.zero, QAngle( 0, -self.rotation, 0 ), self.base_facing )
	self.wisp:SetOrigin( self.position )
	self.wisp:SetForwardVector( self.facing )
end

modifier_weaver_auto_swarm_agility = class({})
function modifier_weaver_auto_swarm_agility:IsHidden() return true end
function modifier_weaver_auto_swarm_agility:IsPurgable() return false end
function modifier_weaver_auto_swarm_agility:RemoveOnDeath() return false end
function modifier_weaver_auto_swarm_agility:OnCreated( kv )
	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)
	self.revolution = 1.5
	self.rotate_radius = 100
	if not IsServer() then return end
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.position = self.parent:GetOrigin() + self.relative_pos
	self.rotation = 180
	self.facing = self.base_facing
	self.wisp = CreateUnitByName( "npc_dota_weaver_swarm", self.position, true, self.parent, self.parent:GetOwner(), self.parent:GetTeamNumber())
	self.wisp:SetForwardVector( self.facing )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_effect", {agility = 1} )
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_attack", {agility = 1} )
	self.wisp:SetDayTimeVisionRange(0)
	self.wisp:SetNightTimeVisionRange(0)
	self:StartIntervalThink( self.interval )
end
function modifier_weaver_auto_swarm_agility:OnRefresh( kv )
	self.revolution = 1.5
	self.rotate_radius = 100
	if not IsServer() then return end
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval
	self.wisp:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_weaver_auto_swarm_attack", {agility = 1} )
end
function modifier_weaver_auto_swarm_agility:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.wisp )
end
function modifier_weaver_auto_swarm_agility:OnIntervalThink()
	self.rotation = self.rotation + self.rotate_delta
	local origin = self.parent:GetOrigin()
	self.position = RotatePosition( origin, QAngle( 0, -self.rotation, 0 ), origin + self.relative_pos )
	self.facing = RotatePosition( self.zero, QAngle( 0, -self.rotation, 0 ), self.base_facing )
	self.wisp:SetOrigin( self.position )
	self.wisp:SetForwardVector( self.facing )
end

modifier_weaver_auto_swarm_effect = class({})
function modifier_weaver_auto_swarm_effect:IsHidden()
	return true
end
function modifier_weaver_auto_swarm_effect:IsPurgable()
	return false
end
function modifier_weaver_auto_swarm_effect:OnCreated( params )
	if not IsServer() then return end
    self.agility = params.agility
	self:GetParent():SetModel( "models/heroes/weaver/weaver_bug.vmdl" )
	self:GetParent():SetOriginalModel( "models/heroes/weaver/weaver_bug.vmdl" )
	self:GetParent():SetModelScale(1.5)
	self:StartIntervalThink(FrameTime())
end

function modifier_weaver_auto_swarm_effect:OnIntervalThink()
	if not IsServer() then return end
    if self.agility ~= nil then
        if self:GetCaster():GetAgility() < 299 then
            self:GetParent():AddNoDraw()
            return
        end
    end
	if self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") and not self:GetCaster():HasModifier("modifier_smoke_of_deceit") and not self:GetCaster():HasModifier("modifier_weaver_2") then
		self:GetParent():RemoveNoDraw()
	else
		self:GetParent():AddNoDraw()
	end
end

function modifier_weaver_auto_swarm_effect:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
	return state
end

modifier_weaver_auto_swarm_attack = class({})

function modifier_weaver_auto_swarm_attack:IsHidden() return false end
function modifier_weaver_auto_swarm_attack:IsDebuff() return false end
function modifier_weaver_auto_swarm_attack:IsStunDebuff() return false end
function modifier_weaver_auto_swarm_attack:IsPurgable() return false end
function modifier_weaver_auto_swarm_attack:OnCreated( params )
	if not IsServer() then return end
    self.agility = params.agility
	self.info = 
	{
		Source = self:GetParent(),
		Ability = self:GetAbility(),	
		EffectName = "particles/units/heroes/hero_weaver/weaver_base_attack.vpcf",
		iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
		bDodgeable = true,
	}
	self:StartIntervalThink( FrameTime() )
end
function modifier_weaver_auto_swarm_attack:OnIntervalThink()
    if not IsServer() then return end
    local weaver_the_swarm_custom = self:GetCaster():FindAbilityByName("weaver_the_swarm_custom")
    if weaver_the_swarm_custom and weaver_the_swarm_custom:GetLevel() > 0 then
        local attack_rate = weaver_the_swarm_custom:GetSpecialValueFor("attack_rate")
        if self:GetCaster():HasModifier("modifier_weaver_14") then
            attack_rate = attack_rate + weaver_the_swarm_custom.modifier_weaver_14
        end
        self:StartIntervalThink(attack_rate)
    else
        return
    end
    if self.agility ~= nil then
        if self:GetCaster():GetAgility() < 299 then
            return
        end
    end
    if self:GetCaster():HasModifier("modifier_weaver_2") then return end
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_FARTHEST, false )
	if #enemies > 0 and self:GetCaster():IsAlive() and not self:GetCaster():HasModifier("modifier_wodawisp") then
		self.info.Target = enemies[1]
        if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then return end
		local proj_id = ProjectileManager:CreateTrackingProjectile(self.info)
		self:GetParent():EmitSound("Hero_Weaver.Attack")
	end
end

modifier_weaver_auto_swarm_armor_debuff = class({})
function modifier_weaver_auto_swarm_armor_debuff:OnCreated(params)
    if not IsServer() then return end
    self.armor = params.arm
    self:SetStackCount(1)
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
end
function modifier_weaver_auto_swarm_armor_debuff:OnRefresh(params)
    if not IsServer() then return end
    self.armor = params.arm
    if self:GetStackCount() < 6 then
        self:IncrementStackCount()
    end
    self:SendBuffRefreshToClients()
end
function modifier_weaver_auto_swarm_armor_debuff:AddCustomTransmitterData()
    return 
    {
        armor = self.armor,
    }
end
function modifier_weaver_auto_swarm_armor_debuff:HandleCustomTransmitterData( data )
    self.armor = data.armor
end
function modifier_weaver_auto_swarm_armor_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end
function modifier_weaver_auto_swarm_armor_debuff:GetModifierPhysicalArmorBonus()
    return (self:GetStackCount() * self.armor) * (-1)
end