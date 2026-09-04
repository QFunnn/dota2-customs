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
local Set = ____lualib.Set
local __TS__Iterator = ____lualib.__TS__Iterator
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____obstruction = require("utils.obstruction")
local SpawnSquareObstructions = ____obstruction.SpawnSquareObstructions
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 长矛陷阱状态：检测目标 -> 触发动画 -> 伤害+root -> 开关路径阻挡。
local TRAP_DETECT_INTERVAL = 0.03
--- 正方形检测半边长
local TRAP_DETECT_HALF = 100
--- 无房间时范围搜索用的半径（能覆盖正方形的最小圆）
local TRAP_FALLBACK_RADIUS = TRAP_DETECT_HALF * math.sqrt(2)
local TRAP_PARTICLE = "particles/trap_model_a.vpcf"
local TRAP_PARTICLE_SIZE = 100
local TRAP_FRAME_MIN = 0
local TRAP_FRAME_MAX = 45
--- 地刺“有效”区间：25-45 为穿出，0-24 为前摇；收缩时 45-25 为收回，25-0 为后摇
local TRAP_FRAME_DANGER = 25
local TRAP_FRAME_INTERVAL = 0.02
--- 踩中后持续在范围内多久才触发（秒）
local TRAP_TRIGGER_DELAY = 0
local TRAP_DEFAULT_DAMAGE = 160
--- root/debuff 时长（秒）
local TRAP_DEFAULT_ROOT_DURATION = 2
--- 阻碍相对 debuff 提前关闭的时间（秒）
local TRAP_OBSTRUCTION_EARLY_CLOSE = 0.5
--- 收缩从 45 到 25（关闭阻碍点）所需时间（秒）
local TRAP_RETRACT_TO_DANGER_TIME = (TRAP_FRAME_MAX - TRAP_FRAME_DANGER) / 2 * TRAP_FRAME_INTERVAL
--- 拥有该自定义值时不会触发陷阱且免疫陷阱伤害/控制
local TRAP_IMMUNITY_CUSTOM_KEY = "免疫陷阱"
____exports.modifier_trap_spear_state = __TS__Class()
local modifier_trap_spear_state = ____exports.modifier_trap_spear_state
modifier_trap_spear_state.name = "modifier_trap_spear_state"
__TS__ClassExtends(modifier_trap_spear_state, BaseModifier_CS)
function modifier_trap_spear_state.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._unitsInRange = {}
	self._obstructions = {}
	self._debuffName = "modifier_trap_debuff"
	self._useObstruction = true
	self._isOpen = false
	self._isTriggering = false
	self._triggerStartTime = nil
	self._hasPrintedNoRoomId = false
end
function modifier_trap_spear_state.prototype.FinishTrigger(self)
	self._isTriggering = false
	return nil
end
function modifier_trap_spear_state.prototype.GetDamageAttacker(self, parent)
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetRoomId
	local roomId = ____opt_0 and ____opt_0(____this_1) or parent.__room_id__
	if roomId == nil or roomId == nil then
		return parent
	end
	local room = MyGameRoomManager:GetRoom(tostring(roomId))
	return room and room:GetRoomDummy() or parent
end
function modifier_trap_spear_state.prototype.IsInDetectSquare(self, center, pos)
	local dx = math.abs(pos.x - center.x)
	local dy = math.abs(pos.y - center.y)
	return dx <= TRAP_DETECT_HALF and dy <= TRAP_DETECT_HALF
end
function modifier_trap_spear_state.prototype.IsTrapImmune(self, unit)
	local ____tonumber_8 = tonumber
	local ____opt_4 = unit and unit.GetCustomValue
	return ____tonumber_8(____opt_4 and ____opt_4(unit, TRAP_IMMUNITY_CUSTOM_KEY) or 0) > 0
end
function modifier_trap_spear_state.prototype.IsHidden(self)
	return true
end
function modifier_trap_spear_state.prototype.IsPurgable(self)
	return false
end
function modifier_trap_spear_state.prototype.IsDebuff(self)
	return false
end
function modifier_trap_spear_state.prototype.IsPermanent(self)
	return true
