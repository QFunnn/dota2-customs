--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modiifer_bloodseeker_bloodrage_custom", "heroes/hero_bloodseeker/bloodseeker_bloodrage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modiifer_bloodseeker_bloodrage_custom_cooldown", "heroes/hero_bloodseeker/bloodseeker_bloodrage_custom", LUA_MODIFIER_MOTION_NONE)

bloodseeker_bloodrage_custom = class({})

function bloodseeker_bloodrage_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():EmitSound("hero_bloodseeker.bloodRage")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modiifer_bloodseeker_bloodrage_custom", {duration = duration})
end

modiifer_bloodseeker_bloodrage_custom = class({})

function modiifer_bloodseeker_bloodrage_custom:IsHidden()
	return false
end

function modiifer_bloodseeker_bloodrage_custom:IsDebuff()
	return self.debuff
end

function modiifer_bloodseeker_bloodrage_custom:IsPurgable()
	return false
end

function modiifer_bloodseeker_bloodrage_custom:OnCreated( kv )
	self.debuff = self:GetCaster()~=self:GetParent()
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	self.spell_amp = self:GetAbility():GetSpecialValueFor( "spell_amp" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct")
	self.shard_max_health_dmg_pct = self:GetAbility():GetSpecialValueFor("shard_max_health_dmg_pct")
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modiifer_bloodseeker_bloodrage_custom:OnRefresh( kv )
	self.debuff = self:GetCaster()~=self:GetParent()
	self.attack_speed = self:GetAbility():GetSpecialValueFor( "attack_speed" )
	self.spell_amp = self:GetAbility():GetSpecialValueFor( "spell_amp" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct")
	self.shard_max_health_dmg_pct = self:GetAbility():GetSpecialValueFor("shard_max_health_dmg_pct")
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modiifer_bloodseeker_bloodrage_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():IsInvulnerable() then return end
	if self:GetParent():GetHealth() <= 1 then return end
	local self_damage = self:GetParent():GetMaxHealth() * 0.01
	local damage_table = {}
    damage_table.attacker = self:GetCaster()
    damage_table.victim = self:GetParent()
    damage_table.damage_type = DAMAGE_TYPE_MAGICAL
    damage_table.ability = self:GetAbility()
    damage_table.damage = self_damage
    damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NON_LETHAL
    ApplyDamage(damage_table)
end

function modiifer_bloodseeker_bloodrage_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modiifer_bloodseeker_bloodrage_custom:GetModifierSpellAmplify_Percentage(params)
	return self.spell_amp
end

function modiifer_bloodseeker_bloodrage_custom:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modiifer_bloodseeker_bloodrage_custom:GetModifierPreAttack_BonusDamage(params)
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	if not self:GetParent():HasShard() then return end
	if self:GetParent() ~= self:GetCaster() then return end
	if params.target == nil then return end
    if self.parent:HasModifier("modiifer_bloodseeker_bloodrage_custom_cooldown") then return end
    self.parent:AddNewModifier(self.parent, self.ability, "modiifer_bloodseeker_bloodrage_custom_cooldown", {duration = 0.2})
	local roshan_phys_immune_resist = 1
    local roshan_phys_immune = params.target:FindAbilityByName("roshan_phys_immune")
    if roshan_phys_immune then
        roshan_phys_immune_resist = 1 - (roshan_phys_immune:GetSpecialValueFor("phys_immune") / 100)
    end
	local leech = params.target:GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("shard_max_health_dmg_pct")
	local bonus = leech * roshan_phys_immune_resist
	if _G.Players and _G.Players.QueueAttackBonus then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "bloodseeker_bloodrage_custom", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end

function modiifer_bloodseeker_bloodrage_custom:TakeDamageScriptModifier( params )
	if not IsServer() then return end
	if params.unit == self:GetParent() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.attacker:PassivesDisabled() then return end
	if params.attacker:IsIllusion() then return end
	if params.no_attack_cooldown then return end
	if not self:GetParent():HasShard() then return end
	if self:GetParent() ~= self:GetCaster() then return end
	if params.inflictor ~= nil then return end
	local leech = params.unit:GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("shard_max_health_dmg_pct")
	self:GetParent():Heal(leech, self:GetAbility())
end

function modiifer_bloodseeker_bloodrage_custom:GetEffectName()
	return "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodrage.vpcf"
end

function modiifer_bloodseeker_bloodrage_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modiifer_bloodseeker_bloodrage_custom_cooldown = class({})
function modiifer_bloodseeker_bloodrage_custom_cooldown:IsHidden() return true end
function modiifer_bloodseeker_bloodrage_custom_cooldown:IsPurgeException() return false end
function modiifer_bloodseeker_bloodrage_custom_cooldown:IsPurgable() return false end