--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--单位模型替换
modifier_wearable_model = class({})

function modifier_wearable_model:IsHidden() return true end

function modifier_wearable_model:IsDebuff() return false end

function modifier_wearable_model:IsPurgable() return false end

function modifier_wearable_model:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_wearable_model:RemoveOnDeath() return false end

function modifier_wearable_model:DeclareFunctions()
	if IsServer() then
		local hParent = self:GetParent()
		local skinID = Wearable_System:GetPlayerHeroSkin(hParent:GetPlayerOwnerID(), hParent:GetUnitName())
		-- 测试英雄皮肤
		if IsInToolsMode() then
			-- skinID = "17000028"
		end
		local skin = HeroSkinKV[skinID]

		local funcs = {}
		if skin then
			local iSkinID = tonumber(skinID)
			if type(iSkinID) == "number" then
				self:SetStackCount(iSkinID)
			end
			if skin.model then
				self.model = skin.model
				table.insert(funcs, MODIFIER_PROPERTY_MODEL_CHANGE)
				table.insert(funcs, MODIFIER_EVENT_ON_MODEL_CHANGED)
			end
			if skin.projectile_name then
				self.projectile_name = skin.projectile_name
				table.insert(funcs, MODIFIER_PROPERTY_PROJECTILE_NAME)
			end
			if skin.model_scale then
				self.model_scale = skin.model_scale
				table.insert(funcs, MODIFIER_PROPERTY_MODEL_SCALE)
			end
			if skin.activity_modifier then
				self.activity_modifier = skin.activity_modifier
				table.insert(funcs, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS)
			end
			return funcs
		end
	end
	return {
		-- MODIFIER_PROPERTY_MODEL_CHANGE,
		-- MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		-- MODIFIER_PROPERTY_MODEL_SCALE,
		-- MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
end

function modifier_wearable_model:GetModifierModelScale()
	local hParent = self:GetParent()
	if hParent:GetModelName() == self.model then
		return self.model_scale
	end
end

function modifier_wearable_model:GetActivityTranslationModifiers()
	return self.activity_modifier
end

function modifier_wearable_model:OnCreated()
	if IsServer() then
		local hParent = self:GetParent()
		self.particles = {}
		if self.model then
			hParent:NotifyWearablesOfModelChange(false)
		end
	end
end

function modifier_wearable_model:OnRefresh()
	if IsServer() then
	end
end

function modifier_wearable_model:OnDestroy()
	if IsServer() then
		if self.particles then
			for _, iParicle in pairs(self.particles) do
				ParticleManager:DestroyParticle(iParicle, true)
				ParticleManager:ReleaseParticleIndex(iParicle)
			end
			self.particles = {}
		end
	end
end

function modifier_wearable_model:OnModelChanged(params)
	local hUnit = params.attacker
	local hParent = self:GetParent()
	if hParent == hUnit then
		if hUnit:GetModelName() == self.model then
			self:StartIntervalThink(FrameTime())
		else
			if self.particles then
				for _, iParicle in pairs(self.particles) do
					ParticleManager:DestroyParticle(iParicle, true)
					ParticleManager:ReleaseParticleIndex(iParicle)
				end
				self.particles = {}
			end
		end
	end
end

function modifier_wearable_model:OnIntervalThink()
	local hParent = self:GetParent()
	local skinID = Wearable_System:GetPlayerHeroSkin(hParent:GetPlayerOwnerID(), hParent:GetUnitName())
	-- if IsInToolsMode() then
	-- 	skinID = "17000017"
	-- end
	local skin = HeroSkinKV[skinID]
	if skin then
		if next(self.particles) == nil then
			for i = 1, 100 do
				if skin["particle" .. i] then
					local sParticleName = skin["particle" .. i]
					local sAttachment = skin["attachment" .. i]
					local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, hParent)
					if sAttachment then
						ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, sAttachment,
							Vector(0, 0, 0), true)
					end
					table.insert(self.particles, iParticleID)
				else
					break
				end
			end
		end

		self:StartIntervalThink(-1)
	end
end

function modifier_wearable_model:GetModifierModelChange(params)
	return self.model
	-- return "model/heroskin/legion_commander/17000003/legion_commander_skin_17000003.vmdl"
end

function modifier_wearable_model:GetModifierProjectileName()
	return self.projectile_name
	-- return "particles/skin/templar_assassin/base_attack_nainai.vpcf"
end

function modifier_wearable_model:GetPriority()
	return MODIFIER_PRIORITY_LOW
end

---------------------------------------------------------------------------------------------------------------------------
---
--单位模型替换
modifier_wearable_model_refresh = class({})

function modifier_wearable_model_refresh:IsHidden() return false end

function modifier_wearable_model_refresh:IsDebuff() return false end

function modifier_wearable_model_refresh:IsPurgable() return false end

function modifier_wearable_model_refresh:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_wearable_model_refresh:RemoveOnDeath() return false end

function modifier_wearable_model_refresh:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_wearable_model_refresh:OnCreated(params)
	if IsServer() then
		self.model = params.model
	end
end

function modifier_wearable_model_refresh:OnRefresh(params)
	if IsServer() then
		self.model = params.model
	end
end

function modifier_wearable_model_refresh:GetModifierModelChange(params)
	return self.model
end

function modifier_wearable_model_refresh:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

---------------------------------------------------------------------------------------------------------------------------
---
-- Warlock Golem Skin Model replacement modifier
modifier_warlock_golem_burning_puppet = class({})

function modifier_warlock_golem_burning_puppet:IsHidden() return true end
function modifier_warlock_golem_burning_puppet:IsDebuff() return false end
function modifier_warlock_golem_burning_puppet:IsPurgable() return false end
function modifier_warlock_golem_burning_puppet:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_warlock_golem_burning_puppet:RemoveOnDeath() return false end

function modifier_warlock_golem_burning_puppet:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_warlock_golem_burning_puppet:GetModifierModelChange(params)
	return "models/items/warlock/golem/warlock_tailor_of_burning_puppet_golem/warlock_tailor_of_burning_puppet_golem.vmdl"
end
