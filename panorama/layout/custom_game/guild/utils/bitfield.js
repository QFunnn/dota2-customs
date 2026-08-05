--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {number} BitFieldResolvable
 */

/** 
 * @template Flags
 */
class BitField {
	/** @type {Flags} */
	static flags = {}

	/**
	 * @private
	 */
	static defaultBit = 0

	/**
	 * @param {BitFieldResolvable} bits
	 */
	constructor(bits) {
		/** @type {number} */
		this.bitfield = this.constructor.resolve(bits)
	}

	/**
	 * @param {BitFieldResolvable | keyof Flags} bit
	 * @returns {boolean}
	 */
	any(bit) {
		return (this.bitfield & this.constructor.resolve(bit)) !== this.constructor.defaultBit
	}

	/**
	 * @param {BitFieldResolvabled | keyof Flags} bit
	 * @returns {boolean}
	 */
	equals(bit) {
		return this.bitfield === this.constructor.resolve(bit)
	}

	/**
	 * @param {BitFieldResolvable | keyof Flags} bit
	 * @returns {boolean}
	 */
	has(bit) {
		bit = this.constructor.resolve(bit)
		return (this.bitfield & bit) === bit
	}

	/**
	 * @param {...(BitFieldResolvable | keyof Flags)} [bits]
	 * @returns {BitField}
	 */
	add(...bits) {
		let total = this.constructor.defaultBit
		for (const bit of bits) {
			total |= this.constructor.resolve(bit)
		}
		this.bitfield |= total
		return this
	}

	/**
	 * @param {...(BitFieldResolvable | keyof Flags)} [bits]
	 * @returns {BitField}
	 */
	remove(...bits) {
		let total = this.constructor.defaultBit
		for (const bit of bits) {
			total |= this.constructor.resolve(bit)
		}
		this.bitfield &= ~total
		return this
	}

	/**
	 * @returns {Object}
	 */
	serialize() {
		const serialized = {}
		for (const [flag, bit] of Object.entries(this.constructor.Flags)) {
			if (isNaN(flag)) serialized[flag] = this.has(bit)
		}
		return serialized
	}

	valueOf() {
		return this.bitfield
	}

	/**
	 * @param {(BitFieldResolvable | keyof Flags)} [bit]
	 * @returns {number}
	 */
	static resolve(bit) {
		if (typeof bit === "number") return bit
		if (bit instanceof BitField) return bit.bitfield
		if (typeof bit === "string") {
			if (this.flags[bit] != null) return this.flags[bit]
			if (!isNaN(bit)) return Number(bit)
		}

		throw new Error(`unresolvable bit: ${bit}`)
	}
}