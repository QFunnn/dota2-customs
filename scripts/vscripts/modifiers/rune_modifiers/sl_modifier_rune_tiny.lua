--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_tiny.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_tiny.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "5:7",
		["17"] = "7:7",
		["24"] = "17:7",
		["26"] = "19:7",
		["28"] = "22:7",
		["30"] = "24:7",
		["32"] = "26:7",
		["34"] = "28:7",
		["36"] = "30:7",
		["38"] = "32:7",
		["40"] = "35:7",
		["42"] = "37:7",
		["44"] = "39:7",
		["46"] = "41:7",
		["48"] = "43:7",
		["49"] = "55:7",
		["53"] = "62:1",
		["54"] = "63:14",
		["55"] = "62:1",
		["56"] = "63:36",
		["58"] = "63:44",
		["59"] = "65:5",
		["60"] = "62:1",
		["61"] = "71:5",
		["62"] = "72:9",
		["63"] = "71:5",
		["64"] = "75:5",
		["65"] = "76:9",
		["66"] = "76:16",
		["67"] = "78:13",
		["68"] = "79:13",
		["69"] = "76:16",
		["70"] = "75:5",
		["71"] = "83:5",
		["72"] = "84:15",
		["73"] = "84:25",
		["74"] = "86:13",
		["75"] = "87:13",
		["76"] = "84:25",
		["77"] = "89:15",
		["78"] = "89:25",
		["79"] = "91:13",
		["80"] = "92:13",
		["81"] = "89:25",
		["82"] = "94:9",
		["83"] = "83:5",
		["84"] = "97:5",
		["85"] = "98:9",
		["86"] = "97:5",
		["87"] = "101:5",
		["88"] = "102:15",
		["89"] = "103:9",
		["90"] = "101:5",
		["91"] = "108:5",
		["92"] = "63:44",
		["93"] = "110:14",
		["96"] = "111:15",
		["97"] = "112:14",
		["100"] = "114:9",
		["101"] = "115:9",
		["102"] = "115:53",
		["103"] = "115:83",
		["104"] = "115:9",
		["105"] = "119:9",
		["106"] = "120:13",
		["107"] = "121:13",
		["108"] = "122:13",
		["109"] = "123:23",
		["110"] = "124:22",
		["113"] = "125:23",
		["114"] = "126:21",
		["115"] = "127:21",
		["116"] = "128:28",
		["117"] = "129:21",
		["118"] = "130:28",
		["119"] = "131:21",
		["121"] = "122:13",
		["122"] = "134:13",
		["123"] = "135:13",
		["124"] = "119:9",
		["125"] = "137:9",
		["126"] = "138:13",
		["127"] = "139:13",
		["128"] = "140:13",
		["129"] = "141:23",
		["130"] = "142:22",
		["133"] = "143:17",
		["134"] = "140:13",
		["135"] = "145:13",
		["136"] = "146:13",
		["137"] = "137:9",
		["138"] = "148:9",
		["139"] = "149:13",
		["140"] = "150:13",
		["141"] = "151:13",
		["142"] = "152:55",
		["143"] = "152:25",
		["144"] = "152:35",
		["145"] = "152:46",
		["146"] = "153:21",
		["149"] = "154:21",
		["152"] = "155:21",
		["155"] = "156:23",
		["156"] = "157:21",
		["159"] = "158:17",
		["160"] = "159:17",
		["161"] = "151:13",
		["162"] = "161:13",
		["163"] = "162:13",
		["164"] = "148:9",
		["165"] = "108:5",
		["166"] = "167:5",
		["167"] = "168:9",
		["168"] = "169:18",
		["171"] = "171:13",
		["172"] = "172:17",
		["173"] = "173:17",
		["174"] = "174:17",
		["175"] = "175:17",
		["176"] = "176:17",
		["177"] = "177:17",
		["178"] = "178:17",
		["179"] = "179:17",
		["180"] = "180:17",
		["181"] = "171:13",
		["182"] = "168:28",
		["183"] = "167:5",
		["184"] = "188:5",
		["185"] = "189:13",
		["188"] = "190:15",
		["189"] = "191:9",
		["190"] = "191:28",
		["191"] = "191:35",
		["192"] = "192:18",
		["195"] = "193:13",
		["196"] = "191:35",
		["197"] = "191:9",
		["198"] = "188:5",
		["199"] = "201:5",
		["200"] = "202:15",
		["201"] = "203:15",
		["202"] = "205:13",
		["203"] = "206:13",
		["204"] = "209:21",
		["205"] = "210:21",
		["206"] = "211:21",
		["207"] = "212:21",
		["208"] = "213:21",
		["209"] = "214:21",
		["210"] = "215:21",
		["211"] = "208:17",
		["214"] = "222:15",
		["215"] = "223:15",
		["216"] = "225:15",
		["217"] = "226:15",
		["218"] = "227:9",
		["219"] = "230:17",
		["220"] = "231:17",
		["221"] = "232:17",
		["222"] = "233:17",
		["223"] = "234:17",
		["224"] = "235:17",
		["225"] = "236:17",
		["226"] = "237:17",
		["227"] = "238:17",
		["228"] = "239:17",
		["229"] = "229:13",
		["230"] = "201:5",
		["231"] = "246:5",
		["232"] = "247:15",
		["233"] = "248:13",
		["234"] = "249:13",
		["236"] = "251:9",
		["237"] = "246:5",
		["238"] = "258:5",
		["239"] = "259:9",
		["240"] = "260:13",
		["243"] = "261:15",
		["244"] = "262:15",
		["245"] = "263:15",
		["246"] = "264:13",
		["247"] = "266:23",
		["248"] = "267:18",
		["249"] = "267:71",
		["251"] = "268:13",
		["252"] = "270:19",
		["253"] = "271:13",
		["254"] = "271:32",
		["255"] = "271:39",
		["256"] = "272:22",
		["259"] = "273:17",
		["260"] = "271:39",
		["261"] = "271:13",
		["262"] = "275:13",
		["263"] = "266:15",
		["264"] = "278:9",
		["265"] = "279:9",
		["266"] = "279:55",
		["267"] = "279:65",
		["268"] = "280:17",
		["269"] = "280:26",
		["271"] = "281:17",
		["272"] = "281:32",
		["274"] = "282:13",
		["275"] = "279:65",
		["276"] = "279:36",
		["277"] = "258:5",
		["278"] = "286:5",
		["279"] = "287:15",
		["280"] = "288:15",
		["281"] = "289:13",
		["284"] = "290:15",
		["285"] = "291:9",
		["286"] = "294:17",
		["287"] = "295:17",
		["288"] = "296:17",
		["289"] = "297:17",
		["290"] = "298:17",
		["291"] = "299:17",
		["292"] = "300:17",
		["293"] = "302:17",
		["294"] = "303:17",
		["295"] = "304:17",
		["296"] = "293:13",
		["297"] = "286:5",
		["298"] = "310:5",
		["299"] = "311:14",
		["302"] = "312:9",
		["303"] = "313:9",
		["304"] = "310:5",
		["305"] = "320:5",
		["306"] = "321:14",
		["309"] = "322:15",
		["310"] = "323:13",
		["311"] = "324:13",
		["314"] = "327:9",
		["315"] = "329:13",
		["316"] = "329:56",
		["318"] = "320:5",
		["319"] = "332:5",
		["320"] = "333:15",
		["321"] = "334:16",
		["322"] = "334:16",
		["323"] = "334:28",
		["325"] = "334:36",
		["327"] = "334:9",
		["328"] = "332:5",
		["329"] = "345:5",
		["330"] = "346:15",
		["331"] = "347:13",
		["334"] = "348:13",
		["335"] = "349:13",
		["336"] = "350:19",
		["337"] = "351:18",
		["340"] = "352:13",
		["342"] = "354:13",
		["344"] = "356:9",
		["345"] = "357:9",
		["346"] = "345:5",
		["347"] = "360:5",
		["348"] = "361:15",
		["349"] = "362:13",
		["350"] = "362:48",
		["353"] = "363:18",
		["354"] = "363:48",
		["355"] = "364:19",
		["357"] = "365:22",
		["358"] = "365:33",
		["359"] = "366:23",
		["360"] = "366:53",
		["361"] = "366:104",
		["362"] = "366:35",
		["363"] = "367:21",
		["364"] = "367:55",
		["366"] = "365:46",
		["369"] = "363:85",
		["372"] = "370:9",
		["373"] = "360:5",
		["374"] = "374:5",
		["375"] = "375:14",
		["376"] = "375:68",
		["378"] = "376:9",
		["379"] = "374:5",
		["380"] = "379:5",
		["381"] = "380:15",
		["382"] = "381:14",
		["385"] = "382:15",
		["386"] = "383:13",
		["387"] = "384:13",
		["388"] = "385:13",
		["389"] = "386:13",
		["390"] = "382:23",
		["391"] = "382:23",
		["392"] = "382:23",
		["393"] = "382:23",
		["394"] = "391:13",
		["395"] = "382:23",
		["396"] = "393:9",
		["398"] = "394:18",
		["399"] = "394:38",
		["401"] = "396:13",
		["402"] = "396:35",
		["403"] = "396:41",
		["404"] = "396:62",
		["405"] = "396:13",
		["409"] = "379:5",
		["410"] = "402:5",
		["411"] = "403:14",
		["414"] = "404:9",
		["415"] = "405:13",
		["416"] = "406:13",
		["418"] = "408:15",
		["419"] = "409:13",
		["420"] = "410:19",
		["421"] = "411:13",
		["422"] = "412:13",
		["423"] = "413:13",
		["425"] = "402:5",
		["426"] = "63:14",
		["427"] = "62:2",
		["428"] = "62:2",
		["429"] = "62:19",
		["430"] = "62:2",
		["432"] = "62:2",
		["433"] = "63:14",
		["435"] = "63:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 生树弹道的监听 id 前缀
