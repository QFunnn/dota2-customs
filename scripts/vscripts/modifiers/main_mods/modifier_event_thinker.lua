--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_event_thinker_test", "modifiers/main_mods/modifier_event_thinker", LUA_MODIFIER_MOTION_NONE)

modifier_event_thinker = class({})


function modifier_event_thinker:IsHidden() return false end
function modifier_event_thinker:IsPurgable() return false end



function modifier_event_thinker:CheckState()
return {
    [MODIFIER_STATE_UNSELECTABLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
}
end

function modifier_event_thinker:RemoveOnDeath() return false end

function modifier_event_thinker:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()

dota1x6.event_thinker_mod = self

self.neutral_mods = {
	"modifier_ursa_clap",
	"modifier_centaur_stun",
	"modifier_satyr_shockwave",
	"modifier_troll_raise",
	"modifier_satyr_purge",
	"modifier_ogre_armor",
	"modifier_golem_stun",
	"modifier_bird_tornado",
	"modifier_harpy_strike",
	
	"modifier_frostgolem_root_ability",
	"modifier_dragon_fire_ability",
	"modifier_lizard_frenzy",
	"modifier_prawler_clap",
}

self.items_effects = 
{
	["item_force_staff_custom"] = 1,
	["item_orchid_custom"] = 4,
	["item_diffusal_blade_custom"] = 5,
	["item_bloodthorn_custom"] = 6,
	["item_cyclone_custom"] = 7,
	["item_disperser_custom"] = 8,
	["item_sheepstick_custom"] = 9,
	["item_wind_waker_custom"] = 10,
	["item_heavens_halberd_custom"] = 12,
	["item_hurricane_pike_custom"] = 15,
}

self.dota_damage =
{
	["muerta_pierce_the_veil_custom"] = true,
}

self.test = false and test

self.max_per_tick = 20
self.event_table = {}

self.max_delay = 0
self.current_active = 0
self.done_count = 0
self.max_active = 0

self.events_per_sec = 0
self.events_out_per_sec = 0
self.max_mod = ""
self.max_mod_count = 0 
self.max_mod_parent = ""
self.mods_table = {}

self.caster_table = {}
self.count = 0

if self.test then
	self.parent:AddNewModifier(self.parent, nil, "modifier_event_thinker_test", {})
end

self.active = false
self.interval = test and FrameTime() or FrameTime()
end

function modifier_event_thinker:OnIntervalThink()
if not IsServer() then return end

local limit = 0
local ended = false
local all_done = false

--print('event thinks')

dota1x6:pcall(function()
	while ended == false do 
		local callback = self.event_table[1]
		
		if not callback then 
			all_done = true
			ended = true
		else
			table.remove(self.event_table, 1)

			if self.test then
				callback.callback()
				local delta = GameRules:GetDOTATime(false, false) - callback.time
				self.max_delay = delta >= self.max_delay and delta or self.max_delay
				self.current_active = self.current_active - 1
				self.events_out_per_sec = self.events_out_per_sec + 1
			else 
				callback()
			end
		end

		limit = limit + 1
		if limit >= self.max_per_tick then 
			ended = true
		end
	end
end)

if all_done then
	self.done_count = self.done_count + 1
	self.active = false
	self:StartIntervalThink(-1)
	--print('done!!')
end

--print('----')
end 

function modifier_event_thinker:StartThink(callback, mod, event_type)
if not IsServer() then return end

local callback_table = self.test and {callback = callback, time = GameRules:GetDOTATime(false, false)} or callback
table.insert(self.event_table, callback_table)

if self.test then

	self.current_active = self.current_active + 1
	self.max_active = self.current_active >= self.max_active and self.current_active or self.max_active

	self.events_per_sec = self.events_per_sec + 1

	local caster = mod:GetCaster()
	local mod_name = mod:GetName()

	if not self.mods_table[mod_name] then
		self.mods_table[mod_name] = 0
	end

	self.mods_table[mod_name] = self.mods_table[mod_name] + 1
	if self.mods_table[mod_name] > self.max_mod_count then
		self.max_mod_count = self.mods_table[mod_name]
		self.max_mod = mod_name
		self.max_mod_parent = caster:GetUnitName()
	end
end

--[[
if not self.caster_table[caster:GetUnitName()] then
	self.caster_table[caster:GetUnitName()] = {}
	self.caster_table[caster:GetUnitName()].count = 0
	self.caster_table[caster:GetUnitName()].events = {}
	self.caster_table[caster:GetUnitName()].mods = {}
end


if not self.caster_table[caster:GetUnitName()].mods[mod_name] then
	self.caster_table[caster:GetUnitName()].mods[mod_name] = {}
	self.caster_table[caster:GetUnitName()].mods[mod_name].count = 0
	self.caster_table[caster:GetUnitName()].mods[mod_name].events = {}
end

if not self.caster_table[caster:GetUnitName()].mods[mod_name].events[event_type] then
	self.caster_table[caster:GetUnitName()].mods[mod_name].events[event_type] = 0
end

self.caster_table[caster:GetUnitName()].mods[mod_name].count = self.caster_table[caster:GetUnitName()].mods[mod_name].count + 1
self.caster_table[caster:GetUnitName()].mods[mod_name].events[event_type] = self.caster_table[caster:GetUnitName()].mods[mod_name].events[event_type] + 1
self.caster_table[caster:GetUnitName()].count = self.caster_table[caster:GetUnitName()].count + 1
]]

if not self.active then
	self.active = true
	if not test then
		self:OnIntervalThink()
	end
	self:StartIntervalThink(self.interval)
end

end


function modifier_event_thinker:PrintStats()
if not IsServer() then return end

print('event test | -----')
print("event test | current active: "..self.current_active.."; max active: "..self.max_active.."; max delay: "..self.max_delay.."; done count: "..self.done_count..";")
--[[
for hero,data in pairs(self.caster_table) do
	print('event test | ######')
	print("event test | hero: "..hero.."; total: "..data.count..";")
	print("event test | 	mods:")
	for mod_name, mod_data in pairs(data.mods) do
		print("event test | 		"..mod_name.." : "..mod_data.count..";")
		for event_name, event_count in pairs(mod_data.events) do
			print("event test | 			"..event_name.." : "..event_count..";")
		end
	end
end]]

end


function modifier_event_thinker:DeclareFunctions()
return
{
	MODIFIER_EVENT_ON_ATTACK_LANDED,
	MODIFIER_EVENT_ON_TAKEDAMAGE,
	MODIFIER_EVENT_ON_DEATH,
	MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	MODIFIER_EVENT_ON_ATTACK,
	MODIFIER_EVENT_ON_ATTACK_START,
    MODIFIER_EVENT_ON_MODIFIER_ADDED,
    MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
	MODIFIER_EVENT_ON_ATTACK_RECORD,
	MODIFIER_EVENT_ON_ATTACK_FAIL,
	MODIFIER_EVENT_ON_RESPAWN,
  	MODIFIER_EVENT_ON_HEAL_RECEIVED,
  	MODIFIER_EVENT_ON_ABILITY_START,
}
end

function modifier_event_thinker:OnModifierAdded(params)
if not IsServer() then return end

local mod = params.added_buff
local unit = params.unit
local ability = mod:GetAbility()

if not mod then return end
if not unit then return end

if mod.GetModifierHealChange and unit:IsRealHero() then
	if not unit.heal_reduce_mods then
		unit.heal_reduce_mods = {}
	end
	local result = 0
	if ability and bit.band(ability:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
		result = 1
	end
	unit.heal_reduce_mods[mod] = result
end

if mod:GetName() == "modifier_status_effect_thinker_custom" then return end

if ability and ability:IsStolen() and perma_mods[mod:GetName()] then
	mod:Destroy()
	return
end

local modifier_hero_wearables_system = unit:FindModifierByName("modifier_hero_wearables_system")
if modifier_hero_wearables_system then
	modifier_hero_wearables_system:AddModifier(mod)
end

end

function modifier_event_thinker:OnAttackFail(params)
if not IsServer() then return end

local target = params.target
local attacker = params.attacker
if not attacker or not target then return end

if attacker.attack_fail_mods_out then
	for mod,sync_type in pairs(attacker.attack_fail_mods_out) do
		if IsValid(mod) and mod.AttackFailEvent_out ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackFailEvent_out(params)
					end
				end
				self:StartThink(callback, mod, "AttackFailEvent_out")
			else
				mod:AttackFailEvent_out(params)
			end
		else
			attacker.attack_fail_mods_out[mod] = nil
		end
	end 
end


if target.attack_fail_mods_inc then
	for mod,sync_type in pairs(target.attack_fail_mods_inc) do
		if IsValid(mod) and mod.AttackFailEvent_inc ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackFailEvent_inc(params)
					end
				end
				self:StartThink(callback, mod, "AttackFailEvent_inc")
			else
				mod:AttackFailEvent_inc(params)
			end
		else
			target.attack_fail_mods_inc[mod] = nil
		end
	end 
end

end


function modifier_event_thinker:OnAttackRecordDestroy(params)
if not IsServer() then return end

local attacker = params.attacker
if not attacker then return end

if attacker.record_destroy_mods then
	for mod,sync_type in pairs(attacker.record_destroy_mods) do
		if IsValid(mod) and mod.RecordDestroyEvent ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker) then
						mod:RecordDestroyEvent(params)
					end
				end
				self:StartThink(callback, mod, "RecordDestroyEvent")
			else
				mod:RecordDestroyEvent(params)
			end
		else
			attacker.record_destroy_mods[mod] = nil
		end
	end 
end

end



function modifier_event_thinker:OnAttackRecord(params)
if not IsServer() then return end
local attacker = params.attacker
local target = params.target
if attacker == nil or target == nil then return end

local attacker_mod = attacker

if attacker_mod.attack_create_mods then
	for mod,sync_type in pairs(attacker_mod.attack_create_mods) do
		if IsValid(mod) and mod.AttackCreateEvent ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackCreateEvent(params)
					end
				end
				self:StartThink(callback, mod, "AttackCreateEvent")
			else
				mod:AttackCreateEvent(params)
			end
		else
			attacker_mod.attack_create_mods[mod] = nil
		end
	end 
end

end

function modifier_event_thinker:OnAttackStart(params)
if not IsServer() then return end
local attacker = params.attacker
local target = params.target
if attacker == nil or target == nil then return end

attacker.attack_flag = nil
attacker.pre_attack_flag = nil
attacker.attack_damage_flag = nil
attacker.no_cleave_flag = nil

local attacker_mod = attacker
local target_mod = target

if attacker_mod.attack_record_mods_out then
	for mod,sync_type in pairs(attacker_mod.attack_record_mods_out) do
		if IsValid(mod) and mod.AttackRecordEvent_out ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackRecordEvent_out(params)
					end
				end
				self:StartThink(callback, mod, "SpellStartEvent")
			else
				mod:AttackRecordEvent_out(params)
			end
		else
			attacker_mod.attack_record_mods_out[mod] = nil
		end
	end 
end

if target_mod.attack_record_mods_inc then
	for mod,sync_type in pairs(target_mod.attack_record_mods_inc) do
		if IsValid(mod) and mod.AttackRecordEvent_inc ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackRecordEvent_inc(params)
					end
				end
				self:StartThink(callback, mod, "SpellStartEvent")
			else
				mod:AttackRecordEvent_inc(params)
			end
		else
			target_mod.attack_record_mods_inc[mod] = nil
		end
	end 
end

if attacker:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then return end
if not attacker:IsCreep() then return end
if attacker:IsSilenced() or attacker:IsStunned() or attacker:IsHexed() or attacker:HasModifier("modifier_neutral_cast_cd") then return end

local mod = nil

for i = 1,#self.neutral_mods do 
	if attacker:HasModifier(self.neutral_mods[i]) then 
		mod = attacker:FindModifierByName(self.neutral_mods[i])
		break
	end 
end 

if mod == nil then return end
if not mod:GetAbility() then return end
if attacker:GetMana() < mod:GetAbility():GetManaCost(1) then return end

mod:StartCast(params.target)
end 


function modifier_event_thinker:OnAbilityStart( params )
if not IsServer() then return end
if not params.ability then return end
if params.ability:IsToggle() then return end
if not params.unit then return end

for mod,sync_type in pairs(spell_start_mods) do 
	if IsValid(mod) and mod.SpellStartEvent ~= nil then 
		if sync_type == 2 then
			local callback = function() 
				if IsValid(mod, params.unit, params.ability) and (not params.target or IsValid(params.target)) then
					mod:SpellStartEvent(params)
				end
			end
			self:StartThink(callback, mod, "SpellStartEvent")
		else
			mod:SpellStartEvent(params)
		end
	else
		spell_start_mods[mod] = nil
	end
end 

end



function modifier_event_thinker:OnAbilityExecuted( params )
if not IsServer() then return end

local ability = params.ability
local caster = params.unit
local target = params.target

if not IsValid(caster, ability) then return end
if ability:IsToggle() then return end

if params.target and params.target:GetTeamNumber() ~= caster:GetTeamNumber() and caster:HasModifier("modifier_smoke_of_deceit") and not params.target:IsCreep() then
	caster:RemoveModifierByName("modifier_smoke_of_deceit")
end

if ability.GetCursorPosition and bit.band(ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
	params.point = ability:GetCursorPosition()
end

if NoPushSpells[ability:GetName()] then
	caster:AddNewModifier(caster, nil, "modifier_can_not_push", {duration = NoPushSpells[ability:GetName()]})
end

if ability:IsItem() and target and target ~= caster and self.items_effects[ability:GetName()] then
	local effect = ParticleManager:CreateParticle("particles/items_fx/generic_item_spell_caster.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(effect, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(effect, 2, Vector(self.items_effects[ability:GetName()], 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
end

local tp_mod = caster:FindModifierByName("modifier_custom_ability_teleport_tracker")
if tp_mod and tp_mod:GetAbility() == ability then
	tp_mod:SpellEvent(params)
end

if UnvalidAbilities[ability:GetName()] and not params.ignore_unvalid then return end
if UnvalidItems[ability:GetName()] then return end
if Recast_mods[ability:GetName()] and caster:HasModifier(Recast_mods[ability:GetName()]) then return end
if ability:IsItem() and ability:GetCurrentCharges() > 0 then return end
if (params.unit:IsRooted() or params.unit:IsLeashed()) and bit.band(ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES) ~= 0 then return end

for mod,sync_type in pairs(spell_cast_mods) do 
	if IsValid(mod) and mod.SpellEvent ~= nil then 
		if sync_type == 2 then
			local callback = function() 
				if IsValid(mod, params.unit, params.ability) and (not params.target or IsValid(params.target)) then
					mod:SpellEvent(params)
				end
			end
			self:StartThink(callback, mod, "SpellEvent")
		else
			mod:SpellEvent(params)
		end
	else
		spell_cast_mods[mod] = nil
	end
end 

if _G.WtfMode == true then 
	caster:SetMana(caster:GetMaxMana())
end 

end


function modifier_event_thinker:OnRespawn(params)
if not IsServer() then return end

local unit = params.unit
if not unit then return end

if unit.respawn_event_mods then
	for mod,sync_type in pairs(unit.respawn_event_mods) do
		if IsValid(mod) and mod.RespawnEvent ~= nil then 	
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.unit) then
						mod:RespawnEvent(params)
					end
				end
				self:StartThink(callback, mod, "RespawnEvent")
			else
				mod:RespawnEvent(params)
			end
		else
			unit.respawn_event_mods[mod] = nil
		end
	end 
end

if unit:IsRealHero() and not unit:IsReincarnating() and not unit:IsTempestDouble() and players[unit:GetId()] then
	start_quest:HideTip(unit:GetId())
end

end


function modifier_event_thinker:OnDeath(params)
if not IsServer() then return end
local killer = params.attacker
local unit = params.unit

if killer == nil then return end

if players[killer:GetId()] and unit:IsValidKill(killer) then 
    dota1x6:CountKill()
end 

for mod,sync_type in pairs(death_mods) do 
	if IsValid(mod) and mod.DeathEvent ~= nil then 
		if sync_type == 2 then
			local callback = function() 
				if IsValid(mod, unit, killer) then
					mod:DeathEvent(params)
				end
			end
			self:StartThink(callback, mod, "DeathEvent")
		else
			mod:DeathEvent(params)
		end
	else
		death_mods[mod] = nil
	end
end 

local killer_table = players[killer:GetId()]
if unit:IsCreepHero() then return end
if killer.owner == nil and not killer:IsHero() then return end

if unit:IsRealHero() and towers[unit:GetTeamNumber()] and killer:GetTeamNumber() ~= DOTA_TEAM_CUSTOM_5 and not unit:IsReincarnating() then 
	dota1x6:ActivatePushReduce(unit:GetTeamNumber(), nil, unit, killer)
end

if unit:IsRealHero() and not unit:IsReincarnating() and not unit:IsTempestDouble() and players[unit:GetId()] then
	Timers:CreateTimer(2, function()
		if IsValid(unit) and not unit:IsAlive() then
			start_quest:SendTip(unit:GetId())
		end
	end)
end

if killer_table == nil then return end

if unit:GetUnitName() == "patrol_range_bad" or
	unit:GetUnitName() == "patrol_melee_bad" or
	unit:GetUnitName() == "patrol_range_good" or 
	unit:GetUnitName() == "patrol_melee_good" then
	killer_table.patrol_kills = killer_table.patrol_kills + 1
end

if unit:GetUnitName() == "npc_dota_observer_wards" and unit:GetTeamNumber() ~= killer:GetTeamNumber() then 
	killer_table.obs_kills = killer_table.obs_kills + 1
end

if unit:GetUnitName() == "npc_dota_sentry_wards" and unit:GetTeamNumber() ~= killer:GetTeamNumber()  then 
	killer_table.sentry_kills = killer_table.sentry_kills + 1
end

if unit:IsNeutralUnitType() and unit:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
	start_quest:CheckQuest({quest_name = "Quest_3", id = killer:GetId(), creep = unit:GetUnitName()})
end

end



function modifier_event_thinker:OnAttack(params)
if not IsServer() then return end
local attacker = params.attacker
local target = params.target
if attacker == nil or target == nil then return end

local attacker_mod = attacker
if attacker_mod.owner and not attacker.is_arc_tempest and not attacker.is_monkey_soldier then
	attacker_mod = attacker_mod.owner
end

if attacker.pre_attack_flag then
	params.pre_attack_flag = attacker.pre_attack_flag
	attacker.pre_attack_flag = nil
end

local target_mod = target

if attacker_mod.attack_start_mods_out then
	for mod,sync_type in pairs(attacker_mod.attack_start_mods_out) do
		if IsValid(mod) and mod.AttackStartEvent_out ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackStartEvent_out(params)
					end
				end
				self:StartThink(callback, mod, "AttackStartEvent_out")
			else
				mod:AttackStartEvent_out(params)
			end
		else
			attacker_mod.attack_start_mods_out[mod] = nil
		end
	end 
end

if target_mod.attack_start_mods_inc then
	for mod,sync_type in pairs(target_mod.attack_start_mods_inc) do
		if IsValid(mod) and mod.AttackStartEvent_inc ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackStartEvent_inc(params)
					end
				end
				self:StartThink(callback, mod, "AttackStartEvent_inc")
			else
				mod:AttackStartEvent_inc(params)
			end
		else
			target_mod.attack_start_mods_inc[mod] = nil
		end
	end 
end

end


function modifier_event_thinker:OnAttackLanded(params)
if not IsServer() then return end
local attacker = params.attacker
local target = params.target
if attacker == nil or target == nil then return end

if attacker.attack_flag then
	params.attack_flag = attacker.attack_flag
	attacker.attack_flag = nil
end

if attacker.no_cleave_flag then
	params.no_cleave_flag = attacker.no_cleave_flag
	attacker.no_cleave_flag = nil
end

local attacker_mod = attacker
if attacker_mod.owner and not attacker.is_arc_tempest and not attacker.is_monkey_soldier then
	attacker_mod = attacker_mod.owner
elseif attacker_mod.summoner then
	attacker_mod = attacker_mod.summoner
end

local target_mod = target

if attacker_mod.attack_landed_mods_out then
	for mod,sync_type in pairs(attacker_mod.attack_landed_mods_out) do
		if IsValid(mod) and mod.AttackEvent_out ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.target) then
						mod:AttackEvent_out(params)
					end
				end
				self:StartThink(callback, mod, "AttackEvent_out")
			else
				mod:AttackEvent_out(params)
			end
		else
			attacker_mod.attack_landed_mods_out[mod] = nil
		end
	end 
end

if target_mod.attack_landed_mods_inc then
	local new_params = params
	if attacker.wd_ward_attack then
		new_params.attacker = attacker.wd_ward_attack
	end
	for mod,sync_type in pairs(target_mod.attack_landed_mods_inc) do
		if IsValid(mod) and mod.AttackEvent_inc ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, new_params.attacker, new_params.target) then
						mod:AttackEvent_inc(new_params)
					end
				end
				self:StartThink(callback, mod, "AttackEvent_inc")
			else
				mod:AttackEvent_inc(new_params)
			end
		else
			target_mod.attack_landed_mods_inc[mod] = nil
		end
	end 
