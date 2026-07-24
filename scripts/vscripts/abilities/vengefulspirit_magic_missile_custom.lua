--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_magic_missile_custom_passive", "abilities/vengefulspirit_magic_missile_custom", LUA_MODIFIER_MOTION_NONE)

vengefulspirit_magic_missile_custom = class({})

function vengefulspirit_magic_missile_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf", context )
end

function vengefulspirit_magic_missile_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local index = DoUniqueString("vengefulspirit_magic_missile_custom")
    self[index] = {}
	self:StartMissile(self:GetCaster(), target, 0, index)
end

function vengefulspirit_magic_missile_custom:GetIntrinsicModifierName()
	return "modifier_vengefulspirit_magic_missile_custom_passive"
end

function vengefulspirit_magic_missile_custom:StartMissile(caster, target, count, index)
	if not IsServer() then return end
	local projectile =
	{
		Target 				= target,
		Source 				= caster,
		Ability 			= self,
		EffectName 			= "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf",
		iMoveSpeed			= 1350,
		bDrawsOnMinimap 	= false,
		bDodgeable 			= true,
		bIsAttack 			= false,
		bVisibleToEnemies 	= true,
		bReplaceExisting 	= false,
		flExpireTime 		= GameRules:GetGameTime() + 10,
		bProvidesVision 	= false,
		iSourceAttachment 	= DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
		ExtraData			= {count = count, index = index}
	}
	ProjectileManager:CreateTrackingProjectile(projectile)
	self:GetCaster():EmitSound("Hero_VengefulSpirit.MagicMissile")
end

function vengefulspirit_magic_missile_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
	if not IsServer() then return end
	if target == nil then return end
	if target:TriggerSpellAbsorb(self) then return end
	if target:IsMagicImmune() then return end
	self[ExtraData.index][target:entindex()] = true
	local magic_missile_stun = self:GetSpecialValueFor("magic_missile_stun")
	local magic_missile_damage = self:GetSpecialValueFor("magic_missile_damage")
	self:GetCaster():EmitSound("Hero_VengefulSpirit.MagicMissileImpact")
	ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = magic_missile_damage, damage_type = DAMAGE_TYPE_MAGICAL})
	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = magic_missile_stun * (1 - target:GetStatusResistance())})

	if self:GetCaster():HasShard() and ExtraData.count < 1 then
		ExtraData.count = ExtraData.count + 1

		local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCastRange(target:GetAbsOrigin(), target), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, false)
		local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCastRange(target:GetAbsOrigin(), target), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)

		for i = #heroes, 1, -1 do
        	if heroes[i] ~= nil and self[ExtraData.index][heroes[i]:entindex()] ~= nil then
	            table.remove(heroes, i)
	        end
	    end
	    for i = #units, 1, -1 do
        	if units[i] ~= nil and self[ExtraData.index][units[i]:entindex()] ~= nil then
	            table.remove(units, i)
	        end
	    end

		local new_target = nil

		if #heroes > 0 then
			new_target = heroes[1]
		end

		if new_target == nil then
			if #units > 0 then
				new_target = units[1]
			end
		end

		if new_target == nil then return end

		self:StartMissile(target, new_target, ExtraData.count, ExtraData.index)
	end
end

modifier_vengefulspirit_magic_missile_custom_passive = class({})

function modifier_vengefulspirit_magic_missile_custom_passive:IsDebuff() return false end
function modifier_vengefulspirit_magic_missile_custom_passive:IsHidden() return not self:GetCaster():HasTalent("special_bonus_unique_cha_vengeful_spirit") end
function modifier_vengefulspirit_magic_missile_custom_passive:IsPurgable() return false end
function modifier_vengefulspirit_magic_missile_custom_passive:IsStunDebuff() return false end
function modifier_vengefulspirit_magic_missile_custom_passive:RemoveOnDeath() return false end

function modifier_vengefulspirit_magic_missile_custom_passive:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(0)
end

function modifier_vengefulspirit_magic_missile_custom_passive:AttackLandedModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not self:GetCaster():HasTalent("special_bonus_unique_cha_vengeful_spirit") then return end
    self:IncrementStackCount()
    if self:GetStackCount() >= 7 then
        local index = DoUniqueString("vengefulspirit_magic_missile_custom")
        self:GetAbility()[index] = {}
	    self:GetAbility():StartMissile(self:GetCaster(), params.target, 0, index)
        self:SetStackCount(0)
    end
end