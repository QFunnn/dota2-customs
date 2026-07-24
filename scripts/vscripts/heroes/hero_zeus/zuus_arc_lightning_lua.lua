--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if zuus_arc_lightning_lua == nil then
	zuus_arc_lightning_lua = class({}) ---@class zuus_arc_lightning_lua : CDOTA_Ability_Lua
end

---@param hCaster CDOTA_BaseNPC
---@param hTarget CDOTA_BaseNPC
---@param radius integer
---@param jump_count number
---@param jump_delay number
---@param damage number
---@param damage_health_pct number
---@param damage_pct number
---@param tUnits CDOTA_BaseNPC[]
function zuus_arc_lightning_lua:Jump(
	hCaster,
	hTarget,
	radius,
	jump_count,
	jump_delay,
	damage,
	damage_health_pct,
	damage_pct,
	tUnits)
	Timers:CreateTimer(jump_delay, function()
		if IsValid(hCaster) and IsValid(hTarget) then
			local hNewTarget = Util:GetBounceTarget(
				hTarget,
				hCaster:GetTeamNumber(),
				hTarget:GetAbsOrigin(),
				radius,
				self:GetAbilityTargetTeam(),
				self:GetAbilityTargetType(),
				self:GetAbilityTargetFlags() + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
				FIND_CLOSEST,
				tUnits,
				false
			)
			if IsValid(hNewTarget) then
				EmitSoundOn("Hero_Zuus.ArcLightning.hTarget", hCaster)

				local iParticleID = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlEnt(
					iParticleID,
					0,
					hTarget,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					hTarget:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					iParticleID,
					1,
					hNewTarget,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					hNewTarget:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(iParticleID)

				local fDamage = (damage + hNewTarget:GetHealth() * damage_health_pct * 0.01) * damage_pct * 0.01

				local tDamageTable = {
					ability = self,
					attacker = hCaster,
					victim = hNewTarget,
					damage = fDamage,
					damage_type = self:GetAbilityDamageType()
				}
				ApplyDamage(tDamageTable)

				table.insert(tUnits, hNewTarget)

				if #tUnits < jump_count then
					self:Jump(hCaster, hNewTarget, radius, jump_count, jump_delay, damage, damage_health_pct, damage_pct,
						tUnits)
				end
			end
		end
	end)
end

function zuus_arc_lightning_lua:ArcLightning(hTarget, bFirebyAttack)
	local hCaster = self:GetCaster()
	local arc_damage = self:GetSpecialValueFor("arc_damage")
	local radius = self:GetSpecialValueFor("radius")
	local jump_count = self:GetSpecialValueFor("jump_count")
	local jump_delay = self:GetSpecialValueFor("jump_delay")
	local damage_health_pct = self:GetSpecialValueFor("damage_health_pct")
	local damage_pct = 100
	local hHand = hCaster:FindAbilityByName("zuus_lightning_hands_lua")
	if bFirebyAttack and IsValid(hHand) then ---@cast hHand CDOTABaseAbility
		local arc_lightning_damage_pct = hHand:GetSpecialValueFor("arc_lightning_damage_pct")
		local arc_lightning_damage_illusion_pct = hHand:GetSpecialValueFor("arc_lightning_damage_illusion_pct")
		if hCaster:IsIllusion() then
			damage_pct = arc_lightning_damage_illusion_pct
		else
			damage_pct = arc_lightning_damage_pct
		end
	end

	local fDamage = (arc_damage + hTarget:GetHealth() * damage_health_pct * 0.01) * damage_pct * 0.01

	local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf",
		PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_attack1",
		hCaster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(iParticleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc",
		hTarget:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local tDamageTable = {
		ability = self,
		attacker = hCaster,
		victim = hTarget,
		damage = fDamage,
		damage_type = self:GetAbilityDamageType()
	}
	ApplyDamage(tDamageTable)

	self:Jump(hCaster, hTarget, radius, jump_count, jump_delay, arc_damage, damage_health_pct, damage_pct, { hTarget })

	hCaster:EmitSound("Hero_Zuus.ArcLightning.Cast")
end

function zuus_arc_lightning_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()

	if IsValid(hTarget) then ---@cast hTarget CDOTA_BaseNPC
		if not hTarget:TriggerSpellAbsorb(self) then
			self:ArcLightning(hTarget, false)
		end
	end
end

function zuus_arc_lightning_lua:IsHiddenWhenStolen()
	return false
end