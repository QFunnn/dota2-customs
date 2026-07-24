--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_earthshaker_enchant_totem_custom", "heroes/npc_dota_hero_earthshaker_custom/earthshaker_enchant_totem_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_earthshaker_enchant_totem_custom_jump", "heroes/npc_dota_hero_earthshaker_custom/earthshaker_enchant_totem_custom", LUA_MODIFIER_MOTION_BOTH )

earthshaker_enchant_totem_custom = class({})
earthshaker_enchant_totem_custom.modifier_earthshaker_4_bonus_dmg = {2,4}
earthshaker_enchant_totem_custom.modifier_earthshaker_6_cooldown = {-0.5,-1}

function earthshaker_enchant_totem_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_totem_leap_impact.vpcf", context )
    PrecacheResource( "particle", "particles/items_fx/battlefury_cleave.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_totem_leap_blur.vpcf", context )
end

function earthshaker_enchant_totem_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_earthshaker_7") then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CAN_SELF_CAST
	end
	return self.BaseClass.GetBehavior( self )
end

function earthshaker_enchant_totem_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_earthshaker_6") then
		bonus = self.modifier_earthshaker_6_cooldown[self:GetCaster():GetTalentLevel("modifier_earthshaker_6")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function earthshaker_enchant_totem_custom:GetAOERadius()
	return self:GetSpecialValueFor( "aftershock_range" )
end

function earthshaker_enchant_totem_custom:GetCastRange( point, target )
	local caster = self:GetCaster()
	if self:GetCaster():HasModifier("modifier_earthshaker_7") then
		return self:GetSpecialValueFor( "distance_scepter" )
	end
	return self.BaseClass.GetCastPoint( self )
end

function earthshaker_enchant_totem_custom:GetCastPoint()
	if not IsServer() then
		return self.BaseClass.GetCastPoint( self )
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if self:GetCaster():HasModifier("modifier_earthshaker_7") and target~=caster then
		return 0
	end

	return self.BaseClass.GetCastPoint( self )
end

function earthshaker_enchant_totem_custom:CastFilterResultTarget( hTarget )
	return UF_SUCCESS
end

function earthshaker_enchant_totem_custom:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if self:GetCaster():HasModifier("modifier_earthshaker_7") and target ~= self:GetCaster() then
		if not self:GetCaster():IsCustomHasTethered() and not self:GetCaster():IsRooted() then
			return true
		else
			local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
	        if player then
	            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#DOTA_ToolTip_Disabled_By_Root"})
	        end
	        return false
		end
	end
	return true
end

function earthshaker_enchant_totem_custom:OnProjectileHit_ExtraData(target, vLocation, table)
    if not IsServer() then return end
    local damage = table.damage
    ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self })
end

function earthshaker_enchant_totem_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	if self:GetCaster():HasModifier("modifier_earthshaker_7") and target ~= self:GetCaster() then

		if not self:GetCaster():IsCustomHasTethered() and not self:GetCaster():IsRooted() then
			self:GetCaster():SetForwardVector((point - self:GetCaster():GetAbsOrigin()):Normalized())
			self:GetCaster():FaceTowards(self:GetCursorPosition())

			local duration = self:GetSpecialValueFor( "scepter_leap_duration" )
			local height = self:GetSpecialValueFor( "scepter_height" )
			local distance = (point - caster:GetOrigin()):Length2D()

			local arc = caster:AddNewModifier(
				caster,
				self,
				"modifier_earthshaker_enchant_totem_custom_jump",
				{
					target_x = point.x,
					target_y = point.y,
					distance = distance,
					duration = 1,
					height = 650,
					fix_end = false,
					isForward = true,
				}
			)

			arc:SetEndCallback(function()
				FindClearSpaceForUnit(self:GetCaster(), self:GetCaster():GetAbsOrigin(), true)
				local duration = self:GetSpecialValueFor("duration")
				self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_earthshaker_enchant_totem_custom", { duration = duration } )
				self:GetCaster():EmitSound("Hero_EarthShaker.Totem")
				local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_totem_leap_impact.vpcf", PATTACH_WORLDORIGIN,  self:GetCaster()  )
				ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetOrigin() )
				ParticleManager:ReleaseParticleIndex( nFXIndex )
				local aftershock = self:GetCaster():FindModifierByName("modifier_earthshaker_aftershock_custom")
				if aftershock then
					aftershock:AfterShockApply(self:GetCaster():GetAbsOrigin())
				end
			end)
		end
	else
		local duration = self:GetSpecialValueFor("duration")
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_earthshaker_enchant_totem_custom", { duration = duration } )
		self:GetCaster():EmitSound("Hero_EarthShaker.Totem")
		local aftershock = self:GetCaster():FindModifierByName("modifier_earthshaker_aftershock_custom")
		if aftershock then
			aftershock:AfterShockApply(self:GetCaster():GetAbsOrigin())
		end
	end
