--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lion_mana_drain_custom", "heroes/npc_dota_hero_lion_custom/lion_mana_drain_custom", LUA_MODIFIER_MOTION_NONE )

lion_mana_drain_custom = class({})

function lion_mana_drain_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lion/lion_spell_mana_drain.vpcf", context )
    PrecacheResource( "particle", "particles/lion_mana_drain_damage.vpcf", context )
end

lion_mana_drain_custom.modifier_lion_1 = {1,2}
lion_mana_drain_custom.modifier_lion_1_mana = {10,20}
lion_mana_drain_custom.modifier_lion_4 = {0.5,1,1.5}
lion_mana_drain_custom.modifier_lion_5 = {7.5,15}
lion_mana_drain_custom.modifiers = {}

function lion_mana_drain_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_lion_7") then
		return "lion_7"
	end
	return "lion_mana_drain"
end

function lion_mana_drain_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_lion_7") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED
end

function lion_mana_drain_custom:GetChannelTime()
    if self:GetCaster():HasModifier("modifier_lion_7") then
        return 0
    end
    return self.BaseClass.GetChannelTime(self)
end

function lion_mana_drain_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb( self ) then
		self:GetCaster():Interrupt()
		return
	end

	local duration = self:GetSpecialValueFor("duration")

	local modifier = target:AddNewModifier( self:GetCaster(), self, "modifier_lion_mana_drain_custom", { duration = duration })
	self.modifiers[modifier] = true

	if self:GetCaster():HasModifier("modifier_lion_1") then
		local heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCastRange( self:GetCaster():GetAbsOrigin(), target ), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)
		local creeps = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCastRange( self:GetCaster():GetAbsOrigin(), target ), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false)

		for i = #heroes, 1, -1 do
	        if heroes[i] ~= nil and (heroes[i] == target) then
	            table.remove(heroes, i)
	        end
	    end

	    for i = #creeps, 1, -1 do
	        if creeps[i] ~= nil and (creeps[i] == target) then
	            table.remove(creeps, i)
	        end
	    end

		local heroes_has = false
		local creep_has = false

		if #heroes > 0 then
			heroes_has = true
		end

		if #creeps > 0 then
			creep_has = true
		end

		if heroes_has then
			local modifier = heroes[1]:AddNewModifier( self:GetCaster(), self, "modifier_lion_mana_drain_custom", { duration = duration })
			self.modifiers[modifier] = true
		elseif creep_has then
			local modifier = creeps[1]:AddNewModifier( self:GetCaster(), self, "modifier_lion_mana_drain_custom", { duration = duration })
			self.modifiers[modifier] = true
		end

		local modifier_lion_1 = self:GetCaster():FindModifierByName("modifier_lion_1")

		if modifier_lion_1 and modifier_lion_1:GetStackCount() > 1 then
			if heroes_has and heroes[2] ~= nil then
				local modifier = heroes[2]:AddNewModifier( self:GetCaster(), self, "modifier_lion_mana_drain_custom", { duration = duration })
				self.modifiers[modifier] = true
			elseif creep_has and creeps[2] ~= nil then
				local modifier = creeps[2]:AddNewModifier( self:GetCaster(), self, "modifier_lion_mana_drain_custom", { duration = duration })
				self.modifiers[modifier] = true
			end
		end
	end

	self:GetCaster():EmitSound("Hero_Lion.ManaDrain")
end

function lion_mana_drain_custom:OnChannelFinish( bInterrupted )

	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			modifier.forceDestroy = bInterrupted
			modifier:Destroy()
		end
	end

	self.modifiers = {}

	self:GetCaster():StopSound("Hero_Lion.ManaDrain")
end

function lion_mana_drain_custom:Unregister( modifier )
	self.modifiers[modifier] = nil

	local counter = 0

	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			counter = counter+1
		end
	end

	if counter == 0 and self:IsChanneling() then
		self:EndChannel( false )
	end
end

modifier_lion_mana_drain_custom = class({})

function modifier_lion_mana_drain_custom:IsPurgable() return false end