end


if (attacker:IsTempestDouble() or attacker:HasModifier("modifier_life_stealer_infest_custom_legendary_creep")) and attacker.owner then 
	attacker = attacker.owner
end 

if (attacker:GetQuest() and not attacker:QuestCompleted()) then 
	if target:IsRealHero() then 
		local logic_mod = attacker:FindModifierByName("modifier_quest_logic")
		if logic_mod and logic_mod.quest_attack_logic then
			logic_mod.quest_attack_logic(params)
		end
	end
end

end



function modifier_event_thinker:OnHealReceived(params)
if not IsServer() then return end
local unit = params.unit
local inflictor = params.inflictor

if unit == nil then return end

params.prev_health = unit:GetHealth()

if unit.heal_mods_inc then
	for mod,sync_type in pairs(unit.heal_mods_inc) do
		if IsValid(mod) and mod.HealEvent_inc ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.unit) then
						mod:HealEvent_inc(params)
					end
				end
				self:StartThink(callback, mod, "HealEvent_inc")
			else
				mod:HealEvent_inc(params)
			end
		else
			unit.heal_mods_inc[mod] = nil
		end
	end 
end

if not unit:IsRealHero() or unit:IsTempestDouble() then return end
if not inflictor then return end

local healing = math.min(math.floor(params.gain), unit:GetMaxHealth() - unit:GetHealth())

