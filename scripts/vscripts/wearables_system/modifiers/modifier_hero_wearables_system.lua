--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local invis_mods_set = nil

local wearables_nodraw_heroes = {
	["npc_dota_hero_crystal_maiden"] = true,
	["npc_dota_hero_lina"] = true,
	["npc_dota_hero_terrorblade"] = true,
}

local hero_effect_kinds = {}
local function HeroHasItemEffect(hero_name, kind)
	if not hero_effect_kinds[hero_name] then
		local kinds = {}
		local items_list = wearables_system.ITEMS_LIST[hero_name]
		if items_list then
			for _, item in pairs(items_list) do
				local effects = wearables_item_effects[tonumber(item.item_id)]
				if effects then
					for effect_kind, _ in pairs(effects) do
						kinds[string.gsub(effect_kind, "_style", "")] = true
					end
				end
			end
		end
		hero_effect_kinds[hero_name] = kinds
	end
	return hero_effect_kinds[hero_name][kind] == true
end

modifier_hero_wearables_system = class({})
function modifier_hero_wearables_system:IsHidden()
	return true
end
function modifier_hero_wearables_system:IsPurgable()
	return false
end
function modifier_hero_wearables_system:IsPurgeException()
	return false
end
function modifier_hero_wearables_system:RemoveOnDeath()
	return false
end
function modifier_hero_wearables_system:OnCreated()
	self.parent = self:GetParent()
	if not IsServer() then
		return
	end
	if not invis_mods_set then
		invis_mods_set = {}
		for _, name in pairs(invis_mods) do
			invis_mods_set[name] = true
		end
	end
	self.model_changed = false
	self.parent.modifier_hero_wearables_system = self
	self.hero_name = self.parent:GetUnitName()
	if
		wearables_nodraw_heroes[self.hero_name]
		or HeroHasItemEffect(self.hero_name, "kill")
		or HeroHasItemEffect(self.hero_name, "death")
	then
		self.parent:AddDeathEvent(self)
	end
	self.parent:AddRespawnEvent(self)
	if HeroHasItemEffect(self.hero_name, "attack") then
		self.parent:AddAttackEvent_out(self, true)
	end
	self.no_draw_mods = {}
	self.status_table = {}
	self.no_draw_exception = {}
	self.exception_items = {}
	self.has_exception = false
	self.invis_state = false
	self.hide_state = false
	self.status_state = false
	self.interval = 0.2
	if self.parent:IsIllusion() or self.parent:IsTempestDouble() then
		self.interval = 0.4
	end
end

function modifier_hero_wearables_system:UpdatePlayerItems()
	if not self.parent or self.parent:IsNull() then
		return
	end
	self:OnModelChanged({ attacker = self.parent, fast = true })
	self.invis_state = false
	self.hide_state = false
	self.status_state = false
	self:UpdateInvis()
	self:CheckNoDraw()
	self:CheckStatusTable()
end

function modifier_hero_wearables_system:UpdateEffectsList(modifier, modifier_name)
	modifier_name = modifier_name or modifier:GetName()
	if modifier_name == "modifier_morphling_replicate_custom" then
		return
	end
	if
		not dota_modifiers_status[modifier_name]
		and (not modifier.GetStatusEffectName or not modifier:GetStatusEffectName())
	then
		return
	end
	local table_result = {}
	local priority = 0
	local status_name = nil
	table_result.status_mod = modifier
	if dota_modifiers_status[modifier_name] then
		status_name = dota_modifiers_status[modifier_name][1]
		priority = dota_modifiers_status[modifier_name][2]
	else
		status_name = modifier:GetStatusEffectName()
	end
	if modifier.StatusEffectPriority ~= nil then
		local mod_priority = modifier:StatusEffectPriority()
		if mod_priority ~= nil then
			priority = mod_priority
		end
	end
	table_result.mod_table = {}
	local items_list = self.parent.items_list
	if items_list then
		for _, item in pairs(items_list) do
			if item and not item:IsNull() then
				table.insert(
					table_result.mod_table,
					item:AddNewModifier(
						self.parent,
						nil,
						"modifier_status_effect_thinker_custom",
						{ name = status_name, priority = priority }
					)
				)
			end
		end
	end
	if priority == MODIFIER_PRIORITY_ILLUSION then
		return
	end
	self.status_table[table_result] = true
	if not self.status_state then
		self.status_state = true
		self:CheckInterval()
	end
end

function modifier_hero_wearables_system:AddModifier(mod)
	if not IsServer() then
		return
	end
	local mod_name = mod:GetName()
	self:UpdateEffectsList(mod, mod_name)
	if invis_mods_set[mod_name] then
		self:UpdateInvis()
	end
	if modifiers_alpha[mod_name] then
		self:AddNoDrawMod(mod)
	end
end

