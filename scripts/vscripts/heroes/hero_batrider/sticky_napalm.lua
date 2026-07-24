--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_batrider_sticky_napalm", "heroes/hero_batrider/sticky_napalm", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_batrider_sticky_napalm_cast", "heroes/hero_batrider/sticky_napalm", LUA_MODIFIER_MOTION_NONE )

if ability_batrider_sticky_napalm == nil then
	ability_batrider_sticky_napalm = class({})
end

function ability_batrider_sticky_napalm:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_napalm_damage_debuff.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_stickynapalm.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_stickynapalm_stack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_stickynapalm_debuff.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_batrider/batrider_stickynapalm_impact.vpcf", context)
end

function ability_batrider_sticky_napalm:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function ability_batrider_sticky_napalm:GetIntrinsicModifierName()
	return "modifier_ability_batrider_sticky_napalm_cast"
end

function ability_batrider_sticky_napalm:OnSpellStart()
	local caster = self:GetCaster()
	local Radius = self:GetSpecialValueFor("radius")
	local Duration = self:GetSpecialValueFor("duration")
	local Damage = self:GetSpecialValueFor("application_damage")

	local point = self:GetCursorPosition()

	local Units = FindUnitsInRadius(
        caster:GetTeamNumber(), 
        point, 
        nil, 
        Radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
        DOTA_UNIT_TARGET_FLAG_NONE, 
        FIND_ANY_ORDER, 
        false
    )

	for _, unit in ipairs(Units) do
		unit:AddNewModifier(caster, self, "modifier_ability_batrider_sticky_napalm", {duration=Duration})

		ApplyDamage({
            victim = unit,
            damage = Damage,
            damage_type = self:GetAbilityDamageType(),
            damage_flags = DOTA_DAMAGE_FLAG_NONE,
            attacker = caster,
            ability = self
        })
	end

	caster:EmitSound("Hero_Batrider.StickyNapalm.Cast")
	caster:EmitSound("Hero_Batrider.StickyNapalm.Impact")

	local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_batrider/batrider_stickynapalm_impact.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(fx, 0, point)
	ParticleManager:SetParticleControl(fx, 1, Vector(Radius, 0, 0))
	ParticleManager:SetParticleControl(fx, 2, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(fx)

	AddFOWViewer(caster:GetTeamNumber(), point, 400, 2, false)
end

modifier_ability_batrider_sticky_napalm = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
			MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
			MODIFIER_PROPERTY_TOOLTIP,
        }
    end,

    GetModifierMagicalResistanceBonus       = function(self) return -(self.ReducePerStack or 0) * self:GetStackCount() end,
    GetModifierMoveSpeedBonus_Percentage       = function(self) return -(self.Movespeed or 0) * self:GetStackCount() end,
    GetModifierTurnRate_Percentage       = function(self) return -(self.TurnRate or 0) end,

	GetEffectName			= function(self)
		return "particles/units/heroes/hero_batrider/batrider_stickynapalm_debuff.vpcf"
	end,
	GetStatusEffectName			= function(self)
		return "particles/status_fx/status_effect_stickynapalm.vpcf"
	end,
})

