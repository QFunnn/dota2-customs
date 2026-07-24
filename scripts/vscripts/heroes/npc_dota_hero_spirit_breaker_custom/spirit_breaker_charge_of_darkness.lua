--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spirit_breaker_charge_of_darkness_custom", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_charge_of_darkness", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_spirit_breaker_charge_of_darkness_custom_debuff", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_charge_of_darkness", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_charge_of_darkness_custom_effect_immune", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_charge_of_darkness", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_charge_of_darkness_custom_bonus", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_charge_of_darkness", LUA_MODIFIER_MOTION_NONE )

spirit_breaker_charge_of_darkness_custom = class({})

spirit_breaker_charge_of_darkness_custom.modifier_spirit_breaker_15 = 50
spirit_breaker_charge_of_darkness_custom.modifier_spirit_breaker_15_percent = {8,12,16}
spirit_breaker_charge_of_darkness_custom.modifier_spirit_breaker_11 = 3

function spirit_breaker_charge_of_darkness_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_target.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_spirit_breaker.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_spirit_breaker.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_spirit_breaker.vpcf", context)
end

--function spirit_breaker_charge_of_darkness_custom:GetCastPoint()
--    if self:GetCaster():HasModifier("modifier_spirit_breaker_9") then
--        return 0
--    end
--	return self.BaseClass.GetCastPoint( self )
--end
--
--function spirit_breaker_charge_of_darkness_custom:GetBehavior()
--    if self:GetCaster():HasModifier("modifier_spirit_breaker_9") then
--        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_ALERT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
--    end
--    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_ALERT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
--end

function spirit_breaker_charge_of_darkness_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    local is_point = 0
    if target == nil then
        local point = self:GetCursorPosition()
        is_point = 1
        target = CreateUnitByName("npc_dota_companion", point, false, nil, nil, DOTA_TEAM_NEUTRALS)
		target:AddNewModifier(self:GetCaster(), self, "modifier_invulnerable", {})
		target:AddNewModifier(self:GetCaster(), self, "modifier_phased", {})
		target:AddNewModifier(self:GetCaster(), self, "modifier_no_healthbar", {})
		target:AddNewModifier(self:GetCaster(), self, "modifier_not_on_minimap", {})
		local abs = point
		abs.z = abs.z + 64
		target:SetAbsOrigin(abs)
    end
    if target:IsHero() then
        if target:TriggerSpellAbsorb(self) then return end
    end
    local direction = (target:GetAbsOrigin() - caster:GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    caster:Stop()
    caster:SetForwardVector(direction)
	caster:AddNewModifier( caster, self, "modifier_spirit_breaker_charge_of_darkness_custom", { target = target:entindex(), is_point = is_point } )
end

modifier_spirit_breaker_charge_of_darkness_custom_debuff = class({})

function modifier_spirit_breaker_charge_of_darkness_custom_debuff:IsHidden()
	return true
end

function modifier_spirit_breaker_charge_of_darkness_custom_debuff:IsDebuff()
	return true
end

function modifier_spirit_breaker_charge_of_darkness_custom_debuff:IsPurgable()
	return false
end

function modifier_spirit_breaker_charge_of_darkness_custom_debuff:OnCreated( kv )
	if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_spirit_breaker_charge_of_darkness_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.2})
    if self:GetParent():IsNeutralUnitType() then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 100, 0.1, true)
    else
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent():GetCurrentVisionRange(), 0.1, true)
    end
end

modifier_spirit_breaker_charge_of_darkness_custom = class({})

function modifier_spirit_breaker_charge_of_darkness_custom:IsPurgable() return false end

function modifier_spirit_breaker_charge_of_darkness_custom:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

