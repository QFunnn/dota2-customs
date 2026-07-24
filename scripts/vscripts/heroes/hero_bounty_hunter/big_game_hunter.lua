--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_bounty_hunter_big_game_hunter", "heroes/hero_bounty_hunter/big_game_hunter", LUA_MODIFIER_MOTION_NONE )

if ability_bounty_hunter_big_game_hunter == nil then
	ability_bounty_hunter_big_game_hunter = class({})
end

function ability_bounty_hunter_big_game_hunter:GetIntrinsicModifierName()
	return "modifier_ability_bounty_hunter_big_game_hunter"
end

modifier_ability_bounty_hunter_big_game_hunter = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	RemoveOnDeath			= function(self) return false end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_EVENT_ON_ORDER,
			MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		}
	end
})

function modifier_ability_bounty_hunter_big_game_hunter:OnCreated()
	self:UpdateKV()

	self.jinada_cast = nil
	self.RegisteredAttacks = {}
	self.Gold = 0

	self:SetStackCount(0)

	if IsServer() then
		self:StartIntervalThink(1)
	end
end

modifier_ability_bounty_hunter_big_game_hunter.OnRefresh = modifier_ability_bounty_hunter_big_game_hunter.UpdateKV

function modifier_ability_bounty_hunter_big_game_hunter:UpdateKV()
	local ability = self:GetAbility()
	if ability then
		self.GPMPerCreep = ability:GetSpecialValueFor("gpm_per_creep")
	end
end

function modifier_ability_bounty_hunter_big_game_hunter:OnAbilityDeleted(AbilityName)
	if AbilityName == "bounty_hunter_jinada" then
		self:SetStackCount(0)
		self.Gold = 0
	end
end

function modifier_ability_bounty_hunter_big_game_hunter:OnDeathEvent(event)
	local attacker = event.attacker
	local parent = self:GetParent()
	local target = event.unit
	local ability = event.inflictor

	local bCountDeath = (parent:HasScepter() and ability and ability:GetName() == "bounty_hunter_shuriken_toss") or self.RegisteredAttacks[event.record] == true

	if target and attacker and parent and attacker == parent and bCountDeath and not target:IsIllusion() and not target:IsStrongIllusion() and not target:IsTempestDouble() and not target:IsClone() then
		self:SetStackCount(self:GetStackCount()+self.GPMPerCreep)
	end
end

function modifier_ability_bounty_hunter_big_game_hunter:OnIntervalThink()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local Stacks = self:GetStackCount()

	if parent and ability and Stacks > 0 then
		local GoldPerTick = Stacks / 60
		local Floored = math.floor(GoldPerTick)
		local Diff = math.abs(GoldPerTick - Floored)

		local Bonus = 0
		if Diff > 0 then
			self.Gold = self.Gold + Diff
			if self.Gold >= 1 then
				Bonus = math.floor(self.Gold)
				self.Gold = self.Gold - Bonus
			end
		end

		local ResultGold = Floored + Bonus

		parent:ModifyGoldFiltered(ResultGold, true, DOTA_ModifyGold_GameTick)
	end
end

function modifier_ability_bounty_hunter_big_game_hunter:AttackModifier(event)
	local attacker = event.attacker
	local parent = self:GetParent()

	if attacker and attacker == parent and self:AttackIsJinada(event.target) then
		self.RegisteredAttacks[event.record] = true

		self.jinada_cast = nil
	end
end

function modifier_ability_bounty_hunter_big_game_hunter:OnOrder(event)
	local unit = event.unit
	local ability = event.ability
	local target = event.target

	if unit and unit == self:GetParent() then
		if event.order_type == DOTA_UNIT_ORDER_CAST_TARGET and ability and ability:GetName() == "bounty_hunter_jinada" then
			self.jinada_cast = target
		else
			self.jinada_cast = nil
		end
	end
end

-- function modifier_ability_bounty_hunter_big_game_hunter:OnOrderFully(event)
-- 	print(event.sequence_number_const)
-- 	local unit = EntIndexToHScript(event.units["0"])
-- 	local iAbility = event.entindex_ability
-- 	local orderType = event.order_type
-- 	local queue = event.queue
-- 	local target = event.entindex_target ~= 0 and EntIndexToHScript(event.entindex_target) or nil

-- 	local hAbility = nil
-- 	if iAbility then
-- 		hAbility = EntIndexToHScript(iAbility)
-- 	end

-- 	if orderType == DOTA_UNIT_ORDER_CAST_TARGET and unit and unit == self:GetParent() and hAbility and hAbility:GetName() == "bounty_hunter_jinada" then
-- 		self.jinada_cast = target
-- 	elseif queue == 0 then
-- 		self.jinada_cast = nil
-- 	end
-- end

function modifier_ability_bounty_hunter_big_game_hunter:AttackIsJinada(target)
	local parent = self:GetParent()
	local ability = parent:FindAbilityByName("bounty_hunter_jinada")
	if ability and ability:IsFullyCastable() and (self.jinada_cast == target or ability:GetAutoCastState()) then
		return true
	end

	return false
end

function modifier_ability_bounty_hunter_big_game_hunter:OnAttackRecordDestroy(event)
	if self.RegisteredAttacks[event.record] ~= nil then
		self.RegisteredAttacks[event.record] = nil
	end
end