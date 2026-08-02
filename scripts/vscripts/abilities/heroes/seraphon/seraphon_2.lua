--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/seraphon/seraphon_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "seraphon_2"
d(m, k)
function m.prototype.OnCreated(self)
	local n = self:GetCaster()
	self:StartThink(0, function()
		local o = DungeonManager:GetCurrentRoom()
		if
			self:GetAutoCastState()
			and self:IsCooldownReady()
			and (o and o:IsCombatRoom() and not o:IsCombatEnd() or AbyssalHordeManager:IsRunning())
		then
			local p = Controller:GetInputDirection(n)
			if VectorIsZero(p) then
				p = n:GetForwardVector()
			end
			self:OnController(n:GetAbsOrigin() + p * self:GetSpecialValueFor("distance"), p)
		end
	end)
end
function m.prototype.OnController(self, q, p)
	local n = self:GetCaster()
	if q == nil then
		q = n:GetAbsOrigin() + p * self:GetSpecialValueFor("distance")
	end
	n:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, q)
end
function m.prototype.GetCooldown(self, r)
	return math.max(k.prototype.GetCooldown(self, r) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function m.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("duration")
end
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local q = self:GetCursorPosition()
	if not n:HasModifier("modifier_seraphon_3") then
		n:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	end
	local p = CalcDirection2D(q, n:GetAbsOrigin())
	n:SetForwardVector(p)
	local s = math.min(self:GetSpecialValueFor("distance"), CalcDistance(q, n))
	local t = self:GetSpecialValueFor("duration")
	local u = 0
	n:AddNewModifier(n, self, "modifier_seraphon_2_dash", { duration = t })
	n:Dash(p, s, u, t)
end
m = e({ l(nil) }, m)
local v = c()
v.name = "modifier_seraphon_2_dash"
d(v, h)
function v.prototype.GetAbilitySpecialValue(self)
	self.distance = self:GetAbilitySpecialValueFor("distance")
	self.knockback = self:GetAbilitySpecialValueFor("knockback")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function v.prototype.OnCreated(self, w)
	local x = self:GetParent()
	if IsServer() then
		local y = self:GetAbility()
		x:EmitSound("Hero_DragonKnight.ElderDragonShoot3.Attack")
		Bullet:CreateCustomBullet({
			caster = x,
			spawnOrigin = x:GetAbsOrigin(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			radius = 120,
			lifeTime = self:GetDuration(),
			PathFunction = function(q, z)
				return x:GetAbsOrigin()
			end,
			ParticleCreator = function(z)
				local A = ParticleManager:CreateParticle(
					"particles/mushi_fx/mushi_fx_chongci_01.vpcf",
					PATTACH_CUSTOMORIGIN,
					x
				)
				ParticleManager:SetParticleControl(A, 0, x:GetAttachmentPosition("attach_hitloc"))
				ParticleManager:SetParticleControl(A, 1, x:GetAttachmentPosition("attach_hitloc"))
				ParticleManager:SetParticleControlEnt(
					A,
					1,
					x,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					x:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(A, 2, Vector(2000, 0, 0))
				return A
			end,
			FuncUnitFinder = function(B, q, C, z)
				return Bullet:FindUnitInLine(z.__teamNumber, B, q, C, C, z.teamFilter, z.typeFilter, z.flagFilter)
			end,
			OnBulletHit = function(D, E, z)
				local F = x:GetForwardVector()
				local G = AbilityUpgrade:HasAbilityUpgrade(x, "seraphon_upgrade_12")
				x:EmitSound("Hero_DragonKnight.DragonTail.DragonFormCast")
				x:DealDamage(D, y, self.damage)
				D:KnockBack(F, not G and self.knockback or self.distance * z.__lifeTimeRemaining / z.lifeTime, 100, 0.3)
				if not G and IsValid(self) then
					self:Destroy()
				end
				if not G then
					x:RemoveModifierByName("modifier_dash")
				end
			end,
		})
	else
	end
end
function v.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function v.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
v = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	v
)
return f