function modifier_spirit_breaker_charge_of_darkness_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.radius = self:GetAbility():GetSpecialValueFor( "bash_radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "stun_duration" )
    self.windup_time = self:GetAbility():GetSpecialValueFor("windup_time")
    self.min_movespeed_bonus_pct = self:GetAbility():GetSpecialValueFor("min_movespeed_bonus_pct") / 100
	if not IsServer() then return end
	self.target = EntIndexToHScript( kv.target )
    self.is_point = kv.is_point
	self.direction = self:GetParent():GetForwardVector()
	self.targets = {}
	self.search_radius = 4000
	self.tree_radius = 300
	self.min_dist = 150
	self.offset = 20
	self.interrupted = false
	self.mod = self.parent:FindModifierByName( "modifier_spirit_breaker_greater_bash_custom" )
    if self:GetAbility().original_owner then
        self.mod = self:GetAbility().original_owner:FindModifierByName( "modifier_spirit_breaker_greater_bash_custom" )
    end
	if self.mod and self.mod:GetAbility():GetLevel()<1 then
		self.mod = nil
	end
    if self:GetCaster():HasModifier("modifier_spirit_breaker_20") then
        self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_spirit_breaker_charge_of_darkness_custom_effect_immune", {})
    end
    if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
	self:SetTarget( self.target )
	self:GetAbility():SetActivated( false )
    self:GetAbility():EndCooldown()
	self.parent:EmitSound("Hero_Spirit_Breaker.ChargeOfDarkness")
    self:StartIntervalThink(0.01)
end

function modifier_spirit_breaker_charge_of_darkness_custom:OnDestroy()
	if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_spirit_breaker_11") then
        self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_spirit_breaker_charge_of_darkness_custom_bonus", {duration = self:GetAbility().modifier_spirit_breaker_11})
    end
    if not self.parent:IsAlive() then
        self.interrupted = true
    end
    if self.parent:IsHexed() or self.parent:IsStunned() or self.parent:IsRooted() or self.parent:IsFeared() then
        self.interrupted = true
    end
    if self.parent:HasModifier("modifier_oracle_false_promise_custom") then
        self.interrupted = true
    end
    self:GetCaster():StartGesture(ACT_DOTA_SPIRIT_BREAKER_CHARGE_END)
    self.parent:RemoveModifierByName("modifier_spirit_breaker_charge_of_darkness_custom_effect_immune")
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree_radius, true )
	self:GetParent():RemoveHorizontalMotionController( self )
	if self.debuff and (not self.debuff:IsNull()) then
		self.debuff:Destroy()
	end
	self:GetAbility():SetActivated( true )
	self:GetAbility():UseResources( false, false, false, true )
    if self.target:GetUnitName() == "npc_dota_companion" then
        UTIL_Remove(self.target)
        return
    end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end

