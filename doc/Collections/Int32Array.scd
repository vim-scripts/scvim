Int8Array, Int16Array, Int32Array, RGBArray, FloatArray,
DoubleArray

Superclass: RawArray

These classes implement arrays whose indexed slots are all of the same type.

Int8Array - 8 bit integer
Int16Array - 16 bit integer
Int32Array - 32 bit integer
RGBArray - 32 bit color
FloatArray - 32 bit floating point
DoubleArray - 64 bit floating point

These classes implement only one method.

*readNew(file)

Called by *read to read the entire file as an array of this class' type and return a new instance.

