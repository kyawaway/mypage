#!/bin/bash
npm run build

echo "Converting absolute paths to relative paths..."

sed -i '' 's|href="/|href="./|g' dist/index.html
sed -i '' 's|src="/|src="./|g' dist/index.html

sed -i '' 's|href="/|href="../|g' dist/publication-list/index.html
sed -i '' 's|src="/|src="../|g' dist/publication-list/index.html

echo "Done!"
