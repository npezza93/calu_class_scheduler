(function() {
  jQuery(function() {
    var front_validation, signedUpForInitializer, workScheduleInitializer;
    $(document).ready(function() {
      $("#drawer-menu")[0].setAttribute("selected", "1");
      signedUpForInitializer();
      if ($("#placement_test_overlay").length) {
        $("#placement_test_overlay")[0].toggle();
      }
      $(".delete-work-schedule-link").each(function() {
        $("._" + $(this)[0].classList[0].split("_")[2]).addClass('selected_work_day_time_slot');
      });
      workScheduleInitializer();
      $('#schedule_new_actual_select option:selected').each(function() {
        return front_validation($('#' + $(this).attr('value')));
      });
    });
    $(document).ajaxComplete(function() {
      var error;
      try {
        signedUpForInitializer();
      } catch (_error) {
        error = _error;
        console.log;
      }
      workScheduleInitializer();
      $('#schedule_new_actual_select option:selected').each(function() {
        return front_validation($('#' + $(this).attr('value')));
      });
      $('#remove-work-schedule-div').children().each(function() {
        if (!$("." + $(this).text().split(":").join("")).hasClass('selected_work_day_time_slot')) {
          return $("." + $(this).text().split(":").join("")).toggleClass('selected_work_day_time_slot');
        }
      });
    });
    signedUpForInitializer = function() {
      var signed_up_for_dates, signedup_for;
      signed_up_for_dates = [];
      signedup_for = $.makeArray($("#advisor_quick_user_courses").children().children());
      signedup_for.shift();
      signedup_for.pop();
      if (signedup_for.length > 0) {
        $.each(signedup_for, function() {
          var course, days;
          course = $(this);
          days = $($(this)).children()[0].getAttribute("days");
          if (days !== "OFFSITE" && days !== "ONLINE") {
            $.each(days.split(""), function() {
              var end_time, flag, index, name, start_time;
              start_time = Date.parse($(course).children()[0].getAttribute("times").split(" - ")[0]);
              end_time = Date.parse($(course).children()[0].getAttribute("times").split(" - ")[1]);
              flag = false;
              index = 0;
              if ((end_time.getMinutes() - 15 === 0) || (end_time.getMinutes() - 15 === 30)) {
                flag = true;
                end_time.setMinutes(end_time.getMinutes() - 15);
              }
              while (start_time.getTime() < end_time.getTime()) {
                if (index === 0) {
                  name = $(course.children()[0]).text().split("-");
                  $("." + $(this)[0] + start_time.toString("hmmtt")).html(name[0] + "<span class='small_schedule_course_title'>: " + name[1].split(": ")[1] + "</span>");
                } else if (index === 1) {
                  name = $(course.children()[2]).text();
                  $("." + $(this)[0] + start_time.toString("hmmtt")).html(name);
                }
                $("." + $(this)[0] + start_time.toString("hmmtt")).addClass(" selected_class");
                index += 1;
                start_time.setMinutes(start_time.getMinutes() + 30);
              }
              if (flag) {
                $("." + $(this)[0] + start_time.toString("hmmtt")).addClass(" half_time_slot");
              }
            });
          }
        });
      }
      if ($("#media_query_schedule")[0].queryMatches) {
        $("#big_schedule_table")[0].setAttribute("hidden", "");
        $("#small_schedule_table")[0].removeAttribute("hidden", "");
        $(".small_schedule_course_title").removeAttr("hidden", "");
      } else {
        $("#big_schedule_table")[0].removeAttribute("hidden", "");
        $("#small_schedule_table")[0].setAttribute("hidden", "");
        $(".small_schedule_course_title").attr("hidden", "");
      }
    };
    $("#drawer_transcripts_item_baluga").click(function() {
      $("#baluga3").attr("exit-animation", "slide-right-animation");
      $("#baluga3").attr("entry-animation", "slide-from-left-animation");
      $("#baluga3")[0].selected = 0;
    });
    $("#drawer_schedule_item_baluga").click(function() {
      if ($("#baluga3")[0].selected === 0) {
        $("#baluga3").attr("exit-animation", "slide-left-animation");
        $("#baluga3").attr("entry-animation", "slide-from-right-animation");
      } else {
        $("#baluga3").attr("exit-animation", "slide-right-animation");
        $("#baluga3").attr("entry-animation", "slide-from-left-animation");
      }
      $("#baluga3")[0].selected = 1;
    });
    $("#drawer_new_schedule_item_baluga").click(function() {
      $("#baluga3").attr("exit-animation", "slide-left-animation");
      $("#baluga3").attr("entry-animation", "slide-from-right-animation");
      $("#baluga3")[0].selected = 2;
    });
    $('body').on('click', '#submit_taken_class_material', function() {
      if ($("#transcript_grade_c option:selected").val() === "") {
        $("#transcript_grade_error_text").fadeIn();
        $("#transcript_grade_c").addClass("dropdown-error");
      } else {
        $("#transcript_grade_error_text").fadeOut();
        $("#transcript_grade_c").removeClass("dropdown-error");
        $("#new_transcript").submit();
      }
    });
    $('body').on('change', '#transcript_course_id', function() {
      if ($("#transcript_course_id option:selected").val() !== "") {
        $("#transcript_course_id").css("color", "#212121");
      } else {
        $("#transcript_course_id").css("color", "#757575");
      }
    });
    $('body').on('change', '#transcript_grade_c', function() {
      if ($("#transcript_grade_c option:selected").val() !== "") {
        $("#transcript_grade_c").css("color", "#212121");
      } else {
        $("#transcript_grade_c").css("color", "#757575");
      }
    });
    $('#upload_transcript_button').click(function() {
      if ($("#textarea").val() !== "" || $("#textarea").val().split("\n")[1].toLowerCase() === "california university degreeworks") {
        $("#Transcript").val($("#textarea").val());
        $('#whole_screen_uploader').slideDown();
        $("#upload-transcript-dialog").find("form").submit();
        $('#upload-transcript-dialog')[0].toggle();
        $("#transcript-text-area").removeAttr('invalid', '');
      } else {
        if ($("#textarea").val() !== "") {
          $("#transcript-text-area").find('paper-input-error').html("Please Paste Your Transcript!");
        } else {
          $("#transcript-text-area").find('paper-input-error').html("Please Upload Correct Text!");
        }
        $("#transcript-text-area").attr('invalid', "");
      }
    });
    $("#fab_new_schedule").click(function() {
      $("#upload-transcript-dialog")[0].toggle();
    });
    $("#pt_yes_no").on('change', function() {
      if ($("#pt_yes_no")[0].selected === "yes") {
        $('#pt_scrollable').slideUp();
      } else {
        $('#pt_scrollable').slideDown();
      }
      $("#user_pt_a_1")[0].checked = true;
      $("#user_pt_b_1")[0].checked = true;
      $("#user_pt_c_1")[0].checked = true;
      $("#user_pt_d_1")[0].checked = true;
    });
    $("#pt_a_group").on('change', function(e) {
      if (e.originalEvent.target.getAttribute("name") === "passed") {
        $("#user_pt_a_1")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "failed") {
        $("#user_pt_a_2")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "na") {
        $("#user_pt_a")[0].checked = true;
      }
    });
    $("#pt_b_group").on('change', function(e) {
      if (e.originalEvent.target.getAttribute("name") === "passed") {
        $("#user_pt_b_1")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "failed") {
        $("#user_pt_b_2")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "na") {
        $("#user_pt_b")[0].checked = true;
      }
    });
    $("#pt_c_group").on('change', function(e) {
      if (e.originalEvent.target.getAttribute("name") === "passed") {
        $("#user_pt_c_1")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "failed") {
        $("#user_pt_c_2")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "na") {
        $("#user_pt_c")[0].checked = true;
      }
    });
    $("#pt_d_group").on('change', function(e) {
      if (e.originalEvent.target.getAttribute("name") === "passed79") {
        $("#user_pt_d_1")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "failed") {
        $("#user_pt_d_2")[0].checked = true;
      } else if (e.originalEvent.target.getAttribute("name") === "na") {
        $("#user_pt_d")[0].checked = true;
      }
      if (e.originalEvent.target.getAttribute("name") === "passed10") {
        $("#user_pt_d_3")[0].checked = true;
      }
    });
    $("#submit-pt").click(function() {
      $(".pt_form").submit();
      $("#placement_test_overlay")[0].toggle();
    });
    $("#drawer_change_password_item_baluga").click(function() {
      $("#change_password_overlay")[0].toggle();
    });
    $("#change_password_overlay").on("iron-overlay-closed", function(e) {
      $("#drawer-menu")[0].selected = $("#baluga3")[0].selected;
      $("#new_user_password").removeAttr('invalid', "");
      $("#new_user_password_confirm").removeAttr('invalid', "");
      $("#user_password").val("");
      $("#user_password_confirmation").val("");
    });
    $("#submit_student_settings").click(function() {
      $(".student_settings_form").submit();
    });
    $(window).resize(function() {
      if ($("#media_query_schedule")[0].queryMatches) {
        $("#big_schedule_table")[0].setAttribute("hidden", "");
        $("#small_schedule_table")[0].removeAttribute("hidden", "");
        $(".small_schedule_course_title").removeAttr("hidden", "");
      } else {
        $("#big_schedule_table")[0].removeAttribute("hidden", "");
        $("#small_schedule_table")[0].setAttribute("hidden", "");
        $(".small_schedule_course_title").attr("hidden", "");
      }
    });
    $('body').on('click', '.next_day', function() {
      if (parseInt($('#baluga4')[0].selected) < 4) {
        $("#baluga4").attr("entry-animation", "slide-from-right-animation");
        $("#baluga4").attr("exit-animation", "slide-left-animation");
        $('#baluga4')[0].selected = parseInt($('#baluga4')[0].selected) + 1;
      }
    });
    $('body').on('click', '.prev_day', function() {
      if (parseInt($('#baluga4')[0].selected) > 0) {
        $("#baluga4").attr("entry-animation", "slide-from-left-animation");
        $("#baluga4").attr("exit-animation", "slide-right-animation");
        $('#baluga4')[0].selected = parseInt($('#baluga4')[0].selected) - 1;
      }
    });
    $('body').on('click', '.offering_checkbox', function(e) {
      var id_string;
      id_string = "#schedule_new_actual_select option[value=" + e.currentTarget.id + "]";
      if ($("#schedule_new_actual_select")[0].options[$(id_string).index()].selected) {
        $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected = false;
      } else {
        $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected = true;
      }
      $("#new_schedule").submit();
      front_validation($(this));
    });
    $('body').on('click', 'paper-item.course_offering', function() {
      $("iron-collapse." + $(this)[0].classList[0])[0].toggle();
      if ($("iron-collapse." + $(this)[0].classList[0])[0].opened) {
        if (!$(this).hasClass("inactive")) {
          $("paper-item." + $(this)[0].classList[0]).find('iron-icon').attr("icon", "expand-less");
          $(this)[0].classList.add("active");
        }
      } else {
        $("paper-item." + $(this)[0].classList[0]).find('iron-icon').attr("icon", "expand-more");
        $(this)[0].classList.remove("active");
      }
    });
    front_validation = function(nodeSelected) {
      var credit_count, disable, nsel_dates_array, nsel_opts, selected;
      selected = [nodeSelected.parent().parent().attr("days"), Date.parse(nodeSelected.parent().parent().attr("start-time")), Date.parse(nodeSelected.parent().parent().attr("end-time")), nodeSelected.parent().parent().attr("course"), nodeSelected[0].classList[1]];
      nsel_opts = [];
      credit_count = parseInt($("#total-creds").text());
      nsel_dates_array = [];
      disable = [];
      $('#schedule_new_actual_select option:not(:selected)').each(function() {
        nsel_opts.push($(this).attr('value'));
      });
      $.each(nsel_opts, function(index, value) {
        var t;
        t = $('#' + value).parent().parent();
        if ((credit_count + parseInt(t.attr("credits"))) > 18) {
          disable.push(value);
        } else {
          if (t.attr("days") === "ONLINE" && t.attr("days") === "OFFSITE" && t.attr("course") === selected[3]) {
            disable.push(value);
          } else if (t.attr("days") !== "ONLINE" && t.attr("days") !== "OFFSITE" && selected[0] !== "ONLINE" && selected[0] !== "OFFSITE" && selected[0].indexOf(t.attr("days")) !== -1) {
            if (selected[1] <= Date.parse(t.attr("end-time")) && Date.parse(t.attr("start-time")) <= selected[2]) {
              disable.push(value);
            }
          }
          if (selected[3] === t.attr("course")) {
            disable.push(value);
          }
        }
      });
      disable = $.unique(disable);
      if (!nodeSelected[0].checked) {
        disable.splice(disable.indexOf(selected[4]), 1);
      }
      $.each(disable, function(index, value) {
        if (!nodeSelected[0].checked) {
          $('.' + value).removeAttr('disabled');
        } else {
          $('.' + value).attr('disabled', '');
        }
      });
    };
    $('body').on('click', '.day_time_slot', function() {
      if ($("#drawer_core_menu").children().length < 11) {
        if ($(this).text() === "" && !$(this).hasClass("half_time_slot")) {
          if (!$(this).hasClass('selected_work_day_time_slot')) {
            $(this).toggleClass('selected_work_day_time_slot');
            $("#work_schedule_work_days_time_id").val($(this)[0].classList[2].split("_")[1]);
            $("#new_work_schedule").submit();
          } else {
            $(this).toggleClass('selected_work_day_time_slot');
            $(".work_schedule" + $(this)[0].classList[2].split()).click();
          }
        }
      }
    });
    $('body').on('click', '.time_slot', function() {
      var time_string;
      if ($("#drawer_core_menu").children().length < 11) {
        time_string = $(this).text().replace(/:/g, '');
        $.each(["M", "T", "W", "R", "F"], function(index, day) {
          if ($('.' + day + time_string).text() === "" && !$('.' + day + time_string).hasClass("half_time_slot")) {
            if (!$('.' + day + time_string).hasClass('selected_work_day_time_slot')) {
              $('.' + day + time_string).toggleClass('selected_work_day_time_slot');
              $("#work_schedule_work_days_time_id").val($('.' + day + time_string)[0].classList[2].split("_")[1]);
              $("#new_work_schedule").submit();
            } else {
              $('.' + day + time_string).toggleClass('selected_work_day_time_slot');
              $(".work_schedule" + $('.' + day + time_string)[0].classList[2].split()).click();
            }
          }
        });
      }
    });
    $('body').on('click', '.day', function() {
      var begin_time, end_time;
      if ($("#drawer_core_menu").children().length < 11) {
        begin_time = new Date(2000, 1, 1, 8);
        end_time = new Date(2000, 1, 1, 21, 30);
        while (begin_time.getTime() <= end_time.getTime()) {
          if ($(this).text() !== 'Thursday') {
            if ($('.' + $(this).text()[0] + begin_time.toString('hmmtt')).text() === '' && !$('.' + $(this).text()[0] + begin_time.toString('hmmtt')).hasClass("half_time_slot")) {
              if (!$('.' + $(this).text()[0] + begin_time.toString('hmmtt')).hasClass('selected_work_day_time_slot')) {
                $('.' + $(this).text()[0] + begin_time.toString('hmmtt')).toggleClass('selected_work_day_time_slot');
                $("#work_schedule_work_days_time_id").val($('.' + $(this).text()[0] + begin_time.toString('hmmtt'))[0].classList[2].split("_")[1]);
                $("#new_work_schedule").submit();
              } else {
                $('.' + $(this).text()[0] + begin_time.toString('hmmtt')).toggleClass('selected_work_day_time_slot');
                $(".work_schedule" + $('.' + $(this).text()[0] + begin_time.toString('hmmtt'))[0].classList[2].split()).click();
              }
            }
          } else {
            if ($('.R' + begin_time.toString('hmmtt')).text() === '' && !$('.R' + begin_time.toString('hmmtt')).hasClass("half_time_slot")) {
              if (!$('.R' + begin_time.toString('hmmtt')).hasClass('selected_work_day_time_slot')) {
                $('.R' + begin_time.toString('hmmtt')).toggleClass('selected_work_day_time_slot');
                $("#work_schedule_work_days_time_id").val($('.R' + begin_time.toString('hmmtt'))[0].classList[2].split("_")[1]);
                $("#new_work_schedule").submit();
              } else {
                $('.R' + begin_time.toString('hmmtt')).toggleClass('selected_work_day_time_slot');
                $(".work_schedule" + $('.R' + begin_time.toString('hmmtt'))[0].classList[2].split()).click();
              }
            }
          }
          begin_time.setMinutes(begin_time.getMinutes() + 30);
        }
      }
    });
    workScheduleInitializer = function() {
      var disable, nsel_dates_array, nsel_opts, work_dates_array;
      work_dates_array = [];
      nsel_opts = [];
      nsel_dates_array = [];
      disable = [];
      $('#schedule_new_actual_select option:not(:selected)').each(function() {
        nsel_opts.push($(this).attr('value'));
      });
      $.each(nsel_opts, function(index, value) {
        var d, t;
        t = $('#' + value).parent().parent();
        d = [t.attr("days"), Date.parse(t.attr("start-time")), Date.parse(t.attr("end-time"))];
        nsel_dates_array.push(d);
      });
      $('#remove-work-schedule-div').children().each(function() {
        var d;
        d = [$(this).text()[0], Date.parse($(this).text().substr(1)), Date.parse($(this).text().substr(1))];
        d[2].setMinutes(d[2].getMinutes() + 30);
        work_dates_array.push(d);
      });
      $.each(nsel_opts, function(index1, value1) {
        $.each(work_dates_array, function(index2, value2) {
          if (!(nsel_dates_array[index1][0].indexOf(value2[0]) === -1)) {
            if (value2[1] < nsel_dates_array[index1][2] && nsel_dates_array[index1][1] < value2[2]) {
              disable.push(value1);
            }
          }
        });
      });
      disable = $.unique(disable);
      $.each(disable, function(index, value) {
        $('.' + value).parent().parent().attr('hidden', '');
      });
      $('.category-items.incomplete-category').each(function() {
        var all_hidden, categoryNode;
        all_hidden = true;
        categoryNode = $(this);
        categoryNode.find('.offering-div').each(function() {
          var count, offeringCourseNode;
          count = $(this).find('paper-icon-item').length;
          offeringCourseNode = $(this);
          offeringCourseNode.find('paper-icon-item').each(function() {
            if ($(this).attr('hidden')) {
              count--;
            }
          });
          if (count === 0) {
            $(offeringCourseNode.children()[0])[0].classList.add('inactive');
          } else {
            all_hidden = false;
          }
        });
        if (all_hidden) {
          $(categoryNode.children()[1]).removeAttr('hidden');
        }
      });
    };
    $("#submit_approval_paper_button").click(function() {
      $("#submit_approval_button")[0].click();
    });
    return $("#advisor_approve_schedule_button").click(function() {
      $("#advisor_approve_schedule_link")[0].click();
    });
  });

}).call(this);
