function filterUnElement(edit) {
  if ($("#area option:selected").val() == "") {
    $("#direction").empty();
    $("#subdirection").empty();
  } else {
    switch(edit) {
      case "direction":
        area = $("#area option:selected").val();
        dataHash = {
          edit: edit,
          area: area
        }
        break;
      case "subdirection":
        area = $("#area option:selected").val();
        dir = $("#direction option:selected").val();
        dataHash = {
          edit: edit,
          area: area,
          dir: dir
        }
        break;
    }
    $.ajax({
      url: "/units",
      dataType: 'json',
      data: dataHash,
      success: function (data) {
        $("#"+edit).empty();
        data.forEach(function(element) {
          name = "";          
          switch(edit) {
            case "direction":
              name = element.dir_name;
              break;
            case "subdirection":
              name = element.subdir_name;
              break;
          }
          $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
        });
        $("#"+edit).trigger("change");
        return {results: data};
      }
    });
  }
}

function filterUnOrgchart(area, dir) {
  dataHash = {
    op_edit: "initEdit",
    area: area,
    dir: dir
  }
  $.ajax({
      url: "/units",
      dataType: 'json',
      data: dataHash,
      async: false,
      success: function (data) {
        $("#direction").empty();
        $("#subdirection").empty();
        data.dir.forEach(function(element) {
          name = element.dir_name;
          $("#direction").append("<option value='" + name + "'>" + name + "</option>");
        });
        data.subdir.forEach(function(element) {
          name = element.subdir_name;
          $("#subdirection").append("<option value='" + name + "'>" + name + "</option>");
        });
        return {results: data};
      }
  });
}