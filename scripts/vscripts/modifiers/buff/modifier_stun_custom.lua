--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_stun_custom"
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
		["12"] = 4,
		["13"] = 13,
		["14"] = 4,
		["15"] = 13,
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["19"] = 17,
		["21"] = 19,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 24,
		["28"] = 24,
		["29"] = 24,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["33"] = 24,
		["36"] = 14,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 30,
		["41"] = 31,
		["43"] = 33,
		["45"] = 28,
		["46"] = 36,
		["47"] = 37,
		["48"] = 38,
		["49"] = 38,
		["50"] = 39,
		["53"] = 36,
		["54"] = 43,
		["55"] = 44,
		["56"] = 43,
		["57"] = 46,
		["58"] = 47,
		["59"] = 46,
		["60"] = 51,
		["61"] = 52,
		["62"] = 51,
		["63"] = 54,
		["64"] = 55,
		["65"] = 54,
		["66"] = 13,
		["67"] = 4,
		["68"] = 4,
		["69"] = 4,
		["70"] = 4,
		["71"] = 4,
		["72"] = 4,
		["73"] = 4,
		["74"] = 4,
		["75"] = 4,
		["76"] = 13,
		["78"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_stun_custom = c()
local k = g.modifier_stun_custom
k.name = "modifier_stun_custom"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		if not self.parent:HasModifier("modifier_state_immunity_custom") then
			CombatLog:recordState(self.parent, self.caster, "Stun", "add")
		end
		self:StartIntervalThink(l.duration)
	else
		if not self.parent:HasModifier("modifier_state_immunity_custom") then
			local m = self:GetParent()
			local n = ParticleManager:CreateParticle(
				"particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_stunned.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				m
			)
			self:AddParticle(n, false, false, -1, false, true)
		end
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		local o = self.parent
		if not (o and o:HasModifier("modifier_state_immunity_custom")) then
			CombatLog:recordState(self.parent, self.caster, "Stun", "add")
		end
		self:StartIntervalThink(l.duration)
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		local p = self.parent
		if not (p and p:HasModifier("modifier_state_immunity_custom")) then
			CombatLog:recordState(self.parent, nil, "Stun", "loss")
		end
	end
end
function k.prototype.OnIntervalThink(self)
	self:Destroy()
end
function k.prototype.DeclareFunctions(self)
	return {}
end
function k.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DISABLED
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_PASSIVES_DISABLED] = true, [MODIFIER_STATE_DISARMED] = true }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				DestroyOnExpire = false,
			}
		),
	},
	k
)
g.modifier_stun_custom = k
return g