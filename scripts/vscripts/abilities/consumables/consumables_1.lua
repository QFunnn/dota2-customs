--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/consumables_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 5,
		["15"] = 10,
		["16"] = 11,
		["17"] = 10,
		["18"] = 11,
		["19"] = 13,
		["20"] = 14,
		["21"] = 15,
		["23"] = 17,
		["25"] = 13,
		["26"] = 20,
		["27"] = 21,
		["28"] = 22,
		["29"] = 23,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["35"] = 29,
		["36"] = 20,
		["37"] = 31,
		["38"] = 32,
		["39"] = 31,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["49"] = 34,
		["50"] = 45,
		["51"] = 46,
		["52"] = 45,
		["53"] = 48,
		["54"] = 49,
		["55"] = 50,
		["56"] = 51,
		["57"] = 52,
		["58"] = 53,
		["61"] = 56,
		["62"] = 57,
		["63"] = 57,
		["64"] = 57,
		["65"] = 57,
		["66"] = 57,
		["67"] = 57,
		["68"] = 63,
		["69"] = 64,
		["70"] = 65,
		["71"] = 66,
		["72"] = 67,
		["73"] = 68,
		["76"] = 71,
		["77"] = 72,
		["79"] = 57,
		["80"] = 57,
		["81"] = 48,
		["82"] = 11,
		["83"] = 10,
		["84"] = 11,
		["86"] = 11,
		["87"] = 79,
		["88"] = 88,
		["89"] = 79,
		["90"] = 88,
		["91"] = 90,
		["92"] = 91,
		["93"] = 90,
		["94"] = 93,
		["95"] = 94,
		["96"] = 95,
		["98"] = 93,
		["99"] = 98,
		["100"] = 99,
		["101"] = 100,
		["103"] = 98,
		["104"] = 103,
		["105"] = 104,
		["106"] = 103,
		["107"] = 108,
		["108"] = 109,
		["109"] = 108,
		["110"] = 88,
		["111"] = 79,
		["112"] = 79,
		["113"] = 79,
		["114"] = 79,
		["115"] = 79,
		["116"] = 79,
		["117"] = 79,
		["118"] = 79,
		["119"] = 79,
		["120"] = 88,
		["122"] = 88,
		["123"] = 112,
		["124"] = 120,
		["125"] = 112,
		["126"] = 120,
		["128"] = 120,
		["129"] = 121,
		["130"] = 112,
		["131"] = 123,
		["132"] = 124,
		["133"] = 125,
		["135"] = 123,
		["136"] = 128,
		["137"] = 129,
		["138"] = 130,
		["139"] = 130,
		["140"] = 129,
		["141"] = 128,
		["142"] = 133,
		["143"] = 134,
		["144"] = 135,
		["145"] = 136,
		["146"] = 137,
		["147"] = 138,
		["148"] = 139,
		["149"] = 140,
		["150"] = 140,
		["151"] = 140,
		["152"] = 140,
		["153"] = 140,
		["155"] = 142,
		["158"] = 133,
		["159"] = 146,
		["160"] = 147,
		["161"] = 148,
		["163"] = 146,
		["164"] = 120,
		["165"] = 112,
		["166"] = 112,
		["167"] = 112,
		["168"] = 112,
		["169"] = 112,
		["170"] = 112,
		["171"] = 112,
		["172"] = 112,
		["173"] = 120,
		["175"] = 120,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = { "cast_error_christmas_tree_end1", "cast_error_christmas_tree_end2", "cast_error_christmas_tree_end3" }
g.consumables_1 = c()
local o = g.consumables_1
o.name = "consumables_1"
d(o, i)
function o.prototype.GetBehavior(self)
	if self:GetCaster():HasModifier("modifier_snow_ball") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_ITEM
	else
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_ITEM
	end
end
function o.prototype.CastFilterResultTarget(self, p)
	if p:GetModifierStackCount("modifier_christmas_tree", p) == 1 then
		self.error = n[RandomInt(0, #n - 1) + 1]
		return UF_FAIL_CUSTOM
	end
	if p == self:GetCaster() then
		self.error = "error_cant_self"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastErrorTarget(self, p)
	return self.error
end
function o.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	if q:HasModifier("modifier_snow_ball") then
		q:RemoveModifierByName("modifier_snow_ball")
		return
	end
	self.target = self:GetCursorTarget()
	self:Throw()
	q:AddNewModifier(q, self, "modifier_snow_ball", {})
end
function o.prototype.GetTarget(self)
	return self.target
end
function o.prototype.Throw(self)
	local r = self:GetSpecialValueFor("speed")
	local s = self:GetSpecialValueFor("duration")
	local q = self:GetCaster()
	if (self.target:GetAbsOrigin() - q:GetAbsOrigin()):Length2D() >= 2500 or not IsValid(self.target) then
		q:RemoveModifierByName("modifier_snow_ball")
		return
	end
	q:EmitSound("Hero_ChaosKnight.idle_throw")
	Projectile:CreateTrackingProjectile({
		EffectName = "particles/econ/events/snowball/snowball_projectile.vpcf",
		hCaster = q,
		vSpawnOrigin = q:GetAbsOrigin(),
		hTarget = self.target,
		iMoveSpeed = r,
		OnProjectileHit = function(t, u, v)
			if t:HasModifier("modifier_christmas_tree") then
				local w = t:FindModifierByName("modifier_christmas_tree")
				w:SnowBall()
				if w:GetStackCount() == 1 then
					q:RemoveModifierByName("modifier_snow_ball")
				end
			else
				t:AddNewModifier(q, self, "modifier_consumables_1", { duration = s })
				q:EmitSound("FrostivusConsumable.Snowball.Target")
			end
		end,
	})
end
o = e({ j(nil) }, o)
g.consumables_1 = o
g.modifier_consumables_1 = c()
local x = g.modifier_consumables_1
x.name = "modifier_consumables_1"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.slow = self:GetAbilitySpecialValueFor("slow")
end
function x.prototype.OnCreated(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function x.prototype.OnRefresh(self, y)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function x.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function x.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return -self:GetStackCount() * self.slow
end
x = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	x
)
g.modifier_consumables_1 = x
g.modifier_snow_ball = c()
local z = g.modifier_snow_ball
z.name = "modifier_snow_ball"
d(z, l)
function z.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.interval = 0.25
end
function z.prototype.OnCreated(self, y)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function z.prototype.EDeclareEvents(self)
	return { [MODIFIER_EVENT_ON_ORDER] = { self:GetParent(), -1 } }
end
function z.prototype.OnIntervalThink(self)
	if IsServer() then
		local A = self:GetAbility()
		local B = A:GetCurrentAbilityCharges()
		if B > 0 and IsValid(A:GetTarget()) then
			A:Throw()
			A:SetCurrentAbilityCharges(B - 1)
			FireModifierEvent(MODIFIER_EVENT_ON_ABILITY_EXECUTED, { ability = A }, self:GetParent())
		else
			self:Destroy()
		end
	end
end
function z.prototype.OnOrder(self, C)
	if
		C.order_type == DOTA_UNIT_ORDER_STOP
		or C.order_type == DOTA_UNIT_ORDER_CONTINUE
		or C.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION
	then
		self:Destroy()
	end
end
z = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	z
)
g.modifier_snow_ball = z
return g