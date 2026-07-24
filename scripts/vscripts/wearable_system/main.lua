--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("Wearable_System.itemEffect_config")
require("Wearable_System.skin_particle")
require("Wearable_System.skin_texture")

LinkLuaModifier("modifier_wearable_model", "Wearable_System/modifier_wearable_model", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wearable_model_refresh", "Wearable_System/modifier_wearable_model", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_golem_burning_puppet", "Wearable_System/modifier_wearable_model", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wearable_material_effect", "Wearable_System/modifier_wearable_material_effect", LUA_MODIFIER_MOTION_NONE)

if Wearable_System == nil then
	_G.Wearable_System = {}
end
function Wearable_System:Init()
	if HeroSkinKV == nil then
		_G.HeroSkinKV = LoadKeyValues("scripts/npc/kv/gameplay/info_hero_skin.kv")
	end

	self.ItemEffect = {}
	self.HeroSkin = {}
	for iPlayerID = 0, CHC_MAX_PLAYER_COUNT do
		self.ItemEffect[iPlayerID] = {}
		self.HeroSkin[iPlayerID] = {}
	end

end
-----------------------------------服务端函数------------------------------------------------
if IsServer() then
	function Wearable_System:ChangeHeroSkin(iPlayerID, params)
		local heroName = params.tag
		local skinID = params.id
		self.HeroSkin[iPlayerID][heroName] = skinID
		local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
		if IsValid(hHero) then
			hHero:RemoveModifierByName("modifier_wearable_model")
			if not hHero:IsAlive() then
				hHero:SetHealth(1)
				hHero:AddNewModifier(hHero, nil, "modifier_wearable_model", {})
				hHero:SetHealth(0)
			else
				hHero:AddNewModifier(hHero, nil, "modifier_wearable_model", {})
			end
		end
	end
	-- 获取玩家为该英雄装备的皮肤
	function Wearable_System:GetPlayerHeroSkin(iPlayerID, heroName)
		if self.HeroSkin and self.HeroSkin[iPlayerID] then
			if self.HeroSkin[iPlayerID][heroName] then
				return self.HeroSkin[iPlayerID][heroName]
			else
				self.HeroSkin[iPlayerID][heroName] = nil
				local Data = CustomNetTables:GetTableValue("service", "skin_list")
				if Data and Data[tostring(iPlayerID)] then
					for id, info in pairs(Data[tostring(iPlayerID)]) do
						if info.tag == heroName and info.is_equip == 1 then
							self.HeroSkin[iPlayerID][heroName] = id
							break
						end
					end
					return self.HeroSkin[iPlayerID][heroName]
				end
			end
		end
		return nil
	end
	function Wearable_System:ChangeItemEffect(iPlayerID, params)
		local itemName = params.tag
		local effectID = params.id
		self.ItemEffect[iPlayerID][itemName] = effectID
	end
	-- 获取玩家为该英雄装备的皮肤
	function Wearable_System:GetPlayerMaterialEffect(iPlayerID, itemName)
		if self.ItemEffect and self.ItemEffect[iPlayerID] then
			if self.ItemEffect[iPlayerID][itemName] then
				return self.ItemEffect[iPlayerID][itemName]
			else
				self.ItemEffect[iPlayerID][itemName] = nil
				local Data = CustomNetTables:GetTableValue("service", "material_effect_list")
				if Data and Data[tostring(iPlayerID)] then
					for id, info in pairs(Data[tostring(iPlayerID)]) do
						if info.tag == itemName and info.is_equip == 1 then
							self.ItemEffect[iPlayerID][itemName] = id
							break
						end
					end
					return self.ItemEffect[iPlayerID][itemName]
				end
			end
		end
		return nil
	end
	function Wearable_System:PlayItemEffect(iPlayerID, hCaster, sAbilityName, event, tData)
		if self.ItemEffect[iPlayerID] ~= nil then
			local EffectName = self:GetPlayerMaterialEffect(iPlayerID, sAbilityName) or "Default"

			if ItemEffectKV_original[sAbilityName] then
				local tInfo = ItemEffectKV_original[sAbilityName][EffectName] or ItemEffectKV_original[sAbilityName]["Default"]
				if tInfo then
					for _, EffectConfig in pairs(tInfo) do
						if EffectConfig.event == event then
							EffectConfig["callback"](hCaster, sAbilityName, tData)
						end
					end
				end
			elseif ItemEffectKV_custom[sAbilityName] and ItemEffectKV_custom[sAbilityName][EffectName] then
				local tInfo = ItemEffectKV_custom[sAbilityName][EffectName] or ItemEffectKV_custom[sAbilityName]["Default"]
				if tInfo then
					for _, EffectConfig in pairs(tInfo) do
						if EffectConfig.event == event then
							EffectConfig["callback"](hCaster, sAbilityName, tData)
						end
					end
				end
			end
		end
	end
	function Wearable_System:CustomGetParticleReplacement(iPlayerID, sParticleName)
		local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
		local sReplaceParticle = sParticleName
		if IsValid(hHero) then
			local sHeroName = hHero:GetUnitName()
			local skinID = Wearable_System:GetPlayerHeroSkin(iPlayerID, sHeroName)
			-- if IsInToolsMode() then
			-- 	skinID = "17000008"
			-- end
			local t = _G
			if skinID then

				for k, v in ipairs({ "SKIN_PARTICLE_CONFIG", sHeroName, sParticleName, skinID }) do
					if t[v] then
						t = t[v]
					end
				end
			end
			if t and type(t) == "string" then
				sReplaceParticle = t
			end
		end

		return sReplaceParticle
	end
end
-----------------------------------客户端函数------------------------------------------------
if IsClient() then
	function Wearable_System:CustomGetTextureReplacement(hHero, sTextureName)
		local skinID = hHero:GetModifierStackCount("modifier_wearable_model", hHero)
		local sReplaceTexture = sTextureName
		if IsValid(hHero) then
			local sHeroName = hHero:GetUnitName()
			-- if IsInToolsMode() then
			-- 	skinID = "17000008"
			-- end
			local t = _G
			if skinID then
	
				for k, v in ipairs({ "SKIN_TEXTURE_CONFIG", sHeroName, sReplaceTexture, skinID }) do
					if t[v] then
						t = t[v]
					end
				end
			end
			if t and type(t) == "string" then
				sReplaceTexture = t
			end
		end

		return sReplaceTexture
	end
end