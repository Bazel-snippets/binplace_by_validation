1. Validation Target - target performing validation depends on the target producing artifact
Command to run: bazel build validation_target:lib_a -s
Observed: validation target lib_a_binplace is not executed

2. Validation Action - single target has action for artifact and validation action
Command to run: bazel build validation_action:process_b -s
Observed: validation actions are not executed
