# https://ncd.io/interfacing-onion-omega-with-industrial-4-20ma-sensors/
# Python Library to Read 4-20mA Inputs
# This code is designed to work with the MCP3428_I2CADC I2C Mini Module available from ControlEverything.com.
# https://shop.controleverything.com/collections/4-20-ma-current-loop-input
import smbus
import time
DL = 0.1
DL1 = 0.1
# Get I2C bus
address = 0x68
bus = smbus.SMBus(1)
 
# MCP3428 address, 0x68(104)
# Send configuration command
# 0x11(17)Continuous conversion mode, Channel-1, 12-bit Resolution,gain2
 
while True:
        with open('/sys/bus/w1/devices/10-000803a29c90/temperature', 'r') as f_9c90:
                print (f_9c90.read().rstrip("\n").zfill(6)[0:3], end=" ")
        with open('/sys/bus/w1/devices/10-000803a3613e/temperature', 'r') as f_613e:
                print (f_613e.read().rstrip("\n").zfill(6)[0:3], end=" ")
        with open('/sys/bus/w1/devices/10-000803a3ee77/temperature', 'r') as f_ee77:
                print (f_ee77.read().rstrip("\n").zfill(6)[0:3], end=" ")
        with open('/sys/bus/w1/devices/10-000803a3f855/temperature', 'r') as f_f855:
                print (f_f855.read().rstrip("\n").zfill(6)[0:3], end=" ")
        with open('/sys/bus/w1/devices/10-000803a47e7c/temperature', 'r') as f_7e7c:
                print (f_7e7c.read().rstrip("\n").zfill(6)[0:3], end=" ")
        bus.write_byte(address, 0x11)
        time.sleep(DL1)
# MCP3428 address, 0x68(104)
# Read data back from 0x00(0), 2 bytes
# raw_adc MSB, raw_adc LSB
        data = bus.read_i2c_block_data(address, 0x00, 2)
 
# Convert the data to 12-bits
        raw_adc = (data[0] & 0x0F) * 256 + data[1]
        if raw_adc > 2047 :
                raw_adc -= 4095
        current1 = (raw_adc * 0.01109)
# Output data to screen
#        print "Current Output channel 1 : %.2f" %current
        time.sleep(DL)
 
####### channel 2
        bus.write_byte(address, 0x31)
        time.sleep(DL1)
# MCP3428 address, 0x68(104)
# Read data back from 0x00(0), 2 bytes
# raw_adc MSB, raw_adc LSB
        data = bus.read_i2c_block_data(address, 0x00, 2)
 
# Convert the data to 12-bits
        raw_adc = (data[0] & 0x0F) * 256 + data[1]
        if raw_adc > 2047 :
                raw_adc -= 4095
        current2 = (raw_adc * 0.01109)
# Output data to screen
#        print "Current Output channel 2 : %.2f" %current1 + "%.2f"  %current
        time.sleep(DL)
############ channel 3 print (f_9c90.read().rstrip("\n").zfill(6))
        bus.write_byte(address, 0x51)
        time.sleep(DL1)
# MCP3428 address, 0x68(104)
# Read data back from 0x00(0), 2 bytes
# raw_adc MSB, raw_adc LSB
        data = bus.read_i2c_block_data(address, 0x00, 2)
 
# Convert the data to 12-bits
        raw_adc = (data[0] & 0x0F) * 256 + data[1]
        if raw_adc > 2047 :
                raw_adc -= 4095
        current3 = (raw_adc * 0.01101)
# Output data to screen
#        print "Current Output channel 3 : %.2f" %current
        time.sleep(DL)
####### channel 4
        bus.write_byte(address, 0x71)
        time.sleep(DL1)
# MCP3428 address, 0x68(104)
# Read data back from 0x00(0), 2 bytes
# raw_adc MSB, raw_adc LSB
        data = bus.read_i2c_block_data(address, 0x00, 2)
 
# Convert the data to 12-bits
        raw_adc = (data[0] & 0x0F) * 256 + data[1]
        if raw_adc > 2047 :
                raw_adc -= 4095
        current4 = (raw_adc * 0.01094)
# Output data to screen
        print (" Presure: %05.2f" %current1 + " %05.2f"  %current2 + " %05.2f"  %current3 + " %05.2f"  %current4)
        time.sleep(DL)
