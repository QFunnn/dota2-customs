--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_manta_style_2", "items/item_manta_style_2", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_manta_style_2_invulnerable", "items/item_manta_style_2", LUA_MODIFIER_MOTION_NONE )

if item_manta_style_2 == nil then
	item_manta_style_2 = class({})
end

function item_manta_style_2:GetIntrinsicModifierName()
	return "modifier_item_manta_style_2"
end

function item_manta_style_2:OnSpellStart()
	local caster = self:GetCaster()

	caster:EmitSound("DOTA_Item.Manta.Activate")
	caster:Purge(false, true, false, true, true)
	caster:AddNewModifier(caster, self, "modifier_item_manta_style_2_invulnerable", {duration = self:GetSpecialValueFor("invuln_duration")})
end

---------------------------------------------------------------------

modifier_item_manta_style_2 = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
			MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		}
	end,

	GetModifierBonusStats_Agility			= function(self) return self.Agility or 0 end,
	GetModifierBonusStats_Strength			= function(self) return self.Strength or 0 end,
	GetModifierBonusStats_Intellect			= function(self) return self.Intellect or 0 end,
	GetModifierMoveSpeedBonus_Percentage_Unique	= function(self) return self.Movespeed or 0 end,
	GetModifierAttackSpeedBonus_Constant	= function(self) return self.Attackspeed or 0 end,

	OnCreated				= function(self)
		local Ability = self:GetAbility()
		if Ability then
			self.Movespeed = Ability:GetSpecialValueFor("bonus_movement_speed")
			self.Attackspeed = Ability:GetSpecialValueFor("bonus_attack_speed")
			self.Agility = Ability:GetSpecialValueFor("bonus_agility")
			self.Strength = Ability:GetSpecialValueFor("bonus_strength")
			self.Intellect = Ability:GetSpecialValueFor("bonus_intellect")
		end
	end
})

modifier_item_manta_style_2_invulnerable = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end,

	GetEffectName			= function(self) return "particles/items2_fx/manta_phase.vpcf" end,

	CheckState              = function(self) 
        return {
            [MODIFIER_STATE_INVULNERABLE]		= true,
			[MODIFIER_STATE_NO_HEALTH_BAR]		= true,
			[MODIFIER_STATE_STUNNED]			= true,
			[MODIFIER_STATE_OUT_OF_GAME]		= true,
			[MODIFIER_STATE_NO_UNIT_COLLISION]	= true
        }
    end,

	OnCreated				= function(self)
		local Ability = self:GetAbility()
		if Ability then
			self.IllusCount = Ability:GetSpecialValueFor("illusion_count")
			self.IllusDuration = Ability:GetSpecialValueFor("illusion_duration")

			self.IllusDamageMelee = Ability:GetSpecialValueFor("illusion_damage_melee")
			self.IllusDamageRanged = Ability:GetSpecialValueFor("illusion_damage_ranged")
			self.IllusDamageTake = Ability:GetSpecialValueFor("illusion_damage_take")
		end
	end,

	OnDestroy				= function(self)
		local parent = self:GetParent()
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		if not IsServer() or not parent:IsAlive() or not ability then return end

		parent:Stop()

		--Удаление прошлых иллюзий
		if ability.manta_illusions then
			for _, illusion in pairs(ability.manta_illusions) do
				if illusion and not illusion:IsNull() then
					illusion:ForceKill(false)
				end
			end
		end
		
		for _, mod in pairs(caster:FindAllModifiersByName("modifier_item_manta_style_2")) do
			if mod:GetAbility() and mod:GetAbility() ~= ability and mod:GetAbility().manta_illusions then
				for _, illusion in pairs(mod:GetAbility().manta_illusions) do
					if illusion and not illusion:IsNull() then
						illusion:ForceKill(false)
					end
				end
			end
		end

		ability.manta_illusions = {}

		local Damage = self.IllusDamageMelee
		if parent:IsRangedAttacker() then
			Damage = self.IllusDamageRanged
		end

		local Padding = 72
		if parent:GetHullRadius() > 8 then
			Padding = 108
		end

		local Illusions = CreateIllusions(
			caster,
			caster, 
			{
				outgoing_damage 			= Damage - 100,
				incoming_damage				= self.IllusDamageTake - 100,
				bounty_base					= parent:GetLevel() * 2,
				bounty_growth				= nil,
				outgoing_damage_structure	= nil,
				outgoing_damage_roshan		= nil,
				duration					= self.IllusDuration
			},
			self.IllusCount,
			Padding,
			true,
			true
		)

		ability.manta_illusions = Illusions
	end,
})