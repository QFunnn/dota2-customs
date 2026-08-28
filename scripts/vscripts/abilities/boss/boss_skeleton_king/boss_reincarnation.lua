--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_reincarnation"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__Number
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.eom_ability")
local l = k.EOMAbility
local m = k.registerEOMAbility
local n = c()
n.name = "boss_reincarnation"
d(n, l)
function n.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = true
end
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	self:CircleWarning(o:GetAbsOrigin(), 1200, self:GetCastPoint())
	local p = ParticleManager:CreateParticle(
		"particles/units/boss/boss_skeleton_king/reincarnation_channel.vpcf",
		PATTACH_ABSORIGIN,
		o
	)
	ParticleManager:SetParticleControl(p, 2, Vector(800, 0, 0))
	o:EmitSound("Hero_Kez.RaptorDance.Katana.Cast")
	return true
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	o:SimulateCast({ castAnimation = ACT_DOTA_VICTORY, duration = 1.23 })
	o:EmitSound("Hero_Huskar.Inner_Fire.Cast")
	local q = self:GetSpecialValueFor("damage")
	Bullet:CreateRingBullet({
		caster = o,
		spawnOrigin = o:GetAbsOrigin(),
		lifeTime = 1.45,
		width = 100,
		moveSpeed = 1000,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		ParticleCreator = function(r)
			local p = ParticleManager:CreateParticle(
				"particles/units/boss/boss_skeleton_king/aoe_wave.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(p, 0, o:GetAbsOrigin())
			return p
		end,
		OnBulletHit = function(s, r, t)
			o:DealDamage(s, self, q, nil)
		end,
	})
end
function n.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.MIN_HEALTH] = function(u, v)
			if self.enable then
				return 1
			end
		end,
	}
end
function n.prototype.EventListener(self)
	return {
		damage_event = function(u, v)
			if self.enable and v.target == self:GetCaster() and v.target:GetHealth() == 1 then
				self.enable = false
				self:EndCooldown()
				self:StartCooldown(20)
				v.target:SimulateCast({ duration = 4 })
				v.target:AddNewModifier(v.attacker, self, "modifier_boss_reincarnation", { duration = 2.97 })
			end
		end,
	}
end
n = e({ m(nil) }, n)
local w = c()
w.name = "modifier_boss_reincarnation"
d(w, i)
function w.prototype.OnCreated(self, v)
	if IsServer() then
		local x = self:GetParent()
		local y = ParticleManager:CreateParticle(
			"particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_reincarn_style2.vpcf",
			PATTACH_ABSORIGIN,
			x
		)
		self:AddParticle(y, false, false, -1, false, false)
		local z = ParticleManager:CreateParticle(
			"particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_style2_reincarn_tombstone.vpcf",
			PATTACH_ABSORIGIN,
			x
		)
		self:AddParticle(z, false, false, -1, false, false)
		x:EmitSound("Hero_SkeletonKing.Reincarnate.Arcana")
		x:EmitSound("skeleton_king_skel_arc_anger_05")
		x:StartGesture(ACT_DOTA_DIE_SPECIAL)
		x:Heal(x:GetMaxHealth(), self:GetAbility())
		local A = self:GetAbility()
		if IsValid(A) then
			A:CircleWarning(x:GetAbsOrigin(), 800, self:GetDuration())
		end
	end
end
function w.prototype.OnDestroy(self)
	if IsServer() then
		local x = self:GetParent()
		x:StartGesture(ACT_DOTA_VICTORY)
		local p = ParticleManager:CreateParticle(
			"particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_toast.vpcf",
			PATTACH_ABSORIGIN,
			x
		)
		self:AddParticle(p, false, false, -1, false, false)
		x:RemoveModifierByName("modifier_boss_reincarnation_buff")
		x:AddNewModifier(x, nil, "modifier_boss_reincarnation_buff", {})
		local A = self:GetAbility()
		if IsValid(A) then
			A:OnSpellStart()
		end
	end
end
function w.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function w.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_STUNNED] = true }
end
w = e(
	{ j(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	w
)
local B = c()
B.name = "modifier_boss_reincarnation_buff"
d(B, i)
function B.prototype.OnCreated(self, v)
	if IsServer() then
		local x = self:GetParent()
		do
			local C = 0
			while C < 16 do
				local A = x:GetAbilityByIndex(C)
				if IsValid(A) then
					A:SetLevel(2)
				end
				C = C + 1
			end
		end
		local p = ParticleManager:CreateParticle(
			"particles/units/boss/boss_skeleton_king/wk_arcstyle_ambient.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			x
		)
		ParticleManager:SetParticleControlEnt(p, 1, x, PATTACH_POINT_FOLLOW, "attach_eye_l_fx", x:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(p, 2, x, PATTACH_POINT_FOLLOW, "attach_eye_r_fx", x:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(p, 3, x, PATTACH_POINT_FOLLOW, "attach_core_fx", x:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(p, 4, x, PATTACH_POINT_FOLLOW, "attach_head_fx", x:GetAbsOrigin(), true)
		self:AddParticle(p, false, false, -1, false, false)
		x:SetMaterialGroup("1")
	end
end
function B.prototype.StaticProperty(self)
	return { [PropertyFunction.HEALTH] = f(-KeyValues.units[self:GetParent():GetUnitName()].StatusHealth) * 0.5 }
end
B = e(
	{ j(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	B
)
return g