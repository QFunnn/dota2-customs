--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_nether_swap_custom", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_nether_swap_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_nether_swap_passive", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_nether_swap_custom", LUA_MODIFIER_MOTION_NONE)

vengefulspirit_nether_swap_custom = class({})

function vengefulspirit_nether_swap_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_nether_swap_target.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", context )
end

vengefulspirit_nether_swap_custom.modifier_vengefulspirit_3 = 40
vengefulspirit_nether_swap_custom.modifier_vengefulspirit_19 = 600
vengefulspirit_nether_swap_custom.modifier_vengefulspirit_4 = {4,8}
vengefulspirit_nether_swap_custom.modifier_vengefulspirit_11 = {100,200}

function vengefulspirit_nether_swap_custom:GetIntrinsicModifierName()
	return "modifier_vengefulspirit_nether_swap_passive"
end

function vengefulspirit_nether_swap_custom:GetCastRange(location, target)
    if self:GetCaster():HasModifier("modifier_vengefulspirit_19") then
        return self.BaseClass.GetCastRange(self, location, target) + self.modifier_vengefulspirit_19
    end
    return self.BaseClass.GetCastRange(self, location, target)
end

function vengefulspirit_nether_swap_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_vengefulspirit_19") then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function vengefulspirit_nether_swap_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target == nil then
		local point = self:GetCursorPosition()
		self:SwapPoint(point)
		return
	end
	self:SwapTarget(target)
end

function vengefulspirit_nether_swap_custom:CastFilterResultTarget( target )
	if target ~= nil and target == self:GetCaster() then
		return UF_FAIL_OTHER
	end
	
	return UnitFilter( target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, self:GetCaster():GetTeamNumber())
end

function vengefulspirit_nether_swap_custom:SwapTarget(target)
	local damage_reduction_duration = self:GetSpecialValueFor("damage_reduction_duration")

	local damage = self:GetSpecialValueFor("damage")

	if target:GetTeam() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then
			return
		end
	end

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = 0.1})
	end

	self:GetCaster():EmitSound("Hero_VengefulSpirit.NetherSwap")
	target:EmitSound("Hero_VengefulSpirit.NetherSwap")

	local caster_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControlEnt(caster_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(caster_pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)

	local target_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap_target.vpcf", PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControlEnt(target_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(target_pfx, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)

	local target_loc = target:GetAbsOrigin()

	local caster_loc = self:GetCaster():GetAbsOrigin()

	FindClearSpaceForUnit(self:GetCaster(), target_loc, true)

	if not target:IsAncient() then
		FindClearSpaceForUnit(target, caster_loc, true)
	end

	GridNav:DestroyTreesAroundPoint(caster_loc, 500, false)

	GridNav:DestroyTreesAroundPoint(target_loc, 500, false)

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = self:GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL})
    else
        target:AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_nether_swap_custom", {duration = damage_reduction_duration})
    end

	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_nether_swap_custom", {duration = damage_reduction_duration})

	if self:GetCaster():HasModifier("modifier_vengefulspirit_4") then
		local health = self:GetCaster():GetMaxHealth() / 100 * self.modifier_vengefulspirit_4[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_4")]
		local mana = self:GetCaster():GetMaxMana() / 100 * self.modifier_vengefulspirit_4[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_4")]
		self:GetCaster():Heal(health, self)
		self:GetCaster():GiveMana(mana)
	end
end

function vengefulspirit_nether_swap_custom:SwapPoint(point)
	local damage_reduction_duration = self:GetSpecialValueFor("damage_reduction_duration")
	self:GetCaster():EmitSound("Hero_VengefulSpirit.NetherSwap")
	local caster_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControlEnt(caster_pfx, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(caster_pfx, 1, point)
	local caster_loc = self:GetCaster():GetAbsOrigin()
	FindClearSpaceForUnit(self:GetCaster(), point, true)
	GridNav:DestroyTreesAroundPoint(caster_loc, 500, false)
	GridNav:DestroyTreesAroundPoint(point, 500, false)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_nether_swap_custom", {duration = damage_reduction_duration})
	
	if self:GetCaster():HasModifier("modifier_vengefulspirit_4") then
		local health = self:GetCaster():GetMaxHealth() / 100 * self.modifier_vengefulspirit_4[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_4")]
		local mana = self:GetCaster():GetMaxMana() / 100 * self.modifier_vengefulspirit_4[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_4")]
		self:GetCaster():Heal(health, self)
		self:GetCaster():GiveMana(mana)
	end
end

modifier_vengefulspirit_nether_swap_custom = class({})

function modifier_vengefulspirit_nether_swap_custom:OnCreated(table)
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_swap_buff_overhead.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(self.particle, 0, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.particle, 5, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.particle, false, false, -1, false, false)

    self.barrier = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_vengefulspirit_11") then
        self.barrier = self.barrier + self:GetAbility().modifier_vengefulspirit_11[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_11")]
    end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_vengefulspirit_nether_swap_custom:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_vengefulspirit_nether_swap_custom:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_vengefulspirit_nether_swap_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_vengefulspirit_nether_swap_custom:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end

	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

modifier_vengefulspirit_nether_swap_passive = class({})

function modifier_vengefulspirit_nether_swap_passive:IsHidden() return true end
function modifier_vengefulspirit_nether_swap_passive:IsPurgable() return false end

function modifier_vengefulspirit_nether_swap_passive:DeclareFunctions()
	return {
		 
	}
end

function modifier_vengefulspirit_nether_swap_passive:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if not self:GetParent():IsAlive() then return end
	if self:GetParent():HasModifier("modifier_vengefulspirit_3") then
		self:SetStackCount(self:GetStackCount() + params.damage)
	end
	if self:GetStackCount() >= self:GetParent():GetMaxHealth() / 100 * self:GetAbility().modifier_vengefulspirit_3 then
		if self:GetParent():HasModifier("modifier_vengefulspirit_3") then
			local point = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(100, 600))
			self:GetAbility():SwapPoint(point)
			self:SetStackCount(0)
		end
	end
end



		
		