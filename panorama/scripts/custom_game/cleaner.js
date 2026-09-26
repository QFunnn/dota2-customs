--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var fs = require("fs")

/**
 * @param {any[]} arr
 * @returns {any[]}
 */
function flatten(arr) {
	return arr.reduce((flat, toFlatten) => flat.concat(Array.isArray(toFlatten) ? flatten(toFlatten) : toFlatten), []);
}

/**
 * @param {string} path
 * @returns {string[]}
 */
function grabUsedContent(path) {
	if (!fs.existsSync(path))
		return []
	if (!fs.statSync(path).isDirectory()) {
		var contents = fs.readFileSync(path, "utf8"),
			re = /(\0|")([a-zA-Z0-9_/]+?\.v(xml|pcf|js|mdl|mesh|agrp|anim|mat|tex|snd|sndevts|phys|seq))(\0|")/g,
			res = new Set(),
			m

		while (m = re.exec(contents)) {
			res.add(m[2])
			re.lastIndex-- // so that it'll correctly parse \0 multiple times
		}
		return [...res]
	}

	return flatten(fs.readdirSync(path).map(file => grabUsedContent(path + "/" + file)))
}

/**
 * @param {string} path
 * @returns {string[]}
 */
function readDir(path) {
	return flatten(fs.readdirSync(path).map(file => {
		file = path + "/" + file
		return fs.statSync(file).isDirectory() ? readDir(file) : file
	}))
}
/**
 * @param {string} path
 */
function cleanEmptyDirs(path) {
	fs.readdirSync(path).forEach(file => {
		file = path + "/" + file
		if (fs.statSync(file).isDirectory())
			if (fs.readdirSync(file).length === 0)
				fs.rmdirSync(file)
			else {
				cleanEmptyDirs(file)
				if (fs.readdirSync(file).length === 0)
					fs.rmdirSync(file)
			}
	})
}

/**
 * @param {string} dir
 * @param {string[]} deps
 */
function clean(dir, deps) {
	if (!fs.existsSync(dir))
		return
	var used = [...new Set(flatten(deps.map(grabUsedContent)))],
		all_files = readDir(dir).map(a => a.substring(0, a.length - 2)),
		readed = []
	function iter(prev_size = -1) {
		all_files.filter(file_name => !readed.includes(file_name) && used.includes(file_name)).forEach(file_name => {
			used = [...new Set([...used, ...grabUsedContent(file_name + "_c")])]
			readed.push(file_name)
		})
		if (used.length !== prev_size)
			iter(used.length)
		else
			all_files.forEach(file_name => {
				if (!used.includes(file_name))
					fs.unlinkSync(file_name + "_c")
			})
	}
	iter()
	cleanEmptyDirs(dir)
}
clean("sounds", ["scripts", "maps", "soundevents"])
clean("models", ["scripts", "maps"])
clean("materials", ["scripts", "maps", "models", "particles"])