--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom_debuff", "abilities/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_hammer_of_purity_custom", "abilities/omniknight_hammer_of_purity_custom", LUA_MODIFIER_MOTION_NONE)

omniknight_hammer_of_purity_custom = class({})

function omniknight_hammer_of_purity_custom:GetIntrinsicModifierName()
	return "modifier_omniknight_hammer_of_purity_custom"
end

function omniknight_hammer_of_purity_custom:OnUpgrade()
    if not IsServer() then return end
    if self and self:GetLevel() == 1 then
        self:ToggleAutoCast()
    end
end

function omniknight_hammer_of_purity_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	if new_target ~= nil then
		target = new_target
	end

	self:GetCaster():EmitSound("Hero_Omniknight.HammerOfPurity.Cast")

	local info = 
	{
		Target = target,
		Source = self:GetCaster(),
		Ability = self,	
		EffectName = "particles/units/heroes/hero_omniknight/omniknight_hammer_of_purity_projectile.vpcf",
		iMoveSpeed = 1200,
		bDodgeable = true,
	}

	ProjectileManager:CreateTrackingProjectile(info)
end

function omniknight_hammer_of_purity_custom:OnProjectileHit(target, vLocation)
	if target == nil then return end
	if target:TriggerSpellAbsorb(self) then return end
	local base_damage = self:GetSpecialValueFor("base_damage")
	local bonus_damage = self:GetSpecialValueFor("bonus_damage")
	local duration  = self:GetSpecialValueFor("duration")
	local damage = base_damage + (self:GetCaster():GetAttackDamage() / 100 * bonus_damage)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 3, target:GetAbsOrigin())
	local dmg = ApplyDamage({ attacker = self:GetCaster(), victim = target, damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self })
	if self:GetCaster():HasShard() then
		self:GetCaster():Heal(dmg / 100 * self:GetSpecialValueFor("bonus_heal_pct"), self)
	end
	target:AddNewModifier(self:GetCaster(), self, "modifier_omniknight_hammer_of_purity_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
	target:EmitSound("Hero_Omniknight.HammerOfPurity.Target")
end

modifier_omniknight_hammer_of_purity_custom_debuff = class({})

function modifier_omniknight_hammer_of_purity_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_omniknight_hammer_of_purity_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_slow")
end

modifier_omniknight_hammer_of_purity_custom = class({})
function modifier_omniknight_hammer_of_purity_custom:IsHidden() return true end
function modifier_omniknight_hammer_of_purity_custom:IsPurgable() return false end
function modifier_omniknight_hammer_of_purity_custom:IsPurgeException() return false end

function modifier_omniknight_hammer_of_purity_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
end

function modifier_omniknight_hammer_of_purity_custom:AttackLandedModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self.parent then return end
    if self:GetParent():HasAbility("omniknight_hammer_of_purity_custom") then
        if self.ability:GetAutoCastState() then
            if self.ability:IsFullyCastable() and params.target:IsAlive() then
                self.ability:UseResources(true, false, false, true)
                self.ability:OnSpellStart(params.target)
            end
        end
    end
end