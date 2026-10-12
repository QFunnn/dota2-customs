--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/fs.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
____debugRuntime.register(
	"utils/fs.lua",
	{
		["21"] = "15:1",
		["22"] = "15:14",
		["23"] = "15:1",
		["25"] = "15:1",
		["26"] = "16:5",
		["27"] = "17:15",
		["28"] = "18:9",
		["29"] = "16:5",
		["30"] = "21:5",
		["31"] = "22:9",
		["32"] = "22:20",
		["33"] = "22:28",
		["34"] = "23:13",
		["35"] = "24:21",
		["36"] = "25:21",
		["38"] = "27:21",
		["39"] = "27:21",
		["40"] = "27:29",
		["41"] = "27:21",
		["43"] = "23:42",
		["44"] = "22:28",
		["45"] = "22:16",
		["46"] = "21:5",
		["47"] = "33:5",
		["48"] = "34:9",
		["49"] = "34:20",
		["50"] = "34:28",
		["51"] = "35:13",
		["52"] = "36:21",
		["53"] = "37:21",
		["55"] = "39:21",
		["57"] = "35:42",
		["58"] = "34:28",
		["59"] = "34:16",
		["60"] = "33:5",
		["61"] = "45:5",
		["62"] = "46:9",
		["63"] = "46:20",
		["64"] = "46:28",
		["65"] = "47:19",
		["66"] = "48:13",
		["67"] = "49:13",
		["68"] = "50:21",
		["69"] = "51:21",
		["71"] = "53:21",
		["73"] = "49:26",
		["74"] = "46:28",
		["75"] = "46:16",
		["76"] = "45:5",
		["77"] = "59:5",
		["78"] = "60:9",
		["79"] = "60:20",
		["80"] = "60:28",
		["81"] = "61:13",
		["82"] = "62:21",
		["83"] = "63:21",
		["85"] = "65:21",
		["87"] = "61:43",
		["88"] = "60:28",
		["89"] = "60:16",
		["90"] = "59:5",
	}
)
local ____exports = {}
--- a custom fs to read/write files via http request
-- please ensure your file server is running
-- see @ gulpfile.ts @task start_file_server
-- 一个使用本地http请求读写文件的fs
-- 请确保你的文件服务器正在运行
-- 参见 @ gulpfile.ts @task start_file_server
--
-- @example fs.read('./game/scripts/src/addon_game_mode.ts').then(content => {
--        print(content);
--    });
--    fs.write('./game/scripts/src/test.ts', 'to be or not to be, it is a problem\r\n');
____exports.fs = __TS__Class()
local fs = ____exports.fs
fs.name = "fs"
function fs.prototype.____constructor(self) end
function fs.request(self, method, url)
	local request = CreateHTTPRequestScriptVM(method, "http://localhost:10384" .. url)
	return request
end
function fs.dir(self, path)
	return __TS__New(__TS__Promise, function(____, resolve, reject)
		____exports.fs:request("GET", path):Send(function(result)
			if result.StatusCode ~= 200 then
				reject(nil, result.Body)
			else
				resolve(nil, JSON:decode(result.Body))
			end
		end)
	end)
end
function fs.read(self, path)
	return __TS__New(__TS__Promise, function(____, resolve, reject)
		____exports.fs:request("GET", path):Send(function(result)
			if result.StatusCode ~= 200 then
				reject(nil, result.Body)
			else
				resolve(nil, result.Body)
			end
		end)
	end)
end
function fs.write(self, path, content)
	return __TS__New(__TS__Promise, function(____, resolve, reject)
		local request = ____exports.fs:request("PUT", path)
		request:SetHTTPRequestRawPostBody("application/json", content)
		request:Send(function(result)
			if result.StatusCode ~= 200 then
				reject(nil, result.Body)
			else
				resolve(nil)
			end
		end)
	end)
end
function fs.mkdir(self, path)
	return __TS__New(__TS__Promise, function(____, resolve, reject)
		____exports.fs:request("POST", path):Send(function(result)
			if result.StatusCode ~= 200 then
				reject(nil, result.Body)
			else
				resolve(nil)
			end
		end)
	end)
end
return ____exports