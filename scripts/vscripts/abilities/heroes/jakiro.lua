--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/jakiro"
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
		["14"] = 3,
		["15"] = 3,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 20,
		["31"] = 12,
		["32"] = 20,
		["34"] = 20,
		["35"] = 25,
		["36"] = 27,
		["37"] = 12,
		["38"] = 28,
		["39"] = 29,
		["40"] = 30,
		["41"] = 31,
		["42"] = 28,
		["43"] = 33,
		["44"] = 34,
		["45"] = 35,
		["46"] = 35,
		["47"] = 35,
		["48"] = 34,
		["49"] = 36,
		["50"] = 36,
		["51"] = 36,
		["52"] = 34,
		["53"] = 34,
		["54"] = 33,
		["55"] = 39,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["59"] = 43,
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 46,
		["64"] = 46,
		["65"] = 46,
		["66"] = 46,
		["67"] = 46,
		["68"] = 52,
		["69"] = 53,
		["70"] = 54,
		["72"] = 46,
		["73"] = 46,
		["74"] = 58,
		["76"] = 39,
		["77"] = 61,
		["78"] = 62,
		["79"] = 63,
		["80"] = 64,
		["81"] = 65,
		["82"] = 66,
		["83"] = 67,
		["84"] = 68,
		["85"] = 68,
		["86"] = 68,
		["87"] = 68,
		["88"] = 68,
		["89"] = 68,
		["90"] = 74,
		["91"] = 75,
		["92"] = 76,
		["94"] = 68,
		["95"] = 68,
		["96"] = 80,
		["98"] = 61,
		["99"] = 20,
		["100"] = 12,
		["101"] = 12,
		["102"] = 12,
		["103"] = 12,
		["104"] = 12,
		["105"] = 12,
		["106"] = 12,
		["107"] = 12,
		["108"] = 20,
		["110"] = 20,
		["112"] = 86,
		["113"] = 95,
		["114"] = 86,
		["115"] = 95,
		["116"] = 99,
		["117"] = 100,
		["118"] = 101,
		["119"] = 102,
		["120"] = 99,
		["121"] = 104,
		["122"] = 105,
		["123"] = 106,
		["124"] = 107,
		["125"] = 108,
		["127"] = 110,
		["128"] = 111,
		["129"] = 112,
		["130"] = 112,
		["131"] = 112,
		["132"] = 112,
		["133"] = 112,
		["134"] = 113,
		["135"] = 113,
		["136"] = 113,
		["137"] = 113,
		["138"] = 113,
		["139"] = 114,
		["140"] = 114,
		["141"] = 114,
		["142"] = 114,
		["143"] = 114,
		["144"] = 114,
		["145"] = 114,
		["146"] = 114,
		["148"] = 104,
		["149"] = 117,
		["150"] = 118,
		["151"] = 119,
		["152"] = 120,
		["153"] = 121,
		["154"] = 122,
		["155"] = 123,
		["156"] = 124,
		["157"] = 125,
		["160"] = 117,
		["161"] = 95,
		["162"] = 86,
		["163"] = 86,
		["164"] = 86,
		["165"] = 86,
		["166"] = 86,
		["167"] = 86,
		["168"] = 86,
		["169"] = 86,
		["170"] = 86,
		["171"] = 95,
		["173"] = 95,
		["174"] = 132,
		["175"] = 133,
		["176"] = 132,
		["177"] = 133,
		["178"] = 135,
		["179"] = 136,
		["180"] = 137,
		["181"] = 138,
		["182"] = 139,
		["183"] = 140,
		["185"] = 142,
		["186"] = 143,
		["187"] = 144,
		["188"] = 144,
		["189"] = 144,
		["190"] = 145,
		["191"] = 146,
		["193"] = 144,
		["194"] = 144,
		["196"] = 150,
		["197"] = 151,
		["198"] = 151,
		["199"] = 151,
		["200"] = 152,
		["201"] = 153,
		["202"] = 151,
		["203"] = 151,
		["205"] = 156,
		["206"] = 135,
		["207"] = 159,
		["208"] = 160,
		["209"] = 161,
		["210"] = 162,
		["211"] = 163,
		["212"] = 164,
		["213"] = 165,
		["214"] = 166,
		["215"] = 167,
		["216"] = 167,
		["217"] = 167,
		["218"] = 167,
		["219"] = 167,
		["220"] = 168,
		["221"] = 169,
		["222"] = 169,
		["223"] = 169,
		["224"] = 169,
		["225"] = 170,
		["226"] = 170,
		["227"] = 170,
		["228"] = 170,
		["229"] = 170,
		["230"] = 170,
		["231"] = 171,
		["232"] = 172,
		["233"] = 173,
		["236"] = 159,
		["237"] = 133,
		["238"] = 132,
		["239"] = 133,
		["241"] = 133,
		["243"] = 180,
		["244"] = 189,
		["245"] = 180,
		["246"] = 189,
		["247"] = 193,
		["248"] = 194,
		["249"] = 195,
		["250"] = 196,
		["251"] = 193,
		["252"] = 198,
		["253"] = 199,
		["254"] = 200,
		["255"] = 201,
		["256"] = 202,
		["258"] = 204,
		["259"] = 205,
		["260"] = 206,
		["261"] = 206,
		["262"] = 206,
		["263"] = 206,
		["264"] = 206,
		["265"] = 207,
		["266"] = 207,
		["267"] = 207,
		["268"] = 207,
		["269"] = 207,
		["270"] = 208,
		["271"] = 208,
		["272"] = 208,
		["273"] = 208,
		["274"] = 208,
		["275"] = 208,
		["276"] = 208,
		["277"] = 208,
		["279"] = 198,
		["280"] = 211,
		["281"] = 212,
		["282"] = 213,
		["283"] = 214,
		["284"] = 215,
		["285"] = 216,
		["286"] = 217,
		["287"] = 218,
		["288"] = 219,
		["291"] = 211,
		["292"] = 189,
		["293"] = 180,
		["294"] = 180,
		["295"] = 180,
		["296"] = 180,
		["297"] = 180,
		["298"] = 180,
		["299"] = 180,
		["300"] = 180,
		["301"] = 180,
		["302"] = 189,
		["304"] = 189,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("abilities.ability_ai")
