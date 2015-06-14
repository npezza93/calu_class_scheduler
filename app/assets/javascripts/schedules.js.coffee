# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

#
# Set the initial selected drawer item
#
    $(document).ready ->  
      $("#drawer-menu")[0].setAttribute "selected", "1"
      if $("#media_query_schedule")[0].queryMatches
        $("#big_schedule_table")[0].setAttribute "hidden", ""
        $("#small_schedule_table")[0].removeAttribute "hidden", ""
        $(".small_schedule_course_title").removeAttr "hidden", ""
      else
        $("#big_schedule_table")[0].removeAttribute "hidden", ""
        $("#small_schedule_table")[0].setAttribute "hidden", ""
        $(".small_schedule_course_title").attr "hidden", ""
      front_validation2()
      if $("#placement_test_overlay").length
        $("#placement_test_overlay")[0].toggle()
      $(".delete-work-schedule-link").each ->
        $("._" + $(this)[0].classList[0].split("_")[2]).addClass('selected_work_day_time_slot');
        return
      return

#
# Handles the 3 schedules items
#
    $("#drawer_transcripts_item_baluga").click ->
      $("#baluga3").attr("exit-animation","slide-right-animation")
      $("#baluga3").attr("entry-animation","slide-from-left-animation")
      $("#baluga3")[0].selected = 0
      return
    
    $("#drawer_schedule_item_baluga").click ->
      if $("#baluga3")[0].selected == 0
        $("#baluga3").attr("exit-animation","slide-left-animation")
        $("#baluga3").attr("entry-animation","slide-from-right-animation")
      else
        $("#baluga3").attr("exit-animation","slide-right-animation")
        $("#baluga3").attr("entry-animation","slide-from-left-animation")
      $("#baluga3")[0].selected = 1
      return
    
    $("#drawer_new_schedule_item_baluga").click ->
      $("#baluga3").attr("exit-animation","slide-left-animation")
      $("#baluga3").attr("entry-animation","slide-from-right-animation")
      $("#baluga3")[0].selected = 2
      return

#
# used to in new transcript form
#
    $('body').on 'click', '#submit_taken_class_material', ->
      if $("#transcript_grade_c option:selected" ).val() == ""
        $("#transcript_grade_error_text").fadeIn();
        $("#transcript_grade_c").addClass("dropdown-error");        
      else
        $("#transcript_grade_error_text").fadeOut();
        $("#transcript_grade_c").removeClass("dropdown-error");        
        $("#new_transcript").submit()
      return

    $('body').on 'change', '#transcript_course_id', ->
      if $("#transcript_course_id option:selected" ).val() != ""
        $("#transcript_course_id" ).css "color", "#212121"
      else
        $("#transcript_course_id" ).css "color", "#757575"
      return

    $('body').on 'change', '#transcript_grade_c', ->
      if $("#transcript_grade_c option:selected" ).val() != ""
        $("#transcript_grade_c" ).css "color", "#212121"
      else
        $("#transcript_grade_c" ).css "color", "#757575"
      return

#
# upload transcript handlers
#
    $('#upload_transcript_button').click ->
      if $('#Transcript').val() != ''
        $("#new-offering-section").parent().submit()
        $('#new_schedule_modal')[0].toggle()
        $('#whole_screen_uploader').fadeIn()
      return

    $("#fab_new_schedule").click ->
        $("#upload-transcript-dialog")[0].toggle()
        return
 
#
# placement test handlers
#
    $("#pt_yes_no").on 'change', ->
      if $("#pt_yes_no")[0].selected == "yes"
        $('#pt_scrollable').slideUp()
      else 
        $('#pt_scrollable').slideDown()
      $("#user_pt_a_1")[0].checked = true
      $("#user_pt_b_1")[0].checked = true
      $("#user_pt_c_1")[0].checked = true
      $("#user_pt_d_1")[0].checked = true
      return
    
    $("#pt_a_group").on 'change', (e) ->
      if e.originalEvent.target.getAttribute("name") == "passed"
        $("#user_pt_a_1")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "failed"
        $("#user_pt_a_2")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "na"      
        $("#user_pt_a")[0].checked = true
      return

    $("#pt_b_group").on 'change', (e) ->
      if e.originalEvent.target.getAttribute("name") == "passed"
        $("#user_pt_b_1")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "failed"
        $("#user_pt_b_2")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "na"      
        $("#user_pt_b")[0].checked = true
      return

    $("#pt_c_group").on 'change', (e) ->
      if e.originalEvent.target.getAttribute("name") == "passed"
        $("#user_pt_c_1")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "failed"
        $("#user_pt_c_2")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "na"      
        $("#user_pt_c")[0].checked = true
      return

    $("#pt_d_group").on 'change', (e) ->
      if e.originalEvent.target.getAttribute("name") == "passed79"
        $("#user_pt_d_1")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "failed"
        $("#user_pt_d_2")[0].checked = true
      else if e.originalEvent.target.getAttribute("name") == "na"      
        $("#user_pt_d")[0].checked = true
      if e.originalEvent.target.getAttribute("name") == "passed10"
        $("#user_pt_d_3")[0].checked = true
      return

    $("#submit-pt").click ->
      $(".pt_form").submit()
      $("#placement_test_overlay")[0].toggle()
      return
      