local new_name = nil
if unit.ReplaceHealing and unit.ReplaceHealing.new_name and unit.ReplaceHealing.inflictor and unit.ReplaceHealing.inflictor == inflictor then
	new_name = unit.ReplaceHealing.new_name
	unit.ReplaceHealing = {}
end

if healing > 0 then
	local callback = function() 
		if IsValid(params.unit) then
			self:HealingTableCount(unit, healing, new_name, inflictor, "healing")
		end
	end	
	self:StartThink(callback, self, "HealingTableCount")
end

end

function modifier_event_thinker:HealingTableCount(unit, healing, new_name, inflictor, healing_type)
local unit_table = players[unit:GetId()]
if not unit_table then return end

local ability_name = new_name
if not ability_name and IsValid(inflictor) then
	ability_name = inflictor:GetName()
end

if not ability_name then return end

local time = GameRules:GetDOTATime(false, false)
if not unit_table.temp_damage_stat["healing"] then
	unit_table.temp_damage_stat["healing"] = {}
	unit_table.temp_damage_stat["healing"].damages = {}
end
unit_table.temp_damage_stat["healing"].time = time

if unit.lifestealer_creep and unit.owner then
	unit = unit_table
end

self:FillHealingTable(unit_table.temp_damage_stat["healing"].damages, ability_name, unit, inflictor, healing_type, healing)
self:FillHealingTable(unit_table.healing_inc, ability_name, unit, inflictor, healing_type, healing)
end

