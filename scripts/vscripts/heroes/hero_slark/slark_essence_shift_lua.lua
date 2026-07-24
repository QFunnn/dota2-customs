--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier('modifier_slark_essence_shift_lua', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_slark_essence_shift_lua_agi', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_slark_essence_shift_lua_agi_permenant', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)


slark_essence_shift_lua = class({})

function slark_essence_shift_lua:GetIntrinsicModifierName()
	return 'modifier_slark_essence_shift_lua'
end

--------------------------------------------------------------------------------
--== Main Modifier ==--

modifier_slark_essence_shift_lua = class({})

function modifier_slark_essence_shift_lua:IsHidden()
	return true
end

function modifier_slark_essence_shift_lua:IsDebuff() return false end
function modifier_slark_essence_shift_lua:IsPurgable() return false end

function modifier_slark_essence_shift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end
function modifier_slark_essence_shift_lua:AllowIllusionDuplicate()
	return false
end
function modifier_slark_essence_shift_lua:OnCreated(keys)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.agi_gain = self:GetAbilitySpecialValueFor('agi_gain')
	self.creep_agi_gain = self:GetAbilitySpecialValueFor('creep_agi_gain')
end
function modifier_slark_essence_shift_lua:OnRefresh(keys)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.agi_gain = self:GetAbilitySpecialValueFor('agi_gain')
	self.creep_agi_gain = self:GetAbilitySpecialValueFor('creep_agi_gain')
end

function modifier_slark_essence_shift_lua:OnDeath(keys)
	if keys.unit == self.parent
	then self:SetStackCount(0)
	end
	local unit_killed = keys.unit

	--如果范围内有敌方英雄死亡
	if unit_killed and unit_killed:IsRealHero() and self.parent:GetTeamNumber() ~= unit_killed:GetTeamNumber() and (not unit_killed:IsIllusion()) and (not unit_killed:IsTempestDouble()) and (not unit_killed:HasModifier("modifier_arc_warden_tempest_double_lua")) then
		local flDistance = (self.parent:GetOrigin() - unit_killed:GetOrigin()):Length2D()
		if flDistance < 1000 then
			if self.parent:HasModifier("modifier_slark_essence_shift_lua_agi_permenant") then
				local nStack = self.parent:GetModifierStackCount("modifier_slark_essence_shift_lua_agi_permenant", self.parent)
				self.parent:FindModifierByName("modifier_slark_essence_shift_lua_agi_permenant"):SetStackCount(nStack + 1)
			else
				local hModifier = self.parent:AddNewModifier(self.parent, self.ability, "modifier_slark_essence_shift_lua_agi_permenant", {})
				if hModifier and (not hModifier:IsNull()) then
					hModifier:SetStackCount(1)
				end
			end
		end
	end

end

-- 对小怪的偷取(英雄逻辑用的原版modifier)
function modifier_slark_essence_shift_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target	--射手天赋无效
	--   if keys.no_attack_cooldown then
	--	   return
	--   end
	if IsServer() then
		if IsValid(hParent) and IsValid(hTarget) and not hParent:PassivesDisabled() and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() and not hParent:HasModifier("modifier_hero_refreshing") then
			if not hParent:IsIllusion() and not hTarget:IsIllusion() then
				if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, hParent:GetTeamNumber()) == UF_SUCCESS then
					-- Purple slash effect
					local particle_cast = ParticleManager:GetParticleReplacement('particles/units/heroes/hero_slark/slark_essence_shift.vpcf', hParent)
					local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
					ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetAbsOrigin() + Vector(0, 0, 64))
					ParticleManager:SetParticleControl(effect_cast, 1, hParent:GetAbsOrigin() + Vector(0, 0, 64))
					ParticleManager:ReleaseParticleIndex(effect_cast)

					local stacks = self:GetAbilitySpecialValueFor("creep_agi_gain")
					--对英雄攻击叠加三层
					if hTarget:IsRealHero() then
						stacks = self:GetAbilitySpecialValueFor("agi_gain")
					end

					hParent:AddNewModifier(hParent, self, "modifier_slark_essence_shift_lua_agi", { duration = self:GetAbilitySpecialValueFor("duration"), stack = stacks })
				end
			end
		end
	end
end


--独立叠加的敏捷
modifier_slark_essence_shift_lua_agi = class({})

function modifier_slark_essence_shift_lua_agi:GetTexture() return "slark_essence_shift" end
function modifier_slark_essence_shift_lua_agi:IsHidden()
	return self:GetStackCount() == 0
end
function modifier_slark_essence_shift_lua_agi:IsDebuff() return false end
function modifier_slark_essence_shift_lua_agi:IsPurgable() return false end
function modifier_slark_essence_shift_lua_agi:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_slark_essence_shift_lua_agi:OnCreated(params)
	if IsServer() then
		self.tStack = {}
		self:StartIntervalThink(0)
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_slark_essence_shift_lua_agi:OnRefresh(params)
	if IsServer() then
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_slark_essence_shift_lua_agi:OnIntervalThink()
	local hCaster = self:GetCaster()
	if not IsValid(hCaster) then
		self:Destroy()
		return
	end
	local fGameTime = GameRules:GetGameTime()
	for i = #self.tStack, 1, -1 do
		if fGameTime >= self.tStack[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStack[i].iCount))
			table.remove(self.tStack, i)
		end
	end
end
function modifier_slark_essence_shift_lua_agi:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

-- Agility
function modifier_slark_essence_shift_lua_agi:GetModifierBonusStats_Agility()
	return self:GetStackCount() * 1
end




--永久敏捷
modifier_slark_essence_shift_lua_agi_permenant = class({})

function modifier_slark_essence_shift_lua_agi_permenant:GetTexture() return "slark_essence_shift" end
function modifier_slark_essence_shift_lua_agi_permenant:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_slark_essence_shift_lua_agi_permenant:IsPermanent()
	return true
end
function modifier_slark_essence_shift_lua_agi_permenant:IsDebuff() return false end
function modifier_slark_essence_shift_lua_agi_permenant:IsPurgable() return false end
function modifier_slark_essence_shift_lua_agi_permenant:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_slark_essence_shift_lua_agi_permenant:OnCreated()
	if not IsServer() then return end
end

function modifier_slark_essence_shift_lua_agi_permenant:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_slark_essence_shift_lua_agi_permenant:GetModifierBonusStats_Agility()
	return self:GetStackCount() * 1
end