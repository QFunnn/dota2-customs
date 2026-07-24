--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_wearables_system = class({})
function modifier_hero_wearables_system:IsHidden() return true end
function modifier_hero_wearables_system:IsPurgable() return false end
function modifier_hero_wearables_system:IsPurgeException() return false end
function modifier_hero_wearables_system:RemoveOnDeath() return false end
function modifier_hero_wearables_system:OnCreated()
    self.parent = self:GetParent()
    if not IsServer() then return end
    print("INIT modifier_hero_wearables_system")
    self.model_changed = false
    self.hero_name = self.parent:GetUnitName()
    self.parent:AddDeathEvent(self)
    self.parent:AddRespawnEvent(self)
    self.parent:AddAttackEvent_out(self, true)
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
    if not self.parent or self.parent:IsNull() then return end
    self:OnModelChanged({attacker = self.parent, fast = true})
    self.invis_state = false
    self.hide_state = false
    self.status_state = false
    self:UpdateInvis()
    self:CheckNoDraw()
    self:CheckStatusTable()
end

function modifier_hero_wearables_system:UpdateEffectsList(modifier)
    local modifier_name = modifier:GetName()
    if modifier_name == "modifier_morphling_replicate_custom" then return end
    if not dota_modifiers_status[modifier_name] and (not modifier.GetStatusEffectName or not modifier:GetStatusEffectName()) then return end
    local table_result = {}
    local priority = 0
    local status_name = nil
    table_result.status_mod = modifier
    if (dota_modifiers_status[modifier_name]) then
        status_name = dota_modifiers_status[modifier_name][1]
        priority = dota_modifiers_status[modifier_name][2]
    else
        status_name = modifier:GetStatusEffectName()
    end
    if (modifier.StatusEffectPriority ~= nil and modifier:StatusEffectPriority() ~= nil) then
        priority = modifier:StatusEffectPriority()
    end
    table_result.mod_table = {}
    local items_list = self.parent:GetPlayerWearables()
    for _,item in pairs(items_list) do
        if item and not item:IsNull() then
            table.insert(table_result.mod_table, item:AddNewModifier(self.parent, nil, "modifier_status_effect_thinker_custom", {name = status_name, priority = priority}))
        end
    end
    if priority == MODIFIER_PRIORITY_ILLUSION then return end
    self.status_table[table_result] = true
    self:CheckStatusTable()
end

function modifier_hero_wearables_system:AddModifier(mod)
    if not IsServer() then return end
    self:UpdateEffectsList(mod)
    self:UpdateInvis()
    if modifiers_alpha[mod:GetName()] then
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
        for _,item in pairs(items_list) do
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
    for mod,_ in pairs(self.no_draw_exception) do
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
    for data,_ in pairs(self.status_table) do
        if data.status_mod and not data.status_mod:IsNull() then
            status_state = true
        else
            if data.mod_table then
                for _,mod in pairs(data.mod_table) do
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
    for mod,_ in pairs(self.no_draw_mods) do
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
            self:OnModelChanged({attacker = self.parent, fast = true})
        end
    end
end

function modifier_hero_wearables_system:CheckInterval(on_interval)
    if self.invis_state == false and (self.hide_state == false or self.has_exception) and self.status_state == false then
        self:StartIntervalThink(-1)
    else
        if on_interval then
            self:OnIntervalThink()
        end
        self:StartIntervalThink(self.interval)
    end
end

function modifier_hero_wearables_system:OnIntervalThink()
    if not IsServer() then return end
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
    if not IsServer() then return end
    local items_list = self.parent:GetPlayerWearables()
    for _, item in pairs(items_list) do
        if item and not item:IsNull() then
            self.exception_items[item] = true
            item:AddEffects(EF_NODRAW)
        end
    end
end

function modifier_hero_wearables_system:EndMorph()
    if not IsServer() then return end
    self.exception_items = {}
    self:OnModelChanged({attacker = self.parent, fast = true})
end

function modifier_hero_wearables_system:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_MODEL_CHANGED,
        MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND
    }
end

function modifier_hero_wearables_system:GetAttackSound()
    if self.parent.new_attack_sound then
        return self.parent.new_attack_sound
    end
end

