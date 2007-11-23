
ControlSpec			specification for a control input

superclass: Spec

The original, and most common spec. (see Spec )

ControlSpec.new( minval, maxval, warp, step, default,units);

The most common way to create one is by

	anObject.asSpec

// nil becomes a default ControlSpec
nil.asSpec.dump
Instance of ControlSpec {  (0313FF18, gc=00, fmt=00, flg=00, set=03)
 instance variables [6]
  minval : Float 0
  maxval : Float 1
  warp : Symbol 'linear'
  step : Float 0
  default : Float 0
}


// array is used as arguments to ControlSpec.new( minval, maxval, warp, step, default)
[300,3000,\exponential,100].asSpec.dump
Instance of ControlSpec {  (0313FC08, gc=00, fmt=00, flg=00, set=03)
 instance variables [6]
  minval : Integer 300
  maxval : Integer 3000
  warp : Symbol 'exponential'
  step : Integer 100
  default : Integer 300
}
// partially specified ...
[-48,48].asSpec.dump
Instance of ControlSpec {  (0313FF18, gc=00, fmt=00, flg=00, set=03)
 instance variables [6]
  minval : Integer -48
  maxval : Integer 48
  warp : Symbol 'linear'
  step : Float 0
  default : Integer -48
}


constrain (value)
	clips and rounds the value to within the spec
	
	
map (value)
	maps a value from [0..1] to spec range
	
	
		
unmap (value)
	maps a value from the spec range to [0..1]




	// example
	
	// make a frquency spec with an exponential range from 20 to 20000,
	// give it a rounding of 30 (Hz)
	a = \freq.asSpec;
	a.step = 100;
	
	// equivalent:
	a = [20, 20000, 'exp', 100, 440].asSpec;
	a.dump;
	
	a.constrain(800); // make sure it is in range and round it.
	a.constrain(803); // make sure it is in range and round it.	

	a.map(0.5);
	a.map(0.0); // returns min
	a.map(1.5); // exceeds the area: clip, returns max
	
	a.unmap(4000);
	a.unmap(22.0);	
			
	// using spec for sliders:
	(
	var w, c, d;
	w = SCWindow("control", Rect(128, 64, 340, 160));
	w.front;
	c = SCSlider(w, Rect(10, 10, 300, 30));
	d = SCStaticText(w, Rect(10, 40, 300, 30));
	c.action = {
		d.string = "unmapped value"
		 + c.value.round(0.01)
		 + "......"
		 + "mapped value"
		 + a.map(c.value)
	};
	)
	
	
	
	
	


