#!/usr/bin/env bash

echo 'Cleaning out test directory'
rm -rv ./test 2> /dev/null

echo
echo "Re-creating test directory"
mkdir -pv ./test/sub1 ./test/sub1/sub1-1 ./test/sub2
echo 'file-1-1' > ./test/sub1/file1-1
echo 'file-1-2' > ./test/sub1/file1-2
echo 'file-1-1-1' > ./test/sub1/sub1-1/file1-1-1
echo 'file-2-1' > ./test/sub2/file2-1

echo
echo 'Building application'
nimble build

echo
echo 'Running application on test directory'
./bin/mv-ed test/**/*