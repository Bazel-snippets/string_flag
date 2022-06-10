# buildifier: disable=module-docstring
load("@bazel_skylib//rules:common_settings.bzl", "BuildSettingInfo")

def _string_list_impl(ctx):
    given_string_list = ctx.build_setting_value
    return BuildSettingInfo(value = given_string_list)

string_list_flag = rule(
    implementation = _string_list_impl,
    build_setting = config.string_list(flag = True),
)


def _multistring_impl(ctx):
    given_multistring = ctx.build_setting_value
    return BuildSettingInfo(value = given_multistring)

multistring_flag = rule(
    implementation = _multistring_impl,
    build_setting = config.string(flag = True, allow_multiple = True),
)
