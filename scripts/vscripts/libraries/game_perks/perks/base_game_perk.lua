--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


base_game_perk = class({})

function base_game_perk:IsHidden()
	return false
end
function base_game_perk:IsPurgable()
	return false
end
function base_game_perk:IsPurgeException()
	return false
end
function base_game_perk:RemoveOnDeath()
	return false
end
function base_game_perk:IsPerk()
	return true
end

function base_game_perk:_CheckCorrectPerksCount()
	local perk_counts = 0
	for i = 0, self.parent:GetModifierCount() - 1 do
		local name = self.parent:GetModifierNameByIndex(i)
		if name then
			local mod = self.parent:FindModifierByName(name)
			if mod and mod.IsPerk then
				perk_counts = perk_counts + 1
			end
		end
	end
	return perk_counts <= 1
end

function base_game_perk:CheckPerksCounts()
	if not IsServer() then
		return
	end

	if not self:_CheckCorrectPerksCount() then
		self:Destroy()
		return true
	end

	return false
end

function base_game_perk:CalculateValueByLevel(const, level_counter, bonus_per_level)
	if not IsValidEntity(self.parent) then
		return 0
	end

	local hero_lvl = self.parent:GetLevel()
	return math.floor(hero_lvl / level_counter) * bonus_per_level + const
end

function base_game_perk:GetTexture()
	return "perkIcons/" .. self:GetName()
end

function base_game_perk:OnCreated(kv)
	self.parent = self:GetParent()
	self.player_id = self.parent:GetPlayerOwnerID()

	if self:CheckPerksCounts() then
		return
	end

	self:SetHasCustomTransmitterData(true)

	if IsServer() then
		self.perk_tier = kv.perk_tier
		self.specials = GamePerks:GetPerksValues(self:GetName(), self.perk_tier)

		self:MergeSpecialsToModifier()
		self:SendBuffRefreshToClients()
	end

	if self.__OnCreated then
		self:__OnCreated()
	end
end

function base_game_perk:AddCustomTransmitterData()
	return self.specials
end

function base_game_perk:HandleCustomTransmitterData(kv)
	self.specials = kv
	self:MergeSpecialsToModifier()
end

function base_game_perk:MergeSpecialsToModifier()
	for k, v in pairs(self.specials) do
		self[k] = v
	end
end