local TINY_TREE_LISTENER_PREFIX = "rune_tiny_tree_"
--- 弹道无模型无特效，只用来对齐原生落地时刻
local TINY_TREE_PROJECTILE_EFFECT = ""
--- 原生扔树/连掷的可见弹道往往比 ability_fully_cast 晚 1～2 帧才真正创建。
-- 陪跑弹若同帧发射会整体提前一小段，看起来「比原始快一点」。
--
-- TODO(rune_tiny 生树弹道同步)：延迟 + attach_attack1 仍无法与原生树完全对齐（弧线/出手帧差）。
-- 若以后要精确同步，可考虑启用 SetTrackingProjectileFilter，在原生弹创建当帧用其 move_speed 发陪跑弹；
-- 点地线性弹无对应 Filter，可能仍只能估时或继续微调。当前先按「销毁必生树」验收，不追求像素级同步。
local TINY_TREE_LAUNCH_DELAY_FRAMES = 2
--- 扔树起点优先用抓树挂点，与原生出手位置对齐；找不到再退回单位原点
local TINY_TREE_THROW_ATTACHMENT = "attach_attack1"
--- 扔树 / 树木连掷取不到 KV speed 时的弹道速度兜底值
local TINY_TREE_FALLBACK_PROJECTILE_SPEED = 900
--- 点地扔树取不到 KV range 时的最大飞行距离兜底值（官方/项目 AbilityValues.range 现为 1200）
local TINY_TOSS_TREE_FALLBACK_RANGE = 1200
--- 点地扔树取不到 KV splash_radius 时的弹道碰撞半径兜底值（wiki 另记 collision≈300，KV 仅有 splash）
local TINY_TOSS_TREE_FALLBACK_COLLISION_RADIUS = 275
--- 树木连掷取不到 KV interval 时的抛射间隔兜底值
local TINY_TREE_CHANNEL_FALLBACK_INTERVAL = 0.5
--- 树木连掷最多抛射次数：原生 AbilityChannelTime 2.5 / interval 0.5，引擎未暴露引导时长，只能按上限兜底
local TINY_TREE_CHANNEL_MAX_THROW = 5
--- 连掷弹道不与单位碰撞，半径只要大于 0 即可
local TINY_TREE_CHANNEL_COLLISION_RADIUS = 1
--- 树木占 128x128 格挡格，半对角约 90；原生「树旁 150 内有单位则不重生」，按 150 找可能被卡住的单位
local TINY_TREE_BLOCK_CHECK_RADIUS = 150
--- 找可放树空位时的环形搜索步长
local TINY_TREE_SPOT_STEP = 64
--- 找可放树空位时的最大搜索半径
local TINY_TREE_SPOT_MAX_RADIUS = 256
--- 找可放树空位时的环形搜索角度步长
local TINY_TREE_SPOT_ANGLE_STEP = 30
--- 新树与已有树的最小间距，避免叠进同一格
local TINY_TREE_SPOT_TREE_CLEARANCE = 64
local TINY_TREE_MODE_KEY = "tiny_tree_mode"
--- 每点力量提升{hp_per_str}生命值，每点力量或敏捷提升{batk_per_str_agi}基础攻击力<br>
-- 丢树（扔树）或投掷树木（神杖树木连掷）落地后，在目标位置生成持续{temporary_tree_duration}秒的临时树木<br>
-- 18级后获得高空视野；二技能投掷对受击敌人各附带一次强制普通攻击
____exports.sl_modifier_rune_tiny = __TS__Class()
local sl_modifier_rune_tiny = ____exports.sl_modifier_rune_tiny
sl_modifier_rune_tiny.name = "sl_modifier_rune_tiny"
__TS__ClassExtends(sl_modifier_rune_tiny, sl_modifier_rune_base)
function sl_modifier_rune_tiny.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._toss_attacked = {}
end
function sl_modifier_rune_tiny.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_rune_tiny.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_tiny.prototype.GetModifierBaseAttack_BonusDamage(self)
	local str_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	return str_atk + agi_atk
