--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_bomb"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.bt_ability_ai")
local k = j.EOMBTAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "enemy_bomb"
d(n, k)
function n.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = self:GetCursorPosition()
	local q = o:GetAbsOrigin()
	local r = CalcDistance(p, q)
	local s = CalcDirection(p, q)
	local t = self:GetSpecialValueFor("duration")
	local u = self:GetSpecialValueFor("speed")
	local v =
		CreateUnitByName("techies_bomb", o:GetAttachmentPosition("attach_attack1") or q, false, o, o, o:GetTeamNumber())
	if IsValid(v) then
		local w = v:AddNewModifier(o, self, "modifier_enemy_bomb_unit", { duration = t + r / u + 1 })
		v:RemoveModifierByName("modifier_common")
		v:RemoveActivityModifier("loadout")
		v:SetForwardVector(s)
		v:StartGesture(ACT_DOTA_SPAWN)
		v:Dash(s, r, 350, r / u, function()
			if not IsValid(v) then
				return
			end
			local x = v:GetAbsOrigin()
			local y = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_techies/techies_remote_cart_jump.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(y, 0, x)
			v:EmitSound("Hero_Techies.StickyBomb.Plant")
			v:StartGesture(ACT_DOTA_LOADOUT)
			self:CreateRadiusWarningParticle(x, t)
			o:GameTimer(t, function()
				self:DestroyWarningParticle()
				if not IsValid(v) then
					return
				end
				if not IsValid(o) or not o:IsAlive() then
					if w ~= nil then
						w:Destroy()
					end
					return
				end
				v:StartGesture(ACT_DOTA_ATTACK)
				local z = self:GetAOERadius()
				local y = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_techies/techies_remote_cart_explode.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(y, 0, x)
				ParticleManager:SetParticleControl(y, 1, Vector(z, z, z))
				ParticleManager:ReleaseParticleIndex(y)
				EmitSoundOnLocationWithCaster(x, "Hero_Techies.StickyBomb.Detonate", o)
				local A = FindUnitsInRadiusWithAbility(o, x, z, self)
				o:DealDamage(A, self, self:GetSpecialValueFor("damage"))
				if w ~= nil then
					w:Destroy()
				end
			end)
		end)
		o:EmitSound("Hero_Techies.StickyBomb.Cast")
	end
end
n = e({ m(nil) }, n)
local B = c()
B.name = "modifier_enemy_bomb_unit"
d(B, h)
function B.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function B.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function B.prototype.OnDestroy(self)
	if IsServer() then
		self.parent:AddNoDraw()
		self.parent:ForceKill(false)
	end
end
B = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	B
)
return f