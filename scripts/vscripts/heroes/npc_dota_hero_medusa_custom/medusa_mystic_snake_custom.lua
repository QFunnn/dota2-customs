--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_medusa_mystic_snake_custom_debuff", "heroes/npc_dota_hero_medusa_custom/medusa_mystic_snake_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_medusa_stone_gaze_custom_petrified", "heroes/npc_dota_hero_medusa_custom/medusa_stone_gaze_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_medusa_mystic_snake_custom_handler", "heroes/npc_dota_hero_medusa_custom/medusa_mystic_snake_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_medusa_mystic_snake_custom_handler_cooldown", "heroes/npc_dota_hero_medusa_custom/medusa_mystic_snake_custom", LUA_MODIFIER_MOTION_NONE)

medusa_mystic_snake_custom = class({})

medusa_mystic_snake_custom.modifier_medusa_9 = 50
medusa_mystic_snake_custom.modifier_medusa_10 = {50,100}
medusa_mystic_snake_custom.modifier_medusa_11 = {24,18,12}
medusa_mystic_snake_custom.modifier_medusa_14 = 1.5

function medusa_mystic_snake_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_medusa_8") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function medusa_mystic_snake_custom:GetIntrinsicModifierName()
    return "modifier_medusa_mystic_snake_custom_handler"
end

function medusa_mystic_snake_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    local one = nil
    if new_target then
        target = new_target
        one = 1
    end
	local mana_steal = self:GetSpecialValueFor( "snake_mana_steal" ) / 100
	local jumps = self:GetSpecialValueFor( "snake_jumps" )
	local radius = self:GetSpecialValueFor( "radius" )
	local base_damage = self:GetSpecialValueFor( "snake_damage" )
	local mult_damage = self:GetSpecialValueFor( "snake_scale" ) / 100
	local projectile_speed = self:GetSpecialValueFor( "initial_speed" )
	local projectile_vision = 100
	local index = self:GetUniqueInt()

	local info = 
    {
		Target = target,
		Source = caster,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		bDrawsOnMinimap = false,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
		iVisionTeamNumber = caster:GetTeamNumber(),
		ExtraData = 
        {
			index = index,
            one = one,
		}
	}

	ProjectileManager:CreateTrackingProjectile(info)

	local data = {}
	data.jump = 0
	data.mana_stolen = 0
	data.isReturning = false
	data.hit_units = {}
	data.jumps = jumps
	data.radius = radius
	data.base_damage = base_damage
	data.mult_damage = mult_damage
	data.base_stun = base_stun
	data.mult_stun = mult_stun
	data.mana_steal = mana_steal
	data.projectile_info = info
	self.projectiles[index] = data

	caster:EmitSound("Hero_Medusa.MysticSnake.Cast")
end

medusa_mystic_snake_custom.projectiles = {}

function medusa_mystic_snake_custom:OnProjectileHit_ExtraData( target, location, ExtraData )
	local data = self.projectiles[ ExtraData.index ]
	if data.isReturning then
		self:Returned( data )
		return
	end

    data.hit_units[target] = true

    local sphere_checkout = true
    if ExtraData.one == nil then
        if target:TriggerSpellAbsorb(self) then
            sphere_checkout = false
        end
    end

	if target and (not target:IsMagicImmune()) and (not target:IsInvulnerable()) and sphere_checkout then
		local damage_type = self:GetAbilityDamageType()
		local damage = data.base_damage + data.base_damage * data.mult_damage * data.jump
        local modifier_medusa_9 = self:GetCaster():FindModifierByName("modifier_medusa_9")
        if self:GetCaster():HasModifier("modifier_medusa_9") then
            if target:IsHero() then
                if modifier_medusa_9:GetStackCount() >= 3 then
                    damage = damage + (target:GetIntellect(false) / 100 * self.modifier_medusa_9)
                end
                if modifier_medusa_9:GetStackCount() >= 2 then
                    damage = damage + (target:GetAgility() / 100 * self.modifier_medusa_9)
                end
                if modifier_medusa_9:GetStackCount() >= 1 then
                    damage = damage + (target:GetStrength() / 100 * self.modifier_medusa_9)
                end
            else
                if modifier_medusa_9:GetStackCount() >= 3 then
                    damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_medusa_9)
                end
                if modifier_medusa_9:GetStackCount() >= 2 then
                    damage = damage + (self:GetCaster():GetAgility() / 100 * self.modifier_medusa_9)
                end
                if modifier_medusa_9:GetStackCount() >= 1 then
                    damage = damage + (self:GetCaster():GetStrength() / 100 * self.modifier_medusa_9)
                end
            end
        end
		local damageTable = 
        {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = damage_type,
			ability = self,
		}
		ApplyDamage(damageTable)
        if self:GetCaster():HasModifier("modifier_medusa_14") then
            local medusa_stone_gaze_custom = self:GetCaster():FindAbilityByName("medusa_stone_gaze_custom")
            if medusa_stone_gaze_custom and medusa_stone_gaze_custom:GetLevel() > 0 then
                target:AddNewModifier(self:GetCaster(), medusa_stone_gaze_custom, "modifier_medusa_stone_gaze_custom_petrified", {duration = self.modifier_medusa_14, physical_bonus = medusa_stone_gaze_custom:GetSpecialValueFor( "bonus_physical_damage" ), center_unit = self:GetCaster():entindex()})
            end
        end
        target:AddNewModifier(self:GetCaster(), self, "modifier_medusa_mystic_snake_custom_debuff", {duration = self:GetSpecialValueFor("slow_duration")})
		local mana_taken = target:GetMaxMana()*data.mana_steal
        if target:IsIllusion() then
            mana_taken = 0
        end
		--target:Script_ReduceMana( mana_taken, self )
		data.mana_stolen = data.mana_stolen + mana_taken
		target:EmitSound("Hero_Medusa.MysticSnake.Target")
		data.jump = data.jump + 1
		if data.jump >= data.jumps or ExtraData.one ~= nil then
			self:Returning( data, target )
			return
		end
	end

	local pos = location
	if target then
		pos = target:GetOrigin()
	end

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), pos, nil, data.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
	local next_target = nil
	for _,enemy in pairs(enemies) do
		local found = false
		for unit, _ in pairs(data.hit_units) do
			if enemy==unit then
				found = true
				break
			end
		end
		if not found then
			next_target = enemy
			break
		end
	end

	if not next_target then
		self:Returning( data, target )
		return
	end

	data.projectile_info.Target = next_target
	data.projectile_info.Source = target
    data.projectile_info.iMoveSpeed = data.projectile_info.iMoveSpeed + (data.projectile_info.iMoveSpeed / 100 * self:GetSpecialValueFor("snake_speed_scale"))

	ProjectileManager:CreateTrackingProjectile( data.projectile_info )
