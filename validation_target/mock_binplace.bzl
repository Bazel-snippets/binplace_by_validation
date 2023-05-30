# buildifier: disable=module-docstring
def _impl(ctx):
    files_to_binplace = ctx.files.target_to_binplace
    binplaced_files = []
    for src_file in files_to_binplace:
        binplaced_file = ctx.actions.declare_file("binplace/" + src_file.basename)
        ctx.actions.run_shell(
            outputs = [binplaced_file],
            inputs = depset([src_file]),
            command = 'cp -f \"$1\" \"$2\"',
            arguments = [src_file.path, binplaced_file.path],
            mnemonic = "MockBinplace",
            progress_message = "Mock binplacing %s" % src_file,
            use_default_shell_env = False,
        )
        binplaced_files.append(binplaced_file)

    return [
        OutputGroupInfo(_validation = depset(binplaced_files)),
    ]

mock_binplace = rule(
    implementation = _impl,
    attrs = {
        "target_to_binplace": attr.label(
            mandatory = True,
        ),
    },
)
