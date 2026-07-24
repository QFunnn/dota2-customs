--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_aegis = class({})

function modifier_aegis:IsHidden()
	return (self:GetStackCount() <= 0)
end

function modifier_aegis:GetTexture()
	return "item_aegis"
end

function modifier_aegis:IsPermanent()
	return true
end

function modifier_aegis:IsPurgable()
	return false
end

function modifier_aegis:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_REINCARNATION,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_aegis:OnCreated()
	if IsServer() then
		self.reincarnate_time = 5
		self.reincarnate_buff_time = 14
	end
end

--PVP无效 断线队伍无效
function modifier_aegis:ReincarnateTime()
	local nPlayerID
	if self:GetParent().GetPlayerOwnerID then
		nPlayerID = self:GetParent():GetPlayerOwnerID()
	end

	local nTeamID = PlayerResource:GetTeam(nPlayerID)

	if nPlayerID and nTeamID and PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_ABANDONED and GameRules.teamAbandonMap[nTeamID] then
		return nil
	end

	--如果层数不够就不触发了
	if self:GetStackCount() <= 0 then
		return nil
	end

	if true ~= self:GetParent().bJoiningPvp then
		return self.reincarnate_time
	else
		return nil
	end
end

-- 断线队伍收到伤害增加
function modifier_aegis:GetModifierIncomingDamage_Percentage(params)
	local nPlayerID
	if self:GetParent().GetPlayerOwnerID then
		nPlayerID = self:GetParent():GetPlayerOwnerID()
	end

	local nTeamID = PlayerResource:GetTeam(nPlayerID)

	if nPlayerID and nTeamID and PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_ABANDONED and GameRules.teamAbandonMap[nTeamID] then
		return 5000
	else
		return 0
	end
end

function modifier_aegis:OnDeath(keys)
	if IsServer() then
		if keys.unit == self:GetParent() then
			-- print(self:GetParent():GetUnitName(), self:GetParent():IsIllusion())
			if self:GetParent().__InRoundBattle__ == false then
				return
			end

			--没有触发重生技能，并且不参与PVP才消耗层数
			if not Util:IsReincarnationWork(self:GetParent()) and true ~= self:GetParent().bJoiningPvp and (self:GetStackCount() >= 1) then
				-- print("modifier_aegis:OnDeath")
				local hCaster = self:GetParent()
				local hAbility = self:GetAbility()
				local flReincarnateTime = self.reincarnate_time
				local flReincarnateBuffTime = self.reincarnate_buff_time

				Timers:CreateTimer({
					endTime = flReincarnateTime,
					callback = function()
						local nParticle = ParticleManager:CreateParticle("particles/items_fx/aegis_respawn_timer.vpcf",
							PATTACH_ABSORIGIN_FOLLOW, hCaster)
						ParticleManager:SetParticleControl(nParticle, 1, Vector(0, 0, 0))
						ParticleManager:SetParticleControl(nParticle, 3, hCaster:GetAbsOrigin())
						ParticleManager:ReleaseParticleIndex(nParticle)
					end
				})
				Timers:CreateTimer({
					endTime = flReincarnateTime + 0.3,
					callback = function()
						Util:RefreshAbilityAndItem(hCaster, { skeleton_king_reincarnation = true })
						hCaster:AddNewModifier(hCaster, hAbility, "modifier_aegis_buff",
							{ duration = flReincarnateBuffTime })
					end
				})
				--削减层数
				local nStackCount = self:GetStackCount()
				self:SetStackCount(nStackCount - 1)
			end
		end
	end
end