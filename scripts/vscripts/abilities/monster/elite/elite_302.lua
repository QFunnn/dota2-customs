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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
____exports.ELITE_302_BURROW_CAST_POINT = 1.54
____exports.ELITE_302_BURROW_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf"
local BURROW_CHECK_RANGE = 800
local BURROW_CHECK_INTERVAL = 0.5
local MOUND_MODEL = "models/heroes/nerubian_assassin/mound.vmdl"
local BURROW_IN_SOUND = "Hero_NyxAssassin.Burrow.In"
local BURROW_OUT_SOUND = "Hero_NyxAssassin.Burrow.Out"
____exports.elite_302 = __TS__Class()
local elite_302 = ____exports.elite_302
elite_302.name = "elite_302"
__TS__ClassExtends(elite_302, MonsterAbility_CS)
function elite_302.prototype.Precache(self, context)
	PrecacheResource("model", MOUND_MODEL, context)
	PrecacheResource("particle", ____exports.ELITE_302_BURROW_PARTICLE, context)
end
function elite_302.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0, cooldown = 0 }
end
function elite_302.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_302_burrow_controller"
end
function elite_302.ApplyMound(self, caster, ability)
	if ____exports.modifier_elite_302_mound:find_on(caster) then
		return
	end
	____exports.modifier_elite_302_mound:applys(caster, caster, ability, {})
end
function elite_302.RemoveMound(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local mound = ____exports.modifier_elite_302_mound:find_on(caster)
	if not mound then
		return
	end
	mound:Destroy()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_BURROW_END, 1)
	EmitSoundOn(BURROW_OUT_SOUND, caster)
end
function elite_302.HasNearbyEnemy(self, caster, range)
	if range == nil then
		range = BURROW_CHECK_RANGE
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			return true
		end
	end
	return false
end
function elite_302.SyncBurrowState(self, caster, ability)
	if ____exports.elite_302:HasNearbyEnemy(caster) then
		____exports.elite_302:RemoveMound(caster)
		return
	end
	____exports.elite_302:ApplyMound(caster, ability)
end
function elite_302.StartBurrow(self, caster, ability, onFinished)
	if not IsValidAlive(nil, caster) then
		return
	end
	____exports.elite_302:PlayBurrowStart(caster)
	ability:Timer(____exports.ELITE_302_BURROW_CAST_POINT, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		____exports.elite_302:ApplyMound(caster, ability)
		if onFinished ~= nil then
			onFinished(nil)
		end
	end)
end
function elite_302.PlayBurrowStart(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	____exports.elite_302:PlayBurrowEffect(caster)
	EmitSoundOn(BURROW_IN_SOUND, caster)
end
function elite_302.PlayBurrowEffect(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local forward = caster:GetForwardVector()
	local particle = ParticleManager:CreateParticle(____exports.ELITE_302_BURROW_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(particle, 0, origin, forward)
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:ReleaseParticleIndex(particle)
end
elite_302 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_302)
____exports.elite_302 = elite_302
local modifier_elite_302_burrow_controller = __TS__Class()
modifier_elite_302_burrow_controller.name = "modifier_elite_302_burrow_controller"
__TS__ClassExtends(modifier_elite_302_burrow_controller, MonsterModifier_CS)
function modifier_elite_302_burrow_controller.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.burrowPending = false
end
function modifier_elite_302_burrow_controller.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(BURROW_CHECK_INTERVAL)
	self:SyncState()
end
function modifier_elite_302_burrow_controller.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:SyncState()
end
function modifier_elite_302_burrow_controller.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_302_burrow_controller.prototype.SyncState(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local ____opt_2 = parent.IsMonsterCasting
	if (____opt_2 and ____opt_2(parent)) == true then
		return
	end
	if ____exports.elite_302:HasNearbyEnemy(parent) then
		self.burrowPending = false
		____exports.elite_302:RemoveMound(parent)
		return
	end
	if ____exports.modifier_elite_302_mound:find_on(parent) or self.burrowPending then
		return
	end
	self:StartBurrow(parent)
end
function modifier_elite_302_burrow_controller.prototype.StartBurrow(self, parent)
	self.burrowPending = true
	____exports.elite_302:PlayBurrowStart(parent)
	self:Timer(____exports.ELITE_302_BURROW_CAST_POINT, function()
		self.burrowPending = false
		if not IsValidAlive(nil, parent) then
			return
		end
		if ____exports.elite_302:HasNearbyEnemy(parent) then
			return
		end
		____exports.elite_302:ApplyMound(parent, self:GetAbility())
	end)
end
function modifier_elite_302_burrow_controller.prototype.IsHidden(self)
	return true
end
function modifier_elite_302_burrow_controller.prototype.IsPurgable(self)
	return false
end
modifier_elite_302_burrow_controller = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_302_burrow_controller") },
	modifier_elite_302_burrow_controller
)
____exports.modifier_elite_302_mound = __TS__Class()
local modifier_elite_302_mound = ____exports.modifier_elite_302_mound
modifier_elite_302_mound.name = "modifier_elite_302_mound"
__TS__ClassExtends(modifier_elite_302_mound, MonsterModifier_CS)
function modifier_elite_302_mound.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function modifier_elite_302_mound.prototype.GetModifierModelChange(self)
	return MOUND_MODEL
end
function modifier_elite_302_mound.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_302_mound.prototype.IsHidden(self)
	return true
end
function modifier_elite_302_mound.prototype.IsPurgable(self)
	return false
end
modifier_elite_302_mound =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_302_mound") }, modifier_elite_302_mound)
____exports.modifier_elite_302_mound = modifier_elite_302_mound
return ____exports