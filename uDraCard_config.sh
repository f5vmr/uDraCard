#!/bin/bash

# Initial Information
whiptail --title "INFORMATION:" --msgbox "This program allows the programming of the uDraCard. It is necessary to turn the switches 2 and 3 to ON. Team F4ICR/F5SWB/F8ASB" 15 60

while :; do
    choix=$(whiptail --title "Make your choice now" --radiolist "What do you wish to do?" 15 50 4 \
        "1" "CONFIGURATION uDraCard" ON \
        "2" "Send to the uDraCard" OFF 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        echo "Your chosen option: $choix"
    else
        echo "You chose Cancel."
        break
    fi

    choixfreqtx() {
        freqtx=$(whiptail --inputbox "Frequency TX XXX.XXXX ?" 8 39 433.5000 --title "Frequency TX" 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "Frequency TX $freqtx"
            choixctcsstx
        else
            echo "Cancel"
        fi
    }

    choixctcsstx() {
        CTCSSTX=$(whiptail --title "Choose your CTCSS" --radiolist "Frequency CTCSS on TX?" 40 32 32 \
            "0000" "No CTCSS" ON \
            "0001" "67.0Hz" OFF \
            "0002" "71.9Hz" OFF \
            "0003" "74.4Hz" OFF \
            "0004" "77.0Hz" OFF \
            "0005" "79.7Hz" OFF \
            "0006" "82.5Hz" OFF \
            "0007" "85.4Hz" OFF \
            "0008" "88.5Hz" OFF \
            "0009" "91.5Hz" OFF \
            "0010" "94.8Hz" OFF \
            "0011" "97.4Hz" OFF \
            "0012" "100.0Hz" OFF \
            "0013" "103.5Hz" OFF \
            "0014" "107.2Hz" OFF \
            "0015" "110.9Hz" OFF \
            "0016" "114.8Hz" OFF \
            "0017" "118.8Hz" OFF \
            "0018" "123.0Hz" OFF \
            "0019" "127.3Hz" OFF \
            "0020" "131.8Hz" OFF \
            "0021" "136.5Hz" OFF \
            "0022" "141.3Hz" OFF \
            "0023" "146.2Hz" OFF \
            "0024" "151.4Hz" OFF \
            "0025" "156.7Hz" OFF \
            "0026" "162.2Hz" OFF \
            "0027" "167.9Hz" OFF \
            "0028" "173.8Hz" OFF \
            "0029" "179.9Hz" OFF \
            "0030" "186.2Hz" OFF \
            "0031" "192.8Hz" OFF \
            "0032" "203.5Hz" OFF \
            "0033" "210.7Hz" OFF \
            "0034" "218.1Hz" OFF \
            "0035" "225.7Hz" OFF \
            "0036" "233.6Hz" OFF \
            "0037" "241.8Hz" OFF \
            "0038" "250.3Hz" OFF 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "CTCSS TX $CTCSSTX"
            choixfreqrx
        else
            echo "Cancel"
            choixfreqtx
        fi
    }

    choixfreqrx() {
        freqrx=$(whiptail --inputbox "Frequency RX XXX.XXXX ?" 8 39 433.5000 --title "Frequency RX" 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "Frequency RX $freqrx"
            choixctcssrx
        else
            echo "Cancel"
            choixctcsstx
        fi
    }

    choixctcssrx() {
        CTCSSRX=$(whiptail --title "Choose your CTCSS" --radiolist "Frequency CTCSS on RX?" 40 32 32 \
            "0000" "No CTCSS" ON \
            "0001" "67.0Hz" OFF \
            "0002" "71.9Hz" OFF \
            "0003" "74.4Hz" OFF \
            "0004" "77.0Hz" OFF \
            "0005" "79.7Hz" OFF \
            "0006" "82.5Hz" OFF \
            "0007" "85.4Hz" OFF \
            "0008" "88.5Hz" OFF \
            "0009" "91.5Hz" OFF \
            "0010" "94.8Hz" OFF \
            "0011" "97.4Hz" OFF \
            "0012" "100.0Hz" OFF \
            "0013" "103.5Hz" OFF \
            "0014" "107.2Hz" OFF \
            "0015" "110.9Hz" OFF \
            "0016" "114.8Hz" OFF \
            "0017" "118.8Hz" OFF \
            "0018" "123.0Hz" OFF \
            "0019" "127.3Hz" OFF \
            "0020" "131.8Hz" OFF \
            "0021" "136.5Hz" OFF \
            "0022" "141.3Hz" OFF \
            "0023" "146.2Hz" OFF \
            "0024" "151.4Hz" OFF \
            "0025" "156.7Hz" OFF \
            "0026" "162.2Hz" OFF \
            "0027" "167.9Hz" OFF \
            "0028" "173.8Hz" OFF \
            "0029" "179.9Hz" OFF \
            "0030" "186.2Hz" OFF \
            "0031" "192.8Hz" OFF \
            "0032" "203.5Hz" OFF \
            "0033" "210.7Hz" OFF \
            "0034" "218.1Hz" OFF \
            "0035" "225.7Hz" OFF \
            "0036" "233.6Hz" OFF \
            "0037" "241.8Hz" OFF \
            "0038" "250.3Hz" OFF 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "CTCSS RX $CTCSSRX"
            choixpas
        else
            echo "Cancel"
            choixfreqrx
        fi
    }

    choixpas() {
        SPACE=$(whiptail --title "Modes of Transmission :" --radiolist "Your choice?" 15 40 6 \
            "0" "NFM - 12.5Khz" ON \
            "1" "WFM - 25Khz" OFF 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "Step: $SPACE"
            choixhighpass
        else
            echo "Cancel"
            choixctcssrx
        fi
    }

    choixhighpass() {
        HIGHPASS=$(whiptail --title "Audio TX - level of treble" --radiolist "Activate the HIGHPASS filter?" 15 40 6 \
            "0" "Yes" OFF \
            "1" "No" ON 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "HIGHPASS: $HIGHPASS"
            choixlowpass
        else
            echo "Cancel"
            choixpas
        fi
    }

    choixlowpass() {
        LOWPASS=$(whiptail --title "Audio TX - Activation of the bass" --radiolist "Activate the LOWPASS filter?" 15 40 6 \
            "0" "Yes" OFF \
            "1" "No" ON 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "LOWPASS: $LOWPASS"
            choixpreamp
        else
            echo "Cancel"
            choixhighpass
        fi
    }

    choixpreamp() {
        if (whiptail --title "Amplification of treble" --yesno "Do you want to keep the amplification of the treble (yes by default)" 8 78); then
            PREAMP=1
        else
            PREAMP=0
        fi
        echo "PREAMP: $PREAMP"
        choixsquelch
    }

    choixsquelch() {
        SQUELCH=$(whiptail --title "Choose the level of the Squelch" --radiolist "Your choice?" 15 60 9 \
            "0" "level 0" OFF \
            "1" "level 1" OFF \
            "2" "level 2" ON \
            "3" "level 3" OFF \
            "4" "level 4" OFF \
            "5" "level 5" OFF \
            "6" "level 6" OFF \
            "7" "level 7" OFF \
            "8" "level 8" OFF 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "LEVEL OF SQUELCH: $SQUELCH"
            choixvolume
        else
            echo "Cancel"
            choixpreamp
        fi
    }

    choixvolume() {
        VOLUME=$(whiptail --title "Choose the level of volume" --radiolist "Your choice?" 15 60 9 \
            "0" "level 0" OFF \
            "1" "level 1" OFF \
            "2" "level 2" ON \
            "3" "level 3" OFF \
            "4" "level 4" OFF \
            "5" "level 5" OFF \
            "6" "level 6" OFF \
            "7" "level 7" OFF \
            "8" "level 8" OFF 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            echo "LEVEL OF VOLUME: $VOLUME"
            ecriturefichier
        else
            echo "Cancel"
            choixsquelch
        fi
    }

    ecrituredra() {
        echo "WRITE TO THE DRA"
        whiptail --title "INFORMATION:" --msgbox "Programming the uDraCard. It is necessary to turn on switches 2 and 3 to ON. At the end of the programming, the system will restart..." 15 60
        python3 uDraCard/uDraProg.py
        exit 0
    }

    ecriturefichier() {
        echo "WRITING THE PARAMETERS"
        echo ""

        cat > uDraCard/parametres.py <<EOF
#!/usr/bin/python3
# -*- coding: utf-8 -*-

# VARIABLES CONFIGURATION DRA/SA818
volumelevel = '$VOLUME'       # volume 2-8
filterpre = '$PREAMP'   # Filter pre/de-emph
lowpass= '$LOWPASS'
highpass= '$HIGHPASS'

# GENERAL CONFIG  : 'AT+DMOSETGROUP={},{},{},{},{},{}\r\n'.format(channelspace, txfreq, rxfreq, txcxcss, squelch, rxcxcss)
channelspace = '$SPACE'     # 0=12.5kHz, 1=25kHz
txfreq = '$freqtx'          # TX frequency
rxfreq = '$freqrx'          # RX frequency
squelch = '$SQUELCH'        # SQUELCH 0-8 (0 = open)
txctcss = '$CTCSSTX'        # CTCSS / CDCSS
rxctcss = '$CTCSSRX'        # CTCSS / CDCSS
EOF
    }

    case $choix in
        1)
            choixfreqtx
            ;;
        2)
            pkill spotnik2hmi
            ecrituredra
            ;;
    esac
done

exit 0
