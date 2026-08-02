--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/consumables_6"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["23"] = 12,
		["25"] = 8,
		["26"] = 15,
		["27"] = 16,
		["28"] = 15,
		["29"] = 18,
		["30"] = 19,
		["31"] = 18,
		["32"] = 21,
		["33"] = 22,
		["34"] = 23,
		["35"] = 24,
		["38"] = 27,
		["39"] = 28,
		["40"] = 29,
		["41"] = 30,
		["42"] = 21,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["46"] = 39,
		["47"] = 40,
		["49"] = 42,
		["50"] = 42,
		["51"] = 42,
		["52"] = 42,
		["53"] = 42,
		["54"] = 43,
		["55"] = 44,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["59"] = 45,
		["60"] = 45,
		["61"] = 46,
		["62"] = 46,
		["63"] = 46,
		["64"] = 46,
		["65"] = 46,
		["66"] = 47,
		["67"] = 47,
		["68"] = 47,
		["69"] = 47,
		["70"] = 47,
		["71"] = 48,
		["72"] = 49,
		["73"] = 50,
		["74"] = 50,
		["75"] = 50,
		["76"] = 51,
		["79"] = 52,
		["80"] = 53,
		["81"] = 54,
		["82"] = 55,
		["83"] = 56,
		["84"] = 57,
		["85"] = 57,
		["86"] = 57,
		["87"] = 57,
		["88"] = 57,
		["89"] = 57,
		["90"] = 57,
		["91"] = 57,
		["92"] = 57,
		["93"] = 57,
		["94"] = 57,
		["95"] = 58,
		["96"] = 58,
		["97"] = 58,
		["98"] = 59,
		["99"] = 60,
		["100"] = 61,
		["101"] = 62,
		["102"] = 63,
		["103"] = 64,
		["104"] = 65,
		["105"] = 65,
		["106"] = 65,
		["107"] = 65,
		["108"] = 65,
		["109"] = 65,
		["110"] = 65,
		["111"] = 66,
		["113"] = 58,
		["114"] = 58,
		["115"] = 71,
		["117"] = 73,
		["118"] = 74,
		["121"] = 50,
		["122"] = 50,
		["123"] = 36,
		["124"] = 5,
		["125"] = 4,
		["126"] = 5,
		["128"] = 5,
		["129"] = 80,
		["130"] = 88,
		["131"] = 80,
		["132"] = 88,
		["134"] = 88,
		["135"] = 89,
		["136"] = 80,
		["137"] = 91,
		["138"] = 92,
		["139"] = 93,
		["141"] = 91,
		["142"] = 96,
		["143"] = 97,
		["144"] = 98,
		["145"] = 98,
		["146"] = 97,
		["147"] = 96,
		["148"] = 101,
		["149"] = 102,
		["150"] = 103,
		["151"] = 104,
		["152"] = 105,
		["153"] = 106,
		["154"] = 107,
		["155"] = 108,
		["156"] = 108,
		["157"] = 108,
		["158"] = 108,
		["159"] = 108,
		["161"] = 110,
		["164"] = 101,
		["165"] = 114,
		["166"] = 115,
		["167"] = 116,
		["169"] = 114,
		["170"] = 88,
		["171"] = 80,
		["172"] = 80,
		["173"] = 80,
		["174"] = 80,
		["175"] = 80,
		["176"] = 80,
		["177"] = 80,
		["178"] = 80,
		["179"] = 88,
		["181"] = 88,
		["182"] = 180,
		["183"] = 188,
		["184"] = 180,
		["185"] = 188,
		["186"] = 189,
		["187"] = 190,
		["188"] = 191,
		["189"] = 191,
		["190"] = 191,
		["191"] = 191,
		["192"] = 191,
		["193"] = 192,
		["194"] = 192,
		["195"] = 192,
		["196"] = 192,
		["197"] = 192,
		["198"] = 192,
		["199"] = 192,
		["200"] = 192,
		["201"] = 192,
		["202"] = 193,
		["203"] = 193,
		["204"] = 193,
		["205"] = 193,
		["206"] = 193,
		["207"] = 193,
		["208"] = 193,
		["209"] = 193,
		["210"] = 193,
		["211"] = 194,
		["212"] = 194,
		["213"] = 194,
		["214"] = 194,
		["215"] = 194,
		["216"] = 194,
		["217"] = 194,
		["218"] = 194,
		["220"] = 189,
		["221"] = 197,
		["222"] = 198,
		["223"] = 199,
		["224"] = 199,
		["225"] = 199,
		["226"] = 199,
		["227"] = 199,
		["228"] = 200,
		["230"] = 197,
		["231"] = 203,
		["232"] = 204,
		["233"] = 203,
		["234"] = 208,
		["235"] = 209,
		["236"] = 208,
		["237"] = 211,
		["238"] = 212,
		["239"] = 211,
		["240"] = 188,
		["241"] = 180,
		["242"] = 180,
		["243"] = 180,
		["244"] = 180,
		["245"] = 180,
		["246"] = 180,
		["247"] = 180,
		["248"] = 180,
		["249"] = 188,
		["251"] = 188,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.consumables_6 = c()