#
# student settings overlay handlers
#
    $("#drawer_change_password_item_baluga").click ->
      $("#change_password_overlay")[0].toggle()
      return  

    $("#change_password_overlay").on "iron-overlay-closed", (e) ->
      $("#drawer-menu")[0].selected = $("#baluga3")[0].selected
      $("#new_user_password").removeAttr('invalid', "")
      $("#new_user_password_confirm").removeAttr('invalid', "")
      $("#user_password").val("");
      $("#user_password_confirmation").val("");
      return

    $("#submit_student_settings").click ->
      $(".student_settings_form").submit()
      return      

#
# calendar handlers
#
    $( window ).resize ->
      if $("#media_query_schedule")[0].queryMatches
        $("#big_schedule_table")[0].setAttribute "hidden", ""
        $("#small_schedule_table")[0].removeAttribute "hidden", ""
        $(".small_schedule_course_title").removeAttr "hidden", ""
      else
        $("#big_schedule_table")[0].removeAttribute "hidden", ""
        $("#small_schedule_table")[0].setAttribute "hidden", ""
        $(".small_schedule_course_title").attr "hidden", ""
      return
         
    $('.next_day').click ->
      if parseInt($('#baluga4')[0].selected) < 4
        $("#baluga4").attr("entry-animation", "slide-from-right-animation")
        $("#baluga4").attr("exit-animation", "slide-left-animation")      
        $('#baluga4')[0].selected = parseInt($('#baluga4')[0].selected) + 1
      return


    $('.prev_day').click ->
      if parseInt($('#baluga4')[0].selected) > 0
        $("#baluga4").attr("entry-animation", "slide-from-left-animation")
        $("#baluga4").attr("exit-animation", "slide-right-animation")      
        $('#baluga4')[0].selected = parseInt($('#baluga4')[0].selected) - 1
      return


















#work schedules
    $('.day_time_slot').click (e) ->
      if $("#drawer_core_menu").children().length <11
        if $( this ).text() == "" and !$( this ).hasClass("half_time_slot")
          if !$(this).hasClass('selected_work_day_time_slot')
            $( this ).toggleClass 'selected_work_day_time_slot'            
            $("#work_schedule_work_days_time_id").val $( this )[0].classList[2].split("_")[1]
            $("#new_work_schedule").submit()
          else
            $( this ).toggleClass 'selected_work_day_time_slot'  
            $(".work_schedule" + $(this)[0].classList[2].split()).click()
      return
      
    $('.time_slot').click (e) ->
      if $("#drawer_core_menu").children().length <11
        time_string = $(this).text().replace(/:/g, '')
        $.each ["M","T","W","R","F"], (index, day) ->
          if $('.' + day + time_string).text() == "" and !$('.' + day + time_string).hasClass("half_time_slot")
            if !$('.' + day + time_string).hasClass('selected_work_day_time_slot')
              $('.' + day + time_string).toggleClass 'selected_work_day_time_slot'            
              $("#work_schedule_work_days_time_id").val $('.' + day + time_string)[0].classList[2].split("_")[1]
              $("#new_work_schedule").submit()
            else
              $('.' + day + time_string).toggleClass 'selected_work_day_time_slot'  
              $(".work_schedule" + $('.' + day + time_string)[0].classList[2].split()).click()
          return
        
      return
    
    $('.day').click (e) ->
      if $("#drawer_core_menu").children().length <11
        begin_time = new Date(2000, 1, 1, 8)
        end_time = new Date(2000, 1, 1, 21, 30)
        while begin_time.getTime() <= end_time.getTime()
          if $(this).text() != 'Thursday'
            if $('.' + $(this).text()[0] + begin_time.toString('hmmtt')).text() == '' and !$('.' + $(this).text()[0] + begin_time.toString('hmmtt')).hasClass("half_time_slot")
              if !$('.' + $(this).text()[0] + begin_time.toString('hmmtt')).hasClass('selected_work_day_time_slot')
                $('.' + $(this).text()[0] + begin_time.toString('hmmtt')).toggleClass 'selected_work_day_time_slot'            
                $("#work_schedule_work_days_time_id").val $('.' + $(this).text()[0] + begin_time.toString('hmmtt'))[0].classList[2].split("_")[1]
                $("#new_work_schedule").submit()
              else
                $('.' + $(this).text()[0] + begin_time.toString('hmmtt')).toggleClass 'selected_work_day_time_slot'  
                $(".work_schedule" + $('.' + $(this).text()[0] + begin_time.toString('hmmtt'))[0].classList[2].split()).click()
          else
            if $('.R' + begin_time.toString('hmmtt')).text() == '' and !$('.R' + begin_time.toString('hmmtt')).hasClass("half_time_slot")
              if !$('.R' + begin_time.toString('hmmtt')).hasClass 'selected_work_day_time_slot'
                $('.R' + begin_time.toString('hmmtt')).toggleClass 'selected_work_day_time_slot'            
                $("#work_schedule_work_days_time_id").val $('.R' + begin_time.toString('hmmtt'))[0].classList[2].split("_")[1]
                $("#new_work_schedule").submit()
              else
                $('.R' + begin_time.toString('hmmtt')).toggleClass 'selected_work_day_time_slot'  
                $(".work_schedule" + $('.R' + begin_time.toString('hmmtt'))[0].classList[2].split()).click()

          begin_time.setMinutes begin_time.getMinutes() + 30
      return


#    workScheduleInitializer = ->








#schedule approvals
    $("#submit_approval_paper_button").click ->
      console.log("email sent")
      $("#submit_approval_button")[0].click()
      return
      
    $("#advisor_approve_schedule_button").click ->
      $("#advisor_approve_schedule_link")[0].click()
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