function modifier_event_thinker:FillHealingTable(damage_table, ability_name, unit, inflictor, healing_type, amount)

if not damage_table[ability_name] then
	local unit_name = unit:GetUnitName()

	local ability_type = nil

	local icons_table = (talents_icons[unit_name] and talents_icons[unit_name][ability_name]) and talents_icons[unit_name] or talents_icons["general"]
	local icon_name = ""
	local color = ""
	if icons_table and icons_table[ability_name] and icons_table[ability_name].icon then 
	    icon_name = icons_table[ability_name].icon
	    if icons_table[ability_name].color then 
	        color = icons_table[ability_name].color
	    end
	    ability_type = "talent"
	end

	if not ability_type then
		ability_type = (IsValid(inflictor) and inflictor:IsItem()) and "item" or "ability"
	end

	damage_table[ability_name] = {}
	damage_table[ability_name].new_icon = icon_name
	damage_table[ability_name].color = color
	damage_table[ability_name].damage = 0
	damage_table[ability_name].type = ability_type
	damage_table[ability_name].healing_type = healing_type
end

damage_table[ability_name].damage = damage_table[ability_name].damage + amount
end




function modifier_event_thinker:OnTakeDamage(params)
if not IsServer() then return end
local attacker = params.attacker
local unit = params.unit

