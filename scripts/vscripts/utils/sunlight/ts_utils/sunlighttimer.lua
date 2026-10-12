--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightTimer.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightTimer.lua",
	{
		["10"] = "1:7",
		["11"] = "1:1",
		["12"] = "115:17",
		["13"] = "3:5",
		["14"] = "6:5",
		["15"] = "8:5",
		["16"] = "116:9",
		["17"] = "115:5",
		["18"] = "10:5",
		["19"] = "11:15",
		["20"] = "12:16",
		["21"] = "14:19",
		["22"] = "15:18",
		["25"] = "19:13",
		["26"] = "20:13",
		["28"] = "10:5",
		["29"] = "24:5",
		["30"] = "25:15",
		["31"] = "26:15",
		["32"] = "27:16",
		["33"] = "28:17",
		["34"] = "30:19",
		["36"] = "31:22",
		["37"] = "31:37",
		["38"] = "32:21",
		["39"] = "33:21",
		["41"] = "31:57",
		["44"] = "36:17",
		["47"] = "39:13",
		["48"] = "40:13",
		["50"] = "24:5",
		["51"] = "44:5",
		["52"] = "45:16",
		["53"] = "46:9",
		["54"] = "47:9",
		["55"] = "44:5",
		["56"] = "53:5",
		["57"] = "56:9",
		["58"] = "57:9",
		["59"] = "53:5",
		["60"] = "60:5",
		["61"] = "61:9",
		["62"] = "60:5",
		["63"] = "65:5",
		["64"] = "66:9",
		["65"] = "67:9",
		["66"] = "68:15",
		["67"] = "69:9",
		["68"] = "71:9",
		["69"] = "65:5",
		["70"] = "75:5",
		["71"] = "76:9",
		["72"] = "75:5",
		["73"] = "80:5",
		["74"] = "81:9",
		["75"] = "80:5",
		["76"] = "85:5",
		["77"] = "86:13",
		["78"] = "87:13",
		["80"] = "85:5",
		["81"] = "92:5",
		["82"] = "93:13",
		["85"] = "94:15",
		["86"] = "95:13",
		["87"] = "96:19",
		["88"] = "97:13",
		["89"] = "98:13",
		["90"] = "99:13",
		["91"] = "100:13",
		["92"] = "101:13",
		["93"] = "102:20",
		["94"] = "103:19",
		["95"] = "104:13",
		["96"] = "105:13",
		["100"] = "92:5",
		["101"] = "120:5",
		["102"] = "121:13",
		["103"] = "122:20",
		["104"] = "123:35",
		["105"] = "123:35",
		["106"] = "123:46",
		["108"] = "123:81",
		["110"] = "123:13",
		["112"] = "125:9",
		["113"] = "120:5",
		["114"] = "129:1",
		["115"] = "129:14",
		["116"] = "129:1",
		["117"] = "302:17",
		["118"] = "136:5",
		["119"] = "138:5",
		["120"] = "139:5",
		["121"] = "145:5",
		["122"] = "145:46",
		["123"] = "145:53",
		["124"] = "147:13",
		["125"] = "148:13",
		["126"] = "149:20",
		["127"] = "152:13",
		["129"] = "154:13",
		["131"] = "145:53",
		["132"] = "145:42",
		["133"] = "238:5",
		["134"] = "303:9",
		["135"] = "306:9",
		["136"] = "306:59",
		["137"] = "306:74",
		["138"] = "306:27",
		["139"] = "309:9",
		["140"] = "310:9",
		["141"] = "302:5",
		["142"] = "167:5",
		["143"] = "168:13",
		["144"] = "169:13",
		["145"] = "171:13",
		["146"] = "172:13",
		["147"] = "173:13",
		["149"] = "175:13",
		["150"] = "176:13",
		["152"] = "179:15",
		["153"] = "183:15",
		["154"] = "184:13",
		["155"] = "185:13",
		["156"] = "186:13",
		["157"] = "187:13",
		["158"] = "183:30",
		["159"] = "190:9",
		["160"] = "192:9",
		["161"] = "194:9",
		["162"] = "195:9",
		["163"] = "167:5",
		["164"] = "199:5",
		["165"] = "200:14",
		["168"] = "201:15",
		["169"] = "202:13",
		["170"] = "203:13",
		["171"] = "204:13",
		["172"] = "206:17",
		["173"] = "207:17",
		["176"] = "199:5",
		["177"] = "213:5",
		["178"] = "214:9",
		["179"] = "215:13",
		["181"] = "213:5",
		["182"] = "220:5",
		["183"] = "221:13",
		["184"] = "222:13",
		["186"] = "224:13",
		["188"] = "220:5",
		["189"] = "229:5",
		["190"] = "230:9",
		["191"] = "229:5",
		["192"] = "234:5",
		["193"] = "235:9",
		["194"] = "234:5",
		["195"] = "239:5",
		["196"] = "240:15",
		["197"] = "241:9",
		["198"] = "242:9",
		["199"] = "239:5",
		["200"] = "245:5",
		["201"] = "247:9",
		["202"] = "248:15",
		["203"] = "251:13",
		["204"] = "252:16",
		["205"] = "254:13",
		["206"] = "256:13",
		["207"] = "257:13",
		["208"] = "259:17",
		["209"] = "261:24",
		["210"] = "261:49",
		["211"] = "261:74",
		["212"] = "263:21",
		["213"] = "264:21",
		["214"] = "261:74",
		["215"] = "261:42",
		["216"] = "266:17",
		["217"] = "267:21",
		["218"] = "269:25",
		["219"] = "270:25",
		["220"] = "271:25",
		["222"] = "273:25",
		["225"] = "277:25",
		["226"] = "277:47",
		["227"] = "277:58",
		["228"] = "277:94",
		["230"] = "277:47",
		["232"] = "279:21",
		["235"] = "283:13",
		["237"] = "285:9",
		["238"] = "245:5",
		["239"] = "289:5",
		["240"] = "292:9",
		["241"] = "289:5",
		["242"] = "298:5",
		["243"] = "299:9",
		["244"] = "298:5",
		["245"] = "334:1",
		["246"] = "335:1",
	}
)
local ____exports = {}
local SLHeap = __TS__Class()
SLHeap.name = "SLHeap"
function SLHeap.prototype.____constructor(self, filter)
	self._heap_tree = {}
	self._length = 0
	self._top = 1
	self._Filter = filter
