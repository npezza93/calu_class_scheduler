# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  
    $("#drawer_core_menu")[0].setAttribute "selected", "1"
    
    $('#transcript_ajax').on 'core-response', (e) ->
      $('#section0').append e.originalEvent.detail.response
      return

    $('#new_schedule_ajax').on 'core-response', (e) ->
      $('#temp_replace').append e.originalEvent.detail.response
      front_validation2()
      $("#schedule_bootup")[0].toggle()
      if $("#placement_test_overlay")
        $("#placement_test_overlay")[0].toggle()
      return

    $("#fab_new_schedule").click ->
        $("#new_schedule_modal")[0].toggle()
        return
 
    $('#upload_transcript_button').click ->
      if $('#Transcript').val() != ''
        $('#upload_transcript_link').click()
        $('#new_schedule_modal')[0].toggle()
        $('#whole_screen_uploader').fadeIn()
      return

    $("#pt_yes_no").on 'core-activate', (e, detail) ->
      $('#pt_collapse')[0].toggle()
      return
    
    $("#pt_a_group").on 'core-activate', (e, detail) ->
      if $("#pt_a_group")[0].selected == "passed"
        $("#user_pt_a_1")[0].checked = true
      else if $("#pt_a_group")[0].selected == "failed"
        $("#user_pt_a_2")[0].checked = true
      else if $("#pt_a_group")[0].selected == "na"      
        $("#user_pt_a")[0].checked = true
      return

    $("#pt_b_group").on 'core-activate', (e, detail) ->
      if $("#pt_b_group")[0].selected == "passed"
        $("#user_pt_b_1")[0].checked = true
      else if $("#pt_b_group")[0].selected == "failed"
        $("#user_pt_b_2")[0].checked = true
      else if $("#pt_b_group")[0].selected == "na"      
        $("#user_pt_b")[0].checked = true
      return

    $("#pt_c_group").on 'core-activate', (e, detail) ->
      if $("#pt_c_group")[0].selected == "passed"
        $("#user_pt_c_1")[0].checked = true
      else if $("#pt_c_group")[0].selected == "failed"
        $("#user_pt_c_2")[0].checked = true
      else if $("#pt_c_group")[0].selected == "na"      
        $("#user_pt_c")[0].checked = true
      return

    $("#pt_d_group").on 'core-activate', (e, detail) ->
      if $("#pt_d_group")[0].selected == "passed"
        $("#user_pt_d_1")[0].checked = true
      else if $("#pt_d_group")[0].selected == "failed"
        $("#user_pt_d_2")[0].checked = true
      else if $("#pt_d_group")[0].selected == "na"      
        $("#user_pt_d")[0].checked = true
      return

    $("#paper_submit_pt").click ->
      if $("#pt_yes_no")[0].selected == "yes"
        $("#submit_pts").click()
      else
        $("#user_pt_a")[0].checked = true
        $("#user_pt_b")[0].checked = true
        $("#user_pt_c")[0].checked = true
        $("#user_pt_d")[0].checked = true
        $("#submit_pts").click()
      $("#placement_test_overlay")[0].toggle()
      return
      
    $("#media_query_schedule").on "core-media-change", (e) ->
      if e.originalEvent.detail.matches is true
        $("#big_schedule_table")[0].setAttribute "hidden", ""
        $("#small_schedule_table")[0].removeAttribute "hidden", ""
        $(".small_schedule_course_title").removeAttr "hidden", ""
      else
        $("#big_schedule_table")[0].removeAttribute "hidden", ""
        $("#small_schedule_table")[0].setAttribute "hidden", ""
        $(".small_schedule_course_title").attr "hidden", ""
      return

    $("#drawer_transcripts_item_baluga").click ->
      $("#baluga3")[0].selected = 0
      $("core-drawer-panel")[0].closeDrawer();
      return
    
    $("#drawer_schedule_item_baluga").click ->
      $("#baluga3")[0].selected = 1
      $("core-drawer-panel")[0].closeDrawer();
      return
    
    $("#drawer_new_schedule_item_baluga").click ->
      $("#baluga3")[0].selected = 2
      $("core-drawer-panel")[0].closeDrawer();
      return

    $("#drawer_choose_minor_item_baluga").click ->
      $("#choose_minor_overlay")[0].toggle()
      return
      
    $("#drawer_change_password_item_baluga").click ->
      $("#change_password_overlay")[0].toggle()
      return     

    $("#drawer_transcripts_item").click ->
      $("#user_transcripts_app_link")[0].click()
      return
    
    $("#drawer_schedule_item").click ->
      $("#user_schedules_app_link")[0].click()
      return
    
    $("#drawer_new_schedule_item").click ->
      $("#new_user_schedule_app_link")[0].click()
      return
    
    
    $("#drawer_logout_item").click ->
      $("#logout_button")[0].click()
      return
    
    $("#drawer_change_password_item").click ->
      $("#change_password_link")[0].click()
      return
    
    $("#drawer_new_major_item").click ->
      $("#new_major_link")[0].click()
      return

    $("#drawer_semesters_item").click ->
      $("#semesters_link")[0].click()
      return
      
    $("#drawer_offerings_item").click ->
      $("#offerings_link")[0].click()
      return
    
    $("#drawer_course_item").click ->
      $("#delete_course_link")[0].click()
      return

    $("#drawer_needed_course_item").click ->
      $("#needed_course_link")[0].click()
      return
    
    $("#drawer_users_item").click ->
      $("#users_link")[0].click()
      return
    
    $("#drawer_categories_item").click ->
      $("#categories_link")[0].click()
      return
      
    $("#change_password_overlay").on "core-overlay-close-completed", (e) ->
      $("#drawer_core_menu")[0].selected= ($("#baluga3")[0].selected)
      $("#user_password").parent().attr "error", ""
      $("#user_password").parent().attr "isInvalid", "false"
      $("#user_password_confirmation").parent().attr "error", ""
      $("#user_password_confirmation").parent().attr "isInvalid", "false"
      $("#user_password").val("");
      $("#user_password_confirmation").val("");
      $("#user_password").parent()[0].updateLabelVisibility();
      $("#user_password_confirmation").parent()[0].updateLabelVisibility();
      return
      
    $("#upload_transcript_button").click ->
      $("#upload_transcript_link")[0].click()
      return
    
    $('.next_day').click ->
      page = $('#baluga4')[0].selected
      if page < 4
        $('#baluga4')[0].selected = $('#baluga4')[0].selected + 1
      return
    $('.prev_day').click ->
      page = $('#baluga4')[0].selected
      if page > 0
        $('#baluga4')[0].selected = $('#baluga4')[0].selected - 1
      return
