--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/fishing_session"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArraySlice
local e = {}
local f = 200
local g = "fishing_bag_full"
local function h(self, i)
	local j = json.decode(i.fish_details)
	if j ~= nil and #j > 0 then
		return j[1]
	end
	return nil
end
local k = {
	[ACT_DOTA_DISABLED] = "1_loop",
	[ACT_DOTA_FLAIL] = "1_loop",
	[ACT_DOTA_OVERRIDE_ABILITY_1] = "1_start",
	[ACT_DOTA_OVERRIDE_ABILITY_2] = "1_end",
	[ACT_DOTA_OVERRIDE_ABILITY_3] = "1_shanggou_loop",
	[ACT_DOTA_IDLE] = "1_start_idle",
	[ACT_DOTA_OVERRIDE_ABILITY_4] = "1_start_idle",
}
e.CFishingSession = c()
local l = e.CFishingSession
l.name = "CFishingSession"
function l.prototype.____constructor(self, m, n, o)
	self.hook_particles = {}
	self.hook_throwed = false
	self.in_progress = false
	self.fishing_idle_animation = ACT_DOTA_IDLE
	self.destroyed = false
	self.round_requesting = false
	self.hero = m
	self.playerID = n
	self.platformIndex = o
	self.fishing_dummy = m
	local p = Fishing:GetFishingPlatformRewardPosition(o)
	if p ~= nil then
		self.reward_card_position = p
	else
		local q = self.hero:GetForwardVector()
		q.z = 0
		q = q:Normalized()
		local r = q * 300
		r.z = r.z - 32
		self.reward_card_position = self.fishing_dummy:GetAbsOrigin() + r
	end
end
function l.prototype.init(self)
	local s = self.hero
	if s ~= nil then
		s:AddNewModifier(self.hero, nil, "modifier_fishing", { iPlatfromIndex = self.platformIndex })
	end
	if self.platformIndex ~= nil then
		Fishing:SetFishingPlatformState(self.platformIndex, false)
	end
	CommonService:CallAction("/v1/idle_game/flush_data", self.playerID, {})
	self:BeginFishing()
end
function l.prototype.SetNewRoundCooldown(self, t)
	if t == nil then
		t = 3
	end
	if self.cooldown_timer ~= nil then
		return
	end
	self:clearRound()
	local u = GameRules:GetGameTime() + t
	local v = PlayerResource:GetPlayer(self.playerID)
	if v then
		CustomGameEventManager:Send_ServerToPlayer(v, "fishing_cooldown", { next_time = u })
	end
	self.cooldown_timer = Timer:GameTimer(t, function()
		self.cooldown_timer = nil
		self:beginRound()
	end)
end
function l.prototype.getFishBagCapacity(self)
	local w = KeyValues.idle_game_setting.fish_num_max
	if w ~= nil then
		w = w.value
	end
	local x = w
	if x == nil then
		x = f
	end
	return x
end
function l.prototype.getFishBagCount(self)
	local y = CommonService:GetPlayerServiceNetTable(self.playerID, "player_idle_game_fishes")
	if y == nil then
		return 0
	end
	local z = 0
	for A, i in pairs(y) do
		if i ~= nil then
			z = z + 1
		end
	end
	return z
end
function l.prototype.isFishBagFull(self)
	return self:getFishBagCount() >= self:getFishBagCapacity()
end
function l.prototype.notifyFishBagFull(self)
	local v = PlayerResource:GetPlayer(self.playerID)
	if v == nil then
		return
	end
	CustomGameEventManager:Send_ServerToPlayer(
		v,
		g,
		{ capacity = self:getFishBagCapacity(), count = self:getFishBagCount() }
	)
end
function l.prototype.CanStartFishing(self)
	return not self:isFishBagFull()
end
function l.prototype.StopFishingForFullBag(self)
	self.round_requesting = false
	self:RegainHookImmediate()
	self:clearRound()
	Fishing:ChangeFishState(self.playerID, "idle")
	self:syncFishData()
	self:notifyFishBagFull()
end
function l.prototype.beginRound(self, B, C)
	if self.destroyed or self.round_requesting then
		return
	end
	if not B then
		local D = Fishing:GetPlayerFishState(self.playerID)
		if D == "waiting" or D == "fishing" or D == "none" then
			return
		end
	end
	if self:isFishBagFull() then
		self:StopFishingForFullBag()
		return
	end
	Fishing:ChangeFishState(self.playerID, "unhook")
	self.round_requesting = C ~= true
	CommonService:CallAction("/v1/idle_game/play_fish", self.playerID, {}, function(E, A, F)
		self.round_requesting = false
		if self.destroyed then
			return
		end
		local G
		if F.data ~= nil then
			CommonService:CommonCallback(self.playerID, F)
			G = F.data.player_play_idle_game_fish_result
		end
		if G ~= nil then
			self:OnFishRequest(G)
		else
			self:beginRound(false, true)
		end
	end, false)
