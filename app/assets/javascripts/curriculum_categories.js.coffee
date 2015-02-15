# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#new_category_material").click ->
        $("#new_cc_overlay")[0].toggle()
        return

    $("#material_create_category").click ->
      $("#actual_create_category")[0].click()
      return

    $('#major_paper_radio').on 'change', ->
      $('#curriculum_category_minor_true').prop 'checked', false
      $('#curriculum_category_minor_false').prop 'checked', true
      return
      
    $('#minor_paper_radio').on 'change', ->
      $('#curriculum_category_minor_false').prop 'checked', false
      $('#curriculum_category_minor_true').prop 'checked', true
      return
        
    $(document).ready ->
      table = $("#table")
      
      # Table bordered
      $("#table-bordered").change ->
        value = $(this).val()
        table.removeClass("table-bordered").addClass value
        return
    
      
      # Table striped
      $("#table-striped").change ->
        value = $(this).val()
        table.removeClass("table-striped").addClass value
        return
    
      
      # Table hover
      $("#table-hover").change ->
        value = $(this).val()
        table.removeClass("table-hover").addClass value
        return
    
      
      # Table color
      $("#table-color").change ->
        value = $(this).val()
        table.removeClass(/^table-mc-/).addClass value
        return
    
      return
    
    
    # jQuery’s hasClass and removeClass on steroids
    # by Nikita Vasilyev
    # https://github.com/NV/jquery-regexp-classes
    ((removeClass) ->
      jQuery.fn.removeClass = (value) ->
        if value and typeof value.test is "function"
          i = 0
          l = @length
    
          while i < l
            elem = this[i]
            if elem.nodeType is 1 and elem.className
              classNames = elem.className.split(/\s+/)
              n = classNames.length
    
              while n--
                classNames.splice n, 1  if value.test(classNames[n])
              elem.className = jQuery.trim(classNames.join(" "))
            i++
        else
          removeClass.call this, value
        this
    
      return
    ) jQuery.fn.removeClass
