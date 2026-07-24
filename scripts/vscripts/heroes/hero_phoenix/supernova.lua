--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_phoenix_supernova", "heroes/hero_phoenix/supernova.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_phoenix_supernova_debuff", "heroes/hero_phoenix/supernova.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_phoenix_supernova_hiding", "heroes/hero_phoenix/supernova.lua", LUA_MODIFIER_MOTION_NONE )

if ability_phoenix_supernova == nil then
	ability_phoenix_supernova = class({})
end

function ability_phoenix_supernova:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_hit.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_radiance.vpcf", context)
end

function ability_phoenix_supernova:GetBehavior()
	local caster = self:GetCaster()
	if caster and caster:HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
	end
	return self.BaseClass.GetBehavior(self)
end

function ability_phoenix_supernova:OnAbilityPhaseStart()
	if not IsServer() then
		return
	end
	self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_5)
	return true
end

function ability_phoenix_supernova:OnSpellStart()
	local caster = self:GetCaster()
	local MaxHealth = self:GetSpecialValueFor("max_hero_attacks")
	local Duration = self:GetDuration()

	caster:RemoveModifierByName("modifier_phoenix_sun_ray")

	--Аганим
	local target = nil
	if caster:HasScepter() then
		target = self:GetCursorTarget()
		MaxHealth = self:GetSpecialValueFor("max_hero_attacks_scepter")
	end

	local position = caster:GetAbsOrigin()
	position = GetGroundPosition(position, caster)

	caster:AddNewModifier(caster, self, "modifier_ability_phoenix_supernova_hiding", {})
	
	local iTarget = -1
	if target and target:IsAlive() then
		target:AddNewModifier(caster, self, "modifier_ability_phoenix_supernova_hiding", {})
		iTarget = target:entindex()
	end

	local hEgg = CreateUnitByName("npc_dota_phoenix_sun", position, false, caster, caster:GetOwner(), caster:GetTeamNumber())
	hEgg:AddNewModifier(caster, self, "modifier_ability_phoenix_supernova", {duration = Duration, iTarget=iTarget})
	hEgg:StartGestureWithPlaybackRate(ACT_DOTA_IDLE, 1)

	hEgg:SetBaseMaxHealth(MaxHealth)
	hEgg:SetMaxHealth(MaxHealth)
	hEgg:SetHealth(MaxHealth)
end

modifier_ability_phoenix_supernova = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	IsAura					= function(self) return true end,
	GetModifierAura			= function(self) return "modifier_ability_phoenix_supernova_debuff" end,
	GetAuraDuration			= function(self) return 0.5 end,
	GetAuraRadius			= function(self) return self.Radius or 0 end,
	GetAuraSearchFlags		= function (self) return DOTA_UNIT_TARGET_FLAG_NONE end,
	GetAuraSearchTeam		= function(self) return DOTA_UNIT_TARGET_TEAM_ENEMY end,
	GetAuraSearchType		= function(self) return DOTA_UNIT_TARGET_HEROES_AND_CREEPS end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_HEALTHBAR_PIPS,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
			-- MODIFIER_PROPERTY_VISUAL_Z_DELTA
        }
    end,

	CheckState				= function(self)
		return {
			[MODIFIER_STATE_MAGIC_IMMUNE]=true,
			[MODIFIER_STATE_DEBUFF_IMMUNE]=true,
			[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY]=true,
			-- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
			[MODIFIER_STATE_NO_UNIT_COLLISION]=true,
		}
	end,

	GetAbsoluteNoDamagePhysical = function(self)
		return 1
	end,

	GetAbsoluteNoDamageMagical 	= function(self)
		return 1
	end,

	GetAbsoluteNoDamagePure 	= function(self)
		return 1
	end,

	GetModifierHealthBarPips	= function(self)
		if self:GetParent() then
			return self:GetParent():GetMaxHealth()
		end
		return 1
	end,

	-- GetVisualZDelta = function(self) return self.z_delta end
})

