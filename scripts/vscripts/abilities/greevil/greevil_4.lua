--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil/greevil_4"
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
		["14"] = 4,
		["15"] = 14,
		["16"] = 4,
		["17"] = 14,
		["18"] = 15,
		["19"] = 16,
		["20"] = 17,
		["22"] = 15,
		["23"] = 14,
		["24"] = 4,
		["25"] = 4,
		["26"] = 4,
		["27"] = 4,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 4,
		["33"] = 4,
		["34"] = 14,
		["36"] = 14,
		["37"] = 22,
		["38"] = 23,
		["39"] = 22,
		["40"] = 23,
		["41"] = 24,
		["42"] = 25,
		["43"] = 24,
		["44"] = 23,
		["45"] = 22,
		["46"] = 23,
		["48"] = 23,
		["49"] = 29,
		["50"] = 37,
		["51"] = 29,
		["52"] = 37,
		["53"] = 39,
		["54"] = 40,
		["55"] = 39,
		["56"] = 42,
		["57"] = 43,
		["58"] = 42,
		["59"] = 48,
		["60"] = 49,
		["61"] = 48,
		["62"] = 51,
		["63"] = 52,
		["64"] = 53,
		["65"] = 54,
		["66"] = 55,
		["67"] = 56,
		["70"] = 51,
		["71"] = 37,
		["72"] = 29,
		["73"] = 29,
		["74"] = 29,
		["75"] = 29,
		["76"] = 29,
		["77"] = 29,
		["78"] = 29,
		["79"] = 29,
		["80"] = 37,
		["82"] = 37,
		["83"] = 62,
		["84"] = 70,
		["85"] = 62,
		["86"] = 70,
		["87"] = 73,
		["88"] = 74,
		["89"] = 75,
		["90"] = 73,
		["91"] = 77,
		["92"] = 78,
		["93"] = 79,
		["95"] = 77,
		["96"] = 82,
		["97"] = 83,
		["98"] = 84,
		["99"] = 85,
		["100"] = 86,
		["101"] = 86,
		["102"] = 86,
		["103"] = 87,
		["104"] = 88,
		["105"] = 89,
		["106"] = 90,
		["107"] = 90,
		["108"] = 90,
		["109"] = 90,
		["110"] = 90,
		["111"] = 90,
		["112"] = 90,
		["113"] = 90,
		["114"] = 90,
		["115"] = 91,
		["116"] = 92,
		["117"] = 93,
		["119"] = 86,
		["120"] = 86,
		["121"] = 82,
		["122"] = 97,
		["123"] = 98,
		["124"] = 99,
		["125"] = 100,
		["126"] = 97,
		["127"] = 104,
		["128"] = 105,
		["129"] = 104,
		["130"] = 70,
		["131"] = 62,
		["132"] = 62,
		["133"] = 62,
		["134"] = 62,
		["135"] = 62,
		["136"] = 62,
		["137"] = 62,
		["138"] = 62,
		["139"] = 70,
		["141"] = 70,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.modifier_skin_greevil_4 = c()
local n = g.modifier_skin_greevil_4
n.name = "modifier_skin_greevil_4"
d(n, l)
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self.parent:SetSkin(4)
	end
end
n = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetStatusEffectName = "particles/gameplay/greevil_amibent_status_4.vpcf",
				StatusEffectPriority = MODIFIER_PRIORITY_ULTRA,
				RemoveOnDeath = false,
			}
		),
	},
	n
)
g.modifier_skin_greevil_4 = n
g.greevil_4 = c()
local p = g.greevil_4
p.name = "greevil_4"
d(p, i)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_greevil_4"
end
p = e({ j(nil) }, p)
g.greevil_4 = p
g.modifier_greevil_4 = c()
local q = g.modifier_greevil_4
q.name = "modifier_greevil_4"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.courier_regen = self:GetAbilitySpecialValueFor("courier_regen")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, -1 },
	}
end
function q.prototype.OnBattleStartBefore(self, o)
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_greevil_4_battle_buff", {})
end
function q.prototype.OnPlayerTakeDamage(self, r)
	local s = self.parent:GetPlayerOwnerID()
	if r.attackerID == s and r.victimID ~= s then
		if r.damage > 0 then
			local t = math.floor(r.damage * self.courier_regen * 0.01)
			PlayerData:modifyHealth(s, t, true)
		end
	end
end
q = e(
	{
		m(
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
	q
)
g.modifier_greevil_4 = q
g.modifier_greevil_4_battle_buff = c()
local u = g.modifier_greevil_4_battle_buff
u.name = "modifier_greevil_4_battle_buff"
d(u, l)
function u.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.battle_regen = self:GetAbilitySpecialValueFor("battle_regen")
end
function u.prototype.OnCreated(self, o)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function u.prototype.OnIntervalThink(self)
	local v = self:GetParent()
	local w = v:GetCaster()
	v:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	GameTimer(0.3, function()
		if IsValid(self) then
			local x = w:GetHealthDeficit()
			local y = ParticleManager:CreateParticle(
				"particles/gameplay/greevil_ability/greevil_4_impact.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				w
			)
			ParticleManager:SetParticleControlEnt(
				y,
				0,
				w,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				w:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(y)
			w:EmitSound("Hero_Oracle.FalsePromise.Healed")
			Heal(w, x * self.battle_regen * 0.01, "greevil_4", "Ability")
		end
	end)
end
function u.prototype.EDeclareEvents(self)
	local v = self:GetParent()
	local w = v:GetCaster()
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { w, w } }
end
function u.prototype.OnBattleEnd(self)
	self:StartIntervalThink(-1)
end
u = e(
	{
		m(
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
	u
)
g.modifier_greevil_4_battle_buff = u
return g