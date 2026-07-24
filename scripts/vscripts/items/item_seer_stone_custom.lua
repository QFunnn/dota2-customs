--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_seer_stone_custom", "items/item_seer_stone_custom", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier( "modifier_item_seer_stone_custom_thinker", "items/item_seer_stone_custom", LUA_MODIFIER_MOTION_NONE )

item_seer_stone_custom = class({})

function item_seer_stone_custom:GetIntrinsicModifierName()
	return "modifier_item_seer_stone_custom"
end

function item_seer_stone_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function item_seer_stone_custom:OnSpellStart()
	if not IsServer() then return end
	EmitSoundOnLocationForPlayer("Item.SeerStone", self:GetCursorPosition(), self:GetCaster():GetPlayerOwnerID())

	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCursorPosition(), self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("duration"), false)

	CreateModifierThinker( self:GetCaster(), self, "modifier_truesight_aura", { duration = self:GetSpecialValueFor("duration"), radius = radius }, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false )

	local particle = ParticleManager:CreateParticleForTeam("particles/items4_fx/seer_stone.vpcf", PATTACH_WORLDORIGIN, nil, self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(particle, 0, self:GetCursorPosition())
	ParticleManager:SetParticleControl(particle, 1, Vector(self:GetSpecialValueFor("duration")+0.5, self:GetSpecialValueFor("radius"), 0))
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_item_seer_stone_custom = class({})

function modifier_item_seer_stone_custom:IsPurgable() return false end
function modifier_item_seer_stone_custom:IsHidden() return true end

function modifier_item_seer_stone_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_BONUS_DAY_VISION,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
	}
end

function modifier_item_seer_stone_custom:GetModifierCastRangeBonusStacking()
	return self:GetAbility():GetSpecialValueFor("cast_range_bonus")
end

function modifier_item_seer_stone_custom:GetBonusDayVision()
	return self:GetAbility():GetSpecialValueFor("vision_bonus")
end

function modifier_item_seer_stone_custom:GetBonusNightVision()
	return self:GetAbility():GetSpecialValueFor("vision_bonus")
end

function modifier_item_seer_stone_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_seer_stone_custom:GetModifierPercentageCooldown()
	return self:GetAbility():GetSpecialValueFor("cooldown")
end

--modifier_item_seer_stone_custom_thinker = class({})
--
--function modifier_item_seer_stone_custom_thinker:OnCreated(kv)
--	self.radius = kv.radius
--end
--
--function modifier_item_seer_stone_custom_thinker:IsAura()
--    return true
--end
--
--function modifier_item_seer_stone_custom_thinker:IsHidden()
--    return true
--end
--
--function modifier_item_seer_stone_custom_thinker:IsPurgable()
--    return false
--end
--
--function modifier_item_seer_stone_custom_thinker:GetAuraRadius()
--    return self.radius
--end
--
--function modifier_item_seer_stone_custom_thinker:GetModifierAura()
--    return "modifier_truesight"
--end
--   
--function modifier_item_seer_stone_custom_thinker:GetAuraSearchTeam()
--    return DOTA_UNIT_TARGET_TEAM_ENEMY
--end
--
--function modifier_item_seer_stone_custom_thinker:GetAuraSearchFlags()
--    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
--end
--
--function modifier_item_seer_stone_custom_thinker:GetAuraSearchType()
--    return DOTA_UNIT_TARGET_ALL
--end