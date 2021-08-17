#/bin/bash
mdHM=`date +%m%d%H%M`
HH=`date +%H`
MM=`date +%M`


  Ofentauch=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f5e9694/temperature`/1000))
   Ofenrein=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01206392000d/temperature`/1000))
   Ofenraus=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-0120637d77c2/temperature`/1000))
 BoilerOben=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f06980a/temperature`/1000))
 BoilerRuck=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f467cc2/temperature`/1000))
  AHausRein=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f4d9801/temperature`/1000))
  AHausRaus=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f63c800/temperature`/1000))
bBoden_Rein=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-0120634b5fc6/temperature`/1000))
    DG_Raus=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-012063614299/temperature`/1000))
EGBodenRaus=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f6306b8/temperature`/1000))
Puffer_Oben=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f7be960/temperature`/1000))
  Haus7Ruek=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f8f8ce2/temperature`/1000))
 KellerRuek=$((`cat /sys/bus/w1/devices/w1_bus_master1/28-01205f8f2ae3/temperature`/1000))

echo $mdHM";"$Ofentauch";"$Ofenrein";"$Ofenraus";"$BoilerOben";"$BoilerRuck";"$AHausRein";"$AHausRaus";"$bBoden_Rein";"$DG_Raus";"$EGBodenRaus";"$Puffer_Oben";$KellerRuek;"$Haus7Ruek >> tempwerte.txt

if [ ! -e /sys/class/gpio/gpio5 ]; then
	echo 5 > /sys/class/gpio/export
	echo 6 > /sys/class/gpio/export
	echo 12 > /sys/class/gpio/export
	echo 13 > /sys/class/gpio/export
	echo 16 > /sys/class/gpio/export
	echo 19 > /sys/class/gpio/export
	echo 20 > /sys/class/gpio/export
	echo 21 > /sys/class/gpio/export
	echo out > /sys/class/gpio/gpio5/direction; sleep 1
	echo out > /sys/class/gpio/gpio6/direction; sleep 1
	echo out > /sys/class/gpio/gpio12/direction; sleep 1
	echo out > /sys/class/gpio/gpio13/direction; sleep 1
	echo out > /sys/class/gpio/gpio16/direction; sleep 1
	echo out > /sys/class/gpio/gpio19/direction; sleep 1
	echo out > /sys/class/gpio/gpio20/direction; sleep 1
	echo out > /sys/class/gpio/gpio21/direction
	echo "$mdHM Initialisierung Keller-Relais -> DONE" >> meldung.txt
	echo 1 > /sys/class/gpio/gpio16/value
#Bodenheizung
	echo 18 > /sys/class/gpio/export
	echo 23 > /sys/class/gpio/export
	echo 24 > /sys/class/gpio/export
	echo 25 > /sys/class/gpio/export
	echo 17 > /sys/class/gpio/export
	echo 27 > /sys/class/gpio/export
	echo 22 > /sys/class/gpio/export
	echo 10 > /sys/class/gpio/export
	echo out > /sys/class/gpio/gpio18/direction && sleep 1
	echo out > /sys/class/gpio/gpio23/direction && sleep 1
	echo out > /sys/class/gpio/gpio24/direction && sleep 1
	echo out > /sys/class/gpio/gpio25/direction && sleep 1
	echo out > /sys/class/gpio/gpio17/direction && sleep 1
	echo out > /sys/class/gpio/gpio27/direction && sleep 1
	echo out > /sys/class/gpio/gpio22/direction && sleep 1
	echo out > /sys/class/gpio/gpio10/direction
	echo "$mdHM Initialisierung Keller-Relais -> DONE" >> meldung.txt

fi
# ANZEIGEN oder Melden
#if [ $HM -eq 0000 ]; then ; sudo -H -u pi lxterminal --geometry=80x10-0 -e "tail -f $md" & ; fi
#if [ $BoilerOben -lt 39 ] && [ ! `pidof gpicview Pictures/bartBAD.jpeg` ]; then
if [ $BoilerOben -lt 39 ] && [ ! -f boiler_warn_proc ]; then
	echo "$mdHM BoilerOben ist kleiner als 39 genau: $BoilerOben" >> meldung.txt
#	sudo -H -u pi gpicview Pictures/bartBAD.jpeg &
	minuten=200
	sudo -H -u pi gnuplot -p -e "set datafile separator ';'; set style line 101 lw 5 lt rgb '#09000f'; set style line 102 lw 5 lt rgb '#1234f6'; set style line 103 lw 5 lt rgb '#72bfaa'; set yrange [10:100]; set terminal wxt size 1000,800 position 280,224 font ',14'; plot '< tail -$minuten tempwerte.txt | cut -c 5-' using 1:5 title 'BoilerOben' with lines ls 101, '' using 1:6 title 'BoilerUnten' with lines ls 102, '' using 1:12 title 'PufferOben' with lines ls 103" &
	touch boiler_warn_proc
fi
if [ $BoilerOben -gt 42 ] && [ -f boiler_warn_proc ]; then
	rm boiler_warn_proc
fi
# Relais-Schalten
if [ $Ofentauch -gt 50 ] && [ `cat /sys/class/gpio/gpio21/value` -eq 1 ]; then
	echo 0 > /sys/class/gpio/gpio21/value
	echo "$mdHM Ofenpumpe an" >> meldung.txt
fi
if [ $Ofentauch -lt 35 ] && [ `cat /sys/class/gpio/gpio21/value` -eq 0 ]; then
	echo 1 > /sys/class/gpio/gpio21/value
	echo "$mdHM Ofenpumpe aus" >> meldung.txt
