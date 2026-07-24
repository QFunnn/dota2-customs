--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_fountain_thinker = class({})

function modifier_fountain_thinker:IsHidden()
	return true
end

function modifier_fountain_thinker:IsDebuff()
	return false
end

function modifier_fountain_thinker:IsPurgable()
	return false
end

function modifier_fountain_thinker:IsPurgeException()
	return false
end

function modifier_fountain_thinker:AllowIllusionDuplicate()
	return false
end

function modifier_fountain_thinker:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		if IsValid(hParent) then
			hParent:RemoveSelf()
		end
	end
end

function modifier_fountain_thinker:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end

function modifier_fountain_thinker:IsAura()
	return true
end

function modifier_fountain_thinker:GetAuraRadius()
	return 2000
end

function modifier_fountain_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_fountain_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_fountain_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end

function modifier_fountain_thinker:GetModifierAura()
	return "modifier_hero_refreshing"
end

function modifier_fountain_thinker:IsAuraActiveOnDeath()
	return true
end

-----------------------------------
modifier_hero_refreshing = class({})


function modifier_hero_refreshing:GetTexture()
	return "fountain_heal"
end

function modifier_hero_refreshing:IsHidden()
	return false
end

function modifier_hero_refreshing:IsDebuff()
	return false
end

function modifier_hero_refreshing:IsPurgable()
	return false
end

function modifier_hero_refreshing:RemoveOnDeath()
	local hParent = self:GetParent()
	return (not hParent:IsRealHero())
end

function modifier_hero_refreshing:OnCreated(kv)
	if IsServer() then
		local hParent = self:GetParent()
		self.flInterval = 0.2
		-- self.nParticleIndex = ParticleManager:CreateParticle("particles/items_fx/bottle.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		if hParent:IsRealHero() then
			local vPos = GoodFrogPos or Vector(0, 0, 128)
			local particleID = ParticleManager:CreateParticle("particles/generic_gameplay/radiant_fountain_regen.vpcf",
				PATTACH_ABSORIGIN_FOLLOW, hParent)
			ParticleManager:SetParticleControl(particleID, 1, vPos)
			-- ParticleManager:SetParticleControlEnt(particleID, 1, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
			self:AddParticle(particleID, true, false, -1, false, false)


			self:StartIntervalThink(self.flInterval)
			--禁用技能表
			self.disableAbilityList = {
				"furion_teleportation",
				"wisp_relocate",
				"phoenix_supernova",
				"shredder_timber_chain",
				"ancient_apparition_ice_blast",
				"brewmaster_primal_split",
				"life_stealer_infest",
				"shadow_demon_disruption",
				-- "alchemist_unstable_concoction"
			}

			hParent:Purge(false, true, false, true, true)
			ProjectileManager:ProjectileDodge(hParent)

			--先执行一次把技能禁用
			self:OnIntervalThink()
		end
	end
end

function modifier_hero_refreshing:OnDestroy(kv)
	if IsServer() then
		local hParent = self:GetParent()

		if hParent:IsRealHero() then
			for _, sAbilityName in ipairs(self.disableAbilityList) do
				if self:GetParent():HasAbility(sAbilityName) then
					self:GetParent():FindAbilityByName(sAbilityName):SetActivated(true)
				end
			end
		end
		-- ParticleManager:DestroyParticle(self.nParticleIndex, false)
		-- ParticleManager:ReleaseParticleIndex(self.nParticleIndex)
	end
end

--遍历全部的技能 加速其CD
function modifier_hero_refreshing:OnIntervalThink()
	if IsServer() then
		local hParent = self:GetParent()

		if (not IsValid(hParent)) or (not hParent:IsAlive()) then
			self:Destroy()
		end

		for _, sAbilityName in ipairs(self.disableAbilityList) do
			if hParent:HasAbility(sAbilityName) then
				hParent:FindAbilityByName(sAbilityName):SetActivated(false)
			end
		end

		if hParent:HasModifier("modifier_ice_blast") then
			hParent:RemoveModifierByName("modifier_ice_blast")
		end
		if hParent:HasModifier("modifier_oracle_false_promise") then
			hParent:RemoveModifierByName("modifier_oracle_false_promise")
		end
		for i = 1, hParent:GetAbilityCount() - 1 do
			local hAbility = hParent:GetAbilityByIndex(i - 1)
			if hAbility and hAbility.GetCooldownTimeRemaining then
				local flRemaining = hAbility:GetCooldownTimeRemaining()
				if self.flInterval < flRemaining then
					--加快冷却速度 --先结束 再设置 这样UI上比较平滑
					hAbility:EndCooldown()
					hAbility:StartCooldown(flRemaining - self.flInterval)
				end
			end
			--重置决斗状态
			if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName() == "legion_commander_duel" then
				hAbility.bRoundDueled = false
			end
		end

		--灌瓶
		if self:GetParent() and self:GetParent():IsRealHero() then
			for i = 0, 32 do
				local hItem = self:GetParent():GetItemInSlot(i)
				if hItem and not hItem:IsNull() and hItem.GetAbilityName and "item_bottle" == hItem:GetAbilityName() then
					local nCurrentCharges = hItem:GetCurrentCharges()
					-- 0 1 2三种充能
					if nCurrentCharges < 3 and nCurrentCharges >= 0 then
						hItem:SetCurrentCharges(nCurrentCharges + 1)
					end
				end
			end
		end
	end
end

function modifier_hero_refreshing:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_hero_refreshing:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_hero_refreshing:OnDeath(keys)
	if IsServer() then
		local hParent = self:GetParent()
		if keys.unit == hParent then
			Timers:CreateTimer({
				endTime = 0.1,
				callback = function()
					hParent:RespawnHero(false, false)
					local nParticle = ParticleManager:CreateParticle("particles/items_fx/aegis_respawn_timer.vpcf",
						PATTACH_ABSORIGIN_FOLLOW, hParent)
					ParticleManager:SetParticleControl(nParticle, 1, Vector(0, 0, 0))
					ParticleManager:SetParticleControl(nParticle, 3, hParent:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(nParticle)
				end
			})
		end
	end
end

function modifier_hero_refreshing:GetModifierHealthRegenPercentage(params)
	return 8
end

function modifier_hero_refreshing:GetModifierTotalPercentageManaRegen(params)
	return 8
end