--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ancient_apparition_chilling_touch_custom_debuff", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_chilling_touch_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_orb_effect_lua_apparation", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_chilling_touch_custom", LUA_MODIFIER_MOTION_NONE )

ancient_apparition_chilling_touch_custom = class({})

ancient_apparition_chilling_touch_custom.modifier_ancient_apparition_8 = 225
ancient_apparition_chilling_touch_custom.modifier_ancient_apparition_9 = {40,80,120}
ancient_apparition_chilling_touch_custom.modifier_ancient_apparition_11 = {50,100}

function ancient_apparition_chilling_touch_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_ancient_apparition.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_ancient_apparition.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_ancient_apparition.vpcf", context)
end

function ancient_apparition_chilling_touch_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_ancient_apparition_11") then
        return self.BaseClass.GetManaCost(self, level) - (self.BaseClass.GetManaCost(self, level) / 100 * self.modifier_ancient_apparition_11[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_11")])
    end
    return self.BaseClass.GetManaCost(self, level)
end

function ancient_apparition_chilling_touch_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_ancient_apparition_14") then
        return 0
    end
end

function ancient_apparition_chilling_touch_custom:ProcsMagicStick() return false end

function ancient_apparition_chilling_touch_custom:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua_apparation"
end

function ancient_apparition_chilling_touch_custom:GetProjectileName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile.vpcf"
end

function ancient_apparition_chilling_touch_custom:GetCastRange()
	return self:GetCaster():Script_GetAttackRange() + self:GetSpecialValueFor("attack_range_bonus")
end

function ancient_apparition_chilling_touch_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_14") then
        return "apparat_14"
    end
    return "ancient_apparition_chilling_touch"
end

function ancient_apparition_chilling_touch_custom:OnOrbFire()
	self:GetCaster():EmitSound("Hero_Ancient_Apparition.ChillingTouch.Cast")
    if not IsServer() then return end
    local modifier_ancient_apparition_16 = self:GetCaster():FindModifierByName("modifier_ancient_apparition_16")
    if modifier_ancient_apparition_16 then
        local manacost = self:GetManaCost(self:GetLevel())
        modifier_ancient_apparition_16:ApplyShield(manacost)
    end
    self:UseResources( true, false, false, true )
end

function ancient_apparition_chilling_touch_custom:OnOrbImpact( params )
    if not IsServer() then return end
    self:DamageAttack(params.target)
    if self:GetCaster():HasModifier("modifier_ancient_apparition_8") then
        local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), params.target:GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_ancient_apparition_8), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
        for _, hero in pairs(heroes) do
            if hero ~= params.target then
                self:DamageAttack(hero)
            end
        end
    end
end

function ancient_apparition_chilling_touch_custom:DamageAttack(target)
    target:EmitSound("Hero_Ancient_Apparition.ChillingTouch.Target")
	target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_chilling_touch_custom_debuff", { duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance())})
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_ancient_apparition_9") then
        damage = damage + self.modifier_ancient_apparition_9[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_9")]
    end
	ApplyDamage({
		victim 			= target,
		damage 			= damage,
		damage_type		= DAMAGE_TYPE_MAGICAL,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		attacker 		= self:GetCaster(),
		ability 		= self
	})
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, target, damage, nil)
end

modifier_ancient_apparition_chilling_touch_custom_debuff = class({})

function modifier_ancient_apparition_chilling_touch_custom_debuff:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_ancient_apparition_chilling_touch_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}	
end

function modifier_ancient_apparition_chilling_touch_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

modifier_generic_orb_effect_lua_apparation = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_orb_effect_lua_apparation:IsHidden()
	return true
end

function modifier_generic_orb_effect_lua_apparation:IsDebuff()
	return false
end

function modifier_generic_orb_effect_lua_apparation:IsPurgable()
	return false
end

function modifier_generic_orb_effect_lua_apparation:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_orb_effect_lua_apparation:OnCreated( kv )
	-- generate data
	self.ability = self:GetAbility()
	self.cast = false
	self.records = {}
end

function modifier_generic_orb_effect_lua_apparation:OnRefresh( kv )
end

function modifier_generic_orb_effect_lua_apparation:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_orb_effect_lua_apparation:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_EVENT_ON_ORDER,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}

	return funcs
end

function modifier_generic_orb_effect_lua_apparation:GetModifierAttackRangeBonus()
    if not IsServer() then return end
    if self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
        return self:GetAbility():GetSpecialValueFor("attack_range_bonus")
    end
end

function modifier_generic_orb_effect_lua_apparation:OnAttack( params )
	-- if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end

	-- no instant attacks
	if params.no_attack_cooldown then return end

	-- register attack if being cast and fully castable
	if self:ShouldLaunch( params.target ) then
		-- use mana and cd

		-- record the attack
		self.records[params.record] = true

		-- run OrbFire script if available
		if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
	end

	self.cast = false
end
function modifier_generic_orb_effect_lua_apparation:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		-- apply the effect
		if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
	end
end
function modifier_generic_orb_effect_lua_apparation:OnAttackFail( params )
	if self.records[params.record] then
		-- apply the fail effect
		if self.ability.OnOrbFail then self.ability:OnOrbFail( params ) end
	end
end
function modifier_generic_orb_effect_lua_apparation:OnAttackRecordDestroy( params )
	-- destroy attack record
	self.records[params.record] = nil
end

function modifier_generic_orb_effect_lua_apparation:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if params.ability then
		-- if this ability, cast
		if params.ability==self:GetAbility() then
			self.cast = true
			return
		end

		-- if casting other ability that cancel channel while casting this ability, turn off
		local pass = false
		local behavior = params.ability:GetBehaviorInt()
		if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
		then
			local pass = true -- do nothing
		end

		if self.cast and (not pass) then
			self.cast = false
		end
	else
		-- if ordering something which cancel channel, turn off
		if self.cast then
			if self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_POSITION ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_TARGET )	or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_MOVE ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_TARGET ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_STOP ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_HOLD_POSITION )
			then
				self.cast = false
			end
		end
	end
end

function modifier_generic_orb_effect_lua_apparation:GetModifierProjectileName()
	if not self.ability.GetProjectileName then return end

	if self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
		return self.ability:GetProjectileName()
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_generic_orb_effect_lua_apparation:ShouldLaunch( target )
	-- check autocast
	if self.ability:GetAutoCastState() then
		-- filter whether target is valid
		if self.ability.CastFilterResultTarget~=CDOTA_Ability_Lua.CastFilterResultTarget then
			-- check if ability has custom target cast filter
			if self.ability:CastFilterResultTarget( target )==UF_SUCCESS then
				self.cast = true
			end
		else
			local nResult = UnitFilter(
				target,
				self.ability:GetAbilityTargetTeam(),
				self.ability:GetAbilityTargetType(),
				self.ability:GetAbilityTargetFlags(),
				self:GetCaster():GetTeamNumber()
			)
			if nResult == UF_SUCCESS then
				self.cast = true
			end
		end
	end

	if self.cast and self.ability:IsFullyCastable() and (not self:GetParent():IsSilenced()) then
		return true
	end

	return false
end

function modifier_generic_orb_effect_lua_apparation:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end