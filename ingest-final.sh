#!/bin/bash

## ARCHIVAL DATA INGEST SCRIPT - FINAL INGEST & BAGGING
##
## This script should be used when a folder containing data
## from an event, exhibition, or project in the Archive NAS
## is complete and unlikely to have had more data added to it.
##
## If additional forbidden characters/emojis are found to be used,
## adding extra lines to this script is super simple--
## just use the same format as below substituting in that specific character.
##
## The script performs the following actions:
##### 1. Removes any existing color tags from the top level folder.
##### 2. Removes certain temporary/invisible files with no archival significance
##### 3. Changes all forbidden characters to dashes (-)
##### 4. Runs a quick (not exhaustive) virus scan
##### 5. Runs the BagIt program to package the event and write checksums.
##### 6. Tags the top level folder as Green to signify a complete and valid bag.
##
## See additional written documentation in
## WORK IMAGES/_ARCHIVES/_Instructions/_2019-Manual
## for more detailed instructions!
##
## Friendly reminder that I am not a scripting expert;
## this one here is messy but functional!
##
## - written by ft, March-April 2019
## - updated by mr 2022, 2024

read -p "Enter the directory: " dir

tag -r Red,Orange,Yellow,Green,Blue,Purple,Gray "$dir"
find "$dir" -type f \( -iname ".DS_Store" -o -iname "thumbs.db" -o -iname "\~\$*" \) -exec rm -rf {} \;
find "$dir" -name "*:*" -exec rename 's/:/-/g' {} +
find "$dir" -name "*🎆*" -exec rename 's/🎆/-/g' {} +
find "$dir" -name "*👍*" -exec rename 's/👍/-/g' {} +
find "$dir" -name "*🙏*" -exec rename 's/🙏/-/g' {} +
find "$dir" -name "*👌*" -exec rename 's/👌/-/g' {} +
find "$dir" -name "*🛄*" -exec rename 's/🛄/-/g' {} +
find "$dir" -name "*\|*" -exec rename 's/\|/-/g' {} +
find "$dir" -name "*\"*" -exec rename 's/\"/-/g' {} +
find "$dir" -name "*\**" -exec rename 's/\*/-/g' {} +
find "$dir" -name "*\?*" -exec rename 's/\?/-/g' {} +
find "$dir" -name "*\#*" -exec rename 's/\#/-/g' {} +
find "$dir" -name '*\\*' -exec rename 's/\\/-/g' {} +
find "$dir" -name "*~*" -exec rename 's/~/-/g' {} +
find "$dir" -name "*\`*" -exec rename 's/\`/-/g' {} +
find "$dir" -name "*@*" -exec rename 's/@/-/g' {} +
find "$dir" -name "*\$*" -exec rename 's/\$/-/g' {} +
find "$dir" -name "*%*" -exec rename 's/%/-/g' {} +
find "$dir" -name "*\^*" -exec rename 's/\^/-/g' {} +
find "$dir" -name "*&*" -exec rename 's/&/-/g' {} +
find "$dir" -name "*\>*" -exec rename 's/\>/-/g' {} +
find "$dir" -name "*\<*" -exec rename 's/\</-/g' {} +
find "$dir" -name "*:*" -exec rename 's/:/-/g' {} +
find "$dir" -name "*🎆*" -exec rename 's/🎆/-/g' {} +
find "$dir" -name "*👍*" -exec rename 's/👍/-/g' {} +
find "$dir" -name "*🙏*" -exec rename 's/🙏/-/g' {} +
find "$dir" -name "*👌*" -exec rename 's/👌/-/g' {} +
find "$dir" -name "*🛄*" -exec rename 's/🛄/-/g' {} +
find "$dir" -name "*\|*" -exec rename 's/\|/-/g' {} +
find "$dir" -name "*\"*" -exec rename 's/\"/-/g' {} +
find "$dir" -name "*\**" -exec rename 's/\*/-/g' {} +
find "$dir" -name "*\?*" -exec rename 's/\?/-/g' {} +
find "$dir" -name "*\#*" -exec rename 's/\#/-/g' {} +
find "$dir" -name '*\\*' -exec rename 's/\\/-/g' {} +
find "$dir" -name "*~*" -exec rename 's/~/-/g' {} +
find "$dir" -name "*\`*" -exec rename 's/\`/-/g' {} +
find "$dir" -name "*@*" -exec rename 's/@/-/g' {} +
find "$dir" -name "*\$*" -exec rename 's/\$/-/g' {} +
find "$dir" -name "*%*" -exec rename 's/%/-/g' {} +
find "$dir" -name "*\^*" -exec rename 's/\^/-/g' {} +
find "$dir" -name "*&*" -exec rename 's/&/-/g' {} +
find "$dir" -name "*\>*" -exec rename 's/\>/-/g' {} +
find "$dir" -name "*\<*" -exec rename 's/\</-/g' {} +

brunnhilde.py "$dir" "$dir/reports"

bagit.py --md5 --source-organization "Cai Studio" "$dir"
freshclam
clamscan -ir "$dir"
tag -a Green "$dir"
echo "Final ingest and bagging script complete! :)"