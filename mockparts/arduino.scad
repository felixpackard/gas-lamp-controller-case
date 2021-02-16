include <../config/_config.scad>
include <../utils/arduino.scad>

/***********************
* ARDUINO MOCK PART
* Renders the arduino mock part
***********************/
module arduinoMockPart() {
    translate(explode ? [0, 0, height_extension + 25] : vector_zero)
	translate([0, 0, wall_thickness + standoff_height]) arduino();
}

/***********************
* RENDER
***********************/
arduinoMockPart();