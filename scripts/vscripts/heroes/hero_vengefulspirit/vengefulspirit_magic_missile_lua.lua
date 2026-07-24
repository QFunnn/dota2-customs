--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_magic_missile_lua", "heroes/hero_vengefulspirit/vengefulspirit_magic_missile_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if vengefulspirit_magic_missile_lua == nil then
	vengefulspirit_magic_missile_lua = class({})
end
function vengefulspirit_magic_missile_lua:GetIntrinsicModifierName()
	return "modifier_vengefulspirit_magic_missile_lua"
end
function vengefulspirit_magic_missile_lua:OnSpellStart()
	-- local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	-- local magic_missile_speed = self:GetSpecialValueFor("magic_missile_speed")
	if IsValid(hTarget) then
		self:FireMissile(hTarget, false)
	end
end
function vengefulspirit_magic_missile_lua:FireMissile(hTarget, bFirebyAttack)
	local hCaster = self:GetCaster()
	local magic_missile_speed = self:GetSpecialValueFor("magic_missile_speed")
	if bFirebyAttack then
		bFirebyAttack = 1
	else
		bFirebyAttack = 0
	end
	local info = {
		EffectName = "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf",
		Ability = self,
		Source = hCaster,
		Target = hTarget,
		iMoveSpeed = magic_missile_speed,
		bDodgeable = true,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		bProvidesVision = false,
		iVisionRadius = 0,
		iVisionTeamNumber = hCaster:GetTeamNumber(),
		ExtraData = {
			hashtable_index = GetHashtableIndex(CreateHashtable()),
			jump_target_index = hTarget:entindex(),
			bFirebyAttack = bFirebyAttack,
		},
	}
	ProjectileManager:CreateTrackingProjectile(info)
	EmitSoundOn("Hero_VengefulSpirit.MagicMissile", hCaster)
end
function vengefulspirit_magic_missile_lua:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	local hCaster = self:GetCaster()
	local tHashtable = GetHashtableByIndex(ExtraData.hashtable_index or -1)
	local hTrueTarget = EntIndexToHScript(ExtraData.jump_target_index or -1)
	local bFirebyAttack = (ExtraData.bFirebyAttack == 1)
	local magic_missile_stun = self:GetSpecialValueFor("magic_missile_stun")
	local magic_missile_stun_attack_pct = self:GetSpecialValueFor("magic_missile_stun_attack_pct")
	local magic_missile_damage = self:GetSpecialValueFor("magic_missile_damage")
	local bonus_damage_pct = self:GetSpecialValueFor("bonus_damage_pct")
	local bounce_count = self:GetSpecialValueFor("bounce_count")

	EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", hTrueTarget)
	if IsValid(hTrueTarget) then
		if not hTrueTarget:TriggerSpellAbsorb(self) then
			if bFirebyAttack then
				magic_missile_stun = magic_missile_stun * (100 - magic_missile_stun_attack_pct) * 0.01
			end

			if hTrueTarget:GetCursorCastTarget() == hCaster or hTrueTarget:GetAttackTarget() == hCaster then
				magic_missile_damage = magic_missile_damage * (100 + bonus_damage_pct) * 0.01
				magic_missile_stun = magic_missile_stun * (100 + bonus_damage_pct) * 0.01
			end

			ApplyDamage({
				victim = hTrueTarget,
				attacker = hCaster,
				ability = self,
				damage = magic_missile_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			})
			if IsValid(hTrueTarget) and hTrueTarget:IsAlive() then
				hTrueTarget:AddNewModifier(hCaster, self, "modifier_stunned", { duration = magic_missile_stun * hTrueTarget:GetStatusResistanceFactor(hCaster) })
			end
			--弹射受林肯影响
			if bounce_count > 0 then
				if #tHashtable < bounce_count then
					self:Bounce(hCaster, hTrueTarget, ExtraData.bFirebyAttack, tHashtable)
				else
					RemoveHashtable(tHashtable)
				end

			end
		end
	end
end
function vengefulspirit_magic_missile_lua:Bounce(hCaster, hTarget, bFirebyAttack, tHashtable)
	tHashtable = tHashtable or CreateHashtable()
	if not IsValid(hTarget) then
		RemoveHashtable(tHashtable)
		return
	end
	local bounce_radius = self:GetCastRange(hCaster:GetAbsOrigin(), hTarget)
	local magic_missile_speed = self:GetSpecialValueFor("magic_missile_speed")

	table.insert(tHashtable, hTarget)

	local flags = DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE

	local hNextTarget = Util:GetBounceTarget(hTarget, hCaster:GetTeamNumber(), hTarget:GetAbsOrigin(), bounce_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, flags, FIND_CLOSEST, tHashtable, false)
	if not IsValid(hNextTarget) then
		RemoveHashtable(tHashtable)
		return
	end
	EmitSoundOn("Hero_VengefulSpirit.MagicMissile", hTarget)
	local tInfo = {
		Target = hNextTarget,
		vSourceLoc = hTarget:GetAttachmentOrigin(hTarget:ScriptLookupAttachment("attach_hitloc")),
		Ability = self,
		EffectName = "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf",
		iMoveSpeed = magic_missile_speed,
		bIsAttack = false,
		flExpireTime = GameRules:GetGameTime() + 10,
		ExtraData = {
			hashtable_index = GetHashtableIndex(tHashtable),
			jump_target_index = hNextTarget:entindex(),
			bFirebyAttack = bFirebyAttack or 0
		},
	}
	ProjectileManager:CreateTrackingProjectile(tInfo)
end
---------------------------------------------------------------------
--Modifiers
if modifier_vengefulspirit_magic_missile_lua == nil then
	modifier_vengefulspirit_magic_missile_lua = class({})
end
function modifier_vengefulspirit_magic_missile_lua:IsHidden()
	local magic_missile_stun_attack_pct = self:GetAbilitySpecialValueFor("magic_missile_stun_attack_pct")
	if magic_missile_stun_attack_pct > 0 then
		return false
	else
		return true
	end
end
function modifier_vengefulspirit_magic_missile_lua:IsDebuff()
	return false
end
function modifier_vengefulspirit_magic_missile_lua:IsPurgable()
	return false
end
function modifier_vengefulspirit_magic_missile_lua:IsPurgeException()
	return false
end
-- function modifier_vengefulspirit_magic_missile_lua:AllowIllusionDuplicate()
-- 	return true
-- end
function modifier_vengefulspirit_magic_missile_lua:OnCreated(params)
	if IsServer() then
	end
end
function modifier_vengefulspirit_magic_missile_lua:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_vengefulspirit_magic_missile_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
	}
end
function modifier_vengefulspirit_magic_missile_lua:OnAttack(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.target
	local fire_attack_count = self:GetAbilitySpecialValueFor("fire_attack_count")

	if IsServer() then
		if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() and (not hParent:IsIllusion() or hParent:HasModifier("modifier_ogre_multicast_lua_bonus")) then
			if fire_attack_count > 0 then
				self:IncrementStackCount()
				if self:GetStackCount() >= fire_attack_count then
					local ability = self:GetAbility()
					if ability ~= nil and ability.FireMissile and type(ability.FireMissile) == "function" then
						ability:FireMissile(hTarget, true)
					end
					self:SetStackCount(0)
				end
			end
		end
	end
end