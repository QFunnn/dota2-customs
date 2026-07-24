--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_meteor_lens", "items/item_meteor_lens.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_meteor_lens_burn", "items/item_meteor_lens.lua", LUA_MODIFIER_MOTION_NONE)

item_meteor_lens = class({})

function item_meteor_lens:GetIntrinsicModifierName()
	return "modifier_item_meteor_lens"
end

function item_meteor_lens:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function item_meteor_lens:OnSpellStart()
	if not IsServer() then return end
	local position	= self:GetCursorPosition()
	AddFOWViewer(self:GetCaster():GetTeam(), position, self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("land_time")+0.5, false)

	self:GetCaster():EmitSound("DOTA_Item.MeteorHammer.Cast")

	local land_time = self:GetSpecialValueFor("land_time")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local radius = self:GetSpecialValueFor("radius")
	local burn_duration = self:GetSpecialValueFor("burn_duration")
	local start_damage = self:GetSpecialValueFor("start_damage")


	local ground_particle = ParticleManager:CreateParticleForTeam("particles/items4_fx/meteor_hammer_aoe.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeam())
	ParticleManager:SetParticleControl(ground_particle, 0, position)
	ParticleManager:SetParticleControl(ground_particle, 1, Vector(radius, 1, 1))
	
	local caster_particle = ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())




	local meteor_hammer	= ParticleManager:CreateParticle("particles/items4_fx/meteor_hammer_spell.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(meteor_hammer, 0, position + Vector(0, 0, 1000))
	ParticleManager:SetParticleControl(meteor_hammer, 1, position)
	ParticleManager:SetParticleControl(meteor_hammer, 2, Vector(land_time, 0, 0))
	ParticleManager:ReleaseParticleIndex(meteor_hammer)

	Timers:CreateTimer(land_time, function()
		if not self:IsNull() then

			ParticleManager:DestroyParticle(ground_particle, false)
			ParticleManager:DestroyParticle(caster_particle, false)

			GridNav:DestroyTreesAroundPoint(position, radius, true)
			EmitSoundOnLocationWithCaster(position, "DOTA_Item.MeteorHammer.Impact", self:GetCaster())
		
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
			
			for _, enemy in pairs(enemies) do
				enemy:EmitSound("DOTA_Item.MeteorHammer.Damage")

				enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
				enemy:AddNewModifier(self:GetCaster(), self, "modifier_item_meteor_lens_burn", {duration = burn_duration * (1 - enemy:GetStatusResistance())})
				
				ApplyDamage({ victim = enemy, damage = start_damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self })
			end
		end
	end)
end

modifier_item_meteor_lens = class({})

function modifier_item_meteor_lens:IsHidden()			return true end
function modifier_item_meteor_lens:IsPurgable() return false end
function modifier_item_meteor_lens:IsPurgeException() return false end
function modifier_item_meteor_lens:RemoveOnDeath()	return false end
function modifier_item_meteor_lens:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_meteor_lens:DeclareFunctions()
    local decFuncs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE_UNIQUE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
    }
	
    return decFuncs
end

function modifier_item_meteor_lens:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_meteor_lens:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_meteor_lens:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agi")
end

function modifier_item_meteor_lens:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_meteor_lens:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_meteor_lens:GetModifierCastRangeBonus()
	return self:GetAbility():GetSpecialValueFor("cast_range_bonus")
end


function modifier_item_meteor_lens:GetModifierSpellAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_spell_damage")
end

function modifier_item_meteor_lens:GetModifierMPRegenAmplify_Percentage_Unique()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_amp")
end

function modifier_item_meteor_lens:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_spell_lifesteal_amp")
end







modifier_item_meteor_lens_burn = class({})

function modifier_item_meteor_lens_burn:GetEffectName()
	return "particles/items4_fx/meteor_hammer_spell_debuff.vpcf"
end

function modifier_item_meteor_lens_burn:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("burn_interval"))
end

function modifier_item_meteor_lens_burn:OnIntervalThink()
	if not IsServer() then return end	
	local damage_in = ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("burn_dps_units"), damage_type = DAMAGE_TYPE_MAGICAL})
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), damage_in, nil)
end

function modifier_item_meteor_lens_burn:DeclareFunctions()
    local decFuncs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS 
    }
	
    return decFuncs
end

function modifier_item_meteor_lens_burn:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magical_resistance")
end