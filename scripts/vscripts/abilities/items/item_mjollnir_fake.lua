--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_mjollnir_fake.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_mjollnir_fake.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:20",
		["14"] = "2:37",
		["15"] = "3:1",
		["16"] = "3:10",
		["19"] = "9:1",
		["20"] = "10:14",
		["21"] = "9:1",
		["22"] = "10:33",
		["23"] = "11:5",
		["24"] = "12:9",
		["25"] = "11:5",
		["26"] = "10:14",
		["27"] = "9:2",
		["28"] = "9:2",
		["29"] = "9:2",
		["31"] = "9:2",
		["32"] = "10:14",
		["34"] = "10:14",
		["35"] = "16:1",
		["36"] = "17:14",
		["37"] = "16:1",
		["38"] = "17:45",
		["39"] = "26:5",
		["40"] = "27:9",
		["41"] = "26:5",
		["42"] = "36:5",
		["43"] = "37:9",
		["44"] = "36:5",
		["45"] = "40:5",
		["46"] = "41:9",
		["47"] = "40:5",
		["48"] = "44:5",
		["49"] = "45:14",
		["52"] = "44:5",
		["53"] = "76:5",
		["54"] = "77:46",
		["55"] = "77:17",
		["56"] = "77:27",
		["57"] = "77:35",
		["58"] = "78:14",
		["61"] = "80:14",
		["64"] = "87:15",
		["65"] = "89:13",
		["68"] = "90:13",
		["69"] = "91:13",
		["70"] = "92:20",
		["71"] = "93:13",
		["73"] = "76:5",
		["74"] = "97:5",
		["75"] = "101:13",
		["76"] = "101:24",
		["77"] = "101:13",
		["78"] = "101:13",
		["79"] = "101:13",
		["80"] = "101:114",
		["81"] = "101:13",
		["84"] = "106:15",
		["85"] = "107:15",
		["86"] = "107:46",
		["87"] = "107:69",
		["88"] = "107:26",
		["89"] = "108:13",
		["92"] = "110:15",
		["93"] = "111:14",
		["96"] = "113:15",
		["97"] = "114:9",
		["98"] = "114:36",
		["99"] = "114:41",
		["100"] = "114:44",
		["101"] = "114:9",
		["102"] = "114:85",
		["103"] = "114:102",
		["104"] = "114:9",
		["105"] = "115:9",
		["106"] = "115:36",
		["107"] = "115:41",
		["108"] = "115:44",
		["109"] = "115:9",
		["110"] = "115:85",
		["111"] = "115:102",
		["112"] = "115:9",
		["113"] = "116:9",
		["114"] = "118:15",
		["115"] = "119:9",
		["116"] = "120:13",
		["117"] = "121:13",
		["118"] = "122:13",
		["119"] = "123:13",
		["120"] = "124:13",
		["121"] = "119:21",
		["122"] = "97:5",
		["123"] = "190:5",
		["124"] = "194:13",
		["127"] = "197:13",
		["128"] = "197:24",
		["129"] = "197:13",
		["130"] = "197:13",
		["131"] = "197:13",
		["132"] = "197:114",
		["133"] = "197:13",
		["136"] = "202:15",
		["137"] = "203:14",
		["140"] = "204:9",
		["141"] = "190:5",
		["142"] = "207:5",
		["143"] = "208:15",
		["144"] = "209:9",
		["145"] = "209:45",
		["146"] = "209:49",
		["147"] = "209:49",
		["148"] = "209:26",
		["149"] = "211:15",
		["150"] = "212:15",
		["151"] = "213:15",
		["152"] = "214:13",
		["153"] = "215:9",
		["154"] = "217:9",
		["155"] = "218:15",
		["156"] = "219:9",
		["157"] = "220:15",
		["158"] = "221:13",
		["159"] = "223:9",
		["160"] = "223:28",
		["161"] = "223:41",
		["162"] = "224:18",
		["165"] = "225:18",
		["168"] = "226:13",
		["169"] = "227:17",
		["172"] = "229:19",
		["173"] = "230:17",
		["174"] = "231:17",
		["175"] = "232:17",
		["176"] = "233:17",
		["177"] = "229:35",
		["178"] = "229:35",
		["179"] = "229:35",
		["180"] = "229:35",
		["181"] = "238:17",
		["182"] = "229:35",
		["183"] = "240:17",
		["184"] = "241:13",
		["186"] = "242:21",
		["187"] = "242:49",
		["189"] = "243:17",
		["194"] = "246:18",
		["197"] = "247:13",
		["198"] = "249:13",
		["199"] = "250:13",
		["200"] = "251:13",
		["201"] = "252:13",
		["202"] = "223:41",
		["203"] = "223:9",
		["204"] = "207:5",
		["205"] = "256:5",
		["206"] = "258:15",
		["207"] = "259:9",
		["208"] = "259:36",
		["209"] = "259:41",
		["210"] = "259:44",
		["211"] = "259:9",
		["212"] = "259:83",
		["213"] = "259:100",
		["214"] = "259:9",
		["215"] = "260:9",
		["216"] = "260:36",
		["217"] = "260:41",
		["218"] = "260:44",
		["219"] = "260:9",
		["220"] = "260:81",
		["221"] = "260:98",
		["222"] = "260:9",
		["223"] = "261:9",
		["224"] = "263:15",
		["225"] = "264:9",
		["226"] = "265:13",
		["227"] = "266:13",
		["228"] = "267:13",
		["229"] = "268:13",
		["230"] = "269:13",
		["231"] = "264:21",
		["232"] = "256:5",
		["233"] = "17:14",
		["234"] = "16:2",
		["235"] = "16:2",
		["236"] = "16:19",
		["237"] = "16:2",
		["239"] = "16:2",
		["240"] = "17:14",
		["242"] = "17:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 雷神之锤（伪）