end
function l.prototype.OnFishRequest(self, G)
	self.fishing_result_data = G
	Fishing:ChangeFishState(self.playerID, "waiting")
	local H = h(nil, self.fishing_result_data)
	local I = H and H.weight
	local J = H and H.price or "[]"
	local i = CommonService:GetPlayerServiceNetTable(self.playerID, "player_idle_game_fish_data")
	local K = i and i.rod_level or 0
	local L = KeyValues.fish_rods[tostring(K)]
	if L ~= nil then
		L = L.interaction
	end
	local M = L
	if M == nil then
		M = 1500
	end
	local N = M
	local O = PropertySystem:GetStaticPropertyValue(PropertyScope.PLAYER, self.playerID, "idle_fish_interaction_pct")
	local P = N * (1 + O * 0.01)
	local Q = tonumber
	local R = KeyValues.fish_rods[tostring(K)]
	if R ~= nil then
		R = R.wait_time
	end
	local S = Q(R) or 15
	local T =
		PropertySystem:GetStaticPropertyValue(PropertyScope.PLAYER, self.playerID, "idle_fish_wait_time_reduce_pct")
	local U = math.max(0.1, S * (1 - T * 0.01))
	local V = PropertySystem:GetStaticPropertyValue(PropertyScope.PLAYER, self.playerID, "idle_fish_escape_speed_pct")
	local W = { width = P, force = 3 }
	local X = W.width + PropertySystem:GetStaticPropertyValue(PropertyScope.PLAYER, self.playerID, "fish_hook_width")
	local Y = W.force + PropertySystem:GetStaticPropertyValue(PropertyScope.PLAYER, self.playerID, "fish_hook_force")
	local Z = tostring(self.fishing_result_data.id)
	local _ = Privilege:HasPrivilege("privilege_cosmetic_002", self.playerID)
	if self.fishing_result_data.is_fish then
		local a0 = tostring(self.fishing_result_data.fish_id)
		local a1 = Fishing.fishKV[a0]
		local a2 = (H and H.is_rainbow) == true
		local a3 = (self.fishing_result_data.box_count or 0) > 0
		local a4 = {
			fishType = a2 and "rainbow" or "normal",
			fishID = self.fishing_result_data.fish_id,
			fish_weight = I,
			fishDelay = U,
			escapeSpeedPct = V,
			fishHookFrame = tonumber(a1.hook_frame),
			hook_width = X,
			hook_force = Y,
			box_rewards = self.fishing_result_data.box_rewards,
			fish_rewards = self.fishing_result_data.fish_rewards,
			fish_price = J,
			box_count = self.fishing_result_data.box_count,
			fish_count = self.fishing_result_data.fish_count,
			box_type = self.fishing_result_data.box_type,
			box_auto_success = _,
			unique = Z,
			action_configs = a1.action_config,
		}
		if a3 then
			a4.box_appear_frame = RandomInt(10, 60)
			a4.box_position = RandomInt(500, Fishing.fishInteractionConfig.height_limit - 500)
		end
		self.roundProps = a4
	else
		local a5 = RandomInt(1, 3)
		local a4 = {
			fishType = "rubbish",
			fishID = a5,
			fish_weight = I,
			fishDelay = U,
			escapeSpeedPct = V,
			fishHookFrame = 120,
			hook_width = X,
			hook_force = Y,
			box_rewards = self.fishing_result_data.box_rewards,
			fish_rewards = self.fishing_result_data.fish_rewards,
			fish_price = J,
			box_count = self.fishing_result_data.box_count,
			fish_count = self.fishing_result_data.fish_count,
			box_type = self.fishing_result_data.box_type,
			box_auto_success = _,
			unique = Z,
			action_configs = {},
		}
		self.roundProps = a4
	end
	self.actionSeq = nil
	self.simulateRecord = nil
	self:syncFishData()
