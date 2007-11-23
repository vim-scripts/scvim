
UnicodeResponder


This can be used to replace a function in a view's keydownAction. 
It matches modifier/unicode combinations and .values functions.

This is the best way to accurately match the exact modifier combination you want.

register( unicode, shift, caps, option, control, function )
	true/false/nil:
		must be present
		should not be present
		doesn't matter

(
k = UnicodeResponder.new;

// option down arrow
k.register( 63233, false,false,true,false, {
  	"option down".postln;
});

// shift-option down arrow
k.register( 63233 , true,false,true,false, {
	"shift option down".debug;
});

w = SCWindow.new.front;
v = SCSlider.new(w,Rect(10,10,100,100));

v.keyDownAction = k;

v.focus;
)



Use this to post the codes:
(

UnicodeResponder.tester

)
it prints a code template for you:

// shift :
k.register(  41 ,  true, false, false, false, {

});




normal( unicode -> function [, unicode -> function ] )
shift( unicode -> function [, unicode -> function ] )
control( unicode -> function [, unicode -> function ] )
option( unicode -> function [, unicode -> function ] )

The view in this example is merely to have something to focus on, it
does nothing else.
(
var w, l;
w= SCWindow("test").front;
l= SCListView(w, Rect(10, 10, 350, 350))
	.items_({"eggs".scramble}.dup(12))
	.focus
	.keyDownAction_(
		UnicodeResponder.new
			.normal(63232 -> {
				"normal arrow".postln;
			})
			.shift(63232 -> {
				"shift arrrow".postln;
			})
			.register( 63232, true, nil, false, true, {
				"shift control, with or without CAPS".postln;
			})
			.normal( 97 -> {
				"normal a".postln
			})
			.shift( $A -> {
				"shift a".postln
			})
	)
)
Note that to match shift-a you have to specify "A", not "a"


You can also specify with ascii characters
(

var w, l;
w= SCWindow("test").front;
l= SCListView(w, Rect(10, 10, 350, 350))
	.items_({"eggs".scramble}.dup(12))
	.focus
	.keyDownAction_(
		UnicodeResponder.new
			.normal(
				$a -> {
					"a ".postln;
				},
				$b -> {
					"b".postln;
				},
				$; -> {
					";".postln;
				},
				$' -> {
					"'".postln;
				}
			)
			.shift(
				$A -> {
					"shift a".postln;
				},
				$B -> {
					"shift b".postln;
				},
				$: -> {
					"shift ;".postln;
				},
				$" -> {
					"shift '".postln;
				}
			);

	)
)




see also KeyCodeResponder

	
	
If you merely check the modifier like so:
	(modifer & optionModifier ) == optionModifier
you will detect the presence of the options key,
but not if only the option key is present ( eg. for shift-option )






