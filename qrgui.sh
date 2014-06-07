#!/bin/bash
#
# Copyright (C) 2014 ssdclickofdeath
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

ICON=qricon.png
TITLE="Qrgui (UNREGISTERED)"
#Checks if qrencode is installed.
qrencode -o /dev/null "Test"

if  [ $? = 127 ]; then
    echo -e "Qrencode (The QR code generator) is not installed.";
    zenity --info \
           --window-icon=$ICON \
           --title="$TITLE" \
           --width=400 \
           --text="The QR code generator (qrencode) is not installed. It must be installed for qrgui to work.

Try installing it with your preferred package manager."
    exit 1;
fi

#Print name and copyright information.
echo "qrgui 1.0"
echo "Copyright (C) 2014 ssdclickofdeath"
echo "This is free software; see README for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."

(
echo  "20" ; sleep 1
echo  "40" ; sleep 1
echo  "60" ; sleep 1
echo  "80" ; sleep 1
echo "100" ; sleep 1
echo # Time Done"
) |
zenity --progress \
       --title="$TITLE" \
       --text="This is the shareware version of Qrgui.
If you like it, pay for it. (Wait five seconds)"

if  [ $? = 1 ]; then
    echo -e "\nExiting qrgui..."; exit 1;
fi

QRSTRING=$(zenity --entry \
                  --title="$TITLE" \
                  --window-icon=$ICON \
                  --text="Enter text to encode into a QR code." \
                  --width=300)

#Checks if window was closed/canceled by looking
#for exit code 1, if so, the program is closed.
if  [ $? = 1 ]; then
    echo -e "\nExiting qrgui..."; exit 1;
fi

# Makes an empty variable to compare to QRSTRING to check for empty text entry.
BLANK=""

#Compares QRSTRING to BLANK to see if text entry field is blank.
#If the field is blank, make a dialog box showing the error.
if [ $QRSTRING = $BLANK ]; then
    zenity --error \
           --width=270 \
           --title="$TITLE" \
           --window-icon=$ICON \
     --text="The text entry field cannot be blank. Qrgui will now close." \
           --timeout=4
           echo -e "\nExiting qrgui..."
           exit 1;
fi

(
echo  "20" ; sleep 1
echo  "40" ; sleep 1
echo  "60" ; sleep 1
echo  "80" ; sleep 1
echo "100" ; sleep 1
echo # Time Done"
) |
zenity --progress \
       --title="$TITLE" \
       --text="This is the shareware version of Qrgui. If you like it, pay for it.
(Wait five seconds)"

if  [ $? = 1 ]; then
    echo -e "\nExiting qrgui..."; exit 1;
fi

#Sets the variable FILENAME to the name and path to save the QR code.
FILENAME=$(zenity --file-selection \
              --window-icon=$ICON \
              --title="Save QR Code - $TITLE" \
              --save \
              --confirm-overwrite)

#Checks if window was closed/canceled by looking
#for exit code 1, if so, the program is closed.
if  [ $? = 1 ]; then
    echo -e "\nExiting qrgui..."; exit 1;
fi

#Generates the QR code.
qrencode -o "$FILENAME" "$QRSTRING"

#Checks if QR code was generated successfully.
if  [ $? = 0 ]; then
    echo -e "\nQR code generated successfully"; exit 0;
                else
    echo -e "\nAn error occured."; exit 1;
fi

sleep 10

zenity --info \
       --title="Register Qrgui" \
       --text="Register Qrgui now and run it without having to wait.
Visit http://example.com/invalid-offers/qrgui-annoying.aspx/ to register today.
(Or just visit https://ssdclickofdeath.github.io/qrgui/ and download the non-annoying version at no charge.)"
exit 0;