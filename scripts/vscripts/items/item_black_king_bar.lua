--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function item_black_king_bar_datadriven_on_spell_start_1_2(keys)
	keys.ability:ApplyDataDrivenModifier(
		keys.caster,
		keys.caster,
		"modifier_item_black_king_bar_datadriven_active",
		nil
	)
	keys.caster:EmitSound("DOTA_Item.BlackKingBar.Activate")

	local current_level = keys.ability:GetLevel()

	local final_model_scale = (keys.PercentageOverModelScale / 100) + 1 --This will be something like 1.3.
	local model_scale_increase_per_interval = 100 / (final_model_scale - 1)

	for i = 1, 100 do
		Timers:CreateTimer(i / 75, function()
			keys.caster:SetModelScale(1 + i / model_scale_increase_per_interval)
		end)
	end

	for i = 1, 100 do
		Timers:CreateTimer(keys.Duration - 1 + (i / 50), function()
			keys.caster:SetModelScale(final_model_scale - i / model_scale_increase_per_interval)
		end)
	end
end

function item_black_king_bar_datadriven_on_spell_start(keys)
	target = keys.target
	keys.ability:ApplyDataDrivenModifier(target, target, "modifier_item_black_king_bar_datadriven_active", nil)
	keys.caster:EmitSound("DOTA_Item.BlackKingBar.Activate")

	local current_level = keys.ability:GetLevel()

	local final_model_scale = (keys.PercentageOverModelScale / 100) + 1 --This will be something like 1.3.
	local model_scale_increase_per_interval = 100 / (final_model_scale - 1)

	for i = 1, 100 do
		Timers:CreateTimer(i / 75, function()
			keys.caster:SetModelScale(1 + i / model_scale_increase_per_interval)
		end)
	end

	for i = 1, 100 do
		Timers:CreateTimer(keys.Duration - 1 + (i / 50), function()
			keys.caster:SetModelScale(final_model_scale - i / model_scale_increase_per_interval)
		end)
	end
end

function modifier_item_black_king_bar_datadriven_on_created(keys)
	if keys.caster.BKBLevel ~= nil and keys.caster.BKBLevel ~= keys.ability:GetLevel() then
		keys.ability:SetLevel(keys.caster.BKBLevel)
	end
end