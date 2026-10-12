--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_custom_knockback.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_custom_knockback.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "75:1",
		["15"] = "76:14",
		["16"] = "75:1",
		["17"] = "76:43",
		["18"] = "77:5",
		["19"] = "78:9",
		["20"] = "77:5",
		["21"] = "81:5",
		["22"] = "82:9",
		["23"] = "81:5",
		["24"] = "85:5",
		["25"] = "86:9",
		["26"] = "85:5",
		["27"] = "89:5",
		["28"] = "90:9",
		["29"] = "89:5",
		["30"] = "93:5",
		["31"] = "94:9",
		["32"] = "93:5",
		["33"] = "97:5",
		["34"] = "98:9",
		["35"] = "97:5",
		["36"] = "166:5",
		["37"] = "167:13",
		["38"] = "167:40",
		["40"] = "168:16",
		["41"] = "168:16",
		["42"] = "168:39",
		["44"] = "168:46",
		["46"] = "168:9",
		["47"] = "166:5",
		["48"] = "171:5",
		["49"] = "172:14",
		["52"] = "173:15",
		["53"] = "177:9",
		["54"] = "178:9",
		["55"] = "179:31",
		["57"] = "179:31",
		["59"] = "179:9",
		["60"] = "180:37",
		["62"] = "180:37",
		["64"] = "180:9",
		["65"] = "181:36",
		["67"] = "181:36",
		["69"] = "181:9",
		["70"] = "182:9",
		["71"] = "183:9",
		["72"] = "186:26",
		["74"] = "186:26",
		["76"] = "186:9",
		["77"] = "187:9",
		["78"] = "188:9",
		["79"] = "189:23",
		["81"] = "189:23",
		["83"] = "189:9",
		["84"] = "192:24",
		["86"] = "192:24",
		["88"] = "192:9",
		["89"] = "193:30",
		["91"] = "193:30",
		["93"] = "193:9",
		["94"] = "194:31",
		["96"] = "194:31",
		["98"] = "194:9",
		["99"] = "195:29",
		["101"] = "195:29",
		["103"] = "195:9",
		["104"] = "196:25",
		["106"] = "196:25",
		["108"] = "196:9",
		["109"] = "199:15",
		["110"] = "200:9",
		["111"] = "202:37",
		["112"] = "202:37",
		["113"] = "203:15",
		["115"] = "204:15",
		["117"] = "202:15",
		["118"] = "205:9",
		["119"] = "208:9",
		["120"] = "211:31",
		["122"] = "211:31",
		["124"] = "211:15",
		["125"] = "212:13",
		["126"] = "213:19",
		["127"] = "214:13",
		["128"] = "214:30",
		["129"] = "214:35",
		["130"] = "214:42",
		["131"] = "214:49",
		["132"] = "214:52",
		["133"] = "214:59",
		["134"] = "214:13",
		["136"] = "218:9",
		["137"] = "221:14",
		["138"] = "222:13",
		["140"] = "171:5",
		["141"] = "227:5",
		["142"] = "228:14",
		["143"] = "229:19",
		["144"] = "230:20",
		["145"] = "230:20",
		["146"] = "230:38",
		["148"] = "230:121",
		["150"] = "230:13",
		["152"] = "233:15",
		["153"] = "234:15",
		["154"] = "235:16",
		["155"] = "235:16",
		["156"] = "235:24",
		["158"] = "235:40",
		["160"] = "235:9",
		["161"] = "227:5",
		["162"] = "239:5",
		["163"] = "240:14",
		["166"] = "242:15",
		["167"] = "243:13",
		["168"] = "245:13",
		["169"] = "246:13",
		["170"] = "247:20",
		["171"] = "248:13",
		["173"] = "250:23",
		["175"] = "250:23",
		["177"] = "250:13",
		["179"] = "253:13",
		["180"] = "254:13",
		["182"] = "239:5",
		["183"] = "258:5",
		["184"] = "259:14",
		["187"] = "261:15",
		["188"] = "262:14",
		["191"] = "265:13",
		["192"] = "266:13",
		["193"] = "267:13",
		["195"] = "271:13",
		["196"] = "272:13",
		["198"] = "276:9",
		["199"] = "276:31",
		["200"] = "276:39",
		["201"] = "276:62",
		["202"] = "276:9",
		["203"] = "279:13",
		["204"] = "280:13",
		["205"] = "280:34",
		["206"] = "280:57",
		["207"] = "281:17",
		["208"] = "282:17",
		["209"] = "283:17",
		["210"] = "284:17",
		["211"] = "280:57",
		["212"] = "280:13",
		["214"] = "258:5",
		["215"] = "289:5",
		["216"] = "290:14",
		["219"] = "291:9",
		["220"] = "289:5",
		["221"] = "294:5",
		["222"] = "295:14",
		["225"] = "296:9",
		["226"] = "294:5",
		["227"] = "299:5",
		["228"] = "300:14",
		["231"] = "303:13",
		["232"] = "304:13",
		["235"] = "309:15",
		["236"] = "310:15",
		["237"] = "310:45",
		["238"] = "310:114",
		["239"] = "310:26",
		["240"] = "313:13",
		["241"] = "313:49",
		["242"] = "313:72",
		["243"] = "313:29",
		["244"] = "314:13",
		["247"] = "319:13",
		["248"] = "320:13",
		["250"] = "324:13",
		["251"] = "325:13",
		["253"] = "299:5",
		["254"] = "329:5",
		["255"] = "330:14",
		["258"] = "333:13",
		["259"] = "334:13",
		["262"] = "339:15",
		["263"] = "340:15",
		["264"] = "340:47",
		["265"] = "340:70",
		["266"] = "340:31",
		["267"] = "341:15",
		["268"] = "342:9",
		["269"] = "329:5",
		["270"] = "345:5",
		["271"] = "346:9",
		["272"] = "345:5",
		["273"] = "349:5",
		["274"] = "350:9",
		["275"] = "349:5",
		["276"] = "353:5",
		["277"] = "354:9",
		["278"] = "353:5",
		["279"] = "360:5",
		["280"] = "361:15",
		["281"] = "362:13",
		["282"] = "362:27",
		["284"] = "364:15",
		["285"] = "365:9",
		["286"] = "360:5",
		["287"] = "369:5",
		["288"] = "370:15",
		["289"] = "371:13",
		["290"] = "371:27",
		["292"] = "373:15",
		["293"] = "374:15",
		["294"] = "376:9",
		["295"] = "376:25",
		["296"] = "376:78",
		["297"] = "376:16",
		["298"] = "369:5",
		["299"] = "380:5",
		["300"] = "381:15",
		["301"] = "382:14",
		["304"] = "383:9",
		["305"] = "383:41",
		["306"] = "383:64",
		["307"] = "383:91",
		["308"] = "383:9",
		["309"] = "380:5",
		["310"] = "125:9",
		["311"] = "126:9",
		["312"] = "127:13",
		["313"] = "126:27",
		["314"] = "129:9",
		["315"] = "130:19",
		["316"] = "131:19",
		["317"] = "132:19",
		["318"] = "133:27",
		["319"] = "133:27",
		["320"] = "133:39",
		["322"] = "133:60",
		["324"] = "133:19",
		["325"] = "134:23",
		["326"] = "134:23",
		["327"] = "134:35",
		["329"] = "134:46",
		["331"] = "134:19",
		["332"] = "135:13",
		["333"] = "129:27",
		["334"] = "137:9",
		["335"] = "138:19",
		["336"] = "139:17",
		["337"] = "140:17",
		["339"] = "142:27",
		["340"] = "142:27",
		["341"] = "142:53",
		["343"] = "142:64",
		["345"] = "142:23",
		["346"] = "143:17",
		["348"] = "137:31",
		["349"] = "146:9",
		["350"] = "147:19",
		["351"] = "148:13",
		["352"] = "146:31",
		["353"] = "125:9",
		["354"] = "153:53",
		["355"] = "154:9",
		["356"] = "155:19",
		["357"] = "156:19",
		["358"] = "157:13",
		["359"] = "154:18",
		["360"] = "159:9",
		["361"] = "160:19",
		["362"] = "161:19",
		["363"] = "162:13",
		["364"] = "159:16",
		["365"] = "153:53",
		["366"] = "76:14",
		["367"] = "75:2",
		["368"] = "75:2",
		["369"] = "75:19",
		["370"] = "75:2",
		["372"] = "75:2",
		["373"] = "76:14",
		["375"] = "76:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_MotionBoth = ____sl_modifier_base.SLModifierBase_MotionBoth
