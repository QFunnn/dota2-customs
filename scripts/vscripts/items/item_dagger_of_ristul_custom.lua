--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dagger_of_ristul_custom", "items/item_dagger_of_ristul_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dagger_of_ristul_custom_debuff", "items/item_dagger_of_ristul_custom", LUA_MODIFIER_MOTION_NONE)

item_dagger_of_ristul_custom = class({})

function item_dagger_of_ristul_custom:GetIntrinsicModifierName()
	return "modifier_item_dagger_of_ristul_custom"
end

modifier_item_dagger_of_ristul_custom = class({})

function modifier_item_dagger_of_ristul_custom:IsHidden() return true end
function modifier_item_dagger_of_ristul_custom:IsPurgable() return false end
function modifier_item_dagger_of_ristul_custom:IsPurgeException() return false end
function modifier_item_dagger_of_ristul_custom:RemoveOnDeath() return false end

function modifier_item_dagger_of_ristul_custom:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_item_dagger_of_ristul_custom:OnAttackLanded(params)
	if params.attacker == self:GetParent() then
        if params.target:IsOther() then
            return nil
        end
        if self:GetParent():IsIllusion() then
            return nil
        end

	    local victim_angle = params.target:GetAnglesAsVector().y
	    local origin_difference = params.target:GetAbsOrigin() - params.attacker:GetAbsOrigin()
	    local origin_difference_radian = math.atan2(origin_difference.y, origin_difference.x)
	    origin_difference_radian = origin_difference_radian * 180
	    local attacker_angle = origin_difference_radian / math.pi
	    attacker_angle = attacker_angle + 180.0
	    local result_angle = attacker_angle - victim_angle
	    result_angle = math.abs(result_angle)
	    if result_angle >= (180 - (105 / 2)) and result_angle <= (180 + (105 / 2)) then 
	        local duration = self:GetAbility():GetSpecialValueFor("duration")
        	params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_dagger_of_ristul_custom_debuff", {duration = duration * (1 - params.target:GetStatusResistance())})
	    end
    end
end

modifier_item_dagger_of_ristul_custom_debuff = class({})

function modifier_item_dagger_of_ristul_custom_debuff:IsPurgable() return true end

function modifier_item_dagger_of_ristul_custom_debuff:OnCreated()
    if not IsServer() then return end
    local damage_phys = self:GetAbility():GetSpecialValueFor("damage_phys")
    self.damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * damage_phys
    self:StartIntervalThink(1)
end

function modifier_item_dagger_of_ristul_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.damage, flags=DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK+DOTA_DAMAGE_FLAG_HPLOSS +DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR +DOTA_DAMAGE_FLAG_IGNORES_BASE_PHYSICAL_ARMOR , damage_type = DAMAGE_TYPE_PHYSICAL})
end