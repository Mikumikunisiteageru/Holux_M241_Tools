[//]: # (Holux_M241_Tools/README.md)
[//]: # (20190429)

# Holux_M241_Tools

## Introduction

Codes and Scripts for decoding binary data file from Holux M-241 GPS Logger.
Written in C++ and MATLAB.

## Usage

1. Download binary data from M-241 / M-241A using the Android app *GPS Device Toolbox* (https://play.google.com/store/apps/details?id=com.diaohs.gdt&hl=en_US) or *AndroidMTK* (https://play.google.com/store/apps/details?id=com.androidmtk&hl=en_US):
2. Rename the `.bin` file downloaded as `GPS.bin`.
3. Compile and run `Decode_v2.cpp` to translate `GPS.bin` into `GPS.tsv`.
4. Run `Photo_Coordinates_Calc.m` to map these data to specified photos, so that the coordinates where the photos were taken are clear.
 
## Update History

- 2018.5.31: ver.1
- 2018.6.1: ver.2
- 2019.4.29: ver.3

## Newest Feature of Decoder_v3

Since UTC+0 2019-04-22T09:40:16, M241 is no longer able to display the time or to log it correctly. The problem was caused by some integer digit overflow at that time. After that all time records were shifted to 7,168.00000 days earlier.

`Decoder_v3.cpp` solved this problem by adding the 7,168 days back.
