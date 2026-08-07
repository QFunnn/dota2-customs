--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_breakable_building"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_breakable_building"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.obstructions = {}
	self.modelConfig = {
		["models/eom/props/sm_column/eom_column_007.vmdl"] = {
			["1"] = "models/eom/props/sm_column/eom_column_007_destroy_lv1.vmdl",
			["2"] = "models/eom/props/sm_column/eom_column_007_destroy_lv2.vmdl",
			destory = "particles/breakable/eom_column_007_destory.vpcf",
		},
		["models/eom/props/sm_column/eom_column_006.vmdl"] = {
			["1"] = "models/eom/props/sm_column/eom_column_006_destroy_lv1.vmdl",
			["2"] = "models/eom/props/sm_column/eom_column_006_destroy_lv2.vmdl",
			destory = "particles/breakable/eom_column_006_destory.vpcf",
		},
		["models/eom/props/sm_column/eom_column_4_0.vmdl"] = {
			["1"] = "models/eom/props/sm_column/eom_column_4_0_destroy_lv1.vmdl",
			["2"] = "models/eom/props/sm_column/eom_column_4_0_destroy_lv2.vmdl",
			destory = "particles/breakable/eom_column_4_0_destroy.vpcf",
		},
	}
end
function j.prototype.CanParentBeAutoAttacked(self)
	return false
end
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		l:SetHullRadius(64)
		self.model = l:GetModelName()
		self.config = self.modelConfig[l:GetModelName()]
		self.block = Bullet:CreateTemporaryBlock({
			type = TEMPORARY_BLOCK_TYPE.POLYGON,
			points = {
				l:GetAbsOrigin() + Vector(64, 64, 0),
				l:GetAbsOrigin() + Vector(-64, 64, 0),
				l:GetAbsOrigin() + Vector(-64, -64, 0),
				l:GetAbsOrigin() + Vector(64, -64, 0),
			},
			callback = function(m)
				if Bullet:GetData(m.__projIndex, "TemporaryBlock" .. tostring(self.block), false) == false then
					if
						m.caster ~= nil
						and m.typeFilter ~= nil
						and bit.band(m.typeFilter, DOTA_UNIT_TARGET_BUILDING) == DOTA_UNIT_TARGET_BUILDING
					then
						Bullet:SaveData(m.__projIndex, "TemporaryBlock" .. tostring(self.block), true)
						m.caster:DealDamage(l, m.ability, 1)
					end
				end
			end,
		})
		self.obstructions =
			{ SpawnEntityFromTableSynchronous("point_simple_obstruction", { origin = l:GetAbsOrigin() }) }
		self:StartIntervalThink(0)
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
		for n, o in ipairs(self.obstructions) do
			UTIL_Remove(o)
		end
		Bullet:RemoveTemporaryBlock(self.block)
	end
end
function j.prototype.OnIntervalThink(self)
	self:GetParent():RemoveModifierByName("modifier_invulnerable")
	self:StartIntervalThink(-1)
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.MIN_HEALTH] = function(p, k)
			local l = self:GetParent()
			local q = l:GetHealth() - 1
			l:EmitSound("Building_Generic.PartialDestruction")
			local r = ParticleManager:CreateParticleForce(
				"particles/breakable/eom_column_006_hurt.vpcf",
				PATTACH_ABSORIGIN,
				l
			)
			ParticleManager:ReleaseParticleIndex(r)
			if q <= 0 then
				l:AddNoDraw()
				l:EmitSound("Building_Generic.Destruction")
				local r = ParticleManager:CreateParticleForce(self.config.destory, PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(r, 0, l:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(r)
				if k and k.attacker then
					local s = FindEnemiesInRadius(k.attacker, l:GetAbsOrigin(), 350)
					local t = k.attacker:GetAttackDamage() * 5
					k.attacker:DealDamage(s, nil, t)
					for n, o in ipairs(s) do
						o:Stun(k.attacker, nil, 2)
					end
				end
			elseif q / l:GetMaxHealth() <= 0.34 then
				l:SetModel(self.config["2"])
				l:SetOriginalModel(self.config["2"])
				l:StartGesture(ACT_DOTA_IDLE)
			elseif q / l:GetMaxHealth() <= 0.67 then
				l:SetModel(self.config["1"])
				l:SetOriginalModel(self.config["1"])
				l:StartGesture(ACT_DOTA_IDLE)
			end
			return q
		end,
	}
end
function j.prototype.StaticState(self)
	return { [StateEnum.BREAKABLE] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	j
)
return f