function modifier_hero_wearables_system:OnModelChanged(params)
    if not IsServer() then return end
    if params.attacker ~= self.parent then return end
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
    if not IsServer() then return end
    if params.unit ~= self.parent then return end
    if self.NoDraw then
        self.NoDraw = nil
        self.parent:RemoveNoDraw() 
        self:CheckNoDraw()
    end
end

function modifier_hero_wearables_system:DeathEvent(params)
    if not IsServer() then return end
    if params.unit == self.parent and self.parent:IsRealHero() then
        if self.parent:GetUnitName() == "npc_dota_hero_crystal_maiden" and not self.parent:IsAlive() then
            self.NoDraw = true
            self:AddNoDrawMod(self)  
        end
        if self.parent:GetUnitName() == "npc_dota_hero_lina" then
            Timers:CreateTimer(2.1, function()
                if not self.parent:IsAlive() then
                    self.NoDraw = true
                    self:AddNoDrawMod(self)            
                    self.parent:AddNoDraw()
                end
            end)
        end
        if self.parent:GetUnitName() == "npc_dota_hero_terrorblade" then
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

function modifier_hero_wearables_system:ItemsDeathEvent(params)
    if params.attacker == self.parent and params.unit:IsRealHero() and params.unit ~= self.parent then
        if params.attacker:HasUnequipItem(6914) then
            local target_effect = ParticleManager:CreateParticle("particles/econ/items/zeus/arcana_chariot/zeus_arcana_kill_remnant.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        elseif params.attacker:HasUnequipItem(18539) and wearables_system.item_styles_saved[self.parent:GetUnitName()][18539] and wearables_system.item_styles_saved[self.parent:GetUnitName()][18539] == 1 then
            -- Death kill effect
            local caster_effect = ParticleManager:CreateParticle("particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_kill_caster_v2.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt(caster_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(caster_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(caster_effect)

            local target_effect = ParticleManager:CreateParticle("particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_kill_target_v2.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControlEnt(target_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        elseif params.attacker:HasUnequipItem(18539) then
            -- Death kill effect
            local caster_effect = ParticleManager:CreateParticle("particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_kill_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt(caster_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(caster_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(caster_effect)

            local target_effect = ParticleManager:CreateParticle("particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_kill_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControlEnt(target_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        elseif params.attacker:HasUnequipItem(19090) and wearables_system.item_styles_saved[self.parent:GetUnitName()][19090] and wearables_system.item_styles_saved[self.parent:GetUnitName()][19090] == 1 then
            -- Death kill effect
            local caster_effect = ParticleManager:CreateParticle("particles/econ/items/drow/drow_arcana/drow_v2_arcana_revenge_kill_effect_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt(caster_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(caster_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(caster_effect)

            local target_effect = ParticleManager:CreateParticle("particles/econ/items/drow/drow_arcana/drow_v2_arcana_revenge_kill_effect_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControlEnt(target_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        elseif params.attacker:HasUnequipItem(19090) then
            -- Death kill effect
            local caster_effect = ParticleManager:CreateParticle("particles/econ/items/drow/drow_arcana/drow_arcana_revenge_kill_effect_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt(caster_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(caster_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(caster_effect)

            local target_effect = ParticleManager:CreateParticle("particles/econ/items/drow/drow_arcana/drow_arcana_revenge_kill_effect_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControlEnt(target_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        elseif params.attacker:HasUnequipItem(23095) and wearables_system.item_styles_saved[self.parent:GetUnitName()][23095] and wearables_system.item_styles_saved[self.parent:GetUnitName()][23095] == 1 then
            -- Death kill effect
            local caster_effect = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_kill_effect_caster_v2.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControl(caster_effect, 2, self.parent:GetAbsOrigin())
            ParticleManager:SetParticleControl(caster_effect, 3, self.parent:GetAbsOrigin())
            ParticleManager:SetParticleControlEnt(caster_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(caster_effect)

            local target_effect = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_kill_effect_target_v2.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        elseif params.attacker:HasUnequipItem(23095) then
            -- Death kill effect
            local caster_effect = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_kill_effect_caster.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControl(caster_effect, 2, self.parent:GetAbsOrigin())
            ParticleManager:SetParticleControl(caster_effect, 3, self.parent:GetAbsOrigin())
            ParticleManager:SetParticleControlEnt(caster_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(caster_effect)

            local target_effect = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_kill_effect_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
            ParticleManager:SetParticleControl(target_effect, 1, params.unit:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(target_effect)
        end
    elseif params.unit == self.parent and not self.parent:IsIllusion() then
        if params.unit:HasUnequipItem(6996) then
            local nFXIndex = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt( nFXIndex, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetOrigin(), false )
            ParticleManager:SetParticleControlEnt( nFXIndex, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetOrigin(), false )
            ParticleManager:ReleaseParticleIndex( nFXIndex )
        elseif params.unit:HasUnequipItem(7247) then
            local particle = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
        elseif params.unit:HasUnequipItem(7385) then
            local particle = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_death_arcana.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
        elseif params.attacker:HasUnequipItem(23095) and wearables_system.item_styles_saved[self.parent:GetUnitName()][23095] and wearables_system.item_styles_saved[self.parent:GetUnitName()][23095] == 1 then
            local nFXIndex = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_death_v2.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	        ParticleManager:SetParticleControlEnt( nFXIndex, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetOrigin(), false )
	        ParticleManager:ReleaseParticleIndex( nFXIndex )
        elseif params.attacker:HasUnequipItem(23095) then
            local nFXIndex = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	        ParticleManager:SetParticleControlEnt( nFXIndex, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetOrigin(), false )
	        ParticleManager:ReleaseParticleIndex( nFXIndex )
        end
    end
end

function modifier_hero_wearables_system:AttackEvent_out(params)
    if not IsServer() then return end
    if params.attacker == self.parent then
        if params.attacker:HasUnequipItem(23095) and wearables_system.item_styles_saved[self.parent:GetUnitName()][23095] and wearables_system.item_styles_saved[self.parent:GetUnitName()][23095] == 1 then
            local particle_attack = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_v2_base_attack_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
            ParticleManager:SetParticleControlEnt(particle_attack, 1, params.target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle_attack)
            local length = params.target:GetAbsOrigin() - self.parent:GetAbsOrigin()
            length.z = 0
            length = length:Length2D()
            if length >= 200 then
                local particle_on_hit = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_v2_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
                ParticleManager:SetParticleControlEnt(particle_on_hit, 3, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
                ParticleManager:SetParticleControlEnt(particle_on_hit, 1, params.target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(particle_on_hit)
            end
        elseif params.attacker:HasUnequipItem(23095) then
            local particle_attack = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_base_attack_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
            ParticleManager:SetParticleControlEnt(particle_attack, 1, params.target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(particle_attack)
            local length = params.target:GetAbsOrigin() - self.parent:GetAbsOrigin()
            length.z = 0
            length = length:Length2D()
            if length >= 200 then
                local particle_on_hit = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_base_attack.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
                ParticleManager:SetParticleControlEnt(particle_on_hit, 3, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
                ParticleManager:SetParticleControlEnt(particle_on_hit, 1, params.target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", params.target:GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(particle_on_hit)
            end
        end
    end
end


function modifier_hero_wearables_system:HideItems(no_hide)
    if not IsServer() then return end
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
    if self.model_changed and not self.parent:HasModifier("modifier_morphling_replicate_custom") and not self.parent:HasModifier("modifier_enigma_demonic_conversion_custom_legendary_caster") and not self.parent:HasModifier("modifier_life_stealer_infest_custom") then
        CustomGameEventManager:Send_ServerToAllClients("force_update_player_hidden", {entindex = self.parent:entindex(), enable = true})
        if self.parent:IsRealHero() then
            CustomGameEventManager:Send_ServerToAllClients("force_update_player_portrait", {entindex = self.parent:entindex(), model_change = 1, hero_name = self.parent:GetUnitName()})
        end
    end
end

function modifier_hero_wearables_system:UnHideItems(is_fast)
    if not IsServer() then return end
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
    CustomGameEventManager:Send_ServerToAllClients("force_update_player_hidden", {entindex = self.parent:entindex()})
    if not is_fast or self.model_changed then
        if self.parent:IsRealHero() then
            CustomGameEventManager:Send_ServerToAllClients("force_update_player_portrait", {entindex = self.parent:entindex(), model_change = 1, hero_name = self.parent:GetUnitName()})
        end
    end
end