____exports.sl_modifier_custom_knockback = __TS__Class()
local sl_modifier_custom_knockback = ____exports.sl_modifier_custom_knockback
sl_modifier_custom_knockback.name = "sl_modifier_custom_knockback"
__TS__ClassExtends(sl_modifier_custom_knockback, SLModifierBase_MotionBoth)
function sl_modifier_custom_knockback.prototype.IsDebuff(self)
	return true
end
function sl_modifier_custom_knockback.prototype.IsHidden(self)
	return true
end
function sl_modifier_custom_knockback.prototype.IsPurgable(self)
	return true
end
function sl_modifier_custom_knockback.prototype.IsPurgeException(self)
	return true
end
function sl_modifier_custom_knockback.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_custom_knockback.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_custom_knockback.prototype._Boolean(self, value)
	if type(value) == "boolean" then
		return value
	end
	local ____temp_3
	if tonumber(value) == 1 then
		____temp_3 = true
	else
		____temp_3 = false
	end
	return ____temp_3
end
function sl_modifier_custom_knockback.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._duration = params.knockDuration
	self._stun = self:_Boolean(params.stun)
	local ____params_stunDuration_4 = params.stunDuration
	if ____params_stunDuration_4 == nil then
		____params_stunDuration_4 = 0
	end
	self._stun_duration = ____params_stunDuration_4
	local ____params_destroyTreesRange_5 = params.destroyTreesRange
	if ____params_destroyTreesRange_5 == nil then
		____params_destroyTreesRange_5 = 0
	end
	self._destroy_trees_range = ____params_destroyTreesRange_5
	local ____params_destroyTreesType_6 = params.destroyTreesType
	if ____params_destroyTreesType_6 == nil then
		____params_destroyTreesType_6 = nil
	end
	self._destroy_trees_type = ____params_destroyTreesType_6
	self._knockback_forward = params.knockBackForward
	self._interrupt_on_destroy = self:_Boolean(params.interruptMotionControllerOnDestroy)
	local ____params_distance_7 = params.distance
	if ____params_distance_7 == nil then
		____params_distance_7 = 0
	end
	self._distance = ____params_distance_7
	self._block = self:_Boolean(params.block)
	self._uniform = self:_Boolean(params.uniform)
	local ____params_power_8 = params.power
	if ____params_power_8 == nil then
		____params_power_8 = 0.65
	end
	self._power = ____params_power_8
	local ____params_height_9 = params.height
	if ____params_height_9 == nil then
		____params_height_9 = 0
	end
	self._height = ____params_height_9
	local ____params_heightPower_10 = params.heightPower
	if ____params_heightPower_10 == nil then
		____params_heightPower_10 = 0.65
	end
	self._height_power = ____params_heightPower_10
	local ____params_heightPower2_11 = params.heightPower2
	if ____params_heightPower2_11 == nil then
		____params_heightPower2_11 = 0.45
	end
	self._height_power2 = ____params_heightPower2_11
	local ____params_heightType_12 = params.heightType
	if ____params_heightType_12 == nil then
		____params_heightType_12 = "pow"
	end
	self._height_type = ____params_heightType_12
	local ____params_gravity_13 = params.gravity
	if ____params_gravity_13 == nil then
		____params_gravity_13 = 5000
	end
	self._gravity = ____params_gravity_13
	local height_calculator = ____exports.sl_modifier_custom_knockback._height_calculators[self._height_type]
	self._height_calculator = function(____, elapsed, timeline)
		return height_calculator(nil, self, elapsed, timeline)
	end
	local ____table__uniform_14
	if self._uniform then
		____table__uniform_14 = ____exports.sl_modifier_custom_knockback._distance_calculators.uniform
	else
		____table__uniform_14 = ____exports.sl_modifier_custom_knockback._distance_calculators.power
	end
	local distance_calculator = ____table__uniform_14
	self._distance_calculator = function(____, elapsed, last_frame_time)
		return distance_calculator(nil, self, elapsed, last_frame_time)
	end
	self._direction = self:_calculate_direction(params, parent)
	local ____params_particleName_15 = params.particleName
	if ____params_particleName_15 == nil then
		____params_particleName_15 = GENERIC_PARTICLES.knockback
	end
	local particle_name = ____params_particleName_15
	if particle_name then
		local pid = SParticleManager:CreateGenericParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, parent)
		self:AddParticle(pid, false, false, 1, false, false)
	end
	self:_apply_knockback_forward()
	if not self:ApplyVerticalMotionController() or not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end