end
function sl_modifier_rune_tiny.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("temporary_tree_duration")
end
function sl_modifier_rune_tiny.prototype.CheckState(self)
	local parent = self:GetParent()
	return { [MODIFIER_STATE_FORCED_FLYING_VISION] = IsValid(parent) and parent:GetLevel() >= 18 }
end
function sl_modifier_rune_tiny.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	self._projectile_listener_id = TINY_TREE_LISTENER_PREFIX .. tostring(self)
	SLModules.CustomProjectile:RegisterListener(self._projectile_listener_id, {
		OnHit = function(____, _source, _target, location, extra_data)
			return self:_OnTreeProjectileHit(location, extra_data)
		end,
	})
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) then
			return
		end
		local ability_name = ability:GetAbilityName()
		if ability_name == "tiny_toss" then
			self._toss_attacked = {}
		elseif ability_name == "tiny_toss_tree" then
			self:_ScheduleTossTreeProjectile(parent, ability, event.target)
		elseif ability_name == "tiny_tree_channel" then
			self:_StartTreeChannelVolley(parent, ability)
		end
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "ability_end_channel", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "tiny_tree_channel" then
			return
		end
		self:_StopTreeChannelVolley()
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "apply_damage", function(____, event)
		local ____event_0 = event
		local attacker = ____event_0.attacker
		local inflictor = ____event_0.inflictor
		local unit = ____event_0.unit
		if attacker ~= parent or not IsValid(inflictor) or not IsValidAlive(unit) then
			return
		end
		if inflictor:GetAbilityName() ~= "tiny_toss" then
			return
		end
		if unit:GetTeam() == parent:GetTeam() then
			return
		end
		local ent = unit:GetEntityIndex()
		if self._toss_attacked[ent] then
			return
		end
		self._toss_attacked[ent] = true
		self:_PerformTossAttack(parent, unit)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_tiny.prototype._PerformTossAttack(self, parent, target)
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValidAlive(parent) or not IsValidAlive(target) then
			return
		end
		parent:PerformAttackWithFixedParams(
			{ record_context = self, fix_miss_on_out_of_attack_range = true },
			target,
			true,
			true,
			true,
			true,
			false,
			false,
			false
		)
	end)
