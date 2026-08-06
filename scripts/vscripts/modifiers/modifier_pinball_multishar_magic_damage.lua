--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


modifier_pinball_multishar_magic_damage = class({})

function modifier_pinball_multishar_magic_damage:IsHidden()
	return false
end
function modifier_pinball_multishar_magic_damage:IsPurgable()
	return false
end
function modifier_pinball_multishar_magic_damage:RemoveOnDeath()
	return true
end

function modifier_pinball_multishar_magic_damage:OnCreated(kv)
	kv = kv or {}
	self.magical_damage_pct_per_stack = tonumber(kv.magical_damage_pct_per_stack) or 0
	self.stack_duration = math.max(0.1, tonumber(kv.stack_duration) or tonumber(kv.duration) or 3)

	if not IsServer() then
		return
	end
	self.source_key = "pinball_multishar_magic_damage:" .. tostring(self:GetParent():entindex())
	self.stack_expire_times = {}
	self:AddStack(self.stack_duration)
	self:StartIntervalThink(0.05)
end

function modifier_pinball_multishar_magic_damage:OnRefresh(kv)
	kv = kv or {}
	self.magical_damage_pct_per_stack = tonumber(kv.magical_damage_pct_per_stack)
		or self.magical_damage_pct_per_stack
		or 0
	self.stack_duration =
		math.max(0.1, tonumber(kv.stack_duration) or tonumber(kv.duration) or self.stack_duration or 3)

	if not IsServer() then
		return
	end
	self:AddStack(self.stack_duration)
	self:SetDuration(self.stack_duration, true)
end

function modifier_pinball_multishar_magic_damage:AddStack(duration)
	self.stack_expire_times = self.stack_expire_times or {}
	table.insert(self.stack_expire_times, GameRules:GetGameTime() + math.max(0.1, tonumber(duration) or 3))
	self:RefreshStackBonus()
end

function modifier_pinball_multishar_magic_damage:PruneExpiredStacks()
	local now = GameRules:GetGameTime()
	local old_count = #(self.stack_expire_times or {})
	local write_index = 1

	for _, expire_time in ipairs(self.stack_expire_times or {}) do
		if (tonumber(expire_time) or 0) > now then
			self.stack_expire_times[write_index] = expire_time
			write_index = write_index + 1
		end
	end

	for index = #(self.stack_expire_times or {}), write_index, -1 do
		self.stack_expire_times[index] = nil
	end
	return old_count ~= #(self.stack_expire_times or {})
end

function modifier_pinball_multishar_magic_damage:RefreshStackBonus()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local stack_count = #(self.stack_expire_times or {})
	self:SetStackCount(stack_count)

	if stack_count <= 0 then
		self:Destroy()
		return
	end

	if IsValid(parent) and parent.LevelUpSetCustomStatsBonus then
		parent:LevelUpSetCustomStatsBonus(self.source_key, {
			magical_damage_pct = stack_count * (tonumber(self.magical_damage_pct_per_stack) or 0),
		}, "bonus")
	end
	self:SendBuffRefreshToClients()
end

function modifier_pinball_multishar_magic_damage:OnIntervalThink()
	if self:PruneExpiredStacks() then
		self:RefreshStackBonus()
	end
end

function modifier_pinball_multishar_magic_damage:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) and self.source_key and parent.LevelUpClearCustomStatsBonus then
		parent:LevelUpClearCustomStatsBonus(self.source_key)
	end
end