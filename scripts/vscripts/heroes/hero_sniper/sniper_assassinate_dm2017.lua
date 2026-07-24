--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


sniper_assassinate_dm2017 = class({})

LinkLuaModifier("modifier_sniper_assassinate_dm2017", "heroes/hero_sniper/sniper_assassinate_dm2017.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_assassinate_dm2017_crit", "heroes/hero_sniper/sniper_assassinate_dm2017.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_assassinate_dm2017_cast_point", "heroes/hero_sniper/sniper_assassinate_dm2017.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_assassinate_dm2017_ignore_passives", "heroes/hero_sniper/sniper_assassinate_dm2017.lua", LUA_MODIFIER_MOTION_NONE)

function sniper_assassinate_dm2017:GetCastPoint()
	local aim_duration = self:GetSpecialValueFor("aim_duration")
	return (100 - (self.cast_point_pct or 0)) * aim_duration * 0.01
end
--------------------------------------------------------------------------------

function sniper_assassinate_dm2017:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function sniper_assassinate_dm2017:GetIntrinsicModifierName()
	local hCaster = self:GetCaster()
	if hCaster:HasAbility("sniper_assassinate_dm2017") then
		return "modifier_sniper_assassinate_dm2017_cast_point"
	end
end
function sniper_assassinate_dm2017:GetPlaybackRateOverride()
	return 1 / ((100 - (self.cast_point_pct or 0)) * 0.01)
end
--------------------------------------------------------------------------------

-- function sniper_assassinate_dm2017:GetBehavior()
--	 if self:GetCaster():HasScepter() then
--		 return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
--	 end

--	 return self.BaseClass.GetBehavior(self)
-- end

--------------------------------------------------------------------------------

function sniper_assassinate_dm2017:OnAbilityPhaseStart()
	-- if IsServer() then
	local aim_duration = self:GetSpecialValueFor("aim_duration")
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		hTarget:AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_dm2017", { duration = aim_duration + 0.5 })
		-- elseif self:GetCaster():HasScepter() then
		--	 self.hScepterTargets = {}
		--	 local scepter_radius = self:GetSpecialValueFor("scepter_radius")
		--	 local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCursorPosition(), nil, scepter_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
		--	 for _, enemy in pairs(enemies) do
		--		 if IsValid(enemy) then

		--			 enemy:AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_dm2017", { duration = aim_duration + 0.5 })
		--			 table.insert(self.hScepterTargets, enemy)
		--		 end
		--	 end
	end

	EmitSoundOn("Ability.AssassinateLoad", self:GetCaster())
	-- end

	return true
end

--------------------------------------------------------------------------------

function sniper_assassinate_dm2017:OnAbilityPhaseInterrupted()
	-- if IsServer() then
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		-- hTarget:RemoveModifierByName("modifier_sniper_assassinate_dm2017")
		-- elseif self:GetCaster():HasScepter() then
		--	 for i = #self.hScepterTargets, 1, -1 do
		--		 local enemy = self.hScepterTargets[i]
		--		 if enemy ~= nil then
		--			 enemy:RemoveModifierByName("modifier_sniper_assassinate_dm2017")
		--			 table.remove(self.hScepterTargets, i)
		--		 end
		--	 end
		--	 self.hScepterTargets = {}
	end
	-- end
end

--------------------------------------------------------------------------------

function sniper_assassinate_dm2017:OnSpellStart()
	-- if IsServer() then
	self.bInBuckshot = false
	local hTarget = self:GetCursorTarget()
	local radius = self:GetSpecialValueFor("radius")
	if IsValid(hTarget) then
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), hTarget:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
		for _, enemy in pairs(enemies) do
			if IsValid(enemy) and enemy:IsAlive() then
				local info =						{
					EffectName = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf";
					Target = enemy,
					Source = self:GetCaster(),
					Ability = self,
					iMoveSpeed = self:GetSpecialValueFor("projectile_speed")
				}
				ProjectileManager:CreateTrackingProjectile(info)
				EmitSoundOn("Ability.Assassinate", self:GetCaster())
				EmitSoundOn("Hero_Sniper.AssassinateProjectile", self:GetCaster())
			end
		end
	end
	-- end
