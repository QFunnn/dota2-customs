--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____PostureBarRules = require("modifiers.state.PostureBarRules")
local PostureBarRules = ____PostureBarRules.PostureBarRules
--- 架势条调试打印开关：需要排查涨条/硬直时改为 true。
local POSTURE_BAR_DEBUG_PRINT = false
local function PostureBarDebugPrint(self, message)
	if POSTURE_BAR_DEBUG_PRINT then
		print(message)
	end
end
____exports.modifier_cs_posture_bar = __TS__Class()
local modifier_cs_posture_bar = ____exports.modifier_cs_posture_bar
modifier_cs_posture_bar.name = "modifier_cs_posture_bar"
__TS__ClassExtends(modifier_cs_posture_bar, BaseModifier_CS)
function modifier_cs_posture_bar.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._threshold = PostureBarRules.DEFAULT_THRESHOLD
	self._lastDecayTime = 0
	self._lastHp = 0
	self._nearbyPlayerMultiplier = 1
	self._lastNearbyPlayerMultiplierRefreshTime = 0
	self._staggerStartTime = 0
	self._initialStaggerDuration = 0
	self._damageTakenDuringStaggerPct = 0
	self._stunPostureAccumulatedTime = 0
end
function modifier_cs_posture_bar.prototype.IsDebuff(self)
	return false
end
function modifier_cs_posture_bar.prototype.IsHidden(self)
	return true
end
function modifier_cs_posture_bar.prototype.IsPurgable(self)
	return false
end
function modifier_cs_posture_bar.prototype.IsPurgeException(self)
	return false
end
function modifier_cs_posture_bar.prototype.IsPermanent(self)
	return true
end
function modifier_cs_posture_bar.prototype.RemoveOnDeath(self)
	return true
end
function modifier_cs_posture_bar.prototype.DeclareEvents(self)
	return {
		BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST,
		{ event = BusinessEvents.ON_POSTURE_COUNTER_HIT, target = { scope = "global" } },
	}
end
function modifier_cs_posture_bar.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._threshold = params and params.threshold or PostureBarRules.DEFAULT_THRESHOLD
	self:SetStackCount(params and params.initial or 0)
	self._lastDecayTime = GameRules:GetGameTime()
	local ____IsValidAlive_result_4
	if IsValidAlive(nil, parent) then
		____IsValidAlive_result_4 = parent:GetHealth()
	else
		____IsValidAlive_result_4 = 0
	end
	self._lastHp = ____IsValidAlive_result_4
	self:_refreshNearbyPlayerMultiplier(parent, true)
	self:StartIntervalThink(FrameTime())