#work schedules
    $('.day_time_slot').click (e) ->
      if $("#drawer_core_menu").children().length <11
        if $('.' + e.originalEvent.toElement.className.split(' ')[1]).text() == "" and !$('.' + e.originalEvent.toElement.className.split(' ')[1]).hasClass("half_time_slot")
          $('.' + e.originalEvent.toElement.className.split(' ')[1]).toggleClass 'selected_work_day_time_slot'
          id_string = '#work_schedule_work_days_time_id option[value=' + e.originalEvent.toElement.id.substring(1) + ']'
          if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
          else
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
          $("#submit_work_schedule_button")[0].click()
      return
      
    $('.time_slot').click (e) ->
      if $("#drawer_core_menu").children().length <11
        time_string = $.trim(e.toElement.innerHTML.replace(/:/g, ''))
        
        if $('.M' + time_string).text() == "" and !$('.M' + time_string).hasClass("half_time_slot")
          $('.M' + time_string).toggleClass 'selected_work_day_time_slot'
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.M' + time_string)[0].id.substring(1) + ']'
          if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
          else
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
        
        if $('.T' + time_string).text() == "" and !$('.T' + time_string).hasClass("half_time_slot")
          $('.T' + time_string).toggleClass 'selected_work_day_time_slot'
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.T' + time_string)[0].id.substring(1) + ']'
          if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
          else
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
        
        if $('.W' + time_string).text() == "" and !$('.W' + time_string).hasClass("half_time_slot")
          $('.W' + $.trim(e.toElement.innerHTML.replace(/:/g, ''))).toggleClass 'selected_work_day_time_slot'
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.W' + time_string)[0].id.substring(1) + ']'
          if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
          else
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
          
        if $('.R' + time_string).text() == "" and !$('.R' + time_string).hasClass("half_time_slot")
          $('.R' + $.trim(e.toElement.innerHTML.replace(/:/g, ''))).toggleClass 'selected_work_day_time_slot'
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.R' + time_string)[0].id.substring(1) + ']'
          if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
          else
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
          
        if $('.F' + time_string).text() == ""  and !$('.F' + time_string).hasClass("half_time_slot")
          $('.F' + $.trim(e.toElement.innerHTML.replace(/:/g, ''))).toggleClass 'selected_work_day_time_slot'
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.F' + time_string)[0].id.substring(1) + ']'
          if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
          else
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
        $("#submit_work_schedule_button")[0].click()
      return
    
    $('.day').click (e) ->
      if $("#drawer_core_menu").children().length <11
        begin_time = new Date(2000, 1, 1, 8)
        end_time = new Date(2000, 1, 1, 21, 30)
        while begin_time.getTime() <= end_time.getTime()
          if e.toElement.innerHTML != 'Thursday'
            if $('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).text() == '' and !$('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).hasClass("half_time_slot")
              $('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).toggleClass 'selected_work_day_time_slot'
              id_string = '#work_schedule_work_days_time_id option[value=' + $('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt'))[0].id.substring(1) + ']'
              if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
              else
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
          else
            if $('.R' + begin_time.toString('hmmtt')).text() == '' and !$('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).hasClass("half_time_slot")
              $('.R' + begin_time.toString('hmmtt')).toggleClass 'selected_work_day_time_slot'
              id_string = '#work_schedule_work_days_time_id option[value=' + $('.R' + begin_time.toString('hmmtt'))[0].id.substring(1) + ']'
              if $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false
              else
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true
          begin_time.setMinutes begin_time.getMinutes() + 30
        $("#submit_work_schedule_button")[0].click()
      return
      
#schedule approvals
    $("#submit_approval_paper_button").click ->
      console.log("email sent")
      $("#submit_approval_button")[0].click()
      return
      
    $("#advisor_approve_schedule_button").click ->
      $("#advisor_approve_schedule_link")[0].click()
      return      
     
    $(document).keydown (e) ->
      pg_selected = $('#baluga3')[0].selected
      switch e.which
        when 37
          # left
          if pg_selected != 0
            $('#baluga3')[0].selected = pg_selected - 1
            $('#drawer_core_menu')[0].setAttribute 'selected', parseInt($('#drawer_core_menu')[0].selected) - 1
        when 39
          # right
          if pg_selected != 2
            $('#baluga3')[0].selected = pg_selected + 1
            $('#drawer_core_menu')[0].setAttribute 'selected', parseInt($('#drawer_core_menu')[0].selected) + 1
        else
          return
        # exit this handler for other keys
      e.preventDefault()
      # prevent the default action (scroll / move caret)
      return
      
    front_validation2 = ->
      asel_opts = undefined
      credit_count = undefined
      disable = undefined
      nsel_dates_array = undefined
      nsel_opts = undefined
      sel_dates_array = undefined
      sel_opts = undefined
      sel_opts = []
      nsel_opts = []
      asel_opts = []
      credit_count = 0
      sel_dates_array = []
      nsel_dates_array = []
      disable = []
      $('#schedule_new_actual_select option:selected').each ->
        sel_opts.push $(this).attr('value')
        asel_opts.push $(this).attr('value')
        return
        
      $('#schedule_new_actual_select option:not(:selected)').each ->
        nsel_opts.push $(this).attr('value')
        asel_opts.push $(this).attr('value')
        return
        
      $.each sel_opts, (index, value) ->
        d = undefined
        t = undefined
        t = $('#' + value).parent().parent()
        credit_count += parseInt(t.find('.new_schedule_credit_td').text())
        if !(t.find('.new_schedule_days_td').text() == "ONLINE" || t.find('.new_schedule_days_td').text() == "OFFSITE") 
          d = [
            t.find('.new_schedule_days_td').text()
            Date.parse(t.find('.new_schedule_times_td').text().split(' - ')[0])
            Date.parse(t.find('.new_schedule_times_td').text().split(' - ')[1])
            t.find('.new_schedule_course_td').text().split('-')[0]
          ]
        else
          d = [ t.find('.new_schedule_days_td').text(),-1,-1,t.find('.new_schedule_course_td').text().split('-')[0]]          
        sel_dates_array.push d
        return
        
      $.each nsel_opts, (index, value) ->
        d = undefined
        t = undefined
        t = $('#' + value).parent().parent()
        if credit_count + parseInt(t.find('.new_schedule_credit_td').text()) > 18
          disable.push value
        if !(t.find('.new_schedule_days_td').text() == "ONLINE" || t.find('.new_schedule_days_td').text() == "OFFSITE") 
          d = [
            t.find('.new_schedule_days_td').text()
            Date.parse(t.find('.new_schedule_times_td').text().split(' - ')[0])
            Date.parse(t.find('.new_schedule_times_td').text().split(' - ')[1])
            t.find('.new_schedule_course_td').text().split('-')[0]
          ]
        else
          d = [t.find('.new_schedule_days_td').text(), -1,-1,t.find('.new_schedule_course_td').text().split('-')[0]]
        nsel_dates_array.push d
        return
      
      $.each nsel_opts, (index1, value1) ->
        $.each sel_opts, (index2, value2) ->
            if sel_dates_array[index2][0] != "ONLINE" and nsel_dates_array[index2][0] != "ONLINE" and sel_dates_array[index2][0] != "OFFSITE" and nsel_dates_array[index2][0] != "OFFSITE" and sel_dates_array[index2][0].indexOf(nsel_dates_array[index1][0]) != -1
              if sel_dates_array[index2][1] <= nsel_dates_array[index1][2] and nsel_dates_array[index1][1] <= sel_dates_array[index2][2]
                disable.push value1
          
            if sel_dates_array[index2][3] == nsel_dates_array[index1][3]
              disable.push value1
            return
        return
      disable = jQuery.unique(disable)

      asel_opts = $(asel_opts).not(disable).get()
      $.each disable, (index, value) ->
        $('.' + value).attr 'disabled', ''
        return
      $.each asel_opts, (index, value) ->
        $('.' + value).removeAttr 'disabled', ''
        return

      return