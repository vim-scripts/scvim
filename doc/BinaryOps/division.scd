/ division

BinaryOperator

a / b

Division can be tricky with signals because of division by zero.

{ PinkNoise.ar(0.1) / FSinOsc.kr(10, 0.5, 0.75) }.play;
