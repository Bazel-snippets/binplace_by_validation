# load("lib_with_binplace.bzl", "lib_with_binplace")

# lib_with_binplace(name = "lib_a")

# lib_with_binplace(name = "lib_b", deps = ["lib_a"])

# lib_with_binplace(name = "lib_c", deps = ["lib_b"])

load("mock_process.bzl", "mock_process")

mock_process(name = "process_a", target_to_process = "lib_a.cpp")

mock_process(name = "process_b", target_to_process = "process_a")
