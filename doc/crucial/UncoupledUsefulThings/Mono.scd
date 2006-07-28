Monoforces the input to a mono signal if needed

 Mono.ar(input)
 
This is useful for inputs to compressors, amplitude detectors or audio functions where you need to ensure that the input is mono. It takes the first channel and discards others. If the input is already mono, it passes through unscathed.

It saves asking the input if its an array or not.