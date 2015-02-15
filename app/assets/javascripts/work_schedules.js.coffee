# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
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
        `var id_string`
        begin_time = new Date(2000, 1, 1, 8, 0o00)
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