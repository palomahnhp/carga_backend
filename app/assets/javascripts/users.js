function filterElement(edit) {
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
      url: "/users",
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
              $("#"+edit).append("<option value='" + name + "'>" + name + "</option>");
              break;
            case "position":
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