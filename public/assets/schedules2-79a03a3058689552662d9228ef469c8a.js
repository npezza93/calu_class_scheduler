(function() {
  jQuery(function() {
    var front_validation;
    $(".offering_checkbox").click(function(e) {
      var id_string;
      id_string = "#schedule_new_actual_select option[value=" + e.currentTarget.id + "]";
      if ($("#schedule_new_actual_select")[0].options[$(id_string).index()].selected) {
        $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected = false;
      } else {
        $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected = true;
      }
      return $("#submit_schedule_changes")[0].click();
    });
    $('#media_query_schedule_new').on('core-media-change', function(e) {
      if (e.originalEvent.detail.matches === true) {
        $('.big_new_schedule_table').each(function(index, node) {
          var all_hidden;
          all_hidden = true;
          $(node).find('paper-checkbox').each(function(index2, node2) {
            if (!$(node2).parent().parent().attr('hidden')) {
              all_hidden = false;
              $(node2).parent().parent().next().removeAttr('hidden', '');
            } else {
              $(node2).parent().parent().next().attr('hidden', '');
            }
          });
          if (all_hidden) {
            if ($(node).find('core-icon').length === 0) {
              $(node).find('.new_schedule_headers').attr('hidden', '');
            } else {
              $(node).find('.new_schedule_headers').removeAttr('hidden', '');
              $(node).find('.remaining_credits_tr').css('border-bottom', 'none');
            }
          } else {
            $(node).find('.new_schedule_headers').attr('hidden', '');
            $('.new_schedule_credit_td').attr('hidden', '');
            $('.new_schedule_times_td').attr('hidden', '');
            $('.new_schedule_prof_td').attr('hidden', '');
            $('.new_schedule_nc_td').attr('hidden', '');
            $('.new_schedule_check_td').attr('rowspan', 2);
            $('.new_schedule_course_td').attr('rowspan', 2);
            $('.new_schedule_day_times_td').removeAttr('hidden');
            $(node).find('.remaining_credits_tr').css('border-bottom', '1px solid rgba(0, 0, 0, 0.12)');
          }
          $(node).find('.common_tr').attr('hidden', '');
        });
      } else {
        $('.resp_new_schedule_tr').attr('hidden', '');
        $('.new_schedule_credit_td').removeAttr('hidden', '');
        $('.new_schedule_times_td').removeAttr('hidden', '');
        $('.new_schedule_prof_td').removeAttr('hidden', '');
        $('.new_schedule_nc_td').removeAttr('hidden', '');
        $('.new_schedule_headers').removeAttr('hidden', '');
        $('.new_schedule_check_td').removeAttr('rowspan');
        $('.new_schedule_course_td').removeAttr('rowspan');
        $('.new_schedule_day_times_td').attr('hidden', '');
        $('.common_tr').removeAttr('hidden');
        $('.days_th').removeAttr('hidden', '');
        $('.time_th').removeAttr('hidden', '');
        $('.prof_th').removeAttr('hidden', '');
        $('.big_new_schedule_table').each(function(index, node) {
          var all_hidden;
          all_hidden = true;
          $(node).find('paper-checkbox').each(function(index2, node2) {
            if ($(node2).parent().parent().attr('hidden') !== 'hidden') {
              all_hidden = false;
            }
          });
          if (all_hidden) {
            if ($(node).find('core-icon').length === 0) {
              $(node).find('.new_schedule_headers').attr('hidden', '');
            } else {
              $(node).find('.common_tr').attr('hidden', '');
              $(node).find('.remaining_credits_tr').css('border-bottom', 'none');
            }
            $(node).find('.days_th').attr('hidden', '');
            $(node).find('.time_th').attr('hidden', '');
            $(node).find('.prof_th').attr('hidden', '');
          } else {
            $(node).find('.remaining_credits_tr').css('border-bottom', 'none');
          }
        });
      }
    });
    $(".offering_checkbox").click(function(e) {
      front_validation();
    });
    return front_validation = function() {
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
