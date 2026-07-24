--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_desolator_2_custom", "items/item_desolator_2_custom", LUA_MODIFIER_MOTION_NONE )

item_desolator_2_custom = class({})

function item_desolator_2_custom:GetIntrinsicModifierName()
	return "modifier_item_desolator_2_custom"
end

modifier_item_desolator_2_custom = class({})

function modifier_item_desolator_2_custom:IsHidden() return true end
function modifier_item_desolator_2_custom:IsPurgable() return false end
function modifier_item_desolator_2_custom:IsPurgeException() return false end
function modifier_item_desolator_2_custom:RemoveOnDeath() return false end
function modifier_item_desolator_2_custom:GetAttributes()  return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_desolator_2_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
end

function modifier_item_desolator_2_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
    self.corruption_duration = self.ability:GetSpecialValueFor("corruption_duration")
    self.arrow_count = self.ability:GetSpecialValueFor("arrow_count")
end

function modifier_item_desolator_2_custom:GetModifierPreAttack_BonusDamage(params)
    if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
        _G.Players:QueueAttackBonus(params.attacker, params.target, self.bonus_damage, "item_desolator_2_custom", DAMAGE_TYPE_PHYSICAL)
    end
    return self.bonus_damage
end

function modifier_item_desolator_2_custom:GetModifierProjectileName()
    return "particles/items_fx/desolator_projectile.vpcf"
end

function modifier_item_desolator_2_custom:AttackModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self.parent then return end
    if params.target:IsWard() then return end
    if self.parent:FindAllModifiersByName("modifier_item_desolator_2_custom")[1] ~= self then return end
    if self.parent:IsIllusion() then return end
    params.target:EmitSound("Item_Desolator.Target")
end

function modifier_item_desolator_2_custom:AttackLandedModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self.parent then return end
    if params.target:IsWard() then return end
    if self.parent:FindAllModifiersByName("modifier_item_desolator_2_custom")[1] ~= self then return end
    if self.parent:IsIllusion() then return end
    params.target:AddNewModifier(self.parent, self.ability, "modifier_desolator_2_buff", {duration = self.corruption_duration})
    params.target:EmitSound("Item_Desolator.Target")
end

function modifier_item_desolator_2_custom:AttackModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self.parent then return end
	if params.attacker:IsIllusion() then return end
	if params.target == self.parent then return end
	if not self.ability:IsFullyCastable() then return end
	if self.parent:PassivesDisabled() then return end
	if params.no_attack_cooldown then return end
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.parent:Script_GetAttackRange() + 100, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	local attacks = 0
	for i, enemy in pairs(enemies) do
		if attacks >= self.arrow_count then break end
		attacks = attacks + 1
		Timers:CreateTimer(0.07 * i, function()
			if enemy and not enemy:IsNull() and enemy:IsAlive() and not enemy:IsAttackImmune() and not enemy:IsInvulnerable() then
				self.parent:PerformAttack(enemy, true, true, true, false, true, false, false) 
			end
		end)
	end
	self.ability:UseResources(false, false, false, true)
end
