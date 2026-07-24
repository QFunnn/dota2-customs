--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tiny_toss_custom", "heroes/npc_dota_hero_tiny_custom/tiny_toss_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_tiny_toss_custom_debuff", "heroes/npc_dota_hero_tiny_custom/tiny_toss_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tiny_toss_custom_magic_immune", "heroes/npc_dota_hero_tiny_custom/tiny_toss_custom", LUA_MODIFIER_MOTION_NONE )

tiny_toss_custom = class({})

tiny_toss_custom.modifier_tiny_15 = {50,100}
tiny_toss_custom.modifier_tiny_20 = {-20,-30,-40}
tiny_toss_custom.modifier_tiny_20_duration = 4
tiny_toss_custom.modifier_tiny_21 = 100

function tiny_toss_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_tiny_21") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_RUNE_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_RUNE_TARGET
end

function tiny_toss_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function tiny_toss_custom:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end
    if hTarget:IsOther() then
        return UF_FAIL_OTHER
    end
	return UF_SUCCESS
end

function tiny_toss_custom:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
	return "#dota_hud_error_nothing_to_toss"
end

function tiny_toss_custom:FindEnemies()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "grab_radius" )
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
	local target
	for _,unit in pairs(units) do
		local filter1 = (unit~=caster) and (not unit:IsAncient()) and (not unit:FindModifierByName( 'modifier_tiny_toss_custom' )) and (not unit:IsDebuffImmune())
		local filter2 = (unit:GetTeamNumber()==caster:GetTeamNumber()) or (not unit:IsInvisible())
		if filter1 then
			if filter2 then
				target = unit
				break
			end
		end
	end
	return target
end

function tiny_toss_custom:OnAbilityPhaseStart()
    if self:GetCaster():HasModifier("modifier_tiny_15") then return true end
	return self:FindEnemies() ~= nil
end

function tiny_toss_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local victim = self:FindEnemies()
    local point = self:GetCursorPosition()
    if self:GetCaster():HasModifier("modifier_tiny_15") then
        victim = self:GetCaster()
    end

    if target == nil then
        victim:AddNewModifier( caster, self, "modifier_tiny_toss_custom", { point_x = point.x, point_y = point.y } )
    else
	    victim:AddNewModifier( caster, self, "modifier_tiny_toss_custom", { target = target:entindex() } )
    end
end

modifier_tiny_toss_custom = class({})

function modifier_tiny_toss_custom:IsHidden()
	return true
end

function modifier_tiny_toss_custom:IsDebuff()
	return self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber()
end

function modifier_tiny_toss_custom:IsStunDebuff()
	return true
end

function modifier_tiny_toss_custom:IsPurgable()
	return true
end

function modifier_tiny_toss_custom:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    if self:GetCaster():HasModifier("modifier_tiny_21") then
        self.radius = self.radius + self:GetAbility().modifier_tiny_21
    end
	if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor( "toss_damage" )
    if self:GetCaster():HasModifier("modifier_tiny_15") then
        self.damage = self.damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_tiny_15[self:GetCaster():GetTalentLevel("modifier_tiny_15")])
    end
    local tiny_grow_custom = self:GetCaster():FindAbilityByName("tiny_grow_custom")
    if tiny_grow_custom then
        self.damage = self.damage + tiny_grow_custom:GetSpecialValueFor("toss_bonus_damage")
    end
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
    if kv.target then
	    self.target = EntIndexToHScript( kv.target )
    end
    if self:GetCaster():HasModifier("modifier_tiny_16") then
        if self:GetParent() == self:GetCaster() then
            self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_tiny_toss_custom_magic_immune", {})
        end
    end
	local height = 850
	self.arc = self.parent:AddNewModifier( self.caster, self:GetAbility(), "modifier_generic_arc_lua", { duration = duration, distance = 0, height = height, fix_duration = false, isStun = true, activity = ACT_DOTA_FLAIL, } )
	self.arc:SetEndCallback(function( interrupted )
		self:Destroy()
		if interrupted then return end
		local enemies = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		local damageTable = 
        {
			attacker = self.caster,
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		}
		for _,enemy in pairs(enemies) do
			damageTable.victim = enemy
			damageTable.damage = self.damage
			ApplyDamage(damageTable)
            if self:GetCaster():HasModifier("modifier_tiny_20") then
                enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_tiny_toss_custom_debuff", {duration = self:GetAbility().modifier_tiny_20_duration})
            end
		end
		--GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )
		self.parent:EmitSound("Ability.TossImpact")
	end)

    local origin = self:GetParent():GetAbsOrigin()
    if self.target then
	    origin = self.target:GetOrigin()
    else
        origin = Vector( kv.point_x, kv.point_y, 0 )
        self.point = Vector( kv.point_x, kv.point_y, 0 )
    end
	local direction = origin-self.parent:GetOrigin()
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	self.distance = distance
	if self.distance==0 then self.distance = 1 end
	self.duration = duration
	self.speed = distance/duration
	self.accel = 100
	self.max_speed = 3000
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
	self.caster:EmitSound("Ability.TossThrow")
	self.parent:EmitSound("Hero_Tiny.Toss.Target")
end

function modifier_tiny_toss_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
    self:GetParent():RemoveModifierByName("modifier_tiny_toss_custom_magic_immune")
end

function modifier_tiny_toss_custom:CheckState()
	return
    {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_tiny_toss_custom:UpdateHorizontalMotion( me, dt )
	local target = self:GetParent():GetAbsOrigin()
    if self:GetParent() == self:GetCaster() then
        if self:GetParent():IsRooted() then
            return
        end
    end
    if self.target then
	    target = self.target:GetOrigin()
    else
        target = self.point
    end
	local parent = self.parent:GetOrigin()
	local duration = self:GetElapsedTime()
	local direction = target-parent
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	local original_distance = duration/self.duration * self.distance
	local expected_speed
	if self:GetElapsedTime()>=self.duration then
		expected_speed = self.speed
	else
		expected_speed = distance/(self.duration-self:GetElapsedTime())
	end
	if self.speed<expected_speed then
		self.speed = math.min(self.speed + self.accel, self.max_speed)
	elseif self.speed>expected_speed then
		self.speed = math.max(self.speed - self.accel, 0)
	end
	local pos = parent + direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_tiny_toss_custom:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_tiny_toss_custom:GetEffectName()
	return "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
end

function modifier_tiny_toss_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_tiny_toss_custom_debuff = class({})

function modifier_tiny_toss_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_tiny_toss_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_tiny_20[self:GetCaster():GetTalentLevel("modifier_tiny_20")]
end

function modifier_tiny_toss_custom_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf"
end

function modifier_tiny_toss_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
end

function modifier_tiny_toss_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_tiny_toss_custom_debuff:StatusEffectPriority()
    return 3
end

modifier_tiny_toss_custom_magic_immune = class({})
function modifier_tiny_toss_custom_magic_immune:IsPurgable() return false end
function modifier_tiny_toss_custom_magic_immune:GetTexture() return "tiny_16" end
function modifier_tiny_toss_custom_magic_immune:CheckState()
 	return 
 	{
 		[MODIFIER_STATE_DEBUFF_IMMUNE] = true
	}
end
function modifier_tiny_toss_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar_aghanim.vpcf"
end

function modifier_tiny_toss_custom_magic_immune:DeclareFunctions()
	return
	{
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_tiny_toss_custom_magic_immune:GetModifierMagicalResistanceBonus(params)
	return 65
end