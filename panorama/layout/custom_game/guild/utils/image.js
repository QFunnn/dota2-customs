--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @abstract
 */
class ImageUtils {
	static errorImage = "file://{images}/guild/error.png"

	/**
	 * @param {string} image
	 */
	static resolve(image) {
		image = image.trim()

		if (this.isURL(image))
			return image

		const resolvedImage = this._resolve(image)

		return $.BImageFileExists(resolvedImage) ? resolvedImage : this.errorImage
	}

	/**
	 * @param {string} image
	 */
	static resolveGuildImage(image) {
		image = image.trim()

		if (this.isURL(image))
			return image
		
		const resolvedImage = this._resolve(`file://{images}/guild/avatars/${image}.png`)

		return $.BImageFileExists(resolvedImage) ? resolvedImage : this.errorImage
	}

	/**
	 * @private
	 * @param {string} image
	 * @returns {boolean}
	 */
	static isURL(image) {
		return /^https?:\/\//.test(image)

	}

	/**
	 * @private
	 * @param {string} image
	 */
	static _resolve(image) {
		if (image == null || image == "")
			return ""

		if (image.startsWith("file://"))
			return image

		if (this.isProbablyEmoji(image))
			return this.emojiToImage(image)

		return `file://{images}/${image}`
	}

	/**
	 * @private
	 * @param {string} str
	 * @returns {boolean}
	 */
	static isProbablyEmoji(str) {
		return str.length && !/[\w\.\/\\\:\{\}]/.test(str[0])
	}

	/**
	 * @private
	 * @param {string} emoji
	 */
	static emojiToImage(emoji) {
		return `file://{images}/unicode_emojis/${emoji.codePointAt(0).toString(16)}.png`
	}
}