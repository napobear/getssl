#! /usr/bin/env bats

load '/bats-support/load.bash'
load '/bats-assert/load.bash'
load '/getssl/test/test_helper.bash'




setup() {
    [ ! -f $BATS_TMPDIR/failed.skip ] || skip "skipping tests after first failure"
}
teardown() {
    [ -n "$BATS_TEST_COMPLETED" ] || touch $BATS_TMPDIR/failed.skip
}

@test "Create new certificate using staging server and prime256v1" {
    if [ -z "$STAGING" ]; then
        skip "Running external tests, skipping internal testing"
    fi
    CONFIG_FILE="getssl-dns01.cfg"

    setup_environment
    init_getssl
    sed -e 's/rsa/prime256v1/g' < "${CODE_DIR}/test/test-config/${CONFIG_FILE}" > "${INSTALL_DIR}/.getssl/${GETSSL_HOST}/getssl.cfg"
    run ${CODE_DIR}/getssl -d "$GETSSL_HOST"
    assert_success
    check_output_for_errors "debug"
}


setup() {
    [ ! -f $BATS_TMPDIR/failed.skip ] || skip "skipping tests after first failure"
}
teardown() {
    [ -n "$BATS_TEST_COMPLETED" ] || touch $BATS_TMPDIR/failed.skip
}

@test "Force renewal of certificate using staging server and prime256v1" {
    if [ -z "$STAGING" ]; then
        skip "Running internal tests, skipping external test"
    fi
    run ${CODE_DIR}/getssl -d -f $GETSSL_HOST
    assert_success
    check_output_for_errors "debug"
    cleanup_environment
}


setup() {
    [ ! -f $BATS_TMPDIR/failed.skip ] || skip "skipping tests after first failure"
}
teardown() {
    [ -n "$BATS_TEST_COMPLETED" ] || touch $BATS_TMPDIR/failed.skip
}

@test "Create new certificate using staging server and secp384r1" {
    if [ -z "$STAGING" ]; then
        skip "Running external tests, skipping internal testing"
    fi
    CONFIG_FILE="getssl-dns01.cfg"

    setup_environment
    init_getssl
    sed -e 's/rsa/secp384r1/g' < "${CODE_DIR}/test/test-config/${CONFIG_FILE}" > "${INSTALL_DIR}/.getssl/${GETSSL_HOST}/getssl.cfg"
    run ${CODE_DIR}/getssl -d "$GETSSL_HOST"
    assert_success
    check_output_for_errors "debug"
}


setup() {
    [ ! -f $BATS_TMPDIR/failed.skip ] || skip "skipping tests after first failure"
}
teardown() {
    [ -n "$BATS_TEST_COMPLETED" ] || touch $BATS_TMPDIR/failed.skip
}

@test "Force renewal of certificate using staging server and secp384r1" {
    if [ -z "$STAGING" ]; then
        skip "Running internal tests, skipping external test"
    fi
    run ${CODE_DIR}/getssl -d -f $GETSSL_HOST
    assert_success
    check_output_for_errors "debug"
    cleanup_environment
}


# Note letsencrypt doesn't support ECDSA curve P-521 as it's being deprecated
