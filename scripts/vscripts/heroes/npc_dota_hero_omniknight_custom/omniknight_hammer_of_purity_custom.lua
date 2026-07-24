--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom_debuff", "heroes/npc_dota_hero_omniknight_custom/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom_debuff_armor", "heroes/npc_dota_hero_omniknight_custom/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom_thinker", "heroes/npc_dota_hero_omniknight_custom/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom_aura", "heroes/npc_dota_hero_omniknight_custom/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_orb_effect_lua_omniknight", "heroes/npc_dota_hero_omniknight_custom/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom_attack_heal", "heroes/npc_dota_hero_omniknight_custom/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)

omniknight_hammer_of_purity_custom = class({})

function omniknight_hammer_of_purity_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_hammer_of_purity_projectile.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_target.vpcf", context )
    PrecacheResource( "particle", "particles/marci_field.vpcf", context )
end

omniknight_hammer_of_purity_custom.modifier_omniknight_10 = {0.7,1.4}
omniknight_hammer_of_purity_custom.modifier_omniknight_11_armor = {-2,-4,-6}
omniknight_hammer_of_purity_custom.modifier_omniknight_11_duration = 5
omniknight_hammer_of_purity_custom.modifier_omniknight_12_damage = 20
omniknight_hammer_of_purity_custom.modifier_omniknight_13_duration = {4,4,4}
omniknight_hammer_of_purity_custom.modifier_omniknight_13_heal = {10,20,30}
omniknight_hammer_of_purity_custom.modifier_omniknight_13_radius = 300
omniknight_hammer_of_purity_custom.modifier_omniknight_14 = -0.5
omniknight_hammer_of_purity_custom.modifier_omniknight_14_radius = 300
omniknight_hammer_of_purity_custom.modifier_omniknight_9 = 100

function omniknight_hammer_of_purity_custom:GetCastRange( location , target)
	local bonus = 0
    local attack_range_bonus = self:GetSpecialValueFor("attack_range_bonus")
    if self:GetCaster():HasModifier("modifier_omniknight_9") then
        bonus = self.modifier_omniknight_9
    end
    if IsServer() then
        return self:GetCaster():Script_GetAttackRange()
    else
        return (self:GetCaster():Script_GetAttackRange() + attack_range_bonus) + bonus
    end
end

function omniknight_hammer_of_purity_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_omniknight_14") then
        bonus = self.modifier_omniknight_14
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function omniknight_hammer_of_purity_custom:GetIntrinsicModifierName()
    return "modifier_generic_orb_effect_lua_omniknight"
end

function omniknight_hammer_of_purity_custom:GetProjectileName()
    return "particles/units/heroes/hero_omniknight/omniknight_hammer_of_purity_projectile.vpcf"
end

function omniknight_hammer_of_purity_custom:OnOrbFire()
    if not IsServer() then return end
    if self:GetCaster():IsRangedAttacker() then
        self:UseResources(true, false, false, true)
    end
    self:GetCaster():EmitSound("Hero_Omniknight.HammerOfPurity.Cast")
end

