- copy all files over as symlinks
ln -s ../../*/*/*.md ./

- strip colons
rename 's|:||g' *

- strip .md extension
for FILENAME in *.md; do mv "$FILENAME" "${FILENAME%.md}"; done

- replace . with -
rename 'y/./-/' *

- replace  with -
rename 'y/ /-' *

add .md back again
for f in *; do mv "$f" "$f.md"; done


