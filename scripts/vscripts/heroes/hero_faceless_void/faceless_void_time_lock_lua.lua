--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_faceless_void_time_lock_lua", "heroes/hero_faceless_void/faceless_void_time_lock_lua.lua",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_faceless_void_time_lock_lua_stun", "heroes/hero_faceless_void/faceless_void_time_lock_lua.lua",
	LUA_MODIFIER_MOTION_NONE)

if faceless_void_time_lock_lua == nil then
	faceless_void_time_lock_lua = class({}) ---@class faceless_void_time_lock_lua : CDOTA_Ability_Lua
end

function faceless_void_time_lock_lua:GetIntrinsicModifierName()
	return "modifier_faceless_void_time_lock_lua"
end

function faceless_void_time_lock_lua:Bash(target, attackInfo, isTriggerbyWalk)
	isTriggerbyWalk = isTriggerbyWalk or false
	local caster = self:GetCaster()
	local delay = self:GetSpecialValueFor("delay")
	local duration = self:GetSpecialValueFor("duration")
	if not IsValid(target) or not target:IsAlive() then return end

	local buff = caster:FindModifierByName("modifier_faceless_void_time_lock_lua")
	if not buff then return end

	target:AddNewModifier(caster, self, "modifier_faceless_void_time_lock_lua_stun", {
		duration = duration * target:GetStatusResistanceFactor(caster)
	})
	EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", target)
	if (caster.time_locking or isTriggerbyWalk or not caster:AttackFilter(attackInfo.record, ATTACK_STATE_NOT_PROCESSPROCS, ATTACK_STATE_NO_EXTENDATTACK)) and not target:IsAttackImmune() then
		table.insert(buff.bonus_attack, { hTarget = target, time = GameRulesCustom:GetGameTime() + delay })
	end
end

---------------------------------------------------------------------
if modifier_faceless_void_time_lock_lua == nil then
	modifier_faceless_void_time_lock_lua = class({}) ---@class modifier_faceless_void_time_lock_lua : CDOTA_Modifier_Lua
end

function modifier_faceless_void_time_lock_lua:IsHidden() return true end

function modifier_faceless_void_time_lock_lua:IsDebuff() return false end

function modifier_faceless_void_time_lock_lua:IsPurgable() return false end

function modifier_faceless_void_time_lock_lua:IsPurgeException() return false end

function modifier_faceless_void_time_lock_lua:AllowIllusionDuplicate() return false end

function modifier_faceless_void_time_lock_lua:OnCreated(params)
	local ability = self:GetAbility()
	if not ability then return end

	self.chance_pct = ability:GetSpecialValueFor("chance_pct")
	self.delay = ability:GetSpecialValueFor("delay")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	if IsServer() then
		self.records = {}
		self.bonus_attack = {}
		self:StartIntervalThink(0)
	end
end

function modifier_faceless_void_time_lock_lua:OnRefresh(params)
	local ability = self:GetAbility()
	if not ability then return end

	self.chance_pct = ability:GetSpecialValueFor("chance_pct")
	self.delay = ability:GetSpecialValueFor("delay")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
end

function modifier_faceless_void_time_lock_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

---@param event ModifierAbilityEvent
function modifier_faceless_void_time_lock_lua:OnAbilityExecuted(event)
	local parent = self:GetParent()
	local caster = event.unit
	local ability = event.ability

	if not IsServer() then return end
	if caster == parent and IsValid(caster) and IsValid(ability) and caster:HasScepter() and ability:GetAbilityName() == "faceless_void_time_walk" then
		local radius_scepter = ability:GetSpecialValueFor("radius")
		local vCursorPos = ability:GetCursorPosition()
		local vDir = (vCursorPos - caster:GetAbsOrigin()):Normalized()
		local fWalkRange = ability:GetSpecialValueFor("range") + ability:GetSpecialValueFor("shard_bonus_range") +
			caster:GetCastRangeBonus()
		local fRange = math.min((vCursorPos - caster:GetAbsOrigin()):Length2D(), fWalkRange)
		local vPos = caster:GetAbsOrigin() + fRange * vDir
		local units = FindUnitsInRadius(caster:GetTeamNumber(), vPos, nil, radius_scepter,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				if self:GetAbility() ~= nil then
					self:GetAbility():Bash(unit, {}, true)
				end
			end
		end
	end
end

function modifier_faceless_void_time_lock_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target

	if IsValid(hParent) and IsValid(hTarget) and hTarget:IsAlive() and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
		if hParent.time_locking then
			ApplyDamage({
				victim = hTarget,
				attacker = hParent,
				damage = self.bonus_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility(),
			})
		end
		if hTarget:IsAlive() and (not hParent:PassivesDisabled()) and RollPseudoRandomPercentage(self.chance_pct, DOTA_PSEUDO_RANDOM_FACELESS_BASH, hParent) then
			local hAbility = self:GetAbility()
			if hAbility and hAbility.Bash and type(hAbility.Bash) == "function" then
				hAbility:Bash(hTarget, params)
			end
		end
	end
end

function modifier_faceless_void_time_lock_lua:OnIntervalThink()
	local hParent = self:GetParent()
	if self.bonus_attack ~= nil then
		for i = #self.bonus_attack, 1, -1 do
			local attack_info = self.bonus_attack[i]
			local hTarget = attack_info.hTarget
			if IsValid(hParent) and IsValid(hTarget) and hTarget:IsAlive() then
				if GameRulesCustom:GetGameTime() >= attack_info.time then
					local particleID = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_faceless_void/faceless_void_time_lock_bash_custom.vpcf",
						PATTACH_ABSORIGIN_FOLLOW, hTarget)
					ParticleManager:SetParticleControlEnt(particleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc",
						hTarget:GetAbsOrigin(), true)
					ParticleManager:SetParticleControlEnt(particleID, 2, hParent, PATTACH_ABSORIGIN_FOLLOW, nil,
						hTarget:GetAbsOrigin(), true)
					ParticleManager:ReleaseParticleIndex(particleID)
					hParent.time_locking = true
					hParent:Attack(hTarget,
						ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NO_EXTENDATTACK +
						ATTACK_STATE_SKIPCOUNTING)
					hParent.time_locking = false
					table.remove(self.bonus_attack, i)
				end
			else
				table.remove(self.bonus_attack, i)
			end
		end
	end
end

---------------------------------------------------------------------
if modifier_faceless_void_time_lock_lua_stun == nil then
	modifier_faceless_void_time_lock_lua_stun = class({}) ---@class modifier_faceless_void_time_lock_lua_stun : CDOTA_Modifier_Lua
end

function modifier_faceless_void_time_lock_lua_stun:IsHidden() return false end

function modifier_faceless_void_time_lock_lua_stun:IsDebuff() return true end

function modifier_faceless_void_time_lock_lua_stun:IsPurgable() return false end

function modifier_faceless_void_time_lock_lua_stun:IsPurgeException() return true end

function modifier_faceless_void_time_lock_lua_stun:CheckState()
	return
	{
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_faceless_void_time_lock_lua_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_faceless_void_time_lock_lua_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_faceless_void_time_lock_lua_stun:GetStatusEffectName()
	return "particles/status_fx/status_effect_faceless_chronosphere.vpcf"
end

function modifier_faceless_void_time_lock_lua_stun:StatusEffectPriority()
	return 10
end