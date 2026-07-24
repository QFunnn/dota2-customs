--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_monkey_king_tree_dance_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_custom_jump", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_custom_cooldown", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_tree_dance_custom", LUA_MODIFIER_MOTION_BOTH )

monkey_king_tree_dance_custom = class({})
monkey_king_tree_dance_custom.modifier_monkey_king_19 = {-1,-2}

function monkey_king_tree_dance_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", context )
end

function monkey_king_tree_dance_custom:GetIntrinsicModifierName()
    return "modifier_monkey_king_tree_dance_custom_cooldown"
end

function monkey_king_tree_dance_custom:OnAbilityPhaseStart()
    local target = self:GetCursorTarget()
    local modifier_monkey_king_tree_dance_custom = self:GetCaster():FindModifierByName("modifier_monkey_king_tree_dance_custom")
    if modifier_monkey_king_tree_dance_custom and modifier_monkey_king_tree_dance_custom.tree == target then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_treejump_tree_target_same_tree"})
        end
        return false
    end
    return true
end

function monkey_king_tree_dance_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local tree = self:GetCursorTarget()
    if not caster:HasModifier("modifier_monkey_king_tree_dance_custom") then 
        local monkey_king_primal_spring_custom = caster:FindAbilityByName("monkey_king_primal_spring_custom")
        if monkey_king_primal_spring_custom then
            monkey_king_primal_spring_custom:SetActivated(true)
        end
    end
    local speed = self:GetSpecialValueFor( "leap_speed" ) + 200
    local perched_spot_height = 256
    local distance = (tree:GetOrigin()-caster:GetOrigin()):Length2D()
    local duration = distance / speed
    local perch = 0
    if caster:HasModifier("modifier_monkey_king_tree_dance_custom") then
        perch = 1
    end
    local modifier = caster:AddNewModifier( caster, self, "modifier_monkey_king_tree_dance_custom_jump", { target_x = tree:GetOrigin().x, target_y = tree:GetOrigin().y, distance = distance, speed = speed, height = perched_spot_height, fix_end = false, fix_height = false, isStun = true, activity = ACT_DOTA_MK_TREE_SOAR, start_offset = perched_spot_height*perch, end_offset = perched_spot_height } )
    if modifier then
        modifier:SetEndCallback(function()
            if tree and not tree:IsNull() then 
                caster:AddNewModifier( caster, self, "modifier_monkey_king_tree_dance_custom", { tree = tree:entindex() } )
            else 
                FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
            end
        end)
        local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
        modifier:AddParticle( particle, false, false, -1, false, false )
        caster:EmitSound("Hero_MonkeyKing.TreeJump.Cast")
    end
    self:StartCooldown(duration + self:GetCooldown(self:GetLevel()))
end

modifier_monkey_king_tree_dance_custom_cooldown = class({})
function modifier_monkey_king_tree_dance_custom_cooldown:IsHidden() return true end
function modifier_monkey_king_tree_dance_custom_cooldown:IsPurgable() return false end
function modifier_monkey_king_tree_dance_custom_cooldown:RemoveOnDeath() return false end
function modifier_monkey_king_tree_dance_custom_cooldown:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    if not self.parent:IsRealHero() or self.parent:IsTempestDouble() then return end
    self.ability = self:GetAbility()
    self.cd = self.ability:GetSpecialValueFor("jump_damage_cooldown")
end 

function modifier_monkey_king_tree_dance_custom_cooldown:OnTakeDamage( params )
    if not IsServer() then return end
    if params.unit~=self.parent then return end
    if params.unit:HasModifier( "modifier_monkey_king_tree_dance_custom" ) then return end
    if not params.attacker then return end
    --if not params.attacker:IsHero() and not params.attacker:IsBuilding() then return end
    if params.damage < 3 then return end
    local cooldown = self.cd
    self.ability:StartCooldown( cooldown )
end