local o = h.consumables_6
o.name = "consumables_6"
d(o, j)
function o.prototype.GetBehavior(self)
	if self:GetCaster():HasModifier("modifier_consumables_6_cast") then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_ITEM
	else
		return DOTA_ABILITY_BEHAVIOR_POINT
			+ DOTA_ABILITY_BEHAVIOR_AOE
			+ DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
			+ DOTA_ABILITY_BEHAVIOR_ITEM
	end
end
function o.prototype.GetCastRange(self, p, q)
	return 500
end
function o.prototype.GetAOERadius(self)
	return 150
end
function o.prototype.OnSpellStart(self)
	local r = self:GetCaster()
	if r:HasModifier("modifier_consumables_6_cast") then
		r:RemoveModifierByName("modifier_consumables_6_cast")
		return
	end
	self.count = 0
	self.vCastPotition = self:GetCursorPosition()
	self:Firework()
	r:AddNewModifier(r, self, "modifier_consumables_6_cast", {})
end
function o.prototype.Firework(self)
	local r = self:GetCaster()
	self.count = self.count + 1
	if self.count == 8 then
		self.count = 0
	end
	local s =
		RotatePosition(self.vCastPotition, QAngle(0, 360 / 8 * self.count, 0), self.vCastPotition + Vector(150, 0, 0))
	local t = self:GetSpecialValueFor("knock_distance")
	local u = ParticleManager:CreateParticle(
		"models/eom/props/firecracker_01/particle/firecracker_01_fx.vpcf",
		PATTACH_CUSTOMORIGIN,
		r
	)
	ParticleManager:SetParticleControl(u, 0, GetGroundPosition(s, nil))
	ParticleManager:SetParticleControl(u, 2, GetGroundPosition(s, nil))
	ParticleManager:SetParticleControl(u, 3, GetGroundPosition(s, nil))
	ParticleManager:ReleaseParticleIndex(u)
	local v = false
	GameTimer(0.85, function()
		if not IsValid(self) then
			return
		end
		if not v then
			v = true
			local w = 0.4
			local x = 150
			EmitSoundOnLocationWithCaster(s, "ParticleDriven.Rocket.Launch", r)
			local y = FindUnitsInRadius(
				DOTA_TEAM_GOODGUYS,
				s,
				nil,
				x,
				DOTA_UNIT_TARGET_TEAM_BOTH,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
				FIND_ANY_ORDER,
				true
			)
			e(y, function(z, A)
				if A:HasModifier("modifier_courier") then
					local B = A:GetAbsOrigin()
					local C = B - s
					local D = t - C:Length2D()
					C.z = 0
					C = C:Normalized()
					A:KnockBack(C, D, 100, w, true)
					A:AddNewModifier(r, self, "modifier_consumables_6_knockback", { duration = w })
				end
			end)
			return 0.4
		else
			if IsValid(r) then
				EmitSoundOnLocationWithCaster(s, "ParticleDriven.Rocket.Explode", r)
			end
		end
	end)
end
o = f({ k(nil) }, o)
h.consumables_6 = o
h.modifier_consumables_6_cast = c()
local E = h.modifier_consumables_6_cast
E.name = "modifier_consumables_6_cast"
d(E, m)
function E.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.interval = 0.25
end
function E.prototype.OnCreated(self, F)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function E.prototype.EDeclareEvents(self)
	return { [MODIFIER_EVENT_ON_ORDER] = { self:GetParent(), -1 } }
end
function E.prototype.OnIntervalThink(self)
	if IsServer() then
		local G = self:GetAbility()
		local H = G:GetCurrentAbilityCharges()
		if H > 0 then
			G:Firework()
			G:SetCurrentAbilityCharges(H - 1)
			FireModifierEvent(MODIFIER_EVENT_ON_ABILITY_EXECUTED, { ability = G }, self:GetParent())
		else
			self:Destroy()
		end
	end
end
function E.prototype.OnOrder(self, I)
	if
		I.order_type == DOTA_UNIT_ORDER_STOP
		or I.order_type == DOTA_UNIT_ORDER_CONTINUE
		or I.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION
		or I.order_type == DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:Destroy()
	end
end
E = f(
	{
		n(
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
	E
)
h.modifier_consumables_6_cast = E
h.modifier_consumables_6_knockback = c()
local J = h.modifier_consumables_6_knockback
J.name = "modifier_consumables_6_knockback"
d(J, m)
function J.prototype.OnCreated(self, F)
	if IsClient() then
		local K = ParticleManager:CreateParticle(
			"particles/gameplay/explode_trail.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(K, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, vec3_zero, true)
		ParticleManager:SetParticleControlEnt(
			K,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			vec3_zero,
			true
		)
		self:AddParticle(K, false, false, -1, false, false)
	end
end
function J.prototype.OnDestroy(self)
	if IsClient() then
		local K = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_remote_cart_jump.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
		ParticleManager:ReleaseParticleIndex(K)
	end
end
function J.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function J.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function J.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
J = f(
	{
		n(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	J
)
h.modifier_consumables_6_knockback = J
return h