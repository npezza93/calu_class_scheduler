(function() {
  jQuery(function() {
    var front_validation2;
    $("#drawer_core_menu")[0].setAttribute("selected", "1");
    $('#transcript_ajax').on('core-response', function(e) {
      $('#section0').append(e.originalEvent.detail.response);
    });
    $('#new_schedule_ajax').on('core-response', function(e) {
      $('#temp_replace').append(e.originalEvent.detail.response);
      front_validation2();
    });
    $("#fab_new_schedule").click(function() {
      $("#new_schedule_modal")[0].toggle();
    });
    $("#media_query_schedule").on("core-media-change", function(e) {
      if (e.originalEvent.detail.matches === true) {
        $("#big_schedule_table")[0].setAttribute("hidden", "");
        $("#small_schedule_table")[0].removeAttribute("hidden", "");
        $(".small_schedule_course_title").removeAttr("hidden", "");
      } else {
        $("#big_schedule_table")[0].removeAttribute("hidden", "");
        $("#small_schedule_table")[0].setAttribute("hidden", "");
        $(".small_schedule_course_title").attr("hidden", "");
      }
    });
    $("#drawer_transcripts_item_baluga").click(function() {
      $("#baluga3")[0].selected = 0;
      $("core-drawer-panel")[0].closeDrawer();
    });
    $("#drawer_schedule_item_baluga").click(function() {
      $("#baluga3")[0].selected = 1;
      $("core-drawer-panel")[0].closeDrawer();
    });
    $("#drawer_new_schedule_item_baluga").click(function() {
      $("#baluga3")[0].selected = 2;
      $("core-drawer-panel")[0].closeDrawer();
    });
    $("#drawer_choose_minor_item_baluga").click(function() {
      $("#choose_minor_overlay")[0].toggle();
    });
    $("#drawer_change_password_item_baluga").click(function() {
      $("#change_password_overlay")[0].toggle();
    });
    $("#drawer_transcripts_item").click(function() {
      $("#user_transcripts_app_link")[0].click();
    });
    $("#drawer_schedule_item").click(function() {
      $("#user_schedules_app_link")[0].click();
    });
    $("#drawer_new_schedule_item").click(function() {
      $("#new_user_schedule_app_link")[0].click();
    });
    $("#drawer_logout_item").click(function() {
      $("#logout_button")[0].click();
    });
    $("#drawer_change_password_item").click(function() {
      $("#change_password_link")[0].click();
    });
    $("#drawer_new_major_item").click(function() {
      $("#new_major_link")[0].click();
    });
    $("#drawer_semesters_item").click(function() {
      $("#semesters_link")[0].click();
    });
    $("#drawer_offerings_item").click(function() {
      $("#offerings_link")[0].click();
    });
    $("#drawer_course_item").click(function() {
      $("#delete_course_link")[0].click();
    });
    $("#drawer_needed_course_item").click(function() {
      $("#needed_course_link")[0].click();
    });
    $("#drawer_users_item").click(function() {
      $("#users_link")[0].click();
    });
    $("#drawer_categories_item").click(function() {
      $("#categories_link")[0].click();
    });
    $("#change_password_overlay").on("core-overlay-close-completed", function(e) {
      $("#drawer_core_menu")[0].selected = ($("#baluga3")[0].selected);
      $("#user_password").parent().attr("error", "");
      $("#user_password").parent().attr("isInvalid", "false");
      $("#user_password_confirmation").parent().attr("error", "");
      $("#user_password_confirmation").parent().attr("isInvalid", "false");
      $("#user_password").val("");
      $("#user_password_confirmation").val("");
      $("#user_password").parent()[0].updateLabelVisibility();
      $("#user_password_confirmation").parent()[0].updateLabelVisibility();
    });
    $("#upload_transcript_button").click(function() {
      $("#upload_transcript_link")[0].click();
    });
    $('.next_day').click(function() {
      var page;
      page = $('#baluga4')[0].selected;
      if (page < 4) {
        $('#baluga4')[0].selected = $('#baluga4')[0].selected + 1;
      }
    });
    $('.prev_day').click(function() {
      var page;
      page = $('#baluga4')[0].selected;
      if (page > 0) {
        $('#baluga4')[0].selected = $('#baluga4')[0].selected - 1;
      }
    });
    $('.day_time_slot').click(function(e) {
      var id_string;
      if ($("#drawer_core_menu").children().length < 11) {
        if ($('.' + e.originalEvent.toElement.className.split(' ')[1]).text() === "" && !$('.' + e.originalEvent.toElement.className.split(' ')[1]).hasClass("half_time_slot")) {
          $('.' + e.originalEvent.toElement.className.split(' ')[1]).toggleClass('selected_work_day_time_slot');
          id_string = '#work_schedule_work_days_time_id option[value=' + e.originalEvent.toElement.id.substring(1) + ']';
          if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
          } else {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
          }
          $("#submit_work_schedule_button")[0].click();
        }
      }
    });
    $('.time_slot').click(function(e) {
      var id_string, time_string;
      if ($("#drawer_core_menu").children().length < 11) {
        time_string = $.trim(e.toElement.innerHTML.replace(/:/g, ''));
        if ($('.M' + time_string).text() === "" && !$('.M' + time_string).hasClass("half_time_slot")) {
          $('.M' + time_string).toggleClass('selected_work_day_time_slot');
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.M' + time_string)[0].id.substring(1) + ']';
          if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
          } else {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
          }
        }
        if ($('.T' + time_string).text() === "" && !$('.T' + time_string).hasClass("half_time_slot")) {
          $('.T' + time_string).toggleClass('selected_work_day_time_slot');
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.T' + time_string)[0].id.substring(1) + ']';
          if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
          } else {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
          }
        }
        if ($('.W' + time_string).text() === "" && !$('.W' + time_string).hasClass("half_time_slot")) {
          $('.W' + $.trim(e.toElement.innerHTML.replace(/:/g, ''))).toggleClass('selected_work_day_time_slot');
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.W' + time_string)[0].id.substring(1) + ']';
          if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
          } else {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
          }
        }
        if ($('.R' + time_string).text() === "" && !$('.R' + time_string).hasClass("half_time_slot")) {
          $('.R' + $.trim(e.toElement.innerHTML.replace(/:/g, ''))).toggleClass('selected_work_day_time_slot');
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.R' + time_string)[0].id.substring(1) + ']';
          if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
          } else {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
          }
        }
        if ($('.F' + time_string).text() === "" && !$('.F' + time_string).hasClass("half_time_slot")) {
          $('.F' + $.trim(e.toElement.innerHTML.replace(/:/g, ''))).toggleClass('selected_work_day_time_slot');
          id_string = '#work_schedule_work_days_time_id option[value=' + $('.F' + time_string)[0].id.substring(1) + ']';
          if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
          } else {
            $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
          }
        }
        $("#submit_work_schedule_button")[0].click();
      }
    });
    $('.day').click(function(e) {
      var begin_time, end_time, id_string;
      if ($("#drawer_core_menu").children().length < 11) {
        begin_time = new Date(2000, 1, 1, 8);
        end_time = new Date(2000, 1, 1, 21, 30);
        while (begin_time.getTime() <= end_time.getTime()) {
          if (e.toElement.innerHTML !== 'Thursday') {
            if ($('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).text() === '' && !$('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).hasClass("half_time_slot")) {
              $('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).toggleClass('selected_work_day_time_slot');
              id_string = '#work_schedule_work_days_time_id option[value=' + $('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt'))[0].id.substring(1) + ']';
              if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
              } else {
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
              }
            }
          } else {
            if ($('.R' + begin_time.toString('hmmtt')).text() === '' && !$('.' + e.toElement.innerHTML.charAt(0) + begin_time.toString('hmmtt')).hasClass("half_time_slot")) {
              $('.R' + begin_time.toString('hmmtt')).toggleClass('selected_work_day_time_slot');
              id_string = '#work_schedule_work_days_time_id option[value=' + $('.R' + begin_time.toString('hmmtt'))[0].id.substring(1) + ']';
              if ($('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected) {
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = false;
              } else {
                $('#work_schedule_work_days_time_id')[0].options[$(id_string).index()].selected = true;
              }
            }
          }
          begin_time.setMinutes(begin_time.getMinutes() + 30);
        }
        $("#submit_work_schedule_button")[0].click();
      }
    });
    $("#submit_approval_paper_button").click(function() {
      $("#submit_approval_button")[0].click();
    });
    $("#advisor_approve_schedule_button").click(function() {
      $("#advisor_approve_schedule_link")[0].click();
    });
    $(document).keydown(function(e) {
      var pg_selected;
      pg_selected = $('#baluga3')[0].selected;
      switch (e.which) {
        case 37:
          if (pg_selected !== 0) {
            $('#baluga3')[0].selected = pg_selected - 1;
            $('#drawer_core_menu')[0].setAttribute('selected', parseInt($('#drawer_core_menu')[0].selected) - 1);
          }
          break;
        case 39:
          if (pg_selected !== 2) {
            $('#baluga3')[0].selected = pg_selected + 1;
            $('#drawer_core_menu')[0].setAttribute('selected', parseInt($('#drawer_core_menu')[0].selected) + 1);
          }
          break;
        default:
          return;
      }
      e.preventDefault();
    });
    return front_validation2 = function() {
      var asel_opts, credit_count, disable, nsel_dates_array, nsel_opts, sel_dates_array, sel_opts;
      asel_opts = void 0;
      credit_count = void 0;
      disable = void 0;
      nsel_dates_array = void 0;
      nsel_opts = void 0;
      sel_dates_array = void 0;
      sel_opts = void 0;
      sel_opts = [];
      nsel_opts = [];
      asel_opts = [];
      credit_count = 0;
      sel_dates_array = [];
      nsel_dates_array = [];
      disable = [];
      $('#schedule_new_actual_select option:selected').each(function() {
        sel_opts.push($(this).attr('value'));
        asel_opts.push($(this).attr('value'));
      });
      $('#schedule_new_actual_select option:not(:selected)').each(function() {
        nsel_opts.push($(this).attr('value'));
        asel_opts.push($(this).attr('value'));
      });
      $.each(sel_opts, function(index, value) {
        var d, t;
        d = void 0;
        t = void 0;
        t = $('#' + value).parent().parent();
        credit_count += parseInt(t.find('.new_schedule_credit_td').text());
        if (!(t.find('.new_schedule_days_td').text() === "ONLINE" || t.find('.new_schedule_days_td').text() === "OFFSITE")) {
          d = [t.find('.new_schedule_days_td').text(), t.find('.new_schedule_times_td').text().split(' - ')[0], t.find('.new_schedule_times_td').text().split(' - ')[1], t.find('.new_schedule_course_td').text().split('-')[0]];
          if (d[1].split(' ')[1] === 'pm') {
            d[1] = new Date(2000, 1, 1, d[1].split(':')[0], d[1].split(':')[1].split(' ')[0]);
            d[1].setHours(d[1].getHours() + 12);
          } else {
            d[1] = new Date(2000, 1, 1, d[1].split(':')[0], d[1].split(':')[1].split(' ')[0]);
          }
          if (d[2].split(' ')[1] === 'pm') {
            d[2] = new Date(2000, 1, 1, d[2].split(':')[0], d[2].split(':')[1].split(' ')[0]);
            d[2].setHours(d[2].getHours() + 12);
          } else {
            d[2] = new Date(2000, 1, 1, d[2].split(':')[0], d[2].split(':')[1].split(' ')[0]);
          }
        } else {
          d = [t.find('.new_schedule_days_td').text(), -1, -1, -1];
        }
        sel_dates_array.push(d);
      });
      $.each(nsel_opts, function(index, value) {
        var d, t;
        d = void 0;
        t = void 0;
        t = $('#' + value).parent().parent();
        if (credit_count + parseInt(t.find('.new_schedule_credit_td').text()) > 18) {
          disable.push(value);
        }
        if (!(t.find('.new_schedule_days_td').text() === "ONLINE" || t.find('.new_schedule_days_td').text() === "OFFSITE")) {
          d = [t.find('.new_schedule_days_td').text(), t.find('.new_schedule_times_td').text().split(' - ')[0], t.find('.new_schedule_times_td').text().split(' - ')[1], t.find('.new_schedule_course_td').text().split('-')[0]];
          if (d[1].split(' ')[1] === 'pm') {
            d[1] = new Date(2000, 1, 1, d[1].split(':')[0], d[1].split(':')[1].split(' ')[0]);
            d[1].setHours(d[1].getHours() + 12);
          } else {
            d[1] = new Date(2000, 1, 1, d[1].split(':')[0], d[1].split(':')[1].split(' ')[0]);
          }
          if (d[2].split(' ')[1] === 'pm') {
            d[2] = new Date(2000, 1, 1, d[2].split(':')[0], d[2].split(':')[1].split(' ')[0]);
            d[2].setHours(d[2].getHours() + 12);
          } else {
            d[2] = new Date(2000, 1, 1, d[2].split(':')[0], d[2].split(':')[1].split(' ')[0]);
          }
        } else {
          d = [t.find('.new_schedule_days_td').text(), -1, -1, -1];
        }
        nsel_dates_array.push(d);
      });
      $.each(nsel_opts, function(index1, value1) {
        $.each(sel_opts, function(index2, value2) {
          if (!(sel_dates_array[index2][0].indexOf(nsel_dates_array[index1][0]) === -1)) {
            if (sel_dates_array[index2][1] <= nsel_dates_array[index1][2] && nsel_dates_array[index1][1] <= sel_dates_array[index2][2]) {
              disable.push(value1);
            }
          }
          if (sel_dates_array[index2][3] === nsel_dates_array[index1][3]) {
            disable.push(value1);
          }
        });
      });
      disable = jQuery.unique(disable);
      asel_opts = $(asel_opts).not(disable).get();
      $.each(disable, function(index, value) {
        $('.' + value).attr('disabled', '');
      });
      $.each(asel_opts, function(index, value) {
        $('.' + value).removeAttr('disabled', '');
      });
    };
  });

}).call(this);