end

function medusa_mystic_snake_custom:Returning( data, target )
	if not target then
		self:Returned( data )
		return
	end
	data.isReturning = true
	data.projectile_info.Target = self:GetCaster()
	data.projectile_info.Source = target
	data.projectile_info.EffectName = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile_return.vpcf"
    data.projectile_info.iMoveSpeed = self:GetSpecialValueFor("return_speed")
	ProjectileManager:CreateTrackingProjectile( data.projectile_info )
end

function medusa_mystic_snake_custom:Returned( data )
	local index = data.projectile_info.ExtraData.index
	self.projectiles[ index ] = nil
	self:DelUniqueInt( index )
	if not self:GetCaster():IsAlive() then return end
	self:GetCaster():GiveMana( data.mana_stolen )
    if self:GetCaster():HasModifier("modifier_medusa_10") then
        self:GetCaster():Heal(data.mana_stolen / 100 * self.modifier_medusa_10[self:GetCaster():GetTalentLevel("modifier_medusa_10")], self)
        SendOverheadEventMessage( nil, OVERHEAD_ALERT_HEAL, self:GetCaster(), data.mana_stolen, self:GetCaster():GetPlayerOwner() )
    end
	self:GetCaster():EmitSound("Hero_Medusa.MysticSnake.Return")
	SendOverheadEventMessage( nil, OVERHEAD_ALERT_MANA_ADD, self:GetCaster(), data.mana_stolen, self:GetCaster():GetPlayerOwner() )
end

medusa_mystic_snake_custom.unique = {}
medusa_mystic_snake_custom.i = 0
medusa_mystic_snake_custom.max = 65536

function medusa_mystic_snake_custom:GetUniqueInt()
	while self.unique[ self.i ] do
		self.i = self.i + 1
		if self.i==self.max then self.i = 0 end
	end

	self.unique[ self.i ] = true
	return self.i
end

function medusa_mystic_snake_custom:DelUniqueInt( i )
	self.unique[ i ] = nil
end

modifier_medusa_mystic_snake_custom_debuff = class({})

function modifier_medusa_mystic_snake_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
    }
end

function modifier_medusa_mystic_snake_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_medusa_mystic_snake_custom_debuff:GetModifierTurnRate_Percentage()
    return self:GetAbility():GetSpecialValueFor("turn_slow")
end

function modifier_medusa_mystic_snake_custom_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf"
end

function modifier_medusa_mystic_snake_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
end

function modifier_medusa_mystic_snake_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_medusa_mystic_snake_custom_debuff:StatusEffectPriority()
    return 3
end


modifier_medusa_mystic_snake_custom_handler = class({})
function modifier_medusa_mystic_snake_custom_handler:IsHidden() return true end
function modifier_medusa_mystic_snake_custom_handler:IsPurgable() return false end
function modifier_medusa_mystic_snake_custom_handler:IsPurgeException() return false end
function modifier_medusa_mystic_snake_custom_handler:RemoveOnDeath() return false end
function modifier_medusa_mystic_snake_custom_handler:DeclareFunctions()
    return
    {
         
    }
end

function modifier_medusa_mystic_snake_custom_handler:OnAbilityFullyCast( params )
    if not IsServer() then return end
    if params.unit == self:GetParent() then return end
    if params.target == nil then return end
    if params.target ~= self:GetParent() then return end
    if self:GetCaster():HasModifier("modifier_medusa_mystic_snake_custom_handler_cooldown") then return end
    if not self:GetCaster():HasModifier("modifier_medusa_11") then return end
    if params.unit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
    self:GetAbility():OnSpellStart(params.unit)
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_medusa_mystic_snake_custom_handler_cooldown", {duration = self:GetAbility().modifier_medusa_11[self:GetCaster():GetTalentLevel("modifier_medusa_11")]})
end

modifier_medusa_mystic_snake_custom_handler_cooldown = class({})
function modifier_medusa_mystic_snake_custom_handler_cooldown:IsPurgable() return false end
function modifier_medusa_mystic_snake_custom_handler_cooldown:IsPurgeException() return false end
function modifier_medusa_mystic_snake_custom_handler_cooldown:RemoveOnDeath() return false end
function modifier_medusa_mystic_snake_custom_handler_cooldown:IsDebuff() return true end
function modifier_medusa_mystic_snake_custom_handler_cooldown:GetTexture() return "medusa_11" end