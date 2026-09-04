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
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local ____exports = {}
local modifier_boss_faceless_3_void
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local MODIFIER_CHRONOSPHERE_AURA = "modifier_ak_faceless_void_chronosphere_aura"
local MODIFIER_CHRONOSPHERE_HANDLER = "modifier_ak_faceless_void_chronosphere_handler"
local MODIFIER_CHRONOSPHERE_CASTER_BUFF = "modifier_ak_faceless_void_chronosphere_caster_buff"
local MODIFIER_CHRONOCHARGES = "modifier_ak_faceless_void_chronocharges"
local CHRONOSPHERE_PARTICLE =
	"particles/econ/items/faceless_void/faceless_void_mace_of_aeons/fv_chronosphere_aeons.vpcf"
local CHRONO_SPEED_PARTICLE = "particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf"
local BLINK_START_PARTICLE = "particles/monster/boss_faceless/boss_faceless_3_blink_start.vpcf"
local BLINK_END_PARTICLE = "particles/monster/boss_faceless/boss_faceless_3_blink_end.vpcf"
local SOUND_CHRONOSPHERE_CAST = "Hero_FacelessVoid.Chronosphere.MaceOfAeons"
local SOUND_VOID_OUT = "Hero_FacelessVoid.TimeWalk"
local AURA_DURATION = 0.2
local DEFAULT_CHRONOCHARGE_RADIUS = 500
local DEFAULT_DURATION = 10
local DEFAULT_MOVEMENT_SPEED = 1000
local CAST_RANGE = 2000
local PRECAST_TIME = 0.3
local VOID_WARNING_DURATION = 0.7
local BLINK_END_PREVIEW_TIME = 0.1
local VOID_TRAVEL_DURATION = VOID_WARNING_DURATION + BLINK_END_PREVIEW_TIME
local CAST_DURATION = VOID_TRAVEL_DURATION + 0.1
--- 虚空结界
-- 虚空领主短暂前摇后遁入异度空间，对目标点预警并闪现释放虚空结界。
____exports.boss_faceless_3 = __TS__Class()
local boss_faceless_3 = ____exports.boss_faceless_3
boss_faceless_3.name = "boss_faceless_3"
__TS__ClassExtends(boss_faceless_3, MonsterAbility_CS)
function boss_faceless_3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function boss_faceless_3.prototype.Precache(self, context)
	PrecacheResource("particle", CHRONOSPHERE_PARTICLE, context)
	PrecacheResource("particle", CHRONO_SPEED_PARTICLE, context)
	PrecacheResource("particle", BLINK_START_PARTICLE, context)
	PrecacheResource("particle", BLINK_END_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)
end
function boss_faceless_3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT,
		castPoint = PRECAST_TIME,
		castDuration = CAST_DURATION,
		castRange = DEFAULT_CHRONOCHARGE_RADIUS,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.chronoCenter = self:resolveTargetPoint(caster)
			local target = self:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, PRECAST_TIME, 10)
			end
		end,
		OnStart = function()
			self:StartVoidBlinkChronosphere()
		end,
		OnFinish = function()
			return self:Cleanup()
		end,
		OnInterrupt = function()
			return self:Cleanup()
		end,
	}
end
function boss_faceless_3.prototype.GetAOERadius(self)
	return DEFAULT_CHRONOCHARGE_RADIUS
end
function boss_faceless_3.prototype.resolveTargetPoint(self, caster)
	local nearest = self:GetMinDistanceUnit(CAST_RANGE)
	if nearest and IsValidAlive(nil, nearest) then
		local pos = nearest:GetAbsOrigin()
		return Vector(pos.x, pos.y, GetGroundHeight(pos, nearest) or pos.z)
	end
	local fallback = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(math.min(CAST_RANGE, 600)))
	return Vector(fallback.x, fallback.y, GetGroundHeight(fallback, caster) or fallback.z)