function sl_modifier_custom_knockback.prototype._calculate_direction(self, params, parent)
	if not params.direction then
		local caster = self:GetCaster()
		local ____IsValid_result_16
		if IsValid(caster) then
			____IsValid_result_16 = SLVector:Normalized2D(parent:GetAbsOrigin() - caster:GetAbsOrigin())
		else
			____IsValid_result_16 = parent:GetForwardVector()
		end
		return ____IsValid_result_16
	end
	local direction_vec = StringToVector(params.direction)
	local is_3d = self:_Boolean(params.direction_3d)
	local ____is_3d_17
	if is_3d then
		____is_3d_17 = direction_vec
	else
		____is_3d_17 = Vector(direction_vec.x, direction_vec.y, 0)
	end
	return ____is_3d_17
end
function sl_modifier_custom_knockback.prototype._apply_knockback_forward(self)
	if not self._knockback_forward or not self._direction then
		return
	end
	local parent = self:GetParent()
	local forward = nil
	if self._knockback_forward == "towardsCaster" then
		forward = -self._direction
	elseif self._knockback_forward == "backCaster" then
		forward = self._direction
	else
		local ____StringToVector_result_18 = StringToVector(self._knockback_forward)
		if ____StringToVector_result_18 == nil then
			____StringToVector_result_18 = nil
		end
		forward = ____StringToVector_result_18
	end
	if forward then
		parent:SetForwardVectorWithoutInterrupt(forward)
	end