modifier_monkey_king_tree_dance_custom = class({})
function modifier_monkey_king_tree_dance_custom:IsHidden() return true end
function modifier_monkey_king_tree_dance_custom:IsPurgable() return false end
function modifier_monkey_king_tree_dance_custom:OnCreated( kv )
    self.parent = self:GetParent()
    self.perched_spot_height = 256
    self.perched_day_vision = self:GetAbility():GetSpecialValueFor( "perched_day_vision" )
    self.perched_night_vision = self:GetAbility():GetSpecialValueFor( "perched_night_vision" )
    if not IsServer() then return end
    self.unperched_stunned_duration = self:GetAbility():GetSpecialValueFor( "unperched_stunned_duration" )
    if self:GetCaster():HasModifier("modifier_monkey_king_19") then
        self.unperched_stunned_duration = self.unperched_stunned_duration + self:GetAbility().modifier_monkey_king_19[self:GetCaster():GetTalentLevel("modifier_monkey_king_19")]
    end
    self.ability = self.parent:FindAbilityByName("monkey_king_primal_spring_custom")
    self.ability:SetActivated(true)
    self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_monkey_king_tree_dance_hidden", {})
    self.tree = EntIndexToHScript( kv.tree )
    self.origin = self.tree:GetOrigin()
    if not self:ApplyHorizontalMotionController() then
        self.interrupted = true
        self:Destroy()
    end
    if not self:ApplyVerticalMotionController() then
        self.interrupted = true
        self:Destroy()
    end
    self:StartIntervalThink( 0.1 )
    self:OnIntervalThink()
    self.parent:EmitSound("Hero_MonkeyKing.TreeJump.Tree")
end

function modifier_monkey_king_tree_dance_custom:OnDestroy()
    if not IsServer() then return end
    local pos = self.parent:GetOrigin()
    if self.ability and not self.ability:IsNull() then
        self.ability:SetActivated(self.ability:CanBeCast())
    end	
    self.parent:RemoveModifierByName("modifier_monkey_king_tree_dance_hidden")
    self.parent:RemoveHorizontalMotionController( self )
    self.parent:RemoveVerticalMotionController( self )
    if not self.unperched then
        self.parent:SetOrigin( pos )
    end
end

function modifier_monkey_king_tree_dance_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_FIXED_DAY_VISION,
        MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
    }
end

function modifier_monkey_king_tree_dance_custom:OnAbilityExecuted(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if not params.ability:IsItem() then return end
    if params.ability:IsToggle() then return end
    if params.ability:GetName() == "item_fallen_sky" then
        self:Destroy()
    end
end

function modifier_monkey_king_tree_dance_custom:GetActivityTranslationModifiers()
    return "perch"
end

function modifier_monkey_king_tree_dance_custom:OnOrder( params )
    if params.unit ~= self.parent then return end
    if params.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or params.order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET or params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
        if not self:GetAbility():IsCooldownReady() then
            return
        end
        local pos = params.new_pos
        if params.target then pos = params.target:GetOrigin() end
        local direction = (pos-self.parent:GetOrigin())
        direction.z = 0
        direction = direction:Normalized()
        self.parent:SetForwardVector( direction )
        local modifier = self.parent:AddNewModifier( self.parent, self:GetAbility(), "modifier_monkey_king_tree_dance_custom_jump", { dir_x = direction.x, activity = ACT_DOTA_MK_STRIKE_END, dir_y = direction.y, distance = 150, speed = 350, height = 1, start_offset = self.perched_spot_height, fix_end = false, isForward = true } )
        local parent = self.parent
        if modifier then
            modifier:SetEndCallback(function()
                FindClearSpaceForUnit( parent, parent:GetOrigin(), true )
            end)
            local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
            modifier:AddParticle( particle, false, false, -1, false, false )
        end
        if not self:GetParent():HasModifier("modifier_monkey_king_21") then
            self:GetParent():RemoveModifierByName("modifier_monkey_king_transform_courier")
            self:GetParent():RemoveModifierByName("modifier_monkey_king_transform_runes")
            self:GetParent():RemoveModifierByName("modifier_monkey_king_transform")
        end
        self:GetAbility():UseResources(false, false, false, true)
        self:Destroy()
    end
end

function modifier_monkey_king_tree_dance_custom:GetFixedDayVision()
	return self.perched_day_vision
end

function modifier_monkey_king_tree_dance_custom:GetFixedNightVision()
	return self.perched_night_vision
end

function modifier_monkey_king_tree_dance_custom:CheckState()
	return
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
        [MODIFIER_STATE_NEUTRALS_DONT_ATTACK] = true,
	}
