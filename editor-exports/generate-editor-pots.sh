#!/bin/sh
set -e
mkdir -p work
for FILE in commands-online commands-offline uiStrings-online uiStrings-offline; do
	sed '/^$/d;G' ${FILE}.txt > work/${FILE}.txt
	(cd work && txt2po --pot -i ${FILE}.txt -o ${FILE}.pot)
done
msgcat work/commands-online.pot work/commands-offline.pot -o ../blocks/templates/blocks.pot
msgcat work/uiStrings-online.pot work/uiStrings-offline.pot -o ../editor/templates/editor.pot
msgfmt --check-format --check-domain ../blocks/templates/blocks.pot -o /dev/null
msgfmt --check-format --check-domain ../editor/templates/editor.pot -o /dev/null
