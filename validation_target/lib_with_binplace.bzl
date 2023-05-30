# buildifier: disable=module-docstring
load("@rules_cc//cc:defs.bzl", "cc_library")
load("mock_binplace.bzl", "mock_binplace")
def lib_with_binplace(name, deps = []):
    cc_library(
        name = name,
        deps = deps,
        srcs = [name + ".cpp"],
    )

    mock_binplace(
        name = name + "_binplace",
        target_to_binplace = name,
    )