function omniknight_hammer_of_purity_custom:OnOrbImpact( params )
    local target = params.target
    print("jab jab")
	if target == nil then return end
    if self:GetCaster():HasModifier("modifier_omniknight_14") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_omniknight_14_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _,unit in pairs(units) do
            self:ApplyDebuff(unit)
        end
    else
        self:ApplyDebuff(target)
    end
    if self:GetCaster():HasModifier("modifier_omniknight_13") then
        CreateModifierThinker(self:GetCaster(), self, "modifier_omniknight_hammer_of_purity_custom_thinker", {duration = self.modifier_omniknight_13_duration[self:GetCaster():GetTalentLevel("modifier_omniknight_13")]}, target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    end
    self:UseResources( true, false, false, true )
end

function omniknight_hammer_of_purity_custom:OnOrbFail()
    self:GetCaster():EmitSound("Hero_Omniknight.HammerOfPurity.Cast")
end

function omniknight_hammer_of_purity_custom:ApplyDebuff(target)
    local ability = self
	local base_damage = self:GetSpecialValueFor("base_damage")
	local bonus_damage = self:GetSpecialValueFor("bonus_damage")
	local duration  = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_omniknight_10") then
        duration = duration + self.modifier_omniknight_10[self:GetCaster():GetTalentLevel("modifier_omniknight_10")]
    end
	if self:GetCaster():HasModifier("modifier_omniknight_12") then
		bonus_damage = bonus_damage + self.modifier_omniknight_12_damage
	end
	local damage = base_damage + (self:GetCaster():GetAttackDamage() / 100 * bonus_damage)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
    local end_damage = ApplyDamage({ attacker = self:GetCaster(), victim = target, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = ability })
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_omniknight_hammer_of_purity_custom_attack_heal", {duration = 5, damage = end_damage})
    target:AddNewModifier(self:GetCaster(), ability, "modifier_omniknight_hammer_of_purity_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
    if self:GetCaster():HasModifier("modifier_omniknight_11") then
        target:AddNewModifier(self:GetCaster(), ability, "modifier_omniknight_hammer_of_purity_custom_debuff_armor", {duration = self.modifier_omniknight_11_duration * (1 - target:GetStatusResistance())})
    end
    target:EmitSound("Hero_Omniknight.HammerOfPurity.Target")
end

modifier_omniknight_hammer_of_purity_custom_debuff = class({})

function modifier_omniknight_hammer_of_purity_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_omniknight_hammer_of_purity_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_slow")
end

modifier_omniknight_hammer_of_purity_custom_debuff_armor = class({})

function modifier_omniknight_hammer_of_purity_custom_debuff_armor:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_omniknight_hammer_of_purity_custom_debuff_armor:GetModifierPhysicalArmorBonus()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_omniknight_11") then
		bonus = self:GetAbility().modifier_omniknight_11_armor[self:GetCaster():GetTalentLevel("modifier_omniknight_11")]
	end
	return bonus
end

modifier_omniknight_hammer_of_purity_custom_thinker = class({})

function modifier_omniknight_hammer_of_purity_custom_thinker:IsHidden() return true end

function modifier_omniknight_hammer_of_purity_custom_thinker:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/marci_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl( particle, 1, Vector( self:GetCaster():GetAoeBonus(self:GetAbility().modifier_omniknight_13_radius), 0, 1 ) )
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_omniknight_hammer_of_purity_custom_thinker:IsAura()
    return true
end

function modifier_omniknight_hammer_of_purity_custom_thinker:GetModifierAura()
    return "modifier_omniknight_hammer_of_purity_custom_aura"
end

function modifier_omniknight_hammer_of_purity_custom_thinker:GetAuraRadius()
    return self:GetCaster():GetAoeBonus(self:GetAbility().modifier_omniknight_13_radius)
end

function modifier_omniknight_hammer_of_purity_custom_thinker:GetAuraDuration()
    return 0
end

function modifier_omniknight_hammer_of_purity_custom_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_omniknight_hammer_of_purity_custom_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_omniknight_hammer_of_purity_custom_thinker:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_omniknight_hammer_of_purity_custom_aura = class({})

function modifier_omniknight_hammer_of_purity_custom_aura:IsPurgable() return false end

function modifier_omniknight_hammer_of_purity_custom_aura:DeclareFunctions()
	return {
		 
	}
end

function modifier_omniknight_hammer_of_purity_custom_aura:OnTakeDamage(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.unit == self:GetParent() then return end
	params.attacker:Heal(params.damage / 100 * self:GetAbility().modifier_omniknight_13_heal[self:GetCaster():GetTalentLevel("modifier_omniknight_13")], self:GetAbility())
end

modifier_generic_orb_effect_lua_omniknight = class({})

function modifier_generic_orb_effect_lua_omniknight:IsHidden()
	return true
end

function modifier_generic_orb_effect_lua_omniknight:IsDebuff()
	return false
end

function modifier_generic_orb_effect_lua_omniknight:IsPurgable()
	return false
end

function modifier_generic_orb_effect_lua_omniknight:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_generic_orb_effect_lua_omniknight:OnCreated( kv )
	self.ability = self:GetAbility()
	self.cast = false
	self.records = {}
end

function modifier_generic_orb_effect_lua_omniknight:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_EVENT_ON_ATTACK_START,
	}
	return funcs
end

function modifier_generic_orb_effect_lua_omniknight:OnAttack( params )
	if params.attacker~=self:GetParent() then return end
	self:GetParent():ClearActivityModifiers()
	if self:ShouldLaunch( params.target ) then
		self.records[params.record] = true
		if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
	end
	self.cast = false
end

function modifier_generic_orb_effect_lua_omniknight:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
	end
end

function modifier_generic_orb_effect_lua_omniknight:OnAttackFail( params )
	if self.records[params.record] then
		if self.ability.OnOrbFail then self:GetParent():ClearActivityModifiers() self.ability:OnOrbFail( params ) end
	end
end

function modifier_generic_orb_effect_lua_omniknight:OnAttackRecordDestroy( params )
	self:GetParent():ClearActivityModifiers()
	self.records[params.record] = nil
end

function modifier_generic_orb_effect_lua_omniknight:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if params.ability then
		if params.ability == self:GetAbility() or string.find( params.ability:GetName(), "omniknight_hammer_of_purity" ) then
			self.cast = true
			return
		end

		local pass = false
		local behavior = params.ability:GetBehaviorInt()
		if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
		then
			local pass = true
		end

		if self.cast and (not pass) then
			self.cast = false
		end
	else
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

function modifier_generic_orb_effect_lua_omniknight:GetModifierProjectileName()
	if not self.ability.GetProjectileName then return end

	if self:ShouldLaunch( self:GetCaster():GetAggroTarget() ) then
		return self.ability:GetProjectileName()
	end
end

function modifier_generic_orb_effect_lua_omniknight:OnAttackStart(params)
	if params.attacker~=self:GetParent() then return end
    print("dobi dobi", self.cast)
	if self:ShouldLaunch( params.target ) then
    	print("self.cast", self.cast)
	end
end

function modifier_generic_orb_effect_lua_omniknight:GetModifierAttackRangeBonus(params)
    if not IsServer() then return end
	if (self.ability:IsFullyCastable() and self.ability:GetAutoCastState()) or self.cast then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_omniknight_9") then
            bonus = self:GetAbility().modifier_omniknight_9
        end
		return self:GetAbility():GetSpecialValueFor("attack_range_bonus") + bonus
	end
end

function modifier_generic_orb_effect_lua_omniknight:ShouldLaunch( target )
	if self.ability:GetAutoCastState() then
		if self.ability.CastFilterResultTarget~=CDOTA_Ability_Lua.CastFilterResultTarget then
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

function modifier_generic_orb_effect_lua_omniknight:CheckState()
    if (self.ability:IsFullyCastable() and (self.ability:GetAutoCastState()) or self.cast) and self:GetCaster():HasModifier("modifier_omniknight_9") then
        return
        {
            [MODIFIER_STATE_CANNOT_MISS] = true,
        }
    end
    return {}
end

function modifier_generic_orb_effect_lua_omniknight:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

modifier_omniknight_hammer_of_purity_custom_attack_heal = class({})
function modifier_omniknight_hammer_of_purity_custom_attack_heal:IsHidden() return true end
function modifier_omniknight_hammer_of_purity_custom_attack_heal:IsPurgable() return false end
function modifier_omniknight_hammer_of_purity_custom_attack_heal:IsPurgeException() return false end
function modifier_omniknight_hammer_of_purity_custom_attack_heal:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_omniknight_hammer_of_purity_custom_attack_heal:OnCreated(params)
    if not IsServer() then return end
    self.damage = params.damage
    self.tick_heal = (self.damage / 100 * self:GetAbility():GetSpecialValueFor("heal_pct")) / self:GetAbility():GetSpecialValueFor("heal_duration")
    self:StartIntervalThink(1)
    self:OnIntervalThink()
end

function modifier_omniknight_hammer_of_purity_custom_attack_heal:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():Heal(self.tick_heal, self:GetAbility())
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), self.tick_heal, nil)
end