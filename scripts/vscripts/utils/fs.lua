--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
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