end
function SLHeap.prototype._BubbleUp(self, pos)
	local values = self._heap_tree
	while pos > self._top do
		local parent = math.floor(pos / 2)
		if not self:_Filter(values[pos], values[parent]) then
			break
		end
		self:_Swap(parent, pos)
		pos = parent
	end
end
function SLHeap.prototype._SinkDown(self, pos)
	local values = self._heap_tree
	local last = self._length
	while true do
		local min = pos
		local child = 2 * pos
		do
			local index = child
			while index <= child + 1 do
				if index <= last and self:_Filter(values[index], values[min]) then
					min = index
				end
				index = index + 1
			end
		end
		if min == pos then
			break
		end
		self:_Swap(pos, min)
		pos = min
	end
end
function SLHeap.prototype._Swap(self, i, j)
	local current, target = self._heap_tree[i], self._heap_tree[j]
	self._heap_tree[j] = current
	self._heap_tree[i] = target
end
function SLHeap.prototype._Erase(self, pos)
	self._heap_tree[pos] = nil
	self._length = self._length - 1
end
function SLHeap.prototype._Filter(self, a, b)
	return a < b
end
function SLHeap.prototype.Insert(self, value)
	assert(value ~= nil, "value is undefined")
	self._length = self._length + 1
	local pos = self._length
	self._heap_tree[pos] = value
	self:_BubbleUp(pos)
end
function SLHeap.prototype.Peek(self)
	return self._heap_tree[self._top]
end
function SLHeap.prototype.Size(self)
	return self._length
end
function SLHeap.prototype.Pop(self)
	if self._heap_tree[self._top] ~= nil then
		return self:Remove(self._top)
	end
end
function SLHeap.prototype.Remove(self, pos)
	if pos < 1 then
		return
	end
	local last = self._length
	if pos < last then
		local value = self._heap_tree[pos]
		self:_Swap(pos, last)
		self:_Erase(last)
		self:_BubbleUp(pos)
		self:_SinkDown(pos)
		return value
	elseif pos == last then
		local value = self._heap_tree[pos]
		self:_Erase(pos)
		return value
	else
		return
	end
end
function SLHeap.prototype.Info(self, msg_func)
	local result = ""
	for index in pairs(self._heap_tree) do
		local ____msg_func_0
		if msg_func then
			____msg_func_0 = msg_func(nil, self._heap_tree[index])
		else
			____msg_func_0 = self._heap_tree[index]
		end
		result = result .. ((index .. ":") .. tostring(____msg_func_0)) .. "\n"
	end
	return result
