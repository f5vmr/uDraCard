#!/usr/bin/python3
# -*- coding: utf-8 -*-

#IMPORT CONFIGURATION
import serial
import re
import parametres as s

import json

Json="/etc/svxlink/config.json"


serport = '/dev/serial0'
baud = '9600'
ser = serial.Serial(serport, baud, timeout=2)

def updatefreq_json():

    #opening JSON
    with open(Json, 'r') as f:
        config = json.load(f)
        config['rx_qrg'] = str(s.rxfreq)
        config['tx_qrg'] = str(s.txfreq)
        config['ctcss_fq'] = str(s.txctcss)
    #writing JSON
    with open(Json, 'w') as f:
        json.dump(config, f) 
        print(' Json file written ')

#VERIFYING FREQUENCIES
def validate(freq):
	r = re.compile('\d{3}[\s.]\d{4}')
	s = str(freq)
	if len(s) ==8 and r.match(s):
		print(freq+"->FREQUENCIES CONFORM")
	else:
		print('\x1b[7;37;41m'+freq+"->ERROR INPUTTING FREQUENCY, TRY TO REDO THE CONFIGURATION"+'\x1b[0m')
		exit()

def connect():
	#CONNECTION to DRA SI=0 OK SI=1 Not OK
	ser.write(b'AT+DMOCONNECT\r\n')
	output = ser.readline()
	print('Opening port: ' + ser.name)
	print('\r\nConnection...')
	if output.decode("utf-8")!="":
		print('reponse (0=OK): ' + output.decode("utf-8"))
	else:
		print('\x1b[7;37;41m'+"VERIFIE THE CONNECTION WITH DRA/SA818! ( switch 2 and 3 are ON)"+'\x1b[0m')
		exit()

#DEFINITON OF the FUNCTIONS
def volume():
	volume = 'AT+DMOSETVOLUME={}\r\n'.format(s.volumelevel)
	ser.write(volume.encode())
	output = ser.readline()
	print('Reponse (0=OK) (1=KO) : ' + output.decode("utf-8"))
	
	if output.decode("utf-8")!="":
		print('response (0=OK): ' + output.decode("utf-8"))
	else:
		print('\x1b[7;37;41m'+"VERIFY THE CONNECTION WITH THE DRA/SA818! ( switch 2 and 3 are ON)"+'\x1b[0m')
		exit()

	print('The volume is now at : ' +str(s.volumelevel))
	print("-+-+-+-+-+-+-+-+-+-+-+-+-+-")

def filters():
	filter = 'AT+SETFILTER={},{},{}\r\n'.format(s.filterpre, s.highpass, s.lowpass)
	ser.write(filter.encode())
	output = ser.readline()
	print('Send the filter commands to the DRA ;) ')
	print('Response from DRA (0=OK) (1=KO) : ' + output.decode("utf-8"))
	
	if output.decode("utf-8")!="":
		print('response (0=OK): ' + output.decode("utf-8"))
	else:
		print('\x1b[7;37;41m'+"VERIFY THE CONNECTION WITH THE DRA/SA818! ( switch 2 and 3 are ON)"+'\x1b[0m')
		exit()

	print('Regulations of the DRA filter underway...')
	print('                                      pre/dehamphasis          highpass          lowpass')
	print('The filters are now at :       ' +str(s.filterpre)+'                        ' +str(s.highpass)+'             ' +str(s.lowpass))
	
def config():
	config = 'AT+DMOSETGROUP={},{},{},{},{},{}\r\n'.format(s.channelspace, s.txfreq, s.rxfreq, s.txctcss, s.squelch, s.rxctcss)
	ser.write(config.encode())
	print(config)
	output = ser.readline()
	print('Send command 0=12.5kHz, 1=25kHz: '+str(s.channelspace))
	print('Send frequency TX: '+str(s.txfreq))
	print('Send frequency RX: '+str(s.rxfreq))
	print('Send CTCSS TX: '+str(s.txctcss))
	print('Send CTCSS RX: '+str(s.rxctcss))
	print('Send squelch: '+str(s.squelch))

def readversion():
	config='AT+VERSION\r\n'
	ser.write(config.encode())
	output = ser.readline()
	print (output.decode("utf-8"))

validate(s.txfreq)
validate(s.rxfreq)
connect()
readversion()
volume()
filters()
config()
updatefreq_json()

