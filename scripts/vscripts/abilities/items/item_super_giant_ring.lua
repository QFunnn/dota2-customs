--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_super_giant_ring.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_super_giant_ring.lua",
	{
		["10"] = "36:7",
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "1:52",
		["14"] = "3:1",
		["15"] = "3:10",
		["16"] = "3:27",
		["17"] = "4:1",
		["18"] = "4:10",
		["21"] = "10:1",
		["22"] = "11:14",
		["23"] = "10:1",
		["24"] = "11:36",
		["26"] = "11:44",
		["27"] = "20:5",
		["28"] = "10:1",
		["29"] = "12:5",
		["30"] = "13:9",
		["31"] = "12:5",
		["32"] = "16:5",
		["33"] = "17:9",
		["34"] = "16:5",
		["35"] = "22:5",
		["36"] = "23:9",
		["37"] = "24:9",
		["38"] = "22:5",
		["39"] = "27:5",
		["40"] = "28:13",
		["41"] = "29:13",
		["43"] = "31:9",
		["44"] = "27:5",
		["45"] = "11:14",
		["46"] = "10:2",
		["47"] = "10:2",
		["48"] = "10:2",
		["50"] = "10:2",
		["51"] = "11:14",
		["53"] = "11:14",
		["54"] = "36:7",
		["55"] = "35:1",
		["56"] = "36:41",
		["57"] = "37:5",
		["58"] = "38:9",
		["59"] = "37:5",
		["60"] = "44:5",
		["61"] = "45:9",
		["62"] = "46:9",
		["63"] = "47:9",
		["64"] = "49:9",
		["65"] = "44:5",
		["66"] = "54:5",
		["67"] = "55:15",
		["68"] = "56:15",
		["69"] = "57:9",
		["70"] = "54:5",
		["71"] = "60:5",
		["72"] = "61:9",
		["73"] = "60:5",
		["74"] = "64:5",
		["75"] = "65:9",
		["76"] = "64:5",
		["77"] = "68:5",
		["78"] = "69:15",
		["79"] = "70:13",
		["80"] = "71:13",
		["81"] = "72:13",
		["83"] = "74:9",
		["84"] = "68:5",
		["85"] = "77:5",
		["86"] = "78:9",
		["87"] = "77:5",
		["88"] = "81:5",
		["89"] = "82:9",
		["90"] = "81:5",
		["91"] = "85:5",
		["92"] = "86:9",
		["93"] = "85:5",
		["94"] = "89:5",
		["95"] = "90:9",
		["96"] = "89:5",
		["97"] = "93:5",
		["98"] = "94:9",
		["99"] = "93:5",
		["100"] = "97:5",
		["101"] = "98:9",
		["102"] = "97:5",
		["103"] = "101:5",
		["104"] = "102:9",
		["105"] = "101:5",
		["106"] = "105:5",
		["107"] = "106:9",
		["108"] = "105:5",
		["109"] = "109:5",
		["110"] = "110:14",
		["111"] = "110:37",
		["113"] = "112:14",
		["114"] = "112:60",
		["116"] = "114:15",
		["117"] = "115:13",
		["118"] = "115:34",
		["120"] = "116:15",
		["121"] = "117:13",
		["122"] = "117:37",
		["124"] = "118:15",
		["125"] = "119:13",
		["126"] = "119:39",
		["128"] = "120:9",
		["129"] = "109:5",
		["130"] = "36:7",
		["131"] = "35:2",
		["132"] = "35:2",
		["133"] = "35:19",
		["134"] = "35:2",
		["136"] = "35:2",
		["137"] = "36:7",
		["140"] = "128:7",
		["141"] = "127:1",
		["142"] = "128:59",
		["144"] = "128:67",
		["145"] = "165:5",
		["146"] = "166:5",
		["147"] = "219:5",
		["148"] = "127:1",
		["149"] = "129:5",
		["150"] = "130:9",
		["151"] = "129:5",
		["152"] = "133:5",
		["153"] = "134:9",
		["154"] = "133:5",
		["155"] = "137:5",
		["156"] = "138:9",
		["157"] = "137:5",
		["158"] = "141:5",
		["159"] = "142:9",
		["160"] = "141:5",
		["161"] = "145:5",
		["162"] = "146:9",
		["163"] = "145:5",
		["164"] = "153:5",
		["165"] = "154:14",
		["168"] = "155:9",
		["169"] = "156:9",
		["170"] = "157:9",
		["171"] = "158:9",
		["172"] = "159:9",
		["173"] = "153:5",
		["174"] = "168:5",
		["175"] = "169:14",
		["178"] = "171:15",
		["179"] = "173:15",
		["180"] = "174:15",
		["181"] = "175:9",
		["182"] = "177:15",
		["183"] = "178:15",
		["184"] = "179:13",
		["185"] = "180:13",
		["188"] = "183:9",
		["189"] = "184:15",
		["190"] = "186:15",
		["191"] = "188:13",
		["192"] = "189:13",
		["193"] = "190:19",
		["194"] = "191:19",
		["195"] = "192:13",
		["197"] = "195:13",
		["198"] = "197:17",
		["199"] = "198:17",
		["200"] = "198:38",
		["201"] = "198:87",
		["202"] = "199:21",
		["203"] = "200:21",
		["204"] = "201:21",
		["205"] = "202:21",
		["206"] = "198:87",
		["207"] = "198:17",
		["209"] = "206:13",
		["210"] = "208:13",
		["212"] = "210:13",
		["214"] = "168:5",
		["215"] = "214:5",
		["216"] = "215:9",
		["217"] = "214:5",
		["218"] = "221:5",
		["219"] = "222:15",
		["220"] = "223:15",
		["221"] = "224:14",
		["222"] = "225:13",
		["223"] = "226:17",
		["224"] = "225:34",
		["225"] = "228:17",
		["226"] = "229:17",
		["227"] = "225:34",
		["228"] = "231:13",
		["229"] = "231:40",
		["230"] = "231:60",
		["231"] = "231:63",
		["232"] = "231:13",
		["233"] = "231:108",
		["234"] = "231:13",
		["235"] = "232:13",
		["236"] = "232:37",
		["237"] = "232:57",
		["238"] = "232:60",
		["239"] = "232:13",
		["241"] = "235:13",
		["242"] = "236:13",
		["243"] = "237:13",
		["244"] = "237:37",
		["245"] = "237:57",
		["246"] = "237:60",
		["247"] = "237:13",
		["249"] = "240:13",
		["250"] = "241:13",
		["251"] = "242:19",
		["252"] = "243:13",
		["253"] = "243:37",
		["254"] = "243:57",
		["255"] = "243:60",
		["256"] = "243:13",
		["258"] = "221:5",
		["259"] = "247:5",
		["260"] = "248:13",
		["261"] = "249:13",
		["262"] = "250:13",
		["264"] = "247:5",
		["265"] = "128:7",
		["266"] = "127:2",
		["267"] = "127:2",
		["268"] = "127:19",
		["269"] = "127:2",
		["271"] = "127:2",
		["272"] = "128:7",
		["275"] = "259:7",
		["276"] = "258:1",
		["277"] = "259:55",
		["278"] = "260:5",
		["279"] = "261:9",
		["280"] = "260:5",
		["281"] = "264:5",
		["282"] = "265:9",
		["283"] = "264:5",
		["284"] = "268:5",
		["285"] = "269:9",
		["286"] = "268:5",
		["287"] = "272:5",
		["288"] = "273:9",
		["289"] = "272:5",
		["290"] = "276:5",
		["291"] = "277:9",
		["292"] = "276:5",
		["293"] = "280:5",
		["294"] = "281:9",
		["295"] = "280:5",
		["296"] = "284:5",
		["297"] = "285:14",
		["300"] = "286:15",
		["301"] = "287:15",
		["302"] = "288:15",
		["303"] = "289:13",
		["304"] = "288:21",
		["305"] = "291:13",
		["306"] = "292:13",
		["307"] = "288:21",
		["308"] = "294:9",
		["309"] = "294:33",
		["310"] = "294:38",
		["311"] = "294:41",
		["312"] = "294:9",
		["313"] = "295:9",
		["314"] = "295:33",
		["315"] = "295:38",
		["316"] = "295:41",
		["317"] = "295:9",
		["318"] = "296:9",
		["319"] = "296:33",
		["320"] = "296:38",
		["321"] = "296:41",
		["322"] = "296:9",
		["323"] = "297:9",
		["324"] = "297:36",
		["325"] = "297:41",
		["326"] = "297:44",
		["327"] = "297:9",
		["328"] = "297:89",
		["329"] = "297:9",
		["330"] = "298:9",
		["331"] = "298:26",
		["332"] = "298:31",
		["333"] = "298:38",
		["334"] = "298:45",
		["335"] = "298:48",
		["336"] = "298:55",
		["337"] = "298:9",
		["338"] = "284:5",
		["339"] = "301:5",
		["340"] = "302:14",
		["343"] = "303:38",
		["344"] = "303:17",
		["345"] = "303:27",
		["346"] = "304:14",
		["349"] = "305:15",
		["350"] = "306:15",
		["351"] = "307:13",
		["352"] = "309:19",
		["353"] = "310:19",
		["354"] = "311:19",
		["355"] = "312:19",
		["356"] = "313:19",
		["357"] = "314:19",
		["358"] = "315:19",
		["359"] = "317:34",
		["360"] = "317:34",
		["361"] = "317:56",
		["362"] = "317:56",
		["363"] = "317:56",
		["365"] = "317:19",
		["366"] = "318:32",
		["368"] = "318:32",
		["370"] = "318:19",
		["371"] = "319:19",
		["372"] = "320:13",
		["373"] = "321:14",
		["374"] = "322:19",
		["375"] = "324:19",
		["376"] = "325:13",
		["377"] = "325:40",
		["378"] = "325:54",
		["379"] = "325:57",
		["380"] = "325:13",
		["381"] = "325:98",
		["382"] = "325:13",
		["383"] = "326:13",
		["384"] = "326:40",
		["385"] = "326:54",
		["386"] = "326:57",
		["387"] = "326:13",
		["388"] = "326:102",
		["389"] = "326:13",
		["390"] = "328:13",
		["391"] = "330:13",
		["392"] = "330:34",
		["393"] = "330:92",
		["394"] = "331:17",
		["395"] = "332:17",
		["396"] = "333:17",
		["397"] = "334:17",
		["398"] = "330:92",
		["399"] = "330:13",
		["400"] = "337:43",
		["401"] = "337:43",
		["406"] = "337:19",
		["407"] = "338:13",
		["408"] = "339:17",
		["409"] = "340:17",
		["410"] = "341:17",
		["411"] = "342:17",
		["412"] = "343:17",
		["413"] = "338:25",
		["414"] = "346:13",
		["416"] = "301:5",
		["417"] = "259:7",
		["418"] = "258:2",
		["419"] = "258:2",
		["420"] = "258:19",
		["421"] = "258:2",
		["423"] = "258:2",
		["424"] = "259:7",
		["427"] = "355:7",
		["428"] = "354:1",
		["429"] = "355:64",
		["430"] = "356:5",
		["431"] = "357:9",
		["432"] = "356:5",
		["433"] = "360:5",
		["434"] = "361:9",
		["435"] = "360:5",
		["436"] = "364:5",
		["437"] = "365:9",
		["438"] = "364:5",
		["439"] = "368:5",
		["440"] = "369:9",
		["441"] = "368:5",
		["442"] = "372:5",
		["443"] = "373:9",
		["444"] = "372:5",
		["445"] = "376:5",
		["446"] = "377:9",
		["447"] = "376:5",
		["448"] = "380:5",
		["449"] = "381:9",
		["450"] = "380:5",
		["451"] = "355:7",
		["452"] = "354:2",
		["453"] = "354:2",
		["454"] = "354:19",
		["455"] = "354:2",
		["457"] = "354:2",
		["458"] = "355:7",
	}
)
local ____exports = {}
local sl_modifier_item_super_giant_ring, sl_modifier_item_super_giant_ring_aura_check_debuff, sl_modifier_item_super_giant_ring_strike_debuff, sl_modifier_item_super_giant_ring_strike_cooldown_debuff
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 巨人刚戒
-- <h1>被动：巨人行猎</h1>当一个敌方英雄在你的行猎范围内停留时间达到%stay_time%秒时，你会盯上他。%strike_debuff_dur%秒内，你的下一次攻击会对目标造成一次%strike_dmg%+%strike_dmg_hp_pct%%%装备者最大生命值的魔法伤害，并将这次伤害（原始伤害）的%dmg_to_hp_pct%%%转化为该装备的永久生命值，可无限叠加。<br><br>当目标脱离你的行猎范围时，你有%stay_stick_time%秒的时间重新靠近他。<br><br>对同一个目标在%strike_cooldown%秒内只能触发一次。<br><br>行猎范围：%radius%\n\n<h1>被动：巨人身躯</h1>你的最大生命值越高，体型越大。每%scale_hp_per_stack%生命值提升%scale_bonus%%%体型，最大提升%scald_bonus_max%%%
____exports.item_super_giant_ring = __TS__Class()
local item_super_giant_ring = ____exports.item_super_giant_ring
item_super_giant_ring.name = "item_super_giant_ring"
__TS__ClassExtends(item_super_giant_ring, SLItemBase)
function item_super_giant_ring.prototype.____constructor(self, ...)
	SLItemBase.prototype.____constructor(self, ...)
	self._manual_toggle_state = false