end
function sl_modifier_custom_knockback.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	if IsValid(self) then
		parent:RemoveHorizontalMotionController(self)
		parent:RemoveVerticalMotionController(self)
	end
	if self._destroy_trees_type == "onDestroy" then
		self:_destroy_trees()
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), self._interrupt_on_destroy)
	if self._stun_duration > self._duration and IsValidAlive(parent) then
		parent:AddSLModifier("modifier_stunned", {
			ability = self:GetAbility(),
			caster = self:GetCaster(),
			calculate_status_resistance = true,
			duration = self._stun_duration - self._duration,
		})
	end
end
function sl_modifier_custom_knockback.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function sl_modifier_custom_knockback.prototype.OnVerticalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function sl_modifier_custom_knockback.prototype.UpdateHorizontalMotion(self, parent, dt)
	if not IsValid(parent) or not IsServer() then
		return
	end
	if self:GetElapsedTime() > self._duration then
		self:Destroy()
		return
	end
	local distance_delta = self:_get_knock_distance_delta()
	local position = GetGroundPosition(parent:GetAbsOrigin() + self._direction * distance_delta, parent)
	if self._block and not GridNav:CanFindPath(parent:GetAbsOrigin(), position) then
		self:Destroy()
		return
	end
	if self._destroy_trees_type == "continues" then
		self:_destroy_trees()
	end
	if position then
		parent:SetAbsOrigin(position)
	end