end
function modifier_trap_spear_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end
function modifier_trap_spear_state.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	if _params.debuffName and _params.debuffName ~= "" then
		self._debuffName = _params.debuffName
	end
	self._useObstruction = (_params.useObstruction or 1) == 1
	self._unitsInRange = {}
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local center = parent:GetAbsOrigin()
	local yaw = parent:GetAngles().y
	local ____table__useObstruction_9
	if self._useObstruction then
		____table__useObstruction_9 = SpawnSquareObstructions(nil, center, yaw)
	else
		____table__useObstruction_9 = {}
	end
	self._obstructions = ____table__useObstruction_9
	self._isOpen = false
	self:UpdateObstructionState()
	self:StartIntervalThink(TRAP_DETECT_INTERVAL)
	local particleAnchor =
		CreateModifierThinker(nil, nil, "modifier_dummy_thinker", {}, center, DOTA_TEAM_GOODGUYS, false)
	self._particleAnchor = particleAnchor
	self._particleId = ParticleManager:CreateParticle(TRAP_PARTICLE, PATTACH_WORLDORIGIN, particleAnchor)
	ParticleManager:SetParticleShouldCheckFoW(self._particleId, false)
	ParticleManager:SetParticleControl(self._particleId, 0, center)
	ParticleManager:SetParticleControl(self._particleId, 1, Vector(TRAP_PARTICLE_SIZE, 0, 0))
	self:SetParticleFrame(TRAP_FRAME_MIN)
end
function modifier_trap_spear_state.prototype.SetParticleFrame(self, frame)
	if self._particleId == nil then
		return
	end
	ParticleManager:SetParticleControl(self._particleId, 3, Vector(0, frame, 0))
end
function modifier_trap_spear_state.prototype.UpdateObstructionState(self)
	for ____, ob in ipairs(self._obstructions) do
		if IsValid(nil, ob) then
			ob:SetEnabled(self._isOpen, false)
		end
	end
end
function modifier_trap_spear_state.prototype.SetOpen(self, open)
	if self._isOpen == open then
		return
	end
	self._isOpen = open
	self:UpdateObstructionState()
end
function modifier_trap_spear_state.prototype.IsOpen(self)
	return self._isOpen