end
function item_super_giant_ring.prototype.GetIntrinsicModifierName(self)
	return sl_modifier_item_super_giant_ring.name
end
function item_super_giant_ring.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function item_super_giant_ring.prototype.OnSpellStart(self)
	self._manual_toggle_state = not self._manual_toggle_state
	self:SetSecondaryCharges(self._manual_toggle_state and 1 or 0)
end
function item_super_giant_ring.prototype.GetAbilityTextureName(self)
	if self:GetSecondaryCharges() == 1 then
		return "item_super_giant_ring_magic"
	end
	return "item_super_giant_ring"
end
item_super_giant_ring = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_super_giant_ring)
____exports.item_super_giant_ring = item_super_giant_ring
sl_modifier_item_super_giant_ring = __TS__Class()
sl_modifier_item_super_giant_ring.name = "sl_modifier_item_super_giant_ring"
__TS__ClassExtends(sl_modifier_item_super_giant_ring, SLModifier_ItemIntrinsic)
function sl_modifier_item_super_giant_ring.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_MODEL_SCALE }
end
function sl_modifier_item_super_giant_ring.prototype.OnCreated(self, params)
	self._scale_hp_per_stack = self:GetAbilitySpecialValueFor("scale_hp_per_stack")
	self._scale_bonus = self:GetAbilitySpecialValueFor("scale_bonus")
	self._scald_bonus_max = self:GetAbilitySpecialValueFor("scald_bonus_max")
	self:StartIntervalThink(1)