-- <h1>被动：静电护盾</h1>自身在受到攻击时，若攻击者处于自身%shock_range%范围内，则有%shock_chance%%%的概率对攻击者释放闪电冲击，造成%shock_damage%点魔法伤害。\n\n<h1>被动：连环闪电</h1>攻击有%chain_chance%%%几率释放一道连环闪电，在%chain_radius%范围内%chain_strikes%个目标之间跳跃，每次造成%chain_damage%点魔法伤害。触发闪电时无视闪避。
____exports.item_mjollnir_fake = __TS__Class()
local item_mjollnir_fake = ____exports.item_mjollnir_fake
item_mjollnir_fake.name = "item_mjollnir_fake"
__TS__ClassExtends(item_mjollnir_fake, SLItemBase)
function item_mjollnir_fake.prototype.GetIntrinsicModifierName(self)
	return ____exports.sl_modifier_item_mjollnir_fake.name
end
item_mjollnir_fake = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_mjollnir_fake)
____exports.item_mjollnir_fake = item_mjollnir_fake
____exports.sl_modifier_item_mjollnir_fake = __TS__Class()
local sl_modifier_item_mjollnir_fake = ____exports.sl_modifier_item_mjollnir_fake
sl_modifier_item_mjollnir_fake.name = "sl_modifier_item_mjollnir_fake"
__TS__ClassExtends(sl_modifier_item_mjollnir_fake, SLModifier_ItemIntrinsic)
function sl_modifier_item_mjollnir_fake.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end
function sl_modifier_item_mjollnir_fake.prototype.GetModifierPreAttack_BonusDamage(self)
	return self:GetAbilitySpecialValueFor("bonus_damage")
end
function sl_modifier_item_mjollnir_fake.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self:GetAbilitySpecialValueFor("bonus_attack_speed")
end
function sl_modifier_item_mjollnir_fake.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
end
function sl_modifier_item_mjollnir_fake.prototype.OnAttackLanded(self, event)
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local target = ____event_0.target
	local record = ____event_0.record
	if not IsServer() then
		return
	end
	if not self:IsLatestSource() then
		return
	end
	local parent = self:GetParent()
	if parent:IsIllusion() then
		return
	end
	if parent == target then
		self:_TryTriggerShock(parent, attacker)
	elseif parent == attacker then
		self:_TryTriggerChain(parent, target)
	end
