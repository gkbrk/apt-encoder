APT encoder
===========

1. Synopsis

   apt-encoder reads image files and turns them into sound data modulated as APT
   signals. APT is a way to send images as audio, and it is used by NOAA weather
   satellites. It is a simple format that a lot of people recognize by sound,
   and decoders for it are easily available. This makes it a good candidate for
   simple radio faxing.

2. License

   This program is free software: you can redistribute it and/or modify it under
   the terms of the GNU Affero General Public License as published by the Free
   Software Foundation, either version 3 of the License, or (at your option) any
   later version.
   
   This program is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
   FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
   details.
   
   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.

2. User manual


2.1. Building the software

   In order to build the project, run `make`. It will produce a binary called
   'apt-encode'. You will need to have Make and a C++ compiler on your system.

2.2. Picture format

   The program needs pictures encoded in the PGM format [1]. You can use an
   image editor, such as GIMP, in order to create these files. The format needed
   by the program is P2, also known as the 'Text' encoding of PGM. Please note
   that some image encoders might put a comment line that starts with '#'. You
   will need to remove that with a text editor before using the program.

   The images will need to have a width of 909 pixels, and they can have any
   height. The program can handle images of different heights. If two images
   with different heights are encoded, the shorter image will be padded with
   black pixels.

2.3. Configuration parameters

   The program has a few knobs that can be tweaked. These are located in the
   "Constants and config" section of the C++ file. If you want the signal to be
   understood by existing decoders, you should only change the OVERSAMPLE
   option.

   CARRIER: This option determines the carrier frequency of the output. It is
   defined to be 2400 Hz by the APT specification.

   BAUD: Determines the speed of the transmission. The APT specification defines
   this to be 4160.

   OVERSAMPLE: How many audio samples to output for each word. The output sample
   rate is BAUD * OVERSAMPLE.

   SYNCA and SYNCB: Sync words that appear before image A and image B
   respectively.

2.4. Usage examples

2.4.1. Encoding the same image for both sections

   In order to provide some data redundancy, you can transmit the same picture
   for both images of the transmission. Just pass the same file to the program
   twice.

   ./apt-encode ~/image1.pgm ~/image2.pgm

2.4.2. Playing the output from the computer

   You can play the output signal from the computer sound card / speakers.

   ./apt-encode ~/image1.pgm ~/image2.pgm | aplay -r 8320

   Replace 8320 with the actual sample rate based on the oversample value.

2.4.3. Creating WAV files

   ./apt-encode ~/image1.pgm ~/image2.pgm > encode.raw
   sox -t raw -b 8 -e unsigned -c 1 -r 8320 encode.raw -r 11025 ~/apt.wav

   This creates a WAV file with a sample rate of 11025.

3. Links and references

   [1]: https://en.wikipedia.org/wiki/Netpbm#PGM_example