local o = n.BaseAbilityAI
local p = n.registerAbilityAI
g.jakiro_talent = c()
local q = g.jakiro_talent
q.name = "jakiro_talent"
d(q, i)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_jakiro_talent"
end
q = e({ j(nil) }, q)
g.jakiro_talent = q
g.modifier_jakiro_talent = c()
local r = g.modifier_jakiro_talent
r.name = "modifier_jakiro_talent"
d(r, l)
function r.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.furyGainedCount = 0
	self.iceGainedCount = 0
end
function r.prototype.GetAbilitySpecialValue(self)
	self.stack = self:GetAbilitySpecialValueFor("stack")
	self.fury_duration = self:GetAbilitySpecialValueFor("fury_duration")
	self.ice_duration = self:GetAbilitySpecialValueFor("ice_duration")
end
function r.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_FURY_GAINED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ICE_GAINED] = { self:GetParent(), -1 },
	}
end
function r.prototype.OnFuryGained(self, s)
	self.furyGainedCount = self.furyGainedCount + 1
	if self.furyGainedCount >= self.stack then
		self.furyGainedCount = self.furyGainedCount - self.stack
		local t = self:GetParent()
		local u = t:GetEnemy()
		local v = self:GetAbility()
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf",
			hCaster = t,
			vSpawnOrigin = t:GetAttachmentPosition("attach_attack1"),
			hTarget = u,
			iMoveSpeed = t:GetProjectileSpeed(),
			OnProjectileHit = function(w, x, y)
				if IsInjurable(u) then
					u:AddNewModifier(t, v, "modifier_jakiro_talent_fury", { duration = self.fury_duration })
				end
			end,
		})
		t:EmitSound("Hero_Jakiro.LiquidFire")
	end
end
function r.prototype.OnIceGained(self, s)
	self.iceGainedCount = self.iceGainedCount + 1
	if self.iceGainedCount >= self.stack then
		self.iceGainedCount = self.iceGainedCount - self.stack
		local t = self:GetParent()
		local u = t:GetEnemy()
		local v = self:GetAbility()
		Projectile:CreateTrackingProjectile({
			EffectName = "particles/units/heroes/hero_jakiro/jakiro_liquid_ice_projectile.vpcf",
			hCaster = t,
			vSpawnOrigin = t:GetAttachmentPosition("attach_attack1"),
			hTarget = u,
			iMoveSpeed = t:GetProjectileSpeed(),
			OnProjectileHit = function(w, x, y)
				if IsInjurable(u) then
					u:AddNewModifier(t, v, "modifier_jakiro_talent_ice", { duration = self.ice_duration })
				end
			end,
		})
		t:EmitSound("Hero_Jakiro.LiquidFrost")
	end