end

--------------------------------------------------------------------------------

function sniper_assassinate_dm2017:OnProjectileHit(hTarget, vLocation)
	local hCaster = self:GetCaster()
	-- if IsServer() then
	if IsValid(hTarget) then
		EmitSoundOn("Hero_Sniper.AssassinateDamage", hTarget)
		-- hTarget:RemoveModifierByName("modifier_sniper_assassinate_dm2017")
		if (not hTarget:IsInvulnerable()) and (not hTarget:TriggerSpellAbsorb(self)) then
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_dm2017_crit", {})
			if hCaster:HasScepter() then
				hTarget:AddNewModifier(hCaster, self, "modifier_sniper_assassinate_dm2017_ignore_passives", { duration = 0.5 })
			end
			self:GetCaster():PerformAttack(hTarget, true, true, true, true, false, false, true)
			self:GetCaster():RemoveModifierByName("modifier_sniper_assassinate_dm2017_crit")
			if IsValid(hTarget) and hTarget:IsAlive() then
				if hCaster:HasScepter() then
					hTarget:RemoveModifierByName("modifier_sniper_assassinate_dm2017_ignore_passives")
				end
				hTarget:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = self:GetSpecialValueFor("stun_duration") * hTarget:GetStatusResistanceFactor(hCaster) })
			end
			-- if self:GetCaster():HasScepter() then
			--	 -- self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_caster", {})
			--	 hTarget:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = self:GetSpecialValueFor("stun_duration") })
			--	 -- self:GetCaster():RemoveModifierByName("modifier_sniper_assassinate_caster")
			-- else
			--	 if self.bInBuckshot == false then
			--		 local damage =						{
			--			 victim = hTarget,
			--			 attacker = self:GetCaster(),
			--			 ability = self,
			--			 damage = self:GetSpecialValueFor("assassinate_damage"),
			--			 damage_type = DAMAGE_TYPE_PURE,
			--		 }

			--		 ApplyDamage(damage)
			--		 

			--		 -- stun the main target
			--		 hTarget:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = self:GetSpecialValueFor("stun_duration") })

			--		 local vToTarget = hTarget:GetOrigin() - self:GetCaster():GetOrigin()
			--		 vToTarget = vToTarget:Normalized()

			--		 local vSideTarget = Vector(vToTarget.y, -vToTarget.x, 0)
			--		 local scatter_range = self:GetSpecialValueFor("scatter_range")
			--		 local scatter_width = self:GetSpecialValueFor("scatter_width")

			--		 local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), hTarget:GetOrigin(), self:GetCaster(), scatter_range + scatter_width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
			--		 if #enemies > 0 then
			--			 for _, enemy in pairs(enemies) do
			--				 if enemy ~= nil and not enemy:IsInvulnerable() then
			--					 local vToPotentialTarget = enemy:GetOrigin() - hTarget:GetOrigin()
			--					 local flSideAmount = math.abs(vToPotentialTarget.x * vSideTarget.x + vToPotentialTarget.y * vSideTarget.y + vToPotentialTarget.z * vSideTarget.z)
			--					 local flLengthAmount = (vToPotentialTarget.x * vToTarget.x + vToPotentialTarget.y * vToTarget.y + vToPotentialTarget.z * vToTarget.z)
			--					 if (flSideAmount < scatter_width) and (flLengthAmount > 0) and (flLengthAmount < scatter_range) then
			--						 local info =										{
			--							 EffectName = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf";
			--							 Target = enemy,
			--							 Source = hTarget,
			--							 Ability = self,
			--							 iMoveSpeed = self:GetSpecialValueFor("projectile_speed") / 2
			--						 }

			--						 ProjectileManager:CreateTrackingProjectile(info)
			--						 EmitSoundOn("Hero_Sniper.AssassinateProjectile_Scatter", enemy)
			--					 end
			--				 end
			--			 end
			--		 end
			--		 self.bInBuckshot = true
			--	 else
			--		 local damage =						{
			--			 victim = hTarget,
			--			 attacker = self:GetCaster(),
			--			 ability = self,
			--			 damage = self:GetSpecialValueFor("assassinate_damage") * 0.4,
			--			 damage_type = DAMAGE_TYPE_PURE,
			--		 }

			--		 ApplyDamage(damage)
			--		 EmitSoundOn("Hero_Sniper.AssassinateDamage_Scatter", hTarget)
			--	 end
			-- end
		end
	end
	-- end

	return true