end
function sl_modifier_item_super_giant_ring.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local health = parent:GetMaxHealth()
	self._scale = math.min(health / self._scale_hp_per_stack * self._scale_bonus, self._scald_bonus_max)
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierModelScale(self)
	return self._scale
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierBonusStats_Strength(self)
	return self:GetAbilitySpecialValueFor("bonus_strength")
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierHealthBonus(self)
	local ability = self:GetAbility()
	local base = ability:GetSpecialValueFor("bonus_hp")
	if ability:IsItem() then
		base = base + ability:GetCurrentCharges()
	end
	return base
end
function sl_modifier_item_super_giant_ring.prototype.IsAura(self)
	return true
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraRadius(self)
	return self:GetAbilitySpecialValueFor("radius")
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraDuration(self)
	return self:GetAbilitySpecialValueFor("stay_stick_time")
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_NO_INVIS
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO
end
function sl_modifier_item_super_giant_ring.prototype.GetModifierAura(self)
	return sl_modifier_item_super_giant_ring_aura_check_debuff.name
end
function sl_modifier_item_super_giant_ring.prototype.IsAuraActiveOnDeath(self)
	return false
end
function sl_modifier_item_super_giant_ring.prototype.GetAuraEntityReject(self, entity)
	if not self:IsLatestSource() then
		return true
	end
	if not IsValidAlive(entity) or not entity:IsRealHero() then
		return true
	end
	local caster = self:GetCaster()
	if caster:IsIllusion() then
		return true
	end
	local strike_debuff = entity:FindSLModifier(sl_modifier_item_super_giant_ring_strike_debuff, caster)
	if IsValid(strike_debuff) then
		return true
	end
	local cooldown_debuff = entity:FindSLModifier(sl_modifier_item_super_giant_ring_strike_cooldown_debuff, caster)
	if IsValid(cooldown_debuff) then
		return true
	end
	return false
