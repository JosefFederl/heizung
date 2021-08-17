#!/bin/bash
yad --form --columns=8 \
--field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" --field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK" \
| tr '|' '\n' > b1.txt 
sed 's/TRUE/X/g' b1.txt > b2.txt
sed 's/FALSE/_/g' b2.txt > b3.txt
(echo -n "00 " ; for i in 1  25 49 73 97  121 145 169; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  > bzeiten.txt
(echo -n "01 " ; for i in 2  26 50 74 98  122 146 170; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "02 " ; for i in 3  27 51 75 99  123 147 171; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "03 " ; for i in 4  28 52 76 100 124 148 172; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "04 " ; for i in 5  29 53 77 101 125 149 173; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "05 " ; for i in 6  30 54 78 102 126 150 174; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "06 " ; for i in 7  31 55 79 103 127 151 175; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "07 " ; for i in 8  32 56 80 104 128 152 176; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "08 " ; for i in 9  33 57 81 105 129 153 177; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "09 " ; for i in 10 34 58 82 106 130 154 178; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "10 " ; for i in 11 35 59 83 107 131 155 179; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "11 " ; for i in 12 36 60 84 108 132 156 180; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "12 " ; for i in 13 37 61 85 109 133 157 181; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "13 " ; for i in 14 38 62 86 110 134 158 182; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "14 " ; for i in 15 39 63 87 111 135 159 183; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "15 " ; for i in 16 40 64 88 112 136 160 184; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "16 " ; for i in 17 41 65 89 113 137 161 185; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "17 " ; for i in 18 42 66 90 114 138 162 186; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "18 " ; for i in 19 43 67 91 115 139 163 187; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "19 " ; for i in 20 44 68 92 116 140 164 188; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "20 " ; for i in 21 45 69 93 117 141 165 189; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "21 " ; for i in 22 46 70 94 118 142 166 190; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "22 " ; for i in 23 47 71 95 119 143 167 191; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt
(echo -n "23 " ; for i in 24 48 72 96 120 144 168 192; do sed -ne "${i}p" b3.txt | tr \\n ' '; done; echo "")  >> bzeiten.txt


# [ $(sed -ne "24p" bzeiten.txt | cut -d ' ' -f 3) == 'X' ] && echo ja

# field="00:CHK" --field="01:CHK" --field="02:CHK" --field="03:CHK" --field="04:CHK" --field="05:CHK" --field="06:CHK" --field="07:CHK" --field="08:CHK" --field="09:CHK" --field="10:CHK" --field="11:CHK" --field="12:CHK" --field="13:CHK" --field="14:CHK" --field="15:CHK" --field="16:CHK" --field="17:CHK" --field="18:CHK" --field="19:CHK" --field="20:CHK" --field="21:CHK" --field="22:CHK" --field="23:CHK"
# i=0; while read zeile; do echo $zeile $((i++)); let i==24?i=0:8888; done < bodenheizsettings.txt
# for i in 1 25 49 73 97 121 149 169; do sed -ne "${i}p" bodenheizsettings.txt | tr \\n ' '; done
# echo -n "0 Uhr  " ; for i in 2 26 50 74 98 122 146 170; do sed -ne "${i}p" bodenheizsettings.txt | tr \\n ' '; done; echo ""
