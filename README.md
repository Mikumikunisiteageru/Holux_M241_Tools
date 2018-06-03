[//]: # (Holux_M241_Tools/README.md)

# Holux_M241_Tools

## Introduction

Codes and Scripts for decoding binary data file from Holux M-241 GPS Logger.
Written in C++ and MATLAB.

## Usage

1. Download binary data from M-241 / M-241A using the Android app *GPS Device Toolbox*:
https://play.google.com/store/apps/details?id=com.diaohs.gdt&hl=en_US
2. Rename the `.bin` file downloaded as `GPS.bin`.
3. Compile and run `Decode_v2.cpp` to translate `GPS.bin` into `GPS.tsv`.
4. Run `Photo_Coordinates_Calc.m` to map these data to specified photos, so that the coordinates where the photos were taken are clear.
 
## Update History

- 2018.6.1: ver. 1
  
