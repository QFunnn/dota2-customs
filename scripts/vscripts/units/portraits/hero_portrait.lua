--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/portraits/hero_portrait"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["6"] = 1,
		["7"] = 1,
		["8"] = 4,
		["9"] = 5,
		["10"] = 6,
		["11"] = 7,
		["12"] = 8,
		["13"] = 9,
		["14"] = 10,
		["16"] = 13,
		["17"] = 13,
		["18"] = 13,
		["19"] = 13,
		["20"] = 14,
		["23"] = 17,
		["24"] = 17,
		["25"] = 17,
		["27"] = 17,
		["28"] = 18,
		["31"] = 19,
		["32"] = 19,
		["33"] = 19,
		["35"] = 19,
		["36"] = 19,
		["37"] = 19,
		["39"] = 19,
		["40"] = 20,
		["41"] = 21,
		["42"] = 22,
		["43"] = 23,
		["45"] = 25,
		["46"] = 26,
		["47"] = 27,
		["49"] = 29,
		["50"] = 29,
		["51"] = 29,
		["53"] = 29,
		["54"] = 30,
		["57"] = 31,
		["58"] = 33,
		["59"] = 34,
		["60"] = 34,
		["61"] = 34,
		["62"] = 34,
		["64"] = 34,
		["65"] = 35,
		["66"] = 36,
		["68"] = 38,
		["69"] = 45,
		["70"] = 46,
		["71"] = 52,
		["72"] = 57,
		["73"] = 57,
		["74"] = 57,
		["76"] = 41,
		["77"] = 41,
		["78"] = 41,
		["79"] = 41,
		["80"] = 41,
		["81"] = 41,
		["82"] = 41,
		["83"] = 41,
		["84"] = 41,
		["85"] = 41,
		["86"] = 41,
		["87"] = 41,
		["88"] = 41,
		["89"] = 41,
		["90"] = 41,
		["91"] = 41,
		["92"] = 41,
		["93"] = 41,
		["94"] = 41,
		["95"] = 41,
		["96"] = 41,
		["97"] = 41,
		["98"] = 41,
		["99"] = 41,
		["100"] = 41,
		["101"] = 41,
		["102"] = 41,
		["103"] = 41,
		["104"] = 41,
		["105"] = 41,
		["106"] = 41,
		["107"] = 41,
		["108"] = 41,
		["109"] = 41,
		["110"] = 41,
		["112"] = 78,
		["113"] = 78,
		["117"] = 78,
		["119"] = 78,
		["120"] = 78,
		["121"] = 78,
		["123"] = 78,
		["124"] = 79,
		["125"] = 80,
		["127"] = 81,
		["128"] = 81,
		["129"] = 82,
		["130"] = 83,
		["131"] = 84,
		["133"] = 81,
		["138"] = 88,
		["139"] = 88,
		["140"] = 89,
		["141"] = 90,
		["142"] = 91,
		["143"] = 91,
		["144"] = 91,
		["146"] = 91,
		["148"] = 91,
		["149"] = 91,
		["150"] = 91,
		["152"] = 91,
		["154"] = 91,
		["155"] = 92,
		["156"] = 92,
		["157"] = 92,
		["159"] = 92,
		["160"] = 93,
		["161"] = 94,
		["162"] = 95,
		["164"] = 97,
		["165"] = 98,
		["166"] = 99,
		["167"] = 100,
		["171"] = 88,
		["175"] = 106,
		["176"] = 109,
		["177"] = 109,
		["178"] = 109,
		["179"] = 109,
		["180"] = 109,
		["181"] = 109,
		["182"] = 109,
		["183"] = 109,
		["184"] = 109,
		["185"] = 109,
		["186"] = 109,
		["187"] = 109,
		["188"] = 109,
		["189"] = 109,
		["190"] = 109,
		["191"] = 109,
		["192"] = 109,
		["193"] = 109,
		["194"] = 109,
		["195"] = 109,
		["196"] = 109,
		["197"] = 109,
		["198"] = 109,
		["199"] = 109,
		["200"] = 134,
		["201"] = 134,
		["202"] = 134,
		["203"] = 134,
		["204"] = 134,
		["205"] = 134,
		["206"] = 134,
		["207"] = 134,
		["208"] = 134,
		["209"] = 134,
		["210"] = 134,
		["211"] = 134,
		["212"] = 134,
		["213"] = 134,
		["214"] = 134,
		["215"] = 134,
		["216"] = 134,
		["217"] = 134,
		["218"] = 134,
		["219"] = 153,
		["220"] = 155,
		["221"] = 156,
		["223"] = 13,
		["224"] = 13,
	}
)
local e = {}
local f = require("lib.dota_ts_adapter")
local g = f.registerEntityFunction
local h
local i
if #_G.HeroPortraitDataQueue > 0 then
	local j = table.remove(_G.HeroPortraitDataQueue, 1)
	h = j.unit_name
	i = j.player_id
	Client:SendLocalConsoleMessage("hero_portrait_loaded", j)