function modifier_ability_phoenix_supernova:OnCreated(table)
	local ability = self:GetAbility()
	if ability then
		self.Radius = ability:GetSpecialValueFor("aura_radius")
		self.StunDuration = ability:GetSpecialValueFor("stun_duration")
	end

	self.Dead = false
	-- self.angles_reduce = (145 / 6) * 0.033
	-- self.z_delta = 350
	-- self.z_reduce = (225 / 6) * 0.033

	if IsServer() then
		if table.iTarget then
			self.iTarget = EntIndexToHScript(table.iTarget)
		end
		local parent = self:GetParent()
		if parent then

			GridNav:DestroyTreesAroundPoint(parent:GetAbsOrigin(), self.Radius or 0, false)

			local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", PATTACH_CUSTOMORIGIN, nil )
			ParticleManager:SetParticleControl(fx, 0, parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt( fx, 1, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
			self:AddParticle(fx, false, false, -1, false, false)

			EmitSoundOn("Hero_Phoenix.SuperNova.Begin", parent)
			EmitSoundOn("Hero_Phoenix.SuperNova.Cast", parent)
		end

		-- self:SetHasCustomTransmitterData(true)

		-- self:StartIntervalThink(0.033)
	end
end

-- function modifier_ability_phoenix_supernova:AddCustomTransmitterData()
-- 	return 
--     {
-- 		z_delta = self.z_delta,
-- 	}
-- end

-- function modifier_ability_phoenix_supernova:HandleCustomTransmitterData(data)
-- 	self.z_delta = data.z_delta
-- end

-- function modifier_ability_phoenix_supernova:OnIntervalThink()
-- 	local parent = self:GetParent()
-- 	if parent and not parent:IsNull() and parent:IsAlive() then
-- 		parent:SetAngles(0, parent:GetAngles().y-self.angles_reduce, 0)
-- 	end
-- 	self.z_delta = self.z_delta - self.z_reduce

-- 	self:SendBuffRefreshToClients()
-- end

function modifier_ability_phoenix_supernova:OnDestroy()
	if not IsServer() then return end
	local hEgg = self:GetParent()

	if hEgg and not hEgg:IsNull() then
		if hEgg:IsAlive() and self.Dead == false then
			local caster = self:GetCaster()
			if caster then
				caster:EmitSound("Hero_Phoenix.SuperNova.Explode")
				local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
				ParticleManager:SetParticleControl( fx, 0, hEgg:GetAbsOrigin() )
				ParticleManager:SetParticleControl( fx, 1, Vector(1.5,1.5,1.5) )
				ParticleManager:SetParticleControl( fx, 3, hEgg:GetAbsOrigin() )
				ParticleManager:ReleaseParticleIndex(fx)

				local enemies = FindUnitsInRadius(caster:GetTeamNumber(),
					hEgg:GetAbsOrigin(),
					nil,
					self.Radius or 0,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
					FIND_ANY_ORDER,
					false )
				for _, enemy in pairs(enemies) do
					enemy:AddNewModifier(caster, self:GetAbility(), "modifier_stunned", {duration=(self.StunDuration or 0) * ( 1 - enemy:GetStatusResistance() )})
				end
			end
		end
		hEgg:AddNoDraw()
		UTIL_Remove(hEgg)
	end

	local caster = self:GetCaster()
	local target = self.iTarget
	if caster and not caster:IsNull() then
		caster:RemoveModifierByName("modifier_ability_phoenix_supernova_hiding")
	end
	if target and not target:IsNull() then
		target:RemoveModifierByName("modifier_ability_phoenix_supernova_hiding")
	end
end

function modifier_ability_phoenix_supernova:AttackLandedModifier(event)
	if not IsServer() then return end

	local hEgg = self:GetParent()

	if hEgg ~= event.target or not event.attacker or not event.attacker:IsRealHero() then return end

	local newHealth = hEgg:GetHealth() - 1
	if newHealth > 0 then
		hEgg:ModifyHealth(newHealth, self, false, 0)
	else
		self.Dead = true
		hEgg:Kill(nil, event.attacker)
	end

	local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_hit.vpcf", PATTACH_POINT_FOLLOW, egg )
	ParticleManager:SetParticleControlEnt( fx, 0, egg, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( fx, 1, egg, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex(fx)
end

function modifier_ability_phoenix_supernova:OnDeathEvent(event)
	if not IsServer() then return end

	local hEgg = self:GetParent()

	if hEgg ~= event.unit or not event.attacker or not event.attacker:IsRealHero() then return end

	if self.Dead == true then
		local caster = self:GetCaster()
		local target = self.iTarget
		if caster then
			caster:Kill(nil, event.attacker)
		end
		if target then
			target:Kill(nil, event.attacker)
		end

		StopSoundOn("Hero_Phoenix.SuperNova.Begin", hEgg)
		StopSoundOn("Hero_Phoenix.SuperNova.Cast", hEgg)

		if caster then
			caster:EmitSound("Hero_Phoenix.SuperNova.Death")

			local fx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf", PATTACH_WORLDORIGIN, nil )
			local attach_point = caster:ScriptLookupAttachment( "attach_hitloc" )
			ParticleManager:SetParticleControl( fx, 0, caster:GetAttachmentOrigin(attach_point) )
			ParticleManager:SetParticleControl( fx, 1, caster:GetAttachmentOrigin(attach_point) )
			ParticleManager:SetParticleControl( fx, 3, caster:GetAttachmentOrigin(attach_point) )
			ParticleManager:ReleaseParticleIndex(fx)
		end
	end
end

modifier_ability_phoenix_supernova_debuff = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return true end,

	GetEffectName			= function(self)
		return "particles/units/heroes/hero_phoenix/phoenix_supernova_radiance.vpcf"
	end,
	GetEffectAttachType		= function(self)
		return PATTACH_ABSORIGIN_FOLLOW
	end,
})

function modifier_ability_phoenix_supernova_debuff:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.DamagePerSec = ability:GetSpecialValueFor("damage_per_sec")
		self.Interval = ability:GetSpecialValueFor("tick_interval")
		self.DamagePerInterval = self.DamagePerSec * self.Interval

		if IsServer() then
			self:StartIntervalThink(self.Interval)
		end
	end
end

modifier_ability_phoenix_supernova_debuff.OnRefresh = modifier_ability_phoenix_supernova_debuff.OnCreated

function modifier_ability_phoenix_supernova_debuff:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if parent and not parent:IsNull() and parent:IsAlive() and caster and not caster:IsNull() and ability and not ability:IsNull() then
		ApplyDamage({
            victim = parent,
            damage = self.DamagePerInterval,
            damage_type = ability:GetAbilityDamageType(),
            damage_flags = DOTA_DAMAGE_FLAG_NONE,
            attacker = caster,
            ability = ability
        })
	end
end

modifier_ability_phoenix_supernova_hiding = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function (self)
        return {
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
			MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        }
    end,

	CheckState				= function(self)
		local State = {
			[MODIFIER_STATE_INVULNERABLE]=true,
			[MODIFIER_STATE_DISARMED]=true,
			[MODIFIER_STATE_ROOTED]=true,
			[MODIFIER_STATE_MUTED]=true,
			[MODIFIER_STATE_OUT_OF_GAME]=true,
			[MODIFIER_STATE_MAGIC_IMMUNE]=true,
			[MODIFIER_STATE_DEBUFF_IMMUNE]=true,
		}
		if self:GetParent() ~= self:GetCaster() then
			State[MODIFIER_STATE_STUNNED] = true
		end

		return State
	end,

	GetAbsoluteNoDamagePhysical = function(self)
		return 1
	end,

	GetAbsoluteNoDamageMagical 	= function(self)
		return 1
	end,

	GetAbsoluteNoDamagePure 	= function(self)
		return 1
	end,
})

