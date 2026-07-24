--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_frostbite_custom", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_frostbite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_frostbite_custom_passive", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_frostbite_custom", LUA_MODIFIER_MOTION_NONE )


LinkLuaModifier( "modifier_crystal_maiden_frostbite_custom_cooldown", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_frostbite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_frostbite_custom_magic_immune", "heroes/npc_dota_hero_crystal_maiden_custom/crystal_maiden_frostbite_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_frostbite_custom = class({})

function crystal_maiden_frostbite_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_frostbite.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf', context )
    PrecacheResource( "particle", 'particles/items_fx/black_king_bar_avatar.vpcf', context )
    PrecacheResource( "particle", 'particles/status_fx/status_effect_avatar.vpcf', context )
end

crystal_maiden_frostbite_custom.modifier_crystal_maiden_9_cooldown = {45,30,15}
crystal_maiden_frostbite_custom.modifier_crystal_maiden_10_duration = 0.5
crystal_maiden_frostbite_custom.modifier_crystal_maiden_11_damage_agility = {40,60,80}
crystal_maiden_frostbite_custom.modifier_crystal_maiden_12_bonus_duration = 0.5

crystal_maiden_frostbite_custom.modifier_crystal_maiden_15 = {50,100}

function crystal_maiden_frostbite_custom:GetIntrinsicModifierName()
	return "modifier_crystal_maiden_frostbite_custom_passive"
end

function crystal_maiden_frostbite_custom:OnSpellStart(target)
	if not IsServer() then return end
	local caster = self:GetCaster()

	if target == nil then 
		target = self:GetCursorTarget()
		if target:TriggerSpellAbsorb(self) then return end
	end

	local duration = self:GetSpecialValueFor("duration")

	if not target:IsHero() then
		duration = self:GetSpecialValueFor("creep_duration")
	end

	if self:GetCaster():HasModifier("modifier_crystal_maiden_12") then
		duration = duration + self.modifier_crystal_maiden_12_bonus_duration
	end

	if self:GetCaster():HasModifier("modifier_crystal_maiden_10") then
		self:GetCaster():Purge(false, true, false, false, false)
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_crystal_maiden_frostbite_custom_magic_immune", {duration = self.modifier_crystal_maiden_10_duration})
	end

	local stun_duration = 0.1
	target:AddNewModifier(caster,self,"modifier_crystal_maiden_frostbite_custom",{ duration = duration * ( 1 - target:GetStatusResistance() ) })
	self:PlayEffects( caster, target )
end

function crystal_maiden_frostbite_custom:PlayEffects( caster, target )
	local projectile_name = "particles/units/heroes/hero_crystalmaiden/maiden_frostbite.vpcf"
	local projectile_speed = 1000
	local info = {Target = target,Source = caster,Ability = self,EffectName = projectile_name,iMoveSpeed = projectile_speed,vSourceLoc= caster:GetAbsOrigin(),bDodgeable = false}
	ProjectileManager:CreateTrackingProjectile(info)
end

modifier_crystal_maiden_frostbite_custom = class({})

function modifier_crystal_maiden_frostbite_custom:IsHidden()
	return false
end

function modifier_crystal_maiden_frostbite_custom:IsDebuff()
	return true
end

function modifier_crystal_maiden_frostbite_custom:IsStunDebuff()
	return false
end

function modifier_crystal_maiden_frostbite_custom:IsPurgable()
	return true
end

function modifier_crystal_maiden_frostbite_custom:OnCreated( kv )
	local tick_damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
    if not self:GetParent():IsHero() and not self:GetParent():IsAncient() then
        tick_damage = tick_damage * self:GetAbility():GetSpecialValueFor("creep_multiplier")
    end
	if self:GetCaster():HasModifier("modifier_crystal_maiden_11") then
		tick_damage = tick_damage + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_crystal_maiden_11_damage_agility[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_11")])
	end
    if self:GetCaster():HasModifier("modifier_crystal_maiden_15") and not self:GetParent():IsHero() then
        tick_damage = tick_damage + (tick_damage / 100 * self:GetAbility().modifier_crystal_maiden_15[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_15")])
    end
	self.interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	if IsServer() then
		self.damageTable = {victim = self:GetParent(),attacker = self:GetCaster(),damage = tick_damage*self.interval,damage_type = DAMAGE_TYPE_MAGICAL,ability = self:GetAbility()}
		self:StartIntervalThink( self.interval )
		self:GetParent():EmitSound("hero_Crystal.frostbite")
	end
end

function modifier_crystal_maiden_frostbite_custom:OnRefresh( kv )
	self:OnCreated()
end

function modifier_crystal_maiden_frostbite_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("hero_Crystal.frostbite")
end

function modifier_crystal_maiden_frostbite_custom:CheckState()
	local state = {[MODIFIER_STATE_DISARMED] = true,[MODIFIER_STATE_ROOTED] = true,[MODIFIER_STATE_INVISIBLE] = false}
	return state
end

function modifier_crystal_maiden_frostbite_custom:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

function modifier_crystal_maiden_frostbite_custom:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_crystal_maiden_frostbite_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_crystal_maiden_frostbite_custom_passive = class({})

function modifier_crystal_maiden_frostbite_custom_passive:IsHidden() return true end
function modifier_crystal_maiden_frostbite_custom_passive:IsPurgable() return false end

function modifier_crystal_maiden_frostbite_custom_passive:DeclareFunctions()
	return {
		 
	}
end

function modifier_crystal_maiden_frostbite_custom_passive:OnTakeDamage(params)
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
	if not self:GetParent():HasModifier("modifier_crystal_maiden_9") then return end
	if self:GetParent():HasModifier("modifier_crystal_maiden_frostbite_custom_cooldown") then return end
	if self:GetParent():HasModifier("modifier_wodarelax") then return end
	if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
	if not params.attacker:IsHero() then return end
	if params.attacker:HasModifier("modifier_wodarelax") then return end
	if params.attacker:HasModifier("modifier_wodawispdeath_wisp") then return end
	if params.attacker:HasModifier("modifier_wodawisp") then return end
    if params.attacker:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
	self:GetAbility():OnSpellStart(params.attacker)
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_crystal_maiden_frostbite_custom_cooldown", {duration = self:GetAbility().modifier_crystal_maiden_9_cooldown[self:GetCaster():GetTalentLevel("modifier_crystal_maiden_9")]})
end

modifier_crystal_maiden_frostbite_custom_cooldown = class({})

function modifier_crystal_maiden_frostbite_custom_cooldown:IsPurgable() return false end
function modifier_crystal_maiden_frostbite_custom_cooldown:IsDebuff() return true end

-- Талант магического иммунитета

modifier_crystal_maiden_frostbite_custom_magic_immune = class({})

function modifier_crystal_maiden_frostbite_custom_magic_immune:IsPurgable() return false end

function modifier_crystal_maiden_frostbite_custom_magic_immune:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_crystal_maiden_frostbite_custom_magic_immune:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_crystal_maiden_frostbite_custom_magic_immune:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_crystal_maiden_frostbite_custom_magic_immune:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_crystal_maiden_frostbite_custom_magic_immune:StatusEffectPriority()
    return 99999
end