end
function l.prototype.syncFishData(self)
	if self.roundProps == nil then
		CustomNetTables:SetNetData(
			"common",
			"fishing_data",
			{
				wait_time = 0,
				hook_width = 0,
				hook_force = 0,
				hook_need_frame = 0,
				operate_bag_index = 0,
				unique = "",
				box_auto_success = false,
			},
			self.playerID
		)
		return
	end
	CustomNetTables:SetNetData(
		"common",
		"fishing_data",
		{
			fish_type = self.roundProps.fishType,
			wait_time = self.roundProps.fishDelay,
			hook_width = self.roundProps.hook_width,
			hook_force = self.roundProps.hook_force,
			hook_need_frame = self.roundProps.fishHookFrame,
			unique = self.roundProps.unique,
			operate_bag_index = self.simulateRecord ~= nil and self.simulateRecord.operate_bag_index or 0,
			box_appear_frame = self.roundProps.box_appear_frame,
			box_position = self.roundProps.box_position,
			box_auto_success = self.roundProps.box_auto_success,
		},
		self.playerID
	)
end
function l.prototype.generateActionSeq(self, a6)
	if self.roundProps == nil then
		return
	end
	local a7 = a6
	local a8 = self.actionSeq
	if a7 == (a8 and a8.action_step) then
		self:_syncActionSeqToClient(a6)
		return
	end
	if self.actionSeq == nil then
		self.actionSeq = {
			action_step = 0,
			step_index = 0,
			last_height = 0,
			last_velocity = 0,
			action_seqs = {},
			last_behavior_index = -1,
		}
	end
	local a9 = self.actionSeq
	a9.step_index = #a9.action_seqs
	local aa = 0
	if #a9.action_seqs > 0 then
		local ab = a9.action_seqs[#a9.action_seqs]
		aa = ab.start_frame + ab.keep_frame
	end
	local ac = math.floor(aa / 600) * 600 + 600
	local a4 = self.roundProps
	local ad = a4.action_configs
	if a9.action_step == 0 then
		self:_runActionConfig(0, ad[1])
	end
	while #a9.action_seqs > 0 do
		local ab = a9.action_seqs[#a9.action_seqs]
		if ab.start_frame + ab.keep_frame >= ac then
			break
		end
		local ae = {}
		do
			local af = 0
			while af < #ad do
				if af ~= a9.last_behavior_index then
					ae[#ae + 1] = af
				end
				af = af + 1
			end
		end
		local ag = ae[RandomInt(0, #ae - 1) + 1]
		self:_runActionConfig(ag, ad[ag + 1])
	end
	self:_syncActionSeqToClient(a6)
end
function l.prototype._syncActionSeqToClient(self, a6)
	local a9 = self.actionSeq
	if a9 == nil or self.roundProps == nil then
		return
	end
	local v = PlayerResource:GetPlayer(self.playerID)
	if v ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(
			v,
			"fishing_action_seq_sync",
			{ action_seqs = json.encode(d(a9.action_seqs, a9.step_index)), unique = self.roundProps.unique, step = a6 }
		)
	end
end
function l.prototype._runActionConfig(self, ah, ai)
	do
		local af = 0
		while af < #ai do
			local aj = ai[af + 1]
			if aj.distance == 0 then
				self:_genNodeIdle(aj.frames)
			else
				self:_genNodeEscape(aj.distance, aj.frames)
			end
			af = af + 1
		end
	end
	self.actionSeq.last_behavior_index = ah
	local ak, al = self.actionSeq, "action_step"
	ak[al] = ak[al] + 1
end
function l.prototype._genNodeIdle(self, am)
	local a9 = self.actionSeq
	local an = a9.action_seqs
	local ao = 0
	if #an > 0 then
		local ab = an[#an]
		ao = ab.start_frame + ab.keep_frame
	end
	local ap = RandomFloat(-30, 30)
	an[#an + 1] = { accelerate = 0, velocity = ap, keep_frame = am, start_frame = ao }
	a9.last_velocity = ap
end
function l.prototype._genNodeEscape(self, aq, am)
	aq = Round(aq * (100 + RandomInt(-5, 5)) * 0.01)
	local a9 = self.actionSeq
	local an = a9.action_seqs
	local ar = a9.last_height
	local as = a9.last_velocity
	local ao = 0
	if #an > 0 then
		local ab = an[#an]
		ao = ab.start_frame + ab.keep_frame
	end
	local at = Fishing.fishInteractionConfig.height_limit
	local au = at - ar
	local av = ar
	local aw = RandomInt(0, 1) == 0 and 1 or -1
	local ax = aw == 1 and au or av
	if aq * 1.1 > ax then
		aw = -aw
	end
	local ae = aw == 1 and au or av
	local ay = math.min(aq, ae * 0.95)
	local az = ay * aw
	local aA = math.floor(am * 0.25)
	local aB = math.floor(am * 0.5)
	local aC = am - aA - aB
	local aD = as * (aA + aB + 0.5 * aC)
	local aE = aA * (0.5 * aA + aB + 0.5 * aC)
	local aF = aE ~= 0 and (az - aD) / aE or 0
	an[#an + 1] = { accelerate = aF, velocity = as, keep_frame = aA, start_frame = ao }
	local aG = as + aF * aA
	local aH = ar + as * aA + 0.5 * aF * aA * aA
	an[#an + 1] = { accelerate = 0, velocity = aG, keep_frame = aB, start_frame = ao + aA }
	local aI = aH + aG * aB
	local aJ = aC > 0 and -aG / aC or 0
	an[#an + 1] = { accelerate = aJ, velocity = aG, keep_frame = aC, start_frame = ao + aA + aB }
	local aK = aG + aJ * aC
	local aL = aI + aG * aC + 0.5 * aJ * aC * aC
	a9.last_height = math.max(0, math.min(at, aL))
	a9.last_velocity = aK
end
function l.prototype.initSimulation(self)
	if self.roundProps == nil then
		return
	end
	self.simulateRecord = {
		hook = { position = 0, velocity = 0 },
		fish = {
			position = 0,
			velocity = 0,
			progress = Fishing.fishInteractionConfig.start_progress,
			last_unhook_frame = 0,
			last_state = false,
		},
		frame_now = 0,
		fish_current_action_index = -1,
		operate_bag_index = 0,
	}
end
function l.prototype.OnReceiveOperate(self, aM, aN, aO, Z)
	if self.roundProps == nil then
		return
	end
	if Z ~= self.roundProps.unique then
		return
	end
	local aP = self:processFishingOperate(aM, aN, aO)
	if aO then
		self:onResult(aP or "failure")
	end
end
function l.prototype.processFishingOperate(self, aM, aN, aO)
	local aQ = self.simulateRecord
	if aQ == nil or self.roundProps == nil then
		return
	end
	if aN ~= aQ.operate_bag_index then
		return
	end
	aQ.operate_bag_index = aQ.operate_bag_index + 1
	local aP
	do
		local af = 0
		while af < #aM do
			local aR = string.sub(aM, af + 1, af + 1) == "1"
			aQ.frame_now = aQ.frame_now + 1
			self:_simUpdateHook(aR)
			self:_simUpdateFish()
			self:_simUpdateBox()
			aP = self:_simCheckProgress()
			if aP ~= nil then
				break
			end
			af = af + 1
		end
	end
	if aO then
		return aP
	end
	if aP ~= nil then
		self:onResult(aP)
	end
	self:syncFishData()
end
function l.prototype.onResult(self, aP)
	if self.roundProps == nil then
		return
	end
	if aP == "failure" then
		Event:Fire(
			"fishing_complete",
			{ playerID = self.playerID, success = false, fishType = self.roundProps.fishType, fishID = self.roundProps.fishID }
		)
		self:SetNewRoundCooldown()
	elseif aP == "success" then
		local aS = false
		local aT = self.simulateRecord
		if
			(aT and aT.box) ~= nil
			and self.simulateRecord.box.progress == Fishing.fishInteractionConfig.box_progress
		then
			aS = true
		end
		Event:Fire(
			"fishing_complete",
			{ playerID = self.playerID, success = true, fishType = self.roundProps.fishType, fishID = self.roundProps.fishID }
		)
		self:RequestFishReward(self.roundProps.unique, aS)
		self:SetNewRoundCooldown()
	end
	Fishing:ChangeFishState(self.playerID, aP)
	self.actionSeq = nil
	self.simulateRecord = nil
end
function l.prototype.RequestFishReward(self, aU, aV)
	if self.destroyed then
		return
	end
	local aW = aU
	local aX = self.roundProps
	if aW ~= (aX and aX.unique) then
		return
	end
	self:OnRewardRequest(aV)
	CommonService:RepeatCallAction(
		"/v1/idle_game/receive_fish",
		self.playerID,
		{ id = aU, success_box = aV },
		function(E, n, F)
			CommonService:CommonCallback(n, F)
			MechanicsFishItem:AutoSellFish(n)
		end,
		true,
		3,
		20
	)
end
function l.prototype.OnRewardRequest(self, aV)
	if self.roundProps == nil then
		return
	end
	local aY = tostring(self.roundProps.fishID)
	local aZ = self.roundProps.fishType
	local a_ = self.roundProps.fish_count or 0
	local b0 = 0
	local b1 = "[]"
	local b2 = ""
	if aV then
		b0 = self.roundProps.box_count or 0
		b1 = self.roundProps.box_rewards
		b2 = self.roundProps.box_type or ""
	end
	local v = PlayerResource:GetPlayer(self.playerID)
	local b3 = self.reward_card_position
	CustomGameEventManager:Send_ServerToAllClients(
		"fishing_result",
		{
			fish_name = aY,
			player_id = self.playerID,
			fish_type = aZ,
			pos = (((tostring(b3.x) .. ",") .. tostring(b3.y)) .. ",") .. tostring(b3.z),
		}
	)
	if v ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(
			v,
			"fishing_reward",
			{
				fish_id = aY,
				fish_type = aZ,
				fish_weight = self.roundProps.fish_weight,
				fish_rewards = self.roundProps.fish_rewards,
				fish_price = self.roundProps.fish_price,
				box_rewards = b1,
				fish_count = a_,
				box_count = b0,
				box_type = b2,
			}
		)
	end
end
function l.prototype._simGetActionSeq(self)
	local aQ = self.simulateRecord
	local a9 = self.actionSeq
	if aQ == nil or a9 == nil then
		return nil
	end
	local b4 = aQ.frame_now
	local b5 = aQ.fish_current_action_index < 0
	if not b5 then
		local b6 = a9.action_seqs[aQ.fish_current_action_index + 1]
		if b6 ~= nil then
			b5 = b4 > b6.start_frame + b6.keep_frame
		end
	end
	if b5 then
		local b7 = aQ.fish_current_action_index + 1
		if b7 < #a9.action_seqs then
			aQ.fish_current_action_index = b7
		end
	end
	if aQ.fish_current_action_index >= 0 and aQ.fish_current_action_index < #a9.action_seqs then
		return a9.action_seqs[aQ.fish_current_action_index + 1]
	end
	return nil
end
function l.prototype._simUpdateHook(self, aR)
	local aQ = self.simulateRecord
	local a4 = self.roundProps
	if aQ == nil or a4 == nil then
		return
	end
	local b8 = Fishing.fishInteractionConfig
	local b9 = aQ.hook
	local ba = b8.height_limit - a4.hook_width
	b9.position = b9.position + b9.velocity
	local bb = true
	if aR then
		local bc = a4.hook_force
		if b9.position >= ba then
			b9.position = ba
			b9.velocity = 0
			bb = false
		else
			b9.velocity = Clamp(b9.velocity + bc, -b8.hook_max_speed, b8.hook_max_speed)
		end
	else
		local bc = -a4.hook_force
		if b9.velocity > 0 then
			bc = bc - b8.hook_resi
		elseif b9.velocity < 0 then
			bc = bc + b8.hook_resi
		end
		b9.velocity = Clamp(b9.velocity + bc, -b8.hook_max_speed, b8.hook_max_speed)
	end
	if bb then
		if b9.position < 0 then
			b9.position = 0
			b9.velocity = math.max(0, math.abs(b9.velocity) - b8.collision_velocity_reduce)
		elseif b9.position > ba then
			b9.position = ba
			b9.velocity = math.min(0, -(math.abs(b9.velocity) - b8.collision_velocity_reduce))
		end
	end
	b9.velocity = Round(b9.velocity)
end
function l.prototype._simUpdateFish(self)
	local aQ = self.simulateRecord
	if aQ == nil then
		return
	end
	local bd = self:_simGetActionSeq()
	if bd ~= nil then
		local be = aQ.fish
		be.position = be.position + be.velocity
		be.velocity = be.velocity + bd.accelerate
		be.velocity = Round(be.velocity)
		local bf = Fishing.fishInteractionConfig.height_limit
		if be.position < 0 then
			be.position = 0
			be.velocity = 0
		elseif be.position > bf then
			be.position = bf
			be.velocity = 0
		end
	end
end
function l.prototype._simUpdateBox(self)
	local aQ = self.simulateRecord
	if aQ == nil or aQ.box ~= nil then
		return
	end
	local bg = self.roundProps
	local bh = bg.box_appear_frame
	if type(bh) ~= "number" then
		return
	end
	if aQ.frame_now >= bh then
		local bi = bg.box_position
		aQ.box = { position = bi, progress = bg.box_auto_success and Fishing.fishInteractionConfig.box_progress or 0 }
	end
end
function l.prototype._simCheckProgress(self)
	local aQ = self.simulateRecord
	local a4 = self.roundProps
	if aQ == nil or a4 == nil then
		return nil
	end
	local b8 = Fishing.fishInteractionConfig
	local be = aQ.fish
	local b9 = aQ.hook
	local a3 = aQ.box
	local bj = math.max(0, 1 - a4.escapeSpeedPct * 0.01)
	local bk = b8.unhook_force * bj
	local bl = b9.position
	local bm = b9.position + a4.hook_width
	if a3 ~= nil then
		if a3.progress < b8.box_progress then
			if a3.position >= bl and a3.position <= bm then
				a3.progress = Clamp(a3.progress + b8.hook_force, 0, b8.box_progress)
			else
				a3.progress = Clamp(a3.progress - b8.unhook_force, 0, b8.box_progress)
			end
		end
	end
	local bn = be.position >= bl and be.position <= bm
	if not bn and be.last_state then
		be.last_unhook_frame = aQ.frame_now
	end
	be.last_state = bn
	if bn then
		be.progress = Clamp(be.progress + b8.hook_force, 0, b8.progress_limit)
	else
		if aQ.frame_now - be.last_unhook_frame >= b8.unhook_delay then
			be.progress = Clamp(be.progress - bk, 0, b8.progress_limit)
		end
	end
	if be.progress >= b8.progress_limit then
		return "success"
	elseif be.progress <= 0 then
		return "failure"
	end
	return nil
end
function l.prototype._startProcThink(self, bo, bp, bq)
	if self.destroyed or self.round_requesting or self.in_progress then
		return
	end
	bp(nil)
	self.in_progress = true
	Timer:GameTimer(bo, function()
		if self.destroyed then
			self.in_progress = false
			return
		end
		self.in_progress = false
		bq(nil)
	end)
end
function l.prototype.BeginFishing(self)
	self.hero:SetWeaponVisible(false)
	self.hero:AddActivityModifier("fishing")
	Fishing:ChangeFishState(self.playerID, "idle")
end
function l.prototype.ExitFishing(self)
	self.hero:SetWeaponVisible(true)
	self.hero:RemoveActivityModifier("fishing")
	Fishing:ChangeFishState(self.playerID, "none")
	Fishing:ClearPlayerSession(self.playerID)
end
function l.prototype._switchDummy(self, D)
	if D then
		self:_startProcThink(0.4, function()
			local aU = ParticleManager:CreateParticleForce(
				"particles/econ/items/enchantress/enchantress_lodestar/ench_lodestar_transform.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(aU, 0, self.hero, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
			self.fishing_dummy:SetAbsOrigin(self.hero:GetAbsOrigin())
			self.fishing_dummy:SetForwardVector(self.hero:GetForwardVector())
			self.fishing_dummy:RemoveNoDraw_Engine()
			self:CheckIdleAnimation()
			self.hero:AddNoDraw()
		end, function()
			Fishing:ChangeFishState(self.playerID, "idle")
		end)
	else
		self:_startProcThink(0.4, function()
			local aU = ParticleManager:CreateParticleForce(
				"particles/econ/items/enchantress/enchantress_lodestar/ench_lodestar_transform.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(aU, 0, self.hero, PATTACH_POINT, "attach_hitloc", vec3_zero, true)
			self.fishing_dummy:AddNoDraw_Engine()
			self.fishing_dummy:SetModelScale(0.01)
			self.hero:RemoveNoDraw()
		end, function()
			Fishing:ChangeFishState(self.playerID, "none")
			Fishing:ClearPlayerSession(self.playerID)
		end)
	end
end
function l.prototype.ChangeIdleAnimationByState(self, br)
	if br == "fishing" or br == "success" or br == "failure" or br == "hooked" then
		self.fishing_idle_animation = ACT_DOTA_OVERRIDE_ABILITY_3
	elseif br == "idle" or br == "none" then
		self.fishing_idle_animation = ACT_DOTA_OVERRIDE_ABILITY_4
	else
		self.fishing_idle_animation = ACT_DOTA_FLAIL
	end
	self:CheckIdleAnimation()
end
function l.prototype.CheckIdleAnimation(self)
	if self.in_progress then
		return
	end
	self:StartAnimation(self.fishing_idle_animation, true)
end
function l.prototype.StartAnimation(self, bs, bt)
	if self.last_fishing_animation == bs then
		return
	end
	local bu = k[bs] or k[ACT_DOTA_OVERRIDE_ABILITY_4]
	if IsValid(self.fishing_dummy_hook) then
		self.fishing_dummy_hook:RemoveSelf()
	end
	local bv = CommonService:GetPlayerServiceNetTable(self.playerID, "player_idle_game_fish_data")
	local K = bv and bv.equipment_level or bv and bv.rod_level or 0
	local bw = KeyValues.fish_rods[tostring(K)]
	if bw ~= nil then
		bw = bw.model
	end
	local bx = bw
	if bx == nil then
		bx = "models/eom/props/fishing_rod/fishing_rod_1.vmdl"
	end
	local by = bx
	self.fishing_dummy_hook = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{
			targetname = "fishing_dummy_hook",
			model = by,
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			StartingAnim = bu,
			IdleAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			IdleAnim = bu,
		}
	)
	self.fishing_dummy_hook:SetParent(self.fishing_dummy, "!bonemerge")
	if self.fishing_hook_particle == nil then
	else
		ParticleManager:SetParticleControlEnt(
			self.fishing_hook_particle,
			6,
			self.fishing_dummy_hook,
			PATTACH_POINT_FOLLOW,
			"attach_ring_c",
			self.fishing_dummy:GetAbsOrigin(),
			true
		)
	end
	if self.last_fishing_animation ~= nil then
		self.fishing_dummy:RemoveGesture(self.last_fishing_animation)
	end
	if not bt then
		if self.idle_timer ~= nil then
			Timer:StopTimer(self.idle_timer)
			self.idle_timer = nil
		end
		self.fishing_dummy:StartGestureWithFade(bs, 0, 0.03)
	else
		self:IdleTimer()
	end
	self.last_fishing_animation = bs
end
function l.prototype.IdleTimer(self)
	if self.idle_timer ~= nil then
		Timer:StopTimer(self.idle_timer)
	end
	local bz = FrameTime()
	self.fishing_dummy:StartGestureWithFade(self.fishing_idle_animation, 0, 0.03)
	self.idle_timer = Timer:GameTimer(0, function()
		self.fishing_dummy:StartGestureWithFade(self.fishing_idle_animation, 0, 0.03)
		return bz
	end)
end
function l.prototype.OnInteractive(self, D, bA)
	if self.destroyed or self.round_requesting or self.in_progress then
		return
	end
	if D == 1 then
		self:ThrowHook()
	elseif D == 2 then
		self:HookFish(bA)
	else
		self:CancelFishing()
	end
end
function l.prototype.ThrowHook(self)
	if self.hook_throwed then
		return
	end
	self:_startProcThink(1.8, function()
		local bB = Fishing:GetFishingPlatformHookPosition(self.platformIndex)
		if bB ~= nil then
			self.hook_position = bB
		else
			local q = self.hero:GetForwardVector()
			q.z = 0
			q = q:Normalized()
			local r = q * 800
			r.z = r.z - 32
			self.hook_position = self.fishing_dummy:GetAbsOrigin() + r
		end
		local bC = (self.hook_position - self.fishing_dummy:GetAbsOrigin()):Length()
		local bD = true
		Timer:GameTimer(0.96, function()
			if self.destroyed then
				return
			end
			if bD then
				bD = nil
				self.fishing_dummy:EmitSound("Hero_Brewmaster.LiquidCourage.Cast")
				local aU = ParticleManager:CreateParticleForce(
					"particles/generic_gameplay/throw_fish_hook.vpcf",
					PATTACH_CUSTOMORIGIN,
					self.fishing_dummy
				)
				ParticleManager:SetParticleControl(aU, 1, self.hook_position)
				ParticleManager:SetParticleControl(aU, 2, Vector(bC / 0.7, 0, 0))
				ParticleManager:SetParticleControlEnt(
					aU,
					6,
					self.fishing_dummy_hook,
					PATTACH_POINT_FOLLOW,
					"attach_ring_c",
					self.fishing_dummy:GetAbsOrigin(),
					true
				)
				self.fishing_hook_particle = aU
				return 0.7
			else
				local bE = ParticleManager:CreateParticleForce(
					"particles/econ/items/lion/fish_stick/fish_stick_splash.vpcf",
					PATTACH_CUSTOMORIGIN,
					self.fishing_dummy
				)
				ParticleManager:SetParticleControl(bE, 0, self.hook_position)
				local aU = ParticleManager:CreateParticleForce(
					"particles/econ/items/lion/fish_stick/fish_stick_spell_ambient.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				EmitSoundOnLocationWithCaster(self.hook_position, "Hero_Morphling.projectileImpact", self.fishing_dummy)
				ParticleManager:SetParticleControl(aU, 0, self.hook_position)
				local bF = self.hook_particles
				bF[#bF + 1] = aU
			end
		end)
		self:StartAnimation(ACT_DOTA_OVERRIDE_ABILITY_1)
	end, function()
		self.hook_throwed = true
		self:beginRound(true)
	end)
end
function l.prototype.CancelFishing(self)
	self:RegainHookImmediate()
	self:ExitFishing()
end
function l.prototype.RegainHookImmediate(self)
	if not self.hook_throwed then
		return
	end
	Fishing:ChangeFishState(self.playerID, "idle")
	self.hook_throwed = false
	self:_clearHookParticles()
	self:clearRound()
	self:syncFishData()
	self:StartAnimation(ACT_DOTA_OVERRIDE_ABILITY_2)
	if self.fishing_hook_particle ~= nil then
		ParticleManager:DestroyParticle(self.fishing_hook_particle, true)
		self.fishing_hook_particle = nil
	end
end
function l.prototype.RegainHook(self)
	if not self.hook_throwed then
		return
	end
	self:_startProcThink(0.67, function()
		Fishing:ChangeFishState(self.playerID, "idle")
		self:_clearHookParticles()
		self:clearRound()
		self:syncFishData()
		self:StartAnimation(ACT_DOTA_OVERRIDE_ABILITY_2)
		local bG = false
		Timer:GameTimer(1.4, function()
			if self.destroyed then
				return
			end
			if self.fishing_hook_particle ~= nil then
				if bG then
					if self.fishing_hook_particle ~= nil then
						ParticleManager:DestroyParticle(self.fishing_hook_particle, true)
						self.fishing_hook_particle = nil
					end
				else
					bG = true
					self.fishing_dummy:EmitSound("Hero_Brewmaster.LiquidCourage.Cast")
					local bC = (self.hook_position - self.fishing_dummy:GetAbsOrigin()):Length()
					ParticleManager:SetParticleControl(self.fishing_hook_particle, 2, Vector(bC / 0.33, 0, 0))
					ParticleManager:SetParticleControlEnt(
						self.fishing_hook_particle,
						1,
						self.fishing_dummy_hook,
						PATTACH_POINT_FOLLOW,
						"attach_ring_c",
						self.fishing_dummy:GetAbsOrigin(),
						true
					)
					return 0.5
				end
			end
		end)
	end, function()
		self.hook_throwed = false
		if self.fishing_hook_particle ~= nil then
			ParticleManager:DestroyParticle(self.fishing_hook_particle, true)
			self.fishing_hook_particle = nil
		end
		Fishing:ChangeFishState(self.playerID, "idle")
	end)
end
function l.prototype.HookFish(self, bH)
	if bH == nil then
		bH = 999
	end
	if self.roundProps == nil then
		self:syncFishData()
		return
	end
	local bI = bH <= self.roundProps.fishHookFrame and "fishing" or "unhook"
	if self.roundProps.fishType == "rubbish" and bI == "fishing" then
		bI = "hooked"
	end
	Fishing:ChangeFishState(self.playerID, bI)
	if bI == "fishing" then
		self:generateActionSeq(0)
		self:initSimulation()
	elseif bI == "hooked" then
		self:RequestFishReward(self.roundProps.unique, false)
		self:SetNewRoundCooldown()
	else
		self:SetNewRoundCooldown()
	end
	self:syncFishData()
end
function l.prototype.Destroy(self)
	if self.destroyed then
		return
	end
	self.destroyed = true
	self.round_requesting = false
	self.in_progress = false
	self:clearRound()
	self:_clearHookParticles()
	if self.platformIndex ~= nil then
		Fishing:SetFishingPlatformState(self.platformIndex, true)
	end
	if self.idle_timer ~= nil then
		Timer:StopTimer(self.idle_timer)
	end
	if self.last_fishing_animation ~= nil then
		self.fishing_dummy:RemoveGesture(self.last_fishing_animation)
	end
	if self.fishing_dummy ~= nil and IsValid(self.fishing_dummy) and self.fishing_dummy ~= self.hero then
		self.fishing_dummy:RemoveSelf()
	end
	if IsValid(self.fishing_dummy_hook) then
		self.fishing_dummy_hook:RemoveSelf()
	end
	local bJ = self.hero
	if IsValid(bJ) then
		bJ:RemoveNoDraw()
	end
	Timer:GameTimer(0.2, function()
		if self.destroyed and IsValid(bJ) then
			bJ:RemoveModifierByName("modifier_fishing")
		end
	end)
end
function l.prototype._clearHookParticles(self)
	do
		local af = 0
		while af < #self.hook_particles do
			ParticleManager:DestroyParticle(self.hook_particles[af + 1], true)
			af = af + 1
		end
	end
	self.hook_particles = {}
end
function l.prototype.clearRound(self)
	self.roundProps = nil
	self.actionSeq = nil
	self.simulateRecord = nil
	if self.cooldown_timer ~= nil then
		Timer:StopTimer(self.cooldown_timer)
		self.cooldown_timer = nil
	end
end
return e