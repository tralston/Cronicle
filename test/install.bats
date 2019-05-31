load 'test_helper'

setup() {
  TEST_TEMP_DIR="$(temp_make --prefix 'cronicle-')"
}

teardown() {
  temp_del "$TEST_TEMP_DIR"
}

@test "Displays version and quits" {
  # skip
  run $node bin/install.js --version
  assert_output --regexp '^Cronicle installer version [0-9]+\.[0-9]+$'
  assert_success
}

@test "Changes base directory in response to --basedir argument" {
  # skip
  run $node bin/install.js --basedir=$TEST_TEMP_DIR
  assert_output --partial "Creating base directory: $TEST_TEMP_DIR"
}

@test "Tests if current user has write permissions to basedir" {
  # skip
  mkdir $TEST_TEMP_DIR/nowrite
  chmod -w $TEST_TEMP_DIR/nowrite
  run $node bin/install.js --basedir=$TEST_TEMP_DIR/nowrite/somefolder
  assert_output --partial "Failed to create base directory"
  assert_failure
}

@test "Creates base directory and changes permissions" {
  run $node bin/install.js --basedir=$TEST_TEMP_DIR/somefolder
  assert_dir_exist $TEST_TEMP_DIR/somefolder
  assert_file_permission 775 $TEST_TEMP_DIR/somefolder
}