end
function boss_faceless_3.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	MonsterAbility_CS.prototype.OnSpellStart(self)
end
function boss_faceless_3.prototype.CreateChronosphereAtTargetPoint(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self
	local chronoCenter = self.chronoCenter or self:resolveTargetPoint(caster)
	AddFOWViewer(caster:GetTeamNumber(), chronoCenter, DEFAULT_CHRONOCHARGE_RADIUS, DEFAULT_DURATION, false)
	caster:EmitSound(SOUND_CHRONOSPHERE_CAST)
	CreateModifierThinker(
		caster,
		ability,
		MODIFIER_CHRONOSPHERE_AURA,
		{ duration = DEFAULT_DURATION },
		chronoCenter,
		caster:GetTeamNumber(),
		false
	)
end
function boss_faceless_3.prototype.StartVoidBlinkChronosphere(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequence = self.sequence + 1
	local currentSequence = self.sequence
	local chronoCenter = self.chronoCenter or self:resolveTargetPoint(caster)
	self.chronoCenter = chronoCenter
	self:PlayWorldParticle(BLINK_START_PARTICLE, caster:GetAbsOrigin(), caster:GetForwardVector())
	EmitSoundOn(SOUND_VOID_OUT, caster)
	modifier_boss_faceless_3_void:applys(caster, caster, self, { duration = VOID_TRAVEL_DURATION + 0.12 })
	self:WarningRingEffect(chronoCenter, DEFAULT_CHRONOCHARGE_RADIUS, VOID_WARNING_DURATION)
	self:Timer(VOID_WARNING_DURATION, function()
		if currentSequence ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		self:PlayWorldParticle(BLINK_END_PARTICLE, chronoCenter, caster:GetForwardVector())
	end)
	self:Timer(VOID_TRAVEL_DURATION, function()
		self:FinishVoidBlinkChronosphere(currentSequence)
	end)
end
function boss_faceless_3.prototype.FinishVoidBlinkChronosphere(self, sequence)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	local chronoCenter = self.chronoCenter or self:resolveTargetPoint(caster)
	local blinkPosition = GetGroundPosition(chronoCenter, caster)
	modifier_boss_faceless_3_void:remove(caster)
	FindClearSpaceForUnit(caster, blinkPosition, true)
	self.chronoCenter = blinkPosition
	self:CreateChronosphereAtTargetPoint()
end
function boss_faceless_3.prototype.PlayWorldParticle(self, particleName, origin, direction)
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 3, origin)
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:SetParticleControlForward(particle, 3, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function boss_faceless_3.prototype.Cleanup(self)
	self.sequence = self.sequence + 1
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		modifier_boss_faceless_3_void:remove(caster)
	end
end
boss_faceless_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_faceless_3)
____exports.boss_faceless_3 = boss_faceless_3
modifier_boss_faceless_3_void = __TS__Class()
modifier_boss_faceless_3_void.name = "modifier_boss_faceless_3_void"
__TS__ClassExtends(modifier_boss_faceless_3_void, MonsterModifier_CS)
function modifier_boss_faceless_3_void.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:AddNoDrawWithWearables()
	end
end
function modifier_boss_faceless_3_void.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveNoDrawWithWearables()
	end
end
function modifier_boss_faceless_3_void.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function modifier_boss_faceless_3_void.prototype.IsHidden(self)
	return true
end
function modifier_boss_faceless_3_void.prototype.IsPurgable(self)
	return false
end
modifier_boss_faceless_3_void =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_faceless_3_void") }, modifier_boss_faceless_3_void)
local modifier_ak_faceless_void_chronosphere_aura = __TS__Class()
modifier_ak_faceless_void_chronosphere_aura.name = "modifier_ak_faceless_void_chronosphere_aura"
__TS__ClassExtends(modifier_ak_faceless_void_chronosphere_aura, MonsterModifier_CS)
function modifier_ak_faceless_void_chronosphere_aura.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.total_radius = DEFAULT_CHRONOCHARGE_RADIUS
	self.mini_chrono = false
	self.casterBuffs = {}
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.IsPurgable(self)
	return false
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.IsHidden(self)
	return true
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.IsAura(self)
	return true
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.IsNetherWardStealable(self)
	return false
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetAuraDuration(self)
	return AURA_DURATION
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_OTHER
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetModifierAura(self)
	return MODIFIER_CHRONOSPHERE_HANDLER
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetAuraRadius(self)
	return self.total_radius
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.GetAuraEntityReject(self, target)
	if target ~= self:GetCaster() and target:GetUnitName() == "npc_dota_hero_faceless_void" then
		return true
	end
	return false
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not ability or ability:IsNull() then
		return
	end
	self.total_radius = params.radius or DEFAULT_CHRONOCHARGE_RADIUS
	local chronocharges = 0
	local chargeModifier = caster:FindModifierByName(MODIFIER_CHRONOCHARGES)
	if chargeModifier and not chargeModifier:IsNull() then
		chronocharges = chargeModifier:GetStackCount()
		chargeModifier:SetStackCount(0)
	end
	self:SetStackCount(chronocharges)
	local particle = ParticleManager:CreateParticle(CHRONOSPHERE_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.total_radius, self.total_radius, self.total_radius))
	self:AddParticle(particle, false, false, -1, false, false)
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, self) or self:IsNull() then
			return
		end
		print("stack count")
		print(self:GetStackCount())
		if self:GetStackCount() > 0 then
			self:StartIntervalThink(0.1)
		end
	end)
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.OnRemoved(self)
	if not IsServer() then
		return
	end
	self:DestroyAllCasterBuffs()
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) then
		return
	end
	if
		not IsValidAlive(nil, caster)
		or not IsValid(nil, parent)
		or parent:IsNull()
		or not ability
		or ability:IsNull()
	then
		return
	end
	local radius = self:GetAuraRadius()
	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)
	for ____, unit in ipairs(units) do
		do
			if not IsValidAlive(nil, unit) then
				goto __continue62
			end
			if not self:IsCasterControlledUnit(unit, caster) then
				goto __continue62
			end
			local id = unit:entindex()
			if self.casterBuffs[id] then
				goto __continue62
			end
		end
		::__continue62::
	end
	for ____, ____value in ipairs(__TS__ObjectEntries(self.casterBuffs)) do
		local idText = ____value[1]
		local mod = ____value[2]
		do
			local id = tonumber(idText)
			if not mod or mod:IsNull() then
				__TS__Delete(self.casterBuffs, id)
				goto __continue67
			end
			local unit = EntIndexToHScript(id)
			if not unit or not IsValid(nil, unit) or unit:IsNull() or not IsValidAlive(nil, unit) then
				mod:Destroy()
				__TS__Delete(self.casterBuffs, id)
				goto __continue67
			end
			if GetDistance(nil, parent:GetAbsOrigin(), unit:GetAbsOrigin()) > radius then
				mod:Destroy()
				__TS__Delete(self.casterBuffs, id)
			end
		end
		::__continue67::
	end
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.DestroyAllCasterBuffs(self)
	for ____, mod in ipairs(__TS__ObjectValues(self.casterBuffs)) do
		if mod and not mod:IsNull() then
			mod:Destroy()
		end
	end
	self.casterBuffs = {}
