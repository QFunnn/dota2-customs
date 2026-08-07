--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "class/custom_unit"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = {}
d.CustomUnit = c()
local e = d.CustomUnit
e.name = "CustomUnit"
function e.prototype.____constructor(self, f, g, h)
	self.enableAttackTime = 0
	self.isDispose = false
	self.kv = KeyValues.units[f]
	self.entity = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{
			angles = "0 0 0",
			model = self.kv.Model,
			origin = (((tostring(g.x) .. " ") .. tostring(g.y)) .. " ") .. tostring(g.z),
			targetname = f,
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			IdleAnim = "ACT_DOTA_IDLE",
			IdleAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			teamnumber = tostring(h),
		}
	)
	self.entity:StartThink(0, function()
		if self.wantPosition ~= nil then
			if self:IsSequenceFinished() then
				self:SetSequence("ACT_DOTA_RUN")
			end
			local i = self:GetAbsOrigin()
			local j = CalcDirection2D(self.wantPosition, i)
			local k = self:GetMoveSpeed()
			local l = k * FrameTime()
			self:SetForwardVector(j)
			if CalcDistance(self.wantPosition, i) > l then
				self.entity:SetLocalOrigin(i + j * l)
			else
				self.entity:SetLocalOrigin(self.wantPosition)
				self.wantPosition = nil
				self:SetSequence("ACT_DOTA_IDLE")
			end
		end
		self:SyncThinkerPosition()
	end)
	self.modifierThinker = CreateModifierThinker(nil, nil, "modifier_custom_thinker", {}, g, h, false)
	if UnitManager ~= nil then
		UnitManager:AddUnit(self.modifierThinker)
	end
end
function e.prototype.StartGesture(self, m)
	self.entity:SetSequence(m)
end
function e.prototype.AddNewModifier(self, n, o, p, q, r)
	return self.modifierThinker:AddNewModifier(n, o, p, q, r)
end
function e.prototype.SetForwardVector(self, s)
	self.entity:SetLocalAngles(0, VectorToAngles(s).y, 0)
end
function e.prototype.GetAbsOrigin(self)
	return self.entity:GetAbsOrigin()
end
function e.prototype.GetForwardVector(self)
	return self.entity:GetForwardVector()
end
function e.prototype.GetMoveSpeed(self)
	return self.kv.MovementSpeed
end
function e.prototype.GetEntityIndex(self)
	return self.entity:GetEntityIndex()
end
function e.prototype.GetUnitName(self)
	return self.entity:GetName()
end
function e.prototype.GetRangedProjectileName(self)
	return self.kv.ProjectileModel
end
function e.prototype.GetProjectileSpeed(self)
	return self.kv.ProjectileSpeed
end
function e.prototype.GetSequence(self)
	return self.entity:GetSequence()
end
function e.prototype.SetSequence(self, m)
	self.entity:SetSequence(m)
end
function e.prototype.GetCycle(self)
	return self.entity:GetCycle()
end
function e.prototype.IsSequenceFinished(self)
	return self.entity:IsSequenceFinished()
end
function e.prototype.SyncThinkerPosition(self)
	if IsValid(self.modifierThinker) and IsValid(self.entity) then
		self.modifierThinker:SetAbsOrigin(self.entity:GetAbsOrigin())
	end
end
function e.prototype.Attack(self)
	self:Stop()
	self:StartGesture("ACT_DOTA_ATTACK")
	self.enableAttackTime = GameRules:GetGameTime() + 2
	self.entity:StartThink(0.3, function()
		local t = self:GetAbsOrigin()
		local j = self:GetForwardVector()
		local u = {
			caster = self.modifierThinker,
			direction = j,
			effectName = "particles/units/creep/ranged_creep/ranged_creep_1_base_attack_fx.vpcf",
			spawnOrigin = t + j * 100 + Vector(0, 0, 45),
			moveSpeed = 900,
			radius = BULLET_WIDTH,
			lifeTime = 1200 / 900,
			reflectable = true,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(v, g, w)
				self.modifierThinker:Attack(v, { baseDamage = 10 })
				return true
			end,
		}
		Bullet:CreateGuidedBullet(u)
		return -1
	end)
end
function e.prototype.GetAttackCooldown(self) end
function e.prototype.Move(self, g)
	self.wantPosition = g
	self:StartGesture("ACT_DOTA_RUN")
end
function e.prototype.Stop(self)
	self.wantPosition = nil
	self:SetSequence("ACT_DOTA_IDLE")
end
function e.prototype.dispose(self)
	if self.isDispose then
		return
	end
	self.isDispose = true
	if IsValid(self.entity) then
		self.entity:RemoveSelf()
		self.entity = nil
	end
	if IsValid(self.modifierThinker) then
		if UnitManager ~= nil then
			UnitManager:RemoveUnit(self.modifierThinker)
		end
		self.modifierThinker:RemoveSelf()
		self.modifierThinker = nil
	end
end
return d