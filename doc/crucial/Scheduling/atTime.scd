atTime

this is an argument for many methods.
it specifies when the bundle or event should occur

Nil : immediately

Float : that many seconds from now
 if time is greater than server latency,
 it will be scheded in sclang and only sent close to the time

 // start in 4.5 seconds
 (

 Patch({ arg tempo;
 Impulse.ar( tempo )
 },[
 TempoPlayer.new
 
 ]).play(atTime: 4.5)
 
 )

Integer : according to TempoClock on the next 
 1 bar
 2 half bar
 4 beat
 8 8th note
 16 16th note
 etc.

 execute the following several times. they will each start at the start of the next bar.
 (

 Patch({ arg tempo;
 Impulse.ar( tempo )
 },[
 TempoPlayer.new
 
 ]).play(atTime: 1)

 )

Date : at that time on that date if in the future
 Date has to have raw seconds set to work !
 use Date.localtime or Date.getDate to create a Date object with the raw seconds set.
 and then make relative changes to that date.
 
 ie. you can't make a Date.new(year,month ....) and expect that to work.
 note: a getRawSeconds primitive would solve this problem.

(
 d = Date.getDate;
 // 10 seconds in the future
 d.rawSeconds = d.rawSeconds + 10;
 Patch({ arg tempo;
 Impulse.ar( tempo )
 },[
 TempoPlayer.new
 
 ]).play(atTime: d)
 
 )