end
function modifier_ak_faceless_void_chronosphere_aura.prototype.IsCasterControlledUnit(self, unit, caster)
	if not IsValidAlive(nil, unit) then
		return false
	end
	if not IsValidAlive(nil, caster) then
		return false
	end
	if unit == caster then
		return true
	end
	local casterOwner = caster:GetPlayerOwner()
	local unitOwner = unit:GetPlayerOwner()
	if casterOwner and unitOwner and casterOwner == unitOwner then
		return true
	end
	local casterPlayerId = caster:GetPlayerOwnerID()
	local unitPlayerId = unit:GetPlayerOwnerID()
	if casterPlayerId >= 0 and unitPlayerId >= 0 and casterPlayerId == unitPlayerId then
		return true
	end
	return false
end
modifier_ak_faceless_void_chronosphere_aura =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_ak_faceless_void_chronosphere_aura)
local modifier_ak_faceless_void_chronosphere_handler = __TS__Class()
modifier_ak_faceless_void_chronosphere_handler.name = "modifier_ak_faceless_void_chronosphere_handler"
__TS__ClassExtends(modifier_ak_faceless_void_chronosphere_handler, MonsterModifier_CS)
function modifier_ak_faceless_void_chronosphere_handler.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.projectile_speed = 0
	self.mini_chrono = false
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.IsHidden(self)
	return true
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.IsPurgable(self)
	return false
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.IsDebuff(self)
	return self:GetStackCount() ~= 1 and self:GetStackCount() ~= 4
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	self.projectile_speed = parent:GetProjectileSpeed()
	if self:IsCasterControlledUnit(parent, caster) then
		self:SetStackCount(1)
	elseif parent:HasAbility("imba_faceless_void_timelord") then
		self:SetStackCount(3)
	elseif caster.HasScepter and caster:HasScepter() and caster:GetTeamNumber() == parent:GetTeamNumber() then
		self:SetStackCount(2)
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) then
		return
	end
	if
		not ability
		or ability:IsNull()
		or not IsValid(nil, parent)
		or parent:IsNull()
		or not IsValid(nil, caster)
		or caster:IsNull()
	then
		return
	end
	self.projectile_speed = parent:GetProjectileSpeed()
	if self:GetStackCount() == 1 and self:HasTalent(caster, "special_bonus_ak_faceless_void_3") then
		ProjectileManager:ProjectileDodge(parent)
	end
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.CheckState(self)
	local stacks = self:GetStackCount()
	if stacks == 0 then
		return { [MODIFIER_STATE_SILENCED] = true, [MODIFIER_STATE_INVISIBLE] = false }
	end
	if stacks == 1 or stacks == 4 then
		return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
	end
	return {}
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.GetPriority(self)
	if self:GetStackCount() == 0 then
		return MODIFIER_PRIORITY_HIGH
	end
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.GetAttributeBonus(self)
	if self:GetStackCount() == 0 then
		return { bonus_movespeed = -100, attack_speed = -100 }
	end
	return { bonus_movespeed = DEFAULT_MOVEMENT_SPEED, attack_speed = 200 }
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.HasTalent(self, caster, talentName)
	if not IsValidAlive(nil, caster) then
		return false
	end
	local unit = caster
	local ____unit_HasTalent_0
	if unit.HasTalent then
		____unit_HasTalent_0 = unit:HasTalent(talentName)
	else
		____unit_HasTalent_0 = false
	end
	return ____unit_HasTalent_0
