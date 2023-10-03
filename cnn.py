#!/usr/bin/python3
import os
import sys
from imagededup.methods import CNN

if len(sys.argv[1]) < 2:
	exit(1)

folder_name = sys.argv[1]

cnn = CNN()
encodings = cnn.encode_images(image_dir=folder_name)
duplicates = cnn.find_duplicates(encoding_map=encodings)

dedup_folder = f"{folder_name}_dedup"

os.system(f"mkdir -p {dedup_folder}")

os.system(f"chmod 777 {dedup_folder}")

fname_split = folder_name.rstrip('/').split('/')[-1]

i = 0
while os.path.isdir(f"{dedup_folder}/{fname_split}_{str(i)}"):
	i += 1

os.system(f"cp -pr {folder_name} {dedup_folder}/{fname_split}_{str(i)}")

os.system(f"chmod -R 777 {dedup_folder}/{fname_split}_{str(i)}")

print("Images copied")

for key in duplicates:
	for dup in duplicates[key]:
		filename = f"{dedup_folder}/{fname_split}_{str(i)}/{dup}"
		
		if not os.path.isfile(filename):
			continue

		os.system(f"rm {filename} 2>/dev/null")

print("Done")

exit(0)