end
sl_modifier_item_super_giant_ring = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring", nil, getfenv()) },
	sl_modifier_item_super_giant_ring
)
--- 巨人刚戒检测光环debuff
sl_modifier_item_super_giant_ring_aura_check_debuff = __TS__Class()
sl_modifier_item_super_giant_ring_aura_check_debuff.name = "sl_modifier_item_super_giant_ring_aura_check_debuff"
__TS__ClassExtends(sl_modifier_item_super_giant_ring_aura_check_debuff, SLModifierBase_Debuff)
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.____constructor(self, ...)
	SLModifierBase_Debuff.prototype.____constructor(self, ...)
	self._progress_sound_steps = 4
	self._progress_sound_steps_record = {}
	self._pid_progress = 0
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.GetTexture(self)
	return self:GetCaster():GetName()
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._interval = 0.33
	self._time_count = 0
	self._last_remain_time = self:GetRemainingTime()
	self._strike_debuff_need = self:GetAbilitySpecialValueFor("stay_time")
	self:StartIntervalThink(self._interval)
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.OnIntervalThink(self)
	if not IsValid(self:GetAbility()) then
		return
	end
	local parent = self:GetParent()
	local remain_time = self:GetRemainingTime()
	local last_remain_time = self._last_remain_time
	self._last_remain_time = remain_time
	local strike_debuff_need = self._strike_debuff_need
	local progress_before = 100 - (strike_debuff_need - self._time_count) / strike_debuff_need * 100
	if remain_time < last_remain_time then
		self:_UpdateProgressParticle(progress_before, true)
		return
	end
	self._time_count = self._time_count + self._interval
	local progress_after = 100 - (strike_debuff_need - self._time_count) / strike_debuff_need * 100
	local sound_step = math.floor(self._progress_sound_steps * progress_after / 100)
	if sound_step > 0 and not self._progress_sound_steps_record[sound_step] then
		self._progress_sound_steps_record[sound_step] = true
		local volume = 1.25 + sound_step * 1.75
		local pitch = sound_step >= self._progress_sound_steps and 3 or 1
		parent:EmitSoundParams("item_super_giant_ring.step", pitch, volume, 0)
	end
	if self._time_count >= strike_debuff_need then
		if IsValidAlive(parent) then
			parent:AddSLModifier(sl_modifier_item_super_giant_ring_strike_debuff, {
				ability = self:GetAbility(),
				caster = self:GetCaster(),
				duration = self:GetAbilitySpecialValueFor("strike_debuff_dur"),
				no_error = true,
			})
		end
		self:StartIntervalThink(-1)
		self:Destroy()
	else
		self:_UpdateProgressParticle(progress_after, false)
	end
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype.OnDestroy(self)
	self:_RemoveProgressParticle()
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype._UpdateProgressParticle(self, progress, out)
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not self._progress_pid then
		self._progress_pid = self:CreateParticleForPlayer(
			ITEM_PARTICLES.item_hunter_marklink,
			PATTACH_ABSORIGIN_FOLLOW,
			caster,
			caster:GetFixedPlayerOwner()
		)
		self:SetParticleControlEnt(self._progress_pid, 7, parent, PATTACH_ABSORIGIN_FOLLOW, nil)
		self:SetParticleControl(self._progress_pid, 4, Vector(0, 0, 0))
	end
	if self._pid_progress ~= progress then
		self._pid_progress = progress
		self:SetParticleControl(self._progress_pid, 2, Vector(self._pid_progress, 0, 0))
	end
	if self._is_out == nil or out ~= nil and out ~= self._is_out then
		self._is_out = out
		local set_out_value = out and 1 or 0
		self:SetParticleControl(self._progress_pid, 3, Vector(set_out_value, 0, 0))
	end