end
____exports.SLTimer = __TS__Class()
local SLTimer = ____exports.SLTimer
SLTimer.name = "SLTimer"
function SLTimer.prototype.____constructor(self, is_system_timer)
	self._think_min_interval = 0.033334
	self._now_time = 0
	self._timer_id_map = {}
	self._timer_heap = __TS__New(SLHeap, function(____, t1, t2)
		if t1.end_time < t2.end_time then
			return true
		elseif t1.end_time == t2.end_time then
			return t1.id < t2.id
		else
			return false
		end
	end)
	self._count = 1
	self._is_system_timer = is_system_timer
	self._timer_ent = SpawnEntityFromTableSynchronous("info_target", { targetname = DoUniqueString("SLTimer") })
	self._think_return_time = is_system_timer and 0.01 or self._think_min_interval
	self._timer_ent:SetThink("_Think", self, self.constructor.name, 0)
end
function SLTimer.prototype.CreateTimer(self, p1, p2)
	local delay
	local callback
	if type(p1) == "number" then
		delay = p1
		callback = p2
	else
		delay = 0
		callback = p1
	end
	local timer_delay = self:_GetMinDelay(delay)
	local timer = {
		end_time = self._now_time + timer_delay,
		call_back = callback,
		id = self:_GenerateTimerId(),
		is_remove = false,
	}
	assert(timer.call_back, "Invalid timer created")
	self._timer_id_map[timer.id] = timer
	self._timer_heap:Insert(timer)
	return timer.id
end
function SLTimer.prototype.RemoveTimer(self, timer_id)
	if not timer_id then
		return
	end
	local timer = self._timer_id_map[timer_id]
	if timer then
		self._timer_id_map[timer_id] = nil
		timer.is_remove = true
		if self._running_timer == timer then
			self._remove_self = true
		end
	end
end
function SLTimer.prototype.RemoveTimers_All(self)
	for ____, timer_id in ipairs(__TS__ObjectKeys(self._timer_id_map)) do
		self:RemoveTimer(tonumber(timer_id))
	end
end
function SLTimer.prototype.IsValid(self, timer_id)
	if timer_id and self._timer_id_map[timer_id] ~= nil and self._timer_id_map[timer_id].is_remove ~= true then
		return true
	else
		return false
	end
end
function SLTimer.prototype.Size(self)
	return #__TS__ObjectKeys(self._timer_id_map)
end
function SLTimer.prototype._GetMinDelay(self, delay)
	return math.max(delay, self._think_min_interval)
end
function SLTimer.prototype._GenerateTimerId(self)
	local id = self._count
	self._count = self._count + 1
	return id
end
function SLTimer.prototype._Think(self)
	self:_UpdateNowTime()
	local now = self._now_time
	local current_timer = self._timer_heap:Peek()
	while current_timer and now >= current_timer.end_time do
		self._timer_heap:Pop()
		self._running_timer = current_timer
		self._remove_self = false
		if current_timer.is_remove ~= true then
			local status, result = xpcall(current_timer.call_back, function(err)
				SLError(err, "Timer 回调失败", "utils/sunlight/ts_utils/SunLightTimer.ts:263:21")
				return err
			end)
			self._running_timer = nil
			if status then
				if result and not self._remove_self then
					current_timer.end_time = current_timer.end_time + self:_GetMinDelay(result)
					self._timer_heap:Insert(current_timer)
				else
					self:RemoveTimer(current_timer.id)
				end
			else
				if self._on_cache_error then
					SafelyCall(function()
						return self:_on_cache_error(result)
					end, "Timer 错误收集回调失败", "utils/sunlight/ts_utils/SunLightTimer.ts:277:47")
				end
				self:RemoveTimer(current_timer.id)
			end
		end
		current_timer = self._timer_heap:Peek()
	end
	return self._think_return_time
end
function SLTimer.prototype._UpdateNowTime(self)
	self._now_time = self._now_time + self._think_min_interval
end
function SLTimer.prototype.RegisterOnCacheError(self, on_catch)
	self._on_cache_error = on_catch
end
_G.Timers = _G.Timers or __TS__New(____exports.SLTimer)
_G.SysTimer = _G.SysTimer or __TS__New(____exports.SLTimer, true)
return ____exports