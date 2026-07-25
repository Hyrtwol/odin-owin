#+build windows
#+vet
package owin

import win32 "core:sys/windows"

stopwatch_tick :: win32.LARGE_INTEGER // i64
stopwatch_time :: f64

stopwatch :: struct {
	start_tick:          stopwatch_tick,
	stop_tick:           stopwatch_tick,
	last_tick:           stopwatch_tick,
	start:               proc(this: ^stopwatch),
	stop:                proc(this: ^stopwatch),
	get_elapsed_seconds: proc(this: ^stopwatch) -> stopwatch_time,
	get_delta_seconds:   proc(this: ^stopwatch) -> stopwatch_time,
}

performance_frequency: stopwatch_tick = 0

ticks_to_seconds :: #force_inline proc "contextless" (ticks: stopwatch_tick) -> stopwatch_time {
	return performance_frequency > 0 ? stopwatch_time(ticks) / stopwatch_time(performance_frequency) : 0
}

@(private = "file")
stopwatch_start :: proc(this: ^stopwatch) {
	win32.Sleep(0)
	this.stop_tick = 0
	win32.QueryPerformanceCounter(&this.start_tick)
	this.stop_tick = this.start_tick
	this.last_tick = this.start_tick
}

@(private = "file")
stopwatch_stop :: proc(this: ^stopwatch) {
	win32.QueryPerformanceCounter(&this.stop_tick)
}

@(private = "file")
stopwatch_get_elapsed_seconds :: proc(this: ^stopwatch) -> stopwatch_time {
	return ticks_to_seconds(this.stop_tick - this.start_tick)
}

@(private = "file")
stopwatch_get_delta_seconds :: proc(this: ^stopwatch) -> stopwatch_time {
	tick: stopwatch_tick
	win32.QueryPerformanceCounter(&tick)
	delta_tick := tick - this.last_tick
	this.last_tick = tick
	return ticks_to_seconds(delta_tick)
}

create_stopwatch :: proc() -> stopwatch {

	if performance_frequency == 0 {
		if !win32.QueryPerformanceFrequency(&performance_frequency) {
			panic("Failed to call win32.QueryPerformanceFrequency")
		}
	}

	sw := stopwatch {
		start_tick          = 0,
		stop_tick           = 0,
		last_tick           = 0,
		start               = stopwatch_start,
		stop                = stopwatch_stop,
		get_elapsed_seconds = stopwatch_get_elapsed_seconds,
		get_delta_seconds   = stopwatch_get_delta_seconds,
	}
	return sw
}

/*
@(init, private)
_initialization :: proc() {
	if win32.QueryPerformanceFrequency(cast(^win32.LARGE_INTEGER)&performance_frequency) {
		// fmt.println("QueryPerformanceFrequency:", performance_frequency)
		ticks_to_seconds = 1.0 / performance_frequency
		ticks_to_millisecond = 1_000.0 / performance_frequency
		ticks_to_timespan = 10_000_000.0 / performance_frequency
	}
	// QueryPerformanceCounter
}
*/
