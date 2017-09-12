function filterElement(edit, url) {
  if ($("#area option:selected").val() == "") {
    $("#direction").empty();
    $("#subdirection").empty();
    $("#unit").empty();
    $("#position").empty();
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
      case "position":
        area = $("#area option:selected").val();
        dir = $("#direction option:selected").val();
        subdir = $("#subdirection option:selected").val();
        unit = $("#unit option:selected").val();
        dataHash = {
          edit: edit,
          area: area,
          dir: dir,
          subdir: subdir,
          unit: unit
        }
        break;
    }
    $.ajax({
      url: url,
      dataType: 'json',
      data: dataHash,
      success: function (data) {
        $("#"+edit).empty();
        data.forEach(function(element) {
          name = "";          
          switch(edit) {
            case "direction":
              name = element.dir_name;
              if (name == "") {
                $("#"+edit).append("<option value='" + name + "'>[Sin dirección]</option>");
              } else {
                $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
              }
              break;
            case "subdirection":
              name = element.subdir_name;
              if (name == "") {
                $("#"+edit).append("<option value='" + name + "'>[Sin subdirección]</option>");
              } else {
                $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
              }
              break;
            case "unit":
              name = element.name;
              if (name == "") {
                $("#"+edit).append("<option value='" + name + "'>[Sin unidad]</option>");
              } else {
                $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
              }
              break;
            case "position":
              name = element.name;
              id = element.id;
              num = element.position_number;
              $("#"+edit).append("<option value='" + id + "'>" + num + " - " + name + "</option>");
              break;
          }
        });
        $("#"+edit).trigger("change");
        return {results: data};
      }
    });
  }
}

function filterOrgchart(area, dir, subdir, unit, url) {
  dataHash = {
    op: "initEdit",
    area: area,
    dir: dir,
    subdir: subdir,
    unit: unit
  }
  $.ajax({
      url: url,
      dataType: 'json',
      data: dataHash,
      async: false,
      success: function (data) {
        $("#direction").empty();
        $("#subdirection").empty();
        $("#unit").empty();
        $("#position").empty();
        data.dir.forEach(function(element) {
          name = element.dir_name;
          if (name == "") {
            $("#direction").append("<option value='" + name + "'>[Sin dirección]</option>");
          } else {
            $("#direction").append("<option value='" + name + "'>" + name + "</option>");
          }
        });
        data.subdir.forEach(function(element) {
          name = element.subdir_name;
          if (name == "") {
            $("#subdirection").append("<option value='" + name + "'>[Sin subdirección]</option>");
          } else {
            $("#subdirection").append("<option value='" + name + "'>" + name + "</option>");
          }
        });
        data.unit.forEach(function(element) {
          name = element.name;
          if (name == "") {
            $("#unit").append("<option value='" + name + "'>[Sin unidad]</option>");
          } else {
            $("#unit").append("<option value='" + name + "'>" + name + "</option>");
          }
        });
        data.pos.forEach(function(element) {
          name = element.name;
          id = element.id;
          num = element.position_number;
          $("#position").append("<option value='" + id + "'>" + num + " - " + name + "</option>");
        });
        return {results: data};
      }
  });
}