function modifier_spirit_breaker_charge_of_darkness_custom:OnPreDestroy()
    if not self.interrupted then
        if self.mod and (not self.mod:IsNull()) then
            self.mod:Bash( self.target, false, self:GetCaster() )
        end
        self.target:AddNewModifier( self.parent, self:GetAbility(), "modifier_stunned", { duration = self.duration * (1 - self.target:GetStatusResistance()) } )
        if self.target:IsAlive() then
            local order = 
            {
                UnitIndex = self.parent:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                TargetIndex = self.target:entindex(),
            }
            ExecuteOrderFromTable( order )
        end
        if self:GetCaster():HasModifier("modifier_spirit_breaker_15") then
            local damage = (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_spirit_breaker_15_percent[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_15")]) + self:GetAbility().modifier_spirit_breaker_15
            ApplyDamage({ victim = self.target, attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
        end
        self.target:EmitSound("Hero_Spirit_Breaker.Charge.Impact")
    end
end

function modifier_spirit_breaker_charge_of_darkness_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
	return funcs
end

function modifier_spirit_breaker_charge_of_darkness_custom:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_spirit_breaker_charge_of_darkness_custom:GetActivityTranslationModifiers()
    return "charge"
end

function modifier_spirit_breaker_charge_of_darkness_custom:OnOrder( params )
    if params.unit == self:GetParent() then
        local cancel_commands = 
        {
            [DOTA_UNIT_ORDER_MOVE_TO_POSITION]  = true,
            [DOTA_UNIT_ORDER_MOVE_TO_TARGET]    = true,
            [DOTA_UNIT_ORDER_ATTACK_MOVE]       = true,
            [DOTA_UNIT_ORDER_ATTACK_TARGET]     = true,
            [DOTA_UNIT_ORDER_CAST_POSITION]     = true,
            [DOTA_UNIT_ORDER_CAST_TARGET]       = true,
            [DOTA_UNIT_ORDER_CAST_TARGET_TREE]  = true,
            [DOTA_UNIT_ORDER_HOLD_POSITION]     = true,
            [DOTA_UNIT_ORDER_STOP]              = true
        }
        
        if cancel_commands[params.order_type] then
            if not self:IsNull() then
                self.interrupted = true
                self:Destroy()
            end
        end
    end
end

function modifier_spirit_breaker_charge_of_darkness_custom:GetModifierMoveSpeedBonus_Constant()
    local t = math.min(self:GetElapsedTime(), self.windup_time)
    local k = self.min_movespeed_bonus_pct + (1 - self.min_movespeed_bonus_pct) * (t / self.windup_time)
    return self.bonus_ms * k
end

function modifier_spirit_breaker_charge_of_darkness_custom:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_spirit_breaker_charge_of_darkness_custom:OnIntervalThink()
    if not IsServer() then return end
    self:UpdateHorizontalMotionCustom( self:GetParent(), 0.01 )
end

function modifier_spirit_breaker_charge_of_darkness_custom:UpdateHorizontalMotionCustom( me, dt )
	self:BashLogic()
	self:CancelLogic()
	local direction = self.target:GetOrigin()-me:GetOrigin()
	local dist = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	if dist<self.min_dist then
        self:OnPreDestroy()
		self:Destroy()
		return
	end
    if me:GetIdealSpeed() < 100 then return end
    me:FaceTowards( self.target:GetOrigin() )
	local pos = me:GetOrigin() + direction * me:GetIdealSpeed() * dt
	pos = GetGroundPosition( pos, me )
	me:SetOrigin( pos )
	self.direction = direction
end

function modifier_spirit_breaker_charge_of_darkness_custom:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_spirit_breaker_charge_of_darkness_custom:BashLogic()
	local loc = self.parent:GetOrigin() + self.direction * self.offset
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), loc, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(enemies) do
		if not self.targets[enemy] then
			self.targets[enemy] = true
            if self.mod then
			    self.mod:Bash( enemy, false, self:GetCaster() )
            end
            if self:GetCaster():HasModifier("modifier_spirit_breaker_15") then
                local damage = (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_spirit_breaker_15_percent[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_15")]) + self:GetAbility().modifier_spirit_breaker_15
                ApplyDamage({ victim = enemy, attacker = self.parent, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
            end
		end
	end
end

function modifier_spirit_breaker_charge_of_darkness_custom:CancelLogic()
	local check = self.parent:IsHexed() or self.parent:IsStunned() or self.parent:IsRooted() or self.parent:IsFeared()
	if check then
		self.interrupted = true
		self:Destroy()
	end
	if self.target and ( not self.target:IsNull() and not self.target:IsAlive()) then
		local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.target:GetOrigin(), nil, self.search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false )
		if #enemies<1 then
			self.interrupted = true
			self:Destroy()
			return
		else
			self:SetTarget( enemies[1] )
		end
	end
end

function modifier_spirit_breaker_charge_of_darkness_custom:SetTarget( target )
	if self.debuff and (not self.debuff:IsNull()) then
		self.debuff:Destroy()
	end
	self.debuff = target:AddNewModifier( self.parent, self:GetAbility(), "modifier_spirit_breaker_charge_of_darkness_custom_debuff", {} )
	self.target = target
	self.targets[target] = true
end

function modifier_spirit_breaker_charge_of_darkness_custom:GetEffectName()
	return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf"
end

function modifier_spirit_breaker_charge_of_darkness_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_spirit_breaker_charge_of_darkness_custom_effect_immune = class({})
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:IsHidden() return true end
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:IsPurgable() return false end
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:IsPurgeException() return false end
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end
function modifier_spirit_breaker_charge_of_darkness_custom_effect_immune:StatusEffectPriority()
    return 99999
end

modifier_spirit_breaker_charge_of_darkness_custom_bonus = class({})

function modifier_spirit_breaker_charge_of_darkness_custom_bonus:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "movement_speed" )
end

function modifier_spirit_breaker_charge_of_darkness_custom_bonus:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
	return funcs
end

function modifier_spirit_breaker_charge_of_darkness_custom_bonus:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_spirit_breaker_charge_of_darkness_custom_bonus:GetModifierIgnoreMovespeedLimit()
	return 1
end