function modifier_hero_wearables_system:UpdateInvis()
	local invis_state = false
	for _, name in pairs(invis_mods) do
		if self.parent:HasModifier(name) then
			invis_state = true
			break
		end
	end
	if invis_state ~= self.invis_state then
		self.invis_state = invis_state
		local items_list = self.parent:GetPlayerWearables()
		for _, item in pairs(items_list) do
			if item and not item:IsNull() then
				local mod = item:FindModifierByName("modifier_donate_hero_illusion_item")
				if mod then
					mod:UpdateState(invis_state)
				end
			end
		end
		self:CheckInterval()
	end
end

function modifier_hero_wearables_system:AddNoDrawMod(mod, add_exception)
	if add_exception then
		self.has_exception = true
		self.no_draw_exception[mod] = true
	end
	self.no_draw_mods[mod] = true
	self:CheckNoDraw()
end

function modifier_hero_wearables_system:RemoveException(delete_mod)
	local has_exception = false
	for mod, _ in pairs(self.no_draw_exception) do
		if not mod or mod:IsNull() or mod == delete_mod then
			self.no_draw_exception[mod] = nil
		else
			has_exception = true
		end
	end
	if has_exception ~= self.has_exception then
		self.has_exception = has_exception
		self:CheckInterval(true)
	end
end

function modifier_hero_wearables_system:CheckStatusTable()
	local status_state = false
	for data, _ in pairs(self.status_table) do
		if data.status_mod and not data.status_mod:IsNull() then
			status_state = true
		else
			if data.mod_table then
				for _, mod in pairs(data.mod_table) do
					if mod and not mod:IsNull() then
						mod:Destroy()
					end
				end
			end
			self.status_table[data] = nil
		end
	end
	if status_state ~= self.status_state then
		self.status_state = status_state
		self:CheckInterval()
	end
end

function modifier_hero_wearables_system:CheckNoDraw()
	local hide_state = false
	for mod, _ in pairs(self.no_draw_mods) do
		if mod and not mod:IsNull() and (mod.NoDraw or modifiers_alpha[mod:GetName()]) then
			hide_state = true
			break
		else
			self.no_draw_mods[mod] = nil
		end
	end
	if self.hide_state ~= hide_state then
		self.hide_state = hide_state
		self:CheckInterval()
		if self.hide_state == true then
			local items_list = self.parent:GetPlayerWearables()
			for _, item in pairs(items_list) do
				if item and not item:IsNull() then
					item:AddEffects(EF_NODRAW)
				end
			end
		else
			self:OnModelChanged({ attacker = self.parent, fast = true })
		end
	end
end

function modifier_hero_wearables_system:CheckInterval(on_interval)
	if
		self.invis_state == false
		and (self.hide_state == false or self.has_exception)
		and self.status_state == false
	then
		self:StartIntervalThink(-1)
	else
		if on_interval then
			self:OnIntervalThink()
		end
		self:StartIntervalThink(self.interval)
	end
end

function modifier_hero_wearables_system:OnIntervalThink()
	if not IsServer() then
		return
	end
	if self.invis_state then
		self:UpdateInvis()
	end
	if self.hide_state and self.has_exception == false then
		self:CheckNoDraw()
	end
	if self.status_state then
		self:CheckStatusTable()
	end
end

function modifier_hero_wearables_system:StartMorph()
	if not IsServer() then
		return
	end
	local items_list = self.parent:GetPlayerWearables()
	for _, item in pairs(items_list) do
		if item and not item:IsNull() then
			self.exception_items[item] = true
			item:AddEffects(EF_NODRAW)
		end
	end
end

function modifier_hero_wearables_system:EndMorph()
	if not IsServer() then
		return
	end
	self.exception_items = {}
	self:OnModelChanged({ attacker = self.parent, fast = true })
end

function modifier_hero_wearables_system:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_MODEL_CHANGED,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
	}
end

function modifier_hero_wearables_system:GetAttackSound()
	if self.parent.new_attack_sound then
		return self.parent.new_attack_sound
	end
end