end
function sl_modifier_custom_knockback.prototype.UpdateVerticalMotion(self, parent, dt)
	if not IsValid(parent) or not IsServer() then
		return
	end
	if self:GetElapsedTime() > self._duration then
		self:Destroy()
		return
	end
	local fly_height = self:_get_fly_height()
	local ground_height = GetGroundHeight(parent:GetAbsOrigin(), parent)
	local pos = parent:GetAbsOrigin()
	parent:SetAbsOrigin(Vector(pos.x, pos.y, ground_height + fly_height))
end
function sl_modifier_custom_knockback.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function sl_modifier_custom_knockback.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function sl_modifier_custom_knockback.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = self._stun }
end
function sl_modifier_custom_knockback.prototype._get_fly_height(self)
	local elapsed = self:GetElapsedTime()
	if elapsed <= 0 then
		return 0
	end
	local timeline = elapsed / self._duration
	return self:_height_calculator(elapsed, timeline)
end
function sl_modifier_custom_knockback.prototype._get_knock_distance_delta(self)
	local elapsed = self:GetElapsedTime()
	if elapsed <= 0 then
		return 0
	end
	local dt = 0.03333
	local last_frame_time = math.max(elapsed - dt, 0)
	return math.max(self:_distance_calculator(elapsed, last_frame_time), 0)
end
function sl_modifier_custom_knockback.prototype._destroy_trees(self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	GridNav:DestroyTreesAroundPoint(parent:GetAbsOrigin(), self._destroy_trees_range, true)
end
sl_modifier_custom_knockback._height_calculators = {
	sin = function(____, ____self, elapsed)
		return math.sin(elapsed * (math.pi / ____self._duration)) * ____self._height
	end,
	pow = function(____, ____self, elapsed, timeline)
		local point = 0.6
		local is_rising = timeline <= point
		local factor = is_rising and point or 1 - point
		local ____is_rising_0
		if is_rising then
			____is_rising_0 = ____self._height_power
		else
			____is_rising_0 = ____self._height_power2
		end
		local power = ____is_rising_0
		local ____is_rising_1
		if is_rising then
			____is_rising_1 = timeline
		else
			____is_rising_1 = 1 - timeline
		end
		local t = ____is_rising_1
		return math.pow(t / factor, power) * ____self._height
	end,
	pow2sin = function(____, ____self, elapsed, timeline)
		local split_point = 1 / 3
		if timeline >= split_point and timeline <= 1 - split_point then
			return math.sin(timeline * math.pi) * ____self._height
		else
			local ____temp_2
			if timeline <= split_point then
				____temp_2 = timeline
			else
				____temp_2 = 1 - timeline
			end
			local t = ____temp_2
			return math.pow(t * 2, 0.35) * ____self._height
		end
	end,
	gravity = function(____, ____self, elapsed)
		local initial_velocity = ____self._duration * ____self._gravity / 2
		return elapsed * initial_velocity - 0.5 * ____self._gravity * math.pow(elapsed, 2)
	end,
}
sl_modifier_custom_knockback._distance_calculators = {
	uniform = function(____, ____self, elapsed, last_frame_time)
		local current = ____self._distance / ____self._duration * elapsed
		local last = ____self._distance / ____self._duration * last_frame_time
		return current - last
	end,
	power = function(____, ____self, elapsed, last_frame_time)
		local current = math.pow(elapsed / ____self._duration, ____self._power) * ____self._distance
		local last = math.pow(last_frame_time / ____self._duration, ____self._power) * ____self._distance
		return current - last
	end,
}
sl_modifier_custom_knockback = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_custom_knockback", nil, getfenv()) },
	sl_modifier_custom_knockback
)
____exports.sl_modifier_custom_knockback = sl_modifier_custom_knockback
return ____exports