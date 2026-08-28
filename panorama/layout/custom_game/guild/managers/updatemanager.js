--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


class UpdateManager {
	/**
	 * @protected
	 * @type {number?}
	 */
	requestUpdateScheduleId
	/**
	 * @protected
	 */
	requestUpdateTimoutExpireAt = 0

	/**
	 * @param {string} eventName
	 * @param {number} timeout
	 * @param {number} [repeatTime]
	 */
	setupRequestUpdate(eventName, timeout, repeatTime) {
		this.requestUpdateEventName = eventName
		this.requestUpdateTimeout = timeout * 1000

		if (repeatTime)
			this.requestUpdateRepeatTime = repeatTime
	}

	/**
	 * @param {boolean} [immediateRequest]
	 */
	startRepeatableRequestUpdate(immediateRequest) {
		if (!this.requestUpdateRepeatTime)
			throw new Error(`${this.constructor.name} have no \`requestUpdateRepeatTime\`. Did you forgot to use \`setupRequestUpdate\`?`)

		this.stopSchedule()

		if (immediateRequest) {
			this._requestUpdate(true)
		} else {
			this.requestUpdateScheduleId = $.Schedule(this.requestUpdateRepeatTime, function () {
				this._requestUpdate(true)
			}.bind(this))
		}
	}

	/** @private */
	stopSchedule() {
		if (!this.requestUpdateScheduleId) return

		$.CancelScheduled(this.requestUpdateScheduleId)
		this.requestUpdateScheduleId = undefined
	}

	reset() {
		this.stopSchedule()

		this.requestUpdateTimoutExpireAt = 0
	}

	/**
	 * @param {Object.<string, any>} [data]
	 * @returns {boolean} was request successfully sent
	 */
	requestUpdate(data) {
		return this._requestUpdate(false, data)
	}

	/**
	 * @returns {boolean}
	 */
	canProcessRepeatableUpdate() {
		return true
	}

	onPreSendUpdateRequest() { }

	/**
	 * @private
	 * @param {boolean} isRepeat
	 * @returns {boolean}
	 */
	_requestUpdate(isRepeat, data={}) {
		if (!this.requestUpdateEventName)
			throw new Error(`${this.constructor.name} have no \`requestUpdateEventName\``)

		if (!isRepeat) {
			if (Date.now() < this.requestUpdateTimoutExpireAt) return false

			this.requestUpdateTimoutExpireAt = Date.now() + this.requestUpdateTimeout
		} else {
			if (!this.canProcessRepeatableUpdate()) {
				this.stopSchedule()

				this.requestUpdateScheduleId = $.Schedule(10, function () {
					this._requestUpdate(true)
				}.bind(this))
				return
			}
		}

		this.stopSchedule()

		this.onPreSendUpdateRequest()

		GameEvents.SendCustomGameEventToServer(this.requestUpdateEventName, data)

		if (this.requestUpdateRepeatTime)
			this.requestUpdateScheduleId = $.Schedule(this.requestUpdateRepeatTime, function () {
				this._requestUpdate(true)
			}.bind(this))

		return true
	}
}