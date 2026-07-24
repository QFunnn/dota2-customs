--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_beastmaster_call_of_the_wild_hawk_lua_summoned", "heroes/hero_beastmaster/beastmaster_call_of_the_wild_hawk_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if beastmaster_call_of_the_wild_hawk_lua == nil then
	beastmaster_call_of_the_wild_hawk_lua = class({})
end
function beastmaster_call_of_the_wild_hawk_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hawk_duration = self:GetSpecialValueFor("hawk_duration")
	local hawk_count = self:GetSpecialValueFor("hawk_count")
	local max_hawk_count = self:GetSpecialValueFor("max_hawk_count")

	if self.hawks == nil then
		self.hawks = {}
	end

	if IsValid(hCaster) and hawk_duration > 0 then

		EmitSoundOn("Hero_Beastmaster.Call.Hawk", hCaster)

		local vOffsetDirs = {}

		for i = 1, hawk_count do
			if i % 2 == 0 then
				vOffsetDirs[i] = -vOffsetDirs[i - 1]
			else
				vOffsetDirs[i] = RandomVector(1)
			end
		end

		for i = 1, hawk_count do
			CreateUnitByNameAsync("npc_dota_beastmaster_hawk", hCaster:GetAbsOrigin(), true, hCaster, hCaster, hCaster:GetTeamNumber(), function(unit)
				if IsValid(unit) then
					unit:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
					local hawk_base_damage = self:GetSpecialValueFor("hawk_base_damage")
					local hawk_base_magic_resist = self:GetSpecialValueFor("hawk_base_magic_resist")
					local hawk_base_vision_range = self:GetSpecialValueFor("hawk_base_vision_range")
					local hawk_base_max_health = self:GetSpecialValueFor("hawk_base_max_health")
					local hawk_base_gold_bounty = self:GetSpecialValueFor("hawk_base_gold_bounty")
					local hawk_base_xp_bounty = self:GetSpecialValueFor("hawk_base_xp_bounty")
					unit:SetBaseDamageMin(hawk_base_damage)
					unit:SetBaseDamageMax(hawk_base_damage)
					unit:SetBaseMagicalResistanceValue(hawk_base_magic_resist)
					unit:SetDayTimeVisionRange(hawk_base_vision_range)
					unit:SetNightTimeVisionRange(hawk_base_vision_range)
					unit:SetBaseMaxHealth(hawk_base_max_health)
					unit:SetMaxHealth(hawk_base_max_health)
					unit:SetHealth(hawk_base_max_health)
					unit:SetMaximumGoldBounty(hawk_base_gold_bounty)
					unit:SetMinimumGoldBounty(hawk_base_gold_bounty)
					unit:SetDeathXP(hawk_base_xp_bounty)
					table.insert(self.hawks, {
						hUnit = unit, fDietime = GameRules:GetGameTime() + hawk_duration
					})

					unit:AddNewModifier(hCaster, self, "modifier_beastmaster_call_of_the_wild_hawk_lua_summoned", { duration = hawk_duration, x = vOffsetDirs[i].x, y = vOffsetDirs[i].y })
					table.sort(self.hawks, function(a, b)
						return a.fDietime > b.fDietime
					end)
					local toKill = #self.hawks - max_hawk_count
					if toKill > 0 then
						for j = #self.hawks, 1, -1 do
							local hHawk = self.hawks[j].hUnit
							if IsValid(hHawk) and hHawk:IsAlive() then
								hHawk:ForceKill(false)
							end
							table.remove(self.hawks, j)
							toKill = toKill - 1
							if toKill <= 0 then
								break
							end
						end
					end
				end
			end)
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_beastmaster_call_of_the_wild_hawk_lua_summoned == nil then
	modifier_beastmaster_call_of_the_wild_hawk_lua_summoned = class({})
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:IsHidden()
	return true
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:IsDebuff()
	return false
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:IsPurgable()
	return false
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:IsPurgeException()
	return false
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:OnCreated(params)
	self.max_offset = self:GetAbilitySpecialValueFor("max_offset")
	if IsServer() then
		self:StartIntervalThink(0)
		self.vOffsetDir = Vector(params.x, params.y, 0)
	end
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:OnRefresh(params)
	self.max_offset = self:GetAbilitySpecialValueFor("max_offset")
	if IsServer() then
	end
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:OnDestroy()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	if IsServer() then
		hParent:Kill(self:GetAbility(), hCaster)
	end
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
	}
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:GetUnitLifetimeFraction(params)
	return ((self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration())
end
function modifier_beastmaster_call_of_the_wild_hawk_lua_summoned:OnIntervalThink(me, dt)
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if IsValid(hCaster) and IsValid(hParent) then
		local vNewPos = hCaster:GetOrigin() + self.vOffsetDir * self.max_offset
		vNewPos.z = vNewPos.z + 50
		hParent:SetOrigin(vNewPos)
		if not hParent:IsAttacking() then
			hParent:FaceTowards(hParent:GetOrigin() + hCaster:GetForwardVector())
		end
	end
end