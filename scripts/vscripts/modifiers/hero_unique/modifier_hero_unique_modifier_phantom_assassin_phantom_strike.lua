--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_phantom_assassin_phantom_strike = class({})
function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:IsHidden() return true end
function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:IsPurgable() return false end
function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:IsPurgeException() return false end
function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_phantom_assassin_phantom_strike:AttackLandedModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not self:GetParent():HasModifier("modifier_phantom_assassin_phantom_strike") then return end
	if self.parent.anchor_attack_talent then return end
	if self.parent.bCanTriggerLock then return end
	if params.no_attack_cooldown then return end
	if self.parent:HasModifier("modifier_muerta_pierce_the_veil_buff") then return end
	local frostivus2018_clinkz_searing_arrows = self.parent:FindAbilityByName("frostivus2018_clinkz_searing_arrows")
	if frostivus2018_clinkz_searing_arrows then
		if frostivus2018_clinkz_searing_arrows:GetAutoCastState() then
			if params.no_attack_cooldown then
				return
			end
		end
	end
	local target_loc = params.target:GetAbsOrigin()
	local fury_swipes_damage = 0
	if params.attacker:HasAbility("ursa_fury_swipes") and params.target:HasModifier("modifier_ursa_fury_swipes_damage_increase") then
		local ursa_swipes = params.attacker:FindAbilityByName("ursa_fury_swipes")
		if ursa_swipes and not ursa_swipes:IsNull() then
			local stacks = params.target:GetModifierStackCount("modifier_ursa_fury_swipes_damage_increase", params.attacker)
			fury_swipes_damage = stacks * ursa_swipes:GetSpecialValueFor("damage_per_stack")
		end
	end
	local damage = params.original_damage + fury_swipes_damage
	local cleave_damage_percent = 50
	-- Phantom Assassin innate: +1% прорубающего урона за уровень (максимум +50%).
	-- Даёт бонус только самой PA через её врождённую способность.
	local innate = params.attacker:FindModifierByName("modifier_phantom_assassin_innate_cleave")
	if innate and innate.GetBonusCleavePct then
		cleave_damage_percent = cleave_damage_percent + innate:GetBonusCleavePct()
	end
	damage = damage * (cleave_damage_percent / 100)
	local enemies = FindUnitsInRadius(params.attacker:GetTeamNumber(), target_loc, nil, 300, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if enemy ~= params.target then
			ApplyDamage({ victim = enemy, attacker = params.attacker, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = ability })
		end
	end
end