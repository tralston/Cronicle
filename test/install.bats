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