end
function sl_modifier_item_mjollnir_fake.prototype._TryTriggerShock(self, parent, target)
	if
		UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			parent:GetTeam()
		) ~= UF_SUCCESS
	then
		return
	end
	local shock_range = self:GetAbilitySpecialValueFor("shock_range")
	local distance = SLVector:Distance2D(parent:GetAbsOrigin(), target:GetAbsOrigin())
	if distance > shock_range then
		return
	end
	local shock_chance = self:GetAbilitySpecialValueFor("shock_chance")
	if not RollPseudoRandomPercentage(shock_chance, 1001, parent) then
		return
	end
	local pid = self:CreateParticle(ITEM_PARTICLES.item_mjollnir_fake_shock, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:SetParticleControlEnt(pid, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parent:GetAbsOrigin())
	self:SetParticleControlEnt(pid, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin())
	self:ReleaseParticleIndex(pid)
	local damage = self:GetAbilitySpecialValueFor("shock_damage")
	ApplyDamage({
		attacker = parent,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		victim = target,
		ability = self:GetAbility(),
	})
end
function sl_modifier_item_mjollnir_fake.prototype._TryTriggerChain(self, parent, target)
	if Timers:IsValid(self._cd_timer) then
		return
	end
	if
		UnitFilter(
			target,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			parent:GetTeam()
		) ~= UF_SUCCESS
	then
		return
	end
	local chain_chance = self:GetAbilitySpecialValueFor("chain_chance")
	if not RollPseudoRandomPercentage(chain_chance, 1002, parent) then
		return
	end
	self:_ShootChain(parent, target)
end
function sl_modifier_item_mjollnir_fake.prototype._ShootChain(self, parent, target)
	local cd = self:GetAbilitySpecialValueFor("chain_cooldown")
	self._cd_timer = Timers:CreateTimer(cd, function() end)
	local chain_delay = self:GetAbilitySpecialValueFor("chain_delay")
	local chain_radius = self:GetAbilitySpecialValueFor("chain_radius")
	local chain_strikes = self:GetAbilitySpecialValueFor("chain_strikes")
	local left_jump_times = chain_strikes
	self:_ShootLightningChain(parent, target)
	target:EmitSound("item_mjollnir_fake.Chain_Lightning")
	local hitted_targets = {}
	hitted_targets[target] = true
	local parent_team = parent:GetTeam()
	local current_unit = target
	Timers:CreateTimer(chain_delay, function()
		if not IsValid(self) then
			return
		end
		if not IsValid(current_unit) then
			return
		end
		left_jump_times = left_jump_times - 1
		if left_jump_times <= 0 then
			return
		end
		local valid_targets = FindUnitsInRadius(
			parent_team,
			current_unit:GetAbsOrigin(),
			nil,
			chain_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)
		local next_target = nil
		for ____, target in ipairs(valid_targets) do
			do
				if hitted_targets[target] then
					goto __continue28
				end
				next_target = target
				break
			end
			::__continue28::
		end
		if not IsValidAlive(next_target) then
			return
		end
		hitted_targets[next_target] = true
		next_target:EmitSound("item_mjollnir_fake.Chain_Lightning.Jump")
		self:_ShootLightningChain(current_unit, next_target)
		current_unit = next_target
		return chain_delay
	end)
end
function sl_modifier_item_mjollnir_fake.prototype._ShootLightningChain(self, from, to)
	local pid = self:CreateParticle(ITEM_PARTICLES.item_mjollnir_fake_chain, PATTACH_ABSORIGIN_FOLLOW, from)
	self:SetParticleControlEnt(pid, 0, from, PATTACH_POINT_FOLLOW, "attach_hitloc", from:GetAbsOrigin())
	self:SetParticleControlEnt(pid, 1, to, PATTACH_POINT_FOLLOW, "attach_hitloc", to:GetAbsOrigin())
	self:ReleaseParticleIndex(pid)
	local chain_damage = self:GetAbilitySpecialValueFor("chain_damage")
	ApplyDamage({
		attacker = self:GetParent(),
		damage = chain_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		victim = to,
		ability = self:GetAbility(),
	})
end
sl_modifier_item_mjollnir_fake = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_mjollnir_fake", nil, getfenv()) },
	sl_modifier_item_mjollnir_fake
)
____exports.sl_modifier_item_mjollnir_fake = sl_modifier_item_mjollnir_fake
return ____exports