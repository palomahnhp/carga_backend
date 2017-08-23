function filterPosElement(edit) {
  if ($("#area option:selected").val() == "") {
    $("#direction").empty();
    $("#subdirection").empty();
    $("#unit").empty();
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
      case "unit":
        area = $("#area option:selected").val();
        dir = $("#direction option:selected").val();
        subdir = $("#subdirection option:selected").val();
        dataHash = {
          edit: edit,
          area: area,
          dir: dir,
          subdir: subdir
        }
        break;
    }
    $.ajax({
      url: "/positions",
      dataType: 'json',
      data: dataHash,
      success: function (data) {
        $("#"+edit).empty();
        data.forEach(function(element) {
          name = "";          
          switch(edit) {
            case "direction":
              name = element.dir_name;
              $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
              break;
            case "subdirection":
              name = element.subdir_name;
              $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
              break;
            case "unit":
              name = element.name;
              id = element.id;
              $("#"+edit).append("<option value='" + id + "'>" + name + "</option>");
              break;
          }
          $("#"+edit).trigger("change");
        });
        return {results: data};
      }
    });
  }
}

function filterPosOrgchart(area, dir, subdir) {
  dataHash = {
    op: "initEdit",
    area: area,
    dir: dir,
    subdir: subdir
  }
  $.ajax({
      url: "/positions",
      dataType: 'json',
      data: dataHash,
      async: false,
      success: function (data) {
        $("#direction").empty();
        $("#subdirection").empty();
        $("#unit").empty();
        data.dir.forEach(function(element) {
          name = element.dir_name;
          $("#direction").append("<option value='" + name + "'>" + name + "</option>");
        });
        data.subdir.forEach(function(element) {
          name = element.subdir_name;
          $("#subdirection").append("<option value='" + name + "'>" + name + "</option>");
        });
        data.unit.forEach(function(element) {
          name = element.name;
          id = element.id;
          $("#unit").append("<option value='" + id + "'>" + name + "</option>");
        });
        return {results: data};
      }
  });
}