if attacker == nil or unit == nil then return end

if attacker.custom_flag then
	params.custom_flag = attacker.custom_flag
	attacker.custom_flag = nil
end

if attacker.attack_damage_flag and not params.inflictor then
	params.attack_damage_flag = attacker.attack_damage_flag
	attacker.attack_damage_flag = nil
end

local attacker_mod = attacker
if attacker_mod.owner and not attacker.is_arc_tempest and not attacker.is_monkey_soldier then
	attacker_mod = attacker_mod.owner
end

local target_mod = unit

if attacker_mod.take_damage_mods_out then
	for mod,sync_type in pairs(attacker_mod.take_damage_mods_out) do
		if IsValid(mod) and mod.DamageEvent_out ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, params.attacker, params.unit) then
						mod:DamageEvent_out(params)
					end
				end
				self:StartThink(callback, mod, "DamageEvent_out")
			else
				mod:DamageEvent_out(params)
			end
		else
			attacker_mod.take_damage_mods_out[mod] = nil
		end
	end 
end

if target_mod.take_damage_mods_inc then
	local new_params = params
	if attacker.wd_ward_attack then
		new_params.attacker = attacker.wd_ward_attack
	end
	if unit:GetHealth() <= 1 then
		new_params.lethal_damage = true
	end
	for mod,sync_type in pairs(target_mod.take_damage_mods_inc) do
		if IsValid(mod) and mod.DamageEvent_inc ~= nil then 
			if sync_type == 2 then
				local callback = function() 
					if IsValid(mod, new_params.attacker, new_params.unit) then
						mod:DamageEvent_inc(new_params)
					end
				end
				self:StartThink(callback, mod, "DamageEvent_inc")
			else
				mod:DamageEvent_inc(new_params)
			end
		else
			target_mod.take_damage_mods_inc[mod] = nil
		end
	end 
