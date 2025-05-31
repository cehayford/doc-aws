import re

# Raw sequence from the file (as a string)
with open('proinsulin/proinsulin-seq.txt', 'r') as f:
    raw_seq = f.read()

# Remove unwanted parts: ORIGIN, numbers, slashes, spaces, newlines
clean_seq = re.sub(r'ORIGIN|//|\d+|\s+', '', raw_seq).lower()

comma_seq = raw_seq.replace(' ', ',')

# Save the full clean sequence
with open('proinsulin/preproinsulin-seq-clean.txt', 'w') as f:
    f.write(comma_seq)

# Save lsinsulin (1-24)
with open('proinsulin/lsinsulin-seq-clean.txt', 'w') as f:
    f.write(clean_seq[0:24])

# Save binsulin (25-54)
with open('proinsulin/binsulin-seq-clean.txt', 'w') as f:
    f.write(clean_seq[24:54])

# Save cinsulin (55-89)
with open('proinsulin/cinsulin-seq-clean.txt', 'w') as f:
    f.write(clean_seq[54:89])

# Save ainsulin (90-110)
with open('proinsulin/ainsulin-seq-clean.txt', 'w') as f:
    f.write(clean_seq[89:110])

# Print lengths for verification
print('preproinsulin-seq-clean.txt:', len(clean_seq))
print('lsinsulin-seq-clean.txt:', len(clean_seq[0:24]))
print('binsulin-seq-clean.txt:', len(clean_seq[24:54]))
print('cinsulin-seq-clean.txt:', len(clean_seq[54:89]))
print('ainsulin-seq-clean.txt:', len(clean_seq[89:110]))


