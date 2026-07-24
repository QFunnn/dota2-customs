--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_undying_reincarnate", "heroes/hero_undying/reincarnate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_undying_reincarnate_buff", "heroes/hero_undying/reincarnate", LUA_MODIFIER_MOTION_NONE )

if ability_undying_reincarnate == nil then
	ability_undying_reincarnate = class({})
end

function ability_undying_reincarnate:GetIntrinsicModifierName()
	return "modifier_ability_undying_reincarnate"
end

function ability_undying_reincarnate:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_tower_destruction_lv.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_scepter_tomb_enter.vpcf", context)
end

function ability_undying_reincarnate:IsRefreshable()
	return false
end

modifier_ability_undying_reincarnate = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	RemoveOnDeath           = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MIN_HEALTH,
			MODIFIER_EVENT_ON_DAMAGE_HPLOSS
        }
    end,
})

function modifier_ability_undying_reincarnate:GetMinHealth()
	if self:IsReady() then
		return 1
	end
	return 0
end

function modifier_ability_undying_reincarnate:IsReady()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	
	if parent and parent:IsAlive() and ability and ability:IsCooldownReady() and ability:GetLevel() > 0 and ability:IsActivated() then
		return true
	end
	return false
end

function modifier_ability_undying_reincarnate:OnDamageHPLoss(event)
	self:Reincarnate(event)
end

function modifier_ability_undying_reincarnate:TakeDamageScriptModifier(event)
	self:Reincarnate(event)
end

function modifier_ability_undying_reincarnate:Reincarnate(event)
	local ability = self:GetAbility()
	local parent = self:GetParent()
	local target = event.unit
	if self:IsReady() and target and target == parent and parent:GetHealth() == 1 and not parent:HasModifier("modifier_dazzle_shallow_grave") then
		ability:UseResources(false, false, false, true)

		parent:Purge(false, true, false, true, true)

		parent:SetHealth(parent:GetMaxHealth())
		parent:SetMana(parent:GetMaxMana())

		if IsServer() then
			EmitSoundOn("Hero_Undying.RelentlessReturn.Trigger", parent)

			local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_tower_destruction_lv.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
			ParticleManager:SetParticleControl(fx, 1, parent:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(fx)

			fx = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_scepter_tomb_enter.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
			ParticleManager:SetParticleControl(fx, 1, parent:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(fx)

			parent:AddNewModifier(parent, ability, "modifier_ability_undying_reincarnate_buff", {duration=0.1})
		end
	end
end

modifier_ability_undying_reincarnate_buff = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        }
    end,

	GetModifierIncomingDamage_Percentage 	= function(self)
		return -100
	end,
})