--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
		local p = DungeonAdventure:IsPlayerInRunningAdventure(n:GetPlayerOwnerID())
		if
			self:IsCooldownReady()
			and (
				Demo.force_dash_auto_cast
				or self:GetAutoCastState()
					and (o and o:IsCombatRoom() and not o:IsCombatEnd() or AbyssalHordeManager:IsRunning() or p)
			)
		then
			if Demo.force_dash_auto_cast and not Demo:CanForceDashAutoCast(n) then
				return
			end
			local q = Demo.force_dash_auto_cast and Demo:GetForceDashDirection(n, self)
				or Controller:GetInputDirection(n)
			if VectorIsZero(q) then
				q = n:GetForwardVector()
			end
			self:OnController(n:GetAbsOrigin() + q * self:GetSpecialValueFor("distance"), q)
			if Demo.force_dash_auto_cast then
				Demo:MarkForceDashAutoCast(n)
			end
		end
	end)
end
function m.prototype.OnController(self, r, q)
	local n = self:GetCaster()
	if r == nil then
		r = n:GetAbsOrigin() + q * self:GetSpecialValueFor("distance")
	end
	n:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, self, r)
end
function m.prototype.GetCooldown(self, s)
	return math.max(k.prototype.GetCooldown(self, s) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function m.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("duration")
end
function m.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local r = self:GetCursorPosition()
	if not n:HasModifier("modifier_seraphon_3") then
		n:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	end
	local q = CalcDirection2D(r, n:GetAbsOrigin())
	n:SetForwardVector(q)
	local t = math.min(self:GetSpecialValueFor("distance"), CalcDistance(r, n))
	local u = self:GetSpecialValueFor("duration")
	local v = 0
	n:AddNewModifier(n, self, "modifier_seraphon_2_dash", { duration = u })
	n:Dash(q, t, v, u)
end
m = e({ l(nil) }, m)
local w = c()
w.name = "modifier_seraphon_2_dash"
d(w, h)
function w.prototype.GetAbilitySpecialValue(self)
	self.distance = self:GetAbilitySpecialValueFor("distance")
	self.knockback = self:GetAbilitySpecialValueFor("knockback")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function w.prototype.OnCreated(self, x)
	local y = self:GetParent()
	if IsServer() then
		local z = self:GetAbility()
		y:EmitSound("Hero_DragonKnight.ElderDragonShoot3.Attack")
		Bullet:CreateCustomBullet({
			caster = y,
			spawnOrigin = y:GetAbsOrigin(),
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			radius = 120,
			lifeTime = self:GetDuration(),
			PathFunction = function(r, A)
				return y:GetAbsOrigin()
			end,
			ParticleCreator = function(A)
				local B = ParticleManager:CreateParticle(
					"particles/mushi_fx/mushi_fx_chongci_01.vpcf",
					PATTACH_CUSTOMORIGIN,
					y
				)
				ParticleManager:SetParticleControl(B, 0, y:GetAttachmentPosition("attach_hitloc"))
				ParticleManager:SetParticleControl(B, 1, y:GetAttachmentPosition("attach_hitloc"))
				ParticleManager:SetParticleControlEnt(
					B,
					1,
					y,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					y:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControl(B, 2, Vector(2000, 0, 0))
				return B
			end,
			FuncUnitFinder = function(C, r, D, A)
				return Bullet:FindUnitInLine(A.__teamNumber, C, r, D, D, A.teamFilter, A.typeFilter, A.flagFilter)
			end,
			OnBulletHit = function(E, F, A)
				local G = y:GetForwardVector()
				local H = AbilityUpgrade:HasAbilityUpgrade(y, "seraphon_upgrade_12")
				y:EmitSound("Hero_DragonKnight.DragonTail.DragonFormCast")
				y:DealDamage(E, z, self.damage)
				E:KnockBack(G, not H and self.knockback or self.distance * A.__lifeTimeRemaining / A.lifeTime, 100, 0.3)
				if not H and IsValid(self) then
					self:Destroy()
				end
				if not H then
					y:RemoveModifierByName("modifier_dash")
				end
			end,
		})
	else
	end
end
function w.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function w.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true, [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
end
w = e(
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
	w
)
return f