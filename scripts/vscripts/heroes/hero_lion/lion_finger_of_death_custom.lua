--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lion_finger_of_death_custom", "heroes/hero_lion/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_finger_of_death_custom_buff", "heroes/hero_lion/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_finger_of_death_custom_passive", "heroes/hero_lion/lion_finger_of_death_custom", LUA_MODIFIER_MOTION_NONE )

lion_finger_of_death_custom = class({})

lion_finger_of_death_custom.bRoundDueled = false

function lion_finger_of_death_custom:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "splash_radius_scepter" )
	end

	return 0
end

function lion_finger_of_death_custom:Spawn()
	if not IsServer() then return end
	Timers:CreateTimer(0.1, function()
		if self:GetCaster():IsAlive() then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lion_finger_of_death_custom_passive", {})
		else
			return 0.1
		end
	end)
end

function lion_finger_of_death_custom:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

function lion_finger_of_death_custom:GetIntrinsicModifierName()
	return "modifier_lion_finger_of_death_custom_passive"
end

function lion_finger_of_death_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	self:GetCaster():EmitSound("Hero_Lion.FingerOfDeath")

	if target:TriggerSpellAbsorb(self) then
		self:DamageParticle( target )
		return 
	end

	local delay = self:GetSpecialValueFor("damage_delay")
	local radius = self:GetSpecialValueFor("splash_radius_scepter")

	if self:GetCaster():HasScepter() then
		local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(targets) do
			enemy:AddNewModifier( self:GetCaster(), self, "modifier_lion_finger_of_death_custom", { duration = delay } )
			self:DamageParticle( enemy )
		end
	else
		target:AddNewModifier( self:GetCaster(), self, "modifier_lion_finger_of_death_custom", { duration = delay } )
		self:DamageParticle( target )
	end

    local punch_duration = self:GetSpecialValueFor("punch_duration")
    if punch_duration > 0 then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lion_finger_punch", {duration = punch_duration})
    end
end

function lion_finger_of_death_custom:DamageParticle( target )
	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	local direction = (self:GetCaster():GetAbsOrigin()-target:GetAbsOrigin()):Normalized()
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, attach, Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( particle, 2, target:GetAbsOrigin() )
	ParticleManager:SetParticleControl( particle, 3, target:GetAbsOrigin() + direction )
	ParticleManager:SetParticleControlForward( particle, 3, -direction )
	ParticleManager:ReleaseParticleIndex( particle )
	target:EmitSound("Hero_Lion.FingerOfDeathImpact")
end

modifier_lion_finger_of_death_custom_passive = class({})

--function modifier_lion_finger_of_death_custom_passive:IsHidden() return self:GetStackCount() == 0 end
function modifier_lion_finger_of_death_custom_passive:IsPurgable() return false end
function modifier_lion_finger_of_death_custom_passive:RemoveOnDeath() return false end
function modifier_lion_finger_of_death_custom_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end
function modifier_lion_finger_of_death_custom_passive:OnTooltip()
	return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("damage_per_kill")
end

function modifier_lion_finger_of_death_custom_passive:GetModifierHealthBonus()
	return self:GetStackCount() * self:GetCaster():FindTalentValue("special_bonus_unique_lion_11")
end

modifier_lion_finger_of_death_custom_buff = class({})

function modifier_lion_finger_of_death_custom_buff:IsHidden() return true end
function modifier_lion_finger_of_death_custom_buff:IsPurgable() return false end

function modifier_lion_finger_of_death_custom_buff:OnDeathEvent(params)
	if params.unit ~= self:GetParent() then return end

	if not self:GetParent():IsHero() then
		if self:GetAbility().bRoundDueled == true then return end
		self:GetAbility().bRoundDueled = true
	end

	local modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if modifier then
		-- Проверяем аспект Fist of Death через значения способности
		-- Если у способности есть punch_duration > 0, значит аспект активен
		local punch_duration = self:GetAbility():GetSpecialValueFor("punch_duration")
		local has_fist_of_death = punch_duration > 0
		local is_hero_kill = self:GetParent():IsRealHero()
		
		-- Если есть аспект Fist of Death и это убийство героя - даем 3 заряда вместо 1
		if has_fist_of_death and is_hero_kill then
			modifier:SetStackCount(modifier:GetStackCount() + 3)
		else
			modifier:IncrementStackCount()
		end
	end
end

modifier_lion_finger_of_death_custom = class({})

function modifier_lion_finger_of_death_custom:IsHidden()
	return true
end

function modifier_lion_finger_of_death_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_lion_finger_of_death_custom:IsPurgable()
	return false
end

function modifier_lion_finger_of_death_custom:OnCreated( kv )
	if not IsServer() then return end
	local grace_period = self:GetAbility():GetSpecialValueFor("grace_period")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lion_finger_of_death_custom_buff", {duration = grace_period})
	local bonus_damage = 0
	local bonus_damage_modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if bonus_damage_modifier then
		bonus_damage = bonus_damage + ( self:GetAbility():GetSpecialValueFor("damage_per_kill") * bonus_damage_modifier:GetStackCount() )
	end
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) + bonus_damage
end

function modifier_lion_finger_of_death_custom:OnRefresh( kv )
	if not IsServer() then return end
	local grace_period = self:GetAbility():GetSpecialValueFor("grace_period")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lion_finger_of_death_custom_buff", {duration = grace_period})
	local bonus_damage = 0
	local bonus_damage_modifier = self:GetCaster():FindModifierByName("modifier_lion_finger_of_death_custom_passive")
	if bonus_damage_modifier then
		bonus_damage = bonus_damage + ( self:GetAbility():GetSpecialValueFor("damage_per_kill") * bonus_damage_modifier:GetStackCount() )
	end
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) + bonus_damage
end

function modifier_lion_finger_of_death_custom:OnDestroy( kv )
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then return end
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end