end
function modifier_ak_faceless_void_chronosphere_handler.prototype.IsCasterControlledUnit(self, unit, caster)
	if unit == caster then
		return true
	end
	local casterOwner = caster:GetPlayerOwner()
	local unitOwner = unit:GetPlayerOwner()
	if casterOwner and unitOwner and casterOwner == unitOwner then
		return true
	end
	local casterPlayerId = caster:GetPlayerOwnerID()
	local unitPlayerId = unit:GetPlayerOwnerID()
	if casterPlayerId >= 0 and unitPlayerId >= 0 and casterPlayerId == unitPlayerId then
		return true
	end
	return false
end
modifier_ak_faceless_void_chronosphere_handler =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_ak_faceless_void_chronosphere_handler)
local modifier_ak_faceless_void_chronosphere_caster_buff = __TS__Class()
modifier_ak_faceless_void_chronosphere_caster_buff.name = "modifier_ak_faceless_void_chronosphere_caster_buff"
__TS__ClassExtends(modifier_ak_faceless_void_chronosphere_caster_buff, MonsterModifier_CS)
function modifier_ak_faceless_void_chronosphere_caster_buff.prototype.GetAttributeBonus(self)
	return { attack_speed = 200 }
end
modifier_ak_faceless_void_chronosphere_caster_buff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_ak_faceless_void_chronosphere_caster_buff)
return ____exports