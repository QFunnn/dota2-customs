--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_aegis = class({}) ---@class modifier_aegis : CDOTA_Modifier_Lua

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

function modifier_aegis:ReincarnateTime()
	local playerId
	if self:GetParent().GetPlayerOwnerID then
		playerId = self:GetParent():GetPlayerOwnerID()
	end

	local teamId = PlayerResource:GetTeam(playerId)

	if playerId and teamId and PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_ABANDONED and GameMode.teamAbandonMap[teamId] then
		return nil
	end

	if self:GetStackCount() <= 0 then
		return nil
	end
	if (Util:CheckReincarnationAbilityReady(self:GetParent())) then
		return nil
	end

	if true ~= self:GetParent().bJoiningPvp then
		return self.reincarnate_time
	else
		return nil
	end
end

function modifier_aegis:GetModifierIncomingDamage_Percentage(params)
	local playerId
	if self:GetParent().GetPlayerOwnerID then
		playerId = self:GetParent():GetPlayerOwnerID()
	end

	local teamId = PlayerResource:GetTeam(playerId)

	if playerId and teamId and PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_ABANDONED and GameMode.teamAbandonMap[teamId] then
		return 5000
	else
		return 0
	end
end

---@param keys ModifierInstanceEvent
function modifier_aegis:OnDeath(keys)
	if not IsServer() then return end
	if keys.unit ~= self:GetParent() then return end
	if Util:IsReincarnationWork(self:GetParent()) or self:GetParent().bJoiningPvp == true or self:GetStackCount() <= 0 then
		return
	end

	local caster = self:GetParent()
	local ability = self:GetAbility()
	local reincarnateTime = self.reincarnate_time
	local reincarnateBuffTime = self.reincarnate_buff_time

	Timers:CreateTimer({
		endTime = reincarnateTime,
		callback = function()
			local nParticle = ParticleManager:CreateParticle("particles/items_fx/aegis_respawn_timer.vpcf",
				PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControl(nParticle, 1, Vector(0, 0, 0))
			ParticleManager:SetParticleControl(nParticle, 3, caster:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(nParticle)
			return nil
		end
	})
	Timers:CreateTimer(0.5, function()
		Util:RefreshAbilityAndItem(caster, {
			skeleton_king_reincarnation = true,
			undying_ceaseless_dirge = true
		})
		return nil
	end)
	Timers:CreateTimer({
		endTime = reincarnateTime + 0.3,
		callback = function()
			caster:AddNewModifier(caster, ability, "modifier_aegis_buff", { duration = reincarnateBuffTime })
			return nil
		end
	})
	self:SetStackCount(self:GetStackCount() - 1)

	if GameMode.currentRound.roundNumber >= 15 then
		self:CompensateDeath()
	end
end

function modifier_aegis:CompensateDeath()
	local parent = self:GetParent()
	for _ = 1, 2 do
		local item = ExtenderStash:GiveItemToPlayerStashInventoryOrDrop(parent:GetPlayerOwnerID(),
			"item_relearn_book_lua")
		if item then
			item:SetPurchaseTime(GameRulesCustom:GetGameTime() - 70)
		end
	end

	Barrage:FireBullet({
		type = "aegis_lose_compensate",
		playerId = parent:GetPlayerOwnerID()
	})
end