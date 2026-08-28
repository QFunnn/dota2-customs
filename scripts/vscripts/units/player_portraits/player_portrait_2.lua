--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/player_portraits/player_portrait_2"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 2,
		["6"] = 3,
		["7"] = 4,
		["10"] = 7,
		["11"] = 8,
		["12"] = 9,
		["13"] = 9,
		["14"] = 9,
		["16"] = 9,
		["17"] = 10,
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["24"] = 11,
		["25"] = 11,
		["26"] = 11,
		["28"] = 11,
		["29"] = 12,
		["30"] = 13,
		["31"] = 14,
		["32"] = 15,
		["34"] = 17,
		["35"] = 17,
		["36"] = 17,
		["38"] = 17,
		["39"] = 18,
		["42"] = 19,
		["43"] = 21,
		["44"] = 22,
		["45"] = 22,
		["46"] = 22,
		["47"] = 22,
		["49"] = 22,
		["50"] = 23,
		["51"] = 24,
		["53"] = 26,
		["54"] = 29,
		["55"] = 29,
		["56"] = 29,
		["57"] = 29,
		["58"] = 29,
		["59"] = 29,
		["60"] = 29,
		["61"] = 29,
		["62"] = 29,
		["63"] = 29,
		["64"] = 29,
		["65"] = 29,
		["66"] = 29,
		["67"] = 29,
		["68"] = 29,
		["69"] = 29,
		["70"] = 29,
		["71"] = 29,
		["72"] = 29,
		["73"] = 29,
		["74"] = 29,
		["75"] = 29,
		["76"] = 29,
		["77"] = 29,
		["78"] = 29,
		["79"] = 29,
		["80"] = 29,
		["81"] = 29,
		["82"] = 29,
		["83"] = 29,
		["84"] = 29,
		["85"] = 29,
		["86"] = 29,
		["87"] = 29,
		["88"] = 29,
		["90"] = 66,
		["91"] = 66,
		["95"] = 66,
		["97"] = 66,
		["98"] = 66,
		["99"] = 66,
		["101"] = 66,
		["102"] = 67,
		["103"] = 68,
		["105"] = 69,
		["106"] = 69,
		["107"] = 70,
		["108"] = 71,
		["109"] = 72,
		["111"] = 69,
		["116"] = 76,
		["117"] = 76,
		["118"] = 77,
		["119"] = 78,
		["120"] = 79,
		["121"] = 79,
		["122"] = 79,
		["124"] = 79,
		["126"] = 79,
		["127"] = 79,
		["128"] = 79,
		["130"] = 79,
		["132"] = 79,
		["133"] = 80,
		["134"] = 81,
		["135"] = 82,
		["136"] = 83,
		["138"] = 85,
		["139"] = 86,
		["140"] = 87,
		["141"] = 88,
		["145"] = 76,
		["149"] = 94,
		["150"] = 97,
		["151"] = 97,
		["152"] = 97,
		["153"] = 97,
		["154"] = 97,
		["155"] = 97,
		["156"] = 97,
		["157"] = 97,
		["158"] = 97,
		["159"] = 97,
		["160"] = 97,
		["161"] = 97,
		["162"] = 97,
		["163"] = 97,
		["164"] = 97,
		["165"] = 97,
		["166"] = 97,
		["167"] = 97,
		["168"] = 97,
		["169"] = 97,
		["170"] = 97,
		["171"] = 97,
		["172"] = 97,
		["173"] = 97,
		["174"] = 122,
		["175"] = 122,
		["176"] = 122,
		["177"] = 122,
		["178"] = 122,
		["179"] = 122,
		["180"] = 122,
		["181"] = 122,
		["182"] = 122,
		["183"] = 122,
		["184"] = 122,
		["185"] = 122,
		["186"] = 122,
		["187"] = 122,
		["188"] = 122,
		["189"] = 122,
		["190"] = 122,
		["191"] = 122,
		["192"] = 122,
		["193"] = 141,
		["194"] = 143,
		["195"] = 145,
		["197"] = 2,
	}
)
function Spawn(self, e)
	local f = Client:GetPlayerPortraitData(2)
	if not f then
		return
	end
	local g = f.unit_name
	local h = f.playerID
	local i = KeyValues.UnitsKv[g]
	if i == nil then
		i = KeyValues.CosmeticsKV[g]
	end
	local j = i
	if j == nil then
		return
	end
	local k = j.portraitmodel
	if k == nil then
		k = j.Model
	end
	local l = k
	if l == nil then
		l = j.resource
	end
	local m = l
	local n = m
	local o = Wearable:getUnitPortraitReplaceModel(n, h)
	if o then
		n = o
	end
	local p = KeyValues.Portrait[n]
	if p == nil then
		p = {}
	end
	local q = c(p, KeyValues.PortraitCustom[n])
	if q == nil then
		return
	end
	local r = q.cameras.default or q.cameras.Default
	local s = Wearable:getUnitPortraitReplaceSkin(n, h)
	local t = tostring
	local u = j.Skin
	if u == nil then
		u = ""
	end
	local v = t(u)
	if s then
		v = tostring(s)
	end
	local w = {}
	local x = {
		classname = "portrait_world_unit",
		targetname = "portraitUnit",
		origin = "0 0 0",
		model = n,
		skin = v,
		EnableAutoStyles = 0,
		ModelScale = 1,
		suppress_intro_effects = 1,
		spawn_background_models = 0,
		rare_loadout_anim_chance = -1,
		suppress_anim_event_sounds = 0,
		skip_pet_spawn = 0,
		flying_courier = 0,
		spawn_wearable_item_defs = 1,
		activity = "ACT_DOTA_CAPTURE",
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
	local y
	if j ~= nil then
		y = j.Creature
	end
	local z
	if y ~= nil then
		z = y.AttachWearables
	end
	local A = z
	if A == nil then
		A = {}
	end
	local B = A
	local C = Wearable:getUnitWearablesModifier(m, h)
	if C then
		do
			local D = 0
			while D <= 9 do
				local E = C[D + 1]
				if E then
					x["item_def" .. tostring(D)] = E
				end
				D = D + 1
			end
		end
	else
		do
			local D = 0
			while D <= 9 do
				local F = "item_def" .. tostring(D)
				local G = "style_index" .. tostring(D)
				local H = j["wearable" .. tostring(D + 1)]
				if H == nil then
					local I = B[tostring(D + 1)]
					if I ~= nil then
						I = I.ItemDef
					end
					local J = I
					if J == nil then
						J = -1
					end
					H = J
				end
				local E = H
				local K = j[("wearable" .. tostring(D + 1)) .. "style"]
				x[F] = E
				if K ~= nil then
					x[G] = K
				else
					local L = KeyValues.ItemsGame[tostring(E)]
					if L ~= nil then
						if L.visuals and L.visuals.skin then
							x[G] = L.visuals.skin
						end
					end
				end
				D = D + 1
			end
		end
	end
	table.insert(w, x)
	table.insert(
		w,
		{
			classname = "point_camera",
			targetname = "camera_1",
			origin = r.PortraitPosition,
			angles = r.PortraitAngles,
			fov = r.PortraitFOV,
			ZFar = r.PortraitFar or KeyValues.Portrait.default_entity_replacement.cameras.default.PortraitFar,
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
		w,
		{
			classname = "env_global_light",
			targetname = "portrait_light",
			origin = q.PortraitLightPosition or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			angles = q.PortraitLightAngles or KeyValues.Portrait.default_entity_replacement.PortraitLightPosition,
			fov = q.PortraitLightFOV or KeyValues.Portrait.default_entity_replacement.PortraitLightFOV,
			nearz = q.PortraitLightDistance or KeyValues.Portrait.default_entity_replacement.PortraitLightDistance,
			Color = q.PortraitLightColor or KeyValues.Portrait.default_entity_replacement.PortraitLightColor,
			ambientcolor2 = q.PortraitShadowColor or KeyValues.Portrait.default_entity_replacement.PortraitShadowColor,
			ambientscale2 = q.PortraitShadowScale or KeyValues.Portrait.default_entity_replacement.PortraitShadowScale,
			ambientcolor1 = q.PortraitAmbientColor
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientColor,
			ambientscale1 = q.PortraitAmbientScale
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientScale,
			specularcolor = q.PortraitSpecularColor
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularColor,
			specularpower = q.PortraitSpecularPower
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularPower,
			specularangles = q.PortraitSpecularDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitSpecularDirection,
			lightscale = q.PortraitLightScale or KeyValues.Portrait.default_entity_replacement.PortraitLightScale,
			groundscale = q.PortraitGroundShadowScale
				or KeyValues.Portrait.default_entity_replacement.PortraitGroundShadowScale,
			ambientangles = q.PortraitAmbientDirection
				or KeyValues.Portrait.default_entity_replacement.PortraitAmbientDirection,
		}
	)
	SpawnEntityListFromTableSynchronous(w)
	if q.PortraitParticle ~= nil then
		local M = ParticleManager:CreateParticle(q.PortraitParticle, PATTACH_ABSORIGIN_FOLLOW, thisEntity)
	end
end