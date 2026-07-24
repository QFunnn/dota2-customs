--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_disruptor_aeon", "heroes/hero_disruptor/aeon", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_disruptor_aeon_buff", "heroes/hero_disruptor/aeon", LUA_MODIFIER_MOTION_NONE )

if ability_disruptor_aeon == nil then
	ability_disruptor_aeon = class({})
end

function ability_disruptor_aeon:GetIntrinsicModifierName()
	return "modifier_ability_disruptor_aeon"
end

function ability_disruptor_aeon:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_pulse_knockback_area.vpcf", context)
end

function ability_disruptor_aeon:IsRefreshable()
	return false
end

modifier_ability_disruptor_aeon = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
        }
    end,
})

function modifier_ability_disruptor_aeon:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.Duration = ability:GetSpecialValueFor("buff_duration")
		self.Threshold = ability:GetSpecialValueFor("health_threshold_pct")
	end
end

modifier_ability_disruptor_aeon.OnRefresh = modifier_ability_disruptor_aeon.OnCreated

function modifier_ability_disruptor_aeon:GetModifierIncomingDamage_Percentage(event)
	local attacker = event.attacker
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local damage_flags = event.damage_flags
	local damage = event.damage
	if ability and ability:IsCooldownReady() and attacker ~= parent and not parent:HasModifier("modifier_ability_disruptor_aeon_buff") and not parent:IsIllusion() then
		local CurrentHealth = parent:GetHealth()
		local HealthThreshold = parent:GetMaxHealth() * 0.01 * self.Threshold

		local ResultHealth = math.max(CurrentHealth - damage, 0)
		
		if ResultHealth <= HealthThreshold and bit:_and(damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS then
			parent:Purge( false, true, false, true, true )
			parent:AddNewModifier(parent, ability, "modifier_ability_disruptor_aeon_buff", {duration = self.Duration})
			
			parent:SetHealth(math.min(CurrentHealth, HealthThreshold))
			
			ability:UseResources(false, false, false, true)
			
			return -100
		end
	end
end

modifier_ability_disruptor_aeon_buff = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
			MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
			MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        }
    end,

	GetModifierStatusResistanceStacking		= function(self)
		return self.StatusResist or 0
	end,
	GetModifierIncomingDamage_Percentage 	= function(self)
		return -100
	end,
	GetModifierTotalDamageOutgoing_Percentage	= function(self)
		return -100
	end
})

function modifier_ability_disruptor_aeon_buff:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.StatusResist = ability:GetSpecialValueFor("status_resistance")
	end

	if IsServer() then
		self:GetParent():EmitSound("DOTA_Item.ComboBreaker")
		self:GetParent():EmitSound("Hero_Disruptor.Innate.Knockback")
		local fx = ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(fx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
		self:AddParticle(fx, false, false, -1, true, false)

		local fx2 = ParticleManager:CreateParticle("particles/units/heroes/hero_disruptor/disruptor_pulse_knockback_area.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(fx2, 2, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(fx2, 7, Vector(300, 0, 0))
		ParticleManager:ReleaseParticleIndex(fx2)
	end
end