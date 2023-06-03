# buildifier: disable=module-docstring
def _binplace_aspect_impl(target, ctx):
    rule = ctx.rule
    print("\n\ttarget = %s\n\trule.kind = %s" % (target, rule.kind))

    # Analyse aspect target - what currently visited node contributes.
    target_first_output_file = target.files.to_list()[0]
    binplace_output = ctx.actions.declare_file(target_first_output_file.basename + ".binplace")

    ctx.actions.run_shell(
        outputs = [binplace_output],
        inputs = depset([target_first_output_file]),
        command = 'cp -f \"$1\" \"$2\"',
        arguments = [target_first_output_file.path, binplace_output.path],
        mnemonic = "MockBinplace",
        progress_message = "Mock binplacing %s" % target_first_output_file,
        use_default_shell_env = False,
    )

    binplace_outputs_in_deps = []
    for dep in ctx.rule.attr.deps:
        binplace_outputs_in_deps.append(dep[OutputGroupInfo].binplace)

    return [
        OutputGroupInfo(binplace = depset([binplace_output], transitive = binplace_outputs_in_deps)),
    ]

binplace_aspect = aspect(
    implementation = _binplace_aspect_impl,
    attr_aspects = ['deps'],
)