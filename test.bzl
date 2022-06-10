# buildifier: disable=module-docstring
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def _dummy_rule_impl(_):
    return []

dummy_rule = rule(
    implementation = _dummy_rule_impl,
)

def _test_transition_impl(settings, attr):
    string_list_flag = settings["//:string_list_flag"]
    print("transition: string_list_flag = %s (%s)" % (string_list_flag, type(string_list_flag)))

    multistring_flag = settings["//:multistring_flag"]
    print("transition: multistring_flag = %s (%s)" % (multistring_flag, type(multistring_flag)))

    configurations = []
    return configurations

test_transition = transition(
    implementation = _test_transition_impl,
    inputs = [
        "//:string_list_flag",
        "//:multistring_flag",
    ],
    outputs = [
    ],
)

def _test_rule_impl(ctx):
    print("_test_rule_impl: ctx.attr._string_list_flag = %s" % ctx.attr._string_list_flag[BuildSettingInfo].value)
    print("_test_rule_impl: ctx.attr._multistring = %s" % ctx.attr._multistring_flag[BuildSettingInfo].value)

    depsets = []
    for dep in ctx.attr.deps:
        depsets.append(dep.files)
    return DefaultInfo(files = depset(transitive = depsets))

test_rule = rule(
    implementation = _test_rule_impl,
    attrs = {
        "deps": attr.label(cfg = test_transition),
        "_string_list_flag": attr.label(default = "string_list_flag"),
        "_multistring_flag": attr.label(default = "multistring_flag"),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)
