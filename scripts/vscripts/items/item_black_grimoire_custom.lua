--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_black_grimoire_custom", "items/item_black_grimoire_custom", LUA_MODIFIER_MOTION_NONE )

if item_black_grimoire_custom == nil then
	item_black_grimoire_custom = class({})
end

function item_black_grimoire_custom:GetIntrinsicModifierName()
	return "modifier_item_black_grimoire_custom"
end

function item_black_grimoire_custom:OnSpellStart()
	local Stacks = self:GetCurrentCharges()
	local XpPerStack = self:GetSpecialValueFor("xp_per_charge")
	
	local caster = self:GetCaster()

	caster:AddExperience(XpPerStack*Stacks, DOTA_ModifyXP_HeroAbility, false, false)
end

modifier_item_black_grimoire_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	RemoveOnDeath           = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_EVENT_ON_DEATH
        }
    end,
})

function modifier_item_black_grimoire_custom:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.ChargesPerHero = ability:GetSpecialValueFor("charges_per_hero")
		self.ChargesPerCreep = ability:GetSpecialValueFor("charges_per_creep")

		if IsServer() then
			ability:SetCurrentCharges(ability:GetCurrentCharges()+1)
		end
	end
end

function modifier_item_black_grimoire_custom:OnDeath(event)
	local target = event.unit
	local attacker = event.attacker
	local parent = self:GetParent()
	local ability = self:GetAbility()
	print(target, attacker, parent, ability)

	if target and attacker and parent and ability and not target:IsIllusion() and not target:IsStrongIllusion() and not target:IsTempestDouble() and not target:IsClone() then
		local RealAttacker = GetRealUnit(attacker)
		print(RealAttacker)
		if RealAttacker and RealAttacker == parent then
			local Stacks = target:IsRealHero() and self.ChargesPerHero or self.ChargesPerCreep
			if Stacks == nil then
				Stacks = 1
			end

			ability:SetCurrentCharges(ability:GetCurrentCharges()+Stacks)
		end
	end
end