--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slark_fish_bait_custom_debuff", "heroes/npc_dota_hero_slark_custom/slark_fish_bait_custom", LUA_MODIFIER_MOTION_NONE)

slark_fish_bait_custom = class({})

function slark_fish_bait_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_shard_fish_bait.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_fish_bait_slow.vpcf", context )
end

slark_fish_bait_custom.modifier_slark_20 = -10

function slark_fish_bait_custom:CastFilterResultTarget( hTarget )
    if hTarget:IsMagicImmune() and (not self:GetCaster():HasModifier("modifier_slark_20")) then
        return UF_FAIL_MAGIC_IMMUNE_ENEMY
    end

    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function slark_fish_bait_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then return end

	local proj = 
	{
		Target = target,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_slark/slark_shard_fish_bait.vpcf",
		iMoveSpeed = 1250,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		bProvidesVision = false,
	}

	self:GetCaster():EmitSound("Hero_Slark.FishBait")

	ProjectileManager:CreateTrackingProjectile(proj)
end

function slark_fish_bait_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
    if not IsServer() then return end
    if target == nil then return end
    if not self:GetCaster():HasModifier("modifier_slark_20") then
   		if target:IsMagicImmune() then return end
   	end
    target:AddNewModifier(self:GetCaster(), self, "modifier_slark_fish_bait_custom_debuff", {duration = self:GetSpecialValueFor("duration") * (1-target:GetStatusResistance())})
end

modifier_slark_fish_bait_custom_debuff = class({})

function modifier_slark_fish_bait_custom_debuff:IsPurgable() return not self:GetCaster():HasModifier("modifier_slark_20") end
function modifier_slark_fish_bait_custom_debuff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self.damage_interval = 0
end

function modifier_slark_fish_bait_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = FrameTime()+FrameTime()})
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, FrameTime()+FrameTime(), false)
	self.damage_interval = self.damage_interval + FrameTime()
	if self.damage_interval >= 0.5 then
		self.damage_interval = 0
		local damage = self:GetCaster():GetIntellect(false) / 100 * self:GetAbility():GetSpecialValueFor("damage_intellect")
		ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL})
	end
end

function modifier_slark_fish_bait_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_slark/slark_fish_bait_slow.vpcf"
end

function modifier_slark_fish_bait_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_slark_fish_bait_custom_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_slark_fish_bait_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_slark_20") then
		bonus = self:GetAbility().modifier_slark_20
	end
	return self:GetAbility():GetSpecialValueFor("movement_speed") + bonus
end