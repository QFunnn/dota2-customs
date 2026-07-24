--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


largo_encore = class({})

--------------------------------------------------------------------------------
-- ФОРМУЛА КАПА
--------------------------------------------------------------------------------
-- В KV (`buff_amplification`) лежит 1% + 0.2% за уровень героя. KV сам по себе
-- не умеет клиппиться -- тултип показывает сырое значение и на высоких уровнях
-- врёт (47% на L233). Реальный кап действует ниже, в ProcessBuffDuration.
local LARGO_ENCORE_CAP = 20

--------------------------------------------------------------------------------
-- ИСКЛЮЧЕНИЯ: модификаторы, на которые врождёнка НЕ распространяется
--------------------------------------------------------------------------------
-- Сюда добавляй имена модификаторов, которые врождёнка должна оставить нетронутыми,
-- даже если их источник (абилка/предмет) принадлежит Largo и прошёл общую проверку.
-- Ключ -- имя модификатора (одно значение = одна запись). Значение -- `true`.
-- Это исключения именно по дизайну (не путать с "техническими" модификаторами вроде
-- _fade_time/_cast/_channel -- они режутся отдельно по паттернам ниже).
local LARGO_ENCORE_MODIFIER_BLACKLIST = {
	["modifier_black_king_bar_immune"] = true,  -- BKB-иммунитет
	["modifier_eul_cyclone"]           = true,  -- Eul's Scepter / Cyclone
}

function largo_encore:GetIntrinsicModifierName()
	return "modifier_largo_encore"
end

LinkLuaModifier("modifier_largo_encore", "abilities/largo_encore", LUA_MODIFIER_MOTION_NONE)

modifier_largo_encore = class({})

function modifier_largo_encore:IsHidden() return true end
function modifier_largo_encore:IsPurgable() return false end
function modifier_largo_encore:RemoveOnDeath() return false end

function modifier_largo_encore:OnCreated()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- ГЛОБАЛЬНЫЙ СЛУШАТЕЛЬ СОБЫТИЙ
--------------------------------------------------------------------------------

if IsServer() then
	local function OnAbilityUsed(event)
		local player_id = event.PlayerID
		local ability_name = event.abilityname

		if player_id == nil or player_id < 0 then return end

		local hero = PlayerResource:GetSelectedHeroEntity(player_id)
		if not hero or hero:IsNull() then return end

		local largo_ability = hero:FindAbilityByName("largo_encore")
		if not largo_ability or largo_ability:GetLevel() == 0 then return end

		-- Раньше тут был фильтр `if not string.find(ability_name, "_custom") then return end` --
		-- он молча отбрасывал ванильные имена (item_black_king_bar, item_blade_mail,
		-- juggernaut_blade_fury и т.д.), из-за чего innate не работал на BKB-предмете
		-- и любых non-_custom абилках. Снят сознательно.
		Timers:CreateTimer(0.1, function()
			ProcessBuffDuration(hero, ability_name, largo_ability)
		end)
	end

	function ProcessBuffDuration(hero, ability_name, largo_ability)
		if not hero or hero:IsNull() or not hero:IsAlive() then return end

		-- Для предметов FindAbilityByName в Source 2 возвращает nil --
		-- пробуем ещё и FindItemInInventory, иначе BKB/Ghost/Blade Mail не находились.
		local ability = hero:FindAbilityByName(ability_name)
		                or hero:FindItemInInventory(ability_name)
		if not ability then return end

		-- Сырое значение из KV (1 + hero_level * 0.2). На высоких уровнях улетает выше 20%.
		local raw_buff_amp = tonumber(largo_ability:GetSpecialValueFor("buff_amplification")) or 0
		-- Жёсткий кап. Тултип может показывать больше, но фактически применяется не больше CAP.
		local buff_amp = raw_buff_amp
		if buff_amp > LARGO_ENCORE_CAP then
			buff_amp = LARGO_ENCORE_CAP
		elseif buff_amp < 0 then
			buff_amp = 0
		end
		local duration_multiplier = 1.0 + (buff_amp / 100)

		local modifiers = hero:FindAllModifiers()
		for _, mod in ipairs(modifiers) do
			if mod and not mod:IsNull() then
				local mod_ability = mod:GetAbility()

				if mod_ability and mod_ability == ability then
					local mod_name = mod:GetName()
					local duration = mod:GetDuration()

					-- Игнорируем технические модификаторы (fade_time, cast, channel, thinker и т.д.)
					local ignored_patterns = {
						"_fade_time", "_fade", "_cast", "_channel", "_thinker",
						"_delay", "_windup", "_start", "_end", "_init"
					}
					local is_technical = false
					for _, pattern in ipairs(ignored_patterns) do
						if string.find(mod_name, pattern) then
							is_technical = true
							break
						end
					end

					-- Дизайн-исключения: явно перечисленные имена не удлиняем.
					local is_blacklisted = LARGO_ENCORE_MODIFIER_BLACKLIST[mod_name] == true

					local is_permanent = mod.IsPermanent and mod:IsPermanent() or false
					if duration > 0 and not is_permanent and not is_technical and not is_blacklisted then
						local new_duration = duration * duration_multiplier
						mod:SetDuration(new_duration, true)
					end
				end
			end
		end
	end

	ListenToGameEvent("dota_player_used_ability", OnAbilityUsed, nil)
end