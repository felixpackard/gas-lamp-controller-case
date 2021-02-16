/***********************
*
* Light Controller Box
* designed for Settle Hackspace by Felix Packard
*
* Hardware used:
*
* ELEGOO UNO R3 Arduino Compatible Board
*	https://www.amazon.co.uk/ELEGOO-Board-ATmega328P-ATMEGA16U2-Cable/dp/B01EWOE0UU/
* MakerHawk I2C OLED Display Module
*	https://www.amazon.co.uk/MakerHawk-Display-Module-SSD1306-Arduino/dp/B07BDFXFRK/
* Mini Momentary Push Button Switch
*	https://www.amazon.co.uk/gp/product/B07FQRV69V/
*
***********************/

/***********************
* Include utility libraries
***********************/
include <utils/arduino.scad>
include <utils/constants.scad>

/***********************
* Include config files
***********************/
include <config/_config.scad>

/***********************
* Include part files
***********************/
use <parts/enclosure.scad>
use <parts/enclosure_lid.scad>

use <mockparts/arduino.scad>
use <mockparts/screen.scad>

/***********************
* ROOT PREVIEW MODULE
* Conditionally render each module for the purpose of previewing
***********************/
module rootPreview() {
    // Parts
    if (show_enclosure) enclosurePart();
    if (show_lid) enclosureLidPart();

    // Mock parts
    if (show_arduino) arduinoMockPart();
    if (show_screen) screenMockPart();
}

/***********************
* RENDER
***********************/
rootPreview();