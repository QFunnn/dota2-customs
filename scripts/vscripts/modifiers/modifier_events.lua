--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_events"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 49,
		["12"] = 50,
		["13"] = 49,
		["14"] = 50,
		["15"] = 51,
		["16"] = 52,
		["17"] = 51,
		["18"] = 54,
		["19"] = 55,
		["20"] = 54,
		["21"] = 57,
		["22"] = 58,
		["23"] = 57,
		["24"] = 60,
		["25"] = 61,
		["26"] = 60,
		["27"] = 63,
		["28"] = 64,
		["29"] = 63,
		["30"] = 66,
		["31"] = 67,
		["32"] = 66,
		["33"] = 69,
		["34"] = 70,
		["35"] = 69,
		["36"] = 72,
		["37"] = 73,
		["38"] = 72,
		["39"] = 75,
		["40"] = 76,
		["41"] = 76,
		["42"] = 76,
		["43"] = 76,
		["44"] = 76,
		["45"] = 76,
		["46"] = 76,
		["47"] = 76,
		["48"] = 76,
		["49"] = 76,
		["50"] = 75,
		["51"] = 87,
		["52"] = 88,
		["53"] = 88,
		["54"] = 88,
		["55"] = 88,
		["56"] = 88,
		["57"] = 88,
		["58"] = 88,
		["59"] = 88,
		["60"] = 88,
		["61"] = 88,
		["62"] = 88,
		["63"] = 88,
		["64"] = 88,
		["65"] = 88,
		["66"] = 88,
		["67"] = 88,
		["68"] = 88,
		["69"] = 88,
		["70"] = 88,
		["71"] = 88,
		["72"] = 88,
		["73"] = 88,
		["74"] = 87,
		["75"] = 134,
		["76"] = 135,
		["77"] = 134,
		["78"] = 137,
		["79"] = 138,
		["80"] = 137,
		["81"] = 140,
		["82"] = 141,
		["83"] = 140,
		["84"] = 143,
		["85"] = 144,
		["86"] = 143,
		["87"] = 146,
		["88"] = 147,
		["89"] = 146,
		["90"] = 149,
		["91"] = 150,
		["92"] = 149,
		["93"] = 152,
		["94"] = 153,
		["95"] = 152,
		["96"] = 155,
		["97"] = 156,
		["98"] = 155,
		["99"] = 158,
		["100"] = 159,
		["101"] = 158,
		["102"] = 161,
		["103"] = 162,
		["104"] = 161,
		["105"] = 164,
		["106"] = 165,
		["107"] = 164,
		["108"] = 167,
		["109"] = 168,
		["110"] = 167,
		["111"] = 217,
		["112"] = 218,
		["113"] = 217,
		["114"] = 220,
		["115"] = 221,
		["116"] = 220,
		["117"] = 223,
		["118"] = 224,
		["119"] = 223,
		["120"] = 226,
		["121"] = 227,
		["122"] = 226,
		["123"] = 229,
		["124"] = 230,
		["125"] = 229,
		["126"] = 232,
		["127"] = 233,
		["128"] = 232,
		["129"] = 235,
		["130"] = 236,
		["131"] = 235,
		["132"] = 238,
		["133"] = 239,
		["134"] = 238,
		["135"] = 241,
		["136"] = 242,
		["137"] = 241,
		["138"] = 284,
		["139"] = 285,
		["140"] = 284,
		["141"] = 287,
		["142"] = 288,
		["143"] = 287,
		["144"] = 290,
		["145"] = 291,
		["146"] = 290,
		["147"] = 293,
		["148"] = 294,
		["149"] = 293,
		["150"] = 296,
		["151"] = 297,
		["152"] = 296,
		["153"] = 299,
		["154"] = 300,
		["155"] = 299,
		["156"] = 302,
		["157"] = 303,
		["158"] = 302,
		["159"] = 305,
		["160"] = 306,
		["161"] = 305,
		["162"] = 308,
		["163"] = 309,
		["164"] = 308,
		["165"] = 311,
		["166"] = 312,
		["167"] = 311,
		["168"] = 314,
		["169"] = 315,
		["170"] = 314,
		["171"] = 317,
		["172"] = 318,
		["173"] = 317,
		["174"] = 320,
		["175"] = 321,
		["176"] = 320,
		["177"] = 323,
		["178"] = 324,
		["179"] = 323,
		["180"] = 326,
		["181"] = 327,
		["182"] = 326,
		["183"] = 329,
		["184"] = 330,
		["185"] = 329,
		["186"] = 332,
		["187"] = 333,
		["188"] = 332,
		["189"] = 335,
		["190"] = 336,
		["191"] = 335,
		["192"] = 50,
		["193"] = 49,
		["194"] = 50,
		["196"] = 50,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseModifier
local j = h.registerModifier
g.modifier_events = c()
local k = g.modifier_events
k.name = "modifier_events"
d(k, i)
function k.prototype.IsHidden(self)
	return true
