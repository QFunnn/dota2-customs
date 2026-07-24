--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_disperser_custom", "items/item_disperser_custom", LUA_MODIFIER_MOTION_NONE)

item_disperser_custom = class({})

function item_disperser_custom:GetIntrinsicModifierName()
	return "modifier_item_disperser_custom"
end

function item_disperser_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function item_disperser_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("radius")
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
        self:OnTarget(enemy)
    end
end

function item_disperser_custom:OnTarget(target)
	if not IsServer() then return end
	if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		target:Purge(false, true, false, false, false)
		target:AddNewModifier(self:GetCaster(), self, "modifier_disperser_movespeed_buff", {duration = self:GetSpecialValueFor("ally_effect_duration")})
	else
		if target:TriggerSpellAbsorb(self) then return end
		self:GetCaster():EmitSound("DOTA_Item.DiffusalBlade.Activate")
		target:EmitSound("DOTA_Item.DiffusalBlade.Target")
		target:AddNewModifier(self:GetCaster(), self, "modifier_item_diffusal_blade_slow", {duration = self:GetSpecialValueFor("enemy_effect_duration")})
		if not target:IsHero() then
			target:AddNewModifier(self:GetCaster(), self, "modifier_rooted", {duration = self:GetSpecialValueFor("purge_root_duration")})
		end
	end
end

modifier_item_disperser_custom = class({})

function modifier_item_disperser_custom:IsHidden()		return true end
function modifier_item_disperser_custom:IsPurgable() return false end
function modifier_item_disperser_custom:IsPurgeException() return false end
function modifier_item_disperser_custom:RemoveOnDeath()	return false end
function modifier_item_disperser_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_disperser_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_item_disperser_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.bonus_agility = self.ability:GetSpecialValueFor("bonus_agility")
    self.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
    self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
    self.burn_radius = self.ability:GetSpecialValueFor("burn_radius")
    self.feedback_mana_burn = self.ability:GetSpecialValueFor("feedback_mana_burn")
    self.damage_per_burn = self.ability:GetSpecialValueFor("damage_per_burn")
    self.feedback_mana_burn_illusion_melee = self.ability:GetSpecialValueFor("feedback_mana_burn_illusion_melee")
end

function modifier_item_disperser_custom:GetModifierBonusStats_Agility()
    return self.bonus_agility
end

function modifier_item_disperser_custom:GetModifierBonusStats_Intellect()
    return self.bonus_intellect
end

function modifier_item_disperser_custom:GetModifierPreAttack_BonusDamage(params)
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, self.bonus_damage, "item_disperser_custom", DAMAGE_TYPE_PHYSICAL)
    end
    return self.bonus_damage
end

function modifier_item_disperser_custom:AttackLandedModifier(params)
    if params.attacker == self.parent then
    	if params.no_attack_cooldown then return end
    	if self.parent:PassivesDisabled() then return end
    	local target_n = params.target
    	if self.parent:FindAllModifiersByName("modifier_item_disperser_custom")[1] ~= self then return end
		local enemies = FindUnitsInRadius(params.attacker:GetTeamNumber(), target_n:GetAbsOrigin(), nil, self.burn_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_ANY_ORDER, false)
		for _, target in pairs(enemies) do
			local manaBurn = self.feedback_mana_burn
			local manaDamage = self.damage_per_burn
			local feedback_mana_burn_illusion = self.feedback_mana_burn_illusion_melee
			local damageTable = {}
			damageTable.attacker = self.parent
			damageTable.victim = target
			damageTable.damage_type = DAMAGE_TYPE_PHYSICAL
			damageTable.ability = self.ability
			if not target:IsMagicImmune() then
				if(target:GetMana() >= manaBurn) then
					damageTable.damage = manaBurn * manaDamage
					if not self.parent:IsIllusion() then
						target:Script_ReduceMana(manaBurn, self.ability)
					else
						target:Script_ReduceMana(feedback_mana_burn_illusion, self.ability)
						damageTable.damage = feedback_mana_burn_illusion * manaDamage
					end
				else
					damageTable.damage = target:GetMana() * manaDamage
					if not self.parent:IsIllusion() then
						target:Script_ReduceMana(manaBurn, self.ability)
					else
						target:Script_ReduceMana(feedback_mana_burn_illusion, self.ability)
					end
				end
				ApplyDamage(damageTable)
			end
		end
    end
end