end
function sl_modifier_rune_tiny.prototype._ScheduleTossTreeProjectile(self, parent, ability, target)
	if self:_GetRuneSpecialValue("temporary_tree_duration") <= 0 then
		return
	end
	local delay = FrameTime() * TINY_TREE_LAUNCH_DELAY_FRAMES
	Timers:CreateTimer(delay, function()
		if not IsValid(self) or not IsValidAlive(parent) or not IsValid(ability) then
			return
		end
		self:_LaunchTossTreeProjectile(parent, ability, target)
	end)
end
function sl_modifier_rune_tiny.prototype._LaunchTossTreeProjectile(self, parent, ability, target)
	local speed = self:_GetAbilityValue(ability, "speed", TINY_TREE_FALLBACK_PROJECTILE_SPEED)
	local start_pos = self:_GetTreeThrowStartPos(parent)
	if IsValidAlive(target) then
		SLModules.CustomProjectile:CreateTrackingProjectileForListener(self._projectile_listener_id, {
			EffectName = TINY_TREE_PROJECTILE_EFFECT,
			Source = parent,
			Target = target,
			vSourceLoc = start_pos,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
			iMoveSpeed = speed,
			bDodgeable = true,
		}, { [TINY_TREE_MODE_KEY] = 1 })
		return
	end
	local cast_pos = ability:GetCursorPosition()
	local direction = SLVector:Normalized2D(cast_pos - start_pos)
	local range = self:_GetAbilityValue(ability, "range", TINY_TOSS_TREE_FALLBACK_RANGE)
	local collision_radius = self:_GetAbilityValue(ability, "splash_radius", TINY_TOSS_TREE_FALLBACK_COLLISION_RADIUS)
	SLModules.CustomProjectile:CreateLinearProjectileForListener(self._projectile_listener_id, {
		EffectName = TINY_TREE_PROJECTILE_EFFECT,
		Source = parent,
		vSpawnOrigin = start_pos,
		vVelocity = direction * speed,
		fDistance = range,
		fStartRadius = collision_radius,
		fEndRadius = collision_radius,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	}, { [TINY_TREE_MODE_KEY] = 2 })