end
function modifier_cs_posture_bar.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local now = GameRules:GetGameTime()
	local currentHp = parent:GetHealth()
	local maxHp = parent:GetMaxHealth()
	local ent = parent:GetEntityIndex()
	local tag = "[PostureBar] unit=" .. tostring(ent)
	self:_refreshNearbyPlayerMultiplier(parent)
	if self._staggerStartTime > 0 then
		local hpLost = math.max(0, self._lastHp - currentHp)
		self._damageTakenDuringStaggerPct = self._damageTakenDuringStaggerPct
			+ PostureBarRules:GetDamageTakenPct(hpLost, maxHp)
		local endTime = PostureBarRules:GetStaggerEndTime(self._staggerStartTime, self._damageTakenDuringStaggerPct)
		if now >= endTime then
			PostureBarDebugPrint(nil, tag .. " 触发: 硬直结束，移除眩晕，stack 置 0")
			parent:RemoveModifierByName(PostureBarRules.NATIVE_STUN_MODIFIER)
			self._staggerStartTime = 0
			self._initialStaggerDuration = 0
			self._damageTakenDuringStaggerPct = 0
			self:SetStackCount(0)
		else
			local remaining = endTime - now
			local stack =
				PostureBarRules:GetStaggerStackDisplay(remaining, self._initialStaggerDuration, self._threshold)
			self:SetStackCount(stack)
		end
		self._lastHp = currentHp
		return
	end
	if self:GetStackCount() >= self._threshold then
		PostureBarDebugPrint(nil, tag .. " 触发: 满层重置(未进硬直)，stack 置 0")
		self:SetStackCount(0)
		self._lastHp = currentHp
		return
	end
	if not self:_isPostureLocked() and maxHp > 0 then
		local hpLost = math.max(0, self._lastHp - currentHp)
		if hpLost > 0 then
			local addFloor = PostureBarRules:GetDamagePostureGain(hpLost, maxHp, self._nearbyPlayerMultiplier)
			local newStack = PostureBarRules:AddStack(self:GetStackCount(), addFloor, self._threshold)
			self:SetStackCount(newStack)
			PostureBarDebugPrint(
				nil,
				(
					(
						(
							(
								(((tag .. " 触发: 受击加层 +") .. tostring(addFloor)) .. " 多人倍率=")
								.. tostring(self._nearbyPlayerMultiplier)
							) .. " 当前 stack="
						) .. tostring(newStack)
					) .. "/"
				) .. tostring(self._threshold)
			)
			self:_tryEnterStagger()
		end
	end
	if
		not self:_isPostureLocked()
		and parent:HasModifier(PostureBarRules.NATIVE_STUN_GENERIC)
		and self._staggerStartTime <= 0
	then
		self._stunPostureAccumulatedTime = self._stunPostureAccumulatedTime + FrameTime()
		local stunAdds = 0
		while self._stunPostureAccumulatedTime >= PostureBarRules.STUN_ACCUMULATE_INTERVAL do
			self._stunPostureAccumulatedTime = self._stunPostureAccumulatedTime
				- PostureBarRules.STUN_ACCUMULATE_INTERVAL
			self:SetStackCount(
				PostureBarRules:AddStack(
					self:GetStackCount(),
					PostureBarRules.STUN_POSTURE_ADD_PER_INTERVAL,
					self._threshold
				)
			)
			stunAdds = stunAdds + 1
			self:_tryEnterStagger()
		end
		if stunAdds > 0 then
			PostureBarDebugPrint(
				nil,
				(
					(
						(((tag .. " 触发: 眩晕积累 +") .. tostring(stunAdds)) .. " 当前 stack=")
						.. tostring(self:GetStackCount())
					) .. "/"
				) .. tostring(self._threshold)
			)
		end
	else
		self._stunPostureAccumulatedTime = 0
	end
	self._lastHp = currentHp
	local elapsed = now - self._lastDecayTime
	if elapsed >= 1 then
		local steps = PostureBarRules:GetDecaySteps(elapsed)
		self._lastDecayTime = self._lastDecayTime + steps
		local before = self:GetStackCount()
		self:SetStackCount(PostureBarRules:ApplyNaturalDecay(before, steps))
		local after = self:GetStackCount()
		if after ~= before then
			PostureBarDebugPrint(
				nil,
				(
					(
						(((tag .. " 触发: 衰减 -") .. tostring(before - after)) .. " 当前 stack=")
						.. tostring(after)
					) .. "/"
				) .. tostring(self._threshold)
			)
		end
	end
end
function modifier_cs_posture_bar.prototype.OnPostureCounterHit_CS(self, ev)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if parent:GetEntityIndex() ~= ev.unit_id then
		return
	end
	if self._staggerStartTime > 0 then
		return
	end
	local bonus = PostureBarRules:GetCounterHitBonus(self._threshold)
	if bonus > 0 then
		local current = self:GetStackCount()
		local newStack = PostureBarRules:AddStack(current, bonus, self._threshold)
		self:SetStackCount(newStack)
		PostureBarDebugPrint(
			nil,
			(
				(
					(
						(
							(
								(
									(("[PostureBar] unit=" .. tostring(ev.unit_id)) .. " 触发: 破招奖励(阈值")
									.. tostring(PostureBarRules.COUNTER_HIT_BONUS_PCT)
								) .. "%) +"
							) .. tostring(bonus)
						) .. " 当前 stack="
					) .. tostring(newStack)
				) .. "/"
			) .. tostring(self._threshold)
		)
		self:_tryEnterStagger()
	end
