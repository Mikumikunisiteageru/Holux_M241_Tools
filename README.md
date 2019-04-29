[//]: # (Holux_M241_Tools/README.md)
[//]: # (20190429)

# Holux_M241_Tools

## 提醒 M241 使用者

自北京时间 **2019 年 4 月 22 日 17:40:16** 起，M241 某个与时间相关的寄存器溢出，导致**时间不能显示**，同时**记录的时间向前推了 7168 天**。经度、纬度、海拔、速度均未受影响。

Decoder_v3.cpp 已经暂时压制了这个问题。如无意外，可以继续使用至北京时间 2023 年 8 月 26 日 21:37:04（随便设的）。到那时如果还有活着的小黄，再来续命不迟。

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
