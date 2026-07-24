--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


witch_doctor_paralyzing_cask_custom = class({})

witch_doctor_paralyzing_cask_custom.modifier_witch_doctor_15 = {2,3,4}
witch_doctor_paralyzing_cask_custom.modifier_witch_doctor_19 = {10,20,30}
witch_doctor_paralyzing_cask_custom.modifier_witch_doctor_20 = {2,4}
witch_doctor_paralyzing_cask_custom.modifier_witch_doctor_21_mana = 300
witch_doctor_paralyzing_cask_custom.modifier_witch_doctor_21_bonus = 1
witch_doctor_paralyzing_cask_custom.modifier_witch_doctor_16 = -3

function witch_doctor_paralyzing_cask_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_cask.vpcf", context )
end

function witch_doctor_paralyzing_cask_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_witch_doctor_16") then
        bonus = self.modifier_witch_doctor_16
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function witch_doctor_paralyzing_cask_custom:OnSpellStart()
	if not IsServer() then return end
	local hTarget = self:GetCursorTarget()
	local speed = self:GetSpecialValueFor("speed")
	local index = DoUniqueString("index")

	local bounc_bonus = 0

	if self:GetCaster():HasModifier("modifier_witch_doctor_21") then
		bounc_bonus = (self:GetCaster():GetMaxMana() / self.modifier_witch_doctor_21_mana) * self.modifier_witch_doctor_21_bonus
	end

	if self:GetCaster():HasModifier("modifier_witch_doctor_15") then
		bounc_bonus = bounc_bonus + self.modifier_witch_doctor_15[self:GetCaster():GetTalentLevel("modifier_witch_doctor_15")]
	end

	self["split_" .. index] = self:GetSpecialValueFor("split_amount")
	self[index] = 1
	local projectile =
	{
		Target = hTarget,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_cask.vpcf",
		bDodgable = false,
		bProvidesVision = false,
		iMoveSpeed = speed,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		ExtraData =
		{
			hero_duration = self:GetSpecialValueFor("hero_duration"),
			creep_duration = self:GetSpecialValueFor("creep_duration"),
			base_damage = self:GetSpecialValueFor("base_damage"),
			bounce_range = self:GetSpecialValueFor("bounce_range"),
			bounces = self:GetSpecialValueFor("bounces") + bounc_bonus,
			speed = speed,
			bounce_delay = self:GetSpecialValueFor("bounce_delay"),
			index = index,
			bFirstCast = 1,
            target_real = hTarget:entindex(),
		}
	}
	self:GetCaster():EmitSound("Hero_WitchDoctor.Paralyzing_Cask_Cast")
	ProjectileManager:CreateTrackingProjectile(projectile)
end

function witch_doctor_paralyzing_cask_custom:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)

    if hTarget == nil then
        if ExtraData.target_real ~= nil then
            hTarget = EntIndexToHScript(ExtraData.target_real)
        end
    end

	if hTarget then
		hTarget:EmitSound("Hero_WitchDoctor.Paralyzing_Cask_Bounce")
		if not hTarget:IsMagicImmune() and (ExtraData.bFirstCast == 0 or not hTarget:TriggerSpellAbsorb(self)) then
			hTarget:AddNewModifier(hTarget, self, "modifier_stunned", {duration = ExtraData.hero_duration * (1 - hTarget:GetStatusResistance())})
			ApplyDamage({victim = hTarget, attacker = self:GetCaster(), ability = self, damage = ExtraData.base_damage, damage_type = self:GetAbilityDamageType()})
		end
	end

	if ExtraData.bounces >= 1 then
		Timers:CreateTimer(ExtraData.bounce_delay, function()
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), hTarget:GetAbsOrigin(), nil, ExtraData.bounce_range, DOTA_UNIT_TARGET_TEAM_ENEMY, self:GetAbilityTargetType(), DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false)
			local tJumpTargets = {}

			for _,unit in pairs(enemies) do
				if hTarget then
					if (unit ~= hTarget) and (not unit:IsOther()) and ((self["split_" .. ExtraData.index] >= 1) or #tJumpTargets == 0) then
						table.insert(tJumpTargets, unit)
						if #tJumpTargets == 2 then
							self[ExtraData.index] = self[ExtraData.index] + 1
							break
						end
					end
				end
			end

			if #tJumpTargets == 0 then
				self.cursed_casket = false
				if self[ExtraData.index] == 1 then
					self[ExtraData.index] = nil
					self["split_" .. ExtraData.index] = nil
				else
					self[ExtraData.index] = self[ExtraData.index] - 1
				end

				if self:GetCaster():HasModifier("modifier_witch_doctor_19") then
					if hTarget then
						local count = ExtraData.bounces
						local damage = ((ExtraData.base_damage * count) + (self:GetSpecialValueFor("bounce_bonus_damage") * count)) / 100 * self.modifier_witch_doctor_19[self:GetCaster():GetTalentLevel("modifier_witch_doctor_19")]
						local duration = ExtraData.hero_duration
						if not hTarget:IsMagicImmune() then
							hTarget:AddNewModifier(hTarget, self, "modifier_stunned", {duration = duration * (1 - hTarget:GetStatusResistance())})
							ApplyDamage({victim = hTarget, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = self:GetAbilityDamageType()})
						end
					end
				end

				if self:GetCaster():HasModifier("modifier_witch_doctor_20") then
					local cooldown = self:GetCooldownTimeRemaining()
					if cooldown - self.modifier_witch_doctor_20[self:GetCaster():GetTalentLevel("modifier_witch_doctor_20")] <= 0 then
						self:EndCooldown()
					else
						self:EndCooldown()
						self:StartCooldown(cooldown - self.modifier_witch_doctor_20[self:GetCaster():GetTalentLevel("modifier_witch_doctor_20")])
					end
				end

				return nil
			elseif #tJumpTargets >= 2 then
				self["split_" .. ExtraData.index] = self["split_" .. ExtraData.index] - 1
			end

			for _, hJumpTarget in pairs(tJumpTargets) do
				local projectile = {
					Target = hJumpTarget,
					Source = hTarget,
					Ability = self,
					EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_cask.vpcf",
					bDodgable = false,
					bProvidesVision = false,
					iMoveSpeed = ExtraData.speed,
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
					ExtraData =
					{
						hero_duration 		= ExtraData.hero_duration,
						creep_duration 		= ExtraData.creep_duration,
						base_damage 		= ExtraData.base_damage + self:GetSpecialValueFor("bounce_bonus_damage"),
						bounce_range 		= ExtraData.bounce_range,
						bounces 			= ExtraData.bounces - 1,
						speed				= ExtraData.speed,
						bounce_delay 		= ExtraData.bounce_delay,
						index 				= ExtraData.index,
						cursed_casket 		= self.cursed_casket,
						bFirstCast			= 0,
                        target_real = hTarget:entindex(),
					}
				}
				ProjectileManager:CreateTrackingProjectile(projectile)
			end
		end)
	else
		self.cursed_casket = false
		if self[ExtraData.index] == 1 then
			self[ExtraData.index] = nil
			self["split_" .. ExtraData.index] = nil
		else
			self[ExtraData.index] = self[ExtraData.index] - 1
		end
		return nil
	end
end