function modifier_ability_phoenix_supernova_hiding:OnCreated()
	if not IsServer() then return end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	if parent then
		parent:AddNoDraw()
	end

	for i = 0, parent:GetAbilityCount()-1 do
		local hAbility = parent:GetAbilityByIndex(i)
		if hAbility and hAbility:GetAbilityType() ~= ABILITY_TYPE_ULTIMATE then
			hAbility:EndCooldown()
		end
	end

	parent:Purge(false, true, false, true, true)

	parent:SetHealth( parent:GetMaxHealth() )
	parent:SetMana( parent:GetMaxMana() )

	if parent ~= caster then return end

	self.Abilities = {}

	-- [NP-32] Sun Ray в яйце разрешён ШАРДОМ, а не скипетром: в яйце отключаем все способности,
	-- кроме phoenix_sun_ray при наличии Aghanim's Shard.
	local hasShard = caster:HasModifier("modifier_item_aghanims_shard")
	for i = 0, caster:GetAbilityCount()-1 do
		local hAbility = caster:GetAbilityByIndex(i)
		if hAbility and hAbility:IsActivated() and (not hasShard or (hasShard and hAbility:GetName() ~= "phoenix_sun_ray")) then
			hAbility:SetActivated(false)
			table.insert(self.Abilities, hAbility)
		end
	end
end

function modifier_ability_phoenix_supernova_hiding:OnDestroy()
	if not IsServer() then return end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	if parent then
		parent:RemoveNoDraw()
	end

	if parent ~= caster then 
		FindClearSpaceForUnit(parent, caster:GetAbsOrigin(), true)
		ResolveNPCPositions(caster:GetAbsOrigin(), 150)
		return 
	end

	if self.Abilities then
		for _, ability in pairs(self.Abilities) do
			if ability and not ability:IsNull() and ability._IsDuelDeactivated ~= true then
				ability:SetActivated(true)
			end
		end
	end

	caster:StartGesture(ACT_DOTA_INTRO)
end