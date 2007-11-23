
Line			line generator

Line.ar(start, end, dur, mul, add, doneAction)
Line.kr(start, end, dur, mul, add, doneAction)

Generates a line from the start value to the end value.
start - starting value
end - ending value
dur - duration in seconds
doneAction - a doneAction to be evaluated when the Line is completed. See UGen-doneActions for more detail.

// XLine is usually better than Line for frequency
play({ SinOsc.ar(Line.kr(200,17000,10),0,0.1) });