end
function modifier_trap_spear_state.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local center = parent:GetAbsOrigin()
	local ____opt_10 = parent.GetRoomId
	local roomId = ____opt_10 and ____opt_10(parent) or parent.__room_id__
	if roomId ~= nil and roomId ~= nil then
		local room = MyGameRoomManager:GetRoom(tostring(roomId))
		if not room then
			self._unitsInRange = {}
			return
		end
		local players = room:GetPlayers()
		self._unitsInRange = {}
		for ____, playerId in __TS__Iterator(players) do
			do
				local hero = MyGamePlayers:getPlayer(playerId):GetHero()
				if not hero or not IsValidAlive(nil, hero) then
					goto __continue30
				end
				if self:IsTrapImmune(hero) then
					goto __continue30
				end
				if self:IsInDetectSquare(center, hero:GetAbsOrigin()) then
					local ____self__unitsInRange_12 = self._unitsInRange
					____self__unitsInRange_12[#____self__unitsInRange_12 + 1] = hero
				end
			end
			::__continue30::
		end
		self:TryDelayTrigger()
		return
	end
	if not self._hasPrintedNoRoomId then
		self._hasPrintedNoRoomId = true
		print("[modifier_trap_spear_state] 陷阱单位无 roomId，退化为范围搜索（性能较差）")
	end
	local team = parent:GetTeamNumber()
	local candidates = FindUnitsInRadius(
		team,
		center,
		nil,
		TRAP_FALLBACK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	self._unitsInRange = __TS__ArrayFilter(candidates, function(____, u)
		if not IsValidAlive(nil, u) then
			return false
		end
		if self:IsTrapImmune(u) then
			return false
		end
		return self:IsInDetectSquare(center, u:GetAbsOrigin())
	end)
	self:TryDelayTrigger()
end
function modifier_trap_spear_state.prototype.TryDelayTrigger(self)
	local now = GameRules:GetGameTime()
	if #self._unitsInRange > 0 and not self._isTriggering and not self._isOpen then
		if self._triggerStartTime == nil then
			self._triggerStartTime = now
		elseif now - self._triggerStartTime >= TRAP_TRIGGER_DELAY then
			self._triggerStartTime = nil
			self:Trigger()
		end
	else
		self._triggerStartTime = nil
	end
end
function modifier_trap_spear_state.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self._unitsInRange = {}
	if self._particleId ~= nil then
		ParticleManager:DestroyParticle(self._particleId, false)
		ParticleManager:ReleaseParticleIndex(self._particleId)
		self._particleId = nil
	end
	if self._particleAnchor and IsValid(nil, self._particleAnchor) and not self._particleAnchor:IsNull() then
		self._particleAnchor:RemoveSelf()
	end
	self._particleAnchor = nil
	for ____, ob in ipairs(self._obstructions) do
		if IsValid(nil, ob) then
			ob:RemoveSelf()
		end
	end
	self._obstructions = {}
end
function modifier_trap_spear_state.prototype.GetUnitsInRange(self)
	return self._unitsInRange
end
function modifier_trap_spear_state.prototype.Trigger(self, options)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	if self._isTriggering then
		return
	end
	self._isTriggering = true
	local damage = options and options.damage or TRAP_DEFAULT_DAMAGE
	local rootDuration = options and options.rootDuration or TRAP_DEFAULT_ROOT_DURATION
	local obstructionHoldDuration =
		math.max(0, rootDuration - TRAP_OBSTRUCTION_EARLY_CLOSE - TRAP_RETRACT_TO_DANGER_TIME)
	local appliedDebuff = false
	local frame = TRAP_FRAME_MIN
	local function doExtend()
		if not IsValid(nil, parent) then
			return self:FinishTrigger()
		end
		frame = math.min(frame + 2, TRAP_FRAME_MAX)
		self:SetParticleFrame(frame)
		if frame >= TRAP_FRAME_DANGER and not appliedDebuff then
			appliedDebuff = true
			local victims = { unpack(self:GetUnitsInRange()) }
			local damageAttacker = self:GetDamageAttacker(parent)
			ScreenShake(parent:GetAbsOrigin(), 10, 10, 0.1, 1000, 1, true)
			for ____, u in ipairs(victims) do
				do
					if not IsValidAlive(nil, u) then
						goto __continue59
					end
					if self:IsTrapImmune(u) then
						goto __continue59
					end
					local maxHealth = u:GetMaxHealth()
					ApplyTrapDamage(
						nil,
						damageAttacker,
						{
							victim = u,
							damage = maxHealth * 0.35 + 100,
							damage_type = 4,
							damage_flag = ApplyDamageFlag.HP_LOSS,
						}
					)
					u:AddNewModifier(u, nil, "modifier_stunned", { duration = 0.5 })
				end
				::__continue59::
			end
		end
		if frame >= TRAP_FRAME_MAX then
			Timers:CreateTimer(obstructionHoldDuration, function()
				if not IsValid(nil, parent) then
					return self:FinishTrigger()
				end
				local retractFrame = TRAP_FRAME_MAX
				local obstructionClosed = false
				local function doRetract()
					if not IsValid(nil, parent) then
						return self:FinishTrigger()
					end
					retractFrame = math.max(retractFrame - 2, TRAP_FRAME_MIN)
					self:SetParticleFrame(retractFrame)
					if retractFrame <= TRAP_FRAME_DANGER and not obstructionClosed then
						obstructionClosed = true
						self:SetOpen(false)
					end
					if retractFrame <= TRAP_FRAME_MIN then
						return self:FinishTrigger()
					end
					return TRAP_FRAME_INTERVAL
				end
				Timers:CreateTimer(TRAP_FRAME_INTERVAL, doRetract)
				return nil
			end)
			return nil
		end
		return TRAP_FRAME_INTERVAL
	end
	Timers:CreateTimer(TRAP_FRAME_INTERVAL, doExtend)
end
modifier_trap_spear_state =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_trap_spear_state") }, modifier_trap_spear_state)
____exports.modifier_trap_spear_state = modifier_trap_spear_state
____exports.modifier_trap_debuff = __TS__Class()
local modifier_trap_debuff = ____exports.modifier_trap_debuff
modifier_trap_debuff.name = "modifier_trap_debuff"
__TS__ClassExtends(modifier_trap_debuff, BaseModifier_CS)
function modifier_trap_debuff.prototype.IsHidden(self)
	return true
end
function modifier_trap_debuff.prototype.IsPurgable(self)
	return false
end
function modifier_trap_debuff.prototype.IsDebuff(self)
	return true
end
function modifier_trap_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local particleId = ParticleManager:CreateParticle(
		"particles/bb/engy_faceless_void_arcana_time_lock_v2_bash_hit2.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(particleId, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particleId, 1, self:GetParent():GetAbsOrigin())
	self:AddParticle(particleId, false, false, -1, false, false)
end
modifier_trap_debuff = __TS__DecorateLegacy({ registerModifier(nil, "modifier_trap_debuff") }, modifier_trap_debuff)
____exports.modifier_trap_debuff = modifier_trap_debuff
return ____exports