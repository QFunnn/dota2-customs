--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spirit_breaker_astral_charge", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_astral_charge", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_spirit_breaker_astral_charge_debuff", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_astral_charge", LUA_MODIFIER_MOTION_NONE )

spirit_breaker_astral_charge = class({})

spirit_breaker_astral_charge.modifier_spirit_breaker_15 = 150
spirit_breaker_astral_charge.modifier_spirit_breaker_15_percent = {10,15,20}

function spirit_breaker_astral_charge:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_target.vpcf", context )
end

function spirit_breaker_astral_charge:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
    local direction = (target:GetAbsOrigin() - caster:GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    local illusion = CreateUnitByName("npc_dota_spirit_breaker_phantom", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    illusion:SetForwardVector(direction)
    illusion:AddNewModifier( caster, self, "modifier_spirit_breaker_astral_charge", { target = target:entindex() } )
    illusion:SetBaseMoveSpeed(caster:GetIdealSpeed())
    illusion:SetRenderAlpha(0.5)
end

modifier_spirit_breaker_astral_charge_debuff = class({})

function modifier_spirit_breaker_astral_charge_debuff:IsHidden()
	return true
end

function modifier_spirit_breaker_astral_charge_debuff:IsDebuff()
	return true
end

function modifier_spirit_breaker_astral_charge_debuff:IsPurgable()
	return false
end

function modifier_spirit_breaker_astral_charge_debuff:OnCreated( kv )
	if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_spirit_breaker_astral_charge_debuff:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = 0.2})
    if self:GetParent():IsNeutralUnitType() then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 100, 0.1, true)
    else
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent():GetCurrentVisionRange(), 0.1, true)
    end
end

modifier_spirit_breaker_astral_charge = class({})
function modifier_spirit_breaker_astral_charge:IsHidden() return true end
function modifier_spirit_breaker_astral_charge:IsPurgable() return false end
function modifier_spirit_breaker_astral_charge:IsPurgeException() return false end
function modifier_spirit_breaker_astral_charge:RemoveOnDeath() return false end

function modifier_spirit_breaker_astral_charge:OnCreated( kv )
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.radius = self:GetAbility():GetSpecialValueFor( "bash_radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "stun_duration" )
	if not IsServer() then return end
	self.target = EntIndexToHScript( kv.target )
	self.direction = self:GetParent():GetForwardVector()
	self.targets = {}
	self.search_radius = 4000
	self.tree_radius = 150
	self.min_dist = 150
	self.offset = 20
	self.interrupted = false
	self.mod = self:GetCaster():FindModifierByName( "modifier_spirit_breaker_greater_bash_custom" )
	if self.mod and self.mod:GetAbility():GetLevel()<1 then
		self.mod = nil
	end
	if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
	self:SetTarget( self.target )
	self.parent:EmitSound("Hero_Spirit_Breaker.ChargeOfDarkness")
end

function modifier_spirit_breaker_astral_charge:OnDestroy()
	if not IsServer() then return end
    local parent = self.parent
    Timers:CreateTimer(0.1, function()
        if parent and not parent:IsNull() then
            UTIL_Remove(parent)
        end
    end)
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree_radius, true )
	self:GetParent():RemoveHorizontalMotionController( self )
	if self.debuff and (not self.debuff:IsNull()) then
		self.debuff:Destroy()
	end
    if self.target == nil or self.target:IsNull() then
        if self.parent and self.parent:IsAlive() then
            UTIL_Remove(self.parent)
        end
        return
    end
	if self.interrupted then 
        if self.parent and self.parent:IsAlive() then
            UTIL_Remove(self.parent)
        end
        return 
    end
	if self.mod and (not self.mod:IsNull()) then
		self.mod:Bash( self.target, false )
	end
    if self:GetCaster():HasModifier("modifier_spirit_breaker_15") then
        local damage = (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_spirit_breaker_15_percent[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_15")]) + self:GetAbility().modifier_spirit_breaker_15
        ApplyDamage({ victim = self.target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
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
	self.target:EmitSound("Hero_Spirit_Breaker.Charge.Impact")
    if self.parent and self.parent:IsAlive() then
        UTIL_Remove(self.parent)
    end
end

function modifier_spirit_breaker_astral_charge:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
	return funcs
end

function modifier_spirit_breaker_astral_charge:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_spirit_breaker_astral_charge:GetActivityTranslationModifiers()
    return "charge"
end

function modifier_spirit_breaker_astral_charge:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_spirit_breaker_astral_charge:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_spirit_breaker_astral_charge:UpdateHorizontalMotion( me, dt )
	self:BashLogic()
	self:CancelLogic()
    if me:IsNull() then return end
	local direction = self.target:GetOrigin()-me:GetOrigin()
	local dist = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	if dist<self.min_dist then
		self:Destroy()
		return
	end
	local pos = me:GetOrigin() + direction * me:GetIdealSpeed() * dt
	pos = GetGroundPosition( pos, me )
	me:SetOrigin( pos )
	self.direction = direction
	self.parent:FaceTowards( self.target:GetOrigin() )
end

function modifier_spirit_breaker_astral_charge:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_spirit_breaker_astral_charge:BashLogic()
	local loc = self.parent:GetOrigin() + self.direction * self.offset
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), loc, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(enemies) do
		if not self.targets[enemy] then
			self.targets[enemy] = true
            if self.mod then
			    self.mod:Bash( enemy, false )
            end
            if self:GetCaster():HasModifier("modifier_spirit_breaker_15") then
                local damage = (self:GetCaster():GetMana() / 100 * self:GetAbility().modifier_spirit_breaker_15_percent[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_15")]) + self:GetAbility().modifier_spirit_breaker_15
                ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
            end
		end
	end
end

function modifier_spirit_breaker_astral_charge:CancelLogic()
	local check = self.parent:IsHexed() or self.parent:IsStunned() or self.parent:IsRooted()
	if check then
		self.interrupted = true
		self:Destroy()
	end

    if self.target:IsNull() then
        self.interrupted = true
        self:Destroy()
        return
    end

	if not self.target:IsAlive() then
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

function modifier_spirit_breaker_astral_charge:SetTarget( target )
	if self.debuff and (not self.debuff:IsNull()) then
		self.debuff:Destroy()
	end
	self.debuff = target:AddNewModifier( self.parent, self:GetAbility(), "modifier_spirit_breaker_astral_charge_debuff", {} )
	self.target = target
	self.targets[target] = true
end

function modifier_spirit_breaker_astral_charge:GetEffectName()
	return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf"
end

function modifier_spirit_breaker_astral_charge:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_spirit_breaker_astral_charge:GetStatusEffectName()
    return "particles/spirit_breaker_ghost.vpcf"
end

function modifier_spirit_breaker_astral_charge:StatusEffectPriority()
    return 999999
end

function modifier_spirit_breaker_astral_charge:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end