fi
if [ $Ofentauch -gt 55 ] && [ $Ofentauch -gt $BoilerRuck ] && [ $BoilerOben -lt 50 ] && [ `cat /sys/class/gpio/gpio20/value` -eq 1 ]; then
	echo 0 > /sys/class/gpio/gpio20/value
	echo "$mdHM Boilerladung started, Ofen > 55 Grad und heisser als Boilerrucklauf" >> meldung.txt
fi
if ( [ $Ofentauch -lt 40 ] && [ `cat /sys/class/gpio/gpio20/value` -eq 0 ] ) || ( [ $Ofentauch -lt $BoilerRuck ] && [ `cat /sys/class/gpio/gpio20/value` -eq 0 ] ); then
	echo 1 > /sys/class/gpio/gpio20/value
	echo "$mdHM Boilerladung ended, Ofen niedriger als Boilerrucklauf oder < 40Grad " >> meldung.txt
fi
if ( [ $BoilerOben -gt 60 ] && [ `cat /sys/class/gpio/gpio20/value` -eq 0 ] ) || ( [ $Ofentauch -lt $BoilerRuck ] && [ `cat /sys/class/gpio/gpio20/value` -eq 0 ] ); then
	echo 1 > /sys/class/gpio/gpio20/value
	echo "$mdHM Boilerladung ended, BoilerOben erreicht 61 Grad " >> meldung.txt
fi
if ( [ $Ofentauch -gt 80 ] && [ `cat /sys/class/gpio/gpio12/value` -eq 1 ] ) || ( [ `date +%H%M` -eq 0500 ] ); then
	echo 0 > /sys/class/gpio/gpio12/value # -> Pufferladung = ON   GPIO 12 und 13
	echo "$mdHM PufferAuf, Ofentauch: $Ofentauch oder Zeit 0600" >> meldung.txt
	if [ `cat /sys/class/gpio/gpio5/value` -eq 0 ] && [ $Ofentauch -lt 40 ]; then
		echo 1 > /sys/class/gpio/gpio5/value
		echo "$mdHM Ofenmischer zu, nur Pufferentladen" >> meldung.txt
	fi
fi
if [ $Ofentauch -lt 70 ] && [ `cat /sys/class/gpio/gpio12/value` -eq 0 ] && [ `date +%H` -ne 05 ] && [ `date +%H` -ne 06 ] && [ `date +%H` -ne 07 ]; then
	echo 1 > /sys/class/gpio/gpio12/value
	echo "$mdHM PufferZu, Ofentauch: $Ofentauch oder Zeit 0800" >> meldung.txt
	if [ `cat /sys/class/gpio/gpio5/value` -eq 1 ]; then
		echo 0 > /sys/class/gpio/gpio5/value
		echo "$mdHM Ofenmischer auf, Pufferentnahme beendet" >> meldung.txt
	fi
fi
if [ $Ofentauch -gt 85 ] && [ `cat /sys/class/gpio/gpio16/value` -eq 1 ]; then
	echo 0 > /sys/class/gpio/gpio16/value
	echo "$mdHM haus 2 auf gt85" >> meldung.txt
fi
if [ $Ofentauch -lt 72 ] && [ `cat /sys/class/gpio/gpio16/value` -eq 0 ]; then
	echo 1 > /sys/class/gpio/gpio16/value
	echo "$mdHM haus 2 zu lt72" >> meldung.txt
fi
#[ ! `pidof /usr/bin/omxplayer.bin` ] && lxterminal -e "omxplayer -o local --vol 2000 --loop ~/Videos/ofen1.mp4"
# omxplayer --win "50 50 850 650" -o local --vol 2000 --loop ~/Videos/ofen1.mp4 > /dev/null 2>&1
#BoilerLAde	lxterminal -e "omxplayer -o local --vol 2000 --loop ~/Videos/ofen1.mp4"


if [ "$MM" = '00' ]; then
HH=`expr $HH + 1`
sed -ne "${HH}p" bzeiten.txt > bcurrentHour.txt
	if [ `cut -d ' ' -f 2 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio25/value; else echo 1 > /sys/class/gpio/gpio25/value; fi
	if [ `cut -d ' ' -f 3 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio23/value; else echo 1 > /sys/class/gpio/gpio23/value; fi
	if [ `cut -d ' ' -f 4 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio24/value; else echo 1 > /sys/class/gpio/gpio24/value; fi
	if [ `cut -d ' ' -f 5 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio18/value; else echo 1 > /sys/class/gpio/gpio18/value; fi
	if [ `cut -d ' ' -f 6 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio10/value; else echo 1 > /sys/class/gpio/gpio10/value; fi
	if [ `cut -d ' ' -f 7 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio22/value; else echo 1 > /sys/class/gpio/gpio22/value; fi
	if [ `cut -d ' ' -f 8 bcurrentHour.txt` = 'X' ]; then echo 0 > /sys/class/gpio/gpio27/value; else echo 1 > /sys/class/gpio/gpio27/value; fi
[ `cut -d ' ' -f 9 bcurrentHour.txt` = 'X' ] && echo 0 > /sys/class/gpio/gpio17/value || echo 1 > /sys/class/gpio/gpio17/value
fi
# field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK"
# i=0; while read zeile; do echo $zeile $((i++)); let i==24?i=0:8888; done < bodenheizsettings.txt
# for i in 1 25 49 73 97 121 149 169; do sed -ne "${i}p" bodenheizsettings.txt | tr \\n ' '; done
# echo -n "0 Uhr  " ; for i in 2 26 50 74 98 122 146 170; do sed -ne "${i}p" bodenheizsettings.txt | tr \\n ' '; done; echo ""

