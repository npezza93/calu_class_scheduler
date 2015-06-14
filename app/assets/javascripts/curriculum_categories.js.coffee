# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "5"

    if $("#categories-notice").find('paper-toast').length > 0
      document.getElementById('categories-notice-toast').toggle()

    $("#new_category_material").click ->
      document.location.href = '/curriculum_categories/new'
      return

    $("#cancel_new_category").click ->
      window.history.back()
      return

    $("#create-category").click ->
      $("#new_curriculum_category").submit()
      return

    $('#major_paper_radio').on 'change', ->
      $('#curriculum_category_minor_true').prop 'checked', false
      $('#curriculum_category_minor_false').prop 'checked', true
      return
      
    $('#minor_paper_radio').on 'change', ->
      $('#curriculum_category_minor_false').prop 'checked', false
      $('#curriculum_category_minor_true').prop 'checked', true
      return

    $('#set_logic_and_paper_radio').on 'change', ->
      $('#curriculum_category_set_and_or_flag_true').prop 'checked', false
      $('#curriculum_category_set_and_or_flag_false').prop 'checked', true
      $('#curriculum_category_set_and_or_flag_0').prop 'checked', false
      return
      
    $('#set_logic_or_paper_radio').on 'change', ->
      $('#curriculum_category_set_and_or_flag_false').prop 'checked', false
      $('#curriculum_category_set_and_or_flag_true').prop 'checked', true
      $('#curriculum_category_set_and_or_flag_0').prop 'checked', false
      return

    $('#set_logic_na_paper_radio').on 'change', ->
      $('#curriculum_category_set_and_or_flag_false').prop 'checked', false
      $('#curriculum_category_set_and_or_flag_true').prop 'checked', false
      $('#curriculum_category_set_and_or_flag_0').prop 'checked', true
      return

    $("#update-category").click ->
      $(".edit_curriculum_category").submit()
      return

    $("#continue-form-category").on 'change', ->
      if $("#continue-form-category")[0].checked
        $("#continue").prop 'checked', true
        $("#create-category").html($("#create-category").html().split("Submit").join("Next"))
      else
        $("#continue").prop 'checked', false
        $("#create-category").html($("#create-category").html().split("Next").join("Submit"))
      return