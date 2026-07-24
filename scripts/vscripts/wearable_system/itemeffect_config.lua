--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.ItemEffectKV_original = {
	item_blink = {
		fall_2021_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_2021/blink_dagger_fall_2021_start_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				particle = "particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf",
				sound = "soundboard.2022.ticktock",
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_2021/blink_dagger_fall_2021_end_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		fall_2021 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_2021/blink_dagger_fall_2021_start.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				particle = "particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf",
				sound = "soundboard.2022.ticktock",
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		["18000002"] = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_start_lvl1.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_end_fall2022.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		["18000003"] = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_major_2016/blink_dagger_start_fm06.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/fall_major_2016/blink_dagger_end_fm06.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		["18000004"] = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/nexon_hero_compendium_2014/blink_dagger_end_nexon_hero_cp_2014.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		spring_2021 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/spring_2021/blink_dagger_spring_2021_start.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/spring_2021/blink_dagger_spring_2021_end.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		spring_2021_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/spring_2021/blink_dagger_spring_2021_start_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/spring_2021/blink_dagger_spring_2021_end_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti10_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti4 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti4/blink_dagger_start_ti4.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti5_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_lvl2_ti5.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_end_lvl2_ti5.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti6_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_end_lvl2_ti5.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti7_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti7/blink_dagger_end_ti7_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti8_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti8/blink_dagger_ti8_start_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti8/blink_dagger_ti8_end_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		ti9_lvl2 = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti9/blink_dagger_ti9_start_lvl2.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/ti9/blink_dagger_ti9_lvl2_end.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
		winter_major = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_START,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/winter_major_2017/blink_dagger_start_wm07.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, hCaster:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local vPos = tData.vPos
					local iParticleID = ParticleManager:CreateParticle("particles/econ/events/winter_major_2017/blink_dagger_end_wm07.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
					ParticleManager:SetParticleControl(iParticleID, 0, vPos)
					ParticleManager:ReleaseParticleIndex(iParticleID)
				end
			},
		},
	}
}

_G.ItemEffectKV_custom = {
	item_refresher_lua = {
		Default = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local particleID = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
					ParticleManager:SetParticleControlEnt(particleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
					ParticleManager:ReleaseParticleIndex(particleID)

					EmitSoundOn("DOTA_Item.Refresher.Activate", hCaster)
				end
			},
		},
		["18000001"] = {
			{
				event = MODIFIER_EVENT_ON_ABILITY_EXECUTED,
				callback = function(hCaster, sAbilityName, tData)
					local iParticleID = ParticleManager:CreateParticle("particles/items/refresher_timer.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
					ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
					ParticleManager:SetParticleControlEnt(iParticleID, 1, hCaster, PATTACH_OVERHEAD_FOLLOW, "", Vector(0, 0, 0), false)
					ParticleManager:ReleaseParticleIndex(iParticleID)

					EmitSoundOn("soundboard.2022.ticktock", hCaster)
					EmitSoundOn("DOTA_Item.Refresher.Activate", hCaster)
				end
			},
		},
	},
	item_felling_shield_lua_1 = {
		Default = {
			{
				event = MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
				callback = function(hCaster, sAbilityName, tData)
					local tBuff = tData.tBuff
					if tBuff then
						local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_sven/sven_warcry_buff_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
						ParticleManager:SetParticleControl(iParticleID, 1, Vector(120, 0, 0))
						ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						tBuff:AddParticle(iParticleID, false, false, -1, false, false)
					end
				end
			},
		},
	},
	item_felling_shield_lua_2 = {
		Default = {
			{
				event = MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
				callback = function(hCaster, sAbilityName, tData)
					local tBuff = tData.tBuff
					if tBuff then
						local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_sven/sven_warcry_buff_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
						ParticleManager:SetParticleControl(iParticleID, 1, Vector(120, 0, 0))
						ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						tBuff:AddParticle(iParticleID, false, false, -1, false, false)
					end
				end
			},
		},
	},
	item_felling_shield_lua_3 = {
		Default = {
			{
				event = MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
				callback = function(hCaster, sAbilityName, tData)
					local hTarget = tData.hTarget
					if IsValid(hTarget) then
						local iParticleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
						ParticleManager:DestroyParticle(iParticleID, false)
						ParticleManager:ReleaseParticleIndex(iParticleID)
					end
				end
			},
			{
				event = MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
				callback = function(hCaster, sAbilityName, tData)
					local tBuff = tData.tBuff
					if tBuff then
						local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_sven/sven_warcry_buff_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
						ParticleManager:SetParticleControl(iParticleID, 1, Vector(120, 0, 0))
						ParticleManager:SetParticleControlEnt(iParticleID, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						tBuff:AddParticle(iParticleID, false, false, -1, false, false)
					end
				end
			},
			{
				event = MODIFIER_FUNCTION_CUSTOM_1,
				callback = function(hCaster, sAbilityName, tData)
					local hTarget = tData.hTarget
					local tBuff = tData.tBuff
					if IsValid(hTarget) and tBuff then
						local iParticleID = ParticleManager:CreateParticle("particles/items_fx/diffusal_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
						tBuff:AddParticle(iParticleID, false, false, -1, false, false)
					end
				end
			},
		},
		["18000005"] = {
			{
				event = MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
				callback = function(hCaster, sAbilityName, tData)
					local hTarget = tData.hTarget
					if IsValid(hTarget) then
						local iParticleID = ParticleManager:CreateParticle("particles/items/felling_shield_bone_manaburn_impact_model.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hTarget)
						ParticleManager:SetParticleControlEnt(iParticleID, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						-- ParticleManager:SetParticleControlEnt(iParticleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
						ParticleManager:SetParticleControlTransformForward(iParticleID, 1, hTarget:GetAbsOrigin(), (hCaster:GetAbsOrigin() - hTarget:GetAbsOrigin()):Normalized())
						ParticleManager:SetParticleControlTransformForward(iParticleID, 10, Vector(0, 0, 0), hTarget:GetForwardVector())
						ParticleManager:ReleaseParticleIndex(iParticleID)
					end
				end
			},
			{
				event = MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
				callback = function(hCaster, sAbilityName, tData)
					if IsValid(hCaster) then
						local tBuff = tData.tBuff
						if tBuff then
							local iParticleID = ParticleManager:CreateParticle("particles/items/felling_shield_bone.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
							tBuff:AddParticle(iParticleID, false, false, -1, false, false)
						end
					end
				end
			},
			{
				event = MODIFIER_FUNCTION_CUSTOM_1,
				callback = function(hCaster, sAbilityName, tData)
					local hTarget = tData.hTarget
					local tBuff = tData.tBuff
					if IsValid(hTarget) then
						if tBuff then
							local iParticleID = ParticleManager:CreateParticle("particles/items/felling_shield_bone_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
							tBuff:AddParticle(iParticleID, false, false, -1, false, false)
						else
							local iParticleID2 = ParticleManager:CreateParticle("particles/items/felling_shield_bone_slow_chain_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
							ParticleManager:SetParticleControlEnt(iParticleID2, 0, hCaster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
							ParticleManager:SetParticleControlEnt(iParticleID2, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
							ParticleManager:ReleaseParticleIndex(iParticleID2)
						end
					end
				end
			},
		}
	},
}