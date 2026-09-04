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
local modifier_elite_305_borrowed_time
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local TRIGGER_HEALTH_PCT = 50
local BORROWED_TIME_DURATION = 5
local CHECK_INTERVAL = 0.1
local BORROWED_TIME_PARTICLE = "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf"
local BORROWED_TIME_STATUS_EFFECT = "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf"
local BORROWED_TIME_SOUND = "Hero_Abaddon.BorrowedTime"
____exports.elite_305 = __TS__Class()
local elite_305 = ____exports.elite_305
elite_305.name = "elite_305"
__TS__ClassExtends(elite_305, MonsterAbility_CS)
function elite_305.prototype.Precache(self, context)
	PrecacheResource("particle", BORROWED_TIME_PARTICLE, context)
	PrecacheResource("particle", BORROWED_TIME_STATUS_EFFECT, context)
end
function elite_305.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE,
		castPoint = 0,
		castDuration = 0,
		castAnimation = ACT_DOTA_CAST_ABILITY_6,
		cooldown = 14,
	}
end
function elite_305.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_305_borrowed_time_trigger"
end
elite_305 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_305)
____exports.elite_305 = elite_305
local modifier_elite_305_borrowed_time_trigger = __TS__Class()
modifier_elite_305_borrowed_time_trigger.name = "modifier_elite_305_borrowed_time_trigger"
__TS__ClassExtends(modifier_elite_305_borrowed_time_trigger, MonsterModifier_CS)
function modifier_elite_305_borrowed_time_trigger.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.triggered = false
end
function modifier_elite_305_borrowed_time_trigger.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.triggered = false
	self:StartIntervalThink(CHECK_INTERVAL)
end
function modifier_elite_305_borrowed_time_trigger.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	if self.triggered then
		return
	end
	if modifier_elite_305_borrowed_time:find_on(parent) then
		return
	end
	local maxHealth = parent:GetMaxHealth()
	if maxHealth <= 0 then
		return
	end
	if parent:GetHealth() / maxHealth * 100 > TRIGGER_HEALTH_PCT then
		return
	end
	self.triggered = true
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, 1)
	modifier_elite_305_borrowed_time:applys(parent, parent, ability, { duration = BORROWED_TIME_DURATION })
end
function modifier_elite_305_borrowed_time_trigger.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_305_borrowed_time_trigger.prototype.IsHidden(self)
	return true
end
function modifier_elite_305_borrowed_time_trigger.prototype.IsPurgable(self)
	return false
end
modifier_elite_305_borrowed_time_trigger = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_305_borrowed_time_trigger") },
	modifier_elite_305_borrowed_time_trigger
)
modifier_elite_305_borrowed_time = __TS__Class()
modifier_elite_305_borrowed_time.name = "modifier_elite_305_borrowed_time"
__TS__ClassExtends(modifier_elite_305_borrowed_time, MonsterModifier_CS)
function modifier_elite_305_borrowed_time.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_elite_305_borrowed_time.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	EmitSoundOn(BORROWED_TIME_SOUND, parent)
	self:CreateBorrowedTimeParticle(parent)
end
function modifier_elite_305_borrowed_time.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.ctx.spec.victim ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local damage = self:GetCurrentPipeDamage(event.final)
	event.prevent_apply = true
	if damage <= 0 then
		return
	end
	parent:CustomHeal(damage, {
		ability = self:GetAbility(),
		source = "spell",
		show_popup = true,
	})
end
function modifier_elite_305_borrowed_time.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyBorrowedTimeParticle()
end
function modifier_elite_305_borrowed_time.prototype.GetEffectName(self)
	return BORROWED_TIME_PARTICLE
end
function modifier_elite_305_borrowed_time.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_305_borrowed_time.prototype.GetStatusEffectName(self)
	return BORROWED_TIME_STATUS_EFFECT
end
function modifier_elite_305_borrowed_time.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
function modifier_elite_305_borrowed_time.prototype.IsHidden(self)
	return false
end
function modifier_elite_305_borrowed_time.prototype.IsPurgable(self)
	return false
end
function modifier_elite_305_borrowed_time.prototype.GetTexture(self)
	return "abaddon_borrowed_time"
end
function modifier_elite_305_borrowed_time.prototype.CreateBorrowedTimeParticle(self, parent)
	self:DestroyBorrowedTimeParticle()
	self.particle = ParticleManager:CreateParticle(BORROWED_TIME_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_elite_305_borrowed_time.prototype.DestroyBorrowedTimeParticle(self)
	if self.particle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
	self.particle = nil
end
function modifier_elite_305_borrowed_time.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
function modifier_elite_305_borrowed_time.GetLocalizationCN(self)
	return { name = "回光返照", description = "不受任何伤害，受到的伤害会转化为治疗。" }
end
modifier_elite_305_borrowed_time = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_305_borrowed_time") },
	modifier_elite_305_borrowed_time
)
return ____exports