function modifier_hero_wearables_system:OnModelChanged(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self.parent then
		return
	end
	if self.parent:GetModelName() == self.parent.current_model or self.parent.current_model == nil then
		if (self.model_changed or params.fast) and not self.hide_state then
			self:UnHideItems(params.fast)
			self.model_changed = false
		end
	else
		if not self.model_changed or self.hide_state then
			self.model_changed = true
			self:HideItems()
		end
	end
	if not self.hide_state then
		if self.parent.morphling_ult_items then
			for _, item in pairs(self.parent.morphling_ult_items) do
				if item and not item:IsNull() then
					item:RemoveEffects(EF_NODRAW)
				end
			end
		end
	end
end

function modifier_hero_wearables_system:RespawnEvent(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self.parent then
		return
	end
	if self.NoDraw then
		self.NoDraw = nil
		self.parent:RemoveNoDraw()
		self:CheckNoDraw()
	end
end

function modifier_hero_wearables_system:DeathEvent(params)
	if not IsServer() then
		return
	end
	if params.unit == self.parent and self.parent:IsRealHero() then
		if self.hero_name == "npc_dota_hero_crystal_maiden" and not self.parent:IsAlive() then
			self.NoDraw = true
			self:AddNoDrawMod(self)
		end
		if self.hero_name == "npc_dota_hero_lina" then
			Timers:CreateTimer(2.1, function()
				if not self.parent:IsAlive() then
					self.NoDraw = true
					self:AddNoDrawMod(self)
					self.parent:AddNoDraw()
				end
			end)
		end
		if self.hero_name == "npc_dota_hero_terrorblade" then
			Timers:CreateTimer(1.7, function()
				if not self.parent:IsAlive() then
					self.NoDraw = true
					self:AddNoDrawMod(self)
					self.parent:AddNoDraw()
				end
			end)
		end
	end
	self:ItemsDeathEvent(params)
end

function modifier_hero_wearables_system:GetItemEffect(kind)
	local items_list = self.parent.items_list_ids
	if not items_list then
		return
	end
	local items_data = wearables_system.ITEMS_DATA[self.hero_name]
	for _, item_id in pairs(items_list) do
		local item_data = items_data and items_data[tonumber(item_id)]
		local dota_id = item_data and tonumber(item_data.dota_id) or tonumber(item_id)
		local effects = wearables_item_effects[dota_id]
		if effects then
			local style = item_data and tonumber(item_data.ItemStyle) or 0
			if style == 1 and effects[kind .. "_style"] then
				return effects[kind .. "_style"]
			end
			if effects[kind] then
				return effects[kind]
			end
		end
	end
end

function modifier_hero_wearables_system:ItemsDeathEvent(params)
	if params.attacker == self.parent and params.unit:IsRealHero() and params.unit ~= self.parent then
		local effect = self:GetItemEffect("kill")
		if effect then
			effect(self.parent, params.unit)
		end
	elseif params.unit == self.parent and not self.parent:IsIllusion() then
		local effect = self:GetItemEffect("death")
		if effect then
			effect(self.parent, self.parent)
		end
	end
end

function modifier_hero_wearables_system:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self.parent then
		return
	end
	local effect = self:GetItemEffect("attack")
	if not effect then
		return
	end
	effect(self.parent, params.target)
end

function modifier_hero_wearables_system:HideItems(no_hide)
	if not IsServer() then
		return
	end
	local items_list = self.parent:GetPlayerWearables()
	for _, item in pairs(items_list) do
		item:AddNoDraw()
		item:AddEffects(EF_NODRAW)
		if item.additional_models and #item.additional_models > 0 then
			for _, model in pairs(item.additional_models) do
				model:AddNoDraw()
				model:AddEffects(EF_NODRAW)
			end
		end
	end
	if
		self.model_changed
		and not self.parent:HasModifier("modifier_morphling_replicate_custom")
		and not self.parent:HasModifier("modifier_enigma_demonic_conversion_custom_legendary_caster")
		and not self.parent:HasModifier("modifier_life_stealer_infest_custom")
	then
		CustomGameEventManager:Send_ServerToAllClients(
			"force_update_player_hidden",
			{ entindex = self.parent:entindex(), enable = true }
		)
		if self.parent:IsRealHero() then
			CustomGameEventManager:Send_ServerToAllClients(
				"force_update_player_portrait",
				{ entindex = self.parent:entindex(), model_change = 1, hero_name = self.parent:GetUnitName() }
			)
		end
	end
end

function modifier_hero_wearables_system:UnHideItems(is_fast)
	if not IsServer() then
		return
	end
	local items_list = self.parent:GetPlayerWearables()
	for _, item in pairs(items_list) do
		local should_hide = false
		if self.exception_items[item] then
			should_hide = true
		end
		if should_hide then
			item:AddEffects(EF_NODRAW)
		else
			item:RemoveNoDraw()
			item:RemoveEffects(EF_NODRAW)
		end
		if item.additional_models and #item.additional_models > 0 then
			for _, model in pairs(item.additional_models) do
				model:RemoveNoDraw()
				model:RemoveEffects(EF_NODRAW)
			end
		end
	end
	CustomGameEventManager:Send_ServerToAllClients("force_update_player_hidden", { entindex = self.parent:entindex() })
	if not is_fast or self.model_changed then
		if self.parent:IsRealHero() then
			CustomGameEventManager:Send_ServerToAllClients(
				"force_update_player_portrait",
				{ entindex = self.parent:entindex(), model_change = 1, hero_name = self.parent:GetUnitName() }
			)
		end
	end
end