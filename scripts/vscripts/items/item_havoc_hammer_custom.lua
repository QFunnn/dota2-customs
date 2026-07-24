--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_havoc_hammer_custom", "items/item_havoc_hammer_custom", LUA_MODIFIER_MOTION_NONE)

item_havoc_hammer_custom = class({})

function item_havoc_hammer_custom:GetIntrinsicModifierName()
	return "modifier_item_havoc_hammer_custom"
end

function item_havoc_hammer_custom:OnSpellStart()
	if not IsServer() then return end
	local duration_slow = self:GetSpecialValueFor("duration_slow")
	local radius = self:GetSpecialValueFor("range")
	local knockback_distance = self:GetSpecialValueFor("knockback_distance")
	local nuke_base_dmg = self:GetSpecialValueFor("nuke_base_dmg")
	local knockback_duration = self:GetSpecialValueFor("knockback_duration")

	local particle = ParticleManager:CreateParticle( "particles/items5_fx/havoc_hammer.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin() )
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))

    self:GetCaster():EmitSound("DOTA_Item.HavocHammer.Cast")

	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	
	for _, unit in pairs(units) do

		local distance = (unit:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
		local direction = (self:GetCaster():GetAbsOrigin() - unit:GetAbsOrigin()):Normalized()
		local bump_point = unit:GetAbsOrigin() - direction * (knockback_distance)
		local knockbackProperties =
		{
			center_x = bump_point.x,
			center_y = bump_point.y,
			center_z = bump_point.z,
			duration = knockback_duration,
			knockback_duration = knockback_duration,
			knockback_distance = knockback_distance,
			knockback_height = 0,
			should_stun = false,
		}
			
		if not unit:HasModifier("modifier_knockback") then
			unit:AddNewModifier( unit, self, "modifier_knockback", knockbackProperties )
		end

		local damage = self:GetCaster():GetStrength() / 100 * self:GetSpecialValueFor("nuke_base_dmg")

		ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})

		unit:AddNewModifier(self:GetCaster(), self, "modifier_havoc_hammer_slow", {duration = 3 * (1 - unit:GetStatusResistance())})
	end
end

modifier_item_havoc_hammer_custom = class({})

function modifier_item_havoc_hammer_custom:IsHidden() return true end

function modifier_item_havoc_hammer_custom:IsPurgable() return false end
function modifier_item_havoc_hammer_custom:IsPurgeException() return false end

function modifier_item_havoc_hammer_custom:OnCreated()
    self.bonus_strength_pct = self:GetAbility():GetSpecialValueFor("bonus_strength_pct")
    self.str_bonus = 0
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_item_havoc_hammer_custom:OnIntervalThink()
    if not IsServer() then return end
    self.str_bonus = 0
    self.str_bonus = self:GetParent():GetStrength() / 100 * self.bonus_strength_pct
    self:GetParent():CalculateStatBonus(true)
end

function modifier_item_havoc_hammer_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_item_havoc_hammer_custom:GetModifierBonusStats_Strength(params)
    return self.str_bonus
end

function modifier_item_havoc_hammer_custom:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("damage")
end