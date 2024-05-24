# Use semicolon as the delimiter for reading fields
cat packages.csv | while IFS=';' read -r NAME VERSION URL MD5SUM; do
  URL=$(echo "$URL" | sed "s/@/$VERSION/g")
  CACHEFILE=$(basename "$URL")

  if [ ! -f "$CACHEFILE" ]; then
    echo "Downloading $URL..."
    wget "$URL"
    if ! echo "$MD5SUM $CACHEFILE" | md5sum -c >/dev/null; then
      rm -f "$CACHEFILE"
      echo "MD5SUM mismatch. Exiting..."
    #   exit 1
    fi
  fi

done
