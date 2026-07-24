--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_demon_hunter", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_demon_hunter", LUA_MODIFIER_MOTION_NONE)

terrorblade_demon_hunter = class({})

terrorblade_demon_hunter.modifier_terrorblade_18 = {-10,-20,-30}
terrorblade_demon_hunter.modifier_terrorblade_17 = {33,66,100}

function terrorblade_demon_hunter:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", context )
end

function terrorblade_demon_hunter:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_18") then
		bonus = self.modifier_terrorblade_18[self:GetCaster():GetTalentLevel("modifier_terrorblade_18")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function terrorblade_demon_hunter:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_demon_hunter", {duration = duration})
end

modifier_terrorblade_demon_hunter = class({})

function modifier_terrorblade_demon_hunter:IsPurgable() return false end

function modifier_terrorblade_demon_hunter:OnCreated(table)
	if not IsServer() then return end
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_2)
	self:GetParent():EmitSound("Hero_Terrorblade.Metamorphosis")
	local transform_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(transform_particle)
end

function modifier_terrorblade_demon_hunter:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_terrorblade_demon_hunter:GetModifierPercentageManacostStacking(params)
	return self:GetAbility():GetSpecialValueFor("manacost_reduce")
end

function modifier_terrorblade_demon_hunter:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_terrorblade_demon_hunter:GetEffectName()
	return "particles/tb/demon_hunter_debuff.vpcf"
end

function modifier_terrorblade_demon_hunter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_terrorblade_demon_hunter:GetModifierProcAttack_BonusDamage_Magical(params)
	if not IsServer() then return end

	if not self:GetParent():HasModifier("modifier_terrorblade_17") then return end
	if params.target:IsMagicImmune() then return 0 end

	local steal_mana = params.damage / 100 * self:GetAbility().modifier_terrorblade_17[self:GetCaster():GetTalentLevel("modifier_terrorblade_17")]

	local mana_burn =  math.min( self:GetParent():GetMana(), steal_mana )
	self:GetParent():Script_ReduceMana(mana_burn, self:GetAbility()) 

    ApplyDamage({ victim = params.target, attacker = self:GetCaster(), ability = self:GetAbility(), damage = mana_burn, damage_type = DAMAGE_TYPE_MAGICAL})

	return 0
end