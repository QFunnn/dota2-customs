--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



item_saw_wheel = class({})

LinkLuaModifier("modifier_item_saw_wheel", "items/item_saw_wheel", LUA_MODIFIER_MOTION_NONE)

function item_saw_wheel:GetIntrinsicModifierName()
	return "modifier_item_saw_wheel"
end


function item_saw_wheel:OnSpellStart()
      
    if IsServer() then

    	self:GetCaster():EmitSound("Hero_Shredder.WhirlingDeath.Cast")

		local nParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_shredder/shredder_whirling_death.vpcf", PATTACH_CENTER_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControlEnt(nParticle, 1, self:GetCaster(), PATTACH_CENTER_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(nParticle)
    
        local flRadius = self:GetSpecialValueFor("whirling_radius")
	    local trees = GridNav:GetAllTreesAroundPoint(self:GetCaster():GetAbsOrigin(), flRadius, false)
	    local nTreeNumber = #trees
	    
	    for _, hEnemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, flRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)) do
            
            local flDamage = self:GetSpecialValueFor("damage")
            
            --如果有树，伤害并且眩晕
            if nTreeNumber>0 and DOTA_UNIT_CAP_MELEE_ATTACK==self:GetCaster():GetAttackCapability() then
               flDamage = self:GetSpecialValueFor("damage_with_tree")
               hEnemy:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = self:GetSpecialValueFor("stun_with_tree") } )
            end

			ApplyDamage({
				victim 			= hEnemy,
				damage 			= flDamage,
				damage_type		= self:GetAbilityDamageType(),
				damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
				attacker 		= self:GetCaster(),
				ability 		= self
			})
		end

		if DOTA_UNIT_CAP_MELEE_ATTACK==self:GetCaster():GetAttackCapability() then
	       GridNav:DestroyTreesAroundPoint(self:GetCaster():GetAbsOrigin(), self:GetSpecialValueFor("whirling_radius"), false)
	    end
	    
    end

end



modifier_item_saw_wheel = class({})

function modifier_item_saw_wheel:IsDebuff() return false end
function modifier_item_saw_wheel:IsHidden() return true end
function modifier_item_saw_wheel:IsPurgable() return false end
function modifier_item_saw_wheel:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_saw_wheel:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_item_saw_wheel:GetModifierPreAttack_BonusDamage(params)
	local bonus = self:GetAbility():GetSpecialValueFor("bonus_dmg")
	if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "item_saw_wheel", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end

function modifier_item_saw_wheel:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_attributes")
end
function modifier_item_saw_wheel:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_attributes")
end
function modifier_item_saw_wheel:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_attributes")
end