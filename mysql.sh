build_mysql() {
  git_sub
  rm -rf bld
  mkdir bld
  cd bld
  cmake .. ${@:--DDOWNLOAD_BOOST=1 -DWITH_BOOST=$DEV_PATH/boost -DCMAKE_BUILD_TYPE=Debug}
  makej 
  cd ..
}

