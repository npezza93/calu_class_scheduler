jQuery ->

#
# Set the initial selected drawer item
#
    $(document).ready ->
      if $("#placement_test_overlay").length
        $("#placement_test_overlay")[0].toggle()
      return


#
# placement test handlers
# #
#     $("#pt_yes_no").on 'change', ->
#       if $("#pt_yes_no")[0].selected == "yes"
#         $('#pt_scrollable').slideUp()
#       else
#         $('#pt_scrollable').slideDown()
#       $("#user_pt_a_1")[0].checked = true
#       $("#user_pt_b_1")[0].checked = true
#       $("#user_pt_c_1")[0].checked = true
#       $("#user_pt_d_1")[0].checked = true
#       return
#
#     $("#pt_a_group").on 'change', (e) ->
#       if e.originalEvent.target.getAttribute("name") == "passed"
#         $("#user_pt_a_1")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "failed"
#         $("#user_pt_a_2")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "na"
#         $("#user_pt_a")[0].checked = true
#       return
#
#     $("#pt_b_group").on 'change', (e) ->
#       if e.originalEvent.target.getAttribute("name") == "passed"
#         $("#user_pt_b_1")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "failed"
#         $("#user_pt_b_2")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "na"
#         $("#user_pt_b")[0].checked = true
#       return
#
#     $("#pt_c_group").on 'change', (e) ->
#       if e.originalEvent.target.getAttribute("name") == "passed"
#         $("#user_pt_c_1")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "failed"
#         $("#user_pt_c_2")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "na"
#         $("#user_pt_c")[0].checked = true
#       return
#
#     $("#pt_d_group").on 'change', (e) ->
#       if e.originalEvent.target.getAttribute("name") == "passed79"
#         $("#user_pt_d_1")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "failed"
#         $("#user_pt_d_2")[0].checked = true
#       else if e.originalEvent.target.getAttribute("name") == "na"
#         $("#user_pt_d")[0].checked = true
#       if e.originalEvent.target.getAttribute("name") == "passed10"
#         $("#user_pt_d_3")[0].checked = true
#       return
#
#     $("#submit-pt").click ->
#       $(".pt_form").submit()
#       $("#placement_test_overlay")[0].toggle()
#       return
#
# #
# # student settings overlay handlers
# #
#     $("#drawer_change_password_item_baluga").click ->
#       $("#change_password_overlay")[0].toggle()
#       return
#
#     $("#change_password_overlay").on "iron-overlay-closed", (e) ->
#       $("#drawer-menu")[0].selected = $("#baluga3")[0].selected
#       $("#new_user_password").removeAttr('invalid', "")
#       $("#new_user_password_confirm").removeAttr('invalid', "")
#       $("#user_password").val("");
#       $("#user_password_confirmation").val("");
#       return
#
#     $("#submit_student_settings").click ->
#       $(".student_settings_form").submit()
#       return
