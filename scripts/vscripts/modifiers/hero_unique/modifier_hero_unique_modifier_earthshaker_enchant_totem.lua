--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_earthshaker_enchant_totem = class({})
function modifier_hero_unique_modifier_earthshaker_enchant_totem:IsHidden() return true end
function modifier_hero_unique_modifier_earthshaker_enchant_totem:IsPurgable() return false end
function modifier_hero_unique_modifier_earthshaker_enchant_totem:IsPurgeException() return false end
function modifier_hero_unique_modifier_earthshaker_enchant_totem:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_earthshaker_enchant_totem:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_earthshaker_enchant_totem:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_earthshaker_enchant_totem:AttackLandedModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.ability:GetLevel() <= 0 then return end
    if self.parent:HasModifier("modifier_earthshaker_enchant_totem") then return end
    self:IncrementStackCount()
    if self:GetStackCount() >= 3 then
        Timers:CreateTimer(0, function()
            self:GetParent():AddNewModifier(self:GetParent(), self.ability, "modifier_earthshaker_enchant_totem", {})
        end)
        self:SetStackCount(0)
    end
end

function modifier_hero_unique_modifier_earthshaker_enchant_totem:AttackLandedModifier(params)
	if not IsServer() then return end
	if self.ability == nil or self.ability:IsNull() or self.ability:GetLevel() <= 0 then return end
	if params.attacker ~= self:GetParent() then return end
	if params.attacker:IsIllusion() then return end
	if params.attacker:GetTeam() == params.target:GetTeam() then return end
	if params.target:IsBuilding() then return end
    if not self.parent:HasModifier("modifier_earthshaker_enchant_totem") then
        self:IncrementStackCount()
        if self:GetStackCount() >= 3 then
            Timers:CreateTimer(0, function()
                self:GetParent():AddNewModifier(self:GetParent(), self.ability, "modifier_earthshaker_enchant_totem", {})
            end)
            self:SetStackCount(0)
        end
    end
	if self.parent.anchor_attack_talent then return end
	if self.parent.bCanTriggerLock then return end
	if params.no_attack_cooldown then return end
    if not self:GetParent():HasModifier("modifier_earthshaker_enchant_totem") then return end
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
	local cleave_damage_percent = 100
	if self.parent:HasModifier("modifier_skill_splash") then
		cleave_damage_percent = cleave_damage_percent + 30
		cleave_damage_percent_creep = cleave_damage_percent_creep + 30
	end
	damage = damage * (cleave_damage_percent / 100)
	local modifier_dragon_knight_elder_dragon_form_custom = self.parent:FindModifierByName("modifier_dragon_knight_elder_dragon_form_custom")
	if modifier_dragon_knight_elder_dragon_form_custom then
		damage = damage + (params.damage * modifier_dragon_knight_elder_dragon_form_custom.splash_pct)
	end
	local enemies = FindUnitsInRadius(params.attacker:GetTeamNumber(), target_loc, nil, 700, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		if enemy ~= params.target then
			ApplyDamage({ victim = enemy, attacker = params.attacker, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = ability })
			if modifier_dragon_knight_elder_dragon_form_custom then
				modifier_dragon_knight_elder_dragon_form_custom:Corrosive( enemy )
			end
		end
	end
end