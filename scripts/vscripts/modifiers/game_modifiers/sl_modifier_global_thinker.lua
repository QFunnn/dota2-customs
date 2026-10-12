--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_global_thinker.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_global_thinker.lua",
	{
		["10"] = "3:1",
		["11"] = "3:10",
		["12"] = "4:1",
		["13"] = "4:10",
		["14"] = "7:1",
		["15"] = "8:14",
		["16"] = "7:1",
		["17"] = "8:41",
		["18"] = "9:5",
		["19"] = "10:9",
		["20"] = "10:16",
		["21"] = "10:16",
		["22"] = "10:16",
		["23"] = "10:16",
		["24"] = "10:16",
		["25"] = "10:16",
		["26"] = "10:16",
		["27"] = "10:16",
		["28"] = "10:16",
		["29"] = "10:16",
		["30"] = "10:16",
		["31"] = "10:16",
		["32"] = "10:16",
		["33"] = "10:16",
		["34"] = "10:16",
		["35"] = "10:16",
		["36"] = "10:16",
		["38"] = "10:16",
		["39"] = "9:5",
		["40"] = "36:5",
		["41"] = "37:14",
		["44"] = "38:9",
		["45"] = "38:20",
		["46"] = "38:9",
		["48"] = "38:9",
		["49"] = "36:5",
		["50"] = "41:5",
		["51"] = "42:14",
		["54"] = "43:9",
		["55"] = "43:20",
		["56"] = "43:9",
		["58"] = "43:9",
		["59"] = "41:5",
		["60"] = "50:5",
		["61"] = "51:14",
		["64"] = "52:9",
		["65"] = "52:20",
		["66"] = "52:9",
		["68"] = "52:9",
		["69"] = "50:5",
		["70"] = "55:5",
		["71"] = "56:14",
		["74"] = "57:9",
		["75"] = "57:20",
		["76"] = "57:9",
		["78"] = "57:9",
		["79"] = "55:5",
		["80"] = "61:5",
		["81"] = "62:14",
		["84"] = "63:9",
		["85"] = "63:20",
		["86"] = "63:9",
		["88"] = "63:9",
		["89"] = "61:5",
		["90"] = "75:5",
		["91"] = "76:14",
		["94"] = "77:9",
		["95"] = "77:20",
		["96"] = "77:9",
		["98"] = "77:9",
		["99"] = "75:5",
		["100"] = "81:5",
		["101"] = "82:14",
		["104"] = "83:9",
		["105"] = "83:20",
		["106"] = "83:9",
		["108"] = "83:9",
		["109"] = "81:5",
		["110"] = "86:5",
		["111"] = "87:14",
		["114"] = "88:9",
		["115"] = "88:20",
		["116"] = "88:9",
		["118"] = "88:9",
		["119"] = "86:5",
		["120"] = "92:5",
		["121"] = "93:14",
		["124"] = "94:9",
		["125"] = "94:20",
		["126"] = "94:9",
		["128"] = "94:9",
		["129"] = "92:5",
		["130"] = "98:5",
		["131"] = "99:14",
		["134"] = "100:9",
		["135"] = "100:20",
		["136"] = "100:9",
		["138"] = "100:9",
		["139"] = "98:5",
		["140"] = "108:5",
		["141"] = "109:14",
		["144"] = "110:9",
		["145"] = "110:20",
		["146"] = "110:9",
		["148"] = "110:9",
		["149"] = "108:5",
		["150"] = "113:5",
		["151"] = "114:14",
		["154"] = "115:9",
		["155"] = "115:20",
		["156"] = "115:9",
		["158"] = "115:9",
		["159"] = "113:5",
		["160"] = "118:5",
		["161"] = "119:14",
		["164"] = "120:9",
		["165"] = "120:20",
		["166"] = "120:9",
		["168"] = "120:9",
		["169"] = "118:5",
		["170"] = "123:5",
		["171"] = "124:14",
		["174"] = "125:9",
		["175"] = "125:20",
		["176"] = "125:9",
		["178"] = "125:9",
		["179"] = "123:5",
		["180"] = "128:5",
		["181"] = "129:14",
		["184"] = "130:9",
		["185"] = "130:20",
		["186"] = "130:9",
		["188"] = "130:9",
		["189"] = "128:5",
		["190"] = "133:5",
		["191"] = "134:14",
		["194"] = "135:9",
		["195"] = "135:20",
		["196"] = "135:9",
		["198"] = "135:9",
		["199"] = "133:5",
		["200"] = "138:5",
		["201"] = "139:14",
		["204"] = "140:9",
		["205"] = "140:20",
		["206"] = "140:9",
		["208"] = "140:9",
		["209"] = "138:5",
		["210"] = "8:14",
		["211"] = "7:2",
		["212"] = "7:2",
		["213"] = "7:19",
		["214"] = "7:2",
		["216"] = "7:2",
		["217"] = "8:14",
		["219"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_global_thinker = __TS__Class()
local sl_modifier_global_thinker = ____exports.sl_modifier_global_thinker
sl_modifier_global_thinker.name = "sl_modifier_global_thinker"
__TS__ClassExtends(sl_modifier_global_thinker, SLModifierBase)
function sl_modifier_global_thinker.prototype.DeclareFunctions(self)
	return {
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
		MODIFIER_EVENT_ON_MODIFIER_REFRESHED,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_HEAL_RECEIVED,
		MODIFIER_EVENT_ON_ABILITY_START,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_EVENT_ON_HERO_KILLED,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_RESPAWN,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ABILITY_END_CHANNEL,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function sl_modifier_global_thinker.prototype.OnModifierRefreshed(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnModifierRefreshed(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:38:9")
end
function sl_modifier_global_thinker.prototype.OnModifierAdded(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnModifierAdded(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:43:9")
end
function sl_modifier_global_thinker.prototype.OnTakeDamage(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnTakeDamage(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:52:9")
end
function sl_modifier_global_thinker.prototype.OnHealReceived(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnHealReceived(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:57:9")
end
function sl_modifier_global_thinker.prototype.OnAbilityStart(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityStart(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:63:9")
end
function sl_modifier_global_thinker.prototype.OnAbilityExecuted(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityExecuted(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:77:9")
end
function sl_modifier_global_thinker.prototype.OnAbilityFullyCast(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityFullyCast(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:83:9")
end
function sl_modifier_global_thinker.prototype.OnAbilityEndChannel(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAbilityEndChannel(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:88:9")
end
function sl_modifier_global_thinker.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnDeath(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:94:9")
end
function sl_modifier_global_thinker.prototype.OnHeroKilled(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnHeroKilled(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:100:9")
end
function sl_modifier_global_thinker.prototype.OnRespawn(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnRespawn(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:110:9")
end
function sl_modifier_global_thinker.prototype.OnAttackStart(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackStart(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:115:9")
end
function sl_modifier_global_thinker.prototype.OnAttackRecord(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackRecord(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:120:9")
end
function sl_modifier_global_thinker.prototype.OnAttackRecordDestroy(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackRecordDestroy(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:125:9")
end
function sl_modifier_global_thinker.prototype.OnAttack(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackLaunch(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:130:9")
end
function sl_modifier_global_thinker.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnAttackLanded(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:135:9")
end
function sl_modifier_global_thinker.prototype.OnDamageCalculated(self, event)
	if not IsServer() then
		return
	end
	SafelyCall(function()
		return GlobalThinker:OnDamageCalculated(event)
	end, nil, "modifiers/game_modifiers/sl_modifier_global_thinker.ts:140:9")
end
sl_modifier_global_thinker = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_global_thinker", nil, getfenv()) },
	sl_modifier_global_thinker
)
____exports.sl_modifier_global_thinker = sl_modifier_global_thinker
return ____exports