end
function k.prototype.IsDebuff(self)
	return false
end
function k.prototype.IsPurgable(self)
	return false
end
function k.prototype.IsPurgeException(self)
	return false
end
function k.prototype.AllowIllusionDuplicate(self)
	return false
end
function k.prototype.RemoveOnDeath(self)
	return false
end
function k.prototype.DestroyOnExpire(self)
	return false
end
function k.prototype.IsPermanent(self)
	return true
end
function k.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function k.prototype.DeclareFunctions(self)
	return {
		MODIFIER_EVENT_ON_SPELL_TARGET_READY,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_EVENT_ON_UNIT_MOVED,
		MODIFIER_EVENT_ON_ABILITY_START,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_EVENT_ON_ABILITY_END_CHANNEL,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_RESPAWN,
		MODIFIER_EVENT_ON_SPENT_MANA,
		MODIFIER_EVENT_ON_TELEPORTED,
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_EVENT_ON_ATTACK_CANCELLED,
	}
end
function k.prototype.OnSpellTargetReady(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_SPELL_TARGET_READY, l, l.unit, l.target)
end
function k.prototype.OnAttackRecord(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_RECORD, l, l.attacker, l.target)
end
function k.prototype.OnAttackStart(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_START, l, l.attacker, l.target)
end
function k.prototype.OnAttack(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK, l, l.attacker, l.target)
end
function k.prototype.OnAttackLanded(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_LANDED, l, l.attacker, l.target)
end
function k.prototype.OnAttackFail(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_FAIL, l, l.attacker, l.target)
end
function k.prototype.OnAttackAllied(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_ALLIED, l, l.attacker, l.target)
end
function k.prototype.OnProjectileDodge(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_PROJECTILE_DODGE, l)
end
function k.prototype.OnOrder(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ORDER, l, l.unit, l.target)
end
function k.prototype.OnUnitMoved(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_UNIT_MOVED, l, l.unit)
end
function k.prototype.OnAbilityStart(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ABILITY_START, l, l.unit, l.target)
end
function k.prototype.OnAbilityExecuted(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ABILITY_EXECUTED, l, l.unit, l.target)
end
function k.prototype.OnAbilityFullyCast(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ABILITY_FULLY_CAST, l, l.unit, l.target)
end
function k.prototype.OnBreakInvisibility(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_BREAK_INVISIBILITY, l)
end
function k.prototype.OnAbilityEndChannel(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ABILITY_END_CHANNEL, l, l.unit, l.target)
end
function k.prototype.OnTakeDamage(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_TAKEDAMAGE, l, l.attacker, l.unit)
end
function k.prototype.OnStateChanged(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_STATE_CHANGED, l, l.unit)
end
function k.prototype.OnProcessCleave(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_PROCESS_CLEAVE, l)
end
function k.prototype.OnDamageCalculated(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_DAMAGE_CALCULATED, l, l.attacker, l.target)
end
function k.prototype.OnAttacked(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACKED, l, l.attacker, l.target)
end
function k.prototype.OnDeath(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_DEATH, l, l.attacker, l.unit)
end
function k.prototype.OnRespawn(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_RESPAWN, l, l.unit)
end
function k.prototype.OnSpentMana(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_SPENT_MANA, l, l.unit)
end
function k.prototype.OnTeleporting(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_TELEPORTING, l, l.unit)
end
function k.prototype.OnTeleported(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_TELEPORTED, l, l.unit)
end
function k.prototype.OnSetLocation(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_SET_LOCATION, l)
end
function k.prototype.OnHealthGained(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_HEALTH_GAINED, l, l.unit)
end
function k.prototype.OnManaGained(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_MANA_GAINED, l, l.unit)
end
function k.prototype.OnTakeDamageKillCredit(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT, l, l.attacker, l.unit)
end
function k.prototype.OnHeroKilled(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_HERO_KILLED, l, l.attacker, l.unit)
end
function k.prototype.OnHealReceived(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_HEAL_RECEIVED, l, l.unit)
end
function k.prototype.OnBuildingKilled(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_BUILDING_KILLED, l)
end
function k.prototype.OnModelChanged(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_MODEL_CHANGED, l)
end
function k.prototype.OnModifierAdded(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_MODIFIER_ADDED, l, l.unit)
end
function k.prototype.OnDominated(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_MODIFIER_ADDED, l)
end
function k.prototype.OnAttackFinished(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_MODIFIER_ADDED, l, l.attacker, l.target)
end
function k.prototype.OnAttackRecordDestroy(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY, l, l.attacker, l.target)
end
function k.prototype.OnProjectileObstructionHit(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_PROJECTILE_OBSTRUCTION_HIT, l)
end
function k.prototype.OnAttackCancelled(self, l)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_CANCELLED, l, l.attacker, l.target)
end
k = e({ j(a) }, k)
g.modifier_events = k
return g