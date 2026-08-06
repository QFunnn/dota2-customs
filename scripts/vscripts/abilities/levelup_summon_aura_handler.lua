--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_levelup_summon_aura_manager",
	"abilities/levelup_summon_aura_handler",
	LUA_MODIFIER_MOTION_NONE
)

levelup_summon_aura_handler = class({})

function levelup_summon_aura_handler:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_summon_aura_handler:GetIntrinsicModifierName()
	return "modifier_levelup_summon_aura_manager"
end

modifier_levelup_summon_aura_manager = class({})

function modifier_levelup_summon_aura_manager:IsHidden()
	return true
end
function modifier_levelup_summon_aura_manager:IsPurgable()
	return false
end
function modifier_levelup_summon_aura_manager:IsPurgeException()
	return false
end
function modifier_levelup_summon_aura_manager:IsPermanent()
	return true
end
function modifier_levelup_summon_aura_manager:RemoveOnDeath()
	return false
end

function modifier_levelup_summon_aura_manager:OnCreated()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	self.player_id = parent:GetPlayerOwnerID()
	self.owner_hero_aura_source_key = "__levelup_summon_aura_owner_total"
	self.aura_sources = self.aura_sources or {}
	self.aura_cache_base, self.aura_cache_bonus, self.aura_cache = summon_aura_system:BuildAuraCache(self.aura_sources)

	parent.modifier_levelup_summon_aura_manager = self

	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(self) then
			return nil
		end
		self:SyncOwnerHeroAuraBonus()
		self:RefreshAllSummons()
		return nil
	end)
end

function modifier_levelup_summon_aura_manager:RebuildAuraCache()
	self.aura_cache_base, self.aura_cache_bonus, self.aura_cache =
		summon_aura_system:BuildAuraCache(self.aura_sources or {})
	self:SyncOwnerHeroAuraBonus()
end

function modifier_levelup_summon_aura_manager:SyncOwnerHeroAuraBonus()
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end

	local hero_bonus_entry = {
		base = summon_aura_system:CloneAuraBucket(self.aura_cache_base),
		bonus = summon_aura_system:CloneAuraBucket(self.aura_cache_bonus),
	}

	if HasAnyStatBonuses and HasAnyStatBonuses(hero_bonus_entry) then
		parent:LevelUpSetCustomStatsBonus(self.owner_hero_aura_source_key, hero_bonus_entry)
		return
	end

	parent:LevelUpClearCustomStatsBonus(self.owner_hero_aura_source_key)
end

function modifier_levelup_summon_aura_manager:SetAuraBonusFromSource(source_key, bonus_table, mode_or_options)
	if source_key == nil then
		return false
	end

	self.aura_sources = self.aura_sources or {}
	self.aura_sources[tostring(source_key)] = summon_aura_system:NormalizeSourceEntry(bonus_table, mode_or_options)

	self:RebuildAuraCache()
	self:RefreshAllSummons()
	return true
end

function modifier_levelup_summon_aura_manager:ClearAuraBonusFromSource(source_key)
	if source_key == nil then
		return false
	end
	if not self.aura_sources then
		return false
	end
	if self.aura_sources[tostring(source_key)] == nil then
		return false
	end

	self.aura_sources[tostring(source_key)] = nil
	self:RebuildAuraCache()
	self:RefreshAllSummons()
	return true
end

function modifier_levelup_summon_aura_manager:ClearAllAuraBonuses()
	self.aura_sources = {}
	self:RebuildAuraCache()
	self:RefreshAllSummons()
end

function modifier_levelup_summon_aura_manager:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end

	parent:LevelUpClearCustomStatsBonus(self.owner_hero_aura_source_key or "__levelup_summon_aura_owner_total")
	if parent.modifier_levelup_summon_aura_manager == self then
		parent.modifier_levelup_summon_aura_manager = nil
	end
end

function modifier_levelup_summon_aura_manager:GetAuraCache()
	return summon_aura_system:CloneAuraBucket(self.aura_cache)
end

function modifier_levelup_summon_aura_manager:ApplyAuraToSummon(summon)
	if not IsValid(summon) or not IsLevelUpSummon(summon) or IsLevelUpGameplayInteractionIgnored(summon) then
		return false
	end

	local receiver = summon:FindModifierByName("modifier_levelup_summon_aura_receiver")
	if receiver == nil or (receiver.IsNull and receiver:IsNull()) then
		receiver = summon:AddNewModifier(self:GetParent(), nil, "modifier_levelup_summon_aura_receiver", {})
	end

	if receiver and receiver.ForceRefreshFromManager then
		receiver:ForceRefreshFromManager(self)
		return true
	end

	return false
end

function modifier_levelup_summon_aura_manager:RefreshAllSummons()
	if self.player_id == nil or self.player_id < 0 then
		return
	end

	local summons = summon_aura_system:GetSummonsForPlayer(self.player_id)
	for _, summon in ipairs(summons) do
		self:ApplyAuraToSummon(summon)
	end
end