function modifier_lion_mana_drain_custom:OnCreated( kv )
	self.mana = self:GetAbility():GetSpecialValueFor( "mana_per_second" )
    if self:GetCaster():HasModifier("modifier_lion_1") then
        self.mana = self.mana + self:GetAbility().modifier_lion_1_mana[self:GetCaster():GetTalentLevel("modifier_lion_1")]
    end
    self.ally_pct = self:GetAbility():GetSpecialValueFor("ally_pct")
	self.radius = self:GetAbility():GetSpecialValueFor( "break_distance" ) + self:GetCaster():GetCastRangeBonus()
	self.slow = self:GetAbility():GetSpecialValueFor( "movespeed" )
	if self:GetCaster():HasModifier("modifier_lion_5") then
		self.slow = self.slow + self:GetAbility().modifier_lion_5[self:GetCaster():GetTalentLevel("modifier_lion_5")]
	end
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        self.slow = self.slow / 100 * self.ally_pct
        self.mana = self.mana / 100 * self.ally_pct
    else
	    self.slow = -self.slow
    end
	self.interval = self:GetAbility():GetSpecialValueFor( "tick_interval" )
	self.mana = self.mana * self.interval
	if IsServer() then
		self:StartIntervalThink( self.interval )
		self:PlayEffects()
	end
end

function modifier_lion_mana_drain_custom:OnDestroy()
	if not IsServer() then return end

	self:GetCaster():StopSound("Hero_Lion.ManaDrain")

	if not self.forceDestroy then
		self:GetAbility():Unregister( self )
	end

	if self:GetParent():IsIllusion() then
		self:GetParent():Kill( self:GetAbility(), self:GetCaster() )
	end
end

function modifier_lion_mana_drain_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_lion_mana_drain_custom:GetModifierMoveSpeedBonus_Percentage()
    local bonus = 0
    if self:GetParent():GetMana() <= 0 and self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        bonus = -self:GetAbility():GetSpecialValueFor("movespeed_bonus_when_empty_pct")
    end
	return self.slow + bonus
end

function modifier_lion_mana_drain_custom:OnIntervalThink()
	if not IsServer() then return end

    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if self:GetParent():IsMagicImmune() or self:GetParent():IsInvulnerable() or self:GetParent():IsIllusion() then
            self:Destroy()
            return
        end
    end

	if not self:GetCaster():IsAlive() then
		self:Destroy()
		return
	end

	if (self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()):Length2D() > self.radius then
		self:Destroy()
		return
	end

	local mana = self:GetParent():GetMana()
	local mana_steal = self.mana
    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        mana = self:GetCaster():GetMana()
    end
	if mana < mana_steal then
		mana_steal = mana
	end

    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if not self:GetCaster():HasModifier("modifier_lion_2") then
            self:GetParent():Script_ReduceMana( mana_steal, self:GetAbility() )
            self:GetCaster():GiveMana( mana_steal )
        end
        if self:GetCaster():HasModifier("modifier_lion_2") then
            local damage = self.mana
            if self:GetCaster():HasModifier("modifier_lion_4") then
                damage = damage + ((self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_lion_4[self:GetCaster():GetTalentLevel("modifier_lion_4")]) * self.interval)
            end
            self:GetCaster():Heal(damage, self:GetAbility())
            ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION })
        end
    else
        if self:GetCaster():HasModifier("modifier_lion_2") then
            if self:GetParent():GetHealthPercent() >= 100 then return end
            local damage = self.mana
            if self:GetCaster():HasModifier("modifier_lion_4") then
                damage = damage + ((self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_lion_4[self:GetCaster():GetTalentLevel("modifier_lion_4")]) * self.interval)
            end
            self:GetCaster():SetHealth(math.max(self:GetCaster():GetHealth() - damage, 1))
            self:GetParent():Heal(damage, self:GetAbility())
        else
            if self:GetParent():GetMana() >= self:GetParent():GetMaxMana() then return end
            local mana_charge = self:GetCaster():Script_ReduceMana(mana_steal, self:GetAbility())
            self:GetParent():GiveMana(mana_charge)
        end
    end
end

function modifier_lion_mana_drain_custom:PlayEffects()
	if not self:GetCaster():HasModifier("modifier_lion_2") then
		local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lion/lion_spell_mana_drain.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
        if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		    ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		    ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", Vector(0,0,0), true )
        else
            ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		    ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", Vector(0,0,0), true )
        end
		self:AddParticle( effect_cast, false, false, -1, false, false )
	else
		local effect_cast = ParticleManager:CreateParticle( "particles/lion_mana_drain_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		    ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		    ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", Vector(0,0,0), true )
        else
            ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		    ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", Vector(0,0,0), true )
        end
		self:AddParticle( effect_cast, false, false, -1, false, false )
	end
end