--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_land_mines"
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
n.name = "enemy_land_mines"
d(n, k)
function n.prototype.OnAbilityPhaseStart(self)
	local o = self:GetCaster()
	self.position = o:GetAbsOrigin() + RandomVector(RandomInt(50, self:GetEffectiveCastRange(vec3_invalid, nil)))
	o:FaceTowards(self.position)
	return true
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = self:GetSpecialValueFor("self_bomb_time")
	local q =
		CreateUnitByName("techies_land_mines", GetGroundPosition(self.position, o), false, o, o, o:GetTeamNumber())
	if IsValid(q) then
		q:AddNewModifier(o, self, "modifier_enemy_land_mines", { duration = p })
	end
end
n = e({ m(nil) }, n)
local r = c()
r.name = "modifier_enemy_land_mines"
d(r, h)
function r.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.search_tick = 0.25
end
function r.prototype.CheckState(self)
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
function r.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function r.prototype.GetAbilitySpecialValue(self)
	self.proximity_threshold = self:GetAbilitySpecialValueFor("proximity_threshold")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.warning_time = self:GetAbilitySpecialValueFor("warning_time")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		self:StartIntervalThink(self.proximity_threshold)
		self.parent:EmitSound("Hero_Techies.RemoteMine.Plant")
	else
		local t = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_land_mine.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		self:AddParticle(t, false, false, -1, false, false)
	end
end
function r.prototype.OnIntervalThink(self)
	if IsServer() then
		if not IsValid(self.caster) or not IsValid(self.ability) then
			self:Destroy()
			return
		end
		local u = self:GetStackCount()
		if u == 0 then
			self:IncrementStackCount()
			self:StartIntervalThink(self.search_tick)
		elseif u == 1 then
			local v = self.parent:GetAbsOrigin()
			local w = FindUnitsInRadiusWithAbility(self.parent, v, self.radius, self.ability)
			if #w > 0 then
				self.parent:EmitSound("Hero_Techies.RemoteMine.Priming")
				self:Destroy()
			end
		end
	end
end
function r.prototype.OnDestroy(self)
	if IsServer() and IsValid(self.parent) then
		if IsValid(self.caster) and IsValid(self.ability) then
			self.parent:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_enemy_land_mines_explode",
				{ duration = self.warning_time }
			)
		else
			self.parent:Remove()
		end
	end
end
r = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
local x = c()
x.name = "modifier_enemy_land_mines_explode"
d(x, h)
function x.prototype.CheckState(self)
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
function x.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function x.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.warning_time = self:GetAbilitySpecialValueFor("warning_time")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function x.prototype.OnCreated(self, s)
	if IsServer() then
		local v = self.parent:GetAbsOrigin()
		local t = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, self.parent)
		ParticleManager:SetParticleControl(t, 0, v)
		ParticleManager:SetParticleControl(t, 1, v)
		ParticleManager:SetParticleControl(t, 2, Vector(self.radius, self.warning_time, 0))
		self:AddParticle(t, false, false, -1, false, false)
		self:StartIntervalThink(self.warning_time)
		self.parent:StartGesture(ACT_DOTA_SPAWN)
	end
end
function x.prototype.OnDestroy(self)
	if IsServer() then
		if IsValid(self.caster) and IsValid(self.ability) then
			local v = self.parent:GetAbsOrigin()
			local w = FindUnitsInRadiusWithAbility(self.parent, v, self.radius, self.ability)
			self.caster:DealDamage(w, self.ability, self.damage)
			local t = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(t, 0, v)
			ParticleManager:SetParticleControl(t, 1, Vector(0, 0, self.radius))
			ParticleManager:ReleaseParticleIndex(t)
			EmitSoundOnLocationWithCaster(v, "Hero_Techies.RemoteMine.Detonate", self.caster)
		end
		self.parent:Remove()
	end
end
x = e(
	{ i(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	x
)
return f