end
r = e(
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
	r
)
g.modifier_jakiro_talent = r
g.modifier_jakiro_talent_fury = c()
local z = g.modifier_jakiro_talent_fury
z.name = "modifier_jakiro_talent_fury"
d(z, l)
function z.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.interval_reduce = self:GetAbilityTalentValue("jakiro_talent_4", "interval_reduce")
end
function z.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(s.count)
		self:StartIntervalThink(self.interval - self.interval_reduce)
		self:OnIntervalThink()
	else
		local t = self:GetParent()
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_jakiro/jakiro_eclipse.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		ParticleManager:SetParticleControl(A, 0, t:GetAbsOrigin())
		ParticleManager:SetParticleControl(A, 2, t:GetAbsOrigin())
		self:AddParticle(A, false, false, -1, false, false)
	end
end
function z.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local B = t:GetEnemy()
	local v = self:GetAbility()
	if IsInjurable(t, B) then
		v:LucentBeam()
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
z = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	z
)
g.modifier_jakiro_talent_fury = z
g.jakiro_ult = c()
local C = g.jakiro_ult
C.name = "jakiro_ult"
d(C, o)
function C.prototype.OnSpellStart(self)
	local D = self:GetCaster()
	local w = D:GetEnemy()
	local E = self:GetTalentValue("jakiro_talent_4", "bonus_count")
	if self.castTime == nil then
		self.castTime = E
	end
	if self.castTime == 0 then
		D:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		self:GameTimer(0.4, function()
			if IsInjurable(D, w) then
				self:LucentBeam()
			end
		end)
	else
		D:StartGesture(ACT_DOTA_CAST_ABILITY_4)
		self:GameTimer(0.5, function()
			D:AddNewModifier(D, self, "modifier_jakiro_ult_buff", { count = self.castTime })
			D:EmitSound("Hero_jakiro.Eclipse.Cast")
		end)
	end
	self.castTime = self.castTime + 1
end
function C.prototype.LucentBeam(self)
	local F = self:GetCaster()
	local u = F:GetEnemy()
	local G = self:GetSpecialValueFor("damage")
	local H = self:GetTalentValue("jakiro_talent_2", "stun_duration")
	local I = self:GetTalentValue("jakiro_talent_6", "attack_pct")
	if IsInjurable(F, u) then
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_jakiro/jakiro_eclipse_impact_notarget.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(A, 1, u:GetAbsOrigin())
		F:EmitSound("Hero_jakiro.LucentBeam.Cast")
		F:EmitSound("Hero_jakiro.LucentBeam.Target", u:GetAbsOrigin())
		F:DealDamage(u, self, G + I * GetAttackDamage(F) * 0.01, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		F:FindModifierByName("modifier_jakiro_talent"):IncrementStackCount()
		if H > 0 then
			u:AddNewModifier(F, self, "stun_duration", { duration = H })
		end
	end
end
C = e({ p(nil) }, C)
g.jakiro_ult = C
g.modifier_jakiro_ult_buff = c()
local J = g.modifier_jakiro_ult_buff
J.name = "modifier_jakiro_ult_buff"
d(J, l)
function J.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.interval_reduce = self:GetAbilityTalentValue("jakiro_talent_4", "interval_reduce")
end
function J.prototype.OnCreated(self, s)
	if IsServer() then
		self:SetStackCount(s.count)
		self:StartIntervalThink(self.interval - self.interval_reduce)
		self:OnIntervalThink()
	else
		local t = self:GetParent()
		local A = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_jakiro/jakiro_eclipse.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		ParticleManager:SetParticleControl(A, 0, t:GetAbsOrigin())
		ParticleManager:SetParticleControl(A, 2, t:GetAbsOrigin())
		self:AddParticle(A, false, false, -1, false, false)
	end
end
function J.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local B = t:GetEnemy()
	local v = self:GetAbility()
	if IsInjurable(t, B) then
		v:LucentBeam()
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end
J = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	J
)
g.modifier_jakiro_ult_buff = J
return g