end
function sl_modifier_item_super_giant_ring_aura_check_debuff.prototype._RemoveProgressParticle(self)
	if self._progress_pid then
		self:DestroyParticle(self._progress_pid, true)
		self._progress_pid = nil
	end
end
sl_modifier_item_super_giant_ring_aura_check_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring", nil, getfenv()) },
	sl_modifier_item_super_giant_ring_aura_check_debuff
)
--- 巨人刚戒额外伤害debuff
sl_modifier_item_super_giant_ring_strike_debuff = __TS__Class()
sl_modifier_item_super_giant_ring_strike_debuff.name = "sl_modifier_item_super_giant_ring_strike_debuff"
__TS__ClassExtends(sl_modifier_item_super_giant_ring_strike_debuff, SLModifierBase_Debuff)
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.GetTexture(self)
	return self:GetCaster():GetName()
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local pid = self:CreateParticleForPlayer(
		ITEM_PARTICLES.item_hunter_marklink,
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster:GetFixedPlayerOwner()
	)
	self:SetParticleControl(pid, 2, Vector(100, 0, 0))
	self:SetParticleControl(pid, 3, Vector(1, 0, 0))
	self:SetParticleControl(pid, 4, Vector(1, 0, 0))
	self:SetParticleControlEnt(pid, 7, parent, PATTACH_ABSORIGIN_FOLLOW, nil)
	self:AddParticle(pid, false, false, 1, false, false)