function modifier_ability_batrider_sticky_napalm:OnCreated(table)
    self:UpdateKV(table)

	self.non_trigger_inflictors = {
		["ability_batrider_sticky_napalm"] = true,
		
		["item_radiance"] = true,
		["item_orb_of_venom"] = true,
		
		["item_urn_of_shadows_custom"] = true,
		["item_spirit_vessel_custom"] = true,
	}

	if IsServer() then
		self.FxStack = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_batrider/batrider_stickynapalm_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber())
		ParticleManager:SetParticleControl(self.FxStack, 1, Vector(math.floor(self:GetStackCount() / 10), self:GetStackCount() % 10, 0))
		self:AddParticle(self.FxStack, false, false, -1, false, false)

		self.FxStatus = ParticleManager:CreateParticle("particles/status_fx/status_effect_stickynapalm.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(self.FxStatus, 1, Vector( 1, self:GetStackCount() / 10, -1 ))
		self:AddParticle(self.FxStatus, false, true, 13, false, false)
	end
end

function modifier_ability_batrider_sticky_napalm:OnRefresh(table)
    self:UpdateKV(table)

	if IsServer() and self.FxStack and self.FxStatus then
		ParticleManager:SetParticleControl(self.FxStack, 1, Vector(math.floor(self:GetStackCount() / 10), self:GetStackCount() % 10, 0))
		ParticleManager:SetParticleControl(self.FxStatus, 1, Vector( 1, self:GetStackCount() / 10, -1 ) )
	end
end

function modifier_ability_batrider_sticky_napalm:UpdateKV(table)
    local ability = self:GetAbility()
    if ability then
        self.ReducePerStack = ability:GetSpecialValueFor("magical_resistance_reduce_per_stack")
        self.Movespeed = ability:GetSpecialValueFor("movement_speed_pct")
        self.TurnRate = ability:GetSpecialValueFor("turn_rate_pct")
        self.StackPerRefresh = ability:GetSpecialValueFor("stacks_per_cast")
        self.MaxStacks = ability:GetSpecialValueFor("max_stacks")
        self.UnlimitedStacks = ability:GetSpecialValueFor("unlimited_stacks")
        self.CreepDmg = ability:GetSpecialValueFor("creep_damage_pct")
        self.Damage = ability:GetSpecialValueFor("damage")
    end

	if IsServer() then
		local NewStacks = self:GetStackCount() + (self.StackPerRefresh or 0)
		if table and table.count ~= nil then
			NewStacks = self:GetStackCount() + table.count
		end
		if NewStacks > self.MaxStacks and self.UnlimitedStacks == 0 then
			NewStacks = self.MaxStacks
		end
		self:SetStackCount(NewStacks)
	end
end

function modifier_ability_batrider_sticky_napalm:TakeDamageScriptModifier(event)
	local attacker = event.attacker
	local caster = self:GetCaster()
	local unit = event.unit
	local parent = self:GetParent()
	local inflictor = event.inflictor
	local damage_flags = event.damage_flags
	local ability = self:GetAbility()

	if ability and attacker == caster and unit == parent and (not inflictor or not self.non_trigger_inflictors[inflictor:GetName()]) and bit:_and(damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then
		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_batrider/batrider_napalm_damage_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:ReleaseParticleIndex(fx)

		local Damage = self.Damage * self:GetStackCount()
		
		if not self:GetParent():IsHero() then
			Damage = Damage * 0.01 * self.CreepDmg
		end
		
		ApplyDamage({
            victim = parent,
            damage = Damage,
            damage_type = ability:GetAbilityDamageType(),
            damage_flags = DOTA_DAMAGE_FLAG_NONE,
            attacker = caster,
            ability = ability
        })
	end
end

function modifier_ability_batrider_sticky_napalm:OnTooltip()
	local Damage = (self.Damage or 0) * self:GetStackCount()
		
	if not self:GetParent():IsHero() then
		Damage = Damage * 0.01 * (self.CreepDmg or 0)
	end

	return Damage
end

modifier_ability_batrider_sticky_napalm_cast = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
			MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
			MODIFIER_PROPERTY_DISABLE_TURNING,
			MODIFIER_EVENT_ON_MODIFIER_ADDED,
			MODIFIER_EVENT_ON_ATTACK_LANDED,
        }
    end,

    GetModifierIgnoreCastAngle       = function(self) return self:GetStackCount() end,
    GetModifierDisableTurning       = function(self) return self:GetStackCount() end,
})

-- R20 талант (special_bonus_unique_batrider_6): каждая атака Batrider'а кладёт
-- +napalm_stacks_on_attack стаков Sticky Napalm на цель. Без этого хука и
-- соответствующего поля в KV (napalm_stacks_on_attack) талант ничего не делал.
function modifier_ability_batrider_sticky_napalm_cast:OnAttackLanded(event)
	if not IsServer() then return end
	local caster = self:GetCaster()
	if event.attacker ~= caster then return end

	local target = event.target
	if not target or target:IsNull() then return end
	if target:GetTeamNumber() == caster:GetTeamNumber() then return end
	if target:IsBuilding() or target:IsTower() or target:IsOther() then return end
	if not target:IsAlive() then return end

	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end

	local Stacks = ability:GetSpecialValueFor("napalm_stacks_on_attack")
	if not Stacks or Stacks <= 0 then return end

	local Duration = ability:GetSpecialValueFor("duration")
	target:AddNewModifier(caster, ability, "modifier_ability_batrider_sticky_napalm", {duration = Duration, count = Stacks})
end

function modifier_ability_batrider_sticky_napalm_cast:OnOrderCast(keys)
	if not IsServer() or keys.unit ~= self:GetParent() then return end
	
	if keys.ability == self:GetAbility() then
		if keys.order_type == DOTA_UNIT_ORDER_CAST_POSITION and (keys.new_pos - self:GetCaster():GetAbsOrigin()):Length2D() <= self:GetAbility():GetEffectiveCastRange(self:GetCaster():GetCursorPosition(), self:GetCaster()) then
			self:SetStackCount(1)
		else
			self:SetStackCount(0)
		end
	else
		self:SetStackCount(0)
	end
end

function modifier_ability_batrider_sticky_napalm_cast:OnModifierAdded(event)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	local unit = event.unit
	local buff = event.added_buff

	local buffCaster = buff:GetCaster()
	local buffAbility = buff:GetAbility()

	if caster and ability and unit and caster == buffCaster and buffAbility and buffAbility:GetName() == "batrider_flamebreak" and caster:HasAbility("batrider_flamebreak") and buff:GetName() == "modifier_flamebreak_damage" then
		local Duration = ability:GetSpecialValueFor("duration")
		local Stacks = ability:GetSpecialValueFor("stacks_on_flamebreak")
		if Stacks > 0 then
			unit:AddNewModifier(caster, ability, "modifier_ability_batrider_sticky_napalm", {duration=Duration, count=Stacks})
		end
	end
end