--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_ranged_cleave = class({}) ---@class CDOTA_Item_Lua

LinkLuaModifier("modifier_item_ranged_cleave", "item_ability/item_ranged_cleave", LUA_MODIFIER_MOTION_NONE)


---@return string
function item_ranged_cleave:GetIntrinsicModifierName()
	return "modifier_item_ranged_cleave"
end


------------------------------------------------------------------------------------
modifier_item_ranged_cleave = class({}) ---@class CDOTA_Modifier_Lua

function modifier_item_ranged_cleave:IsDebuff() return false end
function modifier_item_ranged_cleave:IsHidden() return true end
function modifier_item_ranged_cleave:IsPurgable() return false end

function modifier_item_ranged_cleave:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

---@return modifierfunction[]
function modifier_item_ranged_cleave:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_item_ranged_cleave:OnCreated()
	local ability = self:GetAbility()
	if not ability then return end

	self.bonus_str = ability:GetSpecialValueFor("bonus_str")
	self.bonus_agi = ability:GetSpecialValueFor("bonus_agi")
	self.bonus_dmg = ability:GetSpecialValueFor("bonus_dmg")
	self.bonus_range = ability:GetSpecialValueFor("bonus_range")
	self.cleave_dmg = ability:GetSpecialValueFor("cleave_dmg")
	self.cleave_radius = ability:GetSpecialValueFor("cleave_radius")
	self.cache_interval = ability:GetSpecialValueFor("cleave_cache_interval")
	if self.cache_interval <= 0 then
		self.cache_interval = 0.25
	end
	self.cache_expire_time = 0
	self.cache_enemies = nil
	self.cache_center = Vector(0, 0, 0)
	self.cache_radius = self.cleave_radius
end

function modifier_item_ranged_cleave:OnRefresh()
	self:OnCreated()
end

function modifier_item_ranged_cleave:GetModifierBonusStats_Strength()
	return self.bonus_str or 0
end

function modifier_item_ranged_cleave:GetModifierBonusStats_Agility()
	return self.bonus_agi or 0
end

function modifier_item_ranged_cleave:GetModifierPreAttack_BonusDamage()
	return self.bonus_dmg or 0
end

function modifier_item_ranged_cleave:GetModifierAttackRangeBonusUnique()
	if self:GetParent():IsRangedAttacker() then
		return self.bonus_range or 0
	else
		return 0
	end
end

---@param a Vector
---@param b Vector
---@return number
function modifier_item_ranged_cleave:GetDistance2DSquared(a, b)
	local dx = a.x - b.x
	local dy = a.y - b.y
	return (dx * dx) + (dy * dy)
end

---@param attacker CDOTA_BaseNPC
---@param center Vector
---@param radius number
---@return CDOTA_BaseNPC[]
function modifier_item_ranged_cleave:GetEnemiesCached(attacker, center, radius)
	local now = GameRules:GetGameTime()
	local shift_threshold_sq = 96 * 96
	local moved_sq = self:GetDistance2DSquared(center, self.cache_center)

	if self.cache_enemies
		and now < self.cache_expire_time
		and self.cache_radius == radius
		and moved_sq <= shift_threshold_sq then
		return self.cache_enemies
	end

	self.cache_enemies = FindUnitsInRadius(
		attacker:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	self.cache_expire_time = now + self.cache_interval
	self.cache_center = center
	self.cache_radius = radius

	return self.cache_enemies
end

---@param keys ModifierAttackEvent
function modifier_item_ranged_cleave:GetModifierProcAttack_Feedback(keys)
	if not IsServer() then return end

    local attacker = keys.attacker
    local target = keys.target

    if not attacker:IsRealHero() or not attacker:IsRangedAttacker() then return end
    if target:IsBuilding() or attacker:GetTeam() == target:GetTeam() then return end

    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return end

    local damage = keys.original_damage * self.cleave_dmg * 0.01

    local fury_swipes_damage = 0
    -- Найденная способность кэшируется; если её сняли (handle стал null) или ещё
    -- не нашли — перепроверяем не чаще раза в 3с (вдруг способность выдали/заменили),
    -- а не FindAbilityByName на каждую атаку.
    local ursa_swipes = attacker.fury_swipes_ability
    if ursa_swipes and ursa_swipes:IsNull() then
        ursa_swipes = nil
        attacker.fury_swipes_ability = nil
    end
    if not ursa_swipes then
        local now = GameRules:GetGameTime()
        if not attacker.fury_swipes_recheck_time or now >= attacker.fury_swipes_recheck_time then
            ursa_swipes = attacker:FindAbilityByName("ursa_fury_swipes")
            attacker.fury_swipes_ability = ursa_swipes
            attacker.fury_swipes_recheck_time = now + 3
        end
    end
    if ursa_swipes then
        local mod = target:FindModifierByName("modifier_ursa_fury_swipes_damage_increase")
        if mod then
            fury_swipes_damage = mod:GetStackCount() * ursa_swipes:GetSpecialValueFor("damage_per_stack")
        end
    end

    damage = damage + fury_swipes_damage * self.cleave_dmg * 0.01

    local dmgTable = {
        attacker = attacker,
        damage_type = ability:GetAbilityDamageType(),
        damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
        ability = ability,
    }

    local target_loc = target:GetAbsOrigin()
	local particle = ParticleManager:CreateParticle("particles/custom/shrapnel.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, target_loc)
	ParticleManager:ReleaseParticleIndex(particle)


    local enemies = self:GetEnemiesCached(attacker, target_loc, self.cleave_radius)

    for _, enemy in pairs(enemies) do
        if enemy ~= target and enemy:IsAlive() then
            dmgTable.victim = enemy
            dmgTable.damage = damage
            ApplyDamage(dmgTable)
        end
    end
end