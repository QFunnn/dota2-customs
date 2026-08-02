--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vexis/vexis_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.ability_ai")
local h = g.EOMAbilityAI
local i = require("abilities.eom_ability")
local j = i.registerEOMAbility
local k = c()
k.name = "vexis_attack"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.attackBoolean = true
end
function k.prototype.GetAICastRange(self)
	return self:GetCaster():Script_GetAttackRange()
end
function k.prototype.GetThinkInterval(self)
	return math.max(FrameTime(), self:GetCaster():GetSecondsPerAttack(false) * 0.5)
end
function k.prototype.ProcsMagicStick(self)
	return false
end
function k.prototype.GetCooldown(self, l)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function k.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function k.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function k.prototype.GetChargeRestoreTime(self)
	return -1
end
function k.prototype.GetCastAnimation(self)
	if self:GetStackCount() >= 1 then
		return ACT_DOTA_ATTACK_EVENT
	end
	return self.attackBoolean and ACT_DOTA_ATTACK or ACT_DOTA_ATTACK2
end
function k.prototype.OnAbilityPhaseStart(self)
	local m = self:GetCaster()
	m:EmitSound(KeyValues:GetAttackSoundSet(m, "SoundSet") .. ".PreAttack")
	return true
end
function k.prototype.WispAttack(self, n, o, p, q)
	if q == nil then
		q = 0
	end
	local m = self:GetCaster()
	local r = CalcDirection2D(o, n)
	self:CreateAttack(r, p, n, q)
	local s = 1 + self:GetSpecialValueFor("bullet_count")
	if p then
		self:StartThink(0.1, "wisp_attack", function()
			self:CreateAttack(r, p, n, q)
			Event:Fire("attack_event", { attacker = m, position = o })
			s = s - 1
			return s > 0 and 0.1 or -1
		end)
	end
	Event:Fire("attack_event", { attacker = m, position = o })
end
function k.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	local n = m:GetAbsOrigin()
	local o = self:GetSupportCastPoint()
	local r = CalcDirection2D(o, n)
	m:SetForwardVector(r)
	local t = self:GetStackCount()
	local p = t >= 1
	if not p then
		p = self:PRD(self:GetSpecialValueFor("attack_chance"))
	end
	local u =
		m:GetAttachmentPosition(p and "attach_attack2" or (self.attackBoolean and "attach_attack1" or "attach_attack2"))
	self:CreateAttack(r, p, u)
	if p then
		self:DecrementStackCount(1, false)
		local s = 1 + self:GetSpecialValueFor("bullet_count")
		self:StartThink(0.1, function()
			self:CreateAttack(r, p, m:GetAttachmentPosition("attach_attack1"))
			Event:Fire("attack_event", { attacker = m, position = o })
			s = s - 1
			return s > 0 and 0.1 or -1
		end)
	end
	self.attackBoolean = not self.attackBoolean
	Event:Fire("attack_event", { attacker = m, position = o })
end
function k.prototype.CreateAttack(self, r, p, u, q)
	if q == nil then
		q = 0
	end
	local m = self:GetCaster()
	local v = m:Script_GetAttackRange()
	local w = p and self:GetSpecialValueFor("bonus_damage") or 0
	local x = (p and self:GetSpecialValueFor("damage_amplify") / 100 or 0) + q
	local y = self:GetSpecialValueFor("lightning_damage")
	local z = self:GetSpecialValueFor("blade_count")
	local A = m:GetProjectileSpeed()
	if p then
		local B = self:GetSpecialValueFor("dash_cd_reduce")
		local C = m:GetAbilityByTag(AbilityTag.Dodge)
		if C ~= nil then
			C:ReduceCooldown(B)
		end
	end
	local D = {
		caster = m,
		direction = r,
		effectName = m:GetRangedProjectileName(),
		spawnOrigin = u,
		moveSpeed = A,
		radius = BULLET_WIDTH,
		lifeTime = v / A,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = UNIT_AND_BUILDING,
		flagFilter = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		bounce = self:GetSpecialValueFor("bounce_count"),
		OnBulletHit = function(E, o, F)
			m:Attack(E, { bonusDamage = w, damageAmplify = x, damageType = self:GetDamageType() })
			if p then
				local B = self:GetSpecialValueFor("dash_cd_reduce")
				local C = m:GetAbilityByTag(AbilityTag.Dodge)
				if C ~= nil then
					C:ReduceCooldown(B)
				end
				if y > 0 then
					m:LightningStrike(E, y)
				end
				if z > 0 then
					m:CallSword(z)
				end
			end
		end,
	}
	Bullet:CreateGuidedBullet(D)
	m:EmitSound(KeyValues:GetAttackSoundSet(m, "SoundSet") .. ".Attack")
end
function k.prototype.EventListener(self)
	return {
		ability_cast_complete = function(G, H)
			if H.caster ~= self:GetCaster() then
				return
			end
			if
				H.abilityTag == AbilityTag.Dodge
				or H.abilityTag == AbilityTag.Skill
				or H.abilityTag == AbilityTag.Defense
				or H.abilityTag == AbilityTag.Ultimate
			then
				local I = self:GetSpecialValueFor("max_stack")
				if self:GetStackCount() < I then
					self:IncrementStackCount(1, false)
					self:RestoreCharges()
				end
				self.attackBoolean = true
			end
		end,
		ability_upgrade_added = function(G, J)
			if J.unit == self:GetCaster() and J.upgradeName == "vexis_upgrade_28" then
				self.wisp = J.unit:CreateWisp(
					"vexis_wisp",
					{ attack = self:GetSpecialValueFor("wisp_attack"), attack_ability_name = "vexis_wisp_attack" }
				)
			end
		end,
		ability_upgrade_removed = function(G, J)
			if J.unit == self:GetCaster() and J.upgradeName == "vexis_upgrade_28" and IsValid(self.wisp) then
				J.unit:RemoveWisp(self.wisp)
				self.wisp = nil
			end
		end,
		ability_upgrades_cleared = function(G, J)
			if J.unit == self:GetCaster() and IsValid(self.wisp) then
				J.unit:RemoveWisp(self.wisp)
				self.wisp = nil
			end
		end,
	}
end
function k.prototype.StaticProperty(self)
	return {
		[PropertyFunction.BOUNCE_COUNT] = self:GetSpecialValueFor("bounce"),
		[PropertyFunction.ABILITY_CHARGE_ATTACK] = self:GetSpecialValueFor("max_stack") - 1,
	}
end
k = e({ j(nil, {
	funcCondition = function(G, C)
		return C:GetAutoCastState()
	end,
}) }, k)
return f