--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/consumables/consumables_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayForEach
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 5,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 6,
		["25"] = 13,
		["26"] = 14,
		["27"] = 15,
		["28"] = 16,
		["30"] = 18,
		["31"] = 13,
		["32"] = 20,
		["33"] = 21,
		["34"] = 20,
		["35"] = 5,
		["36"] = 4,
		["37"] = 5,
		["39"] = 5,
		["40"] = 25,
		["41"] = 34,
		["42"] = 25,
		["43"] = 34,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["47"] = 42,
		["48"] = 39,
		["49"] = 44,
		["50"] = 45,
		["51"] = 46,
		["52"] = 47,
		["53"] = 48,
		["55"] = 44,
		["56"] = 51,
		["57"] = 52,
		["58"] = 53,
		["60"] = 51,
		["61"] = 56,
		["62"] = 57,
		["63"] = 58,
		["64"] = 59,
		["65"] = 60,
		["66"] = 60,
		["67"] = 60,
		["68"] = 60,
		["69"] = 60,
		["70"] = 60,
		["71"] = 60,
		["72"] = 60,
		["73"] = 60,
		["74"] = 60,
		["75"] = 60,
		["76"] = 71,
		["77"] = 71,
		["78"] = 71,
		["79"] = 72,
		["80"] = 72,
		["81"] = 72,
		["82"] = 72,
		["83"] = 73,
		["84"] = 73,
		["85"] = 74,
		["86"] = 74,
		["87"] = 74,
		["88"] = 74,
		["89"] = 74,
		["90"] = 74,
		["92"] = 71,
		["93"] = 71,
		["95"] = 56,
		["96"] = 34,
		["97"] = 25,
		["98"] = 25,
		["99"] = 25,
		["100"] = 25,
		["101"] = 25,
		["102"] = 25,
		["103"] = 25,
		["104"] = 25,
		["105"] = 25,
		["106"] = 34,
		["108"] = 34,
		["109"] = 81,
		["110"] = 89,
		["111"] = 81,
		["112"] = 89,
		["113"] = 90,
		["114"] = 91,
		["115"] = 92,
		["116"] = 92,
		["117"] = 92,
		["118"] = 92,
		["119"] = 92,
		["120"] = 93,
		["121"] = 93,
		["122"] = 93,
		["123"] = 93,
		["124"] = 93,
		["125"] = 93,
		["126"] = 93,
		["127"] = 93,
		["128"] = 93,
		["129"] = 94,
		["130"] = 94,
		["131"] = 94,
		["132"] = 94,
		["133"] = 94,
		["134"] = 94,
		["135"] = 94,
		["136"] = 94,
		["138"] = 96,
		["140"] = 90,
		["141"] = 99,
		["142"] = 100,
		["143"] = 101,
		["144"] = 102,
		["146"] = 99,
		["147"] = 105,
		["148"] = 106,
		["149"] = 105,
		["150"] = 110,
		["151"] = 111,
		["152"] = 110,
		["153"] = 113,
		["154"] = 114,
		["155"] = 113,
		["156"] = 89,
		["157"] = 81,
		["158"] = 81,
		["159"] = 81,
		["160"] = 81,
		["161"] = 81,
		["162"] = 81,
		["163"] = 81,
		["164"] = 81,
		["165"] = 89,
		["167"] = 89,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.consumables_5 = c()
local p = i.consumables_5
p.name = "consumables_5"
d(p, k)
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster()
	local r = self:GetSpecialValueFor("duration")
	q:AddNewModifier(q, self, "modifier_consumables_5_cast", { duration = r })
end
function p.prototype.CastFilterResult(self)
	if self:GetCaster():HasModifier("modifier_consumables_5_cast") then
		self.error = "error_cd"
		return UF_FAIL_IN_FOW
	end
	return UF_SUCCESS
end
function p.prototype.GetCustomCastError(self)
	return self.error
end
p = e({ l(nil) }, p)
i.consumables_5 = p
i.modifier_consumables_5_cast = c()
local s = i.modifier_consumables_5_cast
s.name = "modifier_consumables_5_cast"
d(s, n)
function s.prototype.GetAbilitySpecialValue(self)
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.bubble_duration = self:GetAbilitySpecialValueFor("bubble_duration")
	self.angle = self:GetAbilitySpecialValueFor("angle")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		self.records = {}
		self:StartIntervalThink(0.2)
		self:GetParent():EmitSound("TI11.Bubbles.Cast")
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("TI11.Bubbles.Cast")
	end
end
function s.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(0.1)
		local u = self:GetParent()
		local v = FindUnitsInSector(
			u:GetTeamNumber(),
			u:GetAbsOrigin(),
			self.radius,
			u:GetForwardVector(),
			self.angle,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER
		)
		g(v, function(w, x)
			if
				x:HasModifier("modifier_courier")
				and not f(self.records, x:entindex())
				and not x:HasModifier("modifier_consumables_5_buff")
			then
				local y = self.records
				y[#y + 1] = x:entindex()
				x:AddNewModifier(
					x,
					x:GetDummyAbility(),
					"modifier_consumables_5_buff",
					{ duration = self.bubble_duration }
				)
			end
		end)
	end
end
s = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetEffectName = "particles/eom/events/xiari_interact_fx/xiari_interact_fx.vpcf",
				GetEffectAttachType = PATTACH_ABSORIGIN_FOLLOW,
			}
		),
	},
	s
)
i.modifier_consumables_5_cast = s
i.modifier_consumables_5_buff = c()
local z = i.modifier_consumables_5_buff
z.name = "modifier_consumables_5_buff"
d(z, n)
function z.prototype.OnCreated(self, t)
	if IsClient() then
		local A = ParticleManager:CreateParticle(
			"particles/eom/events/xiari_interact_fx/xiari_interact_bubble_fx.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControlEnt(
			A,
			0,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			vec3_zero,
			true
		)
		self:AddParticle(A, false, false, -1, false, false)
	else
		self:GetParent():EmitSound("DOTA_Item.InfusedRaindrop")
	end
end
function z.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():StopSound("DOTA_Item.InfusedRaindrop")
		self:GetParent():EmitSound("Hero_Tidehunter.KrakenShell")
	end
end
function z.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function z.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function z.prototype.CheckState(self)
	return { [MODIFIER_STATE_FLYING] = true, [MODIFIER_STATE_ROOTED] = true }
end
z = e(
	{
		o(
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
	z
)
i.modifier_consumables_5_buff = z
return i