end
function sl_modifier_rune_tiny.prototype._GetTreeThrowStartPos(self, parent)
	local attach = parent:ScriptLookupAttachment(TINY_TREE_THROW_ATTACHMENT)
	if attach and attach > 0 then
		return parent:GetAttachmentOrigin(attach)
	end
	return parent:GetAbsOrigin()
end
function sl_modifier_rune_tiny.prototype._StartTreeChannelVolley(self, parent, ability)
	self:_StopTreeChannelVolley()
	if self:_GetRuneSpecialValue("temporary_tree_duration") <= 0 then
		return
	end
	local target_pos = ability:GetCursorPosition()
	local speed = self:_GetAbilityValue(ability, "speed", TINY_TREE_FALLBACK_PROJECTILE_SPEED)
	local interval = self:_GetAbilityValue(ability, "interval", TINY_TREE_CHANNEL_FALLBACK_INTERVAL)
	local left = TINY_TREE_CHANNEL_MAX_THROW
	local function Throw()
		if not IsValid(self) or not IsValidAlive(parent) or left <= 0 then
			return false
		end
		left = left - 1
		local delay = FrameTime() * TINY_TREE_LAUNCH_DELAY_FRAMES
		Timers:CreateTimer(delay, function()
			if not IsValid(self) or not IsValidAlive(parent) then
				return
			end
			self:_LaunchTreeChannelProjectile(parent, target_pos, speed)
		end)
		return true
	end
	Throw(nil)
	self._tree_channel_timer = Timers:CreateTimer(interval, function()
		if Throw(nil) then
			return interval
		end
		if IsValid(self) then
			self._tree_channel_timer = nil
		end
		return nil
	end)
end
function sl_modifier_rune_tiny.prototype._LaunchTreeChannelProjectile(self, parent, target_pos, speed)
	local start_pos = self:_GetTreeThrowStartPos(parent)
	local distance = SLVector:Distance2D(start_pos, target_pos)
	if distance <= 0 then
		return
	end
	local direction = SLVector:Normalized2D(target_pos - start_pos)
	SLModules.CustomProjectile:CreateLinearProjectileForListener(self._projectile_listener_id, {
		EffectName = TINY_TREE_PROJECTILE_EFFECT,
		Source = parent,
		vSpawnOrigin = start_pos,
		vVelocity = direction * speed,
		fDistance = distance,
		fStartRadius = TINY_TREE_CHANNEL_COLLISION_RADIUS,
		fEndRadius = TINY_TREE_CHANNEL_COLLISION_RADIUS,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_NONE,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	}, { [TINY_TREE_MODE_KEY] = 3 })
