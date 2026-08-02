--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_chaos_custom"
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
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["18"] = 15,
		["21"] = 12,
		["22"] = 21,
		["23"] = 22,
		["24"] = 23,
		["25"] = 24,
		["27"] = 21,
		["28"] = 27,
		["29"] = 28,
		["30"] = 29,
		["31"] = 29,
		["32"] = 28,
		["33"] = 27,
		["34"] = 32,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["42"] = 40,
		["43"] = 41,
		["44"] = 42,
		["45"] = 43,
		["46"] = 44,
		["47"] = 45,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 50,
		["54"] = 50,
		["55"] = 50,
		["56"] = 50,
		["57"] = 55,
		["58"] = 56,
		["60"] = 57,
		["61"] = 57,
		["62"] = 58,
		["63"] = 57,
		["67"] = 50,
		["68"] = 50,
		["69"] = 63,
		["70"] = 64,
		["71"] = 64,
		["72"] = 64,
		["73"] = 64,
		["74"] = 64,
		["75"] = 64,
		["76"] = 64,
		["77"] = 64,
		["78"] = 64,
		["79"] = 65,
		["80"] = 65,
		["81"] = 65,
		["82"] = 65,
		["83"] = 65,
		["84"] = 66,
		["85"] = 67,
		["86"] = 68,
		["89"] = 32,
		["90"] = 11,
		["91"] = 3,
		["92"] = 3,
		["93"] = 3,
		["94"] = 3,
		["95"] = 3,
		["96"] = 3,
		["97"] = 3,
		["98"] = 3,
		["99"] = 11,
		["101"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_chaos_custom = c()
local k = g.modifier_chaos_custom
k.name = "modifier_chaos_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(l.iStackCount)
		self:TriggerChaos()
	else
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount(l.iStackCount)
		self:TriggerChaos()
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function k.prototype.TriggerChaos(self)
	local m = self:GetCaster()
	local n = m:GetEnemy()
	local o = self:GetStackCount()
	local p = 0
	if m:HasModifier("modifier_chaos_permanent") then
		p = p + m:FindModifierByName("modifier_chaos_permanent"):GetStackCount()
	end
	local q = o + p
	if q >= CHAOS_THRESHOLD then
		local r = 0
		while o + p >= CHAOS_THRESHOLD do
			r = r + 1
			o = o - math.max(0, CHAOS_THRESHOLD - p)
		end
		if r > 0 and IsInjurable(m, n) then
			local s = CHAOS_DAMAGE
				+ GetModifierProperty(m, EOMModifierFunction.EOM_MODIFIER_PROPERTY_CHAOS_POINT_DAMAGE_BONUS)
			local t = m:FindAbilityByName("sect_chaos")
			Projectile:CreateTrackingProjectile({
				hCaster = m,
				vSpawnOrigin = m:GetAbsOrigin(),
				hTarget = n,
				iMoveSpeed = PROJECTILE_SPEED_FAST,
				OnProjectileHit = function(u, v, w)
					if IsValid(self) and IsInjurable(u) then
						do
							local x = 0
							while x < r do
								m:DealChaosDamage(n, t, s)
								x = x + 1
							end
						end
					end
				end,
			})
			local y = ParticleManager:CreateParticle("particles/gameplay/sect_chaos_dmg.vpcf", PATTACH_CUSTOMORIGIN, m)
			ParticleManager:SetParticleControlEnt(
				y,
				0,
				n,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				n:GetAbsOrigin() + Vector(0, 0, 16),
				true
			)
			ParticleManager:SetParticleControl(y, 1, m:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(y)
			n:EmitSound("Hero_Oracle.FortunesEnd.Attack")
			self:SetStackCount(o)
		end
	end
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = true,
				IsPurgeException = true,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_chaos_custom = k
return g