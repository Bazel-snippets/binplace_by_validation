# buildifier: disable=module-docstring
def _impl(ctx):
    files_to_process = ctx.files.target_to_process
    processd_files = []
    binplaced_files = []
    for src_file in files_to_process:
        dst_file = ctx.actions.declare_file("process/" + ctx.label.name)
        ctx.actions.run_shell(
            outputs = [dst_file],
            inputs = depset([src_file]),
            command = 'cp -f \"$1\" \"$2\"',
            arguments = [src_file.path, dst_file.path],
            mnemonic = "MockProcess",
            progress_message = "Mock processing %s" % src_file,
            use_default_shell_env = False,
        )
        processd_files.append(dst_file)

        binplaced_file = ctx.actions.declare_file("binplace/" + dst_file.basename)
        ctx.actions.run_shell(
            outputs = [binplaced_file],
            inputs = depset([dst_file]),
            command = 'cp -f \"$1\" \"$2\"',
            arguments = [dst_file.path, binplaced_file.path],
            mnemonic = "MockBinplace",
            progress_message = "Mock binplacing %s" % dst_file,
            use_default_shell_env = False,
        )
        binplaced_files.append(binplaced_file)

    return [
        DefaultInfo(files = depset(processd_files)),
        OutputGroupInfo(_validation = depset(binplaced_files)),
    ]

mock_process = rule(
    implementation = _impl,
    attrs = {
        "target_to_process": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
    },
)
