CHAPTER="$1"
PACKAGE="$2"

cat packages.csv | grep -i "^$PACKAGE;" | grep -i -v "\.patch;"| while IFS=';' read -r NAME VERSION URL MD5SUM; do
  URL=$(echo "$URL" | sed "s/@/$VERSION/g")
  CACHEFILE=$(basename "$URL")
  DIRNAME=$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')

    mkdir -pv "$DIRNAME"
    echo "Extracting $CACHEFILE..."
    tar -xf "$CACHEFILE" -C "$DIRNAME" 

    pushd "$DIRNAME"
        
        if [ "$(ls -1A | wc -l)" == "1" ]; then
          mv $(ls -1A)/* ./
        fi

        echo "Configuring $PACkAGE..."
        sleep 5

        mkdir -pv "../log/chapter$CHAPTER"


        if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER-$PACKAGE.log"; then 
            echo "Error Compiling $PACKAGE"
            popd
            exit 1
        fi
        echo "Done Compiling $PACKAGE"
    popd
done