end
function sl_modifier_rune_tiny.prototype._StopTreeChannelVolley(self)
	if not self._tree_channel_timer then
		return
	end
	Timers:RemoveTimer(self._tree_channel_timer)
	self._tree_channel_timer = nil
end
function sl_modifier_rune_tiny.prototype._OnTreeProjectileHit(self, location, extra_data)
	if not IsValid(self) then
		return
	end
	local mode = extra_data[TINY_TREE_MODE_KEY]
	if mode == 3 then
		self:_CreateTempTreeAt(location, true)
		return
	end
	self:_CreateTempTreeAt(location, false)
	if mode == 2 then
		return true
	end
end
function sl_modifier_rune_tiny.prototype._GetAbilityValue(self, ability, key, fallback)
	local value = ability:GetSpecialValueFor(key)
	local ____temp_1
	if value > 0 then
		____temp_1 = value
	else
		____temp_1 = fallback
	end
	return ____temp_1
end
function sl_modifier_rune_tiny.prototype._CreateTempTreeAt(self, land_pos, find_spot)
	local duration = self:_GetRuneSpecialValue("temporary_tree_duration")
	if duration <= 0 then
		return
	end
	local spot
	if find_spot then
		local found = self:_FindTreeSpot(land_pos)
		if not found then
			return
		end
		spot = found
	else
		spot = GetGroundPosition(land_pos, nil)
	end
	CreateTempTree(spot, duration)
	self:_PushUnitsOutOfTree(spot)
end
function sl_modifier_rune_tiny.prototype._FindTreeSpot(self, land_pos)
	local ground_pos = GetGroundPosition(land_pos, nil)
	if self:_IsTreeSpotValid(ground_pos) then
		return ground_pos
	end
	do
		local radius = TINY_TREE_SPOT_STEP
		while radius <= TINY_TREE_SPOT_MAX_RADIUS do
			local ring_pos = ground_pos + Vector(radius, 0, 0)
			do
				local angle = 0
				while angle < 360 do
					local candidate = GetGroundPosition(SLVector:RotateByYaw(ground_pos, angle, ring_pos), nil)
					if self:_IsTreeSpotValid(candidate) then
						return candidate
					end
					angle = angle + TINY_TREE_SPOT_ANGLE_STEP
				end
			end
			radius = radius + TINY_TREE_SPOT_STEP
		end
	end
	return nil
end
function sl_modifier_rune_tiny.prototype._IsTreeSpotValid(self, pos)
	if not GridNav:IsTraversable(pos) or GridNav:IsBlocked(pos) then
		return false
	end
	return not GridNav:IsNearbyTree(pos, TINY_TREE_SPOT_TREE_CLEARANCE, true)
end
function sl_modifier_rune_tiny.prototype._PushUnitsOutOfTree(self, tree_pos)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local units = FindUnitsInRadius(
		parent:GetTeamNumber(),
		tree_pos,
		nil,
		TINY_TREE_BLOCK_CHECK_RADIUS,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(unit) then
				goto __continue69
			end
			FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), false)
		end
		::__continue69::
	end
end
function sl_modifier_rune_tiny.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:_StopTreeChannelVolley()
	if self._projectile_listener_id then
		SLModules.CustomProjectile:UnregisterListener(self._projectile_listener_id)
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		local ent = parent:GetEntityIndex()
		LocalEvents:Remove("ability_fully_cast", self, ent)
		LocalEvents:Remove("ability_end_channel", self, ent)
		LocalEvents:Remove("apply_damage", self, ent)
	end
end
sl_modifier_rune_tiny = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_tiny", nil, getfenv()) },
	sl_modifier_rune_tiny
)
____exports.sl_modifier_rune_tiny = sl_modifier_rune_tiny
return ____exports