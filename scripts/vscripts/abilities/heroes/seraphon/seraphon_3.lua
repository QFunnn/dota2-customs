--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/seraphon/seraphon_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.ability_ai")
local k = j.EOMAbilityAI
local l = require("abilities.eom_ability")
local m = l.registerEOMAbility
local n = c()
n.name = "seraphon_3"
d(n, k)
function n.prototype.GetCastCooldown(self)
	return self:GetSpecialValueFor("duration")
end
function n.prototype.GetCooldown(self, o)
	return math.max(k.prototype.GetCooldown(self, o) - self:GetSpecialValueFor("cooldown_reduction"), 0)
end
function n.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	local q = self:GetSpecialValueFor("duration")
	p:AddNewModifier(p, self, "modifier_seraphon_3", { duration = self:GetSpecialValueFor("duration") })
	if p:HasAbilityUpgrade("seraphon_upgrade_14") then
		local r = p:GetAbilityByTag(AbilityTag.Skill)
		if IsValid(r) then
			r:RingHammer(self:GetSpecialValueFor("ring_count"), q)
		end
	end
	p:StartGesture(ACT_DOTA_CAST_ABILITY_3)
	p:EmitSound("Hero_Mars.Shield.Block")
end
function n.prototype.Bash(self, s)
	local p = self:GetCaster()
	if p:HasAbilityUpgrade("seraphon_upgrade_32") then
		Bullet:SplitAction(s, 4, 90, function(t, u)
			self:BashSingle(u)
		end)
		return
	end
	self:BashSingle(s)
end
function n.prototype.BashSingle(self, s)
	local p = self:GetCaster()
	local v = p:GetAbsOrigin()
	local w = self:GetSpecialValueFor("damage")
	local x = p:Script_GetAttackRange()
	local y = 140
	local z =
		ParticleManager:CreateParticle("particles/mushi_fx/mushi_fx_fangyu_fanji_01.vpcf", PATTACH_CUSTOMORIGIN, p)
	ParticleManager:SetParticleControlEnt(z, 0, p, PATTACH_ABSORIGIN_FOLLOW, nil, p:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlTransformForward(z, 1, v, s)
	local A = FindEnemiesInTruncatedSector(p, v - s * 300, 300, x + 300, s, y * 0.4)
	for B, C in ipairs(A) do
		local z = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlTransformForward(z, 0, C:GetAbsOrigin(), CalcDirection(C, p))
		p:DealDamage(C, self, w, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE)
	end
	p:EmitSound("Hero_DragonKnight.DragonTail.DragonFormCast")
end
function n.prototype.Purify(self)
	local p = self:GetCaster()
	local x = PURIFY_RADIUS * (1 + GetAoeAmplify(p) * 0.01)
	local z = ParticleManager:CreateParticle(
		"particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_ti6_immortal.vpcf",
		PATTACH_ABSORIGIN,
		p
	)
	ParticleManager:SetParticleControl(z, 1, Vector(x, 0, 0))
	p:EmitSound("Hero_Omniknight.HammerOfPurity.Target")
	local A = FindEnemiesInRadius(p, p:GetAbsOrigin(), x)
	p:DealDamage(A, self, PURIFY_DAMAGE, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
	p:EmitSound("Greevil.Purification")
	local D = self:GetSpecialValueFor("purify_shield")
	if D > 0 then
		p:AddShield(D, "purify_shield", "override", "permanent")
	end
end
function n.prototype.StaticProperty(self)
	return { [PropertyFunction.HEALTH_AMPLIFY] = self:GetStackCount() * self:GetSpecialValueFor("hp_pct_per_stack") }
end
n = e({ m(nil, {
	funcCondition = function(t, E)
		return E:GetAutoCastState()
	end,
}) }, n)
local F = c()
F.name = "modifier_seraphon_3"
d(F, h)
function F.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enableTime = GameRules:GetGameTime()
end
function F.prototype.GetAbilitySpecialValue(self)
	self.hp_max_stack = self:GetAbilitySpecialValueFor("hp_max_stack")
	self.reduce_damage = self:GetAbilitySpecialValueFor("reduce_damage")
	self.shield = self:GetAbilitySpecialValueFor("shield")
	self.interval = self:GetAbilitySpecialValueFor("interval")
end
function F.prototype.OnCreated(self, G)
	local H = self:GetParent()
	if IsServer() then
		H:AddShield(self.shield, "modifier_seraphon_3", "override")
		self:GetAbility():SetFrozenCooldown(true)
		if self.interval > 0 then
			self:StartIntervalThink(self.interval)
		end
		local z = ParticleManager:CreateParticle("particles/mushi_fx/mushi_fx_hudun_01.vpcf", PATTACH_CENTER_FOLLOW, H)
		ParticleManager:SetParticleControlEnt(z, 7, H.__weapon, PATTACH_ABSORIGIN, nil, vec3_zero, true)
		self:AddParticle(z, false, false, -1, false, false)
		if H:HasAbilityUpgrade("seraphon_upgrade_34") then
			self:StartThink(0, "seraphon_upgrade_34", function()
				local I = Bullet:GetBulletInRadius(H:GetAbsOrigin(), 100)
				H:ShootDown(I)
			end)
		end
	end
end
function F.prototype.OnDestroy(self)
	if IsServer() then
		self:GetAbility():SetFrozenCooldown(false)
		local H = self:GetParent()
		local E = self:GetAbility()
		if H:HasAbilityUpgrade("seraphon_upgrade_22") then
			E:Purify()
		end
		H:RemoveShield("modifier_seraphon_3")
	end
end
function F.prototype.OnIntervalThink(self)
	local E = self:GetAbility()
	E:Bash(self:GetParent():GetForwardVector())
end
function F.prototype.StaticProperty(self)
	return { [PropertyFunction.DAMAGE_REDUCTION] = self.reduce_damage }
end
function F.prototype.EventListener(self)
	return {
		damage_event = function(t, J)
			local H = self:GetParent()
			local E = self:GetAbility()
			if self.enableTime > GameRules:GetGameTime() then
				return
			end
			if J.target == H then
				self.enableTime = GameRules:GetGameTime() + COUNTER_CD
				if AbilityUpgrade:HasAbilityUpgrade(H, "seraphon_upgrade_13") then
					local K = H:GetAbilityByTag(AbilityTag.Ultimate)
					if IsValid(K) then
						K:Punishment(J.attacker)
					end
				end
				E:Bash(CalcDirection2D(J.attacker, H))
				if self.hp_max_stack > 0 and E:GetStackCount() < self.hp_max_stack then
					E:IncrementStackCount()
				end
			end
		end,
	}
end
function F.prototype.StaticState(self)
	return {
		[StateEnum.STUN_IMMUNE] = true,
		[StateEnum.KNOCKBACK_IMMUNE] = true,
		[StateEnum.DODGE_BULLET] = self:GetParent():HasAbilityUpgrade("seraphon_upgrade_34"),
	}
end
function F.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function F.prototype.GetActivityTranslationModifiers(self)
	return "seraphon_3"
end
function F.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_3
end
function F.prototype.GetModifierDisableTurning(self)
	return 1
end
function F.prototype.CheckState(self)
	return {}
end
F = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	F
)
return f