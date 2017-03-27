$(document).on("turbolinks:load", function() {
  if ($(".course-select").length > 0 && typeof(courses) === "undefined") {
    fetchCourses($(".course-select"));
  } else if ($(".course-select").length > 0) {
    $.each($(".course-select"), function(element, index) {
      selectizeElement($(this), courses, subjects, $(this).data("selected"));
    });
  }
});

$(document).on("cocoon:after-insert", function(e, insertedItem) {
  element = $(insertedItem).find(".course-select");
  if (typeof(courses) === "undefined") {
    fetchCourses([element]);
  } else {
    selectizeElement(element, courses, subjects, element.data("selected"));
  }
});

$(document).on("click", ".selectize-control.course-select .remove-course", function() {
  var value = $(this).parent().data("value");

});

function fetchCourses(elements) {
  $.getJSON("/courses.json", function(data) {
    window.courses = data["courses"];
    window.subjects = data["subjects"];
    $.each(elements, function(element, index) {
      selectizeElement($(this), courses, subjects, $(this).data("selected"));
    });
  });
}

function selectizeElement(element, courses, subjects, selected_items) {
  element.selectize({
    options: courses,
    optgroups: subjects,
    valueField: "id",
    labelField: "title",
    searchField: ["id", "title"],
    maxItems: null,
    persist: false,
    items: selected_items,
    hideSelected: true,
    placeholder: "Select courses",
    selectOnTab: true,
    optgroupValueField: "subject",
    optgroupLabelField: "subject",
    optgroupField: "subject",
    dropdownContentClass: "mdc-multi-select mdl-list",
    inputClass: "selectize-input mdc-list",
    dropdownClass: "mdc-elevation--z2 selectize-dropdown multi course-select",
    render: {
      item: function(item, escape) {
        return "<div class='mdc-list-item item'>" +
            "<div class='mdc-list-item__text'>" +
              "<div class='mdc-list-item__text__primary'>" +
                item.title +
              "</div>" +
            "</div>" +
            "<i class='material-icons remove-course mdc-list-item__end-detail'>close</i>" +
          "</div>";
      },
      option: function(item, escape) {
        return "<div class='mdc-list-item'>" + escape(item.title) + "</div>";
      },
      optgroup: function(data, escape) {
        return "<div class='mdc-list-group'>" + data.html + "<div class='mdc-list-divider'></div></div>";
      }
    }
  });
}