end
function sl_modifier_item_super_giant_ring_strike_debuff.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	if not IsValidAlive(attacker) or not IsValidAlive(target) then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if target == parent and attacker == caster then
		local strike_dmg = self:GetAbilitySpecialValueFor("strike_dmg")
		local strike_dmg_hp_pct = self:GetAbilitySpecialValueFor("strike_dmg_hp_pct")
		local caster_hp_max = caster:GetMaxHealth()
		local total_dmg = strike_dmg + caster_hp_max * strike_dmg_hp_pct * 0.01
		local item = self:GetAbility()
		local dmg_to_hp_pct = self:GetAbilitySpecialValueFor("dmg_to_hp_pct")
		local bonus_hp = math.floor(total_dmg * dmg_to_hp_pct * 0.01)
		local ____GlobalAttrManager_3 = GlobalAttrManager
		local ____GlobalAttrManager_Get_4 = GlobalAttrManager.Get
		local ____item_GetCaster_result_GetPlayerOwnerID_result_1 = item:GetCaster()
		if ____item_GetCaster_result_GetPlayerOwnerID_result_1 ~= nil then
			____item_GetCaster_result_GetPlayerOwnerID_result_1 =
				____item_GetCaster_result_GetPlayerOwnerID_result_1:GetPlayerOwnerID()
		end
		local attr_manager =
			____GlobalAttrManager_Get_4(____GlobalAttrManager_3, ____item_GetCaster_result_GetPlayerOwnerID_result_1)
		local ____temp_5 = attr_manager and attr_manager:GetAttr("gangpct")
		if ____temp_5 == nil then
			____temp_5 = 0
		end
		local extra_pct = ____temp_5
		local bonus_chargets = bonus_hp * (1 + extra_pct / 100)
		item:SetCurrentCharges(item:GetCurrentCharges() + bonus_chargets)
		caster:CalculateStatBonus(true)
		local particle_path = item:GetSecondaryCharges() == 1 and ITEM_PARTICLES.item_hunter_hit_magic
			or ITEM_PARTICLES.item_hunter_hit
		local hit_particle = self:CreateParticle(particle_path, PATTACH_CUSTOMORIGIN, nil)
		self:SetParticleControlEnt(hit_particle, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc")
		self:SetParticleControlEnt(hit_particle, 1, caster, PATTACH_ABSORIGIN_FOLLOW, nil)
		target:EmitSound("item_super_giant_ring.hit")
		parent:AddSLModifier(sl_modifier_item_super_giant_ring_strike_cooldown_debuff, {
			ability = item,
			caster = caster,
			duration = self:GetAbilitySpecialValueFor("strike_cooldown"),
			no_error = true,
		})
		local ____temp_6
		if item:GetSecondaryCharges() == 1 then
			____temp_6 = DAMAGE_TYPE_MAGICAL
		else
			____temp_6 = DAMAGE_TYPE_PHYSICAL
		end
		local dmg_type = ____temp_6
		ApplyDamage({
			attacker = caster,
			damage = total_dmg,
			damage_type = dmg_type,
			victim = parent,
			ability = item,
		})
		self:Destroy()
	end
end
sl_modifier_item_super_giant_ring_strike_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring", nil, getfenv()) },
	sl_modifier_item_super_giant_ring_strike_debuff
)
--- 巨人刚戒冷却时间debuff
sl_modifier_item_super_giant_ring_strike_cooldown_debuff = __TS__Class()
sl_modifier_item_super_giant_ring_strike_cooldown_debuff.name =
	"sl_modifier_item_super_giant_ring_strike_cooldown_debuff"
__TS__ClassExtends(sl_modifier_item_super_giant_ring_strike_cooldown_debuff, SLModifierBase_Debuff)
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.RemoveOnDeath(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsPermanent(self)
	return true
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_super_giant_ring_strike_cooldown_debuff.prototype.GetTexture(self)
	return self:GetCaster():GetName()
end
sl_modifier_item_super_giant_ring_strike_cooldown_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_super_giant_ring", nil, getfenv()) },
	sl_modifier_item_super_giant_ring_strike_cooldown_debuff
)
return ____exports