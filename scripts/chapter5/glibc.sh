# case $(uname -m) in
# i?86)
# ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
# ;;
# x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
# ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
# ;;
# esac

# mkdir -v build
# cd build

# ../configure \
# --prefix=/usr\
# --host=$LFS_TGT \
# --build=$(../scripts/config.guess) \
# --enable-kernel=4.19 \
# --with-headers=$LFS/usr/include \
# --disable-nscd \
# libc_cv_slibdir=/usr/lib \
# && make \
# && make DESTDIR=$LFS install

# sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
# echo 'int main(){}' | $LFS_TGT-gcc -xc -
# readelf -l a.out | grep ld-linux || exit 1
# rm -v a.out

case $(uname -m) in
i?86)
  ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
  ;;
x86_64)
  ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
  ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
  ;;
esac

patch -Np1 -i ../glibc-2.39-fhs-1.patch

mkdir -v build
cd build

../configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(../scripts/config.guess) \
  --enable-kernel=4.19 \
  --with-headers=$LFS/usr/include \
  --disable-nscd \
  libc_cv_slibdir=/usr/lib \
&& make \
&& make DESTDIR=$LFS install


# Test compilation
echo 'int main(){}' | $LFS_TGT-gcc -xc -
readelf -l a.out | grep ld-linux || exit 1

# Clean up
rm -v a.out
$LFS/tools/libexec/gcc/$LFS_TGT/10.2.0/install-tools/mkheaders