end
-----------------------------------------------------------------------
-- modifier_sniper_assassinate_dm2017 = class({})
-- function modifier_sniper_assassinate_dm2017:IsHidden()
--	 return false
-- end
-- function modifier_sniper_assassinate_dm2017:IsPurgable()
--	 return false
-- end
-- function modifier_sniper_assassinate_dm2017:IsDebuff()
--	 return true
-- end
-- function modifier_sniper_assassinate_dm2017:GetEffectAttachType()
--	 return PATTACH_OVERHEAD_FOLLOW
-- end
-- function modifier_sniper_assassinate_dm2017:GetEffectName()
--	 return "particles/units/heroes/hero_sniper/sniper_crosshair.vpcf"
-- end
-----------------------------------------------------------------------
modifier_sniper_assassinate_dm2017_crit = class({})
function modifier_sniper_assassinate_dm2017_crit:IsHidden()
	return true
end
function modifier_sniper_assassinate_dm2017_crit:IsPurgable()
	return false
end
function modifier_sniper_assassinate_dm2017_crit:IsDebuff()
	return false
end
function modifier_sniper_assassinate_dm2017_crit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	}
end
function modifier_sniper_assassinate_dm2017_crit:GetModifierPreAttack_CriticalStrike()
	return self:GetAbility():GetSpecialValueFor("crit_bonus")
end
---------------------------------------------------------------------------
modifier_sniper_assassinate_dm2017_cast_point = class({})
function modifier_sniper_assassinate_dm2017_cast_point:IsHidden()
	local hCaster = self:GetCaster()
	if hCaster:HasScepter() then
		return false
	else
		return true
	end
end
function modifier_sniper_assassinate_dm2017_cast_point:IsPurgable()
	return false
end
function modifier_sniper_assassinate_dm2017_cast_point:IsDebuff()
	return false
end
function modifier_sniper_assassinate_dm2017_cast_point:OnCreated()
	if IsServer() then
		self:StartIntervalThink(0)
	end
end
function modifier_sniper_assassinate_dm2017_cast_point:OnIntervalThink()
	local hCaster = self:GetCaster()
	if self:GetAbility() ~= nil then
		if IsValid(hCaster) and hCaster:HasScepter() then
			local cast_point_reduce = self:GetAbility():GetSpecialValueFor("cast_point_reduce")
			self:SetStackCount(math.min(hCaster:GetDisplayAttackSpeed() * cast_point_reduce, 100))
		else
			self:SetStackCount(0)
		end
	end
end
function modifier_sniper_assassinate_dm2017_cast_point:OnStackCountChanged(iStackCount)
	if self:GetAbility() ~= nil then
		self:GetAbility().cast_point_pct = self:GetStackCount()
	end
end
function modifier_sniper_assassinate_dm2017_cast_point:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP
	}
end
function modifier_sniper_assassinate_dm2017_cast_point:OnTooltip()
	return self:GetStackCount()
end
-----------------------------------------------------------------------------------------------
modifier_sniper_assassinate_dm2017_ignore_passives = class({})
function modifier_sniper_assassinate_dm2017_ignore_passives:IsHidden()
	return true
end
function modifier_sniper_assassinate_dm2017_ignore_passives:IsPurgable()
	return false
end
function modifier_sniper_assassinate_dm2017_ignore_passives:IsDebuff()
	return true
end
function modifier_sniper_assassinate_dm2017_ignore_passives:CheckState()
	return {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true
	}
end