end
g(nil, "Spawn", function(k, l)
	if h == nil then
		return
	end
	local m = KeyValues.UnitsKv[h]
	if m == nil then
		m = KeyValues.CosmeticsKV[h]
	end
	local n = m
	if n == nil then
		return
	end
	local o = n.portraitmodel
	if o == nil then
		o = n.Model
	end
	local p = o
	if p == nil then
		p = n.resource
	end
	local q = p
	local r = q
	local s = GetLocalPlayerID()
	if i ~= nil then
		s = i
	end
	local t = Wearable:getUnitPortraitReplaceModel(r, s)
	if t then
		r = t
	end
	local u = KeyValues.Portrait[r]
	if u == nil then
		u = {}
	end
	local v = c(u, KeyValues.PortraitCustom[r])
	if v == nil then
		return
	end
	local w = v.cameras.default or v.cameras.Default
	local x = Wearable:getUnitPortraitReplaceSkin(r, s)
	local y = tostring
	local z = n.Skin
	if z == nil then
		z = ""
	end
	local A = y(z)
	if x then
		A = tostring(x)
	end
	local B = {}
	local C = r
	local D = A
	local E = -1
	local F = n.portraitactivity
	if F == nil then
		F = "ACT_DOTA_CAPTURE"
	end
	local G = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = C,
		skin = D,
		EnableAutoStyles = 0,
		ModelScale = 1,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = E,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = F,
		activity_modifier = "",
		item_def0 = 0,
		style_index0 = 0,
		item_def1 = 0,
		style_index1 = 0,
		item_def2 = 0,
		style_index2 = 0,
		item_def3 = 0,
		style_index3 = 0,
		item_def4 = 0,
		style_index4 = 0,
		item_def5 = 0,
		style_index5 = 0,
		item_def6 = 0,
		style_index6 = 0,
		item_def7 = 0,
		style_index7 = 0,
		rendercolor = "255 255 255",
	}
	local H
	if n ~= nil then
		H = n.Creature
	end
	local I
	if H ~= nil then
		I = H.AttachWearables
	end
	local J = I
	if J == nil then
		J = {}
	end
	local K = J
	local L = Wearable:getUnitWearablesModifier(q, s)
	if L then
		do
			local M = 0
			while M <= 9 do
				local N = L[M + 1]
				if N then
					G["item_def" .. tostring(M)] = N
				end
				M = M + 1
			end
		end
	else
		do
			local M = 0
			while M <= 9 do
				local O = "item_def" .. tostring(M)
				local P = "style_index" .. tostring(M)
				local Q = n["wearable" .. tostring(M + 1)]
				if Q == nil then
					local R = K[tostring(M + 1)]
					if R ~= nil then
						R = R.ItemDef
					end
					local S = R
					if S == nil then
						S = -1
					end
					Q = S
				end
				local N = Q
				local T = n[("wearable" .. tostring(M + 1)) .. "style"]
				if T == nil then
					T = 0
				end
				local U = T
				G[O] = N
				if U ~= 0 then
					G[P] = U
				else
					local V = KeyValues.ItemsGame[tostring(N)]
					if V ~= nil then
						if V.visuals and V.visuals.skin then
							G[P] = V.visuals.skin
						end
					end
				end
				M = M + 1
			end
		end
	end
	table.insert(B, G)
	table.insert(
		B,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = w.PortraitPosition,
			angles = w.PortraitAngles,
			fov = w.PortraitFOV,
			ZFar = w.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
			ZNear = 4,
			UseScreenAspectRatio = 0,
			aspectRatio = 1,
			fogEnable = 0,
			fogColor = "0 0 0",
			fogStart = 2048,
			fogEnd = 4096,
			fogMaxDensity = 1,
			rendercolor = "128 128 128",
			override_shadow_farz = 0,
			dof_enabled = 0,
			dof_near_blurry = 250,
			dof_near_crisp = 550,
			dac_dof_far_crisp = 1200,
			dac_dof_far_blurry = 1600,
			dac_dof_tilt_to_ground = 0.75,
		}
	)
	table.insert(
		B,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = v.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = v.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = v.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = v.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = v.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = v.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = v.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = v.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = v.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = v.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = v.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = v.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = v.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = v.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = v.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(B)
	if v.PortraitParticle ~= nil then
		local W = ParticleManager:CreateParticle(v.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end)
return e