end

modifier_earthshaker_enchant_totem_custom = class({})

function modifier_earthshaker_enchant_totem_custom:IsPurgable()
	return true
end

function modifier_earthshaker_enchant_totem_custom:OnCreated( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor( "totem_damage_percentage" )
	self.range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_earthshaker_enchant_totem_custom:OnRefresh( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor( "totem_damage_percentage" )
	self.range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
end

function modifier_earthshaker_enchant_totem_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_earthshaker_enchant_totem_custom:GetActivityTranslationModifiers()
	return "enchant_totem"
end

function modifier_earthshaker_enchant_totem_custom:GetModifierBaseDamageOutgoing_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_earthshaker_4") then
		bonus = self:GetAbility().modifier_earthshaker_4_bonus_dmg[self:GetCaster():GetTalentLevel("modifier_earthshaker_4")] * self:GetParent():GetLevel()
	end
	return self.bonus + bonus
end

function modifier_earthshaker_enchant_totem_custom:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		params.target:EmitSound("Hero_EarthShaker.Totem.Attack")
        local mod = self
        Timers:CreateTimer(FrameTime(), function()
            mod:Destroy()
        end)
	end
end

function modifier_earthshaker_enchant_totem_custom:GetModifierTotalDamageOutgoing_Percentage(params)
    if not IsServer() then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    local modifier_revenants_brooch_custom_counter = self:GetParent():FindModifierByName("modifier_revenants_brooch_custom_counter")
    if modifier_revenants_brooch_custom_counter and modifier_revenants_brooch_custom_counter:GetOverrideAttackMagical() > 0 then
        ApplyDamage({attacker = self:GetParent(), victim = params.target, damage = params.original_damage * 0.8, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    else
        ApplyDamage({attacker = self:GetParent(), victim = params.target, damage = params.original_damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_ATTACK_MODIFIER})
    end
    return 0
end

function modifier_earthshaker_enchant_totem_custom:GetModifierAttackRangeBonus()
	return self.range
end

function modifier_earthshaker_enchant_totem_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment( "attach_totem" )~=0 then attach = "attach_totem" end
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, attach, Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end

modifier_earthshaker_enchant_totem_custom_jump = class({})

function modifier_earthshaker_enchant_totem_custom_jump:IsHidden()
	return true
end

function modifier_earthshaker_enchant_totem_custom_jump:IsDebuff()
	return false
end

function modifier_earthshaker_enchant_totem_custom_jump:IsStunDebuff()
	return false
end

function modifier_earthshaker_enchant_totem_custom_jump:IsPurgable()
	return true
end

function modifier_earthshaker_enchant_totem_custom_jump:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_earthshaker_enchant_totem_custom_jump:OnCreated( kv )
	if not IsServer() then return end
	self.interrupted = false
	self:SetJumpParameters( kv )
	self:Jump()
end

function modifier_earthshaker_enchant_totem_custom_jump:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_earthshaker_enchant_totem_custom_jump:OnDestroy()
	if not IsServer() then return end

	local pos = self:GetParent():GetOrigin()

	self:GetParent():RemoveHorizontalMotionController( self )
	self:GetParent():RemoveVerticalMotionController( self )

	if self.end_offset~=0 then
		self:GetParent():SetOrigin( pos )
	end

	if self.endCallback then
		self.endCallback( self.interrupted )
	end
end

function modifier_earthshaker_enchant_totem_custom_jump:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return funcs
end

function modifier_earthshaker_enchant_totem_custom_jump:GetModifierDisableTurning()
	if not self.isForward then return end
	return 1
end

function modifier_earthshaker_enchant_totem_custom_jump:GetActivityTranslationModifiers()
	return "ultimate_scepter"
end

function modifier_earthshaker_enchant_totem_custom_jump:GetOverrideAnimation()
	return ACT_DOTA_OVERRIDE_ABILITY_2
end

function modifier_earthshaker_enchant_totem_custom_jump:GetEffectName()
	return "particles/units/heroes/hero_earthshaker/earthshaker_totem_leap_blur.vpcf"
end

function modifier_earthshaker_enchant_totem_custom_jump:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_earthshaker_enchant_totem_custom_jump:CheckState()
	return 
    {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_earthshaker_enchant_totem_custom_jump:UpdateHorizontalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
	local pos = me:GetOrigin() + self.direction * self.speed * dt
    if me:GetIdealSpeed() < 100 then return end
	me:SetOrigin( pos )
end

function modifier_earthshaker_enchant_totem_custom_jump:UpdateVerticalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end

	local pos = me:GetOrigin()
	local time = self:GetElapsedTime()

	local height = pos.z
	local speed = self:GetVerticalSpeed( time )
	pos.z = height + speed * dt
	me:SetOrigin( pos )

	if not self.fix_duration then
		local ground = GetGroundHeight( pos, me ) + self.end_offset
		if pos.z <= ground then
			pos.z = ground
			me:SetOrigin( pos )
			self:Destroy()
		end
	end
end

function modifier_earthshaker_enchant_totem_custom_jump:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_earthshaker_enchant_totem_custom_jump:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_earthshaker_enchant_totem_custom_jump:SetJumpParameters( kv )
	self.parent = self:GetParent()

	self.fix_end = true
	self.fix_duration = true
	self.fix_height = true
	if kv.fix_end then
		self.fix_end = kv.fix_end==1
	end
	if kv.fix_duration then
		self.fix_duration = kv.fix_duration==1
	end
	if kv.fix_height then
		self.fix_height = kv.fix_height==1
	end

	self.isStun = kv.isStun==1
	self.isRestricted = kv.isRestricted==1
	self.isForward = kv.isForward==1
	self.activity = kv.activity or 0
	self:SetStackCount( self.activity )

	if kv.target_x and kv.target_y then
		local origin = self.parent:GetOrigin()
		local dir = Vector( kv.target_x, kv.target_y, 0 ) - origin
		dir.z = 0
		dir = dir:Normalized()
		self.direction = dir
	end
	if kv.dir_x and kv.dir_y then
		self.direction = Vector( kv.dir_x, kv.dir_y, 0 ):Normalized()
	end
	if not self.direction then
		self.direction = self.parent:GetForwardVector()
	end

	self.duration = kv.duration
	self.distance = kv.distance
	self.speed = kv.speed
	if not self.duration then
		self.duration = self.distance/self.speed
	end
	if not self.distance then
		self.speed = self.speed or 0
		self.distance = self.speed*self.duration
	end
	if not self.speed then
		self.distance = self.distance or 0
		self.speed = self.distance/self.duration
	end

	self.height = kv.height or 0
	self.start_offset = kv.start_offset or 0
	self.end_offset = kv.end_offset or 0

	local pos_start = self.parent:GetOrigin()
	local pos_end = pos_start + self.direction * self.distance
	local height_start = GetGroundHeight( pos_start, self.parent ) + self.start_offset
	local height_end = GetGroundHeight( pos_end, self.parent ) + self.end_offset
	local height_max

	if not self.fix_height then
		self.height = math.min( self.height, self.distance/4 )
	end

	if self.fix_end then
		height_end = height_start
		height_max = height_start + self.height
	else
		-- calculate height
		local tempmin, tempmax = height_start, height_end
		if tempmin>tempmax then
			tempmin,tempmax = tempmax, tempmin
		end
		local delta = (tempmax-tempmin)*2/3

		height_max = tempmin + delta + self.height
	end

	if not self.fix_duration then
		self:SetDuration( -1, false )
	else
		self:SetDuration( self.duration, true )
	end

	self:InitVerticalArc( height_start, height_max, height_end, self.duration )
end

function modifier_earthshaker_enchant_totem_custom_jump:Jump()
	if self.distance>0 then
		if not self:ApplyHorizontalMotionController() then
			self.interrupted = true
			self:Destroy()
		end
	end

	if self.height>0 then
		if not self:ApplyVerticalMotionController() then
			self.interrupted = true
			self:Destroy()
		end
	end
end

function modifier_earthshaker_enchant_totem_custom_jump:InitVerticalArc( height_start, height_max, height_end, duration )
	local height_end = height_end - height_start
	local height_max = height_max - height_start

	if height_max<height_end then
		height_max = height_end+0.01
	end

	if height_max<=0 then
		height_max = 0.01
	end

	local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
	self.const1 = 4*height_max*duration_end/duration
	self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)
end

function modifier_earthshaker_enchant_totem_custom_jump:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_earthshaker_enchant_totem_custom_jump:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

function modifier_earthshaker_enchant_totem_custom_jump:SetEndCallback( func )
	self.endCallback = func
end