--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_152"
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
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 31,
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["61"] = 38,
		["62"] = 43,
		["63"] = 44,
		["64"] = 31,
		["65"] = 45,
		["66"] = 46,
		["67"] = 47,
		["68"] = 45,
		["69"] = 49,
		["70"] = 50,
		["71"] = 49,
		["72"] = 55,
		["73"] = 56,
		["74"] = 57,
		["75"] = 58,
		["76"] = 59,
		["77"] = 60,
		["78"] = 61,
		["79"] = 62,
		["81"] = 63,
		["82"] = 63,
		["83"] = 64,
		["84"] = 64,
		["85"] = 64,
		["86"] = 64,
		["87"] = 64,
		["88"] = 64,
		["89"] = 64,
		["90"] = 64,
		["91"] = 64,
		["92"] = 64,
		["93"] = 64,
		["94"] = 64,
		["95"] = 63,
		["98"] = 66,
		["99"] = 67,
		["100"] = 68,
		["101"] = 68,
		["102"] = 68,
		["103"] = 68,
		["104"] = 68,
		["105"] = 69,
		["106"] = 69,
		["107"] = 69,
		["108"] = 70,
		["109"] = 69,
		["110"] = 69,
		["111"] = 72,
		["112"] = 73,
		["114"] = 55,
		["115"] = 77,
		["116"] = 78,
		["117"] = 79,
		["118"] = 80,
		["121"] = 83,
		["122"] = 84,
		["123"] = 85,
		["124"] = 86,
		["125"] = 86,
		["127"] = 87,
		["128"] = 88,
		["129"] = 89,
		["130"] = 90,
		["131"] = 90,
		["132"] = 90,
		["133"] = 90,
		["134"] = 90,
		["135"] = 93,
		["136"] = 94,
		["137"] = 95,
		["139"] = 97,
		["140"] = 98,
		["141"] = 98,
		["142"] = 98,
		["143"] = 98,
		["144"] = 98,
		["145"] = 98,
		["146"] = 98,
		["147"] = 98,
		["148"] = 98,
		["149"] = 99,
		["150"] = 77,
		["151"] = 38,
		["152"] = 31,
		["153"] = 31,
		["154"] = 31,
		["155"] = 31,
		["156"] = 31,
		["157"] = 31,
		["158"] = 31,
		["159"] = 38,
		["161"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_152 = c()
local n = g.trait_152
n.name = "trait_152"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_152"
end
n = e({ j(nil) }, n)
g.trait_152 = n
g.modifier_trait_152 = c()
local o = g.modifier_trait_152
o.name = "modifier_trait_152"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_152_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_152_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_152 = o
g.modifier_trait_152_buff = c()
local q = g.modifier_trait_152_buff
q.name = "modifier_trait_152_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.tPosition = {}
	self.radius = 400
end
function q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.attack_cnt_max = self:GetAbilitySpecialValueFor("attack_cnt_max")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 } }
end
function q.prototype.OnBattleStart(self, p)
	if IsServer() then
		local r = self.parent:GetPlayerOwnerID()
		local s = PlayerData:getHero(r).hero
		self:SetStackCount(self.attack_cnt_max)
		self.vCenter = s:GetEnemy():GetAbsOrigin()
		self.vInitDirection = self.vCenter + RandomVector(self.radius)
		self.tPosition = {}
		do
			local t = 0
			while t < self:GetStackCount() do
				table.insert(
					self.tPosition,
					RotatePosition(self.vCenter, QAngle(0, t * 360 / self:GetStackCount(), 0), self.vInitDirection)
				)
				t = t + 1
			end
		end
		local u =
			ParticleManager:CreateParticle("particles/sect/sect_attack_139_circle.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(u, 0, self.vCenter)
		ParticleManager:SetParticleControl(u, 1, Vector(self.radius, 1, 1))
		GameTimer(self.interval * self.attack_cnt_max, function()
			ParticleManager:DestroyParticle(u, true)
		end)
		self:OnIntervalThink()
		self:StartIntervalThink(self.interval)
	end
end
function q.prototype.OnIntervalThink(self)
	local v = self.parent:GetEnemy()
	if not IsInjurable(v, self.parent) then
		self:StartIntervalThink(-1)
		return
	end
	local w = ParticleManager:CreateParticle("particles/sect/sect_139_path.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local x = self.tPosition[self:GetStackCount()]
	local y = x + (self.vCenter - x):Normalized() * self.radius * 2
	if v ~= nil then
		v:EmitSound("Hero_Juggernaut.OmniSlash.Damage")
	end
	ParticleManager:SetParticleControl(w, 0, x)
	ParticleManager:SetParticleControl(w, 1, y)
	ParticleManager:ReleaseParticleIndex(w)
	DamageSystem:performAttack(self.parent, v, { ability = self:GetAbility() })
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:StartIntervalThink(-1)
	end
	local u = ParticleManager:CreateParticle("particles/sect/sect_attack_139_flame.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(u, 4, v, PATTACH_POINT_FOLLOW, "attach_hitloc", v:GetAbsOrigin(), false)
	ParticleManager:ReleaseParticleIndex(u)
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_152_buff = q
return g