end

if attacker:GetTeamNumber() == unit:GetTeamNumber() then return end

if attacker:IsRealHero() and unit:IsRealHero() and unit:IsAlive() and (attacker:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D() < 1000 then 
	dota1x6:ActivatePushReduce(attacker:GetTeamNumber(), unit:GetId())
	dota1x6:ActivatePushReduce(unit:GetTeamNumber(), attacker:GetId())
end

if not params.inflictor or self.dota_damage[params.inflictor:GetName()] then
	self:CheckDamageData(params)
end

if (unit:GetQuest() and not unit:QuestCompleted()) then 
	if attacker:IsRealHero() then 
		local logic_mod = unit:FindModifierByName("modifier_quest_logic")
		if logic_mod and logic_mod.quest_damage_incoming_logic then
			logic_mod.quest_damage_incoming_logic(params)
		end
	end
end

if (attacker:IsTempestDouble() or attacker:HasModifier("modifier_life_stealer_infest_custom_legendary_creep")) and attacker.owner then
	attacker = attacker.owner
end 

if unit:IsRealHero() then 
	if attacker:IsRealHero() then 
		if attacker:GetQuest() and not attacker:QuestCompleted() then 
			local logic_mod = attacker:FindModifierByName("modifier_quest_logic")
			if logic_mod and logic_mod.quest_damage_logic then
				logic_mod.quest_damage_logic(params)
			end
		end
	elseif attacker.owner then
		local owner = attacker.owner
		if owner:IsRealHero() and owner:GetTeamNumber() == attacker:GetTeamNumber() and owner:GetQuest() and not owner:QuestCompleted() then
			local logic_mod = owner:FindModifierByName("modifier_quest_logic")
			if logic_mod and logic_mod.quest_damage_units_logic then
				logic_mod.quest_damage_units_logic(params)
			end
		end
	end
end

end


function modifier_event_thinker:CheckDamageData(params)
if not IsServer() then return end
local unit = params.unit
local attacker = params.attacker
local damage = math.floor(params.damage)

if damage <= 0 or not unit:IsRealHero() or unit:IsTempestDouble() or not players[attacker:GetId()] or unit:GetTeamNumber() == attacker:GetTeamNumber() then return end

local override_attack = nil
if not params.inflictor then
	override_attack = attacker:AbilityAttack(params.attack_damage_flag)
end

local callback = function() 
	if IsValid(params.attacker, params.unit) then
		self:DamageTableCount(params, params.new_name, override_attack)
	end
end	
self:StartThink(callback, self, "DamageTableCount")
end


function modifier_event_thinker:DamageTableCount(params, new_name, override_attack)
local target = params.unit
local attacker = params.attacker

local attacker_table = players[attacker:GetId()]
local target_table = players[target:GetId()]

if not attacker_table or not target_table then return end

local attacker_name = attacker_table:GetUnitName()
local damage_type = params.damage_type ~= 0 and params.damage_type or DAMAGE_TYPE_PURE
local damage = params.damage

local inflictor = params.inflictor
local ability_name = IsValid(inflictor) and inflictor:GetName() or nil

if not target_table.damage_inc[attacker_name] then
	target_table.damage_inc[attacker_name] = {}
	target_table.damage_inc[attacker_name].phys = 0
	target_table.damage_inc[attacker_name].magic = 0
	target_table.damage_inc[attacker_name].pure = 0
	target_table.damage_inc[attacker_name].all_damage = 0
end
  
target_table.damage_inc[attacker_name].all_damage = target_table.damage_inc[attacker_name].all_damage + damage

if damage_type == DAMAGE_TYPE_PHYSICAL then
  target_table.damage_inc[attacker_name].phys = target_table.damage_inc[attacker_name].phys + damage
elseif damage_type == DAMAGE_TYPE_MAGICAL then
  target_table.damage_inc[attacker_name].magic = target_table.damage_inc[attacker_name].magic + damage
elseif damage_type == DAMAGE_TYPE_PURE then
  target_table.damage_inc[attacker_name].pure = target_table.damage_inc[attacker_name].pure + damage
end

local ability_type = "attack"
if IsValid(inflictor) then
	ability_type = inflictor:IsItem() and "item" or "ability"
elseif override_attack then
	ability_type = "ability"
	ability_name = override_attack
else
    ability_name = "attack"
end

if new_name then
	ability_name = new_name
end

local time = GameRules:GetDOTATime(false, false)
if not target_table.temp_damage_stat[attacker_name] then
	target_table.temp_damage_stat[attacker_name] = {}
	target_table.temp_damage_stat[attacker_name].damages = {}
end

if not attacker_table.temp_damage_stat["outgoing"] then
	attacker_table.temp_damage_stat["outgoing"] = {}
	attacker_table.temp_damage_stat["outgoing"].damages = {}
end
attacker_table.temp_damage_stat["outgoing"].time = time
target_table.temp_damage_stat[attacker_name].time = time

self:FillDamageTable(target_table.temp_damage_stat[attacker_name].damages, ability_name, attacker_name, ability_type, damage_type, damage)
self:FillDamageTable(attacker_table.temp_damage_stat["outgoing"].damages, ability_name, attacker_name, ability_type, damage_type, damage)
self:FillDamageTable(attacker_table.damage_out, ability_name, attacker_name, ability_type, damage_type, damage, time)
end


function modifier_event_thinker:FillDamageTable(damage_table, ability_name, attacker_name, ability_type, damage_type, amount, time)

if not damage_table[ability_name] then
	local icons_table = (talents_icons[attacker_name] and talents_icons[attacker_name][ability_name]) and talents_icons[attacker_name] or talents_icons["general"]
	local icon_name = ""
	local color = ""
	local type = ability_type

	if icons_table and icons_table[ability_name] and icons_table[ability_name].icon then 
	    icon_name = icons_table[ability_name].icon
	    if icons_table[ability_name].color then 
	        color = icons_table[ability_name].color
	    end
	    type = "talent"
	end
	damage_table[ability_name] = {}
	damage_table[ability_name].new_icon = icon_name
	damage_table[ability_name].color = color
	damage_table[ability_name].damage = 0
	damage_table[ability_name].time = time
	damage_table[ability_name].damage_type = damage_type
	damage_table[ability_name].damage_types = {}
	damage_table[ability_name].damage_types[DAMAGE_TYPE_MAGICAL] = 0
	damage_table[ability_name].damage_types[DAMAGE_TYPE_PHYSICAL] = 0
	damage_table[ability_name].damage_types[DAMAGE_TYPE_PURE] = 0
	damage_table[ability_name].type = type
end

damage_table[ability_name].damage = damage_table[ability_name].damage + amount
damage_table[ability_name].damage_types[damage_type] = damage_table[ability_name].damage_types[damage_type] + amount
end



modifier_quest_blink = class({})
function modifier_quest_blink:IsHidden() return false end
function modifier_quest_blink:IsPurgable() return false end



modifier_event_thinker_test = class(mod_hidden)
function modifier_event_thinker_test:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.mod = self.parent:FindModifierByName("modifier_event_thinker")

self:StartIntervalThink(1)
end

function modifier_event_thinker_test:OnIntervalThink()
if not IsServer() then return end

print('event test | speed: '..self.mod.events_per_sec.." / "..self.mod.events_out_per_sec.." | max: "..self.mod.max_mod_parent.." : "..self.mod.max_mod.." : "..self.mod.max_mod_count)
self.mod.events_per_sec = 0 
self.mod.max_mod = ""
self.mod.max_mod_parent = ""
self.mod.max_mod_count = 0
self.mod.events_out_per_sec = 0
self.mod.mods_table = {}
end