end

function modifier_monkey_king_tree_dance_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self.tree.IsStanding then
        if self.tree:IsNull() then
            self:Destroy()
        end
        return
    end
    if self:GetParent():IsTaunted() or self:GetParent():HasModifier("modifier_lich_sinister_gaze_custom_debuff") then
        self.unperched = true
        self:Destroy()
        return
    end
    if self.tree:IsStanding() then return end
    local mod = self.parent:AddNewModifier( self.parent, self:GetAbility(), "modifier_stunned", { duration = self.unperched_stunned_duration } )
    self.unperched = true
    self:Destroy()
end

function modifier_monkey_king_tree_dance_custom:UpdateHorizontalMotion( me, dt )
    me:SetOrigin( self.origin )
end

function modifier_monkey_king_tree_dance_custom:UpdateVerticalMotion( me, dt )
    if not self.tree.IsStanding then
        if self.tree:IsNull() then
            self:Destroy()
        end
        return
    end
    local pos = self.tree:GetOrigin()
    pos.z = pos.z + self.perched_spot_height
    me:SetOrigin( pos )
end


function modifier_monkey_king_tree_dance_custom:OnVerticalMotionInterrupted()
    self:Destroy()
end

function modifier_monkey_king_tree_dance_custom:OnHorizontalMotionInterrupted()
    self:Destroy()
end

modifier_monkey_king_tree_dance_custom_jump = class({})
function modifier_monkey_king_tree_dance_custom_jump:IsHidden() return true end
function modifier_monkey_king_tree_dance_custom_jump:IsPurgable() return true end
function modifier_monkey_king_tree_dance_custom_jump:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_monkey_king_tree_dance_custom_jump:OnCreated( kv )
    if not IsServer() then return end
    self.interrupted = false
    self:SetJumpParameters( kv )
    self:Jump()
end

function modifier_monkey_king_tree_dance_custom_jump:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_monkey_king_tree_dance_custom_jump:OnDestroy()
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

function modifier_monkey_king_tree_dance_custom_jump:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
	if self:GetStackCount()>0 then
		table.insert( funcs, MODIFIER_PROPERTY_OVERRIDE_ANIMATION )
	end
	return funcs
end

function modifier_monkey_king_tree_dance_custom_jump:GetModifierDisableTurning()
	if not self.isForward then return end
	return 1
end

function modifier_monkey_king_tree_dance_custom_jump:GetOverrideAnimation()
	return self:GetStackCount()
end

function modifier_monkey_king_tree_dance_custom_jump:CheckState()
	local state = 
    {
		[MODIFIER_STATE_STUNNED] = self.isStun or false,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.isRestricted or false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_monkey_king_tree_dance_custom_jump:UpdateHorizontalMotion( me, dt )
	if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
	local pos = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_monkey_king_tree_dance_custom_jump:UpdateVerticalMotion( me, dt )
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

function modifier_monkey_king_tree_dance_custom_jump:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_monkey_king_tree_dance_custom_jump:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_monkey_king_tree_dance_custom_jump:SetJumpParameters( kv )
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

function modifier_monkey_king_tree_dance_custom_jump:Jump()
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

function modifier_monkey_king_tree_dance_custom_jump:InitVerticalArc( height_start, height_max, height_end, duration )
	local height_end = height_end - height_start
	local height_max = height_max - height_start
	-- fail-safe1: height_max cannot be smaller than height delta
	if height_max<height_end then
		height_max = height_end+0.01
	end
	-- fail-safe2: height-max must be positive
	if height_max<=0 then
		height_max = 0.01
	end
	-- math magic
	local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
	self.const1 = 4*height_max*duration_end/duration
	self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)
end

function modifier_monkey_king_tree_dance_custom_jump:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_monkey_king_tree_dance_custom_jump:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

function modifier_monkey_king_tree_dance_custom_jump:SetEndCallback( func )
	self.endCallback = func
end