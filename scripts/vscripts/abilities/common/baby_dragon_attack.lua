--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/common/baby_dragon_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "baby_dragon_attack"
d(j, h)
function j.prototype.ProcsMagicStick(self)
	return false
end
function j.prototype.GetCooldown(self, k)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function j.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function j.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	l:EmitSound(KeyValues:GetAttackSoundSet(l, "SoundSet") .. ".PreAttack")
	return true
end
function j.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorTarget()
	if not IsValid(m) then
		return
	end
	local n = l:GetOwner()
	if not IsValid(n) then
		return
	end
	local o = n:GetItemByName("item_dragon_baby")
	if not IsValid(o) then
		return
	end
	Bullet:SplitAction(CalcDirection2D(m, l), 3, 10, function(p, q)
		Bullet:CreateGuidedBullet({
			caster = l,
			direction = q,
			radius = BULLET_WIDTH,
			moveSpeed = l:GetProjectileSpeed(),
			effectName = l:GetRangedProjectileName(),
			spawnOrigin = l:GetAttachmentPosition("attach_attack1"),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(m, r, s)
				local t = l:GetAttackDamage() * (1 + GetWispDamage(n) / 100)
				n:DealDamage(m, o, t)
				return true
			end,
		})
	end)
	l:EmitSound(KeyValues:GetAttackSoundSet(l, "SoundSet") .. ".Attack")
	Event:Fire("attack_event", { attacker = l, position = m and m:GetAbsOrigin() })
end
j = e({ i(nil) }, j)
return f