end
function modifier_cs_posture_bar.prototype.OnAfterAbilityFullyCast_CS(self, ev)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if EntIndexToHScript(ev.caster) ~= parent then
		return
	end
	if self._staggerStartTime > 0 then
		return
	end
	local decay = PostureBarRules:GetSkillCastDecay(self._threshold)
	local after = math.max(0, self:GetStackCount() - decay)
	self:SetStackCount(after)
	PostureBarDebugPrint(
		nil,
		(
			(
				(
					(
						(
							("[PostureBar] unit=" .. tostring(parent:GetEntityIndex()))
							.. " 触发: 技能释放完成 衰减 -"
						) .. tostring(decay)
					) .. " 当前 stack="
				) .. tostring(after)
			) .. "/"
		) .. tostring(self._threshold)
	)
end
function modifier_cs_posture_bar.prototype._isPostureLocked(self)
	local ____this_6
	____this_6 = self:GetParent()
	local ____opt_5 = ____this_6.IsPostureLocked
	return (____opt_5 and ____opt_5(____this_6)) == true
end
function modifier_cs_posture_bar.prototype._refreshNearbyPlayerMultiplier(self, parent, force)
	if force == nil then
		force = false
	end
	local now = GameRules:GetGameTime()
	if not force and now - self._lastNearbyPlayerMultiplierRefreshTime < 1 then
		return
	end
	self._lastNearbyPlayerMultiplierRefreshTime = now
	self._nearbyPlayerMultiplier = PostureBarRules:GetNearbyPlayerMultiplier(parent)
end
function modifier_cs_posture_bar.prototype._tryEnterStagger(self)
	if self:GetStackCount() < self._threshold then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or self._staggerStartTime > 0 then
		return
	end
	PostureBarDebugPrint(
		nil,
		(
			(("[PostureBar] unit=" .. tostring(parent:GetEntityIndex())) .. " 触发: 进入硬直，施加眩晕 ")
			.. tostring(PostureBarRules.STAGGER_DURATION)
		) .. " 秒"
	)
	local now = GameRules:GetGameTime()
	self._staggerStartTime = now
	self._initialStaggerDuration = PostureBarRules.STAGGER_DURATION
	self._damageTakenDuringStaggerPct = 0
	self:SetStackCount(self._threshold)
	parent:AddNewModifier(
		parent,
		nil,
		PostureBarRules.NATIVE_STUN_MODIFIER,
		{ duration = PostureBarRules.STAGGER_DURATION }
	)
	SlowDownServerRate(nil, 0.3, 0.2)
	parent:EmitSound("Sounds.Ability.Broken")
	local ____opt_7 = parent and parent.IsBoss
	if (____opt_7 and ____opt_7(parent)) == true then
		local effect2 =
			ParticleManager:CreateParticle("particles/hero/glass_endcap_2.vpcf", PATTACH_CENTER_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt(
			effect2,
			1,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			false
		)
		ParticleManager:SetParticleControlEnt(
			effect2,
			2,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			false
		)
		ParticleManager:SetParticleControlEnt(
			effect2,
			3,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			false
		)
		ParticleManager:ReleaseParticleIndex(effect2)
	end
	ScreenShake(parent:GetAbsOrigin(), 10, 10, 0.15, 100, 0, true)
end
function modifier_cs_posture_bar.prototype.GetPostureCurrent(self)
	return self:GetStackCount()
end
function modifier_cs_posture_bar.prototype.GetPostureThreshold(self)
	return self._threshold
end
modifier_cs_posture_bar =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_cs_posture_bar") }, modifier_cs_posture_bar)
____exports.modifier_cs_posture_bar = modifier_cs_posture_bar
return ____exports