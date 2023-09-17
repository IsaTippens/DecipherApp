f = open("encrypted.txt", "r")

freq = {}
word_freq = {}

for line in f:
    for char in line:
        if char in freq:
            freq[char] += 1
        else:
            freq[char] = 1
    
    for word in line.split():
        word = word.strip(".,'")
        if word in word_freq:
            word_freq[word] += 1
        else:
            word_freq[word] = 1
        
# convert to list and sort
freq_list = [(k, v) for k, v in freq.items()]
freq_list.sort(key=lambda x: x[1], reverse=True)

# print the list
print("LETTER FREQ:")
for i in freq_list:
    print(i[0], ":", i[1])
print()
word_freq_list = [(k, v) for k, v in word_freq.items()]
# sort by frequency and length
word_freq_list.sort(key=lambda x: (len(x[0]), x[1]))
print("WORD FREQ:")
for i in word_freq_list:
    print(i[0], ":", i[1])

lookup = {
    
    # Frequency
    'S': 'E',
    'G': 'O',

    # OIS
    'O': 'T',
    'I': 'H',

    # Word M
    'M': 'A',

    # DSOOSKL
    'L': 'S',

    # DSOOSK
    'D': 'L',
    'K': 'R',

    # WS
    'W': 'W',

    # Guesses
    # EGLO = _OST
    'E': 'M',
    # NMDD = _ALL
    'N': 'C',
    # CGKE = _ORM
    'C': 'F',
    # GNNQKKSFNSL = OCC_RRE_CES
    'Q': 'U',
    'F': 'N',
    # ESLLMRS = MESSA_E
    'R': 'G',
    # UPCCSKSFO = __FFERENT
    'U': 'D',
    'P': 'I',
    # SFNKYHOSU = ENCR__TED
    'Y': 'Y',
    'H': 'P',
    # HDMPFOSXO = PLAINTE_T
    'X': 'X',
    # LGDVS = SOL_E
    'V': 'V', 
    # BFGW = _NOW
    'B': 'K',
    # LYEAGD = SYM_OL
    'A': 'B',
    # CKSJQSFODY = FRE_UENTLY
    'J': 'Q',
}
output = open("output.txt", "w")
f.close()
f = open("encrypted.txt", "r")
for line in f:
    for char in line:
        if char in [' ', '\n', '\t', "'", ',', '.']:
            output.write(char)
            continue

        if char in lookup:
            output.write(lookup[char])
        else:
            output.write("_")

output.close()
f.close()